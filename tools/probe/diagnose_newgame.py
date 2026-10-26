#!/usr/bin/env python3
"""Follow original New through source-bound intro dialogue to the first free gameplay state.

Then inspect loaded original Player/doorway geometry without movement.
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

RUN = None
SOURCE = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')
DATA = 'The Forest of Love_Data'
GAME = None
EXE = None


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


def decode_state(state):
    assert 'responseRecords' in state and 'responseCount' in state, 'Bridge response serialization missing; hold before New'
    state['responses'] = [json.loads(row) for row in state['responseRecords']]
    assert len(state['responses']) == state['responseCount'], 'Incomplete bridge response readback'
    for response in state['responses']:
        assert {'path', 'text', 'targetPath', 'conversationId', 'entryId', 'visible', 'clickable'} <= response.keys(), 'Incomplete response row'
    return state


def read_state():
    return decode_state(json.loads((RUN / 'state.json').read_text()))


def intro_action(state, graph):
    """Choose only a source-bound original action; never infer response IDs from labels."""
    if not state['conversationActive']:
        return None
    if state['conversationId'] == graph['wrapper']['conversationId']:
        assert state['entryId'] in graph['wrapper']['bootstrapEntries'], 'Unexpected wrapper content'
        assert not state.get('conversationState'), 'Wrapper contains visible dialogue; investigate first'
        assert state['narrativeDbName'] == graph['wrapper']['narrativeDbName'], 'Wrapper belongs to another story'
        assert state['narrativeArcName'] in graph['wrapper']['allowedArcs'], 'Unexpected intro arc'
        return None
    assert state['conversationId'] == graph['conversationId'], 'Stop at unexpected dialogue'
    entry = next(e for e in graph['entries'] if e['id'] == state['entryId'])
    source_text = next(f['value'] for f in entry['fields'] if f['title'] == 'Dialogue Text')
    if not source_text:
        return None
    assert len(entry['outgoingLinks']) <= 1, 'Stop at original branching dialogue'
    responses = [r for r in state.get('responses', []) if r['visible'] and r['clickable']]
    if responses:
        assert len(responses) == 1 and len(entry['outgoingLinks']) == 1, 'Stop at response branch'
        response, link = responses[0], entry['outgoingLinks'][0]
        expected = (link['destinationConversationID'], link['destinationDialogueID'])
        assert (response['conversationId'], response['entryId']) == expected, 'Response differs from source successor'
        assert expected[0] == graph['conversationId'] and response['targetPath'], 'Unexpected response target'
        return 'response %s %s %s' % (state['entryId'], *expected)
    return 'continue'


def diagnostic_fields(rows, prefix):
    matches = [row for row in rows if row.split(' | ')[0] == prefix]
    assert len(matches) == 1, 'Missing or ambiguous diagnostic: ' + prefix
    return dict(part.split('=', 1) for part in matches[0].split(' | ')[1:])


def intro_complete(state, guards, seen_dialogue, diagnostics):
    """Original final content, end trigger and delayed cleanup must all finish."""
    if state['conversationActive'] or state['scene'] != 'BunnyHouse' or 249 not in seen_dialogue:
        return False
    fields = diagnostic_fields([guards], 'guards')
    if any(fields.get(k) != v for k, v in {'gameplay': 'True', 'anyEvent': 'False',
                                          'dustin': 'False', 'glitch': 'False'}.items()):
        return False
    cleanup = diagnostic_fields(diagnostics, 'introCleanup')
    if cleanup != {'remainingControllers': '0', 'bedControllers': '1', 'activeBedControllers': '1'}:
        return False
    triggers = [r for r in diagnostics if r.startswith('trigger | name=Cutscene_IntroBunnyHouse | ')]
    trigger = diagnostic_fields(triggers, 'trigger')
    return trigger.get('count', '').isdigit() and int(trigger['count']) > 0


def loaded_travel(state):
    """Require actual loaded objects, not serialized or menu-only geometry."""
    assert state['scene'] == 'BunnyHouse', 'Loaded travel requires BunnyHouse'
    rows = state['diagnostics']
    guards = diagnostic_fields(rows, 'travelGuards')
    assert all(guards.get(k) == v for k, v in {
        'gameplay': 'True', 'anyEvent': 'False', 'conversation': 'False', 'axis': '0,0,0'
    }.items()), 'Loaded travel requires guarded idle gameplay'
    player = diagnostic_fields(rows, 'travelPlayer')
    assert player['active'] == 'True' and player['enabled'] == 'True', 'Original Player inactive'
    doors = [r for r in rows if r.startswith('travelDoor | ') and
             any(part.startswith('path=') and part.endswith('/Doorways/DoorwayToCentralForest')
                 for part in r.split(' | ')[1:])]
    door = diagnostic_fields(doors, 'travelDoor')
    assert door['scene'] == 'BunnyHouse' and door['destination'] == 'CentralForest', 'Wrong loaded doorway'
    colliders = [dict(part.split('=', 1) for part in r.split(' | ')[1:])
                 for r in rows if r.startswith('travelCollider | ')]
    player_colliders = [c for c in colliders if c['owner'] == player['id']]
    door_colliders = [c for c in colliders if c['owner'] == door['id']]
    assert player_colliders and door_colliders, 'Missing loaded colliders'
    root_colliders = [c for c in player_colliders if c['path'] == player['path'] and c['tag'] == 'Player']
    assert len(root_colliders) == 1, 'Missing or ambiguous root Player-tag collider'
    root = root_colliders[0]
    bodies = [dict(part.split('=', 1) for part in r.split(' | ')[1:])
              for r in rows if r.startswith('travelBody | ')]
    attached = root['rigidbody'].rsplit('#', 1)
    assert len(attached) == 2, 'Root Player collider has no attached body identity'
    root_bodies = [b for b in bodies if b['id'] == attached[1]]
    assert len(root_bodies) == 1, 'Missing or ambiguous attached Player body'
    body = root_bodies[0]
    assert body['owner'] == player['id'] and body['path'] == player['path'], 'Body does not belong to original Player'
    pairs = [dict(part.split('=', 1) for part in r.split(' | ')[1:])
             for r in rows if r.startswith('travelPair | ')]
    assert pairs, 'Missing actual enabled collider-pair diagnostics'
    assert any(p['playerCollider'] == root['id'] and
               p['doorCollider'] in {c['id'] for c in door_colliders} for p in pairs), 'Missing root Player/door collider pair'
    return dict(guards=guards, player=player, body=body, door=door,
                bodies=bodies, playerColliders=player_colliders, doorColliders=door_colliders, pairs=pairs)


def main():
    global RUN, GAME, EXE
    RUN = Path(sys.argv[1]).resolve()
    GAME = RUN / 'game'
    EXE = GAME / 'The Forest of Love.exe'
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
    frozen = json.loads((RUN / 'frozen-files.json').read_text())
    assert frozen and all(sha(RUN / p) == h for p, h in frozen.items()), 'Frozen dependency mismatch before launch'
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
                                           ['diagnose_newgame.py', 'command.py', 'build.json', 'bridge-build.json', 'input-pins.json', 'intro-graph.json', 'frozen-files.json']},
                             'scope': 'Original New/source-bound145 intro and loaded idle Player/door geometry; no movement, screenshots or forced eligibility'})
        deadline = time.monotonic() + 300
        while not (RUN / 'player.log').exists() or 'FOREST_PROBE_READY' not in (RUN / 'player.log').read_text(errors='replace'):
            assert time.monotonic() < deadline, 'Startup marker timeout'
            time.sleep(1)
        (RUN / 'actions.log').touch(exist_ok=True)
        command('show-menu')
        command('dump')
        state = read_state()
        assert state['scene'] == 'StartMenu' and state['company'] == 'VNRevivalQA' and state['product'] == 'ForestRuRendererProbe'
        assert state['dataPath'].replace('\\', '/').endswith('/' + RUN.name + '/game/' + DATA)
        shutil.copy2(RUN / 'state.json', RUN / 'main-menu.json')
        command('dump-notebook')
        shutil.copy2(RUN / 'notebook-route.json', RUN / 'main-menu-notebook.json')
        command('dump-tutorial')
        shutil.copy2(RUN / 'tutorial-route.json', RUN / 'main-menu-tutorial.json')
        command('menu StartScreenMainMenu OnClickStart')
        command('dump')
        state = read_state()
        assert 'PlayMenu Canvas/PlayMenu' in state['components'], 'Original Play menu did not open'
        shutil.copy2(RUN / 'state.json', RUN / 'play-menu.json')
        command('dump-notebook')
        shutil.copy2(RUN / 'notebook-route.json', RUN / 'play-menu-notebook.json')
        assert 'Canvas/PlayMenu/Controls/New' in state['buttons']
        assert not any('/Continue' in b for b in state['buttons']), 'Do not overwrite an existing QA session'
        command('menu PlayMenu OnClickStart')
        graph = json.loads((RUN / 'intro-graph.json').read_text())
        assert graph['conversationId'] == 145
        assert graph['wrapper']['conversationId'] == 109
        assert graph['wrapper']['bootstrapEntries'] == [0, 5, 8]
        assert graph['wrapper']['narrativeDbName'] == 'NewGame_Intro'
        entries = {e['id']: e for e in graph['entries']}
        scene_deadline = time.monotonic() + 240
        observations = []
        stable_free = 0
        seen_dialogue = set()
        previous = None
        observed_transitions = []
        submitted_responses = []
        last_action_key = None
        same_action_count = 0
        while time.monotonic() < scene_deadline:
            command('dump')
            state = read_state()
            command('dump-notebook')
            notebook = json.loads((RUN / 'notebook-route.json').read_text())
            guards = next(x for x in notebook['diagnostics'] if x.startswith('guards |'))
            key = (state['scene'], state['conversationActive'], state['conversationId'], state['entryId'])
            observations.append({'elapsed': round(time.monotonic() - started, 3),
                                 'scene': key[0], 'conversationActive': key[1],
                                 'conversationId': key[2], 'entryId': key[3], 'typing': state['typing'],
                                 'narrativeDbName': state['narrativeDbName'], 'narrativeArcName': state['narrativeArcName'],
                                 'responses': state['responses'],
                                 'guards': guards})
            write('newgame-observations.json', observations)
            action = intro_action(state, graph)
            if state['conversationActive'] and action is None:
                # Original wrapper/bootstrap and empty metadata must progress themselves.
                previous = None
                stable_free = 0
            elif state['conversationActive']:
                if previous is not None and previous != state['entryId']:
                    links = entries[previous]['outgoingLinks']
                    if links:
                        assert (links[0]['destinationConversationID'], links[0]['destinationDialogueID']) == (145, state['entryId']), 'Unexpected graph transition'
                    observed_transitions.append([previous, state['entryId']])
                previous = state['entryId']
                seen_dialogue.add(state['entryId'])
                action_key = (key, action)
                same_action_count = same_action_count + 1 if action_key == last_action_key else 1
                last_action_key = action_key
                # At most fast-forward then advance, with one settling observation.
                # A response submits once. Never repeat an unchanged no-op indefinitely.
                assert same_action_count <= (1 if action.startswith('response ') else 3), 'Original action did not advance; inspect boundary'
                command(action)
                if action.startswith('response '):
                    destination = int(action.split()[3])
                    submitted_responses.append({'source': state['entryId'], 'destination': destination,
                                                'response': state['responses'], 'action': action})
                    write('intro-responses.json', submitted_responses)
                    observed_transitions.append([state['entryId'], destination])
                    previous = destination
                stable_free = 0
            else:
                previous = None
                free = False
                if state['scene'] == 'BunnyHouse' and 249 in seen_dialogue:
                    command('dump-tutorial')
                    tutorial = json.loads((RUN / 'tutorial-route.json').read_text())
                    free = intro_complete(state, guards, seen_dialogue, tutorial['diagnostics'])
                    observations[-1]['cleanupDiagnostics'] = [r for r in tutorial['diagnostics']
                        if r.startswith(('introCutscene |', 'introCleanup |', 'trigger | name=Cutscene_IntroBunnyHouse |'))]
                    write('newgame-observations.json', observations)
                stable_free = stable_free + 1 if free else 0
                if stable_free >= 2:
                    break
            time.sleep(.3 if state['conversationActive'] else 1)
        else:
            raise AssertionError('No source-bound completed intro/free state within240 seconds')
        write('newgame-state.json', state)
        write('intro-progression.json', {'conversationId': 145, 'seenEntries': sorted(seen_dialogue),
              'observedTransitions': observed_transitions, 'finalScene': state['scene'], 'guards': guards,
              'submittedResponses': submitted_responses,
              'cleanupBoundary': 'Original Cutscene_IntroBunnyHouse fired, all intro controllers destroyed, exactly one active original bed interaction; two consecutive guarded observations',
              'inputBoundary': 'Original Continue and sole source-bound response Button.onClick on active145 entries; no OS keyboard/controller delivery or forced story state'})
        shutil.copy2(RUN / 'notebook-route.json', RUN / 'newgame-notebook.json')
        command('dump-tutorial')
        shutil.copy2(RUN / 'tutorial-route.json', RUN / 'newgame-tutorial.json')
        loaded = []
        for index in range(2):
            command('dump-travel')
            travel = json.loads((RUN / 'travel-route.json').read_text())
            loaded.append(loaded_travel(travel))
            shutil.copy2(RUN / 'travel-route.json', RUN / ('loaded-travel-%d.json' % (index + 1)))
            time.sleep(.5)
        write('loaded-geometry.json', {'samples': loaded,
              'boundary': 'Two actual idle loaded-world observations after strict intro cleanup; no movement or collision acceptance'})
        print('Original intro completed in', state['scene'], guards, flush=True)
        success = True
    except BaseException as ex:
        error = repr(ex)
    finally:
        owned = processes()
        if owned and not (RUN / 'command.txt').exists():
            try:
                command('restore-input-policy')
            except Exception as ex:
                error = (error or '') + ' input-policy cleanup: ' + repr(ex)
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
                                      'imagesOpened': 0, 'scope': 'Original New/source-bound145 intro through delayed cleanup and loaded idle Player/doorway geometry; no movement',
                                      'inventoryRuntime': 'not-run', 'visual': 'not-run'})
    assert success and clean, error


if __name__ == '__main__':
    main()
