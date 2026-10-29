"""Reconcile two completed Russian wording reviews; never applies game text."""
import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path

ROOT = Path('/Users/antonkrutov/Desktop/Forest')


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def read(p):
    return json.loads(p.read_text())


def rows(p):
    return [json.loads(l) for l in p.read_text().splitlines()]


def index(rs, key):
    result = {r[key]: r for r in rs}
    assert len(result) == len(rs), ('duplicate-id', key)
    return result


def verify_map(mapping, base):
    for name, expected in mapping.items():
        p = Path(name)
        if not p.is_absolute():
            p = ROOT/p if name.startswith(('localization/', 'outputs/', 'tools/')) else base/p
        assert sha(p) == expected, ('stale-evidence', str(p))


def acceptance(case):
    folder = ROOT/'localization/supplemental-ui'/('20261029-'+case)
    review = folder/'independent-review-01'
    verify_map(read(review/'output-hashes.json'), review)
    if case == 'counter-case90':
        pins = read(review/'pin-verification.json')
        assert pins['allMatch']
        for r in pins['checks']:
            p = Path(r['path'])
            if not p.is_absolute():
                p = ROOT/p
            assert r['match'] and sha(p) == r['expected'], ('input-pin', str(p))
    else:
        verify_map(read(review/'reviewed-input-hashes.json'), folder)

    targets = index(rows(folder/'ru.prepared.jsonl'), 'id' if case == 'counter-case90' else 'unitId')
    source = index(rows(folder/'source-context.jsonl'), 'id')
    mapping = index(rows(folder/'mapping.jsonl'), 'id' if case == 'counter-case90' else 'bindingId')
    assert source.keys() == mapping.keys()
    assert all(r['locale'] == 'ru' for r in targets.values())
    semantic = index(rows(review/'semantic-receipts.jsonl'), 'id' if case == 'counter-case90' else 'unitId')
    natural_name = 'natural-russian-receipts.jsonl' if case == 'counter-case90' else 'native-russian-receipts.jsonl'
    natural = index(rows(review/natural_name), 'id' if case == 'counter-case90' else 'unitId')
    result = read(review/'Result.json')
    assert result['objectiveWordingFindings'] == 0
    assert not result['targetApplied'] and not result['wholeGameAccepted']

    if case == 'counter-case90':
        closure = read(folder/'review-closure.json')
        selected = set(closure['closureIds'])
        assert len(source) == 90 and len(targets) == 29 and len(selected) == 16
        assert semantic.keys() == natural.keys() == selected
        for name in ['author-semantic-audit.jsonl', 'native-russian-read.jsonl']:
            author = index(rows(folder/name), 'id')
            assert author.keys() == selected
            assert all(author[k]['targetUtf8Sha256'] == targets[k]['targetUtf8Sha256'] for k in selected)
        assert len(closure['retainedExactAcceptedIds']) == 13
        assert len(closure['protectedComponentIds']) == 61
        holds = read(review/'source-holds.json')
        assert holds['nullCount'] == 11 and holds['allHoldsRetained']
        assert all(r['target'] is None for r in holds['nullProducerFixtures'])
        counts = dict(assignedOccurrences=90, displayUnits=29,
                      newIndependentSemanticRows=16, separateNativeReadRows=16,
                      retainedAcceptedRows=13, protectedContextMembers=61,
                      sourceHeldProducerFixtures=11)
        scope = 'All16 new stored captions plus13 exact prior wording reuses. Dynamic producer joins and source eligibility remain conditional.'
    else:
        assert len(source) == 569 and len(targets) == 98
        assert semantic.keys() == natural.keys() == targets.keys()
        selected = {k for k,r in targets.items() if r['target'] is not None}
        assert len(selected) == 85
        assert Counter(k for r in targets.values() for k in r['memberIds']) == Counter(source.keys())
        for name in ['author-semantic-audit.jsonl', 'native-russian-read.jsonl']:
            versions = index([v for r in rows(folder/name) for v in r['reviewedVersions']], 'unitId')
            assert versions.keys() == targets.keys()
            for k,v in versions.items():
                assert v['sourceAssembledValueSha256'] == targets[k]['sourceAssembledValueSha256']
                assert v['targetUtf8Sha256'] == targets[k]['targetUtf8Sha256']
        holds = read(review/'source-adapter-holds.json')
        held = {r['unitId'] for r in holds['records']}
        assert len(holds['records']) == 35 and len(held) == 32
        for k in targets.keys() - selected:
            assert semantic[k]['status'] == 'source-read-null-target-held'
            assert natural[k]['status'] == 'not-applicable-null-target'
        counts = dict(assignedOccurrences=569, completeUnits=98,
                      independentlyReviewedNonNullUnits=85, separateNativeReadUnits=85,
                      newPreparedUnits=70, retainedAcceptedUnits=15,
                      retainedAcceptedMemberships=120, nullSourceHeldUnits=13,
                      sourceAdapterHoldRecords=35, uniqueSourceAdapterHeldUnits=32,
                      unitsWithoutRecordedSourceAdapterHold=66, assembledFixtures=490)
        scope = 'Literal wording of all85 nonnull complete groups.13 null units and35 source/adapter predicates on32 groups remain unaccepted for application.'

    for k in selected:
        target = targets[k]
        assert hashlib.sha256(target['target'].encode()).hexdigest() == target['targetUtf8Sha256']
        for receipt in [semantic[k], natural[k]]:
            assert receipt['target'] == target['target']
            assert receipt['targetUtf8Sha256'] == target['targetUtf8Sha256']
            assert receipt['status'].startswith(('pass-', 'passed-'))
        expected_source = target.get('sourceValueSha256', target.get('sourceAssembledValueSha256'))
        assert semantic[k]['sourceValueSha256'] == expected_source

    evidence = {}
    for base in [folder, review]:
        for f in sorted(base.iterdir()):
            if f.is_file() and f.name != 'ru.acceptance.json':
                evidence[str(f.relative_to(ROOT))] = sha(f)
    return dict(status='bounded-russian-editorial-accepted', locale='ru', game='The Forest of Love',
                version='0.45', scope=scope, **counts,
                targetEditorialAccepted=True, targetFile='ru.prepared.jsonl',
                targetSha256=sha(folder/'ru.prepared.jsonl'), sourceSha256=sha(folder/'source-context.jsonl'),
                independentReviewer=result['reviewer'], exactFinalDelta=[], objectiveWordingFindings=0,
                evidence=evidence, reconciliationRecipe=str(Path(__file__).relative_to(ROOT)),
                reconciliationRecipeSha256=sha(Path(__file__)),
                dynamicProducerAccepted=False, sourceAdapterAccepted=False,
                targetApplied=False, actualGameRuntime='not-run', visual='not-run',
                specialCaseDecisionGateAccepted=False, ordinaryTranslationEntryAllowed=False,
                sourceGateAccepted=False, wholeGameAccepted=False)


if __name__ == '__main__':
    p = argparse.ArgumentParser()
    p.add_argument('--check', action='store_true')
    args = p.parse_args()
    # Validate both complete packets before writing either receipt. Publication is
    # still two exclusive file writes; it is not a multi-file transaction.
    receipts = {case: acceptance(case) for case in ['counter-case90', 'ornamental-case569']}
    for case, receipt in receipts.items():
        output = ROOT/'localization/supplemental-ui'/('20261029-'+case)/'ru.acceptance.json'
        if args.check:
            assert read(output) == receipt, ('acceptance-drift', case)
        else:
            with output.open('x') as f:
                json.dump(receipt, f, ensure_ascii=False, indent=2)
                f.write('\n')
        print(case, 'verified' if args.check else 'accepted-stored-wording-only')
