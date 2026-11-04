"""Prepare the missing German heading fields without changing an active package's inputs."""
from pathlib import Path
import hashlib
import json
import subprocess

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
source = ROOT / 'localization/languages/de.json'
baseline_commit = '5f7a4b1bb6d41399017f4e78e8df433390ce750c'
baseline_bytes = subprocess.check_output(['git', 'show', baseline_commit + ':localization/languages/de.json'], cwd=ROOT)
old = json.loads(baseline_bytes)
frameworks = ROOT / 'localization/framework'
first = {r['id']: r for r in json.loads((frameworks / 'forest045-shared/catalog.json').read_bytes())}
second = {r['id']: r for r in json.loads((frameworks / 'forest045-shared-v2/catalog.json').read_bytes())}
assert set(old['translations']) == set(first)
assert all(second[k] == v for k, v in first.items())
added = {k: v for k, v in second.items() if k not in first}
assert len(added) == 12
targets = {'<size=22>I</size>NVENTORY': '<size=22>I</size>NVENTAR',
           '<size=30>I</size>NVENTORY': '<size=30>I</size>NVENTAR'}
new = json.loads(baseline_bytes)
for k, row in added.items():
    assert row['source'] == row['baseline'] and row['source'] in targets
    new['translations'][k] = dict(source=row['source'], target=targets[row['source']])
new['framework'] = dict(id='forest045-shared-v2', sha256=hashlib.sha256(
    (frameworks / 'forest045-shared-v2/framework.json').read_bytes()).hexdigest())
assert all(new['translations'][k] == v for k, v in old['translations'].items())
target = HERE / 'de.language.json'
target.write_text(json.dumps(new, ensure_ascii=False, sort_keys=True, indent=2) + '\n')
(HERE / 'de-source-delta.json').write_text(json.dumps(dict(
    previousSha256=hashlib.sha256(baseline_bytes).hexdigest(), baselineCommit=baseline_commit,
    targetSha256=hashlib.sha256(target.read_bytes()).hexdigest(), unchangedEntries=len(first),
    addedEntries=12, translations={k: new['translations'][k] for k in added},
    independentNewWordingReview='not-run', canonicalPublish='deferred-until-active-package-exits'),
    ensure_ascii=False, indent=2) + '\n')
print('Prepared twelve German layers; all prior wording unchanged')
