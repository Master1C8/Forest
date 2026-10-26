"""Read-only one-use48 preflight; never launches a game or reads image pixels."""
from pathlib import Path
import ast,datetime,hashlib,json,subprocess,sys
root=Path('/Users/antonkrutov/Desktop/Forest');run=Path(__file__).resolve().parent
assert run.name=='ru-20261026-48'
source=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest');data='The Forest of Love_Data'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def load(n):return json.loads((run/n).read_text())
checks={};frozen=load('frozen-files.json');report=load('build.json');bridge=load('bridge-build.json');pins=load('all-input-pins.json')
checks['canonicalMain']=subprocess.check_output(['git','branch','--show-current'],cwd=root,text=True).strip()=='main'
checks['unconsumed']=not any((run/n).exists() for n in ['launch.json','observer-child.json','observer-exit.json','runtime-result.json','observer.stdout','observer.stderr'])
mismatches=[n for n,h in frozen.items() if not (run/n).is_file() or sha(run/n)!=h]
checks['allFrozenDependencies']=bool(frozen) and not mismatches
checks['all19LiveLanePins']=len(pins)==19 and all(sha(Path(p))==h for p,h in pins.items())
checks['all150OriginalManagedReferences']=len(bridge['originalManagedReferences'])==150 and all(sha(source/data/'Managed'/n)==h for n,h in bridge['originalManagedReferences'].items())
original=load('original-game-files.json')
checks['original262OtherGameFiles']=len(original)==262 and all(sha(source/n)==h for n,h in original.items())
checks['fiveResourcePairs']=len(report['files'])==5 and all(sha(source/data/r['path'])==r['sourceSha256'] and sha(run/'game'/data/r['path'])==r['probeSha256'] for r in report['files'])
checks['newResourceReadback']=load('choice-resource-readback.json')['status']=='passed-static-only' and load('choice-resource-readback.json')['buildSha256']==sha(run/'build.json') and [len(r['labels']) for r in load('choice-resource-readback.json')['resourceFiles']]==[1,155]
checks['newBridgeAndHookInstalled']=sha(run/'game'/data/'Managed/ForestProbe.dll')==bridge['bridgeSha256']==sha(run/'ForestProbe.dll') and sha(run/'game'/data/'Managed/Assembly-CSharp.dll')==bridge['hookSha256']==sha(run/'Assembly-CSharp.hook.dll')
checks['originalPlayerFiles']=load('owner-player-before.json')=={str(p.relative_to(source)):sha(p) for p in source.rglob('tfol.*') if p.is_file()}
from save_fixture import pinned_fixture,candidate_files
fm,expected=pinned_fixture(run/'qa-fixture/manifest.json','4ff9760850d3d2aa20ceae44a20696c4a5aab3daf59a3ba00fdd3ec4f72b2d36')
checks['exactQA43FixtureAdmission']=len(candidate_files(run/'game',expected))==2
checks['qaIdentity']=(run/'game'/data/'app.info').read_bytes()==b'VNRevivalQA\nForestRuRendererProbe'
checks['originalAppIdentity']=(source/data/'app.info').read_bytes()==b"Carrot's Critters _ Vulpine Visions\nThe Forest of Love"
manifest=json.loads((root/'assets/source-v2/source-files.json').read_text())
checks['originalCatalog']=sha(source/data/'StreamingAssets/aa/catalog.json')==manifest['StreamingAssets/aa/catalog.json']['sha256']
checks['qaCatalog']=sha(run/'game'/data/'StreamingAssets/aa/catalog.json')==report['addressables']['catalogSha256']
qa=source.parent/'users/crossover/AppData/LocalLow/VNRevivalQA/ForestRuRendererProbe'
checks['qaPersistenceEmpty']=qa.is_dir() and not any(qa.rglob('*'))
checks['externalStartupDependencies']=all(sha(Path(p))==h for p,h in load('external-startup-dependencies.json').items())
toolchain=load('toolchain-pins.json')
checks['compilerPins']=all(sha(Path(p))==h for group in ['csharpCompiler','swiftCompiler'] for p,h in toolchain[group].items())
checks['runtimeInterpreterPins']=all(sha(Path(n))==h for n,h in load('runtime-dependencies.json').items())
checks['frozenObserverHelpers']=all(n in frozen for n in ['diagnose_newgame.py','command.py','target_keyboard','target_keyboard.swift','intro-graph.json','tutorial-prefix.json','dynamic-wrapper.json','all-input-pins.json','save_fixture.py','qa-fixture/manifest.json','verify-postrun.py','cleanup-plan.md'])
tests=load('tests.json')
checks['focused128Tests']=tests['testsPassed']==128 and tests['returnCode']==0 and all(sha(root/n)==h for n,h in tests['sourceHashes'].items())
rows=subprocess.check_output(['ps','-axo','pid,ppid,command'],text=True).splitlines();remaining=[]
for row in rows:
 if any(marker in row for marker in ['winewrapper.exe --run -- ','The Forest of Love.exe','UnityCrashHandler64.exe','diagnose_newgame.py','target_keyboard']):
  if any(p in row for p in [str(root/'localization/probes/'),str(root/'localization/probes/').replace('/','\\'),str(source)+'/',str(source).replace('/','\\')+'\\']):remaining.append(row.strip())
