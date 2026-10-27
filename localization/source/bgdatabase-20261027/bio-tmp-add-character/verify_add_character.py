#!/usr/bin/env python3
"""Reproduce phase104 exact original IL/declarations; never invoke original code."""
import argparse
import hashlib
import importlib.util
import json
import subprocess
import sys
from pathlib import Path
sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
OLD = HERE.parent / 'bio-tmp-font-character-internal'
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
READER = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
SCOPES = HERE.parent / 'bio-tmp-backing-style-replacement/bin/Debug/net8.0/BackingScopes.dll'

def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda: f.read(4194304), b''): h.update(b)
    return h.hexdigest()
def load(p): return json.loads(p.read_text())
def write(p, x): p.write_text(json.dumps(x, indent=2) + '\n')
def ordered(t, *tokens):
    pos = 0
    for token in tokens: pos = t.index(token, pos) + len(token)

def retained():
    b = load(HERE / 'baseline.json')
    assert sha(ROOT / b['priorBaseline']) == b['priorBaselineSha256']
    for n, h in b['priorFiles'].items(): assert sha(ROOT / n) == h, n
    for n, a in [('README.md','previous-summary.md'), ('CHECKPOINT.json','previous-checkpoint.json')]:
        assert sha(HERE / a) == b['summaryPins'][n], n
    spec = importlib.util.spec_from_file_location('phase103_pinned', OLD / 'verify_character_internal.py')
    m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
    prior = m.retained()
    return dict(status='passed-hash-parity', previousRetained=prior, phase103Files=len(b['priorFiles']),
                originalResources='hash parity only; not decoded', readerRebuilds=0)

