"""Deterministic selection tests; fake reviews do not establish linguistic quality."""
import json,tempfile,unittest
from pathlib import Path
from unittest.mock import patch
import editorial_adjudication_inputs as tool
from editorial_lane import save,encoded,sha

class InputsTests(unittest.TestCase):
 def fixture(self,root):
  p=root/'job';p.mkdir();phase=p/'phase';phase.mkdir()
  packet=[{'id':str(i),'source':'Full source '+str(i),'target':'Full target '+str(i),'sourceSha256':'s'+str(i),'targetSha256':'t'+str(i),'links':[]} for i in range(4)]
  verdicts=['pass','technical-preservation','finding','needs-context'];rs=[{**{k:r[k] for k in ['id','sourceSha256','targetSha256']},'verdict':verdicts[i],'rationale':'Fake model fixture only',**({'proposedTarget':'Complete proposed wording'} if i==2 else {})} for i,r in enumerate(packet)]
  raw=''.join(encoded(r)+'\n' for r in packet);(p/'pairs.jsonl').write_text(raw);(phase/'pairs.jsonl').write_text(raw);(phase/'reviews.jsonl').write_text(''.join(encoded(r)+'\n' for r in reversed(rs)));(p/'findings.jsonl').write_text(''.join(encoded(r)+'\n' for r in rs if r['verdict']!='pass'))
  result={'reviewsSha256':sha(phase/'reviews.jsonl')};save(phase/'result.json',result);save(p/'config.json',{'locale':'fixture','candidateIds':4,'pins':{}});save(p/'job.json',{'status':'full-pass-complete-awaiting-adjudication','reviewedIds':4,'phases':[{'status':'batch-reviewed','directory':str(phase),'result':result,'packetSha256':sha(phase/'pairs.jsonl')}]});return p,rs
 def test_selects_actual_cases_without_new_verdicts_or_text_changes(self):
  with tempfile.TemporaryDirectory() as tmp:
   p,rs=self.fixture(Path(tmp));before=(p/'pairs.jsonl').read_bytes();r=tool.prepare(p,p/'inputs');self.assertEqual(r['actualCases'],2);self.assertEqual(r['retainedTechnicalReceipts'],1);self.assertEqual(r['modelJudgmentsGenerated'],0)
   cases=[json.loads(s) for s in (p/'inputs/cases.jsonl').read_text().splitlines()];self.assertEqual([r['id'] for r in cases],['2','3']);self.assertEqual(cases[0]['initialReview'],rs[2]);self.assertEqual((p/'pairs.jsonl').read_bytes(),before)
 def test_failure_before_manifest_leaves_unaccepted_partial_not_a_transaction(self):
  with tempfile.TemporaryDirectory() as tmp:
   p,_=self.fixture(Path(tmp));out=p/'partial'
   with patch.object(tool,'save',side_effect=OSError('fixture publish interruption')):
    with self.assertRaisesRegex(OSError,'fixture publish'):tool.prepare(p,out)
   self.assertTrue((out/'cases.jsonl').exists());self.assertFalse((out/'manifest.json').exists())
   with self.assertRaisesRegex(AssertionError,'New immutable'):tool.prepare(p,out)
   result=tool.prepare(p,p/'new-attempt');self.assertEqual(result['actualCases'],2)
   self.assertTrue((out/'cases.jsonl').exists())
 def test_missing_consolidated_finding_rejects_before_output(self):
  with tempfile.TemporaryDirectory() as tmp:
   p,_=self.fixture(Path(tmp));(p/'findings.jsonl').write_text('');out=p/'inputs'
   with self.assertRaisesRegex(AssertionError,'Consolidated finding'):tool.prepare(p,out)
   self.assertFalse(out.exists())
if __name__=='__main__':unittest.main()
