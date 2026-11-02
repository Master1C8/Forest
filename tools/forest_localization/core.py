"""Compile a single language JSON using a registered, immutable game framework.

The framework owns selectors, baseline game adaptations and source identities.
Language documents own target strings only. No commands or Python paths can be
supplied by a language document. Game data and player files are read-only inputs.
"""
import argparse
import base64
import collections
import copy
import difflib
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile

from forest_localization import font_metrics

ROOT = Path(__file__).resolve().parents[2]
DATA_NAME = 'The Forest of Love_Data'
FORMAT = 'forest-language-v1'


def need(value, reason):
    if not value:
        raise ValueError(reason)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def binding(path):
    h = hashlib.sha256()
    with Path(path).open('rb') as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b''):
            h.update(block)
    return dict(bytes=Path(path).stat().st_size, sha256=h.hexdigest())


def encode(obj):
    return (json.dumps(obj, ensure_ascii=True, sort_keys=True, indent=2) + '\n').encode()


def read(path):
    def unique(pairs):
        out = {}
        for key, value in pairs:
            need(key not in out, 'duplicate-json-key:' + key)
            out[key] = value
        return out
    return json.loads(Path(path).read_bytes(), object_pairs_hook=unique)


def child(root, name):
    need(isinstance(name, str) and name and '\\' not in name
         and not Path(name).is_absolute(), 'relative-path-required')
    path = (Path(root) / name).resolve()
    need(path != Path(root).resolve() and path.is_relative_to(Path(root).resolve()), 'path-escape:' + name)
    return path


