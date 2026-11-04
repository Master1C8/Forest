"""Continue only the same independent reviewer; never author or accept translations.

Exact current-version reviewer rows survive turn endings. Missing/context-unresolved
IDs remain work. Uses the shared frozen process/model/submission/usage guards.
"""
import argparse
import fcntl
import hashlib
import json
import os
from pathlib import Path
import time

from locale_cli_lifecycle import (Supervisor, cli_events, cli_turn_succeeded, current_turn,
    digest, inspect_language, known_capacity_failure, latest_usage, now, pending_commands,
    process_identity, read, save, validate_identity)


def checked_rows(path, packet, thread):
    rows = {}
    with Path(path).open() as stream:
        for line in stream:
            if not line.strip():
                continue
            row = json.loads(line)
            ident = row.get('id')
            if ident not in packet:
                raise ValueError('Unknown primary review ID')
            original = packet[ident]
            if any(row.get(key) != original[key] for key in ('sourceSha256', 'targetSha256')):
                raise ValueError('Stale review version: ' + ident)
            if row.get('reviewerThreadId', thread) != thread:
                raise ValueError('Foreign reviewer row')
            for key, expected in [('model', 'gpt-6.1-sol'), ('reasoning', 'high'), ('provider', 'openai')]:
                if key in row and row[key] != expected:
                    raise ValueError('Foreign reviewer model metadata')
            if row.get('reviewed') is False or row.get('verdict') not in ('pass', 'finding'):
                continue  # Including needs-context; not a pass, not retained as complete.
            rationale = row.get('rationale') or row.get('fidelityRationale') or row.get('reason')
            if not isinstance(rationale, str) or not rationale.strip():
                raise ValueError('No actual reviewer rationale: ' + ident)
            if ident in rows and rows[ident] != row:
                raise ValueError('Conflicting duplicate review ID')
            rows[ident] = row
    return rows


def merge_review_result(root, phase, packet, thread, retained, new_rows, result):
    """Accept only explicit current-version reviewer supersession, never silent loss."""
    combined = dict(retained)
    combined.update(new_rows)
    effective = result.get('effectiveFullReviews')
    supersession = result.get('retainedPassSupersession')
    if not effective and not supersession:
        return combined
    if not effective or not supersession:
        raise ValueError('Effective review needs explicit retained supersession evidence')

    def owned_path(value):
        name = value.get('path') if isinstance(value, dict) else value
        path = (Path(root) / name).resolve()
        if not path.is_relative_to(Path(phase).resolve()):
            raise ValueError('Supersession must be authored in the closed own review phase')
        if isinstance(value, dict) and value.get('sha256') != digest(path):
            raise ValueError('Supersession evidence hash changed')
        return path

    revised = checked_rows(owned_path(supersession), packet, thread)
    if not revised or any(ident not in retained or ident in new_rows for ident in revised):
        raise ValueError('Supersession does not name exact retained versions')
    combined.update(revised)
    final = checked_rows(owned_path(effective), packet, thread)
    if set(final) != set(combined):
        raise ValueError('Effective review invents or drops primary judgments')
    fields = ('sourceSha256', 'targetSha256', 'verdict', 'rationale', 'fidelityRationale')
    for ident in final:
        if any(final[ident].get(key) != combined[ident].get(key) for key in fields):
            raise ValueError('Unexplained effective review change: ' + ident)
    return final


