#!/usr/bin/env python3
"""Inspect the original notebook route in one isolated, versioned menu session.

No screenshots, chapter selection, trigger mutation or inventory opening.
Run a frozen copy in the probe directory; all later-read helpers live there too.
"""
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
import time

RUN = Path(sys.argv[1]).resolve()
SOURCE = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')
DATA = 'The Forest of Love_Data'
GAME = RUN / 'game'
EXE = GAME / 'The Forest of Love.exe'


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def write(name, value):
    (RUN / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def processes():
    paths = [str(EXE), 'Z:' + str(EXE).replace('/', '\\'),
             'Y:\\' + str(EXE.relative_to('/Users/antonkrutov')).replace('/', '\\')]
    return [line.strip() for line in subprocess.check_output(['ps', '-axo', 'pid,ppid,command'], text=True).splitlines()
            if any(path in line for path in paths)]


def command(value):
    result = subprocess.run([sys.executable, str(RUN / 'command.py'), str(RUN), value],
                            capture_output=True, text=True, timeout=25)
    assert result.returncode == 0, (value, result.stdout[-500:], result.stderr[-500:])


def main():
    assert RUN.parent == Path('/Users/antonkrutov/Desktop/Forest/localization/probes')
    assert Path(__file__).resolve().parent == RUN, 'Run the immutable snapshot'
    assert not (RUN / 'launch.json').exists() and not processes(), 'Reconcile any previous launch'
    assert not list(GAME.glob('tfol.*'))
    report = json.loads((RUN / 'build.json').read_text())
    assert len(report['files']) == 5 and report['saveIsolation']['companyName'] == 'VNRevivalQA'
    for row in report['files']:
        assert sha(GAME / DATA / row['path']) == row['probeSha256']
        assert sha(SOURCE / DATA / row['path']) == row['sourceSha256']
    owner = {str(p.relative_to(SOURCE)): sha(p) for p in SOURCE.glob('tfol.*') if p.is_file()}
    owner[DATA + '/Managed/Assembly-CSharp.dll'] = sha(SOURCE / DATA / 'Managed/Assembly-CSharp.dll')
    pins = json.loads((RUN / 'input-pins.json').read_text())
    assert len(pins) == 7 and all(sha(Path(p)) == h for p, h in pins.items())
    write('original-before.json', owner)
    args = ['/Applications/CrossOver.app/Contents/SharedSupport/CrossOver/bin/wine', '--bottle',
            '/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam', '--no-update', str(EXE),
            '-screen-fullscreen', '0', '-screen-width', '1280', '-screen-height', '720',
            '-logFile', str(RUN / 'player.log')]
    started = time.monotonic()
    success = False
    error = None
    quit_ok = False
    try:
        with (RUN / 'wine.log').open('wb') as log:
            child = subprocess.Popen(args, cwd=GAME, stdout=log, stderr=subprocess.STDOUT, start_new_session=True)
        write('launch.json', {'pid': child.pid, 'command': args,
                             'snapshots': {name: sha(RUN / name) for name in
                                           ['diagnose_notebook.py', 'command.py', 'build.json', 'bridge-build.json', 'input-pins.json']},
                             'scope': 'Menu-only original route diagnostics; zero screenshots or unlock actions'})
        deadline = time.monotonic() + 120
        while not (RUN / 'player.log').exists() or 'FOREST_PROBE_READY' not in (RUN / 'player.log').read_text(errors='replace'):
            assert time.monotonic() < deadline, 'Startup marker timeout'
            time.sleep(1)
        (RUN / 'actions.log').touch(exist_ok=True)
        command('show-menu')
        command('dump')
        state = json.loads((RUN / 'state.json').read_text())
        assert state['scene'] == 'StartMenu' and state['company'] == 'VNRevivalQA' and state['product'] == 'ForestRuRendererProbe'
        assert state['dataPath'].replace('\\', '/').endswith('/' + RUN.name + '/game/' + DATA)
        shutil.copy2(RUN / 'state.json', RUN / 'main-menu.json')
        command('dump-notebook')
        shutil.copy2(RUN / 'notebook-route.json', RUN / 'main-menu-notebook.json')
        command('menu StartScreenMainMenu OnClickStart')
        command('dump')
        state = json.loads((RUN / 'state.json').read_text())
        assert 'PlayMenu Canvas/PlayMenu' in state['components'], 'Original Play menu did not open'
        shutil.copy2(RUN / 'state.json', RUN / 'play-menu.json')
        command('dump-notebook')
        shutil.copy2(RUN / 'notebook-route.json', RUN / 'play-menu-notebook.json')
        command('menu PlayMenu OnClickBack')
        command('dump')
        assert 'StartScreenMainMenu Canvas/MainMenu' in json.loads((RUN / 'state.json').read_text())['components']
        success = True
    except BaseException as ex:
        error = repr(ex)
    finally:
        owned = processes()
        if owned and not (RUN / 'command.txt').exists():
            try:
                command('quit')
                quit_ok = True
            except Exception as ex:
                error = (error or '') + ' cleanup: ' + repr(ex)
        deadline = time.monotonic() + 30
        while processes() and time.monotonic() < deadline:
            time.sleep(.5)
        remaining = processes()
        managed = GAME / DATA / 'Managed'
        if not remaining:
            shutil.copy2(SOURCE / DATA / 'Managed/Assembly-CSharp.dll', managed / 'Assembly-CSharp.dll')
            (managed / 'ForestProbe.dll').unlink(missing_ok=True)
        unchanged = all(sha(SOURCE / p) == h for p, h in owner.items())
        unchanged = unchanged and all(sha(SOURCE / DATA / r['path']) == r['sourceSha256'] for r in report['files'])
        pins_ok = all(sha(Path(p)) == h for p, h in pins.items())
        restored = sha(managed / 'Assembly-CSharp.dll') == owner[DATA + '/Managed/Assembly-CSharp.dll']
        clean = not remaining and unchanged and pins_ok and restored and not (managed / 'ForestProbe.dll').exists()
        write('cleanup.json', {'verifiedTaskProcessRowsBeforeQuit': owned, 'remainingTaskProcessRows': remaining,
                               'quitAcknowledged': quit_ok, 'originalAssetsAndPlayerFilesUnchanged': unchanged,
                               'originalAssemblyRestoredInQACopy': restored, 'inspectionBridgeRemoved': not (managed / 'ForestProbe.dll').exists(),
                               'inputPinsUnchanged': pins_ok, 'candidateAssetHashesUnchanged': all(sha(GAME / DATA / r['path']) == r['probeSha256'] for r in report['files']),
                               'ownerSavePathUsed': False})
        write('runtime-result.json', {'result': 'passed' if success and clean else 'failed', 'error': error,
                                      'durationSeconds': round(time.monotonic() - started, 3), 'imagesCaptured': 0,
                                      'imagesOpened': 0, 'scope': 'Original main/play menu and notebook state diagnostics only',
                                      'inventoryRuntime': 'not-run', 'visual': 'not-run'})
    assert success and clean, error


if __name__ == '__main__':
    main()
