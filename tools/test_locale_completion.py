"""Continuous phase boundaries; model/native work is replaced with explicit fixtures."""
import json
import os
from pathlib import Path
import signal
import subprocess
import sys
import tempfile
import time
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
            plan=dict(root=str(root),model=dict(name='gpt-6.1-sol',reasoning='high',provider='openai',inheritedHistory=False),cli='fixture-codex',executionPins={},localeOwned=True,enforceLinguisticOwnership=True)
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

    def test_retired_technical_job_rejects_before_any_submission_even_in_legacy_plan(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve()
            plan=dict(root=str(root),model=dict(name='gpt-6.1-sol',reasoning='high',provider='openai',inheritedHistory=False),
                jobs=[dict(locale=loc) for loc in ['zh','es','es-419','pt-BR','ja','de','technical']])
            put(root/'plan.json',plan)
            with patch.object(c.subprocess,'Popen') as model:
                with self.assertRaisesRegex(ValueError,'zero technical jobs'):c.run(root)
                model.assert_not_called()
            self.assertFalse((root/'run.claim').exists())

    def test_explicit_german_selection_never_starts_other_stopped_lanes(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();cli=root/'fixture-cli';cli.write_text('fixture')
            jobs=[dict(locale=loc,directory='jobs/'+loc) for loc in ['zh','es','es-419','pt-BR','ja','de']]
            plan=dict(root=str(root),model=dict(name='gpt-6.1-sol',reasoning='high',provider='openai'),
                      jobs=jobs,executionLocales=['de'],cli=str(cli),cliSha256=sha(cli))
            put(root/'plan.json',plan)
            with patch.object(c,'run_lane',return_value=dict(status='blocked')) as lane:
                c.run(root)
            self.assertEqual(lane.call_count,1)
            self.assertEqual(lane.call_args.args[2]['locale'],'de')
            self.assertEqual([x['locale'] for x in read(root/'status.json')['lanes']],['de'])

    def test_invalid_locale_selection_rejects_before_claim_or_submission(self):
        for selection in [[],['de','de'],['technical'],['fr'],'de',[None]]:
            with self.subTest(selection=selection),tempfile.TemporaryDirectory() as tmp:
                root=Path(tmp).resolve()
                plan=dict(root=str(root),model=dict(name='gpt-6.1-sol',reasoning='high',provider='openai'),
                          jobs=[dict(locale=loc) for loc in ['zh','es','es-419','pt-BR','ja','de']],
                          executionLocales=selection)
                put(root/'plan.json',plan)
                with patch.object(c,'run_lane') as lane:
                    with self.assertRaisesRegex(ValueError,'nonempty unique subset'):c.run(root)
                    lane.assert_not_called()
                self.assertFalse((root/'run.claim').exists())

    def test_no_progress_copy_does_not_continue_and_parent_stop_is_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,job=self.fixture(root);e=phase/'decisions.json';put(e,dict(id='case'))
            brief=phase/'next.md';brief.write_text('Next real task')
            result=dict(outcome='continue',summary='Test',progress=dict(kind='source-decisions',unitIds=['case']),
                        evidence=[dict(path=str(e.relative_to(root)),sha256=sha(e))],nextTask=dict(kind='work',taskClass='shared-engineering',title='Next own-locale adapter work',brief=str(brief.relative_to(root))))
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
            with self.assertRaisesRegex(ValueError,'pending unread IDs'):c.validate_result(root,job,phase,task,result,set())
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

    def test_translated_context_is_preserved_without_source_target_equality(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,job=self.fixture(root)
            packet=phase/'packet.jsonl';packet.write_text(json.dumps(dict(id='a',sourceSha256='english',targetSha256='spanish'))+'\n')
            task=dict(kind='review',reviewPacket=str(packet.relative_to(root)),reviewPacketSha256=sha(packet))
            reviews=phase/'reviews.jsonl';row=dict(id='a',sourceSha256='english',targetSha256='spanish',verdict='context-only-preserve',
                rationale='Retain the existing translated contextual unit',notLinguisticCoverage=True,targetEdited=False)
            reviews.write_text(json.dumps(row)+'\n')
            result=dict(outcome='blocked',summary='Actual boundary',reviews=str(reviews.relative_to(root)),independentWorkRemaining=False,
                blockers=[dict(predicate='P',evidence='E',nextAction='A')])
            c.validate_result(root,job,phase,task,result,set())
            self.assertEqual(result['verifiedReviewCoverage']['contextOnlyPreservations'],1)
            row['targetEdited']=True;reviews.write_text(json.dumps(row)+'\n')
            with self.assertRaisesRegex(ValueError,'retain the reviewed target'):c.validate_result(root,job,phase,task,result,set())

    def test_separate_fidelity_and_native_rationales_remain_separate(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,job=self.fixture(root)
            packet=phase/'packet.jsonl';packet.write_text(json.dumps(dict(id='a',sourceSha256='s',targetSha256='t'))+'\n')
            task=dict(kind='review',reviewPacket=str(packet.relative_to(root)),reviewPacketSha256=sha(packet))
            reviews=phase/'reviews.jsonl';row=dict(id='a',sourceSha256='s',targetSha256='t',verdict='pass',fidelityRationale='Source facts retained',nativeGermanRationale='Natural German')
            reviews.write_text(json.dumps(row)+'\n');result=dict(outcome='blocked',summary='Boundary',reviews=str(reviews.relative_to(root)),independentWorkRemaining=False,blockers=[dict(predicate='P',evidence='E',nextAction='A')])
            c.validate_result(root,job,phase,task,result,set());self.assertNotIn('rationale',json.loads(reviews.read_text()))
            del row['nativeGermanRationale'];reviews.write_text(json.dumps(row)+'\n')
            with self.assertRaisesRegex(ValueError,'explicit verdict and rationale'):c.validate_result(root,job,phase,task,result,set())

    def test_batched_unread_review_carries_deferred_ids_until_reviewed(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,job=self.fixture(root)
            pairs=[dict(id=i,sourceSha256='s',targetSha256='t') for i in ['a','b','c']]
            packet=phase/'packet.jsonl';packet.write_text(''.join(json.dumps(r)+'\n' for r in pairs))
            task=dict(kind='review',reviewPacket=str(packet.relative_to(root)),reviewPacketSha256=sha(packet))
            reviews=phase/'reviews.jsonl';reviews.write_text(''.join(json.dumps(dict(r,reviewed=r['id']=='a',verdict='pass' if r['id']=='a' else 'needs-review',rationale='Explicit read/unread'))+'\n' for r in pairs))
            next_packet=phase/'next.jsonl';next_packet.write_text(json.dumps(pairs[1])+'\n');brief=phase/'next.md';brief.write_text('Read next bounded batch')
            result=dict(outcome='continue',summary='One read',reviews=str(reviews.relative_to(root)),progress=dict(kind='reviewed',unitIds=['a']),
                evidence=[dict(path=str(reviews.relative_to(root)),sha256=sha(reviews))],nextTask=dict(kind='review',title='Read b',brief=str(brief.relative_to(root)),reviewPacket=str(next_packet.relative_to(root))))
            c.validate_result(root,job,phase,task,result,set())
            self.assertEqual(result['verifiedReviewCoverage']['deferredIds'],['c'])
            next_task=result['nextTask'];next_reviews=phase/'b-reviews.jsonl';next_reviews.write_text(json.dumps(dict(pairs[1],reviewed=True,verdict='pass',rationale='Read b'))+'\n')
            final_packet=phase/'c.jsonl';final_packet.write_text(json.dumps(pairs[2])+'\n')
            result2=dict(outcome='continue',summary='b read',reviews=str(next_reviews.relative_to(root)),progress=dict(kind='reviewed',unitIds=['b']),
                evidence=[dict(path=str(next_reviews.relative_to(root)),sha256=sha(next_reviews))],nextTask=dict(kind='review',title='Read c',brief=str(brief.relative_to(root)),reviewPacket=str(final_packet.relative_to(root))))
            c.validate_result(root,job,phase,next_task,result2,set())
            self.assertEqual(result2['verifiedReviewCoverage']['pendingIds'],['c'])
            self.assertEqual(result2['verifiedReviewCoverage']['deferredIds'],[])

    def test_adoption_and_capacity_closeout_preserve_prior_request_provenance(self):
        for kind in ['live-observer-handoff','interrupted-capacity-closeout']:
            with self.subTest(kind=kind),tempfile.TemporaryDirectory() as tmp:
                root=Path(tmp).resolve();phase,job=self.fixture(root);lane=root/'job'
                brief=phase/'next.md';brief.write_text('Complete the next bounded fixture assignment')
                next_task=dict(kind='work',title='Next',brief=str(brief.relative_to(root)),briefSha256=sha(brief))
                evidence=phase/'evidence.json';put(evidence,dict(id='one',actual='reviewed'))
                put(phase/'task.json',dict(task=dict(kind='work')))
                result=dict(outcome='continue',summary='Actual fixture judgment',progress=dict(kind='reviewed',unitIds=['one']),
                    evidence=[dict(path=str(evidence.relative_to(root)),sha256=sha(evidence))],nextTask=next_task)
                put(phase/'result.json',result)
                event=dict(type='turn.completed',usage=dict(input_tokens=10,output_tokens=2)) if kind=='live-observer-handoff' else dict(type='turn.failed',error=dict(message='Selected model is at capacity. Please try a different model.'))
                events=phase/'events.jsonl';events.write_text(json.dumps(dict(type='thread.started',thread_id='old'))+'\n'+json.dumps(event)+'\n')
                if kind=='interrupted-capacity-closeout':(phase/'result.json').unlink()
                record=dict(number=1,kind='work',phase=str(phase),pid=99999998,threadId='old',status='running')
                if kind=='interrupted-capacity-closeout':record.update(exitCode=1,status='held-request-outcome')
                put(lane/'status.json',dict(status='running' if kind=='live-observer-handoff' else 'held-request-outcome',phases=[record]))
                put(lane/'continuation.lock',dict(pid=123))
                receipt=root/'recovery.json';put(receipt,dict(kind=kind,previousStatusSha256=sha(lane/'status.json'),
                    previousClaimSha256=sha(lane/'continuation.lock'),validatedNextTask=next_task,
                    archive='recovery/old-checkpoint',interruptedArtifactPins={str(events.relative_to(root)):sha(events)}))
                job.update(resumeReceipt='recovery.json',resumeReceiptSha256=sha(receipt))
                plan=dict(root=str(root),model=dict(name='gpt-6.1-sol',reasoning='high',provider='openai',inheritedHistory=False),cli='fixture-codex',executionPins={})
                original=events.read_bytes();calls=[]
                class Child:
                    pid=99999999
                    def __init__(self,argv,**kwargs):
                        calls.append(argv);p=Path(argv[argv.index('--output-last-message')+1]).parent
                        put(p/'result.json',dict(outcome='blocked',summary='Actual native boundary',independentWorkRemaining=False,
                            blockers=[dict(predicate='Native',evidence='Static fixture done',nextAction='Owner runtime scope')]))
                        kwargs['stdout'].write(json.dumps(dict(type='thread.started',thread_id='new'))+'\n'+json.dumps(dict(type='turn.completed',usage=dict(input_tokens=10,output_tokens=2)))+'\n');kwargs['stdout'].flush()
                    def wait(self):return 0
                if kind=='interrupted-capacity-closeout':
                    record['exitCode']=0;put(lane/'status.json',dict(status='held-request-outcome',phases=[record]))
                    changed=read(receipt);changed['previousStatusSha256']=sha(lane/'status.json');put(receipt,changed);job['resumeReceiptSha256']=sha(receipt)
                    with patch.object(c,'process_identity',return_value=None),patch.object(c.subprocess,'Popen') as send:
                        with self.assertRaisesRegex(ValueError,'reconciled exited request'):c.run_lane(root,plan,job)
                        send.assert_not_called()
                    record['exitCode']=1;put(lane/'status.json',dict(status='held-request-outcome',phases=[record]))
                    changed['previousStatusSha256']=sha(lane/'status.json');put(receipt,changed);job['resumeReceiptSha256']=sha(receipt)
                with patch.object(c,'process_identity',return_value=None),patch.object(c.subprocess,'Popen',side_effect=Child),patch.object(c,'publish_current_runtime',return_value=dict(threadId='new')):
                    state=c.run_lane(root,plan,job)
                self.assertEqual(len(calls),1);self.assertEqual(state['phases'][-1]['number'],2);self.assertEqual(events.read_bytes(),original)
                prior=state['phases'][0]
                if kind=='live-observer-handoff':self.assertIsNone(prior['exitCode']);self.assertFalse(prior['exitCodeKnown'])
                else:self.assertEqual(prior['exitCode'],1);self.assertEqual(prior['status'],'held-request-outcome');self.assertFalse((phase/'result.json').exists())

    def test_real_observer_replacement_preserves_live_child(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();script=root/'observer.py';marker=root/'child-finished';info=root/'child.json'
            child_code='import time;from pathlib import Path;time.sleep(.5);Path('+repr(str(marker))+').write_text("alive after observer exit");time.sleep(5)'
            script.write_text('import subprocess,sys,json,time\nfrom pathlib import Path\np=subprocess.Popen([sys.executable,"-c",'+repr(child_code)+'])\nPath('+repr(str(info))+').write_text(json.dumps({"pid":p.pid}))\ntime.sleep(60)\n')
            observer=subprocess.Popen([sys.executable,'-B',str(script)],stdin=subprocess.DEVNULL,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL,start_new_session=True)
            child_pid=None;identity=None
            try:
                deadline=time.monotonic()+3
                while not info.exists() and time.monotonic()<deadline:time.sleep(.02)
                child_pid=read(info)['pid'];identity=c.process_identity(child_pid,root)
                self.assertIsNotNone(identity)
                os.kill(observer.pid,signal.SIGSTOP)
                self.assertIsNotNone(c.process_identity(child_pid,root,identity))
                os.kill(observer.pid,signal.SIGKILL);observer.wait(timeout=3)
                self.assertIsNotNone(c.process_identity(child_pid,root,identity))
                while not marker.exists() and time.monotonic()<deadline:time.sleep(.02)
                self.assertEqual(marker.read_text(),'alive after observer exit')
            finally:
                if observer.poll() is None:os.kill(observer.pid,signal.SIGKILL);observer.wait(timeout=3)
                if child_pid and c.process_identity(child_pid,root,identity):os.kill(child_pid,signal.SIGTERM)


if __name__=='__main__':unittest.main()
