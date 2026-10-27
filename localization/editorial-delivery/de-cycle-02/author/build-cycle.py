"""Reproduce a bounded final delta from canonical inventory and verified prior receipts."""
import collections,hashlib,itertools,json,pathlib,re,sys,unicodedata
R=pathlib.Path('/Users/antonkrutov/Desktop/Forest');O=pathlib.Path(__file__).resolve().parent
P=R/'outputs/editorial-20261027/independent-correction-review-v1/de';A=R/'localization/de-assets'
C=O/(sys.argv[1] if len(sys.argv)>1 else 'cycle-02');assert C.parent==O;C.mkdir(exist_ok=False)
sha=lambda b:hashlib.sha256(b).hexdigest()
enc=lambda x:json.dumps(x,ensure_ascii=False,separators=(',',':'))
def jl(p,rows):p.write_text(''.join(enc(x)+'\n' for x in rows))
def dump(p,x):p.write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n')
def load(p):return [json.loads(s) for s in p.read_text().splitlines()]
src=load(R/'localization/source/dialogue-candidates.jsonl');before=load(O/'before-overlay.jsonl');after=load(O/'after-overlay.jsonl')
assert [r['id'] for r in src]==[r['id'] for r in before]==[r['id'] for r in after]
old={r['id']:r for r in before};new={r['id']:r for r in after};assert len(new)==12246
dec=load(O/'adjudication.jsonl');changed={d['id'] for d in dec};assert changed=={i for i in new if new[i]['target']!=old[i]['target']}
assert (A/'dialogue.de.jsonl').read_bytes()==(O/'after-overlay.jsonl').read_bytes()
dispatch=json.loads((O/'dispatch.json').read_text())
for p,h in dispatch['inputPins'].items():
    if p!=str(A/'dialogue.de.jsonl'):assert sha(pathlib.Path(p).read_bytes())==h,p
# Prior final artifacts and per-ID versions are independently verifiable without re-reading semantics.
pm=json.loads((P/'output-manifest.json').read_text());reviewresult=json.loads((P/'result.json').read_text())
assert sha((P/'output-manifest.json').read_bytes())==reviewresult['artifacts']['outputManifestSha256']
for name,v in pm['files'].items():assert sha((P/name).read_bytes())==v['sha256'],name
reviews=load(P/'reviews.jsonl');prior={x['id']:x for x in reviews};priorlist=(P/'repaired-closure-ids.txt').read_text().splitlines()
assert len(prior)==len(reviews)==len(priorlist)==5377 and set(prior)==set(priorlist)
assert priorlist==[x['id'] for x in src if x['id'] in prior]
for i,x in prior.items():
    assert x['sourceSha256']==sha(old[i]['source'].encode())
    assert x['targetSha256']==sha(old[i]['target'].encode())
ctx=json.loads((R/'outputs/editorial-20261027/de/source-context.json').read_text());nodes={(c['id'],e['id']):(c,e) for c in ctx['conversations'] for e in c['dialogueEntries']}
graph=collections.defaultdict(set)
for k,(c,e) in nodes.items():
    for l in e['outgoingLinks']:
        d=(l['destinationConversationID'],l['destinationDialogueID']);graph[k].add(d);graph[d].add(k)
spec=json.loads((O/'selector.json').read_text())
def norm(s):
    s=re.sub(r'^(?:\[pic[ac]?=[0-9A-Za-z_]+\])*','',s)
    s=unicodedata.normalize('NFKC',s).casefold().translate(str.maketrans({'’':"'",'‘':"'",'‐':'-','‑':'-','–':'-','—':'-'}))
    return re.sub(r'\s+',' ',s).strip()
def expand(roots,depth):
    seen=set(roots);wave=set(roots)
    for _ in range(depth):
        wave={d for k in wave for d in graph[k]}-seen;seen|=wave
    return seen & nodes.keys()
