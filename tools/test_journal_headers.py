"""Journal header source/approved-term contracts;Unity serialization/native rendering are separate."""
import copy,json,unittest
from pathlib import Path
from types import SimpleNamespace
from unittest.mock import patch
import journal_header_ui as h
ROOT=Path('/Users/antonkrutov/Desktop/Forest')
class Headers(unittest.TestCase):
 def trees(self):
  inv=h.inventory();trees={r['pathId']:r['sourceTree'] for r in inv['rows']};trees.update({i:{'m_Enabled':0} for i in [18877,18883]});return inv,trees,{i:SimpleNamespace(path_id=i) for i in trees}
 def test_all24_only_text_and_disabled_legacy_images(self):
  inv,trees,objects=self.trees()
  with patch('extract_assets.read_tree',side_effect=lambda o,g:copy.deepcopy(trees[o.path_id])):plan,r=h.plan(objects,None)
  self.assertEqual(len(plan),24);self.assertTrue(r['legacyImagesRemainDisabled'])
  for row in inv['rows']:
   value=copy.deepcopy(plan[row['pathId']]);self.assertNotEqual(value['m_text'],row['source']);value['m_text']=row['source'];self.assertEqual(value,row['sourceTree'])
 def test_changed_font_field_rejected_after_valid_ids_and_source(self):
  inv,trees,objects=self.trees();trees=copy.deepcopy(trees);trees[inv['rows'][0]['pathId']]['m_fontSize']+=1
  with patch('extract_assets.read_tree',side_effect=lambda o,g:copy.deepcopy(trees[o.path_id])):
   with self.assertRaisesRegex(AssertionError,'journal-header-before-tree'):h.plan(objects,None)
 def test_all30_exact935_and_prior911_prefix(self):
  scope=json.loads((h.PACKET/'locale-scope.json').read_text())
  for locale in scope['targetLocales']:
   raw=(h.PACKET/(locale+'.jsonl')).read_bytes();old=(h.PACKET/'history/before-journal-headers'/(locale+'.jsonl')).read_bytes();self.assertTrue(raw.startswith(old));rows=[json.loads(l) for l in raw.splitlines()];self.assertEqual(len(rows),935);self.assertEqual(rows[911:],h.records(locale));g=json.loads((ROOT/'localization/glossary'/(locale+'.json')).read_text())
   for unit,target in zip(h.inventory()['rows'],rows[911:]):self.assertTrue(h.validate(unit,target['target'],g,locale))
 def test_unsupported_locale_rejected_without_fallback(self):
  with self.assertRaises(AssertionError):h.records('xx')
if __name__=='__main__':unittest.main()
