#!/usr/bin/env python3
"""Delete only verified duplicate files in completed QA/build copies.

Retain unique files, saves, images, metadata and every tracked path. No game,
model, server or source lifecycle action. Restore uses retained exact bytes.
"""
import argparse, base64, ctypes, datetime, gzip, hashlib, json, os
from pathlib import Path
import shutil, stat, subprocess, time

ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
PLAN=HERE/'plan.json.gz'
PROTECTED=[ROOT/'localization/framework/forest045-shared',ROOT/'dist/Forest-de-25cfdea9b625',ROOT/'dist/Forest-Universal-Russian',ROOT/'dist/Forest-Russian-Test-20261029']
OWNER=ROOT/'localization/cleanup/protected-owner-test-builds.json'
CACHE={}
LIBC=ctypes.CDLL(None,use_errno=True)
LIBC.listxattr.argtypes=[ctypes.c_char_p,ctypes.c_void_p,ctypes.c_size_t,ctypes.c_int]
LIBC.listxattr.restype=ctypes.c_ssize_t
LIBC.getxattr.argtypes=[ctypes.c_char_p,ctypes.c_char_p,ctypes.c_void_p,ctypes.c_size_t,ctypes.c_uint32,ctypes.c_int]
LIBC.getxattr.restype=ctypes.c_ssize_t
LIBC.setxattr.argtypes=[ctypes.c_char_p,ctypes.c_char_p,ctypes.c_void_p,ctypes.c_size_t,ctypes.c_uint32,ctypes.c_int]
LIBC.setxattr.restype=ctypes.c_int
LIBC.removexattr.argtypes=[ctypes.c_char_p,ctypes.c_char_p,ctypes.c_int]
LIBC.removexattr.restype=ctypes.c_int

def xattrs(p):
    count=LIBC.listxattr(os.fsencode(p),None,0,1)
    if count<0:raise OSError(ctypes.get_errno(),os.strerror(ctypes.get_errno()),str(p))
    if not count:return {}
    buf=ctypes.create_string_buffer(count)
    assert LIBC.listxattr(os.fsencode(p),buf,count,1)==count
    result={}
    for name in buf.raw.rstrip(b'\0').split(b'\0'):
        length=LIBC.getxattr(os.fsencode(p),name,None,0,0,1);assert length>=0
        value=ctypes.create_string_buffer(length)
        assert LIBC.getxattr(os.fsencode(p),name,value,length,0,1)==length
        result[os.fsdecode(name)]=base64.b64encode(value.raw).decode('ascii')
    return result

def restore_row(row):
    p=local(row['path']);a=local(row['retained'])
    assert a.stat().st_size==row['bytes'] and sha(a)==row['sha256']
    assert not p.exists();p.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(a,p)
    for name in xattrs(p):assert LIBC.removexattr(os.fsencode(p),os.fsencode(name),1)==0
    for name,value in row['xattrs'].items():
        raw=base64.b64decode(value);buf=ctypes.create_string_buffer(raw)
        assert LIBC.setxattr(os.fsencode(p),os.fsencode(name),buf,len(raw),0,1)==0
    os.chmod(p,row['signature'][4]);os.utime(p,ns=(p.stat().st_atime_ns,row['signature'][3]))
    assert sha(p)==row['sha256'] and xattrs(p)==row['xattrs']

def now():return datetime.datetime.now(datetime.timezone.utc).isoformat()
def read(p):return json.loads(p.read_bytes())
def sha(p):
    h=hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda:f.read(1024*1024),b''):h.update(b)
    return h.hexdigest()
def sig(p):
    s=p.lstat();return [s.st_dev,s.st_ino,s.st_size,s.st_mtime_ns,stat.S_IMODE(s.st_mode)]
def key(p):
    before=sig(p);k=tuple(before[:4])
    if k not in CACHE:CACHE[k]=sha(p)
    assert sig(p)==before,('file changed while hashing',p)
    return before[2],CACHE[k]
def save(p,v):
    assert not p.exists(),('receipt occupied',p)
    p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
def local(name):
    p=ROOT/name;assert not Path(name).is_absolute() and p.resolve().is_relative_to(ROOT) and not p.is_symlink();return p
def protected_roots():
    return [*PROTECTED,*[ROOT/b['path'] for b in read(OWNER)['builds'] if b.get('neverCleanup') or b.get('ownerManualTest')]]
def protected(p):return any(p==r or p.is_relative_to(r) for r in protected_roots())
def protected_file(p):
    n=p.name.lower()
    return p.is_symlink() or n.startswith('tfol.') or any(s in n for s in ['savegame','playerprefs','savegamebackup']) or p.suffix.lower() in {'.png','.webp','.jpg','.jpeg','.sav','.save','.settings'}
