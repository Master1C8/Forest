#!/usr/bin/env python3
"""Owner-authorized, content-verified Forest storage cleanup. No workers launch.

Deletion is limited to disposable round-trip outputs with successful matching
build receipts, and untracked Python bytecode under current tools. Unique game
outputs, saves, sources, frozen inputs and the accepted Russian build survive.
APFS compaction retains each path and independent copy-on-write semantics.
"""
import collections
import ctypes
import hashlib
import json
import os
from pathlib import Path
import shutil
import stat
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
ACCEPTED = ROOT / 'localization/previews/ru-20261029-narrative42-01'
SCOPES = ('outputs', 'localization/probes', 'localization/previews', 'localization/fonts')


def sha(path):
    h = hashlib.sha256()
    with path.open('rb') as f:
        for b in iter(lambda: f.read(4 * 1024**2), b''):
            h.update(b)
    return h.hexdigest()


def rel(path):
    return str(path.relative_to(ROOT))


def identity(path):
    s = path.stat()
    return [s.st_dev, s.st_ino, s.st_size, s.st_mtime_ns, s.st_mode, s.st_nlink]


def save(name, data):
    (HERE / name).write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n')


def guarded(path):
    assert path.is_relative_to(ROOT) and not path.is_symlink()
    assert not any(p.is_symlink() for p in path.parents if p.is_relative_to(ROOT))
    assert not path.is_relative_to(ACCEPTED)
    assert not path.stat().st_flags, ('file-flags', rel(path))


def no_workers():
    # Recheck ownership, not broad process-name termination. Never signal here.
    rows = subprocess.check_output(['ps', '-axo', 'pid=,command='], text=True)
    for line in rows.splitlines():
        command = line.lstrip().split(' ', 1)[-1].strip()
        if 'codex exec' in command and str(ROOT) in command:
            raise RuntimeError('Forest worker still present; preserve its inputs')


def plan():
    no_workers()
    tracked = set(subprocess.check_output(['git', 'ls-files', '-z'], cwd=ROOT).decode().split('\0'))
    deleted, held = [], []
    for scope in ('localization/probes', 'localization/previews'):
        for directory in sorted((ROOT / scope).iterdir()):
            if not directory.is_dir() or directory == ACCEPTED or directory.is_symlink():
                continue
            files = sorted(directory.glob('noop-*'))
            if not files:
                continue
            receipt = directory / 'build.json'
            try:
                report = json.loads(receipt.read_text())
            except (FileNotFoundError, ValueError):
                held.extend(rel(p) for p in files)
                continue
            receipt_sha = sha(receipt)
            for p in files:
                if not p.is_file() or p.is_symlink() or rel(p) in tracked:
                    held.append(rel(p)); continue
                rows = [r for r in report.get('files', [])
                        if 'noop-' + Path(r.get('path', '')).name == p.name]
                digest = sha(p)
                if (len(rows) != 1 or rows[0].get('noOpTreeEquality') != 'passed'
                        or rows[0].get('unselectedRawBytesEquality') != 'passed'
                        or rows[0].get('noOpSha256') != digest):
                    held.append(rel(p)); continue
                guarded(p)
                deleted.append(dict(path=rel(p), sha256=digest, identity=identity(p),
                                    reason='verified-disposable-round-trip',
                                    receipt=rel(receipt), receiptSha256=receipt_sha))
    for p in sorted((ROOT / 'tools').rglob('*.pyc')):
        if '__pycache__' in p.parts and rel(p) not in tracked and not p.is_symlink():
            guarded(p)
            deleted.append(dict(path=rel(p), sha256=sha(p), identity=identity(p),
                                reason='untracked-regenerable-python-bytecode'))
    result = dict(schemaVersion=1, createdAt=time.time(), root=str(ROOT),
                  freeBefore=shutil.disk_usage(ROOT).free, deletions=deleted,
                  heldUnverified=held,
                  selectedBytes=sum(r['identity'][2] for r in deleted))
    save('deletion-plan.json', result)
    print(json.dumps({k: result[k] for k in ('selectedBytes', 'freeBefore', 'heldUnverified')}), flush=True)
    print('deletion files', len(deleted), flush=True)


def apply():
    no_workers()
    plan = json.loads((HERE / 'deletion-plan.json').read_text())
    assert plan['root'] == str(ROOT)
    tracked = set(subprocess.check_output(['git', 'ls-files', '-z'], cwd=ROOT).decode().split('\0'))
    # Validate the whole selection before the first unlink, then recheck each.
    for r in plan['deletions']:
        p = ROOT / r['path']; guarded(p)
        assert r['path'] not in tracked and identity(p) == r['identity'] and sha(p) == r['sha256']
        if 'receipt' in r:
            assert sha(ROOT / r['receipt']) == r['receiptSha256']
    with (HERE / 'deletions.jsonl').open('x') as journal:
        for r in plan['deletions']:
            p = ROOT / r['path']; guarded(p)
            assert identity(p) == r['identity'] and sha(p) == r['sha256']
            p.unlink()
            journal.write(json.dumps(r) + '\n'); journal.flush()
    save('deletion-result.json', dict(files=len(plan['deletions']),
                                    bytes=plan['selectedBytes'], freeAfter=shutil.disk_usage(ROOT).free))
    print((HERE / 'deletion-result.json').read_text(), flush=True)


