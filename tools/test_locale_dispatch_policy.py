"""Dispatch ownership guards use real files; they never call a model."""
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import locale_dispatch_policy as dispatch
import run_locale_completion as runner
from locale_queue import sha


class DispatchPolicyTests(unittest.TestCase):
    def setUp(self):
        self.tmp=tempfile.TemporaryDirectory();self.addCleanup(self.tmp.cleanup)
        self.root=Path(self.tmp.name).resolve()

    def packet(self,rows):
        path=self.root/'packet.jsonl';path.write_text(''.join(json.dumps(r)+'\n' for r in rows))
        return dict(kind='review',title='Review',reviewPacket='packet.jsonl',reviewPacketSha256=sha(path))

    def test_real_wording_and_dependency_consumption_remain_admitted(self):
        job=dict(locale='es-419')
        self.assertIsNone(dispatch.reason(self.root,job,dict(kind='work',taskClass='linguistic-work')))
        self.assertIsNone(dispatch.reason(self.root,job,self.packet([dict(id='ds:1:2:Dialogue Text',source='Original',target='Saved translation')])))
        self.assertIsNotNone(dispatch.reason(self.root,job,dict(kind='work',dependencyReceipt={'path':'unverified-receipt'})))

    def test_data_binding_review_cannot_hide_behind_a_linguistic_class(self):
        task=self.packet([dict(id='inventory52-resource-binding:item',reviewKind='new-data-binding-only')]);task['taskClass']='linguistic-review'
        self.assertIn('technical batch',dispatch.reason(self.root,dict(locale='es'),task))
        self.assertIsNone(dispatch.reason(self.root,dict(locale='technical'),task))

    def test_unclassified_author_task_does_not_fail_open(self):
        self.assertIn('explicit linguistic-work',dispatch.reason(self.root,dict(locale='es'),dict(kind='work')))

    def test_changed_packet_is_rejected_before_classification(self):
        task=self.packet([dict(id='one')]);(self.root/'packet.jsonl').write_text('changed')
        with self.assertRaisesRegex(ValueError,'packet changed'):dispatch.reason(self.root,dict(locale='es'),task)

    def test_locale_owned_transport_needs_no_extra_model_but_real_review_remains(self):
        task=self.packet([dict(id='resource-binding:quest',reviewKind='resource-binding')])
        task['taskClass']='independent-resource-review'
        self.assertIn('concrete new',dispatch.locale_owned_reason(self.root,task))
        task['newJudgment']=dict(boundary='consumer',predicate='Check changed fragment order in the actual consumer.',
            inputs=[dict(path='packet.jsonl',sha256=sha(self.root/'packet.jsonl'))])
        self.assertIsNone(dispatch.locale_owned_reason(self.root,task))
        task['newJudgment']['inputs'][0]['sha256']='0'*64
        with self.assertRaisesRegex(ValueError,'judgment input changed'):
            dispatch.locale_owned_reason(self.root,task)

    def test_locale_owned_semantic_and_repair_tasks_remain_admitted(self):
        self.assertIsNone(dispatch.locale_owned_reason(self.root,self.packet([dict(id='ds:1:2:Dialogue Text',source='Original',target='Translation')])))
        self.assertIsNone(dispatch.locale_owned_reason(self.root,dict(kind='work',taskClass='locale-integration')))
        self.assertIn('no separate model',dispatch.locale_owned_reason(self.root,dict(kind='work',taskClass='manifest-publication')))
        task=self.packet([dict(id='resource-binding:one')]);(self.root/'packet.jsonl').write_text('changed')
        with self.assertRaisesRegex(ValueError,'packet changed'):dispatch.locale_owned_reason(self.root,task)

    def test_runtime_requires_current_complete_text_and_review(self):
        report=dict(revision='fixture',locales=[dict(locale='de',
            gates={'translate-edit':'passed','editorial':'passed','resources':'not-accepted','package':'not-accepted','runtime':'not-accepted'},
            families=[dict(id='wording',expected=2,resolved=2,reviewResolved=2)])])
        # Native-dependent resource acceptance must not be its own prerequisite.
        self.assertTrue(dispatch.text_gate(self.root,'de',report)['passed'])
        report['locales'][0]['families'][0]['reviewResolved']=1
        self.assertEqual(dispatch.text_gate(self.root,'de',report)['missing'],['text-family:wording'])
        report['locales'][0]['families'][0]['reviewResolved']=2
        report['locales'][0]['gates']['editorial']='not-accepted'
        self.assertEqual(dispatch.text_gate(self.root,'de',report)['missing'],['editorial'])
        with self.assertRaisesRegex(ValueError,'one exact locale'):dispatch.text_gate(self.root,'ja',report)

    def test_downstream_work_cannot_hide_behind_translate_edit(self):
        cases=[
            (dict(kind='work',workCategory='locale-resource'),None),
            (dict(kind='work',taskClass='package-build'),None),
            (dict(kind='review',taskClass='independent-resource-review'),dict(id='opaque',reviewKind='code')),
            (dict(kind='review',taskClass='linguistic-review'),dict(id='resource-binding:heading')),
        ]
        for index,(selector,row) in enumerate(cases):
            task=dict(selector,executionStage='translate-edit')
            if row:
                path=self.root/f'packet-{index}.jsonl'
                path.write_text(json.dumps(row)+'\n')
                task.update(reviewPacket=path.name,reviewPacketSha256=sha(path))
            with self.subTest(task=task),patch.object(dispatch,'text_gate',return_value=dict(passed=False,missing=['editorial'])) as gate:
                self.assertIn('editorial',dispatch.runtime_reason(self.root,dict(locale='de'),task))
                gate.assert_called_once()
            with patch.object(dispatch,'text_gate',return_value=dict(passed=True)):
                self.assertIsNone(dispatch.runtime_reason(self.root,dict(locale='de'),task))
        wording=dict(self.packet([dict(id='ds:1:2:Dialogue Text',source='Original',target='Translation')]),executionStage='editorial')
        with patch.object(dispatch,'text_gate') as gate:
            self.assertIsNone(dispatch.runtime_reason(self.root,dict(locale='de'),wording))
            gate.assert_not_called()

    def test_gate_publishes_one_routing_record_and_submits_no_model(self):
        phase=self.root/'language/0001-work';phase.mkdir(parents=True)
        result=phase/'result.json';result.write_text(json.dumps(dict(outcome='continue')))
        brief=phase/'next.md';brief.write_text('Prepare resource metadata from retained accepted wording.')
        task=dict(kind='work',title='Resource metadata',brief=str(brief.relative_to(self.root)),briefSha256=sha(brief))
        directory=self.root/'observer';directory.mkdir();inbox=self.root/'inbox';inbox.mkdir()
        state=dict(status='starting',phases=[dict(phase=str(phase),pid=123,resultSha256=sha(result))])
        plan=dict(root=str(self.root),technicalInbox=str(inbox),dispatchDirectory=str(directory/'dispatch-holds'),enforceLinguisticOwnership=True,executionPins={})
        # The production guard runs before phase directory creation and Popen.
        why=dispatch.reason(self.root,dict(locale='es'),task)
        with patch.object(runner.subprocess,'Popen') as model:
            replace=Path.replace
            def interrupt(path,target):
                if path.parent==inbox:raise InterruptedError('between-hold-and-inbox')
                return replace(path,target)
            with patch.object(Path,'replace',interrupt):
                with self.assertRaisesRegex(InterruptedError,'between-hold-and-inbox'):
                    dispatch.defer(self.root,directory,plan,dict(locale='es'),state,task,why)
            self.assertEqual(list(inbox.glob('*.json')),[])
            successor=self.root/'successor';successor.mkdir()
            dispatch.defer(self.root,successor,plan,dict(locale='es'),state,task,why)
            dispatch.defer(self.root,successor,plan,dict(locale='es'),state,task,why)
            model.assert_not_called()
        self.assertEqual(state['status'],'held-dispatch-policy')
        self.assertEqual(len(list(inbox.glob('*.json'))),1)
        self.assertEqual(state['pendingTask'],task)

    def test_real_supervisor_defers_before_creating_the_next_model_phase(self):
        self.supervisor_deferral(False)

    def test_locale_owned_supervisor_cannot_bypass_guard_or_create_technical_inbox(self):
        self.supervisor_deferral(True)

    def test_runtime_is_held_before_model_creation_with_other_guards_satisfied(self):
        self.supervisor_deferral(True,runtime=True)

    def test_mislabeled_resource_phase_is_held_by_the_real_supervisor(self):
        self.supervisor_deferral(True,resource=True)

    def supervisor_deferral(self,locale_owned,runtime=False,resource=False):
        text_guard=runtime or resource
        lane=self.root/'language';phase=lane/'0001-work';phase.mkdir(parents=True)
        brief=phase/'next.md';brief.write_text('Prepare existing resource bindings without new wording.')
        task=dict(kind='work',title='Resource binding transport',brief=str(brief.relative_to(self.root)),briefSha256=sha(brief))
        if locale_owned:task['taskClass']='manifest-publication'
        if runtime:task.update(taskClass='locale-integration',executionStage='runtime')
        if resource:task.update(taskClass='linguistic-work',executionStage='translate-edit',workCategory='locale-resource')
        artifact=phase/'data.json';artifact.write_text('{}')
        result=dict(outcome='continue',summary='Completed exact data transport.',progress=dict(kind='resource-build',unitIds=['one']),
            evidence=[dict(path=str(artifact.relative_to(self.root)),sha256=sha(artifact))],nextTask=task)
        result_path=phase/'result.json';result_path.write_text(json.dumps(result))
        (phase/'task.json').write_text(json.dumps(dict(task=dict(kind='work',title='Previous actual assignment'))))
        events=phase/'events.jsonl';events.write_text(json.dumps(dict(type='thread.started',thread_id='finished'))+'\n'+json.dumps(dict(type='turn.completed',usage=dict(input_tokens=10,output_tokens=2)))+'\n')
        usage=dict(input_tokens=10,cached_input_tokens=0,output_tokens=2,reasoning_output_tokens=0,total_tokens=12)
        state=dict(status='held-supervisor-error',phases=[dict(number=1,pid=123,phase=str(phase),threadId='finished',exitCode=0,measuredUsage=usage,errors=[])])
        status=lane/'status.json';status.write_text(json.dumps(state));claim=lane/'continuation.lock';claim.write_text(json.dumps(dict(pid=456)))
        receipt=self.root/'recovery.json';receipt.write_text(json.dumps(dict(kind='completed-turn-supervisor-schema-repair',
            previousStatusSha256=sha(status),previousClaimSha256=sha(claim),resultSha256=sha(result_path),archive='archive',validatedNextTask=task)))
        job=dict(locale='es',directory='language',writePrefixes=['language'],immutablePins={},requiredDeliverables=[],resumeReceipt='recovery.json',resumeReceiptSha256=sha(receipt))
        observer=self.root/'observer';observer.mkdir();inbox=self.root/'inbox';inbox.mkdir()
        plan=dict(root=str(self.root),technicalInbox=str(inbox),enforceLinguisticOwnership=True,executionPins={})
        if locale_owned:plan['localeOwned']=True
        if text_guard:
            plan['textFirst']=False  # A plan flag cannot bypass the shared ordering.
            cli=self.root/'tools/locale_queue.py';cli.parent.mkdir(exist_ok=True)
            cli.write_text('import json\nprint(json.dumps('+repr(dict(locales=[dict(locale='es',
                gates={'translate-edit':'passed','editorial':'not-accepted','resources':'passed','package':'passed'},
                families=[dict(id='text',expected=1,resolved=1,reviewResolved=1)])]))+'))\n')
        with patch.object(runner.subprocess,'Popen',wraps=runner.subprocess.Popen) as model:
            final=runner.run_lane(observer,plan,job)
            if text_guard:
                self.assertEqual(model.call_count,1)
                self.assertIn('progress',model.call_args.args[0])
            else:model.assert_not_called()
        self.assertEqual(final['status'],'held-text-prerequisites' if text_guard else 'held-dispatch-policy')
        if text_guard:self.assertIn('editorial',final['reason'])
        self.assertEqual(len(final['phases']),1)
        self.assertFalse((lane/'0002-work').exists())
        self.assertEqual(len(list(inbox.glob('*.json'))),0 if locale_owned else 1)
        if locale_owned:
            hold=list((observer/'dispatch-holds').rglob('request.json'))
            self.assertEqual(len(hold),1)
            self.assertFalse(json.loads(hold[0].read_text())['newModelRequestCreated'])


if __name__=='__main__':unittest.main()
