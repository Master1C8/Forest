"""Finite static checks and evidence serialization. No application or language generation."""
import collections, copy, hashlib, json, pathlib, re
ROOT=pathlib.Path('/Users/antonkrutov/Desktop/Forest')
P=ROOT/'localization/supplemental-ui/20261029-pause-chapter-case576'
O=ROOT/'outputs/ru-pause-chapter576-case-wording-20261029'
def sha(p):return hashlib.sha256(pathlib.Path(p).read_bytes()).hexdigest()
def uh(s):return hashlib.sha256(s.encode()).hexdigest()
def load(p):return json.loads(pathlib.Path(p).read_text())
def lines(p):return [json.loads(l) for l in pathlib.Path(p).read_text().splitlines()]
def out(name,d): (P/name).write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n')
def jl(name,d):(P/name).write_text(''.join(json.dumps(x,ensure_ascii=False,separators=(',',':'))+'\n' for x in d))
rows=lines(P/'ru.prepared.jsonl');original=lines(P/'ru.initial.jsonl');S={r['id']:r for r in original}
auth=load(P/'wording.authored.json');native=load(P/'native-read.authored.json');schemas={r['id']:r['sourceNativeFields'] for r in lines(P/'native-component-schemas.jsonl')}
groups=lines(P/'semantic-groups.jsonl');pins=load(P/'input-pins.json')
class Rejected(Exception):pass
def require(test,reason):
 if not test:raise Rejected(reason)
def validate(rs):
 ids=[r['id'] for r in rs]
 require(len(ids)==len(set(ids)),'unique-ids')
 require(ids==list(S),'complete-canonical-order')
 for r in rs:
  before=S[r['id']]
  require(all(r[k]==before[k] for k in ['source','sourceValueSha256','sourceUtf8Sha256','hierarchy','pointer','className','role','sourceLine','status','logicalGroup']),'exact-source-binding')
  require(r['currentValue']==before['currentValue'] and r['currentUtf8Sha256']==uh(r['currentValue']),'exact-current-binding')
  if r['status']=='preserve-exactly':require(r['target'] is None,'protected-target-null')
  if r['status']=='needs-source':require(r['target'] is None and bool(r['missingPredicate']),'needs-source-target-null')
  if r['status']=='retained-exact-current-binding':require(r['target']==before['currentValue'],'retained-current-target')
  t=r['target']
  if t is None:continue
  require(re.findall(r'<[^>]*>',t)==re.findall(r'<[^>]*>',r['source']),'markup-contract')
  require(('tfol.info' in t)==('tfol.info' in r['source']),'website-literal')
  require(re.findall(r'\[[^\]]+\]',t)==re.findall(r'\[[^\]]+\]',r['source']),'control-literals')
  require(t.count('\n')==r['source'].count('\n'),'line-break-contract')
  if "Select ''Edit Text''" in r['source']:require('«Изменить текст»' in t,'quoted-action-contract')
 for g in groups:
  rs2=[r for r in rs if r['id'] in g['ids'] and r['target'] is not None]
  require(len({r['target'] for r in rs2})<=1,'parallel-sibling-contract')
 for r in rs:
  if r['status']=='prepared':require(r['target']==auth[r['source']][0],'authored-wording-binding')
  if r['target'] is not None:require(r['targetUtf8Sha256']==uh(r['target']),'target-hash')
 return True
validate(rows)
neg=[]
def negative(name,edit,reason):
 rs=copy.deepcopy(rows);edit(rs)
 try:validate(rs)
 except Rejected as e:require(str(e)==reason,('wrong-negative-boundary',name,str(e)));neg.append({'id':name,'expectedBoundary':reason,'observedBoundary':str(e),'status':'passed'})
 else:raise AssertionError(('negative-accepted',name))
