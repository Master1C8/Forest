"""Occurrence-bound display exception; no wording generation or engine execution.

Regression: flower narration may change, but its delimiters, nested controls and
all unknown brackets remain protected. Evidence or source drift fails closed.
"""
import hashlib
import json
import pathlib
import re

ROOT = pathlib.Path(__file__).resolve().parents[2]
HERE = pathlib.Path(__file__).resolve().parent
MANIFEST_SHA256 = '8e94f6b5029bdd75bd52e67aaa68e4ddda82d35d3be154e446f99fc7f7102fda'
RESOLUTIONS_SHA256 = '036920fe7e8045b70c0eb6de3d8829b75c5a27aabc1c41bcd7926a00dbfdf2e2'
FACTS_SHA256 = 'ebc872f0356eb31c557d74697c66ca5e1441f18ced53320ed89b1ff6446f076c'
ALLOWED_IDS = {'ds:131:153:Dialogue Text', 'ds:540:232:Dialogue Text'}


def sha(raw):
    return hashlib.sha256(raw).hexdigest()


def validate_manifest(manifest, byid, trees):
    assert manifest['locale'] == 'es-419', 'Display manifest locale mismatch'
    assert manifest['sharedSourceFactsSha256'] == FACTS_SHA256, 'Source decision hash mismatch'
    for evidence in manifest['evidence']:
        assert sha((ROOT / evidence['path']).read_bytes()) == evidence['sha256'], 'Display evidence hash mismatch: ' + evidence['path']
    facts = json.loads((HERE / 'consumer-evidence-0035/shared-source-facts.json').read_text())
    assert sha((HERE / 'consumer-evidence-0035/shared-source-facts.json').read_bytes()) == FACTS_SHA256, 'Source decision bytes changed'
    decisions = {r['id']: r for r in facts['records']}
    records = {r['id']: r for r in manifest['records']}
    assert len(records) == len(manifest['records']) == 2 and set(records) == ALLOWED_IDS, 'Display occurrence set mismatch'
    for ident, record in records.items():
        row = byid[ident]
        assert sha(row['source'].encode()) == record['sourceSha256'] == decisions[ident]['sourceSha256'], 'Display source hash mismatch: ' + ident
        assert row['pointer'] == record['pointer'] and row['occurrences'] == record['occurrences'] and len(row['occurrences']) == 2, 'Display occurrence binding mismatch: ' + ident
        assert record['ordinaryBracketOrdinals'] == decisions[ident]['ordinaryBracketOrdinals'] == [0], 'Display ordinal mismatch'
        assert record['protectedSpans'] == decisions[ident]['protectedSpans'], 'Display protected spans mismatch'
        for span in record['protectedSpans']:
            assert row['source'][span['start']:span['end']] == span['text'], 'Display delimiter binding mismatch'
        assert row['source'].startswith('[') and row['source'].endswith(']'), 'Display bracket shape mismatch'
        for tree in trees:
            value = tree
            for key in row['pointer'].strip('/').split('/'):
                value = value[int(key)] if isinstance(value, list) else value[key]
            assert value == row['source'], 'Display source copy mismatch: ' + ident
    return records


def load_manifest(byid, trees):
    raw = (HERE / 'display-spans.json').read_bytes()
    assert sha(raw) == MANIFEST_SHA256, 'Display manifest hash mismatch'
    return validate_manifest(json.loads(raw), byid, trees)


