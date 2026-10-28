"""Verify the finite original title-event serialization boundary; no target edits."""
import argparse
import copy
import hashlib
import json
import subprocess
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
EXPORT = ROOT / 'assets/source-v2'
ASSEMBLY = ROOT / 'localization/probes/ru-20261026-11/game/The Forest of Love_Data/Managed/Assembly-CSharp.dll'
ASSEMBLY_SHA = '46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
CLASS = 'TheForestOfLove.GeneralStoryUIController'
ABSENT = ('onDialogueEmptyWithTitledLine', 'onDialogueLine')


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def inspect_tree(tree):
    for field in ABSENT:
        if field in tree:
            raise ValueError('unexpected-serialized-title-event-field')
    positive = tree.get('onAdvanceMoment')
    if not isinstance(positive, dict) or 'm_PersistentCalls' not in positive:
        raise ValueError('positive-serialized-event-control-missing')
    calls = positive['m_PersistentCalls'].get('m_Calls')
    if not isinstance(calls, list):
        raise ValueError('positive-serialized-event-calls-invalid')
    return calls


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--write', action='store_true')
    args = parser.parse_args()
    authority = ROOT / 'localization/source/shared-source-completion-20261028/parent-handoff.json'
    authority_data = json.loads(authority.read_text())
    objects_path = EXPORT / 'objects.json'
    assert digest(objects_path) == authority_data['sourcePins']['assets/source-v2/objects.json']
    assert digest(ASSEMBLY) == ASSEMBLY_SHA
    metadata = json.loads(subprocess.check_output([
        'dotnet', str(HERE / 'bin/Debug/net8.0/FieldMetadata.dll'), str(ASSEMBLY)
    ]))
    assert metadata == json.loads((HERE / 'field-metadata.json').read_text())
    types = {r['type']: r for r in metadata['types']}
    custom = types['TheForestOfLove.Events.StringPrimitiveEvent']
    assert 'Serializable' not in custom['attributes'] and not custom['customAttributes']
    assert custom['baseType'] == 'UnityEngine.Events.UnityEvent`1<System.String>'
    assert metadata['storyDerivedTypes'] == []
    fields = types['TheForestOfLove.Narrative.DialogueService']['fields']
    assert len(fields) == 1 and fields[0]['isStatic'] is True
    objects = json.loads(objects_path.read_text())
    selected = [o for o in objects if o.get('class') == CLASS]
    assert len(selected) == 39 and len({o['id'] for o in selected}) == 39
    rows, tree_pins = [], {}
    for obj in selected:
        path = EXPORT / obj['tree']
        assert digest(path) == obj['treeSha256']
        tree_pins[str(path.relative_to(ROOT))] = obj['treeSha256']
        tree = json.loads(path.read_text())
        calls = inspect_tree(tree)
        rows.append(dict(object=obj['id'], className=CLASS, tree=obj['tree'],
                         treeSha256=obj['treeSha256'], rawSha256=obj['rawSha256'],
                         script=tree['m_Script'], gameObject=tree['m_GameObject'],
                         enabled=tree['m_Enabled'],
                         fieldPresence={field: 'absent' for field in ABSENT},
                         positiveControlField='onAdvanceMoment', positiveControlCalls=calls))
    changed = copy.deepcopy(tree)
    changed['onDialogueEmptyWithTitledLine'] = None
    try:
        inspect_tree(changed)
    except ValueError as error:
        assert str(error) == 'unexpected-serialized-title-event-field'
    else:
        raise AssertionError('Absent field incorrectly equated with a null event')
    changed = copy.deepcopy(tree)
    del changed['onAdvanceMoment']
    try:
        inspect_tree(changed)
    except ValueError as error:
        assert str(error) == 'positive-serialized-event-control-missing'
    else:
        raise AssertionError('Missing positive control accepted')
    roster = ''.join(json.dumps(r, ensure_ascii=False, separators=(',', ':')) + '\n' for r in rows)
    roster_path = HERE / 'instances.jsonl'
    if args.write:
        with roster_path.open('x') as stream:
            stream.write(roster)
    else:
        assert roster_path.read_text() == roster
    report = dict(
        status='passed-finite-serialized-title-event-boundary',
        originalAssemblySha256=ASSEMBLY_SHA, objectIndexSha256=digest(objects_path),
        metadataSha256=digest(HERE / 'field-metadata.json'),
        inspectorSourceSha256=digest(HERE / 'Program.cs'), inspectorProjectSha256=digest(HERE / 'FieldMetadata.csproj'),
        validatorSha256=digest(Path(__file__)), authoritySha256=digest(authority),
        treePins=tree_pins, instances=39, derivedTypes=0,
        absentTitleEvents=39, absentLineEvents=39, positiveControlEvents=39,
        positiveControlPersistentCalls=sum(len(r['positiveControlCalls']) for r in rows),
        rosterSha256=digest(roster_path), nullDoesNotMeanAbsent=True,
        missingPositiveControlRejected=True,
        decision='No serialized persistent listener table for these two custom fields in any original exported story-controller instance. The service title event is static. Actual code subscriptions retain their separate consumer proofs.',
        boundary='Does not exclude arbitrary reflection/native/external runtime subscribers, decide every remaining database role, or pass common source/translation/runtime gates.',
        commonSourceAccepted=False, translationEntryAllowed=False,
        targetEdits=False, textureEdits=False, gameLaunches=0,
        documentation='https://docs.unity3d.com/2020.3/Documentation/Manual/script-Serialization.html')
    report_path = HERE / 'verification.json'
    if args.write:
        with report_path.open('x') as stream:
            stream.write(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
    else:
        assert json.loads(report_path.read_text()) == report
    print(json.dumps({k: report[k] for k in ('status', 'instances', 'derivedTypes', 'absentTitleEvents', 'positiveControlEvents')}))


if __name__ == '__main__':
    main()
