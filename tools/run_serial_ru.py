#!/usr/bin/env python3
"""Run sequential technical phases alongside the authorized asset-translation lane."""
import argparse
import datetime
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys

from cli_job_support import evidence_files, cli_events

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
MODEL, EFFORT, PROVIDER = 'gpt-6.1-sol', 'high', 'openai'


def validate_model(model, effort, provider):
    if 'astra' in model.lower() or (model, effort, provider) != (MODEL, EFFORT, PROVIDER):
        raise ValueError('Only the explicitly approved gpt-6.1-sol/high/OpenAI is permitted.')


def now():
    return datetime.datetime.now(datetime.timezone.utc).isoformat()


def digest(path):
    h = hashlib.sha256()
    with path.open('rb') as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()


def atomic_json(path, value):
    temp = path.with_name(path.name + '.pending')
    temp.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')
    temp.replace(path)


def validate_capacity_restart(directory, previous, receipt_path, first_brief):
    receipt_path = receipt_path.resolve()
    assert directory in receipt_path.parents, 'Receipt belongs to another job.'
    receipt = json.loads(receipt_path.read_text())
    last = previous['phases'][-1]
    thread, _, errors = cli_events(Path(last['directory']) / 'events.jsonl')
    messages = [e.get('message') or (e.get('error') or {}).get('message') for e in errors]
    assert messages and all(m == 'Selected model is at capacity. Please try a different model.' for m in messages), 'Unknown request outcome cannot resume as capacity.'
    assert last.get('exitCode') == 1 and receipt['failedPhase'] == last['number'] and receipt['failedThreadId'] == thread, 'Wrong failed request.'
    assert digest(directory / 'job.json') == receipt['jobSha256'], 'Job changed since reconciliation.'
    assert first_brief == Path(receipt['nextBrief']).resolve() and digest(first_brief) == receipt['nextBriefSha256'], 'Continuation changed since reconciliation.'
    assert Path(last['directory']).resolve() in first_brief.parents, 'Use the recorded phase continuation.'
    assert receipt['ownerInstruction'] == 'Repair and continue both authorized CLI lanes', 'Restart authorization missing.'
    for name, expected in receipt['artifacts'].items():
        path = (ROOT / name).resolve()
        assert ROOT.resolve() in path.parents and digest(path) == expected, f'Recovered artifact changed: {name}'
    assert receipt['artifacts'], 'Recovered artifact verification is required.'
    return receipt


def validate_interruption_restart(directory, previous, receipt_path, first_brief):
    receipt_path = receipt_path.resolve()
    assert directory in receipt_path.parents, 'Receipt belongs to another job.'
    receipt = json.loads(receipt_path.read_text())
    last = previous['phases'][-1]
    thread, usage, errors = cli_events(Path(last['directory']) / 'events.jsonl')
    assert previous['status'] == 'running' and usage is None and not errors, 'Reconcile recorded completion/failure through its owning path.'
    assert receipt['kind'] == 'observer-interruption' and receipt['failedPhase'] == last['number'] and receipt['failedThreadId'] == thread, 'Wrong interrupted request.'
    assert digest(directory / 'job.json') == receipt['jobSha256'], 'Job changed since reconciliation.'
    assert first_brief == Path(receipt['nextBrief']).resolve() and digest(first_brief) == receipt['nextBriefSha256'], 'Continuation changed since reconciliation.'
    assert directory in first_brief.parents, 'Continuation must belong to this job.'
    assert receipt['ownerInstruction'] == 'Repair and continue both authorized CLI lanes', 'Restart authorization missing.'
    assert receipt['artifacts'], 'Recovered artifact verification is required.'
    for name, expected in receipt['artifacts'].items():
        path = (ROOT / name).resolve()
        assert ROOT.resolve() in path.parents and digest(path) == expected, f'Recovered artifact changed: {name}'
    cleanup = json.loads((ROOT / receipt['cleanup']).read_text())
    assert not cleanup['remainingTaskProcessRows'] and all(cleanup.get(k) is True for k in
        ('quitAcknowledged', 'originalAssetsAndPlayerFilesUnchanged', 'inspectionBridgeRemoved', 'inputPinsUnchanged')), 'Interrupted runtime cleanup is unverified.'
    return receipt


