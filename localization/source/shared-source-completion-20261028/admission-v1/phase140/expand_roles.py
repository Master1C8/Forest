"""Authored playback23 subset of the assigned loader/playback77 packet.

Extends the existing source admission recipe. The remaining54 loader operands
are explicit unread-consumer holds, even where complete original IL is saved.
No translations, inferred semantic pass rows, CLR execution or extraction.
"""
import hashlib
import json
import re
from collections import Counter
from pathlib import Path
from phase138.expand_roles import method_bodies

HERE = Path(__file__).resolve().parent
OUT = HERE.parent
ROOT = OUT.parents[3]
INDEX = ROOT / 'outputs/pause-inventory-bio-completion-20261028/managed-index/literals.jsonl'
SPECS = {
    'PlayDialoguePlayerQuestion': {'W': '22', 'T': '92'},
    'PlayDynamicFastTravelDialogue': {'T': '5a'},
    'Handler_OnLinkedConversationStart': {'W': '133'},
    'HandleDialogueLineActor': {'W': '78'},
    'BuildDynamicConversation': {'C': '29', 'E': '35 42 4f 5c', 'Q': '8f'},
    'ResetDynamicConversation': {'C': 'f', 'E': '1a 26 32 3d'},
    'SetDialogueSystemBoolCondition': {'K': '0'},
    'SetDialogueSystemBranchCondition': {'K': '0'},
    'BuildFastTravelConversation': {'C': '27', 'E': '3a 47 68'},
    'LogPlayedDialogue': {'H': '0'},
}
ROLES = dict(W='display-conditional-unity-log-wording', T='preserve-conversation-trigger-identity',
             C='preserve-database-identity', E='preserve-dialogue-entry-title-identity',
             Q='preserve-conversation-title-template', K='preserve-lua-variable-key',
             H='preserve-history-report-event-prefix')
