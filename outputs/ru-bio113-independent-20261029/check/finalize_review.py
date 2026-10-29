"""Serialize individually authored judgments and verify immutable packet bindings; no wording or judgments generated."""
import csv,hashlib,importlib.util,json,datetime,collections
from pathlib import Path
ROOT=Path('/Users/antonkrutov/Desktop/Forest');CHECK=ROOT/'outputs/ru-bio113-independent-20261029/check';PACKET=ROOT/'localization/supplemental-ui/20261029-bio-case113'
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def stringsha(s):return hashlib.sha256(s.encode('utf-8')).hexdigest()
def valuehash(v):return stringsha(json.dumps(v,ensure_ascii=False,separators=(',',':')))
def read(p):return json.loads(Path(p).read_text())
def jl(p):return [json.loads(l) for l in Path(p).read_text().splitlines()]
def put(n,v):
 p=CHECK/n
 assert not p.exists(),f'Immutable output already exists: {p}'
 p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
def putjl(n,v):
 p=CHECK/n
 assert not p.exists(),f'Immutable output already exists: {p}'
 p.write_text(''.join(json.dumps(x,ensure_ascii=False,separators=(',',':'))+'\n' for x in v))
initial=read(CHECK/'input-pins.initial.json');upstream=read(PACKET/'input-pins.json');pins=dict(initial)
for rel,h in upstream.items():
 assert sha(ROOT/rel)==h,('upstream input changed',rel)
 assert rel not in pins or pins[rel]==h
 pins[rel]=h
assigned=read(CHECK/'review-ids.json');targets=jl(PACKET/'ru.prepared.jsonl');contexts=jl(PACKET/'source-context.jsonl');protected=jl(PACKET/'protected-controls.jsonl');casecontext=jl(PACKET/'protected-case-context.jsonl');assemblies=jl(PACKET/'assembled-outputs.jsonl')
assert len(targets)==len(contexts)==assigned['assigned']==113
assert [x['id'] for x in targets]==assigned['ids']==[x['bindingId'] for x in contexts]
for n,h in assigned['sha256'].items():assert sha(PACKET/n)==h
for t,c in zip(targets,contexts):
 assert t['source']==c['source'] and valuehash(t['source'])==t['sourceValueSha256']==c['sourceValueSha256']
 assert stringsha(t['target'])==t['targetUtf8Sha256']
 assert t['source'].count('\n')==t['target'].count('\n')==0
 assert t['targetApplied'] is False
# Reuse the hash-pinned deterministic validator function without its main(), which writes outside this lane.
vpath=ROOT/'outputs/ru-bio113-case-wording-20261029/check/validate_packet.py'
spec=importlib.util.spec_from_file_location('bio113_bound_validator',vpath);module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
counts=module.validate(targets,contexts,protected,casecontext)
# These assertions exercise stored static assemblies, not Unity or live state.
byid={t['id']:t for t in targets};slots=[]
for a in assemblies:
 for j,s in enumerate(a['slots']):
  slots.append(s);t=byid.get(s['targetId'])
  expected={'text':t['target'],'newAlpha':1} if t is not None and not s['hidden'] else {'text':'???','newAlpha':0}
  assert s['lockedOutput']=='???' and s['allPresentKnownOutput']==expected
  if a['sheet']!='BioDetail':assert s['fragmentIndex']==j+(6 if a['sheet']=='BioKink' else 0)
 if a['sheet']=='BioDetail':
  assert a['allPresentKnownJoined']=='\n'.join(s['allPresentKnownOutput']['text'] for s in a['slots'])
  assert a['allLockedJoined']=='???\n???\n???'
assert len(assemblies)==52 and len(slots)==309
assert sum(s['targetId'] is not None for s in slots)==166
# Exact retained accepted reference versions; no new semantic coverage of UI935 is manufactured.
acceptpath=ROOT/'localization/supplemental-ui/20261029-existing935/ru.acceptance.json';accept=read(acceptpath);base=acceptpath.parent
assert accept['status']=='accepted-russian-ui935' and accept['targetEditorialAccepted'] is True
assert sha(base/accept['targetFile'])==accept['targetSha256']
catpath=ROOT/'localization/supplemental-ui/20261027/source-catalog.json'
assert sha(catpath)==accept['sourceCatalogSha256']
for q in accept['evidence'].values():assert sha(base/q['file'])==q['sha256'];pins[str((base/q['file']).relative_to(ROOT))]=q['sha256']
pins[str(acceptpath.relative_to(ROOT))]=sha(acceptpath)
refs=[]
for c in casecontext:
 for r in c['wordingReferences']:
  q=jl(ROOT/r['path'])[r['line']-1]
  assert q['id']==c['bindingId']==r['targetId'] and q['source']==c['source'] and valuehash(q['source'])==r['sourceValueSha256'] and stringsha(q['target'])==r['targetUtf8Sha256']
  refs.append({'id':q['id'],'sourceValueSha256':r['sourceValueSha256'],'targetUtf8Sha256':r['targetUtf8Sha256'],'target':q['target'],'reference':r,'acceptanceReceipt':str(acceptpath.relative_to(ROOT)),'acceptanceReceiptSha256':sha(acceptpath),'newSemanticPass':False})
