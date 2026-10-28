"""Build this bounded static receipt from pinned inputs; never runs game or extraction.

Run from the canonical Forest directory. All writes are restricted to this script's
check directory. IL acquisition is reproducible via method-acquisition.json; it uses
the existing frozen inspector and original assembly, without compilation.
"""
import hashlib
import json
import pathlib
import re

ROOT = pathlib.Path('/Users/antonkrutov/Desktop/Forest')
CHECK = pathlib.Path(__file__).resolve().parent
assert CHECK == ROOT / 'outputs/penny-tutorial-source-join-20261029/check'
SOURCE = ROOT / 'localization/source/narrative-displays-20261029'
OLD = ROOT / 'outputs/narrative-display-source-20261029/check'
REUSE = ROOT / 'outputs/narrative-reuse-review-20261029/check'


def sha(data):
    return hashlib.sha256(data).hexdigest()


def load(path):
    return json.loads(path.read_text())


def write(name, data):
    (CHECK / name).write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n')


pins = load(CHECK / 'input-pins.initial.json')


def pin(path):
    path = pathlib.Path(path)
    if not path.is_absolute():
        path = ROOT / path
    key = str(path.relative_to(ROOT)) if path.is_relative_to(ROOT) else str(path)
    digest = sha(path.read_bytes())
    if key in pins:
        assert digest == pins[key], ('input changed', key)
    else:
        pins[key] = digest
    return {'path': key, 'sha256': digest}


assert load(CHECK / 'runtime-check.json')['verified'] is True
for name in ['brief.md', 'dispatch.json', 'runtime-verification.json']:
    pin(CHECK / name)
for name in ['AGENTS.md', 'tools/probe/InspectMethods.cs',
             'localization/source/narrative-displays-20261029.parent-inventory-acceptance.json',
             'assets/source-v2/objects.json', 'localization/ru-assets/dialogue.ru.jsonl']:
    pin(name)
for name in ['native-pointer-readback.json', 'native-pointer-supplement.json',
             'input-manifest.json', 'il/PagedTutorial.il']:
    pin(OLD / name)

objects = {x['id']: x for x in load(ROOT / 'assets/source-v2/objects.json')}
original_dll = pin(OLD / 'execution/Assembly-CSharp.dll')
assert original_dll['sha256'] == '46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
assert pins['localization/ru-assets/dialogue.ru.jsonl'] == load(OLD / 'input-manifest.json')['preservedFrozenDialogueSha256']


def tree(object_id):
    obj = objects[object_id]
    path = ROOT / 'assets/source-v2' / obj['tree']
    evidence = pin(path)
    assert evidence['sha256'] == obj['treeSha256']
    return load(path), {'object': object_id, 'rawSha256': obj['rawSha256'], **evidence}


owner, owner_ev = tree('sharedassets2.assets:18057')
tutorial, tutorial_ev = tree('sharedassets2.assets:15852')
owner_go, owner_go_ev = tree('sharedassets2.assets:4561')
tutorial_go, tutorial_go_ev = tree('sharedassets2.assets:3684')
sixth_go, sixth_go_ev = tree('sharedassets2.assets:4214')
assert owner['pennyCloacaFistingStoryPrefab'] == {'m_FileID': 0, 'm_PathID': 15852}
assert owner['m_GameObject']['m_PathID'] == 4561
assert any(x['component']['m_PathID'] == 18057 for x in owner_go['m_Component'])
assert tutorial['m_GameObject']['m_PathID'] == 3684
assert len(tutorial['pages']) == len(tutorial['nav']) == 6
assert tutorial['onSubmit']['m_PersistentCalls']['m_Calls'] == []
assert tutorial['onTutorialFinished']['m_PersistentCalls']['m_Calls'] == []
controller = next(x for x in load(SOURCE / 'controllers.json') if x['ownerObject'] == 'sharedassets2.assets:15852')
assert controller['serializedOwnerControls'] == tutorial
pages = [json.loads(l) for l in (SOURCE / 'source.jsonl').read_text().splitlines()]
assert len(pages) == 25
pages = [x for x in pages if x['ownerObject'] == 'sharedassets2.assets:15852']
assert len(pages) == 5
ids = [x['id'] for x in pages]
occ_ids = [i for p in pages for i in p['occurrenceIds']]
assert len(occ_ids) == len(set(occ_ids)) == 30
assert ids == controller['sourcePageIds']
parent = load(ROOT / 'localization/source/narrative-displays-20261029.parent-inventory-acceptance.json')
assert set(ids) <= set(parent['pageIds']) and set(occ_ids) <= set(parent['occurrenceIds'])
assert len(parent['pageIds']) == 25 and len(parent['occurrenceIds']) == 150
for name, expected in parent['productPins'].items():
    assert pin(SOURCE / name)['sha256'] == expected['sha256']
