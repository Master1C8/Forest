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
def controls(text, ordinary=()):
    # Balanced bracket scan preserves nested Lua array operands as one exact token.
    found=[]; i=0; ordinal=0
    while i<len(text):
        if text[i]=='[':
            start=i; depth=1; i+=1; quote=None
            while i<len(text) and depth:
                c=text[i]
                if quote:
                    if c==quote and text[i-1]!='\\': quote=None
                elif c in '\"\'': quote=c
                elif c=='[': depth+=1
                elif c==']': depth-=1
                i+=1
            assert depth==0, 'Unbalanced bracket'
            if ordinal in ordinary:
                # Only occurrence/source/evidence-bound prose may expose its body.
                # Nested quoted Lua and unknown bracket tokens remain opaque.
                body=text[start+1:i-1]
                assert not re.match(r'(?:pic[ac]?=|lua\(|var=|autocase=|position[ =]|panel=|/?em\d|a$|f$|auto$|nosubtitle$)',body), 'Ordinary span became engine control'
                found.extend(['[', *controls(body), ']'])
            else:
                found.append(text[start:i])
            ordinal+=1
        elif text[i]=='<' and re.match(r'</?[A-Za-z][^>]*>',text[i:]):
            end=text.index('>',i)+1; found.append(text[i:end]); i=end
        elif text[i]=='{' and '}' in text[i:]:
            end=text.index('}',i)+1; found.append(text[i:end]); i=end
        elif text[i]==']' and ordinary:
            raise AssertionError('Unbalanced ordinary bracket delimiter')
        else: i+=1
    return found

def load_dispositions():
    path=HERE/'source-dispositions.json'
    if not path.exists(): return {}
    records=json.loads(path.read_text())
    verified=set()
    for ident,record in records.items():
        assert ident in BYID and record['sourceSha256']==sha(BYID[ident]['source'].encode()), ident+' disposition source mismatch'
        evidence=ROOT/record['evidencePath']
        assert sha(evidence.read_bytes())==record['evidenceSha256'], ident+' disposition evidence mismatch'
        pin_path=ROOT/record['evidencePins']
        assert sha(pin_path.read_bytes())==record['evidencePinsSha256'], ident+' evidence pin manifest changed'
        if pin_path not in verified:
            for name,digest in json.loads(pin_path.read_text()).items():
                assert sha((ROOT/name).read_bytes())==digest, name+' consumer evidence changed'
            verified.add(pin_path)
    return records

DISPOSITIONS=load_dispositions()

def ordinary_for(row):
    record=DISPOSITIONS.get(row['id'],{})
    if record.get('disposition')!='translatable-bracketed-display': return ()
    assert record['sourceSha256']==sha(row['source'].encode()), row['id']+' ordinary source mismatch'
    return tuple(record['ordinaryBracketOrdinals'])

def controls_for(row,text): return controls(text,ordinary_for(row))

