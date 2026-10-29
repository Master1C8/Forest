"""Source-bound chapter/gallery adapter. No builder integration or editorial promotion.

Normal callers MUST use load_inputs(locale=...). Drafts require both the named
static constructor and static_preflight=True at every application boundary.
All projections are in memory; callers own staging/commit and package validation.
"""
from dataclasses import dataclass
import copy
import hashlib
import json
from pathlib import Path
import re
import struct
import subprocess

from russian_actor_names import encode_cells, replace_columns

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
CASE = 'chapter-titles-and-gallery-hints'
SOURCE = ROOT / 'localization/source/chapter-gallery-case-20261029'
PACKET = ROOT / 'localization/supplemental-ui/20261029-chapter-gallery-case'
MANIFEST_SHA = 'b67d6f728f41f00406d63979dba6ee65bcdc625dd6caede724745f7f99a33287'
# Exact currently supported prior stages, not arbitrary user-supplied DLL hashes.
MANAGED_BEFORE = '13f1febb9cc2adb45ebed2227efbd6eb41f82632d5e199502df96c997fff348d'
SOURCE_PINS = {
    'manifest.json': MANIFEST_SHA,
    'source.jsonl': '0f4cf89d7e3f4ffb78d82fd286f46cea82c5f853259199dfee6afa73a4bdd4e7',
    'absence.jsonl': 'c6b9719f1b854be76c1993759fc98f514cd31429e5eb9d4533eb3585c32ba669',
    'preserve-exactly.jsonl': '88f0dd1868e9b395c7bff93b32b49e89dac910643aec28bd5f882e2497427c79',
    'producer-context.json': '0d7c14c3d860d12270b2748e2c3b4bad8e93c33666148b2fa0c617e65bfa3ecc',
    'case-decision.json': '5746b40a6af754666026a438a7d7ccd2c053f9403e6372bf6f1303e516829250',
    'selection-identities.jsonl': 'ed63eab1550a35372e2962617b1103323f45c30459999ca2fac49fb4af39414c',
    'initial-display-context.jsonl': '10ef9254303f5af4dfc232414fa73ecdf871ead503c9cc7999376c2e06016102',
}
DEPENDENCY_PINS = {
    'localization/glossary/en.json': 'b99ff663f69ca19307691cee8f49b8d33d33f8130a6b51695fceff9449c3b5ab',
    'localization/glossary/ru.json': '355faf2be478ddd9693327ca5fcdc39cae7a8804871abf0dcb426d20434320a0',
    'localization/glossary/inventory-display-20261028/handoff.json': '9e13887b2b05ffcf88d89339cb307b10fbe15e03c9d234ce95542edced14b6ac',
    'localization/source/gallery-chapter-display-20261028/admission-v1/application-design.json': '07de45876859ff29f22661f4825b3959d1378e38ed65bd2599025734f5a06aab',
    'localization/source/gallery-chapter-display-20261028/admission-v1/manifest.json': '1a5a7e3d8b6ef22d6f98220724519bc3912db12851af1a4217eda5211b357fb5',
}


class AdapterError(ValueError):
    pass


def require(ok, reason):
    if not ok:
        raise AdapterError(reason)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def sha(path):
    return digest(Path(path).read_bytes())


def json_bytes(value):
    return (json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(',', ':')) + '\n').encode()


def jsonl(raw):
    return [json.loads(line) for line in raw.decode().splitlines()]


def locale_guard(locale):
    require(locale == 'ru', 'explicit-supported-locale-required')


def _local():
    return Path(__file__).resolve().parent


def _snapshot_pins():
    path = _local() / 'chapter-gallery-inputs.json'
    if not path.exists():
        return None
    pins = json.loads(path.read_text())
    require(pins.get('schemaVersion') == 1, 'snapshot-version')
    for name, expected in pins['files'].items():
        rel = Path(name)
        require(not rel.is_absolute() and '..' not in rel.parts, 'snapshot-path')
        require(sha(_local() / rel) == expected, 'snapshot-pin:' + name)
    return pins


def source_packet():
    snap = _snapshot_pins()
    folder = _local() / 'chapter-gallery-source' if snap else SOURCE
    data = {}
    for name, expected in SOURCE_PINS.items():
        raw = (folder / name).read_bytes()
        require(digest(raw) == expected, 'source-packet-pin:' + name)
        data[name] = raw
    for name, expected in DEPENDENCY_PINS.items():
        path = _local() / 'chapter-gallery-dependencies' / name if snap else ROOT / name
        require(sha(path) == expected, 'dependency-pin:' + name)
    return data


