"""Fresh selected-tree readback of five exact reused resource artifacts; no game launch."""
from pathlib import Path
import hashlib,json,sys
import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
root=Path('/Users/antonkrutov/Desktop/Forest');run=Path(__file__).resolve().parent
sys.path.insert(0,str(run/'resource-recipe'))
from extract_assets import read_tree,canonical
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
data='The Forest of Love_Data';prior=root/'localization/probes/ru-20261026-34'
source=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')
report=json.loads((run/'build.json').read_text());generator=TypeTreeGenerator('2020.3.24f1')
generator.load_local_dll_folder(str(source/data/'Managed'))
rows=[]
for record in report['files']:
 p=run/'game'/data/record['path'];old=prior/'game'/data/record['path']
 assert sha(p)==sha(old)==record['probeSha256']
 env=UnityPy.load(str(p));objects={o.path_id:o for o in env.objects};assert len(objects)==len(env.objects)==record['objectCount']
 previous={o.path_id:o for o in UnityPy.load(str(old)).objects}
 selected=[]
 for change in record['changes']:
  pid=change['pathId'];tree=canonical(read_tree(objects[pid],generator))
  assert tree==canonical(read_tree(previous[pid],generator)),(record['path'],pid)
  selected.append(dict(pathId=pid,type=objects[pid].type.name,treeSha256=hashlib.sha256(json.dumps(tree,sort_keys=True,separators=(',',':')).encode()).hexdigest()))
 if record['path']=='globalgamemanagers':
  identity=canonical(read_tree(objects[1],generator));assert identity['companyName']=='VNRevivalQA' and identity['productName']=='ForestRuRendererProbe' and identity['runInBackground'] is True
 rows.append(dict(path=record['path'],sha256=sha(p),objectCount=len(objects),selectedTrees=selected,exactAccepted34BytesAndTrees=True))
result=dict(status='passed-static-only',resourceFiles=rows,sourceAdapterSha256=sha(run/'resource-recipe/extract_assets.py'),sourceBuildReceiptSha256=sha(prior/'build.json'),totalSelectedTrees=sum(len(r['selectedTrees']) for r in rows),boundary='New43 bytes parsed with source-aligned Unity schema. Exact selected trees and full resource hashes equal pinned accepted34 recipe; no runtime or visual acceptance.',imagesOpened=0,gameLaunches=0)
(run/'resource-readback.json').write_text(json.dumps(result,indent=2)+'\n')
print('New43 resource readback:',len(rows),'files;',result['totalSelectedTrees'],'selected trees; identity/background policy preserved')
