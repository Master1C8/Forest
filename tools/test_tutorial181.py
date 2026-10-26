"""Host contracts only: synthetic states/ACKs replace Unity and transport.

Original readback and compiled bridge checks are separate from these tests.
"""
import copy
import json
import unittest
from pathlib import Path
import tempfile
from unittest.mock import patch
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))
from test_save_continue import probe, PREFIX, FIXTURE, loaded, tutorial, response, ack, stamp

ROOT = Path(__file__).resolve().parents[1]
PLAN = json.loads((ROOT / 'localization/source/tutorial181-20261027/original/route-plan.json').read_text())


def menu(frame=10):
    state = stamp(tutorial(158, [response(159), response(181)]), frame=frame)
    text = 'The love. Definitely the love.'
    path = probe.TUTORIAL_TEXT_PANEL + '/Response Menu Panel/Viewport/Content/Response: ' + text
    state['tutorial181Record'] = json.dumps(dict(frame=frame, conversationId=120, sourceId=158,
        destinationId=181, successorId=182, choiceMode='original', text=text, path=path,
        targetPath=probe.TUTORIAL_UI, listenerMethod='OnClick', listenerTargetPath=path,
        typing=False, graphVerified=True, listenerVerified=True, buttonInstance=21, controllerInstance=31))
    return state


def route(eid, frame=11, **changes):
    entry = next(e for e in PLAN['entries'] if e['id'] == eid)
    text = entry['text'].split(']', 1)[1] if entry['text'].startswith('[pic=') else entry['text']
    return dict(tutorial(), entryId=eid, conversationState=text, frame=frame, realtime=float(frame), **changes)


def armed():
    tracker = probe.Tutorial181Transitions(PREFIX, PLAN)
    tracker.prefix_tracker.observe(tutorial(), 1)
    # Exercise the real admitted prefix transition ordering with an acknowledged154.
    tracker.prefix_tracker.acknowledge_response(tutorial(153, [response(154)]), 'response 153 120 154', ack('response 153 120 154'))
    for eid in [155, 156, 157]:
        tracker.observe(dict(tutorial(eid), frame=eid), eid)
    state = menu()
    tracker.observe(state, 200)
    action = tracker.action(state)
    receipt = dict(json.loads(state['tutorial181Record']), frame=11, result='submitted')
    return tracker, state, action, ack(action, 201), receipt


