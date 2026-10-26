"""Freeze bounded source/consumer evidence; never generate translated wording."""
import collections, hashlib, json, pathlib, shutil
ROOT=pathlib.Path(__file__).resolve().parents[2]
HERE=pathlib.Path(__file__).resolve().parent
PHASE=ROOT/'outputs/locale-assets-20261026/ja/0031-translation'
def sha(raw): return hashlib.sha256(raw).hexdigest()
def freeze(path,data):
    raw=(json.dumps(data,ensure_ascii=False,indent=2)+'\n').encode()
    if path.exists(): assert path.read_bytes()==raw, 'Immutable evidence differs: '+str(path)
    else: path.parent.mkdir(parents=True,exist_ok=True);path.write_bytes(raw)
def ref(path): return {'path':str(path.relative_to(ROOT)),'sha256':sha(path.read_bytes())}
def main():
    fp=ROOT/'outputs/locale-assets-20261026/ja/owner-capacity-repair-20261027-044359/shared-source-facts.json'
    assert sha(fp.read_bytes())=='79985ab38967abf481d50be2c155c81f9caa3d37e690a9cdcd1da6b50564eec5'
    facts={r['id']:r for r in json.loads(fp.read_text())['records']}
    rows=[json.loads(s) for s in (ROOT/'localization/source/dialogue-candidates.jsonl').read_text().splitlines()]
    before=json.loads((PHASE/'before.json').read_text()); held=before['held']
    if isinstance(held,list): held={r if isinstance(r,str) else r['id'] for r in held}
    detached=[r for r in rows if r['id'] in held and r['id'] in facts and facts[r['id']]['disposition']=='preserved-detached-source']
    end=detached[397]['conversationId']
    selected=detached[:398]+[r for r in detached[398:] if r['conversationId']==end]
    flowers=[r for r in rows if r['id'] in ['ds:131:153:Dialogue Text','ds:540:232:Dialogue Text']]
    selected_ids={r['id'] for r in selected+flowers}
    selected=[r for r in rows if r['id'] in selected_ids]
    man=json.loads((ROOT/'localization/source/dialogue-manifest.json').read_text())
    trees=[]
    for source in man['sources']:
        p=ROOT/source['tree']; assert sha(p.read_bytes())==source['treeSha256']; trees.append(json.loads(p.read_text()))
    assert trees[0]['conversations']==trees[1]['conversations']
    nodes={}; graph={}; incoming=collections.defaultdict(list); roots=set()
    for c in trees[0]['conversations']:
        for i,e in enumerate(c['dialogueEntries']):
            key=(c['id'],e['id']);assert key not in nodes
            nodes[key]=e; f={v['title']:v['value'] for v in e['fields']}
            if i==0 or e['isRoot'] or f.get('Title','').strip() or f.get('TfolUniqueDataKeySuffix','').strip(): roots.add(key)
            graph[key]=[(x['destinationConversationID'],x['destinationDialogueID']) for x in e['outgoingLinks']]
            for dest in graph[key]: incoming[dest].append(key)
    seen=set(roots); todo=list(roots)
    while todo:
        for dest in graph.get(todo.pop(),[]):
            assert dest in nodes,'Dangling source link'
            if dest not in seen:seen.add(dest);todo.append(dest)
    proofs=[]
    for r in selected:
        f=facts[r['id']]; assert f['sourceSha256']==sha(r['source'].encode())
        key=(r['conversationId'],r['entryId']); e=nodes[key]
        if f['disposition']=='preserved-detached-source':
            assert f['preserveExactly']==r['source']; assert key not in seen and key not in roots
        else: assert key in seen
        for tree in trees:
            value=tree
            for k in r['pointer'].strip('/').split('/'):value=value[int(k)] if isinstance(value,list) else value[k]
            assert value==r['source']
        proofs.append({'id':r['id'],'sourceSha256':f['sourceSha256'],'pointer':r['pointer'],'occurrences':r['occurrences'],'entry':e,'incoming':incoming[key],'outgoing':graph[key],'isConservativeRoot':key in roots,'reachableFromConservativeRoots':key in seen})
    sourcefacts={'provenance':ref(fp),'scope':'Exact source/consumer facts for this bounded group; no target-language wording imported.','records':[facts[r['id']] for r in selected]}
    freeze(PHASE/'source-facts.json',sourcefacts)
    evidence_paths={e['path']:e['sha256'] for r in selected for e in facts[r['id']]['consumerEvidence']}
    verified=[]; copies=[]
    for rel,h in sorted(evidence_paths.items()):
        p=ROOT/rel; assert sha(p.read_bytes())==h,rel
        verified.append({'path':rel,'sha256':h})
        # Only raw consumer code is copied. Other-lane source topology stays read-only;
        # the independently rebuilt bounded topology below is the own-lane evidence.
        if p.suffix in ['.il','.cs']:
            dest=PHASE/'consumer-evidence'/p.name
            if dest.exists():assert dest.read_bytes()==p.read_bytes()
            else:dest.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(p,dest)
            copies.append(ref(dest))
    freeze(PHASE/'consumer-verification.json',{'verifiedOriginals':verified,'ownLaneConsumerCopies':copies,'boundary':'Hash binding to supplied static consumer evidence. No runtime claim.'})
    freeze(PHASE/'source-topology.json',{'manifestSha256':sha((ROOT/'localization/source/dialogue-manifest.json').read_bytes()),'sourceTrees':man['sources'],'rootRule':'All first, isRoot, titled or arc-keyed entries across all conversations; traverse all cross-conversation outgoing links while ignoring conditions.','nodes':len(nodes),'rootIds':sorted(roots),'reachableNodes':len(seen),'records':proofs,'limits':'Bounded static source evidence; arbitrary external direct-node calls and runtime visibility remain unverified. No IDs removed.'})
    print(json.dumps({'selected':len(selected),'detached':len(selected)-len(flowers),'flowers':len(flowers),'lastDetached':detached[len(selected)-len(flowers)-1]['id'],'nodes':len(nodes),'roots':len(roots),'reachable':len(seen),'consumerFiles':len(copies)}))
if __name__=='__main__':main()
