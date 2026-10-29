"""Assemble an unapplied revision from immutable evidence and directly authored captions."""
import collections,copy,hashlib,json,pathlib,re
ROOT=pathlib.Path('/Users/antonkrutov/Desktop/Forest')
V=ROOT/'localization/supplemental-ui/20261029-pause-chapter-case576'
P=V/'revision-02';O=ROOT/'outputs/ru-pause-chapter576-case-wording-20261029/revision-02'
T=ROOT/'localization/source/pause-chapter576-binding-contract-20261029'
def sha(p):return hashlib.sha256(pathlib.Path(p).read_bytes()).hexdigest()
def uh(s):return hashlib.sha256(s.encode()).hexdigest()
def load(p):return json.loads(pathlib.Path(p).read_text())
def lines(p):return [json.loads(l) for l in pathlib.Path(p).read_text().splitlines()]
def out(n,x):(P/n).write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n')
def jl(n,x):(P/n).write_text(''.join(json.dumps(y,ensure_ascii=False,separators=(',',':'))+'\n' for y in x))
def canonical(x):return json.dumps(x,ensure_ascii=False,sort_keys=True,separators=(',',':'))
def control(h):return h.split('/CheatsMenu/Controls/')[1].split('/')[0] if '/CheatsMenu/Controls/' in h else None
assert sha(T/'Result.json')=='edce8583d2eb758b47d65be6dd605a934720e4f2316a6bd4351eeae3b2428c1e'
assert sha(T/'selector-binding-matrix.jsonl')=='c2990f43ad46ea077756b5a1157d1a733f8447c1a937b44e8ddee240ce09a0d4'
v1baseline=load(P/'v1-preservation-baseline.json')
for fn,h in v1baseline.items():assert sha(ROOT/fn)==h,fn
pins=load(T/'output-code-pins.json')
for fn,h in pins.items():assert sha(ROOT/fn)==h,fn
for fn,h in load(V/'input-pins.json').items():
 q=pathlib.Path(fn) if fn.startswith('/') else ROOT/fn
 assert sha(q)==h,fn
old=lines(V/'ru.prepared.jsonl');oldBy={r['id']:r for r in old}
matrix=lines(T/'selector-binding-matrix.jsonl');m={r['id']:r for r in matrix};assert list(m)==list(oldBy)
delta=lines(T/'active-cheat60-source-delta.jsonl');newIds={r['id'] for r in delta};assert len(newIds)==60
heldLabels=lines(T/'unlock-movies-six-authored-label-hold.jsonl');heldLabelIds={r['id'] for r in heldLabels};assert len(heldLabelIds)==6
auth=load(P/'wording.authored.json');groupNotes=load(P/'group-read.authored.json')
context=lines(V/'source-context.jsonl');contextBy={r['source']['id']:r for r in context}
oldAudits={r['id']:r for r in lines(V/'author-semantic-audit.jsonl')};oldNative={r['id']:r for r in lines(V/'native-russian-read.jsonl')}
rows=[];src=[];affected=[];refreshed=[];retained=[];dispositions=[]
for r in old:
 n=copy.deepcopy(r);t=m[r['id']]
 assert all(t[k]==r[k] for k in ['source','sourceValueSha256','sourceLine','hierarchy','pointer','currentValue'])
 n['revision']='02';n['technicalDisposition']=t['disposition'];n['consumerContract']=t['consumerContract']
 n['sourceContractArtifact']=str((T/'selector-binding-matrix.jsonl').relative_to(ROOT));n['sourceContractRowSha256']=uh(canonical(t))
 n['v1BaseContextSha256']=uh(canonical(contextBy[r['id']]))
 n['applicationAllowed']=False;n['targetApplied']=False
 n['applicationClass']='static-wording-candidate' if t['disposition']=='static-display-wording-candidate' else ('accepted-current-binding' if t['disposition']=='preserve-accepted-input72' else ('preserve-exactly' if r['status']=='preserve-exactly' else 'application-held'))
 n['staticWordingApplicable']=n['applicationClass'] in ['static-wording-candidate','accepted-current-binding']
 if r['id'] in newIds:
  assert r['target'] is None and t['disposition']=='static-display-wording-candidate'
  n['target']=auth[r['source']]['target'];n['targetUtf8Sha256']=uh(n['target']);n['status']='prepared-source-resolved';n['missingPredicate']=None
 elif n['applicationClass']=='application-held':
  n['status']='wording-preserved-application-held' if r['target'] is not None else 'source-default-preserved-application-held'
  n['missingPredicate']=load(T/'consumer-contracts.json')[t['consumerContract']]['action']
 if r['id'] in heldLabelIds:assert n['targetUtf8Sha256']==next(x['targetUtf8Sha256'] for x in heldLabels if x['id']==r['id'])
 if control(r['hierarchy']) in groupNotes:
  affected.append(r['id'])
  if r['target'] is not None:refreshed.append(r['id'])
 if r['status']=='needs-source' or r['id'] in heldLabelIds:dispositions.append(r['id'])
 if r['target'] is not None and r['id'] not in refreshed:
  assert oldAudits[r['id']]['sourceValueSha256']==r['sourceValueSha256']
  assert oldAudits[r['id']]['targetUtf8Sha256']==oldNative[r['id']]['targetUtf8Sha256']==r['targetUtf8Sha256']
  assert oldAudits[r['id']]['hierarchy']==r['hierarchy']
  retained.append({'id':r['id'],'source':r['source'],'target':r['target'],'sourceValueSha256':r['sourceValueSha256'],'targetUtf8Sha256':r['targetUtf8Sha256'],'v1BaseContextSha256':n['v1BaseContextSha256'],'semanticReceipt':oldAudits[r['id']],'nativeReceipt':oldNative[r['id']],'semanticArtifactSha256':sha(V/'author-semantic-audit.jsonl'),'nativeArtifactSha256':sha(V/'native-russian-read.jsonl'),'baseContextArtifactSha256':sha(V/'source-context.jsonl'),'applicability':'Exact unchanged source/target/base-context and unaffected consumer group; new technical source supplement does not alter this wording interpretation. Author receipts only, no inherited independent pass.'})
  assert n['source']==r['source'] and n['target']==r['target'] and n['v1BaseContextSha256']==uh(canonical(contextBy[r['id']]))
 rows.append(n);src.append({'id':r['id'],'v1BaseContext':contextBy[r['id']],'v1BaseContextSha256':n['v1BaseContextSha256'],'technicalBinding':t,'technicalBindingSha256':n['sourceContractRowSha256']})
