"""Synthetic judgments test transport and acceptance boundaries, not semantics."""
import copy
import json
from pathlib import Path
import tempfile
import unittest

from locale_dependencies import OWNER_ACCEPTANCE, REGISTRY, current_lane_state, digest, reconcile
from locale_progress import Evidence


class DependencyTests(unittest.TestCase):
    def setUp(self):
        self.temp=tempfile.TemporaryDirectory();self.addCleanup(self.temp.cleanup)
        self.root=Path(self.temp.name)
        self.files={}
        def save(name,value,rows=False):
            path=self.root/name;path.parent.mkdir(parents=True,exist_ok=True)
            path.write_text(('\n'.join(json.dumps(r) for r in value)+'\n') if rows else json.dumps(value))
            self.files[name]=dict(path=name,sha256=digest(path.read_bytes()))
            return self.files[name]
        self.save=save
        save('source.json',{'source':'original'})
        save('canonical-gate.json',dict(commonSourceAccepted=False))
        save('ru/build.json',dict(siteLocale='ru',sourceManifestSha256=self.files['source.json']['sha256'],projection={'static':'passed'}))
        save('ru/manifest.json',dict(candidate='ru',wholeGameReleaseAccepted=False))
        self.owner=dict(authority='owner',accepted=True,locale='ru',gameVersion='0.45',sharedMechanismReuseAllowed=True,
            artifact=self.files['ru/manifest.json'],sourceManifest=self.files['source.json'],
            targetLocaleAcceptanceGranted=False,targetEditorialAcceptanceGranted=False,targetFontAndNativeAcceptanceGranted=False,
            coordinatorFollowUp={'pt-BR':['actual-target-port-and-checks']})
        save(OWNER_ACCEPTANCE,self.owner)
        self.packet=[dict(id='unit',source='Source',target='Judged target',sourceSha256=digest(b'Source'),targetSha256=digest(b'Judged target'))]
        self.judgments=[dict(id='unit',sourceSha256=digest(b'Source'),targetSha256=digest(b'Judged target'),reviewerThreadId='reviewer',reviewed=True,verdict='pass',rationale='Actual fixture judgment.')]
        save('packet.jsonl',self.packet,True);save('judgments.jsonl',self.judgments,True)
        save('task.json',dict(task=dict(reviewPacket='packet.jsonl',reviewPacketSha256=self.files['packet.jsonl']['sha256'])))
        for role in ['author','reviewer']:
            save(role+'.json',dict(threadId=role,actualRuntime=dict(turn=dict(model='gpt-6.1-sol',effort='high'),session=dict(model_provider='openai',parent_thread_id=None))))
        save('receipt.json',dict(status='accepted-policy',findings=[]))
        self.claim=dict(id='policy',packet=self.files['packet.jsonl'],judgments=self.files['judgments.jsonl'],reviewTask=self.files['task.json'],expectedUnits=1,
            authorRuntime=self.files['author.json'],reviewerRuntimes=[self.files['reviewer.json']],receipt=self.files['receipt.json'],
            assertions=[dict(path=['status'],equals='accepted-policy'),dict(path=['findings'],equals=[])],artifacts=[],acceptedStatus='accepted-policy-only')
        policies=[dict(id=str(i),source='Identity'+str(i),sourceSha256=digest(('Identity'+str(i)).encode()),sourceValueSha256=digest(json.dumps('Identity'+str(i)).encode()),field='field'+str(i),method='method'+str(i)) for i in range(3)]
        save('policies.json',dict(rows=policies))
        self.decision=dict(operation='accept-exact-technical-preservation',commonSourceAccepted=False,translationEntryAllowed=False,sourceExclusions=[],predicateId='policy-gate',scope='Exact identities only.',selectors=[dict(r,policy='preserve-identity-including-any-echo',displayAbsenceProved=False) for r in policies])
        save('decision.json',self.decision)
        save('methods.jsonl',[dict(method=r['method'],changed=False,definitionBefore='d',definitionAfter='d',bodyBefore='b',bodyAfter='b') for r in policies],True)
        save('base.json',dict(predicates=[dict(id=id_,remainingMissingFacts=['actual selected consumer unresolved'],nextPermittedAction='Resolve the exact consumer.') for id_ in ['policy-gate','other1','other2','other3','other4']]))
        save('spec.json',dict(families=[dict(id='one')]))
        save('blocked.json',dict(outcome='blocked'))
        self.registry=dict(schemaVersion=1,russianReference=dict(manifest='ru/manifest.json',build='ru/build.json',sourceManifest='source.json',haikuStageMethodReadback='methods.jsonl'),
            canonicalSourceManifest=self.files['canonical-gate.json'],
            processSpec='spec.json',parentDecision='decision.json',originalPolicies='policies.json',baseGateMatrix='base.json',policyApprovalId='policy',
            families=[dict(id='one',referenceStatus='historical-static',buildPointers=[['projection']],sourceContracts=[])],approvals=[self.claim],gateUpdates={},
            locales={'pt-BR':dict(owningBlockedResult='blocked.json',closedWaits=[dict(id='old-wait',approvalId='policy')],completedSubdependencies=[],remaining=['actual-resource-binding'])})

    def evaluate(self):
        self.registry['pins']=[p for name,p in self.files.items() if name not in [REGISTRY,'canonical-gate.json']]
        self.save(REGISTRY,self.registry)
        ev=Evidence(self.root);result=reconcile(ev);ev.stable();return result

    def test_exact_policy_closes_without_language_source_native_or_wake_credit(self):
        result=self.evaluate()
        self.assertEqual(sum(g['historicalStatus']=='held' for g in result['gates']),4)
        self.assertTrue(result['sharedBaseAccepted'])
        self.assertTrue(all(g['blocksRussianBaselineReuse'] is False for g in result['gates']))
        self.assertFalse(result['commonSourceAccepted']);self.assertFalse(result['newModelWakeAllowed'])
        self.assertEqual(result['sourceExclusions'],[])
        self.assertEqual(result['approvals'][0]['linguisticCoverageAdded'],0)
        self.assertFalse(result['families'][0]['localeWordingAccepted'])

    def test_owner_acceptance_supersedes_both_false_and_true_historical_release_flags(self):
        self.assertTrue(self.evaluate()['sharedBaseAccepted'])
        self.owner['artifact']=self.save('ru/manifest.json',dict(candidate='ru',wholeGameReleaseAccepted=True))
        self.save(OWNER_ACCEPTANCE,self.owner)
        self.assertTrue(self.evaluate()['sharedBaseAccepted'])

    def test_russian_owner_confirmation_does_not_accept_another_locale(self):
        self.owner['targetLocaleAcceptanceGranted']=True;self.save(OWNER_ACCEPTANCE,self.owner)
        with self.assertRaisesRegex(ValueError,'russian-owner-target-boundary'):self.evaluate()

    def test_current_blocker_overlay_requires_the_exact_owning_terminal_result(self):
        result=self.evaluate();row=dict(locale='pt-BR',laneStatus='blocked',lastResult=self.files['blocked.json'])
        self.assertIsNotNone(current_lane_state(row,result))
        row['lastResult']=dict(row['lastResult'],sha256='different')
        self.assertIsNone(current_lane_state(row,result))
        row.update(lastResult=self.files['blocked.json'],laneStatus='running')
        self.assertIsNone(current_lane_state(row,result))

    def test_new_canonical_source_evidence_disables_the_old_blocker_overlay(self):
        result=self.evaluate()
        self.save('canonical-gate.json',dict(commonSourceAccepted=True))
        result=self.evaluate()
        self.assertFalse(result['currentSourceVersionMatched'])
        self.assertIsNone(current_lane_state(dict(locale='pt-BR',laneStatus='blocked',lastResult=self.files['blocked.json']),result))

    def test_changed_reviewed_target_rejected_after_self_consistent_packet_and_task_updates(self):
        self.packet[0].update(target='Changed',targetSha256=digest(b'Changed'))
        self.claim['packet']=self.save('packet.jsonl',self.packet,True)
        self.claim['reviewTask']=self.save('task.json',dict(task=dict(reviewPacket='packet.jsonl',reviewPacketSha256=self.claim['packet']['sha256'])))
        with self.assertRaisesRegex(ValueError,'dependency-review-version'):self.evaluate()

    def test_unread_or_missing_judgments_never_become_accepted_dependencies(self):
        self.judgments[0]['reviewed']=False
        self.claim['judgments']=self.save('judgments.jsonl',self.judgments,True)
        with self.assertRaisesRegex(ValueError,'dependency-review-not-passed'):self.evaluate()

    def test_missing_review_coverage_rejects(self):
        self.claim['judgments']=self.save('judgments.jsonl',[],True)
        with self.assertRaisesRegex(ValueError,'dependency-review-coverage'):self.evaluate()

    def test_nonindependent_or_unverified_model_is_rejected(self):
        runtime=json.loads((self.root/'reviewer.json').read_text());runtime['threadId']='author'
        self.claim['reviewerRuntimes']=[self.save('reviewer.json',runtime)]
        with self.assertRaisesRegex(ValueError,'dependency-review-independence'):self.evaluate()

    def test_broadened_parent_decision_is_rejected_after_valid_prior_review(self):
        self.decision['commonSourceAccepted']=True
        self.save('decision.json',self.decision)
        with self.assertRaisesRegex(ValueError,'parent-decision-scope'):self.evaluate()

    def test_changing_technical_identity_is_rejected_without_excluding_it_from_source(self):
        self.decision['selectors'][0]['source']='Translated identity'
        self.save('decision.json',self.decision)
        with self.assertRaisesRegex(ValueError,'parent-policy-original-version'):self.evaluate()

    def test_reference_code_change_cannot_be_reused_as_an_unchanged_russian_method(self):
        rows=[json.loads(x) for x in (self.root/'methods.jsonl').read_text().splitlines()]
        rows[0].update(bodyAfter='different',changed=True);self.save('methods.jsonl',rows,True)
        with self.assertRaisesRegex(ValueError,'russian-policy-method-changed'):self.evaluate()

    def test_unstamped_judgment_requires_explicit_file_bound_legacy_provenance(self):
        self.judgments[0].pop('reviewerThreadId')
        self.claim['judgments']=self.save('judgments.jsonl',self.judgments,True)
        with self.assertRaisesRegex(ValueError,'dependency-review-thread'):self.evaluate()


if __name__=='__main__':unittest.main()
