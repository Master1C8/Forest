"""Read saved output bytes independently of the adapter's projection functions."""
import hashlib,json,pathlib,struct,sys
ROOT=pathlib.Path('/Users/antonkrutov/Desktop/Forest');CHECK=ROOT/'outputs/chapter-gallery-adapter-20261029/check';EXEC=CHECK/'execution-v3';OUT=CHECK/'preflight-v6'
sys.path.insert(0,str(EXEC));import decode_inventory as bg
import UnityPy
from extract_assets import read_tree
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
CANDIDATE=ROOT/'localization/previews/ru-20261028-texture-preserving-17/game/The Forest of Love_Data'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def rows(p):return [json.loads(l) for l in p.read_text().splitlines()]
sources=rows(EXEC/'chapter-gallery-source/source.jsonl');targets={r['id']:r for r in rows(EXEC/'draft-targets.jsonl')};absence=rows(EXEC/'chapter-gallery-source/absence.jsonl')
before=(OUT/'before-bg.bin').read_bytes();after=(OUT/'after-bg.bin').read_bytes();old=bg.parse(before);new=bg.parse(after)
def columns(data,env):return {(s['id'],f['id']):(s,f,data[f['valuesOffset']:f['valuesOffset']+f['valuesBytes']]) for s in env['sheets'] for f in s['fields']}
a,b=columns(before,old),columns(after,new);selected={(r['sheetId'],r['fieldId']) for r in sources if r['id'].startswith('bgdb:')};assert len(selected)==3;count=0
for r in sources+absence:
 if not r['id'].startswith('bgdb:'):continue
 s,f,blob=b[r['sheetId'],r['fieldId']];assert s['rowIds'][r['rowIndex']]==r['rowId'];cells,_=bg.variable_cells(dict(f,valuesHex=blob.hex()),len(s['rowIds']));expected=None if r['source'] is None else targets[r['id']]['target'].encode();assert cells[r['rowIndex']]==expected;count+=1
assert count==129 and len(b)==289
assert all(a[k][2]==b[k][2] for k in a if k not in selected)
restored=after
for key in sorted(selected,key=lambda k:b[k][1]['valuesOffset'],reverse=True):
 f=b[key][1];blob=a[key][2];start=f['valuesOffset'];restored=restored[:start-4]+struct.pack('<i',len(blob))+blob+restored[start+f['valuesBytes']:]
assert restored==before
# Original provenance offsets differ: confirm the actual current payload was used.
original_offsets_differ=all(a[r['sheetId'],r['fieldId']][1]['valuesOffset']!=r['sourceSpan']['offset'] for r in sources if r['id'].startswith('bgdb:'))
# The stronger comparison below compares actual column start offsets to original
# parser offsets; sourceSpan is a cell address, not a column address.
orig=bg.parse((ROOT/'assets/source-v2/text-assets/90744c19ec-resources.assets-320.bin').read_bytes());origcols=columns((ROOT/'assets/source-v2/text-assets/90744c19ec-resources.assets-320.bin').read_bytes(),orig)
shifted=[{'sheet':a[k][0]['name'],'field':a[k][1]['name'],'originalOffset':origcols[k][1]['valuesOffset'],'immediatePriorOffset':a[k][1]['valuesOffset'],'shift':a[k][1]['valuesOffset']-origcols[k][1]['valuesOffset']} for k in selected];assert all(r['shift']!=0 for r in shifted)
g=TypeTreeGenerator('2020.3.24f1');g.load_local_dll_folder(str(CANDIDATE/'Managed'))
text_spans=[]
for name in ['sharedassets0.assets','sharedassets2.assets']:
 extra=[str(CANDIDATE/'globalgamemanagers.assets')]+([str(CANDIDATE/'sharedassets0.assets')] if name=='sharedassets2.assets' else [])
 old_env=UnityPy.load(str(CANDIDATE/name));new_env=UnityPy.load(str(OUT/name),*extra)
 ao={o.path_id:o for o in old_env.objects if o.assets_file.name==name};bo={o.path_id:o for o in new_env.objects if o.assets_file.name==name};assert set(ao)==set(bo)
 sr=[r for r in sources if r['id'].startswith(name+':')];ids={int(r['physicalSelector']['object'].split(':')[1]) for r in sr}
 assert all(ao[pid].get_raw_data()==bo[pid].get_raw_data() for pid in ao if pid not in ids)
 for r in sr:
  pid=int(r['physicalSelector']['object'].split(':')[1]);left=ao[pid].get_raw_data();right=bo[pid].get_raw_data();source=r['source'].encode();target=targets[r['id']]['target'].encode();needle=struct.pack('<i',len(source))+source;assert left.count(needle)==1,(name,pid,'ambiguous source byte span');start=left.index(needle);end=start+len(needle);end+=( -end)%4;assert left[end-( - (start+len(needle)))%4:end]==b'\0'*((-(start+len(needle)))%4)
  inserted=struct.pack('<i',len(target))+target;inserted+=b'\0'*((-(start+len(inserted)))%4);assert right==left[:start]+inserted+left[end:],(name,pid,'bytes outside m_text changed')
  ot=read_tree(ao[pid],g);nt=read_tree(bo[pid],g);assert ot['m_text']==r['source'] and nt['m_text']==targets[r['id']]['target'];nt['m_text']=ot['m_text'];assert nt==ot
  text_spans.append({'id':r['id'],'sourceObjectSha256':hashlib.sha256(left).hexdigest(),'targetObjectSha256':hashlib.sha256(right).hexdigest(),'sourceStringLengthWordOffset':start,'sourceSpanBytes':end-start,'targetSpanBytes':len(inserted),'allOtherObjectBytesExact':True})
