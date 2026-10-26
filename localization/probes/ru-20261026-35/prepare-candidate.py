"""One-use immutable menu input candidate35; never relaunch a consumed copy."""
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
modelrow=next(x for x in rows if x.split()[0]=='26364')
assert 'codex exec --ignore-user-config --model gpt-6.1-sol' in modelrow and 'model_reasoning_effort="high"' in modelrow and 'model_provider="openai"' in modelrow
assert '/0026-work/' in modelrow
write('execution-model.json',dict(pid=26364,model='gpt-6.1-sol',reasoning='high',provider='openai',actualArgv=modelrow,verified=True,fallback='forbidden',subagents=0))
report=json.loads((prior/'build.json').read_text())
bridge=json.loads((prior/'bridge-build.json').read_text())
assert all(sha(source/data/'Managed'/n)==h for n,h in bridge['originalManagedReferences'].items())
assert all(sha(prior/'game'/data/r['path'])==r['probeSha256'] and sha(source/data/r['path'])==r['sourceSha256'] for r in report['files'])
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
for n in ['diagnose_native_input.py','diagnose_newgame.py','command.py','target_keyboard.swift','prepare_bridge.py']:
 shutil.copy2(root/'tools/probe'/n,run/n)
for p in (root/'localization/source/native-focus-20261026').iterdir():
 if p.is_file():shutil.copy2(p,run/('source-'+p.name))
shutil.copy2(root/'localization/source/native-input-20261026/OriginalKeyboardAxes.il',run/'OriginalKeyboardAxes.il')
shutil.copy2(root/'localization/source/native-input-20261026/PolicyAllowed.il',run/'PolicyAllowed.il')
subprocess.run(['python3',str(root/'tools/probe/prepare_bridge.py'),str(run)],check=True)
subprocess.run(['swiftc',str(run/'target_keyboard.swift'),'-o',str(run/'target_keyboard')],check=True)
write('reuse-binding.json',dict(source=str(prior.relative_to(root)),resourcePairs=5,buildSha256=sha(run/'build.json'),clonedFiles=count,method='APFS clonefile; separate inode and full hash match for every copied file',excluded='all nested tfol.*',boundary='Exact34 resource bytes; rebuilt eligibility observer and guarded menu-only QA-policy trial'))
write('preparation.json',dict(preparedAt=datetime.datetime.now(datetime.timezone.utc).isoformat(),status='prepared-not-launched',tests='21 passed; mocked boundary guards only',originalManagedReferences=150,sourceGroups=5,scope='Passive original policy -> one QA-only LEFT -> restore; no New/tutorial or image input'))
frozen={str(p.relative_to(run)):sha(p) for p in sorted(run.rglob('*')) if p.is_file() and '__pycache__' not in p.parts}
write('frozen-files.json',frozen)
print('Prepared immutable35:',len(frozen),'dependencies,',count,'cloned game files')
