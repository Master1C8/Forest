"""Evidence-derived progress view of the existing locale queue; no model requests.

The percentage is a versioned completion index, not elapsed work, cost or a
probability of release. Acceptance gates remain separate from partial credit.
"""
from collections import defaultdict
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
POLICY = 'localization/completion/progress-policy.json'
LOCALES = ('zh', 'es', 'es-419', 'pt-BR', 'ja', 'de')
PASS = {'pass', 'clean'}


def hashed(data):
    return hashlib.sha256(data).hexdigest()


class Evidence:
    def __init__(self, root):
        self.root, self.pins, self.errors = Path(root).resolve(), {}, []
        self.cache = {}
        self.recovered_prefixes = []

    def path(self, name):
        p = Path(name)
        p = p if p.is_absolute() else self.root / p
        if not p.resolve().is_relative_to(self.root.resolve()):
            raise ValueError(f'Outside project evidence: {name}')
        return p.resolve()

    def read(self, name, expected=None):
        p = self.path(name)
        if p not in self.cache:
            before = p.stat()
            data = p.read_bytes()
            after = p.stat()
            if (before.st_ino, before.st_size, before.st_mtime_ns) != (after.st_ino, after.st_size, after.st_mtime_ns):
                raise ValueError(f'Evidence changed during read: {p}')
            self.cache[p] = data
            self.pins[str(p.relative_to(self.root))] = hashed(data)
        data = self.cache[p]
        if expected is not None and hashed(data) != expected:
            raise ValueError(f'Stale evidence: {p}')
        return data

    def json(self, name, expected=None):
        return json.loads(self.read(name, expected))

    def rows(self, name, expected=None):
        try:
            data = self.read(name, expected)
        except ValueError:
            if not expected or not str(name).endswith('.jsonl'):
                raise
            # Reuse an old packet only when its entire original byte stream is
            # proven to be an exact prefix. New appended rows receive no credit.
            data = self.read(name)
            digest, length, matched = hashlib.sha256(), 0, False
            for line in data.splitlines(keepends=True):
                digest.update(line)
                length += len(line)
                if digest.hexdigest() == expected:
                    matched = True
                    break
            if not matched:
                raise ValueError(f'Stale evidence: {self.path(name)}')
            self.recovered_prefixes.append(dict(path=str(self.path(name).relative_to(self.root)),
                                                originalSha256=expected, originalBytes=length,
                                                currentSha256=hashed(data)))
            data = data[:length]
        if str(name).endswith('.jsonl'):
            return [json.loads(line) for line in data.splitlines() if line.strip()]
        return self.records(json.loads(data))

    @staticmethod
    def records(value):
        """Extract actual wording records, never fabricate a target or verdict."""
        if isinstance(value, list):
            for item in value:
                yield from Evidence.records(item)
        elif isinstance(value, dict):
            if isinstance(value.get('id'), str) and isinstance(value.get('source'), str):
                yield value
            else:
                for item in value.values():
                    if isinstance(item, (list, dict)):
                        yield from Evidence.records(item)

    def row_list(self, name, expected=None):
        return list(self.rows(name, expected))

    def pin_file(self, name, expected):
        """Verify saved binary bytes without retaining game files in RAM."""
        from locale_queue import sha
        p=self.path(name);before=p.stat();actual=sha(p);after=p.stat()
        if (before.st_ino,before.st_size,before.st_mtime_ns)!=(after.st_ino,after.st_size,after.st_mtime_ns):
            raise ValueError(f'Evidence changed during read: {p}')
        if actual!=expected:raise ValueError(f'Stale evidence: {p}')
        self.pins[str(p.relative_to(self.root))]=actual
        return actual

    def stable(self):
        from locale_queue import sha
        for name, expected in self.pins.items():
            if sha(self.root / name) != expected:
                raise ValueError(f'Input changed before report publication: {name}')


def version(row):
    if not isinstance(row.get('id'), str):
        return None
    source, target = row.get('source'), row.get('target')
    s = hashed(source.encode()) if isinstance(source, str) else row.get('sourceSha256')
    t = hashed(target.encode()) if isinstance(target, str) else row.get('targetSha256')
    if not s or not t:
        return None
    if row.get('sourceSha256', s) != s or row.get('targetSha256', t) != t:
        raise ValueError(f'Incorrect wording hash: {row["id"]}')
    return row['id'], s, t


