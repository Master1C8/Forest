"""Authored finite loader29 extension of the existing admission recipe.

All selected complete producers were read. Potential exception wording does not
assert delivery/presentation. Deterministic expansion is not editorial judgment.
"""
import hashlib
import json
from collections import Counter
from pathlib import Path
from phase138.expand_roles import method_bodies

HERE = Path(__file__).resolve().parent
OUT = HERE.parent
ROOT = OUT.parents[3]
INDEX = ROOT / 'outputs/pause-inventory-bio-completion-20261028/managed-index/literals.jsonl'
SPECS = {
    'AddDialoguePreconditionsAndTriggers': {'W':'92a 968 b75'},
    'AddDialoguePreconditionsOnscreenOffscreenWatchInferredTriggers': {'K':'90 ef'},
    'AddInferredOnscreenOffscreenWatchTriggerToAllPrecedingDialogues': {'W':'9e 171'},
    'AddDialogueStateTrigger': {'W':'386'},
    'AddArcPreconditionsAndTriggers': {'W':'3d8'},
    'AddInferredDialogueFinishTrigger': {'W':'22'},
    'ConvertToPascalCase': {'E':'27'},
    'AddConversationLeftAlignPortraitsTrigger': {'W':'a4','S':'af'},
    'AddConversationRightAlignPortraitsTrigger': {'W':'a4','S':'af'},
    'AddConversationTriggerUnlockBioFragment': {'W':'fd','S':'104','B':'12b 13a'},
    'AddArcManualCompletionTrigger': {'W':'d0'},
    'AddConversationActorEncounteredTrigger': {'W':'8b aa','S':'b0'},
    'AddConversationActorIntroducedTrigger': {'W':'8b aa','S':'b0'},
    'AddConversationTriggerChangeFont': {'W':'ab'},
    'PrioritizeArcTriggers_CountParentNodesRecursive': {'W':'a7','S':'b7'},
}
ROLES = dict(W='potential-display-exception-wording',S='preserve-exception-assembly-separator',
             K='preserve-inferred-watch-trigger-suffix',E='preserve-identifier-assembly-seed',B='preserve-bio-key-normalization')
