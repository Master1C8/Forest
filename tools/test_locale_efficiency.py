import copy
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import locale_efficiency as e
import restart_locale_completion as restart
import run_locale_completion as runner
from locale_queue import sha,read


class EfficiencyTests(unittest.TestCase):
    def test_unread_inherited_nonpass_is_carried_without_acceptance(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase=root/'job/phase';phase.mkdir(parents=True)
            pair=dict(id='one',sourceSha256='s',targetSha256='t');packet=phase/'packet.jsonl';packet.write_text(json.dumps(pair)+'\n')
            task=dict(kind='review',reviewPacket=str(packet.relative_to(root)),reviewPacketSha256=sha(packet))
            reviews=phase/'reviews.jsonl';prior=dict(pair,verdict='needs-context')
            row=dict(prior,reviewed=False,rationale='Current complete context reading pending',pendingSemanticReview=True,
                inheritedVerdictUnchanged=True,inheritedNonPassEvidence=dict(original=prior))
            reviews.write_text(json.dumps(row)+'\n');brief=phase/'next.md';brief.write_text('Read the exact pending version')
            result=dict(outcome='continue',summary='Explicit unread checkpoint',reviews=str(reviews.relative_to(root)),
                progress=dict(kind='reviewed',unitIds=['context-already-read']),evidence=[dict(path=str(reviews.relative_to(root)),sha256=sha(reviews))],
                nextTask=dict(kind='review',title='Read pending',brief=str(brief.relative_to(root)),reviewPacket=str(packet.relative_to(root))))
            runner.validate_result(root,dict(writePrefixes=['job']),phase,task,result,set())
            self.assertEqual(result['verifiedReviewCoverage']['judged'],0)
            self.assertEqual(result['verifiedReviewCoverage']['pendingIds'],['one'])
            wrapped=copy.deepcopy(row);wrapped['inheritedNonPassEvidence']['original']=dict(pair,receipt=prior)
            reviews.write_text(json.dumps(wrapped)+'\n');result['evidence'][0]['sha256']=sha(reviews)
            runner.validate_result(root,dict(writePrefixes=['job']),phase,task,result,set())
            self.assertEqual(result['verifiedReviewCoverage']['judged'],0)
            for change in [dict(verdict='pass'),dict(inheritedVerdictUnchanged=False),dict(sourceSha256='changed')]:
                bad=dict(row,**change);reviews.write_text(json.dumps(bad)+'\n');result['evidence'][0]['sha256']=sha(reviews)
                with self.assertRaises(ValueError):runner.validate_result(root,dict(writePrefixes=['job']),phase,task,result,set())

    def test_lossless_view_preserves_every_field_and_deduplicates_exact_context(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();packet=root/'packet.jsonl'
            context=dict(body='Complete exact context\n'*400,values=[None,False,0,1,'\u200f','á','a\u0301'])
            rows=[dict(id=str(i),source='Source\n',target='Target\r\n',context=copy.deepcopy(context),
                       sourceSha256='s',targetSha256='t') for i in range(30)]
            packet.write_text(''.join(json.dumps(row,ensure_ascii=False)+'\n' for row in rows));before=packet.read_bytes()
            m=e.make_view(root,[packet],root/'view');self.assertTrue(m['roundtrip'])
            self.assertLess(m['viewBytes'],len(before)//3);self.assertEqual(before,packet.read_bytes())
            defs={};actual=[]
            for page in m['pages']:
                p=root/page['path'];self.assertEqual(sha(p),page['sha256'])
                for line in p.read_text().splitlines():
                    x=json.loads(line)
                    if 'definition' in x:defs[x['definition']]=x['value']
                    else:actual.append(x['value'])
            def decode(x):
                if isinstance(x,dict):
                    if set(x)=={e.REF}:return decode(defs[x[e.REF]])
                    return {k:decode(v) for k,v in x.items()}
                if isinstance(x,list):return [decode(v) for v in x]
                return x
            self.assertEqual([decode(x) for x in actual],rows)
            self.assertEqual(e.canonical([decode(x) for x in actual]),e.canonical(rows))

    def test_producer_artifacts_and_next_brief_bind_review_without_rewriting_result(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase=root/'job/author';phase.mkdir(parents=True)
            packet=phase/'review-packet.jsonl';packet.write_text('{"id":"one","sourceSha256":"s","targetSha256":"t"}\n')
            brief=phase/'next.md';brief.write_text('Read every pair and context')
            artifact=phase/'evidence.json';artifact.write_text('{"actual":"authored"}\n')
            manifest=phase/'handoff-manifest.json';content=dict(reviewPacket=dict(path=str(packet.relative_to(root)),sha256=sha(packet)),
                nextBrief=dict(path=str(brief.relative_to(root)),sha256=sha(brief)),
                artifacts=[dict(path=str(artifact.relative_to(root)),sha256=sha(artifact))])
            manifest.write_text(json.dumps(content))
            job=dict(writePrefixes=['job']);task=dict(kind='work')
            result=dict(outcome='continue',summary='Actual authored fixture',progress=dict(kind='authored',unitIds=['one']),
                evidence=[dict(path=str(manifest.relative_to(root)),sha256=sha(manifest))],
                nextTask=dict(kind='review',title='Review',brief=str(brief.relative_to(root))))
            runner.validate_result(root,job,phase,task,result,set());self.assertEqual(result['nextTask']['reviewPacket'],str(packet.relative_to(root)))
            before=manifest.read_bytes();artifact.write_text('changed')
            result['nextTask'].pop('reviewPacket')
            with self.assertRaisesRegex(ValueError,'dependency changed'):runner.validate_result(root,job,phase,task,result,set())
            self.assertEqual(manifest.read_bytes(),before)

    def test_duplicate_keys_and_reference_collision_reject_before_view(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp)
            for text in ['{"id":"a","id":"b"}\n','{"'+e.REF+'":"injected"}\n']:
                p=root/'packet.jsonl';p.write_text(text)
                with self.assertRaisesRegex(ValueError,'reserved'):e.make_view(root,[p],root/'view')
                self.assertFalse((root/'view').exists())

    def test_combined_packets_retain_union_and_reject_same_id_different_version(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);a=root/'a.jsonl';b=root/'b.jsonl'
            shared=dict(id='context',source='Exact',target='Exact');one=dict(id='one',source='s',target='t')
            a.write_text(json.dumps(shared)+'\n'+json.dumps(one)+'\n');b.write_text(json.dumps(shared)+'\n'+json.dumps(dict(id='two',source='s2',target='t2'))+'\n')
            ids=restart.combine_packets(root,[a,b],root/'combined.jsonl');self.assertEqual(ids,['context','one','two'])
            b.write_text(json.dumps(dict(shared,target='changed'))+'\n')
            with self.assertRaisesRegex(ValueError,'Conflicting'):restart.combine_packets(root,[a,b],root/'bad.jsonl')
            self.assertFalse((root/'bad.jsonl').exists())

    def test_bounded_usage_tail_counts_cached_as_subset(self):
        with tempfile.TemporaryDirectory() as tmp:
            p=Path(tmp)/'session.jsonl';usage=dict(input_tokens=120000,cached_input_tokens=90000,output_tokens=12000)
            p.write_text('x'*2200000+'\n'+json.dumps(dict(type='event_msg',payload=dict(type='token_count',info=dict(total_token_usage=usage))))+'\n')
            self.assertEqual(e.latest_usage(p),usage)

    def test_owner_stopped_request_restarts_fresh_without_promoting_drafts(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();phase=root/'lane/0001-work';phase.mkdir(parents=True);lane=phase.parent
            draft=phase/'draft.json';draft.write_text('{"judgment":"unaccepted"}\n');before=draft.read_bytes()
            brief=root/'restart.md';brief.write_text('Finish actual interrupted work with verified drafts')
            record=dict(number=1,phase=str(phase),pid=99999998,threadId='stopped',status='running')
            (lane/'status.json').write_text(json.dumps(dict(status='owner-stopped',phases=[record])))
            (lane/'continuation.lock').write_text('{"pid":123}\n')
            receipt=root/'receipt.json';receipt.write_text(json.dumps(dict(kind='owner-stopped-efficiency-restart',
                previousStatusSha256=sha(lane/'status.json'),previousClaimSha256=sha(lane/'continuation.lock'),
                stoppedPhasePins={str(draft.relative_to(root)):sha(draft)},currentInputPins={},acceptedResult=False,terminalUsage=None,
                validatedNextTask=dict(kind='work',title='Finish',brief='restart.md',briefSha256=sha(brief)))))
            job=dict(locale='de',directory='lane',writePrefixes=['lane'],requiredDeliverables=['family'],immutablePins={},resumeReceipt='receipt.json',resumeReceiptSha256=sha(receipt))
            plan=dict(root=str(root),cli='fixture',model=dict(name='gpt-6.1-sol',reasoning='high',provider='openai',inheritedHistory=False),executionPins={})
            calls=[]
            class Child:
                pid=99999999
                def __init__(self,argv,**kwargs):
                    calls.append(argv);p=Path(argv[argv.index('--output-last-message')+1]).parent
                    (p/'result.json').write_text(json.dumps(dict(outcome='blocked',summary='Actual exhausted static boundary',independentWorkRemaining=False,
                        blockers=[dict(predicate='Native',evidence='Static fixture done',nextAction='Owner runtime scope')]))+'\n')
                    kwargs['stdout'].write(json.dumps(dict(type='thread.started',thread_id='fresh'))+'\n'+json.dumps(dict(type='turn.completed',usage=dict(input_tokens=10,output_tokens=2)))+'\n');kwargs['stdout'].flush()
                def wait(self):return 0
            with patch.object(runner,'process_identity',return_value=None),patch.object(runner.subprocess,'Popen',side_effect=Child),patch.object(runner,'publish_current_runtime',return_value=dict(threadId='fresh')):
                state=runner.run_lane(root,plan,job)
            self.assertEqual(len(calls),1);self.assertEqual(state['phases'][0]['status'],'owner-interrupted-unaccepted')
            self.assertEqual(state['phases'][1]['number'],2);self.assertEqual(draft.read_bytes(),before)
            self.assertNotIn('outcome',state['phases'][0]);self.assertFalse(state['phases'][0]['osExitCodeKnown'])


if __name__=='__main__':unittest.main()
