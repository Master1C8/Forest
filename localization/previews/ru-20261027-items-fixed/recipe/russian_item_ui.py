"""Apply all item notification strings while preserving database identities and state."""
import hashlib
import json
from pathlib import Path
import subprocess
from russian_actor_names import encode_cells,replace_columns
ROOT=Path('/Users/antonkrutov/Desktop/Forest')
SOURCE=ROOT/'localization/source/item-notifications-20261027'
PACKET=ROOT/'localization/supplemental-ui/20261027'

def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()

def load_inputs():
    local=Path(__file__).parent
    if (local/'item-inputs.json').is_file():
        pins=json.loads((local/'item-inputs.json').read_text())
        for name,expected in pins.items():assert sha(local/name)==expected,('item-snapshot-pin',name)
        inv=json.loads((local/'item-inventory.json').read_text())
        records=[json.loads(line) for line in (local/'item-targets.jsonl').read_text().splitlines()]
    else:
        inv=json.loads((SOURCE/'inventory.json').read_text())
        manifest=json.loads((PACKET/'manifest.json').read_text())
        assert sha(PACKET/'ru.jsonl')==manifest['locales']['ru']['sha256']
        assert sha(PACKET/'source-catalog.json')==manifest['sourceCatalogSha256']
        catalog=json.loads((PACKET/'source-catalog.json').read_text())
        assert sha(SOURCE/'inventory.json')==catalog['sourcePins'][str((SOURCE/'inventory.json').relative_to(ROOT))]
        records=[json.loads(line) for line in (PACKET/'ru.jsonl').read_text().splitlines()]
        assert len(records)==556
    targets={r['id']:r for r in records if r['id'] in {u['id'] for u in inv['units']}}
    assert len(targets)==len(inv['units'])==110
    assert all(targets[u['id']]['source']==u['source'] for u in inv['units'])
    return inv,targets

def snapshot(folder):
    inv,targets=load_inputs()
    (folder/'item-inventory.json').write_text(json.dumps(inv,ensure_ascii=False,indent=2)+'\n')
    (folder/'item-targets.jsonl').write_text(''.join(json.dumps(r,ensure_ascii=False)+'\n' for r in targets.values()))
    (folder/'item-inputs.json').write_text(json.dumps({n:sha(folder/n) for n in ['item-inventory.json','item-targets.jsonl']},indent=2)+'\n')

def columns(data,parse,variable_cells,inv):
    env=parse(data);sheet=next(s for s in env['sheets'] if s['id']==inv['sheetId'])
    assert sheet['name']=='InventoryItem' and sheet['rowIds']==inv['rowIds']
    result={}
    for field in sheet['fields']:
        if field['name'] in inv['fieldIds']:
            assert field['id']==inv['fieldIds'][field['name']]
            blob=data[field['valuesOffset']:field['valuesOffset']+field['valuesBytes']]
            cells,_=variable_cells(dict(field,valuesHex=blob.hex()),48)
            result[field['name']]=(field,blob,cells)
        else:
            protected=next(p for p in inv['preserveExactly'] if p['fieldId']==field['id'])
            assert data[field['valuesOffset']:field['valuesOffset']+field['valuesBytes']].hex()==protected['expectedBlobHex'],('protected-item-column',field['name'])
    assert len(result)==2 and len(sheet['fields'])==18
    return env,result

def project_item_display(data,parse,variable_cells):
    inv,targets=load_inputs();env,original=columns(data,parse,variable_cells,inv)
    edits=[];receipt=[]
    for name,(field,blob,cells) in original.items():
        for unit in [u for u in inv['units'] if u['family']=='item' and u['field']==name]:
            i=unit['rowIndex'];assert cells[i]==unit['source'].encode(),('unexpected-item-before',unit['id'])
            target=targets[unit['id']]['target'];cells[i]=target.encode()
            receipt.append(dict(id=unit['id'],source=unit['source'],target=target))
        edits.append((field,encode_cells(blob,cells)))
    result=replace_columns(data,edits);after,projected=columns(result,parse,variable_cells,inv)
    # Compare every unselected column throughout the whole database, including prior repairs.
    assert [(s['id'],s['rowIds'],[(f['id'],f['name']) for f in s['fields']]) for s in env['sheets']]==[(s['id'],s['rowIds'],[(f['id'],f['name']) for f in s['fields']]) for s in after['sheets']]
    for a,b in zip(env['sheets'],after['sheets']):
        for f,g in zip(a['fields'],b['fields']):
            if a['id']==inv['sheetId'] and f['name'] in original:continue
            assert data[f['valuesOffset']:f['valuesOffset']+f['valuesBytes']]==result[g['valuesOffset']:g['valuesOffset']+g['valuesBytes']],('unselected-column',a['name'],f['name'])
    for unit in [u for u in inv['units'] if u['family']=='item']:
        assert projected[unit['field']][2][unit['rowIndex']]==targets[unit['id']]['target'].encode(),('item-readback',unit['id'])
    assert len(receipt)==96
    assert replace_columns(result,[(projected[n][0],old[1]) for n,old in original.items()])==data,'full-item-payload-restoration'
    return result,dict(units=receipt,selectedCells=96,unselectedColumnsByteExact=True,fullPayloadRestored=True,beforePayloadSha256=hashlib.sha256(data).hexdigest(),targetPayloadSha256=hashlib.sha256(result).hexdigest())

def patch_items(managed,recipe,receipt_path):
    inv,targets=load_inputs();rows=[targets[u['id']] for u in inv['units'] if u['family']=='item-code']
    assert len(rows)==8
    path=recipe/'item-code-targets.json';path.write_text(json.dumps(rows,ensure_ascii=False,indent=2)+'\n')
    output=managed/'Assembly-CSharp.localized.dll'
    subprocess.run(['dotnet',str(recipe/'menu-patch/MenuPatch.dll'),'patch-items',str(managed/'Assembly-CSharp.dll'),str(path),str(output),str(receipt_path)],check=True)
    receipt=json.loads(receipt_path.read_text());assert receipt['selectedStrings']==8 and receipt['allOriginalBodiesRestored']
    assert sha(output)==receipt['targetSha256'];output.replace(managed/'Assembly-CSharp.dll')
    return receipt
