"""Append-only complete BGDatabase value ledger; no game/assembly execution or translation."""
import argparse,base64,collections,hashlib,importlib.util,json,math,pathlib,struct,urllib.parse
D=pathlib.Path(__file__).resolve().parent;R=D.parents[2]
SOURCE=R/'assets/source-v2/text-assets/90744c19ec-resources.assets-320.bin'
SOURCE_SHA='41834cda2f3ea6f010234f3ca2332e31b95b990ab38a8940b0d92f000477fda9'
OLD=R/'localization/source/bgdatabase-20261027/inventory-decoded.json'
REFS=R/'localization/source/source-family-reconciliation-20261027/reconciled-final/bgdatabase-cell-references.json'
WIDTHS={'BGFieldBool':1,'BGFieldInt':4,'BGFieldEnum':4,'BGFieldFloat':4,'BGFieldVector2':8}
TEXT={'BGFieldString','BGFieldText','BGFieldEntityName'}
PATHS={'BGFieldUnitySprite','BGFieldUnityObject','BGFieldUnityPrefab'}
VARIABLE=TEXT|PATHS|{'BGFieldRelationSingle','BGFieldRelationMultiple','BGFieldListInt'}
def enc(x):return (json.dumps(x,ensure_ascii=False,sort_keys=True,separators=(',',':'),allow_nan=False)+'\n').encode()
def sha(x):return hashlib.sha256(x).hexdigest()
def module(name):
 p=D/name;s=importlib.util.spec_from_file_location(p.stem,p);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
