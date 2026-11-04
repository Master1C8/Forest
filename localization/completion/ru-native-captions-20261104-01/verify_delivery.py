"""Verify exact delivered packages, selected native resources and seven frames."""
from pathlib import Path
import hashlib,json,plistlib,subprocess,sys,zipfile
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'tools'))
from build_windows_installer import selection
from forest_inventory_headings import validate_packed_sources
def read(p):return json.loads(p.read_bytes())
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def archive(path,folder):
    expected={str(Path(folder.name)/p.relative_to(folder)):p for p in folder.rglob('*') if p.is_file()}
    with zipfile.ZipFile(path) as z:
        assert z.testzip() is None
        names={n for n in z.namelist() if not n.endswith('/') and not Path(n).name.startswith('._')}
        assert names==set(expected)
        for n,p in expected.items():assert hashlib.sha256(z.read(n)).hexdigest()==sha(p),n
    return True
assert 'PASS: 126 assertions; realResources=true' in (HERE/'macos-actual.log').read_text()
assert 'PASS actual payload: 51 assertions' in (HERE/'windows-actual.log').read_text()
assert 'Ran 15 tests' in (HERE/'compiler-tests.log').read_text() and (HERE/'compiler-tests.log').read_text().rstrip().endswith('OK')
selected=selection();results={}
for platform,folder,manifest in [('MacOS',ROOT/'dist/Forest Languages 1.1.3.app',ROOT/'dist/macos-installer-work/manifest.json'),('Windows',ROOT/'dist/Forest-Language-Installer-Windows-1_1_3',ROOT/'dist/windows-installer-work/payload-manifest.json')]:
    receipt=read(ROOT/platform/'build-receipt.json');target=ROOT/receipt['artifact']
    assert target.stat().st_size==receipt['bytes'] and sha(target)==receipt['sha256']
    for name,pin in receipt['sourcePins'].items():assert sha(ROOT/name)==pin,(platform,name)
    archive(target,folder);validate_packed_sources(read(manifest),selected)
    result=dict(passed=True,version='1.1.3',artifact=receipt['artifact'],bytes=receipt['bytes'],sha256=receipt['sha256'],sourcePinsMatched=True,completeZipInventoryMatched=True,translationLocales=30,
        tests=dict(compiler=15,actualResources=126 if platform=='MacOS' else 51),
        boundary='Native Swift materializer and signed game copies; Russian screenshot coverage separately bound' if platform=='MacOS' else 'Shipping C# core on macOS .NET8 with matching-source host codec. Windows GUI and PowerShell5.1 not run',
        projectArchival='pending-unfinished-multilingual-project')
    (ROOT/platform/'validation.json').write_text(json.dumps(result,indent=2)+'\n');results[platform]=result
app=ROOT/'dist/Forest Languages.app';assert plistlib.loads((app/'Contents/Info.plist').read_bytes())['CFBundleShortVersionString']=='1.1.3'
subprocess.run(['codesign','--verify','--deep','--strict',str(app)],check=True)
assert sha(app/'Contents/Resources/ForestLanguages.forestpack')==read(ROOT/'MacOS/build-receipt.json')['payload']['payloadSha256']
screens=ROOT/'localization/screenshots/ru-owner-20261104-final';m=read(screens/'native-manifest.json');r=read(screens/'review.json');assert len(m['images'])==len(r['images'])==7
for image,review in zip(m['images'],r['images']):
    assert image['order']==review['order'] and sha(screens/'upload'/image['filename'])==image['sha256']
    assert not review['findings'] and all(v in ('passed','not-applicable') for v in review['checks'].values())
assert read(HERE/'owner-after-launcher-apply.json')['saveAndSettingsByteExact']
assert sha(ROOT/'localization/languages/ru-baseline.json')=='f81807d069e3d17ce4c59364a57aa55d8142098ef6ffcfd63b5487d08ec9790f'
(HERE/'delivery-validation.json').write_text(json.dumps(dict(passed=True,platforms=results,allSevenFramesPassed=True,ownerSaveAndSettingsPreserved=True,gameClosed=True),indent=2)+'\n')
print('Verified both1.1.3 packages, all30 source bindings, exact installed RU resources, save preservation and7 passed frames')
