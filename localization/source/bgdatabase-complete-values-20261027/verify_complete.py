"""Independent value/raw-byte readback and matched format guard regressions."""
import base64,collections,copy,hashlib,importlib.util,json,pathlib,struct
D=pathlib.Path(__file__).resolve().parent;R=D.parents[2]
def load(name):
 p=D/name;s=importlib.util.spec_from_file_location(p.stem,p);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
reader=load('frozen_independent_reader.py');local=load('frozen_envelope_reader.py')
source=R/'assets/source-v2/text-assets/90744c19ec-resources.assets-320.bin';data=source.read_bytes();assert sha(source)=='41834cda2f3ea6f010234f3ca2332e31b95b990ab38a8940b0d92f000477fda9'
inventory=reader.extract(data);tables=reader.decode_tables(inventory)
values=[json.loads(x)for x in(D/'verified/cells.jsonl').read_text().splitlines()];assert len(values)==51572
matched=collections.Counter();unresolved=collections.defaultdict(lambda:{'states':0,'stored':0,'nonempty':0,'characters':0,'words':0})
for c in values:
 value=tables[c['sheet']][c['rowIndex']][c['field']];raw=base64.b64decode(c['sourceBytesBase64'],validate=True)if c['stored']else None
 if raw is None:assert value is None and c['source'] is None;matched['absent-state']+=1
 elif c['kind']in {'BGFieldString','BGFieldText','BGFieldEntityName','BGFieldBool','BGFieldInt','BGFieldEnum','BGFieldFloat','BGFieldVector2'}:
  assert value==c['source'],(c['id'],'Independent decoded value differs');matched['decoded-scalar-or-text']+=1
 elif c['kind']=='BGFieldRelationSingle':assert local.bgid(bytes.fromhex(value['rowId']))==c['source'];matched['relation-id-normalization']+=1
 else:assert base64.b64decode(value['bytesBase64'],validate=True)==raw;matched['opaque-typed-raw-value']+=1
 if raw is not None:
  span=c['sourceSpan'];assert data[span['offset']:span['offset']+span['bytes']]==raw
 if c['classification']=='unresolved-text-consumer':
  z=unresolved[(c['sheet'],c['field'],c['kind'])];z['states']+=1;z['stored']+=c['stored'];z['nonempty']+=bool(c['source']);z['characters']+=len(c['source']or'');z['words']+=len((c['source']or'').split())
assert sum(matched.values())==51572
# Restore every field solely from the delivered cell rows and schema/order.
by_field=collections.defaultdict(dict)
for c in values:by_field[(c['sheetId'],c['fieldId'])][c['rowIndex']]=c
restored=bytearray(data);fields=json.loads((D/'verified/fields.json').read_text())
for f in fields:
 cells=by_field.get((f['sheetId'],f['fieldId']),{});assert len(cells)==f['rows']
 raw={i:base64.b64decode(c['sourceBytesBase64'],validate=True)for i,c in cells.items()if c['stored']}
 if f['storedRowsOrder']is None:blob=b''.join(raw[i]for i in range(f['rows'])if i in raw)
 elif f['valuesBytes']==0:assert not raw;blob=b''
 else:
  order=f['storedRowsOrder'];assert set(order)==set(raw);end=0;idx=[]
  for i in order:end+=len(raw[i]);idx.append(struct.pack('<ii',i,end))
  blob=struct.pack('<i',len(order))+b''.join(idx)+b''.join(raw[i]for i in order)
 assert len(blob)==f['valuesBytes']and hashlib.sha256(blob).hexdigest()==f['valuesSha256']
 start=f['valuesOffset'];restored[start:start+len(blob)]=blob
assert bytes(restored)==data
# Positive sparse control includes explicitly STORED empty text, distinct from
# an absent state. Only the intended index/end condition differs per rejection.
positive={'valuesHex':struct.pack('<iii',1,0,0).hex(),'valuesOffset':0}
vals,spans=local.variable_cells(positive,1);assert vals==[b'']and spans==[{'offset':12,'bytes':0}]
controls=[]
for name,blob,reason in [('row-index',struct.pack('<iii',1,1,0),'row-index-out-of-range'),('cumulative-end',struct.pack('<iii',1,0,1),'invalid-cumulative-end'),('duplicate-index',struct.pack('<iiiii',2,0,0,0,0),'duplicate-row-index')]:
 try:local.variable_cells({'valuesHex':blob.hex(),'valuesOffset':0},1)
 except AssertionError as e:assert str(e)==reason;controls.append({'name':name,'status':'passed','actualReason':str(e)})
 else:raise AssertionError(name+' unexpectedly accepted')
fixture=copy.deepcopy(inventory);field=fixture['tables'][0]['fields'][0];blob=bytearray(base64.b64decode(field['valuesBase64']));n=struct.unpack_from('<i',blob)[0];offset=4+8*n;assert offset<len(blob);blob[offset]=255;field['valuesBase64']=base64.b64encode(blob).decode()
try:reader.decode_tables(fixture)
except UnicodeDecodeError as e:assert e.start==0 and e.reason=='invalid start byte';controls.append({'name':'stored-UTF8','status':'passed','actualReason':e.reason})
else:raise AssertionError('Invalid stored UTF-8 accepted')
report={'status':'passed-static-scoped','independentlyComparedCellStates':51572,'comparisonKinds':dict(matched),'restoredFromDeliveredCellsFieldBlobs':len(fields),'wholePayloadReconstructedSha256':hashlib.sha256(restored).hexdigest(),'sourceAndOutputPins':{str(p.relative_to(R)):sha(p)for p in[source,D/'verified/cells.jsonl',D/'verified/fields.json',D/'frozen_envelope_reader.py',D/'frozen_independent_reader.py',pathlib.Path(__file__)]},'matchedNegativeControls':controls,'explicitEmptyAndAbsentDistinct':True,'unresolvedTextFields':[{'sheet':k[0],'field':k[1],'kind':k[2],**v}for k,v in sorted(unresolved.items())],'unresolvedStoredNonemptyTextStates':sum(x['nonempty']for x in unresolved.values()),'unresolvedWords':sum(x['words']for x in unresolved.values()),'boundary':'Static source-payload bytes, cell identities/types and sparse/UTF8 guard mechanisms; no game/assembly/Unity runtime or consumer/display acceptance. Opaque typed resources/lists are byte-compared, not semantically decoded.'}
(D/'readback-validation.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({k:v for k,v in report.items()if k not in['sourceAndOutputPins','unresolvedTextFields','matchedNegativeControls']},ensure_ascii=False))
