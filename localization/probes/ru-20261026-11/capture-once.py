#!/usr/bin/env python3
"""One versioned attempt using the existing bridge commands, with unconditional restoration."""
import datetime, hashlib, json, os, shutil, subprocess, sys, time
from pathlib import Path

RUN=Path(__file__).resolve().parent
PROJECT=RUN.parents[2]
SOURCE=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')
GAME=RUN/'game'; DATA='The Forest of Love_Data'; EXE=GAME/'The Forest of Love.exe'
COMMAND=RUN/'command.py'
SAMPLE='Ёж, съешь ещё этих мягких булок. Йй Щщ Ъъ Ыы Ьь Ээ Юю Яя; 123 — Latin!'
def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def now(): return datetime.datetime.now(datetime.timezone.utc).isoformat()
def write(n,v): (RUN/n).write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
def processes():
    rows=subprocess.check_output(['ps','-axo','pid,ppid,command'],text=True).splitlines()
    paths=[str(EXE), 'Z:'+str(EXE).replace('/',chr(92)), 'Y:'+chr(92)+str(EXE.relative_to(Path('/Users/antonkrutov'))).replace('/',chr(92))]
    return [r.strip() for r in rows if any(p in r for p in paths)]
def command(c):
    r=subprocess.run([sys.executable,str(COMMAND),str(RUN),c],capture_output=True,text=True,timeout=25)
    assert r.returncode==0, (c,r.stdout[-500:],r.stderr[-500:])
def dump():
    command('dump'); d=json.loads((RUN/'state.json').read_text())
    assert d['company']=='VNRevivalQA' and d['product']=='ForestRuRendererProbe'
    assert d['dataPath'].replace('\\','/').endswith('/localization/probes/'+RUN.name+'/game/'+DATA)
    return d

