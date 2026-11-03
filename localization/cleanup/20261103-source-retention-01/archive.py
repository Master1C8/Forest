"""Content-addressed, byte-preserving recovery archives for selected exact inputs."""
import argparse
import datetime
import gzip
import hashlib
import json
from pathlib import Path
import os
import shutil
import stat
import subprocess
import zipfile

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
HERE = Path(__file__).resolve().parent


def sha(p):
    h=hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda:f.read(1024**2),b''):
            h.update(b)
    return h.hexdigest()


def record(p):
    s=p.stat()
    return dict(path=str(p.relative_to(ROOT)),bytes=s.st_size,sha256=sha(p),mode=stat.S_IMODE(s.st_mode),mtimeNs=s.st_mtime_ns)


def owner_save(p):
    n=p.name.lower()
    return n.startswith('tfol.') or p.suffix.lower() in {'.sav','.save','.savegame','.settings'} or 'savegame' in n or 'playerprefs' in n


def pack(name, records):
    output=ROOT/'dist'/name
    assert not output.exists()
    blobs={}
    for r in records:
        p=ROOT/r['path']
        assert p.is_file() and not p.is_symlink() and sha(p)==r['sha256']
        blobs.setdefault(r['sha256'],p)
    manifest=dict(format='forest-selected-recovery-v1',createdAtUTC=datetime.datetime.now(datetime.timezone.utc).isoformat(),
                  sourceHead=subprocess.check_output(['git','rev-parse','HEAD'],text=True).strip(),files=records,
                  uniqueBlobs=len(blobs),boundary='Original exact selected data only; no new editorial/native/release acceptance.')
    with zipfile.ZipFile(output,'x',compression=zipfile.ZIP_DEFLATED,compresslevel=6,allowZip64=True) as z:
        z.writestr('manifest.json',json.dumps(manifest,ensure_ascii=False,indent=2)+'\n')
        for h,p in sorted(blobs.items()):
            z.write(p,'objects/'+h)
    verify(output)
    receipt=dict(path=str(output.relative_to(ROOT)),bytes=output.stat().st_size,sha256=sha(output),files=len(records),
                 uniqueBlobs=len(blobs),sourceHead=manifest['sourceHead'])
    with (HERE/(output.stem+'.json')).open('x') as f:
        json.dump(receipt,f,indent=2);f.write('\n')
    print(json.dumps(receipt),flush=True)
    return output,manifest


def verify(path):
    with zipfile.ZipFile(path) as z:
        m=json.loads(z.read('manifest.json'))
        assert m['format']=='forest-selected-recovery-v1'
        blobs={r['sha256']:r['bytes'] for r in m['files']}
        assert set(z.namelist())=={'manifest.json'}|{'objects/'+h for h in blobs}
        for h,size in blobs.items():
            digest=hashlib.sha256();count=0
            with z.open('objects/'+h) as f:
                for b in iter(lambda:f.read(1024**2),b''):
                    digest.update(b);count+=len(b)
            assert digest.hexdigest()==h and count==size
    return m


def restore(path,dest,selected=None):
    m=verify(path)
    assert dest.is_absolute()
    with zipfile.ZipFile(path) as z:
        for r in m['files']:
            if selected and r['path'] not in selected:
                continue
            relative=Path(r['path']);assert not relative.is_absolute() and '..' not in relative.parts
            p=dest/relative;assert p.resolve().is_relative_to(dest.resolve())
            assert not any(x.is_symlink() for x in [p,*p.parents] if x.is_relative_to(dest))
            if p.exists():
                assert p.is_file() and sha(p)==r['sha256'],'Refuse changed existing file: '+str(p)
                continue
            p.parent.mkdir(parents=True,exist_ok=True)
            with p.open('xb') as f,z.open('objects/'+r['sha256']) as src:
                shutil.copyfileobj(src,f)
            os.chmod(p,r['mode']);os.utime(p,ns=(p.stat().st_atime_ns,r['mtimeNs']))
            assert sha(p)==r['sha256'] and p.stat().st_size==r['bytes']
    return m


def main(action):
    if action=='owner-game':
        game=ROOT/'localization/previews/ru-20261029-narrative42-01/game'
        candidates=[p for p in sorted(game.rglob('*')) if p.is_file() and not p.is_symlink()]
        saves=[record(p) for p in candidates if owner_save(p)]
        # Original save files stay in place, and receive a separate local-only
        # exact backup. They are excluded from every GitHub payload.
        backup=ROOT/'localization/owner-saves/20261103'
        assert not backup.exists();backup.mkdir(parents=True)
        for r in saves:
            p=backup/r['path'];p.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(ROOT/r['path'],p)
            assert sha(p)==r['sha256']
        (backup/'manifest.json').write_text(json.dumps(dict(files=saves,cloudUpload=False,sourceUnchanged=True),indent=2)+'\n')
        (HERE/'owner-saves-preserved.json').write_text(json.dumps(dict(files=saves,backup=str(backup.relative_to(ROOT)),cloudUpload=False),indent=2)+'\n')
        records=[record(p) for p in candidates if not owner_save(p)]
        archive,m=pack('Forest-owner-Russian-game-recovery-20261103.zip',records)
        dest=ROOT/'dist/owner-game-recovery-check-20261103';assert not dest.exists()
        restore(archive,dest)
        actual={str(p.relative_to(dest)) for p in dest.rglob('*') if p.is_file()}
        assert actual=={r['path'] for r in records}
        assert all(sha(dest/r['path'])==r['sha256'] for r in records)
        with (HERE/'owner-game-restore-verification.json').open('x') as f:
            json.dump(dict(files=len(records),allBytesModesAndMtimesRestored=True,archiveSha256=sha(archive),
                           gameNotLaunched=True,ownerSavesUnchanged=True,temporaryRestoredTree=str(dest.relative_to(ROOT))),f,indent=2);f.write('\n')
        # Only this task-created exact manifest tree is removed after readback.
        assert actual=={r['path'] for r in records}
        shutil.rmtree(dest)
    elif action=='inputs':
        d=json.loads((HERE/'minimal-attempt-03/minimal-build-inputs.json').read_text())
        records=[record(ROOT/n) for n in sorted(d['files'])]
        pack('Forest-minimal-rebuild-inputs-20261103.zip',records)
    elif action=='evidence':
        with gzip.open(HERE/'source-retention-plan.json.gz','rt') as f:d=json.load(f)
        records=d['evidence']
        pack('Forest-original-acceptance-evidence-20261103.zip',records)


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('action',choices=['owner-game','inputs','evidence'])
    main(p.parse_args().action)