def checks(main, deps, scopes):
    commands = load(HERE / 'il-commands.json')
    expected = [s for c in commands for s in c['signatures']]
    chunks = (main + deps).split('METHOD ')[1:]
    assert [c.split(' |')[0] for c in chunks] == expected
    counts = [sum(l.startswith('IL_') for l in c.splitlines()) for c in chunks]
    assert counts == [285,3,7,8,22,161,5], counts
    assert [d['signature'] for d in scopes['selectedMethods']] == expected
    assert scopes['selectedMethods'][0] == load(OLD / 'next-consumer.json')['nextMetadata'][0]
    for d in scopes['selectedMethods']:
        assert d['hasBody'] and d['implementation']=='IL' and not d['isVirtual'] and not d['isNewSlot'] and not d['isFinal']
        assert d['genericArity']==0 and not d['explicitOverrides']
    assert len(scopes['directMethodOperands'])==39 and len(scopes['fieldOperands'])==64
    assert len(scopes['opaqueRuntimeOperands'])==27
    assert len(scopes['exceptionHandlers'])==7 and all(not r['handlers'] for r in scopes['exceptionHandlers'])
    lines = main.splitlines()
    assert [l for l in lines if ': stind.ref' in l] == ['IL_0002: stind.ref','IL_0097: stind.ref','IL_01d7: stind.ref','IL_0289: stind.ref']
    # Every normal return is the expected literal, and all nonnull output stores
    # occur only on paths leading to true; exceptions are not false returns.
    returns = [lines[i-1] for i,l in enumerate(lines) if l.endswith(': ret')]
    assert returns == ['IL_0011: ldc.i4.0','IL_002b: ldc.i4.0','IL_0073: ldc.i4.0','IL_00b3: ldc.i4.1','IL_011e: ldc.i4.0','IL_0218: ldc.i4.1','IL_02ca: ldc.i4.1','IL_02cc: ldc.i4.0']
    ordered(main,'IL_0000: ldarg.2','IL_0001: ldnull','IL_0002: stind.ref',
            '::m_MissingUnicodesFromFontFile','::Contains(!0)','IL_000f: brfalse.s IL_0013','IL_0012: ret',
            '::get_sourceFontFile()','FaceInfo::get_pointSize()','FontEngine::LoadFontFace(',
            'IL_0029: brfalse.s IL_002d','IL_002c: ret','FontEngine::GetGlyphIndex(',
            'IL_0035: brtrue.s IL_0075','IL_0038: ldc.i4 160','IL_003d: beq.s IL_0051',
            'IL_0040: ldc.i4 173','IL_0045: beq.s IL_005b','IL_0048: ldc.i4 8209','IL_004d: beq.s IL_005b',
            'IL_0051: ldc.i4.s 32','IL_005b: ldc.i4.s 45','IL_0064: brtrue.s IL_0075',
            '::m_MissingUnicodesFromFontFile','::Add(!0)','IL_0072: pop','IL_0074: ret',
            '::m_GlyphLookupDictionary','::ContainsKey(!0)','IL_0081: brfalse.s IL_00b5',
            'IL_0092: newobj','IL_0097: stind.ref','::m_CharacterTable','::Add(!0)',
            '::m_CharacterLookupDictionary','::Add(!0,!1)','IL_00b4: ret',
            'Texture::get_isReadable()','IL_00c9: brtrue.s IL_0120','Debug::LogWarning(','IL_011f: ret',
            'Texture::get_width()','IL_0132: brfalse.s IL_0148','Texture::get_height()',
            'IL_0146: brtrue.s IL_0179','Texture2D::Resize(','IL_0166: pop','FontEngine::ResetAtlasTexture(',
            'IL_0180: ldc.i4.0','FontEngine::TryAddGlyphToTexture(','IL_01a7: brfalse.s IL_021a',
            'Glyph::set_atlasIndex(','::m_GlyphTable','::m_GlyphLookupDictionary',
            'IL_01d2: newobj','IL_01d7: stind.ref','::m_CharacterTable','::m_CharacterLookupDictionary',
            '::m_GlyphIndexList','::m_GlyphIndexListNewlyAdded','TMP_Settings::get_getFontFeaturesAtRuntime()',
            'IL_0210: brfalse.s IL_0218','::RegisterFontAssetForFontFeatureUpdate(','IL_0219: ret',
            '::m_IsMultiAtlasTexturesEnabled','IL_0220: brfalse IL_02cc','::SetupNewAtlasTexture()',
            'IL_0232: ldc.i4.0','FontEngine::TryAddGlyphToTexture(','IL_0259: brfalse.s IL_02cc',
            'Glyph::set_atlasIndex(','::m_GlyphTable','::m_GlyphLookupDictionary',
            'IL_0284: newobj','IL_0289: stind.ref','::m_CharacterTable','::m_CharacterLookupDictionary',
            '::m_GlyphIndexList','::m_GlyphIndexListNewlyAdded','TMP_Settings::get_getFontFeaturesAtRuntime()',
            'IL_02c2: brfalse.s IL_02ca','::RegisterFontAssetForFontFeatureUpdate(','IL_02cb: ret','IL_02cd: ret')
    assert not any(': '+op in main for op in ('stfld ','stsfld ','conv.u2'))
    wrapper = next(c for c in chunks if c.startswith('System.Boolean UnityEngine.TextCore.LowLevel.FontEngine::TryAddGlyphToTexture('))
    ordered(wrapper, '::get_Count()', '::get_Count()', 'IL_0012: add', '::s_FreeGlyphRects','::s_UsedGlyphRects',
            'IL_0034: add','Mathf::NextPowerOfTwo(', 'IL_0043: stsfld','IL_004f: stsfld','Mathf::Max(',
            'IL_00b2: brtrue.s IL_0062','FontEngine::TryAddGlyphToTexture_Internal(',
            'IL_00d4: brfalse.s IL_0152','Glyph::.ctor(', 'IL_00e0: stind.ref','::Clear()', '::Clear()',
            'Mathf::Max(', 'IL_014b: brtrue.s IL_00fd','IL_014d: ldc.i4.1',
            'IL_0152: ldarg.s glyph','IL_0154: ldnull','IL_0155: stind.ref','IL_0156: ldc.i4.0','IL_015d: ret')
    ordered(chunks[3], 'FontEngine::LoadFontFace_With_Size_FromFont_Internal(', 'IL_000c: ret')
    ordered(chunks[4], 'TMP_TextElement::.ctor()', '::m_ElementType', '::set_unicode(', '::set_textAsset(',
            '::set_glyph(', 'Glyph::get_index()', '::set_glyphIndex(', 'IL_002f: ldc.r4 1', '::set_scale(')
    assert scopes['nextDeclarations'] == load(HERE / 'next-consumer.json')['nextMetadata']
    unique = {r['definition']['signature']:r['definition'] for r in scopes['directMethodOperands']}
    boundaries = load(HERE / 'consumer-boundaries.json')
    assert {r['definition']['signature']:r['definition'] for r in boundaries['consumers']} == unique
    native = [d for d in unique.values() if not d['hasBody']]
    assert len(native)==6 and all(d['implementation']=='InternalCall' for d in native)
    return dict(selectedBodies=7, instructions=sum(counts), perBodyInstructions=counts, fullReadCoverage=True,
                methodOperands=39,fieldOperands=64,opaqueRuntimeOperands=27,handlers=0,
                uniqueMethodDeclarations=len(unique),nativeDeclarations=len(native),newDirectManagedBodies=6,
                meaning='Exact dynamic character-add/output and direct wrapper boundary only; no native/resource/rendering acceptance')

