"""Source-bound Russian preview display fields and TMP face-metric compensation.

No identity substitutions or per-string whitespace normalization. BGDatabase framing
is parsed by the existing pinned v5 reader. The complete two-column Actor display map is applied;
every other column blob and all schema/row identities are compared after decoding.
"""
import copy
import hashlib
import struct
from russian_actor_names import project_actor_display, verify_actor_projection

WARNING_TEXT = {
 'This is an <u>ADULT GAME</u> featuring a ton\nof <u>EXPLICIT CONTENT.</u>':
 'Это <u>ИГРА ДЛЯ ВЗРОСЛЫХ</u> с обилием\n<u>ОТКРОВЕННОГО КОНТЕНТА.</u>',
 'This is an <color=#EE1005><u>ADULT GAME</u></color> featuring a ton\nof <color=#EE1005><u>EXPLICIT CONTENT.</u></color>':
 'Это <color=#EE1005><u>ИГРА ДЛЯ ВЗРОСЛЫХ</u></color> с обилием\n<color=#EE1005><u>ОТКРОВЕННОГО КОНТЕНТА.</u></color>',
 'If you are a kid, <u>GET OUTA HERE!</u>\nIf not, please enjoy!':
 'Если ты ребёнок, <u>УХОДИ ОТСЮДА!</u>\nА если нет — приятной игры!',
 'If you are a kid, <color=#EE1005><u>GET OUTA HERE!</u></color>\nIf not, please enjoy!':
 'Если ты ребёнок, <color=#EE1005><u>УХОДИ ОТСЮДА!</u></color>\nА если нет — приятной игры!',
}
PRESS_PROMPT = ('Press any key', 'Нажмите любую клавишу')
LOADING = ('<color=#ffffff66>...Loading, please wait...</color></size>',
           '<color=#ffffff66>...Загрузка, пожалуйста, подождите...</color></size>')

def exact_ui_plan(objects, generator, name, prior=None):
 """Fit the actual TMP layout provider, keeping its six face/glow copies together.

 The original prompt has NO SyncUiTextToTMPText binding. Legacy Text is a
 transparent sibling ancestor, not a preferred-width producer. The invisible
 NameContainer TMP implements ILayoutElement; its existing ContentSizeFitter
 fits height only. Its left-anchored visible descendants overflow the fixed
 72-unit width. Fit preferred width and bind the container to the root's actual
 horizontal pivot (right edge on the menu, center on the two page prefabs).
 No font-width guess, source-string shortening or additional runtime code.
 """
 from extract_assets import read_tree
 cache={}; classes={}; plan={}; receipt=[]
 def cls(pid):
  if pid not in classes:
   obj=objects[pid]
   classes[pid]=(obj.parse_monobehaviour_head().m_Script.deref().read().m_ClassName
                 if obj.type.name=='MonoBehaviour' else obj.type.name)
  return classes[pid]
 def source(pid):
  if pid not in cache:cache[pid]=read_tree(objects[pid],generator)
  return cache[pid]
 def edit(pid):
  if pid not in plan:plan[pid]=copy.deepcopy((prior or {}).get(pid,source(pid)))
  return plan[pid]
 def component(go,kind):
  ids=[r['component']['m_PathID'] for r in source(go)['m_Component']
       if cls(r['component']['m_PathID'])==kind]
  assert len(ids)==1, ('ambiguous-prompt-component',go,kind)
  return ids[0]
 tmp=[pid for pid in objects if cls(pid)=='TextMeshProUGUI'
      and source(pid).get('m_text')==PRESS_PROMPT[0]]
 containers=[pid for pid in tmp if source(source(pid)['m_GameObject']['m_PathID'])['m_Name']=='NameContainer']
 expected={'level1':1,'sharedassets0.assets':2}.get(name,0)
 assert len(containers)==expected and len(tmp)==6*expected, ('prompt-inventory',name)
 seen=set()
 for pid in containers:
  go=source(pid)['m_GameObject']['m_PathID']; rect=component(go,'RectTransform')
  image=source(rect)['m_Father']['m_PathID']; root=source(image)['m_Father']['m_PathID']
  root_go=source(root)['m_GameObject']['m_PathID']
  assert source(root_go)['m_Name']=='Press Any Key','prompt-root-binding'
  legacy=component(root_go,'Text'); fitter=component(go,'ContentSizeFitter')
  assert source(legacy)['m_Text']==PRESS_PROMPT[0], 'prompt-legacy-text'
  assert source(fitter)['m_HorizontalFit']==0 and source(fitter)['m_VerticalFit']==2,'prompt-fitter-binding'
  assert source(rect)['m_SizeDelta']['x']==72 and source(image)['m_SizeDelta']['x']==108 and source(root)['m_SizeDelta']['x']==100,'prompt-layout-binding'
  assert source(pid)['m_enableWordWrapping']==0, 'prompt-preferred-width-wrapping'
  descendants=[]
  def walk(r):
   g=source(r)['m_GameObject']['m_PathID']
   descendants.extend(c['component']['m_PathID'] for c in source(g)['m_Component'] if c['component']['m_PathID'] in tmp)
   for c in source(r)['m_Children']:walk(c['m_PathID'])
  walk(rect)
  assert len(descendants)==6 and not seen.intersection(descendants),'prompt-layer-binding'
  seen.update(descendants)
  for p in descendants:edit(p)['m_text']=replace_exact(source(p)['m_text'],*PRESS_PROMPT)
  edit(legacy)['m_Text']=replace_exact(source(legacy)['m_Text'],*PRESS_PROMPT)
  # The hidden native source gets the same embedded Cyrillic-capable face as
  # other native UI, without touching the original font or its other consumers.
  font=source(legacy)['m_FontData']['m_Font']
  assert font=={'m_FileID':5 if name=='level1' else 0,'m_PathID':367},'prompt-legacy-font'
  edit(legacy)['m_FontData']['m_Font']['m_PathID']=369
  pivot=source(root)['m_Pivot']['x']; assert pivot in (.5,1.),'prompt-root-pivot'
  target=edit(rect)
  target['m_AnchorMin']['x']=target['m_AnchorMax']['x']=pivot
  target['m_Pivot']['x']=pivot
  target['m_AnchoredPosition']['x']=f32((pivot-.5)*(source(root)['m_SizeDelta']['x']-source(image)['m_SizeDelta']['x']))
  edit(fitter)['m_HorizontalFit']=2
  receipt.append({'rootRect':root,'containerRect':rect,'preferredWidthProvider':pid,
                  'fitter':fitter,'nativeText':legacy,'layers':descendants,'rootPivot':pivot,
                  'mechanism':'existing TMP ILayoutElement -> ContentSizeFitter preferred width; root pivot alignment',
                  'legacyIsSizingProvider':False,'source':PRESS_PROMPT[0],'target':PRESS_PROMPT[1]})
 assert seen==set(tmp),'unbound-prompt-layer'
 if name in ('level5','level6'):
  candidates=[p for p in objects if cls(p)=='TextMeshProUGUI' and source(p).get('m_text')==LOADING[0]]
  assert candidates==[169 if name=='level5' else 205], 'loading-inventory'
  for p in candidates:
   assert source(p)['m_fontAsset']=={'m_FileID':4,'m_PathID':3323} and source(p)['m_fontSize']==72,'loading-binding'
   edit(p)['m_text']=replace_exact(source(p)['m_text'],*LOADING)
   receipt.append({'pathId':p,'source':LOADING[0],'target':LOADING[1],'preservedSourceAnomaly':'unmatched </size>'})
 return plan,receipt

