"""Guard tests; actual Unity serialization is checked by build/check separately."""
import copy
import unittest

from build import plan


class ExactBeforeGuards(unittest.TestCase):
    def setUp(self):
        self.before = {'m_Text': 'The Bell', 'm_IsActive': False,
                       'mask': '???\n', 'font': {'size': 14}}
        self.change = dict(pathId=7, beforeTree=copy.deepcopy(self.before),
                           replace={'/m_Text': 'Bell', '/font/size': 10})

    def test_whole_old_value_and_only_selected_properties(self):
        out = plan({7: self.before}, [self.change])[7]
        self.assertEqual(out, dict(self.before, m_Text='Bell', font={'size': 10}))
        self.assertEqual(out['mask'], '???\n')
        self.assertEqual(self.before['m_Text'], 'The Bell')

    def test_new_substring_inside_old_is_not_already_applied(self):
        out = plan({7: self.before}, [self.change])[7]
        with self.assertRaisesRegex(ValueError, '^before-tree:7$'):
            plan({7: out}, [self.change])
        reverse = dict(pathId=7, beforeTree=out,
                       replace={'/m_Text': 'The Bell', '/font/size': 14})
        self.assertEqual(plan({7: out}, [reverse])[7], self.before)
        with self.assertRaisesRegex(ValueError, '^before-tree:7$'):
            plan({7: self.before}, [reverse])

    def test_unrelated_before_tree_drift_rejects(self):
        changed = copy.deepcopy(self.before)
        changed['mask'] = '???'
        with self.assertRaisesRegex(ValueError, '^before-tree:7$'):
            plan({7: changed}, [self.change])
        self.assertEqual(plan({7: self.before}, [self.change])[7]['mask'], '???\n')

    def test_duplicate_id_rejects_before_applying(self):
        with self.assertRaisesRegex(ValueError, '^duplicate-change$'):
            plan({7: self.before}, [self.change, self.change])


if __name__ == '__main__':
    unittest.main()
