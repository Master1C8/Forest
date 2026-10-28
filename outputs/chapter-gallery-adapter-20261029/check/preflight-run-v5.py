"""Finite real-resource static preflight; no game execution or semantic judgment."""
import copy,hashlib,importlib.util,json,pathlib,shutil,struct,subprocess,sys,time,traceback
ROOT=pathlib.Path('/Users/antonkrutov/Desktop/Forest');CHECK=ROOT/'outputs/chapter-gallery-adapter-20261029/check'
EXEC=pathlib.Path(sys.argv[1]).resolve();OUT=pathlib.Path(sys.argv[2]).resolve();OUT.mkdir()
sys.path.insert(0,str(EXEC))
import russian_chapter_gallery_case as a
import decode_inventory as bg
from extract_assets import read_tree
import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
CANDIDATE=ROOT/'localization/previews/ru-20261028-texture-preserving-17/game/The Forest of Love_Data'
results=[]
def check(name,call):
 value=call();results.append({'name':name,'status':'passed','evidence':value});print(name,'passed',flush=True);return value
def reject(name,call,reason):
 try: call()
 except a.AdapterError as e:
  assert str(e).startswith(reason),(name,str(e),reason)
  results.append({'name':name,'status':'passed','expectedRejection':str(e)});print(name,'rejected correctly',flush=True);return
 raise AssertionError((name,'not rejected'))
