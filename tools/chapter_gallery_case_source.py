#!/usr/bin/env python3
"""Reproduce the one153-member chapter/gallery source supplement; never patch a game.

New outputs are exclusive; --check derives bytes without writing. Source semantic
contracts are authored below; successful validation is not target editorial review.
"""
import argparse
import base64
import collections
import copy
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'localization/source/chapter-gallery-case-20261029'
CHECK = 'outputs/chapter-gallery-case-source-20261029/check/'
SHARED = 'localization/source/shared-source-completion-20261028/'
ADMIT = SHARED + 'admission-v1/'
BG = 'localization/source/gallery-chapter-display-20261028/'
BGA = BG + 'admission-v1/'
INDEX = 'outputs/pause-inventory-bio-completion-20261028/managed-index/'
CASE = 'chapter-titles-and-gallery-hints'
ASSEMBLY = '46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
VERSION = 'The Forest of Love 0.45; original assembly ' + ASSEMBLY
HELPER = 'System.String TheForestOfLove.StartScreenGalleryMenu::BuildLastAttemptedMovieIdentifierPhrase(System.Boolean,System.Int32,System.Int32)'
WRITER = 'System.Void TheForestOfLove.StartScreenGalleryMenu::OnClickPlay(System.String)'
GALLERY = 'System.Void TheForestOfLove.GalleryHintTutorial::'
OOS = 'System.Boolean TheForestOfLove.Content.BaseSpawner::TryShowOutOfSyncContentNotification(System.Int32,TheForestOfLove.Narrative.Chapter)'
OOS_GUARDS = 'System.Void TheForestOfLove.Content.BaseSpawner::TryShowOutOfSyncContentNotification()'

def sha(b):
    return hashlib.sha256(b).hexdigest()

def value_hash(v):
    return sha(json.dumps(v, ensure_ascii=False, separators=(',', ':')).encode())

def encode(name, v):
    return (''.join(json.dumps(r, ensure_ascii=False, separators=(',', ':')) + '\n' for r in v)
            if name.endswith('.jsonl') else json.dumps(v, ensure_ascii=False, indent=2) + '\n').encode()

def lid(method, offset):
    return f'il:Assembly-CSharp.dll/{method}/IL_{offset:04x}'

def unique(rows):
    assert len(rows) == len({r['id'] for r in rows}), 'duplicate-id'
    return {r['id']: r for r in rows}

