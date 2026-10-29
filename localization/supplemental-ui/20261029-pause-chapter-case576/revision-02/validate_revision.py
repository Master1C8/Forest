"""Validate bounded revision, preservation and chooser decision fixtures; never applies targets."""
import collections,copy,hashlib,json,pathlib,re
ROOT=pathlib.Path('/Users/antonkrutov/Desktop/Forest');V=ROOT/'localization/supplemental-ui/20261029-pause-chapter-case576';P=V/'revision-02';O=ROOT/'outputs/ru-pause-chapter576-case-wording-20261029/revision-02';T=ROOT/'localization/source/pause-chapter576-binding-contract-20261029'
def sha(p):return hashlib.sha256(pathlib.Path(p).read_bytes()).hexdigest()
def uh(s):return hashlib.sha256(s.encode()).hexdigest()
def load(p):return json.loads(pathlib.Path(p).read_text())
def lines(p):return [json.loads(l) for l in pathlib.Path(p).read_text().splitlines()]
def out(n,x):(P/n).write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n')
def jl(n,x):(P/n).write_text(''.join(json.dumps(y,ensure_ascii=False,separators=(',',':'))+'\n' for y in x))
def canonical(x):return json.dumps(x,ensure_ascii=False,sort_keys=True,separators=(',',':'))
rows=lines(P/'ru.prepared.jsonl');old=lines(V/'ru.prepared.jsonl');oldBy={r['id']:r for r in old};initial=lines(P/'ru.initial.jsonl');initialBy={r['id']:r for r in initial};matrix={r['id']:r for r in lines(T/'selector-binding-matrix.jsonl')};newIds={r['id'] for r in lines(T/'active-cheat60-source-delta.jsonl')};auth=load(P/'wording.authored.json');groups=lines(V/'semantic-groups.jsonl');chooser=load(T/'cheat-chooser-contract.json')
class Rejected(Exception):pass
def req(ok,boundary):
 if not ok:raise Rejected(boundary)
def validate(rs):
 ids=[r['id'] for r in rs];req(len(ids)==len(set(ids)),'unique-ids');req(ids==list(oldBy),'canonical576-order')
 for r in rs:
  b=initialBy[r['id']];o=oldBy[r['id']]
  req(all(r[k]==o[k] for k in ['source','sourceValueSha256','sourceLine','hierarchy','pointer','currentValue','role']),'source-current-binding')
  req(r['applicationClass']==b['applicationClass'] and r['staticWordingApplicable']==b['staticWordingApplicable'],'application-partition')
  req(r['applicationAllowed'] is False and r['targetApplied'] is False,'closed-application-gate')
  if r['applicationClass']=='preserve-exactly':req(r['target'] is None and r['currentValue']==r['source'],'protected-current-and-null')
  if r['applicationClass']=='application-held':req(r['target']==o['target'],'held-target-preserved')
  if o['target'] is not None:req(r['target']==o['target'],'unchanged-v1-target')
  if r['target'] is not None:
   req(re.findall(r'<[^>]*>',r['target'])==re.findall(r'<[^>]*>',r['source']),'markup-contract')
   req(re.findall(r'\[[^\]]+\]',r['target'])==re.findall(r'\[[^\]]+\]',r['source']),'input-control-literals')
   req(r['target'].count('\n')==r['source'].count('\n'),'paragraph-linebreaks')
   req(('tfol.info' in r['target'])==('tfol.info' in r['source']),'website-literal')
 for g in groups:
  rr=[r for r in rs if r['id'] in g['ids'] and r['target'] is not None];req(len({r['target'] for r in rr})<=1,'six-layer-target-coherence')
 for r in rs:
  if r['id'] in newIds:req(r['target']==auth[r['source']]['target'],'direct-authored-caption')
  req(r['targetUtf8Sha256']==(uh(r['target']) if r['target'] is not None else None),'target-utf8-hash')
 req(sum(r['target']!=oldBy[r['id']]['target'] for r in rs)==60,'exact60-target-delta')
 req(sum(r['target'] is not None and r['staticWordingApplicable'] for r in rs)==446,'applicable446')
 return True
validate(rows)
neg=[]
def negative(name,edit,reason):
 rs=copy.deepcopy(rows);edit(rs)
 try:validate(rs)
 except Rejected as e:req(str(e)==reason,'wrong-negative-boundary:'+name+':'+str(e));neg.append({'id':name,'expected':reason,'observed':str(e),'status':'passed'})
 else:raise AssertionError('negative accepted:'+name)
