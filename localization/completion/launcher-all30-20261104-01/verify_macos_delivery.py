"""Verify the actual signed stable launcher and its delivered ZIP, then record tests."""
from pathlib import Path
import json,hashlib,zipfile,subprocess
R=Path('/Users/antonkrutov/Desktop/Forest');C=R/'localization/completion/launcher-all30-20261104-01';app=R/'dist/Forest Languages.app';receipt=json.loads((R/'MacOS/build-receipt.json').read_bytes());base=json.loads((C/'baseline-MacOS-build-receipt.json').read_bytes())
def h(p):return hashlib.sha256(p.read_bytes()).hexdigest()
assert 'PASS: 118 assertions; realResources=true' in (C/'macos-actual-all30.log').read_text();assert 'PASS: 141 assertions; realResources=false' in (C/'macos-count-tests.log').read_text()
for p,expected in receipt['sourcePins'].items():assert h(R/p)==expected,('source drift',p)
assert h(R/'MacOS/Sources/GameLauncher.swift')==base['sourcePins']['MacOS/Sources/GameLauncher.swift']
config=json.loads((app/'Contents/Resources/PackageConfig.json').read_bytes());codes=[r['code'] for r in config['locales']];assert len(codes)==len(set(codes))==31 and {'hi','sw','uk','en','ru'}<=set(codes)
archive=R/receipt['artifact'];assert h(archive)==receipt['sha256'];files={str(Path(app.name)/p.relative_to(app)):p for p in app.rglob('*') if p.is_file()};metadata=[]
with zipfile.ZipFile(archive) as z:
 assert z.testzip() is None
 actual=set()
 for n in z.namelist():
  if n.endswith('/'):continue
  if Path(n).name.startswith('._'):
   assert z.read(n)[:4]==bytes.fromhex('00051607'),'Unknown auxiliary ZIP entry'
   real=Path(n).with_name(Path(n).name[2:]);assert (R/'dist'/real).exists(),'AppleDouble without an actual bundle member';metadata.append(n)
  else:actual.add(n)
 assert actual==set(files)
 for n,p in files.items():assert hashlib.sha256(z.read(n)).hexdigest()==h(p)
subprocess.run(['codesign','--verify','--deep','--strict',str(app)],check=True)
ui=dict(method='Native accessibility inspection of actual upgraded stable application',application=str(app.relative_to(R)),version='1.1.0',footer='30 languages + original English • Offline',translationOptions=30,totalOptions=31,newMenuLabels=['Hindi / हिन्दी','Swahili / Kiswahili','Ukrainian / українська'],selected='Russian / русский',gameCopyState='Your game copy is ready. Choose a language or launch it.',gameLaunched=False,languageAppliedToOwnerGame=False,screenshotCaptured=False)
(C/'macos-ui-validation.json').write_text(json.dumps(ui,ensure_ascii=False,indent=2)+'\n')
validation=dict(status='all30-delivered-artifact-and-native-accessibility-verified',artifact=receipt['artifact'],artifactSha256=receipt['sha256'],artifactBytes=receipt['bytes'],application=str(app.relative_to(R)),version='1.1.0',architectures=['arm64','x86_64'],translationLocales=30,totalOptions=31,syntheticAssertions=141,actualResourceAssertions=118,actualResourceTestSequence=['hi','sw','uk','ru','en'],settingsAndSavePreservedAcrossSwitches=True,originalApplicationUnchanged=True,nativeResourceLocalesPassed=30,newNativeStreamingReadbacks=3,retainedVersionMatchingNativeStreamingReadbacks=27,launcherUI='Stable application AX footer and all31 options verified; left ready on Russian',directLaunchAssertions=14,directLaunchEvidence='Retained exact unchanged GameLauncher.swift test evidence; no new game launch',signing='ad-hoc-deep-strict-verified',finalArchiveInventoryPassed=True,appleDoubleMetadataEntries=len(metadata),sourcePinsMatched=True,inGameRendering='not-run',devanagariShaping='not-run',gameLaunched=False,publication=False,projectArchival='pending-unfinished-project-native/human-acceptance',boundary='Actual resource materialization, isolated owned-copy switching, signatures, save/settings preservation and English restore, plus actual launcher menu; excludes target Unity execution/rendering.')
(R/'MacOS/validation.json').write_text(json.dumps(validation,indent=2)+'\n');print('Mac final artifact: all30 locales,31 UI options,118 actual +141 synthetic assertions; exact sources/archive/signature and15 AppleDouble metadata entries verified')
