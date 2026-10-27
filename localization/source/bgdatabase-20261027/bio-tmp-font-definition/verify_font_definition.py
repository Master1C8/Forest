#!/usr/bin/env python3
"""Reexport exact font-definition metadata; never load or invoke original code."""
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
OLD = HERE.parent / 'bio-tmp-atlas-setup'
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/Managed')
READER = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
SCOPES = HERE.parent / 'bio-tmp-backing-style-replacement/bin/Debug/net8.0/BackingScopes.dll'
FILES = ['font-definition.il', 'direct-dependencies.il', 'lookup-dependencies.il', 'lookup-accessors.il', 'pair-accessors.il']
GROUPS = [1, 7, 3, 6, 3]
COUNTS = [70, 7, 7, 5, 7, 7, 5, 25, 67, 63, 66, 7, 3, 3, 4, 4, 24, 3, 3, 3]

def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda: f.read(4194304), b''): h.update(b)
    return h.hexdigest()

def load(p): return json.loads(p.read_text())
def write(p, value): p.write_text(json.dumps(value, indent=2) + '\n')

def ordered(t, *tokens):
    pos = 0
    for token in tokens: pos = t.index(token, pos) + len(token)

def retained():
    b = load(HERE / 'baseline.json')
    assert sha(ROOT / b['priorBaseline']) == b['priorBaselineSha256']
    for n, h in b['priorFiles'].items(): assert sha(ROOT / n) == h, n
    for n, ar in [('README.md', 'previous-summary.md'), ('CHECKPOINT.json', 'previous-checkpoint.json')]:
        assert sha(HERE / ar) == b['summaryPins'][n], n
    spec = importlib.util.spec_from_file_location('phase105_pinned', OLD / 'verify_atlas_setup.py')
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return dict(status='passed-hash-parity', previousRetained=module.retained(),
                phase105Files=len(b['priorFiles']), readerRebuilds=0,
                originalResources='hash parity only; not decoded')

