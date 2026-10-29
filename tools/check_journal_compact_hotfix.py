#!/usr/bin/env python3
"""Verify two-file install/recovery boundaries on synthetic byte fixtures."""
import json
from pathlib import Path
import tempfile
from apply_journal_compact_hotfix import apply
from apply_quest_notification_hotfix import sha


def check():
    outcomes = []
    with tempfile.TemporaryDirectory(prefix='journal-install-', dir='/Users/antonkrutov/Desktop/Forest/outputs') as temporary:
        cases = ['running', 'unknown-second', 'bad-payload', 'after-backups', 'after-resources.assets',
                 'after-sharedassets2.assets', 'game-started-between', 'partial-without-backup', 'normal']
        for scenario in cases:
            root = Path(temporary) / scenario
            candidate, release = root / 'candidate', root / 'release'
            data = candidate / 'game/The Forest of Love_Data'
            (data / 'Managed').mkdir(parents=True)
            release.mkdir()
            (candidate / 'build.json').write_bytes(b'fixture-build')
            (data / 'Managed/Assembly-CSharp.dll').write_bytes(b'fixture-code')
            saved = candidate / 'game/tfol.savegame'
            saved.write_bytes(b'owner-progress-sentinel\x00')
            progress_hash = sha(saved)
            files = {}
            for name in ['resources.assets', 'sharedassets2.assets']:
                (data / name).write_bytes(('before-' + name).encode())
                (release / name).write_bytes(('after-' + name).encode())
                files[name] = dict(before=sha(data / name), after=sha(release / name))
            spec = dict(files=files, baselineBuildSha256=sha(candidate / 'build.json'),
                        requiredAssemblySha256=sha(data / 'Managed/Assembly-CSharp.dll'))
            (release / 'manifest.json').write_text(json.dumps(spec))
            if scenario == 'unknown-second':
                (data / 'sharedassets2.assets').write_bytes(b'unknown-second-resource')
            if scenario == 'bad-payload':
                (release / 'sharedassets2.assets').write_bytes(b'corrupt-payload')
            if scenario == 'partial-without-backup':
                (data / 'resources.assets').write_bytes((release / 'resources.assets').read_bytes())
            initial = {n: sha(data / n) for n in files}
            calls = 0

            def processes(_):
                nonlocal calls
                calls += 1
                return ['fixture-game'] if scenario == 'running' or (scenario == 'game-started-between' and calls >= 4) else []

            def failpoint(at):
                if at == scenario:
                    raise RuntimeError('injected-' + at)

            try:
                apply(candidate, release, processes=processes, failpoint=failpoint)
            except (ValueError, RuntimeError) as error:
                expected = {'running': 'Game is running', 'unknown-second': 'Unknown journal resource: sharedassets2.assets',
                            'bad-payload': 'Journal payload hash mismatch: sharedassets2.assets',
                            'after-backups': 'injected-after-backups', 'after-resources.assets': 'injected-after-resources.assets',
                            'after-sharedassets2.assets': 'injected-after-sharedassets2.assets',
                            'game-started-between': 'Game/file state changed',
                            'partial-without-backup': 'Partial journal update requires verified original backup'}[scenario]
                assert str(error).startswith(expected), (scenario, str(error))
                assert not (release / 'application.json').exists()
                if scenario in ['running', 'unknown-second', 'bad-payload', 'after-backups', 'partial-without-backup']:
                    assert initial == {n: sha(data / n) for n in files}
                elif scenario in ['after-resources.assets', 'game-started-between']:
                    assert sha(data / 'resources.assets') == files['resources.assets']['after']
                    assert sha(data / 'sharedassets2.assets') == files['sharedassets2.assets']['before']
                else:
                    assert all(sha(data / n) == h['after'] for n, h in files.items())
            else:
                assert scenario == 'normal'
            if scenario in ['after-backups', 'after-resources.assets', 'after-sharedassets2.assets', 'game-started-between', 'normal']:
                result = apply(candidate, release, processes=lambda _: [])
                assert result['effectiveFiles'] == {n: h['after'] for n, h in files.items()}
                assert all(sha(release / (n + '.before')) == h['before'] for n, h in files.items())
                before = {n: (sha(data / n), (data / n).stat().st_ino, (data / n).stat().st_mtime_ns) for n in files}
                apply(candidate, release, processes=lambda _: [])
                assert before == {n: (sha(data / n), (data / n).stat().st_ino, (data / n).stat().st_mtime_ns) for n in files}
            assert sha(saved) == progress_hash
            assert sha(data / 'Managed/Assembly-CSharp.dll') == spec['requiredAssemblySha256']
            outcomes.append(dict(scenario=scenario, passed=True))
    return dict(scenarios=outcomes, ownerProgressSentinelPreserved=True,
                boundary='Synthetic files test hash guards, per-file atomic commits, partial-state recovery and launcher gating; not Unity rendering',
                atomicDirectoryTransaction=False)


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
