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
    parser.add_argument('--focus-transition', action='store_true', help='Trace original focus initialization/callback/update producers; no runtime')
    args = parser.parse_args()
    assert sum([args.focus_only, args.gameplay_eligibility, args.focus_transition]) <= 1
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
    if args.focus_transition:
        watcher = 'Rewired.ReInput/UYDcZIUFzwNkgKFpAvKGoMimqAT'
        groups = {
            'ManagerFocusCallback': ('Rewired_Core.dll', 'Rewired.InputManager_Base', 'OnApplicationFocus,Update,FixedUpdate,LateUpdate,DoUpdate'),
            'FocusCallback': ('Rewired_Core.dll', 'Rewired.ReInput', 'bznJUoHKVApHghlqpCKYJLbDytar,rRujWYRgwEnOOYvDVNSFbReupcp,ZKumZMMwjLdcKigSxyxILFzYDuE,add_ApplicationFocusChangedEvent,remove_ApplicationFocusChangedEvent'),
            'FocusInitialization': ('Rewired_Core.dll', 'Rewired.ReInput', 'nKQbCtkHPOPnqlOqEQhEesshditg'),
            'WatcherInitializationUpdate': ('Rewired_Core.dll', watcher, '.ctor,jSmUMfkZCZCZfiMnleEGJnwKIqT,wweiCHaRbiDSHRzxofNoPRkDurZ,kokFAeEvpzjEkqzOXVfsybUZexs'),
            'WatcherSetUpdateEvent': ('Rewired_Core.dll', 'Rewired.Utils.Classes.Utility.ValueWatcher`1', '.ctor,Set,Update,TriggerEvent,get_value'),
            'FocusFieldReferences': ('Rewired_Core.dll', '--find-field-fragment', '::QBAmVSgbZBPmppTHWYNgMiDCmXg'),
            'ManagerInitializeCall': ('Rewired_Core.dll', '--find-call-fragment', 'Rewired.ReInput::nKQbCtkHPOPnqlOqEQhEesshditg'),
            'FocusCacheDefaults': ('Rewired_Core.dll', 'Rewired.ReInput', '.cctor'),
            'FocusCacheReferences': ('Rewired_Core.dll', '--find-field-fragment', '::cbmmwJPDGUhXqzzdtJQPbNHADIB'),
            'FocusListenerAndReset': ('Rewired_Core.dll', 'Rewired.ReInput', 'NavijpmlHmAjhDisfzPPUTADGLlI,MkbhfLFUcsGsRzkXpoCFDbyKRux,OCqSJvbpclWclSkjYkLsBbHdJUx'),
            'ReInputUpdate': ('Rewired_Core.dll', 'Rewired.ReInput', 'HXpJWkBpkWGHVPusKmSTbEJtFhLg,nlCAvFCuyFlAIRnTmvLKpOsouZf,jSmUMfkZCZCZfiMnleEGJnwKIqT'),
            'OriginalFocusEligibility': ('Rewired_Core.dll', 'Rewired.ReInput', 'get_applicationIsFocused,get_applicationRunInBackground,get_inputAllowed,IsInputAllowed'),
            'RewiredUnityFocusConsumers': ('Rewired_Core.dll', '--find-call-fragment', 'UnityEngine.Application::get_isFocused'),
            'GameUnityFocusConsumers': ('Assembly-CSharp.dll', '--find-call-fragment', 'UnityEngine.Application::get_isFocused'),
            'UnityFocusNativeBoundary': ('UnityEngine.CoreModule.dll', 'UnityEngine.Application', 'get_isFocused,InvokeFocusChanged,add_focusChanged,remove_focusChanged'),
        }
    # Compile from current sources before every extraction. A cached DLL is never authority.
    project = ROOT / 'tools/probe/InspectMethods.csproj'
    source = ROOT / 'tools/probe/InspectMethods.cs'
    source_pins = {str(p.relative_to(ROOT)): sha(p) for p in [source, project]}
    build_argv = ['dotnet', 'build', str(project), '--no-restore', '--nologo', '--verbosity', 'quiet']
    build = subprocess.run(build_argv, check=True, capture_output=True, text=True)
    assert all(sha(ROOT / p) == h for p,h in source_pins.items()), 'Inspector source changed during build'
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
        'inspectorSourceSha256': sha(source), 'inspectorBuild': {'argv': build_argv, 'exitCode': build.returncode,
            'stdout': build.stdout, 'stderr': build.stderr, 'sourcePins': source_pins}, 'commands': commands,
        'files': {name: hashlib.sha256(payload).hexdigest() for name, payload in files.items()},
        'boundary': 'Original shipped assemblies, read-only source; no native input or runtime acceptance',
    }, indent=2) + '\n')
    print('Pinned', len(groups), 'native-input consumer groups:', out)


if __name__ == '__main__':
    main()
