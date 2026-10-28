"""Reject unbound/ambiguous QA inputs before cloning or game launch."""
import hashlib
import json
from pathlib import Path
import tempfile
import unittest

from probe.prepare_menu_qa import quest_snapshot


class SnapshotLayout(unittest.TestCase):
    def make(self, root):
        root.mkdir(parents=True, exist_ok=True)
        names = ['quest-family-runtime.json', 'quest-family-wording.json']
        for name in names:
            (root / name).write_text('[]\n')
        (root / 'quest-family-inputs.json').write_text(json.dumps({name: hashlib.sha256((root / name).read_bytes()).hexdigest() for name in names}))

    def test_both_versioned_layouts_and_changed_input(self):
        for nested in [False, True]:
            with tempfile.TemporaryDirectory() as tmp:
                base = Path(tmp)
                root = base / 'recipe' if nested else base
                self.make(root)
                self.assertEqual(quest_snapshot(base), root)
                (root / 'quest-family-runtime.json').write_text('[1]\n')
                with self.assertRaisesRegex(AssertionError, 'quest-snapshot-pin'):
                    quest_snapshot(base)

    def test_missing_and_ambiguous_layouts_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            with self.assertRaisesRegex(AssertionError, 'Missing or ambiguous'):
                quest_snapshot(base)
            self.make(base)
            quest_snapshot(base)
            self.make(base / 'recipe')
            with self.assertRaisesRegex(AssertionError, 'Missing or ambiguous'):
                quest_snapshot(base)


if __name__ == '__main__':
    unittest.main()