def validate_text(row,target):
    ident=row['id']; source=row['source']; ordinary=ordinary_for(row)
    assert controls_for(row,source)==controls_for(row,target), (ident,'protected control mismatch',controls_for(row,source),controls_for(row,target))
    for separator in ('\n','\r','|'):
        assert source.count(separator)==target.count(separator),(ident,'line separator mismatch',repr(separator))
    def numeric(text):
        # The two approved ordinary brackets each occupy the entire field.
        if ordinary:
            assert ordinary==(0,) and text.startswith('[') and text.endswith(']'), ident+' ordinary span boundary mismatch'
            text=text[1:-1]
        return re.findall(r'\d+',re.sub(r'\[[^\]]*\]|<[^>]*>','',text))
    assert numeric(source)==numeric(target), ident+' number mismatch'
    record=DISPOSITIONS.get(ident,{})
    if record.get('disposition')=='preserved-detached-source':
        assert target==source==record['preserveExactly'], ident+' technical source preservation mismatch'

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
    resolution_path=HERE/'hold-resolutions.json'
    resolutions=json.loads(resolution_path.read_text()) if resolution_path.exists() else {}
    used_resolutions=set()
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
            assert ident not in targets, ident+' duplicate target'
            if text.startswith('!HOLD '): held[ident]=text[6:]; continue
            resolution=resolutions.get(ident)
            if ident in held:
                assert resolution and resolution['resolutionBatch']==p.stem, ident+' unresolved duplicate hold'
                assert resolution['oldHoldReasonSha256']==sha(held[ident].encode()), ident+' original hold changed'
                assert resolution['sourceSha256']==sha(r['source'].encode()), ident+' resolution source changed'
                assert sha((ROOT/resolution['evidencePath']).read_bytes())==resolution['evidenceSha256'], ident+' resolution evidence changed'
            else:
                assert not resolution, ident+' resolution must replace a real held occurrence'
            text=text.replace('\\n','\n').replace('\\r','\r').replace('\\t','\t')
            prefix=re.match(r'^(?:\[pic[ac]?=[0-9A-Za-z_]+\])*',r['source']).group()
            target=prefix+text
            if r['source'].endswith('\r') and not target.endswith('\r'): target+='\r'
            visible_source=re.sub(r'\[[^\]]*\]|<[^>]*>','',r['source'])
            punctuation_only=not re.search(r'[^\W\d_]',visible_source)
            assert target.strip(), ident+' empty target'
            technical=DISPOSITIONS.get(ident,{}).get('disposition')=='preserved-detached-source'
            assert target!=r['source'] or punctuation_only or unchanged_reasons.get(ident) or technical, ident+' unchanged visible text requires an individual reason'
            validate_text(r,target)
            if resolution:
                assert sha(target.encode())==resolution['targetSha256'], ident+' resolution target changed'
                assert technical==(resolution['kind']=='technical-source-preservation'), ident+' resolution kind mismatch'
            for tree in TREES:
                value=tree
                for k in r['pointer'].strip('/').split('/'): value=value[int(k)] if isinstance(value,list) else value[k]
                assert value==r['source'],ident+' source binding mismatch'
            targets[ident]={**r,'sourceSha256':sha(r['source'].encode()),'target':target,'targetSha256':sha(target.encode()),'status':'edited-provisional','batch':p.stem,'review':'Immediate source-to-target editing by author; independent audit pending'}
            if technical:
                targets[ident].update(status='preserved-detached-source-provisional',technicalPreservationReason=DISPOSITIONS[ident]['reason'],review='Individual source/consumer preservation proposal; no translated wording or runtime acceptance credited')
            elif target==r['source']: targets[ident]['unchangedReason']=unchanged_reasons.get(ident,'Expressive punctuation contains no translatable words; preserved at this exact occurrence.')
            if resolution:
                del held[ident]; used_resolutions.add(ident)
            n+=1
        batches.append({'path':str(p.relative_to(ROOT)),'sha256':sha(p.read_bytes()),'authoredEditedIds':n})
    assert used_resolutions==set(resolutions), 'Unused hold resolution receipt'
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
    progress['technicalPreservedIds']=sum('technicalPreservationReason' in r for r in ordered)
    progress['translatedWordingIds']=sum('unchangedReason' not in r and 'technicalPreservationReason' not in r for r in ordered)
    progress['reviewedUnchangedIds']=sum('unchangedReason' in r for r in ordered)
    progress['reviewedUnchangedPunctuationIds']=sum('unchangedReason' in r and not re.search(r'[^\W\d_]',re.sub(r'\[[^\]]*\]|<[^>]*>','',r['source'])) for r in ordered)
    progress['reviewedUnchangedWordingIds']=progress['reviewedUnchangedIds']-progress['reviewedUnchangedPunctuationIds']
    progress['savedCandidateIds']=len(ordered)
    progress['immediatelyEditedIds']=len(ordered)-progress['technicalPreservedIds']
    progress['coverageCounts']={'translatedWording':progress['translatedWordingIds'],'reviewedUnchanged':progress['reviewedUnchangedIds'],'technicalSourcePreservation':progress['technicalPreservedIds'],'totalSavedCandidates':len(ordered),'pinnedCandidates':len(ROWS)}
    assert sum(progress['coverageCounts'][k] for k in ('translatedWording','reviewedUnchanged','technicalSourcePreservation'))==len(ordered)
    progress['syntaxValidation']['exactProtectedTokens']=sum(len(controls_for(r,r['source'])) for r in ordered)
    progress['syntaxValidation']['controls']='Exact ordered controls, with occurrence/source/evidence-bound ordinary bracket spans; nested Lua/unknown brackets, markup and placeholders remain protected'
    progress['syntaxValidation']['status']='passed for all pinned candidates' if len(ordered)==len(ROWS) else 'passed for saved subset'
    progress['syntaxValidation']['lineSeparators']='Exact counts of LF, CR and pipe separators'
    progress['processBinding']='README.md fixed translate-edit stage; existing CHECKPOINT.json remains owned by renderer lane'
    progress['openAcceptanceIssues']=[{'id':'finley-roommate-glossary-conflict','status':'OPEN','evidence':'localization/es-assets/PRIMARY-SOURCE-RULING-0033.md','decision':'Primary source meaning retained provisionally. Protected glossary correction and dependent glossary/editorial acceptance remain pending.'},{'id':'detached-source-consumer-proposals','status':'OPEN shared integration; runtime not-run','evidence':'localization/es-assets/source-dispositions.json'}]
    progress['remainingUnvisitedIds']=len(ROWS)-len(targets)-len(held)
    progress['allPinnedIdsVisited']=progress['remainingUnvisitedIds']==0
    progress['next']=next((r['id'] for r in ROWS if r['id'] not in targets and r['id'] not in held),None)
    progress['draftStatus']='draft-complete' if len(ordered)==len(ROWS) and not held else 'continue'
    dump(OUT/'progress.json',progress)
    artifacts=[{'path':str(p.relative_to(ROOT)),'sha256':sha(p.read_bytes())} for p in sorted(HERE.rglob('*')) if p.is_file() and not p.name.endswith('.tmp')]
    dump(OUT/'result.json',{'outcome':progress['draftStatus'],'authoredIds':len(ordered),'editedIds':progress['immediatelyEditedIds'],'coverageCounts':progress['coverageCounts'],'sourceFamilyCounts':progress['sourceFamily'],'heldIds':len(held),'remainingUnauthoredIds':progress['remainingUnauthoredIds'],'outputs':artifacts,'syntaxValidation':progress['syntaxValidation'],'remainingGates':progress['acceptance'],'openAcceptanceIssues':progress['openAcceptanceIssues'],'continuation':'Follow continuation.md; provisional dialogue-family drafting is separate from all final acceptance gates.','usage':progress['usage']})
    assert pins()==PINS
    nextrow=next((r for r in ROWS if r['id'] not in targets and r['id'] not in held),None)
    (OUT/'continuation.md').write_text('# '+CONFIG['language']+' ('+LOCALE+') provisional asset draft\n\nRead contract.md, input-pins.json and progress.json. Verify gpt-6.1-sol/high/OpenAI argv before linguistic input; never Astra/fallback. Fresh context, no agents, nested model jobs, Git or shared writes.\n\nSaved candidates: '+str(len(ordered))+'/'+str(len(ROWS))+'. Coverage: '+json.dumps(progress['coverageCounts'])+'. Explicit drafting holds: '+str(len(held))+'. Next unvisited: '+(nextrow['id'] if nextrow else 'none')+'.\n\nRebuild using python3 localization/'+LOCALE+'-assets/corpus.py build, then python3 localization/'+LOCALE+'-assets/check_poetry.py. Saved original TSV streams remain unchanged; hold-resolutions.json authorizes the new source/evidence-bound resolution batch. The adapter preserves technical records separately from linguistic coverage.\n\nPRIMARY-SOURCE INTERPRETATION RULING: localization/es-assets/PRIMARY-SOURCE-RULING-0033.md retains Charlotte/Melody source meaning and Finley he/him. Canonical tfol-010 still says Claire/Violet and is NOT corrected or newly accepted. This is an OPEN source/glossary/editorial issue. Source dispositions remain provisional; runtime not-run.\n\nNo repeat drafting phase is needed when every candidate is saved. Continue with separately scoped acceptance work; all shared source, special-scene, full semantic, independent-diff, fonts/resources/runtime and delivery gates remain pending in progress.json. No whole-game completion claim.\n')
    print(json.dumps({'authoredEdited':len(ordered),'held':len(held),'processedConversations':len(complete),'next':nextrow['id'] if nextrow else None,'sha256':sha(data)}))
if __name__=='__main__':
    if sys.argv[1]=='show':show(int(sys.argv[2]),int(sys.argv[3]))
    elif sys.argv[1]=='build':build()
