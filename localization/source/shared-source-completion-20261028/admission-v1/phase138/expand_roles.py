"""Expand the authored finite command/scene identity subset, not semantic passes.

Only phase137's 255 exact pending selectors are eligible. The remaining output
is an explicit unread-consumer packet, never a default diagnostic classification.
Reads saved original IL and the original index; no DLL execution or extraction.
"""
import hashlib
import json
import re
from collections import Counter
from pathlib import Path

HERE = Path(__file__).resolve().parent
OUT = HERE.parent
ROOT = OUT.parents[3]
INDEX = ROOT / 'outputs/pause-inventory-bio-completion-20261028/managed-index/literals.jsonl'
SET_CLASS = 'System.Void SickDev.CommandSystem.Command::set_className(System.String)'
ADD_COMMAND = 'System.Void SickDev.DevConsole.DevConsole::AddCommand(SickDev.CommandSystem.Command)'
SCENE = 'TheForestOfLove.DevTools.SimulateGameplayVariables'


def load(path):
    return json.loads(path.read_text())


def vh(value):
    return hashlib.sha256(json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(',', ':')).encode()).hexdigest()


def method_bodies(path):
    result = {}
    method = None
    for line in path.read_text().splitlines():
        if line.startswith('METHOD '):
            method = line[7:].split(' | attributes=')[0]
            assert method not in result, 'duplicate-body'
            result[method] = []
        elif line.startswith('IL_'):
            match = re.fullmatch(r'IL_([0-9a-f]+): ([^ ]+)(?: (.*))?', line)
            assert match and method, ('unparsed-il', line)
            result[method].append(dict(offset=int(match[1],16), opcode=match[2], operand=match[3]))
    return result


def registration(source):
    """The full bounded source window: singleton, delegate, command, setter, add."""
    before = source['before'][-6:]
    after = source['after'][:2]
    assert [i['opcode'] for i in before] == ['call','ldnull','ldftn','newobj','newobj','dup'], 'command-producer-window'
    assert before[0]['operand'] == 'SickDev.DevConsole.DevConsole SickDev.CommandSystem.DevConsole::get_singleton()', 'command-receiver'
    assert before[3]['operand'].startswith('System.Void System.Action'), 'command-delegate-constructor'
    assert before[4]['operand'].startswith('System.Void SickDev.CommandSystem.ActionCommand'), 'command-constructor'
    assert [(i['opcode'],i['operand']) for i in after] == [('callvirt',SET_CLASS),('callvirt',ADD_COMMAND)], 'command-registration-window'
    target = before[2]['operand']
    assert target.startswith('System.Void TheForestOfLove.'), 'command-target'
    return target, before, after


