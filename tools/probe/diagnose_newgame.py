#!/usr/bin/env python3
"""Follow original New through source-bound intro dialogue to the first free gameplay state.

Then follow the source-backed natural doorway corridor with guarded left/down pulses.
No screenshots, forced chapter selection, trigger mutation or inventory opening.
Run a frozen copy in the probe directory; all later-read helpers live there too.
"""
import argparse
import hashlib
import json
import math
import os
from pathlib import Path
import shutil
import subprocess
import sys
import time
from datetime import datetime, timezone

RUN = None
SOURCE = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')
DATA = 'The Forest of Love_Data'
GAME = None
EXE = None
LAUNCHER = None
COMMAND_HOLD = None

STARTUP_TRACE_ENV = {
    'WINEDEBUG': '-all,+timestamp,+pid,+tid,+loaddll,+seh,+process',
    # CrossOver's Perl wrapper otherwise defaults CX_DEBUGMSG to -all and then
    # overwrites WINEDEBUG. Setting WINEDEBUG alone does not enable its tracing.
    'CX_DEBUGMSG': '-all,+timestamp,+pid,+tid,+loaddll,+seh,+process',
    'MONO_LOG_LEVEL': 'debug',
    'MONO_LOG_MASK': 'all',
}


def launch_options(argv):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('run', type=Path)
    parser.add_argument('--retain-exit', action='store_true', help='Ordinary task-owned parent waits for observer and retains its actual exit code')
    parser.add_argument('--startup-diagnostics', action='store_true',
                        help='Opt-in Wine loader/exception/process and Mono logs; no runtime-policy changes')
    return parser.parse_args(argv)


def startup_environment(enabled):
    # Preserve normal inheritance exactly unless this new immutable run opts in.
    # Never persist the inherited environment, which may contain credentials.
    return dict(os.environ, **STARTUP_TRACE_ENV) if enabled else None


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


def real_game_rows(rows):
    """Match the executable at argv[0], excluding Wine wrappers/crash helpers."""
    paths = [str(EXE), 'Z:' + str(EXE).replace('/', '\\'),
             'Y:\\' + str(EXE.relative_to('/Users/antonkrutov')).replace('/', '\\')]
    result = []
    for row in rows:
        parts = row.split(None, 2)
        if len(parts) == 3 and any(parts[2] == p or parts[2].startswith(p + ' ') for p in paths):
            result.append(row)
    return result


def observe_lifetime(boundary, value=None, **extra):
    """Retain launcher wait status separately from non-child game presence.

    A ps sample proves presence/absence at its own time, never a game exit code.
    No foreground observation, process signal or policy change occurs here.
    """
    assert LAUNCHER is not None, 'Missing exact launcher handle; hold commands'
    rows = processes()
    pending = RUN / 'command.txt'
    event = dict(utc=datetime.now(timezone.utc).isoformat(), monotonic=time.monotonic(),
                 boundary=boundary, command=value, launcherPid=LAUNCHER.pid,
                 launcherExitCode=LAUNCHER.poll(), gameExitCode=None,
                 ownedProcessRows=rows, realGameRows=real_game_rows(rows),
                 pendingCommand=pending.exists(), unresolvedCommand=COMMAND_HOLD, **extra)
    try:
        raw = pending.read_bytes()
    except FileNotFoundError:
        event['pendingCommand'] = False
    else:
        event['pendingCommand'] = True
        event['pendingCommandSha256'] = hashlib.sha256(raw).hexdigest()
    with (RUN / 'process-lifetime.jsonl').open('a') as stream:
        stream.write(json.dumps(event, ensure_ascii=False) + '\n')
    return event


def wait_for_ready(child, timeout=300):
    """Bound startup by both real readiness and the exact owned process lifetime.

    A CrossOver launcher can exit while its real game survives. Its exit alone
    is insufficient; preserve that distinction and never retry a consumed copy.
    """
    started = time.monotonic()
    while True:
        log = RUN / 'player.log'
        raw = log.read_bytes() if log.exists() else b''
        ready = b'FOREST_PROBE_READY' in raw
        code = child.poll()
        owned = processes() if code is not None or ready else None
        elapsed = time.monotonic() - started
        result = ('launcher-exited-without-game' if code is not None and not owned
                  else 'ready' if ready else 'timeout' if elapsed >= timeout else None)
        if result is not None:
            if owned is None:
                owned = processes()
            write('startup-observation.json', dict(result=result, launcherExitCode=code,
                  elapsedSeconds=round(elapsed, 3), readyMarker=ready,
                  ownedProcessRows=owned, playerLogBytes=len(raw),
                  playerLogSha256=hashlib.sha256(raw).hexdigest(),
                  pendingCommand=(RUN / 'command.txt').exists(),
                  boundary='Launcher poll plus exact executable-path process scan; no game command or retry'))
            assert result != 'launcher-exited-without-game', 'Launcher exited before readiness with no surviving owned game: returnCode=' + str(code)
            assert result != 'timeout', 'Startup marker timeout'
            return
        time.sleep(min(1, max(0, timeout - elapsed)))


