#!/usr/bin/env python3
"""Emit all 27 real-game fixture contracts, or verify parent-captured receipts. Never launch."""
import argparse
import hashlib
import itertools
import json
from pathlib import Path

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
CHECK = ROOT / 'outputs/ru-haiku-identity-adapter-20261029/check'
CONTRACT = ROOT / 'localization/source/haiku-identity-adapter-20261029'


def digest(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def fixtures():
    plan = json.loads((CONTRACT / 'mapping.json').read_text())
    rows = plan['choices']
    result = []
    for index, choice_tuple in enumerate(itertools.product(*[[x for x in rows if x['slot'] == slot] for slot in [1, 2, 3]]), 1):
        ids = [x['id'] for x in choice_tuple]
        arc = 'mixed_ending'
        for branch in plan['branchContracts']:
            if [int(i.split(':')[2]) for i in ids] == branch['ids']:
                arc = branch['arc']
        result.append(dict(fixtureId='haiku-%02d' % index, ids=ids,
                           steps=[dict(slot=x['slot'], choiceEntryId=int(x['id'].split(':')[2]), expectedLabel=x['target'], expectedDestination=x['destination']['destinationDialogueID'], expectedTrigger=x['producerTrigger']) for x in choice_tuple],
                           expectedPoemLines=[x['target'] for x in choice_tuple], expectedArc=arc,
                           expectedCallback=dict(conversation='Dates_OliverCoyotes_Dialogue2', actor='Oliver', arc=arc),
                           startTrigger='oliver_coyotes_date2_haiku_start', finishTrigger=plan['context'], scheduledDelaySeconds=1))
    return result


def main():
    p = argparse.ArgumentParser(description=__doc__)
    sub = p.add_subparsers(dest='command', required=True)
    emit = sub.add_parser('emit'); emit.add_argument('--output', type=Path, required=True)
    verify = sub.add_parser('verify'); verify.add_argument('--receipts', type=Path, required=True); verify.add_argument('--output', type=Path, required=True)
    args = p.parse_args()
    assert not args.output.exists(), 'new-output-required'
    expected = fixtures()
    if args.command == 'emit':
        result = dict(schemaVersion=1, runtime='not-run', executionOwner='parent only after applicable game instruction',
                      requiredInputAssemblySha256=json.loads((CHECK / 'delivery/patch-receipt.json').read_text())['outputSha256'],
                      targetCorpusSha256=json.loads((CONTRACT / 'mapping.json').read_text())['corpusSha256'], fixtures=expected)
    else:
        rows = [json.loads(x) for x in args.receipts.read_text().splitlines()]
        assert len(rows) == 27 and len({r['fixtureId'] for r in rows}) == 27, 'exact27-real-runtime-receipts-required'
        actual = {r['fixtureId']: r for r in rows}
        assembly = json.loads((CHECK / 'delivery/patch-receipt.json').read_text())['outputSha256']
        for e in expected:
            a = actual[e['fixtureId']]
            assert a['assemblySha256'] == assembly and a['executionBoundary'] == 'actual-game-normal-dialogue', 'runtime-artifact-and-boundary'
            assert a['normalMode'] is True and a['ids'] == e['ids'], 'stable-choice-identity'
            assert a['displayedPoemLines'] == e['expectedPoemLines'] and a['storedPoemLines'] == e['expectedPoemLines'], 'russian-display-and-storage'
            assert a['selectedArc'] == e['expectedArc'] and a['callback'] == e['expectedCallback'], 'outcome-and-actual-continuation'
            assert a['scheduledDelaySeconds'] == 1 and a['cutsceneStartCount'] == 1 and a['cutsceneEndCount'] == 1, 'timing-and-callback-counts'
            assert a['steps'] == e['steps'], 'actual-label-trigger-destination-contract'
            assert a['evidence'], 'native-execution-evidence-required'
            for evidence in a['evidence']:
                assert digest(evidence['path']) == evidence['sha256'], 'native-log-pin'
        result = dict(schemaVersion=1, recordedReceiptsValidated=True, count=27, runtimeEvidenceNeedsParentReview=True,
                      boundary='Validates supplied records and evidence hashes; cannot establish that their producer truly exercised native game paths.',
                      sourceGateAccepted=False, ordinaryTranslationEntryAllowed=False, wholeGameAccepted=False)
    args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')


if __name__ == '__main__':
    main()
