"""Append exact game-consumer evidence to the existing database products.

No source extraction or target application. Unproved readers remain explicit;
neither an absent literal nor a non-display-looking value is an exclusion.
"""
import copy
import json
from collections import Counter
from pathlib import Path

from phase135.reconcile_database import ROOT, sha, load, get, vh

HERE = Path(__file__).resolve().parent
BASE = HERE.parent
GREETING_METHOD = 'System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::ExecuteTrigger(System.String)'
GREETING_ID = 'il:Assembly-CSharp.dll/' + GREETING_METHOD + '/IL_0a01'
GREETING = '[pic=2]So where to?'
KEYS = {(109, 5): 'PASSTHROUGH', (109, 8): 'DYNAMICROOT',
        (109, 9): 'GENERICFAREWELL', (109, 10): 'DYNAMICQUESTIONS',
        (457, 875): 'show ending screen'}


def js(v):
    return (json.dumps(v, ensure_ascii=False, indent=2) + '\n').encode()


def classify_remaining(row, tree):
    """Disposition only within the fingerprinted former1660-value residual."""
    r = copy.deepcopy(row)
    field = get(tree, r['pointer'].rsplit('/', 1)[0])
    r['fieldTitle'] = field['title']
    r['fieldType'] = field['typeString']
    r['consumerEvidence'] = 'phase136/role-decisions.json'
    key = (r.get('conversationId'), r.get('entryId'))
    if r['role'] == 'retained-node-label;consumer-unresolved':
        node = get(tree, r['pointer'].split('/fields/')[0])
        fields = {f['title']: f['value'] for f in node['fields']}
        r['sourcePredicate'] = dict(rawDialogueTextEmpty=not fields['Dialogue Text'],
                                    rawMenuTextEmpty=not fields['Menu Text'],
                                    formattedWhitespaceAtRuntime='unknown;raw-empty-test-is-not-parser-execution')
        if key in KEYS:
            assert r['source'] == KEYS[key], ('known-title-value', key)
            r['role'] = ('protected-dynamic-conversation-selection-key' if key[0] == 109
                         else 'protected-story-event-comparison-key')
            r['consumerBoundary'] = ('BuildDynamicConversation/ResetDynamicConversation exact GetDialogueEntry(string) arguments'
                if key[0] == 109 else 'GeneralStoryUIController title event -> RascalSoloBearStory.OnDialogueEmptyWithTitledLine Contains; timer -> TriggerAdvanceMoment')
            r['remainingPredicate'] = 'Identity is proved and must remain exact; this does not assert no other display consumer exists.'
            r['roleResolved'] = True
        else:
            r['consumerBoundary'] = 'OnConversationLine_Handler: missing/whitespace formatted text -> original Title -> UnityEvent<string>; formatted nonblank text -> text event'
            r['remainingPredicate'] = 'Resolve serialized persistent/dynamic listeners of GeneralStoryUIController.onDialogueEmptyWithTitledLine and external listeners of DialogueService.onDialogueLineBegin_AnyPassthruTitledLine for this exact source node. Author notes/old command labels remain potential event payloads; no display exclusion or reachability pass.'
            r['roleResolved'] = False
    else:
        assert r['role'] == 'preserve-custom-metadata;consumer-unresolved'
        if field['title'] == 'Description':
            assert key[0] == 58 and key[1] in (3, 5, 7, 14, 15) and r['source'] == 'DYNAMIC_RESPONSE_OPTION'
            r['consumerBoundary'] = 'Field.Lookup(fields, callerSuppliedTitle) exact Field.title equality -> value; BuildFastTravelConversation selects Title and does not read Description'
            r['remainingPredicate'] = 'Identify an actual data-driven/plugin/Lua reader supplying Description for these five entries, or an authoritative source exclusion. Exact marker has no literal reader in either pinned managed assembly; this bounded search is not an absence proof.'
        else:
            assert field['title'] in ('TfolConversationType', 'TfolUniqueDataKeySuffix')
            r['consumerBoundary'] = 'DialogueLua.AddToConversationTable copies every conversation field under StringToTableIndex(title); GetConversationField(id, fieldName) -> Lua.Run("return Conversation[{0}].{1}", false, true)'
            r['remainingPredicate'] = 'Resolve actual caller/script supplying this field name and whether its returned value affects selection or display. Current game GenerateDialogues uses BG and the one game AssignedField call reads entry suffix, not conversation suffix. Generic Lua/API exposure prevents an unused-field exclusion.'
        r['roleResolved'] = False
    return r


