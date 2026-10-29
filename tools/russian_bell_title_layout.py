"""Source-bound complete-title flow for the four Russian colored-bell popups.

Only GameObject activation, complete-title m_text, and vertical inheritance of
its five visible TMP rects change. Source art, faces, materials, glyph sizes,
wrapping, fitters, horizontal positions, and glow offsets stay intact.
"""
import argparse
import copy
import hashlib
import json
from pathlib import Path

from extract_assets import canonical, read_tree

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
CONTRACT = ROOT / 'localization/hotfixes/ru-dates-titleflow-20261029/bell-layout-contract.json'


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def _assert(condition, label, *details):
    if not condition:
        raise AssertionError((label, *details))


def load_contract(contract_path=None):
    path = Path(contract_path) if contract_path else CONTRACT
    contract = json.loads(path.read_text())
    _assert(contract['schemaVersion'] == 1 and contract['locale'] == 'ru'
            and contract['resource'] == 'sharedassets2.assets', 'bell-contract-identity')
    _assert([r['color'] for r in contract['families']] == ['Blue', 'Red', 'Green', 'Purple'], 'bell-four-colors')
    guards = {r['pathId']: r for r in contract['guards']}
    _assert(len(guards) == len(contract['guards']) == 192, 'bell-guard-coverage')
    expected = {}
    complete_layers = set()
    for family in contract['families']:
        variants = family['variants']
        _assert(set(variants) == {'Title (1)', 'Title', 'Title (2)'}, 'bell-variants')
        joined = variants['Title (1)']['text'] + variants['Title']['text']
        _assert(joined == family['fullText'], 'bell-reviewed-fragment-join', family['color'])
        for name, variant in variants.items():
            _assert(len(set(variant['layers'])) == 6 and variant['provider'] in variant['layers'], 'bell-six-layers')
            for pid in variant['layers']:
                _assert(guards[pid]['expectedTree']['m_text'] == variant['text'], 'bell-consistent-before-layers', pid)
            go = variant['gameObject']
            _assert(guards[go]['expectedTree']['m_Name'] == name
                    and guards[go]['expectedTree']['m_IsActive'] == (name != 'Title (2)'), 'bell-before-activation', go)
            expected[go] = {'m_IsActive': name == 'Title (2)'}
        complete = variants['Title (2)']
        complete_layers.update(complete['layers'])
        _assert(len(set(family['inheritedHeightRects'])) == 5, 'bell-five-visible-rects')
        for pid in complete['layers']:
            if guards[pid]['expectedTree']['m_text'] != joined:
                expected[pid] = {'m_text': joined}
        for pid in family['inheritedHeightRects']:
            before = guards[pid]['expectedTree']
            _assert(guards[pid]['kind'] == 'RectTransform' and before['m_Pivot']['y'] == .5, 'bell-inheritance-rect', pid)
            fields = {f: copy.deepcopy(before[f]) for f in ('m_AnchorMin', 'm_AnchorMax', 'm_SizeDelta')}
            fields['m_AnchorMin']['y'] = 0.
            fields['m_AnchorMax']['y'] = 1.
            fields['m_SizeDelta']['y'] = 0.
            expected[pid] = fields
    _assert(len(complete_layers) == 24 and len(expected) == 50, 'bell-complete-scope')
    declared = {}
    for change in contract['changes']:
        pid = change['pathId']
        _assert(pid not in declared and pid in expected, 'bell-change-id', pid)
        fields = change.get('fields') or {change['field']: {'before': change['before'], 'after': change['after']}}
        declared[pid] = {field: value['after'] for field, value in fields.items()}
        for field, value in fields.items():
            _assert(guards[pid]['expectedTree'][field] == value['before'], 'bell-change-before', pid, field)
    _assert(declared == expected, 'bell-exact-field-allowlist')
    return contract, guards, expected


