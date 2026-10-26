#!/usr/bin/env python3
"""Decode BioDetail18x10 and only its referenced BioKeyword rows, read-only."""
import argparse
import hashlib
import json
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
sys.path[:0] = [str(HERE.parent), str(HERE.parent/'quest-progress'), str(HERE.parent/'quest-controls')]
from decode_inventory import SOURCE, SOURCE_SHA, Reader, parse, variable_cells
from decode_controls import decode_cell, encode_cell

FIELDS = ('name', 'actor', 'bio_portrait', 'nameplate_name_override', 'full_name_override',
          'line1', 'line2', 'line3', 'enable_with_tags', 'is_default')


def sha(data):
    return hashlib.sha256(data).hexdigest()


def sheet_decode(original, data, selected=None):
    sheet = {k:v for k,v in original.items() if k != 'fields'}
    sheet['fields'] = []
    rows = [dict(index=i, id=ident, cells={}, spans={}) for i,ident in enumerate(sheet['rowIds'])
            if selected is None or ident in selected]
    for original_field in original['fields']:
        f = dict(original_field)
        kind = f['type'].split(',')[0].rsplit('.',1)[-1]
        start, size = f['valuesOffset'], f['valuesBytes']
        blob = data[start:start+size]
        assert sha(blob) == f['valuesSha256']
        if kind.startswith('BGFieldRelation'):
            cfg = Reader(bytes.fromhex(f['configHex']))
            assert cfg.integer() == (1 if kind == 'BGFieldRelationSingle' else 2)
            f['targetSheetId'] = cfg.ident()
            if kind == 'BGFieldRelationMultiple':
                f['allowDuplicates'] = cfg.boolean()
            assert cfg.pos == len(cfg.data)
        elif kind == 'BGFieldUnitySprite':
            cfg = Reader(bytes.fromhex(f['configHex']))
            assert cfg.integer() == 2
            f['assetConfig'] = dict(version=2, loaderType=cfg.string(), loaderConfigHex=cfg.blob().hex(), locationConstraint=cfg.integer())
            assert f['assetConfig']['loaderType'].split(',')[0] == 'BansheeGz.BGDatabase.BGAssetLoaderAddressables'
            assert cfg.pos == len(cfg.data)
        if kind == 'BGFieldBool':
            assert len(blob) == len(sheet['rowIds']), 'invalid-fixed-column-size'
            values = [blob[i:i+1] for i in range(len(sheet['rowIds']))]
            spans = [dict(offset=start+i, bytes=1) for i in range(len(sheet['rowIds']))]
        else:
            values, spans = variable_cells(dict(f, valuesHex=blob.hex()), len(sheet['rowIds']))
        for row in rows:
            i = row['index']
            row['cells'][f['name']] = decode_cell(kind, values[i])
            row['spans'][f['name']] = spans[i]
        sheet['fields'].append(f)
    sheet['rows'] = rows
    if selected is not None:
        assert {r['id'] for r in rows} == selected
        sheet['coverage'] = 'Only exact BioDetail line1/line2/line3 target rows; remaining rows opaque'
    return sheet


def decode(data):
    assert sha(data) == SOURCE_SHA
    envelope = parse(data)
    assert envelope == json.loads((HERE.parent/'inventory-decoded.json').read_text())['envelope']
    original = next(s for s in envelope['sheets'] if s['name'] == 'BioDetail')
    assert [f['name'] for f in original['fields']] == list(FIELDS)
    sheet = sheet_decode(original, data)
    assert len(sheet['rows']) == 18
    refs = {r['cells'][f] for r in sheet['rows'] for f in ('line1','line2','line3') if r['cells'][f] is not None}
    keyword = sheet_decode(next(s for s in envelope['sheets'] if s['name'] == 'BioKeyword'), data, refs)
    assert [f['name'] for f in keyword['fields']] == ['name','bio_text','savekey','plugin_db_trigger_name']
    return dict(schemaVersion=1, source=str(SOURCE.relative_to(HERE.parents[3])), sourceSha256=SOURCE_SHA,
                decoderSha256=sha(Path(__file__).read_bytes()), sheets=[sheet,keyword],
                sourceAcceptance='needs-review; bounded static BioDetail and referenced BioKeyword supplement',
                reinsertion='not-run', runtime='not-run', visual='not-run', editorial='not-run')


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output',required=True,type=Path)
    args = p.parse_args()
    assert not args.output.exists()
    args.output.write_text(json.dumps(decode(SOURCE.read_bytes()),ensure_ascii=False,indent=2)+'\n')
