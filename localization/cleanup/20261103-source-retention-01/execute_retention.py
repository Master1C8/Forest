"""Apply the reviewed storage selection after remote recovery verification."""
import argparse
import datetime
import gzip
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import shutil
import stat
import subprocess

ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('forest_storage',ROOT/'tools/forest_storage.py')
s=importlib.util.module_from_spec(spec);spec.loader.exec_module(s)


def write(p,x):
    with p.open('x') as f:json.dump(x,f,indent=2);f.write('\n')


def signature(p):
    t=p.lstat();return [t.st_dev,t.st_ino,t.st_size,t.st_mtime_ns]


def save_path(name):
    p=Path(name);n=p.name.lower()
    return n.startswith('tfol.') or 'savegame' in n or 'playerprefs' in n or p.suffix.lower() in {'.sav','.save','.savegame','.settings'} or name.startswith('localization/owner-saves/')


def idle():
    rows=subprocess.check_output(['ps','-axo','pid=,args='],text=True).splitlines()
    hits=[r for r in rows if ('The Forest of Love.exe' in r or 'run_locale_completion.py' in r or 'forest_localize.py build' in r or 'codex exec --ignore-user-config' in r and '/Forest' in r)]
    assert not hits, ('Active game/localization workload',hits)


def prepare():
    idle()
    assert not subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT)
    with gzip.open(HERE/'source-retention-plan-final.json.gz','rt') as f:old=json.load(f)
    dirty=set(subprocess.check_output(['git','diff','--name-only','-z'],cwd=ROOT,text=True).split('\0'))-{''}
    kept={r['path'] for r in old['keep']}|dirty|{'tools/forest_storage.py','STORAGE_RECOVERY.md','localization/cleanup/20261031-verified-duplicates/cleanup.py'}
    for p in (ROOT/'localization/cleanup').rglob('*'):
        if not p.is_file() or p.is_symlink() or 'dotnet-home' in p.parts:continue
        if p.suffix in {'.py','.json','.md'} or p.name in {'plan.json.gz','deletions.jsonl.gz','source-deletions.jsonl.gz'}:
            kept.add(str(p.relative_to(ROOT)))
    # Existing owner changes remain local even where the earlier generic source
    # rule selected a historical evidence location. No shared-index adoption.
    kept={n for n in kept if not (n.startswith(str(HERE.relative_to(ROOT))+'/') and 'dotnet-home' in Path(n).parts)}
    index={}
    archives=[]
    for archive in sorted((ROOT/'dist').glob('Forest-*-recovery-20261103-v2.zip')):
        m=s.manifest(archive)
        receipt=json.loads((HERE/(m['kind']+'-archive-v2.json')).read_text())
        assert s.hashes(archive)[0]==receipt['sha256']
        archives.append(receipt)
        for r in m['files']:index.setdefault(r['path'],[]).append((archive.name,r))
    tracked={}
    for row in subprocess.check_output(['git','ls-files','--stage','-z'],cwd=ROOT,text=True).split('\0'):
        if not row:continue
        meta,name=row.split('\t',1);mode,oid,stage=meta.split();assert stage=='0'
        tracked[name]=oid
    candidates={r['path']:r for r in old['discard']+old['evidence']}
    for r in json.loads((HERE/'reviewed-visual-preservation.json').read_text())['files']:
        if r['path'] in candidates:candidates[r['path']]=dict(candidates[r['path']],reason='actual-recorded-visual-evidence')
    protected=[]
    for name in sorted(kept):
        p=s.safe(ROOT,name)
        if not p.is_file():continue
        if name.startswith(str(HERE.relative_to(ROOT))+'/'):continue
        protected.append(dict(path=name,sha256=s.hashes(p)[0],bytes=p.stat().st_size))
    rows=[];changed=[]
    for i,(name,r) in enumerate(sorted(candidates.items()),1):
        if name in kept or save_path(name) or Path(name).suffix.lower() in {'.pfx','.p12','.key','.pem'}:continue
        p=s.safe(ROOT,name)
        if not p.is_file():continue
        if signature(p)!=r['signature']:
            changed.append(name);continue
        digest,oid=s.hashes(p)
        if set(s.attrs.xattrs(p)) & {'com.apple.decmpfs','com.apple.ResourceFork'}:
            changed.append(name);continue
        q=dict(path=name,bytes=p.stat().st_size,sha256=digest,signature=signature(p),mode=stat.S_IMODE(p.stat().st_mode),mtimeNs=p.stat().st_mtime_ns,xattrs=s.attrs.xattrs(p),reason=r['reason'])
        matches=[(a,v) for a,v in index.get(name,[]) if v['sha256']==digest]
        if matches:
            a,v=matches[0];q['archive']=a
            assert v['bytes']==q['bytes'] and v['mode']==q['mode'] and v['mtimeNs']==q['mtimeNs'] and v['xattrs']==q['xattrs']
        elif name in tracked:
            assert tracked[name]==oid, ('Raw tracked bytes differ; preserve instead',name)
            q['gitBlob']=oid
        else:
            assert r['reason'] in {'superseded-generated-output-or-build-context','replaceable-extraction-cache-not-a-direct-continuation-input','verified-exact-copy-of-installed-SDK'}, ('Unique needed file has no recovery record',name)
            q['replaceable']=True
        rows.append(q)
        if i%10000==0:print(json.dumps(dict(stage='verified-selection',checked=i,selected=len(rows))),flush=True)
    head=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()
    data=dict(atUTC=datetime.datetime.now(datetime.timezone.utc).isoformat(),sourceHead=head,files=rows,protected=protected,changedPreserved=changed,ownerChangesPreserved=sorted(dirty),archives=archives,unknownAdditions='Preserved; not selected by the original inventory',projectUnfinished=True)
    with gzip.open(HERE/'execution-plan.json.gz','xt') as f:json.dump(data,f)
    write(HERE/'execution-summary.json',dict(files=len(rows),bytes=sum(r['bytes'] for r in rows),protectedFiles=len(protected),changedPreserved=changed,ownerChangesPreserved=len(dirty)))
    print(json.dumps(json.loads((HERE/'execution-summary.json').read_text())),flush=True)