REASONS = {
    'W':'Exact original message fragment contributes to new Exception(string) immediately followed by throw. It is potential wording, not the adjacent dynamic identity or parser key. No catch/native propagation/presentation is established; prior direct LogError proofs do not establish exception delivery.',
    'S':'Exact separator participates in the same exception assembly as wording and original dynamic identities. Five spaces and the parent-error dot remain protected formatting/context; not independent translation units. Exception presentation is unknown.',
    'K':'dbName plus this suffix is passed unchanged to inferred predecessor ArcTriggerFireNamedTrigger and stored as the corresponding precondition trigger name. Its real action activates the original name; CheckOffscreenTrigger/CheckOnscreenTrigger retrieves that same key through GetTriggerByName and checks activation and actor timestamps. This is a generated state identity, not a watch caption.',
    'E':'Empty accumulator after underscore Split(RemoveEmptyEntries), not a replacement argument. Null returns unchanged; strings shorter than two use ToUpper; other segments uppercase their first character and retain the rest before concatenation. Both actual callers feed the result to case-sensitive Enum.Parse(InventoryItemType), then item-trigger constructors. Preserve assembly and identifier semantics, including current-culture casing; no target alias is implemented.',
    'B':'Exact String.Replace search operand removed globally, first note_ then kink_, with String.Empty. It is not StartsWith/prefix-only normalization, nor a displayed BIO label. The resulting key goes to ArcTriggerUnlockBioFragment and optional bioKeywordsByPluginDbTriggerName reverse registration. Existing BIO action/lookup/category proofs are reused by fingerprint; absent legacy keys are not repaired.',
}
COMMON = ('For node commands, the first outgoing destination is looked up in the current conversation; each containing arc gets a trigger targeted at that successor conversation/entry and an assigned arc/recursive count. Except FONT, these selected command bodies do not guard an empty outgoing list. Parenthesized argument extraction is Substring(first-open+1, length-first-open-2), with no newly inferred close-delimiter validation. Protected Title grammar and prior precise roles are retained. Registration is static, not actual callback timing/reachability or renderer acceptance. ')
CONTEXT = {
'AddDialoguePreconditionsAndTriggers': 'Append one FullAvailabilityRule to each dialogue before testing its related rule list for null. Aggregate typed quest/dialogue/tag/trigger/item relations into its fields; area inputs are unity_scene_name and actor requirements are original DB names. Copy percent_chance into randomChance.percentChance, then branch with blt(0) and ble.un(1): preserve exact floating-point IL rather than strengthen to an invented finite-number predicate. Out-of-range branch throws092a+dbName; types600/500 with exact zero throw0968+dbName. Copy max_unlucky_rolls, optional time and named watch triggers, actor lists. A null related-rule list throws0b75; an empty list is not tested as null. Type500 adds NoActorsOnDate,300 adds arc availability,200 may infer first quest/start trigger, then optional state-trigger relations use original dbName. Earlier list mutation can precede an exception; no rollback claimed.',
'AddDialoguePreconditionsOnscreenOffscreenWatchInferredTriggers': 'Only exact FullAvailabilityRule objects participate. If the corresponding trigger-name field is null and either All/Any actor list is nonempty, compute dialogue.dbName+_WaitForActorsOffscreen or +_WaitForActorsOnscreen, call predecessor helper, then store the exact key into the matching field. Empty string is nonnull in this branch. Actual check methods permit null name, otherwise require GetTriggerByName result and IsActivated; compare original actor timePlayerWentOffscreen/timePlayerCameOnscreen with trigger.gameplayTimeFirstActivated for All/Any rules. Debug bypass is separate. No inferred caption.',
'AddInferredOnscreenOffscreenWatchTriggerToAllPrecedingDialogues': 'Read exact preceding-dialogue and FullAvailabilityRule dialoguesAny/dialoguesAll types. Extract helper skips negateCondition and deduplicates references. No predecessor throws009e+target.dbName. For each predecessor find its first exact ArcTriggerFinishDialogue; copy its IDs/arc/allowNullArc, set count to finish count+1 and append FireNamedTrigger(argument2). Missing finish throws0171+target.dbName, not predecessor name. Reused ActivateTrigger/GetTriggerByName prove original state-key role, not successful manifest activation or event delivery.',
'AddDialogueStateTrigger': 'Build completion/invalidation status triggers200/300, idle clearing, quest-log/start/complete, tag add/remove and chapter-unlock actions from typed relations. For nonnull manage_items require nonnull quantities with equal Count, else throw0386+caller debug name. Each original item_type and signed quantity use the same index: negative stored unchanged in itemsToRemoveQuantity; zero selects consume; positive selects add. Action executes consume then remove then add through NarrativeActions, preserving raw negative quantity at that boundary. No inferred absolute-value repair, inventory success, persistence or rollback.',
'AddArcPreconditionsAndTriggers': 'Normalize Title to uppercase, truncate before first open parenthesis when present, and dispatch exact GET/GIVE/CONSUME/BIO/TRIGGER/PORTRAITS/PORTRAITSALIGNL/PORTRAITSALIGNR/FINISHSTEP/FINISHARC/ENCOUNTER/INTRODUCE/FONT. FINISHSTEP marks explicit dialogue completion. If absent, original db completion_arc name indexes arcsByDbArcSuffix and must belong to this dialogue before inferred finish. If still absent and type is not700, choose last primary, then secondary, then idle, then sole named arc; no choice throws03d8+dbName. Actual inferred finish helper registers successor/arc callbacks; Title command identities are not translation wording.',
'AddInferredDialogueFinishTrigger': 'Iterate supplied entries and choose the sole zero-outgoing-links entry. A second terminal throws0022+dbName; no terminal leaves null (no new explicit error guard). For every dialogue arc containing the selected entry register ArcTriggerFinishDialogue with conversation/entry IDs, target dialogue, arc and recursive parent count. OnExecute calls CompleteDialogue(targetDialogue)->SetStatusCompleted. No graph execution, null-containing mutation assumption or successful status-event/save claim.',
'ConvertToPascalCase': 'Exact empty accumulator, underscore splitting and casing/joining return. Both add/remove inventory callers extract the original command argument then ConvertToPascalCase -> Enum.Parse(Type,String) -> InventoryItemType -> add/remove item-trigger constructor. Consume shares remove with true flag, GIVE false; invalid enum parse may fail before the separately retained zero-item diagnostic. No case-insensitive parser or localized item identifier.',
'AddConversationLeftAlignPortraitsTrigger': COMMON+'Actor argument is not trimmed/case-normalized; whitespace fails prior precise diagnostic, absent actorsByPluginDbName key throws00a4+dialogue.dbName+space+argument. Success resolves Actor.dbName into LeftAlign trigger. Repeat-enabled OnExecute emits onArcTriggerLeftAlignPortraits; actual CustomPortraitsUi Add/Remove listeners bind callback. DisableTriggeredEffects returns; exact Player changes parenting/player alignment. Callback matches portrait.actor.dbName, removes matching rightAlignedSchemas, and conditionally clears current right portrait/background. Native Transform/UI calls and actual scene lifetime remain boundaries.',
'AddConversationRightAlignPortraitsTrigger': COMMON+'Actor argument is not trimmed/case-normalized; whitespace fails prior precise diagnostic, absent actorsByPluginDbName key throws00a4+dialogue.dbName+space+argument. Success resolves Actor.dbName into RightAlign trigger. Repeat-enabled OnExecute emits onArcTriggerRightAlignPortraits; actual Add/Remove listeners bind CustomPortraitsUi callback. DisableTriggeredEffects returns; exact Player changes parenting/player alignment. Callback matches portrait.actor.dbName, adds absent rightAlignedSchemas and conditionally clears current left portrait/background. Native Transform/UI calls and actual scene lifetime remain boundaries.',
'AddConversationTriggerUnlockBioFragment': COMMON+'Comma Split length exactly2 uses trimmed actor/key; any other length uses primaryActor.pluginDbName and trimmed segment0. Empty actor/key retains prior precise diagnostics. Unknown actor throws00fd+actor+space+dialogue.pluginDbName. Success resolves Actor.dbName and globally replaces every note_, then kink_, occurrence with empty. Register BIO action with normalized key; if bioKeywordsByPluginDbTriggerName contains that key, add dialogue.dbName to unlockedByDialogueDbNames. Existing126-registration/normal-versus-force/category proofs remain unchanged and are reused by fingerprint, including16 missing-key registrations. No legacy remap, successful unlock or rendering claim.',
'AddArcManualCompletionTrigger': COMMON+'Untrimmed argument matches first arc.pluginDbSuffix by exact equality. Missing target throws00d0+dialogue.dbName. Set target.hasCustomFinishTrigger true; create ArcTriggerManuallyCompleteArc for the successor with that target arc, while its base arc/count belong to each containing current arc. Existing OnExecute calls ManuallyCompleteArc(targetArc). Do not confuse targetArc with base arc, or customName with pluginDbSuffix; no actual completion/save evidence.',
'AddConversationActorEncounteredTrigger': COMMON+'Untrimmed/case-preserved actor argument: whitespace throws008b+argument; unknown dictionary key throws00aa+argument+space+dialogue.dbName. Success resolves Actor.dbName into Encounter trigger/action then DataService actor lookup. Encounter sets encountered flag; already introduced but unencountered sets flag and returns without encounter event; an already encountered actor returns; otherwise flag then onActorFirstEncountered. State/event order is source evidence only.',
'AddConversationActorIntroducedTrigger': COMMON+'Untrimmed/case-preserved actor argument: whitespace throws008b+argument; unknown dictionary key throws00aa+argument+space+dialogue.dbName. Success resolves Actor.dbName into Introduce trigger/action then DataService actor lookup. Introduce returns if already introduced; otherwise retains prior-not-encountered condition, sets encountered and introduced, attempts species/age/role keyword unlocks for current BioDetail, conditionally emits first-encounter then emits introduced. No localization of lookup/state names or successful notification/save claim.',
'AddConversationTriggerChangeFont': COMMON+'This body first returns for zero outgoing links. Untrimmed font argument must exactly equal main or mouse; neither matched throws00ab+argument. There is no enum conversion here. Repeat-enabled FireChangeFont emits onChangeFont then marks executed; actual DialogueNameplateController Add/Remove listeners bind OnChangeFont. Mouse schedules mouse font; main/null/other callback input schedules main, while producer accepts only the two original keys. Reuse existing font-role/resource proof: main TMP3323 versus fictional-language mouse TMP3324, controller4311. Preserve fictional mapping and original bytes; no font/resource/build/runtime change.',
'PrioritizeArcTriggers_CountParentNodesRecursive': 'If entry reference equals arc first entry, return incoming count. Otherwise scan original arc entries/links in order for first parent whose destinationConversationID equals first-entry.conversationID and destinationDialogueID equals target.id. Recurse with count+1; no visited set or new cycle guard. No parent throws00a7+arc.dialogue.dbName+dot+arc.generatedName. Callers store count into trigger.numberOfDialogueEntriesInArcBeforeTargetNode; PrioritizeArcTriggers uses ascending Int32.CompareTo for List.Sort. This is first-parent-chain depth, not maximum depth, global uniqueness, stable ties or runtime success.',
}
EXCEPTION='System.Void System.Exception::.ctor(System.String)'

