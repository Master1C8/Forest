#!/usr/bin/env python3
"""Prepare complete finite native chapter/gallery review packets, never model jobs.

Original PNGs remain unchanged. The shared tools/review_screenshots.py entry point
prepares WebP80 <=1280 only when the parent separately initializes a review queue.
"""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path

ROOT = Path('/Users/antonkrutov/Desktop/Forest')


def require(ok, reason):
    if not ok:
        raise ValueError(reason)


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def read(path):
    return json.loads(Path(path).read_bytes())


def prepare(run, output):
    run, output = Path(run).resolve(), Path(output).resolve()
    require(run.parent == ROOT / 'localization/probes' and output.parent == ROOT / 'localization/visual-qa' and not output.exists(), 'new-project-review-output-required')
    completion = read(run / 'cg-completion.json')
    require(sha(Path(__file__)) == sha(run / 'cg-helpers/prepare_chapter_gallery_review.py'), 'execute-version-matching-review-preparer')
    require(completion['status'] == 'finite-runtime-observations-complete', 'final-runtime-completion-required')
    require(sha(run / 'runtime-result.json') == completion['runtimeResultSha256'] and sha(run / 'cleanup.json') == completion['cleanupSha256'], 'completion-version')
    cleanup = read(run / 'cleanup.json')
    require(all(cleanup[k] is True for k in ('taskOwnedProcessesAbsent', 'localizedAssemblyRestored', 'bridgeRemoved', 'parentArtifactUnchanged')), 'cleanup-boundary')
    frozen = read(run / 'cg-execution-pins.json')
    # Hook bytes were intentionally restored/deleted; verify their saved originals
    # and complete immutable helpers/inputs, rather than accepting stale hook pins.
    mutable = {'game/The Forest of Love_Data/Managed/Assembly-CSharp.dll', 'game/The Forest of Love_Data/Managed/ForestProbe.dll'}
    for name, digest in frozen.items():
        p = (run / name).resolve()
        require(p.is_relative_to(run), 'pin-path')
        if name not in mutable:
            require(sha(p) == digest, 'review-execution-pin:' + name)
    helper = run / 'cg-helpers/capture_chapter_gallery_ui.py'
    spec = importlib.util.spec_from_file_location('cg_review_capture', helper)
    capture = importlib.util.module_from_spec(spec); spec.loader.exec_module(capture)
    capture.no_game_process(run)
    spec = importlib.util.spec_from_file_location('cg_fixture', run / 'cg-helpers/fixture_preservation.py')
    fixture = importlib.util.module_from_spec(spec); spec.loader.exec_module(fixture)
    prep = read(run / 'cg-preparation.json')
    preservation = fixture.verify_fixture(run, Path(prep['fixtureDirectory']), reconcile_resolution_reset=True)
    require(preservation == completion['fixture'], 'fixture-completion-version')
    workload = read(run / 'cg-workload.json'); result = read(run / 'runtime-result.json')
    require(result['measuredCases'] == 3423 and result['loaded113And16AbsencesVerified'] is True, 'whole-finite-workload-required')
    require((run / 'cg-selection-readback.tsv').read_text(encoding='utf-8-sig') == (run / 'cg-selections.tsv').read_text(), 'selection59-readback')
    require((run / 'cg-readback.tsv').read_text(encoding='utf-8-sig') == (run / 'cg-values.tsv').read_text(), 'corpus129-readback')
    expected_captures = []; sources = [run / n for n in ('cg-completion.json', 'cg-preparation.json', 'cg-execution-pins.json', 'cg-workload.json', 'cg-readback.tsv', 'cg-selection-readback.tsv', 'cg-fixture-preservation.json', 'cg-candidate-readback.json', 'runtime-result.json', 'cleanup.json', 'qa-preparation.json', 'build.json', 'player.log', 'task-process.json', 'bridge-ready.txt')]
    geometry_issues = {}
    for surface in capture.SURFACES:
        folder = run / ('cg-' + surface); receipt = read(folder / 'result.json')
        require(sha(folder / 'result.json') == completion['surfaces'][surface] and receipt['status'] == 'surface-observations-complete', 'surface-completion:' + surface)
        measurements = [json.loads(line) for line in (folder / 'measurements.jsonl').read_text().splitlines()]
        cases = [c for c in workload['cases'] if c['surface'] == surface]
        chosen = capture.representatives(cases, measurements)
        require([c['caseIndex'] for c in receipt['captures']] == chosen, 'representative-selection-reproducibility')
        expected_captures.extend(receipt['captures']); geometry_issues[surface] = receipt['geometryIssueCases']
        sources += [folder / n for n in ('result.json', 'measurements.jsonl', 'display-diagnostics.tsv')]
    require(expected_captures == result['captures'], 'complete-frame-set')
    require(len({c['filename'] for c in expected_captures}) == len(expected_captures), 'duplicate-frame')
    for c in expected_captures:
        path = run / c['filename']; require(path.parent == run and sha(path) == c['sha256'], 'original-frame-binding')
        from PIL import Image
        with Image.open(path) as im:
            require(im.size == (c['width'], c['height']) and im.format == 'PNG', 'native-frame-dimensions')
            im.verify()
    sources += [p for p in (run / 'cg-inputs').rglob('*') if p.is_file()]
    sources += [p for p in (run / 'cg-helpers').glob('*') if p.is_file()]
    sources += [p for p in (run / 'cg-command-receipts').glob('*.json')]
    for p in (run / 'cg-command-receipts').glob('*.json'):
        require(read(p)['status'] == 'acknowledged', 'unknown-command-outcome')
    context = '''The Forest of Love0.45/Unity2020.3.24f1, accepted bounded Russian chapter/gallery134 case. These are the complete finite representative frames from measured native display fixtures, not full-game visual or actual progression acceptance. Inspect every assigned entire frame. Shared review prepares WebP80 <=1280, preserving original PNGs; unreadable marks need a source-bound crop or needs-review.

Native typography/layout is preserved by this harness. Check actual font size and readability even if TMP auto-sizing/bounds pass. Check Cyrillic and marks, glyph substitutions, wrapping, overlap, clipping, active masks, alpha, viewport edges, full frame content and source punctuation. Geometry is diagnostic and may retain findings; do not inherit a pass from compilation, character counts or preferred dimensions.

The loaded workload is113 nonempty BG values (57 Movie.hint_phrase,28 Chapter.title,28 Chapter.description) plus16 absences, read back from both the DB entity and cached record. All59 gallery option identities (11 movies,48 stories) remain original. Geometry measures3363 conservative hint/identifier argument combinations plus missing-record/null/empty/whitespace fallback,28 wrapped OOS chapter titles and28 descriptions. Representatives include measured tallest, widest, longest and minimum final font-size cases per branch and one representative per geometry issue class. Remaining geometry issues remain unresolved; representative images never prove unpictured content readable.

Gallery calls original BuildLastAttemptedMovieIdentifierPhrase and GalleryHintTutorial.Start. Nonempty output is identifier + exactly two LF + hint; fallback is alone. Temporary cloned hint records/map entries/statics are restored within the same Update. OOS calls the original SetChapterNameLabel with the unchanged two U+0027 apostrophes each side, using the pinned original wrapper as a pure argument fixture. BaseSpawner itself is NOT invoked, so its delayed callbacks/version guards/progression are untested. Description calls original ChapterSelectUI.UpdateTooltipText. Native consumer text is restored after each surface. Original saves stay byte-exact; resolution metadata is separately checked.

Six native NoHint selectors and12 AfterPhotoshoot initial selectors have static candidate readback. The six OOS labels have the known producer; six inactive AdventureName GO2510 selectors are disjoint from the live Adventure confirmation title root. This harness never activates that unknown root. Their reachability and the separate Adventure.Title case remain pending. Do not call these frames confirmation-title acceptance or actual eligible progression.

Whole-game inventory, ordinary translation, global pretranslation, release, fonts beyond these observed fields and actual gameplay remain separate and false. Painted English chrome needs the parent's exact source-backed exceptions; unexplained ordinary English is a finding or needs-review. Do not invent a visual pass for source text that is absent.

Exact expected text per original frame follows:\n'''
    for c in expected_captures:
        context += json.dumps({k: c[k] for k in ('filename', 'surface', 'branch', 'caseIndex', 'expected')}, ensure_ascii=False, separators=(',', ':')) + '\n'
    context += '\nGeometry issue counts (all require adjudication): ' + json.dumps({s: len(v) for s, v in geometry_issues.items()}) + '\n'
    require(len(context.encode()) <= 32768, 'acceptance-context-too-large-split-scope-explicitly')
    manifest = dict(schemaVersion=1, kind='native-screenshots', scope=f'Complete{len(expected_captures)}-frame finite chapter/gallery representative set from3423 measured argument fixtures. No actual progression/Adventure.Title/whole-game acceptance.',
                    provenance={str(p.relative_to(ROOT)): dict(path=str(p), sha256=sha(p)) for p in sources},
                    images=[dict(game='the-forest-of-love', locale='ru', order=i, direction='ltr', filename=c['filename'], sha256=c['sha256'], width=c['width'], height=c['height']) for i, c in enumerate(expected_captures, 1)])
    # Precompute before exclusive writes; interruption leaves partial unaccepted
    # packets, never an implicit multi-file transaction or model submission.
    output.mkdir()
    (output / 'native-manifest.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + '\n')
    (output / 'acceptance.txt').write_text(context)
    (output / 'preparation.json').write_text(json.dumps(dict(status='review-packets-prepared-not-submitted', completeFrames=len(expected_captures), nativeManifestSha256=sha(output / 'native-manifest.json'), contextSha256=sha(output / 'acceptance.txt'), visualAccepted=False, sharedEntry='python3 tools/review_screenshots.py', originalRoot=str(run), geometryIssueCounts={s: len(v) for s, v in geometry_issues.items()}), indent=2) + '\n')
    return manifest


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__); parser.add_argument('--run', type=Path, required=True); parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args(); result = prepare(args.run, args.output)
    print(json.dumps(dict(status='prepared-not-submitted', completeFrames=len(result['images']), visualAccepted=False)))
