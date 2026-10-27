"""Transport and live-observer handoff regressions; fake workers, no semantic proof."""
from contextlib import redirect_stdout
import io,json,subprocess,sys,tempfile,time
from pathlib import Path
import unittest
from unittest.mock import patch
import editorial_lane as audit
from test_editorial_lane import row
import test_editorial_lane as fixtures

class CompactTransport(unittest.TestCase):
 def test_japanese_existing_draft_can_enter_the_same_preliminary_editorial_runner(self):
  with tempfile.TemporaryDirectory() as tmp:
   root=Path(tmp).resolve();old,home=fixtures.EditorialStorage().fixture(root)
   import shutil
   shutil.copy2(root/'localization/glossary/ru.json',root/'localization/glossary/ja.json')
   target=root/'localization/ja-assets';target.mkdir()
   shutil.copy2(root/'localization/ru-assets/dialogue.ru.jsonl',target/'dialogue.ja.jsonl')
   config=audit.prepare(root,root/'outputs/japanese-fixture','ja','Japanese')
   self.assertEqual(config['locale'],'ja');self.assertEqual(config['candidateIds'],2)
   with self.assertRaisesRegex(AssertionError,'Explicit authorized'):audit.prepare(root,root/'outputs/unauthorized','ko','Korean')
 def test_lossless_complete_coverage_and_batched_decisions(self):
  with tempfile.TemporaryDirectory() as tmp:
   phase=Path(tmp);packet=[]
   for i in range(350):
    packet.append({**row(str(i),'Complete source\n<tag>{x}</tag> '+str(i),'Полная строка\n'+str(i)),
     'conversationId':1,'conversation':'scene','actor':'7','conversant':'2','title':'title',
     'sequence':'Wait(1)','conditions':'x == 1','script':'x=2','links':[{'destinationDialogueID':i+1}],
     'isGroup':0,'unchangedReason':None,'unchangedCategory':None})
   (phase/'pairs.jsonl').write_text(''.join(audit.encoded(r)+'\n' for r in packet))
   restored=[];start=0;calls=0
   while start<len(packet):
    out=io.StringIO()
    with redirect_stdout(out):audit.read_compact(phase,start)
    emitted=json.loads(out.getvalue());self.assertLessEqual(len(out.getvalue().encode()),24001)
    restored.extend(dict(zip(emitted['fields'],r)) for r in emitted['rows']);start=emitted['next'];calls+=1
   self.assertLess(calls,18)
   self.assertEqual(restored,[{k:r.get(k) for k in audit.COMPACT_FIELDS} for r in packet])
   decisions=[{'id':r['id'],'verdict':'pass','rationale':'Explicit fake reviewer fixture, not model semantics.'} for r in packet]
   with redirect_stdout(io.StringIO()):audit.record_decisions(phase,decisions)
   self.assertEqual(len(audit.finalize(phase)),350)
   before=(phase/'decisions.jsonl').read_bytes()
   with self.assertRaisesRegex(AssertionError,'Foreign/duplicate'):
    audit.record_decisions(phase,[{'id':'0','verdict':'pass','rationale':'Duplicate'}])
   self.assertEqual((phase/'decisions.jsonl').read_bytes(),before)
   next((phase/'reads').glob('*.json')).unlink()
   with self.assertRaisesRegex(AssertionError,'Missing full emitted-read coverage'):audit.finalize(phase)
 def test_oversized_unit_is_not_truncated_or_credited(self):
  with tempfile.TemporaryDirectory() as tmp:
   p=Path(tmp);(p/'pairs.jsonl').write_text(audit.encoded(row('long','x'*30000))+'\n')
   with self.assertRaisesRegex(AssertionError,'Oversized unit'):audit.read_compact(p,0)
   self.assertFalse((p/'reads').exists())
 def test_bootstrap_complete_unicode_parts_and_unique_documents(self):
  with tempfile.TemporaryDirectory() as tmp:
   p=Path(tmp);audit.save(p/'config.json',{'model':audit.MODEL,'reasoning':audit.EFFORT})
   docs=[p/'rules.md',p/'glossary.json'];docs[0].write_text('Rule\n'+'語'*20000);docs[1].write_text(json.dumps({'meaning':'Full unchanged meaning','term':'名前'},ensure_ascii=False,indent=2))
   start=0;parts=[]
   with patch.object(audit,'bootstrap_documents',return_value=docs):
    while True:
     out=io.StringIO()
     with redirect_stdout(out):audit.bootstrap(p,start)
     v=json.loads(out.getvalue());parts.append(v['text']);start=v['next']
     if start==v['length']:break
   joined=''.join(parts);self.assertIn(docs[0].read_text(),joined)
   self.assertIn(audit.encoded(json.loads(docs[1].read_text())),joined)
   self.assertEqual(joined.count('DOCUMENT '+str(docs[0])+'\n'),1)
   audit.save(p/'config.json',{'model':'gpt-6-astra','reasoning':audit.EFFORT})
   with self.assertRaisesRegex(ValueError,'Only explicitly pinned'):audit.bootstrap(p)

