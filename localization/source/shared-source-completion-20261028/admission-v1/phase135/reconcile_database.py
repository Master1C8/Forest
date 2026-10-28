"""Finite source-tree reconciliation used by the existing admission recipe.

Original tree hashes define the complete value/selector universe, including
empty strings and nonstring leaves. Authored typed selectors partition it;
compact group digests never merge equal-wording occurrences or invent IDs.
No target text or game execution is involved.
"""
import hashlib
import json
import re
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[5]
HERE = Path(__file__).resolve().parent
BASE = HERE.parent


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def encoded(v):
    return json.dumps(v, ensure_ascii=False, sort_keys=True, separators=(',', ':')).encode()


def vh(v):
    return hashlib.sha256(encoded(v)).hexdigest()


def load(p):
    return json.loads(p.read_text())


def lines(p):
    return [json.loads(s) for s in p.read_text().splitlines()]


def walk(v, pointer=''):
    if isinstance(v, dict):
        for k, x in v.items():
            yield from walk(x, pointer + '/' + k.replace('~', '~0').replace('/', '~1'))
    elif isinstance(v, list):
        for i, x in enumerate(v):
            yield from walk(x, pointer + '/' + str(i))
    else:
        yield pointer, v


def get(tree, pointer):
    for token in pointer.strip('/').split('/'):
        token = token.replace('~1', '/').replace('~0', '~')
        tree = tree[int(token)] if isinstance(tree, list) else tree[token]
    return tree


ROOTS = {'START', 'PRIMARY', 'SECONDARY', 'IDLE', 'NAMED'}
COMMANDS = {'GET', 'GIVE', 'CONSUME', 'BIO', 'TRIGGER', 'PORTRAITS',
            'PORTRAITSALIGNL', 'PORTRAITSALIGNR', 'FINISHSTEP', 'FINISHARC',
            'ENCOUNTER', 'INTRODUCE', 'FONT'}
FAST_TRAVEL_TITLES = {3:'CentralForest',5:'Lake',7:'Mountains',14:'Plains_End',15:'DeepWoods',
                      13:'FT_DYNAMIC_ROOT',337:'FASTTRAVELCANCEL',718:'FT_CUSTOM_GREETING'}
FIELD_ROLES = {
    'actors': {'Name': 'protected-actor-lookup;potential-display-alias',
               'Pictures': 'protected-file-list', 'Description': 'empty-display-slot', 'IsPlayer': 'protected-boolean'},
    'items': {'Name': 'protected-quest-lookup;potential-display-alias', 'Pictures': 'protected-file-list',
              'Description': 'empty-display-slot', 'Is Item': 'protected-boolean',
              'Success Description': 'empty-display-slot', 'Failure Description': 'empty-display-slot',
              'State': 'protected-quest-state'},
    'variables': {'Name': 'protected-lua-variable-key', 'Initial Value': 'protected-initial-state',
                  'Description': 'empty-display-slot'},
    'conversations': {'Title': 'protected-conversation-lookup;potential-display-alias',
                      'Pictures': 'protected-file-list', 'Description': 'empty-display-slot',
                      'Actor': 'protected-actor-reference', 'Conversant': 'protected-actor-reference',
                      'TfolConversationType': 'preserve-custom-metadata;consumer-unresolved',
                      'TfolUniqueDataKeySuffix': 'preserve-custom-metadata;consumer-unresolved'},
    'entries': {'Title': 'partition-title', 'Pictures': 'protected-file-list',
                'Description': 'preserve-custom-metadata;consumer-unresolved',
                'Actor': 'protected-actor-reference', 'Conversant': 'protected-actor-reference',
                'Menu Text': 'empty-display-slot', 'Dialogue Text': 'empty-display-slot',
                'Parenthetical': 'empty-display-slot', 'Audio Files': 'protected-file-list',
                'Video File': 'empty-resource-slot', 'Sequence': 'protected-sequencer-program',
                'TfolUniqueDataKeySuffix': 'protected-arc-save-key-suffix',
                'Response Menu Sequence': 'empty-sequencer-slot'},
}


