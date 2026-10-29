"""Bind directly authored independent judgments and check their exact static inputs.
No model calls, translation generation, target application, or writes outside this folder.
"""
from pathlib import Path
import json, hashlib, datetime, copy
ROOT=Path('/Users/antonkrutov/Desktop/Forest')
P=ROOT/'localization/supplemental-ui/20261029-counter-case90'
OUT=P/'independent-review-01'
SESSION=Path('/Users/antonkrutov/.codex/sessions/2026/10/29/rollout-2026-10-29T11-55-45-01a18603-98d8-7e62-9b84-872a6738ab48.jsonl')
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def digest(v):return hashlib.sha256(json.dumps(v,ensure_ascii=False,sort_keys=True,separators=(',',':')).encode()).hexdigest()
def load(n):return json.loads((P/n).read_text())
def rows(n):return list(map(json.loads,(P/n).read_text().splitlines()))
def write(n,x):
 (OUT/n).write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n')
def jl(n,x):
 (OUT/n).write_text(''.join(json.dumps(v,ensure_ascii=False,separators=(',',':'))+'\n' for v in x))
NOW=datetime.datetime.now(datetime.timezone.utc).isoformat()
meta=turn=None
usage=None
reported_baseline=None
for line in SESSION.open():
 r=json.loads(line)
 if r.get('type')=='session_meta' and meta is None:meta=r
 if r.get('type')=='turn_context' and turn is None:turn=r
 if r.get('type')=='event_msg' and r.get('payload',{}).get('type')=='token_count':
  usage={'cutoff':r['timestamp'],'usage':r['payload']['info']['total_token_usage']}
  if r['timestamp']=='2026-10-29T05:00:57.025Z':reported_baseline=copy.deepcopy(usage)
assert meta['payload']['model_provider']=='openai'
assert turn['payload']['model']=='gpt-6.1-sol' and turn['payload']['effort']=='high'
write('runtime-verification.json',{'verified':True,'model':'gpt-6.1-sol','reasoning':'high','provider':'openai','threadId':meta['payload']['id'],'agent':'/root/counter90_independent','evidencePath':str(SESSION),'evidenceRecords':{'sessionMetaTimestamp':meta['timestamp'],'turnContextTimestamp':turn['timestamp'],'provider':meta['payload']['model_provider'],'model':turn['payload']['model'],'effort':turn['payload']['effort']},'verificationBeforeLocalizedContent':True,'noInheritedHistory':'Explicit fork_turns=none assignment; fresh subagent session, no parent transcript supplied','nestedAgentsOrJobs':False,'AstraUsed':False,'actualGameRuntime':'not-run'})
parent=ROOT/'outputs/chat-resume-20261029-1152/ru-counter90-case-wording-20261029-pins.json'
pinsets={'parent':json.loads(parent.read_text()),'input':load('input-pins.json'),'recipe':load('recipe-pins.json'),'processReferences':load('process-binding.json')['references']}
for k in ['runtimeEvidence','outputs']:pinsets[k]=load('input-output-pins.json')[k]
checks=[]
for group,pins in pinsets.items():
 for path,expected in pins.items():
  f=Path(path) if Path(path).is_absolute() else ROOT/path
  actual=sha(f) if f.exists() else None
  checks.append({'set':group,'path':path,'expected':expected,'actual':actual,'match':actual==expected})
