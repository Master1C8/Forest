#!/usr/bin/env python3
"""Stage version-bound, reviewed resources for the normal installer producers.

No compiler, model, game, publication or installed application is invoked.
Existing source artifacts and previous candidates remain unchanged. A failed
link/copy leaves an explicitly incomplete candidate without a delivery receipt.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def read(path):
    return json.loads(path.read_bytes())


def sha(path):
    h = hashlib.sha256()
    with path.open('rb') as stream:
        while block := stream.read(1 << 20):
            h.update(block)
    return h.hexdigest()


def pin(path):
    return dict(bytes=path.stat().st_size, sha256=sha(path))


def write(path, value):
    path.write_text(json.dumps(value, sort_keys=True, indent=2) + '\n')


def stage(family, index, destination, candidate=None):
    from build_windows_installer import selection, DATA
    assert family.is_relative_to(ROOT / 'localization/screenshots')
    assert destination.parent == ROOT / 'dist' and not destination.exists()
    previous = {r['locale']: r for r in read(index)['sourceRows']}
    selected = selection()
    assert set(previous) == set(selected) and len(selected) == 30
    rows, links, native_records = [], [], []
    for code, language in selected.items():
        current = sha(language)
        old = previous[code]
        acceptance_pin = None
        if code == 'ru' and not candidate:
            # The already accepted Russian resources are an immutable reference.
            native = Path(old['native'])
            compiled = Path(old['compiled'])
        else:
            acceptance = family / code / ('final-' + candidate if candidate else 'final') / 'acceptance.json'
            accepted = read(acceptance)
            assert accepted['passed'] and accepted['frames'] == 7
            assert accepted['allIndependentlyReviewed']
            assert accepted['languageSha256'] == current
            assert accepted['gameClosed'] and not accepted['savedProgressWritten']
            native = Path(accepted['nativeResources'])
            # Each native receipt binds the exact Windows compiler manifest.
            cycle = native.name
            compiled = ROOT / 'dist' / f'Forest-{code}-owner-screens-20261104-{cycle}'
            acceptance_pin = dict(path=str(acceptance), **pin(acceptance))
            for binding in accepted['sourceBindings']:
                for key in ['captureManifest', 'review']:
                    assert sha(Path(binding[key])) == binding[key + 'Sha256']
            for evidence_type in ['reuseEvidence', 'transitionEvidence']:
                evidence = accepted.get(evidence_type)
                for item in evidence if isinstance(evidence, list) else [evidence] if evidence else []:
                    assert sha(Path(item['path'])) == item['sha256']
        wm, nm = compiled / 'manifest.json', native / 'manifest.json'
        w, n = read(wm), read(nm)
        assert w['locale'] == n['locale'] == code
        assert w['languageSha256'] == n['languageSha256'] == current
        assert n['windowsCompilerManifestSha256'] == sha(wm)
        for platform, directory, manifest in [('windows', compiled, w), ('macos', native, n)]:
            for name, expected in manifest['files'].items():
                assert pin(directory / name) == expected, (code, platform, name)
                links.append((directory / name, destination / platform / 'overlays' / code / name, expected))
            links.append((directory / 'manifest.json', destination / platform / 'overlays' / code / 'manifest.json', pin(directory / 'manifest.json')))
            if platform == 'windows' and (directory / 'build-input.json').exists():
                links.append((directory / 'build-input.json', destination / platform / 'overlays' / code / 'build-input.json', pin(directory / 'build-input.json')))
        assert all(name.startswith(DATA + '/') for name in w['files'])
        asset = native / 'bundle.asset'
        links.append((asset, destination / 'macos/overlays' / code / 'bundle.asset', pin(asset)))
        native_records.append(n)
        rows.append(dict(locale=code, languageSha256=current, compiled=str(compiled), native=str(native), visualAccepted=True,
                         compilerManifestSha256=sha(wm), nativeManifestSha256=sha(nm), acceptance=acceptance_pin))
    original = index.parent / 'macos/original-macos.asset'
    assert pin(original) == read(ROOT / 'MacOS/original-inputs.json')['serializedBundle']
    links.append((original, destination / 'macos/original-macos.asset', pin(original)))
    destination.mkdir()
    write(destination / 'incomplete.json', dict(candidate=True, readyForDelivery=False))
    for source, target, expected in links:
        assert pin(source) == expected
        target.parent.mkdir(parents=True, exist_ok=True)
        os.link(source, target)
        assert pin(target) == expected
    write(destination / 'macos/resources.json', native_records)
    # Recheck the authoring boundary after all links, before a usable receipt.
    assert all(sha(selected[r['locale']]) == r['languageSha256'] for r in rows)
    write(destination / 'staging-receipt.json', dict(candidate=True, readyForDelivery=False,
          version=read(ROOT / 'Windows/installer-config.json')['version'], sourceRows=rows,
          producerValidationPending=True, sourceIndex=dict(path=str(index), **pin(index))))
    (destination / 'incomplete.json').unlink()
    print(json.dumps(dict(staged=len(rows), destination=str(destination), readyForDelivery=False)))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--family', required=True, type=Path)
    parser.add_argument('--source-index', required=True, type=Path)
    parser.add_argument('--destination', required=True, type=Path)
    parser.add_argument('--candidate', help='Use separate final-<candidate> sets, including Russian')
    args = parser.parse_args()
    assert args.candidate is None or args.candidate.isalnum()
    stage(args.family.resolve(), args.source_index.resolve(), args.destination.resolve(), args.candidate)
