#!/usr/bin/env python3
"""Bounded per-locale partitions of Forest's complete authenticated site export.

Uses the canonical converter and queue. Hosted provenance remains explicit;
native judgments are never imported as hosted acceptance. No game or site writes.
"""
import argparse
import base64
import copy
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parents[1]
FAMILY = ROOT / 'localization/screenshots/all30-owner-20261104-01'
SHARED = ROOT.parent / 'SiteForMods/tools/codex-skills/screenshot-common/scripts'


def read(path):
    return json.loads(path.read_bytes())


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def write(path, value):
    pending = path.with_suffix('.pending')
    pending.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')
    pending.replace(path)


def module(name):
    spec = importlib.util.spec_from_file_location('hosted_' + name, SHARED / (name + '.py'))
    value = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(value)
    return value


def context(code, native_capture=None, candidate=None, language_document=None):
    language = language_document or ROOT / 'localization/languages' / (code + '.json')
    assert language.is_relative_to(ROOT) and language.is_file() and not language.is_symlink()
    doc = read(language)
    assert doc['locale'] == code and (language_document is None or native_capture is not None)
    if native_capture is None:
        final = (FAMILY / code / ('final-' + candidate) if candidate else
                 ROOT / 'localization/screenshots/ru-owner-20261104-final' if code == 'ru' else FAMILY / code / 'final')
        acceptance = read(final / 'acceptance.json')
    else:
        capture = read(native_capture / 'capture.json')
        assert capture['config']['languageSha256'] == sha(language)
        acceptance = dict(sourceBindings=[dict(order=r['order'], manifest=str(native_capture / 'native-manifest.json'))
                                          for r in capture['images']])
    snapshots, targets = {}, {}
    for binding in acceptance['sourceBindings']:
        order = binding['order']
        manifest = Path(binding.get('captureManifest', binding.get('manifest')))
        if not manifest.is_absolute():
            manifest = ROOT / manifest
        capture_file = manifest.parent / 'capture.json'
        if not capture_file.exists():
            continue
        capture = read(capture_file)
        config = capture.get('config', {})
        for key in ['cameraTitle', 'questTitle', 'dialogueTarget']:
            if key in config:
                targets[key] = config[key]
        run = Path(capture.get('run', manifest.parent))
        snapshot = run / ('state-before-' + str(order) + '.json')
        if order not in [1, 2, 3, 4, 5, 6] or not snapshot.exists():
            continue
        prefix = {1: 'Canvas/MainMenu/', 2: 'Canvas/OptionsMenu/', 3: 'Canvas/GalleryMenu/'}.get(order)
        values = set()
        for row in read(snapshot).get('texts', []):
            path, encoded, *_ = row.split('\t')
            if ((prefix and path.startswith(prefix)) or
                order == 4 and ('/ItemInfoMultilineFixedWidths/' in path or '/Labels/Inventory/' in path) or
                order == 6 and ('/QuestLog/' in path or '/Labels/QuestLog/' in path) or
                order == 5 and ('/CritterLog UI/Content/Bio/' in path or '/Labels/CritterLog/' in path)):
                value = base64.b64decode(encoded).decode()
                values.add(value)
                if order == 5 and path.endswith('/Bio/Subtitles'):
                    values.update(value.splitlines())
        matched = {}
        for item in doc['translations'].values():
            if item['target'] in values and item['target'].strip():
                matched.setdefault(item['target'], set()).add(item['source'])
        snapshots[order] = [dict(target=t, sourceVariants=sorted(s)) for t, s in sorted(matched.items())]
    facts = {'BDSM - Dom', 'Switch', 'Interspecies', 'Town Gossip', 'Farmer Past', '“The Town Mom”', 'Married'}
    resident = [r for key, r in doc['translations'].items()
                if key.startswith('bgdb:resources.assets:320/sheet/l7q0WkqA70qZcKsOchc8NQ/') and r['source'] in facts]
    assert len(resident) == 7
    evidence = ('These are original native macOS captures from the isolated, save-protected fixture; restoration is pinned. '
                'This is finite native screenshot QA, not a full playthrough or hosted-gallery acceptance. '
                if native_capture is not None else
                'These are actual server-stored WebP originals from the complete31-locale latest-draft export. '
                'This is hosted-gallery visual QA, not native runtime or public visibility acceptance. ')
    text = (
        'The Forest of Love0.45; locale ' + code + '. Review only the assigned entire frame. '
        + evidence + 'Inputs are prepared as WebP80 at max1280 without upscaling. Do not import earlier judgments. '
        'Seven scenes:1 main menu;2 settings;3 gallery with counters11/11 and46/46;4 owned camera inventory;'
        '5 Scarlett and all seven known facts;6 completed Hot Takes quest, every visible sidebar title, '
        'full description/history and completion marker;7 original current Maverick warmth dialogue279:144. '
        'Inspect every visible surface for clipping, overlap, broken wraps, faint/too-small text, missing '
        'glyphs, combining marks, fallback, unprocessed tags and OS/storefront contamination. '
        'Protected branding: The Forest of Love, Patreon, TFoL.info, v0.45.1. L/R and controller prompts '
        'retain their input identities. ??? are intentional undiscovered facts. The original formatter '
        'consumes [pic=1] before dialogue display. Bracketed completion labels are intentional UI. '
        'No blanket English, clipping or glyph exemption. Do not describe sexual gallery-thumbnail imagery; '
        'inspect UI only. Independently assess Gallery as scene/illustration gallery and Residents as '
        'inhabitants roster, not a renamed species. These target references never prove visible correctness. '
        'For every RTL frame inspect actual order, joining/marks, paragraph alignment, mixed Latin names, '
        'digit/separator order and contextual punctuation/brackets. Inspect header descenders against rules '
        'and the foreground UI portrait. The gameplay world remains visible behind the log overlay. '
        'A world sprite underneath the outlined heading is expected when the text remains legible and unobscured. '
        'Report lost contrast or any occlusion by the foreground panel. '
        'Uncertain tiny detail requires a concrete needs-review region and source-bound crop.\n')
    gallery = sorted({(item['source'], item['target']) for key, item in doc['translations'].items()
                      if 'StartScreenGalleryMenu::' in key})
    text += json.dumps(dict(captions=doc.get('imageCaptions'), fixtureTargets=targets,
                            galleryCategories=[dict(source=s, target=t) for s, t in gallery],
                            sevenKnownScarlettFacts=resident, visibleAuthoredReferences=snapshots), ensure_ascii=False)
    clarification = FAMILY / 'terminology-decisions' / (code + '.json')
    if clarification.exists():
        text += '\nSource-backed terminology context: ' + json.dumps(read(clarification), ensure_ascii=False)
    assert len(text.encode()) <= 32768, (code, len(text.encode()))
    return text


