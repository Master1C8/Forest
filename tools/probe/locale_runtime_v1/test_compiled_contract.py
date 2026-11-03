"""Actual version/preservation/editorial boundaries; no game or model is replaced by a pass."""
import hashlib
import json
from pathlib import Path
import tempfile
import unittest

from compiled_contract import empty_inventory_wording, resource_manifest, sha, text_gate


class CompiledContractTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.source = [dict(id=str(i), source='source '+str(i)) for i in range(14606)]
        self.protected = {r['id']: hashlib.sha256(r['source'].encode()).hexdigest() for r in self.source[:1781]}
        self.language = dict(locale='hu', culture='hu', translations={r['id']: dict(source=r['source'], target=r['source'] if r['id'] in self.protected else 'synthetic '+r['id']) for r in self.source})
        self.reviews = [dict(id=r['id'], sourceSha256=hashlib.sha256(r['source'].encode()).hexdigest(),
                             targetSha256=hashlib.sha256(self.language['translations'][r['id']]['target'].encode()).hexdigest(),
                             verdict='pass', rationale='Synthetic fixture judgment', reviewerThreadId='independent',
                             model='gpt-6.1-sol', reasoning='high', provider='openai') for r in self.source[1781:]]
        self.put('source.jsonl', self.source, lines=True)
        self.put('preservation.json', dict(baselinePreserved=self.protected))
        self.put('context.json', dict(contextComplete=True))
        self.put('glossary.json', {})
        self.acceptance = dict(format='forest-final-text-acceptance-v1', locale='hu', contextComplete=True,
                               sourcePacket=self.pin('source.jsonl'), preservation=self.pin('preservation.json'),
                               authorThreadIds=['author'], contextReceipts=[self.pin('context.json')],
                               glossaryPins=[self.pin('glossary.json')])
        self.refresh()

    def put(self, name, value, lines=False):
        (self.root/name).write_text((''.join(json.dumps(r)+'\n' for r in value) if lines else json.dumps(value)))

    def pin(self, name):
        return dict(path=name, sha256=sha(self.root/name))

    def refresh(self):
        self.put('language.json', self.language)
        self.put('reviews.jsonl', self.reviews, lines=True)
        self.acceptance.update(language=self.pin('language.json'), independentReviews=self.pin('reviews.jsonl'))
        self.put('acceptance.json', self.acceptance)
        self.config = dict(locale='hu', culture='hu', compiledLanguage=self.pin('language.json'), textAcceptance=self.pin('acceptance.json'))

    def test_matching_positive_control_and_stale_current_target(self):
        self.assertEqual(text_gate(self.root,self.config)['ordinary'],12825)
        self.language['translations']['14605']['target']='materially changed'
        self.refresh()
        with self.assertRaisesRegex(ValueError,'stale independent'):text_gate(self.root,self.config)

    def test_actual_finding_and_self_review_reject(self):
        self.assertTrue(text_gate(self.root,self.config)['passed'])
        self.reviews[-1]['verdict']='finding';self.refresh()
        with self.assertRaisesRegex(ValueError,'Open finding'):text_gate(self.root,self.config)
        self.reviews[-1]['verdict']='pass';self.reviews[-1]['reviewerThreadId']='author';self.refresh()
        with self.assertRaisesRegex(ValueError,'reviewer identity'):text_gate(self.root,self.config)

    def test_missing_duplicate_and_unread_context_reject_after_earlier_guards(self):
        self.reviews[-1]=dict(self.reviews[-2]);self.refresh()
        with self.assertRaisesRegex(ValueError,'coverage'):text_gate(self.root,self.config)
        self.setUpForContext()

    def setUpForContext(self):
        # Restore the sole overwritten synthetic row without changing the version contract.
        ident='14605';v=self.language['translations'][ident]
        self.reviews[-1]=dict(self.reviews[-2],id=ident,sourceSha256=hashlib.sha256(v['source'].encode()).hexdigest(),targetSha256=hashlib.sha256(v['target'].encode()).hexdigest())
        self.refresh();self.assertTrue(text_gate(self.root,self.config)['passed'])
        self.acceptance['contextComplete']=False;self.refresh()
        with self.assertRaisesRegex(ValueError,'editorial closure'):text_gate(self.root,self.config)

    def test_protected_mutation_and_hash_drift_reject(self):
        self.language['translations']['0']['target']='changed';self.refresh()
        with self.assertRaisesRegex(ValueError,'Protected'):text_gate(self.root,self.config)
        self.language['translations']['0']['target']='source 0';self.refresh()
        self.assertTrue(text_gate(self.root,self.config)['passed'])
        (self.root/'reviews.jsonl').write_text('')
        with self.assertRaisesRegex(ValueError,'input changed'):text_gate(self.root,self.config)

    def test_compiler_manifest_positive_and_wrong_locale_or_resource(self):
        candidate=self.root/'candidate';candidate.mkdir();(candidate/'resource').write_bytes(b'exact saved resource')
        m=dict(format='forest-compiled-language-v1',locale='hu',culture='hu',languageSha256=self.config['compiledLanguage']['sha256'],files={'resource':dict(sha256=sha(candidate/'resource'))})
        (candidate/'manifest.json').write_text(json.dumps(m));self.assertEqual(resource_manifest(self.root,self.config,candidate)['outputs'],m['files'])
        m['locale']='nl';(candidate/'manifest.json').write_text(json.dumps(m))
        with self.assertRaisesRegex(ValueError,'Wrong compiled locale'):resource_manifest(self.root,self.config,candidate)
        m['locale']='hu';(candidate/'manifest.json').write_text(json.dumps(m));(candidate/'resource').write_bytes(b'other version')
        with self.assertRaisesRegex(ValueError,'resource changed'):resource_manifest(self.root,self.config,candidate)

    def test_current_managed_ids_bind_exact_original_empty_branches(self):
        method='System.Void TheForestOfLove.InventoryInfoTicker::OnCellSelected(TheForestOfLove.InventoryCellUiController)'
        data=dict(translations={f'managed:Managed/Assembly-CSharp.dll:{method}@{i}':dict(source=s,target='synthetic '+str(i))
                                for i,s in [(82,'SOMETHING?'),(83,'Nope, more nothing.'),(87,'Nothin’'),(88,'You’ve got a whole lot of it.')]})
        self.assertEqual([r['branch'] for r in empty_inventory_wording(data)],['010c','0111','011d','0122'])
        ident=f'managed:Managed/Assembly-CSharp.dll:{method}@82'
        data['translations'][ident]['source']='different original'
        with self.assertRaisesRegex(ValueError,'exact original inventory branch'):empty_inventory_wording(data)


if __name__=='__main__':unittest.main()
