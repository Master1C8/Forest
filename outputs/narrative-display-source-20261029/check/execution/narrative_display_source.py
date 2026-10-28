#!/usr/bin/env python3
"""Finite, append-only narrative source handoff. Never modifies a game or target.

Run the frozen execution copy with --build once, then --check. Checks reuse
fingerprinted original metadata and the six-object native readback, not runtime.
"""
import argparse
import collections
import copy
import hashlib
import json
from pathlib import Path
import re

ROOT_DEFAULT = '/Users/antonkrutov/Desktop/Forest'
CHECK = 'outputs/narrative-display-source-20261029/check/'
OUT = 'localization/source/narrative-displays-20261029/'
ADMIT = 'localization/source/shared-source-completion-20261028/admission-v1/'
INDEX = 'outputs/pause-inventory-bio-completion-20261028/managed-index/'
ASSEMBLY = '46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
FAMILIES = ['MouseOrgyMovie', 'BotbMabelSummary', 'MaverickRascalShopStory',
            'RascalSoloBearStory', 'PennyScarlettCloacaFistingStory']
COUNTS = [13, 3, 3, 1, 5]
ROLE_SUFFIXES = ['', '/NameGlowLeft', '/NameGlowLeft/Name',
                 '/NameGlowLeft/NameGlowTop', '/NameGlowLeft/NameGlowRight',
                 '/NameGlowLeft/NameGlowBottom']


def sha(b):
    return hashlib.sha256(b).hexdigest()


def canonical(v):
    return json.dumps(v, ensure_ascii=False, separators=(',', ':')).encode()


def encode(name, value):
    if name.endswith('.jsonl'):
        return b''.join(canonical(r) + b'\n' for r in value)
    return (json.dumps(value, ensure_ascii=False, indent=2) + '\n').encode()


def require(ok, reason):
    if not ok:
        raise ValueError(reason)


def unique(rows):
    require(len(rows) == len({r['id'] for r in rows}), 'duplicate-identity')
    return {r['id']: r for r in rows}


def parse_methods(text):
    return {m.group(1): m.group(2).strip() + '\n' for m in re.finditer(
        r'^METHOD (.*?) \|[^\n]*\n(.*?)(?=^METHOD |^TYPE |\Z)', text, re.M | re.S)}