def checks(exports, scopes):
    chunks = [c for t in exports for c in t.split('METHOD ')[1:]]
    expected = [s for r in load(HERE / 'il-commands.json') for s in r['signatures']]
    assert [c.split(' |')[0] for c in chunks] == expected
    counts = [sum(l.startswith('IL_') for l in c.splitlines()) for c in chunks]
    assert counts == COUNTS, counts
    assert [d['signature'] for d in scopes['selectedMethods']] == expected
    assert scopes['selectedMethods'][0] == load(OLD / 'next-consumer.json')['nextMetadata'][0]
    for d in scopes['selectedMethods']:
        assert d['hasBody'] and d['implementation'] == 'IL'
        assert not d['isVirtual'] and not d['isNewSlot'] and not d['isFinal']
        assert d['genericArity'] == 0 and not d['explicitOverrides']
    assert len(scopes['directMethodOperands']) == 29
    assert len(scopes['fieldOperands']) == 78
    assert len(scopes['opaqueRuntimeOperands']) == 31
    assert len(scopes['exceptionHandlers']) == 20
    assert all(not r['handlers'] for r in scopes['exceptionHandlers'])
    main, dispatcher, scaleget, scaleset, strikeget, capget, strikeset, hashbody, glyph, char, pair = chunks[:11]
    ordered(main, '::op_Inequality(', 'IL_000c: brfalse.s IL_0021', 'System.String::IsNullOrEmpty(',
            'IL_0019: brfalse.s IL_0021', '::UpgradeFontAsset()', '::InitializeDictionaryLookupTables()',
            '::AddSynthesizedCharactersAndFaceMetrics()', '::get_scale()', 'IL_003d: bne.un.s IL_004f',
            'IL_0045: ldc.r4 1', '::set_scale(', '::get_strikethroughOffset()',
            'IL_005f: bne.un.s IL_007d', '::get_capLine()', 'IL_0072: ldc.r4 2.5', 'IL_0077: div',
            '::set_strikethroughOffset(', '::m_AtlasPadding', 'IL_0083: brtrue.s IL_00b0',
            '::HasProperty(', 'IL_0095: brfalse.s IL_00b0', '::GetFloat(',
            'IL_00a8: conv.i4', 'IL_00a9: ldc.i4.1', 'IL_00aa: sub',
            'IL_00ab: stfld System.Int32 TMPro.TMP_FontAsset::m_AtlasPadding',
            '::get_name()', '::GetSimpleHashCode(', '::hashCode', '::get_name()',
            '::s_DefaultMaterialSuffix', 'System.String::Concat(', '::GetSimpleHashCode(',
            '::materialHashCode', 'IL_00dd: ldc.i4.0',
            'IL_00de: stfld System.Boolean TMPro.TMP_FontAsset::IsFontAssetLookupTablesDirty', 'IL_00e3: ret')
    assert sum('::get_name()' in l for l in main.splitlines() if l.startswith('IL_')) == 2
    assert [l for l in dispatcher.splitlines() if ': call ' in l] == [
        'IL_0001: call System.Void TMPro.TMP_FontAsset::InitializeGlyphLookupDictionary()',
        'IL_0007: call System.Void TMPro.TMP_FontAsset::InitializeCharacterLookupDictionary()',
        'IL_000d: call System.Void TMPro.TMP_FontAsset::InitializeGlyphPaidAdjustmentRecordsLookupDictionary()']
    for t, field in [(scaleget,'m_Scale'), (strikeget,'m_StrikethroughOffset'), (capget,'m_CapLine')]:
        assert sum(': ldfld ' in l for l in t.splitlines()) == 1 and '::' + field in t
        assert not any(': call' in l or ': stfld ' in l for l in t.splitlines())
    for t, field in [(scaleset,'m_Scale'), (strikeset,'m_StrikethroughOffset')]:
        assert sum(': stfld ' in l for l in t.splitlines()) == 1 and '::' + field in t
        assert not any(': call' in l for l in t.splitlines())
    ordered(hashbody, 'IL_0000: ldc.i4.0', 'IL_0004: br.s IL_0018', 'IL_0007: ldc.i4.5',
            'IL_0008: shl', 'IL_000a: add', 'System.String::get_Chars(', 'IL_0012: xor',
            'IL_0015: ldc.i4.1', 'IL_0016: add', 'System.String::get_Length()', 'IL_001f: blt.s IL_0006')
    assert not any(x in hashbody for x in ['ToUpper', 'ToLower', 'add.ovf'])
    ordered(glyph, '::m_GlyphLookupDictionary', 'IL_0006: brtrue.s IL_0015', '::.ctor()', '::Clear()',
            '::m_GlyphIndexList', 'IL_0026: brtrue.s IL_0035', '::.ctor()', '::Clear()',
            '::m_GlyphIndexListNewlyAdded', 'IL_0046: brtrue.s IL_0055', '::.ctor()', '::Clear()',
            '::m_GlyphTable', '::get_Count()', 'IL_006b: stloc.0', '::get_Item(', '::get_index()',
            '::ContainsKey(', 'IL_0090: brtrue.s IL_00ab', '::Add(!0,!1)', '::m_GlyphIndexList',
            '::Add(!0)', 'IL_00af: ldloc.1', 'IL_00b0: ldloc.0', 'IL_00b1: blt.s IL_0070')
    assert sum('::get_Count()' in l for l in glyph.splitlines() if l.startswith('IL_')) == 1
    ordered(char, '::m_CharacterLookupDictionary', '::Clear()', '::m_CharacterTable', '::get_Item(',
            '::get_unicode()', '::get_glyphIndex()', '::ContainsKey(', 'IL_004b: brtrue.s IL_0073',
            '::Add(!0,!1)', '::set_textAsset(', '::m_GlyphLookupDictionary', '::get_Item(!0)',
            '::set_glyph(', 'IL_0077: ldloc.0', '::m_CharacterTable', '::get_Count()',
            'IL_0083: blt.s IL_0024', '::FallbackSearchQueryLookup', 'IL_008b: brtrue.s IL_0099',
            '::.ctor()', '::FallbackSearchQueryLookup', 'IL_0098: ret', '::Clear()', 'IL_00a4: ret')
    ordered(pair, '::m_KerningTable', 'IL_0006: brfalse.s IL_002e', '::kerningPairs',
            'IL_0013: brfalse.s IL_002e', '::get_Count()', 'IL_0026: ble.s IL_002e',
            '::UpgradeGlyphAdjustmentTableToFontFeatureTable()', '::m_FontFeatureTable',
            '::m_GlyphPairAdjustmentRecordLookupDictionary', 'IL_0039: brtrue.s IL_004d',
            '::.ctor()', '::Clear()', '::m_GlyphPairAdjustmentRecords', 'IL_0068: stloc.0',
            'IL_006a: brfalse.s IL_00b6', '::get_Item(', 'GlyphPairKey::.ctor(', 'GlyphPairKey::key',
            '::ContainsKey(', 'IL_0095: brtrue.s IL_00a9', '::Add(!0,!1)',
            'IL_00ad: ldloc.1', 'IL_00ae: ldloc.0', '::get_Count()', 'IL_00b4: blt.s IL_0070')
    for t, field in zip(chunks[11:16], ['m_Index','m_Unicode','m_GlyphIndex','m_TextAsset','m_Glyph']):
        assert '::' + field in t and not any(': call' in l for l in t.splitlines())
    key = chunks[16]
    ordered(key, '::get_firstAdjustmentRecord()', '::get_glyphIndex()', '::firstGlyphIndex',
            '::get_secondAdjustmentRecord()', '::get_glyphIndex()', '::secondGlyphIndex',
            'IL_002a: ldfld System.UInt32 TMPro.GlyphPairKey::secondGlyphIndex',
            'IL_002f: ldc.i4.s 16', 'IL_0031: shl', '::firstGlyphIndex', 'IL_0038: or', '::key')
    assert not any(x in key for x in ['and', 'ovf', 'throw'])
    for t, field in zip(chunks[17:], ['m_FirstAdjustmentRecord','m_SecondAdjustmentRecord','m_GlyphIndex']):
        assert '::' + field in t and not any(': call' in l for l in t.splitlines())
    # Scope absence only: unread callees may register or mutate global/native state.
    assert not any('Register' in l or 'TMP_ResourceManager' in l for t in chunks for l in t.splitlines() if l.startswith('IL_'))
    unique = {r['definition']['signature']: r['definition'] for r in scopes['directMethodOperands']}
    assert {r['definition']['signature']:r['definition'] for r in load(HERE/'consumer-boundaries.json')['consumers']} == unique
    native = [d for d in unique.values() if not d['hasBody']]
    assert len(native) == 1 and native[0]['implementation'] == 'InternalCall'
    assert native[0]['signature'] == 'System.Boolean UnityEngine.Material::HasProperty(System.Int32)'
    assert scopes['nextDeclarations'] == load(HERE/'next-consumer.json')['nextMetadata']
    return dict(selectedBodies=len(counts), instructions=sum(counts), perBodyInstructions=counts,
                fullReadCoverage=True, methodOperands=29, fieldOperands=78, opaqueRuntimeOperands=31,
                handlers=0, uniqueMethodDeclarations=len(unique), nativeDeclarations=1,
                meaning='Exact definition, ordered dictionary rebuilds, accessors and key/hash arithmetic; unread callees/native/resource/rendering remain open')

