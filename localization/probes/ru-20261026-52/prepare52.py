"""Prepare only new candidate52; exact resource reuse, no game/model/image request."""
from pathlib import Path
import datetime,hashlib,json,shutil,subprocess
root=Path('/Users/antonkrutov/Desktop/Forest')
old=root/'localization/probes/ru-20261026-50'
run=root/'localization/probes/ru-20261026-52'
source=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')
data='The Forest of Love_Data'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def load(p):return json.loads(p.read_text())
def write(p,v):p.write_text(json.dumps(v,indent=2)+'\n')
assert not run.exists()
assert subprocess.check_output(['git','branch','--show-current'],cwd=root,text=True).strip()=='main'
assert not subprocess.check_output(['git','diff','--cached','--name-only'],cwd=root,text=True).strip()
rows=subprocess.check_output(['ps','-axo','pid,ppid,command'],text=True).splitlines()
markers=['The Forest of Love.exe','UnityCrashHandler64.exe','diagnose_newgame.py','target_keyboard']
live=[r for r in rows if any(x in r for x in markers) and any(x in r for x in [str(root/'localization/probes'),str(root/'localization/probes').replace('/','\\'),str(source),str(source).replace('/','\\')])]
assert not live,live
pins=load(old/'all-input-pins.json');assert len(pins)==19 and all(sha(Path(p))==h for p,h in pins.items())
report=load(old/'build.json')
for row in report['files']:
 assert sha(source/data/row['path'])==row['sourceSha256']
 assert sha(old/'game'/data/row['path'])==row['probeSha256']
 assert sha(root/'localization/probes/ru-20261026-47/game'/data/row['path'])==row['probeSha256']
recipe=['build_renderer_probe.py','extract_assets.py','addressables_catalog.py','settings_glow.py','tmp_dialogue_font.py','legacy_choice_font.py']
assert all(sha(root/'tools'/n)==sha(old/'resource-recipe'/n) for n in recipe)
previous=load(root/'localization/source/tutorial-20261026/phase0063/tests.json')
assert previous['testsPassed']==133 and all(sha(root/n)==h for n,h in previous['sourceHashes'].items())
run.mkdir()
shutil.copytree(old/'game',run/'game',ignore=shutil.ignore_patterns('tfol.*','*.log','*.dmp'))
for n in ['build.json','input-pins.json','all-input-pins.json','intro-graph.json','tutorial-prefix.json','dynamic-wrapper.json','tutorial181-plan.json','original-game-files.json','owner-player-before.json','external-startup-dependencies.json','runtime-dependencies.json']:
 shutil.copy2(old/n,run/n)
for dirname in ['qa-fixture','source-evidence','resource-recipe']:shutil.copytree(old/dirname,run/dirname)
for p in (run/'qa-fixture').glob('tfol.*'):shutil.copy2(p,run/'game'/data/p.name)
for n in ['diagnose_newgame.py','command.py','save_fixture.py','diagnose_native_input.py','target_keyboard.swift']:
 shutil.copy2(root/'tools/probe'/n,run/n)
for n in recipe:shutil.copy2(root/'tools'/n,run/'resource-recipe'/n)
shutil.copy2(root/'localization/source/tutorial-20261026/phase0060/source-plan/bucky141-plan.json',run/'bucky141-plan.json')
shutil.copy2(root/'localization/source/tutorial-20261026/phase0063/tests.json',run/'tests.json')
shutil.copy2(root/'tools/probe/prepare_bridge.py',run/'prepare_bridge.py')
write(run/'resource-readback.json',dict(status='passed-static-only',totalSelectedTrees=95,evidence='localization/probes/ru-20261026-47/resource-readback.json',evidenceSha256=sha(root/'localization/probes/ru-20261026-47/resource-readback.json'),resourceFiles=load(old/'resource-readback.json')['resourceFiles'],boundary='Exact five resource byte equality to47/50 and all six canonical recipe hashes unchanged; reuse95-tree readback. No new visual claim.'))
write(run/'resource-reuse.json',dict(fromCandidate='ru-20261026-50',buildSha256=sha(old/'build.json'),readbackSha256=sha(run/'resource-readback.json'),recipe={n:sha(root/'tools'/n) for n in recipe},fiveResourcePairs={r['path']:r['probeSha256'] for r in report['files']},catalogSha256=sha(run/'game'/data/'StreamingAssets/aa/catalog.json'),noOpReuse='No resource edits or second serialization; exact accepted payload bytes',ownerPlayerFilesExcluded=True,qa43FixtureCopied=True))
process=next(r for r in rows if r.split(None,2)[0]=='77006')
assert '--model gpt-6.1-sol' in process and 'model_provider="openai"' in process and 'model_reasoning_effort="high"' in process
write(run/'execution-model.json',dict(pid=77006,model='gpt-6.1-sol',provider='openai',reasoning='high',verified='Actual ps launch arguments; --ignore-user-config --disable multi_agent',agents=0,nestedModelJobs=0,usage='Parent runner telemetry; worker counters unknown'))
print(json.dumps(dict(candidate=str(run),resourcePairs=5,pins=len(pins),reusedTests=133,gameLaunches=0)))