def derive(root):
    pins = {}

    def read(path):
        b = (root / path).read_bytes()
        pins[path] = {'sha256': sha(b), 'bytes': len(b)}
        return b

    def js(path):
        return json.loads(read(path))

    def rows(path):
        return [json.loads(s) for s in read(path).decode().splitlines()]

    runtime = js(CHECK + 'runtime-check.json')
    require(runtime['passed'] and all(runtime['checks'].values()), 'runtime-verification')
    require((runtime['actualModel'], runtime['actualEffort'], runtime['provider']) ==
            ('gpt-6.1-sol', 'high', 'openai'), 'runtime-model')
    for name, key in [('dispatch.json', 'dispatchSha256'),
                      ('runtime-verification.json', 'runtimeVerificationSha256')]:
        require(sha(read(CHECK + name)) == runtime[key], 'runtime-evidence-changed')
    read(CHECK + 'brief.md')
    execution = js(CHECK + 'execution-pins.json')
    for path, expected in execution.items():
        require(sha(read(path)) == expected, 'execution-dependency-changed:' + path)
    require(sha(read(CHECK + 'execution/Assembly-CSharp.dll')) == ASSEMBLY, 'assembly-version')
    code = read('tools/narrative_display_source.py')
    require(code == read(CHECK + 'execution/narrative_display_source.py'), 'unfrozen-recipe')
    manifest = js(CHECK + 'input-manifest.json')
    frozen = manifest['preservedFrozenDialogueSha256']
    # Hash bytes only: this technical lane does not open localized wording.
    require(sha(read('localization/ru-assets/dialogue.ru.jsonl')) == frozen, 'frozen-dialogue-changed')
    assigned = rows(CHECK + 'assigned150.jsonl')
    assigned_by_id = unique(assigned)
    require(len(assigned) == 150 and len({r['source'] for r in assigned}) == 25, 'assignment-scope')
    original = read(str(Path(manifest['originalLedger']).relative_to(root)))
    require(sha(original) == manifest['originalLedgerSha256'], 'original-ledger-changed')
    original_by_id = unique([json.loads(s) for s in original.decode().splitlines()])
    for r in assigned:
        require(r == original_by_id[r['id']], 'original-assignment-diverged')
    admitted = js(ADMIT + 'manifest.json')
    locales = admitted['targetLocales']
    require(len(locales) == 30 and len(set(locales)) == 30, 'locale-denominator')
    objects = unique(js('assets/source-v2/objects.json'))
    contexts_all = rows(ADMIT + 'direct-context.jsonl')
    contexts = {r['id']: r for r in contexts_all if r['id'] in assigned_by_id}
    require(len(contexts) == 150, 'context-coverage')
    transforms = {r['object']: r for r in rows(ADMIT + 'context-transforms.jsonl')}
    native = js(CHECK + 'native-pointer-readback.json')
    source_files = js('assets/source-v2/source-files.json')
    require(native['sourceFileSha256'] == source_files['sharedassets2.assets']['sha256'], 'native-file-version')
    supplements = {r['object']: r for r in native['objects']}
    tree_cache = {}
    evidence_objects = {}

    def tree(oid):
        if oid in tree_cache:
            return tree_cache[oid]
        o = objects[oid]
        if 'tree' in o:
            path = 'assets/source-v2/' + o['tree']
            b = read(path)
            require(sha(b) == o['treeSha256'], 'tree-hash:' + oid)
            t = json.loads(b)
            loc = {'path': path, 'sha256': sha(b)}
        else:
            saved = supplements.get(oid, transforms.get(oid))
            require(saved is not None, 'missing-named-object:' + oid)
            require(saved['rawSha256'] == o['rawSha256'], 'raw-object-hash:' + oid)
            t = saved['tree']
            loc = {'path': CHECK + ('native-pointer-readback.json' if oid in supplements else '')}
            if oid not in supplements:
                loc['path'] = ADMIT + 'context-transforms.jsonl'
            loc['selector'] = oid
        tree_cache[oid] = t
        evidence_objects[oid] = {'object': oid, 'type': o.get('class', o['type']),
                                 'rawSha256': o['rawSha256'], 'evidence': loc, 'tree': t}
        return t

    def ptr(oid, p):
        if not p['m_PathID']:
            return None
        asset = oid.rsplit(':', 1)[0]
        if p['m_FileID']:
            require(asset == 'sharedassets2.assets', 'unresolved-external-file:' + oid)
            asset = next(r['path'] for r in native['externals'] if r['fileId'] == p['m_FileID'])
        return asset + ':' + str(p['m_PathID'])

    def components(go):
        return [ptr(go, c['component']) for c in tree(go)['m_Component']]

    def transform(go):
        return next(oid for oid in components(go) if objects[oid]['type'] in ('Transform', 'RectTransform'))

    def go(oid):
        return oid if objects[oid]['type'] == 'GameObject' else ptr(oid, tree(oid)['m_GameObject'])

    def full_path(oid):
        g = go(oid)
        tr = transform(g)
        father = ptr(tr, tree(tr)['m_Father'])
        return (full_path(father) + '/' if father else '') + tree(g)['m_Name']

    def ui_binding(oid):
        if oid is None:
            return None
        ui = tree(oid)
        panels = []
        for pointer in ui['conversationUIElements']['subtitlePanels']:
            panel = ptr(oid, pointer)
            pt = tree(panel)
            text = ptr(panel, pt['subtitleText']['m_textMeshProUGUI'])
            panels.append({'panel': panel, 'subtitleText': text,
                           'isAssignedNarrativeField': text is not None and text + '/m_text' in assigned_by_id,
                           'savedText': tree(text)['m_text'] if text else None,
                           'clearTextOnClose': pt['clearTextOnClose'],
                           'clearTextOnConversationStart': pt['clearTextOnConversationStart']})
        return {'dialogueUi': oid, 'subtitlePanels': panels,
                'boundary': 'Serialized UI receiver identity only; plugin/native mutation and final render not executed.'}

    methods = {}
    method_receipts = []
    for path in sorted((root / (CHECK + 'il')).glob('*.il')):
        rel = str(path.relative_to(root))
        for signature, body in parse_methods(read(rel).decode()).items():
            if signature in methods:
                require(methods[signature] == body, 'conflicting-method-body')
            methods[signature] = body
            method_receipts.append({'id': signature, 'path': rel, 'fileSha256': pins[rel]['sha256'],
                                    'bodySha256': sha(body.encode()), 'instructions': body})
    acquisition = js(CHECK + 'method-acquisition.json')
    for a in acquisition:
        for r in a['reused']:
            require(sha(read(r['path'])) == r['sha256'], 'cached-evidence-changed')
    for name in ['movie-dialogue.il', 'story-dialogue.il']:
        rel = ADMIT + 'phase137/' + name
        for sig, body in parse_methods(read(rel).decode()).items():
            methods.setdefault(sig, body)
            method_receipts.append({'id': sig, 'path': rel, 'fileSha256': pins[rel]['sha256'],
                                    'bodySha256': sha(body.encode()), 'instructions': body})

    def method(typ, name):
        return next(sig for sig in methods if ('TheForestOfLove.' + typ + '::' + name + '(') in sig)

    def ev(typ, name, offsets=None):
        sig = method(typ, name)
        if offsets:
            require(all('IL_' + s + ':' in methods[sig] for s in offsets), 'missing-il-location')
        return {'method': sig, 'offsets': offsets or [], 'bodySha256': sha(methods[sig].encode())}

    registry = js(ADMIT + 'special-cases.json')
    overlaps = collections.defaultdict(list)
    for case in registry['cases']:
        for binding in case.get('sourceBindings', []):
            if binding['id'] in assigned_by_id:
                require(binding['sourceValueSha256'] == sha(canonical(assigned_by_id[binding['id']]['source'])),
                        'case-source-value')
                overlaps[binding['id']].append(case['id'])
    require(all(overlaps[r['id']] == ['narration-and-speaker-context'] for r in assigned), 'case-coverage')
    producer = js(CHECK + 'producer-dialogue-context.json')
    db = read(producer['databaseTree'])
    require(sha(db) == producer['databaseTreeSha256'], 'producer-database-changed')
    db_tree = json.loads(db)
    require(producer['actors'] == db_tree['actors'], 'producer-actors')
    for c in producer['conversations']:
        dc = next(x for x in db_tree['conversations'] if x['id'] == c['conversationId'])
        require(c['fields'] == dc['fields'], 'producer-fields')
        require([r['entry'] for r in c['entries']] == dc['dialogueEntries'], 'producer-entry-coverage')
        for e in c['entries']:
            ci, ei = map(int, re.fullmatch(r'/conversations/(\d+)/dialogueEntries/(\d+)', e['sourcePath']).groups())
            require(db_tree['conversations'][ci]['dialogueEntries'][ei] == e['entry'], 'producer-span')
    candidates = collections.defaultdict(list)
    for c in producer['conversations']:
        for e in c['entries']:
            fields = {f['title']: f['value'] for f in e['entry']['fields']}
            candidates[fields.get('Dialogue Text')].append({
                'id': f"ds:{c['conversationId']}:{e['entry']['id']}:Dialogue Text",
                'databasePath': producer['databaseTree'], 'entryPath': e['sourcePath'],
                'actor': fields.get('Actor'), 'conversant': fields.get('Conversant'),
                'entry': e['entry'], 'acceptance': 'source-reuse-candidate-only;not-a-target-or-physical-binding'})

    family_groups = collections.defaultdict(dict)
    for r in assigned:
        require(r['family'] == 'native-narrative-page', 'unsupported-family')
        ctx = contexts[r['id']]
        require(ctx['hierarchy'] == r['consumer'] and ctx['value'] == r['source'], 'context-identity')
        page_path = r['consumer'].split('/NameContainer', 1)[0]
        family = page_path.split('/')[0]
        require(family in FAMILIES, 'unsupported-family')
        page_name = page_path.rsplit('/', 1)[1]
        page_ancestor = next(a for a in ctx['ancestors'] if a['name'] == page_name)
        family_groups[family].setdefault(page_path, {'go': page_ancestor['object'], 'rows': []})['rows'].append(r)

    pages, occurrences, controls, contracts, resources = [], [], [], [], {}

    def resource(oid):
        if oid is None:
            return None
        o = objects[oid]
        fact = {'id': oid, 'type': o.get('class', o['type']), 'rawSha256': o['rawSha256']}
        if 'tree' in o:
            t = tree(oid)
            fact.update({k: t[k] for k in ['m_Name', 'm_SourceFontFile', 'm_AtlasTextures',
                        'm_FallbackFontAssetTable', 'm_AtlasPopulationMode', 'm_Material'] if k in t})
        resources[oid] = fact
        return oid

    for family, count in zip(FAMILIES, COUNTS):
        groups = family_groups[family]
        require(len(groups) == count, 'family-page-count')
        sample = next(iter(groups.values()))['rows'][0]
        root_go = contexts[sample['id']]['ancestors'][-1]['object']
        klass = 'TheForestOfLove.' + ('PagedTutorial' if family == FAMILIES[4] else family)
        owner = next(o for o in components(root_go) if objects[o].get('class') == klass)
        owner_tree = tree(owner)
        general = ptr(owner, owner_tree['storyController']) if 'storyController' in owner_tree else None
        general_tree = tree(general) if general else None
        slots = []
        for key, val in owner_tree.items():
            if key.startswith('Frame') or key == 'pages':
                for index, pointer in enumerate(val if isinstance(val, list) else [val]):
                    target = ptr(owner, pointer)
                    slot = {'field': '/' + key + ('/' + str(index) if isinstance(val, list) else ''),
                            'pointer': pointer, 'object': target, 'type': objects[target]['type']}
                    if objects[target]['type'] in ('Transform', 'RectTransform', 'CanvasGroup'):
                        if target in transforms or target in supplements or 'tree' in objects[target]:
                            slot.update(gameObject=go(target), hierarchy=full_path(target))
                    slots.append(slot)
        contract = {'id': family, 'ownerObject': owner, 'ownerClass': klass,
                    'rootGameObject': root_go, 'storyController': general,
                    'serializedOwnerControls': owner_tree,
                    'serializedGeneralControls': general_tree, 'slots': slots,
                    'sourcePageIds': [], 'runtime': 'not-run', 'sourceAccepted': False}
        if general:
            contract['dialogueUiBinding'] = ui_binding(ptr(general, general_tree['dialogueUi']))
            contract['selectionMechanism'] = 'SetStoryContent rehomes prior artwork children to hiddenContent, then selected Transform to artworkPlaceholder; it does not activate disabled descendant NameContainer.'
            contract['commonCallbacks'] = [ev('GeneralStoryUIController', n) for n in
                ['OnSceneStarted', 'AdvanceMovie', 'OnDialogueFinished', 'SetStoryContent',
                 'TriggerAdvanceMoment', 'JumpToStateId', 'EndMovie']]
            contract['navigation'] = 'Advance callbacks increment CurrentStateId. JumpToStateId clamps requested1..StateCount+1, subtracts1 and invokes selection. No previous-button contract in these owner bodies.'
            contract['finish'] = 'General EndMovie hides Next, calls MovieWrapper.PlayOutro, sets fadeOutSeconds and invokes onMovieEnding. Wrapper/native execution is untested.'
        else:
            contract['selectionMechanism'] = 'PagedTutorial.pages index; sets all page GameObjects active, selected CanvasGroup alpha1 and other alpha0, nav Animator selected bool.'
            contract['navigation'] = 'Awake currentPage0 and allowNavigation=true (overrides saved false). Right bumper/submit increments modulo6; left bumper wraps0->5. Submit at index5 invokes FinishTutorial then onSubmit.'
            contract['finish'] = 'FinishTutorial sets finishedTutorial and invokes onTutorialFinished; both saved UnityEvents have zero persistent calls. Instance listeners/reachability remain unverified.'
            contract['commonCallbacks'] = [ev('PagedTutorial', n) for n in ['Awake','Update','GetNextPage','GetPreviousPage','UpdatePageVisibility','FinishTutorial']]
            contract['excludedHomonym'] = 'Bundle TheForestOfLove.PennyScarlettCloacaFistingStory movie controller is a different physical family; no control/actor/runtime binding inherited.'

        ordered = []
        for page_path, group in groups.items():
            pg = group['go']
            selected = next(s for s in slots if s.get('gameObject') == pg)
            field = selected['field']
            if family == FAMILIES[0]:
                order = int(field.split('/')[-1]); state = order
                no_dialogue = None
                callback = '<OnAdvanceMoment_Dialogue>b__185_' + ('0' if state < 11 else '2' if state == 12 else '3')
                selection = ev(family, callback, ['000d','0020','0043','0048','004d','006f'])
                producer_binding = {'conversation':'Movies_MouseOrgyMovie_Dialogue','actor':'Narrator',
                                    'arc':f'p{state+1:02d}', 'dialogueUi':ptr(owner,owner_tree['dialogueUis'][state]),
                                    'initialContainerActive':False,'staticNativeWording':'retained-inactive-descendants;selected-dialogue-subtitle-is-separate'}
                producer_binding['uiBinding'] = ui_binding(producer_binding['dialogueUi'])
                require(all(not p['isAssignedNarrativeField'] for p in producer_binding['uiBinding']['subtitlePanels']),
                        'mouse-subtitle-versus-native-identity')
            elif family == FAMILIES[1]:
                order = ['FrameOne','FrameTwo','FrameThree'].index(field[1:]);state=order;no_dialogue=order
                selection=ev(family,'OnAdvanceMoment',['000d', ['0025','0043','0061'][order]])
                producer_binding={'conversation':None,'actor':None,'pointOfView':'second-person summary addressed to player; Mabel is object of report',
                                  'staticNativeWording':'selected-page-static-text'}
            elif family == FAMILIES[2]:
                order = {'/Frame01':0,'/Frame06':1,'/Frame13':2}[field]
                state=[0,6,14][order];no_dialogue=[0,6,None][order]
                selection=ev(family,'OnAdvanceMovement_Dialogue' if order==0 else
                             '<OnAdvanceMovement_Dialogue>b__24_'+('2' if order==1 else '8'))
                producer_binding={'conversation':'Movies_MaverickRascalShopStory_Dialogue','selectedActor':'Maverick',
                                  'pointOfView':'third-person page narration; selected dialogue actor is not automatically the page narrator',
                                  'staticNativeWording':'selected-page-static-text',
                                  'contextArcs':['maverick_rascal_shop_story_part'+str(i) for i in range(1,9)]}
            elif family == FAMILIES[3]:
                order=0;state=6;no_dialogue=None
                selection=ev(family,'<OnAdvanceMovement_Dialogue>b__15_0',['0007','000d'])
                producer_binding={'conversation':'Movies_RascalSoloBearStory_Dialogue','selectedActor':'Rascal','arc':None,
                                  'pointOfView':'third-person ending about Rascal and another participant; do not name anonymous bear from title alone',
                                  'titleCallback':'show ending screen','delaySeconds':0.25,
                                  'staticNativeWording':'FrameSix selected after fade-to-black and1-second timer; absent from five-sprite no-dialogue branch'}
            else:
                order=int(field.split('/')[-1]);state=order;no_dialogue=None
                selection=ev('PagedTutorial','UpdatePageVisibility',['0005','0020','0034'])
                producer_binding={'conversation':None,'actor':None,'pointOfView':'first-person speaker recounts experience; separate conversation273 actor8=bird is supporting provenance, not physical binding',
                                  'staticNativeWording':'PagedTutorial CanvasGroup-selected static text; no StartDialogue call in this owner'}
            pid='narrative-page:'+pg
            rs=group['rows'];require(len(rs)==6 and len({r['source'] for r in rs})==1,'six-occurrence-page')
            suffix={r['consumer'][len(page_path+'/NameContainer'):]:r for r in rs}
            require(set(suffix)==set(ROLE_SUFFIXES),'physical-layer-coverage')
            primary=suffix[''];source=primary['source']
            anomaly=[]
            if family==FAMILIES[1] and order==0:
                anomaly.append('Page1 already includes Page2 and Page3 sentences; preserve complete Page1 and both repeated later pages.')
            if family==FAMILIES[0] and state==4:
                anomaly.append('Source grammar "One mouse ... thighs trail off" and singular/plural they remain exact; no source repair.')
            if family==FAMILIES[3]:anomaly.append('Source says "separating ways"; retain original source anomaly.')
            record={'id':pid,'family':family,'pageGameObject':pg,'hierarchy':page_path,
                    'pageOrderWithinAssignedFamily':order,'controllerStateBeforeSelection':state,
                    'noDialogueStateBeforeSelection':no_dialogue,'ownerObject':owner,
                    'memberBinding':selected,'selectionEvidence':selection,'source':source,
                    'sourceUtf8Sha256':sha(source.encode()),'sourceValueSha256':sha(canonical(source)),
                    'primaryOccurrenceId':primary['id'],'occurrenceIds':[suffix[s]['id'] for s in ROLE_SUFFIXES],
                    'producerContext':producer_binding,'dialogueReuseCandidates':candidates[source],
                    'sourceAnomalies':anomaly,'case':'narration-and-speaker-context',
                    'translationEntryAllowed':False,'sourceAcceptedByWorker':False}
            ordered.append((order,record))
            for s in ROLE_SUFFIXES:
                r=suffix[s];oid=r['id'].rsplit('/',1)[0];t=tree(oid)
                require(t['m_text']==r['source'],'source-value')
                require(sha(r['source'].encode())==r['sourceValueSha256'],'assigned-value-hash')
                require(full_path(oid)==r['consumer'],'physical-hierarchy')
                path='assets/source-v2/'+r['sourceTree'];b=read(path)
                require(sha(b)==r['sourceTreeSha256'],'assigned-tree-hash')
                match=re.search(rb'"m_text"\s*:\s*("(?:[^"\\]|\\.)*")',b)
                require(match and json.loads(match.group(1))==r['source'],'source-span')
                role='invisible-layout-provider' if not s else ('visible-face' if s.endswith('/Name') else 'visible-glow')
                require(t['m_fontColor']['a']==(0 if not s else 1),'authored-alpha')
                font=resource(ptr(oid,t['m_fontAsset']));mat=resource(ptr(oid,t['m_sharedMaterial']))
                sprite=resource(ptr(oid,t['m_spriteAsset']))
                fonttree=tree(font)
                for atlas in fonttree['m_AtlasTextures']:resource(ptr(font,atlas))
                occ={'id':r['id'],'pageId':pid,'original':r,'role':role,
                     'fontAsset':font,'material':mat,'spriteAsset':sprite,
                     'fontColor':t['m_fontColor'],'fontSize':t['m_fontSize'],
                     'sourceSpan':{'path':path,'pointer':'/m_text','jsonTokenByteStart':match.start(1),
                                   'jsonTokenByteEndExclusive':match.end(1),'sha256':sha(b)},
                     'storedContext':contexts[r['id']], 'runtime':'not-run'}
                occurrences.append(occ)
                controls.append({'id':r['id'],'controls':{k:v for k,v in t.items() if k!='m_text'},
                                 'rule':'preserve-exactly; all serialized fields except localized m_text; no application authorized'})
        ordered.sort(key=lambda x:x[0])
        for _,record in ordered:
            contract['sourcePageIds'].append(record['id']);pages.append(record)
        contracts.append(contract)

    # Preserve resource names/IDs independently of narrative roles.
    for oid in ['sharedassets0.assets:3324','sharedassets0.assets:3','sharedassets0.assets:245']:
        resource(oid)
    read('localization/fonts/README.md')
    literals=[]
    for r in rows(INDEX+'literals.jsonl'):
        if r['method'] not in methods:
            continue
        role='preserve-exactly-runtime-control'
        if r['value'].startswith('mouse ceremony movie got stuck'):
            role='diagnostic-wording-context-only'
        literals.append(dict(r,id=f"il:Assembly-CSharp.dll/{r['method']}/IL_{r['offset']:04x}",
                             role=role,assemblySha256=ASSEMBLY))
    # Complete scoped callback identities also include method operands and nontext fields.
    protected={'serialized':controls,'controllers':contracts,'runtimeLiterals':literals}
    source_case={'id':'narration-and-speaker-context','existingRegistryPath':ADMIT+'special-cases.json',
        'exactOccurrenceIds':[r['id'] for r in occurrences],
        'sourceAnalysis':'finite-physical-page-and-controller-contracts-prepared;parent-admission-pending',
        'invariant':'Translate complete paragraphs in actual selection order and bind all six physical fields. Preserve repeated pages, rich text, line breaks and source anomalies; anonymous mice/bear keep source identity limits.',
        'overlapDecisions':[
            {'case':'runtime-template-versus-producer','registeredOverlapOccurrences':0,
             'decision':'No automatic registry extension. Mouse selected dialogue subtitle is separate from inactive static NameContainer. Keep producer dialogue matches as candidates until parent accepts exact joins.'},
            {'case':'markup-and-ornamental-initials','registeredOverlapOccurrences':0,
             'decision':'No split initial or markup tags in these25 assigned values. Preserve rich-text flags and all controls; this is not absence of markup elsewhere.'}],
        'positive':'All150 original physical bindings,25 complete page values, order, callbacks and resources remain exact.',
        'negative':'An omitted/reordered page, changed source/control, unsupported family or swapped homonymous Penny movie owner rejects.',
        'editorial':'not-run','adapter':'not-run','runtimeVisual':'not-run','localeDecisions':{},
        'all30':'One identical append-only increment for all30 supported target locales. No target admission or existing input mutation.'}
    gaps=[
        ('mouse-inactive-native-descendants',78,'needs-review','13 NameContainers are saved inactive; separate runtime subtitle fields do not bind these native occurrences.',
         'Parent source gate decides whether to admit retained inactive native layers and separately accepts exact dialogue producer joins; no absence claim.'),
        ('penny-tutorial-reachability',30,'needs-review','PagedTutorial owner and six-slot order are resolved; actual instantiation and dynamic listeners for this old physical resource are unverified.',
         'Parent source gate supplies an existing exact instantiation binding or records dormant/potential disposition; do not substitute the homonymous movie controller.'),
        ('page-runtime-visibility',150,'not-run','Static selection and serialized alpha/active state are known; no actual rendering, transition completion or input execution was run.',
         'Use these exact selectors only in separately owner-authorized runtime checks; preserve active parent game and helpers.'),
        ('parent-source-admission',150,'needs-review','All assigned selectors and25 page units accounted; append-only source preparation is not admission.',
         'Parent reviews this finite handoff and accepts or rejects this same increment for all30 without changing frozen inputs in this lane.'),
        ('target-wording-and-reuse',150,'not-run','Exact original dialogue matches are provenance candidates; no target text has been read, authored or accepted.',
         'Parent establishes accepted physical/semantic joins and locale glossary/editorial dependencies before any separately authorized target application.'),
        ('fonts-and-resources',150,'needs-review','All150 source pointers and25 alpha0 providers resolved to MatchupPro SDF roles; original atlas bindings and fictional mapping preserved.',
         'After source/wording admission, owning font lane binds final corpus requirements to these roles; no substitute font or texture work here.'),
        ('package-release-whole-game',150,'not-run','No packaged artifact, installation or whole-game inventory/release check executed.',
         'Owning parent retains existing package/runtime/release gates; this finite handoff grants no further action.')]
    checklist=[]
    for gid,count,status,evidence,action in gaps:
        checklist.append({'id':gid,'artifact':OUT+('source.jsonl' if gid!='fonts-and-resources' else 'font-resource-roles.json'),
                          'predicate':gid,'status':status,'affectedOccurrences':count,'currentEvidence':evidence,
                          'uncertainty':evidence,'exactNextPermittedAction':action})
    for gid,artifact,predicate in [
        ('physical-coverage','occurrence-map.jsonl','All150 exact original IDs/values/tree spans and six layers per25 pages'),
        ('controller-coverage','controllers.json','Five physical owners and actual member/array order; animation/sixth tutorial slots retained'),
        ('protected-controls','protected-controls.json','Every selected nontext field, owner/selection/resource identity remains source-exact')]:
        checklist.insert(0,{'id':gid,'artifact':OUT+artifact,'predicate':predicate,'status':'passed',
                            'currentEvidence':'Deterministic full finite comparison and matching positive/negative controls; source/context trace evidence linked.',
                            'uncertainty':'Does not establish runtime or target semantic acceptance.',
                            'exactNextPermittedAction':'Parent reviews the pinned handoff; no automatic continuation.'})
    font_roles={'occurrences':150,'layoutProviders':25,'faceOccurrences':25,'glowOccurrences':100,
                'resources':list(resources.values()),'fictionalMapping':{'font':'sharedassets0.assets:3324','material':'sharedassets0.assets:3','atlas':'sharedassets0.assets:245','policy':'preserve-exactly;not-an-ordinary-narrative-font'},
                'roles':'Each occurrence-map row retains exact source font, material, sprite, size, color and active ancestry. Alpha0 is intentional layout provider evidence, not a translation defect.',
                'coverage':'No target corpus/font cmap, shaping, bidi, texture, native loading or runtime acceptance claimed.'}
    # Include material->atlas pointers, not just font->atlas names.
    for oid,fact in list(resources.items()):
        if objects[oid]['type']=='Material':
            fact['savedProperties']=tree(oid)['m_SavedProperties']
    products={'source.jsonl':pages,'occurrence-map.jsonl':occurrences,'controllers.json':contracts,
              'protected-controls.json':protected,'source-case.json':source_case,
              'font-resource-roles.json':font_roles,'acceptance-checklist.json':checklist,
              'method-evidence.jsonl':method_receipts,'object-evidence.jsonl':list(evidence_objects.values()),
              'producer-context.json':producer}
    validate(products,assigned,products)
    products['validation.json']=negative_controls(products,assigned)
    encoded={name:encode(name,val) for name,val in products.items()}
    product_hashes={n:{'sha256':sha(b),'bytes':len(b)} for n,b in encoded.items()}
    result={'status':'finite-narrative-source-handoff-complete','assignedOccurrences':150,
            'accountedOccurrences':150,'primaryPageUnits':25,'physicalControllerContracts':5,
            'resolvedCounts':{'identityValuesSpans':150,'pageMembership':150,'pageOrder':25,'physicalOwners':5,
                              'fontPointerRoles':150,'invisibleProviders':25},
            'gapCounts':{'unaccountedAssignedSelectors':0,'unboundPageOwners':0,'acceptanceChecklistGaps':len(gaps),
                         'inactiveMouseOccurrences':78,'pennyReachabilityUnverifiedOccurrences':30},
            'sourceAcceptedByWorker':False,'targetEditorialAccepted':False,'runtime':'not-run',
            'wholeGameAccepted':False,'translationEntryAllowed':False,'preservedFrozenDialogueSha256':frozen,
            'model':{'model':'gpt-6.1-sol','reasoning':'high','provider':'openai','inheritedHistory':False,'nestedJobs':0},
            'locales':locales,'codeSha256':sha(code),'assemblySha256':ASSEMBLY,
            'products':product_hashes,'inputs':pins,
            'stop':'Finite assignment ended. No new phase, target edits, root status files, Git or runtime operations.'}
    encoded['Result.json']=encode('Result.json',result)
    return encoded,result


