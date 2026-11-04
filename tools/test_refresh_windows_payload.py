import hashlib
import io
import json
from pathlib import Path
import tempfile
import unittest
import zipfile
from refresh_windows_payload import assemble, verify, publish, literal_segments


class RefreshTests(unittest.TestCase):
    def test_refresh_and_retained_base(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp); old = root / 'old.zip'; new = root / 'new.zip'
            body = b'new localized heading'; key = hashlib.sha256(body).hexdigest()
            manifest = dict(locales=[dict(files=[dict(storageSha256=key, storageBytes=len(body),
                segments=[dict(blob=key, base=-1, offset=0, bytes=len(body))])]),
                dict(files=[dict(storageSha256=hashlib.sha256(b'original').hexdigest(), storageBytes=8,
                segments=[dict(blob=None, base=0, offset=0, bytes=8)])])])
            with zipfile.ZipFile(old, 'w') as z:
                z.writestr('unreferenced', b'unused')
            before = old.read_bytes()
            self.assertEqual(assemble(old, new, manifest, {key: body}, [b'original']), 1)
            self.assertEqual(old.read_bytes(), before)
            with zipfile.ZipFile(new) as z:
                self.assertEqual(set(z.namelist()), {'chunks/' + key, 'manifest.json'})
                verify(z, manifest, [b'original'])

    def test_bad_hash_preserves_source(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp); old = root / 'old.zip'
            with zipfile.ZipFile(old, 'w') as z:
                z.writestr('chunks/' + 'a'*64, b'corrupt')
            before = old.read_bytes()
            manifest = dict(locales=[dict(files=[dict(segments=[dict(blob='a'*64)])])])
            with self.assertRaisesRegex(ValueError, 'stored blob hash mismatch'):
                assemble(old, root/'new.zip', manifest, {}, [])
            self.assertEqual(old.read_bytes(), before)

    def test_negative_base_cannot_wrap(self):
        manifest = dict(locales=[dict(files=[dict(storageSha256='unused', storageBytes=1,
            segments=[dict(blob=None, base=-1, offset=0, bytes=1)])])])
        with zipfile.ZipFile(io.BytesIO(), 'w') as z:
            with self.assertRaisesRegex(ValueError, 'base span out of bounds'):
                verify(z, manifest, [b'positive control data'])

    def test_installer_segment_limit(self):
        body = b'x' * 65537; literals = {}; segments = literal_segments(body, literals)
        self.assertEqual([s['bytes'] for s in segments], [65536, 1])
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp); old = root/'old.zip'
            with zipfile.ZipFile(old, 'w'):
                pass
            resource = dict(storageSha256=hashlib.sha256(body).hexdigest(), storageBytes=len(body), segments=segments)
            manifest = dict(locales=[dict(files=[resource])])
            assemble(old, root/'good.zip', manifest, literals, [])
            key = hashlib.sha256(body).hexdigest()
            resource['segments'] = [dict(blob=key, base=-1, offset=0, bytes=len(body))]
            with self.assertRaisesRegex(ValueError, 'invalid recipe segment'):
                assemble(old, root/'bad.zip', manifest, {key: body}, [])

    def test_publication_boundary_and_old_triplet_recovery(self):
        for point in ['archive', 'manifest', None]:
            with self.subTest(point=point), tempfile.TemporaryDirectory() as tmp:
                work = Path(tmp); source = work/'ForestLanguages.zip'; candidate = work/'candidate.zip'
                source.write_bytes(b'old archive'); candidate.write_bytes(b'new archive')
                previous_sha = hashlib.sha256(source.read_bytes()).hexdigest()
                old_manifest = b'{"old":true}'; old_receipt = json.dumps(dict(sha256=previous_sha)).encode()
                (work/'payload-manifest.json').write_bytes(old_manifest)
                (work/'payload-receipt.json').write_bytes(old_receipt)
                pin = dict(sha256=hashlib.sha256(candidate.read_bytes()).hexdigest())
                if point:
                    with self.assertRaisesRegex(RuntimeError, 'after ' + point):
                        publish(source, candidate, dict(new=True), pin, work, previous_sha, point)
                    self.assertEqual((work/'payload-receipt.json').read_bytes(), old_receipt)
                    self.assertNotEqual(hashlib.sha256(source.read_bytes()).hexdigest(), previous_sha)
                else:
                    publish(source, candidate, dict(new=True), pin, work, previous_sha)
                    self.assertEqual(json.loads((work/'payload-receipt.json').read_bytes()), pin)
                backup = work/('payload-before-refresh-' + previous_sha)
                self.assertEqual((backup/source.name).read_bytes(), b'old archive')
                self.assertEqual((backup/'payload-manifest.json').read_bytes(), old_manifest)
                self.assertEqual((backup/'payload-receipt.json').read_bytes(), old_receipt)
