"""Exact native UI font-pointer repairs outside dialogue response labels.

The selected components are the three native367 consumers established by the
phase148 resource plan. Keep ManaSpace and every texture/material unchanged.
"""
import copy
import hashlib

from extract_assets import read_tree

BINDINGS = {
    'sharedassets0.assets': {
        3695: (0, '76b48c26d8d40940dc380b3d7d2591c748d8b5ee58368e50aee7e27aeccad173'),
    },
    'sharedassets2.assets': {
        17264: (5, 'da49aaa7049a1e099f3c961efd0e01f57a36cde685fe50c3fef65b98938ce97e'),
        17286: (5, '31669b5f4a36303ffcd3e42d2dd0b83fb15153328f4b15aa579beaa708c577b3'),
    },
}


def native_role_plan(objects, generator, source_file):
    """Reject changed identities before returning any planned pointer change."""
    plans, receipt = {}, []
    for pid, (file_id, expected_hash) in BINDINGS.get(source_file, {}).items():
        assert pid in objects, ('missing-native-font-role', source_file, pid)
        obj = objects[pid]
        assert hashlib.sha256(obj.get_raw_data()).hexdigest() == expected_hash, ('native-font-role-source', source_file, pid)
        head = obj.parse_monobehaviour_head()
        assert head.m_Script.deref().read().m_ClassName == 'Text', ('native-font-role-class', pid)
        tree = read_tree(obj, generator)
        assert tree['m_FontData']['m_Font'] == {'m_FileID': file_id, 'm_PathID': 367}, ('native-font-role-binding', pid)
        assert tree['m_Material'] == {'m_FileID': 0, 'm_PathID': 0}, ('native-font-role-material', pid)
        plans[pid] = {'m_FileID': file_id, 'm_PathID': 369}
        receipt.append({'sourceFile': source_file, 'componentPathId': pid,
                        'sourceRawSha256': expected_hash,
                        'sourceFont': copy.deepcopy(tree['m_FontData']['m_Font']),
                        'targetFont': plans[pid],
                        'changedField': '/m_FontData/m_Font/m_PathID'})
    return plans, receipt


def apply_native_role(tree, target):
    """Apply to the assembled tree so other accepted field changes survive."""
    assert tree['m_FontData']['m_Font'] == dict(target, m_PathID=367), 'native-font-role-before-state'
    result = copy.deepcopy(tree)
    result['m_FontData']['m_Font'] = copy.deepcopy(target)
    return result
