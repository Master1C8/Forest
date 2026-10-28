#!/usr/bin/env python3
"""Finite chapter/gallery preparation and capture on a parent-owned isolated game.

Never launches a game, navigates a scene, terminates a process or requests a model.
prepare requires accepted134 inputs, complete candidate readback and an already
isolated staging directory. capture attaches only to an exact parent-recorded PID.
Parent establishes each original native screen and closes the game before finish.
"""
import argparse
import base64
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = Path('/Users/antonkrutov/Desktop/Forest')
DATA = 'The Forest of Love_Data'
BASELINE = ROOT / 'localization/previews/ru-20261028-texture-preserving-17'
SURFACES = ('gallery', 'oos', 'description')


def require(ok, reason):
    if not ok:
        raise ValueError(reason)


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def read(path):
    return json.loads(Path(path).read_bytes())


def write(path, value, exclusive=False):
    path = Path(path)
    raw = (json.dumps(value, ensure_ascii=False, indent=2) + '\n').encode()
    if exclusive:
        with path.open('xb') as stream:
            stream.write(raw)
    else:
        temp = path.with_name(path.name + '.pending')
        with temp.open('xb') as stream:
            stream.write(raw)
        temp.replace(path)


def b64(value):
    return '~' if value is None else base64.b64encode(value.encode()).decode()


def adapter():
    # Used only before preparation; execution uses frozen bytes, never a live adapter.
    sys.path.insert(0, str(ROOT / 'tools'))
    import russian_chapter_gallery_case
    return russian_chapter_gallery_case


def make_plan(plan, *, static_preflight=False):
    a = adapter()
    targets, source = a._use(plan, 'ru', static_preflight)
    absent = a.jsonl(plan.packet['absence.jsonl'])
    bg = [s for s in source if s['id'].startswith('bgdb:')]
    require(len(bg) == 113 and len(absent) == 16, 'corpus-count')
    values = [(s['id'], s['sheet'], str(s['rowIndex']), s['field'], b64(targets[s['id']]['target'])) for s in bg]
    values += [(s['id'], s['sheet'], str(s['rowIndex']), s['field'], '~') for s in absent]
    words = {name: next(targets[s['id']]['target'] for s in source if s['source'] == value and s['id'].startswith('il:'))
             for name, value in [('movie', 'Movie {0}'), ('story', 'Story {0}'), ('fallback', 'No hint available!')]}
    words['wrapper'] = "''{0}''"  # Pinned producer-context outOfSync.wrapper, never invoke BaseSpawner.
    producer = read(a.SOURCE / 'producer-context.json')
    require(producer['outOfSync']['wrapper'] == words['wrapper'], 'original-wrapper')
    selection = a.jsonl((a.SOURCE / 'selection-identities.jsonl').read_bytes())
    require(len(selection) == 59 and [sum('/' + k + '/' in s['id'] for s in selection) for k in ['movieOptions', 'storyOptions']] == [11, 48], 'selection-count')
    cases = []
    hints = [s for s in bg if s['field'] == 'hint_phrase']
    for s in hints:
        for option in selection:
            kind = 'movie' if '/movieOptions/' in option['id'] else 'story'
            ordinal = option['zeroBasedIndex']
            identifier = words[kind].format(ordinal + 1)
            hint = targets[s['id']]['target']
            cases.append(dict(surface='gallery', branch=kind, rowIndex=s['rowIndex'], kind=kind, ordinal=ordinal,
                              argument=hint, expected=identifier + '\n\n' + hint, sourceId=s['id'], selectionId=option['id'],
                              fixture='conservative hint/identifier argument cross-product; actual selection eligibility unaccepted'))
    for branch, value in [('missing', None), ('null', None), ('empty', ''), ('whitespace', ' \t\r\n')]:
        cases.append(dict(surface='gallery', branch=branch, rowIndex=hints[0]['rowIndex'], kind='movie', ordinal=0,
                          argument=value, expected=words['fallback'], sourceId=None, selectionId=None,
                          fixture='missing map entry or cloned hint argument; original map/statics restored in same Update'))
    for s in bg:
        if s['field'] in ('title', 'description'):
            value = targets[s['id']]['target']
            cases.append(dict(surface='oos' if s['field'] == 'title' else 'description', branch=s['field'],
                              rowIndex=s['rowIndex'], kind='none', ordinal=0, argument=value,
                              expected=words['wrapper'].format(value) if s['field'] == 'title' else value,
                              sourceId=s['id'], selectionId=None, fixture='original setter; wrapper is exact literal argument fixture, not BaseSpawner progression'))
    counts = {surface: sum(c['surface'] == surface for c in cases) for surface in SURFACES}
    require(counts == {'gallery': 3367, 'oos': 28, 'description': 28}, 'finite-workload-count')
    for index, case in enumerate(cases):
        case['index'] = index
    native = [dict(surface='gallery' if s['id'].startswith('sharedassets0') else 'oos' if 'OutOfSync' in s.get('hierarchy', '') else 'unknown-adventure',
                   id=s['id'], hierarchy=s['hierarchy'], expected=targets[s['id']]['target']) for s in source if s['id'].startswith('sharedassets')]
    # Resolve groups from the pinned producer membership, not hierarchy wording.
    known_oos = set(next(r for r in producer['serializedProducerBindings'] if r['group'] == 'out-of-sync')['exactPotentialTmpDescendants'])
    for item in native:
        if item['id'] in known_oos:
            item['surface'] = 'oos'
    return dict(schemaVersion=1, mode=plan.mode, locale='ru', counts=counts, values=values, words=words, cases=cases, native=native, selection=selection,
                targetSha256=json.loads(plan.acceptance_bytes).get('targetSha256'), sourcePins=a.SOURCE_PINS,
                nativeInitialSelectors=18, unknownAdventureNameSelectors=6, ordinaryTranslationEntryAllowed=False,
                globalPretranslationPassed=False, wholeGameAccepted=False, visualAccepted=False,
                coverage='3363 hint/identifier cross-product fixtures +4 fallback branches +28 wrapped titles +28 descriptions; complete geometry, bounded representative captures')


