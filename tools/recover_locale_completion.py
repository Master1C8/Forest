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
from prepare_locale_completion import CONTRACT as BASE_CONTRACT
from locale_queue import read,sha,write,local,assert_idle
from cli_job_support import cli_events,cli_turn_succeeded,validate_model

ROOT=Path('/Users/antonkrutov/Desktop/Forest')


def reconcile_adopted_terminal(state,record,result,phase,thread,usage):
    """Repair the old observer's missing final metadata, never repeat its turn."""
    actual=sha(phase/'result.json')
    if record.get('resultSha256')==actual:return None
    if not (record.get('resultSha256') is None and record.get('status')=='running-adopted'
            and record.get('exitCodeKnown') is False and record.get('threadId')==thread
            and record.get('measuredUsage')==usage and result['outcome']==state['status']):
        raise ValueError('Terminal lane differs from accepted result')
    return dict(status='phase-complete-after-adoption-reconciliation',resultSha256=actual,
                summary=result['summary'],progress=result.get('progress'),outcome=result['outcome'],
                verifiedReviewCoverage=result.get('verifiedReviewCoverage'))


def owns_claim(root,job,state,record,claim,group):
    if read(claim)['pid']==group['pid']:return True
    if not job.get('resumeReceipt'):return False
    path=local(root,job['resumeReceipt'])
    if sha(path)!=job['resumeReceiptSha256']:return False
    prior=read(path)
    if prior.get('kind')=='retained-terminal-lane':
        return (state.get('status') in {'blocked','static-complete','held-dispatch-policy'}
                and prior.get('previousStatusSha256')==sha(local(root,job['directory'])/'status.json')
                and prior.get('previousClaimSha256')==sha(claim)
                and prior.get('threadId')==record.get('threadId'))
    if state.get('supervisorPid')!=group['pid']:return False
    return (prior.get('kind')=='live-observer-handoff' and prior.get('threadId')==record.get('threadId')
            and prior.get('previousClaimSha256')==sha(claim))


def prepare(previous,new,handoff=False,overrides=None):
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
        return finish_prepare(previous,new,plan,group,observer_identity,overrides)
    except BaseException:
        if handoff and runner.process_identity(group['pid'],previous,observer_identity):
            os.kill(group['pid'],signal.SIGCONT)
        raise


