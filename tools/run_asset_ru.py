#!/usr/bin/env python3
"""Resume saved Russian drafts in bounded fresh CLI phases, alongside technical QA."""
import argparse
import datetime
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys

from cli_job_support import (MODEL, EFFORT, PROVIDER, validate_model, digest,
                             assert_stopped, cli_events, asset_snapshot, asset_progress,
                             cli_turn_succeeded, known_capacity_failure)

ROOT = Path('/Users/antonkrutov/Desktop/Forest')


def now():
    return datetime.datetime.now(datetime.timezone.utc).isoformat()


def save(path, data):
    temporary = path.with_suffix('.pending')
    temporary.write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n')
    temporary.replace(path)


def validate_capacity_restart(directory, state, receipt_path, snapshot):
    """One explicit reconciled restart, never an automatic failed-request retry."""
    receipt_path = receipt_path.resolve()
    if directory not in receipt_path.parents:
        raise ValueError('Reconciliation receipt must belong to this asset job')
    receipt = json.loads(receipt_path.read_text())
    last = state['phases'][-1]
    if not known_capacity_failure(last.get('errors', [])):
        raise ValueError('Only the exact reconciled capacity failure is eligible; unknown transport outcomes remain held')
    if last.get('exitCode') != 1 or receipt.get('failedPhase') != last['number'] or receipt.get('failedThreadId') != last.get('threadId'):
        raise ValueError('Reconciliation identifies a different failed request')
    if receipt.get('jobSha256') != digest(directory / 'job.json'):
        raise ValueError('Job changed since reconciliation')
    if receipt.get('overlaySha256') != snapshot['overlaySha256'] or receipt.get('inputPinsSha256') != digest(directory / 'input-pins.json'):
        raise ValueError('Inputs or recovered overlay changed since reconciliation')
    before_path = Path(receipt['beforeSnapshot']).resolve()
    if directory not in before_path.parents or digest(before_path) != receipt.get('beforeSnapshotSha256'):
        raise ValueError('Invalid pre-recovery snapshot')
    before = json.loads(before_path.read_text())
    if any(snapshot['targetHashes'].get(ident) != value for ident, value in before['targetHashes'].items()):
        raise ValueError('Recovery changed or lost previously saved targets')
    if receipt.get('ownerInstruction') != 'Repair and continue both authorized CLI lanes':
        raise ValueError('Explicit restart authorization is missing')
    return receipt


def validate_completed_restart(directory, state, receipt_path, snapshot):
    receipt_path = receipt_path.resolve()
    if directory not in receipt_path.parents:
        raise ValueError('Reconciliation receipt must belong to this asset job')
    receipt = json.loads(receipt_path.read_text())
    last = state['phases'][-1]
    thread, usage, errors = cli_events(Path(last['directory']) / 'events.jsonl')
    if not cli_turn_succeeded(last.get('exitCode'), usage, errors):
        raise ValueError('Successful turn completion is unverified')
    if receipt.get('kind') != 'completed-turn' or receipt.get('failedPhase') != last['number'] or receipt.get('failedThreadId') != thread:
        raise ValueError('Reconciliation identifies a different completed turn')
    if receipt.get('jobSha256') != digest(directory / 'job.json') or receipt.get('overlaySha256') != snapshot['overlaySha256']:
        raise ValueError('Completed turn artifacts changed since reconciliation')
    if receipt.get('inputPinsSha256') != digest(directory / 'input-pins.json'):
        raise ValueError('Pinned input declaration changed')
    if receipt.get('ownerInstruction') != 'Repair and continue both authorized CLI lanes':
        raise ValueError('Explicit continuation authorization is missing')
    before_path = Path(last['directory']) / 'before.json'
    if receipt.get('beforeSnapshotSha256') != digest(before_path) or not asset_progress(json.loads(before_path.read_text()), snapshot):
        raise ValueError('Completed turn has no verified saved progress')
    result_path = Path(last['directory']) / 'result.json'
    if receipt.get('completedResultSha256') != digest(result_path):
        raise ValueError('Completed result changed since reconciliation')
    result = json.loads(result_path.read_text())
    if result.get('outcome') != 'continue':
        raise ValueError('Completed turn does not request continuation')
    return receipt, result


