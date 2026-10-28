#!/usr/bin/env python3
"""Finite phase150 metadata reconciliation. No live overlays, fonts or game I/O."""
import argparse
import copy
import hashlib
import json
from pathlib import Path
import unicodedata

ROOT = Path(__file__).resolve().parents[3]
OUT = Path(__file__).resolve().parent
ROLE = 'localization/fonts/role-requirements-20261028/'
SOURCE = 'localization/source/shared-source-completion-20261028/admission-v1/'
DELIVERY = 'localization/editorial-delivery/'
LOCALES = ['ru', 'zh', 'es', 'es-419', 'pt-BR', 'ja', 'de']
PINS = {}


def need(ok, reason):
    if not ok:
        raise ValueError(reason)


def sha(data):
    return hashlib.sha256(data).hexdigest()


def raw_hash(text):
    return sha(text.encode('utf-8'))


def value_hash(value):
    return sha(json.dumps(value, ensure_ascii=False, separators=(',', ':')).encode())


def read(path, expected=None):
    path = Path(path)
    if path.is_absolute():
        path = path.relative_to(ROOT)
    # Saved snapshots inside owning output jobs are allowed; canonical live lanes are not.
    need(not (path.parts[0] == 'localization' and any(p.endswith('-assets') for p in path.parts)),
         'live-target-read-prohibited')
    need(path.parts[0] in ['localization', 'outputs'], 'outside-bounded-project')
    data = (ROOT / path).read_bytes()
    actual = {'sha256': sha(data), 'bytes': len(data)}
    if expected:
        need(actual['sha256'] == (expected if isinstance(expected, str) else expected['sha256']),
             'input-hash-mismatch:' + str(path))
        if isinstance(expected, dict) and 'bytes' in expected:
            need(len(data) == expected['bytes'], 'input-length-mismatch:' + str(path))
    PINS[str(path)] = actual
    return data


def load(path, expected=None):
    return json.loads(read(path, expected))


def lines(path, expected=None):
    return [json.loads(s) for s in read(path, expected).decode().splitlines()]


def unique(rows):
    result = {}
    for row in rows:
        need(row['id'] not in result, 'duplicate-stable-id:' + row['id'])
        result[row['id']] = row
    return result


def require_source(row, source):
    need(row['id'] in source, 'unknown-source-id:' + row['id'])
    need(row['source'] == source[row['id']]['source'], 'source-value-mismatch:' + row['id'])
    for key in ['occurrences', 'pointer']:
        if key in row and key in source[row['id']]:
            need(row[key] == source[row['id']][key], 'source-occurrence-mismatch:' + row['id'])
    if 'sourceSha256' in row:
        need(row['sourceSha256'] == raw_hash(row['source']), 'source-hash-mismatch:' + row['id'])
    if 'targetSha256' in row:
        need(row['targetSha256'] == raw_hash(row['target']), 'target-hash-mismatch:' + row['id'])


def forms(texts):
    # Match phase147's display-character convention; controls remain in value hashes.
    return {form: sorted({ord(c) for text in texts
                          for c in (text if form == 'raw' else unicodedata.normalize(form, text))
                          if not unicodedata.category(c).startswith('C')})
            for form in ['raw', 'NFC', 'NFD']}


def outside(current, universe):
    return sorted(set(current) - set(universe))


def manifest(path):
    d = load(path)
    return d, {'path': path, **PINS[path],
               'version': d.get('currentCycle', d.get('cycle', 'unversioned-output-manifest')),
               'status': d.get('status', d.get('scope', d.get('independentReview', 'not-declared')))}


def corpus_check(rows, source, expected_hash=None):
    unique(rows)
    need({r['id'] for r in rows} == set(source), 'dialogue-id-coverage-mismatch')
    for row in rows:
        require_source(row, source)
    data = ''.join(json.dumps(r, ensure_ascii=False, separators=(',', ':')) + '\n' for r in rows).encode()
    if expected_hash:
        need(sha(data) == expected_hash, 'reconstructed-corpus-hash-mismatch')
    return data


