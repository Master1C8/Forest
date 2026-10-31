"""Compose an exact sparse static payload and audit its physical selections.

No linguistic judgments, game execution, installation, or source modification.
The existing shared publisher owns sequential manifest-last publication.
"""
import argparse
import base64
import collections
import hashlib
import json
from pathlib import Path
import re
import shutil
import sys


def need(value, reason):
    if not value:
        raise ValueError(reason)


def sha(data):
    return hashlib.sha256(data).hexdigest()


def read(path):
    return json.loads(path.read_bytes())


def rows(path):
    return [json.loads(line) for line in path.read_text().splitlines() if line]


def encoded(value):
    return (json.dumps(value, ensure_ascii=True, sort_keys=True, indent=2) + '\n').encode()


def linebytes(values):
    return b''.join((json.dumps(v, ensure_ascii=True, sort_keys=True) + '\n').encode() for v in values)


def valuehash(value):
    return sha(value.encode()) if isinstance(value, str) else sha(encoded(value))


def child(root, name):
    path = (root / name).resolve()
    need(not Path(name).is_absolute() and path.is_relative_to(root), 'contained-path:' + name)
    return path


def pointer(tree, path):
    for bit in path.strip('/').split('/'):
        bit = bit.replace('~1', '/').replace('~0', '~')
        tree = tree[int(bit)] if isinstance(tree, list) else tree[bit]
    return tree