def write_new(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open('xb') as stream:
        stream.write(data)


def module(path, name):
    spec = importlib.util.spec_from_file_location(name, path)
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


def engines():
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    from extract_assets import read_tree, canonical
    composer = module(ROOT/'tools/locale_completion/resource_composition_v1/compose.py', 'forest_composer')
    inventory = module(ROOT/'tools/locale_completion/inventory52/inventory52.py', 'forest_bg_inventory')
    # Reuse the exact header-aligned writer without importing the historical
    # preview launcher and its locale-specific live input loaders.
    import ast
    path = ROOT/'tools/build_russian_preview.py'
    node = next(n for n in ast.parse(path.read_text()).body if isinstance(n, ast.FunctionDef) and n.name == 'save_tree')
    scope = {}
    exec(compile(ast.Module(body=[node], type_ignores=[]), str(path), 'exec'), scope)
    return UnityPy, TypeTreeGenerator, read_tree, canonical, composer, inventory, scope['save_tree']


def managed_tool(work):
    """Compile task-owned code once; never change an existing frozen compiler."""
    source = ROOT/'tools/forest_localization'
    cecil = ROOT/'tools/locale_completion/resource_composition_v1/managed_saved/bin/Debug/net8.0/Mono.Cecil.dll'
    need(cecil.is_file(), 'missing-existing-cecil-dependency')
    key = digest((source/'Managed.cs').read_bytes() + (source/'Managed.csproj').read_bytes() + cecil.read_bytes())
    folder = work/'compiler'/key
    dll = folder/'bin/Release/net8.0/Managed.dll'
    if not dll.exists():
        folder.mkdir(parents=True, exist_ok=True)
        for n in ['Managed.cs', 'Managed.csproj']:
            p = folder/n
            if p.exists():
                need(p.read_bytes() == (source/n).read_bytes(), 'compiler-snapshot-conflict')
            else:
                write_new(p, (source/n).read_bytes())
        subprocess.run(['dotnet', 'build', str(folder/'Managed.csproj'), '-c', 'Release', '--nologo', '-v', 'quiet',
                        '-p:CecilPath=' + str(cecil)], check=True, stdout=sys.stderr)
    return dll


def inspect_managed(path, work, key):
    out = work/(key + '.json')
    if out.exists():
        need(read(out)['sha256'] == binding(path)['sha256'], 'changed-managed-inspection-input')
    else:
        subprocess.run(['dotnet', str(managed_tool(work)), 'inspect', str(path), str(out)], check=True)
    return read(out)


def value(tree, pointer):
    for token in pointer.lstrip('/').split('/'):
        token = token.replace('~1', '/').replace('~0', '~')
        tree = tree[int(token)] if isinstance(tree, list) else tree[token]
    return tree


def native_texts(tree):
    # Dialogue gets its canonical complete inventory below. Serialized script
    # names, resource paths, lookup IDs and font names never become translations.
    if isinstance(tree, dict):
        for key in ('m_Text', 'm_text'):
            if isinstance(tree.get(key), str):
                yield '/' + key, tree[key]


def framework_manifest(directory):
    path = directory/'framework.json'
    data = read(path)
    need(data.get('format') == 'forest-framework-v1', 'framework-format')
    need(data.get('gameVersion') == '0.45', 'unsupported-game-version')
    for name, pin in data['files'].items():
        need(binding(child(directory, name)) == pin, 'framework-file-changed:' + name)
    catalog = read(directory/'catalog.json')
    need(len(catalog) == len({r['id'] for r in catalog}), 'duplicate-catalog-id')
    return data, catalog


def native_additions(catalog, rows, original, baseline):
    """Register inventoried native fields even when Russian left them unchanged."""
    result = copy.deepcopy(catalog)
    ids = {r['id'] for r in result}
    selectors = {(s['asset'], s['pathId'], s['pointer']) for r in result
                 for s in r['selectors'] if s['kind'] == 'field'}
    for row in rows:
        need(set(row) == {'id', 'source', 'selector'}, 'native-addition-schema')
        s = row['selector']
        need(set(s) == {'kind', 'asset', 'pathId', 'pointer'} and s['kind'] == 'field'
             and s['pointer'] in {'/m_text', '/m_Text'} and type(s['pathId']) is int,
             'native-addition-display-field')
        key = s['asset'], s['pathId'], s['pointer']
        need(row['id'] == s['asset'] + ':' + str(s['pathId']) + s['pointer'], 'native-addition-identity')
        need(row['id'] not in ids and key not in selectors, 'native-addition-overlap:' + row['id'])
        need(isinstance(row['source'], str) and original[key] == row['source'], 'native-addition-source:' + row['id'])
        need(isinstance(baseline[key], str), 'native-addition-baseline:' + row['id'])
        result.append(dict(id=row['id'], source=row['source'], baseline=baseline[key], selectors=[s]))
        ids.add(row['id']); selectors.add(key)
    return sorted(result, key=lambda r:r['id'])


def extend_native_framework(directory, original, packet, output, ident, resume=False):
    """Version a finite missing-selector repair without mutating frozen inputs."""
    directory, original, packet, output = (p.resolve() for p in [directory, original, packet, output])
    need(directory.is_relative_to(ROOT) and packet.is_relative_to(ROOT), 'project-owned-framework-and-packet')
    framework, catalog = framework_manifest(directory)
    need(re.fullmatch(r'[a-zA-Z0-9._-]+', ident), 'framework-id')
    need(output.resolve() == (directory.parent/ident).resolve() and output.resolve() != directory.resolve(),
         'new-sibling-framework-required')
    rows = [json.loads(line) for line in packet.read_text().splitlines() if line]
    need(rows, 'empty-native-addition-packet')
    stamp = dict(baseFramework=binding(directory/'framework.json'), packet=binding(packet), id=ident)
    need(not output.exists() or resume, 'occupied-framework-output')
    if output.exists():
        need(read(output/'extension-input.json') == stamp, 'native-extension-input-changed')
    assets = {r['selector']['asset'] for r in rows}
    need(assets <= set(framework['resources']), 'native-addition-outside-existing-resources')
    U, Generator, tree, _, comp, _, _ = engines()
    gen = Generator('2020.3.24f1'); gen.load_local_dll_folder(str(directory/'references'))
    values = [{}, {}]
    for asset in sorted(assets):
        need(binding(child(original, asset)) == framework['sourceMembers'][asset], 'native-original-version:' + asset)
        for index, root in enumerate([original, directory/'base']):
            env = U.load(str(child(root, asset))); env.path = str(root)
            objects = comp.objects(env)
            for row in rows:
                s = row['selector']
                if s['asset'] == asset:
                    values[index][asset, s['pathId'], s['pointer']] = value(tree(objects[s['pathId']], gen), s['pointer'])
    updated = native_additions(catalog, rows, *values)
    marker = copy.deepcopy(framework)
    marker.update(id=ident, catalogUnits=len(updated), extendedFrom=dict(
        path=str(directory.relative_to(ROOT)), **binding(directory/'framework.json')),
        nativeExtension=dict(path=str(packet.relative_to(ROOT)), **binding(packet), units=len(rows)))
    output.mkdir(parents=True, exist_ok=resume)
    def publish(name, data):
        path = child(output, name)
        if path.exists():
            need(resume and path.read_bytes() == data, 'native-extension-output-conflict:' + name)
        else:
            write_new(path, data)
    publish('extension-input.json', encode(stamp))
    for name in framework['files']:
        if name != 'extension-input.json':
            publish(name, encode(updated) if name == 'catalog.json' else child(directory, name).read_bytes())
    marker['files']['catalog.json'] = binding(output/'catalog.json')
    marker['files']['extension-input.json'] = binding(output/'extension-input.json')
    need({p.relative_to(output).as_posix() for p in output.rglob('*') if p.is_file()}
         <= set(marker['files']) | {'framework.json'}, 'unexpected-native-extension-members')
    publish('framework.json', encode(marker))
    framework_manifest(output)
    return dict(framework=ident, addedUnits=len(rows), units=len(updated), preservedBase=True, newModelRequests=0)


def create_framework(original, baseline, output, russian_output, framework_id, resume=False):
    """One-time migration of the accepted Russian implementation, not an audit.

    Snapshot exact changed game files, catalog localizable selectors and keep
    mechanics/fonts/layout as shared compiled inputs. English source is read
    from the original game, never inferred by translating the Russian wording.
    """
    need(re.fullmatch(r'[a-zA-Z0-9._-]+', framework_id), 'framework-id')
    original, baseline, output = original.resolve(), baseline.resolve(), output.resolve()
    need((not output.exists() or resume) and not russian_output.exists(), 'fresh-framework-and-language-output')
    need(not output.is_relative_to(original) and not output.is_relative_to(baseline), 'preserve-input-roots')
    source_manifest = read(ROOT/'assets/source-v2/source-files.json')
    authority_path = ROOT/'localization/completion/russian-owner-baseline-20261030-01/acceptance.json'
    authority = read(authority_path)
    need(authority['accepted'] is True and authority['locale'] == 'ru', 'accepted-Russian-mechanism-baseline')
    for key, name in dict(assembly='Managed/Assembly-CSharp.dll', resources='resources.assets', fontContainer='sharedassets0.assets',
                          sharedassets2='sharedassets2.assets', sharedassets4='sharedassets4.assets').items():
        need(binding(baseline/name)['sha256'] == authority['effectiveInstalledProfile'][key], 'accepted-baseline-version:' + name)
    # Use the complete agreed source inventory as the scope; never include saves,
    # platform binaries, globalgamemanagers (QA product identity), or probe DLLs.
    selected = []
    for name, expected in source_manifest.items():
        if name == 'globalgamemanagers':
            continue
        p, b = child(original, name), child(baseline, name)
        need(p.is_file() and binding(p) == expected, 'original-game-version:' + name)
        need(b.is_file(), 'baseline-member-missing:' + name)
        if binding(b) != expected:
            selected.append(name)
    extra = sorted(p.relative_to(baseline).as_posix() for p in (baseline/'Managed').glob('VNRevival*.dll'))
    selected = sorted(set(selected + extra))
    need(selected and 'resources.assets' in selected and 'Managed/Assembly-CSharp.dll' in selected, 'complete-baseline-input')
    need(shutil.disk_usage(ROOT).free - sum(child(baseline, n).stat().st_size for n in selected)*2 >= 5*1024**3, 'five-GiB-reserve')
    output.mkdir(parents=True, exist_ok=resume)
    work = output/'migration-work'; work.mkdir(exist_ok=resume)
    def snapshot(source, target):
        target.parent.mkdir(parents=True, exist_ok=True)
        if target.exists():
            need(resume and binding(source) == binding(target), 'migration-snapshot-conflict:' + str(target))
        else:
            shutil.copyfile(source, target)
    for name in selected:
        target = child(output/'base', name); target.parent.mkdir(parents=True, exist_ok=True)
        snapshot(child(baseline, name), target)
    # MonoBehaviour type recovery dereferences this original MonoScript table.
    # It is a read-only serialization companion, never an output game override.
    snapshot(original/'globalgamemanagers.assets', output/'base/globalgamemanagers.assets')
    # Original managed companions resolve MonoScripts during independent readback.
    refs = output/'references'; refs.mkdir(exist_ok=resume)
    for p in (original/'Managed').glob('*.dll'):
        snapshot(p, refs/p.name)
    U, Generator, tree, canonical, comp, inv, writer = engines()
    gen = Generator('2020.3.24f1'); gen.load_local_dll_folder(str(refs))
    catalog, targets, font_roles, layout_roles = [], {}, {}, {}

    def add(id_, source, target, selectors, **metadata):
        need(id_ not in targets, 'duplicate-migration-id:' + id_)
        catalog.append(dict(id=id_, source=source, baseline=target, selectors=selectors, **metadata))
        targets[id_] = target

    dialogue_manifest = read(ROOT/'localization/source/dialogue-manifest.json')
    dialogue = [json.loads(s) for s in (ROOT/'localization/source/dialogue-candidates.jsonl').read_text().splitlines() if s]
    need(len(dialogue) == 12246, 'canonical-dialogue-count')
    dialogue_objects = {}
    for spec in dialogue_manifest['sources']:
        asset, pid = spec['object'].rsplit(':', 1)
        dialogue_objects[asset.split('!/', 1)[0]] = int(pid)
    dialogue_values = collections.defaultdict(list)
    for name in selected:
        if name.startswith('Managed/') or name.endswith('.json'):
            continue
        src, base = U.load(str(child(original, name))), U.load(str(child(output/'base', name)))
        src.path, base.path = str(original), str(output/'base')
        a, b = comp.objects(src), comp.objects(base)
        need(set(a) == set(b), 'baseline-object-identities:' + name)
        for pid in sorted(b):
            if b[pid].type.name == 'Font':
                face = tree(b[pid], gen)
                if face.get('m_FontData') and face.get('m_Name') != 'ManaSpace':
                    font_roles[name + ':' + str(pid)] = dict(asset=name, pathId=pid, name=face['m_Name'],
                        faceSha256=digest(bytes(face['m_FontData'])), fictionalMappingMutable=False)
            if name in dialogue_objects and pid == dialogue_objects[name]:
                st, bt = tree(a[pid], gen), tree(b[pid], gen)
                for row in dialogue:
                    need(value(st, row['pointer']) == row['source'], 'canonical-dialogue-selector')
                    dialogue_values[row['id']].append(dict(kind='field', asset=name, pathId=pid, pointer=row['pointer'],
                                                          baseline=value(bt, row['pointer'])))
                continue
            if name == 'resources.assets' and pid == 320:
                st, bt = tree(a[pid], gen), tree(b[pid], gen)
                source_raw = st['m_Script'].encode('utf-8', errors='surrogateescape')
                base_raw = bt['m_Script'].encode('utf-8', errors='surrogateescape')
                parsed, states = inv.inventory(source_raw); _, bs = inv.inventory(base_raw)
                need(states == inv.independent_inventory(source_raw) and bs == inv.independent_inventory(base_raw), 'independent-bg-readback')
                need(set(states) == set(bs), 'same-bg-identities')
                for sheet in parsed['sheets']:
                    for field in sheet['fields']:
                        kind = field['type'].split(',')[0].rsplit('.', 1)[-1]
                        for rid in sheet['rowIds']:
                            id_ = inv.identity(sheet['id'], rid, field['id'])
                            if states[id_] != bs[id_]:
                                need(kind in ('BGFieldString', 'BGFieldText', 'BGFieldEntityName'), 'non-text-bg-change:' + id_)
                                need(states[id_] is not None and bs[id_] is not None, 'null-bg-preserved')
                                add(id_, states[id_].decode(), bs[id_].decode(), [dict(kind='bg', asset=name, pathId=pid,
                                    sheetId=sheet['id'], rowId=rid, fieldId=field['id'])])
                continue
            if a[pid].get_raw_data() == b[pid].get_raw_data():
                continue
            st, bt = tree(a[pid], gen), tree(b[pid], gen)
            source_texts = dict(native_texts(st))
            for ptr, target in native_texts(bt):
                need(ptr in source_texts, 'new-native-text-selector')
                if target != source_texts[ptr]:
                    add(name + ':' + str(pid) + ptr, source_texts[ptr], target,
                        [dict(kind='field', asset=name, pathId=pid, pointer=ptr)])
                    size_pointer = '/m_FontData/m_FontSize' if isinstance(bt.get('m_FontData'), dict) else '/m_fontSize'
                    try:
                        size = value(bt, size_pointer)
                    except KeyError:
                        size = None
                    if isinstance(size, (int, float)) and size >= 8:
                        layout_roles[name + ':' + str(pid)] = dict(asset=name, pathId=pid, pointer=size_pointer, baseline=size)
    for row in dialogue:
        selectors = dialogue_values[row['id']]
        need(len(selectors) == 2 and len({s['baseline'] for s in selectors}) == 1, 'both-dialogue-copies')
        target = selectors[0]['baseline']
        for s in selectors:
            s.pop('baseline')
        add(row['id'], row['source'], target, selectors, family='dialogue')
    # Existing Russian adapters contain display literals and sometimes their
    # matching comparison values. Catalog every changed/inserted non-ASCII value
    # at exact instruction selectors, retaining all untouched technical operands.
    known = collections.defaultdict(set)
    for r in catalog:
        if r['source']:
            known[r['baseline']].add(r['source'])
    unresolved = []
    for name in selected:
        if not name.endswith('.dll'):
            continue
        b = inspect_managed(child(output/'base', name), work, 'base-' + Path(name).stem)
        original_path = child(original, name)
        a = inspect_managed(original_path, work, 'source-' + Path(name).stem) if original_path.exists() else dict(methods=[])
        source_methods = {m['method']:m for m in a['methods']}
        for method in b['methods']:
            before = source_methods.get(method['method'], dict(instructions=[]))['instructions']
            after = method['instructions']
            def signature(i):
                return i['opcode'], '<text>' if i['opcode'] == 'ldstr' else i['operand']
            alignment = {}
            for start, end, size in difflib.SequenceMatcher(a=list(map(signature, before)), b=list(map(signature, after)), autojunk=False).get_matching_blocks():
                for k in range(size):
                    alignment[end+k] = before[start+k]
            for i in after:
                if i['opcode'] != 'ldstr':
                    continue
                old = alignment.get(i['index'])
                target = i['operand']
                if old and old['opcode'] == 'ldstr' and old['operand'] != target:
                    source = old['operand']
                elif (not old or old['opcode'] != 'ldstr') and any(ord(c) > 127 for c in target):
                    candidates = known.get(target, set())
                    source = next(iter(candidates)) if len(candidates) == 1 else None
                    # Accepted source/display adapter: compare an original
                    # speaker key, branch, return its localized display value.
                    n = i['index']
                    if source is None and n >= 3 and n+1 < len(after) and after[n-3]['opcode'] == 'ldstr' \
                            and after[n-2]['opcode'] == 'call' and after[n-2]['operand'] == 'System.Boolean System.String::op_Equality(System.String,System.String)' \
                            and after[n-1]['opcode'].startswith('brfalse') and after[n+1]['opcode'] == 'ret':
                        source = after[n-3]['operand']
                    # Source artwork identities, retained by the accepted
                    # Russian notebook adapter and the canonical image catalog.
                    if source is None and '::RussianStatusHeadings(' in method['method']:
                        if target == '\u0417\u0430\u0432\u0435\u0440\u0448\u0451\u043d\u043d\u044b\u0435':
                            source = 'Completed'
                        elif target == '\u0410\u043a\u0442\u0438\u0432\u043d\u044b\u0435':
                            source = 'Active'
                else:
                    continue
                id_ = 'managed:' + name + ':' + method['method'] + '@' + str(i['index'])
                add(id_, source, target, [dict(kind='managed', asset=name, method=method['method'], index=i['index'])])
                if source is None:
                    unresolved.append(id_)
    catalog.sort(key=lambda r:r['id'])
    write_new(output/'catalog.json', encode(catalog))
    files = {p.relative_to(output).as_posix():binding(p) for folder in ['base', 'references'] for p in (output/folder).rglob('*') if p.is_file()}
    files['catalog.json'] = binding(output/'catalog.json')
    for p in work.glob('base-*.json'):
        files[p.relative_to(output).as_posix()] = binding(p)
    authority = ROOT/'localization/completion/russian-owner-baseline-20261030-01/acceptance.json'
    marker = dict(format='forest-framework-v1', id=framework_id, game='The Forest of Love', gameVersion='0.45',
        baselineLocale='ru', files=files, resources=selected, sourceManifest=binding(ROOT/'assets/source-v2/source-files.json'),
        fontRoles=font_roles, layoutRoles=layout_roles,
        sourceMembers=source_manifest, baselineAuthority=dict(path=str(authority.relative_to(ROOT)), **binding(authority)),
        baseProvenance=str(baseline), sourceProvenance=str(original), catalogUnits=len(catalog),
        unresolvedEnglishSources=unresolved, scope='Accepted Russian selected display changes and complete dual dialogue corpus; no new semantic acceptance.')
    write_new(output/'framework.json', encode(marker))
    doc = language_document(marker, binding(output/'framework.json')['sha256'], catalog, 'ru', 'ru-RU', targets)
    write_new(russian_output, encode(doc))
    return dict(framework=framework_id, units=len(catalog), unresolvedEnglishSources=len(unresolved), resources=len(selected))


def language_document(framework, framework_hash, catalog, locale, culture, targets=None):
    return dict(format=FORMAT, locale=locale, culture=culture,
        framework=dict(id=framework['id'], sha256=framework_hash),
        translations={r['id']:dict(source=r['source'], target=targets[r['id']] if targets is not None else None)
                      for r in catalog},
        fonts={}, fontAssets={}, layout={},
        acceptance=dict(editorial='not-established-by-compiler', native='not-run', runtime='not-run'))


def load_language(path, frameworks):
    doc = read(path)
    need(doc.get('format') == FORMAT, 'language-format')
    need(re.fullmatch(r'[a-z]{2,3}(?:-[A-Za-z0-9]{2,8})*', doc.get('locale', '')) and isinstance(doc.get('culture'), str)
         and doc['culture'], 'explicit-locale-culture')
    ident = doc['framework']['id']
    need(re.fullmatch(r'[a-zA-Z0-9._-]+', ident), 'framework-id')
    directory = child(frameworks, ident)
    need(binding(directory/'framework.json')['sha256'] == doc['framework']['sha256'], 'framework-version')
    framework, catalog = framework_manifest(directory)
    rows = doc.get('translations')
    need(isinstance(rows, dict) and set(rows) == {r['id'] for r in catalog}, 'complete-exact-translation-ids')
    missing = []
    for row in catalog:
        item = rows[row['id']]
        need(set(item) == {'source', 'target'} and item['source'] == row['source'], 'immutable-source:' + row['id'])
        target = item['target']
        if target is None:
            missing.append(row['id'])
        else:
            need(isinstance(target, str) and '\x00' not in target, 'target-type-or-nul:' + row['id'])
            # Placeholders remain data bindings even in otherwise free text.
            placeholders = lambda s:collections.Counter(re.findall(r'\{\d+(?:[,:][^{}]*)?\}|%(?:\d+\$)?[sdif]', s))
            need(placeholders(target) == placeholders(row['baseline']), 'placeholder-binding:' + row['id'])
    for row in catalog:
        if any(s['kind'] == 'managed' and '::VNRevivalRuHaiku_Resolve(' in s.get('method', '') for s in row['selectors']):
            ids = [r['id'] for r in catalog if r['source'] == row['source'] and r['baseline'] == row['baseline']]
            values = {rows[id_]['target'] for id_ in ids if rows[id_]['target'] is not None}
            need(len(values) <= 1, 'haiku-display-evaluation-identity:' + row['id'])
    need(set(doc.get('fonts', {})) <= set(framework.get('fontRoles', {})), 'unregistered-font-role')
    need(set(doc.get('layout', {})) <= set(framework.get('layoutRoles', {})), 'unregistered-layout-role')
    for name, raw in doc.get('fontAssets', {}).items():
        face = base64.b64decode(raw, validate=True)
        need(digest(face) == name and len(face) <= 100*1024**2, 'font-payload-hash-or-size')
        import io
        from fontTools.ttLib import TTFont
        with TTFont(io.BytesIO(face)) as font:
            need(font.getBestCmap(), 'font-without-cmap')
    for role, spec in doc.get('fonts', {}).items():
        need(set(spec) == {'asset', 'family'} and spec['asset'] in doc['fontAssets']
             and isinstance(spec['family'], str) and spec['family'], 'explicit-font-face:' + role)
    for role, size in doc.get('layout', {}).items():
        need(type(size) in (int, float) and 8 <= size <= 128, 'layout-size-bounds:' + role)
        # No translation may replace a technical whole field carried by the
        # original complete dialogue inventory. Use its owning inline guard.
    return doc, directory, framework, catalog, missing


def wording_rows(path):
    """Read saved author rows or an existing shared resource plan, as data."""
    if path.suffix == '.jsonl':
        rows = [json.loads(line) for line in path.read_text().splitlines() if line]
    else:
        document = read(path)
        rows = document.get('edits') if isinstance(document, dict) else document
    need(isinstance(rows, list) and all(isinstance(r, dict) for r in rows), 'saved-wording-rows:' + str(path))
    return rows


def import_existing(candidate_path, frameworks, ident, locale, culture, output, wording=()):
    """Import saved target data once; no reinterpretation of review receipts.

    Missing or ambiguous managed mappings stay null. Matching by English text is
    allowed only when all observed targets agree; selector matches take priority.
    This is migration into the one-file interface, not a language worker.
    """
    folder = child(frameworks, ident)
    framework, catalog = framework_manifest(folder)
    candidate_path = candidate_path.resolve()
    candidate = read(candidate_path)
    need(candidate['locale'] == locale and candidate['culture'] == culture, 'candidate-locale-culture')
    resources = candidate['gameResources']
    prefix = DATA_NAME + '/'
    need(resources and all(n.startswith(prefix) for n in resources), 'candidate-game-resources')
    for n, pin in resources.items():
        need(binding(child(candidate_path.parent, n)) == pin, 'candidate-resource:' + n)
    base = candidate_path.parent/DATA_NAME
    U, Generator, tree, canonical, comp, inv, writer = engines()
    gen = Generator('2020.3.24f1'); gen.load_local_dll_folder(str(folder/'references'))
    cache, tree_cache, bg, methods, baseline_methods, targets = {}, {}, {}, {}, {}, {}
    work = ROOT/'outputs/universal-localizer-20261031/import-work'/locale
    work.mkdir(parents=True, exist_ok=True)
    def load(name):
        if name not in cache:
            need(prefix + name in resources, 'candidate-resource-not-declared:' + name)
            env = U.load(str(child(base, name))); env.path = str(folder/'base')
            cache[name] = env, comp.objects(env)
        return cache[name][1]
    def imported_tree(name, pid):
        key = name, pid
        if key not in tree_cache:
            tree_cache[key] = tree(load(name)[pid], gen)
        return tree_cache[key]
    known = collections.defaultdict(set)
    for path in wording:
        for r in wording_rows(path):
            if isinstance(r.get('source'), str) and isinstance(r.get('target'), str):
                known[r['source']].add(r['target'])
    for row in catalog:
        values = []
        for s in row['selectors']:
            if s['kind'] == 'managed':
                continue
            if prefix + s['asset'] not in resources:
                continue
            current = imported_tree(s['asset'], s['pathId'])
            if s['kind'] == 'field':
                values.append(value(current, s['pointer']))
            else:
                if s['asset'] not in bg:
                    raw = current['m_Script'].encode('utf-8', errors='surrogateescape')
                    _, cells = inv.inventory(raw)
                    need(cells == inv.independent_inventory(raw), 'import-bg-independent-readback')
                    bg[s['asset']] = cells
                raw = bg[s['asset']][row['id']]
                values.append(raw.decode() if raw is not None else None)
        if values:
            need(all(v == values[0] for v in values) and isinstance(values[0], str), 'import-physical-copy-agreement:' + row['id'])
            targets[row['id']] = values[0]
            known[row['source']].add(values[0])
    # Exact semantic method alignment uses opcode/operand shape with only ldstr
    # text replaced by a slot. Added helpers that do not match are never guessed.
    for row in catalog:
        if row['id'] in targets:
            continue
        selector = row['selectors'][0]; name = selector['asset']
        if selector['kind'] != 'managed':
            targets[row['id']] = next(iter(known[row['source']])) if len(known.get(row['source'], set())) == 1 else None
            continue
        if name not in methods:
            if prefix + name not in resources:
                methods[name] = {}
            else:
                data = inspect_managed(child(base, name), work, digest(name.encode())[:12] + '-' + binding(child(base,name))['sha256'][:12])
                methods[name] = {m['method']:m['instructions'] for m in data['methods']}
        if name not in baseline_methods:
            baseline_inspection = read(folder/'migration-work'/('base-' + Path(name).stem + '.json'))
            baseline_methods[name] = {m['method']:m['instructions'] for m in baseline_inspection['methods']}
        before = baseline_methods[name][selector['method']]
        after = methods[name].get(selector['method'], [])
        signature = lambda i:(i['opcode'], '<text>' if i['opcode'] == 'ldstr' else i['operand'])
        matches = []
        for i, j, size in difflib.SequenceMatcher(a=list(map(signature, before)), b=list(map(signature, after)), autojunk=False).get_matching_blocks():
            if i <= selector['index'] < i+size:
                target = after[j+selector['index']-i]
                if target['opcode'] == 'ldstr':
                    matches.append(target['operand'])
        if len(matches) == 1:
            targets[row['id']] = matches[0]
        elif len(known.get(row['source'], set())) == 1:
            targets[row['id']] = next(iter(known[row['source']]))
        else:
            targets[row['id']] = None
    doc = language_document(framework, binding(folder/'framework.json')['sha256'], catalog, locale, culture, targets)
    doc['importProvenance'] = dict(candidateManifest=dict(path=str(candidate_path.relative_to(ROOT)), **binding(candidate_path)),
                                   semanticAcceptanceAdded=False)
    # Import actual native face and point-size differences as data. Do not change
    # font/material PPtrs or fictional-language mappings during migration.
    for role, spec in framework.get('fontRoles', {}).items():
        if prefix + spec['asset'] not in resources:
            continue
        face = imported_tree(spec['asset'], spec['pathId'])
        raw = bytes(face['m_FontData'])
        if raw and digest(raw) != spec['faceSha256']:
            h = digest(raw)
            doc['fontAssets'][h] = base64.b64encode(raw).decode()
            doc['fonts'][role] = dict(asset=h, family=face['m_FontNames'][0])
    for role, spec in framework.get('layoutRoles', {}).items():
        if prefix + spec['asset'] not in resources:
            continue
        size = value(imported_tree(spec['asset'], spec['pathId']), spec['pointer'])
        if size != spec['baseline'] and type(size) in (int, float) and 8 <= size <= 128:
            doc['layout'][role] = size
    write_new(output, encode(doc))
    return dict(locale=locale, units=len(catalog), imported=sum(v is not None for v in targets.values()),
                missing=sum(v is None for v in targets.values()), output=str(output), semanticAcceptanceAdded=False)


def merge_wording(language, wording, output):
    """Fill unread targets from saved authored rows; leave conflicts unread."""
    doc = read(language)
    need(doc.get('format') == FORMAT, 'language-format')
    by_source, by_id = collections.defaultdict(set), collections.defaultdict(set)
    for path in wording:
        for r in wording_rows(path):
            if isinstance(r.get('source'), str) and isinstance(r.get('target'), str):
                by_source[r['source']].add(r['target'])
                by_id[(r.get('id'), r['source'])].add(r['target'])
    changed = []
    for id_, item in doc['translations'].items():
        if item['target'] is not None:
            continue
        targets = by_id.get((id_, item['source']), set()) or by_source.get(item['source'], set())
        if len(targets) == 1:
            item['target'] = next(iter(targets)); changed.append(id_)
    doc.setdefault('importProvenance', {})['mergedWording'] = dict(
        language=dict(path=str(language), **binding(language)),
        inputs=[dict(path=str(p), **binding(p)) for p in wording], filledIds=changed, semanticAcceptanceAdded=False)
    write_new(output, encode(doc))
    return dict(filled=len(changed), missing=sum(r['target'] is None for r in doc['translations'].values()),
                output=str(output), semanticAcceptanceAdded=False)


def engine_fingerprint():
    paths = ['tools/forest_localization/core.py', 'tools/forest_localization/Managed.cs',
             'tools/forest_localization/font_metrics.py',
             'tools/forest_localization/Managed.csproj', 'tools/extract_assets.py', 'tools/addressables_catalog.py',
             'tools/locale_completion/resource_composition_v1/compose.py',
             'tools/locale_completion/inventory52/inventory52.py', 'tools/locale_completion/inventory52/bg_codec.py',
             'tools/locale_completion/inventory52/bg_peer.py', 'localization/ru-assets/inline_guard.py',
             'localization/ru-assets/source-dispositions.json', 'localization/source/dialogue-candidates.jsonl']
    pins = {name:binding(ROOT/name)['sha256'] for name in paths}
    # Only the reused writer function is a dependency of this compiler.
    import ast
    source = (ROOT/'tools/build_russian_preview.py').read_text()
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == 'save_tree')
    pins['tools/build_russian_preview.py::save_tree'] = digest(ast.get_source_segment(source, node).encode())
    import importlib.metadata
    pins['python'] = sys.version
    pins['UnityPy'] = importlib.metadata.version('UnityPy')
    pins['fontTools'] = importlib.metadata.version('fonttools')
    return pins, digest(encode(pins))


