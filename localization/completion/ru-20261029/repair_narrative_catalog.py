"""Finalize the delivered narrative candidate against its last promoted bundle."""
import ast
import base64
import gc
import hashlib
import importlib.util
import json
from pathlib import Path
import shutil
import struct
import sys

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
CANDIDATE = ROOT/'localization/previews/ru-20261029-narrative42-01'
BASELINE = ROOT/'localization/previews/ru-20261029-pause434-01'
SOURCE = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')
DATA_NAME = 'The Forest of Love_Data'
BUNDLE = 'StreamingAssets/aa/StandaloneWindows64/defaultlocalgroup_assets_all_298c5a4d1d1846b1a8d2c7d5da3f319c.bundle'
OUT = ROOT/'outputs/ru-manual-test-handoff-20261029'


def sha(path):
    h = hashlib.sha256()
    with path.open('rb') as stream:
        for block in iter(lambda:stream.read(1024**2),b''):
            h.update(block)
    return h.hexdigest()


def encoded(value):
    return (json.dumps(value,ensure_ascii=False,indent=2)+'\n').encode()


def options(path):
    data = base64.b64decode(json.loads(path.read_bytes())['m_ExtraDataString'])
    cursor = 0
    selected = []
    while cursor < len(data):
        assert data[cursor] == 7
        cursor += 1
        for _ in range(2):
            length = data[cursor]
            cursor += 1+length
        size = struct.unpack_from('<I',data,cursor)[0]
        cursor += 4
        row = json.loads(data[cursor:cursor+size].decode('utf-16le'))
        cursor += size
        if row['m_Hash'] == '298c5a4d1d1846b1a8d2c7d5da3f319c':
            selected.append(row)
    assert cursor == len(data) and len(selected) == 1
    return selected[0]


def atomic(path, data):
    temp = path.with_name(path.name+'.manual-finalization.pending')
    with temp.open('xb') as stream:
        stream.write(data)
    temp.replace(path)


def commit_pair(catalog, report, catalog_bytes, report_bytes, expected, *, fail=False):
    assert sha(catalog) == expected[0], 'catalog-changed-before-commit'
    assert sha(report) == expected[1], 'report-changed-before-commit'
    atomic(catalog,catalog_bytes)
    if fail:
        raise RuntimeError('injected-after-catalog-before-report')
    atomic(report,report_bytes)


