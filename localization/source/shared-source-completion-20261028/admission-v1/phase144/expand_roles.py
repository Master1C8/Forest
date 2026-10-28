"""Finite authored contracts for the whole phase143 compiled-selector scope.

Conservative typed argument proofs stop at unsupported processing. Saved full
producers are evidence, never automatic semantic coverage or default pass rows.
"""
import json,hashlib,re
from pathlib import Path
from collections import Counter
import sys
sys.path.insert(0,str(Path(__file__).resolve().parent.parent))
from phase137.expand_roles import contracts as old_contracts
HERE=Path(__file__).resolve().parent;OUT=HERE.parent;ROOT=OUT.parents[3]
INDEX=ROOT/'outputs/pause-inventory-bio-completion-20261028/managed-index/literals.jsonl'
def load(p):return json.loads(p.read_text())
def rows(p):return [json.loads(l) for l in p.read_text().splitlines()]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def vh(v):return hashlib.sha256(json.dumps(v,ensure_ascii=False,sort_keys=True,separators=(',',':')).encode()).hexdigest()
def sid(r):return f"il:Assembly-CSharp.dll/{r['method']}/IL_{r['offset']:04x}"
# These exact overloads consume no string. Their result is another argument
# above the pending literal. Stores, branches, stack edits and arbitrary calls
# remain barriers. This extends the former 12-instruction navigation window
# using the selected complete producer, without inferring roles from spelling.
NONSTRING={
'System.Void System.Nullable`1<System.Single>::.ctor(!0)',
'System.Void System.Nullable`1<System.Double>::.ctor(!0)',
'System.Void System.Nullable`1<TheForestOfLove.Direction>::.ctor(!0)',
'System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single)',
'System.Void UnityEngine.Color::.ctor(System.Single,System.Single,System.Single,System.Single)',
'UnityEngine.Vector3 UnityEngine.Vector3::get_normalized()',
'System.Boolean TheForestOfLove.Player::get_lanternEquipped()',
'System.Int32 TheForestOfLove.GeneralStoryUIController::get_CurrentStateId()',
}
LOADS={'ldnull','ldstr','ldfld','ldsfld','ldflda','ldsflda','initobj','box','add','sub','conv.i4','conv.r4','conv.r8'}
def first_call(body,offset):
 window=[]
 for i in body:
  if i['offset']<=offset:continue
  window.append(i)
  if i['opcode'] in ('call','callvirt','newobj'):
   if i['operand'] in NONSTRING:continue
   return i,window
  if not (i['opcode'] in LOADS or i['opcode'].startswith(('ldarg','ldloc','ldc.'))):return None,window
 return None,window

