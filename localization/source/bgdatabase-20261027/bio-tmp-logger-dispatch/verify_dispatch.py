#!/usr/bin/env python3
"""Reproduce exact logger metadata/IL; never load or invoke game assemblies."""
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
OLD = HERE.parent / 'bio-tmp-font-native-wrappers'
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/Managed')
READER = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
SCOPES = HERE.parent / 'bio-tmp-backing-style-replacement/bin/Debug/net8.0/BackingScopes.dll'
EXPORTS = [('initialization.il', 0, 1), ('construction-dispatch.il', 1, 4),
           ('direct-dependencies.il', 4, 12), ('leaf-dependencies.il', 12, 15)]
COUNTS = [7, 4, 17, 22, 22, 4, 4, 4, 39, 3, 34, 0, 10, 3, 3, 0]
def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda: f.read(4194304), b''): h.update(b)
    return h.hexdigest()
def load(p): return json.loads(p.read_text())
def write(p, v): p.write_text(json.dumps(v, indent=2) + '\n')
def retained():
    baseline = load(HERE / 'baseline.json')
    for name, h in baseline['priorFiles'].items(): assert sha(ROOT / name) == h, name
    for name, archive in [('README.md', 'previous-summary.md'), ('CHECKPOINT.json', 'previous-checkpoint.json')]:
        assert sha(HERE / archive) == baseline['summaryPins'][name]
    spec = importlib.util.spec_from_file_location('frozen110', OLD / 'verify_wrappers.py')
    mod = importlib.util.module_from_spec(spec); spec.loader.exec_module(mod)
    previous = mod.retained()
    for group in ['codeHashes', 'outputHashes']:
        for name, h in load(OLD / 'reproducibility.json')[group].items(): assert sha(OLD / name) == h, name
    return dict(status='passed-hash-parity', phase110Files=len(baseline['priorFiles']),
                previousRetained=previous, readerRebuilds=0)
def checks(texts, scopes):
    chunks = [c for t in texts for c in t.split('METHOD ')[1:]]
    sigs = [sig for row in load(HERE / 'il-commands.json') for sig in row['signatures']]
    assert [c.split(' |')[0] for c in chunks] == sigs
    assert [sum(l.startswith('IL_') for l in c.splitlines()) for c in chunks] == COUNTS
    assert [d['signature'] for d in scopes['selectedMethods']] == sigs
    assert [d['hasBody'] for d in scopes['selectedMethods']] == [n > 0 for n in COUNTS]
    assert len(scopes['directMethodOperands']) == 19 and len(scopes['fieldOperands']) == 8
    assert len(scopes['opaqueRuntimeOperands']) == 6
    assert len(scopes['exceptionHandlers']) == 14 and all(not r['handlers'] for r in scopes['exceptionHandlers'])
    assert not scopes['nextDeclarations']
    assert set(r['operand'] for r in scopes['directMethodOperands']) <= set(sigs)
    assert 'IL_000a: stsfld UnityEngine.ILogger UnityEngine.Debug::s_DefaultLogger' in chunks[0]
    assert 'IL_0019: stsfld UnityEngine.ILogger UnityEngine.Debug::s_Logger' in chunks[0]
    assert chunks[0].count(': newobj ') == 4
    assert scopes['fieldOperands'][0]['definition']['attributes'] == 'Assembly, Static, InitOnly'
    assert scopes['fieldOperands'][1]['definition']['attributes'] == 'Assembly, Static'
    for i in [3, 4]:
        assert 'IL_0003: call System.Boolean UnityEngine.Logger::IsLogTypeAllowed(UnityEngine.LogType)' in chunks[i]
        assert 'IL_000a: brfalse.s IL_002e' in chunks[i]
        assert 'IL_001a: newarr System.Object' in chunks[i]
        assert 'IL_0022: call System.String UnityEngine.Logger::GetString(System.Object)' in chunks[i]
        assert 'IL_0028: callvirt System.Void UnityEngine.ILogHandler::LogFormat(UnityEngine.LogType,UnityEngine.Object,System.String,System.Object[])' in chunks[i]
    assert 'IL_0013: ldnull' in chunks[3] and 'IL_0013: ldarg.3' in chunks[4]
    assert 'IL_0024: call System.Globalization.CultureInfo System.Globalization.CultureInfo::get_InvariantCulture()' in chunks[10]
    assert 'IL_0029: callvirt System.String System.IFormattable::ToString(System.String,System.IFormatProvider)' in chunks[10]
    assert 'IL_0033: callvirt System.String System.Object::ToString()' in chunks[10]
    assert scopes['selectedMethods'][11]['hasBody'] is False
    assert 'Abstract' in scopes['selectedMethods'][11]['attributes']
    assert scopes['selectedMethods'][15]['implementation'] == 'InternalCall'
    assert not scopes['selectedMethods'][15]['hasBody']
    assert all('::Invoke(' not in c for c in chunks)
    trace = load(HERE / 'source-trace.json')
    for row, text in zip(trace['coverage']['exportFiles'], texts):
        assert row['sha256'] == sha(HERE / row['path'])
        assert row['lines'] == len(text.splitlines())
        assert [i for lo, hi in row['modelReadLineRanges'] for i in range(lo, hi+1)] == list(range(1, row['lines']+1))
    assert not trace['coverage']['unreadSelectedBodyRanges']
    return dict(selectedBodies=14, selectedDeclarations=16, instructions=sum(COUNTS),
                perDeclarationInstructions=COUNTS, exportLines=sum(len(t.splitlines()) for t in texts),
                fullReadCoverage=True, methodOperands=19, fieldOperands=8, opaqueRuntimeOperands=6,
                uniqueMethodDeclarations=len(set(r['operand'] for r in scopes['directMethodOperands'])),
                nativeDeclarations=1, abstractInterfaceDeclarations=1, handlers=0)
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
    for d in scopes['selectedMethods'] + [r['definition'] for r in scopes['directMethodOperands'] + scopes['fieldOperands']]:
        assert sha(DATA / d['module']) == d['sha256']
    result = dict(status='passed-static-scoped', dotnetSDK='8.0.131', **checks(texts, scopes), retained=pins,
                  originalResourcesDecoded=0, gameAssemblyExecuted=False, nativeExecuted=False,
                  gameLaunches=0, imagesOpened=0, gitMutations=0, readerRebuilds=0, authoredTranslations=0,
                  noMocks=True, sourceAcceptance='needs-review', editorial='not-run', runtime='not-run',
                  visual='not-run', delivery='needs-review', usage=None)
    write(out / 'verification.json', result)
    return result
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__); parser.add_argument('--output', type=Path, required=True)
    out = parser.parse_args().output.resolve(); assert HERE in out.parents and not out.exists(); out.mkdir()
    result = verify(out)
    print(json.dumps({k: v for k, v in result.items() if k != 'retained'}))