def idle():
    rows=subprocess.check_output(['ps','-axo','pid=,args='],text=True).splitlines()
    active=[s for s in rows if ('The Forest of Love.exe' in s or 'run_locale_completion.py' in s or 'forest_localize.py build' in s or 'codex exec --ignore-user-config' in s and '/Forest' in s)]
    assert not active,('Active game/localization workload; no deletion',active)
def tracked():return set(subprocess.check_output(['git','ls-files','-z'],cwd=ROOT,text=True).split('\0'))
def regular(p):return p.is_file() and not p.is_symlink()
def verify_qa(game):
    p=game.parent/'cleanup.json'
    if not p.exists() or protected(game):return False
    d=read(p)
    if d.get('taskOwnedProcessesAbsent') is not True or d.get('ownerSaveFilesUsed') is not False:return False
    if not isinstance(d.get('fixtureBefore'),dict) or d.get('fixtureRestored') is not True:return False
    current={p.name:sha(p) for p in (game/'The Forest of Love_Data').glob('tfol.*') if regular(p)}
    if current!=d['fixtureBefore']:return False
    if any(game.parent.glob('OWNER*')) or any(game.glob('OWNER*')):return False
    return True

def plan():
    idle();assert not PLAN.exists();track=tracked();pool={};anchor_paths=set();selected=set();deletions=[];kept_unique=[];scope=[];skipped=[]
    def retain(p):
        if regular(p) and not protected_file(p):
            k=key(p)
            if k not in pool:pool[k]=p;anchor_paths.add(p)
    # Immutable compiler inputs and the protected accepted Russian game supply
    # retained original companions as well as current locale resources.
    roots=[ROOT/'localization/framework/forest045-shared',ROOT/'localization/previews/ru-20261029-narrative42-01/game',ROOT/'dist/Forest-de-25cfdea9b625',ROOT/'dist/Forest-Universal-Russian']
    for root in roots:
        assert root.exists(),root
        for p in sorted(root.rglob('*')):retain(p)
    candidates=[]
    # Explicit recent compiler artifacts: schema + every member must still match.
    for folder in sorted((ROOT/'dist').glob('Forest-Universal-*')):
        if protected(folder):continue
        p=folder/'manifest.json'
        if not p.exists():continue
        m=read(p)
        if m.get('format')!='forest-compiled-language-v1' or len(m.get('files',{}))!=16:continue
        expected=set(m['files'])|{'manifest.json','build-input.json'}
        actual={p.relative_to(folder).as_posix() for p in folder.rglob('*') if regular(p)}
        if actual!=expected:skipped.append(dict(path=str(folder.relative_to(ROOT)),reason='unknown artifact inventory'));continue
        if not all(key(folder/n)==(b['bytes'],b['sha256']) for n,b in m['files'].items()):
            skipped.append(dict(path=str(folder.relative_to(ROOT)),reason='modified output'));continue
        scope.append(dict(path=str(folder.relative_to(ROOT)),kind='completed compiler artifact',proof=sha(folder/'manifest.json')))
        candidates.extend(folder/n for n in m['files'])
    # All nested files are checked. An old parent mtime never proves inactivity.
    games=[*(ROOT/'localization/probes').glob('*/game'),*(ROOT/'localization/de-assets/completion').glob('*/runtime-*/game')]
    for game in sorted(games):
        if not verify_qa(game):continue
        scope.append(dict(path=str(game.relative_to(ROOT)),kind='closed disposable QA game',proof=sha(game.parent/'cleanup.json')))
        candidates.extend(p for p in game.rglob('*') if regular(p))
    # Only our new migration/reconstruction snapshots, not historic source jobs.
    for name in ['outputs/universal-localizer-20261031/reproduced-framework','outputs/universal-localizer-20261031/prototypes/forest045-russian-v1','outputs/universal-localizer-20261031/baseline-before-engine-binding']:
        folder=ROOT/name
        if folder.exists():
            scope.append(dict(path=name,kind='task-owned reconstruction/prototype',proof=None))
            candidates.extend(p for p in folder.rglob('*') if regular(p))
    for index,p in enumerate(sorted(set(candidates)),1):
        rel=p.relative_to(ROOT).as_posix()
        if rel in track or protected(p) or protected_file(p) or p in anchor_paths:continue
        # Keep all receipts and source/configuration snapshots. Remove only raw
        # resource/managed copies or exact copies of pinned inspection JSON.
        if p.suffix.lower() in {'.json','.jsonl','.tsv','.log','.txt','.md','.py','.cs','.csproj','.yaml','.yml'} and '/migration-work/' not in rel:continue
        attrs=xattrs(p)
        if set(attrs)-{'com.apple.provenance','com.apple.quarantine'}:continue
        k=key(p);other=pool.get(k)
        if other is None:
            pool[k]=p;anchor_paths.add(p);kept_unique.append(dict(path=rel,bytes=k[0],sha256=k[1]));continue
        assert other!=p and other not in selected
        selected.add(p)
        deletions.append(dict(path=rel,retained=str(other.relative_to(ROOT)),bytes=k[0],sha256=k[1],signature=sig(p),retainedSignature=sig(other),xattrs=attrs))
        if index%1500==0:print('checked',index,'duplicates',len(deletions),flush=True)
    data=dict(schemaVersion=1,at=now(),ownerInstruction='удали лишние временные файлы',protectedOwnerRegistrySha256=sha(OWNER),protectedRoots=[str(p.relative_to(ROOT)) for p in protected_roots()],scope=scope,files=deletions,uniqueKept=kept_unique,skipped=skipped,logicalBytes=sum(x['bytes'] for x in deletions),freeBeforePlan=shutil.disk_usage(ROOT).free)
    with gzip.open(PLAN,'wt',encoding='utf8') as f:json.dump(data,f,ensure_ascii=False)
    print(json.dumps(dict(files=len(deletions),logicalBytes=data['logicalBytes'],scopes=len(scope),uniqueKept=len(kept_unique),freeBytes=data['freeBeforePlan'])),flush=True)

