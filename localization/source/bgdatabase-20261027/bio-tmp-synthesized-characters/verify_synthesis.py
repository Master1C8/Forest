#!/usr/bin/env python3
"""Reexport the bounded original TMP synthesis bodies without executing them."""
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
OLD = HERE.parent / 'bio-tmp-font-definition'
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/Managed')
READER = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
SCOPES = HERE.parent / 'bio-tmp-backing-style-replacement/bin/Debug/net8.0/BackingScopes.dll'
FILES = ['synthesized-characters.il', 'direct-dependencies.il', 'glyph-dependencies.il', 'marshalling-constructor.il']
GROUPS = [1, 6, 4, 1]
COUNTS = [130, 59, 7, 7, 5, 7, 5, 26, 17, 6, 20, 25]
CODES = [3, 9, 10, 11, 13, 1564, 8203, 8206, 8207, 8232, 8233, 8288]

def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda: f.read(4194304), b''): h.update(b)
    return h.hexdigest()

def load(p): return json.loads(p.read_text())
def write(p, v): p.write_text(json.dumps(v, indent=2) + '\n')

def ordered(t, *tokens):
    pos = 0
    for token in tokens: pos = t.index(token, pos) + len(token)

def retained():
    b = load(HERE/'baseline.json')
    assert sha(ROOT/b['priorBaseline']) == b['priorBaselineSha256']
    for n, h in b['priorFiles'].items(): assert sha(ROOT/n) == h, n
    for n, ar in [('README.md', 'previous-summary.md'), ('CHECKPOINT.json', 'previous-checkpoint.json')]:
        assert sha(HERE/ar) == b['summaryPins'][n]
    spec = importlib.util.spec_from_file_location('phase106_pinned', OLD/'verify_font_definition.py')
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    return dict(status='passed-hash-parity', previousRetained=m.retained(),
                phase106Files=len(b['priorFiles']), readerRebuilds=0)

def checks(exports, s):
    chunks = [c for t in exports for c in t.split('METHOD ')[1:]]
    expected = [sig for r in load(HERE/'il-commands.json') for sig in r['signatures']]
    assert [c.split(' |')[0] for c in chunks] == expected
    counts = [sum(l.startswith('IL_') for l in c.splitlines()) for c in chunks]
    assert counts == COUNTS
    assert [d['signature'] for d in s['selectedMethods']] == expected
    assert s['selectedMethods'][0] == load(OLD/'next-consumer.json')['nextMetadata'][0]
    for d in s['selectedMethods']:
        assert d['hasBody'] and d['implementation'] == 'IL'
        assert not d['isVirtual'] and not d['isNewSlot'] and not d['isFinal']
        assert d['genericArity'] == 0 and not d['explicitOverrides']
    assert [len(s[k]) for k in ['directMethodOperands', 'fieldOperands', 'opaqueRuntimeOperands', 'exceptionHandlers']] == [34, 42, 11, 12]
    assert all(not r['handlers'] for r in s['exceptionHandlers'])
    main, helper, metrics, bearing, capset, mean, meanset, wrapper, metricsctor, zero, glyphctor, marshal = chunks
    ordered(main, 'IL_0000: ldc.i4.0', '::m_AtlasPopulationMode', 'IL_0008: ldc.i4.1',
            'IL_0009: bne.un.s IL_0025', '::get_sourceFontFile()', '::get_pointSize()',
            '::LoadFontFace(', 'IL_0021: ldc.i4.0', 'IL_0022: ceq', 'IL_0024: stloc.0')
    lines = [l for l in main.splitlines() if l.startswith('IL_')]
    calls = [i for i,l in enumerate(lines) if '::AddSynthesizedCharacter(' in l]
    assert len(calls) == 12
    for i, code, overwrite in zip(calls, CODES, [1,1,0,0,0,0,0,0,0,0,0,0]):
        assert lines[i-4].endswith('ldarg.0')
        assert lines[i-3].endswith(' '+str(code)) if code != 3 else lines[i-3].endswith('ldc.i4.3')
        assert lines[i-2].endswith('ldloc.0') and lines[i-1].endswith('ldc.i4.'+str(overwrite))
    ordered(main, '::get_capLine()', 'IL_00c1: bne.un.s IL_0109', 'IL_00c9: ldc.i4.s 88',
            '::ContainsKey(', 'IL_00d0: brfalse.s IL_0109', '::get_glyphIndex()',
            '::m_GlyphLookupDictionary', '::get_Item(!0)', '::get_metrics()',
            '::get_horizontalBearingY()', '::set_capLine(', '::get_meanLine()',
            'IL_0119: bne.un.s IL_0161', 'IL_0121: ldc.i4.s 120', '::ContainsKey(',
            'IL_0128: brfalse.s IL_0161', '::get_glyphIndex()', '::m_GlyphLookupDictionary',
            '::get_Item(!0)', '::get_metrics()', '::get_horizontalBearingY()', '::set_meanLine(', 'IL_0161: ret')
    ordered(helper, '::ContainsKey(', 'IL_000c: brfalse.s IL_000f', 'IL_000e: ret',
            'IL_000f: ldarg.2', 'IL_0010: brfalse.s IL_004f', '::GetGlyphIndex(',
            'IL_0018: brfalse.s IL_004f', 'IL_001a: ldarg.3', 'IL_001b: brtrue.s IL_001e',
            'IL_001d: ret', '::m_AtlasRenderMode', 'IL_0024: ldc.i4.4', 'IL_0025: and',
            'IL_0027: beq.s IL_002c', 'IL_0029: ldc.i4.8', 'IL_002c: ldc.i4.s 10',
            '::TryGetGlyphWithUnicodeValue(', 'IL_0038: brfalse.s IL_004e',
            'TMP_Character::.ctor(', '::Add(!0,!1)', 'IL_004e: ret',
            'IL_004f: ldc.i4.0', 'GlyphMetrics::.ctor(', '::get_zero()',
            'IL_0073: ldc.r4 1', 'IL_0078: ldc.i4.0', 'Glyph::.ctor(',
            'TMP_Character::.ctor(', '::Add(!0,!1)', 'IL_0093: ret')
    assert sum(': ldc.r4 0' in l for l in helper.splitlines()) == 5
    for body, field in [(metrics,'m_Metrics'), (bearing,'m_HorizontalBearingY'), (mean,'m_MeanLine')]:
        assert '::'+field in body and not any(': call' in l or ': stfld ' in l for l in body.splitlines())
    for body, field in [(capset,'m_CapLine'), (meanset,'m_MeanLine')]:
        assert '::'+field in body and sum(': stfld ' in l for l in body.splitlines()) == 1
    ordered(wrapper, 'initobj UnityEngine.TextCore.LowLevel.GlyphMarshallingStruct',
            '::TryGetGlyphWithUnicodeValue_Internal(', 'IL_0014: brfalse.s IL_0023',
            'Glyph::.ctor(', 'IL_001e: stind.ref', 'IL_001f: ldc.i4.1',
            'IL_0023: ldarg.2', 'IL_0024: ldnull', 'IL_0025: stind.ref', 'IL_0026: ldc.i4.0')
    assert '::s_ZeroGlyphRect' in zero and not any(': call' in l or ': stsfld ' in l for l in zero.splitlines())
    assert sum(': stfld ' in l for l in metricsctor.splitlines()) == 5
    for body in [glyphctor, marshal]:
        assert sum(': stfld ' in l for l in body.splitlines()) == 5
        assert sum(': call ' in l for l in body.splitlines()) == 1
    unique = {r['definition']['signature']:r['definition'] for r in s['directMethodOperands']}
    assert len(unique) == 19
    assert {r['definition']['signature']:r['definition'] for r in load(HERE/'consumer-boundaries.json')['consumers']} == unique
    native = [d for d in unique.values() if not d['hasBody']]
    assert len(native) == 2 and all(d['implementation'] == 'InternalCall' for d in native)
    assert s['nextDeclarations'] == load(HERE/'next-consumer.json')['nextMetadata']
    # Absence is scoped to these bodies; native/implicit initializer/transitive effects remain open.
    assert not any('Register' in l or 'TMP_ResourceManager' in l for t in chunks for l in t.splitlines() if l.startswith('IL_'))
    return dict(selectedBodies=12, instructions=sum(counts), perBodyInstructions=counts,
                fullReadCoverage=True, methodOperands=34, fieldOperands=42, opaqueRuntimeOperands=11,
                handlers=0, uniqueMethodDeclarations=19, nativeDeclarations=2,
                meaning='Exact synthesis/helper/metric/constructor bodies only; native, implicit initializer, resource and rendering remain unverified')

