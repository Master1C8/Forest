#!/usr/bin/env python3
"""Explicit-locale inventory52 overlay; never installs or launches the game.

Only a frozen delivery with an externally pinned manifest is executable. Editorial
receipts are trusted local review artifacts, not cryptographic attestations.
"""
import argparse
import base64
import copy
import hashlib
import importlib.util
import json
import platform
from pathlib import Path
import struct
import subprocess
import sys
import urllib.parse

LOCAL = Path(__file__).resolve().parent
LOCALES = ('zh', 'es', 'es-419', 'pt-BR', 'ja', 'de')
WIDTHS = {'BGFieldBool': 1, 'BGFieldInt': 4, 'BGFieldEnum': 4,
          'BGFieldFloat': 4, 'BGFieldVector2': 8}


def need(condition, reason):
    if not condition:
        raise ValueError(reason)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def sha(path):
    h = hashlib.sha256()
    with Path(path).open('rb') as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()


def read(path):
    return json.loads(Path(path).read_text(encoding='utf-8'))


def rows(path):
    return [json.loads(line) for line in Path(path).read_text(encoding='utf-8').splitlines()]


def write(path, value):
    Path(path).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')


def child(folder, name):
    need(isinstance(name, str) and name and not Path(name).is_absolute(), 'relative-path-required')
    p = (Path(folder) / name).resolve()
    need(p.is_relative_to(Path(folder).resolve()), 'path-escape')
    return p


def module(name):
    spec = importlib.util.spec_from_file_location('inventory52_' + name, LOCAL / (name + '.py'))
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    return m


def validate_delivery(expected):
    need(sha(LOCAL / 'delivery-manifest.json') == expected, 'delivery-manifest-pin')
    manifest = read(LOCAL / 'delivery-manifest.json')
    need(manifest['schemaVersion'] == 1 and manifest['locales'] == list(LOCALES), 'delivery-schema')
    for name, value in manifest['files'].items():
        need(sha(child(LOCAL, name)) == value, 'delivery-dependency-pin:' + name)
    environment = read(LOCAL / 'environment.json')
    need(sys.version == environment['python'] and sha(sys.executable) == environment['pythonExecutableSha256'] and
         platform.system() == environment['platform'] and platform.machine() == environment['machine'], 'pinned-python-host')
    need(manifest['sourceUnits'] == 52, 'delivery-source-count')
    return manifest


def source_rows():
    source = rows(LOCAL / 'source52.jsonl')
    need(len(source) == len({r['id'] for r in source}) == 52, 'source52-coverage')
    need(sum(r['family'] == 'inventory-description' for r in source) == 48, 'source48-descriptions')
    need(sum(r['family'] == 'inventory-empty-cell' for r in source) == 4, 'source4-literals')
    return source


