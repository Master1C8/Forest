"""Capture each actual Quest surface in a disposable, source-bound QA profile."""
import base64,json,re,shutil,struct,subprocess,time,sys
from pathlib import Path
import capture_settings as shared
RUN,GAME,DATA=shared.RUN,shared.GAME,shared.DATA
sha,write,command=shared.sha,shared.write,shared.command
def command(value):
 result=subprocess.run([sys.executable,str(RUN/'quest_command.py'),str(RUN),value],capture_output=True,text=True,timeout=100)
 assert result.returncode==0,(value,result.stdout,result.stderr)
 return result.stdout


def geometry():
 command('quest-geometry');rows=[]
 for line in (RUN/'quest-geometry.tsv').read_text().splitlines()[1:]:
  v=line.split('\t');assert len(v)==13,v
  rows.append(dict(path=v[0],text=base64.b64decode(v[1]).decode(),alpha=float(v[2]),characters=int(v[3]),expected=int(v[4]),bounds=list(map(float,v[5:9])),font=v[9],fontSize=int(v[10]),body=v[11]=='True',visible=v[12]=='True'))
 return rows

def main():
 assert not shared.processes() and not (RUN/'launch.json').exists()
 assert not [r for r in subprocess.check_output(['ps','-axo','pid,command'],text=True).splitlines() if 'The Forest of Love.exe' in r],'Another game is active'
 original=RUN/'Assembly-CSharp.localized-original.dll';parent=Path(json.loads((RUN/'qa-preparation.json').read_text())['parentBuild']);build=json.loads((parent/'build.json').read_text());parent_hashes={r['path']:sha(parent/'game'/DATA/r['path']) for r in build['files']}
 fixture={p.name:sha(p) for p in (GAME/DATA).glob('tfol.*') if p.is_file()}
 expected=json.loads((RUN/'quest-expectations.json').read_text());assert len(expected)==195
 args=['/Applications/CrossOver.app/Contents/SharedSupport/CrossOver/bin/wine','--bottle','/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam','--no-update',str(shared.EXE),'-screen-fullscreen','0','-screen-width','1280','-screen-height','720','-logFile',str(RUN/'player.log')]
 started=time.monotonic();success=False;error=None;captures=[];seen=[];loaded_states=0
 try:
  with (RUN/'wine.log').open('wb') as log:child=subprocess.Popen(args,cwd=GAME,stdin=subprocess.DEVNULL,stdout=log,stderr=subprocess.STDOUT,start_new_session=True)
  write('launch.json',dict(pid=child.pid,command=args,recipeSha256=sha(Path(__file__)),scope='Actual loaded Quest data,photo counters and region/pane consumers;disposable in-memory fixture;no owner saves or award/navigation acceptance'))
  shared.wait_for_probe(child,1800)
  command('show-menu');deadline=time.monotonic()+180
  while True:
   command('quest-ensure');status=(RUN/'notebook-ready.txt').read_text()
   if int(status.split('|')[0])>0 and '|gameplay=True|' in status:break
   assert time.monotonic()<deadline,'required-notebook-resource-not-loaded';time.sleep(.5)
  from PIL import Image
  for sample in range(8):
   name=f'ru-ready-{sample+1:02d}.png';command('capture '+name);p=RUN/name
   if max(v[1] for v in Image.open(p).convert('RGB').getextrema())>20:break
   assert sample<7,'Gameplay render remains blank before popup; do not open during a loading curtain'
   time.sleep(.5)
  command('quest-readback');assert (RUN/'quest-readback.tsv').read_bytes()==(RUN/'quest-expectations.tsv').read_bytes();loaded_states=195
  command('quest-open');deadline=time.monotonic()+30;last=None;stable=0
  while True:
   geometry();area=list(map(float,(RUN/'quest-layout.txt').read_text().split('|')[:4]));stable=stable+1 if last is not None and max(abs(a-b) for a,b in zip(area,last))<.0001 else 0;last=area
   if all(.005<=v<=.995 for v in area) and stable>=3:break
   assert time.monotonic()<deadline,('quest-opening-not-settled',area);time.sleep(.25)
  if (RUN/'journal-header-expectations.tsv').exists():command('quest-headers')
  command('quest-cases');case=(RUN/'quest-case-result.txt').read_text();assert case=='photoMasks=512|photoSlots=60|regionStatusStates=64|sourceAllCompleteActiveAnomalyRetained=true'
  if (RUN/'journal-header-expectations.tsv').exists():command('quest-header-geometry')
  command('quest-title-cases');assert len((RUN/'quest-title-cases.tsv').read_text().splitlines())==38
  surfaces=[('photo-active','top'),('photo-active','bottom'),('photo-completed','top'),('photo-completed','bottom'),('regions','top'),('regions','bottom')]
  for i,(scene,end) in enumerate([] if '--diagnostics-only' in sys.argv else surfaces,1):
   surface=scene+'-'+end;command('quest-show '+scene);command('quest-scroll '+end);expected=(RUN/'quest-shown.txt').read_text().split('|')[1:];deadline=time.monotonic()+30;stable=0
   while True:
    rows=geometry()
    area=list(map(float,(RUN/'quest-layout.txt').read_text().split('|')));correct_scroll=area[-3]<=area[-2]+.1 or abs(area[-1]-(1 if end=='top' else 0))<.005;stable=stable+1 if correct_scroll and len(rows)>=3 and all(r['alpha']>.95 and r['characters']>0 for r in rows) else 0
    if stable>=3:break
    assert time.monotonic()<deadline,('quest-ui-did-not-settle',rows);time.sleep(.25)
   for r in rows:
    assert r['characters']>=r['expected'],('quest-truncated',r)
    assert all(.005<=v<=.995 for v in r['bounds'][:2]),('quest-horizontal-overflow',r)
    if not r['body']:assert all(.005<=v<=.995 for v in r['bounds']),('quest-header-offscreen',r)
   # This finite acceptance fixture must fit at the bounded native size. Do not
   # spend a visual request on a mechanically severed first/last line.
   layout=list(map(float,(RUN/'quest-layout.txt').read_text().split('|')))
   assert layout[-3]<=layout[-2]+.1,('finite-quest-fixture-still-scrolls',surface,layout)
   assert all(r['bounds'][2]>=layout[6]-.001 and r['bounds'][3]<=layout[7]+.001 for r in rows if r['body']),('quest-body-ink-outside-viewport',surface,rows,layout)
   title=next(r for r in rows if r['path'].endswith('/Title'));assert base64.b64encode(title['text'].encode()).decode()==expected[0],('quest-selection-changed',scene,title)
   shutil.copy2(RUN/'quest-layout.txt',RUN/f'layout-{surface}.txt');shutil.copy2(RUN/'quest-geometry.tsv',RUN/f'geometry-{surface}.tsv');shutil.copy2(RUN/'quest-shown.txt',RUN/f'shown-{surface}.txt');seen.append(dict(surface=surface,generatedFields=len(rows),visibleFields=sum(r['visible'] for r in rows)))
   name=f'ru-{i:02d}-quest-{surface}.png';command('capture '+name);p=RUN/name;width,height=struct.unpack('>II',p.read_bytes()[16:24])
   from PIL import Image
   assert max(x[1] for x in Image.open(p).convert('RGB').getextrema())>20,'blank-frame'
   captures.append(dict(filename=name,sha256=sha(p),width=width,height=height))
  if '--diagnostics-only' in sys.argv:
   command('quest-show photo-active');command('quest-diagnostics');command('quest-hud');time.sleep(.4);command('quest-hud-geometry');name='ru-01-quest-hud-diagnostic.png';command('capture '+name);p=RUN/name;width,height=struct.unpack('>II',p.read_bytes()[16:24]);captures.append(dict(filename=name,sha256=sha(p),width=width,height=height))
  if '--diagnostics-only' not in sys.argv:
   command('quest-hud-empty');command('quest-hud-geometry');shutil.copy2(RUN/'quest-hud-geometry.tsv',RUN/'quest-hud-empty-geometry.tsv');
   command('quest-hud');assert (RUN/'quest-hud-master-hidden.txt').read_text().endswith('activeInHierarchy=False');time.sleep(.4);command('quest-hud-geometry');hud=[]
   for line in (RUN/'quest-hud-geometry.tsv').read_text().splitlines()[1:]:
    v=line.split('\t');assert len(v)==10;hud.append(v)
    if float(v[2])>.95:
     assert int(v[3])>=int(v[4]),('hud-truncated',v)
     assert all(.005<=float(x)<=.995 for x in v[5:9]),('hud-ink-offscreen',v)
   assert len(hud)==16 and sum(float(v[2])>.95 for v in hud)>=4,'HUD workload invisible'
   name='ru-07-quest-hud.png';command('capture '+name);p=RUN/name;width,height=struct.unpack('>II',p.read_bytes()[16:24]);captures.append(dict(filename=name,sha256=sha(p),width=width,height=height))
  command('display-diagnostics')
  success=True
 except BaseException as ex:error=repr(ex);print(error,flush=True)
 finally:
  restore_error=None
  if shared.processes():
   try:command('quest-restore')
   except Exception as ex:restore_error=repr(ex)
  quit_error=None
  if shared.processes() and not (RUN/'command.txt').exists():
   try:command('quit')
   except Exception as ex:quit_error=repr(ex)
  deadline=time.monotonic()+30
  while shared.processes() and time.monotonic()<deadline:time.sleep(.5)
  remaining=shared.processes()
  if not remaining:
   shutil.copy2(original,GAME/DATA/'Managed/Assembly-CSharp.dll');(GAME/DATA/'Managed/ForestProbe.dll').unlink(missing_ok=True)
  unchanged=all(sha(parent/'game'/DATA/n)==h for n,h in parent_hashes.items())
  write('cleanup.json',dict(taskOwnedProcessesAbsent=not remaining,remainingTaskProcessRows=remaining,quitError=quit_error,restoreError=restore_error,stagedManagedStateRestoreReceipt=(RUN/'quest-restored.txt').read_text() if (RUN/'quest-restored.txt').exists() else None,localizedAssemblyRestored=sha(GAME/DATA/'Managed/Assembly-CSharp.dll')==sha(original),bridgeRemoved=not (GAME/DATA/'Managed/ForestProbe.dll').exists(),parentArtifactUnchanged=unchanged,ownerGameClosedOrControlled=False,ownerSaveFilesUsed=False,qaFixtureBefore=fixture,qaFixtureAfter={p.name:sha(p) for p in (GAME/DATA).glob('tfol.*') if p.is_file()}))
  write('runtime-result.json',dict(automatedResult='pass' if success and not remaining and unchanged and restore_error is None else 'fail',result='capture-pass-review-pending' if success and not remaining and unchanged and restore_error is None else 'automated-fail',error=error,captures=captures,surfaces=seen,loadedStatesCompared=loaded_states,durationSeconds=round(time.monotonic()-started,3),boundary='Actual loaded Quest195 states;original pane/counter/region consumers with reversible synthetic in-memory status/unlock/priority/trigger fixtures.Original label refresh/selection resources;no user input,award,real progression or owner-save continuation acceptance.Artwork unchanged.',visual='pending' if captures else 'not-run'))
 assert success and not remaining and unchanged and restore_error is None,(error,remaining,restore_error)
 print('Quest capture finished;195 loaded states match;actual pane cases and cleanup recorded;visual review separate',flush=True)
if __name__=='__main__':main()
