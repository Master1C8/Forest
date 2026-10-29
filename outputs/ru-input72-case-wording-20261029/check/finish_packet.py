"""Serialize explicit author review judgments and finite handoff; no model calls."""
import json,hashlib,collections
from pathlib import Path
R=Path('/Users/antonkrutov/Desktop/Forest');O=R/'localization/supplemental-ui/20261029-input-case72';C=R/'outputs/ru-input72-case-wording-20261029/check';B=R/'localization/source/shared-source-completion-20261028/admission-v1'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def jl(p):return [json.loads(l) for l in p.read_text().splitlines()]
def load(p):return json.loads(p.read_text())
def write(n,x):(O/n).write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n')
def rows(n,x):(O/n).write_text(''.join(json.dumps(z,ensure_ascii=False,separators=(',',':'))+'\n' for z in x))
t=jl(O/'ru.prepared.jsonl');s=jl(O/'source-context.jsonl');p=jl(O/'protected-controls.jsonl');schemas=jl(O/'native-component-schemas.jsonl')
# Actual complete source/target read was followed by a separate target-only read.
# These are authored judgments, not outcomes inferred from a validator loop.
N={
1:'Return key caption: input action; no change to key13 or output.Submit.',
2:'LeftShift caption names case selection; key304, not translated text emission.',
3:'Done caption denotes completion; key509 retains BugReportMenu callback.',
4:'Numeric-layout Return caption has the same input action as alphabet-layout Return.',
5:'Numeric-layout Done caption remains completion, separate from Return.',
6:'Bottom glow of title prompt retains unrestricted any-key instruction.',
7:'Main title prompt retains any key, without adding an accept/confirm restriction.',
9:'Top title glow matches complete any-key prompt.',
10:'Left title glow keeps the same complete instruction.',
11:'Title prompt container has the same wording as all its glow copies.',
12:'Right title glow retains any key and singular informal address.',
13:'Numeric specialKeys Return name is display text, not layout Return token.',
14:'Alphabet specialKeys Shift name names case selection; matched by keycode304.',
15:'Alphabet specialKeys Return name agrees with the initial Return label.',
16:'Legacy title prompt receives the same complete any-key caption as TMP copies.',
17:'Thank-you-screen prompt retains the unrestricted any-key action.',
18:'Act2 illustration prompt retains the same action; no new completion claim.',
19:'Thank-you bottom glow uses the full prompt.',
20:'Act2 bottom glow uses the full prompt.',
21:'Thank-you main glyph layer retains any key.',
22:'Act2 main glyph layer retains any key.',
23:'Thank-you parent label agrees with glow layers.',
24:'Act2 parent label agrees with glow layers.',
25:'Thank-you left glow preserves the complete any-key instruction.',
26:'Act2 left glow preserves the complete any-key instruction.',
27:'Thank-you top glow matches the same source action.',
28:'Act2 top glow matches the same source action.',
29:'Thank-you right glow matches all other prompt layers.',
30:'Act2 right glow matches all other prompt layers.',
31:'Mobile Atk1 inventory label: Inv abbreviates inventory; Russian Инв. is a label, not an action identifier.',
32:'Dash reminder bottom layer preserves Shift or gamepad X and glossary Рывок.',
33:'Dash reminder parent label preserves the two alternative controls and burst movement.',
34:'Dash reminder top layer retains Shift and X, without changing either into a Cyrillic key.',
35:'Dash reminder left layer retains a single press rather than repeated tapping.',
36:'Dash reminder right layer matches the complete action instruction.',
37:'Dash reminder main layer uses the approved movement concept рывок.',
38:'Gossip bottom hint retains when-finished condition and Escape/B alternatives.',
39:'Gossip right hint retains when-finished condition; no implicit confirmation action.',
40:'Chapter-select bottom hint retains Escape/B and when-finished condition.',
41:'Chapter-select right hint retains both alternatives and completion timing.',
42:'Gossip left hint preserves the whole conditional instruction.',
43:'Chapter-select parent hint matches the complete child labels.',
44:'Level mobile Atk1 inventory label matches the MenuSingletons abbreviation.',
45:'Gossip main hint retains Escape or B, not A/Enter.',
46:'Chapter-select main hint retains Escape or B and final exclamation.',
47:'Level numeric Return initial caption is ВВОД; key13 remains input submission.',
48:'Level numeric Done initial caption is ГОТОВО; key509 custom callback remains separate.',
49:'Actual report placeholder, independent of entered value: normal and on-screen keyboards, touch and gamepad support all retained. Same source/wording as accepted row8, but counted as newly prepared distinct ID.',
50:'Level alphabet Shift special name agrees with its initial caption РЕГИСТР.',
51:'Level alphabet Return special name agrees with its initial caption ВВОД.',
52:'Level alphabet LeftShift initial caption preserves the case-switch action and cached default contract.',
53:'Level numeric Return special name is display-only; layout Return stays English.',
54:'Level alphabet Done initial label preserves completion, not character emission.',
55:'Level alphabet Return initial label preserves input submission, separate from Done.',
56:'Chapter-select left hint keeps the complete when-finished condition.',
57:'Gossip parent hint keeps Escape/B and no added gameplay claim.',
58:'Gossip top hint keeps the same completion timing and both controls.',
59:'Chapter-select top hint keeps Escape/B with source capitalization.',
60:'Plant top hint retains repeated rapid pressing, Spacebar/A alternatives and clenching; мышцы makes the contraction intelligible without inventing an anatomical site.',
61:'Plant bottom hint retains the same rapid-press instruction, not a held-button instruction.',
62:'Full plant main instructions retain delivery to Скарлетт while fresh AND warm, triple LF and clenching. Семя preserves the approved plant/reproductive double meaning as Russian mass usage; no numerical count is supplied by the source.',
63:'Full plant right glow preserves the entire delivery sentence plus rapid-press instruction; no fragment-only replacement.',
64:'Plant left hint retains rapid repetition and the clench action.',
65:'Plant right hint retains Spacebar/A exactly and names contraction without an invented body part.',
66:'Full plant bottom glow retains fresh/warm conjunction, destination and complete second instruction.',
67:'Full plant left glow preserves the same full two-part instruction, including triple LF.',
68:'Plant instruction container retains destination Скарлетт, current freshness/warmth and both controls.',
69:'Full plant top glow preserves reproductive ambiguity and all instructions.',
70:'Plant hint container retains repeated pressing, not holding, and both alternative controls.',
71:'Plant main hint retains the clench action and complete repeated-press instruction.'
}
assert set(N)=={x['ordinal'] for x in t if x['status']=='prepared'}
Native={
'key-actions':'Concise Russian action caption; uppercase follows the source keycap style. РЕГИСТР is case switching, ВВОД and ГОТОВО remain distinct.',
'press-any-key':'Natural singular informal imperative Нажми; любую agrees with клавишу and preserves the unrestricted action.',
'report-placeholder':'Natural impersonal wording; обычной/экранной refer to клавиатуры. Она refers to the on-screen keyboard, not a person; no gender inferred.',
'inventory-shortcut':'Инв. is the conventional recognizable abbreviation of инвентарь; full stop marks truncation.',
'dash-instruction':'Natural Нажми … чтобы сделать рывок; геймпаде is correctly inflected; the glossary movement noun is used.',
'finish-instruction':'Natural temporal clause Когда закончишь followed by Нажми; singular informal address is consistent with neighboring instructions.',
'plant-button-hint':'Быстро нажимай expresses repeated tapping naturally; сжимать мышцы expresses clenching without a false shrink/reduce-size reading.',
'plant-full-instruction':'Донеси семя до Скарлетт has clear delivery agency and destination. Оно свежее и тёплое agrees with mass noun семя; both qualities survive. Second instruction is complete and readable.'
}
audit=[];native=[]
for x in t:
 if x['status']=='reused':continue
 audit.append({'id':x['id'],'ordinal':x['ordinal'],'sourceValueSha256':x['sourceValueSha256'],'targetUtf8Sha256':x['targetUtf8Sha256'],'reviewer':'current verified fresh gpt-6.1-sol/high/OpenAI author','reviewType':'one complete source-to-target semantic self-audit','judgment':'no-objective-wording-defect','note':N[x['ordinal']],'contextArtifact':'source-context.jsonl','independent':False})
 native.append({'id':x['id'],'ordinal':x['ordinal'],'targetUtf8Sha256':x['targetUtf8Sha256'],'reviewType':'separate complete native-Russian target-only self-read','judgment':'no-objective-language-defect','note':Native[x['solutionGroup']],'independent':False})
