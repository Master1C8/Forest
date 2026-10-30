#!/usr/bin/env python3
"""Reconcile successful completed turns rejected by the old supervisor; never rerun them."""
import argparse
import copy
import json
import os
from pathlib import Path
import shutil
import signal
import subprocess
import time

import run_locale_completion as runner
from locale_efficiency import POLICY
from locale_queue import read,sha,write,local,assert_idle
from cli_job_support import cli_events,cli_turn_succeeded,validate_model

ROOT=Path('/Users/antonkrutov/Desktop/Forest')


def prepare(previous,new,handoff=False):
    previous=previous.resolve();new=new.resolve()
    if new.exists() or not new.is_relative_to(ROOT/'outputs/locale-assets-20261026'):
        raise ValueError('Fresh task-owned recovery execution directory required')
    plan=read(previous/'plan.json');validate_model(plan['model']['name'],plan['model']['reasoning'],plan['model']['provider'])
    if sha(Path(plan['cli']))!=plan['cliSha256']:raise ValueError('CLI executable changed')
    group=read(previous/'status.json')
    if group['status']!='all-lanes-terminal' and not (handoff and group['status']=='running'):
        raise ValueError('Old observer has not reached a reconciled terminal state; active handoff must be explicit')
    observer_identity=None
    if handoff:
        observer_identity=runner.process_identity(group['pid'],previous)
        if observer_identity is None:raise ValueError('Expected live observer is absent')
    else:assert_idle(previous)
    for name,digest in plan['executionPins'].items():
        if sha(previous/name)!=digest:raise ValueError('Preserved old execution changed')
    if handoff:
        new.mkdir(parents=True)
        write(new/'handoff-intent.json',dict(oldPid=group['pid'],oldIdentity=observer_identity,modelRequestsStarted=0))
        if runner.process_identity(group['pid'],previous,observer_identity) is None:raise ValueError('Observer changed before pause')
        os.kill(group['pid'],signal.SIGSTOP)
        deadline=time.monotonic()+5
        while True:
            state=subprocess.run(['ps','-p',str(group['pid']),'-o','stat='],capture_output=True,text=True).stdout.strip()
            if state.startswith('T'):break
            if time.monotonic()>deadline:
                os.kill(group['pid'],signal.SIGCONT);raise ValueError('Observer pause unverified')
            time.sleep(.05)
    try:
        return finish_prepare(previous,new,plan,group,observer_identity)
    except BaseException:
        if handoff and runner.process_identity(group['pid'],previous,observer_identity):
            os.kill(group['pid'],signal.SIGCONT)
        raise


