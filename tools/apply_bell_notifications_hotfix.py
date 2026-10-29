#!/usr/bin/env python3
"""Apply the next bell overlay through the existing guarded one-resource writer."""
import argparse
import json
from pathlib import Path
from apply_quest_notification_hotfix import PROJECT, running_game, sha
from apply_tutorial_notification_hotfix import apply as apply_resource

RELEASE = PROJECT / 'dist/Forest-Russian-Test-20261029/bell-notification-hotfix'


def apply(candidate, release=RELEASE, *, processes=running_game, failpoint=None):
    candidate, release = Path(candidate).resolve(), Path(release).resolve()
    spec = json.loads((release / 'manifest.json').read_text())
    data = candidate / 'game/The Forest of Love_Data'
    if processes(candidate):
        raise RuntimeError('Game is running; close it normally before starting again')
    current = sha(data / 'sharedassets2.assets')
    if current == spec['targetSha256']:
        if sha(data / 'resources.assets') != spec['requiredResourcesSha256']:
            raise ValueError('Later bell resource requires the compact journal data')
    elif current != spec['sourceSha256'] or sha(data / 'resources.assets') != spec['requiredResourcesSha256']:
        # Earlier recognized stages recover through their owning installer.
        # A valid later bell state never reaches the older journal-only check.
        from apply_journal_compact_hotfix import apply as prerequisite
        prerequisite(candidate, processes=processes)
    if sha(data / 'resources.assets') != spec['requiredResourcesSha256']:
        raise ValueError('Unexpected bell prerequisite data')
    return apply_resource(candidate, release, processes=processes, failpoint=failpoint)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--candidate', type=Path, required=True)
    args = parser.parse_args()
    if args.candidate.resolve() != PROJECT / 'localization/previews/ru-20261029-narrative42-01':
        raise SystemExit('Unsupported manual-test copy')
    try:
        apply(args.candidate)
    except (OSError, ValueError, RuntimeError) as error:
        raise SystemExit('Не удалось установить исправление колокольчиков: ' + str(error))
