#!/usr/bin/env python3
"""Verify the bounded original BIO dispatch trace; never execute game assemblies."""
import argparse
import collections
import hashlib
import json
from pathlib import Path
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
PRIOR = HERE.parent / 'bio-dialogue-registration'
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')


def sha(path):
    h = hashlib.sha256()
    with path.open('rb') as f:
        for block in iter(lambda: f.read(4 * 1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()


def load(path):
    return json.loads(path.read_text())


def dump(path, value):
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def body(filename, method):
    text = (HERE / filename).read_text()
    matches = [p for p in text.split('\nMETHOD ')[1:] if f'::{method}(' in p.split('\n')[0]]
    assert len(matches) == 1, (filename, method)
    return matches[0]


def normal(registered_arc, incoming_arc, target, incoming, executed=False,
           repeat=False, allow_null=False):
    # CheckTrigger tests INCOMING null on mismatch. It sets executed BEFORE OnExecute.
    if not (incoming_arc == registered_arc or incoming_arc is None and allow_null):
        return dict(action=False, executed=executed, reason='arc-rejected')
    if executed and not repeat:
        return dict(action=False, executed=True, reason='already-executed')
    if incoming != target:
        return dict(action=False, executed=executed, reason='exact-node-rejected')
    return dict(action=True, executed=True, reason='OnExecute-after-mark')


def forced(registered_arc, incoming_arc, executed=False, allow_null=False,
           active=(False, False, False), skip=(False, False, False), direct=False):
    if any(a and s for a, s in zip(active, skip)):
        return dict(action=False, executed=executed, reason='skip-flag-rejected')
    # ForceFireArcTriggers tests REGISTERED null on mismatch. Direct ForceExecute
    # does not filter arc, node or execution state, and does not mark execution.
    if not direct and not (registered_arc == incoming_arc or registered_arc is None and allow_null):
        return dict(action=False, executed=executed, reason='arc-rejected')
    return dict(action=True, executed=executed, reason='OnExecute-without-mark')


def scenarios():
    rows = []
    def check(name, actual, expected):
        assert actual == expected, (name, actual, expected)
        rows.append(dict(name=name, actual=actual, expected=expected))
    ok = dict(action=True, executed=True, reason='OnExecute-after-mark')
    check('normal-exact-positive', normal('a', 'a', (60,155), (60,155)), ok)
    check('normal-wrong-conversation', normal('a', 'a', (60,155), (61,155)),
          dict(action=False, executed=False, reason='exact-node-rejected'))
    check('normal-wrong-entry', normal('a', 'a', (60,155), (60,156)),
          dict(action=False, executed=False, reason='exact-node-rejected'))
    check('normal-wrong-arc', normal('a', 'b', (60,155), (60,155)),
          dict(action=False, executed=False, reason='arc-rejected'))
    check('normal-repeat-blocked', normal('a', 'a', (60,155), (60,155), True),
          dict(action=False, executed=True, reason='already-executed'))
    check('normal-repeat-permitted', normal('a', 'a', (60,155), (60,155), True, True), ok)
    check('normal-null-default-rejected', normal('a', None, (60,155), (60,155)),
          dict(action=False, executed=False, reason='arc-rejected'))
    check('normal-incoming-null-opt-in', normal('a', None, (60,155), (60,155), allow_null=True), ok)
    check('forced-incoming-null-is-different', forced('a', None, allow_null=True),
          dict(action=False, executed=False, reason='arc-rejected'))
    check('forced-registered-null-opt-in', forced(None, 'a', allow_null=True),
          dict(action=True, executed=False, reason='OnExecute-without-mark'))
    for state in (False, True):
        for active_index in range(8):
            active = tuple(bool(active_index & (1 << i)) for i in range(3))
            check(f'bio-forced-defaults-state-{state}-flags-{active_index}',
                  forced('a', 'a', executed=state, active=active),
                  dict(action=True, executed=state, reason='OnExecute-without-mark'))
    for i, name in enumerate(('dialogue-skip', 'chapter-select', 'cheat')):
        active = tuple(j == i for j in range(3))
        check(f'forced-{name}-opt-out', forced('a', 'a', active=active, skip=active),
              dict(action=False, executed=False, reason='skip-flag-rejected'))
    check('direct-force-bypasses-arc', forced('a', 'b', direct=True),
          dict(action=True, executed=False, reason='OnExecute-without-mark'))
    return dict(boundary='Python transcription controls replace game execution; no runtime or reachability proof',
                cases=rows,
                actionOutcomes={'Vslice-active': 'return before lookups; normal execution flag already set',
                    'missing-legacy-key': 'LogError then null; no unlock for unmodified original nonnull lists',
                    'category-member-already-unlocked': 'false; no new event',
                    'category-member-newly-unlocked': 'add dbName-keyed data with StoryClock; OR results then event'})


def build(out):
    baseline = load(HERE / 'baseline.json')
    for p, h in baseline['pins'].items():
        assert sha(Path(p)) == h, p
    for p, h in baseline['owningHelpers'].items():
        assert sha(ROOT / p) == h, p
    groups = {'priorInventoryEvidence': '', 'priorQuestEvidence': 'quest-progress',
        'priorConsumersEvidence': 'quest-consumers', 'priorControlsEvidence': 'quest-controls',
        'priorActorEvidence': 'actor-identity', 'priorBioDetailEvidence': 'bio-detail',
        'priorBioKeywordEvidence': 'bio-keywords', 'priorBioNoteKinkEvidence': 'bio-note-kink',
        'priorRegistrationEvidence': 'bio-dialogue-registration'}
    for group, directory in groups.items():
        for p, h in baseline[group].items():
            assert sha(HERE.parent / directory / p) == h, (group, p)
    prior = load(PRIOR / 'readback/verification.json')
    rechecks = sorted((PRIOR / 'readback').glob('*'))
    assert len(rechecks) == 10
    for p in rechecks:
        assert sha(HERE / 'prior-recheck' / p.name) == sha(p), p.name
    for p, h in prior['checkedInstalledSources'].items():
        assert sha(DATA / p) == h, p
    commands = load(HERE / 'il-commands.json')
    for c in commands:
        result = subprocess.check_output(['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'),
            str(DATA / 'Managed' / c['assembly']), c['type'], c['selection']])
        assert result == (HERE / c['output']).read_bytes(), c['output']
        assert hashlib.sha256(result).hexdigest() == c['sha256'], c['output']
    # Semantic findings are bound to the exact original bodies, including order.
    check = body('trigger-base.il', 'CheckTrigger')
    assert check.index('::set_isExecuted(') < check.index('::OnExecute(')
    assert '::IsConditionSatisfied(' in check and 'skipDuring' not in check
    force = body('trigger-base.il', 'ForceExecute')
    assert '::OnExecute(' in force and all(s not in force for s in ('::set_isExecuted(', '::get_isExecuted(', '::IsConditionSatisfied('))
    ctor = body('trigger-base.il', '.ctor')
    assert all(s not in ctor for s in ('::set_skipDuring', '::set_allowExecute', '::set_isExecuted', '::allowNullArc'))
    assert len((HERE / 'bio-trigger-methods.il').read_text().splitlines()) == 2
    lookup = body('exact-lookups.il', 'GetBioKeywordByPluginDbTriggerName')
    assert '::ContainsKey(!0)' in lookup and 'IL_0033: ldnull\nIL_0034: ret' in lookup
    assert 'IL_0001: brtrue.s IL_0005\nIL_0003: ldc.i4.0\nIL_0004: ret' in body('detail-unlock.il', 'TryUnlockKeyword')
    for name in ('notes', 'kinks'):
        text = body(f'{name}-unlock.il', 'TryUnlockKeyword')
        assert text.index('bne.un.s IL_0059') < text.index('BioKeyword::dbName')
    controls = load(PRIOR / 'readback/bio-registration.json')
    rows = []; outside = []
    for c in controls:
        membership = c['priorCategoryMembership']
        if not c['registrations']:
            outside.append(dict(controlId=c['controlId'], source=c['source'], status=c['status'],
                                globalUse='unverified; retain source candidates'))
        for index, registration in enumerate(c['registrations']):
            actor = c['resolvedActorIdentityCells'][0]
            assert actor['source'] == registration['targetActorDbName']
            outcome = ('missing-key-logs-null-no-unlock-under-original-lists' if c['keywordRowId'] is None else
                       'no-slot-in-any-original-category' if membership['status'] == 'no-current-category-membership' else
                       'potential-category-unlock-dependent-on-current-selection-and-saved-state')
            rows.append(dict(controlId=c['controlId'], registrationIndex=index, source=c['source'],
                registration=registration, exactActorIdentityCell=actor, keywordRowId=c['keywordRowId'],
                normalRequiredArc=registration['arcName'],
                normalRequiredNode=[registration['triggerConversationId'],registration['triggerDialogueEntryId']],
                originalDefaults=dict(isExecuted=False, allowExecuteMoreThanOnce=False, allowNullArc=False,
                                      skipDuringDialogueSkip=False, skipDuringChapterSelect=False, skipDuringCheatCode=False),
                normal='exact arc/node; mark before action; no automatic retry after guard/no-op/error',
                forced='arc filtered by ForceFire; no node/executed check or mark; all three BIO skip flags false',
                directForce='MarkQuestStepAsPlayed null customName executes all dialogue triggers',
                vsliceActive='return before actor/key lookup; normal flag remains marked',
                vsliceInactiveOutcome=outcome, potentialCategoryMembership=membership,
                runtime='not-run; actual selected manifest, events, tags and state remain unverified'))
    counts = dict(collections.Counter(r['vsliceInactiveOutcome'] for r in rows))
    assert len(controls) == 128 and len(rows) == 126 and len(outside) == 3
    assert sorted(counts.values()) == [1, 16, 109]
    cases = scenarios()
    dump(out / 'dispatch-targets.json', rows)
    dump(out / 'outside-registry.json', outside)
    dump(out / 'dispatch-controls.json', cases)
    stats = dict(status='passed-static-scoped', controls=128, registeredControls=125, registrations=126,
        outcomes=counts, unregisteredControls=3, originalBioFlagsAllFalse=True,
        normalMarksBeforeAction=True, forceChecksOrMarksExecution=False,
        noNewDisplayCandidates=True, authoredTranslations=0,
        frozenPinsUnchanged=len(baseline['pins']), helpersChecked=len(baseline['owningHelpers']),
        priorEvidenceHashes={g: len(baseline[g]) for g in groups},
        checkedInstalledSources=prior['checkedInstalledSources'],
        priorRegistrationReadbacksMatched=10, priorFreshIlSelections=prior['currentExactIlSelections'],
        freshIlSelections=len(commands), freshMethodBodies=sum((HERE/c['output']).read_text().count('\nMETHOD ') for c in commands),
        exactSourceValuesPerCopy=12246, sourceCopies=2, exactSourceOccurrences=24492,
        sourceCopyVerification='unchanged phase76 verifier freshly rerun; ten readbacks exact',
        syntheticDispatchControls=len(cases['cases']),
        wholeGameSourceAcceptance=False, storyReachability='not-accepted', successfulManifestConstruction='not-run',
        runtime='not-run', visual='not-run', editorial='not-run', reinsertion='not-run',
        gameAssemblyExecuted=False, imagesOpened=0, gameLaunches=0, gitMutations=0,
        usage='unknown in worker; parent measures telemetry')
    dump(out / 'verification.json', stats)
    return stats


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output', type=Path, required=True)
    args = p.parse_args()
    assert not args.output.exists(), 'output must be new'
    args.output.mkdir(parents=True)
    print(json.dumps(build(args.output)))
