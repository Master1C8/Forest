#!/usr/bin/env python3
"""Launch the six existing prepared reconciliation packets once, with durable observation."""
import argparse
import concurrent.futures
import datetime
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import time

import locale_queue as queue
from cli_job_support import validate_model, cli_events, cli_turn_succeeded
from cli_runtime_identity import publish_current_runtime

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
LOCALES = ('zh','es','es-419','pt-BR','ja','de')
MODEL = 'gpt-6.1-sol'


def now():
    return datetime.datetime.now(datetime.timezone.utc).isoformat()


def save(path, value):
    pending = path.with_suffix(path.suffix+'.pending')
    with pending.open('x') as stream:
        json.dump(value,stream,ensure_ascii=False,indent=2);stream.write('\n')
    pending.replace(path)


def verify_packet(root, packet, expected):
    manifest_path = packet/'packet-manifest.json'
    if queue.sha(manifest_path) != expected['sha256']:
        raise ValueError('Prepared packet manifest changed: '+expected['locale'])
    manifest = queue.read(manifest_path)
    validate_model(manifest['model']['name'],manifest['model']['reasoning'],manifest['model']['provider'])
    if manifest['model']['inheritedHistory'] is not False or manifest['locale'] != expected['locale']:
        raise ValueError('Prepared locale/fresh-history binding mismatch')
    for name,digest in manifest['files'].items():
        if queue.sha(queue.local(packet,name)) != digest:
            raise ValueError('Prepared execution input changed: '+name)
    for name,digest in queue.read(packet/'input-pins.json').items():
        path=Path(name) if Path(name).is_absolute() else queue.local(root,name)
        if queue.sha(path)!=digest:
            raise ValueError('Prepared localization input changed: '+name)
    for name in ['submission-intent.json','events.jsonl','result.json','launch-claim.json']:
        if (packet/name).exists():
            raise ValueError('Prior submission/output requires reconciliation: '+str(packet/name))
    return manifest


def prepare(root, directory, coordinator_baseline=None):
    root,directory=root.resolve(),directory.resolve()
    current=queue.check(root)
    if directory.exists() or not directory.is_relative_to(root/'outputs/locale-assets-20261026'):
        raise ValueError('Use a fresh group execution directory inside the existing queue')
    recorded=queue.read(root/'localization/completion/queue-preparation-20261029.json')
    if set(recorded['existingLinguisticQueuesUpdated'])!=set(LOCALES):
        raise ValueError('Dispatch must use exactly the six updated existing languages')
    if current['limits']!={'linguistic':6,'technical':1}:
        raise ValueError('Unexpected stream limit')
    cli=Path(shutil.which('codex')).resolve()
    registry=queue.read(Path.home()/'.codex/models_cache.json')
    if not any(r.get('slug')==MODEL for r in registry['models']):
        raise ValueError('The exact owner-approved model is unavailable; no fallback')
    entries=[]
    for expected in recorded['preparedPackets']:
        packet=queue.local(root,expected['path']).parent
        manifest=verify_packet(root,packet,expected)
        row=next(r for r in current['locales'] if r['locale']==expected['locale'])
        for owner in row['existingOwners']:queue.assert_idle(root/owner['directory'])
        entries.append(dict(locale=expected['locale'],packet=str(packet),
                            manifestSha256=expected['sha256'],localeContext=row))
    directory.mkdir(parents=True)
    execution=directory/'execution';execution.mkdir()
    for name in ['run_locale_reconciliation.py','locale_queue.py','cli_job_support.py','cli_runtime_identity.py']:
        shutil.copyfile(root/'tools'/name,execution/name)
    plan=dict(root=str(root),revision=current['revision'],queueSha256=queue.sha(root/queue.QUEUE),
              cli=str(cli),cliSha256=queue.sha(cli),model=current['model'],entries=entries,
              executionPins={str(p.relative_to(directory)):queue.sha(p) for p in execution.iterdir()},
              ownerInstruction='Start the six updated CLI localization queues',
              coordinatorBaseline=coordinator_baseline,
              accounting='Baseline starts during preparation; earlier turn work is outside this measured tail. Shared orchestration includes launcher implementation/tests.')
    queue.write(directory/'plan.json',plan)
    return plan


def command(plan, packet):
    model=plan['model']
    validate_model(model['name'],model['reasoning'],model['provider'])
    if model['inheritedHistory'] is not False:
        raise ValueError('Inherited history is prohibited')
    prompt=(
        'Run the existing prepared localization reconciliation packet at '+str(packet)+'. '
        'Fresh gpt-6.1-sol/high/OpenAI; no resume, fork, inherited history, nested jobs or Git writes. '
        'FIRST wait for '+str(packet/'runtime-verification.json')+' (up to 60 seconds); '
        'verify its actual Sol/high/OpenAI identity before reading localization inputs. '
        'If no valid receipt arrives, record the exact preflight blocker without reading localized content. '
        'Then read dispatch.json for your compact localeContext and request.md for the exact finite assignment. '
        'Do not print the whole multilingual queue or inspect other locale histories. '
        'Use the frozen execution instructions, verify input-pins.json, preserve all old work. '
        'Write only new reconciliation evidence/result.json in this packet; never modify its prepared inputs, '
        'execution/, dispatch, intent, events, runtime verification, logs or coordinator files. '
        'Complete this bounded reconciliation, propose the next finite task, and stop for parent review. '
        'No games, images, installers, publication, deployment or servers.')
    return [plan['cli'],'exec','--ignore-user-config','--model',MODEL,
            '-c','model_provider="openai"','-c','model_reasoning_effort="high"',
            '-c','approval_policy="never"','--sandbox','danger-full-access','--disable','multi_agent',
            '--cd',plan['root'],'--json','--output-last-message',str(packet/'last-message.txt'),prompt]


