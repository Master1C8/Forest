"""Extend the existing admission products with the finite original caller boundary.

No new source extraction or general Lua parser. Exact complete original expressions
have explicit read/write roles; unfamiliar syntax remains unparsed and held.
"""
import copy
import json
import re
from collections import Counter
from pathlib import Path
from phase135.reconcile_database import ROOT, get, sha, load, vh

HERE = Path(__file__).resolve().parent
BASE = HERE.parent
INDEX = ROOT / 'outputs/pause-inventory-bio-completion-20261028/managed-index'
SERIAL = ROOT / 'localization/source/shared-source-completion-20261028/serialized-title-events'
NEXT = ('Complete the consolidated1251 original compiled-role selectors across443 methods in phase143/next-compiled-selectors.json, reusing all prior typed immediate-argument/full-body evidence. '
        'Database1655 has a finished finite serialized/caller packet; preserve its exact residual source-policy/external boundaries. '
        'Do not repeat the closed persistent-event search, unchanged Lua expressions, loader/arc/playback methods or generic framework absence work. '
        '1389 Rewired alias bindings and real source/renderer/editorial/runtime gates remain separate.')


def js(value):
    return (json.dumps(value, ensure_ascii=False, indent=2)+'\n').encode()


def rows(path):
    return [json.loads(s) for s in path.read_text().splitlines()]


def analyze_lua(source):
    """Whole-expression recognition only; no substring-based negative proof."""
    if source == '':
        return dict(status='empty-original-slot', reads=[], writes=[], sink='none')
    m = re.fullmatch(r'Variable\["(branch_condition|bool_condition)"\] == (0|1|2|true|false)', source)
    if m:
        key, value = m.groups()
        return dict(status='parsed-exact-original-expression', reads=[dict(table='Variable', key=key)],
                    writes=[], comparison=dict(operator='==', value=value), sink='dialogue-entry-condition-result')
    if source == 'x <= 50':
        return dict(status='parsed-exact-original-expression', reads=[dict(globalName='x')], writes=[],
                    comparison=dict(operator='<=', value=50), sink='dialogue-entry-condition-result')
    if source == 'Variable["mouse/treeId"] = 777':
        return dict(status='parsed-exact-original-expression', reads=[],
                    writes=[dict(table='Variable', key='mouse/treeId', value=777)], sink='Lua-variable-store')
    if source == 'x = math.random(100)':
        return dict(status='parsed-exact-original-expression', reads=[dict(call='math.random', arguments=[100])],
                    writes=[dict(globalName='x')], sink='Lua-global-store')
    return dict(status='unparsed;dynamic-or-new-source', reads=None, writes=None,
                sink='unknown;retain-whole-expression-no-absence-conclusion')


def lua_inventory():
    manifest = load(ROOT / 'localization/source/dialogue-manifest.json')
    copies = [load(ROOT / s['tree']) for s in manifest['sources']]
    result, counts = [], Counter()
    for copy_index, tree in enumerate(copies):
        slots = [('/globalUserScript', tree['globalUserScript'], None, None)]
        for ci, co in enumerate(tree['conversations']):
            for ei, entry in enumerate(co['dialogueEntries']):
                for field in ('conditionsString', 'userScript'):
                    slots.append((f'/conversations/{ci}/dialogueEntries/{ei}/{field}', entry[field], co['id'], entry['id']))
        assert len(slots) == 32793, 'lua-slot-count'
        for pointer, value, conversation, entry in slots:
            if copy_index == 0:
                counts['slotsPerCopy'] += 1
                counts['nonemptyPerCopy' if value else 'emptyPerCopy'] += 1
                counts[pointer.rsplit('/',1)[-1]+('Nonempty' if value else 'Empty')] += 1
                if value:
                    result.append(dict(pointer=pointer, source=value, sourceValueSha256=vh(value),
                        conversationId=conversation, entryId=entry,
                        occurrences=[s['object']+pointer for s in manifest['sources']],
                        analysis=analyze_lua(value)))
            else:
                assert get(copies[0], pointer) == value, ('lua-copy-value', pointer)
    original = [r for r in rows(BASE/'phase143/baseline/dialogue-database-values.jsonl')
                if r['role'] in ('protected-lua-condition','protected-lua-program')]
    assert [(r['pointer'],r['source'],r['occurrences']) for r in original] == [
        (r['pointer'],r['source'],r['occurrences']) for r in result], 'lua-original-inventory-join'
    assert len(result) == 41 and all(r['analysis']['status']=='parsed-exact-original-expression' for r in result)
    return dict(schemaVersion=1, phase='0143-work', scope='Both original database copies: globalUserScript and every conditionsString/userScript, including empty slots.',
        counts=dict(counts), nonemptyLogicalPrograms=len(result), physicalNonemptyPrograms=len(result)*2,
        distinctExpressions=len({r['source'] for r in result}), programs=result,
        customConversationFieldInputs=[], unparsedPrograms=[],
        boundary='Complete exact expressions for this pinned database scope only, not a whole-game script/native/reflection absence proof. No Lua/game execution or target semantic judgment.')


