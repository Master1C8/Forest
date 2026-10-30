"""Explicit owner-authorized repair handoff; preserves live language children."""
import argparse
import json
import os
from pathlib import Path
import signal
import subprocess
import time

import recover_locale_completion as recover
import run_locale_completion as runner
from locale_queue import read, sha, write

ROOT = Path('/Users/antonkrutov/Desktop/Forest')


def configure_owner_continuation(plan,new,config_path):
    if not config_path.is_relative_to(ROOT):raise ValueError('Continuation config outside canonical project')
    config=read(config_path)
    selected=set(config.get('resumes',{}));available={j['locale'] for j in plan['jobs'] if j['locale']!='technical'}
    if config.get('schemaVersion')!=1 or not selected or not selected.issubset(available):
        raise ValueError('Expected named existing stopped-language continuations')
    for job in plan['jobs']:
        if job['locale'] not in selected:
            job.pop('ownerResume',None)
            continue
        state=read(ROOT/job['directory']/'status.json')
        if state['status']!='blocked':raise ValueError('Owner-selected continuation is no longer blocked')
        job['ownerResume']=config['resumes'][job['locale']]
        record=state['phases'][-1]
        runner.owner_resume_task(ROOT,job,dict(path=str((Path(record['phase'])/'result.json').relative_to(ROOT)),sha256=record['resultSha256']))
        job.pop('sourceWake',None)
    priority=config['technicalPriority']
    if priority.get('kind')!='technical' or sha(ROOT/priority['brief'])!=priority['briefSha256']:
        raise ValueError('Technical continuation priority changed')
    plan['ownerPriorityTask']=priority
    for item in config['resumes'].values():
        for pin in [item['authorization'],item['baselineAcceptance'],item['scope'],dict(path=item['task']['brief'],sha256=item['task']['briefSha256'])]:
            plan['executionPins'][os.path.relpath(ROOT/pin['path'],new)]=pin['sha256']
    plan['executionPins'][os.path.relpath(ROOT/priority['brief'],new)]=priority['briefSha256']
    plan['executionPins'][os.path.relpath(config_path,new)]=sha(config_path)
    with (new/'CONTRACT.md').open('a') as stream:
        stream.write('\n## Current owner-accepted baseline and explicit continuation\n\n'
            'The Russian localization is complete and working, accepted by the owner. '
            'Reuse its exact behavior and existing mechanisms; old baseline audit flags do not revoke acceptance. '
            'The owner explicitly requested repair and continuation of the three stopped target streams. '
            'Their finite work is bound in ownerResume; no historical whole-source wake is required for that assignment. '
            'Own target semantic/font/native acceptance is still separate. Preserve protected source/glossary values, '
            'all original controls and the current game/GUI/installer/publication restrictions. '
            'Do substantive target work and its required distinct review; never schedule acknowledgment-only phases.\n')
    plan['executionPins']['CONTRACT.md']=sha(new/'CONTRACT.md')
    plan['continuationReceipt']=config.get('receipt','localization/completion/resume-stopped-20261030-01/receipt.json')
    return sorted(selected)


def configure_process_repair(plan,new,config_path):
    if not config_path.is_relative_to(ROOT):raise ValueError('Process config outside canonical project')
    config=read(config_path)
    if config.get('schemaVersion')!=1 or config.get('kind')!='owner-requested-process-repair':
        raise ValueError('Expected explicit process repair configuration')
    plan['dependencyWake']=dict(schemaVersion=1,authorization=dict(path=str(config_path.relative_to(ROOT)),sha256=sha(config_path)))
    for job in plan['jobs']:
        job.pop('ownerResume',None)
        job.pop('sourceWake',None)
    with (new/'CONTRACT.md').open('a') as stream:
        stream.write('\n## Reviewed resource dependency continuation\n\n'+config['contract']+'\n')
    plan['executionPins']['CONTRACT.md']=sha(new/'CONTRACT.md')
    plan['executionPins'][os.path.relpath(config_path,new)]=sha(config_path)
    plan['continuationReceipt']=config['receipt']


