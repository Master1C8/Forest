"""Prepare new53 once; reuse exact resource/bridge bytes, freeze changed diagnostics."""
from pathlib import Path
import ast,hashlib,json,shutil,subprocess
root=Path('/Users/antonkrutov/Desktop/Forest')
out=Path(__file__).resolve().parent
old=root/'localization/probes/ru-20261026-52'
run=root/'localization/probes/ru-20261026-53'
source=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')
data='The Forest of Love_Data'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def load(p):return json.loads(p.read_text())
def write(p,v):p.write_text(json.dumps(v,indent=2)+'\n')
assert not run.exists(), 'Never prepare/replay an existing candidate'
assert subprocess.check_output(['git','branch','--show-current'],cwd=root,text=True).strip()=='main'
assert not subprocess.check_output(['git','diff','--cached','--name-only'],cwd=root,text=True).strip()
rows=subprocess.check_output(['ps','-axo','pid,ppid,command'],text=True).splitlines()
markers=['The Forest of Love.exe','UnityCrashHandler64.exe','diagnose_newgame.py','target_keyboard']
live=[r for r in rows if any(x in r for x in markers) and any(x in r for x in [str(root/'localization/probes'),str(root/'localization/probes').replace('/','\\'),str(source),str(source).replace('/','\\')])]
assert not live,live
pins=load(old/'all-input-pins.json');assert len(pins)==19 and all(sha(Path(p))==h for p,h in pins.items())
original=load(old/'original-game-files.json');assert len(original)==262 and all(sha(source/n)==h for n,h in original.items())
report=load(old/'build.json');assert len(report['files'])==5
for row in report['files']:
 assert sha(source/data/row['path'])==row['sourceSha256']
 for candidate in ['47','50','52']:
  assert sha(root/('localization/probes/ru-20261026-'+candidate)/'game'/data/row['path'])==row['probeSha256']
recipe=['build_renderer_probe.py','extract_assets.py','addressables_catalog.py','settings_glow.py','tmp_dialogue_font.py','legacy_choice_font.py']
assert all(sha(root/'tools'/n)==sha(old/'resource-recipe'/n) for n in recipe)
tests=load(out/'tests.json');assert tests['testsPassed']==144 and all(sha(root/n)==h for n,h in tests['sourceHashes'].items())
bridge=load(old/'bridge-build.json')
assert all(sha(root/'tools/probe'/n)==h for n,h in bridge['sourceSnapshots'].items())
assert sha(old/'ForestProbe.dll')==bridge['bridgeSha256'] and sha(old/'Assembly-CSharp.hook.dll')==bridge['hookSha256']
installed=load(root/'localization/source/tutorial-20261026/phase0065/native-consumers.json')
external=dict(installed['candidate52StartupPinsRechecked'],**installed['installedFiles'])
assert len(external)==8 and all(sha(Path(p))==h for p,h in external.items())
run.mkdir()
# APFS clone preserves file bytes without another full-sized game allocation.
subprocess.run(['/bin/cp','-cR',str(old/'game'),str(run/'game')],check=True)
assert sha(run/'game'/data/'Managed/Assembly-CSharp.dll')==bridge['originalManagedReferences']['Assembly-CSharp.dll']
assert not (run/'game'/data/'Managed/ForestProbe.dll').exists()
for n in ['build.json','input-pins.json','all-input-pins.json','intro-graph.json','tutorial-prefix.json','dynamic-wrapper.json','tutorial181-plan.json','bucky141-plan.json','original-game-files.json','owner-player-before.json','runtime-dependencies.json','toolchain-pins.json','bridge-build.json','bridge-verification.json','ForestProbe.dll','ForestProbe.synthetic-check.dll','Assembly-CSharp.hook.dll','target_keyboard','cleanup-plan.md']:
 shutil.copy2(old/n,run/n)
for name in ['qa-fixture','source-evidence','resource-recipe']:
 shutil.copytree(old/name,run/name)
(run/'bridge-source').mkdir()
for name in bridge['sourceSnapshots']:
 shutil.copy2(old/'bridge-source'/name,run/'bridge-source'/name)
for p in (run/'qa-fixture').glob('tfol.*'):shutil.copy2(p,run/'game'/data/p.name)
for n in ['diagnose_newgame.py','termination_trace.py','command.py','save_fixture.py','diagnose_native_input.py','target_keyboard.swift']:
 shutil.copy2(root/'tools/probe'/n,run/n)
shutil.copy2(out/'tests.json',run/'tests.json')
shutil.copy2(out/'execution-model.json',run/'execution-model.json')
for n in ['ForestProbe.dll','Assembly-CSharp.hook.dll']:
 target='ForestProbe.dll' if n=='ForestProbe.dll' else 'Assembly-CSharp.dll'
 shutil.copy2(run/n,run/'game'/data/'Managed'/target)
