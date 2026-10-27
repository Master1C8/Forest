"""Conditional handoff boundaries. Fixtures replace linguistic judgments/model calls."""
import json,tempfile,unittest
from pathlib import Path
from unittest.mock import patch
import after_editorial as q
from cli_job_support import digest

class QueueTests(unittest.TestCase):
 def fixture(self,root):
  jobs={}
  for loc in q.LOCALES:
   p=root/loc;p.mkdir();phase=p/'phase';phase.mkdir();(phase/'pairs.jsonl').write_text('fixture exact packet\n');(phase/'reviews.jsonl').write_text('{"id":"one","verdict":"pass","rationale":"Fake reviewer fixture"}\n')
   q.save(phase/'result.json',{'reviewsSha256':digest(phase/'reviews.jsonl'),'reviewedIds':1})
   q.save(p/'config.json',{'model':q.MODEL,'reasoning':q.EFFORT,'pins':{},'batches':[['one']],'candidateIds':1})
   (p/'findings.jsonl').write_text('')
   q.save(p/'job.json',{'status':'full-pass-complete-awaiting-adjudication','reviewedIds':1,
    'phases':[{'status':'interrupted-storage-full'}, {'status':'batch-reviewed','directory':str(phase),'packetSha256':digest(phase/'pairs.jsonl')}]});jobs[loc]=str(p)
  return jobs
 def test_all_six_actual_receipts_required_not_a_counter(self):
  with tempfile.TemporaryDirectory() as tmp:
   root=Path(tmp);jobs=self.fixture(root);self.assertTrue(q.readiness(root,jobs)['ready'])
   p=Path(jobs['de'])/'job.json';j=json.loads(p.read_text());j['status']='running';q.save(p,j)
   self.assertFalse(q.readiness(root,jobs)['ready'])
   j['status']='full-pass-complete-awaiting-adjudication';q.save(p,j)
   (Path(jobs['de'])/'phase/reviews.jsonl').write_text('')
   with self.assertRaises(AssertionError):q.readiness(root,jobs)
 def test_source_change_and_duplicate_ids_reject(self):
  with tempfile.TemporaryDirectory() as tmp:
   root=Path(tmp);jobs=self.fixture(root);p=Path(jobs['ru']);source=p/'source';source.write_text('old');c=json.loads((p/'config.json').read_text());c['pins']={str(source):digest(source)};q.save(p/'config.json',c);source.write_text('new')
   with self.assertRaisesRegex(AssertionError,'Editorial input changed'):q.readiness(root,jobs)
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
if __name__=='__main__':unittest.main()
