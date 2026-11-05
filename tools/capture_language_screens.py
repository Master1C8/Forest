"""Guarded Forest seven-frame native capture, one explicit locale at a time.

Uses the existing native bridge/preparer/supervisor. No model calls or publication.
"""
import argparse,base64,hashlib,json,os,shutil,struct,subprocess,sys,time
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
FAMILY=ROOT/'localization/screenshots/all30-owner-20261104-01'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def read(p):return json.loads(p.read_bytes())
def write(p,v):
    temp=p.with_name(p.name+'.pending');temp.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n');temp.replace(p)
def freeze(run):
    source=run/'execution/source';source.mkdir(parents=True)
    for name in ['NativeCaptureProbe.cs','InjectProbe.cs','native_capture_command.py','native_capture_session.py','prepare_native_capture.py']:
        p=ROOT/'tools/probe'/name;text=p.read_text()
        if name in ['native_capture_session.py','prepare_native_capture.py']:
            text=text.replace('ROOT=Path(__file__).resolve().parents[2]','ROOT=Path('+repr(str(ROOT))+')')
        if name=='prepare_native_capture.py':
            for n in ['NativeCaptureProbe.cs','InjectProbe.cs']:
                text=text.replace("ROOT/'tools/probe/"+n+"'","Path(__file__).with_name('"+n+"')")
        (source/name).write_text(text)
    text=Path(__file__).read_text().replace('ROOT=Path(__file__).resolve().parents[1]','ROOT=Path('+repr(str(ROOT))+')')
    (source/'capture_language_screens.py').write_text(text)
    return source
def command(run,value,timeout=20):
    subprocess.run([sys.executable,'-B',str(run/'execution/source/native_capture_command.py'),str(run),value,'--timeout',str(timeout)],check=True,stdout=subprocess.DEVNULL)
def state(run,name=None):
    command(run,'dump');raw=(run/'state.json').read_bytes()
    if name:(run/('state-'+name+'.json')).write_bytes(raw)
    return json.loads(raw)
def wait_state(run,predicate,name,seconds=45):
    end=time.monotonic()+seconds
    while time.monotonic()<end:
        s=state(run)
        if predicate(s):
            (run/('state-'+name+'.json')).write_bytes((run/'state.json').read_bytes());return s
        time.sleep(.25)
    raise TimeoutError('State guard not reached: '+name)
def click(run,path):
    assert path in state(run)['buttons'],'Original button unavailable: '+path
    command(run,'click '+path)
def menu_rendered(s,button):
    path=button+'/NameContainer/NameGlowLeft/Name'
    rows=[x for x in s['details'] if x.startswith('render-ready|'+path+'|')]
    return len(rows)==1 and float(rows[0].split('|alpha=')[1].split('|')[0])>.95 and int(rows[0].split('|chars=')[1].split('|')[0])>0 and rows[0].endswith('cull=False')