# Preserve unchanged compiled IL acceptance with current binary/source equality.
rb=load(run/'bridge-verification.json')
assert rb['allBodiesExactPhase0063'] and all(v['allExact'] and v['methods']==87 for v in rb['modes'].values())
assert rb['modes']['original']['candidateSha256']==sha(run/'ForestProbe.dll')
assert rb['modes']['synthetic']['candidateSha256']==sha(run/'ForestProbe.synthetic-check.dll')
write(run/'bridge-reuse.json',dict(baseline='localization/probes/ru-20261026-52',verificationSha256=sha(old/'bridge-verification.json'),all87BodiesBothModesUnchanged=True,bridgeSourceAndBinariesUnchanged=True,boundary='Reuse exact source/binary/IL bytes; no fresh compile or native proof'))
write(run/'external-startup-dependencies.json',external)
# Pin Python library modules used by the newly added drain (not a frozen private interpreter).
import threading,select,datetime,subprocess as sp
runtime=load(run/'runtime-dependencies.json')
for module in [threading,select,datetime,sp]:
 path=Path(module.__file__).resolve();runtime[str(path)]=sha(path)
write(run/'runtime-dependencies.json',runtime)
write(run/'resource-readback.json',dict(status='passed-static-only',totalSelectedTrees=95,evidence='localization/probes/ru-20261026-47/resource-readback.json',evidenceSha256=sha(root/'localization/probes/ru-20261026-47/resource-readback.json'),resourceFiles=load(old/'resource-readback.json')['resourceFiles'],boundary='Exact five resource byte equality to47/50/52 and all six canonical recipe hashes unchanged; reuse95-tree readback. No new visual claim.'))
write(run/'resource-reuse.json',dict(fromCandidate='ru-20261026-52',buildSha256=sha(old/'build.json'),readbackSha256=sha(run/'resource-readback.json'),recipe={n:sha(root/'tools'/n) for n in recipe},fiveResourcePairs={r['path']:r['probeSha256'] for r in report['files']},catalogSha256=sha(run/'game'/data/'StreamingAssets/aa/catalog.json'),noOpReuse='No resource edits or serialization; exact accepted payload bytes',ownerPlayerFilesExcluded=True,qa43FixtureCopied=True))
def bodies(p):return {n.name:ast.dump(n,include_attributes=False) for n in ast.parse(p.read_text()).body if isinstance(n,(ast.FunctionDef,ast.ClassDef))}
a=bodies(run/'diagnose_newgame.py');b=bodies(old/'diagnose_newgame.py')
names=load(root/'localization/source/focus-transition-20261026/verification.json')['unchangedGuardBodies']
assert len(names)==14 and all(a[n]==b[n] for n in names)
assert a['ContinueObservationBudget']==b['ContinueObservationBudget']
assert sorted(k for k in b if b[k]!=a.get(k))==['launch_options','main','startup_environment']
assert sorted(set(a)-set(b))==['bind_termination_trace']
# The complete original New/Continue branch is byte-identical despite logging setup changes.
oldtext=(old/'diagnose_newgame.py').read_text();newtext=(run/'diagnose_newgame.py').read_text()
start="        if options.continue_fixture:\n            budget = ContinueObservationBudget"
end='        success = True\n'
assert oldtext.split(start,1)[1].split(end,1)[0]==newtext.split(start,1)[1].split(end,1)[0]
write(run/'guard-verification.json',dict(status='passed-static-only',all14OriginalGuards=names,defaultNewBranchUnchanged=True,ContinueObservationBudgetExact=True,phase0063HostExact=False,changedHostFunctions=['launch_options','main','startup_environment'],addedHostFunctions=['bind_termination_trace'],originalStoryBranchesByteEqual=True,sourceSha256=sha(run/'diagnose_newgame.py')))
for name in ['verify-postrun.py','verify-preflight.py','launch-once.py']:
 text=(old/name).read_text().replace('candidate52','candidate53').replace('immutable52','immutable53').replace("ru-20261026-52'","ru-20261026-53'")
 if name=='launch-once.py':text=text.replace("'--startup-diagnostics','--continue-fixture'","'--startup-diagnostics','--termination-trace','--continue-fixture'")
 if name=='verify-preflight.py':
  text=text.replace("checks['focused133Tests']=tests['testsPassed']==133", "checks['focused144Tests']=tests['testsPassed']==144")
  text=text.replace("'external-startup-dependencies.json'])", "'external-startup-dependencies.json','termination_trace.py'])")
  text=text.replace("checks['modelPinned']=", "checks['exactTerminationHelper']=sha(run/'termination_trace.py')==sha(root/'tools/probe/termination_trace.py')\nchecks['newInstalledDriversPinned']=len(load('external-startup-dependencies.json'))==8\nchecks['changedDiagnosticFlags']=\"'--termination-trace'\" in (run/'launch-once.py').read_text()\nchecks['modelPinned']=")
 (run/name).write_text(text)
text=(run/'cleanup-plan.md').read_text().replace('Candidate52','Candidate53').replace('exact133-test','exact144-test')
text+='\nChanged diagnostic only: both explicit masks append ,trace+macdrv. Discard unrelated macdrv before persistence; 256KiB trace / 8MiB prior diagnostics / 8192-byte line limits. Bind native birth/exact argv and lifecycle Windows PID before retaining macdrv; unbound rows are dropped. EOF/partial/budget gaps remain unknown; terminating-process trace precedes the syscall. No quit suppression or global/owner-history logging.\n'
(run/'cleanup-plan.md').write_text(text)
# All later-read candidate files including game, helper, plans, launch/verification recipes.
frozen={str(p.relative_to(run)):sha(p) for p in sorted(run.rglob('*')) if p.is_file()}
write(run/'frozen-files.json',frozen)
print(json.dumps(dict(candidate=str(run),resourcePairs=5,pins=19,tests=144,frozenDependencies=len(frozen),gameLaunches=0)))
