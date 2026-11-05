"""Archive integrity boundaries with matching outer receipts in every case."""
import hashlib
import json
from pathlib import Path
import struct
import tempfile
import unittest
import zipfile
from verify_installer_delivery import ROOT, verify


class DeliveryIntegrityTests(unittest.TestCase):
    def setUp(self):
        (ROOT / 'dist').mkdir(exist_ok=True)
        self.payload = tempfile.TemporaryDirectory(prefix='integrity-payload-', dir=ROOT / 'dist')
        self.metadata = tempfile.TemporaryDirectory(prefix='integrity-receipts-', dir=ROOT / 'dist')
        self.addCleanup(self.payload.cleanup)
        self.addCleanup(self.metadata.cleanup)
        self.folder = Path(self.payload.name)
        self.scratch = Path(self.metadata.name)
        (self.folder / 'data.bin').write_bytes(b'good')

    def check_archive(self, body=b'good', missing=False, sidecar=False):
        archive = self.scratch / 'delivery.zip'
        with zipfile.ZipFile(archive, 'x') as z:
            if not missing:
                z.writestr(self.folder.name + '/data.bin', body)
            if sidecar:
                # Valid AppleDouble header, associated with an absent member.
                z.writestr(self.folder.name + '/._unknown.bin',
                           struct.pack('>II', 0x00051607, 0x00020000) + bytes(18))
        receipt = self.scratch / 'receipt.json'
        receipt.write_text(json.dumps(dict(artifact=str(archive.relative_to(ROOT)),
            bytes=archive.stat().st_size, sha256=hashlib.sha256(archive.read_bytes()).hexdigest(), sourcePins={})))
        verify(receipt, self.folder, self.scratch / 'result.json', sidecar)

    def test_matching_member(self):
        self.check_archive()

    def test_member_hash_after_matching_outer_hash(self):
        with self.assertRaisesRegex(AssertionError, 'Archive member differs'):
            self.check_archive(body=b'evil')

    def test_missing_member_after_matching_outer_hash(self):
        with self.assertRaisesRegex(AssertionError, 'Incomplete delivered inventory'):
            self.check_archive(missing=True)

    def test_unassociated_metadata_after_matching_outer_hash(self):
        with self.assertRaisesRegex(AssertionError, 'Unassociated AppleDouble metadata'):
            self.check_archive(sidecar=True)


if __name__ == '__main__':
    unittest.main()
