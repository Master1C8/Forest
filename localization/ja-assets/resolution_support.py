"""Source-bound held-unit resolutions. Storage/validation only; no wording generation."""
import collections
import hashlib
import json
import pathlib
import re

HERE = pathlib.Path(__file__).resolve().parent
ROOT = HERE.parents[1]
PRESERVATION = {'preserved-detached-source', 'preserved-constructed-language', 'preserved-source-warning'}
DISPLAY = {'translatable-bracketed-display', 'translated-display-candidate'}
# Source-specific provisional display decisions, not a rule for every stage direction.
# The six complete source/consumer/route decisions are frozen in phase 0034.
DISPLAY_CANDIDATE_HASHES = {
    'ds:43:11:Dialogue Text': '02f0882d5660b5f00cec58ca6318dbcb869a96c98089a175cbd672dc9d9127d0',
    'ds:477:766:Dialogue Text': '31df8a3da1c12952d3edee3f2bf162f6bc54079dee1a7fe4ca36565b996d4ed5',
    'ds:477:810:Dialogue Text': '16edb2d1754813f875bc37b8fb5aa7a1f748038fb6c082054afc923721b738ae',
    'ds:526:940:Dialogue Text': '55dbcdcd9710e90c515e80af3e3668d547cf73dabf35ed63b6255d6e2cf0c425',
    'ds:526:948:Dialogue Text': '5f6ffa297271a25ea653755d443e4abd613c9b30b3628db1ec3d994b7e08352a',
    'ds:526:951:Dialogue Text': '3f8fc8dcc49253423afbba3fa3ceec1d07bd99eeb3c86e0c5cb157b1b6e20e25',
    'ds:949:698:Dialogue Text': '78156ae1d8131986ff5e30c205cd22735b31cb31413cc29cc2f7a74abc04dd09',
    'ds:949:712:Dialogue Text': '64bd271d0054550d7626cc131a5c46ee51ef60046da430baa9b52983cd3873a9',
    'ds:949:720:Dialogue Text': '33a722fed35fcfc99086e9490560bfc0004dc74eb5d11f1892d000cc233976b8',
    'ds:949:724:Dialogue Text': '35424f433cd38d779eb7a6d1604efe46166d8a3b5d4f9995d15dd1923d1a6907',
    'ds:949:746:Dialogue Text': 'd4b2d391e71de40b92c80834e642f48d85c022839146e265e33de74bbd594920',
    'ds:952:807:Dialogue Text': 'f51b8ddede977dd7ab0df40bd9197d3f4818df97f9f378ebc557a232366c865f',
    'ds:518:1242:Dialogue Text': '9241a2671a0a153c291fe9deb9e167c407abd377cac92519a95c577e21893978',
    'ds:518:1252:Dialogue Text': 'e5aa30404a770a8891700c34bf42e1efb6c776d7dd1e1cc561b6cc524d1a2e81',
    'ds:562:207:Dialogue Text': 'd0ac5eee165024737752e71ef6409c884fbbc95c802e7e18c5abfd69a9d9e495',
}
NARRATION_DECISION = {
    'path': 'outputs/locale-assets-20261026/ja/0037-translation/display-decisions.json',
    'sha256': 'ca0c6a7af9ae2be95f8841791bd24840fb5b1e5b5f11b5866d2e58ef43c01553',
}
NARRATION_IDS = frozenset({
    'ds:949:698:Dialogue Text', 'ds:949:712:Dialogue Text', 'ds:949:720:Dialogue Text',
    'ds:949:724:Dialogue Text', 'ds:949:746:Dialogue Text', 'ds:952:807:Dialogue Text',
    'ds:518:1242:Dialogue Text', 'ds:518:1252:Dialogue Text', 'ds:562:207:Dialogue Text',
})
# Exactly 43 source-bound unfamiliar utterances, reviewed in all seven source scenes.
# This does not classify other mouse dialogue, English reveals or source placeholders.
MOUSE_DECISION = {
    'path': 'outputs/locale-assets-20261026/ja/0035-translation/mouse-decisions.json',
    'sha256': 'd28f78b06db40d5f1d1c91d4408b3c39d622984adc9345556bfa4336de1472d1',
}
SOURCE_WARNING_DECISION = {
    'path': 'outputs/locale-assets-20261026/ja/0038-translation/warning-decisions.json',
    'sha256': 'c3de1d4323c5d50f09f46b81a3ecfc3a7667503cf076ded783934dfd11699b8e',
}
SOURCE_WARNING_HASHES = {
    **{f'ds:{key}:Dialogue Text': 'b18479db46a6edbc980b7957981bc1158d4cc7fba420603394c5b7af34ae51f6'
       for key in ('50:82', '50:87', '52:128', '52:129')},
    'ds:496:20:Dialogue Text': '4b044ed22c20ef26cd90003454ad312ac1998ea35883e4c0366528de13aa1472',
}