source_case = load(SOURCE / 'source-case.json')
assert set(occ_ids) <= set(source_case['exactOccurrenceIds'])
reuse = [json.loads(l) for l in (REUSE / 'reuse-review.jsonl').read_text().splitlines()]
reuse = [x for x in reuse if x['pageId'] in ids]
assert len(reuse) == 5 and all(x['disposition'] == 'source-join-unresolved' for x in reuse)
protected = load(SOURCE / 'protected-controls.json')
protected_rows = {x['id']: x for x in protected['serialized'] if x['id'] in occ_ids}
assert len(protected_rows) == 30
all_occurrences = [json.loads(l) for l in (SOURCE / 'occurrence-map.jsonl').read_text().splitlines()]
assert len(all_occurrences) == 150
occurrences = {x['id']: x for x in all_occurrences if x['id'] in occ_ids}

context = load(SOURCE / 'producer-context.json')
conversation = next(c for c in context['conversations'] if c['conversationId'] == 273)
assert len(conversation['entries']) == 7
entries = {x['entry']['id']: x for x in conversation['entries']}
actors = [x for x in context['actors'] if x['id'] in [1, 8]]
assert len(actors) == 2
database_path = ROOT / context['databaseTree']
assert pin(database_path)['sha256'] == context['databaseTreeSha256']
database = load(database_path)
assert database['conversations'][223]['id'] == 273
assert database['conversations'][223]['fields'] == conversation['fields']
actor_evidence = []
for actor in actors:
    matches = [(i, a) for i, a in enumerate(database['actors']) if a['id'] == actor['id']]
    assert len(matches) == 1 and matches[0][1] == actor
    actor_evidence.append({'actorId': actor['id'], 'sourcePointer': '/actors/' + str(matches[0][0]), 'record': actor})

method_evidence = []
for path in sorted((CHECK / 'il').glob('*.il')):
    text = path.read_text()
    matches = list(re.finditer(r'^METHOD (.+)$', text, re.M))
    for i, m in enumerate(matches):
        end = matches[i + 1].start() if i + 1 < len(matches) else len(text)
        body = text[m.start():end]
        method_evidence.append({'method': m.group(1).split(' | ')[0],
                                'path': str(path.relative_to(ROOT)), 'fileSha256': sha(path.read_bytes()),
                                'lineStart': text[:m.start()].count('\n') + 1,
                                'lineEndInclusive': text[:end].count('\n'),
                                'fullBodySha256': sha(body.encode()), 'fullBody': body})
write('method-evidence.json', method_evidence)
assert (CHECK / 'il/penny-field-references.txt').read_text().count('\n') == 1
assert (CHECK / 'il/penny-show-callers.txt').read_text() == ''
assert (CHECK / 'il/penny-show-literal.txt').read_text() == ''
commands = load(CHECK / 'method-acquisition.json')
assert all(x['exitCode'] == 0 and not x['stderr'] for x in commands)