REASONS = {
    'W': 'Actual error wording, not a lookup/control input. Unity Debug.LogError enters Application.logMessageReceived at the native Unity boundary; enabled DevConsole subscribes, applies attachedLogLevel, constructs EntryData from the message and routes it through LogError to rendered console text. Conditional display source retained; actual component activation, mask and runtime reachability untested.',
    'T': 'Exact DialogueSystemTrigger.conversation field value. Fire calls DoConversationAction; the field selects GetConversation, ConversationHasValidEntry and StartConversation. It may also be interpolated in optional plugin diagnostics. Preserve selection identity; no in-place caption translation.',
    'C': 'Exact GetConversation(string) input. Existing pinned cache/fallback source compares original Conversation.Title; returned conversation supplies the dynamic graph. Preserve selection identity independently of displayed node text.',
    'E': 'Exact GetDialogueEntry(string) title selector. Original List.Find predicate compares DialogueEntry.Title with the supplied title using String.Equals. The selected node supplies links/forced state; this is not its Dialogue Text.',
    'Q': 'Format assembles system/dynamicQuestions/{0} with Actor.pluginDbName, then passes the result to GetConversation(string). Preserve the complete template and placeholder; actor identity is a separate argument, not prose substitution.',
    'K': 'Exact variable name passed with boxed bool/int to DialogueLua.SetVariable. Original implementation selects Lua Environment Variable table, applies StringToTableIndex to the name and SetNameValue to store the converted object. No displayed caption is supplied by this operand.',
    'H': 'Original prefix joins the played dialogue dbName before AddEventLog. Real manager stores message with StoryClock in GameplayLogHistory; GenerateRecentStoryEvents copies these messages into the diagnostic report. Preserve this history/report event representation. This is a proved downstream report role, not an assertion that arbitrary other log strings or external readers are absent.',
}
CONTEXT = {
    'PlayDialoguePlayerQuestion': 'Empty arcListCache returns after the separate prior diagnostic at IL000d (role retained). Missing GetDialogueByDbName(arg1) logs prefix+arg1 at IL002d and returns. Success resolves initialActor.dbName, updates CurrentDialogue/DbName/PluginDbName, clears CurrentArc/Name, sets Primary/Initial/CurrentActor and player-question flag, writes trigger conversation at IL0097, Fire(null), then BuildDynamicConversation(cache.Keys,true,PrimaryActor.dbName,false) and LogPlayedDialogue(CurrentDialogueDbName). Original Fire-before-build order is preserved. Error prefix is not sent to any lookup.',
    'PlayDynamicFastTravelDialogue': 'Prior Penny and System_DynamicFastTravel identities remain exact. Returned dialogue updates CurrentDialogue and original plugin/db names; arcs are cleared, primary/initial/current actor set. Write system/fastTravel to trigger conversation IL005f, Fire(null), then BuildFastTravelConversation(destinationNames,customGreeting) and LogPlayedDialogue(CurrentDialogueDbName). Retain original call order and previously verified greeting overwrite/seven frozen dependencies; no runtime activation is asserted.',
    'Handler_OnLinkedConversationStart': 'Only while IsPlayerQuestionDialoguePlaying. Reads active conversation0 and current-state conversation ID, gets original Title. For dialogueType700 returns if current plugin conversation ID equals selected ID OR Title equals system/dynamicConversation (prior protected comparison). Otherwise clears player-question flag, matches selected ID against arcListCache.Values plugin conversation IDs; on match updates current dialogue, first primary arc/customName and actor state then invokes onLinkedDialogueStart. No match logs selected prefix+CurrentDialogue.dbName at IL0147 and returns. That diagnostic carries the previous current dbName, not the selected Title. Error wording never participates in matching.',
    'HandleDialogueLineActor': 'Lowercase sequence containing prior none/delay/continue tokens returns. Otherwise speakerInfo.id from current conversation subtitle is used; nonpositive ID falls back to GetActorPluginIdTheSlowWay, then returns if still nonpositive. GetActorByPluginDbId is stored as CurrentActor. Null result formats selected template with CurrentDialogueDbName in slot0 and numeric plugin actor ID in slot1, then Debug.LogError IL008d. Execution continues: detailed and generic onDialogueLineBegin receive resolved actor (possibly null) and subtitle/formatted text, OnConversationLine_Handler runs, and narrator/player/NPC events branch separately. Diagnostic wording is distinct from emitted formatted dialogue text.',
    'BuildDynamicConversation': 'Requires active conversation; resolves system/dynamicConversation plus PASSTHROUGH, DYNAMICROOT, DYNAMICQUESTIONS, GENERICFAREWELL. Clears outgoingLinks on questions and root. includeQuestions=true resolves actor by dbName, formats system/dynamicQuestions/{0} with actor.pluginDbName, links root to that conversation first entry, questions to every supplied Arc.pluginDbFirstDialogueEntry, then generic farewell. Otherwise root links to each arc. skipPlayerQuestion can select pluginDbFirstPlayerQuestionDialogueEntry, invoke Handler_OnConversationLineEnd for the omitted original first subtitle and, on prior player actor-name equality, select its first outgoing destination. Final ForceNextStateToLinkToEntry uses PASSTHROUGH. These keys select/control graph topology, not captions; caller flags/arc IDs/plugin actor names remain exact.',
    'ResetDynamicConversation': 'Resolves the same conversation and four node-title keys as the builder. PASSTHROUGH and GENERICFAREWELL lookup results are popped. Only DYNAMICQUESTIONS and DYNAMICROOT outgoingLinks are cleared. It does not restore the full original graph or change node Dialogue Text. Keep all five lookup operands even when results are discarded.',
    'SetDialogueSystemBoolCondition': 'bool_condition is the exact name; boxed arg0 Boolean is the value. Original DialogueLua.SetVariable sets WasInvoked, obtains Environment[Variable], returns if it is not a LuaTable, then StringToTableIndex(name), ObjectToLuaValue(value), SetNameValue. Static store proof; actual Lua environment/conditions and runtime bool path untested.',
    'SetDialogueSystemBranchCondition': 'branch_condition is the exact name; boxed arg0 Int32 is the value. Same real Lua Variable-table storage path as bool condition. Keep branch integer and name separate from target wording; native/managed Lua execution not run.',
    'BuildFastTravelConversation': 'Requires active conversation, selects system/fastTravel, first entry, FASTTRAVELCANCEL and FT_DYNAMIC_ROOT; clears root links. Nonblank greeting selects FT_CUSTOM_GREETING, follows its first outgoing destination if present, and writes custom greeting to that node DialogueText only if found. Each supplied destination key matches every node Title by equality; matching nodes are linked from root, then cancellation is always appended. ForceNextStateToLinkToEntry uses first entry. Reuse prior exact ds:58:719 overwrite, destination gates/order, DeepWoods retention and seven frozen text dependencies; this packet adds the four compiled selector roles without new extraction.',
    'LogPlayedDialogue': 'prefix+arg1 dbName -> AddEventLog -> optional ServiceLocator GameplayLogManager -> LogMessage -> AddLogHistory(message,StoryClock) -> pooled/allocated GameplayLogHistory.message/timeUnlocked -> queue/CleanupLogHistory. Awake restores prior persisted messages, GetLogHistory yields queue (or empty list without manager). Existing GenerateRecentStoryEvents enumerates message with LF, falls back to persistent history only if combined text is empty; existing report submits it as Recent Events section. Scanned message-field uses also include save/restore/DeepCopy. No game, save write, report submission or external service operation occurred; no global absence inference from a bounded scan.',
}
CONSUMERS = {
    'W': 'System.Void UnityEngine.Debug::LogError(System.Object)',
    'T': 'System.String PixelCrushers.DialogueSystem.DialogueSystemTrigger::conversation',
    'C': 'PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.String)',
    'E': 'PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.String)',
    'Q': 'PixelCrushers.DialogueSystem.Conversation PixelCrushers.DialogueSystem.DialogueDatabase::GetConversation(System.String)',
    'K': 'System.Void PixelCrushers.DialogueSystem.DialogueLua::SetVariable(System.String,System.Object)',
    'H': 'System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)',
}
REMAINING_PREDICATES = {
    'PopulateDialogueArcs': 'Read full arc producer: orphan/root errors; exact player and TfolUniqueDataKeySuffix selection; underscore key conventions and uniqueness checks; diagnostic assembly joins versus actual graph/storage uses.',
    'AddDialoguePreconditionsAndTriggers': 'Read full producer and percent-chance/availability-rule branches: distinguish errors from numeric preconditions, DB fields and trigger callbacks; retain all earlier precise roles.',
    'AddDialoguePreconditionsOnscreenOffscreenWatchInferredTriggers': 'Prove inferred _WaitForActorsOffscreen/_WaitForActorsOnscreen assembly -> actual watch trigger lookup/store/callback; preserve identifiers independently of display.',
    'AddInferredOnscreenOffscreenWatchTriggerToAllPrecedingDialogues': 'Read complete predecessor traversal and missing-completion/error branches; actual inferred event trigger consumers, not a blanket error-string exclusion.',
    'AddDialogueStateTrigger': 'Read full state-trigger construction and manage-items parallel-list length diagnostic; separate all concrete item/state/action consumers.',
    'AddArcPreconditionsAndTriggers': 'Read full arc precondition/trigger assembly and missing-default-completion diagnostic; exact arc selection/trigger/output boundary.',
    'AddInferredDialogueFinishTrigger': 'Read ambiguity test and recursive dialogue finish callback/storage; distinguish diagnostic text from completion identity.',
    'ConvertToPascalCase': 'Read exact empty replacement and split/case/join transformation, caller argument and identifier output consumers.',
    'AddConversationLeftAlignPortraitsTrigger': 'Read left portrait actor parse/lookup, actual callback registration/action and diagnostic join; preserve effect/actor keys.',
    'AddConversationRightAlignPortraitsTrigger': 'Read right portrait actor parse/lookup, actual callback registration/action and diagnostic join; preserve effect/actor keys.',
    'AddConversationTriggerUnlockBioFragment': 'Read actor selection and note_/kink_ assembly through actual bio unlock lookup/callback; keep separate unknown-actor diagnostics.',
    'AddArcManualCompletionTrigger': 'Read actual arc-name matching/completion callback plus unknown-name diagnostic; do not translate selection names.',
    'AddConversationActorEncounteredTrigger': 'Read encounter actor input/normalization/lookup and registered state callback; separate two error prefixes and join.',
    'AddConversationActorIntroducedTrigger': 'Read introduction actor input/normalization/lookup and registered state callback; separate two error prefixes and join.',
    'AddConversationTriggerChangeFont': 'Read font-name parsing/enum/resource-role mapping and actual callback. Exact unknown-font diagnostic is distinct from fictional-language font identity.',
    'PrioritizeArcTriggers_CountParentNodesRecursive': 'Read parent-count recursion, missing-parent diagnostic assembly and caller use of returned count; distinguish text output from traversal priority.',
}


