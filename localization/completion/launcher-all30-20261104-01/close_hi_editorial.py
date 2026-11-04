"""Bind actual independent Hindi bodies to the final ordinary/artwork versions."""
from pathlib import Path
import json,hashlib
R=Path('/Users/antonkrutov/Desktop/Forest');A=R/'outputs/launcher-all30-20261104-01/hi/review-auto-0001';P=R/'outputs/launcher-all30-20261104-01/hi/independent-delta-01';D=R/'localization/editorial-delivery/launcher-all30-20261104-01/hi';lang=R/'localization/languages/hi.json'
def rows(p):return [json.loads(l) for l in p.read_text().splitlines() if l.strip()]
def h(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def sh(s):return hashlib.sha256(s.encode()).hexdigest()
r=json.loads((P/'result.json').read_bytes());v=r['verifiedReviewCoverage'];assert v['assigned']==v['judged']==6 and not v['unreadIds'] and not v['pendingIds'] and v['nonPassRows']==0;assert json.loads((P/'process-exit.json').read_bytes())['exitCode']==0
basis={r['id']:r for r in rows(D/'repair-01/bounded-final-basis.jsonl')};coverage=rows(P/'context-reading-coverage.jsonl');assert len(coverage)==len(basis)==68 and {r['id'] for r in coverage}==set(basis)
for row in coverage:assert row['reading']=='complete' and all(row[k]==basis[row['id']][k] for k in ['sourceSha256','targetSha256','sourceContextSha256'])
assert json.loads((A/'context-reading-coverage.json').read_bytes())['contextComplete']
controller=json.loads((R/'outputs/launcher-all30-20261104-01/hi-review-controller/status.json').read_bytes())['lanes'][0]
aggregate=R/controller['aggregateReviews'];old=rows(aggregate);assert len(old)==12831
findings={r['id'] for r in old if r['verdict']=='finding'};new=rows(R/r['reviews']);assert len(new)==len(findings)==6 and {r['id'] for r in new}==findings
merged={r['id']:r for r in old if r['verdict']=='pass'};assert len(merged)==12825
for row in new:assert row['verdict']=='pass' and row['id'] not in merged;merged[row['id']]=row
tr=json.loads(lang.read_bytes())['translations'];before=json.loads((D/'repair-01/language-before.json').read_bytes());after=json.loads(lang.read_bytes());assert {k:v for k,v in before.items() if k!='translations'}=={k:v for k,v in after.items() if k!='translations'}
packet={r['id']:r for r in rows(R/'localization/editorial-delivery/last-six-locales-20261103-01/hi/author-auto-0001/independent-review/review-packet.jsonl')};ordinary={};art={}
for i,row in merged.items():
 value=tr[i] if i in tr else packet[i];assert row['sourceSha256']==sh(value['source']) and row['targetSha256']==sh(value['target']),('stale',i)
 (ordinary if i in tr else art)[i]=row
pres=json.loads((R/'localization/completion/five-new-locales-20261101-01/source-preservation.json').read_bytes())['baselinePreserved'];assert set(ordinary)==set(tr)-set(pres) and len(ordinary)==12825 and len(art)==6
for i,s in pres.items():assert sh(tr[i]['source'])==sh(tr[i]['target'])==s
out=D/'editorial-closure-01';out.mkdir(exist_ok=False)
for name,data in [('complete-primary-judgments.jsonl',ordinary),('artwork-wording-judgments.jsonl',art)]:out.joinpath(name).write_text(''.join(json.dumps(row,ensure_ascii=False)+'\n' for row in data.values()))
files=[aggregate,A/'context-reading-coverage.json',P/'result.json',P/'context-reading-coverage.jsonl',P/'runtime-verification.json',P/'process-exit.json',D/'repair-01/manifest.json']
closure=dict(format='forest-editorial-closure-v1',locale='hi',languageSha256=h(lang),ordinaryRequired=12825,ordinaryExactCurrentPasses=12825,extraArtworkWordingPasses=6,protectedSourceStates=1781,actualFinalDeltaPasses=6,duplicateOrStaleJudgments=0,unreadPrimaryOrRequiredContexts=0,openFindings=0,editorial='independent-current-version-closure-verified',evidence=[dict(path=str(p.relative_to(R)),sha256=h(p)) for p in files],nativeRuntime='not-run',devanagariShaping='not-run',rendererAcceptance='not-run',humanGlossary='owner-deferred',releaseAcceptance=False)
(out/'closure.json').write_text(json.dumps(closure,indent=2)+'\n');print(json.dumps({k:v for k,v in closure.items() if k!='evidence'}))
