import sys,pathlib,hashlib,json
sys.path.insert(0,'tools')
import UnityPy
from russian_remaining51_case import sha,digest
p=pathlib.Path('localization/previews/ru-20261029-chapter-gallery-02/game/The Forest of Love_Data/resources.assets')
e=UnityPy.load(str(p));o=next(o for o in e.objects if o.path_id==320);t=o.read_typetree();b=t['m_Script'].encode('utf-8','surrogateescape')
print(json.dumps({'resourceSha256':sha(p),'bytes':p.stat().st_size,'payloadSha256':digest(b),'payloadBytes':len(b),'textures':sum(o.type.name=='Texture2D' for o in e.objects),'objects':len(list(e.objects))}))
