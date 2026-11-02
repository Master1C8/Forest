"""Bind actual clean Persian primary/product judgments to current authored inputs."""
from pathlib import Path
import hashlib
import importlib.util
import json

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
C = Path('localization/completion/six-next-locales-20261102-01')
W = C / 'closing-wave-01'
O = Path('outputs/six-next-locales-20261102-01')
spec = importlib.util.spec_from_file_location('frozen_helper', ROOT / C / 'delta-wave-01/prepare.py')
h = importlib.util.module_from_spec(spec)
spec.loader.exec_module(h)


def main():
    phase = O / 'fa/independent-delta-02'
    result = h.read(phase / 'result.json')
    terminal = h.read(phase / 'process-exit.json')
    assert terminal['exitCode'] == 0
    h.checked_pins(result['evidence'])
    task = h.read(phase / 'task.json')['task']
    source = {r['id']: r for r in h.rows(h.S / 'source-context.jsonl')}
    preserved = h.read(h.S / 'source-preservation.json')['baselinePreserved']
    language_path = Path('localization/languages/fa.json')
    language = h.read(language_path)
    packet = h.validate_packet(Path(task['reviewPacket']), language, source, 2)
    new = h.validate_reviews(Path(result['reviews']), language, source, 2)
    assert {r['id'] for r in new} == {r['id'] for r in packet}
    ledger = h.read(Path(result['reviews']).parent / 'pending-ledger.json')
    assert ledger['contextComplete'] and not ledger['pendingIds']
    retain = task['retainedIndependent']
    assert h.sha(retain['path']) == retain['sha256']
    retained = h.validate_reviews(Path(retain['path']), language, source, 12823)
    joined = {r['id']: r for r in retained}
    assert not joined.keys() & {r['id'] for r in new}
    joined.update({r['id']: r for r in new})
    assert joined.keys() == source.keys() - preserved.keys()
    assert all(r['verdict'] == 'pass' for r in joined.values())
    case = Path('localization/case-decisions') / C.name / 'fa/repair-02'
    products = {r['productIndex']: r for r in h.rows(case / 'all27-final-products.jsonl')}
    old_products = h.rows(case / 'retained18-original-judgments.jsonl')
    new_products = h.rows(phase / 'haiku-composition-judgments.jsonl')
    assert {r['productIndex'] for r in old_products} == set(range(18))
    assert {r['productIndex'] for r in new_products} == set(range(18, 27))
    assert len(old_products) == 18 and len(new_products) == 9
    for row in old_products + new_products:
        product = products[row['productIndex']]
        assert row['verdict'] == 'pass' and row.get('reviewed') is not False and row.get('reviewerThreadId')
        for field in ('stableIds', 'sourceSha256', 'targetSha256', 'expectedArc'):
            assert row[field] == product[field]
        for field in ('source', 'target'):
            assert hashlib.sha256(product[field].encode()).hexdigest() == product[field + 'Sha256']
        assert product['target'] == '\n'.join(language['translations'][ident]['target'] for ident in product['stableIds'])
        if row['productIndex'] >= 18:
            assert row['syllables'] == [5, 7, 5] and row.get('independentScansion') and row.get('meaningAndNaturalnessRationale')
    output = W / 'integrated/fa-final.jsonl'
    assert not (ROOT / output).exists()
    with (ROOT / output).open('x') as stream:
        for ident in source:
            if ident not in preserved:
                stream.write(json.dumps(joined[ident], ensure_ascii=False) + '\n')
    product_output = W / 'integrated/fa-final-products.jsonl'
    with (ROOT / product_output).open('x') as stream:
        for row in old_products + new_products:
            stream.write(json.dumps(row, ensure_ascii=False) + '\n')
    receipt = dict(locale='fa', languageSha256=h.sha(language_path), independentExactPasses=12825,
                   findings=0, unreadPrimary=0, requiredContextComplete=True,
                   products=dict(total=27, retainedOriginal=18, actualNewIndependent=9, allPassed=True,
                                 path=str(product_output), sha256=h.sha(product_output)),
                   reviews=dict(path=str(output), sha256=h.sha(output)),
                   finalReview=dict(phase=str(phase), terminalReceipt=str(phase / 'process-exit.json'), usage=terminal['usage']),
                   native='not-authorized-not-run', resourceBuild='not-run', release='not-accepted')
    with (ROOT / W / 'final-persian-integration.json').open('x') as stream:
        stream.write(h.encode(receipt))
    print(h.encode(receipt))


if __name__ == '__main__':
    main()