rows('author-semantic-audit.jsonl',audit);rows('native-russian-read.jsonl',native)
write('findings-and-delta.json',{'initialArtifact':'ru.initial.jsonl','initialSha256':sha(O/'ru.initial.jsonl'),'finalArtifact':'ru.prepared.jsonl','finalSha256':sha(O/'ru.prepared.jsonl'),'immediateEdit':'All70 authored units edited during drafting before initial serialization; no rejected wording was written to targets.','completeSemanticRead':70,'separateNativeRead':70,'reusedWithVerifiedReceipts':2,'objectiveWordingFindings':[],'acceptedConsolidatedRepairBatch':[],'changedIdsAfterAudit':[],'exactFinalDelta':[],'exactFinalDeltaCount':0,'initialDeliveryDeltaCount':70,'reason':'No objective wording defect found in the complete author pass; final bytes match initial packet. No independent-review claim.'})
rows('ru.final-delta.jsonl',[])
# Explicit executable-behavior boundaries used in this decision, all previously exported.
E=[
('phase134/key-behavior.il','Awake IL_003e–IL_004a copies keyName.text to defaultLabelText; IsShiftKey compares303/304.'),
('phase134/keyboard-generate.il','Generate parses layout, matches specialKeys by keycode, passes name to Assign atIL_0313–032a, binds existing callbacks or KeyCall, preserves doneKey; final Shift broadcasts remain exact.'),
('phase134/keyboard-find.il','Special-key lookup compares keycode, not caption spelling.'),
('phase134/keyboard-callback.il','KeyCall focus/dictionary guards; key13 Submit, Shift303/304 case toggle, printable keycode->char/ToUpper; KeySpace emits ASCII space; OnPhysicalKeyStroke uses existing char-to-keycode map.'),
('phase134/key-click.il','Click preserves isPressed guard and OnMouseDown/OnMouseUp timing; button state unchanged.'),
('phase144/producers/161.il','Assign writes key, label from explicit name or char(key), then keyType; does not derive keycode from translated label.'),
('phase145/receivers/03.il','Relabel applies only to Shift303/304 or302 and uses defaultLabelText on null; it does not restore Return/Done.'),
('phase134/plant-label-producer.il','Plant UI Awake binds instructions/button-hint animators and timer/dash labels; observed label family preserved. Dynamic animator states and gameplay not altered.')]
pins=load(O/'input-pins.json');ev=[]
for n,note in E:
 q=B/n;pins[str(q)]=sha(q);ev.append({'path':str(q.relative_to(R)),'sha256':sha(q),'contract':note})
