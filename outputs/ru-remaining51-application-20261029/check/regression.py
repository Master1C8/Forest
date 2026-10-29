"""Finite boundary controls with unchanged positives; no model/game calls."""
import pathlib,sys,copy,json,subprocess,hashlib,ast,shutil
R=pathlib.Path('/Users/antonkrutov/Desktop/Forest');C=R/'outputs/ru-remaining51-application-20261029/check';sys.path.insert(0,str(R/'tools'))
import russian_remaining51_case as h
O=C/'regression-complete';O.mkdir(exist_ok=False);tests=[]
def reject(name,call,reason):
 try:call()
 except ValueError as e:
  assert str(e)==reason,(name,str(e),reason)
 else:raise AssertionError('accepted:'+name)
 tests.append(dict(name=name,passed=True,reason=reason,positive='unchanged complete accepted inputs pass the same boundary'))
plan=h.load_inputs(locale='ru');sources=h.rows(h.ROOT/h.PACKET/'source-context.jsonl');targets=h.rows(h.ROOT/h.PACKET/'ru.prepared.jsonl')
for locale in [None,'en']:reject('invalid-locale-'+str(locale),lambda:h.load_inputs(locale=locale),'explicit-ru-locale-required')
for name,mutate,reason in [
 ('missing-id',lambda t:t.pop(),'exact51-unique-ids-required'),
 ('duplicate-id',lambda t:t[1].update(id=t[0]['id']),'exact51-unique-ids-required'),
 ('source-hash',lambda t:t[0].update(sourceUtf8Sha256='0'*64),'source-utf8-hash:'+sources[0]['id']),
 ('target-hash',lambda t:t[0].update(targetUtf8Sha256='0'*64),'target-utf8-hash:'+sources[0]['id']),
 ('source-text',lambda t:t[0].update(source=t[0]['source']+'!'),'source-binding:'+sources[0]['id']),
 ('retained3-new31-overlap',lambda t:t[22].update(reusedEvidence={'wrong':'reuse'}),'retained3-new31-disjoint'),
]:
 t=copy.deepcopy(targets);mutate(t);reject(name,lambda:h.validate_rows(t,sources,locale='ru'),reason);h.validate_rows(targets,sources,locale='ru')
for name,i,change,reason in [
 ('placeholder',19,lambda s:s.replace('{0}','{1}'),'protected-placeholder-markup:'),
 ('portrait-identity',32,lambda s:s.replace('[pic=2]','[pic=3]'),'protected-placeholder-markup:'),
 ('LF',23,lambda s:s.replace('\n',''),'protected-LF:'),
 ('final-space',25,lambda s:s.rstrip(' '),'protected-final-space:'),
 ('literal-backslash',0,lambda s:s.replace('\n','\\n'),'raw-LF-required:'),
]:
 t=copy.deepcopy(targets);t[i]['target']=change(t[i]['target']);t[i]['targetUtf8Sha256']=h.digest(t[i]['target'].encode());reject(name,lambda:h.validate_rows(t,sources,locale='ru'),reason+t[i]['id']);h.validate_rows(targets,sources,locale='ru')
# Actual loader absence/stale-acceptance boundaries, with earlier guards satisfied.
root=h.ROOT
for name,alter,reason in [('missing-acceptance',None,'bounded-editorial-acceptance-required'),('stale-target',b'\n','accepted-target-hash')]:
 fake=O/name;p=fake/h.PACKET;p.mkdir(parents=True)
 if alter:
  shutil.copy2(root/h.PACKET/'ru.acceptance.json',p/'ru.acceptance.json');(p/'ru.prepared.jsonl').write_bytes((root/h.PACKET/'ru.prepared.jsonl').read_bytes()+alter)
 h.ROOT=fake
 try:reject(name,lambda:h.load_inputs(locale='ru'),reason)
 finally:h.ROOT=root
 h.load_inputs(locale='ru')
# Exact accepted plan equality prevents injected or partial target plans in application.
wrong=copy.deepcopy(plan);wrong['rows'][0]['target']+='!';reject('injected-plan',lambda:h._use(wrong,'ru'),'accepted-plan-version')
codec=h.module(root/h.CODEC,'codec');actor=h.module(root/'tools/russian_actor_names.py','actor')
data=(C/'bg-private-01/bg-before.bin').read_bytes();result,_=h.project_bg(data,codec.parse,codec.variable_cells,locale='ru');env,states=h.bg_inventory(data)
for name,b in [('double-BG',result)]:reject(name,lambda:h.project_bg(b,codec.parse,codec.variable_cells,locale='ru'),'bg-source-before:'+plan['rows'][0]['id'])
sheet=next(s for s in env['sheets']if s['name']=='ActorGossipGreeting');field=next(f for f in sheet['fields']if f['name']=='greeting_text_test');blob=data[field['valuesOffset']:field['valuesOffset']+field['valuesBytes']];cells,_=codec.variable_cells(dict(field,valuesHex=blob.hex()),17);cells[0]=plan['rows'][0]['target'].encode();partial=actor.replace_columns(data,[(field,actor.encode_cells(blob,cells))]);reject('partial-BG',lambda:h.project_bg(partial,codec.parse,codec.variable_cells,locale='ru'),'bg-source-before:'+plan['rows'][0]['id'])
for name,fieldname in [('actor-relation','actor'),('dormant-backslash-sibling','greeting_text')]:
 f=next(f for f in sheet['fields']if f['name']==fieldname);blob=data[f['valuesOffset']:f['valuesOffset']+f['valuesBytes']];cs,_=codec.variable_cells(dict(f,valuesHex=blob.hex()),17);cs[0]=b'x'+cs[0][1:];changed=actor.replace_columns(data,[(f,actor.encode_cells(blob,cs))]);ident=next(r['cell']['id']for r in h.rows(root/h.PACKET/'preserve-exactly.jsonl')if r['kind']=='BG-unselected-field' and r['cell']['field']==fieldname and r['cell']['rowIndex']==0)
 reject(name,lambda:h.project_bg(changed,codec.parse,codec.variable_cells,locale='ru'),'bg-protected-state:'+ident)
 h.project_bg(data,codec.parse,codec.variable_cells,locale='ru')
