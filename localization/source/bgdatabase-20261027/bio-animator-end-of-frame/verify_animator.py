#!/usr/bin/env python3
"""Reproduce only the pinned coroutine and its four direct managed dependencies."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]


def load(p):
    return json.loads(Path(p).read_text())


def sha(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def run(argv):
    r = subprocess.run(argv, text=True, capture_output=True, check=True)
    assert not r.stderr, r.stderr
    return r.stdout


def select(raw, row):
    blocks = raw.split('METHOD ')
    chosen = []
    for signature in row['signatures']:
        matches = [b for b in blocks[1:] if b.split(' | ', 1)[0] == signature]
        assert len(matches) == 1, ('missing/ambiguous exact signature', signature)
        chosen.append('METHOD ' + matches[0])
    return blocks[0] + ''.join(chosen)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--output', type=Path, required=True)
    out = ap.parse_args().output.resolve()
    assert out.parent == HERE and not out.exists(), 'new owned output directory required'
    baseline, meta = load(HERE/'baseline.json'), load(HERE/'metadata-commands.json')
    for group in ('retainedFiles', 'processReferences'):
        for p, digest in baseline[group].items():
            assert sha(ROOT/p) == digest, p
    managed = Path(meta['managed'])
    for name, digest in baseline['managedDlls'].items():
        assert sha(managed/name) == digest, name
    assert run(['dotnet', '--version']).strip() == meta['dotnetSDK']
    assert load(HERE/'next-signatures.json') == []
    outputs = {}
    rows = load(HERE/'il-commands.json')
    assert len(rows) == 1
    row = rows[0]
    declarations = run(['dotnet', str(ROOT/meta['ilReader']), str(managed/row['assembly']), row['type'], '--list'])
    assert declarations.splitlines().count(row['signatures'][0]) == 1
    outputs['type-declarations.txt'] = declarations
    for command_file, output_file in [('il-commands.json', 'move-next.il'), ('dependency-commands.json', 'direct-dependencies.il')]:
        parts = []
        for row in load(HERE/command_file):
            raw = run(['dotnet', str(ROOT/meta['ilReader']), str(managed/row['assembly']), row['type'], row['selection']])
            parts.append(select(raw, row))
        outputs[output_file] = ''.join(parts)
    for commands, output in [('il-commands.json', 'dependency-scopes.json'), ('dependency-commands.json', 'direct-dependency-scopes.json')]:
        outputs[output] = run(['dotnet', str(ROOT/meta['scopesReader']), str(managed), str(HERE/commands), str(HERE/'next-signatures.json')])
    outputs['all-direct-operands.json'] = run(['dotnet', str(ROOT/meta['allOperandsReader']), str(managed), str(HERE/'il-commands.json')])
    for name, text in outputs.items():
        assert text == (HERE/name).read_text(), name
    scopes = json.loads(outputs['dependency-scopes.json'])
    direct = json.loads(outputs['all-direct-operands.json'])['directMethodOperands']
    dependencies = json.loads(outputs['direct-dependency-scopes.json'])
    assert len(direct) == 19 and len(scopes['directMethodOperands']) == 13
    # The frozen BackingScopes reader excludes PixelCrushers from its resolution filter.
    # Reconcile those six real managed edges; never call them opaque BCL semantics.
    excluded = scopes['opaqueRuntimeOperands']
    assert len(excluded) == 6
    for edge in excluded:
        match = [d for d in direct if (d['caller'], d['offset'], d['operand']) == (edge['caller'], edge['offset'], edge['operand'])]
        assert len(match) == 1 and match[0]['definition']['module'] == 'Auto-asmdef-FirstPass.dll'
    for edge in scopes['directMethodOperands']:
        matches = [d for d in direct if (d['caller'], d['offset'], d['operand']) ==
                   (edge['caller'], edge['offset'], edge['operand'])]
        assert len(matches) == 1
        common = matches[0]
        assert all(edge[k] == v for k, v in common.items() if k != 'definition')
        assert all(edge['definition'][k] == v for k, v in common['definition'].items())
    native = {d['definition']['signature'] for d in direct if not d['definition']['hasBody']}
    assert len(native) == 2
    assert all(not d['handlers'] for d in scopes['exceptionHandlers'] + dependencies['exceptionHandlers'])
    counts = [sum(l.startswith('IL_') for l in part.splitlines()) for name in ['move-next.il', 'direct-dependencies.il'] for part in outputs[name].split('METHOD ')[1:]]
    assert counts == [79, 10, 3, 4, 9]
    trace = load(HERE/'source-trace.json')
    for coverage in trace['coverage']['files']:
        text = outputs[coverage['path']]
        assert coverage['sha256'] == sha(HERE/coverage['path'])
        assert coverage['lines'] == len(text.splitlines())
        assert coverage['modelReadLineRanges'] == [[1, coverage['lines']]]
        assert coverage['unreadSelectedBodyRanges'] == []
    recon = load(HERE/'caller-reconciliation.json')
    old = load(ROOT/recon['animatorGetter']['scopes'])['directMethodOperands']
    target = recon['animatorGetter']['definition']
    assert any(e['definition'] == target for e in old)
    assert len([e for e in direct if e['definition'] == target]) == 4
    new_signatures = {d['signature'] for d in dependencies['selectedMethods']}
    prior = {target['signature']}
    assert {e['definition']['signature'] for e in direct if e['definition']['hasBody']} == new_signatures | prior
    result = dict(status='passed-static-scoped', selectedBodies=5, instructions=105,
                  exportLines=115, perBodyInstructions=counts, directCoroutineEdges=19,
                  uniqueDirectCoroutineMethods=7, reusedBodies=1, nativeDirectMethods=2,
                  selectedUnreadRanges=0, coroutineDirectManagedBodiesUnread=0,
                  forwardedManagedBodiesUnread=2, opaqueRuntimeOperands=0,
                  retainedFilesVerified=len(baseline['retainedFiles']),
                  processReferencesVerified=len(baseline['processReferences']),
                  installedDllsVerified=len(baseline['managedDlls']),
                  readerRebuilds=0, mocks=0, originalExecution=False,
                  runtime='not-run', visual='not-run', sourceAcceptance='needs-review', usage=None)
    out.mkdir()
    for name, text in outputs.items():
        (out/name).write_text(text)
    (out/'verification.json').write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps(result))


if __name__ == '__main__':
    main()
