#!/usr/bin/env python3
"""Apply one hash-guarded DLL overlay offline; never write saves or live game files."""
import argparse
import contextlib
import fcntl
import hashlib
import json
import os
from pathlib import Path
import subprocess
import tempfile

PROJECT = Path('/Users/antonkrutov/Desktop/Forest')
RELEASE = PROJECT / 'dist/Forest-Russian-Test-20261029/quest-notification-hotfix'


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def running_game(candidate):
    exe = str(candidate.resolve() / 'game/The Forest of Love.exe')
    variants = [exe, 'Z:' + exe.replace('/', '\\'),
                'Y:' + exe.replace('/Users/antonkrutov', '', 1).replace('/', '\\')]
    # Also reject Wine wrappers still starting this exact executable, before its
    # native process appears. Never terminate any process.
    return [line.strip() for line in subprocess.check_output(
        ['ps', '-axo', 'pid=,command='], text=True).splitlines()
        if any(value in line for value in variants)]


def atomic_bytes(path, data, mode=0o644):
    fd, temporary = tempfile.mkstemp(prefix='.' + path.name + '.', dir=path.parent)
    try:
        with os.fdopen(fd, 'wb') as stream:
            stream.write(data)
            stream.flush()
            os.fsync(stream.fileno())
        os.chmod(temporary, mode)
        os.replace(temporary, path)
    finally:
        with contextlib.suppress(FileNotFoundError):
            os.unlink(temporary)


def apply(candidate, release, *, processes=running_game, failpoint=None):
    """DLL replace is atomic. Receipt is separate and recovered on unchanged retry."""
    candidate, release = Path(candidate).resolve(), Path(release).resolve()
    spec = json.loads((release / 'manifest.json').read_text())
    dll = candidate / 'game/The Forest of Love_Data/Managed/Assembly-CSharp.dll'
    if sha(candidate / 'build.json') != spec['baselineBuildSha256']:
        raise ValueError('Unexpected baseline build')
    if sha(release / 'Assembly-CSharp.dll') != spec['targetSha256']:
        raise ValueError('Hotfix payload hash mismatch')
    if processes(candidate):
        raise RuntimeError('Game is running; close it normally before starting again')
    # A lock serializes cooperating launcher installations; it is not a game lock.
    with (release / 'application.lock').open('a') as lock:
        fcntl.flock(lock, fcntl.LOCK_EX)
        if processes(candidate):
            raise RuntimeError('Game started before installation')
        current = sha(dll)
        if current not in (spec['sourceSha256'], spec['targetSha256']):
            raise ValueError('Unknown game assembly; nothing replaced')
        backup = release / 'Assembly-CSharp.before.dll'
        if current == spec['sourceSha256']:
            if backup.exists() and sha(backup) != current:
                raise ValueError('Unexpected existing backup')
            if not backup.exists():
                atomic_bytes(backup, dll.read_bytes())
            if failpoint:
                failpoint('after-backup')
            payload = (release / 'Assembly-CSharp.dll').read_bytes()
            # Recheck both live boundary and file after preparation, immediately
            # before replacing the one permitted code file.
            if processes(candidate) or sha(dll) != current:
                raise RuntimeError('Game/file state changed before replacement')
            atomic_bytes(dll, payload, dll.stat().st_mode & 0o777)
            if failpoint:
                failpoint('after-dll')
        if sha(dll) != spec['targetSha256']:
            raise ValueError('Installed payload readback failed')
        result = dict(status='installed', candidate=str(candidate),
                      baselineBuildSha256=spec['baselineBuildSha256'],
                      effectiveAssemblySha256=spec['targetSha256'],
                      sourceAssemblySha256=spec['sourceSha256'],
                      changedGameFiles=['The Forest of Love_Data/Managed/Assembly-CSharp.dll'],
                      savesSettingsProgressTouched=False,
                      commitBoundary='Atomic DLL replacement; separate receipt recovered on retry',
                      runtimeVisualAcceptance=False)
        atomic_bytes(release / 'application.json', (json.dumps(result, indent=2) + '\n').encode())
        return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--candidate', type=Path, required=True)
    args = parser.parse_args()
    if args.candidate.resolve() != PROJECT / 'localization/previews/ru-20261029-narrative42-01':
        raise SystemExit('Unsupported manual-test copy')
    try:
        apply(args.candidate, RELEASE)
    except (ValueError, RuntimeError, OSError) as error:
        raise SystemExit('Не удалось установить исправление заданий: ' + str(error))
