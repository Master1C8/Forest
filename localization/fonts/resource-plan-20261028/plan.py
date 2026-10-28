#!/usr/bin/env python3
"""Derive/check the finite phase148 metadata plan. Never builds game resources."""
import argparse
import copy
import hashlib
import json
import struct
from collections import Counter
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
PRIOR = 'localization/fonts/role-requirements-20261028/'
BUNDLE = 'StreamingAssets/aa/StandaloneWindows64/defaultlocalgroup_assets_all_298c5a4d1d1846b1a8d2c7d5da3f319c.bundle!/CAB-7cd732d37ea0297d073a22a52ce72d28'
FAMILIES = {'sharedassets0.assets:3323': 'shared-tmp', BUNDLE + ':-1127281652424575413': 'bundled-tmp',
            'sharedassets0.assets:369': 'native369', 'sharedassets0.assets:367': 'native367'}


def encode(x):
    return (json.dumps(x, ensure_ascii=False, indent=2) + '\n').encode()


def sha(data):
    return hashlib.sha256(data).hexdigest()


def read(path):
    return json.loads((ROOT / path).read_bytes())


def require(ok, reason):
    if not ok:
        raise ValueError(reason)


def derive():
    prior = read(PRIOR + 'reconciliation.json')
    validation = read(PRIOR + 'validation.json')
    require(sha((ROOT / (PRIOR + 'reconciliation.json')).read_bytes()) == validation['outputs']['reconciliation.json'], 'prior147-output-hash')
    require(sha((ROOT / (PRIOR + 'reconcile.py')).read_bytes()) == validation['recipeSha256'], 'prior147-recipe-hash')
    objects_list = read('assets/source-v2/objects.json')
    objects = {r['id']: r for r in objects_list}
    require(len(objects) == len(objects_list), 'original-index-duplicate')
    required = set(prior['originalResources']) | set(prior['fictionalResources'])
    required |= {'resources.assets:' + str(i) for i in [9, 10, 11, 66, 74, 75, 316, 439, 1017, 1018, 1020]}
    required |= {'sharedassets0.assets:' + str(i) for i in [4, 5, 6, 135, 214, 243, 367, 368, 369]}
    required |= {BUNDLE + ':' + str(i) for i in [2133516458142313129, 525290011395715274]}
    required |= {r['component']['id'] for r in prior['selectedComponents']}
    resources, pins = {}, {}

    def pin(path):
        data = (ROOT / path).read_bytes()
        pins[path] = {'sha256': sha(data), 'bytes': len(data)}

    for path in ['assets/source-v2/objects.json', 'assets/source-v2/source-files.json', 'assets/source-v2/fonts.json',
                 'assets/source-v2/textures.json', 'assets/source-v2/font-export-validation.json',
                 PRIOR + 'reconciliation.json', PRIOR + 'validation.json', PRIOR + 'input-pins.json', PRIOR + 'acceptance-checklist.json',
                 'localization/fonts/no-texture-feasibility-20261028.md', 'localization/fonts/no-texture-guard-20261028.json',
                 'tools/build_renderer_probe.py', 'tools/build_russian_preview.py', 'tools/tmp_dialogue_font.py',
                 'tools/legacy_choice_font.py', 'tools/texture_policy.py',
                 'localization/font-checks/dialogue-20261027-02.json', 'localization/font-checks/cjk-candidates-20261027-01.json',
                 'localization/font-checks/supplemental-30-20261028.json', 'localization/fonts/noto-cjk/provenance.json',
                 'localization/fonts/noto-cjk/LICENSE', 'localization/fonts/noto-cjk/UPSTREAM-README.md']:
        pin(path)
    for name in ['bio-tmp-text-element', 'bio-tmp-font-character-internal', 'bio-tmp-add-character', 'bio-tmp-atlas-setup']:
        for file in ['ADAPTER.md', 'source-trace.json']:
            pin('localization/source/bgdatabase-20261027/' + name + '/' + file)
    textures = {r['id']: r for r in read('assets/source-v2/textures.json')}
    trees = {}
    for identity in sorted(required):
        row = objects[identity]
        fact = {'identity': row, 'boundary': 'original export metadata; no installed asset or image opened'}
        if row.get('tree') and row['type'] != 'Texture2D':
            path = 'assets/source-v2/' + row['tree']
            pin(path)
            require(pins[path]['sha256'] == row['treeSha256'], 'original-tree-hash:' + identity)
            tree = read(path)
            trees[identity] = tree
            if row['type'] == 'Font':
                fact['serialized'] = {k: v for k, v in tree.items() if k not in ['m_FontData', 'm_CharacterRects', 'm_KerningValues']}
                data = bytes(tree['m_FontData'])
                fact['embeddedFontBytes'] = len(data)
                fact['embeddedFontSha256'] = sha(data) if data else None
                fact['serializedCharacterRects'] = len(tree['m_CharacterRects'])
                fact['serializedKerningValues'] = len(tree['m_KerningValues'])
            elif identity.startswith('resources.assets:'):
                fact['serialized'] = tree
        if identity in textures:
            fact['textureMetadata'] = textures[identity]
        resources[identity] = fact
    candidates = {}
    for row in prior['candidateDecisions']:
        identity = row['trialCandidate']
        if identity in candidates:
            continue
        path = 'assets/source-v2/fonts/90744c19ec-resources.assets-439.font' if identity == 'resources.assets:439' else identity
        pin(path)
        require(pins[path]['sha256'] == row['candidateSha256'], 'candidate-byte-hash')
        signature = (ROOT / path).read_bytes()[:4].hex()
        require(signature == ('00010000' if identity == 'resources.assets:439' else '4f54544f'), 'candidate-container-signature')
        candidates[identity] = {'path': path, 'sha256': row['candidateSha256'], 'face': row['candidateFace'],
            'signatureHex': signature, 'format': 'TrueType sfnt' if identity == 'resources.assets:439' else 'OpenType OTTO; CJK CFF candidate',
            'licenseBoundary': row['candidateLicense'], 'candidateApproval': 'bounded-trial-only;not-final'}
    require(resources['resources.assets:439']['embeddedFontSha256'] == candidates['resources.assets:439']['sha256'], '439-payload-export-equality')
    fallback = trees['resources.assets:1017']
    require(fallback['m_SourceFontFile'] == {'m_FileID': 0, 'm_PathID': 439}, 'fallback-source-font')
    require(fallback['m_AtlasPopulationMode'] == 1 and not fallback['m_GlyphTable'] and not fallback['m_CharacterTable'], 'dynamic-empty-original')
    bindings = []
    for row in prior['selectedComponents']:
        bindings.append({'component': row['component'], 'profile': row['requirementProfile'], 'kind': row['kind'],
            'family': FAMILIES[row['resolvedResources']['font']], 'stored': row['resolvedResources'],
            'fontPPtr': row['fontReference'], 'materialPPtr': row['materialReference'],
            'serializedSettings': row['serializedSettings'], 'source': row['storedSource']})
    decisions = []
    for row in prior['candidateDecisions']:
        family = FAMILIES[row['storedResource']]
        compatible = row['trialCandidate'] == 'resources.assets:439'
        decisions.append({**row, 'family': family,
            'componentIds': [b['component']['id'] for b in bindings if b['profile'] == row['profile'] and b['stored']['font'] == row['storedResource']],
            'bindingPlan': 'PLAN.md#' + family, 'changePlan': 'liberation-' + family if compatible else 'cjk-incompatible-existing-builder',
            'currentRecipeApplicability': ('existing-fallback-only;whole-face-not-selected' if 'tmp' in family else
                'coherent-legacy-field-copy' if family == 'native369' else 'selected-three-label-rebind-not-implemented') if compatible else
                'incompatible:builder-hardcodes439-and-does-not-import-candidate;no-coherent-tmp-face',
            'application': 'not-run', 'packagedReadback': 'not-run', 'runtime': 'not-run', 'visual': 'not-run',
            'finalRoleCorpus': 'needs-review;phase147-requirements-are-versioned-projections',
            'nextPermittedAction': 'Immutable final-corpus/role reconciliation only in current static scope; future native trial requires owner runtime instruction.'})
    scale = struct.unpack('<f', struct.pack('<f', (77 / 176) / (59 / 86)))[0]
    plan = {'schemaVersion': 1, 'phase': '0148-work', 'status': 'passed-static-plan-only',
        'selectedBindings': bindings, 'candidateDecisions': decisions, 'candidates': candidates, 'resources': resources,
        'normalRecipe': {'settings': {'resource': 'resources.assets:1020', 'field': '/m_fallbackFontAssets', 'before': [], 'after': [{'m_FileID': 0, 'm_PathID': 1017}], 'condition': 'always in both normal builders'},
            'dynamicScale': {'resource': 'resources.assets:1017', 'field': '/m_FaceInfo/m_Scale', 'before': 1.0, 'after': scale, 'condition': '--repair-cyrillic-metrics'},
            'sourceFontUnchanged': {'m_FileID': 0, 'm_PathID': 439}, 'sourceFontBytesUnchanged': True,
            'glyphAndCharacterCachesUnchanged': True, 'materialAndAtlasLinksUnchanged': True,
            'globalScope': 'all TMP users of these Settings, not limited to109 selections; default1018 already has local fallback1017',
            'defaultFont': 'resources.assets:1018', 'defaultFontLocalFallback': trees['resources.assets:1018']['m_FallbackFontAssetTable'],
            'legacyDefaultCopies': ['sharedassets0.assets:368', BUNDLE + ':2133516458142313129'],
            'legacyDefaultFields': ['m_FontData', 'm_FontNames', 'm_LineSpacing', 'm_FontSize', 'm_Ascent', 'm_Descent', 'm_KerningValues', 'm_FontRenderingMode'],
            'legacyCoherentCopies': ['sharedassets0.assets:369', BUNDLE + ':525290011395715274'],
            'legacyCoherentPreservedFields': ['m_Name', 'm_DefaultMaterial', 'm_Texture', 'm_FallbackFonts'],
            'legacyCoherentCopiedFields': sorted(set(trees['sharedassets0.assets:369']) - {'m_Name', 'm_DefaultMaterial', 'm_Texture', 'm_FallbackFonts'}),
            'choiceHelperScope': 'StandardUIResponseButton.label.m_uiText only; cannot select the3 inventory/plugin Font367 consumers',
            'coherentTmpFace': 'rejected-by-existing-guard;do-not-run',
            'cyrillicMarkHelper': 'glyf composites for exactly ЁёЙй; incompatible with CJK OTTO source as a general recipe'},
        'fictionalPreservation': copy.deepcopy(prior['fictionalPreservation']), 'fictionalResources': copy.deepcopy(prior['fictionalResources']),
        'textureCheck': {'status': 'not-run', 'objectUniverse': 'every original Texture2D keyed by(sourceFile,internalAsset,pathId), complete objects.json; compare raw object bytes including metadata',
            'streamUniverse': 'every original external texture-stream file and every original bundle-contained resource stream; exact bytes/hash/path set, not only selected atlas spans',
            'addedTexturePolicy': 'no serialized atlas/Texture2D additions in this plan; runtime allocations recorded separately',
            'runtimeCaches': '1017/74 resize/reset/glyph packing is in-memory behavior and native-unverified; do not serialize generated caches into originals',
            'positiveControl': 'same package and exact role/corpus, intended embedded face hash and resolved font/material/glyph source observed, required character appears; full original textures/streams equal',
            'negativeControls': ['one original Texture2D raw metadata byte differs', 'one external texture-stream byte differs', 'wrong candidate/source-Font PPtr', 'wrong shared/bundled material', 'missing selected native367 rebind'],
            'boundary': 'future actual packaged readback and native control, not a completed comparison or synthetic renderer proof'},
        'gates': {'source': 'needs-review', 'editorial': 'needs-review', 'fonts': 'needs-review', 'resources': 'not-run', 'runtime': 'not-run', 'visual': 'not-run', 'delivery': 'needs-review'},
        'limits': ['109 selected original identities,not all live components', '84 exact profile-resource-locale decisions,not final fonts',
            'CJK import/face metrics/native loading unsupported by current builder', 'Latin fallback retains primary glyphs,not whole-face parity',
            'native shaping/bidi/marks/baselines/narrow-layout/input/fallback unverified', 'no resource,font,texture,target,game,image,Git or operational-job mutations']}
    return plan, pins


