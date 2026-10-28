"""Finite authored arc25 source-role delta; extends the existing admission recipe.

Complete original producer and selected real field consumers are reused by pin.
Exception construction is proved; exception presentation and runtime are not.
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
METHOD = 'System.Void TheForestOfLove.Narrative.DialogueSystemLoader::PopulateDialogueArcs(TheForestOfLove.Narrative.DataManifest,PixelCrushers.DialogueSystem.DialogueDatabase,TheForestOfLove.Narrative.Dialogue,System.String,System.Collections.Generic.List`1<TheForestOfLove.Narrative.Arc>)'
SPECS = {
    'W': '21 1b8 1f2 25f 2a4 2f9 33e 393 3d8 42d 472',
    'S': '1fd 26a 2af 304 349 39e 3e3 438 47d',
    'A': '106 172', 'F': '1d4', 'D': '222 236',
}
ROLES = dict(W='potential-display-exception-wording', S='preserve-exception-assembly-separator',
             A='preserve-actor-plugin-lookup-key', F='preserve-dialogue-entry-field-key',
             D='preserve-generated-arc-identity-delimiter')
REASONS = {
    'W': 'Complete producer concatenates this wording with original dialogue identity and, for suffix/convention/uniqueness errors, the selected original DialogueText and a separate exact space. The result constructs System.Exception and is thrown. This is potential exception wording, not a lookup key. No catch/presentation/native delivery or actual runtime reachability was proved; retain it in candidate wording without accepting a visible denominator or assuming the Unity LogError sink.',
    'S': 'Exact space between selected original DialogueText and dialogue.dbName in a four-string exception-message concatenation. It belongs to the same exception assembly/context as its separate wording operand and dynamic values, but is protected formatting rather than an independently translatable phrase. Exception presentation remains unknown.',
    'A': 'Exact actorsByPluginDbName dictionary key. Returned actor.pluginDbActor.id is compared with the first selected node ActorID, or with the first successor ActorID after a none-sequence gate. It selects the stored playerInitiatedQuestion and first-player-question node, independently of display wording.',
    'F': 'Exact Field.AssignedField name on the selected first arc entry fields. Pinned AssignedField calls Lookup; the real predicate compares Field.title to the supplied title using String.Equals. Empty field values return null; this producer additionally rejects whitespace-only suffixes. The returned value builds arc lookup/save identities and skip policy; the field name is not a caption.',
    'D': 'Exact underscore in dbName+underscore+suffix or savekey+underscore+suffix. Complete producer stores generatedName/generatedSavekey, uses generatedName for within-sublist equality and inserts original suffix/savekey dictionary keys. Preserve assembly delimiters and both distinct identity domains. These are not display separators.',
}
CONTEXT = (
    'GetDialogueEntry(rootNodeTitle) returns the root; absent root returns without arcs, present root with zero outgoing links throws prefix+dialogue.dbName. Caller argument windows bind PRIMARY/SECONDARY/IDLE/NAMED to their corresponding actual lists. Each outgoing root link allocates an Arc. NAMED first stores the immediate child Title as customName, then takes that child first outgoing destination as the arc first node; other roots use their linked child directly. PRIMARY plus hasPlayerInitiatedQuestion checks types200/400 (other type logs the pre-existing precise diagnostic at00f0, retained unchanged). First ActorID equals actorsByPluginDbName[player].pluginDbActor.id, or a lowercase Sequence containing none leads to its first successor with that actor ID. Store playerInitiatedQuestion and pluginDbFirstPlayerQuestionDialogueEntry, otherwise throw. '
    'AssignedField(first.fields,TfolUniqueDataKeySuffix) must exist and its value must not be whitespace. Missing/blank throws wording+first.DialogueText+space+dialogue.dbName. Compute generatedName=dbName+_+suffix and generatedSavekey=savekey+_+suffix. By actual arcSublist object identity, primary/secondary/idle/named check ^[p][0-9]* / ^[s][0-9]* / ^[i][0-9]* / ^[n][0-9]*, then compare generatedName against every existing arc in that same list. Regexes have no end anchor and permit zero digits; do not strengthen them or treat the whole suffix as numeric. Convention/duplicate errors throw their own prefix+first.DialogueText+space+dialogue.dbName. '
    'Store generatedName, pluginDbSuffix, generatedSavekey, dialogue, skip flag from arcSuffixesDisallowSkip.Contains(suffix), and pluginDbFirstDialogueEntry. RecursivelyPopulateDialogueEntries uses a visited-node list and follows only links whose destinationConversationID equals the current conversationID. Then append to dialogue.arcs, Add(suffix,arc) to arcsByDbArcSuffix, Add(generatedSavekey,arc) to arcsBySavekey, append manifest.arcs and finally arcSublist. Within-list checks do not prove global uniqueness; dictionary Add may reject an existing key after earlier mutation. No rollback or runtime validation is claimed. Exception construction/throw is proved; managed/native propagation and actual presentation remain open. Prior eight precise literal roles are retained unchanged.'
)
EXCEPTION = 'System.Void System.Exception::.ctor(System.String)'
CONSUMERS = dict(W=EXCEPTION, S=EXCEPTION,
    A='!1 System.Collections.Generic.Dictionary`2<System.String,TheForestOfLove.Narrative.Actor>::get_Item(!0)',
    F='PixelCrushers.DialogueSystem.Field PixelCrushers.DialogueSystem.Field::AssignedField(System.Collections.Generic.List`1<PixelCrushers.DialogueSystem.Field>,System.String)',
    D='System.String System.String::Concat(System.String,System.String,System.String)')


def load(path): return json.loads(path.read_text())
def sha(path): return hashlib.sha256(path.read_bytes()).hexdigest()
def vh(value): return hashlib.sha256(json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(',', ':')).encode()).hexdigest()


def validate_rule(source, prior, rule, body):
    assert prior['role'] == 'needs-consumer-decision', 'arc-prior-role'
    assert (rule['id'], rule['method'], rule['offset'], rule['sourceLine']) == (prior['id'], source['method'], source['offset'], prior['sourceLine']), 'arc-selector'
    assert rule['sourceValueSha256'] == vh(source['value']), 'arc-source-value'
    assert rule['producerBodySha256'] == vh(body), 'arc-producer-body'
    literal = next(i for i in body if i['offset'] == source['offset'])
    assert (literal['opcode'], literal['operand']) == ('ldstr', json.dumps(source['value'], ensure_ascii=False)), 'arc-body-literal'
    kind = next(k for k, offsets in SPECS.items() if source['offset'] in {int(o,16) for o in offsets.split()})
    assert (rule['roleKind'],rule['role']) == (kind,ROLES[kind]), 'arc-role-membership'
    assert rule['context'] == CONTEXT and rule['reason'] == REASONS[kind], 'arc-context-membership'
    after = [i for i in body if i['offset'] > source['offset']]
    consumer = next(i for i in after if i['operand'] == CONSUMERS[kind])
    assert rule['bodyConsumer'] == consumer, 'arc-consumer'
    assert rule['bodyArgumentWindow'] == [i for i in after if i['offset'] <= consumer['offset']], 'arc-argument-window'
    if kind in ('W','S'):
        throw = next(i for i in after if i['offset'] > consumer['offset'])
        assert throw['opcode'] == 'throw' and rule['throw'] == throw, 'arc-exception-throw'
    assert rule['visibility'] == ('unknown-exception-presentation' if kind in ('W','S') else 'identity-or-structure;no-caption-application'), 'arc-visibility-boundary'


def expanded():
    for name, digest in load(HERE / 'input-pins.json').items():
        assert sha(ROOT / name) == digest, ('arc-input-pin',name)
    selected = load(OUT / 'phase140/next-compiled-selectors.json')['rows']
    originals = [json.loads(s) for s in INDEX.read_text().splitlines()]
    baseline = [json.loads(s) for s in (HERE / 'baseline/managed-literal-inventory.jsonl').read_text().splitlines()]
    before = {r['id']:r for r in baseline}
    body = method_bodies(OUT / 'phase135/arc-consumers.il')[METHOD]
    assert body[-1]['opcode'] == 'ret' and body[-1]['offset'] == 0x54c, 'arc-complete-producer'
    offsets = {int(o,16):k for k,values in SPECS.items() for o in values.split()}
    rows = [r for r in selected if r['method'] == METHOD]
    assert set(offsets) == {r['offset'] for r in rows} and len(rows) == 25, 'arc-exact-scope'
    rules = []
    for row in rows:
        source = originals[row['sourceLine']-1]; kind = offsets[row['offset']]
        after = [i for i in body if i['offset'] > row['offset']]
        consumer = next(i for i in after if i['operand'] == CONSUMERS[kind])
        rule = dict(row,roleKind=kind,role=ROLES[kind],reason=REASONS[kind],contract='arc-source-'+kind,
            producerBodySha256=vh(body),context=CONTEXT,bodyConsumer=consumer,
            bodyArgumentWindow=[i for i in after if i['offset'] <= consumer['offset']],
            visibility='unknown-exception-presentation' if kind in ('W','S') else 'identity-or-structure;no-caption-application',
            evidence=['../phase135/arc-consumers.il','consumer-proofs.json'],
            application='hold-common-source-special-case-feasibility-and-independent-editorial-gates')
        rule.pop('predicate',None); rule.pop('status',None)
        if kind in ('W','S'): rule['throw'] = next(i for i in after if i['offset'] > consumer['offset'])
        validate_rule(source,before[row['id']],rule,body)
        rules.append(rule)
    assert len(rules) == len({r['id'] for r in rules}) == 25
    held = [r for r in selected if r['id'] not in {a['id'] for a in rules}]
    assert len(held) == 29 and len({r['method'] for r in held}) == 15
    proofs = load(HERE / 'consumer-proofs.json')
    for proof in proofs['methods']:
        path=OUT/proof['path']
        assert sha(path) == proof['fileSha256'], ('arc-consumer-file',proof['path'])
        if path.suffix == '.il': actual=method_bodies(path)[proof['method']]
        else: actual=load(path)['instructions']
        assert vh(actual) == proof['bodySha256'], ('arc-consumer-body',proof['method'])
    new_by_id={r['id']:r for r in rules}
    complete = [dict(id=r['id'],offset=r['offset'],sourceLine=r['sourceLine'],sourceValueSha256=r['sourceValueSha256'],
        role=new_by_id[r['id']]['role'] if r['id'] in new_by_id else r['role'],
        adjudication='phase141-delta' if r['id'] in new_by_id else 'retained-prior-precise-role')
        for r in baseline if r['method']==METHOD]
    assert len(complete)==33
    assemblies=[]
    for r in rules:
        if r['roleKind']!='W':continue
        start=r['offset'];end=r['throw']['offset']
        assemblies.append(dict(wordingId=r['id'],separatorIds=[s['id'] for s in rules if s['roleKind']=='S' and start<s['offset']<end],
            instructions=[i for i in body if start<=i['offset']<=end],
            dynamicArguments=['dialogue.dbName'] if start in (0x21,0x1b8) else ['first.DialogueText','dialogue.dbName'],
            boundary='Exact original exception construction; actual catch/native propagation/presentation remains unknown.'))
    return dict(schemaVersion=1,phase='0141-work',selectedOccurrences=54,resolvedOccurrences=25,remainingSelectedOccurrences=29,
        roleCounts=dict(Counter(r['role'] for r in rules)),decisions=rules,
        boundary='Complete source-role adjudication of arc25 subset only; eleven potential exception wording inputs, fourteen protected operands. Exception visibility is unresolved; no source admission/editorial/runtime acceptance.'), dict(
        schemaVersion=1,phase='0141-work',method=METHOD,producerBodySha256=vh(body),deltaOccurrences=25,
        completeProducerLiterals=complete,wordingIds=[r['id'] for r in rules if r['roleKind']=='W'],
        preserveIds=[r['id'] for r in rules if r['roleKind']!='W'],exceptionAssemblies=assemblies,
        contract=CONTEXT,consumerProofs=proofs,
        sourceFindings=['Prior eight precise roles retained, including00f0 preserve-diagnostic. Same actual Unity LogError sink is a named later role-adjudication finding; not rewritten or excluded by blanket rule.',
            'Missing root returns; present root with no links throws. NAMED has an extra child hop; no inferred empty-child guard was added.',
            'Regex prefix with zero digits is accepted; per-list generatedName checks differ from later suffix/savekey dictionary insertion. No global uniqueness or transactional load is claimed.',
            'Exception ctor/throw is the exact output boundary, not a proven Unity message/event. Do not reuse direct LogError visibility as proof for thrown exceptions.'],
        boundary='Static original argument/field/return/storage contracts; no new IL extraction, CLR/game execution, catch/native delivery/console activation, independent editorial or target application.'), held


def products():
    decisions, context, held = expanded()
    return {'phase141/compiled-role-decisions.json':decisions,'compiled-arc-source-context.json':context,
        'phase141/next-compiled-selectors.json':dict(schemaVersion=1,scope='remaining-dialogue-loader29-of-original54',
            occurrences=29,methods=15,originalAssignedOccurrences=77,adjudicatedPlaybackOccurrences=23,adjudicatedArcOccurrences=25,
            remainingWholeCompiledScope=1280,otherCompiledResiduals=1251,rows=held,
            boundary='Every remaining selector retains its full producer/body pin and exact finite predicate. Saved IL is not semantic coverage. No packet-complete or visible-denominator claim.')}


if __name__ == '__main__':
    for name,value in products().items():
        (OUT/name).write_text(json.dumps(value,ensure_ascii=False,indent=2)+'\n')
    print('Expanded arc25 source roles; loader29 remains explicitly held.')