def command(value, deadline=None):
    global COMMAND_HOLD
    now = time.monotonic()
    expires = now + 25 if deadline is None else min(now + 25, deadline)
    assert expires > now, 'Observation budget exhausted before command submission'
    assert COMMAND_HOLD is None, 'Unresolved command hold; reconcile before any further submission: ' + str(COMMAND_HOLD)
    before = observe_lifetime('before-command', value)
    assert len(before['realGameRows']) == 1, 'Real task game absent or ambiguous before command; no submission'
    assert not (RUN / 'command.txt').exists(), 'Reconcile the pending command instead of submitting another'
    assert time.monotonic() < expires, 'Observation budget exhausted before command submission'
    COMMAND_HOLD = value
    sender = subprocess.Popen([sys.executable, str(RUN / 'command.py'), str(RUN), value],
                              stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    stopped = False
    try:
        while True:
            remaining = expires - time.monotonic()
            if remaining <= 0:
                raise TimeoutError('Command deadline; outcome unknown, reconcile before resubmitting: ' + value)
            try:
                stdout, stderr = sender.communicate(timeout=min(.25, remaining))
                break
            except subprocess.TimeoutExpired:
                state = observe_lifetime('await-ack', value, transportPid=sender.pid)
                # Quit can legitimately remove its game before the helper reads
                # the final ACK. Every other action must retain a unique game.
                assert value == 'quit' or len(state['realGameRows']) == 1, \
                    'Real task game absent or ambiguous while awaiting acknowledgement; outcome unknown, no replay: ' + value
        state = observe_lifetime('transport-returned', value, transportPid=sender.pid,
                                 transportExitCode=sender.returncode,
                                 transportStdout=stdout[-500:], transportStderr=stderr[-500:])
        assert sender.returncode == 0, (value, stdout[-500:], stderr[-500:])
        COMMAND_HOLD = None
        assert value == 'quit' or len(state['realGameRows']) == 1, \
            'Command acknowledged but real task game absent or ambiguous after receipt: ' + value
    finally:
        # Only this ordinary file-transport child is stopped, never the game,
        # launcher, observer, other lane or a process selected by name.
        if sender.poll() is None:
            stopped = True
            sender.terminate()
            try:
                sender.communicate(timeout=2)
            except subprocess.TimeoutExpired:
                sender.kill()
                sender.communicate(timeout=2)
        observe_lifetime('transport-reaped', value, transportPid=sender.pid,
                         transportExitCode=sender.returncode, transportStoppedByObserver=stopped)


def focus_trace_latest(trace):
    """Validate scalar transport only; unfocused states are valid observations."""
    assert trace.get('limited') is False, 'Passive focus trace limit reached; hold actions'
    records = trace.get('records')
    assert isinstance(records, list) and 0 < len(records) <= 1024, 'Missing/bounded focus serialization'
    rows = [diagnostic_fields([row], 'focus') for row in records]
    assert [int(r['sequence']) for r in rows] == list(range(len(rows))), 'Focus trace sequence changed'
    assert all(int(a['frame']) <= int(b['frame']) and float(a['realtime']) <= float(b['realtime'])
               for a,b in zip(rows, rows[1:])), 'Focus frame/clock regressed'
    latest = rows[-1]
    assert any(r['kind'] == 'snapshot' for r in rows) and 'errorType' not in latest, 'No fresh successful focus snapshot'
    # A real callback/scene change can append after command acknowledgement.
    # Keep that newer actual state; do not demand a quiet frame or replay a dump.
    assert all(math.isfinite(float(latest[k])) and float(latest[k]) >= 0 for k in ['frame','realtime','scaledTime','timeScale']), 'Invalid actual focus clocks'
    assert latest.get('scene') and int(latest['winPid']) > 0, 'Missing focus scene/process identity'
    assert all(latest.get(k) in ['True','False'] for k in ['focused','runInBackground','rewiredReady','rewiredCallbackCache']), 'Missing actual focus state'
    if latest['rewiredReady'] == 'True':
        assert all(latest.get(k) in ['True','False'] for k in ['rewiredFocusWatcher',
            'rewiredOtherWatcher','rewiredGlobalEnabled','rewiredFilter','ignoreUnfocused','rewiredInputAllowed',
            'rewiredKeyboardAllowed','nativeKeyboard','unityInput','gameplay','anyEvent','conversation']), 'Missing focus eligibility state'
    return latest


def observe_focus_boundary(label, force=False):
    # Native and game-thread times are bracketed, never called simultaneous.
    path = RUN / 'focus-observations.json'
    rows = json.loads(path.read_text()) if path.exists() else []
    if rows and not force and time.time() - rows[-1]['hostAfter'] < 1:
        return
    assert len(rows) < 512, 'Passive native focus observation bound; hold actions'
    before = time.time()
    command('dump-focus')
    trace = focus_trace_latest(json.loads((RUN / 'focus-trace.json').read_text()))
    result = subprocess.run([str(RUN / 'target_keyboard'), str(RUN), 'observe'],
                            capture_output=True, text=True, timeout=10)
    try:
        native = json.loads(result.stdout) if result.returncode == 0 else None
    except (ValueError, TypeError):
        native = None
    rows.append(dict(label=label, hostBefore=before, hostAfter=time.time(), bridge=trace,
        native=native, helperExitCode=result.returncode, helperStdout=result.stdout, helperStderr=result.stderr))
    write('focus-observations.json', rows)
    assert result.returncode == 0, 'Passive native observation failed; no replay or fallback'
    assert isinstance(native, dict), 'Malformed passive native JSON; hold actions'
    assert native['mode'] == 'observe' and native['status'] in ['unique','unavailable-or-ambiguous'], 'Unknown passive native response'
    assert isinstance(native['frontmostPid'], int) and math.isfinite(native['unixTime']), 'Missing native focus identity/time'
    if native['status'] == 'unique':
        assert native['pid'] > 0 and native['windowID'] > 0 and native['windowCount'] == 1, 'Invalid unique task window'


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


def original_keyboard_guard(row):
    """Real original eligibility and movement map identity, even during transitions."""
    expected = dict(focused='True', ignoreUnfocused='True', rewiredFilter='True',
                    rewiredReady='True', rewiredGlobalEnabled='True', rewiredFocusWatcher='True',
                    rewiredInputAllowed='True', rewiredKeyboardAllowed='True',
                    keyboardEnabled='True', nativeKeyboard='True', unityInput='False', player='0:Player1')
    assert all(row.get(k) == v for k, v in expected.items()), 'Original keyboard eligibility changed: ' + repr({k: row.get(k) for k in expected})
    assert row.get('rewiredOtherWatcher') in ['True', 'False'], 'Missing actual Rewired other watcher'
    maps = json.loads(row.get('keyboardMaps', 'null'))
    assert isinstance(maps, dict) and isinstance(maps.get('maps'), list), 'Missing actual original keyboard maps'
    maps = maps['maps']
    assert sorted((m['source'], m['category'], m['layout']) for m in maps) == [(0, 0, 0), (1, 1, 0)], 'Original keyboard map identity changed'
    assert all(isinstance(m['enabled'], bool) for m in maps), 'Unknown keyboard map enabled state'
    movement = next(m for m in maps if m['source'] == 0)
    assert movement['enabled'] is True and all(not m['movement'] for m in maps if m['source'] != 0), 'Original movement map disabled or rebound'
    # Exact original category0/layout0 action0/1 bindings from the pinned
    # travel input-configuration.json. Sorted lists retain multiplicity.
    expected_bindings = sorted((action, key, pole) for action, key, pole in [
        (0, 97, 1), (0, 100, 0), (0, 276, 1), (0, 275, 0),
        (1, 119, 0), (1, 115, 1), (1, 273, 0), (1, 274, 1)])
    bindings = movement['movement']
    assert sorted((b['action'], b['key'], b['pole']) for b in bindings) == expected_bindings, 'Original movement bindings changed'
    assert all(b['enabled'] is True and b['invert'] is False and
               all(b[k] == v for k,v in dict(type=1, range=0, modifier1=0, modifier2=0, modifier3=0).items())
               for b in bindings), 'Original movement binding flags changed'


def original_menu_ready(rows, minimum=2):
    assert len(rows) >= minimum, 'Need two real original menu idle frames before New'
    for row in rows:
        original_keyboard_guard(row)
        assert all(row.get(k) == v for k,v in dict(scene='StartMenu', gameplay='False',
            anyEvent='False', conversation='False', actor='null', body='null').items()), 'Original menu state changed; no New'
        assert all(row.get(layer+'MovementUp') == 'True' and row.get(layer+'MovementDown') == ''
                   for layer in ['native','async','rewired','unity']), 'Original menu eight-key idle failed; no New'
        assert row.get('nativeValid') == 'True' and all(row.get(k) == '0,0,0' for k in ['actionAxes','fullAxis']), 'Original menu native/axis idle failed; no New'


def observe_original_menu():
    """One passive original-policy gate before New; preserve rejected real frames."""
    command('sample-keyboard-start')
    try:
        deadline = time.monotonic() + 30
        while True:
            rows = keyboard_samples()
            if rows:
                original_menu_ready(rows, minimum=1)
                if len(rows) >= 2:
                    break
            assert time.monotonic() < deadline, 'Two actual original menu frames not produced; no New'
            time.sleep(.25)
    finally:
        command('sample-keyboard-stop')
        shutil.copy2(RUN / 'keyboard-samples.txt', RUN / 'original-menu-idle-samples.txt')
    rows = [diagnostic_fields([r], 'keyboard') for r in (RUN / 'original-menu-idle-samples.txt').read_text().splitlines()]
    original_menu_ready(rows)
    write('original-menu-readiness.json', dict(result='passed', actualIdleFrames=len(rows),
          boundary='Actual original focus/filter/native/Player/maps/eligibility and eight-key/axis idle; no menu pulse or QA policy replacement'))


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


class IntroObservationBudget:
    """Wall-clock bounds with source milestones, independent of rendered FPS.

    Original source: intro-observation-20261026/source-trace.json. The limits
    are conservative harness limits, not claims about original game duration.
    Acks, typing changes, clock ticks and repeated milestones buy no more time.
    """
    HARD_SECONDS = 360
    LIMITS = {'bootstrap': (120, 60), 'dialogue': (240, 30), 'cleanup': (60, 15)}
    STAGES = ['Starting', 'BunnyWalksIn', 'BunnyApproachesBed', 'BunnySaysHi',
              'BunnyLeavesRoom', 'Ending', 'Cleanup']

    def __init__(self, now):
        self.started = self.stage_started = self.progress_at = now
        self.stage = 'bootstrap'
        self.milestones = set()
        self.frame = -1
        self.realtime = -1
        self.cutscene_stage = -1
        self.timer_min = None
        self.terminal_frames = []

    @property
    def deadline(self):
        cap, idle = self.LIMITS[self.stage]
        return min(self.started + self.HARD_SECONDS, self.stage_started + cap, self.progress_at + idle)

    def check(self, now):
        assert now < self.started + self.HARD_SECONDS, 'Intro total hard limit exhausted'
        cap, idle = self.LIMITS[self.stage]
        assert now < self.stage_started + cap, 'Intro stage hard limit exhausted: ' + self.stage
        assert now < self.progress_at + idle, 'Intro forward progress stalled: ' + self.stage

    def observe(self, now, state, graph, seen_dialogue):
        self.check(now)
        assert state['frame'] > self.frame and state['realtime'] > self.realtime, 'Intro observation must be a new real frame'
        assert all(math.isfinite(state[k]) and state[k] >= 0 for k in ['realtime', 'scaledTime', 'timeScale']), 'Invalid original Unity clocks'
        self.frame, self.realtime = state['frame'], state['realtime']
        rows = state['introDiagnostics']
        guards = next(r for r in rows if r.startswith('guards |'))
        # Validate source identities/branching before crediting any progress.
        action = intro_action(state, graph)
        assert state['scene'] in ['StartMenu', 'SoftResetLoadingScene', 'ChapterSelect', 'IntroForest', 'BunnyHouse'], 'Unexpected intro scene'
        milestone = ('scene', state['scene'])
        if state['conversationActive']:
            milestone = ('entry', state['conversationId'], state['entryId'])
        stage = ('cleanup' if 249 in seen_dialogue and not state['conversationActive']
                 else 'dialogue' if action is not None else self.stage)
        assert ['bootstrap', 'dialogue', 'cleanup'].index(stage) >= ['bootstrap', 'dialogue', 'cleanup'].index(self.stage), 'Intro stage regressed'
        if stage != self.stage:
            self.stage, self.stage_started, self.progress_at = stage, now, now
        if milestone not in self.milestones:
            self.milestones.add(milestone)
            self.progress_at = now
        cutscenes = [diagnostic_fields([r], 'introCutscene') for r in rows if r.startswith('introCutscene |')]
        assert len(cutscenes) <= 1, 'Ambiguous original intro controllers'
        if cutscenes:
            c = cutscenes[0]
            index = self.STAGES.index(c['stage'])
            assert index >= self.cutscene_stage, 'Original cutscene stage regressed'
            if index > self.cutscene_stage:
                self.cutscene_stage, self.timer_min, self.progress_at = index, None, now
            if c['timerSet'] == 'True':
                remaining = float(c['timerSeconds'])
                assert math.isfinite(remaining) and remaining > 0, 'Invalid active original cleanup timer'
                assert c['stage'] in ['Starting', 'Ending'] and remaining <= (.5 if c['stage'] == 'Starting' else 3), 'Timer differs from original source stage'
                assert self.timer_min is None or remaining <= self.timer_min + .01, 'Original intro timer increased within stage'
                if self.timer_min is None or remaining < self.timer_min - .01:
                    self.timer_min, self.progress_at = remaining, now
        terminal = intro_complete(state, guards, seen_dialogue, rows)
        if terminal:
            self.terminal_frames.append(state['frame'])
        else:
            self.terminal_frames = []
        return guards, action, len(self.terminal_frames) >= 2

    def receipt(self, now):
        return dict(stage=self.stage, elapsed=round(now-self.started, 3),
                    stageElapsed=round(now-self.stage_started, 3),
                    idle=round(now-self.progress_at, 3), hardLimit=self.HARD_SECONDS,
                    stageLimits=self.LIMITS, actualTerminalFrames=list(self.terminal_frames))


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
    return dict(guards=guards, policy=diagnostic_fields(rows, 'travelRewired'), input=diagnostic_fields(rows, 'travelInput'), player=player, body=body, door=door,
                bodies=bodies, playerColliders=player_colliders, doorColliders=door_colliders, pairs=pairs,
                sweeps=[dict(part.split('=', 1) for part in r.split(' | ')[1:]) for r in rows if r.startswith('travelSweep | ')],
                sweepHits=[dict(part.split('=', 1) for part in r.split(' | ')[1:]) for r in rows if r.startswith('travelSweepHit | ')])


def movement_ready(loaded):
    """Loaded topology and original guards must pass before any native DOWN."""
    player, body, door = (loaded[k] for k in ('player', 'body', 'door'))
    assert loaded['guards'].get('focused') == 'True', 'Original ignore-unfocused policy requires real Unity focus; no task DOWN'
    assert all(loaded['policy'].get(k) == v for k,v in {'ignoreUnfocused':'True', 'nativeKeyboard':'True', 'unityInput':'False'}.items()), 'Original input policy changed; no task DOWN'
    original_keyboard_guard(dict(loaded['policy'], **loaded['input'], focused=loaded['guards'].get('focused')))
    assert loaded['input']['active'] == loaded['input']['enabled'] == 'True', 'Original InputHelper inactive'
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
                                             'rewiredArrowsUp', 'unityArrowsUp', 'nativeMovementUp',
                                             'asyncMovementUp', 'rewiredMovementUp', 'unityMovementUp']) and all(
        row.get(k) == '0,0,0' for k in ['actionAxes', 'fullAxis', 'bodyVelocity']) and all(
        row.get(layer + 'MovementDown') == '' for layer in ['native', 'async', 'rewired', 'unity'])


