"""One-use immutable original-policy natural-route candidate42; never relaunch a consumed copy."""
import ctypes
import datetime
import errno
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess

root=Path('/Users/antonkrutov/Desktop/Forest')
run=Path(__file__).resolve().parent
prior=root/'localization/probes/ru-20261026-34'
source=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')
data='The Forest of Love_Data'
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def write(name,value): (run/name).write_text(json.dumps(value,indent=2)+'\n')
assert run.name=='ru-20261026-42' and not (run/'game').exists(), 'Reconcile partial preparation; never overwrite'
assert not (run/'launch.json').exists(), 'No consumed candidate continuation'
assert subprocess.check_output(['git','branch','--show-current'],cwd=root,text=True).strip()=='main'
assert not subprocess.check_output(['git','diff','--cached','--name-only'],cwd=root,text=True).strip()
checkpoint=json.loads((root/'CHECKPOINT.json').read_text())
assert all(sha(Path(p))==h for p,h in checkpoint['processBinding']['references'].items())
assert sha(root/'README.md')==checkpoint['processBinding']['projectGuideSha256']
trace=json.loads((root/'localization/source/mono-startup-20261026/trace-dependencies.json').read_text())
external={trace['wrapper']:trace['wrapperSha256'],**{p:v['sha256'] for p,v in trace['nativeDependencies'].items()}}
assert all(sha(Path(p))==h for p,h in external.items())
write('external-startup-dependencies.json',external)
consumed=root/'localization/probes/ru-20261026-40'
consumed_frozen=json.loads((consumed/'frozen-files.json').read_text())
exceptions={f'game/{data}/Managed/Assembly-CSharp.dll',f'game/{data}/Managed/ForestProbe.dll'}
assert all(sha(consumed/p)==h for p,h in consumed_frozen.items() if p not in exceptions)
binding41=root/'localization/probes/ru-20261026-41'
assert sha(binding41/'consumed40-binding.json')==json.loads((binding41/'frozen-files.json').read_text())['consumed40-binding.json']
shutil.copy2(binding41/'consumed40-binding.json',run/'consumed40-binding.json')

rows=subprocess.check_output(['ps','-axo','pid,ppid,args'],text=True).splitlines()
assert not any('winewrapper.exe --run -- ' in x and '/Forest/localization/probes/' in x for x in rows)
qa=source.parent/'users/crossover/AppData/LocalLow/VNRevivalQA/ForestRuRendererProbe'
assert not any(('The Forest of Love.exe' in row or 'UnityCrashHandler64.exe' in row) and ('/forest/' in row or '/Forest/localization/probes/' in row or '\\Forest\\localization\\probes\\' in row or '\\forest\\' in row) for row in rows), 'Exact Forest installation/probe process remains'
assert qa.is_dir() and not any(qa.rglob('*'))
processes={int(x.split(None,2)[0]):(int(x.split(None,2)[1]),x) for x in rows if len(x.split(None,2))==3 and x.split()[0].isdigit()}
ancestor=os.getppid()
while ancestor in processes and 'codex exec ' not in processes[ancestor][1]: ancestor=processes[ancestor][0]
assert ancestor in processes, 'Cannot verify coordinator process'
modelrow=processes[ancestor][1]
assert 'codex exec --ignore-user-config --model gpt-6.1-sol' in modelrow and 'model_reasoning_effort="high"' in modelrow and 'model_provider="openai"' in modelrow
assert '/0041-work/' in modelrow
write('execution-model.json',dict(pid=ancestor,model='gpt-6.1-sol',reasoning='high',provider='openai',actualArgv=modelrow,verified=True,fallback='forbidden',subagents=0))
report=json.loads((prior/'build.json').read_text())
bridge=json.loads((prior/'bridge-build.json').read_text())
assert all(sha(source/data/'Managed'/n)==h for n,h in bridge['originalManagedReferences'].items())
assert all(sha(prior/'game'/data/r['path'])==r['probeSha256'] and sha(source/data/r['path'])==r['sourceSha256'] for r in report['files'])
# Current originals, player files and every reused game byte are pinned before copying.
pins=json.loads((prior/'input-pins.json').read_text())
assert len(pins)==7 and all(sha(Path(p))==h for p,h in pins.items())
all_pins=dict(pins)
for manifest_path in sorted((root/'outputs/locale-assets-20261026').glob('*/input-pins.json')):
 for p,h in json.loads(manifest_path.read_text()).items():
  assert p not in all_pins or all_pins[p]==h
  all_pins[p]=h
