"""Read back the current Russian candidate's finite109-component font matrix.

Static packaged bindings and accepted per-profile target characters are separate
from live component selection, arbitrary names and rendered glyph acceptance.
"""
import argparse
import copy
import hashlib
import json
from pathlib import Path
import sys
import unicodedata

import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
sys.path.insert(0, str(ROOT / 'tools'))
from extract_assets import read_tree
from font_corpus_preflight import inspect_font
from russian_ui935 import load_inputs


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def value_hash(value):
    return hashlib.sha256(json.dumps(value, ensure_ascii=False, separators=(',', ':')).encode()).hexdigest()


def split_id(identity):
    asset, pid = identity.rsplit(':', 1)
    return asset, int(pid)


def check_rows(rows, original_ids):
    ids = [row['componentId'] for row in rows]
    assert len(ids) == len(set(ids)) == 109, 'component-count-or-duplicate'
    assert set(ids) == set(original_ids), 'component-identity-set'
    for row in rows:
        assert row['actualFontPointer'] == row['expectedFontPointer'], 'font-pointer-mismatch'
        assert row['actualMaterialPointer'] == row['expectedMaterialPointer'], 'material-pointer-mismatch'


def verify(candidate, output):
    candidate, output = candidate.resolve(), output.resolve()
    assert candidate.parent == ROOT / 'localization/previews' and not output.exists()
    read = lambda p: json.loads(p.read_text())
    source = ROOT / 'localization/fonts/role-requirements-20261028/reconciliation.json'
    profiles_path = ROOT / 'localization/fonts/final-corpus-bindings-20261028/profile-sources.json'
    baseline, profiles = read(source), read(profiles_path)
    assert len(baseline['selectedComponents']) == 109 and len(profiles) == 10
    build_path = candidate / 'build.json'
    build = read(build_path)
    assert build['siteLocale'] == 'ru' and build['coherentLegacyFace'] and build['uniformTmpFallback']
    assert read(candidate / 'texture-preservation.json')['status'] == 'pass'
    pins = {str(p.relative_to(ROOT)): sha(p) for p in (source, profiles_path, build_path, candidate / 'texture-preservation.json', Path(__file__))}
    original_owners = {}
    for row in baseline['selectedComponents']:
        original_path = ROOT / 'assets/source-v2' / row['component']['tree']
        assert sha(original_path) == row['component']['treeSha256'], 'original-component-tree-pin'
        original_owners[row['component']['id']] = read(original_path)['m_GameObject']
        pins[str(original_path.relative_to(ROOT))] = row['component']['treeSha256']
    assert len(original_owners) == 109, 'original-component-identities'
    for row in build['files']:
        assert sha(candidate / 'game/The Forest of Love_Data' / row['path']) == row['probeSha256'], ('current-artifact-file', row['path'])
    _, accepted935, acceptance935 = load_inputs(locale='ru')
    targets = dict(accepted935)
    target_files = [ROOT / 'localization/supplemental-ui/20261029-existing935/ru.edited.jsonl', ROOT / 'localization/supplemental-ui/20261029-existing935/ru.acceptance.json']
    inv = ROOT / 'localization/supplemental-ui/20261028-inventory'
    accepted52 = read(inv / 'ru.acceptance.json')
    assert sha(inv / accepted52['targetFile']) == accepted52['targetSha256']
    target_files += [inv / 'ru.acceptance.json', inv / accepted52['targetFile']]
    additions = [json.loads(line) for line in (inv / accepted52['targetFile']).read_text().splitlines()]
    assert len(additions) == len({row['id'] for row in additions}) == 52
    for row in additions:
        assert row['id'] not in targets, 'overlapping-target-packets'
        targets[row['id']] = row
    for path in target_files:
        pins[str(path.relative_to(ROOT))] = sha(path)

    data = candidate / 'game/The Forest of Love_Data'
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(data / 'Managed'))
    for name in ('Assembly-CSharp.dll', 'Unity.TextMeshPro.dll', 'UnityEngine.UI.dll'):
        path = data / 'Managed' / name
        pins[str(path.relative_to(ROOT))] = sha(path)
    files = {}

    def asset(spec):
        if spec not in files:
            outer, _, member = spec.partition('!/')
            env = UnityPy.load(str(data / outer))
            current = next(iter(env.files.values()))
            if member:
                assert member in current.files, ('bundle-member', member)
                current = current.files[member]
            files[spec] = current
        return files[spec]

    def tree(spec, pid):
        return read_tree(asset(spec).objects[pid], generator)

    repairs = {(row['sourceFile'], row['componentPathId']): row['targetFont'] for row in build['nativeFontRoleRepair']}
    components = []
    for row in baseline['selectedComponents']:
        identity = row['component']['id']
        spec, pid = split_id(identity)
        actual = tree(spec, pid)
        native = row['component']['class'] == 'UnityEngine.UI.Text'
        font = actual['m_FontData']['m_Font'] if native else actual['m_fontAsset']
        material = actual['m_Material'] if native else actual['m_sharedMaterial']
        expected = repairs.get((spec, pid), row['fontReference'])
        assert actual['m_GameObject'] == original_owners[identity], ('component-owner', identity)
        components.append(dict(componentId=identity, profile=row['requirementProfile'], role=row['role'], kind='native-Text' if native else 'TMP',
                               expectedFontPointer=expected, actualFontPointer=font,
                               expectedMaterialPointer=row['materialReference'], actualMaterialPointer=material,
                               serializedRawSha256=hashlib.sha256(asset(spec).objects[pid].get_raw_data()).hexdigest(),
                               runtimeSelection='not-established-by-static-readback'))
    check_rows(components, [row['component']['id'] for row in baseline['selectedComponents']])

    # Resolve resource ownership before following a PPtr; path IDs alone are not
    # identities across shared files. The original typed source roster is pinned.
    objects_path = ROOT / 'assets/source-v2/objects.json'
    original_index = {r['id']: r for r in read(objects_path)}
    fallback_ids = [r['id'] for r in original_index.values() if r['pathId'] == 1017 and r.get('class') == 'TMPro.TMP_FontAsset']
    settings_ids = [r['id'] for r in original_index.values() if r['pathId'] == 1020 and r.get('class') == 'TMPro.TMP_Settings']
    assert len(fallback_ids) == len(settings_ids) == 1, 'typed-resource-identity'
    fallback_spec, fallback_pid = split_id(fallback_ids[0])
    settings_spec, settings_pid = split_id(settings_ids[0])
    fallback = tree(fallback_spec, fallback_pid)
    settings = tree(settings_spec, settings_pid)
    assert fallback_spec == settings_spec, 'fallback-settings-file-contract'
    assert fallback['m_AtlasPopulationMode'] == 1 and fallback['m_SourceFontFile'] == dict(m_FileID=0, m_PathID=439), 'dynamic-fallback-source'
    assert original_index[f'{fallback_spec}:439']['type'] == 'Font', 'source-face-type'
    font439 = tree(fallback_spec, 439)
    available, face = inspect_font(font439)
    assert available is not None and face['spaceAdvance'] > 0
    native369 = tree('sharedassets0.assets', 369)
    assert bytes(native369['m_FontData']) == bytes(font439['m_FontData']), 'native-face-bytes'
    resources = [dict(id='sharedassets0.assets:369', faceSha256=face['embeddedFaceSha256'], originalObjectName=native369['m_Name'],
                      sourceFaceId=f'{fallback_spec}:439', dynamicFallbackId=fallback_ids[0], settingsId=settings_ids[0])]
    assert settings['m_fallbackFontAssets'] == [dict(m_FileID=0, m_PathID=1017)], 'global-fallback-binding'
    for spec in build['uniformTmpFallbackRepair']:
        primaries = {row['fontTarget']['id'] for row in baseline['selectedComponents'] if row['component']['class'] == 'TMPro.TextMeshProUGUI' and split_id(row['fontTarget']['id'])[0].partition('!/')[0] == spec}
        assert len(primaries) == 1, ('ordinary-primary-role-count', spec)
        for identity in primaries:
            primary = tree(*split_id(identity))
            assert [r['m_Unicode'] for r in primary['m_CharacterTable']] == [95], 'decorative-underscore-only'
            resources.append(dict(id=identity, sourceName=primary['m_Name'], primaryCodepoints=[95],
                                  atlasPointers=primary['m_AtlasTextures'], materialPointer=primary['material'],
                                  ordinaryRoute='Global dynamic1017 ->embedded Font439; static serialized route only'))
    fictional = []
    for pid in (3324, 3, 245):
        identity = f'sharedassets0.assets:{pid}'
        original = original_index[identity]
        actual_hash = hashlib.sha256(asset('sharedassets0.assets').objects[pid].get_raw_data()).hexdigest()
        assert actual_hash == original['rawSha256'], 'fictional-resource-changed'
        fictional.append(dict(id=identity, rawSha256=actual_hash, type=original['type']))
    pins[str(objects_path.relative_to(ROOT))] = sha(objects_path)

    projections, requirements = [], []
    for name, profile in profiles.items():
        bound, unresolved, absent, chars = [], [], [], set()
        for selector in profile['selectors']:
            identity = selector['sourceId']
            if identity in targets:
                target = targets[identity]
                assert selector['sourceValueSha256'] == value_hash(target['source']), ('profile-source-value', identity)
                bound.append(identity)
                chars.update(ord(c) for c in target['target'] if not unicodedata.category(c).startswith('C'))
                projections.append(dict(profile=name, sourceId=identity, sourceValueSha256=selector['sourceValueSha256'],
                                        targetSha256=hashlib.sha256(target['target'].encode()).hexdigest(), target=target['target']))
            elif selector['valueState'] == 'absent':
                absent.append(identity)
            else:
                unresolved.append(dict(sourceId=identity, kind=selector['selectorKind'], valueState=selector['valueState']))
        requirements.append(dict(profile=name, componentIds=profile['componentIds'], exactBoundTargetIds=bound,
                                 knownBoundTargetCount=len(bound), requiredCodepoints=sorted(chars),
                                 actualEmbeddedFaceMissing=sorted(chars - available), absentSourceStates=absent,
                                 unresolvedSelectors=unresolved, finalRoleCorpusAccepted=False,
                                 boundary='Accepted935+52 exact selectors only. Stored seeds, arbitrary names, dynamic allocation and full dialogue main/mouse split are not invented or accepted. No empty projection passes.'))
    inv_title = next(r for r in requirements if r['profile'] == 'inventory-itemTitleText')
    inv_body = next(r for r in requirements if r['profile'] == 'inventory-tickerText')
    assert inv_title['knownBoundTargetCount'] == inv_body['knownBoundTargetCount'] == 50, 'complete-inventory50-role-projection'
    assert all(not r['actualEmbeddedFaceMissing'] for r in requirements if r['knownBoundTargetCount']), 'accepted-role-missing-character'

    negative_controls = []
    for name, altered, expected in [('missing109th', copy.deepcopy(components[:-1]), 'component-count-or-duplicate'),
                                    ('wrong-native-font', copy.deepcopy(components), 'font-pointer-mismatch'),
                                    ('changed-material', copy.deepcopy(components), 'material-pointer-mismatch')]:
        if name == 'wrong-native-font':
            next(r for r in altered if r['componentId'] == 'sharedassets0.assets:3695')['actualFontPointer'] = dict(m_FileID=0, m_PathID=367)
        if name == 'changed-material':
            altered[0]['actualMaterialPointer'] = dict(m_FileID=0, m_PathID=-9223372036854775807)
        observed = None
        try:
            check_rows(altered, [row['component']['id'] for row in baseline['selectedComponents']])
        except AssertionError as error:
            observed = str(error)
        assert observed == expected, (name, observed)
        negative_controls.append(dict(id=name, expectedReason=expected, observedReason=observed, passed=True))
    for name, digest in pins.items():
        assert sha(ROOT / name) == digest, ('input-changed-during-readback', name)
    output.mkdir()
    products = dict(components=components, requirements=requirements, resources=resources, fictionalPreserved=fictional,
                    face=face, validation=dict(positive='All109 current saved font/material pointers match actual expected bindings', negatives=negative_controls),
                    inputPins=pins, candidate=str(candidate), candidateBuildSha256=sha(build_path),
                    status='current-russian-packaged-role-bindings-and-accepted-subset-characters-verified',
                    finalRoleCorpusAccepted=False, runtimeAccepted=False, wholeGameAccepted=False)
    (output / 'readback.json').write_text(json.dumps(products, ensure_ascii=False, indent=2) + '\n')
    (output / 'target-projections.jsonl').write_text(''.join(json.dumps(r, ensure_ascii=False) + '\n' for r in projections))
    shutil_source = Path(__file__)
    (output / 'verify_russian_font_roles.py.snapshot').write_bytes(shutil_source.read_bytes())
    print(json.dumps(dict(status=products['status'], components=len(components), profiles=len(requirements),
                          acceptedTargetRoleJoins=len(projections), inventoryPerRole=50,
                          remainingUnresolvedByProfile={r['profile']: len(r['unresolvedSelectors']) for r in requirements})))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--candidate', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    verify(args.candidate, args.output)