def run(directory, reconciliation=None):
    directory = directory.resolve()
    validate_model(MODEL, EFFORT, PROVIDER)
    state_path = directory / 'job.json'
    state = json.loads(state_path.read_text())
    if state['status'] not in ('prepared', 'finished', 'held-process-or-transport-failure'):
        raise ValueError('Only a reconciled partial or known capacity-held asset job may continue.')
    if state['status'] == 'held-process-or-transport-failure' and reconciliation is None:
        raise ValueError('Capacity-held restart needs an explicit reconciled receipt; no automatic retry.')
    config = state.get('localeConfig')
    if state['status'] == 'prepared':
        assert config and all(config.get(k) for k in ('locale', 'language', 'assetDirectory')), 'Prepared locale configuration is required.'
    config = config or {'locale': 'ru', 'language': 'Russian', 'assetDirectory': 'localization/ru-assets'}
    locale, language, asset_directory = (config[k] for k in ('locale', 'language', 'assetDirectory'))
    def snapshot_now():
        return asset_snapshot(ROOT, directory, asset_directory=asset_directory, locale=locale)
    for pid in (state.get('supervisorPid'), state.get('pid')):
        assert_stopped(pid, directory)
    registry = json.loads((Path.home() / '.codex/models_cache.json').read_text())
    if not any(m.get('slug') == MODEL for m in registry['models']):
        raise ValueError('Exact permitted model is unavailable')
    snapshot = snapshot_now()
    completed_result = None
    if reconciliation is not None and state['phases'][-1].get('exitCode') == 0:
        receipt, completed_result = validate_completed_restart(directory, state, reconciliation, snapshot)
    else:
        receipt = validate_capacity_restart(directory, state, reconciliation, snapshot) if reconciliation is not None else None
    lock = directory / 'queue.lock'
    with lock.open('x') as stream:
        json.dump({'pid': os.getpid(), 'startedAt': now()}, stream)
    try:
        history = directory / 'resume-history' / now().replace(':', '-')
        history.mkdir(parents=True)
        for name in ('job.json', 'result.json', 'progress.json', 'continuation.md', 'launch.py'):
            if (directory / name).exists():
                shutil.copyfile(directory / name, history / name)
        if not state.get('phases'):
            state['phases'] = [] if state['status'] == 'prepared' else [{**state, 'number': 1, 'kind': 'translation',
                                'status': 'partial-complete', 'directory': str(directory)}]
        if completed_result is not None:
            state['phases'][-1].update(status='phase-complete', result=completed_result,
                parentReconciliation={'receipt': str(reconciliation.resolve()), 'sha256': digest(reconciliation)})
        state.setdefault('resumptions', []).append({'resumedAt': now(), 'history': str(history),
            'reason': 'Owner instructed repair both lanes; continue existing saved draft automatically.',
            'capacityReconciliation': {'path': str(reconciliation.resolve()), 'sha256': digest(reconciliation),
                                       'failedPhase': receipt['failedPhase']} if receipt else None})
        state.update(status='running', supervisorPid=os.getpid(), freshSessionsWithoutInheritedHistory=True,
                     usageScope='measuredUsage sums phases with complete CLI usage; unavailable phases are excluded, not zero. Never add this subtotal to phase totals.')
        state.pop('finishedAt', None)
        state.pop('exitCode', None)
        state.pop('reason', None)
        cli = Path(shutil.which('codex')).resolve()
        pinned = {p: digest(p) for p in (cli, directory / 'supervise.py',
                  directory / 'cli_job_support.py', directory / 'contract.md')}
        save(state_path, state)
        while True:
            validate_model(MODEL, EFFORT, PROVIDER)
            for path, expected in pinned.items():
                if digest(path) != expected:
                    raise ValueError(f'Execution dependency changed: {path}')
            before = snapshot_now()
            phase = directory / f'{len(state["phases"]) + 1:04d}-translation'
            phase.mkdir()
            save(phase / 'before.json', before)
            brief = (
                f'# Continue the existing {language} asset draft ({locale})\n\n'
                f'Read {directory / "contract.md"}, the current continuation.md and compact progress.json. '
                'This is a fresh context with no inherited or resumed model history. Do not read prior CLI histories. '
                'Exact gpt-6.1-sol/high/OpenAI; verify actual argv before localization inputs; NEVER Astra/fallback. '
                'No agents or nested model/CLI jobs. Parallel technical work is authorized; never stop it. '
                'No Git/index mutations or writes outside the two assigned asset directories.\n\n'
                f'Verified before this phase: {before["authoredIds"]}/{before["sourceIds"]} saved target IDs, '
                f'{before["heldIds"]} held. Next unvisited: {json.dumps(before["next"], ensure_ascii=False)}. '
                'Reuse every existing valid batch. Load the complete compact approved glossary once and '
                'translate coherent source conversations with actual conditions, actors and links. '
                f'Author {language} ({locale}) directly, edit immediately and save batches frequently. '
                'Use existing corpus.py build and applicable poetry validation, never generate wording with scripts.\n\n'
                'Moving a prior unsupported target to a hold requires an immutable source-bound retired-targets.json receipt: '
                'id, sourceSha256, preserved target and targetSha256, objective reason, own-lane evidence path and evidenceSha256. '
                'Keep the old text/evidence; an unexplained missing target is never accepted.\n\n'
                'Process a bounded substantive batch (normally 300–600 fields, fewer for long or difficult scenes), '
                'then finish BEFORE context exhaustion. This is a batch boundary, not stopping the overall assignment: '
                'the parent supervisor automatically launches the next fresh phase after verified saved progress. '
                'Context size is not a needs-owner reason. Preserve specific ambiguity holds; continue independent scenes. '
                'When no unvisited scenes remain, resolve held units with source evidence and approved glossary; '
                'report genuine unresolved source/owner decisions precisely rather than guessing.\n\n'
                f'Before exit rebuild and validate the overlay, update root continuation.md and progress.json, '
                f'then write {phase / "result.json"} with outcome continue|draft-complete|needs-owner|blocked-transport, '
                'summary, authoredIds, heldIds, evidence paths and next action. Only use draft-complete when every '
                'pinned candidate has a real target and no holds; this is not whole-game/editorial/runtime acceptance. '
                'Do not edit supervisor.py/supervise.py, cli_job_support.py, contract.md, request.md, input-pins.json, '
                'job.json, queue.lock or supervisor-owned phase before/after/events files.\n')
            (phase / 'brief.md').write_text(brief)
            prompt = f'Execute {phase / "brief.md"}. The owner authorizes parallel {language} ({locale}) asset drafting and automatic sequential fresh continuation. Preserve saved translations; no inherited history, nested jobs, Git or shared-file writes.'
            command = [str(cli), 'exec', '--ignore-user-config', '--model', MODEL,
                '-c', 'model_provider="openai"', '-c', 'model_reasoning_effort="high"',
                '-c', 'approval_policy="never"', '--sandbox', 'danger-full-access',
                '--disable', 'multi_agent', '--cd', str(ROOT), '--json',
                '--output-last-message', str(phase / 'last-message.txt'), prompt]
            record = {'number': len(state['phases']) + 1, 'kind': 'translation', 'directory': str(phase),
                      'status': 'launching', 'startedAt': now(), 'command': command,
                      'model': MODEL, 'reasoning': EFFORT, 'provider': PROVIDER, 'inheritedHistory': False}
            state['phases'].append(record)
            save(state_path, state)
            with (phase / 'events.jsonl').open('w') as out, (phase / 'stderr.log').open('w') as err:
                child = subprocess.Popen(command, cwd=ROOT, stdin=subprocess.DEVNULL, stdout=out, stderr=err)
                record.update(pid=child.pid, status='running')
                state['pid'] = child.pid
                save(state_path, state)
                rc = child.wait()
            thread, usage, errors = cli_events(phase / 'events.jsonl')
            record.update(status='process-exited', exitCode=rc, finishedAt=now(), threadId=thread,
                          measuredUsage=usage, errors=errors)
            measured = [p['measuredUsage'] for p in state['phases'] if p.get('measuredUsage')]
            state['measuredUsage'] = {k: sum(u.get(k, 0) for u in measured) for k in
                ('input_tokens', 'cached_input_tokens', 'output_tokens', 'reasoning_output_tokens', 'total_tokens')}
            state['unavailableUsagePhases'] = [p['number'] for p in state['phases'] if not p.get('measuredUsage')]
            save(state_path, state)
            if not cli_turn_succeeded(rc, usage, errors):
                state.update(status='held-process-or-transport-failure', reason='Reconcile exact request outcome before retry; no automatic failed-request retry.')
                break
            after = snapshot_now()
            save(phase / 'after.json', after)
            result_path = phase / 'result.json'
            if not result_path.is_file():
                raise ValueError('Worker ended without phase result; saved artifacts preserved for reconciliation.')
            result = json.loads(result_path.read_text())
            outcome = result.get('outcome')
            record['result'] = result
            if outcome not in ('continue', 'draft-complete', 'needs-owner', 'blocked-transport'):
                raise ValueError(f'Unknown continuation outcome: {outcome}')
            progress = asset_progress(before, after)
            if outcome == 'draft-complete':
                if after['remainingIds'] or after['heldIds']:
                    raise ValueError('Draft completion contradicts stored target coverage')
                state.update(status='draft-complete', reason='Pinned dialogue draft complete; editorial and technical acceptance remain separate.')
                break
            if outcome != 'continue':
                state.update(status=outcome, reason=result.get('summary'))
                break
            if not progress:
                raise ValueError('No increase in saved translation/resolved or visited IDs; do not loop unchanged.')
            record.update(status='phase-complete', authoredIds=after['authoredIds'], heldIds=after['heldIds'])
            save(state_path, state)
        state['finishedAt'] = now()
        save(state_path, state)
    except BaseException as error:
        state.update(status='held-supervisor-error', reason=f'{type(error).__name__}: {error}', finishedAt=now())
        save(state_path, state)
        raise
    finally:
        if lock.exists() and json.loads(lock.read_text()).get('pid') == os.getpid():
            lock.unlink()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', required=True, type=Path)
    parser.add_argument('--reconcile-capacity', type=Path)
    parser.add_argument('--reconcile-completed', type=Path)
    args = parser.parse_args()
    assert not (args.reconcile_capacity and args.reconcile_completed), 'Choose one reconciliation path'
    run(args.run.resolve(), reconciliation=args.reconcile_capacity or args.reconcile_completed)
