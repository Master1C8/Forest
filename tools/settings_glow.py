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