def candidate_version_binding(proof, candidate, build, target_sha256, source_pins):
    """Pure version predicate; it cannot grant editorial or candidate acceptance."""
    require(proof['buildSha256'] == sha(candidate / 'build.json') and proof['targetSha256'] == target_sha256 and proof['sourcePins'] == source_pins, 'candidate-version-binding')
    require(proof['baselineBuildSha256'] == sha(BASELINE / 'build.json'), 'candidate17-baseline')
    require(proof['files'] == {r['path']: r['probeSha256'] for r in build['files']}, 'complete-candidate-file-binding')


def validate_candidate(candidate, *, locale='ru'):
    # This guard precedes even path checks or destination creation.
    a = adapter()
    plan = a.load_inputs(locale=locale)
    candidate = Path(candidate).resolve()
    require(candidate.parent == ROOT / 'localization/previews', 'canonical-candidate-required')
    build = read(candidate / 'build.json')
    require(build['siteLocale'] == 'ru', 'candidate-locale')
    for row in build['files']:
        path = (candidate / 'game' / DATA / row['path']).resolve()
        require(path.is_relative_to(candidate / 'game' / DATA) and sha(path) == row['probeSha256'], 'candidate-file:' + row['path'])
    proof = read(candidate / 'chapter-gallery-readback.json')
    acceptance = json.loads(plan.acceptance_bytes)
    require(proof['status'] == 'complete-static-readback' and proof['caseId'] == a.CASE and proof['locale'] == 'ru', 'complete-candidate-readback-required')
    candidate_version_binding(proof, candidate, build, acceptance['targetSha256'], a.SOURCE_PINS)
    bg = proof['bg']; native = proof['native']; managed = proof['managed']
    ids = {r['id']: r['targetSha256'] for r in plan.rows}
    source = a.jsonl(plan.packet['source.jsonl'])
    require(bg['mode'] == 'editorial-accepted' and bg['selectedCells'] == 113 and bg['absentStates'] == 16 and bg['unselectedColumns'] == 286 and bg['allUnselectedColumnsByteExact'] is True and bg['fullImmediatePriorPayloadRestored'] is True, 'candidate-bg-boundary')
    require({r['id']: r['targetSha256'] for r in bg['readback']} == {s['id']: ids[s['id']] for s in source if s['id'].startswith('bgdb:')}, 'candidate113-readback')
    require(len(native) == 2 and {r['asset'] for r in native} == {'sharedassets0.assets', 'sharedassets2.assets'}, 'candidate-native-assets')
    native_rows = [r for asset in native for r in asset['rows']]
    require(len(native_rows) == 18 and {r['id']: r['targetSha256'] for r in native_rows} == {s['id']: ids[s['id']] for s in source if s['id'].startswith('sharedassets')}, 'candidate18-readback')
    require(all(r['selectedField'] == '/m_text' for r in native_rows), 'native-text-only-selector')
    require(all(r['postSaveReadback'] is True and r['allOtherObjectBytesPreserved'] is True for r in native), 'native-post-save-preservation-required')
    require(managed['mode'] == 'editorial-accepted' and managed['selectedStrings'] == 3 and managed['protectedStrings'] == 10 and managed['wholeMethodInventoryReadback'] is True and managed['allOriginalBodiesRestored'] is True, 'managed-three-string-boundary')
    require(managed['sourceSha256'] == a.MANAGED_BEFORE, 'managed-candidate17-source-binding')
    require(managed['targetSha256'] == sha(candidate / 'game' / DATA / 'Managed/Assembly-CSharp.dll'), 'managed-artifact-binding')
    baseline = read(BASELINE / 'build.json')
    allowed = {'resources.assets', 'sharedassets0.assets', 'sharedassets2.assets', 'Managed/Assembly-CSharp.dll'}
    old_files = {r['path']: r['probeSha256'] for r in baseline['files']}
    require(set(old_files) == set(proof['files']), 'candidate17-file-set')
    require(all(old_files[n] == h for n, h in proof['files'].items() if n not in allowed), 'unrelated-candidate-artifact-changed')
    return plan, make_plan(plan), build


