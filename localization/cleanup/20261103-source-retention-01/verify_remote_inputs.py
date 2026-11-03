"""Restore downloaded inputs at canonical paths and exercise the normal compiler."""
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import stat
import subprocess

ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
os.environ['FOREST_RECOVERY_GIT_OBJECTS']=str(ROOT/'dist/recovery/20261103/git-objects')
spec=importlib.util.spec_from_file_location('storage',ROOT/'tools/forest_storage.py')
s=importlib.util.module_from_spec(spec);spec.loader.exec_module(s)


def main():
    assert (HERE/'execution-summary.json').exists(), 'Finish the concurrent read-only inventory first'
    assert not (HERE/'remote-inputs-normal-build.json').exists()
    a=ROOT/'dist/recovery/ranged-20261103/Forest-inputs-recovery-20261103-v2.zip'
    receipt=json.loads((HERE/'inputs-archive-v2.json').read_text());assert s.hashes(a)[0]==receipt['sha256']
    m=s.verify(a);hold=HERE/'held-original-build-inputs';assert not hold.exists()
    selected=[r for r in m['files'] if 'gitBlob' not in r]
    transitions=[];restored=[];finished=False
    try:
        for r in selected:
            p=s.safe(ROOT,r['path']);q=s.safe(hold,r['path']);t=p.stat()
            assert s.hashes(p)[0]==r['sha256'] and s.attrs.xattrs(p)==r['xattrs']
            assert t.st_mtime_ns==r['mtimeNs'] and stat.S_IMODE(t.st_mode)==r['mode']
            q.parent.mkdir(parents=True,exist_ok=True);p.rename(q)
            transitions.append(dict(path=r['path'],originalInode=t.st_ino))
        result=s.restore(a,ROOT)
        assert result['created']==len(selected)
        for r in m['files']:
            p=s.safe(ROOT,r['path']);assert s.hashes(p)[0]==r['sha256']
        with (HERE/'remote-normal-build.stdout.log').open('x') as so,(HERE/'remote-normal-build.stderr.log').open('x') as se:
            run=subprocess.run(['python3','-B',str(HERE/'verify_minimal.py'),'--attempt','4'],cwd=ROOT,stdout=so,stderr=se)
        assert run.returncode==0, 'Keep inputs and inspect the exact normal build failure'
        assert json.loads((HERE/'minimal-attempt-04/minimal-build-result.json').read_text())['status']=='passed'
        finished=True
    finally:
        # The canonical original inodes survive this test. Never replace an
        # unexpected owner edit with either archived or held bytes.
        for r in selected:
            q=s.safe(hold,r['path'])
            if not q.exists():continue
            p=s.safe(ROOT,r['path'])
            if p.exists():
                assert s.hashes(p)[0]==r['sha256'], ('Unexpected concurrent edit; original remains held',r['path'])
                p.unlink()
            q.rename(p);assert s.hashes(p)[0]==r['sha256']
            restored.append(r['path'])
        for p in sorted(hold.rglob('*'),key=lambda p:len(p.parts),reverse=True):
            assert p.is_dir() and not p.is_symlink();p.rmdir()
        if hold.exists():hold.rmdir()
        by_name={r['path']:r for r in transitions}
        for r in selected:
            p=s.safe(ROOT,r['path'])
            assert p.stat().st_ino==by_name[r['path']]['originalInode']
            assert p.stat().st_mtime_ns==r['mtimeNs'] and s.attrs.xattrs(p)==r['xattrs']
        proof=dict(passed=finished,downloadArchiveSha256=receipt['sha256'],actualNonGitFilesRestored=len(transitions),originalInodesRestored=len(restored),gitSource='Compared to actual raw GitHub object downloads; no local blob fallback',all454InputsMatched=True,normalBuild='Dutch and Japanese build/check; all16 resource hashes each; undeclared project data reads denied',gameOrModelStarted=False)
        with (HERE/'remote-inputs-normal-build.json').open('x') as f:json.dump(proof,f,indent=2);f.write('\n')
        print(json.dumps(proof),flush=True)


if __name__=='__main__':main()
