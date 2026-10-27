#!/usr/bin/env python3
"""Reproduce bounded TMP inline-style metadata; never execute original game code."""
import argparse
import hashlib
import json
import subprocess
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')


def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for block in iter(lambda: f.read(4194304), b''):
            h.update(block)
    return h.hexdigest()


def load(p):
    return json.loads(p.read_text())


def ordered(text, *tokens):
    pos = 0
    for token in tokens:
        pos = text.index(token, pos) + len(token)


def project(raw, signatures):
    parts = raw.decode().split('METHOD ')
    rows = [b for b in parts[1:] if b.split(' |')[0] in signatures]
    assert len(rows) == len(signatures) == len(set(signatures))
    return (parts[0] + ''.join('METHOD ' + b for b in rows)).encode()


def retained():
    seen, files, groups = set(), {}, {}

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
            if group in x:
                groups[str(p.relative_to(ROOT)) + ':' + group] = len(x[group])
        for key in ('priorBaseline', 'inheritedBaseline'):
            if key in x:
                check(ROOT / x[key], x[key + 'Sha256'])
                walk(ROOT / x[key])

    walk(HERE / 'baseline.json')
    for name, expected in load(HERE / 'helper-pins.json').items():
        check(ROOT / name, expected)
    for name, archive in [('CHECKPOINT.json', 'previous-checkpoint.json'), ('README.md', 'previous-summary.md')]:
        check(HERE / archive, load(HERE / 'baseline.json')['summaryPins'][name])
    dlls = [p for p in files if p.parent == DATA / 'Managed' and p.suffix == '.dll']
    assert len(dlls) == 150
    assert {p.name for p in dlls} == {p.name for p in (DATA / 'Managed').glob('*.dll')}
    return dict(status='passed-hash-parity', baselineFiles=len(seen), uniqueFilesVerified=len(files), groups=groups,
                metadataDllsPinned=len(dlls), originalResources='hash parity only; not decoded')


