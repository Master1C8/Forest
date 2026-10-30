"""Shared factory transport and real publisher tests; fixture judgments only."""
import copy
import json
from pathlib import Path
import tempfile
import unittest

import locale_resources as r


class ResourceTests(unittest.TestCase):
    def setUp(self):
        (r.ROOT/'outputs').mkdir(exist_ok=True)
        self.temp=tempfile.TemporaryDirectory(prefix='resource-factory-test-',dir=r.ROOT/'outputs')
        self.addCleanup(self.temp.cleanup)
        self.base=Path(self.temp.name)

    def pin(self,path):
        return dict(path=str(path.relative_to(r.ROOT)),sha256=r.sha(path.read_bytes()))

    def fixture(self,locale='fixture',physical=False,missing=False,conflict=False,unreviewed=False,folder_name=None):
        folder=self.base/(folder_name or locale);folder.mkdir()
        pages=[];members=[];packet=[]
        roles=['invisible-layout-provider','visible-face']+['visible-glow']*4
        for i in range(25):
            ids=[f'physical:{i}:{k}' for k in range(6)]
            pages.append(dict(id=f'page:{i}',source=f'Source {i}',family='scene',occurrenceIds=ids))
            for k,id_ in enumerate(ids):
                members.append(dict(id=id_,pageId=f'page:{i}',role=roles[k],original=dict(source=f'Source {i}'),
                    fontAsset='font',material='material',spriteAsset=None,fontColor={},fontSize=12,
                    layoutComponents=[],sourceSpan={},storedContext={}))
            for k,id_ in enumerate(ids if physical else [f'page:{i}']):
                if missing and i==0 and k==5:continue
                target=f'{locale}_{i}_e\u0301_漢'+('_conflict' if conflict and i==0 and k==1 else '')
                source=f'Source {i}'
                packet.append(dict(id=id_,source=source,target=target,sourceSha256=r.sha(source.encode()),targetSha256=r.sha(target.encode())))
        def save(name,value,lines=False):
            path=folder/name;path.write_bytes(r.jsonl(value) if lines else r.encode(value));return self.pin(path)
        pins=dict(sourcePages=save('pages.jsonl',pages,True),sourceMembers=save('members.jsonl',members,True),packet=save('packet.jsonl',packet,True))
        reviews=[dict(id=x['id'],sourceSha256=x['sourceSha256'],targetSha256=x['targetSha256'],verdict='pass',reviewed=not unreviewed,reviewerThreadId='reviewer') for x in packet]
        pins['reviews']=save('reviews.jsonl',reviews,True)
        pins['authorTask']=save('author-task.json',dict(job=dict(locale=locale),task=dict(kind='work')))
        pins['reviewerTask']=save('review-task.json',dict(job=dict(locale=locale),task=dict(kind='review',reviewPacket=pins['packet']['path'],reviewPacketSha256=pins['packet']['sha256'])))
        pins['authorResult']=save('author-result.json',dict(outcome='continue',evidence=[pins['packet']]))
        pins['reviewerResult']=save('review-result.json',dict(outcome='continue',reviews=pins['reviews']['path'],evidence=[pins['reviews']]))
        for role,thread in [('author','author'),('reviewer','reviewer')]:
            pins[role+'Runtime']=save(role+'-runtime.json',dict(threadId=thread,actualRuntime=dict(turn=dict(model='gpt-6.1-sol',effort='high'),session=dict(model_provider='openai',parent_thread_id=None))))
        profile=dict(schemaVersion=1,family='narrative150',locale=locale,inputs=pins,
            outputPrefix=str((folder/'out').relative_to(r.ROOT)),publisher=self.pin(r.ROOT/r.PUBLISHER))
        path=folder/'profile.json';path.write_bytes(r.encode(profile))
        return path,profile,folder/'out/delivery'

    def test_all_six_locales_use_the_same_algorithm_and_preserve_full_workload(self):
        for locale in ['zh','es','es-419','pt-BR','ja','de']:
            path,profile,out=self.fixture(locale)
            result=r.run(path,locale,out)
            self.assertEqual(result['counts']['reviewedSelectors'],150)
            self.assertEqual(result['counts']['roles'],dict({'layout-provider':25,'face':25,'glow':100}))
            pages=[r.parse(line) for line in (out/'pages25.jsonl').read_bytes().splitlines()]
            self.assertTrue(all(p['locale']==locale and p['target'].startswith(locale+'_') for p in pages))
            self.assertTrue(all(p['ready'] is False and p['applicationAllowed'] is False for p in pages))
            r.run(path,locale,out,'check')

    def test_wrong_locale_fails_before_source_reads_or_output(self):
        path,profile,out=self.fixture('one')
        profile['inputs']['packet']['path']='missing'
        path.write_bytes(r.encode(profile))
        with self.assertRaisesRegex(ValueError,'explicit-locale'):r.run(path,'other',out)
        self.assertFalse(out.exists())

    def test_another_locales_owning_job_is_rejected(self):
        path,profile,out=self.fixture()
        p=r.ROOT/profile['inputs']['authorTask']['path']
        data=r.parse(p.read_bytes());data['job']['locale']='another';p.write_bytes(r.encode(data))
        profile['inputs']['authorTask']=self.pin(p);path.write_bytes(r.encode(profile))
        with self.assertRaisesRegex(ValueError,'owning-locale'):r.run(path,'fixture',out)
        self.assertFalse(out.exists())

    def test_unreviewed_rows_do_not_acquire_a_resource_pass(self):
        path,profile,out=self.fixture(unreviewed=True)
        with self.assertRaisesRegex(ValueError,'unaccepted-wording'):r.run(path,'fixture',out)
        self.assertFalse(out.exists())

    def test_stale_receipt_and_self_consistent_changed_wording_fail(self):
        path,profile,out=self.fixture()
        p=r.ROOT/profile['inputs']['packet']['path'];rows=[r.parse(x) for x in p.read_bytes().splitlines()]
        rows[0]['target']='changed';rows[0]['targetSha256']=r.sha(b'changed');p.write_bytes(r.jsonl(rows))
        profile['inputs']['packet']=self.pin(p)
        task=r.ROOT/profile['inputs']['reviewerTask']['path'];value=r.parse(task.read_bytes());value['task']['reviewPacketSha256']=profile['inputs']['packet']['sha256'];task.write_bytes(r.encode(value));profile['inputs']['reviewerTask']=self.pin(task)
        result=r.ROOT/profile['inputs']['authorResult']['path'];result.write_bytes(r.encode(dict(outcome='continue',evidence=[profile['inputs']['packet']])));profile['inputs']['authorResult']=self.pin(result)
        path.write_bytes(r.encode(profile))
        with self.assertRaisesRegex(ValueError,'wording-review-version'):r.run(path,'fixture',out)
        self.assertFalse(out.exists())

    def test_conflicting_glow_targets_reject_after_valid_review_binding(self):
        path,profile,out=self.fixture(physical=True,conflict=True)
        with self.assertRaisesRegex(ValueError,'conflicting-six-layer-wording'):r.run(path,'fixture',out)
        self.assertFalse(out.exists())

    def test_partial_memberships_remain_explicitly_partial(self):
        path,profile,out=self.fixture(physical=True,missing=True)
        result=r.run(path,'fixture',out)
        self.assertEqual(result['counts']['reviewedSelectors'],149)
        self.assertEqual(result['counts']['pendingSelectors'],1)
        pages=[r.parse(line) for line in (out/'pages25.jsonl').read_bytes().splitlines()]
        self.assertEqual(pages[0]['wordingCoverage'],'partial')
        requirements=[r.parse(line) for line in (out/'requirements.jsonl').read_bytes().splitlines()]
        self.assertTrue(all(x['cmapCheck']=='not-run' and x['nativeAccepted'] is False for x in requirements))

    def test_disjoint_reviewed_packets_accumulate_without_rereview_or_receipt_copy(self):
        path,profile,out=self.fixture('de',physical=True)
        _,other,_=self.fixture('de',physical=True,folder_name='de-later')
        for group,chosen in [(profile['inputs'],slice(0,78)),(other['inputs'],slice(78,None))]:
            for key in ['packet','reviews']:
                p=r.ROOT/group[key]['path'];lines=p.read_bytes().splitlines()[chosen]
                p.write_bytes(b'\n'.join(lines)+b'\n');group[key]=self.pin(p)
            for key,value in [('authorResult',dict(outcome='continue',evidence=[group['packet']])),
                              ('reviewerResult',dict(outcome='continue',reviews=group['reviews']['path'],evidence=[group['reviews']])),
                              ('reviewerTask',dict(job=dict(locale='de'),task=dict(kind='review',reviewPacket=group['packet']['path'],reviewPacketSha256=group['packet']['sha256'])))]:
                p=r.ROOT/group[key]['path'];p.write_bytes(r.encode(value));group[key]=self.pin(p)
        profile['wordingPackets']=[profile['inputs'].copy(),other['inputs'].copy()]
        path.write_bytes(r.encode(profile));result=r.run(path,'de',out)
        self.assertEqual(result['counts']['preparedPages'],25)
        self.assertEqual(result['counts']['reviewedSelectors'],150)
        selectors=[r.parse(x) for x in (out/'selectors150.jsonl').read_bytes().splitlines()]
        self.assertEqual(sum(x['wordingReceipt']['file']==other['inputs']['reviews'] for x in selectors),72)
        r.run(path,'de',out,'check')

    def test_overlapping_packets_reject_instead_of_silently_choosing_a_version(self):
        path,profile,out=self.fixture()
        profile['wordingPackets']=[profile['inputs'],profile['inputs']]
        path.write_bytes(r.encode(profile))
        with self.assertRaisesRegex(ValueError,'overlapping-wording-selector'):r.run(path,'fixture',out)
        self.assertFalse(out.exists())

    def test_real_interruption_resumes_same_partial_directory_without_rewriting(self):
        path,profile,out=self.fixture()
        with self.assertRaisesRegex(InterruptedError,'injected-after-completed-output'):
            r.run(path,'fixture',out,fail_after=2)
        self.assertFalse((out/'manifest.json').exists())
        prior={p:(p.read_bytes(),p.stat().st_ino) for p in out.iterdir() if p.is_file()}
        self.assertEqual(len(prior),2)
        r.run(path,'fixture',out,'resume')
        self.assertEqual(prior,{p:(p.read_bytes(),p.stat().st_ino) for p in prior})
        r.run(path,'fixture',out,'check')
        with self.assertRaisesRegex(ValueError,'published-manifest-immutable'):r.run(path,'fixture',out)

    def test_conflicting_partial_resume_writes_no_further_files(self):
        path,profile,out=self.fixture()
        with self.assertRaises(InterruptedError):r.run(path,'fixture',out,fail_after=2)
        p=next(out.iterdir());p.write_bytes(b'conflicting-owner-content')
        before={p:p.read_bytes() for p in out.iterdir()}
        with self.assertRaisesRegex(ValueError,'conflicting-partial-output'):r.run(path,'fixture',out,'resume')
        self.assertEqual(before,{p:p.read_bytes() for p in out.iterdir()})


if __name__=='__main__':unittest.main()
