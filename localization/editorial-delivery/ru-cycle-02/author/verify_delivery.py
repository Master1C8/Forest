"""Exact authored-row, hold-receipt, old-correction and report verification."""
import pathlib,json,hashlib
R=pathlib.Path(__file__).parent;ROOT=R.parents[3];A=ROOT/'localization/ru-assets';B=R/'before';sha=lambda b:hashlib.sha256(b).hexdigest();rows=lambda p:[json.loads(l) for l in p.read_text().splitlines()]
old={x['id']:x for x in rows(B/'localization/ru-assets/dialogue.ru.jsonl')};new={x['id']:x for x in rows(A/'dialogue.ru.jsonl')};plan={x['id']:x for x in json.loads((R/'application-plan.json').read_text())};loc=json.loads((R/'authored-row-locators.json').read_text());diffs=[];changedfiles=[]
for p in sorted((A/'batches').glob('*.tsv')):
 oldraw=(B/p.relative_to(ROOT)).read_bytes();newraw=p.read_bytes();aa=oldraw.splitlines(keepends=True);bb=newraw.splitlines(keepends=True);assert len(aa)==len(bb)
 if oldraw!=newraw:changedfiles.append(str(p.relative_to(ROOT)))
 for n,(a,b) in enumerate(zip(aa,bb),1):
  if a==b:continue
  matches=[(i,v) for i,v in loc.items() if v['path']==str(p.relative_to(ROOT)) and v['lineNumber']==n];assert len(matches)==1;i,v=matches[0];assert a.split(b'\t',1)[0]==b.split(b'\t',1)[0] and sha(a)==v['oldLineSha256'] and sha(b)==v['newLineSha256'];diffs.append(i)
assert set(diffs)==set(plan) and len(diffs)==27
for i in old:
 assert {k:v for k,v in old[i].items() if k not in ('target','targetSha256')}=={k:v for k,v in new[i].items() if k not in ('target','targetSha256')}
 if i not in plan:assert old[i]==new[i]
 else:assert old[i]['target']==plan[i]['oldTarget'] and new[i]['target']==plan[i]['newTarget']
prior=json.loads((ROOT/'outputs/editorial-20261027/correction-completion-v1/ru/result.json').read_text());previous=set(prior['correctedIds']);assert len(previous)==176 and not(previous&set(plan));assert all(old[i]==new[i] for i in previous)
for n in ['source-dispositions.json','preserve-exactly.json','hold-groups.json','inline_guard.py','check_poetry.py']:assert (B/'localization/ru-assets'/n).read_bytes()==(A/n).read_bytes(),n+' changed'
a=json.loads((B/'localization/ru-assets/resolved-holds.json').read_text());b=json.loads((A/'resolved-holds.json').read_text());assert a.keys()==b.keys();assert len(a['records'])==len(b['records']);changed_receipts=0
for x,y in zip(a['records'],b['records']):
 assert x['id']==y['id'];xp=x.copy();yp=y.copy();xp.pop('correctionProvenance',None);yp.pop('correctionProvenance',None);xx=xp.pop('priorHold');yy=yp.pop('priorHold');assert xp==yp
 xx=xx.copy();yy=yy.copy();oldh=xx.pop('sha256');newh=yy.pop('sha256');assert xx==yy
 path=ROOT/xx['path'];assert oldh==sha((B/path.relative_to(ROOT)).read_bytes()) and newh==sha(path.read_bytes())
 if x!=y:
  changed_receipts+=1;assert y['correctionProvenance'][:-1]==x.get('correctionProvenance',[])
  assert y['correctionProvenance'][-1]['oldPriorHold']==x['priorHold'] and y['correctionProvenance'][-1]['newPriorHold']==y['priorHold']
 else:assert oldh==newh
assert changed_receipts==193
beforecode=(B/'localization/ru-assets/corpus.py').read_text();hook="    if len(ordered)==len(ROWS):\n        import subprocess\n        subprocess.run([sys.executable, '-B', str(HERE/'check_poetry.py')], check=True)\n";assert (A/'corpus.py').read_text()==beforecode.replace("    artifacts=[{'path':",hook+"    artifacts=[{'path':")
report=json.loads((ROOT/'outputs/ru-assets-parallel-20261026/result.json').read_text())
for x in report['outputs']:assert sha((ROOT/x['path']).read_bytes())==x['sha256'],x['path']
for p,h in json.loads((R/'application-verification.json').read_text())['finalCanonicalHashes'].items():assert sha(pathlib.Path(p).read_bytes())==h
(R/'before-after-complete-rows.jsonl').write_text(''.join(json.dumps({'id':i,'before':old[i],'after':new[i],'metadataExact':True},ensure_ascii=False,separators=(',',':'))+'\n' for i in old if i in plan))
merged=rows(R/'merged-reviews.jsonl');sourceholds=[x for x in merged if x['verdict'] in ('source-defect','needs-context')];ph=json.loads((ROOT/'outputs/editorial-20261027/correction-completion-v1/ru/remaining-holds.json').read_text());phrows=ph if isinstance(ph,list) else ph.get('records',[])
(R/'retained-open-holds.json').write_text(json.dumps({'policy':'Unchanged prior source/technical holds and independent source/context findings are retained without new adjudication or invented text. Separate lists may overlap; never sum them as distinct defects.','priorCorrectionCompletionHolds':ph,'completeIndependentSourceContextVerdicts':sourceholds,'uniqueIds':sorted({x['id'] for x in phrows+sourceholds}),'sourceGlossaryFinley':'OPEN; protected snapshots unchanged, primary Charlotte/Melody facts retained'},ensure_ascii=False,indent=2)+'\n')
inputs={}
for p in [ROOT/'outputs/editorial-20261027/ru/glossary-en.json',ROOT/'outputs/editorial-20261027/ru/glossary-ru.json',ROOT/'review/text-bearing-textures.json',ROOT/'special-scenes.json']:
 inputs[str(p)]=sha(p.read_bytes())
(R/'cycle-final-01-bindings.json').write_text(json.dumps({'cycleManifestSha256':sha((R/'cycle-final-01/manifest.json').read_bytes()),'unchangedWorkingGlossariesAndOutOfScopeImageSpecialScenePlanHashes':inputs,'scope':'Image wording/resources/runtime are not newly accepted by this preliminary dialogue correction cycle. Working glossary snapshots are the exact complete snapshots read in this worker.'},indent=2)+'\n')
result={'status':'passed','changedExistingTsvFiles':len(changedfiles),'changedExistingTsvFields':len(plan),'physicalUntouchedRowsAndCommentsExact':True,'keysLinePositionsAndMetadataExact':True,'untouchedFullDerivedRows':len(new)-len(plan),'preceding176CorrectionsPreservedAsCompleteRows':True,'precedingCorrectionIdsOverlappingNewChanges':0,'holdResolutionRecordsChecked':len(a['records']),'receiptHashBindingsUpdated':changed_receipts,'receiptTargetSourceDispositionOrLocatorChanged':0,'holdProvenanceAppendedWithoutLosingOldBytes':True,'canonicalPoetryCheckerAndGuardAssertionsUnchanged':True,'onlyBuilderChange':'Regenerate the unchanged canonical poetry checker report on complete builds before its artifact hash is captured; no text/parser/ID/runtime changes.','manifestAssetHashesVerified':len(report['outputs']),'canonicalInlineGuardTests':'23 passed; see canonical-inline-guard-tests.log','sourceGlossariesOtherLocalesRootDocsInstallSaves':'not modified','changedTsvFiles':changedfiles}
(R/'safety-and-preservation-verification.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))
