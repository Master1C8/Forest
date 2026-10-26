"""Passive exact-PID evidence; real child/ps, with Unity argv supplied as a fixture."""
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import Mock, patch

sys.path.insert(0, str(Path(__file__).resolve().parent / 'probe'))
import diagnose_newgame as host


class NativeIdentityEvidence(unittest.TestCase):
    exe = Path('/Users/antonkrutov/Desktop/Forest/localization/probes/fixture/game/The Forest of Love.exe')

    def setUp(self):
        for name, value in [('NATIVE_IDENTITY_RUN', None), ('NATIVE_IDENTITY', None), ('COMMAND_HOLD', None)]:
            guard = patch.object(host, name, value)
            guard.start()
            self.addCleanup(guard.stop)

    def test_real_pid_remains_after_argv_loss_but_never_authorizes_command(self):
        with tempfile.TemporaryDirectory() as folder:
            run = Path(folder)
            exe = self.exe
            child = subprocess.Popen([sys.executable, '-c', 'import sys; sys.stdin.read()'], stdin=subprocess.PIPE)
            try:
                row = f'{child.pid} {os.getpid()} {exe}'
                with patch.object(host, 'RUN', run), patch.object(host, 'EXE', exe), \
                     patch.object(host, 'LAUNCHER', Mock(pid=1, poll=Mock(return_value=7))):
                    bound = host.numeric_identity_evidence([row])
                    self.assertEqual(bound['status'], 'bound')
                    still_alive = host.numeric_identity_evidence([])
                    self.assertEqual(still_alive['status'], 'same-pid-birth-present')
                    self.assertFalse(still_alive['argvStillMatches'])
                    self.assertIsNone(still_alive['gameExitCode'])
                    self.assertIsNone(child.poll())
                    with patch.object(host, 'processes', return_value=[]), \
                         patch.object(host.subprocess, 'Popen') as sender, \
                         patch.object(host, 'numeric_pid_snapshot', return_value=still_alive['sample']):
                        with self.assertRaisesRegex(AssertionError, 'before command; no submission'):
                            host.command('dump-intro')
                        sender.assert_not_called()
                    event = json.loads((run/'process-lifetime.jsonl').read_text())
                    self.assertEqual(event['nativeIdentityEvidence']['status'], 'same-pid-birth-present')
                    self.assertEqual(event['realGameRows'], [])
                    self.assertEqual(event['launcherExitCode'], 7)
                    self.assertIsNone(event['gameExitCode'])
                    self.assertFalse((run/'command.txt').exists())
                    child.stdin.close()
                    self.assertEqual(child.wait(timeout=5), 0)
                    absent = host.numeric_identity_evidence([])
                    self.assertEqual(absent['status'], 'absent')
                    self.assertIsNone(absent['gameExitCode'])
            finally:
                if child.stdin and not child.stdin.closed:
                    child.stdin.close()
                child.wait(timeout=5)

    def test_pid_reuse_is_distinct_from_same_process_presence(self):
        with patch.object(host, 'RUN', Path('/fixture')), patch.object(host, 'EXE', self.exe):
            with patch.object(host, 'numeric_pid_snapshot', return_value=dict(
                    status='present', pid=123, birth='before', completedUtc='fixture')):
                self.assertEqual(host.numeric_identity_evidence(['123 1 '+str(self.exe)])['status'], 'bound')
            for birth, expected in [('before', 'same-pid-birth-present'), ('after', 'pid-reused')]:
                with patch.object(host, 'numeric_pid_snapshot', return_value=dict(
                        status='present', pid=123, birth=birth, completedUtc='fixture')):
                    result = host.numeric_identity_evidence([])
                self.assertEqual(result['status'], expected)
                self.assertEqual(result['identity']['birth'], 'before')
                self.assertIsNone(result['gameExitCode'])

    def test_ambiguous_or_absent_argv_cannot_bind_a_numeric_identity(self):
        with patch.object(host, 'RUN', Path('/fixture')), patch.object(host, 'EXE', self.exe), \
             patch.object(host, 'numeric_pid_snapshot') as snapshot:
            for rows in [[], ['123 1 '+str(self.exe), '124 1 '+str(self.exe)]]:
                self.assertEqual(host.numeric_identity_evidence(rows)['status'], 'unbound')
            snapshot.assert_not_called()

    def test_ps_absence_malformed_and_timeout_are_different(self):
        present = '123 1 Tue Oct 27 03:00:00 2026 S /fixture/wineloader\n'
        for code, stdout, expected in [(0, present, 'present'), (1, '', 'absent'),
                                       (0, '', 'unknown'), (0, present.replace('123', '124'), 'unknown'),
                                       (2, '', 'unknown')]:
            with patch.object(host.subprocess, 'run', return_value=subprocess.CompletedProcess([], code, stdout, '')):
                self.assertEqual(host.numeric_pid_snapshot(123)['status'], expected)
        with patch.object(host.subprocess, 'run', side_effect=subprocess.TimeoutExpired(['ps'], 2)):
            sample = host.numeric_pid_snapshot(123)
        self.assertEqual(sample['status'], 'unknown')
        self.assertEqual(sample['errorType'], 'TimeoutExpired')


if __name__ == '__main__':
    unittest.main()
