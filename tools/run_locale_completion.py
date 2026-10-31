#!/usr/bin/env python3
"""Durable fresh-context localization lanes with automatic evidence-bound continuation."""
import argparse
import copy
import concurrent.futures
import datetime
import hashlib
import json
import os
from pathlib import Path
import subprocess
import time

from cli_job_support import validate_model, cli_events, cli_turn_succeeded
from cli_runtime_identity import publish_current_runtime
from locale_queue import sha, read, local
from locale_efficiency import make_view
import locale_dependency_wake as dependency_wake
import locale_dispatch_policy as dispatch_policy

KINDS = {'work','review','technical'}
MAX_BRIEF_BYTES = 65536
REVIEW_VERDICTS = {'pass','clean','finding','needs-context','source-defect','technical-preservation',
                   'needs-repair','needs-review','held-source','context-only-preserve'}


def now():return datetime.datetime.now(datetime.timezone.utc).isoformat()


def save(path,data):
    pending=path.with_suffix(path.suffix+'.pending')
    with pending.open('x') as f:json.dump(data,f,ensure_ascii=False,indent=2);f.write('\n')
    pending.replace(path)


def permitted(root,path,prefixes):
    resolved=path.resolve()
    return any(resolved.is_relative_to(local(root,prefix)) for prefix in prefixes)


def publish_technical_handoffs(root,directory,job,result,inbox_directory=None):
    """Forward pinned data to the existing technical lane, never launch a model."""
    published=[]
    for pin in result.get('technicalHandoffs',[]):
        path=local(root,pin['path'])
        if not permitted(root,path,job['writePrefixes']) or sha(path)!=pin['sha256']:
            raise ValueError('Technical handoff outside own scope or changed')
        data=read(path)
        if not all(data.get(k) for k in ['predicate','affectedIds','evidence','requiredResult']):
            raise ValueError('Technical handoff needs its actual finite predicate and evidence')
        inbox=Path(inbox_directory) if inbox_directory else directory/'technical-inbox';inbox.mkdir(exist_ok=True)
        target=inbox/(job['locale']+'-'+pin['sha256']+'.json')
        body=dict(locale=job['locale'],request=pin,finiteDeliverable=data['requiredResult'])
        if target.exists():
            if read(target)!=body:raise ValueError('Existing immutable handoff differs')
        else:save(target,body)
        published.append(str(target.relative_to(root)))
    for item in result.get('resolvedTechnicalHandoffs',[]):
        if job.get('locale')!='technical':raise ValueError('Only the technical lane can close shared work')
        request=local(root,item['request']['path']);delivery=local(root,item['delivery']['path'])
        inbox=Path(inbox_directory) if inbox_directory else directory/'technical-inbox'
        if request.parent!=inbox.resolve() or sha(request)!=item['request']['sha256']:
            raise ValueError('Resolved request identity differs')
        if not permitted(root,delivery,job['writePrefixes']) or sha(delivery)!=item['delivery']['sha256']:
            raise ValueError('Resolved technical delivery differs')
        handled=inbox/'handled';handled.mkdir(exist_ok=True)
        receipt=handled/request.name
        if receipt.exists():
            if read(receipt)!=item:raise ValueError('Existing technical closure differs')
        else:save(receipt,item)
    return published


def resolve_review_packet(root,job,next_task,result):
    """Resolve an explicit packet or one unique, fully pinned structured binding."""
    selected=next_task.get('reviewPacket')
    if not selected:
        candidates={}
        brief=local(root,next_task['brief'])
        for evidence in result.get('evidence',[]):
            manifest_path=local(root,evidence['path'])
            if manifest_path.suffix!='.json':continue
            manifest=read(manifest_path)
            if not isinstance(manifest,dict):continue
            binding=manifest.get('reviewPacket')
            files=manifest.get('files',manifest.get('artifacts'))
            if not isinstance(binding,dict) or not {'path','sha256'}<=binding.keys() or not isinstance(files,list):continue
            brief_pin=manifest.get('nextBrief')
            brief_bound=any(isinstance(r,dict) and r.get('path')==next_task['brief'] and r.get('sha256')==sha(brief) for r in files)
            if isinstance(brief_pin,dict):brief_bound|=brief_pin.get('path')==next_task['brief'] and brief_pin.get('sha256')==sha(brief)
            if not brief_bound:continue
            for row in [*files,*manifest.get('sourceEvidencePins',[])]:
                path=local(root,row['path'])
                if sha(path)!=row['sha256']:raise ValueError('Structured review binding dependency changed')
            packet=local(root,binding['path'])
            if sha(packet)!=binding['sha256']:raise ValueError('Structured review packet changed')
            candidates[(binding['path'],binding['sha256'])]=dict(path=evidence['path'],sha256=evidence['sha256'])
        if len(candidates)!=1:raise ValueError('Next review requires one explicit unambiguous pinned reviewPacket binding')
        (path,digest),binding=next(iter(candidates.items()))
        selected=path;next_task['reviewBinding']=binding
    if isinstance(selected,dict):
        packet=local(root,selected['path'])
        if sha(packet)!=selected['sha256']:raise ValueError('Explicit review packet hash differs')
        selected=selected['path']
    packet=local(root,selected)
    if not permitted(root,packet,job['writePrefixes']):raise ValueError('Foreign next review packet')
    next_task['reviewPacket']=selected;next_task['reviewPacketSha256']=sha(packet)
    return packet