def keyboard_samples():
    command('sample-keyboard-snapshot')
    return [diagnostic_fields([row], 'keyboard') for row in (RUN / 'keyboard-samples.txt').read_text().splitlines()]


def observe_loaded_travel():
    """Keep passive producer evidence even when a pre-movement guard rejects."""
    loaded = []
    command('sample-keyboard-start')
    try:
        time.sleep(.3)
        for index in range(2):
            command('dump-travel')
            # Preserve the exact rejected observation before parsing any guard.
            shutil.copy2(RUN / 'travel-route.json', RUN / ('loaded-travel-%d.json' % (index + 1)))
            rows = keyboard_samples()
            current = loaded_travel(json.loads((RUN / 'travel-route.json').read_text()))
            observe_focus_boundary('loaded-%d' % (index + 1), force=True)
            movement_ready(current)
            assert len(rows) >= 2 and all(keyboard_idle(r) for r in rows), 'Non-idle input during loaded observations; no DOWN'
            for row in rows:
                keyboard_gameplay_guard(row, current)
            if loaded:
                for component in ('player', 'body', 'door'):
                    assert all(current[component][key] == loaded[0][component][key]
                               for key in ('id', 'path')), 'Loaded movement identity changed between observations'
            loaded.append(current)
            time.sleep(.5)
    finally:
        command('sample-keyboard-stop')
        shutil.copy2(RUN / 'keyboard-samples.txt', RUN / 'loaded-travel-input-samples.txt')
    write('loaded-geometry.json', {'samples': loaded,
          'boundary': 'Two actual idle loaded-world observations after strict intro cleanup; original arrows/WASD and axes observed; no movement or collision acceptance'})
    return loaded


