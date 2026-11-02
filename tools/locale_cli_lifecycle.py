"""Own-task CLI lifecycle: process completion never implies editorial acceptance.

Uses standard-library code only. Frozen beside a manifest before activation;
does not edit live launchers, source, wording, games, or Git. Existing workers
are adopted first. Only verified closed unfinished author turns may continue.
"""
import argparse
import datetime
import fcntl
import hashlib
import json
import os
from pathlib import Path
import subprocess
import time

from cli_job_support import cli_events, cli_turn_succeeded, digest, known_capacity_failure, validate_model


def read(path):
    return json.loads(Path(path).read_text())


def save(path, value):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_suffix(path.suffix + '.pending')
    temporary.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')
    temporary.replace(path)


def now():
    return datetime.datetime.now(datetime.timezone.utc).isoformat()


def latest_usage(path):
    # Same bounded telemetry reader as locale_efficiency.latest_usage.
    with Path(path).open('rb') as stream:
        stream.seek(0, 2)
        end = stream.tell()
        stream.seek(max(0, end - 2097152))
        data = stream.read()
    for line in reversed(data.splitlines()):
        try:
            event = json.loads(line)
        except (json.JSONDecodeError, UnicodeDecodeError):
            continue
        if event.get('type') == 'event_msg' and event.get('payload', {}).get('type') == 'token_count':
            usage = (event['payload'].get('info') or {}).get('total_token_usage')
            if usage:
                return usage
    raise ValueError('Exact session usage unavailable; do not invent zero')


def current_turn(path, offset):
    selected = actual = started = None
    with Path(path).open('rb') as stream:
        stream.seek(offset)
        for line in stream:
            try:
                event = json.loads(line)
            except ValueError:
                continue
            payload = event.get('payload', {})
            if event.get('type') == 'event_msg' and payload.get('type') == 'thread_settings_applied':
                settings = payload['thread_settings']
                selected = (settings.get('model'), settings.get('reasoning_effort'), settings.get('model_provider_id'))
                validate_model(*selected)
            if event.get('type') == 'event_msg' and payload.get('type') == 'task_started':
                started = payload.get('turn_id')
            if event.get('type') == 'turn_context':
                actual = {'model': payload.get('model'), 'effort': payload.get('effort')}
                validate_model(actual['model'], actual['effort'], 'openai')
    if actual or (selected and started):
        return actual or {'model': selected[0], 'effort': selected[1]}
    return None


def inspect_language(root, lane, source, preserved):
    path = Path(root) / lane['language']
    data = read(path)
    if data.get('locale') != lane['locale']:
        raise ValueError('Explicit locale does not match language data')
    translations = data['translations']
    if translations.keys() != source.keys():
        raise ValueError('Source inventory identity changed')
    for ident, value in translations.items():
        if value['source'] != source[ident]:
            raise ValueError('Source wording changed: ' + ident)
        if ident in preserved and (value['target'] != value['source'] or
                                  hashlib.sha256(value['source'].encode()).hexdigest() != preserved[ident]):
            raise ValueError('Protected value changed: ' + ident)
    remaining = [ident for ident, value in translations.items() if ident not in preserved and value['target'] is None]
    return {'sha256': digest(path), 'remaining': len(remaining),
            'ordinary': len(source) - len(preserved), 'protected': len(preserved)}


def wording_versions(root, lane, source, preserved, allow_pending=False):
    """Progress only: authored/read version evidence, never semantic acceptance."""
    versions = set()
    readings = []

    def visit(value):
        if isinstance(value, list):
            for item in value:
                visit(item)
        elif isinstance(value, dict):
            ident = value.get('id')
            if isinstance(ident, str) and ident in source and ident not in preserved:
                target = value.get('target')
                if isinstance(target, str) and value.get('source', source[ident]) == source[ident]:
                    versions.add((ident, hashlib.sha256(target.encode()).hexdigest()))
                rationale = value.get('rationale') or value.get('reason')
                if value.get('reviewed') is True and isinstance(rationale, str) and rationale.strip():
                    readings.append((ident, value.get('sourceSha256'), value.get('targetSha256'), rationale))
            translations = value.get('translations')
            if isinstance(translations, dict):
                for ident, item in translations.items():
                    if ident in source and ident not in preserved and isinstance(item, dict):
                        target = item.get('target')
                        if isinstance(target, str) and item.get('source') == source[ident]:
                            versions.add((ident, hashlib.sha256(target.encode()).hexdigest()))
            for key, item in value.items():
                if key not in ('translations', 'fontAssets'):
                    visit(item)

    files = {Path(root) / lane['language']}
    for prefix in lane['progressRoots']:
        directory = Path(root) / prefix
        if directory.exists():
            files.update(p for p in directory.rglob('*') if p.is_file() and p.suffix in ('.json', '.jsonl')
                         and p.name not in ('events.jsonl', 'task.json', 'submission.json', 'runtime-verification.json'))
    for path in files:
        if path.stat().st_size > 67108864:
            raise ValueError('Substantive evidence exceeds bounded reader; reconcile explicitly: ' + str(path))
        try:
            if path.suffix == '.jsonl':
                with path.open() as stream:
                    for line in stream:
                        if line.strip():
                            visit(json.loads(line))
            else:
                visit(read(path))
        except (json.JSONDecodeError, UnicodeDecodeError):
            if allow_pending:
                continue  # Live adoption baseline only; never acceptance or a closed-evidence check.
            raise ValueError('Closed substantive evidence is malformed: ' + str(path))
    read_versions = set()
    for ident, source_hash, target_hash, rationale in readings:
        if source_hash == hashlib.sha256(source[ident].encode()).hexdigest() and (ident, target_hash) in versions:
            binding = json.dumps([source_hash, target_hash, rationale], ensure_ascii=False).encode()
            read_versions.add(('@read:' + ident, hashlib.sha256(binding).hexdigest()))
    return sorted(versions | read_versions)