assert len(refreshed)==36 and len(retained)==356 and len(affected)==108 and len(dispositions)==97
jl('ru.initial.jsonl',rows);jl('ru.prepared.jsonl',rows);jl('source-context.jsonl',src);jl('retained-v1-receipts.jsonl',retained)
jl('author-v1-refreshed-ids.jsonl',[{'id':i,'reason':'New complete chooser or unbound-control context actually reread; v1 target unchanged.'} for i in refreshed])
chooser=load(T/'cheat-chooser-contract.json');fixtures=[]
for c,note in groupNotes.items():
 rs=[r for r in rows if control(r['hierarchy'])==c]
 assert len(rs)==18
 pair=next((p for p in chooser['pairs'] if any(i in {r['id'] for r in rs} for f in p['faces'] for i in f['ids'])),None)
 fixtures.append({'control':c,'ids':[r['id'] for r in rs],'rows':[{'id':r['id'],'source':r['source'],'target':r['target'],'hierarchy':r['hierarchy'],'applicationClass':r['applicationClass']} for r in rs],'chooser':pair,'unbound':chooser['unboundControl'] if c=='UnlockMovies' else None,'authorSemanticJudgment':note['semantic'],'separateRussianJudgment':note['native'],'assembly':'Three parallel six-layer groups: heading, true face and false face. No concatenation or translated identity dispatch.','runtime':'not-run'})
out('complete-chooser-fixtures.json',fixtures)
semantic=[];native=[]
for r in rows:
 if r['id'] not in newIds and r['id'] not in refreshed:continue
 c=control(r['hierarchy']);assert c in groupNotes
 note=auth[r['source']]['semantic'] if r['id'] in newIds else 'Target retained exactly and actually reread in full changed consumer context. '+groupNotes[c]['semantic']
 nativeNote=auth[r['source']]['native'] if r['id'] in newIds else groupNotes[c]['native']
 semantic.append({'id':r['id'],'source':r['source'],'target':r['target'],'sourceValueSha256':r['sourceValueSha256'],'targetUtf8Sha256':r['targetUtf8Sha256'],'v1BaseContextSha256':r['v1BaseContextSha256'],'sourceContractRowSha256':r['sourceContractRowSha256'],'control':c,'rationale':note,'completeGroupRationale':groupNotes[c]['semantic'],'verdict':'pass-author-wording-only','coverageKind':'new-caption' if r['id'] in newIds else 'refreshed-v1-target','independent':False})
 native.append({'id':r['id'],'target':r['target'],'targetUtf8Sha256':r['targetUtf8Sha256'],'control':c,'rationale':nativeNote,'completeGroupRationale':groupNotes[c]['native'],'verdict':'pass-separate-author-Russian-read','independent':False})
