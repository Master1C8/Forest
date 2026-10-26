"""Test font-resource geometry and preservation, never visual acceptance."""
import unittest
from pathlib import Path
from tmp_dialogue_font import cyrillic_mark_pairs

ROOT = Path(__file__).resolve().parents[1]

class MarkPairs(unittest.TestCase):
    def test_raw_canonical_pairs_and_geometry(self):
        face = (ROOT / 'assets/source-v2/fonts/90744c19ec-resources.assets-439.font').read_bytes()
        pairs, rows = cyrillic_mark_pairs(face, 86)
        self.assertEqual([r['raw'] for r in rows], ['Е\u0308', 'е\u0308', 'И\u0306', 'и\u0306'])
        # Independently derived from the actual sfnt composite component bounds:
        # E advance 1366, diaeresis target center 700.5, raw center -0.5.
        self.assertEqual(rows[0]['fontUnits'], {'xPlacement': -665.0, 'yPlacement': 311})
        self.assertEqual(rows[3]['fontUnits'], {'xPlacement': -570.0, 'yPlacement': 54})
        for pair in pairs:
            self.assertEqual(pair['m_FirstAdjustmentRecord']['m_GlyphValueRecord'],
                             dict(m_XPlacement=0., m_YPlacement=0., m_XAdvance=0., m_YAdvance=0.))
            self.assertEqual(pair['m_SecondAdjustmentRecord']['m_GlyphValueRecord']['m_XAdvance'], 0.)
        self.assertEqual(len({(p['m_FirstAdjustmentRecord']['m_GlyphIndex'], p['m_SecondAdjustmentRecord']['m_GlyphIndex']) for p in pairs}), 4)

if __name__ == '__main__': unittest.main()