def keyboard_gameplay_guard(row, loaded):
    original_keyboard_guard(row)
    assert all(row.get(k) == v for k, v in {'scene': 'BunnyHouse', 'gameplay': 'True',
        'anyEvent': 'False', 'conversation': 'False', 'dustin': 'False', 'glitch': 'False',
        'movement': 'True', 'lanternTransition': 'False', 'sweaterTransition': 'False',
        'waypoints': 'False', 'nativeValid': 'True', 'keyboardEnabled': 'True',
        'ignoreUnfocused': 'True', 'focused': 'True'}.items()), 'Gameplay/input guard changed; hold further DOWN'
    gameplay_identity_guard(row, loaded)


def gameplay_identity_guard(row, loaded):
    assert row['actor'] == loaded['player']['path'] + '#' + loaded['player']['id'], 'Player sample identity changed'
    assert row['body'] == loaded['body']['path'] + '#' + loaded['body']['id'], 'Root body sample identity changed'


def posted_task_down(stdout, direction, identity):
    """Recovery authority comes from this helper's actual task edge, never intent."""
    try:
        lines = stdout.splitlines()
        target = json.loads(lines[0])
        return target['pid'] == identity['pid'] and target['windowID'] == identity['windowID'] and target['mode'] == direction and any(
            line.startswith('post%sDown pid=%s window=%s unixTime=' %
                            (direction.title(), identity['pid'], identity['windowID'])) for line in lines[1:])
    except (ValueError, KeyError, IndexError):
        return False


