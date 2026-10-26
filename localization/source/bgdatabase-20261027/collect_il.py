#!/usr/bin/env python3
"""Reproduce only the bounded, hash-pinned Cecil inspection selections."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output', required=True, type=Path)
    args = p.parse_args()
    assert not args.output.exists()
    baseline = json.loads((HERE / 'baseline.json').read_text())
    source = json.loads((ROOT / 'assets/source-v2/source-files.json').read_text())
    for path, expected in baseline['owningHelpers'].items():
        assert hashlib.sha256((ROOT / path).read_bytes()).hexdigest() == expected, path
    for name in ('Assembly-CSharp.dll', 'BGDatabase.dll'):
        assert hashlib.sha256((DATA / 'Managed' / name).read_bytes()).hexdigest() == source['Managed/' + name]['sha256']
    args.output.mkdir(parents=True)
    rows = json.loads((HERE / 'il-commands.json').read_text())
    for row in rows:
        data = subprocess.check_output(['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'),
                                        str(DATA / 'Managed' / row['assembly']), row['type'], row['selection']])
        assert hashlib.sha256(data).hexdigest() == row['sha256'], row['output']
        (args.output / row['output']).write_bytes(data)
    print(json.dumps(dict(exactIlSelections=len(rows), gameAssemblyExecuted=False)))


if __name__ == '__main__':
    main()
