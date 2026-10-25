#!/usr/bin/env python3
"""Compare exports to the pinned live source; never writes into the installation."""
import argparse
import hashlib
import json
from pathlib import Path
import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from PIL import Image
from extract_assets import sha, strings, dump, canonical, read_tree


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('export', type=Path)
    args = ap.parse_args()
    out = args.export.resolve()
    load = lambda name: json.loads((out / (name + '.json')).read_text())
    report, source = load('report'), load('source-files')
    root = Path(report['sourceRoot'])
    for rel, row in source.items():
        assert sha(root / rel) == row['sha256'], 'Source changed: ' + rel
    assert sha(out / 'source-files.json') == report['sourceManifestSha256']
    env = UnityPy.load(str(root))
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(root / 'Managed'))
    live = {}
    for obj in env.objects:
        container, internal = obj.assets_file, []
        while container.parent is not env:
            internal.insert(0, container.name)
            container = container.parent
        candidates = [p for p in source if Path(p).name == container.name]
        assert len(candidates) == 1
        asset = candidates[0] + (('!/' + '/'.join(internal)) if internal else '')
        key = f'{asset}:{obj.path_id}'
        assert key not in live, 'Duplicate ID: ' + key
        live[key] = obj
    objects, textures, texts, fields = load('objects'), load('textures'), load('text-assets'), load('string-fields')
    assert len({r['id'] for r in objects}) == len(objects)
    assert set(live) == {r['id'] for r in objects}
    tree_count = 0
    expected_fields = {}
    for row in objects:
        obj = live[row['id']]
        assert hashlib.sha256(obj.get_raw_data()).hexdigest() == row['rawSha256'], row['id']
        if 'tree' in row:
            tree = json.loads((out / row['tree']).read_text())
            # JSON canonicalization accounts for the serialized typetree representation.
            expected = canonical(read_tree(obj, generator))
            assert tree == expected, row['id']
            assert sha(out / row['tree']) == row['treeSha256']
            tree_count += 1
            if row['type'] in ['MonoBehaviour', 'TextMesh']:
                for pointer, value in strings(tree):
                    expected_fields[row['id'] + pointer] = value
    assert len({r['id'] for r in fields}) == len(fields)
    assert {r['id']: r['value'] for r in fields} == expected_fields
    for row in texts:
        d = live[row['id']].read()
        expected = d.m_Script.encode('utf-8', 'surrogateescape') if isinstance(d.m_Script, str) else bytes(d.m_Script)
        assert (out / row['path']).read_bytes() == expected
        assert sha(out / row['path']) == row['sha256']
    image_count = 0
    for row in textures:
        if row['status'] != 'exported':
            continue
        d = live[row['id']].read()
        assert sha(out / row['path']) == row['sha256']
        with Image.open(out / row['path']) as image:
            assert image.size == (row['width'], row['height'])
            assert image.convert('RGBA').tobytes() == d.image.convert('RGBA').tobytes(), row['id']
        image_count += 1
    result = {'status': 'passed', 'boundary': 'pinned installed bytes -> object/typetree/text/PNG export',
              'sourceFiles': len(source), 'objects': len(live), 'trees': tree_count,
              'stringFields': len(fields), 'textAssets': len(texts), 'texturesPixelEqual': image_count,
              'reportSha256': sha(out / 'report.json'), 'validatorSha256': sha(Path(__file__)),
              'reinsertedSourceEquality': 'not-run; export-only scope', 'runtime': 'not-run',
              'semanticClassification': 'not-tested'}
    dump(out / 'validation.json', result)
    print(json.dumps(result))


if __name__ == '__main__':
    main()
