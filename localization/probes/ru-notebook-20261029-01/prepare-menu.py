"""Prepare isolated menu QA without dropping the localized assembly strings."""
import argparse, base64, copy, ctypes, hashlib, json, os, re, shutil, subprocess, sys
from urllib.parse import quote
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'tools'))
import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from build_russian_preview import save_tree
from extract_assets import read_tree
DATA='The Forest of Love_Data'
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def write(p,x):p.write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n')
def windowed_fixture(source,output):
    assert not output.exists()
    manifest=json.loads((source/'manifest.json').read_text())
    for name,pin in manifest['files'].items():assert sha(source/name)==pin['sha256']
    output.mkdir()
    for name in manifest['files']:shutil.copy2(source/name,output/name)
    settings=output/'tfol.settings';before=settings.read_bytes();after=before.replace(b'"isFullscreen" : true',b'"isFullscreen" : false')
    assert before.count(b'"isFullscreen" : true')==1
    expected=json.loads(before);expected['config_data']['value']['generalData']['isFullscreen']=False
    assert json.loads(after)==expected
    settings.write_bytes(after)
    manifest['files']['tfol.settings'].update(sha256=sha(settings),bytes=settings.stat().st_size)
    manifest['derivation']={'sourceManifest':str(source/'manifest.json'),'sourceManifestSha256':sha(source/'manifest.json'),'onlyChangedField':'config_data.value.generalData.isFullscreen','before':True,'after':False,'reason':'Isolated windowed QA after native Wine monitor-path crash; no fullscreen acceptance.'}
    write(output/'manifest.json',manifest)
    return output
def quest_snapshot(preview):
    roots=[p for p in [preview,preview/'recipe'] if (p/'quest-family-inputs.json').is_file()]
    assert len(roots)==1, 'Missing or ambiguous quest snapshot layout'
    root=roots[0];pins=json.loads((root/'quest-family-inputs.json').read_text())
    assert {'quest-family-runtime.json','quest-family-wording.json'}<=pins.keys(), 'Incomplete quest snapshot manifest'
    for name,expected in pins.items():
        path=(root/name).resolve();assert path.is_relative_to(root.resolve()), 'Quest snapshot path escape'
        assert sha(path)==expected, ('quest-snapshot-pin',name)
    if (root/'journal-header-pins.json').exists():
        for name,expected in json.loads((root/'journal-header-pins.json').read_text()).items():
            path=(root/name).resolve();assert path.is_relative_to(root.resolve()), 'Header snapshot path escape'
            assert sha(path)==expected, ('header-snapshot-pin',name)
    return root
