#!/usr/bin/env python3
"""Reproduce exact original TMP style metadata without executing game code."""
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


def body(text, signature):
    rows = [b for b in text.split('METHOD ')[1:] if b.split(' |')[0] == signature]
    assert len(rows) == 1, signature
    return rows[0]


def project(raw, signatures):
    parts = raw.decode().split('METHOD ')
    rows = [b for b in parts[1:] if b.split(' |')[0] in signatures]
    assert len(rows) == len(signatures) == len(set(signatures))
    return (parts[0] + ''.join('METHOD ' + b for b in rows)).encode()


def check_retained():
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
                target = DATA / name if group == 'installedSources' else Path(name) if Path(name).is_absolute() else ROOT / name
                check(target, expected)
            if group in x:
                groups[str(p.relative_to(ROOT)) + ':' + group] = len(x[group])
        for key in ('priorBaseline', 'inheritedBaseline'):
            if key in x:
                check(ROOT / x[key], x[key + 'Sha256'])
                walk(ROOT / x[key])

    walk(HERE / 'baseline.json')
    prior = HERE
    for name, expected in load(HERE / 'helper-pins.json').items():
        check(ROOT / name, expected)
    for name, archive in [('CHECKPOINT.json', 'previous-checkpoint.json'), ('README.md', 'previous-summary.md')]:
        check(HERE / archive, load(HERE / 'baseline.json')['summaryPins'][name])
    dlls = [p for p in files if p.parent == DATA / 'Managed' and p.suffix == '.dll']
    assert len(dlls) == 150
    assert {p.name for p in dlls} == {p.name for p in (DATA / 'Managed').glob('*.dll')}
    return dict(status='passed-hash-parity', baselineFiles=len(seen), uniqueFilesVerified=len(files), groups=groups, previousHelperPins=len(load(HERE / 'helper-pins.json')), originalResources='hashed, not decoded')


