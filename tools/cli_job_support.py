"""Deterministic guards for the two authorized CLI lanes; never generates wording."""
import hashlib
import json
from pathlib import Path
import subprocess

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


def asset_snapshot(root, directory):
    root, directory = Path(root), Path(directory)
    pins = json.loads((directory / 'input-pins.json').read_text())
    for name, expected in pins.items():
        if digest(name) != expected:
            raise ValueError(f'Pinned input changed: {name}')
    source = [json.loads(line) for line in (root / 'localization/source/dialogue-candidates.jsonl').read_text().splitlines()]
    by_id = {r['id']: r for r in source}
    if len(by_id) != len(source):
        raise ValueError('Duplicate source IDs')
    rows = [json.loads(line) for line in (root / 'localization/ru-assets/dialogue.ru.jsonl').read_text().splitlines()]
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
    unresolved = json.loads((root / 'localization/ru-assets/unresolved.json').read_text())
    held = {r['id'] for r in unresolved}
    if len(held) != len(unresolved) or held - by_id.keys() or held & targets.keys():
        raise ValueError('Invalid held-ID set')
    next_row = next((r for r in source if r['id'] not in targets and r['id'] not in held), None)
    return {'authoredIds': len(targets), 'heldIds': len(held), 'sourceIds': len(source),
            'visitedIds': len(targets) + len(held), 'remainingIds': len(source) - len(targets),
            'overlaySha256': digest(root / 'localization/ru-assets/dialogue.ru.jsonl'),
            'next': {k: next_row[k] for k in ('id', 'conversation', 'conversationId')} if next_row else None,
            'targetHashes': targets, 'held': sorted(held)}


def asset_progress(before, after):
    if before['targetHashes'].keys() - after['targetHashes'].keys():
        raise ValueError('Continuation lost previously saved translation IDs')
    if before['sourceIds'] != after['sourceIds']:
        raise ValueError('Source inventory changed')
    return after['authoredIds'] > before['authoredIds'] or after['visitedIds'] > before['visitedIds']
