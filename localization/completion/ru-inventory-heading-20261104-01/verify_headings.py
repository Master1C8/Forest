"""Read back the actual platform resources and bound the change to twelve text fields."""
import hashlib
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT / 'tools'))
from forest_localization.core import engines

HERE = Path(__file__).resolve().parent
delta = json.loads((HERE / 'source-delta.json').read_bytes())
U, Generator, tree, _, comp, _, _ = engines()
gen = Generator('2020.3.24f1')
gen.load_local_dll_folder(str(ROOT / 'localization/framework/forest045-shared-v2/references'))
ids = {int(k.split(':')[1].split('/')[0]): v for k, v in delta['translations'].items()}
results = []
for platform, previous, current in [
    ('Windows', ROOT / 'dist/ru-inventory-work/previous-windows-ru/The Forest of Love_Data',
     ROOT / 'dist/windows-installer-work/overlays/ru/The Forest of Love_Data'),
    ('macOS', ROOT / 'dist/ru-inventory-work/previous-native-ru',
     ROOT / 'dist/macos-installer-work/overlays/ru'),
]:
    old_env = U.load(str(previous / 'sharedassets2.assets'))
    new_env = U.load(str(current / 'sharedassets2.assets'))
    source = (Path('/Applications/TheForestOfLove.app/Contents/Resources/Data') if platform == 'macOS'
              else Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data'))
    old_env.path = new_env.path = str(source)
    old, new = comp.objects(old_env), comp.objects(new_env)
    assert set(old) == set(new)
    changed = {pid for pid in old if old[pid].get_raw_data() != new[pid].get_raw_data()}
    assert changed == set(ids), (platform, changed)
    labels = []
    for pid, wording in ids.items():
        before, after = tree(old[pid], gen), tree(new[pid], gen)
        assert before['m_text'] == wording['source'] and after['m_text'] == wording['target']
        normalized = dict(after, m_text=before['m_text'])
        assert normalized == before, ('Unexpected non-text change', platform, pid)
        labels.append(dict(pathId=pid, text=after['m_text'], font=after.get('m_fontAsset'),
                           rect=after.get('m_rectTransform')))
    names = ['Managed/Assembly-CSharp.dll', 'Managed/VNRevivalInventoryLayout.dll',
             'Managed/VNRevivalQuestLayout.dll', 'resources.assets', 'level1', 'level5', 'level6',
             'sharedassets0.assets', 'sharedassets1.assets', 'sharedassets4.assets', 'sharedassets15.assets']
    for name in names:
        assert (previous / name).read_bytes() == (current / name).read_bytes(), (platform, name)
    results.append(dict(platform=platform, changedObjects=12, allOtherObjectsExact=True,
                        nonTextFieldsExact=True, unchangedOtherResources=len(names), labels=labels))
(HERE / 'heading-readback.json').write_text(json.dumps(dict(passed=True, platforms=results,
    rendererAcceptance='not-run', independentSemanticReview='not-run'), indent=2) + '\n')
print('Both platforms: exactly twelve changed objects; text fields and all other objects verified')
