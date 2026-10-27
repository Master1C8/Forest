#!/usr/bin/env python3
"""Reproduce exact original TMP input metadata without executing game code."""
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
    prior = HERE.parent / 'bio-canvas-rebuild'
    for name, expected in load(prior / 'helper-pins.json').items():
        check(ROOT / name, expected)
    for name, archive in [('CHECKPOINT.json', 'previous-checkpoint.json'), ('README.md', 'previous-summary.md')]:
        check(HERE / archive, load(HERE / 'baseline.json')['summaryPins'][name])
    dlls = [p for p in files if p.parent == DATA / 'Managed' and p.suffix == '.dll']
    assert len(dlls) == 150
    assert {p.name for p in dlls} == {p.name for p in (DATA / 'Managed').glob('*.dll')}
    return dict(status='passed-hash-parity', baselineFiles=len(seen), uniqueFilesVerified=len(files), groups=groups, previousHelperPins=len(load(prior / 'helper-pins.json')), originalResources='hashed, not decoded')


def verify(out):
    retained = check_retained()
    (out / 'retained-input-verification.json').write_text(json.dumps(retained, indent=2) + '\n')
    assert subprocess.check_output(['dotnet', '--version'], text=True).strip() == '8.0.131'
    subprocess.run(['dotnet', 'build', str(HERE / 'InputScopes.csproj'), '--no-restore', '--nologo', '--verbosity', 'quiet'], capture_output=True, check=True)
    for name, expected in load(HERE / 'helper-pins.json').items():
        assert sha(ROOT / name) == expected, name
    texts = {}
    for row in load(HERE / 'il-commands.json'):
        assert row['exitCode'] == 0 and not row['stderr']
        r = subprocess.run(['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'), str(DATA / 'Managed' / row['assembly']), row['type'], row['selection']], capture_output=True, check=True)
        assert not r.stderr
        raw = r.stdout
        if 'rawOutput' in row:
            (out / row['rawOutput']).write_bytes(raw)
            assert sha(out / row['rawOutput']) == row['rawSha256'] == sha(HERE / row['rawOutput'])
        selected = project(raw, row['signatures'])
        (out / row['output']).write_bytes(selected)
        assert sha(out / row['output']) == row['sha256'] == sha(HERE / row['output'])
        texts[row['output']] = selected.decode()
    r = subprocess.run(['dotnet', str(HERE / 'bin/Debug/net8.0/InputScopes.dll'), str(DATA / 'Managed'), str(HERE / 'il-commands.json')], capture_output=True, check=True)
    assert not r.stderr
    (out / 'dependency-scopes.json').write_bytes(r.stdout)
    assert sha(out / 'dependency-scopes.json') == sha(HERE / 'dependency-scopes.json')
    scopes = load(out / 'dependency-scopes.json')
    for row in scopes['directMethodOperands']:
        assert sha(DATA / 'Managed' / row['definition']['module']) == row['definition']['sha256']
    assert {r['name']: r['value'] for r in scopes['textInputSources']} == dict(TextInputBox=0, SetText=1, SetTextArray=2, TextString=3)
    parse = texts['parse-input.il']
    ordered(parse, 'switch IL_001f,IL_004c,IL_004c,IL_001f', 'br.s IL_004c', '::m_TextPreprocessor', 'brfalse.s IL_003b', '::m_text', 'ITextPreprocessor::PreprocessText(System.String)', 'br.s IL_0041', 'IL_003b: ldarg.0', '::m_text', 'IL_0041: call System.Void TMPro.TMP_Text::PopulateTextBackingArray(System.String)', '::PopulateTextProcessingArray()', 'IL_004c: ldarg.0', '::m_TextProcessingArray', '::SetArraySizes(', 'pop', 'ret')
    # Neither ParseInputText nor these direct managed conversion bodies store m_text.
    # Unknown callback bodies can still mutate object state; do not infer otherwise.
    assert not any('stfld System.String TMPro.TMP_Text::m_text' in t for t in texts.values())
    interface = next(m for m in scopes['selectedMethods'] if 'ITextPreprocessor::PreprocessText' in m['signature'])
    assert not interface['hasBody'] and interface['isVirtual'] and 'Abstract' in interface['attributes']
    chain = scopes['concreteSetArraySizes']
    assert len(chain) == 1 and chain[0]['type'] == 'TMPro.TextMeshProUGUI'
    concrete = chain[0]['declarations']
    assert len(concrete) == 1 and concrete[0]['isVirtual'] and not concrete[0]['isNewSlot'] and concrete[0]['hasBody']
    assert all(not r['handlers'] for r in scopes['exceptionHandlers'])
    backing = body(texts['backing-processing.il'], 'System.Void TMPro.TMP_Text::PopulateTextBackingArray(System.String,System.Int32,System.Int32)')
    ordered(backing, 'System.String::get_Chars(', '::set_Item(', 'IL_007f: ldc.i4.0', '::set_Item(', '::set_Count(')
    processing = body(texts['backing-processing.il'], 'System.Void TMPro.TMP_Text::PopulateTextProcessingArray()')
    ordered(processing, '::get_Count()', '::SetDefault(', '::get_textStyle()', '::InsertOpeningStyleTag(', '::get_Item(', 'brfalse IL_0775', '::m_inputSource', 'IL_0081: brtrue IL_0429', 'ldc.i4.s 92', '::m_parseCtrlCharacters', '::GetUTF16(', '::GetUTF32(', 'IL_0429: ldloc.3', 'ldc.i4 55296', 'ldc.i4 56319', 'ldc.i4 56320', 'ldc.i4 57343', '::ConvertToUTF32(', 'IL_04cf: ldc.i4.2', '::m_isRichText', '::GetMarkupTagHashCode(', '::ReplaceOpeningStyleTag(', '::ReplaceClosingStyleTag(', 'IL_0719: ldloc.1', '::stringIndex', '::length', 'IL_0775: ldarg.0', '::InsertClosingStyleTag(', 'IL_07bf: ldc.i4.0', '::unicode', '::m_InternalTextProcessingArraySize')
    assert 'StringBuilder' not in texts['backing-processing.il'] and 'System.Char[]' not in texts['backing-processing.il']
    raw = (out / 'backing-processing-name-selection.il').read_text()
    assert 'StringBuilder' in raw and 'System.Char[]' in raw
    ordered(texts['backing-container.il'], '::get_Capacity()', '::m_Array', 'ldlen', '::get_Count()', '::m_Count', '::set_Count(', 'stfld System.Int32', '::get_Item(', 'ldelem.u4', '::set_Item(', '::Resize(', 'stelem.i4', '::Resize(', '::NextPowerOfTwo(', 'System.Array::Resize')
    ordered(texts['processing-managed.il'], '::GetStyle(', '::m_TextStyle', '::get_NormalStyle()', '::m_TextStyleHashCode', '::ResizeInternalArray(T[]&)', '::NextPowerOfTwo(', 'System.Array::Resize', '::ResizeInternalArray(T[]&,System.Int32)', '::NextPowerOfTwo(', 'System.Array::Resize')
    assert 'impl=InternalCall' in texts['native-capacity-boundary.il'] and 'IL_' not in texts['native-capacity-boundary.il']
    assert len(scopes['selectedMethods']) == 16 and len(scopes['directMethodOperands']) == 54
    result = dict(status='passed-static-scoped', dotnetSDK='8.0.131', metadataSelections=len(texts), methodDeclarations=16, methodBodies=14, abstractInterfaceDeclarations=1, nativeDeclarations=1, directResolvedMethodOperands=54, concreteDispatchChains=1, exceptionHandlers=0, metadataDllsPinned=150, retainedUniqueFiles=retained['uniqueFilesVerified'], retainedPhase95Files=len(load(HERE / 'baseline.json')['priorFiles']), reproducedSubstantiveOutputs=len(texts)+3, incidentalExcludedOverloads=2, originalResourceReads=0, gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0, gitMutations=0, authoredTranslations=0, noMocks=True, sourceAcceptance='needs-review', editorial='not-run', runtime='not-run', visual='not-run', delivery='needs-review', usage=None, boundary='Actual original metadata/IL; native capacity declaration not executed. Preprocessor concrete target and style/font resources remain unknown; SetArraySizes override declaration only.')
    (out / 'verification.json').write_text(json.dumps(result, indent=2) + '\n')
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    out = parser.parse_args().output.resolve()
    assert HERE in out.parents and not out.exists()
    out.mkdir()
    print(json.dumps(verify(out)))
