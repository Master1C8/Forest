#!/usr/bin/env python3
"""Finite reviewed end-of-current-content notification (12 TMP fields)."""
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
if (LOCAL / 'completion-notification/pins.json').exists():
    LOCAL = LOCAL / 'completion-notification'
PACKET = LOCAL / 'inputs' if (LOCAL / 'pins.json').exists() else PROJECT / 'localization/hotfixes/ru-completion12-20261029'
if (LOCAL / 'pins.json').exists():
    sys.path.insert(0, str(LOCAL))
_spec = importlib.util.spec_from_file_location('forest_completion_tmp_projection', LOCAL / 'russian_bell_notifications.py')
_engine = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_engine)
_project_native_tmp, sha = _engine._project_native_tmp, _engine.sha
EXPECTED_IDS = frozenset([13932,14022,14801,14979,15350,16402,16454,16795,17188,17213,17817,18241])
ROOTS = ('EndOfMonthlyContentNotification',)
LAYERS = frozenset(('', '/NameGlowLeft', '/NameGlowLeft/Name', '/NameGlowLeft/NameGlowBottom', '/NameGlowLeft/NameGlowRight', '/NameGlowLeft/NameGlowTop'))


def validate_groups(contract, trees):
    rows = contract['rows']
    assert len(rows) == len({r['id'] for r in rows}) == 12
    assert {r['pathId'] for r in rows} == set(trees) == EXPECTED_IDS
    assert tuple(contract['roots']) == ROOTS
    groups = {}
    for row in rows:
        assert row['id'] == f"sharedassets2.assets:{row['pathId']}/m_text"
        base = row['hierarchy'].split('/NameGlowLeft')[0]
        groups.setdefault(base, []).append(row)
        source, target = row['beforeTree']['m_text'], trees[row['pathId']]['m_text']
        assert re.findall(r'<[^>]*>', source) == re.findall(r'<[^>]*>', target)
        assert target and '\r' not in target
    assert set(groups) == {ROOTS[0]+'/Page1/Title (2)', ROOTS[0]+'/Page1/NameContainer'}
    for base, members in groups.items():
        assert len(members) == 6 and {r['hierarchy'][len(base):] for r in members} == LAYERS
        assert len({trees[r['pathId']]['m_text'] for r in members}) == 1


def _dependencies(lock=None):
    """Pin installed dependency bytes by distribution-relative path, not prefix."""
    lock = lock or LOCAL / 'requirements-assets.lock'
    packages = {}
    for line in lock.read_text().splitlines():
        name, version = line.split('==')
        dist = importlib.metadata.distribution(name)
        assert dist.version == version, ('Completion dependency version', name)
        files = {str(p): sha(dist.locate_file(p)) for p in dist.files
                 if '..' not in p.parts and Path(str(p)).suffix != '.pyc' and dist.locate_file(p).is_file()}
        packages[name] = dict(version=version, files=files)
    return dict(python=list(sys.version_info[:3]), packages=packages)


def load_inputs():
    if (LOCAL / 'pins.json').exists():
        for name, expected in json.loads((LOCAL / 'pins.json').read_text()).items():
            assert sha(LOCAL / name) == expected, ('Completion snapshot pin', name)
        assert _dependencies() == json.loads((LOCAL / 'runtime-dependencies.json').read_text()), 'Completion dependency bytes'
    contract = json.loads((PACKET / 'contract.json').read_text())
    targets = json.loads((PACKET / 'targets.json').read_text())
    review = json.loads((PACKET / 'independent-review.json').read_text())
    font = json.loads((PACKET / 'font-requirements.json').read_text())
    assert review['status'] == 'clean' and not review['findings'], 'Completion reviewed receipt required'
    assert review['packetSha256'] == sha(PACKET / 'review-packet.json'), 'Completion reviewed context version'
    assert review['coverage']['complete'] and review['coverage']['memberships'] == 12
    assert set(review['coverage']['allMembershipIds']) == {r['id'] for r in contract['rows']}, 'Completion full reviewed coverage'
    assert review['targetsSha256'] == contract['targetsSha256'] == sha(PACKET / 'targets.json'), 'Completion reviewed target version'
    assert font['targetsSha256'] == contract['targetsSha256'] and not font['missingCodepoints']
    assert contract['locale'] == 'ru' and contract['resource'] == 'sharedassets2.assets'
    byid = {r['id']: r for r in targets}
    assert len(byid) == len(targets) == 12
    assert set(byid) == {r['id'] for r in contract['rows']}
    for row in contract['rows']:
        target = byid[row['id']]
        assert (row['beforeTree']['m_text'], row['target'], row['hierarchy']) == (target['source'], target['target'], target['hierarchy'])
    trees = {r['pathId']: dict(r['beforeTree'], m_text=r['target']) for r in contract['rows']}
    validate_groups(contract, trees)
    return contract


def snapshot(out):
    load_inputs()
    dest = Path(out) / 'completion-notification'
    dest.mkdir()
    (dest / 'inputs').mkdir()
    for name in ['contract.json', 'targets.json', 'independent-review.json', 'review-packet.json', 'font-requirements.json']:
        shutil.copy2(PACKET / name, dest / 'inputs' / name)
    for name in ['russian_completion.py', 'russian_bell_notifications.py', 'extract_assets.py']:
        shutil.copy2(LOCAL / name, dest / name)
    lock = LOCAL / 'requirements-assets.lock'
    shutil.copy2(lock if lock.exists() else PROJECT / 'requirements-assets.lock', dest / 'requirements-assets.lock')
    # Compute through the frozen lock, including every installed dependency file.
    dependencies = _dependencies(dest / 'requirements-assets.lock')
    (dest / 'runtime-dependencies.json').write_text(json.dumps(dependencies, indent=2) + '\n')
    shutil.copy2(dest / 'russian_completion.py', Path(out) / 'russian_completion.py')
    (dest / 'pins.json').write_text(json.dumps({str(p.relative_to(dest)): sha(p) for p in sorted(dest.rglob('*')) if p.is_file()}, indent=2) + '\n')
    return dest


def apply(source, output, *, locale='ru', fail_after_resource=False):
    assert locale == 'ru'
    contract = load_inputs()
    source, output = Path(source), Path(output)
    assert not output.exists(), 'New completion output required'
    assert sha(source / contract['resource']) == contract['sourceSha256']
    assert sha(source / 'resources.assets') == contract['requiredResourcesSha256']
    assert sha(source / 'Managed/Assembly-CSharp.dll') == contract['requiredAssemblySha256']
    assert sha(source / 'sharedassets0.assets') == json.loads((PACKET / 'font-requirements.json').read_text())['fontContainerSha256']
    _project_native_tmp(source, output, contract, validate_groups)
    if fail_after_resource:
        raise RuntimeError('injected-after-completion-resource-before-receipt')
    result = dict(status='finite-completion12-resource-pass', locale=locale, changedTextFields=12,
                  wholeNotificationPages=1, wholeStringSixLayerGroups=2,
                  allOtherObjectBytesPreserved=True, allNontextFieldsPreserved=True,
                  actualSavedReadbackVerified=True, wholeContainerReversalByteExact=True,
                  sourceSha256=contract['sourceSha256'], targetSha256=sha(output / contract['resource']),
                  resource=contract['resource'], targetsSha256=contract['targetsSha256'],
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
