"""Finite task-stderr retention for the pinned CrossOver26 macdrv quit route.

No raw spool: reject other macdrv/unframed lines before storing anything. The
reader drains a nonblocking fd into finite sanitized memory, with no disk I/O on
the pipe path. Persistence occurs after bounded close; EOF/limits remain explicit.
"""
import json
import os
import re
import select
import threading
from datetime import datetime, timezone


HEADER = re.compile(rb'(?P<clock>[0-9]+\.[0-9]+):(?P<pid>[0-9a-fA-F]{4,8}):'
                    rb'(?P<tid>[0-9a-fA-F]{4,8}):(?P<level>trace|warn|err|fixme):'
                    rb'(?P<channel>[a-zA-Z0-9_]+):(?P<function>[a-zA-Z0-9_]+) (?P<body>[^\r\n]*)\n')
PTR = rb'(?:0x)?[0-9a-fA-F]{1,16}'
UINT = rb'[0-9]{1,10}'
INT = rb'-?[0-9]{1,20}'
FORMATS = {
    (b'trace', b'macdrv_app_quit_requested'): [rb'reason '+INT],
    (b'trace', b'macdrv_app_quit_request'): [
        rb'sending WM_QUERYENDSESSION to win '+PTR,
        rb'failed to send WM_QUERYENDSESSION to win '+PTR+rb" because it's invalid; assuming success",
        rb'failed to send WM_QUERYENDSESSION to win '+PTR+rb'; error 0x[0-9a-fA-F]{8}; assuming refusal'],
    (b'err', b'macdrv_app_quit_request'): [rb'failed to allocate window list'],
    (b'warn', b'macdrv_app_quit_request'): [
        rb'failed to send WM_QUERYENDSESSION to win '+PTR+rb" because it's invalid; assuming success",
        rb'failed to send WM_QUERYENDSESSION to win '+PTR+rb'; error 0x[0-9a-fA-F]{8}; assuming refusal'],
    (b'trace', b'quit_callback'): [
        rb'got WM_QUERYENDSESSION result '+INT+rb' from win '+PTR+rb' \('+UINT+rb' of '+UINT+rb' done\)',
        rb'win '+PTR+rb' no longer exists; ignoring apparent refusal',
        rb'giving quit reply '+INT,
        rb'sending WM_ENDSESSION to win '+PTR+rb' result '+INT+rb' flags 0x[0-9a-fA-F]{8}',
        rb'finished WM_ENDSESSION for win '+PTR+rb' \('+UINT+rb' of '+UINT+rb' done\)',
        rb'(?:not )?terminating process'],
    (b'warn', b'quit_callback'): [rb'failed to send WM_ENDSESSION to win '+PTR+rb'; error 0x[0-9a-fA-F]{8}'],
    (b'warn', b'get_process_windows'): [
        rb'HACK: not sending session end messages to Chrome_StatusTrayWindow hwnd '+PTR],
}
FORMATS = {key: [re.compile(p) for p in patterns] for key, patterns in FORMATS.items()}


