#!/usr/bin/env python3
"""Reproduce the source-only 113-cell admission. --check never writes products.

No target projection, game/model call, Git operation or root checkpoint mutation.
Semantic decisions below are authored source/context decisions, not review receipts.
"""
import argparse, base64, collections, hashlib, json, pathlib, struct

ROOT = pathlib.Path('/Users/antonkrutov/Desktop/Forest')
BASE = 'localization/source/gallery-chapter-display-20261028/'
OUT = ROOT / (BASE + 'admission-v1')
CHECK = 'outputs/gallery-chapter-source-admission-20261028/check/'
COMPLETE = 'localization/source/bgdatabase-complete-values-20261027/'
AUDIT = 'outputs/ru-completion-reconciliation-20261028/check/'
TRACE = 'outputs/pause-inventory-bio-completion-20261028/'
SHARED = 'localization/source/shared-source-completion-20261028/admission-v1/'
GLOSS = 'localization/glossary/inventory-display-20261028/'
COLUMNS = {('Movie','hint_phrase'): (65,57), ('Chapter','title'): (32,28), ('Chapter','description'): (32,28)}

# Each title/description pair was read together against the actual same-row context.
# Explicit source decisions; these do not supply or approve target wording.
CHAPTER = {
0: ('Latest Monthly Progress', [], 'Monthly-content starting point. Keep the stored label even though this row is hidden. Do not promise runtime availability.'),
1: ('New Game (with Intro)', [], 'Restart including introduction cutscenes; preserve the with-intro distinction and parenthetical label.'),
2: ('New Game (Skip Intro)', [1], 'Start after Red awakens in the bunny house. Red is Rascal Redtail; skip-intro is distinct from restarting with cutscenes.'),
4: ('Water Under the Bridge', [5,116], 'Broken-bridge quest and the idiom about past troubles. Preserve both the bridge context and idiomatic title; description places the start BEFORE talking to Bucky.'),
6: ('Need for Seed', [2,43,74,118], 'Rhyming quest title; seed retains the reproductive/plant double meaning. Start BEFORE visiting the plant for Scarlett, ALSO AFTER Bridge Quest. Do not reverse these temporal relations or turn the plant into a person.'),
8: ('End of Act 1', [41,56], 'Start BEFORE the critters gather to finish the bridge, despite the end-of-act title. Preserve Act 1 and plural residents.'),
10: ('An Apple a Day', [5,80,122], 'Familiar saying used as a quest title; apples are traded for Oliver\'s help. This chapter description starts AFTER Bucky finishes the bridge, not after an apple delivery.'),
11: ('Warm and Cozy', [1,11,12,13,86,120], 'Red has ridden Ollie to meet the coyotes. Red=Rascal; Ollie=Oliver. Sweater warmth is the quest context; keep AFTER and plural coyotes without replacing their group label with names.'),
12: ('Critter Dates', [4,55,56,58,59,60], 'Optional encounters, not calendar dates. AFTER riding Penny FROM the coyotes\' fast-travel perch; preserve origin and plural possessive.'),
13: ('Delivery Quest (Relic)', [8,50,83], 'Start AT Maverick\'s shop for deliveries; parenthetical Relic distinguishes this checkpoint. Do not infer a recipient from this description.'),
14: ('Delivery Quest (Toys)', [8,50,83], 'RETURN to the same shop for MORE deliveries; retain Toys and do not merge with the Relic or Shovel checkpoint.'),
15: ('Delivery Quest (Shovel)', [8,50,85], 'RETURN for MORE deliveries. Shovel is the checkpoint distinction; identical description to Toys remains a separate physical cell.'),
16: ('The Musky Mustelid', [8,50,81], 'Shop name: approved alliteration/mustelid association. Buy goods with newly acquired coins; not a new creature identity.'),
17: ('Shear Finley', [10,84,87], 'Literal shearing of Finley the ram with shears helps him cool down. Do not change his species or invent a separate named character/unsupported shear/sheer joke.'),
18: ('Deliver the Wool', [10,11,12,87], 'Take wool FROM Finley BACK TO the coyotes. Preserve direction and material; source does not require naming individual coyotes.'),
19: ("Dustin's Dodge Challenge", [9,143], 'Competitive minigame title. Head-to-head in Dustin\'s battleground; the gallery\'s separate dash-challenge hint is not authority to rename this chapter title.'),
20: ('Pick Up the Sweater', [11,12,86], 'RETURN to coyotes to collect the FINISHED sweater; do not turn collection into delivery or crafting.'),
21: ('Patching Things Up', [10,134], 'Reconciliation idiom; help Finley close the loop with HIS former roommates. Do not identify those roommates or infer romance/species/kinship from the repaired Finley glossary.'),
22: ('Cookie Deliveries', [15,56,135], 'Deliver cookies to help Charlotte break the ice, an idiom for social ease. Do not literalize ice or invent recipients.'),
23: ('Roomies Reunited', [134], 'Informal roommates title; return to the cave where former roommates meet to reconcile. Keep the description unnamed. Do not equate these people with Melody/Charlotte solely because their glossary also says roommates.'),
24: ('Hello Charlotte', [15,45,56], 'Charlotte travels TO Central Forest to meet other residents. Preserve destination and accompanying-player imperative without inventing prior acquaintances.'),
25: ('The Steamy Photoshoot', [8,14,50,108,115,136], 'Steamy is erotic photoshoot wordplay, supported by sexy/private in the description; not literal steam. Melody is the model; location is Maverick\'s shop.'),
26: ('After the Photoshoot', [14], 'AFTER the shoot with Melody; rumblings of trouble foreshadow events without specifying their cause. Preserve the exclamation, ellipsis and suspense rather than supplying a plot explanation.'),
27: ('After The Storm', [56,137,138], 'AFTER the storm; check that ALL residents are okay. Do not change this into the during-storm quest or assert injuries.'),
28: ('Firefly Hunting', [7,112,113], 'Collect fireflies WITH Mabel to FILL a lantern jar. Preserve live-insect/light-source relation and companion.'),
29: ('Into The Woods', [7,46,52], 'Travel into woods WITH Mabel to meet HER folks/community. Preserve the familiar wording without replacing folks with an invented exact family roster or treating a generic woods phrase as a new proper location.'),
30: ('The Mouse Ceremony', [52,70,140], 'RETURN to the forest mice to BEGIN the ceremony. This is Mabel\'s community, not all forest animals; no fictional-language translation or new ritual explanation is authorized.'),
31: ('Free Roam', [], 'Explore extra content freely. Preserve optional exploration; no claim that all content is unlocked or newly translated.')
}
# Complete literal roster for hints. Comma forms intentionally retain underdetermination.
HINTS = {
'Unlocked from an Act 1 quest.': 'Act 1 quest; retain number and unspecified quest identity.',
'Unlocked from an Act 2 quest.': 'Act 2 quest; retain number and unspecified quest identity.',
'Unlocked from an Act 3 quest.': 'Act 3 quest; retain number and unspecified quest identity.',
'Unlocked from a gossip with Dustin.': 'Gossip conversation with Dustin, not malicious rumor or a calendar encounter.',
'Unlocked from a gossip with Penny.': 'Gossip conversation with Penny.',
'Unlocked from a gossip with Augustus.': 'Gossip conversation with Augustus; do not name the story participants from the internal movie name.',
'Unlocked from a gossip with Mabel.': 'Gossip conversation with Mabel.',
'Unlocked from a gossip with Maverick.': 'Gossip conversation with Maverick.',
'Unlocked from a gossip with the Coyotes.': 'Gossip conversation with the plural coyote group; keep group label rather than expanding to personal names.',
'Unlocked from a gossip with Oliver.': 'Gossip conversation with Oliver.',
'Unlocked from a gossip with Charlotte.': 'Gossip conversation with Charlotte; do not add fantasy/story participants.',
'Unlocked from a gossip with Melody.': 'Gossip conversation with Melody.',
'Unlocked from a gossip with Bucky.': 'Gossip conversation with Bucky.',
'Unlocked from a gossip with Finley.': 'Gossip conversation with Finley; repaired species facts do not identify other participants.',
'Unlocked from a gossip with Scarlett.': 'Gossip conversation with Scarlett; do not substitute the internally named movie subject.',
'Unlocked from a date with Mabel and Dustin.': 'Optional encounter with BOTH named participants Mabel and Dustin; preserve source order and conjunction.',
'Unlocked from a date with Peter, Bucky, and Scarlett.': 'Optional encounter with the THREE named participants; preserve list order and and.',
'Unlocked from a date with Bucky and Augustus.': 'Optional encounter with both Bucky and Augustus.',
'Unlocked from a date with Oliver and the Coyotes.': 'Optional encounter with Oliver and the plural coyote group.',
'Unlocked from a date with Finley and the Coyotes.': 'Optional encounter with Finley and the plural coyote group; no roommate claim.',
'Unlocked from a date with Oliver and Bucky.': 'Optional encounter with Oliver and Bucky.',
'Unlocked from a date with Penny and Mabel.': 'Optional encounter with Penny and Mabel.',
'Unlocked from a date with Dustin and Mabel.': 'Optional encounter with Dustin and Mabel; preserve this source order even though another movie lists Mabel first.',
'Unlocked from a date with Penny and Scarlett.': 'Optional encounter with Penny and Scarlett.',
'Unlocked from a date, gossip with the Coyotes.': 'Two comma-listed encounter labels, date THEN gossip, with coyotes. Raw display prose; source does not state AND/OR, alternatives, prerequisites or sequence. Retain list ambiguity; do not invent connective logic.',
'Unlocked from the dash challenge with Dustin.': 'Dustin dash challenge, retaining source wording; no silent substitution of the separate Dodge chapter label.',
"Unlocked from one of Scarlett's adventures.": 'One of Scarlett\'s self-contained adventures; preserve possessive and one-of, without inventing a particular adventure title.',
"Unlocked in Maverick's shop.": 'Maverick\'s shop as location; no purchase condition is stated.',
'Unlocked from a callout from Scarlett.': 'Callout originating from Scarlett. Preserve the callout wording; no evidence here that it means gossip, date, a phone call or spoken accusation.',
"Unlocked from one of Melody's adventures.": 'One of Melody\'s self-contained adventures; preserve possessive and one-of.',
"Unlocked from one of Oliver's adventures.": 'One of Oliver\'s self-contained adventures; preserve possessive and one-of.',
'Unlocked from a callout from Maverick.': 'Callout originating from Maverick; do not upgrade this into gossip/date/telephone mechanics.',
'Unlocked from a gossip, date with Charlotte.': 'Two comma-listed encounter labels, gossip THEN date, with Charlotte. Preserve list ambiguity without inventing AND/OR or order of unlocking.'
}
NAMES = {'Red':[1], 'Ollie':[13], 'Scarlett':[2], 'Peter':[3], 'Penny':[4], 'Bucky':[5], 'Augustus':[6], 'Mabel':[7], 'Maverick':[8], 'Dustin':[9], 'Finley':[10], 'Coyotes':[11,12], 'coyotes':[11,12], 'Oliver':[13], 'Melody':[14], 'Charlotte':[15]}