def observe_exit(row, packet, returncode):
    thread,usage,errors=cli_events(packet/'events.jsonl')
    result=packet/'result.json'
    row.update(exitCode=returncode,threadId=thread,measuredUsage=usage,errors=errors,finishedAt=now())
    if not cli_turn_succeeded(returncode,usage,errors):
        row['status']='held-request-outcome';return
    try:
        value=queue.read(result)
        if not isinstance(value,dict) or not value:
            raise ValueError('Nonempty reconciliation result object required')
        row.update(status='completed-awaiting-parent-review',resultSha256=queue.sha(result),
                   acceptance='Process/result receipt only; no semantic, source, native or release acceptance')
    except (OSError,ValueError) as error:
        row.update(status='held-missing-or-invalid-result',reason=str(error))


def run(directory):
    directory=directory.resolve();plan=queue.read(directory/'plan.json');root=Path(plan['root'])
    validate_model(plan['model']['name'],plan['model']['reasoning'],plan['model']['provider'])
    if len(plan['entries'])!=6 or {r['locale'] for r in plan['entries']}!=set(LOCALES):
        raise ValueError('Exactly six unique existing language streams required')
    for name,digest in plan['executionPins'].items():
        if queue.sha(directory/name)!=digest:raise ValueError('Frozen observer dependency changed')
    if queue.sha(Path(plan['cli']))!=plan['cliSha256']:raise ValueError('CLI executable changed')
    queue.check(root)
    for entry in plan['entries']:
        verify_packet(root,Path(entry['packet']),dict(locale=entry['locale'],sha256=entry['manifestSha256']))
        for owner in entry['localeContext']['existingOwners']:queue.assert_idle(root/owner['directory'])
    global_claim=root/'outputs/locale-assets-20261026/workflow-v2-launch.lock'
    with global_claim.open('x') as stream:
        json.dump(dict(pid=os.getpid(),run=str(directory),startedAt=now()),stream)
    state=dict(status='starting',supervisorPid=os.getpid(),startedAt=now(),revision=plan['revision'],
               model=plan['model'],entries=[],modelRequestsStarted=0,automaticRetries=False)
    save(directory/'status.json',state)
    children={};handles=[]
    try:
        for entry in plan['entries']:
            packet=Path(entry['packet']);argv=command(plan,packet)
            with (packet/'launch-claim.json').open('x') as stream:
                json.dump(dict(run=str(directory),supervisorPid=os.getpid()),stream)
            queue.write(packet/'dispatch.json',dict(locale=entry['locale'],localeContext=entry['localeContext'],
                         plan=str(directory/'plan.json'),packetManifestSha256=entry['manifestSha256']))
            # Intent precedes the only Popen. Unknown outcomes are never retried.
            with (packet/'submission-intent.json').open('x') as stream:
                json.dump(dict(at=now(),argv=argv,run=str(directory),inheritedHistory=False),stream,indent=2)
            row=dict(locale=entry['locale'],packet=str(packet),status='submission-intent',command=argv)
            state['entries'].append(row);save(directory/'status.json',state)
            out=(packet/'events.jsonl').open('x');err=(packet/'stderr.log').open('x');handles.extend([out,err])
            child=subprocess.Popen(argv,cwd=root,stdin=subprocess.DEVNULL,stdout=out,stderr=err)
            children[entry['locale']]=child
            row.update(pid=child.pid,status='starting-runtime-verification')
            state['modelRequestsStarted']+=1;save(directory/'status.json',state)
        with concurrent.futures.ThreadPoolExecutor(max_workers=6) as pool:
            pending={pool.submit(publish_current_runtime,Path(row['packet']),children[row['locale']]):row for row in state['entries']}
            for future in concurrent.futures.as_completed(pending):
                row=pending[future]
                try:
                    receipt=future.result();row.update(status='running-verified',threadId=receipt['threadId'],
                        runtimeVerificationSha256=queue.sha(Path(row['packet'])/'runtime-verification.json'))
                except Exception as error:
                    row.update(status='held-runtime-identity',reason=str(error))
                save(directory/'status.json',state)
                print(json.dumps({k:row.get(k) for k in ['locale','status','pid','threadId','reason']}),flush=True)
        state['status']='observing-six-requests';save(directory/'status.json',state)
        unfinished=set(children)
        while unfinished:
            for row in state['entries']:
                locale=row['locale']
                if locale not in unfinished:continue
                code=children[locale].poll()
                if code is None:continue
                identity_failed=row['status']=='held-runtime-identity'
                observe_exit(row,Path(row['packet']),code)
                if identity_failed:row['status']='held-runtime-identity'
                unfinished.remove(locale);save(directory/'status.json',state)
                print(json.dumps({k:row.get(k) for k in ['locale','status','threadId','measuredUsage']}),flush=True)
            if unfinished:time.sleep(2)
        state.update(status='finished-awaiting-parent-review',finishedAt=now())
        save(directory/'status.json',state)
    except BaseException as error:
        state.update(status='held-observer-error',reason=repr(error),observedAt=now(),
                     warning='Children and request intents survive; reconcile exact identities, never duplicate submission')
        save(directory/'status.json',state)
        raise
    finally:
        for handle in handles:handle.close()


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run',type=Path,required=True)
    args=parser.parse_args();run(args.run)
