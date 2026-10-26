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
                    sweaterTransition='False', waypoints='False', keyboardEnabled='True', ignoreUnfocused='True',
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
