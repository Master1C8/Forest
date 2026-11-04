"""Replace the owned launcher's Contents after tests, preserving its outer path."""
from pathlib import Path
import json,hashlib,plistlib,subprocess
R=Path('/Users/antonkrutov/Desktop/Forest');C=R/'localization/completion/ru-inventory-heading-20261104-01';old=R/'dist/Forest Languages.app';new=R/'dist/Forest Languages 1.1.1.app';backup=R/'dist/ru-inventory-work/previous-launcher-1.1.0.app'
def h(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def inventory(p):return {str(q.relative_to(p)):dict(bytes=q.stat().st_size,sha256=h(q)) for q in p.rglob('*') if q.is_file()}
commands=subprocess.check_output(['ps','-axo','command='],text=True).splitlines()
for p in [old,new]:assert not any(str(p/'Contents/MacOS/Forest Languages') in row for row in commands),'Preserve a running launcher'
assert plistlib.loads((old/'Contents/Info.plist').read_bytes())['CFBundleShortVersionString']=='1.1.0'
assert plistlib.loads((new/'Contents/Info.plist').read_bytes())['CFBundleShortVersionString']=='1.1.1'
config=json.loads((new/'Contents/Resources/PackageConfig.json').read_bytes());assert len(config['locales'])==31 and len({r['code'] for r in config['locales']})==31
for p in [old,new]:subprocess.run(['codesign','--verify','--deep','--strict',str(p)],check=True)
before_old=inventory(old/'Contents');before_new=inventory(new/'Contents');backup.mkdir(exist_ok=False)
(old/'Contents').replace(backup/'Contents')
try:(new/'Contents').replace(old/'Contents')
except BaseException:
 (backup/'Contents').replace(old/'Contents');raise
assert inventory(old/'Contents')==before_new and inventory(backup/'Contents')==before_old
new.rmdir()
subprocess.run(['codesign','--verify','--deep','--strict',str(old)],check=True)
archive=R/'dist/Forest-Languages-macOS.zip';subprocess.run(['ditto','-c','-k','--keepParent',str(old),str(archive)],check=True)
receipt=json.loads((R/'MacOS/build-receipt.json').read_bytes());receipt.update(artifact=str(archive.relative_to(R)),bytes=archive.stat().st_size,sha256=h(archive),application=str(old.relative_to(R)),executableSha256=h(old/'Contents/MacOS/Forest Languages'),configurationSha256=h(old/'Contents/Resources/PackageConfig.json'))
(R/'MacOS/build-receipt.json').write_text(json.dumps(receipt,sort_keys=True,indent=2)+'\n')
(C/'macos-upgrade.json').write_text(json.dumps(dict(stableApplication=str(old.relative_to(R)),previousContentsBackup=str(backup.relative_to(R)),outerApplicationDirectoryPreserved=True,newContentsExactlyMatchTestedApplication=True,oldContentsPreserved=True,newVersion='1.1.1',totalOptions=31,translations=30,signature='deep-strict-verified',gameOrSavesModified=False,artifactSha256=receipt['sha256']),indent=2)+'\n')
print(json.dumps(dict(application=str(old),bytes=receipt['bytes'],sha256=receipt['sha256'],translations=30)))