def verify(out):
    pins=retained();write(out/'retained-input-verification.json',pins)
    assert subprocess.check_output(['dotnet','--version'],text=True).strip()=='8.0.131'
    exports=[]
    for row in load(HERE/'il-commands.json'):
        r=subprocess.run(['dotnet',str(READER),str(DATA/'Managed'/row['assembly']),row['type'],row['selection']],capture_output=True,text=True,check=True)
        assert not r.stderr
        chunks=[c for c in r.stdout.split('METHOD ')[1:] if c.split(' |')[0] in row['signatures']]
        assert [c.split(' |')[0] for c in chunks]==row['signatures']
        exports.append('TYPE '+row['type']+'\n'+''.join('METHOD '+c for c in chunks))
    main,deps=exports[0],''.join(exports[1:])
    for n,t in [('add-character.il',main),('direct-dependencies.il',deps)]:
        (out/n).write_text(t);assert sha(out/n)==sha(HERE/n)
    r=subprocess.run(['dotnet',str(SCOPES),str(DATA/'Managed'),str(HERE/'il-commands.json'),str(HERE/'next-signatures.json')],capture_output=True,check=True)
    assert not r.stderr
    (out/'dependency-scopes.json').write_bytes(r.stdout);assert sha(out/'dependency-scopes.json')==sha(HERE/'dependency-scopes.json')
    scopes=load(out/'dependency-scopes.json')
    for row in scopes['directMethodOperands']+scopes['fieldOperands']:
        assert sha(DATA/'Managed'/row['definition']['module'])==row['definition']['sha256']
    assertions=checks(main,deps,scopes);write(out/'metadata-assertions.json',assertions)
    result=dict(status='passed-static-scoped',dotnetSDK='8.0.131',**assertions,retained=pins,
                originalResourcesDecoded=0,gameAssemblyExecuted=False,gameLaunches=0,imagesOpened=0,
                gitMutations=0,readerRebuilds=0,authoredTranslations=0,noMocks=True,
                sourceAcceptance='needs-review',editorial='not-run',runtime='not-run',visual='not-run',delivery='needs-review',usage=None)
    write(out/'verification.json',result);return result
if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--output',required=True,type=Path)
    out=parser.parse_args().output.resolve();assert HERE in out.parents and not out.exists();out.mkdir()
    print(json.dumps(verify(out)))
