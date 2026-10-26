#!/usr/bin/env python3
"""Send one guarded action to an already verified task-owned inspection bridge."""
import argparse
import json
import time
from pathlib import Path

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('run', type=Path)
parser.add_argument('command')
parser.add_argument('--snapshot')
args = parser.parse_args()
run = args.run.resolve()
assert 'Forest/localization/probes/' in run.as_posix()
pending = run / 'command.txt'
assert not pending.exists(), 'Reconcile the pending command instead of overwriting it.'
log = run / 'actions.log'
offset = log.stat().st_size
temp = run / 'command.pending'
assert not temp.exists()
temp.write_text(args.command + '\n')
temp.rename(pending)
deadline = time.monotonic() + 20
receipt = None
while time.monotonic() < deadline:
    with log.open('rb') as f:
        f.seek(offset)
        lines = f.read().decode('utf-8').splitlines()
    receipt = next((line for line in lines if (' OK ' + args.command) in line or (' FAIL ' + args.command) in line), None)
    if receipt:
        break
    time.sleep(.1)
assert receipt and (' OK ' + args.command) in receipt, receipt or 'Timeout; outcome unknown, reconcile before resubmitting.'
print(receipt)
if args.command == 'dump':
    state = json.loads((run / 'state.json').read_text())
    assert state['company'] == 'VNRevivalQA' and state['product'] == 'ForestRuRendererProbe'
    if args.snapshot:
        output = run / args.snapshot
        assert output.parent == run and not output.exists()
        output.write_bytes((run / 'state.json').read_bytes())
    print(json.dumps(state, ensure_ascii=False, indent=2))
elif args.command.startswith('capture '):
    output = run / args.command[8:]
    while time.monotonic() < deadline and not output.exists():
        time.sleep(.1)
    assert output.is_file(), 'Capture action accepted but image is not ready; preserve the unknown outcome.'
    print('Native game frame:', output)