def load_resolutions(manifest, byid):
    raw = (HERE / 'hold-resolutions.json').read_bytes()
    assert sha(raw) == RESOLUTIONS_SHA256, 'Hold resolution receipt hash mismatch'
    receipt = json.loads(raw)
    assert receipt['locale'] == 'es-419' and receipt['manifestSha256'] == MANIFEST_SHA256, 'Hold resolution manifest mismatch'
    records = {r['id']: r for r in receipt['records']}
    assert len(records) == len(receipt['records']) == 2 and set(records) == set(manifest), 'Hold resolution ID mismatch'
    for ident, record in records.items():
        assert sha(byid[ident]['source'].encode()) == record['sourceSha256'], 'Hold resolution source mismatch'
        assert sha(record['target'].encode()) == record['targetSha256'], 'Hold resolution target hash mismatch'
        prior = record['priorHold']
        raw = (ROOT / prior['path']).read_bytes()
        assert sha(raw) == prior['batchSha256'], 'Original hold batch changed'
        assert raw.decode().splitlines()[prior['lineNumber'] - 1] == prior['line'], 'Original hold line changed'
        assert sha(prior['line'].encode()) == prior['lineSha256'], 'Original hold line hash mismatch'
        assert sha((ROOT / record['proposalPath']).read_bytes()) == record['proposalSha256'], 'Preserved proposal changed'
    return records


def scan(text, ordinary_ordinals=(), strict=False):
    """Return ordered protected tokens and visible text for numeric validation.

    Ordinals select only approved outer spans. Recursion has no display allowance,
    so quoted/nested Lua and unknown inner brackets remain exact opaque tokens.
    """
    tokens = []
    visible = []
    i = 0
    ordinal = 0
    used = set()
    while i < len(text):
        if text[i] == '[':
            start = i
            depth = 1
            i += 1
            quote = None
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
            token = text[start:i]
            if ordinal in ordinary_ordinals:
                assert not re.match(r'^\[(?:/?em\d+\]|(?:a|f|auto|nosubtitle)\]|(?:pic[ac]?|var|autocase|panel|position)\s*[= ]|lua\()', token, re.I), 'Engine command cannot occupy display span'
                nested, words = scan(token[1:-1], strict=True)
                tokens.extend(['[', *nested, ']'])
                visible.append(words)
                used.add(ordinal)
            else:
                tokens.append(token)
            ordinal += 1
        elif text[i] == '<' and re.match(r'</?[A-Za-z][^>]*>', text[i:]):
            end = text.index('>', i) + 1
            tokens.append(text[i:end])
            i = end
        elif text[i] == '{' and '}' in text[i:]:
            end = text.index('}', i) + 1
            tokens.append(text[i:end])
            i = end
        else:
            assert not ((strict or ordinary_ordinals) and text[i] == ']'), 'Unmatched display closing bracket'
            visible.append(text[i])
            i += 1
    assert used == set(ordinary_ordinals), 'Missing approved display bracket'
    return tokens, ''.join(visible)


def validate_target(row, target, manifest, unchanged_reasons):
    ident = row['id']
    record = manifest.get(ident)
    if record:
        assert sha(row['source'].encode()) == record['sourceSha256'], 'Display source hash mismatch: ' + ident
        assert row['pointer'] == record['pointer'] and row['occurrences'] == record['occurrences'], 'Display occurrence binding mismatch: ' + ident
    ordinals = record['ordinaryBracketOrdinals'] if record else ()
    source_tokens, source_visible = scan(row['source'], ordinals)
    target_tokens, target_visible = scan(target, ordinals)
    assert target.strip(), ident + ' empty target'
    # Preserve the prior numeric/unchanged behavior outside the scoped exception.
    if not record:
        source_visible = re.sub(r'\[[^\]]*\]|<[^>]*>', '', row['source'])
        target_visible = re.sub(r'\[[^\]]*\]|<[^>]*>', '', target)
    punctuation_only = not re.search(r'[^\W\d_]', source_visible)
    assert target != row['source'] or punctuation_only or unchanged_reasons.get(ident), ident + ' unchanged visible text requires an individual reason'
    assert source_tokens == target_tokens, ident + ' protected controls mismatch'
    for separator in ('\n', '\r', '|'):
        assert row['source'].count(separator) == target.count(separator), ident + ' line separator mismatch'
    assert re.findall(r'\d+', source_visible) == re.findall(r'\d+', target_visible), ident + ' number mismatch'