def first(rs,source):return next(r for r in rs if r['source']==source and r['target'] is not None)
def change(rs,source,value):first(rs,source)['target']=value
negative('missing-selector',lambda r:r.pop(),'complete-canonical-order')
negative('duplicate-selector',lambda r:r.append(copy.deepcopy(r[0])),'unique-ids')
negative('source-mismatch',lambda r:r[0].update(source='other'),'exact-source-binding')
negative('unexpected-current-value',lambda r:r[0].update(currentValue='other'),'exact-current-binding')
negative('translate-protected-marker',lambda r:next(x for x in r if x['source']=='++').update(target='низкий'),'protected-target-null')
negative('guess-cheat-activation',lambda r:r[0].update(target='Активировать чит?'),'needs-source-target-null')
negative('overwrite-retained-label',lambda r:first(r,'ENTER').update(target='Enter'),'retained-current-target')
negative('insert-unsupported-markup',lambda r:change(r,'Save','<b>Сохранить</b>'),'markup-contract')
web=next(r['source'] for r in rows if 'tfol.info' in r['source'])
negative('alter-website',lambda r:change(r,web,auth[web][0].replace('tfol.info','tfol.example')),'website-literal')
negative('alter-control-identity',lambda r:change(r,'Press [Escape] or Joystick [B] when finished!','Когда закончишь, нажми [Esc] или [B] на геймпаде!'),'retained-current-target')
# A non-retained fixture tests the same control parser after satisfying retention.
def control_check(src,tgt):require(re.findall(r'\[[^\]]+\]',src)==re.findall(r'\[[^\]]+\]',tgt),'control-literals')
control_check('[Escape] [B]','[Escape] [B]')
try:control_check('[Escape] [B]','[Esc] [B]')
except Rejected as e:require(str(e)=='control-literals','negative-control-parser');neg.append({'id':'control-parser-with-matching-positive','expectedBoundary':'control-literals','observedBoundary':str(e),'status':'passed'})
negative('drop-report-line',lambda r:change(r,'Send\nReport','Отправить отчёт'),'line-break-contract')
instruction=next(r['source'] for r in rows if "Select ''Edit Text''" in r['source'])
negative('quoted-action-drift',lambda r:change(r,instruction,auth[instruction][0].replace('«Изменить текст»','«Редактировать»')),'quoted-action-contract')
negative('patch-only-one-glow',lambda r:change(r,'Music','Звук'),'parallel-sibling-contract')
def accept_before(current,old,new):
 require(current==old or current==new,'exact-before-state');return new
require(accept_before('Go','Go','Go now')=='Go now','overlap-forward-positive')
require(accept_before('Go now','Go now','Go')=='Go','overlap-reverse-positive')
for n,old,new,bad in [('forward','Go','Go now','Go now!'),('reverse','Go now','Go','Go now!')]:
 try:accept_before(bad,old,new)
 except Rejected as e:neg.append({'id':'overlap-'+n,'expectedBoundary':'exact-before-state','observedBoundary':str(e),'status':'passed'})
 else:raise AssertionError('ambiguous-before-accepted')
proposal=[]
for r in rows:
 before=copy.deepcopy(schemas[r['id']]);field=r['pointer'][1:]
 # Replaces actual native decoding/application: use saved source schemas plus exact candidate text readback only.
 before[field]=r['currentValue'];after=copy.deepcopy(before)
 if r['target'] is not None:after[field]=accept_before(before[field],r['source'],r['target'])
 residualBefore={k:v for k,v in before.items() if k!=field};residualAfter={k:v for k,v in after.items() if k!=field}
 require(residualBefore==residualAfter,'native-residual-preservation')
 proposal.append({'id':r['id'],'pointer':r['pointer'],'before':before[field],'after':after[field],'changed':before[field]!=after[field],'residualNativeSha256':uh(json.dumps(residualBefore,sort_keys=True,ensure_ascii=False,separators=(',',':'))),'sourceSchemaSha256':uh(json.dumps(schemas[r['id']],sort_keys=True,ensure_ascii=False,separators=(',',':'))),'boundary':'Saved-source JSON schema mock, candidate text readback substituted. Actual candidate non-text fields, reinsertion and runtime not exercised.'})
