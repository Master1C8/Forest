from pathlib import Path
import subprocess,json,hashlib,ast,re
out=Path(__file__).resolve().parent;root=out.parents[3];i=root/'tools/probe/bin/Debug/net8.0/InspectMethods.dll';readback=out/'compiled-readback'
def inspect(dll,t,m):return subprocess.check_output(['dotnet',str(i),str(dll),t,m],text=True)
def normalize(s):
 s=re.sub(r'(b__|<>9__)(\d+)(_)',r'\1N\3',s)
 s=re.sub(r'(<[A-Za-z0-9_]+>d__)(\d+)',r'\1N',s)
 return re.sub(r'(<>c__DisplayClass)(\d+)(_)',r'\1N\3',s)
def bodies(dll):
 result={}
 for t in inspect(dll,'--types','').splitlines():
  names=sorted(set(re.findall(r'::([^:(]+)\(',inspect(dll,t,'--list'))))
  if not names:continue
  raw=inspect(dll,t,','.join(names))
  for block in re.split(r'(?m)^METHOD ',raw)[1:]:
   sig=block.split(' | ',1)[0]
   key=normalize(sig)
   assert key not in result,('ambiguous normalized identity',key)
   result[key]=dict(raw='METHOD '+block,normalized=normalize('METHOD '+block),signature=sig,type=t)
 return result
summary={}
for mode in ['original','synthetic']:
 before=out/f'ForestProbe.before.{mode}.dll';after=out/f'ForestProbe.after.{mode}.dll'
 a,b=bodies(before),bodies(after)
 equal=[];renumbered=[];changed=[];added=[]
 for key,old in a.items():
  assert key in b,('missing method',key)
  new=b[key]
  if old['raw']==new['raw']:equal.append(key)
  elif old['normalized']==new['normalized']:
   renumbered.append(dict(before=old['signature'],after=new['signature']))
  else:changed.append(key)
  if old['raw']!=new['raw']:
   filename=hashlib.sha256(key.encode()).hexdigest()[:16]
   (readback/(mode+'-'+filename+'.before.il')).write_text(old['raw'])
   (readback/(mode+'-'+filename+'.after.il')).write_text(new['raw'])
 for key,new in b.items():
  if key not in a:
   added.append(key)
   filename=hashlib.sha256(key.encode()).hexdigest()[:16]
   (readback/(mode+'-'+filename+'.added.il')).write_text(new['raw'])
 print(mode,'exact',len(equal),'renumbered',len(renumbered),'changed',changed,'added',added,flush=True)
 assert set(changed)=={'System.Void ForestProbe::Update()','System.String ForestProbe::KeyboardMaps(Rewired.Player)','System.Void ForestProbe::LateUpdate()'}
 new_reader=[v['raw'] for k,v in b.items() if 'Bucky' in k and k not in a]
 combined='\n'.join(new_reader)
 for forbidden in ['::CanTrigger(', '::HasAvailableMessages(', '::IsSatisfied(', '::TakeControl(', '::Fire(', '::PlayDialogue(', '::SetValue(', '::Invoke(', '::set_position(', '::set_velocity(']:
  assert forbidden not in combined,forbidden
 summary[mode]=dict(exact=equal,compilerOrdinalOnly=renumbered,intentionallyChanged=changed,added=added,
  normalization='Only generated method/cache-field ordinals b__N_/<>9__N_ DisplayClassN_ and named iterator d__N; normalized signatures must be unique. Every existing body and generated closure compared. Overloads keyed by full signature.',
  readOnlyBuckyForbiddenCallsAbsent=True)
p='tools/probe/diagnose_newgame.py';aa=ast.parse((out/'diagnose_newgame.before.py').read_text());bb=ast.parse((out/'diagnose_newgame.py').read_text())
a={n.name:ast.dump(n,include_attributes=False) for n in aa.body if isinstance(n,(ast.FunctionDef,ast.ClassDef))};b={n.name:ast.dump(n,include_attributes=False) for n in bb.body if isinstance(n,(ast.FunctionDef,ast.ClassDef))};assert all(a[k]==b.get(k) for k in a)
summary['host']=dict(unchanged=sorted(a),added=sorted(set(b)-set(a)),scope='AST equality for every existing top-level definition, including nested class methods')
summary['baselineHead']='81a278c6606351696c97d12abbe5a9cc1996ff05'
summary['inputs']={str(p.relative_to(root)):hashlib.sha256(p.read_bytes()).hexdigest() for p in [out/'ForestProbe.before.cs',out/'ForestProbe.cs',out/'ForestProbe.before.original.dll',out/'ForestProbe.after.original.dll',out/'ForestProbe.before.synthetic.dll',out/'ForestProbe.after.synthetic.dll',out/'diagnose_newgame.before.py',out/'diagnose_newgame.py']}
def update_body(text):
 return text.split('    void Update() {',1)[1].split('    void RestoreInputPolicy()',1)[0]
old_update=update_body((out/'ForestProbe.before.cs').read_text())
new_update=update_body((out/'ForestProbe.cs').read_text())
start=new_update.index('            else if(text=="dump-bucky") {')
end=new_update.index('            else if(text=="qa-background-input") {',start)
assert new_update[:start]+new_update[end:]==old_update
summary['updateExistingCommandsExactSourceEqualityAfterRemovingOnlyDumpBuckyBranch']=True
(readback/'comparison.json').write_text(json.dumps(summary,indent=2)+'\n')
a=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/Managed/Assembly-CSharp.dll')
(readback/'original-TriggerDbName.il').write_text(inspect(a,'TheForestOfLove.Interaction.InteractionTrigger','get_TriggerDbName'))