def input_released(row):
    # A scene transition can temporarily destroy the old body. Key/axis release
    # is still observed independently; BunnyHouse readiness also requires its body.
    return all(row.get(k) == 'True' for k in ['nativeValid', 'nativeMovementUp',
        'asyncMovementUp', 'rewiredMovementUp', 'unityMovementUp']) and all(
        row.get(k) == '0,0,0' for k in ['actionAxes', 'fullAxis']) and (
        row.get('bodyVelocity') == '0,0,0' or
        (row.get('body') == 'null' and row.get('bodyVelocity') == 'null'))


def route_pulse_plan(loaded, spent):
    """Source polygon corridor: left at intro Y, then down at X2.30–2.65.

    Limits come from the pinned doorway, radius.16 and original walking speed.
    Native time is only a bound: actual position/producers decide each next step.
    """
    movement_ready(loaded)
    x, y, _ = map(float, loaded['body']['position'].split(','))
    assert 2.30 <= x <= 3.55 and .20 < y < 1.40, 'Outside bounded original doorway route'
    direction = 'left' if x > 2.65 else 'down'
    assert direction != 'left' or y > 1.20, 'Horizontal leg must precede descent'
    if direction == 'down':
        assert x <= 2.65, 'Right wall blocks descent at intro X'
    # Original prefab speed is checked against the loaded fields before launch.
    assert all(abs(float(v)-1.2)<.0001 for v in loaded['player']['speed'].split(',')[:2]), 'Original walking speed changed'
    assert all(abs(float(v)-1.2)<.0001 for v in loaded['player']['currentSpeed'].split(',')[:2]), 'Walking speed not active'
    speed = 1.2
    distance = x - 2.50 if direction == 'left' else y - .24
    ms = max(150, min(400, int(distance / speed * 1000)))
    assert spent[direction] + ms <= 2400, 'Source-backed leg time bound exhausted; no blind retry'
    sweeps = [r for r in loaded['sweeps'] if r['direction'] == direction]
    assert len(sweeps) == 1, 'Missing unique original root cast'
    sweep = sweeps[0]
    assert int(sweep['count']) < int(sweep['capacity']), 'Physics query truncated'
    root = next(c for c in loaded['playerColliders'] if c['path'] == loaded['player']['path'] and c['tag'] == 'Player')
    assert sweep['root'] == root['id'], 'Sweep does not bind original root'
    required = speed * ms / 1000 + .08
    assert float(sweep['distance']) >= required
    blockers = [r for r in loaded['sweepHits'] if r['direction'] == direction and
                r['ownChild'] != 'True' and r['ignoredPair'] != 'True' and float(r['distance']) <= required]
    assert not blockers, 'Original geometry blocks proposed pulse: ' + repr(blockers)
    return direction, ms


def route_sample_guard(rows, direction, loaded, transitioning=False):
    allowed_axis = '-1,0,0' if direction == 'left' else '0,-1,0'
    key = 'LeftArrow' if direction == 'left' else 'DownArrow'
    for row in rows:
        original_keyboard_guard(row)
        assert all(row.get(k) == v for k,v in {'nativeValid':'True', 'keyboardEnabled':'True', 'ignoreUnfocused':'True'}.items()), 'Unknown or changed original keyboard policy'
        for layer in ['native', 'async', 'rewired', 'unity']:
            assert set(filter(None, row[layer + 'MovementDown'].split(','))) <= {key}, 'Unexplained movement producer; no further DOWN'
        assert row['actionAxes'] in ['0,0,0', allowed_axis] and row['fullAxis'] in ['0,0,0', allowed_axis], 'Unexpected original axis'
        assert row['scene'] in ['BunnyHouse', 'CentralForest'], 'Unexpected scene'
        if row['scene'] == 'BunnyHouse':
            gameplay_identity_guard(row, loaded)
        if row['scene'] == 'BunnyHouse':
            natural_transition = transitioning and direction == 'down' and row.get('routeDoorTransition') == 'True'
            if not natural_transition:
                keyboard_gameplay_guard(row, loaded)
        else:
            assert transitioning and direction == 'down', 'CentralForest without original DOWN transition'