page_results = []
expected_entries = [2, 3, 138, 139, 135]
for index, page in enumerate(pages):
    assert page['memberBinding'] == controller['slots'][index]
    assert page['controllerStateBeforeSelection'] == index
    assert sha(page['source'].encode()) == page['sourceUtf8Sha256']
    assert sha(json.dumps(page['source'], ensure_ascii=False).encode()) == page['sourceValueSha256']
    candidate = page['dialogueReuseCandidates'][0]
    entry = entries[expected_entries[index]]
    assert candidate['entry'] == entry['entry']
    assert database['conversations'][223]['dialogueEntries'][int(entry['sourcePath'].split('/')[-1])] == entry['entry']
    fields = {f['title']: f['value'] for f in entry['entry']['fields']}
    assert fields['Dialogue Text'] == page['source'] and fields['Actor'] == '8' and fields['Conversant'] == '1'
    spans = []
    for occurrence_id in page['occurrenceIds']:
        occurrence = occurrences[occurrence_id]
        span = occurrence['sourceSpan']
        path = ROOT / span['path']
        assert pin(path)['sha256'] == span['sha256']
        raw = path.read_bytes()
        value = json.loads(raw[span['jsonTokenByteStart']:span['jsonTokenByteEndExclusive']])
        assert value == load(path)['m_text'] == page['source']
        controls = dict(load(path)); del controls['m_text']
        assert controls == protected_rows[occurrence_id]['controls']
        spans.append({'occurrenceId': occurrence_id, 'role': occurrence['role'], 'sourceSpan': span,
                      'sourceValueSha256': page['sourceValueSha256'], 'protectedNontextFieldsEqual': True})
    page_results.append({'pageId': page['id'], 'pageOrder': index, 'source': page['source'],
                         'sourceUtf8Sha256': page['sourceUtf8Sha256'], 'occurrenceIds': page['occurrenceIds'],
                         'occurrences': spans, 'memberBinding': page['memberBinding'],
                         'fieldFactoryEvidence': ['sharedassets2.assets:18057/pennyCloacaFistingStoryPrefab',
                                                  'ItemGetNotification::ShowPennyCloacaFistingStory IL_0002,0007',
                                                  'ItemGetNotification::ShowPagedTutorial IL_0018-0024'],
                         'callerEvidence': 'Zero method-reference operands for the exact public Penny entry point in the pinned Assembly-CSharp.dll; activation caller is unresolved.',
                         'phraseSource': {'id': candidate['id'], 'sourcePath': entry['sourcePath'],
                                          'actor': fields['Actor'], 'conversant': fields['Conversant'],
                                          'entry': entry['entry']},
                         'actorEvidence': 'producer-context actors/8 is bird; actors/1 is player. These belong to the separate conversation, not a proven tutorial actor.',
                         'pointOfView': 'First-person recollection; no listener is established. She/her refers to an unnamed female partner. Page4 expressly says lady. Names, identity and a tutorial listener are not established by this wording.',
                         'physicalSpeakerJoinProved': False, 'sourceAccepted': False, 'targetApplied': False})

sixth_native = next(x for x in load(OLD / 'native-pointer-readback.json')['objects'] if x['object'] == 'sharedassets2.assets:13647')
sixth_transform = load(OLD / 'native-pointer-supplement.json')['objects'][0]
for x in [sixth_native, sixth_transform]:
    assert objects[x['object']]['rawSha256'] == x['rawSha256']
assert sixth_native['tree']['m_GameObject']['m_PathID'] == 4214
assert sixth_transform['object'] == 'sharedassets2.assets:10054'
assert controller['slots'][5]['gameObject'] == 'sharedassets2.assets:4214'

