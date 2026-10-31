"""Regression tests for credit boundaries and actual progress publication."""
import copy
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

from locale_progress import (Evidence, accepted_stages, calculate_score, collect_locale, hashed,
                             linguistic_pass, proof_refs, retained_reviews, snapshot, version, report)
from locale_progress_evidence import resources


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

    def editorial_handoff(self):
        dependencies = {}
        for field, path in [('sourceGlossarySha256', 'localization/glossary/en.json'),
                            ('localeGlossarySha256', 'localization/glossary/ja.json'),
                            ('sourceSha256', 'localization/source/dialogue-candidates.jsonl')]:
            _, dependencies[field] = self.write(path, {'fixture': field})
        review, digest = self.write('localization/editorial-delivery/ja-cycle-02/peer/reviews.jsonl',
            dict(id='one', sourceSha256=hashed(b'English'), targetSha256=hashed(b'A'),
                 verdict='pass', rationale='Synthetic judgment tests transport only'))
        manifest, manifest_sha = self.write('localization/editorial-delivery/ja-current.json',
            dict(locale='ja', **dependencies, currentCorpus={'sha256': hashed(b'old whole corpus')},
                 evidence={str(review.relative_to(self.root)): {'sha256': digest}}))
        baseline, _ = self.write('outputs/locale-assets-20261026/ja/workflow-v2/reconcile-saved-evidence/result.json',
            dict(editorialApplicability={'owningManifest': str(manifest.relative_to(self.root))},
                 artifacts=[dict(path=str(manifest.relative_to(self.root)), sha256=manifest_sha)]))
        return baseline, manifest, review

    def test_named_editorial_handoff_recovers_exact_pinned_reviews(self):
        _, _, review = self.editorial_handoff()
        rows = list(retained_reviews(Evidence(self.root), 'ja'))
        self.assertEqual([r['id'] for r in rows], ['one'])
        self.assertEqual(version(rows[0]), ('one', hashed(b'English'), hashed(b'A')))
        review.write_text('{}')
        evidence = Evidence(self.root)
        self.assertEqual(list(retained_reviews(evidence, 'ja')), [])
        self.assertTrue(any('Stale evidence' in error for error in evidence.errors))

    def test_named_editorial_handoff_rejects_unpinned_or_foreign_manifest(self):
        baseline, manifest, _ = self.editorial_handoff()
        value = json.loads(baseline.read_text()); value['artifacts'] = []
        baseline.write_text(json.dumps(value))
        with self.assertRaisesRegex(ValueError, 'Unpinned owning editorial manifest'):
            list(retained_reviews(Evidence(self.root), 'ja'))
        data = json.loads(manifest.read_text()); data['locale'] = 'de'; manifest.write_text(json.dumps(data))
        value['artifacts'] = [dict(path=str(manifest.relative_to(self.root)), sha256=hashed(manifest.read_bytes()))]
        baseline.write_text(json.dumps(value))
        with self.assertRaisesRegex(ValueError, 'Foreign owning editorial manifest'):
            list(retained_reviews(Evidence(self.root), 'ja'))

    def test_named_editorial_handoff_rejects_changed_glossary(self):
        self.editorial_handoff()
        (self.root / 'localization/glossary/ja.json').write_text('{"changed":true}')
        with self.assertRaisesRegex(ValueError, 'Stale evidence'):
            list(retained_reviews(Evidence(self.root), 'ja'))

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

    def test_static_complete_producer_outcome_retains_actual_review_coverage(self):
        self.test_real_collector_deduplicates_receipts_and_invalidates_changed_target()
        corpus=self.root/'localization/ja-assets/dialogue.ja.jsonl'
        row=json.loads(corpus.read_text());row['target']='A';corpus.write_text(json.dumps(row))
        status=self.root/'outputs/locale-assets-20261026/ja/workflow-v3-completion-20261030/status.json'
        state=json.loads(status.read_text());path=Path(state['phases'][0]['phase'])/'result.json';result=json.loads(path.read_text())
        for outcome in ('blocked','static-complete'):
            result['outcome']=outcome;path.write_text(json.dumps(result));state['phases'][0]['resultSha256']=hashed(path.read_bytes());status.write_text(json.dumps(state))
            measured=collect_locale(Evidence(self.root),dict(families=[dict(id='dialogue')]),'ja',dict(dialogue={'one'}))
            self.assertEqual(measured['families'][0]['reviewed'],1)

    def test_nonlinguistic_integration_review_does_not_erase_matching_wording_pass(self):
        self.test_real_collector_deduplicates_receipts_and_invalidates_changed_target()
        corpus=self.root/'localization/ja-assets/dialogue.ja.jsonl';wording=json.loads(corpus.read_text());wording['target']='A';corpus.write_text(json.dumps(wording))
        base='outputs/locale-assets-20261026/ja/workflow-v3-completion-20261030/0002-review'
        packet,digest=self.write(base+'/packet.jsonl',wording)
        self.write(base+'/task.json',dict(task=dict(kind='review',reviewPacket=str(packet),reviewPacketSha256=digest)))
        status=self.root/'outputs/locale-assets-20261026/ja/workflow-v3-completion-20261030/status.json';state=json.loads(status.read_text())
        phase=dict(number=2,kind='review',phase=str(packet.parent));state['phases'].append(phase)
        for extra,expected in [(dict(notLinguisticCoverage=True,verdict='pass'),1),(dict(verdict='finding'),0)]:
            review=packet.parent/'reviews.jsonl';review.write_text(json.dumps(dict(id='one',sourceSha256=hashed(b'English'),targetSha256=hashed(b'A'),rationale='Explicit fixture judgment',**extra))+'\n')
            result,result_sha=self.write(base+'/result.json',dict(outcome='blocked',reviews=str(review),evidence=[dict(path=str(review),sha256=hashed(review.read_bytes()))]))
            phase['resultSha256']=result_sha;status.write_text(json.dumps(state))
            measured=collect_locale(Evidence(self.root),dict(families=[dict(id='dialogue')]),'ja',dict(dialogue={'one'}))
            self.assertEqual(measured['families'][0]['reviewed'],expected)

    def test_final_resource_acceptance_completes_partial_milestones(self):
        policy=dict(components=[dict(id='resource-bindings',stage='resources',points=6,families=['one'],numerator='resourceBound'),
            dict(id='resource-saved',stage='resources',points=2),dict(id='resources',stage='resources',points=2)],requiredGates=['resources'])
        rows=[dict(id='one',expected=10,resourceBound=5)]
        self.assertEqual(calculate_score(policy,rows,{'resource-saved'})['percent'],5)
        self.assertEqual(calculate_score(policy,rows,{'resources'})['percent'],10)

    def test_preservation_is_a_version_bound_disposition_never_a_linguistic_pass(self):
        self.test_real_collector_deduplicates_receipts_and_invalidates_changed_target()
        corpus=self.root/'localization/ja-assets/dialogue.ja.jsonl';row=json.loads(corpus.read_text())
        row.update(target='English',status='preserved-detached-source');corpus.write_text(json.dumps(row))
        def measure(mask):
            return collect_locale(Evidence(self.root),dict(families=[dict(id='dialogue')]),'ja',dict(dialogue={'one'}),mask)['families'][0]
        for mask in ({},{'one':hashed(b'Other source')}):
            self.assertEqual(measure(mask)['resolved'],0)
        accepted=measure({'one':hashed(b'English')})
        self.assertEqual((accepted['drafted'],accepted['reviewed'],accepted['preserved'],accepted['resolved'],accepted['reviewResolved']),(0,0,1,1,1))
        row['target']='A';corpus.write_text(json.dumps(row))
        self.assertEqual(measure({'one':hashed(b'English')})['preserved'],0)

    def test_affirmative_primary_preservation_requires_exact_version_and_explicit_judgment(self):
        self.test_real_collector_deduplicates_receipts_and_invalidates_changed_target()
        corpus=self.root/'localization/ja-assets/dialogue.ja.jsonl';wording=json.loads(corpus.read_text());wording.update(target='English',status='preserved-detached-source');corpus.write_text(json.dumps(wording))
        base='outputs/locale-assets-20261026/ja/workflow-v3-completion-20261030/0002-review';packet,digest=self.write(base+'/packet.jsonl',wording)
        self.write(base+'/task.json',dict(task=dict(kind='review',reviewPacket=str(packet),reviewPacketSha256=digest)))
        status=self.root/'outputs/locale-assets-20261026/ja/workflow-v3-completion-20261030/status.json';state=json.loads(status.read_text());phase=dict(number=2,kind='review',phase=str(packet.parent));state['phases'].append(phase)
        judgment=dict(id='one',sourceSha256=hashed(b'English'),targetSha256=hashed(b'English'),verdict='context-only-preserve',
            reviewed=True,notLinguisticCoverage=True,targetEdited=False,sourceDisposition='preserved-detached-source',rationale='Affirmative exact original preservation')
        for delta,expected in [({},1),(dict(reviewed=False),0),(dict(targetEdited=True),0),(dict(verdict='held-source'),0)]:
            reviews,review_sha=self.write(base+'/reviews.jsonl',dict(judgment,**delta))
            result,result_sha=self.write(base+'/result.json',dict(outcome='blocked',reviews=str(reviews),evidence=[dict(path=str(reviews),sha256=review_sha)]))
            phase['resultSha256']=result_sha;status.write_text(json.dumps(state))
            measured=collect_locale(Evidence(self.root),dict(families=[dict(id='dialogue')]),'ja',dict(dialogue={'one'}))['families'][0]
            self.assertEqual(measured['preserved'],expected);self.assertEqual(measured['reviewed'],0)
        # A later genuine semantic finding must invalidate the matching
        # preservation too; a disposition is not permanent immunity to findings.
        reviews,review_sha=self.write(base+'/reviews.jsonl',judgment)
        result,result_sha=self.write(base+'/result.json',dict(outcome='blocked',reviews=str(reviews),evidence=[dict(path=str(reviews),sha256=review_sha)]))
        phase['resultSha256']=result_sha
        following=base.replace('0002-review','0003-review')
        self.write(following+'/task.json',dict(task=dict(kind='review',reviewPacket=str(packet),reviewPacketSha256=digest)))
        finding,finding_sha=self.write(following+'/reviews.jsonl',dict(id='one',sourceSha256=hashed(b'English'),targetSha256=hashed(b'English'),verdict='finding',reviewed=True,rationale='Concrete target preservation defect'))
        result,result_sha=self.write(following+'/result.json',dict(outcome='blocked',reviews=str(finding),evidence=[dict(path=str(finding),sha256=finding_sha)]))
        status.write_text(json.dumps(state))
        before=collect_locale(Evidence(self.root),dict(families=[dict(id='dialogue')]),'ja',dict(dialogue={'one'}))
        self.assertEqual(before['families'][0]['preserved'],1)
        state['phases'].append(dict(number=3,kind='review',phase=str(finding.parent),resultSha256=result_sha));status.write_text(json.dumps(state))
        after=collect_locale(Evidence(self.root),dict(families=[dict(id='dialogue')]),'ja',dict(dialogue={'one'}))
        self.assertEqual(after['families'][0]['preserved'],0)

    def test_owner_accepted_russian_reference_is_100_without_transferring_native_proof(self):
        artifact,artifact_sha=self.write('reference.json',dict(candidate='ru-build'))
        source,source_sha=self.write('source.json',dict(source='fixed'))
        masks,mask_sha=self.write('preservation.json',dict(records=[dict(id='one',mode='whole-field',sourceSha256=hashed(b'Original'))]))
        self.write('ru-build/build.json',dict(sourceManifestSha256=source_sha,overlay=dict(overlayAndGuardHashes={'preservation.json':mask_sha})))
        self.write('owner.json',dict(authority='owner',accepted=True,locale='ru',statement='Accepted reference',
            sharedMechanismReuseAllowed=True,targetLocaleAcceptanceGranted=False,build='ru-build',
            artifact=dict(path='reference.json',sha256=artifact_sha),sourceManifest=dict(path='source.json',sha256=source_sha)))
        self.write('localization/completion/progress-policy.json',dict(revision='test',meaning='fixture',ownerBaseline='owner.json',
            preservationManifest='preservation.json',sourcePins={},families=[],components=[dict(id='scope',points=100)],requiredGates=['runtime']))
        self.write('localization/source/shared-source-completion-20261028/admission-v1/manifest.json',dict(commonSourceAccepted=False,translationEntryAllowed=False))
        result=report(self.root,'ru');reference=result['locales'][0]
        self.assertEqual(reference['percent'],100);self.assertTrue(reference['deliveryAccepted'])
        self.assertFalse(reference['releaseReady']);self.assertEqual(result['referenceBenchmark']['percent'],100)
        artifact.write_text('changed')
        with self.assertRaisesRegex(ValueError,'Stale evidence'):report(self.root,'ru')

    def resource_fixture(self,physical=2):
        id_='ds:1:2:Dialogue Text';wording=dict(id=id_,source='Original',target='Own target')
        key=version(wording)
        def pin(path):return dict(path=str(path.relative_to(self.root)),sha256=hashed(path.read_bytes()))
        assets=['left.assets','right.bundle'][:physical]
        plan,plan_sha=self.write('recipe/plan.json',dict(locale='ja',edits=[dict(wording,asset=name,pathId=i,pointer='/text') for i,name in enumerate(assets)]))
        config,config_sha=self.write('recipe/config.json',dict(locales=dict(ja=dict(plan='plan.json'))))
        recipe,recipe_sha=self.write('recipe/manifest.json',dict(files={'config.json':config_sha,'plan.json':plan_sha}))
        outputs={}
        for name in assets:
            path=self.root/'saved'/name;path.parent.mkdir(exist_ok=True);path.write_bytes(b'saved candidate bytes '+name.encode())
            outputs[name]=dict(sha256=hashed(path.read_bytes()),bytes=path.stat().st_size)
        manifest,digest=self.write('saved/manifest.json',dict(kind='composed-sparse-target-resource-candidate',locale='ja',frozenRecipeSha256=recipe_sha,outputs=outputs))
        row=dict(locale='ja',families=[dict(id='dialogue',expected=1,drafted=1,reviewed=1)],
            _acceptedVersions={id_:key},_familyIds={'dialogue':{id_}},_resourceRefs={str(recipe.relative_to(self.root)):recipe_sha})
        policy=dict(resourceCandidates=dict(ja=[dict(path=str(manifest.relative_to(self.root)),sha256=digest)]))
        return row,policy

    def test_resource_credit_needs_both_saved_bindings_and_matching_target(self):
        row,policy=self.resource_fixture(1);ev=Evidence(self.root)
        self.assertFalse(resources(ev,policy,row));self.assertEqual(row['families'][0]['resourceBound'],0)
        row,policy=self.resource_fixture(2);ev=Evidence(self.root)
        self.assertTrue(resources(ev,policy,row));self.assertEqual(row['families'][0]['resourceBound'],1)
        self.assertFalse(row['resources']['nativeAccepted']);self.assertFalse(row['resources']['completePackageAccepted'])
        row,policy=self.resource_fixture(2);row['_acceptedVersions']={}
        self.assertFalse(resources(Evidence(self.root),policy,row))
        row,policy=self.resource_fixture(2);(self.root/'saved/right.bundle').write_bytes(b'changed')
        ev=Evidence(self.root);self.assertFalse(resources(ev,policy,row));self.assertTrue(any('Stale evidence' in e for e in ev.errors))

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
