"""Adopt the independent gallery context delta without changing prior wording."""
import argparse
import hashlib
import json
from pathlib import Path

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
REVIEW = ROOT/'localization/supplemental-ui/20261029-counter-case90/gallery-context-review-01'
OUTPUT = REVIEW.parent/'gallery-context-review-01.parent-adoption.json'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(path):
    return json.loads(path.read_text())


def receipt():
    inputs = read(REVIEW/'input-pins.json')
    for row in inputs:
        path = Path(row['path'])
        assert path.is_absolute()
        assert sha(path) == row['sha256'], ('input-pin', str(path))
    outputs = read(REVIEW/'output-manifest.json')['files']
    assert len({row['file'] for row in outputs}) == len(outputs)
    for row in outputs:
        path = REVIEW/row['file']
        assert path.parent == REVIEW
        assert path.stat().st_size == row['bytes']
        assert sha(path) == row['sha256'], ('output-pin', row['file'])
    result = read(REVIEW/'Result.json')
    assert result['status'] == 'complete-independent-bounded-gallery-context-review-clean'
    assert result['newSemanticHeadingRows'] == result['separateRussianReadRows'] == 6
    assert result['storedContextRows'] == 12 and result['unchangedIdentityReceiptReuses'] == 2
    assert result['assembledFixturesRead'] == 35 and result['incoherentSymbolicBoundaryFixtures'] == 8
    assert result['wordingFindings'] == 0
    assert result['exactFinalDelta'] == result['unreadRequiredSelectors'] == []
    assert not result['sourceGateAccepted'] and not result['wholeGameAccepted']
    evidence = {str((REVIEW/row['file']).relative_to(ROOT)):row['sha256'] for row in outputs}
    evidence[str((REVIEW/'output-manifest.json').relative_to(ROOT))] = sha(REVIEW/'output-manifest.json')
    return dict(status='bounded-gallery-context-delta-adopted', locale='ru',
                semanticHeadings=6, separateRussianReadHeadings=6, storedContexts=12,
                unchangedIdentityReceiptReuses=2, assembledFixtures=35,
                symbolicSnapshotIncoherentFixtures=8, exactFinalDelta=[],
                priorTargetReceiptsPreserved=True, candidateBuildSha256=result['candidateBuildSha256'],
                actualGameRuntime='not-run', sourceGateAccepted=False, wholeGameAccepted=False,
                limits='Eight symbolic secret-story controls prove formatting only; no initialized-state reachability, native font/layout or gameplay acceptance.',
                evidence=evidence, reconciliationRecipe=str(Path(__file__).relative_to(ROOT)),
                reconciliationRecipeSha256=sha(Path(__file__)))


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    value = receipt()
    if args.check:
        assert read(OUTPUT) == value
    else:
        with OUTPUT.open('x') as stream:
            json.dump(value, stream, ensure_ascii=False, indent=2)
            stream.write('\n')
    print('Adopted six gallery heading joins, twelve stored contexts and two unchanged identity reuses.')
