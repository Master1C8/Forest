"""Remove verified disposable files created by this storage task, after build QA."""
import hashlib
import importlib.util
import json
import os
from pathlib import Path

ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
sp=importlib.util.spec_from_file_location('storage',ROOT/'tools/forest_storage.py')
s=importlib.util.module_from_spec(sp);sp.loader.exec_module(s)


def main():
    assert json.loads((HERE/'post-cleanup-build-verification.json').read_text())['passed']
    assert json.loads((HERE/'source-cleanup-result.json').read_text())['allSavesPreserved']
    records={}
    def add(p,kind):
        assert p.is_file() and not p.is_symlink() and p.stat().st_uid==os.getuid()
        t=p.stat();records[str(p.relative_to(ROOT))]=dict(path=str(p.relative_to(ROOT)),sha256=s.hashes(p)[0],signature=[t.st_dev,t.st_ino,t.st_size,t.st_mtime_ns],bytes=t.st_size,kind=kind)
    receipts=[json.loads(p.read_text()) for p in HERE.glob('*-archive-v2.json')]
    ranged=ROOT/'dist/recovery/ranged-20261103'
    # Superseded interrupted sequential downloads must match the exact prefix
    # of the independently verified complete remote asset.
    for kind in ['inputs','owner-game']:
        name='Forest-'+kind+'-recovery-20261103-v2.zip';partial=ROOT/'dist/recovery/20261103'/name
        if partial.exists():
            full=ranged/name;assert partial.stat().st_size<=full.stat().st_size
            with partial.open('rb') as a,full.open('rb') as b:
                for chunk in iter(lambda:a.read(1024**2),b''):assert chunk==b.read(len(chunk))
            add(partial,'verified-task-owned-redundant-download-prefix')
    for r in receipts:
        for p in [ROOT/r['path'],ranged/Path(r['path']).name]:
            assert s.hashes(p)[0]==r['sha256'] and p.stat().st_size==r['bytes']
            add(p,'remote-verified-redundant-recovery-archive')
    gitproof=json.loads((HERE/'remote-git-objects-verified.json').read_text())
    cache=ROOT/'dist/recovery/20261103/git-objects'
    assert {p.name for p in cache.iterdir()}=={r['gitBlob'] for r in gitproof['rawObjects']}
    for r in gitproof['rawObjects']:
        p=cache/r['gitBlob'];assert s.hashes(p)[0]==r['sha256'];add(p,'verified-raw-Git-download-cache')
    for locale,folder,reference in [
        ('nl','dist/storage-minimal-nl-20261103-04',HERE/'minimal-attempt-04/nl-delivered-manifest.json'),
        ('ja','dist/storage-minimal-ja-20261103-04',HERE/'minimal-attempt-04/ja-delivered-manifest.json'),
        ('nl','dist/storage-post-cleanup-nl-20261103-01',HERE/'post-cleanup/nl-delivered-manifest.json')]:
        base=ROOT/folder;m=json.loads((base/'manifest.json').read_text());assert m==json.loads(reference.read_text())
        assert m['locale']==locale and m['languageSha256']==s.hashes(ROOT/'localization/languages'/(locale+'.json'))[0]
        actual={str(p.relative_to(base)) for p in base.rglob('*') if p.is_file()}
        assert actual==set(m['files'])|{'manifest.json','build-input.json'}
        assert json.loads((base/'build-input.json').read_text())=={k:m[k] for k in ['compilerSha256','frameworkSha256','languageSha256','locale']}
        for n,r in m['files'].items():assert s.hashes(base/n)[0]==r['sha256'] and (base/n).stat().st_size==r['bytes']
        for n in sorted(actual):add(base/n,'verified-task-build-output')
    # Each home/cache was created by this task. Never touch the installed SDK,
    # the normal Python environment, Keychain or any owner runtime directory.
    homes=[HERE/'dotnet-home',HERE/'minimal-attempt-02/dotnet-home',HERE/'minimal-attempt-03/dotnet-home',HERE/'minimal-attempt-04/dotnet-home',HERE/'post-cleanup/dotnet-home']
    for base in homes+[ROOT/'outputs/universal-localizer-20261031/build-work']:
        if not base.exists():continue
        for p in base.rglob('*'):
            assert not p.is_symlink(), ('Preserve unclassified cache link',str(p))
            if p.is_file():add(p,'task-created-reconstructible-SDK-or-compiler-cache')
    with (HERE/'task-temporary-removal-plan.json').open('x') as f:json.dump(dict(files=list(records.values())),f,indent=2);f.write('\n')
    for r in records.values():
        p=s.safe(ROOT,r['path']);t=p.stat()
        assert [t.st_dev,t.st_ino,t.st_size,t.st_mtime_ns]==r['signature']
        assert s.hashes(p)[0]==r['sha256']
    for r in records.values():s.safe(ROOT,r['path']).unlink()
    assert not any((ROOT/r['path']).exists() for r in records.values())
    with (HERE/'task-temporary-removal-result.json').open('x') as f:
        json.dump(dict(files=len(records),logicalBytes=sum(r['bytes'] for r in records.values()),uniqueSourceRemoved=False,remoteArchivesRetained=True,ownerSavesAndNormalGitUntouched=True),f,indent=2);f.write('\n')
    print(json.dumps(dict(files=len(records),bytes=sum(r['bytes'] for r in records.values()))))


if __name__=='__main__':main()