def apply():
    idle()
    assert not (HERE/'source-cleanup-result.json').exists()
    remote=json.loads((HERE/'remote-restore-build-verification.json').read_text());assert remote['passed'] is True
    with gzip.open(HERE/'execution-plan.json.gz','rt') as f:d=json.load(f)
    current=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()
    assert current==remote['sourceHead']
    subprocess.run(['git','merge-base','--is-ancestor',d['sourceHead'],current],cwd=ROOT,check=True)
    assert not subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT)
    for r in d['archives']:
        proof=remote['archives'][Path(r['path']).name]
        assert proof['downloadSha256']==r['sha256'] and proof['remoteDigest']=='sha256:'+r['sha256']
    for r in d['protected']:
        p=s.safe(ROOT,r['path']);assert p.is_file() and s.hashes(p)[0]==r['sha256'], ('Protected source changed',r['path'])
    for r in d['files']:
        p=s.safe(ROOT,r['path']);assert not save_path(r['path'])
        assert signature(p)==r['signature'] and s.hashes(p)[0]==r['sha256'] and s.attrs.xattrs(p)==r['xattrs'], ('Selected path changed',r['path'])
    before=shutil.disk_usage(ROOT).free;count=0;logical=0
    with gzip.open(HERE/'source-deletions.jsonl.gz','xt') as ledger:
        for r in d['files']:
            if count%2000==0:idle()
            p=s.safe(ROOT,r['path']);assert signature(p)==r['signature']
            # Flush intent first; reconciliation can distinguish interrupted rows
            # using actual path absence and expected bytes, without blind retries.
            ledger.write(json.dumps(r)+'\n');ledger.flush();p.unlink();count+=1;logical+=r['bytes']
    for r in d['files']:assert not s.safe(ROOT,r['path']).exists()
    for r in d['protected']:assert s.hashes(s.safe(ROOT,r['path']))[0]==r['sha256']
    write(HERE/'source-cleanup-result.json',dict(atUTC=datetime.datetime.now(datetime.timezone.utc).isoformat(),files=count,logicalBytes=logical,freeBefore=before,freeAfter=shutil.disk_usage(ROOT).free,protectedFiles=len(d['protected']),allTranslationSourcesPreserved=True,allSavesPreserved=True,unfinishedWorkPreserved=True,projectClosed=False,gameOrModelStarted=False))
    print((HERE/'source-cleanup-result.json').read_text(),flush=True)


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('action',choices=['prepare','apply']);a=p.parse_args()
    prepare() if a.action=='prepare' else apply()
