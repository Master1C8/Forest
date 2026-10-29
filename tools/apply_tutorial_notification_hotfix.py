#!/usr/bin/env python3
"""Offline single-resource overlay; original artwork, code and saves are protected."""
import argparse
import fcntl
import json
from pathlib import Path
from apply_quest_notification_hotfix import PROJECT, atomic_bytes, running_game, sha

RELEASE = PROJECT / 'dist/Forest-Russian-Test-20261029/tutorial-notification-hotfix'


def apply(candidate, release=RELEASE, *, processes=running_game, failpoint=None):
    candidate, release = Path(candidate).resolve(), Path(release).resolve()
    spec = json.loads((release / 'manifest.json').read_text())
    assert spec['resource'] == 'sharedassets2.assets'
    data = candidate / 'game/The Forest of Love_Data'
    resource = data / spec['resource']
    payload = release / spec['resource']
    if sha(candidate / 'build.json') != spec['baselineBuildSha256']:
        raise ValueError('Unexpected baseline build')
    if sha(data / 'Managed/Assembly-CSharp.dll') != spec['requiredAssemblySha256']:
        raise ValueError('Expected Russian quest code hotfix first')
    if sha(payload) != spec['targetSha256']:
        raise ValueError('Tutorial payload hash mismatch')
    if processes(candidate):
        raise RuntimeError('Game is running; close it normally before starting again')
    with (release / 'application.lock').open('a') as lock:
        fcntl.flock(lock, fcntl.LOCK_EX)
        if processes(candidate):
            raise RuntimeError('Game started before installation')
        current = sha(resource)
        if current not in (spec['sourceSha256'], spec['targetSha256']):
            raise ValueError('Unknown game resource; nothing replaced')
        backup = release / 'sharedassets2.before.assets'
        if current == spec['sourceSha256']:
            if backup.exists() and sha(backup) != current:
                raise ValueError('Unexpected existing backup')
            if not backup.exists():
                atomic_bytes(backup, resource.read_bytes())
            if failpoint:
                failpoint('after-backup')
            raw = payload.read_bytes()
            if processes(candidate) or sha(resource) != current:
                raise RuntimeError('Game/file state changed before replacement')
            atomic_bytes(resource, raw, resource.stat().st_mode & 0o777)
            if failpoint:
                failpoint('after-resource')
        if sha(resource) != spec['targetSha256']:
            raise ValueError('Resource readback failed')
        result = dict(status='installed', candidate=str(candidate), resource=spec['resource'],
                      effectiveResourceSha256=spec['targetSha256'],
                      baselineBuildSha256=spec['baselineBuildSha256'],
                      changedGameFiles=['The Forest of Love_Data/sharedassets2.assets'],
                      savesSettingsProgressTouched=False, runtimeVisualAccepted=False,
                      commitBoundary='Atomic resource replacement; separate receipt recovered on retry')
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
        raise SystemExit('Не удалось установить исправление обучающих окон: ' + str(error))
