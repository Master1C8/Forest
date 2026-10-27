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
    prior = HERE.parent / 'bio-tmp-input-parsing'
    for name, expected in load(prior / 'helper-pins.json').items():
        check(ROOT / name, expected)
    for name, archive in [('CHECKPOINT.json', 'previous-checkpoint.json'), ('README.md', 'previous-summary.md')]:
        check(HERE / archive, load(HERE / 'baseline.json')['summaryPins'][name])
    dlls = [p for p in files if p.parent == DATA / 'Managed' and p.suffix == '.dll']
    assert len(dlls) == 150
    assert {p.name for p in dlls} == {p.name for p in (DATA / 'Managed').glob('*.dll')}
    return dict(status='passed-hash-parity', baselineFiles=len(seen), uniqueFilesVerified=len(files), groups=groups, previousHelperPins=len(load(prior / 'helper-pins.json')), originalResources='hashed, not decoded')


def check_metadata(texts, scopes):
    lookup = texts['style-lookup.il']
    ordered(lookup, '::m_StyleSheet', 'UnityEngine.Object::op_Inequality(', 'brfalse.s IL_0022',
            'TMP_StyleSheet::GetStyle(System.Int32)', 'brfalse.s IL_0022', 'IL_0021: ret',
            '::get_defaultStyleSheet()', 'UnityEngine.Object::op_Inequality(', 'brfalse.s IL_003b',
            '::get_defaultStyleSheet()', 'TMP_StyleSheet::GetStyle(System.Int32)', 'IL_003c: ret')
    assert lookup.count('::get_defaultStyleSheet()') == 2
    sheet = texts['sheet-lookup.il']
    ordered(sheet, '::m_StyleLookupDictionary', 'brtrue.s IL_000e', '::LoadStyleDictionaryInternal()',
            '::TryGetValue(', 'brfalse.s IL_0020', 'IL_001f: ret', 'ldnull', 'ret')
    assert 'GetStyle(System.String)' not in sheet
    settings = texts['settings-lookup.il']
    default = body(settings, 'TMPro.TMP_StyleSheet TMPro.TMP_Settings::get_defaultStyleSheet()')
    ordered(default, '::get_instance()', 'ldfld TMPro.TMP_StyleSheet', 'ret')
    assert 'br' not in default and 'ldnull' not in default
    instance = body(settings, 'TMPro.TMP_Settings TMPro.TMP_Settings::get_instance()')
    ordered(instance, '::s_Instance', '::op_Equality(', 'brfalse.s IL_001c',
            'ldstr "TMP Settings"', 'Resources::Load<TMPro.TMP_Settings>(System.String)',
            'stsfld TMPro.TMP_Settings', '::s_Instance', 'ret')
    normal = texts['normal-style.il']
    ordered(normal, '::k_NormalStyle', 'brtrue.s IL_0020', 'ldstr "Normal"',
            'System.String::Empty', 'System.String::Empty', 'TMP_Style::.ctor(',
            'stsfld TMPro.TMP_Style', '::k_NormalStyle', 'ret')
    ctor = texts['style-constructor.il']
    ordered(ctor, '::m_Name', '::GetHashCode(System.String)', '::m_HashCode',
            '::m_OpeningDefinition', '::m_ClosingDefinition', '::RefreshStyle()', 'ret')
    init = texts['sheet-initialize.il']
    ordered(init, 'Dictionary`2<System.Int32,TMPro.TMP_Style>::.ctor()', '::Clear()',
            '::RefreshStyle()', '::get_hashCode()', '::ContainsKey(', 'brtrue.s IL_007b',
            '::get_hashCode()', '::Add(', '::get_Count()', 'ldstr "Normal"',
            '::GetHashCode(System.String)', '::ContainsKey(', 'brtrue.s IL_00d4',
            'ldstr "Normal"', 'TMP_Style::.ctor(', 'List`1<TMPro.TMP_Style>::Add(',
            'Dictionary`2<System.Int32,TMPro.TMP_Style>::Add(', 'ret')
    refresh = body(texts['style-refresh.il'], 'System.Void TMPro.TMP_Style::RefreshStyle()')
    ordered(refresh, '::m_Name', '::GetHashCode(', '::m_HashCode', '::m_OpeningDefinition',
            'System.String::get_Length()', 'newarr System.Int32', '::m_OpeningTagArray',
            'newarr System.UInt32', '::m_OpeningTagUnicodeArray', 'System.String::get_Chars(',
            '::m_ClosingDefinition', 'System.String::get_Length()', 'newarr System.Int32',
            '::m_ClosingTagArray', 'newarr System.UInt32', '::m_ClosingTagUnicodeArray',
            'System.String::get_Chars(', 'ret')
    assert refresh.count('System.String::get_Chars(') == 4
    assert 'ConvertToUTF32' not in refresh and 'brfalse' not in refresh
    hash_body = texts['hash.il'] if 'hash.il' in texts else texts['hash-name-selection.il']
    ordered(hash_body, 'ldc.i4.0', 'ldc.i4.5', 'shl', 'add', 'System.String::get_Chars(',
            '::ToUpperASCIIFast(System.Char)', 'xor', 'System.String::get_Length()', 'ret')
    upper = texts['ascii-upper.il']
    ordered(upper, 'System.String::get_Length()', 'ldc.i4.1', 'sub', 'ble.s IL_0011',
            'IL_000f: ldarg.0', 'IL_0010: ret', 'System.String::get_Chars(', 'ret')
    # Decode the literal table only. This does not invoke original methods.
    table = upper.split('ldstr "', 1)[1].split('"', 1)[0]
    assert len(table) == 128 and table[ord('a')] == table[ord('A')] == 'A'
    derived = 0
    for c in 'Normal':
        derived = ((derived * 33) ^ ord(table[ord(c)])) & 0xffffffff
    signed = derived if derived < 0x80000000 else derived - 0x100000000
    stack = texts['style-stack-name-selection.il']
    ordered(stack, '::SetDefault(TMPro.TMP_TextProcessingStack`1<T>[],T)',
            '::SetDefault(T)', 'ldlen', '::SetDefault(T) |', '::itemStack',
            'brtrue.s IL_002c', 'ldc.i4.4', '::m_Capacity', 'newarr T',
            '::m_DefaultItem', 'initobj T', 'IL_002c: ldarg.0', 'ldc.i4.0',
            'stelem.any T', 'ldc.i4.1', '::index', 'ret')
    resource = texts['resource-load.il']
    assert 'METHOD UnityEngine.Object UnityEngine.Resources::Load(System.String) |' not in resource
    ordered(resource, 'METHOD T UnityEngine.Resources::Load(System.String)', 'ldtoken T',
            '::GetTypeFromHandle(', 'Resources::Load(System.String,System.Type)', 'unbox.any T',
            'METHOD UnityEngine.Object UnityEngine.Resources::Load(System.String,System.Type)',
            '::get_ActiveAPI()', 'callvirt UnityEngine.Object UnityEngine.ResourcesAPI::Load(')
    ordered(texts['resource-api.il'], '::get_overrideAPI()', 'brtrue.s IL_000e',
            '::s_DefaultAPI', '::Load(System.String,System.Type)', 'ResourcesAPIInternal::Load(')
    assert '::<overrideAPI>k__BackingField' in texts['resource-api-override.il']
    assert 'impl=InternalCall' in texts['resource-native.il'] and 'IL_' not in texts['resource-native.il']
    ordered(texts['object-comparison.il'], '::op_Equality(', '::CompareBaseObjects(',
            '::op_Inequality(', '::CompareBaseObjects(', 'ldc.i4.0', 'ceq')
    nulls = texts['object-null-semantics.il']
    ordered(nulls, '::CompareBaseObjects(', 'ldnull', 'ceq', 'ldnull', 'ceq',
            '::IsNativeObjectAlive(', '::IsNativeObjectAlive(', '::IsNativeObjectAlive(UnityEngine.Object) |',
            '::GetCachedPtr()', 'System.IntPtr::Zero', 'System.IntPtr::op_Inequality(',
            '::GetCachedPtr() |', '::m_CachedPtr', 'ret')
    assert len(scopes['selectedMethods']) == 24
    assert sum(bool(m['hasBody']) for m in scopes['selectedMethods']) == 23
    assert all(not r['handlers'] for r in scopes['exceptionHandlers'])
    assert len(scopes['directMethodOperands']) == 31 and len(scopes['fieldOperands']) == 55
    assert len(scopes['opaqueRuntimeOperands']) == 26
    assert len(scopes['nextDeclarations']) == 8
    assert next(t for t in scopes['typeIdentities'] if t['name'] == 'TMPro.TMP_Style')['baseType'] == 'System.Object'
    api = next(m for m in scopes['selectedMethods'] if m['signature'] == 'UnityEngine.Object UnityEngine.ResourcesAPI::Load(System.String,System.Type)')
    assert api['isVirtual'] and api['isNewSlot'] and not api['isFinal']
    return dict(normalHashUnsigned=derived, normalHashSigned=signed, tableLength=len(table),
                meaning='Computed from IL literal/operations by this verifier; original code not executed; no live style identity implied')


