"""One-use immutable original-policy natural-route candidate41; never relaunch a consumed copy."""
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
write('consumed40-binding.json',dict(frozenManifestSha256=sha(consumed/'frozen-files.json'),unchanged=len(consumed_frozen)-2,exceptions=sorted(exceptions),runtimeDiagnosisSha256=sha(consumed/'runtime-diagnosis.json'),rule='Consumed once; not executed or modified'))

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
assert '/0037-work/' in modelrow
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
 # Copy original executable and nonresources. Reuse only pinned resource pairs/catalog/QA identity.
 origin=prior/'game'/rel if rel in resource_paths else p
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
subprocess.run(['python3',str(root/'tools/probe/prepare_bridge.py'),str(run),'--startup-markers'],check=True)
subprocess.run(['swiftc',str(run/'target_keyboard.swift'),'-o',str(run/'target_keyboard')],check=True)
assert b'--startup-diagnostics' in (run/'diagnose_newgame.py').read_bytes()
write('changed-input.json',dict(phase='0037-work',canonicalHead=subprocess.check_output(['git','rev-parse','HEAD'],cwd=root,text=True).strip(),priorConsumed='ru-20261026-40',change='Fresh passive Unity callbacks/getter/Rewired cache-watcher trace; scalar native PID/window/frontmost observations; exact-child retained exit. Reuse unchanged startup diagnostics opt-in for equivalent logging conditions.',question='First menu-to-loaded divergence between native task identity, actual Unity callbacks/getter and original Rewired cache/watcher/eligibility?',limitations='No native-engine causation inference; missing pre-install callback stays unknown. Static preparation only.',gameLaunchLimit=1,gameLaunches=0,imagesOpened=0,imagesCaptured=0))
write('reuse-binding.json',dict(source=str(prior.relative_to(root)),resourcePairs=5,buildSha256=sha(run/'build.json'),clonedFiles=count,method='APFS clonefile within volume; verified copy2 on EXDEV across volumes; existing partial bytes verified before reuse. Independent inode and full hash match. Original executable/nonresources, exact accepted34 resource pairs/catalog/QA identity.',excluded='all nested tfol.*',boundary='Exact34 resource bytes; newly compiled passive focus/startup observer with all original-policy guards. Never execute consumed40/39/38.'))
write('preparation.json',dict(preparedAt=datetime.datetime.now(datetime.timezone.utc).isoformat(),status='prepared-not-launched',originalManagedReferences=150,scope='One future guarded original-policy New/intro/natural route with passive focus transition observation; no images or policy change',acceptance='Static preparation only; callback serialization, real game-window mapping and runtime remain unverified'))
assert all(sha(Path(p))==h for p,h in all_pins.items())
print('Prepared41 bytes and fresh compiles; verification/freeze still required:',count,'game files')
