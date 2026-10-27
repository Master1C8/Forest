#!/usr/bin/env python3
"""Reproduce bounded original TMP lookup metadata; never execute game assemblies."""
import argparse
import hashlib
import json
import subprocess
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
OLD = HERE.parent / 'bio-tmp-array-sizes'
READER = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
SCOPES = HERE.parent / 'bio-tmp-backing-style-replacement/bin/Debug/net8.0/BackingScopes.dll'


def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda: f.read(4194304), b''):
            h.update(b)
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
    baseline = load(HERE / 'baseline.json')
    for n, arc in [('README.md', 'previous-summary.md'), ('CHECKPOINT.json', 'previous-checkpoint.json')]:
        check(HERE / arc, baseline['summaryPins'][n])
    dlls = [p for p in files if p.parent == DATA / 'Managed' and p.suffix == '.dll']
    assert len(dlls) == 150
    assert {p.name for p in dlls} == {p.name for p in (DATA / 'Managed').glob('*.dll')}
    assert sha(SCOPES.parent / 'Mono.Cecil.dll') == sha(READER.parent / 'Mono.Cecil.dll')
    return dict(status='passed-hash-parity', baselineFiles=len(seen), uniqueFilesVerified=len(files),
                metadataDllsPinned=150, phase101Files=len(baseline['priorFiles']), readerRebuilds=0,
                originalResources='hash parity only; not decoded')


def ordered(t, *tokens):
    pos = 0
    for token in tokens:
        pos = t.index(token, pos) + len(token)


def sections(t):
    return {s.split(' |')[0]: s.splitlines()[1:] for s in t.split('METHOD ')[1:]}


