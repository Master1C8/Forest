"""Cache identity regression; decoder is mocked, actual decoder is checked on SW."""
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch
import forest_macos as native

class SourceCacheTests(unittest.TestCase):
    def test_current_cache_reuses_and_modified_body_rejects_at_body_boundary(self):
        with tempfile.TemporaryDirectory() as name:
            root=Path(name);source=root/'bundle';source.write_bytes(b'original bundle')
            codec=root/'codec';codec.write_bytes(b'pinned decoder');target=root/'original.asset'
            def extract(argv,check):
                self.assertTrue(check);Path(argv[-1]).write_bytes(b'verified serialized member')
            with patch.object(native.subprocess,'run',side_effect=extract) as decoder:
                native.verified_source_asset(source,target,codec)
                self.assertEqual(target.read_bytes(),b'verified serialized member')
                native.verified_source_asset(source,target,codec)
                self.assertEqual(decoder.call_count,1)
                target.write_bytes(b'foreign cached bytes')
                with self.assertRaisesRegex(AssertionError,'serialized-source-cache-body-drift'):
                    native.verified_source_asset(source,target,codec)
                self.assertEqual(decoder.call_count,1)

    def test_changed_source_rejects_before_decoder_or_output_mutation(self):
        with tempfile.TemporaryDirectory() as name:
            root=Path(name);source=root/'bundle';source.write_bytes(b'original bundle')
            codec=root/'codec';codec.write_bytes(b'pinned decoder');target=root/'original.asset'
            with patch.object(native.subprocess,'run',side_effect=lambda argv,check:Path(argv[-1]).write_bytes(b'asset')):
                native.verified_source_asset(source,target,codec)
            source.write_bytes(b'different source')
            with patch.object(native.subprocess,'run') as decoder:
                with self.assertRaisesRegex(AssertionError,'serialized-source-cache-input-drift'):
                    native.verified_source_asset(source,target,codec)
                decoder.assert_not_called()
                self.assertEqual(target.read_bytes(),b'asset')

if __name__=='__main__':unittest.main()
