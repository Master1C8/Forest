"""Deterministic static packet checks only. No semantic judgment or game execution."""
import json,hashlib,re,copy,collections
from pathlib import Path
R=Path('/Users/antonkrutov/Desktop/Forest');O=R/'localization/supplemental-ui/20261029-input-case72';C=R/'outputs/ru-input72-case-wording-20261029/check'
def jl(p):return [json.loads(l) for l in p.read_text().splitlines()]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def ts(t):return hashlib.sha256(t.encode()).hexdigest()
def vh(x):return ts(json.dumps(x,ensure_ascii=False,sort_keys=True,separators=(',',':')))
def req(ok,reason):
 if not ok:raise ValueError(reason)
def write(n,x):(O/n).write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n')
a=jl(C/'assigned.jsonl');ctx=jl(C/'context409.jsonl');orig=jl(O/'ru.initial.jsonl');prot=jl(O/'protected-controls.jsonl');schemas=jl(O/'native-component-schemas.jsonl');smap={s['bindingId']:s for s in schemas};sc=jl(O/'source-context.jsonl')
def tokens(t):return re.findall(r'\[[^\]\r\n]+\]',t)
def validate(target,protected):
 req(len(target)==72 and [x['id'] for x in target]==[x['bindingId'] for x in a],'assigned-id-order-coverage')
 req(len(set(x['id'] for x in target))==72,'duplicate-target-id')
 for x,z in zip(target,a):
  req(x['source']==z['source'] and x['sourceValueSha256']==z['sourceValueSha256'] and vh(x['source'])==z['sourceValueSha256'],'source-identity')
  req(x['typedLedger']==z['typedLedger'],'typed-ledger-selector')
  req(isinstance(x['target'],str) and bool(x['target']),'nonempty-target')
  req(tokens(x['source'])==tokens(x['target']),'literal-control-sequence')
  req(re.findall(r'\n+',x['source'])==re.findall(r'\n+',x['target']),'newline-control-sequence')
  req(x['targetUtf8Sha256']==ts(x['target']),'target-hash')
  req(x['displayOnly'] is True and x['targetApplied'] is False,'display-only-unapplied')
  req(x['currentRole'] in ['display-source','display-candidate'],'target-role')
 expected=[x for x in ctx if x['bindingId'] not in {z['bindingId'] for z in a}]
 req(len(protected)==337 and [x['bindingId'] for x in protected]==[x['bindingId'] for x in expected],'context-id-order-coverage')
 for x,z in zip(protected,expected):
  req(x['source']==z['source'] and vh(x['source'])==z['sourceValueSha256'] and x['sourceValueSha256']==z['sourceValueSha256'],'protected-exact-value')
  req(x['currentRole']==z['currentRole'] and x['target'] is None,'protected-no-target')
  req(x['typedLedger']==z['typedLedger'],'protected-selector')
  if z['currentRole']=='potential-display-input-seed':req(bool(x['missingPredicate']) and x['action']=='preserve-exactly-pending-consumer-binding','potential-seed-hold')
 return True
# In-memory proposal: change only the exact admitted display leaf; then remove
# those leaves on both sides and compare the entire residual objects exactly.
def pointer_get(t,parts):
 for k in parts:t=t[int(k)] if isinstance(t,list) else t[k]
 return t
def pointer_set(t,parts,v):
 par=pointer_get(t,parts[:-1]);k=parts[-1];par[int(k) if isinstance(par,list) else k]=v
def trial(target):
 baseline={};proposed={};allowed=collections.defaultdict(list)
 for x in target:
  if x['id'] not in smap:continue
  s=smap[x['id']];key=s['object'];parts=sc[x['ordinal']-1]['typedSource']['pointer'].strip('/').split('/')
  if key not in baseline:baseline[key]=json.loads((R/s['tree']).read_text());proposed[key]=copy.deepcopy(baseline[key])
  req(pointer_get(baseline[key],parts)==x['source'],'proposal-source-leaf')
  pointer_set(proposed[key],parts,x['target']);allowed[key].append(parts)
 return baseline,proposed,dict(allowed)
def guard(b,p,allowed):
 req(set(b)==set(p),'proposal-object-identity')
 for key in b:
  before=copy.deepcopy(b[key]);after=copy.deepcopy(p[key])
  for parts in allowed[key]:pointer_set(before,parts,None);pointer_set(after,parts,None)
  req(before==after,'proposal-residual-controls-exact')
 return True
final=jl(O/'ru.prepared.jsonl');validate(final,prot);b,p,allowed=trial(final);guard(b,p,allowed)
# Each mutant starts from the full valid positive control. Update target hashes
# after mutations so an earlier hash mismatch cannot mask the intended boundary.
tests=[]
def neg(name,reason,fn):
 try:fn()
 except ValueError as e: req(str(e)==reason,'negative-wrong-boundary:'+name+':'+str(e));tests.append({'name':name,'expectedReason':reason,'actualReason':str(e),'passed':True});return
 raise ValueError('negative-accepted:'+name)