def validate_rows(rows, *, locale, packet=None):
    locale_guard(locale)
    packet = source_packet() if packet is None else packet
    source = jsonl(packet['source.jsonl'])
    require(len(rows) == len({r['id'] for r in rows}) == 134, 'exact134-unique-ids-required')
    targets = {r['id']: r for r in rows}
    require(set(targets) == {r['id'] for r in source}, 'exact134-id-set-required')
    for s in source:
        r = targets[s['id']]
        require(r.get('locale') == locale, 'target-locale:' + s['id'])
        require(r.get('source') == s['source'], 'target-source-binding:' + s['id'])
        require(r.get('sourceSha256') == s['sourceUtf8Sha256'] == digest(r['source'].encode()), 'source-hash:' + s['id'])
        target = r.get('target')
        require(isinstance(target, str) and bool(target.strip()) and '\0' not in target, 'empty-or-invalid-target:' + s['id'])
        require(r.get('targetSha256') == digest(target.encode()), 'target-hash:' + s['id'])
        # This is structural validation only, not an authored wording decision.
        syntax = lambda text: re.findall(r'\{[^{}]*\}|<[^>]*>', text)
        require(syntax(target) == syntax(s['source']), 'protected-template:' + s['id'])
        if s['source'] in ('Movie {0}', 'Story {0}'):
            require(target.endswith(' {0}') and target.count('{0}') == 1, 'identifier-format:' + s['id'])
        if s['source'].startswith("''"):
            require(target.startswith("''") and target.endswith("''") and target.count("'") == 4, 'initial-apostrophe-wrapper:' + s['id'])
    # Source order is canonical; never select by target-supplied selectors/context.
    return [targets[s['id']] for s in source]


@dataclass(frozen=True)
class InputPlan:
    locale: str
    mode: str
    target_bytes: bytes
    packet_bytes: bytes
    acceptance_bytes: bytes

    @property
    def rows(self):
        return json.loads(self.target_bytes)

    @property
    def packet(self):
        return {k: bytes.fromhex(v) for k, v in json.loads(self.packet_bytes).items()}


def _plan(rows, mode, acceptance, locale, packet):
    rows = validate_rows(rows, locale=locale, packet=packet)
    return InputPlan(locale, mode, json_bytes(rows), json_bytes({k: v.hex() for k, v in packet.items()}), json_bytes(acceptance))


def prepare_static_preflight(rows, *, locale):
    """Explicit DRAFT injection. Cannot be used by snapshot()/normal loading."""
    return _plan(rows, 'draft-static-preflight-only', {'targetEditorialAccepted': False}, locale, source_packet())


def load_inputs(*, locale):
    """Reject missing/stale bounded acceptance before any application or write."""
    locale_guard(locale)
    packet = source_packet()
    snap = _snapshot_pins()
    folder = _local() if snap else PACKET
    acceptance_path = folder / ('chapter-gallery-acceptance.json' if snap else 'ru.acceptance.json')
    require(acceptance_path.is_file(), 'bounded-editorial-acceptance-required')
    acceptance = json.loads(acceptance_path.read_bytes())
    require(acceptance.get('status') == 'bounded-russian-editorial-accepted' and acceptance.get('caseId') == CASE and acceptance.get('locale') == locale, 'bounded-case-acceptance-required')
    require(acceptance.get('sourcePins') == SOURCE_PINS and acceptance.get('dependencyPins') == DEPENDENCY_PINS, 'acceptance-input-pins')
    require(acceptance.get('targetEditorialAccepted') is True and acceptance.get('wordingOccurrences') == 134, 'full134-editorial-acceptance-required')
    filename = acceptance.get('targetFile', '')
    require(bool(filename) and Path(filename).name == filename, 'acceptance-target-path')
    target_path = folder / ('chapter-gallery-targets.jsonl' if snap else filename)
    raw = target_path.read_bytes()
    require(digest(raw) == acceptance.get('targetSha256'), 'accepted-target-hash')
    # Require version-bound semantic, independent clean delta and deterministic
    # evidence files. Actual editorial judgment remains owned by the parent.
    evidence = acceptance.get('evidence', {})
    for kind in ('fullSemantic', 'independentCleanDelta', 'finalDeterministic'):
        record = evidence.get(kind, {})
        name = record.get('file', '')
        require(bool(name) and Path(name).name == name, 'acceptance-evidence-path:' + kind)
        path = folder / name
        require(path.is_file() and sha(path) == record.get('sha256'), 'acceptance-evidence-pin:' + kind)
        receipt = json.loads(path.read_bytes())
        require(receipt.get('status') == 'passed' and receipt.get('caseId') == CASE and receipt.get('locale') == locale and receipt.get('targetSha256') == digest(raw) and receipt.get('sourceSha256') == SOURCE_PINS['source.jsonl'], 'acceptance-evidence-version:' + kind)
    return _plan(jsonl(raw), 'editorial-accepted', acceptance, locale, packet)


