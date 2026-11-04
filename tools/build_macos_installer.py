#!/usr/bin/env python3
"""Build the offline universal macOS app. No model requests or game launch."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import plistlib
import shutil
import subprocess
import zipfile
from forest_payload import wrap

ROOT=Path(__file__).resolve().parents[1]
WORK=ROOT/'dist/macos-installer-work'
DATA=Path('/Applications/TheForestOfLove.app/Contents/Resources/Data')

def sha(p):
    h=hashlib.sha256()
    with Path(p).open('rb') as f:
        while b:=f.read(1<<20):h.update(b)
    return h.hexdigest()

def encode(o):return (json.dumps(o,sort_keys=True,ensure_ascii=True,indent=2)+'\n').encode()

def codecs():
    win=ROOT/'Windows'
    for directory in [win/'vendor/lz4',win/'vendor/lzma']:
        for name,expected in json.loads((directory/'provenance.json').read_bytes())['files'].items():assert sha(directory/name)==expected
    for arch in ['arm64','x86_64']:
        subprocess.run(['cc','-arch',arch,'-mmacosx-version-min=14.0','-std=c11','-O2','-Wall','-Wextra','-Werror',
            '-I',str(win/'vendor/lz4'),'-I',str(win/'vendor/lzma'),str(ROOT/'MacOS/BundleBuilder.c'),str(win/'vendor/lz4/lz4.c'),
            str(win/'vendor/lz4/lz4hc.c'),str(win/'vendor/lzma/LzmaDec.c'),'-lz','-o',str(WORK/('codec-'+arch))],check=True)
    subprocess.run(['lipo','-create',str(WORK/'codec-arm64'),str(WORK/'codec-x86_64'),'-output',str(WORK/'forest-codec-universal')],check=True)

def payload():
    records=json.loads((WORK/'resources.json').read_bytes())
    from build_windows_installer import selection
    expected=set(selection())
    assert len(records)==len(expected) and {r['locale'] for r in records}==expected
    labels=json.loads((ROOT/'Windows/locale-labels.generated.json').read_bytes())
    names=sorted(records[0]['files']);bundle=next(n for n in names if n.endswith('.bundle'))
    originals=[];bases=[];basepaths=[]
    for name in names:
        source=DATA/name
        originals.append(dict(path=name,bytes=source.stat().st_size if source.exists() else 0,sha256=sha(source) if source.exists() else None))
        # Bundle storage uses only the first serialized member. Its large native
        # texture/audio stream is always retained from the player's original game.
        if source.exists() and name!=bundle:
            bases.append(dict(path=name,bytes=source.stat().st_size,sha256=sha(source)));basepaths.append(source)
    asset=WORK/'original-macos.asset';bases.append(dict(path='__bundle.asset',bytes=asset.stat().st_size,sha256=sha(asset)));basepaths.append(asset)
    manifest=dict(format=1,bundleID='com.CarrotsCrittersVulpineVisions.TheForestofLove',gameVersion='0.45',
        identityPath='globalgamemanagers.assets',identitySha256=sha(DATA/'globalgamemanagers.assets'),bundlePath=bundle,
        originals=originals,baselines=bases,locales=[])
    subprocess.run(['cc','-O2',str(ROOT/'Windows/chunks.c'),'-o',str(WORK/'chunks')],check=True)
    def chunks(path):
        raw=path.read_bytes()
        for line in subprocess.check_output([str(WORK/'chunks'),str(path)],text=True).splitlines():
            offset,length=map(int,line.split());block=raw[offset:offset+length]
            yield offset,length,hashlib.sha256(block).hexdigest(),block
    lookup={};literals=set()
    for index,path in enumerate(basepaths):
        for offset,length,key,_ in chunks(path):lookup.setdefault(key,dict(base=index,offset=offset,bytes=length,blob=None))
    archive=WORK/'ForestMacLanguages.zip'
    with zipfile.ZipFile(archive,'w',zipfile.ZIP_STORED) as z:
        for record in records:
            code=record['locale'];directory=WORK/'overlays'/code
            locale=dict(code=code,name=labels['englishNames'][code]+' / '+labels['names'][code],culture=record['culture'],languageSha256=record['languageSha256'],files=[])
            from build_windows_installer import CONFIG
            source=ROOT/'localization/languages'/CONFIG['sourceOverrides'].get(code,code+'.json')
            assert sha(source)==record['languageSha256']
            for name in names:
                final=directory/name;assert sha(final)==record['files'][name]['sha256']
                storage=directory/'bundle.asset' if name==bundle else final
                segments=[]
                for _,length,key,block in chunks(storage):
                    if key in lookup:segments.append(lookup[key])
                    else:
                        segments.append(dict(base=-1,offset=0,bytes=length,blob=key))
                        if key not in literals:z.writestr('chunks/'+key,block);literals.add(key)
                locale['files'].append(dict(path=name,**record['files'][name],storageBytes=storage.stat().st_size,storageSha256=sha(storage),segments=segments,bundle=name==bundle))
            manifest['locales'].append(locale);print('packed macOS '+code,flush=True)
        z.writestr('manifest.json',encode(manifest))
    # Every reconstructed payload resource must match its native build, including
    # every literal hash and all base offsets. Runtime independently repeats it.
    rawbases=[p.read_bytes() for p in basepaths]
    with zipfile.ZipFile(archive) as z:
        for locale in manifest['locales']:
            for file in locale['files']:
                h=hashlib.sha256();size=0
                for part in file['segments']:
                    block=z.read('chunks/'+part['blob']) if part['blob'] else rawbases[part['base']][part['offset']:part['offset']+part['bytes']]
                    assert len(block)==part['bytes'];h.update(block);size+=len(block)
                assert h.hexdigest()==file['storageSha256'] and size==file['storageBytes']
    (WORK/'manifest.json').write_bytes(encode(manifest))
    inputs=dict(gameVersion='0.45',platform='native macOS universal',bundleID=manifest['bundleID'],
        restore='Install the licensed original macOS game 0.45 at /Applications/TheForestOfLove.app; preserve saves/settings. Restore Windows compiler inputs using STORAGE_RECOVERY.md.',
        identityPath=manifest['identityPath'],identitySha256=manifest['identitySha256'],originals=originals,
        serializedBundle=dict(bytes=asset.stat().st_size,sha256=sha(asset)),
        windowsPayloadSha256=sha(Path(os.environ.get('FOREST_WINDOWS_PAYLOAD',str(ROOT/'dist/Forest-Language-Installer-Windows/Resources/ForestLanguages.forestpack')))),
        originalApplicationModified=False,externalSavesRead=False)
    (ROOT/'MacOS/original-inputs.json').write_bytes(encode(inputs))
    receipt=wrap(archive,WORK/'ForestLanguages.forestpack',6)
    (ROOT/'MacOS/payload-receipt.json').write_bytes(encode(dict(receipt,locales=len(records),resources=14,reconstructionChecks=14*len(records))))
    return manifest,receipt

def app():
    codecs()
    manifest=json.loads((WORK/'manifest.json').read_bytes());receipt=json.loads((ROOT/'MacOS/payload-receipt.json').read_bytes())
    assert sha(WORK/'ForestLanguages.forestpack')==receipt['sha256']
    config=dict(payloadSha256=receipt['sha256'],decodedSha256=receipt['decodedSha256'],codecSha256=sha(WORK/'forest-codec-universal'),
        manifestSha256=sha(WORK/'manifest.json'),locales=[dict(code='en',name='English (original)')]+[dict(code=x['code'],name=x['name']) for x in manifest['locales']])
    (WORK/'PackageConfig.json').write_bytes(encode(config))
    for arch in ['arm64','x86_64']:
        subprocess.run(['swiftc','-swift-version','6','-O','-warnings-as-errors','-parse-as-library','-target',arch+'-apple-macosx14.0',
            *[str(p) for p in sorted((ROOT/'MacOS/Sources').glob('*.swift'))],'-o',str(WORK/('ForestLanguages-'+arch))],check=True)
    destination=ROOT/'dist'/os.environ.get('FOREST_MAC_APP_NAME','Forest Languages.app')
    assert destination.parent==ROOT/'dist' and destination.suffix=='.app'
    if destination.exists():shutil.rmtree(destination)
    contents=destination/'Contents';(contents/'MacOS').mkdir(parents=True);resources=contents/'Resources';resources.mkdir()
    subprocess.run(['lipo','-create',str(WORK/'ForestLanguages-arm64'),str(WORK/'ForestLanguages-x86_64'),'-output',str(contents/'MacOS/Forest Languages')],check=True)
    for name in ['ForestLanguages.forestpack','forest-codec-universal','PackageConfig.json']:
        shutil.copy2(WORK/name,resources/('forest-codec' if name=='forest-codec-universal' else name))
    for source,name in [(ROOT/'Windows/vendor/lz4/LICENSE','LZ4-LICENSE.txt'),(ROOT/'Windows/vendor/lzma/LICENSE.txt','LZMA-NOTICE.txt'),(ROOT/'Windows/THIRD-PARTY-NOTICES.txt','THIRD-PARTY-NOTICES.txt'),(ROOT/'MacOS/README.txt','README.txt')]:shutil.copy2(source,resources/name)
    shutil.copy2(ROOT/'MacOS/App.icns',resources/'App.icns')
    info=dict(CFBundleName='Forest Languages',CFBundleDisplayName='Forest Languages',CFBundleExecutable='Forest Languages',CFBundleIdentifier='org.vnrevival.forest.languages',
        CFBundlePackageType='APPL',CFBundleShortVersionString='1.1.1',CFBundleVersion='4',CFBundleIconFile='App.icns',LSMinimumSystemVersion='14.0',NSHighResolutionCapable=True,
        LSApplicationCategoryType='public.app-category.utilities')
    (contents/'Info.plist').write_bytes(plistlib.dumps(info))
    subprocess.run(['codesign','--force','--deep','--sign','-',str(destination)],check=True)
    subprocess.run(['codesign','--verify','--deep','--strict',str(destination)],check=True)
    target=ROOT/'dist/Forest-Languages-macOS.zip'
    if target.exists():target.unlink()
    subprocess.run(['ditto','-c','-k','--keepParent',str(destination),str(target)],check=True)
    assert target.stat().st_size<=100_000_000,'Distribution size exceeded the normal limit'
    pins={str(p.relative_to(ROOT)):sha(p) for p in sorted((ROOT/'MacOS').rglob('*')) if p.is_file() and not any(s in p.parts for s in ['build','bin','obj']) and p.name not in ['build-receipt.json','validation.json']}
    for name in ['forest_macos.py','build_macos_installer.py','test_macos_installer.py','test_macos_launch.py','verify_macos_resources.py','forest_payload.py','forest_localization/Managed.cs']:
        p=ROOT/'tools'/name;pins[str(p.relative_to(ROOT))]=sha(p)
    for name in ['forest_bundle.c','chunks.c','THIRD-PARTY-NOTICES.txt','vendor/lz4/provenance.json','vendor/lzma/provenance.json']:
        p=ROOT/'Windows'/name;pins[str(p.relative_to(ROOT))]=sha(p)
    result=dict(artifact=str(target.relative_to(ROOT)),bytes=target.stat().st_size,sha256=sha(target),architectures=['arm64','x86_64'],minimumMacOS='14.0',
        payload=config,sourcePins=pins,gameLaunched=False,originalGameModified=False)
    (ROOT/'MacOS/build-receipt.json').write_bytes(encode(result));print(json.dumps({k:v for k,v in result.items() if k!='sourcePins' and k!='payload'}),flush=True)

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('stage',choices=['codecs','payload','app']);a=p.parse_args()
    WORK.mkdir(parents=True,exist_ok=True)
    {'codecs':codecs,'payload':payload,'app':app}[a.stage]()
