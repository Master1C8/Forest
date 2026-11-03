"""Run the normal compiler in place with undeclared project reads denied by macOS."""
import datetime
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
HERE = Path(__file__).resolve().parent


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def write(p, d):
    with p.open('x') as f:
        json.dump(d, f, indent=2)
        f.write('\n')


def main():
    assert sys.platform == 'darwin'
    assert not (HERE/'minimal-build-result.json').exists()
    paths = set((ROOT/'localization/languages').glob('*.json'))
    for ident in {json.loads(p.read_text())['framework']['id'] for p in paths}:
        folder = ROOT/'localization/framework'/ident
        framework = json.loads((folder/'framework.json').read_text())
        paths.add(folder/'framework.json')
        paths.update(folder/n for n in framework['files'])
    names = ['forest-localize', 'tools/forest_localize.py', 'requirements-assets.lock', 'requirements-assets.txt',
             'tools/build_russian_preview.py', 'tools/extract_assets.py', 'tools/addressables_catalog.py',
             'tools/forest_localization/__init__.py', 'tools/forest_localization/core.py',
             'tools/forest_localization/font_metrics.py', 'tools/forest_localization/Managed.cs',
             'tools/forest_localization/Managed.csproj', 'tools/locale_completion/resource_composition_v1/compose.py',
             'tools/locale_completion/inventory52/inventory52.py', 'tools/locale_completion/inventory52/bg_codec.py',
             'tools/locale_completion/inventory52/bg_peer.py', 'localization/ru-assets/inline_guard.py',
             'localization/ru-assets/source-dispositions.json', 'localization/source/dialogue-candidates.jsonl',
             'tools/locale_completion/resource_composition_v1/managed_saved/bin/Debug/net8.0/Mono.Cecil.dll',
             'LOCALIZATION.md']
    paths.update(ROOT/n for n in names)
    dispositions = json.loads((ROOT/'localization/ru-assets/source-dispositions.json').read_text())
    for r in dispositions['records']:
        for e in r['consumerEvidence']:
            p = ROOT/e['path']
            assert sha(p) == e['sha256']
            paths.add(p)
    assert all(p.is_file() for p in paths)
    inputs = {str(p.relative_to(ROOT)): dict(bytes=p.stat().st_size, sha256=sha(p)) for p in sorted(paths)}
    write(HERE/'minimal-build-inputs.json', dict(files=inputs, logicalBytes=sum(r['bytes'] for r in inputs.values()),
          pythonDependencies='requirements-assets.lock; existing .venv-assets314 explicitly allowed',
          externalDependencies='Installed Python3.14/.NET SDK and system libraries, outside the project; not a fresh SDK installation test.'))
    compiler = ROOT/'outputs/universal-localizer-20261031/build-work/compiler'
    key = hashlib.sha256((ROOT/'tools/forest_localization/Managed.cs').read_bytes() +
          (ROOT/'tools/forest_localization/Managed.csproj').read_bytes() +
          (ROOT/'tools/locale_completion/resource_composition_v1/managed_saved/bin/Debug/net8.0/Mono.Cecil.dll').read_bytes()).hexdigest()
    cache = compiler/key
    held = HERE/'held-compiler-cache'
    assert not held.exists()
    had_cache = cache.exists()
    if had_cache:
        cache.rename(held)
    write(HERE/'compiler-cache-transition.json', dict(key=key, original=str(cache.relative_to(ROOT)),
          held=str(held.relative_to(ROOT)), hadCache=had_cache, state='held-for-cold-normal-build'))
    directories = {p for f in paths for p in f.parents if p.is_relative_to(ROOT)}
    output_roots = [ROOT/'dist/storage-minimal-nl-20261103-01', ROOT/'dist/storage-minimal-ja-20261103-01']
    assert all(not p.exists() for p in output_roots)
    work = ROOT/'outputs/universal-localizer-20261031/build-work'
    dotnet_home = HERE/'dotnet-home'
    allowed = ''.join('(literal '+json.dumps(str(p))+')' for p in sorted(paths | directories))
    allowed += ''.join('(subpath '+json.dumps(str(p))+')' for p in [ROOT/'.venv-assets314', work, dotnet_home, *output_roots])
    profile = '(version 1)(allow default)(deny file-read-data (subpath '+json.dumps(str(ROOT))+'))(allow file-read-data '+allowed+')\n'
    sb = HERE/'minimal-build.sb'
    with sb.open('x') as f:
        f.write(profile)
    env = dict(os.environ, DOTNET_CLI_HOME=str(dotnet_home), DOTNET_SKIP_FIRST_TIME_EXPERIENCE='1',
               DOTNET_CLI_TELEMETRY_OPTOUT='1')
    results = []
    try:
        # Same policy, same command; change only the input path for the negative control.
        for name, good in [('requirements-assets.txt', True), ('README.md', False)]:
            r = subprocess.run(['/usr/bin/sandbox-exec', '-f', str(sb), '/bin/cat', str(ROOT/name)],
                               capture_output=True, text=True)
            assert (r.returncode == 0) == good
            if not good:
                assert 'Operation not permitted' in r.stderr
        print('SANDBOX declared input passed; undeclared project read rejected', flush=True)
        for loc, output in zip(['nl', 'ja'], output_roots):
            before = datetime.datetime.now(datetime.timezone.utc).isoformat()
            for mode in ['build', 'check']:
                cmd = ['/usr/bin/sandbox-exec', '-f', str(sb), str(ROOT/'forest-localize'), 'build',
                       'localization/languages/'+loc+'.json', '--output', str(output.relative_to(ROOT)), '--mode', mode]
                with (HERE/(loc+'-'+mode+'.stdout.log')).open('x') as so, (HERE/(loc+'-'+mode+'.stderr.log')).open('x') as se:
                    r = subprocess.run(cmd, cwd=ROOT, env=env, stdout=so, stderr=se)
                results.append(dict(locale=loc, mode=mode, exitCode=r.returncode, command=cmd))
                write(HERE/(loc+'-'+mode+'-exit.json'), results[-1])
                assert r.returncode == 0, 'Inspect exact sandbox/build stderr; no deletion of unique inputs'
            manifest = json.loads((output/'manifest.json').read_text())
            assert manifest['languageSha256'] == sha(ROOT/'localization/languages'/(loc+'.json'))
            for n, pin in manifest['files'].items():
                assert sha(output/n) == pin['sha256'] and (output/n).stat().st_size == pin['bytes']
            write(HERE/(loc+'-delivered-manifest.json'), manifest)
            print(json.dumps(dict(locale=loc, normalBuildCheck='passed', files=len(manifest['files']), startedAtUTC=before)), flush=True)
        for n, pin in inputs.items():
            assert sha(ROOT/n) == pin['sha256']
        write(HERE/'minimal-build-result.json', dict(status='passed', results=results, projectInputFiles=len(inputs),
              projectInputBytes=sum(r['bytes'] for r in inputs.values()), undeclaredProjectReads='OS sandbox denied; negative and positive controls passed',
              compilerCache='Preexisting compiler cache held; normal compiler rebuilt from source',
              tested='Dutch registered layout and Japanese embedded CFF/font metrics, normal build/check and all16 resource hashes each',
              boundary='Static rebuildability only. No game, model, installer, publication or fresh external SDK/Python-environment installation.'))
    finally:
        if cache.exists():
            shutil.rmtree(cache)
        if had_cache:
            held.rename(cache)
        write(HERE/'compiler-cache-restored.json', dict(original=str(cache.relative_to(ROOT)), restored=had_cache,
              taskCreatedCacheRemoved=True, frozenPreviousCacheUnchanged=True))


if __name__ == '__main__':
    main()
