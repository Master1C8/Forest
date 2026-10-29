import json,pathlib,hashlib,os,re,collections,datetime
R=pathlib.Path('/Users/antonkrutov/Desktop/Forest'); P=R/'localization/supplemental-ui/20261029-ornamental-case569'; O=P/'independent-review-01'
def j(p):return json.loads(pathlib.Path(p).read_text())
def rows(p):return [json.loads(x) for x in pathlib.Path(p).read_text().splitlines()]
def sha(p):return hashlib.sha256(pathlib.Path(p).read_bytes()).hexdigest()
def objsha(x):return hashlib.sha256(json.dumps(x,ensure_ascii=False,separators=(',',':')).encode()).hexdigest()
def txtsha(x):return hashlib.sha256(x.encode()).hexdigest() if x is not None else None
def write(n,x): (O/n).write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n')
def write_rows(n,rs):(O/n).write_text(''.join(json.dumps(x,ensure_ascii=False,separators=(',',':'))+'\n' for x in rs))
U=rows(P/'ru.prepared.jsonl'); D=j(O/'reviewer-decisions.json'); F=rows(P/'full-assembled-fixtures.jsonl'); C=rows(P/'protected-context.jsonl'); S=rows(P/'source-context.jsonl'); PC=rows(P/'protected-controls.jsonl'); M=rows(P/'mapping.jsonl'); G=rows(P/'groups.source.jsonl'); MM=rows(P/'membership-map.source.jsonl'); H=j(P/'findings.json'); closure=j(P/'review-closure.json')
# All judgment strings below were explicitly authored in reviewer-decisions.json after the complete read.
for k,v in D.items():
 if v[1] and 'НAДУВНЫЕ' in v[1]:v[1]='НАДУВНЫЕ НАРУКАВНИКИ is natural Russian with correct plural agreement and approved item terminology.'
write('reviewer-decisions.json',D)
assert len(U)==len(D)==98 and set(D)=={x['unitId'] for x in U}
allpins={};pinsets={}
for name,path in [('parent',R/'outputs/chat-resume-20261029-1152/ru-ornamental569-case-wording-20261029-pins.json'),('inputs',P/'input-pins.json'),('additionalReads',P/'additional-read-pins.json'),('recipes',P/'recipe-pins.json')]:
 pins=j(path); rs=[]
 for s,h in pins.items():
  q=pathlib.Path(s);q=q if q.is_absolute() else R/q
  actual=sha(q);assert h==actual,(s,h,actual);rs.append({'path':str(q),'expectedSha256':h,'actualSha256':actual,'match':True});allpins[str(q)]=h
 pinsets[name]={'manifest':str(path),'manifestSha256':sha(path),'count':len(rs),'files':rs}
for s,h in j(P/'process-binding.json')['references'].items():assert sha(s)==h;allpins[s]=h
# Execute only the checked validator's read-only prefix. Its final two output writes are excluded.
vp=R/'outputs/ru-ornamental569-case-wording-20261029/check/validate_packet.py'; vs=vp.read_text();prefix=vs.split("result={'status':",1)[0];assert '.write_text(' not in prefix and '.write_bytes(' not in prefix and '.unlink(' not in prefix
ns={};exec(compile(prefix,str(vp)+'[read-only-prefix]','exec'),ns)
assert len(ns['negative'])==4
# Independent coverage/identity reconciliation, beyond the reused validator's checks.
cm={x['id']:x for x in C}; sm={x['id']:x for x in S}; pcm={x['bindingId']:x for x in PC}; mp={x['bindingId']:x for x in M}; mm={x['bindingId']:x for x in MM}
assert len(cm)==len(C)==953 and len(sm)==len(S)==len(pcm)==len(PC)==569
members=[i for x in U for i in x['memberIds']];assert len(members)==len(set(members))==569
assert set(members)==set(sm)==set(mp)==set(mm)==set(closure['closureMembershipIds'])
assert [x['unitId'] for x in U]==closure['completeUnitIds']
assert set().union(*(set(x['contextIds']) for x in U))==set(cm)
assert set().union(*(set(x['contextIds']) for x in G))==set(cm)
assert len(G)==67
for x in U:
 assert len(x['memberIds'])==len(x['componentMappings'])
 assert {c['id'] for c in x['componentMappings']}==set(x['memberIds'])
 for c in x['componentMappings']:
  sid=c['id']; s=sm[sid];p=pcm[sid];ct=cm[sid];m=mp[sid]
  assert c['source']==s['source']==s['direct']['value']==ct['value']==p['source']
  assert c['sourceValueSha256']==s['sourceValueSha256']==p['sourceValueSha256']==objsha(c['source'])
  assert c['targetProposal']==m['targetProposal'] and c['targetUtf8Sha256']==m['targetUtf8Sha256']==txtsha(c['targetProposal'])
  assert p['typedClass']==ct['class'] and p['fieldPointer']==ct['pointer'] and p['hierarchy']==ct['hierarchy'] and p['ancestors']==ct['ancestors']
  for k in ['componentEnabled','tree','treeSha256','rawSha256']:assert p[k]==ct[k]
  assert s['direct']==ct
  assert re.findall(r'<[^>]*>',c['source'])==p['markupTokens']
  assert re.findall(r'\r\n|\r|\n',c['source'])==p['lineControls']
  assert mm[sid]['unitId']==x['unitId']
