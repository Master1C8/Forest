import copy,sys,unittest,tempfile
from pathlib import Path
from russian_preview_ui import metric_spacing,replace_exact,project_actor_display,verify_actor_projection,WARNING_TEXT
ROOT=Path('/Users/antonkrutov/Desktop/Forest')
sys.path.insert(0,str(ROOT/'localization/source/bgdatabase-20261027'))
from decode_inventory import SOURCE,parse,variable_cells
class DisplayBoundaryTests(unittest.TestCase):
 def test_clone_cache_only_reuses_exact_original_bytes(self):
  from russian_preview_support import select_clone_source
  with tempfile.TemporaryDirectory() as folder:
   base=Path(folder);source=base/'original';cache=base/'cache'
   source.mkdir();cache.mkdir();(source/'asset').write_bytes(b'original')
   (cache/'asset').write_bytes(b'original')
   self.assertEqual(select_clone_source(source/'asset',source,cache),cache/'asset')
   (cache/'asset').write_bytes(b'translated')
   self.assertEqual(select_clone_source(source/'asset',source,cache),source/'asset')
   (cache/'asset').unlink()
   self.assertEqual(select_clone_source(source/'asset',source,cache),source/'asset')
 def test_exact_overlapping_states_both_directions(self):
  for old,new in [('Scarlett','Scarlett Tenderpaw'),('Scarlett Tenderpaw','Scarlett')]:
   self.assertEqual(replace_exact(old,old,new),new)
   for bad in [new,old+'X','X'+old]:
    with self.assertRaisesRegex(AssertionError,'unexpected-before-value'):replace_exact(bad,old,new)
  with self.assertRaisesRegex(AssertionError,'ambiguous-replacement'):replace_exact('A','A','A')
 def test_real_actor_columns_and_rejection(self):
  original=SOURCE.read_bytes();target,receipt=project_actor_display(original,parse,variable_cells)
  self.assertEqual(len(receipt),2);self.assertTrue(verify_actor_projection(original,target,parse,variable_cells))
  with self.assertRaisesRegex(AssertionError,'unexpected-before-value'):project_actor_display(target,parse,variable_cells)
  env=parse(target);actor=next(s for s in env['sheets'] if s['name']=='Actor');f=next(f for f in actor['fields'] if f['name']=='savekey')
  corrupt=bytearray(target);corrupt[f['valuesOffset']+f['valuesBytes']-1]^=1
  with self.assertRaisesRegex(AssertionError,'unselected-column-changed'):verify_actor_projection(original,bytes(corrupt),parse,variable_cells)
 def test_metric_preserves_authored_line_distance(self):
  a={'m_LineHeight':192.,'m_PointSize':176.,'m_Scale':1.}
  b={'m_LineHeight':98.8916015625,'m_PointSize':86.,'m_Scale':(77/176)/(59/86)}
  for spacing in [-32.,0.,5.]:
   s=metric_spacing(a,b,spacing)
   for size in (16,20,40):
    self.assertAlmostEqual(size*(a['m_LineHeight']/176+spacing*.01),size*(b['m_LineHeight']/86*b['m_Scale']+s*.01),places=5)
   self.assertAlmostEqual(metric_spacing(b,a,s),spacing,places=5)
  with self.assertRaisesRegex(AssertionError,'invalid-face-metrics'):metric_spacing(a,dict(b,m_PointSize=0),-32)
 def test_actual_warning_bindings(self):
  import UnityPy
  from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
  from extract_assets import read_tree
  from russian_preview_ui import typography_plan
  source=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
  gen=TypeTreeGenerator('2020.3.24f1');gen.load_local_dll_folder(str(source/'Managed'))
  objs={o.path_id:o for o in UnityPy.load(str(source/'level1')).objects}
  face={'m_LineHeight':192.,'m_PointSize':176.,'m_Scale':1.}
  new={'m_LineHeight':98.8916015625,'m_PointSize':86.,'m_Scale':(77/176)/(59/86)}
  plan,receipt=typography_plan(objs,gen,face,new,3323,5)
  self.assertEqual(sum(r['translatedWarning'] for r in receipt),12)
  for pid in [7385,7403,7488,7491]:self.assertIn(plan[pid]['m_text'],WARNING_TEXT.values())
  # Identical objects but a different physical face binding must select nothing.
  unrelated,_=typography_plan(objs,gen,face,new,3323,99)
  self.assertEqual(unrelated,{})
 def test_warning_markup_and_all_paragraphs(self):
  import re
  self.assertEqual(len(WARNING_TEXT),4)
  for before,after in WARNING_TEXT.items():
   self.assertEqual(re.findall('<[^>]+>',before),re.findall('<[^>]+>',after))
   self.assertEqual(before.count('\n'),after.count('\n'))
 def test_real_prompt_provider_layout_and_binding_rejections(self):
  import UnityPy
  from unittest.mock import patch
  from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
  import extract_assets
  from russian_preview_ui import exact_ui_plan,PRESS_PROMPT
  source=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
  gen=TypeTreeGenerator('2020.3.24f1');gen.load_local_dll_folder(str(source/'Managed'))
  for name,groups in [('level1',1),('sharedassets0.assets',2)]:
   objs={o.path_id:o for o in UnityPy.load(str(source/name)).objects}
   plan,receipt=exact_ui_plan(objs,gen,name)
   self.assertEqual(len(receipt),groups)
   for r in receipt:
    self.assertEqual(len(r['layers']),6)
    for pid in r['layers']:self.assertEqual(plan[pid]['m_text'],PRESS_PROMPT[1])
    self.assertEqual(plan[r['nativeText']]['m_Text'],PRESS_PROMPT[1])
    self.assertEqual(plan[r['fitter']]['m_HorizontalFit'],2)
    rect=plan[r['containerRect']];pivot=r['rootPivot']
    self.assertEqual(rect['m_Pivot']['x'],pivot)
    # Unity fitter grows about pivot. Child origins follow the container's
    # left edge: right bound stays at root right for any preferred width;
    # centered pages remain centered. Widths exercise English and Russian.
    for width in (72.,150.,220.):
     center=rect['m_AnchoredPosition']['x']+(pivot-.5)*108
     left=center-pivot*width;right=left+width
     if pivot==1:self.assertEqual(right,50.)
     else:self.assertEqual((left+right)/2,0.)
   if name=='level1':
    real=extract_assets.read_tree
    for pid,key,value,reason in [(9204,'m_Text','unrelated','prompt-legacy-text'),(7807,'m_enableWordWrapping',1,'prompt-preferred-width-wrapping')]:
     def changed(obj,g):
      t=copy.deepcopy(real(obj,g))
      if obj.path_id==pid:t[key]=value
      return t
     with patch.object(extract_assets,'read_tree',side_effect=changed):
      with self.assertRaisesRegex(AssertionError,reason):exact_ui_plan(objs,gen,name)
 def test_real_loading_and_back_fields(self):
  import UnityPy,re,json
  from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
  from extract_assets import read_tree,canonical
  from russian_preview_ui import exact_ui_plan,LOADING
  source=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
  gen=TypeTreeGenerator('2020.3.24f1');gen.load_local_dll_folder(str(source/'Managed'))
  for name,pid,prefix in [('level5',169,'7b48a89633'),('level6',205,'9af90235c7')]:
   objs={o.path_id:o for o in UnityPy.load(str(source/name)).objects}
   original=read_tree(objs[pid],gen)
   self.assertEqual(canonical(original),json.loads((ROOT/f'assets/source-v2/trees/{prefix}-{name}-{pid}.json').read_text()))
   plan,receipt=exact_ui_plan(objs,gen,name)
   self.assertEqual(set(plan),{pid});self.assertEqual(plan[pid]['m_text'],LOADING[1])
   restored=copy.deepcopy(plan[pid]);restored['m_text']=LOADING[0];self.assertEqual(restored,original)
   self.assertEqual(re.findall('<[^>]+>',LOADING[0]),re.findall('<[^>]+>',LOADING[1]))
  from build_russian_preview import MENU_ACTUAL
  self.assertEqual(MENU_ACTUAL['Back'],'Назад')
  objs={o.path_id:o for o in UnityPy.load(str(source/'level1')).objects}
  actual=[]
  for obj in objs.values():
   if obj.type.name=='MonoBehaviour' and obj.parse_monobehaviour_head().m_Script.deref().read().m_ClassName=='TextMeshProUGUI':
    t=read_tree(obj,gen)
    if t.get('m_text')=='Back':actual.append(obj.path_id)
  self.assertEqual(len(actual),36)
if __name__=='__main__':unittest.main()
