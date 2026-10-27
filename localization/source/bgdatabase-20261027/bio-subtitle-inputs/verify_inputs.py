#!/usr/bin/env python3
"""Read-only source/metadata verification of the bounded Subtitle input trace."""
import argparse
import collections
import hashlib
import json
from pathlib import Path
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
PRIOR = HERE.parent / 'bio-line-dispatch'
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


def lookup(fields, title):
    # Original List.Find: first exact title; AssignedField rejects null/empty,
    # but does not trim. No case folding, normalization or useDefaultIfUndefined.
    return next((f for f in fields if f['title'] == title), None)


def assigned(fields, title):
    f = lookup(fields, title)
    return f if f is not None and f['value'] not in (None, '') else None


def selected(fields, base, language):
    if base == 'Dialogue Text':
        f = assigned(fields, language) if language else None
    else:
        f = assigned(fields, f'{base} {language}' if language else base)
    f = f if f is not None else lookup(fields, base)
    return dict(field=f['title'] if f else None, value=f['value'] if f else None)


def inputs(fields, language):
    dialogue = selected(fields, 'Dialogue Text', language)
    menu = selected(fields, 'Menu Text', language)
    sequence = selected(fields, 'Sequence', language)
    return dict(languageParameter=language, dialogue=dialogue, menu=menu, sequence=sequence,
                rawSubtitle=dialogue if dialogue['value'] not in (None, '') else menu)


def initial_sequence(sequence, prompt=None, default_initial=False, formatted_empty=False,
                     first_entry_group=False):
    # Synthetic supplied FormattedText outputs replace the actual parsing/Lua path.
    if prompt not in (None, ''):
        sequence = (sequence or '') + ('; ' if sequence not in (None, '') else '') + \
            f'TextInput(Text Field UI,{prompt},{prompt})'
    if default_initial and sequence in (None, '') and formatted_empty:
        sequence = 'None()'
    state_group = first_entry_group
    # Controller tests equality with String.Empty, not IsNullOrEmpty.
    if first_entry_group and sequence == '':
        sequence = 'Continue()'
        state_group = False
    return dict(sequence=sequence, stateGroup=state_group)


def finish(wait, notify, subtitle_gate, last):
    return dict(lineEndPayload=last if not wait and notify and subtitle_gate else None,
                controllerEvent=not wait and notify,
                nextNotify=False if not wait and notify else notify)


