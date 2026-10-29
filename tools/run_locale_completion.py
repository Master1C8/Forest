#!/usr/bin/env python3
"""Durable fresh-context localization lanes with automatic evidence-bound continuation."""
import argparse
import concurrent.futures
import datetime
import json
import os
from pathlib import Path
import subprocess
import time

from cli_job_support import validate_model, cli_events, cli_turn_succeeded
from cli_runtime_identity import publish_current_runtime
from locale_queue import sha, read, local

KINDS = {'work','review','technical'}


def now():return datetime.datetime.now(datetime.timezone.utc).isoformat()


def save(path,data):
    pending=path.with_suffix(path.suffix+'.pending')
    with pending.open('x') as f:json.dump(data,f,ensure_ascii=False,indent=2);f.write('\n')
    pending.replace(path)


def permitted(root,path,prefixes):
    resolved=path.resolve()
    return any(resolved.is_relative_to(local(root,prefix)) for prefix in prefixes)


def validate_result(root,job,phase,task,result,seen):
    outcome=result.get('outcome')
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
    if task['kind']=='review':
        packet=local(root,task['reviewPacket'])
        if sha(packet)!=task['reviewPacketSha256']:raise ValueError('Independent review packet changed')
        pairs=[json.loads(s) for s in packet.read_text().splitlines() if s.strip()]
        expected={r['id']:r for r in pairs}
        if len(expected)!=len(pairs) or not pairs:raise ValueError('Nonempty unique review packet required')
        reviews=local(root,result['reviews'])
        if not permitted(root,reviews,job['writePrefixes']):raise ValueError('Foreign review output')
        actual=[json.loads(s) for s in reviews.read_text().splitlines() if s.strip()]
        ids=[r['id'] for r in actual]
        if len(set(ids))!=len(ids) or set(ids)!=set(expected):raise ValueError('Incomplete independent review coverage')
        for row in actual:
            if row.get('verdict') not in {'pass','clean','finding','needs-context','source-defect','technical-preservation'} or not row.get('rationale'):
                raise ValueError('Every review row needs an explicit verdict and rationale')
            if any(row.get(k)!=expected[row['id']].get(k) for k in ['sourceSha256','targetSha256']):
                raise ValueError('Reviewed source/target versions differ')
    if outcome=='continue':
        progress=result.get('progress',{})
        if progress.get('kind') not in {'authored','edited','reviewed','source-decisions','resource-build','technical-proof'} or not progress.get('unitIds'):
            raise ValueError('Real authored/reviewed/resolved/built units required; plans and counters are not progress')
        if not fresh-seen:raise ValueError('No new substantive evidence; do not loop unchanged')
        next_task=result['nextTask']
        if next_task.get('kind') not in KINDS or not next_task.get('title'):raise ValueError('Concrete next task required')
        brief=local(root,next_task['brief'])
        if not brief.is_relative_to(phase.resolve()) or not 0<brief.stat().st_size<=24576:
            raise ValueError('Next brief must be bounded and owned by the completed phase')
        next_task['briefSha256']=sha(brief)
        if next_task['kind']=='review':
            packet=local(root,next_task['reviewPacket'])
            if not permitted(root,packet,job['writePrefixes']):raise ValueError('Foreign next review packet')
            next_task['reviewPacketSha256']=sha(packet)
    elif outcome=='blocked':
        if result.get('independentWorkRemaining') is not False or not result.get('blockers'):
            raise ValueError('Blocked requires concrete blockers and no remaining independent authorized work')
        for blocker in result['blockers']:
            if not all(blocker.get(k) for k in ['predicate','evidence','nextAction']):
                raise ValueError('Blocker must identify the actual boundary, evidence and next action')
    else:
        matrix=read(local(root,result['dispositionMatrix']))
        if {r['id'] for r in matrix}!=set(job['requiredDeliverables']) or len(matrix)!=len(job['requiredDeliverables']):
            raise ValueError('Static completion needs every required deliverable, not just the current packet')
        if any(r.get('status') not in {'accepted','not-applicable'} or not r.get('evidence') for r in matrix):
            raise ValueError('Unaccepted deliverables remain blocked, not static-complete')
    return fresh


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
    return [plan['cli'],'exec','--ignore-user-config','--model','gpt-6.1-sol',
            '-c','model_provider="openai"','-c','model_reasoning_effort="high"','-c','approval_policy="never"',
            '--sandbox','danger-full-access','--disable','multi_agent','--cd',plan['root'],'--json',
            '--output-last-message',str(phase/'last-message.txt'),prompt]


