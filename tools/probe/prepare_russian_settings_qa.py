#!/usr/bin/env python3
"""Reuse the verified settings bridge in a disposable copy of a repaired preview."""
import argparse
import copy
import ctypes
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))
import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from build_russian_preview import save_tree
from build_russian_settings_preview import sha
from extract_assets import canonical, read_tree

DATA = 'The Forest of Love_Data'
SYSTEM = ctypes.CDLL('/usr/lib/libSystem.B.dylib', use_errno=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--preview', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--surface', choices=['settings', 'report', 'names'], default='settings')
    args = parser.parse_args()
    preview, run = args.preview.resolve(), args.output.resolve()
    assert preview.parent == ROOT / 'localization/previews'
    assert run.parent == ROOT / 'localization/probes' and not run.exists()
    report = json.loads((preview / 'build.json').read_text())
    assert len(report['files']) == 7 and len(report['settingsTranslations']) == 9
    assert report['settingsRepair']['texturePixelsChanged'] is False
    if args.surface == 'report':
        assert len(report['reportTranslations']) == 20 and report['reportRepair']['texturePixelsChanged'] is False
    if args.surface == 'names':
        assert len(report['actorDisplayProjection']) == 46 and report['actorNamesRepair']['texturePixelsChanged'] is False
    for row in report['files']:
        assert sha(preview / 'game' / DATA / row['path']) == row['probeSha256']
    old = ROOT / 'localization/probes/ru-20261026-15'
    bridge = json.loads((old / 'bridge-build.json').read_text())
    for name, expected in bridge['originalManagedReferences'].items():
        assert sha(preview / 'game' / DATA / 'Managed' / name) == expected, name
    assert sha(old / 'ForestProbe.dll') == bridge['bridgeSha256']
    assert sha(old / 'Assembly-CSharp.hook.dll') == bridge['hookSha256']
    run.mkdir()

    def clone(source, target):
        if SYSTEM.clonefile(os.fsencode(source), os.fsencode(target), 0):
            shutil.copy2(source, target)
        assert os.stat(source).st_ino != os.stat(target).st_ino
        assert sha(source) == sha(target)
        return target

    shutil.copytree(preview / 'game', run / 'game', copy_function=clone)
    target = run / 'game' / DATA
    gen = TypeTreeGenerator('2020.3.24f1')
    gen.load_local_dll_folder(str(target / 'Managed'))
    env = UnityPy.load(str(target / 'globalgamemanagers'))
    obj = next(o for o in env.objects if o.type.name == 'PlayerSettings')
    tree = read_tree(obj, gen)
    assert tree['companyName'] == 'VNRevivalQA'
    assert tree['productName'] == report['saveIsolation']['productName']
    expected = copy.deepcopy(tree)
    expected['productName'] = 'ForestRuRendererProbe'
    save_tree(obj, expected, gen)
    (target / 'globalgamemanagers').write_bytes(next(iter(env.files.values())).save())
    reopened = next(o for o in UnityPy.load(str(target / 'globalgamemanagers')).objects
                    if o.type.name == 'PlayerSettings')
    assert canonical(read_tree(reopened, gen)) == canonical(expected)
    (target / 'app.info').write_text('VNRevivalQA\nForestRuRendererProbe')
    report['saveIsolation']['productName'] = 'ForestRuRendererProbe'
    next(r for r in report['files'] if r['path'] == 'globalgamemanagers')['probeSha256'] = sha(target / 'globalgamemanagers')
    report['qaParentArtifact'] = {'path': str(preview), 'buildSha256': sha(preview / 'build.json'),
                                 'onlyResourceDifference': 'globalgamemanagers PlayerSettings.productName'}
    (run / 'build.json').write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
    shutil.copy2(old / 'ForestProbe.dll', target / 'Managed/ForestProbe.dll')
    shutil.copy2(old / 'Assembly-CSharp.hook.dll', target / 'Managed/Assembly-CSharp.dll')
    shutil.copy2(old / 'bridge-build.json', run / 'bridge-build.json')
    shutil.copytree(old / 'bridge-source', run / 'bridge-source', ignore=shutil.ignore_patterns('bin', 'obj'))
    shutil.copy2(ROOT / 'tools/probe/command.py', run / 'command.py')
    template = (ROOT / 'tools/probe/capture_settings.py').read_text()
    assert "len(report['files'])==5" in template
    template = template.replace("len(report['files'])==5", "len(report['files'])==7")
    start, end = template.index('        def settings_state(fullscreen):'), template.index("        if not d['fullscreen']:")
    replacement = '''        def settings_state(fullscreen):
            state=dump()
            assert state['fullscreen']==fullscreen
            assert 'OptionsMenu Canvas/OptionsMenu' in state['components']
            rows=[x for x in state['rendererDiagnostics'] if x.startswith('Canvas/OptionsMenu/')]
            visible={'Music Volume/Slider/Label', 'Sound Volume/Slider/Label', 'Fullscreen/Fullscreen',
                     'Fullscreen/'+('On' if fullscreen else 'Off')}
            if fullscreen:
                visible.update({'FullscreenStretch/FullscreenStretch',
                                'FullscreenStretch/'+('On' if state['stretch'] else 'Off')})
            else:
                visible.add('ScaleFactor/ScaleFactor')
            for binding in report['settingsTranslations']:
                family=binding['hierarchy'].removeprefix('Canvas/OptionsMenu/Controls/')
                matching=[r for r in rows if r.startswith(binding['hierarchy']+'/NameContainer')]
                assert len(matching)==(6 if family in visible else 0), (family,len(matching),visible)
                assert all((' | TMPro.TextMeshProUGUI | '+binding['target']+' | ') in r for r in matching), (family,matching)
                assert all('overflow=False' in r for r in matching), ('settings-overflow',family,matching)
            assert not any((' | '+source+' | ') in r for r in rows
                           for source in ['Music','Effects','Fullscreen:','Stretch:','Scale:','On','Off'])
            for binding in report['settingsValueImageRepair']:
                images=[r for r in state['settingsControlDiagnostics'] if r.startswith(binding['hierarchy']+' |')]
                assert len(images)==1 and ' | enabled=False |' in images[0], (binding['hierarchy'],images)
            return state
'''
    template = template[:start] + replacement + template[end:]
    # Capture the reported Stretch Off branch even if disposable defaults differ.
    template = template.replace("        initial_stretch=d['stretch']", "        if d['stretch']:\n            command('click Canvas/OptionsMenu/Controls/FullscreenStretch'); d=settings_state(True)\n        initial_stretch=d['stretch']")
    template = template.replace("        assert d['width']==1440 and d['height']==900,(d['width'],d['height'])", "        assert d['width']>0 and d['height']>0")
    template = template.replace('One isolated settings synthetic candidate', 'One isolated actual Russian settings repair')
    # Intro visibility is bypassed by the existing FinishShowingMenu inspection command.
    # Only the actual Options, Stretch, Fullscreen and Back handlers are exercised.
    (run / 'capture-settings.py').write_text(template)
    capture_recipe = run / 'capture-settings.py'
    if args.surface == 'report':
        shutil.copy2(ROOT / 'tools/probe/capture_settings.py', run / 'capture_settings.py')
        shutil.copy2(ROOT / 'tools/probe/capture_russian_report.py', run / 'capture-report.py')
        capture_recipe = run / 'capture-report.py'
    if args.surface == 'names':
        snapshot = run / 'bridge-source'
        shutil.copy2(ROOT / 'localization/source/actor-display-ru-20261027/plan.json', run / 'actor-display-plan.json')
        source = (snapshot / 'ForestProbe.cs').read_text()
        assert source.count('public sealed class ForestProbe : MonoBehaviour') == 1
        assert source.count('if(text=="dump") Dump();') == 1
        source = source.replace('public sealed class ForestProbe : MonoBehaviour', 'public sealed partial class ForestProbe : MonoBehaviour')
        source = source.replace('if(text=="dump") Dump();', 'if(text=="actor-names") InspectActorNames();\n            else if(text=="dump") Dump();')
        (snapshot / 'ForestProbe.cs').write_text(source)
        shutil.copy2(ROOT / 'tools/probe/ActorNameProbe.cs', snapshot / 'ActorNameProbe.cs')
        compiler = Path(bridge['compiler'])
        assert sha(compiler) == bridge['compilerSha256']
        managed = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest') / DATA / 'Managed'
        refs = [managed / name for name in bridge['originalManagedReferences']]
        subprocess.run(['dotnet', str(compiler), '-nologo', '-target:library', '-nostdlib+',
                        '-out:' + str(run / 'ForestProbe.dll')] + ['-r:' + str(p) for p in refs] +
                       [str(snapshot / 'ForestProbe.cs'), str(snapshot / 'ActorNameProbe.cs')], check=True)
        shutil.copy2(run / 'ForestProbe.dll', target / 'Managed/ForestProbe.dll')
        bridge['bridgeSha256'] = sha(target / 'Managed/ForestProbe.dll')
        bridge['sourceSnapshots'] = {p.name: sha(p) for p in snapshot.glob('*.cs*')}
        bridge['actorNamesBoundary'] = 'Read all 39 actual runtime actor getters; invoke and restore original nameplate consumer in StartMenu; no dialogue/reveal/identity mutation'
        (run / 'bridge-build.json').write_text(json.dumps(bridge, indent=2) + '\n')
        shutil.copy2(ROOT / 'tools/probe/capture_settings.py', run / 'capture_settings.py')
        shutil.copy2(ROOT / 'tools/probe/capture_russian_names.py', run / 'capture-names.py')
        capture_recipe = run / 'capture-names.py'
    shutil.copy2(__file__, run / 'prepare-qa.py')
    receipt = {'preview': str(preview), 'previewBuildSha256': sha(preview / 'build.json'),
               'reusedBridgeReceipt': str(old / 'bridge-build.json'),
               'reusedBridgeReceiptSha256': sha(old / 'bridge-build.json'),
               'allOriginalManagedReferencesVerified': True,
               'bridgeSha256': sha(target / 'Managed/ForestProbe.dll'),
               'hookSha256': sha(target / 'Managed/Assembly-CSharp.dll'),
               'captureRecipeSha256': sha(capture_recipe),
               'captureSurface': args.surface,
               'commandHelperSha256': sha(run / 'command.py'),
               'introInput': 'not exercised; existing FinishShowingMenu inspection command',
               'captureMethod': 'project bridge ScreenCapture; deterministic exact game frame without desktop focus',
               'deliveryArtifactInstrumented': False}
    (run / 'qa-preparation.json').write_text(json.dumps(receipt, indent=2) + '\n')
    print('Prepared isolated actual-settings QA:', run, flush=True)


if __name__ == '__main__':
    main()