class LiveHandoff(unittest.TestCase):
 def test_upgrade_freezes_helpers_preserves_live_files_and_rejects_duplicate_submission(self):
  import shutil
  with tempfile.TemporaryDirectory() as tmp:
   root=Path(tmp).resolve();old,home=fixtures.EditorialStorage().fixture(root)
   directory=root/'outputs/editorial-20261027/ru';shutil.copytree(old,directory)
   phase=directory/'0001-semantic';phase.mkdir()
   state=json.loads((directory/'job.json').read_text());state.update(status='running',supervisorPid=101,pid=102,phases=[{'number':1,'status':'running','directory':str(phase)}]);audit.save(directory/'job.json',state)
   original=audit.sha(directory/'editorial_lane.py')
   def identity(pid):return str(directory)+' observer' if pid==101 else 'codex --model gpt-6.1-sol '+str(phase/'last-message.txt')
   class Child:pid=103
   with patch.object(audit,'process_identity',side_effect=identity),patch.object(audit.subprocess,'Popen',return_value=Child()) as launch,patch.object(audit.os,'kill') as kill:
    result=audit.stage_upgrade(directory,'execution-test')
    self.assertEqual(result['preservedWorkerPid'],102);kill.assert_not_called()
    self.assertEqual(audit.sha(directory/'editorial_lane.py'),original)
    self.assertEqual(audit.sha(directory/'execution-test/editorial_lane.py'),audit.sha(Path(audit.__file__)))
    with self.assertRaisesRegex(AssertionError,'Existing submission'):audit.stage_upgrade(directory,'execution-test')
    self.assertEqual(launch.call_count,1)
 def test_real_child_survives_observer_handoff_and_prefix_is_preserved(self):
  with tempfile.TemporaryDirectory() as tmp:
   root=Path(tmp);directory,home=fixtures.EditorialStorage().fixture(root)
   config=json.loads((directory/'config.json').read_text());phase=directory/'0001-semantic';phase.mkdir()
   (phase/'pairs.jsonl').write_text(audit.encoded(audit.rows(directory/'pairs.jsonl')[0])+'\n')
   worker=directory/'worker.py';worker.write_text('''import json,time,sys
from pathlib import Path
sys.path.insert(0,sys.argv[1]);import editorial_lane as a
p=Path(sys.argv[2]);time.sleep(.8)
a.read_packet(p,0,1)
p.joinpath('decisions.jsonl').write_text(a.encoded({'id':a.rows(p/'pairs.jsonl')[0]['id'],'verdict':'pass','rationale':'Fake OS-survival fixture only'})+'\\n')
a.finalize(p)
with (p/'events.jsonl').open('w') as f:
 f.write(json.dumps({'type':'thread.started','thread_id':'fake-live'})+'\\n')
 f.write(json.dumps({'type':'turn.completed','usage':{'input_tokens':1,'output_tokens':1}})+'\\n')
''')
   supervisor=directory/'supervisor.py';supervisor.write_text('''import subprocess,sys,json,time
from pathlib import Path
p=subprocess.Popen([sys.executable,sys.argv[1],sys.argv[2],sys.argv[3],'--model','gpt-6.1-sol','--output-last-message',str(Path(sys.argv[3])/'last-message.txt')],stdout=subprocess.DEVNULL)
target=Path(sys.argv[4]);temporary=target.with_suffix('.pending');temporary.write_text(str(p.pid));temporary.replace(target);p.wait()
''')
   parent=subprocess.Popen([sys.executable,str(supervisor),str(worker),str(Path(audit.__file__).parent),str(phase),str(directory/'child.pid')])
   try:
    until=time.monotonic()+3
    while not (directory/'child.pid').exists():
     self.assertLess(time.monotonic(),until);time.sleep(.01)
    child=int((directory/'child.pid').read_text())
    state=json.loads((directory/'job.json').read_text());state.update(status='handoff-draining-current-batch',supervisorPid=parent.pid,pid=child,phases=[{'number':1,'status':'interrupted-storage-full','directory':str(directory/'old-partial')},{'number':1,'directory':str(phase),'status':'running','pid':child,'packetSha256':audit.sha(phase/'pairs.jsonl'),'command':['fake','--model','gpt-6.1-sol','--ignore-user-config']}]);audit.save(directory/'job.json',state);audit.save(directory/'queue.lock',{'pid':parent.pid})
    receipt=directory/'handoff.json';audit.save(receipt,{'kind':'editorial-live-supervisor-handoff','job':str(directory),'configSha256':audit.sha(directory/'config.json'),'supervisorPid':parent.pid,'supervisorIdentity':audit.process_identity(parent.pid),'prefixHashes':{}})
    # Reap only the fake observer; the model substitute remains a real child
    # and must finish its own marker/decisions after the observer's SIGTERM.
    original=audit.process_identity
    def identity(pid):
     if pid==parent.pid and parent.poll() is not None:return None
     value=original(pid)
     if pid==child:
      stateps=subprocess.run(['ps','-p',str(pid),'-o','stat='],capture_output=True,text=True)
      if 'Z' in stateps.stdout:return None
     return value
    with patch.object(audit,'process_identity',side_effect=identity):done=audit.adopt_live(directory,state,config,receipt)
    self.assertEqual(done,1);self.assertEqual(state['reviewedIds'],1)
    self.assertEqual(state['phases'][-1]['threadId'],'fake-live');self.assertIsNone(state['phases'][-1]['exitCode'])
    self.assertTrue((phase/'reviews.jsonl').is_file());self.assertEqual(json.loads((directory/'queue.lock').read_text())['pid'],__import__('os').getpid())
   finally:
    if parent.poll() is None:parent.terminate()
    parent.wait(timeout=3)
 def test_wrong_supervisor_identity_rejected_before_signal(self):
  with tempfile.TemporaryDirectory() as tmp:
   p=Path(tmp);audit.save(p/'config.json',{});audit.save(p/'receipt.json',{'kind':'editorial-live-supervisor-handoff','job':str(p),'configSha256':audit.sha(p/'config.json'),'supervisorPid':123,'supervisorIdentity':str(p)+' expected'})
   with patch.object(audit,'process_identity',return_value='different'),patch.object(audit.os,'kill') as kill:
    with self.assertRaisesRegex(AssertionError,'identity changed'):audit.adopt_live(p,{'status':'running','supervisorPid':123},{},p/'receipt.json')
    kill.assert_not_called()

if __name__=='__main__':unittest.main()