resolved = [
    {'id': 'exact-physical-resource', 'predicate': 'Owner field points to the old tutorial, not the bundle movie.', 'status': 'resolved', 'evidence': [owner_ev, tutorial_ev, owner_go_ev, tutorial_go_ev]},
    {'id': 'field-reader', 'predicate': 'Enumerate exact field readers in original game assembly.', 'status': 'resolved', 'evidence': 'One ldfld at ShowPennyCloacaFistingStory IL_0002; full body calls ShowPagedTutorial at 0007.'},
    {'id': 'factory', 'predicate': 'Establish exact prefab instantiation and dynamic listeners.', 'status': 'resolved-static-contract', 'evidence': 'ShowPagedTutorial returns null when visible; otherwise Instantiate<PagedTutorial>(prefab,messageContainer) at001f. allowNavigation=false at0030; 2.5-second callback b__0 sets true. nav is reparented via 005d. onSubmit b__1 is installed at 0079 and triggers pressed; onTutorialFinished b__2 is installed at 0095, hides notification, schedules b__3 after 2 seconds, and invokes onTutorialEnding. b__3 reparents nav and destroys the instance. onTutorialStarting is invoked at 009f; StartNotification at 00a5.'},
    {'id': 'six-slots-and-callbacks', 'predicate': 'Bind all five text pages and retain sixth slot and protected events.', 'status': 'resolved-static-contract', 'evidence': 'Five pages/30 exact spans verified. Sixth CanvasGroup13647 belongs to GO4214, has no assigned narrative text, and remains pages/5. Native supplement retains transform10054 child12070 without inventing a text binding. PagedTutorial Update at 0077 finishes on index5 and invokes onSubmit at 009d. Both serialized persistent-call arrays are empty; the factory adds runtime listeners conditionally.'},
    {'id': 'conversation-provenance', 'predicate': 'Bind five phrase matches and separate actor metadata/order.', 'status': 'resolved-provenance-only', 'evidence': 'Conversation 273 entries 2->3->138->139->135, each actor 8=bird, conversant 1=player. IDLE 131 links to2. Exact words/order are corroborating provenance and not a physical speaker join.'},
]
remaining = [
    {'id': 'activation-caller', 'predicate': 'Identify an actual caller/registration/serialized route that activates ShowPennyCloacaFistingStory on this owner.', 'status': 'bounded-unresolved', 'evidence': 'Zero exact MethodReference operands and zero exact ldstr operands for ShowPennyCloacaFistingStory in original Assembly-CSharp. Owner RegisterServices registers ItemGetNotification; AddEventListeners subscribes OnItemAdded, not the Penny method. No route is established. Candidate text search found no spelling in the existing extracted trees/text-assets or two named cached source directories; this is not an external absence proof.', 'nextPermittedAction': 'Parent retains potential-resource disposition. Obtain a concrete serialized/script route or an explicit source/context adjudication; an observed runtime route requires separate applicable owner authorization. Do not repeat unchanged scans.'},
    {'id': 'physical-speaker', 'predicate': 'Bind this tutorial instance to a narrator, addressee, and conversation 273.', 'status': 'bounded-unresolved', 'evidence': 'The complete named reader/factory/callback bodies contain no actor/conversation parameter or StartDialogue call. Their generic GameEvents and service/native execution boundaries do not prove a listener or story identity. Exact source equality, field/root names, and the excluded movie homonym are insufficient.', 'nextPermittedAction': 'Parent must establish a concrete version-bound route/actor join or explicitly adjudicate the old tutorial context before target reuse admission. No target wording re-review or application in this job.'},
    {'id': 'runtime-and-delivery', 'predicate': 'Actual instantiation, timer/event execution, rendered visibility and target resource acceptance.', 'status': 'not-run', 'nextPermittedAction': 'Retain separate source/editorial/font/package/runtime gates; no global 23-case waiver.'},
]
write('source-join.json', {
    'schemaVersion': 1, 'scope': 'Exact old Penny tutorial only: five pages, 30 occurrences, six slots; static check.',
    'runtimeVerification': 'runtime-check.json', 'originalAssembly': original_dll,
    'handoffReconciliation': {'parentInventory': '25-page/150-occurrence conservative increment, unchanged; complete consumer admission remains false.',
                              'sourceCase': source_case['id'], 'reuseFinding': 'R02 refined: named prefab factory and instance listeners now proven statically; actual activation and physical speaker join remain unresolved. R07 unchanged.',
                              'fiveReuseDispositionsRetained': True, 'targetSemanticReviewPerformed': False},
    'owner': {'object': owner_ev, 'gameObject': owner_go_ev, 'serializedControls': owner,
              'field': '/pennyCloacaFistingStoryPrefab', 'pointer': owner['pennyCloacaFistingStoryPrefab'],
              'unrelatedControls': {'gossipTutorialPrefab': owner['gossipTutorialPrefab'], 'outOfSyncContentPrefab': owner['outOfSyncContentPrefab']}},
    'tutorial': {'object': tutorial_ev, 'serializedControls': tutorial, 'slots': controller['slots'],
                 'sixthGameObject': sixth_go_ev, 'sixthNativeCanvasGroup': sixth_native,
                 'sixthNativeTransform': sixth_transform, 'cachedSelectionContract': controller,
                 'excludedHomonym': controller['excludedHomonym']},
    'pages': page_results, 'actorEvidence': actor_evidence,
    'phraseContext': {'database': pin(database_path), 'conversationId': 273, 'conversationFields': conversation['fields'],
                      'completeSevenEntryContext': conversation['entries'], 'contextFile': pin(REUSE / 'context-273.jsonl'),
                      'contextFileLimitation': 'Despite its extension this is a compact text header followed by seven JSON entry lines; actor metadata is in producer-context and original database.'},
    'methodEvidence': 'method-evidence.json', 'acquisition': 'method-acquisition.json',
    'assemblyBoundNegative': {'target': 'System.Void TheForestOfLove.ItemGetNotification::ShowPennyCloacaFistingStory()',
                              'methodReferenceOperands': 0, 'exactMethodNameStringLiterals': 0,
                              'scope': 'All HasBody methods across nested types in the pinned original Assembly-CSharp.dll, using frozen InspectMethods modes. Includes call,callvirt,ldftn and any other MethodReference operand.',
                              'limits': 'Does not establish absence from other assemblies, unextracted/native/external serialized data, reflection or generated/split strings. No absence or unreachable-resource claim.'},
    'resolvedPredicates': resolved, 'remainingPredicates': remaining,
    'protectedPins': {'source': pin(SOURCE / 'source.jsonl'), 'controls': pin(SOURCE / 'protected-controls.json'),
                      'sourceCase': pin(SOURCE / 'source-case.json'), 'frozenDialogue': pin('localization/ru-assets/dialogue.ru.jsonl'),
                      'preservedKeys': ['all owner and tutorial serialized fields', 'pages/nav pointers and order', 'empty persistent event arrays',
                                        'selected/show/hide/pressed animator keys', 'conversation title,type,unique data keys,Actor,Conversant',
                                        'entry conditions,scripts,onExecute,outgoingLinks', 'all 30 nontext controls including resources and layout'],
                      'policy': 'No source admission, target application, source/glossary/target edits or save/scene/control changes.'},
    'sourceAccepted': False, 'targetApplied': False, 'runtime': 'not-run', 'wholeGameAccepted': False,
})

