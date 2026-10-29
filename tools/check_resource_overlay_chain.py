#!/usr/bin/env python3
"""Verify superseding one-resource overlay stage ordering on synthetic files."""
import json
from pathlib import Path
import tempfile
from apply_bell_notifications_hotfix import apply_overlay
from apply_quest_notification_hotfix import sha


def check():
    results = []
    with tempfile.TemporaryDirectory(prefix='resource-chain-', dir='/Users/antonkrutov/Desktop/Forest/outputs') as tmp:
        for label in ['bell', 'scene', 'dates-titleflow']:
            for scenario in ['before', 'after', 'older', 'running', 'bad-companion', 'interrupted']:
                base = Path(tmp) / label / scenario
                candidate, release = base / 'candidate', base / 'release'
                data = candidate / 'game/The Forest of Love_Data'
                (data / 'Managed').mkdir(parents=True)
                release.mkdir()
                (candidate / 'build.json').write_bytes(b'baseline')
                (data / 'Managed/Assembly-CSharp.dll').write_bytes(b'code')
                (data / 'resources.assets').write_bytes(b'companion')
                resource = data / 'sharedassets2.assets'
                resource.write_bytes(b'before-stage')
                (release / resource.name).write_bytes(b'after-stage')
                saved = candidate / 'game/tfol.savegame'
                saved.write_bytes(b'owner-progress-sentinel')
                spec = dict(resource=resource.name, sourceSha256=sha(resource), targetSha256=sha(release / resource.name),
                            baselineBuildSha256=sha(candidate / 'build.json'),
                            requiredAssemblySha256=sha(data / 'Managed/Assembly-CSharp.dll'),
                            requiredResourcesSha256=sha(data / 'resources.assets'))
                (release / 'manifest.json').write_text(json.dumps(spec))
                if scenario in ['after', 'bad-companion']:
                    resource.write_bytes(b'after-stage')
                if scenario == 'older':
                    resource.write_bytes(b'earlier-stage')
                if scenario == 'bad-companion':
                    (data / 'resources.assets').write_bytes(b'incompatible')
                original = (sha(resource), resource.stat().st_ino, resource.stat().st_mtime_ns)
                previous_calls = []

                def previous(path, **kwargs):
                    previous_calls.append(str(path))
                    assert scenario == 'older' and resource.read_bytes() == b'earlier-stage'
                    resource.write_bytes(b'before-stage')

                def failpoint(at):
                    if scenario == 'interrupted' and at == 'after-resource':
                        raise RuntimeError('injected-after-resource')

                processes = lambda _: ['fixture-game'] if scenario == 'running' else []
                try:
                    result = apply_overlay(candidate, release, previous, processes=processes, failpoint=failpoint, label=label)
                except RuntimeError as error:
                    expected = 'Game is running;' if scenario == 'running' else 'injected-after-resource'
                    assert str(error).startswith(expected)
                    if scenario == 'running':
                        assert original == (sha(resource), resource.stat().st_ino, resource.stat().st_mtime_ns)
                    else:
                        assert sha(resource) == spec['targetSha256'] and not (release / 'application.json').exists()
                        apply_overlay(candidate, release, previous, processes=lambda _: [], label=label)
                except ValueError as error:
                    assert scenario == 'bad-companion'
                    assert str(error) == 'Later ' + label + ' resource requires the compact journal data'
                    assert original == (sha(resource), resource.stat().st_ino, resource.stat().st_mtime_ns)
                else:
                    assert scenario in ['before', 'after', 'older'] and result['status'] == 'installed'
                assert len(previous_calls) == (1 if scenario == 'older' else 0)
                if scenario not in ['running', 'bad-companion']:
                    before = (sha(resource), resource.stat().st_ino, resource.stat().st_mtime_ns)
                    apply_overlay(candidate, release, previous, processes=lambda _: [], label=label)
                    assert before == (sha(resource), resource.stat().st_ino, resource.stat().st_mtime_ns)
                assert saved.read_bytes() == b'owner-progress-sentinel'
                results.append(dict(stage=label, scenario=scenario, passed=True))
    return dict(cases=results, savedProgressSentinelPreserved=True,
                boundary='Real single-resource writer and stage dispatch on synthetic files. Prior-stage callback simulates only its declared transition; no Unity/game behavior tested.')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
