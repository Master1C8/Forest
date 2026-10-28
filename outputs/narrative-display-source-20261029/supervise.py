"""One fresh authorized technical request; never automatically continues/retries."""
import json
from pathlib import Path
import shutil
import subprocess
import sys
sys.path.insert(0, str(Path(__file__).parent / 'runtime'))
from cli_job_support import validate_model, cli_events, cli_turn_succeeded
from cli_runtime_identity import publish_current_runtime

root = Path('/Users/antonkrutov/Desktop/Forest')
job = Path(__file__).resolve().parent; phase = job / 'check'
validate_model('gpt-6.1-sol', 'high', 'openai')
registry = json.loads((Path.home() / '.codex/models_cache.json').read_text())
assert any(m.get('slug') == 'gpt-6.1-sol' for m in registry['models'])
assert not (job / 'submission-intent.json').exists(), 'Reconcile prior request before retry'
argv = [str(Path(shutil.which('codex')).resolve()), 'exec', '--ignore-user-config', '--model', 'gpt-6.1-sol',
        '-c', 'model_provider="openai"', '-c', 'model_reasoning_effort="high"', '-c', 'approval_policy="never"',
        '--sandbox', 'danger-full-access', '--disable', 'multi_agent', '--cd', str(root), '--json',
        '--output-last-message', str(phase / 'last-message.txt'),
        'Execute the one finite150-occurrence narrative source handoff in ' + str(phase / 'brief.md') +
        '. First read brief.md and dispatch.json. Before localized content verify runtime-verification.json. Fresh no inherited history, no nested jobs, no root README/CHECKPOINT or Git mutations.']
dispatch = dict(model='gpt-6.1-sol', reasoning='high', provider='openai', inheritedHistory=False, argv=argv)
(phase / 'dispatch.json').write_text(json.dumps(dispatch, indent=2) + '\n')
(job / 'submission-intent.json').write_text(json.dumps(dispatch, indent=2) + '\n')
state = dict(status='running')
try:
    with (phase / 'events.jsonl').open('w') as out, (phase / 'stderr.log').open('w') as err:
        child = subprocess.Popen(argv, cwd=root, stdin=subprocess.DEVNULL, stdout=out, stderr=err)
        state['pid'] = child.pid
        (job / 'job.json').write_text(json.dumps(state, indent=2) + '\n')
        publish_current_runtime(phase, child)
        code = child.wait()
    thread, usage, errors = cli_events(phase / 'events.jsonl')
    state.update(exitCode=code, threadId=thread, measuredUsage=usage, errors=errors)
    assert cli_turn_succeeded(code, usage, errors)
    assert json.loads((phase / 'result.json').read_text())['status'] == 'finite-narrative-source-handoff-complete'
    state['status'] = 'complete-awaiting-parent-review'
except BaseException as error:
    state.update(status='held-reconcile-exact-process', reason=repr(error))
    raise
finally:
    (job / 'job.json').write_text(json.dumps(state, indent=2) + '\n')
print(json.dumps(state))
