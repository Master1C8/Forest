#!/usr/bin/env python3
"""Prepare one isolated future UI run, or compile only; never launch a game.
Frozen recipe execution is required. Its exact admitted candidate is read-only.
"""
import argparse
import copy
import ctypes
import importlib.util
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys

HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(HERE))
import capture_chapter_completion_ui as cc

PROBE_HELPERS=('capture_chapter_completion_ui.py','prepare_chapter_completion_qa.py','capture_chapter_gallery_ui.py',
               'chapter_gallery_process.py','runtime_startup.py','command.py','fixture_preservation.py',
               'ForestProbe.cs','ChapterGalleryUiProbe.cs','ChapterCompletionUiProbe.cs','InjectProbe.cs','InjectProbe.csproj','prepare_bridge.py')


def source_bundle():
    require=cc.require
    manifest=HERE/'bundle-pins.json'
    require(manifest.exists(),'frozen-execution-bundle-required')
    for name,digest in cc.read(manifest).items():
        p=(HERE/name).resolve();require(p.is_relative_to(HERE) and cc.sha(p)==digest,'frozen-bundle-pin:'+name)
    # Adapter's own source/dependency/target snapshot contract is preserved.
    sys.path.insert(0,str(HERE/'cg-inputs'))
    cc.module('russian_actor_names',HERE/'cg-inputs/russian_actor_names.py')
    cc.module('russian_chapter_gallery_case',HERE/'cg-inputs/russian_chapter_gallery_case.py')
    return cc.candidate_validation(cc.CANDIDATE,locale='ru')


def compile_bridge(output,managed,product):
    output,managed=Path(output).resolve(),Path(managed).resolve()
    cc.require(output.is_relative_to(cc.ROOT) and not output.exists(),'new-private-compile-output-required')
    cc.require(re.fullmatch(r'ForestRuChapterCompletionProbe[0-9_]+',product),'isolated-completion-product-required')
    source=(HERE/'ForestProbe.cs').read_text()
    old='public sealed class ForestProbe : MonoBehaviour';cc.require(source.count(old)==1,'bridge-class-version')
    source=source.replace(old,'public sealed partial class ForestProbe : MonoBehaviour')
    guard='Application.productName != "ForestRuRendererProbe"';cc.require(source.count(guard)==1,'bridge-product-version')
    source=source.replace(guard,'Application.productName != "'+product+'"')
    marker='Debug.Log("FOREST_PROBE_READY " + root + " SAVES " + Application.persistentDataPath);'
    cc.require(source.count(marker)==1,'bridge-ready-version')
    source=source.replace(marker,'File.WriteAllText(Path.Combine(root,"bridge-ready.txt"), "1\\n"+Application.companyName+"\\n"+Application.productName+"\\n"+Application.dataPath);\n        '+marker)
    output.mkdir()
    # Copy ALL compiler inputs, including references; no later mutable dependency.
    refs=output/'managed';shutil.copytree(managed,refs,ignore=shutil.ignore_patterns('*.pdb','*.mdb'))
    payload={'ForestProbe.cs':source.encode(),**{n:(HERE/n).read_bytes() for n in ('ChapterGalleryUiProbe.cs','ChapterCompletionUiProbe.cs')}}
    for n,b in payload.items():(output/n).write_bytes(b)
    row=next(r for r in subprocess.check_output(['dotnet','--list-sdks'],text=True).splitlines() if r.startswith('8.0.131 ['))
    compiler=Path(row.split('[',1)[1].rstrip(']'))/'8.0.131/Roslyn/bincore/csc.dll'
    argv=['dotnet',str(compiler),'-nologo','-target:library','-nostdlib+','-define:CHAPTER_GALLERY_PROBE,CHAPTER_COMPLETION_PROBE','-out:'+str(output/'ForestProbe.dll')]
    argv+=['-r:'+str(p) for p in sorted(refs.glob('*.dll'))]+[str(output/n) for n in payload]
    result=subprocess.run(argv,capture_output=True,text=True)
    receipt=dict(status='compiled-static-only' if result.returncode==0 else 'compile-failed',argv=argv,exitCode=result.returncode,stdout=result.stdout,stderr=result.stderr,compilerSha256=cc.sha(compiler),references={p.name:cc.sha(p) for p in refs.glob('*.dll')},sources={n:cc.sha(output/n) for n in payload},product=product,runtime='not-run',releaseUse=False)
    if result.returncode==0:receipt['bridgeSha256']=cc.sha(output/'ForestProbe.dll')
    cc.write(output/'compile.json',receipt,True)
    cc.require(result.returncode==0,result.stdout+result.stderr)
    return receipt


