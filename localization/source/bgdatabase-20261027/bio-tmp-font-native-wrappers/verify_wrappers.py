#!/usr/bin/env python3
"""Reexport six exact managed bodies and four boundary declarations; never invoke originals."""
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
OLD = HERE.parent / 'bio-tmp-font-feature-upgrade'
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/Managed')
READER = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
SCOPES = HERE.parent / 'bio-tmp-backing-style-replacement/bin/Debug/net8.0/BackingScopes.dll'
COUNTS = [8, 7, 8, 7, 8, 0, 0, 2, 0, 0]
def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for block in iter(lambda: f.read(4194304), b''): h.update(block)
    return h.hexdigest()
def load(p): return json.loads(p.read_text())
def write(p, d): p.write_text(json.dumps(d, indent=2) + '\n')
def retained():
    b = load(HERE / 'baseline.json')
    for p, h in b['priorFiles'].items(): assert sha(ROOT / p) == h, p
    for p, a in [('README.md', 'previous-summary.md'), ('CHECKPOINT.json', 'previous-checkpoint.json')]:
        assert sha(HERE / a) == b['summaryPins'][p]
    spec = importlib.util.spec_from_file_location('frozen109', OLD / 'verify_feature_upgrade.py')
    m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
    prior = m.retained()
    for group in ['codeHashes', 'outputHashes']:
        for p, h in load(OLD / 'reproducibility.json')[group].items(): assert sha(OLD / p) == h, p
    return dict(status='passed-hash-parity', phase109Files=len(b['priorFiles']), previousRetained=prior, readerRebuilds=0)
def checks(texts, s):
    chunks = [c for t in texts for c in t.split('METHOD ')[1:]]
    expected = [sig for row in load(HERE / 'il-commands.json') for sig in row['signatures']]
    assert [c.split(' |')[0] for c in chunks] == expected
    assert [sum(l.startswith('IL_') for l in c.splitlines()) for c in chunks] == COUNTS
    assert [d['signature'] for d in s['selectedMethods']] == expected
    assert s['selectedMethods'][:5] == load(OLD / 'next-consumer.json')['nextMetadata']
    assert [d['hasBody'] for d in s['selectedMethods']] == [n > 0 for n in COUNTS]
    for i in [5, 6]:
        assert s['selectedMethods'][i]['implementation'] == 'InternalCall'
        assert not s['selectedMethods'][i]['isVirtual']
    for i in [8, 9]:
        d = s['selectedMethods'][i]
        assert d['isVirtual'] and d['isNewSlot'] and 'Abstract' in d['attributes'] and not d['hasBody']
    assert [len(s[k]) for k in ['directMethodOperands', 'fieldOperands', 'opaqueRuntimeOperands', 'exceptionHandlers']] == [8, 1, 0, 6]
    assert all(not e['handlers'] for e in s['exceptionHandlers']) and not s['nextDeclarations']
    assert [l for l in chunks[7].splitlines() if l.startswith('IL_')] == ['IL_0000: ldsfld UnityEngine.ILogger UnityEngine.Debug::s_Logger', 'IL_0005: ret']
    assert 'IL_0003: call System.Single UnityEngine.Material::GetFloatImpl(System.Int32)' in chunks[0]
    assert 'IL_0002: call System.String UnityEngine.Object::GetName(UnityEngine.Object)' in chunks[1]
    for i, severity, sig in [(2, 3, expected[8]), (3, 3, expected[9]), (4, 2, expected[8])]:
        lines = [l for l in chunks[i].splitlines() if l.startswith('IL_')]
        assert lines[1] == 'IL_0001: call UnityEngine.ILogger UnityEngine.Debug::get_unityLogger()'
        assert lines[2] == f'IL_0006: ldc.i4.{severity}'
        assert lines[3] == 'IL_0007: ldarg.0'
        if i != 3: assert lines[4] == 'IL_0008: ldarg.1'
        assert sum(': callvirt ' in l for l in lines) == 1
        assert any(l.endswith(': callvirt ' + sig) for l in lines)
    assert all(': stfld ' not in c and ': stsfld ' not in c and ': newobj ' not in c and '::Invoke(' not in c for c in chunks)
    defs = {r['definition']['signature']: r['definition'] for r in s['directMethodOperands']}
    assert len(defs) == 5
    consumers = load(HERE / 'consumer-boundaries.json')['consumers']
    assert {r['definition']['signature']: r['definition'] for r in consumers} == defs
    f = s['fieldOperands'][0]
    assert f['opcode'] == 'ldsfld' and f['definition']['attributes'] == 'Assembly, Static'
    coverage = load(HERE / 'source-trace.json')['coverage']
    for e, t in zip(coverage['exportFiles'], texts):
        assert sha(HERE / e['path']) == e['sha256'] and len(t.splitlines()) == e['lines']
        assert [i for lo, hi in e['modelReadLineRanges'] for i in range(lo, hi+1)] == list(range(1, e['lines']+1))
    assert not coverage['unreadSelectedBodyRanges']
    return dict(selectedBodies=6, selectedDeclarations=10, nativeDeclarations=2, abstractInterfaceDeclarations=2,
                instructions=40, perDeclarationInstructions=COUNTS, exportLines=sum(len(t.splitlines()) for t in texts),
                fullReadCoverage=True, methodOperands=8, fieldOperands=1, opaqueRuntimeOperands=0,
                uniqueMethodDeclarations=5, handlers=0)
