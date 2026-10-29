#!/usr/bin/env python3
"""Compile and install a versioned inspection bridge into an isolated probe only.

Does not launch the game and must never be used on a player installation.
"""
import argparse
import datetime
import hashlib
import json
import shutil
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
ORIGINAL = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/Managed')


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def compile_chapter_gallery(output, managed, product=None):
    """New immutable compile-only snapshot; no installation or process launch."""
    output, managed = Path(output).resolve(), Path(managed).resolve()
    assert output.is_relative_to(ROOT) and not output.exists(), 'New project-owned output required'
    assert managed.is_dir() and (managed / 'Assembly-CSharp.dll').is_file()
    source = (ROOT / 'tools/probe/ForestProbe.cs').read_text()
    assert source.count('public sealed class ForestProbe : MonoBehaviour') == 1
    source = source.replace('public sealed class ForestProbe : MonoBehaviour', 'public sealed partial class ForestProbe : MonoBehaviour')
    if product is not None:
        import re
        assert re.fullmatch(r'ForestRuChapterGalleryProbe[0-9_]+', product), 'Isolated product required'
        guard = 'Application.productName != "ForestRuRendererProbe"'
        assert source.count(guard) == 1
        source = source.replace(guard, 'Application.productName != "' + product + '"')
        marker = 'Debug.Log("FOREST_PROBE_READY " + root + " SAVES " + Application.persistentDataPath);'
        assert source.count(marker) == 1
        source = source.replace(marker, 'File.WriteAllText(Path.Combine(root,"bridge-ready.txt"), "1\\n"+Application.companyName+"\\n"+Application.productName+"\\n"+Application.dataPath);\n        ' + marker)
    sdk = subprocess.check_output(['dotnet', '--list-sdks'], text=True).splitlines()
    row = next(r for r in sdk if r.startswith('8.0.131 ['))
    compiler = Path(row.split('[', 1)[1].rstrip(']')) / '8.0.131/Roslyn/bincore/csc.dll'
    refs = sorted(managed.glob('*.dll'))
    assert compiler.is_file() and refs
    payload = {'ForestProbe.cs': source.encode(),
               'ChapterGalleryUiProbe.cs': (ROOT / 'tools/probe/ChapterGalleryUiProbe.cs').read_bytes()}
    output.mkdir()
    for name, raw in payload.items():
        (output / name).write_bytes(raw)
    argv = ['dotnet', str(compiler), '-nologo', '-target:library', '-nostdlib+',
            '-define:CHAPTER_GALLERY_PROBE', '-out:' + str(output / 'ForestProbe.dll')]
    argv += ['-r:' + str(p) for p in refs] + [str(output / n) for n in payload]
    result = subprocess.run(argv, capture_output=True, text=True)
    receipt = {'status': 'compiled-static-only' if result.returncode == 0 else 'compile-failed',
               'argv': argv, 'exitCode': result.returncode, 'stdout': result.stdout, 'stderr': result.stderr,
               'compilerSha256': sha(compiler), 'references': {str(p): sha(p) for p in refs},
               'sources': {name: sha(output / name) for name in payload}, 'product': product,
               'runtime': 'not-run', 'releaseUse': False}
    if result.returncode == 0:
        receipt['bridgeSha256'] = sha(output / 'ForestProbe.dll')
    (output / 'compile.json').write_text(json.dumps(receipt, indent=2) + '\n')
    assert result.returncode == 0, result.stdout + result.stderr
    return receipt


