"""Pinned factual recovery for plain and bundle/CAB selectors, including page context.

The original recover.py is immutable. This sibling uses its pin and membership
guards and the shared publisher. No Unity objects or input resources are written.
"""
import argparse
import importlib.util
import json
from pathlib import Path
import re
import sys


def original():
    spec = importlib.util.spec_from_file_location('baseline_recover_original', Path(__file__).with_name('recover.py'))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


B = original()
need, digest, canonical, pinned = B.need, B.digest, B.canonical, B.pinned


def selector(ident):
    """Preserve signed path IDs and exact serialized member identity."""
    match = re.fullmatch(r'([^:!]+)(?:!/([^:!/]+))?:(-?[0-9]+)(?:/([^/]+))?', ident)
    need(match is not None, 'selector-syntax:' + ident)
    asset, member, path_id, field = match.groups()
    need(not Path(asset).is_absolute() and '..' not in Path(asset).parts, 'selector-path:' + ident)
    return asset, member, int(path_id), field


def object_for(env, ident):
    asset, member, path_id, field = selector(ident)
    files = [f for f in env.assets if f.name == (member or asset)]
    need(len(files) == 1, 'serialized-member-identity:' + ident)
    need(path_id in files[0].objects, 'serialized-path-id:' + ident)
    return files[0].objects[path_id], field


def rows(path):
    return [json.loads(line) for line in path.read_text().splitlines() if line.strip()]


