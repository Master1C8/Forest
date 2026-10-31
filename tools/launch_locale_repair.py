"""Explicit owner-authorized repair handoff; preserves live language children."""
import argparse
import copy
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


def prepare_terminal(previous,new,config_path):
    """Resume named blocked lanes after a delivered change; no live handoff/model.

    Unselected lanes are never reconciled or rewritten. Existing request outcomes
    and immutable execution versions remain in place.
    """
    previous,new,config_path=previous.resolve(),new.resolve(),config_path.resolve()
    if not all(p.is_relative_to(ROOT) for p in [previous,new,config_path]):
        raise ValueError('Terminal continuation must stay in canonical project')
    config=read(config_path);plan=copy.deepcopy(read(previous/'plan.json'))
    selected=set(config.get('resumes',{}));jobs={j['locale']:j for j in plan['jobs']}
    if (config.get('kind')!='owner-authorized-local-completion' or not selected or
            'technical' in selected or not selected<=set(jobs)):
        raise ValueError('Explicit existing locale continuations required')
    runner.validate_model(plan['model']['name'],plan['model']['reasoning'],plan['model']['provider'])
    if plan['model'].get('inheritedHistory') is not False or plan['root']!=str(ROOT):
        raise ValueError('Fresh canonical runtime required')
    if sha(Path(plan['cli']))!=plan['cliSha256']:raise ValueError('CLI executable changed')
    observer=read(previous/'status.json');identity=runner.process_identity(observer['pid'])
    if identity and str(previous) in identity['command']:
        raise ValueError('Live observer needs the existing handoff workflow')
    recoveries={};untouched={}
    for locale,job in jobs.items():
        lane=ROOT/job['directory'];status=lane/'status.json'
        if locale not in selected:
            if status.exists():untouched[locale]={n:sha(lane/n) for n in ['status.json','continuation.lock'] if (lane/n).exists()}
            continue
        state=read(status);last=state['phases'][-1];phase=Path(last['phase'])
        if state['status']!='blocked':raise ValueError('Selected lane is no longer blocked')
        identity=runner.process_identity(last['pid'])
        if identity and str(phase) in identity['command']:raise ValueError('Selected worker still alive')
        job['ownerResume']=config['resumes'][locale]
        stopped=dict(path=str((phase/'result.json').relative_to(ROOT)),sha256=last['resultSha256'])
        runner.owner_resume_task(ROOT,job,stopped)
        if sha(phase/'result.json')!=stopped['sha256']:raise ValueError('Stopped result changed')
        recoveries[locale]=dict(kind='retained-terminal-lane',previousStatusSha256=sha(status),
            previousClaimSha256=sha(lane/'continuation.lock'),resultSha256=stopped['sha256'],
            archive=str((new/'prior-state'/locale).relative_to(ROOT)))
        job.pop('sourceWake',None)
        for prefix in config.get('extraWritePrefixes',{}).get(locale,[]):
            runner.local(ROOT,prefix)  # No escape from canonical project.
            if prefix not in job['writePrefixes']:job['writePrefixes'].append(prefix)
    if new.exists():raise ValueError('Reconcile existing continuation directory; do not duplicate submission')
    new.mkdir(parents=True);(new/'execution').mkdir();(new/'receipts').mkdir()
    for source in (previous/'execution').glob('*.py'):
        target=new/'execution'/source.name;target.write_bytes((ROOT/'tools'/source.name).read_bytes())
    (new/'CONTRACT.md').write_text((previous/'CONTRACT.md').read_text()+'\n## Current authorized local completion\n\n'+config['contract']+'\n')
    pins={str(p.relative_to(new)):sha(p) for p in [*(new/'execution').glob('*.py'),new/'CONTRACT.md']}
    for name,digest in plan['executionPins'].items():
        if name.startswith('execution/') or name=='CONTRACT.md':continue
        path=(previous/name).resolve()
        if sha(path)!=digest:raise ValueError('Prior frozen dependency changed')
        pins[os.path.relpath(path,new)]=digest
    pins[os.path.relpath(config_path,new)]=sha(config_path)
    for locale in selected:
        path=new/'receipts'/f'{locale}.json';write(path,recoveries[locale])
        job=jobs[locale];job['resumeReceipt']=str(path.relative_to(ROOT));job['resumeReceiptSha256']=sha(path)
        resume=job['ownerResume']
        for pin in [resume['authorization'],resume['baselineAcceptance'],resume['scope'],
                    dict(path=resume['task']['brief'],sha256=resume['task']['briefSha256'])]:
            pins[os.path.relpath(ROOT/pin['path'],new)]=pin['sha256']
    for key in ['observerHandoff','ownerPriorityTask','dependencyWake']:plan.pop(key,None)
    plan.update(executionLocales=sorted(selected),executionPins=pins,recoveredFrom=str(previous),
        efficiencyHelper=str(new/'execution/locale_efficiency.py'),continuationReceipt=config['receipt'])
    write(new/'disabled-lanes.before.json',untouched);write(new/'plan.json',plan)
    return plan


