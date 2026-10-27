"""Regression for confusing the active dialogue subset with all target locales."""
import copy
import json
import unittest
from pathlib import Path

from build_supplemental_ui import OUT, validate_locale_scope


class LocaleScopeTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.scope = json.loads((OUT / 'locale-scope.json').read_text())
        cls.catalog = Path(cls.scope['catalog']['path']).read_bytes()

    def test_actual_canonical_30_targets(self):
        targets = validate_locale_scope(self.scope, self.catalog)
        self.assertEqual(len(targets), 30)
        self.assertIn('ru', targets)
        self.assertIn('es', targets)
        self.assertIn('es-419', targets)
        self.assertNotIn('en', targets)

    def test_active_subset_cannot_claim_full_scope(self):
        bad = copy.deepcopy(self.scope)
        bad['targetLocales'] = bad['activeDialogueSubset']
        bad['targetCount'] = len(bad['targetLocales'])
        with self.assertRaisesRegex(AssertionError, 'target-locale-count'):
            validate_locale_scope(bad, self.catalog)

    def test_same_count_unknown_locale_rejected_by_catalog(self):
        bad = copy.deepcopy(self.scope)
        bad['targetLocales'][-1] = 'xx'
        # Keep glossary coverage satisfied so only the canonical scope differs.
        bad['approvedGlossaries']['locales']['xx'] = bad['approvedGlossaries']['locales'].pop('he')
        with self.assertRaisesRegex(AssertionError, 'canonical-target-locale-coverage'):
            validate_locale_scope(bad, self.catalog)

    def test_missing_approved_glossary_has_own_reason(self):
        bad = copy.deepcopy(self.scope)
        del bad['approvedGlossaries']['locales']['he']
        with self.assertRaisesRegex(AssertionError, 'approved-glossary-locale-coverage'):
            validate_locale_scope(bad, self.catalog)

    def test_changed_catalog_is_not_silently_admitted(self):
        with self.assertRaisesRegex(AssertionError, 'canonical-locale-catalog-pin'):
            validate_locale_scope(self.scope, self.catalog + b'\n')


if __name__ == '__main__':
    unittest.main()
