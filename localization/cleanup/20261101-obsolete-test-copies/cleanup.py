"""Prune exact redundant historical test payloads, preserving live and final work."""
from pathlib import Path
import argparse
import datetime
import gzip
import hashlib
import importlib.util
import json
import os
import re
import shutil
import subprocess

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
HERE = Path(__file__).resolve().parent
PLAN = HERE / 'plan.json.gz'
spec = importlib.util.spec_from_file_location('prior_cleanup', ROOT / 'localization/cleanup/20261031-verified-duplicates/cleanup.py')
helper = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helper)
CACHE = {}


def now():
    return datetime.datetime.now(datetime.timezone.utc).isoformat()


def read(path):
    with (gzip.open(path, 'rt') if path.suffix == '.gz' else path.open()) as stream:
        return json.load(stream)


def save(path, value):
    with path.open('x') as stream:
        json.dump(value, stream, indent=2)
        stream.write('\n')


def sha(path):
    signature = helper.sig(path)
    key = tuple(signature)
    if key not in CACHE:
        CACHE[key] = helper.sha(path)
    assert helper.sig(path) == signature, ('changed during hash', str(path))
    return CACHE[key]


def local(name):
    path = ROOT / name
    assert not Path(name).is_absolute() and path.resolve().is_relative_to(ROOT)
    assert all(not p.is_symlink() for p in [path, *path.parents] if p.is_relative_to(ROOT))
    return path


def files(folder):
    for directory, dirs, names in os.walk(folder, followlinks=False):
        dirs[:] = sorted(d for d in dirs if not (Path(directory) / d).is_symlink())
        for name in sorted(names):
            path = Path(directory) / name
            if path.is_file() and not path.is_symlink():
                yield path


def protection():
    versioned = set(subprocess.check_output(['git', 'ls-files', '-z'], cwd=ROOT, text=True).split('\0'))
    protected = {'dist', 'assets', 'localization/framework', 'localization/source', 'localization/fonts',
                 'outputs/five-new-locales-20261101-01', 'outputs/six-new-locales-20261101-01'}
    registry = read(ROOT / 'localization/cleanup/protected-owner-test-builds.json')
    protected.update(row['path'] for row in registry['builds'])
    current = read(ROOT / 'localization/completion/five-new-locales-20261101-01/current-status.json')
    assert current['status'] == 'five-owner-resumed-cli-authors-running'
    live_documents = [ROOT / 'localization/fonts/README.md', ROOT / 'LOCALIZATION.md']
    for lane in current['lanes']:
        phase = ROOT / lane['phase']
        protected.add(lane['phase'])
        task = read(phase / 'task.json')
        live_documents += [phase / 'task.json', phase / 'brief.md']
        live_documents += [ROOT / p for p in task['job']['immutablePins']]
        versioned.update(task['job']['immutablePins'])
    launch = read(ROOT / 'outputs/locale-assets-20261026/launch-current.json')
    protected.add(launch['run'])
    # A directory mentioned by an actual current source/control document may be
    # read later even when it is not open now. Protect its entire historical run.
    pattern = re.compile(r'(?:outputs/[A-Za-z0-9_.-]+|localization/(?:probes|previews)/[A-Za-z0-9_.-]+)')
    for document in set(live_documents):
        if document.is_file():
            protected.update(pattern.findall(document.read_text()))
    anchors = set()
    for path in (ROOT / 'localization/cleanup').glob('*/plan*'):
        if path.parent == HERE or path.suffix not in {'.json', '.gz'}:
            continue
        data = read(path)
        for row in data.get('files', []) + data.get('removals', []):
            for field in ['retained', 'retainedCopy', 'anchor']:
                value = row.get(field)
                if isinstance(value, dict):
                    value = value.get('path')
                if isinstance(value, str):
                    anchors.add(value)
    retained = ROOT / 'localization/cleanup/20261029-duplicate-qa-games/retained-copies.json'
    if retained.exists():
        anchors.update(read(retained))
    opened = subprocess.run(['lsof', '-nP', '-Fn'], capture_output=True, text=True)
    assert opened.returncode == 0, 'Cannot establish open-file ownership'
    open_files = set()
    prefix = 'n' + str(ROOT) + '/'
    for line in opened.stdout.splitlines():
        if line.startswith(prefix):
            name = line[len(prefix):]
            open_files.add(name)
            match = pattern.match(name)
            if match:
                protected.add(match.group())
    return protected, versioned, anchors, open_files


