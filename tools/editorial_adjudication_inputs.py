#!/usr/bin/env python3
"""Prepare exact initial-finding inputs; never adjudicates or generates wording."""
import argparse,json
from pathlib import Path
from editorial_lane import check_pins,sha,rows,encoded,save

NEEDS_ADJUDICATION={'finding','needs-context','source-defect'}

def prepare(job, output):
    job,output=job.resolve(),output.resolve()
    assert job in output.parents and not output.exists(), 'New immutable lane-owned output required'
    state=json.loads((job/'job.json').read_text());config=json.loads((job/'config.json').read_text())
    assert state['status']=='full-pass-complete-awaiting-adjudication', 'Complete first reading required'
    check_pins(config)
    pairs=rows(job/'pairs.jsonl');by_id={r['id']:r for r in pairs}
    assert len(by_id)==len(pairs)==config['candidateIds']==state['reviewedIds']
    reviews={};versions={str(job/'config.json'):sha(job/'config.json'),str(job/'pairs.jsonl'):sha(job/'pairs.jsonl')}
    for phase in state['phases']:
        if phase['status']!='batch-reviewed':continue
        p=Path(phase['directory']);result=json.loads((p/'result.json').read_text())
        assert result==phase['result'] and sha(p/'pairs.jsonl')==phase['packetSha256']
        assert sha(p/'reviews.jsonl')==result['reviewsSha256']
        for r in rows(p/'reviews.jsonl'):
            ident=r['id'];assert ident in by_id and ident not in reviews,'Foreign/duplicate reviewed ID'
            assert all(r[k]==by_id[ident][k] for k in ['sourceSha256','targetSha256'])
            reviews[ident]=r
        versions[str(p/'reviews.jsonl')]=result['reviewsSha256']
    assert reviews.keys()==by_id.keys(), 'Incomplete semantic reading'
    listed=rows(job/'findings.jsonl');assert len(listed)==len({r['id'] for r in listed})
    assert {r['id']:r for r in listed}=={i:r for i,r in reviews.items() if r['verdict']!='pass'}, 'Consolidated finding set differs'
    cases=[];retained=[]
    for pair in pairs:
        review=reviews[pair['id']]
        if review['verdict'] in NEEDS_ADJUDICATION:cases.append({**pair,'initialReview':review})
        elif review['verdict']=='technical-preservation':retained.append(review)
        else:assert review['verdict']=='pass','Unknown semantic verdict'
    output.mkdir()
    for name,data in [('cases.jsonl',cases),('retained-technical-receipts.jsonl',retained)]:
        (output/name).write_text(''.join(encoded(r)+'\n' for r in data))
    result={'schemaVersion':1,'locale':config['locale'],'stage':'editorial','status':'inputs-prepared-awaiting-model-adjudication',
        'sourceJob':str(job),'sourceCandidateIds':len(pairs),'actualCases':len(cases),
        'caseTypes':{v:sum(r['initialReview']['verdict']==v for r in cases) for v in sorted(NEEDS_ADJUDICATION)},
        'retainedTechnicalReceipts':len(retained),'inputVersions':versions,
        'caseSha256':sha(output/'cases.jsonl'),'retainedSha256':sha(output/'retained-technical-receipts.jsonl'),
        'modelJudgmentsGenerated':0,'translationEditsApplied':0,
        'nextAction':'Model adjudicates every case against source, approved glossary and actual context; preflight full accepted replacements before applying; then immutable dependency closure and fresh independent delta audit. Retained technical receipts are not new clean verdicts; revisit only concrete invalidated dependencies.'}
    save(output/'manifest.json',result);return result

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--job',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args();print(encoded(prepare(a.job,a.output)))
