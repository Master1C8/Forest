#!/usr/bin/env python3
"""Compose exact reviewed resource changes; no game, installer or model execution.

One object is loaded once, all disjoint field edits are merged, then it is saved
once. The frozen plan owns source/target values, selectors and preservation rows.
This is a sparse resource candidate, not permission to install it.
"""
import argparse
import copy
import hashlib
import importlib.util
import json
from pathlib import Path
import shutil
import struct
import sys


def need(ok, why):
    if not ok:
        raise ValueError(why)


def sha(b): return hashlib.sha256(b).hexdigest()
def encode(v): return (json.dumps(v, ensure_ascii=False, sort_keys=True, indent=2) + '\n').encode()
def read(p): return json.loads(Path(p).read_bytes())


def child(root, name):
    p = (root / name).resolve()
    need(not Path(name).is_absolute() and p.is_relative_to(root.resolve()), 'relative-contained-path')
    return p


def module(path, name):
    s = importlib.util.spec_from_file_location(name, path)
    m = importlib.util.module_from_spec(s); s.loader.exec_module(m)
    return m


def pointer(tree, path):
    bits = path.strip('/').split('/')
    for bit in bits[:-1]:
        bit = bit.replace('~1', '/').replace('~0', '~')
        tree = tree[int(bit)] if isinstance(tree, list) else tree[bit]
    bit = bits[-1].replace('~1', '/').replace('~0', '~')
    return tree, int(bit) if isinstance(tree, list) else bit


def merged_edits(tree, edits):
    """All expected values refer to the same original, never an evolving string."""
    paths = [r['pointer'] for r in edits]
    need(len(paths) == len(set(paths)), 'duplicate-field-selector')
    # Sorted neighboring paths expose every ancestor overlap without a quadratic
    # cross product over the complete dialogue corpus.
    ordered = sorted(p.rstrip('/') + '/' for p in paths)
    need(not any(b.startswith(a) for a, b in zip(ordered, ordered[1:])), 'overlapping-field-selectors')
    result = copy.deepcopy(tree)
    for r in edits:
        old, key = pointer(tree, r['pointer'])
        need(old[key] == r['source'], 'source-field:' + r['id'])
        parent, key = pointer(result, r['pointer']); parent[key] = r['target']
    return result


def bg_project(data, edits, inv):
    codec = inv.module('bg_codec')
    before, states = inv.inventory(data)
    need(states == inv.independent_inventory(data), 'independent-before51572')
    need(len(edits) == len({r['id'] for r in edits}), 'duplicate-bg-selector')
    selected = {r['id']: r for r in edits}; expected = dict(states)
    cols, oldcols, found = [], {}, set()
    for s in before['sheets']:
        for f in s['fields']:
            rr = [r for r in edits if r['sheetId'] == s['id'] and r['fieldId'] == f['id']]
            if not rr:
                continue
            kind = f['type'].split(',')[0].rsplit('.', 1)[-1]
            need(kind in ('BGFieldString', 'BGFieldText', 'BGFieldEntityName'), 'bg-display-string-only')
            start = f['valuesOffset']; old = data[start:start + f['valuesBytes']]
            cells, _ = codec.variable_cells(dict(f, valuesHex=old.hex()), len(s['rowIds']))
            for r in rr:
                idx = s['rowIds'].index(r['rowId'])
                need(inv.identity(s['id'], r['rowId'], f['id']) == r['id'], 'bg-stable-selector')
                need(states[r['id']] == cells[idx] == r['source'].encode(), 'bg-source:' + r['id'])
                cells[idx] = r['target'].encode(); expected[r['id']] = cells[idx]; found.add(r['id'])
            count = struct.unpack_from('<i', old)[0]
            order = [struct.unpack_from('<ii', old, 4 + i*8)[0] for i in range(count)]
            end, pairs, payload = 0, [], []
            for idx in order:
                need(cells[idx] is not None, 'bg-stored-null')
                end += len(cells[idx]); pairs.append(struct.pack('<ii', idx, end)); payload.append(cells[idx])
            cols.append((f, struct.pack('<i', count) + b''.join(pairs + payload)))
            oldcols[(s['id'], f['id'])] = old
    need(found == set(selected), 'all-bg-selectors-found')
    def replace(raw, columns):
        for f, blob in sorted(columns, key=lambda x:x[0]['valuesOffset'], reverse=True):
            raw = inv.replace_column(raw, f, blob)
        return raw
    result = replace(data, cols)
    after, got = inv.inventory(result)
    need(got == expected == inv.independent_inventory(result), 'complete-bg51572-readback')
    reverse = [(f, oldcols[(s['id'], f['id'])]) for s in after['sheets'] for f in s['fields'] if (s['id'], f['id']) in oldcols]
    need(replace(result, reverse) == data, 'complete-bg-byte-reversal')
    return result, dict(comparedStates=len(got), selectedIds=sorted(selected), independentReadback=True, wholePayloadReversed=True)


