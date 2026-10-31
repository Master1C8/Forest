"""Prepare exact unaccepted dialogue versions and bounded source context; no judgments."""
import argparse
import collections
import hashlib
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[4]
sys.path.insert(0, str(ROOT / 'tools'))
import locale_progress as progress
from locale_progress_evidence import baseline


def dump(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open('x') as stream:
        json.dump(value, stream, ensure_ascii=False, indent=2)
        stream.write('\n')


def rows(path, values):
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open('x') as stream:
        for value in values:
            stream.write(json.dumps(value, ensure_ascii=False, separators=(',', ':')) + '\n')


def fields(value):
    # Keep ordered duplicate titles and exact nonempty values. Empty editor fields
    # and graphical canvas positions do not provide dialogue semantic context.
    return [[f['title'], f['value']] for f in value['fields'] if f['value'] != '']


def entry(value):
    return dict(id=value['id'], fields=fields(value), **{k: value[k] for k in
        ['conversationID', 'isRoot', 'isGroup', 'outgoingLinks', 'conditionsString',
         'userScript', 'onExecute', 'falseConditionAction', 'conditionPriority']})


def neighborhood(conversation, assigned):
    entries = conversation['dialogueEntries']
    by_id = {e['id']: e for e in entries}
    if len(by_id) != len(entries) or not assigned <= set(by_id):
        raise ValueError('Ambiguous or missing source entry')
    links = collections.defaultdict(set)
    for e in entries:
        for link in e['outgoingLinks']:
            if link['destinationConversationID'] == conversation['id']:
                a, b = e['id'], link['destinationDialogueID']
                if b not in by_id:
                    raise ValueError('Broken in-conversation source link')
                links[a].add(b); links[b].add(a)
    chosen = set(assigned)
    for _ in range(2):
        chosen |= {b for a in chosen for b in links[a]}
    # Include adjacent source nodes too: narrative descriptions may be unlinked.
    for index, e in enumerate(entries):
        if e['id'] in assigned:
            chosen.update(v['id'] for v in entries[max(0, index-2):index+3])
    return [entry(e) for e in entries if e['id'] in chosen]


def prepare(root, locale, output, limit=120, context_limit=260000):
    root, output = root.resolve(), output.resolve()
    if not output.is_relative_to(root) or output.exists():
        raise ValueError('New project-owned output required; reconcile existing publication')
    if locale not in progress.LOCALES or limit < 1 or context_limit < 1:
        raise ValueError('Explicit supported locale and positive batch limits required')
    ev = progress.Evidence(root); policy = ev.json(progress.POLICY)
    _, preservation = baseline(ev, policy)
    families = {f['id']: progress.expected_ids(ev, f) for f in policy['families']}
    measured = progress.collect_locale(ev, policy, locale, families, preservation)
    corpus = ev.row_list(f'localization/{locale}-assets/dialogue.{locale}.jsonl')
    accepted = measured['_acceptedVersions']
    pending = [r for r in corpus if accepted.get(r['id']) != progress.version(r)]
    if ev.errors:
        raise ValueError('Unreconciled progress evidence: ' + repr(ev.errors[:3]))
    if not pending:
        raise ValueError('No current unaccepted dialogue versions')
    source_manifest = ev.json('localization/source/dialogue-manifest.json')
    source = source_manifest['sources'][0]
    tree = ev.json(source['tree'], source['treeSha256'])
    grouped = collections.OrderedDict()
    for row in pending:
        ci, ei, fi = [int(row['pointer'].split('/')[i]) for i in [2, 4, 6]]
        conversation = tree['conversations'][ci]
        original = conversation['dialogueEntries'][ei]
        if (conversation['id'] != row['conversationId'] or original['id'] != row['entryId']
                or original['fields'][fi]['value'] != row['source']):
            raise ValueError('Source pointer/version mismatch: ' + row['id'])
        grouped.setdefault(ci, []).append(row)
    prior = collections.defaultdict(list)
    for row in [*progress.initial_reviews(ev, locale), *progress.retained_reviews(ev, locale)]:
        if any(row.get('id') == p['id'] for p in pending):
            prior[row['id']].append(row)
    if ev.errors:
        raise ValueError('Unreconciled editorial evidence')
    ev.stable()
    output.mkdir(parents=True)
    rows(output/'frontier.jsonl', pending)
    scenes = {}; contexts = {}
    for ci, primary in grouped.items():
        c = tree['conversations'][ci]; cid = c['id']
        scene = output/'scenes'/f'{cid}.json'
        dump(scene, dict(id=cid, fields=fields(c), entries=[entry(e) for e in c['dialogueEntries']]))
        scenes[cid] = str(scene.relative_to(root))
        actor_ids = {str(v) for r in primary for v in [r.get('actorId'), r.get('conversantId')]}
        contexts[ci] = dict(id=f'source-context:{cid}', conversationId=cid,
            fields=fields(c), primaryEntryIds=sorted({r['entryId'] for r in primary}),
            entries=neighborhood(c, {r['entryId'] for r in primary}),
            actors=[dict(id=a['id'], fields=fields(a)) for a in tree['actors'] if str(a['id']) in actor_ids],
            fullSourceScene=scenes[cid], rawSourceTree=source['tree'],
            boundary='Source context only. Two link hops plus adjacent nodes are an index, not a semantic sufficiency claim. Open the full scene and exact linked scenes whenever required; unresolved context never passes.')
    batches = []; current = []; selected_context = []; size = 0
    def publish():
        nonlocal current, selected_context, size
        if not current:
            return
        directory = output/f'batch-{len(batches)+1:02d}'
        rows(directory/'review-packet.jsonl', current)
        rows(directory/'source-context.jsonl', selected_context)
        risks = [dict(id=r['id'], priorJudgments=prior.get(r['id'], [])) for r in current if prior.get(r['id'])]
        rows(directory/'prior-judgments.jsonl', risks)
        batches.append(dict(directory=str(directory.relative_to(root)), ids=[r['id'] for r in current],
            primary=len(current), contextBytes=size))
        current, selected_context, size = [], [], 0
    for ci, primary in grouped.items():
        context = contexts[ci]; count = len(json.dumps(context, ensure_ascii=False).encode())
        if current and (len(current)+len(primary) > limit or size+count > context_limit):
            publish()
        current.extend(primary); selected_context.append(context); size += count
    publish()
    flat = [ident for b in batches for ident in b['ids']]
    if len(flat) != len(set(flat)) or set(flat) != {r['id'] for r in pending}:
        raise ValueError('Batch partition lost or duplicated a primary version')
    pins = [dict(path=str(p.relative_to(root)), sha256=hashlib.sha256(p.read_bytes()).hexdigest())
        for p in output.rglob('*') if p.is_file()]
    result = dict(schemaVersion=1, locale=locale, frontier=len(pending), batches=batches,
        acceptedVersionCount=len(accepted), inputPins=ev.pins, files=pins,
        semanticAcceptance=False, remaining='Every frontier version stays unaccepted until actual version-matching judgment; prior matching passes outside this set are retained.')
    dump(output/'manifest.json', result)
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--locale', required=True)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    result = prepare(ROOT, args.locale, args.output)
    print(json.dumps(dict(frontier=result['frontier'], batches=[dict(primary=b['primary'], contextBytes=b['contextBytes']) for b in result['batches']], semanticAcceptance=False)))
