"""Prepare every native notebook frame after exact runtime/display/fixture checks."""
import argparse
import base64
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools/probe'))
from fixture_preservation import verify_fixture


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def prepare(run, output, artwork):
    run, output, artwork = run.resolve(), output.resolve(), artwork.resolve()
    assert run.parent == ROOT / 'localization/probes' and run.name.startswith('ru-notebook-')
    assert output.parent == ROOT / 'localization/visual-qa' and not output.exists()
    assert artwork.is_relative_to(ROOT / 'localization/visual-qa')
    read = lambda path: json.loads(path.read_text())
    prep, result, cleanup = [read(run / name) for name in ('qa-preparation.json', 'runtime-result.json', 'cleanup.json')]
    assert result['result'] == 'passed' and result['loadedFieldsCompared'] == 156
    assert [r['filename'] for r in result['captures']] == [f'ru-{i:02d}-notebook-page-{i}.png' for i in range(1, 6)]
    assert [r['page'] for r in result['pages']] == list(range(1, 6))
    assert all(cleanup[k] for k in ('taskOwnedProcessesAbsent', 'localizedAssemblyRestored', 'bridgeRemoved', 'parentArtifactUnchanged'))
    unix_game = str(run / 'game') + '/'
    wine_game = 'Y:\\Desktop\\Forest\\localization\\probes\\' + run.name + '\\game\\'
    assert not [row for row in subprocess.check_output(['ps', '-axo', 'pid,command'], text=True).splitlines() if unix_game in row or wine_game in row]
    candidate = Path(prep['parentBuild'])
    assert candidate.parent == ROOT / 'localization/previews' and sha(candidate / 'build.json') == prep['parentBuildSha256']
    textures = read(candidate / 'texture-preservation.json')
    assert textures['status'] == 'pass' and textures['originalTextureObjects'] == 1385
    art = read(artwork)
    assert art['status'] == 'exact-original-artwork-bindings-verified'
    assert art['candidate'] == str(candidate) and art['candidateBuildSha256'] == prep['parentBuildSha256']
    for name, pin in art['sourcePins'].items():
        assert sha(ROOT / name) == pin
    expected = read(run / 'notebook-expectations.json')
    actual = {v[0]: base64.b64decode(v[1]).decode() for line in (run / 'notebook-runtime-texts.tsv').read_text().splitlines() for v in [line.split('\t')]}
    assert len(expected) == len(actual) == 156 and all(actual[r['hierarchy']] == r['target'] for r in expected)
    fixture = verify_fixture(run, Path(prep['fixtureDirectory']), reconcile_resolution_reset=True)
    # All prerequisites precede writes. Later writes are separate files, not a transaction.
    output.mkdir()
    (output / 'fixture-preservation.json').write_text(json.dumps(fixture, indent=2) + '\n')
    shutil.copyfile(ROOT / 'tools/probe/fixture_preservation.py', output / 'fixture-verifier.py.snapshot')
    source = [run / name for name in ('qa-preparation.json', 'runtime-result.json', 'cleanup.json', 'display-diagnostics.tsv', 'player.log', 'actions.log', 'capture_notebook_ui.py', 'notebook-expectations.json', 'notebook-runtime-texts.tsv')]
    source += [run / f'geometry-page-{i}.tsv' for i in range(1, 6)]
    source += [candidate / 'build.json', candidate / 'texture-preservation.json', artwork, output / 'fixture-preservation.json', output / 'fixture-verifier.py.snapshot', Path(__file__)]
    manifest = dict(schemaVersion=1, kind='native-screenshots',
                    scope='Complete five-page native notebook fixture;156 loaded fields. Actual display/fixture bound separately; no input/award/progression or whole-game acceptance.',
                    provenance={str(p.relative_to(ROOT)): dict(path=str(p), sha256=sha(p)) for p in source},
                    images=[dict(game='the-forest-of-love', locale='ru', order=i, direction='ltr', **capture) for i, capture in enumerate(result['captures'], 1)])
    (output / 'native-manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    context = '''Russian notebook, The Forest of Love0.45 Unity2020.3.24f1/CrossOver, combined accepted935/134 full build02. All five pages of actual GossipTutorialRedux captured using original ItemGetNotification.ShowPagedTutorial and page consumer. Every156 loaded field matches its accepted target. Visibility staged without OnSubmit/Finish; no awards, real input, normal progression or save continuation acceptance. All5 frames require complete whole-frame review; only assigned packet slots get rows. Native dimensions are authoritative per slot; prepared input is separate WebP80 <=1280 long edge, never upscaled. Tiny ambiguous glyphs/edges require source-bound crops or needs-review; no automatic passes.

Owned game and sidecars are absent, localized assembly restored, bridge removed, parent unchanged, owner files unused. All1385 original texture objects/26containers and resource streams match source. Main Russian text, punctuation, emphasis, shadows, bounds, page edges, line spacing, every visible word and contamination need inspection; preferred-height/no-overflow metrics never substitute for visual judgment. Correct six-occurrence instruction says Нажми кнопку; old Переключись на кнопку is superseded. Intentional alpha0 preferred-height providers and face/glow duplicates are not extra visible prose. Title has inactive manual-kerning variants; visible full title uses the original single-field variant and coherent size markup.

Exact source-backed artwork exceptions: ItemGetNotification18057.continueButtonAnimator5693 ->GO2060 ControlsR ->Image15383/glow ->shared0Sprite399/Texture114 TutorialsContinueButton. No native Text/TMP in this exact control subtree; English Continue is painted and preserved. Page3/Artwork Image14455 ->Sprite478/Texture13 GossipTutorial2_Artwork includes original Gossip/What's up?/NEW/options. Page4/Mask/Artwork Image13906 ->Sprite527/Texture57 QuestLog_Background_Full includes original English quest illustration. Page5/Mask/Artwork Image14490 ->Sprite574/Texture100 CritterLog_BackgroundFull includes original Residents/notes/kinks illustration. All exact Images/Sprites/Texture2D objects are source-byte-exact in this candidate, no live text descendants below those artwork Images. TALK/GOSSIP on Page2 are exact paired artwork identifiers and corresponding body literals, per accepted notebook source specialCases.spriteLabels. The no-texture exception applies to these named resources only, not arbitrary English. Faint details in the old1650x1050 run's source artwork remained unreadable after a native crop: do not inherit a pass or assume this new viewport resolves them. Source provenance does not establish tiny-mark readability; preserve concrete remaining uncertainty if present.

Measured fixture/display boundary:
'''
    context += json.dumps(fixture, ensure_ascii=False, separators=(',', ':'))
    context += '\nExact expected target fragments per page (deduplicated only for compact visual context; all156 physical fields retained/read back in provenance). Some title variants are inactive:\n'
    seen = set()
    for row in expected:
        page = row['hierarchy'].split('/')[1]
        key = (page, row['target'])
        if key not in seen:
            seen.add(key)
            context += json.dumps(dict(page=page, target=row['target']), ensure_ascii=False, separators=(',', ':')) + '\n'
    assert len(context.encode()) <= 32768
    (output / 'acceptance.txt').write_text(context)
    print(json.dumps(dict(status='prepared-no-model-submitted', frames=5, loadedFields=156, contextBytes=len(context.encode()), fixture=fixture['status'])))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--artwork', type=Path, required=True)
    args = parser.parse_args()
    prepare(args.run, args.output, args.artwork)