# Record the already-completed candidate search without repeating the unchanged scan.
write('candidate-search.json', {'argv': ['rg', '-l', '--no-ignore', 'ShowPennyCloacaFistingStory',
                                       'assets/source-v2/trees', 'assets/source-v2/text-assets',
                                       'localization/source/tutorial-20261026', 'localization/source/inventory-20261026'],
                                'exitCode': 1, 'stdout': '', 'stderr': '',
                                'role': 'Candidate spelling search only; no semantic/external absence acceptance.'})
write('input-pins.initial.json', pins)
verification = []
for path, expected in pins.items():
    actual = sha((ROOT / path).read_bytes())
    assert actual == expected, ('input changed', path)
    verification.append({'path': path, 'before': expected, 'after': actual, 'unchanged': True})
write('input-preservation.json', {'allPinnedInputsUnchanged': True, 'files': verification,
                                  'boundary': 'No writes outside this check directory. Initial pins were captured before receipt generation; source and extraction inputs remain immutable.'})
write('validation.json', {'runtimeIdentityVerifiedBeforeContent': True, 'originalAssemblyHashMatches': True,
                         'parentProductPinsMatch': True, 'pagesVerified': 5, 'sourceOccurrencesVerified': 30,
                         'exactJsonTokenReadbacks': 30, 'protectedNontextEqualityChecks': 30,
                         'tutorialSlotsPreserved': 6, 'originalDatabaseConversationAndActorsMatch': True,
                         'completeNamedMethodBodiesCaptured': len(method_evidence),
                         'fieldReaders': 1, 'pennyEntryPointMethodReferenceOperands': 0,
                         'fullSourceInventoryPagesUnchanged': 25, 'fullOccurrenceInventoryUnchanged': 150,
                         'frozenDialogueHashMatches': True, 'allPinnedInputsUnchanged': True,
                         'semanticBoundary': 'Structural/source trace verification only; unresolved activation and actor join remain unresolved.'})