def route_consumer_ingress(rows, direction):
    key, axis = ('LeftArrow', '-1,0,0') if direction == 'left' else ('DownArrow', '0,-1,0')
    return any(key in row['nativeMovementDown'].split(',') and key in row['rewiredMovementDown'].split(',')
               and row['actionAxes'] == row['fullAxis'] == axis for row in rows)


def natural_doorway_route(loaded):
    """Bounded original movement only; stop at first actual CentralForest state."""
    spent = {'left': 0, 'down': 0}
    pulses = []
    original = loaded
    for index in range(16):
        direction, ms = route_pulse_plan(loaded, spent)
        prefix = 'route-%02d-%s' % (index + 1, direction)
        report = dict(direction=direction, milliseconds=ms, attempted=False)
        sampling = posted = released = False
        identity = None
        try:
            target = subprocess.run([str(RUN / 'target_keyboard'), str(RUN), 'inspect'], capture_output=True, text=True, timeout=10)
            write(prefix + '-target.json', dict(exitCode=target.returncode, stdout=target.stdout, stderr=target.stderr))
            assert target.returncode == 0, 'Exact native target inspection failed'
            identity = json.loads(target.stdout)
            assert identity['accessibilityTrusted'], 'Native transport unavailable'
            command('sample-keyboard-start'); sampling = True
            time.sleep(.3)
            before = keyboard_samples()
            assert len(before) >= 2 and all(keyboard_idle(r) for r in before), 'Non-idle before task DOWN; no input recovery authorized'
            for row in before:
                keyboard_gameplay_guard(row, loaded)
            report['attempted'] = True
            write(prefix + '-pulse.json', report)
            pulse = subprocess.run([str(RUN / 'target_keyboard'), str(RUN), direction, str(ms)], capture_output=True, text=True, timeout=10)
            posted = posted_task_down(pulse.stdout, direction, identity)
            spent[direction] += ms
            report.update(exitCode=pulse.returncode, stdout=pulse.stdout, stderr=pulse.stderr, taskDownReceipt=posted)
            write(prefix + '-pulse.json', report)
            deadline = time.monotonic() + 8
            key = 'LeftArrow' if direction == 'left' else 'DownArrow'
            while True:
                rows = keyboard_samples()
                # Check producer/axis surprises immediately. Story guards may
                # be changing through the real doorway; bind that separately
                # before crediting arrival or submitting another DOWN.
                route_sample_guard(rows, direction, loaded, transitioning=direction == 'down')
                down = all(any(key in r[layer + 'MovementDown'].split(',') for r in rows)
                           for layer in ['native', 'async', 'rewired', 'unity'])
                released = len(rows) >= 2 and all(input_released(r) for r in rows[-2:])
                if released or time.monotonic() >= deadline:
                    break
                time.sleep(.25)
            command('sample-keyboard-stop'); sampling = False
            shutil.copy2(RUN / 'keyboard-samples.txt', RUN / (prefix + '-samples.txt'))
            rows = [diagnostic_fields([r], 'keyboard') for r in (RUN / (prefix + '-samples.txt')).read_text().splitlines()]
            # Stop can retain later frames than the decision snapshot. Those
            # frames must pass release too before any following pulse.
            down = all(any(key in r[layer + 'MovementDown'].split(',') for r in rows)
                       for layer in ['native', 'async', 'rewired', 'unity'])
            released = len(rows) >= 2 and all(input_released(r) for r in rows[-2:])
            route_sample_guard(rows, direction, loaded, transitioning=direction == 'down')
            ingress = route_consumer_ingress(rows, direction)
            report.update(savedSamples=len(rows), deliveryAllFourLayers=down, matchingFrameConsumerIngress=ingress, releaseAndZeroAxesObserved=released)
            write(prefix + '-pulse.json', report)
            assert pulse.returncode == 0 and posted, 'Task DOWN transport not established'
            assert down and ingress and released, 'Native direction delivery/consumer ingress/release unknown; stop route'
            command('dump-travel')
            shutil.copy2(RUN / 'travel-route.json', RUN / (prefix + '-travel.json'))
            travel = json.loads((RUN / 'travel-route.json').read_text())
            # A real original door transition is allowed to change scene/guards.
            transition = direction == 'down' and (travel['scene'] == 'CentralForest' or any(
                r.startswith('travelDoor | ') and 'destination=CentralForest' in r and 'transitioning=True' in r
                for r in travel['diagnostics']))
            route_sample_guard(rows, direction, loaded, transitioning=transition)
            if transition:
                deadline = time.monotonic() + 20
                while travel['scene'] == 'BunnyHouse' and time.monotonic() < deadline:
                    time.sleep(.5)
                    command('dump-travel')
                    travel = json.loads((RUN / 'travel-route.json').read_text())
                assert travel['scene'] == 'CentralForest', 'Original transition did not reach CentralForest'
                command('dump')
                arrival = read_state()
                write('central-forest-arrival.json', arrival)
                assert arrival['scene'] == 'CentralForest', 'Arrival changed to unexpected scene'
                command('dump-tutorial')
                shutil.copy2(RUN / 'tutorial-route.json', RUN / 'central-forest-tutorial.json')
                report['result'] = 'Original natural CentralForest entry observed; no tutorial action submitted'
                pulses.append(report)
                write('natural-route.json', dict(result='passed', pulses=pulses, spentMilliseconds=spent,
                    boundary='Original native left/down -> original axes/Player physics -> natural Doorway travel; stop at first CentralForest state. No tutorial choice or visual acceptance.'))
                return
            after = loaded_travel(travel)
            movement_ready(after)
            for component in ['player', 'body', 'door']:
                assert all(after[component][k] == original[component][k] for k in ['id', 'path']), 'Route identity changed'
            start = list(map(float, before[-1]['bodyPosition'].split(',')))
            end = list(map(float, after['body']['position'].split(',')))
            delta = [b-a for a,b in zip(start,end)]
            axis = 0 if direction == 'left' else 1
            assert delta[axis] < -.02 and abs(delta[1-axis]) < .08, 'Blocked or unexpected displacement; no repeat'
            expected = '-1,0,0' if direction == 'left' else '0,-1,0'
            assert any(r['actionAxes'] == expected and r['fullAxis'] == expected for r in rows), 'No original directional ingress'
            assert any(float(r['bodyVelocity'].split(',')[axis]) < -.01 for r in rows if r['bodyVelocity'] != 'null'), 'No original directional velocity'
            report.update(result='original movement/release observed; continue from changed geometry',
                          startBodyPosition=start, endBodyPosition=end, displacement=delta)
            write(prefix + '-pulse.json', report)
            pulses.append(report)
            write('natural-route.json', dict(result='in-progress', pulses=pulses, spentMilliseconds=spent))
            loaded = after
        finally:
            if posted and not released:
                recovery = subprocess.run([str(RUN / 'target_keyboard'), str(RUN), 'release-' + direction, str(identity['pid'])], capture_output=True, text=True, timeout=10)
                write(prefix + '-recovery.json', dict(exitCode=recovery.returncode, stdout=recovery.stdout, stderr=recovery.stderr,
                    boundary='UP for this exact task DOWN only; posting does not prove delivery'))
                if not sampling:
                    command('sample-keyboard-start'); sampling = True
                time.sleep(.5)
                recovered = keyboard_samples()
                write(prefix + '-recovery-observation.json', dict(released=len(recovered)>=2 and all(input_released(r) for r in recovered[-2:])))
            if sampling:
                command('sample-keyboard-stop')
                shutil.copy2(RUN / 'keyboard-samples.txt', RUN / (prefix + '-failure-samples.txt'))
    raise AssertionError('Source-backed route pulse count exhausted; no blind continuation')


