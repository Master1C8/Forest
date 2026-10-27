#!/usr/bin/env python3
"""Bounded original-byte UI binding verification. No game code is executed."""
import argparse
import hashlib
import json
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
PIDS = (744, 2454, 2220, 3796, 3797, 4193, 4110)


def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda: f.read(4 * 1024 * 1024), b''):
            h.update(b)
    return h.hexdigest()


def load(p):
    return json.loads(p.read_text())


def dump(p, x):
    p.write_text(json.dumps(x, indent=2, ensure_ascii=False) + '\n')


def verify(out):
    b = load(HERE / 'baseline.json')
    for category in ('inputs', 'frozenPins', 'owningHelpers', 'processReferences'):
        for name, expected in b[category].items():
            p = Path(name) if Path(name).is_absolute() else ROOT / name
            assert sha(p) == expected, (category, name)
    for name, expected in b['installedSources'].items():
        assert sha(DATA / name) == expected, name
    pins = load(ROOT / 'localization/source/bgdatabase-20261027/bio-prepare-bindings/binding-pins.json')
    for name, expected in pins.items():
        assert sha(Path(name)) == expected, name
    dlls = [Path(p) for p in pins if Path(p).parent == DATA / 'Managed' and p.endswith('.dll')]
    assert len(dlls) == 150
    assert {p.name for p in dlls} == {p.name for p in (DATA / 'Managed').glob('*.dll')}
    for name, archive in [('README.md', 'previous-summary.md'), ('CHECKPOINT.json', 'previous-checkpoint.json')]:
        assert sha(HERE / archive) == b['summaryPins'][name], archive

    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    sys.path.insert(0, str(ROOT / 'tools'))
    from extract_assets import read_tree, canonical
    inv = load(ROOT / 'assets/source-v2/objects.json')
    env = UnityPy.load(str(DATA / 'sharedassets0.assets'))
    gen = TypeTreeGenerator('2020.3.24f1')
    gen.load_local_dll_folder(str(DATA / 'Managed'))
    rows = []
    for pid in PIDS:
        matches = [o for o in inv if o['asset'] == 'sharedassets0.assets' and o['pathId'] == pid]
        assert len(matches) == 1, ('inventory', pid)
        item = matches[0]
        objects = [o for o in env.objects if o.path_id == pid and o.assets_file.name == 'sharedassets0.assets']
        assert len(objects) == 1, ('original', pid)
        obj = objects[0]
        raw = obj.get_raw_data()
        assert len(raw) == item['bytes']
        assert hashlib.sha256(raw).hexdigest() == item['rawSha256']
        assert obj.type.name == item['type']
        tree = canonical(read_tree(obj, gen))
        row = dict(inventory=item, rawBytes=len(raw), rawSha256=hashlib.sha256(raw).hexdigest(), decoded=tree)
        if 'tree' in item:
            p = ROOT / 'assets/source-v2' / item['tree']
            assert sha(p) == item['treeSha256']
            assert tree == load(p), ('whole-export-parity', pid)
            row['completeExportParity'] = True
        else:
            row['completeExportParity'] = None
            row['exportLimit'] = 'No frozen tree export; raw identity/byte count and native read_tree structure verified.'
        if pid == 744:
            assert tree['m_Name'] == 'OverworldDialogueCanvas'
            assert tree['m_Component'] == [dict(component=dict(m_FileID=0, m_PathID=p)) for p in PIDS[1:]]
        else:
            assert tree['m_GameObject'] == dict(m_FileID=0, m_PathID=744)
        if obj.type.name == 'MonoBehaviour':
            head = obj.parse_monobehaviour_head()
            script_obj = head.m_Script.deref()
            script = canonical(read_tree(script_obj, gen))
            qualified = (script['m_Namespace'] + '.' if script['m_Namespace'] else '') + script['m_ClassName']
            assert qualified == item['class'] and script['m_AssemblyName'] == item['assembly']
            ptr = tree['m_Script']
            assert ptr['m_PathID'] != 0 and ptr['m_FileID'] == 1
            external = obj.assets_file.externals[ptr['m_FileID'] - 1]
            mapping = dict(path=external.path, guid=external.guid.hex(), type=external.type)
            assert Path(external.path).name == script_obj.assets_file.name == 'globalgamemanagers.assets'
            scripts = [o for o in inv if o['asset'] == script_obj.assets_file.name and o['pathId'] == ptr['m_PathID']]
            assert len(scripts) == 1
            script_item = scripts[0]
            script_raw = script_obj.get_raw_data()
            assert len(script_raw) == script_item['bytes']
            assert hashlib.sha256(script_raw).hexdigest() == script_item['rawSha256']
            script_export = ROOT / 'assets/source-v2' / script_item['tree']
            assert sha(script_export) == script_item['treeSha256']
            assert script == load(script_export), ('whole-script-export-parity', pid)
            row['scriptResolution'] = dict(reference=ptr, external=mapping,
                target=script_item, rawSha256=hashlib.sha256(script_raw).hexdigest(),
                decoded=script, declaredType=qualified, assembly=script['m_AssemblyName'])
        rows.append(row)
    dump(out / 'direct-ui-binding.json', dict(
        managerBinding='Reused phase89 original manager /displaySettings/dialogueUI (0,744), retained by hashes.',
        pointerMapping='All seven UI/component references use fileID0, same sharedassets0.assets; MonoScript fileID1 resolves globalgamemanagers.assets.',
        objects=rows,
        limits='Stored pointers/types only; no native instantiation, activation, component dispatch, text renderer or runtime selection inferred. RectTransform children retained as bytes/structure only, not dereferenced.'))
    dump(out / 'verification.json', dict(status='passed-static-scoped',
        directObjectsRead=len(rows), directRawBytes=sum(r['rawBytes'] for r in rows),
        completeExportParityObjects=sum(r.get('completeExportParity') is True for r in rows),
        nativeObjectsWithoutFrozenExport=sum(r.get('completeExportParity') is None for r in rows),
        directMonoScriptsRead=4, frozenPinsUnchanged=len(b['frozenPins']),
        helpersChecked=len(b['owningHelpers']), installedResourcesChecked=len(b['installedSources']),
        metadataDllsPinned=len(dlls), pinnedPriorEvidenceFilesChecked=len(b['inputs']),
        previousMetadataTraces='Retained by hashes, not rerun',
        gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0, gitMutations=0,
        authoredTranslations=0, sourceAcceptance='needs-review', editorial='not-run',
        runtime='not-run', visual='not-run', delivery='needs-review', usage=None))


if __name__ == '__main__':
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    out = args.output.resolve()
    assert HERE in out.parents and not out.exists(), 'New output inside this supplement required'
    out.mkdir()
    verify(out)
