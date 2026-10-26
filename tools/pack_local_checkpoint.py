#!/usr/bin/env python3
"""Package local source/renderer machine evidence, never a localization release."""
import argparse
import hashlib
import json
from pathlib import Path
import zipfile

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    output = args.output.resolve()
    assert ROOT in output.parents and not output.exists()
    run = ROOT / 'localization/probes/ru-20261026-06'
    assert (run / 'runtime-result.json').is_file(), 'Finish and reconcile the runtime check first'
    files = [ROOT / 'requirements-assets.lock']
    files += [ROOT / 'tools' / name for name in ['addressables_catalog.py', 'build_renderer_probe.py',
              'prepare_dialogue_source.py', 'test_prepare_dialogue_source.py', 'pack_local_checkpoint.py']]
    files += [p for p in (ROOT / 'tools/probe').iterdir() if p.suffix in ['.py', '.cs', '.csproj', '.swift']]
    files += list((ROOT / 'localization/source').rglob('*.json'))
    files += list((ROOT / 'localization/source').rglob('*.jsonl'))
    files += list((ROOT / 'localization/source').rglob('*.cs'))
    files += list((ROOT / 'localization/glossary').glob('*.json'))
    files += [p for p in run.glob('*.json') if not p.name.startswith('native-')] + list(run.glob('*.py'))
    files += list((run / 'bridge-source').glob('*.cs')) + list((run / 'bridge-source').glob('*.csproj'))
    files += [ROOT / 'localization/source-write-check.log']
    for name in ['runtime-result.json', 'static-font-coverage.jsonl', 'dialogue-nameplate.cs']:
        files.append(ROOT / 'localization/probes/ru-20261026-04' / name)
    files.append(ROOT / 'localization/probes/ru-20261026-03/custom-typewriter.cs')
    files = sorted(set(files))
    missing = [str(p.relative_to(ROOT)) for p in files if not p.is_file()]
    assert not missing, missing
    payloads = {p.relative_to(ROOT).as_posix(): p.read_bytes() for p in files}
    payloads['OVERVIEW.txt'] = (
        'The Forest of Love 0.45 / Russian technical checkpoint\n'
        'This archive contains source candidates, approved glossary snapshots, tools and machine evidence.\n'
        'It is not a localization installer or a translated game. Translated game units: 0.\n'
        'Full source acceptance, other renderer surfaces and independent editorial review remain pending.\n'
        'Native image inspection is stored separately in the canonical checkout; it is not asserted here.\n'
        'No installed game assets, compiled inspection bridge, executable or player save is included.\n'
        'Reproduction requires the pinned original game installation and the source-v2 metadata archive.\n'
    ).encode()
    manifest = {'schemaVersion': 1, 'kind': 'technical-checkpoint; not a localization release',
                'members': {name: {'bytes': len(value), 'sha256': hashlib.sha256(value).hexdigest()}
                            for name, value in payloads.items()}}
    payloads['MANIFEST.json'] = (json.dumps(manifest, indent=2) + '\n').encode()
    output.parent.mkdir(parents=True, exist_ok=True)
    pending = output.with_suffix(output.suffix + '.pending')
    assert not pending.exists(), 'Reconcile an interrupted archive before retrying'
    with zipfile.ZipFile(pending, 'x', compression=zipfile.ZIP_DEFLATED, compresslevel=9) as archive:
        for name, value in sorted(payloads.items()):
            info = zipfile.ZipInfo(name, date_time=(2026, 10, 26, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            archive.writestr(info, value)
    with zipfile.ZipFile(pending) as archive:
        assert set(archive.namelist()) == set(payloads)
        for name, expected in payloads.items():
            assert archive.read(name) == expected, name
    assert not output.exists()
    pending.rename(output)
    print(json.dumps({'path': str(output.relative_to(ROOT)), 'bytes': output.stat().st_size,
                      'sha256': hashlib.sha256(output.read_bytes()).hexdigest(),
                      'members': len(payloads), 'exactReadback': 'passed',
                      'kind': 'technical checkpoint; no localization release'}))


if __name__ == '__main__':
    main()
