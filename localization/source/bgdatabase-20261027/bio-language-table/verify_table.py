#!/usr/bin/env python3
"""Replay bounded original table metadata; never execute original game assemblies."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
PRIOR = HERE.parent / 'bio-language-initialization'
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')


def sha(path):
    h = hashlib.sha256()
    with path.open('rb') as stream:
        for block in iter(lambda: stream.read(4 * 1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()


def load(path):
    return json.loads(path.read_text())


def dump(path, value):
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def body(file, signature):
    raw = (HERE / file).read_bytes()
    prefix = ('METHOD ' + signature + ' |').encode()
    assert raw.count(prefix) == 1, signature
    return raw.split(prefix, 1)[1].split(b'\nMETHOD ', 1)[0]


def ordered(raw, *tokens):
    offset = 0
    for token in tokens:
        index = raw.find(token, offset)
        assert index >= 0, token
        offset = index + len(token)


def verify(out):
    baseline = load(HERE / 'baseline.json')
    for path, expected in baseline['priorFiles'].items():
        assert sha(ROOT / path) == expected, path
    for path, archive in [('README.md', 'previous-summary.md'), ('CHECKPOINT.json', 'previous-checkpoint.json')]:
        assert sha(HERE / archive) == baseline['summaryPins'][path], archive
    spec = importlib.util.spec_from_file_location('frozen_language', PRIOR / 'verify_language.py')
    prior = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(prior)
    previous_out = out / 'prior-language'
    previous_out.mkdir()
    previous = prior.verify(previous_out)
    previous_files = sorted(path for path in previous_out.rglob('*') if path.is_file())
    assert {p.relative_to(previous_out) for p in previous_files} == {
        p.relative_to(PRIOR / 'readback') for p in (PRIOR / 'readback').rglob('*') if p.is_file()}
    for path in previous_files:
        assert path.read_bytes() == (PRIOR / 'readback' / path.relative_to(previous_out)).read_bytes(), path

    commands = load(HERE / 'il-commands.json')
    assert len(commands) == len({c['output'] for c in commands})
    for command in commands:
        assert command['exitCode'] == 0
        assert sha(HERE / command['output']) == command['sha256'], command['output']
        actual = subprocess.check_output(['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'),
            str(DATA / 'Managed' / command['assembly']), command['type'], command['selection']])
        assert actual == (HERE / command['output']).read_bytes(), command['output']

    global_body = lambda sig: body('global-forwarding.il', sig)
    instance = global_body('PixelCrushers.GlobalTextTable PixelCrushers.GlobalTextTable::get_instance()')
    assert b'::s_instance' in instance and b': call ' not in instance and b': callvirt ' not in instance
    get_language = global_body('System.String PixelCrushers.GlobalTextTable::get_currentLanguage()')
    ordered(get_language, b'UILocalizationManager::get_instance()', b'UILocalizationManager::get_currentLanguage()')
    set_table = global_body('System.Void PixelCrushers.GlobalTextTable::set_textTable(PixelCrushers.TextTable)')
    ordered(set_table, b'::m_textTable', b'UILocalizationManager::get_instance()',
        b'GlobalTextTable::get_currentLanguage()', b'UILocalizationManager::UpdateUIs(System.String)')
    lookup = global_body('System.String PixelCrushers.GlobalTextTable::Lookup(System.String)')
    ordered(lookup, b'String::IsNullOrEmpty', b'String::Empty', b'::get_textTable()',
        b'IL_001b: ldarg.0\nIL_001c: ret', b'::get_currentLanguage()',
        b'::GetFieldTextForLanguage(System.String,System.String)')
    assert b'TextTable::get_currentLanguageID' not in lookup
    sf_lookup = global_body('System.String PixelCrushers.GlobalTextTable::Lookup(PixelCrushers.StringField)')
    ordered(sf_lookup, b'IL_0001: brtrue.s IL_0009', b'String::Empty', b'StringField::get_value()',
        b'GlobalTextTable::Lookup(System.String)')
    field_value = body('string-field-value.il', 'System.String PixelCrushers.StringField::get_value()')
    ordered(field_value, b'::get_textTable()', b'::get_textTableFieldID()',
        b'UILocalizationManager::get_currentLanguage()', b'::GetFieldTextForLanguage(System.Int32,System.String)',
        b'::get_stringAsset()', b'StringAsset::get_text()', b'StringField::get_text()')
    language_id = body('table-lookup.il', 'System.Int32 PixelCrushers.TextTable::GetLanguageID(System.String)')
    ordered(language_id, b'::get_languages()', b'::ContainsKey(!0)',
        b'IL_000e: ldc.i4.0\nIL_000f: ret', b'::get_Item(!0)')
    assert b'IsNullOrEmpty' not in language_id
    field_id = body('table-lookup.il', 'System.Int32 PixelCrushers.TextTable::GetFieldID(System.String)')
    ordered(field_id, b'::GetEnumerator()', b'::get_Value()', b'::get_fieldName()',
        b'System.String::Equals(System.String,System.String)', b'::get_Key()', b'IL_0054: ldc.i4.0')
    for arg, missing, fallback in [
        ('System.Int32', b'::GetFieldName(System.Int32)', b'::GetFieldName(System.Int32)'),
        ('System.String', b'IL_000b: ldarg.1\nIL_000c: ret', b'IL_004e: ldarg.1')]:
        selected = body('table-lookup.il', f'System.String PixelCrushers.TextTable::GetFieldTextForLanguage({arg},System.Int32)')
        ordered(selected, missing, b'::HasTextForLanguage(System.Int32)', b'::GetTextForLanguage(System.Int32)',
            b'System.String::Replace(System.String,System.String)', b'String::IsNullOrEmpty',
            b'ldc.i4.0', b'::GetTextForLanguage(System.Int32)', b'String::IsNullOrEmpty',
            b'::get_useDefaultLanguageForBlankTranslations()', fallback)
        # The emitted operand retains literal backslash-n AND a physical LF. Do not normalize either.
        assert selected.count(b'ldstr "\\n"') == 2
        assert selected.count(b'ldstr "\n"') == 2
    for arg in ['System.Int32', 'System.String']:
        selected = body('table-lookup.il', f'System.String PixelCrushers.TextTable::GetFieldText({arg})')
        ordered(selected, b'::get_currentLanguageID()', b'::GetFieldTextForLanguage(')
    has_text = body('field-lookup.il', 'System.Boolean PixelCrushers.TextTableField::HasTextForLanguage(System.Int32)')
    ordered(has_text, b'::ContainsKey(!0)', b'::get_Item(!0)', b'String::IsNullOrEmpty')

    facts = []
    for command in commands:
        if command['selection'].startswith('--'):
            continue
        for section in (HERE / command['output']).read_text().split('\nMETHOD ')[1:]:
            header, _, instructions = section.partition('\n')
            facts.append(dict(signature=header.split(' |')[0], evidence=command['output'],
                virtual='Virtual' in header, calls=[line for line in instructions.splitlines()
                    if ': call ' in line or ': callvirt ' in line],
                fieldWrites=[line for line in instructions.splitlines() if ': stfld ' in line or ': stsfld ' in line]))
    dump(out / 'table-method-facts.json', dict(boundary='Original method metadata only; no original code/native callback executed.', methods=facts))
    result = {key: previous[key] for key in ['frozenPinsUnchanged', 'helpersChecked', 'checkedInstalledSources',
        'metadataDllsPinned', 'exactCandidateValuesPerCopy', 'exactSourceOccurrences', 'sourceCopies',
        'targetActorIds', 'targetRegistrations', 'uniqueTargetEntries']}
    result.update(status='passed-static-scoped', priorSupplementFilesChecked=len(baseline['priorFiles']),
        previousPhase86FilesReproduced=len(previous_files), newSuccessfulMetadataSelections=len(commands),
        successfulNewMethodBodies=len(facts),
        regressionAssertions=['Global instance is cached reference only; language forwards to UI singleton',
            'Global table store precedes conditional UI update; no UI table write inferred',
            'Global lookup early null/empty and no-table branches precede name/language overload',
            'StringField value is resolved before a second global lookup',
            'Unknown language and missing field name map to numeric0 in distinct dictionaries',
            'Requested nonempty field text returns before fallback flag; fallback uses language0',
            'Literal backslash-n and actual LF operands retained byte-for-byte',
            'GetFieldText uses static table ID; global lookup passes UI language name',
            'Phase86 complete readback set and exact source/actor inputs unchanged'],
        actualTableContentsAndLanguage='not-executed/unaccepted', virtualLifecycleAndReentrancy='needs-review',
        sourceAcceptance='needs-review', runtime='not-run', visual='not-run', editorial='not-run', delivery='needs-review',
        gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0, gitMutations=0,
        authoredTranslations=0, newDisplayCandidates=0, usage=None)
    dump(out / 'verification.json', result)
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert not args.output.exists(), 'output must be new'
    args.output.mkdir(parents=True)
    print(json.dumps(verify(args.output)))
