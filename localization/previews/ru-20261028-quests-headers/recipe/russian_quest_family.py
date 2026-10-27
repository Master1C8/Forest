"""Guarded complete Quest display projection;no save/identity/branch localization."""
import copy,hashlib,json
from pathlib import Path
from russian_actor_names import encode_cells,replace_columns
ROOT=Path('/Users/antonkrutov/Desktop/Forest');SOURCE=ROOT/'localization/source/quest-family-ui-20261028'
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def load_inputs():
 local=Path(__file__).parent
 if (local/'quest-family-inputs.json').exists():
  pins=json.loads((local/'quest-family-inputs.json').read_text())
  for n,v in pins.items():assert sha(local/n)==v,('quest-snapshot-pin',n)
  return tuple(json.loads((local/n).read_text()) for n in ['quest-family-inventory.json','quest-family-targets.json','quest-family-before.json'])
 from quest_supplement import inventory,all_records
 inv=inventory();ids={r['id'] for r in inv['sourceStates'] if r['source'] is not None}|{r['id'] for r in inv['units'] if r['family']=='quest-code'};records=[r for r in all_records('ru') if r['id'] in ids];assert len(records)==205
 return inv,records,json.loads((SOURCE/'russian-input.json').read_text())
def snapshot(folder):
 import shutil
 code=folder/'quest-patch-source';code.mkdir()
 for n in ['Program.cs','QuestPatch.csproj']:shutil.copy2(ROOT/'tools/quest_patch'/n,code/n)
 layout=folder/'quest-layout-source';layout.mkdir();shutil.copy2(ROOT/'tools/quest_layout/QuestLayout.cs',layout/'QuestLayout.cs')
 for n,v in zip(['quest-family-inventory.json','quest-family-targets.json','quest-family-before.json'],load_inputs()):(folder/n).write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
 inv,records,_=load_inputs();targets={r['id']:r['target'] for r in records};runtime=[]
 wording={u['phrase']:targets[u['id']] for u in inv['units'] if 'phrase' in u};assert len(wording)==157
 (folder/'quest-family-wording.json').write_text(json.dumps(wording,ensure_ascii=False,indent=2)+'\n')
 from russian_preview_ui import load_bg_parser
 parse,variable_cells=load_bg_parser();raw=(ROOT/'assets/source-v2/text-assets/90744c19ec-resources.assets-320.bin').read_bytes();assert hashlib.sha256(raw).hexdigest()==inv['sourceSha256']
 env=parse(raw)
 for spec in inv['sheets']:
  sheet=next(s for s in env['sheets'] if s['id']==spec['id']);f=next(f for f in sheet['fields'] if f['name']=='name');blob=raw[f['valuesOffset']:f['valuesOffset']+f['valuesBytes']];names,_=variable_cells(dict(f,valuesHex=blob.hex()),len(sheet['rowIds']));assert len(set(names))==len(names)
  for r in [r for r in inv['sourceStates'] if r['sheetId']==sheet['id']]:runtime.append(dict(id=r['id'],sheet=spec['name'],dbName=names[r['rowIndex']].decode(),field=r['field'],target=targets[r['id']] if r['source'] is not None else None))
 assert len(runtime)==195
 (folder/'quest-family-runtime.json').write_text(json.dumps(runtime,ensure_ascii=False,indent=2)+'\n')
 (folder/'quest-family-inputs.json').write_text(json.dumps({n:sha(folder/n) for n in ['quest-family-inventory.json','quest-family-targets.json','quest-family-before.json','quest-family-runtime.json','quest-family-wording.json','quest-patch-source/Program.cs','quest-patch-source/QuestPatch.csproj','quest-layout-source/QuestLayout.cs']},indent=2)+'\n')
