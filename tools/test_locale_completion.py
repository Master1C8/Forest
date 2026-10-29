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

    def test_nonpass_and_exact_context_preservation_are_not_promoted(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,job=self.fixture(root)
            packet=phase/'packet.jsonl';packet.write_text(json.dumps(dict(id='a',sourceSha256='s',targetSha256='s'))+'\n')
            task=dict(kind='review',reviewPacket=str(packet.relative_to(root)),reviewPacketSha256=sha(packet))
            reviews=phase/'reviews.jsonl'
            result=dict(outcome='blocked',summary='Exact real boundary',reviews=str(reviews.relative_to(root)),independentWorkRemaining=False,
                        blockers=[dict(predicate='P',evidence='E',nextAction='A')])
            for verdict in ['needs-repair','needs-review','held-source','context-only-preserve']:
                row=dict(id='a',sourceSha256='s',targetSha256='s',verdict=verdict,rationale='Explicit non-pass judgment',
                         notLinguisticCoverage=True,targetEdited=False)
                reviews.write_text(json.dumps(row)+'\n')
                c.validate_result(root,job,phase,task,result,set())
                self.assertEqual(result['verifiedReviewCoverage']['nonPassRows'],1)
                self.assertEqual(json.loads(reviews.read_text())['verdict'],verdict)
            row['verdict']='invented-automatic-pass';reviews.write_text(json.dumps(row)+'\n')
            with self.assertRaisesRegex(ValueError,'explicit verdict'):c.validate_result(root,job,phase,task,result,set())

    def test_unread_rows_are_exactly_reassigned_and_never_credited(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,job=self.fixture(root)
            pairs=[dict(id=i,sourceSha256='s',targetSha256='t') for i in ['done','unread']]
            packet=phase/'packet.jsonl';packet.write_text(''.join(json.dumps(r)+'\n' for r in pairs))
            reviews=phase/'reviews.jsonl';reviews.write_text(json.dumps(dict(pairs[0],verdict='pass',reviewed=True,rationale='Actually read'))+'\n'+json.dumps(dict(pairs[1],verdict='needs-review',reviewed=False,rationale='Explicit unread context'))+'\n')
            next_packet=phase/'remaining.jsonl';next_packet.write_text(json.dumps(pairs[1])+'\n')
            brief=phase/'next.md';brief.write_text('Read only the exact remaining source/target/context')
            task=dict(kind='review',reviewPacket=str(packet.relative_to(root)),reviewPacketSha256=sha(packet))
            result=dict(outcome='continue',summary='One judged, one unread',reviews=str(reviews.relative_to(root)),progress=dict(kind='reviewed',unitIds=['done']),
                evidence=[dict(path=str(reviews.relative_to(root)),sha256=sha(reviews))],
                nextTask=dict(kind='review',title='Finish unread',brief=str(brief.relative_to(root)),reviewPacket=str(next_packet.relative_to(root))))
            c.validate_result(root,job,phase,task,result,set())
            self.assertEqual(result['verifiedReviewCoverage']['judged'],1)
            self.assertEqual(result['verifiedReviewCoverage']['unreadIds'],['unread'])
            next_packet.write_text(json.dumps(pairs[0])+'\n')
            with self.assertRaisesRegex(ValueError,'exactly the unread IDs'):c.validate_result(root,job,phase,task,result,set())
            rows=[dict(pairs[0],verdict='pass',reviewed=True,rationale='Read'),dict(pairs[1],verdict='pass',reviewed=False,rationale='Cannot pass unread')]
            reviews.write_text(''.join(json.dumps(r)+'\n' for r in rows));result['evidence'][0]['sha256']=sha(reviews)
            with self.assertRaisesRegex(ValueError,'Unread rows can never'):c.validate_result(root,job,phase,task,result,set())

    def test_structured_next_review_binding_is_used_without_guessing(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,job=self.fixture(root)
            packet=phase/'complete359.jsonl';packet.write_text(json.dumps(dict(id='one',sourceSha256='s',targetSha256='t'))+'\n')
            brief=phase/'next.md';brief.write_text('Read complete independent packet')
            manifest=phase/'next-review-bindings.json';put(manifest,dict(reviewPacket=dict(path=str(packet.relative_to(root)),sha256=sha(packet)),
                files=[dict(path=str(brief.relative_to(root)),sha256=sha(brief)),dict(path=str(packet.relative_to(root)),sha256=sha(packet))]))
            result=dict(outcome='continue',summary='Actual edited target',progress=dict(kind='edited',unitIds=['one']),
                evidence=[dict(path=str(manifest.relative_to(root)),sha256=sha(manifest))],nextTask=dict(kind='review',title='Read',brief=str(brief.relative_to(root))))
            c.validate_result(root,job,phase,dict(kind='work'),result,set())
            self.assertEqual(result['nextTask']['reviewPacket'],str(packet.relative_to(root)))
            del result['nextTask']['reviewPacket'];packet.write_text('changed')
            with self.assertRaisesRegex(ValueError,'binding dependency changed'):c.validate_result(root,job,phase,dict(kind='work'),result,set())

    def test_recovery_continues_after_completed_turn_without_rerunning_or_editing_it(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,job=self.fixture(root);lane=root/'job'
            packet=phase/'packet.jsonl';packet.write_text(json.dumps(dict(id='one',sourceSha256='s',targetSha256='t'))+'\n')
            reviews=phase/'reviews.jsonl';reviews.write_text(json.dumps(dict(id='one',sourceSha256='s',targetSha256='t',verdict='needs-review',rationale='Explicit supported uncertainty'))+'\n')
            brief=phase/'next.md';brief.write_text('Adjudicate the uncertainty and continue real work')
            task=dict(kind='review',reviewPacket=str(packet.relative_to(root)),reviewPacketSha256=sha(packet));put(phase/'task.json',dict(task=task))
            result=dict(outcome='continue',summary='Completed judgment with an explicit hold',reviews=str(reviews.relative_to(root)),
                progress=dict(kind='reviewed',unitIds=['one']),evidence=[dict(path=str(reviews.relative_to(root)),sha256=sha(reviews))],
                nextTask=dict(kind='work',title='Adjudicate',brief=str(brief.relative_to(root))))
            put(phase/'result.json',result)
            events=phase/'events.jsonl';events.write_text(json.dumps(dict(type='thread.started',thread_id='old'))+'\n'+json.dumps(dict(type='turn.completed',usage=dict(input_tokens=10,output_tokens=2)))+'\n')
            usage=dict(input_tokens=10,cached_input_tokens=0,output_tokens=2,reasoning_output_tokens=0,total_tokens=12)
            old_state=dict(status='held-supervisor-error',reason='Old enum rejection',phases=[dict(number=1,kind='review',phase=str(phase),exitCode=0,threadId='old',measuredUsage=usage,errors=[])])
            put(lane/'status.json',old_state);put(lane/'continuation.lock',dict(pid=123))
            original={p:p.read_bytes() for p in [phase/'result.json',reviews,events,phase/'task.json',lane/'status.json']}
            c.validate_result(root,job,phase,task,result,set())
            receipt=root/'recovery.json';put(receipt,dict(previousStatusSha256=sha(lane/'status.json'),resultSha256=sha(phase/'result.json'),
                previousClaimSha256=sha(lane/'continuation.lock'),validatedNextTask=result['nextTask'],archive='recovery/old-checkpoint'))
            job.update(resumeReceipt='recovery.json',resumeReceiptSha256=sha(receipt))
            plan=dict(root=str(root),model=dict(name='gpt-6.1-sol',reasoning='high',provider='openai',inheritedHistory=False),cli='fixture-codex',executionPins={})
            with events.open('a') as f:f.write(json.dumps(dict(type='turn.failed',error=dict(message='Unknown prior outcome')))+'\n')
            with patch.object(c.subprocess,'Popen') as send:
                with self.assertRaisesRegex(ValueError,'Actual prior terminal'):c.run_lane(root,plan,job)
                send.assert_not_called()
            events.write_bytes(original[events]);calls=[]
            class Child:
                pid=99999999
                def __init__(self,argv,**kwargs):
                    calls.append(argv);p=Path(argv[argv.index('--output-last-message')+1]).parent
                    put(p/'result.json',dict(outcome='blocked',summary='Only native check remains',independentWorkRemaining=False,
                        blockers=[dict(predicate='Native access',evidence='All static fixture work done',nextAction='Owner authorizes native check')]))
                    kwargs['stdout'].write(json.dumps(dict(type='thread.started',thread_id='new'))+'\n'+json.dumps(dict(type='turn.completed',usage=dict(input_tokens=10,output_tokens=2)))+'\n');kwargs['stdout'].flush()
                def wait(self):return 0
            with patch.object(c.subprocess,'Popen',side_effect=Child),patch.object(c,'publish_current_runtime',return_value=dict(threadId='new')):
                state=c.run_lane(root,plan,job)
            self.assertEqual(len(calls),1);self.assertEqual(state['phases'][-1]['number'],2)
            self.assertEqual(state['phases'][0]['status'],'phase-complete-after-supervisor-repair')
            for p in [phase/'result.json',reviews,events,phase/'task.json']:self.assertEqual(p.read_bytes(),original[p])
            self.assertEqual((root/'recovery/old-checkpoint/status.json').read_bytes(),original[lane/'status.json'])


if __name__=='__main__':unittest.main()
