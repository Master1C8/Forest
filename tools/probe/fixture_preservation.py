"""Verify disposable fixtures; screen-resolution metadata is separate from saves."""
import copy
import hashlib
import json
import struct
from pathlib import Path


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def settings_delta(before, after, dimensions):
    left = json.loads(before)
    right = json.loads(after)
    expected = copy.deepcopy(left)
    general = expected['config_data']['value']['generalData']
    keys = ('lastKnownScreenResolutionWidth', 'lastKnownScreenResolutionHeight')
    previous = [general[key] for key in keys]
    for key, value in zip(keys, dimensions):
        general[key] = value
    assert right == expected, 'Unexpected disposable settings change'
    return [{'field': key, 'before': old, 'after': new}
            for key, old, new in zip(keys, previous, dimensions) if old != new]


def verify_fixture(run, fixture):
    run, fixture = Path(run), Path(fixture)
    cleanup = json.loads((run / 'cleanup.json').read_text())
    preparation = json.loads((run / 'qa-preparation.json').read_text())
    manifest = json.loads((fixture / 'manifest.json').read_text())
    assert sha(fixture / 'manifest.json') == preparation['fixtureManifestSha256']
    assert manifest['originalOwnerFilesUsed'] is False
    assert cleanup['taskOwnedProcessesAbsent'] and not cleanup['ownerSaveFilesUsed']
    before, after = cleanup['qaFixtureBefore'], cleanup['qaFixtureAfter']
    assert set(before) == set(after) == set(manifest['files']) == {'tfol.settings', 'tfol.savegame'}
    for name, pin in manifest['files'].items():
        assert sha(fixture / name) == pin['sha256'] == before[name]
        assert sha(run / 'game/The Forest of Love_Data' / name) == after[name]
    assert before['tfol.savegame'] == after['tfol.savegame'], 'Disposable savegame changed'
    captures = json.loads((run / 'runtime-result.json').read_text())['captures']
    assert captures, 'No captured viewport evidence'
    dimensions = set()
    for capture in captures:
        path = run / capture['filename']
        assert path.parent.resolve() == run.resolve()
        assert sha(path) == capture['sha256']
        header = path.read_bytes()[:24]
        assert header[:8] == b'\x89PNG\r\n\x1a\n'
        size = struct.unpack('>II', header[16:24])
        assert size == (capture['width'], capture['height'])
        dimensions.add(size)
    assert len(dimensions) == 1, 'Multiple captured viewport sizes'
    dimensions = next(iter(dimensions))
    physical = dimensions
    display = run / 'display-diagnostics.tsv'
    if display.exists():
        fields = display.read_text().strip().split('\t')
        assert len(fields) == 5 and fields[4] in ('True', 'False')
        assert tuple(map(int, fields[:2])) == dimensions, 'Display/capture viewport mismatch'
        physical = tuple(map(int, fields[2:4]))
        assert all(value > 0 for value in physical)
        if manifest.get('derivation', {}).get('after') is False:
            assert fields[4] == 'False', 'Windowed fixture did not remain windowed'
    changes = []
    if before['tfol.settings'] != after['tfol.settings']:
        changes = settings_delta((fixture / 'tfol.settings').read_bytes(),
            (run / 'game/The Forest of Love_Data/tfol.settings').read_bytes(), physical)
    return dict(status='passed', disposableSavegameByteExact=True,
                disposableSettingsByteExact=before['tfol.settings'] == after['tfol.settings'],
                settingsChanges=changes, capturedViewport=list(dimensions),
                physicalScreen=list(physical),
                fixtureManifestSha256=sha(fixture / 'manifest.json'),
                boundary='Exact disposable save bytes and settings schema/values; only recorded physical screen dimensions may follow independent Unity display diagnostics (legacy fullscreen fixtures use captured dimensions). No owner saves or normal continuation acceptance.')
