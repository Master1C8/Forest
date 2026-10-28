#!/usr/bin/env python3
"""Phase149 finite immutable corpus/role join; no fonts, runtime or model calls."""
import argparse
import copy
import hashlib
import json
from pathlib import Path
import unicodedata

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
ROLE = 'localization/fonts/role-requirements-20261028'
SOURCE = 'localization/source/shared-source-completion-20261028/admission-v1'
DELIVERY = 'localization/editorial-delivery'
LOCALES = ['ru', 'zh', 'es', 'es-419', 'pt-BR', 'ja', 'de']
DIALOGUE = 'localization/font-checks/dialogue-20261027-02.json'
INTERFACE = 'localization/font-checks/supplemental-30-20261028.json'
RU = 'outputs/editorial-20261027/final-ru-v1/ru'
ZH = 'outputs/editorial-20261027/final-repairs-v1/zh'
DE = 'outputs/editorial-20261027/final-de-v1/de'


def require(ok, reason):
    if not ok:
        raise ValueError(reason)


def sha(data):
    return hashlib.sha256(data).hexdigest()


def encoded(value):
    return (json.dumps(value, ensure_ascii=False, indent=2) + '\n').encode()


def compact(value):
    return json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(',', ':')).encode()


def allowed(path):
    p = Path(path)
    require(not p.is_absolute() and '..' not in p.parts, 'relative-project-input-required')
    require(not (p.parts[0] == 'localization' and any(x.endswith('-assets') for x in p.parts)),
            'live-overlay-prohibited')
    require(p.name not in ['events.jsonl', 'last-message.txt'], 'conversation-or-log-prohibited')
    return ROOT / p


def read(path):
    # Reject repeated JSON keys before a dict could silently discard identities.
    def pairs(items):
        d = {}
        for k, v in items:
            require(k not in d, 'duplicate-json-key')
            d[k] = v
        return d
    return json.loads(allowed(path).read_text(), object_pairs_hook=pairs)


def rows(path):
    return [json.loads(s) for s in allowed(path).read_text().splitlines() if s]


def unique(values):
    d = {}
    for r in values:
        require(r['id'] not in d, 'duplicate-stable-id')
        d[r['id']] = r
    return d


def fingerprint(path):
    data = allowed(path).read_bytes()
    return {'sha256': sha(data), 'bytes': len(data)}


def verify(path, pin):
    actual = fingerprint(path)
    require(actual['sha256'] == (pin if isinstance(pin, str) else pin['sha256']), 'file-hash-mismatch:' + path)
    if isinstance(pin, dict) and 'bytes' in pin:
        require(actual['bytes'] == pin['bytes'], 'file-size-mismatch:' + path)
    return actual


def forms(texts):
    texts = list(texts)
    result = {}
    for form in ['raw', 'NFC', 'NFD']:
        values = texts if form == 'raw' else [unicodedata.normalize(form, s) for s in texts]
        result[form] = sorted({ord(c) for s in values for c in s if not unicodedata.category(c).startswith('C')})
    return {'forms': result, 'rawNfcNfdCodepoints': sorted(set().union(*map(set, result.values()))),
            'controls': sorted({ord(c) for s in texts for c in s if unicodedata.category(c).startswith('C')})}


def equal_source(source, target, source_bound=True):
    require(set(source) == set(target), 'source-target-id-coverage')
    for sid, t in target.items():
        require(isinstance(t['target'], str), 'target-string-required')
        if source_bound:
            require(t['source'] == source[sid]['source'], 'source-value-mismatch')
            require(t['sourceSha256'] == sha(t['source'].encode()), 'embedded-source-hash-mismatch')
            require(t['targetSha256'] == sha(t['target'].encode()), 'embedded-target-hash-mismatch')
            require(t['occurrences'] == source[sid]['occurrences'], 'source-occurrence-mismatch')


def report_applicability(requirements, universe):
    result = {}
    for form, required in requirements['forms'].items():
        outside = sorted(set(required) - set(universe))
        result[form] = {'status': 'inapplicable-outside-saved-universe' if outside else 'within-saved-universe-only',
                        'outsideCodepoints': outside, 'missingCount': None,
                        'boundary': 'Applicability only; no new missing/present font claim or exact role allocation.'}
    return result


