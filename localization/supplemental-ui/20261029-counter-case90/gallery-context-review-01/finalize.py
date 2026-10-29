"""Bind authored judgments and verify the bounded handoff; no source/target mutation."""
import json,hashlib
from pathlib import Path
OUT=Path(__file__).resolve().parent
ROOT=Path('/Users/antonkrutov/Desktop/Forest')
SRC=ROOT/'localization/source/counter-producer-contracts-20261029'
PKT=OUT.parent
SESSION=Path('/Users/antonkrutov/.codex/sessions/2026/10/29/rollout-2026-10-29T13-19-42-01a18650-77e7-75f0-9007-af547131da94.jsonl')
def read(p):return json.loads(Path(p).read_text())
def lines(p):return [json.loads(l) for l in Path(p).read_text().splitlines()]
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def hs(s):return hashlib.sha256(s.encode()).hexdigest()
def put(n,x):
 p=OUT/n;assert not p.exists(),p
 p.write_text(''.join(json.dumps(r,ensure_ascii=False,separators=(',',':'))+'\n' for r in x) if n.endswith('.jsonl') else json.dumps(x,ensure_ascii=False,indent=2)+'\n')
a=read(OUT/'review.authored.json');joins=lines(OUT/'source-target-joins.jsonl');fixture=lines(OUT/'assembled-heading-fixtures.jsonl');stored=lines(OUT/'stored-context-joins.jsonl');pre=read(OUT/'deterministic-preflight.json')
assert len(a['semanticReceipts'])==len(a['separateRussianReadReceipts'])==6
assert [x['joinIndex'] for x in a['semanticReceipts']]==[0,1,2,3,4,5]
assert [x['joinIndex'] for x in a['separateRussianReadReceipts']]==[0,1,2,3,4,5]
assert {x['id'] for x in a['storedContextReceipts']}=={x['id'] for x in stored} and len(a['storedContextReceipts'])==12
for k,n in [('semanticReceipts','semantic-receipts.jsonl'),('separateRussianReadReceipts','natural-russian-receipts.jsonl')]:
 rs=[]
 for r in a[k]:
  j=joins[r['joinIndex']];fs=[x for x in fixture if x['id']==j['id']]
  if k=='semanticReceipts':assert r['fixtureIds']==[x['fixtureId'] for x in fs]
  rs.append({**r,'id':j['id'],'sourceUtf8Sha256':j['sourceUtf8Sha256'],'targetUtf8Sha256':j['targetUtf8Sha256'],'source':j['source'],'target':j['target'],'fixtureIds':[x['fixtureId'] for x in fs],'fixtureFileSha256':sha(OUT/'assembled-heading-fixtures.jsonl'),'reviewer':a['reviewer'],'sourceRead':'complete selected body and adopted contract','fullCorpusAuditClaim':False})
 put(n,rs)
assert not a['objectiveWordingFindings'] and not a['proposedFullReplacements'] and not a['changedWordingIds']
put('stored-context-receipts.jsonl',[{**r,'sourceUtf8Sha256':next(x['sourceUtf8Sha256'] for x in stored if x['id']==r['id']),'targetUtf8Sha256':next(x['targetUtf8Sha256'] for x in stored if x['id']==r['id']),'contextFileSha256':sha(OUT/'stored-context-joins.jsonl'),'scope':'new source-bound membership/context read; original stored-wording receipt retained','reviewer':a['reviewer']} for r in a['storedContextReceipts']])
chapter=ROOT/'localization/supplemental-ui/20261029-chapter-gallery-case'
rows={x['id']:x for x in lines(chapter/'ru.edited.jsonl')};author=read(chapter/'author-semantic-audit-134.json'); delta={x['id'] for x in lines(chapter/'ru.final-delta-01.jsonl')}
reuse=[]
for j in joins[6:]:
 r=rows[j['id']];assert r['source']==j['source'] and r['target']==j['target'];assert j['id'] in author['sourceTargetIdsReviewed'] and j['id'] not in delta
 acc=read(chapter/'ru.acceptance.json');proof=[]
 for k,v in acc['evidence'].items():
  p=chapter/v['file'];assert sha(p)==v['sha256'];proof.append({'kind':k,'path':str(p.relative_to(ROOT)),'sha256':sha(p)})
 reuse.append({**j,'result':'unchanged-exact-receipt-reuse','sourceAndTargetMatchChapterAcceptedRows':True,'sourceAndTargetMatchRemaining51':True,'originalFullSemanticRosterIncludesId':True,'notInOriginalFinalWordingDelta':True,'originalReceiptEvidence':proof,'acceptance':str((chapter/'ru.acceptance.json').relative_to(ROOT)),'acceptanceSha256':sha(chapter/'ru.acceptance.json'),'originalTargetSha256':acc['targetSha256'],'originalSourceAndTargetRow':r,'newSemanticPass':False,'newRussianReadPass':False,'context':'Separate BuildLastAttemptedMovieIdentifierPhrase Boolean branch formats movieIndex+1 or storyIndex+1. Four heading methods do not call it; count context invalidates neither identity target.'})
