"""Source-bound action guards only; real response delivery is a separate runtime check."""
import copy
from datetime import datetime
import importlib.util
import json
import subprocess
import tempfile
from pathlib import Path
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('intro', ROOT / 'tools/probe/diagnose_newgame.py')
intro = importlib.util.module_from_spec(spec)
spec.loader.exec_module(intro)
GRAPH = json.loads((ROOT / 'localization/source/intro-20261026/intro-graph.json').read_text())


def state(entry=205):
    return dict(conversationActive=True, conversationId=145, entryId=entry,
                narrativeDbName='NewGame_Intro', narrativeArcName='bunny_says_hello',
                conversationState='How are ya feeling?', responses=[])


def observation(frame, entry=205, active=True, cleanup=False, stage=None, timer=0):
    s = state(entry)
    s.update(scene='BunnyHouse', conversationActive=active, frame=frame,
             realtime=float(frame), scaledTime=frame/2, timeScale=1,
             introDiagnostics=[
                 'guards | gameplay=True | dustin=False | glitch=False | anyEvent=False',
                 'introCleanup | remainingControllers=%s | bedControllers=1 | activeBedControllers=%s' %
                 (0 if cleanup else 1, 1 if cleanup else 0),
                 'trigger | name=Cutscene_IntroBunnyHouse | count=' + ('1' if cleanup or stage == 'Ending' else 'absent')])
    if stage:
        s['introDiagnostics'].append('introCutscene | path=CutsceneIntroBunnyHouse(Clone) | active=True | stage=%s | timerSet=%s | timerSeconds=%s' %
                                     (stage, 'True' if timer > 0 else 'False', timer))
    return s


