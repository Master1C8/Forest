"""Bind explicit author poem judgments to unchanged exact rows and retained peers."""
import pathlib,json,hashlib,itertools,re
R=pathlib.Path(__file__).parent;ROOT=R.parents[3];A=ROOT/'localization/ru-assets';sha=lambda b:hashlib.sha256(b).hexdigest()
load=lambda p:[json.loads(l) for l in p.read_text().splitlines()]
cur={x['id']:x for x in load(A/'dialogue.ru.jsonl')};old={x['id']:x for x in load(R/'before/localization/ru-assets/dialogue.ru.jsonl')};prior={x['id']:x for x in load(R/'merged-reviews.jsonl')};auth=json.loads((R/'poem-judgments.authored.json').read_text());report=json.loads((A/'poetry-validation.json').read_text());assert report['checkedSelectableCombinations']==27
strip=lambda s:re.sub(r'^(?:\[pic[ac]?=[0-9A-Za-z_]+\])*','',s)
syll=lambda s:len(re.findall('[аеёиоуыэюя]',s.lower()))
ctx=json.loads((ROOT/'outputs/editorial-20261027/independent-batches-v1/ru/source-context.json').read_text());nodes={n['id']:n for c in ctx['conversations'] if c['id']==303 for n in c['dialogueEntries']}
dests=lambda n:{x['destinationDialogueID'] for x in nodes[n]['outgoingLinks']}
assert dests(419)=={325,410,406} and dests(404)=={599} and dests(599)=={411,407,326} and dests(413)=={600} and dests(600)=={408,327,412}
for e in [325,406,410]:assert dests(e)=={404}
for e in [326,407,411]:assert dests(e)=={413}
for e in [327,408,412]:assert dests(e)=={416}
for n in [419,325,406,410,404,599,326,407,411,413,600,327,408,412,416]:assert nodes[n]['conditionsString']=='' and nodes[n]['userScript']==''
products=auth['selectableProducts'];expected=set(itertools.product([325,406,410],[326,407,411],[327,408,412]));assert {tuple(x['ids']) for x in products}==expected and len(products)==27
allids=set();assembled=[]
for x in products:
 ids=['ds:303:'+str(n)+':Dialogue Text' for n in x['ids']];allids.update(ids);s='\n'.join(strip(cur[i]['source']) for i in ids);t='\n'.join(strip(cur[i]['target']) for i in ids);counts=list(map(syll,t.split('\n')));assert counts==[5,7,5]
 assembled.append({**x,'stableIds':ids,'source':s,'target':t,'syllables':counts,'sourceSha256':sha(s.encode()),'targetSha256':sha(t.encode())})
for x in auth['fullPoemGroups']:
 for e in x['ids']:allids.add('ds:'+e+':Dialogue Text')
callbacks=['ds:300:483:Dialogue Text','ds:300:484:Dialogue Text','ds:302:520:Dialogue Text','ds:303:330:Dialogue Text'];allids.update(callbacks)
receipts=[];missing=[]
for i in sorted(allids):
 assert cur[i]==old[i],i+' changed poem/callback row'
 p=prior.get(i)
 if p:
  assert p['sourceSha256']==cur[i]['sourceSha256'] and p['targetSha256']==cur[i]['targetSha256'];receipts.append(p)
 else:missing.append(i)
lines=strip(cur['ds:302:516:Dialogue Text']['target']).split('\n')
for i,l in zip(callbacks[:2],lines):assert strip(cur[i]['target']).strip('"., ')==l.strip('"., ')
assert lines[-1].strip('.').upper() in strip(cur[callbacks[2]]['target'])
assert 'Как мне повезло' in cur['ds:303:343:Dialogue Text']['target'] and 'Как нам повезло' in cur['ds:303:330:Dialogue Text']['target']
result={'status':'unchanged-poem-and-callback-rows-verified','actualGraphProducts':27,'sourceGraphPredicates':'three unconditional source-linked slots with exact bridge/penny/bug choices and unchanged timing nodes','explicitAuthorJudgments':auth,'assembledProducts':assembled,'allBoundIds':sorted(allids),'retainedExactPriorIndependentReceipts':receipts,'missingPriorReceiptIds':missing,'canonicalCheckerSha256':sha((A/'check_poetry.py').read_bytes()),'canonicalCheckerAssertionsChanged':False,'canonicalReportSha256':sha((A/'poetry-validation.json').read_bytes()),'sourceContextSha256':sha((ROOT/'outputs/editorial-20261027/independent-batches-v1/ru/source-context.json').read_bytes()),'currentOverlaySha256':sha((A/'dialogue.ru.jsonl').read_bytes()),'linguisticStatus':'Actual authored judgments and unchanged prior peer receipts are distinct from syllable checks; no author review is newly credited as independent','runtime':'not-run'}
(R/'poem-and-scansion-verification.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n');print(json.dumps({'products':27,'boundIds':len(allids),'retainedPeerReceipts':len(receipts),'missingPriorReceipts':missing,'status':'passed'}))
