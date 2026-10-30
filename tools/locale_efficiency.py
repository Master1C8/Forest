"""Lossless review views and compact runtime/usage checks. Never writes wording."""
import argparse
import collections
import hashlib
import json
from pathlib import Path

from cli_job_support import validate_model
from locale_queue import sha, read, local

REF = '$r'
POLICY = '''# Efficient continuous execution

Read mandatory instructions and the complete compact approved glossary once per
fresh context. Do not reread them within that context unless they changed.
Use the supplied frozen efficiency helper for runtime/pin/usage checks. Do not
dump raw session logs, all pin rows, full regression reports or unrelated history.
Print counts, hashes and failing records; expand only concrete discrepancies.

Lossless views are exact indexes, not mandatory reading lists of every metadata
field. Read every assigned source/target, full relevant assembled output and all
required source/scene/glossary context. Resolve view references used by that
reading. Mechanical hash lists, origin arrays, preserved raw properties and
unchanged metadata are checked by code; do not reread them all in the model.
Original complete evidence stays available for concrete ambiguity. No sampling,
missing semantic context, default passes or automatic semantic judgments.
When inspect supplies readingView, use its readingPages instead of dumping the
lossless archive pages or original packets as well. This view omits only top-level
SHA-256 fields and original-packet provenance; all wording, IDs, context, flags,
unknown fields and nested objects remain exact. The complete lossless archive
retains every omitted value. Open that archive only for a concrete discrepancy.

Use the frozen locale_review_work.py prepare-scope command when preparing a new
wording review. Give the complete authored candidate file and original packet.
The new review comprises those exact primary versions plus explicitly caused
invalidations with evidence. Unchanged neighboring dialogue is SOURCE context;
do not automatically give it another full target-language audit. Include actual
joined outputs, changed terminology/referents and other real dependencies. Unknown
dependency bounds require a broader explicit scope. Keep scope.json and use its
review-packet.jsonl plus source-context.jsonl in the next task. A full semantic
audit's genuinely unreviewed IDs remain mandatory; this is not a shortcut for them.

For review output, write only newly judged primary IDs, verdicts and actual brief
rationales, then use locale_review_work.py finish-review. It attaches hashes,
writes the pending ledger and publishes the normal result. Missing rows remain
unread, never pass. Keep context notes separate; declared matching context rows
never increase primary/linguistic coverage. Do not write a new publication script
or copy whole inherited receipts into every output row.

Batch a complete finite family or normally100–300 primary units per author/review
context, subject to actual required context volume. Do not default to three
descriptions per context. Small exact repair deltas and true family tails remain
valid. Collect findings before one repair, then independent exact-delta review.
Unchanged held/context-only units retain version-matching receipts. They are not
new linguistic coverage. Preserve every source/editorial/font/runtime gate.
An unread row normally has reviewed:false and needs-review. It may retain an
exact prior non-pass verdict only with pendingSemanticReview:true,
inheritedVerdictUnchanged:true and inheritedNonPassEvidence.original binding its
id/sourceSha256/targetSha256/verdict. Such rows still count as unread and must
carry forward; no inherited pass/clean or completed coverage is permitted.

Mechanical checks use one reproducible command and compact output. Reuse verified
recipes and unchanged deterministic results by fingerprint; do not create another
validator, publisher, manifest hierarchy or fault-injection suite without a named
unmet deliverable requiring it. A routine evidence publication is not its own
model assignment. Apply shared parameterized procedures directly in each locale.
Review finite shared resource contracts together across the authorized locales
when their actual combined input fits; do not create six processes for two cells
each. Keep author and independent reviewer distinct fresh contexts.

Locale jobs own wording, editing, semantic review and direct local resource
application through shared accepted-Russian procedures and explicit locale data.
There is no permanent technical stream or inbox dependency. The coordinator
repairs a named shared defect once; locale jobs reuse that implementation.
Use tools/locale_build.py for exact saved candidate materialization/checks without
a paid metadata phase. Keep target review, font, native and runtime gates separate.
Do not manufacture author/reviewer exchanges for mechanical wrapping, manifests
or unchanged evidence. A concrete missing adapter, source decision or native
authorization is a precise blocker, never a wait for a retired worker. Preserve
historical handoffs, frozen code, packets and interrupted drafts.

Use the compact usage command at substantive checkpoints. Size work by actual
text and required context, not cumulative cached replays or report-writing volume.
Checkpoint before real context exhaustion, carrying exact unread versions and
context; do not stop after two objects merely because a generic output counter
crossed a threshold. No total token budget was assigned. Never auto-kill or retry
an unknown request to enforce an invented limit.

Return the established result.json schema. Supply nextTask.reviewPacket explicitly
for each review. Use nextTask.contextPackets for other required JSONL context so
the supervisor can deduplicate exact repeated structures. Carry unread IDs and
versions. Next work must advance a named outstanding game deliverable; exhausted
independent static work records its actual blocker instead of an unchanged loop.
'''