def sha(data): return hashlib.sha256(data).hexdigest()
def dump(o): return (json.dumps(o,ensure_ascii=False,indent=2)+'\n').encode()
def lines(o): return ''.join(json.dumps(r,ensure_ascii=False,separators=(',',':'))+'\n' for r in o).encode()
def unique(rows):
    m={r['id']:r for r in rows}
    assert len(m)==len(rows), 'duplicate-id'
    return m

def derive():
    pins={}; readlist=[]
    def read(p,mode='deterministic evidence read',selector=None):
        path=pathlib.Path(p);path=path if path.is_absolute() else ROOT/path
        data=path.read_bytes(); key=str(path.relative_to(ROOT)) if path.is_relative_to(ROOT) else str(path)
        pins[key]={'sha256':sha(data),'bytes':len(data)}
        readlist.append({'path':key,'mode':mode,'selector':selector})
        return data
    def j(p,mode='complete JSON metadata',selector=None): return json.loads(read(p,mode,selector))
    def jl(p,mode='parsed stable-ID join',selector=None):return [json.loads(x) for x in read(p,mode,selector).splitlines()]
    runtime=j(CHECK+'runtime-check.json');assert runtime['verified']
    rv=j(CHECK+'runtime-verification.json');assert rv['actualRuntime']['turn']=={'model':'gpt-6.1-sol','effort':'high'} and rv['actualRuntime']['session']['model_provider']=='openai' and rv['freshExecNoResumeNoFork']
    j(CHECK+'dispatch.json');read(CHECK+'brief.md','assignment')
    src=jl(BASE+'source.jsonl','complete 113-ID semantic source/context read');sm=unique(src);assert len(src)==113
    manifest=j(BASE+'manifest.json'); locales=j(BASE+'thirty-locale-coverage.json');preparedpins=j(BASE+'input-pins.json')
    cells=jl(COMPLETE+'verified/cells.jsonl','bounded three-column and same-row joins; full-file hash');cm=unique(cells)
    fields=j(COMPLETE+'verified/fields.json');rb=j(COMPLETE+'readback-validation.json')
    payload=read('assets/source-v2/text-assets/90744c19ec-resources.assets-320.bin','source bytes only; bounded cell/column reconstruction')
    assert sha(payload)==rb['wholePayloadReconstructedSha256']=='41834cda2f3ea6f010234f3ca2332e31b95b990ab38a8940b0d92f000477fda9'
    for p,h in rb['sourceAndOutputPins'].items():
        assert sha(read(p,'verified existing readback dependency fingerprint only'))==h, ('readback-pin',p)
    for p,h in preparedpins.items():assert sha(read(p,'prepared packet dependency fingerprint only'))==h['sha256'],('prepared-pin',p)
    audit=jl(AUDIT+'untranslated-display-inputs.jsonl');am=unique(audit)
    auditpins=j(AUDIT+'input-pins.json')
    for p in [SHARED+'consumer-matrix.json',COMPLETE+'verified/cells.jsonl',GLOSS+'handoff.json']:
        actual=sha(read(p,'prior source trace fingerprint reuse'))
        assert actual in [x['sha256'] for x in auditpins[str(ROOT/p)]['versions']],('prior-pin',p)
    matrix=j(SHARED+'consumer-matrix.json',selector='remainingBgColumns for Movie.hint_phrase, Chapter.title/description')
    glossary=j(GLOSS+'en.json','relevant source facts/aliases/wordplay',list(range(1,16))+[43,45,46,50,52,55,56,57,58,59,60,74,80,81,83,84,85,86,87,108,112,113,115,116,118,120,122,134,135,136,137,138,140,143])
    gm=unique(glossary); ru=j(GLOSS+'ru.json','exact existing term candidates only');handoff=j(GLOSS+'handoff.json')
    assert pins[GLOSS+'en.json']['sha256']==handoff['sourceSha256'] and pins[GLOSS+'ru.json']['sha256']==handoff['russianSha256']
    old=jl('localization/supplemental-ui/20261027/ru.jsonl','exact-source candidate search, no editorial review');om=unique(old)
    assert not set(sm)&set(om)
    assert len(locales)==30 and all(x['additionalSourceIds']==list(sm) for x in locales)
    byrow=collections.defaultdict(list)
    for c in cells:
        if c['sheet'] in ['Movie','Chapter']:byrow[(c['sheet'],c['rowId'])].append(c)
    selected=[c for c in cells if (c['sheet'],c['field']) in COLUMNS];assert len(selected)==129
    assert set(sm)=={c['id'] for c in selected if c['stored'] and c['source']}
    states=[]
    for c in selected:
        st='absent' if not c['stored'] else 'stored-empty' if c['source']=='' else 'stored-nonempty'
        if c['stored']:
            raw=base64.b64decode(c['sourceBytesBase64'],validate=True);span=c['sourceSpan']
            assert raw.decode('utf-8')==c['source'] and payload[span['offset']:span['offset']+span['bytes']]==raw
        else:assert c['source'] is c['sourceBytesBase64'] is c['sourceSpan'] is None
        states.append({**c,'admissionState':st,'disposition':'bounded-display-source' if c['stored'] else 'preserve-absent','preparedId':c['id'] if c['id'] in sm else None})
    selectedfields=[f for f in fields if (f['sheet'],f['field']) in COLUMNS]; restored=bytearray(payload)
    coverage=[]
    for f in selectedfields:
        group=[c for c in selected if c['sheetId']==f['sheetId'] and c['fieldId']==f['fieldId']]
        assert len(group)==f['rows']==COLUMNS[f['sheet'],f['field']][0]
        raw={c['rowIndex']:base64.b64decode(c['sourceBytesBase64']) for c in group if c['stored']}
        order=f['storedRowsOrder'];assert set(order)==set(raw) and len(order)==COLUMNS[f['sheet'],f['field']][1]
        end=0;index=[]
        for i in order:end+=len(raw[i]);index.append(struct.pack('<ii',i,end))
        blob=struct.pack('<i',len(order))+b''.join(index)+b''.join(raw[i] for i in order)
        assert len(blob)==f['valuesBytes'] and sha(blob)==f['valuesSha256']
        offset=f['valuesOffset'];assert payload[offset:offset+len(blob)]==blob
        restored[offset:offset+len(blob)]=blob
        coverage.append({**f,'states':len(group),'stored':len(raw),'nonempty':sum(bool(c['source']) for c in group),'storedEmpty':sum(c['stored'] and c['source']=='' for c in group),'absent':len(group)-len(raw),'absentIds':[c['id'] for c in group if not c['stored']],'sourceReconstructedExactly':True})
    assert bytes(restored)==payload
    # Bind reusable CIL to the exact unchanged original assembly; no new extraction.
    idx=j(TRACE+'managed-index/manifest.json');ui=j(TRACE+'ui-consumer-index/manifest.json');db=j(TRACE+'db-field-bindings/manifest.json')
    assert sha(read(idx['source'],'assembly hash only'))==idx['sourceSha256']==ui['sourceSha256']==db['sourceSha256']
    for n in ['database-consumer-bodies.jsonl','calls.jsonl','field-uses.jsonl']:
        assert sha(read(TRACE+'managed-index/'+n,'pinned saved CIL/metadata; exact bounded methods'))==idx['files'][n]['sha256']
    assert sha(read(TRACE+'ui-consumer-index/bodies.jsonl','pinned full setter bodies; no framework traversal'))==ui['bodiesSha256']
    assert sha(read(TRACE+'db-field-bindings/bodies.jsonl','pinned 3 wrappers, storage getters and 2 table metadata getters'))==db['bodiesSha256']
    saved=jl(TRACE+'managed-index/database-consumer-bodies.jsonl')+jl(TRACE+'ui-consumer-index/bodies.jsonl')+jl(TRACE+'db-field-bindings/bodies.jsonl')
    needles=['::CreateMovieRecord(','::CreateChapterRecord(','::GenerateMovies(','::<GenerateChapters>b__0(','GalleryHintTutorial::Start(','ChapterSelectUI::UpdateTooltipText(','GossipUIItemTemplate::SetText(','Movie::get_hint_phrase()','Movie::get__hint_phrase()','Movie::get_MetaDefault()','Chapter::get_title()','Chapter::get__title()','Chapter::get_description()','Chapter::get__description()','Chapter::get_MetaDefault()']
    evidence=[r for r in saved if any(n in r['method'] for n in needles)]
    assert len(evidence)==15
    for sheet,field in COLUMNS:
        c=next(x for x in selected if x['sheet']==sheet and x['field']==field)
        for suffix,expected in [(f'::get__{field}()',c['fieldId']),('::get_MetaDefault()',c['sheetId'])]:
            body=next(r for r in evidence if f'.DB.{sheet}{suffix}' in r['method'])
            ints=[int(i['operand'])%(1<<64) for i in body['instructions'] if i['opcode']=='ldc.i8']
            assert base64.b64encode(struct.pack('<QQ',*ints)).decode().rstrip('=')==expected
    extra=read(CHECK+'exact-consumers.il','complete exact consumer methods for cache/display predicate').decode();requests=j(CHECK+'consumer-read-requests.json');assert sha(extra.encode())==requests['outputSha256']
    filteril=read(TRACE+'consumer-bodies/ChapterSelectUI.il','FilterAvailableChapters complete; DoChapterSelect secondary title consumer').decode()
    read('localization/source/notebook-20261026/LoaderChapters.il','GenerateChapters parent/cache and original record fields')
    read('localization/source/notebook-20261026/DataService.il','GetChapterRecords and GetChapterRecordByChapter only')
    for token in ['IL_00b6: stfld','IL_00c2: stfld','IsNullOrWhiteSpace','isHiddenInList','IsTagActive','get_IsUnlocked'] : assert token in filteril
    contextrows=[];reuse=[]
    assert {r['rowIndex'] for r in src if r['family']=='chapter-title'}==set(CHAPTER)
    assert {r['source'] for r in src if r['family']=='gallery-hint'}==set(HINTS)
    for r in src:
        c=cm[r['id']];a=am[r['id']]
        assert r['source']==c['source']==a['source'] and r['sourceSpan']==c['sourceSpan']==a['sourceSpan'] and r['sourceValueSha256']==a['sourceValueSha256']
        assert sha(r['source'].encode())==r['sourceUtf8Sha256'] and sha(json.dumps(c['source'],ensure_ascii=False,separators=(',',':')).encode())==r['sourceValueSha256']
        if r['sheet']=='Chapter':
            title,ids,decision=CHAPTER[r['rowIndex']];assert r['sourceRowContext']['title']==title
            gids=[f'tfol-{i:03}' for i in ids];contract='chapter-title' if r['field']=='title' else 'chapter-description'
        else:
            decision=HINTS[r['source']];ids=[]
            for name,ni in NAMES.items():
                if name in r['source']:ids+=ni
            if 'gossip' in r['source']:ids+=[55]
            if 'date' in r['source']:ids+=[58]
            if 'adventures' in r['source']:ids+=[57]
            if 'dash challenge' in r['source']:ids+=[61,143]
            gids=[f'tfol-{i:03}' for i in sorted(set(ids))];contract='gallery-hint'
        assert set(gids)<=set(gm)
        contexts=byrow[r['sheet'],r['rowId']]
        candidates=[]
        for oldr in old:
            if oldr['source']!=r['source']:continue
            # Exact old physical selector and source value independently verified.
            orig=cm[oldr['id']];assert orig['source']==r['source']
            item={'destinationId':r['id'],'sourceUtf8Sha256':r['sourceUtf8Sha256'],'candidateKind':'same-source-different-physical-selector','artifact':'localization/supplemental-ui/20261027/ru.jsonl','artifactSha256':pins['localization/supplemental-ui/20261027/ru.jsonl']['sha256'],'existingId':oldr['id'],'existingSourceSpan':orig['sourceSpan'],'source':oldr['source'],'target':oldr['target'],'targetUtf8Sha256':sha(oldr['target'].encode()),'physicalSelectorBound':False,'independentEditorialAcceptanceForDestination':False}
            reuse.append(item);candidates.append(len(reuse)-1)
        for term in glossary:
            if term['term']!=r['source']:continue
            item={'destinationId':r['id'],'sourceUtf8Sha256':r['sourceUtf8Sha256'],'candidateKind':'exact-approved-glossary-term','artifact':GLOSS+'ru.json','artifactSha256':pins[GLOSS+'ru.json']['sha256'],'sourceArtifact':GLOSS+'en.json','sourceArtifactSha256':pins[GLOSS+'en.json']['sha256'],'existingId':term['id'],'source':term['term'],'target':ru[term['id']]['term'],'targetUtf8Sha256':sha(ru[term['id']]['term'].encode()),'physicalSelectorBound':False,'independentEditorialAcceptanceForDestination':False}
            reuse.append(item);candidates.append(len(reuse)-1)
        contextrows.append({**r,'contractId':contract,'sourceDecision':decision,'glossaryIds':gids,'glossarySourceFacts':[gm[k] for k in gids],'contextCellIds':[c['id'] for c in contexts],'applicationSelector':{k:r[k] for k in ['sheetId','fieldId','rowId','rowIndex']},'reuseCandidateIndexes':candidates,'targetAuthored':False,'sourceClassification':'stored-display-prose','parserContract':'No dialogue parser, callback decoder or unlock-logic parser on this field path. Keep authored prose free of new TMP markup/placeholders; retain source punctuation/semantic list distinctions. TMP processing/rendering is an external delivery boundary.','runtimeReachabilityAccepted':False})
    assert len(contextrows)==len(unique(contextrows))==113
    assert collections.Counter(x['candidateKind'] for x in reuse)=={'same-source-different-physical-selector':5,'exact-approved-glossary-term':7}
    # Operational refs loaded in this fresh context; record exact current versions.
    refs=['AGENTS.md','/Users/antonkrutov/.codex/instructions/sitefor-mods.md','/Users/antonkrutov/.codex/instructions/game-localization-prompt.md','/Users/antonkrutov/.codex/instructions/game-localization-audit-workflow.md']
    for skill in ['vn-localization','vn-game-assets']:
        refs.append(f'/Users/antonkrutov/.codex/skills/{skill}/SKILL.md')
    refs += [f'/Users/antonkrutov/.codex/skills/vn-localization/references/{n}.md' for n in ['COMMON','ROUTING','CHECKPOINT']]
    refs += [f'/Users/antonkrutov/.codex/skills/vn-game-assets/references/{n}.md' for n in ['WORKFLOW','SPECIAL-SCENES','HANDOFF']]
    for p in refs:read(p,'mandatory instructions read; current fingerprint')
    read('tools/gallery_chapter_sources.py','unchanged preparation recipe inspected; --check verified separately')
    read('tools/russian_actor_names.py','existing sparse-column application/restoration mechanism design reference')
    read('tools/russian_preview_ui.py','load_bg_parser boundary and exact before/after comparison design reference')
    read('localization/source/bgdatabase-complete-values-20261027/verify_complete.py','existing byte readback/restoration recipe inspected, not rerun')
    read('tools/gallery_chapter_admission.py','this reproducible recipe')
    products={'column-states.jsonl':lines(states),'column-coverage.json':dump(coverage),'consumer-context.jsonl':lines(contextrows),'consumer-evidence.jsonl':lines(evidence),'row-context-cells.jsonl':lines([c for c in cells if c['sheet'] in ['Movie','Chapter']]),'reuse-candidates.json':dump({'scope':'Exact source matches in pinned old935 Russian packet and repaired glossary only; not a search/acceptance claim over every historical Russian artifact.','candidates':reuse,'count':len(reuse),'destinationIds':len({x['destinationId'] for x in reuse}),'allCandidatesNeedDestinationReview':True}),'input-pins.json':dump(pins),'read-list.json':dump(readlist)}
    return products, {'states':129,'storedNonempty':113,'absent':16,'storedEmpty':0,'columnsReconstructed':3,'wholePayloadSourceReconstructionSha256':sha(bytes(restored)),'sourceCellReadback':113,'metadataTableFieldIdsChecked':5,'preparedInputPinsVerified':len(preparedpins),'sourceContextRows':113,'candidateRecords':12,'candidateDestinationIds':7,'targetProjectionRun':False,'runtime':'not-run','validationBoundary':'Static exact source bytes, sparse membership, spans, source/context joins, original method evidence and fingerprints. Source-only reconstruction is not a target projection/restoration test.'}

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--check',action='store_true');a=p.parse_args()
    products,validation=derive();products['validation.json']=dump({'status':'passed-static-bounded',**validation})
    if a.check:
        for name,data in products.items():assert (OUT/name).read_bytes()==data,('reproduction-mismatch',name)
        print(json.dumps({'status':'verified','generatedProducts':len(products),**validation}));return
    assert not OUT.exists(),'append-only: reconcile existing admission before writing'
    OUT.mkdir()
    for name,data in products.items():(OUT/name).write_bytes(data)
    print(json.dumps({'status':'source-products-written','generatedProducts':len(products),**validation}))

if __name__=='__main__':main()