def stage(candidate,run,fixture,locale):
    cc.require(locale=='ru','explicit-supported-locale-required')
    run=cc.checked_run(run);candidate=Path(candidate).resolve();fixture=Path(fixture).resolve()
    plan,work,build=source_bundle()
    cc.require(candidate==cc.CANDIDATE,'exact-pinned-completion-candidate-required')
    cc.require(not run.exists(),'new-run-required-reconcile-prior-staging')
    cc.process().no_game_process(run)
    manifest=cc.read(fixture/'manifest.json')
    cc.require(fixture.is_relative_to(cc.ROOT/'localization/probes') and manifest['originalOwnerFilesUsed'] is False,'existing-task-generated-fixture-only')
    cc.require(set(manifest['files'])=={'tfol.savegame','tfol.settings'},'two-fixture-inputs-required')
    for n,r in manifest['files'].items():cc.require(cc.sha(fixture/n)==r['sha256'],'source-fixture-pin:'+n)
    cc.require(not list((candidate/'game').rglob('tfol.*')),'candidate-player-sidecars-forbidden')
    cc.require(not (candidate/'game'/cc.DATA/'Managed/ForestProbe.dll').exists(),'candidate-bridge-forbidden')
    product='ForestRuChapterCompletionProbe'+run.name.removeprefix('ru-chapter-completion-').replace('-','_')
    # From here writes are ordered, not transactional. A partial copy has no final
    # preparation receipt and MUST NOT be launched or blindly overwritten.
    run.mkdir();lib=ctypes.CDLL('/usr/lib/libSystem.B.dylib',use_errno=True)
    def clone(src,dst):
        if lib.clonefile(os.fsencode(src),os.fsencode(dst),0):shutil.copyfile(src,dst)
        cc.require(os.stat(src).st_ino!=os.stat(dst).st_ino and cc.sha(src)==cc.sha(dst),'private-clone-integrity')
        return dst
    shutil.copytree(candidate/'game',run/'game',copy_function=clone)
    import UnityPy
    data=run/'game'/cc.DATA;env=UnityPy.load(str(data/'globalgamemanagers'))
    player=next(o for o in env.objects if o.type.name=='PlayerSettings');before=player.read_typetree();after=copy.deepcopy(before)
    cc.require(before['companyName']=='VNRevivalQA' and before['productName']==build['saveIsolation']['productName'],'candidate-isolated-identity')
    after['productName']=product
    other={o.path_id:cc.hashlib.sha256(o.get_raw_data()).hexdigest() for o in env.objects if o.path_id!=player.path_id}
    player.save_typetree(after);(data/'globalgamemanagers').write_bytes(next(iter(env.files.values())).save())
    got={o.path_id:o for o in UnityPy.load(str(data/'globalgamemanagers')).objects}
    cc.require(got[player.path_id].read_typetree()==after and all(cc.hashlib.sha256(got[i].get_raw_data()).hexdigest()==h for i,h in other.items()),'only-product-field-change')
    (data/'app.info').write_text('VNRevivalQA\n'+product)
    build['saveIsolation']['productName']=product
    next(r for r in build['files'] if r['path']=='globalgamemanagers')['probeSha256']=cc.sha(data/'globalgamemanagers')
    inputs=run/'fixture-inputs';shutil.copytree(fixture,inputs)
    for n in manifest['files']:shutil.copyfile(inputs/n,data/n)
    cc.write(run/'build.json',build,True)
    cc.write(run/'qa-preparation.json',dict(parentBuild=str(candidate),parentBuildSha256=cc.BUILD_SHA,ownerFilesUsed=False,fixtureDirectory=str(inputs),fixtureManifestSha256=cc.sha(inputs/'manifest.json'),sourceDisposableFixture=str(fixture),sourceFixtureManifestSha256=cc.sha(fixture/'manifest.json'),onlyPlayerSettingsFieldChanged='productName',allOtherGlobalObjectsByteExact=True),True)
    shutil.copytree(HERE,run/'cg-helpers',ignore=shutil.ignore_patterns('__pycache__'))
    for n in ('cg-workload.json','cg-values.tsv','cg-words.tsv','cg-cases.tsv','cc-selectors.tsv'):
        shutil.copyfile(HERE/n,run/n)
    cc.write(run/'cc-workload.json',work,True)
    # Snapshot input plan already exists in this frozen execution bundle.
    shutil.copytree(HERE/'cg-inputs',run/'cg-inputs')
    compiled=run/'cc-compile';receipt=compile_bridge(compiled,data/'Managed',product)
    managed=data/'Managed';original=run/'Assembly-CSharp.localized-original.dll';shutil.copyfile(managed/'Assembly-CSharp.dll',original)
    cc.require(cc.sha(original)==cc.ASSEMBLY_SHA,'localized-input-assembly-pin')
    injector=run/'cc-injector';injector.mkdir()
    source=(HERE/'InjectProbe.cs').read_text();old='46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
    cc.require(source.count(old)==1,'injector-source-pin');(injector/'InjectProbe.cs').write_text(source.replace(old,cc.ASSEMBLY_SHA))
    shutil.copyfile(HERE/'InjectProbe.csproj',injector/'InjectProbe.csproj')
    subprocess.run(['dotnet','build',str(injector/'InjectProbe.csproj'),'--nologo','-v','quiet','--ignore-failed-sources'],check=True)
    subprocess.run(['dotnet',str(injector/'bin/Debug/net8.0/InjectProbe.dll'),str(compiled/'managed'),str(compiled/'ForestProbe.dll'),str(run/'Assembly-CSharp.hook.dll')],check=True)
    shutil.copyfile(compiled/'ForestProbe.dll',managed/'ForestProbe.dll');shutil.copyfile(run/'Assembly-CSharp.hook.dll',managed/'Assembly-CSharp.dll')
    tracked=[p for folder in [run/'cg-helpers',run/'cg-inputs',compiled,injector] for p in folder.rglob('*') if p.is_file()]
    tracked += [run/n for n in ['build.json','qa-preparation.json','cc-workload.json','cg-workload.json','cg-values.tsv','cg-words.tsv','cg-cases.tsv','cc-selectors.tsv','Assembly-CSharp.localized-original.dll','Assembly-CSharp.hook.dll']]
    tracked += [p for p in (run/'game').rglob('*') if p.is_file() and p.name not in ['tfol.savegame','tfol.settings']]
    cc.write(run/'cc-execution-pins.json',{str(p.relative_to(run)):cc.sha(p) for p in tracked},True)
    cc.write(run/'cc-preparation.json',dict(status='prepared-not-run',counts=work['counts'],parentBuild=str(candidate),parentBuildSha256=cc.BUILD_SHA,executionPinsSha256=cc.sha(run/'cc-execution-pins.json'),fixtureDirectory=str(inputs),fixtureBefore={n:r['sha256'] for n,r in manifest['files'].items()},fixtureManifestSha256=cc.sha(inputs/'manifest.json'),originalAssemblySha256=cc.ASSEMBLY_SHA,bridgeSha256=receipt['bridgeSha256'],sourceSidecarsBefore=[],nativeRoutes='OOS original subscriber effects remain held. Description follows guarded original PauseHelper.Pause and bound OnClickChapterSelect route; measure requires its visible source-selected panel. No chapter selection/progression callback.',preparedNotLaunched=True,runtime='not-run',wholeGameAccepted=False),True)
    print(json.dumps(dict(status='prepared-not-launched',run=str(run),product=product,cases=56)))


def main():
    p=argparse.ArgumentParser(description=__doc__);sub=p.add_subparsers(dest='mode',required=True)
    q=sub.add_parser('prepare');q.add_argument('--candidate',type=Path,required=True);q.add_argument('--run',type=Path,required=True);q.add_argument('--fixture',type=Path,required=True);q.add_argument('--locale',required=True)
    q=sub.add_parser('compile-only');q.add_argument('--output',type=Path,required=True);q.add_argument('--managed',type=Path,required=True);q.add_argument('--product',required=True)
    a=p.parse_args()
    if a.mode=='prepare':stage(a.candidate,a.run,a.fixture,a.locale)
    else:compile_bridge(a.output,a.managed,a.product)


if __name__=='__main__':main()
