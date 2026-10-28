"""Compile explicitly authored targets for the shared52-unit inventory increment.

No translation generation, old packet mutation or semantic acceptance. Every
locale must be explicit and already have its own complete authored input.
"""
import argparse
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'localization/source/inventory-display-completion-20261028'
PACKET = ROOT / 'localization/supplemental-ui/20261028-inventory'
GLOSSARY = ROOT / 'localization/glossary/inventory-display-20261028'


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def encoded(value):
    return json.dumps(value, ensure_ascii=False, separators=(',', ':'))


def derive(locale):
    scope = json.loads((SOURCE / 'manifest.json').read_text())
    if not locale or locale not in scope['targetLocales']:
        raise ValueError('An explicit supported locale is required')
    authored = PACKET / (locale + '.authored.json')
    if not authored.is_file():
        raise ValueError('No authored input for the explicitly requested locale')
    # This increment currently has an accepted local glossary handoff only for ru.
    if locale != 'ru':
        raise ValueError('Verified locale glossary handoff is required')
    values = json.loads(authored.read_text())
    assert values['locale'] == locale
    units = [json.loads(line) for line in (SOURCE / 'source.jsonl').read_text().splitlines()]
    assert len(units) == len({r['id'] for r in units}) == 52
    assert set(values) == {'locale', 'itemDescriptions', 'emptyCellStrings'}
    assert set(values['itemDescriptions']) == {str(r['itemType']) for r in units if 'itemType' in r}
    assert set(values['emptyCellStrings']) == {'010c', '0111', '011d', '0122'}
    rows = []
    for unit in units:
        key = str(unit['itemType']) if 'itemType' in unit else unit['offset']
        target = values['itemDescriptions' if 'itemType' in unit else 'emptyCellStrings'][key]
        assert isinstance(target, str) and target.strip() and '\x00' not in target
        assert hashlib.sha256(unit['source'].encode()).hexdigest() == unit['sourceUtf8Sha256']
        # Only existing literal input bindings and quantities are protected here.
        for pattern in [r'\[[^\]]+\]', r'\{[^}]+\}', r'<[^>]+>', r'\b\d+\b']:
            assert re.findall(pattern, target) == re.findall(pattern, unit['source']), ('protected-token', key, pattern)
        rows.append(dict(unit, locale=locale, target=target,
                         sourceSha256=unit['sourceUtf8Sha256'],
                         targetSha256=hashlib.sha256(target.encode()).hexdigest()))
    assert values['itemDescriptions']['120'] == values['itemDescriptions']['450']
    assert values['itemDescriptions']['430'] == values['itemDescriptions']['435']
    handoff = json.loads((GLOSSARY / 'handoff.json').read_text())
    assert handoff['status'] == 'verified-local-Russian-glossary-repair-handoff'
    for name, key in [('en', 'sourceSha256'), ('ru', 'russianSha256')]:
        assert sha(GLOSSARY / (name + '.json')) == handoff[key]
    inputs = [SOURCE / name for name in ['source.jsonl', 'manifest.json', 'approved-preservation.jsonl']]
    inputs += [authored, GLOSSARY / 'en.json', GLOSSARY / 'ru.json', GLOSSARY / 'handoff.json', Path(__file__)]
    binding = json.loads((ROOT / 'CHECKPOINT.json').read_text())['processBinding']
    # Pin current universal process documents without changing old snapshot bindings.
    inputs += [Path(p) for p in binding['references']]
    pins = {str(p): sha(p) for p in inputs}
    data = ''.join(encoded(row) + '\n' for row in rows).encode()
    manifest = dict(schemaVersion=1, locale=locale, sourceUnits=52, descriptions=48,
                    emptyCellStrings=4, status='authored-preflight-complete;semantic-review-pending',
                    targetSha256=hashlib.sha256(data).hexdigest(), inputPins=pins,
                    process='Universal deterministic preflight, complete semantic audit, consolidated correction/dependency closure, independent diff audit and exact correction delta.',
                    applicability='Bounded repair/preparation for the shared complete52-unit inventory family. New local glossary snapshot only; frozen dialogue/old935 inputs and whole-game gates stay separate.',
                    deterministicValidationIsSemanticJudgment=False, wholeGameAccepted=False,
                    atomicity='Two precomputed outputs use individual atomic replacements, not a multi-file transaction; --check must pass after any interruption.')
    return data, (json.dumps(manifest, ensure_ascii=False, indent=2) + '\n').encode()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--locale', required=True)
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    products = derive(args.locale)
    paths = [PACKET / (args.locale + '.jsonl'), PACKET / (args.locale + '.manifest.json')]
    if args.check:
        for path, data in zip(paths, products):
            assert path.read_bytes() == data, ('Nonreproducible target packet', str(path))
    else:
        assert all(not path.exists() for path in paths), 'Reconcile existing target artifacts before writing'
        for path, data in zip(paths, products):
            temporary = path.with_suffix(path.suffix + '.pending')
            temporary.write_bytes(data)
            temporary.replace(path)
    print(encoded(dict(locale=args.locale, units=52, status='verified' if args.check else 'prepared', semanticAcceptance=False)))


if __name__ == '__main__':
    main()
