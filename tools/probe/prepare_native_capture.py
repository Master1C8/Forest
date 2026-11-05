"""Freeze Forest's native capture adapter and a copy of the owner's current save."""
from pathlib import Path
import hashlib,json,plistlib,shutil,subprocess,sys,os,re
ROOT=Path(__file__).resolve().parents[2]
RUN=ROOT/'localization/probes'/os.environ.get('FOREST_CAPTURE_RUN','ru-owner-shots-20261104-01')
assert RUN.parent==ROOT/'localization/probes' and RUN.name.startswith(('ru-owner-shots-','locale-owner-shots-'))
LOCALE=os.environ.get('FOREST_CAPTURE_LOCALE','ru')
assert re.fullmatch(r'[a-z]{2,3}(?:-[A-Za-z0-9]+)*',LOCALE) and (ROOT/'localization/languages'/(LOCALE+'.json')).is_file()
SOURCE=Path(os.environ.get('FOREST_CAPTURE_SOURCE',str(Path.home()/'Library/Application Support/VN Revival/Forest/Current/The Forest of Love.app'))).resolve()
if 'FOREST_CAPTURE_SOURCE' in os.environ:assert SOURCE.is_relative_to(ROOT/'localization/screenshots') and SOURCE.suffix=='.app'
OVERLAY=os.environ.get('FOREST_CAPTURE_OVERLAY')
PRODUCT='ForestRuScreenshotsProbe20261104' if LOCALE=='ru' else 'ForestScreenshotsProbe20261104-'+LOCALE
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def write(p,v):p.write_text(json.dumps(v,indent=2)+'\n')
RESUME='--resume-prelaunch' in sys.argv
if not RESUME:
    assert not (RUN/'game.app').exists()
    assert shutil.disk_usage(ROOT).free>8*1024**3
    state=json.loads((SOURCE.parent/'state.json').read_bytes());assert state['locale']=='ru'
    owner={p.name:dict(bytes=p.stat().st_size,sha256=sha(p)) for p in (SOURCE/'Contents').glob('tfol.*') if p.is_file()}
    write(RUN/'owner-before.json',dict(source=str(SOURCE),files=owner,resources=state['files']))
    subprocess.run(['/bin/cp','-cR',str(SOURCE),str(RUN/'game.app')],check=True)
    game=RUN/'game.app';contents=game/'Contents';data=contents/'Resources/Data';managed=data/'Managed'
    for name,pin in state['files'].items():assert sha(data/name)==pin['sha256']
    resource_pins=state['files']
    if OVERLAY:
        overlay=Path(OVERLAY).resolve();assert overlay.is_relative_to(ROOT/'dist')
        native=json.loads((overlay/'manifest.json').read_bytes());assert native['locale']==LOCALE
        extras=set(native['files'])-set(resource_pins)
        assert set(resource_pins)<=set(native['files']) and extras<={'Managed/Unity.TextMeshPro.dll'},'Preserve the installed native resource inventory'
        if extras:
            assert sha(data/'Managed/Unity.TextMeshPro.dll')=='775eab21aef1558df02968234ce1e506c2685c95813ba7cbb89e8f3e9102c483','Exact unmodified TMP baseline in fixture'
        for name,pin in native['files'].items():
            assert sha(overlay/name)==pin['sha256'] and (overlay/name).stat().st_size==pin['bytes']
            shutil.copy2(overlay/name,data/name)
        resource_pins=native['files']
    write(RUN/'capture-resource-pins.json',dict(overlay=OVERLAY,files=resource_pins))
    for name in owner:
        assert sha(contents/name)==owner[name]['sha256']
        assert (contents/name).stat().st_ino!=(SOURCE/'Contents'/name).stat().st_ino
        shutil.copy2(contents/name,RUN/('original-'+name))
    settings=json.loads((contents/'tfol.settings').read_bytes());g=settings['config_data']['value']['generalData']
    g.update(isFullscreen=False,enableFullscreenStretch=False,windowScalingIndex=1,lastKnownScreenResolutionWidth=1280,lastKnownScreenResolutionHeight=720)
    (contents/'tfol.settings').write_text(json.dumps(settings,separators=(',',':')))
    sys.path.insert(0,str(ROOT/'tools'))
    import UnityPy
    env=UnityPy.load(str(data/'globalgamemanagers'));obj=next(o for o in env.objects if o.type.name=='PlayerSettings');tree=obj.read_typetree();before=dict(tree)
    assert 'runInBackground' in tree
    tree['companyName']='VNRevivalQA';tree['productName']=PRODUCT;tree['runInBackground']=True
    obj.save_typetree(tree);(data/'globalgamemanagers').write_bytes(env.file.save())
    assert {k:v for k,v in tree.items() if k not in ['companyName','productName','runInBackground']}=={k:v for k,v in before.items() if k not in ['companyName','productName','runInBackground']}
    info=plistlib.loads((contents/'Info.plist').read_bytes());info.update(CFBundleIdentifier='org.vnrevival.forest.capture.'+LOCALE+'20261104',CFBundleName=PRODUCT,CFBundleDisplayName=PRODUCT)
    (contents/'Info.plist').write_bytes(plistlib.dumps(info))