def validate_packet(folder, *, locale, acceptance_sha, delivery_sha, _fixture=False):
    """Externally pinned acceptance binds every target, review and dependency.

    This new family's initial independent delta is all52. Subsequent wording-only
    repairs may provide retained matching rows plus exact new delta in the merged
    independent ledger. This reader never fabricates semantic judgments.
    """
    need(locale in LOCALES, 'explicit-supported-locale-required')
    validate_delivery(delivery_sha)
    folder = Path(folder)
    need(sha(folder / 'acceptance.json') == acceptance_sha, 'acceptance-pin')
    a = read(folder / 'acceptance.json')
    need(a.get('fixtureOnly') is _fixture, 'fixture-production-boundary')
    need(a['locale'] == locale and a['status'] == 'reviewed-inventory52', 'locale-editorial-acceptance')
    need(a['deliveryManifestSha256'] == delivery_sha, 'acceptance-delivery-binding')
    need(a['sourceSha256'] == sha(LOCAL / 'source52.jsonl'), 'acceptance-source-binding')
    need(a['sourceManifestSha256'] == sha(LOCAL / 'source-manifest.json'), 'acceptance-source-manifest')
    need(a['companionManifestSha256'] == sha(LOCAL / 'companions.json'), 'acceptance-companion-binding')
    need(a['consumerContractSha256'] == sha(LOCAL / 'consumer-contract.json'), 'acceptance-consumer-binding')
    need(a['glossaryLocale'] == locale, 'glossary-locale-binding')
    need(a['semanticReviewer'] and a['independentReviewer'] and
         a['semanticReviewer'] != a['independentReviewer'], 'distinct-reviewers-required')
    for name, expected in a['evidence'].items():
        need(sha(child(folder, name)) == expected, 'editorial-evidence-pin:' + name)
    for key in ('targets', 'semanticReviews', 'independentReviews', 'glossary', 'technicalReview'):
        need(a[key] in a['evidence'], 'unpinned-editorial-input:' + key)
    technical = read(child(folder, a['technicalReview']))
    need(technical.get('fixtureOnly', False) is _fixture and
         technical['status'] == 'accepted-portable-inventory52' and
         technical['deliveryManifestSha256'] == delivery_sha and technical['reviewer'], 'independent-technical-review-required')
    source = source_rows()
    targets = rows(child(folder, a['targets']))
    need([r['id'] for r in targets] == [r['id'] for r in source], 'canonical52-target-order')
    for s, t in zip(source, targets):
        need(t['locale'] == locale, 'foreign-target-locale')
        need(t['source'] == s['source'] and t['sourceSha256'] == s['sourceUtf8Sha256'] == digest(t['source'].encode()), 'target-source-binding:' + s['id'])
        need(isinstance(t['target'], str) and t['target'].strip() and '\0' not in t['target'], 'invalid-target:' + s['id'])
        need(t['targetSha256'] == digest(t['target'].encode()), 'target-hash:' + s['id'])
        # Selectors always come from the immutable source, never target metadata.
        for k in ('family', 'rowId', 'rowIndex', 'fieldId', 'offset', 'role'):
            if k in t:
                need(t[k] == s.get(k), 'target-selector-mismatch:' + k)
    for key, reviewer in [('semanticReviews', a['semanticReviewer']),
                          ('independentReviews', a['independentReviewer'])]:
        review = rows(child(folder, a[key]))
        need(len(review) == len({r['id'] for r in review}) == 52, 'review52-coverage:' + key)
        by_id = {r['id']: r for r in review}
        need(set(by_id) == {r['id'] for r in targets}, 'review52-identities:' + key)
        for t in targets:
            r = by_id[t['id']]
            need(r.get('fixtureOnly', False) is _fixture, 'fixture-review-boundary')
            need(r['locale'] == locale and r['reviewer'] == reviewer, 'review-locale-identity')
            need(r['sourceSha256'] == t['sourceSha256'] and r['targetSha256'] == t['targetSha256'], 'stale-review:' + t['id'])
            need(r['verdict'] == 'pass' and isinstance(r['rationale'], str) and r['rationale'].strip(), 'unclean-review:' + t['id'])
    return [dict(s, target=t['target'], targetSha256=t['targetSha256'], locale=locale)
            for s, t in zip(source, targets)], a


def identity(sheet, row, field):
    quote = lambda value: urllib.parse.quote(value, safe='')
    return 'bgdb:resources.assets:320/sheet/' + quote(sheet) + '/row/' + quote(row) + '/field/' + quote(field)


def inventory(data):
    codec = module('bg_codec')
    env = codec.parse(data)
    states = {}
    for s in env['sheets']:
        for f in s['fields']:
            blob = data[f['valuesOffset']:f['valuesOffset'] + f['valuesBytes']]
            kind = f['type'].split(',')[0].rsplit('.', 1)[-1]
            count = len(s['rowIds'])
            if kind in WIDTHS:
                width = WIDTHS[kind]
                need(len(blob) == count * width, 'fixed-field-width')
                cells = [blob[i * width:(i + 1) * width] for i in range(count)]
            else:
                cells, _ = codec.variable_cells(dict(f, valuesHex=blob.hex()), count)
            for row, value in zip(s['rowIds'], cells):
                key = identity(s['id'], row, f['id'])
                need(key not in states, 'duplicate-bg-id')
                states[key] = value
    need(len(states) == 51572, 'bg51572-coverage')
    return env, states


