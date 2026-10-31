"""One frozen, guarded native batch. Cleanup never depends on a model response."""
import base64, datetime, hashlib, json, os, shutil, signal, struct, subprocess, sys, time
from pathlib import Path
import runtime_startup

RUN=Path(__file__).resolve().parents[1]
DATA='The Forest of Love_Data'
GAME=RUN/'game';EXE=GAME/'The Forest of Love.exe'
CONFIG=json.loads((RUN/'execution/config.json').read_text())
ROOT=Path(CONFIG.get('projectRoot',RUN.parents[2])).resolve()
EVIDENCE=ROOT/CONFIG['evidence'];UPLOAD=EVIDENCE/'upload'
SOURCE=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')
def sha(p):
    h=hashlib.sha256()
    with Path(p).open('rb') as f:
        for b in iter(lambda:f.read(1048576),b''):h.update(b)
    return h.hexdigest()
def now():return datetime.datetime.now(datetime.timezone.utc).isoformat()
def write(name,value):
    path=RUN/name;temp=path.with_suffix(path.suffix+'.pending');temp.write_text(json.dumps(value,ensure_ascii=False,indent=2)+'\n');temp.replace(path)
def process_rows():
    variants=[str(EXE),'Z:'+str(EXE).replace('/','\\'),'Y:'+str(EXE).replace('/Users/antonkrutov','',1).replace('/','\\')]
    return [r.strip() for r in subprocess.check_output(['ps','-axo','pid=,ppid=,lstart=,args='],text=True).splitlines() if any(v in r for v in variants)]
def command(value,timeout=25):
    assert not (RUN/'command.txt').exists(),'Pending outcome requires reconciliation'
    offset=(RUN/'actions.log').stat().st_size if (RUN/'actions.log').exists() else 0
    temp=RUN/'command.pending';assert not temp.exists();temp.write_text(value+'\n');temp.rename(RUN/'command.txt')
    end=time.monotonic()+timeout
    while time.monotonic()<end:
        if (RUN/'actions.log').exists():
            with (RUN/'actions.log').open('rb') as f:f.seek(offset);lines=f.read().decode().splitlines()
            receipt=next((r for r in lines if ' OK '+value in r or ' FAIL '+value in r),None)
            if receipt:
                assert ' OK '+value in receipt,receipt
                if value.startswith(('capture ','locale-story-capture ')):
                    path=RUN/value.split(' ',1)[1]
                    while time.monotonic()<end:
                        if path.exists():
                            try:
                                from PIL import Image
                                with Image.open(path) as im:im.verify()
                                return receipt
                            except (OSError,SyntaxError):pass
                        time.sleep(.1)
                    raise RuntimeError('Capture unknown after acknowledgement',value)
                return receipt
        if not process_rows():raise RuntimeError('Game exited during command',value)
        time.sleep(.1)
    raise RuntimeError('Command outcome unknown; reconcile before retry',value)
def dump(label=None):
    command('dump');d=json.loads((RUN/'state.json').read_text())
    assert d['company']=='VNRevivalQA' and d['product']==CONFIG['product']
    actual=d['dataPath'].replace('\\','/');assert actual.endswith('/'+str(GAME/DATA).split('/Users/antonkrutov/',1)[1])
    assert d['persistentDataPath'].replace('\\','/').endswith('/VNRevivalQA/'+CONFIG['product'])
    if label:write(label+'.json',d)
    return d
def wait_state(predicate,label,timeout=45):
    end=time.monotonic()+timeout
    while time.monotonic()<end:
        d=dump()
        if predicate(d):write(label+'.json',d);return d
        time.sleep(.4)
    write(label+'-timeout.json',d);raise RuntimeError('Guard not reached',label,d.get('scene'))
def geometry(label):
    command('menu-geometry');rows=[]
    for line in (RUN/'menu-geometry.tsv').read_text().splitlines()[1:]:
        f=line.split('\t');assert len(f)==8
        rows.append(dict(path=f[0],text=base64.b64decode(f[1]).decode(),visible=f[2]=='True',ink=f[3]=='True',bounds=list(map(float,f[4:]))))
    write(label+'-captions.json',rows);return rows
