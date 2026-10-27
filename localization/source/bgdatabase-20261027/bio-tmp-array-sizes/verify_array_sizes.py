#!/usr/bin/env python3
"""Reproduce the single concrete TMP array-sizing export; metadata only."""
import argparse
import hashlib
import json
import subprocess
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
OLD = HERE.parent / 'bio-tmp-backing-style-replacement'


def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for block in iter(lambda: f.read(4194304), b''):
            h.update(block)
    return h.hexdigest()


def load(p):
    return json.loads(p.read_text())


def write(p, x):
    p.write_text(json.dumps(x, indent=2) + '\n')


def retained():
    seen, files = set(), {}

    def check(p, expected):
        p = p.resolve()
        if p not in files:
            files[p] = sha(p)
        assert files[p] == expected, str(p)

    def walk(p):
        p = p.resolve()
        if p in seen:
            return
        seen.add(p)
        x = load(p)
        for group in ('inputs', 'frozenPins', 'owningHelpers', 'processReferences', 'installedSources', 'metadataPins', 'priorFiles', 'helperPins'):
            for name, expected in x.get(group, {}).items():
                check(DATA / name if group == 'installedSources' else Path(name) if Path(name).is_absolute() else ROOT / name, expected)
        for key in ('priorBaseline', 'inheritedBaseline'):
            if key in x:
                check(ROOT / x[key], x[key + 'Sha256'])
                walk(ROOT / x[key])

    walk(HERE / 'baseline.json')
    for name, archive in [('CHECKPOINT.json', 'previous-checkpoint.json'), ('README.md', 'previous-summary.md')]:
        if name in load(HERE / 'baseline.json')['summaryPins']:
            check(HERE / archive, load(HERE / 'baseline.json')['summaryPins'][name])
    dlls = [p for p in files if p.parent == DATA / 'Managed' and p.suffix == '.dll']
    assert len(dlls) == 150
    assert {p.name for p in dlls} == {p.name for p in (DATA / 'Managed').glob('*.dll')}
    # Frozen readers are executed as tools, never rebuilt in another phase's directory.
    assert sha(OLD / 'bin/Debug/net8.0/Mono.Cecil.dll') == sha(ROOT / 'tools/probe/bin/Debug/net8.0/Mono.Cecil.dll')
    return dict(status='passed-hash-parity', baselineFiles=len(seen), uniqueFilesVerified=len(files),
                metadataDllsPinned=len(dlls), phase100Files=len(load(HERE / 'baseline.json')['priorFiles']),
                originalResources='hash parity only; not decoded', readerRebuilds=0)


def ordered(text, *tokens):
    pos = 0
    for token in tokens:
        pos = text.index(token, pos) + len(token)


