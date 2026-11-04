"""Rebind the shipped Russian baseline to the existing twelve-field catalog repair."""
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent

def read(p):
    return json.loads(p.read_bytes())

def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()

def write(p, value):
    p.write_text(json.dumps(value, ensure_ascii=True, sort_keys=True, indent=2) + '\n')

baseline = ROOT / 'localization/languages/ru-baseline.json'
old = read(baseline)
first = ROOT / 'localization/framework/forest045-shared'
second = ROOT / 'localization/framework/forest045-shared-v2'
old_catalog = {r['id']: r for r in read(first / 'catalog.json')}
new_catalog = {r['id']: r for r in read(second / 'catalog.json')}
assert old['framework'] == dict(id=first.name, sha256=sha(first / 'framework.json'))
assert set(old['translations']) == set(old_catalog)
assert all(new_catalog[k] == v for k, v in old_catalog.items())
added = {k: v for k, v in new_catalog.items() if k not in old_catalog}
assert len(added) == 12
targets = {'<size=22>I</size>NVENTORY': '<size=22>И</size>НВЕНТАРЬ',
           '<size=30>I</size>NVENTORY': '<size=30>И</size>НВЕНТАРЬ'}
for k, r in added.items():
    assert r['source'] == r['baseline'] and r['source'] in targets
    assert r['selectors'] == [dict(asset='sharedassets2.assets', kind='field',
                                  pathId=int(k.split(':')[1].split('/')[0]), pointer='/m_text')]
    old['translations'][k] = dict(source=r['source'], target=targets[r['source']])
old['framework'] = dict(id=second.name, sha256=sha(second / 'framework.json'))
target = ROOT / 'localization/languages/ru.json'
write(target, old)
assert {k: v for k, v in old['translations'].items() if k not in added} == read(baseline)['translations']
write(HERE / 'source-delta.json', dict(
    baseline=dict(path=str(baseline.relative_to(ROOT)), sha256=sha(baseline)),
    language=dict(path=str(target.relative_to(ROOT)), sha256=sha(target)),
    previousWordingUnchanged=14594, addedHeadingLayers=12,
    translations={k: old['translations'][k] for k in added},
    meaning='INVENTORY → ИНВЕНТАРЬ; initial-letter size markup retained',
    independentEditorialReview='not-run; no additional reviewer authorized',
    originalRussianOwnerAcceptancePreserved=True))
