#!/usr/bin/env python3
"""One versioned attempt using the existing bridge commands, with unconditional restoration."""
import datetime, hashlib, json, re, shutil, subprocess, sys, time
from pathlib import Path

RUN=Path(sys.argv[1]).resolve()
SCALE_TEST=len(sys.argv)==3 and sys.argv[2]=='--scale-test'
DIAGNOSTICS_ONLY=(len(sys.argv)==3 and sys.argv[2]=='--diagnostics-only') or SCALE_TEST
assert len(sys.argv)==2 or DIAGNOSTICS_ONLY, 'run [--diagnostics-only|--scale-test]'
PROJECT=RUN.parents[2]
SOURCE=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')
GAME=RUN/'game'; DATA='The Forest of Love_Data'; EXE=GAME/'The Forest of Love.exe'
COMMAND=RUN/'command.py'
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
    assert RUN.parent == PROJECT/'localization/probes'
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
        expected=report['menuSamples']
        def settings_state(fullscreen):
            state=dump()
            assert state['fullscreen']==fullscreen, state['fullscreen']
            assert 'OptionsMenu Canvas/OptionsMenu' in state['components']
            rows=[x for x in state['rendererDiagnostics'] if x.startswith('Canvas/OptionsMenu/')]
            wanted={'Fullscreen:', 'Stretch:' if fullscreen else 'Scale:'}
            counts={old:sum((' | TMPro.TextMeshProUGUI | '+sample+' | ') in x for x in rows) for old,sample in expected.items()}
            assert counts=={old:6 if old in wanted else 0 for old in expected}, counts
            assert all('overflow=False' in x for x in rows if any((' | '+sample+' | ') in x for sample in expected.values())), 'Settings sample overflow'
            assert not any((' | '+old+' | ') in x for old in expected for x in rows), 'Source label remains'
            for binding in report.get('settingsValueImageRepair', []):
                images=[x for x in state['settingsControlDiagnostics'] if x.startswith(binding['hierarchy']+' |')]
                assert len(images)==1, ('Image diagnostics missing or ambiguous', binding['hierarchy'], images)
                assert ' | enabled=False |' in images[0], ('Legacy duplicate Image still enabled', binding['hierarchy'], images)
            value='Canvas/OptionsMenu/Controls/'+('FullscreenStretch' if fullscreen else 'Fullscreen')+'/Off/'
            if not fullscreen or not state['stretch']:
                assert sum(x.startswith(value) and ' | TMPro.TextMeshProUGUI | Off |' in x for x in rows)==6, 'Off TMP replacement family incomplete'
            return state
        if not d['fullscreen']:
            assert 'Canvas/OptionsMenu/Controls/Fullscreen' in d['buttons']
            command('click Canvas/OptionsMenu/Controls/Fullscreen')
        d=settings_state(True)
        initial_stretch=d['stretch']
        # Real control changes exercise both value branches without bypassing their handlers.
        assert 'Canvas/OptionsMenu/Controls/FullscreenStretch' in d['buttons']
        command('click Canvas/OptionsMenu/Controls/FullscreenStretch'); toggled=settings_state(True)
        assert toggled['stretch']!=initial_stretch
        write('stretch-toggled-state.json',toggled)
        command('click Canvas/OptionsMenu/Controls/FullscreenStretch'); d=settings_state(True)
        assert d['stretch']==initial_stretch
        assert not d['stretch'], 'Pinned pilot requires the observed Stretch Off state'
        assert d['width']==1440 and d['height']==900,(d['width'],d['height'])
        write('settings-fullscreen-state.json',d)
        if not DIAGNOSTICS_ONLY:
            name='ru-01-settings-fullscreen.png'; command('capture '+name); captures.append(name)
            print('captured',name,flush=True)
        command('click Canvas/OptionsMenu/Controls/Fullscreen'); d=settings_state(False)
        write('settings-windowed-state.json',d)
        slots=[row for row in d['settingsControlDiagnostics'] if re.search(r'/Multipliers/[1-8]x \|',row)]
        assert len(slots)==8, 'Scale Image slot inventory changed'
        active=[row for row in slots if 'activeInHierarchy=True' in row]
        assert len(active)==1 and '/'+str(d['scaleIndex']+1)+'x |' in active[0], 'Scale index/active Image disagree'
        if SCALE_TEST:
            base='Canvas/OptionsMenu/Controls/ScaleFactor'
            initial_index=d['scaleIndex']; transitions=[]; reached={initial_index}
            eligibility=[]
            for row in d['scaleEligibility']:
                m=re.fullmatch(r'(\d+) \| width=(\d+) \| height=(\d+) \| eligible=(True|False)',row)
                assert m, row
                i,w,h=map(int,m.group(1,2,3)); eligible=m[4]=='True'
                assert i==len(eligibility), 'Scale eligibility order changed'
                expected_eligible=i==1 or (i!=0 and w<d['displayWidth'] and h<d['displayHeight'])
                assert eligible==expected_eligible, ('Eligibility contradicts source',row,d['displayWidth'],d['displayHeight'])
                eligibility.append({'index':i,'width':w,'height':h,'eligible':eligible})
            assert len(eligibility)==8
            command('select '+base); d=dump()
            assert d['selectedControl']==base
            write('scale-selected-state.json',d)
            for direction,delta,flag in [('right',1,'canScaleUp'),('left',-1,'canScaleDown')]:
                for step in range(9):
                    before=d; can=before[flag]; expected_index=before['scaleIndex']+(delta if can else 0)
                    # Dispatch through normal Move navigation. Source binds the arrow's
                    # Select event, not Button.onClick. An unchanged final state alone
                    # does not prove intermediate arrow selection or handler entry.
                    assert before['selectedControl']==base
                    command('move-'+direction); d=dump()
                    assert d['scaleIndex']==expected_index, (direction,before['scaleIndex'],can,d['scaleIndex'])
                    assert d['selectedControl']==base, 'Normal delayed reselection failed'
                    assert (d['width'],d['height'])==(eligibility[expected_index]['width'],eligibility[expected_index]['height'])
                    active=[x for x in d['settingsControlDiagnostics'] if re.search(r'/Multipliers/[1-8]x \|',x) and 'activeInHierarchy=True' in x]
                    assert len(active)==1 and '/'+str(expected_index+1)+'x |' in active[0]
                    name='scale-'+direction+'-'+str(step)+'-state.json';write(name,d)
                    transitions.append({'command':'move-'+direction,'beforeIndex':before['scaleIndex'],'allowed':can,'expectedIndex':expected_index,'actualIndex':d['scaleIndex'],'state':name,'selectedControl':d['selectedControl']})
                    if expected_index not in reached and len(captures)<2:
                        name='ru-'+str(len(captures)+1).zfill(2)+'-settings-scale-'+str(expected_index+1)+'x.png'
                        command('capture '+name);captures.append(name)
                    reached.add(expected_index)
                    if not can: break
                else: raise AssertionError('Scale bound not reached within source slot count')
            for step in range(8):
                if d['scaleIndex']==initial_index: break
                delta=1 if d['scaleIndex']<initial_index else -1
                assert d['canScaleUp' if delta==1 else 'canScaleDown']
                previous_index=d['scaleIndex']
                command('move-right' if delta==1 else 'move-left');d=dump()
                assert d['scaleIndex']==previous_index+delta, 'Scale restoration made no expected progress'
            assert d['scaleIndex']==initial_index, 'Scale restoration exceeded source slot bound'
            write('scale-restored-state.json',d)
            write('scale-interaction.json',{'display':[d['displayWidth'],d['displayHeight']],'eligibility':eligibility,'transitions':transitions,'reachedIndices':sorted(reached),'initialIndex':initial_index,'restoredIndex':d['scaleIndex'],'inputBoundary':'EventSystem selection then ExecuteEvents.moveHandler; post-state checked against source-backed eligibility. No private flag/index writes. Intermediate navigation target/handler entry and OS keyboard/controller delivery are not measured; no-op alone does not establish a controller rejection.','unreachedIndices':[i for i in range(8) if i not in reached],'visual':'New reachable captured slots pending review; unchanged 2x uses existing candidate15 acceptance, not a new pass.'})
        if not DIAGNOSTICS_ONLY:
            name='ru-02-settings-windowed.png'; command('capture '+name); captures.append(name)
            print('captured',name,flush=True)
        command('click Canvas/OptionsMenu/Controls/Fullscreen'); d=settings_state(True)
        assert d['stretch']==initial_stretch
        write('settings-restored-state.json',d)
        assert 'Canvas/OptionsMenu/Controls/Back' in d['buttons']
        command('click Canvas/OptionsMenu/Controls/Back'); d=dump()
        assert 'StartScreenMainMenu Canvas/MainMenu' in d['components']
        assert 'OptionsMenu Canvas/OptionsMenu' not in d['components']
        write('returned-main-menu.json',d)
        seen=['main-menu','fullscreen-settings','stretch-toggled','stretch-restored','windowed-settings','fullscreen-settings','main-menu']
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
        write('runtime-result.json',{'date':now(),'automatedResult':'passed' if success and not remaining and unchanged else 'failed','error':error,'guardedMenuProgression':seen,'captures':captures,'durationSeconds':round(time.monotonic()-started,3),'buildSha256':sha(RUN/'build.json'),'bridgeBuildSha256':sha(RUN/'bridge-build.json'),'settingsControlsPreserved':('passed Scale normal event path and display bounds; see scale-interaction.json' if SCALE_TEST else 'passed for actual Stretch, Fullscreen and Back buttons; Scale slot selection measured, scale-up/down interaction not run') if success else 'unverified','visual':'pending for new captures; text-only capture context has opened no image','completeFeasibilityGate':'unaccepted; all other surfaces and final corpus remain unverified'})
    assert success and not remaining and unchanged,error
if __name__=='__main__': main()
