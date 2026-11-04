import unittest
import hashlib
from pathlib import Path
import tempfile
from forest_inventory_headings import validate_language, validate_packed_sources


class HeadingGuardTests(unittest.TestCase):
    def test_non_cyrillic_translation_passes(self):
        validate_language(dict(translations={'heading': dict(source='<size=22>I</size>NVENTORY',
            target='<size=22>I</size>NVENTAR')}), {'heading': '<size=22>I</size>NVENTORY'})

    def test_missing_selector_rejected(self):
        with self.assertRaisesRegex(ValueError, 'missing inventory heading selector'):
            validate_language(dict(translations={}), {'heading': 'INVENTORY'})

    def test_null_and_source_fallback_rejected(self):
        for target in [None, '', 'INVENTORY']:
            with self.subTest(target=target), self.assertRaisesRegex(ValueError, 'untranslated inventory heading'):
                validate_language(dict(translations={'heading': dict(source='INVENTORY', target=target)}),
                                  {'heading': 'INVENTORY'})

    def test_pack_must_match_current_source_and_exact_catalog(self):
        with tempfile.TemporaryDirectory() as tmp:
            p = Path(tmp)/'de.json'; p.write_bytes(b'current source')
            row = dict(code='de', languageSha256=hashlib.sha256(p.read_bytes()).hexdigest())
            validate_packed_sources(dict(locales=[row]), {'de': p})
            with self.assertRaisesRegex(ValueError, 'packed locale catalog differs'):
                validate_packed_sources(dict(locales=[row, row]), {'de': p})
            p.write_bytes(b'corrected source')
            with self.assertRaisesRegex(ValueError, 'stale packed language: de'):
                validate_packed_sources(dict(locales=[row]), {'de': p})
