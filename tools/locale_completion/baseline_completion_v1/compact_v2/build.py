"""Apply accepted compact wording to exact BG columns and one native caption.

Extends the immutable presentation_v1 candidate without changing its recipe.
All other objects and files retain their exact bytes. No game code is executed.
"""
import argparse
import base64
import copy
import hashlib
import json
from pathlib import Path
import sys
from urllib.parse import unquote


def need(value, reason):
    if not value:
        raise ValueError(reason)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def encode(value):
    # Full TextAsset trees contain losslessly decoded surrogateescape bytes.
    return (json.dumps(value, ensure_ascii=True, sort_keys=True, indent=2) + '\n').encode()


def jsonl(values):
    return b''.join((json.dumps(v, ensure_ascii=False, sort_keys=True) + '\n').encode() for v in values)


def rows(path):
    return [json.loads(line) for line in path.read_text().splitlines() if line]


def select_column(envelope, data, selected, codec, encode_cells, replace_columns):
    """Resolve complete stable IDs; never use source offsets or substring edits."""
    need(len(selected) == len({r['id'] for r in selected}), 'duplicate-selected-id')
    columns, originals, covered = [], {}, set()
    for sheet in envelope['sheets']:
        for field in sheet['fields']:
            matched = []
            for row in selected:
                parts = row['id'].split('/')
                need(len(parts) == 7 and parts[0] == 'bgdb:resources.assets:320'
                     and parts[1::2] == ['sheet', 'row', 'field'], 'bg-selector-shape')
                sid, rid, fid = map(unquote, parts[2::2])
                if sid == sheet['id'] and fid == field['id']:
                    need(sheet['name'] == 'BioKeyword' and field['name'] == 'bio_text', 'exact-display-column')
                    need(rid in sheet['rowIds'], 'exact-row-identity')
                    matched.append((sheet['rowIds'].index(rid), row))
            if not matched:
                continue
            blob = data[field['valuesOffset']:field['valuesOffset'] + field['valuesBytes']]
            cells, _ = codec.variable_cells(dict(field, valuesHex=blob.hex()), len(sheet['rowIds']))
            for index, row in matched:
                need(cells[index] == row['previousTarget'].encode(), 'exact-old-value:' + row['id'])
                need(row['previousTarget'] != row['target'], 'unchanged-target:' + row['id'])
                cells[index] = row['target'].encode()
                covered.add(row['id'])
            originals[(sheet['id'], field['id'])] = blob
            columns.append((field, encode_cells(blob, cells)))
    need(covered == {r['id'] for r in selected}, 'complete-selected-column-coverage')
    return replace_columns(data, columns), originals