assert len(refs)==6
# Compare distinct author/reviewer identity, without resuming or starting anything.
runtime=read(CHECK/'runtime-check.json');author=read(ROOT/'outputs/ru-bio113-case-wording-20261029/check/runtime-verification.json')
assert runtime['status']=='verified' and runtime['beforeLocalizedContent'] and runtime['threadId']!=author['threadId']
reviewer={'threadId':runtime['threadId'],'model':runtime['model'],'reasoning':runtime['reasoning'],'provider':runtime['provider'],'independentFromAuthorThreadId':author['threadId'],'freshExecNoInheritedHistory':True,'nestedJobs':0}
manual=list(csv.DictReader((CHECK/'review.authored.tsv').open(),delimiter='\t'))
assert [int(r['ordinal']) for r in manual]==list(range(1,114))
assert all(r['verdict']=='pass' for r in manual if r['ordinal']!='93')
assert manual[92]['verdict']=='preserve-symbol-context'
reviews=[];native=[];retained=[]
for t,c,r in zip(targets,contexts,manual):
 common={'id':t['id'],'ordinal':int(r['ordinal']),'sourceValueSha256':t['sourceValueSha256'],'sourceUtf8Sha256':stringsha(t['source']),'targetUtf8Sha256':stringsha(t['target'])}
 context={'sourceContextJsonlLine':int(r['ordinal']),'sourceContextSha256':sha(PACKET/'source-context.jsonl'),'actorSlots':[{'sheet':u['sheet'],'rowId':u['rowId'],'slot':u['slotField'],'actorName':u['actor']['name']} for u in c.get('uses',[])],'triggerIds':[q['id'] for q in c.get('triggerContexts',[])]}
 native.append({**common,'verdict':r['verdict'],'rationale':r['nativeRationale'],'readType':'separate complete target-language read','newWordingCredit':r['ordinal']!='93','reviewer':reviewer})
 if r['ordinal']=='93':retained.append({**common,'kind':'assigned-preserved-symbol','verdict':'preserved','source':t['source'],'target':t['target'],'rationale':r['rationale'],'context':context,'newSemanticPass':False,'newWordingCredit':False})
 else:reviews.append({**common,'source':t['source'],'target':t['target'],'verdict':r['verdict'],'rationale':r['rationale'],'findings':[],'context':context,'newSemanticPass':True,'reviewer':reviewer})
refmap={r['id']:r for r in refs}
for c in casecontext:
 sym=c['registryRole']=='preserve-display-symbol';ref=refmap.get(c['bindingId'])
 rationale=('Exact runtime/display ignorance mask; preserve question-mark count and terminal LF; no name or gender supplied.' if sym else ('Existing accepted source/target receipt retained at exact current hashes; Item found notification preserves LF and six unknown-symbol characters; no new semantic credit.' if ref else 'Unassigned source notification context only; Item found, LF and six unknown-symbol characters retained. No target exists in this packet and no new review acceptance is claimed.'))
 retained.append({'id':c['bindingId'],'kind':'unassigned-symbol-mask' if sym else ('retained-accepted-reference' if ref else 'unassigned-source-context'),'source':c['source'],'sourceValueSha256':c['sourceValueSha256'],'sourceUtf8Sha256':stringsha(c['source']),'verdict':'preserved' if sym else ('retained-version-matching' if ref else 'context-read-only'),'rationale':rationale,'newSemanticPass':False,'newWordingCredit':False,'reference':ref})
