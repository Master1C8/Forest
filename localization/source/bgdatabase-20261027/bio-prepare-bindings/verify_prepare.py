#!/usr/bin/env python3
"""Reproduce exact prepare/scene metadata and original serialized candidate bindings."""
import argparse
import collections
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
PRIOR = HERE.parent / 'bio-subtitle-emphasis'


def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda: f.read(4 * 1024 * 1024), b''):
            h.update(b)
    return h.hexdigest()


def load(p):
    return json.loads(p.read_text())


def dump(p, v):
    p.write_text(json.dumps(v, ensure_ascii=False, indent=2) + '\n')


def scene_guid(fields):
    # Original LookupValue returns null for an absent first exact-title field.
    f = next((f for f in fields if f['title'] == 'EventGuid'), None)
    return f['value'] if f is not None else None


def scene_event(guid, scene):
    # Supplied scene replaces original Unity object resolution. No null/empty GUID guard.
    if scene is None:
        return None
    return next((e for e in scene if e['guid'] == guid), None)


def controls():
    cases = []
    def check(name, actual, expected):
        assert actual == expected, (name, actual, expected)
        cases.append(dict(name=name, actual=actual, expected=expected))
    check('absent-field-is-null', scene_guid([]), None)
    check('wrong-case-is-absent', scene_guid([dict(title='eventguid', value='x')]), None)
    check('empty-field-is-empty-not-null', scene_guid([dict(title='EventGuid', value='')]), '')
    check('explicit-null-retained', scene_guid([dict(title='EventGuid', value=None)]), None)
    check('first-exact-duplicate-wins', scene_guid([dict(title='EventGuid', value='first'), dict(title='EventGuid', value='second')]), 'first')
    check('whitespace-retained', scene_guid([dict(title='EventGuid', value=' ')]), ' ')
    null = dict(guid=None, marker='null-event')
    empty = dict(guid='', marker='empty-event')
    first = dict(guid='abc', marker='first')
    check('no-scene-returns-null', scene_event(None, None), None)
    check('null-guid-can-match-null-event', scene_event(None, [empty, null]), null)
    check('empty-guid-can-match-empty-event', scene_event('', [null, empty]), empty)
    check('null-does-not-match-empty', scene_event(None, [empty]), None)
    check('exact-guid-case-sensitive', scene_event('ABC', [first]), None)
    check('first-matching-event-wins', scene_event('abc', [first, dict(guid='abc', marker='second')]), first)
    return dict(boundary='Synthetic Python transcription with supplied fields and scene list; replaces .NET List.Find/string equality, Unity object availability/selection, callbacks and execution. No runtime acceptance.', cases=cases)


def serialized_binding():
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    sys.path.insert(0, str(ROOT / 'tools'))
    from extract_assets import read_tree, canonical
    inventory = load(ROOT / 'assets/source-v2/objects.json')
    suffixes = {'DialogueSystemController', 'DialogueSystemEvents', 'DialogueSystemSceneEvents', 'ConversationLogger'}
    candidates = [o for o in inventory if o.get('class', '').split('.')[-1] in suffixes]
    saved = load(HERE / 'serialized-candidates.json')
    assert candidates == saved['objects'] and sha(ROOT / 'assets/source-v2/objects.json') == saved['inventorySha256']
    controllers = [o for o in candidates if o.get('class') == 'PixelCrushers.DialogueSystem.Wrappers.DialogueSystemController']
    assert len(controllers) == 1 and controllers[0]['id'] == 'sharedassets0.assets:4608'
    env = UnityPy.load(str(DATA / 'sharedassets0.assets'))
    objects = {o.path_id: o for o in env.objects}
    assert len(objects) == len(env.objects)
    gen = TypeTreeGenerator('2020.3.24f1')
    gen.load_local_dll_folder(str(DATA / 'Managed'))
    indexed = {o['pathId']: o for o in inventory if o['asset'] == 'sharedassets0.assets'}
    checks = []
    def tree(pid):
        obj = objects[pid]
        t = canonical(read_tree(obj, gen))
        assert hashlib.sha256(obj.get_raw_data()).hexdigest() == indexed[pid]['rawSha256'], pid
        if obj.type.name in ('MonoBehaviour', 'GameObject'):
            p = ROOT / 'assets/source-v2' / indexed[pid]['tree']
            assert t == load(p), (pid, 'exact-export-parity')
            check = dict(path=str(p.relative_to(ROOT)), sha256=sha(p))
            if check not in checks:
                checks.append(check)
        return t
    manager = tree(4608)
    assert manager['m_GameObject'] == dict(m_FileID=0, m_PathID=1297)
    go = tree(1297)
    rows = []
    for c in go['m_Component']:
        ref = c['component']
        assert ref['m_FileID'] == 0
        pid = ref['m_PathID']; obj = objects[pid]; t = tree(pid)
        row = dict(pathId=pid, type=obj.type.name)
        if obj.type.name == 'MonoBehaviour':
            script = obj.parse_monobehaviour_head().m_Script.deref().read()
            classname = (script.m_Namespace + '.' if script.m_Namespace else '') + script.m_ClassName
            assert classname == indexed[pid]['class']
            row.update(className=classname, assembly=script.m_AssemblyName, enabled=t['m_Enabled'], script=t['m_Script'])
        rows.append(row)
    assert len(rows) == 6 and not any(r.get('className', '').endswith(('.ConversationLogger', '.DialogueSystemSceneEvents')) for r in rows)
    return dict(boundary='Original serialized candidate read directly with header-aligned schema and byte/value parity. Does NOT prove instantiated/active/selected manager, loaded scene, listener subscriptions or callback success.',
        inventoryObjects=len(inventory), inventoryCandidates=candidates,
        sceneEventCandidates=sum(o.get('class', '').split('.')[-1] == 'DialogueSystemSceneEvents' for o in candidates),
        conversationLoggerCandidates=sum(o.get('class', '').split('.')[-1] == 'ConversationLogger' for o in candidates),
        candidateManager=dict(component='sharedassets0.assets:4608', gameObject='sharedassets0.assets:1297', gameObjectName=go['m_Name'], serializedActive=go['m_IsActive'],
            components=rows, initialDatabase=manager['initialDatabase'], instantiateDatabase=manager['instantiateDatabase'], allowOnlyOneInstance=manager['allowOnlyOneInstance'], dontDestroyOnLoad=manager['dontDestroyOnLoad']),
        checkedExports=checks, liveSelection='not-run/unaccepted; inventory absence is not absence of dynamically created or later-loaded objects')