assert all(x['match'] for x in checks)
write('pin-verification.json',{'checkedAt':NOW,'manifest':str(parent),'manifestSha256':sha(parent),'pinSetCounts':{k:len(v) for k,v in pinsets.items()},'allMatch':True,'checks':checks})
src=rows('source-context.jsonl');mp=rows('mapping.jsonl');target=rows('ru.prepared.jsonl');styles=rows('physical-style-preserve.jsonl');stored=rows('assembled-stored-fixtures.jsonl');fixtures=rows('assembled-producer-fixtures.jsonl');producers=rows('selected-complete-producers.jsonl');cl=load('review-closure.json');m={r['id']:r for r in mp};s={r['id']:r for r in src};t={r['id']:r for r in target};sty={r['id']:r for r in styles}
# These per-ID judgments were authored after the full contextual comparison and separate Russian read.
SEM={
'level23:742/m_Text':'Hitcount (3): preserves the hit counter label and zero; the full stored caption matches the accepted prefix plus unchanged value.',
'level23:744/m_Text':'Main Hitcount: the Russian plural noun names the counted event; colon, following space, and ASCII zero are retained.',
'level23:770/m_Text':'Dormant debug ClipName stores the same hit caption; its stored meaning is faithfully translated without asserting that the debug field receives the live counter.',
'level23:838/m_Text':'Hitcount (1): preserves the same counted event and initial zero as the other visual layers; no actor or score increase is added.',
'level23:845/m_Text':'Hitcount (2): matches the accepted prefix and complete zero assembly; no reinterpretation as attacks performed or successful dodges.',
'level23:874/m_Text':'Hitcount (4): the complete Russian caption retains source quantity and agrees with the five other stored counterparts, including the separately held debug field.',
'sharedassets4.assets:28447/m_Text':'TimerGlowLeft: Time becomes Время without adding seconds, remaining time, countdown direction, or a maximum; the three spaces and 999 remain.',
'sharedassets4.assets:29602/m_Text':'TimerGlowRight: the time label retains its generic scope and exact numeric/spatial payload, matching its left overlay.',
'sharedassets4.assets:32690/m_Text':'TimerGlowTop: the caption conveys the timer category with no unsupported units or tense, retaining 999 and its separator.',
'sharedassets4.assets:34911/m_Text':'Timer base: natural Russian time label preserves the full stored assembly and does not claim a relationship to an unread dynamic writer.',
'sharedassets4.assets:35330/m_Text':'TimerGlowBottom: matches the complete timer wording on all other layers; initial inactivity is retained as context, not used to omit translation.',
'sharedassets4.assets:35830/m_Text':'Dashes base: Рывки is the normal plural of approved tfol-061 Рывок for the movement ability; the spaced stars remain unchanged.',
'sharedassets4.assets:35831/m_Text':'DashesGlowTop: names the same movement ability without changing stars into counts or inferring maximum/availability.',
'sharedassets4.assets:35832/m_Text':'DashesGlowBottom: uses the approved movement term and preserves two separator spaces and all star separators.',
'sharedassets4.assets:35835/m_Text':'DashesGlowRight: matches the base and other overlays; no extra charges, cost, or recharge explanation is introduced.',
'sharedassets4.assets:35839/m_Text':'DashesGlowLeft: plural Рывки faithfully labels the ability represented by the unchanged star payload; no star algorithm is invented.'}
NATIVE={
'level23:742/m_Text':'Попадания: 0 reads as a concise count label; the noun stands independently before the value.',
'level23:744/m_Text':'Natural UI caption: plural Попадания plus colon requires no numeral-driven ending.',
'level23:770/m_Text':'The stored Russian phrase is grammatical even in the dormant debug component; visibility and binding remain technical holds.',
'level23:838/m_Text':'The caption is clear and idiomatic without needing a subject or gendered verb.',
'level23:845/m_Text':'The zero value follows a natural invariant category label; no agreement problem.',
'level23:874/m_Text':'The full hit caption reads consistently with the parallel stored layers.',
'sharedassets4.assets:28447/m_Text':'Время is the ordinary Russian UI time heading; the preserved spacing separates it from 999.',
'sharedassets4.assets:29602/m_Text':'The standalone Russian time caption is concise and grammatical.',
'sharedassets4.assets:32690/m_Text':'The numeric timer caption needs no Russian unit or plural suffix to read naturally.',
'sharedassets4.assets:34911/m_Text':'Время   999 is a natural label-value form; adding a colon would be a taste change and alter protected spacing.',
'sharedassets4.assets:35330/m_Text':'The bottom-layer wording reads the same as the other timer layers; no grammatical issue.',
'sharedassets4.assets:35830/m_Text':'Рывки is the idiomatic plural label for the named movement ability.',
'sharedassets4.assets:35831/m_Text':'The plural ability heading reads naturally before the unchanged graphical star payload.',
'sharedassets4.assets:35832/m_Text':'The star-bearing Russian caption is clear without declension against a guessed numeric value.',
'sharedassets4.assets:35835/m_Text':'The movement label has the expected Russian form and register for a compact game HUD.',
'sharedassets4.assets:35839/m_Text':'The full Рывки  * * * caption is grammatical and consistent across overlays.'}
assert list(SEM)==cl['closureIds'] and list(NATIVE)==cl['closureIds']
sem=[];nat=[]
for k in cl['closureIds']:
 common={'id':k,'source':s[k]['source'],'target':t[k]['target'],'sourceValueSha256':s[k]['sourceValueSha256'],'targetUtf8Sha256':hashlib.sha256(t[k]['target'].encode()).hexdigest(),'sourceContextRowSha256':digest(s[k]),'physicalStyleRowSha256':digest(sty[k]),'reviewer':'/root/counter90_independent','newSemanticUnit':True,'targetApplied':False}
 sem.append({**common,'status':'pass-stored-wording','judgment':SEM[k],'producerAcceptance':'held; no dynamic source acceptance'})
 nat.append({**common,'status':'pass-natural-russian','separateRead':True,'judgment':NATIVE[k],'visualReadability':'not-run'})
