#!/usr/bin/env python3
"""Prepare the complete28-description scope; never claim the separate OOS scope."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]


def read(p):
    return json.loads(p.read_text())


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def need(ok, why):
    if not ok:
        raise ValueError(why)


def prepare(run, output):
    need(run.is_absolute() and output.is_absolute(), 'explicit-absolute-paths')
    run, output = run.resolve(), output.resolve()
    helper = run / 'cg-helpers/capture_chapter_completion_ui.py'
    spec = importlib.util.spec_from_file_location('description_review_capture', helper)
    c = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = c
    spec.loader.exec_module(c)
    c.checked_run(run)
    prep = c.pin_check(run, restored=True)
    c.process().no_game_process(run)
    c.parent_unchanged(prep)
    need(output.parent == ROOT / 'localization/visual-qa' and not output.exists(), 'new-review-directory')
    cleanup = read(run / 'cleanup.json')
    restored = read(run / 'cc-restoration.json')
    cleanup_only = read(run / 'cc-cleanup-complete.json')
    need(cleanup_only['status'] == 'isolated-inputs-and-assembly-restored' and cleanup_only['runtimeComplete'] is False, 'honest-subset-cleanup')
    need(cleanup_only['restorationSha256'] == sha(run / 'cc-restoration.json'), 'restoration-version')
    need(all(cleanup[k] is True for k in ('taskOwnedProcessesAbsent', 'localizedAssemblyRestored', 'bridgeRemoved', 'parentArtifactUnchanged')), 'cleanup-boundary')
    need(restored['status'] == 'restored' and restored['validationError'] is None, 'fixture-validation')
    fixture = restored['fixtureVerification']
    need(all(fixture[k] is True for k in ('disposableSavegameByteExact', 'disposableSettingsByteExact', 'requestedWindowedModePreserved')), 'exact-disposable-fixture')
    data = run / 'game/The Forest of Love_Data'
    need(sha(data / 'Managed/Assembly-CSharp.dll') == prep['originalAssemblySha256'] and not (data / 'Managed/ForestProbe.dll').exists(), 'clean-delivered-runtime')
    for name, digest in prep['fixtureBefore'].items():
        need(sha(data / name) == digest, 'restored-input:' + name)
    for name, digest in restored['postRuntimeSidecars'].items():
        need(sha(run / 'cc-post-runtime' / name) == digest, 'preserved-post-runtime:' + name)
    need((run / 'cg-readback.tsv').read_text(encoding='utf-8-sig') == (run / 'cg-values.tsv').read_text(), 'all129-loaded-states')
    work = read(run / 'cc-workload.json')
    need(work['counts'] == dict(oos=28, description=28), 'source-workload')
    cases = [r for r in work['cases'] if r['surface'] == 'description']
    folder = run / 'cc-description'
    result = read(folder / 'result.json')
    need(result['status'] == 'surface-observations-complete' and result['measuredCases'] == len(cases) == 28 and result['restored'], 'complete-description28')
    need(set(result['evidenceSha256']) == {'measurements.jsonl', 'display-diagnostics.tsv', 'native-display.json'}, 'complete-display-evidence')
    for name, digest in result['evidenceSha256'].items():
        need(sha(folder / name) == digest, 'surface-evidence:' + name)
    measurements = [json.loads(line) for line in (folder / 'measurements.jsonl').read_text().splitlines()]
    need([r['index'] for r in measurements] == [r['index'] for r in cases], 'complete-measurement-ids')
    for case, row in zip(cases, measurements):
        need(row['sourceId'] == case['sourceId'] and len(row['fields']) == 6, 'actual-source-role')
        for field in row['fields']:
            recomputed = c.metric_issues(field, case['expected'])
            need(recomputed['issues'] == field['issues'] and recomputed['role'] == field['role'], 'geometry-readback')
    issues = [r['index'] for r in measurements if any(f['issues'] for f in r['fields'])]
    need(issues == result['geometryIssueCases'], 'complete-issue-denominator')
    frames = result['captures']
    need([r['caseIndex'] for r in frames] == c.representatives(cases, measurements), 'all-required-representatives')
    need(read(run / 'runtime-result.json')['captures'] == frames, 'exact-frame-inventory')
    native = read(folder / 'native-display.json')
    from PIL import Image
    for frame in frames:
        path = run / frame['filename']
        need(path.parent == run and sha(path) == frame['sha256'], 'original-frame-pin')
        with Image.open(path) as image:
            need(image.format == 'PNG' and image.size == (frame['width'], frame['height']), 'native-image-format')
            need(image.size == (native['viewportWidth'], native['viewportHeight']), 'native-viewport-parity')
            image.verify()
    receipts = sorted((run / 'cc-command-receipts').glob('*.json'))
    need(receipts and all(read(p)['status'] == 'acknowledged' for p in receipts), 'complete-command-outcomes')
    for name, suffix in (('cc-description-open.txt', '|original-PauseScreenUIManager.OnPause->UIPanelController.Open'),
                         ('cc-description-selected.txt', '|original-MainMenuChapterSelect-waypoint-guard->ShowUi->Show;no-chapter-selected')):
        need((run / name).read_text(encoding='utf-8-sig').endswith(suffix), 'original-visible-route:' + name)
    evidence = [Path(__file__).resolve()] + receipts
    evidence += [run / name for name in ('cc-preparation.json', 'cc-execution-pins.json', 'cc-workload.json', 'cc-selectors.tsv', 'cg-readback.tsv', 'cg-values.tsv', 'runtime-result.json', 'cleanup.json', 'cc-restoration.json', 'cc-cleanup-complete.json', 'task-process.json', 'build.json', 'cc-description-open.txt', 'cc-description-selected.txt')]
    evidence += [folder / name for name in ('result.json', 'measurements.jsonl', 'display-diagnostics.tsv', 'native-display.json')]
    context = '''The Forest of Love0.45, Russian standard localization, exact full candidate02. Native review ONLY of all required representatives from28 Chapter.description argument fixtures on the ORIGINAL ChapterSelectUI17041 tooltip role GO2084. This is not56-case completion: OOS has a separate nonempty-source-listener blocker and was not attempted in this run. Gallery3367/10, other UI fixtures and owner notebook-art exception are outside this scope.

The original normal saved Continue reached CentralForest without active dialogue. The bridge followed the original PauseScreenUIManager.OnPause -> bound UIPanelController.Open, then original PauseScreenUiController.MainMenuChapterSelect with an idle original waypoint guard -> ChapterSelectUI.ShowUi/Show. It did not directly activate a hidden text object, start a chapter/movie, invoke DoChapterSelect, alter progression callbacks or use unrelated AdventureName/Adventure.Title. Original LockInteractions prevents selection/autosave during28 measurements and is restored; source list spacing and component enabled state are preserved. The process ended normally, localized assembly and exact two disposable save/settings inputs restored, bridge removed, parent candidate unchanged.

All28 argument measurements precede these complete required representatives. Each text role has one original alpha0 height provider and five visible alpha1 faces. Do not count invisible provider mesh bounds as clipping. Actual missing glyphs, visible masks, viewport overflow and readability remain defects/needs-review; preferred height by itself is only diagnostic. Font/rect/texture were not modified for this capture. All28 have recorded outsideViewport flags; some also outsideRect. Determine what the ACTUAL frames show; a bad camera-coordinate diagnostic must not be accepted as actual visible clipping without image evidence, and good glyph counts must not hide absent text. Never pass unpictured issue cases from a representative image.

Actual1280x720 PNG/client viewport and1440x900 physical display are independently recorded; windowed mode and exact save/settings parity pass. Inspect ALL three whole frames for visible expected description, wrapping, clipping, overlapping layers, correct Cyrillic/fallback, ordinary unaccepted English/literal markup and non-game contamination. There is no blanket English-art or interface exception. Small uncertain detail requires a source-bound crop/needs-review. Review inputs are separately prepared WebP80 <=1280, originals unchanged; no screenshot editing or recapture.

Expected frames:
'''
    context += ''.join(json.dumps(frame, ensure_ascii=False) + '\n' for frame in frames)
    context += '\nUnresolved measurement IDs: ' + json.dumps(issues) + '\n'
    need(len(context.encode()) <= 32768, 'bounded-context')
    manifest = dict(schemaVersion=1, kind='native-screenshots', scope='All required representative frames from complete28 original Chapter.description fixtures; OOS/whole-game excluded.', provenance={str(p.relative_to(ROOT)): dict(path=str(p), sha256=sha(p)) for p in evidence}, images=[dict(game='the-forest-of-love', locale='ru', direction='ltr', order=i, **{k: frame[k] for k in ('filename', 'sha256', 'width', 'height')}) for i, frame in enumerate(frames, 1)])
    output.mkdir()
    for name, value in (('native-manifest.json', manifest), ('preparation.json', dict(status='prepared-not-submitted', measuredCases=28, frames=len(frames), geometryIssueCases=issues, visualAccepted=False, wholeGameAccepted=False))):
        (output / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')
    (output / 'acceptance.txt').write_text(context)
    return len(frames)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', required=True, type=Path)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    print(json.dumps({'preparedFrames': prepare(args.run, args.output)}))
