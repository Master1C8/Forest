#!/usr/bin/env python3
"""Reproduce phase105 exact original atlas-setup IL; never invoke original code."""
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
OLD = HERE.parent / 'bio-tmp-add-character'
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
    spec = importlib.util.spec_from_file_location('phase104_pinned', OLD / 'verify_add_character.py')
    m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
    return dict(status='passed-hash-parity', previousRetained=m.retained(),
                phase104Files=len(b['priorFiles']), originalResources='hash parity only; not decoded', readerRebuilds=0)

def checks(main, deps, scopes):
    expected = [s for c in load(HERE / 'il-commands.json') for s in c['signatures']]
    chunks = (main + deps).split('METHOD ')[1:]
    assert [c.split(' |')[0] for c in chunks] == expected
    counts = [sum(l.startswith('IL_') for l in c.splitlines()) for c in chunks]
    assert counts == [71,15,14], counts
    assert [d['signature'] for d in scopes['selectedMethods']] == expected
    assert scopes['selectedMethods'][0] == load(OLD / 'next-consumer.json')['nextMetadata'][0]
    for d in scopes['selectedMethods']:
        assert d['hasBody'] and d['implementation']=='IL' and not d['isVirtual'] and not d['isNewSlot'] and not d['isFinal']
        assert d['genericArity']==0 and not d['explicitOverrides']
    assert len(scopes['directMethodOperands'])==4 and len(scopes['fieldOperands'])==22
    assert len(scopes['opaqueRuntimeOperands'])==4
    assert len(scopes['exceptionHandlers'])==3 and all(not r['handlers'] for r in scopes['exceptionHandlers'])
    ordered(main,
        'IL_0002: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasTextureIndex',
        'IL_0007: ldc.i4.1','IL_0008: add',
        'IL_0009: stfld System.Int32 TMPro.TMP_FontAsset::m_AtlasTextureIndex',
        'IL_0014: ldlen','IL_001c: bne.un.s IL_0033',
        'IL_001f: ldflda UnityEngine.Texture2D[] TMPro.TMP_FontAsset::m_AtlasTextures',
        'IL_002a: ldlen','IL_002c: ldc.i4.2','IL_002d: mul','System.Array::Resize<UnityEngine.Texture2D>',
        'IL_0033: ldarg.0','::m_AtlasTextures','::m_AtlasTextureIndex','::m_AtlasWidth','::m_AtlasHeight',
        'IL_004b: ldc.i4.1','IL_004c: ldc.i4.0','IL_004d: newobj',
        'IL_0052: stelem.ref','::m_AtlasTextures','::m_AtlasTextureIndex',
        'IL_0060: call System.Void UnityEngine.TextCore.LowLevel.FontEngine::ResetAtlasTexture(UnityEngine.Texture2D)',
        '::m_AtlasRenderMode','IL_006b: ldc.i4.s 16','IL_006d: and','IL_006e: ldc.i4.s 16',
        'IL_0070: beq.s IL_0075','IL_0072: ldc.i4.1','IL_0073: br.s IL_0076',
        'IL_0075: ldc.i4.0','IL_0076: stloc.0','::m_FreeGlyphRects','::Clear()',
        '::m_FreeGlyphRects','IL_0088: ldc.i4.0','IL_0089: ldc.i4.0','::m_AtlasWidth',
        'IL_0090: ldloc.0','IL_0091: sub','::m_AtlasHeight','IL_0098: ldloc.0','IL_0099: sub',
        'GlyphRect::.ctor(System.Int32,System.Int32,System.Int32,System.Int32)',
        '::Add(!0)','::m_UsedGlyphRects','::Clear()','IL_00af: ret')
    # One index assignment, one slot store, one return; no rollback, loops or handlers.
    assert [l for l in main.splitlines() if ': stfld ' in l] == [
        'IL_0009: stfld System.Int32 TMPro.TMP_FontAsset::m_AtlasTextureIndex']
    assert sum(': stelem.ref' in l for l in main.splitlines())==1
    assert [l for l in main.splitlines() if l.endswith(': ret')]==['IL_00af: ret']
    assert not any(x in main for x in ['add.ovf','mul.ovf','sub.ovf','::Destroy(', '::get_isReadable(', '::ReadFontAssetDefinition('])
    ordered(chunks[1], 'IL_0004: ldarg.s mipChain','IL_0006: brtrue.s IL_000b',
        'IL_0008: ldc.i4.1','IL_0009: br.s IL_000c','IL_000b: ldc.i4.m1','IL_000c: ldc.i4.0',
        'IL_000d: ldsfld System.IntPtr System.IntPtr::Zero',
        'IL_0012: call System.Void UnityEngine.Texture2D::.ctor(System.Int32,System.Int32,UnityEngine.TextureFormat,System.Int32,System.Boolean,System.IntPtr)',
        'IL_0019: ret')
    assert [l.split('::')[-1] for l in chunks[2].splitlines() if ': stfld ' in l]==['m_X','m_Y','m_Width','m_Height']
    assert not any(': call' in l for l in chunks[2].splitlines())
    unique = {r['definition']['signature']:r['definition'] for r in scopes['directMethodOperands']}
    assert {r['definition']['signature']:r['definition'] for r in load(HERE/'consumer-boundaries.json')['consumers']}==unique
    native = [d for d in unique.values() if not d['hasBody']]
    assert len(native)==1 and native[0]['implementation']=='InternalCall'
    assert native[0]['signature']=='System.Void UnityEngine.TextCore.LowLevel.FontEngine::ResetAtlasTexture(UnityEngine.Texture2D)'
    assert scopes['nextDeclarations']==load(HERE/'next-consumer.json')['nextMetadata']
    return dict(selectedBodies=3,instructions=sum(counts),perBodyInstructions=counts,fullReadCoverage=True,
                methodOperands=4,fieldOperands=22,opaqueRuntimeOperands=4,handlers=0,
                uniqueMethodDeclarations=len(unique),nativeDeclarations=len(native),newDirectManagedBodies=2,
                meaning='Exact atlas setup/rectangle mutations and constructor forwarding only; no transitive constructor/native/resource/rendering acceptance')

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
    for n,t in [('atlas-setup.il',main),('direct-dependencies.il',deps)]:
        (out/n).write_text(t);assert sha(out/n)==sha(HERE/n)
    r=subprocess.run(['dotnet',str(SCOPES),str(DATA/'Managed'),str(HERE/'il-commands.json'),str(HERE/'next-signatures.json')],capture_output=True,check=True)
    assert not r.stderr
    (out/'dependency-scopes.json').write_bytes(r.stdout);assert sha(out/'dependency-scopes.json')==sha(HERE/'dependency-scopes.json')
    scopes=load(out/'dependency-scopes.json')
    for row in scopes['directMethodOperands']+scopes['fieldOperands']:
        assert sha(DATA/'Managed'/row['definition']['module'])==row['definition']['sha256']
    for d in scopes['selectedMethods']+scopes['nextDeclarations']: assert sha(DATA/'Managed'/d['module'])==d['sha256']
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
