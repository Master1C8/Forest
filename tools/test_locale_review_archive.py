"""Evidence recovery regressions; no models, games or deletion."""
import hashlib
import tempfile
import unittest
from pathlib import Path
import locale_review_archive as archive

class EvidenceArchiveTests(unittest.TestCase):
    def test_body_restores_and_reference_only_missing_body_rejects(self):
        with tempfile.TemporaryDirectory() as name:
            root = Path(name)
            raw = b'{"id":"one","verdict":"finding","rationale":"Actual judgment"}\n'
            row = dict(path='judgments.jsonl', sha256=hashlib.sha256(raw).hexdigest())
            (root / row['path']).write_bytes(raw)
            archive.pack(root, dict(files=[row]), root / 'saved')
            self.assertEqual(archive.verify(root / 'saved'), 1)
            (root / row['path']).unlink()
            with self.assertRaisesRegex(ValueError, 'Missing actual evidence body'):
                archive.pack(root, dict(files=[row]), root / 'reference-only')
            self.assertFalse((root / 'reference-only').exists())
            self.assertEqual(archive.verify(root / 'saved'), 1)

    def test_changed_body_rejects_before_publication(self):
        with tempfile.TemporaryDirectory() as name:
            root = Path(name)
            (root / 'body').write_bytes(b'changed')
            with self.assertRaisesRegex(ValueError, 'Evidence body changed'):
                archive.pack(root, dict(files=[dict(path='body', sha256='0'*64)]), root / 'saved')
            self.assertFalse((root / 'saved').exists())

if __name__ == '__main__':
    unittest.main()