def linguistic_pass(row):
    return (row.get('verdict') in PASS and not row.get('notLinguisticCoverage')
            and not row.get('contextOnly')
            and row.get('reviewed') is not False
            and row.get('coverageRole') not in ('context', 'source-context', 'context-only', 'technical-preservation', 'held-source')
            and row.get('reviewRole') not in ('context', 'source-context', 'context-only', 'technical-preservation', 'held-source'))


def nonlinguistic(row):
    return (row.get('notLinguisticCoverage') or row.get('contextOnly')
        or row.get('coverageRole') in ('context','source-context','context-only','technical-preservation','held-source')
        or row.get('reviewRole') in ('context','source-context','context-only','technical-preservation','held-source')
        or row.get('verdict') in ('technical-preservation','context-only-preserve')
        or row.get('reviewKind') in ('new-data-binding-only','technical-review','resource-binding','resource-contract'))


def declared_refs(value):
    """Only explicit hash bindings inside a document; no directory searches."""
    if isinstance(value, dict):
        name = value.get('archive') or value.get('path')
        if isinstance(name, str) and re.fullmatch(r'[0-9a-f]{64}', str(value.get('sha256', ''))):
            yield name, value['sha256']
        for key, item in value.items():
            if isinstance(item, dict) and re.fullmatch(r'[0-9a-f]{64}', str(item.get('sha256', ''))) and '/' in key:
                yield item.get('archive', key), item['sha256']
            elif isinstance(item, str) and '/' in key and re.fullmatch(r'[0-9a-f]{64}', item):
                yield key, item
            if isinstance(item, (list, dict)):
                yield from declared_refs(item)
    elif isinstance(value, list):
        for item in value:
            yield from declared_refs(item)


def proof_refs(ev, value, max_depth=2):
    refs, pending = {}, [(name, expected, ev.root) for name, expected in declared_refs(value)]
    visited = set()
    for depth in range(max_depth + 1):
        next_level = []
        for name, expected, base in pending:
            path = Path(name)
            if not path.is_absolute():
                project_relative = path.parts and path.parts[0] in ('outputs', 'localization', 'tools', 'assets', 'dist')
                path = (ev.root if project_relative else base) / path
            path = path.resolve()
            if not path.is_relative_to(ev.root.resolve()):
                continue  # External canonical content is outside this read-only view.
            name = str(path.relative_to(ev.root))
            if (name, expected) in visited:
                continue
            visited.add((name, expected))
            refs[name] = expected
            if depth < max_depth and name.endswith('.json') and re.search(r'(manifest|index|binding|applicability|editorial)', Path(name).name):
                try:
                    next_level.extend((n, h, path.parent) for n, h in declared_refs(ev.json(name, expected)))
                except (OSError, ValueError) as exc:
                    ev.errors.append(str(exc))
        pending = next_level
    return refs


def retained_reviews(ev, locale):
    baseline = ev.json(f'outputs/locale-assets-20261026/{locale}/workflow-v2/reconcile-saved-evidence/result.json')
    refs = proof_refs(ev, baseline, max_depth=3)
    # The owning editorial file is commonly named de-current.json (etc.), so
    # generic filename-based manifest traversal does not open it. Follow this
    # explicit, hash-bound handoff rather than silently dropping its reviews.
    owning = baseline.get('editorialApplicability', {}).get('owningManifest')
    if owning:
        name = str(ev.path(owning).relative_to(ev.root))
        if name not in refs:
            raise ValueError(f'Unpinned owning editorial manifest: {owning}')
        manifest = ev.json(name, refs[name])
        if manifest.get('locale') != locale:
            raise ValueError(f'Foreign owning editorial manifest: {owning}')
        for field, path in [('sourceGlossarySha256', 'localization/glossary/en.json'),
                            ('localeGlossarySha256', f'localization/glossary/{locale}.json'),
                            ('sourceSha256', 'localization/source/dialogue-candidates.jsonl')]:
            expected = manifest.get(field)
            if not re.fullmatch(r'[0-9a-f]{64}', str(expected or '')):
                raise ValueError(f'Missing editorial dependency binding: {field}')
            ev.read(path, expected)
        refs.update(proof_refs(ev, manifest, max_depth=3))
    for name, expected in refs.items():
        if not name.endswith('.jsonl') or not re.search(r'(review|judgment)', Path(name).name):
            continue
        # Another language's judgment must never enter even for equal strings.
        if not any(s in '/' + name for s in (f'/{locale}/', f'/{locale}-cycle-', f'/{locale}-assets/')):
            continue
        try:
            yield from ev.row_list(name, expected)
        except (OSError, ValueError) as exc:
            ev.errors.append(str(exc))