def derive():
    pins = {}
    def read(p):
        b = (ROOT / p).read_bytes()
        pins[p] = {'sha256': sha(b), 'bytes': len(b)}
        return b
    def js(p):
        return json.loads(read(p))
    def rows(p):
        return [json.loads(l) for l in read(p).decode().splitlines()]
    runtime = js(CHECK + 'runtime-check.json')
    assert runtime['status'] == 'verified' and runtime['model'] == 'gpt-6.1-sol'
    assert runtime['reasoning'] == 'high' and runtime['provider'] == 'openai' and runtime['freshExecNoInheritedHistory']
    for n in ['brief.md', 'dispatch.json', 'runtime-verification.json']:
        read(CHECK + n)
    # Verify all retained admitted products, without repeating extraction or semantic review.
    old_manifest = js(BGA + 'manifest.json')
    for name, expected in old_manifest['products'].items():
        assert sha(read(BGA + name)) == expected['sha256'], ('changed-admission-product', name)
    registry = js(ADMIT + 'special-cases.json')
    case = next(c for c in registry['cases'] if c['id'] == CASE)
    assert len(case['sourceBindings']) == 153
    unique(case['sourceBindings'])
    states = unique(rows(BGA + 'column-states.jsonl'))
    originals = unique(rows(BG + 'source.jsonl'))
    native = unique(rows(ADMIT + 'serialized-inventory.jsonl'))
    managed = unique(rows(ADMIT + 'managed-literal-inventory.jsonl'))
    literals_list = rows(INDEX + 'literals.jsonl')
    literals = unique([dict(r, id=lid(r['method'], r['offset'])) for r in literals_list])
    field_uses = rows(INDEX + 'field-uses.jsonl')
    calls = rows(INDEX + 'calls.jsonl')
    metadata = js(INDEX + 'manifest.json')
    assert metadata['sourceSha256'] == ASSEMBLY
    for n in ['literals.jsonl', 'field-uses.jsonl', 'calls.jsonl']:
        assert pins[INDEX + n]['sha256'] == metadata['files'][n]['sha256']
    # Reuse complete helper/writer bodies; no unchanged extraction.
    methods = []
    for path, wanted in [(ADMIT + 'phase144/producer-bodies.jsonl', HELPER),
                         (ADMIT + 'phase146/receiver-bodies.jsonl', WRITER)]:
        b = next(r for r in rows(path) if r['method'] == wanted)
        assert sha(read(b['evidence'])) == b['fileSha256']
        methods.append(b)
    for path in [BGA + 'consumer-evidence.jsonl', 'outputs/pause-inventory-bio-completion-20261028/ui-consumer-index/bodies.jsonl']:
        for b in rows(path):
            if b['method'].startswith(GALLERY) or any(s in b['method'] for s in ['ConfirmBeginAdventureNotification::SetConfirmationScreenTitleText', 'OutOfSyncContentNotification::SetChapterNameLabel']):
                if b['method'] not in [m['method'] for m in methods]:
                    methods.append(dict(b, evidence=path, fileSha256=pins[path]['sha256']))
    for path in ['outputs/pause-inventory-bio-completion-20261028/consumer-bodies/GalleryHintTutorial.il',
                 CHECK + 'title-producers.il', CHECK + 'title-inputs.il', CHECK + 'adventure-title.il',
                 SHARED + 'adventure-source/ConfirmBeginAdventureNotification.il',
                 SHARED + 'adventure-source/Adventure.il']:
        read(path)
    helper = next(m for m in methods if m['method'] == HELPER)
    # Saved inspector bodies quote ldstr operands; raw literal index is authoritative.
    assert [(i['offset'], i['operand']) for i in helper['instructions'] if i['opcode'] == 'ldstr'] == [(3, '"Movie {0}"'), (22, '"Story {0}"')]
    writer_uses = [r for r in field_uses if 'StartScreenGalleryMenu::lastAttemptedMovieIdentifierPhrase' in r['field']]
    assert [(r['method'], r['opcode']) for r in writer_uses] == [(WRITER, 'stsfld'), (GALLERY + 'Start()', 'ldsfld')]
    assert not [r for r in field_uses if r['opcode'] in ('stfld', 'stsfld', 'ldflda') and any(s in r['field'] for s in ['StartScreenGalleryMenu::movieOptions', 'StartScreenGalleryMenu::storyOptions', 'StartScreenGalleryMenuMovie::movie'])]
    direct_context = unique(rows(ADMIT + 'direct-context.jsonl'))
    objects = unique(js('assets/source-v2/objects.json'))
    transforms = {r['object']: r for r in rows(ADMIT + 'context-transforms.jsonl')}
    tree_reads = {}
    def tree(oid):
        if oid in tree_reads:
            return tree_reads[oid]
        obj = objects[oid]
        if 'tree' in obj:
            p = 'assets/source-v2/' + obj['tree']
            b = read(p)
            assert sha(b) == obj['treeSha256'], ('tree-hash', oid)
            t = json.loads(b)
        else:
            snap = transforms[oid]
            assert snap['rawSha256'] == obj['rawSha256']
            t = snap['tree']
        tree_reads[oid] = t
        return t
    overlaps = collections.defaultdict(list)
    for c in registry['cases']:
        for b in c['sourceBindings']:
            overlaps[b['id']].append(c['id'])
    joined = []
    for bind in case['sourceBindings']:
        ident = bind['id']
        if ident in states:
            st = states[ident]
            r = dict(originals.get(ident, st))
            value = st['source']
            disp = 'absent-preserve' if not st['stored'] else 'reused-admitted-display'
            r['sourceState'] = st
            r['physicalSelector'] = {k: st[k] for k in ['sheetId', 'rowId', 'fieldId', 'rowIndex', 'sourceSpan', 'stored']}
            r['admittedDecisionReference'] = BGA + 'family-decision.json#' + ident
        elif ident in native:
            r = dict(native[ident])
            value = r['source']
            oid, pointer = ident.rsplit('/', 1)
            t = tree(oid)
            assert t[pointer] == value
            r['physicalSelector'] = {'object': oid, 'pointer': '/' + pointer, 'tree': objects[oid]['tree'], 'treeSha256': objects[oid]['treeSha256'], 'rawSha256': objects[oid]['rawSha256']}
            r['storedContext'] = direct_context[ident]
            disp = 'initial-template-display'
        else:
            r = dict(managed[ident])
            lit = literals[ident]
            value = lit['value']
            r['source'] = value
            r['physicalSelector'] = {'assemblySha256': ASSEMBLY, 'method': lit['method'], 'offset': lit['offset'], 'instructionIndex': lit['index'], 'opcode': 'ldstr'}
            disp = 'preserve-exactly' if bind['role'].startswith('preserve-') else 'live-fallback-display'
        assert value_hash(value) == bind['sourceValueSha256'], ('source-value-hash', ident)
        r.update(source=value, sourceValueSha256=bind['sourceValueSha256'], originalCaseRole=bind['role'], disposition=disp,
                 version=VERSION, overlaps=overlaps[ident])
        if isinstance(value, str):
            r['sourceUtf8Sha256'] = sha(value.encode())
        joined.append(r)
    assert len(joined) == 153
    absent = [r for r in joined if r['disposition'] == 'absent-preserve']
    protected = [r for r in joined if r['disposition'] == 'preserve-exactly']
    display = [r for r in joined if r not in absent and r not in protected]
    assert len(absent) == 16 and len(protected) == 5 and len(display) == 132
    extras = []
    for r in literals.values():
        if r['method'] not in [HELPER, OOS, OOS_GUARDS]:
            continue
        disp = 'case-wording-input' if r['method'] == HELPER else 'preserve-exactly'
        extras.append(dict(id=r['id'], source=r['value'], sourceValueSha256=value_hash(r['value']), sourceUtf8Sha256=sha(r['value'].encode()),
                           physicalSelector={'assemblySha256': ASSEMBLY, 'method': r['method'], 'offset': r['offset'], 'instructionIndex': r['index'], 'opcode': 'ldstr'},
                           originalInventory=managed[r['id']], disposition=disp, version=VERSION, overlaps=overlaps[r['id']]))
    assert len(extras) == 7 and sum(r['disposition'] == 'case-wording-input' for r in extras) == 2
    assert not {r['id'] for r in extras} & {r['id'] for r in joined}
    # The six Adventure titles explain the DIFFERENT live confirmation title root.
    adventure_titles = [r for r in rows(SHARED + 'adventure-source/display-source.jsonl') if r.get('field') == 'Title']
    assert len(adventure_titles) == 6
    for r in adventure_titles:
        assert literals[r['id']]['value'] == r['source']
        r.update(dependencyRole='external-live-confirmation-root-context;not-an-additional-chapter-case-wording-id', overlaps=overlaps[r['id']], version=VERSION)
    # Static serialized roots: never substitute hierarchy similarity for pointer binding.
    root_specs = [('gallery', 'sharedassets0.assets:3654', 'labelRoot', 'component'),
                  ('out-of-sync', 'sharedassets2.assets:18814', 'chapterNameLabelRoot', 'gameObject'),
                  ('confirmation-live', 'sharedassets2.assets:18088', 'confirmationScreenTitleTextRoot', 'transform')]
    bindings = []
    for group, ctl, field, kind in root_specs:
        t = tree(ctl)
        p = t[field]
        assert p['m_FileID'] == 0
        root_oid = ctl.split(':')[0] + ':' + str(p['m_PathID'])
        root_go = root_oid if kind == 'gameObject' else ctl.split(':')[0] + ':' + str(tree(root_oid)['m_GameObject']['m_PathID'])
        descendants = [r['id'] for r in direct_context.values() if r['class'] == 'TMPro.TextMeshProUGUI' and any(a['object'] == root_go for a in r['ancestors'])]
        assert len(descendants) == 6
        for ident in descendants:
            tree(ident.rsplit('/', 1)[0])
        bindings.append(dict(group=group, controller=ctl, field=field, pointer=p, root=root_oid, rootGameObject=root_go,
                             exactPotentialTmpDescendants=descendants,
                             boundary='Saved hierarchy membership; native GetComponentsInChildren excludes inactive descendants by default. No runtime rendering claim.'))
    by_group = {r['group']: r for r in bindings}
    initial_context = []
    for r in display:
        if r['id'] in originals:
            continue
        ident = r['id']
        if ident.startswith('sharedassets0.assets:'):
            group = 'gallery'
            fact = 'Exact labelRoot binds this six-field hierarchy. Start overwrites active child TMP text with assembled identifier+hint or fallback; stored text alone cannot localize the live fallback.'
            eligibility = 'Prepare one common fallback wording; bind all six initial selectors and compiled Start/IL_0033 separately. A serialized-only replacement is insufficient.'
            selected = True
        elif ident.startswith('sharedassets2.assets:') and 'OutOfSyncContentNotification/' in r['hierarchy']:
            group = 'out-of-sync'
            fact = 'Exact chapterNameLabelRoot binds these six fields. Instantiate -> SetChapterNameLabel copies caller argument1 unchanged. BaseSpawner supplies ChapterRecord.title with original two-apostrophe wrapper.'
            eligibility = 'Retain six initial display occurrences conservatively; use the admitted chapter-title decision and protected wrapper for live prose. Do not treat stored example as a fixed selected chapter.'
            selected = True
        elif ident.startswith('sharedassets2.assets:'):
            group = 'confirmation-template'
            fact = 'AdventureName is initially inactive (GO2510). Live confirmation root is Transform13363 -> GO3483 Title (2), a disjoint sibling. OnClickStart enables confirmationScreen and copies selected Adventure.Title to that other root; it does not bind these six examples.'
            eligibility = 'Conservative initial-only wording candidates at exact selectors. No demonstrated live overwrite/enable producer for this inactive branch; do not patch Adventure.Title or assume runtime absence. Keep selection uncertainty.'
            selected = False
        else:
            group = 'compiled-fallback'
            fact = 'Start/IL_0033 is live fallback for missing MovieRecord or null/empty/whitespace hint. It omits identifier and separator entirely.'
            eligibility = 'Required case fallback wording at this exact managed literal selector; share semantic wording with six initial fields without deduplicating application identities.'
            selected = True
        initial_context.append(dict(id=ident, source=r['source'], sourceValueSha256=r['sourceValueSha256'], group=group,
                                    producerMembershipProvedStatically=selected, sourceFact=fact, conservativeTargetEligibility=eligibility,
                                    runtimeSelection='not-run', applicationSelector=r['physicalSelector']))
    assert len(initial_context) == 19
    confirmation_ids = {r['id'] for r in initial_context if r['group'] == 'confirmation-template'}
    assert len(confirmation_ids) == 6 and not confirmation_ids & set(by_group['confirmation-live']['exactPotentialTmpDescendants'])
    assert {r['id'] for r in initial_context if r['group'] == 'gallery'} == set(by_group['gallery']['exactPotentialTmpDescendants'])
    assert {r['id'] for r in initial_context if r['group'] == 'out-of-sync'} == set(by_group['out-of-sync']['exactPotentialTmpDescendants'])
    # All supported serialized options, enum arguments, ordinals and hint-state joins.
    enum_text = read(CHECK + 'movie-enum.il').decode()
    enums = {name: int(num) for name, num in re.findall(r'Movie::(\w+) = (-?\d+)', enum_text)}
    menu_ids = [r['id'] for r in objects.values() if r.get('class') == 'TheForestOfLove.StartScreenGalleryMenu']
    assert menu_ids == ['level1:8475']
    menu = tree(menu_ids[0])
    movie_rows = collections.defaultdict(dict)
    for r in rows('localization/source/bgdatabase-complete-values-20261027/verified/cells.jsonl'):
        if r['sheet'] == 'Movie':
            movie_rows[r['rowId']][r['field']] = r
    movie_by_enum = {}
    for row in movie_rows.values():
        val = row['movie']['source']
        assert val not in movie_by_enum
        movie_by_enum[val] = row
    selection = []
    for array, label in [('movieOptions', 'Movie'), ('storyOptions', 'Story')]:
        for pos, ref in enumerate(menu[array]):
            assert ref['m_FileID'] == 0
            oid = 'level1:' + str(ref['m_PathID'])
            opt = tree(oid)
            button_id = 'level1:' + str(opt['playButton']['m_PathID'])
            button = tree(button_id)
            events = button['m_OnClick']['m_PersistentCalls']['m_Calls']
            play = [c for c in events if c['m_MethodName'] == 'OnClickPlay']
            assert len(play) == 1
            c = play[0]
            arg = c['m_Arguments']['m_StringArgument']
            assert c['m_Target'] == {'m_FileID': 0, 'm_PathID': 8475} and c['m_Mode'] == 5 and enums[arg] == opt['movie']
            bg_row = movie_by_enum[opt['movie']]
            hint = bg_row['hint_phrase']
            assert hint['id'] in states
            selection.append(dict(id=menu_ids[0] + '/' + array + '/' + str(pos), option=oid, zeroBasedIndex=pos,
                                  originalIdentifier=f'{label} {pos+1}', enumName=arg, enumValue=opt['movie'],
                                  originalOption=opt, originalButtonOnClick=events, button=button_id,
                                  hintId=hint['id'], hintSource=hint['source'], hintStored=hint['stored'],
                                  movieIdentity={k:bg_row[k]['source'] for k in ['name','movie','savekey']},
                                  controlDisposition='preserve-exactly;display wording never changes enum/array/order/button events'))
    assert collections.Counter(r['id'].split('/')[1] for r in selection) == {'movieOptions': 11, 'storyOptions': 48}
    assert len({r['enumValue'] for r in selection}) == 59
    unselected = [s['id'] for s in states.values() if s['sheet'] == 'Movie' and s['id'] not in {r['hintId'] for r in selection}]
    assert len(unselected) == 6
    # Target reuse joins are candidates only. Every packet has its own exact version pin.
    locale_scope = js('localization/supplemental-ui/20261027/locale-scope.json')
    packet_manifest = js('localization/supplemental-ui/20261027/manifest.json')
    wording = display + [r for r in extras if r['disposition'] == 'case-wording-input']
    wording_ids = [r['id'] for r in wording]
    assert len(wording_ids) == len(set(wording_ids)) == 134
    candidates = []
    coverage = []
    for locale in locale_scope['targetLocales']:
        path = 'localization/supplemental-ui/20261027/' + locale + '.jsonl'
        packet = rows(path)
        unique(packet)
        assert len(packet) == 935 and pins[path]['sha256'] == packet_manifest['locales'][locale]['sha256']
        for dest in wording:
            for old in packet:
                if old['source'] == dest['source']:
                    candidates.append(dict(locale=locale, destinationId=dest['id'], originalSourceValueSha256=dest['sourceValueSha256'],
                                           candidateId=old['id'], exactIdMatch=old['id']==dest['id'], exactSourceMatch=True,
                                           target=old['target'], targetSha256=sha(old['target'].encode()), sourcePacket=path,
                                           sourcePacketSha256=pins[path]['sha256'], applicability='candidate-only;no-editorial-or-application-acceptance'))
        assert not set(wording_ids) & {r['id'] for r in packet}
        coverage.append(dict(locale=locale, commonWordingIds=wording_ids, initialTemplateDecisionsRequired=True,
                             commonProtectedIds=[r['id'] for r in protected+extras if r['disposition']=='preserve-exactly'],
                             absentIds=[r['id'] for r in absent], frozen935Sha256=pins[path]['sha256'],
                             candidateRows=sum(r['locale']==locale for r in candidates),
                             localeCaseDecision='needs-review', targetEditorialAccepted=False, application='not-run', runtime='not-run'))
    assert len(coverage) == 30
    old_source_decisions = js(BGA + 'source-decisions.json')
    old_contracts = js(BGA + 'consumer-contracts.json')
    glossary_handoff = js('localization/glossary/inventory-display-20261028/handoff.json')
    # Pin mandatory references actually read; no site/translation mutation.
    for path in ['AGENTS.md', '/Users/antonkrutov/.codex/instructions/sitefor-mods.md',
                 '/Users/antonkrutov/.codex/instructions/game-localization-prompt.md',
                 '/Users/antonkrutov/.codex/instructions/game-localization-audit-workflow.md',
                 '/Users/antonkrutov/.codex/skills/vn-game-assets/SKILL.md', '/Users/antonkrutov/.codex/skills/vn-localization/SKILL.md',
                 '/Users/antonkrutov/.codex/skills/vn-game-assets/references/COMMON.md',
                 '/Users/antonkrutov/.codex/skills/vn-game-assets/references/WORKFLOW.md',
                 '/Users/antonkrutov/.codex/skills/vn-game-assets/references/ROUTING.md',
                 '/Users/antonkrutov/.codex/skills/vn-game-assets/references/SPECIAL-SCENES.md',
                 '/Users/antonkrutov/.codex/skills/vn-game-assets/references/HANDOFF.md',
                 '/Users/antonkrutov/.codex/skills/vn-localization/references/COMMON.md',
                 '/Users/antonkrutov/.codex/skills/vn-localization/references/ROUTING.md',
                 'tools/chapter_gallery_case_source.py']:
        read(path)
    context = dict(schemaVersion=1, caseId=CASE, version=VERSION,
        retained113SourceDecisions={'path':BGA+'source-decisions.json','sha256':pins[BGA+'source-decisions.json']['sha256'], 'semanticRereadRepeated':False},
        glossaryHandoff={'path':'localization/glossary/inventory-display-20261028/handoff.json','sha256':pins['localization/glossary/inventory-display-20261028/handoff.json']['sha256']},
        retainedChapterAndHintConsumers=old_contracts,
        identifier=dict(writer=WRITER, writeOffset=179, allManagedFieldUses=writer_uses, helper=HELPER,
                        branches=[{'guard':'isMovie == true','sourceId':lid(HELPER,3),'format':'Movie {0}','argument':'movie-array first matching index + 1'},
                                  {'guard':'isMovie == false','sourceId':lid(HELPER,22),'format':'Story {0}','argument':'story-array first matching index + 1'}],
                        actorNameSources=[], actorNameReason='Complete helper reads only bool and integer arguments. It does not read actors, names, movie titles or BG prose.',
                        joining='One ASCII space before decimal ordinal. String.Format uses original integer formatting/culture; no explicit locale argument.',
                        writerOrder='Return if isSuspendedForHint or MovieManager.isPlayingMovie. Enum.Parse original callback argument. Scan movies first, then stories; store lastAttemptedMovie and helper result before isUnlocked. Movie hit sets isMovie=true; a later story hit can replace selected option but does not reset that flag. No configured duplicates across arrays.',
                        unknownInput='No option match leaves null local; original member dereference at IL_009f can fail. Do not add guessed fallback or translate Enum.Parse input.',
                        arrays='One saved controller;11+48 configured distinct enum values. No direct managed field/address writes to array fields or Movie option identities in full field-use index. Native/reflection mutation and actual enabled options are unverified.',
                        unselectedMovieHintStateIds=unselected,
                        output='Nonwhitespace hint -> identifier + exactly two LF + hint. Missing/null/empty/whitespace -> fallback alone. Original selector identities remain unchanged.'),
        serializedProducerBindings=bindings,
        confirmationMismatch=dict(exampleIds=sorted(confirmation_ids), initialObject='sharedassets2.assets:2510', initialActiveSelf=False,
            actualRoot='sharedassets2.assets:13363', actualRootGameObject='sharedassets2.assets:3483',
            titleProducer='selected Adventure.Title -> page.SetTitle -> page.Title -> OnClickStart callback -> SetConfirmationScreenTitleText -> other title root',
            conclusion='The six saved examples are not descendants of the live title root. Do not claim producer coverage from equal stored text or generic class setters.',
            remainingPredicate='Whether any shipped animation/native/event path enables or exposes AdventureName GO2510 at runtime. Keep initial-only conservative candidates; authorized runtime needed to establish selection, not a recursive framework audit.'),
        outOfSync=dict(wrapper="''{0}''", wrapperId=lid(OOS,78), apostropheCodepoint='U+0027 twice on each side; not a double quotation mark',
            producer='BaseSpawner resolves ChapterRecord by original chapter enum. Original version/conversation/trigger predicates select chapters2600 or2700. Title is wrapped, cached in closure, delayed1.5s, then ItemGetNotification argument1 -> exact six-field root.',
            guards='Already-shown version flag, missing chapter record or missing ItemGetNotification return false. ItemGetNotification.visible returns before instantiation/setter. These are distinct from chapter-list hidden/tag guards.',
            scope='No rewrite of callbacks, persistent flags, version keys or quest identities. Null title formatting is an existing format boundary, not authorization to populate absent DB cells.'),
        nativeExternalBoundaries=['Unity GetComponentsInChildren/Instantiate/SetActive and event scheduling are not executed.', 'TMP rendering/font/glyph/shaping/RTL/layout unknown; no font audit.', 'DataService manifest/storage cache reuse as admitted; no extraction or framework recursion.'],
        runtime='not-run', targets='not-authored-or-accepted')
    decisions = dict(schemaVersion=1, caseId=CASE, status='finite-case-source-handoff-complete', sourceGroupDisposition='complete-bounded-source-preparation-contract;owning-parent-source-admission-pending',
        sourceAnalysis='All153 physical members and complete named identifier helper reconciled. Runtime-selected reachability remains separate and explicit.',
        originalMembers=153, originalDisplayOccurrences=132, originalAbsentStates=16, originalProtectedOperands=5,
        newCaseWordingOccurrences=2, extraProtectedOperands=5, externalConfirmationTitleContextOccurrences=6,
        commonWordingIds=wording_ids, commonWordingOccurrences=134, commonDistinctSourceValues=len({r['source'] for r in wording}),
        fullGroupIncludesInitialTemplates=True, protectedIds=[r['id'] for r in protected]+[r['id'] for r in extras if r['disposition']=='preserve-exactly'],
        absenceIds=[r['id'] for r in absent],
        dependencyGroups=[{'id':'retained-title-description-wordplay','source':BGA+'source-decisions.json','groups':old_source_decisions['wordplayGroups'], 'policy':'Reuse exact113 source decisions. Red=Rascal; Ollie=Oliver; former roommates remain unnamed; comma lists do not become AND/OR facts.'},
                          {'id':'identifier-hint-fallback','ids':[r['id'] for r in wording if r.get('sheet')=='Movie' or r['id'].startswith('sharedassets0.assets:') or r['id'] in [lid(HELPER,3),lid(HELPER,22),lid(GALLERY+'Start()',51)]], 'policy':'Review ordinal label formats, assembled hint and fallback together. Bind helper literals separately from Movies/Stories counters.'},
                          {'id':'photoshoot-initials-and-live-wrapper','ids':[r['id'] for r in initial_context if r['id'].startswith('sharedassets2.assets:')]+[lid(OOS,78)], 'policy':'Retain original two-apostrophe syntax. Reuse admitted After the Photoshoot chapter title for initial aliases; compiled wrapper stays exact unless separately scoped adapter changes presentation. Confirmation live root is a different existing Adventure case.'}],
        localePreparationContract=dict(locales=locale_scope['targetLocales'], required='For each of30, after approved applicable glossary, prepare and review actual wording for all134 occurrence IDs (including initial-only conservative decisions) and whole dependency groups. Exact repeated-source aliases may share reviewed wording, never application identity.',
             initialOnlyDecision='Keep all six inactive confirmation examples in the conservative preparation denominator until source owner accepts evidence-based exclusion; selected-live and runtime remain unknown.',
             sourceInputs='source.jsonl + original-members.jsonl + absence.jsonl + preserve-exactly.jsonl + selection-identities.jsonl + producer-context.json + retained113 decisions/glossary pins',
             applicationRoutes=['BG113: existing three-column sparse replacement adapter; install before record-manifest creation, whole payload readback/restoration; preserve16 absent states.',
                                'Managed helper2 plus fallback1: exact original assembly/method/offset/ldstr matching, placeholders and argument order exact. Readback all method bodies and restore originals. Existing six gallery-counter patches do not cover these selectors.',
                                'Native18: exact asset/pathId/m_text, initial-state replacements only; readback and all other object bytes preserved. Gallery and OOS live producers still require their separate bindings.',
                                'OOS live title: localized admitted Chapter.title + untouched wrapper; do not replace entire output with saved example or change selected enum.',
                                'Confirmation examples: initial-only selectors; no live producer hook justified for AdventureName. Existing Adventure.Title belongs to compiled-adventure-title-body-status and its own decisions; do not duplicate it as chapter wording.'],
             forbidden='No target content, resource, font or application mutation in this handoff. No ordinary batch, locale case acceptance, game/global source gate or runtime promotion.'),
        concreteRemainingSourceDecision={'ids':sorted(confirmation_ids),'predicate':context['confirmationMismatch']['remainingPredicate'],'sourceClassification':'Known stored initial display, conservative preparation eligible; no unknown physical membership or invented absence.','nextPermittedAction':'Parent may prepare conservative case wording and adjudicate source inclusion; actual selection requires separately owner-authorized runtime. Stop this finite assignment; no automatic framework follow-up.'},
        targetEditorialAccepted=False, localeCaseDecisionAccepted=False, ordinaryTranslationEntryAllowed=False, globalPretranslationPassed=False, wholeGameAccepted=False, runtime='not-run', fonts='not-run')
    tests = [
      ('identifier-movie','Original11 movie option controls','Each callback enum matches exact serialized numeric value; original ordinal1..11 and helper Movie branch retained.','Changing label never changes enum argument/order or unlock. Unknown enum parse/no-match must not be credited as valid selection.'),
      ('identifier-story','Original48 story option controls','Each callback enum matches exact numeric value; original ordinal1..48 and Story branch retained.','Secret/hidden entries retain original array positions; no visible-item recount or substitution by Movies/Stories counter selector.'),
      ('hint-join','Configured option hint source plus managed helper/fallback','Nonempty hint emits localized identifier + exactly LF LF + complete hint; every active glow child matches.','Missing record, null, empty and whitespace each emit only localized fallback; no blank box/identifier separator. Formatter/braces are protected.'),
      ('title-tooltip','Retained113 admitted source IDs and cache','Original selected unlocked/title-nonblank/not-hidden/tag-qualified record displays complete title and description; callbacks keep chapter enum.','enableAllChapters still does not bypass hidden/title/tag guards; empty tag set fails; descriptions cannot reveal four absent title/description rows.'),
      ('source-absence','All16 absent states','Exact source null/sparse membership retained;113 existing stored cells retained.','Adding one new stored string to any absent state must fail exact membership guard even if its hash is self-consistent.'),
      ('oos-title','Exact chapter enum and six-field root','Original2600/2700 choice supplies the corresponding title wrapped in U+0027 U+0027 on each side.','Already-shown/missing-record/missing-notification/visible-notification guards do not instantiate or overwrite; selected chapter must not be replaced by Photoshoot example.'),
      ('initial-gallery','Six initial fields plus Start/IL_0033','Both initial fallback and live fallback use reviewed wording with six active child bindings.','Serialized-only replacement leaving compiled English fallback is an application failure.'),
      ('confirmation-template','Six inactive AdventureName examples vs six live Title (2) fields','Keep physical selectors distinct and retained initial conservative wording. If runtime later exposes branch, verify complete six-child group.','Static live root membership is disjoint. Generic setter existence or equal title text cannot be credited as overwriting these examples; do not enable branch to manufacture coverage.'),
      ('protected-controls','Ten managed operands and59 serialized controls','Exact resource path, format strings, trigger identities, conversation/quest predicates, enum/option/button bindings remain identical.','Translated key, changed punctuation wrapper, reordered array or changed callback rejects application before write.'),
      ('rendering','Future authorized real packaged case surfaces in each locale','Actual loaded fonts, fallback, shaping/RTL, ordinal formatting, title/tooltip wrapping and glow copies are legible.','Static source/validator success cannot pass runtime or font feasibility.')]
    checklist = [dict(id=i, artifact=a, positive=p, negative=n,
                      currentEvidence='Static source join and original body/tree evidence; see input-pins.json. No target build or game runtime.',
                      currentStatus='source-contract-recorded;target-and-runtime-not-run',
                      nextPermittedAction='Parent uses contract for bounded case decisions; implementation/runtime only within applicable separate authorization.') for i,a,p,n in tests]
    products = {'original-members.jsonl':joined, 'source.jsonl':wording, 'absence.jsonl':absent,
                'preserve-exactly.jsonl':protected+[r for r in extras if r['disposition']=='preserve-exactly'],
                'additional-source-findings.jsonl':extras, 'external-confirmation-title-context.jsonl':adventure_titles,
                'initial-display-context.jsonl':initial_context, 'consumer-bodies.jsonl':methods,
                'selection-identities.jsonl':selection, 'producer-context.json':context,
                'case-decision.json':decisions, 'acceptance-checklist.json':checklist,
                'reuse-candidates.jsonl':candidates, 'thirty-locale-preparation.json':coverage,
                'input-pins.json':pins}
    summary = dict(schemaVersion=1, status='finite-case-source-handoff-complete', game='The Forest of Love', build='0.45',
                   caseId=CASE, all153Accounted=True, originalMembers=153, reusedAdmittedNonemptyCells=113,
                   otherDisplayOccurrences=19, absentStates=16, originalProtectedOperands=5,
                   additionalSourceCounts={'caseWording':2,'protectedOperands':5,'externalExistingAdventureTitleContext':6,'serializedOptionControls':59},
                   newTranslationInventorySharedByAll30=True, commonWordingOccurrences=134,
                   remainingRuntimePredicate=context['confirmationMismatch']['remainingPredicate'],
                   targetEditorialAccepted=False, wholeGameAccepted=False, ordinaryTranslationEntryAllowed=False,
                   runtime='not-run', nestedJobs=False, gitMutations=False, rootReadmeCheckpointMutations=False,
                   sourceExtractionRepeated=False, model='gpt-6.1-sol', reasoning='high', provider='openai',
                   freshExecNoInheritedHistory=True,
                   commitBoundary='All products derived before exclusive sequential writes; manifest written last. No transaction or runtime rollback claim.',
                   nextAction='Parent reconcile source decisions, bounded locale preparation, usage and canonical Git integration; no automatic continuation.')
    summary['products'] = {n:{'sha256':sha(encode(n,v)),'bytes':len(encode(n,v))} for n,v in products.items()}
    products['manifest.json'] = summary
    return products

