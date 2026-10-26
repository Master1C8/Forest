#!/usr/bin/env python3
"""Fresh-context, read-only preliminary dialogue audits; never invents verdicts."""
import argparse
import datetime
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys

from cli_job_support import validate_model, cli_events, cli_turn_succeeded, assert_stopped

MODEL, EFFORT = 'gpt-6.1-sol', 'high'
VERDICTS = {'pass', 'finding', 'needs-context', 'source-defect', 'technical-preservation'}


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def encoded(value):
    return json.dumps(value, ensure_ascii=False, separators=(',', ':'))


def save(path, value):
    temp = path.with_suffix(path.suffix + '.pending')
    temp.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')
    temp.replace(path)


def rows(path):
    return [json.loads(s) for s in path.read_text().splitlines() if s.strip()]


def check_pins(config):
    for name, digest in config['pins'].items():
        assert sha(name) == digest, 'Pinned editorial input changed: ' + name


def prepare(root, directory, locale, language):
    root, directory = root.resolve(), directory.resolve()
    assert root in directory.parents and locale in {'ru', 'zh', 'es', 'es-419', 'pt-BR', 'de'}, 'Explicit authorized editorial locale/root required'
    assert not directory.exists(), 'Reconcile an existing lane before preparation'
    overlay = root / f'localization/{locale}-assets/dialogue.{locale}.jsonl'
    source = root / 'localization/source/dialogue-candidates.jsonl'
    manifest = root / 'localization/source/dialogue-manifest.json'
    source_rows, targets = rows(source), rows(overlay)
    by_id = {r['id']: r for r in source_rows}
    target_ids = {r['id']: r for r in targets}
    assert len(by_id) == len(source_rows) == len(target_ids) == len(targets)
    assert by_id.keys() == target_ids.keys(), 'Complete pinned family required'
    pins = {str(p): sha(p) for p in [source, manifest, overlay,
        root / 'localization/glossary/en.json', root / f'localization/glossary/{locale}.json',
        Path('/Users/antonkrutov/.codex/instructions/game-localization-audit-workflow.md'),
        Path('/Users/antonkrutov/.codex/instructions/game-localization-prompt.md')]}
    data = json.loads(manifest.read_text())
    assert len(source_rows) == data['candidateUnits']
    trees = []
    for item in data['sources']:
        path = root / item['tree']; assert sha(path) == item['treeSha256']
        pins[str(path)] = sha(path); trees.append(json.loads(path.read_text()))
    assert trees[0]['conversations'] == trees[1]['conversations']
    entries = {(c['id'], e['id']): e for c in trees[0]['conversations'] for e in c['dialogueEntries']}
    pairs = []
    for original in source_rows:
        target = target_ids[original['id']]
        assert target['source'] == original['source'] and target['occurrences'] == original['occurrences'] and target['pointer'] == original['pointer']
        for field in ['source', 'target']:
            assert hashlib.sha256(target[field].encode()).hexdigest() == target[field + 'Sha256']
        for tree in trees:
            value = tree
            for key in original['pointer'].strip('/').split('/'):
                value = value[int(key)] if isinstance(value, list) else value[key]
            assert value == original['source'], 'Physical source binding differs'
        entry = entries[(original['conversationId'], int(original['id'].split(':')[2]))]
        fields = {f['title']: f['value'] for f in entry['fields']}
        pairs.append({'id': original['id'], 'source': original['source'], 'target': target['target'],
            'sourceSha256': target['sourceSha256'], 'targetSha256': target['targetSha256'],
            'conversationId': original['conversationId'], 'conversation': original['conversation'],
            'actor': fields.get('Actor'), 'conversant': fields.get('Conversant'),
            'title': fields.get('Title'), 'sequence': fields.get('Sequence'),
            'conditions': entry.get('conditionsString'), 'script': entry.get('userScript'),
            'links': entry.get('outgoingLinks'), 'isGroup': entry.get('isGroup'),
            'unchangedReason': target.get('unchangedReason'), 'unchangedCategory': target.get('unchangedCategory')})
    directory.mkdir(parents=True)
    snapshot = directory / 'pairs.jsonl'
    snapshot.write_text(''.join(encoded(p) + '\n' for p in pairs))
    context = directory / 'source-context.json'
    save(context, {'actors': trees[0].get('actors', []), 'conversations': trees[0]['conversations']})
    for name in ['en', locale]:
        shutil.copyfile(root / f'localization/glossary/{name}.json', directory / f'glossary-{name}.json')
    batches, current, size = [], [], 0
    for pair in pairs:
        amount = len(pair['source']) + len(pair['target'])
        if current and (len(current) >= 350 or size + amount > 80000):
            batches.append(current); current, size = [], 0
        current.append(pair['id']); size += amount
    if current: batches.append(current)
    pins.update({str(p): sha(p) for p in [snapshot, context, directory / 'glossary-en.json', directory / f'glossary-{locale}.json']})
    config = {'root': str(root), 'locale': locale, 'language': language, 'model': MODEL,
        'reasoning': EFFORT, 'pins': pins, 'batches': batches, 'candidateIds': len(pairs),
        'scope': 'Preliminary complete dialogue-candidate-family semantic audit only; full-game source/glossary/resource/runtime gates unaccepted',
        'ownerException': '2026-10-27: owner explicitly chose reviewing the entire ready dialogue family now, with preliminary status and possible restart after source changes.'}
    save(directory / 'config.json', config)
    check_pins(config)
    save(directory / 'job.json', {'status': 'prepared', 'phases': [], 'locale': locale,
        'model': MODEL, 'reasoning': EFFORT, 'reviewedIds': 0, 'findingIds': 0})
    return config


