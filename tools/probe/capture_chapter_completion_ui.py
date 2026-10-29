#!/usr/bin/env python3
"""Frozen two-surface runtime recipe. Every runtime action needs parent authority.
No gallery measurements, source edits, forced process termination or model calls.
"""
import argparse
import base64
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import shutil
import subprocess
import sys
import time

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
DATA = 'The Forest of Love_Data'
SURFACES = ('oos', 'description')
CANDIDATE = ROOT / 'localization/previews/ru-20261029-chapter-gallery-02'
BUILD_SHA = '3dcfd4fb1ed8a4bc5e164c993c9d85e2e6e0c740303aa4105aecf93a13ac5143'
ASSEMBLY_SHA = '84f70452d94741489b37d97c8125bf107b4261d4a87e5a2ba294ebdf107dfacf'


def require(ok, reason):
    if not ok:
        raise ValueError(reason)


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def read(path):
    return json.loads(Path(path).read_bytes())


def write(path, value, exclusive=False):
    path = Path(path)
    raw = (json.dumps(value, ensure_ascii=False, indent=2) + '\n').encode()
    if exclusive:
        with path.open('xb') as stream:
            stream.write(raw)
    else:
        temp = path.with_name(path.name + '.pending')
        with temp.open('xb') as stream:
            stream.write(raw)
        temp.replace(path)


def module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    obj = importlib.util.module_from_spec(spec)
    sys.modules[name] = obj
    spec.loader.exec_module(obj)
    return obj


def checked_run(path):
    path = Path(path)
    require(path.is_absolute(), 'explicit-absolute-run-required')
    run = path.resolve()
    require(run.parent == ROOT / 'localization/probes' and re.fullmatch(r'ru-chapter-completion-\d{8}-\d{2}', run.name), 'unique-completion-run-required')
    return run


def helpers():
    return Path(__file__).resolve().parent


def legacy():
    return module('completion_legacy', helpers() / 'capture_chapter_gallery_ui.py')


def candidate_validation(candidate, *, locale):
    require(locale == 'ru', 'explicit-supported-locale-required')
    candidate = Path(candidate).resolve()
    require(candidate == CANDIDATE and sha(candidate / 'build.json') == BUILD_SHA, 'exact-full-candidate02-build-required')
    cg = legacy()
    # Preserve original03 admission instead of weakening it. Reuse its complete
    # accepted readback only for four BYTE-IDENTICAL consumer-bearing artifacts.
    plan, original, b03 = cg.validate_candidate(ROOT / 'localization/previews/ru-20261029-chapter-gallery-03', locale=locale)
    build = read(candidate / 'build.json')
    require(build['siteLocale'] == locale and build['chapterGalleryCase'] is True, 'candidate-locale-case')
    files = {r['path']: r['probeSha256'] for r in build['files']}
    for name, digest in files.items():
        p = (candidate / 'game' / DATA / name).resolve()
        require(p.is_relative_to(candidate / 'game' / DATA) and sha(p) == digest, 'candidate02-artifact:' + name)
    four = ('resources.assets', 'sharedassets0.assets', 'sharedassets2.assets', 'Managed/Assembly-CSharp.dll')
    ref = {r['path']: r['probeSha256'] for r in b03['files']}
    require(all(files[n] == ref[n] for n in four) and files[four[-1]] == ASSEMBLY_SHA, 'consumer02-03-artifact-equivalence')
    require(build['chapterGalleryDatabaseProjection'] == b03['chapterGalleryDatabaseProjection'] and build['chapterGalleryInitialProjection'] == b03['chapterGalleryInitialProjection'] and build['chapterGalleryCodeProjection'] == b03['chapterGalleryCodeProjection'], 'complete-chapter-projection-equivalence')
    texture = read(candidate / 'texture-preservation.json')
    require(texture['status'] == 'pass' and texture['originalTextureObjects'] == 1385 and texture['originalTextureContainers'] == 26 and texture['target'] == str(candidate / 'game' / DATA), 'complete-original-texture-preservation')
    return plan, finite_plan(original), build