def main(out):
 assert not out.exists(),'Never overwrite a completed/frozen extraction'
 data=SOURCE.read_bytes();assert sha(data)==SOURCE_SHA,'Source SHA mismatch'
 local=module('frozen_envelope_reader.py');independent=module('frozen_independent_reader.py')
 envelope=local.parse(data);other=independent.extract(data);tables=independent.decode_tables(other)
 assert len(envelope['sheets'])==len(other['tables'])==len(tables)==29
 old=json.loads(OLD.read_text());assert old['sourceSha256']==SOURCE_SHA
 # Parsed local envelope and existing immutable inventory agree after omitting
 # the old InventoryItem-only opaque payload cache; all byte offsets/hashes match.
 assert envelope==old['envelope']
 refs={ (x['sheetId'],x['rowId'],x['fieldId']):x for x in json.loads(REFS.read_text())};assert len(refs)==7813
 values=[];fields=[];roles=collections.Counter();types=collections.Counter();matches=0;restored=bytearray(data);stored=0;missing=0;strings=0;empty=0
 for sheet,peer in zip(envelope['sheets'],other['tables']):
  assert sheet['id']==local.bgid(bytes.fromhex(peer['id']))and sheet['name']==peer['name']
  assert sheet['rowIds']==[local.bgid(bytes.fromhex(x))for x in peer['rowIds']]
  assert len(sheet['fields'])==len(peer['fields'])
  for field,pf in zip(sheet['fields'],peer['fields']):
   assert field['id']==local.bgid(bytes.fromhex(pf['id']))and field['name']==pf['name']and field['type']==pf['type']
   start=field['valuesOffset'];blob=data[start:start+field['valuesBytes']];assert sha(blob)==field['valuesSha256'];assert blob==base64.b64decode(pf['valuesBase64'],validate=True)
   kind=field['type'].split(',')[0].rsplit('.',1)[-1];assert kind in WIDTHS|dict.fromkeys(VARIABLE),kind
   count=len(sheet['rowIds']);order=[]
   if kind in WIDTHS:
    width=WIDTHS[kind];assert len(blob)in(0,width*count)
    raw=[blob[i*width:(i+1)*width]if blob else None for i in range(count)]
    spans=[{'offset':start+i*width,'bytes':width}if blob else None for i in range(count)]
   else:
    f=dict(field,valuesHex=blob.hex());raw,spans=local.variable_cells(f,count)
    if blob:
     reader=local.Reader(blob);n=reader.count();pairs=[(reader.integer(),reader.integer())for _ in range(n)];order=[x[0]for x in pairs]
   rebuild=[]
   for i,(row_id,b,span)in enumerate(zip(sheet['rowIds'],raw,spans)):
    if b is None:value=None;missing+=1
    elif kind in TEXT|PATHS:
     value=b.decode('utf-8')if b else None;assert value is None or value.encode('utf-8')==b
    elif kind=='BGFieldBool':assert b in(b'\0',b'\1');value=b==b'\1'
    elif kind in('BGFieldInt','BGFieldEnum'):value=struct.unpack('<i',b)[0]
    elif kind in('BGFieldFloat','BGFieldVector2'):
     floats=struct.unpack('<f'if kind=='BGFieldFloat'else'<ff',b)
     value=(floats[0]if len(floats)==1 else list(floats))if all(math.isfinite(x)for x in floats)else{'ieee754RawHex':b.hex()}
    elif kind=='BGFieldRelationSingle':assert len(b)==16;value=local.bgid(b)
    elif kind=='BGFieldRelationMultiple':assert len(b)%16==0;value=[local.bgid(b[j:j+16])for j in range(0,len(b),16)]
    else:value={'opaqueTypedBytesBase64':base64.b64encode(b).decode(),'kind':kind}
    if b is not None:stored+=1;assert data[span['offset']:span['offset']+span['bytes']]==b
    if kind in TEXT and b is not None:strings+=1;empty+=int(not b)
    key=(sheet['id'],row_id,field['id']);prior=refs.get(key)
    if prior:
     assert sha(enc(value))==prior['valueSha256'],(sheet['name'],field['name'],i,'Prior decoded value differs',value)
     role=prior['role'];matches+=1
    elif kind in TEXT:role='unresolved-text-consumer'
    else:role='preserve-typed-technical-bytes'
    ident='bgdb:resources.assets:320/sheet/'+urllib.parse.quote(sheet['id'],safe='')+'/row/'+urllib.parse.quote(row_id,safe='')+'/field/'+urllib.parse.quote(field['id'],safe='')
    record={'id':ident,'sheet':sheet['name'],'sheetId':sheet['id'],'rowId':row_id,'rowIndex':i,'field':field['name'],'fieldId':field['id'],'kind':kind,'stored':b is not None,'source':value,'sourceSpan':span,'sourceBytesBase64':base64.b64encode(b).decode()if b is not None else None,'classification':role,'classificationEvidence':prior['references']if prior else('Serialized scalar/relation/resource/list type; exact bytes preserved, not an exclusion from the source inventory'if kind not in TEXT else'Newly enumerated text-state; actual display/technical consumer unresolved, NOT translation-ready')}
    values.append(record);roles[role]+=1;types[kind]+=1
    if b is not None:rebuild.append((i,b))
   if kind in WIDTHS:rebuilt=b''.join(b for _,b in rebuild)
   elif not blob:rebuilt=b''
   else:
    by_row=dict(rebuild);end=0;pairs=[];payload=[]
    for i in order:end+=len(by_row[i]);pairs.append(struct.pack('<ii',i,end));payload.append(by_row[i])
    rebuilt=struct.pack('<i',len(order))+b''.join(pairs)+b''.join(payload)
   assert rebuilt==blob,(sheet['name'],field['name'],'Cell-state reconstruction differs')
   restored[start:start+len(blob)]=rebuilt
   fields.append({'sheetId':sheet['id'],'sheet':sheet['name'],'fieldId':field['id'],'field':field['name'],'kind':kind,'rows':count,'valuesOffset':start,'valuesBytes':len(blob),'valuesSha256':sha(blob),'storedRowsOrder':order if kind not in WIDTHS else None,'reconstructedFromEveryStoredCell':True})
 assert len(values)==51572 and matches==7813 and bytes(restored)==data
 assert len({x['id']for x in values})==len(values)
 out.mkdir(parents=True)
 (out/'cells.jsonl').write_bytes(b''.join(enc(x)for x in values));(out/'fields.json').write_bytes(enc(fields))
 # Independent reader validates framing, identifiers, field blobs and all14 known
 # serialized types. Opaque lists/resources remain opaque where interpretation
 # is not justified; this is byte extraction, not consumer/display acceptance.
 pins={str(p.relative_to(R)):sha(p.read_bytes())for p in[SOURCE,OLD,REFS,D/'frozen_envelope_reader.py',D/'frozen_independent_reader.py',pathlib.Path(__file__)]}
 report={'schemaVersion':1,'sourceSha256':SOURCE_SHA,'sourceBytes':len(data),'sheets':29,'rows':sum(len(s['rowIds'])for s in envelope['sheets']),'fields':len(fields),'cellStates':len(values),'previouslyEnumeratedAndExactlyMatched':matches,'newlyEnumeratedStates':len(values)-matches,'storedCellStates':stored,'absentCellStates':missing,'storedTextStates':strings,'storedEmptyTextStates':empty,'classifications':dict(roles),'types':dict(types),'wholeSourceNoopReconstructionSha256':sha(restored),'independentReader':'Separate frozen original source-glossary reader:complete framing/identifier/order/field-blob and known-type decoding checks','pins':pins,'artifacts':{'cells.jsonl':sha((out/'cells.jsonl').read_bytes()),'fields.json':sha((out/'fields.json').read_bytes())},'sourceHandoff':'NOT accepted; unresolved text consumers, special scenes and actual UI/reinsertion/runtime remain open. No existing dialogue/glossary/locale inputs or technical roots changed.','scope':'Exact pinned506640-byte exported BGDatabase payload, not Unity/game roundtrip','gameAssemblyExecution':False,'gameGuiOrInstallationWrites':False}
 (out/'verification.json').write_bytes(enc(report));print(json.dumps({k:v for k,v in report.items()if k not in['pins','artifacts','types']},ensure_ascii=False))
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--output',type=pathlib.Path,required=True);main(p.parse_args().output.resolve())
