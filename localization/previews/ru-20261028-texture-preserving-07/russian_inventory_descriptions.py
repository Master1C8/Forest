"""Guarded additive description projection, after the historical item stage.

The historical title/notification scope and its16 protected columns stay frozen.
This later admitted increment selects only description; every other current
column (including earlier Russian display targets) must remain byte-exact.
"""
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
from russian_actor_names import encode_cells, replace_columns

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
PACKET = ROOT / 'localization/supplemental-ui/20261028-inventory'


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def load_inputs():
    local = Path(__file__).parent
    if (local / 'inventory-description-inputs.json').is_file():
        pins = json.loads((local / 'inventory-description-inputs.json').read_text())
        for name, expected in pins.items():
            assert sha(local / name) == expected, ('inventory-snapshot-pin', name)
        target = local / 'inventory-description-targets.jsonl'
        acceptance = json.loads((local / 'inventory-description-acceptance.json').read_text())
    else:
        acceptance = json.loads((PACKET / 'ru.acceptance.json').read_text())
        assert Path(acceptance['targetFile']).name == acceptance['targetFile']
        target = PACKET / acceptance['targetFile']
    assert acceptance['status'] == 'bounded-russian-editorial-accepted'
    assert sha(target) == acceptance['targetSha256']
    rows = [json.loads(line) for line in target.read_text().splitlines()]
    assert len(rows) == len({r['id'] for r in rows}) == 52
    assert all(r['locale'] == 'ru' and r['source'] and r['target'] for r in rows)
    for row in rows:
        for field in ['source', 'target']:
            assert hashlib.sha256(row[field].encode()).hexdigest() == row[field + 'Sha256']
    return rows, acceptance


def snapshot(folder):
    rows, acceptance = load_inputs()
    for name, data in [('inventory-description-targets.jsonl', ''.join(json.dumps(r, ensure_ascii=False) + '\n' for r in rows)),
                       ('inventory-description-acceptance.json', json.dumps(acceptance, ensure_ascii=False, indent=2) + '\n')]:
        (folder / name).write_text(data)
    names = ['inventory-description-targets.jsonl', 'inventory-description-acceptance.json']
    (folder / 'inventory-description-inputs.json').write_text(json.dumps({n: sha(folder / n) for n in names}, indent=2) + '\n')
    source = Path(__file__).with_name('inventory_description_patch')
    if not source.is_dir():
        source = Path(__file__).with_name('inventory-description-patch-source')
    shutil.copytree(source, folder / 'inventory-description-patch-source', ignore=shutil.ignore_patterns('bin', 'obj'))
    subprocess.run(['dotnet', 'build', str(folder / 'inventory-description-patch-source/InventoryDescriptionPatch.csproj'),
                    '-o', str(folder / 'inventory-description-patch')], check=True, capture_output=True)


def project_descriptions(data, parse, variable_cells, explicit_rows=None):
    # Explicit rows are for deterministic preflight before acceptance, not build.
    rows = load_inputs()[0] if explicit_rows is None else explicit_rows
    selected = [r for r in rows if r['family'] == 'inventory-description']
    assert len(selected) == len({r['rowId'] for r in selected}) == 48
    before = parse(data)
    sheet = next(s for s in before['sheets'] if s['name'] == 'InventoryItem')
    assert sheet['rowIds'] == [r['rowId'] for r in sorted(selected, key=lambda r: r['rowIndex'])]
    field = next(f for f in sheet['fields'] if f['name'] == 'description')
    assert all(r['fieldId'] == field['id'] for r in selected)
    blob = data[field['valuesOffset']:field['valuesOffset'] + field['valuesBytes']]
    cells, _ = variable_cells(dict(field, valuesHex=blob.hex()), 48)
    for row in selected:
        assert cells[row['rowIndex']] == row['source'].encode(), ('description-source-cell', row['id'])
        cells[row['rowIndex']] = row['target'].encode()
    result = replace_columns(data, [(field, encode_cells(blob, cells))])
    after = parse(result)
    schema = lambda env: [(s['id'], s['rowIds'], [(f['id'], f['name']) for f in s['fields']]) for s in env['sheets']]
    assert schema(before) == schema(after), 'database-schema-changed'
    new_field = None
    unselected = 0
    for old_sheet, new_sheet in zip(before['sheets'], after['sheets']):
        for old, new in zip(old_sheet['fields'], new_sheet['fields']):
            if old_sheet['id'] == sheet['id'] and old['id'] == field['id']:
                assert new_field is None
                new_field = new
                continue
            assert data[old['valuesOffset']:old['valuesOffset'] + old['valuesBytes']] == result[new['valuesOffset']:new['valuesOffset'] + new['valuesBytes']], ('unselected-column', old_sheet['name'], old['name'])
            unselected += 1
    new_blob = result[new_field['valuesOffset']:new_field['valuesOffset'] + new_field['valuesBytes']]
    readback, _ = variable_cells(dict(new_field, valuesHex=new_blob.hex()), 48)
    assert all(readback[r['rowIndex']] == r['target'].encode() for r in selected), 'description-readback'
    assert replace_columns(result, [(new_field, blob)]) == data, 'whole-payload-restoration'
    receipt = dict(selectedCells=48, selectedField='InventoryItem.description',
                   unselectedColumns=unselected, unselectedColumnsByteExact=True,
                   fullPayloadRestored=True, sourceIds=[r['id'] for r in selected],
                   beforePayloadSha256=hashlib.sha256(data).hexdigest(),
                   targetPayloadSha256=hashlib.sha256(result).hexdigest())
    return result, receipt


def patch_empty_cells(managed, recipe, receipt_path):
    rows, _ = load_inputs()
    selected = [r for r in rows if r['family'] == 'inventory-empty-cell']
    assert len(selected) == 4
    path = recipe / 'inventory-empty-targets.json'
    path.write_text(json.dumps(selected, ensure_ascii=False, indent=2) + '\n')
    source = managed / 'Assembly-CSharp.dll'
    output = managed / 'Assembly-CSharp.inventory.dll'
    subprocess.run(['dotnet', str(recipe / 'inventory-description-patch/InventoryDescriptionPatch.dll'),
                    str(source), sha(source), str(path), str(output), str(receipt_path)], check=True)
    receipt = json.loads(receipt_path.read_text())
    assert receipt['selectedStrings'] == 4 and receipt['allOriginalBodiesRestored']
    assert sha(output) == receipt['targetSha256']
    output.replace(source)
    return receipt
