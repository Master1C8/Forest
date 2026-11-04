"""Independent-review continuation regressions; no model/game requests."""
import hashlib
import json
from pathlib import Path
import unittest
from unittest.mock import patch

import locale_cli_lifecycle as base
import locale_review_lifecycle as review
import test_locale_cli_lifecycle as cli_tests


class ReviewLifecycleTests(unittest.TestCase):
    def setUp(self):
        cli_tests.LifecycleTests.setUp(self)
        for ident in ['a', 'b']:
            self.language['translations'][ident]['target'] = 'Authored ' + ident
        base.save(self.root / 'language.json', self.language)
        self.packet = {i: {'id': i, 'source': self.source[i], 'target': self.language['translations'][i]['target'],
                          'sourceSha256': hashlib.sha256(self.source[i].encode()).hexdigest(),
                          'targetSha256': hashlib.sha256(self.language['translations'][i]['target'].encode()).hexdigest()}
                       for i in ['a', 'b']}
        path = self.root / 'packet.jsonl'
        path.write_text(''.join(json.dumps(r) + '\n' for r in self.packet.values()))
        self.lane.update(fullReviewPacket='packet.jsonl', fullReviewPacketSha256=base.digest(path))
        self.supervisor = review.ReviewSupervisor(self.root, self.cfg, self.root / 'review-controller')
        self.summary = base.inspect_language(self.root, self.lane, self.source, self.preserved)

    def row(self, ident, verdict='pass'):
        return {k: v for k, v in self.packet[ident].items() if k.endswith('Sha256') or k == 'id'} | {
            'verdict': verdict, 'rationale': 'Actual exact-version judgment', 'reviewerThreadId': 'own-thread'}

    def test_only_explicit_pinned_supplemental_wording_extends_full_inventory(self):
        extra = {'id': 'art:label', 'source': 'Title', 'target': 'Authored title'}
        for field in ('source', 'target'):
            extra[field + 'Sha256'] = hashlib.sha256(extra[field].encode()).hexdigest()
        path = self.root / 'packet.jsonl'
        with path.open('a') as stream:
            stream.write(json.dumps(extra) + '\n')
        self.lane['fullReviewPacketSha256'] = base.digest(path)
        with self.assertRaisesRegex(ValueError, 'Invalid independent packet inventory'):
            review.ReviewSupervisor(self.root, self.cfg, self.root / 'review-controller')
        supplemental = self.root / 'supplemental.jsonl'
        supplemental.write_text(json.dumps(extra) + '\n')
        self.lane['supplementalReviewPacket'] = {'path': supplemental.name, 'sha256': base.digest(supplemental)}
        supervisor = review.ReviewSupervisor(self.root, self.cfg, self.root / 'review-controller')
        self.assertEqual(set(supervisor.packets['xx']), {'a', 'b', 'art:label'})
        self.assertEqual(supervisor.known['xx'], {})
        supplemental.write_text(json.dumps(extra | {'target': 'Other'}) + '\n')
        with self.assertRaisesRegex(ValueError, 'Supplemental review packet changed'):
            review.ReviewSupervisor(self.root, self.cfg, self.root / 'review-controller')
        self.lane['supplementalReviewPacket']['sha256'] = base.digest(supplemental)
        with self.assertRaisesRegex(ValueError, 'Supplemental review version differs'):
            review.ReviewSupervisor(self.root, self.cfg, self.root / 'review-controller')

    def result_rows(self, rows):
        path = self.phase / 'reviews.jsonl'
        path.write_text(''.join(json.dumps(r) + '\n' for r in rows))
        base.save(self.phase / 'result.json', {'outcome': 'continue', 'reviews': str(path), 'blocker': None})
        return path

    def test_actual_helper_rows_without_reviewed_flag_survive_but_context_stays_pending(self):
        path = self.result_rows([self.row('a'), self.row('b', 'needs-context')])
        self.assertEqual(set(review.checked_rows(path, self.packet, 'own-thread')), {'a'})
        self.result_rows([self.row('a', 'finding'), self.row('b') | {'reviewed': False}])
        self.assertEqual(review.checked_rows(path, self.packet, 'own-thread')['a']['verdict'], 'finding')
        alternate = self.row('a')
        alternate['fidelityRationale'] = alternate.pop('rationale')
        self.result_rows([alternate])
        self.assertEqual(set(review.checked_rows(path, self.packet, 'own-thread')), {'a'})

    def test_stale_or_foreign_reviews_reject_instead_of_default_pass(self):
        path = self.result_rows([self.row('a') | {'targetSha256': 'stale'}])
        with self.assertRaisesRegex(ValueError, 'Stale review version'):
            review.checked_rows(path, self.packet, 'own-thread')
        self.result_rows([self.row('a') | {'reviewerThreadId': 'author'}])
        with self.assertRaisesRegex(ValueError, 'Foreign reviewer row'):
            review.checked_rows(path, self.packet, 'own-thread')
        self.result_rows([self.row('a') | {'model': 'gpt-6-astra'}])
        with self.assertRaisesRegex(ValueError, 'Foreign reviewer model'):
            review.checked_rows(path, self.packet, 'own-thread')

    def test_partial_review_continues_same_task_and_retains_findings(self):
        self.result_rows([self.row('a', 'finding'), self.row('b', 'needs-context')])
        with patch.object(review, 'process_identity', return_value=None), patch.object(self.supervisor, 'launch') as launch:
            self.supervisor.tick(self.lane)
            launch.assert_called_once()
        self.assertEqual(self.lane['judgedRetained'], 1)
        self.assertEqual(self.lane['findingsRetained'], 1)
        self.assertEqual(self.lane['required'], 2)

    def test_next_packet_is_only_unread_and_write_scope_stays_review_only(self):
        self.supervisor.known['xx'] = {'a': self.row('a', 'finding')}
        before = (self.root / 'language.json').read_bytes()
        phase, _ = self.supervisor.prepare_phase(self.lane, {'phase': self.lane['phase'], 'threadId': 'own-thread'}, self.summary)
        rows = [json.loads(l) for l in (phase / 'review-packet.jsonl').read_text().splitlines()]
        self.assertEqual([r['id'] for r in rows], ['b'])
        task = base.read(phase / 'task.json')
        self.assertEqual(task['job']['writePrefixes'], [str(phase.relative_to(self.root))])
        self.assertEqual(task['task']['retainedIndependent']['count'], 1)
        self.assertEqual((self.root / 'language.json').read_bytes(), before)

    def test_all_judged_stops_for_parent_including_findings_not_clean_acceptance(self):
        self.result_rows([self.row('a'), self.row('b', 'finding')])
        with patch.object(review, 'process_identity', return_value=None), patch.object(self.supervisor, 'launch') as launch:
            self.supervisor.tick(self.lane)
            launch.assert_not_called()
        self.assertEqual(self.lane['status'], 'needs-parent-full-review-and-context-validation')
        self.assertEqual(self.lane['findingsRetained'], 1)

    def test_target_change_invalidates_before_continuation(self):
        self.result_rows([self.row('a')])
        self.language['translations']['a']['target'] = 'Owner changed wording'
        base.save(self.root / 'language.json', self.language)
        with patch.object(review, 'process_identity', return_value=None), patch.object(self.supervisor, 'launch') as launch:
            with self.assertRaisesRegex(ValueError, 'Reviewed language changed'):
                self.supervisor.tick(self.lane)
            launch.assert_not_called()

    def test_live_reviewer_is_adopted_without_starting_duplicate(self):
        with patch.object(review, 'process_identity', return_value='same actual reviewer'), patch.object(self.supervisor, 'launch') as launch:
            self.supervisor.tick(self.lane)
            launch.assert_not_called()
        self.assertEqual(self.lane['status'], 'running')

    def test_explicit_retained_pass_supersession_is_not_silently_lost(self):
        retained = {'a': self.row('a')}
        new = {'b': self.row('b')}
        revised = self.row('a', 'finding') | {'rationale': 'Newly read concrete dependent context'}
        supersession = self.phase / 'supersession.jsonl'
        supersession.write_text(json.dumps(revised) + '\n')
        effective = self.phase / 'effective.jsonl'
        effective.write_text(json.dumps(revised) + '\n' + json.dumps(new['b']) + '\n')
        result = {'effectiveFullReviews': str(effective), 'retainedPassSupersession': str(supersession)}
        merged = review.merge_review_result(self.root, self.phase, self.packet, 'own-thread', retained, new, result)
        self.assertEqual(merged['a']['verdict'], 'finding')
        self.assertEqual(retained['a']['verdict'], 'pass')
        effective.write_text(json.dumps(revised) + '\n' + json.dumps(new['b'] | {'verdict': 'finding'}) + '\n')
        with self.assertRaisesRegex(ValueError, 'Unexplained effective review change'):
            review.merge_review_result(self.root, self.phase, self.packet, 'own-thread', retained, new, result)


if __name__ == '__main__':
    unittest.main()
