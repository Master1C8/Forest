"""Apply current notebook tutorial text and the shared TMP face-spacing repair."""
import copy,hashlib,json
from pathlib import Path
from extract_assets import read_tree,canonical
from russian_preview_ui import metric_spacing
ROOT=Path('/Users/antonkrutov/Desktop/Forest')
SOURCE=ROOT/'localization/source/notebook-tutorial-ui-20261027/inventory.json'
PACKET=ROOT/'localization/supplemental-ui/20261027'
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()

def load_inputs():
 local=Path(__file__).parent
 if (local/'notebook-inputs.json').exists():
  pins=json.loads((local/'notebook-inputs.json').read_text())
  for name,expected in pins.items():assert sha(local/name)==expected,('notebook-snapshot-pin',name)
  inv=json.loads((local/'notebook-inventory.json').read_text());records=[json.loads(x) for x in (local/'notebook-targets.jsonl').read_text().splitlines()]
 else:
  manifest=json.loads((PACKET/'manifest.json').read_text());assert sha(PACKET/'ru.jsonl')==manifest['locales']['ru']['sha256']
  assert sha(PACKET/'source-catalog.json')==manifest['sourceCatalogSha256'];catalog=json.loads((PACKET/'source-catalog.json').read_text())
  assert sha(SOURCE)==catalog['sourcePins'][str(SOURCE.relative_to(ROOT))]
  inv=json.loads(SOURCE.read_text());records=[json.loads(x) for x in (PACKET/'ru.jsonl').read_text().splitlines()]
  from russian_ui935 import apply_accepted
  records=apply_accepted(records,locale='ru')
 ids={r['id'] for r in inv['rows'] if r['classification']=='display'};targets={r['id']:r for r in records if r['id'] in ids}
 assert len(targets)==len(ids)==156
 return inv,targets

def load_layout():
 local=Path(__file__).with_name('notebook-layout.json');path=local if local.exists() else SOURCE.with_name('layout.json')
 value=json.loads(path.read_text());assert len(value['rows'])==10
 return value['rows']

def snapshot(folder):
 inv,targets=load_inputs();(folder/'notebook-inventory.json').write_text(json.dumps(inv,ensure_ascii=False,indent=2)+'\n');(folder/'notebook-targets.jsonl').write_text(''.join(json.dumps(r,ensure_ascii=False)+'\n' for r in targets.values()))
 source=ROOT/'assets/source-v2/trees/57009919ee-sharedassets0.assets-3323.json';old=json.loads(source.read_text())['m_FaceInfo'];(folder/'notebook-original-face.json').write_text(json.dumps(old,indent=2)+'\n')
 (folder/'notebook-layout.json').write_text(json.dumps(dict(rows=load_layout()),indent=2)+'\n')
 (folder/'notebook-inputs.json').write_text(json.dumps({n:sha(folder/n) for n in ['notebook-inventory.json','notebook-targets.jsonl','notebook-original-face.json','notebook-layout.json']},indent=2)+'\n')

def notebook_plan(objects,generator,new_face):
 inv,targets=load_inputs();local=Path(__file__).with_name('notebook-original-face.json')
 if local.exists():old_face=json.loads(local.read_text())
 else:old_face=json.loads((ROOT/'assets/source-v2/trees/57009919ee-sharedassets0.assets-3323.json').read_text())['m_FaceInfo']
 plan={};receipt=[]
 for row in inv['rows']:
  pid=row['pathId'];value=read_tree(objects[pid],generator)
  assert canonical(value)==canonical(row['sourceTree']),('notebook-before-tree',pid)
  if row['classification']!='display':continue
  assert row['kind']=='TextMeshProUGUI' and value['m_fontAsset']=={'m_FileID':5,'m_PathID':3323}
  unit=targets[row['id']];assert unit['source']==value['m_text']
  fixed=copy.deepcopy(value);fixed['m_text']=unit['target'];fixed['m_lineSpacing']=metric_spacing(old_face,new_face,value['m_lineSpacing']);plan[pid]=fixed
  receipt.append(dict(id=row['id'],source=unit['source'],target=unit['target'],hierarchy=row['hierarchy'],sourceLineSpacing=value['m_lineSpacing'],targetLineSpacing=fixed['m_lineSpacing']))
 assert len(receipt)==156
 # Multiline face/glow copies must inherit the hidden preferred-height provider.
 # Their old fixed50-unit rects become insufficient after corrected line metrics.
 by_rect={r['rectId']:r for r in inv['rows'] if r['classification']=='display'}
 inherited=[]
 for row in by_rect.values():
  if not row['lineEndings']:continue
  rect=row['sourceRect'];parent=by_rect.get(rect['m_Father']['m_PathID'])
  if parent is None or parent['source']!=row['source']:continue
  assert rect['m_Pivot']['y']==.5,('notebook-layer-pivot',row['rectId'])
  value=read_tree(objects[row['rectId']],generator);assert canonical(value)==canonical(rect),('notebook-layer-before',row['rectId'])
  fixed=copy.deepcopy(rect);fixed['m_AnchorMin']['y']=0.;fixed['m_AnchorMax']['y']=1.;fixed['m_SizeDelta']['y']=0.;plan[row['rectId']]=fixed
  inherited.append(row['rectId'])
 assert len(inherited)==30 and len(plan)==186

 # Reuse the existing single-field title variant instead of English manual kerning.
 # Its inline enlarged initial and complete translated word share normal TMP flow.
 for row in load_layout():
  pid=row['pathId'];value=read_tree(objects[pid],generator)
  assert canonical(value)==canonical(row['sourceTree']),('notebook-title-before',pid)
  fixed=copy.deepcopy(value);fixed['m_IsActive']=row['targetActive'];plan[pid]=fixed
 assert len(plan)==196

 return plan,receipt
