"""Parent-only continuation of the same six CLI author threads, never a fork."""
import datetime
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
sys.path.insert(0, str(ROOT/'tools'))
from cli_job_support import validate_model
from locale_efficiency import latest_usage

CONTROL = Path(__file__).resolve().parent
CONFIG = json.loads((CONTROL/'manifest.json').read_text())
OUT = ROOT/'outputs'/CONFIG['run']/'continuations'
CLI = '/Applications/ChatGPT.app/Contents/Resources/codex-cli/CodexCLI.app/Contents/MacOS/codex'


def read(p):
    return json.loads(p.read_bytes())


def save(p, obj):
    p.parent.mkdir(parents=True, exist_ok=True)
    tmp = p.with_suffix(p.suffix+'.pending')
    tmp.write_text(json.dumps(obj, ensure_ascii=False, indent=2)+'\n')
    tmp.replace(p)


def now():
    return datetime.datetime.now(datetime.timezone.utc).isoformat()


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def alive(pid):
    return subprocess.run(['ps', '-p', str(pid), '-o', 'pid='], capture_output=True).returncode == 0


def stats(locale, phase):
    doc = read(ROOT/'localization/languages'/f'{locale}.json')
    preserved = read(CONTROL.parent/'source-preservation.json')['baselinePreserved']
    assert all(doc['translations'][i]['source'] == doc['translations'][i]['target'] for i in preserved)
    cp = read(phase/'checkpoint.json') if (phase/'checkpoint.json').exists() else {}
    progress = [cp.get('primaryReviewedOrdinary', 0), cp.get('specialCasesDecided', 0)]
    for d in [cp.get(k, {}) for k in ['counts', 'coverage', 'specialGate']]:
        if isinstance(d, dict):
            progress.extend(d.get(k, 0) for k in ['primaryReviewed', 'primaryReviewedOrdinary',
                'ordinaryPrimaryAudit', 'ordinaryPrimaryAudited', 'primaryAudited', 'specialCasesSettled',
                'specialCasesReviewed', 'completed'])
    return dict(filled=sum(v['target'] is not None for i, v in doc['translations'].items() if i not in preserved),
                coverage=sum(v for v in progress if type(v) is int),
                languageSha256=sha(ROOT/'localization/languages'/f'{locale}.json'))


def may_continue(exit_code, ready, live, before, after, new_policy):
    return (exit_code == 0 and not ready and not live and
            (new_policy or after['filled'] > before['filled'] or after['coverage'] > before['coverage']))


def closed_turn(session):
    last = None
    with session.open('rb') as f:
        f.seek(max(0, session.stat().st_size-5_000_000))
        if f.tell():
            f.readline()
        for line in f:
            try:
                e = json.loads(line)
            except ValueError:
                continue
            p = e.get('payload', {})
            if e.get('type') == 'event_msg' and p.get('type') in ['task_started', 'task_complete', 'turn_aborted']:
                last = p.get('type')
    return last in ['task_complete', 'turn_aborted']


