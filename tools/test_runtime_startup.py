"""Real subprocess/file-event tests; no Unity or Wine behavior is replaced as proof."""
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from probe.runtime_startup import wait_for_probe


class StartupBoundary(unittest.TestCase):
    def test_real_early_exit_retains_code_instead_of_waiting_for_marker_timeout(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            child = subprocess.Popen([sys.executable, '-c', 'raise SystemExit(7)'])
            self.addCleanup(lambda: child.wait(timeout=2))
            with self.assertRaisesRegex(RuntimeError, 'startup-process-exited'):
                wait_for_probe(root, child, lambda: [], 2, interval=.01)
            receipt = json.loads((root / 'startup-state.json').read_text())
            self.assertEqual(receipt['launcherExitCode'], 7)
            self.assertFalse(receipt['markerSeen'])

    def test_marker_with_live_child_and_exited_wrapper_with_survivor(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            survivor = subprocess.Popen([sys.executable, '-c', 'import time; time.sleep(10)'])
            try:
                (root / 'player.log').write_bytes(b'engine startup\nFOREST_PROBE_READY\n')
                rows = lambda: [f'{survivor.pid} verified-test-child'] if survivor.poll() is None else []
                self.assertEqual(wait_for_probe(root, survivor, rows, 2)['status'], 'ready')
                wrapper = subprocess.Popen([sys.executable, '-c', 'pass'])
                wrapper.wait(timeout=2)
                receipt = wait_for_probe(root, wrapper, rows, 2)
                self.assertEqual(receipt['status'], 'ready')
                self.assertEqual(receipt['launcherExitCode'], 0)
                self.assertTrue(receipt['ownedProcessRows'])
            finally:
                survivor.terminate()
                survivor.wait(timeout=2)

    def test_identity_bound_file_does_not_depend_on_log_flush(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            expected = {'companyName': 'VNRevivalQA', 'productName': 'ForestRuFixture'}
            (root / 'build.json').write_text(json.dumps({'saveIsolation': expected}))
            child = subprocess.Popen([sys.executable, '-c', 'import time;time.sleep(10)'])
            try:
                value = '1\nVNRevivalQA\nForestRuFixture\n' + str(root / 'game/The Forest of Love_Data')
                (root / 'bridge-ready.txt').write_text(value)
                receipt = wait_for_probe(root, child, lambda: [str(child.pid)], 1)
                self.assertTrue(receipt['readinessFileVerified'])
                self.assertFalse(receipt['logMarkerSeen'])
                (root / 'bridge-ready.txt').write_text(value.replace('ForestRuFixture', 'OtherProfile'))
                with self.assertRaisesRegex(RuntimeError, 'startup-readiness-invalid'):
                    wait_for_probe(root, child, lambda: [str(child.pid)], 1)
            finally:
                child.terminate()
                child.wait(timeout=2)


if __name__ == '__main__':
    unittest.main()
