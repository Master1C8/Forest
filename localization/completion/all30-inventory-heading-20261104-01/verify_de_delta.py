"""Compare all serialized objects in the repaired German heading resource."""
import json
from pathlib import Path
import sys
ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / 'tools'))
from forest_localization.core import engines
U, Generator, tree, _, comp, _, _ = engines()
gen = Generator('2020.3.24f1')
gen.load_local_dll_folder(str(ROOT / 'localization/framework/forest045-shared-v2/references'))
delta = json.loads((HERE / 'de-source-delta.json').read_bytes())
expected = {int(k.split(':')[1].split('/')[0]): v for k, v in delta['translations'].items()}
proofs = []
for platform, before, after, original in [
    ('Windows', ROOT/'dist/all30-inventory-work/previous-windows-de/The Forest of Love_Data',
     ROOT/'dist/windows-installer-work/overlays/de/The Forest of Love_Data',
     '/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data'),
    ('macOS', ROOT/'dist/all30-inventory-work/previous-native-de',
     ROOT/'dist/macos-installer-work/overlays/de',
     '/Applications/TheForestOfLove.app/Contents/Resources/Data')]:
    a, b = U.load(str(before/'sharedassets2.assets')), U.load(str(after/'sharedassets2.assets'))
    a.path = b.path = original
    ao, bo = comp.objects(a), comp.objects(b)
    assert set(ao) == set(bo)
    changed = {pid for pid in ao if ao[pid].get_raw_data() != bo[pid].get_raw_data()}
    assert changed == set(expected)
    for pid, wording in expected.items():
        old, new = tree(ao[pid], gen), tree(bo[pid], gen)
        assert old['m_text'] == wording['source'] and new['m_text'] == wording['target']
        assert dict(new, m_text=old['m_text']) == old
    proofs.append(dict(platform=platform, changedObjects=12, onlyTextChanged=True, allUnselectedObjectsExact=True))
(HERE/'de-delta-validation.json').write_text(json.dumps(dict(passed=True, proofs=proofs),indent=2)+'\n')
print('German: only12 m_text fields changed on both platforms')
