"""Exercise actual menu rendering in isolated QA; never accept destructive actions."""
import base64,json,shutil,struct,subprocess,time
from pathlib import Path
import capture_settings as shared
RUN,GAME,DATA=shared.RUN,shared.GAME,shared.DATA
sha,write=shared.sha,shared.write
PANELS=['play','gallery','options','delete','new','quit']
PRODUCT=json.loads((RUN/'build.json').read_text())['saveIsolation']['productName']

def command(value):
    allowed={'show-menu','dump','menu-geometry','menu-font-diagnostics','menu-glyph-diagnostics','menu-layout-baseline','menu-play-act1','quit',
        'click Canvas/OptionsMenu/Controls/Fullscreen','click Canvas/OptionsMenu/Controls/FullscreenStretch'}
    allowed.update('menu-panel '+p for p in PANELS)
    allowed.update('capture ru-%02d-%s.png'%(i,p) for i,p in enumerate(PANELS,1))
    assert value in allowed,('unapproved-menu-QA-action',value)
    shared.command(value)

def geometry():
    command('menu-geometry');state=json.loads((RUN/'menu-state.json').read_text())
    assert state['scene']=='StartMenu' and state['company']=='VNRevivalQA' and state['product']==PRODUCT
    assert state['hasSavedSession'], 'QA-generated save was not loaded; Continue scenario invalid'
    assert state['geometrySpace']=='root-canvas-local'
    rows=[]
    for line in (RUN/'menu-geometry.tsv').read_text().splitlines()[1:]:
        v=line.split('\t');assert len(v)==8
        rows.append(dict(path=v[0],text=base64.b64decode(v[1],validate=True).decode(),visible=v[2]=='True',ink=v[3]=='True',minX=float(v[4]),maxX=float(v[5]),minY=float(v[6]),maxY=float(v[7])))
    return state,rows