class TerminationTrace:
    line_limit = 8192
    trace_limit = 256 * 1024
    diagnostic_limit = 8 * 1024 * 1024

    def __init__(self):
        self.identity = None
        self.lock = threading.Lock()
        self.buffer = bytearray()
        self.discarding_line = False
        self.trace = bytearray()
        self.diagnostics = bytearray()
        self.counts = dict(receivedBytes=0, discardedLines=0, unboundMacdrvLines=0,
                           rejectedMacdrvLines=0, oversizedLines=0, traceBudgetDrops=0,
                           diagnosticBudgetDrops=0, retainedTraceLines=0)
        self.eof = False
        self.reader_error = None
        self.stop = threading.Event()
        self.thread = None

    def bind(self, identity):
        assert isinstance(identity['windowsPid'], int) and identity['windowsPid'] > 0
        assert isinstance(identity['nativePid'], int) and identity['nativePid'] > 0
        assert identity['nativeBirth'] and identity['argvRow'] and identity['boundUtc']
        with self.lock:
            assert self.identity is None or self.identity == identity, 'Trace identity changed; hold'
            self.identity = dict(identity)

    def feed(self, chunk):
        # One reader owns framing/counters/buffers; bind only swaps immutable identity.
        self.counts['receivedBytes'] += len(chunk)
        for part in chunk.splitlines(keepends=True):
            complete = part.endswith(b'\n')
            if self.discarding_line:
                if complete:
                    self.discarding_line = False
                continue
            if len(self.buffer) + len(part) > self.line_limit:
                self.buffer.clear()
                self.counts['oversizedLines'] += 1
                self.discarding_line = not complete
                continue
            self.buffer.extend(part)
            if complete:
                self._line(bytes(self.buffer))
                self.buffer.clear()

    def _line(self, line):
        match = HEADER.fullmatch(line)
        if match is None:
            # Keep the pre-existing Mono channel and harmless sync startup markers.
            # Never retain arbitrary continuation lines from a rejected macdrv row.
            if line.startswith((b'Mono: ', b'msync: ', b'esync: ', b'fsync: ')):
                self._retain(self.diagnostics, line, self.diagnostic_limit, 'diagnosticBudgetDrops')
            else:
                self.counts['discardedLines'] += 1
            return
        if match['channel'] != b'macdrv':
            if match['channel'] in (b'loaddll', b'seh', b'process'):
                self._retain(self.diagnostics, line, self.diagnostic_limit, 'diagnosticBudgetDrops')
            else:
                self.counts['discardedLines'] += 1
            return
        with self.lock:
            identity = self.identity
        if identity is None:
            self.counts['unboundMacdrvLines'] += 1
            return
        patterns = FORMATS.get((match['level'], match['function']), [])
        if int(match['pid'], 16) != identity['windowsPid'] or not any(p.fullmatch(match['body']) for p in patterns):
            self.counts['rejectedMacdrvLines'] += 1
            return
        if self._retain(self.trace, line, self.trace_limit, 'traceBudgetDrops'):
            self.counts['retainedTraceLines'] += 1

    def _retain(self, target, line, limit, counter):
        if len(target) + len(line) > limit:
            self.counts[counter] += 1
            return False
        target.extend(line)
        return True

    def start(self, pipe):
        assert self.thread is None
        os.set_blocking(pipe.fileno(), False)

        def drain():
            try:
                while not self.stop.is_set():
                    if not select.select([pipe], [], [], .05)[0]:
                        continue
                    try:
                        chunk = os.read(pipe.fileno(), 16384)
                    except BlockingIOError:
                        continue
                    if not chunk:
                        self.eof = True
                        return
                    self.feed(chunk)
            except Exception as error:
                # Do not serialize raw exception/stream content.
                self.reader_error = type(error).__name__
            finally:
                pipe.close()

        self.thread = threading.Thread(target=drain, name='task-termination-stderr', daemon=True)
        self.thread.start()

    def finish(self, run):
        assert self.thread is not None
        # Descendants may inherit stderr; never wait indefinitely for their EOF.
        self.thread.join(1)
        self.stop.set()
        self.thread.join(.2)
        assert not self.thread.is_alive(), 'Diagnostic reader did not stop; output unknown'
        # Only complete, allowlisted lines were retained; trailing bytes stay unknown.
        (run / 'wine.log').write_bytes(self.diagnostics)
        (run / 'termination-trace.log').write_bytes(self.trace)
        result = dict(identity=self.identity, **self.counts, eof=self.eof,
                      readerError=self.reader_error, trailingBytesDiscarded=len(self.buffer),
                      unfinishedOversizedLine=self.discarding_line,
                      retainedTraceBytes=len(self.trace), retainedDiagnosticBytes=len(self.diagnostics),
                      traceLimit=self.trace_limit, diagnosticLimit=self.diagnostic_limit,
                      lineLimit=self.line_limit, finalizedUtc=datetime.now(timezone.utc).isoformat(),
                      boundary='Task launch stderr only; unbound/rejected/partial/over-budget rows discarded before persistence. Missing/truncated trace is unknown; no syscall or numeric game exit proof.')
        (run / 'termination-trace-retention.json').write_text(json.dumps(result, indent=2)+'\n')
        return result