def validate(candidate, assigned, expected):
    pages=candidate['source.jsonl'];occ=candidate['occurrence-map.jsonl']
    require(all(p['family'] in FAMILIES for p in pages),'unsupported-family')
    ep=expected['source.jsonl'];eo=expected['occurrence-map.jsonl']
    require({p['id'] for p in pages}=={p['id'] for p in ep} and len(pages)==25,'missing-page-identity')
    require([p['id'] for p in pages]==[p['id'] for p in ep],'reordered-page-identity')
    require(len(occ)==150 and set(unique(occ))==set(unique(assigned)),'occurrence-identity')
    for p,e in zip(pages,ep):
        require(p['source']==e['source'],'altered-source')
        require(p['memberBinding']==e['memberBinding'] and p['ownerObject']==e['ownerObject'] and
                p['controllerStateBeforeSelection']==e['controllerStateBeforeSelection'],'altered-page-control')
        require(p['occurrenceIds']==e['occurrenceIds'],'altered-physical-layers')
    by=unique(eo)
    for o in occ:
        require(o['original']==by[o['id']]['original'],'altered-occurrence-source')
        require(o['sourceSpan']==by[o['id']]['sourceSpan'],'altered-source-span')
    require(candidate['protected-controls.json']==expected['protected-controls.json'],'altered-protected-controls')
    require(candidate['controllers.json']==expected['controllers.json'],'altered-controller-contract')
    return True


