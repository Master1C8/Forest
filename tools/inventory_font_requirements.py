"""Bind the accepted Russian inventory increment to two concrete native roles.

Conservative dynamic families, not exact live allocation or shaping acceptance.
Historical role/corpus reports and all other locales remain unchanged.
"""
import argparse
import hashlib
import json
from pathlib import Path
import unicodedata
import UnityPy
from font_corpus_preflight import inspect_font

ROOT = Path('/Users/antonkrutov/Desktop/Forest')


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def derive(candidate):
    candidate = candidate.resolve()
    assert candidate.parent == ROOT / 'localization/previews'
    packet = ROOT / 'localization/supplemental-ui/20261028-inventory'
    acceptance = json.loads((packet / 'ru.acceptance.json').read_text())
    target = packet / acceptance['targetFile']
    assert sha(target) == acceptance['targetSha256'] and acceptance['status'] == 'bounded-russian-editorial-accepted'
    new = [json.loads(line) for line in target.read_text().splitlines()]
    profile_path = ROOT / 'localization/fonts/final-corpus-bindings-20261028/profile-sources.json'
    profiles = json.loads(profile_path.read_text())
    old_path = ROOT / 'localization/supplemental-ui/20261027/ru.jsonl'
    old = [json.loads(line) for line in old_path.read_text().splitlines()]
    old_manifest = ROOT / 'localization/supplemental-ui/20261027/manifest.json'
    assert sha(old_path) == json.loads(old_manifest.read_text())['locales']['ru']['sha256']
    build_path = candidate / 'build.json'; build = json.loads(build_path.read_text())
    assert build['coherentLegacyFace'] and build['inventoryDisplayCompletion']
    asset = candidate / 'game/The Forest of Love_Data/sharedassets0.assets'
    assert sha(asset) == next(r['probeSha256'] for r in build['files'] if r['path'] == 'sharedassets0.assets')
    env = UnityPy.load(str(asset))
    face = next(o for o in env.objects if o.path_id == 369).read_typetree()
    available, metrics = inspect_font(face); assert available is not None
    index_path = ROOT / 'assets/source-v2/fonts.json'
    source_face = next(r for r in json.loads(index_path.read_text()) if r['id'] == 'resources.assets:439')
    face_path = ROOT / 'assets/source-v2' / source_face['tree']
    assert sha(face_path) == source_face['treeSha256']
    original_face = json.loads(face_path.read_text())
    assert bytes(face['m_FontData']) == bytes(original_face['m_FontData']), 'Actual role face differs from bundled Liberation Sans'
    result = []
    for role, offset_role in [('inventory-itemTitleText', 'title'), ('inventory-tickerText', 'description')]:
        prior_ids = set(profiles[role]['boundTargetIds'])
        prior = [r for r in old if r['id'] in prior_ids]
        assert {r['id'] for r in prior} == prior_ids
        additional = [r for r in new if (r['family'] == 'inventory-description' and offset_role == 'description') or
                      (r['family'] == 'inventory-empty-cell' and r['role'] == offset_role)]
        assert {r['id'] for r in additional} == set(profiles[role]['nonemptyDynamicSourceOmissions'])
        units = prior + additional
        assert len(units) == len({r['id'] for r in units}) == 50
        forms = {}
        for form in ['raw', 'NFC', 'NFD']:
            strings = [r['target'] if form == 'raw' else unicodedata.normalize(form, r['target']) for r in units]
            required = {ord(c) for value in strings for c in value if not unicodedata.category(c).startswith('C')}
            forms[form] = dict(required=[f'U+{cp:04X}' for cp in sorted(required)],
                               missing=[f'U+{cp:04X}' for cp in sorted(required - available)],
                               cmapCovered=not bool(required - available))
        result.append(dict(role=role, componentIds=profiles[role]['componentIds'],
                           consumerPredicate=profiles[role]['consumerPredicate'],
                           priorInputs=len(prior), newlyBoundInputs=len(additional), inputCount=50,
                           targetBindings=[dict(id=r['id'], sourceSha256=hashlib.sha256(r['source'].encode()).hexdigest(),
                                                targetSha256=hashlib.sha256(r['target'].encode()).hexdigest()) for r in units],
                           sourceDynamicOmissionsResolved=True, normalization=forms,
                           actualNativeFace='sharedassets0.assets:369', embeddedFace=metrics,
                           nativeShapingAccepted=False,
                           boundary='Complete conservative dynamic family. Stored placeholders, exact live component selection,400 glitch bypass and405 in-story branch remain separate. Cmap is not native mark/layout acceptance.'))
    inputs = [target, packet / 'ru.acceptance.json', profile_path, old_path, old_manifest,
              build_path, asset, index_path, face_path, Path(__file__)]
    return dict(schemaVersion=1, locale='ru', profiles=result, inputPins={str(p): sha(p) for p in inputs},
                wholeGameFontAccepted=False, otherLocalesChanged=False, texturesChanged=False)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--candidate', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert ROOT in args.output.resolve().parents and not args.output.exists()
    result = derive(args.candidate)
    args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps([dict(role=r['role'], inputs=r['inputCount'], newlyBound=r['newlyBoundInputs'],
                           missing={form: data['missing'] for form, data in r['normalization'].items()}) for r in result['profiles']]))
