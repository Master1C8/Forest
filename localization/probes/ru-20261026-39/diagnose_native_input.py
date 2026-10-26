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


def menu_idle(row):
    return (all(row.get(layer + 'MovementUp') == 'True' for layer in ['native', 'async', 'rewired', 'unity'])
            and row.get('nativeValid') == 'True'
            and all(row.get(key) == '0,0,0' for key in ['actionAxes', 'fullAxis']))


def menu_guard(samples, policy, focus, *, pulse=False, minimum=2):
    assert len(samples) >= minimum, 'Need two real menu samples before task DOWN'
    expected = dict(scene='StartMenu', gameplay='False', anyEvent='False', conversation='False',
                    actor='null', body='null', player='0:Player1', keyboardEnabled='True',
                    nativeValid='True', nativeKeyboard='True', unityInput='False',
                    rewiredReady='True', rewiredGlobalEnabled='True',
                    ignoreUnfocused=policy, rewiredFilter=policy, focused=focus)
    for row in samples:
        assert all(row.get(k) == v for k, v in expected.items()), 'Menu input/focus/policy guard changed: ' + str(row)
        assert row.get('rewiredFocusWatcher') in ['True', 'False'] and row.get('rewiredOtherWatcher') in ['True', 'False'], 'Missing actual Rewired watchers'
        if policy == 'False':
            assert row.get('rewiredInputAllowed') == row.get('rewiredKeyboardAllowed') == 'True', 'QA policy did not enable original keyboard eligibility'
        for layer in ['native', 'async', 'rewired', 'unity']:
            assert row.get(layer + 'MovementDown') in (['', 'LeftArrow'] if pulse else ['']), 'Unexplained movement producer; no next DOWN'
        for key in ['actionAxes', 'fullAxis']:
            assert row.get(key) in (['0,0,0', '-1,0,0'] if pulse else ['0,0,0']), 'Unexpected original menu axis'


def menu_ready(samples, policy, focus):
    menu_guard(samples, policy, focus)
    assert all(menu_idle(row) for row in samples), 'All eight keys and original axes must be idle before task DOWN'
    if policy == 'True':
        assert focus == 'True', 'Original filter with real focus=False; no task DOWN'
        assert all(row.get('rewiredKeyboardAllowed') == 'True' for row in samples), 'Original keyboard input disallowed; no task DOWN'


def delivered_to_consumer(samples):
    # Unity.Input is an observed unused layer: the shipped consumer uses Rewired.
    return any(row.get('nativeLeft') == row.get('rewiredLeft') == 'True'
               and row.get('actionAxes') == row.get('fullAxis') == '-1,0,0' for row in samples)


def observe_menu_idle(run, policy, focus=None, timeout=30):
    """Wait for produced frames, never infer frame count from a fixed sleep."""
    deadline = time.monotonic() + timeout
    while True:
        shared.command('sample-keyboard-snapshot')
        rows = [shared.diagnostic_fields([row], 'keyboard')
                for row in (run / 'keyboard-samples.txt').read_text().splitlines()]
        if rows:
            focus = rows[0]['focused'] if focus is None else focus
            assert focus in ['True', 'False'], 'No actual focus sample'
            menu_guard(rows, policy, focus, minimum=1)
            assert all(menu_idle(row) for row in rows), 'Pre-pulse eight-key idle failed; no task DOWN'
            if len(rows) >= 2:
                return rows, focus
        assert time.monotonic() < deadline, 'Two real idle menu frames not produced; no task DOWN'
        time.sleep(.25)


