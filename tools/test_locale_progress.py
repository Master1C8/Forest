"""Regression tests for credit boundaries and actual progress publication."""
import copy
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

from locale_progress import (Evidence, accepted_stages, calculate_score, collect_locale, hashed,
                             linguistic_pass, proof_refs, snapshot, version)


class ProgressTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)

    def write(self, name, value):
        p = self.root / name
        p.parent.mkdir(parents=True, exist_ok=True)
        p.write_text(json.dumps(value))
        return p, hashed(p.read_bytes())

    def test_stale_receipt_is_rejected_with_matching_positive_control(self):
        p, sha = self.write('reviews.json', {'verdict': 'pass'})
        self.assertEqual(Evidence(self.root).json('reviews.json', sha)['verdict'], 'pass')
        p.write_text('{"verdict":"finding"}')
        with self.assertRaisesRegex(ValueError, 'Stale evidence'):
            Evidence(self.root).json('reviews.json', sha)

    def test_changed_target_does_not_match_review_version(self):
        row = dict(id='one', source='English', target='A')
        receipt = dict(id='one', sourceSha256=hashed(b'English'), targetSha256=hashed(b'A'))
        self.assertEqual(version(row), version(receipt))
        row['target'] = 'B'
        self.assertNotEqual(version(row), version(receipt))

    def test_appended_canonical_packet_preserves_only_exact_old_bytes(self):
        p, old_sha = self.write('packet.jsonl', dict(id='old', source='English', target='A'))
        p.write_bytes(p.read_bytes() + b'\n' + json.dumps(dict(id='new', source='Other', target='B')).encode())
        # The old packet lacked its final newline: appending changes its logical
        # line, so the original whole-byte stream must not be guessed/recreated.
        with self.assertRaisesRegex(ValueError, 'Stale evidence'):
            Evidence(self.root).row_list('packet.jsonl', old_sha)
        old = json.dumps(dict(id='old', source='English', target='A')).encode() + b'\n'
        p.write_bytes(old + json.dumps(dict(id='new', source='Other', target='B')).encode() + b'\n')
        ev = Evidence(self.root)
        rows = ev.row_list('packet.jsonl', hashed(old))
        self.assertEqual([r['id'] for r in rows], ['old'])
        self.assertEqual(ev.recovered_prefixes[0]['originalBytes'], len(old))
        p.write_bytes(old.replace(b'"A"', b'"changed"') + b'\n')
        with self.assertRaisesRegex(ValueError, 'Stale evidence'):
            Evidence(self.root).row_list('packet.jsonl', hashed(old))

    def test_mislabelled_wording_hash_rejected(self):
        with self.assertRaisesRegex(ValueError, 'Incorrect wording hash'):
            version(dict(id='one', source='English', target='A', targetSha256=hashed(b'B')))

    def test_context_and_technical_rows_never_become_linguistic_passes(self):
        self.assertTrue(linguistic_pass(dict(verdict='pass')))
        for extra in [dict(notLinguisticCoverage=True), dict(reviewed=False),
                      dict(coverageRole='context-only'), dict(reviewRole='held-source')]:
            self.assertFalse(linguistic_pass(dict(verdict='pass', **extra)))
        self.assertFalse(linguistic_pass(dict(verdict='technical-preservation')))

    def test_relative_manifest_proof_is_verified_at_owning_directory(self):
        _, sha = self.write('receipts/reviews.json', {'rows': []})
        _, manifest_sha = self.write('receipts/manifest.json', {'evidence': {'path': 'reviews.json', 'sha256': sha}})
        refs = proof_refs(Evidence(self.root), {'path': 'receipts/manifest.json', 'sha256': manifest_sha})
        self.assertEqual(refs['receipts/reviews.json'], sha)

    def test_scope_cannot_escape_project(self):
        with self.assertRaisesRegex(ValueError, 'Outside project evidence'):
            Evidence(self.root).read('../elsewhere')

    def test_snapshot_detects_input_change_before_publication(self):
        p, sha = self.write('input.json', {'a': 1})
        ev = Evidence(self.root)
        ev.read('input.json', sha)
        p.write_text('{"a":2}')
        with self.assertRaisesRegex(ValueError, 'Input changed before report publication'):
            ev.stable()

    def test_unknown_denominator_is_reserved_and_never_renormalized(self):
        policy = dict(components=[dict(id='draft', stage='translate-edit', points=60,
                                      families=['known', 'unknown'], numerator='drafted'),
                                  dict(id='runtime', stage='runtime', points=40)], requiredGates=['runtime'])
        rows = [dict(id='known', expected=10, drafted=10), dict(id='unknown', expected=None, drafted=0)]
        score = calculate_score(policy, rows)
        self.assertEqual(score['percent'], 30)
        self.assertEqual(score['unverifiedPoints'], 30)
        self.assertFalse(score['ready'])

    def test_real_collector_deduplicates_receipts_and_invalidates_changed_target(self):
        # These fixtures replace human/model judgments. This tests their transport
        # and current-version binding, not the semantic correctness of a judgment.
        row = dict(id='one', source='English', target='A', status='edited-provisional')
        self.write('localization/source/dialogue-candidates.jsonl', {'id': 'one', 'source': 'English'})
        corpus, _ = self.write('localization/ja-assets/dialogue.ja.jsonl', row)
        self.write('localization/supplemental-ui/20261027/ja.jsonl', dict(id='ui', source='Menu', target='M'))
        self.write('localization/supplemental-ui/20261027/source-catalog.json', {'units': [dict(id='ui', source='Menu')]})
        self.write('outputs/editorial-20261027/ja/job.json', {'phases': []})
        self.write('outputs/locale-assets-20261026/ja/workflow-v2/reconcile-saved-evidence/result.json', {})
        base = 'outputs/locale-assets-20261026/ja/workflow-v3-completion-20261030/0001-review'
        packet, packet_sha = self.write(base + '/packet.jsonl', row)
        receipt = dict(id='one', sourceSha256=hashed(b'English'), targetSha256=hashed(b'A'), verdict='pass')
        reviews = self.root / base / 'reviews.jsonl'
        reviews.write_text('\n'.join(json.dumps(receipt) for _ in range(50)) + '\n')
        self.write(base + '/task.json', {'task': {'kind': 'review', 'reviewPacket': str(packet), 'reviewPacketSha256': packet_sha}})
        result, result_sha = self.write(base + '/result.json', dict(outcome='blocked', nextTask=None, progress=None,
                    reviews=str(reviews.relative_to(self.root)),
                    evidence=[dict(path=str(reviews.relative_to(self.root)), sha256=hashed(reviews.read_bytes()))]))
        status, _ = self.write('outputs/locale-assets-20261026/ja/workflow-v3-completion-20261030/status.json',
                    dict(status='blocked', phases=[dict(number=1, kind='review', phase=str(result.parent), resultSha256=result_sha)]))
        policy = dict(families=[dict(id='dialogue')])
        families = dict(dialogue={'one'})
        first = collect_locale(Evidence(self.root), policy, 'ja', families)
        self.assertEqual(first['families'][0]['reviewed'], 1)
        row['target'] = 'B'
        corpus.write_text(json.dumps(row))
        changed = collect_locale(Evidence(self.root), policy, 'ja', families)
        self.assertEqual(changed['families'][0]['drafted'], 1)
        self.assertEqual(changed['families'][0]['reviewed'], 0)

    def test_100_requires_every_gate_and_full_coverage(self):
        policy = dict(components=[dict(id='draft', stage='translate-edit', points=60,
                                      families=['one'], numerator='drafted'),
                                  dict(id='runtime', stage='runtime', points=40)], requiredGates=['runtime'])
        rows = [dict(id='one', expected=10, drafted=10)]
        self.assertEqual(calculate_score(policy, rows)['percent'], 60)
        self.assertTrue(calculate_score(policy, rows, {'runtime'})['ready'])
        bad = copy.deepcopy(policy)
        bad['requiredGates'].append('editorial')
        with self.assertRaisesRegex(ValueError, '100 points without all acceptance gates'):
            calculate_score(bad, rows, {'runtime'})

    def test_synthetic_runtime_receipt_is_rejected_and_native_control_passes(self):
        _, sha = self.write('actual-evidence.json', {'completed': True})
        row = dict(locale='ja', families=[])
        binding = dict(locale='ja', policyRevision='v1', sourceScopeSha256='scope',
                       wordingVersionSha256=hashed(b'[]'), stages={'runtime': dict(status='passed',
                       proofKind='synthetic-renderer', evidence=[dict(path='actual-evidence.json', sha256=sha)])})
        path, _ = self.write('localization/completion/acceptance/ja.json', binding)
        policy = dict(revision='v1', proofKinds={'runtime': 'native-gameplay-and-save-acceptance'})
        gate = dict(commonSourceAccepted=False, translationEntryAllowed=False)
        ev = Evidence(self.root)
        self.assertNotIn('runtime', accepted_stages(ev, policy, row, 'scope', gate))
        self.assertIn('unsuitable proof kind', ev.errors[0])
        binding['stages']['runtime']['proofKind'] = policy['proofKinds']['runtime']
        path.write_text(json.dumps(binding))
        self.assertIn('runtime', accepted_stages(Evidence(self.root), policy, row, 'scope', gate))
        binding['wordingVersionSha256'] = 'old-version'
        path.write_text(json.dumps(binding))
        self.assertNotIn('runtime', accepted_stages(Evidence(self.root), policy, row, 'scope', gate))

    def report(self, when='2026-10-30T00:00:00+00:00', percent=40):
        return dict(measuredAt=when, revision='v1', sourceScopeSha256='scope', calculatorSha256='code',
                    locales=[dict(locale='ja', percent=percent)])

    def test_history_compares_only_same_scope_and_calculation(self):
        snapshot(self.report(), self.root)
        next_report = self.report('2026-10-30T00:01:00+00:00', 42)
        snapshot(next_report, self.root)
        self.assertEqual(next_report['locales'][0]['sincePrevious']['pointDelta'], 2)
        changed = self.report('2026-10-30T00:02:00+00:00', 50)
        changed['sourceScopeSha256'] = 'new-scope'
        snapshot(changed, self.root)
        self.assertIsNone(changed['locales'][0]['sincePrevious']['pointDelta'])

    def test_failure_between_snapshot_and_pointer_preserves_old_current(self):
        snapshot(self.report(), self.root)
        pointer = self.root / 'outputs/locale-assets-20261026/progress/current.json'
        old = pointer.read_bytes()
        with patch('locale_progress.os.replace', side_effect=OSError('injected publication failure')):
            with self.assertRaisesRegex(OSError, 'injected publication failure'):
                snapshot(self.report('2026-10-30T00:01:00+00:00'), self.root)
        self.assertEqual(pointer.read_bytes(), old)
        self.assertEqual(len(list(pointer.parent.glob('2026*.json'))), 2)
        self.assertFalse(list(pointer.parent.glob('*.tmp')))


if __name__ == '__main__':
    unittest.main()