def initial_reviews(ev, locale):
    """Read real initial semantic rows from completed owning job phases."""
    job = ev.json(f'outputs/editorial-20261027/{locale}/job.json')
    for phase in job.get('phases', []):
        result = phase.get('result', {})
        if phase.get('exitCode') != 0 or result.get('outcome') != 'batch-reviewed':
            continue
        expected = result.get('reviewsSha256')
        if not expected:
            continue
        path = Path(phase['directory']) / 'reviews.jsonl'
        try:
            yield from ev.row_list(path, expected)
        except (OSError, ValueError) as exc:
            ev.errors.append(str(exc))


def expected_ids(ev, family):
    mode, path = family['mode'], family.get('source')
    if mode == 'unresolved':
        return None
    raw = ev.json(path) if not path.endswith('.jsonl') else ev.row_list(path)
    if mode == 'units':
        raw = raw['units']
    elif mode == 'targets-keys':
        return set(raw['targets'])
    elif mode == 'members':
        return {member for row in raw for member in row['members']}
    elif mode == 'assigned':
        raw = [row['assigned'] for row in raw]
    elif mode == 'cases':
        return {row['id'] for row in raw['cases']}
    elif mode == 'haiku':
        # Nine literal fragments; the 27 assembled outcomes remain separate
        # editorial/runtime requirements and are never 27 copies of these passes.
        return {id_ for fixture in raw['fixtures'] for id_ in fixture['ids']}
    if family.get('roles'):
        raw = [row for row in raw if row.get('currentRole') in family['roles']]
    if isinstance(raw, dict):
        raw = [raw]
    key = family.get('idKey', 'id')
    ids = [row[key] for row in raw]
    if not ids or len(ids) != len(set(ids)):
        raise ValueError(f'Empty/duplicate source IDs for {family["id"]}')
    return set(ids)


def known_wording(row, locale):
    return (isinstance(row.get('source'), str) and isinstance(row.get('target'), str)
            and bool(row['target'].strip()) and row.get('locale', locale) == locale
            and not nonlinguistic(row)
            and not str(row.get('status', '')).startswith(('preserved-', 'held-', 'needs-source')))


