"""Read-only one-use43 preflight; writes its own check receipt, never launches the game."""
from pathlib import Path
import ast,datetime,hashlib,json,subprocess,sys
root=Path('/Users/antonkrutov/Desktop/Forest');run=Path(__file__).resolve().parent
assert run.name=='ru-20261026-43'
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
checks['newResourceReadback']=load('resource-readback.json')['status']=='passed-static-only' and load('resource-readback.json')['totalSelectedTrees']==95
checks['newBridgeAndHookInstalled']=sha(run/'game'/data/'Managed/ForestProbe.dll')==bridge['bridgeSha256']==sha(run/'ForestProbe.dll') and sha(run/'game'/data/'Managed/Assembly-CSharp.dll')==bridge['hookSha256']==sha(run/'Assembly-CSharp.hook.dll')
checks['originalPlayerFiles']=load('owner-player-before.json')=={str(p.relative_to(source)):sha(p) for p in source.rglob('tfol.*') if p.is_file()}
checks['nestedPlayerFilesExcluded']=not list((run/'game').rglob('tfol.*'))
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
checks['freshPassiveCompiledReadback']=toolchain['passiveReadback']['exactPhase0036ILAndSILMatch'] and sha(run/'BridgePassiveFocus.il')==toolchain['passiveReadback']['bridgeSha256'] and sha(run/'NativePassiveObserve.sil')==toolchain['passiveReadback']['swiftSha256']
checks['frozenObserverHelpers']=all(n in frozen for n in ['diagnose_newgame.py','command.py','target_keyboard','target_keyboard.swift','intro-graph.json','all-input-pins.json','verify-postrun.py','cleanup-plan.md'])
checks['70FocusedTests']=load('tests.json')['testsPassed']==70 and load('tests.json')['returnCode']==0
old=root/'localization/probes/ru-20261026-40'
oldFrozen=json.loads((old/'frozen-files.json').read_text());exceptions=[f'game/{data}/Managed/Assembly-CSharp.dll',f'game/{data}/Managed/ForestProbe.dll']
checks['consumed40Preserved']=all(sha(old/n)==h for n,h in oldFrozen.items() if n not in exceptions) and all(sha(old/n)==h for n,h in load('consumed40-binding.json')['boundedActualEvidence'].items())
rows=subprocess.check_output(['ps','-axo','pid,ppid,command'],text=True).splitlines();remaining=[]
for row in rows:
 if any(marker in row for marker in ['winewrapper.exe --run -- ','The Forest of Love.exe','UnityCrashHandler64.exe','diagnose_newgame.py','target_keyboard']):
  if any(p in row for p in [str(root/'localization/probes/'),str(root/'localization/probes/').replace('/','\\'),str(source)+'/',str(source).replace('/','\\')+'\\']):remaining.append(row.strip())
