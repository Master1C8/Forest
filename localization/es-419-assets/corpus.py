"""Deterministic storage/inspection only. All target wording is model-authored TSV; locale is explicit configuration."""
import hashlib, json, pathlib, re, sys
from display_spans import load_manifest, load_resolutions, scan, validate_target

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
DISPLAY_SPANS = load_manifest(BYID, TREES)
RESOLUTIONS = load_resolutions(DISPLAY_SPANS, BYID)
def controls(text): return scan(text)[0]
def show(start,count):
    for ci,c in enumerate(TREES[0]['conversations'][start:start+count],start):
        print('\nCONV',ci,c['id'],c['fields'][0]['value'])
        for e in c['dialogueEntries']:
            f={v['title']:v['value'] for v in e['fields']}
            links=[str(x['destinationConversationID'])+':'+str(x['destinationDialogueID']) for x in e['outgoingLinks']]
            txt={k:v for k,v in f.items() if v and k in ['Title','Dialogue Text','Menu Text','Sequence','Parenthetical']}
            print(e['id'],f.get('Actor'),'>',f.get('Conversant'),json.dumps(txt,ensure_ascii=False),'->',','.join(links),'COND',e['conditionsString'],'SCRIPT',e['userScript'])
def build():
    targets={}; held={}; batches=[]; hold_lines={}
    previous=json.loads((OUT/'progress.json').read_text()) if (OUT/'progress.json').exists() else {}
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
            if text.startswith('!HOLD '):
                assert ident not in held and ident not in targets, ident+' duplicate hold'
                held[ident]=text[6:]; hold_lines[ident]={'path':str(p.relative_to(ROOT)),'line':line}; continue
            assert ident not in targets, ident+' duplicate target'
            if ident in held:
                assert ident in RESOLUTIONS, ident+' unresolved hold conflicts with target'
            text=text.replace('\\n','\n').replace('\\r','\r').replace('\\t','\t')
            prefix=re.match(r'^(?:\[pic[ac]?=[0-9A-Za-z_]+\])*',r['source']).group()
            target=prefix+text
            if r['source'].endswith('\r') and not target.endswith('\r'): target+='\r'
            validate_target(r,target,DISPLAY_SPANS,unchanged_reasons)
            for tree in TREES:
                value=tree
                for k in r['pointer'].strip('/').split('/'): value=value[int(k)] if isinstance(value,list) else value[k]
                assert value==r['source'],ident+' source binding mismatch'
            targets[ident]={**r,'sourceSha256':sha(r['source'].encode()),'target':target,'targetSha256':sha(target.encode()),'status':'edited-provisional','batch':p.stem,'review':'Immediate source-to-target editing by author; independent audit pending'}
            if target==r['source']: targets[ident]['unchangedReason']=unchanged_reasons.get(ident,'Expressive punctuation contains no translatable words; preserved at this exact occurrence.')
            n+=1
        batches.append({'path':str(p.relative_to(ROOT)),'sha256':sha(p.read_bytes()),'authoredEditedIds':n})
    for ident, receipt in RESOLUTIONS.items():
        assert ident in held and ident in targets, ident+' missing held source or resolution target'
        assert hold_lines[ident]=={k:receipt['priorHold'][k] for k in ('path','line')}, ident+' hold receipt binding mismatch'
        assert targets[ident]['target']==receipt['target'] and targets[ident]['targetSha256']==receipt['targetSha256'], ident+' resolution target mismatch'
        assert targets[ident]['batch']==receipt['batch'], ident+' resolution batch mismatch'
        del held[ident]
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
    progress['syntaxValidation']['exactProtectedTokens']=sum(len(scan(r['source'],DISPLAY_SPANS.get(r['id'],{}).get('ordinaryBracketOrdinals',()))[0]) for r in ordered)
    progress['syntaxValidation']['controls']='Exact ordered opaque controls, nested/quoted Lua, tags and placeholders; only source/evidence-bound approved flower spans expose prose and retain delimiters'
    progress['syntaxValidation']['displaySpanManifest']={'path':'localization/es-419-assets/display-spans.json','sha256':sha((HERE/'display-spans.json').read_bytes()),'resolvedIds':list(RESOLUTIONS)}
    progress['holdResolutions']={'path':'localization/es-419-assets/hold-resolutions.json','sha256':sha((HERE/'hold-resolutions.json').read_bytes()),'resolvedIds':list(RESOLUTIONS),'originalHoldsPreserved':True}
    progress['syntaxValidation']['lineSeparators']='Exact counts of LF, CR and pipe separators'
    progress['processBinding']='README.md fixed translate-edit stage; existing CHECKPOINT.json remains owned by renderer lane'
    for key in ('pendingSourceFindings','processReferences','lastPhase'):
        if key in previous: progress[key]=previous[key]
    nextrow=next((r for r in ROWS if r['id'] not in targets and r['id'] not in held),None)
    progress['next']=nextrow['id'] if nextrow else None
    progress['unvisitedIds']=sum(r['id'] not in targets and r['id'] not in held for r in ROWS)
    progress['draftFamilyStatus']='draft-complete' if len(ordered)==len(ROWS) and not held else 'continue'
    if progress['draftFamilyStatus']=='draft-complete':
        progress['syntaxValidation']['status']='passed for the complete pinned provisional dialogue/menu family'
    progress['resolvedSourceFindings']=[{'id':ident,'status':'resolved for own-lane provisional draft only; shared acceptance pending','evidence':'localization/es-419-assets/hold-resolutions.json'} for ident in RESOLUTIONS]
    dump(OUT/'progress.json',progress)
    artifacts=[{'path':str(p.relative_to(ROOT)),'sha256':sha(p.read_bytes())} for p in sorted(HERE.rglob('*')) if p.is_file() and not p.name.endswith('.tmp')]
    dump(OUT/'result.json',{'outcome':progress['draftFamilyStatus'],'authoredIds':len(ordered),'editedIds':len(ordered),'translatedWordingIds':progress['translatedWordingIds'],'reviewedUnchangedPunctuationIds':progress['reviewedUnchangedPunctuationIds'],'sourceFamilyCounts':progress['sourceFamily'],'heldIds':len(held),'remainingUnauthoredIds':progress['remainingUnauthoredIds'],'outputs':artifacts,'syntaxValidation':progress['syntaxValidation'],'remainingGates':progress['acceptance'],'continuation':'Provisional dialogue/menu draft complete; stop unchanged drafting continuations. Shared source, special-scene, editorial, independent, resource, runtime and release gates remain pending.' if progress['draftFamilyStatus']=='draft-complete' else 'Resume first unauthored stable ID from continuation.md; do not rerun accepted drafts.','usage':progress['usage']})
    assert pins()==PINS
    (OUT/'continuation.md').write_text('Resume the existing translate-edit stage. Read contract.md and input-pins.json; verify actual model argv before localization inputs. No agents, model jobs or Git writes. Existing TSV batches contain directly authored '+CONFIG['language']+' ('+LOCALE+') wording and build into '+OVERLAY+' with corpus.py build. Reuse edited batches without taste rewrites.\n\nNext unauthored ID: '+(nextrow['id']+'; scene '+nextrow['conversation'] if nextrow else 'none')+'\n\nAuthored/edited: '+str(len(ordered))+'/'+str(len(ROWS))+'. Explicit holds: '+str(len(held))+'. All acceptance gates remain as recorded in progress.json.\n')
    print(json.dumps({'authoredEdited':len(ordered),'held':len(held),'processedConversations':len(complete),'next':nextrow['id'] if nextrow else None,'sha256':sha(data)}))
    if progress['draftFamilyStatus']=='draft-complete':
        (OUT/'continuation.md').write_text('Provisional es-419 dialogue/menu draft complete: all '+str(len(ROWS))+' pinned candidates have real targets; zero holds or unvisited IDs. Both flower holds are resolved with immutable display-spans.json and hold-resolutions.json receipts; all original hold TSV lines remain preserved. Stop unchanged draft loops. Shared source/special-scene/full semantic/independent/resource/runtime/release acceptance remains pending; see progress.json and phase 0035 evidence. No Git, game launch or publication is authorized in this lane.\n')
if __name__=='__main__':
    if sys.argv[1]=='show':show(int(sys.argv[2]),int(sys.argv[3]))
    elif sys.argv[1]=='build':build()