def checks(text, scopes):
    signature = load(HERE / 'il-commands.json')[0]['signatures'][0]
    assert [x.split(' |')[0] for x in text.split('METHOD ')[1:]] == [signature]
    assert scopes['selectedMethods'] == load(OLD / 'next-consumer.json')['nextMetadata']
    assert len(scopes['directMethodOperands']) == 106
    assert len(scopes['fieldOperands']) == 380 and len(scopes['opaqueRuntimeOperands']) == 14
    assert len(scopes['exceptionHandlers']) == 1 and not scopes['exceptionHandlers'][0]['handlers']
    instructions = [x for x in text.splitlines() if x.startswith('IL_')]
    assert len(instructions) == 1323
    assert instructions[0] == 'IL_0000: ldc.i4.0' and instructions[-1] == 'IL_0f89: ret'
    # Verify the source writes and control flow that make this more than allocation.
    ordered(text, 'IL_0004: stfld System.Int32 TMPro.TMP_Text::m_totalCharacterCount',
            '::m_FontStyleInternal', '::Clear()', 'ldc.i4 700', '::SetDefault(T)',
            '::m_currentFontAsset', '::m_currentMaterial', '::m_materialReferenceStack',
            '::AddMaterialReference(UnityEngine.Material,TMPro.TMP_FontAsset,',
            'IL_00d7: brtrue.s IL_00ec', 'IL_00e0: newobj System.Void TMPro.TMP_TextInfo::.ctor(System.Int32)',
            'IL_00ff: bge.s IL_0118', 'IL_0113: call System.Void TMPro.TMP_TextInfo::Resize<TMPro.TMP_CharacterInfo>')
    ordered(text, 'IL_0126: bne.un IL_024e', '::GetEllipsisSpecialCharacter',
            'IL_0142: brfalse IL_0220', '::get_matchMaterialPreset()',
            'IL_01ac: call UnityEngine.Material TMPro.TMP_MaterialManager::GetFallbackMaterial(UnityEngine.Material,UnityEngine.Material)',
            'IL_0219: stfld System.Int32 TMPro.MaterialReference::referenceCount',
            'IL_0220: ldarg.0', 'IL_0221: ldc.i4.3', '::m_overflowMode', '::get_warningsDisabled()')
    ordered(text, 'IL_0254: ldc.i4.6', 'IL_0263: brfalse.s IL_02a2',
            'IL_026b: brtrue.s IL_02a2', 'IL_027c: callvirt System.Void TMPro.TMP_Text::set_text(System.String)',
            'IL_0282: callvirt System.Void TMPro.TMP_Text::ClearMesh()', '::get_textInfo()',
            'IL_028d: callvirt System.Void TMPro.TMP_TextInfo::Clear()', '::get_linkedTextComponent()',
            'IL_02a0: brtrue.s IL_0276')
    ordered(text, 'IL_02c9: blt.s IL_02e4', 'IL_02df: call System.Void TMPro.TMP_TextInfo::Resize<TMPro.TMP_CharacterInfo>',
            'IL_02f8: brfalse IL_04d5', 'IL_0301: bne.un IL_04d5',
            'IL_0315: call System.Boolean TMPro.TMP_Text::ValidateHtmlTag', 'IL_031a: brfalse IL_04d5',
            'IL_032f: stloc.3', 'IL_0349: bne.un IL_0b43', 'ldc.i4 57344',
            'IL_038a: conv.u2', '::stringLength', 'IL_04d0: br IL_0b43')
    ordered(text, 'IL_0503: and', 'System.Char::IsLower', 'System.Char::ToUpper',
            'IL_0524: ldc.i4.8', 'System.Char::IsUpper', 'System.Char::ToLower',
            'IL_0545: ldc.i4.s 32', 'System.Char::IsLower', 'System.Char::ToUpper',
            'IL_0577: call TMPro.TMP_TextElement TMPro.TMP_Text::GetTextElement',
            'IL_0580: brtrue IL_073e', '::get_missingGlyphCharacter()', '::get_missingGlyphCharacter()',
            'ldc.i4 9633', 'IL_05a6: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode',
            'IL_05c6: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset',
            'IL_0601: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAssets',
            '::get_defaultFontAsset()', 'IL_062f: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset',
            'IL_0641: ldc.i4.s 32', 'IL_0646: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode',
            'IL_066f: brtrue.s IL_06a3', 'IL_0678: ldc.i4.3',
            'IL_067c: stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode',
            'IL_069c: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset',
            'IL_06a3: call System.Boolean TMPro.TMP_Settings::get_warningsDisabled()',
            'IL_06a8: brtrue IL_073e', 'IL_06dd: callvirt System.UInt32 TMPro.TMP_TextElement::get_unicode()',
            'IL_073e: ldloc.s V_10', 'IL_0740: callvirt TMPro.TextElementType TMPro.TMP_TextElement::get_elementType()')
    assert text.count('stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode') == 3
    assert 'stfld System.Int32 TMPro.TMP_Text/UnicodeChar::stringIndex' not in text
    assert 'stfld System.Int32 TMPro.TMP_Text/UnicodeChar::length' not in text
    ordered(text, 'IL_07e4: conv.u2', '::character', 'IL_0807:', '::stringIndex',
            'IL_082e:', '::length', 'IL_0861: bne.un IL_094e',
            'IL_091e: callvirt System.UInt32 TMPro.TMP_TextElement::get_glyphIndex()',
            'IL_0949: br IL_0b43', 'IL_0968: beq.s IL_09c1',
            'IL_09cc: callvirt System.Int32 UnityEngine.TextCore.Glyph::get_atlasIndex()',
            'IL_09d2: ble.s IL_0a1b', 'IL_09ed: call UnityEngine.Material TMPro.TMP_MaterialManager::GetFallbackMaterial(TMPro.TMP_FontAsset,UnityEngine.Material,System.Int32)',
            'System.Char::IsWhiteSpace', 'ldc.i4 8203', 'ldc.i4 16383',
            'IL_0a4b: bge.s IL_0a69', 'IL_0a70: newobj System.Void UnityEngine.Material::.ctor(UnityEngine.Material)',
            'IL_0b04: brfalse.s IL_0b35', 'IL_0b20:', '::m_currentFontAsset',
            'IL_0b28:', '::m_currentMaterial', 'IL_0b30:', '::m_currentMaterialIndex',
            'IL_0b47:', 'IL_0b4b: bge.s IL_0b5e', 'IL_0b59: brtrue IL_02a9',
            'IL_0b68: stfld System.Boolean TMPro.TMP_Text::m_isCalculatingPreferredValues', 'IL_0b73: ret')
    ordered(text, 'IL_0b93: stfld System.Int32 TMPro.TMP_TextInfo::materialCount',
            'IL_0bd1: call System.Int32 UnityEngine.Mathf::NextPowerOfTwo',
            'IL_0bf7: ldc.i4 256', 'IL_0bfc: ble.s IL_0c21',
            'IL_0c57: call TMPro.TMP_SubMeshUI TMPro.TMP_SubMeshUI::AddSubTextObject',
            'IL_0cb3: callvirt System.Void UnityEngine.RectTransform::set_pivot',
            'IL_0d13: callvirt System.Void TMPro.TMP_SubMeshUI::set_sharedMaterial',
            'IL_0d83: callvirt System.Void TMPro.TMP_SubMeshUI::set_fallbackMaterial',
            'IL_0df0: bge IL_0e9b', 'IL_0e29: newobj System.Void TMPro.TMP_MeshInfo::.ctor',
            'IL_0e57: newobj System.Void TMPro.TMP_MeshInfo::.ctor',
            'IL_0e7a: ldc.i4 1024', 'IL_0e94: call System.Void TMPro.TMP_MeshInfo::ResizeMeshInfo',
            'IL_0ec6: ldc.i4 256', 'IL_0efb: call System.Void TMPro.TMP_MeshInfo::ResizeMeshInfo',
            'IL_0f23: stfld UnityEngine.Material TMPro.TMP_MeshInfo::material',
            'IL_0f4a: bge.s IL_0f60', 'IL_0f5a: ldnull',
            'IL_0f5b: callvirt System.Void UnityEngine.CanvasRenderer::SetMesh(UnityEngine.Mesh)',
            'IL_0f70: bge.s IL_0f83', 'IL_0f81: brtrue.s IL_0f3b', 'IL_0f89: ret')
    assert 'GenerateTextMesh' not in text
    assert 'METHOD System.Int32 TMPro.TMP_Text::SetArraySizes' not in text
    native = {x['definition']['signature'] for x in scopes['directMethodOperands'] if not x['definition']['hasBody']}
    assert native == {'System.Int32 UnityEngine.Mathf::NextPowerOfTwo(System.Int32)',
                      'System.Void UnityEngine.CanvasRenderer::SetMesh(UnityEngine.Mesh)'}
    for row in load(HERE / 'retained-consumers.json'):
        assert sha(ROOT / row['bodyEvidence']) == row['bodyEvidenceSha256']
        assert sha(ROOT / row['scopeEvidence']) == row['scopeEvidenceSha256']
        prior = next(m for m in load(ROOT / row['scopeEvidence'])['selectedMethods'] if m['signature'] == row['signature'])
        current = next(x['definition'] for x in scopes['directMethodOperands'] if x['definition']['signature'] == row['signature'])
        assert prior == row['definition'] and all(current[k] == v for k, v in prior.items())
        assert current['genericArity'] == 0
    assert len(scopes['nextDeclarations']) == 1
    assert scopes['nextDeclarations'][0]['signature'] == load(HERE / 'next-signatures.json')[0]
    assert scopes['nextDeclarations'] == load(HERE / 'next-consumer.json')['nextMetadata']
    return dict(selectedBodies=1, instructions=len(instructions), fullReadCoverage='IL_0000 through IL_0f89; all 1325 export lines in four contiguous reads',
                methodOperands=106, fieldOperands=380, opaqueRuntimeOperands=14, handlers=0,
                uniqueMethodDeclarations=57, unicodeSourceWriteSites=3, nativeDeclarations=2,
                reusedDirectManagedBodies=3, nextUnreadBodies=1, meaning='Exact original metadata and branch/operand assertions; no original execution or runtime mocks')