def finite_plan(original):
    require(original['mode'] == 'editorial-accepted', 'accepted-runtime-workload-required')
    cases = [dict(c) for s in SURFACES for c in original['cases'] if c['surface'] == s]
    for i, c in enumerate(cases):
        c['original3423Index'] = c['index']; c['index'] = i
    require(len(cases) == 56 and {s: sum(c['surface'] == s for c in cases) for s in SURFACES} == dict(oos=28, description=28), 'exact56-workload')
    require(all(c['sourceId'] and c['kind'] == 'none' and c['branch'] in ('title','description') for c in cases), 'source-bound56')
    for c in cases:
        require(c['expected'] == ("''" + c['argument'] + "''" if c['surface'] == 'oos' else c['argument']), 'exact-original-wrapper-or-tooltip')
    return dict(original, cases=cases, counts=dict(oos=28, description=28), selection=[],
                coverage='Exactly28 wrapped Chapter.title and28 Chapter.description UI argument fixtures; zero gallery remeasurement',
                originalWorkloadCases=3423, wholeGameAccepted=False, runtime='not-run', visualAccepted=False)


def pin_check(run, *, restored=False):
    prep = read(run / 'cc-preparation.json')
    require(sha(run / 'cc-execution-pins.json') == prep['executionPinsSha256'], 'execution-manifest-version')
    if (run/'launch-intent.json').exists():
        require(sha(run/'cc-preparation.json')==read(run/'launch-intent.json')['preparedSha256'],'launched-preparation-version')
    pins = read(run / 'cc-execution-pins.json')
    changed = {'game/' + DATA + '/Managed/Assembly-CSharp.dll', 'game/' + DATA + '/Managed/ForestProbe.dll'} if restored else set()
    for name, digest in pins.items():
        p = (run / name).resolve()
        require(p.is_relative_to(run), 'pin-path-escape')
        if name not in changed:
            require(sha(p) == digest, 'execution-pin:' + name)
    return prep


def process():
    return module('chapter_gallery_process', helpers() / 'chapter_gallery_process.py')


def frozen_run(run):
    require(helpers() == run / 'cg-helpers', 'execute-frozen-runner-only')
    return pin_check(run)


def reconcile(run, receipt_path, timeout=15):
    receipt_path = Path(receipt_path).resolve()
    require(receipt_path.parent == run / 'cc-command-receipts', 'owned-command-receipt-required')
    receipt = read(receipt_path)
    require(receipt['process'] == read(run / 'task-process.json'), 'command-process-version')
    deadline = time.monotonic() + timeout
    while True:
        process().owned(run, allow_absent=receipt['action'] == 'quit')
        log = run / 'actions.log'
        raw = log.read_bytes()[receipt['offset']:] if log.exists() else b''
        lines = raw.decode('utf-8-sig', errors='replace').split('\n')[:-1]
        action = receipt['action']
        matches = [line for line in lines if line.endswith(' OK '+action) or (' FAIL '+action+' ') in line]
        require(len(matches) <= 1, 'duplicate-action-receipt')
        if matches:
            receipt.update(status='acknowledged' if matches[0].endswith(' OK '+action) else 'failed', logReceipt=matches[0])
            write(receipt_path,receipt)
            require(receipt['status'] == 'acknowledged', 'bridge-action-failed:' + action)
            return receipt
        if time.monotonic() >= deadline:
            receipt['status']='outcome-unknown';write(receipt_path,receipt)
            raise RuntimeError('Command outcome unknown; reconcile this exact receipt; do not resubmit or relaunch')
        time.sleep(.2)


def command(run, action):
    process().owned(run)
    journal=run/'cc-command-receipts';journal.mkdir(exist_ok=True)
    old=sorted(journal.glob('*.json'))
    require(not old or read(old[-1])['status']=='acknowledged' or read(old[-1])['status']=='failed' and action in ('cc-restore','quit'), 'reconcile-last-command-first')
    require(not any((run/n).exists() for n in ['command.txt','command.pending']), 'pending-command-needs-reconciliation')
    log=run/'actions.log';path=journal/(str(len(old)).zfill(6)+'.json')
    write(path,dict(status='pending',action=action,offset=log.stat().st_size if log.exists() else 0,process=read(run/'task-process.json')),True)
    try:
        result=subprocess.run([sys.executable,str(helpers()/'command.py'),str(run),action,'--timeout','45'],capture_output=True,text=True,timeout=50)
        transport=dict(exitCode=result.returncode,stdout=result.stdout[-2000:],stderr=result.stderr[-2000:])
    except subprocess.TimeoutExpired:
        transport=dict(exitCode=None,error='transport-timeout;request-preserved')
    receipt=read(path);receipt['transport']=transport;write(path,receipt)
    return reconcile(run,path)