def collect_locale(ev, policy, locale, families, preservation=None):
    current, decisions = {}, {}
    preserved={};resource_refs={};preservation=preservation or {};stage_claims=[]
    source = {r['id']: r for r in ev.row_list('localization/source/dialogue-candidates.jsonl')}
    dialogue = ev.row_list(f'localization/{locale}-assets/dialogue.{locale}.jsonl')
    dialogue_versions={r['id']:version(r) for r in dialogue}
    if len(dialogue) != len({r['id'] for r in dialogue}) or set(r['id'] for r in dialogue) != set(source):
        raise ValueError(f'{locale}: dialogue identity/denominator mismatch')
    for row in dialogue:
        if row['source'] != source[row['id']]['source']:
            raise ValueError(f'{locale}: dialogue source differs: {row["id"]}')
        key = version(row)
        if (preservation.get(row['id'])==key[1] and row['target']==row['source']):
            preserved[row['id']]=key
        elif known_wording(row, locale):
            current[row['id']] = key
    ui = ev.row_list(f'localization/supplemental-ui/20261027/{locale}.jsonl')
    ui_source = {r['id']: r for r in ev.json('localization/supplemental-ui/20261027/source-catalog.json')['units']}
    if len(ui) != len({r['id'] for r in ui}) or {r['id'] for r in ui} != set(ui_source):
        raise ValueError(f'{locale}: UI identity/denominator mismatch')
    for row in ui:
        if row['source'] != ui_source[row['id']]['source']:
            raise ValueError(f'{locale}: UI source differs: {row["id"]}')
        if known_wording(row, locale):
            current[row['id']] = version(row)
    for row in initial_reviews(ev, locale):
        key = version(row)
        if key and not nonlinguistic(row):
            decisions[key] = linguistic_pass(row)
    for row in retained_reviews(ev, locale):
        key = version(row)
        if key and not nonlinguistic(row):
            decisions[key] = linguistic_pass(row)
    status_path = f'outputs/locale-assets-20261026/{locale}/workflow-v3-completion-20261030/status.json'
    lane = ev.json(status_path)
    valid_phases = []
    for phase in lane.get('phases', []):
        if not phase.get('resultSha256'):
            continue
        directory = Path(phase['phase'])
        try:
            result = ev.json(directory / 'result.json', phase['resultSha256'])
            if result.get('outcome') not in ('continue', 'blocked', 'complete', 'static-complete'):
                continue
            task = ev.json(directory / 'task.json')['task']
            if task.get('taskClass') == 'technical' or phase['kind'] == 'technical':
                continue
            refs = proof_refs(ev, result.get('evidence', []))
            resource_refs.update(refs)
            if isinstance(result.get('stageAcceptance'),dict):stage_claims.append(result['stageAcceptance'])
            reviews=result.get('reviews')
            review_name=str(ev.path(reviews).relative_to(ev.root)) if isinstance(reviews,str) else None
            judgments=(ev.row_list(review_name,refs[review_name])
                if phase['kind']=='review' and review_name in refs else [])
            nonlinguistic_ids={r['id'] for r in judgments if nonlinguistic(r)}
            primary, assigned, packet = {}, {}, task.get('reviewPacket')
            if packet and task.get('reviewPacketSha256'):
                for row in ev.row_list(packet, task['reviewPacketSha256']):
                    key=version(row)
                    if key:assigned[row['id']]=key
                    if known_wording(row, locale) and row['id'] not in nonlinguistic_ids:
                        primary[row['id']] = version(row)
            # Completed author phases publish exact primary IDs and pinned wording files.
            progress = result.get('progress') or {}
            next_task = result.get('nextTask') or {}
            authored = set(progress.get('unitIds', [])) if progress.get('kind') == 'authored' else set()
            proposed = next_task.get('reviewPacket')
            if proposed:
                proposed_name=str(ev.path(proposed).relative_to(ev.root))
                expected = next_task.get('reviewPacketSha256') or refs.get(proposed_name)
                if expected:
                    for row in ev.row_list(proposed, expected):
                        if known_wording(row, locale) and (not authored or row['id'] in authored):
                            primary[row['id']] = version(row)
            if authored and not primary:
                candidates = defaultdict(set)
                for path, expected in refs.items():
                    if not path.endswith(('.jsonl', '.json')) or not re.search(r'(packet|authored|target|wording)', Path(path).name):
                        continue
                    # Only this lane's own evidence may define saved wording.
                    if not (f'/{locale}/' in '/' + path or f'/{locale}-assets/' in '/' + path):
                        continue
                    for row in ev.row_list(path, expected):
                        if row.get('id') in authored and known_wording(row, locale):
                            candidates[row['id']].add(version(row))
                for id_, versions in candidates.items():
                    if len(versions) == 1:
                        primary[id_] = next(iter(versions))
                    else:
                        ev.errors.append(f'{locale} phase {phase["number"]}: ambiguous authored versions: {id_}')
            # Dialogue candidates cannot replace the actual applied canonical dialogue.
            for id_, key in primary.items():
                if id_ not in source:
                    current[id_] = key
                    if preserved.get(id_)!=key:preserved.pop(id_,None)
            if phase['kind'] == 'review' and review_name in refs:
                for row in judgments:
                    key = version(row)
                    if (key and assigned.get(row['id'])==key and key[1]==key[2]
                            and (row['id'] not in source or dialogue_versions[row['id']]==key)
                            and row.get('reviewed') is True and row.get('notLinguisticCoverage') is True
                            and row.get('targetEdited') is False
                            and row.get('verdict') in ('context-only-preserve','technical-preservation')
                            and row.get('sourceDisposition') in ('preserved-detached-source','preserve-as-baseline','accepted-baseline-preservation')):
                        # An affirmative primary disposition is resolved work,
                        # not a translated/reviewed phrase or a context extra.
                        preserved[row['id']]=key;current.pop(row['id'],None)
                    if key and not nonlinguistic(row) and (primary.get(row['id']) == key or assigned.get(row['id']) == key):
                        decisions[key] = linguistic_pass(row)
                        if not decisions[key] and preserved.get(row['id'])==key:
                            preserved.pop(row['id'],None)
            valid_phases.append(phase['number'])
        except (OSError, ValueError, KeyError, TypeError) as exc:
            ev.errors.append(f'{locale} phase {phase["number"]}: {exc}')
    rows = []
    for family in policy['families']:
        ids = families[family['id']]
        if ids is None:
            rows.append(dict(id=family['id'], expected=None, drafted=0, reviewed=0, status='unverified-adapter'))
            continue
        drafted = {id_ for id_ in ids if id_ in current}
        reviewed = {id_ for id_ in drafted if decisions.get(current[id_]) is True}
        retained=set(preserved)&ids
        rows.append(dict(id=family['id'], expected=len(ids), drafted=len(drafted), reviewed=len(reviewed),
                         preserved=len(retained),resolved=len(drafted|retained),reviewResolved=len(reviewed|retained),
                         resolvedPercent=round(100*len(drafted|retained)/len(ids),2),
                         reviewResolvedPercent=round(100*len(reviewed|retained)/len(ids),2),
                         wordingVersionSha256=hashed(json.dumps(sorted([current[id_] for id_ in drafted]+[preserved[id_] for id_ in retained])).encode()),
                         status='measured', draftPercent=round(100 * len(drafted) / len(ids), 2),
                         reviewPercent=round(100 * len(reviewed) / len(ids), 2)))
    last = lane.get('phases', [{}])[-1]
    running = False
    if lane['status'] == 'running' and last.get('pid'):
        try:
            os.kill(last['pid'], 0)
            running = True
        except ProcessLookupError:
            pass
    blocker = lane.get('reason')
    if lane['status'] == 'held-request-outcome':
        events = Path(last['phase']) / 'events.jsonl'
        if events.is_file():
            with events.open('rb') as stream:
                stream.seek(max(0, events.stat().st_size - 8192))
                tail = stream.read().decode(errors='replace')
            if 'Selected model is at capacity' in tail:
                blocker = 'model-at-capacity'
    return dict(locale=locale, laneStatus=lane['status'], lastCompletedPhase=max(valid_phases, default=None),
                workerAlive=running,
                lastResult=dict(path=str(ev.path(Path(last['phase'])/'result.json').relative_to(ev.root)),
                                sha256=last['resultSha256']) if last.get('resultSha256') else None,
                lastPhase=lane.get('phases', [{}])[-1].get('number'),
                lastActivityAt=lane.get('phases', [{}])[-1].get('startedAt'),
                blocker=blocker, families=rows,
                _acceptedVersions={**{id_:key for id_,key in current.items() if decisions.get(key) is True},**preserved},
                _resourceRefs=resource_refs,_familyIds=families,_stageClaims=stage_claims)