def launch(previous, new, continuation_config=None, process_config=None):
    if continuation_config is not None and process_config is not None:
        raise ValueError('Choose finite continuation or process repair, not both')
    acceptance=ROOT/'localization/completion/russian-owner-baseline-20261030-01/acceptance.json'
    if continuation_config is None and process_config is None and acceptance.is_file() and read(acceptance).get('accepted') is True:
        raise ValueError('Accepted Russian baseline requires an explicit finite continuation config; legacy source-wake launch is obsolete')
    previous, new = previous.resolve(), new.resolve()
    plan = recover.prepare(previous, new, handoff=True)
    old = plan['observerHandoff']
    try:
        resumed=[]
        if process_config:
            configure_process_repair(plan,new,process_config.resolve())
        elif continuation_config:
            resumed=configure_owner_continuation(plan,new,continuation_config.resolve())
        else:
            configure_legacy_priority(plan,new)
        plan['repairAuthorization'] = 'Owner explicitly instructed stopped queues repaired and run; existing runtime/publication/server restrictions remain'
        (new / 'plan.prepared.json').write_bytes((new / 'plan.json').read_bytes())
        runner.save(new / 'plan.json', plan)
        return commit_handoff(previous,new,plan,old,resumed)
    except BaseException:
        if not (new / 'handoff.commit.json').exists():
            if runner.process_identity(old['oldPid'], previous, old['oldIdentity']) is not None:
                os.kill(old['oldPid'], signal.SIGCONT)
        raise


def configure_legacy_priority(plan,new):
    priority = new / 'owner-priority.md'
    priority.write_bytes((ROOT / 'localization/completion/queue-repair-20261030-01/TASK.md').read_bytes())
    technical = next(j for j in plan['jobs'] if j['locale'] == 'technical')
    state = read(ROOT / technical['directory'] / 'status.json')
    recent = [p for p in state['phases'] if p.get('resultSha256')][-8:]
    with priority.open('a') as stream:
        stream.write('\n## Newly accepted technical deliveries\n\n')
        for record in recent:
            path = Path(record['phase']) / 'result.json'
            if sha(path) != record['resultSha256']:
                raise ValueError('Recent technical receipt changed')
            stream.write(f'- {path.relative_to(ROOT)}; SHA-256 {record["resultSha256"]}; {record["title"]}\n')
            plan['executionPins'][os.path.relpath(path, new)] = sha(path)
    plan['ownerPriorityTask'] = dict(kind='technical',
        title='Close shared source admission and Chinese/Portuguese delivery blockers',
        brief=str(priority.relative_to(ROOT)), briefSha256=sha(priority))
    plan['executionPins'][str(priority.relative_to(new))] = sha(priority)
    source = 'localization/source/shared-source-completion-20261028/admission-v1/manifest.json'
    for job in plan['jobs']:
        if job['locale'] not in ('zh', 'pt-BR'):
            continue
        state = read(ROOT / job['directory'] / 'status.json')
        if state['status'] != 'blocked':
            continue
        last = state['phases'][-1]
        brief = new / 'source-wake' / f'{job["locale"]}.md'
        brief.parent.mkdir(exist_ok=True)
        brief.write_text(f'''# Complete newly source-admitted {job['locale']} wording

The owning blocked result is {Path(last['phase']) / 'result.json'}.
The observer wakes this existing lane only after the canonical source manifest
changes and explicitly accepts complete source admission, translation entry and
a complete visible denominator. Read that actual source delivery first.
Use the saved complete per-family checklist and exact held selectors. Finish
newly admitted locale wording and special-scene solutions with all required
English context and approved glossary, then a distinct independent review.
Retain matching receipts; apply universal source-change/restart and bounded
invalidation rules. Do not repeat unchanged accepted work or status reports.
Shared engineering remains in the one technical lane. If another actual external
predicate remains, record that precise boundary and stop unchanged continuation.
No game, GUI, image, installer, runtime, publication, deployment, server or Git
action. Fresh pinned Sol/high/OpenAI only; no nested workers or extra streams.
''')
        job['sourceWake'] = dict(sourceManifest=source, baselineSha256=sha(ROOT / source),
            task=dict(kind='work', title='Complete newly admitted '+job['locale']+' wording',
                      brief=str(brief.relative_to(ROOT)), briefSha256=sha(brief)))
        plan['executionPins'][str(brief.relative_to(new))] = sha(brief)


