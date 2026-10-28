"""Validate real review receipts for the bounded Russian inventory supplement.

Semantic judgments are made by the reviewers. This joins exact versions and
coverage; it cannot manufacture a pass or promote full-game acceptance.
"""
import argparse
import json
from pathlib import Path
from editorial_lane import check_pins, finalize, rows, sha, save

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
PACKET = ROOT / 'localization/supplemental-ui/20261028-inventory'


def validate_job(job):
    state = json.loads((job / 'job.json').read_text())
    config = json.loads((job / 'config.json').read_text())
    assert state['status'] == 'review-complete-awaiting-parent' and state['exitCode'] == 0
    assert config['model'] == 'gpt-6.1-sol' and config['reasoning'] == 'high' and config['locale'] == 'ru'
    assert config['candidateIds'] == state['reviewedIds'] == 52
    check_pins(config)
    phase = job / 'review'
    runtime = json.loads((phase / 'runtime-verification.json').read_text())
    assert runtime['actualRuntime']['turn'] == {'model': 'gpt-6.1-sol', 'effort': 'high'}
    assert runtime['actualRuntime']['session']['model_provider'] == 'openai'
    assert runtime['actualRuntime']['session']['parent_thread_id'] is None and runtime['freshExecNoResumeNoFork'] is True
    assert runtime['threadId'] == state['threadId']
    assert (phase / 'runtime-check.json').is_file()
    original_result = (phase / 'result.json').read_bytes()
    original_reviews = (phase / 'reviews.jsonl').read_bytes()
    finalize(phase)
    assert (phase / 'result.json').read_bytes() == original_result
    assert (phase / 'reviews.jsonl').read_bytes() == original_reviews
    review_rows = rows(phase / 'reviews.jsonl')
    pairs = rows(phase / 'pairs.jsonl')
    assert len(review_rows) == len({r['id'] for r in review_rows}) == 52
    assert {r['id'] for r in review_rows} == {r['id'] for r in pairs}
    return state, pairs, review_rows


def accept(initial, independent, target):
    a, before, initial_reviews = validate_job(initial.resolve())
    b, after, final_reviews = validate_job(independent.resolve())
    assert a['stage'] == 'initial' and b['stage'] == 'independent-diff'
    assert a['threadId'] != b['threadId'], 'Distinct fresh independent context required'
    assert after == rows(target)
    before_by_id = {r['id']: r for r in before}
    after_by_id = {r['id']: r for r in after}
    assert before_by_id.keys() == after_by_id.keys()
    assert all(before_by_id[i]['source'] == after_by_id[i]['source'] for i in before_by_id)
    findings = [r for r in initial_reviews if r['verdict'] != 'pass']
    assert len(findings) == 1 and findings[0]['verdict'] == 'finding'
    correction = json.loads((PACKET / 'correction-batch-01.json').read_text())
    changed = [i for i in before_by_id if before_by_id[i]['target'] != after_by_id[i]['target']]
    assert changed == [correction['id']] == [findings[0]['id']]
    assert correction['accepted'] == correction['findings'] == 1 and correction['rejected'] == 0
    assert before_by_id[changed[0]]['target'] == correction['before']
    assert after_by_id[changed[0]]['target'] == correction['after'] == findings[0]['proposedTarget']
    assert correction['reviewsSha256'] == sha(initial / 'review/reviews.jsonl')
    assert all(r['verdict'] == 'pass' for r in final_reviews), 'Independent findings need consolidated repair and exact delta review'
    paths = [PACKET / 'correction-batch-01.json', target,
             ROOT / 'localization/source/inventory-display-completion-20261028/manifest.json',
             ROOT / 'localization/glossary/inventory-display-20261028/handoff.json']
    for job in [initial, independent]:
        paths += [job / n for n in ['config.json', 'job.json', 'pairs.jsonl']]
        paths += [job / 'review' / n for n in ['runtime-verification.json', 'runtime-check.json', 'result.json', 'reviews.jsonl']]
    return dict(schemaVersion=1, locale='ru', status='bounded-russian-editorial-accepted',
                targetFile=target.name, targetSha256=sha(target), sourceUnits=52,
                initialReviewed=52, initialFindings=1, consolidatedCorrections=1,
                independentDiffReviewed=52, independentFindings=0,
                dependencyClosure='All52 newly admitted display IDs are the initial-delivery delta; one target wording clarification. Exact complete52 source/glossary/consumer context read in both fresh contexts.',
                initialThread=a['threadId'], independentThread=b['threadId'],
                evidencePins={str(p): sha(p) for p in paths},
                wholeGameAccepted=False, runtimeAccepted=False, visualAccepted=False,
                boundary='Only this new Russian52-unit wording packet. Historical dialogue/935 packets, other locales, source/role/special-scene/font/runtime/release gates are separate.')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--initial', type=Path, required=True)
    parser.add_argument('--independent', type=Path, required=True)
    parser.add_argument('--target', type=Path, required=True)
    args = parser.parse_args()
    result = accept(args.initial.resolve(), args.independent.resolve(), args.target.resolve())
    output = PACKET / 'ru.acceptance.json'
    assert not output.exists(), 'Reconcile existing acceptance instead of overwriting'
    save(output, result)
    print(json.dumps({k: result[k] for k in ['status', 'sourceUnits', 'consolidatedCorrections', 'independentFindings']}))