def discover():
    """One bounded observation, not a polling loop. Mutable job metadata is not input text."""
    observed = {'schemaVersion': 1, 'phase': '0149-work', 'model': 'gpt-6.1-sol',
                'reasoning': 'high', 'provider': 'openai', 'ignoreUserConfig': True,
                'runtimeModelEvidence': 'Current process33366 command line; no prior conversation read.',
                'manifestPaths': sorted(str(p.relative_to(ROOT)) for p in (ROOT / DELIVERY).glob('*/*/*manifest.json')),
                'missingDeliveries': {}}
    for loc in ['es', 'es-419', 'pt-BR', 'ja']:
        path = (f'outputs/locale-assets-20261026/{loc}/job.json' if loc == 'ja'
                else f'outputs/editorial-20261027/{loc}/job.json')
        d = read(path)
        observed['missingDeliveries'][loc] = {
            'owningJob': path, 'observedJobFingerprint': fingerprint(path),
            'statusAtObservation': d['status'],
            'reviewedIdsReportedByOwner': d.get('reviewedIds'),
            'currentManifestAbsentAtObservation': not (ROOT / DELIVERY / (loc + '-current.json')).exists(),
            'cycle02ArchiveAbsentAtObservation': not (ROOT / DELIVERY / (loc + '-cycle-02')).exists(),
            'status': 'missing-immutable-editorial-delivery',
            'boundary': 'Observed once, not process-liveness or semantic acceptance; do not wait or stop any lane.'}
    return observed