def metadata_checks(texts, scopes):
    opening, closing, value, pop, array = [texts[n] for n in ['inline-opening.il', 'inline-closing.il', 'inline-value-hash.il', 'style-stack-pop.il', 'style-closing-array.il']]
    ordered(opening, 'IL_0003: ldc.i4.7', 'IL_0004: add', '::GetStyleHashCode(System.Int32[]&',
            '::GetStyle(System.Int32)', 'IL_0015: brfalse.s IL_001b', 'IL_0018: ldind.i4',
            'IL_0019: brtrue.s IL_001d', 'IL_001b: ldc.i4.0', 'IL_001c: ret',
            'IL_001d:', '::m_TextStyleStackDepth', 'IL_0024: ldc.i4.1', 'IL_0025: add',
            '::m_TextStyleStacks', '::m_TextStyleStackDepth', '::get_hashCode()', '::Push(T)',
            '::get_styleOpeningTagArray()', 'ldlen', '::get_styleOpeningTagArray()',
            'IL_0269:', 'blt IL_005f', 'IL_0271:', '::m_TextStyleStackDepth',
            'IL_0278: ldc.i4.1', 'IL_0279: sub', '::m_TextStyleStackDepth', 'ldc.i4.1', 'ret')
    assert opening.count('::Push(T)') == 1 and '::Pop()' not in opening
    ordered(closing, '::m_TextStyleStacks', '::m_TextStyleStackDepth', 'IL_000c: ldc.i4.1',
            'IL_000d: add', '::Pop()', '::GetStyle(System.Int32)', 'brtrue.s IL_0025',
            'IL_0024: ret', 'IL_0025:', '::m_TextStyleStackDepth', 'ldc.i4.1', 'add',
            '::get_styleClosingTagArray()', 'ldlen', '::get_styleClosingTagArray()',
            'IL_0247:', 'blt IL_004b', 'IL_024f:', '::m_TextStyleStackDepth',
            'IL_0256: ldc.i4.1', 'IL_0257: sub', '::m_TextStyleStackDepth', 'ret')
    assert 'ldarg.1' not in closing and 'ldarg.2' not in closing
    for text, fallback, tail, callopen, callclose in [
        (opening, 'IL_0237', 'IL_0263', 'IL_0214', 'IL_022a'),
        (closing, 'IL_0218', 'IL_0241', 'IL_01f6', 'IL_020b')]:
        assert text.count('::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>') == 4
        assert text.count('stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode') == 4
        assert '::stringIndex' not in text and '::length' not in text
        assert text.count('::GetUTF16(System.Int32[],System.Int32)') == 1
        assert text.count('::GetUTF32(System.Int32[],System.Int32)') == 1
        ordered(text, 'ldc.i4.s 92', 'ldc.i4.s 85', 'ldc.i4.s 92', 'ldc.i4.s 110',
                'ldc.i4.s 114', 'switch', 'ldc.i4.5', '::GetUTF16', 'ldc.i4.s 9', '::GetUTF32',
                'ldc.i4.s 60', '::GetMarkupTagHashCode(System.Int32[],System.Int32)',
                'ldc.i4 2256', 'ldc.i4 2869039', 'ldc.i4 3288238',
                'ldc.i4 100252951', 'ldc.i4 1927738392',
                'ldc.i4.s 10', '::unicode', 'ldc.i4.3',
                'ldc.i4 160', '::unicode', 'ldc.i4.5',
                'ldc.i4 8203', '::unicode', 'ldc.i4.5',
                callopen + ': call System.Boolean TMPro.TMP_Text::ReplaceOpeningStyleTag(System.Int32[]&',
                'brfalse.s ' + fallback, callclose + ': call System.Void TMPro.TMP_Text::ReplaceClosingStyleTag(System.Int32[]&',
                'ldc.i4.7', fallback + ':', '::unicode', tail + ':', 'ldc.i4.1', 'add')
        assert 'ovf' not in text
    ordered(value, 'IL_0000: ldc.i4.0', 'IL_0002: ldarg.3', 'ldc.i4.0', 'stind.i4',
            'IL_0005: ldarg.2', 'IL_0007: br.s IL_0033',
            'ldc.i4.s 34', 'beq.s IL_002f', 'ldc.i4.s 62', 'bne.un.s IL_001e',
            'ldarg.3', 'ldloc.1', 'stind.i4', 'br.s IL_003a',
            'IL_001e:', 'ldc.i4.5', 'shl', 'add', 'conv.u2',
            '::ToUpperASCIIFast(System.Char)', 'xor', 'IL_002f:',
            'IL_0033:', 'ldlen', 'blt.s IL_0009', 'IL_003a:', 'ret')
    assert 'ldc.i4.s 16' not in value and 'ldc.i4.s 32' not in value and 'ldc.i4.s 61' not in value
    ordered(pop, '::index', 'brtrue.s IL_001a', '::m_RolloverSize', 'brtrue.s IL_001a',
            'initobj T', 'ret', 'IL_001a:', '::m_RolloverSize', 'brtrue.s IL_0032',
            '::index', 'ldc.i4.1', 'sub', 'stfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::index',
            'IL_0032:', '::index', 'ldc.i4.1', 'sub', '::m_RolloverSize', 'rem',
            'IL_004f: blt.s IL_0059', 'IL_0059:', '::m_RolloverSize', 'add',
            'IL_006b:', 'ldelem.any T', '::m_DefaultItem', 'stelem.any T',
            '::m_Count', 'bgt.s IL_00a0', 'ldc.i4.0', 'IL_00a0:', '::m_Count', 'ldc.i4.1', 'sub', '::m_Count', 'ret')
    ordered(array, '::m_ClosingTagArray', 'ret')
    assert array.count('IL_') == 3
    assert len(scopes['selectedMethods']) == 5 and all(x['hasBody'] for x in scopes['selectedMethods'])
    assert len(scopes['directMethodOperands']) == 29 and len(scopes['fieldOperands']) == 42
    assert not scopes['opaqueRuntimeOperands']
    assert len(scopes['exceptionHandlers']) == 5 and all(not x['handlers'] for x in scopes['exceptionHandlers'])
    assert len(scopes['nextDeclarations']) == 5
    concrete = scopes['nextDeclarations'][-1]
    assert concrete['isVirtual'] and not concrete['isNewSlot'] and concrete['hasBody']
    return dict(selectedBodies=5, methodOperands=29, fieldOperands=42, handlers=0,
                meaning='Exact original IL order/branch/operand checks; no grammar or runtime mocks, no original code executed')


