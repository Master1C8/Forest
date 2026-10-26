"""Check authored scansion receipts and exact bindings; never generate wording."""
import hashlib
import itertools
import json
import pathlib
import re

HERE = pathlib.Path(__file__).resolve().parent
ROOT = HERE.parents[1]
receipt = json.loads((HERE / 'poetry-scansion.json').read_text())
assert receipt['locale'] == 'es-419'
overlay = HERE / 'dialogue.es-419.jsonl'
rows = {r['id']: r for r in map(json.loads, overlay.read_text().splitlines())}
source = {r['id']: r for r in map(json.loads, (ROOT / 'localization/source/dialogue-candidates.jsonl').read_text().splitlines())}
scans = {r['text']: r for r in receipt['lines']}
assert len(scans) == len(receipt['lines'])
for line in scans.values():
    assert len(line['scan'].split('/')) + line['adjustment'] == line['expected'], line
    assert re.sub(r'[^\w]', '', line['scan']).replace('_', '').casefold() == re.sub(r'[^\w]', '', line['text']).casefold(), line

bindings = {}
def visible(key):
    ident = 'ds:' + key + ':Dialogue Text'
    row = rows[ident]
    assert row['source'] == source[ident]['source']
    assert hashlib.sha256(row['source'].encode()).hexdigest() == row['sourceSha256']
    assert hashlib.sha256(row['target'].encode()).hexdigest() == row['targetSha256']
    bindings[ident] = {'sourceSha256': row['sourceSha256'], 'targetSha256': row['targetSha256']}
    return re.sub(r'^(?:\[pic[ac]?=[0-9A-Za-z_]+\])*', '', row['target']).rstrip('\r')

for poem in receipt['poems']:
    actual = [line for key in poem['keys'] for line in visible(key).splitlines()]
    assert actual == poem['lines'], poem['id']
    assert [scans[line]['expected'] for line in actual] == [5, 7, 5], poem['id']
for callback in receipt['callbacks']:
    assert visible(callback['key']) == callback['exact'], callback['key']
combinations = list(itertools.product(*receipt['combinationColumns']))
assert len(combinations) == 27
for keys in combinations:
    assert [scans[visible(key)]['expected'] for key in keys] == [5, 7, 5], keys
assert visible('303:343') == visible('303:350')
print(json.dumps({'status': 'passed authored receipts and exact text bindings', 'poems': len(receipt['poems']), 'lines': len(scans), 'callbacks': len(receipt['callbacks']), 'combinations': len(combinations), 'bindings': bindings, 'overlaySha256': hashlib.sha256(overlay.read_bytes()).hexdigest(), 'receiptSha256': hashlib.sha256((HERE / 'poetry-scansion.json').read_bytes()).hexdigest(), 'limits': 'Author scans only; no independent semantic audit, automated linguistic syllabification or engine/runtime acceptance.'}, ensure_ascii=False, indent=2))
