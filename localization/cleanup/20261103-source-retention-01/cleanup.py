"""Prune only recoverable binary duplicates; keep unfinished work and unique data."""
import argparse
import gzip
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import shutil
import subprocess

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
HERE = Path(__file__).resolve().parent
HELPER = ROOT/'localization/cleanup/20261031-verified-duplicates/cleanup.py'
spec = importlib.util.spec_from_file_location('preserved_duplicate_restore', HELPER)
h = importlib.util.module_from_spec(spec)
spec.loader.exec_module(h)
CACHE = {}


def read(p):
    with (gzip.open(p, 'rt') if p.suffix == '.gz' else p.open()) as f:
        return json.load(f)


def write(p, d):
    with p.open('x') as f:
        json.dump(d, f, ensure_ascii=False, indent=2)
        f.write('\n')


def local(name):
    p = ROOT/name
    assert not Path(name).is_absolute() and p.resolve().is_relative_to(ROOT)
    assert not any(x.is_symlink() for x in [p, *p.parents] if x.is_relative_to(ROOT))
    return p


def sha(p):
    before = h.sig(p)
    k = tuple(before)
    if k not in CACHE:
        CACHE[k] = h.sha(p)
    assert h.sig(p) == before, ('file changed while hashing', str(p))
    return CACHE[k]


def files(folder):
    for directory, dirs, names in os.walk(folder, followlinks=False):
        dirs[:] = sorted(d for d in dirs if not (Path(directory)/d).is_symlink())
        for name in sorted(names):
            p = Path(directory)/name
            if p.is_file() and not p.is_symlink():
                yield p


def under(name, roots):
    n = name.casefold()
    return any(n == r.casefold() or n.startswith(r.casefold()+'/') for r in roots)


def payload(p):
    n = p.name.lower()
    if n.startswith('tfol.') or any(x in n for x in ['savegame', 'playerprefs', 'savebackup']):
        return False
    return (p.suffix.lower() in {'.assets', '.ress', '.resource', '.bundle', '.dll', '.exe', '.pdb'} or
            '/game/' in str(p) and (n.startswith('level') and n[5:].isdigit() or n == 'globalgamemanagers'))


def protections():
    h.idle()
    tracked = set(subprocess.check_output(['git', 'ls-files', '-z'], cwd=ROOT, text=True).split('\0'))
    roots = {'assets', 'dist', 'localization/framework', 'localization/source', 'localization/fonts',
             'localization/languages', 'localization/editorial-delivery', 'localization/completion',
             'localization/visual-qa', 'localization/cleanup', 'outputs/last-six-locales-20261103-01'}
    owner = read(ROOT/'localization/cleanup/protected-owner-test-builds.json')
    roots.update(r['path'] for r in owner['builds'])
    anchors = set()

    def collect(value, retained=False):
        if isinstance(value, dict):
            for k, v in value.items():
                yes = retained or k in {'retained', 'retainedCopy', 'anchor', 'retainedCompanions'}
                if yes and isinstance(v, str) and '/' in v and (ROOT/v).is_file():
                    anchors.add(str(Path(v)))
                collect(v, yes)
        elif isinstance(value, list):
            for v in value:
                collect(v, retained)

    for p in (ROOT/'localization/cleanup').glob('*/*'):
        if p.parent == HERE or not p.is_file():
            continue
        if p.name.startswith('plan') and p.suffix in {'.gz', '.json'}:
            collect(read(p))
        elif p.name == 'retained-files.json':
            anchors.update(r['path'] for r in read(p)['files'])
        elif p.name == 'retained-copies.json':
            anchors.update(read(p))
    opened = subprocess.run(['lsof', '-nP', '-Fn'], capture_output=True, text=True)
    assert opened.returncode == 0
    prefix = 'n'+str(ROOT)+'/'
    live = {line[len(prefix):] for line in opened.stdout.splitlines() if line.startswith(prefix)}
    for n in live:
        parts = n.split('/')
        if len(parts) >= 3 and parts[:2] in [['localization', 'probes'], ['localization', 'previews']]:
            roots.add('/'.join(parts[:3]))
    return roots, tracked, anchors, live


def fingerprint():
    # Source and all current deliverables remain in their original paths.
    paths = set()
    for root in ['localization/languages', 'localization/framework', 'dist',
                 'localization/previews/ru-20261029-narrative42-01',
                 'outputs/last-six-locales-20261103-01']:
        paths.update(files(ROOT/root))
    return {str(p.relative_to(ROOT)): dict(signature=h.sig(p), sha256=sha(p)) for p in sorted(paths)}


