"""Remove only exact redundant resource copies from inactive historical previews.

Keep unique bytes, all prior reconstruction anchors, the owner's complete build,
and current/open inputs. The gzip plan records exact reconstruction paths.
"""
import argparse
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime, timezone
import gzip
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import stat
import subprocess

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
HERE = Path(__file__).resolve().parent
PLAN = HERE / 'plan.json.gz'


def emit(path, value):
    with path.open('x') as f:
        json.dump(value, f, ensure_ascii=False, indent=2)
        f.write('\n')
        f.flush()
        os.fsync(f.fileno())


def signature(path):
    s = path.lstat()
    assert stat.S_ISREG(s.st_mode) and not path.is_symlink(), path
    return [s.st_dev, s.st_ino, s.st_size, s.st_mtime_ns, s.st_ctime_ns]


def sha(path):
    h = hashlib.sha256()
    with path.open('rb') as f:
        for chunk in iter(lambda: f.read(4 * 1024 * 1024), b''):
            h.update(chunk)
    return h.hexdigest()


def load(path):
    with (gzip.open(path, 'rt') if path.suffix == '.gz' else path.open()) as f:
        return json.load(f)


def prior_anchors():
    anchors = set()
    for path in (ROOT / 'localization/cleanup').glob('*/plan*'):
        if path.parent == HERE or path.suffix not in ('.json', '.gz'):
            continue
        data = load(path)
        for row in data.get('removals', []) + data.get('files', []):
            anchor = row.get('retainedCopy') or row.get('anchor')
            if isinstance(anchor, dict):
                anchor = anchor['path']
            if anchor:
                anchors.add(anchor)
    path = ROOT / 'localization/cleanup/20261029-duplicate-qa-games/retained-copies.json'
    anchors.update(load(path))
    return anchors


def guards():
    paths = load(ROOT / 'localization/cleanup/protected-owner-test-builds.json')['builds']
    protected = {row['path'] for row in paths if row.get('neverCleanup')}
    statuses = [ROOT / 'outputs/locale-assets-20261026/workflow-v3-completion-20261030-01/technical/status.json']
    statuses += list((ROOT / 'outputs/locale-assets-20261026').glob('*/workflow-v3-completion-20261030/status.json'))
    inputs = []
    for status in statuses:
        phases = load(status).get('phases', [])
        if phases:
            phase = Path(phases[-1]['phase'])
            inputs += [phase / name for name in ('task.json', 'brief.md', 'runtime-verification.json', 'contract.json')]
    launch = load(ROOT / 'outputs/locale-assets-20261026/launch-current.json')
    inputs += list((ROOT / launch['run']).glob('*.json'))
    for path in inputs:
        if path.is_file():
            assert path.stat().st_size < 15_000_000, ('unbounded-live-input', path)
            protected.update(re.findall(r'localization/previews/[A-Za-z0-9_-]+', path.read_text()))
    opened = subprocess.run(['lsof', '-nP', '-Fn'], capture_output=True, text=True)
    assert opened.returncode == 0, ('cannot-establish-open-files', opened.stderr)
    prefix = str(ROOT) + '/'
    for line in opened.stdout.splitlines():
        if line.startswith('n' + prefix):
            relative = line[len(prefix) + 1:]
            parts = Path(relative).parts
            if len(parts) >= 3 and parts[:2] == ('localization', 'previews'):
                protected.add('/'.join(parts[:3]))
    return protected


def tracked():
    return set(subprocess.check_output(['git', 'ls-files', '-z'], cwd=ROOT).decode().split('\0'))


def safe(relative, protected, versioned, anchors):
    path = ROOT / relative
    parts = Path(relative).parts
    assert len(parts) >= 4 and parts[:2] == ('localization', 'previews'), relative
    assert parts[3] == 'game' or (len(parts) == 4 and parts[3].startswith('noop-')), relative
    assert '/'.join(parts[:3]) not in protected, ('protected-preview', relative)
    assert relative not in versioned and relative not in anchors, ('retained-or-tracked', relative)
    assert not path.name.startswith('tfol.'), relative
    assert all(not p.is_symlink() for p in [path, *path.parents] if p.is_relative_to(ROOT)), relative
    return path


def owner_tree():
    result = {}
    for row in load(ROOT / 'localization/cleanup/protected-owner-test-builds.json')['builds']:
        for path in (ROOT / row['path']).rglob('*'):
            if path.is_file() and not path.is_symlink():
                result[str(path.relative_to(ROOT))] = signature(path)
    return result


def digest(path):
    before = signature(path)
    hashed = sha(path)
    assert signature(path) == before, ('changed-during-hash', path)
    return dict(path=str(path.relative_to(ROOT)), signature=before, bytes=before[2], sha256=hashed)