def classify(receipt, result, usage, errors, language):
    """Machine routing only. Ready means parent verification, never clean review."""
    successful = cli_turn_succeeded(receipt['exitCode'], usage, errors)
    if not successful:
        return 'capacity-backoff' if known_capacity_failure(errors) else 'needs-attention-unknown-cli-failure'
    if not isinstance(result, dict):
        return 'needs-attention-missing-result'
    if result.get('blocker') or result.get('blockers') or result.get('outcome') in ('needs-owner', 'needs-decision', 'blocked'):
        return 'held-real-blocker'
    status = str(result.get('status', '')).lower()
    next_task = result.get('nextTask') or {}
    ready = status in ('review-ready', 'ready-for-independent-review') or next_task.get('taskClass') == 'semantic-review'
    if ready:
        binding = result.get('language') or {}
        if language['remaining'] or binding.get('sha256') != language['sha256']:
            return 'needs-attention-invalid-ready-claim'
        return 'needs-parent-independent-review-verification'
    if status in ('incomplete', 'in-progress', 'incomplete-authoring'):
        return 'continue-own-authoring'
    return 'needs-attention-unclassified-result'


def process_identity(pid, phase, thread):
    result = subprocess.run(['ps', '-p', str(pid), '-o', 'pid=,stat=,lstart=,command='], capture_output=True, text=True)
    if result.returncode or not result.stdout.strip():
        return None
    row = result.stdout.strip()
    if row.split()[1].startswith('Z'):
        return None
    if str(phase) not in row or '--model gpt-6.1-sol' not in row or 'codex' not in row:
        raise ValueError('Live PID identity differs; never duplicate or terminate it')
    if 'exec resume' in row and thread not in row:
        raise ValueError('Resumed process is not the exact own thread')
    return row


def pending_commands(path):
    pending = set()
    with Path(path).open() as stream:
        for line in stream:
            try:
                event = json.loads(line)
            except ValueError:
                continue
            item = event.get('item', {})
            if item.get('type') in ('command_execution', 'mcp_tool_call'):
                if event.get('type') == 'item.started':
                    pending.add(item['id'])
                elif event.get('type') == 'item.completed':
                    pending.discard(item['id'])
    return sorted(pending)


def validate_identity(runtime):
    actual = runtime['actualRuntime']
    session = actual['session']
    validate_model(actual['turn']['model'], actual['turn']['effort'], session['model_provider'])
    if session.get('parent_thread_id') is not None or session['id'] != runtime['threadId']:
        raise ValueError('Inherited or foreign session is prohibited')


