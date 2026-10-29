#!/usr/bin/env python3
"""Decode the complete read-only native TSV; do not admit callback execution."""
import argparse
import base64
import hashlib
import json
from pathlib import Path

NAMES = ('onShowItemGetAchievement', 'onShowItemGetAchievementOverloadedForAdventures')


def decode(text):
    return base64.b64decode(text, validate=True).decode('utf-8')


def parse(text):
    lines = text.splitlines()
    assert lines and lines.pop(0) == 'format\t1', 'roster-format-required;missing-fields-are-not-zero'
    scene = lines.pop(0).split('\t')
    assert len(scene) == 2 and scene[0] == 'scene', 'scene-record'
    events = {}
    for line in lines:
        f = line.split('\t')
        assert f[1] in NAMES, 'unexpected-event'
        if f[0] == 'event':
            assert len(f) == 5 and f[1] not in events, 'unique-complete-event-record'
            counts = list(map(int, f[2:]))
            assert all(n >= 0 for n in counts), 'negative-call-count'
            events[f[1]] = dict(name=f[1], persistentCount=counts[0], runtimeInvokables=counts[1], persistentInvokables=counts[2], listeners=[])
        else:
            assert f[0] == 'listener' and len(f) == 9 and f[1] in events, 'complete-listener-record'
            index = int(f[2])
            event = events[f[1]]
            assert 0 <= index < event['runtimeInvokables'] and f[8] in ('0', '1'), 'listener-index-or-scene-flag'
            names = ('declaringType', 'method', 'targetType', 'targetPath')
            listener = dict(zip(names, map(decode, f[3:7])))
            listener.update(invokableIndex=index, targetInstance=int(f[7]), targetInScene=f[8] == '1')
            assert listener not in event['listeners'], 'duplicate-listener-record'
            event['listeners'].append(listener)
    assert tuple(events) == NAMES, 'complete-two-event-inventory'
    for event in events.values():
        assert {r['invokableIndex'] for r in event['listeners']} == set(range(event['runtimeInvokables'])), 'missing-runtime-invokable'
    return dict(scene=decode(scene[1]), events=list(events.values()))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert not args.output.exists(), 'Preserve prior roster receipts'
    raw = args.source.read_bytes()
    result = parse(raw.decode('utf-8-sig'))
    result.update(status='complete-readonly-runtime-roster;execution-not-admitted',
                  source=str(args.source.resolve()), sourceSha256=hashlib.sha256(raw).hexdigest(),
                  sourceGateAccepted=False, wholeGameAccepted=False,
                  boundary='Actual native call-list membership only. No callback invocation, transitive effect or restoration acceptance.')
    args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps({'events': len(result['events']), 'runtimeInvokables': [r['runtimeInvokables'] for r in result['events']]}))


if __name__ == '__main__':
    main()
