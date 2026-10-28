"""Reconcile the approved preservation policy and complete shared52-unit increment.

Read-only source verification, then append-only metadata products. No wording is
generated and no frozen corpus, asset, target or old935 packet is modified.
"""
import argparse
import base64
import collections
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'localization/source/inventory-display-completion-20261028'
BASE = 'localization/source/shared-source-completion-20261028/admission-v1/'
PINS = {}


def sha(data):
    return hashlib.sha256(data).hexdigest()


def read(name):
    data = (ROOT / name).read_bytes()
    PINS[name] = {'sha256': sha(data), 'bytes': len(data)}
    return data


def load(name):
    return json.loads(read(name))


def lines(name):
    return [json.loads(line) for line in read(name).decode().splitlines()]


def value_hash(value):
    return sha(json.dumps(value, ensure_ascii=False, separators=(',', ':')).encode())


def derive():
    decision = load('localization/source/source-policy-decision-20261028.json')
    assert decision['status'] == 'owner-approved'
    db = load(BASE + 'dialogue-database-unresolved.json')['values']
    assert len(db) == 1655 and all(r['translationId'] is None for r in db)
    assert sum(r['fieldTitle'] == 'Title' for r in db) == 934
    assert sum(r['fieldTitle'] == 'Description' for r in db) == 5
    policy = [dict(family='dialogue-database', id=r['pointer'],
                   sourceValueSha256=r['sourceValueSha256'], occurrences=r['occurrences'],
                   disposition='owner-approved-preserve-original') for r in db]
    unresolved = load(BASE + 'unresolved-consumers.json')
    groups = {r['index'] for r in unresolved['potentialLabelGroups']}
    serialized = lines(BASE + 'serialized-inventory.jsonl')
    aliases = [r for r in serialized if r['role'] in
               ['potential-display-resource-label', 'potential-display-control-identity']]
    assert all(r['serializedGroupIndex'] in groups for r in aliases)
    assert len(aliases) == 1389
    assert collections.Counter(r['role'] for r in aliases) == {
        'potential-display-resource-label': 1344, 'potential-display-control-identity': 45}
    assert len({r['id'] for r in aliases}) == 1389
    policy += [dict(family='rewired-system', id=r['id'], sourceValueSha256=r['sourceValueSha256'],
                    sourceLine=r['sourceLine'], disposition='owner-approved-preserve-original') for r in aliases]
    selected = {ident for m in unresolved['compiledMethods'] for ident in m['literalIds']}
    literals = lines(BASE + 'managed-literal-inventory.jsonl')
    seeds = [r for r in literals if r['id'] in selected]
    assert len(seeds) == 3 and {r['sourceLine'] for r in seeds} == {331, 332, 4948}
    policy += [dict(family='compiled-technical', id=r['id'], sourceValueSha256=r['sourceValueSha256'],
                    sourceLine=r['sourceLine'], disposition='owner-approved-preserve-original') for r in seeds]
    assert len(policy) == len({(r['family'], r['id']) for r in policy}) == 3047

    cells = lines('localization/source/bgdatabase-complete-values-20261027/verified/cells.jsonl')
    assert len(cells) == 51572
    items = [r for r in cells if r['sheet'] == 'InventoryItem']
    rows = collections.defaultdict(dict)
    for r in items:
        assert r['field'] not in rows[r['rowId']]
        rows[r['rowId']][r['field']] = r
    assert len(rows) == 48 and all(len(row) == 18 for row in rows.values())
    units = []
    for row in sorted(rows.values(), key=lambda r: r['description']['rowIndex']):
        r = row['description']
        assert r['stored'] and isinstance(r['source'], str) and r['source']
        assert base64.b64decode(r['sourceBytesBase64']).decode() == r['source']
        units.append(dict(id=r['id'], family='inventory-description', source=r['source'],
                          sourceUtf8Sha256=sha(r['source'].encode()), sourceValueSha256=value_hash(r['source']),
                          rowId=r['rowId'], rowIndex=r['rowIndex'], fieldId=r['fieldId'],
                          sourceSpan=r['sourceSpan'], itemType=row['item_type']['source'],
                          itemName=row['name']['source'], itemTitle=row['title']['source'],
                          consumer='InventoryInfoTicker.OnCellSelected:arg2 -> tickerText',
                          reachability='complete conservative source family; item400 clears native fields and uses separate glitch TMP; actual selection/quantity branches remain runtime predicates'))
    method = 'System.Void TheForestOfLove.InventoryInfoTicker::OnCellSelected(TheForestOfLove.InventoryCellUiController)'
    trace_name = 'localization/source/inventory-20261026/InventoryInfoTicker.il'
    trace = read(trace_name).decode()
    body = trace.split('METHOD ' + method + '\n', 1)[1].split('\nMETHOD ', 1)[0]
    by_id = {r['id']: r for r in literals}
    for offset, role in [('010c', 'title'), ('0111', 'description'), ('011d', 'title'), ('0122', 'description')]:
        match = re.search(r'^IL_' + offset + r': ldstr (".*")$', body, re.M)
        assert match
        source = json.loads(match[1]);ident = 'il:Assembly-CSharp.dll/' + method + '/IL_' + offset
        assert value_hash(source) == by_id[ident]['sourceValueSha256']
        units.append(dict(id=ident, family='inventory-empty-cell', source=source,
                          sourceUtf8Sha256=sha(source.encode()), sourceValueSha256=value_hash(source),
                          role=role, offset=offset,
                          context='Pair010c/0111 at empty grid(4,3); pair011d/0122 for other empty/unowned cells; consumed/positive-quantity and item405 instance-placeholder branches retain their original predicates.'))
    assert len(units) == len({r['id'] for r in units}) == 52
    profiles = load('localization/fonts/final-corpus-bindings-20261028/profile-sources.json')
    expected = set().union(*(set(profiles[name]['nonemptyDynamicSourceOmissions'])
                            for name in ['inventory-tickerText', 'inventory-itemTitleText']))
    assert {r['id'] for r in units} == expected
    scope = load('localization/supplemental-ui/20261027/locale-scope.json')
    manifest = load('localization/supplemental-ui/20261027/manifest.json')
    assert len(scope['targetLocales']) == len(set(scope['targetLocales'])) == 30
    coverage = []
    for locale in scope['targetLocales']:
        name = 'localization/supplemental-ui/20261027/' + locale + '.jsonl'
        packet = lines(name)
        assert len(packet) == len({r['id'] for r in packet}) == 935
        assert PINS[name]['sha256'] == manifest['locales'][locale]['sha256']
        missing = [r['id'] for r in units if r['id'] not in {p['id'] for p in packet}]
        assert len(missing) == 52
        coverage.append(dict(locale=locale, original935Sha256=PINS[name]['sha256'],
                             additionalSourceIds=missing, targetStatus='not-authored', editorial='not-run'))
    return policy, units, coverage


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    policy, units, coverage = derive()
    PINS[str(Path(__file__).relative_to(ROOT))] = {'sha256': sha(Path(__file__).read_bytes()), 'bytes': Path(__file__).stat().st_size}
    products = {'approved-preservation.jsonl': policy, 'source.jsonl': units,
                'thirty-locale-coverage.json': coverage, 'input-pins.json': PINS}
    products['manifest.json'] = dict(schemaVersion=1, game='The Forest of Love', build='0.45',
        sourceLocale='en', targetLocales=[r['locale'] for r in coverage], sourceUnits=52,
        sourceContentSha256=sha((''.join(json.dumps(r, ensure_ascii=False, separators=(',', ':'))+'\n' for r in units)).encode()),
        preservedPolicySelectors=3047, sourceFamily='complete52-unit inventory display increment',
        status='shared-source-family-reconciled;target-authoring-pending',
        wholeGameSourceAccepted=False, ordinaryWholeGameTranslationEntryAllowed=False,
        boundary='Append-only gap-repair/preparation packet shared by all30 locales. Owner policy is not a model judgment or proof of display absence. Existing source/special-scene/role/font/release gates remain separate.',
        frozen935PacketsChanged=False, readyDialogueChanged=False,
        consumerTraceSha256=PINS['localization/source/inventory-20261026/InventoryInfoTicker.il']['sha256'],
        atomicity='Products are precomputed then written sequentially; not a multi-file transaction. Partial products do not establish completion.')
    if not args.check:
        assert not OUT.exists(), 'Preserve existing output and reconcile it before retrying'
        OUT.mkdir()
    for name, value in products.items():
        data = (''.join(json.dumps(r, ensure_ascii=False, separators=(',', ':'))+'\n' for r in value)
                if name.endswith('.jsonl') else json.dumps(value, ensure_ascii=False, indent=2)+'\n').encode()
        path = OUT / name
        if args.check:
            assert path.read_bytes() == data, ('Reproduction mismatch', name)
        else:
            path.write_bytes(data)
    print(json.dumps(dict(status='verified' if args.check else 'written', policySelectors=3047, sourceUnits=52, locales=30, inputPins=len(PINS))))


if __name__ == '__main__':
    main()