def launch(run):
    frozen_run(run);process().no_game_process(run)
    require(not any((run/n).exists() for n in ['launch-intent.json','launch.json','task-process.json']), 'reconcile-prior-launch-first')
    exe=run/'game/The Forest of Love.exe'
    argv=['/Applications/CrossOver.app/Contents/SharedSupport/CrossOver/bin/wine','--bottle','/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam','--no-update',str(exe),'-screen-fullscreen','0','-screen-width','1280','-screen-height','720','-logFile',str(run/'player.log')]
    receipt=dict(command=argv,preparedSha256=sha(run/'cc-preparation.json'),run=str(run),scope='One parent-authorized isolated UI fixture; no bottle restart; launch args do not prove actual viewport')
    write(run/'launch-intent.json',receipt,True)
    with (run/'wine.log').open('xb') as stream:
        child=subprocess.Popen(argv,cwd=exe.parent,stdin=subprocess.DEVNULL,stdout=stream,stderr=subprocess.STDOUT,start_new_session=True)
    receipt['launcherPid']=child.pid;write(run/'launch.json',receipt,True)
    startup=module('cc_runtime_startup',helpers()/'runtime_startup.py')
    observed=startup.wait_for_probe(run,child,lambda:process().observations(run),60)
    require(observed['readinessFileVerified'],'readiness-file-identity-required')
    process().adopt(run)


def metric_issues(field, expected):
    require(field['text']==expected,'geometry-text-equality')
    require(field['authoredAlpha'] in (0,1),'source-authored-opacity-changed')
    provider=field['authoredAlpha']==0
    issues=[]
    if not field['active'] or not field['enabled']:issues.append('inactive-or-disabled-text')
    if field['generatedText']!=expected:issues.append('generated-character-sequence-differs')
    if field['missingGlyphs']:issues.append('missingGlyphs')
    # Alpha-zero original layer provides height. Its mesh is retained as evidence,
    # but it is not a visible face and cannot prove visual clipping/invisibility.
    if not provider:
        for key in ('outsideMasks','outsideViewport'):
            if field[key]:issues.append(key)
        # A label's own rect does not clip source Overflow-mode text. Real
        # ancestor masks and viewport bounds above remain rejection boundaries.
        if field['outsideRect'] and field['overflowMode'] != 'Overflow':issues.append('outsideRect')
        if field['effectiveAlpha'] < field['authoredAlpha']*.99:issues.append('ancestor-fade')
        if expected.strip() and field['visibleCharacters']==0:issues.append('no-visible-glyphs')
        if field['overflow']:issues.append('TMP-overflow')
    warnings=['preferred-height-exceeds-rect'] if field['preferredHeight']>field['height'] else []
    if field['outsideRect'] and field['overflowMode']=='Overflow':warnings.append('source-overflow-mesh-outside-own-rect;active-masks-and-viewport-checked-separately')
    return dict(field,role='height-provider' if provider else 'visible-face',issues=issues,warnings=warnings)


def measure(run, case):
    command(run,'cc-measure '+str(case['index']))
    expected=[str(case['index']),base64.b64encode(case['expected'].encode()).decode(),'fixture-restored=true']
    require((run/'cg-selected.txt').read_text(encoding='utf-8-sig').splitlines()==expected,'selected-output-readback')
    fields=[json.loads(x) for x in (run/'cg-geometry.jsonl').read_text(encoding='utf-8-sig').splitlines()]
    require(len(fields)==6 and sum(f['authoredAlpha']==0 for f in fields)==1,'six-source-layers-required')
    fields=[metric_issues(f,case['expected']) for f in fields]
    return dict(index=case['index'],surface=case['surface'],branch=case['branch'],sourceId=case['sourceId'],fields=fields)


def representatives(cases, rows):
    require([r['index'] for r in rows]==[c['index'] for c in cases] and len(cases)==28,'complete28-measurements-required')
    return legacy().representatives(cases,rows)


