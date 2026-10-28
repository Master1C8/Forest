"""Current exact248 delta, all prior8325 records and actual output memberships.

Historical validators run against pinned prior outputs only after exact whole
prior inventory reconstruction. Deterministic controls are not semantic review.
"""
import copy,json
from phase146.expand_roles import HERE,OUT,ROOT,INDEX,load,rows,sha,vh,expanded,products,validate_rule,DEPENDENCIES
from phase144.validate_roles import literal_span
import phase145.validate_roles as previous_validator

def jl(rs):return ''.join(json.dumps(r,ensure_ascii=False,separators=(',',':'))+'\n' for r in rs).encode()
def historical_validation():
 old=previous_validator.OUT
 try:
  previous_validator.OUT=HERE/'baseline'
  return previous_validator.validate(rows(HERE/'baseline/managed-literal-inventory.jsonl'))
 finally:previous_validator.OUT=old

def check_memberships(actual,expected):
 for key in ('resolvedIds','wordingIds','preserveIds','outputDependencyIds','remainingIds'):assert actual[key]==expected[key],'final-membership:'+key
 assert actual==expected,'final-context-product'

def validate_field_holds(report,source,field_uses):
 assert report['sourceLines']==[331,332,4948],'final-field-hold-membership'
 assert report['fieldIndexSha256']==sha(ROOT/report['fieldIndex']),'final-field-index'
 for rec,n in zip(report['holds'],report['sourceLines']):
  src=source[n-1];assert rec['sourceLine']==n and rec['method']==src['method'] and rec['sourceValueSha256']==vh(src['value']),'final-field-hold-source'
  actual=[r for r in field_uses if r['field']==rec['field']]
  assert actual==rec['gameAssemblyUses'] and len(actual)==1 and actual[0]['opcode']=='stsfld','final-field-use-membership'
  assert rec['externalConsumers']=='unknown' and rec['sourceAdmission']=='held' and rec['displayAbsenceProved'] is False,'final-field-unsupported-admission'