def f32(x):
 return struct.unpack('<f', struct.pack('<f', x))[0]

def metric_spacing(old, new, spacing):
 """TMP uses lineSpacing * fontSize * .01, independently of face point size.

Preserve authored baseline distance after a face replacement, including its
cap-height scale. This applies to every binding, including outline/glow copies,
not just strings which currently contain an explicit newline. Evidence: shipped
TextMeshProUGUI.GenerateTextMesh IL_0356..037d, 0157..0177, 355e..35a6.
 """
 for face in (old, new):
  assert face['m_PointSize'] > 0 and face['m_Scale'] > 0 and face['m_LineHeight'] > 0, 'invalid-face-metrics'
 return f32(spacing + 100 * (old['m_LineHeight'] * old['m_Scale'] / old['m_PointSize']
                            - new['m_LineHeight'] * new['m_Scale'] / new['m_PointSize']))

def typography_plan(objects, generator, old_face, new_face, font_id, file_id=0, minimum_spacing=None):
 from extract_assets import read_tree
 plan, receipt = {}, []
 for pid,obj in objects.items():
  if obj.type.name != 'MonoBehaviour': continue
  if obj.parse_monobehaviour_head().m_Script.deref().read().m_ClassName != 'TextMeshProUGUI': continue
  tree=read_tree(obj,generator)
  if tree.get('m_fontAsset') != {'m_FileID': file_id, 'm_PathID': font_id}: continue
  before=tree['m_lineSpacing']; tree['m_lineSpacing']=metric_spacing(old_face,new_face,before)
  if minimum_spacing is not None: tree['m_lineSpacing']=max(minimum_spacing,tree['m_lineSpacing'])
  if tree.get('m_text') in WARNING_TEXT: tree['m_text']=WARNING_TEXT[tree['m_text']]
  plan[pid]=tree
  receipt.append({'pathId':pid,'sourceLineSpacing':before,'targetLineSpacing':tree['m_lineSpacing'],
                  'translatedWarning':tree.get('m_text') in WARNING_TEXT.values()})
 return plan, receipt

def replace_exact(value, before, after):
 # Equality, never substring tests: overlapping old/new values remain unambiguous.
 assert before != after, 'ambiguous-replacement'
 assert value == before, 'unexpected-before-value'
 return after

def load_bg_parser():
 from pathlib import Path
 import importlib.util
 local=Path(__file__).with_name('decode_inventory.py')
 path=local if local.is_file() else Path('/Users/antonkrutov/Desktop/Forest/localization/source/bgdatabase-20261027/decode_inventory.py')
 spec=importlib.util.spec_from_file_location('forest_bg_v5',path)
 module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
 return module.parse,module.variable_cells