jl('semantic-receipts.jsonl',sem);jl('natural-russian-receipts.jsonl',nat)
FIX={
'hits-zero':'Complete zero label retains accepted prefix and source value.',
'hits-one':'Label-plus-value remains natural at one without declining the category heading.',
'hits-two':'The complete count caption remains natural at two.',
'hits-five':'Five changes only the protected value; heading remains natural.',
'hits-twenty-one':'Twenty-one does not require changing an independent noun label.',
'hits-int32-limit':'Decimal representation boundary is correctly separated from an actual game maximum.',
'hits-game-maximum':'No maximum invented; null source/target and exact KO-bound predicate retained.',
'hits-paused':'Early return precedes counter assignment; retaining the previous full Russian caption is consistent.',
'wood-zero':'0/24 matches the saved denominator and false completion with unset trigger.',
'wood-one':'1/24 preserves the counter-only output.',
'wood-below':'23/24 is below threshold with no existing trigger.',
'wood-threshold':'24/24 reaches the completion threshold.',
'wood-above':'25/24 preserves an above-threshold input without clamping or altering the denominator.',
'wood-trigger-at-zero':'0/24 and true completion are compatible because the existing trigger is tested below threshold.',
'pages-zero':'0/7, any=false, and no selected-body callback are consistent.',
'pages-one':'1/7 selects first-page callback without reaching completion.',
'pages-below':'6/7 leaves completion false and any true.',
'pages-threshold':'7/7 selects all-pages callback and exact trigger.',
'pages-above':'8/7 preserves the source above-threshold behavior and exact trigger.',
'wool-zero':'0/8 stays below completion.',
'wool-one':'1/8 stays below completion; stored defaults are separate occurrences.',
'wool-below':'7/8 correctly remains below eight.',
'wool-threshold':'8/8 reaches completion and preserves trigger and quest-log identity.',
'wool-above':'9/8 retains the above-threshold output without a guessed clamp.',
'vial-normalized-zero':'Whole 0 and separate .0% match the synthetic endpoint; no locale comma substituted.',
'vial-one-percent':'Whole 1 plus .0% is a future CLR/Single assertion, explicitly not proof from Python arithmetic.',
'vial-normalized-one':'Whole 100 plus .0% describes a synthetic normalized endpoint, not a proven game maximum.',
'vial-game-maximum':'Null output correctly preserves range, Single precision and independent rounding-carry uncertainty.',
'timer-zero':'Null output is required: no writer-derived zero caption exists in selected evidence.',
'timer-one':'No units or assembly invented for numeric input one.',
'timer-maximum':'Stored 999 does not establish the actual dynamic start or maximum; all-layer comparison remains held.',
'dashes-zero':'No blank, zero or hyphen rendering is fabricated for zero dashes.',
'dashes-one':'One input does not prove one star; output remains null.',
'dashes-maximum':'Three stored stars do not establish the maximum or writer algorithm.',
'gallery-zero':'Empty/first index convention and total remain unproven by setter bodies.',
'gallery-one':'An index of one does not establish the complete helper phrase or indexing convention.',
'gallery-maximum':'Movie/story last selection and actual totals remain explicit source holds.'}
assert set(FIX)=={r['fixtureId'] for r in fixtures}
frec=[]
for r in fixtures:
 frec.append({'fixtureId':r['fixtureId'],'fixtureRowSha256':digest(r),'producer':r['producer'],'input':r['input'],'source':r['source'],'target':r['target'],'membershipIds':r['membershipIds'],'status':'needs-source-retained' if r['target'] is None else 'consistent-static-assertion','judgment':FIX[r['fixtureId']],'actualGameRuntime':'not-run'})