def contracts():
 result={}
 def add(target,role,reason,evidence=None):
  assert target not in result
  result[target]=dict(role=role,reason=reason,evidence=evidence or ['phase144/receiver-bodies.jsonl'])
 # Reuse already proved resource/selection receivers, excluding historical
 # diagnostic exclusions. Exception/log presentation is a separate predicate.
 for c in old_contracts():
  if 'diagnostic' not in c['role']:
   add(c['target'],c['role'],c['reason'],['phase137/'+e for e in c['evidence'] if not e.startswith('original-index:')] or ['phase144/producer-bodies.jsonl;exact-typed-API-boundary'])
 for name in ['IsActorSpawnedOrOnDate','IsActorIntroduced','IsActorOnScreen','IsActorSpawned','IsActorEncountered','IsActorDespawnedOrOnDate']:
  add(f'System.Boolean TheForestOfLove.QuestTriggerHelper::{name}(System.String)','preserve-actor-state-identity','Named original receiver uses the original actor dbName for manifest/spawned-actor/date state selection; exact full receiver is pinned. This does not exclude localized nameplates or assert successful lookup/runtime visibility.')
 for name in ['IsQuestCompleted','IsQuestUnstarted']:
  add(f'System.Boolean TheForestOfLove.QuestTriggerHelper::{name}(System.String)','preserve-quest-state-identity','Exact quest dbName -> DataService.GetQuestByDbName -> status comparison. It is the state selector, not the separate quest title.')
 add('TheForestOfLove.Narrative.QuestStatus TheForestOfLove.QuestTriggerHelper::LoadQuestStatus(System.String)','preserve-quest-state-identity','Exact quest dbName -> GetQuestByDbName -> quest.status. No caption application.')
 add('System.Void TheForestOfLove.QuestTriggerHelper::CompleteQuest(System.String)','preserve-quest-state-identity','Exact quest dbName resolves targetQuest for DialogueTriggerCompleteQuest.Execute. No runtime execution or successful persistence claimed.')
 add('AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)','preserve-object-identity','Exact name passed to new GameObject(string), parented to supplied transform or RootContainer, then AddComponent<AreaContentSet>. Resource/container identity; no blanket exclusion of text children.')
 add('System.Boolean TheForestOfLove.Content.BaseSpawner::CanSpawnAdventuresForGatewayName(System.String)','preserve-adventure-gateway-identity','Exact gateway key compares with home and enters HasAnyUnlockedUnfinishedAdventuresByGatewayName; instanced/mechanic-disabled guards remain. No visible destination alias is applied.')
 add('System.Void TheForestOfLove.Utility.ContentManagementExtensions::SetTargetDialogueInChildren(AreaContent,System.String,System.String,System.String)','preserve-dialogue-selection-identity','All three string arguments forwarded unchanged through the GameObject overload to ObjectActor/CritterActor.SetTargetDialogue; conversation/actor/arc selection operands. No alteration of dialogue wording.')
 for name in ['GetVariable']:
  add(f'System.String TheForestOfLove.Services.Persistence.DataService::{name}(System.String)','preserve-variable-key','Exact argument -> Savestate.LoadVariable -> variables.ContainsKey/get_Item. It is the dictionary selector, not a projected caption.')
 add('System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)','preserve-variable-schema-or-control-value','Original key/value -> Savestate.SaveVariable -> variables dictionary. Selected literal values and their argument positions remain exact. No blanket display exclusion for arbitrary variable readers; application requires preserving saved-state semantics.')
 add('System.Void TheForestOfLove.Services.Persistence.DataService::DeepCopySidequestDialogues(TheForestOfLove.Services.Persistence.Savestate,TheForestOfLove.Narrative.Actor,TheForestOfLove.Services.Persistence.SavegameActorData,TheForestOfLove.Services.Persistence.SavegameActorData,System.Collections.Generic.List`1<TheForestOfLove.Narrative.BioKeyword>,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Dialogue>,System.String)','preserve-quest-state-identity','Only string parameter is questDbName, used in questsByDbName.ContainsKey/get_Item. Conditional completed-quest copy uses actor identities/savekeys; no translation of this lookup input.')
 add('System.Void TheForestOfLove.Services.Persistence.DataService::EnsureInventoryItemIfDialogueComplete(TheForestOfLove.Services.Persistence.Savestate,System.String,TheForestOfLove.Inventory.InventoryItemType)','preserve-dialogue-state-identity','Only string parameter is original dialoguesByDbName key; completion record/status savekey and typed InventoryItemType determine EnsurePlayerHasOne/SaveInventoryItem. This is not an item caption.')
 add('TheForestOfLove.Narrative.AreaRecord TheForestOfLove.Services.Persistence.DataService::GetAreaRecordByUnitySceneName(System.String)','preserve-scene-identity','Only string parameter indexes areasByUnitySceneName. Missing-key diagnostic is separate and remains unchanged.')
 for name in ['AddTagToActive','RemoveTagFromActive']:
  add(f'System.Void TheForestOfLove.Services.Persistence.DataService::{name}(System.String)','preserve-tag-state-identity','Exact tag dbName -> GetTagByDbName -> activeTagsByDbName add/remove. No localized tag alias or successful state mutation is established.')
 add('System.Void TheForestOfLove.Services.Persistence.DataService::ClearTriggerData(System.String)','preserve-trigger-state-identity','Exact trigger name -> GetTriggerByName/ResetTriggerDevtoolsOnly and Savestate.ClearTriggerData. Preserve lookup/persistence identity.')
 add('System.String TheForestOfLove.Services.Persistence.Savestate::LoadVariable(System.String)','preserve-variable-key','Exact variables dictionary key; missing key returns null.')
 add('System.Void TheForestOfLove.Services.Persistence.Savestate::SaveAddTag(System.String)','preserve-tag-state-identity','Exact HashSet tags membership value; persisted tag identity, no caption projection.')
 add('TheForestOfLove.Services.Persistence.SavegameTriggerData TheForestOfLove.Services.Persistence.Savestate::LoadTriggerData(System.String)','preserve-trigger-state-identity','Exact triggerData dictionary key, null when missing; no translated lookup replacement.')
 add('System.Void TheForestOfLove.SpawnManager::ReplaceSpawnData(System.String,System.String,System.Nullable`1<TheForestOfLove.Direction>)','preserve-respawn-scene-or-point-identity','Both strings stored directly in PlayerRespawnData.currentAreaUnitySceneName/namedSpawnPoint; optional direction and resets retain original semantics. Native loading/reachability is not executed.')
 for owner,names in [('BunnyCuckMovie',['SetRedBlinkBTreeTriggerName','SetScarlettBlinkBTreeTriggerName']),('BunnyCuckMoviePeter',['SetBlinkBTreeTriggerName']),('CoyotesOralMovie',['SetClaireBTreeTriggerName','SetVioletBTreeTriggerName']),('RamAnalMovie',['SetRedBTreeTriggerName','SetFinleyBTreeTriggerName'])]:
  for name in names:
   add(f'System.Void TheForestOfLove.{owner}::{name}(System.String)','preserve-behaviour-tree-control-value','Original string stored as blackboard variables[triggerName].value after conditional StartBehaviour, then UpdateBehaviour. This is a graph control value; exact native/vendor graph execution and other readers remain a boundary, not an invented caption exclusion.')
 for name in ['SpawnableActor','CritterActor']:
  add(f'TheForestOfLove.Gameplay.{name} TheForestOfLove.Gameplay.{name}::FindActorByName(System.String)','preserve-actor-state-identity','Original actor selector passed to ActorSpawnerService.GetActor or matched against SpawnableActor.ActorDbName in the complete receiver; displayed actor names are separate.')
 for name in ['SetStorySelectionText','SetMovieSelectionText']:
  add(f'System.Void TheForestOfLove.StartScreenGalleryMenu::{name}(System.String)','display-source','Argument forwarded unchanged to TMP_Text.set_text on every child TextMeshProUGUI of the selected gallery root. Actual active hierarchy/native rendering/runtime remains unexecuted.')
 add('System.Void TheForestOfLove.InteractionUiStatusIconController::UpdateGiftIconText(System.String)','display-source','Argument -> giftIcon.GetComponentsInChildren<TextMeshProUGUI> -> TMP_Text.set_text. Exact displayed wording source; runtime reachability/fitting untested.')
 add('System.Void TheForestOfLove.DialogueNameplateController::SetCustomNameplateNextLineOnly(System.String)','potential-display-nameplate-override','Exact argument stored in customNameplate with one-line flag. Actual application/timing through nameplate presentation remains separate; this is potential wording rather than an actor lookup key.')
 add('System.Void TheForestOfLove.QuestUpdatedUI::ShowNotification(System.String,System.String)','potential-display-notification-step','Both string parameters stored separately as previousStepText/currentStepText on queued QuestUpdateNode. Notification display/drain timing and dynamic-text joins remain explicit; no successful queue presentation is asserted.')
 add('System.Void TheForestOfLove.Audio.SoundManager::PlayTypewriterSound(System.String)','preserve-audio-actor-dispatch-identity','Exact source actor name controls original hash/equality switch and selects MasterAudio sound group/variation. Actor captions can be localized separately; this operand must retain original audio dispatch identity.')
 # Public typed API boundaries: names/keys are unambiguous even where native
 # implementations are outside the game assembly. No recursive audit required.
 for target,role,reason in [
 ('System.Void UnityEngine.Animator::Play(System.String,System.Int32,System.Single)','preserve-animation-state-identity','Exact animator state-name argument; numeric layer/time are not text.'),
 ('System.Void UnityEngine.Animator::Play(System.String)','preserve-animation-state-identity','Exact Animator.Play state-name argument.'),
 ('System.Void AnimationCreator.Core.AnimationPlayer::Play(System.String)','preserve-animation-clip-identity','Exact AnimationPlayer.Play clip/state identifier; no visible caption is inferred.'),
 ('System.Void UnityEngine.Material::SetColor(System.String,UnityEngine.Color)','preserve-shader-property-identity','Only string parameter is material property name, with a typed Color value.'),
 ('System.Void UnityEngine.MonoBehaviour::Invoke(System.String,System.Single)','preserve-method-dispatch-identity','Exact method-name argument for delayed Unity dispatch; time is numeric.'),
 ('System.Void UnityEngine.MonoBehaviour::InvokeRepeating(System.String,System.Single,System.Single)','preserve-method-dispatch-identity','Exact method-name argument for repeated delayed Unity dispatch; native timing is untested.'),
 ('System.Void viperOSK.OSK_Key_TFOL::InvokeRealTime(System.String,System.Single)','preserve-method-dispatch-identity','Exact delayed callback name; no translation application to method dispatch.'),
 ('System.Reflection.FieldInfo System.Type::GetField(System.String,System.Reflection.BindingFlags)','preserve-reflection-member-identity','Exact reflection field-name selector and binding flags; no caption replacement.'),
 ('System.Object System.Type::InvokeMember(System.String,System.Reflection.BindingFlags,System.Reflection.Binder,System.Object,System.Object[])','preserve-reflection-member-identity','Exact reflection member-name selector; preserve method binding before native/vendor execution.'),
 ('UnityEngine.GameObject UnityEngine.GameObject::Find(System.String)','preserve-object-identity','Exact hierarchy/object path for Unity lookup. Text children remain separate.'),
 ('!!0[] UnityEngine.Resources::LoadAll<TheForestOfLove.GameVersionKeySettings>(System.String)','preserve-resource-identity','Exact Resources folder argument for GameVersionKeySettings assets.'),
 ('EZCameraShake.CameraShaker EZCameraShake.CameraShaker::GetInstance(System.String)','preserve-object-identity','Exact camera-shaker instance lookup name; native camera action unexecuted.'),
 ('!!0 Rewired.Player/ControllerHelper::GetControllerWithTag<Rewired.CustomController>(System.String)','preserve-input-resource-identity','Exact custom-controller tag lookup; separate1389 potential label alias predicates unchanged.'),
 ('System.Int32 Rewired.Player/ControllerHelper/MapHelper::SetMapsEnabled(System.Boolean,System.String)','preserve-input-resource-identity','Exact input map category-name selector and Boolean state. Vendor display labels remain separate.'),
 ('System.String UnityEngine.PlayerPrefs::GetString(System.String,System.String)','preserve-persistence-schema-or-default','Exact PlayerPrefs key/default API boundary; no generic wording inference.'),
 ('System.Single UnityEngine.PlayerPrefs::GetFloat(System.String,System.Single)','preserve-persistence-schema','Exact PlayerPrefs key; numeric default unaltered.'),
 ('System.Int32 UnityEngine.PlayerPrefs::GetInt(System.String,System.Int32)','preserve-persistence-schema','Exact PlayerPrefs key; numeric default unaltered.'),
 ('System.Void UnityEngine.PlayerPrefs::SetInt(System.String,System.Int32)','preserve-persistence-schema','Only string parameter is PlayerPrefs key; typed integer stored separately.'),
 ('System.Void UnityEngine.PlayerPrefs::SetFloat(System.String,System.Single)','preserve-persistence-schema','Only string parameter is PlayerPrefs key; typed float stored separately.'),
 ('System.Void UnityEngine.PlayerPrefs::SetString(System.String,System.String)','preserve-persistence-schema-or-value','Exact PlayerPrefs key/value storage; no assertion that arbitrary stored text is invisible.'),
 ('System.Boolean ES3::FileExists(System.String,ES3Settings)','preserve-persistence-file-identity','Only string parameter is ES3 file path; original save naming remains exact.'),
 ('System.Void ES3::DeleteFile(System.String,ES3Settings)','preserve-persistence-file-identity','Only string parameter is ES3 file path; source inspection only, operation not executed.'),
 ('System.Boolean ES3::KeyExists(System.String,System.String,ES3Settings)','preserve-persistence-schema-or-file','Exact ES3 key and filename arguments; lookup/schema identifiers.'),
 ('System.Void ES3::CopyFile(System.String,System.String,ES3Settings,ES3Settings)','preserve-persistence-file-identity','Both string arguments are source/destination file paths, not captions.'),
 ('!!0 ES3::Load<System.String>(System.String,System.String,ES3Settings)','preserve-persistence-schema-or-file','Exact ES3 key and filename arguments; loaded string content is separate.'),
 ('!!0 ES3::Load<TheForestOfLove.Services.Persistence.GlobalSavestate>(System.String,System.String,ES3Settings)','preserve-persistence-schema-or-file','Exact ES3 key and filename arguments; typed GlobalSavestate content is separate.'),
 ('!!0 ES3::Load<TheForestOfLove.Services.Persistence.Savestate>(System.String,System.String,ES3Settings)','preserve-persistence-schema-or-file','Exact ES3 key and filename arguments; typed Savestate content is separate.'),
 ('System.Void ES3::Save<TheForestOfLove.Services.Persistence.GlobalSavestate>(System.String,!!0,System.String,ES3Settings)','preserve-persistence-schema-or-file','Both string parameters are ES3 key and filename; the saved value has explicit GlobalSavestate type.'),
 ('System.Void ES3::Save<TheForestOfLove.Services.Persistence.Savestate>(System.String,!!0,System.String,ES3Settings)','preserve-persistence-schema-or-file','Both string parameters are ES3 key and filename; the saved value has explicit Savestate type.'),
 ('System.Void UnityEngine.UI.Text::set_text(System.String)','display-source','Exact Text.set_text argument. Native drawing, actual game activation and fitting untested.'),
 ('System.Void TMPro.TMP_Text::set_text(System.String)','display-source','Exact TMP_Text.set_text argument. Native drawing, actual game activation and fitting untested.'),
 ('System.Void viperOSK.OSK_SpecialKeys::.ctor(UnityEngine.KeyCode,System.String,UnityEngine.Color,System.Single)','potential-display-key-caption','Only string parameter is the separate special-key caption; typed KeyCode, color and width remain controls. Caption application/renderer/serialization joins require the existing keyboard binding contract.'),
 ]:add(target,role,reason,['phase144/producer-bodies.jsonl;exact-typed-API-boundary'])
 return result

