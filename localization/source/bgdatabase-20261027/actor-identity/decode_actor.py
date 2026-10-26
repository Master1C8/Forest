#!/usr/bin/env python3
"""Read original Actor39x7 without changing the accepted v5 Reader/codecs."""
import argparse
import hashlib
import json
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
sys.path[:0] = [str(HERE.parent), str(HERE.parent / 'quest-progress'), str(HERE.parent / 'quest-controls')]
from decode_inventory import SOURCE, SOURCE_SHA, parse, variable_cells
from decode_controls import decode_cell, encode_cell

FIELDS = ('name', 'savekey', 'plugin_db_name', 'nameplate_name', 'full_name',
          'exclude_from_save', 'exclude_from_critter_log')


def sha(data):
    return hashlib.sha256(data).hexdigest()


def decode(data):
    assert sha(data) == SOURCE_SHA
    envelope = parse(data)
    assert envelope == json.loads((HERE.parent / 'inventory-decoded.json').read_text())['envelope']
    original = next(s for s in envelope['sheets'] if s['name'] == 'Actor')
    assert [f['name'] for f in original['fields']] == list(FIELDS)
    sheet = {k: v for k, v in original.items() if k != 'fields'}
    sheet['fields'] = []
    rows = [dict(index=i, id=ident, cells={}, spans={}) for i, ident in enumerate(sheet['rowIds'])]
    assert len(rows) == 39
    for f in original['fields']:
        f = dict(f)
        kind = f['type'].split(',')[0].rsplit('.', 1)[-1]
        start, size = f['valuesOffset'], f['valuesBytes']
        blob = data[start:start + size]
        assert sha(blob) == f['valuesSha256']
        if kind == 'BGFieldBool':
            assert len(blob) == len(rows), 'invalid-fixed-column-size'
            values = [blob[i:i+1] for i in range(len(rows))]
            spans = [dict(offset=start+i, bytes=1) for i in range(len(rows))]
        else:
            assert kind in ('BGFieldString', 'BGFieldEntityName')
            values, spans = variable_cells(dict(f, valuesHex=blob.hex()), len(rows))
        for row, value, span in zip(rows, values, spans):
            row['cells'][f['name']] = decode_cell(kind, value)
            row['spans'][f['name']] = span
        sheet['fields'].append(f)
    sheet['rows'] = rows
    return dict(schemaVersion=1, source=str(SOURCE.relative_to(HERE.parents[3])), sourceSha256=SOURCE_SHA,
                decoderSha256=sha(Path(__file__).read_bytes()), sheets=[sheet],
                sourceAcceptance='needs-review; bounded Actor supplement',
                reinsertion='not-run', runtime='not-run', visual='not-run')


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output', required=True, type=Path)
    args = p.parse_args()
    assert not args.output.exists()
    args.output.write_text(json.dumps(decode(SOURCE.read_bytes()), ensure_ascii=False, indent=2) + '\n')
