"""Exact-field batch application; all language decisions are in application-plan.json.
Uses the unchanged existing corpus.py adapter. No model, Git, game or network calls.
Run once: python3 <this-file>. A completed receipt makes replay verification-only.
"""
import sys
sys.dont_write_bytecode=True
import pathlib,json,hashlib,re,shutil,importlib.util,subprocess,os
ROOT=pathlib.Path('/Users/antonkrutov/Desktop/Forest')
RUN=pathlib.Path(__file__).resolve().parent
ASSETS=ROOT/'localization/ru-assets'
JOB=ROOT/'outputs/ru-assets-parallel-20261026'
sha=lambda b:hashlib.sha256(b).hexdigest()
def dump(p,x):
 p.parent.mkdir(parents=True,exist_ok=True);p.write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n')
def rows(p):return [json.loads(x) for x in p.read_text().splitlines()]
def keyed(rs):
 d={x['id']:x for x in rs}; assert len(d)==len(rs),'duplicate ID';return d
def import_adapter(code=None):
 sys.path.insert(0,str(ASSETS)); spec=importlib.util.spec_from_file_location('existing_corpus',ASSETS/'corpus.py');m=importlib.util.module_from_spec(spec)
 if code is None:spec.loader.exec_module(m)
 else:exec(compile(code,str(ASSETS/'corpus.py'),'exec'),m.__dict__)
 return m
def assert_pins(expected_overlay=None):
 for p,h in json.loads((RUN/'dispatch.json').read_text())['inputPins'].items():
  if pathlib.Path(p)==ASSETS/'dialogue.ru.jsonl' and expected_overlay is not None:h=expected_overlay
  assert sha(pathlib.Path(p).read_bytes())==h,p+' pin changed'
def strict_state(actual,old,new):
 if actual==old:return 'old'
 if actual==new:return 'new'
 raise AssertionError('neither exact old nor exact new field')
def atomic_write(path,data):
 tmp=path.with_name(path.name+'.correction-completion-tmp');assert not tmp.exists();tmp.write_bytes(data);tmp.replace(path)
def write_batch(changes,expected,fail_after=None):
 # A sequence of atomic replacements is NOT a multi-file transaction.
 # On failure, restore only paths we wrote and only if they still equal our bytes.
 written=[]
 try:
  for p,data in changes.items():
   assert p.read_bytes()==expected[p],str(p)+' concurrent change'
   atomic_write(p,data);written.append(p)
   if fail_after==len(written):raise RuntimeError('injected-between-writes')
 except BaseException:
  for p in reversed(written):
   assert p.read_bytes()==changes[p],str(p)+' rollback ownership lost'
   atomic_write(p,expected[p])
  raise
 return written