class Tutorial181(unittest.TestCase):
    def test_plan_positive_and_exact_link_actor_control_rejections(self):
        probe.tutorial181_plan_guard(PLAN)
        for key, value, reason in [('actor', '1', 'actors'), ('script', 'mutate()', 'controls'),
                ('outgoingLinks', [], 'link'), ('onExecute', {'m_PersistentCalls': {'m_Calls': [1]}}, 'callback')]:
            plan = copy.deepcopy(PLAN)
            next(e for e in plan['entries'] if e['id'] == 182)[key] = value
            with self.subTest(key=key), self.assertRaisesRegex(AssertionError, reason):
                probe.tutorial181_plan_guard(plan)

    def test_exact_menu_positive_and_default_still_stops(self):
        state = menu()
        self.assertEqual(probe.tutorial_action(state, PREFIX), 'target-settled')
        self.assertEqual(probe.Tutorial181Transitions(PREFIX, PLAN).action(state), 'select-tutorial181 10 21')

    def test_source_record_stale_and_wrong_destination_control_listener(self):
        state = menu()
        for key, value, reason in [('frame', 9, 'Stale/wrong'), ('destinationId', 159, 'Stale/wrong'),
                ('successorId', 183, 'Stale/wrong'), ('text', 'wrong', 'control/listener'),
                ('targetPath', 'wrong', 'control/listener'), ('choiceMode', 'synthetic', 'control/listener'),
                ('listenerMethod', 'Wrong', 'control/listener'), ('listenerVerified', False, 'unverified'),
                ('controllerInstance', 0, 'identity')]:
            bad = copy.deepcopy(state); row = json.loads(bad['tutorial181Record']); row[key] = value
            bad['tutorial181Record'] = json.dumps(row)
            with self.subTest(key=key), self.assertRaisesRegex(AssertionError, reason):
                probe.tutorial181_selection_guard(bad, PREFIX)

    def test_explicit_native_rejection_preserves_menu_and_forbids_selection(self):
        state = menu()
        state['tutorial181Record'] = json.dumps(dict(status='rejected', error='Tutorial181 original response control differs'))
        state['tutorial181ControlRecord'] = json.dumps(dict(matches=1, controllerEnabled=False))
        self.assertEqual(probe.tutorial_action(state, PREFIX), 'target-settled')
        with self.assertRaisesRegex(AssertionError, 'native admission rejected:.*control=.*controllerEnabled'):
            probe.Tutorial181Transitions(PREFIX, PLAN).action(state)

    def test_mode_and_typing_admission(self):
        with self.assertRaisesRegex(AssertionError, 'original mode'):
            probe.Tutorial181Transitions(PREFIX, PLAN, 'synthetic')
        with self.assertRaisesRegex(AssertionError, 'ready menu'):
            probe.tutorial181_selection_guard(stamp(menu(), typing=True), PREFIX)
        for args in [['run', '--tutorial181'], ['run', '--tutorial181', '--continue-fixture', '--tutorial-choice-mode', 'synthetic']]:
            with self.assertRaisesRegex(AssertionError, 'original QA43'):
                probe.launch_options(args)
        self.assertTrue(probe.launch_options(['run', '--tutorial181', '--continue-fixture']).tutorial181)

    def test_ack_separate_actual182_and_no_replay(self):
        tracker, state, action, transport, receipt = armed()
        tracker.acknowledge_selection(state, action, transport, receipt)
        self.assertFalse(tracker.receipt()['actual182Observed'])
        tracker.observe(route(182), 202)
        self.assertTrue(tracker.receipt()['actual182Observed'])
        self.assertEqual(tracker.action(route(182)), 'continue-bound 120 182')
        with self.assertRaisesRegex(AssertionError, 'no replay'):
            tracker.acknowledge_selection(state, action, transport, receipt)

    def test_wrong_ack_timestamp_native_binding_and_stale_host(self):
        for change, reason in [('ack', 'exact.*ACK'), ('time', 'Stale.*ACK'), ('receipt', 'binding differs'), ('host', 'Stale.*host'), ('frame', 'Stale.*receipt')]:
            tracker, state, action, transport, receipt = armed()
            if change == 'ack': transport['acknowledgement'] = 'bad OK wrong'
            if change == 'time': transport['submittedAt'] = 1
            if change == 'receipt': receipt['buttonInstance'] = 999
            if change == 'host': tracker.observed_frame = 9
            if change == 'frame': receipt['frame'] = 131
            with self.subTest(change=change), self.assertRaisesRegex(AssertionError, reason):
                tracker.acknowledge_selection(state, action, transport, receipt)

    def test_actual182_cannot_be_skipped_or_synthesized_by_ack(self):
        tracker, state, action, transport, receipt = armed()
        tracker.acknowledge_selection(state, action, transport, receipt)
        with self.assertRaisesRegex(AssertionError, 'actual successor'):
            tracker.observe(route(183), 202)
        tracker.observe(route(181), 202)
        self.assertFalse(tracker.receipt()['actual182Observed'])
        tracker.observe(route(182, frame=12), 203)
        with self.assertRaisesRegex(AssertionError, 'skipped/backtracked'):
            tracker.observe(route(184, frame=13), 204)

    def test_full_route_typing_menu_text_and_early_cleanup_guards(self):
        tracker, state, action, transport, receipt = armed()
        tracker.acknowledge_selection(state, action, transport, receipt)
        for frame, eid in enumerate(probe.TUTORIAL181_ROUTE[1:], 11):
            tracker.observe(route(eid, frame), frame+200)
            self.assertIsNone(tracker.action(route(eid, frame, typing=True)))
            self.assertEqual(tracker.action(route(eid, frame)), 'continue-bound 120 '+str(eid))
        self.assertEqual(tracker.route_observed, probe.TUTORIAL181_ROUTE[1:])
        ended = dict(tutorial(), conversationActive=False, narrativeDbName='', entryId=0)
        self.assertEqual(tracker.action(ended), 'route-ended')
        tracker, state, action, transport, receipt = armed()
        tracker.acknowledge_selection(state, action, transport, receipt)
        for bad, reason in [(ended, 'before187'), (route(182, responses=[response(159)]), 'unexpected response'),
                (dict(route(182), conversationState='wrong'), 'exact source')]:
            with self.assertRaisesRegex(AssertionError, reason): tracker.action(bad)

    def test_cleanup_two_actual_frames_and_caps_unchanged(self):
        tracker, state, action, transport, receipt = armed()
        tracker.acknowledge_selection(state, action, transport, receipt)
        for frame, eid in enumerate(probe.TUTORIAL181_ROUTE[1:], 11): tracker.observe(route(eid, frame), 202+frame)
        budget = probe.ContinueObservationBudget(0)
        budget.stage = 'dialogue'
        budget.progress_at = 49
        saved = dict(scene='CentralForest', gameplay=True, anyEvent=True, conversation=False, playerPresent=True)
        ended = dict(tutorial(), conversationActive=False, narrativeDbName='', narrativeArcName='', entryId=0)
        _, terminal = probe.observe_tutorial181(budget, tracker, 50, dict(ended, frame=100, realtime=100.), saved)
        self.assertFalse(terminal)
        self.assertEqual(budget.stage, 'cleanup')
        self.assertEqual(budget.deadline, 65)
        saved['anyEvent'] = False
        self.assertFalse(probe.observe_tutorial181(budget, tracker, 51, dict(ended, frame=101, realtime=101.), saved)[1])
        self.assertTrue(probe.observe_tutorial181(budget, tracker, 52, dict(ended, frame=102, realtime=102.), saved)[1])
        self.assertEqual(budget.deadline, 65)
        with self.assertRaisesRegex(AssertionError, 'new real frame'):
            probe.observe_tutorial181(budget, tracker, 53, dict(ended, frame=102, realtime=102.), saved)

    def test_ordinary_host_loop_selects_once_follows_source_and_never_captures(self):
        # Real host/planner/guards, mocked file transport and Unity producers.
        with tempfile.TemporaryDirectory() as tmp:
            run = Path(tmp)
            (run/'tutorial-prefix.json').write_text(json.dumps(PREFIX))
            (run/'tutorial181-plan.json').write_text(json.dumps(PLAN))
            ready = dict(loaded(), diagnosticsReady=True, dataServicePresent=True,
                manifestPresent=True, dataServiceInstance=101, notReady=[])
            first = dict(ready, components=['PlayMenu Canvas/PlayMenu'], buttons=['Canvas/PlayMenu/Controls/Continue'])
            states = [tutorial(153, [response(154)]), tutorial(155), tutorial(156), tutorial(157), tutorial(158), menu(),
                *[route(eid) for eid in probe.TUTORIAL181_ROUTE[1:]],
                *[dict(tutorial(), conversationActive=False, narrativeDbName='', narrativeArcName='', entryId=0) for _ in range(2)]]
            for frame, state in enumerate(states, 1):
                state.update(frame=frame, realtime=float(frame))
                if state['entryId'] == 158:
                    updated = stamp(state, frame=frame); state.update(updated)
                    if state.get('tutorial181Record'):
                        row=json.loads(state['tutorial181Record']); row['frame']=frame; state['tutorial181Record']=json.dumps(row)
            calls = []; index = -1
            def command(cmd, **kwargs):
                nonlocal index
                calls.append(cmd)
                if cmd == 'dump-save-continuation':
                    saved = dict(ready)
                    if index >= -1 and calls.count('dump-save-continuation') > 1:
                        next_state = states[index+1]
                        saved.update(scene='CentralForest', gameplay=True, anyEvent=next_state['conversationActive'],
                            conversation=next_state['conversationActive'], playerPresent=True,
                            playerPath='SpawnedContent/Player/Content/Player(Clone)', playerInstance=50,
                            playerPosition=FIXTURE['playerRespawnData']['lastPosition'], tutorialIntroControllers=1)
                    (run/'save-continuation.json').write_text(json.dumps(saved))
                elif cmd == 'dump-intro':
                    index += 1; state = dict(states[index])
                    state['responseRecords'] = [json.dumps(r) for r in state['responses']]
                    state['responseCount'] = len(state['responses'])
                    (run/'intro-state.json').write_text(json.dumps(state))
                elif cmd == 'complete-tutorial158':
                    row=json.loads(states[index]['tutorialCompletionRecord']); row['result']='applied'
                    (run/'completion158-receipt.json').write_text(json.dumps(row))
                elif cmd.startswith('select-tutorial181 '):
                    row=json.loads(states[index]['tutorial181Record']); row['result']='submitted'
                    (run/'selection181-receipt.json').write_text(json.dumps(row))
                elif cmd.startswith('continue-bound '):
                    eid=int(cmd.split()[-1])
                    (run/'continue-receipt.json').write_text(json.dumps(dict(result='applied',active=True,
                        expectedConversationId=120,expectedEntryId=eid,actualConversationId=120,actualEntryId=eid)))
                elif cmd in ['dump-tutorial', 'dump-notebook']:
                    (run/('tutorial-route.json' if cmd=='dump-tutorial' else 'notebook-route.json')).write_text('{}')
                return ack(cmd, 1)
            with patch.object(probe,'RUN',run), patch.object(probe,'command',side_effect=command), \
                    patch.object(probe,'qa_identity'), patch.object(probe.time,'monotonic',return_value=1), \
                    patch.object(probe.time,'sleep'):
                probe.continue_from_fixture(first,FIXTURE,probe.ContinueObservationBudget(0),continue181=True)
            selections = [c for c in calls if c.startswith('select-tutorial181 ')]
            self.assertEqual(len(selections),1)
            self.assertEqual(calls.count('complete-tutorial158'),1)
            self.assertFalse(any(c.startswith('capture ') for c in calls))
            result=json.loads((run/'continue-progression.json').read_text())
            self.assertEqual(result['result'],'ordinary181-route-cleanup')
            self.assertTrue(result['subtitleAndResponseEvidence']['actual182Observed'])
            self.assertEqual(len(result['actualTerminalFrames']),2)


if __name__ == '__main__':
    unittest.main()
