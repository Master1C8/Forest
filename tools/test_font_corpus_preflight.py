import unittest
from font_corpus_preflight import required_characters, inspect_font, digest


class FontCorpusPreflightTests(unittest.TestCase):
    def test_complete_logical_characters_and_marks(self):
        text = '[pic=2]Ё Е\u0308 日本\n'
        counts = required_characters([{'id': 'a', 'target': text, 'targetSha256': digest(text.encode())}])
        self.assertIn('\u0308', counts)
        self.assertIn('日', counts)
        self.assertIn('[', counts)
        self.assertNotIn('\n', counts)

    def test_duplicate_and_stale_payload_rejected(self):
        row = {'id': 'a', 'target': 'x', 'targetSha256': digest(b'x')}
        with self.assertRaisesRegex(ValueError, 'Duplicate'):
            required_characters([row, row])
        with self.assertRaisesRegex(ValueError, 'Target hash'):
            required_characters([{**row, 'target': 'y'}])

    def test_bitmap_space_metric_is_not_inferred_from_presence(self):
        tree = {'m_FontData': [], 'm_FontNames': ['synthetic'],
                'm_CharacterRects': [{'index': 32, 'advance': 0}, {'index': 65, 'advance': 8}]}
        available, metrics = inspect_font(tree)
        self.assertIn(32, available)
        self.assertEqual(0, metrics['spaceAdvance'])
        tree['m_CharacterRects'][0]['advance'] = 4
        _, positive = inspect_font(tree)
        self.assertGreater(positive['spaceAdvance'], 0)

    def test_external_unembedded_face_is_unknown_not_empty_coverage(self):
        available, metrics = inspect_font({'m_FontData': [], 'm_FontNames': ['Arial'], 'm_CharacterRects': []})
        self.assertIsNone(available)
        self.assertIsNone(metrics['spaceAdvance'])
        self.assertEqual('unavailable-embedded-face-and-character-map', metrics['kind'])


if __name__ == '__main__':
    unittest.main()
