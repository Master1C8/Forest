"""Reconcile the reported omission families without changing translation inputs.

Uses the complete, existing BGDatabase ledger; does not decode it again. Reads
only the original sharedassets2 UI bindings. No game execution or image input.
"""
import argparse
import base64
import hashlib
import json
from pathlib import Path

import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from UnityPy.classes import PPtr
from extract_assets import read_tree, canonical

ROOT = Path(__file__).resolve().parents[1]
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
OUT = ROOT / 'localization/source/pause-inventory-bio-omissions-20261028'
PREFIXES = ('LevelSingletons/PauseScreenUI',
            'LevelSingletons/MasterLog/CritterLog')


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def collect_ui():
    pins = json.loads((ROOT / 'assets/source-v2/source-files.json').read_text())
    for name in ('sharedassets2.assets', 'Managed/Assembly-CSharp.dll'):
        assert sha(DATA / name) == pins[name]['sha256'], ('original-source', name)
    env = UnityPy.load(str(DATA / 'sharedassets2.assets'))
    objects = {obj.path_id: obj for obj in env.objects}
    gen = TypeTreeGenerator('2020.3.24f1')
    gen.load_local_dll_folder(str(DATA / 'Managed'))
    cache, classes, paths, parents = {}, {}, {}, {}

    def tree(pid):
        if pid not in cache:
            cache[pid] = read_tree(objects[pid], gen)
        return cache[pid]

    def script(pid):
        return objects[pid].parse_monobehaviour_head().m_Script.deref().read()

    def cls(pid):
        if pid not in classes:
            classes[pid] = (script(pid).m_ClassName if objects[pid].type.name == 'MonoBehaviour'
                            else objects[pid].type.name)
        return classes[pid]

    def path(go):
        if go not in paths:
            value = tree(go)
            transforms = [c['component']['m_PathID'] for c in value['m_Component']
                          if objects[c['component']['m_PathID']].type.name in ('Transform', 'RectTransform')]
            assert len(transforms) == 1
            parent = tree(transforms[0])['m_Father']['m_PathID']
            parents[go] = tree(parent)['m_GameObject']['m_PathID'] if parent else None
            paths[go] = (path(parents[go]) + '/' if parent else '') + value['m_Name']
        return paths[go]

    def base(pid, value, hierarchy):
        go = value['m_GameObject']['m_PathID']
        ancestors, current = [], go
        while current is not None:
            path(current)
            ancestors.append(dict(pathId=current, name=tree(current)['m_Name'],
                                  activeSelf=bool(tree(current)['m_IsActive'])))
            current = parents[current]
        return dict(pathId=pid, hierarchy=hierarchy, kind=cls(pid),
                    componentEnabled=bool(value.get('m_Enabled', True)),
                    ancestors=ancestors, rawSha256=hashlib.sha256(objects[pid].get_raw_data()).hexdigest())

    texts, images, controllers = [], [], []
    for pid in sorted(objects):
        if objects[pid].type.name != 'MonoBehaviour':
            continue
        kind = cls(pid)
        head = objects[pid].parse_monobehaviour_head()
        go = head.m_GameObject.path_id
        if not go:
            continue
        hierarchy = path(go)
        if not any(hierarchy == prefix or hierarchy.startswith(prefix + '/') for prefix in PREFIXES):
            continue
        if kind not in ('Text', 'TextMeshProUGUI', 'Image') and not script(pid).m_AssemblyName.startswith('Assembly-CSharp'):
            continue
        value = tree(pid)
        if kind in ('Text', 'TextMeshProUGUI'):
            field = 'm_Text' if kind == 'Text' else 'm_text'
            row = base(pid, value, hierarchy)
            row.update(id=f'sharedassets2.assets:{pid}/{field}', field=field,
                       source=value[field], serialized=canonical(value))
            texts.append(row)
        elif kind == 'Image':
            row = base(pid, value, hierarchy)
            ref = value['m_Sprite']
            row['sprite'] = ref
            if ref['m_PathID']:
                obj = PPtr(**ref, assetsfile=objects[pid].assets_file).deref()
                sprite = obj.read()
                row.update(spriteName=sprite.m_Name, spriteFile=obj.assets_file.name,
                           spritePathId=obj.path_id,
                           spriteRawSha256=hashlib.sha256(obj.get_raw_data()).hexdigest())
            images.append(row)
        elif script(pid).m_AssemblyName.startswith('Assembly-CSharp'):
            row = base(pid, value, hierarchy)
            row['fields'] = canonical(value)
            controllers.append(row)
    return dict(schemaVersion=1, scope=list(PREFIXES),
                sourcePins={name: pins[name]['sha256'] for name in ('sharedassets2.assets', 'Managed/Assembly-CSharp.dll')},
                texts=texts, images=images, controllers=controllers,
                activityMeaning='Serialized activeSelf is not runtime reachability. Component enabled and all ancestor states are retained separately; no sprite is classified as the displayed label from its name alone.')


