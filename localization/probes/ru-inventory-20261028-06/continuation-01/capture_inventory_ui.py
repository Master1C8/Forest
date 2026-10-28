"""Exercise loaded48 descriptions and original native inventory text consumers.

Uses cloned in-memory item arguments, not awards or owner progress. Native input,
actual ownership and the in-story405 placeholder predicate remain separate gates.
"""
import base64
import json
from pathlib import Path
import shutil
import struct
import subprocess
import time
import sys
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import capture_settings as shared

RUN, GAME, DATA = shared.RUN, shared.GAME, shared.DATA
sha, command = shared.sha, shared.command
def write(name, value):
    if name in ['runtime-result.json', 'cleanup.json']:
        (Path(__file__).resolve().parent / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')
    else:
        shared.write(name, value)


def geometry(label, strict=True):
    command('inventory-geometry')
    rows = []
    for line in (RUN / 'inventory-geometry.tsv').read_text().splitlines():
        fields = line.split('\t'); assert len(fields) == 13, fields
        row = dict(role=fields[0], text=base64.b64decode(fields[1]).decode(), font=fields[2],
                   fontSize=int(fields[3]), alpha=float(fields[4]), width=float(fields[5]),
                   height=float(fields[6]), preferredWidth=float(fields[7]),
                   preferredHeight=float(fields[8]), visibleCharacterCount=int(fields[9]),
                   missingGlyphs=fields[10], sourceColorAlpha=float(fields[11]),
                   verticesOutsideActiveMasks=int(fields[12]))
        row['issues'] = []
        if strict and row['text']:
            if row['sourceColorAlpha'] <= 0 or row['alpha'] < row['sourceColorAlpha'] * .99:
                row['issues'].append('native-text-hidden-or-ancestor-fade')
            if row['missingGlyphs']:
                row['issues'].append('native-missing-glyph')
            if row['visibleCharacterCount'] < len(row['text']):
                row['issues'].append('native-generator-incomplete-character-count')
            if row['verticesOutsideActiveMasks']:
                row['issues'].append('native-glyph-vertices-outside-active-mask')
        row['preferredHeightExceedsRect'] = row['preferredHeight'] > row['height'] + .1
        rows.append(row)
    assert {r['role'] for r in rows} == {'itemTitleText', 'tickerText'}
    return dict(case=label, fields=rows)


def main():
    assert shared.processes() and (RUN / 'launch.json').exists() and not (RUN / 'command.txt').exists()
    for name, digest in json.loads((RUN / 'execution-pins.json').read_text()).items():
        assert sha(Path(name)) == digest, ('inventory-execution-pin', name)
    parent = Path(json.loads((RUN / 'qa-preparation.json').read_text())['parentBuild'])
    parent_hashes = {r['path']: sha(parent / 'game' / DATA / r['path']) for r in json.loads((RUN / 'build.json').read_text())['files']}
    original = RUN / 'Assembly-CSharp.localized-original.dll'
    fixture = {p.name: sha(p) for p in (GAME / DATA).glob('tfol.*') if p.is_file()}
    args = ['/Applications/CrossOver.app/Contents/SharedSupport/CrossOver/bin/wine', '--bottle',
            '/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam', '--no-update', str(shared.EXE),
            '-screen-fullscreen', '0', '-screen-width', '1280', '-screen-height', '720', '-logFile', str(RUN / 'player.log')]
    success = False; error = None; started = time.monotonic(); captures = []; measurements = []; loaded = False
    try:
        state = json.loads((RUN / 'post-timeout-state.json').read_text())
        assert state['scene'] == 'CentralForest' and state['product'] == 'ForestRuInventoryProbe20261028_06'
        command('items-gameplay')
        assert (RUN / 'items-gameplay.txt').read_text().startswith('True|CentralForest')
        command('inventory-readback')
        assert (RUN / 'inventory-readback.tsv').read_bytes() == (RUN / 'inventory-expectations.tsv').read_bytes()
        loaded = True
        command('inventory-open'); time.sleep(2)
        item_types = [int(line.split('\t')[0]) for line in (RUN / 'inventory-expectations.tsv').read_text().splitlines()]
        for item in item_types:
            command('inventory-select owned ' + str(item))
            measurement = geometry('owned-' + str(item), strict=item != 400)
            measurements.append(measurement)
            write('inventory-measurements.json', measurements)
        for case in ['consumed 130', 'zero 130', 'empty-special', 'empty']:
            command('inventory-select ' + case)
            measurements.append(geometry(case))
        visible = [m for m in measurements if m['case'].startswith('owned-') and m['case'] != 'owned-400']
        worst_body = max(visible, key=lambda m: next(r['preferredHeight'] for r in m['fields'] if r['role'] == 'tickerText'))
        worst_title = max(visible, key=lambda m: next((r['preferredHeight'], r['preferredWidth']) for r in m['fields'] if r['role'] == 'itemTitleText'))
        issue_cases = [m['case'].replace('-', ' ', 1) if m['case'].startswith('owned-') else m['case']
                       for m in measurements if any(r['issues'] for r in m['fields'])]
        cases = list(dict.fromkeys([worst_body['case'].replace('-', ' '), worst_title['case'].replace('-', ' '), 'empty-special', 'empty', 'owned 400'] + issue_cases))
        for index, case in enumerate(cases, 1):
            command('inventory-select ' + case); time.sleep(.4)
            geometry(case, strict=case != 'owned 400')
            if case == 'owned 400' and (RUN / 'inventory-glitch-expectations.tsv').exists():
                command('inventory-glitch')
                f = (RUN / 'inventory-glitch-readback.tsv').read_text().strip().split('\t')
                assert len(f) == 10, f
                glitch = dict(title=base64.b64decode(f[0]).decode(), text=base64.b64decode(f[1]).decode(),
                              sourceIndex=int(f[2]), possibleStarts=int(f[3]), maxHeightStart=int(f[4]),
                              maximumPreferredHeight=float(f[5]), width=float(f[6]), height=float(f[7]),
                              outsideVertices=int(f[8]), fontSize=float(f[9]))
                write('inventory-glitch-readback.json', glitch)
                time.sleep(.8)
                command('inventory-glitch-show')
                assert base64.b64decode((RUN / 'inventory-glitch-shown.txt').read_text()).decode() == glitch['text']
            name = 'ru-' + str(index).zfill(2) + '-inventory-' + case.replace(' ', '-') + '.png'
            command('capture ' + name); path = RUN / name
            width, height = struct.unpack('>II', path.read_bytes()[16:24])
            from PIL import Image
            extrema = Image.open(path).convert('RGB').getextrema()
            assert max(c[1] for c in extrema) > 20, 'Blank inventory capture'
            captures.append(dict(filename=name, sha256=sha(path), width=width, height=height, case=case))
        write('inventory-measurements.json', measurements)
        command('inventory-close'); command('display-diagnostics')
        assert not issue_cases, ('native-inventory-geometry-issues', issue_cases)
        success = True
    except BaseException as ex:
        error = repr(ex); print(error, flush=True)
    finally:
        quit_error = None
        if shared.processes() and not (RUN / 'command.txt').exists():
            try:
                command('quit')
            except Exception as ex:
                quit_error = repr(ex)
        deadline = time.monotonic() + 30
        while shared.processes() and time.monotonic() < deadline:
            time.sleep(.5)
        remaining = shared.processes()
        if not remaining:
            shutil.copy2(original, GAME / DATA / 'Managed/Assembly-CSharp.dll')
            (GAME / DATA / 'Managed/ForestProbe.dll').unlink(missing_ok=True)
        unchanged = all(sha(parent / 'game' / DATA / name) == digest for name, digest in parent_hashes.items())
        after = {p.name: sha(p) for p in (GAME / DATA).glob('tfol.*') if p.is_file()}
        write('cleanup.json', dict(taskOwnedProcessesAbsent=not remaining, remainingTaskProcessRows=remaining,
              quitError=quit_error, localizedAssemblyRestored=sha(GAME / DATA / 'Managed/Assembly-CSharp.dll') == sha(original),
              bridgeRemoved=not (GAME / DATA / 'Managed/ForestProbe.dll').exists(), parentArtifactUnchanged=unchanged,
              ownerGameClosedOrControlled=False, ownerSaveFilesUsed=False, qaFixtureBefore=fixture, qaFixtureAfter=after))
        write('runtime-result.json', dict(result='passed' if success and not remaining and unchanged else 'failed',
              error=error, captures=captures, loaded48DescriptionsVerified=loaded, measuredCases=len(measurements), durationSeconds=round(time.monotonic()-started, 3),
              boundary='Assigned48 descriptions/title values and original inventory consumer using shallow-cloned in-memory schema arguments. Readback flag/measuredCases identify actual executed coverage. Source quantities/status remain untouched. Actual input, ownership, item405 in-story override and progression unaccepted. Source color alpha is preserved; preferred-height padding alone does not prove clipping. Native character counts/mask bounds and full-frame visual review are separate.', visual='pending' if captures else 'not-run'))
    assert success and not remaining and unchanged, (error, remaining)
    print('Native inventory consumer/readback checks passed; visual review pending', flush=True)


if __name__ == '__main__':
    main()
