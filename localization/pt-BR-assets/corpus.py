"""Deterministic storage/inspection only. All target wording is model-authored TSV; locale is explicit configuration."""
import hashlib, json, pathlib, re, sys

ROOT = pathlib.Path(__file__).resolve().parents[2]
HERE = pathlib.Path(__file__).resolve().parent
CONFIG = json.loads((HERE/'locale.json').read_text())
LOCALE = CONFIG['locale']
assert LOCALE and CONFIG['sourceLocale']=='en' and HERE.name==LOCALE+'-assets', 'Explicit matching locale required'
OUT = ROOT / CONFIG['jobDirectory']
OVERLAY = 'dialogue.'+LOCALE+'.jsonl'
def sha(b): return hashlib.sha256(b).hexdigest()
def dump(p, value):
    raw = (json.dumps(value, ensure_ascii=False, indent=2) + '\n').encode()
    temp = p.with_suffix(p.suffix + '.tmp')
    temp.write_bytes(raw); temp.replace(p)
def pins():
    expected = json.loads((OUT/'input-pins.json').read_text())
    actual = {p:sha(pathlib.Path(p).read_bytes()) for p in expected}
    assert actual == expected, 'Pinned input changed'
    return actual
PINS = pins()
MAN = json.loads((ROOT/'localization/source/dialogue-manifest.json').read_text())
ROWS = [json.loads(s) for s in (ROOT/'localization/source/dialogue-candidates.jsonl').read_text().splitlines()]
BYID = {r['id']:r for r in ROWS}
assert len(BYID) == len(ROWS) == MAN['candidateUnits']
TREES=[]
for s in MAN['sources']:
    raw=(ROOT/s['tree']).read_bytes(); assert sha(raw)==s['treeSha256']
    TREES.append(json.loads(raw))
assert TREES[0]['conversations']==TREES[1]['conversations']
def bracket_end(text, start):
    depth=1; i=start+1; quote=None
    while i<len(text) and depth:
        c=text[i]
        if quote:
            if c=='\\':
                i+=2; continue
            if c==quote: quote=None
        elif c in '\"\'': quote=c
        elif c=='[': depth+=1
        elif c==']': depth-=1
        i+=1
    assert depth==0, 'Unbalanced bracket'
    return i

def recognized_bracket(text):
    # Conservative guard against converting a whole engine tag into display prose.
    return bool(re.match(r'^\[(?:lua\(|var=|autocase=|pic[ac]?=|position(?:=|\s)|pos=|panel=|em\d|/em|a\]|f\]|auto\]|nosubtitle\]|input)', text, re.I))

def scan(text, display_ordinals=()):
    """Unknown brackets are opaque. Only source-approved outer spans expose prose.

    Nested brackets inside approved prose still remain exact opaque tokens, including
    quoted/nested Lua operands. The returned visible text permits numeric checks
    inside approved prose as well as outside all other controls.
    """
    found=[]; visible=[]; i=0; ordinal=0; seen=set()
    while i<len(text):
        if text[i]=='[':
            end=bracket_end(text,i); token=text[i:end]
            if ordinal in display_ordinals:
                assert not recognized_bracket(token), 'Approved display span became an engine control'
                nested,inner=scan(token[1:-1])
                found.extend(['[',*nested,']']); visible.append(inner); seen.add(ordinal)
            else: found.append(token)
            ordinal+=1; i=end
        elif text[i]==']':
            # Two pinned source fields contain a literal unmatched closing bracket.
            # Preserve it exactly rather than rejecting or silently repairing source.
            found.append(']'); i+=1
        elif text[i]=='<' and re.match(r'</?[A-Za-z][^>]*>',text[i:]):
            end=text.index('>',i)+1; found.append(text[i:end]); i=end
        elif text[i]=='{' and '}' in text[i:]:
            end=text.index('}',i)+1; found.append(text[i:end]); visible.append(text[i:end]); i=end
        else: visible.append(text[i]); i+=1
    assert seen==set(display_ordinals), 'Missing approved bracket delimiter/span'
    return found,''.join(visible)