def verify(out):
    pins = retained()
    write(out/'retained-input-verification.json', pins)
    assert subprocess.check_output(['dotnet','--version'], text=True).strip() == '8.0.131'
    rows = load(HERE/'il-commands.json')
    exports, pos = [], 0
    for filename, size in zip(FILES, GROUPS):
        text = ''
        for r in rows[pos:pos+size]:
            run = subprocess.run(['dotnet',str(READER),str(DATA/r['assembly']),r['type'],r['selection']], capture_output=True, text=True, check=True)
            assert not run.stderr
            chunks = [c for c in run.stdout.split('METHOD ')[1:] if c.split(' |')[0] in r['signatures']]
            assert [c.split(' |')[0] for c in chunks] == r['signatures']
            text += 'TYPE '+r['type']+'\n'+''.join('METHOD '+c for c in chunks)
        pos += size
        (out/filename).write_text(text)
        assert sha(out/filename) == sha(HERE/filename), filename
        exports.append(text)
    assert pos == len(rows)
    run = subprocess.run(['dotnet',str(SCOPES),str(DATA),str(HERE/'il-commands.json'),str(HERE/'next-signatures.json')], capture_output=True, check=True)
    assert not run.stderr
    (out/'dependency-scopes.json').write_bytes(run.stdout)
    assert sha(out/'dependency-scopes.json') == sha(HERE/'dependency-scopes.json')
    s = load(out/'dependency-scopes.json')
    for r in s['directMethodOperands'] + s['fieldOperands']:
        assert sha(DATA/r['definition']['module']) == r['definition']['sha256']
    for d in s['selectedMethods'] + s['nextDeclarations']:
        assert sha(DATA/d['module']) == d['sha256']
    checks_result = checks(exports, s)
    write(out/'metadata-assertions.json', checks_result)
    result = dict(status='passed-static-scoped', dotnetSDK='8.0.131', **checks_result, retained=pins,
                  originalResourcesDecoded=0, gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0,
                  gitMutations=0, readerRebuilds=0, authoredTranslations=0, noMocks=True,
                  sourceAcceptance='needs-review', editorial='not-run', runtime='not-run', visual='not-run', delivery='needs-review', usage=None)
    write(out/'verification.json', result)
    return result

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    out = parser.parse_args().output.resolve()
    assert HERE in out.parents and not out.exists()
    out.mkdir()
    print(json.dumps(verify(out)))