assert len(all_pins)==19 and all(sha(Path(p))==h for p,h in all_pins.items())
write('all-input-pins.json',all_pins)
resource_paths={data+'/'+r['path'] for r in report['files']}
catalog=data+'/StreamingAssets/aa/catalog.json'
assert sha(prior/'game'/catalog)==report['addressables']['catalogSha256']
manifest=json.loads((root/'assets/source-v2/source-files.json').read_text())
assert sha(source/catalog)==manifest['StreamingAssets/aa/catalog.json']['sha256']
resource_paths.add(catalog)
identity=data+'/app.info'
assert (prior/'game'/identity).read_bytes()==b'VNRevivalQA\nForestRuRendererProbe'
assert (source/identity).read_bytes()==b"Carrot's Critters _ Vulpine Visions\nThe Forest of Love"
resource_paths.add(identity)
prior_files={str(p.relative_to(prior/'game')) for p in (prior/'game').rglob('*') if p.is_file() and not p.name.startswith('tfol.')}
source_files={str(p.relative_to(source)) for p in source.rglob('*') if p.is_file() and not p.name.startswith('tfol.')}
assert prior_files==source_files, ('Whole-game enumeration differs',sorted(prior_files-source_files),sorted(source_files-prior_files))
original_game={}
for p in sorted((prior/'game').rglob('*')):
 if not p.is_file() or p.name.startswith('tfol.'): continue
 rel=str(p.relative_to(prior/'game'))
 if rel not in resource_paths:
  assert (source/rel).is_file() and sha(p)==sha(source/rel), ('Nonresource reuse diverges from original',rel)
  original_game[rel]=sha(source/rel)
write('original-game-files.json',original_game)
assert len(source_files)==269 and len(original_game)==262 and len(bridge['originalManagedReferences'])==150
write('whole-game-parity.json',dict(totalFiles=len(source_files),nonresourceFiles=len(original_game),resourcePairs=sorted(resource_paths-{catalog,identity}),declaredCompanions=[catalog,identity],otherDifferences=[],nestedPlayerFilesExcluded=True))
owner={str(p.relative_to(source)):sha(p) for p in source.rglob('tfol.*') if p.is_file()}
write('owner-player-before.json',owner)
lib=ctypes.CDLL('/usr/lib/libSystem.B.dylib',use_errno=True)
lib.clonefile.argtypes=[ctypes.c_char_p,ctypes.c_char_p,ctypes.c_int];lib.clonefile.restype=ctypes.c_int
count=0
for p in sorted(source.rglob('*')):
 if not p.is_file() or p.name.startswith('tfol.'): continue
 rel=str(p.relative_to(source))
 # Clone independently verified originals and exact resource pairs/catalog/QA identity.
 origin=prior/'game'/rel  # all nonresources proved equal to original immediately above
 dest=run/'game'/rel;dest.parent.mkdir(parents=True,exist_ok=True)
 if dest.exists():
  assert sha(origin)==sha(dest), ('Partial preparation has divergent bytes',rel)
 elif lib.clonefile(os.fsencode(origin),os.fsencode(dest),0)!=0:
  error=ctypes.get_errno()
  assert error==errno.EXDEV, (origin,error)
  shutil.copy2(origin,dest)
 assert origin.stat().st_ino!=dest.stat().st_ino and sha(origin)==sha(dest)
 count+=1
assert not list((run/'game').rglob('tfol.*'))
for n in ['build.json','input-pins.json']:shutil.copy2(prior/n,run/n)
shutil.copy2(root/'localization/source/intro-20261026/intro-graph.json',run/'intro-graph.json')
for n in ['diagnose_native_input.py','diagnose_newgame.py','command.py','target_keyboard.swift','prepare_bridge.py']:
 shutil.copy2(root/'tools/probe'/n,run/n)
for folder in ['native-focus-20261026','gameplay-eligibility-20261026','startup-boundary-20261026','intro-observation-20261026','mono-startup-20261026','focus-transition-20261026']:
 for p in (root/'localization/source'/folder).iterdir():
  if p.is_file():shutil.copy2(p,run/(folder+'-'+p.name))
shutil.copy2(root/'localization/source/travel-20261026/input-configuration.json',run/'original-input-configuration.json')
shutil.copy2(root/'localization/source/native-input-20261026/OriginalKeyboardAxes.il',run/'OriginalKeyboardAxes.il')
shutil.copy2(root/'localization/source/native-input-20261026/PolicyAllowed.il',run/'PolicyAllowed.il')
# Reuse the exact verified passive compiled41 bridge/helper, without recompilation.
compiled=root/'localization/probes/ru-20261026-41'
cf=json.loads((compiled/'frozen-files.json').read_text())
exceptions={f'game/{data}/Managed/Assembly-CSharp.dll',f'game/{data}/Managed/ForestProbe.dll'}
assert all(sha(compiled/n)==h for n,h in cf.items() if n not in exceptions)
verification=json.loads((root/'localization/source/process-lifetime-20261026/verification.json').read_text())
evidence={}
for n in verification['unchangedConsumed41EvidenceNames']:
 p=compiled/n
 tracked=subprocess.check_output(['git','show','HEAD:'+str(p.relative_to(root))],cwd=root)
 assert hashlib.sha256(tracked).hexdigest()==sha(p),n
 evidence[n]=sha(p)