baseline=copy.deepcopy(schemas[rows[0]['id']]);bad=copy.deepcopy(baseline);bad['m_fontSize']=999
field=rows[0]['pointer'][1:]
try:require({k:v for k,v in baseline.items() if k!=field}=={k:v for k,v in bad.items() if k!=field},'native-residual-preservation')
except Rejected as e:neg.append({'id':'non-display-native-mutation','expectedBoundary':'native-residual-preservation','observedBoundary':str(e),'status':'passed'})
jl('display-proposal.jsonl',proposal)
require(sum(r['changed'] for r in proposal)==380,'proposal-count')
# Direct author judgments, serialized only after the full bilingual and separate Russian reads.
semantic=[];nativeRows=[];contextRows=[]
retainedNotes={
 'Press [Escape] or Joystick [B] when finished!':'Same completion condition and Escape OR B alternatives in all six UI.Text foreground/glow leaves; all exact current targets retained.',
 'ENTER':'Return key13 action label ВВОД; current binding and prior independent receipt retained. Label is not emitted user input.',
 'DONE':'Done action ГОТОВО retains finish-keyboard meaning; original callback/keycode stays separate from Return.',
 'SHIFT':'Case-toggle label РЕГИСТР; original keycode303/304, cache and Relabel contract retained as separate technical requirements.',
 'You can type your report with a physical keyboard.\nOr use our virtual keyboard. It supports touch and gamepad controls!':'Full physical/virtual keyboard and touch/gamepad instruction retained in exact placeholder binding; placeholder is distinct from entered text.'}
for r in rows:
 if r['target'] is None:
  contextRows.append({'id':r['id'],'source':r['source'],'currentValue':r['currentValue'],'status':r['status'],'target':None,'rationale':r['missingPredicate'] or r['preserveReason'],'readStatus':'full-assigned-source-and-hierarchy-read','semanticPass':False});continue
 note=auth[r['source']][1] if r['status']=='prepared' else retainedNotes[r['source']]
 semantic.append({'id':r['id'],'source':r['source'],'target':r['target'],'sourceValueSha256':r['sourceValueSha256'],'sourceUtf8Sha256':r['sourceUtf8Sha256'],'targetUtf8Sha256':r['targetUtf8Sha256'],'hierarchy':r['hierarchy'],'logicalGroup':r['logicalGroup'],'verdict':'pass-wording-with-technical-gates-pending','rationale':note,'reviewKind':'author-full-context-source-to-target','reviewer':'01a18634-381a-71e1-9143-4ca2d43dd59b','independent':False})
 require(r['source'] in native,'missing-native-read-note')
 nativeRows.append({'id':r['id'],'target':r['target'],'targetUtf8Sha256':r['targetUtf8Sha256'],'verdict':'pass-author-Russian-read','rationale':native[r['source']],'reviewKind':'separate-author-native-Russian-read','independent':False})
jl('author-semantic-audit.jsonl',semantic);jl('native-russian-read.jsonl',nativeRows);jl('context-dispositions.jsonl',contextRows)
require(len(semantic)==len(nativeRows)==392 and len(contextRows)==184,'author-coverage')
jl('ru.final-delta.jsonl',[])
out('findings-and-delta.json',{'objectiveWordingFindings':[],'consolidatedWordingRepairBatch':[],'exactFinalDeltaIds':[],'initialSha256':sha(P/'ru.initial.jsonl'),'finalSha256':sha(P/'ru.prepared.jsonl'),'metadataCorrection':'The author rationale originally described ten LF in the warning; exact source and target both have nine LF. Corrected the rationale only, no target changed.','technicalHolds':91,'holdArtifact':'context-dispositions.jsonl','sourceEqualityIsPermission':False})
fixtures=[]
for name,needle in [('quit','/QuitConfirmation/'),('menu','/StartMenuConfirmation/'),('forfeit','/ForfeitConfirmation/'),('adventure-cancel','/CancelAdventureConfirmation/'),('pause-actions','/PauseMenu/'),('report-complete','/BugReportMenu/'),('settings','/OptionsMenu/'),('cheats-complete','/CheatsMenu/'),('chapter-complete','LevelSingletons/ChapterSelectUI/')]:
 rs=[r for r in rows if needle in r['hierarchy']]
 fixtures.append({'id':name,'selector':{'hierarchyContains':needle},'ids':[r['id'] for r in rs],'rows':[{'id':r['id'],'source':r['source'],'target':r['target'],'status':r['status']} for r in rs],'join':'Parallel layers, separate controls and complete paragraphs; never concatenate flattened rows. Dynamic template output remains held.','runtime':'not-run'})
