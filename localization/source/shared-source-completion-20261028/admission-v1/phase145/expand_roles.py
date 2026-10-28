"""Finite remaining569 operand contracts, preserving all prior products.

The bounded argument navigator emits candidate evidence only. Explicit authored
selector assignments admit roles; branches/stores and unknown consumers hold.
"""
import json,hashlib,re
from pathlib import Path
from collections import Counter
from phase144.expand_roles import contracts as previous_contracts,NONSTRING
HERE=Path(__file__).resolve().parent;OUT=HERE.parent;ROOT=OUT.parents[3]
INDEX=ROOT/'outputs/pause-inventory-bio-completion-20261028/managed-index/literals.jsonl'
def load(p):return json.loads(p.read_text())
def rows(p):return [json.loads(x) for x in p.read_text().splitlines()]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def vh(v):return hashlib.sha256(json.dumps(v,ensure_ascii=False,sort_keys=True,separators=(',',':')).encode()).hexdigest()
def splitargs(text):
 out=[];depth=0;start=0
 for i,c in enumerate(text):
  if c in '<[':depth+=1
  if c in '>]':depth-=1
  if c==',' and depth==0:out.append(text[start:i]);start=i+1
 if text:out.append(text[start:])
 return out
# These signatures have a receiver even where C# emits call rather than callvirt.
INSTANCE={'System.String UnityEngine.Object::get_name()','System.String TMPro.TMP_Text::get_text()',
'System.String System.Exception::get_Message()','System.String System.Object::ToString()',
'System.String System.Int32::ToString()','System.String System.Single::ToString()',
'System.String System.Char::ToString()','System.String System.String::Replace(System.String,System.String)',
'System.Boolean System.String::Equals(System.String,System.StringComparison)','System.Boolean System.String::Equals(System.String)'}
TRANSFORMS={'System.String System.String::Concat(System.String,System.String)',
'System.String System.String::Concat(System.String,System.String,System.String)',
'System.String System.String::Concat(System.String,System.String,System.String,System.String)',
'System.String System.String::Format(System.String,System.Object)',
'System.String System.String::Format(System.String,System.Object,System.Object)',
'System.String System.String::Format(System.String,System.Object,System.Object,System.Object)'}
EXTRA={}
def extra(target,role,reason):
 EXTRA[target]=dict(role=role,reason=reason,evidence=['phase145/receiver-bodies.jsonl'])
extra('System.Void viperOSK.OSK_Key_TFOL::Relabel(System.String)','display-source','Shift-key guard then direct TMP_Text.set_text; optional null selects original stored label. Runtime activation/rendering unverified.')
extra('System.Void viperOSK.OSK_Receiver::SetText(System.String)','potential-display-input-seed','Original string is length-limited, stored as receiver.text and assigned to TMP_Text as plain or repeated mask character. Runtime activation/input semantics retained.')
for owner in ['viperOSK.OSK_Keyboard','viperOSK.OSK_UI_Keyboard']:
 extra('System.Void '+owner+'::OutputTextUpdate(System.String)','pending-input-control','Active-keyboard guard; actual receiver path distinguishes backspace/delete control tokens and inserts ordinary input. Exact per-selector control assignment required.')
