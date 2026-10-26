"""Read-only phase preservation proof; never run consumed candidate preparation."""
from pathlib import Path
import hashlib,json,subprocess,datetime
r=Path(__file__).resolve().parents[4];out=Path(__file__).resolve().parent
run=r/'localization/probes/ru-20261026-51';source=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();load=lambda p:json.loads(p.read_text())
base=load(out/'baseline.json');checks={}
checks['all19PinsUnchanged']=len(base['all19Pins'])==19 and all(sha(Path(p))==h for p,h in base['all19Pins'].items())
old=load(run/'runtime-diagnosis.json');checks['allCandidate51DiagnosisEvidenceUnchanged']=all(sha(run/p)==h for p,h in old['evidence'].items())
frozen=load(run/'frozen-files.json');exceptions=load(run/'final-verification.json')['expectedCleanupExceptions']
unchanged={p:h for p,h in frozen.items() if p not in exceptions}
checks['candidate51Frozen358Unchanged']=len(unchanged)==358 and all(sha(run/p)==h for p,h in unchanged.items())
checks['candidate51PendingCommandUnchanged']=sha(run/'command.txt')==old['pendingCommand']['sha256']
original=load(run/'original-game-files.json');managed=[p for p in original if '/Managed/' in p]
checks['original262FilesIncluding150ManagedUnchanged']=len(original)==262 and len(managed)==150 and all(sha(source/p)==h for p,h in original.items())
owner=load(run/'owner-player-before.json');actual={str(p.relative_to(source)):sha(p) for p in source.rglob('tfol.*') if p.is_file()};checks['ownerFilesUnchanged']=actual==owner
checks['candidate51QAAssemblyRestored']=sha(run/'game/The Forest of Love_Data/Managed/Assembly-CSharp.dll')==sha(source/'The Forest of Love_Data/Managed/Assembly-CSharp.dll')
checks['candidate51BridgeAbsent']=not (run/'game/The Forest of Love_Data/Managed/ForestProbe.dll').exists()
qa=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/users/crossover/AppData/LocalLow/VNRevivalQA/ForestRuRendererProbe');checks['qaPersistenceEmpty']=not qa.exists() or not any(p.is_file() for p in qa.rglob('*'))
p=subprocess.run(['ps','-p','75040,75041,75043,75065','-o','pid=,ppid=,lstart=,stat=,comm='],capture_output=True,text=True);checks['candidate51ExactPidsAbsent']=p.returncode==1 and not p.stdout.strip()
checks['historical51And0062GitUnchanged']=not subprocess.check_output(['git','diff','--name-only','--','localization/probes/ru-20261026-51','localization/source/tutorial-20261026/phase0062'],cwd=r,text=True).strip()
assert all(checks.values()),checks
(out/'preservation.json').write_text(json.dumps(dict(status='passed',verifiedAt=datetime.datetime.now(datetime.timezone.utc).isoformat(),checks=checks,candidate51PendingSha256=sha(run/'command.txt'),frozenDependenciesUnchanged=358,originalFilesTotal=262,originalManagedSubset=150,inputPins=19,gameLaunches=0,imagesOpened=0,countCorrection='Historical originalOtherGameFiles262 actually includes150 managed; counts are overlapping, never412 distinct originals. Initial phase0063 assertion of412 failed only on count; all262 hashes matched.'),indent=2)+'\n')
comparison=load(out/'compiled-readback/comparison.json');tests=load(out/'tests.json')
evidence=['ADAPTER.md','candidate51-native-quit.txt','compiled-readback/comparison.json','original/extraction.json','tests.json','preservation.json','execution-model.json','verify.py','verify-preservation.py']
(out/'verification.json').write_text(json.dumps(dict(status='passed-static-diagnostics-runtime-not-run',model=load(out/'execution-model.json'),candidate51Finding='Exact75065 received (aevt,quit) target=Dock then AppKit handled Quit AppleEvent; upstream action unknown',candidate51GameExitCode=None,compiledModes={m:{k:len(comparison['modes'][m][k]) for k in ['exact','compilerOrdinalOnly','changed','added']} for m in ['original','synthetic']},sourceQuitInstructions=5,originalGuardsExact=14,mainAndContinueBudgetExact=True,focusedTestsPassed=tests['testsPassed'],preservation=checks,gameLaunches=0,nativeEvents=0,imagesOpened=0,remaining=['candidate52 full freeze/preflight and one-use runtime','Bucky native141/217/actual194..212/real212/loaded marker consumers','initial spawn/other3 introductions/notebook/inventory','complete source/BGDatabase/special-scene/editorial/final fonts/resources/local delivery'],evidence={n:sha(out/n) for n in evidence},usage='Unknown in worker; parent measures actual request telemetry'),indent=2)+'\n')
print(json.dumps(dict(preservationChecks=len(checks),allPassed=True,frozen51=358,originalFilesTotal=262,managedSubset=150,inputPins=19,tests=133)))
