#!/usr/bin/env python3
"""Offline two-resource journal update with hash-guarded forward recovery."""
import argparse
import fcntl
import json
from pathlib import Path
from apply_quest_notification_hotfix import PROJECT, atomic_bytes, running_game, sha

RELEASE = PROJECT / 'dist/Forest-Russian-Test-20261029/journal-compact-hotfix'


def apply(candidate, release=RELEASE, *, processes=running_game, failpoint=None):
    candidate, release = Path(candidate).resolve(), Path(release).resolve()
    spec = json.loads((release / 'manifest.json').read_text())
    files = spec['files']
    if set(files) != {'resources.assets', 'sharedassets2.assets'}:
        raise ValueError('Exact two journal resources required')
    data = candidate / 'game/The Forest of Love_Data'
    if sha(candidate / 'build.json') != spec['baselineBuildSha256']:
        raise ValueError('Unexpected journal baseline build')
    if sha(data / 'Managed/Assembly-CSharp.dll') != spec['requiredAssemblySha256']:
        raise ValueError('Unexpected managed code')
    for name, hashes in files.items():
        if sha(release / name) != hashes['after']:
            raise ValueError('Journal payload hash mismatch: ' + name)
    if processes(candidate):
        raise RuntimeError('Game is running; close it normally before starting again')
    # This superseding launcher owns the stage order. Do not rerun the older
    # tutorial validator against a valid later journal version of sharedassets2.
    if sha(data / 'sharedassets2.assets') == spec.get('preTutorialSharedassets2Sha256'):
        if sha(data / 'resources.assets') != files['resources.assets']['before']:
            raise ValueError('Unexpected pre-tutorial journal state')
        from apply_tutorial_notification_hotfix import apply as prerequisite
        prerequisite(candidate)
    with (release / 'application.lock').open('a') as lock:
        fcntl.flock(lock, fcntl.LOCK_EX)
        if processes(candidate):
            raise RuntimeError('Game started before journal installation')
        initial = {name: sha(data / name) for name in files}
        for name, hashes in files.items():
            if initial[name] not in (hashes['before'], hashes['after']):
                raise ValueError('Unknown journal resource: ' + name)
        # Validate/create both backups before the first game-resource write.
        for name, hashes in files.items():
            backup = release / (name + '.before')
            if backup.exists() and sha(backup) != hashes['before']:
                raise ValueError('Unexpected journal backup: ' + name)
            if initial[name] == hashes['before'] and not backup.exists():
                atomic_bytes(backup, (data / name).read_bytes())
            if any(initial[n] != files[n]['after'] for n in files) and initial[name] == hashes['after'] and not backup.exists():
                raise ValueError('Partial journal update requires verified original backup: ' + name)
        if failpoint:
            failpoint('after-backups')
        for name, hashes in files.items():
            if processes(candidate) or sha(data / name) != initial[name]:
                raise RuntimeError('Game/file state changed during journal installation')
            if initial[name] != hashes['after']:
                atomic_bytes(data / name, (release / name).read_bytes(), (data / name).stat().st_mode & 0o777)
            if failpoint:
                failpoint('after-' + name)
        if {name: sha(data / name) for name in files} != {name: h['after'] for name, h in files.items()}:
            raise ValueError('Journal installed readback failed')
        result = dict(status='installed', candidate=str(candidate),
                      effectiveFiles={name: h['after'] for name, h in files.items()},
                      baselineBuildSha256=spec['baselineBuildSha256'],
                      savesSettingsProgressTouched=False, runtimeVisualAccepted=False,
                      commitBoundary='Two sequential atomic file replacements; launcher blocks game until both verify. Interrupted known states recover forward; receipt is separate.')
        atomic_bytes(release / 'application.json', (json.dumps(result, indent=2) + '\n').encode())
        return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--candidate', type=Path, required=True)
    args = parser.parse_args()
    if args.candidate.resolve() != PROJECT / 'localization/previews/ru-20261029-narrative42-01':
        raise SystemExit('Unsupported manual-test copy')
    try:
        apply(args.candidate)
    except (OSError, ValueError, RuntimeError) as error:
        raise SystemExit('Не удалось установить исправление журнала: ' + str(error))
