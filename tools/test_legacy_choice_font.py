"""Font-binding safety and actual embedded-face coverage, not visual acceptance."""
import copy
from pathlib import Path
import unittest

from legacy_choice_font import CHOICE_SAMPLES, RUSSIAN, coverage, rebind_label

ROOT = Path(__file__).resolve().parents[1]


class LegacyChoiceFont(unittest.TestCase):
    def setUp(self):
        self.original = {'m_Material': {'m_FileID': 0, 'm_PathID': 0},
                         'm_FontData': {'m_Font': {'m_FileID': 0, 'm_PathID': 367},
                                        'm_FontSize': 12, 'm_Alignment': 3, 'm_RichText': 1},
                         'm_Text': 'The love. Definitely the love.', 'm_Color': {'a': 1.0}}

    def test_only_pointer_changes_and_source_is_immutable(self):
        before = copy.deepcopy(self.original)
        got = rebind_label(self.original, 367, 369)
        self.assertEqual(self.original, before)
        self.assertEqual(got['m_FontData']['m_Font']['m_PathID'], 369)
        got['m_FontData']['m_Font']['m_PathID'] = 367
        self.assertEqual(got, before)

    def test_cross_file_wrong_font_and_already_rebound_are_rejected(self):
        for ref in [{'m_FileID': 1, 'm_PathID': 367},
                    {'m_FileID': 0, 'm_PathID': 368}, {'m_FileID': 0, 'm_PathID': 369}]:
            with self.subTest(ref=ref):
                self.original['m_FontData']['m_Font'] = ref
                with self.assertRaisesRegex(AssertionError, 'font binding'):
                    rebind_label(self.original, 367, 369)

    def test_unreviewed_material_and_size_rejected_with_matching_control(self):
        rebind_label(self.original, 367, 369)
        self.original['m_Material']['m_PathID'] = 4
        with self.assertRaisesRegex(AssertionError, 'Explicit material'):
            rebind_label(self.original, 367, 369)
        self.original['m_Material']['m_PathID'] = 0
        self.original['m_FontData']['m_FontSize'] = 10
        with self.assertRaisesRegex(AssertionError, 'font size'):
            rebind_label(self.original, 367, 369)

    def test_real_bundled_outline_covers_full_russian_and_both_mark_samples(self):
        data = (ROOT / 'assets/source-v2/fonts/90744c19ec-resources.assets-439.font').read_bytes()
        got = coverage({'m_FontData': data, 'm_Name': 'LiberationSans'},
                       RUSSIAN + ''.join(CHOICE_SAMPLES.values()))
        self.assertEqual(got['missingRussianLetters'], '')
        self.assertTrue(all(got['characters'].values()))
        self.assertEqual(got['family'], 'Liberation Sans')
        self.assertEqual(got['spaceAdvance'], 569)
        self.assertEqual(got['unitsPerEm'], 2048)


if __name__ == '__main__':
    unittest.main()