put('unchanged-identity-receipts.jsonl',reuse)
context=[{'method':b['method'],'instructionsRead':len(b['instructions']),'read':'complete','sourceBodyMetadataSha256':next(x['bodyMetadataSha256'] for x in lines(OUT/'body-provenance.jsonl') if x['method']==b['method']),'predicate':('unlocked Boolean fold, debug-secret exclusion, default/selection invocation branches' if 'InitializeGalleryMenu' in b['method'] else 'separate unchanged identity phrase scope' if 'BuildLastAttempted' in b['method'] else 'unchanged full-string delivery to native child enumeration' if '::Set' in b['method'] else 'secret availability including persistence and debug-disable guard' if '::get_Is' in b['method'] else 'option isUnlocked initialization and listener registration; external invocation order unrun' if '::Init(' in b['method'] else 'null-record false; otherwise persistence IsUnlocked' if 'IsGlobalMovieUnlocked' in b['method'] else 'actual count argument, format, branch and setter mapping')} for b in lines(OUT/'selected-source-bodies.jsonl')]
put('context-body-read-coverage.jsonl',context)
calls=lines(ROOT/'outputs/ru-counter11-source-contracts-20261029/calls-selected.jsonl');selected=[x for x in calls if any(m in x['called'] for m in ['::UpdateMovieSelectionText(','::UpdateStorySelectionText(','::ShowDefaultMovieSelectionText(','::ShowDefaultStorySelectionText('])]
put('callback-boundaries.json',{'callMetadataPath':'outputs/ru-counter11-source-contracts-20261029/calls-selected.jsonl','callMetadataSha256':sha(ROOT/'outputs/ru-counter11-source-contracts-20261029/calls-selected.jsonl'),'exactCallRecordsRead':selected,'completeInitBodyRead':True,'completeListenerRegistrationBodyRead':True,'completeHeadingAndSetterBodiesRead':True,'callbackBodyInterpretation':'No new callback-body acceptance. Indexed callers identify scroll, back and row callbacks; the heading bodies ignore the index, so upstream option identity cannot change the wording/count interpretation. Full callback lifecycle or native event ordering remains unrun. Existing source adoption retained without fresh assembly extraction.','nativeBoundaries':['UnityEngine.Object null comparison semantics','UnityEvent listener delivery/order','GameObject.GetComponentsInChildren<TextMeshProUGUI>() active-child inclusion','TMP_Text.set_text layout, fonts and rendering','DataService persistence snapshot/lifecycle']})
put('findings-and-exact-delta.json',{'reviewComplete':True,'objectiveWordingFindings':[],'proposedFullReplacements':[],'changedIds':[],'exactFinalDelta':[],'requiredRepairDependencies':[],'contextClarifications':[a['representationClarification'],a['sourceBoundaryClarification']],'targetApplied':False})
holds={'sourceGateAccepted':False,'ordinaryTranslationEntryAllowed':False,'wholeGameAccepted':False,'actualGameRuntime':'not-run','visual':'not-run','targetApplied':False,'boundedGalleryEditorialContextReview':'passed','nativeHolds':[{'predicate':'all children receive correct complete caption in live scene','evidence':'two complete managed setters and12 serialized ancestor chains; native child inclusion unrun','nextPermittedAction':'Parent retain static mapping; actual live verification needs applicable owner instruction.'},{'predicate':'default/selection/secret branches reachable and persistence coherent','evidence':'complete Initialize, secret getter and heading bodies;35 static substitution fixtures,8 explicitly incoherent symbolic controls','nextPermittedAction':'Parent may adopt bounded static editorial context; do not promote fixtures to actual game execution.'},{'predicate':'newlines, size12, Cyrillic font and layout actually render without clipping','evidence':'same decoded U+000A and complete size span; candidate four-method repair/readback retained','nextPermittedAction':'Keep native/layout pending; no game or screenshots requested by this review.'}],'unreadRequiredSelectors':[],'callbackLimitation':'Upstream callback method bodies were not newly interpreted; exact indexed invocation metadata and Init listener registration were read. Count/wording contract does not depend on the unread index parameter.'}
put('source-native-holds.json',holds)
put('read-coverage.json',{'boundedScopeComplete':True,'semanticHeadingIds':[x['id'] for x in joins[:6]],'newSemanticReceipts':6,'separateRussianReadReceipts':6,'storedContextIds':[x['id'] for x in stored],'storedContextRead':12,'unchangedIdentityIds':[x['id'] for x in joins[6:]],'unchangedReceiptReuses':2,'newIdentitySemanticReceipts':0,'sourceBodiesRead':context,'completeGlossaryReadEntries':171,'glossaryRead':'Complete compact EN/RU term+meaning fields read once; truncated tfol046-054 excerpt recovered before completion. No glossary audit newly claimed.','assembledSourceTargetFixturesRead':[x['fixtureId'] for x in fixture],'assembledRussianFixturesSeparatelyRead':[x['fixtureId'] for x in fixture],'requiredUnreadIds':[],'originalIndexOnlyNullFixtures':'preserved; not silently filled or accepted','symbolicIncoherentFixtureIds':[x['fixtureId'] for x in fixture if not x['snapshotCountCoherent']]})
# Existing input bytes are checked again after all review reads; unrelated checkout work is not touched.
unchanged=[{'path':x['path'],'expectedSha256':x['sha256'],'actualSha256':sha(x['path']),'unchanged':sha(x['path'])==x['sha256']} for x in read(OUT/'input-pins.json')]
assert all(x['unchanged'] for x in unchanged)
put('originals-unchanged.json',{'allUnchanged':True,'files':unchanged,'writeBoundary':str(OUT),'gitIndexMutation':False,'rootDocsMutation':False,'sharedToolsMutation':False})
result={'status':'complete-independent-bounded-gallery-context-review-clean','game':'The Forest of Love','version':'0.45','locale':'ru','reviewer':a['reviewer'],'model':'gpt-6.1-sol','reasoning':'high','provider':'openai','newSemanticHeadingRows':6,'separateRussianReadRows':6,'storedContextRows':12,'unchangedIdentityReceiptReuses':2,'assembledFixturesRead':35,'incoherentSymbolicBoundaryFixtures':8,'sourceBodiesRead':12,'sourceInstructionsRead':pre['sourceInstructions'],'wordingFindings':0,'changedWordingIds':[],'proposedFullReplacements':[],'exactFinalDelta':[],'candidateBuildSha256':pre['candidateBuildSha256'],'candidateFourMethodReadbackReused':True,'originalTargetReceiptsRetained':True,'parentAdoption':'pending for this review output','targetApplied':False,'actualGameRuntime':'not-run','visual':'not-run','ordinaryTranslationEntryAllowed':False,'sourceGateAccepted':False,'wholeGameAccepted':False,'unreadRequiredSelectors':[]}
put('Result.json',result)
# This current-session cumulative usage is disjoint from the parent's counters. Reporting after this cutoff remains unmeasured.
usage=None
for x in lines(SESSION):
 if x['type']=='event_msg' and x['payload'].get('type')=='token_count':usage={'eventTimestamp':x['timestamp'],'info':x['payload']['info']}