def verify(out):
    pins = retained()
    (out / 'retained-input-verification.json').write_text(json.dumps(pins, indent=2) + '\n')
    assert subprocess.check_output(['dotnet', '--version'], text=True).strip() == '8.0.131'
    assert sha(HERE / 'bin/Debug/net8.0/Mono.Cecil.dll') == load(HERE / 'helper-pins.json')['tools/probe/bin/Debug/net8.0/Mono.Cecil.dll']
    build = subprocess.run(['dotnet', 'build', str(HERE / 'InlineScopes.csproj'), '--no-restore', '--nologo', '--verbosity', 'quiet'], capture_output=True)
    assert build.returncode == 0, build.stdout.decode() + build.stderr.decode()
    assert '<IncludeSourceRevisionInInformationalVersion>false</IncludeSourceRevisionInInformationalVersion>' in (HERE / 'InlineScopes.csproj').read_text()
    assert 'AssemblyInformationalVersionAttribute("1.0.0")' in (HERE / 'obj/Debug/net8.0/InlineScopes.AssemblyInfo.cs').read_text()
    for name, expected in load(HERE / 'helper-pins.json').items():
        assert sha(ROOT / name) == expected, name
    texts, controls, exclusions = {}, 0, 0
    for row in load(HERE / 'il-commands.json'):
        r = subprocess.run(['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'), str(DATA / 'Managed' / row['assembly']), row['type'], row['selection']], capture_output=True, check=True)
        assert not r.stderr
        if 'rawOutput' in row:
            (out / row['rawOutput']).write_bytes(r.stdout)
            assert sha(out / row['rawOutput']) == row['rawSha256'] == sha(HERE / row['rawOutput'])
            sigs = [x.split(' |')[0] for x in r.stdout.decode().split('METHOD ')[1:]]
            assert all(s in sigs for s in row['signatures'])
            assert [s for s in sigs if s not in row['signatures']] == row['excludedSignatures']
            controls += 1; exclusions += len(row['excludedSignatures'])
        data = project(r.stdout, row['signatures'])
        (out / row['output']).write_bytes(data)
        assert sha(out / row['output']) == row['sha256'] == sha(HERE / row['output'])
        texts[row['output']] = data.decode()
        assert all(s not in texts[row['output']] for s in row.get('excludedSignatures', []))
    assert controls == exclusions == 3
    r = subprocess.run(['dotnet', str(HERE / 'bin/Debug/net8.0/InlineScopes.dll'), str(DATA / 'Managed'), str(HERE / 'il-commands.json'), str(HERE / 'next-signatures.json')], capture_output=True, check=True)
    assert not r.stderr
    (out / 'dependency-scopes.json').write_bytes(r.stdout)
    assert sha(out / 'dependency-scopes.json') == sha(HERE / 'dependency-scopes.json')
    scopes = load(out / 'dependency-scopes.json')
    for row in scopes['directMethodOperands'] + scopes['fieldOperands']:
        assert sha(DATA / 'Managed' / row['definition']['module']) == row['definition']['sha256']
    checks = metadata_checks(texts, scopes)
    (out / 'metadata-assertions.json').write_text(json.dumps(checks, indent=2) + '\n')
    reused = load(HERE / 'retained-consumers.json')
    for row in reused:
        assert sha(ROOT / row['bodyEvidence']) == row['bodyEvidenceSha256']
        prior = next(m for m in load(ROOT / row['scopeEvidence'])['selectedMethods'] if m['signature'] == row['signature'])
        current = next(m['definition'] for m in scopes['directMethodOperands'] if m['definition']['signature'] == row['signature'])
        assert prior == row['definition']
        assert all(k in current and current[k] == v for k, v in prior.items())
        assert current['genericArity'] == (1 if 'ResizeInternalArray' in row['signature'] else 0)
    selected = {m['signature'] for m in scopes['selectedMethods']}
    assert len(reused) == 9
    assert {m['definition']['signature'] for m in scopes['directMethodOperands']} - selected == {r['signature'] for r in reused}
    result = dict(status='passed-static-scoped', dotnetSDK='8.0.131', metadataSelections=5, methodDeclarations=5,
                  methodBodies=5, directResolvedMethodOperands=29, directResolvedFieldOperands=42,
                  opaqueRuntimeOperands=0, exceptionHandlers=0, nextPinnedDeclarations=5,
                  metadataDllsPinned=150, retainedUniqueFiles=pins['uniqueFilesVerified'],
                  retainedPhase98Files=len(load(HERE / 'baseline.json')['priorFiles']), reusedDirectConsumerBodies=9,
                  exactProjectionControls=controls, projectionExclusions=exclusions, reproducedSubstantiveOutputs=11,
                  originalResourcesDecoded=0, originalResources='hash parity only', gameAssemblyExecuted=False,
                  gameLaunches=0, imagesOpened=0, gitMutations=0, authoredTranslations=0, noMocks=True,
                  sourceAcceptance='needs-review', editorial='not-run', runtime='not-run', visual='not-run', delivery='needs-review', usage=None,
                  boundary='Static original IL/metadata only; actual style/hash/stack/recursion/resources/native/rendering state unknown. Backing/InsertClosingStyleTag/concrete SetArraySizes bodies remain unread.')
    (out / 'verification.json').write_text(json.dumps(result, indent=2) + '\n')
    return result


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output', type=Path, required=True)
    out = p.parse_args().output.resolve()
    assert HERE in out.parents and not out.exists()
    out.mkdir()
    print(json.dumps(verify(out)))