def h(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def save_tree(obj,tree,g):
 nodes=None
 if obj.type.name=='MonoBehaviour':
  script=obj.parse_monobehaviour_head().m_Script.deref().read();fullname=(script.m_Namespace+'.' if script.m_Namespace else '')+script.m_ClassName
  nodes=g.cache.get(('forest-header-aligned:'+script.m_AssemblyName,fullname))
 obj.save_typetree(tree,nodes=nodes)
def objects(env,name):return {o.path_id:o for o in env.objects if o.assets_file.name==name}
def load_native(path,name):
 dependencies=[str(CANDIDATE/'globalgamemanagers.assets')]
 if name=='sharedassets2.assets':dependencies.append(str(CANDIDATE/'sharedassets0.assets'))
 return UnityPy.load(str(path),*dependencies)
rows=a.jsonl((EXEC/'draft-targets.jsonl').read_bytes());plan=check('explicit-draft-134-positive',lambda:a.prepare_static_preflight(rows,locale='ru'))
results[-1]['evidence']={'mode':plan.mode,'rows':len(plan.rows),'targetJsonlSha256':h(EXEC/'draft-targets.jsonl')}
for value in (None,'en','unknown','RU',''):
 reject('locale-'+str(value),lambda value=value:a.prepare_static_preflight(rows,locale=value),'explicit-supported-locale-required')
for label,modify,reason in [
 ('missing-id',lambda r:r.pop(),'exact134-unique-ids-required'),
 ('duplicate-id',lambda r:r.__setitem__(-1,copy.deepcopy(r[0])),'exact134-unique-ids-required'),
 ('extra-id',lambda r:r.append(copy.deepcopy(r[0])),'exact134-unique-ids-required'),
 ('wrong-id-same-source-other-field',lambda r:r[0].__setitem__('id',r[0]['id'].replace('/m_text','/unboundText')),'exact134-id-set-required'),
 ('wrong-source-valid-hash',lambda r:(r[0].__setitem__('source',r[0]['source']+'!'),r[0].__setitem__('sourceSha256',a.digest(r[0]['source'].encode()))),'target-source-binding:'),
 ('stale-target-hash',lambda r:r[0].__setitem__('target',r[0]['target']+'!'),'target-hash:'),
 ('empty-target-valid-hash',lambda r:(r[0].__setitem__('target',' '),r[0].__setitem__('targetSha256',a.digest(b' '))),'empty-or-invalid-target:'),
 ('row-wrong-locale',lambda r:r[0].__setitem__('locale','ja'),'target-locale:')]:
 changed=copy.deepcopy(rows);modify(changed);reject(label,lambda changed=changed:a.prepare_static_preflight(changed,locale='ru'),reason)
for source_value in ('Movie {0}','Story {0}'):
 changed=copy.deepcopy(rows);r=next(r for r in changed if r['source']==source_value);r['target']=r['target'].replace('{0}','{1}');r['targetSha256']=a.digest(r['target'].encode());reject('changed-template-'+source_value,lambda:a.prepare_static_preflight(changed,locale='ru'),'protected-template:')
for value in (None, 'en', 'unknown'):
 reject('normal-loader-locale-'+str(value),lambda value=value:a.load_inputs(locale=value),'explicit-supported-locale-required')
try:a.load_inputs()
except TypeError:check('normal-loader-locale-omitted',lambda:True)
else:raise AssertionError('omitted locale accepted')
reject('normal-loader-draft-only-snapshot',lambda:a.load_inputs(locale='ru'),'bounded-editorial-acceptance-required')
# No accepted snapshot or successful acceptance receipt is fabricated.
blocked=OUT/'blocked-snapshot';blocked.mkdir();reject('snapshot-before-writes',lambda:a.snapshot(blocked,locale='ru'),'bounded-editorial-acceptance-required');assert not list(blocked.iterdir())
input_paths=[CANDIDATE/n for n in ('resources.assets','sharedassets0.assets','sharedassets2.assets','Managed/Assembly-CSharp.dll')]
input_hashes={str(p.relative_to(CANDIDATE)):h(p) for p in input_paths};(OUT/'candidate-inputs.json').write_bytes(a.json_bytes(input_hashes))
g=TypeTreeGenerator('2020.3.24f1');g.load_local_dll_folder(str(CANDIDATE/'Managed'))
env=UnityPy.load(str(CANDIDATE/'resources.assets'));objs=objects(env,'resources.assets');payload_tree=read_tree(objs[320],g);payload=payload_tree['m_Script'].encode('utf-8','surrogateescape')
kw=dict(locale='ru',expected_before_sha256=a.digest(payload),plan=plan,static_preflight=True)
projected,receipt=check('bg-real-candidate17-113-readback-reversal',lambda:a.project_bg(payload,bg.parse,bg.variable_cells,**kw));results[-1]['evidence']=receipt
(OUT/'before-bg.bin').write_bytes(payload);(OUT/'after-bg.bin').write_bytes(projected)
reject('draft-plan-in-normal-bg',lambda:a.project_bg(payload,bg.parse,bg.variable_cells,**dict(kw,static_preflight=False)),'draft-not-accepted-for-build')
reject('bg-already-applied-with-current-hash',lambda:a.project_bg(projected,bg.parse,bg.variable_cells,**dict(kw,expected_before_sha256=a.digest(projected))),'bg-source-before:')
reject('bg-stale-immediate-input-hash',lambda:a.project_bg(projected,bg.parse,bg.variable_cells,**kw),'bg-before-payload-hash')
# Mutate a selected source cell while satisfying the unrelated whole-payload hash
# guard, so this negative exercises source binding rather than an earlier guard.
before=bg.parse(payload);s=next(s for s in before['sheets'] if s['name']=='Chapter');f=next(f for f in s['fields'] if f['name']=='title');blob=payload[f['valuesOffset']:f['valuesOffset']+f['valuesBytes']];cells,_=bg.variable_cells(dict(f,valuesHex=blob.hex()),len(s['rowIds']));cells[0]+=b'!';mutated=a.replace_columns(payload,[(f,a.encode_cells(blob,cells))])
reject('bg-changed-selected-input-valid-payload-hash',lambda:a.project_bg(mutated,bg.parse,bg.variable_cells,**dict(kw,expected_before_sha256=a.digest(mutated))),'bg-source-before:')
# Materialize exactly one absent state with otherwise valid framing/hash.
cells,_=bg.variable_cells(dict(f,valuesHex=blob.hex()),len(s['rowIds']));idx=next(i for i,c in enumerate(cells) if c is None);cells[idx]=b'bad';pairs=[(i,c) for i,c in enumerate(cells) if c is not None];data=b'';enc=[]
for i,c in pairs:data+=c;enc.append(struct.pack('<ii',i,len(data)))
mutated=a.replace_columns(payload,[(f,struct.pack('<i',len(pairs))+b''.join(enc)+data)])
reject('bg-absent-cell-materialized-valid-payload-hash',lambda:a.project_bg(mutated,bg.parse,bg.variable_cells,**dict(kw,expected_before_sha256=a.digest(mutated))),'bg-sparse-membership')
# Overlap in both directions, actual complete source-bound corpus: exact equality
# and selector-based replacement must not mistake substrings for applied targets.
for label,source_row,target in [('source-inside-target',next(r for r in rows if r['id'].startswith('bgdb:')),None),('target-inside-source',next(r for r in rows if r['id'].startswith('bgdb:') and len(r['source'])>5),None)]:
 changed=copy.deepcopy(rows);r=next(r for r in changed if r['id']==source_row['id']);r['target']=(r['source']+' [static test]') if label=='source-inside-target' else r['source'][:5];r['targetSha256']=a.digest(r['target'].encode());overlap=a.prepare_static_preflight(changed,locale='ru');v,e=a.project_bg(payload,bg.parse,bg.variable_cells,**dict(kw,plan=overlap));assert e['fullImmediatePriorPayloadRestored'];check('bg-'+label,lambda:e['readback'][0])
# All prior localized columns are real prior outputs, byte-exact after projection.
original=(ROOT/'assets/source-v2/text-assets/90744c19ec-resources.assets-320.bin').read_bytes();orig=bg.parse(original);prior_changed=[]
selected_keys={(r['sheetId'],r['fieldId']) for r in a.jsonl(plan.packet['source.jsonl']) if r['id'].startswith('bgdb:')}
for os,cs in zip(orig['sheets'],before['sheets']):
 for of,cf in zip(os['fields'],cs['fields']):
  ob=original[of['valuesOffset']:of['valuesOffset']+of['valuesBytes']];cb=payload[cf['valuesOffset']:cf['valuesOffset']+cf['valuesBytes']]
  if ob!=cb:
   assert (cs['id'],cf['id']) not in selected_keys
   prior_changed.append(cs['name']+'.'+cf['name'])
assert {'Actor.nameplate_name','Actor.full_name','Quest.bio_title','InventoryItem.title','InventoryItem.description','QuestProgressLogText.log_text'}.issubset(set(prior_changed)),prior_changed
check('prior-localized-columns-survive',lambda:prior_changed)
# Write and reopen resources.assets, verify actual serialized TextAsset readback
# and every other object's original raw bytes, not only Python in-memory values.
raw_before={pid:o.get_raw_data() for pid,o in objs.items()};target_tree=copy.deepcopy(payload_tree);target_tree['m_Script']=projected.decode('utf-8','surrogateescape');save_tree(objs[320],target_tree,g);asset=objs[320].assets_file;asset_path=OUT/'resources.assets';asset_path.write_bytes(asset.save());back=objects(UnityPy.load(str(asset_path)),'resources.assets');assert set(back)==set(objs);got=read_tree(back[320],g);assert got==target_tree
assert all(back[pid].get_raw_data()==v for pid,v in raw_before.items() if pid!=320)
# Reversal checks the selected object's original serialized bytes, too.
save_tree(back[320],payload_tree,g);assert back[320].data==raw_before[320]
check('bg-serialized-resource-readback-and-object-reversal',lambda:{'assetSha256':h(asset_path),'unselectedObjectsByteExact':len(objs)-1,'selectedRawRestored':True})
del env,objs,back,raw_before
native_receipts=[]
for name in ('sharedassets0.assets','sharedassets2.assets'):
 env=UnityPy.load(str(CANDIDATE/name));objs=objects(env,name);raw={pid:o.get_raw_data() for pid,o in objs.items()};native_kw=dict(locale='ru',expected_asset_sha256=input_hashes[name],actual_asset_sha256=h(CANDIDATE/name),plan=plan,static_preflight=True)
 updates,nr=a.native_plan(name,objs,g,**native_kw);selected=set(updates);original_trees={pid:read_tree(objs[pid],g) for pid in selected}
 # Merge preserves current typography and a pending owner's non-text field edit.
 pid=next(iter(selected));prior=copy.deepcopy(original_trees[pid]);prior['m_lineSpacing']+=1;merged,_=a.native_plan(name,objs,g,prior={pid:prior},**native_kw);assert merged[pid]['m_lineSpacing']==prior['m_lineSpacing'];check('native-merge-prior-typography-'+name,lambda:True)
 reject('native-already-planned-'+name,lambda:a.native_plan(name,objs,g,prior=updates,**native_kw),'native-prior-text-conflict:')
 # Exact field mismatch on a real source object, with the asset version guard valid.
 bad=copy.deepcopy(original_trees[pid]);bad['m_text']+='!';save_tree(objs[pid],bad,g)
 changed_dir=OUT/('changed-native-'+name);changed_dir.mkdir();changed_path=changed_dir/name;changed_path.write_bytes(objs[pid].assets_file.save());changed_env=load_native(changed_path,name);changed_objs=objects(changed_env,name);changed_kw=dict(native_kw,expected_asset_sha256=h(changed_path),actual_asset_sha256=h(changed_path))
 reject('native-changed-input-valid-version-hash-'+name,lambda:a.native_plan(name,changed_objs,g,**changed_kw),'native-source-before:')
 save_tree(objs[pid],original_trees[pid],g);assert objs[pid].data==raw[pid]
 for pid,tree in updates.items():save_tree(objs[pid],tree,g)
 out=OUT/name;out.write_bytes(objs[next(iter(selected))].assets_file.save());back=objects(load_native(out,name),name);assert set(back)==set(objs)
 for pid,obj in back.items():
  if pid not in selected:assert obj.get_raw_data()==raw[pid],(name,pid)
  else:
   t=read_tree(obj,g);assert t==updates[pid];restored=copy.deepcopy(t);restored['m_text']=original_trees[pid]['m_text'];assert restored==original_trees[pid];save_tree(obj,restored,g);assert obj.data==raw[pid]
 nr.update(targetAssetSha256=h(out),allUnselectedObjectsByteExact=True,unselectedObjects=len(objs)-len(selected),selectedObjectRawReversal=True,allOtherFieldsPreserved=True);native_receipts.append(nr);check('native-serialized-readback-reversal-'+name,lambda:nr)
 del env,objs,back,raw
# Backend test operates on real candidate DLL and records every method fingerprint.
recipe=OUT/'managed-recipe';shutil.copytree(EXEC/'cecil',recipe)
managed_out=OUT/'Assembly-CSharp.dll';managed_receipt=OUT/'managed-readback.json'
mr=check('managed-real-candidate17-three-operands',lambda:a.patch_managed(CANDIDATE/'Managed/Assembly-CSharp.dll',managed_out,managed_receipt,recipe,locale='ru',expected_before_sha256=input_hashes['Managed/Assembly-CSharp.dll'],plan=plan,static_preflight=True));results[-1]['evidence']={k:v for k,v in mr.items() if k!='inventory'}
reject('managed-already-applied-current-hash',lambda:a.patch_managed(managed_out,OUT/'reapplied.dll',OUT/'reapplied.json',recipe,locale='ru',expected_before_sha256=h(managed_out),plan=plan,static_preflight=True),'managed-supported-before-hash')
unknown=OUT/'changed-source.dll';unknown.write_bytes((CANDIDATE/'Managed/Assembly-CSharp.dll').read_bytes()+b'changed-version');reject('managed-actual-changed-input-valid-caller-hash',lambda:a.patch_managed(unknown,OUT/'changed-output.dll',OUT/'changed-receipt.json',recipe,locale='ru',expected_before_sha256=h(unknown),plan=plan,static_preflight=True),'managed-supported-before-hash')
# Direct backend negative bypasses Python and must still reject changed versions.
request=json.loads((recipe/'chapter-gallery-request.json').read_text());request['expectedBeforeSha256']=h(unknown);badrequest=OUT/'changed-version-request.json';badrequest.write_bytes(a.json_bytes(request));process=subprocess.run(['dotnet',str(recipe/'ChapterGalleryPatch.dll'),str(unknown),str(badrequest),str(OUT/'backend-bad.dll'),str(OUT/'backend-bad.json'),str(recipe/'chapter-gallery-source.jsonl'),str(recipe/'chapter-gallery-preserve-exactly.jsonl')],capture_output=True,text=True);assert process.returncode!=0 and 'managed-supported-before-hash' in process.stderr;assert not (OUT/'backend-bad.dll').exists();check('cecil-independent-version-rejection',lambda:{'exitCode':process.returncode,'reason':'managed-supported-before-hash'})
# Real filesystem failure after DLL write and before its receipt. Preserve
# the incomplete artifact and report it without creating a completion receipt.
failure=OUT/'failure-between-writes';failure.mkdir();failure_out=failure/'Assembly-CSharp.dll';failure_receipt=failure/'missing-parent/receipt.json'
process=subprocess.run(['dotnet',str(recipe/'ChapterGalleryPatch.dll'),str(CANDIDATE/'Managed/Assembly-CSharp.dll'),str(recipe/'chapter-gallery-request.json'),str(failure_out),str(failure_receipt),str(recipe/'chapter-gallery-source.jsonl'),str(recipe/'chapter-gallery-preserve-exactly.jsonl')],capture_output=True,text=True)
assert process.returncode!=0 and 'DirectoryNotFoundException' in process.stderr and failure_out.exists() and not failure_receipt.exists()
assert h(failure_out)==h(managed_out)
check('actual-failure-between-dll-and-receipt-writes',lambda:{'exitCode':process.returncode,'dllWritten':True,'receiptWritten':False,'dllSha256':h(failure_out),'accepted':False,'recovery':'Preserve incomplete task-owned output; do not treat it as a completed package or retry in place.'})
assert all(h(p)==input_hashes[str(p.relative_to(CANDIDATE))] for p in input_paths)
check('readonly-candidate17-inputs-unchanged',lambda:input_hashes)
report={'status':'passed-static-preflight-only','execution':str(EXEC.relative_to(ROOT)),'executionPinsSha256':h(EXEC/'chapter-gallery-inputs.json'),'candidateInputs':input_hashes,'tests':results,'native':native_receipts,'targetEditorialAccepted':False,'wholeGameAccepted':False,'runtime':'not-run','transaction':'No multi-file transaction; outputs are task-owned and completion report is written last.'}
(OUT/'preflight.json').write_bytes(a.json_bytes(report));print('COMPLETE',len(results),'checks',flush=True)
