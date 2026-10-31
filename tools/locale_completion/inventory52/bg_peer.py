"""Read-only BGDatabase v5 inventory reader, matched to this game's BGDatabase.dll.

No game assembly is executed; binary locators and unmodified value blobs are retained.
"""
import argparse, base64, hashlib, json, pathlib, struct, zlib

class Reader:
    def __init__(self, data): self.data, self.pos = data, 0
    def take(self, n):
        if n < 0 or self.pos + n > len(self.data): raise ValueError(f'Invalid byte range at {self.pos}: {n}')
        v = self.data[self.pos:self.pos+n]; self.pos += n; return v
    def integer(self): return struct.unpack('<i', self.take(4))[0]
    def boolean(self):
        v = self.take(1)[0]
        if v not in (0, 1): raise ValueError(f'Invalid Boolean {v}')
        return bool(v)
    def blob(self): return self.take(self.integer())
    def text(self): return self.blob().decode('utf-8') or None
    def identifier(self): return self.take(16).hex()
    def count(self):
        n = self.integer()
        if not 0 <= n <= 1000000: raise ValueError(f'Invalid array count {n}')
        return n
    def version(self):
        n = self.integer()
        if n != 1: raise ValueError(f'Unsupported record version {n}')


def extract(data):
    r = Reader(data)
    if r.integer() != 5: raise ValueError('Only BGDatabase binary v5 is supported')
    if r.take(16) != struct.pack('<QQ', 5208396773359933591, 14401663668042484142): raise ValueError('Invalid BGDatabase signature')
    addons = []
    zipped = False
    for _ in range(r.count()):
        r.version(); name, config = r.text(), r.blob()
        addons.append({'type': name, 'configBase64': base64.b64encode(config).decode()})
        if name.split(',')[0].endswith('.BGAddonSettings'):
            settings = Reader(config)
            if settings.integer() not in (1, 2): raise ValueError('Unsupported settings version')
            settings.boolean(); zipped = settings.boolean()
    header_size = r.pos
    payload = zlib.decompress(data[r.pos:], -15) if zipped else data[r.pos:]
    r = Reader(payload)
    tables = []
    for _ in range(r.count()):
        start = r.pos; r.version()
        t = {'id': r.identifier(), 'name': r.text(), 'type': r.text(), 'configBase64': base64.b64encode(r.blob()).decode(), 'system': r.boolean(), 'addon': r.text(), 'uniqueName': r.boolean(), 'singleton': r.boolean(), 'emptyName': r.boolean(), 'comment': r.text(), 'payloadOffset': start}
        ids = r.blob()
        if len(ids) % 16: raise ValueError('Invalid entity ID block')
        t['rowIds'] = [ids[i:i+16].hex() for i in range(0, len(ids), 16)]
        if len(t['rowIds']) != len(set(t['rowIds'])): raise ValueError('Duplicate row ID')
        t['fields'] = []
        for _ in range(r.count()):
            start = r.pos; r.version()
            f = {'id': r.identifier(), 'name': r.text(), 'type': r.text(), 'configBase64': base64.b64encode(r.blob()).decode(), 'system': r.boolean(), 'addon': r.text(), 'defaultValue': r.text(), 'required': r.boolean(), 'customStringFormatter': r.text(), 'customEditor': r.text(), 'comment': r.text(), 'payloadOffset': start}
            blob = r.blob()
            f['valueBytes'] = len(blob)
            f['valuesBase64'] = base64.b64encode(blob).decode()
            t['fields'].append(f)
        t['keys'] = []
        for _ in range(r.count()):
            r.version(); key = {'id': r.identifier(), 'name': r.text(), 'unique': r.boolean()}
            key['fieldIds'] = [r.identifier() for _ in range(r.count())]; t['keys'].append(key)
        tables.append(t)
    if r.pos != len(payload): raise ValueError(f'Unconsumed database bytes: {len(payload)-r.pos}')
    names = [t['name'] for t in tables]
    if len(set(names)) != len(names): raise ValueError('Duplicate table name')
    return {'schemaVersion': 1, 'sourceSha256': hashlib.sha256(data).hexdigest(), 'headerBytes': header_size, 'zipped': zipped, 'payloadBytes': len(payload), 'payloadSha256': hashlib.sha256(payload).hexdigest(), 'addons': addons, 'tables': tables}

