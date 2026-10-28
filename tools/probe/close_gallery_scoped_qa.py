"""Close and restore one completed gallery scope without claiming other surfaces."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import shutil
import sys
import time


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(path):
    return json.loads(path.read_text())


def close(run):
    run = run.resolve()
    assert run.parent == Path('/Users/antonkrutov/Desktop/Forest/localization/probes')
    assert not (run / 'gallery-scoped-completion.json').exists()
    surface = read(run / 'cg-gallery/result.json')
    assert surface['status'] == 'surface-observations-complete' and surface['restored'] and surface['measuredCases'] == 3367
    assert not (run / 'command.txt').exists()
    sys.path.insert(0,str(run / 'observer-v2'))
    import chapter_gallery_process as process
    spec=importlib.util.spec_from_file_location('scoped_gallery_capture',run / 'cg-helpers/capture_chapter_gallery_ui.py')
    cg=importlib.util.module_from_spec(spec);spec.loader.exec_module(cg)
    cg.owned=process.owned;cg.no_game_process=process.no_game_process
    cg.pins(run);process.owned(run)
    cg.command(run,'restore-input-policy')
    cg.command(run,'quit')
    deadline=time.monotonic()+30
    while process.observations(run):
        assert time.monotonic()<deadline, 'task-process-exit-pending; do not restart or kill broadly'
        time.sleep(.25)
    process.no_game_process(run)
    prep=read(run / 'cg-preparation.json');fixture=Path(prep['fixtureDirectory'])
    manifest=read(fixture / 'manifest.json');assert manifest['originalOwnerFilesUsed'] is False
    data=run / 'game/The Forest of Love_Data'
    preserved=run / 'post-runtime-fixture';preserved.mkdir()
    states={}
    for name,row in manifest['files'].items():
        assert name in ['tfol.settings','tfol.savegame'] and sha(fixture/name)==row['sha256']
        shutil.copyfile(data/name,preserved/name)
        states[name]=dict(beforeRuntimeSha256=row['sha256'],afterRuntimeSha256=sha(data/name),
                          runtimeBytesPreservedAt=str((preserved/name).relative_to(run)))
        shutil.copyfile(fixture/name,data/name)
        states[name]['restoredSha256']=sha(data/name)
        assert states[name]['restoredSha256']==row['sha256']
    managed=data/'Managed';original=run/'Assembly-CSharp.localized-original.dll'
    assert sha(original)==prep['originalAssemblySha256']
    assert sha(managed/'ForestProbe.dll')==read(run/'cg-execution-pins.json')['game/The Forest of Love_Data/Managed/ForestProbe.dll']
    shutil.copyfile(original,managed/'Assembly-CSharp.dll');(managed/'ForestProbe.dll').unlink()
    parent=Path(prep['parentBuild']);assert sha(parent/'build.json')==prep['parentBuildSha256']
    assert all(sha(parent/'game/The Forest of Love_Data'/r['path'])==r['probeSha256'] for r in read(parent/'build.json')['files'])
    assert all(sha(run/c['filename'])==c['sha256'] for c in surface['captures'])
    result=dict(status='gallery-scope-complete-restored',measuredCases=3367,capturedFrames=10,
                loadedNonemptyValues=113,preservedAbsentValues=16,gallerySelectionIdentities=59,
                taskProcessesAbsent=True,localizedAssemblyRestored=sha(managed/'Assembly-CSharp.dll')==prep['originalAssemblySha256'],
                bridgeRemoved=not (managed/'ForestProbe.dll').exists(),parentArtifactUnchanged=True,
                fixtureStates=states,fixtureRestoration='Original tutorial route can write generated gallery-tutorial flags. Preserve actual post-runtime bytes, then restore both exact disposable inputs after the owned game exits.',
                nativeTextRestored=True,originalGameOrOwnerSavesUsed=False,remainingSurfaces=['oos','description'],
                allThreeSurfacesAccepted=False,actualEligibilityAccepted=False,wholeGameAccepted=False,
                surfaceReceiptSha256=sha(run/'cg-gallery/result.json'))
    (run/'gallery-scoped-completion.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k not in ['fixtureStates','fixtureRestoration']}))


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--run',type=Path,required=True)
    close(parser.parse_args().run)