def products(original):
    out = dict(original)
    pins = load(HERE / 'input-pins.json')
    for name, digest in pins.items():
        assert sha(ROOT / name) == digest, ('phase136-input-changed', name)
    prior = load(HERE / 'baseline/dialogue-database-unresolved.json')['values']
    assert len(prior) == 1660 and len({r['pointer'] for r in prior}) == 1660
    manifest = load(ROOT / 'localization/source/dialogue-manifest.json')
    tree = load(ROOT / manifest['sources'][0]['tree'])
    dispositions = [classify_remaining(r, tree) for r in prior]
    resolved = {r['pointer']: r for r in dispositions if r['roleResolved']}
    assert len(resolved) == 5
    current = [json.loads(s) for s in out['dialogue-database-values.jsonl'].splitlines()]
    by_pointer = {r['pointer']: r for r in dispositions}
    for r in current:
        if r['pointer'] in by_pointer:
            replacement = by_pointer[r['pointer']]
            assert (r['source'], r['occurrences'], r['sourceValueSha256']) == (replacement['source'], replacement['occurrences'], replacement['sourceValueSha256'])
            r.update(replacement)
    unknown = [r for r in dispositions if not r['roleResolved']]
    counts = dict(Counter(r['role'] for r in unknown))
    assert len(unknown) == 1655
    out['dialogue-database-values.jsonl'] = b''.join((json.dumps(r, ensure_ascii=False, sort_keys=True, separators=(',', ':'))+'\n').encode() for r in current)
    out['dialogue-database-unresolved.json'] = js(dict(schemaVersion=1, counts=counts, values=unknown))
    out['dialogue-database-consumer-dispositions.json'] = js(dict(schemaVersion=1, phase='0136-work',
        assignedLogicalValues=1660, resolvedControlKeys=5, remainingLogicalValues=1655,
        remainingTitles=934, remainingCustomMetadata=721, values=dispositions,
        boundary='All1660 exact former residual selectors receive authored bounded dispositions. Unresolved rows are holds, never default semantic passes or technical exclusions. Source values and both physical identities remain exact.',
        evidencePins=pins, commonSourceAccepted=False, runtime='not-run'))
    report = json.loads(out['dialogue-database-reconciliation.json'])
    report['phase'] = '0136-work'
    report['unresolvedLogicalValues'] = len(unknown)
    report['unresolvedRoles'] = counts
    for r in resolved.values():
        report['rolesPerCopy']['retained-node-label;consumer-unresolved'] -= 1
        report['rolesPerCopy'][r['role']] = report['rolesPerCopy'].get(r['role'], 0) + 1
        report['semanticFieldRolesPerCopy']['retained-node-label;consumer-unresolved'] -= 1
        report['semanticFieldRolesPerCopy'][r['role']] = report['semanticFieldRolesPerCopy'].get(r['role'], 0) + 1
    # Typed group digests must match the changed role partition, not old counters.
    title_groups = {}
    from phase135.reconcile_database import encoded
    import hashlib
    for r in current:
        if r.get('fieldTitle') == 'Title' and r['pointer'] in by_pointer:
            group = title_groups.setdefault(r['role'], dict(selector='entries:Title:value', role=r['role'], logicalStates=0, nonemptyStates=0, orderedStateDigest=hashlib.sha256()))
            group['logicalStates'] += 1
            group['nonemptyStates'] += 1
            group['orderedStateDigest'].update(encoded([r['pointer'], r['source']])+b'\n')
    report['selectorGroups'] = [g for g in report['selectorGroups'] if g['role'] != 'retained-node-label;consumer-unresolved']
    for g in title_groups.values():
        g['orderedPointerValueSha256'] = g.pop('orderedStateDigest').hexdigest()
        g['physicalStringStates'] = g['logicalStates']*2
        report['selectorGroups'].append(g)
    report['consumerDispositionArtifact'] = 'dialogue-database-consumer-dispositions.json'
    report['roleEvidence'] = ['phase135/database-role-decisions.json', 'phase136/role-decisions.json']
    report['consumerEvidencePins'] = pins
    report['unresolvedPredicates'] = [dict(role=role, logicalValues=n,
        artifact='dialogue-database-unresolved.json', next='Use exact remainingPredicate and consumerBoundary on each selector; no dormant-value exclusion or recursive framework audit.') for role,n in counts.items()]
    out['dialogue-database-reconciliation.json'] = js(report)
    travel = json.loads(out['fast-travel-source-dependencies.json'])
    travel['argumentSources'] = dict(
        caller='StoryManager.PlayDialogue(QuestManagerInteractionMode, DialogueSettings) IL_009f..00b8',
        destinationProducer='FastTravelController.GetDynamicFastTravelDestinationSceneNames',
        emittedDestinationKeys=['CentralForest','Lake','Plains_End','Mountains'],
        destinationTitleEntries=[3,5,14,7],
        retainedDestinationNotEmittedByThisBody=dict(key='DeepWoods', entry=15, boundary='Stored fifth destination remains retained; no whole-game unreachable/exclusion claim.'),
        currentSceneRemoval='SceneHelper.CurrentSceneName is removed from the identity list',
        conditions=dict(CentralForest='item190 OR (inLake AND NOT act2 AND BridgeQuest_DeliverToyToOtter played)',
            Lake='item180 AND NOT (inCentralForest AND NOT act2 AND BridgeQuest_DeliverToyToOtter not played)',
            Plains_End='item210', Mountains='item200'),
        greetingProducer=dict(id=GREETING_ID, source=GREETING, sourceValueSha256=vh(GREETING),
            condition='act3_penny_mountains_perch_first_time_summoned; not dialogue-skip/chapter-select/cheat; act3_penny_mountains_perch_first_time_landed not set',
            write='TriggerHandlerAct3.ExecuteTrigger IL_0a01 -> FastTravelController.NextFastTravelCustomGreetingText',
            read='StoryManager reads greeting before GetDynamicFastTravelDestinationSceneNames clears it; saved local then passed to PlayDynamicFastTravelDialogue and BuildFastTravelConversation',
            displayTarget='ds:58:719:Dialogue Text', protectedMarkup='[pic=2]'),
        branchCondition='0 nonempty destination cache; 1 empty; nonwhitespace custom greeting overrides to2; disableGreeting overrides to3; greeting and disable flags reset after selection')
    travel['runtimeProducerIds'] = [GREETING_ID]
    travel['runtimeProducerBindings'] = [dict(id=GREETING_ID, source=GREETING, sourceValueSha256=vh(GREETING), role='display-runtime-fast-travel-greeting')]
    travel['externalBoundaries'] = ['Actual scene/item/quest/trigger state and Unity/Lua execution not run; method-local identity list/greeting sources are resolved statically. Serialized/external alternate writers remain unproved.', 'Five Description-marker reader bindings remain separately unresolved; they are not consumed by this fast-travel builder.']
    travel['adaptationContract'] += ' Include the exact compiled greeting producer; translating only ds:58:719 can be overwritten by its English literal. Preserve [pic=2], selection keys and branch flags.'
    travel['argumentEvidence'] = ['phase136/fast-travel-caller.il','phase136/fast-travel-arguments.il','phase136/act3-greeting-producer.il','phase136/greeting-writers.txt','phase136/greeting-field-uses.txt']
    out['fast-travel-source-dependencies.json'] = js(travel)
    return out