def compact():
    no_workers()
    lib = ctypes.CDLL('/usr/lib/libSystem.B.dylib', use_errno=True)
    lib.clonefile.argtypes = [ctypes.c_char_p, ctypes.c_char_p, ctypes.c_int]
    lib.clonefile.restype = ctypes.c_int
    # CPython on macOS does not expose os.listxattr. Read Darwin's native API;
    # differing attributes are held rather than overwritten or discarded.
    lib.listxattr.argtypes = [ctypes.c_char_p, ctypes.c_void_p, ctypes.c_size_t, ctypes.c_int]
    lib.listxattr.restype = ctypes.c_ssize_t
    lib.getxattr.argtypes = [ctypes.c_char_p, ctypes.c_char_p, ctypes.c_void_p,
                            ctypes.c_size_t, ctypes.c_uint32, ctypes.c_int]
    lib.getxattr.restype = ctypes.c_ssize_t

    def xattrs(path):
        raw = os.fsencode(path)
        length = lib.listxattr(raw, None, 0, 0)
        if length < 0: raise OSError(ctypes.get_errno(), 'listxattr failed')
        buf = ctypes.create_string_buffer(length)
        assert lib.listxattr(raw, buf, length, 0) == length
        result = {}
        for name in filter(None, buf.raw.split(b'\0')):
            n = lib.getxattr(raw, name, None, 0, 0, 0)
            if n < 0: raise OSError(ctypes.get_errno(), 'getxattr failed')
            value = ctypes.create_string_buffer(n)
            assert lib.getxattr(raw, name, value, n, 0, 0) == n
            result[name] = value.raw
        return result
    # Positive control: same bytes, distinct inode, and a later write is isolated.
    a, b = HERE / '.cow-control-a', HERE / '.cow-control-b'
    assert not a.exists() and not b.exists()
    try:
        a.write_bytes(b'Forest copy-on-write control\n')
        assert lib.clonefile(os.fsencode(a), os.fsencode(b), 0) == 0
        assert a.stat().st_ino != b.stat().st_ino and sha(a) == sha(b)
        b.write_bytes(b'isolated change\n')
        assert a.read_bytes() == b'Forest copy-on-write control\n'
    finally:
        a.unlink(missing_ok=True); b.unlink(missing_ok=True)
    before = shutil.disk_usage(ROOT).free
    bysize = collections.defaultdict(list)
    for scope in SCOPES:
        for base, dirs, names in os.walk(ROOT / scope, followlinks=False):
            dirs[:] = [d for d in dirs if not (Path(base) / d).is_symlink()]
            for name in names:
                p = Path(base) / name
                if p.is_symlink(): continue
                s = p.stat()
                if stat.S_ISREG(s.st_mode) and s.st_size >= 1024**2 and not s.st_flags:
                    bysize[s.st_size].append(p)
    # Hash each inode once. Hash equality is required before replacing storage.
    hashes, candidates = {}, []
    for size, paths in bysize.items():
        if len(paths) < 2: continue
        for p in paths:
            s = p.stat(); key = (s.st_dev, s.st_ino)
            if key not in hashes:
                hashes[key] = sha(p)
            candidates.append((size, hashes[key], p, identity(p)))
    print('hashed distinct inodes', len(hashes), 'candidate paths', len(candidates), flush=True)
    groups = collections.defaultdict(list)
    for size, digest, p, pin in candidates:
        groups[(size, digest)].append((p, pin))
    count = total = 0
    with (HERE / 'compaction.jsonl').open('x') as journal:
        for (size, digest), paths in groups.items():
            if len(paths) < 2: continue
            paths.sort(key=lambda x: (not x[0].is_relative_to(ACCEPTED), len(str(x[0])), str(x[0])))
            anchor, anchor_pin = paths[0]
            for p, pin in paths[1:]:
                if p.is_relative_to(ACCEPTED) or pin[5] != 1 or pin[1] == anchor_pin[1]:
                    continue
                guarded(p)
                assert identity(p) == pin and identity(anchor) == anchor_pin
                assert sha(p) == sha(anchor) == digest
                attrs = xattrs(p)
                if attrs != xattrs(anchor):
                    continue
                tmp = p.with_name('.' + p.name + '.forest-cow-cleanup')
                assert not tmp.exists()
                try:
                    if lib.clonefile(os.fsencode(anchor), os.fsencode(tmp), 0) != 0:
                        raise OSError(ctypes.get_errno(), 'APFS clonefile failed', str(p))
                    shutil.copystat(p, tmp, follow_symlinks=False)
                    assert sha(tmp) == digest and tmp.stat().st_ino != anchor.stat().st_ino
                    assert xattrs(tmp) == attrs
                    assert (tmp.stat().st_uid, tmp.stat().st_gid) == (p.stat().st_uid, p.stat().st_gid)
                    assert identity(p) == pin and identity(anchor) == anchor_pin
                    assert tmp.stat().st_mode == pin[4] and tmp.stat().st_mtime_ns == pin[3]
                    os.replace(tmp, p)
                    assert sha(p) == digest
                    assert xattrs(p) == attrs
                    journal.write(json.dumps(dict(path=rel(p), anchor=rel(anchor),
                                                  sha256=digest, bytes=size,
                                                  independentCopyOnWrite=True)) + '\n')
                    journal.flush(); count += 1; total += size
                    if count % 100 == 0:
                        print('compacted', count, 'freeGiB', round(shutil.disk_usage(ROOT).free / 2**30, 3), flush=True)
                finally:
                    tmp.unlink(missing_ok=True)
    save('compaction-result.json', dict(files=count, logicalBytesRecloned=total,
                                       freeBefore=before, freeAfter=shutil.disk_usage(ROOT).free,
                                       note='Logical bytes are not reclaimed bytes; APFS snapshots and existing clones affect free-space deltas.'))
    print((HERE / 'compaction-result.json').read_text(), flush=True)


if __name__ == '__main__':
    assert Path.cwd().resolve() == ROOT
    {'plan': plan, 'apply': apply, 'compact': compact}[sys.argv[1]]()
