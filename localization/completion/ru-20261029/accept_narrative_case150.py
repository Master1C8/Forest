"""Adopt exact narrative-page wording receipts, retaining five source holds."""
from collections import Counter
import argparse
import hashlib
import json
from pathlib import Path

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
PACKET = ROOT/'localization/supplemental-ui/20261029-narrative-case150'


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def read(p):
    return json.loads(p.read_text())


def index(name):
    rs = [json.loads(line) for line in (PACKET/name).read_text().splitlines()]
    result = {r['id']:r for r in rs}
    assert len(result) == len(rs), ('duplicate', name)
    return result


def pins(mapping, base):
    for name, info in mapping.items():
        p = Path(name)
        if not p.is_absolute():
            p = ROOT/p if name.startswith(('localization/', 'outputs/', 'tools/', 'assets/')) else base/p
        assert sha(p) == info['sha256'] and p.stat().st_size == info['bytes'], name


def receipt():
    closure = read(PACKET/'review-cycle-01/closure-manifest.v2.json')
    pins(closure['artifacts'], PACKET)
    pins(closure['cycleFiles'], PACKET/'review-cycle-01')
    pins(closure['codePins'], ROOT/'outputs/ru-narrative150-case-wording-20261029')
    inputs = ROOT/closure['inputPinsPath']
    assert sha(inputs) == closure['inputPinsSha256']
    pins(read(inputs), ROOT)
    review = PACKET/'independent-review-01'
    pins(read(review/'output-manifest.json')['files'], review)
    result = read(review/'Result.json')
    assert result['cleanIndependentWordingReview'] and result['wordingDefects'] == 0
    assert result['missingRequiredFiniteSelectors'] == 0 and not result['all25TranslationAccepted']
    assert sha(PACKET/'ru.prepared.jsonl') == result['preparedSha256']
    targets = index('ru.prepared.jsonl')
    sources = index('source-units.jsonl')
    semantic = index('independent-review-01/semantic-review25.jsonl')
    author = index('author-semantic-audit.jsonl')
    native = index('independent-review-01/native-read20.jsonl')
    author_native = index('native-read.jsonl')
    assert targets.keys() == sources.keys() == semantic.keys() == author.keys()
    assert len(targets) == 25
    selected = {k for k,r in targets.items() if r['target'] is not None}
    assert native.keys() == author_native.keys() == selected and len(selected) == 20
    physical = index('occurrence-map150.jsonl')
    assert len(physical) == 150
    assert Counter(r['pageId'] for r in physical.values()) == Counter({k:6 for k in targets})
    for ident, target in targets.items():
        assert target['locale'] == 'ru' and not target['targetApplied']
        assert len(target['occurrenceIds']) == len(set(target['occurrenceIds'])) == 6
        assert set(target['occurrenceIds']) == {r['id'] for r in physical.values() if r['pageId'] == ident}
        row = semantic[ident]
        assert row['source'] == target['source'] and row['target'] == target['target']
        assert row['sourceUtf8Sha256'] == target['sourceUtf8Sha256']
        if ident in selected:
            h = hashlib.sha256(target['target'].encode()).hexdigest()
            assert h == target['targetUtf8Sha256'] == row['targetUtf8Sha256']
            assert row['wholeReplacementRead'] and row['result'] == 'checked-no-objective-wording-defect'
            assert native[ident]['targetUtf8Sha256'] == author[ident]['targetUtf8Sha256'] == author_native[ident]['targetUtf8Sha256'] == h
            assert native[ident]['result'] == 'checked-no-objective-Russian-defect'
        else:
            assert row['result'] == author[ident]['disposition'] == 'source-hold'
            assert target['holdPredicates']
    evidence = {str(p.relative_to(ROOT)):sha(p) for p in sorted(PACKET.rglob('*'))
                if p.is_file() and p.name != 'ru.acceptance.json'}
    return dict(status='bounded-russian-editorial-accepted', game='The Forest of Love',
                version='0.45', locale='ru', assignedPages=25, assignedMemberships=150,
                acceptedWholePageTargets=20, conditionalPriorCandidatesRead=16,
                newlyAuthoredWholePages=4, nullSourceHeldPages=5, selectedContextEntries=315,
                independentReviewer=result['reviewer'], targetEditorialAccepted=True,
                all25TranslationAccepted=False, targetFile='ru.prepared.jsonl',
                targetSha256=sha(PACKET/'ru.prepared.jsonl'), sourceSha256=sha(PACKET/'source-units.jsonl'),
                exactFinalDelta=[], objectiveWordingFindings=0, evidence=evidence,
                reconciliationRecipe=str(Path(__file__).relative_to(ROOT)), reconciliationRecipeSha256=sha(Path(__file__)),
                scope='Twenty complete literal page targets accepted for wording only. Five Penny speaker/activation joins remain source holds. All150 occurrences stay in common inventory.',
                targetApplied=False, actualGameRuntime='not-run', ordinaryTranslationEntryAllowed=False,
                sourceGateAccepted=False, wholeGameAccepted=False)


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
    print('Narrative25/150:20 whole-page wordings verified;five source holds retained.')