extra('System.Void TheForestOfLove.Narrative.StoryManager::MarkConversationsAsPlayed(System.String,System.String)','preserve-dialogue-selection-identity','First parameter filters original Dialogue.dbName by Contains; second enters MarkQuestStepAsPlayed. These are selection/control arguments; dynamic display names remain separate.')
extra('System.Void TheForestOfLove.Gameplay.FastTravelController::PlayerInitiatesFastTravel(System.String)','preserve-scene-identity','Input stored as destinationSceneName and indexes GetAreaRecordByUnitySceneName, then independent history log and fast-travel state/event. Actual travel unexecuted.')
extra('System.Void TheForestOfLove.Narrative.InstancedStoryController::Shared_Setup(System.String)','preserve-tag-state-identity','Argument added alongside Instanced Event in tag list then UpdateTags; it is original tag-state membership, not an event caption.')
extra('System.Void TheForestOfLove.CCTeleport::Teleport(System.String,UnityEngine.Transform,TheForestOfLove.TransformOffset)','preserve-actor-state-identity','Lowercase player selects Player transform; otherwise CritterActor.FindActorByName. Exact actor selection retained independently from captions.')
extra('System.Void TheForestOfLove.DialogueSettings::SetDialogueDbName(System.String)','preserve-dialogue-selection-identity','Argument enters BTagged.ByName and stored dialogueDbName; original dialogue lookup identity.')
extra('System.Void TheForestOfLove.DialogueSettings::SetArcDbName(System.String)','preserve-dialogue-selection-identity','Argument stored unchanged as arcDbName; original arc selector, no caption assignment.')
for name in ['LoadSoftResetScene','LoadSceneAdditive']:
 extra('System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::'+name+'(System.String)','preserve-scene-identity','Original followup scene name stored for soft reset or forwarded to SceneHelperBase.LoadSceneAdditive. Named native/loader activation boundary remains unexecuted.')
for name in ['InScenePartialMatch','InScenePartialMatchRaw']:
 extra('System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::'+name+'(System.String)','preserve-scene-state-identity','Lowercase current scene name Contains lowercase argument; exact scene-state predicate, no displayed caption.')
extra('System.Void TheForestOfLove.Narrative.NarrativeActions::CompleteQuest(System.String)','preserve-quest-state-identity','Original quest dbName -> GetQuestByDbName -> typed CompleteQuest/SetStatusCompleted and event. State identity retained.')
extra('System.Collections.Generic.List`1<System.String> TheForestOfLove.Services.Persistence.GlobalSavegameFileHelper::ReadPlayerPrefsJsonStringList(System.String)','preserve-persistence-schema','Exact PlayerPrefs.HasKey/GetString input, then JSON deserialize; list contents are separate.')
extra('TheForestOfLove.Services.Persistence.Savestate TheForestOfLove.Services.Persistence.SavegameFileHelper::ReadDataFromGameDirectory(System.String)','preserve-persistence-file-identity','Only string is exact ES3 FileExists/Load filename; typed Savestate payload separate.')
extra('System.Boolean TheForestOfLove.Services.Persistence.SavegameFileHelper::WriteDataToGameDirectory(System.String,TheForestOfLove.Services.Persistence.Savestate,ES3Settings)','preserve-persistence-file-identity','Only string parameter is filename for both version and typed Savestate ES3.Save. No write executed.')
extra('System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)','preserve-history-report-event-prefix','Optional registered service stores timestamped history message; report GenerateRecentStoryEvents reads it under phase140 proof. Not an ordinary game caption; report/application presentation remains separate.')
extra('System.Void ES3::Save<System.String>(System.String,!!0,System.String,ES3Settings)','pending-persistence-string','Selected original calls pass key, version-string value and filename; exact selector assignment protects all three, without excluding arbitrary saved strings.')
for target in ['System.String System.String::Replace(System.String,System.String)','System.Boolean System.String::Equals(System.String,System.StringComparison)','System.Boolean System.String::Equals(System.String)']:
 extra(target,'pending-string-operation','Exact typed string-operation argument; source-specific normalization/comparison/output membership is separately authored.')
extra('NodeCanvas.Framework.Variable NodeCanvas.Framework.Blackboard::SetVariableValue(System.String,System.Object)','pending-blackboard-key','String name selects NodeCanvas blackboard variable; exact string position protected, arbitrary object value and graph display remain separate.')

