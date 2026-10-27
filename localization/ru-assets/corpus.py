"""Deterministic storage/inspection only. All Russian wording is model-authored TSV."""
import hashlib, json, pathlib, re, sys
from inline_guard import controls, load_dispositions, validate_preserve_manifest, validate_target

ROOT = pathlib.Path(__file__).resolve().parents[2]
HERE = pathlib.Path(__file__).resolve().parent
OUT = ROOT / 'outputs/ru-assets-parallel-20261026'
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
DISPOSITIONS = load_dispositions(HERE/'source-dispositions.json', ROOT, BYID)
validate_preserve_manifest(HERE/'preserve-exactly.json', HERE/'source-dispositions.json', DISPOSITIONS, BYID)
def show(start,count):
    for ci,c in enumerate(TREES[0]['conversations'][start:start+count],start):
        print('\nCONV',ci,c['id'],c['fields'][0]['value'])
        for e in c['dialogueEntries']:
            f={v['title']:v['value'] for v in e['fields']}
            links=[str(x['destinationConversationID'])+':'+str(x['destinationDialogueID']) for x in e['outgoingLinks']]
            txt={k:v for k,v in f.items() if v and k in ['Title','Dialogue Text','Menu Text','Sequence','Parenthetical']}
            print(e['id'],f.get('Actor'),'>',f.get('Conversant'),json.dumps(txt,ensure_ascii=False),'->',','.join(links),'COND',e['conditionsString'],'SCRIPT',e['userScript'])