def nodeids(ks):return {x['id'] for x in src if (x['conversationId'],x['entryId']) in ks}
roots={(x['conversationId'],x['entryId']) for x in src if x['id'] in changed}
exchange=expand(roots,2)
parts={'changed':changed,'exchanges':nodeids(exchange)}
seeds={norm(t) for d in dec for t in (d['source'],d['oldTarget'],d['newTarget'])}-{''}
parts['repetitions']={x['id'] for x in src if any(norm(t) in seeds for t in (x['source'],old[x['id']]['target'],new[x['id']]['target']))}
concept={name:{x['id'] for x in src if any(re.search(pattern,norm(t),re.I) for t in (x['source'],old[x['id']]['target'],new[x['id']]['target']))} for name,pattern in spec['conceptPatterns'].items()}
# Repair the reusable selector: literal cousin matches alone omit he in the next node.
callbackroots={(x['conversationId'],x['entryId']) for x in src if x['id'] in set.union(*concept.values())}
callbacknodes=expand(callbackroots,1)
concept['source-linked-pronouns-and-callbacks']=nodeids(callbacknodes)
parts['concept-referents']=set.union(*concept.values())
parts['old-new-wording']={x['id'] for x in src if any(re.search(p,norm(t),re.I) for p in spec['wordingPatterns'] for t in (old[x['id']]['target'],new[x['id']]['target']))}
parts['wordplay-callbacks']=concept['flight-service-name']|concept['source-linked-pronouns-and-callbacks']
priorSpec=json.loads((R/'outputs/editorial-20261027/correction-completion-v1/de/closure-selector.json').read_text())
priorHeld={x['id'] for x in load(R/'outputs/editorial-20261027/correction-completion-v1/de/completion-decisions.jsonl') if x['decision']=='held'}
parts['mandatory-regressions']=priorHeld|{x['id'] for x in src if re.search(priorSpec['mandatoryPatterns'],x['conversation']+' '+x['source']+' '+new[x['id']]['target'],re.I)}
parts['runtime-binding']={x['id'] for x in src if x['field']=='Menu Text' or '\n' in x['source'] or '|' in x['source'] or re.search(r'\[(?:var|lua|input)[^]]*\]|<[A-Za-z/]',re.sub(r'^(?:\[pic[ac]?=[0-9A-Za-z_]+\])*','',x['source'])) or 'system/dynamic' in x['conversation'] or x['conversationId'] in (300,302,303)}
parts['runtime-binding']|=nodeids(exchange)
closure=set.union(*parts.values());invalid={'ds:303:411:Dialogue Text'}
delta=changed|(closure-set(prior))|invalid
assert changed<=closure and invalid<=closure
def ordered(ids):return [x['id'] for x in src if x['id'] in ids]
def ids(name,values):(C/(name+'-ids.txt')).write_text(''.join(i+'\n' for i in ordered(values)))
for name,values in parts.items():ids(name,values)
for name,values in [('closure',closure),('delta',delta),('new-dependencies',closure-set(prior)),('explicitly-invalidated',invalid),('removed-dependencies',set(prior)-closure),('previous-reviewed',set(prior))]:ids(name,values)
dump(C/'concept-components.json',{k:ordered(v) for k,v in concept.items()})
dump(C/'explicit-invalidation.json',[{'id':'ds:303:411:Dialogue Text','reason':'Canonical checker accepted-version binding changed; independent delta must inspect exact scan/source/provenance and canonical execution. Target/source bytes and linguistic review stay unchanged; old stale helper receipt is not carried as final validation.'}])
retained=[x for x in reviews if x['id'] not in delta and x['sourceSha256']==new[x['id']]['sourceSha256'] and x['targetSha256']==new[x['id']]['targetSha256']]
jl(C/'retained-per-id-reviews.jsonl',retained)
jl(C/'retained-source-context-holds.jsonl',[x for x in retained if x['verdict'] in ('needs-context','source-defect')])
reviewrows=[]
for x in src:
    if x['id'] not in closure:continue
    i=x['id'];c,e=nodes[x['conversationId'],x['entryId']];f={z['title']:z['value'] for z in e['fields']}
    assert f[x['field']]==x['source']
    reviewrows.append({**x,'oldTarget':old[i]['target'],'newTarget':new[i]['target'],'sourceSha256':new[i]['sourceSha256'],'oldTargetSha256':old[i]['targetSha256'],'newTargetSha256':new[i]['targetSha256'],'actor':f.get('Actor'),'conversant':f.get('Conversant'),'title':f.get('Title'),'sequence':f.get('Sequence'),'conditions':e['conditionsString'],'script':e['userScript'],'links':e['outgoingLinks'],'isGroup':e['isGroup'],'components':[n for n,v in parts.items() if i in v]})