write('producer-evidence.json',ev)
# Store each group membership; no string equality is used to infer runtime acceptance.
groups=[]
for group in dict.fromkeys(x['solutionGroup'] for x in t):
 members=[x for x in t if x['solutionGroup']==group]
 groups.append({'group':group,'ids':[x['id'] for x in members],'sourceWording':[x['source'] for x in members],'targetWording':[x['target'] for x in members],'interpretation':{
 'key-actions':'Translate action captions only. Keep Return, LeftShift and every enum/keycode/callback exact; default cache must agree with initial caption.',
 'press-any-key':'Player may press any key; every existing main/glow copy receives the full same caption. Actual input coverage remains a runtime check.',
 'report-placeholder':'Explicit Placeholder TextMeshProUGUI field, separate from TMP_InputField entered value; retain physical/on-screen and touch/gamepad distinction.',
 'inventory-shortcut':'Mobile button label abbreviates inventory. Do not rename Atk1 or any action ID.',
 'dash-instruction':'One press of physical Shift OR gamepad X triggers the existing burst-movement mechanic; preserve literal controls.',
 'finish-instruction':'Use Escape OR gamepad B when finished; retain condition and every glow copy.',
 'plant-button-hint':'Rapid repeated presses, not hold: Spacebar OR gamepad A; clench without invented anatomical detail.',
 'plant-full-instruction':'Deliver seed to Scarlett while fresh and warm; maintain reproductive/plant ambiguity, triple LF and rapid-clench instruction.',
 'map-instruction':'Reuse accepted map description and exact M/Select controls; activation semantics/resources remain unchanged.'}[group],'implementation':'proposal-only','runtime':'not-run'})