class IntroObservation(unittest.TestCase):
    def test_consumed38_timestamps_reach_incomplete_cleanup_without_global240_rejection(self):
        run = ROOT / 'localization/probes/ru-20261026-38'
        actions = []
        for line in (run / 'actions.log').read_text().splitlines():
            if ' OK ' in line:
                stamp, value = line.split(' OK ', 1)
                actions.append((datetime.fromisoformat(stamp[:26]+'+00:00'), value))
        started = next(t for t, value in actions if value == 'menu PlayMenu OnClickStart')
        stamps = [t for t, value in actions if t > started and value == 'dump-notebook']
        rows = json.loads((run / 'newgame-observations.json').read_text())
        self.assertEqual(len(stamps), len(rows))
        b, seen = intro.IntroObservationBudget(0), set()
        for index, (stamp, actual) in enumerate(zip(stamps, rows), 1):
            #38 had no unified frame/clock fields. Synthetic monotone values
            # exercise Python budgeting only; these never become runtime evidence.
            elapsed = (stamp-started).total_seconds()
            s = dict(actual, frame=index, realtime=elapsed+1, scaledTime=elapsed,
                     timeScale=1, introDiagnostics=[actual['guards']]+
                     actual.get('cleanupDiagnostics', []))
            _, action, terminal = b.observe(elapsed, s, GRAPH, seen)
            if action:
                seen.add(s['entryId'])
            self.assertFalse(terminal)
        self.assertEqual(b.stage, 'cleanup')
        self.assertEqual(b.terminal_frames, [])
        b.check(240)
        # Real38 remains incomplete. Supply no invented successful continuation.
        self.assertLess(b.deadline, 300)

    def test_loading_and_dialogue_do_not_spend_cleanup_stage_budget(self):
        b = intro.IntroObservationBudget(0)
        b.observe(1, dict(observation(1, active=False), scene='StartMenu'), GRAPH, set())
        b.observe(40, dict(observation(2, active=False), scene='IntroForest'), GRAPH, set())
        b.observe(55, observation(3, entry=205), GRAPH, set())
        self.assertEqual(b.stage, 'dialogue')
        b.observe(80, observation(4, entry=207), GRAPH, {205})
        b.observe(105, observation(5, entry=249), GRAPH, {205, 207})
        b.observe(120, observation(6, active=False, stage='BunnyLeavesRoom'), GRAPH, {249})
        self.assertEqual(b.stage, 'cleanup')
        self.assertEqual(b.stage_started, 120)
        b.observe(130, observation(7, active=False, stage='Ending', timer=3), GRAPH, {249})
        self.assertFalse(b.observe(140, observation(8, active=False, stage='Ending', timer=1.9), GRAPH, {249})[2])
        self.assertFalse(b.observe(150, observation(9, active=False, cleanup=True), GRAPH, {249})[2])
        self.assertTrue(b.observe(151, observation(10, active=False, cleanup=True), GRAPH, {249})[2])
        self.assertEqual(b.terminal_frames, [9, 10])

    def test_clock_typing_and_revisited_entries_do_not_reset_progress(self):
        b = intro.IntroObservationBudget(0)
        b.observe(1, observation(1), GRAPH, set())
        s = dict(observation(2), typing=False)
        b.observe(20, s, GRAPH, set())
        self.assertEqual(b.progress_at, 1)
        with self.assertRaisesRegex(AssertionError, 'forward progress stalled: dialogue'):
            b.observe(31, observation(3), GRAPH, set())
        b = intro.IntroObservationBudget(0)
        b.observe(1, observation(1), GRAPH, set())
        b.observe(20, observation(2, entry=207), GRAPH, {205})
        b.observe(40, observation(3), GRAPH, {205, 207})
        self.assertEqual(b.progress_at, 20)

    def test_same_frame_and_frozen_realtime_cannot_supply_terminal_pair(self):
        s = observation(1, active=False, cleanup=True)
        b = intro.IntroObservationBudget(0)
        self.assertFalse(b.observe(1, s, GRAPH, {249})[2])
        first_receipt = b.receipt(1)
        with self.assertRaisesRegex(AssertionError, 'new real frame'):
            b.observe(2, s, GRAPH, {249})
        with self.assertRaisesRegex(AssertionError, 'new real frame'):
            b.observe(3, dict(s, frame=2), GRAPH, {249})
        self.assertTrue(b.observe(4, dict(s, frame=2, realtime=2), GRAPH, {249})[2])
        self.assertEqual(first_receipt['actualTerminalFrames'], [1], 'Later real frames must not rewrite earlier observation receipts')

    def test_terminal_frames_must_be_consecutive_and_all_guards_still_pass(self):
        for old, new in [('anyEvent=False', 'anyEvent=True'),
                         ('remainingControllers=0', 'remainingControllers=1'),
                         ('activeBedControllers=1', 'activeBedControllers=0'),
                         ('count=1', 'count=absent')]:
            with self.subTest(rejection=new):
                b = intro.IntroObservationBudget(0)
                b.observe(1, observation(1, active=False, cleanup=True), GRAPH, {249})
                bad = observation(2, active=False, cleanup=True)
                bad['introDiagnostics'] = [r.replace(old, new) for r in bad['introDiagnostics']]
                self.assertFalse(b.observe(2, bad, GRAPH, {249})[2])
                self.assertFalse(b.observe(3, observation(3, active=False, cleanup=True), GRAPH, {249})[2])
                self.assertTrue(b.observe(4, observation(4, active=False, cleanup=True), GRAPH, {249})[2])

    def test_original_timer_progress_is_bounded_and_increases_buy_no_time(self):
        b = intro.IntroObservationBudget(0)
        b.observe(1, observation(1, active=False, stage='Ending', timer=3), GRAPH, {249})
        b.observe(10, observation(2, active=False, stage='Ending', timer=2.5), GRAPH, {249})
        with self.assertRaisesRegex(AssertionError, 'timer increased within stage'):
            b.observe(20, observation(3, active=False, stage='Ending', timer=2.8), GRAPH, {249})
        self.assertEqual(b.progress_at, 10)
        with self.assertRaisesRegex(AssertionError, 'forward progress stalled: cleanup'):
            b.observe(25, observation(4, active=False, stage='Ending', timer=2.5), GRAPH, {249})
        b = intro.IntroObservationBudget(0)
        for n in range(1, 61, 10):
            b.observe(n, observation(n, active=False, stage='Ending', timer=3-n/100), GRAPH, {249})
        with self.assertRaisesRegex(AssertionError, 'stage hard limit exhausted: cleanup'):
            b.observe(61, observation(61, active=False, stage='Ending', timer=2), GRAPH, {249})

    def test_bootstrap_hard_limit_and_total_hard_limit_are_independent(self):
        b = intro.IntroObservationBudget(0)
        for n, scene in [(1, 'StartMenu'), (50, 'SoftResetLoadingScene'), (99, 'IntroForest')]:
            b.observe(n, dict(observation(n, active=False), scene=scene), GRAPH, set())
        with self.assertRaisesRegex(AssertionError, 'stage hard limit exhausted: bootstrap'):
            b.observe(120, dict(observation(120, active=False), scene='BunnyHouse'), GRAPH, set())
        b = intro.IntroObservationBudget(0)
        b.stage, b.stage_started, b.progress_at = 'cleanup', 350, 359
        with self.assertRaisesRegex(AssertionError, 'total hard limit exhausted'):
            b.check(360)

    def test_source_stage_regression_unknown_scene_or_unexpected_dialogue_holds(self):
        b = intro.IntroObservationBudget(0)
        b.observe(1, observation(1, active=False, stage='Ending', timer=3), GRAPH, {249})
        with self.assertRaisesRegex(AssertionError, 'cutscene stage regressed'):
            b.observe(2, observation(2, active=False, stage='BunnyLeavesRoom'), GRAPH, {249})
        for changes, reason in [(dict(scene='CentralForest'), 'Unexpected intro scene'),
                                (dict(conversationId=225), 'Stop at unexpected dialogue')]:
            with self.assertRaisesRegex(AssertionError, reason):
                intro.IntroObservationBudget(0).observe(1, dict(observation(1), **changes), GRAPH, set())

    def test_inflight_command_uses_remaining_deadline_and_never_submits_after_expiry(self):
        with patch.object(intro.time, 'monotonic', return_value=100), \
             tempfile.TemporaryDirectory() as directory, \
             patch.object(intro, 'RUN', Path(directory)), \
             patch.object(intro, 'COMMAND_HOLD', None), \
             patch.object(intro, 'observe_lifetime', return_value={'realGameRows':['fixture game']}), \
             patch.object(intro.subprocess, 'Popen') as sender:
            sender.return_value.returncode = 0
            sender.return_value.poll.return_value = 0
            def completed(*args, **kwargs):
                sender.call_args.kwargs['stdout'].write('fixture OK dump-intro\n')
            sender.return_value.communicate.side_effect = completed
            intro.command('dump-intro', deadline=103)
            self.assertEqual(sender.return_value.communicate.call_args.kwargs['timeout'], .25)
            sender.return_value.poll.side_effect = [None, 0]
            sender.return_value.communicate.side_effect = subprocess.TimeoutExpired('fixture', .25)
            with patch.object(intro.time, 'monotonic', side_effect=[100, 100, 102.9, 103]):
                with self.assertRaisesRegex(TimeoutError, 'outcome unknown'):
                    intro.command('dump-intro', deadline=103)
            self.assertAlmostEqual(sender.return_value.communicate.call_args.kwargs['timeout'], .1)
            sender.reset_mock()
            with self.assertRaisesRegex(AssertionError, 'before command submission'):
                intro.command('dump-intro', deadline=100)
            sender.assert_not_called()


