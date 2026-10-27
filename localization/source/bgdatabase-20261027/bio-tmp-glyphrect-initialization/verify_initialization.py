#!/usr/bin/env python3
"""Reproduce only exact GlyphRect initializer metadata/IL with frozen readers."""
import argparse
import hashlib
import json
import re
import subprocess
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
SIGNATURE = 'System.Void UnityEngine.TextCore.GlyphRect::.cctor()'
CTOR = 'System.Void UnityEngine.TextCore.GlyphRect::.ctor(System.Int32,System.Int32,System.Int32,System.Int32)'
FIELD = 'UnityEngine.TextCore.GlyphRect UnityEngine.TextCore.GlyphRect::s_ZeroGlyphRect'

def load(path):
    return json.loads(Path(path).read_text())

def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()

def run(argv):
    proc = subprocess.run(argv, text=True, capture_output=True, check=True)
    assert not proc.stderr, proc.stderr
    return proc.stdout

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    out = args.output.resolve()
    assert out.parent == HERE and not out.exists(), 'new direct-child output required'
    baseline = load(HERE / 'baseline.json')
    for group in ['retainedFiles', 'processReferences']:
        for path, digest in baseline[group].items():
            assert sha(ROOT / path) == digest, path
    meta = load(HERE / 'initializer-metadata.json')
    assert sha(meta['assembly']) == meta['sha256']
    reader = ROOT / meta['metadataReader']
    assert sha(reader) == meta['readerSha256']
    method_list = run(['dotnet', str(reader), meta['assembly'], meta['type'], '--list'])
    fields = run(['dotnet', str(reader), meta['assembly'], meta['type'], '--fields'])
    assert hashlib.sha256(method_list.encode()).hexdigest() == meta['rawListSha256']
    assert hashlib.sha256(fields.encode()).hexdigest() == meta['rawFieldsSha256']
    assert [s for s in method_list.splitlines() if '::.cctor(' in s] == [SIGNATURE]
    assert [s for s in fields.splitlines() if s.startswith('FIELD ') and 'zero' in s.lower()] == ['FIELD ' + FIELD]
    il = run(['dotnet', str(reader), meta['assembly'], meta['type'], '.cctor'])
    assert il == (HERE / 'initializer.il').read_text()
    assert il.count('METHOD ') == 1 and ('METHOD ' + SIGNATURE + ' |') in il
    instructions = [s for s in il.splitlines() if s.startswith('IL_')]
    assert instructions == [
        'IL_0000: ldc.i4.0', 'IL_0001: ldc.i4.0',
        'IL_0002: ldc.i4.0', 'IL_0003: ldc.i4.0',
        'IL_0004: newobj ' + CTOR,
        'IL_0009: stsfld ' + FIELD, 'IL_000e: ret']
    scopes_reader = ROOT / 'localization/source/bgdatabase-20261027/bio-tmp-backing-style-replacement/bin/Debug/net8.0/BackingScopes.dll'
    scopes_text = run(['dotnet', str(scopes_reader), str(Path(meta['assembly']).parent), str(HERE / 'il-commands.json'), str(HERE / 'next-signatures.json')])
    assert scopes_text == (HERE / 'dependency-scopes.json').read_text()
    scopes = json.loads(scopes_text)
    assert len(scopes['selectedMethods']) == 1 and scopes['selectedMethods'][0]['signature'] == SIGNATURE
    assert scopes['selectedMethods'][0]['hasBody'] and scopes['selectedMethods'][0]['implementation'] == 'IL'
    calls = scopes['directMethodOperands']
    assert len(calls) == 1 and calls[0]['operand'] == CTOR and calls[0]['offset'] == 4
    old = load(ROOT / 'localization/source/bgdatabase-20261027/bio-tmp-atlas-setup/dependency-scopes.json')
    prior = [r for r in old['selectedMethods'] if r['signature'] == CTOR]
    assert len(prior) == 1 and prior[0] == calls[0]['definition']
    # Regression: type provenance through a constructor is not a zero-field consumer.
    assert not [r for r in old['fieldOperands'] if 'GlyphRect::' in r['operand'] and 'zero' in r['operand'].lower()]
    f = scopes['fieldOperands']
    assert len(f) == 1 and f[0]['offset'] == 9 and f[0]['opcode'] == 'stsfld'
    assert f[0]['operand'] == FIELD and f[0]['definition']['attributes'] == 'Private, Static, InitOnly'
    assert scopes['opaqueRuntimeOperands'] == [] and scopes['nextDeclarations'] == []
    assert scopes['exceptionHandlers'] == [{'caller': SIGNATURE, 'handlers': []}]
    coverage = load(HERE / 'source-trace.json')['coverage']
    assert coverage['modelReadLineRanges'] == [[1, 9]] and coverage['unreadSelectedBodyRanges'] == []
    assert coverage['instructions'] == 7 and coverage['lines'] == len(il.splitlines()) == 9
    assert coverage['sha256'] == sha(HERE / 'initializer.il')
    out.mkdir()
    (out / 'initializer.il').write_text(il)
    (out / 'dependency-scopes.json').write_text(scopes_text)
    result = {'status': 'passed-static-scoped', 'selectedBodies': 1, 'selectedDeclarations': 1,
              'instructions': 7, 'exportLines': 9, 'modelReadCoverage': 'complete selected initializer only',
              'directMethodOperands': 1, 'reusedManagedBodies': 1, 'newDirectBodiesUnread': 0,
              'fieldOperands': 1, 'opaqueRuntimeOperands': 0, 'handlers': 0,
              'retainedFilesVerified': len(baseline['retainedFiles']),
              'processReferencesVerified': len(baseline['processReferences']),
              'readerRebuilds': 0, 'mocks': 0, 'originalExecution': False,
              'runtime': 'not-run', 'visual': 'not-run', 'sourceAcceptance': 'needs-review',
              'meaning': 'Exact pinned metadata/IL byte parity and scoped assertions; not runtime initialization, current value, atlas consumer or full source/renderer acceptance.', 'usage': None}
    (out / 'verification.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result))

if __name__ == '__main__':
    main()
