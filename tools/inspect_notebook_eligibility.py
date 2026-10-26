#!/usr/bin/env python3
"""Pin original notebook eligibility consumers and existing read-only observations.

This supplement never evaluates a game condition or changes the frozen source family.
Use a new output directory; each file write is separate, not a transaction.
"""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]
ASSEMBLY = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/Managed/Assembly-CSharp.dll')
ASSEMBLY_SHA = '46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
TREE = ROOT / 'assets/source-v2/trees/57009919ee-sharedassets0.assets-3336.json'
TREE_SHA = '41749d8b093ab438a9fc73519993809cee8b1288c5fbc6fab46782a1b899d69b'
RUN = ROOT / 'localization/probes/ru-20261026-48'
OBSERVATIONS = {
    'notebook-route.json': '64ac868647a275e8a215264bca9777cd0473bc717b40e0a731f53089c9df0730',
    'tutorial-route.json': 'ab3ea140084632f257c54884319b3f5159afa5bcca41c718bdff4cc084957ef8',
}
PRIOR_TRIGGER = ROOT / 'localization/source/tutorial-20261026/TutorialTriggers.il'
PRIOR_TRIGGER_SHA = '3cc9f17587f1fb2d18b24d5bfc54fdce7c0e6390fbcfde1b460382c13aa993f3'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(path):
    return json.loads(path.read_text())


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    out = parser.parse_args().output.resolve()
    assert ROOT in out.parents and not out.exists(), 'New canonical-project output required'
    assert not any(p.endswith('-assets') for p in out.relative_to(ROOT).parts)
    assert sha(ASSEMBLY) == ASSEMBLY_SHA
    assert sha(TREE) == TREE_SHA
    for name, expected in OBSERVATIONS.items():
        assert sha(RUN / name) == expected, name
    assert sha(PRIOR_TRIGGER) == PRIOR_TRIGGER_SHA
    observed = read(RUN / 'notebook-route.json')
    assert observed['scene'] == 'StartMenu'
    assert (observed['company'], observed['product']) == ('VNRevivalQA', 'ForestRuRendererProbe')
    conditions = {}
    for row in observed['diagnostics']:
        if not row.startswith('notebookCondition | field='):
            continue
        key = row.removeprefix('notebookCondition | field=').split(' | ', 1)[0]
        tail = row.split(' | ', 2)[2]
        kind, value = tail.split('=', 1)
        assert kind in ('value', 'values') and key not in conditions
        conditions[key] = {kind: value}
    assert conditions['DialoguePreconditionFullAvailabilityRule.questsAll.quests'] == {'values': 'Quest(Act1_TutorialQuest)'}
    assert conditions['DialoguePreconditionFullAvailabilityRule.tagsAll.tags'] == {'values': 'Tag(Main Act 1)'}
    assert conditions['DialoguePreconditionFullAvailabilityRule.antiTagsAny.tags'] == {'values': 'Tag(Instanced Event)'}
    tutorial = read(RUN / 'tutorial-route.json')
    assert tutorial['scene'] == 'StartMenu'
    tree = read(TREE)
    ids = [120, 141, 142, 143, 128, 129, 225]
    selected = [next(c for c in tree['conversations'] if c['id'] == id_) for id_ in ids]
    assert all(sum(c['id'] == id_ for c in tree['conversations']) == 1 for id_ in ids)
    # Preserve complete original records, including disconnected trigger markers,
    # conditions, source order, actors, links and empty/control fields.
    graphs = {'sourceTreeSha256': TREE_SHA, 'conversationIds': ids, 'conversations': selected}
    prefix = 'TheForestOfLove.Narrative.'
    pre = prefix + 'DialoguePreconditions.'
    groups = {
        'FullAvailability': (pre + 'DialoguePreconditionFullAvailabilityRule', 'IsConditionSatisfied'),
        'ConditionBase': (pre + 'DialoguePrecondition', 'get_IsSatisfied'),
        'PrecedingQuests': (pre + 'DialoguePreconditionPrecedingQuests', 'IsConditionSatisfied'),
        'PrecedingTags': (pre + 'DialoguePreconditionPrecedingTags', 'IsConditionSatisfied'),
        'ChanceState': (pre + 'DialoguePreconditionPercentChance', 'IsConditionSatisfied,CheckCondition'),
        'QuestCompletion': (prefix + 'Quest', 'get_isCompleted,SetStatusCompleted,IsAvailableWithTags'),
        'DialogueCompletion': (prefix + 'Dialogue', 'SetStatusCompleted,FireDialogueTriggers,CheckIfPreconditionSatisfied'),
        'StoryCompletion': (prefix + 'StoryManager', 'OnDialogueStatusCompleted,HandleDialogueEndFinishOrCancel'),
        'StorySelection': (prefix + 'StoryManager', 'HasNewMainQuest,HasQuestToTurnIn,HasAvailableMessages'),
        'OracleSelection': (prefix + 'ActorDialogueOracle', 'IsUnplayedPrimaryQuestDialogue,GetFirstEncounteredUnplayedPrimaryQuestDialogue'),
        'TriggerAction': ('TheForestOfLove.Narrative.NarrativeActions', 'ActivateTrigger,CompleteQuest'),
        'CompleteQuestHelper': ('TheForestOfLove.QuestTriggerHelper', 'CompleteQuest'),
        'CompleteQuestTrigger': (prefix + 'DialogueTriggers.DialogueTriggerCompleteQuest', 'OnExecute'),
        'DialogueTriggerDispatch': (prefix + 'DialogueTriggers.DialogueTrigger', 'Execute'),
        'InteractionModes': (prefix + 'QuestManagerInteractionMode', '--fields'),
        'DialogueTypes': (prefix + 'DialogueType', '--fields'),
    }
    inspector = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
    files = {
        'original-conversations.json': (json.dumps(graphs, ensure_ascii=False, indent=2) + '\n').encode(),
        'loaded-notebook-conditions.json': (json.dumps({
            'source': str((RUN / 'notebook-route.json').relative_to(ROOT)),
            'sourceSha256': OBSERVATIONS['notebook-route.json'],
            'scene': observed['scene'], 'fields': conditions,
            'identityAndTriggerRows': [r for r in observed['diagnostics'] if r.startswith(('notebookDialogue |', 'notebookTrigger |'))],
            'tutorialRows': [r for r in tutorial['diagnostics'] if r.startswith(('guards |', 'activeTags |', 'quest |', 'questDialogue |', 'primaryArc |'))],
            'boundary': 'Existing read-only StartMenu snapshot; no condition evaluation, gameplay availability or post-tutorial state measured'
        }, ensure_ascii=False, indent=2) + '\n').encode(),
    }
    trigger_lines = PRIOR_TRIGGER.read_text().splitlines(keepends=True)
    start = next(i for i, line in enumerate(trigger_lines) if line.startswith('IL_020c:'))
    stop = next(i for i, line in enumerate(trigger_lines) if line.startswith('IL_02ce:'))
    files['TutorialCompletion.excerpt.il'] = (''.join(trigger_lines[:2]) + ''.join(trigger_lines[start:stop])).encode()
    commands = {}
    for key, (type_, methods) in groups.items():
        argv = ['dotnet', str(inspector), str(ASSEMBLY), type_, methods]
        files[key + '.il'] = subprocess.check_output(argv)
        commands[key + '.il'] = argv
    # Do all reads/inspection before writing any output. An interrupted write is
    # incomplete until the manifest exists and every declared hash verifies.
    assert sha(ASSEMBLY) == ASSEMBLY_SHA and sha(TREE) == TREE_SHA
    out.mkdir(parents=True)
    for name, data in files.items():
        (out / name).write_bytes(data)
    receipt = {'scope': 'Bounded notebook eligibility/source topology supplement, not full source or runtime acceptance',
               'assemblySha256': ASSEMBLY_SHA, 'treeSha256': TREE_SHA,
               'recipeSha256': sha(Path(__file__)), 'inspectorSourceSha256': sha(ROOT / 'tools/probe/InspectMethods.cs'),
               'inspectorBinarySha256': sha(inspector), 'commands': commands,
               'observations': {str((RUN / n).relative_to(ROOT)): h for n, h in OBSERVATIONS.items()},
               'reusedTriggerMethod': {'path': str(PRIOR_TRIGGER.relative_to(ROOT)), 'sha256': PRIOR_TRIGGER_SHA,
                                       'excerpt': 'Exact source lines IL_020c inclusive to IL_02ce exclusive; not a standalone executable method'},
               'files': {n: hashlib.sha256(b).hexdigest() for n, b in files.items()},
               'gameLaunched': False, 'imagesOpened': 0, 'sourceInventoryChanged': False}
    (out / 'extraction.json').write_text(json.dumps(receipt, indent=2) + '\n')
    print(f'Pinned {len(groups)} original consumer groups, {len(conditions)} loaded fields and {len(ids)} complete conversations in {out}')


if __name__ == '__main__':
    main()
