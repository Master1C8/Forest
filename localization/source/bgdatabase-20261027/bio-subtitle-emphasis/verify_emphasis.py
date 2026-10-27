#!/usr/bin/env python3
"""Static original emphasis/constructor source binding; never executes game code."""
import argparse
import collections
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
PRIOR = HERE.parent / 'bio-subtitle-formatting'
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')


def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda: f.read(4 * 1024 * 1024), b''):
            h.update(b)
    return h.hexdigest()


def load(p):
    return json.loads(p.read_text())


def dump(p, value):
    p.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def module(name, p):
    spec = importlib.util.spec_from_file_location(name, p)
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


def extraction(text, settings):
    # Python replacement for original .NET. Single-digit settings counts only;
    # larger/zero character-range grammar and runtime null errors unaccepted.
    emphases = []
    if '[em' not in text:
        return text, emphases
    assert settings is not None, 'emphasis settings required on guarded path'
    assert 1 <= len(settings) <= 9, 'only single-digit positive setting counts transcribed'
    def replace(match):
        index = int(match[0][-2]) - 1
        # Original ignores opening/closing distinction, clears previous record,
        # and assigns whole text with Int32.MaxValue; it does not use match spans.
        emphases.clear()
        emphases.append(dict(startIndex=0, length=2147483647, **settings[index]))
        return ''
    return re.sub(r'\[\/?em[1-' + str(len(settings)) + r']\]', replace, text), emphases


def rich(text, settings):
    if '[em' in text:
        assert settings is not None, 'emphasis settings required on guarded path'
        for index, setting in enumerate(settings, 1):
            opening = f'[em{index}]'
            closing = f'[/em{index}]'
            if opening in text:
                # Supplied webColor replaces original Unity float conversion.
                start = ('<b>' if setting['bold'] else '') + ('<i>' if setting['italic'] else '') + '<color=' + setting['webColor'] + '>'
                end = '</color>' + ('</i>' if setting['italic'] else '') + ('</b>' if setting['bold'] else '')
                text = text.replace(opening, start).replace(closing, end)
    return text, []


def construct(text, emphases, prefix):
    # Exact setters retain properties without trimming or stripping rich text.
    return dict(text=text if text is not None else '', emphases=emphases or [],
        italic=prefix['flags']['[a]'], position=prefix['position'],
        forceMenu=prefix['flags']['[f]'], forceAuto=prefix['flags']['[auto]'],
        noSubtitle=prefix['noSubtitle'], pic=prefix['pictures'][0],
        picActor=prefix['pictures'][1], picConversant=prefix['pictures'][2],
        variableInputPrompt=prefix['variableInputPrompt'], subtitlePanelNumber=prefix['panel'])


