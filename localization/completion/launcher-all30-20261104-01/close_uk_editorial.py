"""Verify complete retained-plus-delta Ukrainian editorial evidence."""
from pathlib import Path
import json,hashlib,sys
R=Path('/Users/antonkrutov/Desktop/Forest');sys.path.insert(0,str(R/'tools'));from locale_efficiency import canonical
P=R/'outputs/launcher-all30-20261104-01/uk/independent-delta-01';D=R/'localization/editorial-delivery/launcher-all30-20261104-01/uk';lang=R/'localization/languages/uk.json'
def rows(p):return [json.loads(l) for l in p.read_text().splitlines() if l.strip()]
def h(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def sh(s):return hashlib.sha256(s.encode()).hexdigest()
def ch(row):return sh(canonical({k:row.get(k) for k in ['context','consumerContext']}))
r=json.loads((P/'result.json').read_bytes());v=r['verifiedReviewCoverage'];assert v['assigned']==v['judged']==20 and not v['unreadIds'] and not v['pendingIds'] and v['nonPassRows']==0;assert json.loads((P/'process-exit.json').read_bytes())['exitCode']==0
required={r['id']:r for r in rows(D/'repair-01/required-context-final.jsonl')};ledger=rows(P/'required-context-ledger.jsonl');assert len(required)==len(ledger)==1077 and {r['id'] for r in ledger}==set(required);pins={}
for row in ledger:
 source=required[row['id']];assert all(row[k]==source[k] for k in ['sourceSha256','targetSha256']) and row['contextSha256']==ch(source)
 assert row['notLinguisticCoverage'] is True and row['targetEdited'] is False
 evidence=row['priorOwnEvidence'];pins.setdefault(evidence['path'],h(R/evidence['path']));assert pins[evidence['path']]==evidence['sha256']
controller=json.loads((R/'outputs/launcher-all30-20261104-01/uk-review-controller/status.json').read_bytes())['lanes'][0];aggregate=R/controller['aggregateReviews'];old=rows(aggregate);assert len(old)==12825
findings={row['id'] for row in old if row['verdict']=='finding'};new=rows(R/r['reviews']);assert len(findings)==len(new)==20 and {row['id'] for row in new}==findings
merged={row['id']:row for row in old if row['verdict']=='pass'};assert len(merged)==12805
packet={row['id']:row for row in rows(D/'repair-01/independent-delta/review-packet.jsonl')}
for row in new:
 assert row['verdict']=='pass' and row['id'] not in merged and row['contextSha256']==ch(packet[row['id']]);merged[row['id']]=row
tr=json.loads(lang.read_bytes())['translations'];before=json.loads((D/'repair-01/language-before.json').read_bytes());after=json.loads(lang.read_bytes());assert {k:v for k,v in before.items() if k!='translations'}=={k:v for k,v in after.items() if k!='translations'}
for i,row in merged.items():assert row['sourceSha256']==sh(tr[i]['source']) and row['targetSha256']==sh(tr[i]['target']),('stale',i)
pres=json.loads((R/'localization/completion/five-new-locales-20261101-01/source-preservation.json').read_bytes())['baselinePreserved'];assert set(merged)==set(tr)-set(pres) and len(merged)==12825
for i,s in pres.items():assert sh(tr[i]['source'])==sh(tr[i]['target'])==s
out=D/'editorial-closure-01';out.mkdir(exist_ok=False);(out/'complete-primary-judgments.jsonl').write_text(''.join(json.dumps(row,ensure_ascii=False)+'\n' for row in merged.values()))
files=[aggregate,R/'outputs/launcher-all30-20261104-01/uk/review-auto-0001/coverage-report.json',P/'result.json',P/'required-context-ledger.jsonl',P/'context-accounting.json',P/'runtime-verification.json',P/'process-exit.json',D/'repair-01/version-accounting.json']
closure=dict(format='forest-editorial-closure-v1',locale='uk',languageSha256=h(lang),ordinaryRequired=12825,ordinaryExactCurrentPasses=12825,protectedSourceStates=1781,actualFinalDeltaPasses=20,duplicateOrStaleJudgments=0,unreadPrimaryOrRequiredContexts=0,openFindings=0,editorial='independent-current-version-closure-verified',evidence=[dict(path=str(p.relative_to(R)),sha256=h(p)) for p in files],nativeRuntime='not-run',rendererAcceptance='not-run',humanGlossary='owner-deferred',releaseAcceptance=False)
(out/'closure.json').write_text(json.dumps(closure,indent=2)+'\n');print(json.dumps({k:v for k,v in closure.items() if k!='evidence'}))
