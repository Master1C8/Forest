"""Candidate geometry for TMP glow layers with serialized Top/fitted-height mismatch.

Keep the native six-layer colors, text, material, point size, alignment and +/-1px
outline offsets. Stretch only the four fixed-height children to their fitted parent.
Scope is the source-backed OptionsMenu scene; no runtime font/layout mutation.
The split serialized fields alone do not establish actual alignment. Candidate12
reports Center; legacy m_textAlignment=514 is also present, but its migration
consumer has not been traced. This topology experiment is
not an established cause/fix for candidate11 overprinting; retain visual gating.
"""
import copy
from extract_assets import read_tree


def settings_value_image_plan(objects, generator):
    """Suppress legacy baked labels only where the scene has a full TMP replacement.

    OptionsMenu enables/disables the value GameObjects, leaving Image.enabled intact.
    A six-layer NameContainer is the source-backed replacement contract. Cursors,
    Scale multiplier images and other non-text images have no such container.
    """
    cache = {}
    def tree(pid):
        if pid not in cache:
            cache[pid] = read_tree(objects[pid], generator)
        return cache[pid]
    def components(go, kind):
        result = []
        for ref in tree(go)['m_Component']:
            obj = objects[ref['component']['m_PathID']]
            name = obj.type.name
            if name == 'MonoBehaviour':
                name = obj.parse_monobehaviour_head().m_Script.deref().read().m_ClassName
            if name == kind:
                result.append(obj.path_id)
        return result
    def transform(go):
        ids = components(go, 'RectTransform')
        assert len(ids) == 1
        return ids[0]
    def path(go):
        father = tree(transform(go))['m_Father']['m_PathID']
        return (path(tree(father)['m_GameObject']['m_PathID']) + '/' if father else '') + tree(go)['m_Name']
    def text_descendants(rect):
        go = tree(rect)['m_GameObject']['m_PathID']
        return (components(go, 'TextMeshProUGUI') +
                [pid for ref in tree(rect)['m_Children'] for pid in text_descendants(ref['m_PathID'])])
    repairs, evidence = {}, []
    for obj in objects.values():
        if obj.type.name != 'GameObject':
            continue
        go = obj.path_id
        images = components(go, 'Image')
        if not images or not path(go).startswith('Canvas/OptionsMenu/'):
            continue
        containers = [ref['m_PathID'] for ref in tree(transform(go))['m_Children']
                      if tree(tree(ref['m_PathID'])['m_GameObject']['m_PathID'])['m_Name'].startswith('NameContainer')]
        if not containers:
            continue
        assert len(images) == len(containers) == 1, ('Ambiguous replacement topology', path(go))
        texts = text_descendants(containers[0])
        assert len(texts) == 6 and len({tree(pid)['m_text'] for pid in texts}) == 1, ('Incomplete TMP replacement', path(go))
        image_id = images[0]; image = tree(image_id)
        assert all(tree(pid)['m_Enabled'] == 1 for pid in texts)
        evidence.append({'hierarchy': path(go), 'imageId': image_id, 'sprite': image['m_Sprite'],
                         'textIds': texts, 'text': tree(texts[0])['m_text'], 'beforeEnabled': image['m_Enabled'],
                         'afterEnabled': 0})
        if image['m_Enabled']:
            fixed = copy.deepcopy(image); fixed['m_Enabled'] = 0
            repairs[image_id] = fixed
    assert set(repairs) == {9708}, 'Pinned duplicate Image set changed; inspect before broadening scope'
    return repairs, evidence


def settings_glow_plan(objects, generator):
    cache = {}
    def tree(pid):
        if pid not in cache:
            cache[pid] = read_tree(objects[pid], generator)
        return cache[pid]
    def transform(go):
        return next((c['component']['m_PathID'] for c in tree(go)['m_Component']
                     if objects[c['component']['m_PathID']].type.name == 'RectTransform'), None)
    def path(go):
        tr = tree(transform(go)); father = tr['m_Father']['m_PathID']
        return (path(tree(father)['m_GameObject']['m_PathID']) + '/' if father else '') + tree(go)['m_Name']
    def tmp(go):
        rows = []
        for c in tree(go)['m_Component']:
            obj = objects[c['component']['m_PathID']]
            if obj.type.name == 'MonoBehaviour':
                head = obj.parse_monobehaviour_head()
                if head.m_Script.deref().read().m_ClassName == 'TextMeshProUGUI':
                    rows.append((obj.path_id, tree(obj.path_id)))
        assert len(rows) == 1
        return rows[0]
    def fitted(go):
        for c in tree(go)['m_Component']:
            obj = objects[c['component']['m_PathID']]
            if obj.type.name == 'MonoBehaviour' and obj.parse_monobehaviour_head().m_Script.deref().read().m_ClassName == 'ContentSizeFitter':
                value = tree(obj.path_id)
                return value['m_Enabled'] == 1 and value['m_VerticalFit'] == 2
        return False
    repairs, evidence = {}, []
    for obj in objects.values():
        if obj.type.name != 'GameObject' or tree(obj.path_id)['m_Name'] != 'NameGlowLeft':
            continue
        go = obj.path_id
        # Other scenes/templates are outside this bounded recipe.
        p = path(go)
        if not p.startswith('Canvas/OptionsMenu/') or not fitted(go):
            continue
        parent_id, parent = tmp(go)
        if parent['m_VerticalAlignment'] != 256:  # TMP Top; Middle is invariant to height.
            continue
        tr = tree(transform(go))
        children = []
        for ref in tr['m_Children']:
            pid = ref['m_PathID']; child = tree(pid); child_go = child['m_GameObject']['m_PathID']
            child_id, text = tmp(child_go)
            assert tree(child_go)['m_Name'] in ('Name', 'NameGlowTop', 'NameGlowBottom', 'NameGlowRight')
            for key in ('m_text', 'm_fontAsset', 'm_sharedMaterial', 'm_fontSize', 'm_VerticalAlignment', 'm_HorizontalAlignment', 'm_enableAutoSizing'):
                assert text[key] == parent[key], (p, child_id, key)
            assert child['m_AnchorMin']['y'] == child['m_AnchorMax']['y'] == .5
            assert child['m_SizeDelta']['y'] == 50
            fixed = copy.deepcopy(child)
            fixed['m_AnchorMin']['y'] = 0.
            fixed['m_AnchorMax']['y'] = 1.
            fixed['m_SizeDelta']['y'] = 0.
            repairs[pid] = fixed
            children.append({'rectId': pid, 'textId': child_id, 'hierarchy': path(child_go),
                             'beforeHeight': 50, 'afterHeight': 'same as fitted parent',
                             'preservedOffset': child['m_AnchoredPosition']})
        assert len(children) == 4
        evidence.append({'hierarchy': p, 'parentTextId': parent_id, 'text': parent['m_text'],
                         'alignment': 'Top', 'parentHeight': 'ContentSizeFitter preferred', 'children': children})
    assert len(evidence) == 2 and len(repairs) == 8, 'Pinned source topology changed'
    assert {r['text'] for r in evidence} == {'Off'}
    return repairs, evidence
