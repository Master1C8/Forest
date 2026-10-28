"""Read-only source bindings for exact notebook screenshot artwork findings."""
import argparse
import hashlib
import json
from pathlib import Path

import UnityPy

ROOT = Path(__file__).resolve().parents[1]


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def verify(candidate, output):
    candidate, output = candidate.resolve(), output.resolve()
    assert candidate.parent == ROOT / 'localization/previews'
    assert output.parent == ROOT / 'localization/visual-qa/ru-notebook-20261029-01-diagnostic'
    assert not output.exists()
    extracted = ROOT / 'assets/source-v2'
    records = json.loads((extracted / 'objects.json').read_text())
    index = {(r['sourceFile'], r['pathId']): r for r in records}
    original = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
    source_files = json.loads((extracted / 'source-files.json').read_text())
    inventory_path = ROOT / 'localization/source/notebook-tutorial-ui-20261027/inventory.json'
    inventory = json.loads(inventory_path.read_text())
    assert inventory['controllerId'] == 15851
    loaded = {}
    target_loaded = {}
    pins = {str(inventory_path.relative_to(ROOT)): sha(inventory_path)}

    def file(asset):
        if asset not in loaded:
            assert sha(original / asset) == source_files[asset]['sha256']
            loaded[asset] = next(iter(UnityPy.load(str(original / asset)).files.values()))
            target_loaded[asset] = next(iter(UnityPy.load(str(candidate / 'game/The Forest of Love_Data' / asset)).files.values()))
        return loaded[asset]

    def tree(asset, pid):
        row = index[(asset, pid)]
        if row.get('tree'):
            path = extracted / row['tree']
            assert sha(path) == row['treeSha256']
            pins[str(path.relative_to(ROOT))] = row['treeSha256']
            return json.loads(path.read_text())
        return file(asset).objects[pid].read_typetree()

    def exact(asset, pid):
        file(asset)
        expected = index[(asset, pid)]['rawSha256']
        assert hashlib.sha256(loaded[asset].objects[pid].get_raw_data()).hexdigest() == expected
        assert hashlib.sha256(target_loaded[asset].objects[pid].get_raw_data()).hexdigest() == expected
        return dict(asset=asset, pathId=pid, sourceAndCandidateRawSha256=expected)

    def resolve(asset, pointer):
        return (asset if pointer['m_FileID'] == 0 else Path(file(asset).externals[pointer['m_FileID'] - 1].path).name,
                pointer['m_PathID'])

    def image_binding(asset, pid):
        image = tree(asset, pid)
        sprite_asset, sprite_id = resolve(asset, image['m_Sprite'])
        sprite = tree(sprite_asset, sprite_id)
        texture_asset, texture_id = resolve(sprite_asset, sprite['m_RD']['texture'])
        texture = tree(texture_asset, texture_id)
        return dict(image=exact(asset, pid), sprite=exact(sprite_asset, sprite_id),
                    spriteName=sprite['m_Name'], texture=exact(texture_asset, texture_id),
                    textureName=texture['m_Name'], imageColor=image['m_Color'])

    notification = tree('sharedassets2.assets', 18057)
    assert notification['gossipTutorialPrefab'] == dict(m_FileID=0, m_PathID=15851)
    assert notification['continueButtonAnimator'] == dict(m_FileID=0, m_PathID=5693)
    animator = tree('sharedassets2.assets', 5693)
    assert animator['m_GameObject']['m_PathID'] == 2060
    subtree = []

    def visit(go_id):
        go = tree('sharedassets2.assets', go_id)
        components = []
        children = []
        for ref in go['m_Component']:
            pid = ref['component']['m_PathID']
            row = index[('sharedassets2.assets', pid)]
            kind = row.get('class', row['type'])
            assert kind not in ('TMPro.TextMeshProUGUI', 'UnityEngine.UI.Text')
            value = tree('sharedassets2.assets', pid)
            components.append(dict(pathId=pid, kind=kind))
            if 'm_Children' in value:
                children = [tree('sharedassets2.assets', c['m_PathID'])['m_GameObject']['m_PathID'] for c in value['m_Children']]
        subtree.append(dict(gameObject=go_id, name=go['m_Name'], components=components))
        for child in children:
            visit(child)

    visit(2060)
    continue_images = [image_binding('sharedassets2.assets', c['pathId']) for go in subtree for c in go['components'] if c['kind'] == 'UnityEngine.UI.Image']
    assert continue_images and all(r['textureName'] == 'TutorialsContinueButton' for r in continue_images)
    selected = [(3, 14455, 'GossipTutorial2_Artwork'), (4, 13906, 'QuestLog_Background_Full'), (5, 14490, 'CritterLog_BackgroundFull')]
    artwork = []
    for page, pid, name in selected:
        entry = next(r for r in inventory['images'] if r['id'] == f'sharedassets2.assets:{pid}')
        assert entry['hierarchy'].startswith(f'GossipTutorialRedux/Page{page}/')
        binding = image_binding('sharedassets2.assets', pid)
        assert binding['spriteName'] == name
        assert not [r for r in inventory['rows'] if r['hierarchy'].startswith(entry['hierarchy'] + '/')]
        artwork.append(dict(page=page, hierarchy=entry['hierarchy'], **binding))
    receipt = dict(status='exact-original-artwork-bindings-verified', candidate=str(candidate),
                   candidateBuildSha256=sha(candidate / 'build.json'), notification=exact('sharedassets2.assets', 18057),
                   continueSubtree=subtree, continueImages=continue_images, illustrations=artwork,
                   sourcePins=pins, codeSha256=sha(Path(__file__)),
                   boundary='These exact Images/Sprites/Texture2D objects remain source-byte-exact. English in those original illustrations and painted Continue uses the existing no-texture exception. This proves resource provenance, not tiny-mark readability, intentional fade appearance, full notebook native-text acceptance or missing run01 display diagnostics. Original review findings remain unchanged.')
    output.write_text(json.dumps(receipt, indent=2) + '\n')
    print(json.dumps(dict(status=receipt['status'], illustrations=len(artwork), continueImages=len(continue_images))))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--candidate', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    verify(args.candidate, args.output)
