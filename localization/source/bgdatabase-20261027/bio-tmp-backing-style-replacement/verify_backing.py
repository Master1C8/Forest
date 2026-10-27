#!/usr/bin/env python3
"""Reproduce bounded TMP backing-style metadata; never execute original game code."""
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
    opening, closing, value, insert = [texts[n] for n in ['backing-opening.il', 'backing-closing.il', 'backing-value-hash.il', 'insert-closing.il']]
    previous = HERE.parent / 'bio-tmp-inline-style-replacement'
    instructions = lambda s: '\n'.join(line for line in s.splitlines() if line.startswith('IL_'))
    oldopen = (previous / 'inline-opening.il').read_text()
    oldclose = (previous / 'inline-closing.il').read_text()
    substitution = '::GetStyleHashCode(System.Int32[]&'
    replacement = '::GetStyleHashCode(TMPro.TMP_Text/TextBackingContainer&'
    assert instructions(oldopen).count(substitution) == 1
    assert instructions(opening) == instructions(oldopen).replace(substitution, replacement)
    assert instructions(closing) == instructions(oldclose)
    ordered(opening, 'ldc.i4.7', 'add', replacement, '::GetStyle(System.Int32)', 'brfalse.s IL_001b',
            'ldind.i4', 'brtrue.s IL_001d', 'ldc.i4.0', 'ret', '::m_TextStyleStackDepth',
            '::Push(T)', '::get_styleOpeningTagArray()', '::get_styleOpeningTagArray()',
            'IL_0271:', '::m_TextStyleStackDepth', 'sub', '::m_TextStyleStackDepth', 'ldc.i4.1', 'ret')
    assert '::Pop()' not in opening
    assert 'ldarg.1' not in closing and 'ldarg.2' not in closing
    ordered(closing, '::m_TextStyleStackDepth', 'ldc.i4.1', 'add', '::Pop()', '::GetStyle(System.Int32)',
            'brtrue.s IL_0025', 'IL_0024: ret', '::m_TextStyleStackDepth', '::get_styleClosingTagArray()')
    ordered(value, 'IL_0000: ldc.i4.0', 'IL_0002: ldarg.3', 'ldc.i4.0', 'stind.i4', 'ldarg.2',
            'br.s IL_003c', '::get_Item(System.Int32)', 'ldc.i4.s 34', 'beq.s IL_0038',
            '::get_Item(System.Int32)', 'ldc.i4.s 62', 'bne.un.s IL_0024',
            'ldarg.3', 'ldloc.1', 'stind.i4', 'br.s IL_0045', 'IL_0024:',
            'ldc.i4.5', 'shl', 'add', '::get_Item(System.Int32)', 'conv.u2',
            '::ToUpperASCIIFast(System.Char)', 'xor', 'IL_0038:', 'ldc.i4.1', 'add',
            'IL_003c:', '::get_Capacity()', 'blt.s IL_0009', 'IL_0045:', 'ret')
    assert value.count('::get_Item(System.Int32)') == 3 and value.count('::get_Capacity()') == 1
    for absent in ['::get_Count()', 'ldc.i4.s 16', 'ldc.i4.s 32', 'ldc.i4.s 61', 'ldlen', '::set_Item']:
        assert absent not in value
    ordered(insert, '::m_TextStyleStacks', 'IL_0006: ldc.i4.0', 'ldelema', '::Pop()',
            '::GetStyle(System.Int32)', 'IL_0019: dup', '::get_styleClosingTagArray()',
            'ldlen', '::get_styleClosingTagArray()', 'IL_0028: ldc.i4.0', 'IL_002a: br IL_01f3',
            'IL_002f:', 'IL_01f3:', 'blt IL_002f', 'IL_01fa: ldarg.0', 'ldc.i4.0',
            'stfld System.Int32 TMPro.TMP_Text::m_TextStyleStackDepth', 'IL_0201: ret')
    assert insert.count('::m_TextStyleStackDepth') == 1 and insert.count('::Pop()') == 1
    prefix = insert[:insert.index('IL_002f:')]
    assert 'brfalse' not in prefix and 'brtrue' not in prefix and prefix.count('ret') == 0
    assert '::Push(T)' not in insert and insert.count('::get_styleClosingTagArray()') == 2
    for text, fallback, tail, callopen, callclose in [
        (opening, 'IL_0237', 'IL_0263', 'IL_0214', 'IL_022a'),
        (closing, 'IL_0218', 'IL_0241', 'IL_01f6', 'IL_020b'),
        (insert, 'IL_01ca', 'IL_01ef', 'IL_01ad', 'IL_01bf')]:
        assert text.count('::ResizeInternalArray<TMPro.TMP_Text/UnicodeChar>') == 4
        assert text.count('stfld System.Int32 TMPro.TMP_Text/UnicodeChar::unicode') == 4
        assert '::stringIndex' not in text and '::length' not in text and 'ovf' not in text
        ordered(text, 'ldc.i4.s 92', 'ldc.i4.s 85', 'ldc.i4.s 92', 'ldc.i4.s 110',
                'ldc.i4.s 114', 'switch', 'ldc.i4.5', '::GetUTF16(System.Int32[],System.Int32)',
                'ldc.i4.s 9', '::GetUTF32(System.Int32[],System.Int32)', 'ldc.i4.s 60',
                '::GetMarkupTagHashCode(System.Int32[],System.Int32)',
                'ldc.i4 2256', 'ldc.i4 2869039', 'ldc.i4 3288238', 'ldc.i4 100252951', 'ldc.i4 1927738392',
                'ldc.i4.s 10', '::unicode', 'ldc.i4.3', 'ldc.i4 160', '::unicode', 'ldc.i4.5',
                'ldc.i4 8203', '::unicode', 'ldc.i4.5',
                callopen + ': call System.Boolean TMPro.TMP_Text::ReplaceOpeningStyleTag(System.Int32[]&',
                'brfalse.s ' + fallback, callclose + ': call System.Void TMPro.TMP_Text::ReplaceClosingStyleTag(System.Int32[]&',
                'ldc.i4.7', fallback + ':', '::unicode', tail + ':', 'ldc.i4.1', 'add')
    assert len(scopes['selectedMethods']) == 4 and all(x['hasBody'] for x in scopes['selectedMethods'])
    assert len(scopes['directMethodOperands']) == 46 and len(scopes['fieldOperands']) == 26
    assert not scopes['opaqueRuntimeOperands']
    assert len(scopes['exceptionHandlers']) == 4 and all(not x['handlers'] for x in scopes['exceptionHandlers'])
    assert len(scopes['nextDeclarations']) == 1
    concrete = scopes['nextDeclarations'][0]
    assert concrete['signature'] == 'System.Int32 TMPro.TextMeshProUGUI::SetArraySizes(TMPro.TMP_Text/UnicodeChar[])'
    assert concrete['isVirtual'] and not concrete['isNewSlot'] and concrete['hasBody']
    return dict(selectedBodies=4, methodOperands=46, fieldOperands=26, handlers=0, emissionSites=12,
                comparisonControls={'opening': 'All IL instructions equal retained inline opening except exact backing value-hash operand',
                                    'closing': 'All IL instructions equal retained inline closing; different declaration'},
                meaning='Original exact IL/metadata/branch/operand checks; no original execution or runtime mocks')


