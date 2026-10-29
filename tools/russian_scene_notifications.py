#!/usr/bin/env python3
"""Finite reviewed scene-unlock notification text projection (114 fields)."""
import argparse
import importlib.metadata
import importlib.util
import json
from pathlib import Path
import re
import shutil
import sys

PROJECT = Path('/Users/antonkrutov/Desktop/Forest')
LOCAL = Path(__file__).resolve().parent
if (LOCAL / 'scene-notifications/pins.json').exists():
    LOCAL = LOCAL / 'scene-notifications'
PACKET = LOCAL / 'inputs' if (LOCAL / 'pins.json').exists() else PROJECT / 'localization/hotfixes/ru-scene-unlocked114-20261029'
if (LOCAL / 'pins.json').exists():
    sys.path.insert(0, str(LOCAL))
_spec = importlib.util.spec_from_file_location('forest_scene_tmp_projection', LOCAL / 'russian_bell_notifications.py')
_engine = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_engine)
_project_native_tmp, sha = _engine._project_native_tmp, _engine.sha
EXPECTED_IDS = frozenset([
    13908, 13909, 13910, 13911, 13912, 13989, 13990, 13991, 13992, 13993,
    13997, 14036, 14185, 14217, 14288, 14711, 14758, 14779, 14780, 14781,
    14782, 14888, 14930, 14931, 14932, 14933, 14934, 14988, 14989, 14990,
    14991, 15037, 15177, 15239, 15240, 15241, 15242, 15243, 15574, 15575,
    15576, 15577, 15578, 16256, 16257, 16258, 16259, 16260, 16263, 16342,
    16392, 16467, 16522, 16682, 16683, 16684, 16685, 16686, 16759, 16760,
    16761, 16762, 16763, 16883, 16884, 16885, 16886, 16887, 16897, 16915,
    16944, 17002, 17155, 17156, 17157, 17158, 17172, 17251, 17252, 17253,
    17254, 17255, 17331, 17336, 17471, 17472, 17473, 17474, 17475, 17823,
    17824, 17825, 17826, 17845, 17871, 17872, 17873, 17874, 17952, 18020,
    18028, 18279, 18350, 18351, 18352, 18353, 18405, 18827, 18836, 18837,
    18838, 18839, 18840, 18850,
])
ROOTS = (
    'GeneralMovieUnlockNotification', 'RamAnalSceneUnlockNotification',
    'CoyotesOralSceneUnlockNotification', 'BunnyCuckSceneUnlockNotification',
    'SquirrelSceneUnlockNotification', 'PlantSceneUnlockNotification',
    'BunnyHandjobSceneUnlockNotification',
)
LAYERS = frozenset(('', '/NameGlowLeft', '/NameGlowLeft/Name',
                    '/NameGlowLeft/NameGlowBottom', '/NameGlowLeft/NameGlowRight',
                    '/NameGlowLeft/NameGlowTop'))


def validate_groups(contract, trees):
    """Validate whole strings in their original six layers, without joins."""
    rows = contract['rows']
    assert len(rows) == len({r['id'] for r in rows}) == 114, 'Scene exact membership count'
    assert {r['pathId'] for r in rows} == EXPECTED_IDS, 'Scene exact path IDs'
    assert set(trees) == EXPECTED_IDS, 'Scene exact projected tree IDs'
    assert tuple(contract['roots']) == ROOTS, 'Scene exact page roots'
    expected_groups = {root + '/Page1/NameContainer' for root in ROOTS}
    expected_groups |= {root + '/Page1/Title' for root in ROOTS if root != ROOTS[0]}
    expected_groups |= {root + '/Page1/Title (1)' for root in ROOTS[:-1]}
    groups = {}
    for row in rows:
        assert row['id'] == f"sharedassets2.assets:{row['pathId']}/m_text"
        base = row['hierarchy'].split('/NameGlowLeft')[0]
        groups.setdefault(base, []).append(row)
        source, target = row['beforeTree']['m_text'], trees[row['pathId']]['m_text']
        assert re.findall(r'<[^>]*>', source) == re.findall(r'<[^>]*>', target), 'Scene size spans preserved'
        if '/Title' in base:
            size = '22' if base.endswith('Title (1)') or base.startswith(ROOTS[-1] + '/') else '36'
            assert source == f'<size={size}>S</size>CENE <size={size}>U</size>NLOCKED!'
            assert len(re.findall(r'<size=' + size + r'>[^<>]+</size>', target)) == 2
            assert '<' not in re.sub(r'<[^>]*>', '', target)
        else:
            assert source == 'Watch it again in the Start Menu Gallery!'
            assert target and '<' not in target and '>' not in target
    assert set(groups) == expected_groups and len(groups) == 19, 'Scene exact whole-string groups'
    for base, members in groups.items():
        assert len(members) == 6 and {r['hierarchy'][len(base):] for r in members} == LAYERS, 'Scene six exact layers'
        assert len({trees[r['pathId']]['m_text'] for r in members}) == 1, 'Scene six-layer text equality'


def _dependencies(lock=None):
    """Pin installed dependency bytes by distribution-relative path, not prefix."""
    lock = lock or LOCAL / 'requirements-assets.lock'
    packages = {}
    for line in lock.read_text().splitlines():
        name, version = line.split('==')
        dist = importlib.metadata.distribution(name)
        assert dist.version == version, ('Scene dependency version', name)
        files = {str(p): sha(dist.locate_file(p)) for p in dist.files
                 if '..' not in p.parts and Path(str(p)).suffix != '.pyc' and dist.locate_file(p).is_file()}
        packages[name] = dict(version=version, files=files)
    return dict(python=list(sys.version_info[:3]), packages=packages)