def ps_identity(pid):
    result = subprocess.run(['ps', '-p', str(pid), '-o', 'lstart=', '-o', 'command='], capture_output=True, text=True)
    return result.stdout.strip() if result.returncode == 0 else None


def owned(run, *, allow_absent=False):
    identity = read(run / 'task-process.json')
    require(isinstance(identity.get('pid'), int) and identity['pid'] > 1, 'task-pid')
    exe = str(run / 'game/The Forest of Love.exe')
    require(identity['executable'] == exe and exe in identity['psIdentity'], 'exact-task-executable')
    observed = ps_identity(identity['pid'])
    if observed is None:
        require(allow_absent, 'task-process-absent')
        return []
    require(observed == identity['psIdentity'], 'task-pid-reused-or-command-changed')
    return [observed]


def no_game_process(run):
    # Include surviving children; parent launcher's exit alone is insufficient.
    output = subprocess.check_output(['ps', '-axo', 'pid,ppid,command'], text=True)
    exe = str(run / 'game/The Forest of Love.exe')
    variants = [exe, exe.replace('/', '\\')]
    require(not any(any(v in line for v in variants) for line in output.splitlines()), 'task-game-process-still-active')


def pins(run):
    frozen = read(run / 'cg-execution-pins.json')
    for name, expected in frozen.items():
        p = (run / name).resolve()
        require(p.is_relative_to(run) and sha(p) == expected, 'execution-pin:' + name)
    return frozen


