"""Read-only whole-object/stream comparison against the extracted source inventory."""
import argparse
import hashlib
import json
from pathlib import Path

import UnityPy

ROOT = Path(__file__).resolve().parents[1]


def sha(path):
    digest = hashlib.sha256()
    with Path(path).open('rb') as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b''):
            digest.update(block)
    return digest.hexdigest()


def compare(expected, actual, boundary):
    assert expected.keys() == actual.keys(), (boundary + '-identity-set', sorted(expected.keys() ^ actual.keys(), key=str))
    for identity, value in expected.items():
        assert actual[identity] == value, (boundary + '-bytes', identity)


def contents(path):
    """Bundle container name is excluded; internal member names remain exact."""
    textures, streams = {}, {}

    def visit(file, prefix):
        name = type(file).__name__
        if name == 'SerializedFile':
            for obj in file.objects.values():
                if obj.type.name == 'Texture2D':
                    raw = obj.get_raw_data()
                    textures[(prefix, obj.path_id)] = (len(raw), hashlib.sha256(raw).hexdigest())
        elif name == 'BundleFile':
            for member, child in file.files.items():
                visit(child, prefix + (member,))
        else:
            raw = file.bytes
            streams[prefix] = (len(raw), hashlib.sha256(raw).hexdigest())

    env = UnityPy.load(str(path))
    assert len(env.files) == 1, ('unexpected-container-count', str(path))
    visit(next(iter(env.files.values())), ())
    return textures, streams


def verify(source, target):
    inventory = json.loads((ROOT / 'assets/source-v2/objects.json').read_text())
    files = json.loads((ROOT / 'assets/source-v2/source-files.json').read_text())
    textures = [r for r in inventory if r['type'] == 'Texture2D']
    assert len(textures) == 1385
    expected = {}
    for row in textures:
        key = (tuple(row['internalAsset']), row['pathId'])
        group = expected.setdefault(row['sourceFile'], {})
        assert key not in group, ('duplicate-source-texture', row['id'])
        group[key] = (row['bytes'], row['rawSha256'])
    changed, exact = [], []
    excluded_player_files = []
    for name, record in files.items():
        assert sha(source / name) == record['sha256'], ('original-source-changed', name)
        if '/' not in name and name.startswith('tfol.'):
            assert not (target / name).exists(), ('owner-player-file-in-candidate', name)
            excluded_player_files.append(name)
            continue
        (exact if sha(target / name) == record['sha256'] else changed).append(name)
    stream_names = {n for n in files if n.lower().endswith(('.ress', '.resource'))}
    actual_streams = {str(p.relative_to(target)) for p in target.rglob('*') if p.is_file() and p.name.lower().endswith(('.ress', '.resource'))}
    compare({n: files[n]['sha256'] for n in stream_names}, {n: sha(target / n) for n in actual_streams}, 'external-stream')
    containers = {n for n in files if n.endswith(('.assets', '.bundle')) or (Path(n).name.startswith('level') and Path(n).name[5:].isdigit())}
    actual_containers = {str(p.relative_to(target)) for p in target.rglob('*') if p.is_file() and (p.name.endswith(('.assets', '.bundle')) or (p.name.startswith('level') and p.name[5:].isdigit()))}
    assert containers == actual_containers, 'asset-container-identity-set'
    checked, bundle_streams = [], []
    for name in sorted(set(changed) & containers):
        got, streams = contents(target / name)
        compare(expected.get(name, {}), got, 'texture-object')
        if name.endswith('.bundle'):
            original, old_streams = contents(source / name)
            compare(expected.get(name, {}), original, 'source-texture-object')
            compare(old_streams, streams, 'bundle-stream')
            bundle_streams.extend({'sourceFile': name, 'member': list(k), 'bytes': v[0], 'sha256': v[1]} for k, v in streams.items())
        checked.append({'sourceFile': name, 'textureObjects': len(got), 'streamMembers': len(streams)})
    return {'schemaVersion': 1, 'status': 'pass', 'source': str(source), 'target': str(target),
            'inventorySha256': sha(ROOT / 'assets/source-v2/objects.json'),
            'sourceFilesSha256': sha(ROOT / 'assets/source-v2/source-files.json'),
            'originalTextureObjects': len(textures), 'originalTextureContainers': len(expected),
            'wholeFileExact': exact, 'changedFiles': changed, 'parsedChangedContainers': checked,
            'excludedOriginalPlayerFiles': excluded_player_files,
            'externalStreams': [{'path': n, 'sha256': files[n]['sha256']} for n in sorted(stream_names)],
            'changedBundleStreams': bundle_streams,
            'boundary': 'All original serialized Texture2D raw bytes and original external/bundle resource streams; in-memory runtime glyph allocation and visual quality are separate.'}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--target', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert not args.output.exists(), 'Preserve prior verification receipts'
    result = verify(args.source.resolve(), args.target.resolve())
    args.output.write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps({k: result[k] for k in ['status', 'originalTextureObjects', 'originalTextureContainers', 'parsedChangedContainers']}))


if __name__ == '__main__':
    main()
