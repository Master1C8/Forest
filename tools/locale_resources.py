"""Shared resource preparation. Locale differences are pinned input profiles.

Does not translate, patch a game, install resources or grant native acceptance.
Historical builders remain immutable inputs to already running/completed jobs.
"""
import argparse
from collections import Counter
import hashlib
import importlib.util
import io
import json
import os
from pathlib import Path
import unicodedata

ROOT = Path(__file__).resolve().parents[1]
PUBLISHER = 'tools/locale_resource_publish.py'
HAIKU = 'tools/locale_completion/haiku_identity_resource_v1/build.py'
HELD = dict(sourceGateAccepted=False, applicationAllowed=False, applied=False,
            ready=False, nativeAccepted=False, runtime='not-run')
SOURCE_ROLES = {'invisible-layout-provider':'layout-provider', 'visible-face':'face', 'visible-glow':'glow'}


def require(ok, reason):
    if not ok:
        raise ValueError(reason)


def sha(data):
    return hashlib.sha256(data).hexdigest()


def encode(value):
    return (json.dumps(value, ensure_ascii=False, sort_keys=True, indent=2, allow_nan=False) + '\n').encode()


def jsonl(rows):
    return b''.join((json.dumps(r, ensure_ascii=False, sort_keys=True, separators=(',', ':'), allow_nan=False)+'\n').encode() for r in rows)


def parse(data):
    def unique_keys(pairs):
        value = {}
        for k, v in pairs:
            require(k not in value, 'duplicate-json-key:'+k)
            value[k] = v
        return value
    return json.loads(data, object_pairs_hook=unique_keys)


def index(rows):
    result = {}
    for row in rows:
        require(row['id'] not in result, 'duplicate-record-id:'+row['id'])
        result[row['id']] = row
    return result


class Inputs:
    def __init__(self, root, profile, locale):
        self.root = Path(root).resolve()
        self.profile_path = Path(profile).resolve()
        self.profile_bytes = self.profile_path.read_bytes()
        self.profile = parse(self.profile_bytes)
        require(self.profile.get('schemaVersion') == 1, 'profile-schema')
        require(bool(locale) and self.profile.get('locale') == locale, 'explicit-locale')
        require(self.profile.get('family') in ('narrative150', 'haiku27'), 'unsupported-family')
        self.locale, self.pins, self.cache = locale, {}, {}

    def path(self, name):
        p = Path(name)
        p = (p if p.is_absolute() else self.root / p).resolve()
        require(p.is_relative_to(self.root), 'input-outside-project')
        return p

    def read(self, pin):
        p = self.path(pin['path'])
        if p not in self.cache:
            before = p.stat()
            data = p.read_bytes()
            after = p.stat()
            require((before.st_ino, before.st_size, before.st_mtime_ns) ==
                    (after.st_ino, after.st_size, after.st_mtime_ns), 'input-changed-during-read')
            self.cache[p] = data
        data = self.cache[p]
        require(sha(data) == pin['sha256'], 'input-hash:'+str(p.relative_to(self.root)))
        if 'bytes' in pin:
            require(len(data) == pin['bytes'], 'input-length')
        self.pins[str(p.relative_to(self.root))] = dict(sha256=sha(data), bytes=len(data))
        return data

    def obj(self, pin):
        return parse(self.read(pin))

    def rows(self, pin):
        return [parse(line) for line in self.read(pin).splitlines() if line.strip()]

    def stable(self):
        for name, pin in self.pins.items():
            require(sha((self.root/name).read_bytes()) == pin['sha256'], 'input-changed-before-publication:'+name)
        require(self.profile_path.read_bytes() == self.profile_bytes, 'profile-changed-before-publication')


def refs(value):
    if isinstance(value, dict):
        if isinstance(value.get('path'), str) and isinstance(value.get('sha256'), str):
            yield value
        for item in value.values():
            if isinstance(item, (dict, list)):
                yield from refs(item)
    elif isinstance(value, list):
        for item in value:
            yield from refs(item)


def bound(I, document, target, depth=2):
    """Find an exact receipt/packet pin through declared manifests only."""
    pending = list(refs(document))
    for level in range(depth+1):
        following = []
        for pin in pending:
            if I.path(pin['path']) == I.path(target['path']):
                return pin['sha256'] == target['sha256']
            if level < depth and Path(pin['path']).suffix == '.json' and 'manifest' in Path(pin['path']).name:
                following.extend(refs(I.obj(pin)))
        pending = following
    return False


