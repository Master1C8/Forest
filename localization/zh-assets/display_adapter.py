"""Exact syntax validation with explicitly bound display spans; no wording generation."""
import hashlib
import json
import re


def sha(raw):
    return hashlib.sha256(raw).hexdigest()


def bracket_end(text, start):
    depth, quote, escaped = 1, None, False
    for i in range(start + 1, len(text)):
        c = text[i]
        if quote:
            if escaped:
                escaped = False
            elif c == '\\':
                escaped = True
            elif c == quote:
                quote = None
        elif c in '\"\'':
            quote = c
        elif c == '[':
            depth += 1
        elif c == ']':
            depth -= 1
            if depth == 0:
                return i + 1
    raise AssertionError('Unbalanced bracket')


def engine_bracket(token):
    # Concrete families from the pinned FormattedText consumer. Unknown spans
    # remain opaque too; this predicate only prevents unsafe display approvals.
    return bool(re.match(r'^\[(?:lua\(|var=|autocase=|pic[ac]?=|position[ =]|panel=|/?em\d+\]|(?:a|f|auto|nosubtitle)\])', token))


def scan(text, display_ordinals=()):
    """Return ordered exact tokens and prose for numeric checks.

    Only approved top-level bracket ordinals expose their interior as display.
    Nested brackets, quoted Lua operands, rich text and variables stay exact.
    """
    tokens, prose, spans = [], [], []
    i, ordinal = 0, 0
    display_ordinals = set(display_ordinals)
    while i < len(text):
        if text[i] == '[':
            end = bracket_end(text, i)
            token = text[i:end]
            spans.append((i, end))
            if ordinal in display_ordinals:
                assert not engine_bracket(token), 'Engine syntax cannot be a display span'
                inner_tokens, inner_prose, _ = scan(token[1:-1])
                tokens.extend(['[', *inner_tokens, ']'])
                prose.append(inner_prose)
            else:
                tokens.append(token)
            ordinal += 1
            i = end
        elif text[i] == '<' and re.match(r'</?[A-Za-z][^>]*>', text[i:]):
            end = text.index('>', i) + 1
            tokens.append(text[i:end])
            i = end
        elif text[i] == '{' and '}' in text[i:]:
            end = text.index('}', i) + 1
            tokens.append(text[i:end])
            i = end
        elif text[i] == ']':
            # Two pinned source records contain an extra closing delimiter.
            # Retain it exactly rather than silently correcting source syntax.
            tokens.append(']')
            i += 1
        else:
            prose.append(text[i])
            i += 1
    assert all(n < ordinal for n in display_ordinals), 'Missing display bracket delimiter'
    return tokens, ''.join(prose), spans


def verify_evidence(root, refs):
    assert refs, 'Source evidence is required'
    for ref in refs:
        assert sha((root / ref['path']).read_bytes()) == ref['sha256'], 'Source evidence hash mismatch: ' + ref['path']


def verify_binding(row, binding):
    assert binding['id'] == row['id'], 'Display binding ID mismatch'
    assert binding['sourceSha256'] == sha(row['source'].encode()), 'Display source hash mismatch'
    assert binding['pointer'] == row['pointer'], 'Display source pointer mismatch'
    assert binding['occurrences'] == row['occurrences'], 'Display occurrence mismatch'


