#!/usr/bin/env python3
"""Verify original TextAsset, typed cells, generated consumer IDs and multiplicity.

No resource writes, game execution, images, translation or live-lane imports.
"""
import argparse
import base64
import collections
import hashlib
import json
from pathlib import Path
import re
import struct
import sys
from urllib.parse import quote

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
sys.path.insert(0, str(ROOT / 'tools'))
from extract_assets import canonical  # Established byte serialization convention.
from decode_inventory import SOURCE, SOURCE_SHA, Reader, bgid, parse, variable_cells
import UnityPy

DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def dump(path, data):
    path.write_text(json.dumps(canonical(data), ensure_ascii=False, indent=2) + '\n')


def require_rejection(fn, fragment):
    try:
        fn()
    except AssertionError as exc:
        assert fragment in str(exc), (fragment, str(exc))
    else:
        raise AssertionError('Expected rejection: ' + fragment)


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output', type=Path, required=True)
    args = p.parse_args()
    assert not args.output.exists()
    baseline = json.loads((HERE / 'baseline.json').read_text())
    assert len(baseline['pins']) == 19
    assert all(sha(Path(n)) == h for n, h in baseline['pins'].items())
    source = json.loads((ROOT / 'assets/source-v2/source-files.json').read_text())
    checked = ('resources.assets', 'sharedassets2.assets', 'Managed/Assembly-CSharp.dll', 'Managed/BGDatabase.dll')
    assert all(sha(DATA / n) == source[n]['sha256'] for n in checked)
    assert sha(SOURCE) == SOURCE_SHA
    record = next(r for r in json.loads((ROOT / 'assets/source-v2/text-assets.json').read_text()) if r['id'] == 'resources.assets:320')
    env = UnityPy.load(str(DATA / 'resources.assets'))
    obj = [o for o in env.objects if o.path_id == 320 and Path(o.assets_file.name).name == 'resources.assets']
    assert len(obj) == 1 and obj[0].type.name == 'TextAsset'
    assert hashlib.sha256(obj[0].get_raw_data()).hexdigest() == record['rawSha256']
    asset = obj[0].read()
    raw = asset.m_Script.encode('utf-8', 'surrogateescape') if isinstance(asset.m_Script, str) else bytes(asset.m_Script)
    assert asset.m_Name == 'bansheegz_database' and raw == SOURCE.read_bytes()
    decoded = json.loads((HERE / 'inventory-decoded.json').read_text())
    assert decoded['sourceSha256'] == sha(SOURCE)
    assert decoded['parserSha256'] == sha(HERE / 'decode_inventory.py')
    assert parse(raw) == decoded['envelope']
    sheet = next(s for s in decoded['envelope']['sheets'] if s['name'] == 'InventoryItem')
    rows = decoded['inventoryRows']
    assert len(rows) == 48 and len(sheet['fields']) == 18
    assert sheet['rowIds'] == [r['id'] for r in rows]
    # Generated getters are independent consumers of binary IDs, not name guesses.
    il = (HERE / 'InventoryItem.il').read_text()
    def consumer_id(method):
        declarations = list(re.finditer(r'^METHOD [^\n]*::' + re.escape(method) + r'\(\)', il, re.M))
        assert len(declarations) == 1
        body = il[declarations[0].end():].split('\nMETHOD ', 1)[0]
        pair = [int(n) for n in re.findall(r'ldc.i8 (-?\d+)', body)]
        assert len(pair) == 2
        return bgid(struct.pack('<QQ', *(n % (1 << 64) for n in pair)))
    assert consumer_id('get_MetaDefault') == sheet['id']
    for f in sheet['fields']:
        if f['name'] in ('name', 'savekey', 'title', 'notification_phrase', 'description'):
            assert consumer_id('get__' + f['name']) == f['id']
    # Validate uniqueness before any keyed lookup. The savekey schema is NONUNIQUE.
    multiplicity = {}
    for name in ('name', 'savekey', 'item_type', 'title', 'notification_phrase', 'description'):
        groups = collections.defaultdict(list)
        for row in rows:
            groups[str(row['cells'][name])].append(row['id'])
        multiplicity[name] = dict(distinct=len(groups), occurrences=len(rows),
                                  duplicates=[dict(value=k, rowIds=v) for k, v in groups.items() if len(v) > 1])
    assert all(multiplicity[n]['distinct'] == 48 for n in ('name', 'savekey', 'item_type'))
    assert [k['unique'] for k in sheet['keys'] if k['name'] == 'uk_savekey'] == [False]
    # Round-trip every decoded cell to its original source byte span; absent cells
    # remain absent. Preserve original sparse order and cumulative-end framing.
    count, written = 0, 0
    rebuilt = bytearray(raw)
    for f in sheet['fields']:
        kind = f['type'].split(',')[0].rsplit('.', 1)[-1]
        for row in rows:
            value, span = row['cells'][f['name']], row['spans'][f['name']]
            count += 1
            if span is None:
                assert value is None
                continue
            if value is None:
                encoded = b''
            elif kind == 'BGFieldBool':
                encoded = bytes([int(value)])
            elif kind in ('BGFieldInt', 'BGFieldEnum'):
                encoded = struct.pack('<i', value)
            elif kind == 'BGFieldVector2':
                encoded = struct.pack('<ff', *value)
            elif kind == 'BGFieldRelationMultiple':
                encoded = b''.join(base64.b64decode(v + '==', validate=True) for v in value)
            else:
                encoded = value.encode('utf-8')
            offset, size = span['offset'], span['bytes']
            assert len(encoded) == size and raw[offset:offset + size] == encoded, (row['id'], f['name'])
            rebuilt[offset:offset + size] = encoded
            written += 1
    assert bytes(rebuilt) == raw
    # Concrete sparse positive/negative controls. Nonconsecutive row indices must
    # survive, duplicate indices must reject rather than overwrite a prior cell.
    payload = struct.pack('<i', 2) + struct.pack('<iiii', 2, 1, 0, 2) + b'AB'
    f = dict(valuesHex=payload.hex(), valuesOffset=100)
    assert variable_cells(f, 3)[0] == [b'B', None, b'A']
    bad = bytearray(payload); struct.pack_into('<i', bad, 12, 2)
    require_rejection(lambda: variable_cells(dict(valuesHex=bad.hex(), valuesOffset=100), 3), 'duplicate-row-index')
    require_rejection(lambda: parse(raw + b'X'), str(len(raw)))
    # Reuse accepted serialized inventory bindings only after all IL hashes and
    # their exact original source/binary hashes match; no game or UI inference.
    old = ROOT / 'localization/source/inventory-20261026'
    prior = json.loads((old / 'source-trace.json').read_text())
    assert all(sha(old / n) == h for n, h in prior['evidence'].items())
    assert sha(DATA / 'sharedassets2.assets') == prior['source']['sharedassets2.assets']
    assert sha(DATA / 'Managed/Assembly-CSharp.dll') == prior['source']['Assembly-CSharp.dll']
    fields, protected = [], []
    visible_names = {'title', 'notification_phrase', 'description'}
    for row in rows:
        for f in sheet['fields']:
            entry = dict(id='bgdb:resources.assets:320/sheet/' + quote(sheet['id'], safe='') + '/row/' + quote(row['id'], safe='') + '/field/' + quote(f['id'], safe=''),
                         sheetId=sheet['id'], rowId=row['id'], rowIndex=row['index'], fieldId=f['id'], field=f['name'],
                         source=row['cells'][f['name']], sourceSpan=row['spans'][f['name']])
            if f['name'] in visible_names:
                entry.update(role='authored-display-candidate', consumer='GenerateItems -> InventoryItem.' + ('notificationPhrase' if f['name'] == 'notification_phrase' else f['name']),
                             reachability='not-run; masked branches and notifications recorded in ADAPTER.md')
                fields.append(entry)
            else:
                entry.update(role='preserve-exactly', reason='Runtime identity/key, enum, boolean, coordinate, resource path, relation ID or priority; never translated as prose.')
                protected.append(entry)
    assert len(fields) == 144 and len(protected) == 720
    assert len({e['id'] for e in fields + protected}) == 864
    fragments = json.loads((HERE / 'compiled-fragments.json').read_text())['fragments']
    assert len(fragments) == 13
    for fragment in fragments:
        text = (HERE / fragment['file']).read_bytes().decode('utf-8')
        marker = fragment['offset'] + ': ldstr "' + fragment['source'] + '"\n'
        assert text.count(marker) == 1, fragment['id']
        declaration = text.split(marker, 1)[0].rsplit('\nMETHOD ', 1)[-1]
        assert declaration.splitlines()[0].removeprefix('METHOD ').split(' | ')[0] == fragment['method'].removeprefix('METHOD ')
    args.output.mkdir(parents=True)
    for name, content in [('visible-fields.jsonl', fields), ('preserve-exactly.jsonl', protected)]:
        (args.output / name).write_text(''.join(json.dumps(e, ensure_ascii=False) + '\n' for e in content))
    dump(args.output / 'multiplicity.json', multiplicity)
    dump(args.output / 'verification.json', dict(status='passed-static-scoped', checkedInstalledSources={n:source[n]['sha256'] for n in checked},
         textAssetRawSha256=record['rawSha256'], exportedBytes=len(raw), fullyConsumedBytes=decoded['envelope']['consumedBytes'],
         sheetsFramed=29, inventoryRows=48, inventoryColumns=18, cellsExactReadback=count, storedCellSpansReencoded=written,
         reconstructedInputSha256=hashlib.sha256(rebuilt).hexdigest(), wholeInputNoOpEquality=True, consumerConstantIdsMatched=6,
         visibleCandidateOccurrences=144, protectedCells=720, frozenPinsUnchanged=19, priorInventoryEvidenceHashesChecked=len(prior['evidence']),
         exactCompiledLiteralOccurrences=13, compiledVisibleFragments=9, compiledProtectedAnimatorKeys=3, compiledMixedFictionalTrace=1,
         sparseOutOfOrderPositive=True, duplicateSparseIndexRejected=True, trailingBytesRejected=True,
         gameLaunches=0, imagesOpened=0, translationAuthored=False, gameAssemblyExecuted=False,
         runtime='not-run', visual='not-run', resourceReinsertion='not-run', sourceAcceptance='needs-review',
         boundary='Original Unity TextAsset/read-only typed decoding and unchanged cell byte reconstruction. Not a translated or reinserted Unity resource; other28 sheet values/consumers and full source/special-scene gates pending.'))
    print(json.dumps(dict(status='passed-static-scoped', cells=count, visibleCandidates=len(fields), protected=len(protected))))


if __name__ == '__main__':
    main()