def wording_inputs(I, pins):
    author, reviewer = I.obj(pins['authorTask']), I.obj(pins['reviewerTask'])
    require(author['job']['locale'] == reviewer['job']['locale'] == I.locale, 'owning-locale')
    require(author['task']['kind'] == 'work' and reviewer['task']['kind'] == 'review', 'distinct-author-review-roles')
    task = reviewer['task']
    require(I.path(task['reviewPacket']) == I.path(pins['packet']['path']) and
            task['reviewPacketSha256'] == pins['packet']['sha256'], 'owning-review-packet')
    own_result, review_result = I.obj(pins['authorResult']), I.obj(pins['reviewerResult'])
    require(own_result.get('outcome') in ('continue', 'blocked', 'static-complete') and
            review_result.get('outcome') in ('continue', 'blocked', 'static-complete'), 'completed-owning-outcomes')
    require(bound(I, own_result, pins['packet']), 'author-packet-binding')
    require(I.path(review_result['reviews']) == I.path(pins['reviews']['path']) and
            bound(I, review_result, pins['reviews']), 'owning-review-receipt-binding')
    runtimes = [I.obj(pins[k]) for k in ('authorRuntime', 'reviewerRuntime')]
    require(runtimes[0]['threadId'] != runtimes[1]['threadId'], 'independent-reviewer')
    for runtime in runtimes:
        actual = runtime['actualRuntime']
        require(actual['turn'] == dict(model='gpt-6.1-sol', effort='high') and
                actual['session']['model_provider'] == 'openai' and
                actual['session']['parent_thread_id'] is None, 'review-runtime-provenance')
    packet, reviews = index(I.rows(pins['packet'])), index(I.rows(pins['reviews']))
    require(set(packet) == set(reviews), 'complete-packet-review-coverage')
    for id_, row in packet.items():
        receipt = reviews[id_]
        require(isinstance(row.get('source'), str) and isinstance(row.get('target'), str) and row['target'].strip(), 'wording-present:'+id_)
        require(row.get('locale', I.locale) == I.locale, 'wording-locale:'+id_)
        require(receipt.get('verdict') in ('pass', 'clean') and receipt.get('reviewed') is not False and
                not receipt.get('notLinguisticCoverage') and not receipt.get('contextOnly'), 'unaccepted-wording:'+id_)
        for key in ('source', 'target'):
            require(sha(row[key].encode()) == row[key+'Sha256'] == receipt[key+'Sha256'], 'wording-review-version:'+id_)
        require(receipt.get('reviewerThreadId') == runtimes[1]['threadId'], 'receipt-reviewer-identity:'+id_)
    return packet, reviews


