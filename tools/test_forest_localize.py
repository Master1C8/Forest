"""Input and publication regressions; real resource readbacks run separately.

These small fixtures exercise data validation, exact writes, first-application
postconditions, continuation and conflict rejection. They do not simulate Unity
or establish runtime, font, editorial or game behavior.
"""
import copy
import json
from pathlib import Path
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import patch

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

    def test_dynamic_quest_sizes_require_exact_framework_and_resource(self):
        digest = '26cf1b28a0d9877a21367d7426571a382f349ed24ab9a8d2ab8b2107e285298f'
        framework = dict(id='forest045-shared-v2', layoutRoles={}, files={
            'base/sharedassets0.assets': dict(sha256='0b16874d428172d176f35e067d481fd601c8cc77d4c0a7f0b97d0450c2940086'),
            'base/sharedassets2.assets': dict(sha256='bb67ae2f0b2eba4fab082b402aa31fdcc016b904689495e878cc801dac10aafd')})
        roles = c.registered_layout_roles(framework, digest)
        self.assertEqual(len(roles), 30)
        self.assertEqual(roles['sharedassets2.assets:18315']['baseline'], 14)
        self.assertEqual(roles['sharedassets2.assets:18716'], dict(
            asset='sharedassets2.assets', pathId=18716,
            pointer='/m_FontData/m_FontSize', baseline=10))
        self.assertEqual(framework['layoutRoles'], {})
        self.assertEqual(roles['sharedassets2.assets:18707']['baseline'],12)
        self.assertEqual(roles['sharedassets0.assets:4545']['baseline'],14)
        self.assertEqual(c.registered_layout_roles(framework, 'different'), {})
        framework['files']['base/sharedassets2.assets']['sha256'] = 'changed'
        with self.assertRaisesRegex(ValueError, 'quest-template-resource-version'):
            c.registered_layout_roles(framework, digest)
        framework['files']['base/sharedassets2.assets']['sha256']='bb67ae2f0b2eba4fab082b402aa31fdcc016b904689495e878cc801dac10aafd'
        framework['files']['base/sharedassets0.assets']['sha256']='changed'
        with self.assertRaisesRegex(ValueError,'speaker-template-resource-version'):
            c.registered_layout_roles(framework,digest)
        self.doc['layout'] = {'sharedassets2.assets:18315': 12}; self.save()
        with self.assertRaisesRegex(ValueError, 'unregistered-layout-role'):
            c.load_language(self.language, self.frameworks)

    def test_native_catalog_keeps_unchanged_baseline_field_and_rejects_overlap(self):
        selector = dict(kind='field', asset='a.bin', pathId=3, pointer='/m_text')
        row = dict(id='a.bin:3/m_text', source='Inventory', selector=selector)
        values = {('a.bin', 3, '/m_text'):'Inventory'}
        extended = c.native_additions(self.catalog, [row], values, values)
        self.assertEqual(len(extended), 2)
        self.assertEqual(extended[0]['source'], extended[0]['baseline'])
        self.assertEqual(self.catalog, [dict(id='label', source='Source', baseline='Target', selectors=[])])
        with self.assertRaisesRegex(ValueError, 'native-addition-overlap:'):
            c.native_additions(extended, [row], values, values)
        row['id'] = 'a.bin:4/m_text'; row['selector']['pathId'] = 4
        values = {('a.bin', 4, '/m_text'):'Different'}
        with self.assertRaisesRegex(ValueError, 'native-addition-source:'):
            c.native_additions(self.catalog, [row], values, values)

    def test_saved_plan_wording_preserves_identity_and_leaves_ambiguity_unread(self):
        self.doc['translations'] = {
            'speaker':dict(source='Mouse', target=None),
            'unknown':dict(source='Mouse', target=None)}
        self.save()
        plan = self.root/'saved-plan.json'
        c.write_new(plan, c.encode(dict(edits=[
            dict(id='speaker', source='Mouse', target='Ratón'),
            dict(id='other', source='Mouse', target='Ratona')])))
        output = self.root/'merged.json'
        result = c.merge_wording(self.language, [plan], output)
        self.assertEqual(result['filled'], 1)
        self.assertEqual(c.read(output)['translations']['speaker']['target'], 'Ratón')
        self.assertIsNone(c.read(output)['translations']['unknown']['target'])

    def test_native_extension_resumes_real_partial_publication(self):
        # Unity decoding is replaced here; file publication/resume is real.
        folder = self.frameworks/'fixture'
        original = self.root/'source'; original.mkdir()
        (original/'a.bin').write_bytes(b'first')
        self.f['sourceMembers'] = {'a.bin':c.binding(original/'a.bin')}
        (folder/'framework.json').write_bytes(c.encode(self.f))
        packet = self.root/'native.jsonl'
        packet.write_text(json.dumps(dict(id='a.bin:3/m_text', source='Inventory',
            selector=dict(kind='field', asset='a.bin', pathId=3, pointer='/m_text'))) + '\n')
        generator = lambda _:SimpleNamespace(load_local_dll_folder=lambda _:None)
        engines = (SimpleNamespace(load=lambda _:SimpleNamespace()), generator,
            lambda obj, _:obj, None,
            SimpleNamespace(objects=lambda _:{3:{'m_text':'Inventory'}}), None, None)
        output = self.frameworks/'extended'; write = c.write_new; calls = []
        def interrupted(path, data):
            calls.append(path)
            if len(calls) == 3:
                raise RuntimeError('injected-native-publication-interruption')
            write(path, data)
        with patch.object(c, 'engines', return_value=engines):
            with patch.object(c, 'write_new', side_effect=interrupted):
                with self.assertRaisesRegex(RuntimeError, 'injected-native-publication-interruption'):
                    c.extend_native_framework(folder, original, packet, output, 'extended')
            self.assertFalse((output/'framework.json').exists())
            partial = {p.relative_to(output):p.read_bytes() for p in output.rglob('*') if p.is_file()}
            self.assertGreater(len(partial), 1)
            c.extend_native_framework(folder, original, packet, output, 'extended', resume=True)
        for name, data in partial.items():
            self.assertEqual((output/name).read_bytes(), data)
        self.assertEqual(len(c.framework_manifest(output)[1]), 2)
        self.assertEqual((folder/'base/a.bin').read_bytes(), b'first')

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
        with self.assertRaisesRegex(ValueError, 'dialogue-protected-controls:fixture'):
            c.validate_dialogue(guard, row, '[pic=2]Hallo 2\nWeiter')
        with self.assertRaisesRegex(ValueError, 'dialogue-separator:fixture'):
            c.validate_dialogue(guard, row, '[pic=1]Hallo 2 Weiter')

    def test_visible_numbers_allow_natural_target_spelling_but_command_operands_stay_exact(self):
        guard = c.module(c.ROOT/'localization/ru-assets/inline_guard.py', 'test_prose_numbers')
        row = dict(id='quantity', source='[pic=3]2 copies for each issue!')
        c.validate_dialogue(guard, row, '[pic=3]Od každého dva výtisky!')
        c.validate_dialogue(guard, row, '[pic=3]۲ نسخه از هر شماره!')
        with self.assertRaisesRegex(ValueError, 'dialogue-protected-controls:quantity'):
            c.validate_dialogue(guard, row, '[pic=2]Od každého dva výtisky!')
        with self.assertRaisesRegex(ValueError, 'dialogue-protected-controls:quantity'):
            c.validate_dialogue(guard, row, 'Od každého dva výtisky!')


if __name__ == '__main__':
    unittest.main()
