#!/usr/bin/env python3
"""Static native resource readback. Does not launch a game or alter its files."""
import base64
import hashlib
import json
from pathlib import Path
import struct
import subprocess

ROOT=Path(__file__).resolve().parents[1];WORK=ROOT/'dist/macos-installer-work'
def sha(p):
    h=hashlib.sha256()
    with p.open('rb') as f:
        while b:=f.read(1<<20):h.update(b)
    return h.hexdigest()
def catalog(data):
    raw=base64.b64decode(json.loads(data)['m_ExtraDataString']);at=0;rows=[]
    while at<len(raw):
        assert raw[at]==7;at+=1;at+=1+raw[at];at+=1+raw[at]
        length=struct.unpack_from('<I',raw,at)[0];at+=4;rows.append(json.loads(raw[at:at+length].decode('utf-16le')));at+=length
    assert at==len(raw);return rows

if __name__=='__main__':
    win=ROOT/'Windows';binary=WORK/'verify-bundle'
    subprocess.run(['cc','-O2','-Wall','-Wextra','-Werror','-I',str(win/'vendor/lz4'),'-I',str(win/'vendor/lzma'),
        str(ROOT/'MacOS/BundleVerify.c'),str(win/'vendor/lz4/lz4.c'),str(win/'vendor/lz4/lz4hc.c'),str(win/'vendor/lzma/LzmaDec.c'),'-lz','-o',str(binary)],check=True)
    data=Path('/Applications/TheForestOfLove.app/Contents/Resources/Data')
    original=next((data/'StreamingAssets/aa/StandaloneOSX').glob('defaultlocalgroup_assets_all*'))
    original_catalog=catalog((data/'StreamingAssets/aa/catalog.json').read_bytes());records=json.loads((WORK/'resources.json').read_bytes());proofs=[]
    assert len(records)==27
    for record in records:
        directory=WORK/'overlays'/record['locale'];paths=record['files'];assert len(paths)==14
        for name,pin in paths.items():assert sha(directory/name)==pin['sha256'] and (directory/name).stat().st_size==pin['bytes']
        result=json.loads(subprocess.check_output([str(binary),str(original),str(directory/'bundle.asset'),str(directory/original.relative_to(data))]))
        new_catalog=catalog((directory/'StreamingAssets/aa/catalog.json').read_bytes());assert len(new_catalog)==len(original_catalog)
        selected=0
        for old,new in zip(original_catalog,new_catalog):
            expected=dict(old)
            if old['m_Hash']=='376e2641519a356eded756c3d05ae96a':
                expected['m_Crc']=result['crc32'];expected['m_BundleSize']=(directory/original.relative_to(data)).stat().st_size;selected+=1
            assert new==expected,'Native catalog changed outside CRC/size'
        assert selected==1
        proofs.append(dict(locale=record['locale'],languageSha256=record['languageSha256'],files=paths,
            bundleReadback=result,nativeCatalogOnlyCRCAndSizeChanged=True,managed=record['proofs'][0],
            serialized=[p for p in record['proofs'] if 'selectedBeforeImagesEqual' in p]))
        print('verified native macOS '+record['locale'],flush=True)
    result=dict(passed=True,locales=len(proofs),resources=14,completeNativeStreamingReadbacks=27,gameLaunched=False,
        rendererAcceptance='not-run',boundary='All produced resource bytes and complete native stream; excludes Unity execution/rendering',localesEvidence=proofs)
    (ROOT/'MacOS/native-resources.json').write_text(json.dumps(result,sort_keys=True,indent=2)+'\n')
