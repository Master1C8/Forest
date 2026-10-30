"""Prepare explicit locale font operations from the accepted Russian mechanism.

Preparation reads saved resource/role evidence only. It never edits wording or
assets and does not grant font/native acceptance to another language.
"""
import argparse
import json
from pathlib import Path
import sys

from locale_queue import read, sha
from locale_fonts import transform, rawsha, encoded, need

ROOT = Path(__file__).resolve().parents[1]


def prepare(locale, input_manifest, requirements, dependency, managed, output):
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    from extract_assets import read_tree
    from russian_preview_ui import metric_spacing
    from locale_build import LOCALES
    need(locale in LOCALES and read(input_manifest)['locale'] == locale, 'font-explicit-locale')
    need(not output.exists() and output.resolve().is_relative_to(ROOT), 'font-new-profile-path')
    authority = ROOT/'localization/completion/russian-owner-baseline-20261030-01/acceptance.json'
    accepted = read(authority); reference = ROOT/accepted['build']/'game/The Forest of Love_Data'
    build = read(ROOT/accepted['build']/'build.json')
    need(build['coherentLegacyFace'] and build['uniformTmpFallback'] and build['coherentChoiceFace'], 'font-accepted-mechanisms')
    source = input_manifest.parent; manifest = read(input_manifest)
    generator = TypeTreeGenerator('2020.3.24f1'); generator.load_local_dll_folder(str(managed))
    pins = {}
    def pin(path):
        path = path.resolve(); pins[str(path.relative_to(ROOT))] = sha(path)
        return dict(path=str(path.relative_to(ROOT)), sha256=pins[str(path.relative_to(ROOT))])
    for p in [authority, input_manifest, ROOT/accepted['build']/'build.json', Path(__file__),
              ROOT/'tools/locale_fonts.py', ROOT/'tools/locale_build.py', ROOT/'tools/extract_assets.py',
              ROOT/'tools/russian_preview_ui.py', ROOT/'tools/russian_actor_names.py',
              ROOT/'tools/addressables_catalog.py', ROOT/'tools/locale_resource_publish.py']:
        pin(p)
    for p in managed.glob('*.dll'): pin(p)
    # This directory is the exact already-frozen parser/companion input. Pin every
    # later-loaded file, not just the CLI or a launcher.
    for p in dependency.rglob('*'):
        if p.is_file(): pin(p)
    cache = {}
    def load(directory, name):
        key = (str(directory), name)
        if key not in cache:
            p = directory/name; pin(p)
            env = UnityPy.load(str(p)); env.path = str(dependency)
            outer = next(iter(env.files.values())); member = ''
            if hasattr(outer, 'dataflags'):
                members = [n for n, f in outer.files.items() if hasattr(f, 'objects')]
                need(len(members) == 1, 'font-bundle-cab-count'); member = members[0]
            cache[key] = (outer.files[member] if member else outer, member)
        return cache[key]
    resources, _ = load(reference, 'resources.assets')
    native_face = read_tree(resources.objects[439], generator)
    primary, _ = load(reference, 'sharedassets0.assets')
    desired_face = read_tree(primary.objects[3323], generator)['m_FaceInfo']
    current_primary, _ = load(source, 'sharedassets0.assets')
    old_face = read_tree(current_primary.objects[3323], generator)['m_FaceInfo']
    operations = []
    for name in manifest['outputs']:
        if name.startswith(('Managed/', 'evidence/')) or name.endswith('.json'): continue
        original, member = load(source, name); donor, donor_member = load(reference, name)
        need(member == donor_member, 'font-cab-identity')
        for pid, obj in original.objects.items():
            kind = cls = None
            if obj.type.name == 'Font' and pid in donor.objects:
                tree = read_tree(obj, generator)
                if tree['m_Name'] in ['MatchupPro 1', 'MatchupPro_TFOL']: kind = 'native-face'
            elif obj.type.name == 'MonoBehaviour':
                head = obj.parse_monobehaviour_head()
                if head.m_Script.m_FileID:
                    external = original.externals[head.m_Script.m_FileID-1].path.replace('\\', '/').rsplit('/', 1)[-1]
                    # Unity's built-in resource scripts are not the managed
                    # Text/TMP classes selected by this bounded transform.
                    if external.lower() == 'unity default resources': continue
                cls = head.m_Script.deref().read().m_ClassName
                if cls == 'TMP_FontAsset':
                    tree = read_tree(obj, generator)
                    if tree['m_Name'] == 'MatchupPro_TFOL_SDF': kind = 'tmp-primary'
                    elif name == 'resources.assets' and pid == 1017: kind = 'dynamic-fallback'
                elif cls == 'TMP_Settings' and name == 'resources.assets' and pid == 1020:
                    tree = read_tree(obj, generator); kind = 'global-fallback'
                elif cls == 'Text' and pid in donor.objects:
                    tree = read_tree(obj, generator); other = read_tree(donor.objects[pid], generator)
                    before, after = tree['m_FontData']['m_Font'], other['m_FontData']['m_Font']
                    if before['m_PathID'] == 367 and after['m_PathID'] == 369 and before['m_FileID'] == after['m_FileID']:
                        need(tree['m_GameObject'] == other['m_GameObject'], 'font-native-owner')
                        op = dict(kind='native-pointer', before=before, after=after)
                        kind = 'native-pointer'
                elif cls == 'TextMeshProUGUI':
                    tree = read_tree(obj, generator); pointer = tree['m_fontAsset']; owner = name
                    if pointer['m_FileID']:
                        owner = original.externals[pointer['m_FileID']-1].path.replace('\\', '/').rsplit('/', 1)[-1]
                    font_id = -1127281652424575413 if member else 3323
                    if pointer['m_PathID'] == font_id and (member or owner == 'sharedassets0.assets'):
                        op = dict(kind='metric-spacing', font=pointer, oldFace=old_face, newFace=desired_face)
                        if transform(tree, op, spacing=metric_spacing) != tree: kind = 'metric-spacing'
            if kind is None: continue
            if kind not in {'metric-spacing', 'native-pointer'}:
                other = read_tree(donor.objects[pid], generator)
                op = dict(kind=kind, reference=dict(file=pin(reference/name), member=member,
                          id=pid, rawSha256=rawsha(donor.objects[pid])))
                if transform(tree, op, other) == tree: continue
            op.update(asset=name, member=member, id=pid, type=obj.type.name,
                      sourceRawSha256=rawsha(obj))
            if kind == 'metric-spacing':
                del op['oldFace']; del op['newFace']
            if cls: op['class'] = cls
            operations.append(op)
    codepoints = {32}; fictional = []
    requirement_pins = []
    for p in requirements:
        requirement_pins.append(pin(p))
        rows = [json.loads(l) for l in p.read_text().splitlines() if l] if p.suffix == '.jsonl' else read(p)
        for row in rows:
            # Fictional-language rows keep their separate original font identity.
            if row.get('group') in {'fictional-mouse', 'mouse-language', 'dialogue:known-fictional-preserved'}:
                fictional.append(dict(group=row['group'], characters=row.get('characters'),
                                      fontIds=row.get('fontIds'), acceptance='preserved;not-accepted-by-ordinary-font'))
                continue
            chars = row.get('characterRequirements', row.get('characters', {}))
            codepoints.update(chars.get('union', []))
    # This is a concrete selected face, not an inferred union of fallback cmaps.
    from fontTools.ttLib import TTFont
    import io
    face = TTFont(io.BytesIO(bytes(native_face['m_FontData'])))
    missing = sorted(codepoints - set(face.getBestCmap()))
    need(not missing, 'font-requirements-outside-selected-face:' + repr(missing))
    bundle = next(n for n in manifest['outputs'] if n.endswith('.bundle'))
    profile = dict(schemaVersion=1, kind='locale-font-transform', locale=locale,
        inputManifest=pin(input_manifest), baselineAcceptance=pin(authority),
        managedDirectory=str(managed.relative_to(ROOT)), dependencyDirectory=str(dependency.relative_to(ROOT)),
        companionDirectory=str(reference.relative_to(ROOT)),
        metricFaces=dict(oldFace=old_face, newFace=desired_face),
        embeddedFace=dict(asset=str((reference/'resources.assets').relative_to(ROOT)), id=439),
        bundle=bundle, operations=operations, requiredCodepoints=sorted(codepoints),
        requirementEvidence=requirement_pins, pins=[dict(path=p, sha256=h) for p, h in sorted(pins.items())],
        preservedFictionalRequirements=fictional,
        boundary='Explicit accepted font mechanisms only. Raw/NFC/NFD character supply is static; runtime fallback, marks and layout unverified.')
    output.parent.mkdir(parents=True, exist_ok=True); output.write_bytes(encoded(profile))
    return dict(locale=locale, operations=len(operations), codepoints=len(codepoints), pins=len(pins), profile=str(output.relative_to(ROOT)))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--locale', required=True); parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--requirements', type=Path, nargs='+', required=True)
    parser.add_argument('--dependencies', type=Path, required=True); parser.add_argument('--managed', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    a = parser.parse_args()
    print(json.dumps(prepare(a.locale, a.input.resolve(), [p.resolve() for p in a.requirements],
                             a.dependencies.resolve(), a.managed.resolve(), a.output.resolve())))