def prepare(candidate, run, *, locale='ru'):
    plan, workload, build = validate_candidate(candidate, locale=locale)
    candidate, run = Path(candidate).resolve(), Path(run).resolve()
    require(run.parent == ROOT / 'localization/probes' and run.is_dir(), 'parent-staged-run-required')
    require(not (run / 'cg-preparation.json').exists() and not (run / 'cg-inputs').exists(), 'new-preparation-required')
    no_game_process(run)
    prep = read(run / 'qa-preparation.json')
    require(prep['parentBuild'] == str(candidate) and prep['parentBuildSha256'] == sha(candidate / 'build.json') and prep['ownerFilesUsed'] is False, 'parent-stage-provenance')
    staged = read(run / 'build.json'); identity = staged['saveIsolation']
    import re
    require(identity['companyName'] == 'VNRevivalQA' and re.fullmatch(r'ForestRuChapterGalleryProbe[0-9_]+', identity['productName']), 'isolated-chapter-gallery-identity')
    require((run / 'game' / DATA / 'app.info').read_text().splitlines() == [identity['companyName'], identity['productName']], 'isolated-app-info')
    original = run / 'Assembly-CSharp.localized-original.dll'
    require(not original.exists() and not (run / 'game' / DATA / 'Managed/ForestProbe.dll').exists(), 'unhooked-parent-stage-required')
    fixture = Path(prep['fixtureDirectory']).resolve()
    require(fixture.is_relative_to(ROOT / 'localization/probes') and sha(fixture / 'manifest.json') == prep['fixtureManifestSha256'], 'fixture-binding')
    manifest = read(fixture / 'manifest.json')
    require(manifest['originalOwnerFilesUsed'] is False and set(manifest['files']) == {'tfol.savegame', 'tfol.settings'}, 'disposable-fixture-only')
    for name, row in manifest['files'].items():
        require(sha(fixture / name) == row['sha256'] == sha(run / 'game' / DATA / name), 'fixture-before:' + name)
    for row in staged['files']:
        require(sha(run / 'game' / DATA / row['path']) == row['probeSha256'], 'staged-file:' + row['path'])
    require({r['path']: r['probeSha256'] for r in staged['files'] if r['path'] != 'globalgamemanagers'} == {r['path']: r['probeSha256'] for r in build['files'] if r['path'] != 'globalgamemanagers'}, 'staged-candidate-file-set')
    # All inexpensive guards above precede writes. A later partial failure remains
    # visible without a final pin/preparation receipt; it is not a transaction.
    (run / 'cg-inputs').mkdir()
    adapter().snapshot(run / 'cg-inputs', locale='ru')
    write(run / 'cg-workload.json', workload, True)
    (run / 'cg-values.tsv').write_text(''.join('\t'.join(r) + '\n' for r in workload['values']))
    (run / 'cg-words.tsv').write_text(''.join(k + '\t' + b64(v) + '\n' for k, v in workload['words'].items()))
    (run / 'cg-cases.tsv').write_text(''.join('\t'.join([c['surface'], c['branch'], str(c['rowIndex']), c['kind'], str(c['ordinal']), b64(c['argument']), b64(c['expected'])]) + '\n' for c in workload['cases']))
    (run / 'cg-native.tsv').write_text(''.join('\t'.join([c['surface'], c['hierarchy'], c['id'], b64(c['expected'])]) + '\n' for c in workload['native']))
    (run / 'cg-selections.tsv').write_text(''.join(('movie' if '/movieOptions/' in s['id'] else 'story') + '\t' + str(s['zeroBasedIndex']) + '\t' + str(s['enumValue']) + '\n' for s in workload['selection']))
    helper_names = ['capture_chapter_gallery_ui.py', 'prepare_bridge.py', 'runtime_startup.py', 'command.py', 'fixture_preservation.py', 'ForestProbe.cs', 'ChapterGalleryUiProbe.cs', 'InjectProbe.cs', 'InjectProbe.csproj']
    snapshot = run / 'cg-helpers'; snapshot.mkdir()
    for name in helper_names:
        shutil.copyfile(ROOT / 'tools/probe' / name, snapshot / name)
    shutil.copyfile(ROOT / 'tools/prepare_chapter_gallery_review.py', snapshot / 'prepare_chapter_gallery_review.py')
    # Compilation reads only the snapshot copied above. ROOT redirects its fixed
    # source lookup to a task-owned mirror, not the mutable checkout.
    import importlib.util
    spec = importlib.util.spec_from_file_location('cg_prepare_bridge', snapshot / 'prepare_bridge.py')
    bridge = importlib.util.module_from_spec(spec); spec.loader.exec_module(bridge)
    mirror = run / 'cg-compile-root'; (mirror / 'tools/probe').mkdir(parents=True)
    for name in ('ForestProbe.cs', 'ChapterGalleryUiProbe.cs'):
        shutil.copyfile(snapshot / name, mirror / 'tools/probe' / name)
    bridge.ROOT = mirror
    managed = run / 'game' / DATA / 'Managed'
    bridge.compile_chapter_gallery(mirror / 'compiled', managed, identity['productName'])
    shutil.copyfile(managed / 'Assembly-CSharp.dll', original)
    injector = run / 'cg-injector'; injector.mkdir()
    source = (snapshot / 'InjectProbe.cs').read_text()
    before_hash = '46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
    require(source.count(before_hash) == 1, 'injector-source-version')
    (injector / 'InjectProbe.cs').write_text(source.replace(before_hash, sha(original)))
    shutil.copyfile(snapshot / 'InjectProbe.csproj', injector / 'InjectProbe.csproj')
    subprocess.run(['dotnet', 'build', str(injector / 'InjectProbe.csproj'), '--nologo', '-v', 'quiet', '--ignore-failed-sources'], check=True)
    dll = mirror / 'compiled/ForestProbe.dll'
    subprocess.run(['dotnet', str(injector / 'bin/Debug/net8.0/InjectProbe.dll'), str(managed), str(dll), str(run / 'Assembly-CSharp.hook.dll')], check=True)
    shutil.copyfile(dll, managed / 'ForestProbe.dll')
    shutil.copyfile(run / 'Assembly-CSharp.hook.dll', managed / 'Assembly-CSharp.dll')
    shutil.copyfile(candidate / 'chapter-gallery-readback.json', run / 'cg-candidate-readback.json')
    tracked = [run / n for n in ('cg-workload.json', 'cg-values.tsv', 'cg-words.tsv', 'cg-cases.tsv', 'cg-native.tsv', 'cg-selections.tsv', 'qa-preparation.json', 'build.json', 'cg-candidate-readback.json', 'Assembly-CSharp.localized-original.dll', 'Assembly-CSharp.hook.dll')]
    tracked += [p for folder in (snapshot, run / 'cg-inputs', mirror, injector) for p in folder.rglob('*') if p.is_file()]
    tracked += [managed / 'ForestProbe.dll', managed / 'Assembly-CSharp.dll']
    tracked += list(managed.glob('*.dll'))
    tracked += [run / 'game' / DATA / 'app.info', run / 'game/The Forest of Love.exe']
    for row in staged['files']:
        tracked.append(run / 'game' / DATA / row['path'])
    write(run / 'cg-execution-pins.json', {str(p.relative_to(run)): sha(p) for p in tracked}, True)
    write(run / 'cg-preparation.json', dict(status='prepared-not-run', counts=workload['counts'], parentBuild=str(candidate),
          parentBuildSha256=sha(candidate / 'build.json'), candidateReadbackSha256=sha(candidate / 'chapter-gallery-readback.json'),
          executionPinsSha256=sha(run / 'cg-execution-pins.json'), fixtureBefore={n: sha(run / 'game' / DATA / n) for n in manifest['files']},
          fixtureDirectory=str(fixture), fixtureManifestSha256=sha(fixture / 'manifest.json'), originalAssemblySha256=sha(original),
          nativeRoutes='Parent must establish visible original gallery hint, OOS notification and chapter tooltip separately; runner never activates an unknown root.',
          partialWritesAreTransaction=False, wholeGameAccepted=False, ordinaryTranslationEntryAllowed=False, globalPretranslationPassed=False), True)