def validate_result(root,job,phase,task,result,seen):
    result.pop('verifiedReviewCoverage',None)
    outcome=result.get('outcome')
    if outcome=='blocked' and result.get('localWorkReady') is True:
        next_task=result.get('nextTask',{})
        if (next_task.get('kind') not in {'work','review'} or
                next_task.get('workCategory') not in {'locale-content','locale-resource','local-tool-repair'} or
                not next_task.get('entryPins')):
            raise ValueError('Local continuation needs an authorized work category and actual pinned inputs')
        for pin in next_task['entryPins']:
            if sha(local(root,pin['path']))!=pin['sha256']:
                raise ValueError('Local continuation prerequisite changed')
        result['automaticLocalContinuation']='Explicit ready local task; normal continuation guards still apply'
        result['outcome']=outcome='continue'
    if outcome not in {'continue','blocked','static-complete'}:
        raise ValueError('Expected continue, blocked or static-complete; normal phase boundaries never await parent')
    if not result.get('summary'):raise ValueError('Concrete phase summary required')
    evidence=result.get('evidence',[]);fresh=set()
    for row in evidence:
        path=local(root,row['path'])
        if not permitted(root,path,job['writePrefixes']) or not path.is_file():
            raise ValueError('Evidence outside own write scope')
        if sha(path)!=row['sha256']:raise ValueError('Evidence hash mismatch')
        # Changing a filename alone never creates progress.
        fresh.add(row['sha256'])
    unread=[];expected={};context_debt={r['id']:r for r in task.get('contextCarryover',[])}
    if task['kind']=='review':
        packet=local(root,task['reviewPacket'])
        if sha(packet)!=task['reviewPacketSha256']:raise ValueError('Independent review packet changed')
        pairs=[json.loads(s) for s in packet.read_text().splitlines() if s.strip()]
        expected={r['id']:r for r in pairs}
        if len(expected)!=len(pairs) or not pairs:raise ValueError('Nonempty unique review packet required')
        reviews=local(root,result['reviews'])
        if not permitted(root,reviews,job['writePrefixes']):raise ValueError('Foreign review output')
        supplied=[json.loads(s) for s in reviews.read_text().splitlines() if s.strip()]
        ids=[r['id'] for r in supplied]
        if len(set(ids))!=len(ids):raise ValueError('Duplicate independent review judgment')
        contexts=dict(context_debt)
        for name in task.get('contextPackets',[]):
            for line in local(root,name).read_text().splitlines():
                if not line.strip():continue
                row=json.loads(line)
                if not isinstance(row,dict) or not all(row.get(k) for k in ['id','sourceSha256','targetSha256']):continue
                if row['id'] in contexts and any(contexts[row['id']][k]!=row[k] for k in ['sourceSha256','targetSha256']):
                    raise ValueError('Conflicting declared context versions')
                contexts[row['id']]=row
        extras=[r for r in supplied if r['id'] not in expected]
        for row in extras:
            if row['id'] not in contexts or row.get('notLinguisticCoverage') is not True or row.get('targetEdited') is not False:
                raise ValueError('Undeclared context review outside assigned primary coverage')
        actual=[r for r in supplied if r['id'] in expected]
        missing=set(expected)-{r['id'] for r in actual}
        if missing and outcome!='continue':raise ValueError('Incomplete independent review coverage')
        unread.extend(sorted(missing))
        for row in supplied:
            combined=isinstance(row.get('rationale'),str) and bool(row['rationale'].strip())
            natural=[v for k,v in row.items() if k=='naturalnessRationale' or (k.startswith('native') and k.endswith('Rationale'))]
            separate=isinstance(row.get('fidelityRationale'),str) and bool(row['fidelityRationale'].strip()) and any(isinstance(v,str) and v.strip() for v in natural)
            if row.get('verdict') not in REVIEW_VERDICTS or not (combined or separate):
                raise ValueError('Every review row needs an explicit verdict and rationale')
            version=expected.get(row['id'],contexts.get(row['id']))
            if any(row.get(k)!=version.get(k) for k in ['sourceSha256','targetSha256']):
                raise ValueError('Reviewed source/target versions differ')
            if 'reviewed' in row and not isinstance(row['reviewed'],bool):raise ValueError('reviewed must be an explicit boolean')
            if row.get('reviewed') is False:
                prior=(row.get('inheritedNonPassEvidence') or {}).get('original')
                if isinstance(prior,dict) and prior.get('verdict') is None and isinstance(prior.get('receipt'),dict):
                    if all(prior.get(k)==row.get(k) for k in ['id','sourceSha256','targetSha256']):prior=prior['receipt']
                pending_prior=(row.get('pendingSemanticReview') is True and row.get('inheritedVerdictUnchanged') is True
                    and row['verdict'] in {'needs-context','source-defect','technical-preservation','held-source','needs-repair'}
                    and isinstance(prior,dict) and all(prior.get(k)==row.get(k) for k in ['id','sourceSha256','targetSha256','verdict']))
                if row['verdict']!='needs-review' and not pending_prior:raise ValueError('Unread rows can never carry a pass or completed disposition')
                if row['id'] in expected:unread.append(row['id'])
            if row['verdict']=='context-only-preserve':
                if row.get('notLinguisticCoverage') is not True or row.get('targetEdited') is not False:
                    raise ValueError('Context-only preservation must retain the reviewed target and stay outside new linguistic coverage')
                if row.get('sourceDisposition')=='preserved-detached-source' and row['sourceSha256']!=row['targetSha256']:
                    raise ValueError('Detached exact-source preservation cannot change source bytes')
            if row['id'] not in expected and row.get('reviewed') is False:
                context_debt[row['id']]={k:row[k] for k in ['id','sourceSha256','targetSha256']}
            elif row.get('reviewed') is not False:
                context_debt.pop(row['id'],None)
        carry=task.get('reviewCarryover')
        inherited=set()
        if carry:
            inherited=set(carry['pendingIds'])
            basis=local(root,carry['packet'])
            if sha(basis)!=carry['sha256']:raise ValueError('Unread carryover basis changed')
            basis_rows={r['id']:r for r in [json.loads(s) for s in basis.read_text().splitlines() if s.strip()]}
            if not set(expected)<=inherited or not inherited<=set(basis_rows):raise ValueError('Current review packet escaped pending carryover')
            if any(any(r.get(k)!=basis_rows[r['id']].get(k) for k in ['sourceSha256','targetSha256']) for r in pairs):raise ValueError('Carryover review versions differ')
        pending=(inherited-set(expected))|set(unread)
        result['verifiedReviewCoverage']=dict(assigned=len(expected),judged=len(expected)-len(unread),unreadIds=unread,
            pendingIds=sorted(pending),
            missingReviewIds=sorted(missing),declaredContextJudgments=len(extras),
            contextOnlyPreservations=sum(r['verdict']=='context-only-preserve' for r in actual),
            nonPassRows=sum(r['verdict'] not in {'pass','clean'} for r in actual),
            acceptance='Coverage classification only; original non-pass verdicts are retained, never promoted')
    elif task.get('reviewCarryover'):
        carry=task['reviewCarryover'];basis=local(root,carry['packet'])
        if sha(basis)!=carry['sha256']:raise ValueError('Prerequisite repair review debt changed')
        basis_ids={json.loads(line)['id'] for line in basis.read_text().splitlines() if line.strip()}
        if not set(carry['pendingIds'])<=basis_ids:raise ValueError('Repair debt escaped the frozen review basis')
        result['verifiedReviewCoverage']=dict(assigned=0,judged=0,pendingIds=carry['pendingIds'],unreadIds=[],
            acceptance='Unreviewed debt carried through prerequisite repair; no new semantic coverage')
    if context_debt:
        result.setdefault('verifiedReviewCoverage',{})['pendingContextIds']=sorted(context_debt)
        if outcome!='continue':raise ValueError('Unread required context prevents terminal acceptance')
    if outcome=='continue':
        progress=result.get('progress',{})
        if progress.get('kind') not in {'authored','edited','reviewed','source-decisions','resource-build','technical-proof'} or not progress.get('unitIds'):
            raise ValueError('Real authored/reviewed/resolved/built units required; plans and counters are not progress')
        if not fresh-seen:raise ValueError('No new substantive evidence; do not loop unchanged')
        next_task=result['nextTask']
        if task.get('executionStage'):
            next_task.setdefault('executionStage',task['executionStage'])
        if context_debt:next_task['contextCarryover']=list(context_debt.values())
        else:next_task.pop('contextCarryover',None)
        if next_task.get('kind') not in KINDS or not next_task.get('title'):raise ValueError('Concrete next task required')
        brief=local(root,next_task['brief'])
        if not brief.is_relative_to(phase.resolve()) or not 0<brief.stat().st_size<=MAX_BRIEF_BYTES:
            raise ValueError('Next brief must be bounded and owned by the completed phase')
        next_task['briefSha256']=sha(brief)
        if next_task['kind']=='review':
            packet=resolve_review_packet(root,job,next_task,result)
        pending=set(result.get('verifiedReviewCoverage',{}).get('pendingIds',unread))
        if pending:
            if next_task['kind']!='review':raise ValueError('Explicit unread rows require a fresh review continuation')
            remaining=[json.loads(s) for s in packet.read_text().splitlines() if s.strip()]
            ids=[r['id'] for r in remaining]
            if not ids or len(ids)!=len(set(ids)) or not set(ids)<=pending:raise ValueError('Next packet must select unique pending unread IDs')
            carry=task.get('reviewCarryover')
            basis=local(root,carry['packet']) if carry else local(root,task['reviewPacket'])
            basis_rows={r['id']:r for r in [json.loads(s) for s in basis.read_text().splitlines() if s.strip()]}
            if any(any(r.get(k)!=basis_rows[r['id']].get(k) for k in ['sourceSha256','targetSha256']) for r in remaining):
                raise ValueError('Unread continuation versions differ')
            next_task['reviewCarryover']=dict(packet=str(basis.relative_to(root.resolve())),sha256=sha(basis),pendingIds=sorted(pending))
            result['verifiedReviewCoverage']['nextBatchIds']=ids
            result['verifiedReviewCoverage']['deferredIds']=sorted(pending-set(ids))
    elif outcome=='blocked':
        if result.get('independentWorkRemaining') is not False or not result.get('blockers'):
            raise ValueError('Blocked requires concrete blockers and no remaining independent authorized work')
        for blocker in result['blockers']:
            if not all(blocker.get(k) for k in ['predicate','evidence','nextAction']):
                raise ValueError('Blocker must identify the actual boundary, evidence and next action')
    else:
        if result.get('verifiedReviewCoverage',{}).get('pendingIds',unread):raise ValueError('Unread review rows prevent static completion')
        matrix=read(local(root,result['dispositionMatrix']))
        if {r['id'] for r in matrix}!=set(job['requiredDeliverables']) or len(matrix)!=len(job['requiredDeliverables']):
            raise ValueError('Static completion needs every required deliverable, not just the current packet')
        if any(r.get('status') not in {'accepted','not-applicable'} or not r.get('evidence') for r in matrix):
            raise ValueError('Unaccepted deliverables remain blocked, not static-complete')
    return fresh


