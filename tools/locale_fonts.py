"""Apply pinned accepted-baseline font mechanisms to an explicit saved locale.

No wording generation, normalization, texture edits, installation or model calls.
Only declared font fields, native pointers and metric compensation may change.
"""
import copy
import hashlib
import io
import json
from pathlib import Path
import shutil

from locale_queue import local, read, sha
from locale_resource_publish import publish

KIND = 'locale-font-transform'
NATIVE_KEEP = {'m_Name', 'm_DefaultMaterial', 'm_Texture', 'm_FallbackFonts'}
TMP_FIELDS = {'m_FaceInfo', 'm_CharacterTable', 'm_GlyphTable', 'm_glyphInfoList',
              'm_fontInfo', 'm_FontFeatureTable', 'm_KerningTable'}
FALLBACK_FIELDS = {'m_FaceInfo', 'm_IsMultiAtlasTexturesEnabled'}


def need(value, reason):
    if not value:
        raise ValueError(reason)


def encoded(value):
    return (json.dumps(value, ensure_ascii=False, sort_keys=True, indent=2) + '\n').encode()


def rawsha(obj):
    return hashlib.sha256(obj.get_raw_data()).hexdigest()


def transform(tree, operation, reference=None, spacing=None):
    """Pure, field-bounded edit; compare whole expected trees after readback."""
    result = copy.deepcopy(tree)
    kind = operation['kind']
    if kind in {'native-face', 'tmp-primary', 'dynamic-fallback', 'global-fallback'}:
        need(tree['m_Name'] == reference['m_Name'], 'font-reference-identity')
        if kind == 'native-face':
            fields = set(tree) - NATIVE_KEEP
        elif kind == 'tmp-primary':
            fields = TMP_FIELDS
            need(tree['material'] == reference['material'] and
                 tree['m_AtlasTextures'] == reference['m_AtlasTextures'], 'font-primary-material-atlas')
        elif kind == 'dynamic-fallback':
            fields = FALLBACK_FIELDS
            need(tree['m_SourceFontFile'] == reference['m_SourceFontFile'] ==
                 {'m_FileID': 0, 'm_PathID': 439}, 'font-dynamic-source')
        else:
            fields = {'m_fallbackFontAssets'}
        for key in fields:
            result[key] = copy.deepcopy(reference[key])
    elif kind == 'native-pointer':
        before, after = operation['before'], operation['after']
        need(before['m_FileID'] == after['m_FileID'] and before['m_PathID'] == 367
             and after['m_PathID'] == 369, 'font-native-file-id')
        need(tree['m_FontData']['m_Font'] == before, 'font-native-before')
        need(tree['m_Material'] == {'m_FileID': 0, 'm_PathID': 0}, 'font-native-material')
        result['m_FontData']['m_Font'] = copy.deepcopy(after)
    elif kind == 'metric-spacing':
        need(tree['m_fontAsset'] == operation['font'], 'font-spacing-role')
        result['m_lineSpacing'] = max(0., spacing(operation['oldFace'], operation['newFace'], tree['m_lineSpacing']))
    else:
        raise ValueError('font-operation-kind')
    # Rendered wording, owner identity and component material are never copied.
    for key in ['m_Text', 'm_text', 'm_Script', 'm_GameObject', 'm_Material', 'm_sharedMaterial']:
        if key in tree:
            need(result[key] == tree[key], 'font-protected-field:' + key)
    return result


