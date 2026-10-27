#!/usr/bin/env python3
"""Reexport the exact legacy font-upgrade metadata; never load original assemblies."""
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
OLD = HERE.parent / 'bio-tmp-synthesized-characters'
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/Managed')
READER = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
SCOPES = HERE.parent / 'bio-tmp-backing-style-replacement/bin/Debug/net8.0/BackingScopes.dll'
COUNTS = [429] + [5] * 15 + [20] + [5] * 4 + [7]

def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda: f.read(4194304), b''): h.update(b)
    return h.hexdigest()

def load(p): return json.loads(p.read_text())
def write(p, v): p.write_text(json.dumps(v, indent=2) + '\n')

def ordered(text, *tokens):
    pos = 0
    for token in tokens: pos = text.index(token, pos) + len(token)

def retained():
    b = load(HERE / 'baseline.json')
    assert sha(ROOT / b['priorBaseline']) == b['priorBaselineSha256']
    for n, h in b['priorFiles'].items(): assert sha(ROOT / n) == h, n
    for n, a in [('README.md', 'previous-summary.md'), ('CHECKPOINT.json', 'previous-checkpoint.json')]:
        assert sha(HERE / a) == b['summaryPins'][n]
    spec = importlib.util.spec_from_file_location('pinned_phase107', OLD / 'verify_synthesis.py')
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    for r in load(HERE / 'retained-consumers.json')['consumers']:
        assert sha(ROOT / r['trace']) == r['traceSha256']
        for e in r['bodyEvidence']:
            assert sha((ROOT / r['trace']).parent / e['path']) == e['sha256']
    return dict(status='passed-hash-parity', previousRetained=m.retained(),
                phase107Files=len(b['priorFiles']), reusedDirectManagedBodies=11, readerRebuilds=0)

def checks(texts, scopes):
    chunks = [c for t in texts for c in t.split('METHOD ')[1:]]
    expected = [sig for r in load(HERE / 'il-commands.json') for sig in r['signatures']]
    assert [c.split(' |')[0] for c in chunks] == expected
    counts = [sum(l.startswith('IL_') for l in c.splitlines()) for c in chunks]
    assert counts == COUNTS
    assert [d['signature'] for d in scopes['selectedMethods']] == expected
    assert scopes['selectedMethods'][0] == load(OLD / 'next-consumer.json')['nextMetadata'][0]
    for d in scopes['selectedMethods']:
        assert d['hasBody'] and d['implementation'] == 'IL'
        assert not d['isVirtual'] and not d['isNewSlot'] and not d['isFinal']
        assert d['genericArity'] == 0 and not d['explicitOverrides']
    assert [len(scopes[k]) for k in ['directMethodOperands', 'fieldOperands', 'opaqueRuntimeOperands', 'exceptionHandlers']] == [40, 148, 19, 22]
    assert all(not r['handlers'] for r in scopes['exceptionHandlers'])
    main = chunks[0]
    ordered(main, 'IL_0001: ldstr "1.1.0"', '::m_Version', '::get_name()', '::Log(System.Object,UnityEngine.Object)', '::set_familyName(')
    for name in ['familyName', 'styleName', 'pointSize', 'scale', 'lineHeight', 'ascentLine', 'capLine', 'meanLine', 'baseline', 'descentLine', 'superscriptOffset', 'superscriptSize', 'subscriptOffset', 'subscriptSize', 'underlineOffset', 'underlineThickness', 'strikethroughOffset', 'strikethroughThickness', 'tabWidth']:
        assert f'::set_{name}(' in main
    assert main.count('::SubSize') == 2
    ordered(main, 'IL_01e9: brfalse.s IL_01f4', 'IL_01f2: brtrue.s IL_0200', 'newarr UnityEngine.Texture2D', 'IL_0208: ldfld UnityEngine.Texture2D TMPro.TMP_FontAsset::atlas', 'IL_020d: stelem.ref')
    assert 'switch IL_0278,IL_0285,IL_0292,IL_029f,IL_02c4,IL_02c4,IL_02ac,IL_02b9' in main
    for value in [4121, 4117, 4122, 4118, 16422, 32806]: assert f'ldc.i4 {value}' in main
    ordered(main, 'IL_02ca: brfalse.s IL_0305', 'IL_02d3: brfalse.s IL_0305', 'IL_02db: ldc.i4.4', 'IL_02f3: ldc.i4.7')
    ordered(main, 'IL_0319: ble.s IL_0366', 'IL_0321: brtrue.s IL_0339', 'IL_034f: callvirt System.Void System.Collections.Generic.List`1<TMPro.TMP_FontAsset>::Add(!0)', 'IL_035f: callvirt System.Int32 System.Collections.Generic.List`1<TMPro.TMP_FontAsset>::get_Count()', 'IL_0364: blt.s IL_033d')
    assert 'List`1<TMPro.TMP_FontAsset>::Clear()' not in main
    ordered(main, 'IL_0371: brtrue.s IL_038a', '::op_Inequality(System.String,System.String)', 'IL_0388: brfalse.s IL_039d', '::m_SourceFontFileGUID')
    ordered(main, 'List`1<UnityEngine.TextCore.Glyph>::Clear()', 'List`1<TMPro.TMP_Character>::Clear()', 'IL_03d2: br IL_04c8', 'IL_03e5: newobj System.Void UnityEngine.TextCore.Glyph::.ctor()', 'IL_03ed: ldc.i4.1', '::set_index(System.UInt32)', '::set_glyphRect(', '::set_metrics(', '::set_scale(', '::set_atlasIndex(', 'List`1<UnityEngine.TextCore.Glyph>::Add(!0)', 'TMP_Character::.ctor(', 'IL_04b1: ldc.i4.s 32', 'List`1<TMPro.TMP_Character>::Add(!0)')
    ordered(main, 'IL_04d4: blt IL_03d7', 'IL_04da: brtrue.s IL_0555', 'IL_04f6: ldc.i4.0', '::get_ascentLine()', 'IL_0516: ldc.r4 5', 'IL_051b: div', '::get_zero()', 'List`1<UnityEngine.TextCore.Glyph>::Add(!0)', 'IL_0546: ldc.i4.s 32', 'List`1<TMPro.TMP_Character>::Add(!0)', 'IL_0556: call System.Void TMPro.TMP_FontAsset::ReadFontAssetDefinition()', 'IL_055b: ret')
    # New accessors have exactly one field operand and no forwarded method calls.
    for c in chunks[1:16] + chunks[17:]:
        lines = [l for l in c.splitlines() if l.startswith('IL_')]
        assert sum(': stfld ' in l or ': ldfld ' in l for l in lines) == 1
        assert not any(': call' in l for l in lines)
    ctor = chunks[16]
    assert ctor.count('initobj ') == 2 and ctor.count(': stfld ') == 3
    assert ctor.count(': call ') == 1 and 'System.Object::.ctor()' in ctor
    unique = {r['definition']['signature']: r['definition'] for r in scopes['directMethodOperands']}
    assert len(unique) == 36
    assert {r['definition']['signature']: r['definition'] for r in load(HERE / 'consumer-boundaries.json')['consumers']} == unique
    assert scopes['nextDeclarations'] == load(HERE / 'next-consumer.json')['nextMetadata']
    coverage = load(HERE / 'source-trace.json')['coverage']
    for e, t in zip(coverage['exportFiles'], texts):
        assert sha(HERE / e['path']) == e['sha256']
        lines = len(t.splitlines())
        assert e['lines'] == lines
        assert [i for lo, hi in e['modelReadLineRanges'] for i in range(lo, hi + 1)] == list(range(1, lines + 1))
    assert not coverage['unreadSelectedBodyRanges']
    assert not any('Register' in l or 'TMP_ResourceManager' in l for c in chunks for l in c.splitlines() if l.startswith('IL_'))
    return dict(selectedBodies=22, instructions=sum(counts), perBodyInstructions=counts,
                fullReadCoverage=True, exportLines=595, methodOperands=40, fieldOperands=148,
                opaqueRuntimeOperands=19, handlers=0, uniqueMethodDeclarations=36,
                reusedDirectManagedBodies=11, unreadDirectManagedBodies=4,
                meaning='Exact legacy upgrade and direct metric/glyph stores only; no native/resource/rendering acceptance')

