#!/usr/bin/env python3
"""Measure a denser chunk layout without changing or accepting any game bytes."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import zipfile

ROOT = Path(__file__).resolve().parents[1]
WORK = Path(os.environ.get('FOREST_WINDOWS_WORK',str(ROOT/'dist/windows-installer-work'))).resolve()
if not WORK.is_relative_to(ROOT/'dist'):raise ValueError('Probe work must stay inside this project')
PROBE = WORK / 'size-probe'
PROBE.mkdir(exist_ok=True)
CHUNKER = WORK / 'chunks-4k'
CODEC = WORK / 'forest-bundle'
ORIGINAL = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')


def digest(b): return hashlib.sha256(b).hexdigest()


def chunks(path):
    data = path.read_bytes()
    for line in subprocess.check_output([str(CHUNKER), str(path)], text=True).splitlines():
        offset, size = map(int, line.split()); block = data[offset:offset+size]
        yield digest(block), block


framework = json.loads((ROOT / 'localization/framework/forest045-shared/framework.json').read_bytes())
paths = sorted(set(framework['resources']) - {'app.info', 'tfol.settings'})
bundle = next(x for x in paths if x.endswith('.bundle'))
source_asset = PROBE / 'original.asset'
subprocess.run([str(CODEC), 'extract', str(ORIGINAL / bundle), str(source_asset)], check=True)
known = set()
for name in paths:
    if name in framework['sourceMembers']:
        for key, _ in chunks(ORIGINAL / name): known.add(key)
for key, _ in chunks(source_asset): known.add(key)
source_count = len(known); segment_count = 0; locale_count = 0; members = 0
with zipfile.ZipFile(PROBE / 'literal-size-probe.zip', 'w', zipfile.ZIP_DEFLATED, compresslevel=9) as archive:
    for directory in sorted((WORK / 'overlays').iterdir()):
        if not (directory / 'manifest.json').exists(): raise ValueError('unfinished normal build')
        manifest = json.loads((directory / 'manifest.json').read_bytes())
        for name in paths:
            path = directory / 'The Forest of Love_Data' / name
            if digest(path.read_bytes()) != manifest['files']['The Forest of Love_Data/' + name]['sha256']:
                raise ValueError('normal artifact drift')
            if name == bundle:
                asset = PROBE / (directory.name + '.asset')
                subprocess.run([str(CODEC), 'extract', str(path), str(asset)], check=True)
                path = asset
            for key, block in chunks(path):
                segment_count += 1
                if key not in known:
                    known.add(key); archive.writestr('chunks/' + key, block)
            members += 1
        locale_count += 1; print('size-probed ' + directory.name, flush=True)
result = dict(locales=locale_count, members=members, sourceChunks=source_count, newChunks=len(known)-source_count,
              segments=segment_count, literalArchiveBytes=(PROBE / 'literal-size-probe.zip').stat().st_size,
              excludesManifestAndBundleRecipes=True, nativeBundleReconstructionAcceptance=False)
(PROBE / 'result.json').write_text(json.dumps(result, indent=2)+'\n')
print(json.dumps(result), flush=True)