def process_identity(pid,phase=None,expected=None):
    def field(name):
        result=subprocess.run(['ps','-p',str(pid),'-o',name+'='],capture_output=True,text=True)
        return (result.stdout.strip() or None) if result.returncode==0 else None
    if (field('stat') or '').startswith('Z'):return None
    command=field('command')
    if command is None:return None
    identity=dict(start=field('lstart'),command=command)
    if expected and identity!=expected:raise ValueError('Process identity/lifetime changed')
    if phase and str(phase) not in command:raise ValueError('Process no longer owns the expected phase')
    return identity


def argv(plan,phase):
    model=plan['model'];validate_model(model['name'],model['reasoning'],model['provider'])
    if model['inheritedHistory'] is not False:raise ValueError('No inherited history')
    prompt=(f'Execute the current finite production assignment at {phase}/brief.md. '
            f'FIRST await and verify {phase}/runtime-verification.json before localized inputs. '
            f'Then read {phase}/task.json and the frozen lane contract named there. '
            'Exact fresh gpt-6.1-sol/high/OpenAI, no inherited/resumed/forked history, Astra, defaults, fallback, nested agents or model jobs. '
            'The owner has explicitly instructed continuous completion of these queues. A normal phase boundary MUST write the next finite task '
            'and outcome continue; the supervisor launches it automatically. Do not stop for parent review or request permission for already '
            'authorized local work. Distinct fresh independent review phases remain mandatory. Do actual editing, review or resource work; '
            'do not repeat reconciliation or spend a phase merely planning. Parent alone owns Git. Follow exact lane write scope and all '
            'source/editorial/font/renderer gates; no game/GUI/image/installer/production/server actions. '
            f'Write the required result to {phase}/result.json. Unknown request errors and true exhausted-work blockers remain explicit.')
    if plan.get('efficiencyPolicy'):
        prompt=(f'Execute {phase}/brief.md and task.json under their frozen contract. First await runtime-verification.json, '
                f'then run python3 -B {Path(plan["efficiencyHelper"])} inspect --phase {phase}. '
                'Fresh explicitly pinned Sol/high/OpenAI; no inherited history, nested agents or models. '
                'Read all assigned wording and necessary semantic context; views are indexes, not instructions to reread every metadata field. '
                f'Use the shared review preparation/publication commands at {Path(plan["efficiencyHelper"]).parent/"locale_review_work.py"}; do not invent per-phase publication scripts. '
                f'Write result.json to {phase}; continue automatically with the next finite task. Parent alone owns Git.')
    return [plan['cli'],'exec','--ignore-user-config','--model','gpt-6.1-sol',
            '-c','model_provider="openai"','-c','model_reasoning_effort="high"','-c','approval_policy="never"',
            '--sandbox','danger-full-access','--disable','multi_agent','--cd',plan['root'],'--json',
            '--output-last-message',str(phase/'last-message.txt'),prompt]


