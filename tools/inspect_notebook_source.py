#!/usr/bin/env python3
"""Reproduce the bounded notebook dispatch and original chapter-menu trace."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]
ASSEMBLY = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/Managed/Assembly-CSharp.dll')
TREE = ROOT / 'assets/source-v2/trees/57009919ee-sharedassets0.assets-3336.json'


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    out = args.output.resolve()
    assert ROOT in out.parents
    assert sha(ASSEMBLY) == '46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
    manifest = json.loads((ROOT / 'localization/source/dialogue-manifest.json').read_text())
    assert sha(TREE) == manifest['sources'][0]['treeSha256']
    tree = json.loads(TREE.read_text())
    conversations = [c for c in tree['conversations'] if c['id'] == 225]
    assert len(conversations) == 1
    conversation = conversations[0]
    entries = conversation['dialogueEntries']
    assert len({e['id'] for e in entries}) == len(entries)
    graph = {'conversationId': 225, 'conversationFields': conversation['fields'], 'entries': entries,
             'sourceTreeSha256': sha(TREE),
             'scope': 'Complete original conversation225; technical control topology, not translation or source acceptance'}
    nodes = {e['id']: e for e in entries}
    title = lambda e: next(f['value'] for f in e['fields'] if f['title'] == 'Title')
    assert title(nodes[188]) == 'TRIGGER(notebook_unlocked)'
    assert len(nodes[188]['outgoingLinks']) == 1
    assert nodes[188]['outgoingLinks'][0]['destinationDialogueID'] == 195
    route = [129]
    while nodes[route[-1]]['outgoingLinks']:
        links = nodes[route[-1]]['outgoingLinks']
        assert len(links) == 1 and links[0]['destinationConversationID'] == 225
        destination = links[0]['destinationDialogueID']
        assert destination not in route
        route.append(destination)
    assert route == [129, 191, 192, 193, 194, 195]
    graph['primaryRoute'] = route
    graph['triggerMarker'] = {'entry': 188, 'outgoingTarget': 195,
                              'incomingCount': sum(l['destinationConversationID'] == 225 and l['destinationDialogueID'] == 188
                                                   for e in entries for l in e['outgoingLinks']),
                              'consumer': 'Loader creates ArcTriggerFireNamedTrigger for outgoing target, checked on line end'}
    methods = {
        'ChapterSelectUI': ('TheForestOfLove.ChapterSelectUI', 'RefreshChapters,FilterAvailableChapters,ShowUi,Show,Update,DoChapterSelect,SelectItemLabel,RefreshItemsMasterList'),
        'PlayMenu': ('TheForestOfLove.PlayMenu', 'OnClickStart,OnClickFastForwardDestination,InitFastForwardDestinationUI,UpdateFastForwardDestinationUI,OnClickScaleFactorUp,OnClickScaleFactorDown'),
        'MainMenuController': ('TheForestOfLove.MainMenuController', 'LoadOverworld,FastForwardGame,PlayMenuFastForward'),
        'DataService': ('TheForestOfLove.Services.Persistence.DataService', 'GenerateManifest,GetChapterRecords,GetGlobalChapterRecords,GetChapterRecordByChapter'),
        'ChapterRecord': ('TheForestOfLove.Narrative.ChapterRecord', 'Load,get_IsUnlocked'),
        'UnlockHelper': ('TheForestOfLove.UnlockHelper', 'Unlock'),
        'LoaderNamedTrigger': ('TheForestOfLove.Narrative.DialogueSystemLoader', 'AddConversationFireNamedTrigger,AddConversationFireNamedTrigger_Single'),
        'LoaderChapters': ('TheForestOfLove.Narrative.DialogueSystemLoader', 'GenerateChapters,CreateChapterRecord'),
        'LoaderArcTriggerDispatch': ('TheForestOfLove.Narrative.DialogueSystemLoader', 'AddArcPreconditionsAndTriggers'),
        'DialogueService': ('TheForestOfLove.Narrative.DialogueService', 'Handler_OnConversationLineBegin,HandleDialogueLineTriggering,Handler_OnConversationLineEnd'),
        'DialogueArcDispatch': ('TheForestOfLove.Narrative.Dialogue', 'FireArcTriggers'),
        'ArcTrigger': ('TheForestOfLove.Narrative.ArcTriggers.ArcTrigger', 'CheckTrigger,IsConditionSatisfied'),
        'ArcTriggerFireNamedTrigger': ('TheForestOfLove.Narrative.ArcTriggers.ArcTriggerFireNamedTrigger', '.ctor,OnExecute'),
    }
    files = {'conversation225.json': (json.dumps(graph, ensure_ascii=False, indent=2) + '\n').encode()}
    commands = {}
    for key, (name, selection) in methods.items():
        argv = ['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'), str(ASSEMBLY), name, selection]
        result = subprocess.run(argv, check=True, capture_output=True)
        files[key + '.il'] = result.stdout
        commands[key + '.il'] = argv
    # Prepare all content before writes. Each output is individually replaced;
    # this is a reproducible source report, not a multi-file transaction.
    out.mkdir(parents=True, exist_ok=True)
    for name, value in files.items():
        (out / name).write_bytes(value)
    evidence = {'assemblySha256': sha(ASSEMBLY), 'treeSha256': sha(TREE),
                'recipeSha256': sha(Path(__file__)), 'inspectorSourceSha256': sha(ROOT / 'tools/probe/InspectMethods.cs'),
                'commands': commands, 'files': {name: hashlib.sha256(value).hexdigest() for name, value in files.items()},
                'runtime': 'not established by this read-only source recipe'}
    (out / 'extraction.json').write_text(json.dumps(evidence, indent=2) + '\n')
    print('Verified conversation225 route129→191→192→193→194→195; marker188 binds195. Extracted13 bounded consumer groups.')


if __name__ == '__main__':
    main()
