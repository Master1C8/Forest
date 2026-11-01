"""Reconcile exact existing model evidence; never manufacture semantic verdicts."""
import hashlib,json
from pathlib import Path
R=Path(__file__).resolve().parents[3]
D=R/'localization/editorial-delivery/ja-single-file-20261101-01'
O=R/'outputs/ja-single-file-20261101-01'
C=R/'localization/completion/ja-single-file-20261101-01'
read=lambda p:json.loads(p.read_bytes())
rows=lambda p:[json.loads(x) for x in p.read_text().splitlines() if x.strip()]
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
bind=lambda p:dict(path=str(p.relative_to(R)),sha256=sha(p))
textsha=lambda s:hashlib.sha256(s.encode()).hexdigest()
lang=read(R/'localization/languages/ja.json');primary=rows(D/'primary-packet.jsonl');bindings=rows(D/'primary-reading-bindings.jsonl')
assert len(primary)==len(bindings)==12825
old=read(D/'ja.json');by={r['id']:r for r in primary};assert len(by)==12825
for b in bindings:
 r=by[b['id']];assert b['sourceSha256']==r['sourceSha256']==textsha(r['source'])
 assert b['finalTargetSha256']==r['targetSha256']==textsha(r['target'])
 assert old['translations'][r['id']]==dict(source=r['source'],target=r['target'])
coverage=read(D/'author-coverage.json');assert coverage['primaryRead']==12825 and not coverage['primaryUnreadIds'] and coverage['finalNull']==0
changes=read(D/'repair-01/changes.json')['changes'];changed={r['id'] for r in changes}
assert changed=={i for i,v in lang['translations'].items() if v!=old['translations'][i]} and len(changed)==7
accepted={};superseded=[]
for phase,count in [('independent-01',607),('independent-delta-01',21)]:
 p=O/phase;receipt=read(p/'process-exit.json');assert receipt['exitCode']==0
 rt=read(p/'runtime-verification.json');assert rt['actualRuntime']['turn']==dict(model='gpt-6.1-sol',effort='high')
 assert rt['actualRuntime']['session']['model_provider']=='openai' and rt['actualRuntime']['session']['parent_thread_id'] is None
 judgments=rows(p/'review-output/reviews.jsonl');assert len(judgments)==count
 assert not read(p/'review-output/pending-ledger.json')['pendingIds']
 for j in judgments:
  current=lang['translations'][j['id']]
  matching=j['sourceSha256']==textsha(current['source']) and j['targetSha256']==textsha(current['target'])
  if matching and j['verdict']=='pass':accepted[j['id']]=dict(j,receipt=bind(p/'review-output/reviews.jsonl'))
  else:
   assert phase=='independent-01' and j['id'] in changed and j['verdict']=='finding'
   superseded.append(j['id'])
 assert read(p/'review-output/pending-ledger.json')['contextComplete'] is True
assert len(accepted)==610 and len(superseded)==4 and changed<=set(accepted)
assert all(accepted[i]['verdict']=='pass' for i in changed)
context=rows(O/'independent-01/context-observations.jsonl');assert {r['id'] for r in context}<=changed
final=rows(O/'independent-delta-01/review-output/reviews.jsonl');assert all(j['verdict']=='pass' for j in final)
proof=dict(status='current-game-text-editorial-accepted-under-pinned-glossary-and-owner-poetic-decision',language=bind(R/'localization/languages/ja.json'),primaryOrdinaryUnits=12825,primaryUnread=[],sourcePreservedUnits=1781,catalogUnits=14606,initialNullFilled=211,primaryAuthorDelta=456,consolidatedFinalChanges=7,independentCurrentUniqueVersions=len(accepted),independentAssignedCounts=[607,21],requiredContextCounts=[845,207],unreadIndependent=[],unreadRequiredContext=[],unresolvedObjectiveFindings=[],supersededFindingIds=superseded,contextObservationsResolved=[r['id'] for r in context],ownerPoetryDecision=bind(D/'repair-01/owner-poetry-decision.json'),primaryEvidence=bind(D/'manifest.json'),remainingGates=['owner-deferred human NSFW glossary review','native CFF loading/shaping/fallback/atlas/layout','actual game behavior','installer/release/publication/deployment'],boundary='Primary actual whole-corpus reading and exact current independent correction/dependency closure. 610 is the union of verified current model verdicts, not whole-corpus independent coverage. No default passes, old finding waiver, native or release acceptance.')
(C/'editorial-closure.json').write_text(json.dumps(proof,ensure_ascii=False,indent=2)+'\n')
(C/'current-independent-verdicts.jsonl').write_text(''.join(json.dumps(accepted[i],ensure_ascii=False)+'\n' for i in sorted(accepted)))
print(json.dumps(dict(primary=12825,independentCurrent=len(accepted),supersededFindings=len(superseded),finalDelta=21,unresolved=0)))
