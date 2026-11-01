"""Continue a verified own incomplete CLI assignment without an external blocker."""
from pathlib import Path
import datetime
import hashlib
import importlib.util
import json
import subprocess
import sys
import time

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
CONTROL = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / 'tools'))
from cli_job_support import validate_model
from locale_efficiency import latest_usage


def read(path):
    return json.loads(path.read_text())


def save(path, value):
    pending = path.with_suffix(path.suffix + '.pending')
    pending.write_text(json.dumps(value, indent=2) + '\n')
    pending.replace(path)


def now():
    return datetime.datetime.now(datetime.timezone.utc).isoformat()


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    cfg = read(CONTROL / 'resume-manifest.json')
    out = ROOT / cfg['statusDirectory']
    out.mkdir(exist_ok=True)
    assert not (out / 'supervisor.json').exists(), 'Reconcile prior submission'
    validate_model('gpt-6.1-sol', 'high', 'openai')
    helper = ROOT / cfg['runtimeHelper']
    assert sha(helper) == cfg['runtimeHelperSha256']
    spec = importlib.util.spec_from_file_location('verified_own_turn', helper)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    for lane in cfg['lanes']:
        phase = ROOT / lane['phase']
        assert not (phase / 'submission.json').exists()
        task = read(phase / 'task.json')
        for path, expected in task['job']['immutablePins'].items():
            assert sha(ROOT / path) == expected, path
        assert sha(ROOT / 'localization/languages' / (lane['locale'] + '.json')) == task['job']['initialLanguageSha256']
    save(out / 'supervisor.json', dict(status='starting', pid=__import__('os').getpid(), atUTC=now()))
    children, records = [], []
    try:
        for lane in cfg['lanes']:
            phase = ROOT / lane['phase']
            session = Path(lane['sessionMetadataPath'])
            baseline, offset = latest_usage(session), session.stat().st_size
            args = [cfg['cli'], 'exec', 'resume', '--ignore-user-config', '--model', 'gpt-6.1-sol',
                    '-c', 'model_provider="openai"', '-c', 'model_reasoning_effort="high"',
                    '-c', 'approval_policy="never"', '-c', 'sandbox_mode="danger-full-access"',
                    '--disable', 'multi_agent', '--json', '--output-last-message', str(phase / 'last-message.txt'),
                    lane['threadId'], f'Continue the SAME incomplete own independent-review assignment without a source or permission blocker. '
                    f'FIRST read {phase}/brief.md and task.json, await {phase}/runtime-verification.json proving the NEW '
                    'actual Sol/high/OpenAI turn after this metadata offset, before further linguistic work. '
                    'No inherited parent/fork or nested model. Reconcile interrupted tool/write outcomes before retrying; '
                    'old phase is immutable, all new writes use the new allowed prefixes. Finish the finite remaining assignment.']
            save(phase / 'submission.json', dict(argv=args, baselineUsage=baseline, metadataOffset=offset,
                 sameOwnThread=True, inheritedParentHistory=False, atUTC=now()))
            with (phase / 'events.jsonl').open('x') as stdout, (phase / 'stderr.log').open('x') as stderr:
                child = subprocess.Popen(args, cwd=ROOT, stdin=subprocess.DEVNULL, stdout=stdout,
                                         stderr=stderr, start_new_session=True)
            save(phase / 'launch.json', dict(pid=child.pid, atUTC=now()))
            children.append((lane, phase, child, baseline))
            deadline = time.monotonic() + 45
            actual = evidence = None
            while time.monotonic() < deadline:
                actual, evidence = module.current_runtime(session, offset)
                if actual:
                    break
                assert child.poll() is None, 'Child exited; preserve evidence, no automatic retry'
                time.sleep(.2)
            assert actual == dict(model='gpt-6.1-sol', effort='high'), 'Unknown actual model; no localization input'
            argv = subprocess.check_output(['ps', '-p', str(child.pid), '-o', 'pid=,ppid=,lstart=,command='], text=True)
            assert all(s in argv for s in ['exec resume --ignore-user-config', '--model gpt-6.1-sol',
                       'model_provider="openai"', 'model_reasoning_effort="high"', str(phase), lane['threadId']])
            session_identity = lane['sourceRuntime']['actualRuntime']['session']
            assert session_identity['model_provider'] == 'openai' and session_identity.get('parent_thread_id') is None
            runtime = dict(threadId=lane['threadId'], sessionMetadataPath=str(session), pid=child.pid,
                           actualRuntime=dict(session=session_identity, turn=actual), actualArgvEvidence=argv,
                           resumedOwnTaskNoParentHistory=True, currentTurnMetadataAfterOffset=offset,
                           baselineUsage=baseline, modelEvidence=evidence)
            save(phase / 'runtime-verification.json', runtime)
            record = dict(locale=lane['locale'], phase=lane['phase'], pid=child.pid, threadId=lane['threadId'],
                          model='gpt-6.1-sol', reasoning='high', provider='openai', status='running',
                          resumedOwnTaskNoParentHistory=True, runtimeVerified=True, atUTC=now())
            records.append(record)
            save(out / 'status.json', dict(status='running', lanes=records, atUTC=now()))
            print(json.dumps(record), flush=True)
        save(out / 'launch-complete.json', dict(lanes=records, atUTC=now()))
        while children:
            for lane, phase, child, baseline in list(children):
                code = child.poll()
                if code is None:
                    continue
                final = latest_usage(Path(lane['sessionMetadataPath']))
                delta = {key: final[key] - baseline[key] for key in final}
                assert all(v >= 0 for v in delta.values()), 'Nonmonotonic telemetry; reconcile without invention'
                result = read(phase / 'result.json') if (phase / 'result.json').exists() else {}
                receipt = dict(exitCode=code, finishedAt=now(), usage=delta, baselineUsage=baseline,
                               finalCumulativeUsage=final, resultStatus=result.get('status', result.get('outcome', 'missing-result')),
                               telemetry='Nonoverlapping same-own-session delta; cache/reasoning are subsets.')
                save(phase / 'process-exit.json', receipt)
                next(r for r in records if r['locale'] == lane['locale']).update(
                    status='finished' if code == 0 and result else 'needs-attention', **receipt)
                children.remove((lane, phase, child, baseline))
                save(out / 'status.json', dict(status='running' if children else 'finished', lanes=records, atUTC=now()))
            if children:
                time.sleep(1)
        save(out / 'supervisor.json', dict(status='finished', noAutomaticFollowup=True, atUTC=now()))
    except BaseException as error:
        save(out / 'supervisor.json', dict(status='observer-error-preserve-children', error=repr(error),
             children=[dict(locale=l['locale'], phase=str(p), pid=c.pid) for l, p, c, _ in children], atUTC=now()))
        raise


if __name__ == '__main__':
    main()
