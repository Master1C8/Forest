"""Read every inventory-heading layer from both platform outputs; reuse exact receipts."""
import argparse
import gc
import hashlib
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / 'tools'))
from forest_localization.core import engines

def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()

p = argparse.ArgumentParser()
p.add_argument('--locale', action='append')
p.add_argument('--aggregate', action='store_true')
a = p.parse_args()
codes = sorted(p.stem for p in (ROOT / 'localization/languages').glob('*.json') if p.stem != 'ru-baseline')
first = {r['id'] for r in json.loads((ROOT / 'localization/framework/forest045-shared/catalog.json').read_bytes())}
headings = {r['id']: r for r in json.loads((ROOT / 'localization/framework/forest045-shared-v2/catalog.json').read_bytes()) if r['id'] not in first}
assert len(codes) == 30 and len(headings) == 12
selected = a.locale or codes
assert set(selected) <= set(codes) and len(selected) == len(set(selected))
U, Generator, tree, _, comp, _, _ = engines()
gen = Generator('2020.3.24f1')
gen.load_local_dll_folder(str(ROOT / 'localization/framework/forest045-shared-v2/references'))
(HERE / 'headings').mkdir(exist_ok=True)
for code in selected:
    language = ROOT / 'localization/languages' / (code + '.json')
    doc = json.loads(language.read_bytes())
    assert set(headings) <= set(doc['translations']), ('Missing heading selectors', code)
    expected = {int(k.split(':')[1].split('/')[0]): doc['translations'][k]['target'] for k in headings}
    assert all(isinstance(t, str) and t and 'NVENTORY' not in t for t in expected.values()), code
    resources = {}
    for platform, directory, original in [
        ('Windows', ROOT / 'dist/windows-installer-work/overlays' / code / 'The Forest of Love_Data',
         '/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data'),
        ('macOS', ROOT / 'dist/macos-installer-work/overlays' / code,
         '/Applications/TheForestOfLove.app/Contents/Resources/Data')]:
        path = directory / 'sharedassets2.assets'
        env = U.load(str(path)); env.path = original
        objects = comp.objects(env)
        for pid, target in expected.items():
            assert tree(objects[pid], gen)['m_text'] == target, (code, platform, pid)
        resources[platform] = dict(path=str(path.relative_to(ROOT)), sha256=sha(path), fields=12)
        del env, objects
        gc.collect()
    result = dict(locale=code, languageSha256=sha(language), resources=resources,
                  headingTargets=expected, passed=True, runtimeVisualAcceptance='not-run')
    (HERE / 'headings' / (code + '.json')).write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    print('verified12 headings on both platforms: ' + code, flush=True)
if a.aggregate:
    rows = []
    for code in codes:
        row = json.loads((HERE / 'headings' / (code + '.json')).read_bytes())
        assert row['passed'] and row['languageSha256'] == sha(ROOT / 'localization/languages' / (code + '.json'))
        for pin in row['resources'].values():
            assert pin['fields'] == 12 and sha(ROOT / pin['path']) == pin['sha256']
        rows.append(row)
    (HERE / 'all30-readback.json').write_text(json.dumps(dict(passed=True, locales=30,
        platformLocalePairs=60, headingFieldReadbacks=720, localesEvidence=rows,
        boundary='Actual saved resources; target renderer layout and script shaping remain separate.'),
        ensure_ascii=False, indent=2) + '\n')
    print('All30 locales:720 exact heading fields verified')