def capture(run,surface):
    frozen_run(run);process().owned(run)
    folder=run/('cc-'+surface);require(surface in SURFACES and not folder.exists(),'new-surface-attempt-required')
    folder.mkdir();rows=[];captures=[];restored=False;error=None
    cases=[c for c in read(run/'cc-workload.json')['cases'] if c['surface']==surface]
    try:
        command(run,'cg-readback')
        require((run/'cg-readback.tsv').read_text(encoding='utf-8-sig')==(run/'cg-values.tsv').read_text(),'complete129-loaded-states')
        command(run,'cc-ready '+surface)
        with (folder/'measurements.jsonl').open('x') as stream:
            for case in cases:
                row=measure(run,case);rows.append(row);stream.write(json.dumps(row,ensure_ascii=False)+'\n');stream.flush()
        for index in representatives(cases,rows):
            case=next(c for c in cases if c['index']==index);before=measure(run,case)
            name='cc-'+surface+'-'+str(index).zfill(2)+'.png';command(run,'capture '+name)
            path=run/name;deadline=time.monotonic()+15
            from PIL import Image
            while True:
                try:
                    with Image.open(path) as im:im.verify()
                    with Image.open(path) as im:width,height=im.size;extrema=im.convert('RGB').getextrema()
                    require(max(x[1] for x in extrema)>20,'blank-frame');break
                except (OSError,SyntaxError):
                    require(time.monotonic()<deadline,'capture-unknown-outcome');time.sleep(.2)
            after=measure(run,case);require(before==after,'capture-geometry-changed')
            require(all((f['viewportWidth'],f['viewportHeight'])==(width,height) for f in after['fields']),'native-capture-dimensions-differ')
            captures.append(dict(filename=name,sha256=sha(path),width=width,height=height,caseIndex=index,surface=surface,branch=case['branch'],expected=case['expected']))
        command(run,'cg-display-diagnostics');shutil.copyfile(run/'display-diagnostics.tsv',folder/'display-diagnostics.tsv')
        command(run,'cc-display');native=read(run/'cc-display.json')
        require(native['processId']==native['windowProcessId'] and all((c['width'],c['height'])==(native['viewportWidth'],native['viewportHeight']) for c in captures),'native-display-process-or-viewport-mismatch')
        require(native['clientWidth']*native['viewportHeight']==native['clientHeight']*native['viewportWidth'],'native-client-aspect-needs-review')
        shutil.copyfile(run/'cc-display.json',folder/'native-display.json')
    except BaseException as ex:error=repr(ex)
    finally:
        try:
            # Source OOS timers are 1s/2.5s. No selection events are clicked.
            time.sleep(4)
            command(run,'cc-restore');command(run,'cc-verify-restored');restored=True
        except BaseException as ex:error=(error or '')+';restore:'+repr(ex)
        write(folder/'result.json',dict(status='surface-observations-complete' if error is None and restored else 'incomplete',surface=surface,error=error,measuredCases=len(rows),expectedCases=28,captures=captures,restored=restored,evidenceSha256={n:sha(folder/n) for n in ['measurements.jsonl','display-diagnostics.tsv','native-display.json'] if (folder/n).is_file()},geometryIssueCases=[r['index'] for r in rows if any(f['issues'] for f in r['fields'])],visualAccepted=False,actualProgressionAccepted=False),True)
    require(error is None and restored,error)


def parent_unchanged(prep):
    parent=Path(prep['parentBuild']);require(sha(parent/'build.json')==prep['parentBuildSha256'],'parent-build-changed')
    for r in read(parent/'build.json')['files']:
        require(sha(parent/'game'/DATA/r['path'])==r['probeSha256'],'parent-artifact-changed:'+r['path'])