def read_packet(phase, start, count):
    packet = rows(phase / 'pairs.jsonl')
    assert 0 <= start < len(packet) and 1 <= count <= 20
    selected = []; output = None
    for row in packet[start:start + count]:
        candidate = selected + [row]
        attempt = {'start': start, 'next': start + len(candidate), 'rows': candidate}
        if len(encoded(attempt).encode()) > 8000: break
        selected, output = candidate, attempt
    assert selected, 'Oversized unit: use read-unit with bounded character parts'
    reads = phase / 'reads'; reads.mkdir(exist_ok=True)
    receipt = {'kind': 'rows', 'ids': [r['id'] for r in selected],
        'packetSha256': sha(phase / 'pairs.jsonl'),
        'emittedSha256': hashlib.sha256(encoded(output).encode()).hexdigest()}
    path = reads / (f'rows-{start:04d}-{start + len(selected):04d}.json')
    save(path, receipt)
    print(encoded(output))


def read_unit(phase, ident, start):
    row = next(r for r in rows(phase / 'pairs.jsonl') if r['id'] == ident)
    text = encoded(row); assert 0 <= start < len(text)
    end = min(start + 1800, len(text))
    output = {'id': ident, 'start': start, 'end': end, 'length': len(text), 'text': text[start:end]}
    reads = phase / 'reads'; reads.mkdir(exist_ok=True)
    save(reads / ('unit-' + hashlib.sha256(ident.encode()).hexdigest()[:16] + f'-{start}.json'),
        {'kind': 'part', 'id': ident, 'start': start, 'end': end, 'length': len(text),
         'packetSha256': sha(phase / 'pairs.jsonl')})
    print(encoded(output))


