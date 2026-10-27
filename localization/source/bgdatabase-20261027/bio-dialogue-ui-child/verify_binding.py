#!/usr/bin/env python3
"""Read one pinned original child, its GameObject and direct components only."""
import argparse
import hashlib
import json
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')


def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda: f.read(4 * 1024 * 1024), b''):
            h.update(b)
    return h.hexdigest()


def load(p):
    return json.loads(p.read_text())


def dump(p, data):
    p.write_text(json.dumps(data, indent=2, ensure_ascii=False) + '\n')


def verify(out):
    baseline = load(HERE / 'baseline.json')
    for category in ('inputs', 'frozenPins', 'owningHelpers', 'processReferences'):
        for name, expected in baseline[category].items():
            p = Path(name) if Path(name).is_absolute() else ROOT / name
            assert sha(p) == expected, (category, name)
    for name, expected in baseline['installedSources'].items():
        assert sha(DATA / name) == expected, name
    pins = load(ROOT / 'localization/source/bgdatabase-20261027/bio-prepare-bindings/binding-pins.json')
    for name, expected in pins.items():
        assert sha(Path(name)) == expected, name
    dlls = [Path(p) for p in pins if Path(p).parent == DATA / 'Managed' and p.endswith('.dll')]
    assert len(dlls) == 150
    assert {p.name for p in dlls} == {p.name for p in (DATA / 'Managed').glob('*.dll')}
    for name, archive in [('README.md', 'previous-summary.md'), ('CHECKPOINT.json', 'previous-checkpoint.json')]:
        assert sha(HERE / archive) == baseline['summaryPins'][name], archive

    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    sys.path.insert(0, str(ROOT / 'tools'))
    from extract_assets import canonical, read_tree
    inv = load(ROOT / 'assets/source-v2/objects.json')
    env = UnityPy.load(str(DATA / 'sharedassets0.assets'))
    gen = TypeTreeGenerator('2020.3.24f1')
    gen.load_local_dll_folder(str(DATA / 'Managed'))
    script_rows = {}

    def inventory(asset, pid):
        matches = [r for r in inv if r['asset'] == asset and r['pathId'] == pid]
        assert len(matches) == 1, (asset, pid, 'unique inventory identity')
        return matches[0]

    def read_object(obj):
        item = inventory(obj.assets_file.name, obj.path_id)
        raw = obj.get_raw_data()
        assert len(raw) == item['bytes']
        assert hashlib.sha256(raw).hexdigest() == item['rawSha256']
        assert obj.type.name == item['type']
        tree = canonical(read_tree(obj, gen))
        row = dict(inventory=item, rawBytes=len(raw), rawSha256=hashlib.sha256(raw).hexdigest(), decoded=tree)
        if 'tree' in item:
            exported = ROOT / 'assets/source-v2' / item['tree']
            assert sha(exported) == item['treeSha256']
            assert tree == load(exported), ('whole-export-parity', item['id'])
            row['completeExportParity'] = True
        else:
            row['completeExportParity'] = None
            row['exportLimit'] = 'No frozen tree export; exact original raw identity and native structure only.'
        return row

    def local(ptr):
        assert ptr['m_FileID'] == 0 and ptr['m_PathID'] != 0, ptr
        objects = [o for o in env.objects if o.assets_file.name == 'sharedassets0.assets' and o.path_id == ptr['m_PathID']]
        assert len(objects) == 1, ptr
        return objects[0]

    prior = ROOT / 'localization/source/bgdatabase-20261027/bio-dialogue-ui-binding'
    next_pin = load(prior / 'metadata-readback/next-consumer.json')
    assert next_pin['reference'] == dict(m_FileID=0, m_PathID=2447)
    child_obj = local(next_pin['reference'])
    child = read_object(child_obj)
    assert child['inventory'] == next_pin['inventory']
    assert child['inventory']['type'] == 'RectTransform'
    assert child['decoded']['m_Father'] == dict(m_FileID=0, m_PathID=2454)
    game_ptr = child['decoded']['m_GameObject']
    game_obj = local(game_ptr)
    game = read_object(game_obj)
    assert game['inventory']['type'] == 'GameObject'
    components = game['decoded']['m_Component']
    assert 2 <= len(components) <= 16, 'Bounded direct component scope; never follow descendants'
    pointers = [r['component'] for r in components]
    assert pointers.count(next_pin['reference']) == 1
    assert len({(p['m_FileID'], p['m_PathID']) for p in pointers}) == len(pointers)
    rows = [child, game]
    for ptr in pointers:
        if ptr == next_pin['reference']:
            continue
        obj = local(ptr)
        row = read_object(obj)
        assert row['decoded']['m_GameObject'] == game_ptr
        if obj.type.name == 'MonoBehaviour':
            script_obj = obj.parse_monobehaviour_head().m_Script.deref()
            script = read_object(script_obj)
            tree = script['decoded']
            qualified = (tree['m_Namespace'] + '.' if tree['m_Namespace'] else '') + tree['m_ClassName']
            assert qualified == row['inventory']['class']
            assert tree['m_AssemblyName'] == row['inventory']['assembly']
            script_ptr = row['decoded']['m_Script']
            assert script_ptr['m_FileID'] == 1 and script_ptr['m_PathID'] == script_obj.path_id
            ext = obj.assets_file.externals[script_ptr['m_FileID'] - 1]
            assert Path(ext.path).name == script_obj.assets_file.name == 'globalgamemanagers.assets'
            assert script_obj.assets_file.name in baseline['installedSources']
            row['scriptResolution'] = dict(reference=script_ptr,
                external=dict(path=ext.path, guid=ext.guid.hex(), type=ext.type),
                targetId=script['inventory']['id'], declaredType=qualified, assembly=tree['m_AssemblyName'])
            script_rows[script['inventory']['id']] = script
        rows.append(row)
    # No child pointers other than the assigned2447 or component field references are dereferenced.
    dump(out / 'child-ui-binding.json', dict(
        fromObject=next_pin['fromObject'], sourceField=next_pin['sourceField'], reference=next_pin['reference'],
        directGameObject=game_ptr, directComponentPointers=pointers, objects=rows,
        monoScripts=list(script_rows.values()),
        mapping='UI/component pointers fileID0 -> same sharedassets0.assets; exact MonoScript fileID1 -> globalgamemanagers.assets.',
        limits='Original stored pointers/types, no runtime cache, native search, prefab instantiation, active state, lifecycle or rendering established. Descendant transforms/field targets not read.'))
    dump(out / 'verification.json', dict(status='passed-static-scoped',
        directObjectsRead=len(rows), directRawBytes=sum(r['rawBytes'] for r in rows),
        directComponents=len(components),
        completeExportParityObjects=sum(r['completeExportParity'] is True for r in rows),
        nativeObjectsWithoutFrozenExport=sum(r['completeExportParity'] is None for r in rows),
        directMonoScriptsRead=len(script_rows),
        frozenPinsUnchanged=len(baseline['frozenPins']), helpersChecked=len(baseline['owningHelpers']),
        installedResourcesChecked=len(baseline['installedSources']), metadataDllsPinned=len(dlls),
        pinnedPriorEvidenceFilesChecked=len(baseline['inputs']),
        previousMetadataTraces='Retained by hashes; not replayed',
        gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0, gitMutations=0,
        authoredTranslations=0, sourceAcceptance='needs-review', editorial='not-run', runtime='not-run', visual='not-run', delivery='needs-review', usage=None))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    out = args.output.resolve()
    assert HERE in out.parents and not out.exists(), 'New output inside this supplement required'
    out.mkdir()
    verify(out)
