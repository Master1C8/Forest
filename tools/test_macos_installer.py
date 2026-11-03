#!/usr/bin/env python3
"""Finite synthetic or real-resource launcher tests. Never starts a game."""
import argparse
import hashlib
import json
from pathlib import Path
import plistlib
import shutil
import struct
import subprocess
import zipfile
from forest_payload import wrap

ROOT=Path(__file__).resolve().parents[1];WORK=ROOT/'dist/macos-installer-work'
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def write(p,b):p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b)
def fixture(target):
    assert not target.exists(),'Preserve and inspect an existing test run before replacing it'
    resources=target/'Resources';resources.mkdir(parents=True)
    source=target/'Original.app';data=source/'Contents/Resources/Data'
    names=['Managed/Assembly-CSharp.dll','Managed/VNRevivalInventoryLayout.dll','Managed/VNRevivalQuestLayout.dll',
        'StreamingAssets/aa/StandaloneOSX/default.bundle','StreamingAssets/aa/catalog.json','level1','level5','level6','resources.assets']+['sharedassets'+n+'.assets' for n in ['0','1','15','2','4']]
    bundle=next(n for n in names if n.endswith('.bundle'));asset=b'original native serialized data';stream=b'native streaming bytes'*100
    raw=asset+stream;info=bytes(16)+struct.pack('>I',1)+struct.pack('>IIH',len(raw),len(raw),0)+struct.pack('>I',2)
    for offset,body,flags,name in [(0,asset,4,'CAB-7cd732d37ea0297d073a22a52ce72d28'),(len(asset),stream,0,'CAB-7cd732d37ea0297d073a22a52ce72d28.resS')]:
        info+=struct.pack('>QQI',offset,len(body),flags)+name.encode()+b'\0'
    header=b'UnityFS\0'+struct.pack('>I',7)+b'5.x.x\0'+b'2020.3.24f1\0';header+=struct.pack('>QIII',64+len(raw)+len(info),len(info),len(info),192);header+=bytes(64-len(header))
    originals=[]
    for name in names:
        original=None if 'VNRevival' in name else header+raw+info if name==bundle else ('native original '+name).encode()
        if original is not None:write(data/name,original)
        originals.append(dict(path=name,bytes=len(original) if original else 0,sha256=hashlib.sha256(original).hexdigest() if original else None))
    identity=b'Forest 0.45 native identity';write(data/'globalgamemanagers.assets',identity)
    write(source/'Contents/tfol.settings',b'original player settings')
    write(source/'Contents/Info.plist',plistlib.dumps(dict(CFBundleIdentifier='com.CarrotsCrittersVulpineVisions.TheForestofLove',CFBundleShortVersionString='0.45')))
    codec=resources/'forest-codec';shutil.copy2(WORK/'forest-codec',codec)
    manifest=dict(format=1,bundleID='com.CarrotsCrittersVulpineVisions.TheForestofLove',gameVersion='0.45',identityPath='globalgamemanagers.assets',identitySha256=hashlib.sha256(identity).hexdigest(),bundlePath=bundle,originals=originals,baselines=[dict(path='__bundle.asset',bytes=len(asset),sha256=hashlib.sha256(asset).hexdigest())],locales=[])
    codes=['ar','bg','cs','de','el','es-419','es','fa','fil','fr','he','hu','id','it','ja','ko','nl','pl','pt-BR','ro','ru','sr','th','tr','vi','zh-TW','zh']
    with zipfile.ZipFile(target/'raw.zip','w') as z:
        for code in codes:
            files=[]
            for name in names:
                block=('localized '+code+' '+name).encode();key=hashlib.sha256(block).hexdigest();z.writestr('chunks/'+key,block)
                if name==bundle:
                    localized=target/'asset';localized.write_bytes(block)
                    final=target/'bundle';subprocess.run([str(codec),'compose',str(data/bundle),str(localized),str(final)],check=True,stdout=subprocess.DEVNULL)
                    size=final.stat().st_size;final_sha=sha(final)
                else:size=len(block);final_sha=key
                files.append(dict(path=name,bytes=size,sha256=final_sha,storageBytes=len(block),storageSha256=key,segments=[dict(base=-1,offset=0,bytes=len(block),blob=key)],bundle=name==bundle))
            manifest['locales'].append(dict(code=code,name=code,culture=code,languageSha256='synthetic-only',files=files))
        raw_manifest=(json.dumps(manifest,sort_keys=True,indent=2)+'\n').encode();z.writestr('manifest.json',raw_manifest)
    receipt=wrap(target/'raw.zip',resources/'ForestLanguages.forestpack')
    config=dict(payloadSha256=receipt['sha256'],decodedSha256=receipt['decodedSha256'],manifestSha256=hashlib.sha256(raw_manifest).hexdigest(),codecSha256=sha(codec),locales=[dict(code=c,name=c) for c in ['en']+codes])
    write(resources/'PackageConfig.json',json.dumps(config).encode())
    return target,source

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--real',action='store_true');p.add_argument('--run',default='01');a=p.parse_args()
    assert a.run.isalnum(),'Run ID must be alphanumeric'
    binary=WORK/('CoreTests-'+('real-' if a.real else 'synthetic-')+a.run)
    subprocess.run(['swiftc','-swift-version','6','-warnings-as-errors','-parse-as-library','-target','arm64-apple-macosx14.0',str(ROOT/'MacOS/Sources/InstallerCore.swift'),str(ROOT/'MacOS/Tests/CoreTests.swift'),'-o',str(binary)],check=True)
    if a.real:
        target=WORK/('real-tests-'+a.run);assert not target.exists(),'Preserve an existing test run'
        target.mkdir();shutil.copytree(ROOT/'dist/Forest Languages.app/Contents/Resources',target/'Resources')
        source=Path('/Applications/TheForestOfLove.app')
    else:target,source=fixture(WORK/('synthetic-tests-'+a.run))
    subprocess.run([str(binary),str(target),str(source)]+(['--real'] if a.real else []),check=True)
