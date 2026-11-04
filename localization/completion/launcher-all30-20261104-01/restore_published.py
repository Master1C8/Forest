"""Restore unchanged published overlays by exact hashes, never recompiling wording."""
from pathlib import Path
import hashlib,json,shutil,subprocess,zipfile
ROOT=Path('/Users/antonkrutov/Desktop/Forest');CONTROL=ROOT/'localization/completion/launcher-all30-20261104-01'
WIN=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data');MAC=Path('/Applications/TheForestOfLove.app/Contents/Resources/Data')
WORK=ROOT/'dist/launcher-all30-work';WORK.mkdir(parents=True,exist_ok=True)
def sha(p):
 h=hashlib.sha256()
 with p.open('rb') as f:
  while data:=f.read(1<<20):h.update(data)
 return h.hexdigest()
def save(p,obj):p.parent.mkdir(parents=True,exist_ok=True);p.write_text(json.dumps(obj,sort_keys=True,indent=2)+'\n')
def put(p,data):
 p.parent.mkdir(parents=True,exist_ok=True)
 if p.exists():assert p.read_bytes()==data,('Conflicting prior resource',p)
 else:
  with p.open('xb') as f:f.write(data)
codec_source=ROOT/'dist/Forest Languages.app/Contents/Resources/forest-codec';mac_build=json.loads((CONTROL/'baseline-MacOS-build-receipt.json').read_bytes());assert sha(codec_source)==mac_build['payload']['codecSha256']
codec=WORK/('codec-'+sha(codec_source));
if not codec.exists():shutil.copy2(codec_source,codec)
for platform in ['Windows','MacOS']:
 work=ROOT/('dist/windows-installer-work' if platform=='Windows' else 'dist/macos-installer-work');work.mkdir(parents=True,exist_ok=True)
 build=json.loads((CONTROL/('baseline-'+platform+'-build-receipt.json')).read_bytes());package=ROOT/('dist/Forest-Language-Installer-Windows/Resources/ForestLanguages.forestpack' if platform=='Windows' else 'dist/Forest Languages.app/Contents/Resources/ForestLanguages.forestpack')
 pin=build['payload'];assert sha(package)==pin.get('sha256',pin.get('payloadSha256'))
 decoded=WORK/(platform+'-published.zip')
 if not decoded.exists():subprocess.run([str(codec),'inflate',str(package),str(decoded)],check=True)
 envelope=package.read_bytes()[:80];assert sha(decoded)==envelope[16:80].decode()
 original_root=WIN if platform=='Windows' else MAC
 with zipfile.ZipFile(decoded) as archive:
  manifest=json.loads(archive.read('manifest.json'));assert len(manifest['locales'])==27
  bundle=next(x['path'] for x in manifest['originals'] if x['path'].endswith('.bundle'))
  asset=WORK/(platform+'-original.asset')
  if not asset.exists():subprocess.run([str(codec),'extract',str(original_root/bundle),str(asset)],check=True)
  bases=[]
  for base in manifest['baselines']:
   p=asset if base['path']=='__bundle.asset' else original_root/base['path'];assert sha(p)==base['sha256'];bases.append(p.read_bytes())
  records={r['locale']:r for r in json.loads((CONTROL/'baseline-Windows-compiler-receipts.json').read_bytes())['locales']} if platform=='Windows' else {r['locale']:r for r in json.loads((CONTROL/'baseline-MacOS-native-resources.json').read_bytes())['localesEvidence']}
  restored=[]
  for locale in manifest['locales']:
   code=locale['code'];directory=work/'overlays'/code;source=ROOT/'localization/languages'/('ru-baseline.json' if code=='ru' else code+'.json');assert sha(source)==locale['languageSha256']
   output=directory/'The Forest of Love_Data' if platform=='Windows' else directory
   files={}
   for item in locale['files']:
    data=bytearray()
    for part in item['segments']:
     block=archive.read('chunks/'+part['blob']) if part['blob'] else bases[part['base']][part['offset']:part['offset']+part['bytes']]
     assert len(block)==part['bytes'];data+=block
    assert len(data)==item['storageBytes'] and hashlib.sha256(data).hexdigest()==item['storageSha256']
    path=output/item['path'];path.parent.mkdir(parents=True,exist_ok=True)
    if item['path']==bundle:
     raw=directory/'bundle.asset';put(raw,data)
     if platform=='Windows':
      recipe_data=archive.read('recipes/'+item['bundleRecipe']);assert hashlib.sha256(recipe_data).hexdigest()==item['bundleRecipe'];recipe=directory/'bundle.recipe';put(recipe,recipe_data)
      if not path.exists():subprocess.run([str(codec),'pack',str(original_root/bundle),str(raw),str(recipe),str(path)],check=True)
      cache=work/'bundles';proof=locale['bundleStorageProof'];assert proof['sourceSha256']==item['sha256'] and proof['assetSha256']==item['storageSha256']
      put(cache/(item['sha256']+'.asset'),data);put(cache/(item['sha256']+'.recipe'),recipe_data);save(cache/(item['sha256']+'.json'),proof)
     else:
      if not path.exists():subprocess.run([str(codec),'compose',str(original_root/bundle),str(raw),str(path)],check=True,stdout=subprocess.DEVNULL)
    else:put(path,data)
    assert path.stat().st_size==item['bytes'] and sha(path)==item['sha256'];files[item['path']]=dict(bytes=item['bytes'],sha256=item['sha256'])
   if platform=='Windows':
    language=json.loads(source.read_bytes());framework=ROOT/'localization/framework'/language['framework']['id']
    for name in ['app.info','tfol.settings']:put(output/name,(framework/'base'/name).read_bytes())
    record=records[code]
    for name,pin in record['files'].items():assert sha(directory/name)==pin['sha256'] and (directory/name).stat().st_size==pin['bytes']
    restored_manifest=dict(record,format='forest-restored-published-output-v1',reusedOriginalCompilerManifestSha256=record['manifestSha256'],publishedPayloadSha256=sha(package),reconstructionVerified=True,acceptance='Reuse exact previously compiled bytes; no new semantic/compiler acceptance')
   else:
    record=records[code];assert files==record['files'];proofs=[record['managed'],*record['serialized'],dict(bytes=files[bundle]['bytes'],crc32=record['bundleReadback']['crc32'],contiguousMembers=True,originalEncodedTailPreserved=True)]
    restored_manifest=dict(locale=code,culture=locale['culture'],name=locale['name'],languageSha256=locale['languageSha256'],files=files,proofs=proofs,reusedPublishedPayloadSha256=sha(package))
   save(directory/'manifest.json',restored_manifest);restored.append(restored_manifest);print('restored '+platform+' '+code,flush=True)
  if platform=='MacOS':save(work/'resources.json',restored)
 save(WORK/(platform+'-restored.json'),dict(publishedPayloadSha256=sha(package),locales=27,exactResources=378,languageHashesMatch=True,metadataBoundary='Windows restored manifests are explicit reuse records, not reconstructed original compiler logs'))
print('All unchanged published resource bytes recovered and SHA-verified',flush=True)
