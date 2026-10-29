"""Read-only receipt/version checks. These never generate semantic acceptance."""
import contextlib
import io
from reconcile import *

checks = []

def check(name, predicate, detail=None):
    checks.append({'predicate': name, 'passed': bool(predicate), 'detail': detail})

def pin(path, expected):
    try:
        b = read(path).encode()
        check('pin:' + str(path), digest(b) == expected)
    except FileNotFoundError:
        check('pin:' + str(path), False, 'missing evidence; not reusable')

def pinned_map(mapping):
    for path, rec in mapping.items():
        pin(path, rec if isinstance(rec,str) else rec['sha256'])

def run():
    with contextlib.redirect_stdout(io.StringIO()):
        registry, roles, source, targets, narrative, bindings = build()
    check('all23 registry cases', len(registry['cases']) == 23)
    check('all binding raw values and typed hashes',all(r['typedHashMatches'] and r['rawValueHashMatches'] for r in bindings))
    for folder in ['20261028-inventory', '20261028-glitch', '20261029-existing935', '20261029-chapter-gallery-case']:
        prefix='localization/supplemental-ui/'+folder+'/'
        a=js(prefix+'ru.acceptance.json')
        targetfile=a.get('targetFile','ru.jsonl')
        pin(prefix+targetfile,a['targetSha256'])
        pinned_map(a.get('evidencePins',{}))
        for key,rec in a.get('evidence',{}).items():
            pin(prefix+rec['file'],rec['sha256'])
            rr=js(prefix+rec['file'])
            check(folder+':'+key+':target version',rr['targetSha256']==a['targetSha256'] and rr['status']=='passed')
        if folder=='20261029-existing935':
            pin('localization/supplemental-ui/20261027/ru.jsonl',a['baseTargetSha256'])
            pin('localization/supplemental-ui/20261027/source-catalog.json',a['sourceCatalogSha256'])
            for label in ['fullSemantic','independent']:
                summary=js(prefix+a['evidence'][label]['file'])
                job=summary['originatingJob']+'/'
                pin(job+'review/reviews.jsonl',summary['reviewsSha256'])
                pairs=jl(job+'pairs.jsonl');reviews=jl(job+'review/reviews.jsonl')
                pm={r['id']:r for r in pairs};rm={r['id']:r for r in reviews}
                check('ui935:'+label+':exact coverage',len(pm)==len(rm)==935 and pm.keys()==rm.keys())
                check('ui935:'+label+':receipt versions',all(r['sourceSha256']==digest(pm[k]['source'].encode()) and r['targetSha256']==digest(pm[k]['target'].encode()) for k,r in rm.items()))
                if label=='independent':
                    final={r['id']:r for r in jl(prefix+targetfile)}
                    check('ui935:independent final pairs',all(pm[k]['source']==final[k]['source'] and pm[k]['target']==final[k]['target'] for k in pm))
                    check('ui935:independent clean',all(r['verdict']=='pass' for r in reviews))
        if folder=='20261029-chapter-gallery-case':
            for name,h in a['sourcePins'].items():pin('localization/source/chapter-gallery-case-20261029/'+name,h)
            pinned_map(a['dependencyPins'])
            full=jl('outputs/chapter-gallery-review-20261029/independent-01/review/reviews.jsonl')
            delta=jl('outputs/chapter-gallery-review-20261029/final-delta-01/review/reviews.jsonl')
            receipt=js(prefix+'ru.independentCleanDelta.json')
            pin('outputs/chapter-gallery-review-20261029/independent-01/review/reviews.jsonl',receipt['fullReviewsSha256'])
            pin('outputs/chapter-gallery-review-20261029/final-delta-01/review/reviews.jsonl',receipt['deltaReviewsSha256'])
            rm={r['id']:r for r in full};rm.update({r['id']:r for r in delta})
            final={r['id']:r for r in jl(prefix+targetfile)}
            check('chapter134:full plus final delta exact coverage',len(rm)==len(final)==134 and rm.keys()==final.keys())
            check('chapter134:full plus delta current versions clean',all(r['sourceSha256']==digest(final[k]['source'].encode()) and r['targetSha256']==digest(final[k]['target'].encode()) and r['verdict']=='pass' for k,r in rm.items()))
            summary=js(prefix+'ru.fullSemantic.json')
            pin(prefix+'author-semantic-audit-134.json',summary['fullAuthorAuditSha256'])
            pin(prefix+'ru.author-final-semantic.json',summary['finalAuthorJudgmentSha256'])
    current=js('localization/editorial-delivery/ru-current.json')
    pin(current['currentCorpus']['path'],current['currentCorpus']['sha256'])
    relevant=['initial/job.json','author/delivery-manifest.json','author/poem-and-scansion-verification.json','cycle/manifest.json','cycle/retention-verification.json','cycle/retained-reviews.jsonl','peer/job.json','peer/0001-semantic/reviews.jsonl','parent/post-peer-validation.json']
    for suffix in relevant:
        path='localization/editorial-delivery/ru-cycle-02/'+suffix
        pin(path,current['evidence'][path]['sha256'])
    dm={r['id']:r for r in jl(current['currentCorpus']['path'])}
    retained=jl('localization/editorial-delivery/ru-cycle-02/cycle/retained-reviews.jsonl')
    peer=jl('localization/editorial-delivery/ru-cycle-02/peer/0001-semantic/reviews.jsonl')
    rm={r['id']:r for r in retained+peer}
    check('dialogue retained and peer current versions',all(r['sourceSha256']==dm[k]['sourceSha256'] and r['targetSha256']==dm[k]['targetSha256'] for k,r in rm.items()))
    haiku=js(BASE+'phase134/haiku-source-dependencies.json')
    check('haiku194 exact125 editorial and69 preservation receipts',len(haiku['sourceIds'])==194 and collections.Counter(rm[k]['verdict'] for k in haiku['sourceIds'])=={'pass':125,'technical-preservation':69} and all(rm[k]['verdict']=='pass' or dm[k]['source']==dm[k]['target'] for k in haiku['sourceIds']))
    for suffix in ['ru-reuse-review-adoption','penny-factory-adoption']:
        adoption=js('localization/source/narrative-displays-20261029.'+suffix+'.json')
        pinned_map(adoption['pins'])
    handoff=js('localization/glossary/inventory-display-20261028/handoff.json')
    pin('localization/glossary/inventory-display-20261028/en.json',handoff['sourceSha256'])
    pin('localization/glossary/inventory-display-20261028/ru.json',handoff['russianSha256'])
    pinned_map(handoff['evidencePins'])
    policy=jl('localization/source/inventory-display-completion-20261028/approved-preservation.jsonl')
    check('owner policy exact3047 family partition',collections.Counter(r['family'] for r in policy)=={'dialogue-database':1655,'rewired-system':1389,'compiled-technical':3})
    pm={}
    for r in policy:
        for oid in r.get('occurrences',[r['id']]): pm[oid]=r
    for b in bindings:
        if b['bindingId'] in pm:
            check('selected owner preservation:'+b['bindingId'],b['sourceValueSha256']==pm[b['bindingId']]['sourceValueSha256'])
    write(CHECK/'receipt-verification.json',{'checks':checks,'passed':all(r['passed'] for r in checks),'semanticJudgmentGenerated':False})
    write(CHECK/'verified-input-pins.json',PINS)
    print('checks',len(checks),'failed',sum(not r['passed'] for r in checks))
    for r in checks:
        if not r['passed']:print(r)

if __name__=='__main__':run()
