"""Bind the complete captured native inventory set before visual review."""
import argparse
import base64
import hashlib
import json
from pathlib import Path
import shutil
import sys

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
sys.path.insert(0, str(ROOT / 'tools/probe'))
from fixture_preservation import verify_fixture


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def prepare(run, out, diagnostic=False, continuation=None):
    run, out = run.resolve(), out.resolve()
    assert run.parent == ROOT / 'localization/probes' and out.parent == ROOT / 'localization/visual-qa'
    assert not out.exists()
    preparation = json.loads((run / 'qa-preparation.json').read_text())
    candidate = Path(preparation['parentBuild'])
    assert candidate.parent == ROOT / 'localization/previews'
    assert sha(candidate / 'build.json') == preparation['parentBuildSha256']
    receipts = run if continuation is None else run / continuation
    assert receipts == run or receipts.parent == run and receipts.is_dir()
    result = json.loads((receipts / 'runtime-result.json').read_text())
    assert (result['result'] == 'passed' or diagnostic) and result['captures']
    assert result['loaded48DescriptionsVerified'] and result['measuredCases'] == 52
    cleanup = json.loads((receipts / 'cleanup.json').read_text())
    assert all(cleanup[k] for k in ['taskOwnedProcessesAbsent', 'localizedAssemblyRestored', 'bridgeRemoved', 'parentArtifactUnchanged'])
    fixture = Path(preparation['fixtureDirectory'])
    preserved = verify_fixture(run, fixture, reconcile_resolution_reset=True, continuation=continuation)
    out.mkdir()
    (out / 'fixture-preservation.json').write_text(json.dumps(preserved, indent=2) + '\n')
    shutil.copyfile(ROOT / 'tools/probe/fixture_preservation.py', out / 'fixture-verifier.py.snapshot')
    source = [candidate / n for n in ['build.json', 'texture-preservation.json']]
    source += [run / n for n in ['qa-preparation.json', 'runtime-result.json', 'cleanup.json', 'player.log',
                                 'display-diagnostics.tsv', 'inventory-measurements.json', 'inventory-readback.tsv',
                                 'capture_inventory_ui.py', 'execution-pins.json']]
    source += [out / 'fixture-preservation.json', out / 'fixture-verifier.py.snapshot']
    if receipts != run:
        source += [receipts / name for name in ['runtime-result.json', 'cleanup.json', 'reconciliation.json', 'capture_inventory_ui.py']]
    glitch = None
    if (run / 'inventory-glitch-readback.json').exists():
        glitch = json.loads((run / 'inventory-glitch-readback.json').read_text())
        source += [run / 'inventory-glitch-readback.json', run / 'inventory-glitch-expectations.tsv',
                   candidate / 'glitch-acceptance.json', candidate / 'inventory-glitch-code-readback.json']
        for name in ['inventory-glitch-readbacks.json', 'inventory-glitch-finite-sizes.tsv', 'inventory-glitch-mode.txt']:
            if (run / name).exists():
                source.append(run / name)
        if (run / 'inventory-glitch-readbacks.json').exists():
            glitch = json.loads((run / 'inventory-glitch-readbacks.json').read_text())
    manifest = dict(schemaVersion=1, kind='native-screenshots',
                    scope=f'Complete{len(result["captures"])}-frame current Russian inventory capture set; all48 loaded descriptions/52 original consumer argument fixtures. Not full-game visual acceptance.' + (' Diagnostic failed run only.' if diagnostic else ''),
                    provenance={str(p.relative_to(ROOT)): dict(path=str(p), sha256=sha(p)) for p in source},
                    images=[dict(game='the-forest-of-love', locale='ru', order=i, direction='ltr',
                                 filename=c['filename'], sha256=c['sha256'], width=c['width'], height=c['height'])
                            for i, c in enumerate(result['captures'], 1)])
    (out / 'native-manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    expectations = {int(f[0]): [base64.b64decode(v).decode() for v in f[1:]]
                    for line in (run / 'inventory-expectations.tsv').read_text().splitlines() for f in [line.split('\t')]}
    empty = {f[0]: base64.b64decode(f[1]).decode() for line in (run / 'inventory-empty-expectations.tsv').read_text().splitlines() for f in [line.split('\t')]}
    context = f'''Actual Russian inventory UI, game0.45/Unity2020.3.24f1/CrossOver, candidate{candidate.name}. Native PNG dimensions are authoritative per slot. Prepared input is WebP80, <=1280 longest edge. Complete set: {len(result['captures'])} frames. Inspect every assigned whole frame; no sampling or automatic clean verdicts. Original textures/streams remain exact; owner saves/files unused and bridge restoration verified. All48 descriptions loaded exactly;52 original OnCellSelected argument fixtures cover owned, consumed, zero and both empty-cell branches. Cloned schema arguments do not award items or prove real ownership/input/progression; grid/icons stay at the generated save state.

The active native pane is ItemInfoMultilineFixedWidths. Its source398x23 horizontal box clipped the complete Russian family. The current shared helper stacks title/description at12 points in a398x60 pane at(16,-195), beneath both original item panels. The existing background height grows from414 to488 at its original0.5 XY scale (Z remains1). The inventory page is uniformly fitted/repositioned against the actual UI camera viewport, leaving header space; confirm the entire frame and border are visible and all labels remain readable at the resulting scale. Sprite/texture bytes are unchanged; inspect background distortion and framing.

This is explicitly a UI-only renderer fixture: unrelated scene mesh/sprite Renderers and dialogue graphics are suppressed and restored, keeping original inventory CanvasRenderer/Graphic objects and artwork. World scenery/character visibility and normal input/progression are NOT accepted by these images. Actual source text color is black at alpha0.6509804, intentionally preserved. All52 current cases have complete native character counts, no missing glyphs and zero vertices outside active masks. These checks do NOT replace visual inspection of line spacing, dots/diacritics, clipping, content, overlap, pane edges or readability.

Check both the large/long title and full description against the exact expected strings below. They must remain legible, complete and mutually separated, inside the pane, without covering the item grid or extra-items list. Smaller unresolved marks require a source-pixel crop or needs-review. Font size is12 native points; no wording was shortened by the layout repair.

Protected painted artwork/headings/buttons may remain English under the owner's no-texture policy (including Inventory). Native item prose must be Russian. [M]/[Select] are exact input bindings. Native fields clear for item400, activating a separate original glitch renderer with its own source/display contract below. Do not inherit native-field geometry to that TMP renderer. Do not waive unexplained ordinary English or an unreadable glitch-region defect; ask for source context when needed. Whole-game source/role/font/dialogue/delivery gates remain separate.

Expected native fields by original capture:\n'''
    if glitch is not None:
        context += '''\nCurrent shared layout also places an opaque native Image backplate only beneath the information fields, using the exact sampled original background RGB193/189/176. No texture pixels are changed. This must remove the obsolete bitmap horizontal/vertical dividers from behind title/description, preserve framing and avoid obscuring any text or grid. Repeated-selection sibling ordering was corrected in candidate14; inspect each frame independently.\n
The former native horizontal layout also contains a live Separator Image (original GameObject3958/RectTransform12216/Image17271), which remained on top of candidate14's backplate. Candidate15 disables this exact child when applying the shared vertical reflow. Check that no divider crosses either text field, especially the opening К in Колокольчик, while the original outer page border remains intact. This is a native Image visibility change, not a texture edit.\n
The separate original item400 glitch title is exactly six question marks (??????), an intentional unknown-item label. Original RandomizeGlitchItemInfoTickerText selects exactly32 characters from a hardcoded fake NullReferenceException stack trace, replacing LF with space and preserving code/identifiers. Midword code fragments are intentional; do not demand prose translation of that exact protected fragment. The ordinary appended action suffix is independently translated to ' <color="purple">(Используй меня)</color>'; it must be fully visible as Russian purple text, with markup interpreted. The original source fake trace/32-character substring/range/0.5-second timer are preserved by whole-method reversal/readback. For this frame, the runner temporarily deactivated the same object so its scheduled callback ended, then reactivated the unchanged original-produced text. This freezes the original effect's text for a reproducible capture and does not prove normal input/progression. The exact captured source-backed title/text and finite possible-fragment size probe follow. Preferred-height values are diagnostic, not a visual pass. Any unreadable question mark, Cyrillic letter, clipped action label or overlap remains a finding/needs-review.\n'''
        context += json.dumps(dict(glitchReadback=glitch), ensure_ascii=False, separators=(',', ':')) + '\n'
        build = json.loads((candidate / 'build.json').read_text())
        if build.get('inventoryGlitchCodeRepair', {}).get('renderingAdapter'):
            context += '''\nThis candidate fixes the original bare-CR overprint at the FINAL DISPLAY boundary: the producer still constructs its exact original32-character fragment plus exact localized suffix. FormatGlitch receives that unchanged input, renders CR as LF, and inserts an LF before the unchanged suffix. The code fragment may therefore occupy two lines, followed by the complete purple action label on its own line. It must not overprint code, title or any other text. The original separate TMP font stays12 points; its body is308x58 in a398x60 row. Question-mark title and native inventory text retain their fonts/wording. Both CR and non-CR inputs are required frames; the fixture temporarily seeds the original random producer to obtain each case, then restores the prior PRNG state and freezes the actual produced text. This is a deterministic renderer fixture, not random gameplay/progression acceptance. The finite size probe enumerates every one of611 possible original fragment starts AFTER the display transform; automatic bounds still do not replace visual readability.\n'''
    for capture in result['captures']:
        case = capture['case']; parts = case.split()
        if parts[0] in ['owned', 'consumed']:
            values = ['', ''] if int(parts[1]) == 400 else expectations[int(parts[1])]
        else:
            values = [empty['010c' if case == 'empty-special' else '011d'], empty['0111' if case == 'empty-special' else '0122']]
        context += json.dumps(dict(filename=capture['filename'], case=case, title=values[0], description=values[1], glitchMode=capture.get('glitchMode')), ensure_ascii=False, separators=(',', ':')) + '\n'
    assert len(context.encode()) <= 32768
    (out / 'acceptance.txt').write_text(context)
    print(json.dumps(dict(status='prepared', completeFrames=len(result['captures']), fixture=preserved['status'], visualAcceptance=False)))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--diagnostic', action='store_true')
    parser.add_argument('--continuation')
    args = parser.parse_args()
    prepare(args.run, args.output, args.diagnostic, args.continuation)
