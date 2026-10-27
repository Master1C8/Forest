#!/usr/bin/env python3
"""Capture the actual report landing page; never submit a report or enter text."""
import json
from pathlib import Path
import shutil
import subprocess
import time

import capture_settings as shared

RUN, GAME, SOURCE, DATA = shared.RUN, shared.GAME, shared.SOURCE, shared.DATA
sha, write = shared.sha, shared.write


def command(value):
    allowed = {'show-menu', 'dump', 'quit', 'menu StartScreenMainMenu OnClickOptions',
               'click Canvas/OptionsMenu/Controls/Fullscreen',
               'click Canvas/OptionsMenu/Controls/Back',
               'click Canvas/MainMenu/Patreon/ReportABug',
               'capture ru-01-report-form.png'}
    assert value in allowed, ('report-QA-action-not-allowed', value)
    shared.command(value)


def dump():
    command('dump')
    state = json.loads((RUN / 'state.json').read_text())
    assert state['company'] == 'VNRevivalQA' and state['product'] == 'ForestRuRendererProbe'
    assert state['dataPath'].replace('\\', '/').endswith('/localization/probes/' + RUN.name + '/game/' + DATA)
    return state


def main():
    assert not (RUN / 'launch.json').exists() and not shared.processes()
    build = json.loads((RUN / 'build.json').read_text())
    assert len(build['reportTranslations']) == 20
    originals = {row['path']: sha(SOURCE / DATA / row['path']) for row in build['files']}
    extra = {str(p.relative_to(SOURCE)): sha(p) for p in SOURCE.rglob('tfol.*') if p.is_file()}
    extra[DATA + '/Managed/Assembly-CSharp.dll'] = sha(SOURCE / DATA / 'Managed/Assembly-CSharp.dll')
    write('original-before.json', {'assets': originals, 'other': extra})
    assert not list(GAME.rglob('tfol.*'))
    args = ['/Applications/CrossOver.app/Contents/SharedSupport/CrossOver/bin/wine', '--bottle',
            '/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam', '--no-update', str(shared.EXE),
            '-screen-fullscreen', '0', '-screen-width', '1280', '-screen-height', '720',
            '-logFile', str(RUN / 'player.log')]
    started = time.monotonic()
    success = False
    error = None
    quit_ok = False
    captures = []
    try:
        with (RUN / 'wine.log').open('wb') as log:
            child = subprocess.Popen(args, cwd=GAME, stdout=log, stderr=subprocess.STDOUT, start_new_session=True)
        write('launch.json', {'pid': child.pid, 'startedAt': shared.now(), 'command': args,
                             'buildSha256': sha(RUN / 'build.json'),
                             'captureRecipeSha256': sha(Path(__file__)),
                             'scope': 'Actual Russian report landing page only; no typing, Send or submission confirmation'})
        deadline = time.monotonic() + 300
        while not (RUN / 'player.log').exists() or 'FOREST_PROBE_READY' not in (RUN / 'player.log').read_text(errors='replace'):
            assert time.monotonic() < deadline, 'Report QA startup marker timeout'
            time.sleep(1)
        command('show-menu')
        state = dump()
        assert 'StartScreenMainMenu Canvas/MainMenu' in state['components']
        if not state['fullscreen']:
            command('menu StartScreenMainMenu OnClickOptions')
            state = dump()
            assert 'Canvas/OptionsMenu/Controls/Fullscreen' in state['buttons']
            command('click Canvas/OptionsMenu/Controls/Fullscreen')
            assert dump()['fullscreen']
            command('click Canvas/OptionsMenu/Controls/Back')
            state = dump()
        assert 'Canvas/MainMenu/Patreon/ReportABug' in state['buttons']
        command('click Canvas/MainMenu/Patreon/ReportABug')
        state = dump()
        assert 'BugReportMenu Canvas/BugReportMenu' in state['components']
        rows = [r for r in state['rendererDiagnostics'] if r.startswith('Canvas/BugReportMenu/')]
        required = {'Canvas/BugReportMenu/Controls/MainControls/SystemInfo/Label',
                    'Canvas/BugReportMenu/Controls/MainControls/EditText/Label',
                    'Canvas/BugReportMenu/Controls/SendReport',
                    'Canvas/BugReportMenu/Controls/Instructions'}
        visible = []
        for binding in build['reportTranslations']:
            # Runtime-generated diagnostics remain technical report data.
            if binding['hierarchy'].endswith(('/InfoLeftColumn', '/InfoRightColumn')):
                continue
            matching = [r for r in rows if r.split(' | ', 1)[0] == binding['hierarchy'] or
                        r.startswith(binding['hierarchy'] + '/')]
            if binding['hierarchy'] in required:
                assert len(matching) == 6, ('report-visible-family', binding['hierarchy'], len(matching))
            if matching:
                assert len(matching) == len(binding['textIds'])
                assert all((' | TMPro.TextMeshProUGUI | ' + binding['target'] + ' | ') in r for r in matching), matching
                assert all('overflow=False' in r for r in matching), ('report-text-overflow', matching)
                visible.append(binding['hierarchy'])
        back = [r for r in rows if r.startswith('Canvas/BugReportMenu/Controls/MainControls/Back/Label/')]
        assert len(back) == 6 and all(' | Назад | ' in r for r in back)
        write('report-form-state.json', state)
        write('report-assertions.json', {'visibleFamilies': visible, 'requiredFamilies': sorted(required),
                                       'allVisibleTextLayersMatchAuthoredRussian': True,
                                       'noVisibleTranslatedTextOverflow': True,
                                       'reportSubmitted': False, 'typedInput': False,
                                       'hiddenStatusPanels': 'not exercised; static serialized readback only',
                                       'dynamicSystemInfoColumns': 'not exercised; runtime-generated technical data'})
        command('capture ru-01-report-form.png')
        captures.append('ru-01-report-form.png')
        success = True
        print('Captured actual Russian report landing page', flush=True)
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
        unchanged = all(sha(SOURCE / DATA / name) == h for name, h in originals.items()) and all(sha(SOURCE / name) == h for name, h in extra.items())
        write('cleanup.json', {'taskOwnedProcessesAbsent': not remaining, 'remainingTaskProcessRows': remaining,
                               'verifiedTaskProcessRowsBeforeQuit': owned, 'quitAcknowledged': quit_ok,
                               'inspectionBridgeRemoved': not (GAME / DATA / 'Managed/ForestProbe.dll').exists(),
                               'originalAssemblyRestoredInQACopy': sha(GAME / DATA / 'Managed/Assembly-CSharp.dll') == extra[DATA + '/Managed/Assembly-CSharp.dll'],
                               'originalAssetsAndPlayerFilesUnchanged': unchanged, 'ownerSavePathUsed': False,
                               'candidateAssetHashesUnchanged': all(sha(GAME / DATA / r['path']) == r['probeSha256'] for r in build['files'])})
        write('runtime-result.json', {'automatedResult': 'passed' if success and not remaining and unchanged else 'failed',
                                     'error': error, 'durationSeconds': round(time.monotonic() - started, 3),
                                     'captures': captures, 'reportSubmitted': False, 'typedInput': False,
                                     'buildSha256': sha(RUN / 'build.json'), 'visual': 'pending',
                                     'scope': 'Report landing page and retained settings resources; no submission or hidden status flows'})
    assert success and not remaining and unchanged, error


if __name__ == '__main__':
    main()