jl('producer-fixture-review.jsonl',frec)
# Context receipt is distinct from the 16 model semantic judgments above.
context=[]
for r in src:
 k=r['id'];q=m[k]
 context.append({'id':k,'ordinal':r['ordinal'],'source':r['source'],'target':q['target'],'role':r['currentRole'],'category':q['category'],'sourceContextRowSha256':digest(r),'mappingRowSha256':digest(q),'read':True,'semanticReceipt': 'semantic-receipts.jsonl' if k in SEM else None,'retainedReceipt':q['reusedEvidence'] if q['category']=='reused' else None,'protectedNonSemanticContext':q['category']=='protected','physicalStyleRowSha256':digest(sty[k]) if k in sty else None,'boundary':'Stored source, complete selected hierarchy/activation/peers and physical fields read; IL members include immediate consumer windows. Dynamic holds remain separate.'})
jl('context-coverage.jsonl',context)
jl('stored-fixture-review.jsonl',[{'fixtureId':r['fixtureId'],'ids':r['ids'],'fixtureRowSha256':digest(r),'source':r['source'],'target':r['target'],'read':True,'disposition':m[r['ids'][0]]['category'],'semanticReceipt':r['ids'][0] if r['ids'][0] in SEM else None,'protectedNonSemanticContext':m[r['ids'][0]]['category']=='protected','actualGameRuntime':'not-run'} for r in stored])
holds=[{'fixtureId':r['fixtureId'],'producer':r['producer'],'predicate':r['predicate'],'status':'needs-source','target':None,'nextPermittedAction':'Source owner supplies the exact existing writer/binding/range evidence for this named predicate; preserve null until accepted.'} for r in fixtures if r['target'] is None]
write('source-holds.json',{'nullProducerFixtures':holds,'nullCount':len(holds),'additionalNamedFamilyHolds':[x for x in load('acceptance-checklist.json') if x['status']=='needs-source'],'allHoldsRetained':True,'newSourceResearchPerformed':False,'sourceGateAccepted':False})
write('context-assessment.json',{'status':'adequate-for-complete-bounded-stored-wording-review','selectedContextRead':True,'newSemanticIds':16,'requiredContextIds':90,'protectedContextIds':61,'retainedExactIds':13,'storedFixtures':90,'producerFixtures':37,'completeProducerBodies':7,'completeProducerInstructionCount':sum(len(r['instructions']) for r in producers),'physicalStyleRecords':75,'unreadAssignedIds':[],'unreadSelectedContextIds':[],'unreadSelectedProducerBodies':[],'missingPredicates':'The named source holds were read and remain unresolved; adequacy here covers stored captions and static contract assertions only, not complete dynamic source acceptance.','selectorRepairRequiredForBoundedWording':False,'reproducibleFutureSourceSelectorProposal':{'rule':'Keep the exact assigned 90-ID snapshot and category=new closure. Add context append-only by named predicate, not broad regex or new semantic IDs.','timerAndDashes':'Once source owner provides existing exact UpdateAnimators/writer or no-writer disposition, select full method body by exact method signature and bind its field/component references to timerContainer/dashesContainer and all stored layers, including numeric/symbol-only roots; pin type/format/bounds/exposure.','gallery':'Select full caller(s) that construct the String passed to exact SetMovieSelectionText/SetStorySelectionText; bind index/total and object roots to all twelve IDs.','hits':'Select exact serialized hitCounterLabelContainer reference and separate debug ClipName binding plus route-specific hit-count/KO bound evidence.','vialClenchInventory':'Select exact cumPercent range and independent clench/inventory writer bindings; do not transfer vial contracts by text similarity.','acceptance':'Resolve named predicate before filling its null fixture; regenerate context and affected delta reproducibly. No source extraction or model requests authorized by this proposal.'}})
# Deterministic checks below validate correspondence, not reviewer judgment.
assigned=list(map(json.loads,(ROOT/'outputs/ru-counter90-case-wording-20261029/check/assigned.jsonl').read_text().splitlines()))
assert len(src)==len(mp)==len(stored)==len(assigned)==90
assert len({r['id'] for r in src})==len({r['id'] for r in mp})==90
assert [r['id'] for r in src]==[r['id'] for r in mp]==[r['bindingId'] for r in assigned]
assert cl['requiredContextIds']==[r['id'] for r in src]
assert set(cl['protectedComponentIds'])=={r['id'] for r in mp if r['category']=='protected'}
assert set(cl['retainedExactAcceptedIds'])=={r['id'] for r in mp if r['category']=='reused'}
assert len(sem)==len(nat)==16 and len(t)==29 and len(styles)==75 and len(fixtures)==37 and len(holds)==11
assert {r['id'] for r in mp if r['category']=='new'}==set(SEM)
assert load('ru.authored.json')['targets']=={k:t[k]['target'] for k in SEM}
for a,r in zip(assigned,src):
 assert a['source']==r['source']==m[r['id']]['source'] and a['sourceValueSha256']==r['sourceValueSha256']
 assert a['currentRole']==r['currentRole']==m[r['id']]['role']
