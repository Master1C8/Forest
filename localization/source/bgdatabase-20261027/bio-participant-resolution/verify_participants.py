#!/usr/bin/env python3
"""Reproduce bounded original BIO participant metadata and unchanged-source bindings."""
import argparse
from collections import Counter
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
PRIOR = HERE.parent / 'bio-prepare-bindings'
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


def value(fields, title):
    return next((f['value'] for f in fields if f['title'] == title), None)


def source_id(fields, title):
    raw = value(fields, title)
    # Actual source is canonical ASCII decimal. Do not approximate culture-sensitive
    # .NET TryParse for arbitrary strings; malformed/null behavior is in original IL.
    assert isinstance(raw, str) and re.fullmatch(r'0|[1-9][0-9]*', raw), (title, raw)
    result = int(raw)
    assert 0 <= result <= 2147483647
    return result


def controls():
    """Supplied cache/identity/transform controls; replaces all Unity/.NET/Lua calls."""
    rows = []
    def check(name, actual, expected):
        assert actual == expected, (name, actual, expected)
        rows.append(dict(name=name, actual=actual, expected=expected))
    def role_transform(i, actor, conversant):
        if i == actor['id']:
            return actor['transform']
        if i == conversant['id']:
            return conversant['transform']
        return None
    actor = dict(id=1, transform='A')
    conversant = dict(id=3, transform='C')
    check('actor-role-selected-first', role_transform(1, actor, conversant), 'A')
    check('conversant-role-selected', role_transform(3, actor, conversant), 'C')
    check('neither-role-does-not-select-by-name', role_transform(14, actor, conversant), None)
    check('equal-role-ids-actor-wins', role_transform(1, actor, dict(id=1, transform='other')), 'A')
    check('null-actor-transform-not-replaced-by-conversant', role_transform(1, dict(id=1, transform=None), dict(id=1, transform='other')), None)
    def info(i, transform, cache, override=None, numeric=None, registry=None):
        if i in cache:
            return cache[i]
        selected = override if override is not None else numeric
        name = selected['name'] if selected is not None else ''
        if transform is None and name:
            transform = (registry or {}).get(name)
        result = dict(id=selected['id'] if selected is not None else i, nameInDatabase=name,
                      transform=transform, characterTypeRequestedId=i)
        if i != -1:
            cache[i] = result
        return result
    cache = {}
    first = info(3, 'T', cache, override=dict(id=4, name='bear'), numeric=dict(id=3, name='beaver'))
    check('override-id-differs-from-cache-key', first['id'], 4)
    check('character-type-still-uses-requested-id', first['characterTypeRequestedId'], 3)
    check('override-does-not-rekey-cache', list(cache), [3])
    check('cache-hit-ignores-new-transform-and-override', info(3, 'NEW', cache, override=dict(id=5, name='mouse')), first)
    check('missing-override-falls-back-to-numeric', info(3, None, {}, numeric=dict(id=3, name='beaver'))['id'], 3)
    check('missing-database-actor-keeps-requested-id-and-empty-name', info(999, None, {}),
          dict(id=999, nameInDatabase='', transform=None, characterTypeRequestedId=999))
    special = {}
    info(-1, None, special)
    check('minus-one-is-not-cached', special, {})
    check('registered-transform-used-only-when-input-null', info(3, None, {}, numeric=dict(id=3, name='beaver'), registry={'beaver': 'R'})['transform'], 'R')
    check('supplied-transform-precedes-registry', info(3, 'T', {}, numeric=dict(id=3, name='beaver'), registry={'beaver': 'R'})['transform'], 'T')
    check('field-first-exact-title', value([dict(title='actor', value='wrong'), dict(title='Actor', value='3'), dict(title='Actor', value='4')], 'Actor'), '3')
    # This control isolates the original argument-versus-field distinction in .ctor:
    # FindSpecifier changes this.transform, but GetDialogueActorComponent still uses
    # the constructor argument, not the newly found field.
    ctor_argument = None
    stored_transform = 'FOUND'
    check('constructor-found-transform-does-not-change-argument', [stored_transform, ctor_argument], ['FOUND', None])
    # Unregister checks key existence and valid supplied transform, not equality
    # with the previously registered value. This is a source behavior, not a repair.
    registry = {'beaver': 'NEW'}
    supplied_old_transform = 'OLD'
    if supplied_old_transform is not None and 'beaver' in registry:
        del registry['beaver']
    check('unregister-old-transform-removes-new-key', registry, {})
    return dict(boundary='Synthetic Python transcription with supplied participant/cache/database/registry values. Replaces Unity null semantics, component and object search, .NET dictionaries, actor lookups, portraits, Lua/display parsing and callbacks. Original IL and exact source readback are separate evidence; no game/runtime acceptance.', cases=rows)


