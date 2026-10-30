#!/usr/bin/env python3
"""Materialize/check exact saved locale resources; no model, game or installer.

The preserved shared recipe and its saved readbacks are inputs, not a worker
dependency. This transport does not accept new wording or engineering decisions.
"""
import argparse
import json
from pathlib import Path
import shutil

from locale_queue import local, read, sha
from locale_resource_publish import publish

ROOT = Path(__file__).resolve().parents[1]
LOCALES = {'zh', 'es', 'es-419', 'pt-BR', 'ja', 'de'}


def need(ok, why):
    if not ok:
        raise ValueError(why)


def pinned(root, pin):
    path = local(root, pin['path'])
    need(path.is_file() and sha(path) == pin['sha256'], 'build-input-changed:' + pin['path'])
    return path


def closure(root, pin):
    path = pinned(root, pin); document = read(path)
    for name, digest in document['files'].items():
        child = local(path.parent, name)
        need(child.is_file() and sha(child) == digest, 'build-recipe-dependency:' + name)
    return path


def payload(root, profile, locale):
    need(profile.get('schemaVersion') == 1 and profile.get('kind') == 'locale-owned-saved-candidate', 'build-profile-schema')
    need(locale in LOCALES and profile.get('locale') == locale, 'build-explicit-locale')
    for pin in profile['tooling']:
        pinned(root, pin)
    recipe = closure(root, profile['recipe'])
    candidate = pinned(root, profile['serializedManifest']); saved = read(candidate)
    need(saved['locale'] == locale and saved['frozenRecipeSha256'] == profile['recipe']['sha256'], 'build-candidate-locale-recipe')
    static_check = read(pinned(root, profile['serializedCheck']))
    need(static_check.get('passed') is True and static_check.get('locale') == locale
         and static_check.get('allPriorAndUnselectedObjectsExact') is True, 'build-serialized-readback')
    files = {}
    for name, binding in saved['outputs'].items():
        path = local(candidate.parent, name)
        need(sha(path) == binding['sha256'] and path.stat().st_size == binding['bytes'], 'build-saved-resource:' + name)
        # Retain the source readback as evidence, not an installation resource.
        files['evidence/serialized-readback.json' if name == 'readback.json' else name] = path.read_bytes()
    assembly = pinned(root, profile['assembly']); helper = pinned(root, profile['displayHelper'])
    managed = read(pinned(root, profile['managedReadback']))
    request = read(pinned(root, profile['managedRequest']))
    need(managed.get('passed') is True and managed.get('locale') == request.get('locale') == locale
         and managed.get('outputSha256') == sha(assembly) and managed.get('helperSha256') == sha(helper)
         and managed.get('sourceSha256') == request.get('sourceSha256')
         and managed.get('selectedStrings') == len(request['rows'])
         and managed.get('completeTreeReadback') is True
         and managed.get('completeOriginalSemanticTreeRestored') is True, 'build-managed-readback')
    files['Managed/Assembly-CSharp.dll'] = assembly.read_bytes()
    files['Managed/VNRevivalLocaleDisplay.dll'] = helper.read_bytes()
    files['evidence/managed-readback.json'] = pinned(root, profile['managedReadback']).read_bytes()
    files['evidence/serialized-check.json'] = pinned(root, profile['serializedCheck']).read_bytes()
    need(files and all(files.values()), 'build-empty-payload')
    return files, saved


def run(profile_path, locale, output, mode='build', root=ROOT, fail_after=None):
    root = root.resolve(); profile_path = profile_path.resolve(); output = output.resolve()
    need(profile_path.is_relative_to(root), 'build-profile-outside-project')
    profile = read(profile_path)
    allowed = local(root, 'outputs/locale-assets-20261026/' + locale)
    need(output.is_relative_to(allowed) and output != allowed, 'build-output-outside-own-locale')
    files, saved = payload(root, profile, locale)
    bindings = {name: dict(sha256=__import__('hashlib').sha256(data).hexdigest(), bytes=len(data)) for name, data in files.items()}
    marker = dict(schemaVersion=1, kind='locale-owned-static-resource-candidate', locale=locale,
        profile=dict(path=str(profile_path.relative_to(root)), sha256=sha(profile_path)),
        recipe=profile['recipe'], outputs=bindings, sourceCompanions=saved['sourceCompanions'],
        ready=False, applicationAllowed=False, semanticCoverageAdded=0,
        independentIntegrationReview='pending', native='not-run', runtime='not-run',
        remaining=saved['remaining'],
        publicationBoundary='Sequential files, manifest last; resume verifies the same partial files. No installation transaction.')
    def verify(out, expected, content):
        need(read(out/'manifest.json') == expected, 'build-published-manifest')
        need({str(p.relative_to(out)) for p in out.rglob('*') if p.is_file()} == set(content) | {'manifest.json'}, 'build-unexpected-output')
        for name, data in content.items():
            need(local(out, name).read_bytes() == data, 'build-output-changed:' + name)
    if mode == 'check':
        verify(output, marker, files)
    else:
        need(mode in {'build', 'resume'}, 'build-mode')
        need(shutil.disk_usage(root).free - sum(map(len, files.values())) >= 5*1024**3, 'build-five-GiB-reserve')
        publish(files, output, allowed, marker, verify, resume=mode == 'resume', fail_after=fail_after)
    return dict(locale=locale, mode=mode, resourceFiles=len(files)-3, manifest=str((output/'manifest.json').relative_to(root)),
                manifestSha256=sha(output/'manifest.json'), ready=False, newModelRequests=0)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--profile', type=Path, required=True)
    parser.add_argument('--locale', required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--mode', choices=['build', 'resume', 'check'], default='build')
    args = parser.parse_args()
    print(json.dumps(run(args.profile, args.locale, args.output, args.mode)))