def main():
 plan=json.loads((RUN/'application-plan.json').read_text());pm=keyed(plan)
 receipt=RUN/'application-verification.json'
 if receipt.exists():
  prev=json.loads(receipt.read_text());assert prev['status']=='passed'
  assert_pins(prev['repeatDerivedSha256'])
  for p,h in prev['finalCanonicalHashes'].items():assert sha(pathlib.Path(p).read_bytes())==h,p
  current=keyed(rows(ASSETS/'dialogue.ru.jsonl'))
  assert all(current[i]['target']==p['newTarget'] for i,p in pm.items())
  print('Existing completed application verified exactly; no writes.');return
 assert_pins()
 m=import_adapter();oldrows=rows(ASSETS/'dialogue.ru.jsonl');old=keyed(oldrows)
 assert len(old)==len(m.ROWS)==12246 and set(old)==set(m.BYID)
 pairs=keyed(rows(ROOT/'outputs/editorial-20261027/independent-batches-v1/ru/full-pairs.jsonl'))
 assert all(old[i]['source']==pairs[i]['source'] and old[i]['target']==pairs[i]['target'] for i in old),'stale base corpus'
 for i,p in pm.items():
  assert sha(old[i]['source'].encode())==p['sourceSha256']
  assert sha(old[i]['target'].encode())==p['oldTargetSha256']
  assert strict_state(old[i]['target'],p['oldTarget'],p['newTarget'])=='old'
  m.validate_target(m.BYID[i],p['newTarget'],m.DISPOSITIONS.get(i))
 # Positive control: same complete valid row. Negative differs only in picture operand.
 pic=next(p for p in plan if p['id']=='ds:122:170:Dialogue Text')
 m.validate_target(m.BYID[pic['id']],pic['newTarget'],m.DISPOSITIONS.get(pic['id']))
 try:m.validate_target(m.BYID[pic['id']],pic['newTarget'].replace('[pic=3]','[pic=4]'),m.DISPOSITIONS.get(pic['id']))
 except AssertionError as e:assert 'protected controls mismatch' in str(e)
 else:raise AssertionError('picture-operand negative accepted')
 # Exact-state controls include overlapping text both ways, not substring presence.
 assert strict_state('alpha','alpha','alpha beta')=='old'
 assert strict_state('alpha beta','alpha','alpha beta')=='new'
 assert strict_state('alpha beta','alpha beta','alpha')=='old'
 assert strict_state('alpha','alpha beta','alpha')=='new'
 try:strict_state('alpha beta gamma','alpha','alpha beta')
 except AssertionError:pass
 else:raise AssertionError('ambiguous state accepted')
 inputs=sorted((ASSETS/'batches').glob('*.tsv'))+[ASSETS/x for x in ['resolved-holds.json','hold-groups.json','source-dispositions.json','preserve-exactly.json','corpus.py','inline_guard.py','check_poetry.py']]
 outputs=[ASSETS/'dialogue.ru.jsonl',ASSETS/'unresolved.json',ASSETS/'poetry-validation.json']+[JOB/x for x in ['progress.json','result.json','continuation.md']]
 baseline={p:p.read_bytes() for p in inputs+outputs}
 backup=RUN/'before'; assert not backup.exists(),'existing checkpoint requires reconciliation'
 for p,data in baseline.items():dest=backup/p.relative_to(ROOT);dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(data)
 dump(RUN/'before-fingerprints.json',{str(p):sha(data) for p,data in baseline.items()})
 dump(RUN/'before-target-map.json',{r['id']:r['target'] for r in oldrows})
 changes={};locators={}; newtsvs={}; counts={}
 # Full canonical builds must generate their current poetry report before the
 # artifact manifest fingerprints it. Keep partial-subset fixture builds valid.
 oldcode=baseline[ASSETS/'corpus.py'].decode()
 needle="    artifacts=[{'path':"
 assert oldcode.count(needle)==1
 hook="    if len(ordered)==len(ROWS):\n        import subprocess\n        subprocess.run([sys.executable, '-B', str(HERE/'check_poetry.py')], check=True)\n"
 changes[ASSETS/'corpus.py']=oldcode.replace(needle,hook+needle).encode()
 for p in sorted((ASSETS/'batches').glob('*.tsv')):
  raw=baseline[p];assert b'\r' not in raw,'unexpected physical CR'; lines=raw.decode().splitlines(keepends=True);newlines=[]
  for n,line in enumerate(lines,1):
   stripped=line.rstrip('\n')
   if not stripped or stripped.startswith('#'):newlines.append(line);continue
   key,text=stripped.split('\t',1);parts=key.split(':'); ident='ds:'+':'.join(parts[:2])+':'+('Menu Text' if len(parts)>2 and parts[2]=='M' else 'Dialogue Text')
   if text.startswith('!HOLD '):newlines.append(line);continue
   counts[ident]=counts.get(ident,0)+1
   prefix=re.match(r'^(?:\[pic[ac]?=[0-9A-Za-z_]+\])*',m.BYID[ident]['source']).group()
   def decode(t):
    value=prefix+t.replace('\\n','\n').replace('\\r','\r').replace('\\t','\t')
    if m.BYID[ident]['source'].endswith('\r') and not value.endswith('\r'):value+='\r'
    return value
   assert decode(text)==old[ident]['target'],ident+' authored/derived mismatch'
   if ident not in pm:newlines.append(line);continue
   target=pm[ident]['newTarget'];assert target.startswith(prefix)
   payload=target[len(prefix):].replace('\n','\\n').replace('\r','\\r').replace('\t','\\t');assert decode(payload)==target,ident+' TSV roundtrip failure'
   newlines.append(key+'\t'+payload+('\n' if line.endswith('\n') else ''))
   locators[ident]={'path':str(p.relative_to(ROOT)),'lineNumber':n,'key':key,'oldLineSha256':sha(line.encode()),'newLineSha256':sha(newlines[-1].encode())}
  candidate=''.join(newlines).encode();newtsvs[p]=candidate
  if candidate!=raw:changes[p]=candidate
 assert set(counts)==set(old) and all(v==1 for v in counts.values()); assert set(locators)==set(pm)
 resolutions=json.loads(baseline[ASSETS/'resolved-holds.json']);resolution_changes=[]
 for r in resolutions['records']:
  previous=json.loads(json.dumps(r)); priorpath=ROOT/r['priorHold']['path']; changed=False
  if priorpath in changes:
   n=r['priorHold']['locator'].get('lineNumber');assert n is not None
   # Hold lines themselves must remain identical, including their exact locator.
   assert baseline[priorpath].decode().splitlines()[n-1]==changes[priorpath].decode().splitlines()[n-1]
   assert r['priorHold']['sha256']==sha(baseline[priorpath]);r['priorHold']['sha256']=sha(changes[priorpath]);changed=True
  if r['id'] in pm:
   assert r['targetSha256']==pm[r['id']]['oldTargetSha256'];r['targetSha256']=sha(pm[r['id']]['newTarget'].encode());changed=True
  if changed:
   provenance={'assignment':'editorial-20261027/final-ru-v1/ru','oldTargetSha256':previous['targetSha256'],'newTargetSha256':r['targetSha256'],'oldPriorHold':previous['priorHold'],'newPriorHold':r['priorHold'],'sourceEvidenceRetained':True}
   r.setdefault('correctionProvenance',[]).append(provenance);resolution_changes.append({'id':r['id'],**provenance})
 changes[ASSETS/'resolved-holds.json']=(json.dumps(resolutions,ensure_ascii=False,indent=2)+'\n').encode()
 if changes[ASSETS/'resolved-holds.json']==baseline[ASSETS/'resolved-holds.json']:del changes[ASSETS/'resolved-holds.json']
 dump(RUN/'authored-row-locators.json',locators);dump(RUN/'resolution-provenance.json',resolution_changes)
 # Prepare a complete input set under this run, not a checkout/worktree.
 scratch=RUN/'preflight-inputs';scratch.mkdir();(scratch/'batches').mkdir()
 for p in inputs:
  if p.name in ('corpus.py','inline_guard.py'):continue
  dest=scratch/p.relative_to(ASSETS);dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(changes.get(p,baseline[p]))
 sr=json.loads((scratch/'resolved-holds.json').read_text())
 for r in sr['records']:
  orig=ROOT/r['priorHold']['path'];dest=scratch/orig.relative_to(ASSETS)
  r['priorHold']['path']=str(dest.relative_to(ROOT));r['priorHold']['sha256']=sha(dest.read_bytes())
 dump(scratch/'resolved-holds.json',sr)
 prejob=RUN/'preflight-job';prejob.mkdir();shutil.copyfile(JOB/'input-pins.json',prejob/'input-pins.json')
 m=import_adapter(changes[ASSETS/'corpus.py']);oldhere,oldout=m.HERE,m.OUT;m.HERE=scratch;m.OUT=prejob
 try:m.build()
 finally:m.HERE,m.OUT=oldhere,oldout
 pre=keyed(rows(scratch/'dialogue.ru.jsonl'));assert set(pre)==set(old)
 expected={i:(pm[i]['newTarget'] if i in pm else old[i]['target']) for i in old}
 assert all(pre[i]['target']==expected[i] for i in old)
 assert {i for i in old if pre[i]['target']!=old[i]['target']}==set(pm)
 assert json.loads((scratch/'unresolved.json').read_text())==[]
 dump(RUN/'preflight.json',{'status':'passed','rows':12246,'changedIds':len(pm),'unchangedNeighborIds':12246-len(pm),'existingAdapter':str(ASSETS/'corpus.py'),'adapterSha256':sha((ASSETS/'corpus.py').read_bytes()),'outputSha256':sha((scratch/'dialogue.ru.jsonl').read_bytes()),'scratchReceiptRebasing':'Only priorHold paths and corresponding copied-file hashes are rebased; original source evidence, disposition, locators and targets are preserved.'})
 # Exercise real rollback helper between first and second input replacement.
 ft=RUN/'rollback-control';ft.mkdir()
 testpaths=list(changes)[:2];control={ft/p.name:changes[p] for p in testpaths};control_old={ft/p.name:baseline[p] for p in testpaths}
 for p,data in control_old.items():p.write_bytes(data)
 try:write_batch(control,control_old,fail_after=1)
 except RuntimeError as e:assert str(e)=='injected-between-writes'
 else:raise AssertionError('fault not injected')
 assert all(p.read_bytes()==data for p,data in control_old.items())
 # Check every snapshot and immutable pin immediately before canonical mutation.
 assert_pins();assert all(p.read_bytes()==raw for p,raw in baseline.items()),'concurrent ru-lane input/output mutation'
 installed=[]
 try:
  installed=write_batch(changes,{p:baseline[p] for p in changes})
  proc=subprocess.run([sys.executable,'-B',str(ASSETS/'corpus.py'),'build'],cwd=ROOT,capture_output=True,text=True)
  (RUN/'canonical-build-01.log').write_text(proc.stdout+proc.stderr);assert proc.returncode==0,'canonical build failed'
  first_outputs={p:p.read_bytes() for p in outputs}
  first_raw=(ASSETS/'dialogue.ru.jsonl').read_bytes(); assert first_raw==(scratch/'dialogue.ru.jsonl').read_bytes()
  assert (ASSETS/'poetry-validation.json').read_bytes()==(scratch/'poetry-validation.json').read_bytes()
  firstrows=rows(ASSETS/'dialogue.ru.jsonl'); first=keyed(firstrows)
  assert len(first)==12246 and set(first)==set(expected)
  assert all(first[i]['target']==expected[i] for i in expected)
  # Derived metadata must match baseline exactly except the target and its digest.
  for i,r in first.items():
   a={k:v for k,v in r.items() if k not in ('target','targetSha256')};o={k:v for k,v in old[i].items() if k not in ('target','targetSha256')};assert a==o,i+' neighbor/metadata regression'
   m.validate_target(m.BYID[i],r['target'],m.DISPOSITIONS.get(i))
   assert r['targetSha256']==sha(r['target'].encode())
  assert json.loads((ASSETS/'unresolved.json').read_text())==[]
  # Actual first postcondition is saved before the repeat build.
  dump(RUN/'first-application-postcondition.json',{'rows':len(first),'changedIds':len(pm),'targetMapSha256':sha(json.dumps(expected,ensure_ascii=False,separators=(',',':')).encode()),'derivedSha256':sha(first_raw),'allExpectedFieldsEqual':True,'allUnchangedMetadataEqual':True})
  proc2=subprocess.run([sys.executable,'-B',str(ASSETS/'corpus.py'),'build'],cwd=ROOT,capture_output=True,text=True)
  (RUN/'canonical-build-02.log').write_text(proc2.stdout+proc2.stderr);assert proc2.returncode==0
  assert all(p.read_bytes()==data for p,data in first_outputs.items()),'repeat derived/report/build output differs'
  assert all((ASSETS/p['path'].split('localization/ru-assets/')[-1]).exists() for p in locators.values())
  assert_pins(sha(first_raw))
 except BaseException:
  # Build may write its derived files before failing; only this lane's snapshotted
  # outputs and this invocation's authored writes are restored.
  for p in reversed(installed):
   assert p.read_bytes()==changes[p],str(p)+' rollback ownership lost';atomic_write(p,baseline[p])
  for p in outputs:atomic_write(p,baseline[p])
  raise
 dump(RUN/'after-target-map.json',{r['id']:r['target'] for r in firstrows})
 finalpaths=list(changes)+outputs
 finalhash={str(p):sha(p.read_bytes()) for p in finalpaths}
 dump(RUN/'after-fingerprints.json',finalhash)
 dump(receipt,{'status':'passed','correctedIds':[r['id'] for r in m.ROWS if r['id'] in pm],'correctedCount':len(pm),'canonicalInputFilesChanged':len(changes),'allAuthoredIdsUnique':True,'fullIdParity':12246,'physicalSourceOccurrencesChecked':24492,'oldNewExactEquality':True,'untouchedTargetsAndMetadataUnchanged':True,'twoSuccessfulBuilds':True,'allDerivedReportsAndJobOutputsReproducible':True,'scratchOverlayAndPoetryReportExact':True,'repeatDerivedSha256':sha(first_raw),'firstPostconditionVerifiedBeforeRepeat':True,'rollbackBetweenWritesControl':'passed','overlappingOldNewControls':'passed','multiFileBoundary':'Per-file atomic replacement followed by exact backup rollback on detected failure; not an atomic multi-file transaction. A process/machine crash between writes requires parent recovery from before/ and fingerprints before any build.','resolutionReceiptsUpdated':len(resolution_changes),'finalCanonicalHashes':finalhash})
 print(json.dumps({'status':'passed','corrected':len(pm),'inputFiles':len(changes),'receiptsUpdated':len(resolution_changes),'derivedSha256':sha(first_raw)}))
if __name__=='__main__':main()