def controls():
    result = []
    def check(name, got, expected):
        assert got == expected, (name, got, expected)
        result.append(dict(name=name, actual=got, expected=expected))
    fs = [dict(title=k, value=v) for k, v in [
        ('Dialogue Text', 'base'), ('Menu Text', 'menu'), ('Sequence', ''),
        ('ru', 'locale'), ('Dialogue Text ru', 'wrong-key'), ('Menu Text ru', 'localized menu'),
        ('Sequence ru', 'None()')]]
    check('dialogue-localized-key-is-language-alone', inputs(fs, 'ru')['dialogue'], dict(field='ru', value='locale'))
    check('menu-localized-key-is-suffixed', inputs(fs, 'ru')['menu'], dict(field='Menu Text ru', value='localized menu'))
    check('sequence-localized-key-is-suffixed', inputs(fs, 'ru')['sequence'], dict(field='Sequence ru', value='None()'))
    check('default-language-base-field', inputs(fs, '')['dialogue'], dict(field='Dialogue Text', value='base'))
    check('undefined-language-fallback', inputs(fs, 'zz')['rawSubtitle'], dict(field='Dialogue Text', value='base'))
    check('empty-localized-dialogue-fallback', inputs([dict(title='ru',value=''),dict(title='Dialogue Text',value='base')], 'ru')['rawSubtitle'], dict(field='Dialogue Text',value='base'))
    check('null-localized-dialogue-fallback', inputs([dict(title='ru',value=None),dict(title='Dialogue Text',value='base')], 'ru')['rawSubtitle'], dict(field='Dialogue Text',value='base'))
    check('whitespace-is-assigned', inputs([dict(title='ru',value=' ')], 'ru')['rawSubtitle'], dict(field='ru',value=' '))
    check('empty-dialogue-uses-menu', inputs([dict(title='Dialogue Text',value=''),dict(title='Menu Text',value='menu')], '')['rawSubtitle'], dict(field='Menu Text',value='menu'))
    check('missing-fields-return-null', inputs([], '')['sequence'], dict(field=None,value=None))
    check('lookup-first-exact-duplicate', lookup([dict(title='Sequence',value='first'),dict(title='Sequence',value='second')], 'Sequence'), dict(title='Sequence',value='first'))
    check('lookup-case-sensitive', lookup([dict(title='sequence',value='bad')], 'Sequence'), None)
    check('blank-first-formatted-empty', initial_sequence('',default_initial=True,formatted_empty=True), dict(sequence='None()',stateGroup=False))
    check('explicit-initial-id-does-not-fix-blank', initial_sequence('',formatted_empty=True), dict(sequence='',stateGroup=False))
    check('first-nonempty-formatted-does-not-fix', initial_sequence('',default_initial=True), dict(sequence='',stateGroup=False))
    check('prompt-appended-to-nonempty', initial_sequence('None()',prompt='name'), dict(sequence='None(); TextInput(Text Field UI,name,name)',stateGroup=False))
    check('prompt-inhibits-blank-first-fix', initial_sequence('',prompt='name',default_initial=True,formatted_empty=True), dict(sequence='TextInput(Text Field UI,name,name)',stateGroup=False))
    check('first-group-empty-controller-override', initial_sequence('',first_entry_group=True), dict(sequence='Continue()',stateGroup=False))
    check('first-group-null-is-not-empty-equality', initial_sequence(None,first_entry_group=True), dict(sequence=None,stateGroup=True))
    check('default-first-empty-group-fix-before-controller', initial_sequence('',default_initial=True,formatted_empty=True,first_entry_group=True), dict(sequence='None()',stateGroup=True))
    check('first-hidden-line-no-stored-subtitle-gate', finish(False,True,False,'hidden-current'), dict(lineEndPayload=None,controllerEvent=True,nextNotify=False))
    check('later-hidden-line-retains-prior-subtitle-gate', finish(False,True,True,'hidden-current'), dict(lineEndPayload='hidden-current',controllerEvent=True,nextNotify=False))
    check('wait-for-continue-holds-finish', finish(True,True,True,'current'), dict(lineEndPayload=None,controllerEvent=False,nextNotify=True))
    check('already-notified-does-not-finish-twice', finish(False,False,True,'current'), dict(lineEndPayload=None,controllerEvent=False,nextNotify=False))
    return dict(boundary='Synthetic Python transcription; supplied formatted outputs and callbacks replace original execution. No parse, renderer, Unity object or event delivery acceptance.', cases=result)


