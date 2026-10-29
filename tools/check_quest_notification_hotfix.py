#!/usr/bin/env python3
"""Exercise the install transaction and running-game guard on isolated code-only fixtures."""
import json
from pathlib import Path
import shutil
import tempfile
from apply_quest_notification_hotfix import apply, sha, RELEASE

SOURCE = Path('/Users/antonkrutov/Desktop/Forest/localization/previews/ru-20261029-narrative42-01')


def check():
    outcomes = []
    original = RELEASE / 'Assembly-CSharp.before.dll'
    if not original.exists():
        original = SOURCE / 'game/The Forest of Love_Data/Managed/Assembly-CSharp.dll'
    assert sha(original) == json.loads((RELEASE / 'manifest.json').read_text())['sourceSha256'], 'Exact pre-hotfix fixture required'
    with tempfile.TemporaryDirectory(prefix='quest-hotfix-', dir=SOURCE.parents[2] / 'outputs') as temporary:
        root = Path(temporary)
        for scenario in ['running', 'unknown-hash', 'bad-payload', 'after-backup', 'after-dll', 'game-started', 'normal']:
            candidate = root / scenario / 'candidate'
            release = root / scenario / 'release'
            dll = candidate / 'game/The Forest of Love_Data/Managed/Assembly-CSharp.dll'
            dll.parent.mkdir(parents=True)
            release.mkdir()
            shutil.copy2(SOURCE / 'build.json', candidate / 'build.json')
            shutil.copy2(original, dll)
            for name in ['manifest.json', 'Assembly-CSharp.dll']:
                shutil.copy2(RELEASE / name, release / name)
            # Sentinel files cover both game-folder saves and adjacent settings.
            protected = [candidate / 'game/tfol.save', candidate / 'game/tfol.settings', candidate / 'progress.bin']
            for n, path in enumerate(protected):
                path.write_bytes(b'owner-progress-do-not-touch\x00' + bytes([n]))
            fingerprints = {path: sha(path) for path in protected}
            before = sha(dll)
            if scenario == 'unknown-hash':
                dll.write_bytes(b'unknown-assembly')
                before = sha(dll)
            if scenario == 'bad-payload':
                (release / 'Assembly-CSharp.dll').write_bytes(b'wrong-payload')
            calls = 0

            def processes(_):
                nonlocal calls
                calls += 1
                return ['fixture-native-game'] if scenario == 'running' or (scenario == 'game-started' and calls >= 3) else []

            def failpoint(at):
                if at == scenario:
                    raise RuntimeError('injected-' + at)

            try:
                result = apply(candidate, release, processes=processes, failpoint=failpoint)
            except (RuntimeError, ValueError) as error:
                message = str(error)
                expected = {'running': 'Game is running', 'unknown-hash': 'Unknown game assembly',
                            'bad-payload': 'Hotfix payload hash mismatch', 'after-backup': 'injected-after-backup',
                            'after-dll': 'injected-after-dll', 'game-started': 'Game/file state changed'}[scenario]
                assert message.startswith(expected), (scenario, message)
                assert not (release / 'application.json').exists()
                if scenario != 'after-dll':
                    assert sha(dll) == before
                else:
                    assert sha(dll) == sha(release / 'Assembly-CSharp.dll')
            else:
                assert scenario == 'normal' and result['status'] == 'installed'
            if scenario in ('after-backup', 'after-dll', 'game-started', 'normal'):
                result = apply(candidate, release, processes=lambda _: [])
                assert result['effectiveAssemblySha256'] == sha(dll) == sha(release / 'Assembly-CSharp.dll')
                assert sha(release / 'Assembly-CSharp.before.dll') == before
                unchanged = (sha(dll), dll.stat().st_ino, dll.stat().st_mtime_ns)
                apply(candidate, release, processes=lambda _: [])
                assert unchanged == (sha(dll), dll.stat().st_ino, dll.stat().st_mtime_ns)
            assert fingerprints == {path: sha(path) for path in protected}
            outcomes.append(dict(scenario=scenario, passed=True))
    return dict(scenarios=outcomes, savesSettingsProgressSentinelsPreserved=True,
                scope='Isolated file install/receipt recovery boundaries; no game execution or real save files',
                commitBoundary='Atomic DLL replacement; receipt recovers after interrupted second write')


if __name__ == '__main__':
    print(json.dumps(check(), indent=2))
