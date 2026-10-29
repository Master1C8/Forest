#!/usr/bin/env python3
"""Prepare earlier owner repairs, then apply the complete Lantern tutorial."""
import argparse
import json
from pathlib import Path
from apply_quest_notification_hotfix import PROJECT, running_game, sha
from apply_adventures_hotfix import apply as prepare_previous
from apply_tutorial_notification_hotfix import apply as write_resource

RELEASE=PROJECT/'dist/Forest-Russian-Test-20261029/lantern-hotfix'


def apply(candidate,release=RELEASE,*,processes=running_game,failpoint=None,prepare=prepare_previous):
    candidate,release=Path(candidate).resolve(),Path(release).resolve();spec=json.loads((release/'manifest.json').read_text());data=candidate/'game/The Forest of Love_Data'
    if processes(candidate):raise RuntimeError('Game is running; close it normally before starting again')
    if sha(candidate/'build.json')!=spec['baselineBuildSha256'] or sha(release/'sharedassets2.assets')!=spec['targetSha256']:raise ValueError('Unexpected Lantern baseline or payload')
    if sha(data/'sharedassets2.assets')!=spec['targetSha256']:prepare(candidate,processes=processes)
    if any(sha(data/n)!=h for n,h in spec['requiredCompanions'].items()):raise ValueError('Incompatible Lantern companions')
    return write_resource(candidate,release,processes=processes,failpoint=failpoint)

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--candidate',type=Path,required=True);a=p.parse_args()
    if a.candidate.resolve()!=PROJECT/'localization/previews/ru-20261029-narrative42-01':raise SystemExit('Unsupported manual-test copy')
    try:apply(a.candidate)
    except (OSError,ValueError,RuntimeError) as e:raise SystemExit('Lantern tutorial preparation failed: '+str(e))