def verify(out):
    pins = retained()
    write(out / 'retained-input-verification.json', pins)
    assert subprocess.check_output(['dotnet', '--version'], text=True).strip() == '8.0.131'
    row, = load(HERE / 'il-commands.json')
    r = subprocess.run(['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'),
                        str(DATA / 'Managed' / row['assembly']), row['type'], row['selection']], capture_output=True, check=True)
    assert not r.stderr
    (out / 'array-sizes.il').write_bytes(r.stdout)
    assert sha(out / 'array-sizes.il') == sha(HERE / 'array-sizes.il')
    r = subprocess.run(['dotnet', str(OLD / 'bin/Debug/net8.0/BackingScopes.dll'), str(DATA / 'Managed'),
                        str(HERE / 'il-commands.json'), str(HERE / 'next-signatures.json')], capture_output=True, check=True)
    assert not r.stderr
    (out / 'dependency-scopes.json').write_bytes(r.stdout)
    assert sha(out / 'dependency-scopes.json') == sha(HERE / 'dependency-scopes.json')
    scopes = load(out / 'dependency-scopes.json')
    for row in scopes['directMethodOperands'] + scopes['fieldOperands']:
        assert sha(DATA / 'Managed' / row['definition']['module']) == row['definition']['sha256']
    assertions = checks((out / 'array-sizes.il').read_text(), scopes)
    write(out / 'metadata-assertions.json', assertions)
    result = dict(status='passed-static-scoped', dotnetSDK='8.0.131', **assertions,
                  retainedUniqueFiles=pins['uniqueFilesVerified'], metadataDllsPinned=150, phase100Files=pins['phase100Files'],
                  originalResourcesDecoded=0, gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0,
                  gitMutations=0, readerRebuilds=0, authoredTranslations=0, noMocks=True,
                  sourceAcceptance='needs-review', editorial='not-run', runtime='not-run', visual='not-run', delivery='needs-review', usage=None,
                  boundary='Full concrete SetArraySizes caller read; new direct dependency bodies and actual input/font/material/native state remain unaccepted.')
    write(out / 'verification.json', result)
    return result


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output', type=Path, required=True)
    out = p.parse_args().output.resolve()
    assert HERE in out.parents and not out.exists()
    out.mkdir()
    print(json.dumps(verify(out)))
