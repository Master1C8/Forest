"""Reproduce a finite final cycle and exact delta against complete 11295-ID support.
No linguistic wording/verdict generation, model calls, game access or Git writes.
"""
import sys
sys.dont_write_bytecode=True
import pathlib,json,hashlib,re,collections,difflib,unicodedata
ROOT=pathlib.Path('/Users/antonkrutov/Desktop/Forest');R=pathlib.Path(__file__).resolve().parent;A=ROOT/'localization/ru-assets';P=ROOT/'outputs/editorial-20261027/independent-batches-v1/ru'
sha=lambda b:hashlib.sha256(b).hexdigest()
def jr(x):return (json.dumps(x,ensure_ascii=False,indent=2)+'\n').encode()
def jl(xs):return ''.join(json.dumps(x,ensure_ascii=False,separators=(',',':'))+'\n' for x in xs).encode()
def rows(p):return [json.loads(l) for l in p.read_text().splitlines()]
def key(xs):
 d={x['id']:x for x in xs};assert len(d)==len(xs),'duplicate ID';return d
def norm(s):return re.sub(r'\s+',' ',re.sub(r'^(?:\[pic[ac]?=[0-9A-Za-z_]+\])*','',unicodedata.normalize('NFKC',s).casefold()).translate(str.maketrans({'’':"'",'‘':"'",'–':'-','—':'-','‑':'-'}))).strip()
def words(s):return re.findall(r"[\w]+(?:[’'][\w]+)?",s.casefold())
def main():
 app=json.loads((R/'application-verification.json').read_text());assert app['status']=='passed'
 spec=json.loads((R/'final-closure-spec.json').read_text());oldrows=rows(P/'full-pairs.jsonl');old=key(oldrows);current=key(rows(A/'dialogue.ru.jsonl'));source=rows(ROOT/'localization/source/dialogue-candidates.jsonl');by=key(source);order=[x['id'] for x in source]
 assert set(old)==set(current)==set(by) and len(by)==12246
 plan=key(json.loads((R/'application-plan.json').read_text()));changed={i for i in order if old[i]['target']!=current[i]['target']};assert changed==set(plan)==set(app['correctedIds'])
 prior=key(rows(R/'merged-reviews.jsonl'));support=set((R/'prior-reviewed-ids.txt').read_text().splitlines());assert len(prior)==len(support)==11295 and set(prior)==support
 for i,r in prior.items():assert r['sourceSha256']==sha(old[i]['source'].encode()) and r['targetSha256']==sha(old[i]['target'].encode()),i+' wrong prior support version'
 ctx=json.loads((P/'source-context.json').read_text());nodes={(c['id'],n['id']):n for c in ctx['conversations'] for n in c['dialogueEntries']};convs={c['id']:c for c in ctx['conversations']}
 man=json.loads((ROOT/'localization/source/dialogue-manifest.json').read_text());physical=0
 for item in man['sources']:
  raw=(ROOT/item['tree']).read_bytes();assert sha(raw)==item['treeSha256'];tree=json.loads(raw);assert tree['conversations']==ctx['conversations']
  for x in source:
   v=tree
   for k in x['pointer'].strip('/').split('/'):v=v[int(k)] if isinstance(v,list) else v[k]
   assert v==x['source'];physical+=1
 del tree,raw
 sys.path.insert(0,str(A));import inline_guard as g
 disp=g.load_dispositions(A/'source-dispositions.json',ROOT,by);g.validate_preserve_manifest(A/'preserve-exactly.json',A/'source-dispositions.json',disp,by)
 baseline=key(rows(R/'before/localization/ru-assets/dialogue.ru.jsonl'));protected=[]
 for i in order:
  x=by[i];c=current[i];o=baseline[i];assert c['source']==old[i]['source']==x['source'];assert {k:v for k,v in c.items() if k not in ('target','targetSha256')}=={k:v for k,v in o.items() if k not in ('target','targetSha256')}
  g.validate_target(x,c['target'],disp.get(i));g.validate_target(x,o['target'],disp.get(i));d=disp.get(i,{});ordinary=d.get('ordinaryBracketOrdinals',[]);t=g.controls(x['source'],ordinary);assert t==g.controls(c['target'],ordinary)==g.controls(o['target'],ordinary)
  protected.append({'id':i,'sourceSha256':sha(x['source'].encode()),'controls':t,'numericLiterals':re.findall(r'\d+',g.display_text(x['source'],ordinary)),'separators':{repr(v):x['source'].count(v) for v in ('\n','\r','|')},'exactPrefix':d.get('preservePrefix'),'exactValue':d.get('preserveExactly')})
 assert all(current[i]['target']==p['newTarget'] for i,p in plan.items())
 entry_ids=collections.defaultdict(set)
 for x in source:entry_ids[(x['conversationId'],x['entryId'])].add(x['id'])
 forward={k:{(l['destinationConversationID'],l['destinationDialogueID']) for l in n['outgoingLinks']} for k,n in nodes.items()};back=collections.defaultdict(set)
 for k,dests in forward.items():
  for dest in dests:back[dest].add(k)
 real=lambda k:any(not current[i].get('unchangedCategory')=='technical-preserved' for i in entry_ids.get(k,()))
 def context_keys(seeds,depth):
  chosen=set(seeds)
  for graph in [forward,back]:
   q=collections.deque((k,0) for k in seeds);seen={}
   while q:
    k,n=q.popleft()
    if k in seen and seen[k]<=n:continue
    seen[k]=n;chosen.add(k)
    for dest in graph.get(k,set()):
     nn=n+(1 if real(dest) else 0)
     if nn<=depth and dest in nodes:q.append((dest,nn))
  return chosen
 def ids_at(keys):return set().union(*(entry_ids.get(k,set()) for k in keys)) if keys else set()
 changedkeys={(by[i]['conversationId'],by[i]['entryId']) for i in changed};exchange_keys=context_keys(changedkeys,2)
 components={'changed':changed,'minimal-changed-exchanges':ids_at(exchange_keys)};reasons=collections.defaultdict(set)
 source_values={by[i]['source'] for i in changed};target_values={x for i in changed for x in (old[i]['target'],current[i]['target'])};norm_values={norm(by[i]['source']) for i in changed}
 components['exact-repetitions']={i for i in order if by[i]['source'] in source_values or old[i]['target'] in target_values or current[i]['target'] in target_values}
 components['normalized-source-repetitions']={i for i in order if norm(by[i]['source']) in norm_values}
 # Recompute every class from the recipe, rather than trusting a generated ID list.
 classes=json.loads((R/'class-spec.json').read_text());hits=set()
 for name,rule in classes.items():
  if name=='normalized-finding-repetitions':
   fids={x['id'] for x in rows(R/'findings.jsonl')};values={norm(by[i]['source']) for i in fids};actual={i for i in order if norm(by[i]['source']) in values}
  else:
   actual=set()
   for i in order:
    sm=bool(rule['sourceRegex'] and re.search(rule['sourceRegex'],by[i]['source'],re.I));tm=bool(rule['targetRegex'] and re.search(rule['targetRegex'],old[i]['target'],re.I))
    if ((sm and tm) if rule['mode']=='AND' else (sm or tm)):actual.add(i)
  assert actual==set(rule['ids']),name+' class reconstruction differs';hits|=actual
 components['demonstrated-class-concepts']=hits
 stop=set('а и но что это я ты он она мы вы они мне меня тебе тебя его её их у в во на по с со к ко за от не ни бы же то да как так для ли есть был была было были будет быть всё все уже'.split());phrases=set()
 for i in changed:
  a,b=words(old[i]['target']),words(current[i]['target'])
  for tag,a1,a2,b1,b2 in difflib.SequenceMatcher(a=a,b=b,autojunk=False).get_opcodes():
   if tag!='equal':
    for span in [a[a1:a2],b[b1:b2]]:
     if len(span)>=2 and any(w not in stop for w in span):phrases.add(tuple(span))
 components['old-new-wording']=set()
 for i in order:
  for target in [old[i]['target'],current[i]['target']]:
   tw=words(target)
   if any(any(tuple(tw[k:k+len(p)])==p for k in range(len(tw)-len(p)+1)) for p in phrases):components['old-new-wording'].add(i)
 regress=set();reg_components={}
 for rule in spec['mandatoryRegressions']:
  selected={i for i in order if (rule.get('source') and re.search(rule['source'],by[i]['source'],re.I)) or (rule.get('conversation') and re.search(rule['conversation'],by[i]['conversation'],re.I)) or (rule.get('dispositions') and i in disp)};reg_components[rule['name']]=selected;regress|=selected
 components['mandatory-regressions']=regress;components['runtime-markup-bindings']=reg_components['mixed-controls-and-layout']
 poemids={i for i in order if by[i]['conversationId'] in (302,303) or i in {'ds:300:483:Dialogue Text','ds:300:484:Dialogue Text'}};components['poem-products-callback-context']=poemids
 seeds=set().union(*components.values());linked=context_keys({(by[i]['conversationId'],by[i]['entryId']) for i in seeds},1);components['linked-class-repetition-regression-context']=ids_at(linked)
 closure=set().union(*components.values());assert closure<=set(order)
 rejected={x['id'] for x in json.loads((R/'adjudications.json').read_text()) if x['decision']=='rejected'}
 invalidated=(components['minimal-changed-exchanges']|rejected)&support
 mismatch={i for i in support if prior[i]['sourceSha256']!=sha(current[i]['source'].encode()) or prior[i]['targetSha256']!=sha(current[i]['target'].encode())};invalidated|=mismatch
 delta=changed|(closure-support)|invalidated;retained=support-invalidated;assert not(delta&retained)
 for i in retained:assert prior[i]['sourceSha256']==sha(current[i]['source'].encode()) and prior[i]['targetSha256']==sha(current[i]['target'].encode())
 files={};ordered=lambda ids:[i for i in order if i in ids]
 for name,ids in components.items():
  files['components/'+name+'-ids.txt']=''.join(i+'\n' for i in ordered(ids)).encode()
  for i in ids:reasons[i].add(name)
 for name,ids in [('changed',changed),('closure',closure),('delta',delta),('explicitly-invalidated',invalidated),('retained-support',retained),('new-dependencies',closure-support),('removed-prior-dependencies',support-closure)]:files[name+'-ids.txt']=''.join(i+'\n' for i in ordered(ids)).encode()
 def reviewrow(i):return {**current[i],'oldTarget':old[i]['target'],'oldTargetSha256':sha(old[i]['target'].encode()),'changed':i in changed,'components':sorted(reasons[i]),'decision':plan.get(i),'priorIndependentJudgment':prior.get(i),'needsNewPeerReview':i in delta}
 files['review-rows.jsonl']=jl(reviewrow(i) for i in ordered(closure|delta));files['delta-review-rows.jsonl']=jl(reviewrow(i) for i in ordered(delta))
 files['retained-reviews.jsonl']=jl(prior[i] for i in ordered(retained));files['retained-source-context-verdicts.jsonl']=jl(prior[i] for i in ordered(retained) if prior[i]['verdict'] in ('source-defect','needs-context'))
 selectedkeys=linked|exchange_keys;selectedconvs={k[0] for k in selectedkeys};delta_keys=context_keys({(by[i]['conversationId'],by[i]['entryId']) for i in delta},2)
 files['context-topology.json']=jr({'actors':ctx['actors'],'conversations':[c for c in ctx['conversations'] if c['id'] in selectedconvs]})
 fragments=[]
 for k,n in nodes.items():
  if k in selectedkeys or k in delta_keys:fragments.append({'nodeKey':f'{k[0]}:{k[1]}','fields':[f for f in n['fields'] if f['title'] not in ('Dialogue Text','Menu Text')],'isGroup':n['isGroup'],'conditionsString':n['conditionsString'],'userScript':n['userScript'],'outgoingLinks':n['outgoingLinks']})
 files['components/nontranslation-context.jsonl']=jl(fragments)
 files['delta-linked-context.jsonl']=jl({'nodeKey':f'{k[0]}:{k[1]}','rawSourceNode':nodes[k],'localizedFields':[{ 'id':i,'source':by[i]['source'],'oldTarget':old[i]['target'],'target':current[i]['target']} for i in ordered(entry_ids.get(k,set()))]} for k in nodes if k in delta_keys)
 files['components/protected-values-all-ids.jsonl']=jl(protected);files['wording-phrases.json']=jr(sorted(' '.join(p) for p in phrases))
 checks={'sourceIds':12246,'changed':len(changed),'untouchedTargetsAndCompleteMetadataExact':12246-len(changed),'physicalPointers':physical,'protectedOrderedTokens':sum(len(x['controls']) for x in protected),'sourceDispositionRecords':len(disp),'sourceContextBothPhysicalTreesExact':True,'sourcePlaceholdersRemainOpen':[i for i in order if disp.get(i,{}).get('disposition')=='preserved-source-placeholder'],'runtime':'not-run','fullEngineGrammar':'pending shared source/consumer acceptance'};files['full-corpus-verification.json']=jr(checks)
 retention={'priorSupportIds':11295,'retainedExactVersionIds':len(retained),'invalidatedIds':len(invalidated),'newClosureIdsWithoutPriorSupport':len(closure-support),'deltaIds':len(delta),'formula':spec['deltaFormula'],'contextPolicy':spec['explicitInvalidation'],'rejectedFindingsRequirePeerAdjudication':ordered(rejected),'removedDependencyReason':spec['removedDependencies'],'removedPriorDependencyCount':len(support-closure),'priorSupportReceiptHash':sha((R/'merged-reviews.jsonl').read_bytes()),'sourceContextSha256':sha((P/'source-context.json').read_bytes()),'notIndependentAcceptance':'This script only selects and verifies; retained findings/holds do not become clean, and all new delta judgments remain pending.'};files['retention-verification.json']=jr(retention)
 pins={}
 for p in [ROOT/'localization/source/dialogue-candidates.jsonl',ROOT/'localization/source/dialogue-manifest.json',A/'dialogue.ru.jsonl',A/'source-dispositions.json',A/'preserve-exactly.json',A/'resolved-holds.json',A/'inline_guard.py',A/'corpus.py',A/'check_poetry.py',A/'poetry-validation.json',ROOT/'localization/glossary/en.json',ROOT/'localization/glossary/ru.json',P/'source-context.json',P/'full-pairs.jsonl',R/'merged-reviews.jsonl',R/'prior-reviewed-ids.txt',R/'merge-verification.json',R/'class-spec.json',R/'class-decisions.authored.json',R/'adjudications.json',R/'final-closure-spec.json',pathlib.Path(__file__).resolve(),R/'apply_batch.py',R/'application-plan.json',R/'consumer-preflight.md',R/'runtime-check.json',R/'poem-judgments.authored.json',R/'poem-and-scansion-verification.json',ROOT/'outputs/editorial-20261027/ru/glossary-en.json',ROOT/'outputs/editorial-20261027/ru/glossary-ru.json',ROOT/'review/text-bearing-textures.json',ROOT/'special-scenes.json']:
  pins[str(p)]=sha(p.read_bytes())
 for p in sorted((ROOT/'outputs/editorial-20261027/continuation/adjudication-run-v1/manuals').glob('*.md')):pins[str(p)]=sha(p.read_bytes())
 for p in sorted((A/'batches').glob('*.tsv')):pins[str(p)]=sha(p.read_bytes())
 for n in ['DialogueEntry.il','FormattedText.cs','ConversationModel.il']:
  p=ROOT/'localization/es-419-assets/consumer-evidence-0035'/n;pins[str(p)]=sha(p.read_bytes())
 files['input-and-artifact-hashes.json']=jr(pins);files['closure-bounds.json']=jr({'components':{k:len(v) for k,v in components.items()},'selectedIds':len(closure),'deltaIds':len(delta),'nontranslationNodeCount':len(fragments),'limits':spec['limits'],'notWholeGame':True})
 manifest={'cycle':'cycle-final-02','locale':'ru','newline':'UTF-8, LF-terminated IDs/JSONL; embedded controls/separators are JSON escapes','changedCount':len(changed),'closureCount':len(closure),'deltaCount':len(delta),'priorCompleteIndependentSupport':11295,'independentReview':'pending different fresh peer; author preflight is not independent acceptance','files':{k:{'sha256':sha(v),'bytes':len(v)} for k,v in files.items()}};files['manifest.json']=jr(manifest)
 dest=R/'cycle-final-02'
 if '--verify' in sys.argv:
  for name,raw in files.items():assert (dest/name).read_bytes()==raw,name+' reconstruction differs'
  print(json.dumps({'status':'reconstructed-byte-exact','files':len(files),**retention}));return
 dest.mkdir()
 for name,raw in files.items():p=dest/name;p.parent.mkdir(parents=True,exist_ok=True);p.open('xb').write(raw)
 print(json.dumps({'status':'immutable-cycle-created','changed':len(changed),'closure':len(closure),'delta':len(delta),'retained':len(retained),'invalidated':len(invalidated),'manifestSha256':sha(files['manifest.json'])}))
if __name__=='__main__':main()
