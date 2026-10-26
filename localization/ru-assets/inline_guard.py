"""Conservative, occurrence-bound inline protection; never generates wording.

FormattedText and actual UI/typewriter evidence live in consumer-evidence-0024.
Unknown square-bracket spans remain opaque. Only source-bound, evidenced ordinary
brackets may contain translated prose. This is a draft adapter, not source acceptance.
"""
import hashlib
import json
import pathlib
import re


def sha(raw):
    return hashlib.sha256(raw).hexdigest()


def engine_bracket(token):
    # These concrete families come from FormattedText.Parse. Conservative coverage
    # includes invalid/unconfigured emphasis indices; they must remain exact too.
    return bool(re.fullmatch(
        r'\[(?:pic[ac]?=[0-9A-Za-z_]+|var=[^\]]*|autocase=[^\]]*|'
        r'a|f|auto|nosubtitle|position(?:=|\s+)[0-9]+|panel=[0-9]+|/?em[0-9]+)\]',
        token) or token.startswith('[lua('))


def bracket_end(text, start):
    """Keep nested Lua indexes and quoted brackets inside one exact control."""
    depth = 1
    quote = None
    lua = text.startswith('[lua(', start)
    i = start + 1
    while i < len(text):
        c = text[i]
        if quote:
            if c == '\\':
                i += 2
                continue
            if c == quote:
                quote = None
        elif lua and c in '\"\'':
            quote = c
        elif c == '[':
            depth += 1
        elif c == ']':
            depth -= 1
            if depth == 0:
                return i + 1
        i += 1
    raise AssertionError('Unbalanced bracket')


def protected_spans(text, ordinary_brackets=()):
    """Return exact protected spans, retaining ordinary bracket delimiters.

    Ordinals address top-level square-bracket spans, in source order. An approved
    ordinary span is scanned recursively, so nested engine tags cannot be dropped
    or edited under a prose approval. Unapproved/unknown spans stay byte-exact.
    """
    allowed = set(ordinary_brackets)
    result = []
    seen = set()
    ordinal = 0
    i = 0
    while i < len(text):
        if text[i] == '[':
            end = bracket_end(text, i)
            token = text[i:end]
            if ordinal in allowed and not engine_bracket(token):
                seen.add(ordinal)
                result.append((i, i + 1))
                result.extend((a + i + 1, b + i + 1)
                              for a, b in protected_spans(token[1:-1]))
                result.append((end - 1, end))
            else:
                result.append((i, end))
            ordinal += 1
            i = end
        elif text[i] == '<' and re.match(r'</?[A-Za-z][^>]*>', text[i:]):
            end = text.index('>', i) + 1
            result.append((i, end))
            i = end
        elif text[i] == '{':
            end, depth = i + 1, 1
            while end < len(text) and depth:
                if text[end] == '{':
                    depth += 1
                elif text[end] == '}':
                    depth -= 1
                end += 1
            assert depth == 0, 'Unbalanced brace placeholder'
            result.append((i, end))
            i = end
        elif text[i:i + 1] == '\\' and text[i + 1:i + 2] in ('.', ',', '^', '<', '>'):
            result.append((i, i + 2))
            i += 2
        else:
            # A stray closing bracket must never disappear in an approved field.
            if text[i] in ']}':
                result.append((i, i + 1))
            i += 1
    assert seen == allowed, 'Ordinary bracket layout/engine-tag mismatch'
    return result


def controls(text, ordinary_brackets=()):
    return [text[a:b] for a, b in protected_spans(text, ordinary_brackets)]


def display_text(text, ordinary_brackets=()):
    parts = []
    previous = 0
    for a, b in protected_spans(text, ordinary_brackets):
        parts.append(text[previous:a])
        previous = b
    parts.append(text[previous:])
    return ''.join(parts)


