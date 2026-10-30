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

For packet input, consume every supplied lossless-view page and definition once.
The helper proves exact decoded roundtrip and source fingerprints; it gives NO
semantic acceptance. References preserve complete values, never summaries.
Judge all assigned IDs, full wording/assemblies and required context. Original
files remain authoritative for ambiguity. No default passes, sampling, skipped
context, narrower dependency selectors or automatic semantic judgments.

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
model assignment. Shared engineering stays in the sole technical lane.
Review finite shared resource contracts together across the authorized locales
when their actual combined input fits; do not create six processes for two cells
each. Keep author and independent reviewer distinct fresh contexts.

Run the supplied usage command after bootstrap and each roughly10 commands.
At100k uncached input or18k output, finish the current coherent unit and checkpoint
the exact remaining IDs/context. Aim below150k uncached input and30k output per
context. These are checkpoint thresholds, not permission to drop required reading,
fabricate progress or stop useful authorized work. The supervisor continues it.
Never auto-kill or retry an unknown request to enforce a token threshold.

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


def make_view(root, paths, directory):
    """Deduplicate exact repeated structures/long strings, preserving every field."""
    root = root.resolve()
    paths = list(dict.fromkeys(p.resolve() for p in paths))
    originals = [(p, load_rows(p)) for p in paths]
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
    directory.mkdir()
    entries = [dict(definition=k, value=v) for k,v in definitions.items()]
    entries += [dict(packet=packet_index, rowIndex=i, value=row)
                for packet_index,item in enumerate(encoded) for i,row in enumerate(item['rows'])]
    pages = []; lines = []; size = 0

    def publish():
        nonlocal lines,size
        if not lines:return
        path = directory/f'page-{len(pages)+1:04d}.jsonl'
        path.write_text(''.join(lines))
        pages.append(dict(path=str(path.relative_to(root)), sha256=sha(path), bytes=path.stat().st_size))
        lines = [];size = 0

    for entry in entries:
        line = canonical(entry)+'\n'
        if size+len(line)>16000:publish()
        lines.append(line);size+=len(line)
    publish()
    manifest = dict(representation='Exact interning; read every definition and row page. No fields omitted; no semantic credit.',
        referenceKey=REF, roundtrip=True, originalBytes=sum(p.stat().st_size for p,_ in originals),
        viewBytes=sum(p['bytes'] for p in pages), definitions=len(definitions),
        inputs=[dict(path=str(p.relative_to(root)),sha256=sha(p),rows=len(rows),
                     decodedSha256=hashlib.sha256(canonical(rows).encode()).hexdigest()) for p,rows in originals],pages=pages)
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
    view=task.get('losslessView')
    if view:
        manifest=local(root,view['path'])
        if sha(manifest)!=view['sha256']:raise ValueError('Lossless view manifest changed')
        content=read(manifest)
        for pin in [*content['inputs'],*content['pages']]:
            if sha(local(root,pin['path']))!=pin['sha256']:raise ValueError('Lossless view dependency changed')
        result['losslessView']=dict(originalBytes=content['originalBytes'],viewBytes=content['viewBytes'],
            requiredPages=[pin['path'] for pin in content['pages']],roundtrip=content['roundtrip'])
    if include_usage:
        usage=latest_usage(Path(runtime['sessionMetadataPath']));result['usage']=usage
        if usage:
            fresh=usage['input_tokens']-usage.get('cached_input_tokens',0)
            result.update(uncachedInput=fresh,checkpointDue=fresh>=100000 or usage.get('output_tokens',0)>=18000)
    return result


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('command',choices=['inspect','usage']);parser.add_argument('--phase',type=Path,required=True)
    args=parser.parse_args();print(json.dumps(inspect_phase(args.phase,args.command=='usage'),ensure_ascii=False))
