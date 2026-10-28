"""Real local registry/file checks; no model call or semantic acceptance."""
import datetime
import json
from pathlib import Path
import sqlite3
import tempfile
import unittest

from cli_runtime_identity import RuntimeIdentityError, metadata_receipt, session_path


class RuntimeIdentity(unittest.TestCase):
    thread = '11111111-2222-3333-4444-555555555555'

    def fixture(self, root, day='2026/10/28', model='gpt-6.1-sol', parent=None):
        path = root / 'sessions' / day / ('rollout-' + self.thread + '.jsonl')
        path.parent.mkdir(parents=True, exist_ok=True)
        events = [
            {'type': 'session_meta', 'payload': dict(id=self.thread, source='exec', model_provider='openai', parent_thread_id=parent)},
            {'type': 'response_item', 'payload': {'model': 'untrusted-message-text', 'content': 'Never treat chat content as runtime identity'}},
            {'type': 'turn_context', 'payload': dict(model=model, effort='high')},
        ]
        path.write_text(''.join(json.dumps(row) + '\n' for row in events))
        return path

    def test_registry_resolves_actual_day_instead_of_historical_date(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp).resolve(); path = self.fixture(root)
            with sqlite3.connect(root / 'state_5.sqlite') as db:
                db.execute('CREATE TABLE threads(id TEXT, rollout_path TEXT)')
                db.execute('INSERT INTO threads VALUES (?,?)', (self.thread, str(path)))
            self.assertEqual(session_path(root, self.thread), path)
            self.assertEqual(metadata_receipt(path, self.thread)['turn']['model'], 'gpt-6.1-sol')
            # A different thread cannot inherit this valid receipt.
            self.assertIsNone(session_path(root, 'another-thread'))

    def test_fallback_covers_midnight_without_a_registry(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp).resolve(); path = self.fixture(root, '2026/10/27')
            now = datetime.datetime(2026, 10, 28, 0, 1, tzinfo=datetime.timezone.utc)
            self.assertEqual(session_path(root, self.thread, now), path)
            self.assertIsNotNone(metadata_receipt(path, self.thread))

    def test_astra_rejected_with_other_identity_guards_satisfied(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp); path = self.fixture(root)
            self.assertIsNotNone(metadata_receipt(path, self.thread))
            self.fixture(root, model='gpt-6-astra')
            with self.assertRaisesRegex(RuntimeIdentityError, 'Actual model/reasoning'):
                metadata_receipt(path, self.thread)

    def test_inherited_session_rejected_with_matching_model(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp); path = self.fixture(root)
            self.assertIsNotNone(metadata_receipt(path, self.thread))
            self.fixture(root, parent='parent-thread')
            with self.assertRaisesRegex(RuntimeIdentityError, 'not a fresh exec'):
                metadata_receipt(path, self.thread)

    def test_ambiguous_and_outside_registry_paths_are_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp).resolve(); first = self.fixture(root); second = self.fixture(root, '2026/10/29')
            now = datetime.datetime(2026, 10, 28, tzinfo=datetime.timezone.utc)
            with self.assertRaisesRegex(RuntimeIdentityError, 'Ambiguous'):
                session_path(root, self.thread, now)
            second.unlink()
            with sqlite3.connect(root / 'state_5.sqlite') as db:
                db.execute('CREATE TABLE threads(id TEXT, rollout_path TEXT)')
                db.execute('INSERT INTO threads VALUES (?,?)', (self.thread, str(root.parent / first.name)))
            with self.assertRaisesRegex(RuntimeIdentityError, 'outside'):
                session_path(root, self.thread, now)


if __name__ == '__main__':
    unittest.main()
