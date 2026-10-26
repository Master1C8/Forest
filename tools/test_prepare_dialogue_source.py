"""Check the source preparer's partial-write boundary, not translation semantics."""
import contextlib
import io
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import prepare_dialogue_source as source


class PartialCreation(unittest.TestCase):
    def test_resume_after_second_write_failure_and_reject_changed_first_file(self):
        fixtures = {'dialogue-candidates.jsonl': b'{"id":"fixture"}\n',
                    'dialogue-manifest.json': b'{"scope":"fixture-only"}\n'}
        directory = source.ROOT / 'outputs'
        directory.mkdir(exist_ok=True)
        with tempfile.TemporaryDirectory(prefix='source-write-check-', dir=directory) as tmp:
            out = Path(tmp)
            actual_write = Path.write_bytes

            def fail_second(path, data):
                if path == out / 'dialogue-manifest.json':
                    raise OSError('injected failure between output writes')
                return actual_write(path, data)

            argv = ['prepare_dialogue_source.py', '--output', str(out)]
            with patch.object(source, 'prepare', return_value=fixtures), patch('sys.argv', argv), contextlib.redirect_stdout(io.StringIO()):
                with patch.object(Path, 'write_bytes', fail_second):
                    with self.assertRaisesRegex(OSError, 'between output writes'):
                        source.main()
                first = out / 'dialogue-candidates.jsonl'
                self.assertEqual(first.read_bytes(), fixtures[first.name])
                self.assertFalse((out / 'dialogue-manifest.json').exists())
                first_stat = first.stat().st_mtime_ns
                source.main()
                self.assertEqual(first.stat().st_mtime_ns, first_stat)
                for name, value in fixtures.items():
                    self.assertEqual((out / name).read_bytes(), value)
                first.write_bytes(b'changed\n')
                manifest_stat = (out / 'dialogue-manifest.json').stat().st_mtime_ns
                with self.assertRaisesRegex(AssertionError, 'Changed existing output:'):
                    source.main()
                self.assertEqual(first.read_bytes(), b'changed\n')
                self.assertEqual((out / 'dialogue-manifest.json').stat().st_mtime_ns, manifest_stat)


if __name__ == '__main__':
    unittest.main()