def objects(env):
    rows = list(env.objects)
    need(len(rows) == len({o.path_id for o in rows}), 'duplicate-object-id-in-container')
    return {o.path_id:o for o in rows}


def native_face_copy(original, imported, spec):
    """Reuse an accepted native input, retaining the destination's stored links.

    This is the Russian coherent-native field policy with explicit locale data.
    It does not modify TMP, textures, materials or Unity's runtime caches.
    """
    preserved = {'m_Name', 'm_DefaultMaterial', 'm_Texture', 'm_FallbackFonts'}
    need(set(original) == set(imported), 'native-face-schema')
    need(original['m_Name'] == spec['originalName'], 'native-face-original-name')
    need(imported['m_FontRenderingMode'] == 0 and not imported['m_CharacterRects'], 'native-face-dynamic-input')
    need(sha(bytes(imported['m_FontData'])) == spec['faceSha256'], 'native-face-payload')
    need(imported['m_FontNames'] == [spec['family']], 'native-face-family')
    result = copy.deepcopy(imported)
    for key in preserved:
        result[key] = copy.deepcopy(original[key])
    return result


def verify_resource(source, saved, expected, ex, generator):
    a, b = objects(source), objects(saved)
    need(set(a) == set(b), 'saved-object-identities')
    textures = 0
    for pid, original in a.items():
        if pid in expected:
            need(ex.canonical(ex.read_tree(b[pid], generator)) == ex.canonical(expected[pid]), 'complete-selected-tree:' + str(pid))
        else:
            need(original.get_raw_data() == b[pid].get_raw_data(), 'unselected-raw:' + str(pid))
        if original.type.name == 'Texture2D':
            need(original.get_raw_data() == b[pid].get_raw_data(), 'texture-original:' + str(pid)); textures += 1
    def serialized(env):
        return [env.file] if hasattr(env.file, 'objects') else [f for f in env.file.files.values() if hasattr(f, 'objects')]
    sa, sb = serialized(source), serialized(saved)
    # Plain serialized files receive the loader's input name; it is not serialized
    # identity. Bundle CAB member names are actually stored and must match.
    if not hasattr(source.file, 'objects'):
        need([f.name for f in sa] == [f.name for f in sb], 'serialized-CAB-identities')
    for x, y in zip(sa, sb):
        need([(e.path, e.guid, e.type) for e in x.externals] == [(e.path, e.guid, e.type) for e in y.externals], 'external-resource-bindings')
    if not hasattr(source.file, 'objects'):
        need((source.file.dataflags, source.file._block_info_flags) == (saved.file.dataflags, saved.file._block_info_flags), 'original-bundle-compression')
        need(set(source.file.files) == set(saved.file.files), 'bundle-member-identities')
        for name, f in source.file.files.items():
            if not hasattr(f, 'objects'):
                g = saved.file.files[name]
                need(f.bytes == g.bytes, 'bundle-stream-original:' + name)
    return dict(objects=len(a), selectedObjectIds=sorted(expected), unselectedRawEqual=True, texturesExact=textures,
                externalResourceBindingsEqual=True, originalCompressionAndCABPreserved=True)