def accepted_stages(ev, policy, row, scope_hash, source_gate):
    accepted = {'scope'}
    if (source_gate['commonSourceAccepted'] is True and source_gate['translationEntryAllowed'] is True
            or source_gate.get('acceptedBaselineReuse') is True):
        accepted.add('source')
    paths=[f'localization/completion/acceptance/{row["locale"]}.json',
           f'localization/{row["locale"]}-assets/completion/acceptance.json']
    claims=list(row.pop('_stageClaims',[]))
    claims.extend(ev.json(path) for path in paths if (ev.root/path).is_file())
    for data in claims:
        accepted.update(_accepted_claim(ev,policy,row,scope_hash,data))
    return accepted


def _accepted_claim(ev,policy,row,scope_hash,data):
    accepted=set()
    wording_hash = hashed(json.dumps([(f['id'], f.get('wordingVersionSha256')) for f in row['families']], sort_keys=True).encode())
    if (data.get('locale') != row['locale'] or data.get('policyRevision') != policy['revision']
            or data.get('sourceScopeSha256') != scope_hash or data.get('wordingVersionSha256') != wording_hash):
        ev.errors.append(f'{row["locale"]}: stale final-stage acceptance binding')
        return accepted
    for stage, proof in data.get('stages', {}).items():
        if stage not in policy['proofKinds'] or proof.get('status') != 'passed':
            continue
        if proof.get('proofKind') != policy['proofKinds'][stage]:
            ev.errors.append(f'{row["locale"]}: unsuitable proof kind for {stage}')
            continue
        refs = list(declared_refs(proof.get('evidence', [])))
        if not refs:
            ev.errors.append(f'{row["locale"]}: no final evidence for {stage}')
            continue
        try:
            for name, expected in refs:
                ev.read(name, expected)
        except (OSError, ValueError) as exc:
            ev.errors.append(str(exc))
            continue
        if stage == 'translate-edit' and any(f['expected'] is None or f.get('resolved',f['drafted']) != f['expected'] for f in row['families']):
            continue
        accepted.add(stage)
    return accepted