def capacity_failure(record,events):
    thread,usage,errors=cli_events(events)
    failures=[e for e in errors if e.get('type')=='turn.failed']
    return (record.get('exitCode')==1 and record.get('threadId')==thread and usage is None
            and bool(failures) and all('Selected model is at capacity' in json.dumps(e) for e in failures))


def restore_capacity_closeout(root,lane,job,receipt):
    state=read(lane/'status.json');record=state['phases'][-1];phase=Path(record['phase'])
    if sha(lane/'status.json')!=receipt['previousStatusSha256'] or state['status']!='held-request-outcome':
        raise ValueError('Capacity closeout checkpoint changed')
    if process_identity(record['pid'],phase) is not None or not capacity_failure(record,phase/'events.jsonl'):
        raise ValueError('Capacity failure is not a reconciled exited request')
    task=receipt['validatedNextTask']
    for name,digest in receipt['interruptedArtifactPins'].items():
        if sha(local(root,name))!=digest:raise ValueError('Interrupted closeout input changed')
    if sha(local(root,task['brief']))!=task['briefSha256']:raise ValueError('Capacity closeout assignment changed')
    claim=lane/'continuation.lock'
    if sha(claim)!=receipt['previousClaimSha256']:raise ValueError('Previous continuation claim changed')
    seen=set()
    for old in state['phases'][:-1]:
        previous=Path(old['phase'])/'result.json'
        if old.get('resultSha256') and sha(previous)!=old['resultSha256']:raise ValueError('Accepted result changed')
        if previous.exists():seen.update(r['sha256'] for r in read(previous).get('evidence',[]))
    archive=local(root,receipt['archive']);archive.mkdir(parents=True)
    for name in ['status.json','continuation.lock']:
        with (archive/name).open('xb') as f:f.write((lane/name).read_bytes())
    claim.unlink()
    record['capacityCloseoutReceipt']=job['resumeReceipt']
    state.setdefault('recoveries',[]).append(dict(receipt=job['resumeReceipt'],at=now(),priorReason=state.get('reason')))
    state.update(status='starting',supervisorPid=os.getpid());state.pop('reason',None)
    return state,seen,copy.deepcopy(task)


def priority_task(root,plan,job,state,task):
    selected=plan.get('ownerPriorityTask')
    if job['locale']!='technical' or not selected or task['kind']=='review' or task.get('reviewCarryover'):
        return task
    if state.get('ownerPriorityApplied')==selected['briefSha256']:return task
    if sha(local(root,selected['brief']))!=selected['briefSha256']:raise ValueError('Owner priority assignment changed')
    state['deferredTechnicalTask']=copy.deepcopy(task)
    state['ownerPriorityApplied']=selected['briefSha256']
    return copy.deepcopy(selected)


def source_wake_ready(root,config):
    path=local(root,config['sourceManifest'])
    if sha(path)==config['baselineSha256']:return False
    value=read(path)
    return (value.get('commonSourceAccepted') is True and value.get('translationEntryAllowed') is True
            and value.get('completeVisibleTranslationDenominator') is not None)


def wait_dependency(root,plan,job,state):
    while True:
        selected=dependency_wake.waiting_task(root,plan,job,state)
        if selected != []:
            return selected
        time.sleep(10)


def consume_dependency(state,task):
    receipts=task.get('dependencyReceipts') or ([task['dependencyReceipt']] if task.get('dependencyReceipt') else [])
    for receipt in receipts:
        used=state.setdefault('consumedDependencyReceipts',[])
        if receipt['sha256'] not in used:used.append(receipt['sha256'])


