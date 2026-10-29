#!/usr/bin/env python3
"""Guarded 66-field native tutorial/Blue Bell repair; preserves artwork and code."""
import argparse
import copy
import hashlib
import json
from pathlib import Path
import shutil

LOCAL = Path(__file__).resolve().parent
if (LOCAL / 'tutorial-notifications/pins.json').exists():
    LOCAL = LOCAL / 'tutorial-notifications'
PROJECT = Path('/Users/antonkrutov/Desktop/Forest')
PACKET = LOCAL / 'inputs' if (LOCAL / 'pins.json').exists() else PROJECT / 'localization/source/tutorial-notifications66-20261029'


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def load_inputs():
    if (LOCAL / 'pins.json').exists():
        for name, expected in json.loads((LOCAL / 'pins.json').read_text()).items():
            assert sha(LOCAL / name) == expected, ('Frozen tutorial input', name)
    contract = json.loads((PACKET / 'source-contract.json').read_text())
    review = json.loads((PACKET / 'independent-review.json').read_text())
    targets = json.loads((PACKET / 'targets.json').read_text())
    byid = {r['id']: r for r in targets}
    assert contract['locale'] == 'ru' and len(contract['rows']) == 66
    assert len(targets) == len(byid) == 66
    assert {r['sourceId'] for r in contract['rows']} == set(byid)
    for row in contract['rows']:
        target = byid[row['sourceId']]
        assert (row['source'], row['target'], row['hierarchy']) == (target['source'], target['target'], target['hierarchy']), 'Contract target binding mismatch'
    assert contract['targetsSha256'] == sha(PACKET / 'targets.json')
    assert review['status'] == 'clean' and not review['objectiveFindings'], 'Independent review required'
    assert review['coverage']['reviewedIds'] == 66 and not review['coverage']['unreadIds']
    assert review['inputsSha256']['localization/source/tutorial-notifications66-20261029/targets.json'] == contract['targetsSha256'], 'Version-matching review required'
    assert review['inputsSha256']['localization/source/shared-source-completion-20261028/admission-v1/direct-context.jsonl'] == contract['sourceCommonInventorySha256']
    assert not any(contract[k] for k in ['sourceGateAccepted', 'ordinaryTranslationEntryAllowed', 'wholeGameAccepted'])
    return contract


def snapshot(out):
    load_inputs()
    folder = Path(out) / 'tutorial-notifications'
    folder.mkdir()
    inputs = folder / 'inputs'
    inputs.mkdir()
    for name in ['source-contract.json', 'targets.json', 'author-review.json', 'independent-review.json', 'font-coverage.json']:
        shutil.copy2(PACKET / name, inputs / name)
    for name in ['russian_tutorial_notifications.py', 'extract_assets.py']:
        shutil.copy2(LOCAL / name, folder / name)
    shutil.copy2(LOCAL / 'russian_tutorial_notifications.py', Path(out) / 'russian_tutorial_notifications.py')
    pins = {str(p.relative_to(folder)): sha(p) for p in folder.rglob('*') if p.is_file()}
    (folder / 'pins.json').write_text(json.dumps(pins, indent=2) + '\n')
    return folder


def validate_groups(rows, trees):
    # Every original six-layer group has exactly one target, except the explicit
    # physically split Blue Bell title, which remains six matched pairs.
    grouped = {}
    for row in rows:
        base = row['hierarchy'].split('/NameGlowLeft')[0]
        grouped.setdefault(base, []).append(row)
    assert len(grouped) == 11 and all(len(v) == 6 for v in grouped.values())
    for group in grouped.values():
        assert len({trees[r['pathId']]['m_text'] for r in group}) == 1
    initials = grouped['BlueBellItemNotification/Page1/Title (1)']
    remainders = grouped['BlueBellItemNotification/Page1/Title']
    suffix = lambda r: r['hierarchy'].split('/Title', 1)[1].split('/', 1)[1:] or ['']
    a = {tuple(suffix(r)): trees[r['pathId']]['m_text'] for r in initials}
    b = {tuple(suffix(r)): trees[r['pathId']]['m_text'] for r in remainders}
    assert a.keys() == b.keys() and len(a) == 6
    assert all(a[k] + b[k] == '<size=22>С</size>ИНИЙ <size=22>К</size>ОЛОКОЛЬЧИК' for k in a)