def derive(observation):
    pins = {}

    def take(path, expected=None):
        pins[path] = verify(path, expected) if expected else fingerprint(path)
        return read(path)

    role = take(ROLE + '/reconciliation.json')
    take(ROLE + '/ADAPTER.md') if False else None
    pins[ROLE + '/ADAPTER.md'] = fingerprint(ROLE + '/ADAPTER.md')
    inherited = take(ROLE + '/input-pins.json')
    # Metadata selector sources and saved reports only. Do not reopen fonts/resources.
    for path in [SOURCE + '/' + s for s in ['manifest.json', 'old935-selector-bindings.json',
                 'direct-context.jsonl', 'serialized-inventory.jsonl', 'bgdatabase-inventory.jsonl',
                 'compiled-wording-source.jsonl']]:
        pins[path] = verify(path, inherited[path])
    for path in [DIALOGUE, INTERFACE, 'localization/font-checks/cjk-candidates-20261027-01.json']:
        pins[path] = verify(path, role['reports'][path])
    saved = read(DIALOGUE)
    interface = read(INTERFACE)
    cjk = read('localization/font-checks/cjk-candidates-20261027-01.json')
    source_path = 'localization/source/dialogue-candidates.jsonl'
    pins[source_path] = verify(source_path, saved['sourceFamilySha256'])
    source = unique(rows(source_path))
    require(len(source) == 12246 and sum(len(r['occurrences']) for r in source.values()) == 24492,
            'dialogue-family-count')
    old = unique(read(SOURCE + '/old935-selector-bindings.json'))
    require(len(old) == 935 and all(r['valueMatches'] for r in old.values()), 'old935-selector-integrity')
    by_source = {}
    for sid, r in old.items():
        by_source.setdefault(r['sourceId'], []).append(sid)
    serial = unique(rows(SOURCE + '/serialized-inventory.jsonl'))
    direct = unique(rows(SOURCE + '/direct-context.jsonl'))
    dynamic = unique(rows(SOURCE + '/bgdatabase-inventory.jsonl') + rows(SOURCE + '/compiled-wording-source.jsonl'))
    profiles = role['requirementProfiles']
    require(len(profiles) == 10 and len(role['selectedComponents']) == 109, 'profile-component-count')
    profile_sources = {}
    for name, p in profiles.items():
        selected = p['storedSelectors'] + p['dynamicSelectors']
        unique(selected)
        source_rows = []
        for r in selected:
            stored = r in p['storedSelectors']
            canonical = serial[r['id']] if stored else dynamic[r['id']]
            require(canonical['sourceValueSha256'] == r['sourceValueSha256'], 'profile-source-hash')
            if stored:
                require(sha(compact(direct[r['id']]['value'])) == r['sourceValueSha256'], 'stored-source-value')
            elif 'source' in r and r.get('valueState') != 'absent':
                require(sha(compact(r['source'])) == r['sourceValueSha256'], 'dynamic-source-value')
            mapped = by_source.get(r['id'], [])
            for uid in mapped:
                require(old[uid]['sourceValueSha256'] == r['sourceValueSha256'], 'mapped-source-hash')
            source_rows.append({'sourceId': r['id'], 'sourceValueSha256': r['sourceValueSha256'],
                                'selectorKind': 'stored' if stored else 'dynamic',
                                'valueState': 'stored-placeholder-or-label' if stored else r.get('valueState', 'nonempty' if r.get('source') else 'empty'),
                                'old935TargetIds': mapped})
        projected = [uid for uid in old if old[uid]['sourceId'] in {r['id'] for r in selected}]
        require(projected == p['old935Projection']['ids'], 'profile-projection-mismatch')
        profile_sources[name] = {
            'componentIds': p['componentIds'], 'consumerPredicate': p['consumerPredicate'],
            'remainingSourcePredicate': p['remainingSourcePredicate'], 'selectors': source_rows,
            'storedSourceOmissions': [r['sourceId'] for r in source_rows if r['selectorKind'] == 'stored' and not r['old935TargetIds']],
            'dynamicSourceOmissions': [r['sourceId'] for r in source_rows if r['selectorKind'] == 'dynamic' and not r['old935TargetIds']],
            'nonemptyDynamicSourceOmissions': p['old935Projection']['nonemptyDynamicSourcesWithoutOld935Targets'],
            'absentDynamicStates': p['old935Projection']['absentDynamicStates'],
            'boundTargetIds': projected, 'finalSourceAccepted': False}
    require(len(profile_sources['inventory-tickerText']['nonemptyDynamicSourceOmissions']) == 50, 'description-omission-count')
    require(len(profile_sources['inventory-itemTitleText']['nonemptyDynamicSourceOmissions']) == 2, 'title-empty-cell-omission-count')

    deliveries = {}
    join_files = {}
    for loc in LOCALES:
        if loc not in ['ru', 'zh', 'de']:
            deliveries[loc] = dict(observation['missingDeliveries'][loc], savedTargetHash=saved['corpora'][loc]['sha256'],
                                   savedTargetHashApplicability='unverifiable', targetIds=None, sourceJoin='unverifiable')
            continue
        current_path = f'{DELIVERY}/{loc}-current.json'
        current = take(current_path)
        current_target = current.get('currentCorpus', current.get('target'))
        source_hash = current.get('sourceSha256', current.get('source', {}).get('sha256'))
        require(source_hash == pins[source_path]['sha256'], 'delivery-source-version')
        cycle_path = f'{DELIVERY}/{loc}-cycle-02/cycle/manifest.json'
        cycle = take(cycle_path)
        archive = current['evidence']
        if loc in ['ru', 'de']:
            verify(cycle_path, archive[cycle_path])
        else:
            idx_path = DELIVERY + '/zh-cycle-02/archive-index.json'
            idx = take(idx_path, archive['indexSha256'])
            matches = [v for v in idx['files'].values() if v['archive'] == cycle_path]
            require(len(matches) == 1, 'zh-cycle-archive-link')
            verify(cycle_path, matches[0])
        if loc == 'ru':
            manifest_path = DELIVERY + '/ru-cycle-02/author/delivery-manifest.json'
            manifest = take(manifest_path, archive[manifest_path])
            require(manifest['cycleManifestSha256'] == pins[cycle_path]['sha256'], 'ru-cycle-link')
            artifact = RU + '/after-target-map.json'
            target_map = take(artifact, manifest['files'][artifact])
            require(all(isinstance(t, str) for t in target_map.values()), 'target-map-value-type')
            target = {sid: {'id': sid, 'target': t} for sid, t in target_map.items()}
            equal_source(source, target, source_bound=False)
            before = RU + '/before/localization/ru-assets/dialogue.ru.jsonl'
            pins[before] = verify(before, manifest['files'][before])
            equal_source(source, unique(rows(before)))
            receipt_path = DELIVERY + '/ru-cycle-02/author/application-verification.json'
            receipt = take(receipt_path, archive[receipt_path])
            require(receipt['repeatDerivedSha256'] == current_target['sha256'] and receipt['untouchedTargetsAndMetadataUnchanged'],
                    'ru-final-receipt-link')
            require(manifest['canonicalFinalHashes'][str(ROOT / current_target['path'])] == current_target['sha256'], 'ru-corpus-link')
            source_join = 'exact-ID target-only map; source fingerprint and retained-metadata receipt; source fields not embedded in final map'
            representation = 'immutable-target-map; complete final corpus bytes unavailable here'
        else:
            manifest_path = (DELIVERY + '/de-cycle-02/author/output-manifest.json' if loc == 'de'
                             else ZH + '/output-manifest.json')
            manifest = take(manifest_path, archive[manifest_path] if loc == 'de' else None)
            if loc == 'de':
                require(manifest['finalCycleManifest']['sha256'] == pins[cycle_path]['sha256'], 'de-cycle-link')
            else:
                # This owning immutable author manifest is outside the smaller durable archive.
                # Bind its cycle and full corpus hash to the archived current record.
                require(manifest['files']['cycle-02/manifest.json']['sha256'] == pins[cycle_path]['sha256'], 'zh-cycle-link')
            artifact = (DE + '/after-overlay.jsonl' if loc == 'de' else ZH + '/targets-after.jsonl')
            pins[artifact] = verify(artifact, manifest['files'][Path(artifact).name])
            require(pins[artifact]['sha256'] == current_target['sha256'], 'final-corpus-hash-link')
            target = unique(rows(artifact))
            equal_source(source, target)
            source_join = 'all12246 embedded sources/hashes/exact occurrence lists match canonical source by stable ID'
            representation = 'immutable-full-corpus'
        requirements = forms(r['target'] for r in target.values())
        universe = list(map(ord, saved['corpora'][loc]['characters']))
        report_reuse = report_applicability(requirements, universe)
        candidate_report = cjk['locales'].get(loc)
        if candidate_report:
            require(candidate_report['corpusSha256'] == saved['corpora'][loc]['sha256'], 'candidate-report-corpus-link')
        deliveries[loc] = {
            'status': 'available-immutable-delivery', 'representation': representation,
            'currentRecord': {'path': current_path, **pins[current_path]},
            'currentRecordSchemaVersion': current.get('schemaVersion'), 'currentRecordStatus': current['status'],
            'cycleManifest': {'path': cycle_path, **pins[cycle_path]},
            'cycleVersion': cycle.get('cycle'), 'cycleStatus': cycle.get('status', cycle.get('independentReview')),
            'authorManifest': {'path': manifest_path, **pins[manifest_path]},
            'authorManifestSchemaVersion': manifest.get('schemaVersion'),
            'authorManifestStatus': manifest.get('scope', manifest.get('boundary', 'no status field; see current record')),
            'artifact': {'path': artifact, **pins[artifact]}, 'targetIds': len(target),
            'declaredFinalCorpus': current_target, 'sourceSha256': source_hash, 'sourceJoin': source_join,
            'savedTargetHash': saved['corpora'][loc]['sha256'],
            'savedTargetHashApplicability': 'applicable-exact-bytes' if current_target['sha256'] == saved['corpora'][loc]['sha256'] else 'superseded',
            'logicalSupersetRequirements': requirements, 'savedReportCharacterApplicability': report_reuse,
            'logicalSupersetBoundary': '12246-ID logical family, not exact main/mouse, subtitle-copy, nameplate or setter allocation.',
            'editorialAcceptance': 'not adjudicated here; current owner status quoted independently of historical pending cycle status',
            'wholeGameAccepted': False}
        joined = []
        for sid, src in source.items():
            joined.append({'id': sid, 'sourceSha256': sha(src['source'].encode()),
                           'targetSha256': sha(target[sid]['target'].encode()),
                           'occurrencesSha256': sha(compact(src['occurrences'])),
                           'occurrenceCount': len(src['occurrences']),
                           'sourceJoin': 'embedded-source-exact' if loc != 'ru' else 'manifest-source-and-retention-receipt'})
        join_files[f'{loc}-dialogue-joins.jsonl'] = b''.join(compact(r) + b'\n' for r in joined)

    packets = {}
    for loc in LOCALES:
        packet = interface['corpora'][loc]
        pins[packet['path']] = verify(packet['path'], packet['sha256'])
        packets[loc] = unique(rows(packet['path']))
        require(set(packets[loc]) == set(old), 'supplemental-id-coverage')
        for uid, row in packets[loc].items():
            require(sha(compact(row['source'])) == old[uid]['sourceValueSha256'], 'supplemental-source-mismatch')
    matrix = []
    projections = []
    checklist = []
    for name, p in profiles.items():
        for loc in LOCALES:
            delivery = deliveries[loc]
            ids = p['old935Projection']['ids']
            projected = [packets[loc][uid] for uid in ids]
            req = forms(r['target'] for r in projected)
            previous = p['interfaceLocales'][loc]
            require(previous['packetSha256'] == pins[previous['packetPath']]['sha256'], 'saved-packet-version')
            require(req['forms'] == previous['requirements']['forms'] and req['rawNfcNfdCodepoints'] == previous['requirements']['rawNfcNfdCodepoints'],
                    'projection-requirements-mismatch')
            for r in projected:
                binding = old[r['id']]
                projections.append({'profile': name, 'locale': loc, 'targetId': r['id'], 'sourceId': binding['sourceId'],
                    'sourceValueSha256': binding['sourceValueSha256'], 'targetUtf8Sha256': sha(r['target'].encode()),
                    'packetPath': previous['packetPath'], 'packetSha256': previous['packetSha256']})
            applicable = name in ['ordinary-dialogue', 'bundled-subtitle']
            has_delivery = delivery['status'] == 'available-immutable-delivery'
            target_state = 'bound-immutable935-subset-only' if ids else 'no-bound-target-characters'
            omissions = profile_sources[name]
            actions = {
                'source': p['remainingSourcePredicate'],
                'editorial': ('Owning locale lane must deliver reviewed targets for the explicit selector omissions; retain this935 packet as provisional.'
                              if ids or p['dynamicSelectors'] else 'Obtain exact source-to-consumer allocation before assigning targets to this role.'),
                'font': ('Reuse only this unchanged bound packet subset; final role corpus and native loaded face/layout remain unaccepted.' if ids
                         else 'No role coverage pass: await source binding and immutable final role targets; do not repeat candidate scans.'),
                'delivery': ('Use the pinned current delivery as a logical dialogue superset only.' if has_delivery
                             else 'Owning lane must publish its immutable editorial artifact/manifest after its normal review cycle; do not poll or stop it.')}
            if applicable:
                actions['source'] += ' Use stable IDs/topology; never flattened order.'
                actions['font'] = ('Use the per-form applicability in deliveries.json; outside-universe characters invalidate reused font evidence. '
                                   'Resolve actual main/mouse/subtitle allocation before any final role check.')
            cell = {'profile': name, 'locale': loc, 'componentIds': p['componentIds'],
                    'deliveryStatus': delivery['status'], 'deliveryReference': f'deliveries.json#/{loc}',
                    'savedDialogueTargetHash': saved['corpora'][loc]['sha256'],
                    'savedDialogueTargetHashApplicability': delivery['savedTargetHashApplicability'],
                    'dialogueAllocation': 'logical-superset-only' if applicable else 'not-a-role-requirement-set',
                    'logicalSupersetRequirementsReference': f'deliveries.json#/{loc}/logicalSupersetRequirements' if applicable and has_delivery else None,
                    'targetState': target_state, 'boundTargetIds': ids, 'targetCount': len(ids),
                    'boundPacket': {'path': previous['packetPath'], 'sha256': previous['packetSha256'], 'familyIds': 935},
                    'targetRequirements': req, 'reusedBoundSubsetChecks': previous['checks'],
                    'sourceOmissionsReference': f'profile-sources.json#/{name}',
                    'targetOmissions': {'nonemptyDynamicSelectorsWithoutTargets': omissions['nonemptyDynamicSourceOmissions'],
                                        'storedSelectorsWithoutTargets': omissions['storedSourceOmissions'],
                                        'absentDynamicStatesWithoutTargets': omissions['absentDynamicStates']},
                    'editorialStatus': 'no-final-role-editorial-acceptance', 'finalRoleCorpusAccepted': False,
                    'fontResourceStatus': 'needs-review', 'runtime': 'not-run', 'visual': 'not-run', 'nextPermittedAction': actions}
            matrix.append(cell)
            checklist.append({'profile': name, 'locale': loc, 'artifact': 'matrix.json',
                              'predicate': 'Final exact source/target selector corpus and applicable font evidence for this role',
                              'currentEvidence': {'targets': len(ids), 'deliveryStatus': delivery['status'], 'sourceSelectors': len(omissions['selectors'])},
                              'remainingUncertainty': p['remainingSourcePredicate'], 'status': 'needs-review',
                              'nextPermittedAction': actions})
    output = {'schemaVersion': 1, 'phase': '0149-work', 'locales': LOCALES, 'profiles': list(profiles), 'cells': matrix,
              'boundary': '70 deterministic applicability cells; no semantic review, font scan, resource production, runtime or visual acceptance.',
              'fictionalPreservation': {'font': 'sharedassets0.assets:3324', 'material': 'sharedassets0.assets:3',
                    'atlas': 'sharedassets0.assets:245', 'originalCodes': 100, 'pinnedPhoneticRows': 38,
                    'evidenceSha256': sha(compact(role['fictionalPreservation'])), 'completeFictionalDialogue': False},
              'gates': role['gates']}
    validate(output)
    result = {'matrix.json': encoded(output), 'deliveries.json': encoded(deliveries),
              'profile-sources.json': encoded(profile_sources), 'acceptance-checklist.json': encoded(checklist),
              'target-projections.jsonl': b''.join(compact(r) + b'\n' for r in projections), **join_files}
    return result, pins