def narrative(I):
    """One source/page/physical-role algorithm for complete or partial locales."""
    pins = I.profile['inputs']
    groups = I.profile.get('wordingPackets', [pins])
    require(isinstance(groups, list) and bool(groups), 'wording-packets-required')
    wording = [(group, *wording_inputs(I, group)) for group in groups]
    pages, members = index(I.rows(pins['sourcePages'])), index(I.rows(pins['sourceMembers']))
    require(len(pages) == 25 and len(members) == 150, 'complete-common-inventory')
    require({m['pageId'] for m in members.values()} == set(pages), 'physical-page-set')
    for id_, page in pages.items():
        ids = page['occurrenceIds']
        require(len(ids) == len(set(ids)) == 6 and set(ids) == {k for k,m in members.items() if m['pageId'] == id_}, 'exact-six-member-join:'+id_)
        require(Counter(SOURCE_ROLES.get(members[k]['role']) for k in ids) == {'layout-provider':1,'face':1,'glow':4}, 'source-page-roles:'+id_)
        require(all(members[k]['original']['source'] == page['source'] for k in ids), 'whole-source-values:'+id_)
    assigned = {}
    for group, packet, reviews in wording:
        for id_, row in packet.items():
            ids = pages[id_]['occurrenceIds'] if id_ in pages else [id_]
            require(all(k in members for k in ids), 'unknown-source-selector:'+id_)
            for member in ids:
                page = pages[members[member]['pageId']]
                require(row['source'] == page['source'], 'original-source-version:'+id_)
                require(row.get('pageId', page['id']) == page['id'], 'declared-page-binding:'+id_)
                require(member not in assigned, 'overlapping-wording-selector:'+member)
                assigned[member] = (row, reviews[id_], group['reviews'])
    codepoints = None
    face_sha = None
    if pins.get('candidateResources'):
        from fontTools.ttLib import TTFont
        resources = I.obj(pins['candidateResources'])
        resource = next(r for r in resources['resources'] if r['id'] == I.profile['fontCandidate']['resourceId'])
        face = bytes(resource['tree']['m_FontData'])
        face_sha = sha(face)
        require(face_sha == I.profile['fontCandidate']['faceSha256'], 'candidate-face-version')
        with TTFont(io.BytesIO(face)) as font:
            codepoints = set(font.getBestCmap())
    output_pages, selectors, requirements = [], [], []
    for id_, page in pages.items():
        bindings = [assigned[k] for k in page['occurrenceIds'] if k in assigned]
        targets = {binding[0]['target'] for binding in bindings}
        require(len(targets) <= 1, 'conflicting-six-layer-wording:'+id_)
        target = next(iter(targets)) if targets else None
        full = len(bindings) == 6
        forms = {}
        if target is not None:
            for name in ('raw','NFC','NFD'):
                text = target if name == 'raw' else unicodedata.normalize(name, target)
                chars = sorted({ord(ch) for ch in text if ch not in '\r\n\t'})
                forms[name] = dict(sha256=sha(text.encode()), codepoints=chars,
                                   candidateMissing=sorted(set(chars)-codepoints) if codepoints is not None else None)
        output_pages.append(dict(id=id_, locale=I.locale, family=page['family'], source=page['source'],
            sourceSha256=sha(page['source'].encode()), target=target, targetSha256=sha(target.encode()) if target is not None else None,
            physicalIds=page['occurrenceIds'], wordingCoverage='complete' if full else 'partial' if bindings else 'not-provided',
            sourceRecordRef=pins['sourcePages'], **HELD))
        if bindings:
            requirements.append(dict(id=id_, locale=I.locale, forms=forms, normalization='diagnostic-only; authored bytes unchanged',
                                     candidateFaceSha256=face_sha, cmapCheck='static-only' if codepoints is not None else 'not-run', **HELD))
        for member_id in page['occurrenceIds']:
            member = members[member_id]
            evidence = assigned.get(member_id)
            receipt = evidence[1] if evidence else None
            selectors.append(dict(id=member_id, pageId=id_, locale=I.locale, role=SOURCE_ROLES[member['role']], sourceRole=member['role'],
                hasReviewedWording=bool(evidence), wordingReceipt=dict(file=evidence[2],id=evidence[0]['id'],
                    sourceSha256=receipt['sourceSha256'],targetSha256=receipt['targetSha256'],
                    reviewerThreadId=receipt['reviewerThreadId'],scope='whole-page' if evidence[0]['id'] in pages else 'physical-member') if evidence else None,
                binding={k:member[k] for k in ('fontAsset','material','spriteAsset','fontColor','fontSize','layoutComponents','sourceSpan','storedContext')},
                sourceOccurrenceRef=pins['sourceMembers'], **HELD))
    counts = dict(sourcePages=25, sourceSelectors=150, preparedPages=sum(p['wordingCoverage']=='complete' for p in output_pages),
                  reviewedSelectors=len(assigned), pendingSelectors=150-len(assigned), roles=dict(Counter(r['role'] for r in selectors)))
    return {'pages25.jsonl':jsonl(output_pages), 'selectors150.jsonl':jsonl(selectors),
            'requirements.jsonl':jsonl(requirements), 'coverage.json':encode(dict(locale=I.locale,**counts,**HELD)),
            'input-pins.json':encode(I.pins)}, counts


def manifest(I, files, counts):
    return dict(schemaVersion=1, family=I.profile['family'], locale=I.locale,
        profileSha256=sha(I.profile_bytes), engineSha256=sha(Path(__file__).read_bytes()), counts=counts,
        outputs={n:dict(sha256=sha(b),bytes=len(b)) for n,b in sorted(files.items())},
        independentTechnicalReview='pending-for-this-new-implementation', manifestPublishedLast=True,
        notATransaction=True, **HELD)


def verify_delivery(out, expected_manifest, files=None):
    require((out/'manifest.json').is_file(), 'manifest-absent')
    require(parse((out/'manifest.json').read_bytes()) == expected_manifest, 'manifest-version')
    for name, pin in expected_manifest['outputs'].items():
        require((out/name).is_file() and sha((out/name).read_bytes()) == pin['sha256'], 'output-hash:'+name)
        if files is not None:
            require((out/name).read_bytes() == files[name], 'output-bytes:'+name)