def prepare_next(root, cfg, lane, previous, language):
    root = Path(root)
    old = root / previous['phase']
    # The immutable owner assignment is outside the worker's allowed write prefixes.
    task = read(root / lane['assignmentTask'])
    for name, expected in task['job']['immutablePins'].items():
        if digest(root / name) != expected:
            raise ValueError('Pinned prerequisite changed: ' + name)
    number = lane.get('sequence', 0) + 1
    phase = root / cfg['phaseRoot'] / lane['locale'] / ('author-auto-%04d' % number)
    phase.mkdir(parents=True, exist_ok=False)
    save(phase / 'language-before.json', read(root / lane['language']))
    pins = dict(task['job']['immutablePins'])
    pins[str((phase / 'language-before.json').relative_to(root))] = digest(phase / 'language-before.json')
    for name in ('result.json', 'process-exit.json', 'checkpoint.json'):
        if (old / name).exists():
            pins[str((old / name).relative_to(root))] = digest(old / name)
    relative = str(phase.relative_to(root))
    destinations = [lane['language'], relative,
                    cfg['editorialRoot'] + '/' + lane['locale'] + '/' + phase.name,
                    cfg['caseRoot'] + '/' + lane['locale'] + '/' + phase.name]
    task['job'].update(immutablePins=pins, initialLanguageSha256=language['sha256'], writePrefixes=destinations)
    task['task']['continuation'] = {'sameOwnThread': previous['threadId'], 'previousPhase': previous['phase'],
                                    'noInheritedParentOrFork': True, 'priorWholeAssignmentComplete': False}
    task['task']['expectedRuntime'] = {'model': 'gpt-6.1-sol', 'reasoning': 'high', 'provider': 'openai',
                                      'parentThreadId': None, 'resumedOwnTask': True}
    save(phase / 'task.json', task)
    (phase / 'brief.md').write_text(
        '# Continue the same finite locale assignment\n\n'
        'FIRST await this phase runtime-verification.json proving the NEW actual Sol/high/OpenAI turn after its '
        'saved metadata offset before further linguistic work. This is your same own bounded task history, '
        'never inherited coordinator history or a fork. No Astra/default/fallback, nested model/agent, Git, '
        'old queue, game/GUI/screenshot/installer/publication/deployment/server action.\n\n'
        'Read new task.json. Its writePrefixes supersede earlier destinations; all old phase/editorial/case '
        'files are immutable reusable inputs. Continue exact saved wording and real special-case decisions. '
        'Reuse already-read unchanged instructions/glossary; do not restart from an all-null initial snapshot '
        'or reopen accepted source/framework audits. Preserve all protected values and original source IDs.\n\n'
        'Advance the next substantial source/target/context family now. The remaining full assignment is '
        'complete special-case wording/solutions, all ordinary targets, one full primary audit, consolidated '
        'corrections/exact self-read and the immutable full parent independent packet. An ended CLI turn or '
        'large cumulative usage is not completion or a task budget. Use compact checkpoints and compaction. '
        'No default pass rows, inferred semantic acceptance or stopping at an ordinary batch. If a real '
        'source/owner/external blocker exists, record blocker precisely and finish independent useful work. '
        'A review-ready handoff needs exact final language/packet/evidence hashes; native and release remain '
        'unrun. Use explicit result.status incomplete, in-progress, or review-ready. Record actual '
        'current-attempt usage excluding the saved cumulative baseline.\n')
    return phase, number


