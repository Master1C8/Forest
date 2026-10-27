"""Wrap both shared item notification prefabs without changing typography or wording."""
import copy,json,hashlib
from pathlib import Path
from extract_assets import read_tree,canonical
ROOT=Path('/Users/antonkrutov/Desktop/Forest')
SOURCE=ROOT/'localization/source/item-notifications-20261027/layout.json'

def load():
 p=Path(__file__).with_name('item-layout.json')
 if not p.exists():p=SOURCE
 return json.loads(p.read_text())

def placement_input():
 p=Path(__file__).with_name('item-placement.json')
 if not p.exists():p=SOURCE.with_name('placement.json')
 return json.loads(p.read_text())

def snapshot(folder):
 value=load();(folder/'item-layout.json').write_text(json.dumps(value,ensure_ascii=False,indent=2)+'\n')
 (folder/'item-placement.json').write_text(json.dumps(placement_input(),indent=2)+'\n')

def layout_plan(objects,generator):
 inv=load();placement=placement_input();plan={}
 from russian_item_ui import load_inputs
 source,targets=load_inputs()
 glitch={u["pathId"]:targets[u["id"]]["target"] for u in source["units"] if u["family"]=="item-prefab"}
 assert len(glitch)==6
 for row in inv['rows']:
  pid=row['pathId'];before=read_tree(objects[pid],generator)
  assert canonical(before)==canonical(row['text']),('item-layout-text-before',pid)
  target=copy.deepcopy(before);target['m_enableWordWrapping']=1
  if pid in glitch:target['m_text']=glitch[pid]
  plan[pid]=target
  r=row['rectId'];rect=read_tree(objects[r],generator)
  assert canonical(rect)==canonical(row['rect']),('item-layout-rect-before',r)
  # The outer NameContainer declares a 210-unit preferred width in
  # its LayoutElement, but no parent layout driver consumes it. Set that width
  # explicitly inside the shared right-edge group with eight units of padding. Each nested face/glow copy previously retained a dummy
  # 20-unit width and relied on unbounded overflow. Fill the parent's width so
  # every copy wraps at the same real constraint; retain original stroke offsets.
  if rect['m_Pivot']['x']==0:
   target=copy.deepcopy(rect);assert target['m_AnchorMin']['x']==target['m_AnchorMax']['x']==0
   target['m_AnchorMax']['x']=1.;target['m_SizeDelta']['x']=0.;plan[r]=target
  else:
   assert rect['m_Pivot']['x']==.5 and rect['m_SizeDelta']['x']==20
   target=copy.deepcopy(rect);target['m_SizeDelta']['x']=placement['textWidth'];target['m_Pivot']['x']=placement['titlePivotX']
   target['m_AnchoredPosition']['x']=placement['titleAnchoredX'];plan[r]=target
 for row in placement['rows']:
  pid=row['pathId'];value=read_tree(objects[pid],generator)
  assert canonical(value)==canonical(row['source']),('notification-placement-before',pid)
  target=copy.deepcopy(value)
  if row['role']=='group':target['m_SizeDelta']['x']=placement['groupWidth']
  else:target['m_AnchoredPosition']['x']=placement['iconAnchoredX']
  plan[pid]=target
 assert len(plan)==28
 return plan,dict(prefabs=[1279,1284],wrappedTextFields=12,stretchedChildRects=10,constrainedOuterRects=2,outerPreferredWidth=210,groupWidth=320,rightPadding=8,wordingFontsSizesAndStrokeOffsetsPreserved=True)