def expanded():
    selected = load(OUT/'phase137/next-compiled-selectors.json')
    assert selected['occurrences'] == len(selected['rows']) == 255
    pending = {(r['method'],r['offset']):r for r in selected['rows']}
    assert len(pending) == 255
    original = [json.loads(s) for s in INDEX.read_text().splitlines()]
    current = {(r['method'],r['offset']):r for r in map(json.loads,(HERE/'baseline/managed-literal-inventory.jsonl').read_text().splitlines())}
    files = load(HERE/'game-body-files.json')
    bodies = {}
    for filename in files.values():
        bodies.update(method_bodies(HERE/filename))
    decisions, dependencies, remaining = [], [], []
    for line, r in enumerate(original,1):
        key = r['method'],r['offset']
        if key not in pending:
            continue
        source = pending[key]
        assert source['sourceLine'] == line and source['sourceValueSha256'] == vh(r['value']), 'selected-original-source'
        assert current[key]['role'] == 'needs-consumer-decision', 'selected-prior-role'
        method = bodies[r['method']]
        literal = next(i for i in method if i['offset']==r['offset'])
        assert (literal['opcode'],literal['operand']) == ('ldstr',json.dumps(r['value'],ensure_ascii=False)), 'body-index-literal'
        owner = r['method'].split(' ',1)[1].split('::')[0]
        evidence = [files[owner]]
        role = contract = reason = None
        extra = {}
        if r['after'][0]['operand'] == SET_CLASS:
            target, before, after = registration(r)
            role, contract = 'preserve-visible-command-identity', 'command-namespace-input-and-suggestion'
            reason = 'The exact delegate registration sets _className and useClassName=true. Command.name joins className + dot + delegate method name. ParsedCommand takes the first space-delimited input token; IsOverloadOf uses ordinal-ignore-case equality. Signature.raw and AutoComplete.DrawEntry display that same command, and Select copies Command.name into ConsoleInput.text. Preserve the namespace as executable input and visible identity; no caller prose is excluded.'
            evidence += ['command-ctor.il','action-ctor0.il','action-ctor1.il','action-ctor2.il','action-ctor3.il','command.il','command-manager.il','command-parse.il','command-execute.il','command-signature.il','command-signature-builder.il','console-contract.il','completion.il','completion-matcher.il']
            extra.update(producerWindow=before, registrationTarget=target, registrationWindow=after)
            deps = dict(kind='command-input-and-suggestion', commandTarget=target,
                        assembledCommand=r['value']+'.'+target.split('::')[1].split('(')[0],
                        display='AutoComplete.DrawEntry -> Signature.raw -> UnityEngine.GUI.Label',
                        input='AutoComplete.Select -> ConsoleInput.text -> SubmitInputText -> ParsedCommand -> Command.IsOverloadOf',
                        adaptation='Retain original command spelling. Any future localized help/alias must be a separate display projection that inserts the original executable command; no alias implementation is accepted.')
        elif owner == 'TheForestOfLove.DevConsoleCommands/FastTravelCommands':
            role, contract = 'preserve-scene-event-identity', 'fast-travel-scene-argument'
            reason = 'The complete producer forwards the literal to FollowDoorwayToScene, whose original onEnteringDoorway string event is subscribed to TransitionEffectsManager.ShowExitFade. Both original completion callbacks carry the same sceneName into LoadScene -> SceneHelper.LoadScene. StartMenu instead uses the proved soft-reset followup. Preserve the original event/scene input. This is one proved scene consumer, not an assertion that other serialized/external listeners or display aliases are absent.'
            evidence += ['travel-helper.il','doorway-registration.il','doorway-handler.il','doorway-load.il','doorway-final-load.il','../phase137/scene-contract.il','../phase137/scene-base.il','reset-scene.il','reset-followup.il']
            expected = ('System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadSoftResetScene(System.String)' if r['offset']==10 else 'System.Void TheForestOfLove.DevConsoleCommands/FastTravelCommands::FollowDoorwayToScene(System.String)')
            assert r['after'][0]['operand']==expected and r['after'][0]['opcode']=='call', 'scene-producer-consumer'
            assert method[-1]['opcode']=='ret', 'scene-producer-return'
        elif owner == SCENE+'/SimulationCommands' or (owner == SCENE and '::.cctor()' in r['method']):
            visible = owner.endswith('/SimulationCommands') or r['offset']==0
            role = 'preserve-visible-scene-identity' if visible else 'preserve-scene-state-identity'
            contract = 'simulation-scene-state-and-label' if visible else 'simulation-last-scene-initial-state'
            reason = 'The complete simulation producer passes the exact argument through UpdateSimulatedScene -> ChangeSimulatedScene. That body moves currentSimScene to lastSimScene, stores the argument as currentSimScene, and copies currentSimScene to currentSceneLabel.text. Awake also displays the initial currentSimScene. SceneHelper.GetCurrentSceneRealOrSimName/GetLastSceneRealOrSimName return these exact values for Test_AllCritters; UpdateCurrentSceneName uses the simulated current name. Preserve state identities independently of any future localized display projection. The initial lastSimScene is a state input, with no direct label write proved for that initial value.'
            evidence += ['simulation-helper.il','simulation-state.il','simulation-scene-readers.il']
            if owner.endswith('/SimulationCommands'):
                assert [(i['opcode']) for i in method] == ['ldstr','call','ret'], 'simulation-producer-body'
                assert r['after'][0]['operand'] == 'System.Void '+SCENE+'/SimulationCommands::UpdateSimulatedScene(System.String)', 'simulation-producer-consumer'
            else:
                assert r['after'][0]['opcode']=='stsfld' and r['after'][0]['operand']=='System.String '+SCENE+('::currentSimScene' if visible else '::lastSimScene'), 'simulation-initial-field'
            if visible:
                deps = dict(kind='scene-state-and-label',display='SimulateGameplayVariables.Awake/ChangeSimulatedScene -> currentSceneLabel -> UnityEngine.UI.Text.set_text',
                            input='currentSimScene/lastSimScene -> SceneHelper real-or-sim scene queries',
                            adaptation='Keep original scene state values and place any future localized scene label in a separate projection. Original direct label is retained as source evidence; no alias binding/application is approved.')
        elif owner == 'TheForestOfLove.DevConsoleCommands/MiscCommands':
            consumer = r['after'][0]['operand']
            if consumer == 'System.Void TheForestOfLove.Services.SceneManagement.SceneHelper::LoadSoftResetScene(System.String)':
                role, contract = 'preserve-scene-identity', 'soft-reset-followup-scene'
                reason = 'Original LoadSoftResetScene stores this argument unchanged as Globals.softResetFollowupScene; SoftResetLoadingFinisher.Start reads it before clearing it and calls Unity SceneManager.LoadScene. Preserve the actual resource input.'
                evidence += ['reset-scene.il','reset-followup.il']
            elif consumer in ['System.Boolean TheForestOfLove.Services.Persistence.QuicksaveFileHelper::DebugArchiveSavestate(System.String)','System.Boolean TheForestOfLove.Services.Persistence.QuicksaveFileHelper::DebugRestoreSavestate(System.String)']:
                role, contract = 'preserve-save-file-identity', 'debug-archive-file-path'
                reason = 'The original archive/restore wrappers pass this argument to their Intermediate bodies for both local and persistent settings. Those bodies use it as the exact ES3 FileExists/DeleteFile/CopyFile path. This is a file name, not the separately emitted success/error wording. No file or save operation was executed.'
                evidence += ['debug-save.il','debug-save-path.il']
            else:
                raise AssertionError(('unread-misc-consumer',source['id']))
        if role is None:
            remaining.append(dict(source,bodyEvidence=files[owner],
                predicate='Read the complete named producer plus actual field/return/output consumers. Distinguish console-visible wording and formatting from data/filter/parser keys. Console Log/LogWarning/LogError reach rendered Entry text; a developer namespace does not exclude wording. No semantic role has been assigned to this selector in phase138.'))
            continue
        decision = dict(id=source['id'],method=r['method'],offset=r['offset'],sourceLine=line,
                        sourceValueSha256=vh(r['value']),role=role,contract=contract,reason=reason,evidence=evidence,
                        consumer=r['after'][0],argumentWindow=[r['after'][0]],**extra)
        decisions.append(decision)
        if role in ('preserve-visible-command-identity','preserve-visible-scene-identity'):
            dependencies.append(dict(id=source['id'],method=r['method'],offset=r['offset'],sourceLine=line,
                                     sourceValueSha256=vh(r['value']),source=r['value'],role=role,**deps))
    assert len(decisions)==145 and len(remaining)==110 and len(dependencies)==120, 'finite-identity-partition'
    assert Counter(r['role'] for r in decisions)=={'preserve-visible-command-identity':103,'preserve-scene-event-identity':20,'preserve-visible-scene-identity':17,'preserve-scene-state-identity':1,'preserve-scene-identity':2,'preserve-save-file-identity':2}, 'authored-role-counts'
    return dict(schemaVersion=1,phase='0138-work',selectedOccurrences=255,resolvedOccurrences=145,
                remainingSelectedOccurrences=110,decisions=decisions,
                boundary='Material source-bound identity subset. No default diagnostic or whole-method exclusion, target authoring, semantic/editorial pass or source gate acceptance.'), dependencies, remaining