def validate_dialogue(guard, row, target, decision=None):
    """Accepted Russian control rules, independent of the target alphabet.

    A Cyrillic-presence test is a Russian authoring heuristic. It is neither a
    control-identity requirement nor a linguistic pass for another language.
    """
    ident, source = row['id'], row['source']
    if decision:
        need(decision['id'] == ident and decision['sourceSha256'] == guard.sha(source.encode()), 'dialogue-disposition-version:' + ident)
        if decision['disposition'] == 'preserved-source-placeholder':
            guard.validate_source_placeholder(row, decision)
            need(target == source, 'dialogue-source-placeholder:' + ident)
            return
        if decision.get('preservePrefix'):
            need(source.startswith(decision['preservePrefix']) and target.startswith(decision['preservePrefix']), 'dialogue-protected-prefix:' + ident)
    ordinary = decision.get('ordinaryBracketOrdinals', []) if decision else []
    need(guard.controls(source, ordinary) == guard.controls(target, ordinary), 'dialogue-protected-controls:' + ident)
    for separator in ('\n', '\r', '|'):
        need(source.count(separator) == target.count(separator), 'dialogue-separator:' + ident)
    # Visible quantities may be written as words or use target-language digits.
    # Their meaning belongs to the version-bound semantic audit. Numeric command
    # operands remain exact through controls(); placeholders are checked on load.
    if decision and decision['disposition'] in ('reviewed-unchanged-nonprose', 'preserved-detached-source', 'preserved-constructed-language'):
        need(target == source == decision['preserveExactly'], 'dialogue-preserved-source:' + ident)
    else:
        need(target.strip(), 'dialogue-empty-prose:' + ident)