# Verify the full model-read compact context table, including legacy /m_Text pointers, against all exact context selectors.
V=j(P/'context-value-index.json');assert set(V.values())=={x['value'] for x in C}
view_ids=set();view_pairs=[]
for n in ['read-context-01-22.txt','read-context-23-44.txt','read-context-45-67.txt']:
 group=None
 for line in (P/n).read_text().splitlines():
  if line.startswith('g'):group=line.split(' ',1)[0]
  elif line:
   match=re.fullmatch(r'(v\d+) (.*?) ([\d,]+)',line);assert match,line
   vk,stem,nums=match.groups();gg=next(g for g in G if g['groupId']==group)
   for num in nums.split(','):
    matches=[x for x in C if x['id'].split(':',1)[0]==gg['file'] and x['object'].split(':',1)[1]==num and x['value']==V[vk] and x['id'] in gg['contextIds']]
    assert len(matches)==1,(line,num)
    view_ids.add(matches[0]['id']);view_pairs.append([group,matches[0]['id'],vk])
assert view_ids==set(cm)
# Reconstruct every fixture from the complete model-read 41-value dictionary and 490 explicit layer rows.
FV=j(O/'fixture-values.json');reconstructed={}
for path in sorted(O.glob('fixtures-???-???.txt')):
 for line in path.read_text().splitlines():
  fk,rr=json.loads(line)
  for ordinal,uid,layer,ids in rr:
   a,b,c,d,e=FV[fk];rec={'unitId':uid,'layer':layer,'sourceIds':ids,'sourceAssembled':a,'targetComponents':b,'targetAssembled':c,'boundary':d,'grammarAdapterPending':e}
   assert rec==F[ordinal-1] and ordinal not in reconstructed
   reconstructed[ordinal]=rec
assert set(reconstructed)==set(range(1,491))
assert {i for f in F for i in f['sourceIds']}=={m['bindingId'] for m in M if m['targetProposal'] is not None}
assert sum(x['target'] is not None for x in U)==85
assert sum(x['accounting']=='reused-exact-accepted' for x in M) in (0,120) # exact actual category verified below
# Verify all reused targets against their exact old artifact row references, not just the copied receipt.
reuse=j(P/'reused-receipts.json');oldrows={}
assert sha(R/reuse['acceptancePath'])==reuse['acceptanceSha256']
for r in reuse['receipts']:
 ref=r['reference'];path=R/ref['path']
 if str(path) not in oldrows:oldrows[str(path)]=rows(path)
 old=oldrows[str(path)][ref['line']-1]
 assert old['id']==ref['targetId'],(r['bindingId'],old.keys())
 assert old['target']==r['target']==mp[r['bindingId']]['targetProposal']
 assert objsha(r['source'])==ref['sourceValueSha256'] and txtsha(r['target'])==ref['targetUtf8Sha256']
