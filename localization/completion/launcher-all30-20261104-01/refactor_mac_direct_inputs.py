"""Share the existing native port operation between payload and normal overlays."""
from pathlib import Path
p=Path('tools/forest_macos.py');s=p.read_text();start=s.index('            files={};proofs=[];temp=WORK/');end=s.index("    (WORK/'resources.json')",start)
old=s[start:end]
# Extract the existing operation without changing its object/assembly/catalog gates.
body=old[old.index("                mac_name="):old.index("            saved=dict")]
body='\n'.join(line[12:] if line.startswith('            ') else line for line in body.splitlines())
helper='''def port_locale(locale, inputs, win, win_bundle, win_asset, mac_bundle, mac_asset, tool, codec):
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
'''+body+'''
    saved=dict(locale=code,culture=locale['culture'],name=locale['name'],languageSha256=locale['languageSha256'],files=files,proofs=proofs)
    if 'compilerManifestSha256' in locale:saved['windowsCompilerManifestSha256']=locale['compilerManifestSha256']
    receipt.write_text(json.dumps(saved,indent=2)+'\\n');print('built macOS '+code,flush=True)
    return saved


'''
s=s[:start]+'''            def inputs():
                for item in locale['files']:
                    data=bytearray()
                    for part in item['segments']:
                        piece=archive.read('chunks/'+part['blob']) if part['blob'] else bases[part['base']][part['offset']:part['offset']+part['bytes']]
                        assert len(piece)==part['bytes'];data+=piece
                    assert hashlib.sha256(data).hexdigest()==item['storageSha256']
                    yield item['path'],data
            all_receipts.append(port_locale(locale, inputs(), win, win_bundle, win_asset, mac_bundle, mac_asset, tool, codec))
'''+s[end:]
s=s.replace('def build_resources():',helper+'def build_resources():',1)
p.write_text(s)