if usage:
 u=usage['info']['total_token_usage'];put('usage-at-cutoff.json',{'agent':a['reviewer'],'sessionId':'01a18650-77e7-75f0-9007-af547131da94','model':'gpt-6.1-sol','reasoning':'high','provider':'openai','measurement':'fresh-session nonoverlapping cumulative token telemetry; baseline zero before assignment','cutoff':usage['eventTimestamp'],'inputTokens':u.get('input_tokens'),'cachedInputTokens':u.get('cached_input_tokens'),'outputTokens':u.get('output_tokens'),'reasoningOutputTokens':u.get('reasoning_output_tokens'),'totalTokens':u.get('total_tokens'),'reportingTail':'All requests after cutoff, including this finalize result and final report, unmeasured here; parent may collect final delta.','coordinatorOrchestrationTokens':'parent owns measurement; not included','descendantAgentTokens':'none; no descendants launched'})
else:put('usage-at-cutoff.json',{'usage':'unknown','reason':'no per-session telemetry exposed','coordinator':'parent owns accounting'})
(OUT/'HANDOFF.md').write_text('''# Gallery counter context-delta review

The Forest of Love 0.45, Russian. Independent bounded review is complete and clean: six actual gallery heading operands, twelve original stored layer bindings, and two separate unchanged identity-phrase receipt reuses. No target repair is proposed or applied.

`semantic-receipts.jsonl` has six new source-context judgments. `natural-russian-receipts.jsonl` has six separately performed Russian reads. Every one of the 35 complete source/target fixtures was read, then every Russian form was read separately. The twelve stored context rows each have an individual receipt. The two `BuildLastAttemptedMovieIdentifierPhrase` operands retain exact chapter/gallery and remaining51 acceptance; no new semantic pass is invented for them.

The source fold counts unlocked entries, not an ordinal: movies use unlocked/11; stories use unlocked/(48 minus locked secrets), with totals 46, 47 or 48. Both independent 47 branches are covered. `Update*SelectionText(Int32)` ignores the index. The full default methods select bare Истории/Фильмы when last-selected compares null, and formatted headings otherwise. Истории/Фильмы with `(открыто: {0}/{1})` preserves this meaning and stays grammatical at zero, one and total. The complete status clause remains inside size12 after the category newline.

All twelve stored captions preserve Фильм 1/8 or История 1/8. Six movie members bind by ancestry to level1:1852 and six story members to level1:1475; setters forward a whole string to enumerated TMP children. Initial values do not establish an eight-item total. All twelve text components are enabled beneath an initially inactive GalleryMenu; static ancestry is not live visibility.

The decoded ledger source/target, raw ldstr, adopted dependency source and actual candidate `gallery-targets.json` contain U+000A. JSON serialization represents it with backslash-n. The pinned builder parses JSON and copies the decoded string directly to ldstr with exact source matching. Do not introduce a second unescape or drop content to repair a nonexistent syntax defect.

Eight zero/one story cases with unlocked secrets are symbolic formatting controls inconsistent with an initialized snapshot's minimum secret count; they are explicitly marked and do not prove game reachability. Every fixture, including coherent endpoint cases, keeps actual runtime not-run. No original null fixture was rewritten.

Twelve complete frozen game bodies (946 instructions) were read, including initialization, both secret predicates, option unlock/listener registration, headings and setters. Exact indexed caller metadata was read for scroll/back/row callback boundaries. Upstream callback bodies were not newly interpreted: the output contract ignores their index. Native event ordering, persistence lifecycle, Unity null semantics, TMP child inclusion, fonts and layout remain unverified. No fresh assembly/Unity extraction or renderer scan was performed.

The actual candidate build SHA-256 is `e0fddc537966c94e44c0989664b2904951c2add43d5d57aaada12753657e8d6d`. Its exact six targets and four-method `galleryCodeRepair`/readback receipt match the accepted joins and preserve original bodies upon restoring display operands. This reuses the existing managed patch-stage receipt; it is not a new actual-game or final-assembly extraction. Parent's delivered-file verification remains separate.

Runtime metadata verifies this reviewer session as `gpt-6.1-sol` / high / OpenAI before localized input. No child model/job was launched. Deterministic checks are kept separate from authored semantic judgment. Input pins, retained original receipts, source-body provenance, source/native holds and preserved-original checks are recorded in this folder. `prepare.py` and `finalize.py` are task-only assembly recipes; their create-only writes are per file and not transactional. Verify the complete output manifest before adoption; do not replay them over existing evidence.

`targetApplied=false`, `actualGameRuntime=not-run`, `ordinaryTranslationEntryAllowed=false`, `sourceGateAccepted=false`, `wholeGameAccepted=false`. These fields describe this review's scope; the preexisting candidate already contains previously authorized target applications. No game, GUI, screenshot, installation, publication, deployment, server, root documentation, accepted wording, shared tool, Git or index mutation occurred.

Parent owns review adoption and canonical Git integration. No wording correction/delta reread is required by this clean context review; adopt its exact pins and keep source/native holds. Do not start a continuation scan from this handoff. Worker telemetry at the measured cutoff is in `usage-at-cutoff.json`; the subsequent reporting tail and parent orchestration are not included.
''')
manifest=[{'file':p.name,'bytes':p.stat().st_size,'sha256':sha(p)} for p in sorted(OUT.iterdir()) if p.is_file()]
put('output-manifest.json',{'files':manifest,'selfExcluded':True,'newline':'UTF-8 LF; JSONL one object per line ending LF','boundary':'per-file create-only writes; manifest completeness required, not transactional'})
print(json.dumps({'status':result['status'],'files':len(manifest)+1,'sourceInstructions':pre['sourceInstructions'],'usage':read(OUT/'usage-at-cutoff.json')}))
