#!/usr/bin/env python3
"""Reproduce only pinned Texture2D construction metadata; never invoke originals."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import sys

sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
OLD = HERE.parent / 'bio-tmp-logger-dispatch'
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/Managed')
READER = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
SCOPES = HERE.parent / 'bio-tmp-backing-style-replacement/bin/Debug/net8.0/BackingScopes.dll'
EXPORTS = [('texture-constructor.il', 0, 1), ('direct-dependencies.il', 1, 6),
           ('validation-dependencies.il', 6, 14), ('leaf-dependencies.il', 14, 17)]
COUNTS = [45, 5, 40, 8, 19, 18, 4, 18, 0, 8, 8, 0, 0, 10, 18, 0, 0]


def sha(path):
    h = hashlib.sha256()
    with path.open('rb') as f:
        for block in iter(lambda: f.read(4194304), b''): h.update(block)
    return h.hexdigest()


def load(path): return json.loads(path.read_text())
def write(path, value): path.write_text(json.dumps(value, indent=2) + '\n')


def retained():
    baseline = load(HERE / 'baseline.json')
    for name, digest in baseline['priorFiles'].items(): assert sha(ROOT / name) == digest, name
    for name, archive in [('README.md', 'previous-summary.md'), ('CHECKPOINT.json', 'previous-checkpoint.json')]:
        assert sha(HERE / archive) == baseline['summaryPins'][name]
    spec = importlib.util.spec_from_file_location('frozen111', OLD / 'verify_dispatch.py')
    mod = importlib.util.module_from_spec(spec); spec.loader.exec_module(mod)
    previous = mod.retained()
    for group in ['codeHashes', 'outputHashes']:
        for name, digest in load(OLD / 'reproducibility.json')[group].items(): assert sha(OLD / name) == digest, name
    return dict(status='passed-hash-parity', phase111Files=len(baseline['priorFiles']), previousRetained=previous)


def checks(texts, scopes):
    chunks = [c for text in texts for c in text.split('METHOD ')[1:]]
    sigs = [s for row in load(HERE / 'il-commands.json') for s in row['signatures']]
    assert [c.split(' |')[0] for c in chunks] == sigs
    assert [sum(l.startswith('IL_') for l in c.splitlines()) for c in chunks] == COUNTS
    assert [d['signature'] for d in scopes['selectedMethods']] == sigs
    assert [d['hasBody'] for d in scopes['selectedMethods']] == [n > 0 for n in COUNTS]
    assert len(scopes['directMethodOperands']) == 19
    assert scopes['fieldOperands'] == [] and len(scopes['opaqueRuntimeOperands']) == 8
    assert len(scopes['exceptionHandlers']) == 12 and all(not x['handlers'] for x in scopes['exceptionHandlers'])
    assert not scopes['nextDeclarations']
    reuse = load(HERE / 'reused-dependencies.json')
    reused = {row['definition']['signature'] for row in reuse['dependencies']}
    assert set(r['operand'] for r in scopes['directMethodOperands']) - set(sigs) == reused
    for row in reuse['dependencies']:
        assert sha(ROOT / row['sourceTrace']) == row['sourceTraceSha256']
        old = load(ROOT / row['sourceTrace'])
        assert row['definition'] in old['selectedMethods']
        assert old['coverage']['unreadSelectedBodyRanges'] == []
        for export in old['coverage']['exportFiles']:
            assert sha((ROOT / row['sourceTrace']).parent / export['path']) == export['sha256']
    ctor = chunks[0]
    assert 'IL_0014: brfalse.s IL_0018' in ctor and 'IL_0016: br.s IL_004c' in ctor
    assert 'IL_0019: ldarg.s linear\nIL_001b: ldc.i4.0\nIL_001c: ceq' in ctor
    assert 'IL_0024: ldarg.s mipCount\nIL_0026: ldc.i4.1\nIL_0027: bne.un.s IL_002c' in ctor
    assert 'IL_0039: ldc.i4.s 64\nIL_003b: or' in ctor
    assert 'IL_0046: call ' + sigs[5] in ctor
    assert 'IL_0002: call System.Boolean UnityEngine.SystemInfo::SupportsTextureFormat(UnityEngine.TextureFormat)' in chunks[2]
    assert 'IL_0049: call System.Void UnityEngine.Debug::LogError(System.Object,UnityEngine.Object)' in chunks[2]
    assert 'IL_001f: call System.Boolean UnityEngine.Experimental.Rendering.GraphicsFormatUtility::CanDecompressFormat(UnityEngine.Experimental.Rendering.GraphicsFormat)' in chunks[2]
    assert all('ldc.i4.s ' + str(n) in chunks[4] for n in [28, 29, 64, 65])
    assert 'IL_0015: brfalse.s IL_0022' in chunks[5] and 'IL_0021: throw' in chunks[5]
    assert 'IL_0018: newobj System.Void System.ArgumentException::.ctor(System.String)' in chunks[7]
    assert 'IL_0002: ldc.i4.1' in chunks[9]
    assert 'IL_0006: ldc.i4.0' in chunks[10]
    assert 'IL_000a: ldc.i4 -2147467261' in chunks[13]
    assert 'IL_0008: call System.Boolean System.Enum::IsDefined(System.Type,System.Object)' in chunks[14]
    for i in [8, 11, 12, 15, 16]:
        assert scopes['selectedMethods'][i]['implementation'] == 'InternalCall'
    assert all('::Invoke(' not in c for c in chunks)
    trace = load(HERE / 'source-trace.json')
    for row, text in zip(trace['coverage']['exportFiles'], texts):
        assert row['sha256'] == sha(HERE / row['path'])
        assert row['lines'] == len(text.splitlines())
        assert [i for lo, hi in row['modelReadLineRanges'] for i in range(lo, hi+1)] == list(range(1, row['lines']+1))
    assert not trace['coverage']['unreadSelectedBodyRanges']
    return dict(selectedBodies=12, selectedDeclarations=17, instructions=sum(COUNTS), perDeclarationInstructions=COUNTS,
                exportLines=sum(len(t.splitlines()) for t in texts), fullReadCoverage=True,
                methodOperands=19, uniqueMethodDeclarations=len(set(r['operand'] for r in scopes['directMethodOperands'])),
                fieldOperands=0, opaqueRuntimeOperands=8, nativeDeclarations=5, reusedManagedBodies=1,
                reusedAbstractDeclarations=1, handlers=0)


def verify(out):
    pins = retained(); write(out / 'retained-input-verification.json', pins)
    assert subprocess.check_output(['dotnet', '--version'], text=True).strip() == '8.0.131'
    rows = load(HERE / 'il-commands.json'); texts = []
    for name, lo, hi in EXPORTS:
        text = ''
        for row in rows[lo:hi]:
            r = subprocess.run(['dotnet', str(READER), str(DATA / row['assembly']), row['type'], row['selection']], text=True, capture_output=True, check=True)
            assert not r.stderr
            cs = [c for c in r.stdout.split('METHOD ')[1:] if c.split(' |')[0] in row['signatures']]
            assert [c.split(' |')[0] for c in cs] == row['signatures']
            text += 'TYPE ' + row['type'] + '\n' + ''.join('METHOD ' + c for c in cs)
        (out / name).write_text(text); assert sha(out / name) == sha(HERE / name); texts.append(text)
    r = subprocess.run(['dotnet', str(SCOPES), str(DATA), str(HERE / 'il-commands.json'), str(HERE / 'next-signatures.json')], capture_output=True, check=True)
    assert not r.stderr; (out / 'dependency-scopes.json').write_bytes(r.stdout)
    assert sha(out / 'dependency-scopes.json') == sha(HERE / 'dependency-scopes.json')
    scopes = load(out / 'dependency-scopes.json')
    for d in scopes['selectedMethods'] + [r['definition'] for r in scopes['directMethodOperands']]:
        assert sha(DATA / d['module']) == d['sha256']
    result = dict(status='passed-static-scoped', dotnetSDK='8.0.131', **checks(texts, scopes), retained=pins,
                  originalResourcesDecoded=0, gameAssemblyExecuted=False, nativeExecuted=False, gameLaunches=0,
                  imagesOpened=0, gitMutations=0, readerRebuilds=0, authoredTranslations=0, noMocks=True,
                  sourceAcceptance='needs-review', editorial='not-run', runtime='not-run', visual='not-run',
                  delivery='needs-review', usage=None)
    write(out / 'verification.json', result)
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__); parser.add_argument('--output', type=Path, required=True)
    out = parser.parse_args().output.resolve(); assert HERE in out.parents and not out.exists(); out.mkdir()
    print(json.dumps(verify(out), indent=2))
