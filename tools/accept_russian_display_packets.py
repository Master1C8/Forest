#!/usr/bin/env python3
"""Bind completed independent wording receipts without granting runtime gates."""
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PACKETS = (
    ('bio113', '20261029-bio-case113', 113, 112, 0, 1),
    ('input72', '20261029-input-case72', 72, 70, 2, 0),
    ('console62', '20261029-console-case62', 62, 62, 0, 0),
)


def read(p):
    return json.loads(p.read_text())


def rows(p):
    return [json.loads(line) for line in p.read_text().splitlines()]


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def utf8(s):
    return hashlib.sha256(s.encode()).hexdigest()


def main():
    outputs = []
    for slug, folder, total, new, reused, symbols in PACKETS:
        packet = ROOT / 'localization/supplemental-ui' / folder
        review = ROOT / 'outputs' / ('ru-' + slug + '-independent-20261029/check')
        result = read(review / 'Result.json')
        assert result['status'] == 'finite-russian-' + slug + '-independent-review-complete'
        identity = read(review / 'review-ids.json')
        for name, digest in identity['sha256'].items():
            assert sha(packet / name) == digest, name
        targets = rows(packet / 'ru.prepared.jsonl')
        ix = {r.get('id', r.get('bindingId')): r for r in targets}
        assert len(ix) == len(targets) == total
        semantic = rows(review / 'reviews.jsonl')
        native = rows(review / 'native-read.jsonl')
        retained = rows(review / 'retained-context.jsonl')
        symbolic_native = [r for r in native if r.get('newWordingCredit') is False]
        assert len(symbolic_native) == symbols
        for r in symbolic_native:
            t = ix[r['id']]
            assert r['verdict'] == 'preserve-symbol-context'
            assert t['source'] == t['target']
            assert r['sourceUtf8Sha256'] == r['targetUtf8Sha256'] == utf8(t['source'])
        native = [r for r in native if r.get('newWordingCredit') is not False]
        assert len(semantic) == len(native) == new
        seen = set()
        for receipts in (semantic, native):
            ids = set()
            for r in receipts:
                t = ix[r['id']]
                assert r['sourceValueSha256'] == t['sourceValueSha256']
                assert r['sourceUtf8Sha256'] == utf8(t['source'])
                assert r['targetUtf8Sha256'] == utf8(t['target'])
                assert r['verdict'] == 'pass' and not r.get('findings')
                ids.add(r['id'])
            assert len(ids) == new
            if seen:
                assert ids == seen
            seen = ids
        remainder = set(ix) - seen
        assert len(remainder) == reused + symbols
        for ident in remainder:
            receipts = [r for r in retained if r['id'] == ident]
            assert len(receipts) == 1
            r, t = receipts[0], ix[ident]
            assert r['verdict'] in ('preserved', 'retained-pass')
            if t['source'] == t['target']:
                assert symbols == 1 and t['status'] == 'prepared-preserve-symbol'
            else:
                assert t['status'] == 'reused' and t['reuseReference']
                prior = t['reuseReference']
                old = rows(ROOT / prior['path'])[prior['line'] - 1]
                assert old['id'] == prior['targetId'] == ident
                assert old['source'] == t['source'] and old['target'] == t['target']
                assert prior['sourceValueSha256'] == t['sourceValueSha256']
                assert prior['targetUtf8Sha256'] == utf8(old['target'])
                if 'sourceValueSha256' in old:
                    assert old['sourceValueSha256'] == t['sourceValueSha256']
        findings = read(review / 'findings.json')
        assert not findings.get('objectiveFindings', findings.get('objectiveWordingFindings', findings.get('findings')))
        assert not findings['proposedReplacements']
        evidence = {}
        for p in (review / 'Result.json', review / 'reviews.jsonl', review / 'native-read.jsonl',
                  review / 'retained-context.jsonl', review / 'coverage.json', review / 'findings.json',
                  review / 'input-pins.json', review / 'runtime-check.json', packet / 'source-context.jsonl',
                  packet / 'ru.prepared.jsonl', packet / 'input-pins.json'):
            evidence[str(p.relative_to(ROOT))] = sha(p)
        acceptance = {
            'status': 'bounded-russian-conditional-wording-accepted' if slug == 'console62' else 'bounded-russian-editorial-accepted',
            'locale': 'ru', 'assignedOccurrences': total, 'newIndependentSemanticRows': new,
            'newSeparateNativeReadRows': new, 'retainedAcceptedRows': reused,
            'preservedAssignedSymbols': symbols, 'targetEditorialAccepted': True,
            'targetFile': 'ru.prepared.jsonl', 'targetSha256': sha(packet / 'ru.prepared.jsonl'),
            'sourceSha256': sha(packet / 'source-context.jsonl'), 'evidence': evidence,
            'objectiveWordingFindings': 0, 'repairBatch': [], 'exactFinalDelta': [],
            'remainingTechnicalFindings': str((review / 'findings.json').relative_to(ROOT)),
            'applicationAdmitted': False, 'targetApplied': False, 'runtime': 'not-run',
            'ordinaryTranslationEntryAllowed': False, 'sourceGateAccepted': False, 'wholeGameAccepted': False,
            'boundary': 'Exact independent semantic and separate native-language receipts accepted. Protected/potential context is not new wording coverage. Source eligibility, display/cache/input identity, reinsertion, resources and native execution remain separate.',
        }
        path = packet / 'ru.acceptance.json'
        assert not path.exists(), 'Reconcile existing receipt before retry: ' + str(path)
        outputs.append((path, acceptance))
    # Validate the whole finite set before writing. Each exclusive file write
    # is independent: interruption may leave a partial set, never a transaction.
    for path, value in outputs:
        with path.open('x') as out:
            json.dump(value, out, ensure_ascii=False, indent=2)
            out.write('\n')
        assert read(path) == value
        print(json.dumps({'packet': path.parent.name, 'status': value['status'],
                          'newIndependent': value['newIndependentSemanticRows']}))


if __name__ == '__main__':
    main()