extra('System.Boolean UnityEngine.Audio.AudioMixer::SetFloat(System.String,System.Single)','preserve-audio-resource-identity','Only string is exposed mixer parameter key; float is volume control. Native mixer binding unexecuted.')
extra('System.Void TheForestOfLove.Narrative.DialogueSystemLoader::PopulateDialogueArcs(TheForestOfLove.Narrative.DataManifest,PixelCrushers.DialogueSystem.DialogueDatabase,TheForestOfLove.Narrative.Dialogue,System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>)','preserve-dialogue-entry-title-identity','Only string is rootNodeTitle passed to GetDialogueEntry; PRIMARY/SECONDARY/IDLE/NAMED select separate arc lists under complete phase141 proof. Not a display caption.')
extra('System.Void PixelCrushers.DialogueSystem.DialogueLua::SetVariable(System.String,System.Object)','preserve-lua-variable-key','Only declared string argument is Lua Variable key under pinned phase140 SetVariable proof; object value is separately checked by argument position.')
def terminal_contracts():
 c=previous_contracts().copy();c.update(EXTRA)
 for n in ['Log','LogWarning','LogError']:
  for args in ['System.Object','System.Object,UnityEngine.Object']:
   c[f'System.Void UnityEngine.Debug::{n}({args})']=dict(role='conditional-log',reason='Exact assembled argument reaches Unity Debug.'+n+'; existing enabled DevConsole subscription/log-mask/render path is reused. Native delivery, activation, mask and runtime reachability remain unverified.',evidence=['phase140/consumer-proofs.json'])
 c['System.Void System.Exception::.ctor(System.String)']=dict(role='exception',reason='Exact assembled message enters Exception constructor. Only construction/throw is source-proved; native exception display and actual UI presentation are unknown.',evidence=['phase141/consumer-proofs.json'])
 return c

def navigate(source,body):
 """Track just this ldstr's stack argument until its first exact boundary.

 No CFG joins, local/field propagation, arrays, pointer stores or broad method
 exclusions. Unknown operations and any branch/store stop before classification.
 """
 stack=[True];window=[];transforms=[]
 def pop():return stack.pop() if stack else False
 for ins in body:
  if ins['offset']<=source['offset']:continue
  window.append(ins);op=ins['opcode'];t=ins['operand'] or ''
  if op.startswith(('br','beq','bne','bgt','bge','blt','ble','leave')) or op in ('switch','ret','throw','rethrow','endfinally','endfilter') or op.startswith('st'):
   return None,window,transforms
  if op.startswith(('ldarg','ldloc','ldc.')) or op in ('ldnull','ldstr','ldsfld','ldsflda','ldftn','ldtoken'):
   stack.append(False)
  elif op in ('ldfld','ldflda'):
   if pop():return None,window,transforms
   stack.append(False)
  elif op=='dup':stack.append(stack[-1] if stack else False)
  elif op=='pop':
   if pop():return None,window,transforms
  elif op=='constrained.':pass
  elif op=='ldlen':
   if pop():return None,window,transforms
   stack.append(False)
  elif op in ('box','unbox.any','castclass','isinst','conv.i4','conv.r4','conv.r8','conv.u2','neg','not'):
   if stack and stack[-1]:return None,window,transforms
  elif op in ('add','sub','mul','div','and','or','ceq','cgt','clt','ldelem.ref'):
   a,b=pop(),pop()
   if a or b:return None,window,transforms
   stack.append(False)
  elif op in ('call','callvirt','newobj'):
   args=splitargs(t[t.rfind('(')+1:-1]);instance=(op=='callvirt' or t in INSTANCE or ('::.ctor(' in t and op!='newobj'))
   consumed=[pop() for _ in args]
   if instance:consumed.append(pop())
   affected=any(consumed)
   if affected:
    if t in TRANSFORMS:transforms.append(ins);stack.append(True)
    elif t in terminal_contracts():return dict(ins,argumentPositions=[len(args)-1-k for k,v in enumerate(consumed[:len(args)]) if v],receiverAffected=bool(instance and consumed[-1])),window,transforms
    else:return None,window,transforms
   elif not t.startswith('System.Void ') or op=='newobj':stack.append(False)
  else:return None,window,transforms
  if not any(stack):return None,window,transforms
 return None,window,transforms

