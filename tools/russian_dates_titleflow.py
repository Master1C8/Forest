#!/usr/bin/env python3
"""Reviewed three-page Dates text and source-bound unified bell heading flow."""
import argparse
import copy
import hashlib
import importlib.metadata
import json
from pathlib import Path
import re
import shutil
import sys

PROJECT = Path('/Users/antonkrutov/Desktop/Forest')
LOCAL = Path(__file__).resolve().parent
if (LOCAL / 'dates-titleflow/pins.json').exists():
    LOCAL = LOCAL / 'dates-titleflow'
PACKET = LOCAL / 'inputs' if (LOCAL / 'pins.json').exists() else PROJECT / 'localization/hotfixes/ru-dates-titleflow-20261029'
sys.path.insert(0, str(LOCAL))

def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()

def dependencies(lock):
    packages = {}
    for line in lock.read_text().splitlines():
        name, version = line.split('==')
        dist = importlib.metadata.distribution(name)
        assert dist.version == version, ('Dependency version', name)
        packages[name] = dict(version=version, files={str(p): sha(dist.locate_file(p)) for p in dist.files if '..' not in p.parts and Path(str(p)).suffix != '.pyc' and dist.locate_file(p).is_file()})
    return dict(python=list(sys.version_info[:3]), packages=packages)

def load_inputs():
    if (LOCAL / 'pins.json').exists():
        for name, expected in json.loads((LOCAL / 'pins.json').read_text()).items():
            assert sha(LOCAL / name) == expected, ('Snapshot pin', name)
        assert dependencies(LOCAL / 'requirements-assets.lock') == json.loads((LOCAL / 'runtime-dependencies.json').read_text())
    contract = json.loads((PACKET / 'dates-contract.json').read_text())
    targets = json.loads((PACKET / 'targets.json').read_text())
    review = json.loads((PACKET / 'independent-review.json').read_text())
    font = json.loads((PACKET / 'font-requirements.json').read_text())
    assert review['status'] == 'clean' and not review['findings']
    assert review['targetsSha256'] == contract['targetsSha256'] == font['targetsSha256'] == sha(PACKET / 'targets.json')
    assert review['packetSha256'] == sha(PACKET / 'review-packet.json')
    assert review['coverage']['complete'] and review['coverage']['memberships'] == 36
    assert set(review['coverage']['allMembershipIds']) == {r['id'] for r in targets}
    assert not font['missingCodepoints']
    assert contract['locale'] == 'ru' and contract['resource'] == 'sharedassets2.assets'
    assert len(contract['rows']) == len(targets) == 36
    assert len({r['pathId'] for r in contract['rows']}) == 36
    byid = {r['id']: r for r in targets}
    groups = {}
    for row in contract['rows']:
        assert row['id'] == f"sharedassets2.assets:{row['pathId']}/m_text"
        target = byid[row['id']]
        assert (row['beforeTree']['m_text'], row['target'], row['hierarchy']) == (target['source'], target['target'], target['hierarchy'])
        assert re.findall(r'<[^>]*>', target['source']) == re.findall(r'<[^>]*>', target['target'])
        base = row['hierarchy'].split('/NameGlowLeft')[0]
        groups.setdefault(base, []).append(row)
    assert set(groups) == {f'DatesTutorial/Page{page}/{role}' for page in (1, 2, 3) for role in ('Title', 'NameContainer')}
    layers = {'', '/NameGlowLeft', '/NameGlowLeft/Name', '/NameGlowLeft/NameGlowTop', '/NameGlowLeft/NameGlowRight', '/NameGlowLeft/NameGlowBottom'}
    for base, rows in groups.items():
        assert len(rows) == 6 and {r['hierarchy'][len(base):] for r in rows} == layers
        assert len({r['target'] for r in rows}) == 1
    return contract, font

