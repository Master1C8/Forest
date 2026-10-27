"""Source-bound Russian settings text; preserve the native six-layer rendering."""
import copy

from extract_assets import read_tree


SETTINGS_TEXT = {
    'Music': 'Музыка',
    'Effects': 'Эффекты',
    'Fullscreen:': 'Полный экран:',
    'Stretch:': 'Растянуть:',
    'Scale:': 'Масштаб:',
    'On': 'Вкл.',
    'Off': 'Выкл.',
}
PREFIX = 'Canvas/OptionsMenu/Controls/'
FAMILIES = {
    'Music Volume/Slider/Label': 'Music',
    'Sound Volume/Slider/Label': 'Effects',
    'Fullscreen/Fullscreen': 'Fullscreen:',
    'FullscreenStretch/FullscreenStretch': 'Stretch:',
    'ScaleFactor/ScaleFactor': 'Scale:',
    'Fullscreen/On': 'On',
    'Fullscreen/Off': 'Off',
    'FullscreenStretch/On': 'On',
    'FullscreenStretch/Off': 'Off',
}


def settings_text_plan(objects, generator):
    cache = {}

    def tree(pid):
        if pid not in cache:
            cache[pid] = read_tree(objects[pid], generator)
        return cache[pid]

    def path(go):
        value = tree(go)
        rects = [c['component']['m_PathID'] for c in value['m_Component']
                 if objects[c['component']['m_PathID']].type.name == 'RectTransform']
        assert len(rects) == 1, ('settings-transform', go)
        father = tree(rects[0])['m_Father']['m_PathID']
        return (path(tree(father)['m_GameObject']['m_PathID']) + '/' if father else '') + value['m_Name']

    groups = {key: [] for key in FAMILIES}
    repairs = {}
    for obj in objects.values():
        if obj.type.name != 'MonoBehaviour':
            continue
        head = obj.parse_monobehaviour_head()
        if head.m_Script.deref().read().m_ClassName != 'TextMeshProUGUI':
            continue
        value = tree(obj.path_id)
        hierarchy = path(value['m_GameObject']['m_PathID'])
        family = next((key for key in FAMILIES
                       if hierarchy.startswith(PREFIX + key + '/NameContainer')), None)
        if family is None:
            continue
        assert value['m_text'] == FAMILIES[family], ('settings-before-text', hierarchy)
        assert value['m_fontAsset'] == {'m_FileID': 5, 'm_PathID': 3323}, ('settings-font-binding', hierarchy)
        fixed = copy.deepcopy(value)
        fixed['m_text'] = SETTINGS_TEXT[value['m_text']]
        repairs[obj.path_id] = fixed
        groups[family].append(obj.path_id)
    assert all(len(ids) == 6 for ids in groups.values()), ('settings-six-layer-coverage', groups)
    receipt = [{'hierarchy': PREFIX + key, 'source': source, 'target': SETTINGS_TEXT[source],
                'textIds': sorted(groups[key])} for key, source in FAMILIES.items()]
    return repairs, receipt