def classify(tree, pointer, value, frozen_by_pointer, named):
    if pointer in frozen_by_pointer:
        r = frozen_by_pointer[pointer]
        assert r['source'] == value, ('frozen-value', r['id'])
        return 'frozen-display-candidate', 'frozen-dialogue', r['id'], False
    normalized = re.sub(r'/\d+(?=/|$)', '/*', pointer)
    tokens = pointer.strip('/').split('/')
    if '/fields/' in pointer:
        field = get(tree, pointer.rsplit('/', 1)[0])
        owner = 'entries' if '/dialogueEntries/' in pointer else tokens[0]
        assert owner in FIELD_ROLES and field['title'] in FIELD_ROLES[owner], ('unread-field', pointer)
        leaf = tokens[-1]
        assert leaf in ('title', 'typeString', 'value'), ('unread-field-leaf', pointer)
        group = owner + ':' + field['title'] + ':' + leaf
        if leaf != 'value':
            return 'protected-schema-key-or-type', group, None, False
        role = FIELD_ROLES[owner][field['title']]
        if not value:
            return 'preserved-empty-state', group, None, False
        if role.startswith('empty-'):
            raise ValueError('unexpected-nonempty-slot:' + pointer)
        if role == 'partition-title':
            co, en = tree['conversations'][int(tokens[1])], get(tree, '/'.join([''] + tokens[:4]))
            if value in ROOTS:
                role = 'protected-arc-root-title'
            elif (co['id'], en['id']) in named:
                role = 'protected-named-arc-key'
            elif co['id']==58 and en['id'] in FAST_TRAVEL_TITLES:
                assert value==FAST_TRAVEL_TITLES[en['id']], ('fast-travel-selection-key',pointer)
                role = 'protected-fast-travel-selection-key'
            elif value.split('(', 1)[0].upper() in COMMANDS:
                role = 'protected-dispatch-command-title'
            else:
                role = 'retained-node-label;consumer-unresolved'
        if owner == 'entries' and field['title'] == 'Description':
            assert value == 'DYNAMIC_RESPONSE_OPTION', ('unread-description', pointer)
        if role == 'protected-file-list':
            assert value == '[]', ('unexpected-file-list', pointer)
        if role == 'protected-boolean':
            assert value in ('True', 'False'), ('unexpected-boolean', pointer)
        if role == 'protected-actor-reference':
            assert re.fullmatch(r'-?\d+', value), ('unexpected-actor-reference', pointer)
        if role == 'protected-sequencer-program':
            assert value in ('None()', 'required Delay(1);Continue()@1;',
                             'required Delay(2);Continue()@2;',
                             'required ClearSubtitleText(all);Delay(2);Continue()@2;'), ('unread-sequence', pointer)
        return role, group, None, role.endswith('consumer-unresolved')
    property_roles = {
        '/m_Name': 'protected-resource-name', '/version': 'preserved-empty-metadata',
        '/author': 'preserved-empty-metadata', '/description': 'preserved-empty-metadata',
        '/globalUserScript': 'preserved-empty-lua-program', '/templateJson': 'protected-editor-template',
        '/conversations/*/overrideSettings/defaultSequence': 'preserved-empty-sequencer-default',
        '/conversations/*/overrideSettings/defaultPlayerSequence': 'preserved-empty-sequencer-default',
        '/conversations/*/overrideSettings/defaultResponseMenuSequence': 'preserved-empty-sequencer-default',
        '/conversations/*/overrideSettings/cancelSubtitle/buttonName': 'preserved-empty-input-key',
        '/conversations/*/overrideSettings/cancelConversation/buttonName': 'preserved-empty-input-key',
        '/conversations/*/nodeColor': 'preserved-empty-editor-color',
        '/conversations/*/dialogueEntries/*/nodeColor': 'preserved-empty-editor-color',
        '/conversations/*/dialogueEntries/*/falseConditionAction': 'protected-condition-enum',
        '/conversations/*/dialogueEntries/*/conditionsString': 'protected-lua-condition',
        '/conversations/*/dialogueEntries/*/userScript': 'protected-lua-program',
        '/conversations/*/entryGroups/*/name': 'retained-editor-group-label;potential-display',
    }
    if normalized not in property_roles:
        raise ValueError('unread-string-selector:' + pointer)
    role = property_roles[normalized]
    if role.startswith('preserved-empty'):
        assert value == '', ('nonempty-previously-empty-slot', pointer)
    if role == 'protected-condition-enum':
        assert value in ('', 'Block', 'Passthrough'), ('unread-condition-enum', pointer)
    return role, normalized, None, False


def check_partition(source, row):
    assert hashlib.sha256(source.encode()).hexdigest() == row['sourceSha256'], 'partition-source'
    end = 0
    for span in row['partition']:
        assert span['start'] == end < span['end'] <= len(source), 'partition-bounds'
        assert source[span['start']:span['end']] == span['text'], 'partition-value'
        end = span['end']
    assert end == len(source), 'partition-incomplete'


