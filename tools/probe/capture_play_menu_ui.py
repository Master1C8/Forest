"""Capture the conditional Act 1 row and bind the Gallery header artwork."""
import json,shutil,struct,subprocess,time
from pathlib import Path
import capture_menu_ui as menu
shared=menu.shared;RUN,GAME,DATA=menu.RUN,menu.GAME,menu.DATA
sha,write=menu.sha,menu.write

def main():
    assert not shared.processes() and not (RUN/'launch.json').exists()
    original=RUN/'Assembly-CSharp.localized-original.dll';parent=Path(json.loads((RUN/'qa-preparation.json').read_text())['parentBuild'])
    parent_hashes={r['path']:sha(parent/'game'/DATA/r['path']) for r in json.loads((RUN/'build.json').read_text())['files']}
    args=['/Applications/CrossOver.app/Contents/SharedSupport/CrossOver/bin/wine','--bottle','/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam','--no-update',str(shared.EXE),'-screen-fullscreen','0','-screen-width','1280','-screen-height','720','-logFile',str(RUN/'player.log')]
    success=False;error=None;started=time.monotonic();capture=None
    try:
        with (RUN/'wine.log').open('wb') as log:child=subprocess.Popen(args,cwd=GAME,stdin=subprocess.DEVNULL,stdout=log,stderr=subprocess.STDOUT,start_new_session=True)
        write('launch.json',{'pid':child.pid,'command':args,'captureRecipeSha256':sha(Path(__file__)),'scope':'Act 1 row visibility staged; original text/renderer, no unlock data or save flag changes'})
        deadline=time.monotonic()+300
        while not (RUN/'player.log').exists() or 'FOREST_PROBE_READY' not in (RUN/'player.log').read_text(errors='replace'):
            assert time.monotonic()<deadline,'startup-marker-timeout';time.sleep(1)
        menu.command('show-menu');menu.command('menu-panel gallery');time.sleep(.8)
        images=(RUN/'gallery-active-images.tsv').read_text();assert 'gallery_act1' in images
        menu.command('menu-panel play');time.sleep(.8);menu.command('menu-play-act1');time.sleep(.2);state,rows=menu.geometry()
        expected=[r['target'] for r in json.loads((RUN/'build.json').read_text())['menuTranslations'] if r['source'] in ('Start from:','Act 1')]
        for target in set(expected):assert any(r['text']==target and r['visible'] for r in rows),('missing-conditional-caption',target)
        shutil.copy2(RUN/'menu-geometry.tsv',RUN/'geometry-play.tsv');write('state-play.json',state)
        menu.command('capture ru-01-play.png');p=RUN/'ru-01-play.png';width,height=struct.unpack('>II',p.read_bytes()[16:24])
        capture={'filename':p.name,'sha256':sha(p),'width':width,'height':height};success=True
    except BaseException as ex:error=repr(ex);print(error,flush=True)
    finally:
        owned=shared.processes();quit_error=None
        if owned and not (RUN/'command.txt').exists():
            try:menu.command('quit')
            except Exception as ex:quit_error=repr(ex)
        deadline=time.monotonic()+30
        while shared.processes() and time.monotonic()<deadline:time.sleep(.5)
        remaining=shared.processes()
        if not remaining:
            shutil.copy2(original,GAME/DATA/'Managed/Assembly-CSharp.dll');(GAME/DATA/'Managed/ForestProbe.dll').unlink(missing_ok=True)
        unchanged=all(sha(parent/'game'/DATA/name)==value for name,value in parent_hashes.items())
        write('cleanup.json',{'taskOwnedProcessesAbsent':not remaining,'remainingTaskProcessRows':remaining,'quitError':quit_error,'localizedAssemblyRestored':sha(GAME/DATA/'Managed/Assembly-CSharp.dll')==sha(original),'bridgeRemoved':not (GAME/DATA/'Managed/ForestProbe.dll').exists(),'parentArtifactUnchanged':unchanged,'ownerGameClosedOrControlled':False,'ownerSaveFilesUsed':False})
        write('runtime-result.json',{'result':'passed' if success and not remaining and unchanged else 'failed','error':error,'capture':capture,'durationSeconds':round(time.monotonic()-started,3),'boundary':'Real translated Act 1 controls and original TMP renderer; only chapter-row visibility staged for early QA fixture. Chapter-unlock behavior is not exercised. Gallery metadata is read-only.','visual':'pending'})
    assert success and not remaining and unchanged,(error,remaining)
    print('Conditional Play captions captured; Gallery sprite bindings recorded',flush=True)
if __name__=='__main__':main()