COLLECTION='System.Void System.Collections.Generic.List`1<System.String>::Add(!0)'
KEYMAP='System.Void System.Collections.Generic.Dictionary`2<System.String,UnityEngine.KeyCode>::Add(!0,!1)'
HASHSET='System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)'

def classify(source,body):
 call,window=first_call(body,source['offset'])
 if not call:return None
 target=call['operand'];owner=source['type'];method=source['method'].split('::')[1].split('(')[0]
 contract=contracts().get(target)
 if target==KEYMAP and owner=='viperOSK.OSK_Keymap' and method=='.cctor':
  contract=dict(role='preserve-keycode-map-token',reason='Exact dictionary initializer key in charToKeycode mapping to typed UnityEngine.KeyCode. Tokens include literal symbols and KeyCode spellings; preserve parser/dispatch vocabulary separately from possible rendered special-key captions.',evidence=['phase144/producer-bodies.jsonl'])
 elif target==HASHSET and method=='get_triggerFilters' and owner.startswith('TheForestOfLove.Events.TriggerHandlers.'):
  contract=dict(role='preserve-trigger-filter-identity',reason='Exact returned triggerFilters HashSet member consumed by QuestTriggerHandler.HandleTrigger: global sentinel equality or substring Contains against original trigger/current dialogue/chapter-selection dbName. First match executes then leaves; no translated display alias applied.',evidence=['phase144/receiver-bodies.jsonl'])
 elif target==COLLECTION:
  if owner in ('TheForestOfLove.BunnyCuckMovie','TheForestOfLove.CoyotesOralMovie','TheForestOfLove.RamAnalMovie') and method.startswith('OnFSMState'):
   expected='System.Collections.Generic.List`1<System.String> '+owner+'::onlyAdvanceOnTheseClips'
   if source['before'][-1]==dict(source['before'][-1],opcode='ldfld',operand=expected):
    contract=dict(role='preserve-animation-clip-identity',reason='Exact onlyAdvanceOnTheseClips list element; receiver ldfld directly precedes literal/Add. Clip acceptance state is separate from movie dialogue wording and captions.',evidence=['phase144/producer-bodies.jsonl'])
  elif (owner,method) in [('TheForestOfLove.GlitchRascalPart1Story','.ctor'),('TheForestOfLove.Narrative.InstancedStoryController','.cctor'),('TheForestOfLove.Narrative.StoryManager','.cctor'),('TheForestOfLove.Core.SceneSetup.DbAddressableAssetsPreloader','EnsureDefaultTags'),('TheForestOfLove.Gameplay.FastTravelController','GetDynamicFastTravelDestinationSceneNames'),('TheForestOfLove.Narrative.InstancedStoryController','Shared_Setup')]:
   role={'TheForestOfLove.GlitchRascalPart1Story':'preserve-animation-parameter-identity','TheForestOfLove.Narrative.InstancedStoryController':'preserve-tag-or-quest-state-identity','TheForestOfLove.Narrative.StoryManager':'preserve-actor-state-identity','TheForestOfLove.Core.SceneSetup.DbAddressableAssetsPreloader':'preserve-tag-state-identity','TheForestOfLove.Gameplay.FastTravelController':'preserve-scene-identity'}[owner]
   contract=dict(role=role,reason='Exact list initializer/element from the named complete producer. Assigned fields/callers bind animation-trigger lists, instanced tags/allowed quest names, date-priority actor names, default tags or dynamic destination scene-name cache respectively. These are original state/resource operands, not a whole-producer display exclusion.',evidence=['phase144/producer-bodies.jsonl'])
 elif re.fullmatch(r'System.Void System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove\.(OliverBuckyOralMovie|BunnyCuckMoviePeter|PlantMovie|BunnyHandjobAnimation|SquirrelAnalMovie)/(InternalMovieState|PlantInternalMovieState)>::Add\(!0,!1\)',target) and method=='InitializeStatesByClipName':
  contract=dict(role='preserve-animation-clip-state-identity',reason='Only string argument is dictionary key in the named statesByClipName initializer, with typed movie-state enum value. Resource clip-to-state association remains exact; no movie dialogue/source exclusion follows.',evidence=['phase144/producer-bodies.jsonl'])
 elif target=='!1 System.Collections.Generic.Dictionary`2<System.String,NodeCanvas.Framework.Variable>::get_Item(!0)':
  contract=dict(role='preserve-blackboard-variable-key',reason='Exact string dictionary lookup key for NodeCanvas Variable object; the Variable.value and any captions are separate. Preserve blackboard schema binding.',evidence=['phase144/producer-bodies.jsonl'])
 elif target=='!!0 NodeCanvas.Framework.Blackboard::GetVariableValue<System.String>(System.String)':
  contract=dict(role='preserve-blackboard-variable-key',reason='Only string input selects the blackboard variable; returned string value is separate. Typed selector retained exactly.',evidence=['phase144/producer-bodies.jsonl'])
 elif target=='!1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Quest>::get_Item(!0)':
  contract=dict(role='preserve-quest-state-identity',reason='Exact dictionary lookup key for typed Quest object. Quest title/body remain separate source fields.',evidence=['phase144/producer-bodies.jsonl'])
 if contract:
  return dict(contract,contract='typed:'+target,bodyConsumer=call,bodyArgumentWindow=window)
 return None

