"""Real local receipt/state transitions; resource bytes stand in for Unity output.

These exercise scheduling and provenance, not the replaced game serializer,
linguistic judgment, renderer or model transport.
"""
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import locale_dependency_wake as wake
import run_locale_completion as runner
import launch_locale_repair as launcher
import recover_locale_completion as recover
import reconcile_locale_terminal as journal
from locale_queue import sha


class DependencyWakeTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(); self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name).resolve()
        self.inbox = self.root / 'inbox'; self.inbox.mkdir()
        self.plan = dict(dependencyWake=dict(schemaVersion=1), technicalInbox=str(self.inbox))
        self.job = dict(locale='technical', writePrefixes=['technical'])
        self.phase = self.root / 'technical/002-review'; self.phase.mkdir(parents=True)
        self.profile = self.write('language/profile.json', dict(version=3))
        self.request = self.write('language/001-work/handoff.json', dict(id='transfer', locale='zh', evidence=[self.pin(self.profile)],
            predicate='The exact target profile is present in saved resources.',affectedIds=['one'],requiredResult='Complete saved target resources for this profile.'))
        self.envelope = self.write('inbox/request.json', dict(locale='zh', request=self.pin(self.request)))
        self.producer = self.write('technical/001-work/runtime-verification.json', self.runtime('author'))
        self.artifact = self.root / 'technical/001-work/resources.assets'; self.artifact.write_bytes(b'composed saved bytes')
        self.delivery = self.write('technical/001-work/delivery.json', dict(schemaVersion=1, kind='locale-resource-dependency',
            locale='zh', requestId='transfer', request=self.pin(self.request), consumptionReady=True,
            releaseAccepted=False, inputs=[self.pin(self.profile)], outputs=[self.pin(self.artifact)], producerRuntime=self.pin(self.producer)))
        self.write('technical/002-review/runtime-verification.json', self.runtime('reviewer'))
        pair = dict(id='delivery:transfer', source=self.request.read_text(), target=self.delivery.read_text(),
                    sourceSha256=sha(self.request), targetSha256=sha(self.delivery))
        self.packet = self.phase / 'packet.jsonl'; self.packet.write_text(json.dumps(pair) + '\n')
        self.judgments = self.phase / 'reviews.jsonl'
        self.judgments.write_text(json.dumps(dict(id=pair['id'], sourceSha256=pair['sourceSha256'],
            targetSha256=pair['targetSha256'], verdict='pass', reviewed=True, rationale='Exact request and complete saved artifact verified.'))+'\n')
        self.task = dict(kind='review', reviewPacket=str(self.packet.relative_to(self.root)), reviewPacketSha256=sha(self.packet))
        self.write('technical/002-review/task.json', dict(task=self.task, job=self.job))
        self.result = dict(outcome='blocked', summary='Static delivery reviewed; runtime remains outside scope.',
            reviews=str(self.judgments.relative_to(self.root)), evidence=[self.pin(self.judgments), self.pin(self.delivery)],
            independentWorkRemaining=False, blockers=[dict(predicate='Runtime', evidence='Not run', nextAction='Owning authorized runtime check')],
            dependencyDeliveries=[dict(request=self.pin(self.envelope), delivery=self.pin(self.delivery), reviewId=pair['id'])])
        self.write('technical/002-review/result.json', self.result)
        runner.validate_result(self.root, self.job, self.phase, self.task, self.result, set())
        self.brief = self.root / 'language/001-work/next.md'; self.brief.write_text('Consume the exact reviewed resource delivery; do not translate unchanged text.')
        self.blocked = self.write('language/001-work/result.json', dict(outcome='blocked',summary='Waiting for exact technical resource delivery.',
            independentWorkRemaining=False,blockers=[dict(predicate='Resource delivery',evidence='Requested',nextAction='Consume reviewed exact artifact')],
            technicalHandoffs=[self.pin(self.request)],
            nextTask=dict(kind='work', title='Consume exact delivery', brief=str(self.brief.relative_to(self.root)), briefSha256=sha(self.brief))))
        self.state = dict(status='blocked', phases=[dict(phase=str(self.blocked.parent), resultSha256=sha(self.blocked))])

    def runtime(self, thread):
        return dict(threadId=thread, actualRuntime=dict(turn=dict(model='gpt-6.1-sol', effort='high'),
                    session=dict(model_provider='openai', parent_thread_id=None)))

    def pin(self, p):
        return dict(path=str(p.relative_to(self.root)), sha256=sha(p))

    def write(self, name, value):
        p = self.root/name; p.parent.mkdir(parents=True, exist_ok=True)
        p.write_text(json.dumps(value, ensure_ascii=False, indent=2)+'\n'); return p

    def publish(self):
        return wake.publish(self.root, self.plan, self.job, self.phase, self.task, self.result)

    def waiting(self):
        return wake.waiting_task(self.root, self.plan, dict(locale='zh'), self.state)

    def test_draft_files_do_not_wake_and_exact_review_wakes_once(self):
        self.assertEqual(self.waiting(), [])
        self.assertEqual(len(self.publish()), 1)
        task = self.waiting(); self.assertEqual(task['title'], 'Consume exact delivery')
        self.assertTrue(task['dependencyReceipt']['sha256'])
        runner.consume_dependency(self.state, task)
        self.assertEqual(self.waiting(), [])

    def test_request_id_alias_is_the_same_shared_protocol_not_a_locale_special_case(self):
        self.assertEqual(wake.request_id(dict(requestId='transfer')),'transfer')
        self.assertEqual(wake.request_id(dict(id='transfer')),'transfer')
        with self.assertRaisesRegex(ValueError,'dependency-request-identity'):wake.request_id({})

    def test_changed_profile_is_rejected_at_resume_not_hidden_by_old_ready_receipt(self):
        self.publish(); self.write('language/profile.json', dict(version=4))
        with self.assertRaisesRegex(ValueError, 'dependency-pin-changed:language/profile.json'):
            self.waiting()

    def test_saved_resource_bytes_are_rechecked_before_resume(self):
        self.publish(); self.artifact.write_bytes(b'corrupted artifact')
        with self.assertRaisesRegex(ValueError, 'dependency-pin-changed:technical/001-work/resources.assets'):
            self.waiting()

    def test_other_request_version_cannot_consume_previous_delivery(self):
        self.publish(); data=json.loads(self.request.read_text());data['version']=4
        self.write(str(self.request.relative_to(self.root)), data)
        blocked=json.loads(self.blocked.read_text());blocked['technicalHandoffs']=[self.pin(self.request)]
        self.write(str(self.blocked.relative_to(self.root)), blocked)
        self.state['phases'][-1]['resultSha256']=sha(self.blocked)
        self.assertEqual(self.waiting(), [])

    def test_author_cannot_publish_its_own_review(self):
        self.write('technical/002-review/runtime-verification.json', self.runtime('author'))
        with self.assertRaisesRegex(ValueError, 'dependency-review-not-independent'): self.publish()

    def test_work_phase_and_incomplete_review_cannot_publish(self):
        with self.assertRaisesRegex(ValueError, 'dependency-needs-technical-review'):
            wake.publish(self.root,self.plan,self.job,self.phase,dict(self.task,kind='technical'),self.result)
        self.result['verifiedReviewCoverage']['pendingIds']=['delivery:transfer']
        with self.assertRaisesRegex(ValueError, 'dependency-review-not-complete-clean'): self.publish()

    def test_all_valid_pins_but_wrong_assigned_manifest_are_rejected(self):
        pair=json.loads(self.packet.read_text());pair['target']='Another manifest'
        self.packet.write_text(json.dumps(pair)+'\n');self.task['reviewPacketSha256']=sha(self.packet)
        with self.assertRaisesRegex(ValueError, 'dependency-reviewed-other-delivery'): self.publish()

    def test_wait_is_quiet_and_makes_no_model_submission(self):
        ready=dict(kind='work',title='Exact task')
        with patch.object(runner.dependency_wake,'waiting_task',side_effect=[[],[],ready]), patch.object(runner.time,'sleep') as sleep, patch.object(runner.subprocess,'Popen') as model:
            self.assertEqual(runner.wait_dependency(self.root,self.plan,dict(locale='zh'),self.state),ready)
            self.assertEqual(sleep.call_count,2); model.assert_not_called()

    def test_missing_next_task_does_not_invent_a_linguistic_job(self):
        data=json.loads(self.blocked.read_text());data['nextTask']={};self.write(str(self.blocked.relative_to(self.root)),data)
        self.state['phases'][-1]['resultSha256']=sha(self.blocked)
        self.assertIsNone(self.waiting())

    def run_real_ready_lane(self,adopting=False):
        self.publish();lane=self.root/'language'
        self.state['phases'][-1].update(number=1,pid=123,threadId='previous')
        if adopting:
            self.state['status']='running'
            self.write('language/001-work/task.json',dict(task=dict(kind='work',title='Original finite task')))
            events=self.blocked.parent/'events.jsonl'
            events.write_text(json.dumps(dict(type='thread.started',thread_id='previous'))+'\n'+json.dumps(dict(type='turn.completed',usage=dict(input_tokens=10,output_tokens=2)))+'\n')
        status=self.write('language/status.json',self.state)
        claim=self.write('language/continuation.lock',dict(pid=456))
        old_status=status.read_bytes();old_result=self.blocked.read_bytes()
        recovery=self.write('recovery.json',dict(kind='live-observer-handoff' if adopting else 'retained-terminal-lane',previousStatusSha256=sha(status),
            resultSha256=sha(self.blocked),previousClaimSha256=sha(claim),archive='old-checkpoints',childIdentity={}))
        job=dict(locale='zh',directory='language',writePrefixes=['language'],immutablePins={},requiredDeliverables=[],
                 resumeReceipt='recovery.json',resumeReceiptSha256=sha(recovery))
        plan=dict(self.plan,root=str(self.root),executionPins={},cli='fixture',model=dict(name='gpt-6.1-sol',reasoning='high',provider='openai',inheritedHistory=False))
        calls=[]
        class Child:
            pid=99999999
            def __init__(child,argv,**kwargs):
                calls.append(argv);phase=Path(argv[argv.index('--output-last-message')+1]).parent
                (phase/'result.json').write_text(json.dumps(dict(outcome='blocked',summary='Consumed exact delivery; native check remains.',
                    independentWorkRemaining=False,blockers=[dict(predicate='Native check',evidence='Not run',nextAction='Authorized native check')])) )
                kwargs['stdout'].write(json.dumps(dict(type='thread.started',thread_id='consumer'))+'\n'+json.dumps(dict(type='turn.completed',usage=dict(input_tokens=10,output_tokens=2)))+'\n');kwargs['stdout'].flush()
            def wait(child):return 0
        with patch.object(runner,'process_identity',return_value=None),patch.object(runner.subprocess,'Popen',side_effect=Child),patch.object(runner,'publish_current_runtime',return_value=dict(threadId='consumer')):
            state=runner.run_lane(self.root,plan,job)
        self.assertEqual(len(calls),1);self.assertEqual(len(state['phases']),2)
        self.assertEqual(len(state['consumedDependencyReceipts']),1)
        self.assertEqual((self.root/'old-checkpoints/status.json').read_bytes(),old_status)
        self.assertEqual(self.blocked.read_bytes(),old_result)
        task=json.loads((lane/'0002-work/task.json').read_text())['task']
        self.assertIn('dependencyReceipt',task)

    def test_retained_lane_consumes_real_review_receipt_and_submits_only_once(self):
        self.run_real_ready_lane()

    def test_adopted_worker_is_not_replayed_and_its_blocked_result_resumes_after_ready(self):
        self.run_real_ready_lane(adopting=True)

    def test_process_handoff_preserves_assignments_and_drops_consumed_launch_overrides(self):
        new=self.root/'new';new.mkdir();(new/'CONTRACT.md').write_text('Existing contract\n')
        priority=dict(kind='technical',title='Existing actual resource work')
        plan=dict(jobs=[dict(locale=l,ownerResume={'obsolete':True},sourceWake={'obsolete':True},firstTask={'original':l}) for l in ['zh','es','es-419','pt-BR','ja','de','technical']],executionPins={},ownerPriorityTask=priority)
        config=self.write('repair.json',dict(schemaVersion=1,kind='owner-requested-process-repair',contract='Exact reviewed dependency receipt only.',receipt='receipt.json'))
        with patch.object(launcher,'ROOT',self.root):launcher.configure_process_repair(plan,new,config)
        self.assertEqual(plan['ownerPriorityTask'],priority)
        for job in plan['jobs']:
            self.assertNotIn('ownerResume',job);self.assertNotIn('sourceWake',job)
            self.assertEqual(job['firstTask'],{'original':job['locale']})

    def test_forged_ready_receipt_without_owning_review_declaration_is_rejected(self):
        self.publish();ready=self.inbox/'ready'/(sha(self.request)+'.json')
        result=json.loads((self.phase/'result.json').read_text());result.pop('dependencyDeliveries')
        self.write('technical/002-review/result.json',result)
        receipt=json.loads(ready.read_text());receipt['reviewResult']=self.pin(self.phase/'result.json')
        ready.write_text(json.dumps(receipt)+'\n')
        with self.assertRaisesRegex(ValueError,'dependency-receipt-not-owned-by-review-result'):self.waiting()

    def test_interruption_between_receipts_keeps_first_and_resumes_same_verified_partial(self):
        request=self.write('language/001-work/pt-request.json',dict(id='pt-transfer',locale='zh',evidence=[self.pin(self.profile)]))
        envelope=self.write('inbox/pt-request.json',dict(locale='zh',request=self.pin(request)))
        data=json.loads(self.delivery.read_text());data.update(locale='zh',requestId='pt-transfer',request=self.pin(request))
        delivery=self.write('technical/001-work/pt-delivery.json',data)
        pair=dict(id='delivery:pt-transfer',source=request.read_text(),target=delivery.read_text(),sourceSha256=sha(request),targetSha256=sha(delivery))
        with self.packet.open('a') as f:f.write(json.dumps(pair)+'\n')
        with self.judgments.open('a') as f:f.write(json.dumps(dict(id=pair['id'],sourceSha256=pair['sourceSha256'],targetSha256=pair['targetSha256'],verdict='pass',reviewed=True,rationale='Exact second saved delivery.'))+'\n')
        self.task['reviewPacketSha256']=sha(self.packet)
        self.result['evidence']=[self.pin(self.judgments),self.pin(self.delivery),self.pin(delivery)]
        self.result['dependencyDeliveries'].append(dict(request=self.pin(envelope),delivery=self.pin(delivery),reviewId=pair['id']))
        self.write('technical/002-review/task.json',dict(task=self.task,job=self.job))
        self.write('technical/002-review/result.json',self.result)
        runner.validate_result(self.root,self.job,self.phase,self.task,self.result,set())
        blocked=json.loads(self.blocked.read_text());blocked['technicalHandoffs'].append(self.pin(request))
        self.write(str(self.blocked.relative_to(self.root)),blocked);self.state['phases'][-1]['resultSha256']=sha(self.blocked)
        original=Path.replace
        def interrupt(path,target):
            if path.name==sha(request)+'.pending':raise InterruptedError('between-independent-receipts')
            return original(path,target)
        with patch.object(Path,'replace',interrupt):
            with self.assertRaisesRegex(InterruptedError,'between-independent-receipts'):self.publish()
        ready=self.inbox/'ready';first=ready/(sha(self.request)+'.json');before=first.read_bytes()
        self.assertFalse((ready/(sha(request)+'.json')).exists())
        self.assertTrue((ready/(sha(request)+'.pending')).exists())
        self.assertEqual(self.waiting(),[])
        self.assertFalse((ready/(sha(request)+'.json')).exists(), 'The consumer must not publish the missing producer receipt')
        self.assertEqual(len(self.publish()),2)
        self.assertEqual(first.read_bytes(),before)
        self.assertTrue((ready/(sha(request)+'.json')).is_file())
        self.assertEqual(len(self.waiting()['dependencyReceipts']),2)

    def test_verified_legacy_adoption_metadata_is_reconciled_without_any_model_call(self):
        data=json.loads(self.blocked.read_text());data.pop('nextTask');self.write(str(self.blocked.relative_to(self.root)),data)
        record=self.state['phases'][-1];usage=dict(input_tokens=10,output_tokens=2)
        record.update(number=1,pid=123,threadId='previous',status='running-adopted',resultSha256=None,exitCodeKnown=False,measuredUsage=usage)
        metadata=recover.reconcile_adopted_terminal(self.state,record,data,self.blocked.parent,'previous',usage)
        lane=self.root/'language';status=self.write('language/status.json',self.state);original=status.read_bytes()
        claim=self.write('language/continuation.lock',dict(pid=456))
        receipt=self.write('recovery.json',dict(kind='retained-terminal-lane',previousStatusSha256=sha(status),resultSha256=sha(self.blocked),
            previousClaimSha256=sha(claim),archive='old-checkpoints',terminalReconciliation=metadata))
        job=dict(locale='zh',directory='language',resumeReceipt='recovery.json',resumeReceiptSha256=sha(receipt))
        with patch.object(runner,'process_identity',return_value=None),patch.object(runner.subprocess,'Popen') as model:
            result=runner.run_lane(self.root,dict(self.plan,root=str(self.root)),job)
            model.assert_not_called()
        self.assertEqual(result['phases'][-1]['resultSha256'],sha(self.blocked))
        self.assertEqual(json.loads(status.read_text()),result)
        self.assertEqual((self.root/'old-checkpoints/status.json').read_bytes(),original)
        self.assertNotEqual(json.loads(claim.read_text())['pid'],456)
        bad=dict(record,resultSha256='unexpected-existing-hash')
        with self.assertRaisesRegex(ValueError,'Terminal lane differs'):
            recover.reconcile_adopted_terminal(self.state,bad,data,self.blocked.parent,'previous',usage)

    def test_journal_repair_resumes_exact_partial_and_preflights_all_unknown_versions(self):
        a=self.write('status.json',{'old':'status'});b=self.write('claim.json',{'old':'claim'})
        old_b=b.read_bytes();changes=[]
        for path,value in [(a,{'new':'status'}),(b,{'new':'claim'})]:
            changes.append(dict(path=str(path.relative_to(self.root)),beforeSha256=sha(path),afterSha256=journal.digest(value),after=value))
        plan=self.write('repair/plan.json',dict(changes=changes))
        with self.assertRaisesRegex(InterruptedError,'between-writes'):journal.apply(self.root,plan,fail_after=1)
        self.assertEqual(sha(a),changes[0]['afterSha256']);self.assertEqual(b.read_bytes(),old_b)
        journal.apply(self.root,plan);self.assertEqual(sha(b),changes[1]['afterSha256'])
        self.assertTrue((plan.parent/'applied.json').exists())
        b.write_text('unknown')
        with self.assertRaisesRegex(ValueError,'unknown-journal-version'):journal.apply(self.root,plan)


if __name__ == '__main__':
    unittest.main()
