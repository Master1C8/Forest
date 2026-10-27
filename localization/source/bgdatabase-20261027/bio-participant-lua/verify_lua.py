#!/usr/bin/env python3
"""Verify original actor-name Lua metadata and exact conditional initialization inputs."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
PRIOR = HERE.parent / 'bio-participant-resolution'
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
IDS = [1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 13, 14, 15, 16, 25, 31]


def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda: f.read(4 * 1024 * 1024), b''):
            h.update(b)
    return h.hexdigest()


def load(p):
    return json.loads(p.read_text())


def dump(p, obj):
    p.write_text(json.dumps(obj, ensure_ascii=False, indent=2) + '\n')


def table_index(s, replace_slash=True):
    # Direct table keys, not Lua code: preserve case/backslashes/apostrophes.
    if s is None or s == '':
        return ''
    s = s.replace('"', '_').replace('\n', '\\n').replace('\r', '')
    for ch in ' -()':
        s = s.replace(ch, '_')
    return s.replace('/', '_') if replace_slash else s


def localized_key(field, language):
    return table_index(field if language is None or language == '' or not field
                       else field + '_' + language)


def localized_value(fields, field, language, use_default):
    # Supplied typed values, not real Lua values/tables/metatables.
    v = fields.get(localized_key(field, language))
    if use_default and (v is None or v[0] == 'nil' or
                        (v[0] == 'string' and (v[1] is None or v[1] == ''))):
        v = fields.get(table_index(field))
    return v


def as_string(v):
    # Numeric/boolean ToString behavior is not implemented or claimed.
    if v is None:
        return ''
    assert v[0] in ('string', 'nil')
    return 'nil' if v[0] == 'nil' else v[1]


def display_name(name, fields, language, use_default):
    v = as_string(localized_value(fields, 'Display Name', language, use_default))
    if v is None or v == '' or v == 'nil':
        v = as_string(localized_value(fields, 'Name', language, use_default))
    if v is None or v == '' or v == 'nil':
        v = name
    # Only static inputs without '[' are accepted: dynamic ParseCode is unresolved.
    if v is None:
        return ''
    assert '[' not in v, 'dynamic ParseCode input not accepted'
    return v


def controls():
    rows = []
    def check(name, actual, expected):
        assert actual == expected, (name, actual, expected)
        rows.append(dict(name=name, actual=actual, expected=expected))
    check('null-key-becomes-empty', table_index(None), '')
    check('quote-space-hyphen-parens-slash-lf-cr-key', table_index('A" /B-(C)\nD\rE'), 'A___B__C_\\nDE')
    check('slash-flag-off', table_index('A/B', False), 'A/B')
    check('case-apostrophe-backslash-tab-retained', table_index("A'B\\C\tD"), "A'B\\C\tD")
    check('default-language-null', localized_key('Display Name', None), 'Display_Name')
    check('language-suffix-converted', localized_key('Display Name', 'pt-BR'), 'Display_Name_pt_BR')
    check('language-case-retained', localized_key('Name', 'RU'), 'Name_RU')
    check('whitespace-language-is-not-default', localized_key('Name', ' '), 'Name__')
    check('empty-field-no-suffix', localized_key('', 'ru'), '')
    base = {'Name': ('string', 'BASE')}
    check('missing-localized-use-base', localized_value(base, 'Name', 'ru', True), ('string', 'BASE'))
    check('missing-localized-no-default', localized_value(base, 'Name', 'ru', False), None)
    for typed, label in [(('nil', None), 'nil'), (('string', ''), 'empty'), (('string', None), 'null-string')]:
        check(label+'-localized-falls-back', localized_value({**base, 'Name_ru': typed}, 'Name', 'ru', True), ('string', 'BASE'))
    for typed, label in [(('string', 'nil'), 'literal-nil'), (('string', ' '), 'space'), (('number', 0), 'number-zero'), (('boolean', False), 'boolean-false')]:
        check(label+'-does-not-table-fallback', localized_value({**base, 'Name_ru': typed}, 'Name', 'ru', True), typed)
    check('display-name-precedes-name', display_name('db', {'Display_Name': ('string', 'DISPLAY'), **base}, '', True), 'DISPLAY')
    check('literal-nil-display-uses-name', display_name('db', {'Display_Name': ('string', 'nil'), **base}, '', True), 'BASE')
    check('uppercase-NIL-is-not-nil', display_name('db', {'Display_Name': ('string', 'NIL'), **base}, '', True), 'NIL')
    check('whitespace-display-is-not-empty', display_name('db', {'Display_Name': ('string', ' '), **base}, '', True), ' ')
    check('no-default-field-consumer-still-uses-db-name', display_name('db', base, 'ru', False), 'db')
    check('empty-both-uses-original-db-name', display_name('db', {'Name': ('string', '')}, '', True), 'db')
    check('empty-localized-display-can-prefer-base-display-over-localized-name', display_name('db', {'Display_Name_ru': ('string', ''), 'Display_Name': ('string', 'BASE DISPLAY'), 'Name_ru': ('string', 'LOCAL NAME')}, 'ru', True), 'BASE DISPLAY')
    check('no-result-as-string-empty', as_string(None), '')
    check('actual-nil-string-rendering', as_string(('nil', None)), 'nil')
    try:
        display_name('db', {'Name': ('string', '[var=player]')}, '', True)
    except AssertionError as e:
        check('dynamic-parsecode-rejected-at-intended-boundary', str(e), 'dynamic ParseCode input not accepted')
    else:
        raise AssertionError('dynamic input incorrectly accepted')
    return dict(boundary='Supplied Python transcription. Replaces Lua/.NET/Unity execution, real table/metatable lookup, language and lifecycle selection, mutation and ParseCode evaluation. Not runtime or editorial acceptance.', cases=rows)


def verify(out):
    baseline = load(HERE / 'baseline.json')
    for p, h in baseline['priorFiles'].items():
        assert sha(ROOT / p) == h, p
    for p, h in load(HERE / 'binding-pins.json').items():
        assert sha(ROOT / p) == h, p
    spec = importlib.util.spec_from_file_location('frozen_participants', PRIOR / 'verify_participants.py')
    prior = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(prior)
    previous_out = out / 'prior-participants'
    previous_out.mkdir()
    previous = prior.verify(previous_out)
    previous_files = sorted(p for p in previous_out.rglob('*') if p.is_file())
    for p in previous_files:
        assert p.read_bytes() == (PRIOR / 'readback' / p.relative_to(previous_out)).read_bytes(), p
    commands = load(HERE / 'il-commands.json')
    assert len(commands) == len({c['output'] for c in commands})
    for c in commands:
        assert c['exitCode'] == 0 and sha(HERE / c['output']) == c['sha256']
        actual = subprocess.check_output(['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'), str(DATA / 'Managed' / c['assembly']), c['type'], c['selection']])
        assert actual == (HERE / c['output']).read_bytes(), c['output']
    raw = (HERE / 'actor-field-lookup.il').read_bytes()
    assert b'IL_0027: ldstr "\r"' in raw and b'IL_0018: ldstr "\n"' in raw
    identities = load(previous_out / 'target-actor-identities.json')
    assert [a['pluginActorId'] for a in identities] == IDS
    bg = next(s for s in load(HERE.parent / 'actor-identity/decoded.json')['sheets'] if s['name'] == 'Actor')
    copies, all_rows = [], []
    for copy in load(previous_out / 'source-copies.json'):
        tree = load(ROOT / copy['tree'])
        assert sha(ROOT / copy['tree']) == copy['sha256']
        rows = []
        for identity in identities:
            ai = identity['pluginActorIndex']
            actor = tree['actors'][ai]
            assert actor['id'] == identity['pluginActorId']
            names = [f for f in actor['fields'] if f['title'] == 'Name']
            assert names == identity['exactNameFields'] and len(names) == 1 and names[0]['type'] == 0
            name = names[0]['value']
            assert name == identity['pluginDbName'] and table_index(name) == name
            # Inspect all fields of only the exact sixteen actors, including absent localized variants.
            relevant = [dict(fieldIndex=fi, pointer=f'/actors/{ai}/fields/{fi}', field=f, tableKey=table_index(f['title']))
                        for fi, f in enumerate(actor['fields']) if table_index(f['title']) in ('Name', 'Display_Name') or table_index(f['title']).startswith(('Name_', 'Display_Name_'))]
            assert len(relevant) == 1 and relevant[0]['field'] == names[0]
            keys = [table_index(f['title']) for f in actor['fields']]
            assert len(keys) == len(set(keys)), 'selected actor field key collision'
            matching = [r for r in bg['rows'] if r['id'] == identity['databaseActorRowId']]
            assert len(matching) == 1
            b = matching[0]
            assert b['cells']['plugin_db_name'] == name and b['cells']['name'] == identity['databaseActorDbName']
            fields = {'Name': ('string', name)}
            # Supplied conditions, NOT actual selected locale/current Lua values.
            conditional = [dict(language=l, useDefaultIfUndefined=u, characterInfoName=display_name(name, fields, l, u))
                           for l in ('', 'ru') for u in (False, True)]
            assert all(c['characterInfoName'] == name for c in conditional)
            rows.append(dict(pluginActorId=actor['id'], pluginActorIndex=ai, pluginOriginalName=name,
                actorLuaKey=table_index(name), exactAllFieldTitles=[f['title'] for f in actor['fields']],
                originalNameAndLocalizedFields=relevant, absentBaseDisplayName=True, absentLocalizedNameFields=True,
                conditionalLuaNameValue=dict(type='LuaString', value=name), conditionalDisplayConsumer=conditional,
                bgActorRowId=b['id'], bgActorRowIndex=b['index'], bgDbName=b['cells']['name'],
                bgNameplateName=b['cells']['nameplate_name'], bgNameplateSpan=b['spans']['nameplate_name'],
                bgPluginNameSpan=b['spans']['plugin_db_name'],
                acceptance='Exact original input and conditional initial Name only. Requires this actor table to have been installed and unchanged, no metatable injection/override, and no later Lua/global-user-script/save/lifecycle mutation. BGDatabase NameplateName is a separate consumer. Not live CharacterInfo.Name or displayed-name acceptance.'))
        assert len({r['actorLuaKey'] for r in rows}) == len(IDS)
        copies.append(dict(tree=copy['tree'], sha256=copy['sha256'], selectedActorIds=IDS,
                           globalUserScript=tree.get('globalUserScript'), actorRows=len(rows)))
        all_rows.append(rows)
    assert len(all_rows) == 2 and all_rows[0] == all_rows[1]
    dump(out / 'target-lua-inputs.json', all_rows[0])
    dump(out / 'source-copies.json', copies)
    cases = controls()
    dump(out / 'lua-controls.json', cases)
    result = dict(status='passed-static-scoped', frozenPinsUnchanged=previous['frozenPinsUnchanged'],
        helpersChecked=previous['helpersChecked'], checkedInstalledSources=previous['checkedInstalledSources'],
        metadataDllsPinned=previous['metadataDllsPinned'], exactCandidateValuesPerCopy=previous['exactCandidateValuesPerCopy'],
        exactSourceOccurrences=previous['exactSourceOccurrences'], sourceCopies=2, targetActorIds=IDS,
        targetRegistrations=previous['targetRegistrations'], uniqueTargetEntries=previous['uniqueTargetEntries'],
        previousPhase83FilesReproduced=len(previous_files), priorSupplementFilesChecked=len(baseline['priorFiles']),
        newSuccessfulMetadataSelections=len(commands), successfulNewMethodBodies=sum((HERE / c['output']).read_bytes().count(b'\nMETHOD ') for c in commands),
        failedMetadataSelectionsRetained=len(load(HERE / 'failed-selections.json')['attempts']),
        selectedActorNameFieldsPerCopy=16, selectedActorDisplayOrLocalizedFieldsPerCopy=0,
        conditionalStaticDisplayOutputsPerCopy=64, syntheticControls=len(cases['cases']),
        actualLuaValuesLanguageAndInitialization='not-executed/unaccepted', actualParticipantCacheTransformAndOverride='needs-review',
        nativeSendMessage='not-executed/unaccepted', sourceAcceptance='needs-review', runtime='not-run', visual='not-run',
        editorial='not-run', delivery='needs-review', gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0,
        gitMutations=0, authoredTranslations=0, newDisplayCandidates=0, usage=None)
    dump(out / 'verification.json', result)
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert not args.output.exists(), 'output must be new'
    args.output.mkdir(parents=True)
    print(json.dumps(verify(args.output)))
