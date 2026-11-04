#!/usr/bin/env python3
"""Build Forest's offline Windows installer from the normal locale compiler.

Local deterministic processes only: no model, game, GUI, VM or network requests.
"""
import argparse
import concurrent.futures
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import time
import zipfile

ROOT = Path(__file__).resolve().parents[1]
WIN = ROOT / 'Windows'
WORK = ROOT / 'dist/windows-installer-work'
CONFIG = json.loads((WIN / 'installer-config.json').read_text())
DATA = CONFIG['dataDirectory']


def sha(data):
    return hashlib.sha256(data).hexdigest()


def encode(obj):
    return (json.dumps(obj, ensure_ascii=True, sort_keys=True, indent=2) + '\n').encode()


def source_pins():
    evidence = {'build-receipt.json', 'validation.json', 'compiler-receipts.json',
                'recovery-validation.json', 'size-reduction.json'}
    paths = [p for p in WIN.rglob('*') if p.is_file() and
             not any(x in p.relative_to(WIN).parts for x in ['bin', 'obj', 'build']) and p.name not in evidence]
    paths += [ROOT / 'tools' / n for n in ['build_windows_installer.py', 'forest_bundle_storage.py',
              'forest_payload.py', 'restore_windows_inputs.py', 'extract_windows_icon.py', 'probe_windows_payload_size.py']]
    return {str(p.relative_to(ROOT)): sha(p.read_bytes()) for p in sorted(paths)}


def selection():
    result = {}
    for path in sorted((ROOT / 'localization/languages').glob('*.json')):
        code = path.stem
        if code == 'ru-baseline' or code in CONFIG['excludedLocales']:
            continue
        result[code] = ROOT / 'localization/languages' / CONFIG['sourceOverrides'].get(code, path.name)
    return result


def compile_one(item):
    code, language = item
    output = WORK / 'overlays' / code
    output.parent.mkdir(parents=True, exist_ok=True)
    mode = 'check' if (output / 'manifest.json').exists() else 'resume' if output.exists() else 'build'
    log = WORK / (code + '-build.log')
    with log.open('wb') as stream:
        p = subprocess.run([str(ROOT / 'forest-localize'), 'build', str(language), '--output', str(output), '--mode', mode],
                           cwd=ROOT, stdout=stream, stderr=subprocess.STDOUT)
    if p.returncode:
        raise RuntimeError('locale build failed: ' + code + '; see ' + str(log))
    print('compiled ' + code, flush=True)


def build_locales():
    WORK.mkdir(parents=True, exist_ok=True)
    # Warm the shared managed-tool cache before multiple read-only consumers.
    items = list(selection().items())
    if items:
        compile_one(items.pop(0))
    with concurrent.futures.ThreadPoolExecutor(max_workers=2) as pool:
        list(pool.map(compile_one, items))
    collect_receipts()


def collect_receipts():
    """Bind existing normal or byte-exact recovered outputs without recompiling."""
    records = []
    framework = json.loads((ROOT / 'localization/framework/forest045-shared/framework.json').read_bytes())
    expected_paths = {DATA + '/' + name for name in framework['resources']}
    for code, language in selection().items():
        path = WORK / 'overlays' / code / 'manifest.json'
        d = json.loads(path.read_bytes())
        if d['locale'] != code or d['languageSha256'] != sha(language.read_bytes()):
            raise ValueError('Stale compiler output: ' + code)
        if set(d['files']) != expected_paths:
            raise ValueError('Incomplete compiler resource inventory: ' + code)
        for name, expected in d['files'].items():
            resource = path.parent / name
            if expected != dict(bytes=resource.stat().st_size, sha256=sha(resource.read_bytes())):
                raise ValueError('Compiler output changed: ' + code + '/' + name)
        record = {k: d[k] for k in ['locale', 'culture', 'languageSha256', 'compilerSha256', 'frameworkSha256', 'files']} | {'manifestSha256': sha(path.read_bytes())}
        if d.get('format') == 'forest-restored-published-output-v1':
            record['reusedPublishedOutput'] = {k: d[k] for k in ['publishedPayloadSha256', 'reusedOriginalCompilerManifestSha256', 'reconstructionVerified']}
        records.append(record)
    (WIN / 'compiler-receipts.json').write_bytes(encode(dict(format=1, locales=records,
        normalResourcesPerLocale=16, installedResourcesPerLocale=14, gameLaunched=False)))