# Wrong prior payload passes schema/selected/protected guards, then rejects whole version.
f=next(f for s in env['sheets']if s['name']=='Actor' for f in s['fields']if f['name']=='nameplate_name');at=f['valuesOffset']+f['valuesBytes']-1;changed=data[:at]+bytes([data[at]^1])+data[at+1:]
reject('unsupported-prior-BG',lambda:h.project_bg(changed,codec.parse,codec.variable_cells,locale='ru'),'supported-prior-bg-payload-hash')
backend=C/'frozen-delivery/remaining51/compiled/Remaining51Patch.dll';prior=root/'outputs/ru-haiku-identity-adapter-20261029/check/delivery/Assembly-CSharp.ru-haiku.dll';mapping=h.CONTRACT/'mapping.json'
def backend_reject(name,source,mode,reason,output=None):
 output=output or O/(name+'.dll');receipt=O/(name+'.json');r=subprocess.run(['dotnet',str(backend),mode,str(source),str(mapping),str(output),str(receipt)],capture_output=True,text=True)
 assert r.returncode==2 and r.stderr.strip()=='InvalidOperationException: '+reason,(name,r.returncode,r.stderr)
 tests.append(dict(name=name,passed=True,reason=reason,positive='supported exact prior succeeds with same backend and mapping'))
 return output,receipt
wrong=O/'wrong-prior.dll';wrong.write_bytes(prior.read_bytes()+b'\0')
backend_reject('wrong-prior-artifact',wrong,'patch','supported-prior-haiku-assembly-hash')
output,receipt=backend_reject('write-interruption',prior,'fail-write','injected-between-output-writes')
assert output.is_file()and pathlib.Path(str(output)+'.before.dll').is_file() and not receipt.exists() and not pathlib.Path(str(output)+'.methods.jsonl').exists()
assert h.sha(output)==h.sha(C/'private-01/Assembly-CSharp.remaining51.dll')and h.sha(str(output)+'.before.dll')==h.PRIOR
backend_reject('occupied-retry',prior,'patch','new-output-required',output)
reject('wrapper-double-managed',lambda:h.patch_managed(C/'private-01/Assembly-CSharp.remaining51.dll',O/'double.dll',O/'double.json',locale='ru',backend=backend),'supported-prior-haiku-assembly-hash')
assert not (O/'double.dll').exists()
# No-flag path: stripping only opt-in branches/decls and new report field recovers
# the exact original AST, proving unrelated builder mechanisms unchanged.
old=ast.parse((C/'build_russian_preview.before.py').read_text());new=ast.parse((R/'tools/build_russian_preview.py').read_text())
class Strip(ast.NodeTransformer):
 def visit_If(self,n):
  if isinstance(n.test,ast.Attribute)and ast.unparse(n.test)=='args.remaining_display_case':return None
  return self.generic_visit(n)
 def visit_Assign(self,n):
  if any(isinstance(t,ast.Name)and t.id in ['remaining_adapter','remaining_plan']for t in n.targets):return None
  return self.generic_visit(n)
 def visit_Expr(self,n):
  if isinstance(n.value,ast.Call)and n.value.args and isinstance(n.value.args[0],ast.Constant)and n.value.args[0].value=='--remaining-display-case':return None
  return self.generic_visit(n)
 def visit_Dict(self,n):
  pairs=[(k,v)for k,v in zip(n.keys,n.values)if not(isinstance(k,ast.Constant)and k.value=='remainingDisplayCase')];n.keys=[x[0]for x in pairs];n.values=[x[1]for x in pairs];return self.generic_visit(n)
assert ast.dump(old,include_attributes=False)==ast.dump(Strip().visit(new),include_attributes=False)
# Actual CLI only rejects invalid prerequisites, before any output/full build.
out=O/'forbidden-builder-output'
r=subprocess.run([str(R/'.venv-assets314/bin/python'),'-B',str(R/'tools/build_russian_preview.py'),'--remaining-display-case','--output',str(out),'--qa-product','ForestRuActual20261029_51'],capture_output=True,text=True)
assert r.returncode==2 and '--remaining-display-case requires --haiku-option-identity'in r.stderr and not out.exists()
tests.append(dict(name='actual-builder-missing-prerequisite',passed=True,reason='--remaining-display-case requires --haiku-option-identity',boundary='actual parser; full build never entered'))
assert h.sha(R/'README.md')==h.read(C/'protected-root-pins.json')['README.md'] and h.sha(R/'CHECKPOINT.json')==h.read(C/'protected-root-pins.json')['CHECKPOINT.json']
summary={'status':'passed','tests':tests,'count':len(tests),'builderNoFlagOriginalAST':True,'managedAdditionalIntendedBoundaryControls':h.read(C/'managed-negative-controls.json'),'betweenWriteFailure':{'existing':['rollback backup','actual patched DLL'],'missing':['reversal','ledger','receipt'],'occupiedRetryRejected':True,'reconciliation':'Preserved failed attempt in regression-final; validated hashes identify partial artifacts. Successful delivery uses a separate fresh output, never overwrites/retries the occupied attempt.'},'rootDocsUnchanged':True,'actualGameRuntime':'not-run'}
h.emit(C/'regression-final.json',summary);print('finite controls passed',len(tests))
