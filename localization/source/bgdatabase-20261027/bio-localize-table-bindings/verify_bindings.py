#!/usr/bin/env python3
"""Reproduce selected original metadata and prior source checks; no game execution."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
PRIOR = HERE.parent / 'bio-language-table'
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


def body(path, signature):
    raw = path.read_bytes()
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
    for name, archive in [('README.md', 'previous-summary.md'), ('CHECKPOINT.json', 'previous-checkpoint.json')]:
        assert sha(HERE / archive) == baseline['summaryPins'][name], archive
    reused = load(HERE / 'reused-inputs.json')
    for path, expected in reused.items():
        assert sha(ROOT / path) == expected, path
    spec = importlib.util.spec_from_file_location('frozen_table', PRIOR / 'verify_table.py')
    prior = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(prior)
    previous_out = out / 'prior-table'
    previous_out.mkdir()
    previous = prior.verify(previous_out)
    files = sorted(p for p in previous_out.rglob('*') if p.is_file())
    assert {p.relative_to(previous_out) for p in files} == {
        p.relative_to(PRIOR / 'readback') for p in (PRIOR / 'readback').rglob('*') if p.is_file()}
    for path in files:
        assert path.read_bytes() == (PRIOR / 'readback' / path.relative_to(previous_out)).read_bytes(), path

    commands = load(HERE / 'il-commands.json')
    assert len(commands) == len({c['output'] for c in commands})
    for command in commands:
        assert command['exitCode'] == 0
        assert sha(HERE / command['output']) == command['sha256'], command['output']
        actual = subprocess.check_output(['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'),
            str(DATA / 'Managed' / command['assembly']), command['type'], command['selection']])
        assert actual == (HERE / command['output']).read_bytes(), command['output']

    binding = lambda sig: body(HERE / 'localize-bindings.il', sig)
    get_table = binding('PixelCrushers.TextTable PixelCrushers.LocalizeUI::get_textTable()')
    ordered(get_table, b'::m_textTable', b'IL_000c: brtrue.s IL_0031',
        b'UILocalizationManager::get_instance()', b'UILocalizationManager::get_textTable()',
        b'IL_001e: brtrue.s IL_0026', b'GlobalTextTable::get_textTable()',
        b'IL_0026: call', b'UILocalizationManager::get_textTable()', b'IL_0031: ldarg.0')
    set_table = binding('System.Void PixelCrushers.LocalizeUI::set_textTable(PixelCrushers.TextTable)')
    assert b'::m_textTable' in set_table and b': call' not in set_table
    field = binding('System.String PixelCrushers.LocalizeUI::get_fieldName()')
    ordered(field, b'String::IsNullOrEmpty', b'IL_000b: brtrue.s IL_0014', b'IL_0014: ldnull')
    life = lambda sig: body(HERE / 'localize-lifecycle.il', sig)
    start = life('System.Void PixelCrushers.LocalizeUI::Start()')
    ordered(start, b'Virtual', b'ldc.i4.1', b'::set_started(System.Boolean)', b'callvirt System.Void PixelCrushers.LocalizeUI::UpdateText()')
    enable = life('System.Void PixelCrushers.LocalizeUI::OnEnable()')
    assert b'callvirt System.Void PixelCrushers.LocalizeUI::UpdateText()' in enable
    assert b'::set_started' not in enable
    set_field = life('System.Void PixelCrushers.LocalizeUI::SetFieldName(System.String)')
    ordered(set_field, b'::GetComponent<UnityEngine.UI.Text>()', b'String::IsNullOrEmpty',
        b'UnityEngine.UI.Text::get_text()', b'::set_fieldName(System.String)')
    assert b'::UpdateText' not in set_field
    dropdown = life('System.Void PixelCrushers.LocalizeUI::UpdateDropdownOptions()')
    ordered(dropdown, b'::get_fieldNames()', b'::Clear()', b'callvirt System.Void PixelCrushers.LocalizeUI::UpdateText()')
    callback = life('System.Void PixelCrushers.LocalizeUI::<UpdateText>b__31_0(UnityEngine.UI.Dropdown/OptionData)')
    ordered(callback, b'::get_fieldNames()', b'OptionData::get_text()', b'::Add(!0)')

    old = HERE.parent / 'bio-language-initialization'
    update = body(old / 'localize-ui-update.il', 'System.Void PixelCrushers.LocalizeUI::UpdateText()')
    ordered(update, b'::get_started()', b'IL_0006: brtrue.s IL_0009', b'IL_0008: ret', b'::get_textTable()')
    local_lookup = body(old / 'localize-ui-update.il', 'System.String PixelCrushers.LocalizeUI::GetLocalizedText(System.String)')
    ordered(local_lookup, b'::HasField(System.String)', b'IL_001a: brtrue.s IL_0023',
        b'GlobalTextTable::Lookup(System.String)', b'IL_0023: ldarg.0',
        b'GlobalTextTable::get_currentLanguage()', b'::GetFieldTextForLanguage(System.String,System.String)')
    ui_table = body(old / 'ui-singleton.il', 'PixelCrushers.TextTable PixelCrushers.UILocalizationManager::get_textTable()')
    assert b'IL_0000: call PixelCrushers.UILocalizationManager PixelCrushers.UILocalizationManager::get_instance()' in ui_table
    assert b'ldarg.0' not in ui_table

    controller = body(HERE / 'controller-text.il', 'System.String PixelCrushers.DialogueSystem.DialogueSystemController::GetLocalizedText(System.String)')
    assert b'Virtual' not in controller and b'GlobalTextTable' not in controller and b'UILocalizationManager' not in controller
    ordered(controller, b'LocalizationSettings::textTable', b'IL_0016: brfalse.s IL_001a',
        b'IL_0018: ldarg.1\nIL_0019: ret', b'Localization::GetCurrentLanguageID(PixelCrushers.TextTable)',
        b'::GetFieldTextForLanguage(System.String,System.Int32)', b'String::IsNullOrEmpty',
        b'IL_003f: brtrue.s IL_0043', b'IL_0041: ldloc.1\nIL_0042: ret', b'IL_0043: ldarg.1')
    cache = body(old / 'localization-flags.il', 'System.Int32 PixelCrushers.DialogueSystem.Localization::GetCurrentLanguageID(PixelCrushers.TextTable)')
    ordered(cache, b'::m_currentLanguageID', b'ldc.i4.m1', b'IL_0006: bne.un.s IL_0021',
        b'::get_language()', b'TextTable::GetLanguageID(System.String)', b'stsfld System.Int32')
    assert b'::textTable' not in cache  # No table-identity key in this selected cache method.
    setter = body(old / 'localization-language.il', 'System.Void PixelCrushers.DialogueSystem.Localization::set_language(System.String)')
    ordered(setter, b'::m_language', b'ldc.i4.m1', b'::m_currentLanguageID', b'DialogueManager::get_instance()')

    for stem, typ in [('dialogue-localize', 'PixelCrushers.DialogueSystem.LocalizeUIText'),
                      ('wrapper-localize', 'PixelCrushers.Wrappers.LocalizeUI')]:
        assert f'TYPE {typ} BASE PixelCrushers.LocalizeUI'.encode() in (HERE / f'{stem}-fields.il').read_bytes()
        declared = (HERE / f'{stem}-list.il').read_bytes()
        assert b'::GetLocalizedText(' not in declared and b'::UpdateText(' not in declared
    deprecated = body(HERE / 'dialogue-localize-lifecycle.il', 'System.Void PixelCrushers.DialogueSystem.LocalizeUIText::LocalizeText()')
    assert b'callvirt System.Void PixelCrushers.LocalizeUI::UpdateText()' in deprecated

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
    dump(out / 'binding-method-facts.json', dict(boundary='Original selected metadata; native/virtual callbacks and game code unexecuted.', methods=facts))
    result = {k: previous[k] for k in ['frozenPinsUnchanged', 'helpersChecked', 'checkedInstalledSources',
        'metadataDllsPinned', 'exactCandidateValuesPerCopy', 'exactSourceOccurrences', 'sourceCopies',
        'targetActorIds', 'targetRegistrations', 'uniqueTargetEntries']}
    result.update(status='passed-static-scoped', priorSupplementFilesChecked=len(baseline['priorFiles']),
        previousPhase87FilesReproduced=len(files), reusedInputFilesChecked=len(reused),
        newSuccessfulMetadataSelections=len(commands), successfulNewMethodBodies=len(facts),
        regressionAssertions=['Component table priority, singleton/global fallback and store-only setter',
            'Base Start sets started before virtual UpdateText; OnEnable does not set it',
            'Field-name null normalization, store-only SetFieldName and dropdown clear/capture boundaries',
            'Controller settings table and numeric Localization cache differ from UI/global route',
            'No-table controller preserves input; nonempty lookup returns before input fallback',
            'UI table getter redirects to singleton rather than receiver',
            'Two metadata-identified derived types declare neither GetLocalizedText nor UpdateText; no exhaustive hierarchy claim',
            'Phase87 entire readback path set/bytes and frozen source/actor inputs retained'],
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