def complete(run, *, cleanup_only=False):
    prep=frozen_run(run)
    results=[read(run/('cc-'+s)/'result.json') for s in SURFACES if (run/('cc-'+s)/'result.json').exists()]
    fully_observed=len(results)==2 and all(r['status']=='surface-observations-complete' and r['measuredCases']==28 and r['restored'] for r in results)
    require(cleanup_only or fully_observed,'both-complete28-receipts-required')
    for result in results:
        for name,digest in result['evidenceSha256'].items():
            require(Path(name).name==name and sha(run/('cc-'+result['surface'])/name)==digest,'surface-evidence-version:'+name)
    if process().observations(run):
        command(run,'quit')
        deadline=time.monotonic()+60
        while process().observations(run):
            require(time.monotonic()<deadline,'normal-quit-timeout-preserve-live-identity-no-relaunch');time.sleep(.5)
    process().no_game_process(run)
    require(not any((run/n).exists() for n in ['command.txt','command.pending']),'unresolved-command')
    parent_unchanged(prep)
    data=run/'game'/DATA;managed=data/'Managed';post=run/'cc-post-runtime';post.mkdir()
    sidecars=[p for p in (run/'game').rglob('tfol.*') if p.is_file()]
    observed={str(p.relative_to(run/'game')):sha(p) for p in sidecars}
    for path in sidecars:
        out=post/path.relative_to(run/'game');out.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(path,out)
    captures=[c for r in results for c in r['captures']]
    require((cleanup_only or captures) and all(sha(run/c['filename'])==c['sha256'] for c in captures),'complete-frame-pins')
    cleanup=dict(taskOwnedProcessesAbsent=True,ownerSaveFilesUsed=False,parentArtifactUnchanged=True,qaFixtureBefore=prep['fixtureBefore'],qaFixtureAfter={n:sha(data/n) for n in prep['fixtureBefore']},postRuntimeSidecars=observed)
    # Preserve post-runtime inputs before restoration. Separate writes are not a
    # transaction; failure receipt and backups remain for exact reconciliation.
    shutil.copyfile(run/'Assembly-CSharp.localized-original.dll',managed/'Assembly-CSharp.dll')
    require(sha(managed/'Assembly-CSharp.dll')==prep['originalAssemblySha256'],'localized-assembly-restoration')
    require(sha(managed/'ForestProbe.dll')==prep['bridgeSha256'],'only-owned-bridge-removal');(managed/'ForestProbe.dll').unlink()
    cleanup.update(localizedAssemblyRestored=True,bridgeRemoved=True)
    write(run/'cleanup.json',cleanup,True)
    write(run/'runtime-result.json',dict(result='observations-complete' if fully_observed else 'incomplete',measuredCases=sum(r['measuredCases'] for r in results),captures=captures,loaded113And16AbsencesVerified=fully_observed,visual='pending',wholeGameAccepted=False),True)
    error=None;verification=None
    try:
        fixture=module('cc_fixture',helpers()/'fixture_preservation.py')
        verification=fixture.verify_fixture(run,Path(prep['fixtureDirectory']),reconcile_resolution_reset=True)
    except BaseException as ex:error=repr(ex)
    finally:
        # Every sidecar is inside the unique task copy; retain all bytes above,
        # then restore exactly the immutable task fixture, never owner saves.
        for path in sidecars:
            require(sha(path)==observed[str(path.relative_to(run/'game'))],'sidecar-changed-during-cleanup')
            if path not in [data/n for n in prep['fixtureBefore']]:path.unlink()
        for n,digest in prep['fixtureBefore'].items():
            shutil.copyfile(Path(prep['fixtureDirectory'])/n,data/n);require(sha(data/n)==digest,'exact-fixture-restoration')
        write(run/'cc-restoration.json',dict(status='restored-with-unresolved-validation' if error else 'restored',validationError=error,fixtureVerification=verification,postRuntimeSidecars=observed,restoredInputs=prep['fixtureBefore'],parentUnchanged=True),True)
    if cleanup_only:
        write(run/'cc-cleanup-complete.json',dict(status='isolated-inputs-and-assembly-restored',runtimeComplete=False,validationError=error,restorationSha256=sha(run/'cc-restoration.json'),wholeGameAccepted=False),True)
        return
    require(error is None,error)
    write(run/'cc-completion.json',dict(status='finite-runtime-observations-complete',measuredCases=56,fixture=verification,surfaces={s:sha(run/('cc-'+s)/'result.json') for s in SURFACES},runtimeResultSha256=sha(run/'runtime-result.json'),cleanupSha256=sha(run/'cleanup.json'),restorationSha256=sha(run/'cc-restoration.json'),visualAccepted=False,wholeGameAccepted=False),True)


def main():
    p=argparse.ArgumentParser(description=__doc__);sub=p.add_subparsers(dest='mode',required=True)
    for mode in ('launch','observe','capture','complete','cleanup','reconcile'):
        q=sub.add_parser(mode);q.add_argument('--run',type=Path,required=True)
        if mode=='capture':q.add_argument('--surface',choices=SURFACES,required=True)
        if mode=='reconcile':q.add_argument('--receipt',type=Path,required=True)
    a=p.parse_args();run=checked_run(a.run)
    if a.mode=='launch':launch(run)
    elif a.mode=='capture':capture(run,a.surface)
    elif a.mode in ('complete','cleanup'):complete(run,cleanup_only=a.mode=='cleanup')
    else:
        frozen_run(run)
        if a.mode=='observe':
            print(json.dumps(dict(observations=process().observations(run),startup=read(run/'startup-state.json') if (run/'startup-state.json').exists() else None,scope='read-only; no relaunch or cancellation')))
        else:reconcile(run,a.receipt)


if __name__=='__main__':main()
