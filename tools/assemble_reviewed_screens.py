#!/usr/bin/env python3
"""Collect the210 accepted original PNGs into one flat delivery folder.

Provenance remains outside upload/. This performs deterministic integrity checks,
not a new visual judgment, and makes no publication or model request.
"""
import argparse
import os
from pathlib import Path
from stage_reviewed_installer import ROOT, read, sha, pin, write, candidate_folder


def assemble(family, destination, candidate=None, fallback=None):
    from build_windows_installer import selection
    assert family.is_relative_to(ROOT / 'localization/screenshots')
    assert destination.parent == ROOT / 'dist' and not destination.exists()
    initial = read(family / 'plan.json')
    references = {r['locale']: r for r in initial['locales']}
    rows, originals, names = [], [], set()
    for code, language in selection().items():
        source = (candidate_folder(family, code, candidate, fallback) if candidate else
                  ROOT / 'localization/screenshots/ru-owner-20261104-final' if code == 'ru' else family / code / 'final')
        acceptance = read(source / 'acceptance.json')
        if code == 'ru' and not candidate:
            assert acceptance['allVisualChecksPassed'] and acceptance['screenCount'] == 7
            assert sha(language) == references[code]['sourceLanguageSha256']
        else:
            assert acceptance['passed'] and acceptance['allIndependentlyReviewed'] and acceptance['frames'] == 7
            assert acceptance['languageSha256'] == sha(language)
        assert acceptance['gameClosed'] and not acceptance['savedProgressWritten']
        manifest = read(source / 'native-manifest.json')
        review = read(source / 'review.json')
        assert review['inputs']['nativeManifest'] == sha(source / 'native-manifest.json')
        assert sorted(r['order'] for r in manifest['images']) == list(range(1, 8))
        assert sorted(r['order'] for r in review['images']) == list(range(1, 8))
        judgments = {r['order']: r for r in review['images']}
        for image in manifest['images']:
            judgment = judgments[image['order']]
            name = image['filename']
            assert Path(name).name == name and name.endswith('.png') and name not in names
            assert image['locale'] == judgment['locale'] == code
            assert judgment['filename'] == image['sha256'] + '.webp'
            assert judgment['reviewer'].startswith('gpt-6.1-sol/high;')
            assert not judgment['findings'] and all(v in ['passed', 'not-applicable'] for v in judgment['checks'].values())
            original = source / 'upload' / name
            assert sha(original) == image['sha256']
            names.add(name)
            originals.append((original, image['sha256']))
        rows.append(dict(locale=code, languageSha256=sha(language), source=str(source), images=manifest['images'],
                         acceptance=pin(source / 'acceptance.json'), nativeManifest=pin(source / 'native-manifest.json'), review=pin(source / 'review.json')))
    assert len(rows) == 30 and len(originals) == len(names) == 210
    destination.mkdir()
    upload = destination / 'upload'
    upload.mkdir()
    write(destination / 'incomplete.json', dict(complete=False, published=False))
    for original, expected in originals:
        assert sha(original) == expected
        os.link(original, upload / original.name)
        assert sha(upload / original.name) == expected
    assert {p.name for p in upload.iterdir()} == names
    write(destination / 'provenance.json', dict(complete=True, locales=30, frames=210, published=False,
          originalPNGsOnly=True, originalsUnchanged=True, boundary='Integrity of existing independent visual acceptances; no new semantic judgment', sourceRows=rows))
    (destination / 'incomplete.json').unlink()
    print(str(upload))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--family', required=True, type=Path)
    parser.add_argument('--destination', required=True, type=Path)
    parser.add_argument('--candidate', help='Use separate final-<candidate> sets, including Russian')
    parser.add_argument('--fallback-candidate', help='Use this earlier accepted set only for absent candidate directories')
    args = parser.parse_args()
    assert args.candidate is None or args.candidate.isalnum()
    assert args.fallback_candidate is None or (args.candidate and args.fallback_candidate.isalnum() and args.fallback_candidate != args.candidate)
    assemble(args.family.resolve(), args.destination.resolve(), args.candidate, args.fallback_candidate)
