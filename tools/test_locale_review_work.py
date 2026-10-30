import hashlib
import json
import os
from pathlib import Path
import tempfile
import unittest
from contextlib import contextmanager
from unittest.mock import patch

import locale_review_work as work
import locale_efficiency as efficiency
import run_locale_completion as runner
import recover_locale_completion as recovery
from locale_queue import read,sha


@contextmanager
def chdir(path):
    previous=Path.cwd();os.chdir(path)
    try:yield
    finally:os.chdir(previous)


def write_rows(path,rows):
    path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(''.join(json.dumps(row)+'\n' for row in rows))


def pair(ident):
    source='Source '+ident;target='Target '+ident
    return dict(id=ident,source=source,target=target,sourceSha256=hashlib.sha256(source.encode()).hexdigest(),targetSha256=hashlib.sha256(target.encode()).hexdigest())


class ReviewWorkTests(unittest.TestCase):
    def test_old_adopted_claim_requires_exact_pinned_handoff_provenance(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();claim=root/'claim.json';claim.write_text('{"pid":111}')
            receipt=root/'receipt.json';receipt.write_text(json.dumps(dict(kind='live-observer-handoff',threadId='exact-thread',previousClaimSha256=sha(claim))))
            job=dict(resumeReceipt='receipt.json',resumeReceiptSha256=sha(receipt));state=dict(supervisorPid=222);record=dict(threadId='exact-thread')
            self.assertTrue(recovery.owns_claim(root,job,state,record,claim,dict(pid=222)))
            self.assertFalse(recovery.owns_claim(root,job,state,dict(threadId='foreign'),claim,dict(pid=222)))
            claim.write_text('{"pid":333}')
            self.assertFalse(recovery.owns_claim(root,job,state,record,claim,dict(pid=222)))

    def test_relative_cli_paths_bind_the_same_real_project_files(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,rows,task,job=self.fixture(root)
            with chdir(root):
                authored=Path('authored.jsonl');write_rows(authored,rows[:1])
                scope=work.prepare_scope(root,Path('lane/phase/input.jsonl'),authored,Path('scope'))
                self.assertEqual(scope['reviewIds'],['a'])
                write_rows(Path('lane/phase/judgments.jsonl'),[dict(id='a',verdict='pass',rationale='Actual complete contextual reading')])
                out=work.finish_review(root,Path('lane/phase'),Path('lane/phase/judgments.jsonl'),'Read one unit',False)
                self.assertEqual(out['pending'],2);self.assertTrue((phase/'result.json').exists())

    def fixture(self,root):
        phase=root/'lane/phase';phase.mkdir(parents=True);rows=[pair(i) for i in ['a','b','c']]
        packet=phase/'input.jsonl';write_rows(packet,rows)
        task=dict(kind='review',reviewPacket=str(packet.relative_to(root)),reviewPacketSha256=sha(packet))
        job=dict(locale='es',writePrefixes=['lane'],immutablePins={})
        (phase/'task.json').write_text(json.dumps(dict(task=task,job=job)))
        return phase,rows,task,job

    def test_scope_contains_every_authored_version_and_only_caused_target_invalidations(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();packet=root/'packet.jsonl';authored=root/'authored.jsonl'
            rows=[pair(i) for i in ['new','affected','context1','context2']];write_rows(packet,rows);write_rows(authored,rows[:1]);before=packet.read_bytes()
            proof=root/'join.json';proof.write_text('{"realConsumer":"same joined output"}')
            dep=dict(id='affected',causedBy=['new'],reason='Same actual joined output',evidence=dict(path='join.json',sha256=sha(proof)))
            scope=work.prepare_scope(root,packet,authored,root/'scope',[dep])
            self.assertEqual(scope['reviewIds'],['new','affected']);self.assertEqual(scope['sourceContextIds'],['context1','context2'])
            context=[json.loads(s) for s in (root/'scope/source-context.jsonl').read_text().splitlines()]
            self.assertTrue(all('target' not in row for row in context));self.assertEqual(packet.read_bytes(),before)
            self.assertEqual([r['source'] for r in context],[r['source'] for r in rows[2:]])
            dep['causedBy']=['unrelated']
            with self.assertRaisesRegex(ValueError,'concrete cause'):work.prepare_scope(root,packet,authored,root/'bad',[dep])
            self.assertFalse((root/'bad').exists())

    def test_sparse_review_and_declared_context_are_distinct_from_missing_primary(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,rows,task,job=self.fixture(root)
            context=pair('context');cp=phase/'context.jsonl';write_rows(cp,[context]);task['contextPackets']=[str(cp.relative_to(root))]
            reviewed=[dict(rows[0],verdict='pass',rationale='Actually read'),dict(context,verdict='context-only-preserve',rationale='Actually checked source context',notLinguisticCoverage=True,targetEdited=False)]
            out=phase/'reviews.jsonl';write_rows(out,reviewed);next_packet=phase/'next.jsonl';write_rows(next_packet,rows[1:]);brief=phase/'next.md';brief.write_text('Read exact remaining versions')
            result=dict(outcome='continue',summary='One primary and one context read',reviews=str(out.relative_to(root)),
                progress=dict(kind='reviewed',unitIds=['a']),evidence=[dict(path=str(out.relative_to(root)),sha256=sha(out))],
                nextTask=dict(kind='review',title='Read pending',brief=str(brief.relative_to(root)),reviewPacket=str(next_packet.relative_to(root))))
            runner.validate_result(root,job,phase,task,result,set());coverage=result['verifiedReviewCoverage']
            self.assertEqual((coverage['assigned'],coverage['judged'],coverage['declaredContextJudgments']),(3,1,1))
            self.assertEqual(coverage['pendingIds'],['b','c'])
            reviewed[1]['sourceSha256']='wrong';write_rows(out,reviewed);result['evidence'][0]['sha256']=sha(out)
            with self.assertRaisesRegex(ValueError,'versions differ'):runner.validate_result(root,job,phase,task,result,set())

    def test_shared_finish_writes_only_actual_judgments_and_exact_pending_ledger(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,rows,task,job=self.fixture(root);j=phase/'judgments.jsonl'
            write_rows(j,[dict(id='a',verdict='pass',rationale='Complete source and native reading performed')]);input_before=(phase/'input.jsonl').read_bytes()
            result=work.finish_review(root,phase,j,'One actual unit reviewed',False)
            self.assertEqual((result['judged'],result['pending']),(1,2))
            review_rows=work.load_rows(phase/'review-output/reviews.jsonl');self.assertEqual(len(review_rows),1)
            self.assertEqual(review_rows[0]['sourceSha256'],rows[0]['sourceSha256'])
            self.assertEqual([r['id'] for r in work.load_rows(phase/'review-output/pending.jsonl')],['b','c'])
            self.assertEqual((phase/'input.jsonl').read_bytes(),input_before)
            self.assertEqual(read(phase/'result.json')['verifiedReviewCoverage']['judged'],1)

    def test_complete_packet_continues_without_claiming_whole_localization_ready(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,rows,task,job=self.fixture(root);j=phase/'judgments.jsonl'
            write_rows(j,[dict(id=r['id'],verdict='pass',rationale='Actual complete source/native/context reading') for r in rows])
            brief=phase/'next.md';brief.write_text('Author the next actual wording family')
            out=work.finish_review(root,phase,j,'Complete finite packet',True,dict(kind='work',title='Next wording family',brief=str(brief.relative_to(root))))
            self.assertEqual(out['pending'],0);result=read(phase/'result.json')
            self.assertEqual(result['outcome'],'continue');self.assertEqual(result['verifiedReviewCoverage']['judged'],3)
            self.assertNotIn('dispositionMatrix',result)

    def test_hash_mismatch_and_unread_context_do_not_publish_a_success(self):
        for mismatch in [True,False]:
            with self.subTest(mismatch=mismatch),tempfile.TemporaryDirectory() as tmp:
                root=Path(tmp).resolve();phase,rows,task,job=self.fixture(root);j=phase/'judgments.jsonl'
                decisions=[dict(id=r['id'],verdict='pass',rationale='Actual fixture judgment') for r in rows]
                if mismatch:decisions[0]['targetSha256']='wrong'
                write_rows(j,decisions)
                with self.assertRaisesRegex(ValueError,'version differs|Unread required context'):
                    work.finish_review(root,phase,j,'Fixture',False)
                self.assertFalse((phase/'result.json').exists());self.assertFalse((phase/'review-output').exists())

    def test_context_debt_cannot_disappear_at_terminal_acceptance(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,rows,task,job=self.fixture(root);task['contextCarryover']=[dict(id='context',sourceSha256='s',targetSha256='t')]
            out=phase/'reviews.jsonl';write_rows(out,[dict(r,verdict='pass',rationale='Read') for r in rows])
            result=dict(outcome='blocked',summary='Would otherwise finish',reviews=str(out.relative_to(root)),independentWorkRemaining=False,
                blockers=[dict(predicate='Native',evidence='Not run',nextAction='Owner scope')])
            with self.assertRaisesRegex(ValueError,'Unread required context'):runner.validate_result(root,job,phase,task,result,set())

    def test_prerequisite_repair_keeps_all_review_debt(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,rows,task,job=self.fixture(root);packet=phase/'input.jsonl'
            carry=dict(packet=str(packet.relative_to(root)),sha256=sha(packet),pendingIds=[r['id'] for r in rows])
            evidence=phase/'fixed-reader.json';evidence.write_text('{"receiptInputCheck":"repaired"}')
            brief=phase/'next.md';brief.write_text('Independently review repaired prerequisite and pending resource contracts')
            result=dict(outcome='continue',summary='Concrete prerequisite repaired',progress=dict(kind='technical-proof',unitIds=['reader']),
                evidence=[dict(path=str(evidence.relative_to(root)),sha256=sha(evidence))],
                nextTask=dict(kind='review',title='Exact pending review',brief=str(brief.relative_to(root)),reviewPacket=str(packet.relative_to(root))))
            runner.validate_result(root,dict(job,locale='technical'),phase,dict(kind='technical',reviewCarryover=carry),result,set())
            self.assertEqual(result['nextTask']['reviewCarryover']['pendingIds'],['a','b','c']);self.assertEqual(result['verifiedReviewCoverage']['judged'],0)

    def test_technical_handoff_is_data_only_and_idempotent(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,rows,task,job=self.fixture(root);group=root/'group';group.mkdir()
            request=phase/'handoff.json';request.write_text(json.dumps(dict(predicate='Actual missing shared adapter',affectedIds=['a'],evidence=['frozen join'],requiredResult='One explicit locale adapter')))
            result=dict(technicalHandoffs=[dict(path=str(request.relative_to(root)),sha256=sha(request))])
            with patch.object(runner.subprocess,'Popen') as model:
                one=runner.publish_technical_handoffs(root,group,job,result);two=runner.publish_technical_handoffs(root,group,job,result)
                model.assert_not_called()
            self.assertEqual(one,two);self.assertEqual(len(list((group/'technical-inbox').glob('*.json'))),1)
            delivery=phase/'delivery.json';delivery.write_text('{"actualResult":"finite adapter contract completed"}')
            closure=dict(request=dict(path=one[0],sha256=sha(root/one[0])),delivery=dict(path=str(delivery.relative_to(root)),sha256=sha(delivery)))
            runner.publish_technical_handoffs(root,group,dict(job,locale='technical'),dict(resolvedTechnicalHandoffs=[closure]))
            config=read(phase/'task.json');config.update(laneRole='shared-technical',technicalInbox=str(group/'technical-inbox'));(phase/'task.json').write_text(json.dumps(config))
            (phase/'runtime-verification.json').write_text(json.dumps(dict(threadId='fixture',actualRuntime=dict(turn=dict(model='gpt-6.1-sol',effort='high'),session=dict(model_provider='openai',parent_thread_id=None)))))
            self.assertEqual(efficiency.inspect_phase(phase)['technicalInbox']['pendingCount'],0)

    def test_adopted_terminal_metadata_survives_invalid_result(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase,rows,task,job=self.fixture(root);lane=phase.parent
            (phase/'result.json').write_text('{"outcome":"invalid","summary":"Broken transport"}')
            (phase/'events.jsonl').write_text(json.dumps(dict(type='thread.started',thread_id='old'))+'\n'+json.dumps(dict(type='turn.completed',usage=dict(input_tokens=10,output_tokens=2)))+'\n')
            (lane/'status.json').write_text(json.dumps(dict(status='running',phases=[dict(number=1,phase=str(phase),pid=99999999,threadId='old')])));(lane/'continuation.lock').write_text('{"pid":123}')
            receipt=root/'receipt.json';receipt.write_text(json.dumps(dict(kind='live-observer-handoff',previousStatusSha256=sha(lane/'status.json'),archive='archive',previousClaimSha256=sha(lane/'continuation.lock'))))
            job.update(directory='lane',resumeReceipt='receipt.json',resumeReceiptSha256=sha(receipt));plan=dict(root=str(root))
            with patch.object(runner,'process_identity',return_value=None):
                with self.assertRaisesRegex(ValueError,'Expected continue'):runner.run_lane(root,plan,job)
            saved=read(lane/'status.json')['phases'][-1];self.assertIsNone(saved['exitCode']);self.assertFalse(saved['exitCodeKnown']);self.assertEqual(saved['measuredUsage']['total_tokens'],12)


if __name__=='__main__':unittest.main()