def candidates():
 b={r['method']:r for r in rows(OUT/'phase144/producer-bodies.jsonl')};selected=load(OUT/'phase144/next-compiled-selectors.json')['selectors'];source=rows(INDEX)
 found=[];held=[]
 for r in selected:
  src=source[r['sourceLine']-1];proof=b[r['method']];sink,window,trans=navigate(src,proof['instructions'])
  record=dict(r,argumentWindow=window,transforms=trans)
  if sink:found.append(dict(record,sink=sink,candidateContract=terminal_contracts()[sink['operand']]))
  else:held.append(record)
 return found,held

from phase145.selector_specs import SPECS,CONTEXT,MANUAL,MANUAL_CONTEXT

def assignment_map(spec):
 result={}
 for role,values in spec.items():
  for n in map(int,values.split()):
   assert n not in result,'tail-duplicate-assignment'
   result[n]=role
 return result

def visibility(role):
 if role=='display-conditional-unity-log-wording':return 'conditional-console;native-delivery-activation-mask-runtime-unverified'
 if role=='potential-display-exception-wording':return 'unknown-exception-presentation;construction-only'
 if role.startswith(('display','potential-display')):return 'source-input;application-or-runtime-unverified'
 return 'protected-role;separate-displayed-alias-not-excluded'

def manual_proof(src,body,role):
 line=src['_line'];ix=next(i for i,x in enumerate(body) if x['offset']==src['offset'])
 after=body[ix+1:];evidence=['phase144/producer-bodies.jsonl'];receiver=None
 if role=='preserve-collider-tag-filter-seed':
  assert src['value']=='' and after[0]['operand']=='System.String SoftSpriteMaskStrengthOnCollision2D::requiredTag'
  receiver='System.Boolean SoftSpriteMaskStrengthOnCollision2D::Qualifies(UnityEngine.Collider2D)';consumer=after[0]
 elif role=='display-conditional-unity-log-wording':
  assert line in (81,82,83)
  consumer=next(i for i in after if i['offset']==0xc3)
  assert consumer['operand']=='System.Void UnityEngine.Debug::LogError(System.Object)'
  assert any(i['offset']==0xbe and i['operand']=='System.String System.String::Concat(System.String[])' for i in after)
  assert body[ix-1]['opcode']=='ldc.i4.'+str({81:0,82:2,83:4}[line])
  evidence+=['phase140/consumer-proofs.json']
 elif role=='preserve-animation-trigger-cache':
  consumer=after[0];assert consumer['opcode']=='stfld' and consumer['operand'] in ('System.String TheForestOfLove.Player::lastSetTrigger','System.String TheForestOfLove.BuckyStormQuestMinigameSubController::uiAnimatorLastSetTrigger')
  assert any(i['opcode']=='ldstr' and i['operand']==json.dumps(src['value'],ensure_ascii=False) and j+1<len(body) and body[j+1]['operand']=='System.Void UnityEngine.Animator::SetTrigger(System.String)' for j,i in enumerate(body))
 elif role=='preserve-animation-parameter-identity':
  assert after[0]['opcode']=='br.s' and after[1]['opcode']=='ldstr'
  consumer=after[2]
  assert consumer['operand']=='System.Void UnityEngine.Animator::SetTrigger(System.String)' and consumer['offset']==int(after[0]['operand'][3:],16)
 elif role=='preserve-input-resource-identity':
  assert src['value'] in ('Horizontal','Vertical') and after[0]['opcode']=='ret';consumer=after[0]
  receiver='System.Single viperTools.viperInput::GetAxis(viperTools.AXIS_INPUT)'
 elif role=='preserve-display-symbol':
  assert src['value']=='???'
  if line==1548:target=0x20
  elif line==1552:target=0x12e
  elif line in (1553,1554,1555):target=0x1a6
  elif line==3210:target=0x108
  else:raise AssertionError('tail-unknown-symbol-selector')
  consumer=next(i for i in after if i['offset']==target)
  assert '::SetText(System.String)' in consumer['operand'] or consumer['operand']=='System.Void UnityEngine.UI.Text::set_text(System.String)'
 elif role=='potential-display-notification-step':
  target={1621:0xe0,1622:0xe0,1634:0x262,1651:0x373}[line]
  consumer=next(i for i in after if i['offset']==target)
  assert consumer['operand']=='System.Void TheForestOfLove.QuestUpdatedUI::ShowNotification(System.String,System.String)'
  evidence+=['phase144/receiver-bodies.jsonl']
 else:raise AssertionError('tail-unknown-manual-contract')
 if receiver:
  rec=next(r for r in rows(HERE/'receiver-bodies.jsonl') if r['method']==receiver)
  assert sha(ROOT/rec['evidence'])==rec['fileSha256'];evidence+=['phase145/receiver-bodies.jsonl']
 return dict(bodyConsumer=consumer,bodyArgumentWindow=[i for i in after if i['offset']<=consumer['offset']],transforms=[],receiver=receiver,evidence=evidence,contract='manual:'+role,reason=MANUAL_CONTEXT[role])