def plan_from_trees(trees, *, contract_path=None):
    """Validate every finite input guard, then return only the 50 changed trees."""
    contract, guards, changes = load_contract(contract_path)
    for pid, row in guards.items():
        _assert(pid in trees and canonical(trees[pid]) == row['expectedTree'], 'bell-before-tree', pid)
    updates = {}
    for pid, fields in changes.items():
        after = copy.deepcopy(trees[pid])
        after.update(copy.deepcopy(fields))
        actual = {k for k in set(after) | set(trees[pid]) if after.get(k) != trees[pid].get(k)}
        _assert(actual == set(fields), 'bell-changed-fields', pid, sorted(actual))
        updates[pid] = after
    receipt = {
        'contractSha256': sha(Path(contract_path) if contract_path else CONTRACT),
        'effectiveInputSha256': contract['effectiveInputSha256'],
        'counts': contract['counts'],
        'runtimeVisualAccepted': False,
        'mechanism': contract['mechanism'],
        'allowedChanges': contract['changes'],
        'families': contract['families'],
    }
    return updates, receipt


def plan(objects, generator, *, contract_path=None):
    """Adapter for parent preview integration; never writes an asset or save."""
    _, guards, _ = load_contract(contract_path)
    trees = {pid: read_tree(objects[pid], generator) for pid in guards}
    return plan_from_trees(trees, contract_path=contract_path)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--data', type=Path, required=True)
    parser.add_argument('--contract', type=Path, default=CONTRACT)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    _assert(not args.output.exists(), 'bell-new-output-required', str(args.output))
    contract, guards, _ = load_contract(args.contract)
    resource = args.data / contract['resource']
    _assert(sha(resource) == contract['effectiveInputSha256'], 'bell-effective-resource-pin')
    _assert(sha(ROOT / contract['sourceInventory']) == contract['sourceInventorySha256'], 'bell-source-inventory-pin')
    _assert(sha(ROOT / contract['sourceObjects']) == contract['sourceObjectsSha256'], 'bell-source-objects-pin')
    for row in guards.values():
        if row['sourceTreePath']:
            _assert(sha(ROOT / row['sourceTreePath']) == row['sourceTreeSha256'], 'bell-source-tree-pin', row['pathId'])
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    env = UnityPy.load(str(resource))
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(args.data / 'Managed'))
    objects = {obj.path_id: obj for obj in env.objects}
    updates, receipt = plan(objects, generator, contract_path=args.contract)
    # Assert reinsertion and an independent deserialization of each planned object.
    for pid, tree in updates.items():
        obj = objects[pid]
        if obj.type.name == 'MonoBehaviour':
            script = obj.parse_monobehaviour_head().m_Script.deref().read()
            fullname = (script.m_Namespace + '.' if script.m_Namespace else '') + script.m_ClassName
            nodes = generator.cache.get(('forest-header-aligned:' + script.m_AssemblyName, fullname))
            obj.save_typetree(tree, nodes=nodes)
        else:
            obj.save_typetree(tree)
    reloaded = UnityPy.load(env.file.save())
    reloaded.path = str(args.data.resolve())
    after_objects = {obj.path_id: obj for obj in reloaded.objects}
    for pid, tree in updates.items():
        _assert(canonical(read_tree(after_objects[pid], generator)) == canonical(tree), 'bell-typetree-readback', pid)
    args.output.mkdir(parents=True)
    (args.output / 'changed-trees.json').write_text(json.dumps(updates, ensure_ascii=False, indent=2) + '\n')
    receipt['validation'] = {'sourcePins': True, 'effectiveInputPin': True, 'all192BeforeTrees': True,
                             'exact50ObjectAllowlist': True, 'all50TypetreeReadbacks': True,
                             'resourceFileUnchanged': sha(resource) == contract['effectiveInputSha256']}
    (args.output / 'receipt.json').write_text(json.dumps(receipt, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps({'output': str(args.output), 'counts': receipt['counts'], 'validation': receipt['validation']}))


if __name__ == '__main__':
    main()
