#!/usr/bin/env python3
"""Pin the original New Game and notebook interaction consumers, read-only."""
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
        'IntroForestEnd': ('TheForestOfLove.IntroForestCutscene/<>c', '<EndCutscene>b__15_0,<EndCutscene>b__15_1'),
        'DynamicConversation': ('TheForestOfLove.Narrative.DialogueService', 'PlayDialogue,BuildDynamicConversation,Handler_OnLinkedConversationStart,get_CurrentDialogueDbName,get_CurrentArcName'),
        'QuestConversation': ('TheForestOfLove.QuestConversationHelper', 'StartConversation,StartConversation_Internal'),
        'IntroForest': ('TheForestOfLove.IntroForestCutscene', 'Start,StartCutscene,EndCutscene,OnWaypointArrived,OnWaypointWaitTimeElapsed,<StartCutscene>b__14_0,<StartCutscene>b__14_1,<StartCutscene>b__14_2'),
        'IntroBunnyHouse': ('TheForestOfLove.IntroBunnyHouseCutscene', 'Start,Update,ConfigureCutsceneStage,StartCutscene,EndCutscene,FinishCleanup,<ConfigureCutsceneStage>b__23_0,<ConfigureCutsceneStage>b__23_1,<ConfigureCutsceneStage>b__23_2,<ConfigureCutsceneStage>b__23_3,<ConfigureCutsceneStage>b__23_6,<ConfigureCutsceneStage>b__23_7,<ConfigureCutsceneStage>b__23_5,<ConfigureCutsceneStage>b__23_8,<ConfigureCutsceneStage>b__23_9'),
        'IntroTriggers': ('TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1', 'OnFinishIntroForestCutscene,OnFinishIntroBunnyHouseCutscene'),
        'DialoguePreconditions': ('TheForestOfLove.Narrative.Dialogue', 'get_isPreconditionSatisfied,CheckIfPreconditionSatisfied'),
        'NewGame': ('TheForestOfLove.MainMenuController', 'PlayMenuStart,StartNewGame,LoadOverworld,DeleteLocalSavestate,DeleteGlobalSavestate'),
        'ChapterInitial': ('TheForestOfLove.ChapterSelectUI', 'FilterAvailableChapters,RefreshChapters,Start,Show,Update'),
        'ActorOracle': ('TheForestOfLove.Narrative.ActorDialogueOracle', 'IsAvailableSingleDialogue,IsAvailableSingleDialogueWithUnplayedPrimaryArcs,GetSingleDialogue,IsUnplayedPrimaryQuestDialogue,IsAvailableGossip,IsAvailableUnplayedGossip'),
        'InteractionTrigger': ('TheForestOfLove.Interaction.DialogueInteractionTrigger', 'CanTrigger,TryActivateTrigger,OnTriggerEnter2D'),
        'InteractionUi': ('TheForestOfLove.InteractionUiController', 'CanShow,OnInterationOptionSelected,UpdateAvailableOptions'),
        'StorySelection': ('TheForestOfLove.Narrative.StoryManager', 'ChooseTargetStepAndArc,IsInferredSchema'),
    }
    inspector = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
    files = {}
    commands = {}
    for name, (type_name, methods) in groups.items():
        argv = ['dotnet', str(inspector), str(ASSEMBLY), type_name, methods]
        files[name + '.il'] = subprocess.check_output(argv)
        commands[name + '.il'] = argv
    tree_path = ROOT / 'assets/source-v2/trees/57009919ee-sharedassets0.assets-3336.json'
    manifest = json.loads((ROOT / 'localization/source/dialogue-manifest.json').read_text())
    assert sha(tree_path) == manifest['sources'][0]['treeSha256']
    tree = json.loads(tree_path.read_text())
    intro = next(c for c in tree['conversations'] if c['id'] == 145)
    wrapper = next(c for c in tree['conversations'] if c['id'] == 109)
    fields = lambda e: {f['title']: f['value'] for f in e['fields']}
    assert fields(wrapper)['Title'] == 'system/dynamicConversation'
    assert [(e['id'], fields(e)['Title']) for e in wrapper['dialogueEntries'][:3]] == [(0, 'START'), (5, 'PASSTHROUGH'), (8, 'DYNAMICROOT')]
    arcs = ['red_double_take', 'red_recognizes_rock', 'red_recognizes_tree',
            'red_feeling_woozy', 'bunny_is_concerned', 'bunny_says_hello']
    assert set(arcs) <= {fields(e)['Title'] for e in intro['dialogueEntries']}
    graph = {'conversationId': 145, 'sourceTreeSha256': sha(tree_path), 'entries': intro['dialogueEntries'],
             'wrapper': {'conversationId': 109, 'bootstrapEntries': [0, 5, 8],
                         'narrativeDbName': 'NewGame_Intro', 'allowedArcs': arcs},
             'scope': 'Normal145 content only;109 bootstrap metadata waits for original dynamic links, without Continue or graph mutation'}
    files['intro-graph.json'] = (json.dumps(graph, ensure_ascii=False, indent=2) + '\n').encode()
    files['dynamic-wrapper.json'] = (json.dumps({'conversation': wrapper, 'sourceTreeSha256': sha(tree_path),
        'scope': 'Original dynamic wrapper; content links built at runtime, no translation or manufactured routing'}, ensure_ascii=False, indent=2) + '\n').encode()
    out.mkdir(parents=True)
    for name, value in files.items():
        (out / name).write_bytes(value)
    (out / 'extraction.json').write_text(json.dumps({
        'scope': 'Supplemental original new-game and actor-interaction consumers; no frozen inventory edits',
        'assemblySha256': sha(ASSEMBLY), 'treeSha256': sha(tree_path), 'recipeSha256': sha(Path(__file__)),
        'inspectorSourceSha256': sha(ROOT / 'tools/probe/InspectMethods.cs'),
        'commands': commands, 'files': {n: hashlib.sha256(v).hexdigest() for n, v in files.items()},
        'runtime': 'not established by source extraction'}, indent=2) + '\n')
    print('Pinned', len(groups), 'original consumer groups:', out)

if __name__ == '__main__':
    main()
