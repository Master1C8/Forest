import json,pathlib,hashlib
R=pathlib.Path('/Users/antonkrutov/Desktop/Forest');C=R/'outputs/ru-remaining51-case-wording-20261029/check';O=R/'localization/supplemental-ui/20261029-remaining-case51'
a=[json.loads(l) for l in (O/'source-context.jsonl').open()];w=json.loads((C/'authored-wording.json').read_text());word={i:(t,n) for i,t,n in w};assert len(word)==48
reusepath=R/'localization/supplemental-ui/20261029-chapter-gallery-case/ru.edited.jsonl';reuse={r['id']:r for r in map(json.loads,reusepath.open())}
rows=[]
for c in a:
 i=c['ordinal'];old=reuse.get(c['id']) if i in [19,20,21] else None
 t,n=(old['target'],'Exact accepted target and matching source/ID reused; receipts remain version-bound, not a new independent judgment.') if old else word[i]
 r={k:c[k] for k in ['id','ordinal','family','source','sourceValueSha256','sourceUtf8Sha256','sourceState']}
 r.update(target=t,targetUtf8Sha256=hashlib.sha256(t.encode()).hexdigest(),locale='ru',status='reused-accepted-wording' if old else 'prepared-author-edited',wordingDecision=n,reusedEvidence=c.get('reuseEvidence'),targetApplied=False,independentReview='retained-version-matching-receipts' if old else 'pending',sourceContext='source-context.jsonl#'+str(i+1))
 rows.append(r)
for name in ['ru.initial.jsonl','ru.prepared.jsonl']:
 p=O/name;assert not p.exists();p.write_text(''.join(json.dumps(r,ensure_ascii=False)+'\n' for r in rows))
print('Bound',len(rows),'rows; reused',sum(r['status']=='reused-accepted-wording' for r in rows),'new',len(word))
