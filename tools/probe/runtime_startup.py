"""Bounded readiness observation; preserve actual launcher exit and survivors."""
import json
import time


def wait_for_probe(run, child, owned_processes, timeout, interval=1):
    start = time.monotonic()
    log = run / 'player.log'
    ready_file = run / 'bridge-ready.txt'
    while True:
        size = log.stat().st_size if log.exists() else 0
        tail = b''
        if size:
            with log.open('rb') as stream:
                stream.seek(max(0, size - 131072))
                tail = stream.read(131072)
        log_marker = b'FOREST_PROBE_READY' in tail
        file_marker = False
        invalid = None
        if ready_file.exists():
            lines = ready_file.read_text(encoding='utf-8-sig').splitlines()
            if len(lines) >= 4:
                expected = json.loads((run / 'build.json').read_text())['saveIsolation']
                data = str(run / 'game/The Forest of Love_Data')
                variants = [data, 'Z:' + data, 'Y:' + data.replace('/Users/antonkrutov', '', 1)]
                file_marker = (len(lines) == 4 and lines[0] == '1' and
                               lines[1:3] == [expected['companyName'], expected['productName']] and
                               lines[3].replace('\\', '/') in variants)
                if not file_marker:
                    invalid = 'readiness-identity-or-schema'
        marker = log_marker or file_marker
        code = child.poll()
        owned = owned_processes()
        elapsed = time.monotonic() - start
        status = 'readiness-invalid' if invalid else 'process-exited' if code is not None and not owned else 'ready' if marker else 'timeout' if elapsed >= timeout else None
        if status:
            receipt = dict(status=status, launcherPid=child.pid, launcherExitCode=code,
                           ownedProcessRows=owned, markerSeen=marker, logBytes=size,
                           readinessFileVerified=file_marker, logMarkerSeen=log_marker, invalid=invalid,
                           elapsedSeconds=round(elapsed, 3))
            temp = run / 'startup-state.json.pending'
            temp.write_text(json.dumps(receipt, indent=2) + '\n')
            temp.replace(run / 'startup-state.json')
            if status != 'ready':
                raise RuntimeError('startup-' + status, code, len(owned))
            return receipt
        time.sleep(interval)