class IntroActions(unittest.TestCase):
    def test_loaded_geometry_requires_real_scene_owned_body_and_pair_rows(self):
        rows = [
            'travelGuards | gameplay=True | anyEvent=False | conversation=False | focused=True | axis=0,0,0',
            'travelRewired | ignoreUnfocused=True | nativeKeyboard=True | unityInput=False',
            'travelInput | path=Singletons/InputHelper | active=True | enabled=True | player=0:Player1',
            'travelPlayer | id=10 | path=Spawned/Player | active=True | enabled=True',
            'travelBody | id=11 | owner=10 | path=Spawned/Player',
            'travelBody | id=13 | owner=10 | path=Spawned/Player/PlayerFootSensor',
            'travelDoor | id=20 | path=Spawned/Environment/Content/Environment/Doorways/DoorwayToCentralForest | scene=BunnyHouse | destination=CentralForest',
            'travelCollider | id=12 | owner=10 | path=Spawned/Player | tag=Player | rigidbody=Spawned/Player#11',
            'travelCollider | id=14 | owner=10 | path=Spawned/Player/PlayerFootSensor | tag=Untagged | rigidbody=Spawned/Player/PlayerFootSensor#13',
            'travelCollider | id=21 | owner=20',
            'travelPair | playerCollider=12 | doorCollider=21',
        ]
        self.assertEqual(intro.loaded_travel(dict(scene='BunnyHouse', diagnostics=rows))['body']['id'], '11')
        with self.assertRaisesRegex(AssertionError, 'requires BunnyHouse'):
            intro.loaded_travel(dict(scene='StartMenu', diagnostics=rows))
        wrong_body = [r.replace('id=11 | owner=10', 'id=11 | owner=99') for r in rows]
        with self.assertRaisesRegex(AssertionError, 'Body does not belong'):
            intro.loaded_travel(dict(scene='BunnyHouse', diagnostics=wrong_body))
        with self.assertRaisesRegex(AssertionError, 'Missing actual enabled collider-pair'):
            intro.loaded_travel(dict(scene='BunnyHouse', diagnostics=rows[:-1]))
        with self.assertRaisesRegex(AssertionError, 'requires guarded idle gameplay'):
            intro.loaded_travel(dict(scene='BunnyHouse', diagnostics=[r.replace('axis=0,0,0', 'axis=-1,0,0') for r in rows]))

    def test_final_content_and_free_flags_do_not_replace_original_cleanup(self):
        s = dict(scene='BunnyHouse', conversationActive=False)
        guards = 'guards | gameplay=True | dustin=False | glitch=False | anyEvent=False | notebookLearned=False'
        cleanup = 'introCleanup | remainingControllers=0 | bedControllers=1 | activeBedControllers=1'
        trigger = 'trigger | name=Cutscene_IntroBunnyHouse | count=1'
        self.assertTrue(intro.intro_complete(s, guards, {249}, [cleanup, trigger]))
        for old, new in [('remainingControllers=0', 'remainingControllers=1'),
                         ('bedControllers=1', 'bedControllers=0'),
                         ('activeBedControllers=1', 'activeBedControllers=0')]:
            self.assertFalse(intro.intro_complete(s, guards, {249}, [cleanup.replace(old, new), trigger]))
        for count in ['absent', '0']:
            self.assertFalse(intro.intro_complete(s, guards, {249}, [cleanup, trigger.replace('count=1', 'count='+count)]))
        self.assertFalse(intro.intro_complete(s, guards, set(), [cleanup, trigger]))
        self.assertFalse(intro.intro_complete(s, guards.replace('anyEvent=False', 'anyEvent=True'), {249}, [cleanup, trigger]))
        with self.assertRaisesRegex(AssertionError, 'Missing or ambiguous diagnostic: introCleanup'):
            intro.intro_complete(s, guards, {249}, [trigger])
        with self.assertRaisesRegex(AssertionError, 'Missing or ambiguous diagnostic: introCleanup'):
            intro.intro_complete(s, guards, {249}, [cleanup, cleanup, trigger])

    def test_response_transport_requires_complete_serialized_records(self):
        s = dict(responseCount=0, responseRecords=[])
        self.assertEqual(intro.decode_state(s)['responses'], [])
        r = dict(path='Original/Response', text='I’m ok.', targetPath='Original/Menu',
                 conversationId=145, entryId=206, visible=True, clickable=True)
        self.assertEqual(intro.decode_state(dict(responseCount=1, responseRecords=[json.dumps(r)]))['responses'], [r])
        with self.assertRaisesRegex(AssertionError, 'serialization missing'):
            intro.decode_state(dict(responseCount=0))
        with self.assertRaisesRegex(AssertionError, 'Incomplete bridge response readback'):
            intro.decode_state(dict(responseCount=1, responseRecords=[]))
        del r['targetPath']
        with self.assertRaisesRegex(AssertionError, 'Incomplete response row'):
            intro.decode_state(dict(responseCount=1, responseRecords=[json.dumps(r)]))

    def test_normal_continue_and_exact_original_response(self):
        s = state()
        self.assertEqual(intro.intro_action(s, GRAPH), 'continue-bound 145 205')
        s['responses'] = [dict(conversationId=145, entryId=206, visible=True,
                               clickable=True, targetPath='Original/ResponseMenu')]
        self.assertEqual(intro.intro_action(s, GRAPH), 'response 205 145 206')
        s['responses'][0]['entryId'] = 207
        with self.assertRaisesRegex(AssertionError, 'Response differs from source successor'):
            intro.intro_action(s, GRAPH)

    def test_response_branch_and_hidden_stale_response(self):
        s = state()
        r = dict(conversationId=145, entryId=206, visible=True, clickable=True, targetPath='Original/Menu')
        s['responses'] = [r, copy.copy(r)]
        with self.assertRaisesRegex(AssertionError, 'Stop at response branch'):
            intro.intro_action(s, GRAPH)
        s['responses'][1]['visible'] = False
        self.assertEqual(intro.intro_action(s, GRAPH), 'response 205 145 206')
        s['responses'][0]['targetPath'] = ''
        with self.assertRaisesRegex(AssertionError, 'Unexpected response target'):
            intro.intro_action(s, GRAPH)

    def test_original_branch_holds(self):
        graph = copy.deepcopy(GRAPH)
        e = next(e for e in graph['entries'] if e['id'] == 205)
        e['outgoingLinks'].append(copy.copy(e['outgoingLinks'][0]))
        with self.assertRaisesRegex(AssertionError, 'Stop at original branching dialogue'):
            intro.intro_action(state(), graph)

    def test_bound_continue_receipt_distinguishes_dispatch_from_original_progression(self):
        s = state(259)
        receipt = dict(expectedConversationId=145, expectedEntryId=259,
                       actualConversationId=145, actualEntryId=259, active=True, result='applied')
        self.assertEqual(intro.continue_outcome(s, receipt), 'applied')
        for actual, active in [(259, False), (260, True)]:
            stale = dict(receipt, actualEntryId=actual, active=active, result='stale')
            self.assertEqual(intro.continue_outcome(s, stale), 'stale')
            with self.assertRaisesRegex(AssertionError, 'Inconsistent game-thread'):
                intro.continue_outcome(s, dict(stale, result='applied'))
        with self.assertRaisesRegex(AssertionError, 'does not match submission'):
            intro.continue_outcome(s, dict(receipt, expectedEntryId=260))

    def test_wrapper_waits_and_rejects_each_unexpected_identity(self):
        for entry in [0, 5, 8]:
            s = state(entry)
            s.update(conversationId=109, conversationState='')
            self.assertIsNone(intro.intro_action(s, GRAPH))
        for field, value, reason in [
            ('entryId', 9, 'Unexpected wrapper content'),
            ('conversationState', 'visible', 'Wrapper contains visible dialogue'),
            ('narrativeDbName', 'OtherStory', 'Wrapper belongs to another story'),
            ('narrativeArcName', 'other_arc', 'Unexpected intro arc'),
        ]:
            s = state(0)
            s.update(conversationId=109, conversationState='')
            s[field] = value
            with self.assertRaisesRegex(AssertionError, reason):
                intro.intro_action(s, GRAPH)

    def test_empty_metadata_and_inactive_wait_but_unknown_conversation_holds(self):
        empty = next(e['id'] for e in GRAPH['entries']
                     if not next(f['value'] for f in e['fields'] if f['title'] == 'Dialogue Text')
                     and len(e['outgoingLinks']) <= 1)
        self.assertIsNone(intro.intro_action(state(empty), GRAPH))
        # Original145:188 fans out to six named arc roots. It is metadata,
        # so waiting must precede the visible-content single-successor guard.
        self.assertIsNone(intro.intro_action(state(188), GRAPH))
        s = state()
        s['conversationActive'] = False
        self.assertIsNone(intro.intro_action(s, GRAPH))
        s.update(conversationActive=True, conversationId=225)
        with self.assertRaisesRegex(AssertionError, 'Stop at unexpected dialogue'):
            intro.intro_action(s, GRAPH)


if __name__ == '__main__':
    unittest.main()