def apply(source, output, *, locale, fail_after_resource=False):
    assert locale == 'ru', 'Explicit ru locale required'
    contract = load_inputs()
    source, output = Path(source), Path(output)
    assert not output.exists(), 'New output required'
    resource = source / contract['resource']
    assert sha(resource) == contract['sourceResourceSha256'], 'Exact supported resource required'
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    from extract_assets import read_tree, canonical
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(source / 'Managed'))
    coverage = json.loads((PACKET / 'font-coverage.json').read_text())
    assert coverage['targetSha256'] == contract['targetsSha256'] and coverage['missingCmapCodepoints'] == []
    primary_env = UnityPy.load(str(source / 'sharedassets0.assets')).file
    resource_env = UnityPy.load(str(source / 'resources.assets')).file
    assert hashlib.sha256(primary_env.objects[3323].get_raw_data()).hexdigest() == coverage['primaryRawSha256']
    font = resource_env.objects[439].read()
    assert hashlib.sha256(bytes(font.m_FontData)).hexdigest() == coverage['fontDataSha256']
    settings = canonical(read_tree(resource_env.objects[1020], generator))
    fallback = canonical(read_tree(resource_env.objects[1017], generator))
    assert settings['m_fallbackFontAssets'] == coverage['globalFallbacks']
    assert fallback['m_SourceFontFile'] == {'m_FileID': 0, 'm_PathID': 439}
    env = UnityPy.load(str(resource))
    asset = env.file
    objects = asset.objects
    raw = {pid: obj.get_raw_data() for pid, obj in objects.items()}
    noop = asset.save()
    assert noop == resource.read_bytes(), 'Whole native container no-op equality required'
    selected = {r['pathId'] for r in contract['rows']}
    before, expected = {}, {}
    for row in contract['rows']:
        obj = objects[row['pathId']]
        tree = canonical(read_tree(obj, generator))
        assert tree['m_text'] == row['source']
        assert {k: v for k, v in tree.items() if k != 'm_text'} == row['nontext']
        assert hashlib.sha256(obj.get_raw_data()).hexdigest() == row['beforeRawSha256']
        before[row['pathId']] = tree
        target = copy.deepcopy(tree)
        target['m_text'] = row['target']
        expected[row['pathId']] = target
        script = obj.parse_monobehaviour_head().m_Script.deref().read()
        full = (script.m_Namespace + '.' if script.m_Namespace else '') + script.m_ClassName
        assert full == 'TMPro.TextMeshProUGUI'
        obj.save_typetree(target, nodes=generator.cache[('forest-header-aligned:' + script.m_AssemblyName, full)])
    validate_groups(contract['rows'], expected)
    result_bytes = asset.save()
    back = UnityPy.load(result_bytes).file
    after_raw = {pid: obj.get_raw_data() for pid, obj in back.objects.items()}
    assert raw.keys() == after_raw.keys()
    assert {pid for pid in raw if raw[pid] != after_raw[pid]} == selected
    actual = {pid: canonical(read_tree(back.objects[pid], generator)) for pid in selected}
    assert actual == expected, 'Complete delivered field and nontext readback'
    validate_groups(contract['rows'], actual)
    for pid in selected:
        back.objects[pid].set_raw_data(raw[pid])
    assert back.save() == resource.read_bytes(), 'Whole resource reversal must be byte-exact'
    output.mkdir(parents=True)
    (output / contract['resource']).write_bytes(result_bytes)
    disk = UnityPy.load(str(output / contract['resource'])).file
    assert {pid: o.get_raw_data() for pid, o in disk.objects.items()} == after_raw
    if fail_after_resource:
        raise RuntimeError('injected-after-resource-before-receipt')
    receipt = dict(status='finite66-static-resource-pass', locale=locale,
                   changedTextFields=66, completePages=3, groupLayers=11,
                   sourceSha256=contract['sourceResourceSha256'], targetSha256=sha(output / contract['resource']),
                   resource=contract['resource'], targetsSha256=contract['targetsSha256'],
                   objectCount=len(raw), allOtherObjectBytesPreserved=True, allNontextFieldsPreserved=True,
                   textureObjectsPreserved=sum(o.type.name == 'Texture2D' for o in disk.objects.values()),
                   wholeResourceReversalByteExact=True, sixLayerJoinsVerified=True,
                   managedCodeAndExternalStreamsWritten=False, runtimeVisualAccepted=False,
                   sourceGateAccepted=False, ordinaryTranslationEntryAllowed=False, wholeGameAccepted=False,
                   writeBoundary='One resource then separate receipt; incomplete occupied output must be preserved')
    (output / 'Result.json').write_text(json.dumps(receipt, indent=2) + '\n')
    return receipt


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--locale', required=True)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    print(json.dumps(apply(args.source, args.output, locale=args.locale)))
