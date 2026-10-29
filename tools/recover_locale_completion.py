#!/usr/bin/env python3
"""Reconcile successful completed turns rejected by the old supervisor; never rerun them."""
import argparse
import copy
import json
from pathlib import Path
import shutil
import subprocess

import run_locale_completion as runner
from locale_queue import read,sha,write,local,assert_idle
from cli_job_support import cli_events,cli_turn_succeeded,validate_model

ROOT=Path('/Users/antonkrutov/Desktop/Forest')


def prepare(previous,new):
    previous=previous.resolve();new=new.resolve()
    if new.exists() or not new.is_relative_to(ROOT/'outputs/locale-assets-20261026'):
        raise ValueError('Fresh task-owned recovery execution directory required')
    plan=read(previous/'plan.json');validate_model(plan['model']['name'],plan['model']['reasoning'],plan['model']['provider'])
    group=read(previous/'status.json')
    if group['status']!='all-lanes-terminal':raise ValueError('Old observer has not reached a reconciled terminal state')
    assert_idle(previous)
    for name,digest in plan['executionPins'].items():
        if sha(previous/name)!=digest:raise ValueError('Preserved old execution changed')
    resolved=[]
    for job in plan['jobs']:
        lane=local(ROOT,job['directory']);assert_idle(lane)
        state=read(lane/'status.json')
        if state['status']!='held-supervisor-error':raise ValueError('Only the exact observed supervisor failure is recoverable')
        record=state['phases'][-1];phase=Path(record['phase'])
        thread,usage,errors=cli_events(phase/'events.jsonl')
        if record.get('exitCode')!=0 or not cli_turn_succeeded(0,usage,errors) or thread!=record.get('threadId') or usage!=record.get('measuredUsage'):
            raise ValueError('Actual successful turn is not verified; no retry')
        runtime=read(phase/'runtime-verification.json')
        if runtime['threadId']!=thread or runtime['actualRuntime']['turn']!={'model':'gpt-6.1-sol','effort':'high'} or runtime['actualRuntime']['session']['model_provider']!='openai' or runtime['actualRuntime']['session']['parent_thread_id'] is not None:
            raise ValueError('Prior request model/history provenance differs')
        for name,digest in job['immutablePins'].items():
            p=Path(name) if Path(name).is_absolute() else local(ROOT,name)
            if sha(p)!=digest:raise ValueError('Immutable input changed: '+name)
        result=read(phase/'result.json');task=read(phase/'task.json')['task'];seen=set()
        for old in state['phases'][:-1]:
            p=Path(old['phase'])/'result.json'
            if old.get('resultSha256') and sha(p)!=old['resultSha256']:raise ValueError('Accepted previous result changed')
            if p.exists():seen.update(r['sha256'] for r in read(p).get('evidence',[]))
        runner.validate_result(ROOT,job,phase,task,result,seen)
        if result['outcome']!='continue':raise ValueError('Completed worker did not request continuation')
        claim=lane/'continuation.lock'
        if not claim.is_file() or read(claim)['pid']!=group['pid']:raise ValueError('Old claim identity differs')
        resolved.append((job,state,record,result,claim,phase))
    new.mkdir(parents=True);execution=new/'execution';execution.mkdir()
    for name in ['run_locale_completion.py','cli_job_support.py','cli_runtime_identity.py','locale_queue.py']:
        shutil.copyfile(ROOT/'tools'/name,execution/name)
    contract=(previous/'CONTRACT.md').read_text()+'''

## Supervisor repair: preserve non-pass and unread dispositions

Review verdicts are pass, clean, finding, needs-context, source-defect,
technical-preservation, needs-repair, needs-review, held-source or
context-only-preserve. They remain distinct; non-pass never becomes clean.
context-only-preserve requires unchanged source/target hashes, targetEdited:false
and notLinguisticCoverage:true. For explicitly unread rows use reviewed:false
and needs-review; never assign a default pass. Carry exactly those unread IDs
and versions into the next fresh review packet. Retain completed matching
judgments; partial review is not full coverage. All assigned IDs still need a
row, with explicit unread status for the remainder.

Every next review task should specify reviewPacket directly. A complete,
uniquely bound structured next-review manifest may supply it instead; every
dependency and current next-brief hash must match. Missing/ambiguous packets
still reject. This repairs transport/schema handling, not semantic acceptance.
'''
    (new/'CONTRACT.md').write_text(contract)
    new_plan=copy.deepcopy(plan);new_plan['recoveredFrom']=str(previous);new_plan['jobs']=[]
    for job,state,record,result,claim,phase in resolved:
        receipt_path=new/'receipts'/(job['locale']+'.json')
        receipt=dict(locale=job['locale'],previousStatusSha256=sha(local(ROOT,job['directory'])/'status.json'),
            resultSha256=sha(phase/'result.json'),previousClaimSha256=sha(claim),
            validatedNextTask=result['nextTask'],verifiedReviewCoverage=result.get('verifiedReviewCoverage'),
            archive=str((new/'old-checkpoints'/job['locale']).relative_to(ROOT)),
            kind='completed-turn-supervisor-schema-repair',threadId=record['threadId'],
            workerReplay=False,priorError=state['reason'])
        write(receipt_path,receipt)
        updated=copy.deepcopy(job);updated['resumeReceipt']=str(receipt_path.relative_to(ROOT));updated['resumeReceiptSha256']=sha(receipt_path)
        new_plan['jobs'].append(updated)
    new_plan['executionPins']={str(p.relative_to(new)):sha(p) for p in [*execution.iterdir(),new/'CONTRACT.md']}
    write(new/'plan.json',new_plan)
    return new_plan


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--previous',required=True,type=Path);parser.add_argument('--run',required=True,type=Path)
    args=parser.parse_args();plan=prepare(args.previous,args.run)
    print(json.dumps(dict(recoveredLanes=[j['locale'] for j in plan['jobs']],completedTurnsReplayed=0),indent=2))