def load():
    with gzip.open(PLAN,'rt',encoding='utf8') as f:return json.load(f)
def apply():
    idle();data=load();assert sha(OWNER)==data['protectedOwnerRegistrySha256'];assert not (HERE/'result.json').exists();track=tracked();before=shutil.disk_usage(ROOT).free
    selected={x['path'] for x in data['files']};assert not selected&{x['retained'] for x in data['files']}
    anchors={x['retained']:(x['bytes'],x['sha256'],x['retainedSignature']) for x in data['files']}
    for name,(size,h,signature) in anchors.items():
        p=local(name);assert sig(p)==signature and sha(p)==h and p.stat().st_size==size,('retained anchor changed',name)
    qa=[local(s['path']) for s in data['scope'] if s['kind']=='closed disposable QA game']
    for game in qa:assert verify_qa(game),('QA eligibility changed',game)
    deleted=0;logical=0
    with gzip.open(HERE/'deletions.jsonl.gz','xt',encoding='utf8') as log:
        for row in data['files']:
            if deleted%150==0:idle()
            p=local(row['path']);anchor=local(row['retained'])
            assert not protected(p) and not protected_file(p) and row['path'] not in track
            assert sig(p)==row['signature'] and sha(p)==row['sha256'] and xattrs(p)==row['xattrs'],('selected file changed',row['path'])
            assert sig(anchor)==row['retainedSignature'],('anchor changed',row['retained'])
            p.unlink();deleted+=1;logical+=row['bytes'];log.write(json.dumps(row,ensure_ascii=False)+'\n');log.flush()
    # Exercise actual exact-path restore, then return the selected duplicate to
    # its pruned state. This is file restoration, not gameplay/save continuation.
    row=max(data['files'],key=lambda x:x['bytes']);p=local(row['path']);restore_row(row);p.unlink()
    missing=[x['path'] for x in data['files'] if local(x['path']).exists()];assert not missing
    for game in qa:
        assert verify_qa(game),('save/cleanup state changed',game)
    time.sleep(1)
    result=dict(at=now(),deletedFiles=deleted,logicalBytes=logical,freeBefore=before,freeAfter=shutil.disk_usage(ROOT).free,physicalFreeDelta=shutil.disk_usage(ROOT).free-before,retainedAnchors=len(anchors),uniqueKept=len(data['uniqueKept']),protectedRoots=data['protectedRoots'],actualExactPathRestoreVerified=dict(path=row['path'],bytes=row['bytes'],sha256=row['sha256']),ownerSavesImagesLogsTranslationsRetained=True,scope='Exact duplicate files only; metadata/unique outputs/current packages/framework/owner accepted build retained',noProcessStopped=True)
    save(HERE/'result.json',result);print(json.dumps(result),flush=True)

def restore(name):
    idle();data=load();row=next(x for x in data['files'] if x['path']==name);p=local(row['path']);a=local(row['retained']);assert a.stat().st_size==row['bytes'] and sha(a)==row['sha256']
    if p.exists():assert sha(p)==row['sha256'] and xattrs(p)==row['xattrs'];return
    restore_row(row);print('Restored',name)

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('action',choices=['plan','apply','restore']);p.add_argument('--path');a=p.parse_args()
    if a.action=='plan':plan()
    elif a.action=='apply':apply()
    else:restore(a.path)