def owner_resume_task(root,job,stopped_result=None):
    """Explicit finite target work, independent of a historical whole-source wake."""
    config=job['ownerResume']
    def pinned(pin):
        path=local(root,pin['path'])
        if sha(path)!=pin['sha256']:raise ValueError('Owner continuation dependency changed')
        return read(path)
    authority=pinned(config['authorization']);baseline=pinned(config['baselineAcceptance'])
    if (authority.get('kind')!='direct-owner-repair-and-resume' or
            job['locale'] not in authority.get('locales',[]) or
            authority.get('baselineAcceptance')!=config['baselineAcceptance']):
        raise ValueError('Owner continuation authorization scope')
    if (baseline.get('authority')!='owner' or baseline.get('accepted') is not True or
            baseline.get('locale')!='ru' or baseline.get('sharedMechanismReuseAllowed') is not True or
            baseline.get('targetLocaleAcceptanceGranted') is not False):
        raise ValueError('Owner baseline acceptance scope')
    for pin in [baseline['artifact'],baseline['sourceManifest']]:
        if sha(local(root,pin['path']))!=pin['sha256']:raise ValueError('Owner baseline artifact changed')
    scope=pinned(config['scope']);ids=scope.get('affectedIds',[])
    if stopped_result is not None:
        owning=scope.get('owningStoppedResult') or {}
        if (owning.get('sha256')!=stopped_result['sha256'] or not owning.get('path') or
                local(root,owning['path'])!=local(root,stopped_result['path'])):
            raise ValueError('Owner continuation belongs to a different stopped result; prepare changed work')
    if scope.get('locale')!=job['locale'] or not ids or len(ids)!=len(set(ids)):
        raise ValueError('Finite owner continuation scope')
    for pin in scope.get('inputs',[]):
        if sha(local(root,pin['path']))!=pin['sha256']:raise ValueError('Target continuation input changed')
    task=config['task']
    if (task.get('kind') not in {'work','review'} or not task.get('title') or
            sha(local(root,task['brief']))!=task['briefSha256']):
        raise ValueError('Owner continuation task changed')
    if task['kind']=='review':
        packet=local(root,task['reviewPacket'])
        if sha(packet)!=task.get('reviewPacketSha256'):raise ValueError('Owner review packet changed')
        rows=[json.loads(line) for line in packet.read_text().splitlines() if line.strip()]
        if len(rows)!=len(ids) or {r['id'] for r in rows}!=set(ids):raise ValueError('Owner review scope differs')
        for row in rows:
            for key in ['source','target']:
                if hashlib.sha256(row[key].encode()).hexdigest()!=row[key+'Sha256']:
                    raise ValueError('Owner review wording hash differs')
    return copy.deepcopy(task)


def retained_terminal(root,lane,recovery):
    if sha(lane/'status.json')!=recovery['previousStatusSha256']:raise ValueError('Terminal checkpoint changed')
    state=read(lane/'status.json');record=state['phases'][-1];phase=Path(record['phase'])
    if state['status'] not in {'blocked','static-complete','held-dispatch-policy'}:raise ValueError('Expected terminal lane')
    if sha(phase/'result.json')!=recovery['resultSha256']:raise ValueError('Terminal result changed')
    if sha(lane/'continuation.lock')!=recovery['previousClaimSha256']:raise ValueError('Terminal claim changed')
    if process_identity(record['pid'],phase) is not None:raise ValueError('Terminal worker is alive')
    if recovery.get('terminalReconciliation'):
        record.update(recovery['terminalReconciliation'])
    return state


def persist_terminal_reconciliation(root,lane,recovery,state):
    if not recovery.get('terminalReconciliation'):return
    archive=local(root,recovery['archive']);archive.mkdir(parents=True)
    for name in ['status.json','continuation.lock']:
        with (archive/name).open('xb') as stream:stream.write((lane/name).read_bytes())
    save(lane/'continuation.lock',dict(pid=os.getpid(),at=now(),reconciledTerminalFrom=read(lane/'continuation.lock')['pid']))
    state['supervisorPid']=os.getpid()
    save(lane/'status.json',state)


