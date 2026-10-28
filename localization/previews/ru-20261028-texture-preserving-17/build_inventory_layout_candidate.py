"""Create an isolated layout increment from a verified Russian candidate.

Reuses unchanged asset bytes. The canonical full builder also applies the same
snapshot/helper, so a later complete rebuild preserves this repair.
"""
import argparse
import copy
import ctypes
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import UnityPy
from russian_inventory_layout import snapshot, patch_layout
from russian_inventory_glitch import snapshot as snapshot_glitch, plan as glitch_plan, patch as patch_glitch, load_inputs as load_glitch_inputs

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
DATA = 'The Forest of Love_Data'


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def build(base, out, product, glitch_text=False):
    base, out = base.resolve(), out.resolve()
    assert base.parent == out.parent == ROOT / 'localization/previews' and not out.exists()
    assert re.fullmatch(r'ForestRuActual[0-9]{8}_[0-9]{2,}', product)
    baseline = json.loads((base / 'build.json').read_text())
    assert baseline['inventoryDisplayCompletion'] and 'inventoryLayoutCodeRepair' not in baseline
    assert json.loads((base / 'texture-preservation.json').read_text())['status'] == 'pass'
    for row in baseline['files']:
        assert sha(base / 'game' / DATA / row['path']) == row['probeSha256']
    assert not list((base / 'game').rglob('tfol.*'))
    if glitch_text:load_glitch_inputs()
    out.mkdir()
    shutil.copyfile(Path(__file__), out / Path(__file__).name)
    shutil.copyfile(Path(__file__).with_name('russian_inventory_layout.py'), out / 'russian_inventory_layout.py')
    shutil.copyfile(Path(__file__).with_name('russian_inventory_glitch.py'), out / 'russian_inventory_glitch.py')
    shutil.copyfile(base / 'build.json', out / 'base-build.json')
    # Immutable input snapshots required by the existing QA adapters.
    for name in ['inventory-description-targets.jsonl', 'inventory-description-acceptance.json', 'inventory-description-inputs.json']:
        shutil.copyfile(base / name, out / name)
    lib = ctypes.CDLL('/usr/lib/libSystem.B.dylib', use_errno=True)
    def clone(source, target):
        if lib.clonefile(os.fsencode(source), os.fsencode(target), 0):
            shutil.copy2(source, target)
        assert os.stat(source).st_ino != os.stat(target).st_ino
        return target
    shutil.copytree(base / 'game', out / 'game', copy_function=clone)
    data = out / 'game' / DATA
    before_assets = {r['path']: sha(data / r['path']) for r in baseline['files']}
    global_path = data / 'globalgamemanagers'
    env = UnityPy.load(str(global_path))
    objects = {o.path_id: o for o in env.objects}
    player = next(o for o in env.objects if o.type.name == 'PlayerSettings')
    original = player.read_typetree(); expected = copy.deepcopy(original)
    assert original['companyName'] == 'VNRevivalQA' and original['productName'] == baseline['saveIsolation']['productName']
    expected['productName'] = product
    raw = {pid: hashlib.sha256(o.get_raw_data()).hexdigest() for pid, o in objects.items() if pid != player.path_id}
    player.save_typetree(expected); global_path.write_bytes(next(iter(env.files.values())).save())
    readback = UnityPy.load(str(global_path)); got = {o.path_id: o for o in readback.objects}
    assert got[player.path_id].read_typetree() == expected
    assert all(hashlib.sha256(got[pid].get_raw_data()).hexdigest() == digest for pid, digest in raw.items())
    (data / 'app.info').write_text('VNRevivalQA\n' + product)
    snapshot(out, data / 'Managed')
    receipt = patch_layout(data / 'Managed', out, out / 'inventory-layout-code-readback.json')
    result = copy.deepcopy(baseline)
    result['saveIsolation']['productName'] = product
    result['inventoryLayoutCodeRepair'] = receipt
    if glitch_text:
        from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
        from extract_assets import read_tree,canonical
        snapshot_glitch(out)
        env=UnityPy.load(str(data/'sharedassets2.assets'));objects={o.path_id:o for o in env.objects}
        generator=TypeTreeGenerator('2020.3.24f1');generator.load_local_dll_folder(str(data/'Managed'))
        plans,projection=glitch_plan(objects,generator)
        unchanged_objects={pid:hashlib.sha256(o.get_raw_data()).hexdigest() for pid,o in objects.items() if pid not in plans}
        for pid,tree in plans.items():
            obj=objects[pid];script=obj.parse_monobehaviour_head().m_Script.deref().read();fullname=(script.m_Namespace+'.' if script.m_Namespace else '')+script.m_ClassName
            obj.save_typetree(tree,nodes=generator.cache.get(('forest-header-aligned:'+script.m_AssemblyName,fullname)))
        (data/'sharedassets2.assets').write_bytes(next(iter(env.files.values())).save())
        check=UnityPy.load(str(data/'sharedassets2.assets'));after={o.path_id:o for o in check.objects};assert objects.keys()==after.keys()
        assert all(hashlib.sha256(after[pid].get_raw_data()).hexdigest()==digest for pid,digest in unchanged_objects.items())
        assert all(canonical(read_tree(after[pid],generator))==canonical(tree) for pid,tree in plans.items())
        projection['allUnselectedObjectsByteExact']=True
        result['inventoryGlitchInitialProjection']=projection
        result['inventoryGlitchCodeRepair']=patch_glitch(data/'Managed',out,out/'inventory-glitch-code-readback.json')
    result['layoutIncrement'] = dict(base=str(base), baseBuildSha256=sha(base / 'build.json'),
                                   recipeSha256=sha(out / Path(__file__).name),
                                   glitchText=glitch_text,
                                   boundary='Isolated PlayerSettings identity, native layout call/helper and optional independently accepted2-unit glitch display overlay. All other asset objects/method bodies remain exact; no font or texture changes.')
    for row in result['files']:
        row['probeSha256'] = sha(data / row['path'])
    result['files'].append(dict(path='Managed/VNRevivalInventoryLayout.dll', probeSha256=sha(data / 'Managed/VNRevivalInventoryLayout.dll'), purpose='Native inventory pane reflow'))
    unchanged = [name for name, digest in before_assets.items() if sha(data / name) == digest]
    assert set(before_assets) - set(unchanged) == {'globalgamemanagers', 'Managed/Assembly-CSharp.dll'} | ({'sharedassets2.assets'} if glitch_text else set())
    result['layoutIncrement']['wholeFileExactToBase'] = unchanged
    (out / 'build.json').write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    assert all(sha(base / 'game' / DATA / r['path']) == r['probeSha256'] for r in baseline['files'])
    print(json.dumps(dict(status='built-static-only', base=str(base), candidate=str(out), unchangedPackagedFiles=len(unchanged), runtime='not-run')))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--base', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--qa-product', required=True)
    parser.add_argument('--glitch-text',action='store_true')
    args = parser.parse_args()
    build(args.base, args.output, args.qa_product,args.glitch_text)