def decode_tables(inventory):
    """Decode known cell types; retain raw bytes for all other serialized values."""
    variable = {'BGFieldString', 'BGFieldText', 'BGFieldEntityName', 'BGFieldRelationSingle', 'BGFieldRelationMultiple', 'BGFieldUnitySprite', 'BGFieldUnityObject', 'BGFieldUnityPrefab', 'BGFieldListInt'}
    strings = {'BGFieldString', 'BGFieldText', 'BGFieldEntityName'}
    sizes = {'BGFieldBool': 1, 'BGFieldInt': 4, 'BGFieldEnum': 4, 'BGFieldFloat': 4, 'BGFieldVector2': 8}
    tables = {}
    for table in inventory['tables']:
        rows = [{'id': key, 'index': i} for i, key in enumerate(table['rowIds'])]
        names = [field['name'] for field in table['fields']]
        if len(names) != len(set(names)): raise ValueError('Duplicate field name')
        for field in table['fields']:
            kind = field['type'].split(',')[0].split('.')[-1]
            data = base64.b64decode(field['valuesBase64'], validate=True)
            values = [None] * len(rows)
            if kind in variable:
                reader = Reader(data); count = reader.count()
                index_end = [(reader.integer(), reader.integer()) for _ in range(count)]
                base, last, seen = reader.pos, 0, set()
                for index, end in index_end:
                    if not 0 <= index < len(rows) or index in seen or end < last or base + end > len(data): raise ValueError('Invalid variable cell index/range')
                    seen.add(index); raw = data[base+last:base+end]; last = end
                    if kind in strings:
                        value = raw.decode('utf-8')
                        if value.encode('utf-8') != raw: raise ValueError('Text byte round trip failed')
                    elif kind == 'BGFieldRelationSingle':
                        if len(raw) != 16: raise ValueError('Invalid relation ID')
                        value = {'rowId': raw.hex()}
                    else: value = {'bytesBase64': base64.b64encode(raw).decode()}
                    values[index] = value
                if base + last != len(data): raise ValueError('Unconsumed field bytes')
            elif kind in sizes:
                size = sizes[kind]
                if len(data) != size * len(rows): raise ValueError('Invalid fixed-size field')
                for i in range(len(rows)):
                    raw = data[i*size:(i+1)*size]
                    if kind == 'BGFieldBool':
                        if raw[0] not in (0, 1): raise ValueError('Invalid Boolean cell')
                        value = bool(raw[0])
                    else:
                        value = struct.unpack('<f' if kind == 'BGFieldFloat' else '<ff' if kind == 'BGFieldVector2' else '<i', raw)
                        value = value[0] if len(value) == 1 else list(value)
                    values[i] = value
            else: raise ValueError(f'Unclassified field type: {kind}')
            for row, value in zip(rows, values): row[field['name']] = value
        tables[table['name']] = rows
    return tables

if __name__ == '__main__':
    p = argparse.ArgumentParser(); p.add_argument('database', type=pathlib.Path); p.add_argument('output', type=pathlib.Path); p.add_argument('--tables', type=pathlib.Path); a = p.parse_args()
    inventory = extract(a.database.read_bytes()); tables = decode_tables(inventory)
    a.output.parent.mkdir(parents=True, exist_ok=True); a.output.write_text(json.dumps(inventory, ensure_ascii=False, indent=2)+'\n')
    if a.tables: a.tables.write_text(json.dumps(tables, ensure_ascii=False, indent=2)+'\n')
    print(f"Fully consumed database: {len(inventory['tables'])} tables, {sum(len(t['rowIds']) for t in inventory['tables'])} rows; compressed={inventory['zipped']}")
    print('Known cell types decoded; all stored UTF-8 cells passed exact byte round-trip checks.')