def verify(out):
    pins = retained()
    (out / 'retained-input-verification.json').write_text(json.dumps(pins, indent=2) + '\n')
    assert subprocess.check_output(['dotnet', '--version'], text=True).strip() == '8.0.131'
    assert sha(HERE / 'bin/Debug/net8.0/Mono.Cecil.dll') == load(HERE / 'helper-pins.json')['tools/probe/bin/Debug/net8.0/Mono.Cecil.dll']
    build = subprocess.run(['dotnet', 'build', str(HERE / 'BackingScopes.csproj'), '--no-restore', '--nologo', '--verbosity', 'quiet'], capture_output=True)
    assert build.returncode == 0, build.stdout.decode() + build.stderr.decode()
    assert '<IncludeSourceRevisionInInformationalVersion>false</IncludeSourceRevisionInInformationalVersion>' in (HERE / 'BackingScopes.csproj').read_text()
    assert 'AssemblyInformationalVersionAttribute("1.0.0")' in (HERE / 'obj/Debug/net8.0/BackingScopes.AssemblyInfo.cs').read_text()
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
        declarations = [b.split(' |')[0] for b in texts[row['output']].split('METHOD ')[1:]]
        assert declarations == row['signatures']
        assert all(s not in declarations for s in row.get('excludedSignatures', []))
    assert controls == exclusions == 3
    r = subprocess.run(['dotnet', str(HERE / 'bin/Debug/net8.0/BackingScopes.dll'), str(DATA / 'Managed'), str(HERE / 'il-commands.json'), str(HERE / 'next-signatures.json')], capture_output=True, check=True)
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
    assert len(reused) == 15
    assert {m['definition']['signature'] for m in scopes['directMethodOperands']} - selected == {r['signature'] for r in reused}
    prev = load(HERE.parent / 'bio-tmp-inline-style-replacement/next-consumer.json')
    assert scopes['nextDeclarations'] == prev['subsequentConcreteArrayConsumer']
    assert sorted(scopes['selectedMethods'], key=lambda m:m['signature']) == sorted(prev['nextMetadata'], key=lambda m:m['signature'])
    result = dict(status='passed-static-scoped', dotnetSDK='8.0.131', metadataSelections=4, methodDeclarations=4,
                  methodBodies=4, directResolvedMethodOperands=46, directResolvedFieldOperands=26,
                  opaqueRuntimeOperands=0, exceptionHandlers=0, nextPinnedDeclarations=1,
                  metadataDllsPinned=150, retainedUniqueFiles=pins['uniqueFilesVerified'],
                  retainedPhase99Files=len(load(HERE / 'baseline.json')['priorFiles']), reusedDirectConsumerBodies=15,
                  exactProjectionControls=controls, projectionExclusions=exclusions, instructionComparisonControls=2,
                  emissionSites=12, reproducedSubstantiveOutputs=10,
                  originalResourcesDecoded=0, originalResources='hash parity only', gameAssemblyExecuted=False,
                  gameLaunches=0, imagesOpened=0, gitMutations=0, authoredTranslations=0, noMocks=True,
                  sourceAcceptance='needs-review', editorial='not-run', runtime='not-run', visual='not-run', delivery='needs-review', usage=None,
                  boundary='Static original IL/metadata only; actual backing/stack/style/resources/native/rendering state unknown. Concrete TextMeshProUGUI.SetArraySizes body remains unread.')
    (out / 'verification.json').write_text(json.dumps(result, indent=2) + '\n')
    return result


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output', type=Path, required=True)
    out = p.parse_args().output.resolve()
    assert HERE in out.parents and not out.exists()
    out.mkdir()
    print(json.dumps(verify(out)))
