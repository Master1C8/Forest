#!/usr/bin/env python3
"""One-shot, no-model polling for the owner-authorized localization continuation."""
import argparse
import hashlib
import datetime
import json
import os
from pathlib import Path
import shutil
import subprocess
import time
from cli_job_support import validate_model, cli_events, digest

MODEL, EFFORT = 'gpt-6.1-sol', 'high'
LOCALES = ('ru','zh','es','es-419','pt-BR','de')

def save(path, value):
    temporary=path.with_suffix(path.suffix+'.pending')
    temporary.write_text(json.dumps(value,ensure_ascii=False,indent=2)+'\n');temporary.replace(path)

def now():return datetime.datetime.now(datetime.timezone.utc).isoformat()

def readiness(root, jobs):
    complete=[]; versions={}
    for locale in LOCALES:
        directory=Path(jobs[locale]); state=json.loads((directory/'job.json').read_text())
        if state['status']!='full-pass-complete-awaiting-adjudication':continue
        config=json.loads((directory/'config.json').read_text())
        validate_model(config['model'],config['reasoning'],'openai')
        for name,want in config['pins'].items():
            assert digest(name)==want,'Editorial input changed: '+name
        expected=[i for batch in config['batches'] for i in batch]; observed=[]
        for phase in state['phases']:
            if phase['status']!='batch-reviewed':continue
            p=Path(phase['directory']); result=json.loads((p/'result.json').read_text())
            assert digest(p/'pairs.jsonl')==phase['packetSha256']
            assert result == phase['result'], 'Final result differs from accepted checkpoint'
            assert digest(p/'reviews.jsonl')==result['reviewsSha256']
            reviewed=[json.loads(line) for line in (p/'reviews.jsonl').read_text().splitlines()]
            assert len(reviewed)==result['reviewedIds']
            packet=[json.loads(line) for line in (p/'pairs.jsonl').read_text().splitlines()]
            by_id={r['id']:r for r in packet}
            assert len(by_id)==len(packet)==len(reviewed), 'Duplicate or missing packet/review IDs'
            assert len({r['id'] for r in reviewed})==len(reviewed), 'Duplicate review IDs'
            assert {r['id'] for r in reviewed}==by_id.keys(), 'Foreign or missing review IDs'
            for row in reviewed:
                assert all(row[k]==by_id[row['id']][k] for k in ['sourceSha256','targetSha256']), 'Reviewed source/target version differs'
            observed.extend(r['id'] for r in reviewed)
            versions[str(p/'reviews.jsonl')]=result['reviewsSha256']
        assert len(observed)==len(expected)==len(set(observed))==config['candidateIds']==state['reviewedIds'], 'Incomplete or duplicate full-pass coverage'
        assert set(observed)==set(expected), 'Full-pass stable ID set differs'
        complete.append(locale)
        versions[str(directory/'config.json')]=digest(directory/'config.json')
        versions[str(directory/'findings.jsonl')]=digest(directory/'findings.jsonl')
    return {'complete':complete,'ready':len(complete)==len(LOCALES),'versions':versions,
            'meaning':'Complete initial preliminary semantic readings only; remaining editorial/technical gates are NOT accepted.'}

def command(plan, directory):
    validate_model(plan['model'],plan['reasoning'],'openai')
    return [plan['cli'],'exec','--ignore-user-config','--model',MODEL,
        '-c','model_provider="openai"','-c','model_reasoning_effort="high"',
        '-c','approval_policy="never"','--sandbox','danger-full-access','--disable','multi_agent',
        '--cd',plan['root'],'--json','--output-last-message',str(directory/'last-message.txt'),
        'Execute the exact owner-authorized continuation brief '+str(directory/'request.md')+
        '. First read that file; do not search histories or discover unrelated projects. Fresh no-history '+MODEL+
        '/high/OpenAI. NEVER Astra/default/fallback. At most six locale streams, existing technical CLI untouched.']

def recover_observer(directory, receipt):
    value=json.loads(receipt.read_text())
    assert value['kind']=='ordered-review-guard-recovery'
    assert digest(directory/'status.json')==value['statusSha256']
    assert json.loads((directory/'status.json').read_text())['status']=='held'
    claim=directory/'watcher.claim';assert json.loads(claim.read_text())['pid']==value['priorWatcherPid']
    process=subprocess.run(['ps','-p',str(value['priorWatcherPid']),'-o','pid='],capture_output=True,text=True)
    assert process.returncode!=0, 'Prior observer still running'
    assert not (directory/'submission-intent.json').exists(), 'Prior model submission needs separate reconciliation'
    claim.rename(receipt.parent/'prior-watcher.claim')


def run(directory, interval=30, reconciliation=None):
    directory=directory.resolve();plan_bytes=(directory/'plan.json').read_bytes()
    plan=json.loads(plan_bytes);plan_sha=hashlib.sha256(plan_bytes).hexdigest()
    validate_model(plan['model'],plan['reasoning'],'openai')
    assert set(plan['jobs'])==set(LOCALES)
    assert not (directory/'submission-intent.json').exists(),'Prior submission outcome needs reconciliation; never resubmit'
    for path,want in plan['executionPins'].items():assert digest(path)==want,'Frozen continuation dependency changed'
    if reconciliation:recover_observer(directory,reconciliation)
    claim=directory/'watcher.claim'
    with claim.open('x') as f:json.dump({'pid':os.getpid(),'at':now()},f)
    prior=None
    try:
        while True:
            result=readiness(Path(plan['root']),plan['jobs'])
            signature=tuple(result['complete'])
            if signature!=prior:
                save(directory/'status.json',{'status':'waiting-for-current-six-readings','at':now(),
                     'complete':result['complete'],'modelRequestsStarted':0});prior=signature
            if result['ready']:break
            time.sleep(interval)
        for path,want in plan['executionPins'].items():assert digest(path)==want,'Continuation changed while waiting'
        assert digest(directory/'plan.json')==plan_sha, 'Continuation plan changed while waiting'
        save(directory/'trigger.json',{'at':now(),'planSha256':plan_sha,**result})
        argv=command(plan,directory)
        # An unknown create outcome is never retried. One intent precedes one Popen.
        with (directory/'submission-intent.json').open('x') as f:
            json.dump({'at':now(),'argv':argv,'model':MODEL,'reasoning':EFFORT,'inheritedHistory':False},f,indent=2)
        with (directory/'events.jsonl').open('w') as out,(directory/'stderr.log').open('w') as err:
            child=subprocess.Popen(argv,cwd=plan['root'],stdout=out,stderr=err,stdin=subprocess.DEVNULL)
            save(directory/'status.json',{'status':'continuation-running','at':now(),'pid':child.pid,'model':MODEL,'reasoning':EFFORT})
            code=child.wait()
        thread,usage,errors=cli_events(directory/'events.jsonl')
        save(directory/'status.json',{'status':'continuation-exited','at':now(),'exitCode':code,
            'threadId':thread,'measuredUsage':usage,'errors':errors,
            'limits':'Process completion is not localization acceptance; read the successor result and gate evidence.'})
    except BaseException as error:
        save(directory/'status.json',{'status':'held','at':now(),'reason':repr(error),
             'limits':'No automatic retry or replacement; preserve any submission identity.'});raise

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--job',type=Path,required=True)
    p.add_argument('--reconcile',type=Path)
    args=p.parse_args();run(args.job,reconciliation=args.reconcile)