write('case-solutions.json',{'caseId':'input-labels-and-emitted-values','locale':'ru','groups':groups,'wordingPrepared':72,'whole409RuntimeAccepted':False,'characterRules':'Apply full171 glossary; no new pronoun/identity facts. Scarlett uses approved Скарлетт. Plant seed remains семя.'})
keyrows=[x for x in t if x['solutionGroup']=='key-actions']
write('display-cache-dispatch-proposal.json',{
 'status':'finite-proposal-only-no-code-written','captionIds':[x['id'] for x in keyrows],
 'initialDisplay':'At the exact original TextMeshPro /m_text leaves, stage ВВОД / РЕГИСТР / ГОТОВО before the key Awake captures keyName.text. Do not touch GameObject names or emitted values.',
 'generatedDisplay':'At the six admitted specialKeys name leaves, stage the matching Russian caption only. Existing Generate finds a special entry by keycode and Assign writes its independent caption. Preserve all sibling fields and specialAction events.',
 'cache':'Before first interaction, defaultLabelText for both Shift keys must contain РЕГИСТР. Prefer asset-time initial-label and specialKeys.name parity so Awake/Generate agree. If a future adapter writes after Awake, it must update the cached default as well as the visible label before any Relabel(null); a visible-label-only write is insufficient.',
 'RelabelScope':'Saved method permits Shift303/304 and layout-switch302 only. Null restores cached default. Return13 and Done509 are not reset by this method. Preserve current non-null contextual overrides; their target wording belongs to their existing owning cases, not this new72-unit packet.',
 'dispatch':'Keep key13 and receiver Submit, Shift303/304, layout-switch302, Done509 and OnClickVirtualKeyboardDone, keyType, focus/dictionary guards, press states, callbacks and physical char->keycode map exact. Caption string is never used as the dispatch identity in the saved bodies.',
 'lettercase':'Preserve original shift/caps state, printable keycode-to-character conversion, ToUpper call and ShiftUp/ShiftDown broadcasts. Do not uppercase localized action captions through a new letter-emission mechanism; no Russian layout is supplied.',
 'symbols':'Keep all176 symbol members byte-exact, including Latin A/X/B, ABC final LF,123, whitespace, arrows and punctuation. Visual resemblance must not replace Latin control identities.',
 'inputSeedAlias':'All157 InputField.m_Text values stay Input Field and target=null. Native schemas show these are entered-value seeds with no placeholder pointer and nonzero text component; that is not proof of visibility or exclusion. If wording is later required, obtain the actual writer/display/submit contract and implement an independent display alias; translating m_Text would also alter the initial input value.',
 'instructions':'Stage complete 55 prose/abbreviated-caption display leaves plus the separate Map description by exact selector; update all glow copies together. Report placeholder is a separate display field, not the input value.',
 'remainingRuntimePredicates':['Actual Awake/Generate order for delivered artifact and post-generation label/cache parity.','Shift case changes and contextual Relabel(non-null)->Relabel(null) restore correct captions without altering emitted characters.','Return submits, Done closes keyboard; keyboard layout switches preserve original physical/emitted characters and gamepad selection.','All label layers align and fit with real Cyrillic font resources at actual size.','Prose matches actual Spacebar/A,Shift/X,Escape/B,M/Select behavior on the delivered build.','Determine per-ID157 seed exposure/replacement before any source exclusion or input alias adaptation.'],
 'sourceGateAccepted':False,'targetApplied':False,'newILReads':0,'newRuntimeCode':False,'noRussianKeyboardLayout':True})