def independent_inventory(data):
    peer = module('bg_peer')
    env = peer.extract(data)
    states = {}
    ident = lambda h: base64.b64encode(bytes.fromhex(h)).decode()[:22]
    for s in env['tables']:
        for f in s['fields']:
            blob = base64.b64decode(f['valuesBase64'])
            kind = f['type'].split(',')[0].rsplit('.', 1)[-1]
            values = [None] * len(s['rowIds'])
            if kind in WIDTHS:
                width = WIDTHS[kind]
                need(len(blob) == width * len(values), 'peer-fixed-width')
                values = [blob[i * width:(i + 1) * width] for i in range(len(values))]
            elif blob:
                r = peer.Reader(blob)
                pairs = [(r.integer(), r.integer()) for _ in range(r.count())]
                start, previous, seen = r.pos, 0, set()
                for index, end in pairs:
                    need(0 <= index < len(values) and index not in seen and previous <= end <= len(blob) - start, 'peer-cell-range')
                    seen.add(index)
                    values[index] = blob[start + previous:start + end]
                    previous = end
                need(start + previous == len(blob), 'peer-field-consumed')
            for row, value in zip(s['rowIds'], values):
                key = identity(ident(s['id']), ident(row), ident(f['id']))
                need(key not in states, 'peer-duplicate-id')
                states[key] = value
    need(len(states) == 51572, 'peer51572-coverage')
    return states


def replace_column(data, field, blob):
    start = field['valuesOffset']
    return data[:start - 4] + struct.pack('<i', len(blob)) + blob + data[start + field['valuesBytes']:]


def project(data, targets):
    """Data-only primitive; production entry always validates_packet first."""
    codec = module('bg_codec')
    before, states = inventory(data)
    need(states == independent_inventory(data), 'independent-before-readback')
    selected = [r for r in targets if r['family'] == 'inventory-description']
    need(len(selected) == len({r['id'] for r in selected}) == 48, 'projection48-coverage')
    sheet, = [s for s in before['sheets'] if s['name'] == 'InventoryItem']
    field, = [f for f in sheet['fields'] if f['name'] == 'description']
    need(sheet['rowIds'] == [r['rowId'] for r in selected], 'inventory-row-order')
    blob = data[field['valuesOffset']:field['valuesOffset'] + field['valuesBytes']]
    cells, _ = codec.variable_cells(dict(field, valuesHex=blob.hex()), len(sheet['rowIds']))
    for index, r in enumerate(selected):
        need(r['rowIndex'] == index and r['fieldId'] == field['id'] and r['id'] == identity(sheet['id'], r['rowId'], field['id']), 'exact-bg-selector')
        need(cells[index] == r['source'].encode(), 'description-source-state:' + r['id'])
        cells[index] = r['target'].encode()
    count = struct.unpack_from('<i', blob)[0]
    order = [struct.unpack_from('<ii', blob, 4 + 8 * i)[0] for i in range(count)]
    need(len(set(order)) == count == 48, 'description-sparse-order')
    payload, pairs = b'', []
    for index in order:
        payload += cells[index]
        pairs.append(struct.pack('<ii', index, len(payload)))
    projected = replace_column(data, field, struct.pack('<i', count) + b''.join(pairs) + payload)
    after, new = inventory(projected)
    need(new == independent_inventory(projected), 'independent-after-readback')
    expected = dict(states)
    for r in selected:
        expected[r['id']] = r['target'].encode()
    need(new == expected, 'exact-selected-states')
    new_sheet, = [s for s in after['sheets'] if s['name'] == 'InventoryItem']
    new_field, = [f for f in new_sheet['fields'] if f['name'] == 'description']
    need(replace_column(projected, new_field, blob) == data, 'whole-payload-reversal')
    return projected, dict(comparedStates=51572, selectedCells=48, protectedStates=51524,
                          actualChangedCells=sum(states[k] != new[k] for k in states),
                          independentReadback=True, wholePayloadReversed=True,
                          beforePayloadSha256=digest(data), targetPayloadSha256=digest(projected))


