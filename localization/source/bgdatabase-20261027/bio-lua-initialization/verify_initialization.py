#!/usr/bin/env python3
"""Reproduce bounded original metadata and unchanged sixteen-actor Lua inputs."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
PRIOR = HERE.parent / 'bio-participant-lua'
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


def dump(p, data):
    p.write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n')


def body(path, signature):
    raw = path.read_bytes()
    prefix = ('METHOD ' + signature + ' |').encode()
    assert raw.count(prefix) == 1, signature
    return raw.split(prefix, 1)[1].split(b'\nMETHOD ', 1)[0]


def verify(out):
    baseline = load(HERE / 'baseline.json')
    for p, h in {**baseline['priorFiles'], **load(HERE / 'binding-pins.json')}.items():
        assert sha(ROOT / p) == h, p
    for p, archived in [('README.md', 'previous-summary.md'), ('CHECKPOINT.json', 'previous-checkpoint.json')]:
        assert sha(HERE / archived) == baseline['summaryPins'][p], archived
    spec = importlib.util.spec_from_file_location('frozen_lua', PRIOR / 'verify_lua.py')
    prior = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(prior)
    prev_out = out / 'prior-lua'
    prev_out.mkdir()
    previous = prior.verify(prev_out)
    reproduced = sorted(p for p in prev_out.rglob('*') if p.is_file())
    for p in reproduced:
        assert p.read_bytes() == (PRIOR / 'readback' / p.relative_to(prev_out)).read_bytes(), p
    commands = load(HERE / 'il-commands.json')
    assert len(commands) == len({c['output'] for c in commands})
    for c in commands:
        assert c['exitCode'] == 0 and sha(HERE / c['output']) == c['sha256']
        raw = subprocess.check_output(['dotnet', str(ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'),
            str(DATA / 'Managed' / c['assembly']), c['type'], c['selection']])
        assert raw == (HERE / c['output']).read_bytes(), c['output']
    # Regression at the first divergence: default setter only stores the reference.
    setter = body(HERE / 'manager-default-reset.il',
        'System.Void PixelCrushers.DialogueSystem.DatabaseManager::set_defaultDatabase(PixelCrushers.DialogueSystem.DialogueDatabase)')
    assert b'IL_0002: stfld ' in setter and b'IL_0007: ret' in setter
    assert b'call ' not in setter and b'callvirt ' not in setter
    merge_clear = body(HERE / 'database-merge.il',
        'System.Void PixelCrushers.DialogueSystem.DialogueDatabase::Clear()')
    assert b'::ResetCache()' in merge_clear
    assert b'::globalUserScript' not in merge_clear and b'::emphasisSettings' not in merge_clear
    actor_inputs = load(prev_out / 'target-lua-inputs.json')
    assert [a['pluginActorId'] for a in actor_inputs] == IDS
    assert previous['sourceCopies'] == 2 and previous['targetRegistrations'] == 126
    bindings = [dict(pluginActorId=a['pluginActorId'], pluginActorIndex=a['pluginActorIndex'],
        pluginOriginalName=a['pluginOriginalName'], actorLuaKey=a['actorLuaKey'],
        exactNameFields=a['originalNameAndLocalizedFields'],
        conditionalDisplayOutputs=a['conditionalDisplayConsumer'],
        evidence='prior-lua/target-lua-inputs.json', acceptance='unchanged phase84 conditional input, not live Actor table')
        for a in actor_inputs]
    dump(out / 'target-initialization-inputs.json', bindings)
    scans = [c for c in commands if c['type'] == '--find-call-fragment']
    findings = [dict(assembly=c['assembly'], selection=c['selection'], output=c['output'],
        matchedInstructionCount=len((HERE / c['output']).read_bytes().splitlines())) for c in scans]
    dump(out / 'direct-setter-call-search.json', dict(
        boundary='Metadata operand substring search in exactly three named DLLs; not reflection/Lua/native/string callbacks, other assemblies, all writes, or runtime absence proof.',
        queries=findings))
    result = dict(status='passed-static-scoped', frozenPinsUnchanged=previous['frozenPinsUnchanged'],
        helpersChecked=previous['helpersChecked'], checkedInstalledSources=previous['checkedInstalledSources'],
        metadataDllsPinned=previous['metadataDllsPinned'], exactCandidateValuesPerCopy=previous['exactCandidateValuesPerCopy'],
        exactSourceOccurrences=previous['exactSourceOccurrences'], sourceCopies=2,
        targetActorIds=IDS, targetRegistrations=126, uniqueTargetEntries=114,
        priorSupplementFilesChecked=len(baseline['priorFiles']), additionalPinsChecked=len(load(HERE / 'binding-pins.json')),
        previousPhase84FilesReproduced=len(reproduced), newSuccessfulMetadataSelections=len(commands),
        successfulNewMethodBodies=sum((HERE / c['output']).read_bytes().count(b'\nMETHOD ') for c in commands),
        directSetterSearchAssemblies=sorted({c['assembly'] for c in scans}),
        directSetterSearchQueries=len(scans), directSetterMatchedInstructions=sum(q['matchedInstructionCount'] for q in findings),
        regressionAssertions=['default setter reference-only', 'master Clear preserves globalUserScript/emphasis fields', 'sixteen unchanged conditional identity inputs'],
        actualControllerSelectionInitializationAndLua='not-executed/unaccepted', actualLanguageAndMutation='needs-review',
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