class ReviewSupervisor(Supervisor):
    def __init__(self, root, cfg, output):
        super().__init__(root, cfg, output)
        self.packets, self.known = {}, {}
        for lane in cfg['lanes']:
            path = self.root / lane['fullReviewPacket']
            if digest(path) != lane['fullReviewPacketSha256']:
                raise ValueError('Full review packet changed')
            packet = {}
            language = read(self.root / lane['language'])['translations']
            supplemental = {}
            declared = lane.get('supplementalReviewPacket')
            if declared:
                extra_path = self.root / declared['path']
                if digest(extra_path) != declared['sha256']:
                    raise ValueError('Supplemental review packet changed')
                for row in map(json.loads, extra_path.read_text().splitlines()):
                    ident = row['id']
                    if ident in supplemental or ident in self.source:
                        raise ValueError('Invalid supplemental review inventory')
                    if not all(isinstance(row.get(field), str) for field in ('source', 'target')):
                        raise ValueError('Invalid supplemental wording')
                    supplemental[ident] = row
            for row in map(json.loads, path.read_text().splitlines()):
                ident = row['id']
                if ident in packet or ident in self.preserved or ident not in self.source.keys() | supplemental.keys():
                    raise ValueError('Invalid independent packet inventory')
                value = supplemental[ident] if ident in supplemental else language[ident]
                if ident in supplemental and row != value:
                    raise ValueError('Supplemental review version differs from frozen full packet')
                if row['source'] != value['source'] or row['target'] != value['target']:
                    raise ValueError('Independent packet is not current')
                for key, field in [('sourceSha256', 'source'), ('targetSha256', 'target')]:
                    if row[key] != hashlib.sha256(value[field].encode()).hexdigest():
                        raise ValueError('Invalid packet hash')
                packet[ident] = row
            if set(packet) != (self.source.keys() - self.preserved.keys()) | supplemental.keys():
                raise ValueError('Incomplete independent packet')
            self.packets[lane['locale']], self.known[lane['locale']] = packet, {}
            lane['boundLanguageSha256'] = digest(self.root / lane['language'])

    def prepare_phase(self, lane, previous, language):
        packet = self.packets[lane['locale']]
        known = self.known[lane['locale']]
        pending = [ident for ident in packet if ident not in known]
        if not pending:
            raise ValueError('No unread primary versions; parent checks remaining context')
        task = read(self.root / lane['assignmentTask'])
        for path, expected in task['job']['immutablePins'].items():
            if digest(self.root / path) != expected:
                raise ValueError('Review prerequisite changed: ' + path)
        number = lane.get('sequence', 0) + 1
        phase = self.root / self.cfg['phaseRoot'] / lane['locale'] / ('review-auto-%04d' % number)
        phase.mkdir(parents=True, exist_ok=False)
        rows = [packet[ident] for ident in pending]
        (phase / 'review-packet.jsonl').write_text(''.join(json.dumps(row, ensure_ascii=False) + '\n' for row in rows))
        save(phase / 'pending-ids.json', pending)
        retained = self.output / 'retained' / (lane['locale'] + '-before-' + phase.name + '.jsonl')
        retained.parent.mkdir(parents=True, exist_ok=True)
        with retained.open('x') as stream:
            for ident in packet:
                if ident in known:
                    stream.write(json.dumps(known[ident], ensure_ascii=False) + '\n')
        pins = dict(task['job']['immutablePins'])
        for path in (phase / 'review-packet.jsonl', phase / 'pending-ids.json', retained):
            pins[str(path.relative_to(self.root))] = digest(path)
        relative = str(phase.relative_to(self.root))
        task['job'].update(immutablePins=pins, initialLanguageSha256=language['sha256'], writePrefixes=[relative])
        description = task['task']
        for key in ('unitIds', 'primaryIds', 'reviewScope', 'scope', 'entryVersions', 'reviewCarryover'):
            description.pop(key, None)
        description.update(kind='work', taskClass='semantic-review', requiredPrimary=len(pending),
            reviewPacket=relative + '/review-packet.jsonl', reviewPacketSha256=digest(phase / 'review-packet.jsonl'),
            primaryIdsFile={'path': relative + '/pending-ids.json', 'sha256': digest(phase / 'pending-ids.json')},
            retainedIndependent={'path': str(retained.relative_to(self.root)), 'sha256': digest(retained), 'count': len(known)},
            fullIndependentRequired=len(packet), previousPhase=previous['phase'],
            continuation={'sameOwnReviewerThread': previous['threadId'], 'noInheritedParentOrFork': True},
            expectedRuntime={'model': 'gpt-6.1-sol', 'reasoning': 'high', 'provider': 'openai', 'parentThreadId': None, 'resumedOwnTask': True})
        save(phase / 'task.json', task)
        (phase / 'brief.md').write_text(
            '# Continue the same independent review\n\n'
            'FIRST await this phase runtime-verification.json proving the NEW actual Sol/high/OpenAI turn '
            'after the saved metadata offset. This is ONLY your same independent-reviewer history, never '
            'the author/coordinator history or a fork. The fresh clause applied to your initial review launch. '
            'No Astra/fallback, nested model, language/source/glossary edit, Git, game/GUI/screenshot/build, '
            'installer, publication/deployment/server action. Write ONLY the new phase.\n\n'
            'Read new task.json. Its exact pending packet replaces the old primary workset and includes '
            'every unread or context-unresolved ID. Current-version pass AND finding judgments in '
            'retainedIndependent are retained from your own prior review, never generated. Do not reread '
            'those primary versions for unrelated style or erase existing findings. Use them as context '
            'only when needed; concrete invalidated dependencies must be named and actually rechecked. '
            'Continue all pending source/target/actor/branch/consumer readings and every unfinished required '
            'case, haiku, image-wording and glossary context. Prior needs-context is still pending.\n\n'
            'Reuse unchanged instructions, complete glossary and known source traces already read in '
            'your own context; do not reopen a global framework audit. Collect ALL findings before any '
            'parent repair. Save actual per-ID sourceSha256/targetSha256/context-bound verdicts and '
            'rationale. Use locale_review_work.py finish-review with this exact subset scope; point '
            'result.reviews to your actual new review JSONL and preserve all missing IDs as unread. '
            'Never generate default passes, copy author conclusions, or count hashes/validators as judgment. '
            'Finish the finite remaining reading using checkpoints/compaction; ordinary batches or a '
            'cumulative token counter are not task budgets or completion. A real blocker must be explicit. '
            'Native/RTL/font/layout/artwork/human glossary and release remain separately unrun. '
            'Record current-attempt usage excluding its saved baseline; leave reporting tail unknown.\n')
        return phase, number

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
                raise ValueError('Nonmonotonic reviewer telemetry')
            save(phase / 'process-exit.json', {'exitCode': child.returncode, 'finishedAt': now(), 'usage': delta,
                 'baselineUsage': baseline, 'finalCumulativeUsage': final,
                 'telemetry': 'Exact own-reviewer attempt delta, cache/reasoning subsets.'})
        if process_identity(runtime['pid'], phase, runtime['threadId']):
            lane.update(status='running', live=True)
            return
        lane['live'] = False
        if not (phase / 'process-exit.json').exists():
            lane['status'] = 'waiting-terminal-receipt'
            return
        receipt = read(phase / 'process-exit.json')
        _, usage, errors = cli_events(phase / 'events.jsonl')
        success = cli_turn_succeeded(receipt['exitCode'], usage, errors)
        result = read(phase / 'result.json') if (phase / 'result.json').exists() else None
        language = inspect_language(self.root, lane, self.source, self.preserved)
        if language['sha256'] != lane['boundLanguageSha256']:
            raise ValueError('Reviewed language changed; reconcile exact invalidated versions')
        if lane.get('accountedPhase') != lane['phase']:
            if success and isinstance(result, dict):
                reviews = result.get('reviews')
                if isinstance(reviews, dict):
                    reviews = reviews.get('path')
                if not isinstance(reviews, str):
                    raise ValueError('Reviewer result has no explicit review rows; parent reconciles')
                path = (self.root / reviews).resolve()
                if not path.is_relative_to(phase.resolve()):
                    raise ValueError('Reviewer rows must belong to its own closed phase')
                rows = checked_rows(path, self.packets[lane['locale']], runtime['threadId'])
                previous = len(self.known[lane['locale']])
                self.known[lane['locale']] = merge_review_result(self.root, phase,
                    self.packets[lane['locale']], runtime['threadId'], self.known[lane['locale']], rows, result)
                lane['noProgressTurns'] = 0 if len(self.known[lane['locale']]) > previous else lane.get('noProgressTurns', 0) + 1
            elif not known_capacity_failure(errors):
                lane['status'] = 'needs-attention-unknown-review-failure'
                return
            lane.update(accountedPhase=lane['phase'], lastAttemptUsage=receipt.get('usage'), atUTC=now())
            save(self.output / 'outcomes' / (lane['locale'] + '-' + phase.name + '.json'),
                 {'locale': lane['locale'], 'phase': lane['phase'], 'terminalReceipt': receipt,
                  'model': 'gpt-6.1-sol', 'reasoning': 'high', 'provider': 'openai'})
            if not success:
                lane['capacityFailures'] = lane.get('capacityFailures', 0) + 1
                lane['retryAfterEpoch'] = time.time() + self.cfg['capacityBackoffSeconds'] * lane['capacityFailures']
            else:
                lane['capacityFailures'] = 0
        known = self.known[lane['locale']]
        lane.update(judgedRetained=len(known), required=len(self.packets[lane['locale']]),
                    findingsRetained=sum(row['verdict'] == 'finding' for row in known.values()))
        if success and isinstance(result, dict) and (result.get('blocker') or result.get('blockers') or
                result.get('outcome') in ('needs-owner', 'needs-decision', 'blocked')):
            lane['status'] = 'held-real-review-blocker'
            return
        if len(known) == len(self.packets[lane['locale']]):
            lane['status'] = 'needs-parent-full-review-and-context-validation'
            aggregate = self.output / 'complete' / (lane['locale'] + '.jsonl')
            aggregate.parent.mkdir(parents=True, exist_ok=True)
            if not aggregate.exists():
                aggregate.write_text(''.join(json.dumps(known[i], ensure_ascii=False) + '\n' for i in self.packets[lane['locale']]))
            lane['aggregateReviews'] = str(aggregate.relative_to(self.root))
            return  # No clean acceptance, correction, build, or independent context pass generated.
        if not success:
            if lane['capacityFailures'] > self.cfg['maxCapacityRetries']:
                lane['status'] = 'held-review-capacity-retries-exhausted'
                return
            lane['status'] = 'capacity-backoff'
            if time.time() < lane['retryAfterEpoch']:
                return
        elif lane.get('noProgressTurns', 0) >= self.cfg['maxNoProgressTurns']:
            lane['status'] = 'held-review-no-primary-progress'
            return
        self.launch(lane, dict(lane), language)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('manifest', type=Path)
    cfg = read(parser.parse_args().manifest)
    root = Path(cfg['root']).resolve()
    output = root / cfg['output']
    output.mkdir(parents=True, exist_ok=True)
    with (output / 'controller.lock').open('a') as lock:
        fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
        if (output / 'status.json').exists():
            raise ValueError('Reconcile the existing reviewer controller; never duplicate')
        for path, expected in cfg['immutablePins'].items():
            if digest(root / path) != expected:
                raise ValueError('Frozen reviewer controller dependency changed: ' + path)
        supervisor = ReviewSupervisor(root, cfg, output)
        live_count = 0
        for lane in cfg['lanes']:
            runtime = read(root / lane['phase'] / 'runtime-verification.json')
            validate_identity(runtime)
            alive = bool(process_identity(runtime['pid'], root / lane['phase'], runtime['threadId']))
            if not alive and not (root / lane['phase'] / 'process-exit.json').exists():
                raise ValueError('Missing original reviewer terminal receipt')
            live_count += int(alive)
            lane.update(status='adopted-running', live=alive, pid=runtime['pid'], threadId=runtime['threadId'], runtimeVerified=True)
        save(output / 'controller.json', {'pid': os.getpid(), 'atUTC': now(), 'selectedOwnReviewers': len(cfg['lanes']),
             'liveAtAdoption': live_count, 'modelRequestsAtAdoption': 0, 'inheritance': 'Only same own independent reviewer histories'})
        supervisor.persist()
        while True:
            for lane in cfg['lanes']:
                try:
                    supervisor.tick(lane)
                except Exception as error:
                    lane.update(status='needs-attention-preserve-reviewer-and-state', error=str(error), atUTC=now())
                supervisor.persist()
            if not any(lane['status'] in ('adopted-running', 'running', 'capacity-backoff', 'waiting-terminal-receipt') for lane in cfg['lanes']):
                break
            time.sleep(cfg.get('pollSeconds', 5))
        save(output / 'finished.json', {'atUTC': now(), 'next': 'Parent verifies complete independent/context evidence and consolidates all findings.', 'acceptanceGenerated': False})


if __name__ == '__main__':
    main()