def verify(out):
    baseline = load(HERE / 'baseline.json')
    for f, h in baseline['priorFiles'].items():
        assert sha(ROOT / f) == h, f
    pins = load(HERE / 'binding-pins.json')
    for f, h in pins.items():
        assert sha(Path(f)) == h, f
    spec = importlib.util.spec_from_file_location('frozen_phase81', PRIOR / 'verify_emphasis.py')
    prior = importlib.util.module_from_spec(spec); spec.loader.exec_module(prior)
    previous_out = out / 'prior-emphasis'; previous_out.mkdir()
    previous = prior.verify(previous_out)
    previous_files = sorted(p for p in previous_out.rglob('*') if p.is_file())
    for p in previous_files:
        assert p.read_bytes() == (PRIOR / 'readback' / p.relative_to(previous_out)).read_bytes(), p
    commands = load(HERE / 'il-commands.json')
    assert len(commands) == len({c['output'] for c in commands})
    for c in commands:
        assert sha(HERE / c['output']) == c['sha256']
        if c['exitCode'] != 0:
            assert c['output'] == 'events-prepare.il' and 'Unknown method' in (HERE / c['output']).read_text()
            assert '::OnPrepareConversationLine(' not in (HERE / 'events-methods.il').read_text()
            continue  # Historical failure retained, never retried.
        actual = subprocess.check_output(['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'), str(DATA / 'Managed' / c['assembly']), c['type'], c['selection']])
        assert actual == (HERE / c['output']).read_bytes(), c['output']
    scan = subprocess.check_output(['dotnet', str(HERE / 'bin/Debug/net8.0/FindPrepare.dll'), str(DATA / 'Managed')])
    assert scan == (HERE / 'prepare-definitions.json').read_bytes()
    defs = json.loads(scan)
    assert len(defs['definitions']) == 1 and defs['definitions'][0]['type'] == 'PixelCrushers.DialogueSystem.ConversationLogger'
    assert len(defs['assemblies']) == 150
    guid_il = (HERE / 'entry-scene-guid.il').read_text()
    assert 'ldstr "EventGuid"' in guid_il and 'Field::LookupValue(' in guid_il
    value_il = (HERE / 'field-lookup-value.il').read_text()
    assert 'IL_0012: ldnull' in value_il and '::Trim(' not in value_il
    predicate = (HERE / 'scene-find-predicate.il').read_text()
    assert 'System.String::op_Equality' in predicate and '::guid' in predicate
    scene_il = (HERE / 'scene-lookup.il').read_text()
    assert '::Find(' in scene_il and 'System.String::IsNullOrEmpty' not in scene_il
    logger = (HERE / 'logger-prepare.il').read_text()
    assert '::get_currentDialogueText()' in logger and 'UnityEngine.Debug::Log' in logger
    assert 'stfld' not in logger and '::set_' not in logger
    sender = (HERE.parent / 'bio-subtitle-inputs/model-state.il').read_text().split('METHOD PixelCrushers.DialogueSystem.ConversationState')[1]
    assert sender.index('DialogueManager::get_instance()') < sender.index('ldstr "OnPrepareConversationLine"') < sender.index('Component::SendMessage(') < sender.index('::MarkDialogueEntryDisplayed(')
    assert 'IL_0011: ldc.i4.1' in sender and 'DontRequireReceiver = 1' in (HERE / 'send-message-options.il').read_text()
    assert 'impl=InternalCall' in (HERE / 'component-send-message.il').read_text()
    # The GetState order remains unchanged: skipExecution gates scene lookup only later.
    assert sender.index('::get_ConversantID()') < sender.index('::get_sceneEventGuid()') < sender.index('UnityEvent`1<UnityEngine.GameObject>::Invoke') < sender.index('::get_subtitleText()')
    assert 'IL_0086: brtrue.s IL_00ce' in sender
    targets = load(HERE.parent / 'bio-subtitle-inputs/readback-v2/target-inputs.json')
    contexts = load(HERE.parent / 'bio-line-dispatch/readback-v2/target-line-contexts.json')
    assert len(targets) == len(contexts) == 126
    manifest = load(ROOT / 'localization/source/dialogue-manifest.json')
    outputs = []; copies = []
    for copy in manifest['sources']:
        tree = load(ROOT / copy['tree'])
        convs = {c['id']: c for c in tree['conversations']}
        rows = []
        for row, context in zip(targets, contexts):
            assert row['controlId'] == context['controlId'] and row['registrationIndex'] == context['registrationIndex']
            entries = [e for e in convs[row['conversationId']]['dialogueEntries'] if e['id'] == row['entryId']]
            assert len(entries) == 1 and entries[0] == context['exactTargetEntry']
            entry = entries[0]
            exact = [f for f in entry['fields'] if f['title'] == 'EventGuid']
            guid = scene_guid(entry['fields'])
            rows.append(dict(**{k: row[k] for k in ('controlId', 'registrationIndex', 'conversationId', 'entryId', 'arcName')},
                exactEventGuidFields=exact, sceneEventGuid=guid, absentEventGuid=(not exact),
                persistentEntryOnExecuteCalls=len(entry['onExecute']['m_PersistentCalls']['m_Calls']), userScript=entry['userScript'],
                sceneLookup='when skipExecution=false: original lookup receives this conditional GUID after prepare/Lua/onExecute and actor/conversant resolution; null GUID is not an early rejection',
                acceptance='Unchanged source entry only. Dynamic mutation and selected scene instance/list/callback invocation are unaccepted; no absence-of-mutation or successful BIO/reachability claim.'))
        outputs.append(rows)
        copies.append(dict(tree=copy['tree'], sha256=sha(ROOT / copy['tree']), targetRows=len(rows)))
    assert outputs[0] == outputs[1]
    assert all(r['absentEventGuid'] and r['sceneEventGuid'] is None for r in outputs[0])
    dump(out / 'target-prepare-scene.json', outputs[0])
    dump(out / 'source-copies.json', copies)
    binding = serialized_binding(); dump(out / 'serialized-manager-binding.json', binding)
    cases = controls(); dump(out / 'prepare-scene-controls.json', cases)
    result = dict(status='passed-static-scoped', frozenPinsUnchanged=previous['frozenPinsUnchanged'], helpersChecked=previous['helpersChecked'],
        priorSupplementFilesChecked=len(baseline['priorFiles']), priorEvidenceHashes=previous['priorEvidenceHashes'], checkedInstalledSources=previous['checkedInstalledSources'],
        additionalPinsChecked=len(pins), metadataDllsScanned=len(defs['assemblies']), exactPrepareDefinitions=len(defs['definitions']),
        newSuccessfulMetadataSelections=sum(c['exitCode'] == 0 for c in commands), failedMetadataSelections=sum(c['exitCode'] != 0 for c in commands),
        successfulNewMethodBodies=sum((HERE / c['output']).read_text().count('\nMETHOD ') for c in commands if c['exitCode'] == 0),
        reproducedPhase81Readbacks=len(previous_files), exactCandidateValuesPerCopy=12246, sourceCopies=2, exactSourceOccurrences=24492,
        targetRegistrations=len(outputs[0]), uniqueTargetEntries=len({(r['conversationId'], r['entryId']) for r in outputs[0]}),
        targetsWithAbsentEventGuid=sum(r['absentEventGuid'] for r in outputs[0]), targetsWithNullSceneGuid=sum(r['sceneEventGuid'] is None for r in outputs[0]),
        targetsWithPersistentEntryCalls=sum(r['persistentEntryOnExecuteCalls'] != 0 for r in outputs[0]), targetRegistrationsWithUserScript=sum(bool(r['userScript']) for r in outputs[0]),
        serializedManagerCandidates=1, serializedManagerComponents=len(binding['candidateManager']['components']), checkedExportTrees=len(binding['checkedExports']),
        syntheticControls=len(cases['cases']), liveManagerSelection='needs-review', sceneSelectionAndMutation='needs-review',
        nativeSendMessage='InternalCall; delivery and native dispatch not executed or accepted', sourceAcceptance='needs-review', runtime='not-run', visual='not-run', editorial='not-run', delivery='needs-review',
        gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0, gitMutations=0, authoredTranslations=0, newDisplayCandidates=0, usage=None)
    dump(out / 'verification.json', result)
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert not args.output.exists(), 'output must be a new directory'
    args.output.mkdir(parents=True)
    print(json.dumps(verify(args.output)))