def run_lane(directory,plan,job):
    root=Path(plan['root']);lane=local(root,job['directory']);lane.mkdir(parents=True,exist_ok=True)
    verified_dependency_task=False
    recovery=read(local(root,job['resumeReceipt'])) if job.get('resumeReceipt') else None
    if recovery and sha(local(root,job['resumeReceipt']))!=job['resumeReceiptSha256']:raise ValueError('Recovery receipt changed')
    if recovery and recovery.get('kind')=='retained-terminal-lane':
        state=retained_terminal(root,lane,recovery)
        config=job.get('sourceWake')
        if state['status']!='blocked' and not (plan.get('localeOwned') and job.get('ownerResume') and state['status']=='held-dispatch-policy'):
            persist_terminal_reconciliation(root,lane,recovery,state);return state
        if job.get('ownerResume'):
            task=owner_resume_task(root,job,dict(path=str((Path(state['phases'][-1]['phase'])/'result.json').relative_to(root)),sha256=recovery['resultSha256']))
            wake=dict(ownerResumeAt=now(),ownerResumeAuthorizationSha256=job['ownerResume']['authorization']['sha256'])
        else:
            if plan.get('dependencyWake'):
                task=wait_dependency(root,plan,job,state)
                if task is None:
                    persist_terminal_reconciliation(root,lane,recovery,state);return state
                verified_dependency_task=True
                wake=dict(dependencyWakeAt=now())
            else:
                if not config:return state
                # Quiet data-only wait. No new model request for an unchanged blocker.
                while not source_wake_ready(root,config):time.sleep(10)
                task=copy.deepcopy(config['task'])
                wake=dict(sourceWakeAt=now(),sourceWakeSha256=sha(local(root,config['sourceManifest'])))
        state=retained_terminal(root,lane,recovery)
        seen=set()
        for old in state['phases']:
            previous=Path(old['phase'])/'result.json'
            if old.get('resultSha256'):
                if sha(previous)!=old['resultSha256']:raise ValueError('Accepted blocked-lane evidence changed')
                seen.update(r['sha256'] for r in read(previous).get('evidence',[]))
        archive=local(root,recovery['archive']);archive.mkdir(parents=True)
        for name in ['status.json','continuation.lock']:
            with (archive/name).open('xb') as f:f.write((lane/name).read_bytes())
        (lane/'continuation.lock').unlink()
        state.update(status='starting',supervisorPid=os.getpid(),automaticContinuation=True,**wake)
        consume_dependency(state,task)
        state.pop('reason',None)
    elif recovery and recovery.get('kind')=='owner-stopped-efficiency-restart':
        if sha(lane/'status.json')!=recovery['previousStatusSha256']:raise ValueError('Stopped checkpoint changed')
        state=read(lane/'status.json')
        if state['status']!='owner-stopped':raise ValueError('Owner stop was not reconciled')
        for name,digest in recovery['stoppedPhasePins'].items():
            if sha(local(root,name))!=digest:raise ValueError('Stopped phase changed')
        for name,digest in recovery.get('currentInputPins',{}).items():
            if sha(local(root,name))!=digest:raise ValueError('Restart input changed')
        record=state['phases'][-1]
        if process_identity(record['pid'],Path(record['phase'])) is not None:raise ValueError('Stopped request still alive')
        seen=set()
        for old in state['phases']:
            previous=Path(old['phase'])/'result.json'
            if old.get('resultSha256'):
                if sha(previous)!=old['resultSha256']:raise ValueError('Accepted result changed')
                seen.update(r['sha256'] for r in read(previous).get('evidence',[]))
        if recovery.get('acceptedResult'):
            result=read(Path(record['phase'])/'result.json')
            fresh=validate_result(root,job,Path(record['phase']),read(Path(record['phase'])/'task.json')['task'],result,seen)
            record.update(outcome=result['outcome'],summary=result['summary'],progress=result.get('progress'),
                resultSha256=sha(Path(record['phase'])/'result.json'),status='phase-complete-after-supervisor-repair')
            seen.update(fresh)
        else:
            record.update(status='owner-interrupted-unaccepted',osExitCodeKnown=False,measuredUsage=recovery.get('terminalUsage'))
        claim=lane/'continuation.lock'
        if sha(claim)!=recovery['previousClaimSha256']:raise ValueError('Stopped continuation claim changed')
        claim.unlink();state.update(status='starting',supervisorPid=os.getpid());state.pop('reason',None)
        state.setdefault('recoveries',[]).append(dict(receipt=job['resumeReceipt'],at=now(),priorRequestReplayed=False))
        task=copy.deepcopy(recovery['validatedNextTask'])
    elif recovery and recovery.get('kind')=='interrupted-capacity-closeout':
        state,seen,task=restore_capacity_closeout(root,lane,job,recovery)
    elif job.get('resumeReceipt'):
        if sha(local(root,job['resumeReceipt']))!=job['resumeReceiptSha256']:raise ValueError('Recovery receipt changed')
        receipt=read(local(root,job['resumeReceipt']))
        if sha(lane/'status.json')!=receipt['previousStatusSha256']:raise ValueError('Recovery checkpoint changed')
        state=read(lane/'status.json')
        adopting=receipt.get('kind')=='live-observer-handoff'
        if state['status']!=('running' if adopting else 'held-supervisor-error'):raise ValueError('Recovery state differs from the verified handoff')
        record=state['phases'][-1];phase=Path(record['phase'])
        if adopting:
            archive=local(root,receipt['archive']);archive.mkdir(parents=True)
            for name in ['status.json','continuation.lock']:
                path=lane/name
                if path.exists():
                    with (archive/name).open('xb') as f:f.write(path.read_bytes())
            claim=lane/'continuation.lock'
            if sha(claim)!=receipt['previousClaimSha256']:raise ValueError('Adopted continuation claim changed')
            save(claim,dict(pid=os.getpid(),at=now(),adoptedFrom=read(claim)['pid']))
            receipt['previousClaimSha256']=sha(claim)
            state.update(supervisorPid=os.getpid(),status='running');record['status']='running-adopted'
            save(lane/'status.json',state)
            try:
                while process_identity(record['pid'],phase,receipt.get('childIdentity')):time.sleep(1)
                thread,usage,errors=cli_events(phase/'events.jsonl')
                record.update(exitCode=None,exitCodeKnown=False,measuredUsage=usage,errors=errors,finishedAt=now(),
                    completionEvidence='Verified model turn.completed and exited adopted process; OS exit code unavailable')
                save(lane/'status.json',state)
                if usage is None or any(e.get('type')=='turn.failed' for e in errors) or thread!=record.get('threadId'):
                    state.update(status='held-request-outcome',reason='Adopted request lacks verified terminal completion; no retry');save(lane/'status.json',state);return state
            except Exception as error:
                state.update(status='held-supervisor-error',reason=repr(error));save(lane/'status.json',state);return state
        else:
            if receipt.get('reconciledTerminal'):
                record.update(receipt['reconciledTerminal'])
            known_success=record.get('exitCode')==0 or record.get('exitCodeKnown') is False and bool(receipt.get('reconciledTerminal'))
            if not known_success or not cli_turn_succeeded(0,record.get('measuredUsage'),record.get('errors',[])):
                raise ValueError('Prior request outcome is not a verified successful turn')
            thread,usage,errors=cli_events(phase/'events.jsonl')
            if not cli_turn_succeeded(0,usage,errors) or thread!=record.get('threadId') or usage!=record.get('measuredUsage'):
                raise ValueError('Actual prior terminal request receipt differs from checkpoint')
            if sha(phase/'result.json')!=receipt['resultSha256']:raise ValueError('Completed result changed after recovery validation')
        old_task=read(phase/'task.json')['task'];result=read(phase/'result.json');seen=set()
        if receipt.get('validationNextTask'):result['nextTask']=copy.deepcopy(receipt['validationNextTask'])
        for old in state['phases'][:-1]:
            previous=Path(old['phase'])/'result.json'
            if old.get('resultSha256') and sha(previous)!=old['resultSha256']:raise ValueError('Retained previous result changed')
            if previous.exists():seen.update(r['sha256'] for r in read(previous).get('evidence',[]))
        fresh=validate_result(root,job,phase,old_task,result,seen)
        if not plan.get('localeOwned'):publish_technical_handoffs(root,directory,job,result,plan.get('technicalInbox'))
        dependency_wake.publish(root,plan,job,phase,old_task,result)
        if result['outcome']!='continue':
            if not adopting:raise ValueError('Recovery does not contain an authorized continuation')
            record.update(status='phase-complete-after-adoption',resultSha256=sha(phase/'result.json'),
                          outcome=result['outcome'],summary=result['summary'],progress=result.get('progress'),
                          verifiedReviewCoverage=result.get('verifiedReviewCoverage'))
            state.update(status=result['outcome'],reason=result['summary'],finishedAt=now());save(lane/'status.json',state)
            resumed=wait_dependency(root,plan,job,state)
            if resumed is None:return state
            result['nextTask']=resumed
            consume_dependency(state,resumed)
            verified_dependency_task=True
        if not adopting and result['nextTask']!=receipt['validatedNextTask']:raise ValueError('Recovery next assignment differs')
        if not adopting:
            archive=local(root,receipt['archive']);archive.mkdir(parents=True)
            for name in ['status.json','continuation.lock']:
                path=lane/name
                if path.exists():
                    with (archive/name).open('xb') as f:f.write(path.read_bytes())
        claim=lane/'continuation.lock'
        if claim.exists():
            if sha(claim)!=receipt['previousClaimSha256']:raise ValueError('Previous continuation claim changed')
            claim.unlink()
        record.update(status='partial-review-reassigned' if result.get('verifiedReviewCoverage',{}).get('unreadIds') else 'phase-complete-after-supervisor-repair',
                      resultSha256=sha(phase/'result.json'),summary=result['summary'],progress=result.get('progress'),outcome=result['outcome'],
                      verifiedReviewCoverage=result.get('verifiedReviewCoverage'))
        state.setdefault('recoveries',[]).append(dict(receipt=job['resumeReceipt'],at=now(),priorReason=state.get('reason')))
        state.update(status='starting',supervisorPid=os.getpid());state.pop('reason',None);state.pop('warning',None);state.pop('observedAt',None)
        task=copy.deepcopy(receipt.get('selectedNextTask') or result['nextTask']);seen.update(fresh)
    else:
        state=dict(locale=job['locale'],status='starting',supervisorPid=os.getpid(),startedAt=now(),
                   phases=[],automaticContinuation=True,automaticFailedRequestRetry=False)
        seen=set();task=job['firstTask']
    with (lane/'continuation.lock').open('x') as f:json.dump({'pid':os.getpid(),'at':now()},f)
    status=lane/'status.json';save(status,state)
    try:
        while True:
            for name,digest in plan['executionPins'].items():
                if sha(directory/name)!=digest:raise ValueError('Frozen continuation dependency changed')
            for name,digest in job['immutablePins'].items():
                path=Path(name) if Path(name).is_absolute() else local(root,name)
                if sha(path)!=digest:raise ValueError('Immutable source/glossary/contract changed: '+name)
            task=priority_task(root,plan,job,state,task)
            why=dispatch_policy.runtime_reason(root,job,task)
            if why:
                dispatch_policy.defer_locale_owned(root,directory,job,state,task,why)
                state['status']='held-text-prerequisites'
                save(status,state)
                return state
            if plan.get('localeOwned') and task.get('kind')=='technical':
                raise ValueError('Permanent technical stream retired; select locale work/review')
            if plan.get('localeOwned'):
                why=dispatch_policy.locale_owned_reason(root,task)
                if why:
                    dispatch_policy.defer_locale_owned(root,directory,job,state,task,why)
                    save(status,state)
                    return state
            if plan.get('enforceLinguisticOwnership') and not plan.get('localeOwned') and not verified_dependency_task:
                why=dispatch_policy.reason(root,job,task)
                if why:
                    dispatch_policy.defer(root,directory,plan,job,state,task,why)
                    save(status,state)
                    return state
            phase=lane/f'{len(state["phases"])+1:04d}-{task["kind"]}';phase.mkdir()
            brief=local(root,task['brief'])
            if sha(brief)!=task['briefSha256']:raise ValueError('Next assignment changed after its receipt')
            (phase/'brief.md').write_bytes(brief.read_bytes())
            phase_config=dict(task=task,job=job,contract=str(directory/'CONTRACT.md'),phaseResult=str(phase/'result.json'),
                supervisorOwnedFiles=['task.json','brief.md','events.jsonl','stderr.log','runtime-verification.json'])
            if plan.get('efficiencyPolicy'):
                phase_config['efficiencyHelper']=plan['efficiencyHelper']
                phase_config['reviewHelper']=str(Path(plan['efficiencyHelper']).parent/'locale_review_work.py')
                phase_config['laneRole']='shared-technical' if job['locale']=='technical' else 'linguistic'
                if not plan.get('localeOwned'):
                    phase_config['technicalInbox']=plan.get('technicalInbox',str(directory/'technical-inbox'))
                else:
                    phase_config['laneRole']='locale-owned'
                packets=[]
                if task.get('reviewPacket'):
                    packet=local(root,task['reviewPacket'])
                    if sha(packet)!=task['reviewPacketSha256']:raise ValueError('Review packet changed before view creation')
                    packets.append(packet)
                for name in task.get('contextPackets',[]):packets.append(local(root,name))
                if packets:
                    view=phase/'lossless-view';manifest=make_view(root,packets,view)
                    phase_config['losslessView']=dict(path=str((view/'manifest.json').relative_to(root)),sha256=sha(view/'manifest.json'),
                        originalBytes=manifest['originalBytes'],viewBytes=manifest['viewBytes'],pages=len(manifest['pages']))
            save(phase/'task.json',phase_config)
            command=argv(plan,phase);record=dict(number=len(state['phases'])+1,title=task['title'],kind=task['kind'],
                phase=str(phase),startedAt=now(),status='submission-intent',argv=command)
            with (phase/'submission-intent.json').open('x') as f:json.dump(record,f,indent=2)
            state['phases'].append(record);state['status']='starting-phase';save(status,state)
            with (phase/'events.jsonl').open('x') as out,(phase/'stderr.log').open('x') as err:
                child=subprocess.Popen(command,cwd=root,stdin=subprocess.DEVNULL,stdout=out,stderr=err)
                record.update(pid=child.pid,status='verifying-runtime');save(status,state)
                identity=publish_current_runtime(phase,child)
                record.update(status='running',threadId=identity['threadId']);state['status']='running';save(status,state)
                print(json.dumps(dict(locale=job['locale'],phase=record['number'],status='running',pid=child.pid,threadId=identity['threadId'])),flush=True)
                code=child.wait()
            thread,usage,errors=cli_events(phase/'events.jsonl')
            record.update(exitCode=code,threadId=thread,measuredUsage=usage,errors=errors,finishedAt=now())
            if not cli_turn_succeeded(code,usage,errors):
                record['status']='held-request-outcome';state.update(status='held-request-outcome',reason='Reconcile this exact request; no automatic retry');save(status,state);return state
            result=read(phase/'result.json');fresh=validate_result(root,job,phase,task,result,seen)
            published=[] if plan.get('localeOwned') else publish_technical_handoffs(root,directory,job,result,plan.get('technicalInbox'))
            if published:record['technicalHandoffs']=published
            deliveries=dependency_wake.publish(root,plan,job,phase,task,result)
            if deliveries:record['dependencyDeliveries']=deliveries
            record.update(status='partial-review-reassigned' if result.get('verifiedReviewCoverage',{}).get('unreadIds') else 'phase-complete',
                          resultSha256=sha(phase/'result.json'),summary=result['summary'],progress=result.get('progress'),outcome=result['outcome'],
                          verifiedReviewCoverage=result.get('verifiedReviewCoverage'))
            seen.update(fresh);save(status,state)
            print(json.dumps(dict(locale=job['locale'],phase=record['number'],outcome=result['outcome'],usage=usage)),flush=True)
            if result['outcome']!='continue':
                state.update(status=result['outcome'],reason=result['summary'],finishedAt=now());save(status,state)
                resumed=wait_dependency(root,plan,job,state)
                if resumed is None:return state
                task=resumed;consume_dependency(state,task)
                verified_dependency_task=True
                state.update(status='starting',supervisorPid=os.getpid());state.pop('reason',None);save(status,state)
                continue
            task=result['nextTask']
            verified_dependency_task=False
    except BaseException as error:
        state.update(status='held-supervisor-error',reason=repr(error),observedAt=now(),
                     warning='Preserve surviving children and immutable inputs; reconcile before resubmission')
        save(status,state);return state


