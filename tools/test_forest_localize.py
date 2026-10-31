"""Input and publication regressions; real resource readbacks run separately.

These small fixtures exercise data validation, exact writes, first-application
postconditions, continuation and conflict rejection. They do not simulate Unity
or establish runtime, font, editorial or game behavior.
"""
import copy
import json
from pathlib import Path
import tempfile
import unittest

from forest_localization import core as c


class LanguageCompilerTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(dir=c.ROOT/'dist', prefix='localizer-test-')
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)
        self.frameworks = self.root/'frameworks'
        folder = self.frameworks/'fixture'; folder.mkdir(parents=True)
        self.catalog = [dict(id='label', source='Source', baseline='Target', selectors=[])]
        for name, data in {'base/a.bin':b'first', 'base/b.bin':b'second', 'catalog.json':c.encode(self.catalog)}.items():
            c.write_new(folder/name, data)
        self.f = dict(format='forest-framework-v1', id='fixture', gameVersion='0.45',
                      resources=['a.bin', 'b.bin'],
                      files={p.relative_to(folder).as_posix():c.binding(p) for p in folder.rglob('*') if p.is_file()})
        c.write_new(folder/'framework.json', c.encode(self.f))
        self.doc = c.language_document(self.f, c.binding(folder/'framework.json')['sha256'], self.catalog, 'ru', 'ru-RU', {'label':'Target'})
        self.language = self.root/'language.json'
        self.save()
        self.out = self.root/'result'

    def save(self):
        self.language.write_bytes(c.encode(self.doc))

    def test_exact_first_apply_check_and_conflict(self):
        result = c.compile_language(self.language, self.out, self.frameworks)
        self.assertTrue(result['passed'])
        self.assertEqual((self.out/c.DATA_NAME/'a.bin').read_bytes(), b'first')
        self.assertEqual((self.out/c.DATA_NAME/'b.bin').read_bytes(), b'second')
        self.assertEqual(set(c.read(self.out/'manifest.json')['files']), {c.DATA_NAME+'/a.bin', c.DATA_NAME+'/b.bin'})
        c.compile_language(self.language, self.out, self.frameworks, 'check')
        (self.out/c.DATA_NAME/'a.bin').write_bytes(b'wrong')
        with self.assertRaisesRegex(ValueError, 'conflicting-output:'):
            c.compile_language(self.language, self.out, self.frameworks, 'check')

    def test_resume_actual_partial_and_reject_changed_input(self):
        with self.assertRaisesRegex(RuntimeError, 'injected-publication-interruption'):
            c.compile_language(self.language, self.out, self.frameworks, fail_after=1)
        self.assertFalse((self.out/'manifest.json').exists())
        self.assertTrue((self.out/c.DATA_NAME/'a.bin').exists())
        self.assertFalse((self.out/c.DATA_NAME/'b.bin').exists())
        c.compile_language(self.language, self.out, self.frameworks, 'resume')
        self.assertEqual((self.out/c.DATA_NAME/'b.bin').read_bytes(), b'second')
        self.doc['culture'] = 'ru'; self.save()
        with self.assertRaisesRegex(ValueError, 'partial-output-different-input'):
            c.compile_language(self.language, self.out, self.frameworks, 'resume')

    def test_null_is_unread_and_empty_is_explicit(self):
        self.doc['translations']['label']['target'] = None; self.save()
        self.assertEqual(c.load_language(self.language, self.frameworks)[-1], ['label'])
        with self.assertRaisesRegex(ValueError, 'untranslated-targets:1'):
            c.compile_language(self.language, self.out, self.frameworks)
        self.assertFalse(self.out.exists())
        self.doc['translations']['label']['target'] = ''; self.save()
        self.assertEqual(c.load_language(self.language, self.frameworks)[-1], [])

    def test_exact_ids_and_source(self):
        self.doc['translations']['unknown'] = dict(source='Source', target='Target'); self.save()
        with self.assertRaisesRegex(ValueError, 'complete-exact-translation-ids'):
            c.load_language(self.language, self.frameworks)
        del self.doc['translations']['unknown']
        self.doc['translations']['label']['source'] = 'Wrong'; self.save()
        with self.assertRaisesRegex(ValueError, 'immutable-source:label'):
            c.load_language(self.language, self.frameworks)

    def test_duplicate_json_source_is_rejected(self):
        self.language.write_text('{"format":"one","format":"two"}')
        with self.assertRaisesRegex(ValueError, 'duplicate-json-key:format'):
            c.read(self.language)

    def test_framework_drift_rejected(self):
        (self.frameworks/'fixture/base/a.bin').write_bytes(b'changed')
        with self.assertRaisesRegex(ValueError, 'framework-file-changed:base/a.bin'):
            c.load_language(self.language, self.frameworks)

    def test_output_escape_and_unknown_render_role(self):
        with self.assertRaisesRegex(ValueError, 'output-must-be-new-project-dist-child'):
            c.compile_language(self.language, c.ROOT/'localization/forbidden', self.frameworks)
        self.doc['layout']['unknown'] = 9; self.save()
        with self.assertRaisesRegex(ValueError, 'unregistered-layout-role'):
            c.load_language(self.language, self.frameworks)

    def test_haiku_display_and_evaluation_must_agree(self):
        folder = self.frameworks/'fixture'
        catalog = [dict(id='display', source='Choice', baseline='Answer', selectors=[]),
                   dict(id='evaluation', source='Choice', baseline='Answer', selectors=[dict(kind='managed',
                       method='System.String Adapter::VNRevivalRuHaiku_Resolve(System.String)', asset='a.dll', index=1)])]
        (folder/'catalog.json').write_bytes(c.encode(catalog))
        self.f['files']['catalog.json'] = c.binding(folder/'catalog.json')
        (folder/'framework.json').write_bytes(c.encode(self.f))
        self.doc = c.language_document(self.f, c.binding(folder/'framework.json')['sha256'], catalog,
                                      'de', 'de-DE', {'display':'Same', 'evaluation':'Same'})
        self.save()
        self.assertEqual(c.load_language(self.language, self.frameworks)[-1], [])
        self.doc['translations']['evaluation']['target'] = 'Different'; self.save()
        with self.assertRaisesRegex(ValueError, 'haiku-display-evaluation-identity:'):
            c.load_language(self.language, self.frameworks)

    def test_placeholder_binding_has_matching_positive_control(self):
        folder = self.frameworks/'fixture'
        catalog = [dict(id='label', source='Source {0}', baseline='Target {0}', selectors=[])]
        (folder/'catalog.json').write_bytes(c.encode(catalog))
        self.f['files']['catalog.json'] = c.binding(folder/'catalog.json')
        (folder/'framework.json').write_bytes(c.encode(self.f))
        self.doc = c.language_document(self.f, c.binding(folder/'framework.json')['sha256'], catalog,
                                      'de', 'de-DE', {'label':'Different {0}'})
        self.save()
        self.assertEqual(c.load_language(self.language, self.frameworks)[-1], [])
        self.doc['translations']['label']['target'] = 'Different'; self.save()
        with self.assertRaisesRegex(ValueError, 'placeholder-binding:label'):
            c.load_language(self.language, self.frameworks)

    def test_dialogue_control_guard_accepts_latin_and_rejects_actual_control_loss(self):
        guard = c.module(c.ROOT/'localization/ru-assets/inline_guard.py', 'test_language_controls')
        row = dict(id='fixture', source='[pic=1]Hello 2\nNext')
        c.validate_dialogue(guard, row, '[pic=1]Hallo 2\nWeiter')
        with self.assertRaisesRegex(ValueError, 'dialogue-protected-controls:fixture'):
            c.validate_dialogue(guard, row, 'Hallo 2\nWeiter')
        with self.assertRaisesRegex(ValueError, 'dialogue-numbers:fixture'):
            c.validate_dialogue(guard, row, '[pic=1]Hallo 3\nWeiter')
        with self.assertRaisesRegex(ValueError, 'dialogue-separator:fixture'):
            c.validate_dialogue(guard, row, '[pic=1]Hallo 2 Weiter')


if __name__ == '__main__':
    unittest.main()
