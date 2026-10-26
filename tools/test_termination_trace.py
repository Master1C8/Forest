"""Synthetic retention/real pipe controls; no Wine, Unity, native input or images."""
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import time
import unittest
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).resolve().parent / 'probe'))
from termination_trace import TerminationTrace
import diagnose_newgame as host


IDENTITY = dict(windowsPid=204, nativePid=1234, nativeBirth='fixture-birth',
                argvRow='1234 1 /fixture/game.exe', boundUtc='fixture-utc')


def line(function='quit_callback', body='terminating process', pid='00cc', level='trace', channel='macdrv'):
    return f'44386.152:{pid}:00d0:{level}:{channel}:{function} {body}\n'.encode()


class RetentionControls(unittest.TestCase):
    def collector(self):
        collector = TerminationTrace()
        collector.bind(IDENTITY)
        return collector

    def test_every_quit_boundary_and_exact_original_bytes(self):
        collector = self.collector()
        rows = [
            line('macdrv_app_quit_requested', 'reason 0'),
            line('macdrv_app_quit_request', 'sending WM_QUERYENDSESSION to win 000000000002003e'),
            line(body='got WM_QUERYENDSESSION result 1 from win 000000000002003e (1 of 2 done)'),
            line(body='win 000000000002003e no longer exists; ignoring apparent refusal'),
            line(body='giving quit reply 1'),
            line(body='sending WM_ENDSESSION to win 000000000002003e result 1 flags 0x00000000'),
            line(body='finished WM_ENDSESSION for win 000000000002003e (2 of 2 done)'),
            line(body='terminating process'), line(body='not terminating process'),
            line('macdrv_app_quit_request', "failed to send WM_QUERYENDSESSION to win 0002003e because it's invalid; assuming success", level='warn'),
            line('macdrv_app_quit_request', 'failed to send WM_QUERYENDSESSION to win 0002003e; error 0x00000008; assuming refusal', level='warn'),
            line(body='failed to send WM_ENDSESSION to win 0002003e; error 0x00000008', level='warn'),
            line('macdrv_app_quit_request', 'failed to allocate window list', level='err'),
            line('get_process_windows', 'HACK: not sending session end messages to Chrome_StatusTrayWindow hwnd 0002003e', level='warn')]
        for row in rows:
            collector.feed(row)
        self.assertEqual(bytes(collector.trace), b''.join(rows))
        self.assertEqual(collector.counts['retainedTraceLines'], len(rows))
        self.assertEqual(collector.diagnostics, b'')

    def test_neighboring_wrong_pid_function_format_level_channel_rejected(self):
        positive = line()
        for wrong in [line(pid='00cd'), line(function='macdrv_key_event'),
                      line(body='terminating process OWNER_CONTENT'),
                      line(body='OWNER_CONTENT terminating process'), line(level='err'),
                      line(channel='clipboard'), positive.replace(b'44386.152:', b'')]:
            collector = self.collector()
            collector.feed(positive + wrong)
            self.assertEqual(collector.trace, positive)
            self.assertEqual(collector.diagnostics, b'')
            self.assertNotIn(b'OWNER_CONTENT', collector.trace)

    def test_unbound_and_changed_identity_are_never_accepted(self):
        collector = TerminationTrace()
        collector.feed(line())
        self.assertEqual(collector.counts['unboundMacdrvLines'], 1)
        collector.bind(IDENTITY)
        collector.feed(line())
        with self.assertRaisesRegex(AssertionError, 'identity changed'):
            collector.bind(dict(IDENTITY, windowsPid=205))
        self.assertEqual(collector.trace, line())

    def test_fragmented_and_multiline_unknown_events_do_not_spool(self):
        collector = self.collector()
        raw = line(function='macdrv_key_event', body='OWNER_CONTENT') + b'OWNER_CLIPBOARD\n' + line()
        for byte in raw:
            collector.feed(bytes([byte]))
        self.assertEqual(collector.trace, line())
        self.assertEqual(collector.diagnostics, b'')

    def test_oversized_line_discards_through_newline_then_recovers(self):
        collector = self.collector()
        collector.feed(b'OWNER_CONTENT' * 1000)
        self.assertLessEqual(len(collector.buffer), collector.line_limit)
        collector.feed(b'terminating process\n' + line())
        self.assertEqual(collector.trace, line())
        self.assertEqual(collector.counts['oversizedLines'], 1)

    def test_finite_byte_budgets_and_partial_tail(self):
        collector = self.collector()
        collector.trace_limit = len(line())
        diagnostic = line('build_module', 'Loaded fixture', channel='loaddll')
        collector.diagnostic_limit = len(diagnostic)
        collector.feed(line() * 10 + diagnostic * 10 + b'44386.152:00cc')
        self.assertEqual(collector.trace, line())
        self.assertEqual(collector.diagnostics, diagnostic)
        self.assertEqual(collector.counts['traceBudgetDrops'], 9)
        self.assertEqual(collector.counts['diagnosticBudgetDrops'], 9)
        self.assertEqual(collector.buffer, b'44386.152:00cc')

    def test_prior_diagnostic_channels_remain_separate(self):
        collector = self.collector()
        rows = b''.join(line('fixture', 'fixture', channel=c) for c in ['loaddll', 'seh', 'process'])
        rows += b'Mono: Assembly fixture\nmsync: up and running.\n'
        collector.feed(rows + line(function='macdrv_clipboard', body='OWNER_CONTENT'))
        self.assertEqual(collector.diagnostics, rows)
        self.assertEqual(collector.trace, b'')

    def test_real_pipe_drains_after_budget_and_never_persists_rejected_bytes(self):
        # A real child writes > typical pipe capacity. Replaces all native producers.
        with tempfile.TemporaryDirectory() as folder:
            run = Path(folder)
            collector = self.collector()
            collector.trace_limit = len(line())
            script = 'import sys; sys.stdout.buffer.write(bytes.fromhex(sys.argv[1])*50000)'
            raw = line() + line(function='macdrv_key_event', body='OWNER_CONTENT')
            child = subprocess.Popen([sys.executable, '-c', script, raw.hex()], stdout=subprocess.PIPE)
            collector.start(child.stdout)
            self.assertEqual(child.wait(timeout=15), 0)
            receipt = collector.finish(run)
            self.assertTrue(receipt['eof'])
            self.assertEqual(receipt['receivedBytes'], len(raw) * 50000)
            self.assertEqual(receipt['traceBudgetDrops'], 49999)
            self.assertEqual(receipt['rejectedMacdrvLines'], 50000)
            self.assertEqual((run/'termination-trace.log').read_bytes(), line())
            self.assertEqual((run/'wine.log').read_bytes(), b'')
            self.assertNotIn('OWNER_CONTENT', (run/'termination-trace-retention.json').read_text())

    def test_live_inherited_pipe_has_finite_close_and_explicit_unknown(self):
        with tempfile.TemporaryDirectory() as folder:
            read, write = os.pipe()
            pipe = os.fdopen(read, 'rb', buffering=0)
            collector = self.collector()
            collector.start(pipe)
            os.write(write, line())
            started = time.monotonic()
            try:
                receipt = collector.finish(Path(folder))
            finally:
                os.close(write)
            self.assertLess(time.monotonic() - started, 2)
            self.assertFalse(receipt['eof'])
            self.assertEqual(receipt['retainedTraceLines'], 1)

    def test_flag_admission_and_identical_explicit_masks(self):
        with self.assertRaisesRegex(AssertionError, 'requires startup diagnostics'):
            host.launch_options(['/fixture', '--termination-trace'])
        with self.assertRaisesRegex(AssertionError, 'requires startup diagnostics'):
            host.startup_environment(False, True)
        options = host.launch_options(['/fixture', '--startup-diagnostics', '--termination-trace'])
        self.assertTrue(options.termination_trace)
        env = host.startup_environment(True, True)
        self.assertEqual(env['WINEDEBUG'], host.STARTUP_TRACE_ENV['WINEDEBUG']+',trace+macdrv')
        self.assertEqual(env['WINEDEBUG'], env['CX_DEBUGMSG'])
        self.assertEqual(env['MONO_LOG_MASK'], host.STARTUP_TRACE_ENV['MONO_LOG_MASK'])
        self.assertEqual(host.startup_environment(True)['WINEDEBUG'], host.STARTUP_TRACE_ENV['WINEDEBUG'])

    def test_host_identity_admission_requires_live_birth_and_matching_lifecycle_pid(self):
        native = dict(status='bound', identity=dict(pid=1234, birth='fixture', argvRow='1234 1 /fixture'))
        with tempfile.TemporaryDirectory() as folder, patch.object(host, 'RUN', Path(folder)), \
             patch.object(host, 'numeric_identity_evidence', return_value=native), \
             patch.object(host, 'processes', return_value=['1234 1 /fixture']), \
             patch.object(host, 'real_game_rows', return_value=['1234 1 /fixture']):
            path = Path(folder)/'lifecycle.jsonl'
            awake = dict(sequence=0, kind='awake', winPid=204)
            path.write_text(json.dumps(awake)+'\n'+ '{"partial":')
            collector = TerminationTrace()
            host.bind_termination_trace(collector)
            self.assertEqual(collector.identity['windowsPid'], 204)
            for changed in [dict(native, status='absent'), dict(native, status='pid-reused')]:
                with patch.object(host, 'numeric_identity_evidence', return_value=changed):
                    with self.assertRaisesRegex(AssertionError, 'Missing live native'):
                        host.bind_termination_trace(TerminationTrace())
            path.write_text(json.dumps(awake)+'\n'+json.dumps(dict(sequence=1, kind='heartbeat', winPid=205))+'\n')
            with self.assertRaises(AssertionError):
                host.bind_termination_trace(TerminationTrace())


if __name__ == '__main__':
    unittest.main()