def compose(root, manifest_sha, locale, output, resume=False, fail_after=None):
    need(not (output/'manifest.json').exists(), 'published-manifest-immutable')
    need(sha((root/'manifest.json').read_bytes()) == manifest_sha, 'frozen-composition-manifest')
    frozen = read(root/'manifest.json')
    for name, h in frozen['files'].items():
        need(sha(child(root, name).read_bytes()) == h, 'frozen-dependency:' + name)
    c = read(root/'config.json')
    need(locale in c['locales'] and locale in ('pt-BR', 'zh', 'es', 'es-419', 'de', 'ja'), 'explicit-supported-locale')
    need(sys.version == c['python'], 'pinned-python-version')
    need(sha(Path(sys.executable).read_bytes()) == c['pythonExecutableSha256'], 'pinned-python-executable')
    dep = Path(c['engineRoot'])
    need(sha((dep/'manifest.json').read_bytes()) == c['engineManifestSha256'], 'immutable-engine-manifest')
    for name, h in read(dep/'manifest.json')['files'].items():
        need(sha(child(dep, name).read_bytes()) == h, 'immutable-engine-dependency:' + name)
    sys.path.insert(0, str(dep/'vendor')); sys.path.insert(0, str(dep/'engine'))
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    import extract_assets as ex
    from save_tree import save_tree
    inv = module(root/'code/inventory52.py', 'composition_inventory')
    publisher = module(root/'code/locale_resource_publish.py', 'composition_publisher')
    catalog = module(root/'code/addressables_catalog.py', 'composition_catalog')
    g = TypeTreeGenerator('2020.3.24f1'); g.load_local_dll_folder(str(dep/'source/Managed'))
    spec = c['locales'][locale]
    plan = read(root/spec['plan'])
    need(plan['locale'] == locale, 'plan-locale')
    planned = sum((root/'source'/name).stat().st_size for name in spec['assets']) * 3 + 256*1024**2
    need(shutil.disk_usage(root).free - planned >= 5*1024**3, 'five-GiB-reserve-with-planned-writes')
    # Resolve original MonoScript companions BEFORE serializing a large bundle.
    # Candidate Font/TMP files live in a separate input folder; their external
    # script PPtrs still resolve against the frozen original source directory.
    font_trees = {}
    for name, pids in spec.get('fontObjects', {}).items():
        fontenv = UnityPy.load(str(child(root, spec['fontResources'][name])))
        fontenv.path = str(root/'source')
        fonts = objects(fontenv)
        for pid in pids:
            font_trees[(name, pid)] = ex.read_tree(fonts[pid], g)
    face_copies = spec.get('nativeFaceCopies', [])
    face_keys = [(r['asset'], r['pathId']) for r in face_copies]
    need(len(face_keys) == len(set(face_keys)), 'duplicate-native-face-selector')
    need(not set(face_keys) & set(font_trees), 'overlapping-native-font-import')
    for r in face_copies:
        need(r['asset'] in spec['assets'] and (r['inputAsset'], r['inputPathId']) in font_trees, 'native-face-explicit-input')
    files, receipts = {}, []
    for name in spec['assets']:
        source_path = child(root/'source', name)
        original = UnityPy.load(str(source_path)); e = UnityPy.load(str(source_path))
        obs, expected = objects(e), {}
        edits = [r for r in plan['edits'] if r['asset'] == name]
        copies = {r['pathId']: r for r in face_copies if r['asset'] == name}
        ids = sorted({r['pathId'] for r in edits} | set(spec.get('fontObjects', {}).get(name, [])) | set(copies))
        for pid in ids:
            tree = ex.read_tree(obs[pid], g)
            binding = spec.get('dialogueObjects', {}).get(name)
            if binding and binding['pathId'] == pid:
                need(ex.canonical(tree) == read(root/binding['sourceTree']), 'complete-original-dialogue-tree')
            if pid in spec.get('fontObjects', {}).get(name, []):
                tree = font_trees[(name, pid)]
            if pid in copies:
                r = copies[pid]
                tree = native_face_copy(tree, font_trees[(r['inputAsset'], r['inputPathId'])], r)
            direct = [r for r in edits if r['pathId'] == pid and r['kind'] == 'field']
            tree = merged_edits(tree, direct)
            bg = [r for r in edits if r['pathId'] == pid and r['kind'] == 'bg']
            if bg:
                raw, proof = bg_project(tree['m_Script'].encode('utf-8', errors='surrogateescape'), bg, inv)
                tree['m_Script'] = raw.decode('utf-8', errors='surrogateescape'); receipts.append(dict(asset=name, bg=proof))
            expected[pid] = tree
            save_tree(obs[pid], tree, g)
        raw = e.file.save(packer='original') if name.endswith('.bundle') else e.file.save()
        reloaded = UnityPy.load(raw); reloaded.path = str(source_path.parent)
        proof = verify_resource(original, reloaded, expected, ex, g)
        files[name] = raw
        receipts.append(dict(installPath='The Forest of Love_Data/'+name, sourceSha256=sha(source_path.read_bytes()),
            targetSha256=sha(raw), bytes=len(raw), selectedFields=len(edits), **proof))
    # Reuse the accepted catalog algorithm. Its temporary output is task-owned.
    bundle = c['bundle']
    if bundle in files:
        import tempfile
        with tempfile.TemporaryDirectory(prefix='catalog-', dir=root) as td:
            b = Path(td)/'composed.bundle'; b.write_bytes(files[bundle]); cat = Path(td)/'catalog.json'
            proof = catalog.update_catalog(root/'source/StreamingAssets/aa/catalog.json', cat, root/'source'/bundle, b)
            files['StreamingAssets/aa/catalog.json'] = cat.read_bytes(); receipts.append(dict(addressables=proof))
    files['readback.json'] = encode(dict(locale=locale, resources=receipts, scope=plan['scope'],
        preservationRows=plan['preserved'], remaining=plan['remaining'], ready=False, runtime='not-run', nativeAccepted=False))
    manifest = dict(schemaVersion=1, kind='composed-sparse-target-resource-candidate', locale=locale,
        frozenRecipeSha256=manifest_sha, planSha256=sha((root/spec['plan']).read_bytes()),
        dialogueProjection=plan.get('dialogueProjection'),
        outputs={name:dict(sha256=sha(raw), bytes=len(raw)) for name,raw in files.items()},
        sourceCompanions=c['sourceCompanions'], installRoot='The Forest of Love_Data',
        ready=False, applicationAllowed=False, runtime='not-run', visual='not-run',
        independentTechnicalReview='pending-new-composition', remaining=plan['remaining'],
        publicationBoundary='Sequential files then manifest; partial output is not accepted. Resume validates every existing byte. No multi-file installation transaction.')
    def verify(out, marker, payload):
        for name, raw in payload.items(): need(child(out, name).read_bytes() == raw, 'published-byte-parity:' + name)
    # Recheck the entire local closure immediately before the real writer.
    for name, h in frozen['files'].items(): need(sha(child(root, name).read_bytes()) == h, 'input-changed-before-publication:' + name)
    publisher.publish(files, output, Path(c['allowedOutputRoot']), manifest, verify, resume=resume, fail_after=fail_after)
    return dict(locale=locale, changedGameFiles=len(files)-1, selectedFields=len(plan['edits']),
                manifestSha256=sha((output/'manifest.json').read_bytes()), ready=False)


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--delivery', type=Path, required=True); p.add_argument('--manifest-sha256', required=True)
    p.add_argument('--locale', required=True); p.add_argument('--output', type=Path, required=True)
    p.add_argument('--resume', action='store_true'); p.add_argument('--fail-after', type=int)
    a = p.parse_args(); print(json.dumps(compose(a.delivery.resolve(), a.manifest_sha256, a.locale, a.output.resolve(), a.resume, a.fail_after)))
