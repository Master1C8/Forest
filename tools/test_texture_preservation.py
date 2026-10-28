"""Whole-byte rejection controls. Does not replace actual package verification."""
import hashlib
import json
from pathlib import Path
import unittest

import UnityPy
from verify_texture_preservation import compare, ROOT

SOURCE = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')


class TextureBoundary(unittest.TestCase):
    def test_actual_empty_atlas_metadata_change_rejected(self):
        inventory = json.loads((ROOT / 'assets/source-v2/objects.json').read_text())
        row = next(r for r in inventory if r['id'] == 'resources.assets:74')
        env = UnityPy.load(str(SOURCE / 'resources.assets'))
        raw = next(o for o in env.objects if o.path_id == 74).get_raw_data()
        expected = {74: (row['bytes'], row['rawSha256'])}
        actual = {74: (len(raw), hashlib.sha256(raw).hexdigest())}
        compare(expected, actual, 'texture-object')
        altered = bytes([raw[0] ^ 1]) + raw[1:]
        with self.assertRaisesRegex(AssertionError, 'texture-object-bytes'):
            compare(expected, {74: (len(altered), hashlib.sha256(altered).hexdigest())}, 'texture-object')

    def test_complete_external_stream_change_and_identity_rejected(self):
        files = json.loads((ROOT / 'assets/source-v2/source-files.json').read_text())
        name = min((n for n in files if n.lower().endswith('.ress') and files[n]['bytes'] > 0), key=lambda n: files[n]['bytes'])
        raw = (SOURCE / name).read_bytes()
        expected = {name: files[name]['sha256']}
        compare(expected, {name: hashlib.sha256(raw).hexdigest()}, 'external-stream')
        altered = bytes([raw[0] ^ 1]) + raw[1:]
        with self.assertRaisesRegex(AssertionError, 'external-stream-bytes'):
            compare(expected, {name: hashlib.sha256(altered).hexdigest()}, 'external-stream')
        with self.assertRaisesRegex(AssertionError, 'external-stream-identity-set'):
            compare(expected, {}, 'external-stream')


if __name__ == '__main__':
    unittest.main()
