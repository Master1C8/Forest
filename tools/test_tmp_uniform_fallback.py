"""Original face coverage and resource preservation; native output is separate."""
import copy
import json
from pathlib import Path
import unittest
from tmp_uniform_fallback import uniform_fallback_primary

ROOT = Path(__file__).resolve().parents[1] / 'assets/source-v2'


class UniformFallback(unittest.TestCase):
    def setUp(self):
        self.original = json.loads((ROOT / 'trees/57009919ee-sharedassets0.assets-3323.json').read_text())
        self.fallback = json.loads((ROOT / 'trees/90744c19ec-resources.assets-1017.json').read_text())
        self.native = {'m_Name': 'LiberationSans', 'm_FontData': (ROOT / 'fonts/90744c19ec-resources.assets-439.font').read_bytes()}

    def test_original_168_characters_retained_without_atlas_or_material_changes(self):
        before = copy.deepcopy(self.original)
        result, receipt = uniform_fallback_primary(self.original, self.fallback, self.native)
        self.assertEqual(self.original, before)
        self.assertEqual(receipt['originalCharacterCount'], 168)
        self.assertTrue(all(receipt['originalCoverageRetained']['characters'].values()))
        self.assertEqual(result['m_AtlasPopulationMode'], 0)
        self.assertEqual(result['m_SourceFontFile'], {'m_FileID': 0, 'm_PathID': 0})
        changed = {'m_FaceInfo', 'm_GlyphTable', 'm_CharacterTable', 'm_glyphInfoList', 'm_fontInfo', 'm_FontFeatureTable', 'm_KerningTable'}
        self.assertEqual({k: v for k, v in result.items() if k not in changed}, {k: v for k, v in before.items() if k not in changed})
        self.assertEqual([r['m_Unicode'] for r in result['m_CharacterTable']], [95])
        self.assertEqual(result['m_CharacterTable'][0], next(r for r in before['m_CharacterTable'] if r['m_Unicode']==95))
        self.assertEqual(len(result['m_GlyphTable']), 1)
        self.assertGreater(result['m_FaceInfo']['m_LineHeight'], 0)

    def test_dynamic_primary_wrong_fallback_and_coverage_loss_rejected(self):
        uniform_fallback_primary(self.original, self.fallback, self.native)
        changed = copy.deepcopy(self.original)
        changed['m_AtlasPopulationMode'] = 1
        with self.assertRaisesRegex(AssertionError, 'must-be-static'):
            uniform_fallback_primary(changed, self.fallback, self.native)
        wrong = copy.deepcopy(self.fallback)
        wrong['m_SourceFontFile']['m_PathID'] = 369
        with self.assertRaisesRegex(AssertionError, 'fallback-source'):
            uniform_fallback_primary(self.original, wrong, self.native)
        changed = copy.deepcopy(self.original)
        changed['m_CharacterTable'].append(dict(changed['m_CharacterTable'][0], m_Unicode=0x10FFFF))
        with self.assertRaisesRegex(AssertionError, 'original-coverage-loss'):
            uniform_fallback_primary(changed, self.fallback, self.native)
        changed = copy.deepcopy(self.original)
        changed['m_CharacterTable'] = [r for r in changed['m_CharacterTable'] if r['m_Unicode']!=95]
        with self.assertRaisesRegex(AssertionError, 'underline-required'):
            uniform_fallback_primary(changed, self.fallback, self.native)


if __name__ == '__main__':
    unittest.main()
