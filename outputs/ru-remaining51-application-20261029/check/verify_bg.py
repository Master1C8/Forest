"""Actual private TextAsset projection, independent full-state decoder and Unity save/readback."""
import argparse,sys,pathlib,json,hashlib,base64,struct,urllib.parse,importlib.util
R=pathlib.Path('/Users/antonkrutov/Desktop/Forest');C=R/'outputs/ru-remaining51-application-20261029/check'
p=argparse.ArgumentParser();p.add_argument('--helper',type=pathlib.Path,default=R/'tools/russian_remaining51_case.py');p.add_argument('--output',type=pathlib.Path,required=True);args=p.parse_args()
sys.path.insert(0,str(args.helper.parent));spec=importlib.util.spec_from_file_location('remaining51_bg',args.helper);h=importlib.util.module_from_spec(spec);spec.loader.exec_module(h)
import UnityPy
codec=h.module(h.ROOT/h.CODEC,'codec');peer=h.module(h.ROOT/h.PEER,'peer')
sha=h.sha;enc=h.enc
source=h.ROOT/'localization/previews/ru-20261029-chapter-gallery-02/game/The Forest of Love_Data/resources.assets'
env=UnityPy.load(str(source));objects={o.path_id:o for o in env.objects};raw={i:h.digest(o.get_raw_data())for i,o in objects.items()};tree=objects[320].read_typetree();assert tree['m_Name']=='bansheegz_database';data=tree['m_Script'].encode('utf-8','surrogateescape')
result,receipt=h.project_bg(data,codec.parse,codec.variable_cells,locale='ru')
_,a=h.bg_inventory(data);_,b=h.bg_inventory(result)
def independently_read(blob):
 inv=peer.extract(blob); decoded=peer.decode_tables(inv);states={};count=0
 for t in inv['tables']:
  bid=lambda x:base64.b64encode(bytes.fromhex(x)).decode()[:22]
  for f in t['fields']:
   kind=f['type'].split(',')[0].split('.')[-1];v=base64.b64decode(f['valuesBase64']);n=len(t['rowIds']);values=[None]*n
   if kind in h.WIDTHS:
    width=h.WIDTHS[kind];assert len(v)==width*n
    values=[v[i*width:(i+1)*width]for i in range(n)]
   else:
    k=int.from_bytes(v[:4],'little',signed=True);assert len(v)>=4+8*k
    start=4+8*k;last=0;seen=set()
    for j in range(k):
     idx=int.from_bytes(v[4+8*j:8+8*j],'little',signed=True);end=int.from_bytes(v[8+8*j:12+8*j],'little',signed=True)
     assert idx not in seen and 0<=idx<n and last<=end<=len(v)-start
     seen.add(idx);values[idx]=v[start+last:start+end];last=end
    assert start+last==len(v)
   for i,row in enumerate(t['rowIds']):
    ident='bgdb:resources.assets:320/sheet/'+urllib.parse.quote(bid(t['id']),safe='')+'/row/'+urllib.parse.quote(bid(row),safe='')+'/field/'+urllib.parse.quote(bid(f['id']),safe='')
    assert ident not in states;states[ident]=values[i];count+=1
    if kind in ['BGFieldString','BGFieldText','BGFieldEntityName']:
     assert decoded[t['name']][i][f['name']]==(values[i].decode()if values[i]is not None else None)
 assert count==51572
 return states
assert independently_read(data)==a and independently_read(result)==b
# Check original physical source provenance; current offsets deliberately come from reparse.
original=(h.ROOT/'assets/source-v2/text-assets/90744c19ec-resources.assets-320.bin').read_bytes()
for r in h.load_inputs(locale='ru')['rows'][:17]:
 span=r['sourceSpan'];assert original[span['offset']:span['offset']+span['bytes']]==r['source'].encode()
# All 85 protected BG records include dormant literals, actor and portrait relations.
# Real Unity stream: save only TextAsset320, then reload every object from bytes.
tree['m_Script']=result.decode('utf-8','surrogateescape');objects[320].save_typetree(tree)
serialized=next(iter(env.files.values())).save();rb=UnityPy.load(serialized);new={o.path_id:o for o in rb.objects};assert new.keys()==objects.keys()
for i,o in new.items():
 if i!=320:assert h.digest(o.get_raw_data())==raw[i],i
nt=new[320].read_typetree();assert nt==tree
readback=nt['m_Script'].encode('utf-8','surrogateescape');assert independently_read(readback)==b
# Reverse TextAsset on actual serialized readback and verify exact prior resource bytes.
nt['m_Script']=data.decode('utf-8','surrogateescape');new[320].save_typetree(nt);reversed_bytes=next(iter(rb.files.values())).save()
assert reversed_bytes==source.read_bytes(),'resource whole-byte reversal'
args.output.mkdir(exist_ok=False,parents=True)
(args.output/'resources.assets').write_bytes(serialized);(args.output/'bg-before.bin').write_bytes(data);(args.output/'bg-after.bin').write_bytes(result);(args.output/'resources.reversed.assets').write_bytes(reversed_bytes)
with (args.output/'all-states-readback.jsonl').open('xb')as f:
 for ident in a:f.write(enc({'id':ident,'beforeRawSha256':None if a[ident]is None else h.digest(a[ident]),'afterRawSha256':None if b[ident]is None else h.digest(b[ident]),'changed':a[ident]!=b[ident],'independentReadback':True}))
receipt.update(sourceResourcesSha256=sha(source),outputResourcesSha256=h.digest(serialized),resourcesBytes=len(serialized),independentReadbackStates=51572,unityObjects=len(objects),unchangedOtherRawObjects=len(objects)-1,unchangedResourceTextures=sum(o.type.name=='Texture2D'for o in objects.values()),wholeResourceSerializedReversalByteExact=True,reversedResourcesSha256=h.digest(reversed_bytes),readbackLedgerSha256=sha(args.output/'all-states-readback.jsonl'),containerBoundary='TextAsset320 payload changes; Unity size/offset framing necessarily adjusts. Every other object payload is byte-exact; reversing TextAsset restores exact whole original container bytes.',runtime='not-run')
(args.output/'bg-readback.json').write_bytes(enc(receipt));print(json.dumps({k:v for k,v in receipt.items()if k!='changedIds'}))