def compile_language(language, output, frameworks, mode='build', fail_after=None):
    doc, directory, framework, catalog, missing = load_language(language, frameworks)
    need(not missing, 'untranslated-targets:' + str(len(missing)))
    output = output.resolve()
    need(output.is_relative_to(ROOT/'dist') and output != ROOT/'dist', 'output-must-be-new-project-dist-child')
    need(not output.is_relative_to(directory) and not directory.is_relative_to(output), 'preserve-framework')
    need(mode in {'build', 'resume', 'check'}, 'mode')
    if mode == 'build':
        need(not output.exists(), 'occupied-output-use-check-or-resume')
    engine_pins, engine_hash = engine_fingerprint()
    stamp = dict(languageSha256=binding(language)['sha256'], frameworkSha256=doc['framework']['sha256'], locale=doc['locale'],
                 compilerSha256=engine_hash)
    if output.exists():
        need(read(output/'build-input.json') == stamp, 'partial-output-different-input')
    elif mode != 'check':
        output.mkdir(parents=True)
        write_new(output/'build-input.json', encode(stamp))
    changed = []
    for row in catalog:
        if doc['translations'][row['id']]['target'] != row['baseline']:
            need(row['source'] is not None, 'unresolved-source-for-edited-target:' + row['id'])
            changed.append(row)
    # Validate all dialogue using the existing source-aware control parser.
    if any(r.get('family') == 'dialogue' for r in changed):
        guard_path = ROOT/'localization/ru-assets/inline_guard.py'
        guard = module(guard_path, 'forest_inline_guard')
        sources = {r['id']:r for r in map(json.loads, (ROOT/'localization/source/dialogue-candidates.jsonl').read_text().splitlines())}
        dispositions = guard.load_dispositions(ROOT/'localization/ru-assets/source-dispositions.json', ROOT, sources)
        for row in changed:
            if row.get('family') == 'dialogue':
                validate_dialogue(guard, sources[row['id']], doc['translations'][row['id']]['target'], dispositions.get(row['id']))
    expected_bytes = sum(framework['files']['base/' + n]['bytes'] for n in framework['resources'])
    need(shutil.disk_usage(ROOT).free - expected_bytes*3 >= 5*1024**3, 'five-GiB-reserve')
    by_asset = collections.defaultdict(list)
    for r in changed:
        for selector in r['selectors']:
            by_asset[selector['asset']].append(dict(selector, id=r['id'], source=r['baseline'], target=doc['translations'][r['id']]['target']))
    for role, size in doc.get('layout', {}).items():
        s = framework['layoutRoles'][role]
        by_asset[s['asset']].append(dict(s, kind='field', id=role + '/layout', source=s['baseline'], target=size))
    for role, spec in doc.get('fonts', {}).items():
        s = framework['fontRoles'][role]
        by_asset[s['asset']].append(dict(s, kind='font', id=role, spec=spec))
    if any(not n.endswith('.dll') for n in by_asset):
        U, Generator, tree, canonical, comp, inv, writer = engines()
        gen = Generator('2020.3.24f1'); gen.load_local_dll_folder(str(directory/'references'))
    files, proofs = {}, []
    work_root = ROOT/'outputs/universal-localizer-20261031/build-work'
    work_root.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix=doc['locale'] + '-', dir=work_root) as tmp:
        work = Path(tmp)
        for name in framework['resources']:
            path = child(directory/'base', name)
            edits = by_asset.get(name, [])
            if not edits:
                files[name] = path.read_bytes()
                continue
            if name.endswith('.dll'):
                need(all(r['kind'] == 'managed' for r in edits), 'managed-selectors-only')
                request = work/(Path(name).name + '.request.json')
                write_new(request, encode(dict(sourceSha256=binding(path)['sha256'], rows=edits)))
                dll, proof = work/Path(name).name, work/(Path(name).name + '.proof.json')
                subprocess.run(['dotnet', str(managed_tool(work_root)), 'patch', str(path), str(request), str(dll), str(proof)], check=True)
                files[name] = dll.read_bytes(); proofs.append(dict(asset=name, **read(proof)))
                continue
            original, env = U.load(str(path)), U.load(str(path))
            original.path = env.path = str(directory/'base')
            obs = comp.objects(env); expected = {}
            font_targets = {}
            for font in [r for r in edits if r['kind'] == 'font']:
                pid = font['pathId']
                need(pid not in font_targets, 'one-face-per-font-role')
                current = tree(obs[pid], gen)
                need(digest(bytes(current['m_FontData'])) == font['faceSha256'], 'exact-baseline-font')
                face = base64.b64decode(doc['fontAssets'][font['spec']['asset']], validate=True)
                if face == bytes(current['m_FontData']):
                    need(font['spec']['family'] in current['m_FontNames'], 'unchanged-face-family')
                    font_targets[pid] = current
                    continue
                metrics = font_metrics.face_metrics(face, font['spec']['family'])
                font_targets[pid] = font_metrics.native_font(current, face, metrics)
                dependencies = font_metrics.TMP_DEPENDENCIES.get((name, pid), ())
                for dependent in dependencies:
                    need(dependent in obs and dependent not in font_targets
                         and not any(r['pathId'] == dependent for r in edits), 'registered-font-dependency-conflict')
                    font_targets[dependent] = font_metrics.tmp_font(tree(obs[dependent], gen), metrics, pid,
                        font['spec']['asset'] + metrics['extension'])
                proofs.append(dict(asset=name, fontPathId=pid, faceSha256=digest(face),
                    dependentTmpPathIds=list(dependencies), faceMetrics=metrics,
                    boundary='Table-scaled serialized font inputs; no Unity import/native rendering acceptance'))
            for pid in sorted({r['pathId'] for r in edits} | set(font_targets)):
                current = tree(obs[pid], gen)
                direct = [r for r in edits if r['pathId'] == pid and r['kind'] == 'field']
                result = comp.merged_edits(current, direct)
                bg = [r for r in edits if r['pathId'] == pid and r['kind'] == 'bg']
                if bg:
                    raw, proof = comp.bg_project(result['m_Script'].encode('utf-8', errors='surrogateescape'), bg, inv)
                    result['m_Script'] = raw.decode('utf-8', errors='surrogateescape')
                    proofs.append(dict(asset=name, **proof))
                if pid in font_targets:
                    need(not direct and not bg, 'font-field-overlap')
                    result = font_targets[pid]
                writer(obs[pid], result, gen); expected[pid] = result
            data = env.file.save(packer='original') if name.endswith('.bundle') else env.file.save()
            saved = U.load(data); saved.path = str(directory/'base')
            proof = comp.verify_resource(original, saved, expected, module(ROOT/'tools/extract_assets.py', 'forest_extractor'), gen)
            # Also reverse all selected raw objects and require byte identity of
            # the complete containing file, including streams and compression.
            saved_objects, original_objects = comp.objects(saved), comp.objects(original)
            for pid in expected:
                saved_objects[pid].set_raw_data(original_objects[pid].get_raw_data())
            reverse = saved.file.save(packer='original') if name.endswith('.bundle') else saved.file.save()
            need(reverse == path.read_bytes(), 'whole-resource-reversal:' + name)
            files[name] = data; proofs.append(dict(asset=name, wholeContainerReversal=True, **proof))
        bundles = [n for n in by_asset if n.endswith('.bundle')]
        if bundles:
            import addressables_catalog
            need(len(bundles) == 1 and 'StreamingAssets/aa/catalog.json' in files, 'known-addressables-catalog')
            name = bundles[0]; target = work/'new.bundle'; target.write_bytes(files[name])
            catalog_out = work/'catalog.json'
            proof = addressables_catalog.update_catalog(directory/'base/StreamingAssets/aa/catalog.json', catalog_out,
                                                       directory/'base'/name, target)
            files['StreamingAssets/aa/catalog.json'] = catalog_out.read_bytes()
            proofs.append(dict(asset='StreamingAssets/aa/catalog.json', **proof))
    need(binding(language)['sha256'] == stamp['languageSha256'] and engine_fingerprint()[1] == engine_hash,
         'build-input-or-engine-changed-during-compilation')
    framework_manifest(directory)
    marker = dict(format='forest-compiled-language-v1', **stamp, culture=doc['culture'], gameVersion=framework['gameVersion'],
        engineInputs=engine_pins,
        files={DATA_NAME + '/' + n:dict(bytes=len(b), sha256=digest(b)) for n,b in files.items()},
        baselineUnits=len(catalog), changedUnits=len(changed), readbacks=proofs,
        configuredFontRoles=len(doc.get('fonts', {})), configuredLayoutRoles=len(doc.get('layout', {})),
        preservedBaselineResources=[n for n in files if n not in by_asset],
        acceptance=dict(editorial='not-established-by-compiler', fonts='static-face-data-and-table-scaled-metrics;target-coverage-allocation-shaping-and-layout-not-accepted',
                        native='not-run', runtime='not-run', release='not-accepted'),
        installed=False, newModelRequests=0,
        publicationBoundary='Exclusive resumable writes, input marker first, completion manifest last. No installation or multi-file transaction.')
    content = {DATA_NAME + '/' + n:b for n,b in files.items()}
    for index, (name, data) in enumerate(sorted(content.items()), 1):
        p = child(output, name)
        if p.exists():
            need(p.read_bytes() == data, 'conflicting-output:' + name)
        else:
            need(mode != 'check', 'missing-output:' + name)
            write_new(p, data)
        if fail_after == index:
            raise RuntimeError('injected-publication-interruption')
    expected_paths = set(content) | {'build-input.json', 'manifest.json'}
    existing = {p.relative_to(output).as_posix() for p in output.rglob('*') if p.is_file()}
    need(existing <= expected_paths, 'unexpected-output-members')
    manifest = output/'manifest.json'
    if manifest.exists():
        need(read(manifest) == marker, 'completion-manifest-conflict')
    else:
        need(mode != 'check', 'completion-manifest-missing')
        write_new(manifest, encode(marker))
    need({p.relative_to(output).as_posix() for p in output.rglob('*') if p.is_file()} == expected_paths, 'complete-output-inventory')
    return dict(passed=True, locale=doc['locale'], units=len(catalog), changedUnits=len(changed), resources=len(files),
                configuredFontRoles=len(doc.get('fonts', {})), configuredLayoutRoles=len(doc.get('layout', {})),
                output=str(output), installed=False, newModelRequests=0)


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--frameworks', type=Path, default=ROOT/'localization/framework')
    sub = p.add_subparsers(dest='command', required=True)
    q = sub.add_parser('migrate-russian', help='One-time immutable migration of the accepted baseline')
    for n in ['original', 'baseline', 'output', 'language-output']:
        q.add_argument('--' + n, type=Path, required=True)
    q.add_argument('--id', required=True)
    q.add_argument('--resume', action='store_true')
    q = sub.add_parser('template', help='Create a complete untranslated language file')
    q.add_argument('--framework', required=True); q.add_argument('--locale', required=True); q.add_argument('--culture', required=True)
    q.add_argument('--output', type=Path, required=True)
    q = sub.add_parser('extend-native', help='Version inventoried missing native fields without changing the baseline')
    q.add_argument('--framework', required=True); q.add_argument('--id', required=True)
    q.add_argument('--original', type=Path, required=True); q.add_argument('--packet', type=Path, required=True)
    q.add_argument('--resume', action='store_true')
    q = sub.add_parser('validate', help='Report exact missing targets without calling a model')
    q.add_argument('language', type=Path)
    q.add_argument('--details', action='store_true')
    q = sub.add_parser('import-existing', help='Migrate a saved locale candidate into one language JSON')
    q.add_argument('--framework', required=True); q.add_argument('--locale', required=True); q.add_argument('--culture', required=True)
    q.add_argument('--candidate', type=Path, required=True); q.add_argument('--output', type=Path, required=True)
    q.add_argument('--wording', type=Path, action='append', default=[])
    q = sub.add_parser('merge-wording', help='Fill missing targets from existing authored source/target records')
    q.add_argument('language', type=Path); q.add_argument('--wording', type=Path, action='append', required=True)
    q.add_argument('--output', type=Path, required=True)
    q = sub.add_parser('build', help='Compile one language JSON into a new game-data overlay')
    q.add_argument('language', type=Path); q.add_argument('--output', type=Path)
    q.add_argument('--mode', choices=['build', 'resume', 'check'], default='build')
    a = p.parse_args()
    if a.command == 'migrate-russian':
        result = create_framework(a.original, a.baseline, a.output, a.language_output, a.id, a.resume)
    elif a.command == 'extend-native':
        result = extend_native_framework(child(a.frameworks, a.framework), a.original, a.packet,
                                         child(a.frameworks, a.id), a.id, a.resume)
    elif a.command == 'template':
        folder = child(a.frameworks, a.framework); framework, catalog = framework_manifest(folder)
        write_new(a.output, encode(language_document(framework, binding(folder/'framework.json')['sha256'], catalog, a.locale, a.culture)))
        result = dict(output=str(a.output), units=len(catalog), untranslated=len(catalog))
    elif a.command == 'validate':
        doc, _, _, catalog, missing = load_language(a.language, a.frameworks)
        result = dict(locale=doc['locale'], units=len(catalog), providedTargets=len(catalog)-len(missing), missing=len(missing),
                      unresolvedSourceUnits=sum(r['source'] is None for r in catalog), readyToCompile=not missing,
                      newModelRequests=0)
        if a.details:
            result['missingIds'] = missing
    elif a.command == 'import-existing':
        result = import_existing(a.candidate, a.frameworks, a.framework, a.locale, a.culture, a.output, a.wording)
    elif a.command == 'merge-wording':
        result = merge_wording(a.language, a.wording, a.output)
    else:
        doc = read(a.language)
        output = a.output or ROOT/'dist'/('Forest-' + doc['locale'] + '-' + binding(a.language)['sha256'][:12])
        result = compile_language(a.language, output, a.frameworks, a.mode)
    print(json.dumps(result, ensure_ascii=False))