def caller_inventory():
    calls = rows(INDEX/'calls.jsonl')
    literals = rows(INDEX/'literals.jsonl')
    selected = [r for r in calls if r['targetType'] in (
        'PixelCrushers.DialogueSystem.DialogueLua','PixelCrushers.DialogueSystem.Lua',
        'PixelCrushers.DialogueSystem.Field') or 'PixelCrushers.DialogueSystem.Asset::Lookup' in r['called']]
    result = []
    for call in selected:
        r = copy.deepcopy(call)
        if 'DialogueLua::SetVariable(' in call['called']:
            matches = [l for l in literals if l['method']==call['method'] and l['value'] in ('bool_condition','branch_condition')
                       and any(i['offset']==call['offset'] and i['operand']==call['called'] for i in l['after'])]
            assert len(matches)==1, 'lua-setter-name-input'
            lit = matches[0]
            window = [dict(index=lit['index'],offset=lit['offset'],opcode='ldstr',operand=lit['value'])]
            window += [i for i in lit['after'] if i['index']<=call['index']]
            assert len(window)==4 and window[-1]['operand']==call['called']
            r.update(nameInput=lit['value'], nameInputId=f"il:Assembly-CSharp.dll/{lit['method']}/IL_{lit['offset']:04x}",
                argumentWindow=window, sink='Lua Variable table setter; bool/branch control state, not a Conversation-field read',
                evidence='phase140/set-variable.il' if 'DialogueService::' in call['method'] else 'complete original literal-index argument window')
        else:
            assert call['called'].startswith('PixelCrushers.DialogueSystem.Field PixelCrushers.DialogueSystem.Field::AssignedField(')
            r.update(nameInput='TfolUniqueDataKeySuffix', owner='DialogueEntry.fields, not Conversation.fields',
                sink='PopulateDialogueArcs arc/save identity suffix',
                evidence=['phase141/consumer-proofs.json','phase141/compiled-role-decisions.json','phase136/field-lookup.il'])
        result.append(r)
    assert len(result)==6 and sum('SetVariable(' in r['called'] for r in result)==5
    # The manifest binds the entire index, not a candidate grep excerpt.
    return dict(schemaVersion=1, phase='0143-work', originalIndexSha256=sha(INDEX/'calls.jsonl'),
        assemblyScope=load(INDEX/'manifest.json'), directCalls=result,
        conversationFieldGetterDirectCalls=[], descriptionFieldReaderDirectCalls=[],
        boundary='Complete direct-call selection for the stated API families in original Assembly-CSharp only. Unresolved reflection, interface/dynamic dispatch, external assemblies, serialized non-database script generators and runtime additions are not excluded. Generic plugin GetConversationField/Field.Lookup remain exposed; no native/Lua-internal recursion.')


def validate_selector(before, after):
    for k in ('pointer','occurrences','source','sourceValueSha256','role','roleResolved'):
        if before[k] != after[k]:
            raise ValueError('database-binding-preserved-'+k)
    if after['roleResolved'] or after.get('translationId') is not None:
        raise ValueError('database-binding-unsupported-admission')
    if after.get('consumerBindingEvidence') != 'dialogue-database-caller-bindings.json':
        raise ValueError('database-binding-missing-evidence')


