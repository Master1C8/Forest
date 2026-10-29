#!/usr/bin/env python3
"""Finite reviewed Green/Red/Purple notification text projection."""
import argparse
import copy
import hashlib
import json
from pathlib import Path
import shutil

PROJECT = Path('/Users/antonkrutov/Desktop/Forest')
LOCAL = Path(__file__).resolve().parent
if (LOCAL / 'bell-notifications/pins.json').exists():
    LOCAL = LOCAL / 'bell-notifications'
PACKET = LOCAL / 'inputs' if (LOCAL / 'pins.json').exists() else PROJECT / 'localization/hotfixes/ru-bell-notifications72-20261029'


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def load_inputs():
    if (LOCAL / 'pins.json').exists():
        for name, expected in json.loads((LOCAL / 'pins.json').read_text()).items():
            assert sha(LOCAL / name) == expected, ('Bell snapshot pin', name)
    contract = json.loads((PACKET / 'contract.json').read_text())
    targets = json.loads((PACKET / 'targets.json').read_text())
    review = json.loads((PACKET / 'independent-review.json').read_text())
    font = json.loads((PACKET / 'font-requirements.json').read_text())
    assert review['status'] == 'clean' and not review['findings']
    assert review['targetsSha256'] == contract['targetsSha256'] == sha(PACKET / 'targets.json')
    assert font['targetsSha256'] == contract['targetsSha256'] and not font['missingCodepoints']
    byid = {r['id']: r for r in targets}
    assert len(byid) == len(targets) == len(contract['rows']) == 72
    assert set(byid) == {r['id'] for r in contract['rows']}
    for row in contract['rows']:
        target = byid[row['id']]
        assert (row['beforeTree']['m_text'], row['target'], row['hierarchy']) == (target['source'], target['target'], target['hierarchy'])
    return contract


def snapshot(out):
    load_inputs()
    dest = Path(out) / 'bell-notifications'
    dest.mkdir()
    (dest / 'inputs').mkdir()
    for name in ['contract.json', 'targets.json', 'independent-review.json', 'review-packet.json', 'font-requirements.json']:
        shutil.copy2(PACKET / name, dest / 'inputs' / name)
    for name in ['russian_bell_notifications.py', 'extract_assets.py']:
        shutil.copy2(LOCAL / name, dest / name)
    shutil.copy2(dest / 'russian_bell_notifications.py', Path(out) / 'russian_bell_notifications.py')
    (dest / 'pins.json').write_text(json.dumps({str(p.relative_to(dest)): sha(p) for p in dest.rglob('*') if p.is_file()}, indent=2) + '\n')
    return dest


def validate_groups(contract, trees):
    groups = {}
    for row in contract['rows']:
        base = row['hierarchy'].split('/NameGlowLeft')[0]
        groups.setdefault(base, []).append(row)
    assert len(groups) == 12 and all(len(rows) == 6 for rows in groups.values())
    for rows in groups.values():
        assert len({trees[r['pathId']]['m_text'] for r in rows}) == 1
    for family, title in contract['expectedTitles'].items():
        suffix = lambda r: tuple(r['hierarchy'].split('/Title', 1)[1].split('/', 1)[1:])
        initial = {suffix(r): trees[r['pathId']]['m_text'] for r in groups[family + '/Page1/Title (1)']}
        remainder = {suffix(r): trees[r['pathId']]['m_text'] for r in groups[family + '/Page1/Title']}
        assert initial.keys() == remainder.keys() and len(initial) == 6
        assert all(initial[k] + remainder[k] == title for k in initial)


def _project_native_tmp(source, output, contract, group_validator):
    """Project an already-validated finite contract; check disk readback/reversal.

    Callers own packet/editorial/font/source admission and output exclusivity.
    Only contract m_text fields may differ; the complete other-object raw-byte
    equality also protects artwork, geometry, masks and native unlock state.
    """
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    from extract_assets import read_tree, canonical
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(source / 'Managed'))
    env = UnityPy.load(str(source / contract['resource']))
    objects = env.file.objects
    raw = {pid: obj.get_raw_data() for pid, obj in objects.items()}
    assert env.file.save() == (source / contract['resource']).read_bytes()
    expected = {}
    for row in contract['rows']:
        obj = objects[row['pathId']]
        before = canonical(read_tree(obj, generator))
        assert before == row['beforeTree'], ('Native TMP before tree', row['id'])
        tree = copy.deepcopy(before)
        tree['m_text'] = row['target']
        script = obj.parse_monobehaviour_head().m_Script.deref().read()
        fullname = (script.m_Namespace + '.' if script.m_Namespace else '') + script.m_ClassName
        assert fullname == 'TMPro.TextMeshProUGUI'
        obj.save_typetree(tree, nodes=generator.cache[('forest-header-aligned:' + script.m_AssemblyName, fullname)])
        expected[row['pathId']] = tree
    group_validator(contract, expected)
    data = env.file.save()
    output.mkdir(parents=True)
    (output / contract['resource']).write_bytes(data)
    assert (output / contract['resource']).read_bytes() == data
    back = UnityPy.load(str(output / contract['resource']))
    back.path = str(source)
    after = back.file.objects
    actual_raw = {pid: obj.get_raw_data() for pid, obj in after.items()}
    assert raw.keys() == actual_raw.keys()
    assert {pid for pid in raw if raw[pid] != actual_raw[pid]} == set(expected)
    actual = {pid: canonical(read_tree(after[pid], generator)) for pid in expected}
    assert actual == expected
    group_validator(contract, actual)
    for pid in expected:
        after[pid].set_raw_data(raw[pid])
    assert back.file.save() == (source / contract['resource']).read_bytes()
    return data


def apply(source, output, *, locale, fail_after_resource=False):
    assert locale == 'ru'
    contract = load_inputs()
    source, output = Path(source), Path(output)
    assert not output.exists(), 'New bell output required'
    assert sha(source / contract['resource']) == contract['sourceSha256']
    assert sha(source / 'resources.assets') == contract['requiredResourcesSha256']
    assert sha(source / 'Managed/Assembly-CSharp.dll') == contract['requiredAssemblySha256']
    assert sha(source / 'sharedassets0.assets') == json.loads((PACKET / 'font-requirements.json').read_text())['fontContainerSha256']
    _project_native_tmp(source, output, contract, validate_groups)
    if fail_after_resource:
        raise RuntimeError('injected-after-bell-resource-before-receipt')
    result = dict(status='finite-bell72-resource-pass', locale=locale, changedTextFields=72,
                  wholeNotificationPages=3, reusedHeaderComponents=54, newBodyMemberships=18,
                  sixLayerTitleJoins=18, allOtherObjectBytesPreserved=True,
                  allNontextFieldsPreserved=True, wholeContainerReversalByteExact=True,
                  sourceSha256=contract['sourceSha256'], targetSha256=sha(output / contract['resource']),
                  resource=contract['resource'], targetsSha256=contract['targetsSha256'],
                  existingBlueAndJournalFieldsPreserved=True, runtimeVisualAccepted=False,
                  wholeGameAccepted=False, commitBoundary='One exclusive resource then separate receipt; incomplete occupied output rejects retry')
    (output / 'Result.json').write_text(json.dumps(result, indent=2) + '\n')
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--locale', required=True)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    print(json.dumps(apply(args.source, args.output, locale=args.locale)))