def collect_cells():
    ledger = ROOT / 'localization/source/bgdatabase-complete-values-20261027/verified/cells.jsonl'
    rows = [json.loads(line) for line in ledger.read_text().splitlines()]
    assert len(rows) == 51572 and len({r['id'] for r in rows}) == len(rows)
    selected = [r for r in rows if (r['sheet'], r['field']) in
                {('InventoryItem', 'description'), ('BioKeyword', 'bio_text')}]
    assert len(selected) == 159 and all(r['stored'] for r in selected)
    assert sum(r['sheet'] == 'InventoryItem' for r in selected) == 48
    assert sum(r['sheet'] == 'BioKeyword' for r in selected) == 111
    protected = [r for r in rows if r['sheet'] in ('InventoryItem', 'BioKeyword') and r not in selected]
    assert len(protected) == 1149
    payload = ROOT / 'assets/source-v2/text-assets/90744c19ec-resources.assets-320.bin'
    data = payload.read_bytes()
    assert sha(payload) == '41834cda2f3ea6f010234f3ca2332e31b95b990ab38a8940b0d92f000477fda9'
    restored = bytearray(data)
    present = absent = 0
    for row in selected + protected:
        if not row['stored']:
            assert row['sourceSpan'] is None and row['sourceBytesBase64'] is None
            absent += 1
            continue
        span = row['sourceSpan']; start = span['offset']; end = start + span['bytes']
        original = base64.b64decode(row['sourceBytesBase64'], validate=True)
        assert data[start:end] == original, ('source-span-readback', row['id'])
        if row in selected:
            assert original.decode('utf-8') == row['source']
        restored[start:end] = original
        present += 1
    assert bytes(restored) == data
    return dict(schemaVersion=1, ledger=str(ledger.relative_to(ROOT)), ledgerSha256=sha(ledger),
                sourceStates=selected, preserveExactly=protected,
                readback=dict(stored=present, absent=absent, wholePayloadRestoredExactly=True),
                acceptance='Source reconciliation only. These are candidates pending the owning shared source/special-scene gate; no new accepted translation IDs or target wording.')