class DisplayAdapter:
    def __init__(self, root, here, byid):
        self.root, self.here, self.byid = root, here, byid
        path = here / 'display-spans.json'
        config = json.loads(path.read_text()) if path.exists() else {'locale': 'zh', 'records': []}
        assert config['locale'] == 'zh', 'Explicit zh display adapter required'
        self.records = {}
        for binding in config['records']:
            row = byid[binding['id']]
            verify_binding(row, binding)
            verify_evidence(root, binding['evidence'])
            assert row['id'] not in self.records, 'Duplicate display binding'
            ordinals = [span['bracketOrdinal'] for span in binding['spans']]
            assert len(set(ordinals)) == len(ordinals), 'Duplicate display ordinal'
            _, _, source_spans = scan(row['source'], ordinals)
            for span in binding['spans']:
                start, end = source_spans[span['bracketOrdinal']]
                assert (start, end) == (span['start'], span['end']), 'Display source offset mismatch'
                assert sha(row['source'][start:end].encode()) == span['sourceSpanSha256'], 'Display span hash mismatch'
            self.records[row['id']] = binding

    def signature(self, row, text):
        binding = self.records.get(row['id'])
        if binding:
            verify_binding(row, binding)
        return scan(text, [s['bracketOrdinal'] for s in binding['spans']] if binding else ())

    def validate(self, row, target):
        source_tokens, source_prose, _ = self.signature(row, row['source'])
        target_tokens, target_prose, _ = self.signature(row, target)
        assert source_tokens == target_tokens, row['id'] + ' protected control mismatch'
        for separator in ('\n', '\r', '|'):
            assert row['source'].count(separator) == target.count(separator), row['id'] + ' line separator mismatch'
        assert re.findall(r'\d+', source_prose) == re.findall(r'\d+', target_prose), row['id'] + ' number mismatch'


class HoldResolutions:
    def __init__(self, root, here, byid):
        self.records, self.used = {}, set()
        path = here / 'hold-resolutions.json'
        config = json.loads(path.read_text()) if path.exists() else {'locale': 'zh', 'records': []}
        assert config['locale'] == 'zh', 'Explicit zh hold resolutions required'
        for receipt in config['records']:
            ident = receipt['id']
            assert ident not in self.records, 'Duplicate hold resolution'
            verify_binding(byid[ident], receipt)
            verify_evidence(root, receipt['evidence'])
            verify_evidence(root, [receipt['priorProposalEvidence']])
            old = receipt['originalHold']
            raw = (root / old['batch']).read_bytes()
            assert sha(raw) == old['batchSha256'], 'Original hold batch changed'
            matches = [line for line in raw.decode().splitlines() if line == old['line']]
            assert len(matches) == 1 and old['line'].split('\t', 1)[1] == '!HOLD ' + old['reason'], 'Original hold receipt mismatch'
            assert sha(old['line'].encode()) == old['lineSha256'], 'Original hold line changed'
            self.records[ident] = receipt

    def apply(self, row, target, batch, held):
        receipt = self.records.get(row['id'])
        if not receipt:
            assert row['id'] not in held, row['id'] + ' unresolved duplicate hold'
            return
        assert row['id'] in held, 'Resolution must consume an existing hold'
        assert held[row['id']] == receipt['originalHold']['reason'], 'Held reason mismatch'
        assert batch == receipt['targetBatch'], 'Hold resolution batch mismatch'
        assert sha(target.encode()) == receipt['targetSha256'], 'Hold resolution target mismatch'
        assert row['id'] not in self.used, 'Repeated hold resolution'
        del held[row['id']]
        self.used.add(row['id'])

    def finish(self):
        assert self.used == set(self.records), 'Unused hold resolutions'


def verify_technical_preservations(root, here, byid, targets, reasons):
    path = here / 'technical-preservations.json'
    config = json.loads(path.read_text()) if path.exists() else {'locale': 'zh', 'records': []}
    assert config['locale'] == 'zh', 'Explicit zh technical preservation required'
    seen = set()
    for binding in config['records']:
        ident = binding['id']
        assert ident not in seen, 'Duplicate technical preservation'
        seen.add(ident)
        row = byid[ident]
        verify_binding(row, binding)
        verify_evidence(root, binding['evidence'])
        assert targets[ident]['target'] == row['source'] == binding['preserveExactly'], 'Technical source must remain byte-exact'
        assert reasons[ident] == binding['reason'], 'Technical unchanged reason mismatch'
        targets[ident]['classification'] = 'unchanged-detached-technical-source'
    return seen