def replace_textasset(original, serialized, new_raw):
    """Preserve this exact v22 container's original layout, gaps and metadata.

    UnityPy's no-op save repacks this shipped asset. Instead of accepting that
    change, locate and validate its complete fixed-width object table, then edit
    only object320's size, following offsets and total file size. The same routine
    with the original raw object reverses the entire source container byte-exactly.
    """
    h = serialized.header
    need(h.version == 22 and h.endian == '<' and h.file_size == len(original), 'v22-container-layout')
    objects = list(serialized.objects.values())
    record = lambda o: struct.pack('<qqIi', o.path_id, o.byte_start - h.data_offset, o.byte_size, o.type_id)
    first = record(objects[0])
    start = original.find(first, 48, h.data_offset)
    need(start >= 48 and original.find(first, start + 1, h.data_offset) == -1, 'unique-object-table')
    need(start + len(objects) * 24 <= h.data_offset and
         all(original[start + i * 24:start + (i + 1) * 24] == record(o) for i, o in enumerate(objects)), 'whole-object-table-binding')
    chosen = serialized.objects[320]
    begin, end = chosen.byte_start, chosen.byte_start + chosen.byte_size
    aligned_end = (end + 7) & ~7
    need(begin % 8 == 0 and original[end:aligned_end] == b'\0' * (aligned_end - end), 'selected-object-padding')
    need(all(o.path_id == 320 or o.byte_start + o.byte_size <= begin or o.byte_start >= aligned_end for o in objects), 'nonoverlapping-object-spans')
    padding = (-len(new_raw)) % 8
    replacement = new_raw + b'\0' * padding
    shift = len(replacement) - (aligned_end - begin)
    need(shift % 8 == 0, 'preserve-object-alignment')
    result = bytearray(original[:begin] + replacement + original[aligned_end:])
    struct.pack_into('>q', result, 24, len(result))
    for i, obj in enumerate(objects):
        position = start + i * 24
        if obj.path_id == 320:
            struct.pack_into('<I', result, position + 16, len(new_raw))
        elif obj.byte_start >= aligned_end:
            struct.pack_into('<q', result, position + 8, obj.byte_start - h.data_offset + shift)
    return bytes(result)


def apply(source, output, *, packet, locale, acceptance_sha, delivery_sha, fail_after=None):
    """Write a new two-file overlay plus receipt last. No multi-file transaction.

    Occupied output rejects retry. Interrupted overlays have no Result.json and
    cannot be treated as delivered. Caller reconciles the retained partial output.
    """
    targets, acceptance = validate_packet(packet, locale=locale, acceptance_sha=acceptance_sha, delivery_sha=delivery_sha)
    return _write_overlay(source, output, targets=targets, locale=locale,
                          acceptance_sha=acceptance_sha, delivery_sha=delivery_sha,
                          fail_after=fail_after)


