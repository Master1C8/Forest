"""Apply reviewed locale display adapters to a pinned actual saved game assembly.

Shared publisher owns manifest-last publication. No game loading, model call,
installation, translation generation or native acceptance occurs here.
"""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import shutil
import subprocess
import sys


def sha(data):
    return hashlib.sha256(data).hexdigest()


def encode(value):
    return (json.dumps(value, ensure_ascii=False, sort_keys=True, indent=2) + '\n').encode()


def need(value, message):
    if not value:
        raise ValueError(message)


def run(root, profile_path, output, mode):
    root = root.resolve()
    profile_path, output = profile_path.resolve(), output.resolve()
    profile_bytes = profile_path.read_bytes()
    profile = json.loads(profile_bytes)
    locale = profile['locale']
    need(locale and profile['culture'], 'explicit-locale-culture')
    prefix = (root/profile['writePrefix']).resolve()
    need(prefix.is_relative_to(root) and output.is_relative_to(prefix) and output != prefix, 'own-output-prefix')
    pins = {}
    def read(pin):
        path = (root/pin['path']).resolve()
        need(path.is_relative_to(root), 'input-outside-project')
        data = path.read_bytes()
        need(sha(data) == pin['sha256'], 'input-pin:'+pin['path'])
        pins[pin['path']] = pin['sha256']
        return data
    for pin in profile['pins']:
        read(pin)
    base = json.loads(read(profile['baseManifest']))
    need(base['locale'] == locale and base['ready'] is False, 'actual-base-locale')
    base_dir = (root/profile['baseManifest']['path']).parent
    files = {}
    for name, pin in base['outputs'].items():
        data = (base_dir/name).read_bytes()
        need(sha(data) == pin['sha256'] and len(data) == pin['bytes'], 'base-resource:'+name)
        files[name] = data
    gaps = json.loads(read(profile['selectors']))['selectors']
    need(len(gaps) == len({r['id'] for r in gaps}), 'unique-selectors')
    rows = []
    for item in gaps:
        packet = [json.loads(line) for line in read(item['packet']).splitlines() if line]
        reviews = [json.loads(line) for line in read(item['reviews']).splitlines() if line]
        row, = [r for r in packet if r['id'] == item['id']]
        receipt, = [r for r in reviews if r['id'] == item['id']]
        need(receipt['verdict'] in ('pass', 'clean') and receipt.get('reviewed') is not False and not receipt.get('notLinguisticCoverage') and not receipt.get('contextOnly'), 'accepted-wording:'+item['id'])
        for key in ['source', 'target']:
            need(sha(row[key].encode()) == row[key+'Sha256'] == item[key+'Sha256'] == receipt[key+'Sha256'], 'own-wording-version:'+item['id'])
        rows.append(row)
    managed, osk = [r for r in rows if r['id'].startswith('il:')], [r for r in rows if not r['id'].startswith('il:')]
    need(len(managed) == profile['managedCount'] and len(osk) == profile['oskCount'], 'exact-family-counts')
    mappings = {}
    for row in osk:
        key = (row['source'], 304 if row['source'] == 'SHIFT' else 13 if row['source'] == 'ENTER' else None)
        need(key[1] is not None, 'unsupported-explicit-key-caption')
        need(mappings.get(key, row['target']) == row['target'], 'conflicting-key-caption')
        mappings[key] = row['target']
    request = dict(locale=locale, culture=profile['culture'], sourceSha256=sha(files['Managed/Assembly-CSharp.dll']),
        rows=managed, oskSelectors=[r['id'] for r in osk],
        captions=[dict(source=k[0], keycode=k[1], target=v) for k,v in mappings.items()])
    work = (root/profile['workDirectory']).resolve()
    need(work.is_relative_to(prefix) and work != prefix, 'own-work-prefix')
    if mode == 'build':
        need(not work.exists(), 'fresh-work-directory')
        work.mkdir(parents=True)
        compiler = work/'compiler'; compiler.mkdir()
        for name, pin in profile['compilerSources'].items():
            (compiler/name).write_bytes(read(pin))
        (work/'request.json').write_bytes(encode(request))
        subprocess.run([profile['dotnet'], 'build', str(compiler/'Patch.csproj'), '--nologo', '--verbosity', 'quiet'], check=True)
        subprocess.run([profile['dotnet'], str(compiler/'bin/Debug/net8.0/Patch.dll'), 'patch', str(base_dir/'Managed/Assembly-CSharp.dll'), str(work/'request.json'), str(work/'Assembly-CSharp.dll'), str(work/'managed-check.json')], check=True)
    need((work/'request.json').read_bytes() == encode(request), 'execution-request-version')
    receipt = json.loads((work/'managed-check.json').read_bytes())
    dll = (work/'Assembly-CSharp.dll').read_bytes()
    need(receipt['locale'] == locale and receipt['culture'] == profile['culture'] and receipt['sourceSha256'] == request['sourceSha256'] and receipt['targetSha256'] == sha(dll), 'managed-output-binding')
    need(receipt['completeTreeReadback'] and receipt['completeOriginalSemanticTreeRestored'] and receipt['allOriginalBodiesRestored'] and receipt['displayOperands'] == len(managed) and receipt['oskSelectorCount'] == len(osk), 'complete-preservation-check')
    files['Managed/Assembly-CSharp.dll'] = dll
    files['evidence/deferred-display-check.json'] = (work/'managed-check.json').read_bytes()
    files['evidence/deferred-display-request.json'] = encode(request)
    pins_path = work/'verified-inputs.json'
    if mode == 'build':
        pins_path.write_bytes(encode(pins))
    need(json.loads(pins_path.read_bytes()) == pins, 'verified-pin-record')
    files['evidence/deferred-display-inputs.json'] = encode(pins)
    manifest = dict(schemaVersion=1, kind='locale-owned-display-adapter-candidate', locale=locale, culture=profile['culture'],
        input=profile['baseManifest'], profile=dict(path=str(profile_path.relative_to(root)), sha256=sha(profile_bytes)),
        outputs={name:dict(sha256=sha(data), bytes=len(data)) for name,data in files.items()},
        sourceCompanions=base['sourceCompanions'], selectedIds=[r['id'] for r in rows],
        unchangedPriorOutputs=[n for n in base['outputs'] if n != 'Managed/Assembly-CSharp.dll'],
        remaining=['Independent integration review of changed managed bindings', 'Full-game haiku adapter and six template lifecycle predicates', 'Remaining target implementation and exact native/layout/runtime/package gates'],
        ready=False, applicationAllowed=False, semanticCoverageAdded=0, independentIntegrationReview='pending', native='not-run', runtime='not-run',
        publicationBoundary='Shared sequential publisher, manifest last; no multi-file transaction or owner installation')
    def verify(out, marker, payload):
        need(json.loads((out/'manifest.json').read_bytes()) == marker, 'published-manifest')
        need({str(p.relative_to(out)) for p in out.rglob('*') if p.is_file()} == set(payload) | {'manifest.json'}, 'exact-published-paths')
        for name,data in payload.items():
            need((out/name).read_bytes() == data, 'published-bytes:'+name)
    for name,digest in pins.items():
        need(sha((root/name).read_bytes()) == digest, 'input-changed-before-publication:'+name)
    if mode == 'check':
        verify(output, manifest, files)
    else:
        spec = importlib.util.spec_from_file_location('shared_publisher', root/profile['publisher']['path'])
        publisher = importlib.util.module_from_spec(spec); spec.loader.exec_module(publisher)
        need(sha(Path(publisher.__file__).read_bytes()) == profile['publisher']['sha256'], 'publisher-version')
        publisher.publish(files, output, prefix, manifest, verify)
    return dict(passed=True, locale=locale, mode=mode, selectors=len(rows), verifiedPins=len(pins), actualManagedSha256=sha(dll), unchangedPriorFiles=len(manifest['unchangedPriorOutputs']), ready=False)


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--root', type=Path, required=True); p.add_argument('--profile', type=Path, required=True)
    p.add_argument('--output', type=Path, required=True); p.add_argument('--mode', choices=['build','check'], default='build')
    a = p.parse_args(); print(json.dumps(run(a.root, a.profile, a.output, a.mode)))