def products():
    decisions, dependencies, remaining = expanded()
    return {'phase138/compiled-role-decisions.json':decisions,
            'compiled-display-identity-dependencies.json':dict(schemaVersion=1,phase='0138-work',occurrences=120,
                commandNamespaces=103,simulationSceneLabelProducers=17,rows=dependencies,
                boundary='Visible executable/state identities retained separately from target wording. These originals remain exact; display projections and runtime acceptance are unimplemented. This is not a complete game display inventory.'),
            'phase138/next-compiled-selectors.json':dict(schemaVersion=1,scope='remaining-command-console-wording-and-data-consumers',
                occurrences=len(remaining),methods=len({r['method'] for r in remaining}),remainingWholeCompiledScope=1438,
                rows=remaining,source='phase137/next-compiled-selectors.json',
                nextAction='Finish these110 original selectors using complete saved game-01/02/03/05/06/08/09 bodies and actual named consumers. Reuse proved input/suggestion/scene contracts; do not reread the145 accepted identity operands. Then choose a named finite family from the other1328 compiled residuals.',
                boundary='Incomplete packet: exact unread consumer predicates, no default roles. Existing original bodies are fingerprinted evidence, not proof they have all been read.')}


if __name__ == '__main__':
    for name,value in products().items():
        (OUT/name).write_text(json.dumps(value,ensure_ascii=False,indent=2)+'\n')
    print('Expanded145 original identity roles;120 visible identity dependencies;110 selected roles remain.')
