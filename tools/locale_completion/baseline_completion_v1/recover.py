"""Recover exact serialized selectors from source, accepted baseline and locale bytes.

This is a factual readback, never a source admission or linguistic judgment. Family
memberships remain separate even when they select one physical field.
"""
import argparse
import hashlib
import json
from pathlib import Path
import sys


def need(ok, reason):
    if not ok:
        raise ValueError(reason)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def canonical(value):
    return json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(',', ':'))


def pinned(root, pin):
    path = (root / pin['path']).resolve()
    need(path.is_relative_to(root), 'input-outside-project')
    need(digest(path.read_bytes()) == pin['sha256'], 'input-pin:' + pin['path'])
    return path


def memberships(rows, families):
    selected = [r for r in rows if r['family'] in families]
    keys = [(r['family'], r['id']) for r in selected]
    need(bool(keys) and len(keys) == len(set(keys)), 'duplicate-or-empty-memberships')
    result = {}
    for row in selected:
        result.setdefault(row['id'], []).append(row)
    return result


def recover(root, config_path, output):
    config = json.loads(config_path.read_bytes())
    locale = config['locale']
    need(locale in {'zh', 'es', 'es-419', 'pt-BR', 'ja', 'de'}, 'explicit-locale')
    need(sys.version == config['python'] and
         digest(Path(sys.executable).read_bytes()) == config['pythonExecutableSha256'], 'pinned-python')
    selected_path = pinned(root, config['selectors'])
    selected = memberships([json.loads(s) for s in selected_path.read_text().splitlines()], config['families'])
    inventories = {}
    for pin in config['inventories']:
        path = pinned(root, pin)
        for line, text in enumerate(path.read_text().splitlines(), 1):
            row = json.loads(text)
            if row['id'] not in selected:
                continue
            value = row['source']
            if row['id'] in inventories:
                need(inventories[row['id']]['source'] == value, 'conflicting-inventory:' + row['id'])
            entry = inventories.setdefault(row['id'], dict(source=value, refs=[]))
            entry['refs'].append(dict(path=pin['path'], line=line, rowSha256=digest(canonical(row).encode())))
    need(set(inventories) == set(selected), 'missing-source-selectors')
    engine = pinned(root, config['engineManifest']).parent
    for pin in config['contextPins']:
        pinned(root, pin)
    sys.path[:0] = [str(engine / 'vendor'), str(engine / 'engine'), str(root / 'tools')]
    import UnityPy
    import extract_assets as ex
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    from locale_resource_publish import publish
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(engine / 'source/Managed'))
    observed = {ident: {} for ident in selected}
    for role in ('source', 'baseline', 'target'):
        for asset, pin in config['resources'][role].items():
            path = pinned(root, pin)
            env = UnityPy.load(str(path))
            env.path = str(engine / 'source')
            objects = {obj.path_id: obj for obj in env.objects}
            for ident in selected:
                name, tail = ident.split(':', 1)
                if name != asset:
                    continue
                pid, field = tail.split('/', 1)
                obj = objects[int(pid)]
                tree = ex.read_tree(obj, generator)
                need(field in tree and isinstance(tree[field], str), 'literal-string-field:' + ident)
                observed[ident][role] = dict(value=tree[field], utf8Sha256=digest(tree[field].encode()),
                    treeSha256=digest(canonical(ex.canonical(tree)).encode()),
                    rawSha256=digest(obj.get_raw_data()), gameObject=tree.get('m_GameObject'),
                    script=tree.get('m_Script'), fontAsset=tree.get('m_fontAsset'),
                    material=tree.get('m_sharedMaterial'), resource=pin)
    rows = []
    for ident, members in selected.items():
        values = observed[ident]
        need(set(values) == {'source', 'baseline', 'target'}, 'incomplete-readback:' + ident)
        need(values['source']['value'] == inventories[ident]['source'], 'inventory-resource-drift:' + ident)
        rows.append(dict(id=ident, memberships=members, inventory= inventories[ident], readback=values,
            sourceEqualsBaseline=values['source']['value'] == values['baseline']['value'],
            sourceEqualsTarget=values['source']['value'] == values['target']['value'],
            baselineEqualsTarget=values['baseline']['value'] == values['target']['value'],
            judgmentAdded=False, linguisticCoverageAdded=0))
    data = (''.join(json.dumps(r, ensure_ascii=False) + '\n' for r in rows)).encode()
    files = {'readback.jsonl': data}
    manifest = dict(kind='exact-baseline-selector-recovery', locale=locale,
        config=dict(path=str(config_path.relative_to(root)), sha256=digest(config_path.read_bytes())),
        implementation=dict(path=str(Path(__file__).resolve().relative_to(root)), sha256=digest(Path(__file__).read_bytes())),
        uniqueSelectors=len(rows), familyMemberships=sum(map(len, selected.values())),
        allBaselineEqualsTarget=all(r['baselineEqualsTarget'] for r in rows),
        files={'readback.jsonl': digest(data)}, semanticCoverageAdded=0,
        boundary='Actual serialized fields only. No visibility, source admission, linguistic, native or runtime acceptance.')
    allowed = root / 'outputs/locale-assets-20261026' / locale
    def verify(out, marker, content):
        need(json.loads((out / 'manifest.json').read_bytes()) == marker, 'saved-manifest')
        need((out / 'readback.jsonl').read_bytes() == content['readback.jsonl'], 'saved-readback')
    publish(files, output, allowed, manifest, verify)
    return {k: manifest[k] for k in ('uniqueSelectors', 'familyMemberships', 'allBaselineEqualsTarget', 'semanticCoverageAdded')}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, required=True)
    parser.add_argument('--config', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    print(json.dumps(recover(args.root.resolve(), args.config.resolve(), args.output.resolve())))
