"""Read-only postrun verification for this exact consumed candidate42."""
from pathlib import Path
import datetime
import hashlib
import json
import subprocess
import sys
run=Path(__file__).resolve().parent
assert run.name=='ru-20261026-42'
source=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')
data='The Forest of Love_Data'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def load(name):return json.loads((run/name).read_text())
rows=subprocess.check_output(['ps','-axo','pid,ppid,lstart,command'],text=True).splitlines()
variants=[]
for name in ['The Forest of Love.exe','UnityCrashHandler64.exe']:
 p=run/'game'/name
 variants.extend([str(p),'Z:'+str(p).replace('/','\\'),'Y:'+str(p).replace('/Users/antonkrutov','',1).replace('/','\\')])
remaining=[r.strip() for r in rows if any(p in r for p in variants)]
frozen=load('frozen-files.json');exceptions=[f'game/{data}/Managed/Assembly-CSharp.dll',f'game/{data}/Managed/ForestProbe.dll']
mismatch=[p for p,h in frozen.items() if p not in exceptions and (not (run/p).is_file() or sha(run/p)!=h)]
bridge=load('bridge-build.json');report=load('build.json');pins=load('all-input-pins.json')
owner=load('owner-player-before.json');now={str(p.relative_to(source)):sha(p) for p in source.rglob('tfol.*') if p.is_file()}
original_game=load('original-game-files.json')
checks=dict(frozenDependenciesUnchanged=not mismatch,originalManagedReferencesUnchanged=all(sha(source/data/'Managed'/p)==h for p,h in bridge['originalManagedReferences'].items()),
 originalOtherGameFilesUnchanged=all(sha(source/p)==h for p,h in original_game.items()),
 resourcePairsUnchanged=all(sha(source/data/r['path'])==r['sourceSha256'] and sha(run/'game'/data/r['path'])==r['probeSha256'] for r in report['files']),
 inputPinsUnchanged=all(sha(Path(p))==h for p,h in pins.items()),ownerPlayerFilesUnchanged=now==owner,
 originalQAAssemblyRestored=sha(run/'game'/data/'Managed/Assembly-CSharp.dll')==bridge['originalManagedReferences']['Assembly-CSharp.dll'],
 inspectionBridgeRemoved=not (run/'game'/data/'Managed/ForestProbe.dll').exists(),exactTaskProcessesAbsent=not remaining)
qa=source.parent/'users/crossover/AppData/LocalLow/VNRevivalQA/ForestRuRendererProbe'
checks['originalCatalogUnchanged']=sha(source/data/'StreamingAssets/aa/catalog.json')=='f827a57fd786c98841428d69a8afa914423063dd07c2763dd1e88aa5dfc87b59'
checks['originalAppIdentityUnchanged']=(source/data/'app.info').read_bytes()==b"Carrot's Critters _ Vulpine Visions\nThe Forest of Love"
checks['externalStartupDependenciesUnchanged']=all(sha(Path(p))==h for p,h in load('external-startup-dependencies.json').items())
observer=load('observer-child.json')
checks['exactObserverAndWrapperAbsent']=all(not any(r.split(None,1)[0]==str(observer[k]) for r in rows if r.strip()) for k in ['observerPid','wrapperPid'])
checks['actualObserverExitRetained']=(run/'observer-exit.json').is_file() and load('observer-exit.json')['observerPid']==observer['observerPid'] and isinstance(load('observer-exit.json').get('returnCode'),int)
checks['qaPersistenceEmpty']=qa.is_dir() and not any(qa.rglob('*'))
value=dict(status='passed' if all(checks.values()) else 'failed',verifiedAt=datetime.datetime.now(datetime.timezone.utc).isoformat(),checks=checks,
 frozenDependencies=len(frozen),unchangedFrozenHashes=len(frozen)-len(exceptions)-len(mismatch),expectedCleanupExceptions=exceptions,frozenMismatches=mismatch,
 originalManagedReferences=len(bridge['originalManagedReferences']),originalOtherGameFiles=len(original_game),resourcePairs=len(report['files']),inputPins=len(pins),
 remainingTaskProcesses=remaining,qaPersistentDirectory=str(qa),qaGeneratedFiles={str(p.relative_to(run/'game')):sha(p) for p in (run/'game').rglob('tfol.*') if p.is_file()},
 imagesCaptured=0,imagesOpened=0,scope='No runtime/renderer/editorial acceptance implied by cleanup/hash verification')
(run/'final-verification.json').write_text(json.dumps(value,indent=2)+'\n')
print(json.dumps(value,indent=2));sys.exit(0 if all(checks.values()) else 1)