binary_names=['ForestProbe.dll','Assembly-CSharp.hook.dll','target_keyboard','target_keyboard.swift','diagnose_newgame.py','command.py','bridge-source/ForestProbe.cs']
assert len(binary_names)==7 and all(sha(compiled/n)==cf[n] for n in binary_names)
write('consumed41-binding.json',dict(frozenManifestSha256=sha(compiled/'frozen-files.json'),unchangedFrozen=len(cf)-2,exceptions=sorted(exceptions),evidence=evidence,binaryPins={n:sha(compiled/n) for n in binary_names},pendingCommandSha256=sha(compiled/'command.txt'),rule='Consumed41 read-only, no command removal/resubmission or replay; numeric launcher/game status and Quit sender remain unknown'))
for n in ['ForestProbe.dll','Assembly-CSharp.hook.dll','target_keyboard','target_keyboard.swift','bridge-build.json','toolchain-pins.json','BridgePassiveFocus.il','NativePassiveObserve.sil']:
 assert sha(compiled/n)==cf[n]
 shutil.copy2(compiled/n,run/n)
for n in ['ForestProbe.cs','InjectProbe.cs','InjectProbe.csproj']:
 dest=run/'bridge-source'/n;dest.parent.mkdir(exist_ok=True)
 shutil.copy2(compiled/'bridge-source'/n,dest)
 assert sha(dest)==cf['bridge-source/'+n]
for p in (compiled/'resource-recipe').iterdir():
 if p.is_file():
  assert sha(p)==cf[str(p.relative_to(compiled))]
  dest=run/'resource-recipe'/p.name;dest.parent.mkdir(exist_ok=True);shutil.copy2(p,dest)
bridge=json.loads((run/'bridge-build.json').read_text())
assert all(sha(run/'bridge-source'/n)==h for n,h in bridge['sourceSnapshots'].items())
assert sha(root/'tools/probe/ForestProbe.cs')==bridge['sourceSnapshots']['ForestProbe.cs']
assert sha(root/'tools/probe/target_keyboard.swift')==sha(run/'target_keyboard.swift')
assert sha(run/'ForestProbe.dll')==bridge['bridgeSha256'] and sha(run/'Assembly-CSharp.hook.dll')==bridge['hookSha256']
shutil.copy2(run/'ForestProbe.dll',run/'game'/data/'Managed/ForestProbe.dll')
shutil.copy2(run/'Assembly-CSharp.hook.dll',run/'game'/data/'Managed/Assembly-CSharp.dll')
source_verification=json.loads((root/'localization/source/process-lifetime-20261026/verification.json').read_text())
assert all(sha(root/n)==h for n,h in source_verification['sourceHashes'].items())
shutil.copy2(root/'localization/source/process-lifetime-20261026/tests.json',run/'tests.json')
write('compiled-reuse.json',dict(source=str(compiled.relative_to(root)),sourceFrozenManifestSha256=sha(compiled/'frozen-files.json'),bridgeBuildSha256=sha(run/'bridge-build.json'),exactOriginalManagedReferences=len(bridge['originalManagedReferences']),reusedBinaries={n:sha(run/n) for n in ['ForestProbe.dll','Assembly-CSharp.hook.dll','target_keyboard']},sourceSnapshots=bridge['sourceSnapshots'],sourceVerificationSha256=sha(root/'localization/source/process-lifetime-20261026/verification.json'),testSourceHashes=source_verification['sourceHashes'],recompiled=False,boundary='Byte-identical compiled passive bridge/native helper, exact source/compiler/reference/readback linkage reused; runtime unverified'))
assert b'--startup-diagnostics' in (run/'diagnose_newgame.py').read_bytes()
write('changed-input.json',dict(phase='0041-work',canonicalHead=subprocess.check_output(['git','rev-parse','HEAD'],cwd=root,text=True).strip(),priorConsumed='ru-20261026-41',change='Only corrected canonical process/command lifetime observer replaces consumed41 snapshot; unchanged command transport, passive bridge/native helper, startup logging and original-policy resources.',question='Retain actual launcher/game/command lifetime across original intro and distinguish native Quit/process disappearance from missing ACK without a focus workaround.',observerSha256=sha(run/'diagnose_newgame.py'),previousObserverSha256=sha(compiled/'diagnose_newgame.py'),gameLaunchLimit=1,gameLaunches=0,imagesOpened=0,imagesCaptured=0))
write('reuse-binding.json',dict(source=str(prior.relative_to(root)),compiledSource=str(compiled.relative_to(root)),resourcePairs=5,buildSha256=sha(run/'build.json'),clonedFiles=count,method='Independent inode APFS clonefile of verified originals/exact34 resource pairs; copy2 on EXDEV only.',excluded='all nested tfol.*',boundary='Static reuse; no recompilation or runtime. Corrected observer frozen separately. Never replay41/40/39/38.'))
write('preparation.json',dict(preparedAt=datetime.datetime.now(datetime.timezone.utc).isoformat(),status='prepared-not-launched',originalManagedReferences=150,scope='One future guarded original-policy New/intro/natural route with corrected lifetime observation; zero launches during preparation.',acceptance='Static preparation only; launcher/game/command lifetime in Wine/Unity, native runtime and route remain unverified'))
assert all(sha(Path(p))==h for p,h in all_pins.items())
print('Prepared42:',count,'original/resource game files plus passive bridge; verification/freeze still required')