def load_dispositions(path, root, byid):
    if not path.exists():
        return {}
    document = json.loads(path.read_text())
    assert document['schemaVersion'] == 1
    found = {}
    checked_evidence = {}
    for record in document['records']:
        ident = record['id']
        assert ident in byid and ident not in found, 'Disposition ID mismatch/duplicate'
        source = byid[ident]['source']
        assert record['sourceSha256'] == sha(source.encode()), 'Disposition source hash mismatch'
        assert record['reason'] and record['consumerEvidence'], 'Disposition lacks evidence'
        for evidence in record['consumerEvidence']:
            p = (root / evidence['path']).resolve()
            assert p.is_relative_to(root.resolve()), 'Evidence outside project'
            if str(p) not in checked_evidence:
                checked_evidence[str(p)] = sha(p.read_bytes())
            digest = checked_evidence[str(p)]
            assert digest == evidence['sha256'], 'Consumer evidence hash mismatch'
        ordinary = record.get('ordinaryBracketOrdinals', [])
        assert len(ordinary) == len(set(ordinary)), 'Duplicate ordinary bracket ordinal'
        spans = protected_spans(source, ordinary)
        expected_spans = [{'start': a, 'end': b, 'text': source[a:b]} for a, b in spans]
        assert record['protectedSpans'] == expected_spans, 'Source protected span mismatch'
        if record['disposition'] in ('reviewed-unchanged-nonprose', 'preserved-detached-source'):
            assert record['preserveExactly'] == source, 'Unchanged source value mismatch'
        found[ident] = record
    return found


def validate_preserve_manifest(path, dispositions_path, decisions, byid):
    document = json.loads(path.read_text())
    assert document['schemaVersion'] == 1
    assert document['sourceDispositionsSha256'] == sha(dispositions_path.read_bytes()), 'Preserve manifest disposition hash mismatch'
    seen = set()
    for r in document['records']:
        ident = r['id']
        assert ident in decisions and ident not in seen, 'Preserve manifest ID mismatch/duplicate'
        seen.add(ident)
        source, d = byid[ident]['source'], decisions[ident]
        assert r['sourceSha256'] == sha(source.encode()), 'Preserve manifest source mismatch'
        assert r['disposition'] == d['disposition'], 'Preserve manifest disposition mismatch'
        if d.get('preserveExactly') is not None:
            assert r['mode'] == 'whole-field' and r['value'] == source, 'Preserve manifest whole field mismatch'
            assert r['valueSha256'] == sha(source.encode()), 'Preserve manifest value hash mismatch'
        else:
            expected = list(d['protectedSpans'])
            if d.get('preservePrefix'):
                prefix = d['preservePrefix']
                assert source.startswith(prefix), 'Preserve manifest source prefix mismatch'
                expected.insert(0, {'start': 0, 'end': len(prefix), 'text': prefix})
            assert r['mode'] == 'protected-spans' and r['spans'] == expected, 'Preserve manifest spans mismatch'
    assert seen == set(decisions), 'Preserve manifest incomplete'


def validate_target(row, target, decision=None):
    """Validate a complete bound field, including its portrait prefix."""
    ident, source = row['id'], row['source']
    if decision:
        assert decision['id'] == ident, 'Disposition ID mismatch'
        assert decision['sourceSha256'] == sha(source.encode()), 'Disposition source hash mismatch'
        if decision.get('preservePrefix'):
            assert source.startswith(decision['preservePrefix']) and target.startswith(decision['preservePrefix']), ident + ' protected prefix mismatch'
    ordinary = decision.get('ordinaryBracketOrdinals', []) if decision else []
    source_controls = controls(source, ordinary)
    target_controls = controls(target, ordinary)
    assert source_controls == target_controls, (ident, 'protected controls mismatch', source_controls, target_controls)
    for separator in ('\n', '\r', '|'):
        assert source.count(separator) == target.count(separator), (ident, 'line separator mismatch', repr(separator))
    assert re.findall(r'\d+', display_text(source, ordinary)) == re.findall(r'\d+', display_text(target, ordinary)), ident + ' number mismatch'
    punctuation_only = not re.search(r'[^\W\d_]', display_text(source, ordinary))
    unchanged = bool(decision and decision['disposition'] in ('reviewed-unchanged-nonprose', 'preserved-detached-source'))
    if unchanged:
        assert target == source == decision['preserveExactly'], ident + ' unchanged nonprose mismatch'
        return decision['disposition']
    assert target.strip() and (re.search('[А-Яа-яЁё]', display_text(target, ordinary))
                               or (punctuation_only and target == source)), ident + ' no Russian text'
    return 'reviewed-unchanged-punctuation' if punctuation_only else 'translated-wording'
