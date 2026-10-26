"""Submit this immutable48 once; the frozen retaining parent owns observer exit."""
from pathlib import Path
import hashlib,json,os,subprocess
run=Path(__file__).resolve().parent
assert run.name=='ru-20261026-48'
assert not any((run/n).exists() for n in ['launch.json','wrapper-launch.json','observer-child.json','observer-exit.json','runtime-result.json'])
pre=json.loads((run/'preflight.json').read_text())
assert pre['status']=='passed-static-only' and pre['frozenManifestSha256']==hashlib.sha256((run/'frozen-files.json').read_bytes()).hexdigest()
argv=['/usr/bin/python3','-B',str(run/'diagnose_newgame.py'),str(run),'--retain-exit','--startup-diagnostics','--continue-fixture','--tutorial-choice-mode','synthetic']
with (run/'wrapper.stdout').open('xb') as stdout,(run/'wrapper.stderr').open('xb') as stderr:
 child=subprocess.Popen(argv,cwd=run,stdout=stdout,stderr=stderr,start_new_session=True,env=dict(os.environ,PYTHONDONTWRITEBYTECODE='1'))
v=dict(wrapperPid=child.pid,argv=argv,gameLaunchLimit=1,submission='accepted-local-Popen',observerExitReceipt='observer-exit.json',runtimeAcceptance='runtime-result.json and cleanup.json; observer status alone is insufficient')
(run/'wrapper-launch.json').write_text(json.dumps(v,indent=2)+'\n')
print(json.dumps(v,indent=2))