class Supervisor:
    def __init__(self, root, cfg, output):
        self.root, self.cfg, self.output = Path(root), cfg, Path(output)
        validate_model(cfg['model'], cfg['reasoning'], cfg['provider'])
        locales = [lane['locale'] for lane in cfg['lanes']]
        if not locales or len(locales) != len(set(locales)) or len(locales) > cfg['streamCap']:
            raise ValueError('Explicit unique bounded locale selection required')
        self.source = {}
        for row in map(json.loads, (self.root / cfg['sourcePacket']).read_text().splitlines()):
            if row['id'] in self.source:
                raise ValueError('Duplicate source ID')
            self.source[row['id']] = row['source']
        self.preserved = read(self.root / cfg['preservation'])['baselinePreserved']
        self.children = {}

    def launch(self, lane, previous, language):
        runtime = read(self.root / previous['phase'] / 'runtime-verification.json')
        validate_identity(runtime)
        if process_identity(runtime['pid'], self.root / previous['phase'], runtime['threadId']):
            raise ValueError('Previous own worker still lives')
        if pending_commands(self.root / previous['phase'] / 'events.jsonl'):
            raise ValueError('Unknown prior tool outcome; reconcile before resubmission')
        # Look for any surviving same-thread CLI before preparing or submitting.
        for row in subprocess.check_output(['ps', '-axo', 'command='], text=True).splitlines():
            if row.startswith(self.cfg['cli'] + ' exec') and runtime['threadId'] in row:
                raise ValueError('Same-thread CLI already exists; preserve and reconcile')
        phase, number = prepare_next(self.root, self.cfg, lane, previous, language)
        session = Path(runtime['sessionMetadataPath'])
        baseline, offset = latest_usage(session), session.stat().st_size
        args = [self.cfg['cli'], 'exec', 'resume', '--ignore-user-config', '--model', 'gpt-6.1-sol',
                '-c', 'model_provider="openai"', '-c', 'model_reasoning_effort="high"',
                '-c', 'approval_policy="never"', '-c', 'sandbox_mode="danger-full-access"',
                '--disable', 'multi_agent', '--json', '--output-last-message', str(phase / 'last-message.txt'),
                runtime['threadId'], 'Continue the SAME authorized unfinished locale assignment. FIRST read ' +
                str(phase / 'brief.md') + ' and task.json, then await this phase runtime-verification.json. '
                'Only the same own task history; no inherited parent, fork, nested model, model switch, '
                'Git, game/GUI, publication or server action. Preserve all previous drafts.']
        save(phase / 'submission.json', {'argv': args, 'baselineUsage': baseline, 'metadataOffset': offset,
                                        'sameOwnThread': True, 'inheritedParentHistory': False, 'atUTC': now()})
        # Persist unknown-submission state BEFORE the single Popen boundary.
        lane.update(status='submission-pending-reconciliation', phase=str(phase.relative_to(self.root)), sequence=number)
        self.persist()
        with (phase / 'events.jsonl').open('x') as out, (phase / 'stderr.log').open('x') as err:
            child = subprocess.Popen(args, cwd=self.root, stdin=subprocess.DEVNULL, stdout=out, stderr=err, start_new_session=True)
        save(phase / 'launch.json', {'pid': child.pid, 'atUTC': now()})
        lane.update(pid=child.pid, threadId=runtime['threadId'], status='verifying-new-turn')
        self.children[lane['locale']] = (child, baseline, session)
        self.persist()
        deadline = time.monotonic() + 45
        actual = None
        while time.monotonic() < deadline:
            actual = current_turn(session, offset)
            if actual:
                break
            if child.poll() is not None:
                raise ValueError('New child exited before runtime verification; preserve it, no blind retry')
            time.sleep(.2)
        if actual != {'model': 'gpt-6.1-sol', 'effort': 'high'}:
            raise ValueError('Actual new model unverified; preserve child and withhold linguistic gate')
        argv = process_identity(child.pid, phase, runtime['threadId'])
        save(phase / 'runtime-verification.json', {'threadId': runtime['threadId'], 'pid': child.pid,
             'sessionMetadataPath': str(session), 'actualRuntime': {'session': runtime['actualRuntime']['session'], 'turn': actual},
             'actualArgvEvidence': argv, 'currentTurnMetadataAfterOffset': offset, 'baselineUsage': baseline,
             'resumedOwnTaskNoParentHistory': True})
        lane.update(status='running', runtimeVerified=True, atUTC=now())

    def persist(self):
        compact = [{key: value for key, value in lane.items() if key != 'wordingVersions'}
                   for lane in self.cfg['lanes']]
        save(self.output / 'status.json', {'atUTC': now(), 'lanes': compact,
             'streamCap': self.cfg['streamCap'], 'semanticAcceptanceGenerated': False})

    def tick(self, lane):
        if lane['status'] not in ('adopted-running', 'running', 'capacity-backoff', 'waiting-terminal-receipt'):
            return
        phase = self.root / lane['phase']
        runtime = read(phase / 'runtime-verification.json')
        validate_identity(runtime)
        owned = self.children.get(lane['locale'])
        if owned and owned[0].poll() is not None and not (phase / 'process-exit.json').exists():
            child, baseline, session = owned
            final = latest_usage(session)
            delta = {key: final[key] - baseline[key] for key in final}
            if any(value < 0 for value in delta.values()):
                raise ValueError('Nonmonotonic telemetry')
            save(phase / 'process-exit.json', {'exitCode': child.returncode, 'finishedAt': now(), 'usage': delta,
                 'baselineUsage': baseline, 'finalCumulativeUsage': final,
                 'telemetry': 'Nonoverlapping same-own-session delta; cache/reasoning subsets.'})
        alive = process_identity(runtime['pid'], phase, runtime['threadId'])
        if alive:
            lane.update(status='running', live=True)
            return
        lane['live'] = False
        if not (phase / 'process-exit.json').exists():
            lane['status'] = 'waiting-terminal-receipt'
            return  # Legacy parent owns exit accounting; process disappearance alone is insufficient.
        receipt = read(phase / 'process-exit.json')
        result = read(phase / 'result.json') if (phase / 'result.json').exists() else None
        _, usage, errors = cli_events(phase / 'events.jsonl')
        language = inspect_language(self.root, lane, self.source, self.preserved)
        action = classify(receipt, result, usage, errors, language)
        if lane.get('accountedPhase') != lane['phase']:
            save(self.output / 'outcomes' / (lane['locale'] + '-' + phase.name + '.json'),
                 {'locale': lane['locale'], 'phase': lane['phase'], 'action': action, 'terminalReceipt': receipt,
                  'model': 'gpt-6.1-sol', 'reasoning': 'high', 'provider': 'openai', 'atUTC': now()})
            versions = wording_versions(self.root, lane, self.source, self.preserved)
            new_versions = set(map(tuple, versions)) - set(map(tuple, lane.get('wordingVersions', [])))
            if action != 'capacity-backoff':
                lane['noProgressTurns'] = 0 if new_versions else lane.get('noProgressTurns', 0) + 1
            lane.update(accountedPhase=lane['phase'], wordingVersions=versions, lastAction=action,
                        lastAttemptUsage=receipt.get('usage'), atUTC=now())
            progress_path = self.output / 'progress' / (lane['locale'] + '-' + phase.name + '.json')
            save(progress_path, {'versions': versions, 'newVersions': len(new_versions),
                                 'semanticAcceptance': False})
            lane.update(wordingVersionsPath=str(progress_path.relative_to(self.root)),
                        substantiveVersionCount=len(versions), lastNewSubstantiveVersions=len(new_versions))
            if action == 'capacity-backoff':
                lane['capacityFailures'] = lane.get('capacityFailures', 0) + 1
                lane['retryAfterEpoch'] = time.time() + self.cfg['capacityBackoffSeconds'] * lane['capacityFailures']
            else:
                lane['capacityFailures'] = 0
        if action == 'capacity-backoff':
            if lane['capacityFailures'] > self.cfg['maxCapacityRetries']:
                lane['status'] = 'held-capacity-retries-exhausted'
                return
            lane['status'] = 'capacity-backoff'
            if time.time() < lane['retryAfterEpoch']:
                return
        elif action != 'continue-own-authoring':
            lane['status'] = action
            return
        elif lane['noProgressTurns'] >= self.cfg['maxNoProgressTurns']:
            lane['status'] = 'held-no-substantive-progress'
            return
        previous = dict(lane)
        self.launch(lane, previous, language)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('manifest', type=Path)
    args = parser.parse_args()
    cfg = read(args.manifest)
    root = Path(cfg['root']).resolve()
    output = root / cfg['output']
    output.mkdir(parents=True, exist_ok=True)
    with (output / 'controller.lock').open('a') as lock:
        fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
        for name, expected in cfg['immutablePins'].items():
            if digest(root / name) != expected:
                raise ValueError('Frozen controller dependency changed: ' + name)
        if (output / 'status.json').exists():
            raise ValueError('Existing lifecycle state needs explicit reconciliation, not duplicate dispatch')
        supervisor = Supervisor(root, cfg, output)
        live_count = 0
        for lane in cfg['lanes']:
            runtime = read(root / lane['phase'] / 'runtime-verification.json')
            validate_identity(runtime)
            alive = bool(process_identity(runtime['pid'], root / lane['phase'], runtime['threadId']))
            if not alive and not (root / lane['phase'] / 'process-exit.json').exists():
                raise ValueError('Closed adoption requires a verified original terminal receipt')
            live_count += int(alive)
            versions = wording_versions(root, lane, supervisor.source, supervisor.preserved, allow_pending=True)
            progress_path = output / 'progress' / (lane['locale'] + '-adoption.json')
            save(progress_path, {'versions': versions, 'semanticAcceptance': False})
            lane.update(status='adopted-running', live=alive, pid=runtime['pid'], threadId=runtime['threadId'],
                        wordingVersions=versions, substantiveVersionCount=len(versions),
                        wordingVersionsPath=str(progress_path.relative_to(root)), runtimeVerified=True)
        save(output / 'controller.json', {'pid': os.getpid(), 'manifest': str(args.manifest.resolve()),
             'adoptedAtUTC': now(), 'modelRequestsAtAdoption': 0, 'liveWorkersAtAdoption': live_count,
             'selectedOwnAssignments': len(cfg['lanes'])})
        supervisor.persist()
        while True:
            for lane in cfg['lanes']:
                try:
                    supervisor.tick(lane)
                except Exception as error:
                    lane.update(status='needs-attention-preserve-process-and-state', error=str(error), atUTC=now())
                supervisor.persist()
            active = ('adopted-running', 'running', 'capacity-backoff', 'waiting-terminal-receipt')
            if not any(lane['status'] in active for lane in cfg['lanes']):
                break
            time.sleep(cfg.get('pollSeconds', 5))
        save(output / 'finished.json', {'atUTC': now(), 'allAuthorTurnsTerminalOrHeld': True,
             'editorialAcceptance': False, 'nextStage': 'Parent verifies each ready independent-review handoff.'})


if __name__ == '__main__':
    main()
