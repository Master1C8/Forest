"""Complete five-page notebook bindings and protection regressions."""
import copy,json,sys,unittest
from pathlib import Path
from unittest.mock import patch
import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from extract_assets import read_tree
import russian_notebook_ui as notebook
import notebook_supplement as supplement
ROOT=Path('/Users/antonkrutov/Desktop/Forest')
class NotebookTests(unittest.TestCase):
 @classmethod
 def setUpClass(cls):
  d=ROOT/'localization/previews/ru-20261027-items-fixed/game/The Forest of Love_Data';cls.gen=TypeTreeGenerator('2020.3.24f1');cls.gen.load_local_dll_folder(str(d/'Managed'));cls.objects={o.path_id:o for o in UnityPy.load(str(d/'sharedassets2.assets')).objects};fonts={o.path_id:o for o in UnityPy.load(str(d/'sharedassets0.assets')).objects};cls.face=read_tree(fonts[3323],cls.gen)['m_FaceInfo']
 def test_all156_fields_and_only_text_spacing_change(self):
  plan,receipt=notebook.notebook_plan(self.objects,self.gen,self.face);self.assertEqual(len(plan),196);self.assertEqual(len(receipt),156)
  inv,_=notebook.load_inputs();self.assertEqual(len(inv['pages']),5)
  for row in inv['rows']:
   if row['classification']!='display':self.assertNotIn(row['pathId'],plan);continue
   value=copy.deepcopy(plan[row['pathId']]);self.assertGreater(value['m_lineSpacing'],0);value['m_text']=row['sourceTree']['m_text'];value['m_lineSpacing']=row['sourceTree']['m_lineSpacing'];self.assertEqual(value,row['sourceTree'])
 def test_wrong_existing_paragraph_rejected(self):
  def changed(obj,g):
   value=copy.deepcopy(read_tree(obj,g))
   if obj.path_id==14053:value['m_text']='Different owner text'
   return value
  with patch.object(notebook,'read_tree',side_effect=changed):
   with self.assertRaisesRegex(AssertionError,'notebook-before-tree'):notebook.notebook_plan(self.objects,self.gen,self.face)
 def test_multiline_children_inherit_height_without_other_rect_changes(self):
  plan,_=notebook.notebook_plan(self.objects,self.gen,self.face);inv,_=notebook.load_inputs();display={r['pathId'] for r in inv['rows'] if r['classification']=='display'};rects={r['rectId']:r['sourceRect'] for r in inv['rows']};selected=set(plan)-display-{r['pathId'] for r in notebook.load_layout()};self.assertEqual(len(selected),30)
  for pid in selected:
   value=copy.deepcopy(plan[pid]);source=rects[pid];self.assertEqual(value['m_AnchorMin']['y'],0);self.assertEqual(value['m_AnchorMax']['y'],1);self.assertEqual(value['m_SizeDelta']['y'],0)
   for field in ['m_AnchorMin','m_AnchorMax','m_SizeDelta']:value[field]['y']=source[field]['y']
   self.assertEqual(value,source)
 def test_existing_complete_title_variant_only_active_states_change(self):
  plan,_=notebook.notebook_plan(self.objects,self.gen,self.face)
  for row in notebook.load_layout():
   value=copy.deepcopy(plan[row['pathId']]);self.assertEqual(value['m_IsActive'],row['targetActive']);value['m_IsActive']=row['sourceTree']['m_IsActive'];self.assertEqual(value,row['sourceTree'])
 def test_changed_existing_child_rect_rejected(self):
  inv,_=notebook.load_inputs();pid=next(r['rectId'] for r in inv['rows'] if r['rectId']==9488)
  def changed(obj,g):
   value=copy.deepcopy(read_tree(obj,g))
   if obj.path_id==pid:value['m_SizeDelta']['x']+=1
   return value
  with patch.object(notebook,'read_tree',side_effect=changed):
   with self.assertRaisesRegex(AssertionError,'notebook-layer-before'):notebook.notebook_plan(self.objects,self.gen,self.face)
 def test_all30_prefixes_headers_and_control_literals(self):
  base=ROOT/'localization/supplemental-ui/20261027';inv,words=supplement.inputs();scope=json.loads((base/'locale-scope.json').read_text())
  for locale in scope['targetLocales']:
   data=(base/(locale+'.jsonl')).read_bytes();old=(base/'history/before-notebook'/(locale+'.jsonl')).read_bytes();self.assertTrue(data.startswith(old));rows=[json.loads(l) for l in data.splitlines()];self.assertEqual(len(rows),712);tail={r['id']:r for r in rows[556:]};gloss=json.loads((ROOT/f'localization/glossary/{locale}.json').read_text())
   for row in inv['rows']:
    if row['classification']!='display':continue
    unit=dict(row,lineEndings=row['lineEndings']);target=tail[row['id']]['target'];supplement.validate(unit,target,words[locale],gloss)
 def test_mixed_crlf_and_trailing_cr_preserved(self):
  inv,words=supplement.inputs();gloss=json.loads((ROOT/'localization/glossary/ru.json').read_text());row=next(r for r in inv['rows'] if r.get('phrase')=='details');target=supplement.render(row,words['ru'],gloss);self.assertEqual(target.count('\r\n'),2);self.assertTrue(target.endswith('\r'));self.assertEqual(target.count('\n'),2)
if __name__=='__main__':unittest.main()