def sha(data):
    return hashlib.sha256(data).hexdigest()


def scan_controls(text, ordinary=(), include_numbers=False):
    """All unknown brackets stay opaque; only reviewed outer ordinals open as prose."""
    tokens = []
    i = 0
    ordinal = 0
    used = set()
    while i < len(text):
        if text[i] == '[':
            start = i
            depth = 1
            quote = None
            i += 1
            while i < len(text) and depth:
                c = text[i]
                if quote:
                    if c == quote and text[i - 1] != '\\':
                        quote = None
                elif c in '\"\'':
                    quote = c
                elif c == '[':
                    depth += 1
                elif c == ']':
                    depth -= 1
                i += 1
            assert depth == 0, 'Unbalanced bracket'
            block = text[start:i]
            if ordinal in ordinary:
                used.add(ordinal)
                # No known control family may be reclassified as ordinary prose.
                assert not re.match(r'\[(?:lua\(|var=|autocase=|pic[ac]?=|position[ =]|panel=|/?em\d+\]|a\]|f\]|auto\]|nosubtitle\])', block, re.I), 'Engine tag cannot be ordinary prose'
                tokens += ['['] + scan_controls(block[1:-1], include_numbers=include_numbers) + [']']
            else:
                tokens.append(block)
            ordinal += 1
        elif text[i] == '<' and re.match(r'</?[A-Za-z][^>]*>', text[i:]):
            end = text.index('>', i) + 1
            tokens.append(text[i:end])
            i = end
        elif text[i] == '{' and '}' in text[i:]:
            end = text.index('}', i) + 1
            tokens.append(text[i:end])
            i = end
        elif include_numbers and text[i].isdigit():
            match = re.match(r'\d+', text[i:])
            tokens.append('NUMBER:' + match.group())
            i += len(match.group())
        else:
            i += 1
    assert used == set(ordinary), 'Approved bracket ordinal absent'
    return tokens


def validate_text(source, target, ordinary=()):
    assert target.strip(), 'Empty target'
    assert scan_controls(source, ordinary) == scan_controls(target, ordinary), 'Protected controls mismatch'
    for separator in ('\n', '\r', '|'):
        assert source.count(separator) == target.count(separator), 'Line separator mismatch'
    assert scan_controls(source, ordinary, True) == scan_controls(target, ordinary, True), 'Numeric literals mismatch'


def topology(trees):
    assert trees[0]['conversations'] == trees[1]['conversations'], 'Source copies differ'
    nodes = {}
    graph = {}
    roots = set()
    incoming = collections.defaultdict(list)
    for c in trees[0]['conversations']:
        for i, entry in enumerate(c['dialogueEntries']):
            key = (c['id'], entry['id'])
            assert key not in nodes, 'Duplicate source node'
            nodes[key] = entry
            fields = {f['title']: f['value'] for f in entry['fields']}
            if i == 0 or entry['isRoot'] or fields.get('Title', '').strip() or fields.get('TfolUniqueDataKeySuffix', '').strip():
                roots.add(key)
            graph[key] = [(link['destinationConversationID'], link['destinationDialogueID']) for link in entry['outgoingLinks']]
            for dest in graph[key]:
                incoming[dest].append(key)
    reachable = set(roots)
    todo = list(roots)
    while todo:
        for dest in graph.get(todo.pop(), []):
            assert dest in nodes, 'Dangling source link'
            if dest not in reachable:
                reachable.add(dest)
                todo.append(dest)
    return nodes, graph, roots, reachable, incoming


def verify_own_evidence(ref):
    path = (ROOT / ref['path']).resolve()
    assert path.is_relative_to(HERE) or path.is_relative_to(ROOT / 'outputs/locale-assets-20261026/ja'), 'Resolution evidence outside own lane'
    raw = path.read_bytes()
    assert sha(raw) == ref['sha256'], 'Resolution evidence hash mismatch'
    return json.loads(raw) if path.suffix == '.json' else raw


