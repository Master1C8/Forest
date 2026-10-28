"""Bounded static regressions. No game/process/model launched; no acceptance forged."""
import copy
import dataclasses
import importlib.util
import json
from pathlib import Path
import sys
import unittest

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
CHECK = ROOT / 'outputs/chapter-gallery-probe-20261029/check'
sys.path.insert(0, str(ROOT / 'tools'))
spec = importlib.util.spec_from_file_location('chapter_capture', ROOT / 'tools/probe/capture_chapter_gallery_ui.py')
capture = importlib.util.module_from_spec(spec); spec.loader.exec_module(capture)
a = capture.adapter()


class StaticChecks(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.draft = a.prepare_static_preflight(a.jsonl((a.PACKET / 'ru.case-preparation.full.jsonl').read_bytes()), locale='ru')
        cls.work = capture.make_plan(cls.draft, static_preflight=True)

    def test_finite_draft_plan_is_labelled_and_complete(self):
        w = self.work
        self.assertEqual(w['mode'], 'draft-static-preflight-only')
        self.assertEqual(w['counts'], dict(gallery=3367, oos=28, description=28))
        self.assertEqual(len(w['values']), 129)
        self.assertEqual(sum(r[-1] == '~' for r in w['values']), 16)
        self.assertEqual({k: sum(r['surface'] == k for r in w['native']) for k in ['gallery','oos','unknown-adventure']}, dict(gallery=6, oos=6, **{'unknown-adventure':6}))
        self.assertEqual(len(w['selection']), 59)
        fallback = [c for c in w['cases'] if c['branch'] in ('missing','null','empty','whitespace')]
        self.assertEqual(len(fallback), 4)
        self.assertTrue(all(c['expected'] == w['words']['fallback'] for c in fallback))
        for c in w['cases']:
            if c['surface'] == 'gallery' and c['branch'] in ('movie','story'):
                self.assertEqual(c['expected'], w['words'][c['kind']].format(c['ordinal']+1)+'\n\n'+c['argument'])
            elif c['surface'] == 'oos':
                self.assertEqual(c['expected'], "''"+c['argument']+"''")
        self.assertFalse(w['ordinaryTranslationEntryAllowed'])
        self.assertFalse(w['globalPretranslationPassed'])
        self.assertFalse(w['wholeGameAccepted'])

    def test_wrong_locale_rejects_before_any_destination_write(self):
        destination = CHECK / 'wrong-locale-must-not-exist'
        self.assertFalse(destination.exists())
        with self.assertRaisesRegex(a.AdapterError, '^explicit-supported-locale-required$'):
            capture.prepare(CHECK / 'nonexistent-candidate', destination, locale='ja')
        self.assertFalse(destination.exists())

    def test_draft_cannot_enter_runtime_plan(self):
        with self.assertRaisesRegex(a.AdapterError, '^draft-not-accepted-for-build$'):
            capture.make_plan(self.draft)

    def test_missing_acceptance_rejects_before_candidate_or_destination(self):
        # Temporarily redirect ONLY this process's packet lookup. No canonical
        # acceptance file is renamed/edited and no accepted receipt is fabricated.
        original = a.PACKET
        missing = CHECK / 'empty-unaccepted-inputs'; missing.mkdir(exist_ok=True)
        destination = CHECK / 'unaccepted-must-not-exist'
        try:
            a.PACKET = missing
            with self.assertRaisesRegex(a.AdapterError, '^bounded-editorial-acceptance-required$'):
                capture.prepare(CHECK / 'nonexistent-candidate', destination, locale='ru')
        finally:
            a.PACKET = original
        self.assertFalse(destination.exists())

    def test_stale_plan_source_rejected(self):
        packet = json.loads(self.draft.packet_bytes)
        packet['source.jsonl'] = (bytes.fromhex(packet['source.jsonl']) + b'\n').hex()
        stale = dataclasses.replace(self.draft, packet_bytes=a.json_bytes(packet))
        with self.assertRaisesRegex(a.AdapterError, '^input-plan-source-pins$'):
            capture.make_plan(stale, static_preflight=True)

    def test_candidate_version_predicate_with_matching_control(self):
        # Isolated binding test only; marker is not editorial/candidate acceptance.
        candidate = capture.BASELINE; build = capture.read(candidate / 'build.json')
        proof = dict(buildSha256=capture.sha(candidate / 'build.json'), targetSha256='static-binding-marker',
                     sourcePins=a.SOURCE_PINS, baselineBuildSha256=capture.sha(candidate / 'build.json'),
                     files={r['path']:r['probeSha256'] for r in build['files']})
        capture.candidate_version_binding(proof, candidate, build, 'static-binding-marker', a.SOURCE_PINS)
        for key in ('buildSha256','targetSha256'):
            stale = copy.deepcopy(proof); stale[key] = 'stale'
            with self.assertRaisesRegex(ValueError, '^candidate-version-binding$'):
                capture.candidate_version_binding(stale, candidate, build, 'static-binding-marker', a.SOURCE_PINS)
        stale = copy.deepcopy(proof); stale['files']['resources.assets'] = 'stale'
        with self.assertRaisesRegex(ValueError, '^complete-candidate-file-binding$'):
            capture.candidate_version_binding(stale, candidate, build, 'static-binding-marker', a.SOURCE_PINS)

    def test_real_acceptance_positive_gate_when_available(self):
        if not (a.PACKET / 'ru.acceptance.json').exists():
            self.skipTest('Genuine acceptance absent; no accepted positive path fabricated')
        plan = a.load_inputs(locale='ru'); work = capture.make_plan(plan)
        self.assertEqual(work['mode'], 'editorial-accepted')
        self.assertEqual(work['targetSha256'], json.loads(plan.acceptance_bytes)['targetSha256'])
        self.assertEqual(work['counts'], self.work['counts'])

    def test_late_ack_reconciliation_without_resubmission(self):
        # Real receipt/log parsing, with ONLY live-process observation replaced.
        # This proves transport accounting, not Unity execution or PID ownership.
        from unittest.mock import patch
        run = CHECK / 'transport-fixture-01'; run.mkdir(exist_ok=True)
        log = run / 'actions.log'; log.write_text('older OK cg-measure 1\n')
        offset = log.stat().st_size
        receipt = run / 'request.json'
        capture.write(receipt, dict(status='outcome-unknown', action='cg-measure 1', offset=offset))
        log.write_text(log.read_text() + 'late OK cg-measure 10\npartial OK cg-measure 1')
        with patch.object(capture, 'owned', return_value=['fixture-observation-only']), patch.object(capture.subprocess, 'run', side_effect=AssertionError('No command may be resubmitted')):
            with self.assertRaisesRegex(RuntimeError, '^Command outcome unknown'):
                capture.reconcile(run, receipt, timeout=0)
            with log.open('a') as stream:
                stream.write('\n')
            result = capture.reconcile(run, receipt, timeout=0)
        self.assertEqual(result['status'], 'acknowledged')
        self.assertEqual(result['logReceipt'], 'partial OK cg-measure 1')

    def test_representatives_require_complete_measured_workload(self):
        cases = [dict(index=i,branch='movie',expected='x'*(i+1)) for i in range(3)]
        measurements = [dict(index=i, fields=[dict(preferredHeight=i+1,preferredWidth=3-i,minGlyphPointSize=14-i,issues=[])]) for i in range(3)]
        self.assertEqual(capture.representatives(cases, measurements), [0,2])
        with self.assertRaisesRegex(ValueError, '^complete-measured-workload-required$'):
            capture.representatives(cases, measurements[:-1])


if __name__ == '__main__':
    suite=unittest.defaultTestLoader.loadTestsFromTestCase(StaticChecks)
    result=unittest.TextTestRunner(verbosity=2).run(suite)
    (CHECK/'static-checks.json').write_text(json.dumps(dict(status='passed-static-only' if result.wasSuccessful() else 'failed', testsRun=result.testsRun, failures=len(result.failures),errors=len(result.errors),skipped=[reason for _,reason in result.skipped],boundary='Pure preparation/guard/selection checks only; real acceptance gate if available. No candidate completeness, Unity consumer, rendering, process transport or visual pass.'),indent=2)+'\n')
    sys.exit(not result.wasSuccessful())
