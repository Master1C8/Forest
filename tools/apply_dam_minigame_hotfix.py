#!/usr/bin/env python3
"""Supersede storm sharedassets4 after existing earlier Russian preparation."""
import argparse
import json
from pathlib import Path
from apply_quest_notification_hotfix import PROJECT, running_game, sha
from apply_storm_greetings_hotfix import apply as write_resource, RELEASE as STORM_RELEASE

RELEASE=PROJECT/'dist/Forest-Russian-Test-20261029/dam-minigame-hotfix'


def apply(candidate,release=RELEASE,*,processes=running_game,failpoint=None,previous=None):
    candidate,release=Path(candidate).resolve(),Path(release).resolve();spec=json.loads((release/'manifest.json').read_text())
    if processes(candidate):raise RuntimeError('Game is running; close it normally before starting again')
    if sha(candidate/'build.json')!=spec['baselineBuildSha256'] or sha(release/'sharedassets4.assets')!=spec['targetSha256']:raise ValueError('Unexpected dam baseline or payload')
    resource=candidate/'game/The Forest of Love_Data/sharedassets4.assets';current=sha(resource)
    if current not in (spec['sourceSha256'],spec['targetSha256']):
        (previous or (lambda c,**k:write_resource(c,STORM_RELEASE,**k)))(candidate,processes=processes)
    return write_resource(candidate,release,processes=processes,failpoint=failpoint)

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--candidate',type=Path,required=True);a=p.parse_args()
    if a.candidate.resolve()!=PROJECT/'localization/previews/ru-20261029-narrative42-01':raise SystemExit('Unsupported manual-test copy')
    try:apply(a.candidate)
    except (OSError,ValueError,RuntimeError) as e:raise SystemExit('Не удалось установить перевод мини-игры на плотине: '+str(e))
