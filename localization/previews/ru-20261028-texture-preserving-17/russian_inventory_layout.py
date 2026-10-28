"""Build/apply the bounded native inventory layout helper; textures stay exact."""
import hashlib
import json
from pathlib import Path
import shutil
import subprocess

ROOT = Path('/Users/antonkrutov/Desktop/Forest')


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def validate_source_pane(managed):
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    from extract_assets import read_tree
    env = UnityPy.load(str(managed.parent / 'sharedassets2.assets'))
    objects = {o.path_id: o for o in env.objects}
    generator = TypeTreeGenerator('2020.3.24f1'); generator.load_local_dll_folder(str(managed))
    pane = objects[12225].read_typetree()
    assert pane['m_SizeDelta'] == dict(x=398.0, y=23.0)
    assert pane['m_AnchoredPosition'] == dict(x=16.0, y=-195.0)
    assert pane['m_Father']['m_PathID'] == 12190
    assert any(c['m_PathID'] == 12216 for c in pane['m_Children'])
    separator = objects[12216].read_typetree()
    assert separator['m_Father']['m_PathID'] == 12225 and not separator['m_Children']
    assert separator['m_SizeDelta'] == dict(x=10.0, y=0.0)
    separator_go = objects[separator['m_GameObject']['m_PathID']].read_typetree()
    assert separator_go['m_Name'] == 'Separator' and separator_go['m_IsActive']
    assert any(c['component']['m_PathID'] == 17271 for c in separator_go['m_Component'])
    assert objects[17271].parse_monobehaviour_head().m_Script.deref().read().m_ClassName == 'Image'
    background = objects[12592].read_typetree()
    assert background['m_SizeDelta'] == dict(x=824.0, y=414.0)
    assert background['m_LocalScale'] == dict(x=.5, y=.5, z=1.0)
    assert background['m_AnchoredPosition'] == dict(x=0.0, y=-16.0)
    for pid in [17274, 17292]:
        text = read_tree(objects[pid], generator)
        assert text['m_FontData']['m_FontSize'] == 12 and not text['m_FontData']['m_BestFit']
        go = objects[text['m_GameObject']['m_PathID']].read_typetree()
        rect = next(objects[c['component']['m_PathID']].read_typetree() for c in go['m_Component']
                    if objects[c['component']['m_PathID']].type.name == 'RectTransform')
        assert rect['m_Father']['m_PathID'] == 12225
    # The glitch sibling is NOT a child selected for native text reflow.
    go = objects[5021].read_typetree()
    assert any(c['component']['m_PathID'] == 15439 for c in go['m_Component'])
    assert objects[15439].parse_monobehaviour_head().m_Script.deref().read().m_ClassName == 'HorizontalLayoutGroup'
    rect = next(objects[c['component']['m_PathID']].read_typetree() for c in go['m_Component']
                if objects[c['component']['m_PathID']].type.name == 'RectTransform')
    assert rect['m_Father']['m_PathID'] == 12190
    assert rect['m_SizeDelta'] == dict(x=398.0, y=23.0)
    assert rect['m_AnchoredPosition'] == dict(x=16.0, y=-195.0)
    assert rect['m_Pivot'] == dict(x=0.0, y=1.0)
    glitch_text = read_tree(objects[15506], generator)
    assert glitch_text['m_fontSize'] == 12 and not glitch_text['m_enableAutoSizing']
    assert objects[glitch_text['m_GameObject']['m_PathID']].read_typetree()['m_Name'] == 'ItemDescriptionText'


def snapshot(folder, managed):
    validate_source_pane(managed)
    extraction_helper = Path(__file__).with_name('extract_assets.py')
    assert extraction_helper.is_file(), 'Exact type-tree helper required in the frozen recipe'
    if extraction_helper.resolve() != (folder / extraction_helper.name).resolve():
        shutil.copyfile(extraction_helper, folder / extraction_helper.name)
    source = Path(__file__).with_name('inventory_layout')
    if not source.is_dir():
        source = Path(__file__).with_name('inventory-layout-source')
    target = folder / 'inventory-layout-source'
    shutil.copytree(source, target, ignore=shutil.ignore_patterns('bin', 'obj'))
    baseline = json.loads((ROOT / 'localization/probes/ru-20261026-15/bridge-build.json').read_text())
    compiler = Path(baseline['compiler']); assert sha(compiler) == baseline['compilerSha256']
    refs = sorted(managed.glob('*.dll'))
    assert all(p.name != 'ForestProbe.dll' for p in refs)
    helper = folder / 'VNRevivalInventoryLayout.dll'
    subprocess.run(['dotnet', str(compiler), '-nologo', '-target:library', '-nostdlib+',
                    '-out:' + str(helper)] + ['-r:' + str(p) for p in refs] + [str(target / 'VNRevivalInventoryLayout.cs')], check=True, capture_output=True)
    subprocess.run(['dotnet', 'build', str(target / 'InventoryLayoutPatch.csproj'), '-o', str(folder / 'inventory-layout-patch')], check=True, capture_output=True)
    receipt = dict(compiler=str(compiler), compilerSha256=sha(compiler),
                   extractionHelperSha256=sha(folder / 'extract_assets.py'),
                   references={p.name: sha(p) for p in refs},
                   sourcePins={p.name: sha(p) for p in target.iterdir() if p.is_file()},
                   helperSha256=sha(helper), targetRect=dict(x=16, y=-195, width=398, height=60),
                   backgroundRect=dict(width=824,height=488,scale=.5),
                   boundary='Full-width vertical native text pane below both original item panels; only the existing background height extends. Font12, source opacity, wording, ownership, grids, scrolling and textures unchanged; actual native bounds/visual acceptance required.')
    (folder / 'inventory-layout-build.json').write_text(json.dumps(receipt, indent=2) + '\n')


def patch_layout(managed, recipe, receipt_path):
    source = managed / 'Assembly-CSharp.dll'; helper = recipe / 'VNRevivalInventoryLayout.dll'
    output = managed / 'Assembly-CSharp.inventory-layout.dll'
    subprocess.run(['dotnet', str(recipe / 'inventory-layout-patch/InventoryLayoutPatch.dll'),
                    str(source), sha(source), str(helper), str(output), str(receipt_path)], check=True)
    receipt = json.loads(receipt_path.read_text())
    assert receipt['allOriginalBodiesRestored'] and receipt['addedInstructions'] == 2
    assert sha(output) == receipt['targetSha256'] and sha(helper) == receipt['helperSha256']
    output.replace(source); shutil.copy2(helper, managed / helper.name)
    return receipt
