"""Real face tables and saved Forest templates; no native rendering claim."""
import copy
import sys
import unittest

from forest_localization import core
from forest_localization import font_metrics as fm


class FontMetricTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        folder = core.ROOT/'localization/framework/forest045-shared-v2'
        U, Generator, tree, _, composer, _, _ = core.engines()
        gen = Generator('2020.3.24f1'); gen.load_local_dll_folder(str(folder/'references'))
        env = U.load(str(folder/'base/resources.assets')); env.path = str(folder/'base')
        obs = composer.objects(env)
        cls.native = tree(obs[439], gen)
        cls.tmp = tree(obs[1017], gen)
        cls.data = (core.ROOT/'localization/fonts/noto-cjk/NotoSansCJKjp-Regular.otf').read_bytes()
        cls.metrics = fm.face_metrics(cls.data, 'Noto Sans CJK JP')

    def test_real_japanese_face_and_exact_previously_verified_face_info(self):
        result = fm.tmp_font(self.tmp, self.metrics, 439, 'face.otf')
        old = core.read(core.ROOT/'outputs/locale-assets-20261026/ja/workflow-v3-completion-20261030/0127-work/saved-font-resources.json')
        # The old report may wrap individual resources; find its exact face once.
        def faces(value):
            if isinstance(value, dict):
                if value.get('m_FamilyName') == 'Noto Sans CJK JP':
                    yield value
                for v in value.values():
                    yield from faces(v)
            elif isinstance(value, list):
                for v in value:
                    yield from faces(v)
        expected = list(faces(old))
        self.assertTrue(expected)
        self.assertIn(result['m_FaceInfo'], expected)
        for key in self.tmp:
            if key not in {'m_FaceInfo', 'm_fontInfo', 'm_SourceFontFileGUID', 'm_CreationSettings'}:
                self.assertEqual(result[key], self.tmp[key], key)
        self.assertEqual(self.tmp['m_FaceInfo']['m_FamilyName'], 'Liberation Sans')

    def test_native_face_metrics_and_stale_kerning_removed(self):
        result = fm.native_font(self.native, self.data, self.metrics)
        self.assertEqual(bytes(result['m_FontData']), self.data)
        self.assertEqual(result['m_Ascent'], fm.f32(16 * 1160 / 1000))
        self.assertEqual(result['m_Descent'], fm.f32(16 * -288 / 1000))
        self.assertEqual(result['m_LineSpacing'], fm.f32(16 * 1448 / 1000))
        self.assertEqual(result['m_KerningValues'], [])
        for key in self.native:
            if key not in {'m_FontData', 'm_FontNames', 'm_LineSpacing', 'm_Ascent', 'm_Descent', 'm_KerningValues'}:
                self.assertEqual(result[key], self.native[key], key)

    def test_wrong_source_static_and_nonempty_cache_reject_at_intended_boundary(self):
        self.assertEqual(fm.tmp_font(self.tmp, self.metrics, 439, 'face.otf')['m_SourceFontFile'], self.tmp['m_SourceFontFile'])
        cases = [('m_SourceFontFile', dict(m_FileID=0, m_PathID=438), 'exact-dynamic-source-route'),
                 ('m_AtlasPopulationMode', 0, 'dynamic-tmp-font-required'),
                 ('m_GlyphTable', [{'glyph':1}], 'empty-dynamic-tmp-caches-required'),
                 ('m_FontFeatureTable', {'m_GlyphPairAdjustmentRecords':[{}]}, 'empty-dynamic-tmp-feature-caches-required')]
        for key, value, reason in cases:
            with self.subTest(key=key):
                template = copy.deepcopy(self.tmp); template[key] = value
                with self.assertRaisesRegex(ValueError, reason):
                    fm.tmp_font(template, self.metrics, 439, 'face.otf')

    def test_native_cached_face_rejects(self):
        template = copy.deepcopy(self.native); template['m_CharacterRects'] = [{}]
        with self.assertRaisesRegex(ValueError, 'empty-dynamic-native-font-required'):
            fm.native_font(template, self.data, self.metrics)

    def test_actual_family_and_chinese_face_regression(self):
        with self.assertRaisesRegex(ValueError, 'actual-font-family'):
            fm.face_metrics(self.data, 'Unrelated Font')
        data = (core.ROOT/'localization/fonts/noto-cjk/NotoSansCJKsc-Regular.otf').read_bytes()
        metrics = fm.face_metrics(data, 'Noto Sans CJK SC')
        result = fm.tmp_font(self.tmp, metrics, 439, 'face.otf')
        self.assertEqual(result['m_FaceInfo']['m_FamilyName'], 'Noto Sans CJK SC')
        self.assertGreater(result['m_FaceInfo']['m_TabWidth'], 0)
        self.assertEqual(result['m_AtlasTextures'], self.tmp['m_AtlasTextures'])


if __name__ == '__main__':
    unittest.main()