def products():
    pins = load(HERE / 'input-pins.json')
    for p, digest in pins.items():
        assert sha(ROOT / p) == digest, ('phase135-evidence-changed', p)
    source_manifest = load(ROOT / 'localization/source/dialogue-manifest.json')
    frozen = lines(ROOT / 'localization/source/dialogue-candidates.jsonl')
    lexical = lines(ROOT / 'localization/source/shared-source-completion-20261028/dialogue-grammar/protected-spans.jsonl')
    assert [r['id'] for r in lexical] == [r['id'] for r in frozen]
    partitions = []
    for f, lex in zip(frozen, lexical):
        assert lex['occurrences'] == f['occurrences'] and lex['pointer'] == f['pointer']
        spans = sorted(lex['protectedSpans'] + [dict(s, kind='preserved-line-separator') for s in lex['lineSeparators']], key=lambda s:s['start'])
        parts, previous = [], 0
        for s in spans:
            if previous < s['start']:
                parts.append(dict(start=previous, end=s['start'], text=f['source'][previous:s['start']], kind='ordinary-lexical-text;field-eligibility-separate'))
            parts.append(s)
            previous = s['end']
        if previous < len(f['source']):
            parts.append(dict(start=previous, end=len(f['source']), text=f['source'][previous:], kind='ordinary-lexical-text;field-eligibility-separate'))
        row = dict(id=f['id'], sourceSha256=lex['sourceSha256'], sourceValueSha256=vh(f['source']),
                   pointer=f['pointer'], occurrences=f['occurrences'], partition=parts,
                   consumerEvidence='dialogue-grammar/verification.json;phase135/input-pins.json')
        check_partition(f['source'], row)
        partitions.append(row)
    trees = []
    for spec in source_manifest['sources']:
        p = ROOT / spec['tree']
        assert sha(p) == spec['treeSha256'], ('original-tree-pin', spec['tree'])
        trees.append(load(p))
    assert trees[0]['conversations'] == trees[1]['conversations']
    string_maps = [{p:v for p,v in walk(t) if isinstance(v,str)} for t in trees]
    assert list(string_maps[0].items()) == list(string_maps[1].items()), 'copy-string-multiplicity'
    frozen_by_pointer = {r['pointer']:r for r in frozen}
    assert len(frozen_by_pointer) == 12246
    named = set()
    for c in trees[0]['conversations']:
        for e in c['dialogueEntries']:
            if next(f['value'] for f in e['fields'] if f['title']=='Title') == 'NAMED':
                named.update((c['id'],link['destinationDialogueID']) for link in e['outgoingLinks'])
    groups, semantic, unknown = {}, [], []
    roles, field_roles = Counter(), Counter()
    originals = source_manifest['sources']
    for p,v in string_maps[0].items():
        role, selector, logical, unresolved = classify(trees[0],p,v,frozen_by_pointer,named)
        key = (selector, role)
        if key not in groups:
            groups[key] = dict(selector=selector,role=role,logicalStates=0,nonemptyStates=0,
                               orderedStateDigest=hashlib.sha256())
        g = groups[key];g['logicalStates'] += 1;g['nonemptyStates'] += bool(v)
        g['orderedStateDigest'].update(encoded([p,v])+b'\n')
        roles[role] += 1
        if role != 'frozen-display-candidate' and (p.endswith('/value') or role in (
            'protected-lua-condition','protected-lua-program','retained-editor-group-label;potential-display')):
            field_roles[role] += 1
            # Constant schema/empty/numeric-reference/file-list states are fully
            # reconstructed by the typed selectors and ordered group digest.
            # Material nonempty source values get their own physical IDs.
            if v and role not in ('protected-file-list','protected-actor-reference','protected-boolean'):
                r = dict(pointer=p,occurrences=[s['object']+p for s in originals],source=v,
                         sourceValueSha256=vh(v),role=role,translationId=None,
                         application='preserve-original;new-display-binding-and-common-gates-required')
                if '/dialogueEntries/' in p:
                    tokens=p.split('/');r.update(conversationId=trees[0]['conversations'][int(tokens[2])]['id'],
                        entryId=trees[0]['conversations'][int(tokens[2])]['dialogueEntries'][int(tokens[4])]['id'])
                semantic.append(r)
                if unresolved:
                    unknown.append(r)
    group_rows=[]
    for g in groups.values():
        g['orderedPointerValueSha256']=g.pop('orderedStateDigest').hexdigest()
        g['physicalStringStates']=2*g['logicalStates']
        group_rows.append(g)
    preserved=[]
    for t,spec in zip(trees,originals):
        leaf_counts=Counter(type(v).__name__ for p,v in walk(t))
        # Reuse the original exact removal contract, with no target application.
        for r in frozen:
            parent=get(t,r['pointer'].rsplit('/',1)[0]);assert parent['value']==r['source']
            parent['value']={'candidateId':r['id']}
        digest=hashlib.sha256(encoded(t)+b'\n').hexdigest()
        assert digest==spec['allNoncandidateValuesSha256'], ('whole-noncandidate-boundary',spec['object'])
        preserved.append(dict(object=spec['object'],tree=spec['tree'],treeSha256=spec['treeSha256'],
                              allNoncandidateValuesSha256=digest,scalarTypes=dict(leaf_counts)))
    # Complete exported nonempty source union. Exact physical occurrence keys,
    # not a wording set or an assumption about the exporter's empty policy.
    export=load(ROOT/'assets/source-v2/string-fields.json')
    source_objects={s['object']:i for i,s in enumerate(originals)}
    db=[r for r in export if r['object'] in source_objects]
    expected={(s['object']+p):v for s in originals for p,v in string_maps[0].items() if v}
    assert len(db)==len(expected)==875796
    assert len({r['id'] for r in db})==len(db)
    for r in db:
        assert r['id']==r['object']+r['pointer'] and expected.pop(r['id'])==r['value'], 'export-selector-value'
    assert not expected
    non_db=[r['id'] for r in export if r['object'] not in source_objects]
    retained=lines(BASE/'serialized-inventory.jsonl')
    assert set(non_db)=={r['id'] for r in retained} and len(non_db)==len(retained)==36107
    assert len(export)==911903
    template=load(ROOT/originals[0]['tree'])['templateJson']
    template_leaves=[dict(pointer=p,source=v,sourceValueSha256=vh(v),role='protected-editor-schema-or-default')
                     for p,v in walk(json.loads(template))]
    original_tree = load(ROOT/originals[0]['tree'])
    travel=next(c for c in original_tree['conversations'] if c['id']==58)
    greeting=next(e for e in travel['dialogueEntries'] if e['id']==718)
    assert len(greeting['outgoingLinks'])>0
    greeting_target=greeting['outgoingLinks'][0]['destinationDialogueID']
    dependency_nodes=set(FAST_TRAVEL_TITLES)|{greeting_target}
    travel_ids=[r['id'] for r in frozen if r['conversationId']==58 and r['entryId'] in dependency_nodes]
    travel_case=dict(schemaVersion=1,id='fast-travel-selection-identity',conversationId=58,
        exactTitleKeys=FAST_TRAVEL_TITLES,customGreetingWriteTarget=greeting_target,
        sourceIds=travel_ids,sourceContext=[e for e in travel['dialogueEntries'] if e['id'] in dependency_nodes],
        sourceContextBoundary='Exact original fields, conditions, scripts, callbacks and links for selected source/control nodes; complete whole-conversation reachability is not claimed.',
        consumer='phase135/fast-travel-producer.il',consumerSha256=sha(HERE/'fast-travel-producer.il'),
        flow=['Require an active conversation; select system/fastTravel by protected conversation Title.',
              'Resolve FASTTRAVELCANCEL, FT_DYNAMIC_ROOT and FT_CUSTOM_GREETING by exact node Title.',
              'Clear dynamic-root links; add links for each exact input-string == node.Title match, then append cancel.',
              'For nonempty custom greeting, overwrite DialogueText of first FT_CUSTOM_GREETING successor with the method argument.',
              'Force the next state to the stored first conversation entry.'],
        adaptationContract='Translate eligible display fields separately; retain all conversation/node Title selection identities and order. Trace both external method arguments before claiming complete wording coverage or application readiness. Localizing Title instead of display can remove available destinations.',
        descriptionMarkers='Five DYNAMIC_RESPONSE_OPTION Description values retained exact. This game body does not read Description; other/plugin dynamic consumers remain unresolved, not absent.',
        externalBoundaries=['List<string> destination identities and custom greeting argument originate outside this method; caller producer/binding and real gameplay not yet accepted.'],
        runtime='not-run',editorial='not-run',localeDecisions={},commonSourceAccepted=False)
    index=ROOT/'outputs/pause-inventory-bio-completion-20261028/managed-index'
    calls_path=index/'calls.jsonl'
    assert sha(calls_path)==load(index/'manifest.json')['files']['calls.jsonl']['sha256']
    named_consumers=('PixelCrushers.DialogueSystem.DialogueEntry::get_Title()',
                     'PixelCrushers.DialogueSystem.Conversation::GetDialogueEntry(System.String)',
                     'TheForestOfLove.Narrative.DialogueService::BuildFastTravelConversation(')
    selected_calls=[r for r in lines(calls_path) if any(n in r['called'] for n in named_consumers)]
    consumer_selectors=dict(schemaVersion=1,input=str(calls_path.relative_to(ROOT)),sha256=sha(calls_path),
        selectorSignatures=list(named_consumers),calls=selected_calls,
        boundary='Existing exact original game call-index candidates for remaining named predicates. Not complete consumer review, runtime display acceptance or absence proof; custom-field/vendor readers remain separate.')
    # Named exact consumer gaps are not promoted to safe-to-translate fields.
    unresolved_counts=Counter(r['role'] for r in unknown)
    report=dict(schemaVersion=1,phase='0135-work',status='complete-string-selector-and-value-partition;consumer-gaps-explicit',
        sources=preserved,sourceStringsPerCopy=len(string_maps[0]),physicalStringStates=2*len(string_maps[0]),
        frozenLogicalIds=12246,frozenPhysicalOccurrences=24492,
        noncandidateStringStates=2*(len(string_maps[0])-12246),
        exportedNonemptyDatabaseStrings=len(db),retainedNonDatabaseExportStrings=len(retained),
        completeExportUnion=911903,rolesPerCopy=dict(roles),semanticFieldRolesPerCopy=dict(field_roles),
        selectorGroups=group_rows,materialNoncandidateValueRecords=len(semantic),
        unresolvedLogicalValues=len(unknown),unresolvedRoles=dict(unresolved_counts),
        selectorSemantics='Each typed group expands against both pinned original trees, in source order, to every exact pointer/value state. Digests include pointer and full value, including empty strings. No occurrence or logical display ID is merged by wording. Nonstring state is protected by the original whole-tree removal digest.',
        unresolvedPredicates=[
            dict(role='retained-node-label;consumer-unresolved',producer='DialogueEntry.Title outside exact roots/13 command families/NAMED outgoing labels',
                 body='Named original game consumers of DialogueEntry.get_Title / Conversation.GetDialogueEntry(string); older command labels may be dormant but absence is unproved.',
                 next='Join every exact retained selector to existing game call-index consumers; preserve note prose and old control syntax, no invented translation IDs.'),
            dict(role='preserve-custom-metadata;consumer-unresolved',producer='Conversation.TfolConversationType/TfolUniqueDataKeySuffix and five DYNAMIC_RESPONSE_OPTION Description values',
                 body='Field.AssignedField/Lookup consumers and any vendor/dynamic field reader; current loader gets dialogue type/savekey from BG, which does not prove these custom fields unreachable.',
                 next='Resolve the exact original producer/consumer joins or retain an explicit potential/dormant-display boundary; no recursive framework absence audit.')],
        evidencePins=pins,roleEvidence='phase135/database-role-decisions.json',grammar=dict(artifact='dialogue-inline-partitions.jsonl',sourceFields=12246,physicalOccurrences=24492,
            protectedSpans=7103,lineSeparators=291,unresolvedLexicalSpans=0,fieldEligibilityAccepted=False),
        gates=dict(commonSourceAccepted=False,translationEntryAllowed=False,editorial='not-run',runtime='not-run',visual='not-run'),
        boundary='Static inventory and authored typed-role expansion; lexical ordinary spans are not whole-field eligibility. Preserve all originals/targets/old935 packets. No display-alias, registered-effect, whole-parser execution or whole-game source acceptance.')
    return {'dialogue-database-reconciliation.json':(json.dumps(report,ensure_ascii=False,indent=2)+'\n').encode(),
            'dialogue-database-values.jsonl':b''.join(encoded(r)+b'\n' for r in semantic),
            'dialogue-database-unresolved.json':(json.dumps(dict(schemaVersion=1,counts=dict(unresolved_counts),values=unknown),ensure_ascii=False,indent=2)+'\n').encode(),
            'dialogue-template-preserve.json':(json.dumps(dict(sourceValueSha256=vh(template),leaves=template_leaves),ensure_ascii=False,indent=2)+'\n').encode(),
            'fast-travel-source-dependencies.json':(json.dumps(travel_case,ensure_ascii=False,indent=2)+'\n').encode(),
            'dialogue-database-game-consumer-selectors.json':(json.dumps(consumer_selectors,ensure_ascii=False,indent=2)+'\n').encode(),
            'dialogue-inline-partitions.jsonl':b''.join(encoded(r)+b'\n' for r in partitions)}
