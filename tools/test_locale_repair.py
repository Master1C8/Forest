"""Queue repair boundaries; no paid requests or native game dependencies."""
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import run_locale_completion as runner
import recover_locale_completion as recover
from locale_queue import sha


class RepairTests(unittest.TestCase):
    def setUp(self):
        self.tmp=tempfile.TemporaryDirectory();self.addCleanup(self.tmp.cleanup)
        self.root=Path(self.tmp.name).resolve()

    def write(self,name,value):
        path=self.root/name;path.parent.mkdir(parents=True,exist_ok=True)
        path.write_text(json.dumps(value));return path

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