def main():
    assert not shared.processes() and not (RUN/'launch.json').exists()
    assert not [r for r in subprocess.check_output(['ps','-axo','pid,command'],text=True).splitlines() if 'The Forest of Love.exe' in r], 'Another game is active'
    build=json.loads((RUN/'build.json').read_text())
    required={'globalgamemanagers','resources.assets','level1','level5','level6','sharedassets0.assets','sharedassets1.assets','sharedassets2.assets',
        'StreamingAssets/aa/StandaloneWindows64/defaultlocalgroup_assets_all_298c5a4d1d1846b1a8d2c7d5da3f319c.bundle',
        'Managed/VNRevivalQuestLayout.dll','Managed/Assembly-CSharp.dll'}
    assert len(build['files'])==len(required) and {r['path'] for r in build['files']}==required, 'Changed candidate file inventory'
    original=RUN/'Assembly-CSharp.localized-original.dll';assert sha(original)==next(r['probeSha256'] for r in build['files'] if r['path']=='Managed/Assembly-CSharp.dll')
    parent=Path(json.loads((RUN/'qa-preparation.json').read_text())['parentBuild'])
    parent_hashes={r['path']:sha(parent/'game'/DATA/r['path']) for r in build['files']}
    expected={r['hierarchy']:r['target'] for r in build['menuTranslations']}
    args=['/Applications/CrossOver.app/Contents/SharedSupport/CrossOver/bin/wine','--bottle','/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam','--no-update',str(shared.EXE),'-screen-fullscreen','0','-screen-width','1280','-screen-height','720','-logFile',str(RUN/'player.log')]
    started=time.monotonic();success=False;error=None;captures=[];assertions=[]
    reused=RUN/'reused-captures.json'
    if reused.exists():
        captures=json.loads(reused.read_text())['captures']
        assert all(sha(RUN/r['filename'])==r['sha256'] for r in captures)
    try:
        with (RUN/'wine.log').open('wb') as log:
            child=subprocess.Popen(args,cwd=GAME,stdin=subprocess.DEVNULL,stdout=log,stderr=subprocess.STDOUT,start_new_session=True)
        write('launch.json',{'pid':child.pid,'command':args,'bridgeSha256':sha(GAME/DATA/'Managed/ForestProbe.dll'),'buildSha256':sha(RUN/'build.json'),'captureRecipeSha256':sha(Path(__file__))})
        shared.wait_for_probe(child,300)
        command('show-menu');time.sleep(.7)
        for i,panel in enumerate(PANELS,1):
            if any(r['filename']=='ru-%02d-%s.png'%(i,panel) for r in captures):continue
            command('menu-panel '+panel);time.sleep(.8)
            state,rows=geometry()
            if panel=='options':
                if not state['fullscreen']:
                    command('click Canvas/OptionsMenu/Controls/Fullscreen');time.sleep(1);state,rows=geometry()
                assert state['fullscreen']
                if state['stretch']:
                    command('click Canvas/OptionsMenu/Controls/FullscreenStretch');time.sleep(.8);state,rows=geometry()
                assert not state['stretch']
                for root,label,value in [('Fullscreen','Fullscreen','On'),('FullscreenStretch','FullscreenStretch','Off')]:
                    prefix='Canvas/OptionsMenu/Controls/'+root+'/'
                    caption=[r for r in rows if r['path'].startswith(prefix+label+'/') and r['visible'] and r['ink']]
                    values=[r for r in rows if r['path'].startswith(prefix+value+'/') and r['visible'] and r['ink']]
                    assert caption and values,('missing-visible-caption/value',root)
                    gap=min(r['minX'] for r in values)-max(r['maxX'] for r in caption)
                    assert gap>=4,('caption-value-overlap',root,gap)
                    assertions.append({'row':root,'actualInkGapRootCanvasUnits':gap,'viewport':[state['width'],state['height']]})
                command('menu-layout-baseline')
                baseline_rows=[]
                for line in (RUN/'menu-geometry.tsv').read_text().splitlines()[1:]:
                    v=line.split('\t');baseline_rows.append(dict(path=v[0],visible=v[2]=='True',ink=v[3]=='True',minX=float(v[4]),maxX=float(v[5])))
                shutil.copy2(RUN/'menu-geometry.tsv',RUN/'geometry-original-caption-layout.tsv')
                baseline_gaps=[]
                for root,label,value in [('Fullscreen','Fullscreen','On'),('FullscreenStretch','FullscreenStretch','Off')]:
                    prefix='Canvas/OptionsMenu/Controls/'+root+'/'
                    a=[r for r in baseline_rows if r['path'].startswith(prefix+label+'/') and r['visible'] and r['ink']]
                    b=[r for r in baseline_rows if r['path'].startswith(prefix+value+'/') and r['visible'] and r['ink']]
                    assert a and b
                    baseline_gaps.append(min(r['minX'] for r in b)-max(r['maxX'] for r in a))
                assert min(baseline_gaps)<0,('old-layout-negative-control-did-not-reproduce',baseline_gaps)
                assertions.append({'originalLayoutCounterfactualGaps':baseline_gaps,'boundary':'Same runtime Russian text/font/viewport; only the four original caption layout properties were restored temporarily. Fixed layout restored in finally.'})
                state,rows=geometry()
            matched=0
            for row in rows:
                if row['path'] not in expected:continue
                target=expected[row['path']]
                if '/MoviesSelectionLabel/' in row['path']:target='Фильмы\n<size=12>(открыто: 0/11)</size>'
                if '/StoriesSelectionLabel/' in row['path']:target='Истории\n<size=12>(открыто: 0/46)</size>'
                assert row['text']==target,('runtime-caption',row['path'],row['text'],target)
                matched+=1
            assert matched>0,('no-menu-caption-workload',panel)
            if panel=='gallery':
                assert any(r['text']=='Фильмы\n<size=12>(открыто: 0/11)</size>' for r in rows)
                assert any(r['text']=='Истории\n<size=12>(открыто: 0/46)</size>' for r in rows)
            shutil.copy2(RUN/'menu-geometry.tsv',RUN/('geometry-'+panel+'.tsv'));write('state-'+panel+'.json',state)
            command('menu-font-diagnostics');font_rows=[]
            for line in (RUN/'font-diagnostics.tsv').read_text().splitlines()[1:]:
                v=line.split('\t');assert len(v)==10,('font-diagnostics-columns',v)
                row={k:base64.b64decode(v[i],validate=True).decode() for i,k in enumerate(['name','family','sourceFont','population'])}
                assert v[4] in ('True','False');row['multiAtlas']=v[4]=='True'
                row.update({k:int(v[i+5]) for i,k in enumerate(['glyphs','characters','atlasCount','atlasWidth','atlasHeight'])});font_rows.append(row)
            fonts={'fallbacks':font_rows}
            assert any(f['family']=='Liberation Sans' and f['sourceFont']=='LiberationSans' and f['multiAtlas'] and f['glyphs']>0 for f in fonts['fallbacks']), ('dynamic-fallback-not-loaded', fonts)
            write('font-diagnostics-'+panel+'.json',fonts)
            if build.get('uniformTmpFallback'):
                command('menu-glyph-diagnostics');glyphs=[]
                for line in (RUN/'glyph-diagnostics.tsv').read_text().splitlines()[1:]:
                    v=line.split('\t');assert len(v)==7,('glyph-diagnostics-columns',v)
                    if v[2]=='True':glyphs.append((int(v[1]),base64.b64decode(v[4],validate=True).decode()))
                assert glyphs and all(family=='Liberation Sans' for _,family in glyphs),('mixed-visible-glyph-families',glyphs)
                shutil.copy2(RUN/'glyph-diagnostics.tsv',RUN/('glyph-diagnostics-'+panel+'.tsv'))
            filename='ru-%02d-%s.png'%(i,panel);command('capture '+filename)
            data=(RUN/filename).read_bytes();assert data[:8]==b'\x89PNG\r\n\x1a\n';width,height=struct.unpack('>II',data[16:24])
            captures.append({'filename':filename,'sha256':sha(RUN/filename),'width':width,'height':height,'runtimeCaptionsCompared':matched})
        missing=[line for line in (RUN/'player.log').read_text(errors='replace').splitlines() if 'was not found' in line or 'MissingCharacter' in line]
        assert not missing,('missing-glyph-runtime-warnings',len(missing),missing[:3])
        success=True
    except BaseException as ex:
        error=repr(ex);print(error,flush=True)
    finally:
        owned=shared.processes();quit_error=None
        if owned and not (RUN/'command.txt').exists():
            try:command('quit')
            except Exception as ex:quit_error=repr(ex)
        deadline=time.monotonic()+30
        while shared.processes() and time.monotonic()<deadline:time.sleep(.5)
        remaining=shared.processes()
        if not remaining:
            shutil.copy2(original,GAME/DATA/'Managed/Assembly-CSharp.dll');(GAME/DATA/'Managed/ForestProbe.dll').unlink(missing_ok=True)
        unchanged=all(sha(parent/'game'/DATA/name)==value for name,value in parent_hashes.items())
        write('cleanup.json',{'taskOwnedProcessesAbsent':not remaining,'remainingTaskProcessRows':remaining,'verifiedTaskProcessRowsBeforeQuit':owned,'quitError':quit_error,'localizedAssemblyRestored':sha(GAME/DATA/'Managed/Assembly-CSharp.dll')==sha(original),'bridgeRemoved':not (GAME/DATA/'Managed/ForestProbe.dll').exists(),'parentArtifactUnchanged':unchanged,'ownerGameClosedOrControlled':False,'ownerSaveFilesUsed':False})
        write('runtime-result.json',{'result':'passed' if success and not remaining and unchanged else 'failed','error':error,'durationSeconds':round(time.monotonic()-started,3),'captures':captures,'geometryAssertions':assertions,'buildSha256':sha(RUN/'build.json'),'boundary':'Actual loaded captions, original patched gallery formatter and TMP preferred-width layout; inspection panel staging bypasses first-time tutorial/navigation, no replacement text or save flags','visual':'pending'})
    assert success and not remaining and unchanged,(error,remaining)
    print('All six menu panels captured; actual gallery counters and caption/value gaps passed',flush=True)
if __name__=='__main__':main()