def build():
    assert pins()==PINS, 'Pinned input changed before build'
    targets={}; held={}; batches=[]
    # Historical TSVs and hold-groups stay byte-exact. Each override accounts for
    # its exact old hold occurrence and the reviewed new source/target binding.
    rp=HERE/'resolved-holds.json'
    resolution_document=json.loads(rp.read_text()) if rp.exists() else {'schemaVersion':1,'records':[]}
    assert resolution_document['schemaVersion']==1, 'Unsupported hold resolution schema'
    resolutions=resolution_document['records']
    resolved={r['id']:r for r in resolutions}
    assert len(resolved)==len(resolutions), 'Duplicate hold resolution'
    consumed=set()
    def resolve_hold(ident,reason,path,locator):
        receipt=resolved.get(ident)
        if receipt is None:return False
        assert ident not in consumed, 'Duplicate resolved hold occurrence'
        assert receipt['sourceSha256']==sha(BYID[ident]['source'].encode()), 'Resolution source mismatch'
        expected={'path':str(path.relative_to(ROOT)),'sha256':sha(path.read_bytes()),'locator':locator,'reason':reason}
        assert receipt['priorHold']==expected, 'Resolution prior hold mismatch'
        decision=DISPOSITIONS[ident]
        assert receipt['dispositionSha256']==sha(json.dumps(decision,ensure_ascii=False,sort_keys=True,separators=(',',':')).encode()), 'Resolution disposition mismatch'
        consumed.add(ident)
        return True
    hp=HERE/'hold-groups.json'
    if hp.exists():
        for gi,group in enumerate(json.loads(hp.read_text())):
            for key in group['ids'].split():
                ident='ds:'+key+':Dialogue Text'
                assert ident in BYID and ident not in held
                if resolve_hold(ident,group['reason'],hp,{'groupIndex':gi,'key':key}):continue
                held[ident]=group['reason']
    for p in sorted((HERE/'batches').glob('*.tsv')):
        n=0
        for line_number,line in enumerate(p.read_text().splitlines(),1):
            if not line or line.startswith('#'): continue
            key,text=line.split('\t',1)
            parts=key.split(':'); ident='ds:'+':'.join(parts[:2])+':'+('Menu Text' if len(parts)>2 and parts[2]=='M' else 'Dialogue Text')
            assert ident in BYID, ident
            r=BYID[ident]
            assert ident not in targets and ident not in held, ident
            if text.startswith('!HOLD '):
                if not resolve_hold(ident,text[6:],p,{'lineNumber':line_number,'lineSha256':sha(line.encode())}):held[ident]=text[6:]
                continue
            text=text.replace('\\n','\n').replace('\\r','\r').replace('\\t','\t')
            prefix=re.match(r'^(?:\[pic[ac]?=[0-9A-Za-z_]+\])*',r['source']).group()
            target=prefix+text
            if r['source'].endswith('\r') and not target.endswith('\r'): target+='\r'
            decision=DISPOSITIONS.get(ident)
            content_class=validate_target(r, target, decision)
            if ident in resolved:
                assert resolved[ident]['targetBatch']==p.stem and resolved[ident]['targetSha256']==sha(target.encode()), 'Resolution target mismatch'
            for tree in TREES:
                value=tree
                for k in r['pointer'].strip('/').split('/'): value=value[int(k)] if isinstance(value,list) else value[k]
                assert value==r['source'],ident+' source binding mismatch'
            targets[ident]={**r,'sourceSha256':sha(r['source'].encode()),'target':target,'targetSha256':sha(target.encode()),'status':'edited-provisional','batch':p.stem,'review':'Immediate source-to-target editing by author; independent audit pending'}
            if content_class=='reviewed-unchanged-punctuation': targets[ident]['unchangedReason']='Expressive punctuation contains no translatable words; preserved at this exact occurrence.'
            elif content_class in ('reviewed-unchanged-nonprose','preserved-detached-source','preserved-constructed-language','preserved-source-placeholder'):
                targets[ident]['unchangedReason']=decision['reason']
                targets[ident]['unchangedCategory']={'reviewed-unchanged-nonprose':'nonprose','preserved-detached-source':'technical-preserved','preserved-constructed-language':'constructed-language','preserved-source-placeholder':'source-placeholder'}[content_class]
                targets[ident]['sourceDisposition']='source-dispositions.json#'+ident
            if content_class=='preserved-source-placeholder':
                targets[ident]['sourceDefectStatus']='OPEN'
                targets[ident]['review']='Exact source-defect preservation under current owner authority; intended text and consumer acceptance remain OPEN'
            if decision: targets[ident]['contentDisposition']=decision['disposition']
            n+=1
        batches.append({'path':str(p.relative_to(ROOT)),'sha256':sha(p.read_bytes()),'authoredEditedIds':n})
    assert consumed==set(resolved) and set(resolved)<=set(targets), 'Resolution is missing an old hold or a new target'
    ordered=[targets[r['id']] for r in ROWS if r['id'] in targets]
    data=''.join(json.dumps(r,ensure_ascii=False,separators=(',',':'))+'\n' for r in ordered).encode()
    temp=HERE/'dialogue.ru.jsonl.tmp';temp.write_bytes(data);temp.replace(HERE/'dialogue.ru.jsonl')
    unresolved=[{'id':r['id'],'reason':held[r['id']]} for r in ROWS if r['id'] in held]
    dump(HERE/'unresolved.json',unresolved)
    complete=[]
    for c in TREES[0]['conversations']:
        ids=[r['id'] for r in ROWS if r['conversationId']==c['id']]
        if ids and all(i in targets or i in held for i in ids):complete.append(c['id'])
    progress={'game':'The Forest of Love','build':'0.45','locale':'ru','stage':'translate-edit','mode':'owner-authorized parallel provisional drafting','model':{'name':'gpt-6.1-sol','reasoning':'high','provider':'openai'},'inputHashes':PINS,'sourceFamily':{'logicalCandidates':len(ROWS),'physicalOccurrences':MAN['physicalOccurrences'],'conversations':MAN['conversations'],'wholeGameDenominator':None},'authoredIds':len(ordered),'immediatelyEditedIds':len(ordered),'boundOccurrences':sum(len(r['occurrences']) for r in ordered),'explicitHeldIds':len(held),'remainingUnauthoredIds':len(ROWS)-len(ordered),'processedConversations':complete,'lastAuthoredId':ordered[-1]['id'] if ordered else None,'lastScene':ordered[-1]['conversation'] if ordered else None,'overlay':{'path':str((HERE/'dialogue.ru.jsonl').relative_to(ROOT)),'sha256':sha(data)},'batches':batches,'syntaxValidation':{'status':'passed for authored subset','checkedIds':len(ordered),'sourcePointerBothCopies':'exact equality','controls':'balanced brackets with nested/quoted operands, angle tags and brace placeholders; exact ordered equality','numericLiterals':'exact ordered equality outside tags','fullEngineGrammar':'pending shared source classification; no reinsertion performed'},'acceptance':{'source':'needs-review','probe':'pending owning renderer lane','specialScenes':'pending; drafting exception only','fullSemanticAudit':'not-run','independentDiffAudit':'not-run','resources':'not-run','runtime':'not-run','canonicalIntegration':'pending renderer worker Git ownership'},'usage':{'status':'unavailable in worker tools; launcher records telemetry separately'}}
    progress['sourceFamily']['whitespaceDelimitedWords']=sum(len(r['source'].split()) for r in ROWS)
    progress['authoredSourceWhitespaceWords']=sum(len(r['source'].split()) for r in ordered)
    progress['translatedWordingIds']=sum('unchangedReason' not in r for r in ordered)
    progress['reviewedUnchangedPunctuationIds']=sum('unchangedReason' in r and 'unchangedCategory' not in r for r in ordered)
    progress['reviewedUnchangedNonproseIds']=sum(r.get('unchangedCategory')=='nonprose' for r in ordered)
    progress['technicalPreservedIds']=sum(r.get('unchangedCategory')=='technical-preserved' for r in ordered)
    progress['reviewedUnchangedConstructedLanguageIds']=sum(r.get('unchangedCategory')=='constructed-language' for r in ordered)
    progress['preservedSourcePlaceholderIds']=sum(r.get('unchangedCategory')=='source-placeholder' for r in ordered)
    progress['sourceWarnings']=[{'id':r['id'],'status':'OPEN','classification':'preserved-source-placeholder','sourceSha256':r['sourceSha256'],'reason':DISPOSITIONS[r['id']]['reason'],'evidence':DISPOSITIONS[r['id']]['consumerEvidence']} for r in ordered if r.get('unchangedCategory')=='source-placeholder']
    assert len(progress['sourceWarnings'])==progress['preservedSourcePlaceholderIds']
    progress['acceptance']['sourceDefects']={'status':'OPEN' if progress['sourceWarnings'] else 'not-assessed','count':len(progress['sourceWarnings'])}
    progress['acceptance']['release']='pending source/editorial/resource/runtime gates'
    progress['technicalExcludedIds']=0
    progress['coverageBreakdown']={'candidateDenominator':len(ROWS),'translatedWording':progress['translatedWordingIds'],'unchangedPunctuation':progress['reviewedUnchangedPunctuationIds'],'unchangedNonprose':progress['reviewedUnchangedNonproseIds'],'technicalPreserved':progress['technicalPreservedIds'],'technicalExclusions':0,'constructedLanguage':progress['reviewedUnchangedConstructedLanguageIds'],'sourcePlaceholders':progress['preservedSourcePlaceholderIds'],'held':len(held),'unvisited':len(ROWS)-len(ordered)-len(held)}
    assert sum(progress['coverageBreakdown'][k] for k in ['translatedWording','unchangedPunctuation','unchangedNonprose','technicalPreserved','technicalExclusions','constructedLanguage','sourcePlaceholders','held','unvisited'])==len(ROWS)
    progress['savedTargetIds']=len(ordered)
    progress['countingNote']='authoredIds is the legacy supervisor saved-target counter; linguistic coverage is translatedWordingIds. Technical preservation is a source-disposition proposal. Constructed-language exact preservation is visible unfamiliar speech, not Russian wording. Source placeholders are exact preserved OPEN source defects, not translated wording. None establishes whole-source acceptance.'
    progress['syntaxValidation']['exactProtectedTokens']=sum(len(controls(r['source'],DISPOSITIONS.get(r['id'],{}).get('ordinaryBracketOrdinals',[]))) for r in ordered)
    progress['syntaxValidation']['controls']='Exact ordered balanced/quoted controls, rich text, placeholders and typewriter escapes. Ordinary bracket prose only under source-bound consumer evidence; delimiters and nested controls remain exact.'
    progress['syntaxValidation']['sourceDispositions']={'path':'localization/ru-assets/source-dispositions.json','sha256':sha((HERE/'source-dispositions.json').read_bytes()),'records':len(DISPOSITIONS),'status':'own-lane proposal; shared source acceptance pending'}
    progress['syntaxValidation']['lineSeparators']='Exact counts of LF, CR and pipe separators'
    progress['processBinding']='README.md fixed translate-edit stage; existing CHECKPOINT.json remains owned by renderer lane'
    draft_complete=len(ordered)==len(ROWS) and not held
    next_action=('Hand off the provisional pinned candidate family to shared source/editorial review. Keep six source defects OPEN and all remaining acceptance gates pending; do not launch unchanged draft phases.' if draft_complete else 'Resume the first unvisited candidate, then source-bound held decisions; preserve valid targets.')
    progress['draftOutcome']='draft-complete' if draft_complete else 'continue'
    progress['resume']={'nextAction':next_action}
    dump(OUT/'progress.json',progress)
    if len(ordered)==len(ROWS):
        import subprocess
        subprocess.run([sys.executable, '-B', str(HERE/'check_poetry.py')], check=True)
    artifacts=[{'path':str(p.relative_to(ROOT)),'sha256':sha(p.read_bytes())} for p in sorted(HERE.rglob('*')) if p.is_file() and not p.name.endswith('.tmp')]
    dump(OUT/'result.json',{'outcome':progress['draftOutcome'],'authoredIds':len(ordered),'editedIds':len(ordered),'translatedWordingIds':progress['translatedWordingIds'],'reviewedUnchangedPunctuationIds':progress['reviewedUnchangedPunctuationIds'],'reviewedUnchangedNonproseIds':progress['reviewedUnchangedNonproseIds'],'technicalPreservedIds':progress['technicalPreservedIds'],'reviewedUnchangedConstructedLanguageIds':progress['reviewedUnchangedConstructedLanguageIds'],'savedTargetIds':progress['savedTargetIds'],'preservedSourcePlaceholderIds':progress['preservedSourcePlaceholderIds'],'sourceWarnings':progress['sourceWarnings'],'coverageBreakdown':progress['coverageBreakdown'],'countingNote':progress['countingNote'],'sourceFamilyCounts':progress['sourceFamily'],'heldIds':len(held),'remainingUnauthoredIds':progress['remainingUnauthoredIds'],'outputs':artifacts,'syntaxValidation':progress['syntaxValidation'],'remainingGates':progress['acceptance'],'continuation':next_action,'usage':progress['usage']})
    assert pins()==PINS
    nextrow=next((r for r in ROWS if r['id'] not in targets and r['id'] not in held),None)
    intro=('The provisional pinned dialogue candidate draft is complete. Next stage: shared source/editorial handoff; no unchanged draft continuation.' if draft_complete else 'Resume the existing translate-edit stage.')
    (OUT/'continuation.md').write_text(intro+' Read request.md and input-pins.json; verify actual model argv before localization inputs. No agents, model jobs or Git writes. Existing TSV batches contain direct authored Russian wording and explicitly classified preserved values, and build into dialogue.ru.jsonl with corpus.py build. Reuse edited batches without taste rewrites.\n\nNext unauthored ID: '+(nextrow['id']+'; scene '+nextrow['conversation'] if nextrow else 'none')+'\n\nSaved targets: '+str(len(ordered))+'/'+str(len(ROWS))+'. Russian wording: '+str(progress['translatedWordingIds'])+'. Unchanged punctuation: '+str(progress['reviewedUnchangedPunctuationIds'])+'. Unchanged nonprose: '+str(progress['reviewedUnchangedNonproseIds'])+'. Technical preservation proposals: '+str(progress['technicalPreservedIds'])+'. Constructed-language exact preservation: '+str(progress['reviewedUnchangedConstructedLanguageIds'])+'. Preserved OPEN source placeholders: '+str(progress['preservedSourcePlaceholderIds'])+'. Explicit holds: '+str(len(held))+'. '+next_action+'  Keep technical preservation separate from linguistic coverage. All acceptance gates remain as recorded in progress.json.\n')
    print(json.dumps({'authoredEdited':len(ordered),'held':len(held),'processedConversations':len(complete),'next':nextrow['id'] if nextrow else None,'sha256':sha(data)}))
if __name__=='__main__':
    if len(sys.argv)>1 and sys.argv[1]=='show':show(int(sys.argv[2]),int(sys.argv[3]))
    elif len(sys.argv)>1 and sys.argv[1]=='build':build()
    else: raise SystemExit('Usage: corpus.py show START COUNT | build')