jl(C/'closure-review-rows.jsonl',reviewrows);jl(C/'delta-review-rows.jsonl',[x for x in reviewrows if x['id'] in delta])
delta_roots={(x['conversationId'],x['entryId']) for x in src if x['id'] in delta}
support_nodes=expand(delta_roots,2)|{(303,k) for k in (419,325,410,406,404,599,411,407,326,413,600,408,327,412,416,597)}
support_ids=nodeids(support_nodes)-delta
jl(C/'delta-supporting-reviewed-rows.jsonl',[x for x in reviewrows if x['id'] in support_ids])
jl(C/'delta-context-nodes.jsonl',[{'componentId':f'node:{c}:{e}','conversationId':c,'node':nodes[c,e][1]} for c,e in sorted(support_nodes)])

# Separate nontranslation consumer metadata from candidate coverage.
contextnodes=expand({(x['conversationId'],x['entryId']) for x in src if x['id'] in closure},1)
context=[]
for c in ctx['conversations']:
    if any(k[0]==c['id'] for k in contextnodes):context.append({'kind':'conversation','conversationId':c['id'],'fields':c['fields']})
    for e in c['dialogueEntries']:
        if (c['id'],e['id']) not in contextnodes:continue
        context.append({'kind':'node','conversationId':c['id'],'entryId':e['id'],**{k:v for k,v in e.items() if k!='fields'},'fields':[f for f in e['fields'] if f['title'] not in ('Dialogue Text','Menu Text')]})
jl(C/'context-runtime.jsonl',context)
components=[]; artifact_cache={}
for x in load(P/'reviewed-components.jsonl'):
    if 'counts' in x:continue  # Count the 27 poem receipts only in their own component.
    if 'artifact' in x:
        path=pathlib.Path(x['artifact'])
        if path not in artifact_cache:artifact_cache[path]={v['componentId']:v for v in load(path)}
        item=artifact_cache[path][x['componentId']];assert sha(enc(item).encode())==x['sha256']
        c,e=map(int,x['componentId'].split(':')[1:]);assert item['node']==nodes[c,e][1]
    else:
        path=R/x.get('path',x['componentId']);assert sha(path.read_bytes())==x['sha256']
    components.append(x)
assert len(components)==201
jl(C/'retained-context-receipts.jsonl',components)
# Reuse only exactly matching independent poem receipts; checker is a separate technical artifact.
poetry=load(P/'poetry-review.jsonl')
for x in poetry:
    ss='\n'.join(new[i]['source'] for i in x['ids']);tt='\n'.join(re.sub(r'^(?:\[pic[ac]?=[0-9A-Za-z_]+\])*','',new[i]['target']) for i in x['ids'])
    assert sha(ss.encode())==x['sourceSha256'] and sha(tt.encode())==x['targetSha256']
jl(C/'retained-poetry-reviews.jsonl',poetry)
# Reconcile actual slot order and empty nodes, preserving all commands and 27 products.
def destinations(e):return [l['destinationDialogueID'] for l in nodes[303,e][1]['outgoingLinks'] if l['destinationConversationID']==303]
slots=[destinations(i) for i in (419,599,600)]
assert slots==[[325,410,406],[411,407,326],[408,327,412]]
for choices,join,nextnode in zip(slots,[404,413,416],[599,600,597]):
    for e in choices:assert destinations(e)==[join]
    assert destinations(join)==[nextnode]
combinations=[]
for seq in itertools.product(*slots):
    ii=[f'ds:303:{e}:Dialogue Text' for e in seq]
    combinations.append({'ids':ii,'source':'\n'.join(new[i]['source'] for i in ii),'target':'\n'.join(new[i]['target'] for i in ii)})