assert len(semantic)==len(native)==96
jl('author-semantic-delta.jsonl',semantic);jl('native-russian-delta.jsonl',native)
jl('author-semantic-final.jsonl',[next(x for x in semantic if x['id']==r['id']) if r['id'] in newIds or r['id'] in refreshed else oldAudits[r['id']] for r in rows if r['target'] is not None])
jl('native-russian-final.jsonl',[next(x for x in native if x['id']==r['id']) if r['id'] in newIds or r['id'] in refreshed else oldNative[r['id']] for r in rows if r['target'] is not None])
jl('source-disposition-delta.jsonl',[{'id':r['id'],'oldStatus':oldBy[r['id']]['status'],'newStatus':r['status'],'oldMissingPredicate':oldBy[r['id']]['missingPredicate'],'newDisposition':r['technicalDisposition'],'consumerContract':r['consumerContract'],'applicationClass':r['applicationClass'],'target':r['target'],'sourceContractRowSha256':r['sourceContractRowSha256']} for r in rows if r['id'] in dispositions])
jl('protected-and-held.jsonl',[r for r in rows if r['applicationClass'] in ['application-held','preserve-exactly']])
jl('ru.target-delta.jsonl',[{'id':r['id'],'beforeTarget':None,'target':r['target'],'source':r['source'],'sourceValueSha256':r['sourceValueSha256'],'targetUtf8Sha256':r['targetUtf8Sha256']} for r in rows if r['id'] in newIds])
out('counts.json',{'assigned':576,'newCaptions':60,'v1TargetsUnchanged':392,'refreshedV1Targets':36,'unaffectedV1AuthorReceiptsRetained':356,'finalNonnullWording':452,'staticCandidates':434,'alreadyAcceptedInput72':12,'applicableNonnullFields':446,'applicationHeld':37,'applicationHeldNonnullWording':6,'applicationHeldNull':31,'protectedValues':93,'newAuthorSemanticRows':96,'newSeparateRussianRows':96,'authorFinalCovered':452,'independentReview':'pending'})
out('findings-and-delta.json',{'objectiveWordingFindings':[],'consolidatedCorrectionBatch':[],'changedTargetIds':[r['id'] for r in rows if r['id'] in newIds],'targetRepairDelta':[],'newCaptionCount':60,'unchangedV1TargetCount':392,'dispositionDeltaCount':97,'refreshedContextWordings':36,'countCorrection':'54 is rejected: five controls x2 faces x6 layers=60. Six preexisting UnlockMovies labels are separately application-held, not new active statuses.','v1Supersession':'Revision02 supersedes v1 static display proposal only for this bounded preparation stage. All40 historical v1 files remain immutable.','globalGates':{'ordinaryTranslationEntryAllowed':False,'sourceGateAccepted':False,'wholeGameAccepted':False},'targetApplied':False})
requiredContext=[r['id'] for r in rows if r['id'] in set(affected)|set(dispositions)]
for fn,ids in [('changed-ids.txt',[r['id'] for r in rows if r['id'] in newIds]),('closure-ids.txt',[r['id'] for r in rows if r['target'] is not None]),('delta-author-read-ids.txt',[r['id'] for r in rows if r['id'] in newIds or r['id'] in refreshed]),('affected-context-ids.txt',requiredContext),('source-disposition-changed-ids.txt',dispositions),('retained-v1-author-ids.txt',[r['id'] for r in retained]),('context-only-ids.txt',[r['id'] for r in rows if r['target'] is None]),('repair-delta-ids.txt',[])]:
 (P/fn).write_text(''.join(x+'\n' for x in ids))
out('review-closure.json',{'cycle':'revision-02','previousCycle':{'path':str((V/'review-closure.json').relative_to(ROOT)),'sha256':sha(V/'review-closure.json'),'targetSha256':sha(V/'ru.prepared.jsonl')},'newTargetIds':60,'newAuthorSemanticReadIds':96,'unchangedV1ReceiptsRetained':356,'contextAndSourceDispositionChanges':len(requiredContext),'sourceDispositionChanges':97,'fullFinalIndependentWordingClosure':452,'separateNullContext':124,'independentReview':'pending; parent reviews whole final576 packet once','rules':'All nonnull wording IDs, including six application-held potential labels, enter full first independent closure. All124 null members are separate exact context. Delta author read covers new60 + actual refreshed36; source-disposition list97 and affected-context list127 kept separately. Old author evidence only retained by exact source/target/base-context hash.','lists':{f.name:{'sha256':sha(f),'count':len(f.read_text().splitlines()),'newline':'UTF-8 LF; terminal LF iff nonempty'} for f in P.glob('*-ids.txt')},'noInheritedIndependentPass':True,'mandatoryRegressions':'mandatory-regressions.json'})
newPins={str((T/'output-code-pins.json').relative_to(ROOT)):sha(T/'output-code-pins.json')};newPins.update(pins)
for f in V.iterdir():
 if f.is_file():newPins[str(f.relative_to(ROOT))]=sha(f)
out('input-pins.json',newPins)
out('coverage-read-evidence.json',{'authorSession':'01a18634-381a-71e1-9143-4ca2d43dd59b','model':'gpt-6.1-sol','reasoning':'high','provider':'openai','requiredReferencesReused':'Unchanged mandatory workflow and full approved171-entry working glossary read in v1; all624 v1 input pins reverified.','sourceDeltaRead':'Pinned complete consumer-contracts/cheat-chooser contract, complete CheatsMenu CIL, exact60 delta IDs and six held labels; whole576 matrix reconciled against unchanged v1 ID/source/current values.','newSemanticRead':96,'separateRussianRead':96,'unaffectedV1ReadsRetained':356,'allFinalNonnullCovered':452,'unreadAssignedIds':[],'sourceHolds':'37 application-held members remain fully explicit; no runtime/default/diagnostic acceptance from static wording.','newExtraction':False,'nestedJobs':0,'targetApplied':False})
print(json.dumps(load(P/'counts.json')))
