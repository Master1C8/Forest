"""Source-bound tutorial quest projection, leaving other quests and counters intact."""
import hashlib
import json
from pathlib import Path

from russian_actor_names import encode_cells, replace_columns

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
PLAN = Path(__file__).with_name('tutorial-quest-plan.json')
if not PLAN.is_file():
    PLAN = ROOT / 'localization/source/tutorial-quest-ru-20261027/plan.json'
PLAN_SHA = '9a94aa6a554bed1a7e6f9b30196004da63b724ece5651da6e8e2e54a11b65e73'


def project_quest_display(data, parse, variable_cells):
    raw = PLAN.read_bytes()
    assert hashlib.sha256(raw).hexdigest() == PLAN_SHA, 'quest-plan-fingerprint'
    plan = json.loads(raw)
    assert hashlib.sha256(data).hexdigest() == plan['inputPayloadSha256'], 'quest-unexpected-before-state'
    for path, expected in plan['glossaryPins'].items():
        assert hashlib.sha256((ROOT / path).read_bytes()).hexdigest() == expected, 'quest-glossary-pin'
    env = parse(data)
    edits, records, original = [], [], {}
    for spec in plan['sheets']:
        sheet = next(s for s in env['sheets'] if s['name'] == spec['name'])
        assert sheet['id'] == spec['id'] and sheet['rowIds'] == spec['rowIds'], 'quest-source-identities'
        for name, ident in spec['fields'].items():
            units = [u for u in plan['units'] if u['sheet'] == sheet['name'] and u['field'] == name]
            if not units:
                continue
            field = next(f for f in sheet['fields'] if f['name'] == name)
            assert field['id'] == ident
            start, size = field['valuesOffset'], field['valuesBytes']
            blob = data[start:start + size]
            cells, _ = variable_cells(dict(field, valuesHex=blob.hex()), len(sheet['rowIds']))
            for unit in units:
                i = unit['rowIndex']
                assert sheet['rowIds'][i] == unit['rowId'] and cells[i] == unit['source'].encode(), 'quest-before-cell'
                assert unit['source'].count('\n') == unit['target'].count('\n')
                cells[i] = unit['target'].encode()
                records.append(unit)
            original[(sheet['id'], field['id'])] = blob
            edits.append((field, encode_cells(blob, cells)))
    assert len(records) == 6 and len(edits) == 3
    result = replace_columns(data, edits)
    rebuilt = parse(result)
    restore = []
    for sheet in rebuilt['sheets']:
        for field in sheet['fields']:
            key = (sheet['id'], field['id'])
            if key not in original:
                continue
            start, size = field['valuesOffset'], field['valuesBytes']
            cells, _ = variable_cells(dict(field, valuesHex=result[start:start + size].hex()), len(sheet['rowIds']))
            wanted = [u for u in records if u['sheetId'] == sheet['id'] and u['fieldId'] == field['id']]
            before_field = next(f for s in env['sheets'] if s['id'] == sheet['id'] for f in s['fields'] if f['id'] == field['id'])
            old_cells, _ = variable_cells(dict(before_field, valuesHex=original[key].hex()), len(sheet['rowIds']))
            for unit in wanted:
                i = unit['rowIndex']
                assert cells[i] == unit['target'].encode(), 'quest-target-readback'
                cells[i] = old_cells[i]
            assert cells == old_cells, 'other-quest-cell-changed'
            restore.append((field, original[key]))
    assert replace_columns(result, restore) == data, 'quest-whole-payload-restoration'
    return result, records