def prepare(export, output, source_provenance=None, candidate=None, slots=None):
    assert export.is_relative_to(ROOT) and output.is_relative_to(ROOT) and not output.exists()
    original = module('review').inventory_rows(export)
    rows = original['images']
    assert len(rows) == 210
    grouped = {}
    for row in rows:
        grouped.setdefault(row['locale'], []).append(row)
    assert len(grouped) == 30 and all(sorted(r['order'] for r in group) == list(range(1, 8)) for group in grouped.values())
    # Match every delivered slot to the exact accepted source PNG identity.
    provenance_path = source_provenance or ROOT / 'dist/Forest-Screenshots-30-Languages-20261105/provenance.json'
    assert provenance_path.is_relative_to(ROOT) and not provenance_path.is_symlink()
    provenance = read(provenance_path)
    assert provenance['complete'] and provenance['frames'] == 210
    source = {(r['locale'], i['order']): i for r in provenance['sourceRows'] for i in r['images']}
    assert len(source) == sum(len(r['images']) for r in provenance['sourceRows']) == 210
    for row in rows:
        prefix = f"screenshot-webp-v1-{row['locale']}-{row['order']}-{source[row['locale'], row['order']]['sha256']}-"
        assert prefix in row['url'] and '-' + row['sha256'] + '-' in row['url']
    if slots is not None:
        requested = read(slots)
        selected = {(r['locale'], r['order']) for r in requested}
        assert selected and len(selected) == len(requested) and selected <= set(source)
        grouped = {code: [r for r in group if (code, r['order']) in selected] for code, group in grouped.items()}
        grouped = {code: group for code, group in grouped.items() if group}
    output.mkdir()
    converted, full = module('review_entry').prepare_scope(export, output / 'prepared-full')
    prepared = read(full)
    assert prepared['sourceKind'] == 'hosted-export'
    queue = module('review_queue')
    partitions = []
    for code in sorted(grouped):
        folder = output / code
        folder.mkdir()
        manifest = copy.deepcopy(prepared)
        orders = sorted(r['order'] for r in grouped[code])
        manifest['scope'] = f'Slots {orders} in the {code} partition of the complete hosted export; full scope retained in provenance'
        manifest['images'] = [r for r in prepared['images'] if r['locale'] == code and r['order'] in orders]
        manifest['provenance']['completePreparedExport'] = dict(path=str(full), sha256=sha(full))
        write(folder / 'manifest.json', manifest)
        (folder / 'acceptance.txt').write_text(context(code, candidate=candidate))
        queue.main(['init', '--root', str(converted), '--queue', str(folder / 'queue'),
                    '--review', str(folder / 'review.json'), '--manifest', str(folder / 'manifest.json'),
                    '--context', str(folder / 'acceptance.txt'), '--model', 'gpt-6.1-sol', '--reasoning', 'high'], ROOT)
        partitions.append(dict(locale=code, directory=str(folder), orders=orders))
    total = sum(len(task['orders']) for task in partitions)
    write(output / 'plan.json', dict(sourceExport=str(export), sourceInputs=original['inputs'],
          fullPreparedManifest=dict(path=str(full), sha256=sha(full)), partitions=partitions,
          sourceProvenance=dict(path=str(provenance_path), sha256=sha(provenance_path)),
          selectedSlots=dict(path=str(slots), sha256=sha(slots)) if slots else None,
          total=total, sourceKind='hosted-export', model='gpt-6.1-sol', reasoning='high', provider='OpenAI',
          freshHistory=True, maxConcurrentWorkers=2, modelRequestsSent=False))
    print(json.dumps(dict(prepared=total, locales=len(partitions), modelRequestsSent=False)))