def verify_mouse_record(record, source_row, proof, topo):
    decision = verify_own_evidence(MOUSE_DECISION)
    assert decision['locale'] == 'ja' and decision['glossaryId'] == 'tfol-068', 'Mouse decision locale/glossary mismatch'
    assert decision['glossarySha256'] == sha((ROOT / 'localization/glossary/ja.json').read_bytes()), 'Mouse decision glossary changed'
    decisions = {r['id']: r for r in decision['records']}
    assert len(decisions) == len(decision['records']) == 43, 'Mouse decision group mismatch'
    reviewed = decisions.get(record['id'])
    assert reviewed and reviewed['sourceSha256'] == record['sourceSha256'] and reviewed['source'] == source_row['source'], 'Mouse utterance lacks exact reviewed source decision'
    assert record['target'] == reviewed['source'] and record['targetSha256'] == reviewed['targetSha256'], 'Mouse preservation target changed'
    assert record['reason'] == reviewed['reason'], 'Mouse preservation reason changed'
    nodes, graph, roots, reachable, incoming = topo
    key = (source_row['conversationId'], source_row['entryId'])
    assert key in reachable, 'Mouse utterance lacks source route'
    context = verify_own_evidence(decision['sourceContext'])
    for conversation in context['conversations']:
        for entry in conversation['dialogueEntries']:
            assert nodes.get((conversation['id'], entry['id'])) == entry, 'Mouse source context changed'
    assert nodes[key] == reviewed['entry'], 'Mouse execution context changed'
    route = [tuple(k) for k in proof['displaySourceRoute']]
    assert route == [tuple(k) for k in reviewed['displaySourceRoute']], 'Mouse source route decision mismatch'
    assert route and route[0] in roots and route[-1] == key, 'Mouse source route endpoints mismatch'
    assert all(b in graph[a] for a, b in zip(route, route[1:])), 'Mouse source route link mismatch'
    font = verify_own_evidence(decision['fontSourceMap'])
    for ref in font['inputs']:
        assert sha((ROOT / ref['path']).read_bytes()) == ref['sha256'], 'Mouse source font input changed'
    for group in font['fontSelectors']:
        for entry in group['entries']:
            assert nodes[(group['conversationId'], entry['id'])] == entry, 'Mouse font selector changed'
    consumers = verify_own_evidence(decision['consumers'])
    for ref in consumers['ownLaneConsumerCopies']:
        verify_own_evidence(ref)


def narration_spans(text, mixed):
    """Validate the reviewed display shape without reclassifying literal asterisks."""
    prefix = re.match(r'^(?:\[pic=[0-9A-Za-z_]+\])*', text).group()
    body = text[len(prefix):]
    match = re.fullmatch(r'\*([^*]+)\* ([^*]+)' if mixed else r'\*([^*]+)\*', body)
    assert match, 'Reviewed narration span shape mismatch'
    assert match[1].strip() and (not mixed or match[2].strip()), 'Empty narration or speech span'
    return {'portraitPrefix': prefix, 'narration': match[1], 'speech': match[2] if mixed else None,
            'separator': ' ' if mixed else '', 'kind': 'narration-then-speech' if mixed else 'standalone-narration'}


def verify_narration_record(record, source_row, proof, topo):
    decision = verify_own_evidence(NARRATION_DECISION)
    assert decision['locale'] == 'ja', 'Narration decision locale mismatch'
    assert decision['glossarySha256'] == sha((ROOT / 'localization/glossary/ja.json').read_bytes()), 'Narration glossary changed'
    reviewed = {r['id']: r for r in decision['records']}
    assert len(reviewed) == len(decision['records']) == 9 and set(reviewed) == NARRATION_IDS, 'Narration decision group mismatch'
    item = reviewed[record['id']]
    assert item['sourceSha256'] == record['sourceSha256'] and item['source'] == source_row['source'], 'Narration source decision mismatch'
    mixed = record['id'] == 'ds:949:712:Dialogue Text'
    assert narration_spans(source_row['source'], mixed) == item['sourceSpans'], 'Narration source span mismatch'
    assert narration_spans(record['target'], mixed) == item['targetSpans'], 'Narration target span decision mismatch'
    assert item['target'] == record['target'] and item['targetSha256'] == record['targetSha256'], 'Narration target decision mismatch'
    assert item['reason'] == record['reason'], 'Narration decision reason mismatch'
    assert item['entry'] == proof['entry'], 'Narration reviewed execution context changed'
    assert item['displaySourceRoute'] == proof['displaySourceRoute'], 'Narration reviewed route changed'
    context = verify_own_evidence(decision['sourceContext'])
    nodes = topo[0]
    for conversation in context['conversations']:
        for entry in conversation['dialogueEntries']:
            assert nodes.get((conversation['id'], entry['id'])) == entry, 'Narration source context changed'
    consumers = verify_own_evidence(decision['consumers'])
    for reference in consumers['ownLaneConsumerCopies']:
        verify_own_evidence(reference)
    verify_own_evidence(decision['authoredDisplay'])


