"""Exact authored branch/store/return contracts for the original251 tail.

Evidence navigation locates only explicit memberships. It does not classify an
unlisted selector or assert runtime/native presentation from a stored value.
"""
import json,hashlib,re
from functools import lru_cache
from pathlib import Path
from collections import Counter
from phase146.selector_specs import GROUPS
from phase145.expand_roles import visibility
HERE=Path(__file__).resolve().parent;OUT=HERE.parent;ROOT=OUT.parents[3]
INDEX=ROOT/'outputs/pause-inventory-bio-completion-20261028/managed-index/literals.jsonl'
def load(p):return json.loads(p.read_text())
def rows(p):return [json.loads(x) for x in p.read_text().splitlines()]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def vh(v):return hashlib.sha256(json.dumps(v,ensure_ascii=False,sort_keys=True,separators=(',',':')).encode()).hexdigest()
DEPENDENCIES={'preserve-display-symbol','preserve-display-format','preserve-key-caption-fallback-sentinel','preserve-keyboard-layout-grammar','preserve-keycode-enum-prefix'}
def assignment_map():
 result={}
 for group in GROUPS:
  for n in group['lines']:
   assert n not in result,'final-duplicate-selector';result[n]=group
 return result

@lru_cache(maxsize=None)
def receiver_records(fragments):
 records=rows(HERE/'receiver-bodies.jsonl')+rows(OUT/'phase145/receiver-bodies.jsonl')+rows(OUT/'phase144/producer-bodies.jsonl')
 result=[]
 for fragment in fragments:
  matches=[r for r in records if fragment in r['method']];assert matches,('final-missing-named-receiver',fragment)
  for r in matches:
   assert sha(ROOT/r['evidence'])==r['fileSha256'],'final-receiver-file'
   item=dict(method=r['method'],bodySha256=vh(r['instructions']),evidence=r['evidence'],fileSha256=r['fileSha256'])
   if item not in result:result.append(item)
 return result

def exact_rule(source,body):
 n=source['_line'];group=assignment_map().get(n)
 if group is None:return None
 ix=next(i for i,x in enumerate(body) if x['offset']==source['offset']);after=body[ix+1:];target=group['target']
 if target=='@store':matches=[x for x in after if x['opcode'] in ('stfld','stsfld')]
 elif target=='@local-store':matches=[x for x in after if x['opcode'].startswith('stloc')]
 elif target=='@ret':matches=[x for x in after if x['opcode']=='ret' and (n!=3265 or x['offset']==0xca)]
 elif target=='@layout':matches=[x for x in after if (x['opcode']=='stfld' and x['operand'].endswith('::layout')) or x['operand']=='System.Void viperOSK.OSK_Keyboard::LoadLayout(System.String)']
 elif target=='@assign-key':matches=[x for x in after if x['operand'] and ('OSK_Key::Assign(' in x['operand'] or 'OSK_UI_Key::Assign(' in x['operand'])]
 elif target=='@quest-store':
  suffix='targetConversationName' if n==4369 else 'targetDialogueArcName'
  matches=[x for x in after if x['opcode']=='stsfld' and x['operand']=='System.String TheForestOfLove.QuestConversationHelper::'+suffix]
 elif target=='@byref-store':matches=[x for x in after if x['opcode']=='stind.ref']
 elif target=='@debug-output':matches=[x for x in after if x['opcode']=='stind.ref' or x['operand']=='System.Void UnityEngine.UI.Text::set_text(System.String)']
 elif target=='@new-empty-content':matches=[x for x in after if x['opcode']=='call' and x['operand'] and ('BaseSpawner::NewEmptyContent(' in x['operand'] or 'BaseSpawner::NewEmptyContentSet(' in x['operand'])]
 else:matches=[x for x in after if x['operand']==target and x['opcode'] in ('call','callvirt')]
 assert matches,('final-missing-consumer',n,target)
 consumer=matches[0];window=[x for x in after if x['offset']<=consumer['offset']]
 if group['maxSteps'] is not None:assert len(window)<=group['maxSteps'],'final-consumer-window-bound'
 return dict(role=group['role'],visibility=visibility(group['role']),placeholderContract=re.findall(r'\{[^{}]*\}',source['value']),
  contract='authored:'+target,reason=group['reason'],bodyConsumer=consumer,bodyArgumentWindow=window,
  transforms=[x for x in window if x['opcode'] in ('call','callvirt') and x['operand'] and ('System.String::Concat(' in x['operand'] or 'System.String::Format(' in x['operand'])],
  receiverBindings=receiver_records(tuple(group['receivers'])),evidence=['phase144/producer-bodies.jsonl','phase146/selector_specs.py']+(['phase146/receiver-bodies.jsonl'] if group['receivers'] else [])+(['phase140/consumer-proofs.json'] if 'conditional-unity-log' in group['role'] else []))