def launch(lane, prior_phase, before):
    session = Path(lane['sessionMetadataPath'])
    assert closed_turn(session), 'Unknown/live thread state; preserve, do not duplicate'
    count = lane['phaseNumber']+1
    phase = ROOT/'outputs'/CONFIG['run']/lane['locale']/f'author-{count:02d}'
    assert not phase.exists(), 'Occupied continuation identity; reconcile first'
    phase.mkdir()
    lang = ROOT/'localization/languages'/f"{lane['locale']}.json"
    (phase/'starting-language.json').write_bytes(lang.read_bytes())
    original = ROOT/lane['originalPhase']
    task = read(original/'task.json')
    task['job']['initialLanguageSha256'] = sha(lang)
    task['job']['writePrefixes'] = [str(phase.relative_to(ROOT)) if p == lane['originalPhase'] else p
                                  for p in task['job']['writePrefixes']]
    for p in [CONTROL.parent/'poetry-autonomy-20261101.json', phase/'starting-language.json']:
        task['job']['immutablePins'][str(p.relative_to(ROOT))] = sha(p)
    task['task']['continuationOf'] = str(prior_phase.relative_to(ROOT))
    save(phase/'task.json', task)
    for name, expected in task['job']['immutablePins'].items():
        assert sha(ROOT/name) == expected, 'Changed required input: '+name
    (phase/'brief.md').write_text(f'''# Finish the same complete {lane['locale']} assignment

This is a parent continuation of YOUR OWN existing thread, not a fork, new agent
or inherited parent conversation. FIRST await {phase}/runtime-verification.json
and verify the NEW actual Sol/high/OpenAI turn after the journal offset BEFORE
localized input. Same six streams only. No nested models, Git/shared/source/glossary
edits, old queues, game/GUI/install/publication/server actions.

Read task.json and your exact checkpoint/result/remaining IDs in {prior_phase}.
Reuse valid own drafts, actual read receipts and settled cases. Original scope and
guards remain in {original}/brief.md. Do not restart the corpus/glossary or repeat
completed groups. No numeric token/response/time limit was assigned. A finite batch,
low output threshold or routine checkpoint is NOT completion. Finish all12825
ordinary translations and the complete primary source/target/context audit,
consolidated repairs and exact self-deltas. Do not stop incomplete when useful
authorized work remains without a genuine current source/authority blocker.

OWNER DECISION IS NOW DIRECTLY DELIVERED: read
{CONTROL.parent}/poetry-autonomy-20261101.json. Owner explicitly said реши сам.
Prefer natural5-7-5 adaptation; rhetorical necessity/current time or repeated
positive modifiers may remain implicit in the disclosed poetic manner. Turkish
candidates Hoş içki, dostlar and Şimdi niye iş? each have5 syllables. Actually assess
them in the whole own source/target group, correcting objective native/meaning
problems rather than requiring a literal extra syllable or another owner permission.
Italian and other locales resolve this same tradeoff themselves. Keep plurality,
agency, referents/reveal timing, whole poems/quotes/feedback, all9 paired choices
and27 original outcomes. Reuse valid earlier decisions. Record final readings and
the real complete special-case gate, then proceed with ordinary batches.
The earlier queued decision turns aborted during CLI shutdown; they are reconciled,
not another live worker. This direct prompt supplies the authority. Independent
review is still required later; do not self-certify it.

Write only the existing language file, own case/editorial directory and THIS new
author phase. Preserve all frozen prior outputs/helpers. Update this checkpoint
through long work/compaction. Do not build resources before independent closure.
Publish the exact full review-ready handoff only at complete assigned coverage.
A real blocker needs exact evidence and remaining IDs, not a resolved policy repeat.
''')
    baseline = latest_usage(session)
    offset = session.stat().st_size
    args = [CLI, 'exec', 'resume', '--ignore-user-config', '--model', 'gpt-6.1-sol',
        '-c', 'model_provider="openai"', '-c', 'model_reasoning_effort="high"',
        '-c', 'approval_policy="never"', '-c', 'sandbox_mode="danger-full-access"',
        '--disable', 'multi_agent', '--json', '--output-last-message', str(phase/'last-message.txt'),
        lane['threadId'], f'Continue your SAME complete author task through {phase}/brief.md and task.json. '
        f'FIRST await {phase}/runtime-verification.json verifying the NEW actual resumed turn before localized input. '
        'Read the directly delivered owner poetry decision; no pending permission on this tradeoff. '
        'No nested models, inherited parent chat, Git/shared edits, runtime/publication or early batch stopping.']
    save(phase/'submission.json', dict(argv=args, threadId=lane['threadId'], baselineUsage=baseline,
        metadataOffset=offset, atUTC=now(), sameOwnThread=True, inheritedParentHistory=False))
    with (phase/'events.jsonl').open('x') as out, (phase/'stderr.log').open('x') as err:
        child = subprocess.Popen(args, cwd=ROOT, stdin=subprocess.DEVNULL, stdout=out,
                                 stderr=err, start_new_session=True)
    save(phase/'launch.json', dict(pid=child.pid, atUTC=now()))
    lane.update(phaseNumber=count, currentPhase=str(phase.relative_to(ROOT)), pid=child.pid,
                startingStats=before, status='verifying-resumed-runtime', policyDelivered=True)
    save(OUT/'status.json', STATE)
    deadline = time.monotonic()+30
    actual = None
    while time.monotonic() < deadline:
        with session.open('rb') as f:
            f.seek(offset)
            lines = f.read().splitlines()
        for line in lines:
            try:
                e = json.loads(line)
            except ValueError:
                continue
            if e.get('type') == 'turn_context':
                p = e['payload']; actual = dict(model=p.get('model'), effort=p.get('effort'))
        if actual:
            break
        if child.poll() is not None:
            raise RuntimeError('Child exited before new-turn identity; reconcile known process')
        time.sleep(.1)
    assert actual == dict(model='gpt-6.1-sol', effort='high'), 'Unknown resumed model; preserve child, no retry'
    argv = subprocess.run(['ps', '-p', str(child.pid), '-o', 'pid=,ppid=,lstart=,command='],
                          capture_output=True, text=True)
    assert argv.returncode == 0 and all(x in argv.stdout for x in [' exec resume --ignore-user-config',
        '--model gpt-6.1-sol', 'model_provider="openai"', 'model_reasoning_effort="high"', str(phase), lane['threadId']])
    save(phase/'runtime-verification.json', dict(threadId=lane['threadId'], sessionMetadataPath=str(session),
        pid=child.pid, actualRuntime=dict(session=lane['sourceRuntime']['actualRuntime']['session'], turn=actual),
        actualArgvEvidence=argv.stdout, resumedOwnTaskNoParentHistory=True,
        currentTurnMetadataAfterOffset=offset, baselineUsage=baseline))
    lane.update(status='running', runtimeVerified=True, phaseBaselineUsage=baseline)
    save(OUT/'status.json', STATE)
    print(json.dumps(dict(locale=lane['locale'], phase=lane['currentPhase'], pid=child.pid,
        threadId=lane['threadId'], actualRuntime=actual, status='running')), flush=True)
    return child


