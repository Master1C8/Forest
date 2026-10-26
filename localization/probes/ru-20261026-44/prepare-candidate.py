"""One-use candidate44: exact QA43 fixture through ordinary Continue, never New."""
import ctypes
import datetime
import errno
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess

root=Path('/Users/antonkrutov/Desktop/Forest');run=Path(__file__).resolve().parent
prior=root/'localization/probes/ru-20261026-34'
source=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest');data='The Forest of Love_Data'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def write(n,v):(run/n).write_text(json.dumps(v,indent=2)+'\n')
assert run.name=='ru-20261026-44' and not (run/'game').exists() and not (run/'launch.json').exists()
assert subprocess.check_output(['git','branch','--show-current'],cwd=root,text=True).strip()=='main'
assert not subprocess.check_output(['git','diff','--cached','--name-only'],cwd=root,text=True).strip()
checkpoint=json.loads((root/'CHECKPOINT.json').read_text())
assert all(sha(Path(p))==h for p,h in checkpoint['processBinding']['references'].items())
assert sha(root/'README.md')==checkpoint['processBinding']['projectGuideSha256']
rows=subprocess.check_output(['ps','-axo','pid,ppid,args'],text=True).splitlines()
assert not any(('The Forest of Love.exe' in row or 'UnityCrashHandler64.exe' in row or 'winewrapper.exe --run -- ' in row) and any(s in row for s in ['/forest/','/Forest/localization/probes/','\\Forest\\localization\\probes\\','\\forest\\']) for row in rows), 'Exact Forest game process remains'
qa=source.parent/'users/crossover/AppData/LocalLow/VNRevivalQA/ForestRuRendererProbe'
assert qa.is_dir() and not any(qa.rglob('*'))
processes={int(x.split(None,2)[0]):(int(x.split(None,2)[1]),x) for x in rows if len(x.split(None,2))==3 and x.split()[0].isdigit()}
ancestor=os.getppid()
while ancestor in processes and 'codex exec ' not in processes[ancestor][1]:ancestor=processes[ancestor][0]
assert ancestor in processes
modelrow=processes[ancestor][1]
assert 'codex exec --ignore-user-config --model gpt-6.1-sol' in modelrow and 'model_reasoning_effort="high"' in modelrow and 'model_provider="openai"' in modelrow and '/0047-work/' in modelrow
write('execution-model.json',dict(pid=ancestor,model='gpt-6.1-sol',reasoning='high',provider='openai',actualArgv=modelrow,verified=True,fallback='forbidden',subagents=0))
trace=json.loads((root/'localization/source/mono-startup-20261026/trace-dependencies.json').read_text())
external={trace['wrapper']:trace['wrapperSha256'],**{p:v['sha256'] for p,v in trace['nativeDependencies'].items()}}
assert all(sha(Path(p))==h for p,h in external.items());write('external-startup-dependencies.json',external)
report=json.loads((prior/'build.json').read_text());oldbridge=json.loads((prior/'bridge-build.json').read_text())
assert len(oldbridge['originalManagedReferences'])==150 and all(sha(source/data/'Managed'/n)==h for n,h in oldbridge['originalManagedReferences'].items())
assert len(report['files'])==5 and all(sha(prior/'game'/data/r['path'])==r['probeSha256'] and sha(source/data/r['path'])==r['sourceSha256'] for r in report['files'])
pins=json.loads((prior/'input-pins.json').read_text());assert len(pins)==7
all_pins=dict(pins)
for mp in sorted((root/'outputs/locale-assets-20261026').glob('*/input-pins.json')):
 for p,h in json.loads(mp.read_text()).items():
  assert p not in all_pins or all_pins[p]==h
  all_pins[p]=h
assert len(all_pins)==19 and all(sha(Path(p))==h for p,h in all_pins.items());write('all-input-pins.json',all_pins)
resource_paths={data+'/'+r['path'] for r in report['files']};catalog=data+'/StreamingAssets/aa/catalog.json';identity=data+'/app.info'
assert sha(prior/'game'/catalog)==report['addressables']['catalogSha256']
manifest=json.loads((root/'assets/source-v2/source-files.json').read_text());assert sha(source/catalog)==manifest['StreamingAssets/aa/catalog.json']['sha256']
assert (prior/'game'/identity).read_bytes()==b'VNRevivalQA\nForestRuRendererProbe'
assert (source/identity).read_bytes()==b"Carrot's Critters _ Vulpine Visions\nThe Forest of Love"
resource_paths|={catalog,identity}
source_files={str(p.relative_to(source)) for p in source.rglob('*') if p.is_file() and not p.name.startswith('tfol.')}
prior_files={str(p.relative_to(prior/'game')) for p in (prior/'game').rglob('*') if p.is_file() and not p.name.startswith('tfol.')}
assert source_files==prior_files and len(source_files)==269
original={}
for rel in sorted(source_files-resource_paths):
 assert sha(prior/'game'/rel)==sha(source/rel),rel
 original[rel]=sha(source/rel)