def validate_rule(source,prior,rule,body):
 assert prior['role']=='needs-consumer-decision','final-prior-role'
 assert (rule['id'],rule['method'],rule['offset'],rule['sourceLine'])==(prior['id'],source['method'],source['offset'],source['_line']),'final-selector'
 assert rule['sourceValueSha256']==vh(source['value']),'final-source-value'
 assert rule['producerBodySha256']==vh(body),'final-producer-body'
 literal=next(x for x in body if x['offset']==source['offset'])
 assert (literal['opcode'],literal['operand'])==('ldstr',json.dumps(source['value'],ensure_ascii=False)),'final-body-literal'
 expected=exact_rule(source,body);assert expected is not None,'final-unassigned-selector'
 for field,reason in [('role','final-role-membership'),('contract','final-role-membership'),('reason','final-context'),('evidence','final-context'),('bodyConsumer','final-consumer'),('bodyArgumentWindow','final-argument-window'),('transforms','final-transform'),('receiverBindings','final-receiver-binding'),('placeholderContract','final-placeholder'),('visibility','final-visibility')]:assert rule[field]==expected[field],reason

def expanded():
 for n,h in load(HERE/'input-pins.json').items():assert sha(ROOT/n)==h,('final-input-pin',n)
 selected=load(OUT/'phase145/next-compiled-selectors.json')['selectors'];assert len(selected)==251
 baseline=rows(HERE/'baseline/managed-literal-inventory.jsonl');before={r['id']:r for r in baseline};original=rows(INDEX)
 assert [r['id'] for r in selected]==[r['id'] for r in baseline if r['role']=='needs-consumer-decision']
 bodies={r['method']:r for r in rows(OUT/'phase144/producer-bodies.jsonl')};assigned=assignment_map();assert set(assigned)<={r['sourceLine'] for r in selected}
 decisions=[];held=[]
 for r in selected:
  source=dict(original[r['sourceLine']-1],_line=r['sourceLine']);record=bodies[r['method']];body=record['instructions']
  assert sha(ROOT/record['evidence'])==record['fileSha256'] and vh(source['value'])==r['sourceValueSha256']
  proof=exact_rule(source,body)
  if proof:
   rule=dict(id=r['id'],method=r['method'],offset=r['offset'],sourceLine=r['sourceLine'],sourceValueSha256=r['sourceValueSha256'],producerBodySha256=vh(body),producerEvidence=record['evidence'],**proof)
   validate_rule(source,before[r['id']],rule,body);decisions.append(rule)
  else:
   ins=next(i for i,x in enumerate(body) if x['offset']==r['offset']);boundary=body[ins+1]
   held.append(dict(r,phase146Boundary=boundary,remainingPredicate='Original static field is stored but the pinned original game-assembly field-use index contains no reader. External/native/editor consumers or source admission remain unknown. No display absence or protected identity is inferred from its English name. Supply a named actual reader or an explicit source-policy disposition; do not repeat unchanged field scans.'))
 assert len(decisions)==len(assigned) and len(decisions)+len(held)==251
 d=dict(schemaVersion=1,phase='0146-work',assignedOccurrences=251,assignedMethods=98,resolvedOccurrences=len(decisions),roleCounts=dict(Counter(r['role'] for r in decisions)),decisions=decisions,remainingOccurrences=len(held),remainingMethods=len({r['method'] for r in held}),boundary='Exact authored original operands only. Conditional console delivery, input/caption/notification application and external-field source policy remain uncertain. No full source/editorial/font/renderer/runtime gate accepted.')
 n=dict(schemaVersion=1,phase='0146-work',occurrences=len(held),methods=len({r['method'] for r in held}),selectors=held,postcondition='Three exact static-field holds need a named external reader or source-policy disposition. Finite game-assembly reader lookup is exhausted; proceed to concrete font/resource role deliverables without turning absence into an exclusion.',boundary=d['boundary'])
 return d,n

def products():
 d,n=expanded();return {'phase146/compiled-role-decisions.json':d,'phase146/next-compiled-selectors.json':n,'compiled-final-source-context.json':dict(schemaVersion=1,phase='0146-work',assignedOccurrences=251,resolvedIds=[r['id'] for r in d['decisions']],wordingIds=[r['id'] for r in d['decisions'] if r['role'].startswith(('display','potential-display'))],preserveIds=[r['id'] for r in d['decisions'] if r['role'].startswith('preserve')],outputDependencyIds=[r['id'] for r in d['decisions'] if r['role'] in DEPENDENCIES],remainingIds=[r['id'] for r in n['selectors']],producerSnapshot='phase144/producer-bodies.jsonl',receivers='phase146/receiver-bodies.jsonl',boundary=d['boundary'])}
if __name__=='__main__':
 for n,v in products().items():(OUT/n).write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
 d,n=expanded();print(json.dumps(dict(resolved=d['resolvedOccurrences'],remaining=n['occurrences'],roles=d['roleCounts'])))
