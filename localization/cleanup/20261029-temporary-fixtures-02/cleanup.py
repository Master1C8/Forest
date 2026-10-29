"""Remove only hash-identical native resource copies in finished test fixtures."""
import argparse
import datetime
import gzip
import hashlib
import json
import os
from pathlib import Path
import shutil
import stat
import subprocess

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
HERE = Path(__file__).resolve().parent
SCOPES = [
    'outputs/ru-bio-input185-application-20261029/check/wrong-prior-fixture',
    'outputs/ru-bio-input185-application-20261029/check/wrong-prior-fixture-final',
    'outputs/ru-bio-input185-application-20261029/check/partial-write-fixture',
    'outputs/ru-bio185-build-boundary-20261029/fixture-normal',
    'outputs/ru-bio185-build-boundary-20261029/negative-fixture',
    'outputs/ru-bio185-build-boundary-20261029/wrong-prior-fixture-final',
    'outputs/ru-bio185-build-boundary-20261029/partial-write-fixture',
    'outputs/ru-pause434-application-20261029/negative-fixtures-01',
    'outputs/ru-pause434-application-20261029/negative-fixtures-02',
]
ANCHORS = [
    'outputs/ru-bio-input185-application-20261029/check/fixture-prior',
    'outputs/ru-narrative42-application-20261029/private-source/game/The Forest of Love_Data',
]


def read(path):
    if not path.exists() and path.with_suffix(path.suffix+'.gz').exists():
        with gzip.open(path.with_suffix(path.suffix+'.gz'), 'rt') as stream:
            return json.load(stream)
    return json.loads(path.read_text())


def save(name, value):
    with (HERE/name).open('x') as stream:
        json.dump(value, stream, indent=2, ensure_ascii=False)
        stream.write('\n')
        stream.flush()
        os.fsync(stream.fileno())


def fingerprint(path):
    info = path.lstat()
    assert stat.S_ISREG(info.st_mode), ('not-regular', str(path))
    return [info.st_dev, info.st_ino, info.st_size, info.st_mtime_ns, info.st_ctime_ns]


def digest(path):
    before = fingerprint(path)
    accumulator = hashlib.sha256()
    with path.open('rb') as stream:
        for block in iter(lambda: stream.read(4 * 1024**2), b''):
            accumulator.update(block)
    result = accumulator.hexdigest()
    assert fingerprint(path) == before, ('changed-during-hash', str(path))
    return result


def native_resource(path):
    return (path.suffix in ('.assets', '.resS', '.resource', '.bundle')
            or (path.name.startswith('level') and path.name[5:].isdigit()))


def safe_path(path):
    assert path.is_relative_to(ROOT)
    assert not any(p.is_symlink() for p in [path, *path.parents] if p.is_relative_to(ROOT))


def opened():
    result = subprocess.run(['lsof', '-nP', '-Fn'], capture_output=True, text=True)
    assert result.returncode == 0, 'cannot-establish-open-paths'
    return [Path(line[1:]) for line in result.stdout.splitlines() if line.startswith('n/')]


def assert_idle():
    for path in opened():
        assert not any(path.is_relative_to(ROOT/scope) for scope in SCOPES), ('busy-fixture', str(path))
    processes = subprocess.check_output(['ps', '-axo', 'pid,ppid,command'], text=True)
    assert not any('Forest' in line and ('codex exec ' in line or 'dotnet ' in line)
                   for line in processes.splitlines()), 'active-project-worker'


def protected_tree():
    records = {}
    policy = read(ROOT/'localization/cleanup/protected-owner-test-builds.json')
    for build in policy['builds']:
        base = ROOT/build['path']
        for directory, dirs, files in os.walk(base, followlinks=False):
            for name in files:
                path = Path(directory)/name
                if not path.is_symlink():
                    records[str(path.relative_to(ROOT))] = fingerprint(path)
    for path in [ROOT/'Играть по-русски.command', ROOT/'dist/Forest-Russian-Test-20261029/manifest.json']:
        records[str(path.relative_to(ROOT))] = fingerprint(path)
    return records


