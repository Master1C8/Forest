"""Exact authored residual110 roles, expanded through the existing admission recipe.

No spelling classifier, translation generation or semantic pass rows. All offsets
below were adjudicated against complete original producer and named consumer bodies.
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
# W: wording; F: exact output layout; N: input normalization; J: search join;
# K: filter/ranking key; D: displayed filter identity; T: database selection.
SPECS = {
 'DialogueCommands::Find': {'W':'1a0 1ac', 'F':'210 23b'},
 'DialogueCommands::Info': {'W':'1b 8e cf 124 15c 194 1d5 219 2e0 328 32f', 'F':'9a af c8 11d 155 18d 1ce 212 252 2d9 30f'},
 'DialogueCommands::Raw': {'W':'1b'},
 'DialogueCommands::Play': {'W':'1b'},
 'DialogueCommands::Complete': {'W':'1b 54'},
 'DialogueCommands::Reset': {'W':'18 35'},
 'DialogueCommands::Test': {'T':'a'},
 'DialogueCommands::.cctor': {'K':'6'},
 'DateCommands::Find': {'W':'1b7 1c3', 'F':'227 252'},
 'DateCommands::List': {'F':'f2 114'},
 'DateCommands::ForceNext': {'W':'21 4a 56 8f'},
 'DateCommands::.cctor': {'K':'6 11'},
 'QuestCommands::List': {'F':'b1 ce'},
 'QuestCommands::Find': {'W':'13b 147', 'F':'1f3 21e'},
 'QuestCommands::Info': {'W':'f 82 b6 144', 'F':'8e a3 af 13d'},
 'QuestCommands::Complete': {'W':'f 3d'},
 'QuestCommands::Reset': {'W':'f 3d'},
 'QuestCommands::.cctor': {'K':'6'},
 'InventoryCommands::Add': {'N':'22','W':'81'},
 'InventoryCommands::PlayerHas': {'N':'22','W':'75 8b a1'},
 'InventoryCommands::Remove': {'N':'22','W':'81'},
 'InventoryCommands::Search': {'J':'5c','W':'18f 19b','F':'204','N':'227'},
 'ChapterCommands::Search': {'J':'57','W':'18a 196','F':'1ff'},
 'ChapterCommands::Unlock': {'W':'59'},
 'StatsCommands::Stats_GenerateStats': {'D':'6 17 28 39 4a 5c 6e'},
 'StatsCommands::Stats_GenerateTags': {'W':'14a 160 177 18d 1a4 1c3'},
 'StatsCommands::PrintUnplayed': {'W':'5c 64','F':'81 9c'},
 'StatsCommands::Stats_FilterDialogueTypes': {'W':'69'},
 'StatsCommands::PrintStats': {'W':'4b 53','F':'84'},
 'TriggersCommands::Set': {'W':'b'},
 'TriggersCommands::Reset': {'W':'15'},
 'TriggersCommands::Info': {'W':'18 1f 2a 30'},
}
ROLES = dict(W='display-console-wording', F='preserve-display-format', N='preserve-input-normalization',
             J='preserve-search-assembly', K='preserve-search-ranking-key',
             D='preserve-visible-filter-identity', T='preserve-database-identity')
REASONS = {
 'W':'Actual source-language console/UI wording, including complete format templates with lexical text. Translate only in a future accepted target source packet; keep every placeholder, dynamic identity and source branch separate.',
 'F':'Exact output layout, indentation, separator or placeholder-only format. Contains no lexical target wording; preserve the original assembly contract and parameter positions.',
 'N':'Space is the oldValue in dbName.Replace(space, String.Empty). Lowercased normalized names are compared to command input or printed as executable suggestions. Changing this token changes normalization.',
 'J':'Space joins searchable identity/title and description before ToLower/Contains/Replace scoring. This is a search corpus delimiter, not independent prose or a proved visible output separator.',
 'K':'Stored in tokensToCountOnce; Find tests query-token membership and scores a matching token once instead of by occurrence count. Preserve original query/ranking vocabulary.',
 'D':'StatEntry.typeName is BOTH lowercase substring-filter input and actual printed category. Preserve original filter identity; any translated caption needs a separate display projection. Never translate this field in place.',
 'T':'Exact GetConversation(string) title selector, not wording: original cache keys use Conversation.Title and fallback uses String.Equals; selected original conversation43 has this Title in both databases. No runtime database activation is claimed.',
}
CONTEXT = {
 'DialogueCommands::Find':'Query is lowercased and split on char32. Lowercased Dialogue.dbName is scored; QueueNode stores the original numeric conversation ID and that lowercased name. Header is top + limit10 + matching dialogues. Negative-priority rows alone print (absolute score) padded ID name, at most10 rows. {0,-5} pads the numeric ID; outer slots are score, padded ID, conversationTitle. Dynamic dbName remains a lookup identity even when printed.',
 'DialogueCommands::Info':'Missing ID prints error. Header = prefix + numeric ID + separator + dbName. Four-space indent is local V4; wrappers {0}{1} join indent and content. Quest-type200 template slots = dialogueType, quest.dbName, quest.status; otherwise type only. Other captions format status, primaryActorDbName and conditional initialActorDbName. Named arcs print customName with doubled indent. Named triggers print triggerPluginDbName and ready/fired selected by IsTriggerFired; {0}{1} ({2}) = double indent, trigger identity, selected status. These status words never feed the trigger lookup.',
 'DialogueCommands::Raw':'Missing numeric dialogue ID emits error prefix + ID; success passes original dbName and optional arc argument to DialogueService.PlayDialogue and closes console. Error prefix is independent of the lookup/control identity.',
 'DialogueCommands::Play':'Missing numeric dialogue ID emits error prefix + ID; success sends selected Dialogue and trimmed optional arc to StoryManager.PlayDialogue. Preserve identities/precondition flags, translate only error wording after gates.',
 'DialogueCommands::Complete':'Missing numeric dialogue ID emits error. Success uses original dbName in MarkConversationsAsPlayed then logs completion prefix + numeric ID.',
 'DialogueCommands::Reset':'ResetConversation(id) boolean selects success or error prefix; each concatenates numeric ID. Reset state and DevCommandActive flag do not consume either prefix.',
 'DialogueCommands::Test':'GetConversation(system/testconvo) on current defaultDatabase; null emits existing prior diagnostic-classified IL001d, success forwards returned Title plus caller arc to DialogueService.PlayDialogue. Original stored record is conversation43 at /conversations/240 in both copies. Runtime default DB construction/replacement remains separate. The prior IL001d role is retained exactly but its visible LogError sink is a source finding requiring later adjudication; this phase does not overwrite prior roles.',
 'DialogueCommands::.cctor':'List contains quest; Find reads tokensToCountOnce at IL00a9 and Contains at IL00b0 before once-only versus occurrence scoring.',
 'DateCommands::Find':'Filters dialogues to dialogueType500 then ranks lowercase dbName by query tokens. Header top +10+ matching dialogues; each matching row = absolute score, padded original pluginDbConversation.id, lowercased dbName. Queue constructor preserves ID/title. Dynamic database name stays an identity.',
 'DateCommands::List':'Only dialogueType500. Output {0,-5} formats original plugin conversation ID; {0} {1} joins padded ID and lowercased dbName. It is layout without lexical wording.',
 'DateCommands::ForceNext':'Calls dialogue Reset, checks ID and type500; errors assemble prefix + numeric ID (+ non-date suffix). Debug Date prefix joins dbName into debugDateName UI.Text only if both instance and Text are nonnull. dbName separately writes Globals.Debug_ForceSpawnDate_DialogueDbName; never replace that state with the caption.',
 'DateCommands::.cctor':'quest and date populate tokensToCountOnce. Find reads list at IL00ba/Contains IL00c1; keys change ranking, not header wording.',
 'QuestCommands::List':'Enumerates GetQuests with mock IDs starting0, at most10. Format ID as {0,-5}; row = absolute queue priority, padded mock ID, original quest.dbName, quest.status. Status is boxed enum; title is stored by QueueNode constructor. Preserve dynamic identities and ordinal mock ID mapping.',
 'QuestCommands::Find':'Lowercase query split char32, score nonempty lowercase quest.dbName; preserve enumeration-derived mock ID. Header top+10+matching quests; negative score rows print absolute score, padded mock ID, stored lowercase title. Layout stays separate from wording.',
 'QuestCommands::Info':'GetQuestByMockId result controls missing error. Header prefix + mock ID + separator + dbName. Four-space indent wraps status template and steps completed template; completed count includes dialogue statuses200 or300, denominator is dialogues.Count. Preserve counts and status/identity values.',
 'QuestCommands::Complete':'Missing mock ID error; success SetStatusCompleted then completion prefix+ID in LogWarning. Preserve mock ID/state.',
 'QuestCommands::Reset':'Missing mock ID error; success Reset then reset prefix+ID in LogWarning. Preserve mock ID/state.',
 'QuestCommands::.cctor':'quest list goes into tokensToCountOnce; Find IL008b/0092 controls once-only ranking.',
 'InventoryCommands::Add':'Each activeSchema.dbName removes spaces and lowercases, compared to lowercased caller input. Success uses itemType for AddInventoryItem; missing match logs prefix + original input. Do not translate normalized command name or type.',
 'InventoryCommands::PlayerHas':'Same dbName normalization and comparison as Add. Original itemType passes to PlayerHasItem; true and false select distinct message prefixes, both LogError in this original. Unknown input is third error. Preserve truth/negation and original input independently of log severity.',
 'InventoryCommands::Remove':'Same name normalization as Add, success RemoveInventoryItem by itemType. Unknown prefix + caller input is actual LogError output.',
 'InventoryCommands::Search':'Search string = dbName + space + description, lowercased. Inactive schemas skipped; query ranks by token occurrence. Header top+10+matching items. Row slots = absolute priority, dbName.Replace(space,empty).ToLower(), description. First space is search corpus join; second is protected normalization operand. Outer pipe/parentheses/spaces are display layout.',
 'ChapterCommands::Search':'Search string = title + space + description, lowercased; isHiddenInList entries skipped. Header top+10+matching chapters. Row slots = absolute priority, title, description. Search delimiter is not a visible separator; outer pipe format is.',
 'ChapterCommands::Unlock':'Original compares input.ToLower() with input.Trim() after null/hidden checks (IL0026-0037), not with ChapterRecord.title. Preserve this source anomaly. Missing record logs prefix + caller input; success uses unlockStopPoint/respawnInScene for DoChapterSelect. No gameplay fix is authorized.',
 'StatsCommands::Stats_GenerateStats':'Seven entries correspond to quest/date/gossip/gift/manual/final-idle/player-choice dialogue queries. Caller filter string splits on char38 ampersand, passes same token list to GenerateTags and PrintUnplayed. typeName feeds FilterDialogueTypes lowercase Contains and PrintStats slot2; filtered header also prints original name. Keep typeName field exact; future caption projection must retain original filters.',
 'StatsCommands::Stats_GenerateTags':'Input equality keys act1/act2/act3/nonlinear/adventure/all remain prior protected comparison operands. Each branch updates tag list and writes an independent caption through arg1 stind.ref. Six captions go via GenerateStats V8 to PrintStats arg2 or PrintUnplayed arg3. Original order and last recognized caption wins while tags reset; do not translate tag IDs or filter keys.',
 'StatsCommands::PrintUnplayed':'First calls FilterDialogueTypes with separate byref caption. Header slots = Actor.dbName or All Actors; optional leading-space+GenerateTags caption; optional leading-space+type-filter caption. Whitespace tokens are display layout. Entries print notCompleted.dbName until requested positive limit; no category caption is emitted for each row here.',
 'StatsCommands::Stats_FilterDialogueTypes':'Ignores blank or trimmed-length<3 tokens. Compares typeName.ToLower().Contains(token.ToLower()) using original token (not Trim result). Each unique matched entry appends {previous} & type {typeName} through byref output; PrintUnplayed displays it. If no matches, returns original list. This template is caption wording, not a filter parser.',
 'StatsCommands::PrintStats':'Header slots = Actor.dbName or All Actors, GenerateTags caption. Nonzero totals print {completed.Count+invalidated.Count} / {total} {typeName}. Placeholder-only row format is protected layout, typeName remains displayed filter identity; runtime totals are not translated wording.',
 'TriggersCommands::Set':'Original caller key goes first to SetTrigger; independent prefix + same original key then LogWarning. Prefix is wording; key remains unchanged.',
 'TriggersCommands::Reset':'Original key goes to GetTriggerByName then optional ResetTriggerDevtoolsOnly. Prefix+original key logs even if lookup null. No claim that message proves reset succeeded.',
 'TriggersCommands::Info':'GetTriggerByName original input key; null leaves status String.Empty. Existing trigger IsActivated chooses not set or set, stored locally. Output trigger + input + is + status via Concat4/LogWarning. These selected statuses never become state/lookup values.',
}

def load(p): return json.loads(p.read_text())
def vh(v): return hashlib.sha256(json.dumps(v,ensure_ascii=False,sort_keys=True,separators=(',',':')).encode()).hexdigest()
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def short(m): return m.split(' TheForestOfLove.DevConsoleCommands/',1)[1].split('(')[0]

def validate_rule(source, prior, rule, body):
    assert prior['role']=='needs-consumer-decision','console-prior-role'
    assert (rule['id'],rule['method'],rule['offset'],rule['sourceLine'])==(prior['id'],source['method'],source['offset'],prior['sourceLine']),'console-selector'
    assert rule['sourceValueSha256']==vh(source['value']),'console-source-value'
    assert vh(body)==rule['producerBodySha256'],'console-producer-body'
    literal=next(i for i in body if i['offset']==source['offset'])
    assert (literal['opcode'],literal['operand'])==('ldstr',json.dumps(source['value'],ensure_ascii=False)),'console-body-literal'
    expected_kind=next(k for k,offsets in SPECS[short(source['method'])].items() if source['offset'] in {int(o,16) for o in offsets.split()})
    assert rule['roleKind']==expected_kind and rule['role']==ROLES[expected_kind],'console-role-membership'
    assert rule['placeholderContract']==re.findall(r'\{[^{}]*\}',source['value']),'console-placeholder-contract'
    assert rule['contextKey']==short(source['method']) and rule['context']==CONTEXT[rule['contextKey']],'console-context-membership'

def expanded():
    pins=load(HERE/'input-pins.json')
    for name,digest in pins.items():assert sha(ROOT/name)==digest,('console-input-pin',name)
    selectors=load(OUT/'phase138/next-compiled-selectors.json')['rows']
    baseline=[json.loads(s) for s in (HERE/'baseline/managed-literal-inventory.jsonl').read_text().splitlines()]
    original=[json.loads(s) for s in INDEX.read_text().splitlines()]
    prior={r['id']:r for r in baseline}
    files=load(OUT/'phase138/game-body-files.json');bodies={}
    for name in dict.fromkeys(r['bodyEvidence'] for r in selectors):bodies.update(method_bodies(OUT/'phase138'/name))
    rules=[]; contexts=[]
    for m in dict.fromkeys(r['method'] for r in selectors):
        key=short(m);assert key in SPECS and key in CONTEXT
        assignments={int(o,16):k for k,offsets in SPECS[key].items() for o in offsets.split()}
        selected=[r for r in selectors if r['method']==m]
        assert set(assignments)=={r['offset'] for r in selected},('console-exact-scope',key)
        body=bodies[m];assert body[-1]['opcode']=='ret'
        context_ids=[]
        for row in selected:
            src=original[row['sourceLine']-1];kind=assignments[row['offset']]
            rule=dict(id=row['id'],method=m,offset=row['offset'],sourceLine=row['sourceLine'],sourceValueSha256=row['sourceValueSha256'],
                role=ROLES[kind],roleKind=kind,contract='console-source-'+kind,reason=REASONS[kind],
                evidence=['../phase138/'+row['bodyEvidence'],'../phase138/console-contract.il','../phase138/console-entry.il'],
                producerBodySha256=vh(body),contextKey=key,context=CONTEXT[key],
                placeholderContract=re.findall(r'\{[^{}]*\}',src['value']),
                application='hold-common-source-special-case-feasibility-and-independent-editorial-gates')
            if kind=='D':rule['evidence']+=['stats-field-uses.il','stats-input-producers.il']
            if kind=='T':rule['evidence']+=['conversation-get.il','conversation-cache.il','conversation-create-cache.il','conversation-match.il','test-conversation-selection.json']
            validate_rule(src,prior[row['id']],rule,body);rules.append(rule);context_ids.append(row['id'])
        sinks=[i for i in body if i['opcode'] in ('call','callvirt','stind.ref','stfld','stsfld') and (i['opcode'].startswith('st') or any(s in (i['operand'] or '') for s in ['DevConsole::Log','UI.Text::set_text','StatEntry::typeName','::Replace(','::Concat(','::Format(','::GetConversation(']))]
        contexts.append(dict(method=m,key=key,producerBodySha256=vh(body),bodyEvidence='../phase138/'+selected[0]['bodyEvidence'],ids=context_ids,
            wordingIds=[r['id'] for r in rules if r['method']==m and r['roleKind']=='W'],
            preserveIds=[r['id'] for r in rules if r['method']==m and r['roleKind']!='W'],contract=CONTEXT[key],consumerInstructions=sinks))
    assert len(rules)==110 and len(contexts)==32 and len({r['id'] for r in rules})==110
    assert set(SPECS)=={short(r['method']) for r in selectors}
    # Canonical source order is never replaced by method-table order.
    rules.sort(key=lambda r:r['sourceLine'])
    dual=[dict(id=r['id'],method=r['method'],offset=r['offset'],sourceLine=r['sourceLine'],sourceValueSha256=r['sourceValueSha256'],
        source=original[r['sourceLine']-1]['value'],role=r['role'],input='Stats_FilterDialogueTypes IL0047-0057 lowercase typeName.Contains(query)',
        display='PrintStats IL00c9 -> Format slot2 -> Log; Stats_FilterDialogueTypes IL0072 -> byref caption -> PrintUnplayed header',
        adaptation='Preserve typeName filter value; future display-only caption mapping must retain this full seven-entry group.') for r in rules if r['roleKind']=='D']
    return dict(schemaVersion=1,phase='0139-work',selectedOccurrences=110,resolvedOccurrences=110,remainingSelectedOccurrences=0,
        roleCounts=dict(Counter(r['role'] for r in rules)),decisions=rules,
        boundary='All exact selected source roles adjudicated; not a full compiled packet, target translation, independent semantic/editorial or runtime pass.'),dict(
            schemaVersion=1,phase='0139-work',occurrences=110,methods=32,groups=contexts,displayedFilterDependencies=dual,
            retainedSourceFindings=[dict(method='DialogueCommands::Test',offset='IL_001d',finding='Existing prior preserve-diagnostic role retained; actual LogError is visible. Needs later exact-role adjudication, not an absence claim.'),dict(method='ChapterCommands::Unlock',offsets='IL_0026-0037',finding='Original compares input.ToLower with input.Trim, not ChapterRecord.title; no repair made.')],
            testConversation=load(HERE/'test-conversation-selection.json'),
            boundary='Complete selected role/wording/preserve/context membership. Actual reachability/rendering, whole-family special cases and source admission remain pending.')

def products():
    decisions,contexts=expanded()
    baseline=[json.loads(s) for s in (HERE/'baseline/managed-literal-inventory.jsonl').read_text().splitlines()]
    owners={'TheForestOfLove.Narrative.DialogueSystemLoader','TheForestOfLove.Narrative.DialogueService'}
    next_rows=[dict(id=r['id'],method=r['method'],offset=r['offset'],sourceLine=r['sourceLine'],sourceValueSha256=r['sourceValueSha256'],
        predicate='Read the complete original dialogue loading/playback producer and actual argument/field/output consumer. Separate error/visible console messages, resource/state/effect keys, format strings and actual callback/substitution dependencies; no default diagnostic or whole-method exclusion.')
        for r in baseline if r['role']=='needs-consumer-decision' and r['method'].split(' ',1)[1].split('::')[0] in owners]
    return {'phase139/compiled-role-decisions.json':decisions,'compiled-console-source-context.json':contexts,
        'phase139/next-compiled-selectors.json':dict(schemaVersion=1,scope='dialogue-loader-and-playback-producer-consumers',occurrences=len(next_rows),methods=len({r['method'] for r in next_rows}),
            remainingWholeCompiledScope=1328,rows=next_rows,boundary='Finite named family from the other1328 residuals, not yet semantically read or classified.')}

if __name__=='__main__':
    for name,value in products().items():(OUT/name).write_text(json.dumps(value,ensure_ascii=False,indent=2)+'\n')
    print('Expanded exact110 console roles and complete context membership.')
