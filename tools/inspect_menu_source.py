#!/usr/bin/env python3
"""Trace the bounded settings label family from pinned original Unity objects."""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path

import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from extract_assets import read_tree

PROJECT = Path(__file__).resolve().parents[1]
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
LABELS = {'Fullscreen:', 'Scale:', 'Stretch:'}


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    assert not args.output.exists(), 'Preserve earlier evidence.'
    source_hashes = json.loads((PROJECT / 'assets/source-v2/source-files.json').read_text())
    assert sha(DATA / 'level1') == source_hashes['level1']['sha256']
    env = UnityPy.load(str(DATA / 'level1'))
    objects = {o.path_id: o for o in env.objects}
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(DATA / 'Managed'))
    cache = {}

    def tree(pid):
        if pid not in cache:
            cache[pid] = read_tree(objects[pid], generator)
        return cache[pid]

    def path(pid, visited=()):
        go = tree(pid)
        assert pid not in visited
        transform_ids = [c['component']['m_PathID'] for c in go['m_Component']
                         if objects[c['component']['m_PathID']].type.name in ('Transform', 'RectTransform')]
        assert len(transform_ids) == 1
        tr = tree(transform_ids[0]); father = tr['m_Father']
        assert father['m_FileID'] == 0
        return (path(tree(father['m_PathID'])['m_GameObject']['m_PathID'], visited + (pid,)) + '/'
                if father['m_PathID'] else '') + go['m_Name']

    rows = []; controllers = []
    for obj in objects.values():
        if obj.type.name != 'MonoBehaviour':
            continue
        script = obj.parse_monobehaviour_head().m_Script.deref().read()
        if script.m_ClassName not in ('TextMeshProUGUI', 'OptionsMenu', 'StartScreenMainMenu'):
            continue
        value = tree(obj.path_id)
        go_id = value['m_GameObject']['m_PathID']
        if script.m_ClassName != 'TextMeshProUGUI':
            controllers.append({'id': 'level1:' + str(obj.path_id), 'class': script.m_ClassName,
                                'hierarchy': path(go_id), 'fields': value})
        elif value.get('m_text') in LABELS:
            rows.append({'id': 'level1:' + str(obj.path_id), 'field': '/m_text',
                         'original': value['m_text'], 'hierarchy': path(go_id),
                         'fontReference': value['m_fontAsset'], 'size': value['m_fontSize'],
                         'autoSize': value['m_enableAutoSizing'],
                         'rawSha256': hashlib.sha256(obj.get_raw_data()).hexdigest()})
    assert Counter(r['original'] for r in rows) == Counter({x: 6 for x in LABELS})
    assert all(r['hierarchy'].startswith('Canvas/OptionsMenu/') for r in rows)
    externals = [x.path for x in next(iter(env.files.values())).externals]
    assert externals[4] == 'sharedassets0.assets'
    assert all(r['fontReference'] == {'m_FileID': 5, 'm_PathID': 3323} for r in rows)
    result = {'schemaVersion': 1, 'scope': 'Three settings labels only, not complete UI/source acceptance',
              'source': {'level1': sha(DATA / 'level1'),
                         'Assembly-CSharp.dll': sha(DATA / 'Managed/Assembly-CSharp.dll')},
              'recipeSha256': sha(Path(__file__)), 'font': 'sharedassets0.assets:3323',
              'physicalOccurrences': len(rows), 'logicalLabelGroups': 3,
              'finding': 'Each label is six TMP components in one face/glow hierarchy. Preserve all six occurrences and distinct controls; runtime visibility remains a separate gate.',
              'labels': rows, 'controllers': controllers,
              'notEstablished': ['All menu source semantics', 'Code-literal consumers', 'Runtime visibility', 'Complete source denominator']}
    args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    print('Traced 3 label groups / 18 exact TMP occurrences to the shared font.')


if __name__ == '__main__':
    main()