def reconcile(run, receipt_path, *, timeout=90):
    receipt = read(receipt_path)
    require(receipt['status'] in ('pending', 'outcome-unknown', 'acknowledged', 'failed'), 'command-receipt-status')
    action = receipt['action']; deadline = time.monotonic() + timeout
    log = run / 'actions.log'
    while True:
        owned(run)
        raw = log.read_bytes()[receipt['offset']:] if log.exists() else b''
        # An incomplete tail is never an ACK. Match the complete exact action.
        lines = raw.decode('utf-8-sig', errors='replace').split('\n')[:-1]
        matches = [line for line in lines if line.endswith(' OK ' + action) or (' FAIL ' + action + ' ') in line]
        require(len(matches) <= 1, 'duplicate-action-receipt')
        if matches:
            receipt.update(status='acknowledged' if matches[0].endswith(' OK ' + action) else 'failed', logReceipt=matches[0])
            write(receipt_path, receipt)
            require(receipt['status'] == 'acknowledged', 'bridge-action-failed:' + action)
            return receipt
        if time.monotonic() >= deadline:
            receipt['status'] = 'outcome-unknown'; write(receipt_path, receipt)
            raise RuntimeError('Command outcome unknown; preserve request and reconcile this receipt before any subsequent command')
        time.sleep(.2)