def derive():
    discovery = load(str((OUT / 'discovery.json').relative_to(ROOT)))
    role = load(ROLE + 'reconciliation.json')
    load(ROLE + 'input-pins.json')  # Preserve historical pins; do not bless changed builders.
    report = load('localization/font-checks/dialogue-20261027-02.json',
                  role['reports']['localization/font-checks/dialogue-20261027-02.json'])
    interface = load('localization/font-checks/supplemental-30-20261028.json',
                     role['reports']['localization/font-checks/supplemental-30-20261028.json'])
    load(SOURCE + 'manifest.json', role['sourceManifest']['sha256'])
    source_rows = lines('localization/source/dialogue-candidates.jsonl', report['sourceFamilySha256'])
    source = unique(source_rows)
    need(len(source) == 12246, 'dialogue-source-count')
    need(sum(len(r['occurrences']) for r in source_rows) == 24492, 'dialogue-physical-occurrence-count')
    direct = unique(lines(SOURCE + 'direct-context.jsonl'))
    serial = unique(lines(SOURCE + 'serialized-inventory.jsonl'))
    bg = unique(lines(SOURCE + 'bgdatabase-inventory.jsonl'))
    compiled = unique(lines(SOURCE + 'compiled-wording-source.jsonl'))
    old = unique(load(SOURCE + 'old935-selector-bindings.json'))
    need(len(old) == 935, 'old935-count')
    profiles = role['requirementProfiles']
    need(len(profiles) == 10, 'profile-count')
    components = [c for p in profiles.values() for c in p['componentIds']]
    need(len(components) == len(set(components)) == 109, 'selected-component-count')
    packets = {}
    for loc in LOCALES:
        c = interface['corpora'][loc]
        packet = unique(lines(c['path'], c['sha256']))
        need(set(packet) == set(old), 'old935-target-id-coverage:' + loc)
        for uid, row in packet.items():
            need(value_hash(row['source']) == old[uid]['sourceValueSha256'], 'interface-source-mismatch:' + uid)
        packets[loc] = packet

    deliveries, corpora = {}, {}
    # Russian: exact immutable before rows +27 complete after rows. Never write a target overlay.
    ru_base = DELIVERY + 'ru-cycle-02/'
    ru_manifest, ru_ref = manifest(ru_base + 'author/delivery-manifest.json')
    ru_cycle, ru_cycle_ref = manifest(ru_base + 'cycle/manifest.json')
    need(ru_ref['version'] == ru_cycle['cycle'], 'ru-cycle-version-mismatch')
    need(ru_manifest['cycleManifestSha256'] == ru_cycle_ref['sha256'], 'ru-cycle-hash-mismatch')
    before_path = 'outputs/editorial-20261027/final-ru-v1/ru/before/localization/ru-assets/dialogue.ru.jsonl'
    change_original = 'outputs/editorial-20261027/final-ru-v1/ru/before-after-complete-rows.jsonl'
    change_path = ru_base + 'author/before-after-complete-rows.jsonl'
    ru_before = lines(before_path, ru_manifest['files'][before_path])
    ru_changes = unique(lines(change_path, ru_manifest['files'][change_original]))
    need(len(ru_changes) == ru_cycle['changedCount'] == 27, 'ru-change-count')
    ru_rows = []
    for row in ru_before:
        change = ru_changes.get(row['id'])
        if change:
            need(row == change['before'], 'ru-exact-before-mismatch')
            need(change['after']['id'] == row['id'], 'ru-after-id-mismatch')
        ru_rows.append(change['after'] if change else row)
    ru_hash = ru_manifest['canonicalFinalHashes'][str(ROOT / 'localization/ru-assets/dialogue.ru.jsonl')]
    corpus_check(ru_rows, source, ru_hash)
    corpora['ru'] = ru_rows
    deliveries['ru'] = {'manifests': [ru_ref, ru_cycle_ref], 'sha256': ru_hash,
                        'representation': 'verified-in-memory-exact-composite; no replacement overlay written',
                        'artifacts': [before_path, change_path], 'changedRows': 27}

    # Chinese: exact before-map snapshot + two manifest-bound complete target corrections.
    zh_base = DELIVERY + 'zh-cycle-02/'
    zh_cycle, zh_ref = manifest(zh_base + 'cycle/manifest.json')
    zh_application_path = 'outputs/editorial-20261027/final-repairs-v1/zh/application-manifest.json'
    zh_output_path = 'outputs/editorial-20261027/final-repairs-v1/zh/output-manifest.json'
    zh_output, zh_output_ref = manifest(zh_output_path)
    app = load(zh_application_path, zh_output['files']['application-manifest.json'])
    zh_before_path = 'outputs/editorial-20261027/final-repairs-v1/zh/backup/localization/zh-assets/dialogue.zh.jsonl'
    zh_rows = lines(zh_before_path, app['beforeMapSha256'])
    zh_review_path = zh_base + 'cycle/closure-review-rows.jsonl'
    zh_review = unique(lines(zh_review_path, zh_cycle['files']['closure-review-rows.jsonl']))
    zh_changed = read(zh_base + 'cycle/changed-ids.txt', zh_cycle['files']['changed-ids.txt']).decode().splitlines()
    need(len(set(zh_changed)) == len(zh_changed) == zh_cycle['changedCount'] == 2, 'zh-change-count')
    need(set(zh_changed) == set(app['fixIds']), 'zh-application-ids-mismatch')
    for row in zh_rows:
        if row['id'] in zh_changed:
            change = zh_review[row['id']]
            need(row['source'] == change['source'] and row['target'] == change['oldTarget'], 'zh-exact-before-mismatch')
            row['target'], row['targetSha256'] = change['target'], change['targetSha256']
    corpus_check(zh_rows, source, app['expectedMapSha256'])
    corpora['zh'] = zh_rows
    deliveries['zh'] = {'manifests': [zh_ref, zh_output_ref], 'sha256': app['expectedMapSha256'],
                        'representation': 'verified-in-memory-exact-composite; no replacement overlay written',
                        'artifacts': [zh_before_path, zh_application_path, zh_review_path,
                                      zh_base + 'cycle/changed-ids.txt'], 'changedRows': 2}

    # German: actual final saved artifact, checked against both owning manifests.
    de_base = DELIVERY + 'de-cycle-02/'
    de_manifest, de_ref = manifest(de_base + 'author/output-manifest.json')
    de_cycle, de_cycle_ref = manifest(de_base + 'cycle/manifest.json')
    need(de_manifest['finalCycleManifest']['sha256'] == de_cycle_ref['sha256'], 'de-cycle-hash-mismatch')
    de_path = 'outputs/editorial-20261027/final-de-v1/de/after-overlay.jsonl'
    de_pin = de_manifest['files']['after-overlay.jsonl']
    de_rows = lines(de_path, de_pin)
    corpus_check(de_rows, source, de_pin['sha256'])
    corpora['de'] = de_rows
    deliveries['de'] = {'manifests': [de_ref, de_cycle_ref], 'sha256': de_pin['sha256'],
                        'representation': 'owning-manifest-bound-immutable-final-file', 'artifacts': [de_path],
                        'changedRows': de_cycle['changedIds']}

    corpus_joins = []
    for loc in LOCALES:
        saved = report['corpora'][loc]
        if loc not in deliveries:
            deliveries[loc] = {'manifests': [], 'sha256': None, 'representation': 'no-final-immutable-delivery-located',
                               'artifacts': [], 'owningJob': discovery['jobs'][loc],
                               'unverifiedTargetIdsReference': 'dialogue-source-ids.txt',
                               'nextAction': 'Owning linguistic lane must provide its versioned immutable correction/final delivery; do not read live overlays or infer final hashes from draft counts.'}
        d = deliveries[loc]
        if loc in corpora:
            current_path = DELIVERY + loc + '-current.json'
            current = load(current_path)
            declared = current['target'] if loc == 'zh' else current['currentCorpus']
            declared_source = current['source']['sha256'] if loc == 'zh' else current['sourceSha256']
            need(declared['sha256'] == d['sha256'], 'owning-current-corpus-mismatch')
            need(declared_source == report['sourceFamilySha256'], 'owning-current-source-mismatch')
            d['currentRecord'] = {'path': current_path, **PINS[current_path],
                                  'schemaVersion': current['schemaVersion'], 'status': current['status']}
        d['savedDialogueSha256'] = saved['sha256']
        d['savedHashApplicability'] = ('unverifiable' if loc not in corpora else
                                       'applicable' if d['sha256'] == saved['sha256'] else 'superseded')
        d['ids'] = len(corpora[loc]) if loc in corpora else None
        d['sourceIds'] = len(source)
        d['editorialAcceptance'] = 'not-established-by-this-deterministic-reconciliation'
        if loc in corpora:
            req = forms([r['target'] for r in corpora[loc]])
            universe = sorted(map(ord, saved['characters']))
            extra = outside(req['raw'], universe)
            d['logicalSupersetRequirements'] = req
            d['priorRawRequirementUniverse'] = universe
            d['rawOutsidePriorUniverse'] = extra
            d['perFormReportApplicability'] = {
                form: {'status': 'inapplicable-outside-saved-universe' if outside(codes, universe)
                                 else 'within-saved-universe-only',
                       'outsideCodepoints': outside(codes, universe), 'missingCount': None,
                       'boundary': 'Applicability only; no new missing/present font claim or exact role allocation.'}
                for form, codes in req.items()}
            d['fontReportApplicability'] = ('inapplicable-current-characters-outside-report-universe' if extra else
                                             'raw-static-subset-evidence-only; final-role-and-NFC/NFD-coverage-unaccepted')
            for row in corpora[loc]:
                corpus_joins.append({'locale': loc, 'id': row['id'], 'sourceSha256': raw_hash(row['source']),
                                     'targetSha256': raw_hash(row['target']), 'corpusSha256': d['sha256'],
                                     'roleAllocation': 'unmapped-logical-superset'})

    profile_sources, matrix, target_joins = {}, [], []
    for name, profile in profiles.items():
        selectors = []
        for s in profile['storedSelectors']:
            uid = s['id']
            need(uid in serial and uid in direct, 'missing-stored-source')
            need(value_hash(direct[uid]['value']) == serial[uid]['sourceValueSha256'] == s['sourceValueSha256'],
                 'stored-source-hash-mismatch')
            selectors.append({'id': uid, 'sourceValueSha256': s['sourceValueSha256'], 'selection': 'stored',
                              'nonempty': bool(direct[uid]['value'])})
        for s in profile['dynamicSelectors']:
            uid = s['id']
            admitted = bg if s['family'] == 'bgdatabase' else compiled
            need(uid in admitted and s['sourceValueSha256'] == admitted[uid]['sourceValueSha256'], 'dynamic-source-mismatch')
            if 'source' in s:
                need(value_hash(s['source']) == s['sourceValueSha256'], 'dynamic-value-mismatch')
            selectors.append({'id': uid, 'sourceValueSha256': s['sourceValueSha256'], 'selection': 'dynamic-candidate',
                              'family': s['family'], 'stored': s.get('stored'),
                              'nonempty': bool(s.get('source')) if 'source' in s else None,
                              'valueState': s.get('valueState')})
        smap = unique(selectors)
        bound = profile['old935Projection']['ids']
        for uid in bound:
            need(uid in old and old[uid]['sourceId'] in smap, 'projection-outside-real-selector')
            need(old[uid]['sourceValueSha256'] == smap[old[uid]['sourceId']]['sourceValueSha256'], 'projection-source-hash')
        mapped_sources = {old[uid]['sourceId'] for uid in bound}
        profile_sources[name] = {'componentIds': profile['componentIds'], 'selectors': selectors,
                                'consumerPredicate': profile['consumerPredicate'],
                                'remainingSourcePredicate': profile['remainingSourcePredicate'],
                                'old935Ids': bound,
                                'sourceSelectorsWithoutOld935Targets': [s['id'] for s in selectors if s['id'] not in mapped_sources],
                                'nonemptyDynamicSourcesWithoutOld935Targets': profile['old935Projection']['nonemptyDynamicSourcesWithoutOld935Targets'],
                                'absentDynamicStates': profile['old935Projection']['absentDynamicStates'],
                                'nextSourceAction': profile['nextPermittedAction']}
        for loc in LOCALES:
            saved = profile['interfaceLocales'][loc]
            packet = packets[loc]
            need(saved['packetSha256'] == interface['corpora'][loc]['sha256'], 'saved-interface-version-mismatch')
            req = forms([packet[uid]['target'] for uid in bound])
            need(req == saved['requirements']['forms'], 'saved-profile-requirements-mismatch')
            d = deliveries[loc]
            current_ids = {r['id'] for r in corpora.get(loc, [])}
            exact_current = sorted(set(smap) & current_ids)
            # Current deliveries contain ds: IDs; never infer role allocation from flattened order.
            need(not exact_current, 'unexpected-current-role-selector-requires-explicit-binding')
            for uid in bound:
                row = packet[uid]
                target_joins.append({'profile': name, 'locale': loc, 'targetId': uid,
                                     'sourceId': old[uid]['sourceId'], 'sourceValueSha256': old[uid]['sourceValueSha256'],
                                     'targetValueSha256': value_hash(row['target']), 'targetRawSha256': raw_hash(row['target']),
                                     'packetPath': saved['packetPath'], 'packetSha256': saved['packetSha256'],
                                     'binding': old[uid]['binding'], 'applicability': 'old935-bound-subset-only'})
            gaps = ['final-role-corpus-unaccepted', 'native-loaded-face-shaping-metrics-layout-unverified']
            if not bound:
                gaps.append('no-bound-interface-target-characters')
            if name in ['ordinary-dialogue', 'bundled-subtitle']:
                gaps.append('dialogue-main-mouse-and-physical-component-allocation-unmapped')
            if name == 'plugin-portrait-name':
                gaps.append('plugin-speaker-source-target-handoff-unmapped')
            if name == 'custom-nameplate':
                gaps.append('custom-setter-parser-dynamic-input-allocation-unmapped')
            if profile_sources[name]['sourceSelectorsWithoutOld935Targets']:
                gaps.append('source-selectors-absent-from-old935')
            if loc not in corpora:
                gaps.append('missing-final-immutable-dialogue-delivery')
            cell = {'profile': name, 'locale': loc, 'selectedComponents': len(profile['componentIds']),
                    'selectorCount': len(selectors), 'sourceSelectorsReference': 'profile-sources.json#' + name,
                    'owningDeliveryReference': 'phase150-corpus-bindings.json#/' + loc,
                    'currentDeliveryExactRoleIds': exact_current,
                    'currentRoleTargetRequirements': None,
                    'currentRoleStatus': 'unmapped' if loc in corpora else 'missing-immutable-delivery',
                    'savedDialogueHashApplicability': d['savedHashApplicability'],
                    'savedDialogueRoleApplicability': profile['savedDialogue']['applicability'],
                    'old935': {'path': saved['packetPath'], 'sha256': saved['packetSha256'], 'units': len(bound),
                               'savedHashApplicability': 'applicable-exact-unchanged-packet',
                               'requirements': req,
                               'fontEvidence': 'unchanged-bound-subset-only' if bound else 'no-bound-target-characters',
                               'coveragePass': False},
                    'gaps': gaps, 'nextSourceAction': profile['nextPermittedAction'],
                    'nextEditorialAction': 'Complete source-bound per-role immutable target handoff and universal semantic/independent-delta acceptance; manifest counts are not editorial judgment.',
                    'nextFontAction': 'After exact final role mapping, compare raw/NFC/NFD requirements to pinned report universes; new characters invalidate reuse. No font scans or resources produced here.',
                    'acceptance': 'needs-review'}
            matrix.append(cell)
    need(len(matrix) == 70 and len({(c['profile'], c['locale']) for c in matrix}) == 70, 'matrix-70-cell-coverage')
    descriptions = profile_sources['inventory-tickerText']['nonemptyDynamicSourcesWithoutOld935Targets']
    need(len(descriptions) == 50, 'description-omission-count')
    need(sum(s['family'] == 'bgdatabase' and bool(s.get('source')) for s in profiles['inventory-tickerText']['dynamicSelectors']) == 48,
         '48-nonempty-description-sources')
    empty_inputs = [s['id'] for n in ['inventory-itemTitleText', 'inventory-tickerText']
                    for s in profiles[n]['dynamicSelectors'] if s['family'] == 'managed-literal']
    need(len(set(empty_inputs)) == len(empty_inputs) == 4, 'four-empty-cell-inputs')
    need(all(uid not in {r['sourceId'] for r in old.values()} for uid in empty_inputs), 'empty-cell-old935-omission')
    fictional = role['fictionalPreservation']
    need(fictional['mappingPreserved'] and fictional['fontMouse']['m_PathID'] == 3324, 'fictional-mapping')
    need(len(role['fictionalResources']['sharedassets0.assets:3324']['characterCodes']) == 100, 'fictional-code-count')
    return {'matrix': matrix, 'deliveries': deliveries, 'profiles': profile_sources,
            'corpusJoins': corpus_joins, 'targetJoins': target_joins, 'sourceIds': list(source),
            'emptyInputs': empty_inputs, 'fictional': {'controller': 4311, 'fontMouse': 3324, 'material': 3,
                'atlas': 245, 'originalCodes': 100, 'pinnedPhoneticRows': 38,
                'boundary': '38 is not the complete fictional-dialogue denominator; unchanged phase147 evidence.'}}