def validate_rule(source,prior,rule,body):
 assert prior['role']=='needs-consumer-decision','remaining-prior-role'
 assert (rule['id'],rule['method'],rule['offset'],rule['sourceLine'])==(prior['id'],source['method'],source['offset'],prior['sourceLine']),'remaining-selector'
 assert rule['sourceValueSha256']==vh(source['value']),'remaining-source-value'
 assert rule['producerBodySha256']==vh(body),'remaining-producer-body'
 actual=classify(source,body)
 assert actual is not None,'remaining-unproved-consumer'
 assert rule['role']==actual['role'] and rule['contract']==actual['contract'],'remaining-role-membership'
 assert rule['reason']==actual['reason'] and rule['evidence']==actual['evidence'],'remaining-context'
 assert rule['bodyConsumer']==actual['bodyConsumer'],'remaining-consumer'
 assert rule['bodyArgumentWindow']==actual['bodyArgumentWindow'],'remaining-argument-window'
 assert rule['visibility']==('potential;consumer-application-unverified' if rule['role'].startswith('potential') else 'typed-display-input;runtime-unverified' if rule['role'].startswith('display') else 'protected-role;other-display-consumers-not-excluded'),'remaining-visibility'

def expanded():
 for n,h in load(HERE/'input-pins.json').items():assert sha(ROOT/n)==h,('remaining-input-pin',n)
 selected=load(OUT/'phase143/next-compiled-selectors.json')['selectors'];assert len(selected)==1251
 baseline=rows(HERE/'baseline/managed-literal-inventory.jsonl');prior={r['id']:r for r in baseline}
 assert [r['id'] for r in selected]==[r['id'] for r in baseline if r['role']=='needs-consumer-decision']
 original=rows(INDEX);bodies={r['method']:r for r in rows(HERE/'producer-bodies.jsonl')}
 assert len(bodies)==443 and set(bodies)=={r['method'] for r in selected}
 decisions=[];remaining=[]
 for row in selected:
  source=original[row['sourceLine']-1];proof=bodies[row['method']];body=proof['instructions']
  assert sid(source)==row['id'] and vh(source['value'])==row['sourceValueSha256']
  assert sha(ROOT/proof['evidence'])==proof['fileSha256']
  literal=next(i for i in body if i['offset']==row['offset'])
  assert literal['opcode']=='ldstr' and literal['operand']==json.dumps(source['value'],ensure_ascii=False),'remaining-original-literal'
  found=classify(source,body)
  if not found:
   call,window=first_call(body,row['offset'])
   remaining.append(dict(row,source=source['value'],producerEvidence=proof['evidence'],producerBodySha256=vh(body),firstBoundary=call or window[-1] if window else None,remainingPredicate='Read exact pending producer/argument assembly and named actual display/control consumer; no default role inferred. Saved producer capture alone is not semantic coverage.'))
   continue
  rule=dict(row,**{k:v for k,v in found.items() if k not in row},producerBodySha256=vh(body),producerEvidence=proof['evidence'])
  for k in ('role','reason','contract','evidence','bodyConsumer','bodyArgumentWindow'):rule[k]=found[k]
  rule.pop('source',None)
  rule['visibility']='potential;consumer-application-unverified' if rule['role'].startswith('potential') else 'typed-display-input;runtime-unverified' if rule['role'].startswith('display') else 'protected-role;other-display-consumers-not-excluded'
  validate_rule(source,prior[row['id']],rule,body);decisions.append(rule)
 assert len(decisions)+len(remaining)==1251
 return dict(schemaVersion=1,phase='0144-work',assignedOccurrences=1251,assignedMethods=443,decisions=decisions,roleCounts=dict(Counter(r['role'] for r in decisions)),remainingOccurrences=len(remaining),remainingMethods=len({r['method'] for r in remaining}),boundary='Exact finite typed-source judgments; unproved consumers explicitly retained. Full producer capture does not establish full semantic review, source admission, editorial, application or runtime acceptance.'),dict(schemaVersion=1,phase='0144-work',assignedOccurrences=1251,assignedMethods=443,resolvedOccurrences=len(decisions),occurrences=len(remaining),methods=len({r['method'] for r in remaining}),selectors=remaining,postcondition='Finish every listed original role using the existing captured producer and exact named receiver; no unchanged re-extraction or tiny-subset continuation.',boundary='Only remaining original compiled roles; database1655 and Rewired1389 remain separate source-policy/alias holds.')

def products():
 d,n=expanded()
 return {'phase144/compiled-role-decisions.json':d,'phase144/next-compiled-selectors.json':n,'compiled-remaining-source-context.json':dict(schemaVersion=1,phase='0144-work',assignedOccurrences=1251,assignedMethods=443,roleCounts=d['roleCounts'],resolvedIds=[r['id'] for r in d['decisions']],wordingIds=[r['id'] for r in d['decisions'] if r['role'].startswith(('display','potential-display'))],preserveIds=[r['id'] for r in d['decisions'] if r['role'].startswith('preserve')],remainingIds=[r['id'] for r in n['selectors']],producerSnapshot='phase144/producer-bodies.jsonl',receiverSnapshot='phase144/receiver-bodies.jsonl',boundary=d['boundary'])}
if __name__=='__main__':
 for name,value in products().items():(OUT/name).write_text(json.dumps(value,ensure_ascii=False,indent=2)+'\n')
 d,n=expanded();print(json.dumps(dict(resolved=len(d['decisions']),remaining=n['occurrences'],roles=d['roleCounts'])))
