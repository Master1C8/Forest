"""Run one prepared existing locale assignment; no retries, forks or nested workers."""
from pathlib import Path
import datetime,json,subprocess,sys
ROOT=Path('/Users/antonkrutov/Desktop/Forest');sys.path.insert(0,str(ROOT/'tools'))
from cli_job_support import validate_model,cli_events,digest
from cli_runtime_identity import publish_current_runtime
validate_model('gpt-6.1-sol','high','openai')
phase=(ROOT/sys.argv[1]).resolve();assert phase.is_relative_to(ROOT/'outputs/launcher-all30-20261104-01')
assert not (phase/'submission.json').exists(),'Reconcile prior request before resubmission'
config=json.loads((phase/'task.json').read_bytes())
for p,h in config['job']['immutablePins'].items():assert digest(ROOT/p)==h,('Changed prerequisite',p)
cli='/Applications/ChatGPT.app/Contents/Resources/codex-cli/CodexCLI.app/Contents/MacOS/codex'
prompt=f'FIRST await {phase}/runtime-verification.json proving fresh Sol/high/OpenAI/null-parent before localized input. Then read {phase}/brief.md and task.json and finish the bounded existing locale assignment. No inherited history, resume/fork, nested model/agent, Git, game/GUI, publication or server action. Stay within task writePrefixes.'
argv=[cli,'exec','--ignore-user-config','--model','gpt-6.1-sol','-c','model_provider="openai"','-c','model_reasoning_effort="high"','-c','approval_policy="never"','--sandbox','danger-full-access','--disable','multi_agent','--cd',str(ROOT),'--json','--output-last-message',str(phase/'last-message.txt'),prompt]
(phase/'submission.json').write_text(json.dumps(dict(argv=argv,model='gpt-6.1-sol',reasoning='high',provider='openai',fork_context=False),indent=2)+'\n')
with (phase/'events.jsonl').open('xb') as out,(phase/'stderr.log').open('xb') as err:
 child=subprocess.Popen(argv,cwd=ROOT,stdin=subprocess.DEVNULL,stdout=out,stderr=err,start_new_session=True)
(phase/'process.json').write_text(json.dumps(dict(pid=child.pid,phase=str(phase)))+'\n')
runtime=publish_current_runtime(phase,child,timeout=45)
print(json.dumps(dict(phase=str(phase),pid=child.pid,threadId=runtime['threadId'],runtimeVerified=True)),flush=True)
code=child.wait();thread,usage,errors=cli_events(phase/'events.jsonl')
(phase/'process-exit.json').write_text(json.dumps(dict(exitCode=code,threadId=thread,usage=usage,errors=errors,atUTC=datetime.datetime.now(datetime.timezone.utc).isoformat()),indent=2)+'\n')
print(json.dumps(dict(exitCode=code,usage=usage,errors=errors)),flush=True)