def pick(rs,cond):return next(r for r in rs if cond(r))
negative('omit-active-status-row',lambda r:r.pop(0),'canonical576-order')
negative('duplicate-selector',lambda r:r.append(copy.deepcopy(r[0])),'unique-ids')
negative('alter-source',lambda r:r[0].update(source='Run Cheat'),'source-current-binding')
negative('unexpected-current',lambda r:r[0].update(currentValue='Применить чит?'),'source-current-binding')
negative('apply-before-parent-gates',lambda r:r[0].update(applicationAllowed=True),'closed-application-gate')
negative('release-unbound-gallery-heading',lambda r:pick(r,lambda x:'/UnlockMovies/' in x['hierarchy'] and x['target'] is not None).update(applicationClass='static-wording-candidate'),'application-partition')
negative('translate-unbound-status',lambda r:pick(r,lambda x:'/UnlockMovies/' in x['hierarchy'] and x['source']=='Not Activated').update(target='Не активировано'),'held-target-preserved')
negative('translate-template-seed',lambda r:pick(r,lambda x:x['technicalDisposition']=='preserve-dynamic-template-default').update(target='тест'),'held-target-preserved')
negative('translate-diagnostic-default',lambda r:pick(r,lambda x:x['technicalDisposition']=='preserve-dynamic-diagnostic-default').update(target='Система'),'held-target-preserved')
negative('guess-mixed-tooltip',lambda r:pick(r,lambda x:x['technicalDisposition']=='hold-mixed-empty-state-default').update(target='Здесь появятся главы!'),'held-target-preserved')
negative('change-plus-level',lambda r:pick(r,lambda x:x['source']=='++').update(target='низкий'),'protected-current-and-null')
negative('overwrite-accepted-input',lambda r:pick(r,lambda x:x['source']=='ENTER').update(target='Ввод'),'unchanged-v1-target')
negative('change-one-new-glow',lambda r:r[0].update(target='Запустить чит?'),'six-layer-target-coherence')
negative('insert-new-markup',lambda r:r[0].update(target='<b>Применить чит?</b>'),'markup-contract')
def guardChooser(c):req(c==chooser,'protected-chooser-identities')
guardChooser(copy.deepcopy(chooser));bad=copy.deepcopy(chooser);bad['pairs'][0]['faces'][0]['gameObject']=0
try:guardChooser(bad)
except Rejected as e:neg.append({'id':'alter-chooser-go','expected':'protected-chooser-identities','observed':str(e),'status':'passed'})
else:raise AssertionError('chooser mutation accepted')
# Source-derived decision fixtures. They replace real Unity input/activation, not claim it.
keys=['cheats_unlock_all_story_chapters','cheats_complete_all_dates','cheats_complete_all_gossips','cheats_dustin_minigame_invincible','cheats_plant_minigame_handsfree'];decision=[]
req(re.findall(r'ldstr "(cheats_[^"]+)"',(T/'CheatsMenu.il').read_text())==keys,'original-cheat-key-bindings')
req(collections.Counter(p['change'] for p in chooser['pairs'])=={'set-true':3,'toggle':2},'one-shot-toggle-partition')
def guardKeys(k):req(k==keys,'protected-cheat-key-identities')
guardKeys(list(keys));badKeys=list(keys);badKeys[0]='читы_открыть_главы'
try:guardKeys(badKeys)
except Rejected as e:neg.append({'id':'translate-cheat-variable-key','expected':'protected-cheat-key-identities','observed':str(e),'status':'passed'})
else:raise AssertionError('translated key accepted')
bad=copy.deepcopy(chooser);bad['pairs'][0]['callback']='Cheat_CompleteAllDates'
try:guardChooser(bad)
except Rejected as e:neg.append({'id':'swap-active-cheat-callback','expected':'protected-chooser-identities','observed':str(e),'status':'passed'})
else:raise AssertionError('callback swap accepted')
for pair,key in zip(chooser['pairs'],keys):
 for value in [None,'','false','true']:
  state=value is not None;face=pair['faces'][0 if state else 1]
  req(len(face['ids'])==6 and set(face['ids'])<=newIds,'chooser-six-members')
  decision.append({'property':pair['property'],'protectedKey':key,'storedValue':value,'initializedState':state,'selectedGameObject':face['gameObject'],'selectedIds':face['ids'],'boundary':'Source presence != null; textual false is still present. No parsing of translated captions.'})
 for state in [False,True]:
  for wait in [0,2]:
   after=state if wait>0 else (True if pair['change']=='set-true' else not state)
   decision.append({'property':pair['property'],'callback':pair['callback'],'inputState':state,'waitFrames':wait,'stateAfter':after,'waitAfter':wait if wait>0 else 2,'selectedIds':pair['faces'][0 if after else 1]['ids'],'boundary':'Source CIL decision fixture only; callback invocation, game effects, persistence and Unity.SetActive not executed.'})