def refresh_catalog():
    path = ROOT.parent / 'SiteForMods/lib/language-data/site-locales.ts'
    data = path.read_text()
    block = data.split('export const SITE_LOCALE_NATIVE_NAMES:', 1)[1].split('};', 1)[0]
    names = {}
    for quoted, plain, name in re.findall(r'^\s*(?:"([^"]+)"|([\w-]+)):\s*"([^"]+)",', block, re.M):
        names[quoted or plain] = name
    english_block = data.split('export const SITE_LOCALE_NAMES:', 1)[1].split('};', 1)[0]
    english = {quoted or plain: name for quoted,plain,name in re.findall(r'^\s*(?:"([^"]+)"|([\w-]+)):\s*"([^"]+)",', english_block, re.M)}
    result = dict(source={'path': 'SiteForMods/lib/language-data/site-locales.ts', 'sha256': sha(path.read_bytes())},
                  generatedBy='tools/build_windows_installer.py catalog',
                  names={code: names[code] for code in ['en'] + list(selection())},
                  englishNames={code: english[code] for code in ['en'] + list(selection())})
    (WIN / 'locale-labels.generated.json').write_bytes(encode(result))


def catalog():
    # A generated projection, not an independently maintained language catalog.
    # Keeping its binding in Git permits rebuilding Forest without another checkout.
    result = json.loads((WIN / 'locale-labels.generated.json').read_bytes())
    if set(result['names']) != set(selection()) | {'en'}:
        raise ValueError('refresh the catalog projection after changing locale eligibility')
    return result['names'], result['source']