def controls(text, display_ordinals=()):
    return scan(text,display_ordinals)[0]

def verify_file(binding):
    p=ROOT/binding['path']
    assert sha(p.read_bytes())==binding['sha256'], 'Display/hold evidence hash mismatch: '+binding['path']

def load_display_spans():
    manifest=json.loads((HERE/'display-spans.json').read_text())
    assert manifest['schemaVersion']==1 and manifest['locale']==LOCALE
    verify_file(manifest['sourceInventory']); verify_file(manifest['decisionSnapshot'])
    snapshot=json.loads((ROOT/manifest['decisionSnapshot']['path']).read_text())
    assert snapshot['provenanceCommit']==manifest['decisionSnapshot']['provenanceCommit']
    decisions={r['id']:r for r in snapshot['records']}
    for evidence in manifest['consumerEvidence']: verify_file(evidence)
    approved={}
    for record in manifest['records']:
        ident=record['id']; source=BYID[ident]; decision=decisions[ident]
        assert ident not in approved, 'Duplicate display approval'
        assert record['sourceSha256']==sha(source['source'].encode())==decision['sourceSha256'], 'Display source binding mismatch'
        assert record['pointer']==source['pointer'] and record['occurrences']==source['occurrences'], 'Display occurrence binding mismatch'
        assert record['disposition']==decision['disposition']=='translatable-bracketed-display'
        assert record['ordinaryBracketOrdinals']==decision['ordinaryBracketOrdinals'], 'Unapproved bracket ordinal'
        brackets=[]; i=0
        while i<len(source['source']):
            if source['source'][i]=='[':
                end=bracket_end(source['source'],i); brackets.append((i,end)); i=end
            else: i+=1
        assert len(record['spans'])==len(record['ordinaryBracketOrdinals'])
        for span,ordinal in zip(record['spans'],record['ordinaryBracketOrdinals']):
            assert span['ordinal']==ordinal and brackets[ordinal]==(span['start'],span['end'])
            assert source['source'][span['start']:span['end']]==span['source']
            assert span['delimiters']==['[',']'] and not recognized_bracket(span['source'])
        controls(source['source'],record['ordinaryBracketOrdinals'])
        approved[ident]=tuple(record['ordinaryBracketOrdinals'])
    return approved

DISPLAY_SPANS=load_display_spans()

def validate_pair(row,target):
    ident=row['id']; source=row['source']; ordinals=DISPLAY_SPANS.get(ident,())
    protected,source_visible=scan(source,ordinals)
    target_protected,target_visible=scan(target,ordinals)
    assert protected==target_protected, ident+' protected control mismatch'
    for separator in ('\n','\r','|'):
        assert source.count(separator)==target.count(separator),(ident,'line separator mismatch',repr(separator))
    assert re.findall(r'\d+',source_visible)==re.findall(r'\d+',target_visible), ident+' number mismatch'
    for tree in TREES:
        value=tree
        for k in row['pointer'].strip('/').split('/'): value=value[int(k)] if isinstance(value,list) else value[k]
        assert value==source,ident+' source binding mismatch'

def load_hold_resolutions():
    data=json.loads((HERE/'hold-resolutions.json').read_text())
    assert data['schemaVersion']==1 and data['locale']==LOCALE
    resolutions={}
    for receipt in data['resolutions']:
        ident=receipt['id']; assert ident not in resolutions and ident in DISPLAY_SPANS
        assert receipt['sourceSha256']==sha(BYID[ident]['source'].encode()), 'Hold source binding mismatch'
        verify_file(receipt['proposal']); verify_file(receipt['displayManifest'])
        proposals=json.loads((ROOT/receipt['proposal']['path']).read_text())['held']
        proposal=next(p for p in proposals if p['id']==ident)
        assert proposal['sourceSha256']==receipt['sourceSha256'] and proposal['targetSha256']==receipt['targetSha256'] and proposal['authoredTargetPendingAdapter']==receipt['target'], 'Authored proposal binding mismatch'
        verify_file({'path':receipt['heldBatch'],'sha256':receipt['heldBatchSha256']})
        verify_file({'path':receipt['targetBatch'],'sha256':receipt['targetBatchSha256']})
        assert receipt['previousHeldLine'] in (ROOT/receipt['heldBatch']).read_text().splitlines()
        assert receipt['previousHeldLine'].split('\t',1)[1]=='!HOLD '+receipt['previousReason']
        assert sha(receipt['target'].encode())==receipt['targetSha256']
        assert receipt['reason'].strip()
        resolutions[ident]=receipt
    return resolutions