def run(root, profile_path, output, mode):
    root, profile_path, output = root.resolve(), profile_path.resolve(), output.resolve()
    profile = read(profile_path)
    need(profile['locale'] == 'de' and profile['culture'] == 'de-DE', 'explicit-German-locale')
    need(sys.version == profile['python'] and sha(Path(sys.executable).read_bytes()) == profile['pythonExecutableSha256'], 'pinned-python')
    pins = {}
    for pin in profile['pins']:
        path = child(root, pin['path'])
        need(sha(path.read_bytes()) == pin['sha256'], 'pin:' + pin['path'])
        pins[pin['path']] = path

    def pinned(name):
        need(name in pins, 'undeclared-input:' + name)
        return pins[name]

    candidate_path = pinned(profile['candidate'])
    candidate = read(candidate_path)
    need(candidate['locale'] == 'de', 'candidate-locale')
    payload, saved_evidence = {}, []
    for name, binding in candidate['outputs'].items():
        path = child(candidate_path.parent, name)
        data = path.read_bytes()
        need(len(data) == binding['bytes'] and sha(data) == binding['sha256'], 'actual-candidate:' + name)
        if name.startswith('evidence/'):
            saved_evidence.append(dict(path=str(path.relative_to(root)), **binding))
        else:
            payload[name] = data
    need(set(payload) == set(profile['incomingPayloadMembers']) and len(payload) == 10, 'exact-ten-incoming-payload-members')
    need('level23' not in payload, 'held-level23-no-override')
    repaired = read(pinned(profile['managedRepairReceipt']))
    repaired_bytes = pinned(profile['managedRepairAssembly']).read_bytes()
    need(repaired['passed'] is True and repaired['locale'] == 'de'
         and repaired['sourceSha256'] == sha(payload['Managed/Assembly-CSharp.dll'])
         and repaired['outputSha256'] == sha(repaired_bytes)
         and repaired['selectedStrings'] == 9 and repaired['glitchHook'] is False
         and repaired['completeTreeReadback'] is True
         and repaired['completeOriginalSemanticTreeRestored'] is True
         and repaired['sourceStackHeaderNormalizations'] == [], 'exact-nine-managed-repair')
    payload['Managed/Assembly-CSharp.dll'] = repaired_bytes
    inspected = read(pinned(profile['managedInspection']))
    need(inspected['sha256'] == sha(repaired_bytes), 'actual-managed-inspection')
    inspected_methods = {r['method']: r for r in inspected['methods']}
    repair_request = read(pinned(profile['managedRepairRequest']))
    primary_receipts = rows(pinned(profile['managedPrimaryReceipts']))
    need(len(primary_receipts) == 9, 'nine-primary-receipts')
    for row in repair_request['rows']:
        receipt = next(r for r in primary_receipts if r['id'] == row['id'])
        original_rows = rows(pinned(receipt['receipt']['path']))
        need(any(r['id'] == row['id'] and r.get('sourceSha256') == row['sourceSha256']
                 and r.get('targetSha256') == row['targetSha256'] and r.get('verdict') in {'pass', 'clean'}
                 and r.get('reviewed') is not False and not r.get('pendingSemanticReview') for r in original_rows), 'exact-original-primary-pass:' + row['id'])
        literal = next(r for r in inspected_methods[row['method']]['literals'] if r['offset'] == row['offset'])
        need(literal['instructionIndex'] == row['instructionIndex'] and literal['source'] == row['target'], 'actual-repaired-operand:' + row['id'])
    delta_path = pinned(profile['nativeDelta'])
    delta = read(delta_path)
    recipe_path = pinned(profile['nativeRecipe'])
    need(delta['locale'] == 'de' and delta['frozenRecipeSha256'] == sha(recipe_path.read_bytes()), 'native-delta-recipe')
    for name, digest in read(recipe_path)['files'].items():
        need(sha(child(recipe_path.parent, name).read_bytes()) == digest, 'native-recipe-closure:' + name)
    delta_readback = read(delta_path.parent / 'readback.json')
    native_plan = read(pinned(profile['nativePlan']))
    need(len(native_plan['edits']) == 31 and native_plan['locale'] == 'de', 'native-delta31')
    native_primary = rows(pinned(profile['nativePrimaryReceipts']))
    need(len(native_primary) == 31, 'native-primary31')
    for row in native_plan['edits']:
        receipt = next(r for r in native_primary if r['id'] == row['id'])
        need(any(r['id'] == row['id'] and r.get('sourceSha256') == row['sourceSha256']
                 and r.get('targetSha256') == row['targetSha256'] and r.get('verdict') in {'pass','clean'}
                 and r.get('reviewed') is not False and not r.get('pendingSemanticReview')
                 for r in rows(pinned(receipt['receipt']['path']))), 'native-exact-primary:' + row['id'])
    native_inputs = {}
    for name, binding in delta['outputs'].items():
        path = child(delta_path.parent, name); data = path.read_bytes()
        need(sha(data) == binding['sha256'] and len(data) == binding['bytes'], 'actual-native-delta:' + name)
        if name == 'readback.json':
            continue
        before_path = recipe_path.parent / 'source' / name
        before = before_path.read_bytes()
        if name in payload:
            need(before == payload[name], 'native-incoming-candidate:' + name)
        else:
            need(name == 'sharedassets15.assets', 'only-new-native-member')
        proof = next(r for r in delta_readback['resources'] if r.get('installPath') == 'The Forest of Love_Data/' + name)
        need(proof['sourceSha256'] == sha(before) and proof['targetSha256'] == sha(data)
             and proof['unselectedRawEqual'] is True and proof['externalResourceBindingsEqual'] is True
             and proof['originalCompressionAndCABPreserved'] is True, 'native-actual-readback:' + name)
        native_inputs[name] = before
        payload[name] = data
    need(set(payload) == set(profile['payloadMembers']) and len(payload) == 11, 'exact-eleven-final-members')
    source_manifest = read(pinned(profile['sourceManifest']))
    source_root = Path(profile['sourceRoot']).resolve()
    companions = {}
    for name, binding in candidate['sourceCompanions'].items():
        need(source_manifest[name] == binding, 'source-manifest-companion:' + name)
        path = child(source_root, name)
        need(path.stat().st_size == binding['bytes'] and sha(path.read_bytes()) == binding['sha256'], 'actual-source-companion:' + name)
        companions[name] = dict(path=str(path), **binding, action='retain-original;not-an-override')

    # Load the pinned source engine, never the owner's installed/running game.
    engine_manifest = pinned(profile['engineManifest'])
    engine = engine_manifest.parent
    for name, digest in read(engine_manifest)['files'].items():
        need(sha(child(engine, name).read_bytes()) == digest, 'engine-closure:' + name)
    sys.path[:0] = [str(engine / 'vendor'), str(engine / 'engine'), str(root / 'tools')]
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    from extract_assets import read_tree
    from locale_resource_publish import publish
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(engine / 'source/Managed'))
    objects, tree_cache, base_bindings = {}, {}, {}

    def tree(asset, pid):
        if asset not in objects:
            if asset in payload:
                env = UnityPy.load(payload[asset])
            else:
                path = child(source_root, asset)
                need(sha(path.read_bytes()) == source_manifest[asset]['sha256'], 'original-base:' + asset)
                base_bindings[asset] = dict(path=str(path), **source_manifest[asset], action='retain-original;not-an-override')
                env = UnityPy.load(str(path))
            env.path = str(engine / 'source')
            group = list(env.objects)
            need(len(group) == len({o.path_id for o in group}), 'unique-container-ids:' + asset)
            objects[asset] = (env, {o.path_id: o for o in group})
        key = asset, pid
        if key not in tree_cache:
            tree_cache[key] = read_tree(objects[asset][1][pid], generator)
        return tree_cache[key]

    def physical(key):
        match = re.fullmatch(r'(.+):(-?\d+)(/.*)', key)
        need(match is not None, 'physical-selector:' + key)
        asset, pid, ptr = match.groups()
        asset = profile.get('resourceAliases', {}).get(asset, asset)
        if '!/' in asset:
            asset, cab = asset.split('!/', 1)
            tree(asset, int(pid))
            need(cab in objects[asset][0].file.files, 'CAB-member:' + cab)
            need(objects[asset][1][int(pid)].assets_file.name == cab, 'CAB-object-owner')
        return pointer(tree(asset, int(pid)), ptr), asset

    # Reuse the accepted complete independently decoded BG state ledger. Its
    # actual resource hash is bound by the accepted candidate and compact check.
    bg = {r['id']: None if r['after'] is None else base64.b64decode(r['after']) for r in rows(pinned(profile['bgLedger']))}
    need(len(bg) == 51572, 'complete-BG-ledger')
    plan = read(pinned(profile['plan']))
    expected = {}
    for edit in plan['edits']:
        key = edit['id']
        if edit['kind'] == 'bg':
            value, asset = bg[key], 'resources.assets'
            need(value == edit['target'].encode() or key in profile['supersededBGIds'], 'selected-BG-target:' + key)
        else:
            value, asset = pointer(tree(edit['asset'], edit['pathId']), edit['pointer']), edit['asset']
            if key not in profile['supersededFieldIds']:
                need(value == edit['target'], 'selected-field-target:' + key)
        expected[key] = edit
    # New final compact versions are authoritative over their exact old versions.
    compact = rows(pinned(profile['compact']))
    for row in compact:
        if row['id'].startswith('bgdb:'):
            need(bg[row['id']] == row['target'].encode(), 'compact-BG:' + row['id'])
        else:
            need(physical(row['id'])[0] == row['target'], 'compact-native:' + row['id'])
    for row in read(pinned(profile['presentation']))['changes']:
        for ptr, value in row['replace'].items():
            key = 'sharedassets2.assets:' + str(row['pathId']) + ptr
            if key not in profile['supersededPresentationIds']:
                need(pointer(tree('sharedassets2.assets', row['pathId']), ptr) == value, 'presentation-value:' + key)
    native_reversals = []
    for asset, before in native_inputs.items():
        source_env = UnityPy.load(before)
        final_env = UnityPy.load(payload[asset])
        source_objects, final_objects = source_env.file.objects, final_env.file.objects
        need(source_objects.keys() == final_objects.keys(), 'native-whole-object-ids')
        selected_ids = {r['pathId'] for r in native_plan['edits'] if r['asset'] == asset}
        for row in native_plan['edits']:
            if row['asset'] == asset:
                need(pointer(tree(asset, row['pathId']), row['pointer']) == row['target'], 'actual-native-target:' + row['id'])
        for pid, obj in source_objects.items():
            if pid not in selected_ids:
                need(obj.get_raw_data() == final_objects[pid].get_raw_data(), 'native-unselected-raw')
            else:
                final_objects[pid].set_raw_data(obj.get_raw_data())
        need(final_env.file.save() == before, 'native-whole-container-reversal:' + asset)
        native_reversals.append(asset)

    # Exact physical readback for family membership. This reports differences;
    # equality is application evidence only and never a semantic pass.
    ledger = rows(pinned(profile['versionLedger']))
    disposition = {r['id']: r for r in read(pinned(profile['selectorDispositions']))}
    managed = {r['id']: r for name in profile['managedRequests'] for r in read(pinned(name))['rows']}
    source_dialogue = {r['id']: r for r in rows(pinned(profile['sourceDialogue']))}
    # The old receipt index lists only29 counter wordings. Account separately
    # for every protected source membership; never silently shrink90 to29.
    existing_counter = {r['id'] for r in ledger if r['family'] == 'counter90'}
    counter_source = rows(pinned(profile['counterSource']))
    need(len(counter_source) == 90, 'complete-counter90-source')
    ledger += [dict(family='counter90', id=r['id'], version=None, wording=None)
               for r in counter_source if r['id'] not in existing_counter]
    memberships = []
    for row in ledger:
        key, family = row['id'], row['family']
        wording = row['wording']
        state, artifact, current = 'unresolved', None, None
        if key.startswith('ds:'):
            source = source_dialogue[key]
            values = [physical(k) for k in source['occurrences']]
            need(len(values) == 2 and values[0][0] == values[1][0], 'dialogue-dual-copy:' + key)
            current, artifact = values[0]
            state = 'current-physical-dialogue'
        elif key.startswith('bgdb:'):
            current, artifact = (None if bg[key] is None else bg[key].decode()), 'resources.assets'
            state = 'current-BG-ledger'
        elif key.startswith('il:'):
            if key in managed:
                current, artifact, state = managed[key]['target'], 'Managed/Assembly-CSharp.dll', 'accepted-managed-request-chain'
            else:
                method, offset = key.removeprefix('il:Assembly-CSharp.dll/').rsplit('/IL_', 1)
                literal = next(r for r in inspected_methods[method]['literals'] if r['offset'] == int(offset, 16))
                current, state, artifact = literal['source'], 'current-managed-retained-operand', 'Managed/Assembly-CSharp.dll'
                source_value = wording['source'] if wording is not None else next(r['source'] for r in counter_source if r['id'] == key)
                need(current == source_value, 'retained-managed-source:' + key)
        elif key.startswith('speaker-display:'):
            state, artifact = 'accepted-display-helper-chain', 'Managed/VNRevivalLocaleDisplay.dll'
        elif family == 'special-cases23':
            state = 'accepted-case-disposition-with-held-predicates'
        else:
            current, artifact = physical(key)
            state = 'current-physical-field'
        record = dict(family=family, id=key, version=row['version'], evidenceState=state, artifact=artifact,
                      actualValueSha256=valuehash(current) if state.startswith('current-') or key in managed else None,
                      oldReviewedTargetMatches=(current == wording['target']) if wording is not None and (state.startswith('current-') or key in managed) else None,
                      existingDisposition=disposition.get(key), semanticCoverageAdded=0)
        if wording is not None and record['oldReviewedTargetMatches'] is False:
            record['reviewedTargetSha256'] = valuehash(wording['target'])
        memberships.append(record)

    baseline_comparisons, baseline_objects = [], {}
    for record in memberships:
        if record['oldReviewedTargetMatches'] is not False or (record['existingDisposition'] or {}).get('reason') != 'missing-accepted-baseline-selection-binding':
            continue
        asset, pid, ptr = re.fullmatch(r'(.+):(-?\d+)(/.*)', record['id']).groups()
        binding = profile['baselineResources'].get(asset)
        if binding is None:
            baseline_comparisons.append(dict(family=record['family'], id=record['id'], status='no-baseline-override;retain-source-and-conditional-producer-binding'))
            continue
        if asset not in baseline_objects:
            path = pinned(binding)
            env = UnityPy.load(str(path)); env.path = str(path.parent)
            baseline_objects[asset] = {o.path_id:o for o in env.objects}
        value = pointer(read_tree(baseline_objects[asset][int(pid)], generator), ptr)
        source = next(r['wording']['source'] for r in ledger if r['family'] == record['family'] and r['id'] == record['id'])
        baseline_comparisons.append(dict(family=record['family'], id=record['id'], baseline=binding,
            baselineValueSha256=valuehash(value), baselineEqualsSource=value == source,
            status='baseline-retains-original' if value == source else 'concrete-missing-target-selection'))

    # Original sparse resources remain original, including held source fields.
    check = dict(passed=True, locale='de', culture='de-DE', payloadMembers=len(payload), savedEvidenceFiles=len(saved_evidence),
                 verifiedSelectedFields=len(plan['edits']), newlyAppliedNativeFields=31, newlyAppliedManagedOperands=9,
                 nativeContainerReversals=native_reversals, actualCompactValues=len(compact), presentationObjects=77,
                 sourceCompanions=len(companions), baseResources=base_bindings, membershipRows=len(memberships),
                 membershipStates=dict(collections.Counter(r['evidenceState'] for r in memberships)),
                 ready=False, native='not-run', runtime='not-run', installer='not-run', semanticCoverageAdded=0)
    evidence_output = child(root, profile['evidenceOutput'])
    evidence_files = {'physical-check.json': encoded(check), 'family-memberships.jsonl': linebytes(memberships),
                      'source-companions.json': encoded(companions), 'baseline-comparisons.json': encoded(baseline_comparisons)}
    if mode == 'audit':
        evidence_output.mkdir(parents=True, exist_ok=True)
        for name, data in evidence_files.items():
            path = evidence_output / name
            need(not path.exists() or path.read_bytes() == data, 'immutable-audit-output:' + name)
            path.write_bytes(data)
        return check
    need(mode in {'build', 'resume', 'check'}, 'mode')
    for name, data in evidence_files.items():
        need((evidence_output / name).read_bytes() == data, 'audit-binding:' + name)
    marker = dict(schemaVersion=1, kind='German-final-sparse-static-payload', locale='de', culture='de-DE',
                  input=dict(path=profile['candidate'], sha256=sha(candidate_path.read_bytes())),
                  profile=dict(path=str(profile_path.relative_to(root)), sha256=sha(profile_path.read_bytes())),
                  installRoot='The Forest of Love_Data', outputs={n: dict(bytes=len(b), sha256=sha(b)) for n,b in payload.items()},
                  evidence=saved_evidence, sourceCompanions=companions, retainedOriginalBase=base_bindings,
                  ready=False, applicationAllowed=False, native='not-run', runtime='not-run', installer='not-run',
                  semanticCoverageAdded=0, publicationBoundary='Sequential manifest-last static publication; no installation transaction.')

    def verify(out, expected_marker, content):
        need(read(out / 'manifest.json') == expected_marker, 'published-marker')
        need({str(p.relative_to(out)) for p in out.rglob('*') if p.is_file()} == set(content) | {'manifest.json'}, 'exact-payload-paths')
        for name, data in content.items():
            need(child(out, name).read_bytes() == data, 'published-bytes:' + name)
    if mode == 'check':
        verify(output, marker, payload)
    else:
        need(shutil.disk_usage(root).free - sum(map(len, payload.values())) >= 5*1024**3, 'five-GiB-reserve')
        publish(payload, output, child(root, profile['writePrefix']), marker, verify, resume=mode == 'resume')
    return dict(check, manifest=str((output / 'manifest.json').relative_to(root)), manifestSha256=sha((output / 'manifest.json').read_bytes()))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['root', 'profile', 'output']:
        parser.add_argument('--' + name, type=Path, required=True)
    parser.add_argument('--mode', choices=['audit', 'build', 'resume', 'check'], required=True)
    args = parser.parse_args()
    print(json.dumps(run(args.root, args.profile, args.output, args.mode)))
