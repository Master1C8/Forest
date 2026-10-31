"""Apply reviewed Dates/bell and journal presentation through explicit locale data.

This is a resource-only adapter. It preserves the complete incoming candidate and
publishes through the common manifest-last publisher. No game code is executed.
"""
import argparse
import copy
import hashlib
import itertools
import json
from pathlib import Path
import sys


def need(value, reason):
    if not value:
        raise ValueError(reason)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def encode(value):
    return (json.dumps(value, ensure_ascii=False, sort_keys=True, indent=2) + '\n').encode()


def rows(path):
    return [json.loads(line) for line in path.read_text().splitlines() if line]


def get(tree, pointer):
    for key in pointer.strip('/').split('/'):
        tree = tree[key]
    return tree


def put(tree, pointer, value):
    keys = pointer.strip('/').split('/')
    for key in keys[:-1]:
        tree = tree[key]
    tree[keys[-1]] = copy.deepcopy(value)


def plan(trees, changes):
    """Exact full before trees, exact permitted properties, no substring matches."""
    need(len(changes) == len({r['pathId'] for r in changes}), 'duplicate-change')
    result = {}
    for row in changes:
        pid = row['pathId']
        need(trees[pid] == row['beforeTree'], 'before-tree:' + str(pid))
        target = copy.deepcopy(trees[pid])
        for pointer, value in row['replace'].items():
            need(get(target, pointer) != value, 'unchanged-replacement:' + str(pid) + pointer)
            put(target, pointer, value)
        result[pid] = target
    return result