def refine(row, tree):
    r = copy.deepcopy(row)
    assert not r['roleResolved'], 'not-original1655-residual'
    r['consumerBindingEvidence'] = 'dialogue-database-caller-bindings.json'
    r['finiteStaticAssignment'] = 'complete;source-policy-or-identified-runtime-evidence-needed'
    r['consumerEvidence'] = 'phase143/role-decisions.json'
    r['ownerConversationId'] = tree['conversations'][int(r['pointer'].split('/')[2])]['id']
    if r['fieldTitle']=='Title':
        assert 'show ending screen' not in r['source'], 'unaccounted-rascal-title-match'
        r['boundedOriginalRole'] = 'preserved-conditional-event-payload;no-bound-display-reader-in-reviewed-original-path'
        r['consumerBoundary'] = ('Original whitespace/absent formatted text branch emits Title. Named Rascal receiver only tests Contains(show ending screen); this exact value fails that predicate. '
            'All39 original exported controllers omit both custom event fields; no persistent listener tables exist. Service event is static and game field-use index has no subscriber.')
        r['remainingPredicate'] = ('Source admission must decide preservation of this exact original node/event payload with external consumer boundary disclosed, or provide an identified external/runtime reader that displays it. '
            'No author-note/old-command/PASSTHRU spelling exclusion, no parser/reachability pass. Closed serialized-persistent-listener search must not be repeated.')
        r['rascalContainsPredicate'] = False
        r['serializedPersistentListenerBoundary'] = 'closed-for-original39-instances;fields-absent-not-null'
        r['externalBoundary'] = 'DialogueService.onDialogueLineBegin_AnyPassthruTitledLine and arbitrary runtime/reflection/native subscribers remain unobserved; no particular external display reader is identified.'
    elif r['fieldTitle']=='Description':
        r['boundedOriginalRole'] = 'preserved-entry-marker;no-actual-reader-bound'
        r['consumerBoundary'] = 'Original58:3/5/7/14/15 Description=DYNAMIC_RESPONSE_OPTION; fast-travel uses Title. Exact database programs do not read Description; original game direct field call reads entry TfolUniqueDataKeySuffix. Generic Field.Lookup still accepts caller-supplied keys.'
        r['remainingPredicate'] = 'Source admission decision: retain marker unchanged under this exact unbound API boundary, or supply an identified actual producer/caller passing Description for one of these entries. No accepted exclusion or new dynamic-reader search without that named evidence.'
        r['externalBoundary'] = 'Generic Field.Lookup caller-supplied key/value and external data-driven readers; no concrete Description reader found in this bounded original scope.'
    else:
        assert r['fieldTitle'] in ('TfolConversationType','TfolUniqueDataKeySuffix')
        r['boundedOriginalRole'] = 'preserved-conversation-custom-field;Lua-exported-with-no-bound-original-input'
        r['consumerBoundary'] = ('DialogueLua exports every conversation field. All41 nonempty original database conditions/programs are whole-expression classified and use Variable/x/math only. '
            'Complete original game direct-call roster has five Variable setters and one DialogueEntry suffix lookup; no direct GetConversationField caller. No original script/caller input reaches this custom field in the bounded roster.')
        r['remainingPredicate'] = 'Source admission decision: preserve this exact exported metadata value with the bounded API/external uncertainty recorded, or supply a named external/dynamic script/caller and actual sink. Generic GetConversationField capability alone does not authorize endless framework tracing or a display exclusion.'
        r['externalBoundary'] = 'GetConversationField caller-supplied field name -> Lua.Run; external/dynamic/uninventoried script generators and runtime additions unobserved. No bound display/dual consumer.'
    validate_selector(row,r)
    return r


