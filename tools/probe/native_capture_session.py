"""Own one native capture process and restore its instrumentation on every exit."""
from pathlib import Path
import datetime,hashlib,json,os,plistlib,shutil,subprocess,time
ROOT=Path(__file__).resolve().parents[2]
RUN=ROOT/'localization/probes'/os.environ.get('FOREST_CAPTURE_RUN','ru-owner-shots-20261104-01')
assert RUN.parent==ROOT/'localization/probes' and RUN.name.startswith('ru-owner-shots-')
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def write(name,value):(RUN/name).write_text(json.dumps(value,indent=2)+'\n')
build=json.loads((RUN/'build.json').read_bytes());game=Path(build['game']);source=Path(build['source']);contents=game/'Contents';data=contents/'Resources/Data'
exe=contents/'MacOS'/plistlib.loads((contents/'Info.plist').read_bytes())['CFBundleExecutable']
assert not (RUN/'launch.json').exists()
for name,origin in [('original-globalgamemanagers',source/'Contents/Resources/Data/globalgamemanagers'),('original-Info.plist',source/'Contents/Info.plist')]:
 assert not (RUN/name).exists();shutil.copy2(origin,RUN/name)
argv=[str(exe),'-screen-fullscreen','0','-screen-width','1280','-screen-height','720','-logFile',str(RUN/'player.log')]
error=None;child=None;start=time.monotonic()
try:
 with (RUN/'native-stdout.log').open('wb') as log:
  child=subprocess.Popen(argv,cwd=exe.parent,stdin=subprocess.DEVNULL,stdout=log,stderr=subprocess.STDOUT,start_new_session=True)
 write('launch.json',dict(pid=child.pid,argv=argv,startedAt=datetime.datetime.now(datetime.timezone.utc).isoformat(),sessionRecipeSha256=sha(Path(__file__)),buildSha256=sha(RUN/'build.json'),timeoutSeconds=1800))
 while child.poll() is None:
  if (RUN/'finish.request').exists() or (RUN/'failure.request').exists():break
  if time.monotonic()-start>1800:raise TimeoutError('Native capture session deadline')
  time.sleep(.5)
except BaseException as e:error=repr(e)
finally:
 if child is not None and child.poll() is None:
  if not (RUN/'command.txt').exists():(RUN/'command.txt').write_text('quit\n')
  try:child.wait(timeout=25)
  except subprocess.TimeoutExpired:
   # Only this Popen identity, never a name-matched owner process.
   child.terminate()
   try:child.wait(timeout=10)
   except subprocess.TimeoutExpired:child.kill();child.wait(timeout=10)
 stopped=child is None or child.poll() is not None
 if stopped:
  assert sha(data/'Managed/ForestProbe.dll')==build['bridgeSha256']
  shutil.copy2(RUN/'Assembly-CSharp.original.dll',data/'Managed/Assembly-CSharp.dll')
  (data/'Managed/ForestProbe.dll').unlink()
  shutil.copy2(RUN/'original-globalgamemanagers',data/'globalgamemanagers')
  shutil.copy2(RUN/'original-Info.plist',contents/'Info.plist')
  shutil.copy2(RUN/'original-tfol.settings',contents/'tfol.settings')
 owner=json.loads((RUN/'owner-before.json').read_bytes())
 owner_unchanged=all(sha(source/'Contents'/n)==v['sha256'] for n,v in owner['files'].items())
 task_save_unchanged=sha(contents/'tfol.savegame')==owner['files']['tfol.savegame']['sha256']
 write('cleanup.json',dict(taskProcessStopped=stopped,exitCode=child.returncode if child else None,error=error,
  ownerSaveSettingsUnchanged=owner_unchanged,taskSaveByteExact=task_save_unchanged,
  bridgeRemoved=not (data/'Managed/ForestProbe.dll').exists(),localizedAssemblyRestored=sha(data/'Managed/Assembly-CSharp.dll')==sha(RUN/'Assembly-CSharp.original.dll'),
  settingsRestored=sha(contents/'tfol.settings')==owner['files']['tfol.settings']['sha256'],
  elapsedSeconds=round(time.monotonic()-start,2),progressSaveWritesBlocked=True))
 assert stopped and owner_unchanged and task_save_unchanged