def run_lane(directory,plan,job):
    root=Path(plan['root']);lane=local(root,job['directory']);lane.mkdir(parents=True,exist_ok=True)
    with (lane/'continuation.lock').open('x') as f:json.dump({'pid':os.getpid(),'at':now()},f)
    state=dict(locale=job['locale'],status='starting',supervisorPid=os.getpid(),startedAt=now(),
               phases=[],automaticContinuation=True,automaticFailedRequestRetry=False)
    status=lane/'status.json';save(status,state);seen=set();task=job['firstTask']
    try:
        while True:
            for name,digest in plan['executionPins'].items():
                if sha(directory/name)!=digest:raise ValueError('Frozen continuation dependency changed')
            for name,digest in job['immutablePins'].items():
                path=Path(name) if Path(name).is_absolute() else local(root,name)
                if sha(path)!=digest:raise ValueError('Immutable source/glossary/contract changed: '+name)
            phase=lane/f'{len(state["phases"])+1:04d}-{task["kind"]}';phase.mkdir()
            brief=local(root,task['brief'])
            if sha(brief)!=task['briefSha256']:raise ValueError('Next assignment changed after its receipt')
            (phase/'brief.md').write_bytes(brief.read_bytes())
            save(phase/'task.json',dict(task=task,job=job,contract=str(directory/'CONTRACT.md'),
                                      phaseResult=str(phase/'result.json'),supervisorOwnedFiles=['task.json','brief.md','events.jsonl','stderr.log','runtime-verification.json']))
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
            record.update(status='phase-complete',resultSha256=sha(phase/'result.json'),summary=result['summary'],progress=result.get('progress'),outcome=result['outcome'])
            seen.update(fresh);save(status,state)
            print(json.dumps(dict(locale=job['locale'],phase=record['number'],outcome=result['outcome'],usage=usage)),flush=True)
            if result['outcome']!='continue':
                state.update(status=result['outcome'],reason=result['summary'],finishedAt=now());save(status,state);return state
            task=result['nextTask']
    except BaseException as error:
        state.update(status='held-supervisor-error',reason=repr(error),observedAt=now(),
                     warning='Preserve surviving children and immutable inputs; reconcile before resubmission')
        save(status,state);return state


def run(directory):
    directory=directory.resolve();plan=read(directory/'plan.json')
    validate_model(plan['model']['name'],plan['model']['reasoning'],plan['model']['provider'])
    jobs=plan['jobs'];languages=[j for j in jobs if j['locale']!='technical']
    if len(languages)!=6 or len({j['locale'] for j in languages})!=6 or sum(j['locale']=='technical' for j in jobs)>1:
        raise ValueError('Exactly six linguistic lanes plus at most one technical lane')
    if sha(Path(plan['cli']))!=plan['cliSha256']:raise ValueError('CLI executable changed')
    with (directory/'run.claim').open('x') as f:json.dump(dict(pid=os.getpid(),at=now()),f)
    state=dict(status='running',pid=os.getpid(),startedAt=now(),automaticContinuation=True,
               lanes=[dict(locale=j['locale'],statusFile=str(Path(j['directory'])/'status.json')) for j in jobs])
    save(directory/'status.json',state)
    with concurrent.futures.ThreadPoolExecutor(max_workers=len(jobs)) as pool:
        pending={pool.submit(run_lane,directory,plan,j):j for j in jobs}
        for future in concurrent.futures.as_completed(pending):
            job=pending[future];result=future.result()
            print(json.dumps(dict(locale=job['locale'],terminalStatus=result['status'],reason=result.get('reason'))),flush=True)
    state.update(status='all-lanes-terminal',finishedAt=now());save(directory/'status.json',state)


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--run',type=Path,required=True)
    run(parser.parse_args().run)