def controls(prefix_module):
    cases = []
    def check(name, actual, expected):
        assert actual == expected, (name, actual, expected)
        cases.append(dict(name=name, actual=actual, expected=expected))
    a = dict(color='supplied-A', bold=True, italic=False, underline=True)
    b = dict(color='supplied-B', bold=False, italic=True, underline=False)
    settings = [a, b]
    check('no-open-prefix-bypasses-null-settings-extraction', extraction('[/em1]<pause>[prose]', None), ('[/em1]<pause>[prose]', []))
    check('no-open-prefix-bypasses-null-settings-rich', rich('[/em1]<pause>[prose]', None), ('[/em1]<pause>[prose]', []))
    check('extract-supported-markers-whole-text-single-record', extraction('a[em1]b[/em1]c', settings), ('abc', [dict(startIndex=0,length=2147483647,**a)]))
    check('extract-last-valid-marker-wins-including-closing', extraction('[em1]a[em2]b[/em1]', settings), ('ab', [dict(startIndex=0,length=2147483647,**a)]))
    check('extract-unsupported-case-spacing-and-index-retained', extraction('[em3][EM1][em1 ]', settings), ('[em3][EM1][em1 ]', []))
    check('extract-no-trimming', extraction(' [em1] [/em1] ', settings), ('   ', [dict(startIndex=0,length=2147483647,**a)]))
    check('extract-empty-after-tag-removal', extraction('[em1][/em1]', settings)[0], '')
    supplied = [dict(webColor='#11223344',bold=True,italic=True,underline=True), dict(webColor='#55667788',bold=False,italic=False,underline=False)]
    check('rich-bold-italic-color-order-no-underline', rich('[em1]a[/em1]', supplied), ('<b><i><color=#11223344>a</color></i></b>', []))
    check('rich-opening-only-still-replaced', rich('[em2]a', supplied), ('<color=#55667788>a', []))
    check('rich-empty-markers-produce-nonempty-markup', rich('[em2][/em2]', supplied), ('<color=#55667788></color>', []))
    check('rich-closing-only-preserved-even-with-other-opening', rich('[/em2][em1]a', supplied), ('[/em2]<b><i><color=#11223344>a', []))
    check('rich-all-exact-occurrences-replaced', rich('[em2]a[/em2][em2]b[/em2]', supplied), ('<color=#55667788>a</color><color=#55667788>b</color>', []))
    check('rich-empty-settings-retain-markers', rich('[em1]x[/em1]', []), ('[em1]x[/em1]', []))
    for f, text, settings_value, expected in [
        (extraction,'[em1]x',None,'emphasis settings required on guarded path'),
        (rich,'[em1]x',None,'emphasis settings required on guarded path'),
        (extraction,'[em1]x',[],'only single-digit positive setting counts transcribed'),
        (extraction,'[em1]x',[a]*10,'only single-digit positive setting counts transcribed')]:
        try:
            f(text,settings_value)
        except AssertionError as e:
            reason = str(e)
        else:
            raise AssertionError('guarded unsupported path must reject')
        check('explicit-unsupported-' + f.__name__ + '-' + str(None if settings_value is None else len(settings_value)), reason, expected)
    p = prefix_module.static_prefix('')
    check('constructor-null-text-and-emphases-normalized', (construct(None,None,p)['text'],construct(None,None,p)['emphases']), ('',[]))
    check('constructor-markup-and-whitespace-retained', construct(' <pause><b>x</b> ',[],p)['text'], ' <pause><b>x</b> ')
    check('constructor-empty-and-noSubtitle-independent', (construct('',[],p)['text'],construct('',[],p)['noSubtitle']), ('',False))
    p = prefix_module.static_prefix('[a][f][auto][nosubtitle][pic=2]text')
    check('constructor-keeps-supplied-flags-pictures', [construct('text',[],p)[k] for k in ('italic','forceMenu','forceAuto','noSubtitle','pic','position','subtitlePanelNumber')], [True,True,True,True,2,-1,-1])
    return dict(boundary='Synthetic Python IL transcription with supplied text/settings/web-color. Replaces .NET regex, Unity colors, manager/settings resolution, callbacks, language/initial state, renderer and game execution. Scoped no-[em paths do not evaluate those settings. Not runtime or editorial acceptance.', cases=cases)


