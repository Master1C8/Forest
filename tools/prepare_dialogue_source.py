#!/usr/bin/env python3
"""Prepare lossless dialogue candidates; this does not accept the full game source.

Every noncandidate tree value remains protected by the complete original tree.
The manifest explicitly lists the only candidate pointers; an eventual reinserter
must compare every other value exactly. Mixed inline syntax is still unclassified.
"""
import argparse
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TREES = ROOT / 'assets/source-v2/trees'
COPIES = [
    ('sharedassets0.assets:3336', TREES / '57009919ee-sharedassets0.assets-3336.json'),
    ('StreamingAssets/aa/StandaloneWindows64/defaultlocalgroup_assets_all_298c5a4d1d1846b1a8d2c7d5da3f319c.bundle!/CAB-7cd732d37ea0297d073a22a52ce72d28:-9011735310751668748',
     TREES / 'c1a187d8bb-CAB-7cd732d37ea0297d073a22a52ce72d28--9011735310751668748.json'),
]


def encoded(value):
    return (json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(',', ':')) + '\n').encode()


def fields(record):
    pairs = [(f['title'], f['value']) for f in record['fields']]
    assert len(dict(pairs)) == len(pairs), 'Duplicate field titles'
    return dict(pairs)


def prepare():
    trees = [json.loads(path.read_text()) for _, path in COPIES]
    assert trees[0]['conversations'] == trees[1]['conversations'], 'Dialogue copies differ'
    rows, entries, conversations = [], set(), set()
    protected_views = []
    for ci, conversation in enumerate(trees[0]['conversations']):
        cid = conversation['id']
        assert cid not in conversations, 'Duplicate conversation ID'
        conversations.add(cid)
        title = fields(conversation).get('Title', '')
        for ei, entry in enumerate(conversation['dialogueEntries']):
            eid = entry['id']
            assert (cid, eid) not in entries, 'Duplicate dialogue identity'
            entries.add((cid, eid))
            context = fields(entry)
            for fi, field in enumerate(entry['fields']):
                if field['title'] not in ('Dialogue Text', 'Menu Text') or not field['value']:
                    continue
                pointer = f'/conversations/{ci}/dialogueEntries/{ei}/fields/{fi}/value'
                rows.append({'id': f'ds:{cid}:{eid}:{field["title"]}',
                             'conversationId': cid, 'entryId': eid, 'conversation': title,
                             'field': field['title'], 'source': field['value'],
                             'actorId': context.get('Actor'), 'conversantId': context.get('Conversant'),
                             'pointer': pointer, 'occurrences': [key + pointer for key, _ in COPIES],
                             'classification': 'display-candidate; inline grammar and reachability pending'})
    assert len({row['id'] for row in rows}) == len(rows)
    # Removing only candidate values makes a reproducible complete protection
    # boundary, including links, scripts, sequence fields, IDs and object refs.
    for tree in trees:
        for row in rows:
            tokens = row['pointer'].strip('/').split('/')
            obj = tree
            for token in tokens[:-1]:
                obj = obj[int(token)] if isinstance(obj, list) else obj[token]
            assert obj[tokens[-1]] == row['source']
            obj[tokens[-1]] = {'candidateId': row['id']}
        protected_views.append(hashlib.sha256(encoded(tree)).hexdigest())
    corpus = b''.join(encoded(row) for row in rows)
    manifest = {'schemaVersion': 1, 'build': '0.45', 'sourceLocale': 'en',
                'sourceAcceptance': 'needs-review', 'fullVisibleDenominator': None,
                'scope': 'Only Dialogue Text/Menu Text candidates from both exact dialogue database copies',
                'conversations': len(conversations), 'entries': len(entries),
                'candidateUnits': len(rows), 'physicalOccurrences': len(rows) * len(COPIES),
                'corpusSha256': hashlib.sha256(corpus).hexdigest(),
                'sources': [{'object': key, 'tree': str(path.relative_to(ROOT)),
                             'treeSha256': hashlib.sha256(path.read_bytes()).hexdigest(),
                             'allNoncandidateValuesSha256': digest}
                            for (key, path), digest in zip(COPIES, protected_views)],
                'pending': ['Inline control grammar/preserve-exactly spans',
                            'Complete BGDatabase/UI/C# literal/image inventory and consumers',
                            'Unresolved metadata and full special-scene semantic discovery'],
                'scriptSha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
    return {'dialogue-candidates.jsonl': corpus, 'dialogue-manifest.json': encoded(manifest)}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=ROOT / 'localization/source')
    args = parser.parse_args()
    output = args.output.resolve()
    assert ROOT in output.parents
    files = prepare()
    output.mkdir(parents=True, exist_ok=True)
    # Precheck every existing output before any writes. Individual file writes
    # are not a transaction; a partial creation is resumable by exact equality.
    for name, value in files.items():
        path = output / name
        assert not path.exists() or path.read_bytes() == value, f'Changed existing output: {path}'
    for name, value in files.items():
        path = output / name
        if not path.exists():
            path.write_bytes(value)
        assert path.read_bytes() == value
    print(json.dumps(json.loads(files['dialogue-manifest.json']), indent=2))


if __name__ == '__main__':
    main()