def run(root, profile_path, output, mode):
    root, profile_path, output = root.resolve(), profile_path.resolve(), output.resolve()
    need(profile_path.is_relative_to(root), 'profile-outside-project')
    profile = json.loads(profile_path.read_bytes())
    need(profile['schemaVersion'] == 1 and profile['locale'] in {'de', 'zh', 'es', 'es-419', 'pt-BR', 'ja'}, 'explicit-locale')
    need(profile['culture'] and sys.version == profile['python']
         and digest(Path(sys.executable).read_bytes()) == profile['pythonExecutableSha256'], 'pinned-python-culture')

    def pinned(pin):
        path = (root / pin['path']).resolve()
        need(path.is_relative_to(root), 'pin-outside-project')
        need(digest(path.read_bytes()) == pin['sha256'], 'pin:' + pin['path'])
        return path

    # All cheap input checks precede Unity imports and engine loads.
    for pin in profile['pins']:
        pinned(pin)
    prior_profile = json.loads(pinned(profile['priorProfile']).read_bytes())
    need((prior_profile['locale'], prior_profile['culture']) == (profile['locale'], profile['culture']), 'prior-locale')
    for pin in prior_profile['pins']:
        pinned(pin)
    engine = pinned(prior_profile['engineManifest']).parent
    for name, sha in json.loads((engine / 'manifest.json').read_bytes())['files'].items():
        path = (engine / name).resolve()
        need(path.is_relative_to(engine) and digest(path.read_bytes()) == sha, 'engine-closure:' + name)
    base_path = pinned(profile['baseManifest'])
    base = json.loads(base_path.read_bytes())
    need(base['locale'] == profile['locale'] and base['profile'] == profile['priorProfile'], 'base-profile-locale')
    files = {}
    for name, pin in base['outputs'].items():
        path = (base_path.parent / name).resolve()
        need(path.is_relative_to(base_path.parent), 'base-path')
        files[name] = path.read_bytes()
        need(len(files[name]) == pin['bytes'] and digest(files[name]) == pin['sha256'], 'base-file:' + name)
    selected = rows(pinned(profile['wording']))
    compact = rows(pinned(profile['compact']))
    need(len(selected) == profile['selectedCount'] == 12 and len(compact) == 137, 'finite-counts')
    need(len({r['id'] for r in compact}) == len(compact), 'unique-compact-ids')
    review = {r['id']: r for r in rows(pinned(profile['reviews']))}
    compact_by_id = {r['id']: r for r in compact}
    for row in selected:
        need(compact_by_id[row['id']]['target'] == row['target'], 'compact-target-version')
        receipt = review[row['id']]
        need(receipt['verdict'] in {'pass', 'clean'} and receipt.get('reviewed') is not False, 'independent-accepted')
        for field in ['source', 'target']:
            need(receipt[field + 'Sha256'] == row[field + 'Sha256'] == digest(row[field].encode()), 'reviewed-version:' + field)
    sys.path[:0] = [str(engine / 'vendor'), str(engine / 'engine'), str(root / 'tools')]
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    from extract_assets import canonical, read_tree
    from russian_bio_input_case import bg_inventory, independent_inventory, module, encode_cells, replace_columns
    from russian_journal_layout import validate_targets
    from locale_resource_publish import publish
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(engine / 'source/Managed'))
    codec = module(pinned(prior_profile['bgCodec']), 'compact_codec')
    peer = module(pinned(prior_profile['bgPeer']), 'compact_peer')
    decoder = module(pinned(prior_profile['bioDecoder']), 'compact_bio_decoder')
    bg_rows = [r for r in selected if r['id'].startswith('bgdb:')]
    native_rows = [r for r in selected if not r['id'].startswith('bgdb:')]
    need(len(bg_rows) == 11 and len(native_rows) == 1 and native_rows[0]['id'] == 'sharedassets2.assets:14193/m_Text', 'selected-scope')
    environments, originals, targets, readbacks, object_ledger = {}, {}, {}, [], []
    for resource, pid in [('resources.assets', 320), ('sharedassets2.assets', 14193)]:
        env = UnityPy.load(files[resource]); env.path = str(engine / 'source')
        environments[resource] = env
        originals[resource] = {p: obj.get_raw_data() for p, obj in env.file.objects.items()}
        need(env.file.save() == files[resource], 'source-noop-roundtrip:' + resource)
        obj = env.file.objects[pid]
        before_tree = canonical(read_tree(obj, generator))
        target = copy.deepcopy(before_tree)
        if resource == 'resources.assets':
            old_bg = before_tree['m_Script'].encode('utf-8', errors='surrogateescape')
            before_env, before_states = bg_inventory(old_bg, codec)
            need(before_states == independent_inventory(old_bg, peer), 'independent-before51572')
            new_bg, old_columns = select_column(before_env, old_bg, bg_rows, codec, encode_cells, replace_columns)
            after_env, after_states = bg_inventory(new_bg, codec)
            need(after_states == independent_inventory(new_bg, peer), 'independent-after51572')
            need(before_states.keys() == after_states.keys(), 'bg-stable-id-set')
            changed_states = {k for k in before_states if before_states[k] != after_states[k]}
            need(changed_states == {r['id'] for r in bg_rows}, 'exact-eleven-state-delta')
            reverse = [(f, old_columns[(s['id'], f['id'])]) for s in after_env['sheets'] for f in s['fields'] if (s['id'], f['id']) in old_columns]
            need(replace_columns(new_bg, reverse) == old_bg, 'whole-bg-payload-reversal')
            target['m_Script'] = new_bg.decode('utf-8', errors='surrogateescape')
        else:
            row = native_rows[0]
            need(before_tree['m_Text'] == row['previousTarget'], 'exact-caption-old-value')
            target['m_Text'] = row['target']
        nodes = None
        if obj.type.name == 'MonoBehaviour':
            script = obj.parse_monobehaviour_head().m_Script.deref().read()
            fullname = (script.m_Namespace + '.' if script.m_Namespace else '') + script.m_ClassName
            nodes = generator.cache.get(('forest-header-aligned:' + script.m_AssemblyName, fullname))
        obj.save_typetree(target, nodes=nodes)
        data = env.file.save()
        saved = UnityPy.load(data); saved.path = str(engine / 'source')
        need(saved.file.objects.keys() == originals[resource].keys(), 'whole-object-id-set')
        changed_objects = {p for p, raw in originals[resource].items() if saved.file.objects[p].get_raw_data() != raw}
        need(changed_objects == {pid}, 'exact-one-object-delta:' + resource)
        need(canonical(read_tree(saved.file.objects[pid], generator)) == target, 'saved-full-tree:' + resource)
        for p, raw in originals[resource].items():
            object_ledger.append(dict(resource=resource, pathId=p, beforeSha256=digest(raw), afterSha256=digest(saved.file.objects[p].get_raw_data()), changed=p == pid))
        saved.file.objects[pid].set_raw_data(originals[resource][pid])
        need(saved.file.save() == files[resource], 'whole-container-reversal:' + resource)
        readbacks.append(dict(resource=resource, pathId=pid, beforeTree=before_tree, afterTree=target))
        targets[resource] = target
        files[resource] = data

    # Compare wording and metrics read back from the new actual resource bytes.
    actual_compact = []
    # Reload the completed serialized bytes: ObjectReader.read_typetree on an
    # edited source reader may still read its original input stream.
    native_env = UnityPy.load(files['sharedassets2.assets'])
    native_env.path = str(engine / 'source')
    for row in compact:
        actual = dict(row)
        if row['id'].startswith('bgdb:'):
            actual['target'] = after_states[row['id']].decode()
        else:
            pid = int(row['id'].split(':')[1].split('/')[0])
            actual['target'] = canonical(read_tree(native_env.file.objects[pid], generator))['m_Text']
        need(actual['target'] == row['target'], 'actual-compact-value:' + row['id'])
        actual_compact.append(actual)
    font_env = UnityPy.load(files['sharedassets0.assets'])
    font = bytes(x % 256 for x in font_env.file.objects[369].read().m_FontData)
    fit = validate_targets(actual_compact, font)
    for row, metrics in zip(actual_compact, fit['rows']):
        if row['target'] == '???\n':
            metrics['intentionalMaskLF'] = True
            metrics['fits'] = metrics['metrics']['maxAdvance'] <= metrics['limit']
    fit['allFit'] = all(r['fits'] for r in fit['rows'])
    need(fit['allFit'], 'actual-static-fit137')
    fit['fontDataSha256'] = digest(font)
    fit['fontResource'] = 'sharedassets0.assets:369'
    # Existing role properties and the entire native caption tree except wording
    # are byte-preserved by the complete object and full-tree comparisons above.
    for name in ['BioDetail', 'Actor']:
        old = next(s for s in before_env['sheets'] if s['name'] == name)
        new = next(s for s in after_env['sheets'] if s['name'] == name)
        need(decoder.sheet_decode(old, old_bg) == decoder.sheet_decode(new, new_bg), 'preserve-sheet:' + name)
    detail = decoder.sheet_decode(next(s for s in after_env['sheets'] if s['name'] == 'BioDetail'), new_bg)
    keywords = decoder.sheet_decode(next(s for s in after_env['sheets'] if s['name'] == 'BioKeyword'), new_bg)
    keyword = {r['id']: r['cells'] for r in keywords['rows']}
    joins = json.loads(files['evidence/presentation-joins.json'])
    need(len(detail['rows']) == len(joins) == 18, 'detail18')
    for row, join in zip(detail['rows'], joins):
        need(row['id'] == join['rowId'], 'join-row')
        parts = [keyword[row['cells'][k]]['bio_text'] if row['cells'][k] is not None else None for k in ['line1', 'line2', 'line3']]
        need(parts == join['displayParts'], 'unchanged-detail-parts')
        for mask in join['allEightMaskOutputs']:
            need(mask['text'] == '\n'.join(value if value is not None and flag else '???' for value, flag in zip(parts, mask['unlocked'])), 'mask-output')
    need(sum(len(j['allEightMaskOutputs']) for j in joins) == 144, 'masks144')
    need({j['actor'] for j in joins if j['displayParts'][1] == 'Im jungen Erwachsenenalter'} == {'Dustin', 'Mabel', 'Maverick'}, 'age-three-distinct-uses')
    unchanged_files = [name for name, pin in base['outputs'].items() if name not in targets]
    need(all(digest(files[name]) == base['outputs'][name]['sha256'] for name in unchanged_files), 'all-other-files-exact')
    receipt = dict(passed=True, locale=profile['locale'], culture=profile['culture'], comparedBGStates=51572,
        independentBeforeAndAfter=True, changedBGStates=sorted(changed_states), changedObjects={'resources.assets': [320], 'sharedassets2.assets': [14193]},
        completeSelectedTreeReadback=True, allUnselectedRawObjectsExact=True, wholeBGReversal=True, wholeContainerReversals=['resources.assets', 'sharedassets2.assets'],
        actualCompactRecords=137, allActualStaticRolesFit=True, unchangedBioDetailRows=18, unchangedMaskOutputs=144,
        unchangedPriorOutputs=unchanged_files, retainedPresentationReview=profile['reviews'], native='not-run', runtime='not-run', package='not-run', ready=False)
    ledger = [dict(id=k, before=None if v is None else base64.b64encode(v).decode(), after=None if after_states[k] is None else base64.b64encode(after_states[k]).decode(), changed=k in changed_states) for k, v in before_states.items()]
    files.update({'evidence/compact-check.json': encode(receipt), 'evidence/compact-metrics.json': encode(fit),
        'evidence/compact-values.jsonl': jsonl(actual_compact), 'evidence/compact-bg-states.jsonl': jsonl(ledger),
        'evidence/compact-object-hashes.jsonl': jsonl(object_ledger), 'evidence/compact-object-readbacks.json': encode(readbacks)})
    marker = dict(schemaVersion=1, kind='locale-owned-compact-candidate', locale=profile['locale'], culture=profile['culture'], input=profile['baseManifest'],
        profile=dict(path=str(profile_path.relative_to(root)), sha256=digest(profile_path.read_bytes())),
        outputs={n: dict(sha256=digest(b), bytes=len(b)) for n, b in files.items()}, sourceCompanions=base['sourceCompanions'],
        unchangedPriorOutputs=unchanged_files, semanticCoverageAdded=0, independentIntegrationReview='pending', pendingFitIds=[],
        ready=False, applicationAllowed=False, native='not-run', runtime='not-run', package='not-run',
        publicationBoundary='Shared sequential publisher; manifest last, not a multi-file transaction.')

    def verify(out, expected, payload):
        need(json.loads((out / 'manifest.json').read_bytes()) == expected, 'published-manifest')
        need({str(p.relative_to(out)) for p in out.rglob('*') if p.is_file()} == set(payload) | {'manifest.json'}, 'published-paths')
        for name, value in payload.items():
            need((out / name).read_bytes() == value, 'published-bytes:' + name)
        for resource, pid in [('resources.assets', 320), ('sharedassets2.assets', 14193)]:
            saved = UnityPy.load(str(out / resource)); saved.path = str(engine / 'source')
            need(saved.file.objects.keys() == originals[resource].keys(), 'disk-object-ids')
            need({p for p, raw in originals[resource].items() if saved.file.objects[p].get_raw_data() != raw} == {pid}, 'disk-raw-delta')
            need(canonical(read_tree(saved.file.objects[pid], generator)) == targets[resource], 'disk-full-tree')

    for pin in profile['pins']:
        pinned(pin)
    if mode == 'check':
        verify(output, marker, files)
    else:
        need(mode in {'build', 'resume'}, 'mode')
        publish(files, output, root / profile['writePrefix'], marker, verify, resume=mode == 'resume')
    return dict(passed=True, mode=mode, changedBGCells=11, changedNativeCaptions=1, actualCompactRecords=137, allFit=True, comparedBGStates=51572, ready=False)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['root', 'profile', 'output']:
        parser.add_argument('--' + name, type=Path, required=True)
    parser.add_argument('--mode', choices=['build', 'resume', 'check'], required=True)
    args = parser.parse_args()
    print(json.dumps(run(args.root, args.profile, args.output, args.mode)))
