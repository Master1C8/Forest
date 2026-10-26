#!/usr/bin/env python3
"""Check only this phase's preservation boundary; no game or native diagnostic calls."""
import hashlib
import json
import subprocess
from pathlib import Path
ROOT = Path(__file__).resolve().parents[4]
OUT = Path(__file__).resolve().parent
BASE = '3db85b8fe873c8cc6e8fa3fe337d0d981cfa07c7'
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def git(*args): return subprocess.check_output(['git',*args],cwd=ROOT)
assert git('branch','--show-current').decode().strip() == 'main'
p = ROOT/'localization/probes/ru-20261026-52'
pins = json.loads((p/'all-input-pins.json').read_text())
assert len(pins) == 19
assert all(sha(Path(path)) == h for path,h in pins.items())
phase64 = 'localization/source/tutorial-20261026/phase0064/'
paths = git('ls-tree','-r','--name-only',BASE,'--',phase64).decode().splitlines()
assert paths
for path in paths:
    assert (ROOT/path).read_bytes() == git('show',BASE+':'+path),path
runtime = json.loads((p/'runtime-diagnosis.json').read_text())
for path,h in runtime['evidence'].items():
    assert sha(p/path) == h,path
assert sha(p/'command.txt') == 'c37bb7fc2cf30d209f2142977c8a69db9af24ce95fff4a342f3ca79bf4e77cbb'
# Preserves all committed51 and52 non-game evidence, not arbitrary old logs or game copies.
historical = git('ls-tree','-r','--name-only',BASE,'--','localization/probes/ru-20261026-51/','localization/probes/ru-20261026-52/').decode().splitlines()
for path in historical:
    assert '/game/' not in path,path
    assert (ROOT/path).read_bytes() == git('show',BASE+':'+path),path
c = json.loads((ROOT/'CHECKPOINT.json').read_text())
assert all(sha(Path(path)) == h for path,h in c['processBinding']['references'].items())
assert sha(ROOT/'README.md') == c['processBinding']['projectGuideSha256']
old = git('show',BASE+':README.md').decode()
new = (ROOT/'README.md').read_text()
marker='## Prior runtime: phase0050 original158 completion and unselected response pair\n'
assert old.split(marker,1)[1] == new.split(marker,1)[1]
# Numeric old task IDs plus the exact consumed executable paths; never signal processes.
old_ids = [77510,77511,77513,77552,77556,77660]
rows = subprocess.run(['ps','-p',','.join(map(str,old_ids)),'-o','pid=,lstart=,command='],capture_output=True,text=True)
assert rows.returncode == 1 and not rows.stdout.strip(),rows.stdout
all_rows = subprocess.check_output(['ps','-axo','pid=,command='],text=True)
owned = [line for line in all_rows.splitlines() if any('/ru-20261026-'+n+'/game/The Forest of Love.exe' in line or ('ru-20261026-'+n+'\\game\\The Forest of Love.exe') in line for n in ['51','52'])]
assert not owned,owned
assert not (ROOT/'localization/probes/ru-20261026-53').exists()
emit = {
 'status':'passed', 'baselineHead':BASE, 'pinsUnchanged':len(pins),
 'phase0064CommittedFilesUnchanged':len(paths), 'candidate52RuntimeHashesUnchanged':len(runtime['evidence']),
 'candidate51And52CommittedEvidenceUnchanged':len(historical), 'pending52CommandUnchanged':True,
 'pending51CommandPreservedByCommittedByteComparison':True,
 'universalReferenceHashesUnchanged':len(c['processBinding']['references']),
 'stableReadmeCommandBindingSuffixUnchanged':True, 'currentGuidePinMatches':True,
 'exactOldTaskPidsAbsent':old_ids, 'consumed51And52ExecutableRowsAbsent':True,
 'candidate53Created':False, 'imagesOpened':0, 'gameLaunches':0,
 'boundary':'No game/build/input changes this phase; checks verify named pins and committed historical evidence. Prior64 original262/QA cleanup results are reused, not rerun or relabeled as a new restore proof. Live asset outputs and owner content are not read.'
}
(OUT/'preservation.json').write_text(json.dumps(emit,indent=2)+'\n')
print(json.dumps(emit,indent=2))