out('complete-group-fixtures.json',fixtures)
regressions=[
 {'id':'title-not-single-example','predicate':'Seven exact Chapter Select memberships include panel header17682 and six pause button faces; all target Выбор главы.','ids':[r['id'] for r in rows if r['source']=='Chapter Select'],'status':'passed-static'},
 {'id':'complete-sibling-family','predicate':'Each source face/glow family keeps exact membership and has identical complete target in all nonnull siblings;164 logical groups accounted.','status':'passed-static'},
 {'id':'destructive-warnings','predicate':'Quit/menu/forfeit preserve unsaved restriction; cancel-adventure preserves loss and restart later; chapter warning retains four categories and future statement.','status':'passed-author-semantic'},
 {'id':'report-paragraphs','predicate':'Success/empty/cancel/send/disabled/intro instructions remain full units, with website exact and Edit Text callback wording matched.','status':'passed-author-semantic'},
 {'id':'exact-current-retention','predicate':'Twelve current translated input/hint targets remain byte exact against accepted input72 receipts.','status':'passed-static-and-author-applicability'},
 {'id':'display-not-input','predicate':'Keyboard letters, digits, arrows, layout labels, spaces, sentinel and + levels remain exact; no emitted/input/parser/callback keys translated.','status':'passed-static-proposal'},
 {'id':'boolean-not-word-match','predicate':'24 options On/Off faces bind exact controller GO booleans;24 cheat On/Off faces plus48 other cheat-state faces remain null.','status':'passed-static-binding'},
 {'id':'template-not-producer','predicate':'All17 ChapterSelect template/tooltip/debug members remain null, including source-labelled display defaults; two report info columns also null.','status':'passed-static-hold'},
 {'id':'markup-and-styling','predicate':'Stored sprite=0 tags remain unchanged in held templates. All newly prepared faces have style0; no partial-grapheme styling. Full source schema/fonts/sizes preserved in proposal.','status':'passed-static-proposal'},
 {'id':'dynamic-joins-and-activation','predicate':'Actual ChapterRecord title/description setters, hidden template activation/cache and cheat-state restoration need source-owner acceptance; no emitted output is inferred from initial strings.','status':'needs-source'},
 {'id':'layout-font-runtime','predicate':'30pt wrapping title;14pt nonwrapping chapter warning;16pt report instructions and20pt nonwrapping labels require actual Cyrillic font/layout confirmation.','status':'not-run'}]