def run(profile_path, locale, output, mode='build', root=None, fail_after=None):
    from locale_build import ROOT, pinned, LOCALES
    root = Path(root or ROOT).resolve(); output = output.resolve(); profile_path = profile_path.resolve()
    need(profile_path.is_relative_to(root), 'font-profile-outside-project')
    profile = read(profile_path)
    need(profile.get('schemaVersion') == 1 and profile.get('kind') == KIND, 'font-profile-schema')
    need(locale in LOCALES and profile.get('locale') == locale, 'font-explicit-locale')
    allowed = local(root, 'outputs/locale-assets-20261026/' + locale)
    need(output.is_relative_to(allowed) and output != allowed, 'font-output-outside-own-locale')
    need(mode in {'build', 'resume', 'check'}, 'font-mode')
    need(mode != 'build' or not output.exists() or not any(output.iterdir()), 'font-existing-output')
    for pin in profile['pins']:
        pinned(root, pin)
    acceptance = read(pinned(root, profile['baselineAcceptance']))
    need(acceptance.get('authority') == 'owner' and acceptance.get('accepted') is True and
         acceptance.get('sharedMechanismReuseAllowed') is True, 'font-owner-baseline')
    for key in ['artifact', 'sourceManifest']:
        pinned(root, acceptance[key])
    source = pinned(root, profile['inputManifest']); manifest = read(source)
    need(manifest.get('locale') == locale and manifest.get('kind') == 'locale-owned-static-resource-candidate', 'font-input-candidate')
    # Verify every file before loading an engine or producing an output.
    for name, binding in manifest['outputs'].items():
        path = local(source.parent, name)
        need(sha(path) == binding['sha256'] and path.stat().st_size == binding['bytes'], 'font-input-bytes:' + name)
    need(shutil.disk_usage(root).free - sum(r['bytes'] for r in manifest['outputs'].values()) >= 5*1024**3,
         'font-five-GiB-reserve')
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    from extract_assets import read_tree
    from russian_preview_ui import metric_spacing
    from addressables_catalog import update_catalog
    from fontTools.ttLib import TTFont
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(local(root, profile['managedDirectory'])))
    environments = {}

    def asset(path, member=''):
        key = (str(path), member)
        if key not in environments:
            env = UnityPy.load(str(path)); env.path = str(local(root, profile['dependencyDirectory']))
            outer = next(iter(env.files.values()))
            environments[key] = (env, outer, outer.files[member] if member else outer)
        return environments[key]

    operations = profile['operations']
    identities = [(o['asset'], o['member'], o['id']) for o in operations]
    need(identities and len(identities) == len(set(identities)), 'font-operation-identities')
    grouped = {}
    for operation in operations:
        grouped.setdefault((operation['asset'], operation['member']), []).append(operation)
    files = {name: local(source.parent, name).read_bytes() for name in manifest['outputs']}
    changes, preserved, textures = [], 0, 0
    for (name, member), assigned in grouped.items():
        need(name in manifest['outputs'], 'font-foreign-input-asset')
        env, outer, serialized = asset(local(source.parent, name), member)
        before = {i: rawsha(o) for i, o in serialized.objects.items()}
        expected = {}
        for operation in assigned:
            obj = serialized.objects[operation['id']]
            need(rawsha(obj) == operation['sourceRawSha256'], 'font-object-before:' + str(operation['id']))
            tree = read_tree(obj, generator)
            need(obj.type.name == operation['type'], 'font-object-type')
            if obj.type.name == 'MonoBehaviour':
                script = obj.parse_monobehaviour_head().m_Script.deref().read()
                need(script.m_ClassName == operation['class'], 'font-object-class')
            reference = None
            if 'reference' in operation:
                ref = operation['reference']; reference_file = pinned(root, ref['file'])
                _, _, ref_asset = asset(reference_file, ref['member'])
                ref_obj = ref_asset.objects[ref['id']]
                need(rawsha(ref_obj) == ref['rawSha256'], 'font-reference-object')
                reference = read_tree(ref_obj, generator)
            planned = dict(operation, **profile['metricFaces']) if operation['kind'] == 'metric-spacing' else operation
            result = transform(tree, planned, reference, metric_spacing)
            need(result != tree, 'font-empty-operation')
            if obj.type.name == 'MonoBehaviour':
                nodes = generator.cache.get(('forest-header-aligned:' + script.m_AssemblyName,
                    (script.m_Namespace + '.' if script.m_Namespace else '') + script.m_ClassName))
            else:
                nodes = None
            obj.save_typetree(result, nodes=nodes)
            expected[obj.path_id] = result
            changes.append(dict(asset=name, member=member, id=obj.path_id, kind=operation['kind'],
                                beforeRawSha256=before[obj.path_id], afterRawSha256=rawsha(obj)))
        # Original bundle packer/CAB and every other member must survive.
        old_flags = int(outer.dataflags) if member else None
        member_before = {n: hashlib.sha256(f.reader.bytes if hasattr(f, 'reader') else f.bytes).hexdigest()
                         for n, f in outer.files.items() if n != member} if member else {}
        data = outer.save(packer='original') if member else outer.save()
        reopened = UnityPy.load(data); reopened.path = env.path
        new_outer = next(iter(reopened.files.values()))
        actual = new_outer.files[member] if member else new_outer
        need(set(actual.objects) == set(before), 'font-object-inventory')
        if member:
            need(int(new_outer.dataflags) == old_flags and set(new_outer.files) == set(outer.files), 'font-bundle-identity-compression')
            for n, h in member_before.items():
                f = new_outer.files[n]
                need(hashlib.sha256(f.reader.bytes if hasattr(f, 'reader') else f.bytes).hexdigest() == h, 'font-other-bundle-member')
        for i, obj in actual.objects.items():
            if obj.type.name == 'Texture2D': textures += 1
            if i in expected:
                need(read_tree(obj, generator) == expected[i], 'font-selected-tree-readback:' + str(i))
            else:
                need(rawsha(obj) == before[i], 'font-unselected-raw-bytes:' + str(i))
                preserved += 1
        files[name] = data
    # Check pinned companion bytes; streams are never rewritten or republished.
    companions = local(root, profile['companionDirectory'])
    for name, row in manifest['sourceCompanions'].items():
        need(sha(local(companions, name)) == row['sha256'], 'font-source-companion:' + name)
    bundle = profile['bundle']
    # Catalog helper operates on saved files. A task-local temporary directory is
    # removed even on failure; only verified final files reach the publisher.
    import tempfile
    with tempfile.TemporaryDirectory(prefix='font-catalog-', dir=root/'outputs') as temporary:
        temp = Path(temporary); rebuilt = temp/'bundle'; rebuilt.write_bytes(files[bundle])
        catalog = temp/'catalog.json'
        catalog_check = update_catalog(local(source.parent, 'StreamingAssets/aa/catalog.json'), catalog,
                                       local(source.parent, bundle), rebuilt)
        files['StreamingAssets/aa/catalog.json'] = catalog.read_bytes()
    _, _, font_assets = asset(local(root, profile['embeddedFace']['asset']))
    embedded = read_tree(font_assets.objects[profile['embeddedFace']['id']], generator)
    face = TTFont(io.BytesIO(bytes(embedded['m_FontData'])))
    cmap = face.getBestCmap()
    missing = [n for n in profile['requiredCodepoints'] if n not in cmap]
    need(not missing and face['hmtx'][cmap[32]][0] > 0, 'font-selected-face-character-supply')
    evidence = dict(schemaVersion=1, locale=locale, passed=True, changedObjects=len(changes), changes=changes,
        selectedTreeReadback=True, allUnselectedRawBytesExact=True, unselectedObjects=preserved,
        textureObjectsExact=textures, sourceCompanionsExact=len(manifest['sourceCompanions']),
        originalBundleCompressionAndMembersExact=True, catalog=catalog_check,
        requiredCodepoints=profile['requiredCodepoints'], missingCodepoints=missing,
        embeddedFaceSha256=hashlib.sha256(bytes(embedded['m_FontData'])).hexdigest(),
        dynamicFallback=dict(sourceFont=439, fontAsset=1017, policy='Accepted ordinary TMP global dynamic fallback; primary underscore retained',
                             serializedAtlasTextures='unchanged', nativeLoading='not-run', markPlacement='not-run'),
        authoredTextChanged=False, semanticCoverageAdded=0, native='not-run', runtime='not-run', ready=False)
    files['evidence/font-transform.json'] = encoded(evidence)
    outputs = {n: dict(sha256=hashlib.sha256(data).hexdigest(), bytes=len(data)) for n, data in files.items()}
    marker = dict(schemaVersion=1, kind='locale-owned-font-resource-candidate', locale=locale,
        profile=dict(path=str(profile_path.relative_to(root)), sha256=sha(profile_path)), input=profile['inputManifest'],
        baselineAcceptance=profile['baselineAcceptance'], outputs=outputs, sourceCompanions=manifest['sourceCompanions'],
        ready=False, applicationAllowed=False, semanticCoverageAdded=0, native='not-run', runtime='not-run',
        independentIntegrationReview='pending', remaining=manifest['remaining'],
        publicationBoundary='Sequential files; manifest last. Resume checks every existing partial byte; not an installation transaction.')

    def verify(out, expected_marker, content):
        need(read(out/'manifest.json') == expected_marker, 'font-published-manifest')
        need({str(p.relative_to(out)) for p in out.rglob('*') if p.is_file()} == set(content) | {'manifest.json'}, 'font-output-inventory')
        for name, data in content.items():
            need(local(out, name).read_bytes() == data, 'font-output-bytes:' + name)
    if mode == 'check':
        verify(output, marker, files)
    else:
        publish(files, output, allowed, marker, verify, resume=mode == 'resume', fail_after=fail_after)
    return dict(locale=locale, mode=mode, manifest=str((output/'manifest.json').relative_to(root)),
                manifestSha256=sha(output/'manifest.json'), changedObjects=len(changes), ready=False, newModelRequests=0)


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--profile', type=Path, required=True)
    parser.add_argument('--locale', required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--mode', choices=['build', 'resume', 'check'], default='build')
    args = parser.parse_args()
    print(json.dumps(run(args.profile, args.locale, args.output, args.mode)))