req(len(decision)==40,'chooser-fixtures-count')
jl('chooser-decision-fixtures.jsonl',decision)
plan=[]
for r in rows:
 after=r['target'] if r['applicationClass']=='static-wording-candidate' else r['currentValue']
 req(after is not None,'non-null-proposal')
 if r['applicationClass'] in ['application-held','preserve-exactly','accepted-current-binding']:req(after==r['currentValue'],'noncandidate-current-preserved')
 plan.append({'id':r['id'],'pointer':r['pointer'],'currentValue':r['currentValue'],'wordingTarget':r['target'],'proposedScalarAfter':after,'changed':after!=r['currentValue'],'applicationClass':r['applicationClass'],'currentNonTextTreeSha256':matrix[r['id']]['currentNonTextTreeSha256'],'applicationAllowed':False,'targetApplied':False,'boundary':'Scalar-only proposal backed by immutable technical current nontext hash. No asset rewritten or independently decoded in this linguistic lane.'})
req(sum(r['changed'] for r in plan)==434,'static434-proposal')
jl('display-proposal.jsonl',plan)
fullFixtures=[]
for g in groups:
 rr=[r for r in rows if r['id'] in g['ids']]
 fullFixtures.append({'groupId':g['groupId'],'hierarchy':g['hierarchy'],'ids':g['ids'],'members':[{'id':r['id'],'source':r['source'],'target':r['target'],'applicationClass':r['applicationClass'],'proposedScalarAfter':next(x['proposedScalarAfter'] for x in plan if x['id']==r['id'])} for r in rr],'assembly':g['assembly']})
jl('complete-semantic-groups.jsonl',fullFixtures)
for fn,n in [('author-semantic-delta.jsonl',96),('native-russian-delta.jsonl',96),('author-semantic-final.jsonl',452),('native-russian-final.jsonl',452),('retained-v1-receipts.jsonl',356)]:
 rr=lines(P/fn);req(len(rr)==len({r['id'] for r in rr})==n,'review-coverage:'+fn)
regressions=load(V/'mandatory-regressions.json')
out('mandatory-regressions.json',{'retainedV1Catalog':{'path':str((V/'mandatory-regressions.json').relative_to(ROOT)),'sha256':sha(V/'mandatory-regressions.json'),'rows':regressions,'applicability':'Unchanged wording/control/title/report/font risks retained. V1 cheat/template hold assertions superseded only by revision02 explicit source disposition below.'},'revision02':[
 {'id':'exact60-not54','predicate':'Five bound controls x2 faces x6 physical leaves;60 exact new targets, no dropped UnlockMovies offset','status':'passed-static'},
 {'id':'one-shot-versus-toggle','predicate':'Three Run Cheat?/Activated pairs set true; two On/Off pairs invert state; original keys/GO/callbacks protected','status':'passed-source-and-author; runtime-not-run'},
 {'id':'full-chooser-read','predicate':'All90 active chooser members plus complete18 unbound members read;96 nonnull words actually audited and separately read in Russian','status':'passed-author'},
 {'id':'unbound18-hold','predicate':'Six prior heading targets preserved;12 status defaults remain null; all18 application-held, no action synthesized','status':'passed-static-and-author'},
 {'id':'chapter-defaults','predicate':'Ten clone-cleared templates, mixed6 tooltip defaults and debug1 retained unchanged; generated titles/descriptions remain separate','status':'passed-static-hold'},
 {'id':'diagnostic-payload-split','predicate':'Two generated diagnostic defaults stay exact; changing saved strings cannot localize transmitted data','status':'passed-static-hold'},
 {'id':'current-protection','predicate':'93 protected values and12 current accepted inputs remain exact;434 scalar changes only in unapplied proposal','status':'passed-static'},
 {'id':'independence-and-runtime','predicate':'No independent pass inherited, no renderer/runtime or source/ordinary/whole-game acceptance inferred','status':'pending-independent; runtime-not-run'}]})
