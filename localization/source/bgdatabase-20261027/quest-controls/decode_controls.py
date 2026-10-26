#!/usr/bin/env python3
"""Append-only Quest control/Tag identity supplement from the original v5 bytes."""
import argparse
import hashlib
import json
from pathlib import Path
import struct
import sys

HERE = Path(__file__).resolve().parent
sys.path[:0] = [str(HERE.parent), str(HERE.parent / 'quest-progress')]
from decode_inventory import SOURCE, SOURCE_SHA, Reader, parse, variable_cells
from decode_quest import decode_cell as prior_decode, encode_cell as prior_encode

FIELDS = ('plugin_db_name_prefix', 'bio_hidden', 'bio_portrait', 'enable_with_tags',
          'disable_with_tags', 'priority', 'is_side_quest')


def sha(data):
    return hashlib.sha256(data).hexdigest()


def decode_cell(kind, value):
    if value is None:
        return None
    if kind == 'BGFieldBool':
        # Shipped runtime treats any nonzero byte as true. Exact readback only
        # accepts canonical 0/1 so reencoding cannot normalize original bytes.
        assert len(value) == 1, 'invalid-bool-width'
        assert value in (b'\0', b'\1'), 'noncanonical-bool-byte'
        return value == b'\1'
    if kind == 'BGFieldUnitySprite':
        return value.decode('utf-8') if value else None
    return prior_decode(kind, value)


def encode_cell(kind, value):
    if value is None:
        return b''
    if kind == 'BGFieldBool':
        assert type(value) is bool, 'invalid-bool-value'
        return bytes([int(value)])
    return prior_encode(kind, value)


def decode(data):
    assert sha(data) == SOURCE_SHA
    envelope = parse(data)
    assert envelope == json.loads((HERE.parent / 'inventory-decoded.json').read_text())['envelope']
    result = []
    for original in envelope['sheets']:
        if original['name'] not in ('Quest', 'Tag'):
            continue
        sheet = {k: v for k, v in original.items() if k != 'fields'}
        sheet['fields'], sheet['opaqueFields'] = [], []
        rows = [dict(index=i, id=ident, cells={}, spans={}) for i, ident in enumerate(sheet['rowIds'])]
        for f in original['fields']:
            if sheet['name'] == 'Quest' and f['name'] not in FIELDS:
                sheet['opaqueFields'].append(f)
                continue
            f = dict(f); kind = f['type'].split(',')[0].rsplit('.', 1)[-1]
            start, size = f['valuesOffset'], f['valuesBytes']; blob = data[start:start + size]
            assert sha(blob) == f['valuesSha256']
            if kind == 'BGFieldRelationMultiple':
                cfg = Reader(bytes.fromhex(f['configHex']))
                assert cfg.integer() == 2
                f['targetSheetId'], f['allowDuplicates'] = cfg.ident(), cfg.boolean()
                assert cfg.pos == len(cfg.data)
            elif kind == 'BGFieldUnitySprite':
                cfg = Reader(bytes.fromhex(f['configHex']))
                version = cfg.integer(); assert version == 2
                f['assetConfig'] = dict(version=version, loaderType=cfg.string(), loaderConfigHex=cfg.blob().hex(), locationConstraint=cfg.integer())
                assert f['assetConfig']['loaderType'].split(',')[0] == 'BansheeGz.BGDatabase.BGAssetLoaderAddressables'
                assert cfg.pos == len(cfg.data)
            width = {'BGFieldBool': 1, 'BGFieldInt': 4}.get(kind)
            if width:
                assert len(blob) == width * len(rows), 'invalid-fixed-column-size'
                values = [blob[i * width:(i + 1) * width] for i in range(len(rows))]
                spans = [dict(offset=start + i * width, bytes=width) for i in range(len(rows))]
            else:
                values, spans = variable_cells(dict(f, valuesHex=blob.hex()), len(rows))
            for row, value, span in zip(rows, values, spans):
                row['cells'][f['name']] = decode_cell(kind, value)
                row['spans'][f['name']] = span
            sheet['fields'].append(f)
        sheet['rows'] = rows; result.append(sheet)
    assert [(s['name'], len(s['rows']), len(s['fields'])) for s in result] == [('Quest', 38, 7), ('Tag', 18, 2)]
    return dict(schemaVersion=1, source=str(SOURCE.relative_to(HERE.parents[3])), sourceSha256=SOURCE_SHA,
                decoderSha256=sha(Path(__file__).read_bytes()), sheets=result,
                sourceAcceptance='needs-review; supplemental selected fields only', reinsertion='not-run', runtime='not-run', visual='not-run')


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__); p.add_argument('--output', required=True, type=Path)
    args = p.parse_args(); assert not args.output.exists()
    args.output.write_text(json.dumps(decode(SOURCE.read_bytes()), ensure_ascii=False, indent=2) + '\n')