def verify(out):
    baseline = load(HERE/'baseline.json')
    for path, expected in baseline['priorFiles'].items():
        assert sha(ROOT/path) == expected, path
    prior = module('frozen_phase80_formatting', PRIOR/'verify_formatting.py')
    prior_out = out/'prior-formatting'
    prior_out.mkdir()
    prior_stats = prior.verify(prior_out)
    prior_files = sorted(p for p in prior_out.rglob('*') if p.is_file())
    for p in prior_files:
        assert p.read_bytes() == (PRIOR/'readback'/p.relative_to(prior_out)).read_bytes(), p
    commands = load(HERE/'il-commands.json')
    assert len(commands) == len({c['output'] for c in commands})
    for c in commands:
        assert c['exitCode'] == 0
        actual = subprocess.check_output(['dotnet',str(ROOT/'tools/probe/bin/Debug/net8.0/InspectMethods.dll'),str(DATA/'Managed'/c['assembly']),c['type'],c['selection']])
        assert actual == (HERE/c['output']).read_bytes(), c['output']
        assert hashlib.sha256(actual).hexdigest() == c['sha256']
    # Bind transcribed conclusions to exact original instruction boundaries.
    il = (HERE/'emphasis-helpers.il').read_text()
    assert 'ldstr "[em"' in il and 'IL_0024: brfalse.s IL_0061' in il and 'IL_000c: brfalse IL_0114' in il
    assert 'IL_0026: ldstr "\\[\\/?em[1-"' in il
    assert 'ldstr "{0}{1}<color={2}>"' in il and 'ldstr "</color>{0}{1}"' in il
    evaluator = (HERE/'extract-evaluator.il').read_text()
    assert 'ldc.i4 2147483647' in evaluator and '::Clear()' in evaluator and '::Add(!0)' in evaluator
    assert '::get_Index()' not in evaluator and 'EmphasisSetting::underline' in evaluator
    rich_body = il.split('METHOD PixelCrushers.DialogueSystem.Emphasis[] PixelCrushers.DialogueSystem.FormattedText::ReplaceEmphasisTagsWithRichText')[1]
    assert 'EmphasisSetting::underline' not in rich_body and 'newarr PixelCrushers.DialogueSystem.Emphasis' in rich_body
    ctor = il.split('METHOD PixelCrushers.DialogueSystem.Emphasis[]')[0]
    assert '::set_text(System.String)' in ctor and '::Trim(' not in ctor
    inputs_module = module('frozen_phase79_inputs', HERE.parent/'bio-subtitle-inputs/verify_inputs.py')
    manifest = load(ROOT/'localization/source/dialogue-manifest.json')
    candidates = [json.loads(s) for s in (ROOT/'localization/source/dialogue-candidates.jsonl').read_text().splitlines()]
    assert len(candidates) == len({c['id'] for c in candidates}) == 12246
    outputs = []; copies = []
    for copy in manifest['sources']:
        assert sha(ROOT/copy['tree']) == copy['treeSha256']
        tree = load(ROOT/copy['tree'])
        for c in candidates:
            value = tree
            for part in c['pointer'].strip('/').split('/'):
                value = value[int(part)] if isinstance(value,list) else value[part]
            assert value == c['source'],c['id']
        convs = {c['id']:c for c in tree['conversations']}
        assert len(convs) == len(tree['conversations'])
        by_kind = {}
        for name in ('target','arc-first'):
            results = []
            for row in load(prior_out/(name+'-formatting.json')):
                matches = [e for e in convs[row['conversationId']]['dialogueEntries'] if e['id']==row['entryId']]
                assert len(matches)==1
                entry = matches[0]
                source_input = inputs_module.inputs(entry['fields'],'')
                assert source_input['rawSubtitle'] == row['rawSubtitle'] and source_input['sequence'] == row['sequence']
                prefix = prior.static_prefix(source_input['rawSubtitle']['value'])
                assert prefix == row['preEmphasis']
                text = prefix['textBeforeEmphasis']
                # Exact case-sensitive original guards skip settings access in BOTH
                # emphasis helpers; no arbitrary manager object/settings is selected.
                assert '[em' not in text
                a = extraction(text,None); b = rich(text,None)
                assert a == b == (text,[])
                formatted = construct(*a,prefix)
                sequence = source_input['sequence']['value']
                identity = {k:row[k] for k in ('controlId','registrationIndex','conversationId','entryId','arcName') if k in row}
                results.append(dict(**identity,rawSubtitle=row['rawSubtitle'],rawSequence=row['sequence'],
                    conditionalFormattedText=formatted,emptyFormattedText=(formatted['text']==''),
                    branchesEquivalentWithoutSettings=True,retainedAngleText=('<' in text or '>' in text),
                    retainedBracketText=('[' in text or ']' in text),originalEntryGroup=entry['isGroup'],
                    ifNotDefaultInitial=inputs_module.initial_sequence(sequence,prompt=formatted['variableInputPrompt'],formatted_empty=(formatted['text']==''),first_entry_group=entry['isGroup']),
                    ifDefaultInitial=inputs_module.initial_sequence(sequence,prompt=formatted['variableInputPrompt'],default_initial=True,formatted_empty=(formatted['text']==''),first_entry_group=entry['isGroup']),
                    acceptance='Conditional unchanged original raw field/sequence and no prior mutation; Parse must be reached successfully with valid manager/display objects. Both emphasis guards bypass settings; actual selected language, callbacks, initial state, Subtitle delivery/rendering/BIO success/reachability unaccepted. Cached arc first does not establish model initial state.'))
            by_kind[name]=results
        outputs.append(by_kind)
        copies.append(dict(tree=copy['tree'],sha256=copy['treeSha256'],exactCandidateValues=12246,targets=len(by_kind['target']),arcs=len(by_kind['arc-first'])))
    assert len(outputs)==2 and outputs[0]==outputs[1]
    stats={}
    for name, rows in outputs[0].items():
        dump(out/(name+'-emphasis.json'),rows)
        stats[name]=dict(rows=len(rows),emptyFormatted=sum(r['emptyFormattedText'] for r in rows),nonemptyFormatted=sum(not r['emptyFormattedText'] for r in rows),
            emphasisPrefixRows=sum('[em' in r['conditionalFormattedText']['text'] for r in rows),emphasisRecords=sum(len(r['conditionalFormattedText']['emphases']) for r in rows),
            branchEquivalentRows=sum(r['branchesEquivalentWithoutSettings'] for r in rows),retainedAngleRows=sum(r['retainedAngleText'] for r in rows),retainedBracketRows=sum(r['retainedBracketText'] for r in rows),
            noSubtitle=sum(r['conditionalFormattedText']['noSubtitle'] for r in rows),
            conditionalDefaultInitialSequenceChanges=sum(r['ifDefaultInitial']['sequence'] != r['rawSequence']['value'] for r in rows),
            conditionalNonDefaultInitialSequenceChanges=sum(r['ifNotDefaultInitial']['sequence'] != r['rawSequence']['value'] for r in rows),
            originalGroupRows=sum(r['originalEntryGroup'] for r in rows))
    cases = controls(prior)
    dump(out/'emphasis-controls.json',cases)
    dump(out/'source-copies.json',copies)
    result=dict(status='passed-static-scoped',frozenPinsUnchanged=prior_stats['frozenPinsUnchanged'],helpersChecked=prior_stats['helpersChecked'],
        priorSupplementFilesChecked=len(baseline['priorFiles']),priorEvidenceHashes=prior_stats['priorEvidenceHashes'],checkedInstalledSources=prior_stats['checkedInstalledSources'],
        reproducedPhase80Readbacks=len(prior_files),reproducedPhase79Readbacks=5,priorPhase80MetadataSelections=17,priorPhase79MetadataSelections=44,
        newMetadataSelections=len(commands),newMethodBodies=sum((HERE/c['output']).read_text().count('\nMETHOD ') for c in commands),failedMetadataSelections=0,
        exactCandidateValuesPerCopy=12246,sourceCopies=2,exactSourceOccurrences=24492,scopedStats=stats,syntheticControls=len(cases['cases']),
        settingsEvidence='not required for unchanged scoped no-[em inputs; actual manager/display/subtitle settings identity and availability NOT accepted',
        actualSubtitleInputs='needs-review: language, prepare/Lua/scene mutations, live manager/state and callback bindings',sourceAcceptance='needs-review',runtime='not-run',visual='not-run',editorial='not-run',delivery='needs-review',
        gameAssemblyExecuted=False,gameLaunches=0,imagesOpened=0,gitMutations=0,authoredTranslations=0,newDisplayCandidates=0,usage=None)
    dump(out/'verification.json',result)
    return result


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args()
    assert not args.output.exists(),'output must be a new directory'
    args.output.mkdir(parents=True)
    print(json.dumps(verify(args.output)))