def launch_terminal(previous,new,config_path):
    plan=prepare_terminal(previous,new,config_path)
    new=new.resolve();argv=[str(ROOT/'.venv-assets314/bin/python'),'-B',str(new/'execution/run_locale_completion.py'),'--run',str(new)]
    write(new/'observer-submission-intent.json',dict(argv=argv,at=runner.now(),model=plan['model'],executionLocales=plan['executionLocales']))
    with (new/'observer.stdout.jsonl').open('x') as out,(new/'observer.stderr.log').open('x') as err:
        child=subprocess.Popen(argv,cwd=ROOT,stdin=subprocess.DEVNULL,stdout=out,stderr=err,start_new_session=True)
    write(new/'observer-launch.json',dict(pid=child.pid,argv=argv,at=runner.now()))
    deadline=time.monotonic()+20
    while not (new/'status.json').exists():
        if child.poll() is not None:raise RuntimeError('Observer exited; reconcile this exact saved launch, never resubmit blindly')
        if time.monotonic()>deadline:return dict(status='submitted-readiness-pending',pid=child.pid,run=str(new.relative_to(ROOT)))
        time.sleep(.1)
    pointer=ROOT/'outputs/locale-assets-20261026/launch-current.json'
    if pointer.exists():(new/'previous-launch-current.json').write_bytes(pointer.read_bytes())
    runner.save(pointer,dict(run=str(new.relative_to(ROOT)),status=str((new/'status.json').relative_to(ROOT)),
        executionLocales=plan['executionLocales'],automaticContinuation=True,otherLocalesRemainStopped=True,
        revision='autonomous-authorized-local-completion',receipt=plan['continuationReceipt']))
    return dict(status='observer-started',pid=child.pid,run=str(new.relative_to(ROOT)),executionLocales=plan['executionLocales'])


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
    plan['enforceLinguisticOwnership']=config.get('enforceLinguisticOwnership',False)
    if plan['enforceLinguisticOwnership']:
        plan.setdefault('dispatchDirectory',str(new/'dispatch-holds'))
    priority=config.get('technicalPriority')
    if config.get('localeOwned'):
        retirement=config['technicalRetirement'];rp=ROOT/retirement['path']
        if sha(rp)!=retirement['sha256']:raise ValueError('Technical retirement receipt changed')
        retired=read(rp);old=next((j for j in plan['jobs'] if j['locale']=='technical'),None)
        if old is None and plan.get('localeOwned'):
            matches=[entry['job'] for entry in plan.get('retiredJobs',[]) if entry.get('retirement')==retirement]
            if len(matches)==1:old=matches[0]
        if old is None or retired.get('status')!='owner-stopped' or retired['lane']['directory']!=old['directory']:
            raise ValueError('Expected exact owner-stopped technical lane')
        state=read(ROOT/old['directory']/'status.json');record=state['phases'][-1]
        if record['pid']!=retired['lane']['pid'] or record.get('threadId')!=retired['lane']['threadId']:
            raise ValueError('Retirement belongs to a different technical request')
        for process in retired['processes']:
            if runner.process_identity(process['pid'],expected=process['identity']):raise ValueError('Retired technical process still alive')
        plan['retiredJobs']=[dict(job=old,retirement=retirement)]
        plan['jobs']=[j for j in plan['jobs'] if j['locale']!='technical']
        plan['localeOwned']=True;plan['enforceLinguisticOwnership']=False
        plan.pop('ownerPriorityTask',None);priority=None
        plan.pop('dependencyWake',None)
        plan['executionPins'][os.path.relpath(rp,new)]=retirement['sha256']
        if config.get('resumes'):
            for job in plan['jobs']:
                resume=config['resumes'].get(job['locale'])
                if not resume:continue
                state=read(ROOT/job['directory']/'status.json')
                if state['status'] not in {'blocked','held-dispatch-policy'}:raise ValueError('Locale continuation is no longer terminal')
                record=state['phases'][-1];job['ownerResume']=resume
                runner.owner_resume_task(ROOT,job,dict(path=str((Path(record['phase'])/'result.json').relative_to(ROOT)),sha256=record['resultSha256']))
                for pin in [resume['authorization'],resume['baselineAcceptance'],resume['scope'],dict(path=resume['task']['brief'],sha256=resume['task']['briefSha256'])]:
                    plan['executionPins'][os.path.relpath(ROOT/pin['path'],new)]=pin['sha256']
        if config.get('processSpecUpdate'):
            update=config['processSpecUpdate'];target=ROOT/update['current']['path'];replacement=ROOT/update['replacement']['path']
            if sha(target)!=update['current']['sha256'] or sha(replacement)!=update['replacement']['sha256']:
                raise ValueError('Process specification migration changed')
            for job in plan['jobs']:
                record=read(ROOT/job['directory']/'status.json')['phases'][-1]
                if runner.process_identity(record['pid'],Path(record['phase'])):
                    raise ValueError('Preserve live worker process specification until its finite phase exits')
            value=read(replacement)
            if value.get('limits')!={'linguistic':6,'technical':0}:raise ValueError('Locale-owned specification requires zero technical jobs')
            archive=new/'process-spec.before.json';archive.write_bytes(target.read_bytes())
            runner.save(target,value)
            for job in plan['jobs']:
                for name in list(job['immutablePins']):
                    if (Path(name) if Path(name).is_absolute() else ROOT/name).resolve()==target.resolve():
                        job['immutablePins'][name]=sha(target)
            plan['executionPins'][os.path.relpath(target,new)]=sha(target)
    if priority:
        if priority.get('kind')!='technical' or sha(ROOT/priority['brief'])!=priority['briefSha256']:
            raise ValueError('Technical process consolidation task changed')
        plan['ownerPriorityTask']=priority
        plan['executionPins'][os.path.relpath(ROOT/priority['brief'],new)]=priority['briefSha256']
    for job in plan['jobs']:
        if not config.get('localeOwned'):job.pop('ownerResume',None)
        job.pop('sourceWake',None)
    with (new/'CONTRACT.md').open('a') as stream:
        stream.write('\n## Reviewed resource dependency continuation\n\n'+config['contract']+'\n')
    plan['executionPins']['CONTRACT.md']=sha(new/'CONTRACT.md')
    plan['executionPins'][os.path.relpath(config_path,new)]=sha(config_path)
    plan['continuationReceipt']=config['receipt']
    return sorted(config.get('resumes',{}))


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
            resumed=configure_process_repair(plan,new,process_config.resolve())
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
            revision='continuous-locale-owned-no-technical-stream' if plan.get('localeOwned') else 'continuous-production-v9-reviewed-dependency-wake' if plan.get('dependencyWake') else 'continuous-production-v7-owner-accepted-baseline-continuation' if resumed else 'continuous-production-v6-repaired-capacity-and-source-wake', automaticContinuation=True,
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
    parser.add_argument('--terminal-config', type=Path,help='Explicit finite work for named blocked lanes; preserves all unselected lanes')
    args = parser.parse_args()
    if args.terminal_config:
        if args.continuation_config or args.process_config:parser.error('Choose terminal continuation or live handoff configuration')
        result=launch_terminal(args.previous,args.run,args.terminal_config)
    else:result=launch(args.previous,args.run,args.continuation_config,args.process_config)
    print(json.dumps(result, ensure_ascii=False))