assert len(text_spans)==18
managed=json.loads((OUT/'managed-readback.json').read_text());assert sha(OUT/'Assembly-CSharp.dll')==managed['targetSha256'];assert managed['methodCount']==len(managed['inventory'])==14095;assert len({r['method'] for r in managed['inventory']})==14095;changed=[r['method'] for r in managed['inventory'] if r['beforeBodySha256']!=r['targetBodySha256']];assert set(changed)==set(managed['changedMethods']) and len(changed)==2;assert managed['serializedReversalReadback']
# Canonical normal loading must also be blocked, not only the frozen copy.
spec=__import__('importlib.util',fromlist=['']).spec_from_file_location('canonical_chapter_adapter',ROOT/'tools/russian_chapter_gallery_case.py');module=__import__('importlib.util',fromlist=['']).module_from_spec(spec);sys.modules[spec.name]=module;spec.loader.exec_module(module)
try:module.load_inputs(locale='ru')
except module.AdapterError as e:assert str(e)=='bounded-editorial-acceptance-required'
else:raise AssertionError('canonical normal loader unexpectedly accepted')
# Exact delivered code == tested immutable source bytes.
code={}
for source,dest in [('tools/russian_chapter_gallery_case.py','russian_chapter_gallery_case.py'),('tools/chapter_gallery_patch/Program.cs','chapter_gallery_patch/Program.cs'),('tools/chapter_gallery_patch/ChapterGalleryPatch.csproj','chapter_gallery_patch/ChapterGalleryPatch.csproj')]:
 assert sha(ROOT/source)==sha(EXEC/dest);code[source]=sha(ROOT/source)
report={'status':'passed-independent-saved-byte-readback','bgTargetCells':113,'bgAbsentStates':16,'bgUnselectedColumns':286,'bgImmediatePriorWholeRestoration':True,'currentOffsetsDifferFromOriginal':shifted,'nativeMTextOnlyExactByteSpans':text_spans,'managedMethods':14095,'managedChangedMethods':changed,'canonicalNormalLoader':'blocked-editorial-acceptance-required','deliveredCodeMatchesTestedExecution':code,'boundaries':'BG/native checked from saved bytes without adapter application functions; managed output hash/inventory checked against the Cecil full-readback/reversal receipt. Static only, no independent linguistic judgment or game execution.'}
(CHECK/'delivery-verification.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps({k:v for k,v in report.items() if k not in ['nativeMTextOnlyExactByteSpans','deliveredCodeMatchesTestedExecution']}))
