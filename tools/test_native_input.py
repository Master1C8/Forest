"""Input observation guards only; these tests do not emulate native event delivery."""
from pathlib import Path
import sys
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parent / 'probe'))
from diagnose_native_input import release_observed
from diagnose_newgame import keyboard_idle, loaded_travel, movement_ready
import json


class NativeReleaseObservation(unittest.TestCase):
    def test_gameplay_down_requires_all_arrows_released_and_zero_axes(self):
        row = {k: 'True' for k in ['nativeValid', 'nativeArrowsUp', 'asyncArrowsUp',
                                  'rewiredArrowsUp', 'unityArrowsUp']}
        row.update({k: '0,0,0' for k in ['actionAxes', 'fullAxis', 'bodyVelocity']})
        self.assertTrue(keyboard_idle(row))
        for key in row:
            with self.subTest(key=key):
                changed = dict(row)
                changed[key] = 'False' if row[key] == 'True' else '-1,0,0'
                self.assertFalse(keyboard_idle(changed))

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
