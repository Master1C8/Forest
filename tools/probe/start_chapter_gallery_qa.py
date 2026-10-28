"""One parent-owned isolated launch; preserve unknown outcomes and live children."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys


def start(run):
    run = run.resolve()
    assert run.parent == Path('/Users/antonkrutov/Desktop/Forest/localization/probes')
    assert not any((run / n).exists() for n in ['launch.json', 'launch-intent.json', 'task-process.json'])
    sys.path.insert(0, str(run / 'cg-helpers'))
    import capture_chapter_gallery_ui as cg
    from chapter_gallery_process import observations, actual_command
    from runtime_startup import wait_for_probe
    cg.pins(run); cg.no_game_process(run)
    exe = run / 'game/The Forest of Love.exe'
    def owned_rows():
        rows = subprocess.check_output(['ps', '-axo', 'pid=,ppid=,command='], text=True).splitlines()
        variants = [str(exe), 'Z:' + str(exe).replace('/', '\\'), 'Y:' + str(exe).replace('/Users/antonkrutov', '', 1).replace('/', '\\')]
        return [line.strip() for line in rows if any(v in line for v in variants)]
    assert not owned_rows()
    args = ['/Applications/CrossOver.app/Contents/SharedSupport/CrossOver/bin/wine', '--bottle',
            '/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam', '--no-update', str(exe),
            '-screen-fullscreen', '0', '-screen-width', '1280', '-screen-height', '720',
            '-logFile', str(run / 'player.log')]
    recipe = run / Path(__file__).name
    if recipe.resolve() != Path(__file__).resolve():
        assert not recipe.exists(); shutil.copyfile(Path(__file__), recipe)
    receipt = dict(command=args, recipeSha256=hashlib.sha256(recipe.read_bytes()).hexdigest(),
                   scope='One isolated authorized Russian QA launch; no bottle restart or original player files',
                   preparationSha256=hashlib.sha256((run / 'cg-preparation.json').read_bytes()).hexdigest())
    (run / 'launch-intent.json').write_text(json.dumps(receipt, indent=2) + '\n')
    with (run / 'wine.log').open('xb') as log:
        child = subprocess.Popen(args, cwd=exe.parent, stdin=subprocess.DEVNULL, stdout=log,
                                 stderr=subprocess.STDOUT, start_new_session=True)
    receipt['launcherPid'] = child.pid
    (run / 'launch.json').write_text(json.dumps(receipt, indent=2) + '\n')
    observed = wait_for_probe(run, child, owned_rows, 300)
    assert observed['readinessFileVerified'], 'verified bridge readiness required'
    rows = [r for r in observations(run) if r['nativeGame']]
    assert len(rows) == 1, ('reconcile-actual-task-processes', rows)
    pid = rows[0]['pid']; identity = cg.ps_identity(pid)
    assert identity and actual_command(rows[0]['command'],run), 'exact native task command must be reconciled'
    (run / 'task-process.json').write_text(json.dumps(dict(pid=pid, executable=str(exe), psIdentity=identity), indent=2) + '\n')
    cg.owned(run)
    print(json.dumps(dict(status='ready', actualPid=pid, launcherPid=child.pid, run=str(run))))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', type=Path, required=True)
    start(parser.parse_args().run)