def load(path): return json.loads(path.read_text())
def sha(path): return hashlib.sha256(path.read_bytes()).hexdigest()
def vh(value): return hashlib.sha256(json.dumps(value,ensure_ascii=False,sort_keys=True,separators=(',',':')).encode()).hexdigest()
def short(method): return method.split('::')[1].split('(')[0]
def kind_for(method,offset):
    return next(k for k,values in SPECS[short(method)].items() if offset in {int(o,16) for o in values.split()})
def consumer_for(kind,body,offset):
    after=[i for i in body if i['offset']>offset]
    if kind in ('W','S'): return next(i for i in after if i['operand']==EXCEPTION)
    if kind=='K':return next(i for i in after if '::AddInferredOnscreenOffscreenWatchTriggerToAllPrecedingDialogues(' in (i['operand'] or ''))
    if kind=='E':return next(i for i in after if i['opcode']=='stloc.0')
    return next(i for i in after if i['operand']=='System.String System.String::Replace(System.String,System.String)')

def validate_rule(source,prior,rule,body):
    assert prior['role']=='needs-consumer-decision','loader-prior-role'
    assert (rule['id'],rule['method'],rule['offset'],rule['sourceLine'])==(prior['id'],source['method'],source['offset'],prior['sourceLine']),'loader-selector'
    assert rule['sourceValueSha256']==vh(source['value']),'loader-source-value'
    assert rule['producerBodySha256']==vh(body),'loader-producer-body'
    literal=next(i for i in body if i['offset']==source['offset'])
    assert (literal['opcode'],literal['operand'])==('ldstr',json.dumps(source['value'],ensure_ascii=False)),'loader-body-literal'
    kind=kind_for(source['method'],source['offset'])
    assert (rule['roleKind'],rule['role'])==(kind,ROLES[kind]),'loader-role-membership'
    assert rule['context']==CONTEXT[short(source['method'])] and rule['reason']==REASONS[kind],'loader-context-membership'
    consumer=consumer_for(kind,body,source['offset'])
    assert rule['bodyConsumer']==consumer,'loader-consumer'
    assert rule['bodyArgumentWindow']==[i for i in body if source['offset']<i['offset']<=consumer['offset']],'loader-argument-window'
    if kind in ('W','S'):
        throw=next(i for i in body if i['offset']>consumer['offset'])
        assert throw['opcode']=='throw' and rule['throw']==throw,'loader-exception-throw'
    assert rule['visibility']==('unknown-exception-presentation' if kind in ('W','S') else 'identity-or-structure;no-caption-application'),'loader-visibility-boundary'

