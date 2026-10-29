"""Reconcile the complete28-case native description run and its two fresh reviews."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
RUN = ROOT/'localization/probes/ru-chapter-completion-20261029-09'
REVIEW = ROOT/'localization/visual-qa/ru-chapter-description-20261029-09'
OUTPUT = REVIEW/'final-acceptance.json'


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def read(p):
    return json.loads(p.read_bytes())


def receipt():
    spec = importlib.util.spec_from_file_location('accepted_description09', RUN/'cg-helpers/capture_chapter_completion_ui.py')
    c = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = c
    spec.loader.exec_module(c)
    prep = c.pin_check(RUN, restored=True)
    c.process().no_game_process(RUN)
    c.parent_unchanged(prep)
    cleanup = read(RUN/'cleanup.json')
    assert all(cleanup[k] for k in ['taskOwnedProcessesAbsent','localizedAssemblyRestored','bridgeRemoved','parentArtifactUnchanged'])
    restore = read(RUN/'cc-restoration.json')
    assert restore['status'] == 'restored' and restore['validationError'] is None
    assert all(restore['fixtureVerification'][k] for k in ['disposableSavegameByteExact','disposableSettingsByteExact','requestedWindowedModePreserved'])
    ready = read(RUN/'cc-pre-route-save-continuation.json')
    assert ready['scene'] == 'CentralForest' and ready['diagnosticsReady'] and ready['dataServicePresent'] and ready['manifestPresent']
    assert ready['gameplay'] and not ready['conversation'] and not ready['anyEvent'] and ready['notReady'] == []
    route = [json.loads(line) for line in (RUN/'cc-description-route.jsonl').read_text().splitlines()]
    assert [r['action'] for r in route] == ['open','select']
    assert all(r['scene'] == 'CentralForest' and not r['conversationActive'] for r in route)
    assert not route[0]['paused'] and route[1]['paused']
    assert (RUN/'cg-readback.tsv').read_text(encoding='utf-8-sig') == (RUN/'cg-values.tsv').read_text()
    work = read(RUN/'cc-workload.json')
    cases = [r for r in work['cases'] if r['surface'] == 'description']
    rows = [json.loads(line) for line in (RUN/'cc-description/measurements.jsonl').read_text().splitlines()]
    assert len(cases) == len(rows) == 28
    assert [r['index'] for r in rows] == [r['index'] for r in cases]
    for case,row in zip(cases,rows):
        assert row['sourceId'] == case['sourceId'] and len(row['fields']) == 6
        for field in row['fields']:
            check = c.metric_issues(field,case['expected'])
            assert field['projectionDiagnosticVersion'] == 2 and check['issues'] == field['issues'] == []
            assert check['role'] == field['role']
    result = read(RUN/'cc-description/result.json')
    assert result['status'] == 'surface-observations-complete' and result['measuredCases'] == 28 and result['restored'] and result['geometryIssueCases'] == []
    assert [f['caseIndex'] for f in result['captures']] == c.representatives(cases,rows)
    assert len(result['captures']) == 2
    for name,digest in result['evidenceSha256'].items():
        assert sha(RUN/'cc-description'/name) == digest
    manifest_path = REVIEW/'queue.previews/manifest.json'
    manifest = read(manifest_path)
    reviewed = read(REVIEW/'review.json')
    inputs = {'nativeManifest':sha(manifest_path)}
    for name,info in manifest['provenance'].items():
        assert sha(Path(info['path'])) == info['sha256'], ('visual-provenance',name)
        inputs['provenance:'+name] = info['sha256']
    assert reviewed['inputs'] == inputs and len(reviewed['images']) == len(manifest['images']) == 2
    for original,review in zip(manifest['images'],reviewed['images']):
        assert all(review[k] == original[k] for k in original)
        assert not review['findings'] and all(review['checks'][k] == 'passed' for k in ['layout','glyphs','content','contamination'])
    bindings = read(REVIEW/'queue.previews/source-bindings.json')
    assert bindings['policy'] == 'screenshot-webp-1280-q80-v1'
    assert len(bindings['images']) == 2
    for frame,binding,image in zip(result['captures'],bindings['images'],manifest['images']):
        original = Path(binding['sourcePath']);preview = binding['preview']
        assert original == RUN/frame['filename'] and sha(original) == frame['sha256'] == preview['sourceSha256']
        assert preview['quality'] == 80 and preview['maxEdge'] == 1280 and max(preview['width'],preview['height']) <= 1280
        assert sha(Path(preview['path'])) == preview['sha256'] == image['sha256']
    state = read(REVIEW/'queue/state.json')
    assert (state['total'],state['passed'],state['failed'],state['pending']) == (2,2,0,0)
    files = [p for base in [RUN/'cc-description',RUN/'cc-command-receipts'] for p in base.rglob('*') if p.is_file()]
    files += [RUN/n for n in ['cc-preparation.json','cc-execution-pins.json','cc-pre-route-save-continuation.json','cc-readiness-observations.jsonl','cc-description-route.jsonl','cc-description-open.txt','cc-description-selected.txt','cg-readback.tsv','cg-values.tsv','cleanup.json','cc-restoration.json','cc-cleanup-complete.json','runtime-result.json']]
    files += [REVIEW/n for n in ['review.json','native-manifest.json','acceptance.txt','queue/state.json','queue/attempt-0001/usage.json','queue.previews/manifest.json','queue.previews/source-bindings.json']]
    files += [Path(b['sourcePath']) for b in bindings['images']]+[Path(b['preview']['path']) for b in bindings['images']]
    return dict(status='bounded-description28-native-and-visual-accepted',locale='ru',
                candidate=prep['parentBuild'],candidateBuildSha256=prep['parentBuildSha256'],
                measuredCases=28,originalLoadedStates=129,textFields=168,visibleFaces=140,geometryIssueCases=[],
                reviewedCompleteFrames=2,screenshotPolicy=bindings['policy'],russianHeadingFindingResolved=True,
                projectionPredicate='Actual screen bounds and camera viewport/near/far interval inclusive; nonfinite projections reject. Orthographic near0/depth0 is valid.',
                processAndFixtureRestoration='exact receipts verified',
                excluded='OOS28 with original subscriber-effect holds;chapter selection/progression;actual Bio/input keyboard lifecycle;other576 menu contexts.',
                actualProgressionAccepted=False,sourceGateAccepted=False,wholeGameAccepted=False,
                evidence={str(p.relative_to(ROOT)):sha(p) for p in sorted(set(files))},
                reconciliationRecipe=str(Path(__file__).relative_to(ROOT)),reconciliationRecipeSha256=sha(Path(__file__)))


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--check',action='store_true')
    args = parser.parse_args()
    value = receipt()
    if args.check:
        assert read(OUTPUT) == value
    else:
        with OUTPUT.open('x') as stream:
            json.dump(value,stream,ensure_ascii=False,indent=2);stream.write('\n')
    print('Accepted all28 description cases/168fields/140visiblefaces and both complete native frames;OOS/progression excluded.')