def load_module(path):
    spec = importlib.util.spec_from_file_location('shared_resource_'+sha(str(path).encode())[:12], path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def run(profile, locale, output, mode='build', root=ROOT, fail_after=None):
    I = Inputs(root, profile, locale)
    output = Path(output).resolve()
    prefix = I.path(I.profile['outputPrefix'])
    require(prefix.is_relative_to(I.root/'outputs') and output.is_relative_to(prefix) and output != prefix, 'output-outside-profile')
    if I.profile['family'] == 'haiku27':
        require(mode in ('build','check'), 'haiku-partial-output-requires-explicit-reconciliation')
        pin = I.profile['backend']
        require(I.path(pin['path']) == I.root/HAIKU, 'shared-haiku-backend')
        I.read(pin)
        upstream = I.profile['inputs']['snapshotManifest']
        snapshot = I.path(upstream['path']).parent
        data = I.obj(upstream)
        require(data['locale'] == locale and I.profile['culture'] == data.get('culture',locale), 'explicit-culture')
        for name, expected in data['files'].items():
            I.read(dict(expected,path=str((snapshot/name).relative_to(I.root))))
        I.stable()
        # The already shared adapter owns source, review, compile and CLR guards.
        backend=load_module(I.path(pin['path']))
        if mode=='build':
            require(not output.exists(), 'fresh-output-required')
            backend.build(snapshot,output,locale)
        else:
            plan,_,_,_=backend.derive(snapshot,locale)
            require(parse((output/'mapping.json').read_bytes())==plan, 'haiku-mapping-version')
        delivered=parse((output/'manifest.json').read_bytes())
        require(delivered['locale']==locale and delivered['request']==data['files']['request.json'], 'haiku-delivery-binding')
        require(delivered['sourceGateAccepted'] is False and delivered['applicationAllowed'] is False and
                delivered['ready'] is False and delivered['nativeRuntime']=='not-run', 'haiku-acceptance-boundary')
        for name, expected in delivered['files'].items():
            path=(output/name).resolve()
            require(path.is_relative_to(output) and path.is_file() and sha(path.read_bytes())==expected, 'haiku-output-hash:'+name)
        I.stable()
        binding=dict(schemaVersion=1, family='haiku27', locale=locale,
                     profileSha256=sha(I.profile_bytes), engineSha256=sha(Path(__file__).read_bytes()),
                     inputPins=I.pins, backendManifestSha256=sha((output/'manifest.json').read_bytes()), **HELD)
        receipt=output/'factory-binding.json'
        if mode=='build':
            pending=output/'factory-binding.pending'
            with pending.open('xb') as stream:
                stream.write(encode(binding)); stream.flush(); os.fsync(stream.fileno())
            os.replace(pending,receipt)
        require(parse(receipt.read_bytes())==binding, 'haiku-factory-version')
        return dict(locale=locale,family='haiku27',counts=dict(choices=delivered['choiceCount'],outcomes=delivered['tuples']),
                    mode=mode,profileSha256=sha(I.profile_bytes),sharedBackendSha256=pin['sha256'],**HELD)
    files, counts = narrative(I)
    publisher = I.profile['publisher']
    require(I.path(publisher['path']) == I.root/PUBLISHER, 'shared-publisher')
    I.read(publisher)
    files['input-pins.json'] = encode(I.pins)
    expected = manifest(I,files,counts)
    I.stable()
    if mode == 'check':
        verify_delivery(output,expected,files)
    else:
        require(mode in ('build','resume'), 'publication-mode')
        source = load_module(I.path(publisher['path']))
        source.publish(files,output,prefix,expected,verify_delivery,
                       resume=mode=='resume',fail_after=fail_after)
    return dict(locale=locale,family=I.profile['family'],counts=counts,mode=mode,**HELD)


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--profile',type=Path,required=True)
    parser.add_argument('--locale',required=True)
    parser.add_argument('--output',type=Path,required=True)
    parser.add_argument('--mode',choices=['build','resume','check'],default='build')
    args=parser.parse_args()
    result=run(args.profile,args.locale,args.output,args.mode)
    print(json.dumps(result,ensure_ascii=False))


if __name__=='__main__':main()
