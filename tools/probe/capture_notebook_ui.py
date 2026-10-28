"""Capture each actual notebook page in a disposable, source-bound QA profile."""
import base64,json,re,shutil,struct,subprocess,time
from pathlib import Path
import capture_settings as shared
RUN,GAME,DATA=shared.RUN,shared.GAME,shared.DATA
sha,write,command=shared.sha,shared.write,shared.command

def geometry():
 command('notebook-geometry');rows=[]
 for line in (RUN/'notebook-geometry.tsv').read_text().splitlines()[1:]:
  v=line.split('\t');assert len(v)==10,v
  rows.append(dict(path=v[0],text=base64.b64decode(v[1]).decode(),alpha=float(v[2]),lines=int(v[3]),overflow=v[4],bounds=list(map(float,v[5:9])),gap=float(v[9])))
 return rows

def main():
 assert not shared.processes() and not (RUN/'launch.json').exists()
 assert not [r for r in subprocess.check_output(['ps','-axo','pid,command'],text=True).splitlines() if 'The Forest of Love.exe' in r],'Another game is active'
 original=RUN/'Assembly-CSharp.localized-original.dll';parent=Path(json.loads((RUN/'qa-preparation.json').read_text())['parentBuild']);build=json.loads((parent/'build.json').read_text());parent_hashes={r['path']:sha(parent/'game'/DATA/r['path']) for r in build['files']}
 fixture={p.name:sha(p) for p in (GAME/DATA).glob('tfol.*') if p.is_file()}
 expected=json.loads((RUN/'notebook-expectations.json').read_text());assert len(expected)==156
 args=['/Applications/CrossOver.app/Contents/SharedSupport/CrossOver/bin/wine','--bottle','/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam','--no-update',str(shared.EXE),'-screen-fullscreen','0','-screen-width','1280','-screen-height','720','-logFile',str(RUN/'player.log')]
 started=time.monotonic();success=False;error=None;captures=[];seen=[]
 try:
  with (RUN/'wine.log').open('wb') as log:child=subprocess.Popen(args,cwd=GAME,stdin=subprocess.DEVNULL,stdout=log,stderr=subprocess.STDOUT,start_new_session=True)
  write('launch.json',dict(pid=child.pid,command=args,recipeSha256=sha(Path(__file__)),scope='Actual PagedTutorial prefab/consumer and all five pages; no awards or owner saves'))
  shared.wait_for_probe(child,300)
  command('show-menu');deadline=time.monotonic()+60
  while True:
   command('notebook-ensure');status=(RUN/'notebook-ready.txt').read_text()
   if int(status.split('|')[0])>0 and '|gameplay=True|' in status:break
   assert time.monotonic()<deadline,'required-notebook-resource-not-loaded';time.sleep(.5)
  from PIL import Image
  for sample in range(8):
   name=f'ru-ready-{sample+1:02d}.png';command('capture '+name);p=RUN/name
   if max(v[1] for v in Image.open(p).convert('RGB').getextrema())>20:break
   assert sample<7,'Gameplay render remains blank before popup; do not open during a loading curtain'
   time.sleep(.5)
  command('notebook-open');time.sleep(.8)
  for page in range(5):
   command('notebook-page '+str(page));deadline=time.monotonic()+8
   while True:
    rows=geometry()
    if rows and all(r['alpha']>.95 for r in rows):break
    assert time.monotonic()<deadline,'notebook-fade-did-not-settle';time.sleep(.25)
   raw={v[0]:base64.b64decode(v[1]).decode() for v in [x.split('\t') for x in (RUN/'notebook-runtime-texts.tsv').read_text().splitlines()]}
   assert len(raw)==156 and all(raw[r['hierarchy']]==r['target'] for r in expected),'Runtime notebook copy differs from authored records'
   for r in rows:
    assert '/Page'+str(page+1)+'/' in r['path'],('wrong-visible-page',page,r)
    assert r['overflow']=='False',('notebook-overflow',r)
    assert all(.005<=v<=.995 for v in r['bounds']),('notebook-offscreen',r)
    assert r['gap']>=0,('notebook-line-overlap',r)
   shutil.copy2(RUN/'notebook-geometry.tsv',RUN/f'geometry-page-{page+1}.tsv');seen.append(dict(page=page+1,visibleFields=len(rows),minimumGap=min(r['gap'] for r in rows)))
   name=f'ru-{page+1:02d}-notebook-page-{page+1}.png';command('capture '+name);p=RUN/name;width,height=struct.unpack('>II',p.read_bytes()[16:24])
   from PIL import Image
   assert max(x[1] for x in Image.open(p).convert('RGB').getextrema())>20,'blank-frame'
   captures.append(dict(filename=name,sha256=sha(p),width=width,height=height))
  command('display-diagnostics')
  success=True
 except BaseException as ex:error=repr(ex);print(error,flush=True)
 finally:
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
  write('cleanup.json',dict(taskOwnedProcessesAbsent=not remaining,remainingTaskProcessRows=remaining,quitError=quit_error,localizedAssemblyRestored=sha(GAME/DATA/'Managed/Assembly-CSharp.dll')==sha(original),bridgeRemoved=not (GAME/DATA/'Managed/ForestProbe.dll').exists(),parentArtifactUnchanged=unchanged,ownerGameClosedOrControlled=False,ownerSaveFilesUsed=False,qaFixtureBefore=fixture,qaFixtureAfter={p.name:sha(p) for p in (GAME/DATA).glob('tfol.*') if p.is_file()}))
  write('runtime-result.json',dict(result='passed' if success and not remaining and unchanged else 'failed',error=error,captures=captures,pages=seen,loadedFieldsCompared=156 if seen else 0,durationSeconds=round(time.monotonic()-started,3),boundary='Original ItemGetNotification.ShowPagedTutorial and five-page prefab; page visibility staged without OnSubmit/Finish; no item award or owner-save continuation acceptance. Artwork and source controls remain unchanged.',visual='pending' if captures else 'not-run'))
 assert success and not remaining and unchanged,(error,remaining)
 print('Five notebook pages captured;156 loaded fields match;UI Camera bounds/line spacing pass;cleanup complete',flush=True)
if __name__=='__main__':main()