def validate(plan, baseline):
    bindings = plan['selectedBindings']
    require(len(bindings) == 109 and len({b['component']['id'] for b in bindings}) == 109, 'selected109-coverage')
    require(bindings == baseline['selectedBindings'], 'stored-selection-change')
    require(Counter(b['family'] for b in bindings) == {'bundled-tmp': 75, 'shared-tmp': 19, 'native369': 12, 'native367': 3}, 'resource-family-counts')
    rows = plan['candidateDecisions']
    key = lambda r: (r['profile'], r['storedResource'], r['locale'])
    require(len(rows) == 84 and {key(r) for r in rows} == {key(r) for r in baseline['candidateDecisions']}, 'candidate84-coverage')
    for row in rows:
        expected = next(r for r in baseline['candidateDecisions'] if key(r) == key(row))
        require(row['trialCandidate'] == expected['trialCandidate'] and row['candidateSha256'] == expected['candidateSha256'], 'locale-candidate-identity')
        require(row == expected, 'candidate-applicability-or-scope')
    require(plan['normalRecipe']['sourceFontUnchanged'] == {'m_FileID': 0, 'm_PathID': 439}, 'fallback-source-439')
    require(plan['normalRecipe']['coherentTmpFace'] == 'rejected-by-existing-guard;do-not-run', 'atlas-rewrite-forbidden')
    require(plan['normalRecipe'] == baseline['normalRecipe'], 'recipe-claim-change')
    require(plan['fictionalPreservation'] == baseline['fictionalPreservation'] and plan['fictionalResources'] == baseline['fictionalResources'], 'fictional-mapping-change')
    require(plan['textureCheck']['status'] == 'not-run' and plan['gates'] == baseline['gates'], 'unrun-gate-promoted')
    require(plan['resources'] == baseline['resources'] and plan['candidates'] == baseline['candidates'], 'original-or-candidate-facts')
    require(plan == baseline, 'plan-content-change')


