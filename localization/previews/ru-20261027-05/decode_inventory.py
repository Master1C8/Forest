#!/usr/bin/env python3
"""Read the pinned BGDatabase v5 envelope; decode only InventoryItem cell values.

Static format binding: il-commands.json and the named shipped BGDatabase IL.
Uses the existing Unity exporter input, never executes Unity/game assemblies.
"""
import argparse
import base64
import hashlib
import json
from pathlib import Path
import struct

ROOT = Path(__file__).resolve().parents[3]
SOURCE = ROOT / 'assets/source-v2/text-assets/90744c19ec-resources.assets-320.bin'
SOURCE_SHA = '41834cda2f3ea6f010234f3ca2332e31b95b990ab38a8940b0d92f000477fda9'


def sha(b):
    return hashlib.sha256(b).hexdigest()


def bgid(b):
    assert len(b) == 16
    return base64.b64encode(b).decode()[:22]


class Reader:
    def __init__(self, data, offset=0):
        self.data, self.pos = data, offset

    def take(self, size):
        assert 0 <= size <= len(self.data) - self.pos, (self.pos, size)
        result = self.data[self.pos:self.pos + size]
        self.pos += size
        return result

    def integer(self):
        return struct.unpack('<i', self.take(4))[0]

    def count(self):
        value = self.integer()
        assert 0 <= value <= len(self.data) - self.pos
        return value

    def boolean(self):
        b = self.take(1)
        assert b in (b'\0', b'\1')
        return b == b'\1'

    def ident(self):
        return bgid(self.take(16))

    def blob(self):
        return self.take(self.count())

    def string(self):
        b = self.blob()
        return b.decode('utf-8') if b else None


def parse(data):
    """All framing/row IDs/field blobs consumed; non-inventory values stay opaque."""
    r = Reader(data)
    assert r.integer() == 5
    assert r.take(16) == struct.pack('<Qq', 5208396773359933591, -4045080405667067474)
    addons = []
    for _ in range(r.count()):
        assert r.integer() == 1
        addons.append(dict(type=r.string(), configHex=r.blob().hex()))
    # Exact input has only CodeGen: no compressed/encrypted/lazy interpretation.
    assert len(addons) == 1 and addons[0]['type'].split(',')[0] == 'BansheeGz.BGDatabase.BGAddonCodeGen'
    sheets = []
    for index in range(r.count()):
        start = r.pos
        assert r.integer() == 1
        meta = dict(index=index, id=r.ident(), name=r.string(), type=r.string(),
                    configHex=r.blob().hex(), headerBool1=r.boolean(), headerString1=r.string(),
                    headerBool2=r.boolean(), headerBool3=r.boolean(),
                    headerBool4=r.boolean(), comment=r.string())
        ids_start = r.pos + 4
        ids = r.blob()
        assert len(ids) % 16 == 0
        meta['rowIds'] = [bgid(ids[i:i + 16]) for i in range(0, len(ids), 16)]
        meta['rowIdsOffset'] = ids_start
        assert len(meta['rowIds']) == len(set(meta['rowIds']))
        fields = []
        for fi in range(r.count()):
            field_start = r.pos
            assert r.integer() == 1
            field = dict(index=fi, id=r.ident(), name=r.string(), type=r.string(),
                         configHex=r.blob().hex(), headerBool1=r.boolean(), headerString1=r.string(),
                         headerString2=r.string(), headerBool2=r.boolean(), formatter=r.string(),
                         editor=r.string(), comment=r.string())
            values_start = r.pos + 4
            values = r.blob()
            field.update(offset=field_start, valuesOffset=values_start,
                         valuesBytes=len(values), valuesSha256=sha(values))
            if meta['name'] == 'InventoryItem':
                field['valuesHex'] = values.hex()
            fields.append(field)
        meta['fields'] = fields
        meta['keys'] = []
        for _ in range(r.count()):
            assert r.integer() == 1
            key = dict(id=r.ident(), name=r.string(), unique=r.boolean())
            key['fieldIds'] = [r.ident() for _ in range(r.count())]
            meta['keys'].append(key)
        meta.update(offset=start, endOffset=r.pos)
        assert len(fields) == len({f['id'] for f in fields})
        assert len(fields) == len({f['name'] for f in fields})
        sheets.append(meta)
    assert r.pos == len(data), (r.pos, len(data))
    assert len(sheets) == len({s['id'] for s in sheets})
    assert len(sheets) == len({s['name'] for s in sheets})
    return dict(version=5, addons=addons, consumedBytes=r.pos, sheets=sheets)