def products(original):
    out = dict(original)
    pins = load(HERE/'input-pins.json')
    for name, digest in pins.items():
        assert sha(ROOT/name)==digest, ('phase143-input',name)
    previous = load(HERE/'baseline/dialogue-database-unresolved.json')['values']
    assert len(previous)==1655
    tree = load(ROOT/load(ROOT/'localization/source/dialogue-manifest.json')['sources'][0]['tree'])
    refined = [refine(r,tree) for r in previous]
    by_pointer = {r['pointer']:r for r in refined}
    assert len(by_pointer)==1655
    for name in ('dialogue-database-unresolved.json','dialogue-database-consumer-dispositions.json'):
        d=json.loads(out[name])
        assert all(r==next(x for x in d['values'] if x['pointer']==r['pointer']) for r in previous)
        d['values']=[by_pointer.get(r['pointer'],r) for r in d['values']]
        d['phase']='0143-work'
        d['callerBindingArtifact']='dialogue-database-caller-bindings.json'
        if name.endswith('dispositions.json'):
            d['boundary']='All1660 exact prior selectors retained; five proved control keys unchanged.1655 residuals have finite serialized/caller boundary dispositions, not automatic source exclusions/admission. External/source-policy uncertainty remains explicit.'
        out[name]=js(d)
    current=[json.loads(s) for s in out['dialogue-database-values.jsonl'].splitlines()]
    out['dialogue-database-values.jsonl']=b''.join((json.dumps(by_pointer.get(r['pointer'],r),ensure_ascii=False,sort_keys=True,separators=(',',':'))+'\n').encode() for r in current)
    report=json.loads(out['dialogue-database-reconciliation.json'])
    report['phase']='0143-work'
    report['roleEvidence'].append('phase143/role-decisions.json')
    report['callerBindingArtifact']='dialogue-database-caller-bindings.json'
    report['unresolvedPredicates']=[dict(role=role,logicalValues=n,artifact='dialogue-database-unresolved.json',
        next='Finite original serialized/caller assignment complete. Use per-selector remainingPredicate: source admission preservation decision or identified external/runtime consumer; no unchanged static search.') for role,n in report['unresolvedRoles'].items()]
    out['dialogue-database-reconciliation.json']=js(report)
    lua=lua_inventory(); callers=caller_inventory()
    supplement=dict(schemaVersion=1,phase='0143-work', assignedResidualValues=1655, physicalResidualSelectors=3310,
        priorProvedControlKeysRetained=5, unresolvedLogicalValues=1655,
        countsByField=dict(Counter(r['fieldTitle'] for r in refined)),
        exactDispositionArtifact='dialogue-database-consumer-dispositions.json', exactRemainingArtifact='dialogue-database-unresolved.json',
        serializedBoundary=dict(artifact='../serialized-title-events/verification.json',instances=39,absentFields=['onDialogueEmptyWithTitledLine','onDialogueLine'],
            absentIsNotNull=True,positiveControl='onAdvanceMoment.m_PersistentCalls.m_Calls present39 times, empty lists',derivedTypes=0,
            metadata='StringPrimitiveEvent lacks Serializable flag/attribute; service event static; HideInInspector alone is not the exclusion reason',
            rosterSha256=sha(SERIAL/'instances.jsonl'),verificationSha256=sha(SERIAL/'verification.json')),
        codeTitleBoundary=dict(evidence=['phase136/title-ui-subscribers.txt','phase136/title-service-subscribers.txt','phase136/rascal-listener.il','phase136/rascal-title-handler.il','phase136/story-title-consumer.il'],
            namedSubscriber='RascalSoloBearStory.AddEventListeners/RemoveEventListeners',actualReceiver='OnDialogueEmptyWithTitledLine -> Contains(show ending screen) -> timer -> TriggerAdvanceMoment',
            remaining934ExactPredicateMatches=0,serviceOriginalDirectSubscribers=0,
            retainedBoundary='Only original game field-use/direct-code scope; arbitrary external/reflection/native runtime subscribers not excluded. Formatted whitespace and scene reachability not executed.'),
        luaArtifact='phase143/lua-inputs.json',callerArtifact='phase143/game-callers.json',
        finiteStaticAssignment='complete-for-all1655;uncertainty-retained',
        remainingDecision='Source admission must explicitly accept original-value preservation under the named bounded external/API contracts, or supply a concrete additional reader/sink. This phase neither excludes retained values nor waives full-game gates.',
        nextFiniteDeliverable='phase143/next-compiled-selectors.json', nextAction=NEXT,
        commonSourceAccepted=False,translationEntryAllowed=False,editorial='not-run',runtime='not-run',visual='not-run')
    managed=rows(BASE/'phase143/baseline/managed-literal-inventory.jsonl')
    literal_map={(r['method'],r['offset']):r for r in rows(INDEX/'literals.jsonl')}
    residual=[dict(r,source=literal_map[r['method'],r['offset']]['value']) for r in managed if r['role']=='needs-consumer-decision']
    assert len(residual)==1251 and len({r['method'] for r in residual})==443
    next_packet=dict(schemaVersion=1,phase='0143-work',occurrences=1251,methods=443,
        sourceIndex=str((INDEX/'literals.jsonl').relative_to(ROOT)),sourceIndexSha256=sha(INDEX/'literals.jsonl'),
        selectors=residual,postcondition='Consolidated exact original compiled-role decisions with preserved source identity/values and actual named producer/consumer boundaries; whole family or exact remaining IDs, never a tiny exception/session loop.',
        constraints='Reuse existing typed argument/full-body proofs; do not recursively prove framework/native implementations. All source/renderer/editorial/runtime gates remain real.')
    out.update({'dialogue-database-caller-bindings.json':js(supplement),'phase143/lua-inputs.json':js(lua),
                'phase143/game-callers.json':js(callers),'phase143/next-compiled-selectors.json':js(next_packet)})
    return out
