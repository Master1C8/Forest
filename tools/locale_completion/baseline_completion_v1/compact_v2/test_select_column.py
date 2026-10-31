"""Selector guards with the real sparse-cell codec, independent of Unity loads."""
import copy
import importlib.util
import json
from pathlib import Path
import struct
import sys
import unittest

from build import encode, select_column

ROOT = Path(__file__).resolve().parents[4]
sys.path.insert(0, str(ROOT / 'tools'))
from russian_bio_input_case import encode_cells, replace_columns

spec = importlib.util.spec_from_file_location('compact_test_codec', ROOT / 'localization/source/bgdatabase-20261027/decode_inventory.py')
codec = importlib.util.module_from_spec(spec)
spec.loader.exec_module(codec)


class ExactColumnGuards(unittest.TestCase):
    def test_full_binary_text_tree_roundtrip(self):
        raw = b'\xff\xfe\x00German \xc3\xbc'
        tree = {'m_Script': raw.decode('utf-8', errors='surrogateescape')}
        restored = json.loads(encode(tree))
        self.assertEqual(restored['m_Script'].encode('utf-8', errors='surrogateescape'), raw)

    def setUp(self):
        self.blob = struct.pack('<iiiii', 2, 1, 4, 0, 12) + b'keepThe Bell'
        self.data = b'head' + struct.pack('<i', len(self.blob)) + self.blob + b'after'
        self.field = dict(id='f', name='bio_text', valuesOffset=8, valuesBytes=len(self.blob))
        self.env = dict(sheets=[dict(id='s', name='BioKeyword', rowIds=['a', 'b', 'null'], fields=[self.field])])
        self.row = dict(id='bgdb:resources.assets:320/sheet/s/row/a/field/f', previousTarget='The Bell', target='Bell')

    def apply(self, env=None, selected=None):
        return select_column(self.env if env is None else env, self.data,
                             [self.row] if selected is None else selected,
                             codec, encode_cells, replace_columns)

    def test_sparse_order_nulls_and_substring_replacement_then_reverse(self):
        result, old = self.apply()
        field = dict(self.field, valuesBytes=len(result) - 13)
        cells, _ = codec.variable_cells(dict(field, valuesHex=result[8:-5].hex()), 3)
        self.assertEqual(cells, [b'Bell', b'keep', None])
        self.assertEqual(replace_columns(result, [(field, old[('s', 'f')])]), self.data)
        with self.assertRaisesRegex(ValueError, '^exact-old-value:'):
            select_column(dict(sheets=[dict(self.env['sheets'][0], fields=[field])]), result,
                          [self.row], codec, encode_cells, replace_columns)

    def test_wrong_row_with_all_other_guards_satisfied(self):
        wrong = dict(self.row, id=self.row['id'].replace('/row/a/', '/row/b/'))
        with self.assertRaisesRegex(ValueError, '^exact-old-value:'):
            self.apply(selected=[wrong])
        self.assertNotEqual(self.apply()[0], self.data)

    def test_missing_row_identity(self):
        wrong = dict(self.row, id=self.row['id'].replace('/row/a/', '/row/missing/'))
        with self.assertRaisesRegex(ValueError, '^exact-row-identity$'):
            self.apply(selected=[wrong])

    def test_non_display_column_rejected_even_with_matching_values(self):
        env = copy.deepcopy(self.env)
        env['sheets'][0]['fields'][0]['name'] = 'control_key'
        with self.assertRaisesRegex(ValueError, '^exact-display-column$'):
            self.apply(env=env)
        self.assertNotEqual(self.apply()[0], self.data)

    def test_duplicate_selection_and_unknown_field_reject(self):
        with self.assertRaisesRegex(ValueError, '^duplicate-selected-id$'):
            self.apply(selected=[self.row, self.row])
        with self.assertRaisesRegex(ValueError, '^complete-selected-column-coverage$'):
            self.apply(selected=[dict(self.row, id=self.row['id'] + 'missing')])


if __name__ == '__main__':
    unittest.main()