def run(directory, first_brief, resume=False, reconciliation=None, git_coordinator='technical'):
    directory, first_brief = directory.resolve(), first_brief.resolve()
    validate_model(MODEL, EFFORT, PROVIDER)
    assert git_coordinator in ('technical', 'parent'), 'Explicit Git coordinator required'
    assert directory.is_dir()
    path = directory / 'job.json'
    previous = json.loads(path.read_text()) if resume else None
    if resume:
        assert previous['status'] in ('needs-owner', 'held-supervisor-error', 'held-process-failure', 'running'), 'Reconcile the previous outcome before resuming.'
        capacity_receipt = None
        if previous['status'] == 'held-process-failure':
            assert reconciliation is not None, 'Failed request requires explicit capacity reconciliation; no automatic retry.'
            capacity_receipt = validate_capacity_restart(directory, previous, reconciliation, first_brief)
        elif previous['status'] == 'running':
            assert reconciliation is not None, 'A running record requires verified interruption reconciliation.'
            capacity_receipt = validate_interruption_restart(directory, previous, reconciliation, first_brief)
        if capacity_receipt is not None:
            assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip() == capacity_receipt['head'], 'Canonical HEAD changed after reconciliation.'
        for pid in (previous.get('supervisorPid'), previous['phases'][-1].get('pid')):
            if pid:
                row = subprocess.run(['ps', '-p', str(pid), '-o', 'command='], text=True, capture_output=True)
                assert not (row.returncode == 0 and str(directory) in row.stdout), 'Recorded technical process still alive.'
        history = directory / 'resume-history' / now().replace(':', '-')
        history.mkdir(parents=True)
        for name in ('job.json', 'contract.md', 'run_review.py', 'supervise.py', 'cli_job_support.py'):
            if not (directory / name).exists():
                continue
            shutil.copyfile(directory / name, history / name)
    else:
        assert not path.exists()
    registry = json.loads((Path.home() / '.codex/models_cache.json').read_text())
    assert any(x.get('slug') == MODEL for x in registry['models'])
    lock = directory / 'queue.lock'
    if lock.exists() and resume and previous['status'] == 'running' and capacity_receipt is not None:
        assert json.loads(lock.read_text()).get('pid') == previous['supervisorPid'], 'Queue claim belongs to another supervisor.'
        shutil.copyfile(lock, history / 'queue.lock')
        lock.unlink()
    with lock.open('x') as stream:
        json.dump({'pid': os.getpid(), 'startedAt': now()}, stream)
    codex = Path(shutil.which('codex')).resolve()
    codex_hash = digest(codex)
    contract = directory / 'contract.md'
    shutil.copyfile(ROOT / 'localization/CLI-TASK.md', contract)
    contract_hash = digest(contract)
    source_wrapper = Path('/Users/antonkrutov/.codex/skills/game-localization-visual-qa/scripts/run_review.py')
    wrapper = directory / 'run_review.py'
    shutil.copyfile(source_wrapper, wrapper)
    wrapper_hash = digest(wrapper)
    support = directory / 'cli_job_support.py'
    support_hash = digest(support)
    state = previous or {'schemaVersion': 1, 'task': 'The Forest of Love 0.45 Russian localization',
             'status': 'running', 'startedAt': now(), 'supervisorPid': os.getpid(),
             'model': MODEL, 'reasoning': EFFORT, 'provider': PROVIDER,
             'parallelism': 1, 'freshSessionsWithoutInheritedHistory': True,
             'contractSha256': contract_hash, 'reviewWrapperSha256': wrapper_hash,
             'reviewWrapperSource': str(source_wrapper), 'phases': []}
    if resume:
        if capacity_receipt is not None:
            state['phases'][-1].update(status='interruption-reconciled' if capacity_receipt.get('kind') == 'observer-interruption' else 'capacity-reconciled',
                parentReconciliation={'receipt': str(reconciliation.resolve()), 'sha256': digest(reconciliation),
                                      'recoveredArtifacts': capacity_receipt['artifacts']})
        if previous['status'] == 'held-supervisor-error':
            last = state['phases'][-1]
            assert last.get('exitCode') == 0 and last.get('result', {}).get('outcome') == 'continue', 'Unresolved worker failure cannot be replayed.'
            phase = Path(last['directory']).resolve()
            result = last['result']
            substantive, auxiliary = evidence_files(ROOT, directory, result['evidence'])
            next_path = Path(result['nextBrief']).resolve()
            assert phase in next_path.parents and next_path.is_file()
            assert first_brief.resolve() == next_path, 'Resume the recorded continuation; do not rerun completed work.'
            last.update(status='phase-complete', evidenceFingerprints=sorted(substantive), auxiliaryEvidence=sorted(auxiliary), resultReconciledAt=now())
        state.setdefault('resumptions', []).append({
            'resumedAt': now(), 'previousStatus': state['status'], 'previousReason': state.get('reason'),
            'history': str(history), 'brief': str(first_brief),
            'authorization': 'Owner explicitly instructed resume technical CLI with parallel translation allowed; do not stop translation.'})
        state.update(status='running', supervisorPid=os.getpid(), contractSha256=contract_hash,
                     reviewWrapperSha256=wrapper_hash, reviewWrapperSource=str(source_wrapper),
                     concurrentAssetLane='outputs/ru-assets-parallel-20261026')
        state.pop('finishedAt', None)
        state.pop('reason', None)
    state['gitOwner'] = git_coordinator
    atomic_json(path, state)
    brief, kind, seen = first_brief, 'work', set()
    if resume:
        kind = (state['phases'][-1].get('result') or {}).get('nextKind', 'work')
        for old in state['phases']:
            seen.update(tuple(x) for x in old.get('evidenceFingerprints', []))
    try:
        while True:
            validate_model(MODEL, EFFORT, PROVIDER)
            assert digest(codex) == codex_hash, 'CLI binary changed; reconcile before another phase.'
            assert digest(contract) == contract_hash and digest(wrapper) == wrapper_hash and digest(support) == support_hash
            assert brief.is_file() and 0 < brief.stat().st_size <= 16384
            phase = directory / f'{len(state["phases"])+1:04d}-{kind}'
            phase.mkdir()
            shutil.copyfile(brief, phase / 'brief.md')
            result_path = phase / 'result.json'
            git_rule = ('Parent alone owns Git/index/HEAD for this dispatch; NO Git/index/branch mutations by this worker.'
                        if git_coordinator == 'parent' else 'Technical lane alone owns Git commits;')
            editing_role = ('You own only the authorized technical file edits; parent integrates verified artifacts. Parent commits are expected, not an index-ownership blocker for this no-Git worker.'
                            if git_coordinator == 'parent' else 'The parent only monitors and accounts; you own canonical edits/index in this phase.')
            prompt = (
                f'Continue the owner-authorized serial Russian localization. Read {contract}, '
                f'then the bounded assignment {phase / "brief.md"}. This is a fresh context; '
                'do not load parent/previous CLI conversation history. One active technical CLI in this lane; '
                'the owner explicitly allows the parallel asset-translation CLI; never stop it or block on its existence. '
                f'{git_rule} '
                'Never stage or modify localization/ru-assets/ or its job directory. '
                'Do not spawn agents or nested model/CLI jobs. The selected model is explicitly '
                'gpt-6.1-sol/high/OpenAI; NEVER Astra or fallback. '
                f'This phase kind is {kind}. '
                'Work phases are text-only: prepare/repair/build/capture/restore, never open images. '
                'Visual-review phases are review-only: inspect at most 1–2 pinned originals, '
                'write their real results and short handoff, then finish immediately. '
                f'Write the required phase result JSON to {result_path}. '
                'For continuation, write a concise next brief inside this phase directory and '
                'set nextKind to work or visual-review. Sequential fresh continuations and '
                'independent reviewer contexts are already authorized; do not stop for the '
                'former single-session restriction. Preserve real source/renderer/editorial gates. '
                'Make substantive progress; do not repeat unchanged status or add a framework. '
                f'{editing_role} '
                'Do not modify the serial runner, its frozen contract/wrapper, sibling phases, '
                'or operational job/log files. You may write your own result/next brief and '
                'the project files within this assignment. No site publication/deployment.'
            )
            (phase / 'prompt.txt').write_text(prompt + '\n')
            command = [str(codex), 'exec', '--ignore-user-config', '--model', MODEL,
                       '-c', 'model_provider="openai"', '-c', 'model_reasoning_effort="high"',
                       '-c', 'approval_policy="never"', '--sandbox', 'danger-full-access',
                       '--disable', 'multi_agent', '--cd', str(ROOT), '--json',
                       '--output-last-message', str(phase / 'last-message.txt'), prompt]
            if kind == 'visual-review':
                command = [sys.executable, '-B', str(wrapper), '--attempt', str(phase / 'review-attempt'), '--', *command]
                events = phase / 'review-attempt/stdout.log'
            else:
                events = phase / 'events.jsonl'
            record = {'number': len(state['phases']) + 1, 'kind': kind, 'directory': str(phase),
                      'startedAt': now(), 'briefSha256': digest(phase / 'brief.md'),
                      'status': 'launching', 'command': command}
            state['phases'].append(record)
            atomic_json(path, state)
            with (phase / 'events.jsonl').open('w') as out, (phase / 'stderr.log').open('w') as err:
                child = subprocess.Popen(command, cwd=ROOT, stdout=out, stderr=err)
                record.update(status='running', pid=child.pid)
                atomic_json(path, state)
                child.wait()
            record.update(exitCode=child.returncode, finishedAt=now(), status='process-exited')
            usage = []
            transport_errors = []
            if events.exists():
                for line in events.read_text().splitlines():
                    try:
                        item = json.loads(line)
                    except json.JSONDecodeError:
                        continue
                    if item.get('type') == 'thread.started':
                        record['threadId'] = item.get('thread_id')
                    if item.get('type') == 'turn.completed':
                        usage.append(item.get('usage'))
                    if item.get('type') in ['error', 'turn.failed']:
                        message = json.dumps(item).lower()
                        if any(token in message for token in ['408', 'body-read', 'broken pipe', 'disconnected', 'capacity', 'deadline']):
                            transport_errors.append(item)
            record['rawTurnUsage'] = usage
            if transport_errors:
                record['transportErrors'] = transport_errors
            if len(usage) == 1:
                record['measuredUsage'] = {**usage[0], 'total_tokens': usage[0]['input_tokens'] + usage[0]['output_tokens']}
            atomic_json(path, state)
            if kind == 'visual-review' and transport_errors:
                state.update(status='blocked-transport', reason='Review transport failure recorded. Preserve any completed result and reconcile before another submission.')
                break
            if child.returncode != 0:
                state.update(status='held-process-failure', reason='No automatic retry. Reconcile this exact phase/process and any unknown or transport outcome.')
                break
            assert result_path.is_file(), 'Worker exited without required phase result; reconcile before resubmission.'
            result = json.loads(result_path.read_text())
            assert result['outcome'] in ['continue', 'complete', 'needs-owner', 'blocked-transport']
            record['result'] = result
            if result['outcome'] != 'continue':
                if result['outcome'] == 'complete':
                    checkpoint = json.loads((ROOT / 'CHECKPOINT.json').read_text())
                    assert checkpoint.get('delivery', {}).get('localizationComplete') is True, 'Completion conflicts with canonical checkpoint.'
                state.update(status=result['outcome'], reason=result['summary'])
                break
            current, auxiliary = evidence_files(ROOT, directory, result['evidence'])
            record.update(evidenceFingerprints=sorted(current), auxiliaryEvidence=sorted(auxiliary))
            assert current - seen, 'No new substantive evidence; hold instead of launching an unchanged loop.'
            seen.update(current)
            next_brief = Path(result['nextBrief']).resolve()
            assert phase in next_brief.parents and next_brief.is_file()
            assert result['nextKind'] in ['work', 'visual-review']
            record['status'] = 'phase-complete'
            brief, kind = next_brief, result['nextKind']
            atomic_json(path, state)
        state['finishedAt'] = now()
        atomic_json(path, state)
    except BaseException as error:
        state.update(status='held-supervisor-error', reason=f'{type(error).__name__}: {error}', finishedAt=now())
        atomic_json(path, state)
        raise
    finally:
        if lock.exists() and json.loads(lock.read_text()).get('pid') == os.getpid():
            lock.unlink()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', type=Path)
    parser.add_argument('--brief', type=Path)
    parser.add_argument('--self-check', action='store_true')
    parser.add_argument('--resume', action='store_true')
    parser.add_argument('--reconcile-capacity', type=Path)
    parser.add_argument('--reconcile-interruption', type=Path)
    parser.add_argument('--git-coordinator', choices=('technical', 'parent'), default='technical')
    args = parser.parse_args()
    if args.self_check:
        validate_model(MODEL, EFFORT, PROVIDER)
        for forbidden in ['gpt-6-astra', 'GPT-6-ASTRA', 'astra', 'future-astra-alias']:
            try:
                validate_model(forbidden, EFFORT, PROVIDER)
            except ValueError:
                continue
            raise AssertionError('Prohibited model passed the pre-request guard')
        print('Permitted-model positive control and Astra rejection controls passed without model requests.')
    else:
        assert args.run and args.brief
        assert not (args.reconcile_capacity and args.reconcile_interruption), 'Choose the exact reconciliation path.'
        run(args.run.resolve(), args.brief.resolve(), resume=args.resume,
            reconciliation=args.reconcile_capacity or args.reconcile_interruption,
            git_coordinator=args.git_coordinator)