def _use(plan, locale, static_preflight):
    locale_guard(locale)
    require(isinstance(plan, InputPlan) and plan.locale == locale, 'matching-input-plan-required')
    require(plan.mode == ('draft-static-preflight-only' if static_preflight else 'editorial-accepted'), 'draft-not-accepted-for-build')
    require(set(plan.packet) == set(SOURCE_PINS) and all(digest(raw) == SOURCE_PINS[name] for name, raw in plan.packet.items()), 'input-plan-source-pins')
    if not static_preflight:
        # A caller cannot relabel a draft dataclass to bypass current acceptance.
        require(plan == load_inputs(locale=locale), 'accepted-plan-snapshot-mismatch')
    validate_rows(plan.rows, locale=locale, packet=plan.packet)
    return {r['id']: r for r in plan.rows}, jsonl(plan.packet['source.jsonl'])


def snapshot(folder, *, locale):
    """Only accepted inputs may enter an immutable build recipe snapshot."""
    plan = load_inputs(locale=locale)  # Gate FIRST: failure writes nothing.
    folder = Path(folder)
    require(folder.is_dir() and not (folder / 'chapter-gallery-inputs.json').exists(), 'new-snapshot-required')
    # Read and validate the complete snapshot before creating any destination.
    # Preserve accepted target bytes/hash exactly. Exclusive writes and a final
    # pin manifest expose partial failure; this is not a multi-file transaction.
    is_snapshot = _snapshot_pins() is not None
    current = _local() if is_snapshot else PACKET
    acceptance = json.loads(plan.acceptance_bytes)
    targets = current / ('chapter-gallery-targets.jsonl' if is_snapshot else acceptance['targetFile'])
    files = {'chapter-gallery-targets.jsonl': targets.read_bytes(),
             'chapter-gallery-acceptance.json': plan.acceptance_bytes,
             Path(__file__).name: Path(__file__).read_bytes(),
             'russian_actor_names.py': (_local() / 'russian_actor_names.py').read_bytes()}
    require(digest(files['chapter-gallery-targets.jsonl']) == acceptance['targetSha256'], 'snapshot-target-changed')
    files.update({'chapter-gallery-source/' + name: raw for name, raw in plan.packet.items()})
    for name in DEPENDENCY_PINS:
        src = _local() / 'chapter-gallery-dependencies' / name if is_snapshot else ROOT / name
        raw = src.read_bytes()
        require(digest(raw) == DEPENDENCY_PINS[name], 'snapshot-dependency-changed')
        files['chapter-gallery-dependencies/' + name] = raw
    for record in acceptance['evidence'].values():
        raw = (current / record['file']).read_bytes()
        require(digest(raw) == record['sha256'], 'snapshot-evidence-changed')
        files[record['file']] = raw
    for name in ('Program.cs', 'ChapterGalleryPatch.csproj'):
        files['chapter_gallery_patch/' + name] = (_local() / 'chapter_gallery_patch' / name).read_bytes()
    require(all(not (folder / name).exists() for name in files), 'snapshot-destination-exists')
    for name, raw in files.items():
        path = folder / name
        path.parent.mkdir(parents=True, exist_ok=True)
        with path.open('xb') as stream:
            stream.write(raw)
    with (folder / 'chapter-gallery-inputs.json').open('xb') as stream:
        stream.write(json_bytes({'schemaVersion': 1, 'files': {name: digest(raw) for name, raw in files.items()}}))
    return plan