assert len(combinations)==27
jl(C/'poetry-actual-branch-combinations.jsonl',combinations)
dump(C/'poetry-topology.json',{'actualBranchOrder':slots,'scaffoldingNodes':{str(e):nodes[303,e][1] for e in (419,404,599,413,600,416,597)},'context':'Static separate full dialogue fields and source links; no flatten-order concatenation or new trimming. Real runtime not exercised.'})
assert len(concept['flight-service-name'])==11
for i in ['ds:468:767:Dialogue Text','ds:468:768:Dialogue Text','ds:481:749:Dialogue Text','ds:209:133:Dialogue Text','ds:523:997:Dialogue Text','ds:524:898:Dialogue Text','ds:524:901:Dialogue Text']:assert i in closure,i
assert not any('Flug und Flitz' in x['target'] for x in after)
dump(C/'selector-regressions.json',{'status':'passed','namedServiceOccurrences':11,'cousinLinkedHeRetained':True,'wolfRecipientAnd901CallbackRetained':True,'dragonCombatClass':'Included as context; no mechanical role rewrite performed','canonicalOrderAndNoInventedIds':True,'priorReviewVersionChecks':5377,'unchangedPoetryReceipts':len(poetry),'retainedContextReceipts':len(components),'newDependencyCount':len(closure-set(prior))})
inputs={}
for p in [R/'localization/source/dialogue-candidates.jsonl',R/'localization/source/dialogue-manifest.json',R/'outputs/editorial-20261027/de/source-context.json',R/'localization/glossary/en.json',R/'localization/glossary/de.json',R/'outputs/editorial-20261027/de/glossary-en.json',R/'outputs/editorial-20261027/de/glossary-de.json',*sorted((R/'outputs/editorial-20261027/continuation/adjudication-run-v1/manuals').glob('*')), *sorted((A/'batches').glob('*.tsv')),A/'corpus.py',A/'locale.json',A/'display-spans.json',A/'unchanged-reasons.json',A/'check_poetry.py',A/'poetry-scansion-provenance.json',A/'poetry-validation.json',A/'dialogue.de.jsonl',O/'before-overlay.jsonl',O/'after-overlay.jsonl',O/'selector.json',O/'build-cycle.py',O/'adjudication.jsonl',P/'result.json',P/'reviews.jsonl',P/'output-manifest.json',P/'repaired-closure-ids.txt',P/'review-validation.json',P/'poetry-review.jsonl',P/'reviewed-components.jsonl']:
    inputs[str(p)]=sha(p.read_bytes())
for p in dispatch['inputPins']:
    if '/assets/source-v2/' in p:inputs[p]=sha(pathlib.Path(p).read_bytes())
for p in [R/'localization/es-419-assets/consumer-evidence-0035/DialogueEntry.il',R/'localization/es-419-assets/consumer-evidence-0035/LoaderRecursion.il',R/'localization/ru-assets/consumer-evidence-0024/BuildDynamicConversation.il']:
    inputs[str(p)]=sha(p.read_bytes())
dump(C/'input-fingerprints.json',inputs)
for name in ('adjudication.jsonl','preflight.json','consumer-preflight.jsonl','build-verification.json','application-receipt.json','poetry-regression.json','rollback-regression.json','runtime-check.json','selector.json'):(C/name).write_bytes((O/name).read_bytes())
manifest={'cycle':'cycle-02','status':'corrections-applied-awaiting-independent-review','changedIds':len(changed),'closureIds':len(closure),'previousReviewedIds':len(prior),'deltaIds':len(delta),'newDependencyIds':len(closure-set(prior)),'explicitlyInvalidatedIds':len(invalid),'removedDependencyIds':len(set(prior)-closure),'retainedPerIdReceipts':len(retained),'retainedVerdicts':dict(collections.Counter(x['verdict'] for x in retained)),'retainedContextReceipts':len(components),'retainedPoetryReceipts':len(poetry),'components':{k:len(v) for k,v in parts.items()},'nontranslationContextRecords':len(context),'deltaFormula':'changed + (current closure - prior 5377 reviewed IDs) + explicitly invalidated IDs','encoding':'UTF-8, LF per ID/JSONL record, final LF; embedded LF/CR retained as JSON escapes','bounds':spec['bounds'],'runtime':'not-run','independentReview':'pending different fresh reviewer; no author self-acceptance','files':{p.name:sha(p.read_bytes()) for p in sorted(C.iterdir()) if p.is_file()}}
dump(C/'manifest.json',manifest)
print(enc({k:v for k,v in manifest.items() if k not in ('files','components')}))