def run(output, resume=False, workers=2, max_images=1):
    assert 1 <= workers <= 4
    plan = read(output / 'plan.json')
    assert plan['model'] == 'gpt-6.1-sol' and plan['reasoning'] == 'high'
    # The caller first runs one pilot packet through the same canonical wrapper.
    pilot = read(Path(plan['partitions'][0]['directory']) / 'review.json')['images']
    assert any(r.get('reviewer') for r in pilot), 'A completed actual-image pilot is required before scaling'
    state_path = output / 'batch-state.json'
    if resume:
        previous = read(state_path)
        assert previous['state'] in ('held', 'stopped') and not previous['active']
        for task in plan['partitions']:
            queue_path = Path(task['directory']) / 'queue'
            assert not (queue_path / 'lock').exists(), 'Reconcile active queue ownership first'
            assert read(queue_path / 'state.json')['state'] not in ('held', 'running'), 'Reconcile the named attempt first'
        history = output / ('batch-state-before-resume-' + str(time.time_ns()) + '.json')
        history.write_bytes(state_path.read_bytes())
    else:
        assert not state_path.exists()
    pending = [task for task in plan['partitions']
               if not all(r.get('reviewer') for r in read(Path(task['directory']) / 'review.json')['images'])]
    if not pending:
        counts = []
        for task in plan['partitions']:
            rows = read(Path(task['directory']) / 'review.json')['images']
            counts.append(dict(locale=task['locale'], total=len(rows), reviewed=len(rows),
                               passed=sum(not r['findings'] and all(v in ['passed', 'not-applicable'] for v in r['checks'].values()) for r in rows)))
        write(state_path, dict(pid=os.getpid(), state='complete', completed=[], active=[], locales=counts,
                              maxConcurrentWorkers=workers))
        return 0
    active = []
    completed = []
    held = False
    pins = {str(p): sha(p) for p in [Path(__file__).resolve(), ROOT / 'tools/review_screenshots.py',
            *SHARED.glob('*.py'), SHARED.parent / 'references/VISUAL-CHECKS.md']}
    while pending or active:
        assert all(sha(Path(p)) == value for p, value in pins.items()), 'Live review helper drift'
        while pending and len(active) < workers and not held and not (output / 'stop.request').exists():
            task = pending.pop(0)
            folder = Path(task['directory'])
            log = (folder / 'run.log').open('ab')
            child = subprocess.Popen([sys.executable, '-B', str(ROOT / 'tools/review_screenshots.py'),
                'run', '--queue', str(folder / 'queue'), '--execute', '--max-images', str(max_images)], stdout=log, stderr=subprocess.STDOUT)
            active.append((task, child, log))
        for task, child, log in list(active):
            if child.poll() is None:
                continue
            log.close()
            active.remove((task, child, log))
            if child.returncode:
                held = True
                completed.append(dict(locale=task['locale'], exitCode=child.returncode))
            elif all(row.get('reviewer') for row in read(Path(task['directory']) / 'review.json')['images']):
                completed.append(dict(locale=task['locale'], exitCode=0))
            else:
                pending.append(task)
        counts = []
        for task in plan['partitions']:
            rows = read(Path(task['directory']) / 'review.json')['images']
            counts.append(dict(locale=task['locale'], total=len(rows), reviewed=sum(bool(r.get('reviewer')) for r in rows),
                passed=sum(bool(r.get('reviewer')) and not r['findings'] and all(v in ['passed', 'not-applicable'] for v in r['checks'].values()) for r in rows)))
        write(state_path, dict(pid=os.getpid(), state='held' if held else 'running', completed=completed,
                              active=[dict(locale=t['locale'], pid=c.pid) for t, c, _ in active], locales=counts, maxConcurrentWorkers=workers))
        if (held or (output / 'stop.request').exists()) and not active:
            break
        time.sleep(1)
    write(state_path, dict(read(state_path), state='held' if held else 'stopped' if pending else 'complete'))
    return 1 if held else 0


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', choices=['prepare', 'run'])
    parser.add_argument('output', type=Path)
    parser.add_argument('--export', type=Path)
    parser.add_argument('--source-provenance', type=Path)
    parser.add_argument('--candidate', help='Read source context from final-<candidate> sets')
    parser.add_argument('--slots', type=Path, help='JSON list of locale/order pairs to review; the full export is still verified')
    parser.add_argument('--execute', action='store_true')
    parser.add_argument('--max-images', type=int, choices=(1, 2), default=1)
    parser.add_argument('--workers', type=int, choices=(1, 2, 3, 4), default=2)
    parser.add_argument('--resume', action='store_true', help='Continue only after explicit held-attempt reconciliation')
    args = parser.parse_args()
    if args.action == 'prepare':
        assert args.export and not args.execute
        assert args.candidate is None or (args.candidate.isalnum() and args.source_provenance)
        prepare(args.export.resolve(), args.output.resolve(),
                args.source_provenance.resolve() if args.source_provenance else None, args.candidate,
                args.slots.resolve() if args.slots else None)
    else:
        assert args.execute, 'Model-backed review requires explicit --execute'
        sys.exit(run(args.output.resolve(), args.resume, args.workers, args.max_images))