def recover(root, config_path, output):
    config = json.loads(config_path.read_bytes())
    locale = config['locale']
    need(locale in {'zh', 'es', 'es-419', 'pt-BR', 'ja', 'de'}, 'explicit-locale')
    need(sys.version == config['python'] and digest(Path(sys.executable).read_bytes()) == config['pythonExecutableSha256'], 'pinned-python')
    for pin in config['implementationPins'] + config['contextPins']:
        pinned(root, pin)
    selected = B.memberships(rows(pinned(root, config['selectors'])), config['families'])
    inventories = {}
    for pin in config['inventories']:
        for line, row in enumerate(rows(pinned(root, pin)), 1):
            ident = row['id']
            if ident not in selected and ident not in config['contextSelectors']:
                continue
            value = row[pin['valueField']]
            need(isinstance(value, str), 'source-string:' + ident)
            if ident in inventories:
                need(inventories[ident]['source'] == value, 'conflicting-inventory:' + ident)
            entry = inventories.setdefault(ident, dict(source=value, refs=[]))
            entry['refs'].append(dict(path=pin['path'], line=line, rowSha256=digest(canonical(row).encode())))
    need(set(inventories) == set(selected) | set(config['contextSelectors']), 'complete-primary-and-context-inventory')
    engine = pinned(root, config['engineManifest']).parent
    engine_files = json.loads((engine/'manifest.json').read_bytes())['files']
    for name, sha in engine_files.items():
        path = (engine/name).resolve()
        need(path.is_relative_to(engine) and digest(path.read_bytes()) == sha, 'engine-closure:' + name)
    sys.path[:0] = [str(engine/'vendor'), str(engine/'engine'), str(root/'tools')]
    import UnityPy
    import extract_assets as ex
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    from locale_resource_publish import publish
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(engine/'source/Managed'))
    observed = {ident: {} for ident in inventories}
    protections = {ident: {} for ident in config['protectedObjects']}
    for role in ('source', 'baseline', 'target'):
        for asset, pin in config['resources'][role].items():
            env = UnityPy.load(str(pinned(root, pin)))
            env.path = str(engine/'source')
            def tree_and_raw(ident):
                obj, field = object_for(env, ident)
                tree = ex.read_tree(obj, generator)
                return obj, field, tree
            for ident, inventory in inventories.items():
                if selector(ident)[0] != asset:
                    continue
                obj, field, tree = tree_and_raw(ident)
                need(field in tree and isinstance(tree[field], str), 'literal-string-field:' + ident)
                nontext = {k:v for k,v in tree.items() if k != field}
                ancestry = []
                go = tree.get('m_GameObject', {}).get('m_PathID', 0)
                seen = set()
                while go:
                    need(go not in seen, 'ancestry-cycle:' + ident)
                    seen.add(go)
                    go_obj = obj.assets_file.objects[go]
                    go_tree = ex.read_tree(go_obj, generator)
                    ancestry.append(dict(pathId=go, name=go_tree.get('m_Name'), active=go_tree.get('m_IsActive'), rawSha256=digest(go_obj.get_raw_data())))
                    parents = []
                    for component in go_tree.get('m_Component', []):
                        ptr = component.get('component', component)
                        component_obj = obj.assets_file.objects.get(ptr.get('m_PathID'))
                        if component_obj and component_obj.type.name in {'Transform', 'RectTransform'}:
                            component_tree = ex.read_tree(component_obj, generator)
                            father = component_tree['m_Father']['m_PathID']
                            if father:
                                father_tree = ex.read_tree(obj.assets_file.objects[father], generator)
                                parents.append(father_tree['m_GameObject']['m_PathID'])
                    need(len(parents) <= 1, 'ambiguous-transform-parent:' + ident)
                    go = parents[0] if parents else 0
                observed[ident][role] = dict(value=tree[field], utf8Sha256=digest(tree[field].encode()),
                    rawSha256=digest(obj.get_raw_data()), treeSha256=digest(canonical(ex.canonical(tree)).encode()),
                    nontextSha256=digest(canonical(ex.canonical(nontext)).encode()),
                    gameObject=tree.get('m_GameObject'), script=tree.get('m_Script'),
                    fontAsset=tree.get('m_fontAsset'), material=tree.get('m_sharedMaterial'),
                    activeAncestry=ancestry, resource=pin)
            for ident in protections:
                if selector(ident)[0] != asset:
                    continue
                obj, field, tree = tree_and_raw(ident)
                need(field is None, 'protected-whole-object:' + ident)
                protections[ident][role] = dict(rawSha256=digest(obj.get_raw_data()), treeSha256=digest(canonical(ex.canonical(tree)).encode()))
    result = []
    for ident, inventory in inventories.items():
        values = observed[ident]
        need(set(values) == {'source', 'baseline', 'target'}, 'incomplete-readback:' + ident)
        need(values['source']['value'] == inventory['source'], 'inventory-resource-drift:' + ident)
        result.append(dict(id=ident, primary=ident in selected, memberships=selected.get(ident, []), inventory=inventory, readback=values,
            sourceEqualsBaseline=values['source']['value'] == values['baseline']['value'],
            sourceEqualsTarget=values['source']['value'] == values['target']['value'],
            baselineEqualsTarget=values['baseline']['value'] == values['target']['value'],
            targetBinding=config.get('targetBindings', {}).get(selector(ident)[0], 'candidate-override'),
            judgmentAdded=False, linguisticCoverageAdded=0))
    for ident, values in protections.items():
        need(set(values) == {'source', 'baseline', 'target'}, 'incomplete-protection:' + ident)
    files = {'readback.jsonl': ''.join(json.dumps(r, ensure_ascii=False)+'\n' for r in result).encode(),
             'protected-objects.json': (json.dumps(protections, indent=2, sort_keys=True)+'\n').encode()}
    manifest = dict(kind='exact-baseline-bundle-selector-recovery', locale=locale,
        config=dict(path=str(config_path.relative_to(root)), sha256=digest(config_path.read_bytes())),
        implementation=dict(path=str(Path(__file__).resolve().relative_to(root)), sha256=digest(Path(__file__).read_bytes())),
        primarySelectors=len(selected), contextSelectors=len(config['contextSelectors']),
        familyMemberships=sum(map(len, selected.values())), actualReadbacks=len(result),
        engineClosureFiles=len(engine_files), files={name:digest(data) for name,data in files.items()},
        semanticCoverageAdded=0, boundary='Serialized resources only; target original-base pass-through is explicitly distinguished from a candidate override. No visibility, source admission or linguistic/native/runtime acceptance.')
    # Detect input changes across the expensive read before publishing any output.
    for pin in config['implementationPins'] + config['contextPins']:
        pinned(root, pin)
    for resources in config['resources'].values():
        for pin in resources.values():
            pinned(root, pin)
    def verify(out, marker, content):
        need(json.loads((out/'manifest.json').read_bytes()) == marker, 'saved-manifest')
        for name,data in content.items():
            need((out/name).read_bytes() == data, 'saved-readback:' + name)
    publish(files, output, root/'outputs/locale-assets-20261026'/locale, manifest, verify)
    return {k:manifest[k] for k in ('primarySelectors','contextSelectors','familyMemberships','actualReadbacks','engineClosureFiles')}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('root', 'config', 'output'):
        parser.add_argument('--'+name, type=Path, required=True)
    args = parser.parse_args()
    print(json.dumps(recover(args.root.resolve(), args.config.resolve(), args.output.resolve())))
