#!/usr/bin/env python3
"""Menu-only native keyboard preflight; never replay the intro on unproven input."""
import json
from pathlib import Path
import shutil
import subprocess
import sys
import time

import diagnose_newgame as shared


def release_observed(samples):
    keys = ['nativeLeft', 'asyncLeft', 'rewiredLeft', 'unityLeft']
    saw_down = any(row[key] == 'True' for row in samples for key in keys)
    return saw_down and len(samples) >= 2 and all(row[key] == 'False' for row in samples[-2:] for key in keys)


def wait_for_release(run, timeout=8):
    """Observe actual delivery/release rather than treating post completion as delivery."""
    deadline = time.monotonic() + timeout
    while True:
        shared.command('sample-keyboard-snapshot')
        samples = [shared.diagnostic_fields([row], 'keyboard')
                   for row in (run / 'keyboard-samples.txt').read_text().splitlines()]
        if release_observed(samples) or time.monotonic() >= deadline:
            return samples
        time.sleep(.25)


def main():
    run = Path(sys.argv[1]).resolve()
    assert Path(__file__).resolve().parent == run, 'Use the frozen candidate'
    assert run.parent == Path('/Users/antonkrutov/Desktop/Forest/localization/probes')
    shared.RUN, shared.GAME = run, run / 'game'
    shared.EXE = shared.GAME / 'The Forest of Love.exe'
    sha, write, command = shared.sha, shared.write, shared.command
    assert not (run / 'launch.json').exists() and not shared.processes()
    assert not list(shared.GAME.rglob('tfol.*'))
    frozen = json.loads((run / 'frozen-files.json').read_text())
    assert all(sha(run / p) == h for p, h in frozen.items())
    pins = json.loads((run / 'input-pins.json').read_text())
    assert len(pins) == 7 and all(sha(Path(p)) == h for p, h in pins.items())
    report = json.loads((run / 'build.json').read_text())
    assert len(report['files']) == 5 and report['saveIsolation']['companyName'] == 'VNRevivalQA'
    for row in report['files']:
        assert sha(shared.GAME / shared.DATA / row['path']) == row['probeSha256']
        assert sha(shared.SOURCE / shared.DATA / row['path']) == row['sourceSha256']
    owner = {str(p.relative_to(shared.SOURCE)): sha(p) for p in shared.SOURCE.rglob('tfol.*') if p.is_file()}
    owner[shared.DATA + '/Managed/Assembly-CSharp.dll'] = sha(shared.SOURCE / shared.DATA / 'Managed/Assembly-CSharp.dll')
    write('original-before.json', owner)
    args = ['/Applications/CrossOver.app/Contents/SharedSupport/CrossOver/bin/wine', '--bottle',
            '/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam', '--no-update', str(shared.EXE),
            '-screen-fullscreen', '0', '-screen-width', '1280', '-screen-height', '720',
            '-logFile', str(run / 'player.log')]
    error = None
    completed = False
    quit_ok = False
    policy_restored = False
    pulse_attempted = False
    task_down_posted = False
    sample_active = False
    release_verified = False
    started = time.monotonic()
    try:
        with (run / 'wine.log').open('wb') as log:
            child = subprocess.Popen(args, cwd=shared.GAME, stdout=log, stderr=subprocess.STDOUT, start_new_session=True)
        write('launch.json', {'pid': child.pid, 'command': args, 'scope': 'Main menu only, two process-targeted left pulses; no New, story or movement bypass',
                              'frozenManifestSha256': sha(run / 'frozen-files.json')})
        deadline = time.monotonic() + 180
        while not (run / 'player.log').exists() or 'FOREST_PROBE_READY' not in (run / 'player.log').read_text(errors='replace'):
            assert time.monotonic() < deadline, 'Startup marker timeout'
            time.sleep(1)
        (run / 'actions.log').touch(exist_ok=True)
        command('show-menu'); command('dump')
        state = shared.read_state()
        assert state['scene'] == 'StartMenu' and state['company'] == 'VNRevivalQA' and state['product'] == 'ForestRuRendererProbe'
        assert state['dataPath'].replace('\\', '/').endswith('/' + run.name + '/game/' + shared.DATA)
        shutil.copy2(run / 'state.json', run / 'main-menu.json')
        command('dump-travel')
        shutil.copy2(run / 'travel-route.json', run / 'main-menu-travel.json')
        target = subprocess.run([str(run / 'target_keyboard'), str(run), 'inspect'], capture_output=True, text=True, timeout=10)
        write('target-inspection.json', {'exitCode': target.returncode, 'stdout': target.stdout, 'stderr': target.stderr})
        assert target.returncode == 0, 'Native target inspection failed: ' + target.stderr
        identity = json.loads(target.stdout)
        assert identity['accessibilityTrusted'], 'No accessible process-targeted transport; no global fallback'
        trials = []
        for label, expected_policy in [('original-policy', 'True'), ('qa-background-policy', 'False')]:
            if expected_policy == 'False':
                command('qa-background-input')
            command('sample-keyboard-start')
            sample_active = True
            time.sleep(.3)
            # A prior trial's successful release never covers the next pulse.
            release_verified = False
            task_down_posted = False
            pulse_attempted = True
            pulse = subprocess.run([str(run / 'target_keyboard'), str(run), 'left', '600'], capture_output=True, text=True, timeout=10)
            task_down_posted = shared.posted_task_down(pulse.stdout, 'left', identity)
            samples = wait_for_release(run)
            command('sample-keyboard-stop')
            sample_active = False
            samples_path = run / (label + '-samples.txt')
            shutil.copy2(run / 'keyboard-samples.txt', samples_path)
            samples = [shared.diagnostic_fields([row], 'keyboard') for row in samples_path.read_text().splitlines()]
            assert samples and all(row['ignoreUnfocused'] == expected_policy for row in samples)
            trial = {'label': label, 'pulseExitCode': pulse.returncode, 'pulseStdout': pulse.stdout, 'pulseStderr': pulse.stderr,
                     'samples': len(samples), 'nativeDownSamples': sum(row['nativeLeft'] == 'True' for row in samples),
                     'asyncDownSamples': sum(row['asyncLeft'] == 'True' for row in samples),
                     'rewiredDownSamples': sum(row['rewiredLeft'] == 'True' for row in samples),
                     'unityDownSamples': sum(row['unityLeft'] == 'True' for row in samples),
                     'focusValues': sorted(set(row['focused'] for row in samples)),
                     'actionAxisValues': sorted(set(row['actionAxes'] for row in samples)),
                     'downThenTwoReleasedSamples': release_observed(samples),
                     'sampleFile': samples_path.name}
            trials.append(trial); write('input-trials.json', trials)
            assert pulse.returncode == 0, 'Process-targeted pulse failed; do not submit another unchanged pulse'
            release_verified = release_observed(samples)
            assert release_verified, 'Native pulse delivery/release not observed within bounded sampling; inspect transport before any new down pulse'
        command('restore-input-policy'); command('dump-travel')
        shutil.copy2(run / 'travel-route.json', run / 'restored-travel.json')
        policy_restored = 'ignoreUnfocused=True' in (run / 'restored-travel.json').read_text()
        assert policy_restored
        completed = True
    except BaseException as ex:
        error = repr(ex)
    finally:
        owned = shared.processes()
        if owned and not (run / 'command.txt').exists():
            if task_down_posted and not release_verified:
                try:
                    release = subprocess.run([str(run / 'target_keyboard'), str(run), 'release-left', str(identity['pid'])], capture_output=True, text=True, timeout=10)
                    write('failure-key-release.json', {'exitCode': release.returncode, 'stdout': release.stdout, 'stderr': release.stderr,
                                                      'boundary': 'Target-scoped up only; posted event is not proof of delivery'})
                    if not sample_active:
                        command('sample-keyboard-start'); sample_active = True
                    samples = wait_for_release(run, timeout=5)
                    # Recovery observes two up states; it need not create a down.
                    keys = ['nativeLeft', 'asyncLeft', 'rewiredLeft', 'unityLeft']
                    release_verified = len(samples) >= 2 and all(row[key] == 'False' for row in samples[-2:] for key in keys)
                    command('sample-keyboard-stop'); sample_active = False
                    shutil.copy2(run / 'keyboard-samples.txt', run / 'failure-release-samples.txt')
                except Exception as ex:
                    error = (error or '') + ' key release: ' + repr(ex)
            try:
                command('restore-input-policy'); command('dump-travel')
                policy_restored = 'ignoreUnfocused=True' in (run / 'travel-route.json').read_text()
                command('quit'); quit_ok = True
            except Exception as ex:
                error = (error or '') + ' cleanup: ' + repr(ex)
        deadline = time.monotonic() + 30
        while shared.processes() and time.monotonic() < deadline:
            time.sleep(.5)
        remaining = shared.processes()
        managed = shared.GAME / shared.DATA / 'Managed'
        if not remaining:
            shutil.copy2(shared.SOURCE / shared.DATA / 'Managed/Assembly-CSharp.dll', managed / 'Assembly-CSharp.dll')
            (managed / 'ForestProbe.dll').unlink(missing_ok=True)
        unchanged = all(sha(shared.SOURCE / p) == h for p, h in owner.items())
        unchanged = unchanged and all(sha(shared.SOURCE / shared.DATA / row['path']) == row['sourceSha256'] for row in report['files'])
        pins_ok = all(sha(Path(p)) == h for p, h in pins.items())
        restored = sha(managed / 'Assembly-CSharp.dll') == owner[shared.DATA + '/Managed/Assembly-CSharp.dll']
        assets_ok = all(sha(shared.GAME / shared.DATA / row['path']) == row['probeSha256'] for row in report['files'])
        # The two installed runtime DLL paths intentionally change during restore.
        skipped = {'game/' + shared.DATA + '/Managed/' + name for name in ['ForestProbe.dll', 'Assembly-CSharp.dll']}
        frozen_ok = all(sha(run / p) == h for p, h in frozen.items() if p not in skipped)
        clean = not remaining and unchanged and pins_ok and restored and assets_ok and frozen_ok and policy_restored and (not pulse_attempted or release_verified) and not (managed / 'ForestProbe.dll').exists()
        write('cleanup.json', {'verifiedTaskProcessRowsBeforeQuit': owned, 'remainingTaskProcessRows': remaining,
                              'quitAcknowledged': quit_ok, 'inputPolicyRestored': policy_restored,
                              'keyPulseAttempted': pulse_attempted, 'keyReleaseObservedBeforeQuit': release_verified if pulse_attempted else None,
                              'originalAssetsAndPlayerFilesUnchanged': unchanged, 'inputPinsUnchanged': pins_ok,
                              'originalAssemblyRestoredInQACopy': restored, 'candidateAssetHashesUnchanged': assets_ok,
                              'frozenDependenciesUnchanged': frozen_ok, 'inspectionBridgeRemoved': not (managed / 'ForestProbe.dll').exists()})
        write('runtime-result.json', {'result': 'completed' if completed and clean else 'failed', 'error': error,
                                     'durationSeconds': round(time.monotonic() - started, 3), 'imagesCaptured': 0, 'imagesOpened': 0,
                                     'scope': 'Menu-only native-input boundary; never claims movement, doorway, tutorial or visual acceptance'})
    assert completed and clean, error


if __name__ == '__main__':
    main()
