#!/usr/bin/env python3
"""Restore only the twelve pinned installer build inputs to a dist child."""
import argparse
import hashlib
import json
from pathlib import Path
import zipfile

ROOT = Path(__file__).resolve().parents[1]


def restore(archive, output):
    output = output.resolve()
    if not output.is_relative_to(ROOT / 'dist') or output == ROOT / 'dist':
        raise ValueError('restore destination must be a dist child')
    pins = json.loads((ROOT / 'Windows/original-inputs.json').read_bytes())
    if 'recovery' in pins and hashlib.sha256(archive.read_bytes()).hexdigest() != pins['recovery']['sha256']:
        raise ValueError('input archive SHA mismatch')
    expected = {pins['dataDirectory'] + '/' + x['path']: x for x in pins['files']}
    with zipfile.ZipFile(archive) as z:
        if len(z.namelist()) != len(expected) + 1 or set(z.namelist()) != set(expected) | {'manifest.json'}:
            raise ValueError('unexpected input archive inventory')
        for name, info in expected.items():
            data = z.read(name)
            if len(data) != info['bytes'] or hashlib.sha256(data).hexdigest() != info['sha256']:
                raise ValueError('input integrity failure: ' + name)
            dest = output / name
            if not dest.resolve().is_relative_to(output):
                raise ValueError('linked input destination escapes restore root')
            cursor = dest
            while cursor != output:
                if cursor.is_symlink(): raise ValueError('linked input destination')
                cursor = cursor.parent
            if dest.exists():
                if dest.read_bytes() != data: raise ValueError('existing changed input: ' + name)
            else:
                dest.parent.mkdir(parents=True, exist_ok=True)
                with dest.open('xb') as stream: stream.write(data)
    print(json.dumps(dict(restoredInputs=len(expected), output=str(output), originalGameModified=False)))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('archive', type=Path)
    parser.add_argument('--output', type=Path, default=ROOT/'dist/windows-installer-inputs')
    args = parser.parse_args(); restore(args.archive, args.output)