def load_inputs():
    if (LOCAL / 'pins.json').exists():
        for name, expected in json.loads((LOCAL / 'pins.json').read_text()).items():
            assert sha(LOCAL / name) == expected, ('Scene snapshot pin', name)
        assert _dependencies() == json.loads((LOCAL / 'runtime-dependencies.json').read_text()), 'Scene dependency bytes'
    contract = json.loads((PACKET / 'contract.json').read_text())
    targets = json.loads((PACKET / 'targets.json').read_text())
    review = json.loads((PACKET / 'independent-review.json').read_text())
    font = json.loads((PACKET / 'font-requirements.json').read_text())
    assert review['status'] == 'clean' and not review['findings'], 'Scene reviewed receipt required'
    assert review['packetSha256'] == sha(PACKET / 'review-packet.json'), 'Scene reviewed context version'
    assert review['coverage']['complete'] and review['coverage']['memberships'] == 114
    assert set(review['coverage']['allMembershipIds']) == {r['id'] for r in contract['rows']}, 'Scene full reviewed coverage'
    assert review['targetsSha256'] == contract['targetsSha256'] == sha(PACKET / 'targets.json'), 'Scene reviewed target version'
    assert font['targetsSha256'] == contract['targetsSha256'] and not font['missingCodepoints']
    assert contract['locale'] == 'ru' and contract['resource'] == 'sharedassets2.assets'
    byid = {r['id']: r for r in targets}
    assert len(byid) == len(targets) == 114
    assert set(byid) == {r['id'] for r in contract['rows']}
    for row in contract['rows']:
        target = byid[row['id']]
        assert (row['beforeTree']['m_text'], row['target'], row['hierarchy']) == (target['source'], target['target'], target['hierarchy'])
    trees = {r['pathId']: dict(r['beforeTree'], m_text=r['target']) for r in contract['rows']}
    validate_groups(contract, trees)
    return contract


def snapshot(out):
    load_inputs()
    dest = Path(out) / 'scene-notifications'
    dest.mkdir()
    (dest / 'inputs').mkdir()
    for name in ['contract.json', 'targets.json', 'independent-review.json', 'review-packet.json', 'font-requirements.json']:
        shutil.copy2(PACKET / name, dest / 'inputs' / name)
    for name in ['russian_scene_notifications.py', 'russian_bell_notifications.py', 'extract_assets.py']:
        shutil.copy2(LOCAL / name, dest / name)
    lock = LOCAL / 'requirements-assets.lock'
    shutil.copy2(lock if lock.exists() else PROJECT / 'requirements-assets.lock', dest / 'requirements-assets.lock')
    # Compute through the frozen lock, including every installed dependency file.
    dependencies = _dependencies(dest / 'requirements-assets.lock')
    (dest / 'runtime-dependencies.json').write_text(json.dumps(dependencies, indent=2) + '\n')
    shutil.copy2(dest / 'russian_scene_notifications.py', Path(out) / 'russian_scene_notifications.py')
    (dest / 'pins.json').write_text(json.dumps({str(p.relative_to(dest)): sha(p) for p in sorted(dest.rglob('*')) if p.is_file()}, indent=2) + '\n')
    return dest


def apply(source, output, *, locale='ru', fail_after_resource=False):
    assert locale == 'ru'
    contract = load_inputs()
    source, output = Path(source), Path(output)
    assert not output.exists(), 'New scene output required'
    assert sha(source / contract['resource']) == contract['sourceSha256']
    assert sha(source / 'resources.assets') == contract['requiredResourcesSha256']
    assert sha(source / 'Managed/Assembly-CSharp.dll') == contract['requiredAssemblySha256']
    assert sha(source / 'sharedassets0.assets') == json.loads((PACKET / 'font-requirements.json').read_text())['fontContainerSha256']
    _project_native_tmp(source, output, contract, validate_groups)
    if fail_after_resource:
        raise RuntimeError('injected-after-scene-resource-before-receipt')
    result = dict(status='finite-scene114-resource-pass', locale=locale, changedTextFields=114,
                  wholeNotificationPages=7, reusedHeaderComponents=72, newBodyMemberships=42,
                  wholeStringSixLayerGroups=19, splitTitleJoins=0,
                  allOtherObjectBytesPreserved=True, allNontextFieldsPreserved=True,
                  actualSavedReadbackVerified=True, wholeContainerReversalByteExact=True,
                  sourceSha256=contract['sourceSha256'], targetSha256=sha(output / contract['resource']),
                  resource=contract['resource'], targetsSha256=contract['targetsSha256'],
                  existingBlueSwimBellAndJournalFieldsPreserved=True,
                  sourceGateAccepted=False, ordinaryTranslationEntryAllowed=False,
                  runtimeVisualAccepted=False, wholeGameAccepted=False,
                  commitBoundary='One exclusive resource then separate receipt; incomplete occupied output rejects retry')
    (output / 'Result.json').write_text(json.dumps(result, indent=2) + '\n')
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--locale', required=True)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    print(json.dumps(apply(args.source, args.output, locale=args.locale)))
