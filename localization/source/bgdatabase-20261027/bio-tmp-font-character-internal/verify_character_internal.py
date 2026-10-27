#!/usr/bin/env python3
"""Reproduce phase103 exact original TMP metadata; never execute game code."""
import argparse
import hashlib
import json
import subprocess
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
OLD = HERE.parent / 'bio-tmp-text-element'
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
            for n, h in x.get(group, {}).items():
                check(DATA / n if group == 'installedSources' else Path(n) if Path(n).is_absolute() else ROOT / n, h)
        for k in ('priorBaseline', 'inheritedBaseline'):
            if k in x:
                check(ROOT / x[k], x[k + 'Sha256'])
                walk(ROOT / x[k])

    walk(HERE / 'baseline.json')
    baseline = load(HERE / 'baseline.json')
    for n, a in [('README.md', 'previous-summary.md'), ('CHECKPOINT.json', 'previous-checkpoint.json')]:
        check(HERE / a, baseline['summaryPins'][n])
    dlls = [p for p in files if p.parent == DATA / 'Managed' and p.suffix == '.dll']
    assert len(dlls) == 150
    assert {p.name for p in dlls} == {p.name for p in (DATA / 'Managed').glob('*.dll')}
    assert sha(SCOPES.parent / 'Mono.Cecil.dll') == sha(READER.parent / 'Mono.Cecil.dll')
    return dict(status='passed-hash-parity', baselineFiles=len(seen), uniqueFilesVerified=len(files),
                metadataDllsPinned=150, phase102Files=len(baseline['priorFiles']), readerRebuilds=0,
                originalResources='hash parity only; not decoded')


def ordered(t, *tokens):
    pos = 0
    for token in tokens:
        pos = t.index(token, pos) + len(token)


