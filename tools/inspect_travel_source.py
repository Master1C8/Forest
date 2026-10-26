#!/usr/bin/env python3
"""Pin original travel/input consumers and BunnyHouse doorway geometry, without launch."""
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
    out = parser.parse_args().output.resolve()
    assert ROOT in out.parents and not out.exists()
    pins = json.loads((ROOT / 'assets/source-v2/source-files.json').read_text())
    # Native scene identity comes from BuildSettings, never from a doorway label.
    for name in ['globalgamemanagers', 'level3']:
        assert sha(DATA / name) == pins[name]['sha256']
    assemblies = {
        'Assembly-CSharp.dll': '46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf',
        'Auto-asmdef-SecondPass.dll': '6731a288369fcddc227f5baf601d6ca2f5843e7154184a3dcb4a0d21fb414802',
        'Rewired_Core.dll': '591d0f9429e66821a4edea6d0c09acc0d78da6512e717b5652c4572f52e2d0bf',
    }
    inspector = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
    groups = {
        'InputProduction': ('Assembly-CSharp.dll', 'TheForestOfLove.InputHelper',
                            'Awake,CheckInputsRewired,GetAxisValueCallback,GetButtonValueCallback'),
        'Joystick-fields': ('Auto-asmdef-SecondPass.dll', 'Itelisoft.KOF.TheKingOfJoysticks', '--fields'),
        'JoystickLifecycle': ('Auto-asmdef-SecondPass.dll', 'Itelisoft.KOF.TheKingOfJoysticks',
                              'Awake,Start,LateUpdate,get_DisableJoystickInput'),
        'JoystickMouse': ('Auto-asmdef-SecondPass.dll', 'Itelisoft.KOF.TheKingOfJoysticks',
                          'UpdateMouseMode,MouseDown,MouseUp,ValidateMouseMode'),
        'JoystickTouch': ('Auto-asmdef-SecondPass.dll', 'Itelisoft.KOF.TheKingOfJoysticks',
                          'UpdateTouchMode,ValidateTouchMode'),
        'JoystickAxes': ('Auto-asmdef-SecondPass.dll', 'Itelisoft.KOF.TheKingOfJoysticks',
                         'GetAxisX,GetAxisY,TranslateCenter,IsPositionOutOfBounds'),
        'TouchVisibility': ('Assembly-CSharp.dll', 'TheForestOfLove.TouchInputHelper',
                            'ShowUi,HideUi,ShowButtonsDefaultState,Update,LateUpdate'),
        'PlayerReadOnly': ('Assembly-CSharp.dll', 'TheForestOfLove.Player',
                           'get_playerState,get_lanternTransitioning,get_sweaterTransitioning,get_waypointController'),
        'WaypointReadOnly': ('Assembly-CSharp.dll', 'TheForestOfLove.WaypointController',
                             'get_HasWaypoints'),
        'RewiredConfigReads': ('Rewired_Core.dll', 'Rewired.ReInput/ConfigHelper',
                               'get_ignoreInputWhenAppNotInFocus,get_nativeKeyboardSupport,get_alwaysUseUnityInput'),
        'RewiredPlayerReads': ('Rewired_Core.dll', 'Rewired.Player', 'get_id,get_name'),
    }
    files, commands = {}, {}
    for name, (assembly, typename, methods) in groups.items():
        path = DATA / 'Managed' / assembly
        assert sha(path) == assemblies[assembly]
        argv = ['dotnet', str(inspector), str(path), typename, methods]
        files[name + '.il'] = subprocess.check_output(argv)
        commands[name + '.il'] = argv
    managers = UnityPy.load(str(DATA / 'globalgamemanagers'))
    settings = next(o.read_typetree() for o in managers.objects if o.type.name == 'BuildSettings')
    scenes = settings['scenes']
    assert Path(scenes[3]).stem == 'BunnyHouse'
    objects = {o.path_id: o for o in UnityPy.load(str(DATA / 'level3')).objects}
    original = ROOT / 'assets/source-v2/trees/387b8e8247-level3-303.json'
    doorway = json.loads(original.read_text())
    assert doorway['sceneName'] == 'CentralForest' and doorway['m_GameObject']['m_PathID'] == 91
    geometry = {'sceneBuildIndex': 3, 'scenePath': scenes[3], 'sourceFile': 'level3',
                'doorwayComponentPathId': 303, 'doorwayTree': doorway,
                'doorwayTreeSha256': sha(original), 'components': [], 'ancestors': []}
    go = objects[91].read_typetree()
    for component in go['m_Component']:
        obj = objects[component['component']['m_PathID']]
        if obj.type.name in ['Transform', 'BoxCollider2D', 'CircleCollider2D', 'Rigidbody2D']:
            geometry['components'].append({'pathId': obj.path_id, 'type': obj.type.name,
                                           'tree': obj.read_typetree()})
    transform = next(row for row in geometry['components'] if row['type'] == 'Transform')['pathId']
    while transform:
        tree = objects[transform].read_typetree()
        go = objects[tree['m_GameObject']['m_PathID']].read_typetree()
        geometry['ancestors'].append({'transformPathId': transform, 'name': go['m_Name'],
                                     'activeSelf': go['m_IsActive'], 'transform': tree})
        assert tree['m_Father']['m_FileID'] == 0
        transform = tree['m_Father']['m_PathID']
    files['doorway-geometry.json'] = (json.dumps(geometry, indent=2) + '\n').encode()
    input_tree = ROOT / 'assets/source-v2/trees/57009919ee-sharedassets0.assets-4519.json'
    user = json.loads(input_tree.read_text())['_userData']
    input_config = {'sourceTree': str(input_tree.relative_to(ROOT)), 'sourceTreeSha256': sha(input_tree),
                    'configVars': user['configVars'], 'players': user['players'],
                    'actions': [a for a in user['actions'] if a['_id'] in [0, 1, 12, 13]],
                    'keyboardMaps': user['keyboardMaps'], 'mapCategories': user['mapCategories'],
                    'customControllers': user['customControllers'],
                    'boundary': 'Original serialized configuration only; current runtime focus/maps require separate observation'}
    files['input-configuration.json'] = (json.dumps(input_config, indent=2) + '\n').encode()
    out.mkdir(parents=True)
    for name, payload in files.items():
        (out / name).write_bytes(payload)
    (out / 'extraction.json').write_text(json.dumps({
        'assemblies': assemblies, 'sourceFiles': {name: sha(DATA / name) for name in ['globalgamemanagers', 'level3']},
        'recipeSha256': sha(Path(__file__)), 'inspectorSha256': sha(inspector),
        'inspectorSourceSha256': sha(ROOT / 'tools/probe/InspectMethods.cs'),
        'commands': commands, 'files': {name: hashlib.sha256(value).hexdigest() for name, value in files.items()},
        'boundary': 'Supplemental read-only source; no game launch, image, input injection or frozen-input change'
    }, indent=2) + '\n')
    print('Pinned', len(groups), 'consumer groups and original BunnyHouse doorway geometry:', out)


if __name__ == '__main__':
    main()