def run(directory):
    directory=directory.resolve();plan=read(directory/'plan.json')
    validate_model(plan['model']['name'],plan['model']['reasoning'],plan['model']['provider'])
    jobs=plan['jobs'];languages=[j for j in jobs if j['locale']!='technical']
    if any(j['locale']=='technical' for j in jobs):
        raise ValueError('Permanent technical stream retired; locale-owned execution requires zero technical jobs')
    if len(languages)!=6 or len({j['locale'] for j in languages})!=6 or sum(j['locale']=='technical' for j in jobs)>1:
        raise ValueError('Exactly six linguistic lanes plus at most one technical lane')
    selected=plan.get('executionLocales')
    if selected is not None:
        available={j['locale'] for j in jobs}
        if (not isinstance(selected,list) or not selected or
                any(not isinstance(locale,str) for locale in selected) or
                len(selected)!=len(set(selected)) or not set(selected)<=available):
            raise ValueError('Execution locales must be a nonempty unique subset of configured languages')
        jobs=[j for j in jobs if j['locale'] in selected]
    if sha(Path(plan['cli']))!=plan['cliSha256']:raise ValueError('CLI executable changed')
    with (directory/'run.claim').open('x') as f:json.dump(dict(pid=os.getpid(),at=now()),f)
    if plan.get('observerHandoff'):
        handoff=plan['observerHandoff']
        if process_identity(handoff['oldPid'],expected=handoff['oldIdentity']) is None:raise ValueError('Old observer vanished before handoff readiness')
        save(directory/'handoff.ready.json',dict(pid=os.getpid(),oldPid=handoff['oldPid'],at=now()))
        deadline=time.monotonic()+120
        while not (directory/'handoff.commit.json').exists():
            if time.monotonic()>deadline:raise ValueError('Observer handoff not committed; no model submissions made')
            time.sleep(.1)
        commit=read(directory/'handoff.commit.json')
        if commit.get('newPid')!=os.getpid() or commit.get('oldPid')!=handoff['oldPid']:raise ValueError('Handoff commit identity differs')
        if process_identity(handoff['oldPid']) is not None:raise ValueError('Old observer still active; refuse duplicate ownership')
    state=dict(status='running',pid=os.getpid(),startedAt=now(),automaticContinuation=True,
               lanes=[dict(locale=j['locale'],statusFile=str(Path(j['directory'])/'status.json')) for j in jobs])
    save(directory/'status.json',state)
    with concurrent.futures.ThreadPoolExecutor(max_workers=len(jobs)) as pool:
        pending={pool.submit(run_lane,directory,plan,j):j for j in jobs}
        for future in concurrent.futures.as_completed(pending):
            job=pending[future]
            try:result=future.result()
            except Exception as error:
                path=local(Path(plan['root']),job['directory'])/'status.json'
                result=read(path) if path.exists() else dict(locale=job['locale'],phases=[])
                result.update(status='held-supervisor-error',reason=repr(error),failureBoundary='lane-startup-or-adoption',observedAt=now())
                save(path,result)
            print(json.dumps(dict(locale=job['locale'],terminalStatus=result['status'],reason=result.get('reason'))),flush=True)
    state.update(status='all-lanes-terminal',finishedAt=now());save(directory/'status.json',state)


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--run',type=Path,required=True)
    run(parser.parse_args().run)
