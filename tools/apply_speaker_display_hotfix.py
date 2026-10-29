#!/usr/bin/env python3
"""Prepare existing Russian resource overlays, then the portrait display DLL."""
import argparse
import json
from pathlib import Path
from apply_quest_notification_hotfix import PROJECT, running_game, sha, apply as apply_dll, RELEASE as QUEST_RELEASE
from apply_dates_titleflow_hotfix import apply as apply_resources

RELEASE = PROJECT / 'dist/Forest-Russian-Test-20261029/speaker-display-hotfix'


def apply(candidate, release=RELEASE, *, processes=running_game, failpoint=None,
          quest_previous=None, resources_previous=None):
    candidate, release = Path(candidate).resolve(), Path(release).resolve()
    spec = json.loads((release / 'manifest.json').read_text())
    data = candidate / 'game/The Forest of Love_Data'
    if processes(candidate):
        raise RuntimeError('Game is running; close it normally before starting again')
    if sha(candidate / 'build.json') != spec['baselineBuildSha256'] or sha(release / 'Assembly-CSharp.dll') != spec['targetSha256']:
        raise ValueError('Unexpected speaker baseline or payload')
    current = sha(data / 'Managed/Assembly-CSharp.dll')
    if current == spec['targetSha256']:
        # A final later DLL must never reach an older installer that accepts94b5 only.
        if any(sha(data / n) != expected for n, expected in spec['requiredResources'].items()):
            raise ValueError('Final speaker assembly has incompatible resources')
    else:
        if current not in (spec['sourceSha256'], spec['earliestQuestAssemblySha256']):
            raise ValueError('Unknown assembly before speaker preparation')
        if quest_previous is None:
            apply_dll(candidate, QUEST_RELEASE, processes=processes)
        else:
            quest_previous(candidate, processes=processes)
        (resources_previous or apply_resources)(candidate, processes=processes)
        if sha(data / 'Managed/Assembly-CSharp.dll') != spec['sourceSha256'] or any(sha(data / n) != expected for n, expected in spec['requiredResources'].items()):
            raise ValueError('Speaker preparation postcondition failed')
        if failpoint:
            failpoint('after-resources')
    return apply_dll(candidate, release, processes=processes, failpoint=failpoint)


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--candidate', type=Path, required=True)
    a = p.parse_args()
    if a.candidate.resolve() != PROJECT / 'localization/previews/ru-20261029-narrative42-01':
        raise SystemExit('Unsupported manual-test copy')
    try:
        apply(a.candidate)
    except (OSError, ValueError, RuntimeError) as error:
        raise SystemExit('Не удалось установить перевод подписей персонажей: ' + str(error))
