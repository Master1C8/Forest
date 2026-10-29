"""Continuous phase boundaries; model/native work is replaced with explicit fixtures."""
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import run_locale_completion as c
from locale_queue import sha,read


def put(path,value):
    path.parent.mkdir(parents=True,exist_ok=True);path.write_text(json.dumps(value)+'\n')


class CompletionTests(unittest.TestCase):
    def fixture(self,root):
        phase=root/'job/phase';phase.mkdir(parents=True)
        job=dict(locale='de',directory='job',writePrefixes=['job','localization/de-assets'],requiredDeliverables=['family'],immutablePins={})
        return phase,job

    def test_automatic_author_to_distinct_fresh_independent_review(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,job=self.fixture(root)
            first=root/'first.md';first.write_text('Actually author a fixture target')
            job['firstTask']=dict(kind='work',title='Author',brief='first.md',briefSha256=sha(first))
            plan=dict(root=str(root),model=dict(name='gpt-6.1-sol',reasoning='high',provider='openai',inheritedHistory=False),cli='fixture-codex',executionPins={})
            calls=[]
            class Child:
                pid=99999999
                def __init__(self,argv,**kwargs):
                    calls.append(argv);p=Path(argv[argv.index('--output-last-message')+1]).parent
                    if len(calls)==1:
                        packet=p/'review-packet.jsonl';packet.write_text(json.dumps(dict(id='one',source='Source',target='Target',sourceSha256='s',targetSha256='t'))+'\n')
                        next_brief=p/'next.md';next_brief.write_text('Independently read the complete fixture packet')
                        result=dict(outcome='continue',summary='One actual fixture target authored',progress=dict(kind='authored',unitIds=['one']),
                            evidence=[dict(path=str(packet.relative_to(root)),sha256=sha(packet))],
                            nextTask=dict(kind='review',title='Independent review',brief=str(next_brief.relative_to(root)),reviewPacket=str(packet.relative_to(root))))
                    else:
                        reviews=p/'reviews.jsonl';reviews.write_text(json.dumps(dict(id='one',sourceSha256='s',targetSha256='t',verdict='clean',rationale='Explicit fixture judgment'))+'\n')
                        matrix=p/'matrix.json';put(matrix,[dict(id='family',status='accepted',evidence=str(reviews))])
                        result=dict(outcome='static-complete',summary='Fixture complete',reviews=str(reviews.relative_to(root)),
                            evidence=[dict(path=str(reviews.relative_to(root)),sha256=sha(reviews))],dispositionMatrix=str(matrix.relative_to(root)))
                    put(p/'result.json',result)
                    kwargs['stdout'].write(json.dumps(dict(type='thread.started',thread_id='fresh-'+str(len(calls))))+'\n')
                    kwargs['stdout'].write(json.dumps(dict(type='turn.completed',usage=dict(input_tokens=10,output_tokens=2)))+'\n');kwargs['stdout'].flush()
                def wait(self):return 0
            with patch.object(c.subprocess,'Popen',side_effect=Child),patch.object(c,'publish_current_runtime',return_value=dict(threadId='verified-fixture')):
                result=c.run_lane(root,plan,job)
            self.assertEqual(result['status'],'static-complete');self.assertEqual(len(calls),2)
            self.assertEqual([p['kind'] for p in result['phases']],['work','review'])
            self.assertNotEqual(calls[0],calls[1]);self.assertTrue(all('resume' not in a and 'fork' not in a for a in calls))

    def test_no_progress_copy_does_not_continue_and_parent_stop_is_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,job=self.fixture(root);e=phase/'decisions.json';put(e,dict(id='case'))
            brief=phase/'next.md';brief.write_text('Next real task')
            result=dict(outcome='continue',summary='Test',progress=dict(kind='source-decisions',unitIds=['case']),
                        evidence=[dict(path=str(e.relative_to(root)),sha256=sha(e))],nextTask=dict(kind='work',title='Next',brief=str(brief.relative_to(root))))
            c.validate_result(root,job,phase,dict(kind='work'),result,set())
            with self.assertRaisesRegex(ValueError,'No new substantive evidence'):
                c.validate_result(root,job,phase,dict(kind='work'),result,{sha(e)})
            result['outcome']='needs-parent'
            with self.assertRaisesRegex(ValueError,'never await parent'):c.validate_result(root,job,phase,dict(kind='work'),result,set())

    def test_partial_or_wrong_version_independent_review_never_completes(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,job=self.fixture(root)
            packet=phase/'packet.jsonl';packet.write_text('\n'.join(json.dumps(dict(id=i,sourceSha256='s',targetSha256='t')) for i in ['a','b'])+'\n')
            task=dict(kind='review',reviewPacket=str(packet.relative_to(root)),reviewPacketSha256=sha(packet))
            reviews=phase/'reviews.jsonl';reviews.write_text(json.dumps(dict(id='a',sourceSha256='s',targetSha256='t',verdict='pass',rationale='Explicit'))+'\n')
            result=dict(outcome='blocked',summary='Exact native boundary',reviews=str(reviews.relative_to(root)),independentWorkRemaining=False,
                        blockers=[dict(predicate='Native access',evidence='Recorded not-run',nextAction='Owner runtime scope')])
            with self.assertRaisesRegex(ValueError,'Incomplete independent review coverage'):c.validate_result(root,job,phase,task,result,set())
            with reviews.open('a') as f:f.write(json.dumps(dict(id='b',sourceSha256='s',targetSha256='t',verdict='pass',rationale='Explicit'))+'\n')
            c.validate_result(root,job,phase,task,result,set())
            text=reviews.read_text().replace('"targetSha256": "t"','"targetSha256": "wrong"');reviews.write_text(text)
            with self.assertRaisesRegex(ValueError,'versions differ'):c.validate_result(root,job,phase,task,result,set())

    def test_blocker_cannot_skip_remaining_independent_work(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,job=self.fixture(root)
            r=dict(outcome='blocked',summary='Actual boundary',independentWorkRemaining=False,blockers=[dict(predicate='P',evidence='E',nextAction='A')])
            c.validate_result(root,job,phase,dict(kind='work'),r,set())
            r['independentWorkRemaining']=True
            with self.assertRaisesRegex(ValueError,'no remaining independent'):c.validate_result(root,job,phase,dict(kind='work'),r,set())

    def test_astra_never_crosses_request_boundary(self):
        with tempfile.TemporaryDirectory() as tmp:
            phase=Path(tmp)
            for model in ['gpt-6-astra','ASTRA-alias','default']:
                plan=dict(model=dict(name=model,reasoning='high',provider='openai',inheritedHistory=False))
                with self.assertRaisesRegex(ValueError,'explicitly pinned'):c.argv(plan,phase)


if __name__=='__main__':unittest.main()
