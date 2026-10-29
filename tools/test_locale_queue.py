"""Queue migration/packet boundaries; fixtures replace games and semantic reviews."""
import copy
import hashlib
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import locale_queue as q
from cli_job_support import require_legacy_assignment_current
import run_asset_ru
import editorial_lane
import after_editorial


def put(path, value):
    path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(json.dumps(value)+'\n')


class QueueTests(unittest.TestCase):
    def fixture(self, root):
        for name in [q.GUIDE,'tools/locale_queue.py','tools/cli_runtime_identity.py','tools/cli_job_support.py']:
            path=root/name;path.parent.mkdir(parents=True,exist_ok=True);path.write_text('fixture\n')
        original=dict(id='one',source='English',occurrences=[{'id':1}])
        source=root/'localization/source/dialogue.jsonl';source.parent.mkdir(parents=True,exist_ok=True)
        source.write_text(json.dumps(original)+'\n')
        target=dict(original,sourceSha256=hashlib.sha256(b'English').hexdigest(),target='Deutsch',targetSha256=hashlib.sha256(b'Deutsch').hexdigest())
        overlay=root/'localization/de-assets/dialogue.de.jsonl';overlay.parent.mkdir(parents=True)
        overlay.write_text(json.dumps(target)+'\n')
        (overlay.parent/'custom-helper.py').write_text('Do not overwrite custom adapters\n')
        for locale in ['en','de','ja','ru']:put(root/f'localization/glossary/{locale}.json',[])
        put(root/'scope.json',dict(targetLocales=['ru','de','ja']))
        put(root/'family.json',dict(status='source-held',visibleDenominator=None))
        spec=dict(revision='test-v2',model=dict(name='gpt-6.1-sol',reasoning='high',provider='openai',inheritedHistory=False),
                  limits=dict(linguistic=6,technical=1),stages=list(q.STAGES),languages={'ru':'Russian','de':'German','ja':'Japanese'},
                  localeScope='scope.json',dialogueSource='localization/source/dialogue.jsonl',sharedEvidence=['family.json','localization/source/dialogue.jsonl'],
                  universalReferences=[],families=[dict(id='held-family',evidence=['family.json'],predicate='Exact admitted selectors',nextAction='Resolve source hold')],
                  sharedTasks=[dict(id='source-reconcile',state='prepared')])
        put(root/q.SPEC,spec)
        owner=root/'outputs/locale-assets-20261026/de';put(owner/'job.json',dict(status='draft-complete',pid=99999999))
        (owner/'supervise.py').write_text('Immutable old execution\n')
        group=owner.parent/'group.json';put(group,dict(status='running',jobs=[str((owner/'job.json').relative_to(root))],submissions=[dict(thread='old')]))
        return overlay,owner,spec

    def test_migration_updates_actual_existing_owner_and_preserves_old_work(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();overlay,owner,_=self.fixture(root)
            before={p:p.read_bytes() for p in [overlay,overlay.parent/'custom-helper.py',owner/'job.json',owner/'supervise.py']}
            receipt=q.update(root);queue=q.check(root)
            self.assertEqual(receipt['existingLanguageCount'],1)
            self.assertEqual(receipt['modelRequestsStarted'],0)
            self.assertEqual(len(queue['locales']),2)
            self.assertEqual(queue['locales'][0]['savedDialogue']['authoredIds'],1)
            self.assertIsNone(queue['locales'][1]['savedDialogue'])
            self.assertTrue(all(p.read_bytes()==raw for p,raw in before.items()))
            group=q.read(owner.parent/'group.json')
            self.assertEqual(group['status'],'prepared-not-started')
            self.assertEqual(group['submissions'],[dict(thread='old')])
            self.assertEqual(q.read(root/group['workflowBinding']['previousGroup'])['status'],'running')
            self.assertEqual(q.update(root),receipt)  # Repeat changes no saved input or pointer.
            self.assertTrue(all(p.read_bytes()==raw for p,raw in before.items()))

    def test_source_binding_mismatch_is_rejected_before_queue_publication(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);overlay,_,_=self.fixture(root)
            q.build_queue(root)  # Matching positive control.
            row=json.loads(overlay.read_text());row['source']='Different English';overlay.write_text(json.dumps(row)+'\n')
            with self.assertRaisesRegex(ValueError,'Saved source binding mismatch'):q.update(root)
            self.assertFalse((root/q.QUEUE).exists())

    def test_changed_shared_recipe_or_local_target_requires_reconciliation(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);overlay,_,_=self.fixture(root);q.update(root);q.check(root)
            (root/'family.json').write_text('{"status":"changed"}')
            with self.assertRaisesRegex(ValueError,'Queue inputs/state changed'):q.check(root)
            before=(root/q.QUEUE).read_bytes()
            with self.assertRaisesRegex(ValueError,'Existing queue differs'):q.update(root)
            q.update(root,reconcile=True);q.check(root)
            historical=root/'localization/completion/queue-history'/hashlib.sha256(before).hexdigest()/q.QUEUE
            self.assertEqual(historical.read_bytes(),before)
            self.assertEqual(q.read(root/q.RECEIPT)['modelRequestsStarted'],0)

    def test_prohibited_model_fails_before_localized_files_are_read(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);_,_,spec=self.fixture(root)
            for model in ['gpt-6-astra','ASTRA-alias','unverified-default']:
                changed=copy.deepcopy(spec);changed['model']['name']=model;put(root/q.SPEC,changed)
                with patch.object(q,'rows',side_effect=AssertionError('localized file read')) as read_rows:
                    with self.assertRaisesRegex(ValueError,'NEVER Astra'):q.build_queue(root)
                    read_rows.assert_not_called()

    def test_live_owner_prevents_all_migration_writes(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);_,owner,_=self.fixture(root);before=(owner/'job.json').read_bytes()
            with patch.object(q,'assert_idle',side_effect=ValueError('Existing job still has a live process')):
                with self.assertRaisesRegex(ValueError,'live process'):q.update(root)
            self.assertFalse((root/q.QUEUE).exists());self.assertEqual((owner/'job.json').read_bytes(),before)

    def test_pinned_locale_packet_and_scope_and_occupied_output(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();_,owner,_=self.fixture(root);q.update(root)
            output=owner/'workflow-v2/reconcile'
            manifest=q.prepare(root,'de',output)
            self.assertEqual(manifest['modelRequestsStarted'],0)
            for name,digest in manifest['files'].items():self.assertEqual(q.sha(output/name),digest)
            self.assertIn('German', (output/'request.md').read_text())
            self.assertEqual(q.read(output/'packet-manifest.json'),manifest)
            for locale in ['ru','unknown']:
                with self.assertRaisesRegex(ValueError,'Explicit known'):q.prepare(root,locale,output.parent/'unknown')
            with self.assertRaisesRegex(ValueError,'existing locale job'):q.prepare(root,'de',root/'outputs/foreign/new')
            with self.assertRaisesRegex(ValueError,'Occupied output'):q.prepare(root,'de',output)

    def test_failure_before_last_manifest_is_explicit_partial_packet(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();_,owner,_=self.fixture(root);q.update(root);output=owner/'workflow-v2/partial'
            with patch.object(q.shutil,'copyfile',side_effect=OSError('interrupted copy')):
                with self.assertRaisesRegex(OSError,'interrupted copy'):q.prepare(root,'de',output)
            self.assertTrue(output.exists());self.assertFalse((output/'packet-manifest.json').exists())
            with self.assertRaisesRegex(ValueError,'Occupied output'):q.prepare(root,'de',output)

    def test_pointer_corruption_and_old_entry_points_fail_before_model_launch(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();_,owner,_=self.fixture(root);q.update(root);q.check(root)
            with self.assertRaisesRegex(ValueError,'Job migrated'):require_legacy_assignment_current(owner)
            for runner in [run_asset_ru.run,editorial_lane.run]:
                with patch('subprocess.Popen') as launch:
                    with self.assertRaisesRegex(ValueError,'Job migrated'):runner(owner)
                    launch.assert_not_called()
            pointer=owner/'current-workflow.json';data=q.read(pointer);data['legacyResumeAllowed']=True;put(pointer,data)
            with self.assertRaisesRegex(ValueError,'workflow pointer changed'):q.check(root)

    def test_old_post_editorial_dispatch_stops_before_claim_or_request(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp).resolve();_,owner,_=self.fixture(root);q.update(root)
            trigger=root/'outputs/trigger';trigger.mkdir()
            jobs={loc:str(root/'outputs/editorial-20261027'/loc) for loc in after_editorial.LOCALES}
            jobs['de']=str(owner)
            put(trigger/'plan.json',dict(model='gpt-6.1-sol',reasoning='high',jobs=jobs))
            with patch('subprocess.Popen') as launch:
                with self.assertRaisesRegex(ValueError,'Job migrated'):after_editorial.run(trigger)
                launch.assert_not_called()
            self.assertFalse((trigger/'watcher.claim').exists())
            self.assertFalse((trigger/'submission-intent.json').exists())


if __name__=='__main__':unittest.main()
