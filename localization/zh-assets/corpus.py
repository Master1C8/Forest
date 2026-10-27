"""Deterministic storage/inspection only. All target wording is model-authored TSV; locale is explicit configuration."""
import hashlib, json, pathlib, re, sys
from display_adapter import DisplayAdapter, HoldResolutions, scan, verify_technical_preservations

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
ADAPTER = DisplayAdapter(ROOT, HERE, BYID)
def controls(text):
    # Generic callers remain strict: unknown square-bracket spans stay opaque.
    return scan(text)[0]
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
    resolutions=HoldResolutions(ROOT, HERE, BYID)
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
            assert ident not in targets, ident
            if text.startswith('!HOLD '):
                assert ident not in held, ident
                held[ident]=text[6:]; continue
            text=text.replace('\\n','\n').replace('\\r','\r').replace('\\t','\t')
            prefix=re.match(r'^(?:\[pic[ac]?=[0-9A-Za-z_]+\])*',r['source']).group()
            target=prefix+text
            if r['source'].endswith('\r') and not target.endswith('\r'): target+='\r'
            visible_source=re.sub(r'\[[^\]]*\]|<[^>]*>','',r['source'])
            punctuation_only=not re.search(r'[^\W\d_]',visible_source)
            assert target.strip(), ident+' empty target'
            assert target!=r['source'] or punctuation_only or unchanged_reasons.get(ident), ident+' unchanged visible text requires an individual reason'
            ADAPTER.validate(r,target)
            for tree in TREES:
                value=tree
                for k in r['pointer'].strip('/').split('/'): value=value[int(k)] if isinstance(value,list) else value[k]
                assert value==r['source'],ident+' source binding mismatch'
            resolutions.apply(r,target,str(p.relative_to(ROOT)),held)
            targets[ident]={**r,'sourceSha256':sha(r['source'].encode()),'target':target,'targetSha256':sha(target.encode()),'status':'edited-provisional','batch':p.stem,'review':'Immediate source-to-target editing by author; independent audit pending'}
            if target==r['source']: targets[ident]['unchangedReason']=unchanged_reasons.get(ident,'Expressive punctuation contains no translatable words; preserved at this exact occurrence.')
            n+=1
        batches.append({'path':str(p.relative_to(ROOT)),'sha256':sha(p.read_bytes()),'authoredEditedIds':n})
    resolutions.finish()
    technical_ids=verify_technical_preservations(ROOT,HERE,BYID,targets,unchanged_reasons)
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
    unchanged=[r for r in ordered if r['target']==r['source']]
    command_ids={'ds:466:760:Dialogue Text','ds:466:821:Dialogue Text'}
    constructed_ids={r['id'] for r in unchanged if 'tfol-068' in unchanged_reasons.get(r['id'],'')}
    progress['reviewedUnchangedExactCommandIds']=sum(r['id'] in command_ids for r in unchanged)
    progress['reviewedUnchangedConstructedLanguageIds']=len(constructed_ids)
    progress['preservedDetachedTechnicalIds']=len(technical_ids)
    progress['reviewedUnchangedPunctuationIds']=sum(r['id'] not in command_ids|constructed_ids|technical_ids for r in unchanged)
    progress['syntaxValidation']['exactProtectedTokens']=sum(len(ADAPTER.signature(r,r['source'])[0]) for r in ordered)
    progress['syntaxValidation']['controls']='Exact ordered controls, nested/quoted Lua, variables, rich text and opaque unknown brackets; only occurrence/source/evidence-bound display spans expose prose, retaining both delimiters'
    progress['syntaxValidation']['numericLiterals']='Exact ordered prose numbers including approved display spans; protected operand values preserved byte-exact'
    progress['syntaxValidation']['holdResolutions']=len(resolutions.used)
    progress['syntaxValidation']['status']='passed for complete pinned dialogue/menu family' if len(ordered)==len(ROWS) and not held else 'passed for authored subset'
    progress['syntaxValidation']['lineSeparators']='Exact counts of LF, CR and pipe separators'
    progress['processBinding']='README.md fixed translate-edit stage; existing CHECKPOINT.json remains owned by renderer lane'
    nextrow=next((r for r in ROWS if r['id'] not in targets and r['id'] not in held),None)
    family_complete=len(ordered)==len(ROWS) and not held
    progress['retainedCandidateIds']=len(ordered)
    progress['unchangedTechnicalIds']=progress['reviewedUnchangedExactCommandIds']+len(technical_ids)
    progress['unvisitedIds']=len(ROWS)-len(targets)-len(held)
    progress['remainingHeldIds']=[r['id'] for r in ROWS if r['id'] in held]
    progress['next']=nextrow['id'] if nextrow else None
    progress['draftStatus']='draft-complete for pinned dialogue/menu family only; full source/editorial/renderer/runtime/delivery acceptance pending' if family_complete else 'provisional dialogue/menu draft incomplete'
    progress['adapter']={'recipe':'localization/zh-assets/RECIPE.md','files':{str((HERE/name).relative_to(ROOT)):sha((HERE/name).read_bytes()) for name in ['corpus.py','display_adapter.py','display-spans.json','hold-resolutions.json','technical-preservations.json']}}
    dump(OUT/'progress.json',progress)
    artifacts=[{'path':str(p.relative_to(ROOT)),'sha256':sha(p.read_bytes())} for p in sorted(HERE.rglob('*')) if p.is_file() and not p.name.endswith('.tmp')]
    dump(OUT/'result.json',{'outcome':'draft-complete' if family_complete else 'continue','scope':'pinned dialogue/menu family only','authoredIds':len(ordered),'retainedCandidateIds':len(ordered),'editedIds':len(ordered),'translatedWordingIds':progress['translatedWordingIds'],'reviewedUnchangedPunctuationIds':progress['reviewedUnchangedPunctuationIds'],'reviewedUnchangedConstructedLanguageIds':progress['reviewedUnchangedConstructedLanguageIds'],'reviewedUnchangedExactCommandIds':progress['reviewedUnchangedExactCommandIds'],'preservedDetachedTechnicalIds':len(technical_ids),'unchangedTechnicalIds':progress['unchangedTechnicalIds'],'sourceFamilyCounts':progress['sourceFamily'],'heldIds':len(held),'remainingUnauthoredIds':progress['remainingUnauthoredIds'],'unvisitedIds':progress['unvisitedIds'],'outputs':artifacts,'syntaxValidation':progress['syntaxValidation'],'remainingGates':progress['acceptance'],'continuation':'All family candidates retained; proceed only to separately assigned pending gates, without repeating the completed draft.' if family_complete else 'Resume first unauthored stable ID from continuation.md; preserve saved drafts.','usage':progress['usage']})
    assert pins()==PINS
    (OUT/'continuation.md').write_text('Resume the existing zh translate-edit stage. Read contract.md and input-pins.json; verify actual gpt-6.1-sol/high/OpenAI argv before localization inputs. No agents, nested model jobs, Git or shared-file writes. Authored Simplified Chinese TSV batches rebuild dialogue.zh.jsonl with corpus.py build. Preserve every original batch and explicit hold-resolution receipt.\n\nNext unauthored ID: '+(nextrow['id']+'; scene '+nextrow['conversation'] if nextrow else 'none')+'\n\nRetained targets: '+str(len(ordered))+'/'+str(len(ROWS))+'. Explicit holds: '+str(len(held))+'. This is only the pinned dialogue/menu family. Editorial, renderer, source, resource, runtime and delivery gates remain as recorded in progress.json.\n')
    print(json.dumps({'authoredEdited':len(ordered),'held':len(held),'processedConversations':len(complete),'next':nextrow['id'] if nextrow else None,'sha256':sha(data)}))
if sys.argv[1]=='show':show(int(sys.argv[2]),int(sys.argv[3]))
elif sys.argv[1]=='build':build()
