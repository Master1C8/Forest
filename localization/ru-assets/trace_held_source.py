"""Reproduce bounded source topology evidence; no translated wording generation."""
import collections
import hashlib
import json
import pathlib

ROOT = pathlib.Path(__file__).resolve().parents[2]
HERE = pathlib.Path(__file__).resolve().parent


def sha(raw):
    return hashlib.sha256(raw).hexdigest()


def trace(ids):
    manifest_raw = (ROOT/'localization/source/dialogue-manifest.json').read_bytes()
    manifest = json.loads(manifest_raw)
    trees = []
    for source in manifest['sources']:
        raw = (ROOT/source['tree']).read_bytes()
        assert sha(raw) == source['treeSha256'], 'Tree fingerprint changed'
        trees.append(json.loads(raw))
    assert trees[0]['conversations'] == trees[1]['conversations']
    tree = trees[0]
    entries = {(c['id'], e['id']): e for c in tree['conversations'] for e in c['dialogueEntries']}
    fields = {k: {f['title']: f['value'] for f in e['fields']} for k, e in entries.items()}
    incoming = collections.defaultdict(list)
    for key, e in entries.items():
        for link in e['outgoingLinks']:
            incoming[(link['destinationConversationID'], link['destinationDialogueID'])].append(key)
    # Overapproximation: EVERY titled/keyed node and EVERY conversation's first
    # node, not just the recognized PRIMARY/SECONDARY/IDLE/NAMED roots. Ignore
    # conditions and follow cross-conversation links too. This cannot prove an
    # arbitrary external runtime call never selects an orphan; retain that limit.
    roots = {k for k, f in fields.items() if f.get('Title') or f.get('TfolUniqueDataKeySuffix')}
    roots.update((c['id'], c['dialogueEntries'][0]['id']) for c in tree['conversations'] if c['dialogueEntries'])
    parents = {key: None for key in sorted(roots)}
    queue = collections.deque(parents)
    while queue:
        key = queue.popleft()
        for link in entries[key]['outgoingLinks']:
            child = (link['destinationConversationID'], link['destinationDialogueID'])
            assert child in entries, 'Unresolved dialogue link'
            if child not in parents:
                parents[child] = key
                queue.append(child)
    rows = {r['id']: r for r in map(json.loads, (ROOT/'localization/source/dialogue-candidates.jsonl').read_text().splitlines())}
    result = []
    for ident in ids:
        r = rows[ident]
        key = (r['conversationId'], r['entryId'])
        e = entries[key]
        path = []
        if key in parents:
            cursor = key
            while cursor is not None:
                path.append(list(cursor))
                cursor = parents[cursor]
            path.reverse()
        result.append({'id': ident, 'source': r['source'], 'sourceSha256': sha(r['source'].encode()),
                       'pointer': r['pointer'], 'occurrences': r['occurrences'],
                       'entry': e, 'incoming': incoming[key],
                       'conservativeRootPath': path, 'reachableFromConservativeRoots': key in parents})
    return {'scope': 'Bounded own-lane static disposition proposal; original inventory/denominator unchanged',
            'manifestSha256': sha(manifest_raw), 'sourceTrees': manifest['sources'],
            'recipeSha256': sha(pathlib.Path(__file__).read_bytes()), 'records': result,
            'limits': 'All conditions treated as satisfiable. No runtime launch or claim about arbitrary external direct-node calls, reflection or serialized callbacks. Detached source is preserved, never deleted. Shared integration pending.'}


if __name__ == '__main__':
    selection = json.loads((HERE/'consumer-evidence-0024/selected-ids.json').read_text())
    result = trace(selection)
    (HERE/'consumer-evidence-0024/source-topology.json').write_text(json.dumps(result, ensure_ascii=False, indent=2)+'\n')
    print(json.dumps({'records': len(result['records']),
                      'reachable': sum(r['reachableFromConservativeRoots'] for r in result['records']),
                      'detached': sum(not r['reachableFromConservativeRoots'] for r in result['records'])}))
