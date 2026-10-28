"""Bind genuine full semantic and independent/delta receipts to the final134 packet.

This validates evidence and structure; it never generates semantic verdicts.
"""
import argparse
import hashlib
import json
from pathlib import Path

import russian_chapter_gallery_case as adapter
from inventory_display_review import check_pins

ROOT = adapter.ROOT
PACKET = adapter.PACKET
FULL = ROOT / 'outputs/chapter-gallery-review-20261029/independent-01'
DELTA = ROOT / 'outputs/chapter-gallery-review-20261029/final-delta-01'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(path):
    return json.loads(path.read_text())


def rows(path):
    data = [json.loads(line) for line in path.read_text().splitlines()]
    assert len(data) == len({r['id'] for r in data}), 'duplicate evidence IDs'
    return {r['id']: r for r in data}


def reviewed(job):
    state = read(job / 'job.json')
    assert state['status'] == 'review-complete-awaiting-parent' and state['exitCode'] == 0
    assert state['measuredUsage']['total_tokens'] > 0 and not state['errors']
    config = read(job / 'config.json')
    check_pins(config)
    runtime = read(job / 'review/runtime-verification.json')['actualRuntime']
    assert runtime['turn'] == {'model': 'gpt-6.1-sol', 'effort': 'high'}
    assert runtime['session']['model_provider'] == 'openai'
    assert runtime['session']['parent_thread_id'] is None
    result = read(job / 'review/result.json')
    assert result['reviewedIds'] == config['candidateIds'] == state['reviewedIds']
    assert sha(job / 'review/reviews.jsonl') == result['reviewsSha256']
    pairs, decisions = rows(job / 'pairs.jsonl'), rows(job / 'review/reviews.jsonl')
    assert pairs.keys() == decisions.keys()
    for key, pair in pairs.items():
        for field in ('source', 'target'):
            expected = hashlib.sha256(pair[field].encode()).hexdigest()
            assert decisions[key][field + 'Sha256'] == expected
    return pairs, decisions


def acceptance():
    old_path = PACKET / 'ru.case-preparation.full.jsonl'
    final_path = PACKET / 'ru.edited.jsonl'
    old, final = rows(old_path), rows(final_path)
    assert old.keys() == final.keys() and len(final) == 134
    adapter.validate_rows(list(final.values()), locale='ru')
    changed = {key for key in old if old[key] != final[key]}
    assert len(changed) == 1
    repair = read(PACKET / 'repair-batch-01.json')
    assert set(repair['changedIds']) == changed
    assert repair['originalTargetSha256'] == sha(old_path)
    assert repair['targetSha256'] == sha(final_path)
    author = read(PACKET / 'author-semantic-audit-134.json')
    assert author['count'] == len(author['sourceTargetIdsReviewed']) == 134
    assert set(author['sourceTargetIdsReviewed']) == set(old)
    assert author['targetSha256'] == sha(old_path)
    assert author['status'].startswith('complete-author-semantic-pass-for134-wording;')
    judgment = read(PACKET / 'ru.author-final-semantic.json')
    assert judgment['status'] == 'passed' and judgment['targetSha256'] == sha(final_path)
    assert judgment['sourceSha256'] == adapter.SOURCE_PINS['source.jsonl']
    assert judgment['fullAuthorAuditSha256'] == sha(PACKET / 'author-semantic-audit-134.json')
    assert judgment['repairBatchSha256'] == sha(PACKET / 'repair-batch-01.json')
    full_pairs, full_reviews = reviewed(FULL)
    delta_pairs, delta_reviews = reviewed(DELTA)
    assert set(full_pairs) == set(old) and set(delta_pairs) == changed
    for key in old:
        assert all(full_pairs[key][f] == old[key][f] for f in ('source', 'target'))
        if key not in changed:
            assert full_reviews[key]['verdict'] == 'pass' and old[key] == final[key]
        else:
            assert full_reviews[key]['verdict'] == 'finding'
            assert full_reviews[key]['proposedTarget'] == final[key]['target']
            assert all(delta_pairs[key][f] == final[key][f] for f in ('source', 'target'))
            assert delta_reviews[key]['verdict'] == 'pass'
    common = dict(status='passed', caseId=adapter.CASE, locale='ru',
                  targetSha256=sha(final_path), sourceSha256=adapter.SOURCE_PINS['source.jsonl'],
                  wholeGameAccepted=False, ordinaryTranslationEntryAllowed=False)
    evidence = {
        'fullSemantic': dict(common, fullAuthorAuditSha256=sha(PACKET / 'author-semantic-audit-134.json'),
                             finalAuthorJudgmentSha256=sha(PACKET / 'ru.author-final-semantic.json')),
        'independentCleanDelta': dict(common, fullReviewedIds=134, unchangedPassIds=133,
                                     correctedPassIds=1, fullReviewsSha256=sha(FULL / 'review/reviews.jsonl'),
                                     deltaReviewsSha256=sha(DELTA / 'review/reviews.jsonl')),
        'finalDeterministic': dict(common, exactUniqueIds=134, sourceTargetHashes=True,
                                   sourcePacketPins=adapter.SOURCE_PINS, protectedTemplates=True,
                                   mechanicalChecksAreSemanticJudgment=False),
    }
    files = {kind: 'ru.' + kind + '.json' for kind in evidence}
    raw = {files[k]: (json.dumps(v, ensure_ascii=False, indent=2) + '\n').encode() for k, v in evidence.items()}
    accepted = dict(status='bounded-russian-editorial-accepted', caseId=adapter.CASE, locale='ru',
                    wordingOccurrences=134, targetEditorialAccepted=True,
                    targetFile=final_path.name, targetSha256=sha(final_path),
                    sourcePins=adapter.SOURCE_PINS, dependencyPins=adapter.DEPENDENCY_PINS,
                    evidence={k: dict(file=files[k], sha256=hashlib.sha256(raw[files[k]]).hexdigest()) for k in evidence},
                    localeCaseDecisionAccepted=False, ordinaryTranslationEntryAllowed=False,
                    globalPretranslationPassed=False, runtime='not-run', wholeGameAccepted=False)
    raw['ru.acceptance.json'] = (json.dumps(accepted, indent=2) + '\n').encode()
    return raw


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    products = acceptance()
    if args.check:
        assert all((PACKET / name).read_bytes() == raw for name, raw in products.items())
    else:
        assert all(not (PACKET / name).exists() for name in products)
        # Completion acceptance is written last; partial files are not a transaction.
        for name, raw in products.items():
            with (PACKET / name).open('xb') as stream:
                stream.write(raw)
    assert adapter.load_inputs(locale='ru').mode == 'editorial-accepted'
    print('134 wording IDs accepted; source/case/runtime/global/release gates remain separate')