def controls(plan):
    validate(plan, plan)
    events = []
    def negative(name, mutate, reason):
        changed = copy.deepcopy(plan)
        mutate(changed)
        try:
            validate(changed, plan)
        except ValueError as exc:
            require(str(exc) == reason, 'wrong-rejection:' + name + ':' + str(exc))
            events.append({'id': name, 'reason': str(exc), 'result': 'rejected'})
        else:
            raise ValueError('accepted-negative:' + name)
    negative('omit109th', lambda p: p['selectedBindings'].pop(), 'selected109-coverage')
    negative('duplicate84th', lambda p: p['candidateDecisions'].__setitem__(-1, copy.deepcopy(p['candidateDecisions'][0])), 'candidate84-coverage')
    negative('wrong-source-439', lambda p: p['normalRecipe']['sourceFontUnchanged'].__setitem__('m_PathID', 369), 'fallback-source-439')
    negative('allow-atlas-rewrite', lambda p: p['normalRecipe'].__setitem__('coherentTmpFace', 'allowed'), 'atlas-rewrite-forbidden')
    j = next(i for i, r in enumerate(plan['candidateDecisions']) if r['locale'] == 'ja')
    negative('JP-replaced-with-SC', lambda p: p['candidateDecisions'][j].__setitem__('trialCandidate', 'localization/fonts/noto-cjk/NotoSansCJKsc-Regular.otf'), 'locale-candidate-identity')
    negative('claim-CJK-supported', lambda p: p['candidateDecisions'][j].__setitem__('currentRecipeApplicability', 'supported'), 'candidate-applicability-or-scope')
    negative('shared-material-for-bundle', lambda p: p['selectedBindings'][0]['stored'].__setitem__('material', 'sharedassets0.assets:7'), 'stored-selection-change')
    negative('mouse-mapping-edited', lambda p: p['fictionalResources'].clear(), 'fictional-mapping-change')
    negative('claim-textures-pass', lambda p: p['textureCheck'].__setitem__('status', 'passed'), 'unrun-gate-promoted')
    return {'negative': events, 'positive': ['all109-real-bindings', 'all84-exact-profile-resource-locale-decisions', 'matched-SC-and-JP-candidates',
        '439-export-equals-serialized-payload', '1017-dynamic-empty-caches-source439', '367-three-vs369-twelve', 'fictional-original-preserved'],
        'boundary': 'Metadata-plan and exact-input controls only; does not execute builders,font parsers,native renderer or future texture comparisons.'}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    plan, pins = derive()
    if args.check:
        require(read(str(HERE.relative_to(ROOT) / 'input-pins.json')) == pins, 'input-pin-set-or-content')
        validate(read(str(HERE.relative_to(ROOT) / 'resource-plan.json')), plan)
    validation = controls(plan)
    outputs = {'resource-plan.json': encode(plan), 'input-pins.json': encode(pins)}
    validation.update({'phase': '0148-work', 'status': 'passed-static-plan-only', 'inputPins': len(pins), 'selectedComponents': 109,
        'candidateDecisions': 84, 'requirementProfiles': 10, 'families': 4, 'resourceFacts': len(plan['resources']),
        'recipeSha256': sha(Path(__file__).read_bytes()), 'outputs': {k: sha(v) for k,v in outputs.items()},
        'resourceBuilds': 0, 'fontParsersRun': 0, 'resourceEdits': 0, 'textureEdits': 0, 'imagesOpened': 0, 'newIL': 0,
        'runtime': 'not-run', 'usage': 'unknown;parent measures actual request telemetry'})
    outputs['validation.json'] = encode(validation)
    for name, data in outputs.items():
        path = HERE / name
        if args.check:
            require(path.read_bytes() == data, 'output-reproduction:' + name)
        else:
            require(not path.exists(), 'refuse-overwrite:' + name)
            path.write_bytes(data)
    print(json.dumps({k:v for k,v in validation.items() if k not in ['outputs','negative','positive']}, indent=2))


if __name__ == '__main__':
    main()