def main():
    assert not (OUT/'catalog-finalization.json').exists(), 'reconcile-existing-finalization'
    sys.path.insert(0,str(ROOT/'tools'))
    from addressables_catalog import update_catalog, bundle_crc
    spec = importlib.util.spec_from_file_location('manual_process_check',ROOT/'tools/probe/chapter_gallery_process.py')
    process = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(process)
    assert not process.observations(CANDIDATE), 'owner-test-already-running'
    assert not list((CANDIDATE/'game').rglob('tfol.*')), 'owner-progress-already-created'
    data = CANDIDATE/'game'/DATA_NAME
    catalog = data/'StreamingAssets/aa/catalog.json'
    report = CANDIDATE/'build.json'
    expected = [sha(catalog),sha(report)]
    assert expected[1] == '06aa7f62d4b4864e5df09a71e9d60366ad1893f93aa906638fe830c7caebf449'
    assert sha(data/BUNDLE) == 'e4394dc01e391feec8f809dc6e5744dd44e29edca67481c36d3e2d6c034adffc'
    old = json.loads(report.read_bytes())
    assert old['addressables']['catalogSha256'] == expected[0]
    old_options = options(catalog)
    assert old_options['m_Crc'] == int(old['addressables']['rebuiltCrc32'],16)
    # Exercise the actual final production assignment on actual final payload
    # bytes in a small task-owned sandbox; no game copy or renderer substitute.
    tree = ast.parse((ROOT/'tools/build_russian_preview.py').read_text())
    method = next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name == 'main')
    blocks = [n for n in method.body if isinstance(n,ast.If) and isinstance(n.test,ast.Attribute) and n.test.attr == 'narrative_display_case']
    assignment = blocks[-1].body[-1]
    assert isinstance(assignment,ast.Assign) and isinstance(assignment.value,ast.Call) and assignment.value.func.id == 'update_catalog'
    fragment = ast.Module(body=[assignment],type_ignores=[])
    ast.fix_missing_locations(fragment)
    sandbox = OUT/'actual-final-catalog-block'
    (sandbox/Path(BUNDLE).parent).mkdir(parents=True)
    (sandbox/BUNDLE).symlink_to(data/BUNDLE)
    namespace = dict(SOURCE=SOURCE,DATA_NAME=DATA_NAME,BUNDLE=BUNDLE,target=sandbox,report={},update_catalog=update_catalog)
    exec(compile(fragment,str(ROOT/'tools/build_russian_preview.py'),'exec'),namespace)
    final = namespace['report']['addressables']
    new_catalog = (sandbox/'StreamingAssets/aa/catalog.json').read_bytes()
    new_options = options(sandbox/'StreamingAssets/aa/catalog.json')
    gc.collect()
    actual_crc = bundle_crc(data/BUNDLE)
    assert new_options['m_Crc'] == actual_crc == int(final['rebuiltCrc32'],16)
    assert new_options['m_BundleSize'] == (data/BUNDLE).stat().st_size
    assert old_options['m_Crc'] != new_options['m_Crc'], 'reported-final-bundle-regression-not-exercised'
    assert {k:v for k,v in old_options.items() if k not in ['m_Crc','m_BundleSize']} == {k:v for k,v in new_options.items() if k not in ['m_Crc','m_BundleSize']}
    assert new_options['m_UseCrcForCachedBundles'] is True and new_options['m_UseUWRForLocalBundles'] is False
    gc.collect()
    prior_catalog = OUT/'unchanged-without-narrative.catalog.json'
    update_catalog(SOURCE/DATA_NAME/'StreamingAssets/aa/catalog.json',prior_catalog,SOURCE/DATA_NAME/BUNDLE,BASELINE/'game'/DATA_NAME/BUNDLE)
    assert prior_catalog.read_bytes() == (BASELINE/'game'/DATA_NAME/'StreamingAssets/aa/catalog.json').read_bytes()
    # Removing all narrative opt-in additions still yields the exact prior AST.
    class Strip(ast.NodeTransformer):
        def visit_If(self,node):
            if isinstance(node.test,ast.Attribute) and node.test.attr == 'narrative_display_case':
                return None
            return self.generic_visit(node)
        def visit_Expr(self,node):
            call = node.value
            if isinstance(call,ast.Call) and isinstance(call.func,ast.Attribute) and call.func.attr == 'add_argument' and call.args and isinstance(call.args[0],ast.Constant) and call.args[0].value == '--narrative-display-case':
                return None
            return node
    before = ast.parse((ROOT/'outputs/ru-narrative42-application-20261029/build_russian_preview.before.py').read_text())
    assert ast.dump(Strip().visit(tree),include_attributes=False) == ast.dump(before,include_attributes=False)
    updated = dict(old,addressables=final)
    updated['postBuildFinalization'] = dict(kind='final-bundle-addressables-crc-and-size',beforeBuildSha256=expected[1],
        recipe=str(Path(__file__).relative_to(ROOT)),recipeSha256=sha(Path(__file__)),
        canonicalBuilderSha256=sha(ROOT/'tools/build_russian_preview.py'),
        executedBuildSnapshotPreserved=True,gamePayloadsChanged=False,
        boundary='Catalog then report are individually atomic. Interrupted pair requires exact-state reconciliation;no multi-file rollback. No owner launch before success receipt.')
    new_report = encoded(updated)
    for name,fail in [('interrupted-pair-control',True),('complete-pair-control',False)]:
        folder = OUT/name
        folder.mkdir()
        cat,rep = folder/'catalog.json',folder/'build.json'
        cat.write_bytes(catalog.read_bytes());rep.write_bytes(report.read_bytes())
        if fail:
            try:
                commit_pair(cat,rep,new_catalog,new_report,expected,fail=True)
            except RuntimeError as error:
                assert str(error) == 'injected-after-catalog-before-report'
            else:
                raise AssertionError('failure-not-injected')
            assert cat.read_bytes() == new_catalog and sha(rep) == expected[1]
            try:
                commit_pair(cat,rep,new_catalog,new_report,expected)
            except AssertionError as error:
                assert str(error) == 'catalog-changed-before-commit'
            else:
                raise AssertionError('partial-retry-not-rejected')
        else:
            commit_pair(cat,rep,new_catalog,new_report,expected)
            assert cat.read_bytes() == new_catalog and rep.read_bytes() == new_report
    (OUT/'catalog-commit-intent.json').write_bytes(encoded(dict(before=expected,after=[hashlib.sha256(new_catalog).hexdigest(),hashlib.sha256(new_report).hexdigest()])))
    commit_pair(catalog,report,new_catalog,new_report,expected)
    assert catalog.read_bytes() == new_catalog and report.read_bytes() == new_report
    result = dict(status='final-catalog-matches-final-narrative-bundle',oldOptions=old_options,newOptions=new_options,
        beforeBuildSha256=expected[1],afterBuildSha256=sha(report),catalogSha256=sha(catalog),bundleSha256=sha(data/BUNDLE),
        actualProductionBlockExercised=True,noNarrativeCatalogUnchanged=True,noNarrativeASTUnchanged=True,
        failureBetweenCatalogAndReportVerified=True,partialBlindRetryRejected=True,
        gamePayloadsUnchanged=True,ownerSaveFilesPresent=False,wholeGameReleaseAccepted=False)
    (OUT/'catalog-finalization.json').write_bytes(encoded(result))
    print(json.dumps(dict(status=result['status'],oldCrc=old_options['m_Crc'],newCrc=new_options['m_Crc'],buildSha256=sha(report))))


if __name__ == '__main__':
    main()
