"""Complete source-bound Actor display projection; preserve identities and nulls."""
import hashlib
import json
from pathlib import Path
import struct

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
PLAN = Path(__file__).with_name('actor-display-plan.json')
if not PLAN.is_file():
    PLAN = ROOT / 'localization/source/actor-display-ru-20261027/plan.json'
PLAN_SHA = 'a09e06f91f8d95b0e4a03f4ee4da3d56d0ad9758daed8469f48d7611ea3c55cb'
SCARLETT = 'A5FQ9EyucE2xuZaKCq62yA'


def load_plan():
    raw = PLAN.read_bytes()
    assert hashlib.sha256(raw).hexdigest() == PLAN_SHA, 'actor-display-plan-fingerprint'
    plan = json.loads(raw)
    assert len(plan['rows']) == 39 and len({r['rowId'] for r in plan['rows']}) == 39
    for path, expected in plan['glossaryPins'].items():
        assert hashlib.sha256((ROOT / path).read_bytes()).hexdigest() == expected, 'actor-display-glossary-pin'
    return plan


def expected_before(row, field, state):
    if state == 'scarlett-preview' and row['rowId'] == SCARLETT:
        return row['target'][field]
    return row['source'][field]


def display_columns(data, parse, variable_cells, plan):
    env = parse(data)
    sheet = next(s for s in env['sheets'] if s['name'] == 'Actor')
    assert sheet['id'] == plan['sheetId'], 'actor-sheet-identity'
    assert sheet['rowIds'] == [r['rowId'] for r in plan['rows']], 'actor-row-identity-order'
    columns = {}
    for field in sheet['fields']:
        if field['name'] not in plan['fieldIds']:
            continue
        assert field['id'] == plan['fieldIds'][field['name']], 'actor-field-identity'
        start, size = field['valuesOffset'], field['valuesBytes']
        blob = data[start:start + size]
        cells, _ = variable_cells(dict(field, valuesHex=blob.hex()), len(sheet['rowIds']))
        columns[field['name']] = (field, blob, cells)
    assert len(columns) == 2, 'missing-display-field'
    return env, sheet, columns


def replace_columns(data, columns):
    result = data
    for field, blob in sorted(columns, key=lambda item: item[0]['valuesOffset'], reverse=True):
        start = field['valuesOffset']
        end = start + field['valuesBytes']
        result = result[:start - 4] + struct.pack('<i', len(blob)) + blob + result[end:]
    return result


def encode_cells(blob, cells):
    count = struct.unpack_from('<i', blob)[0]
    pairs = [struct.unpack_from('<ii', blob, 4 + 8 * i) for i in range(count)]
    assert len({index for index, _ in pairs}) == count
    payload = b''
    encoded = []
    for index, _ in pairs:
        assert cells[index] is not None, 'actor-stored-null-state'
        payload += cells[index]
        encoded.append(struct.pack('<ii', index, len(payload)))
    return struct.pack('<i', count) + b''.join(encoded) + payload


def project_actor_display(data, parse, variable_cells, before_state='source'):
    plan = load_plan()
    assert before_state in plan['beforeStates'], 'unknown-actor-before-state'
    assert hashlib.sha256(data).hexdigest() == plan['beforeStates'][before_state], 'unexpected-before-value'
    _, sheet, columns = display_columns(data, parse, variable_cells, plan)
    replacements, receipts = [], []
    for name, (field, blob, cells) in columns.items():
        for row in plan['rows']:
            index = row['rowIndex']
            old = expected_before(row, name, before_state)
            expected = old.encode() if old is not None else None
            assert cells[index] == expected, ('actor-before-cell', row['rowId'], name)
            target = row['target'][name]
            if target is None:
                assert old is None
                continue
            cells[index] = target.encode()
            receipts.append({'sheetId': sheet['id'], 'rowId': row['rowId'], 'rowIndex': index,
                             'fieldId': field['id'], 'field': name, 'source': row['source'][name],
                             'before': old, 'target': target, 'changed': old != target})
        replacements.append((field, encode_cells(blob, cells)))
    assert len(receipts) == 46
    result = replace_columns(data, replacements)
    verify_actor_projection(data, result, parse, variable_cells, before_state=before_state)
    return result, receipts


def verify_actor_projection(before, after, parse, variable_cells, before_state='source'):
    plan = load_plan()
    assert before_state in plan['beforeStates']
    assert hashlib.sha256(before).hexdigest() == plan['beforeStates'][before_state], 'unexpected-before-value'
    a, _, original = display_columns(before, parse, variable_cells, plan)
    b, _, projected = display_columns(after, parse, variable_cells, plan)
    assert len(a['sheets']) == len(b['sheets']), 'schema-changed'
    for sheet, other in zip(a['sheets'], b['sheets']):
        assert len(sheet['fields']) == len(other['fields']), 'field-schema-changed'
        for field, new_field in zip(sheet['fields'], other['fields']):
            if sheet['name'] == 'Actor' and field['name'] in original:
                continue
            left = before[field['valuesOffset']:field['valuesOffset'] + field['valuesBytes']]
            right = after[new_field['valuesOffset']:new_field['valuesOffset'] + new_field['valuesBytes']]
            assert left == right, 'unselected-column-changed'
    restore = []
    nulls = translated = 0
    for name, (field, old_blob, old_cells) in original.items():
        new_field, new_blob, new_cells = projected[name]
        old_count = struct.unpack_from('<i', old_blob)[0]
        new_count = struct.unpack_from('<i', new_blob)[0]
        assert old_count == new_count
        assert [struct.unpack_from('<i', old_blob, 4 + 8 * i)[0] for i in range(old_count)] == [struct.unpack_from('<i', new_blob, 4 + 8 * i)[0] for i in range(new_count)], 'actor-sparse-order-changed'
        for row in plan['rows']:
            i = row['rowIndex']
            source = expected_before(row, name, before_state)
            target = row['target'][name]
            assert old_cells[i] == (source.encode() if source is not None else None)
            assert new_cells[i] == (target.encode() if target is not None else None), 'display-projection-mismatch'
            if target is None:
                nulls += 1
            else:
                translated += 1
        restore.append((new_field, old_blob))
    assert translated == 46 and nulls == 32
    assert replace_columns(after, restore) == before, 'whole-payload-restoration-mismatch'
    return True
