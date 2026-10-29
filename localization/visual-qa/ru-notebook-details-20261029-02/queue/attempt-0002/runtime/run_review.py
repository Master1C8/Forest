#!/usr/bin/env python3
"""Bound one already-authorized review-only process. No retries or game control."""
import argparse
from datetime import datetime, timezone
import json
import os
from pathlib import Path
import signal
import subprocess
import time


def now():
    return datetime.now(timezone.utc).isoformat()


def write_status(directory, status):
    temporary = directory / '.attempt.tmp'
    temporary.write_text(json.dumps(status, indent=2) + '\n')
    os.replace(temporary, directory / 'attempt.json')


def stop_group(process):
    # start_new_session makes this new group exclusive to this attempt. No name matching.
    try:
        os.killpg(process.pid, signal.SIGTERM)
    except ProcessLookupError:
        return
    try:
        process.wait(timeout=2)
    except subprocess.TimeoutExpired:
        pass
    # Reap same-group children too; a surviving child may outlive the group leader.
    try:
        os.killpg(process.pid, signal.SIGKILL)
    except ProcessLookupError:
        pass
    process.wait()


def run(directory, command, timeout=180):
    if not command or not 0 < timeout <= 180:
        raise ValueError('Provide a review-only command and a deadline in (0, 180] seconds.')
    directory.mkdir()  # Exclusive attempt identity; never silently overwrite/resume.
    started = time.monotonic()
    status = dict(state='starting', startedAt=now(), timeoutSeconds=timeout,
                  executable=command[0], visualAcceptance='pending', retry=False)
    write_status(directory, status)
    process = None
    try:
        with (directory / 'stdout.log').open('xb') as out, (directory / 'stderr.log').open('xb') as err:
            process = subprocess.Popen(command, stdout=out, stderr=err, start_new_session=True)
            status.update(state='running', pid=process.pid, processGroup=process.pid)
            write_status(directory, status)
            try:
                code = process.wait(timeout=max(0.001, timeout - (time.monotonic() - started)))
            except subprocess.TimeoutExpired:
                status['state'] = 'deadline-exceeded'
                stop_group(process)
                code = 124
            else:
                status['state'] = 'exited' if code == 0 else 'process-failed'
                # A review job must not leave same-group MCP/helper children behind.
                stop_group(process)
            status['exitCode'] = code
    except BaseException as error:
        if process is not None:
            stop_group(process)
        status.update(state='interrupted' if isinstance(error, KeyboardInterrupt) else 'launch-failed',
                      errorType=type(error).__name__)
        raise
    finally:
        status.update(finishedAt=now(), durationSeconds=round(time.monotonic()-started, 3),
                      cleanupScope='Owned process group only; separately detached children require reconciliation.')
        write_status(directory, status)
    return code


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--attempt', required=True, type=Path)
    parser.add_argument('--timeout', type=float, default=180)
    parser.add_argument('command', nargs=argparse.REMAINDER)
    args = parser.parse_args()
    command = args.command[1:] if args.command[:1] == ['--'] else args.command
    # SIGTERM also takes the owned cleanup path. SIGKILL cannot be handled.
    def interrupted(signum, frame):
        raise KeyboardInterrupt()
    signal.signal(signal.SIGTERM, interrupted)
    raise SystemExit(run(args.attempt, command, args.timeout))


if __name__ == '__main__':
    main()