def load(p): return json.loads(p.read_text())
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def vh(v): return hashlib.sha256(json.dumps(v, ensure_ascii=False, sort_keys=True, separators=(',', ':')).encode()).hexdigest()
def short(m): return m.split('::', 1)[1].split('(', 1)[0]


def validate_rule(source, prior, rule, body):
    assert prior['role'] == 'needs-consumer-decision', 'playback-prior-role'
    assert (rule['id'], rule['method'], rule['offset'], rule['sourceLine']) == (prior['id'], source['method'], source['offset'], prior['sourceLine']), 'playback-selector'
    assert rule['sourceValueSha256'] == vh(source['value']), 'playback-source-value'
    assert vh(body) == rule['producerBodySha256'], 'playback-producer-body'
    literal = next(i for i in body if i['offset'] == source['offset'])
    assert (literal['opcode'], literal['operand']) == ('ldstr', json.dumps(source['value'], ensure_ascii=False)), 'playback-body-literal'
    kind = next(k for k, offsets in SPECS[short(source['method'])].items() if source['offset'] in {int(o, 16) for o in offsets.split()})
    assert rule['roleKind'] == kind and rule['role'] == ROLES[kind], 'playback-role-membership'
    assert rule['placeholderContract'] == re.findall(r'\{[^{}]*\}', source['value']), 'playback-placeholder-contract'
    assert rule['contextKey'] == short(source['method']) and rule['context'] == CONTEXT[rule['contextKey']], 'playback-context-membership'
    after = [i for i in body if i['offset'] > source['offset']]
    consumer = next(i for i in after if i['operand'] == CONSUMERS[kind])
    assert rule['bodyConsumer'] == consumer, 'playback-consumer'
    assert rule['bodyArgumentWindow'] == [i for i in after if i['offset'] <= consumer['offset']], 'playback-argument-window'