def capture(slug,expected,boundary,capture_command='capture'):
    d=dump();command('locale-diagnostics')
    name='de-'+str(len(captures)+1).zfill(2)+'-'+slug+'.png';command(capture_command+' '+name)
    path=RUN/name
    from PIL import Image
    with Image.open(path) as im:
        width,height=im.size
        assert max(x[1] for x in im.convert('RGB').getextrema())>20,'Blank frame'
    assert (width,height)==(d['width'],d['height']),('Viewport dimensions differ',width,height,d['width'],d['height'])
    shutil.copy2(path,UPLOAD/name)
    row=dict(game='The Forest of Love',locale='de',runtimeLocale='de',order=len(captures)+1,direction='ltr',filename=name,sha256=sha(path),width=width,height=height,
             scene=d['scene'],expected=expected,boundary=boundary,conversationId=d.get('conversationId'),entryId=d.get('entryId'),stateHash=sha(RUN/'state.json'))
    captures.append(row);write('captures.json',captures)
    shutil.copy2(RUN/'state.json',EVIDENCE/(name+'.state.json'))
    for source in ['display-diagnostics.tsv','locale-window.tsv','font-diagnostics.tsv','glyph-diagnostics.tsv']:
        shutil.copy2(RUN/source,EVIDENCE/(name+'.'+source))
    native=subprocess.run(['swift',str(RUN/'execution/window_diagnostics.swift')],capture_output=True,text=True,timeout=45)
    (EVIDENCE/(name+'.mac-windows.json')).write_text(native.stdout if native.returncode==0 else json.dumps(dict(error=native.stderr)))
    print('CAPTURE',name,width,height,flush=True)
    return row
def inventory_geometry(label):
    command('inventory-geometry');rows=[]
    for line in (RUN/'inventory-geometry.tsv').read_text().splitlines():
        f=line.split('\t');assert len(f)==13
        rows.append(dict(role=f[0],text=base64.b64decode(f[1]).decode(),font=f[2],size=int(f[3]),alpha=float(f[4]),width=float(f[5]),height=float(f[6]),preferredWidth=float(f[7]),preferredHeight=float(f[8]),characters=int(f[9]),missing=f[10],sourceAlpha=float(f[11]),outsideMasks=int(f[12])))
    assert {r['role'] for r in rows}=={'itemTitleText','tickerText'}
    measurements.append(dict(case=label,fields=rows));write('inventory-measurements.json',measurements)
    if label!='owned 400':
        for r in rows:
            assert not r['missing'] and not r['outsideMasks'] and r['characters']>=len(r['text']),('Inventory glyph/mask guard',label,r)
            assert not r['text'] or r['alpha']>=r['sourceAlpha']*.99>0,('Inventory opacity guard',label,r)
    return rows