def negative_controls(products, assigned):
    tests=[]
    def test(name,reason,mutate):
        candidate=copy.deepcopy(products);mutate(candidate)
        try:validate(candidate,assigned,products)
        except ValueError as e:
            require(str(e)==reason,'wrong-negative-boundary:'+name+':'+str(e))
            tests.append({'id':name,'expectedReason':reason,'observedReason':str(e),'passed':True})
        else:raise ValueError('negative-did-not-reject:'+name)
    require(validate(copy.deepcopy(products),assigned,products),'positive-control')
    test('missing-page','missing-page-identity',lambda x:x['source.jsonl'].pop())
    def reorder(x):x['source.jsonl'][0],x['source.jsonl'][1]=x['source.jsonl'][1],x['source.jsonl'][0]
    test('reordered-page','reordered-page-identity',reorder)
    test('altered-source','altered-source',lambda x:x['source.jsonl'][0].update(source='changed'))
    test('changed-source-span','altered-source-span',lambda x:x['occurrence-map.jsonl'][0]['sourceSpan'].update(jsonTokenByteStart=0))
    test('unsupported-family','unsupported-family',lambda x:x['source.jsonl'][0].update(family='OtherStory'))
    test('changed-protected-alpha','altered-protected-controls',lambda x:x['protected-controls.json']['serialized'][0]['controls']['m_fontColor'].update(a=0.5))
    test('swapped-homonymous-owner','altered-page-control',lambda x:x['source.jsonl'][-1].update(ownerObject='unrelated-movie-controller'))
    test('changed-slot-state','altered-page-control',lambda x:x['source.jsonl'][0].update(controllerStateBeforeSelection=999))
    return {'positiveControl':'passed','negativeControls':tests,'boundary':'Complete source handoff integrity against verified physical metadata; no renderer/target semantic execution or mocks.'}


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root',type=Path,default=Path(ROOT_DEFAULT))
    mode=parser.add_mutually_exclusive_group(required=True)
    mode.add_argument('--build',action='store_true');mode.add_argument('--check',action='store_true')
    args=parser.parse_args();root=args.root.resolve();encoded,result=derive(root);out=root/OUT
    readme=('Finite narrative source handoff for The Forest of Love0.45\n\n'
        'All150 original selectors retained as25 semantic page units under five physical owners. '
        'This is append-only source preparation for all30 locales; parent admission is pending.\n\n'
        'Reproduce: python3 -B outputs/narrative-display-source-20261029/check/execution/narrative_display_source.py --check\n'
        'Initial creation uses --build and refuses an existing directory. Checks do not write. '
        'Execution recipe and inspector dependencies are frozen in the task check directory. '
        'Checks compare every product and input fingerprint; validation.json records one positive and eight intended-boundary negatives.\n\n'
        'Read source.jsonl with occurrence-map.jsonl, controllers.json, producer-context.json, source-case.json and acceptance-checklist.json. '
        'Page IDs use physical GameObject identities. Physical occurrences are never deduplicated. '
        'Source spans are JSON token byte ranges in exact hashed extracted source trees; raw object hashes preserve original provenance.\n\n'
        'Mouse native NameContainers remain saved inactive, with separate runtime subtitles; the animation slot11 is retained. '
        'Penny pages belong to sharedassets2.assets:15852 PagedTutorial with a sixth slot, not the homonymous bundle movie controller. '
        'Its instance/reachability remains unverified. Bear FrameSix is dialogue-only. '
        'The summary Page1 includes later Page2/Page3 wording and remains complete.\n\n'
        'Context snapshot retains four complete original producer conversations (315 entries), actors, links, fields and controls. '
        'They are provenance/context, not315 reviewed target units. Exact dialogue wording matches remain reuse candidates. '
        'The Mouse Awake evidence includes unrelated animation setup: only its page/state/callback prefix is needed for this predicate; '
        'no recursive animation/framework audit or whole-body semantic acceptance is claimed. '
        'The captured homonymous Penny movie evidence is retained as excluded evidence, not physical ownership proof.\n\n'
        'All25 alpha0 layout providers and125 face/glow fields use exact saved MatchupPro SDF bindings; fictional mouse3324/material3/atlas245 is separate. '
        'No fonts or textures produced. No target wording, source admission, runtime, visual, package or whole-game acceptance. '
        'Root README/CHECKPOINT and Git remain parent-owned. The worker stops here.\n').encode()
    encoded['README.md']=readme
    if args.build:
        out.mkdir(parents=True,exist_ok=False)
        # Exclusive per-file writes, not a transaction. Interrupted creation stays incomplete;
        # --check rejects missing/mismatched products; never overwrite the partial directory.
        for name,b in encoded.items():
            with (out/name).open('xb') as f:f.write(b)
    else:
        require(set(p.name for p in out.iterdir())==set(encoded),'product-set')
        for name,b in encoded.items():require((out/name).read_bytes()==b,'product-mismatch:'+name)
    print(json.dumps({'status':result['status'],'mode':'build' if args.build else 'check',
                      'occurrences':150,'pages':25,'controllers':5,'negativeControls':8,
                      'gaps':result['gapCounts'],'codeSha256':result['codeSha256']}))


if __name__=='__main__':
    main()
