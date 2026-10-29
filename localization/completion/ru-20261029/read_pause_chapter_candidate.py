from pathlib import Path
import json,hashlib,sys,collections
ROOT=Path('/Users/antonkrutov/Desktop/Forest');sys.path.insert(0,str(ROOT/'tools'))
import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
from extract_assets import read_tree
folder=ROOT/'localization/source/chapter-select-heading-20261029'
selected=[]
for l in (ROOT/'localization/source/shared-source-completion-20261028/admission-v1/serialized-inventory.jsonl').open():
 r=json.loads(l)
 if r.get('hierarchy','').startswith(('LevelSingletons/PauseScreenUI/','LevelSingletons/ChapterSelectUI/')):selected.append(r)
assert len(selected)==576
DATA=ROOT/'localization/previews/ru-20261029-bio-input-v2-01/game/The Forest of Love_Data'
env=UnityPy.load(str(DATA/'sharedassets2.assets'));objects={o.path_id:o for o in env.objects}
g=TypeTreeGenerator('2020.3.24f1');g.load_local_dll_folder(str(DATA/'Managed'))
rows=[]
for r in selected:
 file,tail=r['id'].split(':',1);pid,ptr=tail.split('/',1);assert file=='sharedassets2.assets'
 t=read_tree(objects[int(pid)],g);v=t
 for k in ptr.split('/'):v=v[int(k)] if isinstance(v,list) else v[k]
 rows.append(dict(id=r['id'],source=r['source'],sourceValueSha256=r['sourceValueSha256'],role=r['role'],hierarchy=r['hierarchy'],currentValue=v,sourceEqual=v==r['source'],className=r['className'],pointer=r['pointer']))
with (folder/'pause-chapter-576-readback.jsonl').open('x') as f:
 for r in rows:f.write(json.dumps(r,ensure_ascii=False)+'\n')
missing=[r for r in rows if r['role']=='display-source' and r['sourceEqual']]
summary=dict(status='actual-new-full-candidate-known-selector-readback',selectors=576,sourceEqualDisplayMemberships=len(missing),sourceEqualDisplayGroups=len({r['source'] for r in missing}),roleCounts=dict(collections.Counter(r['role'] for r in rows)),candidate=str(DATA.parent.parent),buildSha256=hashlib.sha256((DATA.parent.parent/'build.json').read_bytes()).hexdigest(),containerSha256=hashlib.sha256((DATA/'sharedassets2.assets').read_bytes()).hexdigest(),sourceEqualDisplayValues=dict(collections.Counter(r['source'] for r in missing)),boundary='Actual stored-value comparison only; equality is not automatic translation permission, unknown input/reachability/template roles remain explicit. No source inventory or game input modified.')
(folder/'pause-chapter-576-readback-summary.json').write_text(json.dumps(summary,ensure_ascii=False,indent=2)+'\n');print(json.dumps(summary,ensure_ascii=False))
