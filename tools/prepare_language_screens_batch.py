"""Finite sequential resource preparation, with a cooperative between-build stop."""
import argparse,hashlib,json,os,subprocess,sys,time
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
FAMILY=ROOT/'localization/screenshots/all30-owner-20261104-01'
def read(p):return json.loads(p.read_bytes())
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def write(p,v):
 t=p.with_suffix('.pending');t.write_text(json.dumps(v,indent=2)+'\n');t.replace(p)
p=argparse.ArgumentParser(description=__doc__);p.add_argument('locales',nargs='+');p.add_argument('--name',required=True);p.add_argument('--after-receipt',type=Path);p.add_argument('--dependency-timeout',type=int,default=43200);a=p.parse_args()
assert a.name.isalnum() and len(a.locales)==len(set(a.locales))
assert 1<=a.dependency_timeout<=43200,'Dependency wait must be finite, at most12 hours'
d=FAMILY/('resource-batch-'+a.name);d.mkdir(exist_ok=False)
# Future helpers remain in the canonical checkout. Defer conflicting edits until
# stop.request is observed and the current build has finished; detect drift too.
paths=[Path(__file__).resolve(),ROOT/'tools/prepare_language_screens.py',ROOT/'tools/forest_macos.py',ROOT/'tools/build_windows_installer.py',ROOT/'Windows/installer-config.json',*sorted((ROOT/'tools/forest_localization').glob('*.py')),*sorted((ROOT/'tools/forest_localization').glob('*.cs')),*sorted((ROOT/'tools/quest_layout').glob('*.cs')),*sorted((ROOT/'MacOS/Compiler').glob('*'))]
sys.path.insert(0,str(ROOT/'tools'))
from forest_localization.complex_text import SOURCES
paths += [ROOT/'tools/complex_text'/name for name in SOURCES+['prepare_corpus.py','font_shaping.py','thai_wrap.py','requirements.txt','CorpusTests.cs']]
pins={str(p):sha(p) for p in paths if p.is_file()}
state=dict(pid=os.getpid(),locales=a.locales,completed=[],status='waiting',sourcePins=pins,stopPolicy='Touch stop.request; current finite build completes before stopping. No helpers may be rewritten while the batch is live.')
write(d/'state.json',state)
if a.after_receipt:
 deadline=time.monotonic()+a.dependency_timeout
 while not a.after_receipt.exists():
  if (d/'stop.request').exists():state['status']='stopped-before-build';write(d/'state.json',state);sys.exit(0)
  if time.monotonic()>deadline:state['status']='dependency-timeout';write(d/'state.json',state);sys.exit(1)
  time.sleep(1)
for task in a.locales:
 code,cycle=(task.split(':',1)+['01'])[:2] if ':' in task else (task,'01')
 assert cycle.isalnum()
 if (d/'stop.request').exists():state['status']='stopped-between-builds';break
 assert all(sha(Path(p))==v for p,v in pins.items()),'Shared helper drift: preserve current outputs and reconcile before another build'
 assert code!='ru' and (ROOT/'localization/languages'/(code+'.json')).is_file()
 assert not (FAMILY/(code+'-resources-'+cycle+'.json')).exists(),'Already prepared; choose only pending locale versions'
 with (d/(code+'.log')).open('wb') as log:
  child=subprocess.Popen([sys.executable,'-B',str(ROOT/'tools/prepare_language_screens.py'),code,'--cycle',cycle],stdout=log,stderr=subprocess.STDOUT,start_new_session=True)
  state.update(status='building',current=code,cycle=cycle,childPid=child.pid);write(d/'state.json',state);rc=child.wait()
 state['lastExitCode']=rc
 if rc:
  state['status']='failed';break
 receipt=FAMILY/(code+'-resources-'+cycle+'.json');result=read(receipt);assert result['languageSha256']==sha(ROOT/'localization/languages'/(code+'.json'))
 state['completed'].append(dict(locale=code,receipt=str(receipt),sha256=sha(receipt)));state.pop('current',None);state.pop('childPid',None);write(d/'state.json',state)
else:state['status']='complete'
write(d/'state.json',state);print(json.dumps(dict(status=state['status'],completed=len(state['completed']))))
sys.exit(1 if state['status'] in ['failed','dependency-timeout'] else 0)
