"""Source-state, database preservation and all-locale acquisition regressions."""
import copy,json,sys,unittest,subprocess,tempfile
from pathlib import Path
from unittest.mock import patch
import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from extract_assets import read_tree
import russian_item_ui as item
from russian_actor_names import replace_columns,encode_cells
ROOT=Path('/Users/antonkrutov/Desktop/Forest')
sys.path.insert(0,str(ROOT/'localization/source/bgdatabase-20261027'))
from decode_inventory import parse,variable_cells
class ItemTests(unittest.TestCase):
 @classmethod
 def setUpClass(cls):
  data=ROOT/'localization/previews/ru-20261027-menu-fix/game/The Forest of Love_Data'
  gen=TypeTreeGenerator('2020.3.24f1');gen.load_local_dll_folder(str(data/'Managed'))
  obj=next(o for o in UnityPy.load(str(data/'resources.assets')).objects if o.path_id==320)
  cls.before=read_tree(obj,gen)['m_Script'].encode('utf-8',errors='surrogateescape')
 def test_positive_complete_patch_and_readback(self):
  after,r=item.project_item_display(self.before,parse,variable_cells)
  self.assertEqual(r['selectedCells'],96);self.assertTrue(r['fullPayloadRestored']);self.assertNotEqual(self.before,after)
 def test_unexpected_cell_rejected_at_intended_boundary(self):
  inv,_=item.load_inputs();_,cols=item.columns(self.before,parse,variable_cells,inv)
  field,blob,cells=cols['title'];cells[0]=b'unexpected owner value'
  changed=replace_columns(self.before,[(field,encode_cells(blob,cells))])
  with self.assertRaisesRegex(AssertionError,'unexpected-item-before'):item.project_item_display(changed,parse,variable_cells)
 def test_technical_savekey_rejected(self):
  env=parse(self.before);sheet=next(s for s in env['sheets'] if s['name']=='InventoryItem');field=next(f for f in sheet['fields'] if f['name']=='savekey')
  blob=self.before[field['valuesOffset']:field['valuesOffset']+field['valuesBytes']];changed=replace_columns(self.before,[(field,blob.replace(b'bottle_of_lube',b'bottle_of_Lube'))])
  with self.assertRaisesRegex(AssertionError,'protected-item-column'):item.project_item_display(changed,parse,variable_cells)
 def test_repeat_is_rejected_as_already_localized(self):
  after,_=item.project_item_display(self.before,parse,variable_cells)
  with self.assertRaisesRegex(AssertionError,'unexpected-item-before'):item.project_item_display(after,parse,variable_cells)
 def test_all_30_append_only_packets_and_glossary_bindings(self):
  folder=ROOT/'localization/supplemental-ui/20261027';scope=json.loads((folder/'locale-scope.json').read_text());inv,_=item.load_inputs()
  for locale in scope['targetLocales']:
   raw=(folder/(locale+'.jsonl')).read_bytes();old=(folder/'history/thirty-locales-before-items'/(locale+'.jsonl')).read_bytes()
   self.assertTrue(raw.startswith(old),locale);records=[json.loads(x) for x in raw.splitlines()];self.assertEqual(len(records),712)
   tail={r['id']:r for r in records[446:556]};gloss=json.loads((ROOT/f'localization/glossary/{locale}.json').read_text())
   self.assertEqual(set(tail),{u['id'] for u in inv['units']})
   for u in inv['units']:
    if 'glossaryId' in u:self.assertEqual(tail[u['id']]['target'],gloss[u['glossaryId']]['term'],(locale,u['id']))
class ManagedItemGuards(unittest.TestCase):
 def test_protected_trigger_cannot_enter_target_scope(self):
  inv,targets=item.load_inputs();rows=[targets[u['id']] for u in inv['units'] if u['family']=='item-code']
  rows.append(dict(id='il:Assembly-CSharp.dll/protected-show-trigger',source='show',target='показать'))
  self.reject(rows,'Exact 8-unit target coverage required')
 def test_wrong_display_source_rejected_after_exact_id_coverage(self):
  inv,targets=item.load_inputs();rows=[copy.deepcopy(targets[u['id']]) for u in inv['units'] if u['family']=='item-code']
  rows[0]['source']='different source'
  self.reject(rows,'Source cell mismatch')
 def reject(self,rows,reason):
  # The assembly and all unrelated coverage guards match; mutate only the named condition.
  with tempfile.TemporaryDirectory(dir=ROOT/'outputs') as tmp:
   p=Path(tmp);(p/'targets.json').write_text(json.dumps(rows,ensure_ascii=False))
   source=ROOT/'localization/previews/ru-20261027-menu-fix/game/The Forest of Love_Data/Managed/Assembly-CSharp.dll'
   r=subprocess.run(['dotnet',str(ROOT/'tools/menu_patch/bin/Debug/net8.0/MenuPatch.dll'),'patch-items',str(source),str(p/'targets.json'),str(p/'output.dll'),str(p/'receipt.json')],text=True,capture_output=True)
   self.assertNotEqual(r.returncode,0);self.assertIn(reason,r.stderr);self.assertFalse((p/'output.dll').exists());self.assertFalse((p/'receipt.json').exists())
if __name__=='__main__':unittest.main()