def verify(out):
    pins = retained(); write(out / 'retained-input-verification.json', pins)
    assert subprocess.check_output(['dotnet', '--version'], text=True).strip() == '8.0.131'
    rows = load(HERE / 'il-commands.json'); texts = []
    for name, group in [('wrappers.il', rows[:5]), ('direct-dependencies.il', rows[5:])]:
        t = ''
        for row in group:
            r = subprocess.run(['dotnet', str(READER), str(DATA / row['assembly']), row['type'], row['selection']], capture_output=True, text=True, check=True)
            assert not r.stderr
            cs = [c for c in r.stdout.split('METHOD ')[1:] if c.split(' |')[0] in row['signatures']]
            assert [c.split(' |')[0] for c in cs] == row['signatures']
            t += 'TYPE ' + row['type'] + '\n' + ''.join('METHOD ' + c for c in cs)
        (out / name).write_text(t); assert sha(out / name) == sha(HERE / name); texts.append(t)
    r = subprocess.run(['dotnet', str(SCOPES), str(DATA), str(HERE / 'il-commands.json'), str(HERE / 'next-signatures.json')], capture_output=True, check=True)
    assert not r.stderr; (out / 'dependency-scopes.json').write_bytes(r.stdout)
    assert sha(out / 'dependency-scopes.json') == sha(HERE / 'dependency-scopes.json')
    s = load(out / 'dependency-scopes.json')
    for row in s['directMethodOperands'] + s['fieldOperands']: assert sha(DATA / row['definition']['module']) == row['definition']['sha256']
    for d in s['selectedMethods']: assert sha(DATA / d['module']) == d['sha256']
    result = dict(status='passed-static-scoped', dotnetSDK='8.0.131', **checks(texts, s), retained=pins,
                  originalResourcesDecoded=0, gameAssemblyExecuted=False, nativeExecuted=False, gameLaunches=0,
                  imagesOpened=0, gitMutations=0, readerRebuilds=0, authoredTranslations=0, noMocks=True,
                  sourceAcceptance='needs-review', editorial='not-run', runtime='not-run', visual='not-run', delivery='needs-review', usage=None)
    write(out / 'verification.json', result); return result
if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__); p.add_argument('--output', type=Path, required=True)
    out = p.parse_args().output.resolve(); assert HERE in out.parents and not out.exists(); out.mkdir()
    print(json.dumps(verify(out)))