def canonical(value):
    return json.dumps(value, ensure_ascii=False, separators=(',', ':'), sort_keys=True)


def unique_object(items):
    result = {}
    for key, value in items:
        if key in result or key == REF:
            raise ValueError('Duplicate or reserved input object key')
        result[key] = value
    return result


def load_rows(path):
    return [json.loads(line, object_pairs_hook=unique_object)
            for line in path.read_text().splitlines() if line.strip()]


def _intern_pages(root, originals, directory, prefix):
    """Encode one representation; each page set has its own reference namespace."""
    counts = collections.Counter()
    values = {}

    def key(value):
        if isinstance(value, (dict, list)) or isinstance(value, str) and len(value) >= 64:
            encoded = canonical(value)
            if len(encoded) >= (64 if isinstance(value,str) else 256):
                digest = hashlib.sha256(encoded.encode()).hexdigest()
                counts[digest] += 1
                values[digest] = value
        if isinstance(value, dict):
            for item in value.values():key(item)
        elif isinstance(value, list):
            for item in value:key(item)

    for _, rows in originals:
        for row in rows:key(row)
    selected = {digest for digest, n in counts.items()
                if n > 1 or isinstance(values[digest],(dict,list)) and len(canonical(values[digest]))>4000}
    names = {digest:'D'+str(i+1) for i,digest in enumerate(sorted(selected))}
    definitions = {}

    def encode(value, defining=None):
        digest = hashlib.sha256(canonical(value).encode()).hexdigest() if isinstance(value, (dict, list, str)) else None
        if digest in selected and digest != defining:
            name = names[digest]
            if name not in definitions:definitions[name] = encode(value, digest)
            return {REF:name}
        if isinstance(value, dict):return {k:encode(v) for k,v in value.items()}
        if isinstance(value, list):return [encode(v) for v in value]
        return value

    encoded = [dict(path=str(p.relative_to(root)), rows=[encode(row) for row in rows]) for p,rows in originals]

    def decode(value):
        if isinstance(value, dict):
            if set(value) == {REF}:return decode(definitions[value[REF]])
            return {k:decode(v) for k,v in value.items()}
        if isinstance(value, list):return [decode(v) for v in value]
        return value

    for item, (_, original) in zip(encoded, originals):
        if canonical(decode(item['rows'])) != canonical(original):
            raise ValueError('Lossless view roundtrip failed')
    entries = [dict(definition=k, value=v) for k,v in definitions.items()]
    entries += [dict(packet=packet_index, rowIndex=i, value=row)
                for packet_index,item in enumerate(encoded) for i,row in enumerate(item['rows'])]
    pages = []; lines = []; size = 0

    def publish():
        nonlocal lines,size
        if not lines:return
        path = directory/f'{prefix}-{len(pages)+1:04d}.jsonl'
        path.write_text(''.join(lines))
        pages.append(dict(path=str(path.relative_to(root)), sha256=sha(path), bytes=path.stat().st_size))
        lines = [];size = 0

    for entry in entries:
        line = canonical(entry)+'\n';line_bytes=len(line.encode())
        if size+line_bytes>16000:publish()
        lines.append(line);size+=line_bytes
    publish()
    return dict(viewBytes=sum(p['bytes'] for p in pages), definitions=len(definitions), pages=pages, roundtrip=True)


def reading_row(row):
    """Keep all semantic/unknown/nested data; separate only known row provenance.

    This is a presentation projection, never a review decision or coverage receipt.
    Unexpected types and non-digest values stay visible rather than being hidden.
    """
    if not isinstance(row, dict):
        return row
    digests = {'sourceSha256', 'targetSha256', 'originalRowSha256'}
    def metadata(key, value):
        if key in digests:
            return (isinstance(value, str) and len(value) == 64
                    and all(c in '0123456789abcdef' for c in value))
        return (key == 'originalPacket' and isinstance(value, str)
                and '\n' not in value and Path(value).suffix == '.jsonl')
    return {key: value for key, value in row.items() if not metadata(key, value)}


