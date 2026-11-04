#!/usr/bin/env python3
"""Forest's finite macOS resource adapter; canonical wording stays unchanged."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import zipfile
import struct
import base64
import re
import gc

ROOT=Path(__file__).resolve().parents[1]
WORK=ROOT/'dist/macos-installer-work'
GAME=Path('/Applications/TheForestOfLove.app')
DATA=GAME/'Contents/Resources/Data'


def digest(p): return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def verified_source_asset(source, target, codec):
    """Bind a cached serialized member to its exact original and decoder."""
    receipt=target.with_suffix(target.suffix+'.source.json')
    pins=dict(sourceSha256=digest(source),codecSha256=digest(codec))
    if receipt.exists():
        saved=json.loads(receipt.read_bytes())
        assert all(saved[k]==v for k,v in pins.items()),'serialized-source-cache-input-drift'
        assert target.exists() and digest(target)==saved['assetSha256'],'serialized-source-cache-body-drift'
        return target
    fresh=target.with_suffix(target.suffix+'.verification')
    assert not fresh.exists(),'Preserve and reconcile the previous serialized-source verification'
    subprocess.run([str(codec),'extract',str(source),str(fresh)],check=True)
    expected=digest(fresh)
    if target.exists():
        assert digest(target)==expected,'unverified-serialized-source-cache-differs'
        fresh.unlink()
    else:fresh.replace(target)
    receipt.write_text(json.dumps(dict(pins,assetSha256=expected),indent=2)+'\n')
    return target


def managed():
    out=WORK/'assembly-port';out.mkdir(parents=True,exist_ok=True)
    shared=(ROOT/'tools/forest_localization/Managed.cs').read_text()
    assert shared.count('static class Program {')==1 and shared.count('static void Main(')==1
    shared=shared.replace('static class Program {','static partial class Program {').replace('static void Main(','static void LegacyMain(')
    shared=shared.replace('m.Body.CodeSize<64','m.Body.Instructions.Sum(i=>i.GetSize())<64')
    (out/'SharedInspection.cs').write_text(shared)
    for name in ['AssemblyPort.cs','AssemblyPort.csproj']:shutil.copy2(ROOT/'MacOS/Compiler'/name,out/name)
    cecil=ROOT/'tools/locale_completion/resource_composition_v1/managed_saved/bin/Debug/net8.0/Mono.Cecil.dll'
    subprocess.run(['dotnet','build',str(out/'AssemblyPort.csproj'),'-c','Release','--nologo','-v','quiet','-p:CecilPath='+str(cecil)],check=True)
    return out/'bin/Release/net8.0/AssemblyPort.dll'


def asset_objects(env): return {o.path_id:o for o in env.objects}


def catalog_update(data, old_size, crc, size):
    catalog=json.loads(data);extra=bytearray(base64.b64decode(catalog['m_ExtraDataString']));at=0;changed=0
    while at<len(extra):
        assert extra[at]==7;at+=1;n=extra[at];at+=1+n;n=extra[at];at+=1+n
        length=struct.unpack_from('<I',extra,at)[0];at+=4;text=extra[at:at+length].decode('utf-16le');row=json.loads(text)
        if row['m_Hash']=='376e2641519a356eded756c3d05ae96a':
            assert row['m_BundleSize']==old_size and row['m_UseCrcForCachedBundles'] and not row['m_UseUWRForLocalBundles']
            for key,value in [('m_Crc',crc),('m_BundleSize',size)]:
                match=re.search('("'+key+'"\\s*:\\s*)([0-9]+)',text);assert match and len(str(value))<=len(match[2]),'catalog-field-capacity'
                text=text[:match.start(2)]+str(value).rjust(len(match[2]))+text[match.end(2):]
            encoded=text.encode('utf-16le');assert len(encoded)==length;extra[at:at+length]=encoded;changed+=1
        at+=length
    assert changed==1;catalog['m_ExtraDataString']=base64.b64encode(extra).decode()
    return json.dumps(catalog,separators=(',',':')).encode()


def port_serialized(original_windows, target_windows, original_mac, output):
    import UnityPy
    we=UnityPy.load(str(original_windows));te=UnityPy.load(str(target_windows));me=UnityPy.load(str(original_mac))
    wo,to,mo=asset_objects(we),asset_objects(te),asset_objects(me)
    assert set(wo)==set(to),'windows-target-object-set'
    changed=[i for i in wo if wo[i].get_raw_data()!=to[i].get_raw_data()]
    expected={pid:obj.get_raw_data() for pid,obj in mo.items()}
    for pid in changed:
        assert pid in mo and mo[pid].type==wo[pid].type and mo[pid].get_raw_data()==wo[pid].get_raw_data(),('native-source-object-difference',str(original_mac),pid)
        assert mo[pid].type.name not in ['Texture2D','Shader','SpriteAtlas'],'protected-platform-resource'
        expected[pid]=to[pid].get_raw_data();mo[pid].set_raw_data(expected[pid])
    data=me.file.save();saved=UnityPy.load(data);so=asset_objects(saved)
    assert set(so)==set(mo)
    for pid in mo:assert so[pid].get_raw_data()==expected[pid],('whole-object-readback',pid)
    for key in ['unity_version','target_platform','_enable_type_tree']:
        assert getattr(me.file,key)==getattr(saved.file,key),('native-header',key)
    assert [(e.path,e.guid,e.type) for e in me.file.externals]==[(e.path,e.guid,e.type) for e in saved.file.externals]
    output.parent.mkdir(parents=True,exist_ok=True);output.write_bytes(data)
    result=dict(objects=len(mo),selectedObjects=len(changed),nativeSourceSha256=digest(original_mac),windowsTargetSha256=digest(target_windows),outputSha256=digest(output),allUnselectedNativeObjectsExact=True,selectedBeforeImagesEqual=True,nativePlatformAndExternalsPreserved=True)
    del we,te,me,saved,wo,to,mo,so;gc.collect();return result


def port_locale(locale, inputs, win, win_bundle, win_asset, mac_bundle, mac_asset, tool, codec):
    code=locale['code'];out=WORK/'overlays'/code;out.mkdir(parents=True,exist_ok=True)
    receipt=out/'manifest.json'
    if receipt.exists():
        saved=json.loads(receipt.read_bytes());assert saved['languageSha256']==locale['languageSha256']
        assert all(digest(out/n)==v['sha256'] for n,v in saved['files'].items())
        print('reused macOS '+code,flush=True);return saved
    mac_bundle_name=mac_bundle.relative_to(DATA).as_posix()
    files={};proofs=[];temp=out/'target-windows.bin'
    for name,data in inputs:
        temp.write_bytes(data)
        mac_name=mac_bundle_name if name==win_bundle else name;dest=out/mac_name
        if name.endswith('VNRevivalInventoryLayout.dll') or name.endswith('VNRevivalQuestLayout.dll'):
            dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(data)
        elif name.endswith('Assembly-CSharp.dll'):
            dest.parent.mkdir(parents=True,exist_ok=True);proof=out/'managed-proof.json'
            subprocess.run(['dotnet',str(tool),'port',str(win/name),str(DATA/name),str(temp),str(dest),str(proof)],check=True)
            proofs.append(json.loads(proof.read_bytes()))
        elif name==win_bundle:
            asset=out/'bundle.asset';proofs.append(port_serialized(win_asset,temp,mac_asset,asset))
            dest.parent.mkdir(parents=True,exist_ok=True)
            meta=json.loads(subprocess.check_output([str(codec),'compose',str(mac_bundle),str(asset),str(dest)]))
            catalog=catalog_update((DATA/'StreamingAssets/aa/catalog.json').read_bytes(),mac_bundle.stat().st_size,meta['crc32'],dest.stat().st_size)
            catalog_path=out/'StreamingAssets/aa/catalog.json';catalog_path.parent.mkdir(parents=True,exist_ok=True);catalog_path.write_bytes(catalog)
            files['StreamingAssets/aa/catalog.json']=dict(bytes=len(catalog),sha256=digest(catalog_path));proofs.append(meta)
        elif name=='StreamingAssets/aa/catalog.json':continue
        else:proofs.append(port_serialized(win/name,temp,DATA/name,dest))
        files[mac_name]=dict(bytes=dest.stat().st_size,sha256=digest(dest))
    saved=dict(locale=code,culture=locale['culture'],name=locale['name'],languageSha256=locale['languageSha256'],files=files,proofs=proofs)
    if 'compilerManifestSha256' in locale:saved['windowsCompilerManifestSha256']=locale['compilerManifestSha256']
    receipt.write_text(json.dumps(saved,indent=2)+'\n');print('built macOS '+code,flush=True)
    return saved


def build_resources():
    codec=WORK/'forest-codec';tool=managed()
    win=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')
    package=Path(os.environ.get('FOREST_WINDOWS_PAYLOAD',str(ROOT/'dist/Forest-Language-Installer-Windows/Resources/ForestLanguages.forestpack')))
    pins=json.loads((ROOT/'Windows/build-receipt.json').read_bytes());assert digest(package)==pins['payload']['sha256']
    decoded=WORK/('windows-payload-'+pins['payload']['sha256']+'.zip')
    if not decoded.exists():subprocess.run([str(codec),'inflate',str(package),str(decoded)],check=True)
    header=package.read_bytes()[:80];assert digest(decoded)==header[16:80].decode()
    mac_bundle=next((DATA/'StreamingAssets/aa/StandaloneOSX').glob('defaultlocalgroup_assets_all*'));mac_bundle_name=mac_bundle.relative_to(DATA).as_posix()
    with zipfile.ZipFile(decoded) as archive:
        manifest=json.loads(archive.read('manifest.json'));win_bundle=next(x['path'] for x in manifest['originals'] if x['path'].endswith('.bundle'))
        win_asset=WORK/'original-windows.asset';mac_asset=WORK/'original-macos.asset'
        for source,target in [(win/win_bundle,win_asset),(mac_bundle,mac_asset)]:
            if not target.exists():subprocess.run([str(codec),'extract',str(source),str(target)],check=True)
        bases=[]
        for base in manifest['baselines']:
            source=win_asset if base['path']=='__bundle.asset' else win/base['path'];assert digest(source)==base['sha256'];bases.append(source.read_bytes())
        all_receipts=[]
        for locale in manifest['locales']:
            code=locale['code'];out=WORK/'overlays'/code;out.mkdir(parents=True,exist_ok=True)
            receipt=out/'manifest.json'
            if receipt.exists():
                saved=json.loads(receipt.read_bytes());assert saved['languageSha256']==locale['languageSha256']
                assert all(digest(out/n)==v['sha256'] for n,v in saved['files'].items());all_receipts.append(saved);print('reused macOS '+code,flush=True);continue
            def inputs():
                for item in locale['files']:
                    data=bytearray()
                    for part in item['segments']:
                        piece=archive.read('chunks/'+part['blob']) if part['blob'] else bases[part['base']][part['offset']:part['offset']+part['bytes']]
                        assert len(piece)==part['bytes'];data+=piece
                    assert hashlib.sha256(data).hexdigest()==item['storageSha256']
                    yield item['path'],data
            all_receipts.append(port_locale(locale, inputs(), win, win_bundle, win_asset, mac_bundle, mac_asset, tool, codec))
    (WORK/'resources.json').write_text(json.dumps(all_receipts,indent=2)+'\n')


def build_from_overlays(directory, codes):
    """Use the normal compiler directly; the native port operation is shared."""
    from build_windows_installer import CONFIG
    assert codes and len(codes)==len(set(codes))
    codec=WORK/'forest-codec'
    win=Path(os.environ.get('FOREST_ORIGINAL_GAME','/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest'))/CONFIG['dataDirectory']
    framework=json.loads((ROOT/'localization/framework/forest045-shared/framework.json').read_bytes())
    paths=sorted(set(framework['resources'])-set(CONFIG['preservedFiles']))
    for name in paths:
        pin=framework['sourceMembers'].get(name)
        if pin:assert (win/name).stat().st_size==pin['bytes'] and digest(win/name)==pin['sha256'],('original-windows-input-drift',name)
    native=json.loads((ROOT/'MacOS/original-inputs.json').read_bytes())
    for pin in native['originals']:
        if pin['sha256']:assert (DATA/pin['path']).stat().st_size==pin['bytes'] and digest(DATA/pin['path'])==pin['sha256'],('original-macos-input-drift',pin['path'])
    tool=managed()
    win_bundle=next(n for n in paths if n.endswith('.bundle'))
    mac_bundle=next((DATA/'StreamingAssets/aa/StandaloneOSX').glob('defaultlocalgroup_assets_all*'))
    win_asset=WORK/'original-windows.asset';mac_asset=WORK/'original-macos.asset'
    for source,target in [(win/win_bundle,win_asset),(mac_bundle,mac_asset)]:
        verified_source_asset(source,target,codec)
    assert digest(mac_asset)==native['serializedBundle']['sha256'],'original-macos-serialized-drift'
    for code in codes:
        assert code in {p.stem for p in (ROOT/'localization/languages').glob('*.json')} and code!='ru-baseline'
        language=ROOT/'localization/languages'/CONFIG['sourceOverrides'].get(code,code+'.json')
        overlay=directory/code;manifest=overlay/'manifest.json';built=json.loads(manifest.read_bytes())
        assert built['locale']==code and built['languageSha256']==digest(language)
        expected_paths={CONFIG['dataDirectory']+'/'+n for n in framework['resources']}
        assert set(built['files'])==expected_paths
        for name,pin in built['files'].items():
            source=overlay/name
            assert digest(source)==pin['sha256'] and source.stat().st_size==pin['bytes']
        locale=dict(code=code,culture=built['culture'],name=code,languageSha256=built['languageSha256'],compilerManifestSha256=digest(manifest))
        def inputs():
            for name in paths:
                source=overlay/CONFIG['dataDirectory']/name
                if name==win_bundle:
                    serialized=WORK/'overlays'/code/'windows-bundle.asset';serialized.parent.mkdir(parents=True,exist_ok=True)
                    subprocess.run([str(codec),'extract',str(source),str(serialized)],check=True)
                    yield name,serialized.read_bytes()
                else:yield name,source.read_bytes()
        port_locale(locale,inputs(),win,win_bundle,win_asset,mac_bundle,mac_asset,tool,codec)
    receipts=[json.loads(p.read_bytes()) for p in sorted((WORK/'overlays').glob('*/manifest.json'))]
    (WORK/'resources.json').write_text(json.dumps(receipts,indent=2)+'\n')


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('stage',choices=['managed-probe','resources']);p.add_argument('--windows-overlays',type=Path);p.add_argument('--locale',action='append');a=p.parse_args()
    if a.windows_overlays or a.locale:
        assert a.stage=='resources' and a.windows_overlays and a.locale
        build_from_overlays(a.windows_overlays,a.locale)
    elif a.stage=='resources':build_resources()
    else:
        tool=managed();original=ROOT/'localization/framework/forest045-shared/references/Assembly-CSharp.dll'
        subprocess.run(['dotnet',str(tool),'compare',str(original),str(DATA/'Managed/Assembly-CSharp.dll'),str(WORK/'managed-probe.json')],check=True)
        subprocess.run(['dotnet',str(tool),'delta',str(original),str(DATA/'Managed/Assembly-CSharp.dll'),str(ROOT/'localization/framework/forest045-shared/base/Managed/Assembly-CSharp.dll'),str(WORK/'managed-delta.json')],check=True)
