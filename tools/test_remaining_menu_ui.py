"""Original-resource guards and retained-translation regressions for menu repair."""
import copy
import json
from pathlib import Path
import unittest
from unittest.mock import patch
import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from extract_assets import read_tree
import russian_menu_ui as menu

ROOT=Path('/Users/antonkrutov/Desktop/Forest')


class RemainingMenuTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        source=ROOT/'localization/previews/ru-20261027-quest-fix/game/The Forest of Love_Data'
        cls.generator=TypeTreeGenerator('2020.3.24f1');cls.generator.load_local_dll_folder(str(source/'Managed'))
        cls.objects={o.path_id:o for o in UnityPy.load(str(source/'level1')).objects}

    def test_all_reported_menu_fields_and_preserved_neighbors(self):
        plan,records=menu.menu_plan(self.objects,self.generator)
        self.assertEqual(len(records),282)
        self.assertEqual(sum(r['changed'] for r in records),204)
        self.assertEqual(len(plan),286)
        for row in records:
            pid=int(row['id'].split(':')[1].split('/')[0]);before=read_tree(self.objects[pid],self.generator)
            restored=copy.deepcopy(plan[pid]);restored['m_text']=before['m_text']
            self.assertEqual(restored,before)

    def test_unexpected_existing_caption_is_rejected(self):
        # All actual font/object/source guards are satisfied; change only one value.
        def changed(obj,generator):
            value=copy.deepcopy(read_tree(obj,generator))
            if obj.path_id==7401:value['m_text']='unrelated text'
            return value
        with patch.object(menu,'read_tree',side_effect=changed):
            with self.assertRaisesRegex(AssertionError,'unexpected-menu-before-value'):
                menu.menu_plan(self.objects,self.generator)

    def test_existing_212_records_preserved_in_every_locale(self):
        folder=ROOT/'localization/supplemental-ui/20261027'
        scope=json.loads((folder/'locale-scope.json').read_text())
        for locale in scope['targetLocales']:
            old=(folder/'history/thirty-locales-before-menu'/f'{locale}.jsonl').read_bytes()
            current=(folder/f'{locale}.jsonl').read_bytes()
            before=[json.loads(line) for line in old.splitlines()]
            after=[json.loads(line) for line in current.splitlines()]
            self.assertEqual(b'\n'.join(current.splitlines()[:212])+b'\n',old,locale)
            self.assertEqual(len(before),212)
            self.assertEqual(after[:212],before,locale)
            self.assertEqual(len(after),446,locale)


if __name__=='__main__':unittest.main()
