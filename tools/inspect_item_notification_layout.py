"""Extract only the two shared notification prefabs and intentional site control."""
import hashlib,json
from pathlib import Path
import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from extract_assets import read_tree
ROOT=Path(__file__).resolve().parents[1]
DATA=ROOT/'localization/previews/ru-20261027-item-fix/game/The Forest of Love_Data'
gen=TypeTreeGenerator('2020.3.24f1');gen.load_local_dll_folder(str(DATA/'Managed'))
objects={o.path_id:o for o in UnityPy.load(str(DATA/'sharedassets1.assets')).objects};cache={}
def tree(pid):
 if pid not in cache:cache[pid]=read_tree(objects[pid],gen)
 return cache[pid]
def cls(pid):
 o=objects[pid];return o.parse_monobehaviour_head().m_Script.deref().read().m_ClassName if o.type.name=='MonoBehaviour' else o.type.name
def transform(go):return next(p['component']['m_PathID'] for p in tree(go)['m_Component'] if cls(p['component']['m_PathID']) in ['RectTransform','Transform'])
def descendants(rect):
 yield rect
 for ptr in tree(rect)['m_Children']:yield from descendants(ptr['m_PathID'])
rows=[]
for component in [1279,1284]:
 root=tree(component)['itemNotificationRoot']['m_PathID'];rect=transform(root)

 for r in descendants(rect):
  go=tree(r)['m_GameObject']['m_PathID']
  for p in tree(go)['m_Component']:
   pid=p['component']['m_PathID']
   if cls(pid)=='TextMeshProUGUI':
    v=tree(pid);rows.append(dict(prefab=component,pathId=pid,rectId=r,rect=tree(r),text=v))

output=ROOT/'localization/source/item-notifications-20261027/layout.json'
result=dict(schemaVersion=1,source='sharedassets1.assets',sourceSha256=hashlib.sha256((DATA/'sharedassets1.assets').read_bytes()).hexdigest(),controllers=[dict(asset='sharedassets1.assets',pathId=1220,normal=1284,glitch=1279),dict(asset='sharedassets2.assets',pathId=14504,externalFileId=6,normal=1284,glitch=1279)],rows=rows)
assert len(rows)==12
raw=(json.dumps(result,ensure_ascii=False,indent=2)+'\n').encode()
if output.exists():assert output.read_bytes()==raw,'notification-layout-inventory-drift'
else:output.write_bytes(raw)
print('12 TMP fields in the two shared normal/glitch item prefabs verified')
