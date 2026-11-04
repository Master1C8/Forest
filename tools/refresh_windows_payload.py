"""Refresh changed serialized resources in an already verified Forest payload.

Unchanged bundles retain their exact, hash-bound normal-build roundtrip evidence.
Changed bundles deliberately require the full normal payload route.
"""
import copy
import hashlib
import json
import os
from pathlib import Path
import shutil
import zipfile


def sha(data):
    return hashlib.sha256(data).hexdigest()


def encode(value):
    return (json.dumps(value, sort_keys=True, ensure_ascii=True, indent=2) + '\n').encode()


def literal_segments(data, literals):
    segments = []
    for offset in range(0, len(data), 65536):
        block = data[offset:offset + 65536]; key = sha(block)
        literals[key] = block
        segments.append(dict(base=-1, offset=0, bytes=len(block), blob=key))
    return segments


def verify(archive, manifest, bases):
    for locale in manifest['locales']:
        for resource in locale['files']:
            digest = hashlib.sha256(); size = 0
            for part in resource['segments']:
                if not (0 < part['bytes'] <= 65536 and part['offset'] >= 0):
                    raise ValueError('invalid recipe segment')
                if part['blob']:
                    block = archive.read('chunks/' + part['blob'])
                    if sha(block) != part['blob']:
                        raise ValueError('literal hash mismatch')
                else:
                    index, offset, length = part['base'], part['offset'], part['bytes']
                    if not (0 <= index < len(bases) and offset >= 0 and length >= 0
                            and offset + length <= len(bases[index])):
                        raise ValueError('base span out of bounds')
                    block = bases[index][offset:offset + length]
                if len(block) != part['bytes']:
                    raise ValueError('segment length mismatch')
                digest.update(block); size += len(block)
            if digest.hexdigest() != resource['storageSha256'] or size != resource['storageBytes']:
                raise ValueError('reconstructed resource mismatch')


def assemble(source, output, manifest, literals, bases):
    """Write a separate candidate, prune unused blobs, and verify every resource."""
    if output.exists():
        raise ValueError('preserve existing refresh candidate')
    chunks = {s['blob'] for l in manifest['locales'] for f in l['files'] for s in f['segments'] if s['blob']}
    recipes = {f['bundleRecipe'] for l in manifest['locales'] for f in l['files'] if f.get('bundleRecipe')}
    with zipfile.ZipFile(source) as old, zipfile.ZipFile(output, 'x', zipfile.ZIP_STORED) as new:
        for prefix, keys in [('chunks/', chunks), ('recipes/', recipes)]:
            for key in sorted(keys):
                data = literals[key] if prefix == 'chunks/' and key in literals else old.read(prefix + key)
                if sha(data) != key:
                    raise ValueError('stored blob hash mismatch')
                new.writestr(prefix + key, data)
        new.writestr('manifest.json', encode(manifest))
    with zipfile.ZipFile(output) as new:
        if new.testzip() is not None:
            raise ValueError('refresh ZIP integrity failure')
        verify(new, manifest, bases)
    return len(chunks)


def publish(source, candidate, manifest, pin, work, previous_sha, fail_after=None):
    backup = work / ('payload-before-refresh-' + previous_sha)
    backup.mkdir(exist_ok=False)
    os.link(source, backup / source.name)
    for name in ['payload-manifest.json', 'payload-receipt.json']:
        shutil.copy2(work / name, backup / name)
    candidate.replace(source)
    if fail_after == 'archive':
        raise RuntimeError('injected publication interruption after archive')
    for name, value in [('payload-manifest.json', manifest), ('payload-receipt.json', pin)]:
        temp = work / (name + '.refresh')
        with temp.open('xb') as f:
            f.write(encode(value))
        temp.replace(work / name)
        if fail_after == 'manifest' and name == 'payload-manifest.json':
            raise RuntimeError('injected publication interruption after manifest')


def refresh(root, work, config, selection):
    source = work / 'ForestLanguages.zip'
    old_pin = json.loads((work / 'payload-receipt.json').read_bytes())
    if sha(source.read_bytes()) != old_pin['sha256']:
        raise ValueError('previous normal payload differs')
    old = json.loads((work / 'payload-manifest.json').read_bytes())
    with zipfile.ZipFile(source) as z:
        if json.loads(z.read('manifest.json')) != old:
            raise ValueError('previous manifest differs')
    manifest = copy.deepcopy(old)
    selected = selection()
    if {r['code'] for r in manifest['locales']} != set(selected):
        raise ValueError('locale catalog changed; use normal payload build')
    data_name = config['dataDirectory']
    original = Path(os.environ.get('FOREST_ORIGINAL_GAME',
        '/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')) / data_name
    bundle = next(r for r in old['originals'] if r['path'].endswith('.bundle'))
    bases = []
    for base in manifest['baselines']:
        path = (work / 'bundles' / (bundle['sha256'] + '.asset')
                if base['path'] == '__bundle.asset' else original / base['path'])
        data = path.read_bytes()
        if len(data) != base['bytes'] or sha(data) != base['sha256']:
            raise ValueError('original baseline differs')
        bases.append(data)
    literals = {}; changed = []; reused = []
    for locale in manifest['locales']:
        code = locale['code']; language = selected[code]
        directory = work / 'overlays' / code
        compiler_path = directory / 'manifest.json'
        built = json.loads(compiler_path.read_bytes())
        language_sha = sha(language.read_bytes())
        if built['locale'] != code or built['languageSha256'] != language_sha:
            raise ValueError('stale compiler output: ' + code)
        before = copy.deepcopy(locale); edits = []
        for resource in locale['files']:
            name = resource['path']; pin = built['files'][data_name + '/' + name]
            data = (directory / data_name / name).read_bytes()
            if dict(bytes=len(data), sha256=sha(data)) != pin:
                raise ValueError('compiler resource differs: ' + code + '/' + name)
            valid_segments = all(0 < s['bytes'] <= 65536 and s['offset'] >= 0 for s in resource['segments'])
            if resource['sha256'] == pin['sha256'] and resource['bytes'] == pin['bytes'] and valid_segments:
                continue
            if name.endswith('.bundle'):
                raise ValueError('changed bundle requires normal full payload: ' + code)
            key = sha(data)
            resource.update(pin, storageSha256=key, storageBytes=len(data),
                segments=literal_segments(data, literals))
            edits.append(name)
        locale.update(languageSha256=language_sha,
            languagePath=str(language.relative_to(root)), compilerManifestSha256=sha(compiler_path.read_bytes()))
        if locale != before:
            changed.append(dict(locale=code, changedResources=edits))
        else:
            reused.append(code)
    if not changed:
        raise ValueError('no changed inputs; reuse existing payload')
    candidate = work / ('ForestLanguages.refresh-' + old_pin['sha256'] + '.zip')
    count = assemble(source, candidate, manifest, literals, bases)
    pin = dict(bytes=candidate.stat().st_size, sha256=sha(candidate.read_bytes()),
        locales=len(manifest['locales']), filesPerLocale=len(manifest['locales'][0]['files']),
        literalChunks=count, incrementalRefresh=dict(previousPayloadSha256=old_pin['sha256'],
            changedLocales=changed, unchangedLocaleRecords=reused,
            exactUnchangedBundleRoundtripsRetained=len(manifest['locales']),
            allResourceReconstructionsVerified=True))
    # Preserve the exact old triplet before publication. Consumers reject an
    # interrupted archive/manifest/receipt mismatch; receipt is written last.
    publish(source, candidate, manifest, pin, work, old_pin['sha256'])
    print(json.dumps(pin['incrementalRefresh']), flush=True)