def verify(out):
    pins = retained()
    write(out / 'retained-input-verification.json', pins)
    assert subprocess.check_output(['dotnet', '--version'], text=True).strip() == '8.0.131'
    rows = load(HERE / 'il-commands.json')
    texts = []
    for filename, selected in [('font-upgrade.il', rows[:1]), ('direct-dependencies.il', rows[1:])]:
        text = ''
        for r in selected:
            run = subprocess.run(['dotnet', str(READER), str(DATA / r['assembly']), r['type'], r['selection']], capture_output=True, text=True, check=True)
            assert not run.stderr
            chunks = [c for c in run.stdout.split('METHOD ')[1:] if c.split(' |')[0] in r['signatures']]
            assert [c.split(' |')[0] for c in chunks] == r['signatures']
            text += 'TYPE ' + r['type'] + '\n' + ''.join('METHOD ' + c for c in chunks)
        (out / filename).write_text(text)
        assert sha(out / filename) == sha(HERE / filename)
        texts.append(text)
    run = subprocess.run(['dotnet', str(SCOPES), str(DATA), str(HERE / 'il-commands.json'), str(HERE / 'next-signatures.json')], capture_output=True, check=True)
    assert not run.stderr
    (out / 'dependency-scopes.json').write_bytes(run.stdout)
    assert sha(out / 'dependency-scopes.json') == sha(HERE / 'dependency-scopes.json')
    scopes = load(out / 'dependency-scopes.json')
    for r in scopes['directMethodOperands'] + scopes['fieldOperands']:
        assert sha(DATA / r['definition']['module']) == r['definition']['sha256']
    for d in scopes['selectedMethods'] + scopes['nextDeclarations']:
        assert sha(DATA / d['module']) == d['sha256']
    result = dict(status='passed-static-scoped', dotnetSDK='8.0.131', **checks(texts, scopes), retained=pins,
                  originalResourcesDecoded=0, gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0,
                  gitMutations=0, readerRebuilds=0, authoredTranslations=0, noMocks=True,
                  sourceAcceptance='needs-review', editorial='not-run', runtime='not-run', visual='not-run', delivery='needs-review', usage=None)
    write(out / 'verification.json', result)
    return result

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    out = parser.parse_args().output.resolve()
    assert HERE in out.parents and not out.exists()
    out.mkdir()
    print(json.dumps(verify(out)))
