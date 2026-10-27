#!/usr/bin/env python3
"""Check loaded names and the actual native nameplate consumer in isolated QA."""
import json
from pathlib import Path
import shutil
import subprocess
import time

import capture_settings as shared

RUN, GAME, SOURCE, DATA = shared.RUN, shared.GAME, shared.SOURCE, shared.DATA
sha, write = shared.sha, shared.write


def command(value):
    assert value in {'show-menu', 'actor-names', 'quit'}
    shared.command(value)


def main():
    assert not (RUN / 'launch.json').exists() and not shared.processes()
    build = json.loads((RUN / 'build.json').read_text())
    assert len(build['actorDisplayProjection']) == 46
    originals = {r['path']: sha(SOURCE / DATA / r['path']) for r in build['files']}
    extra = {str(p.relative_to(SOURCE)): sha(p) for p in SOURCE.rglob('tfol.*') if p.is_file()}
    extra[DATA + '/Managed/Assembly-CSharp.dll'] = sha(SOURCE / DATA / 'Managed/Assembly-CSharp.dll')
    write('original-before.json', {'assets': originals, 'other': extra})
    assert not list(GAME.rglob('tfol.*'))
    args = ['/Applications/CrossOver.app/Contents/SharedSupport/CrossOver/bin/wine', '--bottle',
            '/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam', '--no-update', str(shared.EXE),
            '-screen-fullscreen', '0', '-screen-width', '1280', '-screen-height', '720',
            '-logFile', str(RUN / 'player.log')]
    started = time.monotonic()
    success = quit_ok = False
    error = None
    try:
        with (RUN / 'wine.log').open('wb') as log:
            child = subprocess.Popen(args, cwd=GAME, stdout=log, stderr=subprocess.STDOUT, start_new_session=True)
        write('launch.json', {'pid': child.pid, 'startedAt': shared.now(), 'command': args,
                             'buildSha256': sha(RUN / 'build.json'),
                             'bridgeSha256': sha(RUN / 'bridge-build.json'),
                             'captureRecipeSha256': sha(Path(__file__)),
                             'scope': 'Actual loaded names and native nameplate consumer; StartMenu reveal bypass only, no saved game or conversation'})
        deadline = time.monotonic() + 300
        while not (RUN / 'player.log').exists() or 'FOREST_PROBE_READY' not in (RUN / 'player.log').read_text(errors='replace'):
            assert time.monotonic() < deadline, 'Actor name QA startup marker timeout'
            time.sleep(1)
        command('show-menu')
        command('actor-names')
        state = json.loads((RUN / 'actor-names.json').read_text())
        assert state['company'] == 'VNRevivalQA' and state['product'] == 'ForestRuRendererProbe'
        assert state['dataPath'].replace('\\', '/').endswith('/localization/probes/' + RUN.name + '/game/' + DATA)
        assert state['scene'] == 'StartMenu' and len(state['actors']) == 39
        plan = json.loads((RUN / 'actor-display-plan.json').read_text())
        expected = {row['identity']: row for row in plan['rows']}
        actual = {row['dbName']: row for row in state['actors']}
        assert len(actual) == 39 and actual.keys() == expected.keys()
        for name, row in actual.items():
            for field, runtime_field in [('nameplate_name', 'nameplate'), ('full_name', 'fullName')]:
                target = expected[name]['target'][field]
                if target is None:
                    assert row.get(runtime_field) in (None, ''), (name, runtime_field, row)
                else:
                    assert row[runtime_field] == target, (name, runtime_field, row)
        assert state['labelText'] == 'Маверик' and state['cyrillicGlyphsPresent'] and state['generated']
        assert state['visibleCharacters'] == 7
        assert 0 < state['textWidth'] <= state['rectWidth'] and 0 < state['textHeight'] <= state['rectHeight']
        write('name-assertions.json', {'runtimeActorsCompared': 39, 'localizedValuesCompared': 46,
                                     'absentRuntimeValuesCompared': 32, 'nativeLabel': state['labelText'],
                                     'allNativeNameGlyphsPresent': True, 'nativeGlyphBoundsFitRect': True,
                                     'sourceNulls': 'Preserved in resource readback; Unity JSON may serialize null strings as empty',
                                     'scenario': 'Original nameplate consumer invoked and restored in StartMenu; original conversation 128:174 not replayed'})
        success = True
        print('All 39 loaded actor records match; actual native nameplate writes Маверик with seven supported glyphs', flush=True)
    except BaseException as ex:
        error = repr(ex)
        print(error, flush=True)
    finally:
        owned = shared.processes()
        if owned and not (RUN / 'command.txt').exists():
            try:
                command('quit')
                quit_ok = True
            except Exception as ex:
                error = (error or '') + ' quit: ' + repr(ex)
        deadline = time.monotonic() + 30
        while shared.processes() and time.monotonic() < deadline:
            time.sleep(.5)
        remaining = shared.processes()
        if not remaining:
            shutil.copy2(SOURCE / DATA / 'Managed/Assembly-CSharp.dll', GAME / DATA / 'Managed/Assembly-CSharp.dll')
            (GAME / DATA / 'Managed/ForestProbe.dll').unlink(missing_ok=True)
        unchanged = all(sha(SOURCE / DATA / n) == h for n, h in originals.items()) and all(sha(SOURCE / n) == h for n, h in extra.items())
        write('cleanup.json', {'taskOwnedProcessesAbsent': not remaining, 'remainingTaskProcessRows': remaining,
                               'verifiedTaskProcessRowsBeforeQuit': owned, 'quitAcknowledged': quit_ok,
                               'inspectionBridgeRemoved': not (GAME / DATA / 'Managed/ForestProbe.dll').exists(),
                               'originalAssemblyRestoredInQACopy': sha(GAME / DATA / 'Managed/Assembly-CSharp.dll') == extra[DATA + '/Managed/Assembly-CSharp.dll'],
                               'originalAssetsAndPlayerFilesUnchanged': unchanged, 'ownerSavePathUsed': False,
                               'candidateAssetHashesUnchanged': all(sha(GAME / DATA / r['path']) == r['probeSha256'] for r in build['files'])})
        write('runtime-result.json', {'automatedResult': 'passed' if success and not remaining and unchanged else 'failed',
                                     'error': error, 'durationSeconds': round(time.monotonic() - started, 3),
                                     'buildSha256': sha(RUN / 'build.json'), 'captures': [],
                                     'boundary': 'Loaded Actor data plus actual native nameplate consumer and glyph generation',
                                     'originalConversationReplayed': False, 'visual': 'not-run; no screenshot pass claimed'})
    assert success and not remaining and unchanged, error


if __name__ == '__main__':
    main()