def calculate_score(policy, families, accepted_stages=None):
    accepted_stages = accepted_stages or set()
    indexed = {r['id']: r for r in families}
    components = []
    for component in policy['components']:
        earned, unverified = 0.0, 0.0
        if component['id'] in ('resource-bindings','resource-saved') and 'resources' in accepted_stages:
            earned=component['points']
        elif component.get('families'):
            ids = component['families']
            share = component['points'] / len(ids)
            for id_ in ids:
                row = indexed[id_]
                if row['expected'] is None:
                    unverified += share
                else:
                    if row['expected'] <= 0 or not 0 <= row[component['numerator']] <= row['expected']:
                        raise ValueError(f'Invalid coverage bounds: {id_}')
                    earned += share * row[component['numerator']] / row['expected']
        elif component['id'] in accepted_stages:
            earned = component['points']
        components.append(dict(id=component['id'], stage=component['stage'], maximum=component['points'],
                               earned=round(earned, 6), unverified=round(unverified, 6)))
    total = sum(c['earned'] for c in components)
    if not 0 <= total <= 100.000001:
        raise ValueError('Invalid score bounds')
    gates_passed = set(policy['requiredGates']).issubset(accepted_stages)
    if total >= 99.999999 and not gates_passed:
        raise ValueError('Policy permits 100 points without all acceptance gates')
    return dict(percent=round(total, 2), unverifiedPoints=round(sum(c['unverified'] for c in components), 2),
                components=components, ready=total >= 99.999999 and gates_passed)


def report(root=ROOT, locale=None):
    from locale_progress_evidence import baseline,resources
    ev = Evidence(root)
    policy = ev.json(POLICY)
    if sum(c['points'] for c in policy['components']) != 100:
        raise ValueError('Policy weights must total exactly 100')
    for path, expected in policy['sourcePins'].items():
        ev.read(path, expected)
    owner,preservation=baseline(ev,policy)
    process_context=ev.json(policy['processContext']) if policy.get('processContext') else None
    families = {family['id']: expected_ids(ev, family) for family in policy['families']}
    source_gate = ev.json('localization/source/shared-source-completion-20261028/admission-v1/manifest.json')
    if owner:
        dependencies=dict(sharedBaseAccepted=True,russianOwnerAcceptance=owner,
            scope='Reuse of the exact owner-accepted Russian behavior; no target language/native acceptance.')
        source_gate=dict(source_gate,acceptedBaselineReuse=True)
    else:
        from locale_dependencies import reconcile
        dependencies=reconcile(ev)
    scope_hash = hashed(json.dumps(policy['sourcePins'], sort_keys=True).encode())
    rows = []
    for code in ([locale] if locale else LOCALES):
        if code=='ru' and owner:
            rows.append(dict(locale='ru',percent=100.0,releaseReady=False,deliveryAccepted=True,
                acceptanceBasis='direct-owner-accepted-reference',laneStatus='owner-accepted',workerAlive=False,
                ownerStatement=owner['statement'],evidence=owner['artifact'],families=[],components=[],
                boundary='Accepted Russian scope; historic unrun flags retained, publication/release not inferred.'))
            continue
        if code not in LOCALES:
            raise ValueError(f'Unsupported progress locale: {code}')
        row = collect_locale(ev, policy, code, families,preservation)
        saved=resources(ev,policy,row) if owner else False
        if not owner:
            for key in ('_acceptedVersions','_resourceRefs','_familyIds'):row.pop(key,None)
        accepted = accepted_stages(ev, policy, row, scope_hash, source_gate)
        if saved:accepted.add('resource-saved')
        row.update(calculate_score(policy, row['families'], accepted))
        row['gates'] = {stage: ('passed' if stage in accepted else 'not-accepted') for stage in policy['requiredGates']}
        row['wholeGameSourceAccepted'] = source_gate['commonSourceAccepted']
        row['sharedRussianBaseAccepted'] = dependencies['sharedBaseAccepted']
        if owner:dependency_state=None
        else:
            from locale_dependencies import current_lane_state
            dependency_state=current_lane_state(row,dependencies)
        if dependency_state is not None:
            row['historicalBlocker']=row['blocker']
            row['dependencyState']=dependency_state
            row['blocker']='; '.join(dependency_state['remaining'])
        row['releaseReady'] = row.pop('ready') and (bool(owner) or source_gate['commonSourceAccepted'])
        rows.append(row)
    ev.stable()
    return dict(schemaVersion=1, measuredAt=datetime.now(timezone.utc).isoformat(), revision=policy['revision'],
                meaning=policy['meaning'], sourceScopeSha256=scope_hash,
                policyRebase=policy.get('rebasedFrom'),
                calculatorSha256=hashed(Path(__file__).read_bytes()+Path(__file__).with_name('locale_progress_evidence.py').read_bytes()),
                locales=rows, sharedDependencies=dependencies,
                processRevision=process_context.get('revision') if process_context else None,
                referenceBenchmark=dict(locale='ru',percent=100.0,accepted=True,authority=policy['ownerBaseline']) if owner else None,
                evidencePins=ev.pins, warnings=list(dict.fromkeys(ev.errors)),
                recoveredExactPacketPrefixes=ev.recovered_prefixes,
                unknownWholeGameInventory=not source_gate['commonSourceAccepted'], modelRequestsStarted=0)


