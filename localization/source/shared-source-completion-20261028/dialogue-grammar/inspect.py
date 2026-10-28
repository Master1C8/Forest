"""Inventory every frozen dialogue field's conservative protected spans.

Reuse the existing source-bound lexer without changing any locale input. Unknown
brackets remain explicit exceptions, not inferred commands or translation passes.
"""
import argparse
import hashlib
import importlib.util
import json
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[4]
HERE = Path(__file__).resolve().parent
CORPUS = ROOT / 'localization/source/dialogue-candidates.jsonl'
LEXER = ROOT / 'localization/ru-assets/inline_guard.py'
EXPECTED_CORPUS = 'adc49d6bc544d6322d68d671d4dc3306a7e66995b90e94c7ed34d6a863a3696f'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def text_sha(value):
    return hashlib.sha256(value.encode()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--write', action='store_true')
    args = parser.parse_args()
    assert sha(CORPUS) == EXPECTED_CORPUS
    decisions = json.loads((HERE / 'span-decisions.json').read_text())
    ordinary = {r['id']: r for r in decisions['ordinaryBracketText']}
    anomalies = {r['id']: r for r in decisions['preservedSourceAnomalies']}
    assert len(ordinary) == 4 and len(anomalies) == 2
    assert not (set(ordinary) & set(anomalies))
    input_files = [CORPUS, LEXER, HERE / 'span-decisions.json',
        ROOT / 'localization/source/consumers/FormattedText.cs',
        ROOT / 'localization/ru-assets/consumer-evidence-0024/UITools.il',
        ROOT / 'localization/ru-assets/consumer-evidence-0024/UITextField.il',
        ROOT / 'localization/ru-assets/consumer-evidence-0024/LegacyTypewriter.il',
        ROOT / 'localization/ru-assets/consumer-evidence-0024/TmpTypewriter.il']
    pins = {str(p.relative_to(ROOT)): sha(p) for p in input_files}
    spec = importlib.util.spec_from_file_location('existing_inline_lexer', LEXER)
    lexer = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(lexer)
    rows = [json.loads(line) for line in CORPUS.read_text().splitlines()]
    assert len(rows) == len({r['id'] for r in rows}) == 12246
    assert sum(len(r['occurrences']) for r in rows) == 24492
    result, exceptions, consumed = [], [], set()
    kinds, angles, separator_counts = Counter(), Counter(), Counter()
    for row in rows:
        source = row['source']
        decision = ordinary.get(row['id']) or anomalies.get(row['id'])
        if decision:
            assert text_sha(source) == decision['sourceSha256'], ('decision-source', row['id'])
            consumed.add(row['id'])
        spans = []
        previous = 0
        reconstructed = []
        ordinals = ordinary.get(row['id'], {}).get('ordinaryBracketOrdinals', [])
        for start, end in lexer.protected_spans(source, ordinals):
            assert previous <= start < end <= len(source)
            value = source[start:end]
            if ordinals and value in ('[', ']'):
                kind = 'preserved-literal-bracket-delimiter'
            elif value.startswith('['):
                kind = 'formatted-text-square-control' if lexer.engine_bracket(value) else 'unclassified-square-span'
            elif value.startswith('<'):
                kind = 'opaque-preserved-angle-markup'
                angles[value] += 1
            elif value.startswith('{'):
                kind = 'opaque-preserved-brace-span'
            elif value.startswith('\\'):
                kind = 'preserved-typewriter-escape'
            else:
                kind = 'preserved-stray-closing-delimiter'
                expected = anomalies.get(row['id'])
                assert expected and (start, end, value) == (expected['start'], expected['end'], expected['text']), 'unadmitted-source-anomaly'
            record = dict(start=start, end=end, text=value, kind=kind,
                          utf8Start=len(source[:start].encode()), utf8End=len(source[:end].encode()))
            spans.append(record)
            kinds[kind] += 1
            if kind in ('unclassified-square-span', 'preserved-stray-closing-delimiter') or ordinals:
                exceptions.append(dict(id=row['id'], sourceSha256=text_sha(source),
                                       pointer=row['pointer'], occurrences=row['occurrences'], span=record))
            reconstructed.extend([source[previous:start], value])
            previous = end
        reconstructed.append(source[previous:])
        assert ''.join(reconstructed) == source
        separators = []
        for index, char in enumerate(source):
            if char in ('\n', '\r', '|'):
                # Separators inside a protected operand stay part of that
                # operand instead of becoming a second, overlapping span.
                if any(s['start'] <= index < s['end'] for s in spans):
                    continue
                separators.append(dict(start=index, end=index+1, text=char,
                    utf8Start=len(source[:index].encode()), utf8End=len(source[:index+1].encode())))
                separator_counts[char] += 1
        result.append(dict(id=row['id'], sourceSha256=text_sha(source), pointer=row['pointer'],
                           occurrences=row['occurrences'], protectedSpans=spans,
                           lineSeparators=separators))
    assert consumed == set(ordinary) | set(anomalies)
    assert not kinds['unclassified-square-span'], 'unclassified-square-spans'
    # Nested quoted Lua brackets stay one opaque control, not ordinary prose.
    fixture = '[lua(Variable["x]y"])] body'
    assert lexer.protected_spans(fixture) == [(0, len(fixture) - 5)]
    original = '[pic=6]body'
    changed = '[pic=7]body'
    assert lexer.controls(original) == ['[pic=6]']
    assert lexer.controls(original) != lexer.controls(changed)
    # Unknown brackets do not inherit a prose approval from an unrelated ID.
    assert lexer.controls('[not an admitted command]') == ['[not an admitted command]']
    try:
        lexer.protected_spans(original, [0])
    except AssertionError as error:
        assert str(error) == 'Ordinary bracket layout/engine-tag mismatch'
    else:
        raise AssertionError('Engine control accepted as ordinary prose')
    for name, expected in pins.items():
        assert sha(ROOT / name) == expected, ('input-changed', name)
    files = {
        'protected-spans.jsonl': ''.join(json.dumps(r, ensure_ascii=False, separators=(',', ':'))+'\n' for r in result),
        'exceptions.json': json.dumps(exceptions, ensure_ascii=False, indent=2)+'\n',
    }
    report = dict(schemaVersion=1, status='passed-complete-lexical-span-inventory;field-role-and-semantic-gates-separate',
        inputPins=pins, scriptSha256=sha(Path(__file__)), logicalIds=len(rows), physicalOccurrences=24492,
        protectedSpans=sum(kinds.values()), spanKinds=dict(kinds), angleValues=dict(angles),
        lineSeparatorCounts=dict(separator_counts),
        exceptionFields=len(consumed), exceptionSpans=len(exceptions), unresolvedLexicalSpans=0,
        lexicalReconstruction='exact-complete-source-fields',
        nativeAndSemanticAcceptance=False, commonSourceGatePassed=False,
        boundary='Complete conservative lexical spans only. Field-level callbacks, variable/input producers, effect registration, full parser execution and special-scene semantics remain separate predicates. No field-level disposition is promoted.',
        regressions=dict(nestedQuotedLua=True, changedPortraitOperandDistinguished=True,
                         unapprovedBracketRemainsOpaque=True, engineControlCannotBecomeProse=True),
        originalInstallAccess=False, gameLaunch=False, targetEdits=False, textureEdits=False,
        outputs={name: text_sha(value) for name, value in files.items()})
    files['verification.json'] = json.dumps(report, ensure_ascii=False, indent=2)+'\n'
    if args.write:
        assert all(not (HERE/name).exists() for name in files), 'first-creation-only'
        for name, value in files.items():
            with (HERE/name).open('x') as stream:
                stream.write(value)
    else:
        for name, value in files.items():
            assert (HERE/name).read_text() == value, ('complete-output-mismatch', name)
    print(json.dumps({k: report[k] for k in ('status', 'logicalIds', 'protectedSpans', 'spanKinds', 'exceptionFields', 'unresolvedLexicalSpans')}))


if __name__ == '__main__':
    main()