for fn,h in load(P/'input-pins.json').items():req(sha(ROOT/fn)==h,'input-pin:'+fn)
for fn,h in load(P/'v1-preservation-baseline.json').items():req(sha(ROOT/fn)==h,'v1-preservation:'+fn)
out('deterministic-preflight.json',{'status':'passed','assigned':576,'newTargetDelta':60,'unchangedV1Targets':392,'applicableNonnull':446,'wordingNonnull':452,'applicationHeld':37,'protectedValues':93,'unappliedScalarChanges':434,'negativeControls':neg,'negativeControlCount':len(neg),'decisionFixtures':40,'retainedV1DeterministicEvidence':{'path':str((V/'deterministic-preflight.json').relative_to(ROOT)),'sha256':sha(V/'deterministic-preflight.json'),'applicability':'Unchanged392 wording and old structural/control contracts only; new cheat holds/dispositions superseded by revision02 tests.'},'boundary':'Saved mappings, scalar proposal, exact keys/GO contracts and source-derived mocked decisions. Does not exercise asset reinsertion, live chooser activation, transmission, fonts or runtime.'})
out('preservation-proof.json',{'status':'passed','v1FilesUnchanged':40,'v1Baseline':'v1-preservation-baseline.json','v1TargetsUnchanged':392,'old93ProtectedValuesUnchanged':True,'acceptedInput72Current12Unchanged':True,'unchangedSixHeldHeadingHashes':True,'allNewTechnicalOutputPinsVerified':81,'v1InputPinsReverified':624,'inputPinCount':len(load(P/'input-pins.json')),'writes':['localization/supplemental-ui/20261029-pause-chapter-case576/revision-02/','outputs/ru-pause-chapter576-case-wording-20261029/revision-02/'],'sourceInventoryWritten':False,'existingAssetsWritten':False,'rootDocsWritten':False,'gitMutations':False,'nestedJobs':0,'targetApplied':False})
checklist=[
 {'artifact':'ru.prepared.jsonl','predicate':'Exact576 source/current bindings and all target/application dispositions','evidence':'452 nonnull wording,446 applicable incl12 already current,37 held incl6 wording,93 protected','uncertainty':'Independent wording review and parent admission pending','nextPermittedAction':'Parent reviews full final576 packet once; do not apply held37'},
 {'artifact':'complete-chooser-fixtures.json + author-semantic-delta.jsonl','predicate':'60 new status captions plus complete heading/chooser dependencies','evidence':'New96 semantic/native rows;356 unaffected v1 receipts retained by exact source/target/context hashes','uncertainty':'No independent language review yet','nextPermittedAction':'Independent reviewer checks complete452 wording closure plus124 null context'},
 {'artifact':'protected-and-held.jsonl','predicate':'Inactive UnlockMovies, runtime defaults and diagnostic payloads preserved','evidence':'Whole18 unbound control,10 templates,6 mixed tooltip defaults,2 diagnostic columns,1 debug held','uncertainty':'Empty-list display decision, unbound reachability and optional diagnostic display projection remain outside scalar wording','nextPermittedAction':'Parent retains exact source values; any future adaptation gets its own exact accepted contract'},
 {'artifact':'display-proposal.jsonl + chooser-decision-fixtures.jsonl','predicate':'Exact native scalar projection respects original control identities','evidence':'434 unapplied scalar changes;40 source-decision fixtures; technical nontext hashes forwarded unchanged','uncertainty':'No live reinsertion, callback, persistence or activation exercise','nextPermittedAction':'Parent-owned implementation only after accepted wording and applicable gates'},
 {'artifact':'mandatory-regressions.json','predicate':'Actual Cyrillic rendering and full field/layout behavior','evidence':'V1 source sizes/styles/resources and final target wording hashes retained; no font changes','uncertainty':'Native fit/font/keyboard/game paths not run','nextPermittedAction':'Authorized parent runtime/resource workflow after its gates'},
 {'artifact':'v1-preservation-baseline.json','predicate':'Historical evidence immutable; only finite revision supersedes proposal','evidence':'All40 v1 files and392 old targets unchanged','uncertainty':'Canonical integration remains parent-owned','nextPermittedAction':'Parent integrates reviewed packet; worker starts no further phase'}]