for r in target:
 assert r['source']==s[r['id']]['source'] and r['target']==m[r['id']]['target']
 assert hashlib.sha256(r['target'].encode()).hexdigest()==r['targetUtf8Sha256']
for r in mp:
 if r['category']=='protected':assert r['source']==r['target']
 if r['category']=='reused':
  for ref in r['reusedEvidence']:
   if 'target' in ref:
    f=ref['target'];prior=json.loads((ROOT/f['path']).read_text().splitlines()[f['line']-1]);assert prior['id']==f['targetId']==r['id']
   else:
    candidates=[x for x in map(json.loads,(ROOT/ref['path']).read_text().splitlines()) if x['id']==ref['id']]
    assert len(candidates)==1
    prior=candidates[0];assert prior['id']==r['id']
   assert prior['source']==r['source'] and prior['target']==r['target']
for r in styles:
 k=r['id'];tree=json.loads((ROOT/s[k]['treePath']).read_text());field=k.split('/')[-1]
 assert tree[field]==s[k]['source']
 assert {a:b for a,b in tree.items() if a!=field}==r['protectedNonTextFields']
 assert sha(ROOT/s[k]['treePath'])==r['originalTreeSha256']
for r in stored:
 assert len(r['ids'])==1;k=r['ids'][0];assert r['source']==m[k]['source'] and r['target']==m[k]['target']
for r in fixtures:
 assert set(r['membershipIds'])<=set(m)
 if r['target'] is None:assert r['status']=='needs-source' and r['predicate']
 elif r['producer']=='hits':
  if r['input'].get('paused'):assert r['target']==r['input']['previousText'] and r['source'] is None
  else:assert r['target']=='Попадания: '+str(r['input']['hitCountCurrent']) and r['source']=='Hits: '+str(r['input']['hitCountCurrent'])
 elif r['producer'] in ['wood','pages','wool']:
  den,field={'wood':(24,'currentWoodCount'),'pages':(7,'currentPageCount'),'wool':(8,'currentWoolCount')}[r['producer']];n=r['input'][field]
  assert r['source']==r['target']==str(n)+'/'+str(den)
  assert r['complete']==(n>=den or (r['producer']=='wood' and r['input']['triggerAlreadySet']))
 elif r['producer']=='vial':assert r['source']==r['target'] # Exact CLR Single formatting remains unrun.
for r in target:
 if r['id'] in SEM:
  if r['source']=='Time   999':assert r['target']=='Время   999'
  elif r['source']=='Dashes  * * *':assert r['target']=='Рывки  * * *'
  else:assert r['source']=='Hits: 0' and r['target']=='Попадания: 0'