def command(run, action):
    owned(run)
    journal = run / 'cg-command-receipts'; journal.mkdir(exist_ok=True)
    existing = sorted(journal.glob('*.json'))
    require(not existing or read(existing[-1])['status'] == 'acknowledged' or
            read(existing[-1])['status'] == 'failed' and action == 'cg-restore', 'reconcile-last-command-first')
    require(not (run / 'command.txt').exists() and not (run / 'command.pending').exists(), 'pending-command-needs-reconciliation')
    log = run / 'actions.log'; offset = log.stat().st_size if log.exists() else 0
    path = journal / (str(len(existing)).zfill(6) + '.json')
    write(path, dict(status='pending', action=action, offset=offset, process=read(run / 'task-process.json')), True)
    try:
        result = subprocess.run([sys.executable, str(run / 'cg-helpers/command.py'), str(run), action, '--timeout', '75'], capture_output=True, text=True, timeout=80)
        transport = dict(transportExit=result.returncode, transportStdout=result.stdout[-2000:], transportStderr=result.stderr[-2000:])
    except subprocess.TimeoutExpired:
        transport = dict(transportExit=None, transportError='observer-timeout; original request remains pending')
    receipt = read(path); receipt.update(transport); write(path, receipt)
    # Reconcile the SAME request, including a late ACK; never resubmit it.
    return reconcile(run, path, timeout=15)


def measure(run, case):
    command(run, 'cg-measure ' + str(case['index']))
    selected = (run / 'cg-selected.txt').read_text(encoding='utf-8-sig').splitlines()
    require(selected == [str(case['index']), b64(case['expected']), 'fixture-restored=true'], 'selected-output-readback')
    fields = [json.loads(line) for line in (run / 'cg-geometry.jsonl').read_text(encoding='utf-8-sig').splitlines()]
    require(len(fields) == (6 if case['surface'] != 'description' else len(fields)) and fields, 'geometry-membership')
    for field in fields:
        require(field['text'] == case['expected'], 'geometry-text-equality')
        field['issues'] = [key for key in ('missingGlyphs', 'outsideRect', 'outsideMasks', 'outsideViewport') if field[key]]
        if field['generatedText'] != field['text']:
            field['issues'].append('generated-character-sequence-differs')
        if field['overflow']:
            field['issues'].append('TMP-overflow')
        if not field['active'] or not field['enabled'] or field['authoredAlpha'] <= 0 or field['effectiveAlpha'] < field['authoredAlpha'] * .99:
            field['issues'].append('hidden-or-ancestor-fade')
        if case['expected'].strip() and field['visibleCharacters'] == 0:
            field['issues'].append('no-visible-glyphs')
    return dict(index=case['index'], surface=case['surface'], branch=case['branch'], fields=fields)


def representatives(cases, measurements):
    require([m['index'] for m in measurements] == [c['index'] for c in cases], 'complete-measured-workload-required')
    chosen = set()
    for branch in sorted({c['branch'] for c in cases}):
        group = [c for c in cases if c['branch'] == branch]; by_id = {m['index']: m for m in measurements}
        for metric in ('preferredHeight', 'preferredWidth', 'minGlyphPointSize'):
            # min final font size is a readability risk even when auto-fit succeeds.
            key = lambda c: max(f[metric] for f in by_id[c['index']]['fields']) if metric != 'minGlyphPointSize' else -min(f[metric] for f in by_id[c['index']]['fields'])
            chosen.add(max(group, key=key)['index'])
        chosen.add(max(group, key=lambda c: len(c['expected']))['index'])
    for issue in sorted({i for m in measurements for f in m['fields'] for i in f['issues']}):
        affected = [m for m in measurements if any(issue in f['issues'] for f in m['fields'])]
        chosen.add(max(affected, key=lambda m: sum(len(f['issues']) for f in m['fields']))['index'])
    return sorted(chosen)


