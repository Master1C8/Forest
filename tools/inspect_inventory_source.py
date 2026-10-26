#!/usr/bin/env python3
"""Trace the bounded inventory ticker family and adjacent quest consumer, read-only."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from extract_assets import read_tree, canonical

ROOT = Path(__file__).resolve().parents[1]
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    out = args.output.resolve()
    assert ROOT in out.parents and not out.exists()
    out.mkdir(parents=True)
    source = json.loads((ROOT / 'assets/source-v2/source-files.json').read_text())
    assert sha(DATA / 'sharedassets2.assets') == source['sharedassets2.assets']['sha256']
    env = UnityPy.load(str(DATA / 'sharedassets2.assets'))
    objects = {o.path_id: o for o in env.objects}
    gen = TypeTreeGenerator('2020.3.24f1')
    gen.load_local_dll_folder(str(DATA / 'Managed'))
    cache = {}

    def tree(pid):
        if pid not in cache:
            cache[pid] = read_tree(objects[pid], gen)
        return cache[pid]

    def path(go, seen=()):
        assert go not in seen
        value = tree(go)
        tids = [c['component']['m_PathID'] for c in value['m_Component']
                if objects[c['component']['m_PathID']].type.name in ('Transform', 'RectTransform')]
        assert len(tids) == 1
        parent = tree(tids[0])['m_Father']
        assert parent['m_FileID'] == 0
        return (path(tree(parent['m_PathID'])['m_GameObject']['m_PathID'], seen + (go,)) + '/'
                if parent['m_PathID'] else '') + value['m_Name']

    externals = [x.path for x in next(iter(env.files.values())).externals]

    def text_binding(ref):
        assert ref['m_FileID'] == 0 and ref['m_PathID']
        pid = ref['m_PathID']; value = tree(pid)
        script = objects[pid].parse_monobehaviour_head().m_Script.deref().read()
        assert script.m_ClassName == 'Text'
        go = value['m_GameObject']['m_PathID']
        font = value['m_FontData']['m_Font']
        font_asset = 'sharedassets2.assets' if font['m_FileID'] == 0 else externals[font['m_FileID'] - 1]
        tr = next(c['component']['m_PathID'] for c in tree(go)['m_Component']
                  if objects[c['component']['m_PathID']].type.name == 'RectTransform')
        return {'id': 'sharedassets2.assets:' + str(pid), 'hierarchy': path(go),
                'serializedText': value['m_Text'], 'font': font_asset + ':' + str(font['m_PathID']),
                'fontData': value['m_FontData'], 'rect': tree(tr),
                'rawSha256': hashlib.sha256(objects[pid].get_raw_data()).hexdigest()}

    controllers = []
    wanted = {'InventoryUi', 'InventoryInfoTicker', 'QuestLogDetailsPane'}
    for obj in objects.values():
        if obj.type.name != 'MonoBehaviour':
            continue
        script = obj.parse_monobehaviour_head().m_Script.deref().read()
        if script.m_ClassName not in wanted:
            continue
        value = tree(obj.path_id)
        keys = ['itemTitleText', 'tickerText'] if script.m_ClassName == 'InventoryInfoTicker' else (
            ['title', 'description', 'stepHistoryCurrent', 'stepHistory1Back', 'stepHistory2Back',
             'stepHistory3Back', 'stepHistory4Back'] if script.m_ClassName == 'QuestLogDetailsPane' else [])
        controllers.append({'id': 'sharedassets2.assets:' + str(obj.path_id),
                            'class': script.m_ClassName, 'hierarchy': path(value['m_GameObject']['m_PathID']),
                            'fields': canonical(value), 'textBindings': {k: text_binding(value[k]) for k in keys}})
    assert sum(c['class'] == 'InventoryInfoTicker' for c in controllers) == 3
    methods = {
        'InventoryInfoTicker': 'Start,Update,OnCellSelected,UpdateItemInfoText,StartScrolling,Scroll,ResetScrolling',
        'InventoryCellUiController': 'OnSelected',
        'InventoryUi': 'Start,Open,Close',
        'QuestLogDetailsPane': 'UpdateSelectedQuest',
    }
    inspector = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
    for name, selection in methods.items():
        result = subprocess.run(['dotnet', str(inspector), str(DATA / 'Managed/Assembly-CSharp.dll'),
                                 'TheForestOfLove.' + name, selection], check=True, capture_output=True, text=True)
        (out / (name + '.il')).write_text(result.stdout)
    result = {'scope': 'All 3 serialized InventoryInfoTicker instances in sharedassets2 and adjacent quest pane; not complete game source coverage',
              'source': {'sharedassets2.assets': sha(DATA / 'sharedassets2.assets'),
                         'Assembly-CSharp.dll': sha(DATA / 'Managed/Assembly-CSharp.dll')},
              'recipeSha256': sha(Path(__file__)), 'controllers': controllers,
              'inventoryTextOccurrenceCount': 6, 'questTextOccurrenceCount': 7,
              'evidence': {p.name: sha(p) for p in out.glob('*.il')},
              'runtime': 'not-run', 'visibleDenominator': None}
    (out / 'bindings.json').write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    print('Traced 3 ticker controllers / 6 native Text bindings, plus 7 quest Text bindings.')


if __name__ == '__main__':
    main()
