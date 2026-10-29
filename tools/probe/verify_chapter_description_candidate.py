"""Bind the finite original chapter-description fixture to the new full QA build."""
import base64
import hashlib
import importlib.util
import json
from pathlib import Path

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
OLD = ROOT/'localization/previews/ru-20261029-chapter-gallery-02'
NEW = ROOT/'localization/previews/ru-20261029-pause434-01'
DATA = 'game/The Forest of Love_Data'
OUT = ROOT/'localization/completion/ru-20261029/pause434-chapter-native-admission.json'
BUNDLE = ROOT/'outputs/ru-chapter-runtime-binding-20261029/frozen-route-diagnostics-v7'


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def read(p):
    return json.loads(p.read_bytes())


def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


def main():
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    assert not OUT.exists(), 'new-admission-output-required'
    assert sha(OLD/'build.json') == '3dcfd4fb1ed8a4bc5e164c993c9d85e2e6e0c740303aa4105aecf93a13ac5143'
    build = read(NEW/'build.json')
    assert build['siteLocale'] == 'ru' and build['chapterGalleryCase'] and build['pauseChapterDisplayCase']
    assert build['pauseChapterDisplayProjection']['appliedStaticFields'] == 434
    assert build['bioInputDisplayProjection']['assigned'] == 185
    files = {r['path']:r['probeSha256'] for r in build['files']}
    assert len(files) == len(build['files']) == 14
    for name, expected in files.items():
        assert sha(NEW/DATA/name) == expected, name
    texture = read(NEW/'texture-preservation.json')
    assert texture['status'] == 'pass' and texture['originalTextureObjects'] == 1385
    assert texture['originalTextureContainers'] == 26 and texture['target'] == str(NEW/DATA)
    methods = ROOT/'outputs/ru-chapter-runtime-binding-20261029/pause434-method-compatibility.json'
    method = read(methods)
    assert method['status'] == 'selected-game-route-classes-identical'
    assert method['oldAssemblySha256'] == sha(OLD/DATA/'Managed/Assembly-CSharp.dll')
    assert method['newAssemblySha256'] == files['Managed/Assembly-CSharp.dll']
    assert len(method['classes']) == 14 and method['methods'] == method['bodies'] == 204
    extract = module('chapter_admission_extract', ROOT/'tools/extract_assets.py')
    decoder = module('chapter_admission_decoder', NEW/'decode_inventory.py')
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(NEW/DATA/'Managed'))
    envs = {}
    def objects(folder, name):
        key = (folder, name)
        if key not in envs:
            envs[key] = {o.path_id:o for o in UnityPy.load(str(folder/DATA/name)).objects}
        return envs[key]
    def db(folder):
        tree = extract.read_tree(objects(folder, 'resources.assets')[320], generator)
        payload = tree['m_Script'].encode('utf-8', errors='surrogateescape')
        result = {}
        for sheet in decoder.parse(payload)['sheets']:
            for field in sheet['fields']:
                if sheet['name'] not in ('Chapter', 'Movie') or field['name'] not in ('title', 'description', 'hint_phrase'):
                    continue
                raw = payload[field['valuesOffset']:field['valuesOffset']+field['valuesBytes']]
                values, _ = decoder.variable_cells(dict(field, valuesHex=raw.hex()), len(sheet['rowIds']))
                result[sheet['name'],field['name']] = values
        return result
    old_db, new_db = db(OLD), db(NEW)
    values = (BUNDLE/'cg-values.tsv').read_text().splitlines()
    assert len(values) == 129
    for line in values:
        ident, sheet, row, field, value = line.split('\t')
        expected = None if value == '~' else base64.b64decode(value)
        assert old_db[sheet,field][int(row)] == new_db[sheet,field][int(row)] == expected, ident
    # Complete native text objects are unchanged for both source-selected roles.
    selectors = [line.split('\t') for line in (BUNDLE/'cc-selectors.tsv').read_text().splitlines()]
    assert len(selectors) == 12
    stable = {int(row[3]) for row in selectors}
    matrix = [json.loads(line) for line in (ROOT/'localization/source/pause-chapter576-binding-contract-20261029/selector-binding-matrix.jsonl').read_text().splitlines()]
    route = {14452,14965,18354,18185,16862,17694,17682,15425,16273,16709,17332,17648,17659}
    for row in matrix:
        if int(row['id'].split(':')[1].split('/')[0]) not in route:
            continue
        stable.add(row['rectId'])
        for ancestor in row['ancestors']:
            stable.add(int(ancestor['object'].split(':')[1]))
            stable.update(int(x.split(':')[1]) for x in ancestor['controllers'])
    before, after = objects(OLD,'sharedassets2.assets'), objects(NEW,'sharedassets2.assets')
    for pid in sorted(stable):
        assert before[pid].get_raw_data() == after[pid].get_raw_data(), ('native-route-object', pid)
    targets = {r['id']:r['target'] for r in [json.loads(line) for line in (ROOT/'localization/supplemental-ui/20261029-pause-chapter-case576/revision-02/ru.prepared.jsonl').read_text().splitlines()]}
    assert extract.read_tree(after[17682], generator)['m_text'] == targets['sharedassets2.assets:17682/m_text']
    # Preserve concrete ordinary/fallback/fictional font and atlas bindings.
    fonts = {'resources.assets':[1017,439], 'sharedassets0.assets':[3323,7,3324,3,245]}
    for asset, ids in fonts.items():
        a,b = objects(OLD,asset),objects(NEW,asset)
        for pid in ids:
            assert a[pid].get_raw_data() == b[pid].get_raw_data(), ('font-resource',asset,pid)
    acceptance = ROOT/'localization/supplemental-ui/20261029-chapter-gallery-case/ru.acceptance.json'
    evidence = [methods,ROOT/'tools/probe/ChapterRuntimeCompatibility.cs',ROOT/'tools/probe/ChapterRuntimeCompatibility.csproj',
                Path(__file__),NEW/'texture-preservation.json',NEW/'build.json',BUNDLE/'cg-values.tsv',BUNDLE/'cc-selectors.tsv',
                acceptance,ROOT/'localization/supplemental-ui/20261029-pause-chapter-case576/revision-02/ru.acceptance.json']
    result = dict(status='bounded-description-candidate-static-admission', locale='ru',
                  candidate=str(NEW.relative_to(ROOT)),buildSha256=sha(NEW/'build.json'),
                  assemblySha256=files['Managed/Assembly-CSharp.dll'],files=files,
                  baselineCandidate=str(OLD.relative_to(ROOT)),baselineBuildSha256=sha(OLD/'build.json'),
                  targetSha256=read(acceptance)['targetSha256'], unchangedDatabaseStates=129,
                  unchangedNativeTextObjects=12,unchangedNativeRouteObjects=len(stable),
                  unchangedGameClasses=14,unchangedGameMethodBodies=204,unchangedFontObjects=7,
                  heading17682=targets['sharedassets2.assets:17682/m_text'],
                  evidence={str(p.relative_to(ROOT)):sha(p) for p in evidence},
                  scope='Original28 description argument fixtures only. OOS has separate subscriber-effect holds. Loaded state, original route, native rendering and cleanup must still be verified in the isolated process.',
                  actualGameRuntime='not-run',sourceGateAccepted=False,wholeGameAccepted=False)
    with OUT.open('x') as stream:
        json.dump(result,stream,ensure_ascii=False,indent=2);stream.write('\n')
    print('Bound new candidate:',len(files),'files;129 states;12 text objects;',len(stable),'route objects;204 unchanged game bodies;7 font objects.')


if __name__ == '__main__':
    main()
