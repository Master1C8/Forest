"""Pack/restore selected Forest inputs without changing source content or acceptance."""
import argparse
import base64
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
import zipfile

ROOT = Path(__file__).resolve().parents[1]
CONTROL = ROOT/'localization/cleanup/20261103-source-retention-01'
spec = importlib.util.spec_from_file_location('original_attribute_recipe', ROOT/'localization/cleanup/20261031-verified-duplicates/cleanup.py')
attrs = importlib.util.module_from_spec(spec)
spec.loader.exec_module(attrs)


def hashes(p):
    before=p.stat();a=hashlib.sha256();b=hashlib.sha1(('blob '+str(before.st_size)+'\0').encode())
    with p.open('rb') as f:
        for chunk in iter(lambda:f.read(1024**2),b''):
            a.update(chunk);b.update(chunk)
    after=p.stat()
    assert (before.st_dev,before.st_ino,before.st_size,before.st_mtime_ns)==(after.st_dev,after.st_ino,after.st_size,after.st_mtime_ns)
    return a.hexdigest(),b.hexdigest()


def safe(root,name):
    relative=Path(name)
    assert not relative.is_absolute() and relative.parts and '..' not in relative.parts
    p=root/relative;assert p.resolve().is_relative_to(root.resolve())
    assert not any(x.is_symlink() for x in [p,*p.parents] if x.is_relative_to(root))
    return p


def manifest(path):
    with zipfile.ZipFile(path) as z:return json.loads(z.read('manifest.json'))


def data(record,archive):
    if 'gitBlob' in record:
        return subprocess.check_output(['git','cat-file','blob',record['gitBlob']],cwd=ROOT)
    owner=archive.with_name(record.get('fromArchive',archive.name))
    with zipfile.ZipFile(owner) as z:return z.read('objects/'+record['sha256'])


def pack(kind):
    revision=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()
    reachable={line.split(' ',1)[0] for line in subprocess.check_output(['git','rev-list','--objects','refs/heads/main'],cwd=ROOT,text=True).splitlines()}
    if kind=='inputs':
        names=list(json.loads((CONTROL/'minimal-attempt-03/minimal-build-inputs.json').read_text())['files'])
    elif kind=='owner-game':
        old=manifest(ROOT/'dist/Forest-owner-Russian-game-recovery-20261103.zip')
        names=[r['path'] for r in old['files']]
    else:
        with gzip.open(CONTROL/'source-retention-plan-final.json.gz','rt') as f:plan=json.load(f)
        if kind=='companions':names=[r['path'] for r in plan['evidence'] if r['reason']=='indispensable-prior-restoration-companion']
        elif kind=='evidence':names=[r['path'] for r in plan['evidence'] if r['reason']!='indispensable-prior-restoration-companion']
        else:
            inputs=set(json.loads((CONTROL/'minimal-attempt-03/minimal-build-inputs.json').read_text())['files'])
            names=[r['path'] for r in plan['keep'] if r['path'] not in inputs and not r['path'].startswith(('.venv-', 'localization/owner-saves/')) and 'dotnet-home' not in Path(r['path']).parts and not Path(r['path']).name.lower().startswith('tfol.') and Path(r['path']).suffix.lower() not in {'.sav','.save','.savegame','.settings','.pfx','.p12','.key','.pem'}]
    if kind not in {'inputs','owner-game'}:
        names=[n for n in names if not Path(n).name.lower().startswith('tfol.') and Path(n).suffix.lower() not in {'.sav','.save','.savegame','.settings','.pfx','.p12','.key','.pem'} and 'dotnet-home' not in Path(n).parts and not n.startswith('localization/owner-saves/')]
    filename='Forest-'+kind+'-recovery-20261103-v2.zip';output=ROOT/'dist'/filename
    assert not output.exists()
    shared={}
    for other in (ROOT/'dist').glob('Forest-*-recovery-20261103-v2.zip'):
        for r in manifest(other)['files']:
            if 'gitBlob' not in r and 'fromArchive' not in r:shared.setdefault(r['sha256'],other.name)
    records=[];blobs={}
    for i,name in enumerate(sorted(set(names)),1):
        p=safe(ROOT,name);assert p.is_file()
        digest,oid=hashes(p);s=p.stat();x=attrs.xattrs(p)
        assert 'com.apple.decmpfs' not in x and 'com.apple.ResourceFork' not in x, 'Preserve unsupported fork/compression metadata: '+name
        r=dict(path=name,sha256=digest,bytes=s.st_size,mode=stat.S_IMODE(s.st_mode),mtimeNs=s.st_mtime_ns,xattrs=x)
        if oid in reachable:r['gitBlob']=oid
        elif digest in shared:r['fromArchive']=shared[digest]
        else:blobs.setdefault(digest,p)
        records.append(r)
        if i%2000==0:print(json.dumps(dict(stage='selected-records',kind=kind,checked=i)),flush=True)
    m=dict(format='forest-selected-recovery-v2',kind=kind,sourceGitRevision=revision,files=records,
           gitObjectsProvidedBy='https://github.com/Master1C8/Forest; fetch the recorded ancestor revision',
           originalData=True,newEditorialOrNativeAcceptance=False)
    with zipfile.ZipFile(output,'x',compression=zipfile.ZIP_DEFLATED,compresslevel=6,allowZip64=True) as z:
        z.writestr('manifest.json',json.dumps(m,ensure_ascii=False,indent=2)+'\n')
        for digest,p in sorted(blobs.items()):z.write(p,'objects/'+digest)
    verify(output)
    receipt=dict(path=str(output.relative_to(ROOT)),bytes=output.stat().st_size,sha256=hashes(output)[0],
                 files=len(records),uniquePayloadBlobs=len(blobs),reusedGitBlobs=sum('gitBlob' in r for r in records),
                 reusedOtherArchiveBlobs=sum('fromArchive' in r for r in records),sourceGitRevision=revision)
    with (CONTROL/(kind+'-archive-v2.json')).open('x') as f:json.dump(receipt,f,indent=2);f.write('\n')
    print(json.dumps(receipt),flush=True)