def interrupted(signum,frame):raise RuntimeError('Runner interrupted',signum)
captures=[];measurements=[];progress=[];fixture_before={};error=None;success=False;child=None;inventory_open=False;quest_open=False
def main():
    global child,error,success,inventory_open,quest_open,fixture_before
    # Check current acceptance before creating evidence or starting Wine. Frozen
    # historical runs retain their old execution versions as evidence only.
    subprocess.run([sys.executable,'-B',str(ROOT/'tools/locale_queue.py'),
                    'text-gate','--locale',CONFIG['locale'],'--json'],cwd=ROOT,check=True)
    assert not (RUN/'launch.json').exists() and not process_rows(),'Reconcile prior launch before another run'
    rows=subprocess.check_output(['ps','-axo','pid=,args='],text=True).splitlines();assert not any('The Forest of Love.exe' in r for r in rows),'Unrelated game active'
    for name,pin in json.loads((RUN/'execution-pins.json').read_text()).items():assert sha(RUN/name)==pin,('Frozen execution changed',name)
    build=json.loads((RUN/'build.json').read_text())
    assert sha(GAME/DATA/'Managed/ForestProbe.dll')==build['bridgeSha256']
    assert sha(GAME/DATA/'Managed/Assembly-CSharp.dll')==build['hookSha256']
    assert shutil.disk_usage(ROOT).free>5*1024**3
    assert not EVIDENCE.exists();UPLOAD.mkdir(parents=True)
    fixture_before={p.name:sha(p) for p in (RUN/'fixture-inputs').iterdir()};assert set(fixture_before)=={'tfol.settings','tfol.savegame'}
    candidate=ROOT/CONFIG['candidate'];cm=json.loads((candidate/'manifest.json').read_text());parent_pins={n:r['sha256'] for n,r in cm['outputs'].items()}
    args=['/Applications/CrossOver.app/Contents/SharedSupport/CrossOver/bin/wine','--bottle','/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam','--no-update',str(EXE),'-screen-fullscreen','0','-screen-width','1280','-screen-height','720','-logFile',str(RUN/'player.log')]
    signal.signal(signal.SIGTERM,interrupted);signal.signal(signal.SIGINT,interrupted)
    start=time.monotonic();write('launch-intent.json',dict(command=args,date=now(),configSha256=sha(RUN/'execution/config.json'),executionPinsSha256=sha(RUN/'execution-pins.json')))
    try:
        with (RUN/'wine.log').open('xb') as log:child=subprocess.Popen(args,cwd=GAME,stdin=subprocess.DEVNULL,stdout=log,stderr=subprocess.STDOUT,start_new_session=True)
        write('launch.json',dict(pid=child.pid,command=args,date=now()))
        ready=runtime_startup.wait_for_probe(RUN,child,process_rows,300);assert ready['readinessFileVerified']
        command('show-menu');d=wait_state(lambda s:s['scene']=='StartMenu' and 'StartScreenMainMenu Canvas/MainMenu' in s['components'],'main-menu')
        if CONFIG.get('nativeBatch') in ['quest-layout','quest-callbacks']:
            import quest_native
            command('menu StartScreenMainMenu OnClickStart')
            d=wait_state(lambda s:'PlayMenu Canvas/PlayMenu' in s['components'],'quest-play-menu')
            assert 'Canvas/PlayMenu/Controls/Continue' in d['buttons']
            command('menu PlayMenu OnClickContinue',75)
            wait_state(lambda s:s['scene']=='CentralForest','quest-fixture-loaded',180)
            command('items-ready',75)
            if CONFIG.get('nativeBatch')=='quest-callbacks':quest_native.callback_batch(globals())
            else:quest_native.quest_batch(globals())
        elif CONFIG.get('nativeBatch')=='original-intro':
            import quest_native
            quest_native.intro_batch(globals())
        elif CONFIG.get('nativeBatch')=='original-tutorial':
            import tutorial_native
            tutorial_native.batch(globals())
        else:
            rows=geometry('main-menu');words=[r['text'] for r in rows if r['visible'] and r['ink']]
            assert any('Spielen' in t for t in words),('German menu locale guard',words)
            capture('main-menu',words,'Original loaded main menu; bridge finishes its opening animation, no replacement strings.')
            command('menu StartScreenMainMenu OnClickOptions')
            d=wait_state(lambda s:'OptionsMenu Canvas/OptionsMenu' in s['components'],'options-menu')
            rows=geometry('settings');words=[r['text'] for r in rows if r['visible'] and r['ink']]
            assert any('Vollbild' in t for t in words) and any('Zurück' in t for t in words),('German settings guard',words)
            capture('settings',words,'Original Options handler; current actual display mode independently logged. No fullscreen toggling in this batch.')
            assert 'Canvas/OptionsMenu/Controls/Back' in d['buttons'];command('click Canvas/OptionsMenu/Controls/Back')
            wait_state(lambda s:'StartScreenMainMenu Canvas/MainMenu' in s['components'],'options-back')
            for panel in ['play','gallery','delete','new','quit']:
                assert dump()['scene']=='StartMenu'
                command('menu-panel '+panel);time.sleep(.6);d=dump('panel-'+panel);rows=geometry(panel);words=[r['text'] for r in rows if r['visible'] and r['ink']]
                assert words,('Empty staged panel',panel)
                capture('menu-'+panel,words,'Original '+panel+' panel Open method, renderer fixture; no confirmation accepted, no destructive callback or unlock.')
            command('menu-panel play');d=dump('before-fixture-continue');assert 'Canvas/PlayMenu/Controls/Continue' in d['buttons']
            command('menu PlayMenu OnClickContinue',75)
            d=wait_state(lambda s:s['scene']=='CentralForest','fixture-continue-loaded',180)
            command('dump-save-continuation');shutil.copy2(RUN/'save-continuation.json',RUN/'fixture-continuation.json')
            continuation=json.loads((RUN/'fixture-continuation.json').read_text());assert continuation['diagnosticsReady'] and continuation['gameplay'] and continuation['playerPresent']
            progress.append(dict(predicate='generated-fixture-original-continue',status='passed',scene=d['scene'],boundary='QA-only save restoration through original Continue; not owner-save or new-game-route acceptance'))
            command('items-ready',75);assert (RUN/'items-ready.txt').read_text().strip()=='48'
            # Original conversation is observed and advanced only with a fresh source-bound guard.
            if d['conversationActive']:
                d=wait_state(lambda s:s['conversationActive'] and not s['typing'],'dialogue-settled',75)
                capture('dialogue',d['conversationState'],'Original resumed-fixture conversation. No text injection or forced conversation start.')
                old=(d['conversationId'],d['entryId']);write('dialogue-before.json',d)
                if old!=(120,158) and d['responseCount']==0:
                    command('continue-bound '+str(old[0])+' '+str(old[1]))
                    after=wait_state(lambda s:not s['conversationActive'] or (s['conversationId'],s['entryId'])!=old or s['responseCount']>0,'dialogue-next-state',60)
                    progress.append(dict(predicate='original-dialogue-next-state',status='passed',before=list(old),after=[after['conversationId'],after['entryId']],responses=after['responseCount']))
                else:progress.append(dict(predicate='original-dialogue-choice',status='pending',source=list(old),reason='Source-specific guarded selector belongs to next finite batch'))
            else:progress.append(dict(predicate='original-dialogue-choice-progression',status='pending',reason='Fixture restored outside an active conversation; no synthetic conversation counted'))
            command('inventory-readback');assert (RUN/'inventory-readback.tsv').read_bytes()==(RUN/'inventory-expectations.tsv').read_bytes()
            command('inventory-open');inventory_open=True;time.sleep(2)
            ids=[int(l.split('\t')[0]) for l in (RUN/'inventory-expectations.tsv').read_text().splitlines()]
            for item in ids:
                command('inventory-select owned '+str(item));inventory_geometry('owned '+str(item))
            for case in ['consumed 130','zero 130','empty-special','empty']:
                command('inventory-select '+case);inventory_geometry(case)
            ordinary=[r for r in measurements if r['case'].startswith('owned ') and r['case']!='owned 400']
            worst_body=max(ordinary,key=lambda r:next(f['preferredHeight'] for f in r['fields'] if f['role']=='tickerText'))['case']
            worst_title=max(ordinary,key=lambda r:next((f['preferredHeight'],f['preferredWidth']) for f in r['fields'] if f['role']=='itemTitleText'))['case']
            for case in dict.fromkeys([worst_body,worst_title,'owned 10','empty-special','empty']):
                command('inventory-select '+case);time.sleep(.4);fields=inventory_geometry(case)
                if case.startswith('owned '):command('locale-sprite '+case.split()[1])
                capture('inventory-'+case.replace(' ','-'),[r['text'] for r in fields],'Original inventory consumer with cloned item argument; original sprites loaded in gameplay; no awards/quantity/progress change.')
            command('inventory-close');inventory_open=False;time.sleep(1)
            command('quest-readback');assert (RUN/'quest-readback.tsv').read_bytes()==(RUN/'quest-expectations.tsv').read_bytes()
            quest_open=True;command('locale-finley');time.sleep(2);command('quest-geometry')
            f=(RUN/'finley-shown.tsv').read_text().split('\t');expected=[base64.b64decode(s).decode() for s in f[1:]]
            capture('finley-quest',expected,'Original QuestLogDetailsPane with reversible active-status fixture; exact corrected serialized Finley title/body. Quest awarding/progression not tested.')
            command('quest-restore');quest_open=False
        command('locale-diagnostics')
        warnings=[l for l in (RUN/'player.log').read_text(errors='replace').splitlines() if 'was not found' in l or 'MissingCharacter' in l or 'Exception' in l or 'CRC Mismatch' in l]
        write('runtime-warnings.json',warnings);assert not warnings,('Logged runtime errors',warnings[:5])
        success=True
    except BaseException as ex:
        error=repr(ex);print('FAILED',error,flush=True)
        if process_rows() and not (RUN/'command.txt').exists():
            try:command('capture de-99-failure.png',10)
            except Exception:pass
    finally:
        # Do not interrupt restoration when a second signal arrives.
        signal.signal(signal.SIGTERM,signal.SIG_IGN);signal.signal(signal.SIGINT,signal.SIG_IGN)
        cleanup_errors=[];owned=process_rows()
        if owned and not (RUN/'command.txt').exists():
            for condition,action in [(CONFIG.get('nativeBatch')=='quest-callbacks','locale-queue-restore'),(inventory_open,'inventory-close'),(quest_open,'quest-restore'),(True,'restore-input-policy'),(True,'quit')]:
                if condition:
                    try:command(action,15)
                    except Exception as ex:cleanup_errors.append([action,repr(ex)])
        deadline=time.monotonic()+30
        while process_rows() and time.monotonic()<deadline:time.sleep(.5)
        remaining=process_rows();terminated=[]
        # Only exact verified game paths, no bottle/wineserver/application lifecycle action.
        for row in remaining:
            pid=int(row.split()[0]);actual=subprocess.run(['ps','-p',str(pid),'-o','pid=,ppid=,lstart=,args='],capture_output=True,text=True).stdout.strip()
            if actual==row and row in process_rows():
                os.kill(pid,signal.SIGTERM);terminated.append(dict(pid=pid,identity=row))
        deadline=time.monotonic()+10
        while process_rows() and time.monotonic()<deadline:time.sleep(.5)
        remaining=process_rows();fixture_after={p.name:sha(p) for p in (GAME/DATA).glob('tfol.*') if p.is_file()}
        # Preserve real runtime bytes BEFORE unconditional fixture restoration.
        # Only files in this exact disposable game are read; owner saves are excluded.
        retained=None
        if not remaining and CONFIG.get('nativeBatch')=='original-tutorial':
            try:
                archive=RUN/'retained-checkpoint';archive.mkdir()
                for name in fixture_after:
                    shutil.copy2(GAME/DATA/name,archive/name)
                    assert sha(archive/name)==fixture_after[name]
                state_path=RUN/('checkpoint-state.json' if (RUN/'checkpoint-state.json').exists() else 'save-continuation.json')
                state=None
                if state_path.exists():
                    shutil.copy2(state_path,archive/'state.json');state=dict(filename='state.json',sha256=sha(archive/'state.json'))
                retained=dict(processesAbsent=True,candidateManifestSha256=sha(candidate/'manifest.json'),product=CONFIG['product'],
                    originalGameplayCheckpoint=bool(success and (RUN/'checkpoint-state.json').exists()),
                    files={name:dict(sha256=sha(archive/name),bytes=(archive/name).stat().st_size) for name in fixture_after},
                    state=state,sourceGameSha256=sha(RUN/'original-before.json'),executionPinsSha256=sha(RUN/'execution-pins.json'),
                    boundary='Task-owned runtime bytes retained after exact process exit and before fixture restoration; no owner files.')
                write('retained-checkpoint/manifest.json',retained)
            except Exception as ex:cleanup_errors.append(['archive-runtime-checkpoint',repr(ex)])
        if not remaining:
            shutil.copy2(RUN/'Assembly-CSharp.localized-original.dll',GAME/DATA/'Managed/Assembly-CSharp.dll');(GAME/DATA/'Managed/ForestProbe.dll').unlink(missing_ok=True)
            for name in fixture_before:shutil.copy2(RUN/'fixture-inputs'/name,GAME/DATA/name)
        before=json.loads((RUN/'original-before.json').read_text());source_after={str(p.relative_to(SOURCE)):sha(p) for p in SOURCE.rglob('*') if p.is_file()}
        cleanup=dict(date=now(),taskOwnedProcessesAbsent=not remaining,verifiedTaskProcessRowsBeforeQuit=owned,remainingTaskProcessRows=remaining,terminatedExactProcesses=terminated,cleanupErrors=cleanup_errors,
                     originalGameByteExact=before==source_after,parentCandidateByteExact=all(sha(candidate/n)==pin for n,pin in parent_pins.items()),
                     bridgeRemoved=not (GAME/DATA/'Managed/ForestProbe.dll').exists(),localizedAssemblyRestored=sha(GAME/DATA/'Managed/Assembly-CSharp.dll')==sha(RUN/'Assembly-CSharp.localized-original.dll'),
                     fixtureBefore=fixture_before,fixtureAfterRuntime=fixture_after,fixtureRestored={p.name:sha(p) for p in (GAME/DATA).glob('tfol.*') if p.is_file()}==fixture_before,
                     disposableSavegameByteExactBeforeRestoration=fixture_after.get('tfol.savegame')==fixture_before['tfol.savegame'],retainedCheckpoint=retained,ownerSaveFilesUsed=False,ownerSessionControlled=False)
        write('cleanup.json',cleanup)
        passed=success and not remaining and cleanup['originalGameByteExact'] and cleanup['parentCandidateByteExact'] and cleanup['fixtureRestored'] and not cleanup_errors
        write('runtime-result.json',dict(result='capture-pass-review-pending' if passed else 'automated-fail',automatedResult='pass' if passed else 'fail',error=error,captures=captures,progress=progress,inventoryCases=len(measurements),durationSeconds=round(time.monotonic()-start,3),visual='pending' if captures else 'not-run',locale='de',scope=CONFIG['scope'],cleanupSha256=sha(RUN/'cleanup.json')))
        print('RESULT',json.dumps(dict(passed=passed,captures=len(captures),error=error,cleanupErrors=cleanup_errors,processesRemaining=len(remaining))),flush=True)
    return 0 if passed else 1
if __name__=='__main__':sys.exit(main())
