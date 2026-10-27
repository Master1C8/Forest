"""Shared notification prefab safety and six-layer width regressions."""
import copy,unittest
from pathlib import Path
from unittest.mock import patch
import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from extract_assets import read_tree
import item_notification_layout as layout
ROOT=Path('/Users/antonkrutov/Desktop/Forest')
class NotificationLayoutTests(unittest.TestCase):
 @classmethod
 def setUpClass(cls):
  data=ROOT/'localization/previews/ru-20261027-item-fix/game/The Forest of Love_Data';cls.gen=TypeTreeGenerator('2020.3.24f1');cls.gen.load_local_dll_folder(str(data/'Managed'));cls.objects={o.path_id:o for o in UnityPy.load(str(data/'sharedassets1.assets')).objects}
 def test_both_game_and_menu_prefabs_all_six_layers(self):
  plan,r=layout.layout_plan(self.objects,self.gen);self.assertEqual(len(plan),28);self.assertEqual(r['wrappedTextFields'],12)
  inv=layout.load();self.assertEqual({x['normal'] for x in inv['controllers']},{1284});self.assertEqual({x['glitch'] for x in inv['controllers']},{1279})
  for row in inv['rows']:
   text=copy.deepcopy(plan[row['pathId']]);self.assertEqual(text.pop('m_enableWordWrapping'),1);original=copy.deepcopy(row['text']);self.assertEqual(original.pop('m_enableWordWrapping'),0);text['m_text']=original['m_text'];self.assertEqual(text,original)
   if row['rectId'] in plan:
    rect=copy.deepcopy(plan[row['rectId']]);rect['m_AnchorMax']['x']=row['rect']['m_AnchorMax']['x'];rect['m_SizeDelta']['x']=row['rect']['m_SizeDelta']['x'];rect['m_Pivot']['x']=row['rect']['m_Pivot']['x'];rect['m_AnchoredPosition']['x']=row['rect']['m_AnchoredPosition']['x'];self.assertEqual(rect,row['rect'])
 def test_unexpected_font_cannot_be_overwritten(self):
  def changed(obj,gen):
   value=copy.deepcopy(read_tree(obj,gen))
   if obj.path_id==1250:value['m_fontSize']=17
   return value
  with patch.object(layout,'read_tree',side_effect=changed):
   with self.assertRaisesRegex(AssertionError,'item-layout-text-before'):layout.layout_plan(self.objects,self.gen)
if __name__=='__main__':unittest.main()
