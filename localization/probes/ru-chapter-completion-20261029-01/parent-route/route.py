import sys,json,hashlib,importlib.util
from pathlib import Path
run=Path(__file__).resolve().parent.parent
path=run/'cg-helpers/capture_chapter_completion_ui.py'
pin=json.loads(Path(__file__).with_name('pins.json').read_text())
assert hashlib.sha256(path.read_bytes()).hexdigest()==pin['runnerSha256']
spec=importlib.util.spec_from_file_location('parent_completion_route',path);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
m.frozen_run(run)
assert len(sys.argv)==2
receipt=m.command(run,sys.argv[1]);print(json.dumps({'status':receipt['status'],'action':receipt['action']}))