def exact_rule(src,body):
 line=src['_line'];manual=assignment_map(MANUAL);typed=assignment_map(SPECS)
 assert not set(manual)&set(typed)
 if line in manual:
  role=manual[line];proof=manual_proof(src,body,role)
 elif line in typed:
  role=typed[line];sink,window,trans=navigate(src,body)
  assert sink is not None,'tail-unsupported-typed-path'
  contract=terminal_contracts()[sink['operand']]
  if role in ('preserve-blackboard-variable-key','preserve-lua-variable-key'):
   assert sink['argumentPositions']==[0] and not sink['receiverAffected'],'tail-key-argument-position'
  proof=dict(bodyConsumer={k:v for k,v in sink.items() if k not in ('argumentPositions','receiverAffected')},bodyArgumentWindow=window,transforms=trans,
   argumentPositions=sink['argumentPositions'],receiverAffected=sink['receiverAffected'],contract='argument:'+sink['operand'],
   evidence=contract['evidence'],reason=CONTEXT.get(role,contract['reason']))
 else:return None
 return dict(role=role,visibility=visibility(role),placeholderContract=re.findall(r'\{[^{}]*\}',src['value']),**proof)

def validate_rule(source,prior,rule,body):
 assert prior['role']=='needs-consumer-decision','tail-prior-role'
 assert (rule['id'],rule['method'],rule['offset'],rule['sourceLine'])==(prior['id'],source['method'],source['offset'],source['_line']),'tail-selector'
 assert rule['sourceValueSha256']==vh(source['value']),'tail-source-value'
 assert rule['producerBodySha256']==vh(body),'tail-producer-body'
 literal=next(i for i in body if i['offset']==source['offset'])
 assert (literal['opcode'],literal['operand'])==('ldstr',json.dumps(source['value'],ensure_ascii=False)),'tail-body-literal'
 expected=exact_rule(source,body);assert expected is not None,'tail-unassigned-selector'
 for k,reason in [('role','tail-role-membership'),('contract','tail-role-membership'),('reason','tail-context'),('evidence','tail-context'),('bodyConsumer','tail-consumer'),('bodyArgumentWindow','tail-argument-window'),('transforms','tail-transform'),('placeholderContract','tail-placeholder'),('visibility','tail-visibility')]:
  assert rule[k]==expected[k],reason
 for k in ('argumentPositions','receiverAffected','receiver'):
  assert rule.get(k)==expected.get(k),'tail-argument-position'

