"""Check both actual delivered packages and their exact source/resource bindings."""
import hashlib
import json
from pathlib import Path
import plistlib
import subprocess
import sys
import zipfile

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT/'tools'))
from build_windows_installer import selection
from forest_inventory_headings import validate_selection, validate_packed_sources

def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()

def read(p):
    return json.loads(p.read_bytes())

def check_zip(path, folder, apple_double=False):
    expected = {str(Path(folder.name)/p.relative_to(folder)): p for p in folder.rglob('*') if p.is_file()}
    with zipfile.ZipFile(path) as z:
        assert z.testzip() is None
        names = set()
        for name in z.namelist():
            if name.endswith('/'):
                continue
            if apple_double and Path(name).name.startswith('._'):
                assert z.read(name)[:4] == bytes.fromhex('00051607')
                assert (folder.parent/Path(name).with_name(Path(name).name[2:])).exists()
            else:
                names.add(name)
        assert names == set(expected)
        for name, source in expected.items():
            assert hashlib.sha256(z.read(name)).hexdigest() == sha(source), name

assert 'PASS: 150 assertions; realResources=true' in (HERE/'macos-actual-versionguard.log').read_text()
assert 'PASS: 149 assertions; realResources=false' in (HERE/'macos-synthetic-upgrade.log').read_text()
assert 'PASS actual payload: 102 assertions' in (HERE/'windows-actual-corrected.log').read_text()
assert read(HERE/'all30-readback.json')['headingFieldReadbacks'] == 720
selected = selection(); validate_selection(ROOT, selected)
results = {}
for platform in ['MacOS', 'Windows']:
    receipt = read(ROOT/platform/'build-receipt.json')
    for name, pin in receipt['sourcePins'].items():
        assert sha(ROOT/name) == pin, ('source drift', platform, name)
    archive = ROOT/receipt['artifact']
    assert archive.stat().st_size == receipt['bytes'] and sha(archive) == receipt['sha256']
    if platform == 'MacOS':
        folder = ROOT/'dist/Forest Languages.app'
        assert plistlib.loads((folder/'Contents/Info.plist').read_bytes())['CFBundleShortVersionString'] == '1.1.2'
        check_zip(archive, folder, True)
        subprocess.run(['codesign','--verify','--deep','--strict',str(folder)],check=True)
        config = read(folder/'Contents/Resources/PackageConfig.json')
        manifest = read(ROOT/'dist/macos-installer-work/manifest.json')
        assert len(config['locales']) == 31 and len({r['code'] for r in config['locales']}) == 31
        assert sha(folder/'Contents/Resources/ForestLanguages.forestpack') == config['payloadSha256']
        validate_packed_sources(manifest, selected)
        assertions = dict(synthetic=149, actualNativeResources=150)
    else:
        folder = archive.with_suffix('')
        check_zip(archive, folder)
        assert sha(folder/'Resources/ForestLanguages.forestpack') == receipt['payload']['sha256']
        assert (folder/'Resources/ForestInstaller.cs').read_bytes() == (ROOT/'Windows/ForestInstaller.cs').read_bytes()
        validate_packed_sources(read(ROOT/'dist/windows-installer-work/payload-manifest.json'), selected)
        assertions = dict(actualPayload=102)
    result = dict(passed=True,version='1.1.2',artifact=receipt['artifact'],bytes=receipt['bytes'],
        sha256=receipt['sha256'],sourcePinsMatched=True,archiveInventoryMatched=True,
        translationLocales=30,headingFieldsReadBackAcrossBothPlatforms=720,assertions=assertions,
        inGameVisualAcceptance='not-run',independentNewHeadingReview='not-run',
        boundary=('Native Swift core and exact delivered resources; isolated owned copies, save/settings preservation, stale selected-version rejection and normal update' if platform=='MacOS'
                  else 'Shipping C# core on macOS .NET8 with matching-source host codec; isolated Windows resources and a dummy never-run executable; Windows native UI/PowerShell5.1 not run'),
        projectArchival='pending-unfinished-project')
    (ROOT/platform/'validation.json').write_text(json.dumps(result,indent=2)+'\n')
    results[platform] = result
assert sha(ROOT/'localization/languages/ru-baseline.json') == 'f81807d069e3d17ce4c59364a57aa55d8142098ef6ffcfd63b5487d08ec9790f'
(HERE/'delivery-validation.json').write_text(json.dumps(dict(passed=True,platforms=results,
    immutableRussianBaselinePreserved=True),indent=2)+'\n')
print('Both final delivered packages: sources, full ZIP inventories, all30 heading bindings and installation tests passed')
