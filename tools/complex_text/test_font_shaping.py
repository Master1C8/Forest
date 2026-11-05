"""Regression for the numeric-order defect observed in the native Arabic probe."""
import unittest
from pathlib import Path
from font_shaping import FontAugmenter, known_tag_sequence

ROOT = Path(__file__).resolve().parents[2]

class NumericOrdering(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.font = FontAugmenter(ROOT/'localization/fonts/complex-sources/NotoSansArabicLatin-Regular.ttf',
            dict(script='arab',language='ar',baseDirection='R',ranges=((0x0600,0x06FF),(0x0750,0x077F),(0x08A0,0x08FF))))

    def test_arabic_indic_digits_are_ltr_inside_rtl(self):
        shaped = self.font.shape_rich_text('العربية مع ١٢٣ و456')
        self.assertIn('١٢٣', shaped)  # Glyph preparation must retain logical numeric runs.
        self.assertIn('456', shaped)  # BidiOrder performs the single display compensation.
        self.assertFalse(any(self.font.is_script_character(c) for c in shaped))

    def test_pure_numeric_and_ltr_values_remain_unchanged(self):
        for value in ['١٢٣', 'Scarlett 12/34 — 2026-11-05', '123']:
            self.assertEqual(self.font.shape_rich_text(value),value)

    def test_tags_and_boundary_whitespace_survive(self):
        value='  <color=#88FFAA>العربية ١٢٣</color> <i>Latin</i>  '
        shaped=self.font.shape_rich_text(value)
        self.assertEqual(known_tag_sequence(value),known_tag_sequence(shaped))
        self.assertTrue(shaped.startswith('  ') and shaped.endswith('  '))

    def test_clusters_retain_logical_character_indices(self):
        for value in ['لا','مرحبًا','اللَّه','العربية ١٢٣']:
            shaped=self.font.shape_rich_text(value)
            self.assertEqual(len(shaped),len(value),value)

if __name__=='__main__': unittest.main()
