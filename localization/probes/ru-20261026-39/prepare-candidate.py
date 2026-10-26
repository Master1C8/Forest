"""One-use immutable original-policy natural-route candidate39; never relaunch a consumed copy."""
import ctypes
import datetime
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
assert not (run/'game').exists() and not (run/'launch.json').exists()
rows=subprocess.check_output(['ps','-axo','pid,ppid,args'],text=True).splitlines()
assert not any('winewrapper.exe --run -- ' in x and '/Forest/localization/probes/' in x for x in rows)
qa=source.parent/'users/crossover/AppData/LocalLow/VNRevivalQA/ForestRuRendererProbe'
assert qa.is_dir() and not any(qa.rglob('*'))
processes={int(x.split(None,2)[0]):(int(x.split(None,2)[1]),x) for x in rows if len(x.split(None,2))==3 and x.split()[0].isdigit()}
ancestor=os.getppid()
while ancestor in processes and 'codex exec ' not in processes[ancestor][1]: ancestor=processes[ancestor][0]
assert ancestor in processes, 'Cannot verify coordinator process'
modelrow=processes[ancestor][1]
assert 'codex exec --ignore-user-config --model gpt-6.1-sol' in modelrow and 'model_reasoning_effort="high"' in modelrow and 'model_provider="openai"' in modelrow
assert '/0032-work/' in modelrow
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
write('whole-game-parity.json',dict(totalFiles=len(source_files),nonresourceFiles=len(original_game),resourcePairs=sorted(resource_paths-{catalog,identity}),declaredCompanions=[catalog,identity],otherDifferences=[],nestedPlayerFilesExcluded=True))
owner={str(p.relative_to(source)):sha(p) for p in source.rglob('tfol.*') if p.is_file()}
write('owner-player-before.json',owner)
lib=ctypes.CDLL('/usr/lib/libSystem.B.dylib',use_errno=True)
lib.clonefile.argtypes=[ctypes.c_char_p,ctypes.c_char_p,ctypes.c_int];lib.clonefile.restype=ctypes.c_int
count=0
for p in sorted((prior/'game').rglob('*')):
 if not p.is_file() or p.name.startswith('tfol.'): continue
 dest=run/'game'/p.relative_to(prior/'game');dest.parent.mkdir(parents=True,exist_ok=True)
 assert lib.clonefile(os.fsencode(p),os.fsencode(dest),0)==0, (p,ctypes.get_errno())
 assert p.stat().st_ino!=dest.stat().st_ino and sha(p)==sha(dest)
 count+=1
assert not list((run/'game').rglob('tfol.*'))
for n in ['build.json','input-pins.json']:shutil.copy2(prior/n,run/n)
shutil.copy2(root/'localization/source/intro-20261026/intro-graph.json',run/'intro-graph.json')
for n in ['diagnose_native_input.py','diagnose_newgame.py','command.py','target_keyboard.swift','prepare_bridge.py']:
 shutil.copy2(root/'tools/probe'/n,run/n)
for folder in ['native-focus-20261026','gameplay-eligibility-20261026','startup-boundary-20261026','intro-observation-20261026']:
 for p in (root/'localization/source'/folder).iterdir():
  if p.is_file():shutil.copy2(p,run/(folder+'-'+p.name))
shutil.copy2(root/'localization/source/travel-20261026/input-configuration.json',run/'original-input-configuration.json')
shutil.copy2(root/'localization/source/native-input-20261026/OriginalKeyboardAxes.il',run/'OriginalKeyboardAxes.il')
shutil.copy2(root/'localization/source/native-input-20261026/PolicyAllowed.il',run/'PolicyAllowed.il')
subprocess.run(['python3',str(root/'tools/probe/prepare_bridge.py'),str(run),'--startup-markers'],check=True)
subprocess.run(['swiftc',str(run/'target_keyboard.swift'),'-o',str(run/'target_keyboard')],check=True)
write('reuse-binding.json',dict(source=str(prior.relative_to(root)),resourcePairs=5,buildSha256=sha(run/'build.json'),clonedFiles=count,method='APFS clonefile; separate inode and full hash match for every copied file',excluded='all nested tfol.*',boundary='Exact34 resource bytes; rebuilt passive startup markers plus unchanged eligibility/map observer and guarded original-policy New/intro/natural route; no QA policy change'))
write('preparation.json',dict(preparedAt=datetime.datetime.now(datetime.timezone.utc).isoformat(),status='prepared-not-launched',tests='See tests.json; mocked guards/file transport only; startup-marker injection exact readback verified by fresh compilation; no Unity acceptance',originalManagedReferences=150,sourceGroups=5,scope='Two actual original-policy idle menu frames with real eligibility/maps -> original New/intro terminal cleanup -> guarded natural left/down doorway route; no images or QA policy change'))
frozen={str(p.relative_to(run)):sha(p) for p in sorted(run.rglob('*')) if p.is_file() and '__pycache__' not in p.parts}
write('frozen-files.json',frozen)
assert all(sha(Path(p))==h for p,h in all_pins.items())
print('Prepared immutable39:',len(frozen),'dependencies,',count,'cloned game files')
