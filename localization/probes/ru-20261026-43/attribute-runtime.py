"""Offline scalar attribution for consumed43; never launches or opens images.

This postrun recipe was added after runtime, outside its frozen execution manifest.
Process, command, focus and Unity intervals overlap; do not add their totals.
"""
from collections import Counter, defaultdict
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path

run = Path(__file__).resolve().parent
assert run.name == 'ru-20261026-43'
names = ['process-lifetime.jsonl', 'actions.log', 'focus-observations.json',
         'newgame-observations.json', 'intro-observation-budget.json',
         'startup-observation.json', 'intro-progression.json', 'natural-route.json',
         'runtime-result.json', 'observer-exit.json', 'final-verification.json']
raw = {n: (run/n).read_bytes() for n in names}
load = lambda n: json.loads(raw[n])
events = [json.loads(row) for row in raw['process-lifetime.jsonl'].splitlines()]
actions = [row.decode().split(' OK ', 1)[1] for row in raw['actions.log'].splitlines()]
assert load('runtime-result.json')['result'] == 'passed'
assert load('observer-exit.json')['returnCode'] == 0
assert load('final-verification.json')['status'] == 'passed'
groups = []
for e in events:
    assert e['hostBeforeAppendMonotonic'] >= e['monotonic']
    if e['boundary'] == 'before-command':
        groups.append([e])
    elif e['boundary'] in ['await-ack', 'transport-returned', 'transport-reaped']:
        assert groups[-1][0]['command'] == e['command']
        groups[-1].append(e)
assert len(groups) == len(actions)
command_rows = []
for group, action in zip(groups, actions):
    before, reaped = group[0], group[-1]
    returned, = [e for e in group if e['boundary'] == 'transport-returned']
    assert before['command'] == action and reaped['boundary'] == 'transport-reaped'
    assert reaped['transportExitCode'] == 0 and not reaped['transportStoppedByObserver']
    assert reaped['unresolvedCommand'] is None and not reaped['pendingCommand']
    sample = reaped['processSample']
    assert sample['reused'] and sample['sourceBoundary'] == 'transport-returned'
    assert sample['sourceMonotonic'] == returned['monotonic']
    assert (sample['started'], sample['completed']) == (returned['processSample']['started'], returned['processSample']['completed'])
    assert reaped['transportPid'] == returned['transportPid']
    assert reaped['ownedProcessRows'] == returned['ownedProcessRows']
    command_rows.append(dict(command=action, start=before['monotonic'], end=reaped['monotonic'],
        beforeToReaped=reaped['monotonic']-before['monotonic'],
        returnedToReaped=reaped['monotonic']-returned['monotonic']))
fresh = [e for e in events if not e['processSample']['reused']]
assert all(e['processSample']['started'] <= e['processSample']['completed'] <= e['monotonic'] for e in fresh)
by_boundary = defaultdict(list)
for e in fresh:
    by_boundary[e['boundary']].append(e['processSample']['completed']-e['processSample']['started'])
focus = load('focus-observations.json')
focus_parts = Counter()
for f in focus:
    t = f['hostTiming']
    keys = ['started', 'commandReturned', 'nativeStarted', 'nativeReturned', 'beforeAppend']
    assert all(t[a] <= t[b] for a,b in zip(keys,keys[1:]))
    for label,a,b in [('command','started','commandReturned'), ('decode','commandReturned','nativeStarted'),
                      ('nativeHelper','nativeStarted','nativeReturned'), ('afterNative','nativeReturned','beforeAppend')]:
        focus_parts[label] += t[b]-t[a]
observations = load('newgame-observations.json')
first,last = observations[0],observations[-1]
intro = load('intro-progression.json')
route = load('natural-route.json')
assert route['result'] == 'passed' and len(route['pulses']) == 5
assert len(intro['seenEntries']) == 49 and len(intro['submittedResponses']) == 10
result = dict(verifiedAt=datetime.now(timezone.utc).isoformat(),
    inputs={n:dict(bytes=len(v),sha256=hashlib.sha256(v).hexdigest()) for n,v in raw.items()},
    lifecycleEvents=len(events), successfulCommands=len(groups), exactAckExitAndDatedReuseVerified=len(groups),
    freshProcessScans=len(fresh), datedReusedProcessRows=len(events)-len(fresh),
    freshProcessScanSeconds=sum(sum(v) for v in by_boundary.values()),
    scansByBoundary={k:dict(count=len(v),seconds=sum(v)) for k,v in by_boundary.items()},
    lifetimeAfterScanBeforeAppendSeconds=sum(e['hostBeforeAppendMonotonic']-e['monotonic'] for e in events),
    commandSpanSeconds=command_rows[-1]['end']-command_rows[0]['start'],
    commandBracketsSeconds=sum(r['beforeToReaped'] for r in command_rows),
    returnedToReapedSeconds=sum(r['returnedToReaped'] for r in command_rows),
    betweenCommandSeconds=sum(b['start']-a['end'] for a,b in zip(command_rows,command_rows[1:])),
    passiveFocus=dict(observations=len(focus),seconds=dict(focus_parts)),
    sourceSamples=dict(count=len(observations),firstFrame=first['frame'],lastFrame=last['frame'],
        frameDelta=last['frame']-first['frame'],hostElapsedDelta=last['elapsed']-first['elapsed'],
        unityRealtimeDelta=last['realtime']-first['realtime'],unityScaledDelta=last['scaledTime']-first['scaledTime']),
    originalIntro=dict(contentNodes=len(intro['seenEntries']),sourceBoundResponses=len(intro['submittedResponses']),
        terminalFrames=intro['observationBudget']['actualTerminalFrames'],budget=intro['observationBudget']),
    naturalRoute=dict(pulses=len(route['pulses']),spentMilliseconds=route['spentMilliseconds'],arrival='CentralForest'),
    startupSeconds=load('startup-observation.json')['elapsedSeconds'],runtimeSeconds=load('runtime-result.json')['durationSeconds'],
    limits=[
        '313 exact successful commands reuse their own fresh returned scan only for completion bookkeeping; every admission and next command remains fresh.',
        'Observed removal of one duplicate scan per successful command is established. Counterfactual saved seconds are not measured.',
        'Fresh process scans bracket ps and its subprocess decoding; lifetime after-scan metadata excludes append/flush. Focus decode brackets scalar JSON/validation; native helper brackets include child scheduling.',
        'Process, command, focus and Unity durations overlap. They are not additive or pure source-wait measurements.',
        'Consumed42 ended after38 observations at145:214;43 completed112 observations/49 content nodes and route. Workload, startup, original menu frames, scheduling and caches differ; whole-run speedup cannot be attributed to the repair.',
        'No source, renderer, visual, editorial or final-delivery acceptance follows from this scoped runtime success.'
    ])
(run/'instrumentation-attribution.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({k:v for k,v in result.items() if k not in ['inputs','limits','scansByBoundary']},indent=2))
