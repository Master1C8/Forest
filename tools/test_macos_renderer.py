"""Test legacy14-to15 renderer ownership and rollback; never launches a game."""
import argparse,hashlib,json,shutil,subprocess,zipfile
from pathlib import Path
from test_macos_installer import fixture,ROOT,WORK
from forest_payload import wrap

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--run',required=True);p.add_argument('--renderer',type=Path,required=True)
a=p.parse_args();assert a.run.isalnum()
base=WORK/('renderer-tests-'+a.run);assert not base.exists();base.mkdir()
legacy,source=fixture(base/'Legacy')
original=ROOT/'localization/framework/forest045-shared-v2/references/Unity.TextMeshPro.dll'
shutil.copy2(original,source/'Contents/Resources/Data/Managed/Unity.TextMeshPro.dll')
fixture(base/'Renderer',a.renderer)
broken=base/'Broken';shutil.copytree(base/'Renderer/Resources',broken/'Resources')
with zipfile.ZipFile(base/'Renderer/raw.zip') as old,zipfile.ZipFile(broken/'raw.zip','w') as out:
    for name in old.namelist():
        data=old.read(name)
        if name=='manifest.json':
            m=json.loads(data);m['locales'][0]['files']=[r for r in m['locales'][0]['files'] if r['path']!='Managed/Unity.TextMeshPro.dll']
            data=(json.dumps(m,sort_keys=True,indent=2)+'\n').encode();manifest_sha=hashlib.sha256(data).hexdigest()
        out.writestr(name,data)
receipt=wrap(broken/'raw.zip',broken/'Resources/ForestLanguages.forestpack')
config=json.loads((broken/'Resources/PackageConfig.json').read_bytes())
config.update(payloadSha256=receipt['sha256'],decodedSha256=receipt['decodedSha256'],manifestSha256=manifest_sha)
(broken/'Resources/PackageConfig.json').write_text(json.dumps(config)+'\n')
binary=base/'RendererTests'
subprocess.run(['swiftc','-swift-version','6','-warnings-as-errors','-parse-as-library','-target','arm64-apple-macosx14.0',str(ROOT/'MacOS/Sources/InstallerCore.swift'),str(ROOT/'MacOS/Tests/RendererTests.swift'),'-o',str(binary)],check=True)
subprocess.run([str(binary),str(base)],check=True)
