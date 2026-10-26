"""Continuation-boundary regressions. CLI requests are replaced; no model/game runs."""
import hashlib
import json
from pathlib import Path
import shutil
import tempfile
import unittest
from unittest.mock import patch

import cli_job_support as support
import run_asset_ru as assets
import run_serial_ru as technical

TOOLS = Path(__file__).resolve().parent


def write(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value) + '\n')


class ContinuationTests(unittest.TestCase):
    def test_operational_report_is_auxiliary_not_a_progress_substitute(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary).resolve()
            run = root / 'outputs/job'
            write(root / 'localization/probe.json', {'real': True})
            write(run / 'integration.json', {'report': True})
            main, auxiliary = support.evidence_files(root, run,
                ['localization/probe.json', 'outputs/job/integration.json'])
            self.assertEqual(len(main), 1)
            self.assertEqual(len(auxiliary), 1)
            with self.assertRaisesRegex(ValueError, 'operational reports alone'):
                support.evidence_files(root, run, ['outputs/job/integration.json'])
            write(root / 'outputs/other/report.json', {})
            with self.assertRaisesRegex(ValueError, 'belongs to another job'):
                support.evidence_files(root, run, ['localization/probe.json', 'outputs/other/report.json'])
            with self.assertRaisesRegex(ValueError, 'outside the canonical'):
                support.evidence_files(root, run, ['../escape.json'])

    def test_resume_reconciles_completed_result_without_rerunning_it(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary).resolve()
            run = root / 'outputs/job'
            old = run / '0001-work'
            old.mkdir(parents=True)
            first = old / 'next.md'
            first.write_text('Original recorded next action')
            write(root / 'localization/probe.json', {'version': 1})
            write(old / 'integration.json', {'committed': True})
            for name in ('contract.md', 'run_review.py'):
                (run / name).write_text('Historical execution file')
            shutil.copyfile(TOOLS / 'cli_job_support.py', run / 'cli_job_support.py')
            (root / 'localization/CLI-TASK.md').write_text('Parallel lanes authorized')
            codex = root / 'fake-codex'
            codex.write_text('Fake request boundary')
            write(run / 'job.json', {'status': 'held-supervisor-error', 'supervisorPid': None,
                'phases': [{'number': 1, 'directory': str(old), 'exitCode': 0,
                    'result': {'outcome': 'continue', 'evidence': ['localization/probe.json',
                        'outputs/job/0001-work/integration.json'], 'nextBrief': str(first), 'nextKind': 'work'}}]})
            calls = []

            class Child:
                pid = 99999999

                def __init__(self, command, **kwargs):
                    self.phase = Path(command[command.index('--output-last-message') + 1]).parent
                    self.out = kwargs['stdout']
                    calls.append(self.phase.name)

                def wait(self):
                    self.returncode = 0
                    self.out.write(json.dumps({'type': 'turn.completed', 'usage': {'input_tokens': 10, 'output_tokens': 2}}) + '\n')
                    self.out.flush()
                    if len(calls) == 1:
                        write(root / 'localization/new-probe.json', {'new': True})
                        write(self.phase / 'integration.json', {'report': True})
                        next_path = self.phase / 'next.md'
                        next_path.write_text('Next genuinely new work')
                        result = {'outcome': 'continue', 'summary': 'new probe',
                            'evidence': ['localization/new-probe.json', str((self.phase / 'integration.json').relative_to(root))],
                            'nextKind': 'work', 'nextBrief': str(next_path)}
                    else:
                        result = {'outcome': 'needs-owner', 'summary': 'Deliberate test stopping boundary'}
                    write(self.phase / 'result.json', result)
                    return 0

            with patch.object(technical, 'ROOT', root), patch.object(technical.shutil, 'which', return_value=str(codex)), patch.object(technical.subprocess, 'Popen', Child):
                technical.run(run, first, resume=True)
            state = json.loads((run / 'job.json').read_text())
            self.assertEqual(calls, ['0002-work', '0003-work'])
            self.assertEqual(state['phases'][0]['status'], 'phase-complete')
            self.assertEqual(state['phases'][1]['status'], 'phase-complete')
            self.assertEqual(len(state['phases'][1]['auxiliaryEvidence']), 1)
            history = Path(state['resumptions'][0]['history'])
            self.assertEqual(json.loads((history / 'job.json').read_text())['status'], 'held-supervisor-error')
            self.assertFalse((run / 'queue.lock').exists())

    def test_asset_partial_state_survives_two_automatic_fresh_phases(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary).resolve()
            run = root / 'outputs/asset-job'
            run.mkdir(parents=True)
            source_path = root / 'localization/source/dialogue-candidates.jsonl'
            source_path.parent.mkdir(parents=True)
            source = [{'id': str(i), 'source': f'Original {i}', 'occurrences': [f'a:{i}', f'b:{i}'],
                       'conversation': 'test', 'conversationId': 1} for i in range(3)]
            source_path.write_text(''.join(json.dumps(x) + '\n' for x in source))
            write(run / 'input-pins.json', {str(source_path): support.digest(source_path)})
            target_path = root / 'localization/ru-assets/dialogue.ru.jsonl'
            target_path.parent.mkdir(parents=True)

            def target(i):
                row = {**source[i], 'target': f'Перевод {i}'}
                for field in ('source', 'target'):
                    row[field + 'Sha256'] = hashlib.sha256(row[field].encode()).hexdigest()
                return row

            target_path.write_text(json.dumps(target(0)) + '\n')
            write(target_path.parent / 'unresolved.json', [])
            for name in ('result.json', 'progress.json'):
                write(run / name, {'authoredIds': 1})
            for name in ('continuation.md', 'launch.py', 'contract.md', 'supervise.py'):
                (run / name).write_text('Saved pre-existing checkpoint')
            shutil.copyfile(TOOLS / 'cli_job_support.py', run / 'cli_job_support.py')
            write(run / 'job.json', {'status': 'finished', 'pid': None, 'supervisorPid': None,
                'measuredUsage': {'input_tokens': 11, 'output_tokens': 2, 'total_tokens': 13}})
            codex = root / 'fake-codex'
            codex.write_text('Fake request boundary')
            calls = []

            class Child:
                pid = 99999999

                def __init__(self, command, **kwargs):
                    self.phase = Path(command[command.index('--output-last-message') + 1]).parent
                    self.out = kwargs['stdout']
                    calls.append(command)

                def wait(self):
                    with target_path.open('a') as stream:
                        stream.write(json.dumps(target(len(calls))) + '\n')
                    write(self.phase / 'result.json', {'outcome': 'continue' if len(calls) == 1 else 'draft-complete'})
                    self.out.write(json.dumps({'type': 'turn.completed', 'usage': {'input_tokens': 10, 'cached_input_tokens': 4, 'output_tokens': 3}}) + '\n')
                    self.out.flush()
                    return 0

            with patch.object(assets, 'ROOT', root), patch.object(assets.shutil, 'which', return_value=str(codex)), patch.object(assets.subprocess, 'Popen', Child):
                assets.run(run)
            state = json.loads((run / 'job.json').read_text())
            self.assertEqual(state['status'], 'draft-complete')
            self.assertEqual(len(state['phases']), 3)
            self.assertEqual(state['measuredUsage']['total_tokens'], 39)
            rows = [json.loads(line) for line in target_path.read_text().splitlines()]
            self.assertEqual(rows[0], target(0))
            self.assertEqual(len(rows), 3)
            self.assertTrue(all('resume' not in command for command in calls))
            self.assertTrue(all(command[command.index('--model') + 1] == 'gpt-6.1-sol' for command in calls))
            before = support.asset_snapshot(root, run)
            lost = {**before, 'targetHashes': dict(list(before['targetHashes'].items())[1:])}
            with self.assertRaisesRegex(ValueError, 'lost previously saved'):
                support.asset_progress(before, lost)
            self.assertFalse(support.asset_progress(before, before))

    def test_model_guard_rejects_astra_before_requests(self):
        support.validate_model('gpt-6.1-sol', 'high', 'openai')
        for forbidden in ('gpt-6-astra', 'GPT-6-ASTRA', 'future-Astra-alias', 'unverified-default'):
            with self.assertRaisesRegex(ValueError, 'explicitly pinned'):
                support.validate_model(forbidden, 'high', 'openai')

    def test_capacity_restart_is_bound_to_failed_request_and_saved_targets(self):
        with tempfile.TemporaryDirectory() as temporary:
            directory = Path(temporary).resolve()
            state = {'status': 'held-process-or-transport-failure', 'phases': [
                {'number': 8, 'threadId': 'failed-request', 'exitCode': 1, 'errors': [
                    {'type': 'error', 'message': 'Selected model is at capacity. Please try a different model.'}]}]}
            write(directory / 'job.json', state)
            write(directory / 'input-pins.json', {})
            before = directory / 'before.json'
            write(before, {'targetHashes': {'saved': 'unchanged'}})
            snapshot = {'overlaySha256': 'recovered', 'targetHashes': {'saved': 'unchanged', 'new': 'added'}}
            receipt = {'failedPhase': 8, 'failedThreadId': 'failed-request',
                'jobSha256': support.digest(directory / 'job.json'), 'overlaySha256': 'recovered',
                'inputPinsSha256': support.digest(directory / 'input-pins.json'),
                'beforeSnapshot': str(before), 'beforeSnapshotSha256': support.digest(before),
                'ownerInstruction': 'Repair and continue both authorized CLI lanes'}
            path = directory / 'receipt.json'
            write(path, receipt)
            self.assertEqual(assets.validate_capacity_restart(directory, state, path, snapshot), receipt)
            with self.assertRaisesRegex(ValueError, 'changed or lost previously saved'):
                assets.validate_capacity_restart(directory, state, path,
                    {**snapshot, 'targetHashes': {'saved': 'overwritten'}})
            write(path, {**receipt, 'failedPhase': 7})
            with self.assertRaisesRegex(ValueError, 'different failed request'):
                assets.validate_capacity_restart(directory, state, path, snapshot)
            unknown = json.loads(json.dumps(state))
            unknown['phases'][0]['errors'][0]['message'] = 'Stream disconnected; outcome unknown'
            write(directory / 'job.json', unknown)
            write(path, {**receipt, 'jobSha256': support.digest(directory / 'job.json')})
            with self.assertRaisesRegex(ValueError, 'unknown transport outcomes remain held'):
                assets.validate_capacity_restart(directory, unknown, path, snapshot)

    def test_technical_capacity_restart_retains_failed_turn_and_binds_next_step(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary).resolve()
            directory = root / 'outputs/technical'
            phase = directory / '0020-work'
            phase.mkdir(parents=True)
            brief = phase / 'next.md'
            brief.write_text('Continue new geometry work; never repeat consumed runtime')
            artifact = root / 'localization/verified.json'
            write(artifact, {'cleanup': True})
            events = phase / 'events.jsonl'
            records = [{'type': 'thread.started', 'thread_id': 'interrupted'},
                       {'type': 'error', 'message': 'Selected model is at capacity. Please try a different model.'}]
            events.write_text(''.join(json.dumps(x) + '\n' for x in records))
            state = {'phases': [{'number': 20, 'exitCode': 1, 'directory': str(phase), 'result': None}]}
            write(directory / 'job.json', state)
            receipt = {'failedPhase': 20, 'failedThreadId': 'interrupted',
                'jobSha256': support.digest(directory / 'job.json'), 'nextBrief': str(brief),
                'nextBriefSha256': support.digest(brief), 'ownerInstruction': 'Repair and continue both authorized CLI lanes',
                'artifacts': {'localization/verified.json': support.digest(artifact)}}
            path = directory / 'receipt.json'
            write(path, receipt)
            with patch.object(technical, 'ROOT', root):
                self.assertEqual(technical.validate_capacity_restart(directory, state, path, brief), receipt)
                write(artifact, {'cleanup': False})
                with self.assertRaisesRegex(AssertionError, 'Recovered artifact changed'):
                    technical.validate_capacity_restart(directory, state, path, brief)

                write(artifact, {'cleanup': True})
                records[-1]['message'] = 'Unknown stream outcome'
                events.write_text(''.join(json.dumps(x) + '\n' for x in records))
                with self.assertRaisesRegex(AssertionError, 'Unknown request outcome'):
                    technical.validate_capacity_restart(directory, state, path, brief)

    def test_orphaned_running_record_requires_real_cleanup(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary).resolve()
            directory = root / 'outputs/technical'
            phase = directory / '0022-work'
            phase.mkdir(parents=True)
            (phase / 'events.jsonl').write_text(json.dumps({'type': 'thread.started', 'thread_id': 'orphaned'}) + '\n')
            brief = directory / 'reviewed-next.md'
            brief.write_text('Use repaired snapshot; never relaunch consumed candidate')
            state = {'status': 'running', 'phases': [{'number': 22, 'directory': str(phase)}]}
            write(directory / 'job.json', state)
            cleanup_path = root / 'localization/probe/cleanup.json'
            cleanup = {'remainingTaskProcessRows': [], 'quitAcknowledged': True,
                       'originalAssetsAndPlayerFilesUnchanged': True, 'inspectionBridgeRemoved': True, 'inputPinsUnchanged': True}
            write(cleanup_path, cleanup)
            receipt = {'kind': 'observer-interruption', 'failedPhase': 22, 'failedThreadId': 'orphaned',
                'jobSha256': support.digest(directory / 'job.json'), 'nextBrief': str(brief),
                'nextBriefSha256': support.digest(brief), 'ownerInstruction': 'Repair and continue both authorized CLI lanes',
                'cleanup': 'localization/probe/cleanup.json', 'artifacts': {'localization/probe/cleanup.json': support.digest(cleanup_path)}}
            path = directory / 'receipt.json'
            write(path, receipt)
            with patch.object(technical, 'ROOT', root):
                self.assertEqual(technical.validate_interruption_restart(directory, state, path, brief), receipt)
                write(cleanup_path, {**cleanup, 'inspectionBridgeRemoved': False})
                receipt['artifacts']['localization/probe/cleanup.json'] = support.digest(cleanup_path)
                write(path, receipt)
                with self.assertRaisesRegex(AssertionError, 'runtime cleanup is unverified'):
                    technical.validate_interruption_restart(directory, state, path, brief)


if __name__ == '__main__':
    unittest.main()