write('Result.json', {'status': 'finite-penny-tutorial-source-join-check-complete',
                     'scopeDisposition': 'Named field/factory/listener scope resolved statically; activation and physical speaker join precisely bounded.',
                     'pages': 5, 'occurrences': 30, 'slots': 6, 'fieldReaderCount': 1,
                     'activationCaller': 'bounded-unresolved', 'physicalSpeakerJoin': 'bounded-unresolved',
                     'sourceAccepted': False, 'targetApplied': False, 'targetEditorialAccepted': False,
                     'ordinaryTranslationEntryAllowed': False, 'global23CaseGate': False,
                     'runtime': 'not-run', 'wholeGameAccepted': False, 'immutableInputsUnchanged': True,
                     'model': {'name': 'gpt-6.1-sol', 'reasoning': 'high', 'provider': 'openai', 'inheritedHistory': False},
                     'nestedJobs': False, 'usage': 'Parent measures actual session usage; no nested jobs launched.',
                     'stop': 'Finite assignment ends here. No automatic next phase, Git/index/root README/CHECKPOINT mutation, runtime or publication.'})
(CHECK / 'report.md').write_text(
    '# Old Penny tutorial source join\n\n'
    'The finite static check is complete for five pages, 30 exact text occurrences and all six slots. '
    'The source join remains partially unresolved; no admission or target application was made.\n\n'
    'Original `sharedassets2.assets:18057` (`ItemGetNotification`, GO4561) points through '
    '`pennyCloacaFistingStoryPrefab` to old `PagedTutorial:15852`, GO3684. The field has exactly one '
    'reader: `ShowPennyCloacaFistingStory`, which calls `ShowPagedTutorial`. That factory conditionally '
    'instantiates the exact prefab under `messageContainer`, delays navigation by 2.5 seconds, reparents '
    'nav, and installs actual submit/completion listeners. Completion hides the notification and schedules '
    'nav restoration and destruction after 2 seconds. Full bodies, hashes and line spans are recorded. '
    'The saved persistent callbacks remain empty; factory listeners are a separate conditional contract.\n\n'
    'The pinned original game assembly contains zero method-reference operands to the public Penny '
    'entry point and zero exact method-name literals. Its service registration and inventory listener do '
    'not establish an activation route. This assembly-bound negative does not prove external absence or '
    'unreachability. Native Unity instantiation/events and timer execution were not exercised.\n\n'
    'Conversation 273 reproduces all five phrases in order 2→3→138→139→135 with actor 8=`bird`, '
    'conversant 1=`player`. The original database confirms the entries and actor metadata. The generic '
    'tutorial factory carries no actor/conversation parameter or dialogue call; the tutorial narrator, '
    'addressee and physical conversation join therefore remain unproved. First-person recollection, '
    'female partner references and the source word “lady” are preserved without inferring identity from '
    'names or art. The homonymous bundle movie is excluded.\n\n'
    'All30 source token spans and nontext controls passed exact readback. The accepted conservative '
    '25-page/150-occurrence inventory, protected controls and frozen dialogue hash remain unchanged. '
    'The sixth slot remains a nontext slot in the assigned narrative inventory; its native transform '
    'child is retained without inventing a new text binding. Existing reuse finding R02 is narrowed by '
    'the proven factory/listeners; R07 and the speaker/activation gaps remain open.\n\n'
    'Parent action: retain potential-resource status until a concrete version-bound activation/actor '
    'route or an explicit source/context adjudication resolves those two predicates. No unchanged scan '
    'should be repeated. Runtime, source/editorial, fonts, package, target application and global 23-case '
    'acceptance remain separate. No Git/index, root README/CHECKPOINT, game, screenshot, server or '
    'publication action occurred. Parent owns measured usage. Stop after this deliverable.\n')
outputs = [p for p in CHECK.rglob('*') if p.is_file() and p.name not in
           ['events.jsonl', 'stderr.log', 'last-message.txt', 'output-manifest.json']]
write('output-manifest.json', {'files': [{'path': str(p.relative_to(CHECK)), 'sha256': sha(p.read_bytes())}
                                      for p in sorted(outputs)]})
print(json.dumps({'status': 'complete', 'pages': 5, 'occurrences': 30, 'methods': len(method_evidence),
                  'preservedInputs': len(pins), 'speakerJoin': 'bounded-unresolved'}))