def make_view(root, paths, directory):
    """Preserve the full archive and provide a separate complete reading view."""
    root = root.resolve()
    paths = list(dict.fromkeys(p.resolve() for p in paths))
    originals = [(p, load_rows(p)) for p in paths]
    # Reject ambiguous input before publishing any view or launching a reviewer.
    # Packet roles may intentionally repeat an ID with source-only context, so
    # version consistency remains owned by the existing review-scope validator.
    directory.mkdir()
    archive = _intern_pages(root, originals, directory, 'page')
    projected = [(p, [reading_row(row) for row in rows]) for p, rows in originals]
    reading = _intern_pages(root, projected, directory, 'reading')
    reading.update(representation='All rows and all non-provenance fields, exactly interned; no semantic acceptance.',
        separatedTopLevelFields=['sourceSha256', 'targetSha256', 'originalRowSha256', 'originalPacket'],
        rows=sum(len(rows) for _, rows in originals),
        omittedFields=sum(len(row)-len(reading_row(row)) for _, rows in originals for row in rows if isinstance(row, dict)),
        completeArchive='pages')
    manifest = dict(representation='Complete lossless archive; use readingView for wording/context. No semantic credit.',
        referenceKey=REF, roundtrip=True, originalBytes=sum(p.stat().st_size for p,_ in originals),
        viewBytes=archive['viewBytes'], definitions=archive['definitions'],
        inputs=[dict(path=str(p.relative_to(root)),sha256=sha(p),rows=len(rows),
                     decodedSha256=hashlib.sha256(canonical(rows).encode()).hexdigest()) for p,rows in originals],
        pages=archive['pages'], readingView=reading)
    (directory/'manifest.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n')
    return manifest


def latest_usage(path):
    # Bounded tail of the current session, never a full journal read.
    with path.open('rb') as f:
        f.seek(0,2);end=f.tell();f.seek(max(0,end-2097152));data=f.read()
    for line in reversed(data.splitlines()):
        try:event=json.loads(line)
        except (json.JSONDecodeError,UnicodeDecodeError):continue
        if event.get('type')=='event_msg' and event.get('payload',{}).get('type')=='token_count':
            info=event['payload'].get('info') or {};usage=info.get('total_token_usage')
            if usage:return usage
    return None


def inspect_phase(phase, include_usage=False):
    runtime=read(phase/'runtime-verification.json');actual=runtime['actualRuntime']
    validate_model(actual['turn']['model'],actual['turn']['effort'],actual['session']['model_provider'])
    if actual['session']['parent_thread_id'] is not None:raise ValueError('Inherited runtime history')
    result=dict(threadId=runtime['threadId'],model=actual['turn']['model'],reasoning=actual['turn']['effort'],fresh=True)
    task=read(phase/'task.json');root=Path('/Users/antonkrutov/Desktop/Forest')
    mismatches=[]
    for name,digest in task['job']['immutablePins'].items():
        path=Path(name) if Path(name).is_absolute() else local(root,name)
        if sha(path)!=digest:mismatches.append(name)
    if mismatches:raise ValueError('Immutable input changed: '+repr(mismatches[:5]))
    result['immutablePinsVerified']=len(task['job']['immutablePins'])
    if task.get('laneRole')=='shared-technical' and task.get('technicalInbox'):
        inbox=Path(task['technicalInbox'])
        pending=[p for p in sorted(inbox.glob('*.json')) if not (inbox/'handled'/p.name).exists()]
        result['technicalInbox']=dict(path=str(inbox),pendingCount=len(pending),requests=[str(p) for p in pending[:16]])
    view=task.get('losslessView')
    if view:
        manifest=local(root,view['path'])
        if sha(manifest)!=view['sha256']:raise ValueError('Lossless view manifest changed')
        content=read(manifest)
        reading=content.get('readingView')
        for pin in [*content['inputs'],*content['pages'],*(reading['pages'] if reading else [])]:
            if sha(local(root,pin['path']))!=pin['sha256']:raise ValueError('Lossless view dependency changed')
        result['losslessView']=dict(originalBytes=content['originalBytes'],viewBytes=content['viewBytes'],
            archiveManifest=view['path'],roundtrip=content['roundtrip'])
        if reading:
            result['readingView']=dict(bytes=reading['viewBytes'],rows=reading['rows'],
                separatedMetadataFields=reading['omittedFields'],
                readingPages=[pin['path'] for pin in reading['pages']],
                roundtrip=reading['roundtrip'],coverage='All rows; no semantic acceptance')
        else:
            result['losslessView']['requiredPages']=[pin['path'] for pin in content['pages']]
    if include_usage:
        usage=latest_usage(Path(runtime['sessionMetadataPath']));result['usage']=usage
        if usage:
            fresh=usage['input_tokens']-usage.get('cached_input_tokens',0)
            result.update(uncachedInput=fresh,usageIsNotAContextLimit=True)
    return result


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('command',choices=['inspect','usage']);parser.add_argument('--phase',type=Path,required=True)
    args=parser.parse_args();print(json.dumps(inspect_phase(args.phase,args.command=='usage'),ensure_ascii=False))