def verify(out):
    baseline = load(HERE / 'baseline.json')
    for p, h in baseline['priorFiles'].items():
        assert sha(ROOT / p) == h, p
    pins = load(HERE / 'binding-pins.json')
    for p, h in pins.items():
        assert sha(Path(p)) == h, p
    spec = importlib.util.spec_from_file_location('frozen_prepare', PRIOR / 'verify_prepare.py')
    prior = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(prior)
    previous_out = out / 'prior-prepare'
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
    contexts = load(HERE.parent / 'bio-line-dispatch/readback-v2/target-line-contexts.json')
    targets = load(HERE.parent / 'bio-subtitle-inputs/readback-v2/target-inputs.json')
    actors = load(HERE.parent / 'actor-identity/readback/plugin-actor-bindings.json')
    manifest = load(ROOT / 'localization/source/dialogue-manifest.json')
    outputs, mappings, copies = [], [], []
    assert len(contexts) == len(targets) == 126
    for copy in manifest['sources']:
        tree = load(ROOT / copy['tree'])
        by_conv = {}
        for i, c in enumerate(tree['conversations']):
            assert c['id'] not in by_conv
            by_conv[c['id']] = (i, c)
        rows, ids = [], set()
        for context, target in zip(contexts, targets):
            assert (context['controlId'], context['registrationIndex']) == (target['controlId'], target['registrationIndex'])
            ci, conversation = by_conv[target['conversationId']]
            entries = [(i, e) for i, e in enumerate(conversation['dialogueEntries']) if e['id'] == target['entryId']]
            assert len(entries) == 1
            ei, entry = entries[0]
            assert entry == context['exactTargetEntry']
            actor_id, conversant_id = (source_id(entry['fields'], t) for t in ('Actor', 'Conversant'))
            assert actor_id == target['originalActorId'] == context['originalEntryActorId']
            ca, cc = (source_id(conversation['fields'], t) for t in ('Actor', 'Conversant'))
            ids.update([actor_id, conversant_id])
            def assumed_role(i):
                return 'actor' if i == ca else 'conversant' if i == cc else 'neither'
            rows.append(dict(controlId=target['controlId'], registrationIndex=target['registrationIndex'],
                conversationId=target['conversationId'], entryId=target['entryId'], arcName=target['arcName'],
                entryPointer=f'/conversations/{ci}/dialogueEntries/{ei}',
                exactEntryActorFields=[f for f in entry['fields'] if f['title'] == 'Actor'],
                exactEntryConversantFields=[f for f in entry['fields'] if f['title'] == 'Conversant'],
                requestedActorId=actor_id, requestedConversantId=conversant_id,
                originalConversationActorId=ca, originalConversationConversantId=cc,
                actorRoleIfConversationParticipantsUnmodified=assumed_role(actor_id),
                conversantRoleIfConversationParticipantsUnmodified=assumed_role(conversant_id),
                registeredBioTargetDbName=context['registration']['targetActorDbName'],
                acceptance='Exact original fields only. Requested ID is not selected CharacterInfo.id. Role comparison assumes unchanged conversation participants/no DialogueActor override; linked conversation updates/cache/live transforms and mutation remain unaccepted.'))
        assert ids == {1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 13, 14, 15, 16, 25, 31}
        mapping = []
        for i in sorted(ids):
            plugin_matches = [(ai, a) for ai, a in enumerate(tree['actors']) if a['id'] == i]
            assert len(plugin_matches) == 1
            ai, actor = plugin_matches[0]
            name = value(actor['fields'], 'Name')
            prior_matches = [b for b in actors if b['tree'] == copy['tree'] and any(m['actorId'] == i for m in b['matches'])]
            assert len(prior_matches) == 1
            b = prior_matches[0]
            assert len(b['matches']) == 1 and b['matches'][0]['actorIndex'] == ai
            assert b['pluginDbName'] == name == b['matches'][0]['name']
            assert b['treeSha256'] == sha(ROOT / copy['tree'])
            mapping.append(dict(pluginActorId=i, pluginActorIndex=ai, pluginDbName=name,
                databaseActorRowId=b['rowId'], databaseActorDbName=b['dbName'],
                exactNameFields=[f for f in actor['fields'] if f['title'] == 'Name'],
                exactIsPlayerFields=[f for f in actor['fields'] if f['title'] == 'IsPlayer'],
                exactDisplayNameFields=[f for f in actor['fields'] if f['title'] == 'Display Name'],
                namePointer=f'/actors/{ai}/fields/0/value',
                requestedSpeakerOccurrences=sum(x['requestedActorId'] == i for x in rows),
                requestedConversantOccurrences=sum(x['requestedConversantId'] == i for x in rows),
                acceptance='Existing BGDatabase Actor identity -> original plugin ID/Name only; not a selected runtime actor or Transform, displayed name, override, cache or manager identity.'))
        outputs.append(rows)
        mappings.append(mapping)
        copies.append(dict(tree=copy['tree'], sha256=sha(ROOT / copy['tree']), targetRegistrations=len(rows), selectedActorIds=sorted(ids), identityMappings=len(mapping)))
    assert len(outputs) == 2 and outputs[0] == outputs[1] and mappings[0] == mappings[1]
    rows, mapping = outputs[0], mappings[0]
    assert all(r['requestedConversantId'] == 1 for r in rows)
    dump(out / 'target-participants.json', rows)
    dump(out / 'target-actor-identities.json', mapping)
    dump(out / 'source-copies.json', copies)
    case_result = controls()
    dump(out / 'participant-controls.json', case_result)
    result = dict(status='passed-static-scoped', frozenPinsUnchanged=previous['frozenPinsUnchanged'],
        helpersChecked=previous['helpersChecked'], checkedInstalledSources=previous['checkedInstalledSources'],
        priorSupplementFilesChecked=len(baseline['priorFiles']), additionalPinsChecked=len(pins),
        reproducedPhase82Readbacks=len(previous_files), metadataDllsPinned=previous['metadataDllsScanned'],
        newSuccessfulMetadataSelections=len(commands), successfulNewMethodBodies=sum((HERE / c['output']).read_text().count('\nMETHOD ') for c in commands),
        exactCandidateValuesPerCopy=previous['exactCandidateValuesPerCopy'], sourceCopies=len(copies),
        exactSourceOccurrences=previous['exactSourceOccurrences'], targetRegistrations=len(rows),
        uniqueTargetEntries=len({(r['conversationId'], r['entryId']) for r in rows}),
        targetParticipantIds=[x['pluginActorId'] for x in mapping], identityMappingsPerCopy=len(mapping),
        requestedSpeakerIdCounts=dict(sorted(Counter(r['requestedActorId'] for r in rows).items())),
        requestedConversantIdCounts=dict(sorted(Counter(r['requestedConversantId'] for r in rows).items())),
        sourceConversationRoleCounts=dict(Counter(r['actorRoleIfConversationParticipantsUnmodified'] for r in rows)),
        syntheticControls=len(case_result['cases']),
        actualParticipantAndTransformSelection='needs-review', actualCacheAndOverrides='needs-review',
        luaDisplayNamesAndPortraitDependencies='not-executed/unaccepted', nativeSendMessage='not-executed/unaccepted',
        sourceAcceptance='needs-review', runtime='not-run', visual='not-run', editorial='not-run', delivery='needs-review',
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
