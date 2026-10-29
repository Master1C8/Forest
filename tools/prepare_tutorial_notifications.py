#!/usr/bin/env python3
"""Bind the existing finite 66-field common source to the delivered native scene resource."""
import hashlib
import json
from pathlib import Path
import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from extract_assets import read_tree, canonical

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
DATA = ROOT / 'localization/previews/ru-20261029-narrative42-01/game/The Forest of Love_Data'
OUT = ROOT / 'localization/source/tutorial-notifications66-20261029'
BUNDLE = 'StreamingAssets/aa/StandaloneWindows64/defaultlocalgroup_assets_all_298c5a4d1d1846b1a8d2c7d5da3f319c.bundle'
CAB = 'CAB-7cd732d37ea0297d073a22a52ce72d28'
BASELINE = 'e4394dc01e391feec8f809dc6e5744dd44e29edca67481c36d3e2d6c034adffc'
RESOURCE = 'sharedassets2.assets'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def prepare():
    assert not (OUT / 'source-contract.json').exists(), 'Append-only source contract'
    assert sha(DATA / BUNDLE) == BASELINE
    targets = json.loads((OUT / 'targets.json').read_text())
    allsource = [json.loads(l) for l in (ROOT / 'localization/source/shared-source-completion-20261028/admission-v1/direct-context.jsonl').open()]
    source = [r for r in allsource if r['hierarchy'].startswith(('SwimFloatiesTutorial/', 'BlueBellItemNotification/'))]
    assert len(source) == len(targets) == 66
    byid = {r['id']: r for r in targets}
    assert len(byid) == 66 and set(byid) == {r['id'] for r in source}
    index = json.loads((ROOT / 'assets/source-v2/objects.json').read_text())
    # The first bounded read found zero matching paths among all1200 bundled
    # TMP fields. Unlike narrative42, these notifications live in the scene's
    # native sharedassets2 resource; do not manufacture bundle aliases.
    candidates = [r for r in index if r['sourceFile'] == RESOURCE and r.get('class') == 'TMPro.TextMeshProUGUI']
    env = UnityPy.load(str(DATA / RESOURCE))
    asset = env.file
    objects = asset.objects
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(DATA / 'Managed'))
    path_cache = {}

    def hierarchy(go):
        if go not in path_cache:
            t = objects[go].read()
            transform = t.m_Component[0].component.deref().read()
            parent = transform.m_Father
            path_cache[go] = (hierarchy(parent.deref().read().m_GameObject.path_id) + '/' if parent.path_id else '') + t.m_Name
        return path_cache[go]

    selected = {}
    wanted = {r['hierarchy']: r for r in source}
    assert len(wanted) == 66
    for r in candidates:
        obj = objects[r['pathId']]
        # Class metadata pins which bodies are parsed; no guessed string scan.
        tree = canonical(read_tree(obj, generator))
        path = hierarchy(tree['m_GameObject']['m_PathID'])
        if path in wanted:
            assert path not in selected, ('Ambiguous hierarchy', path)
            selected[path] = (r, tree)
    assert set(selected) == set(wanted), ('Missing/extra exact hierarchy', set(wanted) - set(selected))
    rows = []
    for s in source:
        entry = byid[s['id']]
        r, tree = selected[s['hierarchy']]
        assert s['class'] == 'TMPro.TextMeshProUGUI' and tree['m_text'] == s['value'] == entry['source']
        assert sha(ROOT / 'assets/source-v2' / s['tree']) == s['treeSha256'] == entry['sourceTreeSha256']
        rows.append(dict(sourceId=s['id'], id=r['id'] + '/m_text', pathId=r['pathId'],
                         hierarchy=s['hierarchy'], source=s['value'], target=entry['target'],
                         nontext={k: v for k, v in tree.items() if k != 'm_text'},
                         beforeRawSha256=hashlib.sha256(objects[r['pathId']].get_raw_data()).hexdigest()))
    assert len({r['pathId'] for r in rows}) == 66
    result = dict(schemaVersion=1, game='The Forest of Love', version='0.45', locale='ru',
                  sourceCommonInventory='localization/source/shared-source-completion-20261028/admission-v1/direct-context.jsonl',
                  sourceCommonInventorySha256=sha(ROOT / 'localization/source/shared-source-completion-20261028/admission-v1/direct-context.jsonl'),
                  targetsSha256=sha(OUT / 'targets.json'), sourceBundleSha256=BASELINE,
                  resource=RESOURCE, sourceResourceSha256=sha(DATA / RESOURCE), rows=rows,
                  selection='Complete three notification pages; source-native IDs matched one-to-one by exact hierarchy, typed field and full source value',
                  grammarAdapter='Six Blue Bell initial/remainder pairs retain physical split; exact assembled accepted Russian title verified during application',
                  onlyTextFieldWrites=True, sourceGateAccepted=False, ordinaryTranslationEntryAllowed=False,
                  runtimeVisualAccepted=False, wholeGameAccepted=False)
    with (OUT / 'source-contract.json').open('x') as f:
        f.write(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps(dict(boundFields=66, actualResource=RESOURCE,
                          pages=sorted({'/'.join(r['hierarchy'].split('/')[:2]) for r in rows}))))


if __name__ == '__main__':
    prepare()
