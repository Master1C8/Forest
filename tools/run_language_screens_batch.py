"""Finite sequential native capture and per-frame fresh CLI review.

Stops on the first unknown state, transport failure or visual finding. Existing
accepted originals are never overwritten. No save edits or publication.
"""
import argparse,hashlib,json,os,subprocess,sys,time,datetime
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1];FAMILY=ROOT/'localization/screenshots/all30-owner-20261104-01'
def read(p):return json.loads(p.read_bytes())
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def write(p,v):
 t=p.with_suffix('.pending');t.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n');t.replace(p)
def refresh_progress():
 p=FAMILY/'progress.json';d=read(p)
 for row in d['locales']:
  code=row['locale'];folder=FAMILY/code
  if code=='ru':continue
  accepted=folder/'final/acceptance.json'
  if accepted.exists() and read(accepted)['passed'] and read(accepted)['languageSha256']==sha(ROOT/'localization/languages'/(code+'.json')):row.update(captured=7,visuallyPassed=7,status='passed',final=str(accepted.parent))
  else:
   capture_sets=list(folder.glob('*/capture.json'));captured=set()
   for q in capture_sets:captured.update(x['order']for x in read(q)['images'])
   # Historical passes from different renderer versions are not one accepted set.
   row.update(captured=len(captured),visuallyPassed=0)
  row['resourcesPrepared']=row['resourcesPrepared']or any(FAMILY.glob(code+'-resources-*.json'))
 d.update(updatedAt=datetime.datetime.now(datetime.timezone.utc).isoformat(),newCaptured=sum(x['captured']for x in d['locales']if x['locale']!='ru' and x['visuallyPassed']==7),capturedAtAnyVersion=sum(x['captured']for x in d['locales']),passed=sum(x['visuallyPassed']for x in d['locales']),countingNote='passed/newCaptured count final accepted version-bound slots only; capturedAtAnyVersion includes historical candidates. Individual judgments remain in their immutable reviews.');write(p,d)
p=argparse.ArgumentParser(description=__doc__);p.add_argument('plan',type=Path);p.add_argument('--name',required=True);a=p.parse_args();assert a.name.isalnum();plan=read(a.plan);d=FAMILY/('capture-batch-'+a.name);d.mkdir(exist_ok=False)
pin_paths=[ROOT/'tools'/n for n in ['capture_language_screens.py','review_language_screens.py','finalize_language_screens.py','review_screenshots.py']]+list((ROOT/'tools/probe').glob('*.py'))+list((ROOT/'tools/probe').glob('*.cs'))
pins={str(p):sha(p)for p in pin_paths};state=dict(pid=os.getpid(),status='starting',completed=[],sourcePins=pins,planSha256=sha(a.plan));write(d/'state.json',state)
def check():
 assert all(sha(Path(p))==v for p,v in pins.items()),'Capture/review helper drift; reconcile before new work'
 return not(d/'stop.request').exists()