def verify(out):
    baseline = load(HERE/'baseline.json')
    directories = dict(priorInventoryEvidence='', priorQuestEvidence='quest-progress',
        priorConsumersEvidence='quest-consumers', priorControlsEvidence='quest-controls',
        priorActorEvidence='actor-identity', priorBioDetailEvidence='bio-detail',
        priorBioKeywordEvidence='bio-keywords', priorBioNoteKinkEvidence='bio-note-kink',
        priorRegistrationEvidence='bio-dialogue-registration', priorTriggerDispatchEvidence='bio-trigger-dispatch',
        priorLineDispatchEvidence='bio-line-dispatch')
    for f,h in baseline['pins'].items():
        assert sha(Path(f)) == h, f
    for f,h in baseline['owningHelpers'].items():
        assert sha(ROOT/f) == h, f
    for group,directory in directories.items():
        for f,h in baseline[group].items():
            assert sha(HERE.parent/directory/f) == h, (group,f)
    previous = load(PRIOR/'readback-v2/verification.json')
    for f,h in previous['checkedInstalledSources'].items():
        assert sha(DATA/f) == h, f
    reproduced = sorted((HERE/'line-recheck').iterdir())
    assert len(reproduced) == 7
    for f in reproduced:
        assert f.read_bytes() == (PRIOR/'readback-v2'/f.name).read_bytes(), f
    commands = load(HERE/'il-commands.json')
    assert len(commands) == len({c['output'] for c in commands})
    for c in commands:
        actual = subprocess.check_output(['dotnet', str(ROOT/'tools/probe/bin/Debug/net8.0/InspectMethods.dll'),
            str(DATA/'Managed'/c['assembly']), c['type'], c['selection']])
        assert actual == (HERE/c['output']).read_bytes(), c['output']
        assert hashlib.sha256(actual).hexdigest() == c['sha256'], c['output']
    view = (HERE/'view-start.il').read_text().split('METHOD System.Boolean')[0]
    assert view.index('::NotifyParticipantsOnConversationLine(') < view.index('::ShouldShowSubtitle(') < view.index('::ShowSubtitle(')
    assert view.index('::NotifyParticipantsOnConversationLine(') < view.index('IL_011a: stfld') < view.index('::PreprocessSequence(')
    assert 'IL_011f: ldarg.1' in view and 'IL_0173: ldarg.0' in view
    end = (HERE/'view-start.il').read_text().split('METHOD System.Void PixelCrushers.DialogueSystem.ConversationView::FinishSubtitle()')[1].split('METHOD ')[0]
    assert end.index('::waitForContinue') < end.index('::Stop()') < end.index('::HideSubtitle(') < end.index('::NotifyParticipantsOnConversationLineEnd(') < end.index('System.EventHandler::Invoke')
    assert '::\u005fsubtitle' in end and '::lastSubtitle' in end
    gate_uses = (HERE/'view-current-subtitle-uses.il').read_text()
    assert gate_uses.count('stfld PixelCrushers.DialogueSystem.Subtitle') == 1
    assert 'StartSubtitle' in gate_uses.splitlines()[0]
    assert '::_subtitle' not in (HERE/'view-initialize.il').read_text()
    assert '::FinishSubtitle()' in (HERE/'view-finished.il').read_text()
    controller_init = (HERE/'controller-initialize.il').read_text()
    assert controller_init.index('ldstr "OnConversationStart"') < controller_init.index('::add_FinishedSubtitleHandler(') < controller_init.index('::GotoState(')
    model = (HERE/'model-state.il').read_text()
    state = model.split('METHOD PixelCrushers.DialogueSystem.ConversationState')[1]
    assert state.index('ldstr "OnPrepareConversationLine"') < state.index('::MarkDialogueEntryDisplayed(') < state.index('::get_subtitleText()') < state.index('FormattedText::Parse(') < state.index('Subtitle::.ctor(')
    assert 'IL_0046: brtrue.s IL_006a' in state and 'IL_0086: brtrue.s IL_00ce' in state
    ctor = (HERE/'model-ctor.il').read_text()
    assert 'IL_009e: ldc.i4.m1' in ctor and 'IL_009f: bne.un.s IL_00bf' in ctor and 'IL_00b9: call System.Void' in ctor
    assert 'IL_022d: call System.Boolean System.String::op_Equality' in (HERE/'controller-start.il').read_text()
    assert 'stfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence' not in (HERE/'cross-assembly-sequence-uses.il').read_text()

    candidates = [json.loads(line) for line in (ROOT/'localization/source/dialogue-candidates.jsonl').read_text().splitlines()]
    assert len(candidates) == len({c['id'] for c in candidates}) == 12246
    targets = load(PRIOR/'readback-v2/target-line-contexts.json')
    arcs = load(PRIOR/'readback-v2/dynamic-arcs.json')
    manifest = load(ROOT/'localization/source/dialogue-manifest.json')
    rows_by_copy = []; copies = []
    for copy in manifest['sources']:
        assert sha(ROOT/copy['tree']) == copy['treeSha256']
        tree = load(ROOT/copy['tree'])
        for c in candidates:
            value = tree
            for part in c['pointer'].strip('/').split('/'):
                value = value[int(part)] if isinstance(value,list) else value[part]
            assert value == c['source'], c['id']
        convs = {c['id']:c for c in tree['conversations']}; assert len(convs)==len(tree['conversations'])
        entries = {cid:{e['id']:e for e in c['dialogueEntries']} for cid,c in convs.items()}
        assert all(len(entries[cid])==len(c['dialogueEntries']) for cid,c in convs.items())
        target_rows = []
        for t in targets:
            r=t['registration']; cid=r['triggerConversationId']; eid=r['triggerDialogueEntryId']; entry=entries[cid][eid]
            assert entry == t['exactTargetEntry']
            assert len({f['title'] for f in entry['fields']}) == len(entry['fields'])
            base=inputs(entry['fields'],''); ru=inputs(entry['fields'],'ru')
            assert {k:v for k,v in base.items() if k!='languageParameter'} == {k:v for k,v in ru.items() if k!='languageParameter'}
            target_rows.append(dict(controlId=t['controlId'],registrationIndex=t['registrationIndex'],
                conversationId=cid,entryId=eid,arcName=r['arcName'],
                originalEntryGroup=entry['isGroup'],originalActorId=t['originalEntryActorId'],
                defaultLanguageInputs=base,ruLanguageParameterInputs=ru,
                rawSequenceSuppressesActorCheck='none' in (base['sequence']['value'] or '').lower(),
                userScript=entry['userScript'],onExecute=entry['onExecute'],
                priorTargetBinding=dict(path=str((PRIOR/'readback-v2/target-line-contexts.json').relative_to(ROOT)),sha256=sha(PRIOR/'readback-v2/target-line-contexts.json')),
                acceptance='Original raw fields only. Mutable prepare/script/scene callbacks precede text/sequence construction; FormattedText and prompt/initial overrides are conditional. No actual Subtitle, event delivery, display, selected state, successful BIO or reachability proof.'))
        arc_rows=[]
        for a in arcs:
            entry=entries[a['conversationId']][a['originalFirstEntryId']]
            assert entry['fields']==a['firstEntryFields']
            arc_rows.append(dict(arcName=a['arcName'],conversationId=a['conversationId'],entryId=entry['id'],
                originalEntryGroup=entry['isGroup'],defaultLanguageInputs=inputs(entry['fields'],''),
                initialOverrideApplicability='Only actual model initial entry; cached arc first entry is not proof of that initial state or formatted text.'))
        rows_by_copy.append(dict(targets=target_rows,arcs=arc_rows))
        copies.append(dict(tree=copy['tree'],sha256=copy['treeSha256'],exactCandidateValues=12246,targets=len(target_rows),arcs=len(arc_rows)))
    assert len(rows_by_copy)==2 and rows_by_copy[0]==rows_by_copy[1]
    result=rows_by_copy[0]; cases=controls()
    for name,value in [('target-inputs.json',result['targets']),('arc-first-inputs.json',result['arcs']),('source-copies.json',copies),('input-controls.json',cases)]:
        dump(out/name,value)
    stats=dict(status='passed-static-scoped',frozenPinsUnchanged=len(baseline['pins']),helpersChecked=len(baseline['owningHelpers']),
        priorEvidenceHashes={k:len(baseline[k]) for k in directories},checkedInstalledSources=previous['checkedInstalledSources'],
        freshlyReproducedPriorLineReadbacks=7,priorFreshSelections=25,priorFreshMethodBodies=39,
        freshIlSelections=len(commands),freshMethodBodies=sum((HERE/c['output']).read_text().count('\nMETHOD ') for c in commands),
        exactCandidateValuesPerCopy=12246,sourceCopies=2,exactSourceOccurrences=24492,
        targetRegistrations=len(result['targets']),arcFirstInputs=len(result['arcs']),
        targetRawSequences=dict(collections.Counter(r['defaultLanguageInputs']['sequence']['value'] for r in result['targets'])),
        targetRawSubtitleFieldChoices=dict(collections.Counter(r['defaultLanguageInputs']['rawSubtitle']['field'] for r in result['targets'])),
        targetGroups=sum(bool(r['originalEntryGroup']) for r in result['targets']),
        targetRawNoneSuppressions=sum(r['rawSequenceSuppressesActorCheck'] for r in result['targets']),
        syntheticControls=len(cases['cases']),newDisplayCandidates=0,authoredTranslations=0,
        wholeGameSourceAcceptance=False,actualSubtitleInputs='not-accepted; mutable prepare/script/scene callbacks and formatting remain',
        callbackOrdering='original local instruction/broadcast order only; object identity, persistent listener order and delivery unaccepted',
        storyReachability='not-accepted',runtime='not-run',visual='not-run',editorial='not-run',reinsertion='not-run',
        gameAssemblyExecuted=False,gameLaunches=0,imagesOpened=0,gitMutations=0,usage='unknown in worker; parent measures telemetry')
    dump(out/'verification.json',stats)
    return stats


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args()
    assert not args.output.exists(), 'output must be new'
    args.output.mkdir(parents=True)
    print(json.dumps(verify(args.output)))
