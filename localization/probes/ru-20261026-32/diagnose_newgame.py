#!/usr/bin/env python3
"""Follow original New through source-bound intro dialogue to the first free gameplay state.

Then inspect loaded original Player/doorway geometry and one scoped left pulse.
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
    return 'continue-bound %s %s' % (state['conversationId'], state['entryId'])


def continue_outcome(state, receipt):
    assert (receipt['expectedConversationId'], receipt['expectedEntryId']) == (state['conversationId'], state['entryId']), 'Continue receipt does not match submission'
    matches = receipt['active'] and (receipt['actualConversationId'], receipt['actualEntryId']) == (state['conversationId'], state['entryId'])
    assert receipt['result'] == ('applied' if matches else 'stale'), 'Inconsistent game-thread Continue receipt'
    return receipt['result']


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


def movement_ready(loaded):
    """Loaded topology and original guards must pass before any native DOWN."""
    player, body, door = (loaded[k] for k in ('player', 'body', 'door'))
    assert all(player.get(k) == v for k, v in {
        'movement': 'True', 'lanternTransition': 'False', 'sweaterTransition': 'False',
        'swim': 'null', 'waypoints': 'False'}.items()), 'Original movement guard not ready'
    assert body['type'] == 'Dynamic' and body['simulated'] == 'True' and body['velocity'] == '0,0,0', 'Root body not idle/simulated'
    assert all(door[k] == v for k, v in {'active': 'True', 'enabled': 'True', 'transitioning': 'False',
                                         'delay': '0'}.items()), 'Original doorway not ready'
    root = next(c for c in loaded['playerColliders'] if c['path'] == player['path'] and c['tag'] == 'Player')
    assert all(root[k] == v for k, v in {'active': 'True', 'enabled': 'True', 'trigger': 'False'}.items())
    enabled = [c for c in loaded['doorColliders'] if c['active'] == 'True' and c['enabled'] == 'True']
    assert len(enabled) == 1 and enabled[0]['trigger'] == 'True' and enabled[0]['type'] == 'BoxCollider2D', 'Ambiguous original door trigger'
    pairs = [p for p in loaded['pairs'] if p['playerCollider'] == root['id'] and p['doorCollider'] == enabled[0]['id']]
    assert len(pairs) == 1, 'Missing unique original root/trigger pair'
    pair = pairs[0]
    assert all(pair[k] == v for k, v in {'ignoredLayers': 'False', 'ignoredPair': 'False',
        'distanceValid': 'True', 'overlapped': 'False', 'touching': 'False'}.items()), 'Root/door pair not ready'
    assert float(pair['distance']) > 0, 'Already contacting doorway'
    return pair


def keyboard_idle(row):
    return all(row.get(k) == 'True' for k in ['nativeValid', 'nativeArrowsUp', 'asyncArrowsUp',
                                             'rewiredArrowsUp', 'unityArrowsUp']) and all(
        row.get(k) == '0,0,0' for k in ['actionAxes', 'fullAxis', 'bodyVelocity'])


def keyboard_gameplay_guard(row, loaded):
    assert all(row.get(k) == v for k, v in {'scene': 'BunnyHouse', 'gameplay': 'True',
        'anyEvent': 'False', 'conversation': 'False', 'dustin': 'False', 'glitch': 'False',
        'movement': 'True', 'lanternTransition': 'False', 'sweaterTransition': 'False',
        'waypoints': 'False', 'nativeValid': 'True', 'keyboardEnabled': 'True',
        'ignoreUnfocused': 'True'}.items()), 'Gameplay/input guard changed; hold further DOWN'
    assert row['actor'] == loaded['player']['path'] + '#' + loaded['player']['id'], 'Player sample identity changed'
    assert row['body'] == loaded['body']['path'] + '#' + loaded['body']['id'], 'Root body sample identity changed'


def gameplay_left_pulse(loaded):
    """One150ms native pulse; original Player physics, no route-clearance claim."""
    movement_ready(loaded)
    sampling = attempted = released = False
    report = {'direction': 'left', 'milliseconds': 150, 'attempted': False,
              'boundary': 'Original Player.FixedUpdate -> CheckInput -> FullAxis -> Walk -> root Rigidbody.velocity. Native target helper only; no game-state writes.'}

    def samples():
        command('sample-keyboard-snapshot')
        return [diagnostic_fields([row], 'keyboard') for row in (RUN / 'keyboard-samples.txt').read_text().splitlines()]

    try:
        target = subprocess.run([str(RUN / 'target_keyboard'), str(RUN), 'inspect'], capture_output=True, text=True, timeout=10)
        write('target-inspection.json', dict(exitCode=target.returncode, stdout=target.stdout, stderr=target.stderr))
        assert target.returncode == 0, 'Exact native target inspection failed'
        identity = json.loads(target.stdout)
        assert identity['accessibilityTrusted'], 'Target transport unavailable'
        command('sample-keyboard-start'); sampling = True
        time.sleep(.3)
        before = samples()
        assert len(before) >= 2 and all(keyboard_idle(r) for r in before[-2:]), 'No observed all-up/zero-axis idle before DOWN'
        for row in before:
            keyboard_gameplay_guard(row, loaded)
        report['attempted'] = attempted = True
        write('movement-pulse.json', report)
        pulse = subprocess.run([str(RUN / 'target_keyboard'), str(RUN), 'left', '150'], capture_output=True, text=True, timeout=10)
        report.update(exitCode=pulse.returncode, stdout=pulse.stdout, stderr=pulse.stderr)
        write('movement-pulse.json', report)
        deadline = time.monotonic() + 8
        while True:
            rows = samples()
            down = all(any(r[k] == 'True' for r in rows) for k in ['nativeLeft', 'asyncLeft', 'rewiredLeft', 'unityLeft'])
            released = down and len(rows) >= 2 and all(keyboard_idle(r) for r in rows[-2:])
            if released or time.monotonic() >= deadline:
                break
            time.sleep(.25)
        command('sample-keyboard-stop'); sampling = False
        shutil.copy2(RUN / 'keyboard-samples.txt', RUN / 'gameplay-left-samples.txt')
        report.update(samples=len(rows), deliveryAllFourLayers=down, releaseAndZeroAxesObserved=released)
        write('movement-pulse.json', report)
        assert pulse.returncode == 0, 'Native pulse failed; hold further DOWN'
        assert json.loads(pulse.stdout.splitlines()[0])['pid'] == identity['pid'], 'Native target changed'
        assert released, 'Delivery/release unknown; no second DOWN'
        for row in rows:
            keyboard_gameplay_guard(row, loaded)
        assert any(r['fullAxis'] == '-1,0,0' and r['actionAxes'] == '-1,0,0' for r in rows), 'No original action-axis ingress'
        start = [float(x) for x in before[-1]['bodyPosition'].split(',')]
        end = [float(x) for x in rows[-1]['bodyPosition'].split(',')]
        delta = [b-a for a, b in zip(start, end)]
        report.update(startBodyPosition=start, endBodyPosition=end, displacement=delta,
                      observedBodyVelocities=sorted({r['bodyVelocity'] for r in rows}))
        write('movement-pulse.json', report)
        assert delta[0] < -.001 and abs(delta[1]) < .1, 'Native ingress did not establish bounded original left displacement'
        assert any(float(r['bodyVelocity'].split(',')[0]) < -.01 for r in rows), 'No actual left physics velocity observed'
        command('dump-travel')
        shutil.copy2(RUN / 'travel-route.json', RUN / 'post-movement-travel.json')
        after = loaded_travel(json.loads((RUN / 'travel-route.json').read_text()))
        movement_ready(after)
        report['result'] = 'passed: one original left movement and observed release; route/collision/travel unverified'
        write('movement-pulse.json', report)
    finally:
        if attempted and not released:
            recovery = subprocess.run([str(RUN / 'target_keyboard'), str(RUN), 'release-left'], capture_output=True, text=True, timeout=10)
            write('failure-key-release.json', dict(exitCode=recovery.returncode, stdout=recovery.stdout, stderr=recovery.stderr))
            if not sampling:
                command('sample-keyboard-start'); sampling = True
            time.sleep(.5)
            recovered = samples()
            report['upOnlyRecoveryObserved'] = len(recovered) >= 2 and all(keyboard_idle(r) for r in recovered[-2:])
            write('movement-pulse.json', report)
            shutil.copy2(RUN / 'keyboard-samples.txt', RUN / 'failure-release-samples.txt')
        if sampling:
            command('sample-keyboard-stop')


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
                             'scope': 'Original New/source-bound145 intro, two loaded idle Player/door pair samples, then one150ms process-targeted left pulse; no screenshots or forced eligibility'})
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
        submitted_continues = []
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
                if action.startswith('continue-bound '):
                    receipt = json.loads((RUN / 'continue-receipt.json').read_text())
                    result = continue_outcome(state, receipt)
                    submitted_continues.append(dict(action=action, receipt=receipt))
                    write('intro-continues.json', submitted_continues)
                    if result == 'stale':
                        # Re-observe original progression. Do not replay this
                        # stale request or credit an action to another entry.
                        previous = last_action_key = None
                        same_action_count = 0
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
            movement_ready(loaded[-1])
            for component in ('player', 'body', 'door'):
                assert all(loaded[-1][component][key] == loaded[0][component][key]
                           for key in ('id', 'path')), 'Loaded movement identity changed between observations'
            shutil.copy2(RUN / 'travel-route.json', RUN / ('loaded-travel-%d.json' % (index + 1)))
            time.sleep(.5)
        write('loaded-geometry.json', {'samples': loaded,
              'boundary': 'Two actual idle loaded-world observations after strict intro cleanup; no movement or collision acceptance'})
        gameplay_left_pulse(loaded[-1])
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
                                      'imagesOpened': 0, 'scope': 'Original New/source-bound145 intro through delayed cleanup, loaded root/door pair observations and one150ms original left movement pulse',
                                      'inventoryRuntime': 'not-run', 'visual': 'not-run'})
    assert success and clean, error


if __name__ == '__main__':
    main()