assert len(original)==262;write('original-game-files.json',original)
write('owner-player-before.json',{str(p.relative_to(source)):sha(p) for p in source.rglob('tfol.*') if p.is_file()})
lib=ctypes.CDLL('/usr/lib/libSystem.B.dylib',use_errno=True);lib.clonefile.argtypes=[ctypes.c_char_p,ctypes.c_char_p,ctypes.c_int];lib.clonefile.restype=ctypes.c_int
for rel in sorted(source_files):
 origin=prior/'game'/rel;dest=run/'game'/rel;dest.parent.mkdir(parents=True,exist_ok=True)
 assert not dest.exists()
 if lib.clonefile(os.fsencode(origin),os.fsencode(dest),0)!=0:
  error=ctypes.get_errno();assert error==errno.EXDEV,(origin,error);shutil.copy2(origin,dest)
 assert origin.stat().st_ino!=dest.stat().st_ino and sha(origin)==sha(dest)
assert not list((run/'game').rglob('tfol.*'))
for n in ['build.json','input-pins.json']:shutil.copy2(prior/n,run/n)
for n in ['diagnose_native_input.py','diagnose_newgame.py','command.py','target_keyboard.swift','prepare_bridge.py','save_fixture.py']:
 shutil.copy2(root/'tools/probe'/n,run/n)
shutil.copy2(root/'localization/source/intro-20261026/intro-graph.json',run/'intro-graph.json')
shutil.copy2(root/'localization/source/intro-20261026/dynamic-wrapper.json',run/'dynamic-wrapper.json')
for folder in ['save-continue-20261026','tutorial-20261026']:
 for p in (root/'localization/source'/folder).rglob('*'):
  if p.is_file():
   dest=run/'source-evidence'/folder/p.relative_to(root/'localization/source'/folder);dest.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(p,dest)
shutil.copy2(root/'localization/source/save-continue-20261026/tutorial-prefix.json',run/'tutorial-prefix.json')
fixture=root/'localization/probes/ru-20261026-43/qa-generated'
import sys
sys.path.insert(0,str(run));from save_fixture import pinned_fixture,candidate_files
fixture_sha='4ff9760850d3d2aa20ceae44a20696c4a5aab3daf59a3ba00fdd3ec4f72b2d36'
fm,expected=pinned_fixture(fixture/'manifest.json',fixture_sha)
(run/'qa-fixture').mkdir()
for n in ['manifest.json',*expected]:shutil.copy2(fixture/n,run/'qa-fixture'/n)
for n in expected:shutil.copy2(run/'qa-fixture'/n,run/'game'/data/n)
candidate_files(run/'game',expected)
shutil.copy2(root/'localization/probes/ru-20261026-43/target_keyboard',run/'target_keyboard')
assert sha(run/'target_keyboard.swift')==sha(root/'localization/probes/ru-20261026-43/target_keyboard.swift')
for n in ['toolchain-pins.json','runtime-dependencies.json','BridgePassiveFocus.il','NativePassiveObserve.sil']:
 shutil.copy2(root/'localization/probes/ru-20261026-43'/n,run/n)
for p in (root/'localization/probes/ru-20261026-43/resource-recipe').iterdir():
 if p.is_file():
  dest=run/'resource-recipe'/p.name;dest.parent.mkdir(exist_ok=True);shutil.copy2(p,dest)
write('reuse-binding.json',dict(source=str(prior.relative_to(root)),resourcePairs=5,clonedFiles=269,originalOtherFiles=262,method='Independent inode APFS clonefile, copy2 on EXDEV only',excludedOwnerFiles='all nested tfol.* excluded before exact QA43 two-file injection',fixtureManifestSha256=fixture_sha,recompiledBridgeRequired=True,gameLaunchesDuringPreparation=0))
write('preparation.json',dict(preparedAt=datetime.datetime.now(datetime.timezone.utc).isoformat(),status='copy-prepared-bridge-and-freeze-pending',candidate=44,gameLaunchesDuringPreparation=0,imagesCapturedDuringPreparation=0,imagesOpened=0,scope='One future ordinary-policy QA43 Continue to settled120:158; no choices, direct chapter/story/scene calls or New fallback'))
assert all(sha(Path(p))==h for p,h in all_pins.items())
print('Prepared44 isolated269-file copy plus two exact QA43 files; bridge/freeze/preflight pending')