def checks(main, accessors, enums, scopes):
    expected = [s for c in load(HERE / 'il-commands.json') for s in c['signatures']]
    chunks = (main + accessors).split('METHOD ')[1:]
    assert [c.split(' |')[0] for c in chunks] == expected
    counts = [sum(l.startswith('IL_') for l in c.splitlines()) for c in chunks]
    assert counts == [210, 3, 8, 3, 3], counts
    assert [d['signature'] for d in scopes['selectedMethods']] == expected
    assert scopes['selectedMethods'][0] == load(OLD / 'next-consumer.json')['nextMetadata'][0]
    for d in scopes['selectedMethods']:
        assert d['hasBody'] and not d['isVirtual'] and not d['isNewSlot'] and not d['isFinal']
        assert d['genericArity'] == 0 and not d['explicitOverrides'] and d['implementation'] == 'IL'
    assert len(scopes['directMethodOperands']) == 14 and len(scopes['fieldOperands']) == 9
    assert len(scopes['opaqueRuntimeOperands']) == 6
    assert len(scopes['exceptionHandlers']) == 5 and all(not h['handlers'] for h in scopes['exceptionHandlers'])
    # Assert exact branch operands, not just counts or method-name presence.
    ordered(main, 'IL_0000: ldarg.s isAlternativeTypeface', 'IL_0002: ldc.i4.0', 'IL_0003: stind.i1',
            'IL_0006: ldarg.3', 'IL_0007: ldc.i4.2', 'IL_0008: and', 'IL_000a: ceq',
            'IL_000e: brtrue.s IL_001c', 'IL_0012: ldc.i4 400', 'IL_0017: beq IL_0115',
            'IL_001d: callvirt TMPro.TMP_FontWeightPair[] TMPro.TMP_FontAsset::get_fontWeightTable()',
            'IL_0023: ldc.i4.4', 'IL_0024: stloc.3')
    for off, op in [('0096', 'ldc.i4.1'), ('009a', 'ldc.i4.2'), ('009e', 'ldc.i4.3'), ('00a2', 'ldc.i4.4'),
                    ('00a6', 'ldc.i4.5'), ('00aa', 'ldc.i4.6'), ('00ae', 'ldc.i4.7'), ('00b2', 'ldc.i4.8'), ('00b6', 'ldc.i4.s 9')]:
        assert 'IL_' + off + ': ' + op in main
    for value, target in [(100, '0096'), (200, '009a'), (300, '009e'), (400, '00a2'), (500, '00a6'),
                          (600, '00aa'), (700, '00ae'), (800, '00b2'), (900, '00b6')]:
        needle = ('ldc.i4.s ' if value == 100 else 'ldc.i4 ') + str(value)
        # Locate an equality branch immediately following the matching literal.
        lines = main.splitlines()
        assert any(needle == l.split(': ', 1)[-1] and lines[i + 1].endswith('beq.s IL_' + target)
                   for i, l in enumerate(lines[:-1]))
    ordered(main, 'IL_00ba: brtrue.s IL_00ca', 'IL_00be: ldelema TMPro.TMP_FontWeightPair',
            '::regularTypeface', 'IL_00c8: br.s IL_00d6', 'IL_00cc: ldelema TMPro.TMP_FontWeightPair',
            '::italicTypeface', 'IL_00db: call System.Boolean UnityEngine.Object::op_Inequality',
            'IL_00e0: brfalse.s IL_0115', 'IL_00e4: callvirt', 'IL_00ec: callvirt',
            'IL_00f1: brfalse.s IL_00f9', 'IL_00f5: ldc.i4.1', 'IL_00f6: stind.i1', 'IL_00f8: ret',
            'IL_00fb: callvirt TMPro.AtlasPopulationMode', 'IL_0100: ldc.i4.1', 'IL_0101: bne.un.s IL_0115',
            'IL_0108: callvirt System.Boolean TMPro.TMP_FontAsset::TryAddCharacterInternal(',
            'IL_010d: brfalse.s IL_0115', 'IL_0111: ldc.i4.1', 'IL_0112: stind.i1', 'IL_0114: ret',
            'IL_0116: callvirt', 'IL_011e: callvirt', 'IL_0123: brfalse.s IL_0127', 'IL_0126: ret',
            'IL_0128: callvirt TMPro.AtlasPopulationMode', 'IL_012d: ldc.i4.1', 'IL_012e: bne.un.s IL_013d',
            'IL_0134: callvirt System.Boolean TMPro.TMP_FontAsset::TryAddCharacterInternal(',
            'IL_0139: brfalse.s IL_013d', 'IL_013c: ret', 'IL_013d: ldloc.0', 'IL_013e: ldnull',
            'IL_013f: ceq', 'IL_0141: ldarg.2', 'IL_0142: and', 'IL_0143: brfalse.s IL_01c3',
            'IL_0146: callvirt', 'IL_014b: brfalse.s IL_01c3', 'IL_014e: callvirt',
            'IL_0157: callvirt', 'IL_015c: stloc.s V_6', 'IL_0160: brtrue.s IL_0164', 'IL_0163: ret',
            'IL_0177: call System.Boolean UnityEngine.Object::op_Equality', 'IL_017c: brtrue.s IL_01b7',
            'IL_0180: callvirt System.Int32 TMPro.TMP_Asset::get_instanceID()', 'IL_0187: ldsfld',
            'IL_018e: callvirt', 'IL_0193: brfalse.s IL_01b7', 'IL_0196: ldfld', 'IL_019d: callvirt',
            'IL_01a2: pop', 'IL_01a3: ldarg.0', 'IL_01a4: ldloc.s V_8', 'IL_01a6: ldc.i4.1',
            'IL_01a7: ldarg.3', 'IL_01a8: ldarg.s fontWeight', 'IL_01aa: ldarg.s isAlternativeTypeface',
            'IL_01ac: call ' + expected[0], 'IL_01b3: brfalse.s IL_01b7', 'IL_01b6: ret',
            'IL_01c1: blt.s IL_0169', 'IL_01c3: ldnull', 'IL_01c4: ret')
    assert sum(': stind.i1' in l for l in main.splitlines()) == 3
    assert not any(': ' + op in main for op in ('stfld ', 'stsfld ', 'conv.u2', 'ldstr '))
    ordered(accessors, '::m_AtlasPopulationMode', '::get_characterLookupTable()', '::m_CharacterLookupDictionary',
            'IL_0006: brtrue.s IL_000e', 'IL_0009: call System.Void TMPro.TMP_FontAsset::ReadFontAssetDefinition()',
            'IL_000f: ldfld', 'IL_0014: ret', '::get_fallbackFontAssetTable()', '::m_FallbackFontAssetTable',
            '::get_fontWeightTable()', '::m_FontWeightTable')
    assert 'TMPro.FontStyles::Italic = 2' in enums and 'TMPro.AtlasPopulationMode::Dynamic = 1' in enums
    for r in load(HERE / 'retained-consumers.json'):
        assert sha(ROOT / r['bodyEvidence']) == r['bodyEvidenceSha256']
        assert sha(ROOT / r['scopeEvidence']) == r['scopeEvidenceSha256']
        old = next(d for d in load(ROOT / r['scopeEvidence'])['selectedMethods'] if d['signature'] == r['signature'])
        current = next(d['definition'] for d in scopes['directMethodOperands'] if d['definition']['signature'] == r['signature'])
        assert current == old == r['definition']
    assert scopes['nextDeclarations'] == load(HERE / 'next-consumer.json')['nextMetadata']
    unique = {(r['definition']['module'], r['definition']['signature']) for r in scopes['directMethodOperands']}
    consumers = load(HERE / 'consumer-boundaries.json')
    assert len(unique) == consumers['directUniqueDeclarations'] == 10
    assert unique == {(r['definition']['module'], r['definition']['signature']) for r in consumers['consumers']}
    return dict(selectedBodies=5, instructions=227, perBodyInstructions=counts, fullReadCoverage=True,
                methodOperands=14, fieldOperands=9, opaqueRuntimeOperands=6, handlers=0,
                uniqueMethodDeclarations=10, reusedDirectManagedBodies=3, unreadDirectManagedBodies=2,
                meaning='Exact selection/getter bodies; not dictionary initialization, glyph addition, native or rendering acceptance')


