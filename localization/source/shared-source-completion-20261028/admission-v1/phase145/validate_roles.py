"""Validate exact318 current operand decisions and reconstruct whole prior tree.

Historical phase144 validation explicitly reads pinned phase145/baseline outputs;
current real output memberships are independently checked here, without mocks.
"""
import copy,json
from collections import Counter
from phase145.expand_roles import HERE,OUT,ROOT,INDEX,load,rows,sha,vh,expanded,products,validate_rule,navigate
import phase144.validate_roles as previous_validator
from phase144.validate_roles import literal_span

def jl(rr):return ''.join(json.dumps(r,ensure_ascii=False,separators=(',',':'))+'\n' for r in rr).encode()
def historical_validation():
 old=previous_validator.OUT
 try:
  previous_validator.OUT=HERE/'baseline'
  return previous_validator.validate(rows(HERE/'baseline/managed-literal-inventory.jsonl'))
 finally:previous_validator.OUT=old

def check_memberships(context,expected):
 for key in ('resolvedIds','wordingIds','preserveIds','outputDependencyIds','remainingIds'):
  assert context[key]==expected[key],'tail-membership:'+key
 assert context==expected,'tail-context-product'

def validate(current):
 for n,h in load(HERE/'baseline-pins.json').items():assert sha(HERE/'baseline'/n)==h,('tail-baseline-pin',n)
 d,n=expanded();assert d['resolvedOccurrences']==318 and n['occurrences']==251 and n['methods']==98
 baseline=rows(HERE/'baseline/managed-literal-inventory.jsonl');before={r['id']:r for r in baseline};rules={r['id']:r for r in d['decisions']}
 source=rows(INDEX);by_source={(r['method'],r['offset']):dict(r,_line=i+1) for i,r in enumerate(source)}
 bodies={r['method']:r for r in rows(OUT/'phase144/producer-bodies.jsonl')}
 assert [r['id'] for r in current]==[r['id'] for r in baseline],'tail-ordered-identities'
 reconstructed=[]
 for old,new in zip(baseline,current):
  expected=copy.deepcopy(old)
  if old['id'] in rules:
   rule=rules[old['id']];expected.update(role=rule['role'],decision='phase145:'+rule['contract'])
   if rule['role'].startswith(('display','potential-display')):expected['source']=source[old['sourceLine']-1]['value']
  assert expected==new,('tail-exact-delta',old['id'])
  reconstructed.append(copy.deepcopy(old) if old['id'] in rules else new)
 assert jl(reconstructed)==(HERE/'baseline/managed-literal-inventory.jsonl').read_bytes(),'tail-whole-prior-product'
 assert sum(r['role']=='needs-consumer-decision' for r in current)==251
 assert sum(r['role']=='needs-consumer-decision' for r in baseline)==569
 for rule in d['decisions']:
  src=by_source[rule['method'],rule['offset']];proof=bodies[rule['method']];body=proof['instructions']
  assert sha(ROOT/proof['evidence'])==proof['fileSha256'],'tail-actual-producer-file'
  literal_span((ROOT/proof['evidence']).read_bytes(),src)
  validate_rule(src,before[rule['id']],rule,body)
 for rec in rows(HERE/'receiver-bodies.jsonl'):assert sha(ROOT/rec['evidence'])==rec['fileSha256'],'tail-actual-receiver-file'
 for name,value in products().items():assert load(OUT/name)==value,('tail-product-reproduction',name)
 context=load(OUT/'compiled-tail-source-context.json');expected_context=products()['compiled-tail-source-context.json'];check_memberships(context,expected_context)
 wording=rows(OUT/'compiled-wording-source.jsonl');preserve=rows(OUT/'compiled-preserve-exactly.jsonl');wi={r['id'] for r in wording};pi={r['id'] for r in preserve}
 assert len(wording)==len(wi)==315 and len(preserve)==len(pi)==8022
 assert wi|pi=={r['id'] for r in current if r['role']!='needs-consumer-decision'},'tail-actual-wording-preserve-union'
 assert wi&pi=={r['id'] for r in current if r['role']=='comparison-on-display'},'tail-retained-comparison-overlap'
 for r in wording:assert r['source']==source[r['sourceLine']-1]['value'],'tail-actual-wording-value'
 for r in preserve:assert r['sourceValueSha256']==vh(source[r['sourceLine']-1]['value']),'tail-actual-protected-value'
 held={r['id'] for r in n['selectors']};assert held=={r['id'] for r in current if r['role']=='needs-consumer-decision'}
 assert held|set(rules)=={r['id'] for r in baseline if r['role']=='needs-consumer-decision'} and not held&set(rules)
 rule=d['decisions'][0];src=by_source[rule['method'],rule['offset']];prior=before[rule['id']];body=bodies[rule['method']]['instructions'];validate_rule(src,prior,rule,body)
 reasons={'value':'tail-source-value','selector':'tail-selector','body':'tail-producer-body','role':'tail-role-membership','context':'tail-context','consumer':'tail-consumer','argument':'tail-argument-window','transform':'tail-transform','prior':'tail-prior-role','visibility':'tail-visibility','placeholder':'tail-placeholder'}
 for kind,reason in reasons.items():
  a,b,c,e=map(copy.deepcopy,[src,prior,rule,body])
  if kind=='value':a['value']+='__changed__'
  if kind=='selector':c['sourceLine']+=1
  if kind=='body':e[-1]['opcode']='throw'
  if kind=='role':c['role']='display-source'
  if kind=='context':c['reason']+='__changed__'
  if kind=='consumer':c['bodyConsumer']['offset']+=1
  if kind=='argument':c['bodyArgumentWindow']=[]
  if kind=='transform':c['transforms']=[]
  if kind=='prior':b['role']='preserve-object-identity'
  if kind=='visibility':c['visibility']='proved-runtime-visible'
  if kind=='placeholder':c['placeholderContract']=['{unproved}']
  try:validate_rule(a,b,c,e)
  except AssertionError as err:assert str(err)==reason,(kind,err)
  else:raise AssertionError('tail-invalid-contract-accepted:'+kind)
 # Changed operation follows this actual literal, so these controls exercise
 # the real navigator barrier with every unrelated positive condition held.
 assert navigate(src,body)[0] is not None
 for op in ('br.s','stloc.0'):
  altered=copy.deepcopy(body);ix=next(i for i,r in enumerate(altered) if r['offset']==src['offset'])+1;altered[ix]['opcode']=op
  assert navigate(src,altered)[0] is None,'tail-navigator-branch-or-store-barrier'
 # Actual key position is distinct from the separate object value parameter.
 keyrule=next(r for r in d['decisions'] if r['role']=='preserve-blackboard-variable-key');keysrc=by_source[keyrule['method'],keyrule['offset']];keybody=bodies[keyrule['method']]['instructions'];validate_rule(keysrc,before[keyrule['id']],keyrule,keybody)
 altered=copy.deepcopy(keyrule);altered['argumentPositions']=[1]
 try:validate_rule(keysrc,before[keyrule['id']],altered,keybody)
 except AssertionError as err:assert str(err)=='tail-argument-position'
 else:raise AssertionError('tail-value-misclassified-as-key')
 for field in ('resolvedIds','wordingIds','preserveIds','outputDependencyIds','remainingIds'):
  altered=copy.deepcopy(context);assert altered[field];altered[field]=altered[field][1:]
  try:check_memberships(altered,expected_context)
  except AssertionError as err:assert str(err)=='tail-membership:'+field
  else:raise AssertionError('tail-lost-membership-accepted:'+field)
 historical=historical_validation()
 return dict(assignedOccurrences=569,assignedMethods=284,resolvedRoles=318,roleCounts=d['roleCounts'],remainingOccurrences=251,remainingMethods=98,knownWordingOperands=315,protectedOperandsTotal=8022,sharedComparisonOperands=12,resolvedTotal=8325,wholePrior8007RolesAndAllRecordsRetained=True,priorWholeProductReconstructedExactly=True,receiverSnapshots=32,completeCompiledPacket=False,historicalPhase144=historical,historicalProductBoundary='Pinned phase145/baseline outputs are reconstructed exactly before prior validator; current outputs validated separately.',negativeControls=list(reasons)+['key-versus-value-argument-position','branch-barrier','store-barrier','resolved-membership','wording-membership','preserve-membership','output-dependency-membership','remaining-membership'],deterministicIsNotIndependentSemanticReview=True,multiOutputTransaction=False)
