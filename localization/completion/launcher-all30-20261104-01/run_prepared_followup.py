"""Continue one verified closed locale assignment into its prepared finite phase."""
from pathlib import Path
import json,sys
R=Path('/Users/antonkrutov/Desktop/Forest');sys.path.insert(0,str(R/'localization/completion/launcher-all30-20261104-01/hi-review-continuation/runtime'))
from locale_cli_lifecycle import Supervisor,read,save,digest,latest_usage,now,validate_identity
phase=R/sys.argv[1];previous=R/sys.argv[2]
assert phase.is_relative_to(R/'outputs/launcher-all30-20261104-01')
assert previous.is_relative_to(R/'outputs/launcher-all30-20261104-01')
assert not (phase/'submission.json').exists(),'Reconcile existing submission'
task=read(phase/'task.json')
for p,h in task['job']['immutablePins'].items():assert digest(R/p)==h,p
runtime=read(previous/'runtime-verification.json');validate_identity(runtime);receipt=read(previous/'process-exit.json');assert receipt['exitCode']==0
lane=dict(locale=task['job']['locale'],language='localization/languages/'+task['job']['locale']+'.json',phase=str(previous.relative_to(R)),progressRoots=[str(phase.parent.relative_to(R))])
cfg=dict(model='gpt-6.1-sol',reasoning='high',provider='openai',streamCap=1,lanes=[lane],sourcePacket='localization/completion/five-new-locales-20261101-01/source-context.jsonl',preservation='localization/completion/five-new-locales-20261101-01/source-preservation.json',cli='/Applications/ChatGPT.app/Contents/Resources/codex-cli/CodexCLI.app/Contents/MacOS/codex')
class Prepared(Supervisor):
 def prepare_phase(self,lane,previous,language):return phase,1
supervisor=Prepared(R,cfg,phase/'supervisor');supervisor.output.mkdir(exist_ok=False)
supervisor.launch(lane,dict(lane),{'sha256':task['job']['initialLanguageSha256']})
print(json.dumps(dict(pid=lane['pid'],phase=lane['phase'],threadId=lane['threadId'],verified=True)),flush=True)
child,baseline,session=supervisor.children[lane['locale']];code=child.wait();final=latest_usage(session);usage={k:final[k]-baseline[k] for k in final};assert all(v>=0 for v in usage.values())
save(phase/'process-exit.json',dict(exitCode=code,finishedAt=now(),usage=usage,baselineUsage=baseline,finalCumulativeUsage=final,telemetry='Nonoverlapping same-own-task attempt delta; cached input/reasoning are subsets.'))
print(json.dumps(dict(exitCode=code,usage=usage)),flush=True)