def finish_prepare(previous,new,plan,group,observer_identity):
    handoff=observer_identity is not None;resolved=[]
    for job in plan['jobs']:
        lane=local(ROOT,job['directory'])
        state=read(lane/'status.json')
        adopting=handoff and state['status']=='running'
        capacity=state['status']=='held-request-outcome' and runner.capacity_failure(state['phases'][-1],Path(state['phases'][-1]['phase'])/'events.jsonl')
        if state['status']!='held-supervisor-error' and not adopting and not capacity:raise ValueError('Only running handoffs or exact supervisor failures are recoverable')
        if not adopting:assert_idle(lane)
        record=state['phases'][-1];phase=Path(record['phase'])
        thread,usage,errors=cli_events(phase/'events.jsonl')
        if not adopting and not capacity and (record.get('exitCode')!=0 or not cli_turn_succeeded(0,usage,errors) or thread!=record.get('threadId') or usage!=record.get('measuredUsage')):
            raise ValueError('Actual successful turn is not verified; no retry')
        runtime=read(phase/'runtime-verification.json')
        if runtime['threadId']!=thread or runtime['actualRuntime']['turn']!={'model':'gpt-6.1-sol','effort':'high'} or runtime['actualRuntime']['session']['model_provider']!='openai' or runtime['actualRuntime']['session']['parent_thread_id'] is not None:
            raise ValueError('Prior request model/history provenance differs')
        for name,digest in job['immutablePins'].items():
            p=Path(name) if Path(name).is_absolute() else local(ROOT,name)
            if sha(p)!=digest:raise ValueError('Immutable input changed: '+name)
        result=None;task=read(phase/'task.json')['task'];seen=set()
        for old in state['phases'][:-1]:
            p=Path(old['phase'])/'result.json'
            if old.get('resultSha256') and sha(p)!=old['resultSha256']:raise ValueError('Accepted previous result changed')
            if p.exists():seen.update(r['sha256'] for r in read(p).get('evidence',[]))
        if not adopting and not capacity:
            result=read(phase/'result.json');runner.validate_result(ROOT,job,phase,task,result,seen)
            if result['outcome']!='continue':raise ValueError('Completed worker did not request continuation')
        claim=lane/'continuation.lock'
        if not claim.is_file() or read(claim)['pid']!=group['pid']:raise ValueError('Old claim identity differs')
        child_identity=runner.process_identity(record['pid'],phase) if adopting else None
        resolved.append((job,state,record,result,claim,phase,adopting,child_identity,capacity))
    if not handoff:new.mkdir(parents=True)
    execution=new/'execution';execution.mkdir()
    for name in ['run_locale_completion.py','cli_job_support.py','cli_runtime_identity.py','locale_queue.py','locale_efficiency.py']:
        shutil.copyfile(ROOT/'tools'/name,execution/name)
    contract=(previous/'CONTRACT.md').read_text()
    if plan.get('efficiencyPolicy') and '\n# Efficient continuous execution' in contract:
        contract=contract.split('\n# Efficient continuous execution',1)[0]
    contract=contract.replace('context-only-preserve requires unchanged source/target hashes, targetEdited:false',
        'context-only-preserve requires both hashes to match the packet, targetEdited:false')
    contract=contract.replace('Carry exactly those unread IDs\nand versions into the next fresh review packet.',
        'Carry all unread IDs and versions in the pending ledger; select a bounded nonempty subset for each fresh review packet.')
    contract+='''

## Review transport clarification

Context-only preservation may retain an already translated target. Source and
 target hashes must match their frozen packet values; targetEdited must be false,
 and no new linguistic coverage is credited. Detached exact-source preservation
 still requires equal hashes. Give either rationale, or both fidelityRationale
 and a native-language/naturalness rationale; preserve separate dimensions.

A fresh review may take a bounded nonempty subset of unread IDs. The supervisor
 carries all pending and deferred IDs across phases. Omitted rows receive no
 credit and completion cannot skip them. Preserve other required context
 components. Next briefs are bounded to 64 KiB and owned by the completed phase.

An explicitly reconciled capacity failure may receive one fresh bounded closeout
 assignment on the same pinned model. Preserve failed-request provenance and
 draft artifacts, read all assigned IDs/context, and never credit drafts as
 accepted judgments without verification. A repeated failure holds for diagnosis;
 no fallback model or automatic failed-request retry is permitted.
'''
    if plan.get('efficiencyPolicy'):contract+='\n'+POLICY
    (new/'CONTRACT.md').write_text(contract)
    new_plan=copy.deepcopy(plan);new_plan['recoveredFrom']=str(previous);new_plan['jobs']=[]
    if new_plan.get('efficiencyPolicy'):new_plan['efficiencyHelper']=str(execution/'locale_efficiency.py')
    if handoff:new_plan['observerHandoff']=dict(oldPid=group['pid'],oldIdentity=observer_identity)
    else:new_plan.pop('observerHandoff',None)
    for job,state,record,result,claim,phase,adopting,child_identity,capacity in resolved:
        receipt_path=new/'receipts'/(job['locale']+'.json')
        interrupted_pins={};closeout=None
        if capacity:
            interrupted_pins={str(p.relative_to(ROOT)):sha(p) for p in phase.rglob('*') if p.is_file()}
            brief=new/'capacity-closeout'/job['locale']/'brief.md';brief.parent.mkdir(parents=True)
            brief.write_text(f"""# Finish the interrupted {job['locale']} review packet

The prior request at {phase} exited with code1 with a verified capacity failure after
producing draft artifacts; its terminal result is absent. This is a new bounded
closeout assignment, with no accepted coverage credited to that failed turn.
Read its original brief.md and task.json for the exact scope and full required
context. Independently read every assigned source/target ID and required context.
Inspect the existing draft reviews, findings and validations, preserve their
provenance, and verify/reuse unchanged deterministic work by fingerprint.
Do not rerun extraction or reset a completed accepted receipt. Draft judgments
need verification; never promote them by default. Write fresh reviewed output
and result.json under this new phase, retaining explicit unread/held cases.
Close the finite review packet and produce its exact next authorized task.
The same pinned Sol/high/OpenAI model is mandatory; no capacity fallback,
nested jobs, game/GUI/runtime, publication, deployment or Git work.
""")
            closeout=copy.deepcopy(read(phase/'task.json')['task'])
            closeout.update(title='Close interrupted '+job['locale']+' independent review packet',
                brief=str(brief.relative_to(ROOT)),briefSha256=sha(brief))
        receipt=dict(locale=job['locale'],previousStatusSha256=sha(local(ROOT,job['directory'])/'status.json'),
            resultSha256=sha(phase/'result.json') if not adopting and not capacity else None,previousClaimSha256=sha(claim),
            validatedNextTask=result['nextTask'] if result else closeout,interruptedArtifactPins=interrupted_pins,verifiedReviewCoverage=result.get('verifiedReviewCoverage') if result else None,
            archive=str((new/'old-checkpoints'/job['locale']).relative_to(ROOT)),
            kind='live-observer-handoff' if adopting else 'interrupted-capacity-closeout' if capacity else 'completed-turn-supervisor-schema-repair',threadId=record['threadId'],
            childIdentity=child_identity,workerReplay=False,priorError=state.get('reason'))
        write(receipt_path,receipt)
        updated=copy.deepcopy(job);updated['resumeReceipt']=str(receipt_path.relative_to(ROOT));updated['resumeReceiptSha256']=sha(receipt_path)
        new_plan['jobs'].append(updated)
    new_plan['executionPins']={str(p.relative_to(new)):sha(p) for p in [*execution.iterdir(),new/'CONTRACT.md']}
    write(new/'plan.json',new_plan)
    return new_plan


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--previous',required=True,type=Path);parser.add_argument('--run',required=True,type=Path)
    parser.add_argument('--handoff-active',action='store_true')
    args=parser.parse_args();plan=prepare(args.previous,args.run,handoff=args.handoff_active)
    print(json.dumps(dict(recoveredLanes=[j['locale'] for j in plan['jobs']],completedTurnsReplayed=0),indent=2))