def main():
    global STATE
    validate_model(CONFIG['model'], CONFIG['reasoning'], CONFIG['provider'])
    assert CONFIG['model'] == 'gpt-6.1-sol' and len(CONFIG['lanes']) == CONFIG['maxActiveLocaleStreams'] == 6
    OUT.mkdir(parents=True, exist_ok=True)
    assert not (OUT/'supervisor.json').exists(), 'Reconcile known observer; never duplicate'
    STATE = dict(status='running', atUTC=now(), lanes=[])
    children = {}
    for original in CONFIG['lanes']:
        STATE['lanes'].append(dict(original, phaseNumber=1, currentPhase=original['originalPhase'],
            pid=original['originalPid'], startingStats=dict(filled=0, coverage=0),
            status='observing-original', policyDelivered=False))
    save(OUT/'supervisor.json', dict(pid=os.getpid(), startedAtUTC=now(), executionSha256=sha(Path(__file__))))
    save(OUT/'status.json', STATE)
    try:
        while any(l['status'] not in ['review-ready-awaiting-independent', 'needs-attention'] for l in STATE['lanes']):
            changed = False
            for lane in STATE['lanes']:
                if lane['status'] in ['review-ready-awaiting-independent', 'needs-attention']:
                    continue
                phase = ROOT/lane['currentPhase']; child = children.get(lane['locale'])
                receipt = phase/'process-exit.json'
                if child:
                    code = child.poll()
                    if code is None:
                        continue
                    final = latest_usage(Path(lane['sessionMetadataPath'])); baseline = lane['phaseBaselineUsage']
                    delta = {k:final[k]-baseline.get(k, 0) for k in final}
                    assert all(v >= 0 for v in delta.values())
                    save(receipt, dict(exitCode=code, finishedAt=now(), usage=delta, baselineUsage=baseline,
                        finalCumulativeUsage=final, telemetry='Nonoverlapping same-session delta; cache/reasoning subsets'))
                    del children[lane['locale']]
                elif not receipt.exists() or alive(lane['pid']):
                    continue
                end = read(receipt)
                result = read(phase/'result.json') if (phase/'result.json').exists() else {}
                after = stats(lane['locale'], phase)
                ready = result.get('status') == 'review-ready' and after['filled'] == 12825
                save(phase/'parent-continuation-check.json', dict(endingStats=after,
                    resultStatus=result.get('status'), sourceReceipt=str(receipt.relative_to(ROOT)),
                    atUTC=now(), independentAcceptance=False))
                if may_continue(end['exitCode'], ready, alive(lane['pid']), lane['startingStats'], after,
                                not lane['policyDelivered']):
                    children[lane['locale']] = launch(lane, phase, after)
                else:
                    lane.update(status='review-ready-awaiting-independent' if ready else 'needs-attention',
                        endingStats=after, exitCode=end['exitCode'], resultStatus=result.get('status'))
                changed = True
            if changed:
                STATE['atUTC'] = now(); save(OUT/'status.json', STATE)
            time.sleep(1)
        STATE.update(status='author-phases-finished', atUTC=now()); save(OUT/'status.json', STATE)
        save(OUT/'completion.json', dict(atUTC=now(), independentReview='parent-owned-pending', native='not-run'))
    except BaseException as e:
        STATE.update(status='observer-error-preserve-active-children', error=repr(e), atUTC=now())
        save(OUT/'status.json', STATE)
        raise


if __name__ == '__main__':
    main()
