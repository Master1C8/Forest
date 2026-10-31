"""Selector-recovery boundary regressions; actual Unity readback is run separately."""
import importlib.util
from pathlib import Path
import tempfile
import unittest
import json
import sys

SPEC = importlib.util.spec_from_file_location('baseline_recovery', Path(__file__).parent /
    'locale_completion/baseline_completion_v1/recover.py')
RECOVERY = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(RECOVERY)

EXT_SPEC = importlib.util.spec_from_file_location('baseline_recovery_extended', Path(__file__).parent /
    'locale_completion/baseline_completion_v1/recover_extended.py')
EXTENDED = importlib.util.module_from_spec(EXT_SPEC)
EXT_SPEC.loader.exec_module(EXTENDED)


class RecoveryBoundaries(unittest.TestCase):
    def test_family_overlap_retains_distinct_context_and_nulls(self):
        a = dict(family='pause', id='asset:1/m_text', context=False, target=None)
        b = dict(family='ornamental', id=a['id'], context=0, target='')
        result = RECOVERY.memberships([a, b], ['pause', 'ornamental'])
        self.assertEqual(list(result), [a['id']])
        self.assertEqual(result[a['id']], [a, b])
        self.assertIs(result[a['id']][0]['context'], False)
        self.assertIsNone(result[a['id']][0]['target'])
        self.assertEqual(result[a['id']][1]['target'], '')
        with self.assertRaisesRegex(ValueError, '^duplicate-or-empty-memberships$'):
            RECOVERY.memberships([a, a], ['pause', 'ornamental'])

    def test_exact_pin_rejects_mutated_input_with_same_path(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory).resolve()
            path = root / 'input.jsonl'
            path.write_bytes(b'original\r\n')
            pin = dict(path=path.name, sha256=RECOVERY.digest(path.read_bytes()))
            self.assertEqual(RECOVERY.pinned(root, pin), path)
            path.write_bytes(b'original\n')
            with self.assertRaisesRegex(ValueError, '^input-pin:input.jsonl$'):
                RECOVERY.pinned(root, pin)

    def test_external_path_rejected_even_with_correct_digest(self):
        with tempfile.TemporaryDirectory() as directory:
            parent = Path(directory).resolve()
            root = parent / 'project'
            root.mkdir()
            inside, outside = root / 'value', parent / 'value'
            inside.write_bytes(b'same')
            outside.write_bytes(b'same')
            digest = RECOVERY.digest(b'same')
            self.assertEqual(RECOVERY.pinned(root, dict(path='value', sha256=digest)), inside)
            with self.assertRaisesRegex(ValueError, '^input-outside-project$'):
                RECOVERY.pinned(root, dict(path='../value', sha256=digest))


class ActualBundleBoundaries(unittest.TestCase):
    """Real pinned Unity input, not a mock of member/path resolution."""
    @classmethod
    def setUpClass(cls):
        root = Path(__file__).resolve().parents[1]
        phase = root/'outputs/locale-assets-20261026/de/workflow-v3-completion-20261030/0091-work'
        config = json.loads((phase/'recovery-request.json').read_bytes())
        engine = RECOVERY.pinned(root, config['engineManifest']).parent
        sys.path[:0] = [str(engine/'vendor'), str(engine/'engine')]
        import UnityPy
        import extract_assets
        from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
        cls.ex = extract_assets
        cls.generator = TypeTreeGenerator('2020.3.24f1')
        cls.generator.load_local_dll_folder(str(engine/'source/Managed'))
        cls.ident = next(r['id'] for r in EXTENDED.rows(RECOVERY.pinned(root, config['inventories'][1]))
                         if '!/' in r['id'] and ':-' in r['id'])
        asset = EXTENDED.selector(cls.ident)[0]
        cls.env = UnityPy.load(str(RECOVERY.pinned(root, config['resources']['source'][asset])))
        cls.source = next(r['sourceValue'] for r in EXTENDED.rows(RECOVERY.pinned(root, config['inventories'][1])) if r['id'] == cls.ident)
        cls.plain = UnityPy.load(str(RECOVERY.pinned(root, config['resources']['source']['level23'])))
        cls.plain.path = str(engine/'source')

    def test_actual_bundle_negative_id_and_literal_source(self):
        obj, field = EXTENDED.object_for(self.env, self.ident)
        self.assertLess(obj.path_id, 0)
        self.assertEqual(self.ex.read_tree(obj, self.generator)[field], self.source)

    def test_wrong_cab_rejects_before_path_resolution(self):
        asset, member, pid, field = EXTENDED.selector(self.ident)
        with self.assertRaisesRegex(ValueError, '^serialized-member-identity:'):
            EXTENDED.object_for(self.env, f'{asset}!/CAB-wrong:{pid}/{field}')
        # Same real ID remains a positive control when only the member is restored.
        self.assertEqual(EXTENDED.object_for(self.env, self.ident)[0].path_id, pid)

    def test_wrong_signed_path_rejects_at_path_boundary(self):
        asset, member, pid, field = EXTENDED.selector(self.ident)
        self.assertNotIn(-pid, self.env.assets[0].objects)
        with self.assertRaisesRegex(ValueError, '^serialized-path-id:'):
            EXTENDED.object_for(self.env, f'{asset}!/{member}:{-pid}/{field}')

    def test_actual_plain_resource_consumer_remains_supported(self):
        obj, field = EXTENDED.object_for(self.plain, 'level23:770/m_Text')
        self.assertEqual(self.ex.read_tree(obj, self.generator)[field], 'Hits: 0')


if __name__ == '__main__':
    unittest.main()