def payload():
    from forest_bundle_storage import prepare
    WORK.mkdir(parents=True, exist_ok=True)
    chunker = WORK / 'chunks'
    subprocess.run(['cc', '-O2', '-Wall', '-Wextra', '-Werror', str(WIN / 'chunks.c'), '-o', str(chunker)], check=True)
    subprocess.run(['python3', str(WIN / 'build_codec.py')], check=True)
    codec = WORK / 'forest-bundle'
    framework = json.loads((ROOT / 'localization/framework/forest045-shared/framework.json').read_bytes())
    paths = sorted(set(framework['resources']) - set(CONFIG['preservedFiles']))
    bundle = next(x for x in paths if x.endswith('.bundle'))
    names, catalog_pin = catalog()
    original_root = Path(os.environ.get('FOREST_ORIGINAL_GAME', '/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')) / DATA
    original_asset, _, original_proof = prepare(original_root / bundle, WORK / 'bundles')
    manifest = dict(format=3, gameVersion=CONFIG['gameVersion'], dataDirectory=DATA,
                    identityPath='globalgamemanagers.assets', identitySha256=framework['sourceMembers']['globalgamemanagers.assets']['sha256'],
                    originals=[], baselines=[], locales=[], catalogSource=catalog_pin, excludedLocales=CONFIG['excludedLocales'])
    bases = []; lookup = {}; literals = set()

    def chunks(path):
        raw = path.read_bytes()
        for line in subprocess.check_output([str(chunker), str(path)], text=True).splitlines():
            offset, length = map(int, line.split()); block = raw[offset:offset + length]
            yield offset, length, sha(block), block

    for name in paths:
        original = framework['sourceMembers'].get(name)
        manifest['originals'].append(dict(path=name, sha256=original['sha256'] if original else None, bytes=original['bytes'] if original else 0))
        if original:
            source = original_root / name
            if original != dict(bytes=source.stat().st_size, sha256=sha(source.read_bytes())): raise ValueError('original input drift: ' + name)
            manifest['baselines'].append(dict(path=name, **original)); bases.append(source)
    manifest['baselines'].append(dict(path='__bundle.asset', bytes=original_asset.stat().st_size, sha256=sha(original_asset.read_bytes())))
    bases.append(original_asset)
    for index, path in enumerate(bases):
        for offset, length, key, _ in chunks(path): lookup.setdefault(key, dict(base=index, offset=offset, bytes=length, blob=None))
    target = WORK / 'ForestLanguages.zip'
    with zipfile.ZipFile(target, 'w', zipfile.ZIP_DEFLATED, compresslevel=9) as z:
        for code, source in selection().items():
            directory = WORK / 'overlays' / code
            if os.environ.get('FOREST_WAIT_FOR_OVERLAYS') == '1' and not (directory / 'manifest.json').exists():
                print('waiting for compiler: ' + code, flush=True); deadline = time.monotonic() + 5400
                while not (directory / 'manifest.json').exists():
                    if time.monotonic() > deadline: raise RuntimeError('compiler wait timed out: ' + code)
                    time.sleep(1)
            built = json.loads((directory / 'manifest.json').read_bytes())
            source_sha = sha(source.read_bytes())
            if built['languageSha256'] != source_sha: raise ValueError('stale compiled language: ' + code)
            locale = dict(code=code, name=names[code], culture=built['culture'], languageSha256=source_sha,
                          languagePath=str(source.relative_to(ROOT)), compilerManifestSha256=sha((directory / 'manifest.json').read_bytes()), files=[])
            for name in paths:
                path = directory / DATA / name; expected = built['files'][DATA + '/' + name]
                if expected != dict(bytes=path.stat().st_size, sha256=sha(path.read_bytes())): raise ValueError('compiler artifact drift: ' + str(path))
                raw = path; recipe_key = None; recipe_bytes = 0
                if name == bundle:
                    raw, recipe, proof = prepare(path, WORK / 'bundles')
                    if (proof['streamSha256'], proof['streamBytes']) != (original_proof['streamSha256'], original_proof['streamBytes']):
                        raise ValueError('protected streaming data changed: ' + code)
                    recipe_data = recipe.read_bytes(); recipe_key = sha(recipe_data); recipe_bytes = len(recipe_data)
                    z.writestr('recipes/' + recipe_key, recipe_data)
                    verified = WORK / 'bundle-verify.bin'
                    subprocess.run([str(codec), 'pack', str(original_root / bundle), str(raw), str(recipe), str(verified)], check=True)
                    if sha(verified.read_bytes()) != expected['sha256']: raise ValueError('lossless native bundle roundtrip failed: ' + code)
                    verified.unlink(); locale['bundleStorageProof'] = proof
                segments = []
                for _, length, key, block in chunks(raw):
                    if key in lookup: segment = dict(lookup[key])
                    else:
                        segment = dict(base=-1, offset=0, bytes=length, blob=key)
                        if key not in literals: z.writestr('chunks/' + key, block); literals.add(key)
                    segments.append(segment)
                locale['files'].append(dict(path=name, **expected, storageSha256=sha(raw.read_bytes()), storageBytes=raw.stat().st_size,
                                            bundleRecipe=recipe_key, bundleRecipeBytes=recipe_bytes, segments=segments))
            manifest['locales'].append(locale); print('packed ' + code, flush=True)
        z.writestr('manifest.json', encode(manifest))
    for locale in manifest['locales']:
        if sha((ROOT / locale['languagePath']).read_bytes()) != locale['languageSha256']: raise ValueError('language changed during packaging: ' + locale['code'])
    with zipfile.ZipFile(target) as z:
        base_data = [x.read_bytes() for x in bases]
        for locale in manifest['locales']:
            for file in locale['files']:
                h = hashlib.sha256(); size = 0
                for segment in file['segments']:
                    block = z.read('chunks/' + segment['blob']) if segment['blob'] else base_data[segment['base']][segment['offset']:segment['offset']+segment['bytes']]
                    if len(block) != segment['bytes']: raise ValueError('segment length mismatch')
                    h.update(block); size += len(block)
                if h.hexdigest() != file['storageSha256'] or size != file['storageBytes']: raise ValueError('payload reconstruction failed')
    pin = dict(bytes=target.stat().st_size, sha256=sha(target.read_bytes()), locales=len(manifest['locales']), filesPerLocale=len(paths), literalChunks=len(literals))
    (WORK / 'payload-receipt.json').write_bytes(encode(pin)); (WORK / 'payload-manifest.json').write_bytes(encode(manifest))
    print(json.dumps(pin), flush=True)


