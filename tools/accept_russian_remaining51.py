#!/usr/bin/env python3
"""Reconcile genuine editorial receipts for the finite Russian51 packet.

This does not generate semantic judgments or apply translations. The parent
source disposition below preserves the documented Claire/Violet mismatch and
does not invent a food mechanic for MysteryMeets.
"""
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PACKET = ROOT / 'localization/supplemental-ui/20261029-remaining-case51'
REVIEW = ROOT / 'outputs/ru-remaining51-independent-20261029/check'


def read(path):
    return json.loads(path.read_text())


def rows(path):
    return [json.loads(line) for line in path.read_text().splitlines()]


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def emit(path, value):
    # These are separate exclusive writes, not a multi-file transaction.
    # Existing receipts must be reconciled rather than overwritten on retry.
    with path.open('x') as out:
        json.dump(value, out, ensure_ascii=False, indent=2)
        out.write('\n')


def main():
    for folder in (PACKET, REVIEW):
        for name, digest in read(folder / 'input-pins.json').items():
            assert sha(ROOT / name) == digest, name
    targets = rows(PACKET / 'ru.prepared.jsonl')
    sources = rows(PACKET / 'source-context.jsonl')
    author = rows(PACKET / 'author-semantic-audit.jsonl')
    independent = rows(REVIEW / 'reviews.jsonl')
    retained = rows(REVIEW / 'context3.jsonl')
    assert len(targets) == len(sources) == len(author) == 51
    assert len(independent) == 48 and len(retained) == 3
    ix = {r['id']: r for r in targets}
    sx = {r['id']: r for r in sources}
    assert len(ix) == len(sx) == 51
    for target in targets:
        assert sx[target['id']]['source'] == target['source']
        for key in ('source', 'target'):
            assert hashlib.sha256(target[key].encode()).hexdigest() == target[key + 'Utf8Sha256']
    for receipt in author:
        target = ix[receipt['id']]
        for key in ('sourceUtf8Sha256', 'targetUtf8Sha256', 'sourceValueSha256'):
            assert receipt[key] == target[key]
        assert receipt['verdict'] == 'author-semantic-preparation-pass'
        assert receipt['fidelityRead'] and receipt['separateNativeRead']
    assert {r['id'] for r in author} == set(ix)
    for receipt in independent:
        target = ix[receipt['id']]
        assert receipt['sourcehash'] == target['sourceUtf8Sha256']
        assert receipt['targethash'] == target['targetUtf8Sha256']
        assert receipt['sourceValueSha256'] == target['sourceValueSha256']
        assert receipt['verdict'] == 'pass' and not receipt['findings']
        assert not target['reusedEvidence']
    for receipt in retained:
        target = ix[receipt['id']]
        assert receipt['sourcehash'] == target['sourceUtf8Sha256']
        assert receipt['targethash'] == target['targetUtf8Sha256']
        assert receipt['verdict'] == 'retained-consistent' and not receipt['findings']
        assert not receipt['newIndependentSemanticPass'] and target['reusedEvidence']
        prior = receipt['priorReceipt']
        assert sha(ROOT / prior['file']) == prior['fileSha256']
        assert rows(ROOT / prior['file'])[prior['line'] - 1] == prior['receipt']
        artifact = receipt['acceptedArtifact']
        assert sha(ROOT / artifact['file']) == artifact['sha256']
    assert {r['id'] for r in independent + retained} == set(ix)
    result = read(REVIEW / 'result.json')
    assert result['status'] == 'finite-russian51-independent-review-complete'
    assert result['sourceAndTargetUnchanged'] and result['objectiveWordingFindings'] == 0
    assert not result['coverage']['unreadIds'] and not result['coverage']['unreadRequiredContextMembers']
    preflight = read(REVIEW / 'preflight-recheck.json')
    assert preflight['positiveControl'] and preflight['exactProtectedRecords'] == 2135
    assert len(preflight['negativeControls']) == 8 and all(r['passed'] for r in preflight['negativeControls'])
    decision = read(REVIEW / 'fast-travel-decision-review.json')
    findings = read(REVIEW / 'findings.json')
    assert not findings['objectiveWordingFindings'] and not findings['proposedReplacements']
    assert not rows(PACKET / 'ru.final-delta.jsonl')
    evidence = {}
    for folder, names in (
        (PACKET, ('source-context.jsonl', 'ru.prepared.jsonl', 'author-semantic-audit.jsonl',
                  'coverage-read-evidence.json', 'preserve-exactly.jsonl', 'assembled-outputs.jsonl', 'input-pins.json')),
        (REVIEW, ('result.json', 'reviews.jsonl', 'context3.jsonl', 'coverage-read-evidence.json',
                  'findings.json', 'preflight-recheck.json', 'fast-travel-decision-review.json', 'runtime-check.json')),
    ):
        for name in names:
            path = folder / name
            evidence[str(path.relative_to(ROOT))] = sha(path)
    admission = {
        'status': 'finite51-static-source-application-design-admitted',
        'locale': 'ru', 'assignedOccurrences': 51,
        'newBGDisplayCells': 17, 'newCompiledOperands': 31, 'alreadyAppliedChapterOperands': 3,
        'sourceFindings': findings['sourceFindings'],
        'parentDisposition': [
            'Preserve the original Claire actor and Violet portrait relation exactly. The accepted target introduces no speaker-gender inference; correcting game identities is outside this patch.',
            'Accept contextual meeting/dating wordplay without asserting a food mechanic or supplying unidentified partners.',
        ],
        'protectedRecords': 2135,
        'applicationPredicate': 'Change only exact bound display cells/operands; verify complete BG payload, original producer controls and all unchanged managed methods. Preserve the three prior chapter operands and the independently accepted Haiku identity adapter when composing stages.',
        'fastTravelDecision': {'artifact': str((REVIEW / 'fast-travel-decision-review.json').relative_to(ROOT)), 'sha256': sha(REVIEW / 'fast-travel-decision-review.json'), 'newSemanticReviewOfRetained7': False},
        'actualRuntime': 'not-run', 'applicationImplemented': False,
        'ordinaryTranslationEntryAllowed': False, 'sourceGateAccepted': False, 'wholeGameAccepted': False,
    }
    acceptance = {
        'status': 'bounded-russian-editorial-accepted', 'locale': 'ru',
        'wordingOccurrences': 51, 'newIndependentSemanticRows': 48, 'retainedAcceptedRows': 3,
        'targetEditorialAccepted': True, 'targetFile': 'ru.prepared.jsonl',
        'targetSha256': sha(PACKET / 'ru.prepared.jsonl'),
        'sourceSha256': sha(PACKET / 'source-context.jsonl'),
        'exactFinalDelta': [], 'objectiveWordingFindings': 0, 'evidence': evidence,
        'sourceDisposition': 'source-application-admission.json',
        'sourceDispositionSha256': hashlib.sha256((json.dumps(admission, ensure_ascii=False, indent=2) + '\n').encode()).hexdigest(),
        'ordinaryTranslationEntryAllowed': False, 'sourceGateAccepted': False,
        'targetApplied': False, 'runtime': 'not-run', 'wholeGameAccepted': False,
        'receiptBoundary': 'Author and independent model judgments are retained by exact hash. This parent script validates correspondence only; separate receipt writes are not transactional.',
    }
    # Complete all validations before the first write. A failed second write
    # leaves the first receipt intact for explicit reconciliation.
    assert not (PACKET / 'source-application-admission.json').exists()
    assert not (PACKET / 'ru.acceptance.json').exists()
    emit(PACKET / 'source-application-admission.json', admission)
    assert sha(PACKET / 'source-application-admission.json') == acceptance['sourceDispositionSha256']
    emit(PACKET / 'ru.acceptance.json', acceptance)
    print(json.dumps({'status': acceptance['status'], 'newIndependent': 48, 'retained': 3, 'targetSha256': acceptance['targetSha256']}))


if __name__ == '__main__':
    main()
