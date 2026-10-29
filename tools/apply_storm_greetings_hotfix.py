#!/usr/bin/env python3
"""Offline one-file storm greeting projection; earlier preparation is explicit."""
import argparse
import fcntl
import json
from pathlib import Path
from apply_quest_notification_hotfix import PROJECT, running_game, sha, atomic_bytes

RELEASE = PROJECT / 'dist/Forest-Russian-Test-20261029/storm-greetings-hotfix'


def apply(candidate, release=RELEASE, *, processes=running_game, failpoint=None):
    candidate,release=Path(candidate).resolve(),Path(release).resolve()
    spec=json.loads((release/'manifest.json').read_text());assert spec['resource']=='sharedassets4.assets'
    data=candidate/'game/The Forest of Love_Data';resource=data/spec['resource'];payload=release/spec['resource']
    if processes(candidate):raise RuntimeError('Game is running; close it normally before starting again')
    if sha(candidate/'build.json')!=spec['baselineBuildSha256'] or sha(payload)!=spec['targetSha256']:raise ValueError('Unexpected storm baseline or payload')
    if any(sha(data/n)!=h for n,h in spec['requiredCompanions'].items()):raise ValueError('Storm requires completed earlier Russian repairs')
    with (release/'application.lock').open('a') as lock:
        fcntl.flock(lock,fcntl.LOCK_EX)
        if processes(candidate):raise RuntimeError('Game started before storm installation')
        if any(sha(data/n)!=h for n,h in spec['requiredCompanions'].items()):raise ValueError('Storm companion changed before installation')
        current=sha(resource)
        if current not in (spec['sourceSha256'],spec['targetSha256']):raise ValueError('Unknown storm resource')
        if current==spec['sourceSha256']:
            backup=release/'sharedassets4.before.assets'
            if backup.exists() and sha(backup)!=current:raise ValueError('Unexpected storm backup')
            if not backup.exists():atomic_bytes(backup,resource.read_bytes())
            if failpoint:failpoint('after-backup')
            if processes(candidate) or sha(resource)!=current:raise RuntimeError('Game/file state changed before storm replacement')
            atomic_bytes(resource,payload.read_bytes(),resource.stat().st_mode&0o777)
            if failpoint:failpoint('after-resource')
        if sha(resource)!=spec['targetSha256']:raise ValueError('Storm resource readback failed')
        receipt=dict(status='installed',candidate=str(candidate),effectiveSharedassets4Sha256=spec['targetSha256'],changedGameFiles=['The Forest of Love_Data/sharedassets4.assets'],savesSettingsProgressTouched=False,runtimeVisualAccepted=False,commitBoundary='Atomic one-resource replacement; prerequisite preparation and receipt are separate')
        atomic_bytes(release/'application.json',(json.dumps(receipt,indent=2)+'\n').encode());return receipt

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--candidate',type=Path,required=True);a=p.parse_args()
    if a.candidate.resolve()!=PROJECT/'localization/previews/ru-20261029-narrative42-01':raise SystemExit('Unsupported manual-test copy')
    try:apply(a.candidate)
    except (OSError,ValueError,RuntimeError) as e:raise SystemExit('Не удалось установить перевод штормовых реплик: '+str(e))