def verify_warning_group(records):
    assert len(records) == 5 and {r['id'] for r in records} == set(SOURCE_WARNING_HASHES), 'Source-warning group must contain exactly the five reviewed IDs'
    for record in records:
        assert record['sourceSha256'] == SOURCE_WARNING_HASHES[record['id']], 'Source-warning source decision mismatch'
        assert record['sourceDefectStatus'] == 'OPEN', 'Source-warning defect must remain OPEN'


def verify_warning_record(record, source_row, fact, proof, topo):
    assert SOURCE_WARNING_HASHES.get(record['id']) == record['sourceSha256'], 'Source-warning lacks exact reviewed ID/source decision'
    assert record.get('sourceDefectStatus') == fact.get('sourceDefectStatus') == 'OPEN', 'Source-warning defect must remain OPEN'
    decision = verify_own_evidence(SOURCE_WARNING_DECISION)
    assert decision['locale'] == 'ja' and decision['sourceDefectStatus'] == 'OPEN', 'Source-warning locale/status mismatch'
    verify_warning_group(decision['records'])
    item = next(r for r in decision['records'] if r['id'] == record['id'])
    assert all(record[k] == item[k] for k in item if k not in {'source', 'entry'}), 'Source-warning frozen decision mismatch'
    assert item['source'] == source_row['source'] == record['target'], 'Source-warning complete bytes changed'
    assert item['entry'] == proof['entry'], 'Source-warning complete entry changed'
    parent = verify_own_evidence(decision['parentDecision'])
    assert len(parent['records']) == 5 and {r['id'] for r in parent['records']} == set(SOURCE_WARNING_HASHES), 'Source-warning parent group mismatch'
    original = next(r for r in parent['records'] if r['id'] == record['id'])
    assert original['sourceSha256'] == record['sourceSha256'] and original['preserveExactly'] == record['target'], 'Source-warning parent source mismatch'
    assert original['sourceDefectStatus'] == 'OPEN' and original['sourceBinding'] == {'pointer': record['pointer'], 'occurrences': record['occurrences']}, 'Source-warning parent binding mismatch'
    assert fact['protectedSpans'] == original['protectedSpans'], 'Source-warning protected spans mismatch'
    for reference in decision['priorFindings']:
        verify_own_evidence(reference)
    context = verify_own_evidence(decision['sourceContext'])
    for conversation in context['conversations']:
        for entry in conversation['dialogueEntries']:
            assert topo[0].get((conversation['id'], entry['id'])) == entry, 'Source-warning scene context changed'
    consumers = verify_own_evidence(decision['consumers'])
    for reference in consumers['ownLaneConsumerCopies']:
        verify_own_evidence(reference)
    for path, digest in consumers['parentEvidenceHashChecks'].items():
        assert sha((ROOT / path).read_bytes()) == digest, 'Source-warning parent consumer evidence changed'


