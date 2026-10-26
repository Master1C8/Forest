#!/usr/bin/env python3
"""Pin original Continue/save/respawn consumers without executing game code."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]
ASSEMBLY = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/Managed/Assembly-CSharp.dll')


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    out = parser.parse_args().output.resolve()
    assert ROOT in out.parents and not out.exists()
    assert sha(ASSEMBLY) == '46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
    groups = {
        'PlayContinue': ('PlayMenu', 'Awake,Start,get_showContinueButton,OnClickContinue'),
        'MenuContinue': ('MainMenuController', 'Start,MainMenuPlay,PlayMenuContinue,ContinueSavedGame,OnMainMenuFadedOut,LoadOverworld'),
        'BeginPlaySession': ('Events.GameStateManager', 'Start,BeginPlaySession'),
        'BeginPlayCallback': ('Events.GameStateManager/<>c', '<Start>b__34_0'),
        'SaveManager': ('Services.Persistence.SaveManager', 'Awake,get_HasSavedPlaySession,ReadDataFromDisk,Save,WriteDataToDisk'),
        'SaveFileRead': ('Services.Persistence.SavegameFileHelper', 'get_savingEnabled,.cctor,ReadSavegameData,ReadDataFromGameDirectory,CleanupLegacySavegameFiles,CleanupLegacySavegameFiles_Intermediate'),
        'SaveFileWrite': ('Services.Persistence.SavegameFileHelper', 'WriteSavegameData,WriteDataToGameDirectory'),
        'SettingsRead': ('Services.Persistence.GlobalSavegameFileHelper', 'ReadGlobalData,ReadDataFromGameDirectory,CleanupLegacyGlobalFiles,CleanupLegacyGlobalFiles_Intermediate'),
        'ManifestRestore': ('Services.Persistence.DataService', 'get_Manifest,GenerateManifest,GetPlayerRespawnData,GetGeneralData'),
        'RespawnLoad': ('Services.Persistence.PlayerRespawnData', 'Load'),
        'RespawnFields': ('Services.Persistence.PlayerRespawnData', '--fields'),
        'SavedRespawnFields': ('Services.Persistence.SavegamePlayerRespawnData', '--fields'),
        'GeneralFields': ('Services.Persistence.GeneralData', '--fields'),
        'NormalLoadScene': ('ChapterSelectUI', 'Start,OnSceneLoaded'),
        'SpawnPlayer': ('SpawnManager', 'Start,OnActiveSceneChanged,FinishSpawningPlayer,RespawnPlayerAtExactPosition'),
        'SavePlayer': ('Player', 'Save'),
    }
    inspector = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
    argv = ['dotnet', str(inspector), str(ASSEMBLY)]
    files, commands = {}, {}
    for name, (type_name, methods) in groups.items():
        exact_type = 'TheForestOfLove.' + type_name
        if methods != '--fields':
            listing = subprocess.check_output(argv + [exact_type, '--list'], text=True)
            assert all('::' + method + '(' in listing for method in methods.split(',')), (exact_type, methods)
        command = argv + [exact_type, methods]
        files[name + '.il'] = subprocess.check_output(command)
        commands[name + '.il'] = command
    serialization = ASSEMBLY.with_name('Auto-asmdef-FirstPass.dll')
    serialization_groups = {
        'ES3Path': ('ES3Settings', 'get_FullPath'),
        'ES3Directory': ('ES3/Directory', '--fields'),
        'ES3Location': ('ES3/Location', '--fields'),
    }
    for name, (type_name, methods) in serialization_groups.items():
        command = ['dotnet', str(inspector), str(serialization), type_name, methods]
        files[name + '.il'] = subprocess.check_output(command)
        commands[name + '.il'] = command
    out.mkdir(parents=True)
    for name, value in files.items():
        (out / name).write_bytes(value)
    (out / 'extraction.json').write_text(json.dumps({
        'assemblySha256': sha(ASSEMBLY), 'serializationAssemblySha256': sha(serialization),
        'recipeSha256': sha(Path(__file__)),
        'inspectorSourceSha256': sha(ROOT / 'tools/probe/InspectMethods.cs'),
        'inspectorBinarySha256': sha(inspector), 'commands': commands,
        'files': {name: hashlib.sha256(value).hexdigest() for name, value in files.items()},
        'boundary': 'Read-only original IL supplement; no runtime, fixture edits or shared inventory changes'
    }, indent=2) + '\n')
    print('Pinned', len(files), 'original Continue/save/respawn consumer groups:', out)


if __name__ == '__main__':
    main()
