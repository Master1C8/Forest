"""Rebind native response-label Text components to the existing coherent face.

Only StandardUIResponseButton.label.m_uiText is selected. ManaSpace itself and
all non-response consumers remain unchanged. This is a resource feasibility
recipe, not final font selection or runtime/visual acceptance.
"""
import copy
import hashlib
import io

from fontTools.ttLib import TTFont
from extract_assets import read_tree

RUSSIAN = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя'
CHOICE_SAMPLES = {
    '159': 'Ёж Йй Щъ Ыь Эю Яя; 123 — Latin!',
    '181': 'Е\u0308 и\u0306; ё й. Съешь ещё этих булок!',
}


def coverage(font_tree, sample):
    """Serialized glyph availability; never substitute it for Font.HasCharacter."""
    data = bytes(font_tree['m_FontData'])
    if data:
        font = TTFont(io.BytesIO(data))
        cmap = font.getBestCmap()
        available = set(cmap)
        space_advance = font['hmtx'][cmap[32]][0]
        units = font['head'].unitsPerEm
        family = font['name'].getDebugName(1)
    else:
        available = {r['index'] for r in font_tree['m_CharacterRects']}
        space_advance = next(r['advance'] for r in font_tree['m_CharacterRects'] if r['index'] == 32)
        units, family = None, font_tree['m_FontNames']
    return {
        'boundary': 'serialized bitmap character indices or embedded sfnt cmap/hmtx, not Unity runtime',
        'fontName': font_tree['m_Name'], 'family': family,
        'embeddedFaceSha256': hashlib.sha256(data).hexdigest() if data else None,
        'embeddedFaceBytes': len(data), 'serializedCharacterCount': len(available),
        'characters': {c: ord(c) in available for c in dict.fromkeys(sample)},
        'missingRussianLetters': ''.join(c for c in RUSSIAN if ord(c) not in available),
        'spaceAdvance': space_advance, 'unitsPerEm': units,
    }


def rebind_label(tree, source_font_id, target_font_id):
    assert tree['m_FontData']['m_Font'] == {'m_FileID': 0, 'm_PathID': source_font_id}, 'Unexpected response font binding'
    assert tree['m_FontData']['m_FontSize'] == 12, 'Unexpected response font size'
    assert tree['m_Material'] == {'m_FileID': 0, 'm_PathID': 0}, 'Explicit material requires separate renderer review'
    result = copy.deepcopy(tree)
    result['m_FontData']['m_Font'] = {'m_FileID': 0, 'm_PathID': target_font_id}
    return result


def choice_font_plan(objects, generator, native_fallback):
    fonts = {pid: obj.read_typetree() for pid, obj in objects.items() if obj.type.name == 'Font'}
    source_ids = [pid for pid, tree in fonts.items() if tree['m_Name'] == 'ManaSpaceKerned8pixelperfect']
    target_ids = [pid for pid, tree in fonts.items() if tree['m_Name'] == 'MatchupPro_TFOL']
    assert len(source_ids) == len(target_ids) == 1, 'Ambiguous font identity'
    source_id, target_id = source_ids[0], target_ids[0]
    plans, bindings = {}, []
    for pid, obj in objects.items():
        if obj.type.name != 'MonoBehaviour':
            continue
        head = obj.parse_monobehaviour_head()
        if head.m_Script.deref().read().m_ClassName != 'StandardUIResponseButton':
            continue
        button = read_tree(obj, generator)
        label = button['label']
        assert label['m_textMeshProUGUI'] == {'m_FileID': 0, 'm_PathID': 0}, 'Unexpected TMP label'
        ref = label['m_uiText']
        assert ref['m_FileID'] == 0 and ref['m_PathID'] in objects, 'Nonlocal/missing response label'
        label_id = ref['m_PathID']
        assert label_id not in plans, 'Response label has multiple owners'
        text_obj = objects[label_id]
        text_head = text_obj.parse_monobehaviour_head()
        assert text_head.m_Script.deref().read().m_ClassName == 'Text', 'Non-Text response label'
        assert text_head.m_GameObject.deref().read().m_Name == 'Response Text', 'Unexpected response label object'
        original = read_tree(text_obj, generator)
        plans[label_id] = rebind_label(original, source_id, target_id)
        bindings.append({'buttonPathId': pid, 'labelPathId': label_id,
                         'sourceFontPathId': source_id, 'targetFontPathId': target_id,
                         'fontSize': original['m_FontData']['m_FontSize'],
                         'sourceText': original['m_Text']})
    assert len(plans) in (1, 155), 'Changed pinned response-template inventory'
    sample = RUSSIAN + ''.join(CHOICE_SAMPLES.values())
    source = coverage(fonts[source_id], sample)
    target = coverage(native_fallback, sample)
    assert not target['missingRussianLetters'] and all(target['characters'].values())
    assert target['spaceAdvance'] > 0
    return plans, {
        'mechanism': 'Only native StandardUIResponseButton.label.m_uiText font pointer -> existing coherent MatchupPro_TFOL identity with embedded Liberation Sans',
        'changedField': '/m_FontData/m_Font/m_PathID',
        'labels': bindings, 'sourceCoverage': source, 'targetCoverage': target,
        'runtime': 'not-run', 'visual': 'not-run',
        'limitations': 'Cmap/positive space advance do not prove Unity loading, combining placement, readable size, wrapping or progression; final corpus unknown.',
    }
