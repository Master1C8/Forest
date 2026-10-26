#!/usr/bin/env python3
"""Project the pinned original Bucky graph; no model, game or frozen-input edits."""
import argparse
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'localization/source/tutorial-20261026/phase0058/original/conversation141.json'
SOURCE_SHA = '7cd3173110e9498ada7669cb07f1edf6ab949abef76d791c1e07c7e96da0e10b'
ROUTE = list(range(194, 213))
IDS = [215, 216, 217, *ROUTE, 218, 192, 225, 235]


def plan():
    assert hashlib.sha256(SOURCE.read_bytes()).hexdigest() == SOURCE_SHA, 'Original141 source changed'
    source = json.loads(SOURCE.read_text())
    entries = []
    for eid in IDS:
        e, = [e for e in source['conversation']['dialogueEntries'] if e['id'] == eid]
        f = {f['title']: f['value'] for f in e['fields']}
        assert len(f) == len(e['fields'])
        entries.append(dict(id=eid, title=f['Title'], text=f['Dialogue Text'], actor=int(f['Actor']),
            conversant=int(f['Conversant']), menuText=f['Menu Text'], sequence=f['Sequence'],
            responseMenuSequence=f['Response Menu Sequence'], conditions=e['conditionsString'],
            script=e['userScript'], isGroup=e['isGroup'], onExecute=e['onExecute'], outgoingLinks=e['outgoingLinks']))
    return dict(conversation=141, dbName='TutorialQuest_BeaverIntroduction', arc='p1',
        sourceSha256=SOURCE_SHA, first=215, selected=217, declined=216, successor=194, route=ROUTE,
        entries=entries, boundary='Original source/controls only; marker218 is not the loaded first subtitle. '
        'Selection is not194 coverage; seeing212 is not its line-end or notebook completion.')


def graph_calls(value):
    """Exact C# literals, checked again against the full plan by host tests."""
    rows = []
    for e in value['entries']:
        targets = ','.join(str(link['destinationDialogueID']) for link in e['outgoingLinks'])
        rows.append('        Bucky141Entry(%s,%s,%s,%s,%s,%s,new int[]{%s});' % (
            e['id'], json.dumps(e['title'], ensure_ascii=False), json.dumps(e['text'], ensure_ascii=False),
            e['actor'], e['conversant'], json.dumps(e['sequence']), targets))
    return '\n'.join(rows) + '\n'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    out = parser.parse_args().output.resolve()
    assert ROOT / 'localization/source/tutorial-20261026' in out.parents and not out.exists()
    value = plan()
    out.mkdir()
    (out/'bucky141-plan.json').write_text(json.dumps(value, ensure_ascii=False, indent=2)+'\n')
    (out/'graph-calls.cs.txt').write_text(graph_calls(value))


if __name__ == '__main__':
    main()
