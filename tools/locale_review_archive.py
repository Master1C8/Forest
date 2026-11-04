"""Preserve exact selected editorial evidence bodies; never infer acceptance.

Selection JSON: {"files": [{"path": "relative/path", "sha256": "..."}]}.
Compressed copies are verified by restoration in memory. Missing bodies reject,
including when references or their expected hashes remain available elsewhere.
"""
import argparse
import gzip
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def sha(raw):
    return hashlib.sha256(raw).hexdigest()


def within(root, name):
    relative = Path(name)
    path = root / relative
    if relative.is_absolute() or '..' in relative.parts or not path.resolve().is_relative_to(root.resolve()):
        raise ValueError('Evidence path escapes the checkout')
    return path


def pack(root, selection, output):
    rows = selection['files']
    if not rows or len({row['path'] for row in rows}) != len(rows):
        raise ValueError('Explicit nonempty unique evidence selection required')
    # Verify the entire selection before publishing any compressed body.
    bodies = []
    for row in rows:
        source = within(root, row['path'])
        if not source.is_file():
            raise ValueError('Missing actual evidence body: ' + row['path'])
        raw = source.read_bytes()
        if sha(raw) != row['sha256']:
            raise ValueError('Evidence body changed: ' + row['path'])
        bodies.append((row, raw))
    output.mkdir(parents=True, exist_ok=False)
    saved = []
    for row, raw in bodies:
        compressed = gzip.compress(raw, mtime=0)
        target = output / (row['sha256'] + '.gz')
        if target.exists():
            if gzip.decompress(target.read_bytes()) != raw:
                raise ValueError('Conflicting evidence object')
        else:
            target.write_bytes(compressed)
        if gzip.decompress(target.read_bytes()) != raw:
            raise ValueError('Evidence restoration differs')
        saved.append(dict(original=row['path'], sha256=sha(raw), bytes=len(raw),
                          body=target.name, compressedSha256=sha(target.read_bytes())))
    manifest = dict(format='forest-editorial-evidence-bodies-v1', files=saved,
                    restoredBodiesEqual=True, acceptanceGenerated=False,
                    boundary='Exact byte retention only; semantic/context acceptance remains separate.')
    (output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    verify(output)
    return manifest


def verify(output):
    manifest = json.loads((output / 'manifest.json').read_bytes())
    if manifest['format'] != 'forest-editorial-evidence-bodies-v1':
        raise ValueError('Unknown evidence archive format')
    for row in manifest['files']:
        compressed = within(output, row['body']).read_bytes()
        raw = gzip.decompress(compressed)
        if sha(compressed) != row['compressedSha256'] or sha(raw) != row['sha256'] or len(raw) != row['bytes']:
            raise ValueError('Evidence restoration failed: ' + row['original'])
    return len(manifest['files'])


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', choices=['pack', 'verify'])
    parser.add_argument('output', type=Path)
    parser.add_argument('--selection', type=Path)
    args = parser.parse_args()
    output = within(ROOT, args.output)
    if args.action == 'pack':
        if args.selection is None:
            parser.error('pack requires --selection')
        pack(ROOT, json.loads(args.selection.read_bytes()), output)
    print(json.dumps(dict(verifiedBodies=verify(output), acceptanceGenerated=False)))