def check_metadata(texts, scopes):
    opening = texts['opening-style.il']
    ordered(opening, 'ldarg.1', 'brtrue.s IL_0005', 'ldc.i4.0', 'ret',
            '::m_TextStyleStacks', 'ldc.i4.0', '::get_hashCode()', '::Push(T)',
            '::get_styleOpeningTagArray()', 'ldlen', '::get_styleOpeningTagArray()',
            'IL_0033:', 'ldc.i4.s 92', 'IL_00bf:', 'ldc.i4.s 60',
            '::GetMarkupTagHashCode(System.Int32[],System.Int32)',
            'ldc.i4 2256', 'ldc.i4 2869039', 'ldc.i4 3288238',
            'ldc.i4 100252951', 'ldc.i4 1927738392',
            'IL_0136: ldc.i4.s 10', 'IL_0146: ldc.i4.3',
            'IL_0168: ldc.i4 160', 'IL_017b: ldc.i4.5',
            'IL_019d: ldc.i4 8203', 'IL_01b0: ldc.i4.5',
            '::ReplaceOpeningStyleTag(System.Int32[]&', 'brfalse.s IL_01dc',
            '::ReplaceClosingStyleTag(System.Int32[]&', 'ldc.i4.7',
            'IL_01dc:', 'IL_01f6: ldloc.3', '::unicode',
            'IL_0208:', 'blt IL_0033', '::m_TextStyleStackDepth', 'ldc.i4.1', 'ret')
    assert 'ldarg.2' not in opening
    assert opening.count('::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>') == 4
    assert opening.count('::unicode') == 4 and '::stringIndex' not in opening and '::length' not in opening
    ordered(opening, 'IL_0082:', 'IL_0088: ldc.i4.s 10', 'IL_0091:', 'ldc.i4.5', 'bge.s IL_00bf',
            '::GetUTF16(System.Int32[],System.Int32)', 'IL_00a8:', 'ldc.i4.s 9', 'bge.s IL_00bf',
            '::GetUTF32(System.Int32[],System.Int32)')
    for file in ['markup-hash.il', 'definition-markup-hash.il']:
        t = texts[file]
        ordered(t, 'ldc.i4.0', 'ldarg.2', 'ldc.i4.s 16', 'add',
                'ldc.i4.s 62', 'ldc.i4.s 61', 'ldc.i4.s 32',
                'ldc.i4.5', 'shl', 'add', '::ToUpperASCIIFast(System.UInt32)', 'xor',
                'starg.s readIndex', 'bge.s', 'blt.s', 'ret')
        assert 'get_Count' not in t and 'ceq' not in t and 'ldc.i4.0\n' in t
    assert '::get_Capacity()' in texts['markup-hash.il'] and '::get_Item(System.Int32)' in texts['markup-hash.il']
    assert 'ldlen' in texts['definition-markup-hash.il']
    array = texts['style-opening-array.il']
    ordered(array, '::m_OpeningTagArray', 'ret')
    assert array.count('IL_') == 3
    push = texts['style-stack-push.il']
    ordered(push, '::index', '::m_Capacity', 'bne.un.s IL_003c', 'ldc.i4.2', 'mul',
            'stfld System.Int32 TMPro.TMP_TextProcessingStack`1<T>::m_Capacity',
            'brtrue.s IL_002b', 'ldc.i4.4', '::itemStack', 'System.Array::Resize<T>',
            'IL_003c:', 'stelem.any T', '::m_RolloverSize', 'brtrue.s IL_0073',
            '::index', '::m_Count', 'ret', 'IL_0073:', 'rem', '::m_Count', 'blt.s IL_009f', 'ret')
    utf = texts['style-unicode.il']
    utf16 = body(utf, 'System.Int32 TMPro.TMP_Text::GetUTF16(System.Int32[],System.Int32)')
    utf32 = body(utf, 'System.Int32 TMPro.TMP_Text::GetUTF32(System.Int32[],System.Int32)')
    assert utf16.count('::HexToInt(System.Char)') == utf16.count('conv.u2') == 4
    assert utf32.count('::HexToInt(System.Char)') == utf32.count('conv.u2') == 8
    assert 'ConvertToUTF32' not in utf and 'ovf' not in utf
    hexcode = texts['hex-digit.il']
    ordered(hexcode, 'ldc.i4.s 48', 'switch', 'ldc.i4.s 97', 'switch', 'br.s IL_00c1',
            'IL_0088: ldc.i4.0', 'IL_00be: ldc.i4.s 15', 'IL_00c1: ldc.i4.s 15', 'ret')
    upper = texts['markup-uppercase.il']
    ordered(upper, 'conv.u8', 'System.String::get_Length()', 'conv.i8', 'ble.s IL_0013',
            'IL_0011: ldarg.0', 'IL_0012: ret', 'System.String::get_Chars(System.Int32)', 'ret')
    table = upper.split('ldstr "', 1)[1].split('"', 1)[0]
    assert len(table) == 128 and table[0] == table[ord('"')] == '-' and table[ord('a')] == 'A'
    # Derived examples corroborate integer branch constants; no original code is executed.
    examples = {}
    for name in ['br', 'nbsp', 'zwsp', 'style', '/style']:
        value = 0
        for c in name:
            value = ((value * 33) ^ ord(table[ord(c)])) & 0xffffffff
        examples[name] = value
    assert list(examples.values()) == [2256, 2869039, 3288238, 100252951, 1927738392]
    assert len(scopes['selectedMethods']) == 9 and all(m['hasBody'] for m in scopes['selectedMethods'])
    assert len(scopes['directMethodOperands']) == 29 and len(scopes['fieldOperands']) == 30
    assert len(scopes['opaqueRuntimeOperands']) == 3 and len(scopes['nextDeclarations']) == 6
    assert len(scopes['exceptionHandlers']) == 9 and all(not r['handlers'] for r in scopes['exceptionHandlers'])
    return dict(tableLength=len(table), branchHashExamples=examples,
                meaning='Derived from exact IL operations/literal; examples do not prove complete tag grammar or absence of collisions; original methods never invoked')