assert len(reviews)==112 and len(native)==113 and len(retained)==107
# Complete required input pins, including read instructions and retained evidence; no live events/log stream is pinned.
for p in [ROOT/'AGENTS.md',Path('/Users/antonkrutov/.codex/instructions/sitefor-mods.md'),Path('/Users/antonkrutov/.codex/instructions/game-localization-prompt.md'),Path('/Users/antonkrutov/.codex/instructions/game-localization-audit-workflow.md'),Path('/Users/antonkrutov/.codex/skills/vn-game-localize/SKILL.md'),Path('/Users/antonkrutov/.codex/skills/vn-game-localize/references/COMMON.md'),Path('/Users/antonkrutov/.codex/skills/vn-game-localize/references/WORKFLOW.md')]:pins[str(p)]=sha(p)
for rel,h in pins.items():assert sha(Path(rel) if Path(rel).is_absolute() else ROOT/rel)==h,('input changed at final boundary',rel)
putjl('reviews.jsonl',reviews);putjl('native-read.jsonl',native);putjl('retained-context.jsonl',retained)
put('deterministic-checks.json',{'status':'passed','boundary':'Exact packet/source/control/consumer-context bindings and static assembly consequences only; no semantic judgments generated and no game methods executed.','owningValidator':str(vpath.relative_to(ROOT)),'owningValidatorSha256':sha(vpath),'invocation':'import with -B; validate(targets, contexts, protected, casecontext); main not called','counts':counts,'upstreamPinsVerified':len(upstream),'assignedPacketPinsVerified':assigned['sha256'],'assembliesChecked':52,'slotsChecked':309,'presentReferences':166,'sourceCanonicalRepresentation':'UTF-8 compact JSON value, no trailing LF','stringHashRepresentation':'UTF-8 string bytes','protectedTechnicalStatesExact':1468,'maskSourceValues':dict(collections.Counter(c['source'] for c in casecontext if c['registryRole']=='preserve-display-symbol')),'retainedReferencesVerified':refs,'runtime': 'not-run','negativeTests':'Existing13-negative owner report retained at unchanged validator/input hashes; no new negative-test or model review credit.'})
put('findings.json',{'status':'complete-clean-independent-finite-review','objectiveFindings':[],'proposedReplacements':[],'unreadAssignedIds':[],'sourceObservations':[{'kind':'existing-source-anomaly','detail':'BIO(gator,kink_sizeplay), conversation299:1006, resolves identities without current category membership; preserve without remapping.'},{'kind':'unbound-keywords','detail':'Swinging and authored literal ??? have no current three-table slots; no actor/visibility/global-nonuse claim.'}],'remainingTechnicalUncertainty':[{'artifact':'sharedassets2.assets:14193/m_Text','predicate':'Complete Кинки at native16px with actual glyphs and source rectangle','nextPermittedAction':'Technical owner resolves bound RectTransform12362 dimensions from allowed source snapshot; runtime/visual checks require owning authorization.'},{'artifact':'sharedassets2.assets:17708/m_Text','predicate':'Complete Заметки at native16px with actual glyphs and source rectangle','nextPermittedAction':'Technical owner resolves bound RectTransform11976 dimensions from allowed source snapshot; runtime/visual checks require owning authorization.'},{'artifact':'display-only BioKeyword map','predicate':'Correct reinsertion, reveal/save/cache behavior and runtime reachability','nextPermittedAction':'Parent integrates only after its gate reconciliation; separate technical/runtime workflow verifies the actual artifact.'}],'targetApplied':False})
additional=read(PACKET/'additional-source-context.json')
coverage={'status':'complete','scope':'Independent final-version bio113 Russian wording review only','assignedIds':assigned['ids'],'assignedCount':113,'newSemanticIds':[r['id'] for r in reviews],'newSemanticCount':112,'reusedAssignedSemanticIds':[],'assignedSymbolIds':[targets[92]['id']],'assignedSymbolCount':1,'nativeReadIds':[r['id'] for r in native],'nativeWordingCount':112,'nativeSymbolContextCount':1,'completeCompactGlossaryRead':{'entries':171,'ids':[f'tfol-{i:03}' for i in range(1,172)],'sourcePath':'localization/glossary/inventory-display-20261028/en.json','targetPath':'localization/glossary/inventory-display-20261028/ru.json','handoffPath':'localization/glossary/inventory-display-20261028/handoff.json','sourceSha256':sha(ROOT/'localization/glossary/inventory-display-20261028/en.json'),'targetSha256':sha(ROOT/'localization/glossary/inventory-display-20261028/ru.json'),'handoffSha256':sha(ROOT/'localization/glossary/inventory-display-20261028/handoff.json'),'newGlossaryReviewCredit':False},'context':{'sourceContextLinesRead':list(range(1,114)),'actorSlotUsesRead':166,'bioTriggerContextsRead':113,'all52AssembliesRead':list(range(1,53)),'orderedSlotsRead':309,'additionalConversationsRead':[{'conversationId':c['conversationId'],'entryIds':[e['id'] for e in c['entries']]} for c in additional],'unassignedMaskSelectorsRead':94,'unassignedProseSelectorsRead':12,'retainedAcceptedReferenceIds':[r['id'] for r in refs],'newReferenceSemanticCredit':False,'protectedControlStatesDeterministicallyVerified':1468,'protectedControlSemanticCredit':False,'consumerAdaptersRead':['bio-detail/ADAPTER.md','bio-note-kink/ADAPTER.md','bio-keywords/ADAPTER.md'],'readRepresentation':'Lossless nonempty semantic-field projection for source trigger/conversation fields, compact actor-slot bindings and ordered full static outputs; duplicate typed cells/byte provenance checked deterministically. Initial truncated probes were superseded by complete bounded projections. Empty strings/empty [] fields were omitted only in display projections.','notModelReadAsProse':'All1468 raw control metadata wrappers, empty field wrappers, duplicate source spans/base64 and unrelated historical audits; no semantic credit claimed for them.'},'mandatoryRegressions':{'hiddenLockedNullMasks':'read; static exact values verified','literalCaptionVersusMasks':'read;1 authored caption distinct from94 masks','sourceLF':'read; ???\\n and Item found LF preserved','actorReferentsGenderNumber':'all166 joins read against approved character evidence; unknown Fisher receives no invented wording','oralGiverVersusReceiver':'final51 inspected with hidden Augustus dependency and generic oral label6','dominanceVersusPosition':'10/26/27/34/36/42 distinct concepts checked in source context','interestObjectsVersusActors':'28/44/55/62/111 preserve named/plural objects','fenReveal':'94 remains species Волк;95-97 retain tentative information','charlotteVariants':'Main row2/null role and Vslice row15/temporary role retained; no tags false fallback or both-tag priority changed','headingsNativeVersusArt':'enabled Text14193/17708 read; no artwork exemption','protectedKeys':'all1468 exact; Verile, town_arial_taxi and all BIO joins preserved'},'unreadAssignedIds':[],'unreadRequiredContext':[],'runtime':'not-run','visual':'not-run','targetApplied':False,'ordinaryTranslationEntryAllowed':False,'sourceGateAccepted':False,'wholeGameAccepted':False,'reviewer':reviewer}
put('coverage.json',coverage)
put('input-pins.json',{'schemaVersion':1,'immutable':True,'files':pins,'initialManifest':'input-pins.initial.json','verification':'All initial packet/glossary and upstream expected hashes compared at final boundary; exact final source/target pins match review-ids.json.','createdAt':datetime.datetime.now(datetime.timezone.utc).isoformat()})
put('input-preservation.json',{'status':'passed','verifiedFiles':len(pins),'changedInputs':[],'finalSourceContextSha256':sha(PACKET/'source-context.jsonl'),'finalTargetSha256':sha(PACKET/'ru.prepared.jsonl'),'writeScope':'Only outputs/ru-bio113-independent-20261029/check/','gitMutations':False,'rootReadmeCheckpointMutations':False,'sourceTargetGlossaryEdits':False})
result={'status':'finite-russian-bio113-independent-review-complete','game':'The Forest of Love 0.45','locale':'ru','assigned':113,'newSemanticReviewed':112,'nativeWordingRead':112,'preservedAssignedSymbol':1,'assembliesRead':52,'constituentSlotsRead':309,'glossaryEntriesRead':171,'independentReview':'clean','objectiveFindings':0,'unreadAssignedIds':[],'unreadRequiredContext':[],'finalSourceContextSha256':sha(PACKET/'source-context.jsonl'),'finalTargetSha256':sha(PACKET/'ru.prepared.jsonl'),'inputFilesUnchanged':True,'inputPinsSha256':sha(CHECK/'input-pins.json'),'reviewer':reviewer,'evidence':{n:sha(CHECK/n) for n in ['runtime-check.json','reviews.jsonl','native-read.jsonl','retained-context.jsonl','coverage.json','findings.json','deterministic-checks.json','input-preservation.json','review.authored.tsv']},'targetApplied':False,'ordinaryTranslationEntryAllowed':False,'sourceGateAccepted':False,'wholeGameAccepted':False,'runtime':'not-run','visual':'not-run','nextAction':'Finite assignment finished. Parent collects findings and owns gate reconciliation/integration; no automatic continuation.','usage':'Parent owns actual measured request telemetry; this lane does not estimate token counts.'}
put('Result.json',result)
# Recheck after output creation; output writes cannot stand in for an unchanged-input check.
for rel,h in pins.items():assert sha(Path(rel) if Path(rel).is_absolute() else ROOT/rel)==h,('input changed after delivery',rel)
print(json.dumps({k:result[k] for k in ['status','assigned','newSemanticReviewed','preservedAssignedSymbol','objectiveFindings','inputFilesUnchanged']},indent=2))