def mut_target(i,fn):
 t=copy.deepcopy(final);fn(t[i]);t[i]['targetUtf8Sha256']=ts(t[i]['target']);return validate(t,prot)
def mutate_prot(i,k,v):
 q=copy.deepcopy(prot);q[i][k]=v;return validate(final,q)
neg('control-X-to-Cyrillic-lookalike','literal-control-sequence',lambda:mut_target(31,lambda x:x.update(target=x['target'].replace('[X]','[Х]'))))
neg('Spacebar-renamed','literal-control-sequence',lambda:mut_target(59,lambda x:x.update(target=x['target'].replace('[Spacebar]','[Пробел]'))))
neg('remove-plant-triple-LF','newline-control-sequence',lambda:mut_target(61,lambda x:x.update(target=x['target'].replace('\n\n\n','\n'))))
neg('source-rebound','source-identity',lambda:mut_target(0,lambda x:x.update(source='DONE')))
neg('missing-last-target','assigned-id-order-coverage',lambda:validate(final[:-1],prot))
neg('duplicate-last-target','assigned-id-order-coverage',lambda:validate(final[:-1]+[final[0]],prot))
pi=next(i for i,x in enumerate(prot) if x['currentRole']=='potential-display-input-seed')
neg('translate-input-seed-without-alias','protected-no-target',lambda:mutate_prot(pi,'target','Поле ввода'))
li=next(i for i,x in enumerate(prot) if x['currentRole']=='preserve-control')
neg('localize-layout-grammar','protected-exact-value',lambda:mutate_prot(li,'source',prot[li]['source'].replace('Skip','Пропуск')))
si=next(i for i,x in enumerate(prot) if x['source']=='ABC\n')
neg('trim-symbol-final-LF','protected-exact-value',lambda:mutate_prot(si,'source','ABC'))
def native_mut(key,fn):
 q=copy.deepcopy(p);fn(q[key]);return guard(b,q,allowed)
keyboard=next(k for k in p if 'specialKeys' in p[k]);shift=next(s['keyComponent'] for s in schemas if s['bindingId']=='level1:7299/m_text')
neg('change-special-keycode','proposal-residual-controls-exact',lambda:native_mut(keyboard,lambda t:t['specialKeys'][4].update(keycode=32)))
neg('change-special-action','proposal-residual-controls-exact',lambda:native_mut(keyboard,lambda t:t['specialKeys'][4]['specialAction']['m_PersistentCalls']['m_Calls'].append({'m_MethodName':'Submit'})))
# These original bound key component trees have no allowed changes at all.
k=shift['object'];kb=json.loads((R/shift['tree']).read_text());b2={k:kb};p2=copy.deepcopy(b2);p2[k]['isPressed']=1
neg('change-bound-button-state','proposal-residual-controls-exact',lambda:guard(b2,p2,{k:[]}))
pins=json.loads((O/'input-pins.json').read_text());changed=[]
for name,expected in pins.items():
 actual=sha(Path(name))
 if actual!=expected:changed.append({'path':name,'expected':expected,'actual':actual})
# Root guide/checkpoint are owner-maintained live summaries, never inputs to a
# wording selector; any concurrent change is reported separately, not overwritten.
material=[x for x in changed if x['path'] not in [str(R/'README.md'),str(R/'CHECKPOINT.json')]];req(not material,'material-input-pins-changed')
report={'status':'passed','scope':'full finite static packet; no runtime execution or semantic auto-judgment','sourceUnits':72,'targetUnits':72,'prepared':70,'reused':2,'protectedContextMembers':337,'protectedRoles':dict(collections.Counter(x['currentRole'] for x in prot)),'sourceContextRows':len(sc),'nativeComponentSchemaRows':len(schemas),'plannedNativeObjects':len(b),'plannedNativeDisplayLeaves':sum(map(len,allowed.values())),'backgroundDatabaseDisplayLeaves':1,'positiveControl':'actual unchanged final72 packet and all337 context rows pass; in-memory exact selected native leaf proposal passes full residual-tree equality','negativeTests':tests,'negativeTestCount':len(tests),'inputPinsChecked':len(pins),'concurrentRootSummaryChanges':changed,'runtime':'not-run','sourceGateAccepted':False,'semanticJudgmentGenerated':False,'targetApplied':False}
write('deterministic-preflight.json',report);write('native-display-proposal.json',{'boundary':'In-memory proposal only; original native asset trees never written','allowedDisplayPointers':allowed,'nativeObjects':len(b),'nativeLeaves':sum(map(len,allowed.values())),'residualTreeEquality':True,'runtime':'not-run'})
print(json.dumps({k:v for k,v in report.items() if k!='negativeTests'},ensure_ascii=False))
