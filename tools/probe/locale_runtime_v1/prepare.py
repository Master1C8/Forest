"""Prepare a frozen explicit-locale isolated game; never launches or edits a source."""
import argparse, base64, ctypes, hashlib, importlib.util, json, os, shutil, struct, subprocess, sys
from pathlib import Path

ROOT=Path(__file__).resolve().parents[3]
DATA='The Forest of Love_Data'
SOURCE=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')
def sha(p):
    h=hashlib.sha256()
    with Path(p).open('rb') as f:
        for b in iter(lambda:f.read(1048576),b''):h.update(b)
    return h.hexdigest()
def write(p,v):p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
def b64(v):return '~' if v is None else base64.b64encode(v.encode()).decode()
def inventory(root):return {str(p.relative_to(root)):sha(p) for p in sorted(root.rglob('*')) if p.is_file()}
def prepare(config_path):
    config_path=Path(config_path).resolve();config=json.loads(config_path.read_text())
    compiled=bool(config.get('compiledLanguage'))
    if compiled:
        import compiled_contract
        compiled_contract.text_gate(ROOT,config)
        language=json.loads(compiled_contract.read_pin(ROOT,config['compiledLanguage']).read_text())
        assert config['culture']==language['culture']
    else:assert config['locale']=='de' and config['culture']=='de-DE'
    run=ROOT/config['run'];candidate=ROOT/config['candidate'];phase=ROOT/config['phase']
    legacy_run=run.parent==ROOT/'localization/probes' and run.name.startswith('de-')
    locale_run=run.is_relative_to(ROOT/'localization/de-assets/completion') and run.name.startswith('runtime-')
    compiled_run=compiled and run.parent==ROOT/'localization/probes' and run.name.startswith(config['locale']+'-')
    assert (legacy_run or locale_run or compiled_run) and not run.exists()
    assert Path(config.get('projectRoot',ROOT)).resolve()==ROOT
    task=(dict(task=dict(entryPins=config['entryPins'])) if compiled else json.loads((phase/'task.json').read_text()))
    # The phase explicitly leases these adapter repairs, while its frozen task
    # and all other pins remain immutable. Bind both versions, never ignore drift.
    revisions=config.get('entryPinRevisions',{})
    assert set(revisions)<= {'tools/probe/locale_runtime_v1/prepare.py','tools/probe/locale_runtime_v1/runner.py','tools/probe/locale_runtime_v1/LocaleRuntimeProbe.cs','tools/probe/locale_runtime_v1/LocaleStoryProbe.cs','tools/probe/locale_runtime_v1/APPLICATION.md','tools/probe/locale_runtime_v1/quest_native.py','tools/probe/locale_runtime_v1/tutorial_native.py'}
    for pin in task['task']['entryPins']:
        revision=revisions.get(pin['path'])
        if revision:
            assert revision['beforeSha256']==pin['sha256'] and revision['reason']
        assert sha(ROOT/pin['path'])==(revision['afterSha256'] if revision else pin['sha256']),pin['path']
    manifest=(compiled_contract.resource_manifest(ROOT,config,candidate) if compiled else json.loads((candidate/'manifest.json').read_text()))
    for name,pin in manifest['outputs'].items():assert sha(candidate/name)==pin['sha256'],name
    # The original failed launch is retained. Future attempts reject its named
    # missing primary-label projection before spending a copy, build or launch.
    labels=config.get('staticLabels')
    assert labels and set(labels)=={'path','sha256'},'Explicit pinned static label expectations required before another runtime attempt'
    labels_path=(ROOT/labels['path']).resolve();assert labels_path.is_relative_to(ROOT) and sha(labels_path)==labels['sha256']
    spec=importlib.util.spec_from_file_location('runtime_preflight',Path(__file__).parent/'preflight.py');preflight=importlib.util.module_from_spec(spec);spec.loader.exec_module(preflight)
    checked=preflight.check(ROOT,candidate/DATA/'level1',labels_path)
    assert checked['passed'],('primary-menu-resource-language',[(r['id'],r['status']) for r in checked['rows'] if r['status']!='target'])
    for section in ['sourceCompanions','retainedOriginalBase']:
        for name,pin in manifest[section].items():assert sha(Path(pin['path']))==pin['sha256'],name
    process_rows=subprocess.check_output(['ps','-axo','pid,ppid,args'],text=True).splitlines()
    assert not any('The Forest of Love.exe' in r for r in process_rows),'Unrelated game active; do not automate'
    assert shutil.disk_usage(ROOT).free>5*1024**3+sum(p.stat().st_size for p in SOURCE.rglob('*') if p.is_file())
    run.mkdir();snapshot=run/'execution';snapshot.mkdir()
    for name in ['prepare.py','preflight.py','runner.py','LocaleRuntimeProbe.cs','window_diagnostics.swift']:
        shutil.copy2(Path(__file__).parent/name,snapshot/name)
    if compiled:shutil.copy2(Path(__file__).parent/'compiled_contract.py',snapshot/'compiled_contract.py')
    shutil.copy2(config_path,snapshot/'config.json')
    write(run/'original-before.json',inventory(SOURCE))
    if compiled:
        framework=json.loads(compiled_contract.read_pin(ROOT,config['framework']).read_text())
        before=json.loads((run/'original-before.json').read_text())
        for name,pin in framework['sourceMembers'].items():
            assert before.get(DATA+'/'+name)==pin['sha256'],('Original source member differs',name)
    system=ctypes.CDLL('/usr/lib/libSystem.B.dylib',use_errno=True)
    def clone(source,target):
        if system.clonefile(os.fsencode(source),os.fsencode(target),0):shutil.copy2(source,target)
        assert os.stat(source).st_ino!=os.stat(target).st_ino and sha(source)==sha(target)
        return target
    shutil.copytree(SOURCE,run/'game',copy_function=clone,ignore=lambda p,n:[x for x in n if x.startswith('tfol.')])
    data=run/'game'/DATA;managed=data/'Managed'
    for name,pin in manifest['gameResources'].items():
        destination=run/'game'/name;destination.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(candidate/name,destination)
        assert sha(destination)==pin['sha256']
    sys.path.insert(0,str(ROOT/'tools'));import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    from build_russian_preview import save_tree
    from extract_assets import read_tree
    gen=TypeTreeGenerator('2020.3.24f1');gen.load_local_dll_folder(str(managed))
    env=UnityPy.load(str(data/'globalgamemanagers'));obj=next(o for o in env.objects if o.type.name=='PlayerSettings');settings=read_tree(obj,gen)
    original_identity={k:settings[k] for k in ['companyName','productName']}
    settings['companyName']='VNRevivalQA';settings['productName']=config['product']
    assert config['product'].startswith('ForestQA'+config['locale'].upper() if compiled else 'ForestDe') and 'Probe' in config['product']
    save_tree(obj,settings,gen);(data/'globalgamemanagers').write_bytes(next(iter(env.files.values())).save())
    (data/'app.info').write_text('VNRevivalQA\n'+config['product'])
    # Candidate BG values provide independent serialized expectations for the runtime consumer.
    codec_path=ROOT/'localization/source/bgdatabase-20261027/decode_inventory.py'
    shutil.copy2(codec_path,snapshot/'decode_inventory.py')
    spec=importlib.util.spec_from_file_location('codec',snapshot/'decode_inventory.py');codec=importlib.util.module_from_spec(spec);spec.loader.exec_module(codec)
    env=UnityPy.load(str(data/'resources.assets'));obj=next(o for o in env.objects if o.path_id==320)
    blob=read_tree(obj,None)['m_Script'].encode('utf-8',errors='surrogateescape');envelope=codec.parse(blob)
    selected={}
    for sheet in envelope['sheets']:
        if sheet['name'] not in ['InventoryItem','Quest','QuestProgressLogText']:continue
        count=len(sheet['rowIds']);rows=[{'rowId':rid} for rid in sheet['rowIds']]
        for field in sheet['fields']:
            if field['name'] not in ['item_type','title','description','name','bio_title','bio_description','log_text','db_name','text','notification_phrase']:continue
            values=blob[field['valuesOffset']:field['valuesOffset']+field['valuesBytes']]
            if field['name']=='item_type':cells=[struct.unpack_from('<i',values,i*4)[0] for i in range(count)]
            else:
                cells,_=codec.variable_cells(dict(field,valuesHex=values.hex()),count)
                cells=[None if v is None else v.decode() for v in cells]
            for row,value in zip(rows,cells):row[field['name']]=value
        selected[sheet['name']]=rows
    items=selected['InventoryItem'];assert len(items)==48
    (run/'inventory-expectations.tsv').write_text(''.join(str(r['item_type'])+'\t'+b64(r['title'])+'\t'+b64(r['description'])+'\n' for r in items))
    # Empty branches are already patched managed literals. New compiled data uses
    # stable instruction indices, not the historical per-language IL-offset IDs.
    if compiled:
        language=json.loads(compiled_contract.read_pin(ROOT,config['compiledLanguage']).read_text())
        empty=compiled_contract.empty_inventory_wording(language)
        (run/'inventory-empty-expectations.tsv').write_text(''.join(r['branch']+'\t'+b64(r['target'])+'\n' for r in empty))
    else:
        import re
        all_inv=[json.loads(l) for l in (ROOT/'localization/de-assets/inventory52-20261030/authored.jsonl').read_text().splitlines()]
        empty=[r for r in all_inv if not r['id'].startswith('bgdb:')];assert len(empty)==4
        (run/'inventory-empty-expectations.tsv').write_text(''.join(re.search(r'(010c|0111|011d|0122)',r['id'],re.I)[1].lower()+'\t'+b64(r['target'])+'\n' for r in empty))
    quest_template=json.loads((ROOT/'localization/previews/ru-20261029-narrative42-01/quest-family-runtime.json').read_text())
    # Reuse source identities only, never Russian target wording.
    quest_rows=[]
    for r in quest_template:
        from urllib.parse import unquote
        row_id=unquote(r['id'].split('/row/')[1].split('/')[0])
        matches=[s for s in selected[r['sheet']] if s['rowId']==row_id];assert len(matches)==1
        quest_rows.append(dict(sheet=r['sheet'],dbName=r['dbName'],field=r['field'],target=matches[0][r['field']]))
    assert len(quest_rows)==195
    (run/'quest-expectations.tsv').write_text(''.join(r['sheet']+'\t'+r['dbName']+'\t'+r['field']+'\t'+b64(r['target'])+'\n' for r in quest_rows))
    corrected=(language['translations'][config['questBodyId']]['target'] if compiled else 'Hilf Finley, die Sache mit seinen früheren Mitbewohnerinnen abzuschließen.')
    finley=next(r for r in quest_rows if r['target']==corrected);title=next(r['target'] for r in quest_rows if r['dbName']==finley['dbName'] and r['field']=='bio_title')
    (run/'finley-expectation.tsv').write_text(finley['dbName']+'\t'+b64(title)+'\t'+b64(corrected)+'\n')
    write(run/'serialized-expectations.json',selected)
    if config.get('nativeBatch')=='notebook-headings':
        pin=config['inventoryHeadings'];path=ROOT/pin['path'];assert sha(path)==pin['sha256']
        rows=[json.loads(line) for line in path.read_text().splitlines() if line.strip()];assert len(rows)==12
        (run/'inventory-heading-expectations.tsv').write_text(''.join(r['context']['hierarchy'].split('/MasterLog/',1)[1]+'\t'+b64(r['target'])+'\n' for r in rows))
    # Snapshot every later-read source, including the original bridge/injector and runtime helper.
    for name in ['ForestProbe.cs','MenuUiProbe.cs','ItemUiProbe.cs','InventoryUiProbe.cs','NotebookUiProbe.cs','QuestUiProbe.cs','InjectProbe.cs','InjectProbe.csproj','runtime_startup.py']:
        shutil.copy2(ROOT/'tools/probe'/name,snapshot/name)
    for name in ['quest_native.py']:
        shutil.copy2(Path(__file__).parent/name,snapshot/name)
    if config.get('nativeBatch')=='original-tutorial':
        shutil.copy2(Path(__file__).parent/'tutorial_native.py',snapshot/'tutorial_native.py')
        shutil.copy2(Path(__file__).parent/'LocaleStoryProbe.cs',snapshot/'LocaleStoryProbe.cs')
        for key,name in [('originalInputMethods','original-input-methods.py'),('nativeTransport','target_keyboard.original.swift'),('tutorialGraph','tutorial-graph.json')]:
            pin=config[key];path=ROOT/pin['path'];assert sha(path)==pin['sha256']
            shutil.copy2(path,snapshot/name)
        if config.get('tutorialChoice',181)==159:
            pin=config['storySprites'];path=ROOT/pin['path'];assert sha(path)==pin['sha256']
            shutil.copy2(path,snapshot/'story-sprites.json')
        transport=(snapshot/'target_keyboard.original.swift').read_text()
        old='''    let root = "/Users/antonkrutov/Desktop/Forest/localization/probes/"
    try require(run.hasPrefix(root) && !run.dropFirst(root.count).contains("/") &&
        run.dropFirst(root.count).hasPrefix("ru-20261026-"), "Only one isolated Forest QA candidate")'''
        assert transport.count(old)==1
        transport=transport.replace(old,'    try require(run == '+json.dumps(str(run))+', "Only exact frozen German QA run")')
        old='["inspect", "observe", "left", "down", "release-left", "release-down"].contains(mode)'
        assert transport.count(old)==1
        transport=transport.replace(old,'["inspect", "observe", "focus", "left", "down", "release-left", "release-down"].contains(mode)')
        marker='    if mode != "inspect" {'
        assert transport.count(marker)==1
        transport=transport.replace(marker,'''    if mode == "focus" {
        try require(args.count == 3 && trusted, "Exact task focus requires trusted native target")
        guard let app = NSRunningApplication(processIdentifier: pid) else { throw Failure.guardFailed("Task native application absent") }
        try require(app.activate(options: []), "Task native activation refused")
        let taskAXApp = AXUIElementCreateApplication(pid)
        let axResult = AXUIElementSetAttributeValue(taskAXApp, kAXFrontmostAttribute as CFString, kCFBooleanTrue)
        print("taskAXFrontmostRequested pid=\\(pid) result=\\(axResult.rawValue)")
        try require(axResult == .success, "Exact task AX foreground request refused")
        let focusDeadline = Date().addingTimeInterval(3)
        while NSWorkspace.shared.frontmostApplication?.processIdentifier != pid && Date() < focusDeadline { RunLoop.current.run(until: Date().addingTimeInterval(0.05)) }
        try require(NSWorkspace.shared.frontmostApplication?.processIdentifier == pid, "Exact task app did not become native foreground")
        print("taskFocusRequested pid=\\(pid) window=\\(windowID); original Unity focus and keyboard guards still required")
        exit(0)
    }
'''+marker)
        (snapshot/'target_keyboard.swift').write_text(transport)
        subprocess.run(['swiftc',str(snapshot/'target_keyboard.swift'),'-o',str(run/'target_keyboard')],check=True)
    if config.get('nativeBatch')=='quest-callbacks':
        import quest_cases
        quest_cases.bind(ROOT,run,snapshot,config,selected)
    original=managed/'Assembly-CSharp.dll';shutil.copy2(original,run/'Assembly-CSharp.localized-original.dll')
    source=(snapshot/'ForestProbe.cs').read_text().replace('public sealed class ForestProbe : MonoBehaviour','public sealed partial class ForestProbe : MonoBehaviour')
    source=source.replace('Application.productName != "ForestRuRendererProbe"','Application.productName != "'+config['product']+'"')
    marker='Debug.Log("FOREST_PROBE_READY " + root + " SAVES " + Application.persistentDataPath);'
    assert source.count(marker)==1
    source=source.replace(marker,'File.WriteAllText(Path.Combine(root,"bridge-ready.txt"), "1\\n"+Application.companyName+"\\n"+Application.productName+"\\n"+Application.dataPath);\n        '+marker)
    # All original graph/control guards remain intact. Only their expected
    # wording is bound to exact admitted German versions in a source-bound map.
    if config.get('routeExpectations'):
        route_path=ROOT/config['routeExpectations']['path'];assert sha(route_path)==config['routeExpectations']['sha256']
        route=json.loads(route_path.read_text());write(run/'route-expectations.json',route)
        shutil.copy2(route_path,snapshot/'route-input.json')
        graph_path=ROOT/config['introGraph']['path'];assert sha(graph_path)==config['introGraph']['sha256']
        shutil.copy2(graph_path,snapshot/'intro-graph.json')
        for before,after in route.get('bridgeWording',{}).items():
            old=json.dumps(before,ensure_ascii=False);new=json.dumps(after,ensure_ascii=False)
            story_path=snapshot/'LocaleStoryProbe.cs'
            story=story_path.read_text() if story_path.exists() else ''
            assert old in source or old in story,('Missing original bridge guard',before)
            source=source.replace(old,new)
            if old in story:story_path.write_text(story.replace(old,new))
    dispatch='''if(text=="locale-diagnostics") LocaleDiagnostics();
            else if(text=="locale-quest-diagnostics") LocaleQuestDiagnostics();
            else if(text=="locale-quest-headings") LocaleQuestHeadings();
            else if(text.StartsWith("locale-heading-page ")) LocaleHeadingPage(text.Substring(20));
            else if(text.StartsWith("locale-heading-scroll ")) LocaleHeadingScroll(text.Substring(22));
            else if(text=="locale-heading-measure") LocaleHeadingMeasure("heading-measure.json");
            else if(text.StartsWith("locale-heading-capture ")) LocaleHeadingCapture(text.Substring(23));
            else if(text=="locale-heading-restore") LocaleHeadingRestore();
            else if(text=="locale-finley") LocaleFinley();
            else if(text.StartsWith("locale-queue-stage ")) LocaleQueueStage(text.Substring(19));
            else if(text=="locale-queue-fixture-guards") LocaleQueueFixtureGuards();
            else if(text=="locale-queue-poll") {LocaleQueueSetup();LocaleQueueRecord("poll");}
            else if(text=="locale-queue-restore") LocaleQueueRestore();
            else if(text.StartsWith("locale-sprite ")) LocaleSprite(text.Substring(14));
            else if(text.StartsWith("menu-panel ")) MenuPanel(text.Substring(11));
            else if(text=="menu-geometry") MenuGeometry();
            else if(text=="menu-font-diagnostics") MenuFontDiagnostics();
            else if(text=="menu-glyph-diagnostics") MenuGlyphDiagnostics();
            else if(text=="display-diagnostics") DisplayDiagnostics();
            else if(text=="items-ready") ItemsReady();
            else if(text=="items-gameplay") ItemsGameplay();
            else if(text=="inventory-readback") InventoryReadback();
            else if(text=="inventory-open") InventoryOpen();
            else if(text=="inventory-close") InventoryClose();
            else if(text=="inventory-geometry") InventoryGeometry();
            else if(text.StartsWith("inventory-select ")) InventorySelect(text.Substring(17));
            else if(text.StartsWith("quest-")) QuestCommand(text.Substring(6));
            else if(text=="dump-focus") ObserveFocus("snapshot","unknown");'''
    if config.get('nativeBatch')!='quest-callbacks':
        dispatch='\n'.join(l for l in dispatch.split('\n') if 'LocaleQueue' not in l)
    if config.get('nativeBatch')=='original-tutorial':
        dispatch+='\n            else if(text=="locale-story-start") LocaleStoryStart();\n            else if(text=="locale-story-poll") LocaleStoryRecord("poll");\n            else if(text=="locale-story-save") LocaleStorySave();\n            else if(text=="locale-task-focus") LocaleTaskFocus();'
        dispatch+='\n            else if(text=="locale-story-choice159") LocaleStoryChoice159();\n            else if(text.StartsWith("select-tutorial159 ")) LocaleStorySelect159(text.Substring(19));\n            else if(text=="locale-story-render") LocaleStoryRender();'
        dispatch+='\n            else if(text.StartsWith("locale-story-capture ")) LocaleStoryCapture(text.Substring(20));'
    assert source.count('if(text=="dump-focus") ObserveFocus("snapshot","unknown");')==1
    source=source.replace('if(text=="dump-focus") ObserveFocus("snapshot","unknown");',dispatch)
    (snapshot/'ForestProbe.cs').write_text(source)
    injector=(snapshot/'InjectProbe.cs').read_text();injector=injector.replace('46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf',sha(original));(snapshot/'InjectProbe.cs').write_text(injector)
    compiler=Path('/opt/homebrew/Cellar/dotnet@8/8.0.131/libexec/sdk/8.0.131/Roslyn/bincore/csc.dll')
    refs=sorted(managed.glob('*.dll'));sources=[snapshot/n for n in ['ForestProbe.cs','MenuUiProbe.cs','ItemUiProbe.cs','InventoryUiProbe.cs','NotebookUiProbe.cs','QuestUiProbe.cs','LocaleRuntimeProbe.cs']]
    if config.get('nativeBatch')=='quest-callbacks':sources.append(snapshot/'LocaleQuestCallbacks.cs')
    if config.get('nativeBatch')=='original-tutorial':sources.append(snapshot/'LocaleStoryProbe.cs')
    defines=['-define:FOREST_NOTEBOOK_HEADINGS'] if config.get('nativeBatch')=='notebook-headings' else []
    subprocess.run(['dotnet',str(compiler),'-nologo','-target:library','-nostdlib+','-out:'+str(run/'ForestProbe.dll')]+defines+['-r:'+str(p) for p in refs]+list(map(str,sources)),check=True)
    subprocess.run(['dotnet','build',str(snapshot/'InjectProbe.csproj'),'--nologo','-v','quiet','--ignore-failed-sources'],check=True)
    subprocess.run(['dotnet',str(snapshot/'bin/Debug/net8.0/InjectProbe.dll'),str(managed),str(run/'ForestProbe.dll'),str(run/'Assembly-CSharp.hook.dll'),'--startup-markers'],check=True)
    shutil.copy2(run/'ForestProbe.dll',managed/'ForestProbe.dll');shutil.copy2(run/'Assembly-CSharp.hook.dll',original)
    fixture=ROOT/'localization/probes/ru-20261026-43/qa-generated';fm=json.loads((fixture/'manifest.json').read_text())
    assert fm['originalOwnerFilesUsed'] is False and sha(fixture/'manifest.json')=='4ff9760850d3d2aa20ceae44a20696c4a5aab3daf59a3ba00fdd3ec4f72b2d36'
    fi=run/'fixture-inputs';fi.mkdir()
    for name,pin in fm['files'].items():assert sha(fixture/name)==pin['sha256'];shutil.copy2(fixture/name,fi/name)
    settings=json.loads((fi/'tfol.settings').read_text());general=settings['config_data']['value']['generalData'];general['isFullscreen']=False
    (fi/'tfol.settings').write_text(json.dumps(settings,ensure_ascii=False,indent=2)+'\n')
    checkpoint=config.get('retainedCheckpoint')
    if checkpoint:
        assert config.get('startMode')=='continue' and config.get('nativeBatch')=='original-tutorial'
        checkpoint_path=ROOT/checkpoint['path'];assert sha(checkpoint_path)==checkpoint['sha256']
        retained=json.loads(checkpoint_path.read_text())
        assert retained['processesAbsent'] and retained['candidateManifestSha256']==sha(candidate/'manifest.json')
        assert retained['originalGameplayCheckpoint'] and set(retained['files'])=={'tfol.settings','tfol.savegame'}
        for name,pin in retained['files'].items():
            path=checkpoint_path.parent/name;assert sha(path)==pin['sha256'];shutil.copy2(path,fi/name)
        shutil.copy2(checkpoint_path,snapshot/'retained-checkpoint.json')
        state_path=checkpoint_path.parent/retained['state']['filename'];assert sha(state_path)==retained['state']['sha256']
        shutil.copy2(state_path,snapshot/'retained-state.json')
    for name in fm['files']:shutil.copy2(fi/name,data/name)
    assert config.get('startMode','continue') in ['continue','new-game']
    if config.get('startMode')=='new-game':
        # Only the disposable copied QA fixture is absent. Original New starts
        # without overwriting any owner or accepted fixture save.
        (data/'tfol.savegame').unlink()
    write(run/'build.json',dict(locale=config['locale'],culture=config['culture'],candidate=str(candidate),candidateManifestSha256=sha(candidate/'manifest.json'),saveIsolation=dict(companyName='VNRevivalQA',productName=config['product']),originalIdentity=original_identity,fixtureOrigin=checkpoint if checkpoint else sha(fixture/'manifest.json'),fixtureDerivation='Exact retained original gameplay save/settings; no generated save loaded' if checkpoint else 'isFullscreen=false; exact parsed remaining values retained; no owner files',bridgeSha256=sha(managed/'ForestProbe.dll'),hookSha256=sha(original),compilerSha256=sha(compiler),managedReferences={str(p.relative_to(managed)):sha(p) for p in refs if p.name!='Assembly-CSharp.dll'}))
    write(run/'execution-pins.json',{str(p.relative_to(run)):sha(p) for p in snapshot.rglob('*') if p.is_file() and not set(p.parts)&{'bin','obj'}}|{str(p.relative_to(run)):sha(p) for p in run.glob('*expectation*') if p.is_file()}|{str(p.relative_to(run)):sha(p) for p in run.glob('quest-*') if p.is_file()}|{name:sha(run/name) for name in ['build.json','ForestProbe.dll','Assembly-CSharp.hook.dll','Assembly-CSharp.localized-original.dll']}|({'target_keyboard':sha(run/'target_keyboard')} if (run/'target_keyboard').exists() else {}))
    write(run/'qa-preparation.json',dict(status='prepared',ownerFilesUsed=False,candidateManifestSha256=sha(candidate/'manifest.json'),fixtureManifestSha256=sha(fixture/'manifest.json'),resources={n:sha(run/'game'/n) for n in manifest['gameResources']},originalGameUnchanged=inventory(SOURCE)==json.loads((run/'original-before.json').read_text()),backend='Project-owned bridge: original game-thread consumers and native ScreenCapture; deterministic and background-safe. No desktop clicks.',releaseUse=False))
    print('Prepared',run,flush=True)
if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--config',required=True);prepare(parser.parse_args().config)
