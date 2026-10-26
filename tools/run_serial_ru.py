#!/usr/bin/env python3
"""Run the owner-authorized Russian localization in one serial CLI stream."""
import argparse
import datetime
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys

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


def run(directory, first_brief):
    validate_model(MODEL, EFFORT, PROVIDER)
    assert directory.is_dir() and not (directory / 'job.json').exists()
    registry = json.loads((Path.home() / '.codex/models_cache.json').read_text())
    assert any(x.get('slug') == MODEL for x in registry['models'])
    lock = directory / 'queue.lock'
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
    state = {'schemaVersion': 1, 'task': 'The Forest of Love 0.45 Russian localization',
             'status': 'running', 'startedAt': now(), 'supervisorPid': os.getpid(),
             'model': MODEL, 'reasoning': EFFORT, 'provider': PROVIDER,
             'parallelism': 1, 'freshSessionsWithoutInheritedHistory': True,
             'contractSha256': contract_hash, 'reviewWrapperSha256': wrapper_hash,
             'reviewWrapperSource': str(source_wrapper), 'phases': []}
    path = directory / 'job.json'
    atomic_json(path, state)
    brief, kind, seen = first_brief, 'work', set()
    try:
        while True:
            validate_model(MODEL, EFFORT, PROVIDER)
            assert digest(codex) == codex_hash, 'CLI binary changed; reconcile before another phase.'
            assert digest(contract) == contract_hash and digest(wrapper) == wrapper_hash
            assert brief.is_file() and 0 < brief.stat().st_size <= 16384
            phase = directory / f'{len(state["phases"])+1:04d}-{kind}'
            phase.mkdir()
            shutil.copyfile(brief, phase / 'brief.md')
            result_path = phase / 'result.json'
            prompt = (
                f'Continue the owner-authorized serial Russian localization. Read {contract}, '
                f'then the bounded assignment {phase / "brief.md"}. This is a fresh context; '
                'do not load parent/previous CLI conversation history. One active CLI only; '
                'do not spawn agents or model/CLI jobs. The selected model is explicitly '
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
                'The parent only monitors and accounts; you own canonical edits/index in this phase. '
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
                for line in events.open():
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
            current = set()
            for name in result['evidence']:
                evidence = (ROOT / name).resolve()
                assert ROOT in evidence.parents and directory not in evidence.parents
                assert evidence.is_file()
                current.add((str(evidence), digest(evidence)))
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
        state.update(status='held-supervisor-error', reason=str(error), finishedAt=now())
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
        run(args.run.resolve(), args.brief.resolve())
