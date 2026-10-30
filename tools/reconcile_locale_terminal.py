"""Reconcile verified completed lanes after an observer startup error; no models.

The immutable repair plan supports interruption between status and claim writes.
Every path must still match its exact before or after version. No other journal,
worker, source, translation or artifact is modified.
"""
import argparse
import hashlib
import json
from pathlib import Path

import run_locale_completion as runner
from cli_job_support import cli_events, cli_turn_succeeded, validate_model
from locale_queue import read, sha, local


def require(ok, why):
    if not ok: raise ValueError(why)


def raw(value): return (json.dumps(value,ensure_ascii=False,indent=2)+'\n').encode()
def digest(value): return hashlib.sha256(raw(value)).hexdigest()


def prepare(root, directory, output):
    plan=read(directory/'plan.json');group=read(directory/'status.json')
    validate_model(plan['model']['name'],plan['model']['reasoning'],plan['model']['provider'])
    require(group['status']=='running' and runner.process_identity(group['pid'],directory) is not None,'verified-live-observer-required')
    changes=[];evidence=[]
    for job in plan['jobs']:
        lane=local(root,job['directory']);status=lane/'status.json';state=read(status)
        if state['status']!='held-supervisor-error' or state.get('failureBoundary')!='lane-startup-or-adoption':continue
        record=state['phases'][-1];phase=Path(record['phase']);result_path=phase/'result.json'
        require(runner.process_identity(record['pid'],phase) is None,'terminal-worker-still-alive')
        receipt_path=local(root,job['resumeReceipt']);require(sha(receipt_path)==job['resumeReceiptSha256'],'prior-receipt-changed')
        receipt=read(receipt_path);result=read(result_path)
        require(receipt['kind']=='retained-terminal-lane' and receipt['resultSha256']==sha(result_path)
                and result['outcome'] in {'blocked','static-complete'},'verified-terminal-receipt-required')
        thread,usage,errors=cli_events(phase/'events.jsonl')
        require(cli_turn_succeeded(0,usage,errors) and thread==record['threadId']==receipt['threadId']
                and usage==record['measuredUsage'],'terminal-turn-not-verified')
        runtime=read(phase/'runtime-verification.json');actual=runtime['actualRuntime']
        require(runtime['threadId']==thread and actual['turn']=={'model':'gpt-6.1-sol','effort':'high'}
                and actual['session']['model_provider']=='openai' and actual['session']['parent_thread_id'] is None,'terminal-runtime-selection')
        task=read(phase/'task.json')['task'];runner.validate_result(root,job,phase,task,result,set())
        require(record.get('resultSha256') in {None,sha(result_path)},'terminal-result-drift')
        claim=lane/'continuation.lock';require(sha(claim)==receipt['previousClaimSha256'],'terminal-claim-changed')
        old_status=sha(status);old_claim=sha(claim)
        record.update(status='phase-complete-after-terminal-journal-repair',resultSha256=sha(result_path),
            summary=result['summary'],progress=result.get('progress'),outcome=result['outcome'],verifiedReviewCoverage=result.get('verifiedReviewCoverage'))
        state.update(status=result['outcome'],reason=result['summary'],supervisorPid=group['pid'])
        for key in ['failureBoundary','warning','observedAt']:state.pop(key,None)
        state.setdefault('journalRepairs',[]).append(dict(priorStatusSha256=old_status,priorClaimSha256=old_claim,at=runner.now(),workerReplayed=False))
        new_claim=dict(pid=group['pid'],at=runner.now(),reconciledFrom=read(claim)['pid'])
        for path,before,after in [(status,old_status,state),(claim,old_claim,new_claim)]:
            changes.append(dict(path=str(path.relative_to(root)),beforeSha256=before,afterSha256=digest(after),after=after))
        evidence.extend([dict(path=str(p.relative_to(root)),sha256=sha(p)) for p in [result_path,receipt_path,phase/'runtime-verification.json',phase/'events.jsonl']])
    require(bool(changes),'no-eligible-terminal-journal-repair')
    output.mkdir(parents=True)
    for i,item in enumerate(changes):
        path=local(root,item['path']);require(sha(path)==item['beforeSha256'],'journal-changed-before-snapshot')
        (output/f'before-{i}.json').write_bytes(path.read_bytes())
    repair=dict(kind='verified-terminal-journal-repair',observerPid=group['pid'],observerDirectory=str(directory),
        observerIdentity=runner.process_identity(group['pid'],directory),changes=changes,evidence=evidence,modelRequests=0,
        boundary='Per-file atomic replacement, no cross-file transaction. Resume this exact plan after interruption.')
    runner.save(output/'plan.json',repair)
    return output/'plan.json'


def apply(root, plan_path, fail_after=None):
    data=read(plan_path)
    if data.get('observerDirectory'):
        require(runner.process_identity(data['observerPid'],Path(data['observerDirectory']),data['observerIdentity']) is not None,'repair-observer-identity-changed')
    for pin in data.get('evidence',[]):require(sha(local(root,pin['path']))==pin['sha256'],'repair-evidence-changed')
    for item in data['changes']:
        require(sha(local(root,item['path'])) in {item['beforeSha256'],item['afterSha256']},'unknown-journal-version')
        require(digest(item['after'])==item['afterSha256'],'repair-plan-after-version')
    written=0
    for item in data['changes']:
        path=local(root,item['path'])
        if sha(path)==item['afterSha256']:continue
        require(sha(path)==item['beforeSha256'],'journal-changed-before-write')
        runner.save(path,item['after']);written+=1
        if written==fail_after:raise InterruptedError('journal-repair-between-writes')
    require(all(sha(local(root,c['path']))==c['afterSha256'] for c in data['changes']),'journal-repair-postcondition')
    runner.save(plan_path.parent/'applied.json',dict(planSha256=sha(plan_path),paths=[c['path'] for c in data['changes']],modelRequests=0))
    return dict(status='terminal-journals-reconciled',paths=len(data['changes']),modelRequests=0)


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--root',type=Path,default=Path(__file__).resolve().parents[1]);p.add_argument('--run',type=Path);p.add_argument('--output',type=Path);p.add_argument('--apply-plan',type=Path);a=p.parse_args()
    plan=a.apply_plan or prepare(a.root,a.run.resolve(),a.output.resolve())
    print(json.dumps(apply(a.root,plan)))
