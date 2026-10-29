"""Remove verified duplicate files from inactive QA copies; keep reconstruction maps."""
import argparse
import concurrent.futures
import hashlib
import json
import os
from pathlib import Path
import shutil
import stat
import subprocess
import time

HERE = Path(__file__).resolve().parent
SCOPE = json.loads((HERE / 'scope.json').read_text())
ROOT = Path(SCOPE['root'])
PROTECTED = {ROOT / p for p in SCOPE['protectedGameRoots']}


def signature(p):
    s = p.lstat()
    assert stat.S_ISREG(s.st_mode), p
    return [s.st_dev, s.st_ino, s.st_size, s.st_mtime_ns, s.st_ctime_ns]


def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda: f.read(4 * 1024 * 1024), b''):
            h.update(b)
    return h.hexdigest()


def opened():
    p = subprocess.run(['lsof', '-nP', '-Fn'], capture_output=True, text=True)
    assert p.returncode == 0, 'Cannot establish open files'
    return {Path(l[1:]) for l in p.stdout.splitlines() if l.startswith('n/')}


def tracked():
    return set(subprocess.check_output(['git', 'ls-files', '-z'], cwd=ROOT).decode().split('\0'))


def active_game_roots(paths):
    roots = set()
    for p in paths:
        if not p.is_relative_to(ROOT):
            continue
        parts = p.relative_to(ROOT).parts
        if len(parts) >= 4 and parts[0] == 'localization' and parts[1] in ('probes', 'previews') and parts[3] == 'game':
            roots.add(ROOT.joinpath(*parts[:4]))
    return roots


def safe(p):
    assert p.is_relative_to(ROOT) and not p.is_symlink(), p
    rel = p.relative_to(ROOT)
    assert len(rel.parts) >= 5 and rel.parts[0] == 'localization'
    assert rel.parts[1] in ('probes', 'previews') and rel.parts[3] == 'game'
    assert all(not q.is_symlink() for q in p.parents if q.is_relative_to(ROOT)), p
    assert ROOT.joinpath(*rel.parts[:4]) not in PROTECTED, p
    assert not p.name.startswith('tfol.'), p


def inventory():
    busy, versioned = opened(), tracked()
    busy_games = active_game_roots(busy)
    keep, candidates = [], []
    for parent in ('localization/probes', 'localization/previews'):
        for game in sorted((ROOT / parent).glob('*/game')):
            if game.is_symlink():
                continue
            if game.parent.name == 'ru-20261029-bio-input-01':
                # The current build is protected but is not an immutable anchor.
                continue
            # Open descendants protect the whole game, including later-read files.
            active = game in busy_games
            if active:
                continue
            for p in game.rglob('*'):
                if p.is_symlink() or not p.is_file():
                    continue
                if any(q.is_symlink() for q in p.parents if q.is_relative_to(game)):
                    continue
                rel = str(p.relative_to(ROOT))
                if active or game in PROTECTED or rel in versioned or p.name.startswith('tfol.'):
                    keep.append(p)
                else:
                    safe(p)
                    candidates.append(p)
    return keep, candidates


