#!/usr/bin/env python3
"""Follow original New/intro or exact QA43 save through ordinary Continue.

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
import tempfile
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
    parser.add_argument('--continue-fixture', action='store_true',
                        help='Admit only the frozen QA43 fixture and use original Continue; never fall back to New')
    parser.add_argument('--tutorial-choice-mode', choices=['original', 'synthetic'], default='original',
                        help='Explicit two-value synthetic choice admission; requires Continue and matching compiled bridge/resources')
    parser.add_argument('--tutorial181', action='store_true',
                        help='Exact original181 selection and source route through187/cleanup; no menu capture')
    args = parser.parse_args(argv)
    assert args.tutorial_choice_mode == 'original' or args.continue_fixture, 'Synthetic choices require exact QA43 Continue'
    assert not args.tutorial181 or (args.continue_fixture and args.tutorial_choice_mode == 'original'), 'Tutorial181 requires original QA43 Continue'
    return args


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


def observe_lifetime(boundary, value=None, process_sample=None, **extra):
    """Retain launcher wait status separately from non-child game presence.

    A ps sample proves presence/absence at its own time, never a game exit code.
    No foreground observation, process signal or policy change occurs here.
    """
    assert LAUNCHER is not None, 'Missing exact launcher handle; hold commands'
    began = time.monotonic()
    if process_sample is None:
        rows = processes()
        sampled = time.monotonic()
        sample = dict(started=began, completed=sampled, reused=False)
    else:
        # communicate() already reaped this exact successful helper before the
        # transport-returned check. No wait/signal follows it on this path.
        # Retain that sample's time; never label reused rows as fresh evidence.
        assert boundary == 'transport-reaped' and process_sample['boundary'] == 'transport-returned'
        assert process_sample['command'] == value and process_sample['launcherPid'] == LAUNCHER.pid
        assert process_sample['transportPid'] == extra['transportPid'] and extra['transportExitCode'] == 0
        assert not extra['transportStoppedByObserver'] and COMMAND_HOLD is None
        rows = process_sample['ownedProcessRows']
        sample = dict(process_sample['processSample'], reused=True,
                      sourceBoundary='transport-returned', sourceMonotonic=process_sample['monotonic'])
    pending = RUN / 'command.txt'
    event = dict(utc=datetime.now(timezone.utc).isoformat(), monotonic=time.monotonic(),
                 boundary=boundary, command=value, launcherPid=LAUNCHER.pid,
                 launcherExitCode=LAUNCHER.poll(), gameExitCode=None,
                 ownedProcessRows=rows, realGameRows=real_game_rows(rows),
                 pendingCommand=pending.exists(), unresolvedCommand=COMMAND_HOLD,
                 processSample=sample, **extra)
    try:
        raw = pending.read_bytes()
    except FileNotFoundError:
        event['pendingCommand'] = False
    else:
        event['pendingCommand'] = True
        event['pendingCommandSha256'] = hashlib.sha256(raw).hexdigest()
    # Ends before the append itself; it is not a measurement of disk flush time.
    event['hostBeforeAppendMonotonic'] = time.monotonic()
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
    # File captures let an already exited child be consumed without waiting on
    # pipe EOF or losing stdout accumulated by an earlier communicate timeout.
    with tempfile.TemporaryFile(mode='w+t') as output, tempfile.TemporaryFile(mode='w+t') as errors:
        sender = subprocess.Popen([sys.executable, str(RUN / 'command.py'), str(RUN), value],
                                  stdout=output, stderr=errors, text=True)
        stopped = False
        completed_sample = None
        completed_at_expired_boundary = False
        try:
            while True:
                remaining = expires - time.monotonic()
                if remaining <= 0:
                    # Bookkeeping after a timed wait can cross the deadline
                    # while this exact child finishes. Poll only: no extra wait,
                    # submission or renewal of the independent story budget.
                    if sender.poll() is None:
                        raise TimeoutError('Command deadline; outcome unknown, reconcile before resubmitting: ' + value)
                    completed_at_expired_boundary = True
                    break
                try:
                    sender.communicate(timeout=min(.25, remaining))
                    break
                except subprocess.TimeoutExpired:
                    state = observe_lifetime('await-ack', value, transportPid=sender.pid)
                    # Quit can legitimately remove its game before the helper reads
                    # the final ACK. Every other action must retain a unique game.
                    assert value == 'quit' or len(state['realGameRows']) == 1, \
                        'Real task game absent or ambiguous while awaiting acknowledgement; outcome unknown, no replay: ' + value
            output.seek(0)
            errors.seek(0)
            stdout, stderr = output.read(), errors.read()
            state = observe_lifetime('transport-returned', value, transportPid=sender.pid,
                                     transportExitCode=sender.returncode,
                                     completedResultCollectedAtExpiredBoundary=completed_at_expired_boundary,
                                     transportStdout=stdout[-500:], transportStderr=stderr[-500:])
            assert sender.returncode == 0, \
                'Nonzero transport exit; outcome unknown, reconcile before resubmitting: ' + repr((value, sender.returncode, stdout[-500:], stderr[-500:]))
            lines = stdout.splitlines()
            assert lines and lines[0].partition(' OK ')[0] and lines[0].partition(' OK ')[2] == value, \
                'Missing exact transport acknowledgement; outcome unknown, reconcile before resubmitting: ' + value
            assert value == 'quit' or len(state['realGameRows']) == 1, \
                'Command acknowledged but real task game absent or ambiguous after receipt: ' + value
            COMMAND_HOLD = None
            completed_sample = state
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
                             transportExitCode=sender.returncode, transportStoppedByObserver=stopped,
                             process_sample=completed_sample if not stopped else None)
    return dict(command=value, acknowledgement=lines[0], transportPid=sender.pid,
                transportExitCode=sender.returncode, submittedAt=before['monotonic'],
                acknowledgedAt=state['monotonic'])


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
    began = time.monotonic()
    command('dump-focus')
    command_returned = time.monotonic()
    trace = focus_trace_latest(json.loads((RUN / 'focus-trace.json').read_text()))
    native_started = time.monotonic()
    result = subprocess.run([str(RUN / 'target_keyboard'), str(RUN), 'observe'],
                            capture_output=True, text=True, timeout=10)
    native_returned = time.monotonic()
    try:
        native = json.loads(result.stdout) if result.returncode == 0 else None
    except (ValueError, TypeError):
        native = None
    rows.append(dict(label=label, hostBefore=before, hostAfter=time.time(), bridge=trace,
        native=native, helperExitCode=result.returncode, helperStdout=result.stdout, helperStderr=result.stderr,
        hostTiming=dict(started=began, commandReturned=command_returned, nativeStarted=native_started,
                        nativeReturned=native_returned, beforeAppend=time.monotonic())))
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


BUCKY_ACTOR = 'SpawnedContent/Critters/Bucky/Content/BuckyOnNorthShore(Clone)'
BUCKY_PLAYER = 'SpawnedContent/Player/Content/Player(Clone)'


def bucky_interaction_guard(sample, state):
    """Read-only ordinary admission. Call only with fresh real bridge samples.

    No native action is wired here yet. Cached Talk cannot prove selected141;
    the eventual host must observe the original dispatch separately.
    """
    qa_identity(sample)
    qa_identity(state)
    assert sample['choiceMode'] == 'original', 'Bucky requires original mode'
    assert sample['scene'] == state['scene'] == 'CentralForest', 'Bucky scene differs'
    assert all(sample[k] == state[k] for k in ['dataPath', 'persistentDataPath']), 'Bucky process/save identity differs'
    assert continue_diagnostic_ready(state), 'Bucky dependencies not ready'
    assert type(sample['frame']) is type(state['frame']) is int and 0 < sample['frame'] <= state['frame'] <= sample['frame'] + 120, 'Stale Bucky frame'
    assert all(math.isfinite(x) and x >= 0 for x in [sample['realtime'], state['realtime']]) and 0 <= state['realtime'] - sample['realtime'] <= 2, 'Stale Bucky time'
    assert state['conversationActive'] is False and not state['responses'] and not state['narrativeDbName'] and not state['narrativeArcName'], 'Bucky conversation/menu already active'
    rows = sample['diagnostics']
    result = {key: diagnostic_fields(rows, 'bucky' + key.title()) for key in [
        'guards', 'actor', 'controller', 'trigger', 'settings', 'ui', 'bindings', 'collision', 'enter', 'stay', 'exit', 'player']}
    assert result['guards'] == dict(gameplay='True', anyEvent='False', conversation='False'), 'Bucky gameplay/event guards differ'
    for key, typename, path in [('actor', 'Gameplay.CritterActor', BUCKY_ACTOR),
            ('controller', 'InteractionUiController', BUCKY_ACTOR + '/Interaction/InteractionUiController'),
            ('trigger', 'Interaction.DialogueInteractionTrigger', BUCKY_ACTOR + '/Interaction/DialogueTrigger'),
            ('settings', 'DialogueSettings', BUCKY_ACTOR + '/Interaction/DialogueTrigger'),
            ('collision', 'CollisionEventListener', BUCKY_ACTOR + '/Interaction/InteractionArea'),
            ('player', 'Player', BUCKY_PLAYER), ('ui', 'InteractionUi', None)]:
        row = result[key]
        assert row['type'] == 'TheForestOfLove.' + typename and (row['path'] == path if path else bool(row['path'])), 'Bucky exact type/path differs: ' + key
        assert row['active'] == row['enabled'] == 'True' and int(row['id']) != 0, 'Bucky inactive/invalid component: ' + key
    assert result['actor']['dbName'] == 'Bucky', 'Bucky actor differs'
    assert all(result['bindings'].get(k) == 'True' for k in ['actor', 'listener', 'actorParent', 'settingsObject',
        'controllerDescendant', 'triggerDescendant', 'listenerDescendant']), 'Bucky original bindings differ'
    for key in ['controller', 'trigger']:
        row = result[key]
        assert int(row['authorityId']) == int(row['gameObject']) != 0 and row['gameObject'] != row['id'], 'Bucky GameObject authority differs: ' + key
        assert row['touching'] == 'True', 'Bucky natural touch missing: ' + key
    controller, trigger, ui, collision, player = [result[k] for k in ['controller', 'trigger', 'ui', 'collision', 'player']]
    assert controller['gameObject'] != trigger['gameObject'], 'Bucky authority stores conflated'
    assert 'Talk' in controller['available'].split(',') and 'Talk' not in controller['disallowed'].split(','), 'Bucky cached Talk unavailable/disallowed'
    assert all(trigger.get(k) == v for k, v in dict(mode='0', triggered='False', cooldown='0', blocked='False',
        onCollision='False', withoutUi='False', namedTrigger='', maxTimes='0').items()), 'Bucky trigger mode/ordinary guards differ'
    assert tuple(result['settings'][k] for k in ['actor', 'dialogue', 'arc']) == ('Bucky', '- Untagged -', ''), 'Bucky inferred settings differ'
    assert all(ui.get(k) == v for k, v in dict(activeCount='1', visible='True', locked='True', selected='0').items()) and 'Talk' in ui['available'].split(','), 'Bucky shared UI/selected Talk differs'
    callback = controller['path'] + '#' + controller['id'] + '::TheForestOfLove.InteractionUiController::'
    assert ui['callbacks'] == callback + 'OnInterationOptionSelected', 'Bucky option listener differs'
    trigger_callback = trigger['path'] + '#' + trigger['id'] + '::TheForestOfLove.Interaction.DialogueInteractionTrigger::'
    for key, suffix, include_trigger in [('enter', 'OnTriggerEnter2D', True), ('stay', 'OnTriggerStay2D', False), ('exit', 'OnTriggerExit2D', True)]:
        expected = [callback + suffix] + ([trigger_callback + suffix] if include_trigger else [])
        assert result[key] == dict(persistent='0', callbacks=','.join(sorted(expected))), 'Bucky collision listener differs: ' + key
    assert all(collision.get(k) == v for k, v in dict(colliderType='UnityEngine.CapsuleCollider2D', colliderCount='1',
        colliderEnabled='True', isTrigger='True', rootTouch='True', ignoredPair='False').items()), 'Bucky actual collider/contact differs'
    for key, expected in [('size', [1, .6, 0]), ('offset', [0, .21, 0]), ('scale', [1, 1, 1])]:
        values = list(map(float, collision[key].split(',')))
        assert len(values) == 3 and all(math.isfinite(a) and abs(a-b) < .0001 for a, b in zip(values, expected)), 'Bucky collider geometry differs'
    assert all(player.get(k) == v for k, v in dict(canInteract='True', bodyType='Dynamic', bodySimulated='True',
        rootColliderEnabled='True', rootIsTrigger='False', rootTag='Player', velocity='0,0,0').items()), 'Bucky root Player not idle/eligible'
    assert all(int(row[key]) != 0 for row, key in [(player, 'body'), (player, 'rootCollider'), (collision, 'collider')]), 'Bucky physics identity missing'
    return result


def bucky_submit_map_guard(row):
    """Retain original movement/focus guards; additionally pin gameplay action2."""
    original_keyboard_guard(row)
    maps = json.loads(row['keyboardMaps'])['maps']
    gameplay_map = next(m for m in maps if m['source'] == 0)
    bindings = gameplay_map['submit']
    assert sorted((b['action'], b['key'], b['pole']) for b in bindings) == [(2, 13, 0), (2, 32, 0), (2, 305, 0), (2, 306, 0)], 'Bucky original gameplay Submit bindings differ'
    assert all(b['enabled'] is True and b['invert'] is False and all(b[k] == v for k, v in dict(
        type=1, range=0, modifier1=0, modifier2=0, modifier3=0).items()) for b in bindings), 'Bucky Submit binding flags differ'
    assert all(not any(b['action'] == 2 for b in m['submit']) for m in maps if m['source'] != 0), 'Bucky gameplay Submit rebound'


def bucky_input_released(row):
    """All twelve original movement/action keys plus action2 and both axes idle."""
    bucky_submit_map_guard(row)
    return input_released(row) and all(row.get(layer + 'SubmitUp') == 'True' and
        row.get(layer + 'SubmitDown') == row.get(layer + 'MovementDown') == '' for layer in ['native', 'async', 'rewired', 'unity']) and all(
        row.get(k) == 'False' for k in ['rewiredAction2Held', 'rewiredAction2Down', 'helperSubmitDown', 'unityReturnDown'])


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


FIXTURE_SHA256 = '4ff9760850d3d2aa20ceae44a20696c4a5aab3daf59a3ba00fdd3ec4f72b2d36'


def admit_session(game, run, use_continue):
    """Default New stays file-free; Continue admits only exact frozen QA43 bytes."""
    if not use_continue:
        assert not list(game.rglob('tfol.*')), 'New forbids every existing player file'
        return None
    # Import from this observer's own frozen directory, never a live checkout helper.
    sys.path.insert(0, str(Path(__file__).resolve().parent))
    from save_fixture import expectations, candidate_files
    fixture = expectations(run / 'qa-fixture/manifest.json', FIXTURE_SHA256)
    candidate_files(game, fixture['files'])
    return fixture


def qa_identity(state):
    assert state['company'] == 'VNRevivalQA' and state['product'] == 'ForestRuRendererProbe', 'Unexpected QA identity'
    assert state['dataPath'].replace('\\', '/').endswith('/' + RUN.name + '/game/' + DATA), 'Unexpected QA DataPath'


def vector_matches(actual, expected):
    return set(actual) == set(expected) == {'x', 'y', 'z'} and all(
        math.isfinite(actual[k]) and abs(actual[k] - expected[k]) <= .00001 for k in expected)


def loaded_fixture_guard(state, fixture):
    """Original loaded data at the menu, before any Continue submission."""
    qa_identity(state)
    assert state['scene'] == 'StartMenu' and state['hasSavedPlaySession'] is True, 'Original saved session not loaded at menu'
    assert all(state[k] is False for k in ['isChapterSelect', 'isCheatCode', 'isFinishingSoftReset',
                                         'gameplay', 'anyEvent', 'conversation', 'playerPresent']), 'Unexpected saved menu flags'
    assert state['currentArea'] == 'CentralForest' and state['lastArea'] == 'BunnyHouse', 'Loaded saved areas differ'
    respawn = fixture['playerRespawnData']
    for key in ['lastPosition', 'lastSpawnPosition']:
        assert vector_matches(state[key], respawn[key]), 'Loaded saved vector differs: ' + key
    for key in ['lastPositionExact', 'isSwimming', 'isFastTraveling', 'cameraSettingsObjectName']:
        assert state[key] == respawn[key], 'Loaded saved field differs: ' + key
    general = fixture['generalData']
    assert math.isfinite(state['storyClock']) and abs(state['storyClock'] - general['storyClock']) <= .00001, 'Loaded story clock differs'
    assert all(state[k] == general[k] for k in ['finishedControlTutorial', 'finishedDialogueTutorial', 'finishedGossipTutorial']), 'Loaded tutorial completion differs'
    assert state['introStatus'] == 200 and state['tutorialIntroControllers'] == 0, 'Loaded intro state differs'
    rows = state['diagnostics']
    assert diagnostic_fields(rows, 'activeTags') == {'values': 'Tag(Main),Tag(Main Act 1)'}, 'Loaded tags differ'
    expected_rows = [
        'trigger | name=Cutscene_IntroBunnyHouse | count=1',
        'quest | name=Act1_TutorialQuest | status=0 | enableWithTags=Tag(Main) | disableWithTags=',
        'questDialogue | name=TutorialQuest_IntroFromBunny | actor=Scarlett | initialActor=Scarlett | status=0 | conversation=120 | type=Quest | first=True | last=False',
        'primaryArc | dialogue=TutorialQuest_IntroFromBunny | suffix=p1 | status=0 | entry=153']
    assert all(rows.count(row) == 1 for row in expected_rows), 'Loaded intro/tutorial records differ'


def continue_menu_guard(state):
    qa_identity(state)
    assert state['scene'] == 'StartMenu' and 'PlayMenu Canvas/PlayMenu' in state['components'], 'Original Play menu not active'
    assert state['buttons'].count('Canvas/PlayMenu/Controls/Continue') == 1, 'Exact original Continue control unavailable'


SYNTHETIC_CHOICES = {
    159: 'Ёж Йй Щъ Ыь Эю Яя; 123 — Latin!',
    181: 'Е\u0308 и\u0306; ё й. Съешь ещё этих булок!',
}


def tutorial_choice_text(eid, prefix, choice_mode):
    assert choice_mode in ['original', 'synthetic'], 'Unknown tutorial choice mode'
    assert eid in [159, 181], 'Unapproved tutorial choice ID'
    return (SYNTHETIC_CHOICES[eid] if choice_mode == 'synthetic' else
            next(e['text'] for e in prefix['entries'] if e['id'] == eid))


def choice_renderer_guard(state, prefix, choice_mode):
    if choice_mode != 'synthetic':
        return []
    tutorial_action(state, prefix, choice_mode)
    rows = [r for r in state['rendererDiagnostics'] if '/Response Text | UnityEngine.UI.Text | ' in r]
    assert len(rows) == 2, 'Expected two actual loaded choice labels'
    for eid in [159, 181]:
        text = tutorial_choice_text(eid, prefix, choice_mode)
        label = TUTORIAL_TEXT_PANEL + '/Response Menu Panel/Viewport/Content/Response: ' + text + '/Response Text'
        matches = [r for r in rows if r.startswith(label + ' | UnityEngine.UI.Text | ' + text + ' | ')]
        assert len(matches) == 1, 'Choice renderer identity/text differs'
        fields = dict(part.split('=', 1) for part in matches[0].split(' | ')[3:])
        assert fields['font'] == 'MatchupPro_TFOL' and fields['fontNames'] == 'Liberation Sans' and fields['dynamic'] == 'True', 'Choice runtime font/face differs'
        assert fields['size'] == '12' and fields['style'] == 'Normal', 'Choice runtime size/style differs'
        assert all(fields[k] == 'True' for k in ['hasYo', 'hasShortI', 'hasDigit1', 'hasSpace', 'hasDiaeresis', 'hasBreve']), 'Choice individual glyph availability differs'
    return rows


def admit_choice_mode(run, choice_mode):
    assert choice_mode in ['original', 'synthetic'], 'Unknown tutorial choice mode'
    build = json.loads((run / 'build.json').read_text())
    bridge = json.loads((run / 'bridge-build.json').read_text())
    assert bridge.get('tutorialChoiceMode', 'original') == choice_mode, 'Compiled tutorial choice mode differs'
    if choice_mode == 'synthetic':
        assert build['sampleSurface'] == 'tutorial-choices' and build['coherentChoiceFace'] is True, 'Synthetic choice resource surface differs'
        assert build['choiceSamples'] == {str(k): v for k, v in SYNTHETIC_CHOICES.items()}, 'Synthetic choice resource values differ'
    else:
        assert not build.get('choiceSamples'), 'Original mode forbids synthetic choice resources'


def tutorial_action(state, prefix, choice_mode='original'):
    """Finish158 via its exact original control; never select159/181."""
    assert choice_mode in ['original', 'synthetic'], 'Unknown tutorial choice mode'
    if not state['conversationActive']:
        return None
    assert state['narrativeDbName'] == 'TutorialQuest_IntroFromBunny' and state['narrativeArcName'] in [None, ''], 'Unexpected restored narrative binding'
    if state['conversationId'] == 109:
        assert state['entryId'] in [0, 5, 8] and not state.get('conversationState'), 'Unexpected tutorial wrapper content'
        return None
    assert state['conversationId'] == prefix['conversation'] == 120, 'Unexpected tutorial conversation'
    assert state['entryId'] in range(153, 159), 'Stop before unapproved tutorial choice'
    entry = next(e for e in prefix['entries'] if e['id'] == state['entryId'])
    # [pic=N] is a source portrait directive, absent from the formatted subtitle.
    text = entry['text']
    if text.startswith('[pic='):
        text = text.split(']', 1)[1]
    assert state['conversationState'] == text, 'Tutorial subtitle differs from exact source'
    responses = [r for r in state['responses'] if r['visible'] and r['clickable']]
    links = entry['outgoingLinks']
    if state['entryId'] == 158:
        tutorial_completion_guard(state, prefix, choice_mode)
        if state['typing']:
            return None
        if not state['responses']:
            return 'complete-tutorial158'
        assert len(responses) == len(state['responses']), 'Tutorial choice control not visible/clickable'
        assert len(responses) == 2 and {r['entryId'] for r in responses} == {159, 181}, 'Tutorial choice set differs'
        for row in responses:
            assert (row['conversationId'] == 120 and row['targetPath'] == TUTORIAL_UI and row['text'] == tutorial_choice_text(row['entryId'], prefix, choice_mode)
                    and row['path'] == TUTORIAL_TEXT_PANEL + '/Response Menu Panel/Viewport/Content/Response: ' + tutorial_choice_text(row['entryId'], prefix, choice_mode)), 'Tutorial choice binding/text differs'
        return 'target-settled'
    assert len(links) == 1 and links[0]['destinationConversationID'] == 120 and links[0]['destinationDialogueID'] == state['entryId'] + 1, 'Tutorial linear source changed'
    if responses:
        assert len(responses) == 1, 'Unexpected tutorial response branch'
        row = responses[0]
        target = next(e for e in prefix['entries'] if e['id'] == state['entryId'] + 1)
        assert row['conversationId'] == 120 and row['entryId'] == target['id'] and row['text'] == target['text'] and row['targetPath'], 'Tutorial sole response differs'
        return 'response %s 120 %s' % (state['entryId'], target['id'])
    return 'continue-bound 120 ' + str(state['entryId'])


TUTORIAL_UI = 'Singletons/GlobalSingletonsFirstpass(Clone)/DialogueManager/OverworldDialogueCanvas/VN Template Standard Dialogue UI'
TUTORIAL_TEXT_PANEL = TUTORIAL_UI + '/Dialogue Panel/Text Panel'


def tutorial_completion_guard(state, prefix, choice_mode='original'):
    entries = {e['id']: e for e in prefix['entries']}
    entry = entries[158]
    assert len(entry['outgoingLinks']) == 2 and {
        (r['originConversationID'], r['originDialogueID'], r['destinationConversationID'], r['destinationDialogueID'])
        for r in entry['outgoingLinks']} == {(120,158,120,159), (120,158,120,181)}, 'Tutorial158 source destinations differ'
    assert all(r['isConnector'] == 0 and r['priority'] == 2 for r in entry['outgoingLinks']), 'Tutorial158 source link policy differs'
    for eid, text, actor, conversant in [(158, '[pic=3]So tell me. What is it you’re here for?', '2','1'),
            (159,'Well… uhh… You see…','1','2'), (181,'The love. Definitely the love.','1','2')]:
        e = entries[eid]
        assert (e['text'],e['actor'],e['conversant']) == (text,actor,conversant), 'Tutorial158 source text/actors differ'
        assert all(e[k] == '' for k in ['menuText','conditions','script','sequence','responseMenuSequence']), 'Tutorial158 source conditions differ'
        assert e['onExecute']['m_PersistentCalls']['m_Calls'] == [], 'Tutorial158 source callbacks differ'
    record = state.get('tutorialCompletionRecord')
    assert isinstance(record, str) and record, 'Missing native Tutorial158 completion evidence'
    row = json.loads(record)
    assert (row['frame'],row['conversationId'],row['entryId'],row['text'],row['sourceText']) == (
        state['frame'],120,158,state['conversationState'],entry['text']), 'Stale/wrong Tutorial158 completion evidence'
    assert row.get('choiceMode', 'original') == choice_mode, 'Native tutorial choice mode differs'
    assert row['typing'] is state['typing'] and row['menuPresent'] is bool(state['responses']), 'Tutorial158 completion/menu disagreement'
    assert row['graphVerified'] is True and row['sourceDestinations'] == row['pcDestinations'] == '120:159,120:181', 'Tutorial158 native destinations differ'
    assert (row['panelPath'],row['buttonPath'],row['textPath'],row['targetPath'],row['listenerMethod'],row['listenerTargetPath']) == (
        TUTORIAL_TEXT_PANEL+'/Subtitle Panel 0',TUTORIAL_TEXT_PANEL+'/Continue Button',TUTORIAL_TEXT_PANEL+'/Subtitle Text',
        TUTORIAL_UI,'OnFastForward',TUTORIAL_TEXT_PANEL+'/Continue Button'), 'Tutorial158 original control differs'
    assert all(type(row[k]) is int and row[k] != 0 for k in ['panelInstance','buttonInstance','textInstance']), 'Tutorial158 control identity missing'
    if not row['menuPresent']:
        assert all(row[k] is True for k in ['buttonActive','buttonEnabled','buttonInteractable']), 'Tutorial158 Continue unavailable'
    return row


class TutorialTransitions:
    """Observed subtitles and acknowledged response selections are separate evidence.

    Original response consumption can pass through a PC destination before another
    host sample. Only a fresh exact ACK authorizes its one source-linked successor.
    This bookkeeping never renews a budget or submits/replays an action.
    """
    def __init__(self, prefix, choice_mode='original'):
        assert choice_mode in ['original', 'synthetic'], 'Unknown tutorial choice mode'
        self.choice_mode = choice_mode
        self.prefix = prefix
        self.entries = {e['id']: e for e in prefix['entries']}
        assert len(self.entries) == len(prefix['entries']), 'Duplicate tutorial source IDs'
        self.previous = self.observed_frame = self.observed_at = None
        self.pending = None
        self.observed = []
        self.transitions = []
        self.responses = []
        self.completion = None

    def successor(self, entry):
        links = self.entries[entry]['outgoingLinks']
        assert len(links) == 1, 'Expected sole tutorial source successor'
        link = links[0]
        assert (link['originConversationID'], link['originDialogueID'],
                link['destinationConversationID']) == (self.prefix['conversation'], entry, self.prefix['conversation']), 'Tutorial source link binding differs'
        target = link['destinationDialogueID']
        assert target in self.entries and target in range(153, 159), 'Successor leaves approved tutorial prefix'
        return target

    def observe(self, state, now):
        tutorial_action(state, self.prefix, self.choice_mode)  # Exact text, binding, controls and choice stop.
        if not state['conversationActive'] or state['conversationId'] != self.prefix['conversation']:
            assert self.previous is None, 'Tutorial left prefix after it started'
            return
        entry = state['entryId']
        if self.previous is None:
            assert entry == 153, 'Tutorial prefix did not start at153'
        elif self.pending is not None:
            selected = self.pending
            assert entry in [selected['destination'], selected['successor']], 'Unexpected acknowledged tutorial response transition; no replay'
            self.transitions.append(dict(source=self.previous, selectedResponse=selected['destination'],
                observed=entry, frame=state['frame'], kind='acknowledged-response'))
            self.pending = None
        elif entry != self.previous:
            assert entry == self.successor(self.previous), 'Unexpected tutorial source transition'
            self.transitions.append(dict(source=self.previous, observed=entry,
                                         frame=state['frame'], kind='observed-source-link'))
        self.previous, self.observed_frame, self.observed_at = entry, state['frame'], now
        if entry not in self.observed:
            self.observed.append(entry)

    def acknowledge_response(self, state, action, transport):
        assert tutorial_action(state, self.prefix, self.choice_mode) == action and action.startswith('response '), 'Only an exact sole response may authorize a transition; stop before choices'
        assert self.pending is None, 'Response already acknowledged; no replay'
        assert (state['entryId'], state['frame']) == (self.previous, self.observed_frame), 'Stale tutorial action observation'
        assert isinstance(transport, dict) and transport.get('command') == action and transport.get('transportExitCode') == 0, 'Missing exact response acknowledgement'
        line = transport.get('acknowledgement', '')
        assert line.partition(' OK ')[0] and line.partition(' OK ')[2] == action, 'Missing exact response acknowledgement'
        assert self.observed_at <= transport['submittedAt'] <= transport['acknowledgedAt'], 'Stale response acknowledgement'
        destination = self.successor(state['entryId'])
        assert action == 'response %s %s %s' % (state['entryId'], self.prefix['conversation'], destination), 'Response action differs from source destination'
        assert self.entries[destination]['actor'] == '1', 'Response destination is not the source Player entry'
        record = dict(source=state['entryId'], sourceFrame=state['frame'], destination=destination,
                      successor=self.successor(destination), action=action,
                      response=[dict(r) for r in state['responses'] if r['visible'] and r['clickable']],
                      transport=transport)
        assert not any(r['source'] == record['source'] for r in self.responses), 'Response already acknowledged; no replay'
        self.responses.append(record)
        self.pending = record

    def receipt(self):
        return dict(observedSubtitleEntries=list(self.observed), selectedResponses=self.responses,
                    transitions=self.transitions, pendingResponse=self.pending, completion158=self.completion,
                    boundary='Selected response destinations are not credited as observed subtitles; ACKs do not renew budgets')

    def acknowledge_completion(self, state, action, transport, receipt):
        assert action == 'complete-tutorial158' and tutorial_action(state,self.prefix,self.choice_mode) == action, 'Only exact158 completion is allowed; no terminal choice'
        assert self.completion is None, 'Tutorial158 completion already acknowledged; no replay'
        assert (state['entryId'],state['frame']) == (self.previous,self.observed_frame), 'Stale Tutorial158 action observation'
        assert isinstance(transport,dict) and transport.get('command') == action and transport.get('transportExitCode') == 0, 'Missing exact completion acknowledgement'
        line = transport.get('acknowledgement','')
        assert line.partition(' OK ')[0] and line.partition(' OK ')[2] == action, 'Missing exact completion acknowledgement'
        assert self.observed_at <= transport['submittedAt'] <= transport['acknowledgedAt'], 'Stale completion acknowledgement'
        assert isinstance(receipt,dict) and receipt.get('result') in ['applied','menu-present'], 'Missing native completion receipt'
        expected = tutorial_completion_guard(state,self.prefix,self.choice_mode)
        assert receipt['frame'] >= state['frame'], 'Stale native completion receipt'
        # The native action rereads exact source/control/available responses on the
        # game thread; a menu appearing after sampling is an acknowledged no-op.
        assert receipt.get('choiceMode', 'original') == self.choice_mode, 'Native completion mode differs'
        for k in ['conversationId','entryId','text','sourceText','graphVerified','sourceDestinations','pcDestinations',
                  'panelPath','buttonPath','textPath','targetPath','listenerMethod','listenerTargetPath',
                  'panelInstance','buttonInstance','textInstance']:
            assert receipt[k] == expected[k], 'Native completion binding differs: ' + k
        assert receipt['typing'] is False and receipt['menuPresent'] is (receipt['result']=='menu-present'), 'Native completion outcome differs'
        if receipt['result']=='applied':
            assert all(receipt[k] is True for k in ['buttonActive','buttonEnabled','buttonInteractable']), 'Native Continue unavailable'
        self.completion = dict(sourceFrame=state['frame'],action=action,transport=transport,native=receipt)


TUTORIAL181_ROUTE = [181, 182, 183, 184, 185, *range(163, 181), 186, 187]


def tutorial181_plan_guard(plan):
    assert (plan['conversation'], plan['selectedEntry'], plan['successor'], plan['route']) == (120, 181, 182, TUTORIAL181_ROUTE), 'Tutorial181 source route differs'
    assert plan['sourceTreeSha256'] == '41749d8b093ab438a9fc73519993809cee8b1288c5fbc6fab46782a1b899d69b', 'Tutorial181 original source pin differs'
    entries = {e['id']: e for e in plan['entries']}
    assert len(entries) == len(plan['entries']) and set(entries) == {158, 159, *TUTORIAL181_ROUTE}, 'Tutorial181 source IDs differ'
    for eid in TUTORIAL181_ROUTE:
        e = entries[eid]
        assert (e['actor'], e['conversant']) == (('1', '2') if eid == 181 else ('2', '1')), 'Tutorial181 source actors differ'
        assert e['isGroup'] == 0 and all(e[k] == '' for k in ['menuText', 'sequence', 'responseMenuSequence', 'conditions', 'script']), 'Tutorial181 source controls differ'
        assert e['onExecute']['m_PersistentCalls']['m_Calls'] == [], 'Tutorial181 source callback differs'
        target = TUTORIAL181_ROUTE[TUTORIAL181_ROUTE.index(eid)+1] if eid != 187 else None
        expected = [] if target is None else [dict(originConversationID=120, originDialogueID=eid,
            destinationConversationID=120, destinationDialogueID=target, isConnector=0, priority=2)]
        assert e['outgoingLinks'] == expected, 'Tutorial181 source link differs'
    assert entries[181]['text'] == 'The love. Definitely the love.' and entries[182]['text'] == '[pic=2]Hahaha!', 'Tutorial181 exact branch text differs'
    canonical = json.dumps(plan, ensure_ascii=False, sort_keys=True, separators=(',', ':')).encode()
    assert hashlib.sha256(canonical).hexdigest() == '509dc77480f5594a95b6c5ef60b9b3658ff196c4b8777165e549e1e914787130', 'Tutorial181 complete original plan pin differs'
    return entries


def tutorial181_selection_guard(state, prefix, choice_mode='original'):
    assert choice_mode == 'original', 'Tutorial181 requires original mode'
    assert tutorial_action(state, prefix, choice_mode) == 'target-settled', 'Tutorial181 requires exact ready menu'
    row = json.loads(state.get('tutorial181Record') or '{}')
    assert row.get('status') != 'rejected', 'Tutorial181 native admission rejected: ' + str(row.get('error')) + '; control=' + str(state.get('tutorial181ControlRecord'))
    text = 'The love. Definitely the love.'
    path = TUTORIAL_TEXT_PANEL + '/Response Menu Panel/Viewport/Content/Response: ' + text
    assert (row.get('frame'), row.get('conversationId'), row.get('sourceId'), row.get('destinationId'), row.get('successorId')) == (state['frame'], 120, 158, 181, 182), 'Stale/wrong Tutorial181 native source'
    assert (row['choiceMode'], row['text'], row['path'], row['targetPath'], row['listenerMethod'], row['listenerTargetPath']) == ('original', text, path, TUTORIAL_UI, 'OnClick', path), 'Tutorial181 native control/listener differs'
    assert row['typing'] is False and row['graphVerified'] is True and row['listenerVerified'] is True, 'Tutorial181 native graph/listener unverified'
    assert all(type(row[k]) is int and row[k] != 0 for k in ['buttonInstance', 'controllerInstance']), 'Tutorial181 native identity missing'
    return row


class Tutorial181Transitions:
    """One exact branch admission; its ACK never proves the actual182 successor."""
    def __init__(self, prefix, plan, choice_mode='original'):
        assert choice_mode == 'original', 'Tutorial181 requires original mode'
        self.prefix = prefix
        self.entries = tutorial181_plan_guard(plan)
        self.prefix_tracker = TutorialTransitions(prefix, choice_mode)
        self.selection = None
        self.previous = self.observed_frame = self.observed_at = None
        self.route_observed = []
        self.cleanup_started = False

    def action(self, state):
        if self.selection is None:
            action = tutorial_action(state, self.prefix)
            if action == 'target-settled':
                row = tutorial181_selection_guard(state, self.prefix)
                return 'select-tutorial181 %s %s' % (row['frame'], row['buttonInstance'])
            return action
        if not state['conversationActive']:
            assert self.previous == 187, 'Tutorial181 conversation ended before187'
            assert not state['responses'] and not state['typing'], 'Tutorial181 cleanup has active text/menu'
            return 'route-ended'
        assert (state['conversationId'], state['narrativeDbName'], state['narrativeArcName'] or '') == (120, 'TutorialQuest_IntroFromBunny', ''), 'Tutorial181 narrative binding differs'
        eid = state['entryId']
        assert eid in TUTORIAL181_ROUTE, 'Tutorial181 left exact source route'
        text = self.entries[eid]['text']
        if text.startswith('[pic='):
            text = text.split(']', 1)[1]
        assert state['conversationState'] == text, 'Tutorial181 subtitle differs from exact source'
        assert not state['responses'], 'Tutorial181 unexpected response menu'
        # PC181 may appear before182, but an ACK or PC observation cannot replace182.
        return None if state['typing'] or eid == 181 else 'continue-bound 120 ' + str(eid)

    def observe(self, state, now):
        self.action(state)
        if self.selection is None:
            self.prefix_tracker.observe(state, now)
        elif state['conversationActive']:
            eid = state['entryId']
            if self.previous == 158:
                assert eid in [181, 182], 'Tutorial181 actual successor must be182'
            elif eid != self.previous:
                assert eid == TUTORIAL181_ROUTE[TUTORIAL181_ROUTE.index(self.previous)+1], 'Tutorial181 source transition skipped/backtracked'
            if eid not in self.route_observed:
                self.route_observed.append(eid)
        self.previous = state['entryId'] if state['conversationActive'] else self.previous
        self.observed_frame, self.observed_at = state['frame'], now

    def acknowledge_selection(self, state, action, transport, receipt):
        assert self.selection is None, 'Tutorial181 already selected; no replay'
        expected = tutorial181_selection_guard(state, self.prefix)
        assert (state['entryId'], state['frame']) == (self.previous, self.observed_frame), 'Stale Tutorial181 host observation'
        assert action == 'select-tutorial181 %s %s' % (state['frame'], expected['buttonInstance']), 'Tutorial181 action binding differs'
        assert transport.get('command') == action and transport.get('transportExitCode') == 0 and transport.get('acknowledgement', '').partition(' OK ')[2] == action, 'Missing exact Tutorial181 selection ACK'
        assert self.observed_at <= transport['submittedAt'] <= transport['acknowledgedAt'], 'Stale Tutorial181 selection ACK'
        assert receipt['result'] == 'submitted' and 0 <= receipt['frame']-state['frame'] <= 120, 'Stale Tutorial181 native receipt'
        assert all(receipt[k] == v for k, v in expected.items() if k not in ['frame', 'result']), 'Tutorial181 native receipt binding differs'
        self.selection = dict(sourceFrame=state['frame'], action=action, native=receipt, transport=transport)

    def receipt(self):
        return dict(prefix=self.prefix_tracker.receipt(), selection181=self.selection,
            observedRouteSubtitles=self.route_observed, actual182Observed=182 in self.route_observed,
            boundary='Selection ACK, PC181 and actual182 observation are separate; no initial-spawn/notebook/quest-completion claim')


def observe_tutorial181(budget, tracker, now, state, saved):
    budget.check(now)
    assert continue_diagnostic_ready(state), 'Tutorial181 dependencies not ready'
    assert state['frame'] > budget.frame and state['realtime'] > budget.realtime, 'Tutorial181 requires a new real frame'
    assert all(math.isfinite(state[k]) and state[k] >= 0 for k in ['realtime', 'scaledTime', 'timeScale']), 'Invalid original Unity clocks'
    assert state['scene'] in ['StartMenu', 'SoftResetLoadingScene', 'ChapterSelect', 'CentralForest'], 'Unexpected Tutorial181 scene'
    action = tracker.action(state)
    tracker.observe(state, now)
    budget.frame, budget.realtime = state['frame'], state['realtime']
    if action is not None and budget.stage == 'bootstrap':
        budget.stage, budget.stage_started, budget.progress_at = 'dialogue', now, now
    if action == 'route-ended' and budget.stage != 'cleanup':
        assert 182 in tracker.route_observed, 'Tutorial181 missing actual182'
        budget.stage, budget.stage_started, budget.progress_at = 'cleanup', now, now
    milestone = ('entry', state['conversationId'], state['entryId']) if state['conversationActive'] else ('scene', state['scene'])
    if milestone not in budget.milestones:
        budget.milestones.add(milestone)
        budget.progress_at = now
    terminal = (action == 'route-ended' and saved['scene'] == state['scene'] == 'CentralForest' and
        saved['gameplay'] and not saved['anyEvent'] and not saved['conversation'] and saved['playerPresent'] and
        not state['narrativeDbName'] and not state['narrativeArcName'])
    budget.terminal_frames = budget.terminal_frames + [state['frame']] if terminal else []
    return (None if action == 'route-ended' else action), len(budget.terminal_frames) >= 2


BUCKY141_ROUTE = list(range(194, 213))
BUCKY141_PLAN_SHA = '33f993794f98a44c9080b5d03a9ebf105dae3bb9b795b720a5de324173293dba'
BUCKY141_WRAPPER = 'PixelCrushers.DialogueSystem.Wrappers.StandardUIResponseButton'
BUCKY141_LISTENER = 'PixelCrushers.DialogueSystem.StandardUIResponseButton'
BUCKY141_COUNTS = ['intro_from_beaver', 'intro_from_mouse', 'intro_from_otter', 'give_sugar_to_bunny']


def bucky141_plan_guard(plan):
    assert (plan['conversation'], plan['dbName'], plan['arc'], plan['first'], plan['selected'],
        plan['declined'], plan['successor'], plan['route']) == (141, 'TutorialQuest_BeaverIntroduction', 'p1', 215, 217, 216, 194, BUCKY141_ROUTE), 'Bucky141 source route differs'
    assert plan['sourceSha256'] == '7cd3173110e9498ada7669cb07f1edf6ab949abef76d791c1e07c7e96da0e10b', 'Bucky141 source pin differs'
    entries = {e['id']: e for e in plan['entries']}
    assert len(entries) == len(plan['entries']) and set(entries) == {215, 216, 217, *BUCKY141_ROUTE, 218, 192, 225, 235}, 'Bucky141 source IDs differ'
    for eid, e in entries.items():
        expected_actor = (7, 1) if eid in [201, 215] else (1, 3) if eid in [206, 216, 217] else (3, 1)
        assert (e['actor'], e['conversant']) == expected_actor, 'Bucky141 source actors differ'
        assert e['isGroup'] == 0 and all(e[k] == '' for k in ['menuText', 'responseMenuSequence', 'conditions', 'script']), 'Bucky141 source controls differ'
        assert e['sequence'] == ('None()' if eid in [218, 192, 225, 235] else ''), 'Bucky141 source sequence differs'
        assert e['onExecute']['m_PersistentCalls']['m_Calls'] == [], 'Bucky141 source callback differs'
        targets = [216, 217] if eid == 215 else [194] if eid == 217 else [215] if eid == 218 else [212] if eid in [192, 225, 235] else [eid+1] if eid in BUCKY141_ROUTE[:-1] else []
        assert e['outgoingLinks'] == [dict(originConversationID=141, originDialogueID=eid,
            destinationConversationID=141, destinationDialogueID=t, isConnector=0, priority=2) for t in targets], 'Bucky141 source link differs'
    canonical = json.dumps(plan, ensure_ascii=False, sort_keys=True, separators=(',', ':')).encode()
    assert hashlib.sha256(canonical).hexdigest() == BUCKY141_PLAN_SHA, 'Bucky141 full plan pin differs'
    return entries


def bucky141_subtitle_guard(state, entries):
    qa_identity(state)
    assert continue_diagnostic_ready(state), 'Bucky141 dependencies not ready'
    assert state['scene'] == 'CentralForest' and state['conversationActive'] is True, 'Bucky141 requires actual conversation'
    assert (state['conversationId'], state['narrativeDbName'], state['narrativeArcName']) == (141, 'TutorialQuest_BeaverIntroduction', 'p1'), 'Bucky141 narrative binding differs'
    eid = state['entryId']
    assert eid in [215, 217, *BUCKY141_ROUTE], 'Bucky141 unexpected source entry'
    e = entries[eid]
    row = json.loads(state.get('bucky141Record') or '{}')
    assert row.get('status') != 'rejected', 'Bucky141 native admission rejected: ' + str(row.get('error'))
    assert (row.get('frame'), row.get('conversationId'), row.get('entryId')) == (state['frame'], 141, eid), 'Stale Bucky141 native source'
    assert row['choiceMode'] == 'original' and row['graphVerified'] is True, 'Bucky141 original graph unverified'
    assert (row['actorId'], row['conversantId'], row['sourceText']) == (e['actor'], e['conversant'], e['text']), 'Bucky141 exact actor/text differs'
    text = e['text'].split(']', 1)[1] if e['text'].startswith('[pic=') else e['text']
    assert state['conversationState'] == text, 'Bucky141 exact rendered subtitle differs'
    return row


def bucky217_selection_guard(state, entries):
    bucky141_subtitle_guard(state, entries)
    assert state['entryId'] == 215 and state['typing'] is False, 'Bucky217 requires non-typing215'
    responses = state['responses']
    assert len(responses) == 2 and {r['entryId'] for r in responses} == {216, 217}, 'Bucky217 requires both exact choices'
    for r in responses:
        text = entries[r['entryId']]['text']
        assert r['conversationId'] == 141 and r['text'] == text and r['visible'] is True and r['clickable'] is True and r['targetPath'] == TUTORIAL_UI and r['path'] == TUTORIAL_TEXT_PANEL+'/Response Menu Panel/Viewport/Content/Response: '+text, 'Bucky217 response control differs'
    row = json.loads(state.get('bucky217Record') or '{}')
    assert (row.get('frame'), row.get('conversationId'), row.get('sourceId'), row.get('destinationId'), row.get('successorId')) == (state['frame'], 141, 215, 217, 194), 'Stale/wrong Bucky217 native source'
    path = TUTORIAL_TEXT_PANEL+'/Response Menu Panel/Viewport/Content/Response: Yes'
    assert (row['choiceMode'], row['text'], row['path'], row['targetPath'], row['listenerMethod'], row['listenerTargetPath']) == ('original', 'Yes', path, TUTORIAL_UI, 'OnClick', path), 'Bucky217 native binding differs'
    assert all(row[k] == BUCKY141_WRAPPER for k in ['controllerType', 'declinedControllerType']), 'Bucky217 exact wrapper type differs'
    assert all(row[k] == BUCKY141_LISTENER for k in ['listenerDeclaringType', 'declinedListenerDeclaringType']), 'Bucky217 inherited listener differs'
    assert row['typing'] is False and row['graphVerified'] is True and row['listenerVerified'] is True, 'Bucky217 native graph/listener unverified'
    ids = [row[k] for k in ['buttonInstance', 'controllerInstance', 'declinedButtonInstance', 'declinedControllerInstance']]
    assert all(type(i) is int and i != 0 for i in ids) and len(set(ids)) == 4, 'Bucky217 distinct control identities missing'
    return row


def bucky_completion_snapshot(sample):
    """Freshness against gameplay samples belongs to the caller, never a file mtime."""
    qa_identity(sample)
    assert sample['scene'] == 'CentralForest' and sample['choiceMode'] == 'original', 'Bucky completion identity/mode differs'
    assert type(sample['frame']) is int and sample['frame'] > 0 and math.isfinite(sample['realtime']) and sample['realtime'] >= 0, 'Bucky completion frame/time missing'
    rows = sample['diagnostics']
    guards = diagnostic_fields(rows, 'guards')
    assert guards == dict(gameplay='True', anyEvent='False', conversation='False'), 'Bucky completion not idle gameplay'
    def select(prefix, **fields):
        parsed = [dict(p.split('=', 1) for p in r.split(' | ')[1:]) for r in rows if r.split(' | ')[0] == prefix]
        selected = [r for r in parsed if all(r.get(k) == str(v) for k, v in fields.items())]
        assert len(selected) == 1, 'Bucky completion missing/ambiguous ' + prefix + str(fields)
        return selected[0]
    counts = {name: int(select('trigger', name=name)['count']) for name in BUCKY141_COUNTS}
    assert all(n >= 0 for n in counts.values()), 'Bucky completion negative count'
    return dict(counts=counts, completion=diagnostic_fields(rows, 'buckyCompletion'),
        quest=select('quest', name='Act1_TutorialQuest'),
        dialogue=select('questDialogue', name='TutorialQuest_BeaverIntroduction'),
        arc=select('primaryArc', dialogue='TutorialQuest_BeaverIntroduction', suffix='p1'),
        notebook=select('buckyNotebookTrigger', conversation=225, entry=195))


class Bucky141Transitions:
    """Bounded pure host state only; no gameplay executor or input injection here."""
    def __init__(self, plan, baseline, started):
        self.entries = bucky141_plan_guard(plan)
        self.baseline = baseline
        self.before = bucky_completion_snapshot(baseline)
        assert self.before['counts'] == dict.fromkeys(BUCKY141_COUNTS, 0), 'Bucky initial four counts differ'
        assert self.before['completion'] == dict(notebookLearned='False', observerArmed='False', lineEnd='null') and self.before['notebook']['executed'] == 'False', 'Bucky initial notebook/observer differs'
        assert (self.before['quest']['status'], self.before['dialogue']['status'], self.before['arc']['status']) == ('100', '0', '0'), 'Bucky initial source status differs'
        assert math.isfinite(started), 'Bucky invalid clock'
        self.started = self.progress_at = self.observed_at = started
        self.deadline = started + 120
        self.frame, self.realtime = baseline['frame'], baseline['realtime']
        self.previous = None
        self.selection = self.line_end = self.completion = None
        self.observed = []
        self.cleanup = []
        self.first212 = None

    def check(self, now):
        assert math.isfinite(now) and self.observed_at <= now <= self.deadline, 'Bucky fixed stage deadline exceeded'
        assert now - self.progress_at <= 20, 'Bucky unchanged progress timeout'

    def action(self, state):
        if not state['conversationActive']:
            assert self.selection is not None and self.observed == BUCKY141_ROUTE, 'Bucky cleanup before full212 route'
            assert not state['responses'] and not state['typing'] and not state['narrativeDbName'] and not state['narrativeArcName'], 'Bucky cleanup active text/menu/narrative'
            return 'route-ended'
        bucky141_subtitle_guard(state, self.entries)
        eid = state['entryId']
        if self.selection is None:
            assert eid == 215, 'Bucky first actual entry must be215'
            if state['typing'] or not state['responses']:
                return None
            row = bucky217_selection_guard(state, self.entries)
            return 'select-bucky217 %s %s' % (row['frame'], row['buttonInstance'])
        if eid == 215:
            bucky217_selection_guard(state, self.entries)
            return None
        assert not state['responses'], 'Bucky unexpected response menu'
        return None if state['typing'] or eid == 217 else 'continue-bound 141 ' + str(eid)

    def observe(self, state, now, saved=None):
        self.check(now)
        qa_identity(state)
        assert continue_diagnostic_ready(state), 'Bucky141 dependencies not ready'
        assert state['scene'] == 'CentralForest' and all(state[k] == self.baseline[k] for k in ['dataPath', 'persistentDataPath']), 'Bucky process/scene identity changed'
        assert type(state['frame']) is int and state['frame'] > self.frame and math.isfinite(state['realtime']) and state['realtime'] > self.realtime, 'Bucky requires new real frame/time'
        action = self.action(state)
        if state['conversationActive']:
            assert not self.cleanup, 'Bucky conversation resumed during cleanup'
            eid = state['entryId']
            if self.previous is None:
                assert eid == 215 and state['realtime']-self.baseline['realtime'] <= 15, 'Bucky stale initial dispatch'
            elif eid != self.previous:
                expected = [215, 217, 194] if self.previous == 215 else [194] if self.previous == 217 else [self.previous+1]
                assert eid in expected, 'Bucky actual successor194 required or source transition skipped/backtracked'
            if eid != self.previous:
                self.progress_at = now
                if eid in BUCKY141_ROUTE:self.observed.append(eid)
                if eid == 212:self.first212 = dict(frame=state['frame'], realtime=state['realtime'])
            self.previous = eid
        else:
            end = json.loads(state.get('bucky212EndRecord') or '{}')
            assert self.first212 is not None and (end.get('conversationId'), end.get('entryId'), end.get('dbName'), end.get('arc'), end.get('count')) == (141, 212, 'TutorialQuest_BeaverIntroduction', 'p1', 1), 'Bucky missing exact real212 line-end'
            assert type(end['frame']) is int and self.first212['frame'] < end['frame'] <= state['frame'] and math.isfinite(end['realtime']) and self.first212['realtime'] < end['realtime'] <= state['realtime'], 'Bucky stale real212 line-end'
            assert saved and saved['scene'] == 'CentralForest' and saved['gameplay'] is True and saved['anyEvent'] is False and saved['conversation'] is False and saved['playerPresent'] is True, 'Bucky cleanup requires no-event Player frame'
            if not self.cleanup:
                self.deadline = min(self.deadline, now+15)
                self.progress_at = now
                self.line_end = end
            assert end == self.line_end, 'Bucky line-end changed during cleanup'
            self.cleanup.append(dict(frame=state['frame'], realtime=state['realtime']))
        self.frame, self.realtime, self.observed_at = state['frame'], state['realtime'], now
        return None if action == 'route-ended' else action

    def acknowledge_selection(self, state, action, transport, receipt):
        assert self.selection is None, 'Bucky217 already selected; no replay'
        expected = bucky217_selection_guard(state, self.entries)
        assert (state['frame'], state['entryId']) == (self.frame, self.previous), 'Stale Bucky217 host observation'
        assert action == 'select-bucky217 %s %s' % (state['frame'], expected['buttonInstance']), 'Bucky217 action binding differs'
        assert transport.get('command') == action and transport.get('transportExitCode') == 0 and transport.get('acknowledgement', '').partition(' OK ')[2] == action, 'Missing exact Bucky217 ACK'
        assert self.observed_at <= transport['submittedAt'] <= transport['acknowledgedAt'] <= self.deadline and transport['acknowledgedAt']-self.progress_at <= 20, 'Stale Bucky217 ACK'
        assert receipt['result'] == 'submitted' and type(receipt['frame']) is int and 0 <= receipt['frame']-state['frame'] <= 120, 'Stale Bucky217 receipt'
        assert all(receipt[k] == v for k, v in expected.items() if k not in ['frame', 'result']), 'Bucky217 receipt binding differs'
        self.selection = dict(native=receipt, transport=transport, sourceFrame=state['frame'])
        # ACK does not change self.frame, progress_at, previous, deadline or coverage.

    def accept_completion(self, sample, now):
        self.check(now)
        assert self.completion is None, 'Bucky completion already accepted'
        assert len(self.cleanup) >= 2 and self.line_end is not None, 'Bucky needs two real cleanup frames'
        after = bucky_completion_snapshot(sample)
        assert all(sample[k] == self.baseline[k] for k in ['dataPath', 'persistentDataPath']), 'Bucky completion process identity differs'
        assert type(sample['frame']) is int and self.frame < sample['frame'] <= self.frame+120 and 0 < sample['realtime']-self.realtime <= 2, 'Bucky stale completion snapshot'
        assert after['counts'] == dict(zip(BUCKY141_COUNTS, [1, 0, 0, 0])), 'Bucky actual named trigger delta differs'
        assert after['completion']['observerArmed'] == 'True' and json.loads(after['completion']['lineEnd']) == self.line_end, 'Bucky completion line-end differs'
        assert after['completion']['notebookLearned'] == 'False' and after['notebook']['executed'] == 'False', 'Bucky alone cannot complete notebook'
        assert (after['quest']['status'], after['dialogue']['status'], after['arc']['status']) == ('100', '200', '100'), 'Bucky actual quest/dialogue/arc status differs'
        self.completion = dict(sample=sample, parsed=after)
        return self.receipt()

    def receipt(self):
        return dict(selection217=self.selection, actual194Observed=194 in self.observed, observedRouteSubtitles=list(self.observed),
            real212LineEnd=self.line_end, cleanupFrames=list(self.cleanup), completion=self.completion,
            boundary='Pure host admission, pending real Unity/native execution. Selection/actual194/real212 end/two cleanup frames/counts are separate. Bucky alone is not all-four/notebook acceptance.')


def continue_diagnostic_ready(state):
    """Read-only producer contract; never infer readiness from default story fields."""
    assert type(state['diagnosticsReady']) is bool, 'Invalid diagnostic readiness flag'
    assert type(state['dataServicePresent']) is bool and type(state['manifestPresent']) is bool, 'Invalid service readiness flags'
    missing = state['notReady']
    assert isinstance(missing, list) and len(missing) <= 128 and len(set(missing)) == len(missing), 'Invalid not-ready dependency list'
    allowed = {'DataService._instance', 'DataService._manifest',
               'DataManifest.playerRespawnData', 'DataManifest.generalData',
               'DataManifest.triggersByTriggerName', 'DataManifest.activeTagsByDbName',
               'DataManifest.dialoguesByDbName', 'DataManifest.questsByDbName',
               'dialogue.NewGame_Intro', 'GameStateManager.isEventActive'}
    allowed.update('quest.' + name + suffix for name in ['Act1_TutorialQuest', 'Act1_GossipQuest']
                   for suffix in ['', '.dialogues', '.dialogue', '.primaryArcs', '.primaryArc'])
    assert all(isinstance(reason, str) and reason in allowed for reason in missing), 'Unknown not-ready dependency'
    if not state['dataServicePresent']:
        assert not state['manifestPresent'] and state['dataServiceInstance'] == 0 and missing == ['DataService._instance'], 'Inconsistent absent singleton'
    else:
        assert type(state['dataServiceInstance']) is int and state['dataServiceInstance'] != 0, 'Invalid service instance identity'
        if not state['manifestPresent']:
            assert missing == ['DataService._manifest'], 'Inconsistent absent manifest'
        else:
            assert not any(r.startswith('DataService.') for r in missing), 'Inconsistent present manifest'
    assert state['diagnosticsReady'] == (not missing), 'Diagnostic readiness/list disagree'
    return state['diagnosticsReady']


class ContinueObservationBudget(IntroObservationBudget):
    """Same hard/stage/idle caps, monotone real frames and source-only milestones."""
    def observe_not_ready(self, now, state):
        self.check(now)
        assert not continue_diagnostic_ready(state), 'Expected scalar not-ready observation'
        assert self.stage == 'bootstrap', 'Diagnostic dependencies disappeared after tutorial started'
        assert state['scene'] in ['StartMenu', 'SoftResetLoadingScene', 'ChapterSelect', 'CentralForest'], 'Unexpected not-ready scene'
        assert state['frame'] > self.frame and state['realtime'] > self.realtime, 'Continue observation must be a new real frame'
        assert all(math.isfinite(state[k]) and state[k] >= 0 for k in ['realtime', 'scaledTime', 'timeScale']), 'Invalid original Unity clocks'
        self.frame, self.realtime = state['frame'], state['realtime']
        self.terminal_frames = []
        # Readiness, timers and scalar scene changes never buy more idle/hard time.
        return None, False

    def observe_continue(self, now, state, prefix, choice_mode='original'):
        self.check(now)
        assert continue_diagnostic_ready(state), 'Full diagnostic dependencies not ready'
        assert state['frame'] > self.frame and state['realtime'] > self.realtime, 'Continue observation must be a new real frame'
        assert all(math.isfinite(state[k]) and state[k] >= 0 for k in ['realtime', 'scaledTime', 'timeScale']), 'Invalid original Unity clocks'
        self.frame, self.realtime = state['frame'], state['realtime']
        assert state['scene'] in ['StartMenu', 'SoftResetLoadingScene', 'ChapterSelect', 'CentralForest'], 'Unexpected restored scene'
        action = tutorial_action(state, prefix, choice_mode)
        milestone = ('scene', state['scene']) if not state['conversationActive'] else ('entry', state['conversationId'], state['entryId'])
        if action is not None and self.stage == 'bootstrap':
            self.stage, self.stage_started, self.progress_at = 'dialogue', now, now
        if milestone not in self.milestones:
            self.milestones.add(milestone)
            self.progress_at = now
        self.terminal_frames = self.terminal_frames + [state['frame']] if action == 'target-settled' else []
        return action, len(self.terminal_frames) >= 2


def continue_from_fixture(menu, fixture, budget, choice_mode='original', continue181=False):
    continue_menu_guard(menu)
    command('dump-save-continuation', deadline=budget.deadline)
    loaded = json.loads((RUN / 'save-continuation.json').read_text())
    shutil.copy2(RUN / 'save-continuation.json', RUN / 'continue-menu-loaded.json')
    assert continue_diagnostic_ready(loaded), 'Loaded menu diagnostic dependencies not ready'
    loaded_fixture_guard(loaded, fixture)
    prefix = json.loads((RUN / 'tutorial-prefix.json').read_text())
    command('menu PlayMenu OnClickContinue', deadline=budget.deadline)
    observations, actions = [], []
    first_player = None
    saw_controller = False
    transitions = (Tutorial181Transitions(prefix, json.loads((RUN / 'tutorial181-plan.json').read_text()), choice_mode)
                   if continue181 else TutorialTransitions(prefix, choice_mode))
    prefix_transitions = transitions.prefix_tracker if continue181 else transitions
    last_action, repeats = None, 0
    while True:
        budget.check(time.monotonic())
        command('dump-save-continuation', deadline=budget.deadline)
        saved = json.loads((RUN / 'save-continuation.json').read_text())
        qa_identity(saved)
        if not continue_diagnostic_ready(saved):
            budget.observe_not_ready(time.monotonic(), saved)
            observations.append(dict(save=saved, intro=None, action=None, budget=budget.receipt(time.monotonic())))
            write('continue-observations.json', observations)
            write('intro-observation-budget.json', budget.receipt(time.monotonic()))
            time.sleep(min(1, max(0, budget.deadline-time.monotonic())))
            continue
        assert saved['hasSavedPlaySession'] and not saved['isChapterSelect'] and not saved['isCheatCode'], 'Restored session flags changed'
        command('dump-intro', deadline=budget.deadline)
        state = decode_state(json.loads((RUN / 'intro-state.json').read_text()))
        qa_identity(state)
        if not continue_diagnostic_ready(state):
            budget.observe_not_ready(time.monotonic(), state)
            observations.append(dict(save=saved, intro=state, action=None, budget=budget.receipt(time.monotonic())))
            write('continue-observations.json', observations)
            write('intro-observation-budget.json', budget.receipt(time.monotonic()))
            time.sleep(min(1, max(0, budget.deadline-time.monotonic())))
            continue
        # Reject an unrelated jump before it can credit a budget milestone.
        if continue181:
            action, terminal_pair = observe_tutorial181(budget, transitions, time.monotonic(), state, saved)
        else:
            transitions.observe(state, time.monotonic())
            action, terminal_pair = budget.observe_continue(time.monotonic(), state, prefix, choice_mode)
        write('continue-transitions.json', transitions.receipt())
        if action == 'complete-tutorial158' and prefix_transitions.completion is not None:
            action = None  # Wait under unchanged caps; never replay acknowledged completion.
        if saved['scene'] == 'CentralForest' and saved['playerPresent']:
            assert saved['gameplay'] and saved['playerPath'] == 'SpawnedContent/Player/Content/Player(Clone)' and saved['playerInstance'] != 0, 'Restored root Player identity differs'
            if first_player is None:
                first_player = dict(saved, matchesFixturePosition=vector_matches(saved['playerPosition'], fixture['playerRespawnData']['lastPosition']),
                                    boundary='First host-observed Player; original tutorial may already have moved it. Not necessarily the spawn frame.')
                write('continue-first-player.json', first_player)
            saw_controller = saw_controller or saved['tutorialIntroControllers'] == 1
        observations.append(dict(save=saved, intro=state, action=action, budget=budget.receipt(time.monotonic())))
        write('continue-observations.json', observations)
        write('intro-observation-budget.json', budget.receipt(time.monotonic()))
        if terminal_pair:
            assert first_player is not None and saw_controller, 'Missing original Player/tutorial controller observation'
            if continue181:
                command('dump-tutorial', deadline=budget.deadline)
                shutil.copy2(RUN / 'tutorial-route.json', RUN / 'post181-tutorial-route.json')
                command('dump-notebook', deadline=budget.deadline)
                shutil.copy2(RUN / 'notebook-route.json', RUN / 'post181-notebook-route.json')
                write('continue-progression.json', dict(result='ordinary181-route-cleanup',
                    tutorialChoiceMode=choice_mode, actualTerminalFrames=budget.terminal_frames,
                    choicesSubmitted=1, initialSpawnPositionVerified=False,
                    firstObservedPositionMatchesFixture=first_player['matchesFixturePosition'],
                    observationBudget=budget.receipt(time.monotonic()),
                    subtitleAndResponseEvidence=transitions.receipt(),
                    boundary='Actual182/route187 and conversation/event cleanup only; four tutorial triggers, notebook and inventory remain unverified'))
                break
            write('continue-progression.json', dict(result='target-settled', conversationId=120, entryId=158,
                tutorialChoiceMode=choice_mode, actualTerminalFrames=budget.terminal_frames, choicesSubmitted=0, initialSpawnPositionVerified=False,
                firstObservedPositionMatchesFixture=first_player['matchesFixturePosition'],
                positionBoundary='Host observation cannot establish the initial spawn frame; retained separately from normal continuation.',
                observationBudget=budget.receipt(time.monotonic()),
                subtitleAndResponseEvidence=transitions.receipt()))
            command('dump', deadline=budget.deadline)
            renderer = read_state()
            assert tutorial_action(renderer, prefix, choice_mode) == 'target-settled', 'Tutorial state changed before capture'
            rows = choice_renderer_guard(renderer, prefix, choice_mode)
            write('choice-renderer-before-capture.json', dict(frame=renderer['frame'], choiceMode=choice_mode, rows=rows))
            # Native Unity framebuffer capture, no activation, OS overlay or pixel input.
            command('capture ru-01-tutorial-choice.png', deadline=budget.deadline)
            capture = RUN / 'ru-01-tutorial-choice.png'
            while not capture.exists() and time.monotonic() < budget.deadline:
                time.sleep(.1)
            assert capture.is_file(), 'Native capture did not materialize within existing observation budget'
            command('dump', deadline=budget.deadline)
            final = read_state()
            assert tutorial_action(final, prefix, choice_mode) == 'target-settled', 'Tutorial state changed across capture'
            choice_renderer_guard(final, prefix, choice_mode)
            shutil.copy2(RUN / 'state.json', RUN / 'capture-state.json')
            break
        if action and action != 'target-settled':
            key = (state['entryId'], action)
            repeats = repeats + 1 if key == last_action else 1
            last_action = key
            assert repeats <= (1 if action.startswith('response ') else 3), 'Tutorial action did not advance'
            transport = command(action, deadline=budget.deadline)
            receipt = json.loads((RUN / 'continue-receipt.json').read_text()) if action.startswith('continue-bound ') else None
            if action == 'complete-tutorial158':
                receipt = json.loads((RUN / 'completion158-receipt.json').read_text())
                prefix_transitions.acknowledge_completion(state, action, transport, receipt)
                write('continue-transitions.json', transitions.receipt())
            elif action.startswith('select-tutorial181 '):
                receipt = json.loads((RUN / 'selection181-receipt.json').read_text())
                transitions.acknowledge_selection(state, action, transport, receipt)
                write('continue-transitions.json', transitions.receipt())
            elif receipt is not None:
                continue_outcome(state, receipt)
            else:
                prefix_transitions.acknowledge_response(state, action, transport)
                write('continue-transitions.json', transitions.receipt())
            actions.append(dict(action=action, frame=state['frame'], receipt=receipt, transport=transport))
            write('continue-actions.json', actions)
        budget.check(time.monotonic())
        time.sleep(min(.3 if state['conversationActive'] else 1, max(0, budget.deadline-time.monotonic())))


def main():
    global RUN, GAME, EXE, LAUNCHER
    options = launch_options(sys.argv[1:])
    RUN = options.run.resolve()
    GAME = RUN / 'game'
    EXE = GAME / 'The Forest of Love.exe'
    assert RUN.parent == Path('/Users/antonkrutov/Desktop/Forest/localization/probes')
    assert Path(__file__).resolve().parent == RUN, 'Run the immutable snapshot'
    assert not (RUN / 'launch.json').exists() and not processes(), 'Reconcile any previous launch'
    fixture = admit_session(GAME, RUN, options.continue_fixture)
    admit_choice_mode(RUN, options.tutorial_choice_mode)
    if options.tutorial181:
        tutorial181_plan_guard(json.loads((RUN / 'tutorial181-plan.json').read_text()))
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
                             'tutorialChoiceMode': options.tutorial_choice_mode,
                             'tutorial181': options.tutorial181,
                             'environmentOverrides': dict(STARTUP_TRACE_ENV) if options.startup_diagnostics else {},
                             'snapshots': {name: sha(RUN / name) for name in
                                           ['diagnose_newgame.py', 'command.py', 'build.json', 'bridge-build.json', 'input-pins.json', 'intro-graph.json', 'frozen-files.json']},
                             'scope': ('Original QA43 Continue, exact181 ->182 route through187 and cleanup; no capture' if options.tutorial181 else 'Original QA43 Continue to source-bound120:158; no choice submitted' if options.continue_fixture else 'Original New/source-bound145 intro, two loaded idle Player/door pair samples, then source-backed bounded process-targeted left/down route to natural CentralForest entry; no screenshots or forced eligibility')})
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
        observe_focus_boundary('menu-before-Continue' if options.continue_fixture else 'menu-before-New', force=True)
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
        if options.continue_fixture:
            budget = ContinueObservationBudget(time.monotonic())
            continue_from_fixture(state, fixture, budget, options.tutorial_choice_mode, options.tutorial181)
        else:
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
                                      'durationSeconds': round(time.monotonic() - started, 3), 'imagesCaptured': len(list(RUN.glob('ru-*.png'))),
                                      'imagesOpened': 0, 'tutorialChoiceMode': options.tutorial_choice_mode, 'tutorial181': options.tutorial181, 'scope': ('Original QA43 Continue, exact181 ->182 route through187 and cleanup; no capture' if options.tutorial181 else 'Original QA43 Continue to source-bound120:158; no choice submitted' if options.continue_fixture else 'Original New/source-bound145 intro through delayed cleanup, loaded root/door pair observations and guarded original left/down movement to natural CentralForest entry'),
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