def route(run):
    config=read(run/'capture-config.json');code=config['locale'];images=[]
    def capture(order,slug):
        if order not in config.get('captureOrders',list(range(1,8))):return
        name=code+'-'+str(order).zfill(2)+'-'+slug+'.png';path=run/name
        assert not path.exists();state(run,'before-'+str(order));time.sleep(.7)
        reused=next((row for row in config.get('reusedImages',[]) if row['order']==order),None)
        if reused:
            original=Path(reused['path']);assert sha(original)==reused['sha256'];shutil.copy2(original,path)
        else:command(run,'capture '+name,timeout=75)
        end=time.monotonic()+20
        while time.monotonic()<end:
            if path.exists():
                raw=path.read_bytes()
                if raw[:8]==b'\x89PNG\r\n\x1a\n' and raw[-12:]==b'\0\0\0\0IEND\xaeB`\x82':break
            time.sleep(.1)
        else:raise TimeoutError('Native PNG writer did not finish: '+name)
        width,height=struct.unpack('>II',raw[16:24]);assert (width,height)==(2880,1800)
        images.append(dict(game='The Forest of Love',locale=code,runtimeLocale=code,publishingLocale=code,order=order,direction='rtl' if code in ['ar','fa','he'] else 'ltr',filename=name,sha256=sha(path),width=width,height=height))
        write(run/'capture-progress.json',dict(locale=code,images=images,completed=len(images),total=7))
    command(run,'show-menu');wait_state(run,lambda s:'Canvas/MainMenu/Controls/Options' in s['buttons'] and menu_rendered(s,'Canvas/MainMenu/Controls/Start'),'main')
    if 1 in config.get('captureOrders',list(range(1,8))):
        wait_state(run,lambda s:'version-contrast|Canvas/Logo/BuildVersionNumber (3)|pass=True' in s['details'],'version-contrast')
    capture(1,'main-menu')
    click(run,'Canvas/MainMenu/Controls/Options');wait_state(run,lambda s:'Canvas/OptionsMenu/Controls/Back' in s['buttons'] and menu_rendered(s,'Canvas/OptionsMenu/Controls/Back'),'settings');capture(2,'settings')
    if set(config['captureOrders'])<={1,2}:return images
    click(run,'Canvas/OptionsMenu/Controls/Back');click(run,'Canvas/MainMenu/Controls/Gallery');wait_state(run,lambda s:'Canvas/GalleryMenu/Controls/Column/Back' in s['buttons'] and menu_rendered(s,'Canvas/GalleryMenu/Controls/Column/Back'),'gallery')
    if config.get('verifyGalleryRtlGroup'):
        def toggle_value(s):
            values={name for name in ['On','Off'] if any(t.startswith('Canvas/GalleryMenu/Dialogue/'+name+'/') for t in s['texts'])}
            assert len(values)==1,'Ambiguous original dialogue toggle state'
            return next(iter(values))
        initial=toggle_value(state(run,'gallery-toggle-initial'));other='Off' if initial=='On' else 'On'
        click(run,'Canvas/GalleryMenu/Dialogue');wait_state(run,lambda s:toggle_value(s)==other,'gallery-toggle-other')
        click(run,'Canvas/GalleryMenu/Dialogue');restored=wait_state(run,lambda s:toggle_value(s)==initial,'gallery-toggle-restored')
        for name,x in [('Dialogue',44),('On',-20),('Off',-20)]:
            assert any(t.startswith('layout-pose|Canvas/GalleryMenu/Dialogue/'+name+'|x='+str(x)+'|y=0|') for t in restored['geometry']),'RTL gallery group pose not applied'
    capture(3,'gallery')
    if not set(config.get('captureOrders',list(range(1,8)))) & {4,5,6,7}:return images
    click(run,'Canvas/GalleryMenu/Controls/Column/Back');click(run,'Canvas/MainMenu/Controls/Start');click(run,'Canvas/PlayMenu/Controls/Continue')
    wait_state(run,lambda s:any(x.startswith('player|') for x in s['details']),'loaded',75)
    command(run,'page Inventory');time.sleep(.7);command(run,'camera')
    wait_state(run,lambda s:any(base64.b64decode(x.split('\t')[1]).decode()==config['cameraTitle'] for x in s['texts']),'camera');capture(4,'camera-inventory')
    command(run,'page CritterLog');command(run,'resident-id scarlett');initial=state(run,'scarlett-initial')
    if config.get('verifyResidentRefresh'):
        def resident_values(s):
            return sorted({tuple(t.split('\t')[:2]) for t in s['texts'] if t.split('\t')[2]=='native' and ('/ResidentsScrollView/' in t or '/Bio/' in t)})
        before=resident_values(initial);assert before,'Original resident labels unavailable'
        command(run,'resident-id maverick');other=state(run,'resident-refresh-other')
        assert resident_values(other)!=before,'Original resident selection did not change'
        command(run,'resident-id scarlett');returned=state(run,'scarlett')
        assert resident_values(returned)==before,'Original resident labels failed to refresh after display installation'
        write(run/'resident-refresh-proof.json',dict(passed=True,route=['scarlett','maverick','scarlett'],originalNativeLabels=len(before),logicalLabelsRestored=True,receiver='Original CritterLog.SelectResidentLabel by stable actor.savekey',boundary='Refresh/control preservation; glyph readability remains independent visual review'))
    else:state(run,'scarlett')
    capture(5,'scarlett')
    if not set(config.get('captureOrders',list(range(1,8)))) & {6,7}:return images
    command(run,'page QuestLog');command(run,'quest-id Act3_MelodyQuest')
    s=state(run)
    for row in s['scrolls']:
        path=row.split('\t')[0]
        if path.endswith('/QuestDetails'):command(run,'scroll '+path+' 1')
    command(run,'align-quest-list-any');s=state(run,'quest')
    assert any(x.split('\t')[0].endswith('/QuestDetails/Title') and base64.b64decode(x.split('\t')[1]).decode()==config['questTitle'] for x in s['texts'])
    capture(6,'hot-takes')
    if 7 not in config.get('captureOrders',list(range(1,8))):return images
    command(run,'close-log');command(run,'place-maverick-fixture')
    wait_state(run,lambda s:any('maverick' in x.lower() and '|authority=True|' in x and '|canTrigger=True|' in x for x in s['details'] if x.startswith('trigger|')),'maverick-authority',8)
    command(run,'talk-maverick')
    s=wait_state(run,lambda s:s['conversationActive'] and s['conversationId']==279 and s['entryId'] in [149,150],'maverick-start')
    end=time.monotonic()+30
    while not any(row.split('\t')[:2]==['279','142'] for row in s['responses']):
        assert s['entryId'] in [149,150] and s['conversationId']==279 and not s['responses'],'Unexpected current dialogue branch'
        if time.monotonic()>end:raise TimeoutError('Original response142 did not appear')
        command(run,'continue 279 '+str(s['entryId']));time.sleep(.2);s=state(run)
    response=next(row.split('\t') for row in s['responses'] if row.split('\t')[:2]==['279','142']);click(run,response[2])
    wait_state(run,lambda s:s['conversationId']==279 and s['entryId']==143 and not s['typing'],'maverick143')
    command(run,'continue 279 143');s=wait_state(run,lambda s:s['conversationId']==279 and s['entryId']==144 and not s['typing'],'maverick-target')
    assert s['conversationText']==config['dialogueTarget'],'Loaded subtitle differs from the exact authored target'
    capture(7,'maverick-warmth');return images
