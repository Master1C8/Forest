"""Read exact serialized selectors for the menu/roster/nameplate layout defects."""
from pathlib import Path
import hashlib,json,argparse
from forest_localization.core import engines
ROOT=Path(__file__).resolve().parents[1]
U,Generator,tree,canonical,comp,inv,writer=engines()
framework=ROOT/'localization/framework/forest045-shared'
gen=Generator('2020.3.24f1');gen.load_local_dll_folder(str(framework/'references'))
rows=[]
p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',type=Path);p.add_argument('--assets',nargs='+',default=['level1','sharedassets2.assets']);args=p.parse_args()
for asset in args.assets:
    assert asset in json.loads((framework/'framework.json').read_bytes())['resources']
    env=U.load(str(framework/'base'/asset));env.path=str(framework/'base')
    objects=comp.objects(env);cache={}
    def value(pid):
        if pid not in cache:cache[pid]=tree(objects[pid],gen)
        return cache[pid]
    def address(go):
        t=value(go)
        transforms=[r['component']['m_PathID'] for r in t['m_Component'] if objects[r['component']['m_PathID']].type.name in ['Transform','RectTransform']]
        assert len(transforms)==1
        tr=value(transforms[0]);parent=tr['m_Father'];assert parent['m_FileID']==0
        return (address(value(parent['m_PathID'])['m_GameObject']['m_PathID'])+'/' if parent['m_PathID'] else '')+t['m_Name']
    for pid,o in objects.items():
        if o.type.name!='MonoBehaviour':continue
        head=o.parse_monobehaviour_head()
        if head.m_GameObject.path_id==0:continue
        path=address(head.m_GameObject.path_id)
        if not (path.startswith(('Canvas/MainMenu/','Canvas/OptionsMenu/','Canvas/GalleryMenu/')) or '/ResidentsScrollView/' in path or path.endswith('/NameplateRoot/NameLabel')):continue
        script=head.m_Script.deref().read()
        if script.m_ClassName not in ['TextMeshProUGUI','Text']:continue
        t=value(pid)
        key='m_fontSize' if script.m_ClassName=='TextMeshProUGUI' else 'm_FontData'
        size=t[key] if key=='m_fontSize' else t[key]['m_FontSize']
        rect=next(value(r['component']['m_PathID']) for r in value(t['m_GameObject']['m_PathID'])['m_Component'] if objects[r['component']['m_PathID']].type.name=='RectTransform')
        rows.append(dict(role=asset+':'+str(pid),asset=asset,pathId=pid,path=path,kind=script.m_ClassName,size=size,pointer='/m_fontSize' if key=='m_fontSize' else '/m_FontData/m_FontSize',text=t.get('m_text',t.get('m_Text')),rect=rect,rawSha256=hashlib.sha256(o.get_raw_data()).hexdigest()))
out=args.output or ROOT/'localization/screenshots/all30-owner-20261104-01/menu-layout-inventory-01.json'
out=out.resolve();assert out.is_relative_to(ROOT/'localization/screenshots')
assert not out.exists();out.write_text(json.dumps(dict(recipeSha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),rows=rows),ensure_ascii=False,indent=2)+'\n')
print('Exact layout rows:',len(rows),out)
