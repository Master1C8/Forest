"""Table-scaled inputs for Forest's registered dynamic font resources.

This is serialized input preparation, not a Unity importer or a native render
test. Existing glyph/atlas caches cannot be reused with a different face.
"""
import copy
import io
import math
import struct


def need(value, reason):
    if not value:
        raise ValueError(reason)


def f32(value):
    need(math.isfinite(value), 'finite-font-metric')
    return struct.unpack('<f', struct.pack('<f', value))[0]


def face_metrics(data, family):
    from fontTools.ttLib import TTFont
    need(data[:4] in (b'OTTO', b'\x00\x01\x00\x00'), 'single-static-sfnt-required')
    with TTFont(io.BytesIO(data), lazy=False, checkChecksums=2) as font:
        need({'head', 'hhea', 'hmtx', 'cmap', 'name', 'OS/2', 'post'} <= set(font.keys()), 'font-metric-tables')
        need('fvar' not in font and ('glyf' in font or 'CFF ' in font), 'single-static-outline-required')
        names = font['name']
        need(family in {names.getDebugName(1), names.getDebugName(16)}, 'actual-font-family')
        h, os2, post = font['hhea'], font['OS/2'], font['post']
        cmap = font.getBestCmap()
        need(32 in cmap and font['hmtx'][cmap[32]][0] > 0, 'positive-font-space')
        need(hasattr(os2, 'sCapHeight') and hasattr(os2, 'sxHeight'), 'explicit-cap-and-x-height-required')
        metrics = dict(unitsPerEm=font['head'].unitsPerEm, ascent=h.ascent, descent=h.descent,
            lineGap=h.lineGap, capHeight=os2.sCapHeight, xHeight=os2.sxHeight,
            underlineOffset=post.underlinePosition, underlineThickness=post.underlineThickness,
            strikeOffset=os2.yStrikeoutPosition, strikeThickness=os2.yStrikeoutSize,
            spaceAdvance=font['hmtx'][cmap[32]][0])
        need(all(math.isfinite(v) for v in metrics.values()) and metrics['unitsPerEm'] > 0
             and metrics['ascent'] > 0 and metrics['descent'] < 0
             and metrics['ascent'] - metrics['descent'] + metrics['lineGap'] > 0, 'valid-font-metrics')
        return dict(family=family, style=names.getDebugName(17) or names.getDebugName(2),
                    extension='.otf' if data[:4] == b'OTTO' else '.ttf', **metrics)


def native_font(template, data, metrics):
    need(template['m_FontRenderingMode'] == 0 and not template['m_CharacterRects'], 'empty-dynamic-native-font-required')
    point = template['m_FontSize']
    need(point > 0 and math.isfinite(point), 'positive-native-font-point')
    scale = point / metrics['unitsPerEm']
    result = copy.deepcopy(template)
    result.update(m_FontData=list(data), m_FontNames=[metrics['family']],
        m_LineSpacing=f32((metrics['ascent'] - metrics['descent'] + metrics['lineGap']) * scale),
        m_Ascent=f32(metrics['ascent'] * scale), m_Descent=f32(metrics['descent'] * scale), m_KerningValues=[])
    return result


def tmp_font(template, metrics, source_path_id, filename):
    need(template['m_SourceFontFile'] == dict(m_FileID=0, m_PathID=source_path_id), 'exact-dynamic-source-route')
    need(template['m_AtlasPopulationMode'] == 1, 'dynamic-tmp-font-required')
    need(not any(template[k] for k in ['m_GlyphTable', 'm_CharacterTable', 'm_glyphInfoList', 'm_UsedGlyphRects']),
         'empty-dynamic-tmp-caches-required')
    need(template['m_FontFeatureTable'] == {'m_GlyphPairAdjustmentRecords': []}
         and template['m_KerningTable'] == {'kerningPairs': []}, 'empty-dynamic-tmp-feature-caches-required')
    result = copy.deepcopy(template)
    point = result['m_FaceInfo']['m_PointSize']
    need(type(point) is int and point > 0, 'positive-tmp-font-point')
    scale = point / metrics['unitsPerEm']
    m = {k: f32(metrics[k] * scale) for k in ['ascent', 'descent', 'capHeight', 'xHeight', 'underlineOffset',
         'underlineThickness', 'strikeOffset', 'strikeThickness', 'spaceAdvance']}
    face = dict(m_FaceIndex=0, m_FamilyName=metrics['family'], m_StyleName=metrics['style'],
        m_PointSize=point, m_Scale=1.0,
        m_LineHeight=f32((metrics['ascent'] - metrics['descent'] + metrics['lineGap']) * scale),
        m_AscentLine=m['ascent'], m_CapLine=m['capHeight'], m_MeanLine=m['xHeight'], m_Baseline=0.0,
        m_DescentLine=m['descent'], m_SuperscriptOffset=m['ascent'], m_SuperscriptSize=0.5,
        m_SubscriptOffset=m['descent'], m_SubscriptSize=0.5, m_UnderlineOffset=m['underlineOffset'],
        m_UnderlineThickness=m['underlineThickness'], m_StrikethroughOffset=m['strikeOffset'],
        m_StrikethroughThickness=m['strikeThickness'], m_TabWidth=m['spaceAdvance'])
    need(set(face) == set(result['m_FaceInfo']), 'known-tmp-face-schema')
    result['m_FaceInfo'] = face
    result['m_fontInfo'].update(Name=metrics['family'], PointSize=float(point), Scale=1.0, CharacterCount=0,
        LineHeight=face['m_LineHeight'], Baseline=0.0, Ascender=m['ascent'], CapHeight=m['capHeight'],
        Descender=m['descent'], CenterLine=0.0, SuperscriptOffset=m['ascent'], SubscriptOffset=m['descent'],
        SubSize=0.5, Underline=m['underlineOffset'], UnderlineThickness=m['underlineThickness'],
        strikethrough=m['strikeOffset'], strikethroughThickness=m['strikeThickness'],
        TabWidth=f32(m['spaceAdvance'] * result['tabSize']),
        AtlasWidth=float(result['m_AtlasWidth']), AtlasHeight=float(result['m_AtlasHeight']))
    result['m_SourceFontFileGUID'] = ''
    result['m_CreationSettings'].update(sourceFontFileName=filename, sourceFontFileGUID='', pointSize=point,
        characterSequence='', referencedFontAssetGUID='', referencedTextAssetGUID='')
    return result


# Exact shared-framework consumer registration, independent of target locale.
# TMP1020 retains its original fallback route to TMP1017; fictional Font3324,
# material3 and atlas245 are outside this registration and stay untouched.
TMP_DEPENDENCIES = {('resources.assets', 439): (1017,)}