def solid():
    raw = json.loads((WORK / 'payload-receipt.json').read_bytes())
    source = WORK / 'ForestLanguages.zip'; target = WORK / 'ForestLanguages.forestpack'
    if sha(source.read_bytes()) != raw['sha256']: raise ValueError('raw payload changed')
    receipt = Path(str(target)+'.json')
    saved = json.loads(receipt.read_bytes()) if receipt.exists() else {}
    if not (target.exists() and saved.get('sourceZipSha256') == raw['sha256'] and saved.get('encoderPreset') == 6 and sha(target.read_bytes()) == saved.get('sha256')):
        subprocess.run(['python3', '-B', str(ROOT / 'tools/forest_payload.py'), str(source), str(target), '--preset', '6'], check=True)
        saved = json.loads(receipt.read_bytes())
    print(json.dumps(saved), flush=True)
    return dict(raw, **{k:v for k,v in saved.items() if k not in raw}, rawArchiveBytes=raw['bytes'], rawArchiveSha256=raw['sha256'], packedBytes=saved['bytes'], packedSha256=saved['sha256'])


def package():
    pin = solid()
    pin['bytes'] = pin['packedBytes']; pin['sha256'] = pin['packedSha256']
    manifest = json.loads((WORK / 'payload-manifest.json').read_bytes())
    if sha((WORK / 'ForestLanguages.forestpack').read_bytes()) != pin['sha256']:
        raise ValueError('payload changed')
    english = json.loads((WIN / 'locale-labels.generated.json').read_bytes())['englishNames']
    def label(x):
        value = english[x['code']] + ' / ' + x['name']
        return value.replace('\\', '\\\\').replace(chr(34), '\\'+chr(34))
    header = ['/* Generated from the canonical catalog and verified payload. */',
              '#define FOREST_PAYLOAD_SHA L"' + pin['sha256'] + '"',
              '#define FOREST_SCRIPT_SHA L"' + sha((WIN / 'install.ps1').read_bytes()) + '"',
              '#define FOREST_CORE_SHA L"' + sha((WIN / 'ForestInstaller.cs').read_bytes()) + '"',
              '#define FOREST_CODEC_SHA L"' + sha((WORK / 'forest-bundle.exe').read_bytes()) + '"',
              'static const wchar_t *localeCodes[] = {L"en",' + ','.join('L"' + x['code'] + '"' for x in manifest['locales']) + '};',
              'static const wchar_t *localeNames[] = {L"English (original)",' + ','.join('L"' + label(x) + '"' for x in manifest['locales']) + '};']
    (WORK / 'Locales.h').write_text('\n'.join(header) + '\n')
    dest = ROOT / 'dist' / os.environ.get('FOREST_WINDOWS_PACKAGE_NAME', 'Forest-Language-Installer-Windows')
    if dest.parent != ROOT / 'dist' or dest.suffix:
        raise ValueError('Windows package name must be a direct distribution folder name')
    resources = dest / 'Resources'
    resources.mkdir(parents=True, exist_ok=True)
    for source in ['install.ps1', 'ForestInstaller.cs']:
        shutil.copy2(WIN / source, resources / source)
    shutil.copy2(WORK / 'ForestLanguages.forestpack', resources / 'ForestLanguages.forestpack')
    shutil.copy2(WORK / 'forest-bundle.exe', resources / 'forest-bundle.exe')
    shutil.copy2(WIN / 'vendor/lz4/LICENSE', dest / 'LZ4-LICENSE.txt')
    shutil.copy2(WIN / 'vendor/lzma/LICENSE.txt', dest / 'LZMA-NOTICE.txt')
    shutil.copy2(WIN / 'README.txt', dest / 'README.txt')
    shutil.copy2(WIN / 'THIRD-PARTY-NOTICES.txt', dest / 'THIRD-PARTY-NOTICES.txt')
    version = CONFIG['version'].split('.')
    if len(version) != 3 or any(not x.isdigit() or not 0 <= int(x) <= 65535 for x in version): raise ValueError('invalid app version')
    (WORK / 'Version.h').write_text('\n'.join('#define VERSION_'+key+' '+value for key,value in zip(['MAJOR','MINOR','PATCH'],version)) + '\n#define VERSION_TEXT "' + CONFIG['version'] + '"\n')
    windres = '/opt/homebrew/bin/x86_64-w64-mingw32-windres'
    gcc = '/opt/homebrew/bin/x86_64-w64-mingw32-gcc'
    subprocess.run([windres, '-I', str(WIN), '-I', str(WORK),
                    str(WIN / 'Installer.rc'), '-O', 'coff', '-o', str(WORK / 'Installer.res')], check=True)
    subprocess.run([gcc, '-std=c11', '-O2', '-Wall', '-Wextra', '-Werror', '-municode', '-mwindows', '-I', str(WORK),
                    str(WIN / 'ForestLanguageInstaller.c'), str(WORK / 'Installer.res'), '-o', str(dest / 'Forest Language Installer.exe'),
                    '-lcomctl32', '-lshell32', '-lole32', '-luuid', '-ladvapi32'], check=True)
    # Script and helper hashes are compiled into the UI too; tampering must reject
    # before PowerShell execution. See verifyCompanions in the native launcher.
    artifact = dest.with_suffix('.zip')
    with zipfile.ZipFile(artifact, 'w', zipfile.ZIP_DEFLATED, compresslevel=9) as z:
        for path in sorted(dest.rglob('*')):
            if path.is_file():
                z.write(path, str(Path(dest.name) / path.relative_to(dest)))
    if artifact.stat().st_size > 100_000_000:
        raise ValueError('packaged installer exceeds the 100 MB target; reduce before delivery')
    receipt = dict(artifact=str(artifact.relative_to(ROOT)), bytes=artifact.stat().st_size, sha256=sha(artifact.read_bytes()),
                   app=dict(bytes=(dest / 'Forest Language Installer.exe').stat().st_size, sha256=sha((dest / 'Forest Language Installer.exe').read_bytes())),
                   sourcePins=source_pins(),
                   payload=pin, localeSources=[{k: x[k] for k in ['code', 'culture', 'languagePath', 'languageSha256', 'compilerManifestSha256']} for x in manifest['locales']],
                   nativeRuntime='not-run', realGameInstall='not-run', published=False,
                   validation='Windows/validation.json', inputRecovery='Windows/original-inputs.json')
    (WIN / 'build-receipt.json').write_bytes(encode(receipt))
    print(json.dumps({k: receipt[k] for k in ['artifact', 'bytes', 'sha256']}), flush=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('stage', choices=['catalog', 'compile', 'receipts', 'payload', 'solid', 'package', 'all'])
    args = parser.parse_args()
    for name, action in [('catalog', refresh_catalog), ('compile', build_locales), ('receipts', collect_receipts), ('payload', payload), ('solid', solid), ('package', package)]:
        if args.stage == name or args.stage == 'all' and name not in ['catalog', 'receipts', 'solid']:
            action()