def expanded():
    for name,digest in load(HERE/'input-pins.json').items():assert sha(ROOT/name)==digest,('loader-input-pin',name)
    selected=load(OUT/'phase141/next-compiled-selectors.json')['rows']
    originals=[json.loads(s) for s in INDEX.read_text().splitlines()]
    baseline=[json.loads(s) for s in (HERE/'baseline/managed-literal-inventory.jsonl').read_text().splitlines()]
    prior={r['id']:r for r in baseline}; bodies=method_bodies(OUT/'phase140/loader.il')
    expected={(name,int(o,16)) for name,kinds in SPECS.items() for values in kinds.values() for o in values.split()}
    assert {(short(r['method']),r['offset']) for r in selected}==expected and len(selected)==29,'loader-exact-scope'
    rules=[]
    for row in selected:
        source=originals[row['sourceLine']-1];body=bodies[row['method']];kind=kind_for(row['method'],row['offset']);consumer=consumer_for(kind,body,row['offset'])
        rule=dict(row,bodyEvidence='phase140/loader.il',sourceSelectorPacket='phase141/next-compiled-selectors.json',roleKind=kind,role=ROLES[kind],reason=REASONS[kind],contract='loader-source-'+kind,
            producerBodySha256=vh(body),context=CONTEXT[short(row['method'])],bodyConsumer=consumer,
            bodyArgumentWindow=[i for i in body if row['offset']<i['offset']<=consumer['offset']],
            visibility='unknown-exception-presentation' if kind in ('W','S') else 'identity-or-structure;no-caption-application',
            evidence=['phase140/loader.il','phase142/consumer-proofs.json'],
            application='hold-common-source-special-case-feasibility-and-independent-editorial-gates')
        rule.pop('status',None)
        if kind in ('W','S'):rule['throw']=next(i for i in body if i['offset']>consumer['offset'])
        validate_rule(source,prior[row['id']],rule,body);rules.append(rule)
    assert Counter(r['roleKind'] for r in rules)==dict(W=18,S=6,K=2,E=1,B=2)
    proofs=load(HERE/'consumer-proofs.json')
    for proof in proofs['methods']:
        path=ROOT/proof['path'];assert sha(path)==proof['fileSha256'],('loader-consumer-file',proof['path'])
        assert vh(method_bodies(path)[proof['method']])==proof['bodySha256'],('loader-consumer-body',proof['method'])
    delta={r['id']:r for r in rules};groups=[]
    for method in dict.fromkeys(r['method'] for r in selected):
        body=bodies[method];complete=[dict(r,adjudication='phase142-delta' if r['id'] in delta else 'retained-prior-precise-role') for r in baseline if r['method']==method]
        for r in complete:
            if r['id'] in delta:r.update(role=delta[r['id']]['role'],decision='phase142:'+delta[r['id']]['contract'])
        assert {r['offset'] for r in complete}=={i['offset'] for i in body if i['opcode']=='ldstr'},'loader-complete-producer-literals'
        assemblies=[]
        for r in rules:
            if r['method']!=method or r['roleKind']!='W':continue
            start,end=r['offset'],r['throw']['offset']
            assemblies.append(dict(wordingId=r['id'],separatorIds=[s['id'] for s in rules if s['method']==method and s['roleKind']=='S' and start<s['offset']<end],
                instructions=[i for i in body if start<=i['offset']<=end],presentation='unknown;ctor-and-throw-proved-only'))
        groups.append(dict(method=method,producerBodySha256=vh(body),contract=CONTEXT[short(method)],completeProducerLiterals=complete,
            wordingIds=[r['id'] for r in rules if r['method']==method and r['roleKind']=='W'],
            preserveIds=[r['id'] for r in rules if r['method']==method and r['roleKind']!='W'],exceptionAssemblies=assemblies))
    return dict(schemaVersion=1,phase='0142-work',selectedOccurrences=29,resolvedOccurrences=29,remainingSelectedOccurrences=0,
        roleCounts=dict(Counter(r['role'] for r in rules)),decisions=rules,
        boundary='All29 assigned loader source roles across15 full producers;18 potential exception wording and11 protected operands. Prior precise roles unchanged; no full-source, presentation, editorial or runtime acceptance.'),dict(
        schemaVersion=1,phase='0142-work',groups=groups,consumerProofs=proofs,
        sourceFindings=['Potential exception presentation stays unknown. Existing immediate exception diagnostics retain precise historical roles; this packet supplies no blanket exclusion or retroactive rewrite.',
            'BIO normalization removes all note_/kink_ substrings, in that order. PascalCase uses an empty accumulator, not empty replacement.',
            'Watch inference excludes negated predecessors; inferred trigger uses finish priority+1. Parent recursion follows first parent without cycle detection; sort ties are not proved stable.',
            'FONT uses exact string roles, not an enum; existing fictional font mapping and every texture remain unchanged.'],
        boundary='Static original source/consumer evidence only. All29 roles resolved, exception/native/lifetime/runtime uncertainty retained. Source/frozen/target/glossary values and independent editorial gates unchanged.')

def products():
    decisions,context=expanded()
    return {'phase142/compiled-role-decisions.json':decisions,'compiled-loader-source-context.json':context}

if __name__=='__main__':
    for name,value in products().items():(OUT/name).write_text(json.dumps(value,ensure_ascii=False,indent=2)+'\n')
    print('Expanded all29 loader roles; no selected loader roles remain.')