def verify_record(record, source_row, original_hold, fact, proof, topo):
    ident = record['id']
    assert ident == source_row['id'] == fact['id'] == proof['id'], 'Resolution ID mismatch'
    assert record['sourceSha256'] == sha(source_row['source'].encode()) == fact['sourceSha256'] == proof['sourceSha256'], 'Resolution source hash mismatch'
    assert record['pointer'] == source_row['pointer'] == proof['pointer'], 'Resolution pointer mismatch'
    assert record['occurrences'] == source_row['occurrences'] == proof['occurrences'], 'Resolution occurrence mismatch'
    assert record['originalHoldReason'] == original_hold and record['originalHoldReasonSha256'] == sha(original_hold.encode()), 'Resolution hold reason mismatch'
    assert record['targetSha256'] == sha(record['target'].encode()), 'Resolution target hash mismatch'
    nodes, graph, roots, reachable, incoming = topo
    key = (source_row['conversationId'], source_row['entryId'])
    assert proof['entry'] == nodes[key], 'Resolution entry mismatch'
    assert proof['incoming'] == [list(k) for k in incoming[key]] and proof['outgoing'] == [list(k) for k in graph[key]], 'Resolution topology mismatch'
    assert proof['isConservativeRoot'] == (key in roots) and proof['reachableFromConservativeRoots'] == (key in reachable), 'Resolution reachability mismatch'
    disposition = record['disposition']
    assert disposition == fact['disposition'], 'Resolution disposition mismatch'
    assert disposition in {'preserved-detached-source', 'translatable-bracketed-display', 'translated-display-candidate', 'preserved-constructed-language', 'preserved-source-warning'}, 'Unsupported resolution disposition; extend only after source-specific review'
    if disposition == 'preserved-detached-source':
        assert key not in reachable and key not in roots, 'Detached resolution is reachable'
    if disposition == 'preserved-constructed-language':
        verify_mouse_record(record, source_row, proof, topo)
    if disposition == 'preserved-source-warning':
        verify_warning_record(record, source_row, fact, proof, topo)
    if disposition in PRESERVATION:
        assert record['target'] == source_row['source'] == fact['preserveExactly'], 'Preserved source changed'
        assert not record.get('ordinaryBracketOrdinals'), 'Preserved source cannot open brackets'
    elif disposition == 'translatable-bracketed-display':
        assert record.get('ordinaryBracketOrdinals') == fact.get('ordinaryBracketOrdinals') == [0], 'Ordinary bracket decision mismatch'
        # These source-bound receipts approve exactly one outer display bracket.
        assert source_row['source'].startswith('[') and source_row['source'].endswith(']'), 'Outer display delimiters missing'
        assert fact['protectedSpans'] == [{'start': 0, 'end': 1, 'text': '['}, {'start': len(source_row['source']) - 1, 'end': len(source_row['source']), 'text': ']'}], 'Display delimiter spans mismatch'
        assert key in reachable, 'Display resolution lacks source route'
        assert record['target'] != source_row['source'], 'Visible prose unchanged'
    elif disposition == 'translated-display-candidate':
        assert DISPLAY_CANDIDATE_HASHES.get(ident) == record['sourceSha256'], 'Display candidate lacks exact reviewed source decision'
        assert key in reachable, 'Display resolution lacks source route'
        fields = {f['title']: f['value'] for f in nodes[key]['fields']}
        assert all(not fields.get(k, '').strip() for k in ('Title', 'Sequence', 'Menu Text', 'Response Menu Sequence')), 'Display candidate has unreviewed service fields'
        assert not nodes[key]['isGroup'] and not nodes[key]['conditionsString'] and not nodes[key]['userScript'], 'Display candidate has unreviewed execution state'
        assert not nodes[key]['onExecute']['m_PersistentCalls']['m_Calls'], 'Display candidate has unreviewed callback'
        route = [tuple(k) for k in proof['displaySourceRoute']]
        assert route and route[-1] == key and route[0] in roots, 'Display source route endpoints mismatch'
        root_fields = {f['title']: f['value'] for f in nodes[route[0]]['fields']}
        assert root_fields.get('Title', '').strip(), 'Display source route must begin at a titled selector'
        assert all(b in graph[a] for a, b in zip(route, route[1:])), 'Display source route link mismatch'
        assert fact['protectedSpans'] == [], 'Unreviewed display protected spans'
        assert not record.get('ordinaryBracketOrdinals'), 'Unapproved ordinary brackets'
        assert source_row['source'].count('*') == record['target'].count('*'), 'Narration asterisk mismatch'
        if ident in NARRATION_IDS:
            verify_narration_record(record, source_row, proof, topo)
        elif source_row['source'].startswith('*'):
            assert record['target'].startswith('*') and record['target'].endswith('*'), 'Narration delimiters missing'
        assert record['target'] != source_row['source'], 'Visible prose unchanged'
    else:
        assert not record.get('ordinaryBracketOrdinals'), 'Unapproved ordinary brackets'
        assert record['target'] != source_row['source'], 'Visible prose unchanged'
    validate_text(source_row['source'], record['target'], record.get('ordinaryBracketOrdinals', ()))
    assert record['reason'].strip(), 'Resolution reason missing'


