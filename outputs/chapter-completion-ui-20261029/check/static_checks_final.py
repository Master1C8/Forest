"""Finite static checks. Mocks replace only named runtime boundaries, never coverage."""
from pathlib import Path
import copy,json,sys,unittest,types,shutil,ast
from unittest.mock import patch
CHECK=Path(__file__).resolve().parent;ROOT=CHECK.parents[2];BUNDLE=CHECK/'frozen-final-v2'
sys.path.insert(0,str(BUNDLE))
import capture_chapter_completion_ui as cc
import prepare_chapter_completion_qa as prep

class Checks(unittest.TestCase):
 @classmethod
 def setUpClass(cls):
  cls.plan,cls.work,cls.build=prep.source_bundle()
  cls.a=sys.modules['russian_chapter_gallery_case']
  cls.original=cc.legacy().make_plan(cls.plan)
 def test_real_candidate02_and_complete_finite_workload(self):
  self.assertEqual(cc.sha(cc.CANDIDATE/'build.json'),cc.BUILD_SHA)
  self.assertEqual(self.work['counts'],dict(oos=28,description=28));self.assertEqual(len(self.work['cases']),56)
  self.assertEqual(len({c['sourceId'] for c in self.work['cases']}),56)
  self.assertEqual(len(self.work['values']),129);self.assertEqual(sum(v[-1]=='~' for v in self.work['values']),16)
  self.assertEqual(self.work['selection'],[]);self.assertNotIn('gallery',self.work['counts'])
  self.assertFalse(self.work['wholeGameAccepted'])
 def test_explicit_locale_guard_before_candidate_access(self):
  with self.assertRaisesRegex(ValueError,'^explicit-supported-locale-required$'):cc.candidate_validation(CHECK/'absent',locale='ja')
 def test_wrong_candidate_pin_with_real_positive_control(self):
  self.assertEqual(self.work['counts']['oos'],28)
  with self.assertRaisesRegex(ValueError,'^exact-full-candidate02-build-required$'):cc.candidate_validation(CHECK/'absent',locale='ru')
 def test_original_unmodified_admission_still_rejects_full02(self):
  # Full02 lacks the incremental03 readback file. New adapter reuses the03
  # proof ONLY after exact four-file equality and full02 pins; never bypasses it.
  with self.assertRaises(FileNotFoundError):cc.legacy().validate_candidate(cc.CANDIDATE,locale='ru')
 def test_draft_and_missing_case_do_not_become_runtime_ready(self):
  draft=dict(self.original,mode='draft-static-preflight-only')
  with self.assertRaisesRegex(ValueError,'^accepted-runtime-workload-required$'):cc.finite_plan(draft)
  missing=copy.deepcopy(self.original);missing['cases']=[c for c in missing['cases'] if c['index']!=self.work['cases'][0]['original3423Index']]
  with self.assertRaisesRegex(ValueError,'^exact56-workload$'):cc.finite_plan(missing)
 def test_exact_apostrophe_wrapper_boundary(self):
  wrong=copy.deepcopy(self.original);c=next(c for c in wrong['cases'] if c['surface']=='oos');c['expected']='"'+c['argument']+'"'
  with self.assertRaisesRegex(ValueError,'^exact-original-wrapper-or-tooltip$'):cc.finite_plan(wrong)
 def test_missing_editorial_acceptance_after_valid_source(self):
  empty=CHECK/'empty-acceptance';empty.mkdir(exist_ok=True)
  # Same validated original source/dependencies, only acceptance directory differs.
  with patch.object(self.a,'_snapshot_pins',return_value=None),patch.object(self.a,'PACKET',empty):
   with self.assertRaisesRegex(self.a.AdapterError,'^bounded-editorial-acceptance-required$'):self.a.load_inputs(locale='ru')
 def test_absolute_run_guard_and_wrong_identity(self):
  run=ROOT/'localization/probes/ru-chapter-completion-20261029-01'
  self.assertEqual(cc.checked_run(run),run)
  with self.assertRaisesRegex(ValueError,'^explicit-absolute-run-required$'):cc.checked_run('localization/probes/ru-chapter-completion-20261029-01')
  with self.assertRaisesRegex(ValueError,'^unique-completion-run-required$'):cc.checked_run(ROOT/'localization/probes/ru-chapter-gallery-20261029-01')
 def test_preparation_wrong_locale_writes_nothing(self):
  dest=ROOT/'localization/probes/ru-chapter-completion-20991231-99';self.assertFalse(dest.exists())
  with self.assertRaisesRegex(ValueError,'^explicit-supported-locale-required$'):prep.stage(CHECK/'absent',dest,CHECK/'absent','de')
  self.assertFalse(dest.exists())
 def test_original_source_selectors_and_role_counts(self):
  rows=cc.read(BUNDLE/'native-text-selectors.json');self.assertEqual(len(rows),12)
  for starts in ('LevelSingletons','OutOfSyncContentNotification'):
   group=[r for r in rows if r['path'].startswith(starts)]
   self.assertEqual(sum(r['alpha']==0 for r in group),1);self.assertEqual(sum(r['alpha']==1 for r in group),5)
  ctl=cc.read(BUNDLE/'native-controllers.json');d=next(r['tree'] for r in ctl if r['class']=='ChapterSelectUI')
  self.assertEqual(d['tooltipContainer'],dict(m_FileID=0,m_PathID=2084))
  self.assertNotIn(2510,[r['go'] for r in rows]);self.assertNotIn(13363,[r['go'] for r in rows])
 def test_alpha0_height_provider_and_visible_face_mask_control(self):
  # Scalar-only geometry classification; no claim that Unity generated it.
  f=dict(text='text',generatedText='text',authoredAlpha=0,effectiveAlpha=0,active=True,enabled=True,missingGlyphs=0,outsideRect=12,outsideMasks=0,outsideViewport=0,visibleCharacters=4,overflow=False,preferredHeight=24.5,height=23)
  provider=cc.metric_issues(f,'text');self.assertEqual(provider['issues'],[]);self.assertEqual(provider['role'],'height-provider')
  visible=cc.metric_issues(dict(f,authoredAlpha=1,effectiveAlpha=1,outsideRect=0),'text');self.assertEqual(visible['issues'],[]);self.assertEqual(visible['warnings'],['preferred-height-exceeds-rect'])
  clipped=cc.metric_issues(dict(f,authoredAlpha=1,effectiveAlpha=1,outsideRect=0,outsideMasks=1),'text');self.assertEqual(clipped['issues'],['outsideMasks'])
  hidden=cc.metric_issues(dict(f,authoredAlpha=1,effectiveAlpha=0,outsideRect=0),'text');self.assertIn('ancestor-fade',hidden['issues'])
 def test_representatives_require_all28_and_include_extrema(self):
  cases=[dict(index=i,branch='description',expected='x'*(i+1)) for i in range(28)]
  rows=[dict(index=i,fields=[dict(preferredHeight=i,preferredWidth=28-i,minGlyphPointSize=30-i,issues=[])]) for i in range(28)]
  self.assertEqual(cc.representatives(cases,rows),[0,27])
  with self.assertRaisesRegex(ValueError,'^complete28-measurements-required$'):cc.representatives(cases,rows[:-1])
 def test_exact_process_prefix_rejects_wrapper_lookalikes(self):
  p=cc.process();run=ROOT/'localization/probes/ru-chapter-completion-20261029-01'
  for v in p.variants(run):
   self.assertTrue(p.actual_command(v,run));self.assertTrue(p.actual_command('"'+v+'" -arg',run))
   self.assertFalse(p.actual_command('python3 wrapper.py '+v,run));self.assertFalse(p.actual_command(v+'.other',run))
 def test_partial_and_late_ack_are_reconciled_without_resubmit(self):
  run=CHECK/'transport-test-final';run.mkdir(exist_ok=True);(run/'cc-command-receipts').mkdir(exist_ok=True)
  cc.write(run/'task-process.json',dict(pid=123,executable='test-fixture-only'))
  log=run/'actions.log';log.write_text('old OK cc-measure 1\n');receipt=run/'cc-command-receipts/000000.json'
  cc.write(receipt,dict(status='outcome-unknown',action='cc-measure 1',offset=log.stat().st_size,process=cc.read(run/'task-process.json')))
  with log.open('a') as s:s.write('other OK cc-measure 10\npartial OK cc-measure 1')
  # Replace only process observation. Exercise actual exact receipt/tail parser.
  with patch.object(cc,'process',return_value=types.SimpleNamespace(owned=lambda *a,**k:[])),patch.object(cc.subprocess,'run',side_effect=AssertionError('no resubmission')):
   with self.assertRaisesRegex(RuntimeError,'^Command outcome unknown'):cc.reconcile(run,receipt,timeout=0)
   with log.open('a') as s:s.write('\n')
   self.assertEqual(cc.reconcile(run,receipt,timeout=0)['status'],'acknowledged')
 def make_cleanup_fixture(self,name):
  run=CHECK/(name+'-final');run.mkdir();data=run/'game'/cc.DATA;managed=data/'Managed';managed.mkdir(parents=True);inputs=run/'fixture-inputs';inputs.mkdir()
  original=run/'Assembly-CSharp.localized-original.dll';original.write_bytes(b'localized-original');(managed/'Assembly-CSharp.dll').write_bytes(b'hooked');(managed/'ForestProbe.dll').write_bytes(b'owned-bridge')
  for n,v in [('tfol.savegame',b'fixture-save'),('tfol.settings',b'fixture-settings')]:
   (inputs/n).write_bytes(v);(data/n).write_bytes(v)
  (data/'tfol.savegame').write_bytes(b'changed-save-test');(data/'tfol.extra').write_bytes(b'sidecar-test')
  return run,dict(parentBuild='mocked-outside-this-test',fixtureDirectory=str(inputs),fixtureBefore={n:cc.sha(inputs/n) for n in ['tfol.savegame','tfol.settings']},originalAssemblySha256=cc.sha(original),bridgeSha256=cc.sha(managed/'ForestProbe.dll'))
 def test_incomplete_cleanup_preserves_changed_save_then_restores_exact_inputs(self):
  run,prep=self.make_cleanup_fixture('cleanup-test')
  fake=types.SimpleNamespace(observations=lambda r:[],no_game_process=lambda r:None)
  # Process ownership and parent checks are replaced. Exercise file preservation,
  # owned DLL restoration, sidecars and exact fixture restoration on verifier error.
  with patch.object(cc,'frozen_run',return_value=prep),patch.object(cc,'process',return_value=fake),patch.object(cc,'parent_unchanged'):
   cc.complete(run,cleanup_only=True)
  data=run/'game'/cc.DATA
  self.assertEqual((run/'cc-post-runtime'/cc.DATA/'tfol.savegame').read_bytes(),b'changed-save-test')
  self.assertEqual((run/'cc-post-runtime'/cc.DATA/'tfol.extra').read_bytes(),b'sidecar-test')
  self.assertEqual((data/'tfol.savegame').read_bytes(),b'fixture-save');self.assertFalse((data/'tfol.extra').exists())
  self.assertEqual((data/'Managed/Assembly-CSharp.dll').read_bytes(),b'localized-original');self.assertFalse((data/'Managed/ForestProbe.dll').exists())
  self.assertFalse((run/'cc-completion.json').exists());self.assertTrue((run/'cc-cleanup-complete.json').exists())
 def test_failure_between_cleanup_writes_has_no_completion_receipt(self):
  run,prep=self.make_cleanup_fixture('cleanup-interruption-test');real=cc.write
  def fail(path,*a,**k):
   if Path(path).name=='cleanup.json':raise OSError('injected-between-writes')
   return real(path,*a,**k)
  fake=types.SimpleNamespace(observations=lambda r:[],no_game_process=lambda r:None)
  with patch.object(cc,'frozen_run',return_value=prep),patch.object(cc,'process',return_value=fake),patch.object(cc,'parent_unchanged'),patch.object(cc,'write',side_effect=fail):
   with self.assertRaisesRegex(OSError,'^injected-between-writes$'):cc.complete(run,cleanup_only=True)
  self.assertTrue((run/'cc-post-runtime'/cc.DATA/'tfol.savegame').exists());self.assertFalse((run/'cc-completion.json').exists())
  self.assertEqual((run/'game'/cc.DATA/'Managed/Assembly-CSharp.dll').read_bytes(),b'localized-original')
 def test_new_and_existing_mode_compilation(self):
  for path in [CHECK/'compile-05/compile.json',CHECK/'legacy-compile-root/compiled/compile.json']:
   d=cc.read(path);self.assertEqual(d['status'],'compiled-static-only');self.assertEqual(d['exitCode'],0);self.assertEqual(d['runtime'],'not-run')
 def test_compiled_lock_fixture_preserves_service_lifecycle(self):
  body=(CHECK/'inspection/compiled-CCReady.il').read_text()
  self.assertIn('LockInteractions',body)
  self.assertNotIn('UnityEngine.Behaviour::set_enabled',body)
  self.assertEqual(cc.sha(BUNDLE/'ChapterCompletionUiProbe.cs'),cc.sha(CHECK/'compile-05/ChapterCompletionUiProbe.cs'))
  self.assertEqual(cc.sha(BUNDLE/'ForestProbe.cs'),cc.sha(CHECK/'legacy-compile-root/tools/probe/ForestProbe.cs'))
 def test_execution_and_launch_preparation_pins(self):
  run=CHECK/'execution-pin-test';run.mkdir();helper=run/'helper.py';helper.write_bytes(b'original')
  cc.write(run/'cc-execution-pins.json',{'helper.py':cc.sha(helper)},True)
  cc.write(run/'cc-preparation.json',dict(executionPinsSha256=cc.sha(run/'cc-execution-pins.json')),True)
  cc.pin_check(run)
  helper.write_bytes(b'changed')
  with self.assertRaisesRegex(ValueError,'^execution-pin:helper.py$'):cc.pin_check(run)
  helper.write_bytes(b'original')
  cc.write(run/'launch-intent.json',dict(preparedSha256=cc.sha(run/'cc-preparation.json')),True)
  cc.pin_check(run)
  value=cc.read(run/'cc-preparation.json');value['changed']=True;cc.write(run/'cc-preparation.json',value)
  with self.assertRaisesRegex(ValueError,'^launched-preparation-version$'):cc.pin_check(run)
 def test_python_parses_without_cache_or_execution(self):
  for p in BUNDLE.glob('*.py'):ast.parse(p.read_text(),filename=str(p))

if __name__=='__main__':
 result=unittest.TextTestRunner(verbosity=2).run(unittest.defaultTestLoader.loadTestsFromTestCase(Checks))
 cc.write(CHECK/'static-checks-final.json',dict(status='passed-static-only' if result.wasSuccessful() else 'failed',testsRun=result.testsRun,failures=len(result.failures),errors=len(result.errors),runtime='not-run',boundary='Genuine accepted inputs/artifact hashes and private bridge compiles; pure guards/geometry/receipt parsing and file restoration. Mocked process/parent boundaries in cleanup tests do not establish those real runtime mechanisms.'),True)
 sys.exit(not result.wasSuccessful())