def validate(matrix):
    cells = matrix['cells']
    require(len(cells) == 70, 'matrix-cell-count')
    require(len({(r['profile'], r['locale']) for r in cells}) == 70, 'matrix-cell-uniqueness')
    require({r['locale'] for r in cells} == set(LOCALES), 'matrix-locale-coverage')
    for cell in cells:
        require(cell['targetCount'] == len(set(cell['boundTargetIds'])), 'target-id-count')
        require(not cell['finalRoleCorpusAccepted'], 'unsupported-final-role-acceptance')
        if not cell['targetCount']:
            require(cell['targetState'] == 'no-bound-target-characters', 'empty-projection-pass')
            require(all(r['missingCount'] is None for r in cell['reusedBoundSubsetChecks']), 'empty-font-pass')
        require(not (cell['dialogueAllocation'] == 'not-a-role-requirement-set' and cell['logicalSupersetRequirementsReference']),
                'unbound-dialogue-allocation')
    for loc in LOCALES:
        desc = next(c for c in cells if c['profile'] == 'inventory-tickerText' and c['locale'] == loc)
        title = next(c for c in cells if c['profile'] == 'inventory-itemTitleText' and c['locale'] == loc)
        require(len(desc['targetOmissions']['nonemptyDynamicSelectorsWithoutTargets']) == 50, 'description-omission-count')
        require(len(title['targetOmissions']['nonemptyDynamicSelectorsWithoutTargets']) == 2, 'title-empty-cell-omission-count')
    require(matrix['fictionalPreservation']['originalCodes'] == 100 and matrix['fictionalPreservation']['pinnedPhoneticRows'] == 38
            and not matrix['fictionalPreservation']['completeFictionalDialogue'], 'fictional-scope')


