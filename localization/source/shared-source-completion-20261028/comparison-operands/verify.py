"""Bind exact compiled comparison operands; never generate target wording.

The literal immediately precedes the named call, so it supplies that call's
last string argument. This proves the operand role on that execution path,
not the provenance of the other argument, whole-method reachability, or safe
adaptation of comparisons against translated display text.
"""
import argparse
import copy
import hashlib
import json
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[4]
HERE = Path(__file__).resolve().parent
INDEX = ROOT / 'outputs/pause-inventory-bio-completion-20261028/managed-index/literals.jsonl'
ASSEMBLY_SHA = '46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
RULES = {
    'System.Boolean System.String::op_Equality(System.String,System.String)':
        'Exact equality operand; preserve casing, whitespace and every codepoint.',
    'System.Boolean System.String::op_Inequality(System.String,System.String)':
        'Exact inequality operand; preserve casing, whitespace and every codepoint.',
    'System.Boolean System.String::Contains(System.String)':
        'Substring search operand; translation can change the boolean result.',
    'System.Int32 System.String::IndexOf(System.String)':
        'Substring search operand; translation can change the returned position.',
    'System.Boolean System.Text.RegularExpressions.Regex::IsMatch(System.String,System.String)':
        'Regular-expression pattern argument; preserve its matching grammar and literal values.',
}


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def value_hash(value):
    data = json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(',', ':')).encode()
    return hashlib.sha256(data).hexdigest()


def row(literal):
    after = literal['after']
    if not after or after[0]['opcode'] not in ('call', 'callvirt') or after[0]['operand'] not in RULES:
        raise ValueError('consumer-not-protected-comparison')
    call = after[0]
    if call['index'] != literal['index'] + 1 or call['offset'] != literal['offset'] + 5:
        raise ValueError('literal-not-immediately-consumed')
    return dict(
        id=f"il:Assembly-CSharp.dll/{literal['method']}/IL_{literal['offset']:04x}",
        method=literal['method'], offset=literal['offset'],
        sourceValueSha256=value_hash(literal['value']),
        consumerOffset=call['offset'], consumerOpcode=call['opcode'],
        consumer=call['operand'], role='preserve-comparison-operand',
        reason=RULES[call['operand']],
        boundary='Immediate argument only; input/display dependencies and native implementation not reviewed here.',
    )


def compare(expected, literal):
    actual = row(literal)
    if actual['id'] != expected['id']:
        raise ValueError('literal-selector-changed')
    if actual['sourceValueSha256'] != expected['sourceValueSha256']:
        raise ValueError('literal-value-changed')
    if actual != expected:
        raise ValueError('consumer-binding-changed')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--write', action='store_true')
    args = parser.parse_args()
    index_manifest = json.loads((INDEX.parent / 'manifest.json').read_text())
    assert index_manifest['sourceSha256'] == ASSEMBLY_SHA
    assert digest(INDEX) == index_manifest['files']['literals.jsonl']['sha256']
    assert INDEX.stat().st_size == index_manifest['files']['literals.jsonl']['bytes']
    source = [json.loads(line) for line in INDEX.read_text().splitlines()]
    assert len(source) == 8576
    selected = [r for r in source if r['after'] and r['after'][0]['opcode'] in ('call', 'callvirt')
                and r['after'][0]['operand'] in RULES]
    rows = [row(r) for r in selected]
    assert len({r['id'] for r in rows}) == len(rows)
    for expected, literal in zip(rows, selected):
        compare(expected, literal)
    first = selected[0]
    changed = copy.deepcopy(first)
    changed['value'] += '\u200b'
    try:
        compare(rows[0], changed)
    except ValueError as error:
        assert str(error) == 'literal-value-changed'
    else:
        raise AssertionError('changed comparison operand accepted')
    changed = copy.deepcopy(first)
    changed['after'][0]['operand'] = 'System.String System.String::Concat(System.String,System.String)'
    try:
        compare(rows[0], changed)
    except ValueError as error:
        assert str(error) == 'consumer-not-protected-comparison'
    else:
        raise AssertionError('non-comparison consumer accepted')
    content = ''.join(json.dumps(r, ensure_ascii=False, separators=(',', ':')) + '\n' for r in rows)
    output = HERE / 'preserve-exactly.jsonl'
    if args.write:
        with output.open('x') as stream:
            stream.write(content)
    else:
        assert output.read_text() == content, 'complete protected-operand inventory differs'
    report = dict(
        schemaVersion=1, status='passed-immediate-comparison-operand-bindings',
        originalAssemblySha256=ASSEMBLY_SHA,
        inputIndex=str(INDEX.relative_to(ROOT)), inputIndexSha256=digest(INDEX),
        inputIndexManifestSha256=digest(INDEX.parent / 'manifest.json'),
        scriptSha256=digest(Path(__file__)), protectedOperandCount=len(rows),
        consumerCounts=dict(Counter(r['consumer'] for r in rows)),
        outputSha256=digest(output),
        matchingPositiveControls=True, changedLiteralRejected=True, changedConsumerRejected=True,
        modelSemanticDecision='The five explicit consumer-role rules were authored by the Sol/high coordinator; script expansion/readback is deterministic.',
        commonSourceGatePassed=False, translationEntryAllowed=False,
        limitation='No whole-method, source-producer, special-scene, reinsertion, native implementation or runtime acceptance. Display-versus-control comparison dependencies still require exact adapters, including haiku.',
        originalInstallAccess=False, gameLaunch=False, textureEdits=False,
    )
    report_path = HERE / 'verification.json'
    if args.write:
        with report_path.open('x') as stream:
            stream.write(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
    else:
        assert json.loads(report_path.read_text()) == report
    print(json.dumps({k: report[k] for k in ('status', 'protectedOperandCount', 'consumerCounts')}))


if __name__ == '__main__':
    main()
