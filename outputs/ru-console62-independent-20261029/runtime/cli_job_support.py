"""Deterministic guards for the two authorized CLI lanes; never generates wording."""
import hashlib
import json
from pathlib import Path
import subprocess
import re

MODEL, EFFORT, PROVIDER = 'gpt-6.1-sol', 'high', 'openai'


def validate_model(model, effort, provider):
    if 'astra' in model.lower() or (model, effort, provider) != (MODEL, EFFORT, PROVIDER):
        raise ValueError('Only explicitly pinned gpt-6.1-sol/high/OpenAI is permitted.')


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def assert_stopped(pid, marker):
    if pid:
        row = subprocess.run(['ps', '-p', str(pid), '-o', 'command='], text=True, capture_output=True)
        if row.returncode == 0 and str(marker) in row.stdout:
            raise RuntimeError(f'Prior task-owned process {pid} is still alive; do not duplicate it.')


def evidence_files(root, directory, names):
    """Operational reports may accompany, but never substitute for, real artifacts."""
    root, directory = Path(root).resolve(), Path(directory).resolve()
    substantive, auxiliary = set(), set()
    for name in names:
        path = (root / name).resolve()
        if root not in path.parents or not path.is_file():
            raise ValueError(f'Evidence is missing or outside the canonical project: {name}')
        entry = (str(path), digest(path))
        if root / 'outputs' in path.parents:
            if directory not in path.parents:
                raise ValueError(f'Operational evidence belongs to another job: {name}')
            auxiliary.add(entry)
        else:
            substantive.add(entry)
    if not substantive:
        raise ValueError('At least one substantive project artifact is required; operational reports alone are not progress.')
    return substantive, auxiliary


def cli_events(path):
    usage, thread, errors = [], None, []
    if Path(path).exists():
        for line in Path(path).read_text().splitlines():
            try:
                event = json.loads(line)
            except json.JSONDecodeError:
                continue
            if event.get('type') == 'thread.started':
                thread = event.get('thread_id')
            if event.get('type') == 'turn.completed' and event.get('usage'):
                usage.append(event['usage'])
            if event.get('type') in ('error', 'turn.failed'):
                errors.append(event)
    total = None
    if usage:
        total = {k: sum(u.get(k, 0) for u in usage) for k in
                 ('input_tokens', 'cached_input_tokens', 'output_tokens', 'reasoning_output_tokens')}
        total['total_tokens'] = total['input_tokens'] + total['output_tokens']
    return thread, total, errors


def cli_turn_succeeded(returncode, usage, errors):
    return returncode == 0 and usage is not None and not any(e.get('type') == 'turn.failed' for e in errors)


def known_capacity_failure(errors):
    messages = [e.get('message') or (e.get('error') or {}).get('message') for e in errors]
    capacity = 'Selected model is at capacity. Please try a different model.'
    return bool(messages) and capacity in messages and all(
        m == capacity or (isinstance(m, str) and re.fullmatch(
            r'Reconnecting\.\.\. [1-5]/5 \(exceeded retry limit, last status: 429 Too Many Requests\)', m))
        for m in messages)


def asset_snapshot(root, directory, asset_directory="localization/ru-assets", locale="ru"):
    root, directory = Path(root), Path(directory)
    if not locale or not asset_directory:
        raise ValueError('Explicit locale and asset directory are required')
    asset_root = (root / asset_directory).resolve()
    if asset_root != (root / 'localization' / (locale + '-assets')).resolve():
        raise ValueError('Asset directory must match the explicitly selected locale')
    overlay = asset_root / ('dialogue.' + locale + '.jsonl')
    pins = json.loads((directory / 'input-pins.json').read_text())
    for name, expected in pins.items():
        if digest(name) != expected:
            raise ValueError(f'Pinned input changed: {name}')
    source = [json.loads(line) for line in (root / 'localization/source/dialogue-candidates.jsonl').read_text().splitlines()]
    by_id = {r['id']: r for r in source}
    if len(by_id) != len(source):
        raise ValueError('Duplicate source IDs')
    rows = [json.loads(line) for line in overlay.read_text().splitlines()]
    targets = {}
    for row in rows:
        ident = row['id']
        if ident in targets or ident not in by_id:
            raise ValueError(f'Duplicate or unknown target ID: {ident}')
        original = by_id[ident]
        if row['source'] != original['source'] or row['occurrences'] != original['occurrences']:
            raise ValueError(f'Source binding changed: {ident}')
        if not row['target'].strip():
            raise ValueError(f'Empty target: {ident}')
        for field in ('source', 'target'):
            if hashlib.sha256(row[field].encode()).hexdigest() != row[field + 'Sha256']:
                raise ValueError(f'Invalid {field} hash: {ident}')
        targets[ident] = row['targetSha256']
    unresolved = json.loads((asset_root / 'unresolved.json').read_text())
    held = {r['id'] for r in unresolved}
    if len(held) != len(unresolved) or held - by_id.keys() or held & targets.keys():
        raise ValueError('Invalid held-ID set')
    next_row = next((r for r in source if r['id'] not in targets and r['id'] not in held), None)
    retirements = {}
    retirement_path = asset_root / 'retired-targets.json'
    if retirement_path.exists():
        seen_retirements = set()
        for record in json.loads(retirement_path.read_text()):
            ident = record['id']
            key = (ident, record['targetSha256'])
            if key in seen_retirements or ident not in by_id:
                raise ValueError('Retired target receipt must be unique and source-bound')
            seen_retirements.add(key)
            if hashlib.sha256(by_id[ident]['source'].encode()).hexdigest() != record['sourceSha256']:
                raise ValueError('Retired target source changed')
            if not record.get('reason') or hashlib.sha256(record['target'].encode()).hexdigest() != record['targetSha256']:
                raise ValueError('Retired target wording/reason is not preserved')
            evidence = (root / record['evidence']).resolve()
            if not (asset_root in evidence.parents or directory.resolve() in evidence.parents) or digest(evidence) != record['evidenceSha256']:
                raise ValueError('Retirement evidence must be pinned inside its own lane')
            if ident in held and ident not in targets:
                retirements[ident] = record['targetSha256']
    return {'authoredIds': len(targets), 'heldIds': len(held), 'sourceIds': len(source),
            'visitedIds': len(targets) + len(held), 'remainingIds': len(source) - len(targets),
            'overlaySha256': digest(overlay),
            'next': {k: next_row[k] for k in ('id', 'conversation', 'conversationId')} if next_row else None,
            'targetHashes': targets, 'held': sorted(held), 'retiredTargets': retirements}


def asset_progress(before, after):
    lost = before['targetHashes'].keys() - after['targetHashes'].keys()
    if any(ident not in after.get('held', []) or after.get('retiredTargets', {}).get(ident) != before['targetHashes'][ident] for ident in lost):
        raise ValueError('Continuation lost previously saved translation IDs')
    if before['sourceIds'] != after['sourceIds']:
        raise ValueError('Source inventory changed')
    return after['authoredIds'] > before['authoredIds'] or after['visitedIds'] > before['visitedIds']
