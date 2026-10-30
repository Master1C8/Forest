#!/usr/bin/env python3
"""Prepare an explicitly owner-stopped queue for an immutable, efficient restart."""
import argparse
import copy
import json
from pathlib import Path
import shutil

import run_locale_completion as runner
from locale_efficiency import POLICY, load_rows
from locale_queue import read,sha,write,local
from cli_job_support import validate_model

ROOT=Path('/Users/antonkrutov/Desktop/Forest')


def combine_packets(root, paths, destination):
    rows={};order=[]
    for path in paths:
        for row in load_rows(path):
            ident=row['id']
            if ident in rows and rows[ident]!=row:raise ValueError('Conflicting combined review identity: '+ident)
            if ident not in rows:rows[ident]=row;order.append(ident)
    destination.parent.mkdir(parents=True,exist_ok=True)
    with destination.open('x') as f:
        for ident in order:f.write(json.dumps(rows[ident],ensure_ascii=False)+'\n')
    return order


def prepare(directory):
    directory=directory.resolve();stop=read(directory/'stop-receipt.json');previous=Path(read(directory/'stop-intent.json')['previous'])
    if (directory/'plan.json').exists():raise ValueError('Already prepared; reconcile before another submission')
    plan=read(previous/'plan.json');validate_model(plan['model']['name'],plan['model']['reasoning'],plan['model']['provider'])
    if not stop['oldObserverStopped'] or runner.process_identity(read(directory/'stop-intent.json')['oldObserverPid']):raise ValueError('Old observer not stopped')
    for pin,digest in plan['executionPins'].items():
        if sha(previous/pin)!=digest:raise ValueError('Old immutable execution changed')
    if sha(Path(plan['cli']))!=plan['cliSha256']:raise ValueError('CLI changed')
    execution=directory/'execution';execution.mkdir()
    for name in ['run_locale_completion.py','cli_job_support.py','cli_runtime_identity.py','locale_queue.py','locale_efficiency.py','locale_review_work.py','locale_dependency_wake.py','locale_dispatch_policy.py']:
        shutil.copyfile(ROOT/'tools'/name,execution/name)
    (directory/'CONTRACT.md').write_text((previous/'CONTRACT.md').read_text()+'\n'+POLICY)
    jobs=[]
    for job in plan['jobs']:
        observed=next(row for row in stop['lanes'] if row['locale']==job['locale']);lane=local(ROOT,job['directory']);state=read(lane/'status.json')
        if state['status']!='owner-stopped':raise ValueError('Lane is not owner-stopped')
        phase=Path(observed['phaseDirectory']);record=state['phases'][-1]
        if runner.process_identity(record['pid'],phase):raise ValueError('Prior model process survives')
        runtime=read(phase/'runtime-verification.json');actual=runtime['actualRuntime']
        validate_model(actual['turn']['model'],actual['turn']['effort'],actual['session']['model_provider'])
        if actual['session']['parent_thread_id'] is not None:raise ValueError('Inherited worker history')
        for pin,digest in observed['phasePins'].items():
            if sha(local(ROOT,pin))!=digest:raise ValueError('Stopped phase changed')
        task=copy.deepcopy(read(phase/'task.json')['task']);accepted=False;extra=''
        if observed['terminalUsage'] is not None and not any(e.get('type')=='turn.failed' for e in observed['terminalErrors']):
            result=read(phase/'result.json');seen=set()
            for old in state['phases'][:-1]:
                if old.get('resultSha256'):
                    f=Path(old['phase'])/'result.json'
                    if sha(f)!=old['resultSha256']:raise ValueError('Accepted prior result changed')
                    seen.update(x['sha256'] for x in read(f).get('evidence',[]))
            runner.validate_result(ROOT,job,phase,task,result,seen)
            if result['outcome']!='continue':raise ValueError('Successful terminal result lacks continuation')
            task=copy.deepcopy(result['nextTask']);accepted=True
        base=local(ROOT,task['brief']);original=base.read_text()
        brief=directory/'assignments'/job['locale']/'brief.md';brief.parent.mkdir(parents=True)
        extra_pins={}
        if job['locale']=='technical':
            # Same frozen implementation and dependency registry: combine remaining
            # locale cells and deduplicate identical shared context IDs exactly.
            partition=ROOT/'localization/fonts/locale-completion-20261030/quest-header-requirements-v1/revision02/review/partition-manifest.json'
            spec=read(partition);paths=[]
            for packet in spec['packets'][1:]:
                p=partition.parent.parent/packet['path']
                if sha(p)!=packet['sha256']:raise ValueError('Frozen technical partition changed')
                paths.append(p)
            combined=brief.parent/'combined-review.jsonl';ids=combine_packets(ROOT,paths,combined)
            task.update(reviewPacket=str(combined.relative_to(ROOT)),reviewPacketSha256=sha(combined),
                title='Independently review all remaining10 quest-header cells and3 shared contexts in one packet')
            extra='''The owner replaces the old single-locale restriction with ONE combined
technical review of the remaining five locales,10 cells plus3 shared contexts.
The combined packet is an exact version-checked union of original packets02–06;
read every assigned unit and every required allocation/source/target field.
Reuse the matching completed Chinese packet01 only; interrupted packet02 drafts
are unaccepted. Collect all findings before one repair/delta. Do not schedule
the old per-locale review chain again. On completion produce the finite combined
acceptance/checklist and select the next unmet game deliverable, or the actual
exhausted-static-work blocker. No repeated unchanged contract reviews.\n'''
            extra_pins[str(partition.relative_to(ROOT))]=sha(partition)
        elif job['locale']=='es-419':
            source=ROOT/'localization/source/inventory-display-completion-20261028/source.jsonl'
            canonical=ROOT/'localization/es-419-assets/inventory-descriptions.authored.jsonl'
            stored=load_rows(canonical);expected=phase/'storage-expected.jsonl'
            if canonical.read_bytes()!=expected.read_bytes() or len(stored)!=22 or len({r['id'] for r in stored})!=22:
                raise ValueError('Interrupted append postcondition is ambiguous')
            all_rows=load_rows(source);existing={r['id'] for r in stored}
            if len({r['id'] for r in all_rows})!=52 or not existing<={r['id'] for r in all_rows}:
                raise ValueError('Canonical inventory identity is not reconciled')
            remaining=[r for r in all_rows if r['id'] not in existing]
            if len(remaining)!=30:raise ValueError('Remaining inventory denominator changed')
            selection=brief.parent/'remaining-inventory.jsonl'
            with selection.open('x') as f:
                for row in remaining:f.write(json.dumps(row,ensure_ascii=False)+'\n')
            task.update(title='Finish all30 remaining inventory descriptions in one author/editor batch')
            extra=f'''The owner replaces the old three-description batch with the complete
remaining inventory-display family in {selection.relative_to(ROOT)}:30 unique
source records. The old phase DID complete the19->22 append before interruption.
Canonical22 bytes match its storage-expected.jsonl; never attempt19->22 again.
Verify the22 existing receipts and retain their exact bytes.
The interrupted first-append/replay receipts are preserved. Do not rerun an old
pre-append verifier against22 and mistake the expected19-before drift for failure.
The current draft
130/140/150 candidates are unaccepted and may be inspected/repaired/reused only
after actual source/context reading. Some current candidate IDs may already be
among the22 accepted records: do not duplicate or recount them.
Classify every selected record using existing source/consumer evidence. Directly
author and immediately edit all permitted remaining descriptions in this SAME
context, retaining explicit source/test holds instead of inventing text. Build
one reproducible complete dependency/context selector for their union, reuse
verified old extraction and append mechanisms, and freeze ONE next independent
review packet. Do not split routine descriptions into batches of three or append
unreviewed wording. Required original facts, glossary and scene/notification
context remain mandatory. If the real combined context exceeds the checkpoint
budget, finish a coherent large subset and explicitly carry every unread ID.\n'''
            extra_pins[str(canonical.relative_to(ROOT))]=sha(canonical)
            extra_pins[str(source.relative_to(ROOT))]=sha(source)
        elif job['locale']=='ja':
            pending=phase.parent/'0073-review/next-pending-ui935.jsonl';rows=load_rows(pending)
            rest=brief.parent/'combined-unread-ui935.jsonl'
            combine_packets(ROOT,[local(ROOT,task['reviewPacket']),pending],rest)
            task.update(reviewPacket=str(rest.relative_to(ROOT)),reviewPacketSha256=sha(rest),
                title='Independently review all385 remaining saved Japanese UI records')
            extra='''The owner expands this phase to ALL385 still-unread saved UI935 records,
combining the156 Notebook rows with229 deferred records. Read all exact pairs
and the complete required source/consumer context for each newly assigned
family from the existing pinned catalog and artifacts. Retain550 verified prior
receipts; do not reread them for taste. All385 remain unaccepted until actually
judged. Use one combined finite review, or explicit bounded unread carryover
when the measured budget requires another context; never default-pass a tail.\n'''
        if job['locale']=='pt-BR':
            task['contextPackets']=[str((phase/name).relative_to(ROOT)) for name in
                ['preservation-packet.jsonl','group-decisions.jsonl','member-contracts.jsonl']]
        brief.write_text('''# Owner-authorized efficient continuation

The owner explicitly stopped the old CLI requests to repair token efficiency.
All old phase files remain immutable. Use this NEW phase/runtime/output path;
never execute a prior writer in place. Reuse matching deterministic outputs and
accepted receipts. Interrupted draft judgments have no accepted coverage; verify
their actual IDs/context independently. No inherited/resumed/forked history.
Use the frozen efficiency helper and lossless input view declared in task.json.
Their compact checks replace manual dumps of runtime metadata and pin rows.
All mandatory instructions, source/context reading and editorial gates remain.

## Current assignment update (supersedes the old batching/stop wording)

'''+extra+'''\nFinish this finite deliverable without creating extra bookkeeping phases.
The final result uses explicit nextTask.reviewPacket for each review and named
remaining game deliverables. Preserve every source/editorial/font/runtime hold.

## Original scope and required evidence (read once)

'''+original)
        task.update(brief=str(brief.relative_to(ROOT)),briefSha256=sha(brief))
        receipt_path=directory/'receipts'/(job['locale']+'.json')
        receipt=dict(kind='owner-stopped-efficiency-restart',previousStatusSha256=sha(lane/'status.json'),
            previousClaimSha256=sha(lane/'continuation.lock'),stoppedPhasePins=observed['phasePins'],
            currentInputPins=extra_pins,acceptedResult=accepted,terminalUsage=observed['terminalUsage'],
            validatedNextTask=task,previousRequestReplayed=False)
        write(receipt_path,receipt);updated=copy.deepcopy(job)
        updated.update(resumeReceipt=str(receipt_path.relative_to(ROOT)),resumeReceiptSha256=sha(receipt_path))
        # First combined review packets live in the observer's immutable assignment
        # directory; they are read inputs, not worker write permission.
        updated['restartInputDirectory']=str(brief.parent.relative_to(ROOT))
        jobs.append(updated)
    updated=copy.deepcopy(plan);updated.pop('observerHandoff',None)
    updated.update(jobs=jobs,restartedFrom=str(previous),efficiencyPolicy=True,efficiencyHelper=str(execution/'locale_efficiency.py'),
        executionPins={str(p.relative_to(directory)):sha(p) for p in [*execution.iterdir(),directory/'CONTRACT.md']})
    write(directory/'plan.json',updated)
    return updated


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--run',type=Path,required=True);args=parser.parse_args()
    plan=prepare(args.run);print(json.dumps(dict(prepared=[j['locale'] for j in plan['jobs']],efficiencyPolicy=True)))