def verify(out):
    retained = check_retained()
    (out / 'retained-input-verification.json').write_text(json.dumps(retained, indent=2) + '\n')
    assert subprocess.check_output(['dotnet', '--version'], text=True).strip() == '8.0.131'
    subprocess.run(['dotnet', 'build', str(HERE / 'StyleScopes.csproj'), '--no-restore', '--nologo', '--verbosity', 'quiet'], capture_output=True, check=True)
    for name, expected in load(HERE / 'helper-pins.json').items():
        assert sha(ROOT / name) == expected, name
    texts = {}
    exclusions = 0
    for row in load(HERE / 'il-commands.json'):
        assert row['exitCode'] == 0 and not row['stderr']
        r = subprocess.run(['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'), str(DATA / 'Managed' / row['assembly']), row['type'], row['selection']], capture_output=True, check=True)
        assert not r.stderr
        raw = r.stdout
        if 'rawOutput' in row:
            (out / row['rawOutput']).write_bytes(raw)
            assert sha(out / row['rawOutput']) == row['rawSha256'] == sha(HERE / row['rawOutput'])
            exclusions += len(raw.decode().split('METHOD ')) - 1 - len(row['signatures'])
        selected = project(raw, row['signatures'])
        (out / row['output']).write_bytes(selected)
        assert sha(out / row['output']) == row['sha256'] == sha(HERE / row['output'])
        texts[row['output']] = selected.decode()
    assert exclusions == 3
    for file, included, excluded in [
        ('sheet-lookup', 'GetStyle(System.Int32)', 'GetStyle(System.String)'),
        ('ascii-upper', 'ToUpperASCIIFast(System.Char)', 'ToUpperASCIIFast(System.UInt32)'),
        ('resource-load', 'METHOD T UnityEngine.Resources::Load(System.String)', 'METHOD UnityEngine.Object UnityEngine.Resources::Load(System.String) |')]:
        raw = (out / (file + '-name-selection.il')).read_text()
        exact = texts[file + '.il']
        assert included in raw and included in exact and excluded in raw and excluded not in exact
    r = subprocess.run(['dotnet', str(HERE / 'bin/Debug/net8.0/StyleScopes.dll'), str(DATA / 'Managed'), str(HERE / 'il-commands.json')], capture_output=True, check=True)
    assert not r.stderr
    (out / 'dependency-scopes.json').write_bytes(r.stdout)
    assert sha(out / 'dependency-scopes.json') == sha(HERE / 'dependency-scopes.json')
    scopes = load(out / 'dependency-scopes.json')
    for row in scopes['directMethodOperands'] + scopes['fieldOperands']:
        assert sha(DATA / 'Managed' / row['definition']['module']) == row['definition']['sha256']
    derived = check_metadata(texts, scopes)
    (out / 'derived-hash.json').write_text(json.dumps(derived, indent=2) + '\n')
    result = dict(status='passed-static-scoped', dotnetSDK='8.0.131', metadataSelections=len(texts),
        methodDeclarations=24, methodBodies=23, nativeDeclarations=1, directResolvedMethodOperands=31,
        directResolvedFieldOperands=55, opaqueRuntimeOperands=26, nextPinnedDeclarations=8, exceptionHandlers=0,
        metadataDllsPinned=150, retainedUniqueFiles=retained['uniqueFilesVerified'],
        retainedPhase96Files=len(load(HERE / 'baseline.json')['priorFiles']),
        reproducedSubstantiveOutputs=len(texts)+3+3, incidentalExcludedOverloads=3,
        originalResourcesDecoded=0, installedResources="retained hash checks only", gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0,
        gitMutations=0, authoredTranslations=0, noMocks=True, sourceAcceptance='needs-review',
        editorial='not-run', runtime='not-run', visual='not-run', delivery='needs-review', usage=None,
        boundary='Actual original metadata/IL only. Resource Load is virtual through ActiveAPI; base implementation reaches pinned InternalCall. No current resource/API/style selection, markup expansion or rendering is verified.')
    (out / 'verification.json').write_text(json.dumps(result, indent=2) + '\n')
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    out = parser.parse_args().output.resolve()
    assert HERE in out.parents and not out.exists()
    out.mkdir()
    print(json.dumps(verify(out)))