write('deterministic-check.json',{'passed':True,'checkCode':str(OUT/'review.py'),'counts':{'memberships':90,'newSemanticReceipts':16,'newNaturalReadReceipts':16,'displayUnits':29,'retainedExactReceipts':13,'protectedNonSemanticContext':61,'physicalStyleRecords':75,'storedFixtures':90,'producerFixtures':37,'nullSourceHolds':11,'completeProducerBodies':7},'pinSetCounts':{k:len(v) for k,v in pinsets.items()},'checks':['all pinned files byte-exact','ordered identity/multiplicity and closure membership','authored/prepared/mapping target correspondence','complete protected-value equality','exact source/target/acceptance version reuse','all original tree nontext fields exact','all stored fixture assemblies exact','static label-plus-value and fraction assertions','every null fixture retains named source predicate'],'boundary':'Python verifies static correspondence and selected source-contract arithmetic; no semantic judgment generated, no CLR Single formatting, Unity routing, activation, rendering, or actual game execution.'})
write('findings.json',{'status':'complete-clean-bounded-wording-review','objectiveWordingFindings':[],'proposedFullReplacements':[],'repairDependencies':[],'exactWordingDeltaIds':[],'sourceHolds':'source-holds.json','noTasteRewrites':True,'completeScopeRead':True,'targetApplied':False})
readfiles=['HANDOFF.md','review-closure.json','process-binding.json','source-context.jsonl','mapping.jsonl','protected-controls.jsonl','physical-style-preserve.jsonl','ru.authored.json','ru.prepared.jsonl','selected-complete-producers.jsonl','assembled-stored-fixtures.jsonl','assembled-producer-fixtures.jsonl','case-solutions.json','acceptance-checklist.json','reused-receipts.json','deterministic-preflight.final.json','fixture-validation.jsonl','preflight-negative-controls.jsonl']
readpin={str(P/n):sha(P/n) for n in readfiles}
for n in ['en.json','ru.json','handoff.json']:
 f=ROOT/'localization/glossary/inventory-display-20261028'/n;readpin[str(f)]=sha(f)
for n in ['plant-label-producer.il','minigame-labels.il']:
 f=ROOT/'localization/source/shared-source-completion-20261028/admission-v1/phase134'/n;readpin[str(f)]=sha(f)
