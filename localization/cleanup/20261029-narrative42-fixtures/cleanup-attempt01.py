"""Reclaim finished duplicate fixtures; losslessly retain unique superseded bundles."""
import datetime
import gzip
import hashlib
import json
from pathlib import Path
import shutil
import subprocess

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
TASK = ROOT/'outputs/ru-narrative42-application-20261029'
CURRENT = ROOT/'localization/previews/ru-20261029-pause434-01/game/The Forest of Love_Data'
HERE = Path(__file__).resolve().parent
ALLOWED = [TASK/name for name in ['verification-01','verification-02','positive-01',
                                 'serialized-excluded-verification-01','serialized-excluded-verification-02']]
SUFFIX = Path('StreamingAssets/aa/StandaloneWindows64/defaultlocalgroup_assets_all_298c5a4d1d1846b1a8d2c7d5da3f319c.bundle')
ANCHOR = TASK/'verification-02/positive'/SUFFIX
POSITIVE = '0ee778c8004116b3c927fc5ae2d7a813b150c908869f6b878ffae8219714ef94'
UNIQUE = {'5707a2b6603e155c32dd67271286c8c51950fcee57e42a4ea00c97dab19d5f84',
          'd2be1f69389f6944d36b7c3922fb55d50099e6035fffab5facc27c3436146c2a',
          '93e4ed53c7fed6cdd35ca014a904594261cca0586e562b9011b17f680a252989'}


def digest(path):
    with path.open('rb') as stream:
        return hashlib.file_digest(stream,'sha256').hexdigest()


def fingerprint(path):
    stat = path.stat()
    return [stat.st_ino,stat.st_size,stat.st_mtime_ns]


def write(path, value):
    temp = path.with_suffix(path.suffix+'.pending')
    with temp.open('x') as stream:
        json.dump(value,stream,ensure_ascii=False,indent=2)
        stream.write('\n')
    temp.replace(path)


def main():
    assert not (HERE/'Result.json').exists(), 'reconcile-existing-cleanup-first'
    assert digest(ANCHOR) == POSITIVE
    tracked = subprocess.check_output(['git','ls-files','--',*[str(p.relative_to(ROOT)) for p in ALLOWED]],cwd=ROOT,text=True)
    assert not tracked, 'tracked-work-must-not-be-removed'
    archives = HERE/'archives'
    archives.mkdir(exist_ok=False)
    candidates = [p for base in ALLOWED for p in base.rglob('*')
                  if p.is_file() and not p.is_symlink() and p != ANCHOR and p.stat().st_size >= 1024**2]
    rows = []
    known = {}
    actual_anchors = {str(ANCHOR):POSITIVE}
    free_before = shutil.disk_usage(ROOT).free
    for path in sorted(candidates):
        assert any(path.resolve().is_relative_to(base.resolve()) for base in ALLOWED)
        stat = fingerprint(path)
        before = digest(path)
        if path.name == SUFFIX.name:
            assert before == POSITIVE or before in UNIQUE, ('unknown-bundle-preserved',str(path),before)
            if before == POSITIVE:
                anchor = ANCHOR
                kind = 'byte-identical-retained-file'
            else:
                anchor = archives/(before+'.bundle.gz')
                if before not in known:
                    with path.open('rb') as source,anchor.open('xb') as output:
                        with gzip.GzipFile(filename='',mode='wb',fileobj=output,compresslevel=6,mtime=0) as packed:
                            shutil.copyfileobj(source,packed,1024**2)
                    with gzip.open(anchor,'rb') as restored:
                        restored_hash = hashlib.file_digest(restored,'sha256').hexdigest()
                    assert restored_hash == before, 'lossless-archive-readback'
                    known[before] = dict(path=str(anchor.relative_to(ROOT)),sha256=digest(anchor),
                                         originalSha256=before,originalBytes=stat[1],compressedBytes=anchor.stat().st_size)
                kind = 'verified-lossless-gzip'
        else:
            marker = '/game/The Forest of Love_Data/'
            if marker not in str(path):
                continue
            relative = str(path).split(marker,1)[1]
            anchor = CURRENT/relative
            if not anchor.is_file() or anchor.stat().st_size != stat[1]:
                continue
            key = str(anchor)
            if key not in actual_anchors:
                actual_anchors[key] = digest(anchor)
            if actual_anchors[key] != before:
                continue  # Unique mutated test input stays intact.
            kind = 'byte-identical-retained-file'
        assert fingerprint(path) == stat, 'candidate-changed-during-verification'
        rows.append(dict(path=str(path.relative_to(ROOT)),fingerprint=stat,bytes=stat[1],sha256=before,
                         retention=kind,anchor=str(anchor.relative_to(ROOT)),anchorFingerprint=fingerprint(anchor)))
    assert set(known) == UNIQUE, 'all-three-unique-superseded-inputs-retained'
    plan = dict(ownerRequest='очисти лишнее',time=datetime.datetime.now(datetime.timezone.utc).isoformat(),
                selection='Finished superseded verification01/02 fixtures only;no active/private-source/execution/guard input.',
                files=rows,archives=known,retainedPositive=str(ANCHOR.relative_to(ROOT)),freeBytesBefore=free_before,
                status='all-actual-content-verified-before-removal')
    write(HERE/'plan.json',plan)
    for row in rows:
        path,anchor = ROOT/row['path'],ROOT/row['anchor']
        assert fingerprint(path) == row['fingerprint'], 'selected-path-changed-before-removal'
        assert fingerprint(anchor) == row['anchorFingerprint'], 'retained-anchor-changed-before-removal'
        assert path != anchor and not path.is_symlink()
        path.unlink()
    assert digest(ANCHOR) == POSITIVE
    for key,expected in actual_anchors.items():
        assert digest(Path(key)) == expected, 'retained-file-recheck'
    for info in known.values():
        archive = ROOT/info['path']
        assert digest(archive) == info['sha256']
        with gzip.open(archive,'rb') as stream:
            assert hashlib.file_digest(stream,'sha256').hexdigest() == info['originalSha256']
    result = dict(status='completed-verified-duplicate-and-lossless-fixture-cleanup',filesRemoved=len(rows),
                  logicalBytesRemoved=sum(r['bytes'] for r in rows),losslessArchives=list(known.values()),
                  freeBytesBefore=free_before,freeBytesAfter=shutil.disk_usage(ROOT).free,
                  protected='Current build,private-source,all execution snapshots,guard inputs,old code/results/ledgers,and unique small/partial failed outputs remain.',
                  restore='For each plan row,copy retained raw anchor or gzip-decompress its archive to the exact path,then require original SHA256. Superseded raw fixture directories are partial archives,not runnable inputs until restored.')
    write(HERE/'Result.json',result)
    print(json.dumps({k:v for k,v in result.items() if k not in ['losslessArchives','protected','restore']}))


if __name__ == '__main__':
    main()
