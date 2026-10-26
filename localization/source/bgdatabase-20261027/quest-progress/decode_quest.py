#!/usr/bin/env python3
"""Decode the exact QuestProgressLogText spans and five adjacent Quest columns.

Reuse the accepted v5 envelope/Reader without changing InventoryItem evidence.
Does not execute game code, write resources, import drafts or author translations.
"""
import argparse
import base64
import hashlib
import json
from pathlib import Path
import struct
import sys

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent))
from decode_inventory import SOURCE, SOURCE_SHA, Reader, bgid, parse, variable_cells

QUEST_FIELDS = ('name', 'savekey', 'bio_title', 'bio_description', 'initial_progress_log_unlocks')


def sha(data):
    return hashlib.sha256(data).hexdigest()


def decode_cell(kind, value):
    if value is None:
        return None
    if kind in ('BGFieldString', 'BGFieldEntityName', 'BGFieldText'):
        return value.decode('utf-8') if value else None
    if kind == 'BGFieldInt':
        assert len(value) == 4, 'invalid-int-width'
        return struct.unpack('<i', value)[0]
    if kind == 'BGFieldRelationSingle':
        # Shipped FromBytes clears non-16-byte segments. Reject malformed data
        # rather than silently interpreting corrupt bytes as a valid null link.
        assert len(value) in (0, 16), 'invalid-single-relation-width'
        return bgid(value) if value else None
    if kind == 'BGFieldRelationMultiple':
        assert len(value) % 16 == 0, 'invalid-multiple-relation-width'
        return [bgid(value[i:i + 16]) for i in range(0, len(value), 16)]
    raise AssertionError('unclassified-quest-codec: ' + kind)


def encode_cell(kind, value):
    if value is None:
        return b''
    if kind == 'BGFieldInt':
        return struct.pack('<i', value)
    if kind == 'BGFieldRelationSingle':
        return base64.b64decode(value + '==', validate=True)
    if kind == 'BGFieldRelationMultiple':
        return b''.join(base64.b64decode(v + '==', validate=True) for v in value)
    return value.encode('utf-8')


def decode(data):
    assert sha(data) == SOURCE_SHA
    saved = json.loads((HERE.parent / 'inventory-decoded.json').read_text())
    envelope = parse(data)
    assert envelope == saved['envelope']
    result = []
    for original in envelope['sheets']:
        if original['name'] not in ('Quest', 'QuestProgressLogText'):
            continue
        sheet = {k: v for k, v in original.items() if k != 'fields'}
        sheet['fields'], sheet['opaqueFields'] = [], []
        rows = [dict(index=i, id=ident, cells={}, spans={}) for i, ident in enumerate(sheet['rowIds'])]
        for f in original['fields']:
            if sheet['name'] == 'Quest' and f['name'] not in QUEST_FIELDS:
                sheet['opaqueFields'].append(f)
                continue
            f = dict(f)
            kind = f['type'].split(',')[0].rsplit('.', 1)[-1]
            start, size = f['valuesOffset'], f['valuesBytes']
            blob = data[start:start + size]
            assert sha(blob) == f['valuesSha256']
            if kind.startswith('BGFieldRelation'):
                cfg = Reader(bytes.fromhex(f['configHex']))
                assert cfg.integer() == (1 if kind == 'BGFieldRelationSingle' else 2)
                f['targetSheetId'] = cfg.ident()
                if kind == 'BGFieldRelationMultiple':
                    f['allowDuplicates'] = cfg.boolean()
                assert cfg.pos == len(cfg.data)
            if kind == 'BGFieldInt':
                assert len(blob) == 4 * len(rows)
                values = [blob[i * 4:i * 4 + 4] for i in range(len(rows))]
                spans = [dict(offset=start + i * 4, bytes=4) for i in range(len(rows))]
            else:
                values, spans = variable_cells(dict(f, valuesHex=blob.hex()), len(rows))
            for row, value, span in zip(rows, values, spans):
                row['cells'][f['name']] = decode_cell(kind, value)
                row['spans'][f['name']] = span
            sheet['fields'].append(f)
        sheet['rows'] = rows
        result.append(sheet)
    assert [(s['name'], len(s['rows']), len(s['fields'])) for s in result] == [('Quest', 38, 5), ('QuestProgressLogText', 119, 6)]
    return dict(schemaVersion=1, source=str(SOURCE.relative_to(HERE.parents[3])),
                sourceSha256=SOURCE_SHA, decoderSha256=sha(Path(__file__).read_bytes()),
                reusedEnvelopeSha256=sha((HERE.parent / 'inventory-decoded.json').read_bytes()),
                sheets=result, resourceReinsertion='not-run', runtime='not-run', visual='not-run')


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output', type=Path, required=True)
    args = p.parse_args()
    assert not args.output.exists()
    result = decode(SOURCE.read_bytes())
    args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps(dict(logRows=119, logColumns=6, adjacentQuestRows=38, adjacentQuestColumns=5)))


if __name__ == '__main__':
    main()
