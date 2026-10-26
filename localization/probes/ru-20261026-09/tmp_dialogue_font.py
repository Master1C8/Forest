"""Resource-only TMP dialogue face and canonical Cyrillic mark-pair recipe.

Uses TMP's existing glyph-pair placement, not a text normalizer or engine hook.
Only the four Russian canonical diaeresis/breve decompositions are covered here;
this is not general shaping or final-corpus acceptance.
"""
import copy
import io
import struct
import unicodedata
from fontTools.ttLib import TTFont


def cyrillic_mark_pairs(font_bytes, point_size):
    font = TTFont(io.BytesIO(bytes(font_bytes)))
    cmap = font.getBestCmap()
    unit_scale = point_size / font['head'].unitsPerEm
    pairs, evidence = [], []
    for composed in 'ЁёЙй':
        base, mark = unicodedata.normalize('NFD', composed)
        base_name, mark_name = cmap[ord(base)], cmap[ord(mark)]
        composite = font['glyf'][cmap[ord(composed)]]
        assert composite.isComposite() and len(composite.components) == 2
        first, accent = composite.components
        assert (first.x, first.y) == (0, 0)
        # A Cyrillic E/e can itself alias the Latin E/e outline.
        b, first_glyph = font['glyf'][base_name], font['glyf'][first.glyphName]
        assert (b.xMin, b.yMin, b.xMax, b.yMax) == (first_glyph.xMin, first_glyph.yMin, first_glyph.xMax, first_glyph.yMax)
        a, m = font['glyf'][accent.glyphName], font['glyf'][mark_name]
        # Match the accent component's optical center and top to the font's own
        # composed glyph; keep the base origin/advance and raw mark codepoint.
        dx = accent.x + (a.xMin + a.xMax - m.xMin - m.xMax) / 2 - font['hmtx'][base_name][0]
        dy = accent.y + a.yMax - m.yMax
        def record(glyph, x=0., y=0.):
            return {'m_GlyphIndex': font.getGlyphID(glyph),
                    'm_GlyphValueRecord': {'m_XPlacement': x, 'm_YPlacement': y, 'm_XAdvance': 0., 'm_YAdvance': 0.}}
        assert font['hmtx'][mark_name][0] == 0, 'Marks must retain zero advance'
        pairs.append({'m_FirstAdjustmentRecord': record(base_name),
                      'm_SecondAdjustmentRecord': record(mark_name, dx * unit_scale, dy * unit_scale),
                      'm_FeatureLookupFlags': 256})
        evidence.append({'composed': composed, 'raw': base + mark,
                         'baseGlyph': font.getGlyphID(base_name), 'markGlyph': font.getGlyphID(mark_name),
                         'fontUnits': {'xPlacement': dx, 'yPlacement': dy},
                         'pointUnits': {'xPlacement': dx * unit_scale, 'yPlacement': dy * unit_scale},
                         'derivation': 'Embedded face canonical composite accent center/top; base advance unchanged'})
    return pairs, evidence


def coherent_tmp_face(original, liberation, native_font_id, font_bytes):
    tree = copy.deepcopy(original)
    # Keep every original object/reference binding. This role already uses the
    # bitmap TMP shader with an Alpha8 atlas; generate smooth alpha glyphs with
    # FontEngine's SMOOTH_HINTED mode, not SDF values in a bitmap material.
    for key in ['m_FaceInfo', 'm_fontInfo', 'm_SourceFontFileGUID', 'm_FontWeightTable', 'fontWeights',
                'normalStyle', 'normalSpacingOffset', 'boldStyle', 'boldSpacing', 'italicStyle', 'tabSize']:
        tree[key] = copy.deepcopy(liberation[key])
    tree['m_FaceInfo']['m_Scale'] = struct.unpack('<f', struct.pack('<f', (77 / 176) / (59 / 86)))[0]
    tree['m_SourceFontFile'] = {'m_FileID': 0, 'm_PathID': native_font_id}
    tree['m_AtlasPopulationMode'] = 1
    tree['m_AtlasRenderMode'] = 4121  # UnityEngine.TextCore.LowLevel.GlyphRenderMode.SMOOTH_HINTED
    tree['m_AtlasPadding'] = 5
    tree['m_IsMultiAtlasTexturesEnabled'] = True
    tree['m_ClearDynamicDataOnBuild'] = False
    tree['m_GlyphTable'] = []
    tree['m_CharacterTable'] = []
    tree['m_glyphInfoList'] = []
    tree['m_UsedGlyphRects'] = []
    tree['m_FreeGlyphRects'] = [{'m_X': 0, 'm_Y': 0, 'm_Width': tree['m_AtlasWidth'] - 1, 'm_Height': tree['m_AtlasHeight'] - 1}]
    tree['m_FallbackFontAssetTable'] = []
    tree['fallbackFontAssets'] = []
    pairs, evidence = cyrillic_mark_pairs(font_bytes, tree['m_FaceInfo']['m_PointSize'])
    tree['m_FontFeatureTable'] = {'m_GlyphPairAdjustmentRecords': pairs}
    return tree, evidence
