#!/usr/bin/env python3
"""Follow original New through source-bound intro dialogue to the first free gameplay state.

No screenshots, forced chapter selection, trigger mutation or inventory opening.
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
    paths = []
    for exe in [EXE, GAME / 'UnityCrashHandler64.exe']:
        paths.extend([str(exe), 'Z:' + str(exe).replace('/', '\\'),
                      'Y:\\' + str(exe.relative_to('/Users/antonkrutov')).replace('/', '\\')])
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
    assert not list(GAME.rglob('tfol.*'))
    report = json.loads((RUN / 'build.json').read_text())
    assert len(report['files']) == 5 and report['saveIsolation']['companyName'] == 'VNRevivalQA'
    for row in report['files']:
        assert sha(GAME / DATA / row['path']) == row['probeSha256']
        assert sha(SOURCE / DATA / row['path']) == row['sourceSha256']
    owner = {str(p.relative_to(SOURCE)): sha(p) for p in SOURCE.rglob('tfol.*') if p.is_file()}
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
                                           ['diagnose_newgame.py', 'command.py', 'build.json', 'bridge-build.json', 'input-pins.json', 'intro-graph.json']},
                             'scope': 'Original New and normal Continue through source-bound145 intro; no screenshots or forced eligibility'})
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
        assert 'Canvas/PlayMenu/Controls/New' in state['buttons']
        assert not any('/Continue' in b for b in state['buttons']), 'Do not overwrite an existing QA session'
        command('menu PlayMenu OnClickStart')
        graph = json.loads((RUN / 'intro-graph.json').read_text())
        assert graph['conversationId'] == 145
        entries = {e['id']: e for e in graph['entries']}
        scene_deadline = time.monotonic() + 240
        observations = []
        stable_free = 0
        seen_dialogue = set()
        previous = None
        observed_transitions = []
        while time.monotonic() < scene_deadline:
            command('dump')
            state = json.loads((RUN / 'state.json').read_text())
            command('dump-notebook')
            notebook = json.loads((RUN / 'notebook-route.json').read_text())
            guards = next(x for x in notebook['diagnostics'] if x.startswith('guards |'))
            key = (state['scene'], state['conversationActive'], state['conversationId'], state['entryId'])
            observations.append({'elapsed': round(time.monotonic() - started, 3),
                                 'scene': key[0], 'conversationActive': key[1],
                                 'conversationId': key[2], 'entryId': key[3], 'typing': state['typing'],
                                 'guards': guards})
            write('newgame-observations.json', observations)
            if state['conversationActive']:
                assert state['conversationId'] == 145, ('Stop at unexpected dialogue', key)
                entry = entries[state['entryId']]
                assert len(entry['outgoingLinks']) <= 1, 'Stop at original branching dialogue'
                if previous is not None and previous != state['entryId']:
                    links = entries[previous]['outgoingLinks']
                    if links:
                        assert (links[0]['destinationConversationID'], links[0]['destinationDialogueID']) == (145, state['entryId']), 'Unexpected graph transition'
                    observed_transitions.append([previous, state['entryId']])
                previous = state['entryId']
                seen_dialogue.add(state['entryId'])
                # Original method fast-forwards a typing line, then advances the
                # completed line on the next guarded iteration. No graph jumps.
                command('continue')
                stable_free = 0
            else:
                previous = None
                free = ('gameplay=True' in guards and 'anyEvent=False' in guards
                        and state['scene'] not in ('IntroForest', 'StartMenu')
                        and 249 in seen_dialogue)
                stable_free = stable_free + 1 if free else 0
                if stable_free >= 2:
                    break
            time.sleep(.3 if state['conversationActive'] else 1)
        else:
            raise AssertionError('No source-bound completed intro/free state within240 seconds')
        write('newgame-state.json', state)
        write('intro-progression.json', {'conversationId': 145, 'seenEntries': sorted(seen_dialogue),
              'observedTransitions': observed_transitions, 'finalScene': state['scene'], 'guards': guards,
              'inputBoundary': 'Original Continue/FastForwardTextOrAdvanceDialogue on active source-bound145 entries; no OS keyboard/controller delivery or forced story state'})
        shutil.copy2(RUN / 'notebook-route.json', RUN / 'newgame-notebook.json')
        print('Original intro completed in', state['scene'], guards, flush=True)
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
                                      'imagesOpened': 0, 'scope': 'Original New and source-bound145 intro to first free gameplay state',
                                      'inventoryRuntime': 'not-run', 'visual': 'not-run'})
    assert success and clean, error


if __name__ == '__main__':
    main()