def commit_handoff(previous,new,plan,old,resumed):
    child=None
    try:
        argv = [str(ROOT / '.venv-assets314/bin/python'), '-B',
                str(new / 'execution/run_locale_completion.py'), '--run', str(new)]
        write(new / 'observer-submission-intent.json', dict(argv=argv, at=runner.now(), model=plan['model']))
        with (new / 'observer.stdout.jsonl').open('x') as out, (new / 'observer.stderr.log').open('x') as err:
            child = subprocess.Popen(argv, cwd=ROOT, stdin=subprocess.DEVNULL, stdout=out, stderr=err, start_new_session=True)
        write(new / 'observer-launch.json', dict(pid=child.pid, argv=argv, at=runner.now()))
        deadline = time.monotonic() + 20
        while not (new / 'handoff.ready.json').exists():
            if child.poll() is not None:
                raise RuntimeError('Observer exited before readiness; reconcile its logs')
            if time.monotonic() > deadline:
                raise RuntimeError('Readiness unknown; reconcile before retry')
            time.sleep(.1)
        ready = read(new / 'handoff.ready.json')
        if ready['pid'] != child.pid or ready['oldPid'] != old['oldPid']:
            raise ValueError('Readiness identity mismatch')
        if runner.process_identity(old['oldPid'], previous, old['oldIdentity']) is None:
            raise ValueError('Original observer identity changed')
        # Only the exactly verified paused observer exits. Its model children
        # keep running and are adopted by the ready successor.
        os.kill(old['oldPid'], signal.SIGKILL)
        deadline = time.monotonic() + 10
        while runner.process_identity(old['oldPid']) is not None:
            if time.monotonic() > deadline:
                raise RuntimeError('Old observer exit not established')
            time.sleep(.1)
        write(new / 'handoff.commit.json', dict(newPid=child.pid, oldPid=old['oldPid'], at=runner.now(), activeChildrenPreserved=True))
        deadline = time.monotonic() + 10
        while not (new / 'status.json').exists():
            if child.poll() is not None or time.monotonic() > deadline:
                raise RuntimeError('Committed observer status unknown; preserve children and reconcile')
            time.sleep(.1)
        pointer = ROOT / 'outputs/locale-assets-20261026/launch-current.json'
        (new / 'previous-launch-current.json').write_bytes(pointer.read_bytes())
        runner.save(pointer, dict(run=str(new.relative_to(ROOT)), status=str((new / 'status.json').relative_to(ROOT)),
            revision='continuous-production-v9-reviewed-dependency-wake' if plan.get('dependencyWake') else 'continuous-production-v7-owner-accepted-baseline-continuation' if resumed else 'continuous-production-v6-repaired-capacity-and-source-wake', automaticContinuation=True,
            receipt=plan.get('continuationReceipt','localization/completion/queue-repair-20261030-01/receipt.json')))
        return dict(status='observer-handoff-committed', run=str(new.relative_to(ROOT)), pid=child.pid,
                    ownerResumedLanguages=resumed, existingChildrenPreserved=True)
    except BaseException:
        if not (new / 'handoff.commit.json').exists():
            if child is not None and runner.process_identity(child.pid, new) is not None:
                child.terminate()
                child.wait(timeout=5)
            if runner.process_identity(old['oldPid'], previous, old['oldIdentity']) is not None:
                os.kill(old['oldPid'], signal.SIGCONT)
        raise


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--previous', type=Path, required=True)
    parser.add_argument('--run', type=Path, required=True)
    parser.add_argument('--continuation-config', type=Path)
    parser.add_argument('--process-config', type=Path)
    args = parser.parse_args()
    print(json.dumps(launch(args.previous, args.run,args.continuation_config,args.process_config), ensure_ascii=False))
