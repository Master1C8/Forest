"""Verify fresh CLI metadata without a calendar-specific session directory.

The exact thread registry is authoritative for path discovery. The bounded
current-date fallback covers registry publication lag and UTC/local midnight.
Only session_meta/turn_context fields enter the receipt; no chat text is emitted.
"""
import datetime
import json
from pathlib import Path
import sqlite3
import subprocess
import time


class RuntimeIdentityError(RuntimeError):
    pass


def session_path(state_dir, thread, now=None):
    state_dir = Path(state_dir).resolve()
    paths = set()
    for database in state_dir.glob('state_*.sqlite'):
        try:
            with sqlite3.connect(database.as_uri() + '?mode=ro', uri=True) as connection:
                row = connection.execute('SELECT rollout_path FROM threads WHERE id=?', (thread,)).fetchone()
                if row:
                    paths.add(Path(row[0]).resolve())
        except sqlite3.OperationalError:
            continue  # Registry creation/locking may briefly precede publication.
    if not paths:
        now = now or datetime.datetime.now(datetime.timezone.utc)
        for delta in (-1, 0, 1):
            day = (now + datetime.timedelta(days=delta)).strftime('%Y/%m/%d')
            paths.update(p.resolve() for p in (state_dir / 'sessions' / day).glob('*' + thread + '*.jsonl'))
    if len(paths) > 1:
        raise RuntimeIdentityError('Ambiguous exact-thread session paths')
    if not paths:
        return None
    path = paths.pop()
    if not path.is_relative_to(state_dir) or thread not in path.name:
        raise RuntimeIdentityError('Session path is outside the exact-thread state boundary')
    return path if path.is_file() else None


def metadata_receipt(path, thread):
    session = turn = None
    with Path(path).open() as stream:
        for line in stream:
            try:
                event = json.loads(line)
            except ValueError:
                continue  # A concurrently appended last record may be partial.
            payload = event.get('payload', {})
            if event.get('type') == 'session_meta':
                session = {k: payload.get(k) for k in ('id', 'source', 'model_provider', 'parent_thread_id')}
            elif event.get('type') == 'turn_context':
                turn = {k: payload.get(k) for k in ('model', 'effort')}
                break
    if session is None or turn is None:
        return None
    if session['id'] != thread:
        raise RuntimeIdentityError('Metadata thread ID mismatch')
    if session['source'] != 'exec' or session['parent_thread_id'] is not None:
        raise RuntimeIdentityError('Session is not a fresh exec without inherited history')
    if session['model_provider'] != 'openai':
        raise RuntimeIdentityError('Actual provider is not OpenAI')
    if turn != {'model': 'gpt-6.1-sol', 'effort': 'high'}:
        raise RuntimeIdentityError('Actual model/reasoning is not pinned Sol/high')
    return {'session': session, 'turn': turn}


def publish_current_runtime(phase, child, state_dir=None, timeout=30):
    phase = Path(phase)
    state_dir = Path(state_dir) if state_dir is not None else Path.home() / '.codex'
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        thread = None
        for line in (phase / 'events.jsonl').read_text().splitlines():
            try:
                event = json.loads(line)
            except ValueError:
                continue
            if event.get('type') == 'thread.started':
                thread = event['thread_id']
                break
        path = session_path(state_dir, thread) if thread else None
        actual = metadata_receipt(path, thread) if path else None
        if actual:
            argv = subprocess.run(['ps', '-p', str(child.pid), '-o', 'pid=,ppid=,lstart=,command='], capture_output=True, text=True)
            required = [' exec --ignore-user-config', '--model gpt-6.1-sol',
                        'model_provider="openai"', 'model_reasoning_effort="high"', str(phase)]
            if argv.returncode or not all(value in argv.stdout for value in required):
                raise RuntimeIdentityError('Live argv does not match the pinned fresh request')
            receipt = dict(threadId=thread, sessionMetadataPath=str(path), actualRuntime=actual,
                           pid=child.pid, actualArgvEvidence=argv.stdout, freshExecNoResumeNoFork=True)
            temporary = phase / 'runtime-verification.json.pending'
            temporary.write_text(json.dumps(receipt, indent=2) + '\n')
            temporary.replace(phase / 'runtime-verification.json')
            return receipt
        time.sleep(.1)
    raise RuntimeIdentityError('Current runtime identity was not published before the deadline; preserve/reconcile child')
