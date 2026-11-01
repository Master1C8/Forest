"""Continue one incomplete, uncontaminated own author assignment; never retry."""
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


def read(p):
    return json.loads(p.read_text())


def save(p, data):
    temporary = p.with_suffix(p.suffix + '.pending')
    temporary.write_text(json.dumps(data, indent=2) + '\n')
    temporary.replace(p)


def now():
    return datetime.datetime.now(datetime.timezone.utc).isoformat()


def main():
    cfg = read(CONTROL / 'continuation.json')
    phase = ROOT / cfg['phase']
    task = read(phase / 'task.json')
    validate_model('gpt-6.1-sol', 'high', 'openai')
    assert not (phase / 'submission.json').exists(), 'Reconcile existing submission first'
    for name, digest in task['job']['immutablePins'].items():
        assert hashlib.sha256((ROOT / name).read_bytes()).hexdigest() == digest, name
    language = ROOT / 'localization/languages/th.json'
    assert hashlib.sha256(language.read_bytes()).hexdigest() == task['job']['initialLanguageSha256']
    helper = ROOT / 'localization/completion/six-new-locales-20261101-01/continuations/run.py'
    spec = importlib.util.spec_from_file_location('forest_verified_continuation', helper)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    session = Path(cfg['sessionMetadataPath'])
    baseline, offset = latest_usage(session), session.stat().st_size
    cli = '/Applications/ChatGPT.app/Contents/Resources/codex-cli/CodexCLI.app/Contents/MacOS/codex'
    args = [cli, 'exec', 'resume', '--ignore-user-config', '--model', 'gpt-6.1-sol',
            '-c', 'model_provider="openai"', '-c', 'model_reasoning_effort="high"',
            '-c', 'approval_policy="never"', '-c', 'sandbox_mode="danger-full-access"',
            '--disable', 'multi_agent', '--json', '--output-last-message', str(phase / 'last-message.txt'),
            cfg['threadId'], f'Continue the SAME incomplete full Thai author assignment through {phase}/brief.md and task.json. '
            f'FIRST await {phase}/runtime-verification.json proving the NEW actual resumed Sol/high/OpenAI turn before localized input. '
            'Retain real own drafts; no inherited parent/fork, nested models, Git/shared edits, game/build/publication or routine first-batch stopping.']
    save(phase / 'submission.json', dict(argv=args, baselineUsage=baseline, metadataOffset=offset,
         sameOwnThread=True, inheritedParentHistory=False, helperSha256=hashlib.sha256(helper.read_bytes()).hexdigest(), atUTC=now()))
    with (phase / 'events.jsonl').open('x') as stdout, (phase / 'stderr.log').open('x') as stderr:
        child = subprocess.Popen(args, cwd=ROOT, stdin=subprocess.DEVNULL, stdout=stdout,
                                 stderr=stderr, start_new_session=True)
    save(phase / 'launch.json', dict(pid=child.pid, atUTC=now()))
    save(CONTROL / 'status.json', dict(status='verifying-runtime', pid=child.pid, phase=cfg['phase'], atUTC=now()))
    try:
        deadline = time.monotonic() + 40
        actual = evidence = None
        while time.monotonic() < deadline:
            actual, evidence = module.current_runtime(session, offset)
            if actual:
                break
            assert child.poll() is None, 'Child exited before runtime; preserve evidence, no retry'
            time.sleep(.2)
        assert actual == dict(model='gpt-6.1-sol', effort='high'), 'Unknown new model; preserve child, no retry'
        argv = subprocess.check_output(['ps', '-p', str(child.pid), '-o', 'pid=,ppid=,lstart=,command='], text=True)
        assert all(x in argv for x in ['exec resume --ignore-user-config', '--model gpt-6.1-sol',
                   'model_provider="openai"', 'model_reasoning_effort="high"', str(phase), cfg['threadId']])
        runtime = dict(threadId=cfg['threadId'], sessionMetadataPath=str(session), pid=child.pid,
                       actualRuntime=dict(session=cfg['sourceRuntime']['actualRuntime']['session'], turn=actual),
                       actualArgvEvidence=argv, resumedOwnTaskNoParentHistory=True,
                       currentTurnMetadataAfterOffset=offset, baselineUsage=baseline, modelEvidence=evidence)
        save(phase / 'runtime-verification.json', runtime)
        save(CONTROL / 'status.json', dict(status='running', pid=child.pid, threadId=cfg['threadId'], phase=cfg['phase'], atUTC=now()))
        code = child.wait()
        final = latest_usage(session)
        delta = {key: final[key] - baseline[key] for key in final}
        result = read(phase / 'result.json') if (phase / 'result.json').exists() else {}
        receipt = dict(exitCode=code, finishedAt=now(), usage=delta, baselineUsage=baseline,
                       finalCumulativeUsage=final, resultStatus=result.get('status', result.get('outcome', 'missing-result')),
                       telemetry='Nonoverlapping same-own-session delta; cache/reasoning are subsets.')
        save(phase / 'process-exit.json', receipt)
        save(CONTROL / 'status.json', dict(status='finished', phase=cfg['phase'], **receipt))
    except BaseException as error:
        save(CONTROL / 'status.json', dict(status='observer-error-preserve-child', pid=child.pid,
             error=repr(error), noRetry=True, atUTC=now()))
        raise


if __name__ == '__main__':
    main()
