"""Real pinned-file transport/publisher tests; no semantic or engine acceptance."""
import json
from pathlib import Path
import tempfile
import unittest

import locale_build as build
from locale_queue import sha


class LocaleBuildTests(unittest.TestCase):
    def setUp(self):
        self.tmp=tempfile.TemporaryDirectory();self.addCleanup(self.tmp.cleanup)
        self.root=Path(self.tmp.name).resolve()

    def put(self, name, value):
        p=self.root/name;p.parent.mkdir(parents=True,exist_ok=True)
        p.write_bytes(value if isinstance(value,bytes) else (json.dumps(value)+'\n').encode())
        return p

    def pin(self, p):return dict(path=str(p.relative_to(self.root)),sha256=sha(p))

    def fixture(self, locale='zh'):
        recipe_file=self.put('recipe/config.json',dict(frozen=True))
        recipe=self.put('recipe/manifest.json',dict(files={'config.json':sha(recipe_file)}))
        asset=self.put('saved/resources.assets',b'original serialized candidate')
        readback=self.put('saved/readback.json',dict(locale=locale))
        candidate=self.put('saved/manifest.json',dict(locale=locale,frozenRecipeSha256=sha(recipe),
            outputs={p.name:dict(sha256=sha(p),bytes=p.stat().st_size) for p in [asset,readback]},
            sourceCompanions={},remaining=['Native/runtime acceptance not run']))
        check=self.put('saved/check.json',dict(passed=True,locale=locale,allPriorAndUnselectedObjectsExact=True))
        assembly=self.put('managed/Assembly-CSharp.dll',b'exact assembly')
        helper=self.put('managed/VNRevivalLocaleDisplay.dll',b'exact helper')
        request=self.put('managed/request.json',dict(locale=locale,sourceSha256='a'*64,rows=[{'id':'saved'}]))
        managed=self.put('managed/readback.json',dict(passed=True,locale=locale,outputSha256=sha(assembly),helperSha256=sha(helper),
            sourceSha256='a'*64,selectedStrings=1,completeTreeReadback=True,completeOriginalSemanticTreeRestored=True))
        profile=self.put('profile.json',dict(schemaVersion=1,kind='locale-owned-saved-candidate',locale=locale,
            tooling=[],recipe=self.pin(recipe),serializedManifest=self.pin(candidate),serializedCheck=self.pin(check),
            assembly=self.pin(assembly),displayHelper=self.pin(helper),managedReadback=self.pin(managed),managedRequest=self.pin(request)))
        out=self.root/f'outputs/locale-assets-20261026/{locale}/candidate'
        return profile,out

    def test_six_locales_materialize_actual_bytes_without_acceptance(self):
        for locale in sorted(build.LOCALES):
            profile,out=self.fixture(locale)
            result=build.run(profile,locale,out,root=self.root)
            self.assertFalse(result['ready']);self.assertEqual(result['newModelRequests'],0)
            self.assertEqual((out/'resources.assets').read_bytes(),b'original serialized candidate')
            self.assertEqual((out/'Managed/Assembly-CSharp.dll').read_bytes(),b'exact assembly')
            marker=json.loads((out/'manifest.json').read_text())
            self.assertEqual(marker['semanticCoverageAdded'],0)
            self.assertEqual(marker['independentIntegrationReview'],'pending')
            build.run(profile,locale,out,mode='check',root=self.root)

    def test_own_locale_and_changed_actual_resource_fail_at_intended_boundary(self):
        profile,out=self.fixture()
        with self.assertRaisesRegex(ValueError,'build-explicit-locale'):
            build.run(profile,'de',self.root/'outputs/locale-assets-20261026/de/candidate',root=self.root)
        build.run(profile,'zh',out,root=self.root)
        self.put('saved/resources.assets',b'changed source output')
        with self.assertRaisesRegex(ValueError,'build-saved-resource:resources.assets'):
            build.run(profile,'zh',out,mode='check',root=self.root)

    def test_actual_partial_write_resumes_same_inode_and_conflict_rejects(self):
        profile,out=self.fixture()
        with self.assertRaisesRegex(InterruptedError,'injected-after-completed-output'):
            build.run(profile,'zh',out,root=self.root,fail_after=1)
        first=next(p for p in out.rglob('*') if p.is_file());inode=first.stat().st_ino
        self.assertFalse((out/'manifest.json').exists())
        build.run(profile,'zh',out,mode='resume',root=self.root)
        self.assertEqual(first.stat().st_ino,inode)
        build.run(profile,'zh',out,mode='check',root=self.root)
        with self.assertRaisesRegex(ValueError,'published-manifest-immutable'):
            build.run(profile,'zh',out,root=self.root)
        other=self.root/'outputs/locale-assets-20261026/zh/conflict'
        self.put(str(other.relative_to(self.root))+'/resources.assets',b'conflict')
        with self.assertRaisesRegex(ValueError,'conflicting-partial-output'):
            build.run(profile,'zh',other,mode='resume',root=self.root)

    def test_changed_recipe_and_foreign_output_do_not_publish(self):
        profile,out=self.fixture()
        self.put('recipe/config.json',dict(frozen=False))
        with self.assertRaisesRegex(ValueError,'build-recipe-dependency:config.json'):
            build.run(profile,'zh',out,root=self.root)
        self.assertFalse(out.exists())
        self.fixture()
        with self.assertRaisesRegex(ValueError,'build-output-outside-own-locale'):
            build.run(profile,'zh',self.root/'outputs/locale-assets-20261026/de/candidate',root=self.root)


if __name__=='__main__':unittest.main()