checks['noTaskRuntimeOrHelperProcess']=not remaining
checkpoint=json.loads((root/'CHECKPOINT.json').read_text())
checks['processBinding']=all(sha(Path(p))==h for p,h in checkpoint['processBinding']['references'].items()) and sha(root/'README.md')==checkpoint['processBinding']['projectGuideSha256']
names=json.loads((root/'localization/source/focus-transition-20261026/verification.json').read_text())['unchangedGuardBodies']
def bodies(p):return {n.name:ast.dump(n,include_attributes=False) for n in ast.parse(p.read_text()).body if isinstance(n,(ast.FunctionDef,ast.ClassDef))}
a,b=bodies(run/'diagnose_newgame.py'),bodies(root/'localization/probes/ru-20261026-43/diagnose_newgame.py')
checks['all14OriginalGuards']=len(names)==14 and all(a[n]==b[n] for n in names)
checks['exactCanonicalObserver']=sha(run/'diagnose_newgame.py')==sha(root/'tools/probe/diagnose_newgame.py') and sha(run/'save_fixture.py')==sha(root/'tools/probe/save_fixture.py')
checks['compiledSourceAndBinaryLinkage']=all(sha(run/'bridge-source'/n)==h for n,h in bridge['sourceSnapshots'].items()) and sha(root/'tools/probe/ForestProbe.cs')==bridge['sourceSnapshots']['ForestProbe.cs'] and load('bridge-verification.json')['semanticallyUnchangedTopLevelMethods']==37
checks['exactRecipeSnapshots']=all(sha(run/'resource-recipe'/n)==sha(root/'tools'/n) for n in ['build_renderer_probe.py','extract_assets.py','addressables_catalog.py','settings_glow.py','tmp_dialogue_font.py','legacy_choice_font.py'])
for p in run.glob('*.py'):compile(p.read_text(),str(p),'exec')
checks['pythonSnapshotsCompile']=True
checks['noUnexpectedOrUnfrozenFiles']=set(frozen)=={str(p.relative_to(run)) for p in run.rglob('*') if p.is_file() and p.name not in ['frozen-files.json','preflight.json']}
checks['exactTerminalCompletionReadback']=load('bridge-verification.json')['changedMethods']==['ReadTutorialCompletion'] and load('bridge-verification.json')['newMethods']==['TutorialChoiceText'] and all(v['exactEqualityAfterDeclaredRename'] for v in load('bridge-verification.json')['generatedClosureRenames'].values())
from diagnose_newgame import admit_choice_mode
admit_choice_mode(run,'synthetic')
checks['explicitSyntheticMode']=bridge['tutorialChoiceMode']=='synthetic' and load('bridge-verification.json')['defaultMode']=='original'
checks['freshBridgeStartupMarkers']=bridge['startupMarkers'] is True and load('bridge-verification.json')['canonicalSourceEqualsSnapshot'] and bridge['sourceSnapshots']['ForestProbe.cs']==load('bridge-verification.json')['sourceSha256']
value=dict(status='passed-static-only' if all(checks.values()) else 'failed',verifiedAt=datetime.datetime.now(datetime.timezone.utc).isoformat(),checks=checks,frozenDependencies=len(frozen),frozenManifestSha256=sha(run/'frozen-files.json'),frozenMismatches=mismatches,remainingTaskProcesses=remaining,gameLaunchesDuringPreparation=0,imagesOpened=0,imagesCapturedDuringPreparation=0,boundary='Static preflight, not Unity restoration/continuation or renderer/editorial acceptance')
(run/'preflight.json').write_text(json.dumps(value,indent=2)+'\n')
print(json.dumps(dict(status=value['status'],checks=len(checks),frozenDependencies=len(frozen),failed=[k for k,v in checks.items() if not v]),indent=2));sys.exit(0 if all(checks.values()) else 1)