def checks(main, direct, scopes):
    commands = load(HERE / 'il-commands.json')
    expected = [s for c in commands for s in c['signatures']]
    bodies = sections(main + direct)
    assert list(bodies) == expected and len(bodies) == 4
    assert scopes['selectedMethods'][0] == load(OLD / 'next-consumer.json')['nextMetadata'][0]
    assert [r['signature'] for r in scopes['selectedMethods']] == expected
    for d in scopes['selectedMethods']:
        assert d['hasBody'] and not d['isVirtual'] and not d['isNewSlot'] and not d['isFinal']
        assert d['genericArity'] == 0 and not d['explicitOverrides']
    assert len(scopes['directMethodOperands']) == 25 and len(scopes['fieldOperands']) == 27
    assert len(scopes['opaqueRuntimeOperands']) == 11
    assert len(scopes['exceptionHandlers']) == 4 and all(not h['handlers'] for h in scopes['exceptionHandlers'])
    counts = [sum(s.startswith('IL_') for s in bodies[sig]) for sig in expected]
    assert counts == [152, 17, 60, 10], counts
    ordered(main, 'IL_0002: ldc.i4.0', 'IL_0008: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset(',
            'IL_000f: brfalse.s IL_0013', 'IL_0014: ldfld', 'IL_0027: ble.s IL_003d', 'IL_0031: ldc.i4.1',
            'IL_0037: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAssets(',
            'IL_003e: brfalse.s IL_0042', 'IL_0043: callvirt System.Int32 TMPro.TMP_Asset::get_instanceID()',
            'IL_004e: callvirt System.Int32 TMPro.TMP_Asset::get_instanceID()', 'IL_0053: beq.s IL_00c8',
            'IL_005c: ldc.i4.0', 'IL_0062: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset(',
            'IL_0069: brfalse.s IL_008a', 'IL_006c: ldc.i4.0', 'IL_006d: stfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex',
            'IL_0073: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences', 'IL_0078: ldc.i4.0',
            'IL_0079: ldelema TMPro.MaterialReference', 'IL_007e: ldfld UnityEngine.Material TMPro.MaterialReference::material',
            'IL_0083: stfld UnityEngine.Material TMPro.TMP_Text::m_currentMaterial', 'IL_0089: ret',
            'IL_00aa: ldarg.1', 'IL_00ab: ldarg.2', 'IL_00ad: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_fontAsset',
            'IL_00b2: ldfld System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_FontAsset::m_FallbackFontAssetTable',
            'IL_00b7: ldc.i4.1', 'IL_00bd: call', 'IL_00c4: brfalse.s IL_00c8',
            'IL_00cf: call System.Boolean UnityEngine.Object::op_Inequality', 'IL_00dd: ldc.i4.1',
            'IL_00de: call TMPro.TMP_SpriteCharacter TMPro.TMP_FontAssetUtilities::GetSpriteCharacterFromSpriteAsset(',
            'IL_00e9: call System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_Settings::get_fallbackFontAssets()',
            'IL_00fb: ble.s IL_0110', 'IL_00fd: ldarg.1', 'IL_00fe: ldarg.2', 'IL_0104: ldc.i4.1',
            'IL_010a: call', 'IL_0111: brfalse.s IL_0115', 'IL_0115: call TMPro.TMP_FontAsset TMPro.TMP_Settings::get_defaultFontAsset()',
            'IL_0120: brfalse.s IL_0134', 'IL_0128: ldc.i4.1', 'IL_012e: call', 'IL_0135: brfalse.s IL_0139',
            'IL_0139: call TMPro.TMP_SpriteAsset TMPro.TMP_Settings::get_defaultSpriteAsset()', 'IL_0144: brfalse.s IL_0158',
            'IL_014c: ldc.i4.1', 'IL_014d: call', 'IL_0154: brfalse.s IL_0158', 'IL_0158: ldnull', 'IL_0159: ret')
    stores = [s for s in main.splitlines() if ': stfld ' in s]
    assert len(stores) == 2 and all('m_currentMaterial' in s for s in stores)
    assert 'stind.' not in main and 'conv.u2' not in main and 'UnicodeChar::' not in main
    a, b, c = ['\n'.join(bodies[s]) for s in expected[1:]]
    ordered(a, 'IL_0001: brfalse.s IL_0020', '::k_SearchedAssets', 'IL_0008: brtrue.s IL_0016',
            'IL_000a: newobj', 'IL_000f: stsfld', 'IL_0014: br.s IL_0020', 'IL_001b: callvirt',
            'IL_0028: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset_Internal(', 'IL_002d: ret')
    assert 'stind.' not in a
    ordered(b, 'IL_0000: ldarg.s isAlternativeTypeface', 'IL_0002: ldc.i4.0', 'IL_0003: stind.i1',
            'IL_0005: brfalse.s IL_000f', 'IL_000d: brtrue.s IL_0011', 'IL_000f: ldnull', 'IL_0010: ret',
            'IL_0012: brfalse.s IL_0031', 'IL_0020: stsfld', 'IL_002c: callvirt',
            'IL_0032: callvirt', 'IL_0037: stloc.0', 'IL_003e: callvirt', 'IL_0046: call System.Boolean UnityEngine.Object::op_Equality',
            'IL_004b: brtrue.s IL_0073', 'IL_004d: ldarg.1', 'IL_004e: ldfld System.Collections.Generic.HashSet`1<System.Int32> TMPro.TMP_FontAsset::FallbackSearchQueryLookup',
            'IL_0054: callvirt System.Int32 TMPro.TMP_Asset::get_instanceID()', 'IL_0059: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Int32>::Add(!0)',
            'IL_005e: pop', 'IL_0068: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset_Internal(',
            'IL_006f: brfalse.s IL_0073', 'IL_0072: ret', 'IL_0079: blt.s IL_003c', 'IL_007b: ldnull', 'IL_007c: ret')
    ordered(c, '::m_InstanceID', 'IL_0006: brtrue.s IL_0014', 'IL_000a: call System.Int32 UnityEngine.Object::GetInstanceID()',
            'IL_000f: stfld System.Int32 TMPro.TMP_Asset::m_InstanceID', 'IL_0015: ldfld', 'IL_001a: ret')
    for row in load(HERE / 'retained-consumers.json'):
        assert sha(ROOT / row['bodyEvidence']) == row['bodyEvidenceSha256']
        assert sha(ROOT / row['scopeEvidence']) == row['scopeEvidenceSha256']
        prior = next(d for d in load(ROOT / row['scopeEvidence'])['selectedMethods'] if d['signature'] == row['signature'])
        current = next(d['definition'] for d in scopes['directMethodOperands'] if d['definition']['signature'] == row['signature'])
        assert prior == current == row['definition']
    assert scopes['nextDeclarations'] == load(HERE / 'next-consumer.json')['nextMetadata']
    assert [d['signature'] for d in scopes['nextDeclarations']] == load(HERE / 'next-signatures.json')
    consumers = load(HERE / 'consumer-boundaries.json')
    unique = {(d['definition']['module'], d['definition']['signature']) for d in scopes['directMethodOperands']}
    assert len(unique) == consumers['directUniqueDeclarations'] == 11
    assert unique == {(d['definition']['module'], d['definition']['signature']) for d in consumers['consumers']}
    return dict(selectedBodies=4, instructions=sum(counts), perBodyInstructions=counts, fullReadCoverage=True,
                methodOperands=25, fieldOperands=27, opaqueRuntimeOperands=11, handlers=0,
                uniqueMethodDeclarations=11, reusedDirectManagedBodies=2, nextUnreadFontBodies=1,
                meaning='Four full managed bodies and exact declarations; not transitive body, native or rendering acceptance')