def under(name, roots):
    return any(name == p or name.startswith(p + '/') for p in roots)


def payload(path):
    name = str(path.relative_to(ROOT))
    lower = path.name.lower()
    if lower.startswith('tfol.') or any(x in lower for x in ['savegame', 'playerprefs', 'savebackup']):
        return False
    if path.suffix.lower() in {'.assets', '.ress', '.resource', '.bundle', '.dll', '.exe', '.pdb'}:
        return True
    if '/game/' in name and (lower.startswith('level') and lower[5:].isdigit() or lower == 'globalgamemanagers'):
        return True
    return path.name == 'objects.json' and '/inputs/assets/source-v2/' in name


def frozen_fingerprint():
    result = {}
    for name in ['dist', 'localization/framework', 'localization/languages']:
        for path in files(ROOT / name):
            # Active own-locale language data may legitimately advance. It is
            # excluded from candidates and never asserted to stay unchanged.
            if name == 'localization/languages' and path.stem in {'th', 'vi', 'id', 'uk', 'ar'}:
                continue
            result[str(path.relative_to(ROOT))] = dict(signature=helper.sig(path), sha256=sha(path))
    return result


def plan():
    assert not PLAN.exists(), 'Reconcile the existing plan instead of replacing it'
    protected, versioned, anchors, opened = protection()
    candidates = []
    for name in ['outputs', 'localization/probes', 'localization/previews']:
        for path in files(ROOT / name):
            rel = str(path.relative_to(ROOT))
            if payload(path) and not under(rel, protected) and rel not in versioned | anchors | opened:
                candidates.append(path)
    sizes = {p.stat().st_size for p in candidates}
    pool = {}
    # Protect all old restoration anchors and canonical/current/final bytes.
    retain_paths = set()
    for name in ['assets', 'dist', 'localization/framework', 'localization/previews/ru-20261029-narrative42-01/game']:
        retain_paths.update(files(ROOT / name))
    retain_paths.update(ROOT / name for name in anchors if (ROOT / name).is_file())
    for path in sorted(retain_paths):
        if path.stat().st_size in sizes and not path.is_symlink():
            pool.setdefault((path.stat().st_size, sha(path)), path)
    print(json.dumps(dict(stage='anchors-indexed', candidates=len(candidates), retainedKeys=len(pool))), flush=True)
    removals, unique, skipped = [], [], []
    for index, path in enumerate(sorted(candidates)):
        name = str(path.relative_to(ROOT))
        attrs = helper.xattrs(path)
        if set(attrs) - {'com.apple.provenance', 'com.apple.quarantine'}:
            skipped.append(dict(path=name, reason='unique extended attributes'))
            continue
        key = path.stat().st_size, sha(path)
        retained = pool.get(key)
        if retained is None:
            pool[key] = path
            unique.append(name)
        else:
            removals.append(dict(path=name, retained=str(retained.relative_to(ROOT)), bytes=key[0],
                                 allocatedBytes=path.stat().st_blocks * 512, sha256=key[1],
                                 signature=helper.sig(path), retainedSignature=helper.sig(retained), xattrs=attrs))
        if index and index % 500 == 0:
            print(json.dumps(dict(stage='checking', checked=index, duplicateFiles=len(removals))), flush=True)
    data = dict(atUTC=now(), ownerInstruction='Remove obsolete test game/build copies while protecting current tasks and completed localizations.',
                protectedRoots=sorted(protected), priorAnchors=sorted(anchors), files=removals, uniqueKept=unique,
                skipped=skipped, finalFingerprint=frozen_fingerprint(), freeBeforePlan=shutil.disk_usage(ROOT).free,
                scope='Only exact duplicate raw historical test payload files. Unique binaries, recipes, saves, screenshots, text, logs, frozen inputs and final distributions retained.')
    with gzip.open(PLAN, 'xt') as stream:
        json.dump(data, stream)
    save(HERE / 'plan-summary.json', dict(atUTC=now(), files=len(removals), logicalBytes=sum(r['bytes'] for r in removals),
         allocatedBytes=sum(r['allocatedBytes'] for r in removals), uniqueFilesRetained=len(unique), protectedRoots=sorted(protected)))
    print((HERE / 'plan-summary.json').read_text(), flush=True)