def finalize(phase):
    packet = rows(phase / 'pairs.jsonl'); by_id = {r['id']: r for r in packet}
    complete, parts = set(), {}
    for path in (phase / 'reads').glob('*.json'):
        receipt = json.loads(path.read_text())
        assert receipt['packetSha256'] == sha(phase / 'pairs.jsonl'), 'Read receipt version differs'
        if receipt['kind'] == 'rows': complete.update(receipt['ids'])
        else: parts.setdefault(receipt['id'], []).append(receipt)
    for ident, ranges in parts.items():
        end = 0; length = len(encoded(by_id[ident]))
        for item in sorted(ranges, key=lambda r: r['start']):
            assert item['length'] == length and 0 <= item['start'] <= item['end'] <= length
            if item['start'] > end: break
            end = max(end, item['end'])
        if end == length: complete.add(ident)
    decisions = rows(phase / 'decisions.jsonl')
    assert len(decisions) == len({r['id'] for r in decisions}), 'Duplicate editorial decision'
    assert {r['id'] for r in decisions} == by_id.keys(), 'Incomplete/foreign semantic coverage'
    assert by_id.keys() <= complete, 'Missing full emitted-read coverage'
    output = []
    for decision in decisions:
        row = by_id[decision['id']]
        assert decision['verdict'] in VERDICTS and decision.get('rationale', '').strip(), 'Actual individual decision required'
        if decision['verdict'] == 'finding':
            assert decision.get('proposedTarget') or decision.get('requiresSourceDecision') is True, 'Finding requires full correction or source question'
        output.append({**decision, 'sourceSha256': row['sourceSha256'], 'targetSha256': row['targetSha256']})
    (phase / 'reviews.jsonl').write_text(''.join(encoded(r) + '\n' for r in output))
    save(phase / 'result.json', {'outcome': 'batch-reviewed', 'reviewedIds': len(output),
        'findingIds': sum(r['verdict'] != 'pass' for r in output),
        'reviewsSha256': sha(phase / 'reviews.jsonl'),
        'limits': 'Stored read/decision receipts do not themselves prove semantic correctness or full-game acceptance.'})
    return output


def context(directory, conversation, entry_id):
    data = json.loads((directory / 'source-context.json').read_text())
    conv = next(c for c in data['conversations'] if c['id'] == conversation)
    entries = {e['id']: e for e in conv['dialogueEntries']}; selected = {entry_id}
    for key, entry in entries.items():
        for link in entry['outgoingLinks']:
            if key == entry_id or (link['destinationConversationID'] == conversation and link['destinationDialogueID'] == entry_id):
                selected.add(key)
                if link['destinationConversationID'] == conversation: selected.add(link['destinationDialogueID'])
    selected_entries = [e for e in conv['dialogueEntries'] if e['id'] in selected]
    actor_ids = {int(f['value']) for e in selected_entries for f in e['fields']
                 if f['title'] in {'Actor', 'Conversant'} and str(f['value']).isdigit()}
    output = {'conversation': conversation, 'fields': conv['fields'],
        'entries': selected_entries, 'actors': [a for a in data['actors'] if a['id'] in actor_ids],
        'warning': 'Serialized actor IDs alone do not establish scene identity; trace labels/links and canonical evidence.'}
    raw = encoded(output)
    assert len(raw.encode()) <= 8000, 'Context too large: inspect selected source-context fields in smaller bounded reads'
    print(raw)


