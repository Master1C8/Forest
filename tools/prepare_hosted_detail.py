#!/usr/bin/env python3
"""Prepare a full hosted frame plus one source-pixel crop; submits no requests."""
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

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('review_root', type=Path)
parser.add_argument('locale')
parser.add_argument('order', type=int)
parser.add_argument('output', type=Path)
parser.add_argument('--crop', type=int, nargs=4, required=True, metavar=('X', 'Y', 'WIDTH', 'HEIGHT'))
args = parser.parse_args()
base, output = args.review_root.resolve(), args.output.resolve()
assert base.is_relative_to(ROOT) and output.is_relative_to(ROOT) and not output.exists()
manifest = read(base / args.locale / 'manifest.json')
full = next(row for row in manifest['images'] if row['order'] == args.order)
bindings = read(base / 'prepared-full/source-bindings.json')
binding = next(row for row in bindings['images'] if row['source']['locale'] == args.locale and row['source']['order'] == args.order)
assert binding['preview']['sha256'] == full['sha256']
original = Path(binding['sourcePath'])
assert pin(original)['sha256'] == binding['source']['sha256']
previous = next(row for row in read(base / args.locale / 'review.json')['images'] if row['order'] == args.order)
assert previous.get('reviewer') and previous['findings']
output.mkdir()
images = output / 'images'
images.mkdir()
preview = base / 'prepared-full/images' / full['filename']
os.link(preview, images / full['filename'])
crop_path = images / ('detail-' + args.locale + '-' + str(args.order) + '.webp')
result = subprocess.run([sys.executable, '-B', str(SHARED / 'screenshot_preview.py'), str(original),
    '--output', str(crop_path), '--crop', *map(str, args.crop)], check=True, capture_output=True, text=True)
receipt = json.loads(result.stdout)
write(output / 'crop-provenance.json', receipt)
write(output / 'prior-finding.json', previous)
write(output / 'hosted-source-binding.json', binding)
generator = output / 'prepare-generator.py'
generator.write_bytes(Path(__file__).read_bytes())
provenance = {name: pin(path) for name, path in {
    'completePreparedManifest': base / 'prepared-full/manifest.json',
    'source': original, 'crop': output / 'crop-provenance.json',
    'priorFinding': output / 'prior-finding.json',
    'hostedSourceBinding': output / 'hosted-source-binding.json',
    'generator': generator,
}.items()}
detail = dict(full, order=5000 + args.order, filename=crop_path.name, sha256=receipt['sha256'],
              width=receipt['width'], height=receipt['height'])
write(output / 'manifest.json', dict(schemaVersion=1, kind='native-screenshots', sourceKind='hosted-export-detail',
    scope=f'Hosted {args.locale} slot {args.order}, full prepared frame plus source-bound detail {detail["order"]}; not an extra gallery slot',
    provenance=provenance, images=[copy.deepcopy(full), detail]))
context = (base / args.locale / 'acceptance.txt').read_text()
context += ('\nAffected detail cycle: inspect the entire full frame and the accompanying source-pixel crop of the SAME '
    'actual hosted original. The second order is a supplemental view, not a gallery slot. Crop bounds are '
    + json.dumps(args.crop) + ' in the hosted original coordinate system. Source pixels were cropped, never upscaled '
    'or retouched; WebP80 applies to both views. Independently resolve the following finding; do not assume '
    'the earlier judgment is correct or incorrect. Readability at full-view scale and source detail are separate '
    'observations. A readable crop does not excuse unreadable full-view UI, and readability alone does not excuse '
    'overlap, clipping or missing clearance. Preserve a real defect or remaining uncertainty.\n'
    + json.dumps(previous['findings'], ensure_ascii=False))
assert len(context.encode()) <= 32768
(output / 'acceptance.txt').write_text(context)
spec = importlib.util.spec_from_file_location('detail_queue', SHARED / 'review_queue.py')
queue = importlib.util.module_from_spec(spec)
spec.loader.exec_module(queue)
queue.main(['init', '--root', str(images), '--queue', str(output / 'queue'), '--review', str(output / 'review.json'),
    '--manifest', str(output / 'manifest.json'), '--context', str(output / 'acceptance.txt'),
    '--model', 'gpt-6.1-sol', '--reasoning', 'high'], ROOT)
print(json.dumps({'preparedViews': 2, 'modelRequestsSent': False, 'crop': receipt['crop']}))
