"""Conditional handoff boundaries; fixtures replace semantic judgments/model calls."""
import json,tempfile,unittest,subprocess
from pathlib import Path
from unittest.mock import patch
import after_editorial as q
from cli_job_support import digest

class QueueTests(unittest.TestCase):
 def fixture(self,root):
  jobs={}
  for loc in q.LOCALES:
   p=root/loc;p.mkdir();phase=p/'phase';phase.mkdir()
   packet=[{'id':i,'sourceSha256':'source-'+i,'targetSha256':'target-'+i} for i in ['one','two']]
   (phase/'pairs.jsonl').write_text(''.join(json.dumps(r)+'\n' for r in packet))
   reviewed=[{**r,'verdict':'pass','rationale':'Fake reviewer fixture'} for r in reversed(packet)]
   (phase/'reviews.jsonl').write_text(''.join(json.dumps(r)+'\n' for r in reviewed))
   result={'reviewsSha256':digest(phase/'reviews.jsonl'),'reviewedIds':2};q.save(phase/'result.json',result)
   q.save(p/'config.json',{'model':q.MODEL,'reasoning':q.EFFORT,'pins':{},'batches':[['one','two']],'candidateIds':2})
   (p/'findings.jsonl').write_text('')
   q.save(p/'job.json',{'status':'full-pass-complete-awaiting-adjudication','reviewedIds':2,
    'phases':[{'status':'interrupted-storage-full'}, {'status':'batch-reviewed','directory':str(phase),'packetSha256':digest(phase/'pairs.jsonl'),'result':result}]});jobs[loc]=str(p)
  return jobs
 def rewrite_reviews(self,p,rows):
  phase=p/'phase';(phase/'reviews.jsonl').write_text(''.join(json.dumps(r)+'\n' for r in rows))
  result={'reviewsSha256':digest(phase/'reviews.jsonl'),'reviewedIds':len(rows)};q.save(phase/'result.json',result)
  state=json.loads((p/'job.json').read_text());state['phases'][-1]['result']=result;q.save(p/'job.json',state)
 def test_all_six_actual_receipts_required_and_review_order_is_irrelevant(self):
  with tempfile.TemporaryDirectory() as tmp:
   root=Path(tmp);jobs=self.fixture(root);self.assertTrue(q.readiness(root,jobs)['ready'])
   p=Path(jobs['de'])/'job.json';j=json.loads(p.read_text());j['status']='running';q.save(p,j)
   self.assertFalse(q.readiness(root,jobs)['ready'])
   j['status']='full-pass-complete-awaiting-adjudication';q.save(p,j)
   (Path(jobs['de'])/'phase/reviews.jsonl').write_text('')
   with self.assertRaises(AssertionError):q.readiness(root,jobs)
 def test_source_change_rejects(self):
  with tempfile.TemporaryDirectory() as tmp:
   root=Path(tmp);jobs=self.fixture(root);p=Path(jobs['ru']);source=p/'source';source.write_text('old');c=json.loads((p/'config.json').read_text());c['pins']={str(source):digest(source)};q.save(p/'config.json',c);source.write_text('new')
   with self.assertRaisesRegex(AssertionError,'Editorial input changed'):q.readiness(root,jobs)
 def test_duplicate_ids_reject_even_when_count_and_hash_are_current(self):
  with tempfile.TemporaryDirectory() as tmp:
   root=Path(tmp);jobs=self.fixture(root);p=Path(jobs['ru']);r=json.loads((p/'phase/reviews.jsonl').read_text().splitlines()[0]);self.rewrite_reviews(p,[r,r])
   with self.assertRaisesRegex(AssertionError,'Duplicate review IDs'):q.readiness(root,jobs)
 def test_changed_target_hash_rejects_even_with_matching_review_file_hash(self):
  with tempfile.TemporaryDirectory() as tmp:
   root=Path(tmp);jobs=self.fixture(root);p=Path(jobs['ru']);r=[json.loads(x) for x in (p/'phase/reviews.jsonl').read_text().splitlines()];r[0]['targetSha256']='wrong';self.rewrite_reviews(p,r)
   with self.assertRaisesRegex(AssertionError,'Reviewed source/target version differs'):q.readiness(root,jobs)
 def test_astra_rejected_before_launch(self):
  with tempfile.TemporaryDirectory() as tmp:
   p=Path(tmp);q.save(p/'plan.json',{'model':'gpt-6-astra','reasoning':'high'})
   with patch.object(q.subprocess,'Popen') as launch:
    with self.assertRaises(ValueError):q.run(p)
    launch.assert_not_called()
 def test_existing_intent_cannot_submit_again(self):
  with tempfile.TemporaryDirectory() as tmp:
   p=Path(tmp);q.save(p/'plan.json',{'model':q.MODEL,'reasoning':q.EFFORT,'jobs':{k:'unused' for k in q.LOCALES}});(p/'submission-intent.json').write_text('{}')
   with patch.object(q.subprocess,'Popen') as launch:
    with self.assertRaisesRegex(AssertionError,'Prior submission'):q.run(p)
    launch.assert_not_called()
 def test_dead_observer_recovery_preserves_old_claim(self):
  with tempfile.TemporaryDirectory() as tmp:
   p=Path(tmp);q.save(p/'status.json',{'status':'held'});q.save(p/'watcher.claim',{'pid':123});before=(p/'watcher.claim').read_bytes();receipt=p/'recovery.json';q.save(receipt,{'kind':'ordered-review-guard-recovery','statusSha256':digest(p/'status.json'),'priorWatcherPid':123})
   with patch.object(q.subprocess,'run',return_value=subprocess.CompletedProcess([],1)):q.recover_observer(p,receipt)
   self.assertFalse((p/'watcher.claim').exists());self.assertEqual((p/'prior-watcher.claim').read_bytes(),before)
 def test_recovery_preserves_claim_if_prior_observer_alive(self):
  with tempfile.TemporaryDirectory() as tmp:
   p=Path(tmp);q.save(p/'status.json',{'status':'held'});q.save(p/'watcher.claim',{'pid':123});receipt=p/'recovery.json';q.save(receipt,{'kind':'ordered-review-guard-recovery','statusSha256':digest(p/'status.json'),'priorWatcherPid':123})
   with patch.object(q.subprocess,'run',return_value=subprocess.CompletedProcess([],0)):
    with self.assertRaisesRegex(AssertionError,'Prior observer still running'):q.recover_observer(p,receipt)
   self.assertTrue((p/'watcher.claim').exists())
if __name__=='__main__':unittest.main()