def main():
    global RUN, GAME, EXE, LAUNCHER
    options = launch_options(sys.argv[1:])
    RUN = options.run.resolve()
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
    budget = None
    try:
        with (RUN / 'wine.log').open('wb') as log:
            child = subprocess.Popen(args, cwd=GAME, stdout=log, stderr=subprocess.STDOUT,
                                     start_new_session=True, env=startup_environment(options.startup_diagnostics))
        LAUNCHER = child
        write('launch.json', {'pid': child.pid, 'command': args,
                             'canonicalHeadAtLaunch': subprocess.check_output(['git', '-C', str(RUN.parents[2]), 'rev-parse', 'HEAD'], text=True).strip(),
                             'launchedAt': datetime.now(timezone.utc).isoformat(),
                             'startupDiagnostics': options.startup_diagnostics,
                             'environmentOverrides': dict(STARTUP_TRACE_ENV) if options.startup_diagnostics else {},
                             'snapshots': {name: sha(RUN / name) for name in
                                           ['diagnose_newgame.py', 'command.py', 'build.json', 'bridge-build.json', 'input-pins.json', 'intro-graph.json', 'frozen-files.json']},
                             'scope': 'Original New/source-bound145 intro, two loaded idle Player/door pair samples, then source-backed bounded process-targeted left/down route to natural CentralForest entry; no screenshots or forced eligibility'})
        wait_for_ready(child)
        (RUN / 'actions.log').touch(exist_ok=True)
        observe_focus_boundary('ready', force=True)
        command('show-menu')
        command('dump')
        state = read_state()
        assert state['scene'] == 'StartMenu' and state['company'] == 'VNRevivalQA' and state['product'] == 'ForestRuRendererProbe'
        assert state['dataPath'].replace('\\', '/').endswith('/' + RUN.name + '/game/' + DATA)
        shutil.copy2(RUN / 'state.json', RUN / 'main-menu.json')
        observe_original_menu()
        observe_focus_boundary('menu-before-New', force=True)
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
        graph = json.loads((RUN / 'intro-graph.json').read_text())
        assert graph['conversationId'] == 145
        assert graph['wrapper']['conversationId'] == 109
        assert graph['wrapper']['bootstrapEntries'] == [0, 5, 8]
        assert graph['wrapper']['narrativeDbName'] == 'NewGame_Intro'
        entries = {e['id']: e for e in graph['entries']}
        budget = IntroObservationBudget(time.monotonic())
        command('menu PlayMenu OnClickStart', deadline=budget.deadline)
        observations = []
        seen_dialogue = set()
        previous = None
        observed_transitions = []
        submitted_responses = []
        submitted_continues = []
        last_action_key = None
        same_action_count = 0
        while True:
            budget.check(time.monotonic())
            command('dump-intro', deadline=budget.deadline)
            state = decode_state(json.loads((RUN / 'intro-state.json').read_text()))
            assert state['company'] == 'VNRevivalQA' and state['product'] == 'ForestRuRendererProbe'
            assert state['dataPath'].replace('\\', '/').endswith('/' + RUN.name + '/game/' + DATA)
            guards, action, terminal_pair = budget.observe(time.monotonic(), state, graph, seen_dialogue)
            observe_focus_boundary('intro')
            key = (state['scene'], state['conversationActive'], state['conversationId'], state['entryId'])
            observations.append({'elapsed': round(time.monotonic() - started, 3),
                                 'scene': key[0], 'conversationActive': key[1],
                                 'conversationId': key[2], 'entryId': key[3], 'typing': state['typing'],
                                 'narrativeDbName': state['narrativeDbName'], 'narrativeArcName': state['narrativeArcName'],
                                 'responses': state['responses'],
                                 'guards': guards, 'frame': state['frame'], 'realtime': state['realtime'],
                                 'scaledTime': state['scaledTime'], 'timeScale': state['timeScale'],
                                 'cleanupDiagnostics': state['introDiagnostics'],
                                 'budget': budget.receipt(time.monotonic())})
            write('newgame-observations.json', observations)
            write('intro-observation-budget.json', budget.receipt(time.monotonic()))
            if terminal_pair:
                break
            if state['conversationActive'] and action is None:
                # Original wrapper/bootstrap and empty metadata must progress themselves.
                previous = None
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
                command(action, deadline=budget.deadline)
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
            else:
                previous = None
            budget.check(time.monotonic())
            time.sleep(min(.3 if state['conversationActive'] else 1,
                           max(0, budget.deadline-time.monotonic())))
        write('newgame-state.json', state)
        write('intro-progression.json', {'conversationId': 145, 'seenEntries': sorted(seen_dialogue),
              'observedTransitions': observed_transitions, 'finalScene': state['scene'], 'guards': guards,
              'submittedResponses': submitted_responses,
              'observationBudget': budget.receipt(time.monotonic()),
              'cleanupBoundary': 'Original Cutscene_IntroBunnyHouse fired, all intro controllers destroyed, exactly one active original bed interaction; two consecutive guarded observations',
              'inputBoundary': 'Original Continue and sole source-bound response Button.onClick on active145 entries; no OS keyboard/controller delivery or forced story state'})
        command('dump-notebook')
        shutil.copy2(RUN / 'notebook-route.json', RUN / 'newgame-notebook.json')
        command('dump-tutorial')
        shutil.copy2(RUN / 'tutorial-route.json', RUN / 'newgame-tutorial.json')
        loaded = observe_loaded_travel()
        natural_doorway_route(loaded[-1])
        print('Original intro completed in', state['scene'], guards, flush=True)
        success = True
    except BaseException as ex:
        error = repr(ex)
        if budget is not None:
            write('intro-observation-budget.json', dict(budget.receipt(time.monotonic()), error=error))
    finally:
        if LAUNCHER is not None:
            observe_lifetime('observer-finally')
        owned = processes()
        if owned and COMMAND_HOLD is None and not (RUN / 'command.txt').exists():
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
        if LAUNCHER is not None:
            observe_lifetime('after-cleanup-wait')
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
                               'quitAcknowledged': quit_ok, 'unresolvedCommand': COMMAND_HOLD,
                               'originalAssetsAndPlayerFilesUnchanged': unchanged,
                               'originalAssemblyRestoredInQACopy': restored, 'inspectionBridgeRemoved': not (managed / 'ForestProbe.dll').exists(),
                               'inputPinsUnchanged': pins_ok, 'candidateAssetHashesUnchanged': all(sha(GAME / DATA / r['path']) == r['probeSha256'] for r in report['files']),
                               'ownerSavePathUsed': False})
        write('runtime-result.json', {'result': 'passed' if success and clean else 'failed', 'error': error,
                                      'durationSeconds': round(time.monotonic() - started, 3), 'imagesCaptured': 0,
                                      'imagesOpened': 0, 'scope': 'Original New/source-bound145 intro through delayed cleanup, loaded root/door pair observations and guarded original left/down movement to natural CentralForest entry',
                                      'inventoryRuntime': 'not-run', 'visual': 'not-run'})
    assert success and clean, error


