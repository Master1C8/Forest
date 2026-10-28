"""Pinned process-observer correction around an unchanged live run's frozen helper."""
import hashlib
import importlib.util
import json
from pathlib import Path
import sys


def main():
    run = Path(sys.argv[sys.argv.index('--run') + 1]).resolve()
    here = Path(__file__).resolve().parent
    assert here == run / 'observer-v2'
    pins = json.loads((here / 'inputs.json').read_text())
    for name, digest in pins.items():
        assert hashlib.sha256((run / name).read_bytes()).hexdigest() == digest, name
    sys.path.insert(0,str(here))
    import chapter_gallery_process as process
    spec = importlib.util.spec_from_file_location('frozen_chapter_gallery_capture',run / 'cg-helpers/capture_chapter_gallery_ui.py')
    cg = importlib.util.module_from_spec(spec);spec.loader.exec_module(cg)
    cg.owned = process.owned;cg.no_game_process = process.no_game_process
    if sys.argv[1] == 'command':
        process.owned(run)
        action=sys.argv[sys.argv.index('--action') + 1]
        cg.command(run,action)
    else:
        cg.main()


if __name__ == '__main__':
    main()