out('mandatory-regressions.json',regressions)
changed=[r['id'] for r in rows if r['status']=='prepared'];closure=[r['id'] for r in rows if r['target'] is not None];context=[r['id'] for r in rows if r['target'] is None]
for fn,ids in [('changed-ids.txt',changed),('closure-ids.txt',closure),('protected-context-ids.txt',context),('final-delta-ids.txt',[])]: (P/fn).write_text(''.join(x+'\n' for x in ids))
out('review-closure.json',{'cycle':'initial-01','algorithm':'Universal full author semantic -> independent complete initial closure -> correction delta, if any','changedIds':changed,'closureIds':closure,'nontranslatableContextIds':context,'components':{'wholeAssignedPhysicalMemberships':576,'wordingClosure':392,'newBindings':380,'retainedExactBindings':12,'preserveExactly':93,'needsSource':91},'selectorRecipe':'prepare.py group() reconciles exact immutable576 source IDs; validate_and_handoff.py selects ALL nonnull targets for first independent closure and ALL remaining members as separate context. No keyword-only pruning.','evidenceInvalidated':[],'previousClosure':None,'exactFinalDelta':[],'mandatoryRegressions':'mandatory-regressions.json','independentReview':'pending','frozenInputs':{'ru.prepared.jsonl':sha(P/'ru.prepared.jsonl'),'source-context.jsonl':sha(P/'source-context.jsonl'),'semantic-groups.jsonl':sha(P/'semantic-groups.jsonl')},'lists':{fn:{'count':n,'sha256':sha(P/fn),'newline':'UTF-8 LF; final LF iff nonempty'} for fn,n in [('changed-ids.txt',380),('closure-ids.txt',392),('protected-context-ids.txt',184),('final-delta-ids.txt',0)]}})
out('deterministic-preflight.json',{'status':'passed','positiveControl':{'assigned':576,'targets':392,'newChanges':380,'retained':12,'protected':93,'sourceHolds':91},'negativeControls':neg,'negativeCount':len(neg),'boundary':'Authored mapping, exact saved-source schemas, current physical text readback, sibling/token/contract selection and preservation. Replaces native candidate decoding/reinsertion/runtime; no actual game or build verified.','nativeResiduals':576,'actualGameRuntime':'not-run'})
preserve=[]
for path,expected in pins.items():
 q=pathlib.Path(path) if path.startswith('/') else ROOT/path
 require(sha(q)==expected,('input-changed',path));preserve.append({'path':path,'sha256':expected,'unchanged':True})
out('preservation-proof.json',{'status':'passed','pinnedInputs':len(preserve),'inputs':preserve,'frozenRussianDialogue':{'path':'localization/ru-assets/dialogue.ru.jsonl','sha256':sha(ROOT/'localization/ru-assets/dialogue.ru.jsonl'),'rows':12246,'contentRead':'hash/count only'},'writes':['localization/supplemental-ui/20261029-pause-chapter-case576/','outputs/ru-pause-chapter576-case-wording-20261029/'],'rootDocsWritten':False,'gitMutations':False,'nativeAssetsWritten':False,'targetApplied':False,'concurrentLaneBoundary':'Only own allowed paths written. Other lanes remain active; no repository-wide unchanged claim.'})
checklist=[
 {'artifact':'ru.prepared.jsonl','predicate':'Every selected576 membership has exact source/current binding and target or explicit null disposition','evidence':'576/576 mapped; deterministic-preflight.json','uncertainty':'Independent wording acceptance pending','nextPermittedAction':'Parent arranges fresh independent review of392 closure plus184 context'},
 {'artifact':'controller-contracts.json + settings-boolean-bindings.json','predicate':'On/Off are display faces, not boolean identities','evidence':'Exact controller18627 GO ancestry and existing OptionsMenu CIL for24 settings faces','uncertainty':'72 cheat status/action faces lack full chooser/cache/identity contract','nextPermittedAction':'Owning technical lane resolves named cheat face predicate; preserve every held value meanwhile'},
 {'artifact':'context-dispositions.jsonl','predicate':'Chapter template/tooltip/debug defaults distinguished from live producer output','evidence':'17 saved members held, complete direct hierarchy and source controller17041 retained','uncertainty':'Initial activation/default-cache/restoration and empty-list placeholder behavior','nextPermittedAction':'Owning source lane accepts exact default/producer contracts; no automatic extra extraction'},
 {'artifact':'context-dispositions.jsonl','predicate':'Report info columns are separated from submitted system payload','evidence':'Two exact column values held; report instructions and + levels separately accounted','uncertainty':'Column overwrite/default and payload/display split','nextPermittedAction':'Owning source lane resolves exact report column producer contract'},
 {'artifact':'reused-receipts.json','predicate':'12 current translated bindings preserve accepted wording and physical identity','evidence':'Version-matching input72 independent semantic/native receipts and new full-context read','uncertainty':'Prior receipts do not establish new build runtime','nextPermittedAction':'Retain exact targets during any parent application'},
 {'artifact':'mandatory-regressions.json','predicate':'Final rendered glyphs, wrapping, joins and control behavior','evidence':'Static source sizes/styles only; no resources changed','uncertainty':'Actual game font/layout/activation and report keyboard paths not run','nextPermittedAction':'Parent uses applicable separate runtime authorization after source/editorial/resource gates'},
 {'artifact':'review-closure.json','predicate':'Immutable complete independent initial closure and exact later deltas','evidence':'380 changed IDs,392 closure IDs,184 separate context IDs; delta0','uncertainty':'No independent review performed by author','nextPermittedAction':'Independent reviewer reads full closure and required context; collect findings before one consolidated repair batch'}]
