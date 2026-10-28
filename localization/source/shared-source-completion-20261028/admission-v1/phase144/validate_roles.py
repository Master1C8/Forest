"""Exact current delta validation plus inherited whole-product preservation."""
import json,copy,hashlib
from collections import Counter
from pathlib import Path
from phase144.expand_roles import HERE,OUT,ROOT,INDEX,load,rows,sha,vh,expanded,validate_rule,first_call,products

def literal_span(raw,source):
 start=raw.index(('METHOD '+source['method']+' |').encode());end=raw.find(b'\nMETHOD ',start+1)
 block=raw[start:end if end>=0 else len(raw)]
 expected=('IL_'+format(source['offset'],'04x')+': ldstr "'+source['value']+'"\n').encode()
 assert expected in block,'remaining-raw-literal-span'

def validate(current):
 for n,h in load(HERE/'baseline-pins.json').items():assert sha(HERE/'baseline'/n)==h,('remaining-preserved-baseline',n)
 decisions,remaining=expanded();rules={r['id']:r for r in decisions['decisions']};baseline=rows(HERE/'baseline/managed-literal-inventory.jsonl');before={r['id']:r for r in baseline};sources=rows(INDEX);by_selector={(r['method'],r['offset']):r for r in sources};bodies={r['method']:r for r in rows(HERE/'producer-bodies.jsonl')}
 assert len(rules)==682 and remaining['occurrences']==569 and remaining['methods']==284
 assert load(HERE/'compiled-role-decisions.json')==decisions,'remaining-decision-expansion'
 assert load(HERE/'next-compiled-selectors.json')==remaining,'remaining-selector-expansion'
 assert [r['id'] for r in current]==[r['id'] for r in baseline],'remaining-whole-identity-order'
 reconstructed=[]
 for old,new in zip(baseline,current):
  expected=copy.deepcopy(old)
  if old['id'] in rules:
   rule=rules[old['id']];expected.update(role=rule['role'],decision='phase144:'+rule['contract'])
   if rule['role'].startswith(('display','potential-display')):expected['source']=sources[old['sourceLine']-1]['value']
  assert new==expected,('remaining-exact-delta',old['id'])
  reconstructed.append(copy.deepcopy(old) if old['id'] in rules else new)
 encoded=lambda a:''.join(json.dumps(r,ensure_ascii=False,separators=(',',':'))+'\n' for r in a).encode()
 assert encoded(reconstructed)==(HERE/'baseline/managed-literal-inventory.jsonl').read_bytes(),'remaining-prior-whole-product'
 assert sum(r['role']=='needs-consumer-decision' for r in current)==569
 for method,record in bodies.items():
  assert sha(ROOT/record['evidence'])==record['fileSha256'],'remaining-producer-file'
  raw=(ROOT/record['evidence']).read_bytes()
  method_sources=[r for r in sources if r['method']==method]
  assert {r['offset'] for r in method_sources}=={i['offset'] for i in record['instructions'] if i['opcode']=='ldstr'},'remaining-complete-producer-literals'
  for source in method_sources:
   literal_span(raw,source)
   ins=next(i for i in record['instructions'] if i['offset']==source['offset'])
   assert ins['operand']==json.dumps(source['value'],ensure_ascii=False),'remaining-canonical-literal'
 for record in rows(HERE/'receiver-bodies.jsonl'):
  assert sha(ROOT/record['evidence'])==record['fileSha256'],'remaining-receiver-file'
 for rule in rules.values():validate_rule(by_selector[rule['method'],rule['offset']],before[rule['id']],rule,bodies[rule['method']]['instructions'])
 wording=rows(OUT/'compiled-wording-source.jsonl');preserved=rows(OUT/'compiled-preserve-exactly.jsonl');wi={r['id'] for r in wording};pi={r['id'] for r in preserved}
 assert len(wording)==len(wi)==206 and len(preserved)==len(pi)==7813
 assert wi|pi=={r['id'] for r in current if r['role']!='needs-consumer-decision'},'remaining-wording-preserve-union'
 assert wi&pi=={r['id'] for r in current if r['role']=='comparison-on-display'},'remaining-prior-comparison-overlap'
 for r in wording:assert r['source']==sources[r['sourceLine']-1]['value'],'remaining-wording-source'
 context=load(OUT/'compiled-remaining-source-context.json');expected_context=products()['compiled-remaining-source-context.json']
 assert context==expected_context,'remaining-context-expansion'
 pending={r['id'] for r in remaining['selectors']};assert not set(rules)&pending and set(rules)|pending=={r['id'] for r in baseline if r['role']=='needs-consumer-decision'}
 for row in remaining['selectors']:
  assert first_call(bodies[row['method']]['instructions'],row['offset'])[0] is not None or row['firstBoundary'] is not None or row['offset']==bodies[row['method']]['instructions'][-1]['offset']
 # All unrelated earlier guards are satisfied by the matching positive control.
 rule=next(iter(rules.values()));source=by_selector[rule['method'],rule['offset']];prior=before[rule['id']];body=bodies[rule['method']]['instructions'];validate_rule(source,prior,rule,body)
 reasons={'value':'remaining-source-value','selector':'remaining-selector','body':'remaining-producer-body','role':'remaining-role-membership','context':'remaining-context','consumer':'remaining-consumer','argument':'remaining-argument-window','prior':'remaining-prior-role','visibility':'remaining-visibility'}
 for kind,reason in reasons.items():
  a,b,c,d=map(copy.deepcopy,[source,prior,rule,body])
  if kind=='value':a['value']+='__changed__'
  if kind=='selector':c['sourceLine']+=1
  if kind=='body':d[-1]['opcode']='throw'
  if kind=='role':c['role']='display-source'
  if kind=='context':c['reason']+='__changed__'
  if kind=='consumer':c['bodyConsumer']['offset']+=1
  if kind=='argument':c['bodyArgumentWindow']=[]
  if kind=='prior':b['role']='preserve-diagnostic'
  if kind=='visibility':c['visibility']='proved-visible-in-game'
  try:validate_rule(a,b,c,d)
  except AssertionError as e:assert str(e)==reason,(kind,e)
  else:raise AssertionError('remaining-invalid-contract-accepted:'+kind)
 for opcode in ('br.s','stloc.0'):
  altered=copy.deepcopy(body);index=next(i for i,v in enumerate(altered) if v['offset']==source['offset'])+1;altered[index]['opcode']=opcode
  assert first_call(body,source['offset'])[0]==rule['bodyConsumer']
  assert first_call(altered,source['offset'])[0] is None,'remaining-typed-barrier'
 for field in ('wordingIds','preserveIds','remainingIds'):
  altered=copy.deepcopy(context);assert altered[field];altered[field]=altered[field][1:]
  try:assert altered==expected_context,'remaining-context-expansion'
  except AssertionError as e:assert str(e)=='remaining-context-expansion'
  else:raise AssertionError('remaining-lost-membership-accepted:'+field)
 # Regression uses actual CR/LF/quote/backslash literals, not synthetic OCR or
 # a normalizer which could silently invent a value from the index.
 normalized=load(HERE/'literal-transport-normalization.json')
 for row in normalized:
  source=by_selector[row['method'],row['offset']];raw=(ROOT/row['rawEvidence']).read_bytes();literal_span(raw,source)
  altered=copy.deepcopy(source);altered['value']+='__changed__'
  try:literal_span(raw,altered)
  except AssertionError as e:assert str(e)=='remaining-raw-literal-span'
  else:raise AssertionError('remaining-raw-source-mutation-accepted')
 assert normalized and any('\r' in by_selector[r['method'],r['offset']]['value'] for r in normalized)
 assert any('\\' in by_selector[r['method'],r['offset']]['value'] for r in normalized)
 return dict(assignedOccurrences=1251,assignedMethods=443,resolvedRoles=682,wordingOperands=4,potentialWordingOperands=17,protectedOperands=661,remainingOccurrences=569,remainingMethods=284,priorWholeProductReconstructedExactly=True,producerSnapshots=443,receiverSnapshots=47,transportNormalizationRegressions=len(normalized),knownWordingOperands=206,protectedOperandsTotal=7813,sharedComparisonOperands=12,resolvedTotal=8007,completeCompiledPacket=False,negativeControls=list(reasons)+['branch-barrier','store-barrier','wording-membership','preserve-membership','remaining-membership','raw-LF-CR-quote-backslash-source-span'],deterministicIsNotSemanticReview=True)
