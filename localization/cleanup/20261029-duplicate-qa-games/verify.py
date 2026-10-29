"""Verify completed cleanup and reconstruct three actual files without a game launch."""
import hashlib
import json
from pathlib import Path
import shutil

HERE = Path(__file__).resolve().parent
scope = json.loads((HERE/'scope.json').read_text())
ROOT = Path(scope['root'])
plan = json.loads((HERE/'plan.json').read_text())
result = json.loads((HERE/'Result.json').read_text())
assert result['status'] == 'verified-duplicates-removed'


def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda:f.read(4*1024*1024), b''):
            h.update(b)
    return h.hexdigest()


anchors = {r['retainedCopy']['path']:r['retainedCopy'] for r in plan['removals']}
protected = set(scope['protectedGameRoots'])
removed = {r['path'] for r in plan['removals']}
assert not removed.intersection(anchors)
for name, r in anchors.items():
    p = ROOT/name
    assert p.is_file() and not p.is_symlink() and p.stat().st_size == r['bytes']
    assert sha(p) == r['sha256'], name
for r in plan['removals']:
    p = ROOT/r['path']
    assert not p.exists() and not p.is_symlink(), r['path']
    assert '/'.join(p.relative_to(ROOT).parts[:4]) not in protected
    assert r['sha256'] == r['retainedCopy']['sha256']
    assert r['bytes'] == r['retainedCopy']['bytes']

samples = []
for suffix in ('.resS', '.assets', '.dll'):
    matches = [r for r in plan['removals'] if Path(r['path']).suffix == suffix]
    assert matches, suffix
    samples.append(max(matches, key=lambda r:r['bytes']))
temporary = HERE/'restore-check'
temporary.mkdir(exist_ok=False)
receipts = []
for i, r in enumerate(samples):
    target = temporary/(str(i)+'.bin')
    source = ROOT/r['retainedCopy']['path']
    assert not target.exists()
    shutil.copy2(source, target)
    assert target.stat().st_size == r['bytes'] and sha(target) == r['sha256']
    receipts.append(dict(originalPath=r['path'], retainedSource=r['retainedCopy']['path'],
                         bytes=r['bytes'], sha256=r['sha256'], actualCopyReadback='pass'))
    target.unlink()
temporary.rmdir()
report = dict(status='pass', removedPathsVerified=len(removed),
              retainedSourcesVerified=len(anchors), logicalBytesRemoved=plan['removableBytes'],
              protectedCompleteGameRoots=len(protected), gameLaunched=False,
              restorationSamples=receipts, temporaryRestorationFilesRemoved=True,
              boundary='Every missing path and retained hash checked; three actual full-byte reconstructions. No runtime or localization acceptance implied.')
with (HERE/'reconstruction-verification.json').open('x') as f:
    json.dump(report, f, indent=2)
print(json.dumps({k:v for k,v in report.items() if k != 'restorationSamples'}))