def snapshot(out):
    load_inputs()
    dest = Path(out) / 'dates-titleflow'
    dest.mkdir()
    (dest / 'inputs').mkdir()
    for name in ['dates-contract.json', 'targets.json', 'independent-review.json', 'review-packet.json', 'font-requirements.json', 'bell-layout-contract.json']:
        shutil.copy2(PACKET / name, dest / 'inputs' / name)
    for name in ['russian_dates_titleflow.py', 'russian_bell_title_layout.py', 'extract_assets.py']:
        shutil.copy2(LOCAL / name, dest / name)
    lock = LOCAL / 'requirements-assets.lock'
    shutil.copy2(lock if lock.exists() else PROJECT / 'requirements-assets.lock', dest / 'requirements-assets.lock')
    (dest / 'runtime-dependencies.json').write_text(json.dumps(dependencies(dest / 'requirements-assets.lock'), indent=2) + '\n')
    shutil.copy2(dest / 'russian_dates_titleflow.py', Path(out) / 'russian_dates_titleflow.py')
    (dest / 'pins.json').write_text(json.dumps({str(p.relative_to(dest)): sha(p) for p in sorted(dest.rglob('*')) if p.is_file()}, indent=2) + '\n')
    return dest

def apply(source, output, *, locale='ru', fail_after_resource=False):
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    from extract_assets import read_tree, canonical
    import russian_bell_title_layout as layout
    assert locale == 'ru'
    contract, font = load_inputs()
    source, output = Path(source), Path(output)
    assert not output.exists(), 'New exclusive output required'
    for name, expected in [(contract['resource'], contract['sourceSha256']), ('resources.assets', contract['requiredResourcesSha256']), ('Managed/Assembly-CSharp.dll', contract['requiredAssemblySha256']), ('sharedassets0.assets', font['fontContainerSha256'])]:
        assert sha(source / name) == expected, ('Source binding', name)
    gen = TypeTreeGenerator('2020.3.24f1')
    gen.load_local_dll_folder(str(source / 'Managed'))
    env = UnityPy.load(str(source / contract['resource']))
    objects = env.file.objects
    raw = {pid: o.get_raw_data() for pid, o in objects.items()}
    assert env.file.save() == (source / contract['resource']).read_bytes()
    expected = {}
    for row in contract['rows']:
        before = canonical(read_tree(objects[row['pathId']], gen))
        assert before == row['beforeTree'], ('Before tree', row['id'])
        expected[row['pathId']] = dict(copy.deepcopy(before), m_text=row['target'])
    layout_plan, layout_receipt = layout.plan(objects, gen, contract_path=PACKET / 'bell-layout-contract.json')
    assert not (set(expected) & set(layout_plan))
    expected.update(layout_plan)
    for pid, tree in expected.items():
        obj = objects[pid]
        if obj.type.name == 'MonoBehaviour':
            script = obj.parse_monobehaviour_head().m_Script.deref().read()
            fullname = (script.m_Namespace + '.' if script.m_Namespace else '') + script.m_ClassName
            assert fullname == 'TMPro.TextMeshProUGUI'
            obj.save_typetree(tree, nodes=gen.cache[('forest-header-aligned:' + script.m_AssemblyName, fullname)])
        else:
            obj.save_typetree(tree)
    output.mkdir(parents=True)
    (output / contract['resource']).write_bytes(env.file.save())
    back = UnityPy.load(str(output / contract['resource']))
    back.path = str(source)
    after = back.file.objects
    assert raw.keys() == after.keys()
    assert {pid for pid in raw if raw[pid] != after[pid].get_raw_data()} == set(expected)
    assert {pid: canonical(read_tree(after[pid], gen)) for pid in expected} == expected
    target_sha = sha(output / contract['resource'])
    for pid in expected:
        after[pid].set_raw_data(raw[pid])
    assert back.file.save() == (source / contract['resource']).read_bytes()
    if fail_after_resource:
        raise RuntimeError('injected-after-dates-resource-before-receipt')
    result = dict(status='finite-dates-and-bell-titleflow-resource-pass', locale=locale, resource=contract['resource'], sourceSha256=contract['sourceSha256'], targetSha256=target_sha, targetsSha256=contract['targetsSha256'], changedObjects=len(expected), datesTextFields=36, datesPages=3, bellLayout=layout_receipt, actualSavedReadbackVerified=True, allUnselectedObjectBytesPreserved=True, wholeContainerReversalByteExact=True, runtimeVisualAccepted=False, sourceGateAccepted=False, ordinaryTranslationEntryAllowed=False, wholeGameAccepted=False, commitBoundary='Exclusive single resource, then separate receipt; interruption retains occupied output')
    (output / 'Result.json').write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    return result

if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--source', type=Path, required=True)
    p.add_argument('--output', type=Path, required=True)
    p.add_argument('--locale', required=True)
    a = p.parse_args()
    print(json.dumps(apply(a.source, a.output, locale=a.locale)))
