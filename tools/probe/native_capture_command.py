"""Bounded bridge transport that also preserves newlines in real UI object names."""
import argparse,json,subprocess,time
from pathlib import Path
p=argparse.ArgumentParser();p.add_argument('run',type=Path);p.add_argument('command');p.add_argument('--timeout',type=float,default=20);a=p.parse_args()
r=a.run.resolve();assert r.parent.name=='probes' and r.parent.parent.name=='localization' and r.name.startswith(('ru-owner-shots-','locale-owner-shots-'))
launch=json.loads((r/'launch.json').read_bytes())
actual=subprocess.check_output(['ps','-p',str(launch['pid']),'-o','command='],text=True).strip()
assert actual.startswith(launch['argv'][0]),'Exact task process is not live'
assert 0<a.timeout<=90 and not (r/'command.txt').exists(),'Reconcile pending command'
log=r/'actions.log';offset=log.stat().st_size if log.exists() else 0
temp=r/'command.pending';assert not temp.exists();temp.write_text(a.command+'\n');temp.rename(r/'command.txt')
deadline=time.monotonic()+a.timeout
while time.monotonic()<deadline:
 if log.exists():
  with log.open('rb') as f:f.seek(offset);data=f.read().decode()
  if ' OK '+a.command+'\n' in data:break
  if ' FAIL '+a.command+' ' in data:raise RuntimeError(data[-1500:])
 time.sleep(.1)
else:raise TimeoutError('Outcome unknown; reconcile same process before another action')
if a.command.startswith('capture '):
 image=r/a.command[8:]
 while not image.exists() and time.monotonic()<deadline:time.sleep(.1)
 assert image.exists(),'Capture acknowledged; image outcome still unknown'
print('Acknowledged:',a.command.split('\n')[0][:180])