def wait_for_release(run, timeout=8, guard=None):
    """Observe actual delivery/release rather than treating post completion as delivery."""
    deadline = time.monotonic() + timeout
    while True:
        shared.command('sample-keyboard-snapshot')
        samples = [shared.diagnostic_fields([row], 'keyboard')
                   for row in (run / 'keyboard-samples.txt').read_text().splitlines()]
        if guard:
            guard(samples)
        if (release_observed(samples) and all(menu_idle(row) for row in samples[-2:])) or time.monotonic() >= deadline:
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
        write('launch.json', {'pid': child.pid, 'command': args, 'scope': 'Main menu only: passive original policy, one QA-background LEFT; no New, story or movement bypass',
                              'frozenManifestSha256': sha(run / 'frozen-files.json')})
        # Match the existing New-game runner.35 reached its real bridge only
        # after this menu runner's former180s boundary; no input had been sent.
        deadline = time.monotonic() + 300
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
        original_focus = None
        for label, expected_policy in [('original-policy', 'True'), ('qa-background-policy', 'False')]:
            if expected_policy == 'False':
                command('qa-background-input')
            command('sample-keyboard-start')
            sample_active = True
            idle, original_focus = observe_menu_idle(run, expected_policy, original_focus)
            shutil.copy2(run / 'keyboard-samples.txt', run / (label + '-idle-samples.txt'))
            menu_guard(idle, expected_policy, original_focus)
            assert all(menu_idle(row) for row in idle), 'Pre-pulse eight-key idle failed; no task DOWN'
            if expected_policy == 'True':
                command('sample-keyboard-stop'); sample_active = False
                trials.append({'label': label, 'pulseSubmitted': False, 'focus': original_focus,
                               'samples': len(idle), 'boundary': 'Passive original-policy control only; no original-policy DOWN submitted for either real focus value',
                               'sampleFile': label + '-idle-samples.txt'})
                write('input-trials.json', trials)
                continue
            menu_ready(idle, expected_policy, original_focus)
            # A prior trial's successful release never covers the next pulse.
            release_verified = False
            task_down_posted = False
            pulse_attempted = True
            pulse = subprocess.run([str(run / 'target_keyboard'), str(run), 'left', '600'], capture_output=True, text=True, timeout=10)
            task_down_posted = shared.posted_task_down(pulse.stdout, 'left', identity)
            write('qa-left-pulse.json', {'exitCode': pulse.returncode, 'stdout': pulse.stdout, 'stderr': pulse.stderr,
                                         'sameTargetDownReceipt': task_down_posted})
            samples = wait_for_release(run, guard=lambda rows: menu_guard(rows, expected_policy, original_focus, pulse=True))
            command('sample-keyboard-stop')
            sample_active = False
            samples_path = run / (label + '-samples.txt')
            shutil.copy2(run / 'keyboard-samples.txt', samples_path)
            samples = [shared.diagnostic_fields([row], 'keyboard') for row in samples_path.read_text().splitlines()]
            menu_guard(samples, expected_policy, original_focus, pulse=True)
            trial = {'label': label, 'pulseExitCode': pulse.returncode, 'pulseStdout': pulse.stdout, 'pulseStderr': pulse.stderr,
                     'samples': len(samples), 'nativeDownSamples': sum(row['nativeLeft'] == 'True' for row in samples),
                     'asyncDownSamples': sum(row['asyncLeft'] == 'True' for row in samples),
                     'rewiredDownSamples': sum(row['rewiredLeft'] == 'True' for row in samples),
                     'unityDownSamples': sum(row['unityLeft'] == 'True' for row in samples),
                     'focusValues': sorted(set(row['focused'] for row in samples)),
                     'actionAxisValues': sorted(set(row['actionAxes'] for row in samples)),
                     'downThenTwoReleasedSamples': release_observed(samples),
                     'allEightKeysAndAxesReleased': all(menu_idle(row) for row in samples[-2:]),
                     'deliveredToOriginalConsumer': delivered_to_consumer(samples),
                     'dependencyReplacement': 'Public QA-only ignoreInputWhenAppNotInFocus=False; real focus unchanged; original keyboard/maps/consumer',
                     'sampleFile': samples_path.name}
            trials.append(trial); write('input-trials.json', trials)
            assert pulse.returncode == 0, 'Process-targeted pulse failed; do not submit another unchanged pulse'
            release_verified = release_observed(samples) and all(menu_idle(row) for row in samples[-2:])
            assert release_verified, 'Native pulse delivery/release not observed within bounded sampling; inspect transport before any new down pulse'
            assert delivered_to_consumer(samples), 'Native LEFT did not reach original Rewired/action axes/FullAxis; no next pulse'
        command('restore-input-policy'); command('dump-travel')
        shutil.copy2(run / 'travel-route.json', run / 'restored-travel.json')
        policy_restored = 'ignoreUnfocused=True' in (run / 'restored-travel.json').read_text()
        assert policy_restored
        command('sample-keyboard-start'); sample_active = True
        observe_menu_idle(run, 'True', original_focus)
        command('sample-keyboard-stop'); sample_active = False
        shutil.copy2(run / 'keyboard-samples.txt', run / 'restored-policy-samples.txt')
        restored_rows = [shared.diagnostic_fields([row], 'keyboard')
                         for row in (run / 'restored-policy-samples.txt').read_text().splitlines()]
        menu_guard(restored_rows, 'True', original_focus)
        assert all(menu_idle(row) for row in restored_rows), 'Restored original policy is not idle'
        completed = True
    except BaseException as ex:
        error = repr(ex)
    finally:
        owned = shared.processes()
        if sample_active and (run / 'keyboard-samples.txt').exists():
            shutil.copy2(run / 'keyboard-samples.txt', run / 'failure-last-keyboard-snapshot.txt')
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
                    release_verified = len(samples) >= 2 and all(row[key] == 'False' for row in samples[-2:] for key in keys) and all(menu_idle(row) for row in samples[-2:])
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