def table(data):
    names = dict(zh='Китайский', es='Испанский', **{'es-419': 'Латиноамериканский испанский', 'pt-BR': 'Бразильский португальский'}, ja='Японский', de='Немецкий',ru='Русский — принятый эталон')
    states = {'running': 'Работает', 'blocked': 'Заблокирован', 'held-request-outcome': 'Остановлен: запрос требует сверки',
              'held-dispatch-policy': 'Историческая приостановка очереди','owner-accepted':'Принят владельцем'}
    lines = ['| Язык | Общий индекс готовности | Готова к выпуску | Состояние |',
             '|---|---:|---|---|']
    for row in data['locales']:
        state = states.get(row['laneStatus'], row['laneStatus'])
        if row.get('dependencyState'):
            state = ('Ожидает переноса сборки и CJK-шрифта' if row['locale']=='zh' else
                     'Ожидает переноса готовой сборки на язык')
        if row.get('blocker') == 'model-at-capacity':
            state = 'Остановлен: модель недоступна'
        elif row['laneStatus'] == 'running' and not row['workerAlive']:
            state = 'Процесс завершился; очередь ещё не сверена'
        lines.append(f'| {names[row["locale"]]} | {row["percent"]:.1f}% | {"Да" if row["releaseReady"] else "Нет"} | {state} |')
    return '\n'.join(lines)


def snapshot(data, root=ROOT):
    """Publish a derived history file, then its pointer. This is not a transaction.

    Failure before pointer replacement leaves the old current view intact and an
    extra complete history snapshot; it never alters a queue or execution input.
    """
    directory = Path(root) / 'outputs/locale-assets-20261026/progress'
    directory.mkdir(parents=True, exist_ok=True)
    pointer = directory / 'current.json'
    if pointer.is_file():
        previous = json.loads(pointer.read_text())
        same_policy = all(previous.get(k) == data.get(k) for k in ('revision', 'sourceScopeSha256', 'calculatorSha256'))
        old = {r['locale']: r for r in previous['locales']}
        for row in data['locales']:
            before = old.get(row['locale'])
            if before:
                row['sincePrevious'] = dict(comparable=same_policy, previousAt=previous['measuredAt'],
                                            previousPercent=before['percent'],
                                            pointDelta=round(row['percent'] - before['percent'], 2) if same_policy else None,
                                            reason='same-calculation-and-scope' if same_policy else 'calculation-or-scope-revised')
    path = directory / (data['measuredAt'].replace(':', '').replace('+', '_') + '.json')
    raw = (json.dumps(data, ensure_ascii=False, indent=2) + '\n').encode()
    with path.open('xb') as stream:
        stream.write(raw)
        stream.flush()
        os.fsync(stream.fileno())
    tmp = directory / (path.stem + '.current.tmp')
    try:
        with tmp.open('xb') as stream:
            stream.write(raw)
            stream.flush()
            os.fsync(stream.fileno())
        os.replace(tmp, pointer)
    finally:
        if tmp.exists():
            tmp.unlink()
    return path
