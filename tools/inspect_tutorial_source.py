#!/usr/bin/env python3
"""Extract bounded original tutorial/interaction consumers without executing game code."""
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
        'TutorialTriggers': ('Events.TriggerHandlers.TriggerHandlerAct1', 'ExecuteTrigger'),
        'TutorialIntroduction': ('TutorialQuestBunnyIntroduction', 'Start,RegisterServices,Show_TurnInQuest,Show_NewQuestAvailable,Show_RepromptQuest,Show_ContinueTopic,StartCutsceneConversation,Cleanup'),
        'CentralForestSpawn': ('Content.CentralForestSpawner', 'SpawnObjects'),
        'QuestState': ('Narrative.Quest', 'get_status,get_isStarted,get_isCompleted,IsAvailableWithTags'),
        'DialogueState': ('Narrative.Dialogue', 'get_status,get_isStarted,get_isCompleted,get_firstPrimaryArcPlayed,get_allPrimaryArcsPlayed'),
        'ArcState': ('Narrative.Arc', 'get_status,get_isPlayed,get_isSkipped'),
        'QuestHelpers': ('QuestTriggerHelper', 'LoadQuestStatus,IsTriggerFired,PlayerFinishedIntroTutorial'),
        'DataReads': ('Services.Persistence.DataService', 'GetQuests,GetQuestByDbName,GetActiveTags,IsTagActive,GetTagByDbName,GetDialogues,GetDialogueByDbName,GetTriggerByName'),
        'InteractionAuthority': ('InteractionUiController', 'get_isAuthority,get_isVisible,CanShow,OnInterationOptionSelected'),
        'InteractionUiState': ('InteractionUi', 'get_visible,get_locked,get_currentSelectedOption'),
        'InteractionTriggerState': ('Interaction.DialogueInteractionTrigger', 'get_IsAuthority,get_interactionMode,get_dialogueDbName,get_arcDbName,CanTrigger,TryActivateTrigger'),
        'ActorIdentity': ('Gameplay.SpawnableActor', 'get_ActorDbName'),
        'SettingsIdentity': ('DialogueSettings', 'get_ActorDbName,get_DialogueDbName,get_ArcDbName'),
    }
    fields = ['Narrative.Quest', 'Narrative.Tag', 'Narrative.Trigger', 'Narrative.Dialogue', 'Narrative.Arc',
              'InteractionUiController', 'InteractionUi', 'InteractionUiOption', 'Interaction.DialogueInteractionTrigger',
              'Gameplay.SpawnableActor', 'DialogueSettings', 'Player', 'TutorialQuestBunnyIntroduction']
    for name in fields:
        groups[name.replace('.', '-') + '-fields'] = (name, '--fields')
    inspector = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
    files, commands = {}, {}
    for name, (type_name, methods) in groups.items():
        argv = ['dotnet', str(inspector), str(ASSEMBLY), 'TheForestOfLove.' + type_name, methods]
        files[name + '.il'] = subprocess.check_output(argv)
        commands[name + '.il'] = argv
    tree_path = ROOT / 'assets/source-v2/trees/57009919ee-sharedassets0.assets-3336.json'
    tree = json.loads(tree_path.read_text())
    selected = [c for c in tree['conversations'] if c['id'] in [120, 141, 142, 143, 128, 129]]
    assert len(selected) == 6
    files['tutorial-graphs.json'] = (json.dumps({'sourceTreeSha256': sha(tree_path), 'conversations': selected,
        'scope': 'Original tutorial conversations only; source IDs and fields preserved; no routing overrides'},
        ensure_ascii=False, indent=2) + '\n').encode()
    out.mkdir(parents=True)
    for name, value in files.items():
        (out / name).write_bytes(value)
    (out / 'extraction.json').write_text(json.dumps({
        'assemblySha256': sha(ASSEMBLY), 'treeSha256': sha(tree_path), 'recipeSha256': sha(Path(__file__)),
        'inspectorSourceSha256': sha(ROOT / 'tools/probe/InspectMethods.cs'), 'commands': commands,
        'files': {name: hashlib.sha256(value).hexdigest() for name, value in files.items()},
        'boundary': 'Read-only supplemental evidence; no frozen inventory/glossary change; no runtime evaluation'
    }, indent=2) + '\n')
    print('Pinned', len(groups), 'consumer/field groups and six original tutorial graphs:', out)


if __name__ == '__main__':
    main()
