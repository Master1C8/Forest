#!/usr/bin/env python3
"""Exercise the real pending resource->speaker DLL sequence on private fixtures."""
import argparse
import json
from pathlib import Path
import shutil
import tempfile
from apply_speaker_display_hotfix import apply, RELEASE
from apply_quest_notification_hotfix import sha, apply as quest_apply, RELEASE as QUEST_RELEASE
from apply_dates_titleflow_hotfix import apply as dates_apply, RELEASE as DATES_RELEASE


def check(owner):
    owner = Path(owner).resolve()
    original = owner / 'game/The Forest of Love_Data'
    spec = json.loads((RELEASE / 'manifest.json').read_text())
    assert sha(original / 'Managed/Assembly-CSharp.dll') == spec['sourceSha256']
    assert sha(original / 'sharedassets2.assets') == json.loads((DATES_RELEASE / 'manifest.json').read_text())['sourceSha256']
    results = []
    with tempfile.TemporaryDirectory(prefix='speaker-display-install-', dir=owner.parents[2] / 'outputs') as temporary:
        for scenario in ['before', 'after', 'after-resources', 'after-dll', 'running', 'unknown-code', 'bad-companion', 'bad-payload']:
            root = Path(temporary) / scenario
            data = root / 'candidate/game/The Forest of Love_Data'
            (data / 'Managed').mkdir(parents=True)
            candidate = root / 'candidate'
            shutil.copy2(owner / 'build.json', candidate / 'build.json')
            shutil.copy2(original / 'Managed/Assembly-CSharp.dll', data / 'Managed/Assembly-CSharp.dll')
            shutil.copy2(original / 'sharedassets2.assets', data / 'sharedassets2.assets')
            for name in ['resources.assets', 'sharedassets0.assets']:
                (data / name).symlink_to(original / name)
            for name in ['tfol.savegame', 'tfol.settings']:
                (data / name).write_bytes(('private-owner-sentinel:' + name).encode())
            releases = {}
            for label, source, names in [('speaker', RELEASE, ['manifest.json', 'Assembly-CSharp.dll']), ('quest', QUEST_RELEASE, ['manifest.json', 'Assembly-CSharp.dll']), ('dates', DATES_RELEASE, ['manifest.json', 'sharedassets2.assets'])]:
                dest = root / label; dest.mkdir(); releases[label] = dest
                for name in names:
                    shutil.copy2(source / name, dest / name)
            if scenario in ['after', 'bad-companion']:
                shutil.copy2(RELEASE / 'Assembly-CSharp.dll', data / 'Managed/Assembly-CSharp.dll')
            if scenario == 'after':
                shutil.copy2(DATES_RELEASE / 'sharedassets2.assets', data / 'sharedassets2.assets')
            if scenario == 'unknown-code':
                (data / 'Managed/Assembly-CSharp.dll').write_bytes(b'unknown-code')
            if scenario == 'bad-payload':
                (releases['speaker'] / 'Assembly-CSharp.dll').write_bytes(b'wrong-payload')
            saved = {name: sha(data / name) for name in ['tfol.savegame', 'tfol.settings']}
            state = {name: (sha(data / name), (data / name).stat().st_ino, (data / name).stat().st_mtime_ns) for name in ['Managed/Assembly-CSharp.dll', 'sharedassets2.assets']}
            calls = []
            def quest(path, **kwargs):
                calls.append('quest'); return quest_apply(path, releases['quest'], **kwargs)
            def dates(path, **kwargs):
                calls.append('dates'); return dates_apply(path, releases['dates'], **kwargs)
            def failpoint(at):
                if at == scenario and scenario in ['after-resources', 'after-dll']:
                    raise RuntimeError('injected-' + scenario)
            processes = (lambda _: ['private-fixture-game']) if scenario == 'running' else (lambda _: [])
            arguments = dict(release=releases['speaker'], processes=processes, quest_previous=quest, resources_previous=dates)
            try:
                apply(candidate, failpoint=failpoint, **arguments)
            except RuntimeError as e:
                if scenario == 'running':
                    assert str(e).startswith('Game is running;')
                else:
                    assert str(e) == 'injected-' + scenario
                    assert sha(data / 'sharedassets2.assets') == spec['requiredResources']['sharedassets2.assets']
                    expected_code = spec['sourceSha256'] if scenario == 'after-resources' else spec['targetSha256']
                    assert sha(data / 'Managed/Assembly-CSharp.dll') == expected_code
                    assert not (releases['speaker'] / 'application.json').exists()
                    apply(candidate, **arguments)
            except ValueError as e:
                reasons = {'unknown-code': 'Unknown assembly before speaker preparation', 'bad-companion': 'Final speaker assembly has incompatible resources', 'bad-payload': 'Unexpected speaker baseline or payload'}
                assert str(e) == reasons[scenario]
            else:
                assert scenario in ['before', 'after']
            if scenario in ['running', 'unknown-code', 'bad-companion', 'bad-payload']:
                assert state == {n: (sha(data / n), (data / n).stat().st_ino, (data / n).stat().st_mtime_ns) for n in state}
                assert not calls
            else:
                assert sha(data / 'Managed/Assembly-CSharp.dll') == spec['targetSha256']
                assert sha(data / 'sharedassets2.assets') == spec['requiredResources']['sharedassets2.assets']
                count = len(calls)
                final = {n: (sha(data / n), (data / n).stat().st_ino, (data / n).stat().st_mtime_ns) for n in state}
                apply(candidate, **arguments)
                assert len(calls) == count and final == {n: (sha(data / n), (data / n).stat().st_ino, (data / n).stat().st_mtime_ns) for n in state}
            assert saved == {n: sha(data / n) for n in saved}
            results.append(dict(scenario=scenario, passed=True))
    return dict(cases=results, savedProgressSettingsSentinelsPreserved=True, realEarlierWritersAndActualPayloads=True, runtimeVisualAccepted=False, boundary='Private data-only candidates without executable. Real quest/date/speaker writers and final payloads; process lists mocked. Resources and DLL are individually atomic, separate receipts, no multi-file transaction; both interruption boundaries roll forward.')

if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--candidate', type=Path, required=True)
    a = p.parse_args()
    print(json.dumps(check(a.candidate), indent=2))