def apply_resolutions(targets, held, byid, trees):
    receipts = sorted((HERE / 'resolutions').glob('*.json'))
    if not receipts:
        return []
    topo = topology(trees)
    applied = []
    seen = set()
    for path in receipts:
        receipt = json.loads(path.read_text())
        assert receipt['schemaVersion'] == 1 and receipt['locale'] == 'ja', 'Resolution locale/schema mismatch'
        assert receipt['manifestSha256'] == sha((ROOT / 'localization/source/dialogue-manifest.json').read_bytes()), 'Resolution manifest mismatch'
        assert receipt['candidatesSha256'] == sha((ROOT / 'localization/source/dialogue-candidates.jsonl').read_bytes()), 'Resolution candidates mismatch'
        evidence = {k: verify_own_evidence(v) for k, v in receipt['evidence'].items()}
        warnings = [r for r in receipt['records'] if r['disposition'] == 'preserved-source-warning']
        if warnings:
            assert receipt['evidence'].get('warningDecisions') == SOURCE_WARNING_DECISION, 'Source-warning decision evidence binding mismatch'
            verify_warning_group(warnings)
        for ref in evidence['consumers']['ownLaneConsumerCopies']:
            verify_own_evidence(ref)
        original_holds = {r['id']:r['reason'] for r in evidence['originalHolds']}
        display_targets = {}
        for line in evidence['authoredDisplay'].decode().splitlines():
            key, value = line.split('\t', 1)
            display_ident = 'ds:' + key + ':Dialogue Text'
            assert display_ident not in display_targets, 'Duplicate authored display ID'
            display_targets[display_ident] = value
        facts = {r['id']: r for r in evidence['facts']['records']}
        proofs = {r['id']: r for r in evidence['topology']['records']}
        display_decisions = {r['id']: r for r in evidence.get('displayDecisions', {}).get('records', [])}
        for record in receipt['records']:
            ident = record['id']
            assert ident not in seen and ident not in targets and ident in held, 'Resolution requires one existing held ID: ' + ident
            seen.add(ident)
            row = byid[ident]
            assert original_holds[ident] == held[ident], 'Frozen original hold mismatch'
            if record['disposition'] in DISPLAY:
                assert display_targets[ident] == record['target'], 'Authored display binding mismatch'
            if record['disposition'] == 'translated-display-candidate':
                if ident in NARRATION_IDS:
                    assert receipt['evidence']['displayDecisions'] == NARRATION_DECISION, 'Narration decision evidence binding mismatch'
                decision = display_decisions[ident]
                assert decision['sourceSha256'] == record['sourceSha256'] and decision['targetSha256'] == record['targetSha256'], 'Display decision binding mismatch'
                assert evidence['displayDecisions']['glossarySha256'] == sha((ROOT / 'localization/glossary/ja.json').read_bytes()), 'Display decision glossary mismatch'
            if record['disposition'] == 'preserved-constructed-language':
                assert receipt['evidence']['mouseDecisions'] == MOUSE_DECISION, 'Mouse decision evidence binding mismatch'
            verify_record(record, row, held[ident], facts[ident], proofs[ident], topo)
            for tree in trees:
                value = tree
                for k in row['pointer'].strip('/').split('/'):
                    value = value[int(k)] if isinstance(value, list) else value[k]
                assert value == row['source'], 'Resolution source occurrence changed'
            preserved = record['disposition'] in PRESERVATION
            target = {**row, 'sourceSha256': record['sourceSha256'], 'target': record['target'], 'targetSha256': record['targetSha256'],
                      'status': record['disposition'] if preserved else 'edited-provisional', 'batch': path.stem,
                      'review': 'Source/consumer-bound preservation; no Japanese translation credited' if preserved else 'Immediate source-to-target editing by author; independent audit pending',
                      'disposition': record['disposition'], 'resolutionReceipt': str(path.relative_to(ROOT)), 'resolutionReceiptSha256': sha(path.read_bytes()),
                      'protectedControls': scan_controls(row['source'], record.get('ordinaryBracketOrdinals', ()))}
            if preserved:
                target['unchangedReason'] = record['reason']
            if record['disposition'] == 'preserved-source-warning':
                target['sourceDefectStatus'] = 'OPEN'
                target['sourceWarning'] = 'Finished dialogue absent in shipped source; exact provisional preservation only'
            targets[ident] = target
            del held[ident]
            applied.append(ident)
    return applied