write('read-coverage.json',{'reviewer':'/root/counter90_independent','model':'gpt-6.1-sol','reasoning':'high','provider':'openai','newSemanticIds':cl['closureIds'],'separateNaturalReadIds':cl['closureIds'],'allContextIds':cl['requiredContextIds'],'protectedNonSemanticIds':cl['protectedComponentIds'],'retainedExactIds':cl['retainedExactAcceptedIds'],'producerMethods':[{'line':r['line'],'method':r['method'],'instructionsRead':len(r['instructions']),'rowSha256':digest(r)} for r in producers],'glossaryEntriesRead':171,'sourceAndTargetGlossaryFieldsRead':['term','meaning'],'fullGlossaryHandoffRead':True,'allStoredFixturesRead':90,'allProducerFixturesRead':37,'physicalStyleRecordsRead':75,'readRepresentation':'Compact source/target and hierarchy/activation/peer projection; source IL immediate windows; full producer instructions; physical fields losslessly represented as two complete bases plus all 75 per-ID deltas; full stored/producer assemblies. Hash/ledger identity checked mechanically. Truncated initial outputs repaired with bounded explicit reads.','unreadAssignedContent':[],'unavailableDynamicEvidence':'source-holds.json','fileHashes':readpin})
assert reported_baseline is not None
assert {k:reported_baseline['usage'][k] for k in ['input_tokens','cached_input_tokens','output_tokens','total_tokens']}=={'input_tokens':2486848,'cached_input_tokens':2322816,'output_tokens':15117,'total_tokens':2501965}
write('usage-at-cutoff.json',{'agent':'/root/counter90_independent','threadId':meta['payload']['id'],'model':'gpt-6.1-sol','reasoning':'high','provider':'openai','measurement':usage,'alreadyReportedByParent':reported_baseline,'laterNonoverlappingDelta':{k:v-reported_baseline['usage'][k] for k,v in usage['usage'].items()},'category':'Entire independent-review worker session including the initial failed checker attempt and its repair; no descendants','subsets':'Cached input is included in input; reasoning output is included in output; do not add twice. Parent must add only laterNonoverlappingDelta to its already-reported baseline.','coordinatorOrchestration':'Parent owns separate accounting; unavailable in this worker.','unmeasuredTail':'Subsequent report writing, validation, messages and final response after this cutoff plus platform overhead are not included.'})
result={'status':'complete-clean-independent-stored-wording-review','game':'The Forest of Love','version':'0.45','locale':'ru','completeScopeRead':True,'reviewer':'/root/counter90_independent','model':'gpt-6.1-sol','reasoning':'high','provider':'openai','coverage':{'newSemanticIds':16,'separateNaturalReadIds':16,'memberships':90,'displayUnits':29,'retainedExactAcceptedIds':13,'protectedNonSemanticContext':61,'physicalStyleRecords':75,'storedFixtures':90,'producerFixtures':37,'completeProducerBodies':7,'nullProducerSourceHolds':11,'glossaryEntries':171,'unreadAssignedIds':[]},'objectiveWordingFindings':0,'proposedFullReplacements':0,'exactFinalDeltaIds':[],'boundedStoredWordingVerdict':'pass; parent owns acceptance/integration','contextAdequacy':'adequate for bounded stored-wording review; all named dynamic holds remain','targetApplied':False,'actualGameRuntime':'not-run','visual':'not-run','ordinaryTranslationEntryAllowed':False,'sourceGateAccepted':False,'wholeGameAccepted':False,'noNestedJobs':True,'writesRestrictedTo':str(OUT),'nextPermittedAction':'Parent reconcile complete independent receipts and source holds on unchanged pins; do not promote dynamic/source/runtime gates. This finite assignment ends here.','usage':'usage-at-cutoff.json'}
write('Result.json',result)
(OUT/'HANDOFF.md').write_text('''# Independent Russian counter90 review\n\nComplete, clean review of all 16 new stored-wording IDs and a separate natural Russian read. No objective wording findings, replacement proposals, or wording delta. Exact 13 accepted receipts remain scoped to their original IDs.\n\nAll 90 memberships, 29 display units, 61 protected context members, 75 physical-style records, seven complete producer bodies, 90 stored fixtures and 37 producer fixtures were read/accounted. Protected members are context, not invented semantic IDs. The full 171-entry English/Russian glossary and handoff were read. See `read-coverage.json` and per-ID receipts.\n\nAll parent/nested pins match. `python3 -B localization/supplemental-ui/20261029-counter-case90/independent-review-01/review.py` checks exact static correspondence and rewrites only this review folder. It binds the directly authored judgments; it does not generate wording or prove runtime behavior. `deterministic-check.json` lists boundaries. Individual report writes are not a multi-file transaction.\n\nEleven null producer targets remain named source holds. Timer/dash writers and star rule, gallery index/total construction, hit/debug binding and actual bounds, vial range/Single carry, and independent clench/inventory writers remain unaccepted. Selected context is adequate for stored wording; it does not establish dynamic source completeness. `context-assessment.json` gives exact predicate-bound future selectors, without a new extraction or automatic phase.\n\nRuntime metadata verifies gpt-6.1-sol/high/OpenAI before localized content. No nested agents/jobs or target application. No root docs, Git/index, shared source, approved targets, glossary, game/GUI, site, deployment or server mutations. Parent owns integration and acceptance.\n\n`targetApplied=false`, `actualGameRuntime=not-run`, `ordinaryTranslationEntryAllowed=false`, `sourceGateAccepted=false`, `wholeGameAccepted=false`.\n\nUsage is measured in `usage-at-cutoff.json`; it excludes the stated reporting tail. Cached input and reasoning tokens are subsets. Parent coordinator orchestration is separate and unknown here.\n''')
write('output-hashes.json',{f.name:sha(f) for f in sorted(OUT.iterdir()) if f.is_file() and f.name!='output-hashes.json'})
print(json.dumps({'status':result['status'],'output':str(OUT),'pinsVerified':len(checks),'newSemanticReceipts':len(sem),'allMemberships':len(context),'sourceHolds':len(holds)},indent=2))