def plan():
    assert not any((HERE/name).exists() for name in ('plan.json', 'plan.json.gz', 'Result.json')), 'preserve-existing-cleanup'
    assert_idle()
    versioned = set(subprocess.check_output(['git', 'ls-files', '-z'], cwd=ROOT).decode().split('\0'))
    historical = read(ROOT/'localization/cleanup/20261029-duplicate-qa-games/retained-copies.json')
    candidates = []
    for scope in SCOPES:
        for path in sorted((ROOT/scope).rglob('*')):
            if not path.is_file() or path.is_symlink() or not native_resource(path):
                continue
            safe_path(path)
            rel = str(path.relative_to(ROOT))
            if path.stat().st_size < 1024**2 or rel in versioned or rel in historical:
                continue
            subprocess.run(['git', 'check-ignore', '-q', '--', rel], cwd=ROOT, check=True)
            candidates.append(path)
    sizes = {p.stat().st_size for p in candidates}
    by_size = {}
    anchor_paths = []
    for base in ANCHORS:
        anchor_paths.extend(p for p in (ROOT/base).rglob('*')
                            if p.is_file() and not p.is_symlink() and native_resource(p))
    # Existing reconstruction sources remain protected, including later cleanup anchors.
    anchor_paths.extend(ROOT/name for name in historical if (ROOT/name).is_file())
    for path in dict.fromkeys(anchor_paths):
        if path.stat().st_size in sizes:
            safe_path(path)
            by_size.setdefault(path.stat().st_size, []).append(path)
    cache = {}
    rows, unique = [], []
    for path in candidates:
        identity = fingerprint(path)
        sha = digest(path)
        match = None
        for anchor in by_size.get(identity[2], []):
            if anchor not in cache:
                cache[anchor] = (fingerprint(anchor), digest(anchor))
            if cache[anchor][1] == sha:
                match = anchor
                break
        if match is None:
            unique.append(dict(path=str(path.relative_to(ROOT)), bytes=identity[2], sha256=sha))
            continue
        rows.append(dict(path=str(path.relative_to(ROOT)), fingerprint=identity,
                         bytes=identity[2], sha256=sha, retainedCopy=str(match.relative_to(ROOT)),
                         retainedFingerprint=cache[match][0]))
    assert not {r['path'] for r in rows}.intersection(r['retainedCopy'] for r in rows)
    save('plan.json', dict(schemaVersion=1, createdAt=datetime.datetime.now(datetime.timezone.utc).isoformat(),
         scopes=SCOPES, removals=rows, preservedUnique=unique,
         protectedTree=protected_tree(), freeBytesBefore=shutil.disk_usage(ROOT).free,
         logicalBytes=sum(r['bytes'] for r in rows),
         boundary='Finished fixture resource duplicates only; retained source bytes make each removed path reconstructible.'))
    print(json.dumps(dict(plannedFiles=len(rows), logicalBytes=sum(r['bytes'] for r in rows), preservedUnique=len(unique))), flush=True)


def apply():
    data = read(HERE/'plan.json')
    assert data['scopes'] == SCOPES
    assert not (HERE/'deletions.jsonl').exists(), 'reconcile-existing-execution-before-resuming'
    assert_idle()
    assert protected_tree() == data['protectedTree'], 'protected-copy-changed-since-plan'
    versioned = set(subprocess.check_output(['git', 'ls-files', '-z'], cwd=ROOT).decode().split('\0'))
    verified = set()
    for row in data['removals']:
        anchor = ROOT/row['retainedCopy']
        if anchor not in verified:
            assert fingerprint(anchor) == row['retainedFingerprint'] and digest(anchor) == row['sha256']
            verified.add(anchor)
    removed = []
    with (HERE/'deletions.jsonl').open('x') as ledger:
        for row in data['removals']:
            path, anchor = ROOT/row['path'], ROOT/row['retainedCopy']
            safe_path(path)
            assert any(path.is_relative_to(ROOT/scope) for scope in SCOPES)
            assert row['path'] not in versioned
            assert fingerprint(path) == row['fingerprint'] and digest(path) == row['sha256']
            assert fingerprint(anchor) == row['retainedFingerprint']
            ledger.write(json.dumps(dict(row, state='verified-before-unlink'))+'\n')
            ledger.flush()
            # The complete plan is already fsynced; batch device flushes.
            if len(removed) % 32 == 0:
                os.fsync(ledger.fileno())
            path.unlink()
            assert not path.exists()
            removed.append(row)
        os.fsync(ledger.fileno())
    assert protected_tree() == data['protectedTree'], 'protected-copy-changed-during-cleanup'
    for anchor in verified:
        row = next(r for r in removed if ROOT/r['retainedCopy'] == anchor)
        assert fingerprint(anchor) == row['retainedFingerprint'] and digest(anchor) == row['sha256']
    # Exercise an actual reconstruction without changing a historical fixture.
    sample = min(removed, key=lambda r:r['bytes'])
    restore = HERE/'restoration-check.tmp'
    shutil.copyfile(ROOT/sample['retainedCopy'], restore)
    assert digest(restore) == sample['sha256']
    restore.unlink()
    result = dict(status='completed', filesRemoved=len(removed),
                  logicalBytesRemoved=sum(r['bytes'] for r in removed),
                  freeBytesBefore=data['freeBytesBefore'], freeBytesAfter=shutil.disk_usage(ROOT).free,
                  retainedSourcesRehashed=len(verified), protectedOwnerTreeUnchanged=True,
                  preservedUniqueFiles=len(data['preservedUnique']),
                  restorationCheck=dict(originalPath=sample['path'], sha256=sample['sha256'], passed=True),
                  note='Logical bytes differ from physical recovery on APFS. Historical fixtures require restoration before rerun.')
    save('Result.json', result)
    print(json.dumps(result), flush=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('mode', choices=['plan', 'apply'])
    args = parser.parse_args()
    plan() if args.mode == 'plan' else apply()