def capture(run, surface):
    run = Path(run).resolve()
    require(run.parent == ROOT / 'localization/probes' and surface in SURFACES, 'run-surface')
    pins(run); owned(run)
    require(sha(run / 'cg-execution-pins.json') == read(run / 'cg-preparation.json')['executionPinsSha256'], 'preparation-pins')
    require(Path(__file__).resolve() == run / 'cg-helpers/capture_chapter_gallery_ui.py', 'execute-frozen-runner-only')
    directory = run / ('cg-' + surface)
    require(not directory.exists(), 'surface-attempt-exists-reconcile-without-blind-retry')
    directory.mkdir()
    sys.path.insert(0, str(run / 'cg-helpers'))
    from runtime_startup import wait_for_probe
    class Attached:
        pid = read(run / 'task-process.json')['pid']
        def poll(self):
            return None if owned(run, allow_absent=True) else 0
    wait_for_probe(run, Attached(), lambda: owned(run, allow_absent=True), 30)
    require((run / 'bridge-ready.txt').exists(), 'verified-readiness-file-required')
    command(run, 'cg-readback')
    require((run / 'cg-readback.tsv').read_text(encoding='utf-8-sig') == (run / 'cg-values.tsv').read_text(), 'complete129-loaded-readback')
    command(run, 'cg-ready ' + surface)
    if surface == 'gallery':
        require((run / 'cg-selection-readback.tsv').read_text(encoding='utf-8-sig') == (run / 'cg-selections.tsv').read_text(), 'loaded59-selection-identities')
    cases = [c for c in read(run / 'cg-workload.json')['cases'] if c['surface'] == surface]
    measurements = []; captures = []; restored = False; error = None
    try:
        with (directory / 'measurements.jsonl').open('x') as stream:
            for case in cases:
                row = measure(run, case); measurements.append(row); stream.write(json.dumps(row, ensure_ascii=False) + '\n'); stream.flush()
        selected = representatives(cases, measurements)
        lookup = {c['index']: c for c in cases}
        for index in selected:
            before = measure(run, lookup[index]); name = 'cg-' + surface + '-' + str(index).zfill(4) + '.png'
            command(run, 'capture ' + name)
            path = run / name; deadline = time.monotonic() + 15
            from PIL import Image
            while True:
                try:
                    with Image.open(path) as im:
                        im.verify()
                    with Image.open(path) as im:
                        width, height = im.size; extrema = im.convert('RGB').getextrema()
                    require(max(c[1] for c in extrema) > 20, 'blank-frame')
                    break
                except (OSError, SyntaxError):
                    require(time.monotonic() < deadline, 'capture-not-complete-unknown-outcome')
                    time.sleep(.2)
            after = measure(run, lookup[index])
            require(before == after, 'rendered-text-or-geometry-changed-during-capture')
            require(all((f['viewportWidth'], f['viewportHeight']) == (width, height) for f in after['fields']), 'capture-viewport-mismatch')
            captures.append(dict(filename=name, sha256=sha(path), width=width, height=height, caseIndex=index,
                                 surface=surface, expected=lookup[index]['expected'], branch=lookup[index]['branch']))
        command(run, 'cg-display-diagnostics')
        shutil.copyfile(run / 'display-diagnostics.tsv', directory / 'display-diagnostics.tsv')
    except BaseException as ex:
        error = repr(ex)
    finally:
        # Unknown pending command blocks restoration commands too. Never overwrite it.
        try:
            command(run, 'cg-restore'); restored = True
        except BaseException as ex:
            error = (error or '') + ';restore:' + repr(ex)
        write(directory / 'result.json', dict(status='surface-observations-complete' if error is None and restored else 'incomplete', surface=surface,
              error=error, measuredCases=len(measurements), expectedCases=len(cases), captures=captures, restored=restored,
              geometryIssueCases=[m['index'] for m in measurements if any(f['issues'] for f in m['fields'])],
              visualAccepted=False, actualEligibilityAccepted=False, wholeGameAccepted=False), True)
    require(error is None and restored, error)


