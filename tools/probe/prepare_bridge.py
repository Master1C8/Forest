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


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('run', type=Path)
    parser.add_argument('--inventory-sample', action='store_true', help='Two synthetic empty-cell display literals only; no inventory identities/state changes')
    parser.add_argument('--startup-markers', action='store_true', help='Passive original bootstrap/menu entry logs; never a readiness or input-policy substitute')
    args = parser.parse_args()
    run = args.run.resolve()
    assert run.parent == ROOT / 'localization/probes'
    game = run / 'game'
    target = game / 'The Forest of Love_Data/Managed'
    assert target.is_dir()
    report = json.loads((run / 'build.json').read_text())
    assert len(report['files']) == 5 and report['saveIsolation']['companyName'] == 'VNRevivalQA'
    for row in report['files']:
        assert sha(game / 'The Forest of Love_Data' / row['path']) == row['probeSha256']
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
                    '-out:' + str(run / 'ForestProbe.dll')] + ['-r:' + str(p) for p in refs] +
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
               'inventorySample': {'title': 'Ёж Йй 123 — Latin!',
                                   'description': 'Е\u0308 и\u0306; Ё й. Щъ Ыь Эю Яя; 123 — Latin!'} if args.inventory_sample else None,
               'releaseUse': 'forbidden; inspection bridge only'}
    (run / 'bridge-build.json').write_text(json.dumps(receipt, indent=2) + '\n')
    print('Versioned bridge installed into isolated probe:', run)


if __name__ == '__main__':
    main()