def apply():
    assert not (HERE / 'result.json').exists(), 'Never repeat a completed apply'
    data = read(PLAN)
    protected, versioned, anchors, opened = protection()
    selected = {row['path'] for row in data['files']}
    assert not selected & {row['retained'] for row in data['files']}
    retained = {row['retained']: row for row in data['files']}
    for name, row in retained.items():
        path = local(name)
        assert helper.sig(path) == row['retainedSignature'] and sha(path) == row['sha256'], ('anchor changed', name)
    for name, record in data['finalFingerprint'].items():
        path = local(name)
        assert helper.sig(path) == record['signature'] and sha(path) == record['sha256'], ('final changed', name)
    before = shutil.disk_usage(ROOT).free
    deleted = 0
    with gzip.open(HERE / 'deletions.jsonl.gz', 'xt') as stream:
        for row in data['files']:
            name = row['path']; path = local(name)
            assert payload(path) and not under(name, protected) and name not in versioned | anchors | opened, name
            assert helper.sig(path) == row['signature'] and sha(path) == row['sha256'] and helper.xattrs(path) == row['xattrs'], ('candidate changed', name)
            assert helper.sig(local(row['retained'])) == row['retainedSignature']
            path.unlink()
            stream.write(json.dumps(row) + '\n'); stream.flush()
            deleted += 1
            if deleted % 500 == 0:
                print(json.dumps(dict(stage='deleting', deletedFiles=deleted)), flush=True)
    # Actual exact-path restore verifies retained bytes and metadata before
    # returning one bounded duplicate to its intended pruned state.
    sample = next((r for r in data['files'] if 1_000_000 <= r['bytes'] <= 20_000_000), data['files'][0])
    helper.restore_row(sample)
    assert sha(local(sample['path'])) == sample['sha256']
    local(sample['path']).unlink()
    for row in data['files']:
        assert not local(row['path']).exists()
    for name, record in data['finalFingerprint'].items():
        assert helper.sig(local(name)) == record['signature'] and sha(local(name)) == record['sha256']
    result = dict(atUTC=now(), deletedFiles=deleted, logicalBytes=sum(r['bytes'] for r in data['files']),
                  allocatedBytesUnlinked=sum(r['allocatedBytes'] for r in data['files']),
                  freeBefore=before, freeAfter=shutil.disk_usage(ROOT).free,
                  finalFingerprintFilesVerified=len(data['finalFingerprint']), retainedAnchorsVerified=len(retained),
                  exactPathRestoreVerified=dict(path=sample['path'], retained=sample['retained'], sha256=sample['sha256']),
                  noProcessStopped=True, noCurrentTaskOrCompletedLocalizationDeleted=True,
                  uniquePayloadFilesRetained=len(data['uniqueKept']), protectedRoots=data['protectedRoots'])
    save(HERE / 'result.json', result)
    print(json.dumps(result), flush=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', choices=['plan', 'apply'])
    args = parser.parse_args()
    plan() if args.action == 'plan' else apply()