def reconcile_interruption(directory, state, config, receipt_path):
    receipt_path = receipt_path.resolve()
    assert directory in receipt_path.parents, 'Reconciliation belongs to another lane'
    receipt = json.loads(receipt_path.read_text())
    assert state['status'] in {'running', 'held-supervisor-error'}, 'Only an interrupted supervisor may resume'
    assert receipt['kind'] == 'storage-interruption' and receipt['jobSha256'] == sha(directory / 'job.json'), 'Interrupted checkpoint changed'
    last = state['phases'][-1]
    assert last['status'] != 'batch-reviewed' and receipt['phaseDirectory'] == last['directory'], 'Wrong interrupted phase'
    assert receipt['eventsSha256'] == sha(Path(last['directory']) / 'events.jsonl'), 'Interrupted request changed'
    assert receipt['noSurvivingTaskProcesses'] is True and receipt['availableBytes'] >= 256 * 1024**2
    for pid in [state.get('supervisorPid'), state.get('pid'), last.get('pid')]:
        assert_stopped(pid, directory)
    check_pins(config)
    complete = [p for p in state['phases'] if p['status'] == 'batch-reviewed']
    assert [p['number'] for p in complete] == list(range(1, len(complete) + 1)), 'Completed prefix is not contiguous'
    for p, ids in zip(complete, config['batches']):
        phase = Path(p['directory']); result = json.loads((phase / 'result.json').read_text())
        assert sha(phase / 'pairs.jsonl') == p['packetSha256']
        assert sha(phase / 'reviews.jsonl') == result['reviewsSha256']
        assert {r['id'] for r in rows(phase / 'reviews.jsonl')} == set(ids)
    assert state['reviewedIds'] == sum(len(config['batches'][i]) for i in range(len(complete)))
    lock = directory / 'queue.lock'
    if lock.exists():
        assert json.loads(lock.read_text())['pid'] == state['supervisorPid'], 'Foreign queue claim'
        lock.rename(receipt_path.parent / 'prior-queue.lock')
    thread, usage, errors = cli_events(Path(last['directory']) / 'events.jsonl')
    last.update(status='interrupted-storage-full', threadId=thread, measuredUsage=usage,
                errors=errors, requestOutcome='Local processes verified absent; final accounting unknown unless terminal usage survived',
                reconciliation=str(receipt_path))
    state.setdefault('resumptions', []).append({'receipt': str(receipt_path), 'sha256': sha(receipt_path)})
    state.pop('reason', None)
    return len(complete)