def project_bg(data, parse, variable_cells, *, locale, expected_before_sha256, plan=None, static_preflight=False):
    plan = load_inputs(locale=locale) if plan is None else plan
    targets, source = _use(plan, locale, static_preflight)
    require(digest(data) == expected_before_sha256, 'bg-before-payload-hash')
    selected = [r for r in source if r['id'].startswith('bgdb:')]
    absent = jsonl(plan.packet['absence.jsonl'])
    before = parse(data)  # Current reparsed offsets; original spans are never used.
    fields, changes, saved, receipts = {}, [], {}, []
    all_states = selected + absent
    for s in before['sheets']:
        for f in s['fields']:
            fields[s['id'], f['id']] = (s, f)
    groups = {}
    for r in all_states:
        groups.setdefault((r['sheetId'], r['fieldId']), []).append(r)
    require(len(groups) == 3 and len(selected) == 113 and len(absent) == 16, 'exact-three-column-scope')
    for key, states in groups.items():
        require(key in fields, 'bg-selected-field-missing')
        sheet, field = fields[key]
        states.sort(key=lambda r: r['rowIndex'])
        require(sheet['name'] == states[0]['sheet'] and field['name'] == states[0]['field'] and field['type'].split(',')[0] == 'BansheeGz.BGDatabase.' + ('BGFieldText' if (sheet['name'], field['name']) == ('Chapter', 'description') else 'BGFieldString'), 'bg-column-schema')
        require(sheet['rowIds'] == [r['rowId'] for r in states] and [r['rowIndex'] for r in states] == list(range(len(states))), 'bg-row-identity-order')
        blob = data[field['valuesOffset']:field['valuesOffset'] + field['valuesBytes']]
        cells, _ = variable_cells(dict(field, valuesHex=blob.hex()), len(states))
        count = struct.unpack_from('<i', blob)[0]
        membership = [struct.unpack_from('<i', blob, 4 + 8 * i)[0] for i in range(count)]
        require(membership == [r['rowIndex'] for r in states if r['source'] is not None], 'bg-sparse-membership')
        for r in states:
            i = r['rowIndex']
            expected = None if r['source'] is None else r['source'].encode()
            require(cells[i] == expected, 'bg-source-before:' + r['id'])
            if expected is not None:
                cells[i] = targets[r['id']]['target'].encode()
                receipts.append({'id': r['id'], 'sourceSha256': digest(expected), 'targetSha256': digest(cells[i])})
        saved[key] = (blob, membership, states)
        changes.append((field, encode_cells(blob, cells)))
    result = replace_columns(data, changes)
    after = parse(result)
    schema = lambda e: [(s['id'], s['name'], s['rowIds'], [(f['id'], f['name'], f['type']) for f in s['fields']]) for s in e['sheets']]
    require(schema(before) == schema(after), 'bg-schema-changed')
    restore, unselected = [], 0
    for old_sheet, new_sheet in zip(before['sheets'], after['sheets']):
        for old, new in zip(old_sheet['fields'], new_sheet['fields']):
            key = old_sheet['id'], old['id']
            blob = result[new['valuesOffset']:new['valuesOffset'] + new['valuesBytes']]
            if key not in saved:
                require(data[old['valuesOffset']:old['valuesOffset'] + old['valuesBytes']] == blob, 'bg-unselected-column')
                unselected += 1
                continue
            prior, membership, states = saved[key]
            count = struct.unpack_from('<i', blob)[0]
            require([struct.unpack_from('<i', blob, 4 + 8 * i)[0] for i in range(count)] == membership, 'bg-readback-sparse-membership')
            cells, _ = variable_cells(dict(new, valuesHex=blob.hex()), len(states))
            for r in states:
                expected = None if r['source'] is None else targets[r['id']]['target'].encode()
                require(cells[r['rowIndex']] == expected, 'bg-target-readback:' + r['id'])
            restore.append((new, prior))
    require(unselected == 286, 'bg-unselected-column-count')
    # Whole byte equality also proves all schema/framing/non-column bytes exact.
    restored = replace_columns(result, restore)
    require(restored == data, 'bg-whole-immediate-prior-restoration')
    return result, {'mode': plan.mode, 'selectedCells': 113, 'absentStates': 16, 'unselectedColumns': unselected,
                    'allUnselectedColumnsByteExact': True, 'fullImmediatePriorPayloadRestored': True,
                    'beforePayloadSha256': digest(data), 'targetPayloadSha256': digest(result), 'readback': receipts}


