import hashlib,json,sys
from pathlib import Path
root=Path('/Users/antonkrutov/Desktop/Forest'); sys.path.insert(0,str(root/'tools'))
import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from extract_assets import read_tree
source=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
env=UnityPy.load(str(source/'level1'));objects={o.path_id:o for o in env.objects}; cache={}
gen=TypeTreeGenerator('2020.3.24f1');gen.load_local_dll_folder(str(source/'Managed'))
def tree(pid):
    if pid not in cache: cache[pid]=read_tree(objects[pid],gen)
    return cache[pid]
def path(pid):
    go=tree(pid);tr=tree(next(c['component']['m_PathID'] for c in go['m_Component'] if objects[c['component']['m_PathID']].type.name in ('Transform','RectTransform')));father=tr['m_Father']['m_PathID']
    return (path(tree(father)['m_GameObject']['m_PathID'])+'/' if father else '')+go['m_Name']
rows=[]
for o in objects.values():
    if o.type.name!='MonoBehaviour': continue
    head=o.parse_monobehaviour_head(); script=head.m_Script.deref().read();cl=script.m_ClassName
    if cl not in ('Button','SelectableUiControl','EventTrigger'):continue
    v=tree(o.path_id);p=path(v['m_GameObject']['m_PathID'])
    if p.startswith('Canvas/OptionsMenu/Controls/ScaleFactor'):
        rows.append({'id':o.path_id,'class':cl,'path':p,'fields':v})
(root/'localization/probes/ru-20261026-16/scale-bindings.json').write_text(json.dumps({'sourceSha256':hashlib.sha256((source/'level1').read_bytes()).hexdigest(),'rows':rows},indent=2)+'\n')
for r in rows: print(r['path'],r['class'],json.dumps({k:v for k,v in r['fields'].items() if k in ('m_OnClick','onSelected','onDeselected','m_Navigation','m_Delegates')}))