def verify(out):
    pins = retained()
    write(out / 'retained-input-verification.json', pins)
    assert subprocess.check_output(['dotnet', '--version'], text=True).strip() == '8.0.131'
    exports = []
    for row in load(HERE / 'il-commands.json'):
        r = subprocess.run(['dotnet', str(READER), str(DATA / 'Managed' / row['assembly']), row['type'], row['selection']], capture_output=True, text=True, check=True)
        assert not r.stderr
        chunks = [c for c in r.stdout.split('METHOD ')[1:] if c.split(' |')[0] in row['signatures']]
        assert [c.split(' |')[0] for c in chunks] == row['signatures']
        exports.append('TYPE ' + row['type'] + '\n' + ''.join('METHOD ' + c for c in chunks))
    for name, text in zip(('character-internal.il', 'font-accessors.il'), exports):
        (out / name).write_text(text)
        assert sha(out / name) == sha(HERE / name)
    r = subprocess.run(['dotnet', str(SCOPES), str(DATA / 'Managed'), str(HERE / 'il-commands.json'), str(HERE / 'next-signatures.json')], capture_output=True, check=True)
    assert not r.stderr
    (out / 'dependency-scopes.json').write_bytes(r.stdout)
    assert sha(out / 'dependency-scopes.json') == sha(HERE / 'dependency-scopes.json')
    parts = []
    for t in ('TMPro.FontStyles', 'TMPro.AtlasPopulationMode'):
        r = subprocess.run(['dotnet', str(READER), str(DATA / 'Managed/Unity.TextMeshPro.dll'), t, '--fields'], capture_output=True, text=True, check=True)
        assert not r.stderr
        parts.append(r.stdout)
    enums = ''.join(parts)
    (out / 'selection-enums.txt').write_text(enums)
    assert sha(out / 'selection-enums.txt') == sha(HERE / 'selection-enums.txt')
    scopes = load(out / 'dependency-scopes.json')
    for r in scopes['directMethodOperands'] + scopes['fieldOperands']:
        assert sha(DATA / 'Managed' / r['definition']['module']) == r['definition']['sha256']
    assertions = checks(*exports, enums, scopes)
    write(out / 'metadata-assertions.json', assertions)
    result = dict(status='passed-static-scoped', dotnetSDK='8.0.131', **assertions,
                  retainedUniqueFiles=pins['uniqueFilesVerified'], metadataDllsPinned=150, phase102Files=pins['phase102Files'],
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
