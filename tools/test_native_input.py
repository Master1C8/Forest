"""Input observation guards only; these tests do not emulate native event delivery."""
from pathlib import Path
import sys
import unittest
from unittest.mock import patch
import tempfile
import copy
import subprocess
import threading
import time

sys.path.insert(0, str(Path(__file__).resolve().parent / 'probe'))
from diagnose_native_input import release_observed, menu_guard, menu_ready, delivered_to_consumer, observe_menu_idle
from diagnose_newgame import keyboard_idle, loaded_travel, movement_ready
import diagnose_newgame as gameplay
import json


class NativeReleaseObservation(unittest.TestCase):
    def eligibility_fixture(self):
        """Explicit mock of newly observed fields; never historical runtime acceptance."""
        row = self.menu_fixture(focus='True', policy='True')
        source = json.loads((Path(__file__).resolve().parents[1] /
            'localization/source/travel-20261026/input-configuration.json').read_text())
        maps = []
        for original in source['keyboardMaps']:
            bindings = []
            for b in original['actionElementMaps']:
                if b['_actionId'] in (0, 1):
                    bindings.append(dict(action=b['_actionId'], key=b['_keyboardKeyCode'],
                        type=b['_elementType'], range=b['_axisRange'], pole=b['_axisContribution'],
                        modifier1=b['_modifierKey1'], modifier2=b['_modifierKey2'], modifier3=b['_modifierKey3'],
                        invert=bool(b['_invert']), enabled=True))
            maps.append(dict(source=original['id'], category=original['categoryId'], layout=original['layoutId'],
                             enabled=True, movement=bindings))
        row['keyboardMaps'] = json.dumps(dict(maps=maps))
        return row

    def mock_loaded_eligibility(self, loaded):
        row = self.eligibility_fixture()
        for key in ['rewiredReady', 'rewiredGlobalEnabled', 'rewiredFilter', 'rewiredFocusWatcher',
                    'rewiredOtherWatcher', 'rewiredInputAllowed', 'rewiredKeyboardAllowed', 'keyboardEnabled']:
            loaded['policy'][key] = row[key]
        loaded['input']['keyboardMaps'] = row['keyboardMaps']
        return loaded

    def test_actual35_single_passive_frame_is_insufficient_before_any_down(self):
        root = Path(__file__).resolve().parents[1]
        rows = [gameplay.diagnostic_fields([line], 'keyboard') for line in
                (root / 'localization/probes/ru-20261026-35/late-ready-passive-samples.txt').read_text().splitlines()]
        self.assertEqual(len(rows), 1)
        menu_guard(rows, 'True', 'False', minimum=1)  # observation only
        self.assertTrue(all(row['rewiredKeyboardAllowed'] == row['rewiredInputAllowed'] == 'False' for row in rows))
        with self.assertRaisesRegex(AssertionError, 'Need two real menu samples'):
            menu_ready(rows, 'True', 'False')

    def test_menu_waits_for_produced_frames_and_rejects_first_foreign_key(self):
        row = self.menu_fixture()
        for foreign in [False, True]:
            with self.subTest(foreign=foreign), tempfile.TemporaryDirectory() as directory:
                run = Path(directory)
                first = dict(row, nativeMovementDown='D') if foreign else row
                responses = iter([[first], [row, row]])
                def command(value):
                    self.assertEqual(value, 'sample-keyboard-snapshot')
                    samples = next(responses)
                    (run / 'keyboard-samples.txt').write_text('\n'.join('keyboard | '+' | '.join(k+'='+v for k,v in x.items()) for x in samples))
                with patch.object(gameplay, 'command', side_effect=command) as sender, patch('diagnose_native_input.time.sleep'):
                    if foreign:
                        with self.assertRaisesRegex(AssertionError, 'Unexplained movement producer'):
                            observe_menu_idle(run, 'False')
                        self.assertEqual(sender.call_count, 1)
                    else:
                        rows, focus = observe_menu_idle(run, 'False')
                        self.assertEqual((len(rows), focus), (2, 'False'))
                        self.assertEqual(sender.call_count, 2)

    def test_transport_waits_for_first_real_action_log_without_replaying_command(self):
        script = Path(__file__).resolve().parent / 'probe/command.py'
        # Stand-in tests the file transport only; Unity startup/action semantics
        # are not replaced evidence. Exercise both absent and existing log states.
        for existing in [False, True]:
            with self.subTest(existing=existing), tempfile.TemporaryDirectory() as directory:
                run = Path(directory) / 'Forest/localization/probes/transport'
                run.mkdir(parents=True)
                log = run / 'actions.log'
                if existing:
                    log.write_text('old OK unrelated\n')
                received = []
                def bridge():
                    deadline = time.monotonic() + 10
                    while not (run / 'command.txt').exists() and time.monotonic() < deadline:
                        time.sleep(.01)
                    if not (run / 'command.txt').exists():
                        return
                    received.append((run / 'command.txt').read_text())
                    (run / 'command.txt').unlink()
                    with log.open('a') as stream:
                        stream.write('test OK restore-input-policy\n')
                observer = threading.Thread(target=bridge)
                observer.start()
                result = subprocess.run([sys.executable, '-B', str(script), str(run), 'restore-input-policy'],
                                        capture_output=True, text=True, timeout=15)
                observer.join(timeout=1)
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual(received, ['restore-input-policy\n'])
                self.assertFalse((run / 'command.pending').exists())

    def test_missing_log_does_not_override_unknown_pending_command(self):
        script = Path(__file__).resolve().parent / 'probe/command.py'
        with tempfile.TemporaryDirectory() as directory:
            run = Path(directory) / 'Forest/localization/probes/transport'
            run.mkdir(parents=True)
            (run / 'command.txt').write_text('original unknown command\n')
            result = subprocess.run([sys.executable, '-B', str(script), str(run), 'quit'],
                                    capture_output=True, text=True, timeout=5)
            self.assertNotEqual(result.returncode, 0)
            self.assertIn('Reconcile the pending command', result.stderr)
            self.assertEqual((run / 'command.txt').read_text(), 'original unknown command\n')
            self.assertFalse((run / 'command.pending').exists())

    def menu_fixture(self, focus='False', policy='False'):
        row = dict(scene='StartMenu', gameplay='False', anyEvent='False', conversation='False',
                   actor='null', body='null', player='0:Player1', keyboardEnabled='True', nativeValid='True',
                   nativeKeyboard='True', unityInput='False', rewiredReady='True', rewiredGlobalEnabled='True',
                   ignoreUnfocused=policy, rewiredFilter=policy, focused=focus, rewiredFocusWatcher=focus,
                   rewiredOtherWatcher='False', rewiredInputAllowed='True', rewiredKeyboardAllowed='True',
                   actionAxes='0,0,0', fullAxis='0,0,0')
        for layer in ['native', 'async', 'rewired', 'unity']:
            row.update({layer + 'MovementUp': 'True', layer + 'MovementDown': '', layer + 'Left': 'False'})
        return row

    def test_menu_refuses_unfocused_original_down_but_allows_explicit_qa_policy(self):
        qa = self.menu_fixture()
        menu_ready([qa, qa], 'False', 'False')
        original = self.menu_fixture(policy='True')
        menu_guard([original, original], 'True', 'False')  # passive observation is allowed
        with self.assertRaisesRegex(AssertionError, 'Original filter with real focus=False'):
            menu_ready([original, original], 'True', 'False')
        focused = self.menu_fixture(focus='True', policy='True')
        menu_ready([focused, focused], 'True', 'True')
        with self.assertRaisesRegex(AssertionError, 'Original keyboard input disallowed'):
            menu_ready([dict(focused, rewiredKeyboardAllowed='False')]*2, 'True', 'True')

    def test_menu_down_requires_eight_key_idle_and_stable_real_focus_eligibility(self):
        row = self.menu_fixture()
        menu_ready([row, row], 'False', 'False')
        for field, value, reason in [('nativeMovementUp', 'False', 'All eight keys'),
                                     ('rewiredKeyboardAllowed', 'False', 'QA policy did not enable'),
                                     ('focused', 'True', 'Menu input/focus/policy guard changed'),
                                     ('nativeMovementDown', 'D', 'Unexplained movement producer'),
                                     ('fullAxis', '0,-1,0', 'Unexpected original menu axis')]:
            with self.subTest(field=field), self.assertRaisesRegex(AssertionError, reason):
                menu_ready([dict(row, **{field: value})]*2, 'False', 'False')

    def test_menu_success_requires_shipped_consumer_and_not_unused_unity_layer(self):
        row = self.menu_fixture()
        native = dict(row, nativeLeft='True', nativeMovementDown='LeftArrow', nativeMovementUp='False')
        self.assertFalse(delivered_to_consumer([native, row, row]))
        consumer = dict(native, rewiredLeft='True', rewiredMovementDown='LeftArrow', rewiredMovementUp='False',
                        actionAxes='-1,0,0', fullAxis='-1,0,0')
        menu_guard([row, consumer, row, row], 'False', 'False', pulse=True)
        self.assertTrue(delivered_to_consumer([row, consumer, row, row]))
        for field in ['rewiredLeft', 'actionAxes', 'fullAxis']:
            wrong = dict(consumer, **{field: 'False' if field.endswith('Left') else '0,0,0'})
            self.assertFalse(delivered_to_consumer([wrong, row, row]))

    def test_gameplay_down_requires_all_arrows_released_and_zero_axes(self):
        row = {k: 'True' for k in ['nativeValid', 'nativeArrowsUp', 'asyncArrowsUp',
                                  'rewiredArrowsUp', 'unityArrowsUp', 'nativeMovementUp',
                                  'asyncMovementUp', 'rewiredMovementUp', 'unityMovementUp']}
        row.update({k: '0,0,0' for k in ['actionAxes', 'fullAxis', 'bodyVelocity']})
        row.update({layer+'MovementDown': '' for layer in ['native', 'async', 'rewired', 'unity']})
        self.assertTrue(keyboard_idle(row))
        for key in row:
            with self.subTest(key=key):
                changed = dict(row)
                changed[key] = 'False' if row[key] == 'True' else '-1,0,0'
                self.assertFalse(keyboard_idle(changed))

    def test_original_wasd_must_be_observed_before_down(self):
        # Arrows and axes alone may be idle between input updates while an
        # original movement letter remains held. Never release that owner key.
        row = {k: 'True' for k in ['nativeValid', 'nativeArrowsUp', 'asyncArrowsUp',
                                  'rewiredArrowsUp', 'unityArrowsUp', 'nativeMovementUp',
                                  'asyncMovementUp', 'rewiredMovementUp', 'unityMovementUp']}
        row.update({k: '0,0,0' for k in ['actionAxes', 'fullAxis', 'bodyVelocity']})
        row.update({layer+'MovementDown': '' for layer in ['native', 'async', 'rewired', 'unity']})
        self.assertTrue(keyboard_idle(row))
        for layer in ['native', 'async', 'rewired', 'unity']:
            with self.subTest(layer=layer):
                held_d = dict(row, **{layer + 'MovementUp': 'False', layer + 'MovementDown': 'D'})
                self.assertFalse(keyboard_idle(held_d))
                unknown = dict(row)
                del unknown[layer + 'MovementUp']
                self.assertFalse(keyboard_idle(unknown))

    def test_pair_ignore_guard_rejects_after_other_movement_prerequisites_pass(self):
        # Actual30 topology with one explicitly MOCKED pair to exercise guards only.
        root = Path(__file__).resolve().parents[1]
        state = json.loads((root / 'localization/probes/ru-20261026-30/travel-route.json').read_text())
        state['diagnostics'].append('travelPair | playerCollider=-55552 | doorCollider=202506 | ignoredLayers=False | ignoredPair=False | distanceValid=True | overlapped=False | touching=False | distance=1')
        loaded = self.mock_loaded_eligibility(loaded_travel(state))
        self.assertEqual(movement_ready(loaded)['ignoredPair'], 'False')
        loaded['pairs'][0]['ignoredPair'] = 'True'
        with self.assertRaisesRegex(AssertionError, 'Root/door pair not ready'):
            movement_ready(loaded)

    def test_rejected_second_geometry_keeps_raw_state_and_stops_passive_sampler(self):
        root = Path(__file__).resolve().parents[1]
        state = json.loads((root / 'localization/probes/ru-20261026-32/loaded-travel-1.json').read_text())
        # Historical32 lacks the new fields: add explicit mocked observations
        # solely to exercise passive evidence preservation at the second dump.
        policy = self.eligibility_fixture()
        for i, line in enumerate(state['diagnostics']):
            if line.startswith('travelRewired | '):
                state['diagnostics'][i] += ''.join(' | '+k+'='+policy[k] for k in [
                    'rewiredReady','rewiredGlobalEnabled','rewiredFilter','rewiredFocusWatcher',
                    'rewiredOtherWatcher','rewiredInputAllowed','rewiredKeyboardAllowed','keyboardEnabled'])
            if line.startswith('travelInput | '):
                state['diagnostics'][i] += ' | keyboardMaps='+policy['keyboardMaps']
        loaded = loaded_travel(state)
        idle = {k: 'True' for k in ['nativeValid', 'nativeArrowsUp', 'asyncArrowsUp',
                                   'rewiredArrowsUp', 'unityArrowsUp', 'nativeMovementUp',
                                   'asyncMovementUp', 'rewiredMovementUp', 'unityMovementUp']}
        idle.update({k: '0,0,0' for k in ['actionAxes', 'fullAxis', 'bodyVelocity']})
        idle.update(self.eligibility_fixture())
        idle['bodyVelocity'] = '0,0,0'
        idle.update(scene='BunnyHouse', gameplay='True', anyEvent='False', conversation='False',
                    dustin='False', glitch='False', movement='True', lanternTransition='False',
                    sweaterTransition='False', waypoints='False', keyboardEnabled='True', ignoreUnfocused='True', focused='True',
                    actor=loaded['player']['path'] + '#' + loaded['player']['id'],
                    body=loaded['body']['path'] + '#' + loaded['body']['id'])
        for second_axis in ['0,0,0', '1,0,0']:
            with self.subTest(secondAxis=second_axis), tempfile.TemporaryDirectory() as directory:
                run = Path(directory)
                calls = []
                second = copy.deepcopy(state)
                second['diagnostics'][0] = second['diagnostics'][0].replace('axis=0,0,0', 'axis=' + second_axis)
                inputs = iter([state, second])

                def command(value):
                    calls.append(value)
                    if value == 'dump-travel':
                        (run / 'travel-route.json').write_text(json.dumps(next(inputs)))
                    elif value == 'sample-keyboard-stop':
                        (run / 'keyboard-samples.txt').write_text('mock passive samples; not real input delivery\n')

                with patch.object(gameplay, 'RUN', run), patch.object(gameplay, 'command', command), \
                     patch.object(gameplay, 'keyboard_samples', return_value=[idle, idle]), \
                     patch.object(gameplay.time, 'sleep'):
                    if second_axis == '0,0,0':
                        self.assertEqual(len(gameplay.observe_loaded_travel()), 2)
                    else:
                        with self.assertRaisesRegex(AssertionError, 'guarded idle gameplay'):
                            gameplay.observe_loaded_travel()
                        self.assertFalse((run / 'loaded-geometry.json').exists())
                self.assertEqual(json.loads((run / 'loaded-travel-2.json').read_text()), second)
                self.assertEqual(calls.count('sample-keyboard-start'), 1)
                self.assertEqual(calls[-1], 'sample-keyboard-stop')
                self.assertEqual((run / 'loaded-travel-input-samples.txt').read_bytes(),
                                 (run / 'keyboard-samples.txt').read_bytes())

    def route_fixture(self):
        root = Path(__file__).resolve().parents[1]
        loaded = loaded_travel(json.loads((root / 'localization/probes/ru-20261026-33/post-movement-travel.json').read_text()))
        # Mock newly required eligibility/maps as well as speed/physics.33 did
        # not observe those fields and is not a positive runtime control for them.
        self.mock_loaded_eligibility(loaded)
        loaded['player'].update(speed='1.2,1.2,0', currentSpeed='1.2,1.2,0')
        root_id = loaded['pairs'][0]['playerCollider']
        loaded['sweeps'] = [dict(direction=d, root=root_id, distance='1.2', count='0', capacity='128') for d in ['left', 'down']]
        return loaded

    def test_route_uses_left_before_down_and_stops_on_real_blocker(self):
        loaded = self.route_fixture()
        self.assertEqual(gameplay.route_pulse_plan(loaded, dict(left=0, down=0)), ('left', 400))
        loaded['body']['position'] = '2.50,1.29,0'
        self.assertEqual(gameplay.route_pulse_plan(loaded, dict(left=800, down=0)), ('down', 400))
        hit = dict(direction='down', ownChild='False', ignoredPair='False', distance='.30')
        loaded['sweepHits'] = [hit]
        with self.assertRaisesRegex(AssertionError, 'Original geometry blocks proposed pulse'):
            gameplay.route_pulse_plan(loaded, dict(left=800, down=0))
        loaded['sweepHits'][0]['distance'] = '.8'
        self.assertEqual(gameplay.route_pulse_plan(loaded, dict(left=800, down=0)), ('down', 400))
        with self.assertRaisesRegex(AssertionError, 'leg time bound exhausted'):
            gameplay.route_pulse_plan(loaded, dict(left=800, down=2400))
        loaded['sweeps'][1]['count'] = '128'
        with self.assertRaisesRegex(AssertionError, 'Physics query truncated'):
            gameplay.route_pulse_plan(loaded, dict(left=800, down=0))

    def test_actual_focus_must_pass_before_original_policy_task_down(self):
        loaded = self.route_fixture()
        gameplay.movement_ready(loaded)
        loaded['guards']['focused'] = 'False'
        with self.assertRaisesRegex(AssertionError, 'requires real Unity focus; no task DOWN'):
            gameplay.route_pulse_plan(loaded, dict(left=0, down=0))
        loaded['guards']['focused'] = 'True'
        loaded['policy']['ignoreUnfocused'] = 'False'
        with self.assertRaisesRegex(AssertionError, 'Original input policy changed; no task DOWN'):
            gameplay.movement_ready(loaded)

    def test_down_sample_rejects_foreign_producer_axis_or_story_guard(self):
        root = Path(__file__).resolve().parents[1]
        row = gameplay.diagnostic_fields([(root / 'localization/probes/ru-20261026-33/loaded-travel-input-samples.txt').read_text().splitlines()[-1]], 'keyboard')
        eligibility = self.eligibility_fixture()
        for key in ['rewiredReady','rewiredGlobalEnabled','rewiredFilter','rewiredFocusWatcher',
                    'rewiredOtherWatcher','rewiredInputAllowed','rewiredKeyboardAllowed','nativeKeyboard',
                    'unityInput','player','keyboardMaps']:
            row[key] = eligibility[key]  # explicit mocked fields absent from33
        loaded = self.route_fixture()
        row.update(actionAxes='0,-1,0', fullAxis='0,-1,0')
        for layer in ['native', 'async', 'rewired', 'unity']:
            row[layer + 'MovementDown'] = 'DownArrow'
        gameplay.route_sample_guard([row], 'down', loaded)
        for field, value, reason in [('nativeMovementDown', 'DownArrow,D', 'Unexplained movement producer'),
                                     ('actionAxes', '1,0,0', 'Unexpected original axis'),
                                     ('anyEvent', 'True', 'Gameplay/input guard changed')]:
            with self.subTest(field=field), self.assertRaisesRegex(AssertionError, reason):
                gameplay.route_sample_guard([dict(row, **{field:value})], 'down', loaded)
        # A separately observed natural door transition may change story guards;
        # it still cannot authorize an unrelated key or axis.
        gameplay.route_sample_guard([dict(row, anyEvent='True', routeDoorTransition='True')], 'down', loaded, transitioning=True)
        with self.assertRaisesRegex(AssertionError, 'Unexplained movement producer'):
            gameplay.route_sample_guard([dict(row, nativeMovementDown='D')], 'down', loaded, transitioning=True)

    def test_original_eligibility_each_predicate_and_missing_fields_reject(self):
        row = self.eligibility_fixture()
        gameplay.original_keyboard_guard(row)
        for key in ['focused','ignoreUnfocused','rewiredFilter','rewiredReady','rewiredGlobalEnabled',
                    'rewiredFocusWatcher','rewiredInputAllowed','rewiredKeyboardAllowed',
                    'keyboardEnabled','nativeKeyboard','unityInput','player']:
            for value in [None, 'False' if row[key] == 'True' else 'True']:
                changed = dict(row)
                if value is None:
                    del changed[key]
                else:
                    changed[key] = value
                with self.subTest(key=key,value=value), self.assertRaisesRegex(AssertionError, 'Original keyboard eligibility changed'):
                    gameplay.original_keyboard_guard(changed)
        with self.assertRaisesRegex(AssertionError, 'Missing actual Rewired other watcher'):
            gameplay.original_keyboard_guard(dict(row, rewiredOtherWatcher='unknown'))

    def test_original_map_identity_bindings_flags_and_multiplicity(self):
        row = self.eligibility_fixture()
        gameplay.original_keyboard_guard(row)
        for change, reason in [('disabled','disabled or rebound'),('duplicate','bindings changed'),
                               ('key','bindings changed'),('modifier','binding flags changed'),
                               ('identity','map identity changed'),('rebound','disabled or rebound')]:
            maps = json.loads(row['keyboardMaps'])
            movement = maps['maps'][0]
            if change == 'disabled': movement['enabled'] = False
            elif change == 'duplicate': movement['movement'].append(copy.deepcopy(movement['movement'][0]))
            elif change == 'key': movement['movement'][0]['key'] = 0
            elif change == 'modifier': movement['movement'][0]['modifier1'] = 1
            elif change == 'identity': movement['source'] = 2
            else: maps['maps'][1]['movement'] = movement['movement']
            with self.subTest(change=change), self.assertRaisesRegex(AssertionError, reason):
                gameplay.original_keyboard_guard(dict(row, keyboardMaps=json.dumps(maps)))
        with self.assertRaisesRegex(AssertionError, 'Missing actual original keyboard maps'):
            gameplay.original_keyboard_guard(dict(row, keyboardMaps='null'))

    def test_transition_story_changes_never_bypass_eligibility_or_player_identity(self):
        loaded = self.route_fixture()
        row = dict(self.eligibility_fixture(), scene='BunnyHouse', anyEvent='True', conversation='True', routeDoorTransition='True',
                   actor=loaded['player']['path']+'#'+loaded['player']['id'],
                   body=loaded['body']['path']+'#'+loaded['body']['id'])
        gameplay.route_sample_guard([row], 'down', loaded, transitioning=True)
        for direction, transition in [('down','False'), ('left','True')]:
            with self.subTest(direction=direction), self.assertRaisesRegex(AssertionError, 'Gameplay/input guard changed'):
                gameplay.route_sample_guard([dict(row, routeDoorTransition=transition)], direction, loaded, transitioning=True)
        for field, value, reason in [('rewiredInputAllowed','False','eligibility changed'),
                                     ('rewiredFilter','False','eligibility changed'),
                                     ('focused','False','eligibility changed'),
                                     ('nativeValid','False','original keyboard policy'),
                                     ('actor','other#1','Player sample identity changed')]:
            with self.subTest(field=field), self.assertRaisesRegex(AssertionError, reason):
                gameplay.route_sample_guard([dict(row, **{field:value})], 'down', loaded, transitioning=True)

    def test_route_ingress_requires_native_rewired_and_axes_in_same_frame(self):
        row = dict(self.eligibility_fixture(), nativeMovementDown='DownArrow')
        consumer = dict(row, nativeMovementDown='', rewiredMovementDown='DownArrow', actionAxes='0,-1,0', fullAxis='0,-1,0')
        self.assertFalse(gameplay.route_consumer_ingress([row, consumer], 'down'))
        self.assertTrue(gameplay.route_consumer_ingress([dict(consumer, nativeMovementDown='DownArrow')], 'down'))

    def test_passive_original_menu_gate_stops_and_preserves_rejected_rows(self):
        for eligible in [True, False]:
            with self.subTest(eligible=eligible), tempfile.TemporaryDirectory() as directory:
                run = Path(directory)
                row = self.eligibility_fixture()
                if not eligible: row['rewiredInputAllowed'] = 'False'
                text = '\n'.join(['keyboard | '+' | '.join(k+'='+v for k,v in row.items())]*2)+'\n'
                def command(value):
                    if value in ['sample-keyboard-snapshot','sample-keyboard-stop']:
                        (run/'keyboard-samples.txt').write_text(text)
                with patch.object(gameplay,'RUN',run), patch.object(gameplay,'command',side_effect=command) as sender:
                    if eligible:
                        gameplay.observe_original_menu()
                        self.assertTrue((run/'original-menu-readiness.json').exists())
                    else:
                        with self.assertRaisesRegex(AssertionError,'Original keyboard eligibility changed'):
                            gameplay.observe_original_menu()
                        self.assertFalse((run/'original-menu-readiness.json').exists())
                    self.assertEqual(sender.call_args_list[-1].args, ('sample-keyboard-stop',))
                    self.assertFalse(any(c.args[0].startswith(('menu ','qa-')) for c in sender.call_args_list))
                self.assertEqual((run/'original-menu-idle-samples.txt').read_text(), text)

    def test_original_menu_requires_two_complete_real_observations(self):
        row = self.eligibility_fixture()
        gameplay.original_menu_ready([row,row])
        with self.assertRaisesRegex(AssertionError, 'two real original menu idle frames'):
            gameplay.original_menu_ready([row])
        with self.assertRaisesRegex(AssertionError, 'Original keyboard eligibility changed'):
            historical = dict(row)
            del historical['rewiredReady']
            gameplay.original_menu_ready([historical,historical])

    def test_route_release_requires_idle_existing_body_or_observed_absence(self):
        row = dict(self.eligibility_fixture(), body='Player#1', bodyVelocity='0,0,0')
        self.assertTrue(gameplay.input_released(row))
        self.assertFalse(gameplay.input_released(dict(row,bodyVelocity='0,-1.2,0')))
        self.assertFalse(gameplay.input_released(dict(row,bodyVelocity='null')))
        self.assertTrue(gameplay.input_released(dict(row,body='null',bodyVelocity='null')))
        self.assertFalse(gameplay.input_released(dict(row,nativeMovementUp='False')))

    def test_process_cleanup_finds_new_exact_task_child_after_old_pids_exit(self):
        game = Path('/Users/antonkrutov/Desktop/Forest/localization/probes/ru-20261026-37/game')
        child = '38362 1 Y:'+str(game/'UnityCrashHandler64.exe').replace('/Users/antonkrutov','').replace('/',chr(92))+' 204 549064704'
        other = child.replace('ru-20261026-37','ru-20261026-36').replace('38362','40000')
        # A new PID is still owned through the exact frozen executable path.
        # No actual game/process is started or stopped by this mocked test.
        with patch.object(gameplay,'GAME',game), patch.object(gameplay,'EXE',game/'The Forest of Love.exe'), \
             patch.object(gameplay.subprocess,'check_output',return_value=child+'\n'+other+'\n'):
            self.assertEqual(gameplay.processes(),[child])

    def test_recovery_requires_actual_same_target_task_down(self):
        identity = dict(pid=123, windowID=44)
        header = json.dumps(dict(identity, mode='down'))
        edge = 'postDownDown pid=123 window=44 unixTime=1.0'
        self.assertTrue(gameplay.posted_task_down(header + '\n' + edge, 'down', identity))
        for wrong in [header, header + '\npostDownUp pid=123 window=44 unixTime=1',
                      header + '\n' + edge.replace('123', '999'),
                      header.replace('"down"', '"left"') + '\n' + edge, '']:
            self.assertFalse(gameplay.posted_task_down(wrong, 'down', identity))
        self.assertFalse(gameplay.posted_task_down(header + '\n' + edge, 'down', dict(pid=123, windowID=45)))

    def test_delivery_and_release_are_distinct(self):
        up = {key: 'False' for key in ['nativeLeft', 'asyncLeft', 'rewiredLeft', 'unityLeft']}
        down = dict(up, asyncLeft='True')
        for label, samples, expected in [
            ('no observed down', [up, up], False),
            ('candidate27 last-sample down', [up, down], False),
            ('only one up sample', [down, up], False),
            ('down then two released samples', [down, up, up], True),
            ('Rewired remains down', [down, up, dict(up, rewiredLeft='True')], False),
        ]:
            with self.subTest(label=label):
                self.assertEqual(release_observed(samples), expected)


if __name__ == '__main__':
    unittest.main()