def show(start,count):
    for ci,c in enumerate(TREES[0]['conversations'][start:start+count],start):
        print('\nCONV',ci,c['id'],c['fields'][0]['value'])
        for e in c['dialogueEntries']:
            f={v['title']:v['value'] for v in e['fields']}
            links=[str(x['destinationConversationID'])+':'+str(x['destinationDialogueID']) for x in e['outgoingLinks']]
            txt={k:v for k,v in f.items() if v and k in ['Title','Dialogue Text','Menu Text','Sequence','Parenthetical']}
            print(e['id'],f.get('Actor'),'>',f.get('Conversant'),json.dumps(txt,ensure_ascii=False),'->',','.join(links),'COND',e['conditionsString'],'SCRIPT',e['userScript'])
def build():
    targets={}; held={}; batches=[]
    resolutions=load_hold_resolutions(); resolved_holds=set()
    reasons_path=HERE/'unchanged-reasons.json'
    unchanged_reasons=json.loads(reasons_path.read_text()) if reasons_path.exists() else {}
    hp=HERE/'hold-groups.json'
    if hp.exists():
        for group in json.loads(hp.read_text()):
            for key in group['ids'].split():
                ident='ds:'+key+':Dialogue Text'
                assert ident in BYID and ident not in held
                held[ident]=group['reason']
    for p in sorted((HERE/'batches').glob('*.tsv')):
        n=0
        for line in p.read_text().splitlines():
            if not line or line.startswith('#'): continue
            key,text=line.split('\t',1)
            parts=key.split(':'); ident='ds:'+':'.join(parts[:2])+':'+('Menu Text' if len(parts)>2 and parts[2]=='M' else 'Dialogue Text')
            assert ident in BYID, ident
            r=BYID[ident]
            assert ident not in targets and ident not in held, ident
            if text.startswith('!HOLD '):
                if ident in resolutions:
                    receipt=resolutions[ident]
                    assert str(p.relative_to(ROOT))==receipt['heldBatch'] and line==receipt['previousHeldLine'], 'Hold receipt mismatch'
                    resolved_holds.add(ident)
                else: held[ident]=text[6:]
                continue
            text=text.replace('\\n','\n').replace('\\r','\r').replace('\\t','\t')
            prefix=re.match(r'^(?:\[pic[ac]?=[0-9A-Za-z_]+\])*',r['source']).group()
            target=prefix+text
            if r['source'].endswith('\r') and not target.endswith('\r'): target+='\r'
            visible_source=scan(r['source'],DISPLAY_SPANS.get(ident,()))[1]
            punctuation_only=not re.search(r'[^\W\d_]',visible_source)
            assert target.strip(), ident+' empty target'
            assert target!=r['source'] or punctuation_only or unchanged_reasons.get(ident), ident+' unchanged visible text requires an individual reason'
            validate_pair(r,target)
            if ident in resolutions:
                receipt=resolutions[ident]
                assert str(p.relative_to(ROOT))==receipt['targetBatch'] and sha(target.encode())==receipt['targetSha256'], 'Resolved target receipt mismatch'
            targets[ident]={**r,'sourceSha256':sha(r['source'].encode()),'target':target,'targetSha256':sha(target.encode()),'status':'edited-provisional','batch':p.stem,'review':'Immediate source-to-target editing by author; independent audit pending'}
            if target==r['source']: targets[ident]['unchangedReason']=unchanged_reasons.get(ident,'Expressive punctuation contains no translatable words; preserved at this exact occurrence.')
            n+=1
        batches.append({'path':str(p.relative_to(ROOT)),'sha256':sha(p.read_bytes()),'authoredEditedIds':n})
    assert resolved_holds==set(resolutions) and all(i in targets and i not in held for i in resolutions), 'Incomplete hold resolution'
    ordered=[targets[r['id']] for r in ROWS if r['id'] in targets]
    data=''.join(json.dumps(r,ensure_ascii=False,separators=(',',':'))+'\n' for r in ordered).encode()
    temp=HERE/(OVERLAY+'.tmp');temp.write_bytes(data);temp.replace(HERE/OVERLAY)
    unresolved=[{'id':r['id'],'reason':held[r['id']]} for r in ROWS if r['id'] in held]
    dump(HERE/'unresolved.json',unresolved)
    complete=[]
    for c in TREES[0]['conversations']:
        ids=[r['id'] for r in ROWS if r['conversationId']==c['id']]
        if ids and all(i in targets or i in held for i in ids):complete.append(c['id'])
    progress={'game':'The Forest of Love','build':'0.45','locale':LOCALE,'stage':'translate-edit','mode':'owner-authorized parallel provisional drafting','model':{'name':'gpt-6.1-sol','reasoning':'high','provider':'openai'},'inputHashes':PINS,'sourceFamily':{'logicalCandidates':len(ROWS),'physicalOccurrences':MAN['physicalOccurrences'],'conversations':MAN['conversations'],'wholeGameDenominator':None},'authoredIds':len(ordered),'immediatelyEditedIds':len(ordered),'boundOccurrences':sum(len(r['occurrences']) for r in ordered),'explicitHeldIds':len(held),'remainingUnauthoredIds':len(ROWS)-len(ordered),'processedConversations':complete,'lastAuthoredId':ordered[-1]['id'] if ordered else None,'lastScene':ordered[-1]['conversation'] if ordered else None,'overlay':{'path':str((HERE/OVERLAY).relative_to(ROOT)),'sha256':sha(data)},'batches':batches,'syntaxValidation':{'status':'passed for authored subset','checkedIds':len(ordered),'sourcePointerBothCopies':'exact equality','controls':'balanced brackets with nested/quoted operands, angle tags and brace placeholders; exact ordered equality','numericLiterals':'exact ordered equality outside tags','fullEngineGrammar':'pending shared source classification; no reinsertion performed'},'acceptance':{'source':'needs-review','probe':'pending owning renderer lane','specialScenes':'pending; drafting exception only','fullSemanticAudit':'not-run','independentDiffAudit':'not-run','resources':'not-run','runtime':'not-run','canonicalIntegration':'pending renderer worker Git ownership'},'usage':{'status':'unavailable in worker tools; launcher records telemetry separately'}}
    progress['sourceFamily']['whitespaceDelimitedWords']=sum(len(r['source'].split()) for r in ROWS)
    progress['authoredSourceWhitespaceWords']=sum(len(r['source'].split()) for r in ordered)
    progress['translatedWordingIds']=sum('unchangedReason' not in r for r in ordered)
    progress['reviewedUnchangedPunctuationIds']=sum('unchangedReason' in r for r in ordered)
    progress['reviewedUnchangedIds']=progress['reviewedUnchangedPunctuationIds']
    progress['countDefinitions']={'translatedWordingIds':'Real targets different from source','reviewedUnchangedIds':'Individually justified source-equal targets, including names, encoded speech and punctuation','reviewedUnchangedPunctuationIds':'Legacy alias of reviewedUnchangedIds; includes more than punctuation','technicalPreservedIds':'Detached technical preservation records; none in this pt-BR resolution'}
    progress['syntaxValidation']['status']='passed all pinned candidates' if len(ordered)==len(ROWS) and not held else 'passed for authored subset'
    progress['syntaxValidation']['exactProtectedTokens']=sum(len(controls(r['source'],DISPLAY_SPANS.get(r['id'],()))) for r in ordered)
    progress['syntaxValidation']['controls']='Exact opaque controls, nested/quoted Lua, tags and placeholders; only source/evidence/occurrence-bound display spans expose prose with exact bracket delimiters'
    progress['syntaxValidation']['displaySpanManifestSha256']=sha((HERE/'display-spans.json').read_bytes())
    progress['syntaxValidation']['holdResolutionsSha256']=sha((HERE/'hold-resolutions.json').read_bytes())
    progress['technicalPreservedIds']=0
    progress['resolvedHoldIds']=sorted(resolved_holds)
    progress['heldIds']=sorted(held)
    progress['unvisitedIds']=len(ROWS)-len(targets)-len(held)
    progress['draftStatus']='draft-complete for provisional dialogue family only' if len(targets)==len(ROWS) and not held else 'in-progress'
    progress['poetryValidation']={'status':'pending check_poetry.py for rebuilt overlay','overlaySha256':sha(data)}
    progress['syntaxValidation']['lineSeparators']='Exact counts of LF, CR and pipe separators'
    progress['processBinding']='README.md fixed translate-edit stage; existing CHECKPOINT.json remains owned by renderer lane'
    dump(OUT/'progress.json',progress)
    artifacts=[{'path':str(p.relative_to(ROOT)),'sha256':sha(p.read_bytes())} for p in sorted(HERE.rglob('*')) if p.is_file() and not p.name.endswith('.tmp')]
    dump(OUT/'result.json',{'outcome':'draft-complete' if len(targets)==len(ROWS) and not held else 'continue','scope':'provisional dialogue family only','authoredIds':len(ordered),'editedIds':len(ordered),'translatedWordingIds':progress['translatedWordingIds'],'reviewedUnchangedIds':progress['reviewedUnchangedIds'],'reviewedUnchangedPunctuationIds':progress['reviewedUnchangedPunctuationIds'],'technicalPreservedIds':0,'sourceFamilyCounts':progress['sourceFamily'],'heldIds':len(held),'remainingUnauthoredIds':progress['remainingUnauthoredIds'],'outputs':artifacts,'syntaxValidation':progress['syntaxValidation'],'poetryValidation':progress['poetryValidation'],'remainingGates':progress['acceptance'],'continuation':'Read continuation.md; preserve all saved targets. Full semantic, independent and runtime acceptance remains pending.','usage':progress['usage']})
    assert pins()==PINS
    nextrow=next((r for r in ROWS if r['id'] not in targets and r['id'] not in held),None)
    (OUT/'continuation.md').write_text('Portuguese (Brazil), exact locale pt-BR. Stage: translate-edit, provisional dialogue family only. Read contract.md and input-pins.json; verify actual model argv before localization inputs. No agents, nested model jobs or Git writes. Reuse the saved pt-BR wording and source-bound display-spans.json / hold-resolutions.json receipts; old TSV hold lines remain preserved.\n\nNext unauthored ID: '+(nextrow['id']+'; scene '+nextrow['conversation'] if nextrow else 'none')+'\n\nAuthored/edited: '+str(len(ordered))+'/'+str(len(ROWS))+'. Explicit holds: '+str(len(held))+'. Rebuild with python3 localization/pt-BR-assets/corpus.py build; after every rebuild run python3 localization/pt-BR-assets/check_poetry.py. All acceptance gates remain as recorded in progress.json. Full semantic and independent diff audits, resources, runtime and canonical integration are pending.\n')
    print(json.dumps({'authoredEdited':len(ordered),'held':len(held),'processedConversations':len(complete),'next':nextrow['id'] if nextrow else None,'sha256':sha(data)}))
if __name__=='__main__':
    if sys.argv[1]=='show':show(int(sys.argv[2]),int(sys.argv[3]))
    elif sys.argv[1]=='build':build()
