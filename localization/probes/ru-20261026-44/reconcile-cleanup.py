"""Reconcile one completed read-only diagnostic FAIL; cleanup commands only, no replay."""
from pathlib import Path
import datetime,hashlib,json,shutil,subprocess,sys,time
run=Path(__file__).resolve().parent
assert run.name=='ru-20261026-44'
source=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest');data='The Forest of Love_Data'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def load(n):return json.loads((run/n).read_text())
def write(n,v):(run/n).write_text(json.dumps(v,indent=2)+'\n')
def now():return datetime.datetime.now(datetime.timezone.utc).isoformat()
def ps():return subprocess.check_output(['ps','-axo','pid,ppid,lstart,command'],text=True).splitlines()
assert not (run/'command-reconciliation.json').exists() and not (run/'reconciled-cleanup.json').exists()
original_cleanup=load('cleanup.json');observer=load('observer-exit.json');identity=load('observer-child.json')
assert observer['returnCode']==1 and observer['observerPid']==identity['observerPid']
assert original_cleanup['unresolvedCommand']=='dump-save-continuation' and not original_cleanup['quitAcknowledged']
assert not (run/'command.txt').exists() and not (run/'command.pending').exists()
lifetime=[json.loads(x) for x in (run/'process-lifetime.jsonl').read_text().splitlines()]
returned=[r for r in lifetime if r['boundary']=='transport-returned' and r['command']=='dump-save-continuation'][-1]
reaped=[r for r in lifetime if r['boundary']=='transport-reaped' and r['command']=='dump-save-continuation'][-1]
assert returned['transportExitCode']==reaped['transportExitCode']==1
assert returned['transportPid']==reaped['transportPid'] and reaped['transportStoppedByObserver'] is False
lines=(run/'actions.log').read_text().splitlines()
fails=[r for r in lines if ' FAIL ' in r]
assert len(fails)==1 and ' FAIL dump-save-continuation System.NullReferenceException:' in fails[0]
assert 'OK menu PlayMenu OnClickContinue' in '\n'.join(lines)
assert not any(' OK ' in r for r in lines[lines.index(fails[0])+1:]),'A later command needs separate reconciliation'
rows=ps();pids=[identity['observerPid'],identity['wrapperPid'],returned['transportPid']]
assert all(not any(r.strip().split(None,1)[0]==str(p) for r in rows if r.strip()) for p in pids)
owned_pids=[int(r.split()[0]) for r in original_cleanup['remainingTaskProcessRows']]
owned=[r.strip() for r in rows if r.strip() and r.split()[0] in list(map(str,owned_pids))]
assert len(owned)==3 and all('ru-20261026-44' in r for r in owned)
frozen=load('frozen-files.json')
assert all((run/n).is_file() and sha(run/n)==h for n,h in frozen.items()),'Frozen candidate changed before cleanup'
# Keep exact pre-cleanup evidence: later cleanup appends actions but never replaces a failed receipt.
snapshot=run/'failure-snapshot';snapshot.mkdir()
for n in ['actions.log','process-lifetime.jsonl','observer-exit.json','runtime-result.json','cleanup.json','save-continuation.json','intro-state.json']:
 shutil.copy2(run/n,snapshot/n)
reconciliation=dict(verifiedAt=now(),decision='Completed read-only native diagnostic FAIL reconciled for normal cleanup only; no dump retry or story progression',nativeFailure=fails[0],transportPid=returned['transportPid'],transportExitCode=1,transportStoppedByObserver=False,unknownSubmission=False,pendingCommand=False,exactProcesses=owned,absentObserverWrapperTransportPids=pids,historicalObserverExit=1,historicalFailurePreserved=True,sourceBoundary='Frozen DumpSaveContinuation and its source-pinned read-only getters have no story/scene/save/eligibility writes; exact native FAIL and completed helper prove no pending command. The first diagnostic failure remains a failed runtime.',sourceSha256=sha(run/'bridge-source/ForestProbe.cs'),frozenManifestSha256=sha(run/'frozen-files.json'),snapshot={p.name:sha(p) for p in snapshot.iterdir()},allowedNextCommands=['restore-input-policy','quit'],forbidden='Any story/dump/input/replay/force signal; DLL replacement while game/crash live')
write('command-reconciliation.json',reconciliation)
result=dict(startedAt=now(),reconciliationSha256=sha(run/'command-reconciliation.json'),before=owned,commands=[],status='cleanup-in-progress',storyCommands=0,imagesOpened=0,imagesCaptured=0,launcherExitCode=None,gameExitCode=None)
write('reconciled-cleanup.json',result)
for value in ['restore-input-policy','quit']:
 assert not (run/'command.txt').exists() and not (run/'command.pending').exists()
 offset=(run/'actions.log').stat().st_size
 cmd=dict(command=value,actionLogOffset=offset,startedAt=now(),status='submitted')
 result['commands'].append(cmd);write('reconciled-cleanup.json',result)
 child=subprocess.Popen([sys.executable,str(run/'command.py'),str(run),value],stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True)
 cmd['transportPid']=child.pid;write('reconciled-cleanup.json',result)
 try:stdout,stderr=child.communicate(timeout=25)
 except subprocess.TimeoutExpired:
  cmd['status']='unknown-timeout';write('reconciled-cleanup.json',result);raise
 cmd.update(transportExitCode=child.returncode,stdout=stdout,stderr=stderr,endedAt=now())
 suffix=(run/'actions.log').read_bytes()[offset:].decode()
 cmd['actionLogSuffix']=suffix
 assert child.returncode==0 and len(suffix.splitlines())==1 and suffix.split(' OK ',1)[-1].strip()==value,'Cleanup unknown; hold'
 cmd['status']='acknowledged';write('reconciled-cleanup.json',result)
limit=time.monotonic()+30
while time.monotonic()<limit:
 rows=ps();remaining=[r.strip() for r in rows if r.strip() and r.split()[0] in list(map(str,owned_pids))]
 if not remaining:break
 time.sleep(.5)
result['remaining']=remaining
assert not remaining,'Exact task processes remain; no DLL replacement'
managed=run/'game'/data/'Managed'
shutil.copy2(source/data/'Managed/Assembly-CSharp.dll',managed/'Assembly-CSharp.dll');(managed/'ForestProbe.dll').unlink()
result.update(status='known-clear-cleanup-complete',finishedAt=now(),originalQAAssemblyRestored=sha(managed/'Assembly-CSharp.dll')==sha(source/data/'Managed/Assembly-CSharp.dll'),inspectionBridgeRemoved=not (managed/'ForestProbe.dll').exists())
write('reconciled-cleanup.json',result)
print(json.dumps(result,indent=2))
