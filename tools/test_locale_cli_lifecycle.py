"""Lifecycle regressions. Model/CLI launch is mocked; no paid requests or game runs."""
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

import locale_cli_lifecycle as life


USAGE = {'input_tokens': 10, 'cached_input_tokens': 8, 'output_tokens': 2, 'total_tokens': 12}
CAPACITY = {'type': 'turn.failed', 'error': {'message': 'Selected model is at capacity. Please try a different model.'}}


class LifecycleTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.phase = self.root / 'outputs/test/xx/author-01'
        self.phase.mkdir(parents=True)
        self.source = {'a': 'Alpha', 'b': 'Beta', 'control': 'ID_KEY'}
        self.preserved = {'control': __import__('hashlib').sha256(b'ID_KEY').hexdigest()}
        (self.root / 'source.jsonl').write_text(''.join(json.dumps({'id': k, 'source': v}) + '\n' for k, v in self.source.items()))
        life.save(self.root / 'preservation.json', {'baselinePreserved': self.preserved})
        self.language = {'locale': 'xx', 'translations': {k: {'source': v, 'target': v if k == 'control' else None} for k, v in self.source.items()}}
        life.save(self.root / 'language.json', self.language)
        self.runtime = {'threadId': 'own-thread', 'pid': 100000,
                        'sessionMetadataPath': str(self.root / 'session.jsonl'),
                        'actualRuntime': {'session': {'id': 'own-thread', 'model_provider': 'openai', 'parent_thread_id': None},
                                          'turn': {'model': 'gpt-6.1-sol', 'effort': 'high'}}}
        life.save(self.phase / 'runtime-verification.json', self.runtime)
        (self.phase / 'events.jsonl').write_text(json.dumps({'type': 'turn.completed', 'usage': USAGE}) + '\n')
        life.save(self.phase / 'process-exit.json', {'exitCode': 0, 'usage': USAGE})
        life.save(self.phase / 'result.json', {'status': 'incomplete', 'blocker': None})
        self.lane = {'locale': 'xx', 'language': 'language.json', 'phase': str(self.phase.relative_to(self.root)),
                     'assignmentTask': 'owner-task.json', 'progressRoots': ['outputs/test/xx'],
                     'status': 'adopted-running', 'wordingVersions': []}
        life.save(self.root / 'owner-task.json', {'job': {'immutablePins': {}}, 'task': {'sourcePacket': 'source.jsonl'}})
        self.cfg = {'model': 'gpt-6.1-sol', 'reasoning': 'high', 'provider': 'openai', 'streamCap': 6,
                    'sourcePacket': 'source.jsonl', 'preservation': 'preservation.json', 'lanes': [self.lane],
                    'phaseRoot': 'outputs/test', 'editorialRoot': 'editorial', 'caseRoot': 'cases',
                    'cli': '/verified/codex', 'capacityBackoffSeconds': 60, 'maxCapacityRetries': 2,
                    'maxNoProgressTurns': 2}
        self.supervisor = life.Supervisor(self.root, self.cfg, self.root / 'controller')
        self.summary = life.inspect_language(self.root, self.lane, self.source, self.preserved)

    def test_zero_exit_incomplete_is_continuation_not_finished(self):
        self.assertEqual(life.classify({'exitCode': 0}, {'status': 'incomplete', 'blocker': None}, USAGE, [], self.summary),
                         'continue-own-authoring')
        with patch.object(life, 'process_identity', return_value=None), patch.object(self.supervisor, 'launch') as launch:
            self.supervisor.tick(self.lane)
            launch.assert_called_once()

    def test_invalid_ready_claim_and_valid_parent_handoff(self):
        result = {'status': 'review-ready', 'language': {'sha256': self.summary['sha256']}}
        self.assertEqual(life.classify({'exitCode': 0}, result, USAGE, [], self.summary), 'needs-attention-invalid-ready-claim')
        full = dict(self.summary, remaining=0)
        self.assertEqual(life.classify({'exitCode': 0}, result, USAGE, [], full), 'needs-parent-independent-review-verification')
        result['language']['sha256'] = 'stale'
        self.assertEqual(life.classify({'exitCode': 0}, result, USAGE, [], full), 'needs-attention-invalid-ready-claim')

    def test_existing_canonical_language_alias_requires_exact_unambiguous_binding(self):
        full = dict(self.summary, remaining=0)
        result = {'status': 'review-ready', 'canonicalLanguage': {'path': 'language.json', 'sha256': full['sha256']}}
        self.assertEqual(life.classify({'exitCode': 0}, result, USAGE, [], full), 'needs-parent-independent-review-verification')
        result['language'] = {'sha256': 'contradictory'}
        self.assertEqual(life.classify({'exitCode': 0}, result, USAGE, [], full), 'needs-attention-invalid-ready-claim')
        result['language']['sha256'] = full['sha256']
        self.assertEqual(life.classify({'exitCode': 0}, result, USAGE, [], full), 'needs-parent-independent-review-verification')
        result['canonicalLanguage']['sha256'] = 'stale-alias'
        self.assertEqual(life.classify({'exitCode': 0}, result, USAGE, [], full), 'needs-attention-invalid-ready-claim')

    def test_ready_handoff_ignores_obsolete_malformed_scratch_but_validates_final_source(self):
        for ident in ['a', 'b']:
            self.language['translations'][ident]['target'] = 'Authored ' + ident
        life.save(self.root / 'language.json', self.language)
        summary = life.inspect_language(self.root, self.lane, self.source, self.preserved)
        life.save(self.phase / 'result.json', {'status': 'review-ready', 'language': {'sha256': summary['sha256']}})
        (self.phase / 'obsolete-draft.json').write_text('{ incomplete scratch')
        with patch.object(life, 'process_identity', return_value=None), patch.object(life, 'wording_versions', side_effect=AssertionError('Must not parse obsolete drafts')):
            self.supervisor.tick(self.lane)
        self.assertEqual(self.lane['status'], 'needs-parent-independent-review-verification')

    def test_repair_continuation_keeps_bounded_scope_instead_of_full_author_audit(self):
        owner = life.read(self.root / 'owner-task.json')
        owner['task']['taskClass'] = 'editorial-repair'
        life.save(self.root / 'owner-task.json', owner)
        cfg = dict(self.cfg, phasePrefix='repair-auto')
        phase, _ = life.prepare_next(self.root, cfg, self.lane, {'phase': self.lane['phase'], 'threadId': 'own-thread'}, self.summary)
        self.assertEqual(phase.name, 'repair-auto-0001')
        self.assertIn('unchanged exact independent judgments', (phase / 'brief.md').read_text())

    def test_real_blocker_and_unknown_result_do_not_continue(self):
        self.assertEqual(life.classify({'exitCode': 0}, {'status': 'incomplete', 'blocker': 'protected source decision'}, USAGE, [], self.summary), 'held-real-blocker')
        self.assertEqual(life.classify({'exitCode': 0}, None, USAGE, [], self.summary), 'needs-attention-missing-result')
        self.assertEqual(life.classify({'exitCode': 0}, {'status': 'unknown'}, USAGE, [], self.summary), 'needs-attention-unclassified-result')

    def test_capacity_is_bounded_and_recovered_warning_is_not_failure(self):
        self.assertEqual(life.classify({'exitCode': 1}, None, None, [CAPACITY], self.summary), 'capacity-backoff')
        unknown = {'type': 'error', 'message': 'Unknown stream outcome'}
        self.assertEqual(life.classify({'exitCode': 1}, None, None, [CAPACITY, unknown], self.summary), 'needs-attention-unknown-cli-failure')
        warning = {'type': 'error', 'message': 'Reconnecting... 2/5 (exceeded retry limit, last status: 429 Too Many Requests)'}
        self.assertEqual(life.classify({'exitCode': 0}, {'status': 'incomplete'}, USAGE, [warning], self.summary), 'continue-own-authoring')
        (self.phase / 'events.jsonl').write_text(json.dumps(CAPACITY) + '\n')
        life.save(self.phase / 'process-exit.json', {'exitCode': 1, 'usage': USAGE})
        self.lane['capacityFailures'] = 2
        with patch.object(life, 'process_identity', return_value=None), patch.object(self.supervisor, 'launch') as launch:
            self.supervisor.tick(self.lane)
            self.assertEqual(self.lane['status'], 'held-capacity-retries-exhausted')
            launch.assert_not_called()

    def test_capacity_waits_without_spawning_or_double_accounting(self):
        (self.phase / 'events.jsonl').write_text(json.dumps(CAPACITY) + '\n')
        life.save(self.phase / 'process-exit.json', {'exitCode': 1, 'usage': USAGE})
        with patch.object(life, 'process_identity', return_value=None), patch.object(self.supervisor, 'launch') as launch:
            self.supervisor.tick(self.lane)
            self.supervisor.tick(self.lane)
            self.assertEqual(self.lane['capacityFailures'], 1)
            self.assertEqual(self.lane.get('noProgressTurns', 0), 0)
            launch.assert_not_called()

    def test_exact_actual_read_evidence_counts_as_progress_but_not_default_rows(self):
        import hashlib
        self.language['translations']['a']['target'] = 'Authored'
        life.save(self.root / 'language.json', self.language)
        baseline = life.wording_versions(self.root, self.lane, self.source, self.preserved)
        row = {'id': 'a', 'sourceSha256': hashlib.sha256(b'Alpha').hexdigest(),
               'targetSha256': hashlib.sha256(b'Authored').hexdigest(), 'reviewed': True}
        path = self.phase / 'reading.jsonl'
        path.write_text(json.dumps(row) + '\n')
        self.assertEqual(life.wording_versions(self.root, self.lane, self.source, self.preserved), baseline)
        row['rationale'] = 'Actual version-specific reviewer explanation'
        path.write_text(json.dumps(row) + '\n')
        after = life.wording_versions(self.root, self.lane, self.source, self.preserved)
        self.assertEqual(len(after), len(baseline) + 1)
        self.assertTrue(any(key == '@read:a' for key, _ in after))

    def test_missing_exit_receipt_and_live_worker_never_duplicate(self):
        (self.phase / 'process-exit.json').unlink()
        with patch.object(life, 'process_identity', return_value='exact live argv'), patch.object(self.supervisor, 'launch') as launch:
            self.supervisor.tick(self.lane)
            self.assertEqual(self.lane['status'], 'running')
            launch.assert_not_called()
        with patch.object(life, 'process_identity', return_value=None), patch.object(self.supervisor, 'launch') as launch:
            self.supervisor.tick(self.lane)
            self.assertEqual(self.lane['status'], 'waiting-terminal-receipt')
            launch.assert_not_called()

    def test_two_no_progress_turns_hold_and_real_wording_resets(self):
        self.lane['noProgressTurns'] = 1
        with patch.object(life, 'process_identity', return_value=None), patch.object(self.supervisor, 'launch') as launch:
            self.supervisor.tick(self.lane)
            self.assertEqual(self.lane['status'], 'held-no-substantive-progress')
            launch.assert_not_called()
        self.lane.update(status='adopted-running', accountedPhase=None)
        self.language['translations']['a']['target'] = 'Actual authored value'
        life.save(self.root / 'language.json', self.language)
        with patch.object(life, 'process_identity', return_value=None), patch.object(self.supervisor, 'launch') as launch:
            self.supervisor.tick(self.lane)
            self.assertEqual(self.lane['noProgressTurns'], 0)
            launch.assert_called_once()

    def test_source_and_preserved_controls_fail_before_launch(self):
        self.language['translations']['control']['target'] = 'changed'
        life.save(self.root / 'language.json', self.language)
        with self.assertRaisesRegex(ValueError, 'Protected value changed'):
            life.inspect_language(self.root, self.lane, self.source, self.preserved)
        self.language['translations']['control']['target'] = 'ID_KEY'
        self.language['translations']['a']['source'] = 'wrong source'
        life.save(self.root / 'language.json', self.language)
        with self.assertRaisesRegex(ValueError, 'Source wording changed'):
            life.inspect_language(self.root, self.lane, self.source, self.preserved)

    def test_new_turn_offset_and_astra_rejection(self):
        path = self.root / 'session.jsonl'
        path.write_text(json.dumps({'type': 'turn_context', 'payload': {'model': 'gpt-6.1-sol', 'effort': 'high'}}) + '\n')
        offset = path.stat().st_size
        self.assertIsNone(life.current_turn(path, offset))
        with path.open('a') as stream:
            stream.write(json.dumps({'type': 'turn_context', 'payload': {'model': 'gpt-6.1-sol', 'effort': 'high'}}) + '\n')
        self.assertEqual(life.current_turn(path, offset), {'model': 'gpt-6.1-sol', 'effort': 'high'})
        path.write_text(json.dumps({'type': 'turn_context', 'payload': {'model': 'GPT-6-ASTRA', 'effort': 'high'}}) + '\n')
        with self.assertRaisesRegex(ValueError, 'explicitly pinned'):
            life.current_turn(path, 0)
        self.cfg['model'] = 'gpt-6-astra'
        with self.assertRaisesRegex(ValueError, 'explicitly pinned'):
            life.Supervisor(self.root, self.cfg, self.root / 'blocked')

    def test_prepare_uses_frozen_owner_assignment_and_preserves_old_outputs(self):
        life.save(self.phase / 'task.json', {'job': {'immutablePins': {}}, 'task': {'sourcePacket': 'tampered'}})
        old = (self.phase / 'result.json').read_bytes()
        phase, number = life.prepare_next(self.root, self.cfg, self.lane, {'phase': self.lane['phase'], 'threadId': 'own-thread'}, self.summary)
        task = life.read(phase / 'task.json')
        self.assertEqual(task['task']['sourcePacket'], 'source.jsonl')
        self.assertEqual((self.phase / 'result.json').read_bytes(), old)
        self.assertEqual(task['job']['initialLanguageSha256'], self.summary['sha256'])
        self.assertEqual(number, 1)

    def test_unclosed_tool_command_blocks_submission(self):
        event = {'type': 'item.started', 'item': {'id': 'x', 'type': 'command_execution'}}
        (self.phase / 'events.jsonl').write_text(json.dumps(event) + '\n')
        with patch.object(life, 'process_identity', return_value=None), patch.object(life.subprocess, 'Popen') as popen:
            with self.assertRaisesRegex(ValueError, 'Unknown prior tool outcome'):
                self.supervisor.launch(self.lane, {'phase': self.lane['phase'], 'threadId': 'own-thread'}, self.summary)
            popen.assert_not_called()
        event['type'] = 'item.completed'
        with (self.phase / 'events.jsonl').open('a') as stream:
            stream.write(json.dumps(event) + '\n')
        self.assertEqual(life.pending_commands(self.phase / 'events.jsonl'), [])

    def test_pid_reuse_is_rejected_without_touching_process(self):
        other = subprocess.CompletedProcess([], 0, '100000 S Mon Nov 2 00:00:00 2026 /bin/unrelated\n', '')
        with patch.object(life.subprocess, 'run', return_value=other):
            with self.assertRaisesRegex(ValueError, 'Live PID identity differs'):
                life.process_identity(100000, self.phase, 'own-thread')

    def test_unknown_submission_is_persisted_and_not_resubmitted(self):
        session = Path(self.runtime['sessionMetadataPath'])
        session.write_text(json.dumps({'type': 'event_msg', 'payload': {'type': 'token_count',
                           'info': {'total_token_usage': USAGE}}}) + '\n')
        previous = {'phase': self.lane['phase'], 'threadId': 'own-thread'}
        with patch.object(life, 'process_identity', return_value=None), \
                patch.object(life.subprocess, 'check_output', return_value=''), \
                patch.object(life.subprocess, 'Popen', side_effect=RuntimeError('unknown submission boundary')) as popen:
            with self.assertRaisesRegex(RuntimeError, 'unknown submission boundary'):
                self.supervisor.launch(self.lane, previous, self.summary)
            self.assertEqual(life.read(self.root / 'controller/status.json')['lanes'][0]['status'],
                             'submission-pending-reconciliation')
            self.supervisor.tick(self.lane)
            self.assertEqual(popen.call_count, 1)

    def test_positive_continuation_pins_same_session_and_new_runtime_gate(self):
        session = Path(self.runtime['sessionMetadataPath'])
        session.write_text(json.dumps({'type': 'event_msg', 'payload': {'type': 'token_count',
                           'info': {'total_token_usage': USAGE}}}) + '\n')
        previous = {'phase': self.lane['phase'], 'threadId': 'own-thread'}
        class LiveChild:
            pid = 100001
            def poll(self):
                return None
        submitted = []
        def popen(args, **kwargs):
            submitted.append(args)
            with session.open('a') as stream:
                stream.write(json.dumps({'type': 'turn_context', 'payload':
                              {'model': 'gpt-6.1-sol', 'effort': 'high'}}) + '\n')
            return LiveChild()
        with patch.object(life, 'process_identity', side_effect=[None, 'verified current argv']), \
                patch.object(life.subprocess, 'check_output', return_value=''), \
                patch.object(life.subprocess, 'Popen', side_effect=popen):
            self.supervisor.launch(self.lane, previous, self.summary)
        self.assertEqual(len(submitted), 1)
        args = submitted[0]
        self.assertEqual(args[:6], ['/verified/codex', 'exec', 'resume', '--ignore-user-config', '--model', 'gpt-6.1-sol'])
        self.assertIn('model_provider="openai"', args)
        self.assertIn('model_reasoning_effort="high"', args)
        self.assertIn('own-thread', args)
        phase = self.root / self.lane['phase']
        gate = life.read(phase / 'runtime-verification.json')
        self.assertEqual(gate['actualRuntime']['turn'], {'model': 'gpt-6.1-sol', 'effort': 'high'})
        self.assertEqual(gate['baselineUsage'], USAGE)
        self.assertEqual(self.lane['status'], 'running')

    def test_own_attempt_usage_excludes_previous_session_counters(self):
        session = Path(self.runtime['sessionMetadataPath'])
        final = {'input_tokens': 20, 'cached_input_tokens': 14, 'output_tokens': 5, 'total_tokens': 25}
        session.write_text(json.dumps({'type': 'event_msg', 'payload': {'type': 'token_count',
                           'info': {'total_token_usage': final}}}) + '\n')
        (self.phase / 'process-exit.json').unlink()
        life.save(self.phase / 'result.json', {'status': 'incomplete', 'blocker': 'real source decision'})
        class ClosedChild:
            returncode = 0
            def poll(self):
                return 0
        self.supervisor.children['xx'] = (ClosedChild(), USAGE, session)
        with patch.object(life, 'process_identity', return_value=None):
            self.supervisor.tick(self.lane)
        receipt = life.read(self.phase / 'process-exit.json')
        self.assertEqual(receipt['usage'], {'input_tokens': 10, 'cached_input_tokens': 6,
                                          'output_tokens': 3, 'total_tokens': 13})
        self.assertEqual(receipt['finalCumulativeUsage'], final)


if __name__ == '__main__':
    unittest.main()
