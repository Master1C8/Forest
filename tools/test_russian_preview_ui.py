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
if __name__=='__main__':unittest.main()