def run_locale(code,overlay,attempt,reuse_run=None,orders=None,background_best_effort=False):
    plan=read(FAMILY/'plan.json');assert code in {r['locale'] for r in plan['locales']}|{'ru'};assert attempt.isalnum()
    run=ROOT/'localization/probes'/('locale-owner-shots-20261104-'+code+'-'+attempt);assert not run.exists();run.mkdir();source=freeze(run)
    language=ROOT/'localization/languages'/(code+'.json');doc=read(language);native=read(overlay/'manifest.json');assert native['locale']==code and native['languageSha256']==sha(language)
    camera_row=doc['translations']['bgdb:resources.assets:320/sheet/0BzeuogxqUOTnLWmTpBxVw/row/qePqzfpKTE%2BQlx%2FSCoUyQw/field/idzA%2BSihD062xkfAt9az8Q']
    quest_row=doc['translations']['bgdb:resources.assets:320/sheet/t0mvbnMW90imSoe6SezMKA/row/sl%2FyUAqDxkSWLRtNu9jKfg/field/pFHvU0%2FmGUGVujz%2Bd6ktEA']
    assert camera_row['source']=='Camera' and quest_row['source']=='Hot Takes'
    dialogue=doc['translations']['ds:279:144:Dialogue Text'];assert dialogue['source'].startswith('[pic=1]') and dialogue['target'].startswith('[pic=1]')
    config=dict(locale=code,languageSha256=sha(language),nativeManifestSha256=sha(overlay/'manifest.json'),overlay=str(overlay),cameraTitle=camera_row['target'],questTitle=quest_row['target'],dialogueTarget=dialogue['target'][len('[pic=1]'):],dialogueTargetAuthored=dialogue['target'],consumedCommandPrefix='[pic=1]',sourcePins={p.name:sha(p) for p in source.iterdir()},preparedWithOriginalInputDelivery=True)
    config['captureOrders']=orders or list(range(1,8));assert config['captureOrders'] and set(config['captureOrders'])<=set(range(1,8))
    config['verifyGalleryRtlGroup']=doc.get('complexText',False) and code in ['ar','fa','he']
    config['verifyResidentRefresh']=doc.get('complexText',False)
    if reuse_run:
        reuse_run=reuse_run.resolve();assert reuse_run.parent==ROOT/'localization/probes'
        parent=read(reuse_run/'capture-config.json');cleanup=read(reuse_run/'cleanup.json');assert cleanup['taskProcessStopped'] and cleanup['taskSaveByteExact']
        assert parent['languageSha256']==config['languageSha256'] and parent['nativeManifestSha256']==config['nativeManifestSha256']
        assert read(reuse_run/'build.json')['sourceSaveSha256']==plan['fixtureFiles']['tfol.savegame']['sha256']
        old=read(reuse_run/'capture-progress.json')['images']
        # A lost observer does not undo an acknowledged, subsequently completed
        # native write. Reconcile the exact frame/state before another capture.
        for order,slug in enumerate(['main-menu','settings','gallery','camera-inventory','scarlett','hot-takes'],1):
            name=code+'-'+str(order).zfill(2)+'-'+slug+'.png';image=reuse_run/name
            if any(row['order']==order for row in old) or not image.exists():continue
            raw=image.read_bytes()
            assert (reuse_run/('state-before-'+str(order)+'.json')).exists() and 'OK capture '+name+'\n' in (reuse_run/'actions.log').read_text()
            assert raw[-12:]==b'\0\0\0\0IEND\xaeB`\x82' and struct.unpack('>II',raw[16:24])==(2880,1800)
            old.append(dict(order=order,filename=name,sha256=sha(image),reconciledAfterObserverTimeout=True))
        assert all(row['order']<=6 for row in old)
        config['reusedImages']=[dict(order=row['order'],path=str(reuse_run/row['filename']),sha256=row['sha256']) for row in old]
        config['reuseReason']='Exact same production overlay/save and unchanged rendering/route for reused slots. Latest repair affects only quest-list capture scroll alignment after frame5; earlier selector repairs affected only later slots at their respective parent versions.'
    write(run/'capture-config.json',config);env=dict(os.environ,FOREST_CAPTURE_RUN=run.name,FOREST_CAPTURE_LOCALE=code,FOREST_CAPTURE_SOURCE=plan['sourceFixture'],FOREST_CAPTURE_OVERLAY=str(overlay))
    write(FAMILY/'current-capture.json',dict(locale=code,run=str(run),state='preparing'))
    with (run/'preparation.log').open('wb') as log:subprocess.run([str(ROOT/'.venv-assets314/bin/python'),'-B',str(source/'prepare_native_capture.py')],env=env,check=True,stdout=log,stderr=subprocess.STDOUT)
    sessionlog=(run/'session.log').open('wb');session=subprocess.Popen([sys.executable,'-B',str(source/'native_capture_session.py')],env=env,stdout=sessionlog,stderr=subprocess.STDOUT,start_new_session=True)
    images=None;failure=None
    try:
        end=time.monotonic()+300
        launch_published=False
        while not (run/'bridge-ready.txt').exists():
            if not launch_published and (run/'launch.json').exists():
                write(FAMILY/'current-capture.json',dict(locale=code,run=str(run),state='starting-native',supervisorPid=session.pid,launch=read(run/'launch.json')))
                launch_published=True
            if session.poll() is not None:raise RuntimeError('Native supervisor exited before bridge ready')
            if time.monotonic()>end:raise TimeoutError('Native startup deadline')
            time.sleep(.25)
        startup=state(run,'startup-focus')
        if startup.get('focused') is False:
            write(run/'background-ready.json',dict(background=True,hidden=False,method='Original Unity Application.isFocused=false, runInBackground already true; no OS activation performed'))
        elif background_best_effort:
            write(run/'background-ready.json',dict(background=False,hidden=False,method='Existing project fallback: hidden-window framebuffer captures stalled. No OS activation or synthetic input; native framebuffer capture continues if the owner changes focus. Actual focused startup is recorded.'))
        write(FAMILY/'current-capture.json',dict(locale=code,run=str(run),state='awaiting-background',supervisorPid=session.pid,launch=read(run/'launch.json')))
        end=time.monotonic()+180
        while not (run/'background-ready.json').exists():
            if time.monotonic()>end:raise TimeoutError('Background UI handoff not completed')
            if session.poll() is not None:raise RuntimeError('Native supervisor ended while awaiting UI handoff')
            time.sleep(.25)
        write(FAMILY/'current-capture.json',dict(locale=code,run=str(run),state='capturing',supervisorPid=session.pid))
        images=route(run)
    except BaseException as error:
        failure=repr(error);write(run/'failure.json',dict(error=failure))
        try:command(run,'capture failure-native.png')
        except Exception:pass
    finally:
        (run/'finish.request').touch()
        try:session.wait(timeout=45)
        except subprocess.TimeoutExpired:raise RuntimeError('Supervisor outcome unknown; reconcile exact process and children before further work')
        sessionlog.close()
    cleanup=read(run/'cleanup.json');assert cleanup['taskProcessStopped'] and cleanup['ownerSaveSettingsUnchanged'] and cleanup['taskSaveByteExact'] and cleanup['bridgeRemoved']
    if failure:
        write(FAMILY/'current-capture.json',dict(locale=code,run=str(run),state='failed-native',error=failure));raise RuntimeError(failure)
    assert len(images)==len(config['captureOrders'])
    destination=FAMILY/code/attempt;upload=destination/'upload';upload.mkdir(parents=True,exist_ok=False)
    for image in images:shutil.copy2(run/image['filename'],upload/image['filename']);assert sha(upload/image['filename'])==image['sha256']
    pins={name:dict(path=str(run/file),sha256=sha(run/file)) for name,file in [('build','build.json'),('cleanup','cleanup.json'),('configuration','capture-config.json')]}
    write(destination/'native-manifest.json',dict(schemaVersion=1,kind='native-screenshots',scope='Complete assigned same-save '+code+' capture slots '+','.join(map(str,config['captureOrders'])),provenance=pins,images=[{k:v for k,v in row.items() if k not in ['runtimeLocale','publishingLocale']} for row in images]))
    write(destination/'capture.json',dict(locale=code,run=str(run),images=images,cleanup=cleanup,config=config))
    write(FAMILY/'current-capture.json',dict(locale=code,run=str(run),state='captured-review-pending',destination=str(destination),count=len(images)))
    print(json.dumps(dict(locale=code,screens=len(images),destination=str(destination),native='captured',visual='pending')))
if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('locale');p.add_argument('--overlay',type=Path,required=True);p.add_argument('--attempt',default='01');p.add_argument('--reuse-run',type=Path);p.add_argument('--orders');p.add_argument('--background-best-effort',action='store_true');a=p.parse_args()
    run_locale(a.locale,a.overlay.resolve(),a.attempt,a.reuse_run,list(map(int,a.orders.split(','))) if a.orders else None,a.background_best_effort)