def controls(matrix):
    validate(matrix)
    results = []

    def reject(name, call, reason):
        try:
            call()
        except ValueError as e:
            require(str(e) == reason, 'wrong-rejection:' + name + ':' + str(e))
            results.append({'name': name, 'expectedReason': reason, 'result': 'rejected-at-intended-boundary'})
        else:
            raise ValueError('not-rejected:' + name)

    source = {'a': {'id': 'a', 'source': 'same', 'occurrences': ['x', 'y']}}
    positive = {'a': {'id': 'a', 'source': 'same', 'target': 'target', 'sourceSha256': sha(b'same'),
                      'targetSha256': sha(b'target'), 'occurrences': ['x', 'y']}}
    equal_source(source, positive)
    reject('duplicate IDs before mapping', lambda: unique([{'id': 'a'}, {'id': 'a'}]), 'duplicate-stable-id')
    reject('missing target with otherwise valid source', lambda: equal_source(source, {}), 'source-target-id-coverage')
    bad = copy.deepcopy(positive); bad['a']['source'] = 'different'; bad['a']['sourceSha256'] = sha(b'different')
    reject('source value changed with correct own hash', lambda: equal_source(source, bad), 'source-value-mismatch')
    bad = copy.deepcopy(positive); bad['a']['occurrences'].reverse()
    reject('physical source pointer order', lambda: equal_source(source, bad), 'source-occurrence-mismatch')
    bad = copy.deepcopy(positive); bad['a']['targetSha256'] = sha(b'wrong')
    reject('embedded target hash', lambda: equal_source(source, bad), 'embedded-target-hash-mismatch')
    reject('live overlay read', lambda: allowed('localization/ru-assets/dialogue.ru.jsonl'), 'live-overlay-prohibited')
    reject('wrong manifest file hash', lambda: verify(DIALOGUE, '0' * 64), 'file-hash-mismatch:' + DIALOGUE)
    bad = copy.deepcopy(matrix); bad['cells'][0] = copy.deepcopy(bad['cells'][1])
    reject('duplicate matrix cell', lambda: validate(bad), 'matrix-cell-uniqueness')
    bad = copy.deepcopy(matrix); next(c for c in bad['cells'] if not c['targetCount'])['targetState'] = 'passed'
    reject('empty projection credited as coverage', lambda: validate(bad), 'empty-projection-pass')
    bad = copy.deepcopy(matrix); next(c for c in bad['cells'] if c['profile'] == 'inventory-tickerText')['targetOmissions']['nonemptyDynamicSelectorsWithoutTargets'].pop()
    reject('description omission hidden', lambda: validate(bad), 'description-omission-count')
    bad = copy.deepcopy(matrix); next(c for c in bad['cells'] if c['profile'] == 'inventory-itemTitleText')['targetOmissions']['nonemptyDynamicSelectorsWithoutTargets'].pop()
    reject('compiled empty-cell title omission hidden', lambda: validate(bad), 'title-empty-cell-omission-count')
    bad = copy.deepcopy(matrix); c = next(c for c in bad['cells'] if c['profile'] == 'plugin-portrait-name'); c['logicalSupersetRequirementsReference'] = 'invented'
    reject('unmapped plugin given dialogue corpus', lambda: validate(bad), 'unbound-dialogue-allocation')
    req = forms(['é'])
    check = report_applicability(req, [ord('é')])
    require(check['raw']['status'] == 'within-saved-universe-only' and check['NFD']['status'] == 'inapplicable-outside-saved-universe', 'normalization-positive-control')
    require(all(r['missingCount'] is None for r in check.values()), 'applicability-inferred-coverage')
    return {'negativeControls': results, 'positiveControls': ['valid exact source/hash/occurrence join',
        'complete70-cell matrix', 'raw/NFC/NFD kept separate; decomposed new characters invalidate only applicability',
        'empty projections have no font coverage pass', '48 DB descriptions and four compiled empty-cell inputs remain omissions'],
        'boundary': 'Controls test deterministic metadata/ID/hash/selector rejection; no semantic, font-parser or native renderer proof.'}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    obs_path = HERE / 'observation.json'
    if args.check:
        observation = json.loads(obs_path.read_text())
    else:
        require(not obs_path.exists(), 'append-only-observation-already-exists')
        observation = discover()
        obs_path.write_bytes(encoded(observation))
    outputs, pins = derive(observation)
    matrix = json.loads(outputs['matrix.json'])
    control = controls(matrix)
    outputs['controls.json'] = encoded(control)
    pins[str(obs_path.relative_to(ROOT))] = fingerprint(str(obs_path.relative_to(ROOT)))
    pins[str((HERE / 'bind.py').relative_to(ROOT))] = fingerprint(str((HERE / 'bind.py').relative_to(ROOT)))
    outputs['input-pins.json'] = encoded(pins)
    receipt = {'schemaVersion': 1, 'status': 'passed-deterministic-applicability-only', 'phase': '0149-work',
               'cells': 70, 'profiles': 10, 'locales': 7, 'immutableDialogueIdJoins': 36738,
               'immutable935ProjectionRows': sum(c['targetCount'] for c in matrix['cells']),
               'negativeControls': len(control['negativeControls']), 'inputPins': len(pins),
               'outputPins': {name: {'sha256': sha(data), 'bytes': len(data)} for name, data in outputs.items()},
               'writes': 'Append-only sequential files, not a multi-file transaction; no prior packet overwritten.',
               'fontScans': 0, 'gameRuntime': 'not-run', 'visual': 'not-run', 'editorialJudgment': 'not-performed',
               'workerTokenTelemetry': 'unknown; parent owns measurement'}
    outputs['validation.json'] = encoded(receipt)
    for name, data in outputs.items():
        path = HERE / name
        if args.check:
            require(path.read_bytes() == data, 'reproduction-mismatch:' + name)
        else:
            require(not path.exists(), 'append-only-output-already-exists:' + name)
            path.write_bytes(data)
    print(json.dumps({k: receipt[k] for k in ['status', 'cells', 'immutableDialogueIdJoins', 'immutable935ProjectionRows', 'negativeControls', 'inputPins']}))


if __name__ == '__main__':
    main()