# Fix wording count from actual membership, rather than assuming key/prose totals.
proposal=load(O/'display-cache-dispatch-proposal.json');proposal['instructions']='Stage complete '+str(len(t)-len(keyrows)-1)+' non-key-caption display leaves plus the separate Map description by exact selector; update all glow copies together. Report placeholder is a separate display field, not the input value.';write('display-cache-dispatch-proposal.json',proposal)
# Exact finite context account, with no inferred invisible exclusions.
write('context-accounting.json',{'caseMembers':409,'targetUnits':72,'newPrepared':70,'reused':2,'protectedOrPotential':337,'preserveSymbols':176,'preserveLayoutControls':4,'unresolvedPotentialSeeds':157,'potentialSeedTarget':None,'potentialSourceStatus':'needs-source','potentialMissingPredicate':'For each exact ID, prove the seed consumer, initial display/replacement, submitted-value semantics and independent display alias. See protected-controls.jsonl.','nativeInputSchema':'All157: UnityEngine.UI.InputField.m_Text=Input Field; m_Placeholder null, m_TextComponent nonzero, no persistent on-end-edit/value-change callbacks in the selected serialized fields. Runtime code may still replace/consume it.','coverageMeaning':'All409 memberships and exact source bindings accounted. Model semantic wording audit covers70 new target units;2 retain receipts. Context metadata inspection and exact preservation do not establish409 runtime acceptance.','whole409RuntimeAccepted':False})
new=[x['id'] for x in t if x['status']=='prepared'];reused=[x['id'] for x in t if x['status']=='reused']
write('review-closure.json',{'cycle':'initial-input72-wording-handoff','sourceAndTarget':'ru.prepared.jsonl','targetSha256':sha(O/'ru.prepared.jsonl'),'changedIds':new,'closureIds':new,'reusedIdsWithRetainedReceipts':reused,'contextIds':[x['bindingId'] for x in p],'runtimeContractIds':[x['id'] for x in t],'exactFinalDeltaIds':[],'removedDependencyIds':[],'componentRule':'Entire finite input case: all70 newly authored units plus72 source/producer/display contracts; retain two accepted wording receipts;337 exact nontranslatable/potential context members remain separate.','independentReview':'pending; parent dispatches distinct reviewer; no job launched here','mandatoryRegressions':['Latin control tokens incl.X/A/B and exact bracket syntax','LF and triple-LF preservation','Shift versus Enter versus Done; default cache restoration','All duplicate/glow layer IDs kept','157 input seeds not silently translated/excluded','Source meaning fresh AND warm and seed ambiguity','No invented identity/pronouns'],'generatedSemanticJudgment':False})
write('coverage-read-evidence.json',{'runtimeBeforeLocalizedContent':str(C/'runtime-check.json'),'glossary':'All171 compact English and Russian entries plus handoff read; initial bulk output was truncated, followed by complete bounded entries1–57,58–114,115–171.','sourceAndContext':'Every72 source/target/hierarchy read in complete compact output. All409 bound against their exact typed ledger and native schemas (408 serialized +1 BGDatabase).','newTargetSemanticReadIds':new,'newTargetSemanticReadCount':70,'newTargetNativeReadIds':new,'newTargetNativeReadCount':70,'reusedWithVerifiedReceiptsIds':reused,'newWordingUnreadIds':[],'contextUnresolvedIds':[x['bindingId'] for x in p if x['currentRole']=='potential-display-input-seed'],'unreadContext':'No extra framework callee is claimed read; only named saved bodies in producer-evidence.json. Potential seed semantic consumer remains unresolved, explicitly not a pass.','sourceTargetArtifactSha256':sha(O/'ru.prepared.jsonl'),'authorSemanticAuditSha256':sha(O/'author-semantic-audit.jsonl'),'nativeReadSha256':sha(O/'native-russian-read.jsonl'),'independentReview':False})
write('acceptance-checklist.json',[
 {'artifact':'ru.prepared.jsonl','predicate':'72 exact IDs have complete Russian wording or explicit hold','currentEvidence':'70 prepared +2 exact receipt reuse;0 wording holds','status':'passed-for-preparation','remainingUncertainty':'Independent judgment of new wording pending','nextPermittedAction':'Parent reviews the finite packet with a distinct reviewer.'},
 {'artifact':'protected-controls.jsonl / native-component-schemas.jsonl','predicate':'All337 context members accounted with source values exact','currentEvidence':'176 symbols+4 parser layouts preserved;157 entered-value seeds preserved with target=null','status':'passed-static-accounting','remainingUncertainty':'Per-seed display/replace/submit consumer unknown','nextPermittedAction':'Owning source/technical lane resolves157 exact per-ID predicates; no translation or exclusion on defaults alone.'},
 {'artifact':'display-cache-dispatch-proposal.json','predicate':'Caption display, cached reset and dispatch remain coherent','currentEvidence':'Saved Awake/Generate/Assign/Relabel/KeyCall bodies and source-bound schemas; exact selected-leaf memory proposal passes','status':'proposal-prepared','remainingUncertainty':'No adapter implementation or delivered runtime exercised','nextPermittedAction':'Parent technical lane evaluates proposal within its own permission; do not apply through this packet.'},
 {'artifact':'deterministic-preflight.json','predicate':'Full finite packet safe at declared static boundary','currentEvidence':'Positive72+337 check and12 intended-boundary negatives','status':'passed','remainingUncertainty':'In-memory tree copies replace reinsertion/runtime, so this is no build/rendering proof','nextPermittedAction':'Reuse unchanged evidence by hash; run actual packaging/runtime only under owning authorization.'},
 {'artifact':'review-closure.json','predicate':'Independent review clean on final unchanged hashes','currentEvidence':'Full author semantic audit and separate native read; no objective wording findings, exact final repair delta empty','status':'pending','remainingUncertainty':'No distinct reviewer in this stream','nextPermittedAction':'Parent dispatches independent review; no nested job here.'}])
write('input-pins.json',pins)
write('write-boundary.json',{'allowedWrites':[str(C),str(O)],'originalSourceAndTargets':'read-only; unchanged input pins verified by preflight','rootREADMEAndCHECKPOINT':'no writes by this job; baseline pins recorded, concurrent owner changes reported separately','git':'no Git/index commands or mutations','nestedJobs':0,'gameGUIImagesInputProcessControl':'not-run','originalGameSaveFontTexture':'not-modified','installerBrowserSitePublicationDeploymentServer':'not-run','usage':'Parent measures actual session telemetry; no estimate made here.'})
print('Serialized actual70 semantic and70 native-read judgments;2 verified reuse receipts; finite proposal and acceptance checklist.')