checks['noTaskRuntimeOrHelperProcess']=not remaining
checkpoint=json.loads((root/'CHECKPOINT.json').read_text())
checks['processBinding']=all(sha(Path(p))==h for p,h in checkpoint['processBinding']['references'].items()) and sha(root/'README.md')==checkpoint['processBinding']['projectGuideSha256']
# Verify unchanged shared guard bodies against exact consumed40, without importing/executing them.
names=json.loads((root/'localization/source/focus-transition-20261026/verification.json').read_text())['unchangedGuardBodies']
def bodies(p):return {n.name:ast.dump(n,include_attributes=False) for n in ast.parse(p.read_text()).body if isinstance(n,(ast.FunctionDef,ast.ClassDef))}
a,b=bodies(run/'diagnose_newgame.py'),bodies(old/'diagnose_newgame.py')
checks['all14OriginalGuards']=len(names)==14 and all(a[n]==b[n] for n in names)
binding42=load('consumed42-binding.json');consumed42=root/'localization/probes/ru-20261026-42'
checks['consumed42FrozenPreserved']=sha(consumed42/'frozen-files.json')==binding42['frozenManifestSha256'] and all(sha(consumed42/n)==h for n,h in json.loads((consumed42/'frozen-files.json').read_text()).items() if n not in binding42['exceptions'])
checks['consumed42SnapshotPreserved']=len(binding42['snapshotFiles'])==37 and all(sha(consumed42/'phase0042-snapshot'/n)==h for n,h in binding42['snapshotFiles'].items())
checks['consumed42Cleaned']=json.loads((consumed42/'phase0043-final-verification.json').read_text())['status']=='passed' and sha(consumed42/'phase0043-final-verification.json')==binding42['cleanupVerificationSha256']
checks['exactCanonicalObserver']=sha(run/'diagnose_newgame.py')==sha(root/'tools/probe/diagnose_newgame.py')
checks['mainAndBudgetUnchangedFrom42']=a['main']==bodies(consumed42/'diagnose_newgame.py')['main'] and a['IntroObservationBudget']==bodies(consumed42/'diagnose_newgame.py')['IntroObservationBudget']
checks['runtimeInterpreterPins']=all(sha(Path(n))==h for n,h in load('runtime-dependencies.json').items())
for p in run.glob('*.py'):compile(p.read_text(),str(p),'exec')
checks['pythonSnapshotsCompile']=True
binding=load('consumed41-binding.json');consumed=root/'localization/probes/ru-20261026-41'
cf=json.loads((consumed/'frozen-files.json').read_text())
checks['consumed41FrozenPreserved']=sha(consumed/'frozen-files.json')==binding['frozenManifestSha256'] and all(sha(consumed/n)==h for n,h in cf.items() if n not in binding['exceptions'])
checks['consumed41All38EvidencePreserved']=len(binding['evidence'])==38 and all(sha(consumed/n)==h for n,h in binding['evidence'].items())
checks['consumed41SevenPinsAndPendingPreserved']=len(binding['binaryPins'])==7 and all(sha(consumed/n)==h for n,h in binding['binaryPins'].items()) and sha(consumed/'command.txt')==binding['pendingCommandSha256']
reuse=load('compiled-reuse.json')
checks['compiledSourceAndBinaryLinkage']=all(sha(run/'bridge-source'/n)==h for n,h in bridge['sourceSnapshots'].items()) and all(sha(run/n)==h for n,h in reuse['reusedBinaries'].items())
checks['repairedObserverAndReused70Tests']=sha(root/'localization/source/process-lifetime-20261026/phase0044-tests.json')==reuse['sourceVerificationSha256'] and all(sha(root/n)==h for n,h in reuse['testSourceHashes'].items()) and sha(run/'diagnose_newgame.py')==reuse['testSourceHashes']['tools/probe/diagnose_newgame.py'] and sha(run/'command.py')==reuse['testSourceHashes']['tools/probe/command.py']
checks['exactRecipeSnapshots']=all(sha(run/'resource-recipe'/n)==sha(root/'tools'/n) for n in ['build_renderer_probe.py','extract_assets.py','addressables_catalog.py','settings_glow.py','tmp_dialogue_font.py'])
checks['noUnexpectedOrUnfrozenFiles']=set(frozen)=={str(p.relative_to(run)) for p in run.rglob('*') if p.is_file() and p.name not in ['frozen-files.json','preflight.json']}
value=dict(status='passed-static-only' if all(checks.values()) else 'failed',verifiedAt=datetime.datetime.now(datetime.timezone.utc).isoformat(),checks=checks,frozenDependencies=len(frozen),frozenManifestSha256=sha(run/'frozen-files.json'),frozenMismatches=mismatches,remainingTaskProcesses=remaining,originalManagedReferences=150,originalOtherGameFiles=262,resourcePairs=5,selectedResourceTrees=95,liveLanePins=19,originalGuardBodies=names,gameLaunches=0,imagesOpened=0,imagesCaptured=0,boundary='Static preparation/preflight only. Unity callback ordering/serialization, actual game window mapping, route/renderer/source/editorial/full delivery remain unverified.')
(run/'preflight.json').write_text(json.dumps(value,indent=2)+'\n')
print(json.dumps(dict(status=value['status'],checks=len(checks),frozenDependencies=len(frozen),failed=[k for k,v in checks.items() if not v]),indent=2))
sys.exit(0 if all(checks.values()) else 1)