def native_plan(asset_name, objects, generator, *, locale, expected_asset_sha256, actual_asset_sha256, plan=None, prior=None, static_preflight=False):
    """Merge ONLY /m_text onto current/prior typography plans at exact selectors."""
    from extract_assets import read_tree
    plan = load_inputs(locale=locale) if plan is None else plan
    targets, source = _use(plan, locale, static_preflight)
    require(expected_asset_sha256 == actual_asset_sha256 and bool(re.fullmatch('[0-9a-f]{64}', expected_asset_sha256)), 'native-before-asset-hash')
    require(asset_name in ('sharedassets0.assets', 'sharedassets2.assets'), 'native-exact-asset-required')
    rows = [r for r in source if r['id'].startswith(asset_name + ':')]
    require(len(rows) == (6 if asset_name == 'sharedassets0.assets' else 12), 'native-selected-count')
    merged = copy.deepcopy(prior or {})
    receipts = []
    for r in rows:
        selector = r['physicalSelector']
        asset, pid = selector['object'].split(':')
        pid = int(pid)
        require(asset == asset_name and selector['pointer'] == '/m_text' and r['id'] == f'{asset}:{pid}/m_text', 'native-selector')
        require(pid in objects, 'native-selected-object-missing')
        obj = objects[pid]
        require(obj.path_id == pid and obj.assets_file.name == asset_name, 'native-object-asset-identity')
        require(obj.parse_monobehaviour_head().m_Script.deref().read().m_ClassName == 'TextMeshProUGUI', 'native-class')
        current = read_tree(obj, generator)
        require(current['m_text'] == r['source'], 'native-source-before:' + r['id'])
        target = copy.deepcopy(merged.get(pid, current))
        require(target['m_text'] == r['source'], 'native-prior-text-conflict:' + r['id'])
        before = copy.deepcopy(target)
        target['m_text'] = targets[r['id']]['target']
        compare = copy.deepcopy(target)
        compare['m_text'] = r['source']
        require(compare == before, 'native-nontext-plan-changed')
        merged[pid] = target
        receipts.append({'id': r['id'], 'selectedField': '/m_text', 'sourceSha256': r['sourceUtf8Sha256'], 'targetSha256': targets[r['id']]['targetSha256'], 'runtimeProducerCovered': False})
    return merged, {'mode': plan.mode, 'asset': asset_name, 'beforeAssetSha256': actual_asset_sha256, 'selectedFields': len(rows), 'readbackRequiredAfterSave': True, 'initialOnly': True, 'rows': receipts}


def patch_managed(source, output, receipt, recipe, *, locale, expected_before_sha256, plan=None, static_preflight=False):
    plan = load_inputs(locale=locale) if plan is None else plan
    _use(plan, locale, static_preflight)
    source, output, receipt, recipe = map(Path, (source, output, receipt, recipe))
    require(sha(source) == expected_before_sha256 == MANAGED_BEFORE, 'managed-supported-before-hash')
    require(not output.exists() and not receipt.exists(), 'managed-new-output-required')
    require(recipe.is_dir(), 'managed-recipe-required')
    request = recipe / 'chapter-gallery-request.json'
    require(not request.exists(), 'managed-new-request-required')
    # Cecil verifies these source bytes against hardcoded source packet hashes.
    for name in ('source.jsonl', 'preserve-exactly.jsonl'):
        path = recipe / ('chapter-gallery-' + name)
        require(not path.exists(), 'managed-new-source-request-required')
        path.write_bytes(plan.packet[name])
    request.write_bytes(json_bytes({'caseId': CASE, 'locale': locale, 'mode': plan.mode, 'expectedBeforeSha256': expected_before_sha256,
                                   'targets': [r for r in plan.rows if r['id'].startswith('il:')]}))
    subprocess.run(['dotnet', str(recipe / 'ChapterGalleryPatch.dll'), str(source), str(request), str(output), str(receipt),
                    str(recipe / 'chapter-gallery-source.jsonl'), str(recipe / 'chapter-gallery-preserve-exactly.jsonl')], check=True, capture_output=True)
    result = json.loads(receipt.read_bytes())
    require(result['selectedStrings'] == 3 and result['protectedStrings'] == 10 and result['wholeMethodInventoryReadback'] and result['allOriginalBodiesRestored'] and sha(output) == result['targetSha256'], 'managed-readback-receipt')
    return result