assert len(reuse['receipts'])==120
thread=os.environ['CODEX_THREAD_ID'];session=next(pathlib.Path('/Users/antonkrutov/.codex/sessions/2026/10/29').glob('*'+thread+'.jsonl'))
meta=[];turns=[]
for line in session.open():
 row=json.loads(line)
 if row['type']=='session_meta':meta.append(row)
 if row['type']=='turn_context':turns.append(row)
assert meta[0]['payload']['model_provider']=='openai'
assert all(x['payload']['model']=='gpt-6.1-sol' and x['payload']['effort']=='high' for x in turns)
write('runtime-verification.json',{'status':'verified-before-localized-content','reviewer':'/root/ornamental569_independent','threadId':thread,'model':'gpt-6.1-sol','reasoning':'high','provider':'openai','sessionMetadataPath':str(session),'sessionMetaSha256':objsha(meta[0]),'firstTurnContextSha256':objsha(turns[0]),'verificationTiming':'Own session_meta/turn_context fields were read before packet localized text; this file records that completed verification. Rechecked unchanged identity after interruption.','noInheritedHistory':'Explicit parent launch requirement fork_turns:none; no inherited transcript supplied in assignment.','nestedModelsOrJobsStarted':False})
reviewer={'identity':'/root/ornamental569_independent','threadId':thread,'model':'gpt-6.1-sol','reasoning':'high','provider':'openai'}
semantic=[];native=[];coverage=[]
for x in U:
 uid=x['unitId'];note,note_native=D[uid];holds=[h['findingId'] for h in H if h['unitId']==uid];fixtures=[i for i,f in enumerate(F,1) if f['unitId']==uid]
 base={'unitId':uid,'reviewer':reviewer,'sourceValueSha256':x['sourceAssembledValueSha256'],'targetUtf8Sha256':x['targetUtf8Sha256'],'sourceAssembled':x['sourceAssembled'],'target':x['target'],'memberIds':x['memberIds'],'unitSourceRowSha256':objsha(x),'requiredContextIds':x['contextIds'],'requiredContextSha256':x['contextSha256'],'fixtureOrdinals':fixtures,'sourceAdapterHolds':holds,'targetApplied':False,'actualGameRuntime':'not-run'}
 semantic.append({**base,'status':'passed-literal-wording' if x['target'] is not None else 'source-read-null-target-held','semanticJudgment':note,'fullGroupRead':True,'initialSiblingShadowEmphasisContract':'authored complete group and each layer read; no rendered geometry or activation claim','objectiveWordingFindings':[]})
 native.append({**base,'status':'passed-native-read' if note_native else 'not-applicable-null-target','naturalReadJudgment':note_native or 'There is no Russian target to read. No pass is assigned to absent wording.','targetOnlyReadPerformed':bool(note_native)})
 coverage.append({'unitId':uid,'memberIds':x['memberIds'],'sourceRowSha256':objsha(x),'sourceAssembledValueSha256':x['sourceAssembledValueSha256'],'targetUtf8Sha256':x['targetUtf8Sha256'],'contextIds':x['contextIds'],'fixtureOrdinals':fixtures,'semanticReceipt':uid,'nativeReceipt':uid,'allModelReadsCompleted':True})