def verify(out):
    retained = check_retained()
    (out / 'retained-input-verification.json').write_text(json.dumps(retained, indent=2) + '\n')
    assert subprocess.check_output(['dotnet', '--version'], text=True).strip() == '8.0.131'
    build = subprocess.run(['dotnet', 'build', str(HERE / 'ExpansionScopes.csproj'), '--no-restore', '--nologo', '--verbosity', 'quiet'], capture_output=True)
    assert build.returncode == 0, build.stderr.decode() + build.stdout.decode()
    assert '<IncludeSourceRevisionInInformationalVersion>false</IncludeSourceRevisionInInformationalVersion>' in (HERE / 'ExpansionScopes.csproj').read_text()
    assert 'AssemblyInformationalVersionAttribute("1.0.0")' in (HERE / 'obj/Debug/net8.0/ExpansionScopes.AssemblyInfo.cs').read_text()
    for name, expected in load(HERE / 'helper-pins.json').items():
        assert sha(ROOT / name) == expected, name
    texts, exclusions, controls = {}, 0, 0
    for row in load(HERE / 'il-commands.json'):
        r = subprocess.run(['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'), str(DATA / 'Managed' / row['assembly']), row['type'], row['selection']], capture_output=True, check=True)
        assert not r.stderr
        if 'rawOutput' in row:
            (out / row['rawOutput']).write_bytes(r.stdout)
            assert sha(out / row['rawOutput']) == row['rawSha256'] == sha(HERE / row['rawOutput'])
            raw_sigs = [b.split(' |')[0] for b in r.stdout.decode().split('METHOD ')[1:]]
            assert [s for s in raw_sigs if s not in row['signatures']] == row['excludedSignatures']
            assert all(s in raw_sigs for s in row['signatures'])
            exclusions += len(row['excludedSignatures']); controls += 1
        data = project(r.stdout, row['signatures'])
        (out / row['output']).write_bytes(data)
        assert sha(out / row['output']) == row['sha256'] == sha(HERE / row['output'])
        texts[row['output']] = data.decode()
        assert all(s not in texts[row['output']] for s in row.get('excludedSignatures', []))
    assert controls == 3 and exclusions == 10
    r = subprocess.run(['dotnet', str(HERE / 'bin/Debug/net8.0/ExpansionScopes.dll'), str(DATA / 'Managed'), str(HERE / 'il-commands.json'), str(HERE / 'next-signatures.json')], capture_output=True, check=True)
    assert not r.stderr
    (out / 'dependency-scopes.json').write_bytes(r.stdout)
    assert sha(out / 'dependency-scopes.json') == sha(HERE / 'dependency-scopes.json')
    scopes = load(out / 'dependency-scopes.json')
    for row in scopes['directMethodOperands'] + scopes['fieldOperands']:
        assert sha(DATA / 'Managed' / row['definition']['module']) == row['definition']['sha256']
    derived = check_metadata(texts, scopes)
    (out / 'derived-hashes.json').write_text(json.dumps(derived, indent=2) + '\n')
    # Reuse the four already-read direct dependencies without rereading their bodies.
    reused = load(HERE / 'retained-consumers.json')
    for row in reused:
        assert sha(ROOT / row['bodyEvidence']) == row['bodyEvidenceSha256']
        old = load(ROOT / row['scopeEvidence'])
        prior = next(m for m in old['selectedMethods'] if m['signature'] == row['signature'])
        current = next(m['definition'] for m in scopes['directMethodOperands'] if m['definition']['signature'] == row['signature'])
        assert prior == row['definition']
        assert all(key in current and current[key] == value for key, value in prior.items())
        assert current['genericArity'] == (1 if 'ResizeInternalArray' in row['signature'] else 0)
    result = dict(status='passed-static-scoped', dotnetSDK='8.0.131', metadataSelections=len(texts),
        methodDeclarations=9, methodBodies=9, directResolvedMethodOperands=29, directResolvedFieldOperands=30,
        opaqueRuntimeOperands=3, nextPinnedDeclarations=6, exceptionHandlers=0,
        metadataDllsPinned=150, retainedUniqueFiles=retained['uniqueFilesVerified'],
        retainedPhase97Files=len(load(HERE / 'baseline.json')['priorFiles']), reusedDirectConsumerBodies=4,
        reproducedSubstantiveOutputs=len(texts)+3+3, exactProjectionControls=controls,
        projectionExclusions=exclusions,
        originalResourcesDecoded=0, originalResources='hash parity only', gameAssemblyExecuted=False,
        gameLaunches=0, imagesOpened=0, gitMutations=0, authoredTranslations=0, noMocks=True,
        sourceAcceptance='needs-review', editorial='not-run', runtime='not-run', visual='not-run', delivery='needs-review', usage=None,
        boundary='Static original metadata/IL only. Inline/closing style helpers and concrete SetArraySizes remain unread; resources, live preprocessing/styles/stacks/native calls and rendering unexecuted.')
    (out / 'verification.json').write_text(json.dumps(result, indent=2) + '\n')
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    out = parser.parse_args().output.resolve()
    assert HERE in out.parents and not out.exists()
    out.mkdir()
    print(json.dumps(verify(out)))
