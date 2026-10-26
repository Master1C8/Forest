"""Reproduce source topology and bounded roommate-concept dependencies; no wording generation."""
import hashlib
import json
from collections import deque
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
EVIDENCE = HERE / 'hold-evidence-0033'

def sha(raw): return hashlib.sha256(raw).hexdigest()
def fields(entry): return {f['title']: f['value'] for f in entry['fields']}
def write(name, data):
    (EVIDENCE / name).write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n')

def main():
    EVIDENCE.mkdir(exist_ok=True)
    manifest = json.loads((ROOT/'localization/source/dialogue-manifest.json').read_text())
    trees = []
    for source in manifest['sources']:
        raw = (ROOT/source['tree']).read_bytes()
        assert sha(raw) == source['treeSha256']
        trees.append(json.loads(raw))
    assert trees[0]['conversations'] == trees[1]['conversations']
    tree = trees[0]
    nodes = {(c['id'], e['id']): e for c in tree['conversations'] for e in c['dialogueEntries']}
    assert len(nodes) == sum(len(c['dialogueEntries']) for c in tree['conversations'])
    incoming = {n: [] for n in nodes}
    edges = {n: [] for n in nodes}
    roots = []
    for c in tree['conversations']:
        for index, e in enumerate(c['dialogueEntries']):
            key = (c['id'], e['id']); f = fields(e)
            if index == 0 or f.get('Title') or f.get('TfolUniqueDataKeySuffix'):
                roots.append(key)
            for link in e['outgoingLinks']:
                dest = (link['destinationConversationID'], link['destinationDialogueID'])
                if dest in nodes:
                    edges[key].append(dest); incoming[dest].append(key)
    # Deliberately overapproximate actual loader: every titled/keyed/first node,
    # every branch condition allowed, including cross-conversation links.
    paths = {key: [key] for key in roots}; queue = deque(roots)
    while queue:
        key = queue.popleft()
        for dest in edges[key]:
            if dest not in paths:
                paths[dest] = paths[key] + [dest]; queue.append(dest)
    wanted = [(131,153),(540,232),(71,147),(458,340),(458,346)]
    records = []
    for key in wanted:
        entry = nodes[key]; f = fields(entry)
        records.append({'id': f'ds:{key[0]}:{key[1]}:Dialogue Text',
                        'sourceSha256': sha(f['Dialogue Text'].encode()),
                        'fields': f, 'entry': entry, 'incoming': incoming[key],
                        'pathFromOverapproximateRoot': paths.get(key),
                        'rootCount': len(roots), 'allConditionsAllowed': True})
    write('source-topology.json', {'sourceTrees': manifest['sources'], 'records': records,
          'limits': 'Static topology and copied original IL only. No proof against arbitrary external direct-node calls; runtime unrun.'})
    rows = [json.loads(line) for line in (ROOT/'localization/source/dialogue-candidates.jsonl').read_text().splitlines()]
    # Explicit concept families plus every linked branch in their containing scenes.
    # Do not select every line spoken by/naming these characters.
    rx = re.compile(r'room.?mates?|rooming|mov\w* (?:back )?in|liv\w* (?:together|with)|Finley[’\x27]s (?:stuff|things|belongings)|former (?:house|flat)', re.I)
    seeds = {r['id'] for r in rows if rx.search(r['source']) and
             (r['conversation'].startswith(('gossip/ram/','act3/finleyQuest/','gossip/bear/roomingFinley')) or r['conversationId'] == 422)}
    scene_ids = {r['conversationId'] for r in rows if r['id'] in seeds}
    selected = [r for r in rows if r['conversationId'] in scene_ids]
    overlay = {r['id']: r for r in map(json.loads, (HERE/'dialogue.es.jsonl').read_text().splitlines())}
    write('roommate-dependencies.json', {'selector': {'regex': rx.pattern, 'flags': 'IGNORECASE',
          'families': ['gossip/ram/', 'act3/finleyQuest/', 'gossip/bear/roomingFinley'],
          'additionalScene': 422, 'closure': 'all candidate fields in source conversations containing those concept seeds'},
          'sourceCandidateSha256': sha((ROOT/'localization/source/dialogue-candidates.jsonl').read_bytes()),
          'conceptSeedIds': [r['id'] for r in rows if r['id'] in seeds],
          'conversationIds': sorted(scene_ids), 'closureIds': [r['id'] for r in selected],
          'rows': [{'id': r['id'], 'source': r['source'], 'sourceSha256': sha(r['source'].encode()),
                    'target': overlay.get(r['id'],{}).get('target'), 'pointer': r['pointer'],
                    'entry': nodes[(r['conversationId'], int(r['id'].split(':')[2]))]} for r in selected],
          'status': 'Reproducible affected-use/context inventory; not a full semantic or independent audit.'})
    print(json.dumps({'topologyRecords': len(records), 'conceptSeeds': len(seeds), 'dependencyCandidates': len(selected), 'conversations': sorted(scene_ids)}))

if __name__ == '__main__': main()
