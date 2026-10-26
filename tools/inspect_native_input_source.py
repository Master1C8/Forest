#!/usr/bin/env python3
"""Pin the shipped native keyboard producer and public background policy, without launch."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]
MANAGED = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/Managed')


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    parser.add_argument('--focus-only', action='store_true', help='Read-only supplemental watcher/eligibility bindings; preserve original extraction')
    parser.add_argument('--gameplay-eligibility', action='store_true', help='Read-only original player map getters for strict gameplay eligibility')
    args = parser.parse_args()
    out = args.output.resolve()
    assert ROOT in out.parents and not out.exists()
    refs = json.loads((ROOT / 'localization/probes/ru-20261026-25/bridge-build.json').read_text())['originalManagedReferences']
    inspector = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
    groups = {
        'BackgroundPolicy': ('Rewired_Core.dll', 'Rewired.ReInput/ConfigHelper', 'set_ignoreInputWhenAppNotInFocus,get_ignoreInputWhenAppNotInFocus'),
        'NativeKeyboardUpdate': ('Rewired_Windows.dll', 'aUzJnDdLagLcYhSjJnsRTHTqyRC', 'ZXuGbUVrsKcbexFubWFQFBrecCK'),
        'NativeKeyboardEvents': ('Rewired_Windows.dll', 'aUzJnDdLagLcYhSjJnsRTHTqyRC', 'pmEkkkanGSbOAFLCwZTkNgBKQei'),
        'NativeKeyboardConstructor': ('Rewired_Windows.dll', 'aUzJnDdLagLcYhSjJnsRTHTqyRC', '.ctor,get_inputSource'),
        'KeyboardPublicRead': ('Rewired_Core.dll', 'Rewired.Keyboard', 'GetKey'),
        'OriginalKeyboardAxes': ('Assembly-CSharp.dll', 'TheForestOfLove.InputHelper', 'UpdateAxisInputFromKeyboard'),
        'PolicyFollowup': ('Rewired_Core.dll', 'Rewired.ReInput', 'IsInputAllowed,qlBFRJWraZKrzfOnAGXcGDaGoOh'),
        'PolicyAllowed': ('Rewired_Core.dll', 'Rewired.ReInput', 'get_inputAllowed,sXSmojTfsGWqzEIEtxKcdoWFQcy'),
        'NativeKeyboardStateAPI': ('Rewired_Windows.dll', '--find-native', 'GetKeyboardState'),
        'NativeAsyncKeyAPI': ('Rewired_Windows.dll', '--find-native', 'GetAsyncKeyState'),
    }
    if args.focus_only:
        groups = {
            'Eligibility': ('Rewired_Core.dll', 'Rewired.ReInput', 'get_inputAllowed,IsInputAllowed'),
            'EligibilityFields': ('Rewired_Core.dll', 'Rewired.ReInput', '--fields'),
            'FocusWatcherFields': ('Rewired_Core.dll', 'Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT', '--fields'),
            'WatcherValue': ('Rewired_Core.dll', 'Rewired.Utils.Classes.Utility.ValueWatcher`1', 'get_value'),
            'EditorEligibility': ('Rewired_Core.dll', 'Rewired.ReInput', 'get_isEditor,get_isAllowedEditorWindowFocused,get_isUnityEditorFocused,get_isReady'),
        }
    if args.gameplay_eligibility:
        assert not args.focus_only
        groups = {
            'Eligibility': ('Rewired_Core.dll', 'Rewired.ReInput', 'get_inputAllowed,IsInputAllowed'),
            'WatcherValue': ('Rewired_Core.dll', 'Rewired.Utils.Classes.Utility.ValueWatcher`1', 'get_value'),
            'KeyboardMaps': ('Rewired_Core.dll', 'Rewired.Player/ControllerHelper/MapHelper', 'GetAllMaps'),
            'KeyboardMapIterator': ('Rewired_Core.dll', 'Rewired.Player/ControllerHelper/MapHelper/yvtMLgqhSABcamdBxBRhiFddGugS', 'MoveNext'),
            'KeyCodeConversion': ('Rewired_Core.dll', 'Rewired.Keyboard', 'KeyboardKeyCodeToKeyCode'),
            'MapGetters': ('Rewired_Core.dll', 'Rewired.ControllerMap', 'get_sourceMapId,get_categoryId,get_layoutId,get_enabled,get_AllMaps'),
            'BindingGetters': ('Rewired_Core.dll', 'Rewired.ActionElementMap', 'get_actionId,get_elementType,get_axisRange,get_invert,get_axisContribution,get_modifierKey1,get_modifierKey2,get_modifierKey3,get_keyCode,get_enabled'),
        }
    commands, files = {}, {}
    for name, (assembly, typename, methods) in groups.items():
        assert sha(MANAGED / assembly) == refs[assembly]
        argv = ['dotnet', str(inspector), str(MANAGED / assembly), typename, methods]
        commands[name] = argv
        files[name + '.il'] = subprocess.check_output(argv)
    out.mkdir(parents=True)
    for name, payload in files.items():
        (out / name).write_bytes(payload)
    (out / 'extraction.json').write_text(json.dumps({
        'assemblies': {assembly: refs[assembly] for assembly, _, _ in groups.values()},
        'recipeSha256': sha(Path(__file__)), 'inspectorSha256': sha(inspector),
        'inspectorSourceSha256': sha(ROOT / 'tools/probe/InspectMethods.cs'), 'commands': commands,
        'files': {name: hashlib.sha256(payload).hexdigest() for name, payload in files.items()},
        'boundary': 'Original shipped assemblies, read-only source; no native input or runtime acceptance',
    }, indent=2) + '\n')
    print('Pinned', len(groups), 'native-input consumer groups:', out)


if __name__ == '__main__':
    main()