def run(directory, reconciliation=None):
    directory = directory.resolve(); config = json.loads((directory / 'config.json').read_text())
    validate_model(config['model'], config['reasoning'], 'openai')
    state = json.loads((directory / 'job.json').read_text())
    assert state['status'] == 'prepared' or reconciliation is not None, 'Explicit reconciled interruption required'
    registry = json.loads((Path.home() / '.codex/models_cache.json').read_text())
    assert any(m.get('slug') == MODEL for m in registry['models'])
    check_pins(config)
    completed = reconcile_interruption(directory, state, config, reconciliation) if reconciliation else 0
    lock = directory / 'queue.lock'
    with lock.open('x') as stream: json.dump({'pid': os.getpid()}, stream)
    state.update(status='running', supervisorPid=os.getpid(), inheritedHistory=False)
    save(directory / 'job.json', state)
    helper, support = directory / 'editorial_lane.py', directory / 'cli_job_support.py'
    execution_pins = {p: sha(p) for p in [helper, support, directory / 'config.json', directory / 'contract.md']}
    by_id = {r['id']: r for r in rows(directory / 'pairs.jsonl')}
    try:
        for number, ids in enumerate(config['batches'][completed:], completed + 1):
            assert shutil.disk_usage(config['root']).free >= 256 * 1024**2, 'Insufficient disk reserve before model request'
            check_pins(config)
            assert all(sha(p) == digest for p, digest in execution_pins.items()), 'Frozen execution dependency changed'
            phase = directory / f'{number:04d}-semantic'
            attempt = 1
            while phase.exists():
                attempt += 1
                phase = directory / f'{number:04d}-semantic-attempt-{attempt:02d}'
            phase.mkdir()
            (phase / 'pairs.jsonl').write_text(''.join(encoded(by_id[i]) + '\n' for i in ids))
            brief = f'''Read {directory / 'contract.md'} and execute this exact {config['language']} ({config['locale']}) preliminary full-family audit batch. Fresh no-history gpt-6.1-sol/high/OpenAI; verify actual argv; NEVER Astra/default/fallback or nested model jobs. Read-only all project/source/locale data. Write only this phase's read receipts, model-authored decisions/findings and result. No Git/index, games, images, translation edits or site/server operations.
Read the complete compact working glossaries {directory / 'glossary-en.json'} and {directory / ('glossary-' + config['locale'] + '.json')} once, plus the universal audit protocol and the bounded contract. This batch has {len(ids)} exact stable IDs in {phase / 'pairs.jsonl'}; no sampling or guessed pass coverage. Actual source/target fields must all be read once with sufficient actor/addressee/branch/sequence context. Use `python3 -B {helper} read --phase {phase} --start N --count 20` with max_output_tokens at least10000. Output is bounded to8000 UTF8 bytes; follow actual returned next index, never assume20 were returned. For oversized individual units use read-unit with successive start/end parts until length. Do not redirect read output to a file to manufacture receipts. A truncated/unread tool output earns no read credit. The receipts only bind emitted versions; they do not replace your real semantic reading.
Use `python3 -B {helper} context --job {directory} --conversation ID --entry ID` for real linked context. If its output is too large, read bounded exact entries/actors from source-context.json; never accept truncation. Read relevant actual scene evidence/glossary references for concrete doubts, not other locales' audits or previous model histories. No blanket uppercase/colon/non-Latin heuristics.
Author decisions.jsonl explicitly, one actual individual decision per assigned ID: id, verdict(pass|finding|needs-context|source-defect|technical-preservation), concise objective rationale, and proposedTarget(full complete replacement) or requiresSourceDecision=true for a finding. Do not use a loop/script to default unread rows to pass. Scripts may join IDs/hashes, never produce verdicts or corrected wording. Preserve meaning, every fact/sentence/credit, speaker/addressee/possessor, source anonymity/reveal timing, identity/species/kinship/number/negation, approved terminology and known/hidden gender/address rules. Keep real commands, comparisons/IDs, markup span meaning, placeholders, control operands, line/choice boundaries, callbacks and wordplay intact. Stable hash/control equality alone is not semantic correctness. Record every objective issue, not the first one; valid alternatives need no taste rewrite.
Technical preservation, original fictional-language symbols, punctuation/names and original source placeholders need explicit source-aware assessment; they are not translated-wording coverage. The six original placeholders and Finley glossary/background contradiction remain OPEN source findings; do not invent text or rewrite primary source facts to match a contradictory background clause. Inspect relevant source links. This is preliminary dialogue-family review under the owner's explicit exception: full game inventory, image plans, source/renderer/special-scene/resource/runtime acceptance stay pending. Record needs-context/source-defect where necessary without stopping independent review of the rest of this batch.
When all assigned decisions are genuinely complete, call `python3 -B {helper} finalize --phase {phase}`. It joins actual decisions with immutable versions and checks emitted-read coverage. Do not edit reviews.jsonl/result.json afterward. Finish promptly; the supervisor launches the next fresh batch automatically. No corrections in this initial full pass. All findings are consolidated before adjudication, versioned dependency closure and a separate fresh independent diff/delta review. Never claim a clean final localization from this batch or from a validator.
'''
            (phase / 'brief.md').write_text(brief)
            cli = str(Path(shutil.which('codex')).resolve())
            command = [cli, 'exec', '--ignore-user-config', '--model', MODEL,
                '-c', 'model_provider="openai"', '-c', 'model_reasoning_effort="high"',
                '-c', 'approval_policy="never"', '--sandbox', 'danger-full-access', '--disable', 'multi_agent',
                '--cd', config['root'], '--json', '--output-last-message', str(phase / 'last-message.txt'),
                'Execute ' + str(phase / 'brief.md') + '. Exact target ' + config['locale'] + '; fresh no-history read-only semantic review.']
            record = {'number': number, 'attempt': attempt, 'kind': 'preliminary-semantic', 'directory': str(phase), 'status': 'running', 'command': command,
                      'packetSha256': sha(phase / 'pairs.jsonl')}
            state['phases'].append(record)
            with (phase / 'events.jsonl').open('w') as out, (phase / 'stderr.log').open('w') as err:
                child = subprocess.Popen(command, cwd=config['root'], stdin=subprocess.DEVNULL, stdout=out, stderr=err)
                record['pid'] = child.pid; state['pid'] = child.pid; save(directory / 'job.json', state); rc = child.wait()
            thread, usage, errors = cli_events(phase / 'events.jsonl')
            record.update(exitCode=rc, threadId=thread, measuredUsage=usage, errors=errors, status='process-exited')
            if not cli_turn_succeeded(rc, usage, errors):
                state['status'] = 'held-request-failure'; break
            check_pins(config)
            assert sha(phase / 'pairs.jsonl') == record['packetSha256'], 'Assigned packet changed during review'
            # Revalidate actual model-authored decisions/read coverage instead of
            # trusting a worker-supplied result or hand-written coverage counter.
            finalize(phase)
            result = json.loads((phase / 'result.json').read_text())
            assert result['outcome'] == 'batch-reviewed' and result['reviewedIds'] == len(ids)
            reviewed = rows(phase / 'reviews.jsonl'); assert {r['id'] for r in reviewed} == set(ids)
            assert sha(phase / 'reviews.jsonl') == result['reviewsSha256']
            for row in reviewed:
                assert all(row[field] == by_id[row['id']][field] for field in ['sourceSha256', 'targetSha256'])
            record.update(status='batch-reviewed', result=result)
            state['reviewedIds'] += len(ids); state['findingIds'] += result['findingIds']
            save(directory / 'job.json', state)
        else:
            assert state['reviewedIds'] == config['candidateIds']
            consolidated = [r for p in state['phases'] if p['status'] == 'batch-reviewed'
                            for r in rows(Path(p['directory']) / 'reviews.jsonl') if r['verdict'] != 'pass']
            (directory / 'findings.jsonl').write_text(''.join(encoded(r) + '\n' for r in consolidated))
            state.update(status='full-pass-complete-awaiting-adjudication', nextStage='Consolidated source-based adjudication, accepted correction batch, immutable dependency closure, distinct fresh independent diff/delta review; no full-game editorial acceptance.')
    except BaseException as error:
        state.update(status='held-supervisor-error', reason=type(error).__name__ + ': ' + str(error))
        raise
    finally:
        state['measuredUsage'] = {k: sum((p.get('measuredUsage') or {}).get(k, 0) for p in state['phases']) for k in ['input_tokens', 'cached_input_tokens', 'output_tokens', 'reasoning_output_tokens', 'total_tokens']}
        save(directory / 'job.json', state)
        if lock.exists() and json.loads(lock.read_text()).get('pid') == os.getpid(): lock.unlink()


