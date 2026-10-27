#!/usr/bin/env python3
"""Reproduce the four exact TMP_TextElement bodies with frozen metadata readers."""
import argparse
import hashlib
import json
import subprocess
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]


def load(path):
    return json.loads(Path(path).read_text())


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def run(argv):
    result = subprocess.run(argv, text=True, capture_output=True, check=True)
    assert not result.stderr, result.stderr
    return result.stdout


def select(raw, signatures):
    parts = raw.split('METHOD ')
    assert len(parts) - 1 == len(signatures), 'unexpected/missing overload'
    selected = []
    for signature in signatures:
        matches = [p for p in parts[1:] if p.split(' |', 1)[0] == signature]
        assert len(matches) == 1, signature
        selected.append('METHOD ' + matches[0])
    return parts[0] + ''.join(selected)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    out = args.output.resolve()
    assert out.parent == HERE and not out.exists(), 'new direct-child output required'
    baseline = load(HERE / 'baseline.json')
    for group in ('retainedFiles', 'processReferences'):
        for path, digest in baseline[group].items():
            assert sha(ROOT / path) == digest, path
    meta = load(HERE / 'metadata-commands.json')
    recon = load(HERE / 'caller-reconciliation.json')
    commands = load(HERE / 'il-commands.json')
    assert load(HERE / 'next-signatures.json') == []
    assert len(commands) == 1
    row = commands[0]
    signatures = row['signatures']
    assert len(signatures) == len(set(signatures)) == 4
    assert signatures == [d['signature'] for d in recon['selectedNewDeclarations']]
    managed = Path(meta['managed'])
    for definition in recon['selectedNewDeclarations'] + [recon['zeroGetterDeclaration']]:
        assert sha(managed / definition['module']) == definition['sha256']
    raw = run(['dotnet', str(ROOT / meta['ilReader']), str(managed / row['assembly']),
               row['type'], row['selection']])
    il = select(raw, signatures)
    assert il == (HERE / 'character-dependencies.il').read_text()
    bodies = il.split('METHOD ')[1:]
    expected = [
        ['IL_0000: ldarg.0', 'IL_0001: call System.Void System.Object::.ctor()', 'IL_0006: ret'],
    ]
    for field in ('System.UInt32 TMPro.TMP_TextElement::m_Unicode',
                  'System.UInt32 TMPro.TMP_TextElement::m_GlyphIndex',
                  'System.Single TMPro.TMP_TextElement::m_Scale'):
        expected.append(['IL_0000: ldarg.0', 'IL_0001: ldarg.1',
                         'IL_0002: stfld ' + field, 'IL_0007: ret'])
    actual = [[line for line in body.splitlines() if line.startswith('IL_')] for body in bodies]
    assert actual == expected
    scopes_text = run(['dotnet', str(ROOT / meta['scopesReader']), str(managed),
                       str(HERE / 'il-commands.json'), str(HERE / 'next-signatures.json')])
    assert scopes_text == (HERE / 'dependency-scopes.json').read_text()
    scopes = json.loads(scopes_text)
    assert {d['signature']: d for d in scopes['selectedMethods']} == {
        d['signature']: d for d in recon['selectedNewDeclarations']}
    assert scopes['directMethodOperands'] == [] and scopes['nextDeclarations'] == []
    assert len(scopes['fieldOperands']) == 3
    for field, instructions in zip(scopes['fieldOperands'], expected[1:]):
        assert field['opcode'] == 'stfld' and field['offset'] == 2
        assert instructions[2] == 'IL_0002: stfld ' + field['operand']
        assert field['definition']['attributes'] == 'Assembly'
    assert scopes['opaqueRuntimeOperands'] == [{
        'caller': signatures[0], 'offset': 1, 'operand': 'System.Void System.Object::.ctor()',
        'scope': 'netstandard, Version=2.0.0.0, Culture=neutral, PublicKeyToken=cc7b13ffcd2ddd51',
        'boundary': 'BCL/runtime semantics not executed'}]
    assert len(scopes['exceptionHandlers']) == 4
    assert all(not item['handlers'] for item in scopes['exceptionHandlers'])
    # Read/store provenance is actual metadata equality, not matching names alone.
    read, store = recon['zeroGetterRead'], recon['initializerStore']
    assert read['definition'] == store['definition']
    assert read['opcode'] == 'ldsfld' and store['opcode'] == 'stsfld'
    atlas = load(ROOT / 'localization/source/bgdatabase-20261027/bio-tmp-atlas-setup/dependency-scopes.json')
    assert not [f for f in atlas['fieldOperands'] if 'GlyphRect::' in f['operand'] and 'zero' in f['operand'].lower()]
    # Phase107 reaches the ctor through phase104; do not invent forwarded callers in107.
    prior = load(ROOT / 'localization/source/bgdatabase-20261027/bio-tmp-synthesized-characters/dependency-scopes.json')
    ctor = recon['constructor']['definition']
    assert len(recon['synthesisConstructorCalls']) == 2
    assert all(call['definition'] == ctor for call in recon['synthesisConstructorCalls'])
    assert not [call for call in prior['directMethodOperands'] if call['caller'] == ctor['signature']]
    trace = load(HERE / 'source-trace.json')
    coverage = trace['coverage']
    assert coverage['sha256'] == sha(HERE / 'character-dependencies.il')
    assert coverage['modelReadLineRanges'] == [[1, 20]]
    assert coverage['unreadSelectedBodyRanges'] == []
    assert coverage['perBodyInstructions'] == [3, 4, 4, 4]
    assert coverage['lines'] == len(il.splitlines()) == 20
    out.mkdir()
    (out / 'character-dependencies.il').write_text(il)
    (out / 'dependency-scopes.json').write_text(scopes_text)
    result = {
        'status': 'passed-static-scoped', 'selectedBodies': 4, 'instructions': 15,
        'exportLines': 20, 'perBodyInstructions': [3, 4, 4, 4],
        'directMethodOperands': 0, 'fieldOperands': 3, 'opaqueRuntimeOperands': 1,
        'handlers': 0, 'newDirectManagedBodiesUnread': 0,
        'retainedFilesVerified': len(baseline['retainedFiles']),
        'processReferencesVerified': len(baseline['processReferences']),
        'modelReadCoverage': 'four selected bodies fully read separately from reproduction',
        'zeroGetter': 'phase107 full reading reused by hash; field matches phase113 initializer',
        'readerRebuilds': 0, 'mocks': 0, 'originalExecution': False,
        'runtime': 'not-run', 'visual': 'not-run', 'sourceAcceptance': 'needs-review',
        'usage': None,
    }
    (out / 'verification.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result))


if __name__ == '__main__':
    main()
