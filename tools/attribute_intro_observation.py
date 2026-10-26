#!/usr/bin/env python3
"""Attribute only sampled intervals in consumed42's four frozen scalar files.

Read-only, offline analysis; never opens player/Wine/native logs or images.
ACK brackets use UTC across processes, host partitions use monotonic time.
Intervals overlap game execution and must not be added to Unity elapsed time.
"""
import argparse
from collections import defaultdict
from datetime import datetime
import hashlib
import json
from pathlib import Path
import re


def utc(value):
    # Unity emits seven fractional digits; Python 3.9 accepts at most six.
    return datetime.fromisoformat(re.sub(r'(\.\d{6})\d+', r'\1', value).replace('Z', '+00:00')).timestamp()


def attribute(snapshot):
    names = ['process-lifetime.jsonl', 'actions.log', 'newgame-observations.json',
             'intro-observation-budget.json']
    raw = {name: (snapshot/name).read_bytes() for name in names}
    events = [json.loads(line) for line in raw[names[0]].splitlines()]
    actions = [line.decode().split(' OK ', 1) for line in raw[names[1]].splitlines()]
    observations = json.loads(raw[names[2]])
    budget = json.loads(raw[names[3]])
    commands = []
    for event in events:
        if event['boundary'] == 'before-command':
            commands.append([event])
        elif event['boundary'] in ['await-ack', 'transport-returned', 'transport-reaped']:
            assert commands and commands[-1][0]['command'] == event['command']
            assert commands[-1][-1]['boundary'] != 'transport-reaped'
            commands[-1].append(event)
    assert len(commands) == len(actions)
    assert all(a['monotonic'] <= b['monotonic'] for a, b in zip(events, events[1:]))
    rows = []
    for command_events, (ack_utc, value) in zip(commands, actions):
        before, reaped = command_events[0], command_events[-1]
        assert value == before['command'] and reaped['boundary'] == 'transport-reaped'
        assert reaped['transportPid'] > 0
        returned = [e for e in command_events if e['boundary'] == 'transport-returned']
        assert len(returned) <= 1
        assert all(e.get('transportPid', reaped['transportPid']) == reaped['transportPid'] for e in command_events)
        ack = utc(ack_utc)
        assert utc(before['utc']) <= ack <= utc(reaped['utc'])
        rows.append(dict(command=value, start=before['monotonic'], end=reaped['monotonic'],
            beforeToReaped=reaped['monotonic']-before['monotonic'],
            beforeToAckUtc=ack-utc(before['utc']), ackToReapedUtc=utc(reaped['utc'])-ack,
            returnedToReaped=(reaped['monotonic']-returned[0]['monotonic']) if returned else None,
            awaitSamples=sum(e['boundary']=='await-ack' for e in command_events)))
    groups = defaultdict(list)
    for row in rows:
        groups[row['command'].split()[0]].append(row)
    def aggregate(items):
        return dict(commands=len(items), **{key: round(sum(r[key] or 0 for r in items), 6)
                    for key in ['beforeToReaped','beforeToAckUtc','ackToReapedUtc','returnedToReaped','awaitSamples']})
    gaps = [dict(after=a['command'], before=b['command'], start=a['end'], end=b['start'],
                 seconds=b['start']-a['end']) for a,b in zip(rows, rows[1:])]
    dumps = [r for r in rows if r['command']=='dump-intro']
    assert len(dumps) == len(observations)
    # Each observation is persisted after its corresponding passive-focus
    # command/native bracket. The native bracket's scalar file is intentionally
    # outside this assignment. Its duration cannot be recovered from these gaps.
    dialogue_index = next(i for i,o in enumerate(observations) if o['budget']['stage']=='dialogue')
    first_dialogue = dumps[dialogue_index]
    dialogue_rows = [r for r in rows if r['start'] >= first_dialogue['start']]
    first, last = observations[0], observations[-1]
    return dict(schemaVersion=1, snapshot=str(snapshot),
        inputs={name: dict(bytes=len(data), sha256=hashlib.sha256(data).hexdigest()) for name,data in raw.items()},
        commandSpanSeconds=rows[-1]['end']-rows[0]['start'],
        allCommands=aggregate(rows), byCommand={k:aggregate(v) for k,v in sorted(groups.items())},
        betweenCommandSeconds=sum(g['seconds'] for g in gaps),
        dialogueSampleWindow=dict(note='Starts before first dialogue dump, not at exact stage transition; last command has no returned sample.',
                                  firstDumpStart=first_dialogue['start'], lastReaped=rows[-1]['end'],
                                  aggregates=aggregate(dialogue_rows)),
        sourceObservations=dict(count=len(observations), dialogueCount=len(observations)-dialogue_index,
            firstFrame=first['frame'], lastFrame=last['frame'],
            hostElapsedDelta=last['elapsed']-first['elapsed'],
            unityRealtimeDelta=last['realtime']-first['realtime'],
            unityScaledTimeDelta=last['scaledTime']-first['scaledTime'],
            finalSource=[last['conversationId'],last['entryId']], finalBudget=budget),
        longestCommandIntervals=sorted(rows, key=lambda r:r['beforeToReaped'], reverse=True)[:4],
        longestBetweenCommandIntervals=sorted(gaps, key=lambda g:g['seconds'], reverse=True)[:4],
        limits=[
            'beforeToReaped excludes the initial process scan, includes final scan, helper waits, file/Python work and game ACK latency.',
            'ACK uses Unity UTC and host UTC, not a measured synchronized monotonic clock; negative brackets are rejected.',
            'ackToReaped includes helper completion/output decoding and host work; it is not pure process-scan or disk time.',
            'returnedToReaped encloses a repeated unguarded ps/file log boundary after communicate already reaped a successful child. It is not an estimate of saved seconds.',
            'betweenCommand includes the next initial process scan, focus/native observation, bookkeeping, original sleeps and scheduling; no component can be isolated from these four files.',
            'Unity realtime/scaled deltas and frame counts overlap host intervals; they neither measure pure source waiting nor explain unsampled stalls.',
            'The final helper exit instant relative to the old deadline remains unknown; no missing transport-returned event is fabricated.',
        ])


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('snapshot', type=Path)
    args = parser.parse_args()
    print(json.dumps(attribute(args.snapshot), indent=2))