def main():
    parser = argparse.ArgumentParser(description=__doc__); sub = parser.add_subparsers(dest='action', required=True)
    p = sub.add_parser('prepare'); p.add_argument('--root', type=Path, required=True); p.add_argument('--job', type=Path, required=True); p.add_argument('--locale', required=True); p.add_argument('--language', required=True)
    p = sub.add_parser('run'); p.add_argument('--job', type=Path, required=True); p.add_argument('--reconcile-interruption', type=Path)
    p = sub.add_parser('read'); p.add_argument('--phase', type=Path, required=True); p.add_argument('--start', type=int, required=True); p.add_argument('--count', type=int, default=20)
    p = sub.add_parser('read-unit'); p.add_argument('--phase', type=Path, required=True); p.add_argument('--id', required=True); p.add_argument('--start', type=int, default=0)
    p = sub.add_parser('finalize'); p.add_argument('--phase', type=Path, required=True)
    p = sub.add_parser('context'); p.add_argument('--job', type=Path, required=True); p.add_argument('--conversation', type=int, required=True); p.add_argument('--entry', type=int, required=True)
    args = parser.parse_args()
    if args.action == 'prepare': print(encoded(prepare(args.root, args.job, args.locale, args.language)))
    elif args.action == 'run': run(args.job, args.reconcile_interruption)
    elif args.action == 'read': read_packet(args.phase, args.start, args.count)
    elif args.action == 'read-unit': read_unit(args.phase, args.id, args.start)
    elif args.action == 'finalize': print(encoded({'reviewed': len(finalize(args.phase))}))
    elif args.action == 'context': context(args.job, args.conversation, args.entry)


if __name__ == '__main__':
    main()