def variable_cells(field, count):
    """ReadFieldValues: sparse (row index, cumulative end) pairs then payload."""
    b = bytes.fromhex(field['valuesHex'])
    if not b:
        return [None] * count, [None] * count
    r = Reader(b)
    n = r.count()
    pairs = [(r.integer(), r.integer()) for _ in range(n)]
    payload = r.pos
    values, spans = [None] * count, [None] * count
    seen, previous = set(), 0
    for index, end in pairs:
        assert 0 <= index < count, 'row-index-out-of-range'
        assert index not in seen, 'duplicate-row-index'
        assert previous <= end <= len(b) - payload, 'invalid-cumulative-end'
        seen.add(index)
        values[index] = b[payload + previous:payload + end]
        spans[index] = dict(offset=field['valuesOffset'] + payload + previous, bytes=end - previous)
        previous = end
    assert payload + previous == len(b)
    return values, spans


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output', type=Path, required=True)
    args = p.parse_args()
    assert not args.output.exists()
    data = SOURCE.read_bytes()
    assert sha(data) == SOURCE_SHA
    envelope = parse(data)
    inventory = [s for s in envelope['sheets'] if s['name'] == 'InventoryItem']
    assert len(inventory) == 1
    sheet = inventory[0]
    rows = [dict(index=i, id=ident, cells={}, spans={}) for i, ident in enumerate(sheet['rowIds'])]
    for f in sheet['fields']:
        kind = f['type'].split(',')[0].rsplit('.', 1)[-1]
        # Fixed and variable-size value codecs are verified against shipped IL.
        widths = {'BGFieldBool': 1, 'BGFieldInt': 4, 'BGFieldEnum': 4, 'BGFieldVector2': 8}
        b = bytes.fromhex(f['valuesHex'])
        if kind in widths:
            width = widths[kind]
            assert len(b) in (0, width * len(rows)), (f['name'], len(b), width * len(rows))
            values = [b[i * width:(i + 1) * width] if b else None for i in range(len(rows))]
            spans = [dict(offset=f['valuesOffset'] + i * width, bytes=width) if b else None for i in range(len(rows))]
        else:
            values, spans = variable_cells(f, len(rows))
        for row, value, span in zip(rows, values, spans):
            if value is None:
                decoded = None
            elif kind in ('BGFieldString', 'BGFieldEntityName', 'BGFieldText', 'BGFieldUnitySprite', 'BGFieldUnityObject'):
                decoded = value.decode('utf-8') if value else None
            elif kind == 'BGFieldBool':
                assert value in (b'\0', b'\1')
                decoded = value == b'\1'
            elif kind in ('BGFieldInt', 'BGFieldEnum'):
                decoded = struct.unpack('<i', value)[0]
            elif kind == 'BGFieldVector2':
                decoded = list(struct.unpack('<ff', value))
            elif kind == 'BGFieldRelationMultiple':
                assert len(value) % 16 == 0
                decoded = [bgid(value[i:i + 16]) for i in range(0, len(value), 16)]
            else:
                raise ValueError('Unclassified inventory codec: ' + kind)
            row['cells'][f['name']] = decoded
            row['spans'][f['name']] = span
    result = dict(schemaVersion=1, source='assets/source-v2/text-assets/90744c19ec-resources.assets-320.bin',
                  sourceSha256=SOURCE_SHA, parserSha256=sha(Path(__file__).read_bytes()),
                  envelope=envelope, inventoryRows=rows, runtime='not-run', reinsertion='not-run',
                  boundary='Complete v5 framing; only InventoryItem values decoded. Not complete BGDatabase source/consumer acceptance.')
    args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps(dict(sheets=len(envelope['sheets']), rows=len(rows), fields=len(sheet['fields']), bytes=envelope['consumedBytes'])))


if __name__ == '__main__':
    main()
