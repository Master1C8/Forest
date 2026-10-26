"""Input observation guards only; these tests do not emulate native event delivery."""
from pathlib import Path
import sys
import unittest
from unittest.mock import patch
import tempfile
import copy

sys.path.insert(0, str(Path(__file__).resolve().parent / 'probe'))
from diagnose_native_input import release_observed
from diagnose_newgame import keyboard_idle, loaded_travel, movement_ready
import diagnose_newgame as gameplay
import json


class NativeReleaseObservation(unittest.TestCase):
    def test_gameplay_down_requires_all_arrows_released_and_zero_axes(self):
        row = {k: 'True' for k in ['nativeValid', 'nativeArrowsUp', 'asyncArrowsUp',
                                  'rewiredArrowsUp', 'unityArrowsUp', 'nativeMovementUp',
                                  'asyncMovementUp', 'rewiredMovementUp', 'unityMovementUp']}
        row.update({k: '0,0,0' for k in ['actionAxes', 'fullAxis', 'bodyVelocity']})
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
        loaded = loaded_travel(state)
        self.assertEqual(movement_ready(loaded)['ignoredPair'], 'False')
        loaded['pairs'][0]['ignoredPair'] = 'True'
        with self.assertRaisesRegex(AssertionError, 'Root/door pair not ready'):
            movement_ready(loaded)

    def test_rejected_second_geometry_keeps_raw_state_and_stops_passive_sampler(self):
        root = Path(__file__).resolve().parents[1]
        state = json.loads((root / 'localization/probes/ru-20261026-32/loaded-travel-1.json').read_text())
        loaded = loaded_travel(state)
        idle = {k: 'True' for k in ['nativeValid', 'nativeArrowsUp', 'asyncArrowsUp',
                                   'rewiredArrowsUp', 'unityArrowsUp', 'nativeMovementUp',
                                   'asyncMovementUp', 'rewiredMovementUp', 'unityMovementUp']}
        idle.update({k: '0,0,0' for k in ['actionAxes', 'fullAxis', 'bodyVelocity']})
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
        # Mock only the newly added source speed and read-only physics producer.
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
        gameplay.route_sample_guard([dict(row, anyEvent='True')], 'down', loaded, transitioning=True)
        with self.assertRaisesRegex(AssertionError, 'Unexplained movement producer'):
            gameplay.route_sample_guard([dict(row, nativeMovementDown='D')], 'down', loaded, transitioning=True)

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
