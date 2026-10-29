"""Read-only source-manifest-to-candidate texture preservation; no decoding/images."""
import json,pathlib,hashlib,collections
import UnityPy
R=pathlib.Path('/Users/antonkrutov/Desktop/Forest');C=R/'outputs/ru-remaining51-application-20261029/check';game=R/'localization/previews/ru-20261029-chapter-gallery-02/game/The Forest of Love_Data'
sha=lambda p:hashlib.sha256(pathlib.Path(p).read_bytes()).hexdigest()
textures=json.loads((R/'assets/source-v2/textures.json').read_text());assert len(textures)==1385
by=collections.defaultdict(list)
for x in textures:by[x['sourceFile']].append(x)
report=[]
for name,rs in by.items():
 p=C/'bg-private-01/resources.assets' if name=='resources.assets' else game/name
 env=UnityPy.load(str(p));obs={(o.assets_file.name,o.path_id):o for o in env.objects}
 for r in rs:
  key=(r['asset'].split('/')[-1],r['pathId']);o=obs[key];assert o.type.name=='Texture2D';assert hashlib.sha256(o.get_raw_data()).hexdigest()==r['rawSha256'],r['id']
 report.append({'sourceFile':name,'checkedFile':str(p.relative_to(R)),'sha256':sha(p),'textures':len(rs)})
(C/'textures-preserved.json').write_text(json.dumps({'status':'passed','textures':1385,'manifestSha256':sha(R/'assets/source-v2/textures.json'),'files':report,'boundary':'All original serialized Texture2D object payload hashes match on actual candidate files with private resources substituted; no texture images emitted. External streamed pixels are not rewritten by this stage.'},indent=2)+'\n');print('all 1385 original Texture2D payloads unchanged')