def verify(out):
    pins = retained()
    write(out / 'retained-input-verification.json', pins)
    assert subprocess.check_output(['dotnet', '--version'], text=True).strip() == '8.0.131'
    results = []
    for row in load(HERE / 'il-commands.json'):
        r = subprocess.run(['dotnet', str(READER), str(DATA / 'Managed' / row['assembly']), row['type'], row['selection']], capture_output=True, text=True, check=True)
        assert not r.stderr
        chunks = r.stdout.split('METHOD ')[1:]
        chosen = [c for c in chunks if c.split(' |')[0] in row['signatures']]
        assert len(chosen) == len(row['signatures'])
        results.append('TYPE ' + row['type'] + '\n' + ''.join('METHOD ' + c for c in chosen))
    for n, t in [('text-element.il', results[0]), ('direct-font-utilities.il', ''.join(results[1:]))]:
        (out / n).write_text(t)
        assert sha(out / n) == sha(HERE / n), n
    r = subprocess.run(['dotnet', str(SCOPES), str(DATA / 'Managed'), str(HERE / 'il-commands.json'), str(HERE / 'next-signatures.json')], capture_output=True, check=True)
    assert not r.stderr
    (out / 'dependency-scopes.json').write_bytes(r.stdout)
    assert sha(out / 'dependency-scopes.json') == sha(HERE / 'dependency-scopes.json')
    scopes = load(out / 'dependency-scopes.json')
    for r in scopes['directMethodOperands'] + scopes['fieldOperands']:
        assert sha(DATA / 'Managed' / r['definition']['module']) == r['definition']['sha256']
    assertions = checks(results[0], ''.join(results[1:]), scopes)
    write(out / 'metadata-assertions.json', assertions)
    result = dict(status='passed-static-scoped', dotnetSDK='8.0.131', **assertions,
                  retainedUniqueFiles=pins['uniqueFilesVerified'], metadataDllsPinned=150, phase101Files=pins['phase101Files'],
                  originalResourcesDecoded=0, gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0,
                  gitMutations=0, readerRebuilds=0, authoredTranslations=0, noMocks=True,
                  sourceAcceptance='needs-review', editorial='not-run', runtime='not-run', visual='not-run', delivery='needs-review', usage=None,
                  boundary='Lookup order, material reset, shared search state and ID-cache writes read; internal character selection, sprite/settings/native state and actual glyph/rendering remain unaccepted.')
    write(out / 'verification.json', result)
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    out = parser.parse_args().output.resolve()
    assert HERE in out.parents and not out.exists()
    out.mkdir()
    print(json.dumps(verify(out)))
