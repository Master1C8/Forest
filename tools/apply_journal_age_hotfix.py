#!/usr/bin/env python3
"""Apply one journal age cell after the existing pending Russian repairs."""
import argparse
import fcntl
import json
from pathlib import Path
from apply_quest_notification_hotfix import PROJECT, running_game, sha, atomic_bytes
from apply_speaker_display_hotfix import apply as previous

RELEASE = PROJECT / 'dist/Forest-Russian-Test-20261029/journal-age-hotfix'


def apply(candidate, release=RELEASE, *, processes=running_game, failpoint=None, prepare=previous):
    candidate, release = Path(candidate).resolve(), Path(release).resolve()
    spec = json.loads((release / 'manifest.json').read_text()); data = candidate / 'game/The Forest of Love_Data'; resource = data / 'resources.assets'
    if processes(candidate): raise RuntimeError('Game is running; close it normally before starting again')
    if sha(candidate / 'build.json') != spec['baselineBuildSha256'] or sha(release / 'resources.assets') != spec['targetSha256']:
        raise ValueError('Unexpected age baseline or payload')
    if sha(resource) != spec['targetSha256']:
        prepare(candidate, processes=processes)
    if any(sha(data / name) != value for name, value in spec['requiredCompanions'].items()):
        raise ValueError('Incompatible journal age companions')
    with (release / 'application.lock').open('a') as lock:
        fcntl.flock(lock, fcntl.LOCK_EX)
        if processes(candidate): raise RuntimeError('Game started before age installation')
        if any(sha(data / name) != value for name, value in spec['requiredCompanions'].items()):
            raise ValueError('Age companions changed before installation')
        current = sha(resource)
        if current not in (spec['sourceSha256'], spec['targetSha256']): raise ValueError('Unknown journal age resource')
        if current == spec['sourceSha256']:
            backup = release / 'resources.before.assets'
            if backup.exists() and sha(backup) != current: raise ValueError('Unexpected age backup')
            if not backup.exists(): atomic_bytes(backup, resource.read_bytes())
            if failpoint: failpoint('after-backup')
            if processes(candidate) or sha(resource) != current: raise RuntimeError('Game/file state changed before age replacement')
            atomic_bytes(resource, (release / 'resources.assets').read_bytes(), resource.stat().st_mode & 0o777)
            if failpoint: failpoint('after-resource')
        if sha(resource) != spec['targetSha256']: raise ValueError('Age resource readback failed')
        receipt = dict(status='installed', candidate=str(candidate), effectiveResourcesSha256=spec['targetSha256'], changedGameFiles=['The Forest of Love_Data/resources.assets'], savesSettingsProgressTouched=False, runtimeVisualAccepted=False, commitBoundary='One atomic resource replacement; prerequisite writes and receipt separate, known partial states roll forward')
        atomic_bytes(release / 'application.json', (json.dumps(receipt, indent=2) + '\n').encode()); return receipt

if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__); p.add_argument('--candidate', type=Path, required=True); a = p.parse_args()
    if a.candidate.resolve() != PROJECT / 'localization/previews/ru-20261029-narrative42-01': raise SystemExit('Unsupported manual-test copy')
    try: apply(a.candidate)
    except (OSError, ValueError, RuntimeError) as e: raise SystemExit('Не удалось обновить возрастную подпись: ' + str(e))
