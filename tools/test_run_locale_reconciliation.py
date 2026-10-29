"""Real filesystem/intent tests; model execution and runtime metadata are replaced."""
import copy
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import locale_queue as q
import run_locale_reconciliation as launch


def put(path,value):
    path.parent.mkdir(parents=True,exist_ok=True);path.write_text(json.dumps(value)+'\n')


class LaunchTests(unittest.TestCase):
    def plan(self,root):
        group=root/'outputs/locale-assets-20261026/run';group.mkdir(parents=True)
        cli=root/'codex-fixture';cli.write_text('fixture executable bytes')
        entries=[]
        for loc in launch.LOCALES:
            packet=root/'outputs/locale-assets-20261026'/loc/'packet';packet.mkdir(parents=True)
            entries.append(dict(locale=loc,packet=str(packet),manifestSha256='fixture',localeContext=dict(existingOwners=[])))
        plan=dict(root=str(root),model=dict(name='gpt-6.1-sol',reasoning='high',provider='openai',inheritedHistory=False),
                  revision='test',entries=entries,executionPins={},cli=str(cli),cliSha256=q.sha(cli))
        put(group/'plan.json',plan)
        return group,plan

    def test_exact_fresh_command_and_astra_before_model_boundary(self):
        with tempfile.TemporaryDirectory() as tmp:
            group,plan=self.plan(Path(tmp));packet=Path(plan['entries'][0]['packet'])
            argv=launch.command(plan,packet)
            self.assertEqual(argv[1:5],['exec','--ignore-user-config','--model','gpt-6.1-sol'])
            self.assertNotIn('resume',argv);self.assertNotIn('fork',argv)
            self.assertIn('model_provider="openai"',argv)
            self.assertIn('runtime-verification.json',argv[-1])
            for model in ['gpt-6-astra','ASTRA-alias','default']:
                bad=copy.deepcopy(plan);bad['model']['name']=model;put(group/'plan.json',bad)
                with patch.object(launch.queue,'check') as read_localized,patch.object(launch.subprocess,'Popen') as send:
                    with self.assertRaisesRegex(ValueError,'explicitly pinned'):launch.run(group)
                    read_localized.assert_not_called();send.assert_not_called()

    def test_packet_hashes_and_prior_intent_fail_at_intended_boundary(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);packet=root/'packet';packet.mkdir();source=root/'source';source.write_text('pinned')
            (packet/'request.md').write_text('Finite fixture request')
            put(packet/'input-pins.json',{str(source):q.sha(source)})
            manifest=dict(locale='de',model=dict(name='gpt-6.1-sol',reasoning='high',provider='openai',inheritedHistory=False),
                          files={name:q.sha(packet/name) for name in ['request.md','input-pins.json']})
            put(packet/'packet-manifest.json',manifest);expected=dict(locale='de',sha256=q.sha(packet/'packet-manifest.json'))
            launch.verify_packet(root,packet,expected)
            (packet/'submission-intent.json').write_text('{}')
            with self.assertRaisesRegex(ValueError,'Prior submission/output'):launch.verify_packet(root,packet,expected)
            (packet/'submission-intent.json').unlink();source.write_text('changed')
            with self.assertRaisesRegex(ValueError,'localization input changed'):launch.verify_packet(root,packet,expected)

    def test_six_once_and_capacity_failure_never_retries(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();group,plan=self.plan(root);calls=[]
            class Child:
                pid=99999999
                def __init__(self,argv,**kwargs):
                    calls.append(argv);packet=Path(argv[argv.index('--output-last-message')+1]).parent
                    self.code=1 if packet.parent.name=='ja' else 0
                    events=[dict(type='thread.started',thread_id=packet.parent.name)]
                    events.append(dict(type='turn.failed',error=dict(message='Selected model is at capacity. Please try a different model.')) if self.code else
                                  dict(type='turn.completed',usage=dict(input_tokens=10,cached_input_tokens=4,output_tokens=2)))
                    for event in events:kwargs['stdout'].write(json.dumps(event)+'\n')
                    kwargs['stdout'].flush()
                    if not self.code:put(packet/'result.json',dict(note='Fixture result; no semantic acceptance'))
                def poll(self):return self.code
            def identity(packet,child):
                put(packet/'runtime-verification.json',dict(fixture=True))
                return dict(threadId=packet.parent.name)
            with patch.object(launch.queue,'check'),patch.object(launch,'verify_packet'),patch.object(launch.queue,'assert_idle'),\
                 patch.object(launch.subprocess,'Popen',side_effect=Child),patch.object(launch,'publish_current_runtime',side_effect=identity):
                launch.run(group)
                self.assertEqual(len(calls),6)
                state=q.read(group/'status.json');self.assertEqual(state['modelRequestsStarted'],6)
                self.assertEqual(next(r for r in state['entries'] if r['locale']=='ja')['status'],'held-request-outcome')
                self.assertEqual(sum(r['status']=='completed-awaiting-parent-review' for r in state['entries']),5)
                with self.assertRaises(FileExistsError):launch.run(group)
                self.assertEqual(len(calls),6)

    def test_observer_failure_preserves_unknown_intent_without_retry(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();group,plan=self.plan(root)
            with patch.object(launch.queue,'check'),patch.object(launch,'verify_packet'),patch.object(launch.queue,'assert_idle'),\
                 patch.object(launch.subprocess,'Popen',side_effect=OSError('unknown submission outcome')) as send:
                with self.assertRaisesRegex(OSError,'unknown submission'):launch.run(group)
                self.assertEqual(send.call_count,1)
            state=q.read(group/'status.json');self.assertEqual(state['status'],'held-observer-error')
            self.assertTrue((Path(plan['entries'][0]['packet'])/'submission-intent.json').exists())


if __name__=='__main__':unittest.main()
