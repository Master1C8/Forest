"""Original-asset selector and pointer preservation checks; no renderer mock."""
import copy
from pathlib import Path
import unittest

import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from extract_assets import read_tree
from russian_native_font_roles import native_role_plan, apply_native_role

SOURCE = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')


class NativeRoles(unittest.TestCase):
    def test_complete_real_selection_and_rejection(self):
        generator = TypeTreeGenerator('2020.3.24f1')
        generator.load_local_dll_folder(str(SOURCE / 'Managed'))
        selected = set()
        for name in ['sharedassets0.assets', 'sharedassets2.assets']:
            env = UnityPy.load(str(SOURCE / name))
            objects = {o.path_id: o for o in env.objects}
            plan, receipt = native_role_plan(objects, generator, name)
            self.assertEqual(len(receipt), len(plan))
            for pid, target in plan.items():
                selected.add((name, pid))
                original = read_tree(objects[pid], generator)
                before = copy.deepcopy(original)
                changed = apply_native_role(original, target)
                self.assertEqual(original, before)
                self.assertEqual(changed['m_FontData']['m_Font']['m_PathID'], 369)
                with self.assertRaisesRegex(AssertionError, 'before-state'):
                    apply_native_role(changed, target)
                changed['m_FontData']['m_Font']['m_PathID'] = 367
                self.assertEqual(changed, before)
                if target['m_FileID']:
                    self.assertEqual(objects[pid].assets_file.externals[target['m_FileID'] - 1].path, 'sharedassets0.assets')
                missing = dict(objects)
                del missing[pid]
                with self.assertRaisesRegex(AssertionError, 'missing-native-font-role'):
                    native_role_plan(missing, generator, name)
        self.assertEqual(selected, {('sharedassets0.assets', 3695), ('sharedassets2.assets', 17264), ('sharedassets2.assets', 17286)})


if __name__ == '__main__':
    unittest.main()