def verify(archive):
    m=manifest(archive);assert m['format']=='forest-selected-recovery-v2'
    seen=set()
    for r in m['files']:
        safe(ROOT,r['path']);key=(r.get('gitBlob'),r.get('fromArchive'),r['sha256'])
        if key in seen:continue
        seen.add(key);raw=data(r,archive)
        assert len(raw)==r['bytes'] and hashlib.sha256(raw).hexdigest()==r['sha256']
    with zipfile.ZipFile(archive) as z:
        expected={'manifest.json'}|{'objects/'+r['sha256'] for r in m['files'] if 'gitBlob' not in r and 'fromArchive' not in r}
        assert set(z.namelist())==expected
    return m


def set_metadata(p,r):
    for name in attrs.xattrs(p):assert attrs.LIBC.removexattr(os.fsencode(p),os.fsencode(name),1)==0
    for name,value in r['xattrs'].items():
        raw=base64.b64decode(value);buf=attrs.ctypes.create_string_buffer(raw)
        assert attrs.LIBC.setxattr(os.fsencode(p),os.fsencode(name),buf,len(raw),0,1)==0
    os.chmod(p,r['mode']);os.utime(p,ns=(p.stat().st_atime_ns,r['mtimeNs']))


def restore(archive,dest,missing_only=False):
    m=verify(archive);created=0;existing=0;changed=0
    for r in m['files']:
        p=safe(dest,r['path'])
        if p.exists():
            assert p.is_file()
            if hashes(p)[0]!=r['sha256']:
                if missing_only:changed+=1;continue
                raise ValueError('Refuse changed existing file: '+r['path'])
            existing+=1;continue
        p.parent.mkdir(parents=True,exist_ok=True)
        with p.open('xb') as f:f.write(data(r,archive))
        set_metadata(p,r)
        assert hashes(p)[0]==r['sha256'] and attrs.xattrs(p)==r['xattrs']
        created+=1
    return dict(created=created,existingExact=existing,preservedChangedExisting=changed,gameLaunched=False)


def main():
    p=argparse.ArgumentParser(description=__doc__);sub=p.add_subparsers(dest='action',required=True)
    c=sub.add_parser('pack');c.add_argument('kind',choices=['inputs','owner-game','companions','evidence','workspace'])
    c=sub.add_parser('verify');c.add_argument('archive',type=Path)
    c=sub.add_parser('restore');c.add_argument('archive',type=Path);c.add_argument('--dest',type=Path,default=ROOT);c.add_argument('--missing-only',action='store_true')
    a=p.parse_args()
    if a.action=='pack':pack(a.kind)
    elif a.action=='verify':print(json.dumps(dict(passed=True,files=len(verify(a.archive)['files']))))
    else:print(json.dumps(restore(a.archive,a.dest.resolve(),a.missing_only)))


if __name__=='__main__':main()
