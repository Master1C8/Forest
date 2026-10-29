#!/usr/bin/env python3
"""Test installer guards/recovery on synthetic byte fixtures, without a game."""
import hashlib
import json
from pathlib import Path
import tempfile
from apply_tutorial_notification_hotfix import apply
from apply_quest_notification_hotfix import sha


def check():
    outcomes = []
    root = Path('/Users/antonkrutov/Desktop/Forest/outputs')
    with tempfile.TemporaryDirectory(prefix='tutorial-install-', dir=root) as temporary:
        for scenario in ['running', 'unknown-resource', 'bad-payload', 'after-backup', 'after-resource', 'game-started', 'normal']:
            folder = Path(temporary) / scenario
            candidate, release = folder / 'candidate', folder / 'release'
            data = candidate / 'game/The Forest of Love_Data'
            (data / 'Managed').mkdir(parents=True)
            release.mkdir()
            (candidate / 'build.json').write_bytes(b'fixture-baseline')
            (data / 'Managed/Assembly-CSharp.dll').write_bytes(b'fixture-reviewed-code')
            resource = data / 'sharedassets2.assets'
            resource.write_bytes(b'fixture-before-resource')
            (release / resource.name).write_bytes(b'fixture-after-resource')
            manifest = dict(resource=resource.name, sourceSha256=sha(resource),
                            targetSha256=sha(release / resource.name),
                            baselineBuildSha256=sha(candidate / 'build.json'),
                            requiredAssemblySha256=sha(data / 'Managed/Assembly-CSharp.dll'))
            (release / 'manifest.json').write_text(json.dumps(manifest))
            save = candidate / 'game/tfol.save'
            save.write_bytes(b'owner-progress-sentinel\x00\x01')
            original_save = sha(save)
            if scenario == 'unknown-resource':
                resource.write_bytes(b'unknown-resource')
            if scenario == 'bad-payload':
                (release / resource.name).write_bytes(b'corrupt-payload')
            before = sha(resource)
            calls = 0

            def processes(_):
                nonlocal calls
                calls += 1
                return ['fixture-game'] if scenario == 'running' or (scenario == 'game-started' and calls >= 3) else []

            def failpoint(at):
                if at == scenario:
                    raise RuntimeError('injected-' + at)

            try:
                apply(candidate, release, processes=processes, failpoint=failpoint)
            except (ValueError, RuntimeError) as error:
                expected = {'running': 'Game is running', 'unknown-resource': 'Unknown game resource',
                            'bad-payload': 'Tutorial payload hash mismatch', 'after-backup': 'injected-after-backup',
                            'after-resource': 'injected-after-resource', 'game-started': 'Game/file state changed'}[scenario]
                assert str(error).startswith(expected), (scenario, str(error))
                assert not (release / 'application.json').exists()
                assert sha(resource) == (manifest['targetSha256'] if scenario == 'after-resource' else before)
            else:
                assert scenario == 'normal'
            if scenario in ['after-backup', 'after-resource', 'game-started', 'normal']:
                result = apply(candidate, release, processes=lambda _: [])
                assert result['effectiveResourceSha256'] == sha(resource) == manifest['targetSha256']
                assert sha(release / 'sharedassets2.before.assets') == manifest['sourceSha256']
                unchanged = (resource.read_bytes(), resource.stat().st_ino, resource.stat().st_mtime_ns)
                apply(candidate, release, processes=lambda _: [])
                assert unchanged == (resource.read_bytes(), resource.stat().st_ino, resource.stat().st_mtime_ns)
            assert sha(save) == original_save
            assert sha(data / 'Managed/Assembly-CSharp.dll') == manifest['requiredAssemblySha256']
            outcomes.append(dict(scenario=scenario, passed=True))
    return dict(scenarios=outcomes, savesAndCodeSentinelsUnchanged=True,
                boundary='Synthetic byte fixtures exercise file guards, atomic replacement and receipt recovery; Unity semantics verified separately',
                actualGameRuntime='not-run')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