def _write_overlay(source, output, *, targets, locale, acceptance_sha, delivery_sha, fail_after=None, _fixture=False):
    """Internal resource boundary, also exercised with explicitly marked fixtures."""
    need(locale in LOCALES, 'explicit-supported-locale-required')
    source, output = Path(source).resolve(), Path(output).resolve()
    need(not output.exists() and not output.is_relative_to(source) and not source.is_relative_to(output), 'exclusive-disjoint-output-required')
    companions = read(LOCAL / 'companions.json')
    for name, expected in companions.items():
        need(sha(child(source, name)) == expected, 'companion-state:' + name)
    sys.path.insert(0, str(LOCAL / 'vendor'))
    import UnityPy
    need(UnityPy.__version__ == '1.25.4', 'UnityPy-version')
    need(Path(UnityPy.__file__).resolve().is_relative_to(LOCAL / 'vendor'), 'immutable-UnityPy-required')
    env = UnityPy.load(str(source / 'resources.assets'))
    original = {pid: o.get_raw_data() for pid, o in env.file.objects.items()}
    original_bytes = (source / 'resources.assets').read_bytes()
    need(replace_textasset(original_bytes, env.file, original[320]) == original_bytes, 'source-resource-noop')
    obj = env.file.objects[320]
    need(obj.type.name == 'TextAsset', 'bg-textasset-class')
    tree = obj.read_typetree(check_read=True)
    data = tree['m_Script'].encode('utf-8', errors='surrogateescape')
    need(digest(data) == '41834cda2f3ea6f010234f3ca2332e31b95b990ab38a8940b0d92f000477fda9', 'supported-bg-payload')
    projected, bg_receipt = project(data, targets)
    fixed = copy.deepcopy(tree)
    fixed['m_Script'] = projected.decode('utf-8', errors='surrogateescape')
    saved_raw = obj.save_typetree(fixed)
    output.mkdir(parents=True)
    (output / 'resources.assets').write_bytes(replace_textasset(original_bytes, env.file, saved_raw))
    back = UnityPy.load(str(output / 'resources.assets')).file
    need(back.objects.keys() == original.keys(), 'saved-resource-object-set')
    expected_changed = {320} if projected != data else set()
    need({p for p in original if original[p] != back.objects[p].get_raw_data()} == expected_changed, 'saved-resource-exact-change-set')
    back_tree = back.objects[320].read_typetree(check_read=True)
    need(back_tree == fixed, 'saved-textasset-tree')
    saved = back_tree['m_Script'].encode('utf-8', errors='surrogateescape')
    need(saved == projected and independent_inventory(saved) == inventory(projected)[1], 'saved51572-readback')
    need(replace_textasset((output / 'resources.assets').read_bytes(), back, original[320]) == original_bytes, 'whole-resource-reversal')
    if fail_after == 'resource':
        raise RuntimeError('injected-after-resource')
    (output / 'Managed').mkdir()
    empty = [dict(r, sourceSha256=r['sourceUtf8Sha256']) for r in targets if r['family'] == 'inventory-empty-cell']
    write(output / 'empty-targets.json', empty)
    command = ['dotnet', str(LOCAL / 'managed/InventoryDescriptionPatch.dll'),
               str(source / 'Managed/Assembly-CSharp.dll'), companions['Managed/Assembly-CSharp.dll'],
               str(output / 'empty-targets.json'), str(output / 'Managed/Assembly-CSharp.dll'),
               str(output / 'managed-readback.json'), locale]
    subprocess.run(command, check=True, capture_output=True, text=True)
    managed = read(output / 'managed-readback.json')
    need(managed['locale'] == locale and managed['selectedStrings'] == 4 and
         managed['wholeMethodInventoryReadback'] and managed['allOriginalBodiesRestored'] and
         managed['targetSha256'] == sha(output / 'Managed/Assembly-CSharp.dll'), 'managed-readback')
    if fail_after == 'managed':
        raise RuntimeError('injected-after-managed')
    # Recheck the original companions after the save and managed writer complete.
    for name, expected in companions.items():
        need(sha(child(source, name)) == expected, 'source-mutated:' + name)
    result = dict(status='inventory52-static-overlay-verified', locale=locale,
                  fixtureOnly=_fixture,
                  acceptanceSha256=acceptance_sha, deliveryManifestSha256=delivery_sha,
                  bg=bg_receipt, selectedManagedLiterals=4, wholeResourceReversed=True,
                  texturesAndStreams='unchanged raw objects plus externally pinned streams',
                  addressables='bundle bytes, compression, CAB identity and catalog CRC/size unchanged',
                  sourceCompanionsUnchanged=True, companionManifestSha256=sha(LOCAL / 'companions.json'),
                  files={n: sha(output / n) for n in ['resources.assets', 'Managed/Assembly-CSharp.dll']},
                  runtime='not-run', fontAcceptance='not-established', wholeGameAccepted=False,
                  boundary='Two-file additive overlay; receipt last; no rollback or installation. Exact original0.45 companions only.')
    write(output / 'Result.json', result)
    return result


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--source', type=Path, required=True)
    p.add_argument('--output', type=Path, required=True)
    p.add_argument('--packet', type=Path, required=True)
    p.add_argument('--locale', choices=LOCALES, required=True)
    p.add_argument('--acceptance-sha256', required=True)
    p.add_argument('--delivery-sha256', required=True)
    a = p.parse_args()
    print(json.dumps(apply(a.source, a.output, packet=a.packet, locale=a.locale,
                           acceptance_sha=a.acceptance_sha256, delivery_sha=a.delivery_sha256)))


if __name__ == '__main__':
    main()