out('acceptance-checklist.json',checklist)
refs=['/Users/antonkrutov/.codex/instructions/sitefor-mods.md','/Users/antonkrutov/.codex/instructions/game-localization-prompt.md','/Users/antonkrutov/.codex/instructions/game-localization-audit-workflow.md','/Users/antonkrutov/.codex/skills/vn-game-localize/SKILL.md']
refs += [str(pathlib.Path('/Users/antonkrutov/.codex/skills/vn-game-localize/references')/(n+'.md')) for n in ['COMMON','WORKFLOW','CHECKPOINT','SPECIAL-SCENES','CHARACTERS','HANDOFF']]
refs += ['/Users/antonkrutov/Desktop/SiteForMods/tools/codex-skills/shared/'+n+'.md' for n in ['CHECKPOINT','ROUTING']]
out('process-binding.json',{'game':'The Forest of Love','version':'0.45','sourceLocale':'en','locale':'ru','type':'standard','stage':'translate-edit: bounded special-case missing-binding preparation','existingProjectBinding':'README.md:1300; reused, no root checkpoint writes','model':'gpt-6.1-sol','reasoning':'high','provider':'openai','sessionId':'01a18634-381a-71e1-9143-4ca2d43dd59b','runtimeVerifiedBeforeLocalizedContent':True,'inheritedHistory':False,'nestedJobs':0,'references':{p:sha(p) for p in refs},'ordinaryTranslationEntryAllowed':False,'sourceGateAccepted':False})
out('coverage-read-evidence.json',{'reader':'01a18634-381a-71e1-9143-4ca2d43dd59b','fullGlossaryEntriesRead':171,'fullAssignedSourceBindingsRead':576,'logicalGroupsRead':164,'bilingualTargetMembershipsRead':392,'separateRussianTargetMembershipsRead':392,'distinctTargetSourceGroups':len({r['source'] for r in rows if r['target'] is not None}),'unreadAssignedIds':[],'unresolvedConsumerPredicates':'Exact91 per-ID holds in context-dispositions.jsonl; read source values are not accepted live contracts','contextReadMethod':'Complete grouped values, all physical IDs/hierarchies and stored style signatures read in two bounded group tables (groups001-082 and083-164); full source paragraphs before authorship and separate target-only Russian read afterward. Existing saved source schemas selected for576. No screenshots.','independentCredit':False,'newSourceExtraction':False,'pins':{'source-context.jsonl':sha(P/'source-context.jsonl'),'ru.prepared.jsonl':sha(P/'ru.prepared.jsonl'),'author-semantic-audit.jsonl':sha(P/'author-semantic-audit.jsonl'),'native-russian-read.jsonl':sha(P/'native-russian-read.jsonl')}})
result={'status':'finite-russian-pause-chapter576-wording-handoff-complete-with-source-holds','game':'The Forest of Love','version':'0.45','locale':'ru','assigned':576,'prepared':380,'retainedExactCurrentBindings':12,'protectedExactValues':93,'needsSource':91,'authorSourceToTargetRead':392,'authorSeparateRussianRead':392,'newIndependentReview':0,'independentReview':'pending','targetApplied':False,'actualGameRuntime':'not-run','ordinaryTranslationEntryAllowed':False,'sourceGateAccepted':False,'wholeGameAccepted':False,'fontResources':'not-run','build':'not-run','visual':'not-run','publication':'not-run','nestedJobs':0,'model':'gpt-6.1-sol','reasoning':'high','provider':'openai','deterministicPreflight':'passed','negativeControls':len(neg),'objectiveWordingFindings':0,'exactFinalDelta':0,'unreadAssignedIds':[],'nextPermittedAction':'Parent-owned independent review and source-hold reconciliation; no automatic next phase, application or build from this worker.','packetPath':str(P),'targetSha256':sha(P/'ru.prepared.jsonl'),'usage':'Measured session telemetry separately, with cutoff and reporting tail.'}
out('Result.json',result)
(P/'HANDOFF.md').write_text('''The finite Russian Pause/Chapter576 wording packet is prepared and remains unapplied. All576 physical memberships are mapped:380 newly prepared targets,12 exact current accepted targets,93 preserved values,91 explicit source-contract holds. This is a bounded special-case handoff, not complete Russian-build acceptance.

The Chapter Select panel header sharedassets2.assets:17682/m_text and all six pause-button faces use Выбор главы. Full report paragraphs, confirmations, cancellation consequences, settings, cheat headings and the complete chapter warning are included. Semantic groups retain every sibling and full field replacement; they are parallel render layers, not concatenated fragments.

The author read all392 nonnull source/target memberships in full context and separately read all392 Russian targets. Twelve retained bindings have exact version-matching independent input72 receipts and newly read applicability. Same-English935 wording is evidence only; zero935 physical bindings are reused as accepted new bindings. No objective wording repair was needed; initial and final target bytes are identical. Independent review remains pending on the complete392-ID initial closure plus184 separate protected/held context memberships and mandatory regressions.

The91 holds are72 cheat activation/status faces,17 ChapterSelect template/tooltip/debug defaults and2 report-info columns. Each has target=null and an exact missing consumer predicate. Known ChapterRecord title/description output does not establish stored-default restoration or activation. Settings On/Off are separately bound through exact controller18627 GO booleans for24 display faces. No original GO names, fields, parser keys, callbacks, emitted/entered values, + levels, URLs, symbols or placeholders are changed.

Static preflight and intended-boundary negative controls pass. The576-row display proposal uses saved source JSON schemas with candidate text readback substituted; this is an explicit mock boundary, not actual candidate decoding, reinsertion or runtime. All pinned source/glossary/accepted targets and frozen12246 Russian dialogue remain unchanged. Fixed-size/nonwrapping strings and the30pt panel title still require actual font/layout checks after the owning gates.

Only this packet and its outputs directory were written. No source inventory, code, case registry, root README/CHECKPOINT, Git/index, game, GUI, images, runtime, fonts, textures, installer, site, server or publication work occurred. Parent owns independent review, application and canonical integration. This worker stops here.
''')
recipe={f:sha(P/f) for f in ['prepare.py','validate_and_handoff.py','wording.authored.json','native-read.authored.json']};out('recipe-pins.json',recipe)
out('output-hashes.json',{f.name:sha(f) for f in sorted(P.iterdir()) if f.is_file() and f.name!='output-hashes.json'})
O.mkdir(exist_ok=True);(O/'Result.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({'status':result['status'],'assigned':576,'nonnull':392,'holds':91,'protected':93,'negativeControls':len(neg),'pinnedInputsPreserved':len(preserve),'targetSha256':result['targetSha256']},ensure_ascii=False))