def choice_mode_admission(run, report, mode):
    assert mode in ['original', 'synthetic'], 'Unknown tutorial choice mode'
    expected = {'159': 'Ёж Йй Щъ Ыь Эю Яя; 123 — Latin!',
                '181': 'Е\u0308 и\u0306; ё й. Съешь ещё этих булок!'}
    if mode == 'original':
        assert not report.get('choiceSamples'), 'Original mode forbids synthetic choice resources'
        return
    assert report['sampleSurface'] == 'tutorial-choices' and report['coherentChoiceFace'] is True, 'Synthetic choice resource surface differs'
    assert report['choiceSamples'] == expected, 'Synthetic choice resource values differ'
    readback = json.loads((run / 'choice-resource-readback.json').read_text())
    assert readback['status'] == 'passed-static-only' and readback['buildSha256'] == sha(run / 'build.json'), 'Stale choice resource readback'
    assert len(readback['resourceFiles']) == 2
    assert [len(r['labels']) for r in readback['resourceFiles']] == [1, 155]
    for row in readback['resourceFiles']:
        assert sha(run / 'game/The Forest of Love_Data' / row['path']) == row['candidateSha256'], 'Choice resource bytes differ'
        assert row['entireDatabaseExceptTwoDeclaredValuesEqual'] is True, 'Choice source database differs'
        assert {str(r['entryId']): r['synthetic'] for r in row['syntheticSamples']} == expected, 'Choice readback values differ'
        assert all(all(r[k] is True for k in ['allOtherLabelFieldsEqual', 'originalResponseControllerRawBytesEqual',
                'originalManaSpaceRawBytesEqual', 'actualTargetEmbeddedFaceMatches']) for r in row['labels']), 'Choice label binding differs'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('run', type=Path, nargs='?')
    parser.add_argument('--chapter-gallery-compile-only', type=Path)
    parser.add_argument('--managed', type=Path)
    parser.add_argument('--inventory-sample', action='store_true', help='Two synthetic empty-cell display literals only; no inventory identities/state changes')
    parser.add_argument('--startup-markers', action='store_true', help='Passive original bootstrap/menu entry logs; never a readiness or input-policy substitute')
    parser.add_argument('--tutorial-choice-mode', choices=['original', 'synthetic'], default='original')
    args = parser.parse_args()
    if args.chapter_gallery_compile_only:
        assert args.run is None and args.managed is not None
        receipt = compile_chapter_gallery(args.chapter_gallery_compile_only, args.managed)
        print(receipt['status'])
        return
    assert args.run is not None and args.managed is None
    run = args.run.resolve()
    assert run.parent == ROOT / 'localization/probes'
    game = run / 'game'
    target = game / 'The Forest of Love_Data/Managed'
    assert target.is_dir()
    report = json.loads((run / 'build.json').read_text())
    assert len(report['files']) == 5 and report['saveIsolation']['companyName'] == 'VNRevivalQA'
    for row in report['files']:
        assert sha(game / 'The Forest of Love_Data' / row['path']) == row['probeSha256']
    choice_mode_admission(run, report, args.tutorial_choice_mode)
    processes = subprocess.check_output(['ps', '-axo', 'pid,ppid,command'], text=True)
    assert not any(str(game / 'The Forest of Love.exe') in line or
                   str(game / 'The Forest of Love.exe').replace('/', '\\') in line
                   for line in processes.splitlines()), 'Probe is running; do not replace its files'
    snapshot = run / 'bridge-source'
    assert not snapshot.exists() and not (run / 'bridge-build.json').exists()
    snapshot.mkdir()
    for name in ['ForestProbe.cs', 'InjectProbe.cs', 'InjectProbe.csproj']:
        shutil.copy2(ROOT / 'tools/probe' / name, snapshot / name)
    sdk_rows = subprocess.check_output(['dotnet', '--list-sdks'], text=True).splitlines()
    row = next(row for row in sdk_rows if row.startswith('8.0.131 ['))
    compiler = Path(row.split('[', 1)[1].rstrip(']')) / '8.0.131/Roslyn/bincore/csc.dll'
    assert compiler.is_file()
    refs = sorted(ORIGINAL.glob('*.dll'))
    subprocess.run(['dotnet', str(compiler), '-nologo', '-target:library', '-nostdlib+',
                    '-out:' + str(run / 'ForestProbe.dll')] + (['-define:SYNTHETIC_TUTORIAL_CHOICES'] if args.tutorial_choice_mode == 'synthetic' else []) + ['-r:' + str(p) for p in refs] +
                   [str(snapshot / 'ForestProbe.cs')], check=True)
    subprocess.run(['dotnet', 'build', str(snapshot / 'InjectProbe.csproj'), '--nologo', '--verbosity', 'quiet'], check=True)
    injector = snapshot / 'bin/Debug/net8.0/InjectProbe.dll'
    subprocess.run(['dotnet', str(injector), str(ORIGINAL), str(run / 'ForestProbe.dll'),
                    str(run / 'Assembly-CSharp.hook.dll')] + (['--inventory-sample'] if args.inventory_sample else []) +
                   (['--startup-markers'] if args.startup_markers else []), check=True)
    shutil.copy2(run / 'ForestProbe.dll', target / 'ForestProbe.dll')
    shutil.copy2(run / 'Assembly-CSharp.hook.dll', target / 'Assembly-CSharp.dll')
    receipt = {'builtAt': datetime.datetime.now(datetime.timezone.utc).isoformat(),
               'compiler': str(compiler), 'compilerSha256': sha(compiler),
               'sourceSnapshots': {p.name: sha(p) for p in snapshot.glob('*.cs*')},
               'originalManagedReferences': {p.name: sha(p) for p in refs},
               'bridgeSha256': sha(target / 'ForestProbe.dll'),
               'hookSha256': sha(target / 'Assembly-CSharp.dll'),
               'injectorSha256': sha(injector),
               'boundary': 'Exact instruction readback; MainMenuController.Start hook' +
                           ('; passive RootActivator Awake/scene-change, PrefabDropper Awake and menu entry logs' if args.startup_markers else '') +
                           ('; two InventoryInfoTicker.OnCellSelected empty-cell display literals' if args.inventory_sample else '') +
                           '; original hook/bootstrap bodies, branches, locals and exception handlers preserved',
               'startupMarkers': args.startup_markers,
               'tutorialChoiceMode': args.tutorial_choice_mode,
               'inventorySample': {'title': 'Ёж Йй 123 — Latin!',
                                   'description': 'Е\u0308 и\u0306; Ё й. Щъ Ыь Эю Яя; 123 — Latin!'} if args.inventory_sample else None,
               'releaseUse': 'forbidden; inspection bridge only'}
    (run / 'bridge-build.json').write_text(json.dumps(receipt, indent=2) + '\n')
    print('Versioned bridge installed into isolated probe:', run)


if __name__ == '__main__':
    main()