out('acceptance-checklist.json',checklist)
out('process-binding.json',{'stage':'translate-edit: bounded special-case source-evidence delta','game':'The Forest of Love','version':'0.45','locale':'ru','model':'gpt-6.1-sol','reasoning':'high','provider':'openai','sameSession':'01a18634-381a-71e1-9143-4ca2d43dd59b','v1ProcessBinding':{'path':str((V/'process-binding.json').relative_to(ROOT)),'sha256':sha(V/'process-binding.json')},'inheritedNewHistory':False,'nestedJobs':0,'ordinaryTranslationEntryAllowed':False,'sourceGateAccepted':False,'wholeGameAccepted':False,'targetApplied':False})
result={'status':'finite-pause-chapter576-revision02-handoff-complete','game':'The Forest of Love','version':'0.45','locale':'ru','revision':'02','assigned':576,'newCaptions':60,'v1TargetsUnchanged':392,'staticCandidates':434,'acceptedCurrentInput72':12,'applicableNonnullFields':446,'wordingNonnullFields':452,'applicationHeld':37,'heldNonnullWording':6,'heldNullDefaults':31,'protectedValues':93,'newAuthorSemanticRows':96,'newSeparateRussianRows':96,'retainedUnaffectedV1AuthorReceipts':356,'authorFinalCovered':452,'independentReview':'pending','targetApplied':False,'actualGameRuntime':'not-run','ordinaryTranslationEntryAllowed':False,'sourceGateAccepted':False,'wholeGameAccepted':False,'deterministicPreflight':'passed','negativeControls':len(neg),'decisionFixtures':40,'objectiveWordingFindings':0,'repairDelta':0,'targetDelta':60,'model':'gpt-6.1-sol','reasoning':'high','provider':'openai','nestedJobs':0,'targetSha256':sha(P/'ru.prepared.jsonl'),'packetPath':str(P),'supersedes':'V1 display proposal only for this bounded preparation stage; historical v1 preserved','nextPermittedAction':'Parent independent review of final576 and later parent-owned application/adoption; worker stops here.'}
out('Result.json',result);O.mkdir(exist_ok=True);(O/'Result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
(P/'HANDOFF.md').write_text('''Revision02 completes the finite source-evidence delta for the same576 Pause/Chapter memberships. It supersedes v1's display proposal only for this bounded preparation stage; all40 v1 files and392 prior targets remain unchanged.

The exact new caption set is60: five active controls, two faces each, six render layers per face. Three one-shot controls use Применить чит? / Активировано; Dustin and Plant toggles use Вкл. / Выкл. The author read the full90 active chooser members plus18 unbound UnlockMovies members, actually audited and separately read96 nonnull targets (new60 + refreshed36), and retained356 unaffected v1 author receipts only after exact source/target/base-context hash checks. No independent pass is inherited.

The full576 mapping contains434 static wording candidates plus12 exact current accepted input72 bindings, yielding446 applicable nonnull fields. Six additional prior UnlockMovies heading targets remain authored wording with application held. The whole18-member UnlockMovies control is held: its other12 status defaults stay null and no callback is invented. The other19 held members are10 clone-cleared chapter templates,6 mixed tooltip defaults,2 generated diagnostic columns and1 dormant debug field. All93 protected values remain exact. Total nonnull wording452 includes the6 held labels; it is not a452-field application plan.

All full paragraphs, callback labels, title/button siblings, literal website/control data and prior accepted targets remain unchanged. The exact source-disposition delta has97 IDs; affected chooser/default context has127 IDs. New target delta60 and wording-repair delta0 are distinct. Initial and final revision02 wording bytes match.

Static preflight, intended-boundary negative checks and40 source-derived chooser decision fixtures pass. The unapplied scalar proposal has434 changes and preserves all held/current/protected values. It forwards immutable technical nontext hashes; this linguistic lane does not decode or rewrite the candidate, execute Unity, invoke callbacks, alter persistence or verify rendering. V1's624 input pins and81 final technical output/code pins are reverified.

The parent should independently review the full final576 packet once:452 wording IDs, including6 held potential labels, plus124 null context IDs and mandatory regressions. Any later correction follows the exact dependency delta algorithm. Source, ordinary-translation, whole-game, application, resources and runtime gates remain unaccepted/not-run. No game, GUI, image, installer, font, texture, Git/index, root documentation, source inventory, site, server or nested job was touched. This worker stops at this finite handoff.
''')
out('recipe-pins.json',{f:sha(P/f) for f in ['prepare_revision.py','validate_revision.py','wording.authored.json','group-read.authored.json']})
out('output-hashes.json',{f.name:sha(f) for f in P.iterdir() if f.is_file() and f.name!='output-hashes.json'})
print(json.dumps({'status':result['status'],'applicableNonnullFields':446,'wordingNonnullFields':452,'newTargets':60,'newSemanticNative':96,'held':37,'protected':93,'negativeControls':len(neg),'decisionFixtures':40,'targetSha256':result['targetSha256']}))