def reconcile(ui, cells):
    packet = ROOT / 'localization/supplemental-ui/20261027'
    catalog = json.loads((packet / 'source-catalog.json').read_text())
    manifest = json.loads((packet / 'manifest.json').read_text())
    scope = json.loads((packet / 'locale-scope.json').read_text())
    assert sha(packet / 'source-catalog.json') == manifest['sourceCatalogSha256']
    old = catalog['units']; old_ids = [r['id'] for r in old]
    assert len(old_ids) == len(set(old_ids)) == 935
    by_source = {}
    for row in old:
        by_source.setdefault(row['source'], []).append(row['id'])
    candidates, protected_ui, dynamic = [], [], []
    for row in ui['texts']:
        if row['hierarchy'].startswith(PREFIXES[0]):
            if row['source'] in ('+', '++', '+++', '++++', '\u200b'):
                protected_ui.append(dict(id=row['id'], source=row['source'],
                                         reason='Existing report-control markers / empty-input sentinel, not prose.'))
            else:
                candidates.append(dict(id=row['id'], family='pause-ui', source=row['source'],
                                       context=row['hierarchy'],
                                       existingEqualSourceIds=by_source.get(row['source'], [])))
        elif row['pathId'] in (14193, 17708):
            assert row['componentEnabled'] and row['source'] in ('Kinks', 'Notes')
            candidates.append(dict(id=row['id'], family='critter-heading', source=row['source'], context=row['hierarchy']))
        else:
            dynamic.append(dict(id=row['id'], source=row['source'],
                                reason='Runtime-populated resident template / masked BioDetail or fragment field; localize its original data producer, not the serialized example.'))
    assert len(protected_ui) == 25 and len(dynamic) == 24
    assert sum(r['family'] == 'pause-ui' for r in candidates) == 448
    for row in cells['sourceStates']:
        if row['sheet'] == 'BioKeyword' and row['source'] == '???':
            continue
        candidates.append(dict(id=row['id'], family='inventory-description' if row['sheet'] == 'InventoryItem' else 'bio-keyword',
                               source=row['source'], rowIndex=row['rowIndex']))
    classification_path = ROOT / 'localization/source/inventory-20261026/literal-classification.json'
    literals = json.loads(classification_path.read_text())
    literals = [r for r in literals['rows'] if 'InventoryInfoTicker::OnCellSelected(' in r['method'] and r['role'] == 'visible']
    assert len(literals) == 4
    for row in literals:
        candidates.append(dict(id=f"il:Assembly-CSharp.dll/{row['method']}/{row['offset']}",
                               family='inventory-empty-slot', source=row['value'],
                               context=row['reason']))
    ids = [r['id'] for r in candidates]
    assert len(ids) == len(set(ids)) == 612 and not set(ids).intersection(old_ids)
    family_counts = {family: sum(r['family'] == family for r in candidates) for family in sorted({r['family'] for r in candidates})}
    locales = scope['targetLocales']
    assert len(locales) == len(set(locales)) == 30 and 'en' not in locales
    coverage = []
    for locale in locales:
        path = packet / f'{locale}.jsonl'
        assert sha(path) == manifest['locales'][locale]['sha256']
        rows = [json.loads(line) for line in path.read_text().splitlines()]
        assert [r['id'] for r in rows] == old_ids
        assert [r['source'] for r in rows] == [r['source'] for r in old]
        present = set(ids).intersection(r['id'] for r in rows)
        coverage.append(dict(locale=locale, existingUnits=935, artifactSha256=sha(path),
                             newCandidateStates=612, candidatesPresent=len(present),
                             candidatesAbsent=612-len(present), translationStatus='not-started-source-gate',
                             sourceFamilyAcceptance='needs-review', runtime='not-run'))
    return dict(schemaVersion=1, candidates=candidates, familyCounts=family_counts,
                protectedUi=protected_ui, runtimePopulatedUi=dynamic,
                retainedSourceLiteral=[r['id'] for r in cells['sourceStates'] if r['source'] == '???'],
                priorSourceCatalogSha256=sha(packet / 'source-catalog.json'),
                priorManifestSha256=sha(packet / 'manifest.json'),
                locales=coverage, targetLocaleCount=30,
                acceptance='Candidate inventory / gap accounting, NOT canonical source acceptance or translated coverage. Existing 935-unit packets, frozen dialogue and all live lanes remain unchanged.')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    ui, cells = collect_ui(), collect_cells()
    products = {'ui-bindings.json': ui, 'database-fields.json': cells,
                'coverage.json': reconcile(ui, cells)}
    OUT.mkdir(parents=True, exist_ok=True)
    for name, value in products.items():
        data = (json.dumps(value, ensure_ascii=False, indent=2) + '\n').encode()
        target = OUT / name
        if args.check or target.exists():
            assert target.read_bytes() == data, ('source-output-drift', name)
        else:
            with target.open('xb') as stream:
                stream.write(data)
    print(json.dumps({'texts': len(products['ui-bindings.json']['texts']),
                      'images': len(products['ui-bindings.json']['images']),
                      'controllers': len(products['ui-bindings.json']['controllers']),
                      'databaseStates': 159, 'protectedDatabaseStates': 1149,
                      'newCandidateStatesPerLocale': 612, 'localesChecked': 30}))


if __name__ == '__main__':
    main()