def expanded():
    for name, digest in load(HERE / 'input-pins.json').items():
        assert sha(ROOT / name) == digest, ('playback-input-pin', name)
    selected = load(OUT / 'phase139/next-compiled-selectors.json')['rows']
    originals = [json.loads(s) for s in INDEX.read_text().splitlines()]
    baseline = {r['id']: r for r in map(json.loads, (HERE / 'baseline/managed-literal-inventory.jsonl').read_text().splitlines())}
    files = load(HERE / 'body-files.json')
    body_cache = {f: method_bodies(HERE / f) for f in set(files.values())}
    rules, groups = [], []
    for method in dict.fromkeys(r['method'] for r in selected if r['method'].split(' ', 1)[1].split('::')[0] == 'TheForestOfLove.Narrative.DialogueService'):
        key = short(method)
        offsets = {int(o, 16): k for k, values in SPECS[key].items() for o in values.split()}
        rows = [r for r in selected if r['method'] == method]
        assert set(offsets) == {r['offset'] for r in rows}, ('playback-exact-scope', key)
        body = body_cache[files[method]][method]
        assert body and body[-1]['opcode'] == 'ret', 'playback-complete-body'
        method_rules = []
        for row in rows:
            source = originals[row['sourceLine'] - 1]
            kind = offsets[row['offset']]
            after = [i for i in body if i['offset'] > row['offset']]
            consumer = next(i for i in after if i['operand'] == CONSUMERS[kind])
            rule = dict(row, roleKind=kind, role=ROLES[kind], contract='playback-source-' + kind, reason=REASONS[kind],
                        evidence=[files[method], 'consumer-proofs.json'], producerBodySha256=vh(body), contextKey=key,
                        context=CONTEXT[key], placeholderContract=re.findall(r'\{[^{}]*\}', source['value']), bodyConsumer=consumer,
                        bodyArgumentWindow=[i for i in after if i['offset'] <= consumer['offset']],
                        application='hold-common-source-special-case-feasibility-and-independent-editorial-gates')
            rule.pop('predicate', None)
            validate_rule(source, baseline[row['id']], rule, body)
            rules.append(rule)
            method_rules.append(rule)
        groups.append(dict(method=method, key=key, bodyEvidence=files[method], producerBodySha256=vh(body),
                           ids=[r['id'] for r in method_rules], wordingIds=[r['id'] for r in method_rules if r['roleKind'] == 'W'],
                           preserveIds=[r['id'] for r in method_rules if r['roleKind'] != 'W'], contract=CONTEXT[key]))
    assert len(rules) == 23 and len(groups) == 10 and len({r['id'] for r in rules}) == 23
    assert set(SPECS) == {g['key'] for g in groups}
    rules.sort(key=lambda r: r['sourceLine'])
    held = [dict(r, bodyEvidence=files[r['method']], predicate=REMAINING_PREDICATES[short(r['method'])],
                 status='needs-consumer-decision;saved-body-is-not-semantic-coverage') for r in selected if r['id'] not in {v['id'] for v in rules}]
    assert len(held) == 54 and len({r['method'] for r in held}) == 16
    proofs = load(HERE / 'consumer-proofs.json')
    for proof in proofs['methods']:
        path = HERE / proof['path']
        assert sha(path) == proof['fileSha256'], ('playback-consumer-file', proof['path'])
        assert vh(method_bodies(path)[proof['method']]) == proof['bodySha256'], ('playback-consumer-body', proof['method'])
    return dict(schemaVersion=1, phase='0140-work', selectedOccurrences=77, resolvedOccurrences=23, remainingSelectedOccurrences=54,
                roleCounts=dict(Counter(r['role'] for r in rules)), decisions=rules,
                boundary='Substantive exact playback subset, not full loader77, full compiled/source packet, independent semantic/editorial or runtime acceptance.'), dict(
                    schemaVersion=1, phase='0140-work', occurrences=23, methods=10, groups=groups, consumerProofs=proofs,
                    preservedPriorRoles=True, sourceFindings=[
                        'Unity Debug.LogError is conditionally rendered through the actual DevConsole subscription/mask/EntryData path. Current three selected errors are wording; no blanket rewrite or exclusion of earlier diagnostic-classified operands.',
                        'PlayDialoguePlayerQuestion IL000d retains its earlier precise preserve-diagnostic role; its same Unity error sink is a named future source-role adjudication. DialogueCommands.Test IL001d finding is also retained unchanged.',
                        'History/report prefix has a proved queue/report representation; no UI or external-reader absence is claimed. Source values remain exact.'],
                    boundary='All selected23 wording/preserve/context memberships and downstream proofs. Native Unity log delivery, component settings/reachability, current defaultDatabase activation, Lua execution and runtime graph/visual behavior remain untested.'), held


def products():
    decisions, context, held = expanded()
    return {'phase140/compiled-role-decisions.json': decisions, 'compiled-playback-source-context.json': context,
            'phase140/next-compiled-selectors.json': dict(schemaVersion=1, scope='remaining-dialogue-loader54-of-original77',
                occurrences=54, methods=16, originalAssignedOccurrences=77, adjudicatedPlaybackOccurrences=23,
                remainingWholeCompiledScope=1305, otherCompiledResiduals=1251, rows=held,
                boundary='Exact remaining original selectors, ordered without loss. Stored full bodies do not establish semantic coverage; real downstream callbacks/watch/parser/field/output consumers still require named adjudication.')}


if __name__ == '__main__':
    for name, value in products().items():
        (OUT / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')
    print('Expanded playback23 source roles; loader54 remains explicitly held.')
