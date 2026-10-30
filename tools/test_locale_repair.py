"""Queue repair boundaries; no paid requests or native game dependencies."""
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import run_locale_completion as runner
import recover_locale_completion as recover
import launch_locale_repair as launcher
from locale_queue import sha


class RepairTests(unittest.TestCase):
    def setUp(self):
        self.tmp=tempfile.TemporaryDirectory();self.addCleanup(self.tmp.cleanup)
        self.root=Path(self.tmp.name).resolve()

    def write(self,name,value):
        path=self.root/name;path.parent.mkdir(parents=True,exist_ok=True)
        path.write_text(json.dumps(value));return path

    def test_locale_owned_configuration_removes_exact_stopped_technical_job(self):
        old=dict(locale='technical',directory='technical',immutablePins={})
        self.write('technical/status.json',dict(phases=[dict(pid=123,threadId='stopped')]))
        retirement=self.write('retirement.json',dict(status='owner-stopped',lane=dict(directory='technical',pid=123,threadId='stopped'),
            processes=[dict(pid=123,identity=dict(start='exact-start',command='exact-worker'))]))
        config=self.write('config.json',dict(schemaVersion=1,kind='owner-requested-process-repair',localeOwned=True,
            technicalRetirement=dict(path='retirement.json',sha256=sha(retirement)),contract='No permanent technical worker.',receipt='receipt.json'))
        new=self.root/'new';new.mkdir();(new/'CONTRACT.md').write_text('Preserved contract\n')
        plan=dict(jobs=[old,dict(locale='de')],executionPins={},ownerPriorityTask=dict(kind='technical'))
        with patch.object(launcher,'ROOT',self.root),patch.object(runner,'process_identity',return_value={'still':'alive'}):
            with self.assertRaisesRegex(ValueError,'still alive'):launcher.configure_process_repair(plan,new,config)
        with patch.object(launcher,'ROOT',self.root),patch.object(runner,'process_identity',return_value=None):
            launcher.configure_process_repair(plan,new,config)
        self.assertTrue(plan['localeOwned']);self.assertEqual([j['locale'] for j in plan['jobs']],['de'])
        self.assertNotIn('ownerPriorityTask',plan);self.assertNotIn('dependencyWake',plan)
        self.assertEqual(plan['retiredJobs'][0]['job'],old)
        self.assertFalse(plan['enforceLinguisticOwnership'])
        # A later observer handoff retains the removal instead of inventing a
        # replacement technical job or replaying its stopped request.
        later=self.root/'later';later.mkdir();(later/'CONTRACT.md').write_text('Fresh frozen contract\n')
        with patch.object(launcher,'ROOT',self.root),patch.object(runner,'process_identity',return_value=None):
            launcher.configure_process_repair(plan,later,config)
        self.assertEqual([j['locale'] for j in plan['jobs']],['de'])
        self.assertEqual(len(plan['retiredJobs']),1)

    def test_priority_preserves_required_review_and_uses_next_work_boundary(self):
        brief=self.root/'priority.md';brief.write_text('Concrete source admission work')
        task=dict(kind='technical',brief='priority.md',briefSha256=sha(brief),title='Close named blockers')
        plan=dict(ownerPriorityTask=task);state={};job=dict(locale='technical')
        review=dict(kind='review',title='Required independent review')
        self.assertEqual(runner.priority_task(self.root,plan,job,state,review),review)
        work=dict(kind='technical',title='Deferred resource work')
        self.assertEqual(runner.priority_task(self.root,plan,job,state,work),task)
        self.assertEqual(state['deferredTechnicalTask'],work)
        self.assertEqual(runner.priority_task(self.root,plan,job,state,work),work)
        self.assertEqual(runner.priority_task(self.root,plan,dict(locale='de'),{},work),work)

    def test_changed_source_file_alone_never_wakes_a_blocked_model(self):
        path=self.write('source.json',dict(commonSourceAccepted=False,translationEntryAllowed=False,completeVisibleTranslationDenominator=None))
        config=dict(sourceManifest='source.json',baselineSha256=sha(path))
        self.assertFalse(runner.source_wake_ready(self.root,config))
        self.write('source.json',dict(commonSourceAccepted=False,translationEntryAllowed=True,completeVisibleTranslationDenominator=100))
        self.assertFalse(runner.source_wake_ready(self.root,config))
        self.write('source.json',dict(commonSourceAccepted=True,translationEntryAllowed=True,completeVisibleTranslationDenominator=100))
        self.assertTrue(runner.source_wake_ready(self.root,config))

    def owner_config(self):
        def pin(p):return dict(path=str(p.relative_to(self.root)),sha256=sha(p))
        artifact=self.write('accepted-russian.json',dict(delivered=True))
        source=self.write('original-source.json',dict(version='0.45'))
        target=self.write('target-input.json',dict(source='Original',target='Saved'))
        baseline=self.write('baseline.json',dict(authority='owner',accepted=True,locale='ru',
            sharedMechanismReuseAllowed=True,targetLocaleAcceptanceGranted=False,
            artifact=pin(artifact),sourceManifest=pin(source)))
        authority=self.write('owner-repair.json',dict(kind='direct-owner-repair-and-resume',
            locales=['zh','es','pt-BR'],baselineAcceptance=pin(baseline)))
        stopped=self.write('stopped.json',dict(outcome='blocked'))
        scope=self.write('scope.json',dict(locale='zh',affectedIds=['one'],inputs=[pin(target)],owningStoppedResult=pin(stopped)))
        brief=self.root/'actual-work.md';brief.write_text('Produce the bounded target overlay from actual saved wording.')
        config=dict(authorization=pin(authority),baselineAcceptance=pin(baseline),scope=pin(scope),
            task=dict(kind='work',title='Produce actual target overlay',brief='actual-work.md',briefSha256=sha(brief)))
        return config

    def test_owner_can_resume_real_target_work_without_changing_old_source_flags(self):
        config=self.owner_config()
        source=self.write('old-gate.json',dict(commonSourceAccepted=False,translationEntryAllowed=False,completeVisibleTranslationDenominator=None))
        original=source.read_bytes()
        self.assertEqual(runner.owner_resume_task(self.root,dict(locale='zh',ownerResume=config)),config['task'])
        self.assertEqual(source.read_bytes(),original)

    def test_owner_accepted_baseline_rejects_a_new_legacy_source_wake_launch_before_pause(self):
        self.write('localization/completion/russian-owner-baseline-20261030-01/acceptance.json',dict(accepted=True))
        with patch.object(launcher,'ROOT',self.root),patch.object(launcher.recover,'prepare') as prepare:
            with self.assertRaisesRegex(ValueError,'legacy source-wake launch is obsolete'):
                launcher.launch(self.root/'previous',self.root/'new')
            prepare.assert_not_called()
            prepare.side_effect=RuntimeError('explicit-config-passed-legacy-guard')
            with self.assertRaisesRegex(RuntimeError,'explicit-config-passed-legacy-guard'):
                launcher.launch(self.root/'previous',self.root/'new',self.root/'config.json')
            prepare.assert_called_once()

    def test_owner_resume_rejects_another_locale_after_valid_authority(self):
        config=self.owner_config()
        with self.assertRaisesRegex(ValueError,'Finite owner continuation scope'):
            runner.owner_resume_task(self.root,dict(locale='pt-BR',ownerResume=config))

    def test_owner_resume_rejects_an_empty_scope_with_consistent_pin(self):
        config=self.owner_config();scope=self.write('scope.json',dict(locale='zh',affectedIds=[]))
        config['scope']['sha256']=sha(scope)
        with self.assertRaisesRegex(ValueError,'Finite owner continuation scope'):
            runner.owner_resume_task(self.root,dict(locale='zh',ownerResume=config))

    def test_owner_resume_rejects_drift_in_a_real_target_dependency(self):
        config=self.owner_config();job=dict(locale='zh',ownerResume=config)
        runner.owner_resume_task(self.root,job)
        self.write('target-input.json',dict(source='Original',target='Changed'))
        with self.assertRaisesRegex(ValueError,'Target continuation input changed'):
            runner.owner_resume_task(self.root,job)

    def test_prior_finite_assignment_cannot_be_replayed_after_a_new_stopped_result(self):
        config=self.owner_config();job=dict(locale='zh',ownerResume=config)
        scope=json.loads((self.root/'scope.json').read_text())
        runner.owner_resume_task(self.root,job,scope['owningStoppedResult'])
        with self.assertRaisesRegex(ValueError,'different stopped result'):
            runner.owner_resume_task(self.root,job,dict(path='new-result.json',sha256='different'))

    def test_stopped_result_binding_accepts_equivalent_absolute_and_relative_paths(self):
        config=self.owner_config();scope=json.loads((self.root/'scope.json').read_text())
        original=scope['owningStoppedResult']
        runner.owner_resume_task(self.root,dict(locale='zh',ownerResume=config),dict(original,path=str(self.root/original['path'])))

    def review_config(self):
        config=self.owner_config();packet=self.root/'review.jsonl'
        packet.write_text(json.dumps(dict(id='one',source='Source',target='Target',sourceSha256=runner.hashlib.sha256(b'Source').hexdigest(),targetSha256=runner.hashlib.sha256(b'Target').hexdigest()))+'\n')
        config['task'].update(kind='review',reviewPacket='review.jsonl',reviewPacketSha256=sha(packet))
        return config

    def test_owner_can_resume_an_exact_independent_review_packet(self):
        config=self.review_config();task=runner.owner_resume_task(self.root,dict(locale='zh',ownerResume=config))
        self.assertEqual(task['kind'],'review')

    def test_independent_resume_rejects_another_reviewed_id_after_valid_hashes(self):
        config=self.review_config();p=self.root/'review.jsonl';row=json.loads(p.read_text());row['id']='another';p.write_text(json.dumps(row)+'\n');config['task']['reviewPacketSha256']=sha(p)
        with self.assertRaisesRegex(ValueError,'Owner review scope differs'):
            runner.owner_resume_task(self.root,dict(locale='zh',ownerResume=config))

    def test_owner_resume_continues_same_terminal_lane_once_and_preserves_old_checkpoint(self):
        config=self.owner_config();lane=self.root/'lane';phase=lane/'0001-review'
        result=self.write('lane/0001-review/result.json',dict(outcome='blocked',summary='Old whole-source flag'))
        scope=json.loads((self.root/'scope.json').read_text())
        scope['owningStoppedResult']=dict(path='lane/0001-review/result.json',sha256=sha(result))
        scope_path=self.write('scope.json',scope);config['scope']['sha256']=sha(scope_path)
        status=self.write('lane/status.json',dict(status='blocked',phases=[dict(number=1,pid=123,phase=str(phase),resultSha256=sha(result))]))
        claim=self.write('lane/continuation.lock',dict(pid=456))
        receipt=self.write('recovery.json',dict(kind='retained-terminal-lane',previousStatusSha256=sha(status),resultSha256=sha(result),previousClaimSha256=sha(claim),archive='archive'))
        job=dict(locale='zh',directory='lane',writePrefixes=['lane'],requiredDeliverables=[],immutablePins={},
            resumeReceipt='recovery.json',resumeReceiptSha256=sha(receipt),ownerResume=config)
        plan=dict(root=str(self.root),model=dict(name='gpt-6.1-sol',reasoning='high',provider='openai',inheritedHistory=False),cli='fixture',executionPins={})
        original=status.read_bytes();calls=[]
        class Child:
            pid=99999999
            def __init__(child,argv,**kwargs):
                calls.append(argv);p=Path(argv[argv.index('--output-last-message')+1]).parent
                (p/'result.json').write_text(json.dumps(dict(outcome='blocked',summary='Actual target-native boundary',independentWorkRemaining=False,
                    blockers=[dict(predicate='Native target output',evidence='Not run',nextAction='Authorized target test')])) )
                kwargs['stdout'].write(json.dumps(dict(type='thread.started',thread_id='owner-target'))+'\n'+json.dumps(dict(type='turn.completed',usage=dict(input_tokens=10,output_tokens=2)))+'\n');kwargs['stdout'].flush()
            def wait(child):return 0
        with patch.object(runner,'process_identity',return_value=None),patch.object(runner.subprocess,'Popen',side_effect=Child),patch.object(runner,'publish_current_runtime',return_value=dict(threadId='owner-target')):
            state=runner.run_lane(self.root,plan,job)
        self.assertEqual(len(calls),1);self.assertEqual(len(state['phases']),2)
        self.assertEqual((self.root/'archive/status.json').read_bytes(),original)
        self.assertEqual(state['ownerResumeAuthorizationSha256'],config['authorization']['sha256'])

    def test_retained_blocked_lane_launches_nothing_and_preserves_inputs(self):
        lane=self.root/'lane';phase=lane/'0001-review'
        result=self.write('lane/0001-review/result.json',dict(outcome='blocked',summary='Actual source hold'))
        status=self.write('lane/status.json',dict(status='blocked',phases=[dict(pid=123,phase=str(phase),resultSha256=sha(result))]))
        claim=self.write('lane/continuation.lock',dict(pid=456))
        receipt=self.write('recovery.json',dict(kind='retained-terminal-lane',previousStatusSha256=sha(status),resultSha256=sha(result),previousClaimSha256=sha(claim)))
        job=dict(locale='zh',directory='lane',resumeReceipt='recovery.json',resumeReceiptSha256=sha(receipt))
        before={p:p.read_bytes() for p in [status,claim,result]}
        with patch.object(runner,'process_identity',return_value=None),patch.object(runner.subprocess,'Popen') as request:
            value=runner.run_lane(self.root,dict(root=str(self.root)),job)
            self.assertEqual(value['status'],'blocked');request.assert_not_called()
        self.assertEqual(before,{p:p.read_bytes() for p in before})

    def test_shared_inbox_keeps_exact_request_identity_across_handoff(self):
        inbox=self.root/'old-observer/technical-inbox';inbox.mkdir(parents=True)
        request=self.write('lane/request.json',dict(predicate='P',affectedIds=['one'],evidence=['E'],requiredResult='Actual finite resource'))
        new=self.root/'new-observer';new.mkdir()
        result=dict(technicalHandoffs=[dict(path='lane/request.json',sha256=sha(request))])
        published=runner.publish_technical_handoffs(self.root,new,dict(locale='zh',writePrefixes=['lane']),result,inbox)
        self.assertEqual(len(published),1)
        self.assertTrue((self.root/published[0]).is_relative_to(inbox))
        self.assertFalse((new/'technical-inbox').exists())

    def test_retained_terminal_claim_keeps_lineage_at_later_handoffs(self):
        state=dict(status='blocked',supervisorPid=111)
        self.write('lane/status.json',state)
        claim=self.write('lane/continuation.lock',dict(pid=111))
        receipt=self.write('retained.json',dict(kind='retained-terminal-lane',
            previousStatusSha256=sha(self.root/'lane/status.json'),previousClaimSha256=sha(claim),threadId='old'))
        job=dict(directory='lane',resumeReceipt='retained.json',resumeReceiptSha256=sha(receipt))
        self.assertTrue(recover.owns_claim(self.root,job,state,dict(threadId='old'),claim,dict(pid=222)))
        self.assertFalse(recover.owns_claim(self.root,job,state,dict(threadId='other'),claim,dict(pid=222)))

    def test_source_wake_continues_existing_checkpoint_once(self):
        lane=self.root/'lane';phase=lane/'0001-review'
        result=self.write('lane/0001-review/result.json',dict(outcome='blocked',summary='Source hold'))
        status=self.write('lane/status.json',dict(status='blocked',phases=[dict(number=1,pid=123,phase=str(phase),resultSha256=sha(result))]))
        claim=self.write('lane/continuation.lock',dict(pid=456))
        receipt=self.write('recovery.json',dict(kind='retained-terminal-lane',previousStatusSha256=sha(status),resultSha256=sha(result),previousClaimSha256=sha(claim),archive='archive'))
        source=self.write('source.json',dict(commonSourceAccepted=False,translationEntryAllowed=False,completeVisibleTranslationDenominator=None))
        baseline=sha(source)
        self.write('source.json',dict(commonSourceAccepted=True,translationEntryAllowed=True,completeVisibleTranslationDenominator=10))
        brief=self.root/'new.md';brief.write_text('Newly source-admitted finite wording')
        job=dict(locale='zh',directory='lane',writePrefixes=['lane'],requiredDeliverables=['one'],immutablePins={},
                 resumeReceipt='recovery.json',resumeReceiptSha256=sha(receipt),sourceWake=dict(sourceManifest='source.json',baselineSha256=baseline,
                 task=dict(kind='work',title='Newly admitted',brief='new.md',briefSha256=sha(brief))))
        plan=dict(root=str(self.root),model=dict(name='gpt-6.1-sol',reasoning='high',provider='openai',inheritedHistory=False),cli='fixture',executionPins={})
        original=status.read_bytes();calls=[]
        class Child:
            pid=99999999
            def __init__(child,argv,**kwargs):
                calls.append(argv);p=Path(argv[argv.index('--output-last-message')+1]).parent
                (p/'result.json').write_text(json.dumps(dict(outcome='blocked',summary='Only real native check remains',independentWorkRemaining=False,
                    blockers=[dict(predicate='Native',evidence='Not run',nextAction='Authorized native check')])) )
                kwargs['stdout'].write(json.dumps(dict(type='thread.started',thread_id='fresh'))+'\n'+json.dumps(dict(type='turn.completed',usage=dict(input_tokens=10,output_tokens=2)))+'\n');kwargs['stdout'].flush()
            def wait(child):return 0
        with patch.object(runner,'process_identity',return_value=None),patch.object(runner.subprocess,'Popen',side_effect=Child),patch.object(runner,'publish_current_runtime',return_value=dict(threadId='fresh')):
            state=runner.run_lane(self.root,plan,job)
        self.assertEqual(len(calls),1)
        self.assertEqual(len(state['phases']),2)
        self.assertEqual(state['phases'][-1]['number'],2)
        self.assertEqual((self.root/'archive/status.json').read_bytes(),original)


if __name__=='__main__':unittest.main()