def validate(current):
 for n,h in load(HERE/'baseline-pins.json').items():assert sha(HERE/'baseline'/n)==h,('final-baseline-pin',n)
 d,n=expanded();assert d['resolvedOccurrences']==248 and n['occurrences']==3 and n['methods']==3
 baseline=rows(HERE/'baseline/managed-literal-inventory.jsonl');before={r['id']:r for r in baseline};rules={r['id']:r for r in d['decisions']};sources=rows(INDEX)
 by_source={(r['method'],r['offset']):dict(r,_line=i+1) for i,r in enumerate(sources)};bodies={r['method']:r for r in rows(OUT/'phase144/producer-bodies.jsonl')}
 assert [r['id'] for r in current]==[r['id'] for r in baseline],'final-ordered-identities'
 reconstructed=[]
 for old,new in zip(baseline,current):
  expected=copy.deepcopy(old)
  if old['id'] in rules:
   rule=rules[old['id']];expected.update(role=rule['role'],decision='phase146:'+rule['contract'])
   if rule['role'].startswith(('display','potential-display')):expected['source']=sources[old['sourceLine']-1]['value']
  assert expected==new,('final-exact-delta',old['id'])
  reconstructed.append(copy.deepcopy(old) if old['id'] in rules else new)
 assert jl(reconstructed)==(HERE/'baseline/managed-literal-inventory.jsonl').read_bytes(),'final-whole-prior-product'
 assert sum(r['role']=='needs-consumer-decision' for r in current)==3 and sum(r['role']=='needs-consumer-decision' for r in baseline)==251
 for rule in d['decisions']:
  source=by_source[rule['method'],rule['offset']];record=bodies[rule['method']];body=record['instructions']
  assert sha(ROOT/record['evidence'])==record['fileSha256'],'final-actual-producer-file'
  literal_span((ROOT/record['evidence']).read_bytes(),source);validate_rule(source,before[rule['id']],rule,body)
 # Every actual new receiver literal, including embedded LF/CR/quotes/backslash,
 # is checked against its original index and full raw byte span.
 receiver_literals=0
 for record in rows(HERE/'receiver-bodies.jsonl'):
  assert sha(ROOT/record['evidence'])==record['fileSha256'],'final-actual-receiver-file'
  original=[r for r in sources if r['method']==record['method']]
  actual={x['offset']:x for x in record['instructions'] if x['opcode']=='ldstr'}
  assert set(actual)=={r['offset'] for r in original},'final-complete-receiver-literals'
  for source in original:
   literal_span((ROOT/record['evidence']).read_bytes(),source)
   assert actual[source['offset']]['operand']==json.dumps(source['value'],ensure_ascii=False),'final-canonical-receiver-literal';receiver_literals+=1
 for name,value in products().items():assert load(OUT/name)==value,('final-product-reproduction',name)
 context=load(OUT/'compiled-final-source-context.json');expected_context=products()['compiled-final-source-context.json'];check_memberships(context,expected_context)
 wording=rows(OUT/'compiled-wording-source.jsonl');preserve=rows(OUT/'compiled-preserve-exactly.jsonl');wi={r['id'] for r in wording};pi={r['id'] for r in preserve}
 assert len(wording)==len(wi)==348 and len(preserve)==len(pi)==8237
 assert wi|pi=={r['id'] for r in current if r['role']!='needs-consumer-decision'},'final-actual-wording-preserve-union'
 assert wi&pi=={r['id'] for r in current if r['role']=='comparison-on-display'},'final-retained-comparison-overlap'
 for r in wording:assert r['source']==sources[r['sourceLine']-1]['value'],'final-actual-wording-value'
 for r in preserve:assert r['sourceValueSha256']==vh(sources[r['sourceLine']-1]['value']),'final-actual-protected-value'
 assert {r['id'] for r in n['selectors']}=={r['id'] for r in current if r['role']=='needs-consumer-decision'}
 field_report=load(HERE/'static-field-holds.json');field_uses=rows(ROOT/field_report['fieldIndex']);validate_field_holds(field_report,sources,field_uses)
 rule=d['decisions'][0];src=by_source[rule['method'],rule['offset']];prior=before[rule['id']];body=bodies[rule['method']]['instructions'];validate_rule(src,prior,rule,body)
 reasons={'value':'final-source-value','selector':'final-selector','body':'final-producer-body','role':'final-role-membership','context':'final-context','consumer':'final-consumer','argument':'final-argument-window','transform':'final-transform','prior':'final-prior-role','visibility':'final-visibility','placeholder':'final-placeholder','receiver':'final-receiver-binding'}
 for kind,reason in reasons.items():
  a,b,c,e=map(copy.deepcopy,[src,prior,rule,body])
  if kind=='value':a['value']+='__changed__'
  if kind=='selector':c['sourceLine']+=1
  if kind=='body':e[-1]['opcode']='throw'
  if kind=='role':c['role']='display-source'
  if kind=='context':c['reason']+='__changed__'
  if kind=='consumer':c['bodyConsumer']['offset']+=1
  if kind=='argument':c['bodyArgumentWindow']=[]
  if kind=='transform':c['transforms']=[dict(offset=-1,opcode='call',operand='unproved')]
  if kind=='prior':b['role']='preserve-object-identity'
  if kind=='visibility':c['visibility']='proved-runtime-visible'
  if kind=='placeholder':c['placeholderContract']=['{unproved}']
  if kind=='receiver':c['receiverBindings']=[]
  try:validate_rule(a,b,c,e)
  except AssertionError as err:assert str(err)==reason,(kind,err)
  else:raise AssertionError('final-invalid-contract-accepted:'+kind)
 for key in ('resolvedIds','wordingIds','preserveIds','outputDependencyIds','remainingIds'):
  altered=copy.deepcopy(context);assert altered[key];altered[key]=altered[key][1:]
  try:check_memberships(altered,expected_context)
  except AssertionError as err:assert str(err)=='final-membership:'+key
  else:raise AssertionError('final-lost-membership-accepted:'+key)
 for mutation in ('source','membership','admission'):
  altered=copy.deepcopy(field_report)
  if mutation=='source':altered['holds'][0]['sourceValueSha256']='0'*64;reason='final-field-hold-source'
  if mutation=='membership':altered['holds'][0]['gameAssemblyUses']=[];reason='final-field-use-membership'
  if mutation=='admission':altered['holds'][0]['displayAbsenceProved']=True;reason='final-field-unsupported-admission'
  try:validate_field_holds(altered,sources,field_uses)
  except AssertionError as err:assert str(err)==reason
  else:raise AssertionError('final-invalid-field-hold-accepted:'+mutation)
 normalized=load(HERE/'literal-transport-normalization.json');assert any('GalleryHintTutorial::Start' in r['method'] and '\\n' in r['canonicalOperand'] for r in normalized),'final-real-multiline-regression'
 historical=historical_validation()
 return dict(assignedOccurrences=251,assignedMethods=98,resolvedRoles=248,resolvedMethods=len({r['method'] for r in d['decisions']}),roleCounts=d['roleCounts'],remainingOccurrences=3,remainingMethods=3,knownWordingOperands=348,protectedOperandsTotal=8237,sharedComparisonOperands=12,resolvedTotal=8573,wholePrior8325RolesAndAllRecordsRetained=True,priorWholeProductReconstructedExactly=True,receiverSnapshots=48,receiverLiterals=receiver_literals,realReceiverLiteralTransportRepairs=len(normalized),completeCompiledPacket=False,historicalPhase145=historical,historicalProductBoundary='Pinned phase146/baseline prior outputs; actual current memberships checked separately.',negativeControls=list(reasons)+['resolved-membership','wording-membership','preserve-membership','output-dependency-membership','remaining-membership','static-field-source','static-field-use-membership','unsupported-static-field-admission'],deterministicIsNotIndependentSemanticReview=True,multiOutputTransaction=False)