def controls(data):
    results = []
    def reject(name, action, reason):
        try:
            action()
        except ValueError as exc:
            need(reason in str(exc), 'wrong-negative-boundary:' + name)
            results.append({'name': name, 'expectedReason': reason, 'result': 'rejected'})
        else:
            raise ValueError('negative-control-accepted:' + name)
    reject('duplicate-stable-id', lambda: unique([{'id': 'a'}, {'id': 'a'}]), 'duplicate-stable-id')
    unique([{'id': 'a'}, {'id': 'b'}])
    reject('source-value-drift', lambda: require_source({'id': 'a', 'source': 'new', 'target': 'x'},
                                                      {'a': {'source': 'old'}}), 'source-value-mismatch')
    require_source({'id': 'a', 'source': 'old', 'target': 'x'}, {'a': {'source': 'old'}})
    reject('physical-pointer-order', lambda: require_source({'id': 'a', 'source': 'old', 'occurrences': ['b', 'a']},
                  {'a': {'source': 'old', 'occurrences': ['a', 'b']}}), 'source-occurrence-mismatch')
    reject('unknown-translation-id', lambda: require_source({'id': 'b', 'source': 'old'},
                                                          {'a': {'source': 'old'}}), 'unknown-source-id')
    reject('live-target-access-before-read', lambda: read('localization/ru-assets/dialogue.ru.jsonl'), 'live-target-read-prohibited')
    reject('hash-mismatch', lambda: read(ROLE + 'reconciliation.json', '0' * 64), 'input-hash-mismatch')
    sample = [{'id': 'a', 'source': 'x', 'target': 'y'}]
    corpus_check(sample, {'a': {'source': 'x'}})
    reject('incomplete-corpus', lambda: corpus_check(sample, {'a': {'source': 'x'}, 'b': {'source': 'z'}}), 'dialogue-id-coverage-mismatch')
    reject('corpus-byte-version-mismatch', lambda: corpus_check(sample, {'a': {'source': 'x'}}, '0' * 64), 'reconstructed-corpus-hash-mismatch')
    reject('outside-report-universe', lambda: need(not outside([65, 0x4E00], [65]), 'report-universe-exceeded'), 'report-universe-exceeded')
    need(not outside([65], [65, 66]), 'subset-positive')
    reject('empty-projection-is-not-coverage', lambda: need(bool(forms([])['raw']), 'no-bound-target-characters'), 'no-bound-target-characters')
    need(bool(forms(['A'])['raw']), 'nonempty-positive')
    need(forms(['й'])['raw'] != forms(['й'])['NFD'], 'normalization-separation')
    omissions = data['profiles']['inventory-tickerText']['nonemptyDynamicSourcesWithoutOld935Targets']
    reject('48-description-omissions-cannot-pass', lambda: need(not omissions, 'missing-description-targets'), 'missing-description-targets')
    reject('four-empty-cell-inputs-cannot-pass', lambda: need(not data['emptyInputs'], 'missing-empty-cell-targets'), 'missing-empty-cell-targets')
    reject('69-cell-matrix-cannot-pass', lambda: need(len(data['matrix'][:-1]) == 70, 'matrix-70-cell-coverage'), 'matrix-70-cell-coverage')
    return {'negativeControls': results, 'positiveControls': ['unique-ids', 'matching-source', 'complete-corpus',
            'in-universe-subset', 'nonempty-projection', 'raw-versus-NFD-separation', 'real-70-cell-matrix',
            'three-exact-current-corpus-hashes', '48-nonempty-descriptions-and-four-compiled-inputs'],
            'boundary': 'Metadata/hash/ID gates only; no semantic, font-parser, resource, native or visual replacement.'}