def plan():
    assert not PLAN.exists(), 'Preserve the existing plan'
    anchors, protected, versioned = prior_anchors(), guards(), tracked()
    keep, candidates = [], []
    for preview in sorted((ROOT / 'localization/previews').iterdir()):
        if not preview.is_dir() or preview.is_symlink():
            continue
        files = list((preview / 'game').rglob('*')) + list(preview.glob('noop-*'))
        for path in files:
            if not path.is_file() or path.is_symlink() or path.name.startswith('tfol.'):
                continue
            relative = str(path.relative_to(ROOT))
            if any(p.is_symlink() for p in path.parents if p.is_relative_to(ROOT)):
                continue
            if str(preview.relative_to(ROOT)) in protected or relative in anchors or relative in versioned:
                keep.append(path)
            else:
                safe(relative, protected, versioned, anchors)
                candidates.append(path)
    sizes = {p.stat().st_size for p in candidates}
    keep = [p for p in keep if p.stat().st_size in sizes]
    # Earlier reconstruction sources outside previews are also valid anchors.
    for name in sorted(anchors):
        path = ROOT / name
        if path.is_file() and not path.is_symlink() and path.stat().st_size in sizes and path not in keep:
            keep.append(path)
    index, removals = {}, []
    with ThreadPoolExecutor(max_workers=4) as pool:
        for row in pool.map(digest, keep):
            index.setdefault((row['bytes'], row['sha256']), row)
        for row in pool.map(digest, candidates):
            key = (row['bytes'], row['sha256'])
            if key in index:
                removals.append(dict(row, retainedCopy=index[key]))
            else:
                index[key] = row
    data = dict(schemaVersion=1, createdAt=datetime.now(timezone.utc).isoformat(),
                selection='Only exact redundant game/no-op payload files in inactive historical previews; all unique bytes retained.',
                protectedPreviewRoots=sorted(protected), priorAnchorCount=len(anchors),
                removals=removals, logicalBytes=sum(r['bytes'] for r in removals),
                ownerTree=owner_tree(), freeBytesBefore=shutil.disk_usage(ROOT).free)
    packed = json.dumps(data, ensure_ascii=False).encode()
    with PLAN.open('xb') as f:
        f.write(gzip.compress(packed, mtime=0))
        f.flush()
        os.fsync(f.fileno())
    assert load(PLAN) == data
    print(json.dumps(dict(removableFiles=len(removals), logicalBytes=data['logicalBytes'],
                          protectedPreviewRoots=data['protectedPreviewRoots'], priorAnchorCount=len(anchors))), flush=True)


def apply():
    assert not (HERE / 'Result.json').exists(), 'Completed cleanup must not rerun'
    data = load(PLAN)
    assert owner_tree() == data['ownerTree'], 'Owner build changed; re-evaluate'
    anchors, protected, versioned = prior_anchors(), guards(), tracked()
    sources = {r['retainedCopy']['path']: r['retainedCopy'] for r in data['removals']}
    assert not set(sources).intersection(r['path'] for r in data['removals'])
    for name, row in sources.items():
        assert signature(ROOT / name) == row['signature'] and sha(ROOT / name) == row['sha256'], ('changed-anchor', name)
    # Preflight all current candidates before the first unlink.
    for row in data['removals']:
        path = safe(row['path'], protected, versioned, anchors)
        assert signature(path) == row['signature'], ('changed-candidate', row['path'])
    before = shutil.disk_usage(ROOT).free
    removed, total = 0, 0
    with (HERE / 'deletions.jsonl').open('x') as ledger:
        for row in data['removals']:
            path = safe(row['path'], protected, versioned, anchors)
            assert signature(path) == row['signature'] and sha(path) == row['sha256'], ('changed-candidate', path)
            source = ROOT / row['retainedCopy']['path']
            assert signature(source) == row['retainedCopy']['signature'], ('changed-anchor', source)
            ledger.write(json.dumps(dict(path=row['path'], state='verified-before-unlink')) + '\n')
            ledger.flush()
            path.unlink()
            assert not path.exists()
            removed += 1
            total += row['bytes']
            if removed % 250 == 0:
                os.fsync(ledger.fileno())
        ledger.flush()
        os.fsync(ledger.fileno())
    for name, row in sources.items():
        assert signature(ROOT / name) == row['signature'] and sha(ROOT / name) == row['sha256'], ('changed-anchor-after', name)
    assert owner_tree() == data['ownerTree'], 'Owner build fingerprints changed'
    # A real restore verifies the actual reconstruction path, bytes and recipe.
    row = next((r for r in data['removals'] if 100_000 <= r['bytes'] <= 10_000_000), data['removals'][0])
    restored = ROOT / row['path']
    assert not restored.exists()
    with restored.open('xb') as dst, (ROOT / row['retainedCopy']['path']).open('rb') as src:
        shutil.copyfileobj(src, dst)
    assert signature(restored)[2] == row['bytes'] and sha(restored) == row['sha256']
    restored.unlink()
    result = dict(status='verified-duplicate-preview-payloads-removed', removedFiles=removed,
                  logicalBytesRemoved=total, freeBytesBefore=before, freeBytesAfter=shutil.disk_usage(ROOT).free,
                  retainedSources=len(sources), planSha256=sha(PLAN),
                  ownerBuildUnchanged=True, previousReconstructionAnchorsPreserved=True,
                  uniqueBytesAndReviewEvidencePreserved=True,
                  reconstruction=dict(path=row['path'], sha256=row['sha256'], status='restored-exact-path-hashed-and-removed'))
    emit(HERE / 'Result.json', result)
    print(json.dumps(result), flush=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('action', choices=['plan', 'apply'])
    args = parser.parse_args()
    plan() if args.action == 'plan' else apply()