def plan():
    assert not (HERE/'plan.json.gz').exists(), 'Reconcile the existing plan'
    roots, tracked, anchors, live = protections()
    candidates = []
    for root in ['outputs', 'localization/probes', 'localization/previews']:
        for p in files(ROOT/root):
            n = str(p.relative_to(ROOT))
            if payload(p) and not under(n, roots) and n not in tracked | anchors | live:
                candidates.append(p)
    sizes = {p.stat().st_size for p in candidates}
    pool = {}
    retained = set()
    for root in ['localization/framework', 'dist', 'assets', 'localization/previews/ru-20261029-narrative42-01']:
        retained.update(files(ROOT/root))
    retained.update(ROOT/n for n in anchors if (ROOT/n).is_file())
    for p in sorted(retained):
        if p.stat().st_size in sizes:
            pool.setdefault((p.stat().st_size, sha(p)), p)
    removals, unique, skipped = [], [], []
    for index, p in enumerate(sorted(set(candidates)), 1):
        attrs = h.xattrs(p)
        if set(attrs)-{'com.apple.provenance', 'com.apple.quarantine'}:
            skipped.append(str(p.relative_to(ROOT)))
            continue
        key = p.stat().st_size, sha(p)
        other = pool.get(key)
        if other is None:
            pool[key] = p
            unique.append(str(p.relative_to(ROOT)))
        else:
            removals.append(dict(path=str(p.relative_to(ROOT)), retained=str(other.relative_to(ROOT)),
                                 bytes=key[0], sha256=key[1], signature=h.sig(p),
                                 retainedSignature=h.sig(other), xattrs=attrs,
                                 allocatedBytes=p.stat().st_blocks*512))
        if index % 3000 == 0:
            print(json.dumps(dict(stage='hashing', checked=index, duplicates=len(removals))), flush=True)
    data = dict(atUTC=h.now(), scope='Only exact redundant binary copies; source-only archival remains pending.',
                helperSha256=sha(HELPER), protectedRoots=sorted(roots), priorAnchors=sorted(anchors),
                files=removals, uniqueKept=unique, skippedAttributes=skipped,
                preserved=fingerprint(), logicalBytes=sum(r['bytes'] for r in removals))
    assert not {r['path'] for r in removals} & {r['retained'] for r in removals}
    with gzip.open(HERE/'plan.json.gz', 'xt') as f:
        json.dump(data, f)
    summary = dict(atUTC=h.now(), selectedFiles=len(removals), logicalBytes=data['logicalBytes'],
                   allocatedBytes=sum(r['allocatedBytes'] for r in removals), uniqueKept=len(unique),
                   preservedFingerprintFiles=len(data['preserved']), priorAnchors=len(anchors),
                   scope=data['scope'], protectedRoots=data['protectedRoots'])
    write(HERE/'plan-summary.json', summary)
    print(json.dumps(summary), flush=True)


def apply():
    assert not (HERE/'result.json').exists() and not (HERE/'deletions.jsonl.gz').exists(), 'Never blindly repeat an apply'
    d = read(HERE/'plan.json.gz')
    assert sha(HELPER) == d['helperSha256']
    roots, tracked, anchors, live = protections()
    assert set(d['priorAnchors']) <= anchors
    for name, r in d['preserved'].items():
        p = local(name)
        assert h.sig(p) == r['signature'] and sha(p) == r['sha256'], ('protected input changed', name)
    retained = {r['retained']: r for r in d['files']}
    for name, r in retained.items():
        assert h.sig(local(name)) == r['retainedSignature'] and sha(local(name)) == r['sha256']
    free = shutil.disk_usage(ROOT).free
    with gzip.open(HERE/'deletions.jsonl.gz', 'xt') as f:
        for index, r in enumerate(d['files'], 1):
            if index % 500 == 0:
                h.idle()
            n = r['path']; p = local(n); a = local(r['retained'])
            assert payload(p) and not under(n, roots) and n not in tracked | anchors | live
            assert h.sig(p) == r['signature'] and sha(p) == r['sha256'] and h.xattrs(p) == r['xattrs']
            assert h.sig(a) == r['retainedSignature']
            p.unlink()
            f.write(json.dumps(r)+'\n'); f.flush()
    sample = max(d['files'], key=lambda r:r['bytes'])
    h.restore_row(sample)
    assert sha(local(sample['path'])) == sample['sha256']
    local(sample['path']).unlink()
    assert all(not local(r['path']).exists() for r in d['files'])
    for name, r in d['preserved'].items():
        assert h.sig(local(name)) == r['signature'] and sha(local(name)) == r['sha256']
    result = dict(atUTC=h.now(), deletedFiles=len(d['files']), logicalBytes=d['logicalBytes'],
                  allocatedBytesUnlinked=sum(r['allocatedBytes'] for r in d['files']),
                  freeBefore=free, freeAfter=shutil.disk_usage(ROOT).free,
                  retainedAnchors=len(retained), protectedFilesVerified=len(d['preserved']),
                  exactOriginalPathRestore=dict(path=sample['path'], sha256=sample['sha256'], bytes=sample['bytes']),
                  sourceOnlyArchival='pending: unfinished project, no configured GitHub remote, protected owner test copy',
                  noProcessesStartedOrStopped=True)
    write(HERE/'result.json', result)
    print(json.dumps(result), flush=True)


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('action', choices=['plan', 'apply', 'restore'])
    p.add_argument('--path')
    a = p.parse_args()
    if a.action == 'plan':
        plan()
    elif a.action == 'apply':
        apply()
    else:
        row = next(r for r in read(HERE/'plan.json.gz')['files'] if r['path'] == a.path)
        assert not local(row['path']).exists()
        h.restore_row(row)
