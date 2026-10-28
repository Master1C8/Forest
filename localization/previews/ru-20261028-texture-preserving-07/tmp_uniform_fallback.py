"""Route the complete ordinary TMP face through the existing dynamic fallback.

Original bitmap atlases and materials remain untouched. The static primary keeps
only its mandatory underline primitive; TMP's global fallback supplies ordinary
glyphs, including punctuation. Fictional-language faces are not selected.
"""
import copy
import struct
from legacy_choice_font import coverage


def uniform_fallback_primary(original, fallback, native_face):
    assert original['m_Name'] == 'MatchupPro_TFOL_SDF', 'uniform-primary-identity'
    assert original['m_AtlasPopulationMode'] == 0, 'uniform-primary-must-be-static'
    assert original['m_SourceFontFile'] == {'m_FileID': 0, 'm_PathID': 0}, 'uniform-primary-source'
    assert not original['m_FallbackFontAssetTable'] and not original['fallbackFontAssets'], 'uniform-primary-local-fallback'
    assert fallback['m_Name'] == 'LiberationSans SDF - Fallback' and fallback['m_AtlasPopulationMode'] == 1, 'uniform-dynamic-fallback'
    assert fallback['m_SourceFontFile'] == {'m_FileID': 0, 'm_PathID': 439}, 'uniform-fallback-source'
    original_chars = sorted({r['m_Unicode'] for r in original['m_CharacterTable']})
    proof = coverage(native_face, ''.join(map(chr, original_chars)))
    assert original_chars and all(proof['characters'].values()) and proof['spaceAdvance'] > 0, 'uniform-original-coverage-loss'
    result = copy.deepcopy(original)
    result['m_FaceInfo'] = copy.deepcopy(fallback['m_FaceInfo'])
    result['m_FaceInfo']['m_Scale'] = struct.unpack('<f', struct.pack('<f', (77 / 176) / (59 / 86)))[0]
    # This shipped TMP GetUnderlineSpecialCharacter explicitly searches the
    # primary with includeFallbacks=false; unlike ellipsis it never consults
    # global fallbacks. Preserve the original decorative underscore and atlas.
    underscore = [r for r in original['m_CharacterTable'] if r['m_Unicode'] == 95]
    assert len(underscore) == 1, 'uniform-primary-underline-required'
    glyph_index = underscore[0]['m_GlyphIndex']
    result['m_CharacterTable'] = copy.deepcopy(underscore)
    result['m_GlyphTable'] = [copy.deepcopy(r) for r in original['m_GlyphTable'] if r['m_Index'] == glyph_index]
    result['m_glyphInfoList'] = [copy.deepcopy(r) for r in original['m_glyphInfoList'] if r['id'] == 95]
    assert len(result['m_GlyphTable']) == len(result['m_glyphInfoList']) == 1, 'uniform-primary-underline-glyph'
    result['m_fontInfo']['CharacterCount'] = 1
    result['m_FontFeatureTable'] = {'m_GlyphPairAdjustmentRecords': []}
    result['m_KerningTable'] = {'kerningPairs': []}
    return result, {'mechanism': 'Primary retains exact decorative underscore required by shipped TMP; ordinary glyphs -> global dynamic1017; no serialized atlas edits',
                    'preservedPrimaryCodepoints': [95],
                    'originalCharacterCount': len(original_chars), 'originalCoverageRetained': proof,
                    'preservedAtlasPointers': original['m_AtlasTextures'], 'preservedMaterial': original['material'],
                    'runtime': 'not-run', 'visual': 'not-run'}
