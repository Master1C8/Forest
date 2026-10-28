"""Verify loaded item data and real notification formatters in a disposable game."""
import json,re,shutil,struct,subprocess,time
from pathlib import Path
import capture_settings as shared
RUN,GAME,DATA=shared.RUN,shared.GAME,shared.DATA
sha,write,command=shared.sha,shared.write,shared.command

def main():
    assert not shared.processes() and not (RUN/'launch.json').exists()
    # No other actual Forest game may be controlled or overlapped by this run.
    rows=subprocess.check_output(['ps','-axo','pid,command'],text=True).splitlines()
    assert not [r for r in rows if 'The Forest of Love.exe' in r], 'Another game is active'
    original=RUN/'Assembly-CSharp.localized-original.dll';parent=Path(json.loads((RUN/'qa-preparation.json').read_text())['parentBuild'])
    parent_hashes={r['path']:sha(parent/'game'/DATA/r['path']) for r in json.loads((RUN/'build.json').read_text())['files']}
    fixture={p.name:sha(p) for p in (GAME/DATA).glob('tfol.*') if p.is_file()}
    args=['/Applications/CrossOver.app/Contents/SharedSupport/CrossOver/bin/wine','--bottle','/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam','--no-update',str(shared.EXE),'-screen-fullscreen','0','-screen-width','1280','-screen-height','720','-logFile',str(RUN/'player.log')]
    success=False;error=None;started=time.monotonic();captures=[]
    try:
        with (RUN/'wine.log').open('wb') as log:child=subprocess.Popen(args,cwd=GAME,stdin=subprocess.DEVNULL,stdout=log,stderr=subprocess.STDOUT,start_new_session=True)
        write('launch.json',dict(pid=child.pid,command=args,recipeSha256=sha(Path(__file__)),scope='Original notification prefab staged in the fully visible StartMenu; no continuation or item-award event'))
        shared.wait_for_probe(child,300)
        command('show-menu')
        command('dump');state=json.loads((RUN/'state.json').read_text());assert state['scene']=='StartMenu'
        write('staged-menu-state.json',state)
        deadline=time.monotonic()+40
        while True:
            command('items-ready')
            if (RUN/'items-ready.txt').read_text().strip()=='48':break
            assert time.monotonic()<deadline,'runtime-inventory-not-ready';time.sleep(.5)
        # String rows alone do not establish the notification workload. Follow
        # the original Continue route into the disposable fixture's gameplay
        # scene so its item sprite resources are actually available.
        deadline=time.monotonic()+180
        while True:
            command('items-gameplay')
            if (RUN/'items-gameplay.txt').read_text().startswith('True|'):break
            assert time.monotonic()<deadline,'item-gameplay-resources-not-ready';time.sleep(.5)
        command('items-readback')
        assert (RUN/'item-readback.tsv').read_bytes()==(RUN/'item-expectations.tsv').read_bytes()
        for i,action in enumerate(['received','found','delivered','glitch'],1):
            command('items-display '+action)
            report=(RUN/('notification-'+action+'.txt')).read_text();assert report.strip() and 'overflow=True' not in report,report
            if shared.DIAGNOSTICS_ONLY:
                for sample in range(8):
                    time.sleep(.4);command('items-geometry '+action)
                continue
            deadline=time.monotonic()+8
            while True:
                command('items-geometry '+action)
                block=(RUN/('geometry-'+action+'.txt')).read_text().split('END\n')[-2]
                marker=block.splitlines()[0]
                normalized=float(marker.split('|')[1]);camera=[x for x in block.splitlines() if x.startswith('camera|UI Camera|')]
                assert len(camera)==1,('exact-ui-camera',camera)
                bounds=list(map(float,re.search(r'viewport=([^|]+)',camera[0])[1].split(',')))
                if normalized>=1 and all(.02<=v<=.98 for v in bounds):break
                assert normalized<1.25 and time.monotonic()<deadline,('notification-outside-viewport',action,bounds,marker)
                time.sleep(.2)
            if action in ('received','glitch'):
                time.sleep(.35);name='ru-01-item-received.png' if action=='received' else 'ru-02-glitch-item.png';command('capture '+name);p=RUN/name
                width,height=struct.unpack('>II',p.read_bytes()[16:24])
                from PIL import Image
                extrema=Image.open(p).convert('RGB').getextrema();assert max(channel[1] for channel in extrema)>20,('blank-capture',extrema)
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
        fixture_after={p.name:sha(p) for p in (GAME/DATA).glob('tfol.*') if p.is_file()}
        write('cleanup.json',dict(taskOwnedProcessesAbsent=not remaining,remainingTaskProcessRows=remaining,quitError=quit_error,localizedAssemblyRestored=sha(GAME/DATA/'Managed/Assembly-CSharp.dll')==sha(original),bridgeRemoved=not (GAME/DATA/'Managed/ForestProbe.dll').exists(),parentArtifactUnchanged=unchanged,ownerGameClosedOrControlled=False,ownerSaveFilesUsed=False,qaFixtureBefore=fixture,qaFixtureAfter=fixture_after))
        write('runtime-result.json',dict(result='passed' if success and not remaining and unchanged else 'failed',error=error,captures=captures,durationSeconds=round(time.monotonic()-started,3),boundary='48 actual DataService items/96 strings; original Continue route into the disposable QA fixture and actual gameplay notification prefab/font/sprite resources. Display calls bypass item awarding events; no ownership, real progression or owner-save acceptance. Source sprite availability is required before display.',visual='pending' if captures else 'not-run'))
    assert success and not remaining and unchanged,(error,remaining)
    print('48 items/96 strings loaded; four real notification displays passed; cleanup complete',flush=True)
if __name__=='__main__':main()