def finish(run):
    run = Path(run).resolve(); require(run.parent == ROOT / 'localization/probes', 'run-path')
    require(Path(__file__).resolve() == run / 'cg-helpers/capture_chapter_gallery_ui.py', 'execute-frozen-runner-only')
    no_game_process(run)
    require(not (run / 'command.txt').exists(), 'pending-command-outcome')
    pins(run)
    prep = read(run / 'cg-preparation.json'); results = [read(run / ('cg-' + s) / 'result.json') for s in SURFACES]
    require(all(r['status'] == 'surface-observations-complete' and r['restored'] and r['measuredCases'] == prep['counts'][r['surface']] for r in results), 'complete-surface-receipts')
    parent = Path(prep['parentBuild']); require(sha(parent / 'build.json') == prep['parentBuildSha256'], 'parent-build-changed')
    parent_build = read(parent / 'build.json')
    require(all(sha(parent / 'game' / DATA / r['path']) == r['probeSha256'] for r in parent_build['files']), 'parent-artifact-changed')
    captures = [c for r in results for c in r['captures']]
    require(captures and all(sha(run / c['filename']) == c['sha256'] for c in captures), 'complete-frame-pins')
    managed = run / 'game' / DATA / 'Managed'
    require(sha(run / 'Assembly-CSharp.localized-original.dll') == prep['originalAssemblySha256'], 'restoration-original-pin')
    shutil.copyfile(run / 'Assembly-CSharp.localized-original.dll', managed / 'Assembly-CSharp.dll')
    (managed / 'ForestProbe.dll').unlink()
    cleanup = dict(taskOwnedProcessesAbsent=True, remainingTaskProcessRows=[], localizedAssemblyRestored=sha(managed / 'Assembly-CSharp.dll') == prep['originalAssemblySha256'], bridgeRemoved=not (managed / 'ForestProbe.dll').exists(), parentArtifactUnchanged=True,
                   ownerSaveFilesUsed=False, qaFixtureBefore=prep['fixtureBefore'], qaFixtureAfter={n: sha(run / 'game' / DATA / n) for n in prep['fixtureBefore']})
    write(run / 'cleanup.json', cleanup, True)
    write(run / 'runtime-result.json', dict(result='observations-complete', captures=captures, measuredCases=sum(r['measuredCases'] for r in results), loaded113And16AbsencesVerified=True,
          visual='pending', actualEligibilityAccepted=False, unknownAdventureNameReachability='pending', ordinaryTranslationEntryAllowed=False, globalPretranslationPassed=False, wholeGameAccepted=False), True)
    # Shared verifier reads these final receipts, checks saves and separately
    # validates any original resolution metadata change. Failure stays visible.
    sys.path.insert(0, str(run / 'cg-helpers'))
    from fixture_preservation import verify_fixture
    fixture = verify_fixture(run, Path(prep['fixtureDirectory']), reconcile_resolution_reset=True)
    write(run / 'cg-fixture-preservation.json', fixture, True)
    write(run / 'cg-completion.json', dict(status='finite-runtime-observations-complete', fixture=fixture,
          surfaces={s: sha(run / ('cg-' + s) / 'result.json') for s in SURFACES}, runtimeResultSha256=sha(run / 'runtime-result.json'), cleanupSha256=sha(run / 'cleanup.json'),
          visualAccepted=False, actualProgressionAccepted=False, ordinaryTranslationEntryAllowed=False, globalPretranslationPassed=False, wholeGameAccepted=False), True)


def main():
    parser = argparse.ArgumentParser(description=__doc__); sub = parser.add_subparsers(dest='mode', required=True)
    p = sub.add_parser('prepare'); p.add_argument('--candidate', type=Path, required=True); p.add_argument('--run', type=Path, required=True); p.add_argument('--locale', required=True)
    p = sub.add_parser('capture'); p.add_argument('--run', type=Path, required=True); p.add_argument('--surface', choices=SURFACES, required=True)
    p = sub.add_parser('finish'); p.add_argument('--run', type=Path, required=True)
    p = sub.add_parser('reconcile'); p.add_argument('--run', type=Path, required=True); p.add_argument('--receipt', type=Path, required=True)
    args = parser.parse_args()
    if args.mode == 'prepare': prepare(args.candidate, args.run, locale=args.locale)
    elif args.mode == 'capture': capture(args.run, args.surface)
    elif args.mode == 'finish': finish(args.run)
    else:
        run = args.run.resolve(); receipt = args.receipt.resolve()
        require(Path(__file__).resolve() == run / 'cg-helpers/capture_chapter_gallery_ui.py', 'execute-frozen-runner-only')
        require(receipt.parent == run / 'cg-command-receipts', 'receipt-path')
        reconcile(run, receipt)


if __name__ == '__main__':
    main()