def main():
    assert not (RUN/'launch.json').exists() and not processes(), 'Reconcile prior launch before rerunning'
    assert COMMAND.is_file()
    report=json.loads((RUN/'build.json').read_text())
    assert report['coherentLegacyFace'] and report['coherentTmpFace'] and len(report['files'])==5
    originals={row['path']:sha(SOURCE/DATA/row['path']) for row in report['files']}
    original_extra={str(p.relative_to(SOURCE)):sha(p) for p in SOURCE.glob('tfol.*') if p.is_file()}
    original_extra[DATA+'/Managed/Assembly-CSharp.dll']=sha(SOURCE/DATA/'Managed/Assembly-CSharp.dll')
    write('original-before.json',{'assets':originals,'other':original_extra})
    assert not list(GAME.glob('tfol.*')), 'Copied owner files are forbidden'
    args=['/Applications/CrossOver.app/Contents/SharedSupport/CrossOver/bin/wine','--bottle','/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam','--no-update',str(EXE),'-screen-fullscreen','0','-screen-width','1280','-screen-height','720','-logFile',str(RUN/'player.log')]
    started=time.monotonic(); child=None; success=False; quit_ok=False; error=None; seen=[]; captures=[]; owned=[]
    try:
        with (RUN/'wine.log').open('wb') as log:
            child=subprocess.Popen(args,cwd=GAME,stdout=log,stderr=subprocess.STDOUT,start_new_session=True)
        write('launch.json',{'pid':child.pid,'startedAt':now(),'command':args,'buildSha256':sha(RUN/'build.json'),'bridgeSha256':sha(RUN/'bridge-build.json'),'captureRecipeSha256':sha(Path(__file__)),'commandHelperSha256':sha(COMMAND),'scope':'One isolated settings synthetic candidate; real menu handlers, no desktop input or activation'})
        until=time.monotonic()+300
        while not (RUN/'player.log').exists() or 'FOREST_PROBE_READY' not in (RUN/'player.log').read_text(errors='replace'):
            assert time.monotonic()<until, 'Startup marker timeout'
            time.sleep(1)
        (RUN/'actions.log').touch(exist_ok=True)
        command('show-menu'); d=dump(); assert d['scene']=='StartMenu'
        assert 'StartScreenMainMenu Canvas/MainMenu' in d['components']
        write('main-menu.json',d)
        command('menu StartScreenMainMenu OnClickOptions'); d=dump()
        assert 'OptionsMenu Canvas/OptionsMenu' in d['components']
        assert 'StartScreenMainMenu Canvas/MainMenu' not in d['components']
        rows=[x for x in d['rendererDiagnostics'] if x.startswith('Canvas/OptionsMenu/')]
        expected=report['menuSamples']
        counts={sample:sum((' | TMPro.TextMeshProUGUI | '+sample+' | ') in x for x in rows) for sample in expected.values()}
        assert counts=={sample:6 for sample in expected.values()},counts
        assert all('overflow=False' in x for x in rows if any((' | '+sample+' | ') in x for sample in expected.values())), 'Settings sample overflow'
        assert not any((' | '+old+' | ') in x for old in expected for x in rows), 'Source label remains in selected hierarchy'
        assert d['width']==1440 and d['height']==900,(d['width'],d['height'])
        write('settings-state.json',d)
        name='ru-01-settings-synthetic.png'
        command('capture '+name); captures.append(name)
        print('captured',name,counts,flush=True)
        command('menu OptionsMenu OnClickBack'); d=dump()
        assert 'StartScreenMainMenu Canvas/MainMenu' in d['components']
        assert 'OptionsMenu Canvas/OptionsMenu' not in d['components']
        write('returned-main-menu.json',d)
        seen=['main-menu','options-menu','main-menu']
        success=True
    except BaseException as ex:
        error=repr(ex); print(error,flush=True)
        if (RUN/'actions.log').exists() and not (RUN/'command.txt').exists():
            try: command('capture ru-99-failure.png')
            except Exception: pass
    finally:
        owned=processes()
        if owned and not (RUN/'command.txt').exists():
            try: command('quit'); quit_ok=True
            except Exception as ex: error=(error or '')+' cleanup quit: '+repr(ex)
        until=time.monotonic()+30
        while processes() and time.monotonic()<until: time.sleep(.5)
        remaining=processes()
        if not remaining:
            managed=GAME/DATA/'Managed'
            shutil.copy2(SOURCE/DATA/'Managed/Assembly-CSharp.dll',managed/'Assembly-CSharp.dll')
            (managed/'ForestProbe.dll').unlink(missing_ok=True)
        unchanged=all(sha(SOURCE/DATA/n)==h for n,h in originals.items()) and all(sha(SOURCE/n)==h for n,h in original_extra.items())
        write('cleanup.json',{'date':now(),'verifiedTaskProcessRowsBeforeQuit':owned,'remainingTaskProcessRows':remaining,'taskOwnedProcessesAbsent':not remaining,'quitAcknowledged':quit_ok,'inspectionBridgeRemoved':not (GAME/DATA/'Managed/ForestProbe.dll').exists(),'originalAssemblyRestoredInQACopy':sha(GAME/DATA/'Managed/Assembly-CSharp.dll')==original_extra[DATA+'/Managed/Assembly-CSharp.dll'],'originalAssetsAndPlayerFilesUnchanged':unchanged,'ownerSavePathUsed':False,'persistentDataPath':'C:/users/crossover/AppData/LocalLow/VNRevivalQA/ForestRuRendererProbe','candidateAssetHashesUnchanged':all(sha(GAME/DATA/r['path'])==r['probeSha256'] for r in report['files'])})
        write('runtime-result.json',{'date':now(),'automatedResult':'passed' if success and not remaining and unchanged else 'failed','error':error,'guardedMenuProgression':seen,'captures':captures,'durationSeconds':round(time.monotonic()-started,3),'buildSha256':sha(RUN/'build.json'),'bridgeBuildSha256':sha(RUN/'bridge-build.json'),'settingsControlsPreserved':'passed' if success else 'unverified','visual':'pending; text-only capture context has opened no image','completeFeasibilityGate':'unaccepted; all other surfaces and final corpus remain unverified'})
    assert success and not remaining and unchanged,error
if __name__=='__main__': main()
