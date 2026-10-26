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
    assert report['coherentLegacyFace'] and len(report['files'])==5
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
        write('launch.json',{'pid':child.pid,'startedAt':now(),'command':args,'buildSha256':sha(RUN/'build.json'),'bridgeSha256':sha(RUN/'bridge-build.json'),'captureRecipeSha256':sha(Path(__file__)),'commandHelperSha256':sha(COMMAND),'scope':'One isolated synthetic candidate; no desktop input or activation'})
        until=time.monotonic()+300
        while not (RUN/'player.log').exists() or 'FOREST_PROBE_READY' not in (RUN/'player.log').read_text(errors='replace'):
            assert time.monotonic()<until, 'Startup marker timeout'
            time.sleep(1)
        (RUN/'actions.log').touch(exist_ok=True)
        command('show-menu'); d=dump(); assert d['scene']=='StartMenu'
        write('main-menu.json',d)
        command('menu StartScreenMainMenu OnClickStart'); d=dump()
        assert 'Canvas/PlayMenu/Controls/New' in d['buttons']; write('play-menu.json',d)
        command('menu PlayMenu OnClickStart')
        deadline=time.monotonic()+480; last=None; advanced=set()
        original_intro={265,259,260,266,267,261,262,263}
        while time.monotonic()<deadline:
            time.sleep(1.5); d=dump()
            assert d['scene'] in ['StartMenu','ChapterSelect','IntroForest','BunnyHouse'],d['scene']
            key=(d['scene'],d['conversationId'],d['entryId'],d['typing'])
            with (RUN/'state-transitions.jsonl').open('a') as f:
                f.write(json.dumps({'at':now(),'scene':d['scene'],'conversationId':d['conversationId'],'entryId':d['entryId'],'typing':d['typing'],'text':d['conversationState']},ensure_ascii=False)+'\n')
            if key!=last: print('state',key,flush=True); last=key
            cid,eid=d['conversationId'],d['entryId']
            if cid!=145 or d['typing']: continue
            if eid in original_intro:
                assert eid not in advanced, 'Continue did not change original entry'
                command('continue'); advanced.add(eid); continue
            if eid in [197,199,200,202,203]:
                if not seen or seen[-1]!=eid: seen.append(eid)
                expected=SAMPLE+({197:'\nЕ\u0308 и\u0306',199:'\nЁ й',200:'  ',202:'  '}.get(eid,''))
                if eid!=203:
                    assert d['conversationState']==expected,(eid,d['conversationState'])
                    subtitle=[x.split(' | ') for x in d['rendererDiagnostics'] if x.split(' | ')[0].endswith('/Subtitle Text')]
                    assert len(subtitle)==1 and subtitle[0][2] in [expected,'<noparse></noparse>'+expected] and subtitle[0][-1]=='overflow=False', 'Subtitle missing or overflow'
                if eid in [197,199]:
                    command('probe-nameplate'); d=dump()
                    native=[x for x in d['rendererDiagnostics'] if 'UnityEngine.UI.Text | Ёж Йй 123' in x]
                    assert len(native)==1 and 'fontNames=Liberation Sans' in native[0] and 'hasCyrillicAndDigits=True' in native[0],native
                    name='ru-01-renderer-nfd.png' if eid==197 else 'ru-02-renderer-nfc.png'
                    write('captured-state-'+str(eid)+'.json',d)
                    command('capture '+name); captures.append(name)
                    print('captured',name,flush=True)
                write('entry-'+str(eid)+'.json',d)
                if eid==203:
                    assert d['conversationState']=='You’ve been out for quite a while, dear.'
                    assert seen==[197,199,200,202,203],seen
                    success=True; break
                assert eid not in advanced,'Continue did not change synthetic entry'
                command('continue'); advanced.add(eid)
            else:
                raise AssertionError(('Unknown active dialogue',cid,eid,d['conversationState']))
        assert success,'Guarded progression deadline'
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
        write('runtime-result.json',{'date':now(),'automatedResult':'passed' if success and not remaining and unchanged else 'failed','error':error,'normalButtonProgression':seen,'captures':captures,'durationSeconds':round(time.monotonic()-started,3),'buildSha256':sha(RUN/'build.json'),'bridgeBuildSha256':sha(RUN/'bridge-build.json'),'naturalCompletion':'passed' if success else 'unverified','visual':'pending; text-only capture context has opened no image','completeFeasibilityGate':'unaccepted; all other surfaces and final corpus remain unverified'})
    assert success and not remaining and unchanged,error
if __name__=='__main__': main()