def project_quest_family(data,parse,variable_cells):
 inv,records,before=load_inputs();assert hashlib.sha256(data).hexdigest()==before['inputPayloadSha256'],'quest-family-before-payload';targets={r['id']:r for r in records};retained=before['retainedTargets'];env=parse(data);edits=[];original={};count=0
 def protected(payload,environment):
  for row in inv['preserveExactly']:
   sheet=next(s for s in environment['sheets'] if s['id']==row['sheetId']);f=next(f for f in sheet['fields'] if f['id']==row['fieldId']);assert f['name']==row['field'];blob=payload[f['valuesOffset']:f['valuesOffset']+f['valuesBytes']];assert hashlib.sha256(blob).hexdigest()==row['expectedBlobSha256'],('protected-quest-column',row['field'])
 protected(data,env)
 for spec in inv['sheets']:
  sheet=next(s for s in env['sheets'] if s['id']==spec['id']);assert sheet['rowIds']==spec['rowIds'];assert sheet['name']==spec['name']
  for name,fid in spec['fields'].items():
   f=next(f for f in sheet['fields'] if f['id']==fid);assert f['name']==name;blob=data[f['valuesOffset']:f['valuesOffset']+f['valuesBytes']];original[(sheet['id'],fid)]=blob;cells,_=variable_cells(dict(f,valuesHex=blob.hex()),len(sheet['rowIds']))
   for r in [r for r in inv['sourceStates'] if r['sheetId']==sheet['id'] and r['fieldId']==fid]:
    i=r['rowIndex'];assert sheet['rowIds'][i]==r['rowId'];expected=retained.get(r['id'],r['source']);assert cells[i]==(expected.encode() if expected is not None else None),('quest-family-source-cell',r['id'])
    if r['source'] is not None:cells[i]=targets[r['id']]['target'].encode();count+=1
   edits.append((f,encode_cells(blob,cells)))
 assert count==177 and len(edits)==3
 result=replace_columns(data,edits);after=parse(result);protected(result,after);restore=[]
 for sheet in after['sheets']:
  for f in sheet['fields']:
   key=(sheet['id'],f['id'])
   if key not in original:continue
   blob=result[f['valuesOffset']:f['valuesOffset']+f['valuesBytes']];cells,_=variable_cells(dict(f,valuesHex=blob.hex()),len(sheet['rowIds']))
   for r in [r for r in inv['sourceStates'] if r['sheetId']==sheet['id'] and r['fieldId']==f['id']]:assert cells[r['rowIndex']]==(targets[r['id']]['target'].encode() if r['source'] is not None else None),('quest-family-readback',r['id'])
   restore.append((f,original[key]))
 assert replace_columns(result,restore)==data,'quest-family-whole-payload-restoration'
 return result,dict(displayCells=177,retainedExistingTargets=6,columns=3,nullStatesPreserved=18,exactReadback=True,wholePayloadRestoration=True,inputPayloadSha256=hashlib.sha256(data).hexdigest(),outputPayloadSha256=hashlib.sha256(result).hexdigest())
def patch_quest_code(source,target,receipt,recipe):
 import subprocess
 _,records,_=load_inputs();ids={r['id'] for r in load_inputs()[0]['units'] if r['family']=='quest-code'};rows=[r for r in records if r['id'] in ids];assert len(rows)==28
 folder=recipe/'quest-patch';folder.mkdir()
 pins=json.loads((recipe/'quest-family-inputs.json').read_text())
 layout=recipe/'quest-layout';layout.mkdir();layout_source=recipe/'quest-layout-source/QuestLayout.cs';assert sha(layout_source)==pins['quest-layout-source/QuestLayout.cs']
 bridge=json.loads((ROOT/'localization/probes/ru-20261026-15/bridge-build.json').read_text());compiler=Path(bridge['compiler']);assert sha(compiler)==bridge['compilerSha256']
 references=[source.parent/name for name in bridge['originalManagedReferences']]
 layout_dll=layout/'VNRevivalQuestLayout.dll'
 subprocess.run(['dotnet',str(compiler),'-nologo','-target:library','-nostdlib+','-out:'+str(layout_dll)]+['-r:'+str(p) for p in references]+[str(layout_source)],check=True)
 for name in ['Program.cs','QuestPatch.csproj']:
  import shutil
  code_source=recipe/'quest-patch-source'/name;assert sha(code_source)==pins['quest-patch-source/'+name]
  shutil.copy2(code_source,folder/name)
 (folder/'targets.json').write_text(json.dumps(rows,ensure_ascii=False,indent=2)+'\n')
 subprocess.run(['dotnet','build',str(folder/'QuestPatch.csproj'),'--output',str(folder/'compiled')],check=True,stdout=subprocess.DEVNULL)
 subprocess.run(['dotnet',str(folder/'compiled/QuestPatch.dll'),'patch',str(source),str(folder/'targets.json'),str(target),str(receipt),str(layout_dll)],check=True)
 import shutil;shutil.copy2(layout_dll,source.parent/'VNRevivalQuestLayout.dll')
 return json.loads(receipt.read_text())
