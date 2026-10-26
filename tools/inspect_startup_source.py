#!/usr/bin/env python3
"""Read-only startup supplement and static injection checks; never launches Unity."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

import UnityPy

ROOT = Path(__file__).resolve().parents[1]
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    parser.add_argument('--scratch', required=True, type=Path)
    args = parser.parse_args()
    out, scratch = args.output.resolve(), args.scratch.resolve()
    assert out.parent == ROOT / 'localization/source' and not out.exists()
    assert ROOT / 'outputs' in scratch.parents and not scratch.exists()
    sources = json.loads((ROOT / 'assets/source-v2/source-files.json').read_text())
    originals = {name: sha(DATA / name) for name in
                 ['globalgamemanagers', 'globalgamemanagers.assets', 'level0',
                  'Managed/Assembly-CSharp.dll', 'Managed/UnityEngine.CoreModule.dll']}
    assert all(value == sources[name]['sha256'] for name, value in originals.items())
    records = {r['id']: r for r in json.loads((ROOT / 'assets/source-v2/objects.json').read_text())}
    env = UnityPy.load(str(DATA / 'globalgamemanagers'))
    build = next(o for o in env.objects if o.type.name == 'BuildSettings')
    assert hashlib.sha256(build.get_raw_data()).hexdigest() == records['globalgamemanagers:11']['rawSha256']
    settings = build.read_typetree()
    assert settings['scenes'][:2] == ['Assets/_Game/[Scenes]/FirstLaunch.unity', 'Assets/_Game/[Scenes]/StartMenu.unity']
    # Keep only relevant public build fields, not the complete serialized object.
    scene_setup = {'scenes': settings['scenes'][:2], 'unityVersion': settings['m_Version'], 'objects': {}}
    selected = ['level0:' + str(i) for i in [33, 34, 35, 107, 108, 109, 110, 111, 112, 113]]
    selected += ['globalgamemanagers.assets:' + str(i) for i in [4075, 5395]]
    level = UnityPy.load(str(DATA / 'level0'))
    native = {o.path_id: o for o in level.objects}
    for key in selected:
        row = records[key]
        path = ROOT / 'assets/source-v2' / row['tree']
        assert sha(path) == row['treeSha256']
        if key.startswith('level0:'):
            assert hashlib.sha256(native[row['pathId']].get_raw_data()).hexdigest() == row['rawSha256']
        scene_setup['objects'][key] = {'treeSha256': sha(path), 'value': json.loads(path.read_text())}
    for pid in [68, 69, 70]:
        value = native[pid].read_typetree()
        assert hashlib.sha256(native[pid].get_raw_data()).hexdigest() == records['level0:' + str(pid)]['rawSha256']
        scene_setup['objects']['level0:' + str(pid)] = {'value': value}
    out.mkdir()
    scratch.mkdir(parents=True)
    (out / 'scene-setup.json').write_text(json.dumps(scene_setup, indent=2) + '\n')
    inspector = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
    injector = ROOT / 'tools/probe/bin/Debug/net8.0/InjectProbe.dll'
    assembly = DATA / 'Managed/Assembly-CSharp.dll'
    groups = {
        'RootActivator': ('TheForestOfLove.Core.SceneSetup.ActivateGameObjectOnActiveSceneChanged', 'Awake,OnLevelFinishedLoading'),
        'PrefabDropper': ('TheForestOfLove.Core.SceneSetup.PrefabDropper', 'Awake,Start,Update,LoopPrefabsAndSelfDestructWhenAllAreDropped,DropPrefabs'),
        'MainMenu': ('TheForestOfLove.MainMenuController', 'Start,.cctor'),
        'RuntimeInitializers': ('--runtime-initializers', 'all'),
    }
    commands = {}

    def inspect(source, name, type_name, methods):
        argv = ['dotnet', str(inspector), str(source), type_name, methods]
        data = subprocess.check_output(argv, timeout=60)
        (out / (name + '.il')).write_bytes(data)
        commands[name + '.il'] = argv
        return data.decode()

    for name, (type_name, methods) in groups.items():
        inspect(assembly, name, type_name, methods)
    prior = json.loads((ROOT / 'localization/probes/ru-20261026-37/bridge-build.json').read_text())
    refs = sorted((DATA / 'Managed').glob('*.dll'))
    assert {p.name: sha(p) for p in refs} == prior['originalManagedReferences']
    compiler = Path(prior['compiler'])
    assert sha(compiler) == prior['compilerSha256']
    bridge = scratch / 'ForestProbe.dll'
    compile_argv = ['dotnet', str(compiler), '-nologo', '-target:library', '-nostdlib+', '-out:' + str(bridge)]
    compile_argv += ['-r:' + str(p) for p in refs] + [str(ROOT / 'tools/probe/ForestProbe.cs')]
    compiled = subprocess.run(compile_argv, capture_output=True, text=True, timeout=120)
    assert compiled.returncode == 0, compiled.stdout + compiled.stderr
    tests = []
    for name, flags, count in [('baseline', [], 1), ('startup', ['--startup-markers'], 4),
                               ('inventory', ['--inventory-sample'], 2),
                               ('both', ['--inventory-sample', '--startup-markers'], 5)]:
        target = scratch / (name + '.dll')
        argv = ['dotnet', str(injector), str(DATA / 'Managed'), str(bridge), str(target)] + flags
        result = subprocess.run(argv, capture_output=True, text=True, timeout=60)
        assert result.returncode == 0, result.stdout + result.stderr
        assert result.stdout.startswith('Exact probe readback verified; changed methods: ')
        changed = result.stdout.split('changed methods: ', 1)[1].split('; all other', 1)[0].split(', ')
        assert len(changed) == count, changed
        tests.append({'name': name, 'result': 'passed', 'changedMethods': changed, 'sha256': sha(target), 'readback': result.stdout.strip()})
        if name == 'startup':
            for group in ['RootActivator', 'PrefabDropper', 'MainMenu']:
                text = inspect(target, 'Hook-' + group, *groups[group])
                assert 'FOREST_STARTUP ' in text
                if group != 'MainMenu':
                    assert 'ForestProbe::' not in text, 'Early bootstrap must not resolve the bridge'
    target = scratch / 'invalid.dll'
    result = subprocess.run(['dotnet', str(injector), str(DATA / 'Managed'), str(bridge), str(target),
                             '--startup-markers', '--startup-markers'], capture_output=True, text=True, timeout=60)
    assert result.returncode != 0 and '[--inventory-sample] [--startup-markers]' in result.stderr and not target.exists()
    tests.append({'name': 'duplicate-flag', 'result': 'passed', 'boundary': 'Argument rejection before output; matching baseline positive above'})
    inspect(bridge, 'BridgeBootstrap', 'ForestProbe', 'Install,Awake')
    assert all(sha(DATA / name) == value for name, value in originals.items())
    evidence = {p.name: sha(p) for p in out.iterdir()}
    tools = ['tools/inspect_startup_source.py', 'tools/probe/InspectMethods.cs', 'tools/probe/InjectProbe.cs',
             'tools/probe/ForestProbe.cs', 'tools/probe/prepare_bridge.py']
    receipt = {'scope': 'Supplement only; no frozen corpus/glossary changes, no game or image launch',
               'originals': originals, 'tools': {p: sha(ROOT / p) for p in tools},
               'executables': {'inspector': sha(inspector), 'injector': sha(injector), 'compiler': sha(compiler), 'bridge': sha(bridge)},
               'originalManagedReferences': prior['originalManagedReferences'], 'files': evidence,
               'commands': commands, 'compileCommand': compile_argv, 'compilerOutput': compiled.stdout,
               'staticTests': tests, 'runtime': 'not-run; serialization/IL checks cannot establish Unity startup or readiness'}
    (out / 'extraction.json').write_text(json.dumps(receipt, indent=2) + '\n')
    print('Startup supplement and five static cases passed:', out)


if __name__ == '__main__':
    main()