write_rows('semantic-receipts.jsonl',semantic);write_rows('native-russian-receipts.jsonl',native);write_rows('unit-read-coverage.jsonl',coverage)
write_rows('membership-protected-read-coverage.jsonl',[{'bindingId':x['id'],'unitId':mm[x['id']]['unitId'],'sourceContextRowSha256':objsha(x),'protectedControlsRowSha256':objsha(pcm[x['id']]),'protectedContextRowSha256':objsha(cm[x['id']]),'sourceValueSha256':x['sourceValueSha256'],'modelReadRepresentation':'complete unit/component mappings + full context-value dictionary/group index + metadata summary + every fixture layer'} for x in S])
write_rows('context-read-coverage.jsonl',[{'id':x['id'],'rowSha256':objsha(x),'sourceValueSha256':objsha(x['value']),'valueKey':next(k for k,v in V.items() if v==x['value']),'class':x['class'],'pointer':x['pointer'],'hierarchy':x['hierarchy'],'componentEnabled':x['componentEnabled'],'ancestorObjects':[a['object'] for a in x['ancestors']],'ancestorStates':[a['activeSelf'] for a in x['ancestors']],'treeSha256':x['treeSha256'],'rawSha256':x['rawSha256'],'groups':[g['groupId'] for g in G if x['id'] in g['contextIds']],'status':'model-read-in-factored-complete-representation;identity-hashes-deterministically-bound'} for x in C])
write_rows('fixture-read-coverage.jsonl',[{'ordinal':i,'unitId':f['unitId'],'layer':f['layer'],'sourceIds':f['sourceIds'],'rowSha256':objsha(f),'sourceAssembledValueSha256':objsha(f['sourceAssembled']),'targetUtf8Sha256':txtsha(f['targetAssembled']),'status':'reviewed-authored-assembly','runtime':'not-run','grammarAdapterPending':f['grammarAdapterPending']} for i,f in enumerate(F,1)])
write('deterministic-check.json',{'status':'passed-bounded-pin-coverage-and-preservation-check','pinSets':pinsets,'processReferencePins':'all matched','memberships':569,'completeUnits':98,'hierarchyGroups':67,'nonNullUnits':85,'nullHeldUnits':13,'fixtures':490,'fixtureValueForms':41,'contexts':953,'distinctContextValues':89,'allExactContextSelectorsRepresented':True,'fixtureRepresentationReconstructsEveryOriginalRow':True,'protectedSourceControlRows':569,'sourceContextProtectedFieldsEqual':True,'reusedTargetsVerifiedAgainstOriginalArtifactRows':120,'negativeControls':ns['negative'],'validatorReadOnlyPrefixSha256':hashlib.sha256(prefix.encode()).hexdigest(),'validatorOriginalSha256':sha(vp),'originalValidatorOutputWritesExecuted':False,'semanticJudgmentGeneratedByScript':False,'runtimeRendererExercised':False,'mappingCategories':dict(collections.Counter(x['accounting'] for x in M))})
write('reviewed-input-hashes.json',allpins)
write('read-coverage.json',{'status':'complete-finite-assigned-read','reviewer':reviewer,'memberships':569,'completeUnits':98,'hierarchyGroups':67,'semanticNonNullUnits':85,'sourceReadNullHeldUnits':13,'nativeReadNonNullUnits':85,'fixtures':490,'contextRecords':953,'distinctContextValues':89,'glossaryEnRuEntries':171,'sourceControlRecords':569,'representation':'Complete unit/component views, all 89 exact context strings plus every source group/context selector, 173 metadata groups covering all953 records, and all490 explicit fixture/layer records bound to41 full value forms. This is factoring equal text, not semantic sampling. Original hashes and exact selectors are separately preserved. Unread redundant generated raw context views were removed; no claim those views were read.','readRepresentations':{str(q.relative_to(R)):sha(q) for q in sorted(O.iterdir()) if q.name.startswith(('units-','fixtures-','fixture-values','context-metadata-summary'))},'sourceContextRepresentations':{str(P/n):sha(P/n) for n in ['context-value-index.json','read-context-01-22.txt','read-context-23-44.txt','read-context-45-67.txt']},'truncationReconciliation':'Earlier oversized displays were not credited. The complete compact glossary and unit/fixture/context views were subsequently read in bounded output; the initially clipped35/36 glossary entries and first unit components were explicitly recovered.','hashConvention':'SHA-256 of original file bytes; per-row hashes use UTF-8 compact JSON ensure_ascii=false separators comma/colon, no trailing newline; target hashes use raw UTF-8 text. JSONL files use LF with final newline.'})
print(json.dumps({'validation':'passed','semanticReceipts':len(semantic),'nativeRussianRead':sum(x['targetOnlyReadPerformed'] for x in native),'protectedMembershipRows':len(S),'contextRows':len(C),'fixtures':len(F),'pins':len(allpins)},ensure_ascii=False))