def expanded():
 for n,h in load(HERE/'input-pins.json').items():assert sha(ROOT/n)==h,('tail-input-pin',n)
 selected=load(OUT/'phase144/next-compiled-selectors.json')['selectors'];assert len(selected)==569
 baseline=rows(HERE/'baseline/managed-literal-inventory.jsonl');before={r['id']:r for r in baseline}
 assert [r['id'] for r in selected]==[r['id'] for r in baseline if r['role']=='needs-consumer-decision']
 original=rows(INDEX);bodies={r['method']:r for r in rows(OUT/'phase144/producer-bodies.jsonl')}
 assigned=set(assignment_map(SPECS))|set(assignment_map(MANUAL));assert assigned<={r['sourceLine'] for r in selected}
 decisions=[];held=[]
 for r in selected:
  src=dict(original[r['sourceLine']-1],_line=r['sourceLine']);record=bodies[r['method']];body=record['instructions']
  assert sha(ROOT/record['evidence'])==record['fileSha256'] and vh(src['value'])==r['sourceValueSha256']
  proof=exact_rule(src,body)
  if proof:
   rule=dict(id=r['id'],method=r['method'],offset=r['offset'],sourceLine=r['sourceLine'],sourceValueSha256=r['sourceValueSha256'],producerBodySha256=vh(body),producerEvidence=record['evidence'],**proof)
   validate_rule(src,before[r['id']],rule,body);decisions.append(rule)
  else:
   sink,window,trans=navigate(src,body)
   held.append(dict(r,phase145Boundary=sink or (window[-1] if window else None),phase145ArgumentWindow=window,remainingPredicate='Exact remaining operand; follow the named original return/store/branch/unsupported receiver with its saved complete producer. Current path capture is not an admitted role. No default diagnostic/control exclusion.'))
 assert len(decisions)==len(assigned) and len(decisions)+len(held)==569
 d=dict(schemaVersion=1,phase='0145-work',assignedOccurrences=569,assignedMethods=284,resolvedOccurrences=len(decisions),roleCounts=dict(Counter(r['role'] for r in decisions)),decisions=decisions,
  remainingOccurrences=len(held),remainingMethods=len({r['method'] for r in held}),boundary='Exact per-selector argument/branch/cache/receiver judgments. Conditional Unity console source, unknown exception presentation, and protected input/report/state semantics remain separate. No source/locale/editorial/renderer/runtime gate passed.')
 n=dict(schemaVersion=1,phase='0145-work',occurrences=len(held),methods=len({r['method'] for r in held}),selectors=held,postcondition='Resolve this whole finite remainder using unchanged captured bodies and exact named game consumers; preserve all prior precise roles and whole-product reconstruction.',boundary='Remaining original compiled roles only; database1655 policy/external holds and Rewired1389 aliases remain separate.')
 return d,n

def products():
 d,n=expanded();return {'phase145/compiled-role-decisions.json':d,'phase145/next-compiled-selectors.json':n,
 'compiled-tail-source-context.json':dict(schemaVersion=1,phase='0145-work',assignedOccurrences=569,resolvedIds=[r['id'] for r in d['decisions']],wordingIds=[r['id'] for r in d['decisions'] if r['role'].startswith(('display','potential-display'))],preserveIds=[r['id'] for r in d['decisions'] if r['role'].startswith('preserve')],outputDependencyIds=[r['id'] for r in d['decisions'] if r['role'] in ('preserve-display-symbol','preserve-display-format')],remainingIds=[r['id'] for r in n['selectors']],producerSnapshot='phase144/producer-bodies.jsonl',receivers='phase145/receiver-bodies.jsonl',boundary=d['boundary'])}
if __name__=='__main__':
 for n,v in products().items():(OUT/n).write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
 d,n=expanded();print(json.dumps(dict(resolved=d['resolvedOccurrences'],remaining=n['occurrences'],methods=n['methods'],roles=d['roleCounts'])))