def verify_products(actual, expected):
    assert actual.keys() == expected.keys(), 'product-membership'
    for n in expected:
        assert actual[n] == expected[n], ('product-content', n)

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--check', action='store_true')
    args=ap.parse_args()
    values=derive()
    expected={n:encode(n,v) for n,v in values.items()}
    if args.check:
        actual={n:(OUT/n).read_bytes() for n in expected}
        verify_products(actual, expected)
        # Matching positive control first; recomputed tampered hashes cannot mask content drift.
        tests=[]
        for name, predicate, change in [
            ('missing-absence','product-content',lambda d:d.__setitem__('absence.jsonl',b'')),
            ('changed-protected-value-with-valid-hash','product-content',lambda d:d.__setitem__('preserve-exactly.jsonl', encode('preserve-exactly.jsonl',[dict(r,source='translated-key',sourceValueSha256=value_hash('translated-key')) if i==0 else r for i,r in enumerate(values['preserve-exactly.jsonl'])]))),
            ('wrong-confirmation-root','product-content',lambda d:d.__setitem__('producer-context.json',encode('producer-context.json',dict(values['producer-context.json'],confirmationMismatch={'actualRootGameObject':'sharedassets2.assets:2510'})))),
            ('wrong-identifier-ordinal','product-content',lambda d:d.__setitem__('selection-identities.jsonl',encode('selection-identities.jsonl',[dict(r,originalIdentifier='Movie 0') if i==0 else r for i,r in enumerate(values['selection-identities.jsonl'])]))),
            ('missing-case-member','product-content',lambda d:d.__setitem__('original-members.jsonl',encode('original-members.jsonl',values['original-members.jsonl'][:-1]))),
        ]:
            bad=dict(actual);change(bad)
            try:verify_products(bad,expected)
            except AssertionError as e:
                assert e.args[0][0]==predicate
                tests.append(name)
            else:raise AssertionError('negative-control-did-not-reject:'+name)
        print(json.dumps(dict(status='verified', all153Accounted=True, sourceOccurrences=134, absence=16,
                              preservedManagedOperands=10, serializedOptions=59, locales=30, negativeControls=tests,
                              boundary='Deterministic source/version/selector comparisons only; no target semantics, adapter or runtime execution.')))
    else:
        assert not OUT.exists(), 'append-only-output-exists'
        OUT.mkdir()
        for n,data in expected.items():
            with (OUT/n).open('xb') as f:f.write(data)
        print(json.dumps(dict(status='prepared',originalMembers=153,sourceOccurrences=134,locales=30)))

if __name__ == '__main__':
    main()
