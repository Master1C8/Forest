#!/usr/bin/env python3
"""Pin original intro cleanup and consumed38 timing; compile/read back the repair.

Read-only toward every game and prior probe. Does not launch Unity or open images.
"""
import argparse
from collections import Counter
from datetime import datetime
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]
MANAGED = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/Managed')
PRIOR = ROOT / 'localization/probes/ru-20261026-38'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def write(path, value):
    path.write_text(json.dumps(value, indent=2) + '\n')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    parser.add_argument('--scratch', required=True, type=Path)
    args = parser.parse_args()
    out, scratch = args.output.resolve(), args.scratch.resolve()
    assert out.parent == ROOT / 'localization/source' and not out.exists()
    assert ROOT / 'outputs' in scratch.parents and not scratch.exists()
    prior_build = json.loads((PRIOR / 'bridge-build.json').read_text())
    refs = sorted(MANAGED.glob('*.dll'))
    assert {p.name: sha(p) for p in refs} == prior_build['originalManagedReferences']
    assembly = MANAGED / 'Assembly-CSharp.dll'
    assert sha(assembly) == '46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
    original_evidence = json.loads((PRIOR / 'runtime-diagnosis.json').read_text())['evidence']
    assert all(sha(PRIOR / p) == h for p, h in original_evidence.items())
    pin_files = [ROOT / 'outputs/ru-assets-parallel-20261026/input-pins.json']
    pin_files += [ROOT / 'outputs/locale-assets-20261026' / locale / 'input-pins.json'
                  for locale in ['zh', 'es', 'es-419', 'pt-BR', 'ja', 'de']]
    pins = {}
    for path in pin_files:
        for name, value in json.loads(path.read_text()).items():
            assert name not in pins or pins[name] == value
            pins[name] = value
    assert all(sha(Path(p)) == h for p, h in pins.items())
    compiler = Path(prior_build['compiler'])
    assert sha(compiler) == prior_build['compilerSha256']
    inspector = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
    injector = PRIOR / 'bridge-source/bin/Debug/net8.0/InjectProbe.dll'
    startup = json.loads((ROOT / 'localization/source/startup-boundary-20261026/extraction.json').read_text())
    assert sha(inspector) == startup['executables']['inspector']
    assert sha(injector) == prior_build['injectorSha256']
    assert all(sha(ROOT / 'tools/probe' / name) == prior_build['sourceSnapshots'][name]
               for name in ['InjectProbe.cs', 'InjectProbe.csproj'])
    out.mkdir()
    scratch.mkdir(parents=True)
    commands = {}

    def inspect(name, source, type_name, methods):
        argv = ['dotnet', str(inspector), str(source), type_name, methods]
        data = subprocess.check_output(argv, timeout=60)
        (out / name).write_bytes(data)
        commands[name] = argv
        return data.decode()

    inspect('OriginalCleanup.il', assembly, 'TheForestOfLove.IntroBunnyHouseCutscene',
            'Update,ConfigureCutsceneStage,EndCutsceneStage,EndCutscene,FinishCleanup,<ConfigureCutsceneStage>b__23_1,<ConfigureCutsceneStage>b__23_5,<ConfigureCutsceneStage>b__23_8,<ConfigureCutsceneStage>b__23_9')
    inspect('OriginalStages.il', assembly, 'TheForestOfLove.IntroBunnyHouseCutscene/CutsceneStage', '--fields')
    bridge = scratch / 'ForestProbe.dll'
    argv = ['dotnet', str(compiler), '-nologo', '-target:library', '-nostdlib+', '-out:' + str(bridge)]
    argv += ['-r:' + str(p) for p in refs] + [str(ROOT / 'tools/probe/ForestProbe.cs')]
    compiled = subprocess.run(argv, capture_output=True, text=True, timeout=120)
    assert compiled.returncode == 0, compiled.stdout + compiled.stderr
    compact = inspect('BridgeIntro.il', bridge, 'ForestProbe', 'DumpIntro,IntroCleanupDiagnostics,ReadConversation,ReadResponses')
    assert all('ForestProbe::' + name in compact for name in ['ReadResponses()', 'ReadConversation(ForestProbe/State)', 'IntroCleanupDiagnostics()'])
    assert all(token not in compact for token in ['::set_', 'ForestProbe::Dump()', 'TutorialRouteDiagnostics',
        'NotebookRouteDiagnostics', 'CanTrigger', 'IsSatisfied', 'HasAvailableMessages', '::OnClick', '::Invoke()'])
    assert all(token in compact for token in ['Time::get_frameCount()', 'Time::get_realtimeSinceStartup()',
        'Time::get_time()', 'Time::get_timeScale()', 'remainingControllers=', 'activeBedControllers=', 'Cutscene_IntroBunnyHouse'])
    hook = scratch / 'Assembly-CSharp.hook.dll'
    injected = subprocess.run(['dotnet', str(injector), str(MANAGED), str(bridge), str(hook), '--startup-markers'],
                              capture_output=True, text=True, timeout=60)
    assert injected.returncode == 0 and injected.stdout.startswith('Exact probe readback verified; changed methods:'), injected.stdout + injected.stderr
    # Actions use .NET seven-digit fractions. Preserve exact originals, parsing
    # only the six microsecond digits supported by the workstation Python.
    actions = []
    for line in (PRIOR / 'actions.log').read_text().splitlines():
        if ' OK ' in line:
            stamp, command = line.split(' OK ', 1)
            actions.append((datetime.fromisoformat(stamp[:26] + '+00:00'), stamp, command))
    new = next(t for t, _, c in actions if c == 'menu PlayMenu OnClickStart')
    first = next((t, stamp) for t, stamp, c in actions if c.startswith('continue-bound '))
    final = next((t, stamp) for t, stamp, c in actions if c == 'continue-bound 145 249')
    end = next((t, stamp) for t, stamp, c in actions if c == 'restore-input-policy')
    last = [(t, stamp) for t, stamp, c in actions if c == 'dump-tutorial'][-1]
    observations = json.loads((PRIOR / 'newgame-observations.json').read_text())
    timing = dict(newAcknowledgement=next(stamp for _, stamp, c in actions if c == 'menu PlayMenu OnClickStart'),
        firstContinue=first[1], firstContinueAfterNewSeconds=(first[0]-new).total_seconds(),
        finalContinue=final[1], finalContinueAfterNewSeconds=(final[0]-new).total_seconds(),
        lastCleanupSample=last[1], lastCleanupAfterFinalContinueSeconds=(last[0]-final[0]).total_seconds(),
        restore=end[1], restoreAfterNewSeconds=(end[0]-new).total_seconds(),
        commandsAfterNewBeforeRestore=dict(Counter(c.split()[0] for t, _, c in actions if new < t < end[0])),
        observationCount=len(observations), finalRealObservation=observations[-1],
        interpretation='Original Ending timer still active at final sample. Cleanup was incomplete, not proved stuck. Earlier stages and serial diagnostics share old240s budget. Per-command CPU cost/FPS/timeScale and eventual cleanup unobserved; no claimed cause or measured speedup.')
    write(out / 'timing38.json', timing)
    write(out / 'source-trace.json', dict(
        scope='Supplemental consumer/observer repair; frozen inventory, glossaries, all asset lanes unchanged',
        source=[str((out / p).relative_to(ROOT)) for p in ['OriginalCleanup.il', 'OriginalStages.il']],
        originalSemantics=[
            'BunnyLeavesRoom: FadeToBlack1; callback waits4 then FadeFromBlack1.5; its completion advances to Ending.',
            'Ending: EndCutscene removes dialogue-end listener, activates original end trigger, restores player idle threshold and exits cinematic mode, then sets timerSet=True and remaining=3.',
            'Update subtracts Time.deltaTime only while timerSet and remaining>0; at expiry clears timerSet and advances Ending5 to Cleanup6.',
            'Cleanup calls FinishCleanup: EnableInteractionInChildren for the original bed; Destroy own gameObject. Unity deferred destruction needs later real samples.',
            'Final content249, conversation=False, gameplay=True, anyEvent=False or end trigger alone cannot prove cleanup.'],
        repair=[
            'dump-intro reads dialogue, responses, guards, original controller/stage/timer, bed and trigger in one synchronous game-thread callback, recording frame/realtime/scaledTime/timeScale.',
            'Shared ReadResponses/ReadConversation and IntroCleanupDiagnostics preserve full dump/tutorial consumers. No glyph/layout/notebook/quest traversal on each intro observation.',
            'Bootstrap120s/idle60s, dialogue240s/idle30s, cleanup60s/idle15s plus total360s; command waits capped by nearest deadline. Limits are declared harness choices, not source timing guarantees.',
            'Only first-seen source scene/entry, monotone original cutscene stages or decreasing original active timer renew progress. Repetition, typing, acknowledgements and clock changes do not.',
            'Two consecutive distinct advancing real frames must each satisfy original terminal trigger/controller/bed and unchanged gameplay/event guards before any loaded route.'],
        regression='Original New/loading/intro bootstrap precede firstContinue by54.405516s in38. Advancing final dialogue near old global deadline must leave separately bounded observation for original delayed cleanup; repeated frames, stalled/reset timer, repeated content and changing clocks must never manufacture completion or unlimited time.',
        runtime='not-run after repair;38 remains failed, no39 prepared; actual compact serialization/performance and original cleanup acceptance pending'))
    assert all(sha(MANAGED / p) == h for p, h in prior_build['originalManagedReferences'].items())
    assert all(sha(PRIOR / p) == h for p, h in original_evidence.items())
    assert all(sha(Path(p)) == h for p, h in pins.items())
    sources = ['tools/inspect_intro_observation.py', 'tools/probe/ForestProbe.cs', 'tools/probe/diagnose_newgame.py',
               'tools/probe/command.py', 'tools/test_intro_actions.py', 'tools/test_native_input.py']
    write(out / 'verification.json', dict(
        result='passed-static-only', files={p.name: sha(p) for p in out.iterdir()}, commands=commands,
        tools={p: sha(ROOT / p) for p in sources}, compileCommand=argv, compilerOutput=compiled.stdout,
        compilerSha256=sha(compiler), inspectorSha256=sha(inspector), injectorSha256=sha(injector),
        bridgeSha256=sha(bridge), hookSha256=sha(hook), injectionReadback=injected.stdout.strip(),
        originalManagedReferences=prior_build['originalManagedReferences'],
        consumed38EvidenceUnchanged=original_evidence, allAssetLaneInputsUnchanged=pins,
        boundary='Original assembly IL and existing38 timestamps -> source-bound diagnosis; bridge compile/IL checks and exact injection readback. No Unity serialization, FPS, native input, rendered pixels or new runtime acceptance.'))
    print('Intro source/timing supplement, bridge compile and injection readback passed:', out)


if __name__ == '__main__':
    main()
