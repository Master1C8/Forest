"""Verify existing receipt versions; never create new semantic pass rows."""
import hashlib
import json
import pathlib

ROOT = pathlib.Path('/Users/antonkrutov/Desktop/Forest')
OUT = pathlib.Path(__file__).resolve().parent
pins = json.loads((OUT/'input-pins.json').read_text())

def sha(b):
    return hashlib.sha256(b).hexdigest()

def read(p):
    p = ROOT / p
    b = p.read_bytes()
    pins[str(p)] = {'sha256':sha(b),'bytes':len(b)}
    return b.decode()

def jread(p):
    return json.loads(read(p))

def lines(p):
    return [json.loads(l) for l in read(p).splitlines()]

selected = [json.loads(l) for l in (OUT/'selected-source-context.jsonl').read_text().splitlines()]
targets = {x['value']['id']:x for x in selected if x['kind']=='unchanged-accepted-target-reference'}
inv = 'localization/supplemental-ui/20261028-inventory/'
ui = 'localization/supplemental-ui/20261029-existing935/'
checks, retained = [], []
for packet, base in [('inventory52',inv),('ui935',ui)]:
    acceptance = jread(base+'ru.acceptance.json')
    assert sha(read(base+'ru.edited.jsonl').encode()) == acceptance['targetSha256']
    if packet == 'inventory52':
        for path, expected in acceptance['evidencePins'].items():
            actual = sha(read(path).encode())
            checks.append({'path':path,'expected':expected,'actual':actual,'matches':actual==expected})
            assert actual == expected, path
        jobs = ['outputs/inventory-display-20261028/initial-01','outputs/inventory-display-20261028/independent-01']
    else:
        for e in acceptance['evidence'].values():
            actual = sha(read(base+e['file']).encode())
            assert actual == e['sha256']
            checks.append({'path':base+e['file'],'expected':e['sha256'],'actual':actual,'matches':True})
        full = jread(base+'ru935.fullSemantic.json')
        independent = jread(base+'ru935.independent.json')
        assert full['targetSha256'] == independent['targetSha256'] == acceptance['targetSha256']
        jobs = [full['originatingJob'],independent['originatingJob']]
    threads = []
    for layer, job in zip(['full','independent'], jobs):
        runtime = jread(job+'/review/runtime-verification.json')
        turn = runtime['actualRuntime']['turn']
        session = runtime['actualRuntime']['session']
        assert turn == {'model':'gpt-6.1-sol','effort':'high'}
        assert session['model_provider']=='openai' and session.get('parent_thread_id') is None
        assert runtime['freshExecNoResumeNoFork']
        threads.append(runtime['threadId'])
        pairs = {x['id']:x for x in lines(job+'/pairs.jsonl')}
        reviews_path = job+'/review/reviews.jsonl'
        reviews = lines(reviews_path)
        result = jread(job+'/review/result.json')
        assert sha(read(reviews_path).encode()) == result['reviewsSha256']
        for r in reviews:
            if r['id'] not in targets or targets[r['id']]['reference']['packet']!=packet:
                continue
            current = targets[r['id']]['value']
            pair = pairs[r['id']]
            assert pair['source']==current['source'] and pair['target']==current['target']
            assert r['verdict']=='pass'
            assert r['sourceSha256']==sha(current['source'].encode())
            assert r['targetSha256']==sha(current['target'].encode())
            retained.append({'caseId':targets[r['id']]['caseId'],'id':r['id'],'layer':layer,
                'packet':packet,'reviewPath':reviews_path,'reviewFileSha256':result['reviewsSha256'],
                'threadId':runtime['threadId'],'runtimePath':job+'/review/runtime-verification.json',
                'runtimeSha256':pins[str(ROOT/job/'review/runtime-verification.json')]['sha256'],
                'originalRow':r,'versionMatch':True,'newSemanticPass':False})
    assert len(set(threads))==2
assert len(retained)==8
for id in targets:
    assert {r['layer'] for r in retained if r['id']==id}=={'full','independent'}

# Read target context is a binding aid, not a new acceptance layer.
context = []
for x in lines('localization/ru-assets/dialogue.ru.jsonl'):
    if x['conversationId'] in [128,129,276,414,423] or (x['conversationId']==409 and x['entryId']>=783):
        context.append(x)
(OUT/'selected-target-context.jsonl').write_text(''.join(json.dumps(x,ensure_ascii=False,separators=(',',':'))+'\n' for x in context))
(OUT/'retained-receipts.jsonl').write_text(''.join(json.dumps(x,ensure_ascii=False,separators=(',',':'))+'\n' for x in retained))
(OUT/'receipt-verification.json').write_text(json.dumps({'status':'verified','retainedRows':8,
    'acceptedTargetIds':4,'independentThreadPairs':2,'checks':checks,
    'boundary':'Version-matching prior semantic verdicts only; no new wording pass; unrelated corrected rows not retained.'},indent=2)+'\n')
(OUT/'input-pins.json').write_text(json.dumps(pins,indent=2)+'\n')
print(json.dumps({'status':'verified','retainedRows':len(retained),'targetContextRows':len(context),'pinChecks':len(checks)}))
