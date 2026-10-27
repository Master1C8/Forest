"""Extract the complete reported menu and linked confirmation text scopes."""
import argparse
import hashlib
import json
from pathlib import Path
import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from extract_assets import read_tree

ROOT = Path(__file__).resolve().parents[1]
SOURCE = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
PREFIXES = tuple('Canvas/' + p for p in ('PlayMenu/', 'GalleryMenu/', 'OptionsMenu/',
    'NewGameConfirmation/', 'DeleteSavegameConfirmation/', 'QuitConfirmation/'))


def inventory():
    raw = (SOURCE / 'level1').read_bytes()
    assert hashlib.sha256(raw).hexdigest() == '5ff0636003eed46615678c124f42320eb9a8c66baa0870ec11c9faa42db78db0'
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(SOURCE / 'Managed'))
    objects = {o.path_id:o for o in UnityPy.load(str(SOURCE / 'level1')).objects}
    cache, classes = {}, {}
    def tree(pid):
        if pid not in cache: cache[pid] = read_tree(objects[pid], generator)
        return cache[pid]
    def cls(pid):
        if pid not in classes:
            obj = objects[pid]
            classes[pid] = obj.parse_monobehaviour_head().m_Script.deref().read().m_ClassName if obj.type.name == 'MonoBehaviour' else obj.type.name
        return classes[pid]
    def path(go):
        value = tree(go)
        transforms = [c['component']['m_PathID'] for c in value['m_Component'] if cls(c['component']['m_PathID']) in ('Transform','RectTransform')]
        assert len(transforms) == 1
        father = tree(transforms[0])['m_Father']['m_PathID']
        return (path(tree(father)['m_GameObject']['m_PathID']) + '/' if father else '') + value['m_Name']
    rows = []
    for pid in sorted(objects):
        kind = cls(pid)
        if kind not in ('Text','TextMeshProUGUI'): continue
        value = tree(pid); hierarchy = path(value['m_GameObject']['m_PathID'])
        if not hierarchy.startswith(PREFIXES): continue
        field = 'm_text' if kind == 'TextMeshProUGUI' else 'm_Text'
        rows.append(dict(id=f'level1:{pid}/{field}',pathId=pid,field=field,source=value[field],
                         hierarchy=hierarchy,kind=kind,font=value.get('m_fontAsset'),size=value.get('m_fontSize')))
    assert len(rows) == 282 and all(r['kind']=='TextMeshProUGUI' for r in rows)
    layouts = []
    for rect_id, fitter_id, source_x in [(6854,9913,68.0),(6685,9729,79.0)]:
        rect, fitter = tree(rect_id), tree(fitter_id)
        assert rect['m_AnchoredPosition']['x'] == source_x and rect['m_Pivot']['x'] == .5
        assert fitter['m_HorizontalFit'] == 0 and fitter['m_VerticalFit'] == 2
        layouts.append(dict(rectId=rect_id,fitterId=fitter_id,sourceRect=rect,sourceFitter=fitter,
                            targetPivotX=1.0,targetAnchoredX=68.0,targetHorizontalFit=2))
    return dict(schemaVersion=1,source='level1',sourceSha256=hashlib.sha256(raw).hexdigest(),
                scope=list(PREFIXES),linkedControllerSource='controller-bindings.json; MainMenuController8642',
                rows=rows,captionLayout=layouts)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',type=Path,required=True)
    args = parser.parse_args()
    result = (json.dumps(inventory(),ensure_ascii=False,indent=2)+'\n').encode()
    if args.output.exists():
        assert args.output.read_bytes() == result, 'existing-inventory-drift'
    else:
        args.output.write_bytes(result)
    print('Complete menu inventory verified: 282 fields and two caption layout bindings')