for task in plan['tasks']:
 if not check():state['status']='stopped-between-locales';break
 code=task['locale'];attempt=task.get('attempt','01');cycle=task.get('cycle','01');receipt=FAMILY/(code+'-resources-'+cycle+'.json')
 state.update(current=code,attempt=attempt,cycle=cycle,status='waiting-resource');write(d/'state.json',state);deadline=time.monotonic()+12*3600
 required=[receipt]
 if task.get('reuseEvidence'):required.append(Path(task['reuseEvidence']).resolve())
 while not all(path.exists() for path in required):
  if not check():state['status']='stopped-before-capture';write(d/'state.json',state);sys.exit(0)
  if time.monotonic()>deadline:raise TimeoutError('Resource/reuse evidence deadline: '+code)
  time.sleep(1)
 resource=read(receipt);assert resource['languageSha256']==sha(ROOT/'localization/languages'/(code+'.json'))
 if task.get('reuseEvidence'):assert read(Path(task['reuseEvidence']))['passed'],'Reuse proof must pass before dependent capture'
 overlay=Path(resource['native']);orders=task.get('orders',list(range(1,8)));run=ROOT/'localization/probes'/('locale-owner-shots-20261104-'+code+'-'+attempt)
 command=[sys.executable,'-B',str(ROOT/'tools/capture_language_screens.py'),code,'--overlay',str(overlay),'--attempt',attempt,'--orders',','.join(map(str,orders))]
 with(d/(code+'-capture.log')).open('wb')as log:
  child=subprocess.Popen(command,stdout=log,stderr=subprocess.STDOUT,start_new_session=True);state.update(status='capturing',childPid=child.pid,run=str(run));write(d/'state.json',state)
  while child.poll()is None:
   pointer=FAMILY/'current-capture.json'
   if pointer.exists():
    current=read(pointer)
    if current.get('run')==str(run)and current.get('state')=='awaiting-background'and not(run/'background-ready.json').exists():
     assert(run/'bridge-ready.txt').exists()
     write(run/'background-ready.json',dict(background=False,hidden=False,method='Finite native framebuffer capture with no OS activation. Best-effort background preference: earlier hidden-window captures stalled; preserve guarded frame delivery.'))
   time.sleep(.5)
 if child.returncode:
  state.update(status='capture-failed',exitCode=child.returncode);write(d/'state.json',state);break
 capture=FAMILY/code/attempt;assert read(capture/'capture.json')['cleanup']['taskProcessStopped'];check();refresh_progress()
 with(d/(code+'-review.log')).open('wb')as log:
  child=subprocess.Popen([sys.executable,'-B',str(ROOT/'tools/review_language_screens.py'),code,'--attempt',attempt,'--execute'],stdout=log,stderr=subprocess.STDOUT,start_new_session=True);state.update(status='reviewing',childPid=child.pid);write(d/'state.json',state);rc=child.wait()
 if rc:
  state.update(status='review-transport-failed',exitCode=rc);write(d/'state.json',state);break
 result=read(capture/'result.json');refresh_progress()
 if result['status']!='passed':state.update(status='visual-findings',result=result);write(d/'state.json',state);break
 frames=[]
 for order in range(1,8):
  src=capture if order in orders else FAMILY/code/task['reuseAttempt']
  if order not in orders and str(order) in task.get('reuseCaptures',{}):
   src=Path(task['reuseCaptures'][str(order)]).resolve();assert src.is_relative_to(FAMILY/code)
  review=src/'review.json'
  if order not in orders and str(order) in task.get('reuseReviews',{}):
   review=Path(task['reuseReviews'][str(order)]).resolve();assert review.is_relative_to(FAMILY/code)
  frames.append(dict(order=order,capture=str(src),review=str(review)))
 final=dict(locale=code,nativeResources=str(overlay),affectedOrders=orders,frames=frames)
 if task.get('reuseEvidence'):
  evidence=Path(task['reuseEvidence']).resolve();final.update(reuseEvidence=dict(path=str(evidence),sha256=sha(evidence)),reuseJustification=task['reuseJustification'])
 write(capture/'finalization-plan.json',final)
 if task.get('preserveFinalAs'):
  current=FAMILY/code/'final';backup=FAMILY/code/task['preserveFinalAs']
  assert backup.parent==FAMILY/code and backup.name.startswith('final-before-') and not backup.exists()
  assert sha(current/'acceptance.json')==task['previousAcceptanceSha256'],'Prior accepted final changed'
  with(d/(code+'-finalize-preflight.log')).open('wb')as log:
   rc=subprocess.run([sys.executable,'-B',str(ROOT/'tools/finalize_language_screens.py'),str(capture/'finalization-plan.json'),'--check-only'],stdout=log,stderr=subprocess.STDOUT).returncode
  if rc:state.update(status='integration-preflight-failed',exitCode=rc);write(d/'state.json',state);break
  current.rename(backup)
 with(d/(code+'-finalize.log')).open('wb')as log:rc=subprocess.run([sys.executable,'-B',str(ROOT/'tools/finalize_language_screens.py'),str(capture/'finalization-plan.json')],stdout=log,stderr=subprocess.STDOUT).returncode
 if rc:state.update(status='integration-failed',exitCode=rc);write(d/'state.json',state);break
 state['completed'].append(dict(locale=code,final=str(FAMILY/code/'final')));state.pop('childPid',None);write(d/'state.json',state);refresh_progress()
else:state['status']='complete'
write(d/'state.json',state);print(json.dumps(dict(status=state['status'],completed=len(state['completed']))))
sys.exit(0 if state['status']=='complete'or state['status'].startswith('stopped-')else 1)
