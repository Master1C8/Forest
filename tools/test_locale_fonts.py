"""Field-bound font edits and early guards; actual Unity readback is separate."""
import copy
import json
from pathlib import Path
import tempfile
import unittest

from locale_fonts import transform, run


class LocaleFontTests(unittest.TestCase):
    def test_native_face_preserves_original_identity_and_resource_links(self):
        original = dict(m_Name='MatchupPro_TFOL', m_DefaultMaterial={'m_PathID': 6},
                        m_Texture={'m_PathID': 136}, m_FallbackFonts=[368], m_FontData=[1], m_Ascent=12)
        reference = dict(original, m_DefaultMaterial={'m_PathID': 999}, m_Texture={'m_PathID': 999},
                         m_FallbackFonts=[], m_FontData=[2, 3], m_Ascent=13)
        result = transform(original, dict(kind='native-face'), reference)
        self.assertEqual(result['m_FontData'], [2, 3])
        for key in ['m_Name', 'm_DefaultMaterial', 'm_Texture', 'm_FallbackFonts']:
            self.assertEqual(result[key], original[key])
        self.assertEqual(original['m_FontData'], [1])

    def test_pointer_changes_only_font_and_preserves_file_id_and_german_bytes(self):
        original = dict(m_FontData=dict(m_Font=dict(m_FileID=5, m_PathID=367), m_FontSize=12),
                        m_Material=dict(m_FileID=0, m_PathID=0), m_Text='„Öl“\r\nÄ\u0308', m_GameObject=42)
        operation = dict(kind='native-pointer', before=dict(m_FileID=5, m_PathID=367), after=dict(m_FileID=5, m_PathID=369))
        result = transform(original, operation)
        restored = copy.deepcopy(result); restored['m_FontData']['m_Font']['m_PathID'] = 367
        self.assertEqual(restored, original)
        operation['after']['m_FileID'] = 0
        with self.assertRaisesRegex(ValueError, 'font-native-file-id'):
            transform(original, operation)

    def test_native_pointer_rejects_already_changed_and_ambiguous_material(self):
        operation = dict(kind='native-pointer', before=dict(m_FileID=0, m_PathID=367), after=dict(m_FileID=0, m_PathID=369))
        tree = dict(m_FontData=dict(m_Font=dict(m_FileID=0, m_PathID=369)), m_Material=dict(m_FileID=0, m_PathID=0))
        with self.assertRaisesRegex(ValueError, 'font-native-before'): transform(tree, operation)
        tree['m_FontData']['m_Font']['m_PathID'] = 367; tree['m_Material']['m_PathID'] = 9
        with self.assertRaisesRegex(ValueError, 'font-native-material'): transform(tree, operation)

    def test_spacing_changes_no_wording_or_size(self):
        tree = dict(m_fontAsset=dict(m_FileID=0, m_PathID=3323), m_text='Äß „Text“', m_fontSize=12, m_lineSpacing=-3)
        operation = dict(kind='metric-spacing', font=tree['m_fontAsset'], oldFace={}, newFace={})
        result = transform(tree, operation, spacing=lambda old, new, value: value + 10)
        self.assertEqual(result, dict(tree, m_lineSpacing=7))

    def test_foreign_or_unknown_locale_rejects_before_engine_or_output(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary); profile = root/'profile.json'
            profile.write_text(json.dumps(dict(schemaVersion=1, kind='locale-font-transform', locale='de')))
            for locale in ['ru', 'fr', 'ja']:
                output = root/'outputs/locale-assets-20261026'/locale/'candidate'
                with self.subTest(locale=locale), self.assertRaisesRegex(ValueError, 'font-explicit-locale'):
                    run(profile, locale, output, root=root)
                self.assertFalse(output.exists())


if __name__ == '__main__': unittest.main()