def retain_observer_exit(run, child_argv):
    """Do not infer a dead detached observer's status; wait for our actual child."""
    path = run / 'observer-exit.json'
    assert not path.exists(), 'Existing observer status; reconcile before submission'
    with (run / 'observer.stdout').open('xb') as stdout, (run / 'observer.stderr').open('xb') as stderr:
        child = subprocess.Popen(child_argv, stdout=stdout, stderr=stderr)
        (run / 'observer-child.json').write_text(json.dumps(dict(observerPid=child.pid,
            wrapperPid=os.getpid(), argv=child_argv, returnCode=None), indent=2)+'\n')
        code = child.wait()
    path.write_text(json.dumps(dict(observerPid=child.pid, returnCode=code,
        waitStatusSource='subprocess.Popen.wait on exact task-owned child',
        boundary='OS observer status only; runtime-result/cleanup define game acceptance'), indent=2)+'\n')
    return code


if __name__ == '__main__':
    options = launch_options(sys.argv[1:])
    if options.retain_exit:
        run = options.run.resolve()
        assert Path(__file__).resolve().parent == run, 'Supervise only the immutable task snapshot'
        code = retain_observer_exit(run, [sys.executable, str(Path(__file__).resolve())] +
                                    [x for x in sys.argv[1:] if x != '--retain-exit'])
        sys.exit(code if code >= 0 else 128-code)
    main()