def finish_prepare(previous,new,plan,group,observer_identity,overrides=None):
    handoff=observer_identity is not None;resolved=[]
    selections=read(overrides) if overrides else {}
    for job in plan['jobs']:
        lane=local(ROOT,job['directory'])
        state=read(lane/'status.json')
        adopting=handoff and state['status']=='running'
        retained=state['status'] in {'blocked','static-complete','held-dispatch-policy'}
        capacity=state['status']=='held-request-outcome' and runner.capacity_failure(state['phases'][-1],Path(state['phases'][-1]['phase'])/'events.jsonl')
        if state['status']!='held-supervisor-error' and not adopting and not capacity and not retained:raise ValueError('Only verified running, terminal or failed lanes are recoverable')
        if not adopting:assert_idle(lane)
        record=state['phases'][-1];phase=Path(record['phase'])
        thread,usage,errors=cli_events(phase/'events.jsonl')
        reconciled=None
        if not adopting and not capacity and not retained:
            if not cli_turn_succeeded(0,usage,errors) or thread!=record.get('threadId'):
                raise ValueError('Actual successful turn is not verified; no retry')
            if record.get('exitCode')!=0:
                prior_path=local(ROOT,job['resumeReceipt'])
                if sha(prior_path)!=job['resumeReceiptSha256']:raise ValueError('Adoption provenance changed')
                prior=read(prior_path)
                if prior.get('kind')!='live-observer-handoff' or prior.get('threadId')!=thread or runner.process_identity(record['pid'],phase):
                    raise ValueError('Unknown OS result lacks exact adopted-turn provenance')
                reconciled=dict(exitCode=None,exitCodeKnown=False,threadId=thread,measuredUsage=usage,errors=errors,
                    terminalObservedAt=runner.now(),completionEvidence='Reconciled successful model turn and absent exact adopted process; OS exit code remains unknown')
            elif usage!=record.get('measuredUsage'):
                raise ValueError('Terminal usage differs from checkpoint')
        runtime=read(phase/'runtime-verification.json')
        if runtime['threadId']!=thread or runtime['actualRuntime']['turn']!={'model':'gpt-6.1-sol','effort':'high'} or runtime['actualRuntime']['session']['model_provider']!='openai' or runtime['actualRuntime']['session']['parent_thread_id'] is not None:
            raise ValueError('Prior request model/history provenance differs')
        for name,digest in job['immutablePins'].items():
            p=Path(name) if Path(name).is_absolute() else local(ROOT,name)
            if sha(p)!=digest:raise ValueError('Immutable input changed: '+name)
        result=None;terminal_reconciliation=None;task=read(phase/'task.json')['task'];seen=set()
        for old in state['phases'][:-1]:
            p=Path(old['phase'])/'result.json'
            if old.get('resultSha256') and sha(p)!=old['resultSha256']:raise ValueError('Accepted previous result changed')
            if p.exists():seen.update(r['sha256'] for r in read(p).get('evidence',[]))
        if not adopting and not capacity:
            result=read(phase/'result.json')
            correction=selections.get(job['locale'],{}).get('validationNextTask')
            if correction:result['nextTask']=copy.deepcopy(correction)
            runner.validate_result(ROOT,job,phase,task,result,seen)
            if retained:
                deferred=state['status']=='held-dispatch-policy'
                if deferred and (result['outcome']!='continue' or state.get('pendingTask')!=result.get('nextTask')):
                    raise ValueError('Deferred task differs from its completed owning result')
                if not deferred and result['outcome']!=state['status']:
                    raise ValueError('Terminal lane differs from accepted result')
                terminal_reconciliation=reconcile_adopted_terminal(state,record,result,phase,thread,usage)
                if runner.process_identity(record['pid'],phase) is not None:raise ValueError('Terminal lane still has a live worker')
            elif result['outcome']!='continue':raise ValueError('Completed worker did not request continuation')
        claim=lane/'continuation.lock'
        if not claim.is_file() or not owns_claim(ROOT,job,state,record,claim,group):raise ValueError('Old claim identity differs')
        child_identity=runner.process_identity(record['pid'],phase) if adopting else None
        resolved.append((job,state,record,result,claim,phase,adopting,child_identity,capacity,reconciled,retained,terminal_reconciliation))
    if not handoff:new.mkdir(parents=True)
    execution=new/'execution';execution.mkdir()
    for name in ['run_locale_completion.py','cli_job_support.py','cli_runtime_identity.py','locale_queue.py','locale_efficiency.py','locale_review_work.py','locale_dependency_wake.py','locale_dispatch_policy.py']:
        shutil.copyfile(ROOT/'tools'/name,execution/name)
    contract=BASE_CONTRACT+'\n'+POLICY
    (new/'CONTRACT.md').write_text(contract)
    if overrides:shutil.copyfile(overrides,new/'assignment-overrides.json')
    new_plan=copy.deepcopy(plan);new_plan['recoveredFrom']=str(previous);new_plan['jobs']=[]
    # Keep one inbox identity across observer handoffs, including active requests.
    new_plan['technicalInbox']=plan.get('technicalInbox',str(previous/'technical-inbox'))
    if new_plan.get('efficiencyPolicy'):new_plan['efficiencyHelper']=str(execution/'locale_efficiency.py')
    if handoff:new_plan['observerHandoff']=dict(oldPid=group['pid'],oldIdentity=observer_identity)
    else:new_plan.pop('observerHandoff',None)
    for job,state,record,result,claim,phase,adopting,child_identity,capacity,reconciled,retained,terminal_reconciliation in resolved:
        receipt_path=new/'receipts'/(job['locale']+'.json')
        interrupted_pins={};closeout=None
        if capacity:
            interrupted_pins={str(p.relative_to(ROOT)):sha(p) for p in phase.rglob('*') if p.is_file()}
            brief=new/'capacity-closeout'/job['locale']/'brief.md';brief.parent.mkdir(parents=True)
            prior_task=read(phase/'task.json')['task']
            scope='independent review packet' if prior_task['kind']=='review' else 'author/edit assignment'
            brief.write_text(f"""# Finish the interrupted {job['locale']} {scope}

The prior request at {phase} exited with code1 with a verified capacity failure after
producing draft artifacts; its terminal result is absent. This is a new bounded
closeout assignment, with no accepted coverage credited to that failed turn.
Read its original brief.md and task.json for the exact scope and full required
context. Read every assigned source/target ID and necessary context. This is a
{scope}; preserve its original role and do not invent another audit layer.
Inspect existing drafts, findings, side effects and validations, preserve their
provenance, and verify/reuse unchanged deterministic work by fingerprint.
First verify any recorded first-application postconditions against the actual
canonical files. Already stored accepted wording stays stored; do not replay an
application or overwrite existing phase-owned artifacts. Complete remaining work
in this new phase and the original permitted locale paths. Author/edit tasks
must hand new wording to a distinct independent reviewer, never self-accept it.
Do not rerun extraction or reset a completed accepted receipt. Draft judgments
need verification; never promote them by default. Write fresh reviewed output
and result.json under this new phase, retaining explicit unread/held cases.
Close the finite review packet and produce its exact next authorized task.
The same pinned Sol/high/OpenAI model is mandatory; no capacity fallback,
nested jobs, game/GUI/runtime, publication, deployment or Git work.
""")
            closeout=copy.deepcopy(prior_task)
            closeout.update(title='Finish interrupted '+job['locale']+' '+scope,
                brief=str(brief.relative_to(ROOT)),briefSha256=sha(brief))
        receipt=dict(locale=job['locale'],previousStatusSha256=sha(local(ROOT,job['directory'])/'status.json'),
            resultSha256=sha(phase/'result.json') if not adopting and not capacity else None,previousClaimSha256=sha(claim),
            validatedNextTask=result.get('nextTask') if result else closeout,interruptedArtifactPins=interrupted_pins,verifiedReviewCoverage=result.get('verifiedReviewCoverage') if result else None,
            archive=str((new/'old-checkpoints'/job['locale']).relative_to(ROOT)),
            kind='retained-terminal-lane' if retained else 'live-observer-handoff' if adopting else 'interrupted-capacity-closeout' if capacity else 'completed-turn-supervisor-schema-repair',threadId=record['threadId'],
            childIdentity=child_identity,reconciledTerminal=reconciled,workerReplay=False,priorError=state.get('reason'))
        if terminal_reconciliation:receipt['terminalReconciliation']=terminal_reconciliation
        override_file=new/'assignment-overrides.json'
        if override_file.exists() and job['locale'] in read(override_file):
            entry=read(override_file)[job['locale']]
            selected=entry.get('selectedNextTask',entry)
            if adopting or not result:raise ValueError('An active bounded assignment cannot be overridden')
            if selected.get('reviewCarryover')!=result['nextTask'].get('reviewCarryover'):
                raise ValueError('Assignment override must preserve exact pending review debt')
            if sha(local(ROOT,selected['brief']))!=selected['briefSha256']:raise ValueError('Override brief changed')
            receipt['selectedNextTask']=selected
            if entry.get('validationNextTask'):receipt['validationNextTask']=entry['validationNextTask']
        write(receipt_path,receipt)
        updated=copy.deepcopy(job);updated['resumeReceipt']=str(receipt_path.relative_to(ROOT));updated['resumeReceiptSha256']=sha(receipt_path)
        new_plan['jobs'].append(updated)
    new_plan['executionPins']={str(p.relative_to(new)):sha(p) for p in [*execution.iterdir(),new/'CONTRACT.md']}
    write(new/'plan.json',new_plan)
    return new_plan


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--previous',required=True,type=Path);parser.add_argument('--run',required=True,type=Path)
    parser.add_argument('--handoff-active',action='store_true')
    parser.add_argument('--overrides',type=Path)
    args=parser.parse_args();plan=prepare(args.previous,args.run,handoff=args.handoff_active,overrides=args.overrides)
    print(json.dumps(dict(recoveredLanes=[j['locale'] for j in plan['jobs']],completedTurnsReplayed=0),indent=2))