def plan():
    assert not (HERE / 'plan.json').exists(), 'Preserve the existing plan'
    keep, candidates = inventory()
    sizes = {p.stat().st_size for p in candidates}
    files = [(p, True) for p in keep if p.stat().st_size in sizes]
    files += [(p, False) for p in candidates]
    start = time.monotonic()

    def digest(row):
        p, retained = row
        before = signature(p)
        h = sha(p)
        assert signature(p) == before, ('changed-during-hash', p)
        return dict(path=str(p.relative_to(ROOT)), signature=before,
                    sha256=h, bytes=before[2], retained=retained)

    anchors, removals = {}, []
    examined = 0
    with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
        for r in pool.map(digest, files):
            key = (r['bytes'], r['sha256'])
            if key not in anchors:
                anchors[key] = r
            elif not r['retained']:
                removals.append(dict(r, retainedCopy=anchors[key]))
            examined += 1
            if examined % 5000 == 0:
                print(json.dumps(dict(examined=examined, total=len(files),
                      removableBytes=sum(r['bytes'] for r in removals))), flush=True)
    result = dict(schemaVersion=1, root=str(ROOT), removals=removals,
                  examinedFiles=examined, retainedAnchors=len(anchors),
                  candidateFiles=len(candidates), removedFiles=0,
                  removableBytes=sum(r['bytes'] for r in removals),
                  seconds=time.monotonic()-start,
                  boundary='Exact SHA256/length duplicates only. Logical bytes are not physical freed space.')
    with (HERE / 'plan.json').open('x') as f:
        json.dump(result, f, indent=2)
    print(json.dumps({k:v for k,v in result.items() if k != 'removals'}), flush=True)


def apply():
    plan_path = HERE / 'plan.json'
    d = json.loads(plan_path.read_text())
    assert d['root'] == str(ROOT)
    ledger_path = HERE / 'deletions.jsonl'
    prior = {}
    planned = {r['path']: r for r in d['removals']}
    if ledger_path.exists():
        for line in ledger_path.read_text().splitlines():
            row = json.loads(line)
            assert row['path'] in planned, ('unknown-ledger-path', row['path'])
            assert all(row[k] == v for k, v in planned[row['path']].items()), row['path']
            prior[row['path']] = row
    busy, versioned = opened(), tracked()
    busy_games = active_game_roots(busy)
    sources = {r['retainedCopy']['path']:r['retainedCopy'] for r in d['removals']}
    removed = {r['path'] for r in d['removals']}
    assert not removed.intersection(sources), 'A retained source may never be removed'
    for name, r in sources.items():
        p = ROOT / name
        assert signature(p)[:4] == r['signature'][:4] and sha(p) == r['sha256'], ('retained-source', name)
    total = 0
    with ledger_path.open('a' if ledger_path.exists() else 'x', buffering=1) as ledger:
        for index, r in enumerate(d['removals']):
            p, source = ROOT / r['path'], ROOT / r['retainedCopy']['path']
            safe(p)
            game = ROOT.joinpath(*p.relative_to(ROOT).parts[:4])
            assert game not in busy_games, ('active-game', game)
            assert r['path'] not in versioned, ('tracked', p)
            if not p.exists():
                assert r['path'] in prior, ('unrecorded-missing-path', p)
                total += r['bytes']
                continue
            assert signature(p)[:4] == r['signature'][:4] and sha(p) == r['sha256'], ('changed-candidate', p)
            assert signature(source)[:4] == r['retainedCopy']['signature'][:4], ('changed-anchor', source)
            # Persist the exact reconstruction source before the destructive step.
            ledger.write(json.dumps(dict(r, state='verified-before-unlink')) + '\n')
            ledger.flush()
            # The complete reconstruction plan was fsynced before application.
            # Batched ledger sync avoids a device flush for each tiny DLL.
            if index % 250 == 0:
                os.fsync(ledger.fileno())
            p.unlink()
            assert not p.exists()
            total += r['bytes']
        ledger.flush()
        os.fsync(ledger.fileno())
    result = dict(status='verified-duplicates-removed', removedFiles=len(d['removals']),
                  logicalBytesRemoved=total, freeBytesAfter=shutil.disk_usage(ROOT).free,
                  freeBytesBefore=SCOPE['beforeFreeBytes'], planSha256=sha(plan_path),
                  retainedSources=len(sources), originalEvidenceAndUniqueFilesPreserved=True)
    (HERE / 'Result.json').write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps(result), flush=True)


if __name__ == '__main__':
    p = argparse.ArgumentParser()
    p.add_argument('mode', choices=['plan', 'apply'])
    a = p.parse_args()
    plan() if a.mode == 'plan' else apply()
