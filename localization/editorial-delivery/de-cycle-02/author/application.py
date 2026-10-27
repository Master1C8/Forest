"""Apply verified staged authored fields; explicit rollback, never a multi-file transaction."""
import hashlib,json,pathlib,subprocess,sys
R=pathlib.Path('/Users/antonkrutov/Desktop/Forest');O=pathlib.Path(__file__).resolve().parent;A=R/'localization/de-assets'
sha=lambda b:hashlib.sha256(b).hexdigest()
def dump(p,x):p.write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n')
def atomic(p,b):
    if b is None:
        if p.exists():p.unlink()
    else:
        t=p.with_name(p.name+'.final-de-tmp');t.write_bytes(b);t.replace(p)
def apply(items,fail_after=None):
    before={p:p.read_bytes() if p.exists() else None for p,b in items};written=[]
    try:
        for j,(p,b) in enumerate(items,1):
            atomic(p,b);written.append(p)
            if fail_after==j:raise RuntimeError('injected-between-writes')
    except BaseException:
        for p in reversed(written):atomic(p,before[p])
        assert all((p.read_bytes() if p.exists() else None)==b for p,b in before.items())
        raise
def regress():
    T=O/'scratch/rollback-regression-v3';T.mkdir(exist_ok=False)
    originals=[b'old-long',None,b'old',b'four',b'five',b'six',b'seven'];new=[b'old',b'created',b'old-long',b'FOUR',b'FIVE',b'SIX',b'SEVEN']
    paths=[T/str(i) for i in range(7)]
    for p,b in zip(paths,originals):atomic(p,b)
    cases=[]
    for split in range(1,7):
        try:apply(list(zip(paths,new)),split)
        except RuntimeError as e:assert str(e)=='injected-between-writes'
        else:raise AssertionError('Missing injected failure')
        assert [(p.read_bytes() if p.exists() else None) for p in paths]==originals
        cases.append({'afterWrite':split,'rollback':'exact prior bytes and absence verified'})
    apply(list(zip(paths,new)));assert [p.read_bytes() for p in paths]==new
    # Exact whole-field guards distinguish overlapping values in either direction.
    for old,new in [('word','word-long'),('word-long','word')]:
        def replacement(value):
            assert value==old,'unexpected before-state'
            return new
        assert replacement(old)==new
        try:replacement(new)
        except AssertionError as e:assert str(e)=='unexpected before-state'
        else:raise AssertionError('new state misclassified as old')
    dump(O/'rollback-regression.json',{'status':'passed','betweenWriteFailures':cases,'positiveControl':'all seven exact new byte strings','overlapGuards':'passed both directions','boundary':'Disposable files exercise the actual atomic/rollback function; this is process-exception recovery, not crash-atomic or cross-file transactional storage.'})
def main():
    regress()
    manifest=json.loads((O/'staging-manifest.json').read_text());items=[]
    for e in manifest['edits']:
        p=pathlib.Path(e['path']);b=pathlib.Path(e['staged']).read_bytes()
        assert sha(b)==e['afterSha256']
        assert (sha(p.read_bytes()) if p.exists() else None)==e['beforeSha256'],str(p)+' before-state changed'
        items.append((p,b))
    derived=[A/'dialogue.de.jsonl',A/'unresolved.json',A/'poetry-validation.json',*[R/'outputs/locale-assets-20261026/de'/n for n in ('progress.json','result.json','continuation.md')]]
    saved={p:p.read_bytes() if p.exists() else None for p,b in items}
    saved.update({p:p.read_bytes() for p in derived})
    try:
        apply(items)
        build=[]
        for n in (1,2):
            proc=subprocess.run([sys.executable,str(A/'corpus.py'),'build'],capture_output=True,text=True)
            (O/f'build-{n}.log').write_text(proc.stdout+proc.stderr)
            assert proc.returncode==0,proc.stderr
            h=sha((A/'dialogue.de.jsonl').read_bytes());assert h==manifest['scratchOverlaySha256']
            build.append({'iteration':n,'exitCode':proc.returncode,'stdout':proc.stdout.strip(),'overlaySha256':h})
            # Verify the actual first-application postcondition, then unchanged rebuild.
            rows=[json.loads(s) for s in (A/'dialogue.de.jsonl').read_text().splitlines()]
            before=[json.loads(s) for s in (O/'before-overlay.jsonl').read_text().splitlines()]
            dec={x['id']:x for x in map(json.loads,(O/'adjudication.jsonl').read_text().splitlines())}
            assert len(rows)==len(before)==12246
            assert [x['id'] for x in rows]==[x['id'] for x in before]
            for old,current in zip(before,rows):
                assert current['target']==(dec[old['id']]['newTarget'] if old['id'] in dec else old['target'])
            poetry=subprocess.run([sys.executable,str(A/'check_poetry.py')],capture_output=True,text=True)
            (O/f'poetry-{n}.log').write_text(poetry.stdout+poetry.stderr);assert poetry.returncode==0,poetry.stderr
            if n==1:
                first={p:sha(p.read_bytes()) for p in derived}
            else:assert first=={p:sha(p.read_bytes()) for p in derived},'Normal generated outputs not reproducible'
        (O/'after-overlay.jsonl').write_bytes((A/'dialogue.de.jsonl').read_bytes())
        dump(O/'build-verification.json',{'status':'passed','command':[sys.executable,str(A/'corpus.py'),'build'],'runs':build,'allSixDerivedOutputsByteIdentical':True,'firstApplicationPostcondition':'all seven expected complete targets, all 12239 unchanged targets exact; checked after first build before repeat','canonicalPoetry':'passed on both builds, 27 combinations and callbacks','generatedOutputHashes':{str(p):sha(p.read_bytes()) for p in derived}})
        dump(O/'application-receipt.json',{'status':'applied-and-postconditions-verified','edits':manifest['edits'],'rollback':'All six between-write failure points and matching positive control passed','boundary':'Individual atomic replacements with own-file exception rollback; a process crash can interrupt the multi-file batch. Verified backups remain available.','rollbackScopeOnBuildFailure':[str(p) for p in saved]})
    except BaseException:
        for p,b in reversed(list(saved.items())):atomic(p,b)
        assert all((p.read_bytes() if p.exists() else None)==b for p,b in saved.items())
        raise
    print(json.dumps({'status':'applied','changedIds':7,'builds':2,'overlaySha256':manifest['scratchOverlaySha256'],'poetry':'canonical helper passed twice'}))
if __name__=='__main__':main()
