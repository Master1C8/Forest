#!/usr/bin/env python3
"""Reproduce bounded original language metadata; never execute game code."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
PRIOR = HERE.parent / 'bio-lua-initialization'
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')


def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for block in iter(lambda: f.read(4 * 1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()


def load(p):
    return json.loads(p.read_text())


def dump(p, obj):
    p.write_text(json.dumps(obj, ensure_ascii=False, indent=2) + '\n')


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
    for path, expected in {**baseline['priorFiles'], **load(HERE / 'binding-pins.json')}.items():
        assert sha(ROOT / path) == expected, path
    for path, archive in [('README.md', 'previous-summary.md'), ('CHECKPOINT.json', 'previous-checkpoint.json')]:
        assert sha(HERE / archive) == baseline['summaryPins'][path], archive
    spec = importlib.util.spec_from_file_location('frozen_initialization', PRIOR / 'verify_initialization.py')
    prior = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(prior)
    previous_out = out / 'prior-initialization'
    previous_out.mkdir()
    previous = prior.verify(previous_out)
    previous_files = sorted(p for p in previous_out.rglob('*') if p.is_file())
    for p in previous_files:
        assert p.read_bytes() == (PRIOR / 'readback' / p.relative_to(previous_out)).read_bytes(), p

    commands = load(HERE / 'il-commands.json')
    assert len(commands) == len({c['output'] for c in commands})
    for c in commands:
        assert c['exitCode'] == 0 and sha(HERE / c['output']) == c['sha256']
        actual = subprocess.check_output(['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'),
            str(DATA / 'Managed' / c['assembly']), c['type'], c['selection']])
        assert actual == (HERE / c['output']).read_bytes(), c['output']

    ui = body('ui-language.il', 'System.Void PixelCrushers.UILocalizationManager::set_currentLanguage(System.String)')
    ordered(ui, b'::get_instance()', b'::m_currentLanguage', b'::get_instance()', b'::UpdateUIs(System.String)')
    assert b'ldarg.0' not in ui and b'br' not in ui and b'DialogueSystem.Localization::' not in ui
    update = body('ui-language.il', 'System.Void PixelCrushers.UILocalizationManager::UpdateUIs(System.String)')
    ordered(update, b'::m_currentLanguage', b'::get_saveLanguageInPlayerPrefs()',
        b'UnityEngine.PlayerPrefs::SetString', b'::m_alsoUpdateInactiveLocalizeUI',
        b'FindObjectsOfType<PixelCrushers.LocalizeUI>', b'FindObjectsOfTypeAlsoInactive<PixelCrushers.LocalizeUI>',
        b'callvirt System.Void PixelCrushers.LocalizeUI::UpdateText()')
    assert b'DialogueSystem.Localization::' not in update
    loc = body('localization-language.il', 'System.Void PixelCrushers.DialogueSystem.Localization::set_language(System.String)')
    ordered(loc, b'::m_language', b'ldc.i4.m1', b'::m_currentLanguageID', b'DialogueManager::get_instance()',
        b'::set_currentLanguage(System.String)')
    assert b'::m_useDefaultIfUndefined' not in loc
    iterator = body('ui-start-state.il', 'System.Boolean PixelCrushers.UILocalizationManager/<Start>d__22::MoveNext()')
    ordered(iterator, b'WaitForEndOfFrame', b'IL_0031: ret', b'::get_currentLanguage()', b'::UpdateUIs(System.String)')
    controller = (PRIOR / 'controller-language-master.il').read_bytes()
    ordered(controller, b'::set_currentLanguage(System.String)', b'LocalizationSettings::language',
        b'Localization::set_language(System.String)')
    assert b'Virtual' in body('localize-ui-update.il', 'System.Void PixelCrushers.LocalizeUI::UpdateText()')

    searches = []
    for c in commands:
        if c['type'] != '--find-call-fragment':
            continue
        rows = (HERE / c['output']).read_text().splitlines()
        searches.append(dict(assembly=c['assembly'], operandFragment=c['selection'],
            evidence=c['output'], matchedInstructions=len(rows), matches=rows))
    subscriptions = [s for s in searches if 'add_initializationComplete' in s['operandFragment']]
    assert len(subscriptions) == 4 and all(s['matchedInstructions'] == 0 for s in subscriptions)
    dump(out / 'direct-call-searches.json', dict(
        boundary='Only exact supplied operand fragments in four named DLLs. No absence claim for aliases, fields, reflection, scripts, dynamic/native paths, other DLLs or runtime callbacks.',
        searches=searches))

    facts = []
    for c in commands:
        if c['selection'].startswith('--') or c['type'].startswith('--'):
            continue
        for section in (HERE / c['output']).read_text().split('\nMETHOD ')[1:]:
            header, _, instructions = section.partition('\n')
            lines = instructions.splitlines()
            facts.append(dict(signature=header.split(' |')[0], evidence=c['output'],
                virtual='Virtual' in header,
                fieldWrites=[line for line in lines if ': stfld ' in line or ': stsfld ' in line],
                calls=[line for line in lines if ': call ' in line or ': callvirt ' in line]))
    dump(out / 'language-method-facts.json', dict(
        boundary='Metadata extraction only; virtual targets, Unity callbacks and native methods unexecuted.', methods=facts))
    result = dict(status='passed-static-scoped',
        frozenPinsUnchanged=previous['frozenPinsUnchanged'], helpersChecked=previous['helpersChecked'],
        checkedInstalledSources=previous['checkedInstalledSources'], metadataDllsPinned=previous['metadataDllsPinned'],
        exactCandidateValuesPerCopy=previous['exactCandidateValuesPerCopy'], exactSourceOccurrences=previous['exactSourceOccurrences'],
        sourceCopies=previous['sourceCopies'], targetActorIds=previous['targetActorIds'],
        targetRegistrations=previous['targetRegistrations'], uniqueTargetEntries=previous['uniqueTargetEntries'],
        priorSupplementFilesChecked=len(baseline['priorFiles']), additionalPinsChecked=len(load(HERE / 'binding-pins.json')),
        previousPhase85FilesReproduced=len(previous_files), newSuccessfulMetadataSelections=len(commands),
        successfulNewMethodBodies=len(facts), directSubscriptionQueries=len(subscriptions), directSubscriptionMatches=0,
        fallbackSetterQueries=len(searches)-len(subscriptions),
        fallbackSetterMatches=sum(s['matchedInstructions'] for s in searches if s not in subscriptions),
        regressionAssertions=['UI setter redirects through singleton before synchronous update',
            'UI update prefs before virtual LocalizeUI callbacks; no direct Localization setter',
            'controller UI update precedes settings and Localization writes',
            'Localization stores language and invalidates ID before UI update; fallback flag unchanged',
            'UI Start yields end-of-frame before update', 'unchanged phase85 sixteen-actor inputs'],
        actualInstanceAndLanguage='not-executed/unaccepted', virtualCallbacksAndReentrancy='needs-review',
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