def encoded(value):
    return (json.dumps(value, ensure_ascii=False, indent=2) + '\n').encode()


def jsonl(rows):
    return ''.join(json.dumps(r, ensure_ascii=False, separators=(',', ':')) + '\n' for r in rows).encode()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    parser.add_argument('--recovered-recipe', action='store_true',
                        help='Write separate parent recovery receipts; preserve historical phase150 receipts.')
    args = parser.parse_args()
    data = derive()
    tests = controls(data)
    # Reconcile and reuse the existing149 artifacts, instead of creating a duplicate matrix.
    prefix = str(OUT.relative_to(ROOT)) + '/'
    prior_validation = load(prefix + 'validation.json')
    for name, pin in prior_validation['outputPins'].items():
        read(prefix + name, pin)
    prior_pins = load(prefix + 'input-pins.json')
    historical_recipe = prefix + 'bind.py'
    for name, pin in prior_pins.items():
        if name != historical_recipe:
            read(name, pin)
    recipe_actual = read(historical_recipe)
    recipe_gap = {'path': historical_recipe, 'expectedOriginal': prior_pins[historical_recipe],
                  'current': {'sha256': sha(recipe_actual), 'bytes': len(recipe_actual)},
                  'status': 'original-recipe-recovery-required',
                  'cause': 'Phase150 mistakenly replaced existing untracked recipe before discovering149 artifacts. Git HEAD has no copy. Existing data outputs remain byte-identical; prior recipe reproducibility is not claimed.',
                  'nextAction': 'Parent must recover exact original bytes matching expectedOriginal from its retained edit/request evidence. Worker did not open prior CLI history.'}
    if args.recovered_recipe:
        need(recipe_gap['current'] == recipe_gap['expectedOriginal'], 'original-recipe-not-restored')
        recipe_gap.update(status='original-recipe-restored-and-reproduced',
                          cause='Parent recovered exact pinned recipe bytes from the original AddFile request; both later revisions remain preserved separately.',
                          nextAction='No recipe recovery remains. Source allocation, missing final deliveries and all other acceptance gates remain open.')
    prior_matrix = load(prefix + 'matrix.json')
    prior_cells = {(c['profile'], c['locale']): c for c in prior_matrix['cells']}
    need(len(prior_cells) == len(prior_matrix['cells']) == 70, 'recovered-matrix-coverage')
    prior_deliveries = load(prefix + 'deliveries.json')
    for c in data['matrix']:
        old_cell = prior_cells[c['profile'], c['locale']]
        need(old_cell['targetCount'] == c['old935']['units'], 'recovered-role-count-mismatch')
        need(old_cell['boundTargetIds'] == data['profiles'][c['profile']]['old935Ids'], 'recovered-target-id-mismatch')
        need(old_cell['boundPacket']['sha256'] == c['old935']['sha256'], 'recovered-packet-hash-mismatch')
        need(old_cell['targetRequirements']['forms'] == c['old935']['requirements'], 'recovered-role-form-mismatch')
        need(old_cell['savedDialogueTargetHashApplicability'] == c['savedDialogueHashApplicability'], 'recovered-saved-applicability-mismatch')
        need(old_cell['finalRoleCorpusAccepted'] is False, 'recovered-unaccepted-role-promoted')
    for loc in ['ru', 'zh', 'de']:
        prior = unique(lines(prefix + loc + '-dialogue-joins.jsonl'))
        current = [r for r in data['corpusJoins'] if r['locale'] == loc]
        need(set(prior) == {r['id'] for r in current}, 'recovered-corpus-id-mismatch')
        for r in current:
            need(prior[r['id']]['sourceSha256'] == r['sourceSha256'] and
                 prior[r['id']]['targetSha256'] == r['targetSha256'], 'recovered-corpus-hash-join-mismatch')
        need(prior_deliveries[loc]['logicalSupersetRequirements']['forms'] ==
             data['deliveries'][loc]['logicalSupersetRequirements'], 'recovered-corpus-forms-mismatch')
        need(prior_deliveries[loc]['savedReportCharacterApplicability'] ==
             data['deliveries'][loc]['perFormReportApplicability'], 'recovered-font-applicability-mismatch')
    prior_target_joins = lines(prefix + 'target-projections.jsonl')
    old_projection = {(r['profile'], r['locale'], r['targetId']): r for r in prior_target_joins}
    need(len(old_projection) == len(prior_target_joins) == len(data['targetJoins']), 'recovered-target-projection-count')
    for r in data['targetJoins']:
        old_row = old_projection[r['profile'], r['locale'], r['targetId']]
        need(old_row['sourceId'] == r['sourceId'] and old_row['sourceValueSha256'] == r['sourceValueSha256']
             and old_row['targetUtf8Sha256'] == r['targetRawSha256'], 'recovered-target-projection-hash')
    # Exact current map/file controls bind the recovery to owning immutable artifacts as well.
    ru_map = load('outputs/editorial-20261027/final-ru-v1/ru/after-target-map.json', prior_deliveries['ru']['artifact'])
    need(len(ru_map) == 12246, 'ru-map-count')
    for row in [r for r in data['corpusJoins'] if r['locale'] == 'ru']:
        need(raw_hash(ru_map[row['id']]) == row['targetSha256'], 'ru-map-exact-target')
    zh_snapshot = prior_deliveries['zh']['artifact']
    zh_rows = lines(zh_snapshot['path'], zh_snapshot)
    zh_source = unique(lines('localization/source/dialogue-candidates.jsonl'))
    corpus_check(zh_rows, zh_source, data['deliveries']['zh']['sha256'])
    outputs = {'phase150-corpus-bindings.json': encoded(data['deliveries']),
               'phase150-recipe-recovery.json': encoded(recipe_gap),
               'phase150-controls.json': encoded(tests),
               'phase150-verification.json': encoded({'status': 'passed-data-reconciliation-with-original-recipe-recovery-gap',
                   'phase': '0150-work', 'reusedMatrix': 'matrix.json', 'verifiedCells': len(data['matrix']),
                   'verifiedCurrentCorpora': 3, 'sourceIdsPerCorpus': 12246, 'physicalOccurrencesPerCorpus': 24492,
                   'verifiedDialogueHashJoins': len(data['corpusJoins']), 'verifiedRoleTargetHashJoins': len(data['targetJoins']),
                   'historicalOutputPinsVerified': len(prior_validation['outputPins']),
                   'historicalInputPinsVerified': len(prior_pins) - 1, 'historicalRecipePin': recipe_gap,
                   'newEvidence': 'Russian final complete corpus bytes reconstructed in memory from immutable before27 after rows and matched exact owning hash; Chinese independent composite matches actual final immutable file; no target produced.',
                   'sourceAndTargetOmissions': {'nonemptyItemDescriptions': 48, 'compiledEmptyCellInputs': data['emptyInputs'],
                       'fourLocalesMissingImmutableFinalDelivery': ['es', 'es-419', 'pt-BR', 'ja'],
                       'sourceHolds': {'compiledStaticSeeds': [331, 332, 4948], 'databasePolicyExternal': 1655, 'rewiredAliases': 1389}},
                   'fictionalPreservation': data['fictional'],
                   'fontResourceNativeRuntimeVisualEditorial': 'not performed by phase150; no gate promoted',
                   'writes': 'Append-only receipt files are sequential, not a multi-file transaction. A partial write is not a complete receipt set.',
                   'usage': 'unknown; parent measures', 'nextAction': 'Owning source/corpus allocation and missing immutable deliveries; recover prior recipe. No unchanged automatic continuation.'})}
    PINS[str(Path(__file__).relative_to(ROOT))] = {'sha256': sha(Path(__file__).read_bytes()), 'bytes': Path(__file__).stat().st_size}
    outputs['phase150-input-pins.json'] = encoded(PINS)
    if args.recovered_recipe:
        verification = json.loads(outputs['phase150-verification.json'])
        verification.update(status='passed-data-reconciliation-and-original-recipe-recovery',
                            historicalInputPinsVerified=len(prior_pins),
                            nextAction='Owning source/corpus allocation and missing immutable deliveries. No unchanged automatic continuation.')
        outputs['phase150-verification.json'] = encoded(verification)
        outputs = {name.replace('phase150-', 'parent-recovery-', 1): content
                   for name, content in outputs.items()}
    for name, content in outputs.items():
        p = OUT / name
        if args.check:
            need(p.read_bytes() == content, 'reproduction-mismatch:' + name)
        else:
            need(not p.exists(), 'append-only-output-exists:' + name)
            p.write_bytes(content)
    print(json.dumps({'status': 'verified' if args.check else 'written', 'cells': 70,
                      'pins': len(PINS), 'negativeControls': len(tests['negativeControls']),
                      'corpusJoins': len(data['corpusJoins']), 'roleTargetJoins': len(data['targetJoins'])}))


if __name__ == '__main__':
    main()
