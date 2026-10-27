"""Complete Quest projection and guarded append coverage;runtime IL/UI receipts are separate."""
import copy,hashlib,json,unittest
from pathlib import Path
from unittest.mock import patch
import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from extract_assets import read_tree
import russian_quest_family as quest
import quest_supplement as supplement
from russian_actor_names import encode_cells,replace_columns
from russian_preview_ui import load_bg_parser
ROOT=Path('/Users/antonkrutov/Desktop/Forest')
class QuestFamilyTests(unittest.TestCase):
 @classmethod
 def setUpClass(cls):
  d=ROOT/'localization/previews/ru-20261028-notebook-final/game/The Forest of Love_Data';g=TypeTreeGenerator('2020.3.24f1');g.load_local_dll_folder(str(d/'Managed'));o=next(o for o in UnityPy.load(str(d/'resources.assets')).objects if o.path_id==320);cls.before=read_tree(o,g)['m_Script'].encode('utf-8',errors='surrogateescape');parse,cells=load_bg_parser();cls.parse=staticmethod(parse);cls.cells=staticmethod(cells)
 def test_complete_177_cells_18_nulls_and_whole_payload_restoration(self):
  after,r=quest.project_quest_family(self.before,self.parse,self.cells);self.assertEqual(r['displayCells'],177);self.assertEqual(r['nullStatesPreserved'],18);self.assertTrue(r['exactReadback']);self.assertTrue(r['wholePayloadRestoration']);self.assertNotEqual(after,self.before)
  inv,records,_=quest.load_inputs();targets={x['id']:x['target'] for x in records};env=self.parse(after)
  for state in inv['sourceStates']:
   sheet=next(s for s in env['sheets'] if s['id']==state['sheetId']);f=next(f for f in sheet['fields'] if f['id']==state['fieldId']);blob=after[f['valuesOffset']:f['valuesOffset']+f['valuesBytes']];values,_=self.cells(dict(f,valuesHex=blob.hex()),len(sheet['rowIds']));self.assertEqual(values[state['rowIndex']],None if state['source'] is None else targets[state['id']].encode())
 def test_repeat_rejected_by_exact_before_payload(self):
  after,_=quest.project_quest_family(self.before,self.parse,self.cells)
  with self.assertRaisesRegex(AssertionError,'quest-family-before-payload'):quest.project_quest_family(after,self.parse,self.cells)
 def test_changed_cell_rejected_after_satisfying_payload_guard(self):
  inv,rows,before=quest.load_inputs();state=next(r for r in inv['sourceStates'] if r['source'] is not None and r['id'] not in before['retainedTargets']);env=self.parse(self.before);sheet=next(s for s in env['sheets'] if s['id']==state['sheetId']);f=next(f for f in sheet['fields'] if f['id']==state['fieldId']);blob=self.before[f['valuesOffset']:f['valuesOffset']+f['valuesBytes']];cells,_=self.cells(dict(f,valuesHex=blob.hex()),len(sheet['rowIds']));cells[state['rowIndex']]=b'Unexpected owner text';changed=replace_columns(self.before,[(f,encode_cells(blob,cells))]);approved=copy.deepcopy(before);approved['inputPayloadSha256']=hashlib.sha256(changed).hexdigest()
  with patch.object(quest,'load_inputs',return_value=(inv,rows,approved)):
   with self.assertRaisesRegex(AssertionError,'quest-family-source-cell'):quest.project_quest_family(changed,self.parse,self.cells)
 def test_changed_technical_column_rejected_after_payload_guard(self):
  inv,rows,before=quest.load_inputs();row=inv['preserveExactly'][0];env=self.parse(self.before);sheet=next(s for s in env['sheets'] if s['id']==row['sheetId']);f=next(f for f in sheet['fields'] if f['id']==row['fieldId']);blob=bytearray(self.before[f['valuesOffset']:f['valuesOffset']+f['valuesBytes']]);blob[-1]^=1;changed=replace_columns(self.before,[(f,bytes(blob))]);approved=copy.deepcopy(before);approved['inputPayloadSha256']=hashlib.sha256(changed).hexdigest()
  with patch.object(quest,'load_inputs',return_value=(inv,rows,approved)):
   with self.assertRaisesRegex(AssertionError,'protected-quest-column'):quest.project_quest_family(changed,self.parse,self.cells)
 def test_all30_append_exact_712_and_199_targets(self):
  folder=supplement.PACKET;scope=json.loads((folder/'locale-scope.json').read_text());self.assertEqual(len(scope['targetLocales']),30)
  for locale in scope['targetLocales']:
   current=(folder/(locale+'.jsonl')).read_bytes();prior=(folder/'history/before-quests'/(locale+'.jsonl')).read_bytes();self.assertTrue(current.startswith(prior),locale);rows=[json.loads(l) for l in current.splitlines()];self.assertEqual(len(rows),935);self.assertEqual(rows[712:911],supplement.new_records(locale));self.assertEqual(len(supplement.words(locale)),157)
 def test_unknown_locale_rejected_before_reading_a_fallback(self):
  with self.assertRaisesRegex(AssertionError,'Explicit supported locale required'):supplement.words('xx')
if __name__=='__main__':unittest.main()