def verify(out):
    pins = retained()
    write(out/'retained-input-verification.json', pins)
    assert subprocess.check_output(['dotnet','--version'], text=True).strip() == '8.0.131'
    rows = load(HERE/'il-commands.json')
    exports = []
    pos = 0
    for filename, size in zip(FILES, GROUPS):
        text = ''
        for row in rows[pos:pos+size]:
            r = subprocess.run(['dotnet',str(READER),str(DATA/row['assembly']),row['type'],row['selection']],
                               capture_output=True, text=True, check=True)
            assert not r.stderr
            chunks = [c for c in r.stdout.split('METHOD ')[1:] if c.split(' |')[0] in row['signatures']]
            assert [c.split(' |')[0] for c in chunks] == row['signatures']
            text += 'TYPE '+row['type']+'\n'+''.join('METHOD '+c for c in chunks)
        pos += size
        (out/filename).write_text(text)
        assert sha(out/filename) == sha(HERE/filename), filename
        exports.append(text)
    assert pos == len(rows)
    r = subprocess.run(['dotnet',str(SCOPES),str(DATA),str(HERE/'il-commands.json'),str(HERE/'next-signatures.json')],
                       capture_output=True, check=True)
    assert not r.stderr
    (out/'dependency-scopes.json').write_bytes(r.stdout)
    assert sha(out/'dependency-scopes.json') == sha(HERE/'dependency-scopes.json')
    scopes = load(out/'dependency-scopes.json')
    for row in scopes['directMethodOperands'] + scopes['fieldOperands']:
        assert sha(DATA/row['definition']['module']) == row['definition']['sha256']
    for d in scopes['selectedMethods'] + scopes['nextDeclarations']:
        assert sha(DATA/d['module']) == d['sha256']
    assertions = checks(exports, scopes)
    write(out/'metadata-assertions.json', assertions)
    result = dict(status='passed-static-scoped', dotnetSDK='8.0.131', **assertions, retained=pins,
                  originalResourcesDecoded=0, gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0,
                  gitMutations=0, readerRebuilds=0, authoredTranslations=0, noMocks=True,
                  sourceAcceptance='needs-review', editorial='not-run', runtime='not-run', visual='not-run',
                  delivery='needs-review', usage=None)
    write(out/'verification.json', result)
    return result

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    out = parser.parse_args().output.resolve()
    assert HERE in out.parents and not out.exists()
    out.mkdir()
    print(json.dumps(verify(out)))