game=RUN/'game.app';contents=game/'Contents';data=contents/'Resources/Data';managed=data/'Managed'
owner=json.loads((RUN/'owner-before.json').read_bytes())['files']
assert sha(contents/'tfol.savegame')==owner['tfol.savegame']['sha256']
assert sha(managed/'Assembly-CSharp.dll')==json.loads((RUN/'capture-resource-pins.json').read_bytes())['files']['Managed/Assembly-CSharp.dll']['sha256']
execution=RUN/'execution'/('compile-02' if RESUME else 'compile-01');execution.mkdir(exist_ok=False);source=(ROOT/'tools/probe/NativeCaptureProbe.cs').read_text().replace('__TASK_ROOT__',str(RUN)).replace('const string Product = "ForestRuScreenshotsProbe20261104";','const string Product = '+json.dumps(PRODUCT)+';');(execution/'NativeCaptureProbe.cs').write_text(source)
cecil=ROOT/'tools/locale_completion/resource_composition_v1/managed_saved/bin/Debug/net8.0/Mono.Cecil.dll'
inject=execution/'inject';inject.mkdir(exist_ok=False)
text=(ROOT/'tools/probe/InjectProbe.cs').read_text().replace('46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf',sha(managed/'Assembly-CSharp.dll'))
marker='var prefixes=new Dictionary<string,int>{{method.FullName,1}};'
assert text.count(marker)==1
text=text.replace(marker,marker+'''
var save=module.GetType("TheForestOfLove.Services.Persistence.SavegameFileHelper").Methods.Single(m=>m.Name=="WriteSavegameData");
var first=save.Body.Instructions[0];var il=save.Body.GetILProcessor();
il.InsertBefore(first,Instruction.Create(OpCodes.Call,module.ImportReference(bridge.GetType("ForestProbe").Methods.Single(m=>m.Name=="NoteBlockedSave"))));
il.InsertBefore(first,Instruction.Create(OpCodes.Ret));
intended.Add(save.FullName);prefixes.Add(save.FullName,2);
''')
(inject/'InjectProbe.cs').write_text(text)
(inject/'InjectProbe.csproj').write_text('<Project Sdk="Microsoft.NET.Sdk"><PropertyGroup><OutputType>Exe</OutputType><TargetFramework>net8.0</TargetFramework><ImplicitUsings>enable</ImplicitUsings><Nullable>enable</Nullable></PropertyGroup><ItemGroup><Reference Include="Mono.Cecil"><HintPath>'+str(cecil)+'</HintPath></Reference></ItemGroup></Project>')
compiler=Path('/opt/homebrew/Cellar/dotnet@8/8.0.131/libexec/sdk/8.0.131/Roslyn/bincore/csc.dll');assert compiler.exists()
refs=sorted(managed.glob('*.dll'))
subprocess.run(['dotnet',str(compiler),'-nologo','-target:library','-nostdlib+','-out:'+str(execution/'ForestProbe.dll')]+['-r:'+str(p) for p in refs]+[str(execution/'NativeCaptureProbe.cs')],check=True)
subprocess.run(['dotnet','build',str(inject/'InjectProbe.csproj'),'--nologo','-v','quiet'],check=True)
shutil.copy2(managed/'Assembly-CSharp.dll',RUN/'Assembly-CSharp.original.dll')
subprocess.run(['dotnet',str(inject/'bin/Debug/net8.0/InjectProbe.dll'),str(managed),str(execution/'ForestProbe.dll'),str(execution/'Assembly-CSharp.capture.dll')],check=True)
shutil.copy2(execution/'ForestProbe.dll',managed/'ForestProbe.dll');shutil.copy2(execution/'Assembly-CSharp.capture.dll',managed/'Assembly-CSharp.dll')
subprocess.run(['codesign','--force','--deep','--sign','-',str(game)],check=True)
write(RUN/'build.json',dict(locale=LOCALE,saveIsolation=dict(companyName='VNRevivalQA',productName=PRODUCT),source=str(SOURCE),
 game=str(game),compilerSha256=sha(compiler),sourceSaveSha256=owner['tfol.savegame']['sha256'],
 bridgeSha256=sha(managed/'ForestProbe.dll'),assemblySha256=sha(managed/'Assembly-CSharp.dll'),
 saveWrites='WriteSavegameData is a no-op only in this disposable copy; reads remain original',
 adapter='Port of existing Forest project bridge to native framebuffer and original UI/submit handlers',
 sourcePins={str(p.relative_to(ROOT)):sha(p) for p in execution.rglob('*') if p.is_file() and p.suffix in ['.py','.cs','.csproj']},
 requestedScreens=['main-menu','settings','gallery','camera-inventory','scarlett','hot-takes','maverick-current-dialogue'],
 targetDialogue=dict(conversation=279,entry=144),runtime='not-launched'))
print('Prepared native capture copy; owner save byte-exact and progress writes blocked')
