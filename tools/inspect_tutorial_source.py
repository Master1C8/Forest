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


def ordinary_bucky(out):
    """Supplement the existing tutorial trace; inspect bytes, never game methods."""
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    from extract_assets import canonical, read_tree

    data = ASSEMBLY.parent.parent
    pins = json.loads((ROOT / 'assets/source-v2/source-files.json').read_text())
    resource_names = ['sharedassets0.assets', 'sharedassets2.assets', 'sharedassets4.assets']
    for name in resource_names + ['Managed/Assembly-CSharp.dll']:
        assert sha(data / name) == pins[name]['sha256'], name
    assert not any(p.endswith('-assets') for p in out.relative_to(ROOT).parts)
    source_pins = {str(p.relative_to(ROOT)): sha(p) for p in [
        Path(__file__), ROOT / 'tools/probe/InspectMethods.cs', ROOT / 'tools/probe/InspectMethods.csproj']}
    build_argv = ['dotnet', 'build', str(ROOT / 'tools/probe/InspectMethods.csproj'),
                  '--no-restore', '--nologo', '--verbosity', 'quiet']
    build = subprocess.run(build_argv, check=True, capture_output=True, text=True)
    inspector = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
    groups = {
        'Input': ('InputHelper', 'CheckInputsRewired,UpdateAxisInputFromKeyboard'),
        'Player': ('Player', 'get_canInteract,CheckInput,FixedUpdate'),
        'Collision': ('CollisionEventListener', 'OnTriggerEnter2D,OnTriggerStay2D,OnTriggerExit2D'),
        'ControllerTouch': ('InteractionUiController', 'Awake,Start,OnTriggerEnter2D,OnTriggerStay2D,OnTriggerExit2D,TakeControl,ReleaseControl'),
        'ControllerUi': ('InteractionUiController', 'Update,CanShow,Show,Hide,UpdateAvailableOptions,OnInterationOptionSelected'),
        'Ui': ('InteractionUi', 'Show,SetAvailableOptions,NavigateOptions'),
        'UiOptions': ('InteractionUiOption', '--fields'),
        'TriggerInput': ('Interaction.DialogueInteractionTrigger', 'Awake,AddEventListeners,Update,OnTriggerEnter2D,OnTriggerExit2D,TryActivateTrigger,CanTrigger,TryResetAuthority'),
        'TriggerBase': ('Interaction.InteractionTrigger', 'get_interactionBlocked,CanTrigger,Fire'),
        'StoryDispatch': ('Narrative.StoryManager', 'IsInferredSchema,PlayDialogue,ChooseTargetStepAndArc'),
        'OracleRoute': ('Narrative.ActorDialogueOracle', 'HasAvailableUnplayedQuestDialogue,TrackFirstEncounteredUnplayedQuestDialogue,GetFirstEncounteredUnplayedPrimaryQuestDialogue,IsUnplayedPrimaryQuestDialogue'),
        'Settings': ('DialogueSettings', 'get_ActorDbName,get_DialogueDbName,get_ArcDbName'),
        'Actor': ('Gameplay.SpawnableActor', 'get_ActorDbName'),
        'Loader': ('Narrative.DialogueSystemLoader', 'AddConversationFireNamedTrigger,AddConversationFireNamedTrigger_Single'),
        'LineEnd': ('Narrative.DialogueService', 'Handler_OnConversationLineEnd,HandleDialogueLineTriggering'),
        'ArcTrigger': ('Narrative.ArcTriggers.ArcTrigger', 'CheckTrigger,IsConditionSatisfied'),
        'NamedTrigger': ('Narrative.ArcTriggers.ArcTriggerFireNamedTrigger', '.ctor,OnExecute'),
    }
    files, commands = {}, {}
    for name, (type_, methods) in groups.items():
        argv = ['dotnet', str(inspector), str(ASSEMBLY), 'TheForestOfLove.' + type_, methods]
        files[name + '.il'] = subprocess.check_output(argv)
        commands[name + '.il'] = argv
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(data / 'Managed'))
    rows = {}
    # Exact original components only: no traversal of unrelated sprite/UI children.
    selections = {
        'sharedassets4.assets': [3761, 10354, 32067, 4950, 10581, 6864, 11316, 12178,
                               37348, 4612, 10360, 34291, 30977, 1309, 9853, 28786],
        'sharedassets2.assets': [13876, 13826],
        'sharedassets0.assets': [4519, 3336],
    }
    database = None
    input_tree = None
    for resource, selected in selections.items():
        env = UnityPy.load(str(data / resource))
        objects = {o.path_id: o for o in env.objects}
        assert len(objects) == len(env.objects)
        for pid in selected:
            obj = objects[pid]
            tree = canonical(read_tree(obj, generator))
            exports = list((ROOT / 'assets/source-v2/trees').glob(f'*-{resource}-{pid}.json'))
            # Native Transform/Collider exports are not in the MonoBehaviour inventory.
            if obj.type.name in ('GameObject', 'MonoBehaviour'):
                assert len(exports) == 1 and tree == json.loads(exports[0].read_text()), (resource, pid)
            if resource == 'sharedassets0.assets' and pid == 3336:
                database = tree
                continue
            if resource == 'sharedassets0.assets' and pid == 4519:
                input_tree = tree
                continue
            script = obj.parse_monobehaviour_head().m_Script.deref().read() if obj.type.name == 'MonoBehaviour' else None
            rows[f'{resource}:{pid}'] = dict(type=obj.type.name, tree=tree,
                rawSha256=hashlib.sha256(obj.get_raw_data()).hexdigest(),
                script=({k: getattr(script, k) for k in ['m_AssemblyName', 'm_Namespace', 'm_ClassName']} if script else None),
                externalFiles=[e.path for e in obj.assets_file.externals])
    def original(pid):
        return rows[f'sharedassets4.assets:{pid}']['tree']
    assert original(3761)['m_Name'] == 'BuckyOnNorthShore'
    assert original(32067)['actorName'] == original(34291)['actor'] == {'m_FileID': 7, 'm_PathID': 13876}
    assert rows['sharedassets4.assets:34291']['externalFiles'][6] == 'sharedassets2.assets'
    assert rows['sharedassets2.assets:13876']['tree']['m_Name'] == 'Bucky'
    assert rows['sharedassets2.assets:13826']['tree']['m_Name'] == '- Untagged -'
    assert original(34291)['dialogue'] == {'m_FileID': 7, 'm_PathID': 13826}
    assert original(34291)['arcDbName'] == ''
    assert original(28786)['dialogueInteractionTrigger']['m_PathID'] == 30977
    assert original(28786)['collisionEventListener']['m_PathID'] == original(30977)['collisionEventListener']['m_PathID'] == 37348
    assert original(30977)['settings']['m_PathID'] == 34291
    assert original(30977)['triggerOnCollision'] == original(30977)['allowTriggeringWithoutUi'] == 0
    assert original(12178)['m_IsTrigger'] and rows['sharedassets4.assets:12178']['type'] == 'CapsuleCollider2D'
    assert rows['sharedassets4.assets:32067']['script']['m_ClassName'] == 'CritterActor'
    assert rows['sharedassets4.assets:28786']['script']['m_ClassName'] == 'InteractionUiController'
    assert rows['sharedassets4.assets:30977']['script']['m_ClassName'] == 'DialogueInteractionTrigger'
    conversation, = [c for c in database['conversations'] if c['id'] == 141]
    prior = ROOT / 'localization/source/notebook-eligibility-20261027/original/original-conversations.json'
    assert conversation == next(c for c in json.loads(prior.read_text())['conversations'] if c['id'] == 141)
    nodes = {e['id']: e for e in conversation['dialogueEntries']}
    assert len(nodes) == len(conversation['dialogueEntries'])
    route = [218, 215, 217, *range(194, 213)]
    for a, b in zip(route, route[1:]):
        assert any(l['destinationConversationID'] == 141 and l['destinationDialogueID'] == b for l in nodes[a]['outgoingLinks']), (a, b)
    assert nodes[212]['outgoingLinks'] == nodes[216]['outgoingLinks'] == []
    fields = lambda eid: {f['title']: f['value'] for f in nodes[eid]['fields']}
    assert fields(192)['Title'] == 'TRIGGER(intro_from_beaver)'
    assert nodes[192]['outgoingLinks'][0]['destinationDialogueID'] == 212
    assert fields(217)['Dialogue Text'] == 'Yes' and fields(216)['Dialogue Text'] == 'No'
    user = input_tree['_userData']
    actions = [a for a in user['actions'] if a['_id'] in [0, 1, 2, 9, 10, 12, 13]]
    maps = [dict(m, actionElementMaps=[a for a in m['actionElementMaps'] if a['_actionId'] in [0, 1, 2, 9, 10, 12, 13]]) for m in user['keyboardMaps']]
    submit = [a['_keyboardKeyCode'] for m in maps if m['categoryId'] == 0 for a in m['actionElementMaps'] if a['_actionId'] == 2]
    assert submit == [306, 305, 13, 32]
    def put(name, obj):
        files[name] = (json.dumps(obj, ensure_ascii=False, indent=2) + '\n').encode()
    put('serialized-controls.json', rows)
    put('input-bindings.json', dict(actions=actions, keyboardMaps=maps,
        note='Original serialized keys only; runtime maps/focus/native key edges remain unverified for right/submit'))
    put('conversation141.json', dict(conversation=conversation, proposedRoute=route,
        primaryRoot=218, firstSubtitle=215, selectedResponse=217, successor=194,
        declinedResponse=216, triggerMarker=192, triggerLine=212,
        actors=[a for a in database['actors'] if a['id'] in [1, 3, 7]],
        boundary='Complete original graph equality, no trigger execution or runtime reachability claim'))
    assert all(sha(ROOT / p) == h for p, h in source_pins.items())
    assert all(sha(data / n) == pins[n]['sha256'] for n in resource_names)
    out.mkdir(parents=True)
    for name, payload in files.items():
        (out / name).write_bytes(payload)
    (out / 'extraction.json').write_text(json.dumps(dict(
        status='passed-source-only', sourcePins=source_pins,
        resources={n: pins[n]['sha256'] for n in resource_names},
        assemblySha256=sha(ASSEMBLY), inspectorSha256=sha(inspector),
        inspectorBuild=dict(argv=build_argv, exitCode=build.returncode, stdout=build.stdout, stderr=build.stderr),
        reusedConversationSnapshot=dict(path=str(prior.relative_to(ROOT)), sha256=sha(prior)),
        commands=commands, files={n: hashlib.sha256(b).hexdigest() for n, b in files.items()},
        gameLaunches=0, imagesOpened=0, predicatesExecuted=0,
        boundary='Independent output writes, not a transaction; require manifest plus every declared hash'), indent=2) + '\n')
    print(f'Pinned {len(groups)} consumer groups, {len(rows)} serialized objects and complete original141: {out}')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--ordinary-bucky', action='store_true', help='Read-only original ordinary Bucky input/authority/141 supplement')
    args = parser.parse_args()
    out = args.output.resolve()
    assert ROOT in out.parents and not out.exists()
    assert sha(ASSEMBLY) == '46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
    if args.ordinary_bucky:
        ordinary_bucky(out)
        return
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
