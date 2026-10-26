"""Bounded unchanged evidence/pin checks; never replay or mutate older candidates."""
import hashlib,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[4];OUT=Path(__file__).resolve().parent
BASE='83de516027a0701b451b83dc0b83650de6dc10e9'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def git(*args):return subprocess.check_output(['git',*args],cwd=ROOT)
assert git('branch','--show-current').decode().strip()=='main'
p=ROOT/'localization/probes/ru-20261026-52'
pins=json.loads((p/'all-input-pins.json').read_text())
assert len(pins)==19 and all(sha(Path(n))==h for n,h in pins.items())
history=git('ls-tree','-r','--name-only',BASE,'--','localization/probes/ru-20261026-51/','localization/probes/ru-20261026-52/','localization/source/tutorial-20261026/phase0064/','localization/source/tutorial-20261026/phase0065/').decode().splitlines()
assert history
for n in history:assert (ROOT/n).read_bytes()==git('show',BASE+':'+n),n
runtime=json.loads((p/'runtime-diagnosis.json').read_text())
assert all(sha(p/n)==h for n,h in runtime['evidence'].items())
assert sha(p/'command.txt')=='c37bb7fc2cf30d209f2142977c8a69db9af24ce95fff4a342f3ca79bf4e77cbb'
c=json.loads((ROOT/'CHECKPOINT.json').read_text())
assert all(sha(Path(n))==h for n,h in c['processBinding']['references'].items())
assert sha(ROOT/'README.md')==c['processBinding']['projectGuideSha256']
marker='## Prior runtime: phase0050 original158 completion and unselected response pair\n'
assert git('show',BASE+':README.md').decode().split(marker,1)[1]==(ROOT/'README.md').read_text().split(marker,1)[1]
current=ROOT/'localization/probes/ru-20261026-53'
post=json.loads((current/'final-verification.json').read_text());assert post['status']=='passed'
assert not (ROOT/'localization/probes/ru-20261026-54').exists()
v=dict(status='passed',baselineHead=BASE,sourceAndLanePinsUnchanged=19,historicalCommittedFilesUnchanged=len(history),candidate52RuntimeHashesUnchanged=len(runtime['evidence']),unknownPending51And52Preserved=True,universalReferencesUnchanged=len(c['processBinding']['references']),stableReadmeCommandBindingSuffixUnchanged=True,currentGuidePinMatches=True,candidate53PostrunVerificationSha256=sha(current/'final-verification.json'),candidate54Created=False,imagesOpened=0,gameLaunchesThisPhase=1,boundary='Historical files/pins and actual53 postrun proof; no replay of51/52 or writes/reads of live translated corpus. Native/renderer/editorial acceptance remains separately scoped.')
(OUT/'preservation.json').write_text(json.dumps(v,indent=2)+'\n');print(json.dumps(v,indent=2))