def run(root, profile_path, output, mode):
    profile = json.loads(profile_path.read_bytes())
    need(profile['locale'] in {'zh', 'es', 'es-419', 'pt-BR', 'ja', 'de'}, 'explicit-locale')
    need(profile['culture'] and profile['schemaVersion'] == 1, 'explicit-culture-schema')
    need(sys.version == profile['python'] and digest(Path(sys.executable).read_bytes()) == profile['pythonExecutableSha256'], 'pinned-python')

    def pinned(pin):
        path = (root / pin['path']).resolve()
        need(path.is_relative_to(root), 'input-outside-project')
        need(digest(path.read_bytes()) == pin['sha256'], 'pin:' + pin['path'])
        return path

    for pin in profile['pins']:
        pinned(pin)
    engine = pinned(profile['engineManifest']).parent
    for name, sha in json.loads((engine / 'manifest.json').read_bytes())['files'].items():
        need(digest((engine / name).read_bytes()) == sha, 'engine-closure:' + name)
    sys.path[:0] = [str(engine / 'vendor'), str(engine / 'engine'), str(root / 'tools')]
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    from extract_assets import read_tree, canonical
    from russian_bio_input_case import bg_inventory, independent_inventory, module
    from russian_journal_layout import validate_targets
    from journal_header_ui import render
    from locale_resource_publish import publish

    base_path = pinned(profile['baseManifest'])
    base = json.loads(base_path.read_bytes())
    need(base['locale'] == profile['locale'], 'base-locale')
    files = {}
    for name, pin in base['outputs'].items():
        path = (base_path.parent / name).resolve()
        need(path.is_relative_to(base_path.parent), 'base-output-path')
        files[name] = path.read_bytes()
        need(len(files[name]) == pin['bytes'] and digest(files[name]) == pin['sha256'], 'base-file:' + name)
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(engine / 'source/Managed'))
    resource = 'sharedassets2.assets'
    env = UnityPy.load(files[resource]); env.path = str(engine / 'source')
    objects = env.file.objects
    original = {pid: obj.get_raw_data() for pid, obj in objects.items()}
    need(env.file.save() == files[resource], 'source-noop-roundtrip')
    recipe = json.loads(pinned(profile['plan']).read_bytes())
    need(recipe['locale'] == profile['locale'] and recipe['culture'] == profile['culture'], 'plan-locale')
    before = {row['pathId']: canonical(read_tree(objects[row['pathId']], generator)) for row in recipe['changes']}
    changes = plan(before, recipe['changes'])
    need(len(changes) == recipe['changedObjects'], 'exact-change-count')
    for pid, tree in changes.items():
        obj = objects[pid]
        nodes = None
        if obj.type.name == 'MonoBehaviour':
            script = obj.parse_monobehaviour_head().m_Script.deref().read()
            fullname = (script.m_Namespace + '.' if script.m_Namespace else '') + script.m_ClassName
            nodes = generator.cache.get(('forest-header-aligned:' + script.m_AssemblyName, fullname))
        obj.save_typetree(tree, nodes=nodes)
    data = env.file.save()
    back = UnityPy.load(data); back.path = str(engine / 'source')
    after = back.file.objects
    need(after.keys() == original.keys(), 'complete-object-id-set')
    changed = {pid for pid in original if original[pid] != after[pid].get_raw_data()}
    need(changed == set(changes), 'complete-changed-object-set')
    for pid, tree in changes.items():
        need(canonical(read_tree(after[pid], generator)) == tree, 'saved-tree:' + str(pid))
    actual_tree = lambda pid: canonical(read_tree(after[pid], generator))
    bell = json.loads(pinned(profile['bellContract']).read_bytes())
    bell_readback = []
    for family in bell['families']:
        title = profile['bellTitles'][family['color']]
        v = family['variants']
        for name, variant in v.items():
            need(actual_tree(variant['gameObject'])['m_IsActive'] == (name == 'Title (2)'), 'bell-activation:' + family['color'] + name)
        complete = v['Title (2)']
        need(all(actual_tree(pid)['m_text'] == title for pid in complete['layers']), 'bell-six-complete-layers')
        for pid in family['inheritedHeightRects']:
            t = actual_tree(pid)
            need((t['m_AnchorMin']['y'], t['m_AnchorMax']['y'], t['m_SizeDelta']['y']) == (0., 1., 0.), 'bell-preferred-height-inheritance')
        # The original fitter and full-title provider remain bound byte-exact.
        need(after[complete['fitter']].get_raw_data() == original[complete['fitter']], 'bell-fitter-preserved')
        bell_readback.append(dict(color=family['color'], title=title, provider=complete['provider'], fitter=complete['fitter'], layers=complete['layers'], inheritedHeightRects=family['inheritedHeightRects']))
    dates = rows(pinned(profile['dates']))
    need(len(dates) == 36, 'dates36')
    for row in dates:
        need(actual_tree(int(row['id'].split(':')[1].split('/')[0]))['m_text'] == row['target'], 'dates-actual-wording:' + row['id'])
    glossary = json.loads(pinned(profile['glossary']).read_bytes())
    header_inventory = json.loads(pinned(profile['headerInventory']).read_bytes())
    need(len(header_inventory['rows']) == 24, 'headers24')
    for row in header_inventory['rows']:
        need(actual_tree(row['pathId'])['m_text'] == render(row, glossary, profile['locale']), 'actual-header:' + row['id'])
    need(all(actual_tree(pid)['m_Enabled'] == 0 for pid in [18877, 18883]), 'legacy-heading-images-disabled')
    bg = UnityPy.load(files['resources.assets'])
    bg_data = read_tree(bg.file.objects[320], None)['m_Script'].encode('utf-8', errors='surrogateescape')
    codec = module(pinned(profile['bgCodec']), 'presentation_codec')
    peer = module(pinned(profile['bgPeer']), 'presentation_peer')
    envelope, states = bg_inventory(bg_data, codec)
    need(states == independent_inventory(bg_data, peer), 'independent51572-states')
    compact = rows(pinned(profile['compact']))
    need(len(compact) == 137, 'compact137')
    for row in compact:
        value = states[row['id']].decode() if row['id'].startswith('bgdb:') else actual_tree(int(row['id'].split(':')[1].split('/')[0]))['m_Text']
        need(value == row['target'], 'actual-compact-wording:' + row['id'])
    # Decode the actual existing BioDetail links and masks; this does not reopen
    # the accepted BG classification or execute its native unlock decisions.
    decoder = module(pinned(profile['bioDecoder']), 'presentation_bio_decoder')
    detail = decoder.sheet_decode(next(s for s in envelope['sheets'] if s['name'] == 'BioDetail'), bg_data)
    keywords = decoder.sheet_decode(next(s for s in envelope['sheets'] if s['name'] == 'BioKeyword'), bg_data)
    actors = decoder.sheet_decode(next(s for s in envelope['sheets'] if s['name'] == 'Actor'), bg_data)
    keyword = {r['id']: r['cells'] for r in keywords['rows']}
    actor = {r['id']: r['cells'] for r in actors['rows']}
    joins = []
    for row in detail['rows']:
        cells = row['cells']; parts = [keyword[cells[k]]['bio_text'] if cells[k] is not None else None for k in ('line1', 'line2', 'line3')]
        joins.append(dict(rowId=row['id'], actor=actor[cells['actor']]['name'], sourceLinks={k: cells[k] for k in ('line1', 'line2', 'line3')}, tags=cells['enable_with_tags'], isDefault=cells['is_default'], fullNameOverride=cells['full_name_override'], nameplateOverride=cells['nameplate_name_override'], displayParts=parts,
            allEightMaskOutputs=[dict(unlocked=list(flags), text='\n'.join((value if value is not None and flag else '???') for value, flag in zip(parts, flags))) for flags in itertools.product([False, True], repeat=3)], native='not-run'))
    young = [r for r in compact if r['source'] == 'Young Adult']; adult = [r for r in compact if r['source'] == 'Adult']
    need(len(young) == len(adult) == 1 and young[0]['target'] != adult[0]['target'], 'age-distinction')
    age_uses = [r for r in joins if r['displayParts'][1] == young[0]['target']]
    need({r['actor'] for r in age_uses} == {'Dustin', 'Mabel', 'Maverick'} and len(age_uses) == 3, 'actual-three-age-uses')
    font_env = UnityPy.load(files['sharedassets0.assets'])
    font = bytes(x % 256 for x in font_env.file.objects[369].read().m_FontData)
    fit = validate_targets(compact, font)
    # The original one-cell ??? + LF sentinel is intentional; it is not another
    # visible content line. Keep its bytes and classify it separately.
    for row, metrics in zip(compact, fit['rows']):
        if row['target'] == '???\n':
            metrics['intentionalMaskLF'] = True
            metrics['fits'] = metrics['metrics']['maxAdvance'] <= metrics['limit']
    fit['allFit'] = all(r['fits'] for r in fit['rows'])
    failed = [r['id'] for r in fit['rows'] if not r['fits']]
    need(set(failed) == set(profile['expectedPendingFitIds']), 'explicit-fit-findings')
    for pid in changes:
        after[pid].set_raw_data(original[pid])
    need(back.file.save() == files[resource], 'whole-container-reversal')
    files[resource] = data
    receipt = dict(locale=profile['locale'], culture=profile['culture'], changedObjects=sorted(changed), totalObjects=len(original), allUnselectedRawObjectsExact=True, completeSelectedTreeReadback=True, wholeContainerReversal=True, unchangedBGStates=len(states), actualBioDetailRows=len(joins), actualAgeUses=[r['rowId'] for r in age_uses], actualYoungAdult=young[0]['target'], actualAdult=adult[0]['target'], unchangedDatesFields=36, unchangedFinalNotebookHeaders=24, legacyHeaderImagesDisabled=True, unchangedManagedSha256=digest(files['Managed/Assembly-CSharp.dll']), native='not-run', runtime='not-run', package='not-run', ready=False)
    files['evidence/presentation-check.json'] = encode(receipt)
    files['evidence/presentation-joins.json'] = encode(joins)
    files['evidence/presentation-bells.json'] = encode(bell_readback)
    files['evidence/presentation-metrics.json'] = encode(fit)
    marker = dict(schemaVersion=1, kind='locale-owned-presentation-candidate', locale=profile['locale'], culture=profile['culture'], input=profile['baseManifest'], profile=dict(path=str(profile_path.relative_to(root)), sha256=digest(profile_path.read_bytes())), outputs={n: dict(sha256=digest(b), bytes=len(b)) for n, b in files.items()}, sourceCompanions=base['sourceCompanions'], unchangedPriorOutputs=[n for n in base['outputs'] if n != resource], semanticCoverageAdded=0, independentIntegrationReview='pending', pendingFitIds=failed, ready=False, applicationAllowed=False, native='not-run', runtime='not-run', package='not-run', publicationBoundary='Shared sequential publisher; manifest last, not a multi-file transaction.')

    def verify(out, manifest, payload):
        need(json.loads((out / 'manifest.json').read_bytes()) == manifest, 'published-manifest')
        need({str(p.relative_to(out)) for p in out.rglob('*') if p.is_file()} == set(payload) | {'manifest.json'}, 'exact-published-paths')
        for name, value in payload.items():
            need((out / name).read_bytes() == value, 'published-file:' + name)
        saved = UnityPy.load(str(out / resource)); saved.path = str(engine / 'source')
        need({pid for pid in original if original[pid] != saved.file.objects[pid].get_raw_data()} == changed, 'actual-disk-changed-objects')
        for pid, expected in changes.items():
            need(canonical(read_tree(saved.file.objects[pid], generator)) == expected, 'actual-disk-tree:' + str(pid))

    for pin in profile['pins']:
        pinned(pin)
    if mode == 'check':
        verify(output, marker, files)
    else:
        publish(files, output, root / profile['writePrefix'], marker, verify)
    return dict(passed=True, mode=mode, changedObjects=len(changed), unchangedBGStates=len(states), ageUses=len(age_uses), finalHeaders=24, pendingTargetFit=len(failed), ready=False)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('root', 'profile', 'output'):
        parser.add_argument('--' + name, type=Path, required=True)
    parser.add_argument('--mode', choices=['build', 'check'], required=True)
    args = parser.parse_args()
    print(json.dumps(run(args.root.resolve(), args.profile.resolve(), args.output.resolve(), args.mode)))
