import hashlib,importlib.util,json,time,sys
from pathlib import Path
run=Path(__file__).resolve().parents[1]
p=run/'cg-helpers/capture_chapter_completion_ui.py'
assert hashlib.sha256(p.read_bytes()).hexdigest()=='2361f0a3d7c86e2f60b4eb716bfbdc493db6fe1c88dbae530d80f9c6f0e2780a'
spec=importlib.util.spec_from_file_location('frozen_completion',p);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
m.frozen_run(run)
if len(sys.argv)>1:
 print(json.dumps(m.command(run,sys.argv[1])['status']));sys.exit()
m.launch(run)
for action in ['show-menu','menu StartScreenMainMenu OnClickStart','menu PlayMenu OnClickContinue']:
 m.command(run,action);print('ACK',action,flush=True)
deadline=time.monotonic()+45
while True:
 m.command(run,'dump');state=json.loads((run/'state.json').read_text(encoding='utf-8-sig'))
 if state.get('scene')=='CentralForest':break
 assert time.monotonic()<deadline,'original-scene-readiness-timeout-no-replay'
 time.sleep(1)
print(json.dumps({k:state.get(k) for k in ['scene','conversationActive','responseCount','width','height']}),flush=True)
m.command(run,'cc-description-open');print('ORIGINAL_PAUSE_OPEN',flush=True)
time.sleep(2)
m.command(run,'cc-description-select');print('ORIGINAL_CHAPTER_PANEL_VISIBLE',flush=True)
time.sleep(1)
m.capture(run,'description');print('DESCRIPTION28_CAPTURE_COMPLETED',flush=True)
m.complete(run,cleanup_only=True);print('DESCRIPTION_SCOPE_CLEANUP_COMPLETE',flush=True)
