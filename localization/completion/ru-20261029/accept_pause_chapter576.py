"""Reconcile final Pause/Chapter wording with the separate static-role admission."""
import argparse
import hashlib
import json
from pathlib import Path

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
PACKET = ROOT/'localization/supplemental-ui/20261029-pause-chapter-case576/revision-02'
SOURCE = ROOT/'localization/source/pause-chapter576-binding-contract-20261029.parent-acceptance.json'


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def read(p):
    return json.loads(p.read_text())


def rows(p):
    return [json.loads(line) for line in p.read_text().splitlines()]


def index(rs):
    result = {r['id']:r for r in rs}
    assert len(result) == len(rs), 'duplicate-id'
    return result


def verify(mapping, base):
    for name, info in mapping.items():
        p = Path(name)
        if not p.is_absolute():
            p = ROOT/p if name.startswith(('localization/', 'outputs/', 'tools/', 'assets/')) else base/p
        expected = info['sha256'] if isinstance(info, dict) else info
        assert sha(p) == expected, ('evidence-pin', str(p))


def receipt():
    review = PACKET/'independent-review-01'
    verify(read(PACKET/'input-pins.json'), PACKET)
    verify(read(PACKET/'output-hashes.json'), PACKET)
    verify(read(review/'input-pins.json'), ROOT)
    verify(read(review/'output-manifest.json'), review)
    source = read(SOURCE)
    assert source['status'] == 'bounded-pause-chapter576-role-admission-accepted'
    assert source['boundedSourceRolesAccepted'] and not source['sourceGateAccepted']
    verify(source['evidence'], ROOT)
    targets = index(rows(PACKET/'ru.prepared.jsonl'))
    semantic = index(rows(review/'semantic-receipts.jsonl'))
    natural = index(rows(review/'russian-read-receipts.jsonl'))
    nulls = index(rows(review/'null-context-receipts.jsonl'))
    assert len(targets) == 576
    nonnull = {k for k,r in targets.items() if r['target'] is not None}
    assert semantic.keys() == natural.keys() == nonnull and len(nonnull) == 452
    assert nulls.keys() == targets.keys()-nonnull and len(nulls) == 124
    allowed = set(source['applicationAllowedIds'])
    retained = set(source['retainedAcceptedIds'])
    held = set(source['applicationHeldIds'])
    protected = set(source['protectedIds'])
    assert len(allowed) == 434 and len(retained) == 12 and len(held) == 37 and len(protected) == 93
    assert allowed|retained|held|protected == targets.keys()
    assert sum(map(len, [allowed, retained, held, protected])) == 576
    assert nonnull == allowed|retained|(nonnull&held) and len(nonnull&held) == 6
    for ident in nonnull:
        t = targets[ident]
        assert t['locale'] == 'ru' and not t['targetApplied']
        h = hashlib.sha256(t['target'].encode()).hexdigest()
        assert h == t['targetUtf8Sha256']
        assert semantic[ident]['source'] == t['source']
        for r in [semantic[ident], natural[ident]]:
            assert r['target'] == t['target']
            assert r['sourceValueSha256'] == t['sourceValueSha256']
            assert r['targetUtf8Sha256'] == h and r['verdict'] == 'pass' and not r['findings']
            assert r['technicalBindingSha256'] == t['sourceContractRowSha256']
    result = read(review/'Result.json')
    assert result['objectiveWordingFindings'] == result['proposedDelta'] == 0
    assert result['assigned'] == 576 and result['semanticReviewed'] == result['separateRussianRead'] == 452
    assert result['independentReview'] == 'clean'
    evidence = {str(p.relative_to(ROOT)):sha(p) for p in sorted(PACKET.rglob('*'))
                if p.is_file() and p.name != 'ru.acceptance.json'}
    evidence[str(SOURCE.relative_to(ROOT))] = sha(SOURCE)
    return dict(status='bounded-russian-editorial-accepted', locale='ru', game='The Forest of Love', version='0.45',
                targetEditorialAccepted=True, targetFile='ru.prepared.jsonl', targetSha256=sha(PACKET/'ru.prepared.jsonl'),
                sourceSha256=sha(PACKET/'source-context.jsonl'), assignedOccurrences=576,
                independentlyReviewedNonNullFields=452, separateRussianReadFields=452, reviewedNullContextFields=124,
                applicableStaticFields=434, retainedAcceptedFields=12, applicationHeldFields=37, protectedFields=93,
                heldNonNullWordings=6, exactFinalDelta=[], objectiveWordingFindings=0,
                independentReviewer=result['reviewer'], evidence=evidence,
                reconciliationRecipe=str(Path(__file__).relative_to(ROOT)), reconciliationRecipeSha256=sha(Path(__file__)),
                scope='All452 nonnull literal wordings accepted; application is limited by the separate434/12/37/93 source-role receipt. Six potential UnlockMovies headings retain wording but no application permission.',
                targetApplied=False, actualGameRuntime='not-run', visual='not-run',
                ordinaryTranslationEntryAllowed=False, sourceGateAccepted=False, wholeGameAccepted=False)


if __name__ == '__main__':
    p = argparse.ArgumentParser()
    p.add_argument('--check', action='store_true')
    args = p.parse_args()
    value = receipt()
    output = PACKET/'ru.acceptance.json'
    if args.check:
        assert read(output) == value
    else:
        with output.open('x') as f:
            json.dump(value, f, ensure_ascii=False, indent=2)
            f.write('\n')
    print('Final576 wording accepted;434 new fields eligible,12 retained,37 held,93 protected.')