def main():
    parser=argparse.ArgumentParser();parser.add_argument('--preview',type=Path,required=True);parser.add_argument('--output',type=Path,required=True);parser.add_argument('--reuse-native',type=Path);parser.add_argument('--item-probe',action='store_true');parser.add_argument('--inventory-probe',action='store_true');parser.add_argument('--notebook-probe',action='store_true');parser.add_argument('--quest-probe',action='store_true');parser.add_argument('--startup-markers',action='store_true');parser.add_argument('--windowed-fixture',action='store_true');args=parser.parse_args()
    preview=args.preview.resolve();run=args.output.resolve();assert preview.parent==ROOT/'localization/previews' and run.parent==ROOT/'localization/probes' and not run.exists()
    build=json.loads((preview/'build.json').read_text());assert len(build['files']) in (8,9,10,11,12) and len(build['menuTranslations'])==282
    for row in build['files']:assert sha(preview/'game'/DATA/row['path'])==row['probeSha256']
    assert re.fullmatch(r'ru-(?:menu|items|inventory|notebook|quests)-[0-9]{8}-[0-9]{2}',run.name)
    assert sum([args.item_probe,args.inventory_probe,args.notebook_probe,args.quest_probe])<=1
    quest_recipe=quest_snapshot(preview) if args.quest_probe else None
    assert run.name.startswith('ru-quests-')==args.quest_probe
    assert run.name.startswith('ru-notebook-')==args.notebook_probe
    assert run.name.startswith('ru-items-')==args.item_probe, 'Run identity must match the selected probe'
    assert run.name.startswith('ru-inventory-')==args.inventory_probe, 'Run identity must match the inventory mode'
    product=('ForestRuInventoryProbe' if args.inventory_probe else 'ForestRuQuestProbe' if args.quest_probe else 'ForestRuNotebookProbe' if args.notebook_probe else 'ForestRuItemProbe' if args.item_probe else 'ForestRuMenuProbe')+run.name.split('-',2)[2].replace('-','_')
    run.mkdir();system=ctypes.CDLL('/usr/lib/libSystem.B.dylib',use_errno=True)
    def clone(source,target):
        if system.clonefile(os.fsencode(source),os.fsencode(target),0):shutil.copy2(source,target)
        assert os.stat(source).st_ino!=os.stat(target).st_ino and sha(source)==sha(target)
        return target
    shutil.copytree(preview/'game',run/'game',copy_function=clone,ignore=lambda p,n:[x for x in n if x.startswith('tfol.')])
    data=run/'game'/DATA;managed=data/'Managed';gen=TypeTreeGenerator('2020.3.24f1');gen.load_local_dll_folder(str(managed))
    env=UnityPy.load(str(data/'globalgamemanagers'));obj=next(o for o in env.objects if o.type.name=='PlayerSettings');value=read_tree(obj,gen)
    assert value['companyName']=='VNRevivalQA' and value['productName']==build['saveIsolation']['productName']
    value['productName']=product;save_tree(obj,value,gen);(data/'globalgamemanagers').write_bytes(next(iter(env.files.values())).save());(data/'app.info').write_text('VNRevivalQA\n'+value['productName'])
    build['saveIsolation']['productName']=value['productName'];next(r for r in build['files'] if r['path']=='globalgamemanagers')['probeSha256']=sha(data/'globalgamemanagers')
    shutil.copy2(managed/'Assembly-CSharp.dll',run/'Assembly-CSharp.localized-original.dll')
    old=ROOT/'localization/probes/ru-20261026-15';bridge=json.loads((old/'bridge-build.json').read_text())
    original=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')/DATA/'Managed'
    for name,expected in bridge['originalManagedReferences'].items():
        assert sha(original/name)==expected
        if name!='Assembly-CSharp.dll':assert sha(managed/name)==expected
    snapshot=run/'bridge-source';shutil.copytree(old/'bridge-source',snapshot,ignore=shutil.ignore_patterns('bin','obj'))
    source=(snapshot/'ForestProbe.cs').read_text();assert source.count('public sealed class ForestProbe : MonoBehaviour')==1 and source.count('if(text=="dump") Dump();')==1
    identity_guard='Application.productName != "ForestRuRendererProbe"'
    assert source.count(identity_guard)==1
    source=source.replace(identity_guard,'Application.productName != "'+product+'"')
    ready_log='Debug.Log("FOREST_PROBE_READY " + root + " SAVES " + Application.persistentDataPath);'
    assert source.count(ready_log)==1
    ready_file='File.WriteAllText(Path.Combine(root,"bridge-ready.txt"), "1\\n"+Application.companyName+"\\n"+Application.productName+"\\n"+Application.dataPath);\n        '
    source=source.replace(ready_log,ready_file+ready_log)
    source=source.replace('public sealed class ForestProbe : MonoBehaviour','public sealed partial class ForestProbe : MonoBehaviour').replace('if(text=="dump") Dump();','if(text.StartsWith("menu-panel ")) MenuPanel(text.Substring(11));\n            else if(text=="menu-play-act1") MenuShowActOne();\n            else if(text=="menu-geometry") MenuGeometry();\n            else if(text=="menu-layout-baseline") MenuOriginalLayout();\n            else if(text=="dump") Dump();')
    source=source.replace('else if(text=="menu-geometry") MenuGeometry();', 'else if(text=="display-diagnostics") DisplayDiagnostics();\n            else if(text=="menu-font-diagnostics") MenuFontDiagnostics();\n            else if(text=="menu-glyph-diagnostics") MenuGlyphDiagnostics();\n            else if(text=="menu-geometry") MenuGeometry();')
    assert source.count('MenuFontDiagnostics();')==1
    if args.item_probe:
        source=source.replace('if(text.StartsWith("menu-panel "))', 'if(text=="items-readback") ItemsReadback();\n            else if(text=="items-ready") ItemsReady();\n            else if(text=="items-gameplay") ItemsGameplay();\n            else if(text.StartsWith("items-geometry ")) ItemsGeometry(text.Substring(15));\n            else if(text.StartsWith("items-display ")) ItemsDisplay(text.Substring(14));\n            else if(text.StartsWith("menu-panel "))')
        shutil.copy2(ROOT/'tools/probe/ItemUiProbe.cs',snapshot/'ItemUiProbe.cs')
        inv=json.loads((ROOT/'localization/source/bgdatabase-20261027/inventory-decoded.json').read_text());units=build['itemDisplayProjection']['units']
        expected=[]
        for row in inv['inventoryRows']:
            values={u['source']:u['target'] for u in units if '/row/'+quote(row['id'],safe='')+'/' in u['id']}
            expected.append(dict(itemType=row['cells']['item_type'],title=values[row['cells']['title']],phrase=values[row['cells']['notification_phrase']]))
        write(run/'item-expectations.json',dict(rows=expected))
        (run/'item-expectations.tsv').write_text(''.join(str(r['itemType'])+'\t'+base64.b64encode(r['title'].encode()).decode()+'\t'+base64.b64encode(r['phrase'].encode()).decode()+'\n' for r in expected))
    if args.notebook_probe:
        source=source.replace('if(text.StartsWith("menu-panel "))', 'if(text=="notebook-ensure") NotebookEnsure();\n            else if(text=="notebook-open") NotebookOpen();\n            else if(text.StartsWith("notebook-page ")) NotebookPage(int.Parse(text.Substring(14)));\n            else if(text=="notebook-geometry") NotebookGeometry();\n            else if(text.StartsWith("menu-panel "))')
        shutil.copy2(ROOT/'tools/probe/NotebookUiProbe.cs',snapshot/'NotebookUiProbe.cs')
        write(run/'notebook-expectations.json',build['notebookTranslations'])
    if args.inventory_probe:
        assert build['inventoryDisplayCompletion'] is True
        source=source.replace('if(text.StartsWith("menu-panel "))', 'if(text=="items-ready") ItemsReady();\n            else if(text=="items-gameplay") ItemsGameplay();\n            else if(text=="inventory-readback") InventoryReadback();\n            else if(text=="inventory-open") InventoryOpen();\n            else if(text=="inventory-geometry") InventoryGeometry();\n            else if(text=="inventory-close") InventoryClose();\n            else if(text.StartsWith("inventory-select ")) InventorySelect(text.Substring(17));\n            else if(text.StartsWith("menu-panel "))')
        source=source.replace('else if(text=="inventory-geometry")', 'else if(text=="inventory-glitch") InventoryGlitch();\n            else if(text=="inventory-glitch-show") InventoryGlitchShow();\n            else if(text=="inventory-geometry")')
        source=source.replace('else if(text=="inventory-glitch")', 'else if(text.StartsWith("inventory-glitch-mode ")) InventoryGlitchMode(text.Substring(22));\n            else if(text=="inventory-glitch")')
        for name in ['ItemUiProbe.cs','InventoryUiProbe.cs']:shutil.copy2(ROOT/'tools/probe'/name,snapshot/name)
        recipe=preview if (preview/'inventory-description-inputs.json').exists() else preview/'recipe'
        pins=json.loads((recipe/'inventory-description-inputs.json').read_text())
        for name,digest in pins.items():assert sha(recipe/name)==digest
        targets=[json.loads(line) for line in (recipe/'inventory-description-targets.jsonl').read_text().splitlines()]
        descriptions={r['itemType']:r for r in targets if r['family']=='inventory-description'};assert len(descriptions)==48
        title_by_id={r['id']:r['target'] for r in build['itemDisplayProjection']['units']}
        original=json.loads((ROOT/'localization/source/item-notifications-20261027/inventory.json').read_text())['units']
        titles={r['rowIndex']:title_by_id[r['id']] for r in original if r['family']=='item' and r['field']=='title'};assert len(titles)==48
        (run/'inventory-expectations.tsv').write_text(''.join(str(k)+'\t'+base64.b64encode(titles[r['rowIndex']].encode()).decode()+'\t'+base64.b64encode(r['target'].encode()).decode()+'\n' for k,r in descriptions.items()))
        (run/'inventory-empty-expectations.tsv').write_text(''.join(r['offset']+'\t'+base64.b64encode(r['target'].encode()).decode()+'\n' for r in targets if r['family']=='inventory-empty-cell'))
        if 'inventoryGlitchCodeRepair' in build:
            glitch=[json.loads(line) for line in (recipe/'glitch-targets.jsonl').read_text().splitlines()]
            suffix=next(r['target'] for r in glitch if r['id'].endswith('IL_0054'))
            (run/'inventory-glitch-expectations.tsv').write_text('\n'.join(base64.b64encode(v.encode()).decode() for v in [build['inventoryGlitchCodeRepair']['fakeTrace'],suffix])+'\n')
    if args.quest_probe:
        source=source.replace('if(text.StartsWith("menu-panel "))', 'if(text.StartsWith("quest-")) QuestCommand(text.Substring(6));\n            else if(text.StartsWith("menu-panel "))')
        for name in ['QuestUiProbe.cs','NotebookUiProbe.cs']:shutil.copy2(ROOT/'tools/probe'/name,snapshot/name)
        expected=json.loads((quest_recipe/'quest-family-runtime.json').read_text());assert len(expected)==195
        header_inv=quest_recipe/'journal-header-inventory.json'
        if header_inv.exists():
            hi=json.loads(header_inv.read_text());ht={r['id']:r['target'] for r in json.loads((quest_recipe/'journal-header-targets.json').read_text())};assert len(hi['rows'])==24
            (run/'journal-header-expectations.tsv').write_text(''.join(r['suffix']+'\t'+base64.b64encode(ht[r['id']].encode()).decode()+'\n' for r in hi['rows']))
        write(run/'quest-expectations.json',expected)
        (run/'quest-expectations.tsv').write_text(''.join(r['sheet']+'\t'+r['dbName']+'\t'+r['field']+'\t'+('~' if r['target'] is None else base64.b64encode(r['target'].encode()).decode())+'\n' for r in expected))
        words=json.loads((quest_recipe/'quest-family-wording.json').read_text());(run/'quest-words.tsv').write_text(''.join(k.split('.')[1]+'\t'+base64.b64encode(v.encode()).decode()+'\n' for k,v in words.items()))
    (snapshot/'ForestProbe.cs').write_text(source);shutil.copy2(ROOT/'tools/probe/MenuUiProbe.cs',snapshot/'MenuUiProbe.cs')
    compiler=Path(bridge['compiler']);assert sha(compiler)==bridge['compilerSha256'];refs=[managed/name for name in bridge['originalManagedReferences']]
    subprocess.run(['dotnet',str(compiler),'-nologo','-target:library','-nostdlib+','-out:'+str(run/'ForestProbe.dll')]+['-r:'+str(p) for p in refs]+[str(snapshot/'ForestProbe.cs'),str(snapshot/'MenuUiProbe.cs')]+([str(snapshot/'ItemUiProbe.cs')] if args.item_probe or args.inventory_probe else [])+([str(snapshot/'InventoryUiProbe.cs')] if args.inventory_probe else [])+([str(snapshot/'NotebookUiProbe.cs')] if args.notebook_probe or args.quest_probe else [])+([str(snapshot/'QuestUiProbe.cs')] if args.quest_probe else []),check=True)
    shutil.copy2(run/'ForestProbe.dll',managed/'ForestProbe.dll')
    injector=run/'injector';injector.mkdir();source=(ROOT/'tools/probe/InjectProbe.cs').read_text();assert source.count('46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf')==1
    source=source.replace('46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf',sha(managed/'Assembly-CSharp.dll'));(injector/'InjectProbe.cs').write_text(source);shutil.copy2(ROOT/'tools/probe/InjectProbe.csproj',injector/'InjectProbe.csproj')
    subprocess.run(['dotnet','build',str(injector/'InjectProbe.csproj'),'--nologo','-v','quiet','--ignore-failed-sources'],check=True)
    inject_args=['dotnet',str(injector/'bin/Debug/net8.0/InjectProbe.dll'),str(managed),str(managed/'ForestProbe.dll'),str(run/'Assembly-CSharp.hook.dll')]
    if args.startup_markers:inject_args.append('--startup-markers')
    subprocess.run(inject_args,check=True)
    shutil.copy2(run/'Assembly-CSharp.hook.dll',managed/'Assembly-CSharp.dll')
    # The accepted QA-generated fixture is independent of all owner gameplay files.
    fixture=ROOT/'localization/probes/ru-20261026-43/qa-generated'
    assert sha(fixture/'manifest.json')=='4ff9760850d3d2aa20ceae44a20696c4a5aab3daf59a3ba00fdd3ec4f72b2d36'
    if args.windowed_fixture:fixture=windowed_fixture(fixture,run/'fixture-inputs')
    manifest=json.loads((fixture/'manifest.json').read_text());assert manifest['originalOwnerFilesUsed'] is False and manifest['inspectionBridgePresent'] is False
    for name,row in manifest['files'].items():assert sha(fixture/name)==row['sha256'];shutil.copy2(fixture/name,data/name)
    write(run/'qa-fixture.json',manifest);write(run/'build.json',build)
    if args.reuse_native:
        prior=args.reuse_native.resolve();assert prior.parent==ROOT/'localization/probes'
        prep=json.loads((prior/'qa-preparation.json').read_text());cleanup=json.loads((prior/'cleanup.json').read_text());result=json.loads((prior/'runtime-result.json').read_text())
        assert prep['parentBuildSha256']==sha(preview/'build.json') and prep['fixtureManifestSha256']==sha(fixture/'manifest.json')
        assert cleanup['taskOwnedProcessesAbsent'] and cleanup['localizedAssemblyRestored'] and cleanup['parentArtifactUnchanged']
        captures=result['captures'];assert [r['filename'] for r in captures]==['ru-01-play.png','ru-02-gallery.png']
        for row in captures:
            assert sha(prior/row['filename'])==row['sha256'];shutil.copy2(prior/row['filename'],run/row['filename'])
        write(run/'reused-captures.json',{'sourceRun':str(prior),'sourceResultSha256':sha(prior/'runtime-result.json'),'captures':captures,'reason':'Only geometry observer units changed; same immutable parent artifact, original formatter, fixture and renderer. Retain valid Play/Gallery captures.'})
    for name in ['runtime_startup.py','capture_settings.py','command.py','capture_menu_ui.py','capture_play_menu_ui.py','capture_item_ui.py','capture_inventory_ui.py','capture_notebook_ui.py','capture_quest_ui.py','quest_command.py']:shutil.copy2(ROOT/'tools/probe'/name,run/name)
    shutil.copy2(__file__,run/'prepare-menu.py')
    write(run/'qa-preparation.json',{'parentBuild':str(preview),'parentBuildSha256':sha(preview/'build.json'),'localizedAssemblyPreservedBeforeHook':sha(run/'Assembly-CSharp.localized-original.dll'),'bridgeSha256':sha(managed/'ForestProbe.dll'),'hookSha256':sha(managed/'Assembly-CSharp.dll'),'ownerFilesUsed':False,'fixtureManifestSha256':sha(fixture/'manifest.json'),'fixtureDirectory':str(fixture),'boundary':'Original menu resources/gallery formatter and actual layout; panel inspection bypasses first-time tutorial navigation, without replacement text or flags'})
    if args.inventory_probe:
        owned=[run/n for n in ['capture_inventory_ui.py','capture_settings.py','runtime_startup.py','command.py','qa-preparation.json','qa-fixture.json','inventory-expectations.tsv','inventory-empty-expectations.tsv']]+list(snapshot.glob('*.cs'))
        if (run/'inventory-glitch-expectations.tsv').exists():owned.append(run/'inventory-glitch-expectations.tsv')
        write(run/'execution-pins.json',{str(p.resolve()):sha(p) for p in owned})
    print('Prepared immutable isolated menu QA:',run)
if __name__=='__main__':main()
