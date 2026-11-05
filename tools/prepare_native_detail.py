#!/usr/bin/env python3
"""Prepare one native frame and a provenance-bound detail; no model requests."""
import argparse
import copy
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
SHARED = ROOT.parent / 'SiteForMods/tools/codex-skills/screenshot-common/scripts'

def read(path):
    return json.loads(path.read_bytes())

def write(path, value):
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')

def pin(path):
    return {'path': str(path.resolve()), 'sha256': hashlib.sha256(path.read_bytes()).hexdigest()}

def module(path, name):
    spec = importlib.util.spec_from_file_location(name, path)
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('capture', type=Path)
parser.add_argument('order', type=int)
parser.add_argument('output', type=Path)
parser.add_argument('--crop', type=int, nargs=4, required=True)
parser.add_argument('--language-file', type=Path, help='Exact pinned language document for an earlier capture')
parser.add_argument('--focus', help='One supplemental region; all other checks still apply to the full frame')
args = parser.parse_args()
assert args.focus is None or 0 < len(args.focus.encode()) <= 700
capture, output = args.capture.resolve(), args.output.resolve()
assert capture.is_relative_to(ROOT) and output.is_relative_to(ROOT) and not output.exists()
manifest = read(capture / 'native-manifest.json')
original = next(r for r in manifest['images'] if r['order'] == args.order)
record = read(capture / 'capture.json')
assert all(record['cleanup'][k] for k in ['taskProcessStopped', 'ownerSaveSettingsUnchanged', 'taskSaveByteExact', 'bridgeRemoved'])
output.mkdir()
entry = module(SHARED / 'review_entry.py', 'native_detail_entry')
prepared_root, prepared_path = entry.prepare_scope(capture / 'upload', output / 'prepared-full', capture / 'native-manifest.json')
prepared = read(prepared_path)
full = next(r for r in prepared['images'] if r['order'] == args.order)
images = output / 'images'
images.mkdir()
os.link(prepared_root / full['filename'], images / full['filename'])
source = capture / 'upload' / original['filename']
crop_path = images / ('detail-' + str(args.order) + '.webp')
result = subprocess.run([sys.executable, '-B', str(Path.home() / '.codex/tools/screenshot_preview.py'),
    str(source), '--output', str(crop_path), '--crop', *map(str, args.crop)], capture_output=True, text=True, check=True)
receipt = json.loads(result.stdout)
assert receipt['sourceSha256'] == original['sha256']
write(output / 'crop-provenance.json', receipt)
generator = output / 'prepare-generator.py'
generator.write_bytes(Path(__file__).read_bytes())
detail = dict(full, order=5000 + args.order, filename=crop_path.name, sha256=receipt['sha256'],
              width=receipt['width'], height=receipt['height'])
provenance = {name: pin(path) for name, path in {'completePreparedNativeManifest': prepared_path,
    'original': source, 'crop': output / 'crop-provenance.json', 'generator': generator}.items()}
language_input = args.language_file.resolve() if args.language_file else ROOT / 'localization/languages' / (original['locale'] + '.json')
assert language_input.is_relative_to(ROOT)
language = output / 'language-exact.json'
language.write_bytes(language_input.read_bytes())
assert pin(language)['sha256'] == record['config']['languageSha256']
provenance['language'] = pin(language)
write(output / 'manifest.json', dict(schemaVersion=1, kind='native-screenshots', sourceKind='native-detail',
    scope=f'One native {original["locale"]} slot {args.order}, full frame plus source-bound supplemental view {detail["order"]}',
    supplementalRegion=args.focus, provenance=provenance, images=[copy.deepcopy(full), detail]))
context_helper = module(ROOT / 'tools/review_hosted_forest.py', 'native_exact_context')
context = context_helper.context(original['locale'], capture, language_document=language)
context += ('\nThe second image is a source-pixel detail of the same native frame, not an extra gallery slot. '
            'Inspect the entire full frame and the detail. Verify unobstructed glyphs and visible clearance from '
            'decorative rules, portrait and prompts. A crop never excuses an unreadable full view. Bounds in the '
            'original native capture are ' + json.dumps(args.crop) + '. No previous visual judgments are supplied.')
if args.focus:
    context += (f'\nSupplemental view {detail["order"]} is limited to this region: {args.focus}. '
                f'Review every criterion in the complete frame {args.order}. '
                'In the supplemental view, mark unrelated checks not applicable when their subjects are outside the crop. '
                'If the relevant glyphs or boundary are missing from the crop, the supplemental check remains unresolved.')
assert len(context.encode()) <= 32768
(output / 'acceptance.txt').write_text(context)
queue = module(SHARED / 'review_queue.py', 'native_detail_queue')
queue.main(['init', '--root', str(images), '--queue', str(output / 'queue'), '--review', str(output / 'review.json'),
    '--manifest', str(output / 'manifest.json'), '--context', str(output / 'acceptance.txt'),
    '--model', 'gpt-6.1-sol', '--reasoning', 'high'], ROOT)
print(json.dumps({'preparedViews': 2, 'modelRequestsSent': False, 'sourceKind': 'native', 'crop': args.crop}))
