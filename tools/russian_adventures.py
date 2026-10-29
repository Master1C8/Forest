#!/usr/bin/env python3
"""Reviewed three-page adventure tutorial and coherent body-layer heights."""
import argparse
import copy
import hashlib
import importlib.metadata
import json
from pathlib import Path
import re
import shutil
import sys

PROJECT=Path('/Users/antonkrutov/Desktop/Forest')
LOCAL=Path(__file__).resolve().parent
if (LOCAL/'adventures/pins.json').exists():LOCAL=LOCAL/'adventures'
PACKET=LOCAL/'inputs' if (LOCAL/'pins.json').exists() else PROJECT/'localization/hotfixes/ru-adventures24-20261029'


def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def dependencies(lock):
    packages={}
    for line in lock.read_text().splitlines():
        name,version=line.split('==');dist=importlib.metadata.distribution(name);assert dist.version==version
        packages[name]=dict(version=version,files={str(p):sha(dist.locate_file(p)) for p in dist.files if '..' not in p.parts and Path(str(p)).suffix!='.pyc' and dist.locate_file(p).is_file()})
    return dict(python=list(sys.version_info[:3]),packages=packages)


def differences(a,b,p=''):
    if isinstance(a,dict) and isinstance(b,dict):
        assert a.keys()==b.keys();return [q for k in a for q in differences(a[k],b[k],p+'/'+k)]
    if isinstance(a,list) and isinstance(b,list):
        assert len(a)==len(b);return [q for i in range(len(a)) for q in differences(a[i],b[i],p+'/'+str(i))]
    return [] if a==b else [p]


def load_inputs():
    if (LOCAL/'pins.json').exists():
        for n,h in json.loads((LOCAL/'pins.json').read_text()).items():assert sha(LOCAL/n)==h,('Adventure snapshot pin',n)
        assert dependencies(LOCAL/'requirements-assets.lock')==json.loads((LOCAL/'runtime-dependencies.json').read_text())
    c=json.loads((PACKET/'contract.json').read_text());targets=json.loads((PACKET/'targets.json').read_text());review=json.loads((PACKET/'independent-review.json').read_text());layout=json.loads((PACKET/'body-layout-plan.json').read_text());scope=json.loads((PACKET/'membership-scope.json').read_text());guards=json.loads((PACKET/'source-guards.json').read_text())
    assert c['resource']=='sharedassets2.assets' and c['locale']=='ru'
    assert review['status']=='clean' and not review['findings']
    assert c['targetsSha256']==review['targetsSha256']==layout['targetsSha256']==sha(PACKET/'targets.json')
    assert review['packetSha256']==sha(PACKET/'review-packet.json') and not layout['missingCodepoints']
    ids={r['id'] for r in targets};assert len(targets)==24 and review['coverage']['complete'] and review['coverage']['memberships']==24 and set(review['coverage']['allMembershipIds'])==ids
    assert {r['id'] for r in scope['rows'] if r['status']=='active-display-when-page-selected'}==ids
    assert scope['counts']=={'active-display-when-page-selected':24,'inactive-contained-heading':12,'inactive-unrelated-template':12}
    assert guards['resourceSha256']==c['sourceSha256'] and len(layout['changes'])==15
    byid={r['id']:r for r in targets};groups={}
    for r in c['rows']:
        t=byid[r['id']];assert (r['beforeTree']['m_text'],r['target'],r['hierarchy'])==(t['source'],t['target'],t['hierarchy'])
        assert re.findall('<[^>]*>',t['source'])==re.findall('<[^>]*>',t['target'])
        groups.setdefault(r['hierarchy'].split('/NameGlowLeft')[0],[]).append(r)
    assert len(c['rows'])==24 and len(groups)==4
    suffixes={'','/NameGlowLeft','/NameGlowLeft/Name','/NameGlowLeft/NameGlowTop','/NameGlowLeft/NameGlowRight','/NameGlowLeft/NameGlowBottom'}
    for base,rows in groups.items():
        assert len(rows)==6 and {r['hierarchy'][len(base):] for r in rows}==suffixes and len({r['target'] for r in rows})==1
    rects=set()
    for r in layout['changes']:
        assert r['pathId'] not in rects;rects.add(r['pathId'])
        allowed={'/m_AnchorMin/y','/m_AnchorMax/y'}
        if r['beforeTree']['m_SizeDelta']['y']!=0:allowed.add('/m_SizeDelta/y')
        assert set(differences(r['beforeTree'],r['afterTree']))==allowed
        assert r['afterTree']['m_AnchorMin']['y']==0 and r['afterTree']['m_AnchorMax']['y']==1 and r['afterTree']['m_SizeDelta']['y']==0
        assert '/NameContainer/NameGlowLeft' in r['hierarchy'] and r['beforeTree']['m_Pivot']['y']==0.5
    assert not rects & {r['pathId'] for r in c['rows']}
    return c,layout,guards


def snapshot(out):
    load_inputs();dest=Path(out)/'adventures';dest.mkdir();(dest/'inputs').mkdir()
    for n in ['contract.json','targets.json','review-packet.json','independent-review.json','body-layout-plan.json','membership-scope.json','source-guards.json']:shutil.copy2(PACKET/n,dest/'inputs'/n)
    for n in ['russian_adventures.py','extract_assets.py']:shutil.copy2(LOCAL/n,dest/n)
    lock=LOCAL/'requirements-assets.lock';shutil.copy2(lock if lock.exists() else PROJECT/'requirements-assets.lock',dest/'requirements-assets.lock');(dest/'runtime-dependencies.json').write_text(json.dumps(dependencies(dest/'requirements-assets.lock'),indent=2)+'\n');shutil.copy2(dest/'russian_adventures.py',Path(out)/'russian_adventures.py');(dest/'pins.json').write_text(json.dumps({str(p.relative_to(dest)):sha(p) for p in sorted(dest.rglob('*')) if p.is_file()},indent=2)+'\n');return dest


def apply(source,output,*,locale='ru',fail_after_resource=False):
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    from extract_assets import read_tree,canonical
    c,layout,guards=load_inputs();source,output=Path(source),Path(output)
    assert locale=='ru' and not output.exists(),'New Russian adventure output required'
    for n,h in [(c['resource'],c['sourceSha256']),('resources.assets',c['requiredResourcesSha256']),('Managed/Assembly-CSharp.dll',c['requiredAssemblySha256']),('sharedassets0.assets',c['fontContainerSha256'])]:assert sha(source/n)==h,('Adventure source binding',n)
    g=TypeTreeGenerator('2020.3.24f1');g.load_local_dll_folder(str(source/'Managed'));env=UnityPy.load(str(source/c['resource']));objects=env.file.objects;raw={pid:o.get_raw_data() for pid,o in objects.items()};assert env.file.save()==(source/c['resource']).read_bytes()
    for pid,r in guards['objects'].items():assert hashlib.sha256(raw[int(pid)]).hexdigest()==r['rawSha256'],('Adventure structural guard',pid)
    expected={}
    for r in c['rows']:
        assert canonical(read_tree(objects[r['pathId']],g))==r['beforeTree'];expected[r['pathId']]=dict(copy.deepcopy(r['beforeTree']),m_text=r['target'])
    for r in layout['changes']:
        pid=r['pathId'];assert canonical(read_tree(objects[pid],g))==r['beforeTree'];expected[pid]=r['afterTree']
    assert len(expected)==39
    for pid,tree in expected.items():
        o=objects[pid]
        if o.type.name=='MonoBehaviour':
            script=o.parse_monobehaviour_head().m_Script.deref().read();fullname=(script.m_Namespace+'.' if script.m_Namespace else '')+script.m_ClassName;assert fullname=='TMPro.TextMeshProUGUI';o.save_typetree(tree,nodes=g.cache[('forest-header-aligned:'+script.m_AssemblyName,fullname)])
        else:assert o.type.name=='RectTransform';o.save_typetree(tree)
    output.mkdir(parents=True);(output/c['resource']).write_bytes(env.file.save());target=sha(output/c['resource']);back=UnityPy.load(str(output/c['resource']));back.path=str(source);after=back.file.objects
    assert raw.keys()==after.keys() and {pid for pid in raw if raw[pid]!=after[pid].get_raw_data()}==set(expected)
    assert {pid:canonical(read_tree(after[pid],g)) for pid in expected}==expected
    for pid in expected:after[pid].set_raw_data(raw[pid])
    assert back.file.save()==(source/c['resource']).read_bytes()
    if fail_after_resource:raise RuntimeError('injected-after-adventure-resource-before-receipt')
    result=dict(status='finite-adventures24-layout15-pass',resource=c['resource'],sourceSha256=c['sourceSha256'],targetSha256=target,targetsSha256=c['targetsSha256'],changedTextFields=24,changedBodyRects=15,changedObjects=39,structuralGuards=len(guards['objects']),inactiveTitleFieldsPreserved=24,allOtherObjectBytesPreserved=True,actualSavedReadback=True,wholeContainerReversalByteExact=True,allNontextFieldsPreservedExcept15ExplicitRectHeights=True,runtimeVisualAccepted=False,sourceGateAccepted=False,wholeGameAccepted=False,commitBoundary='One exclusive native resource then separate receipt; incomplete occupied output retained');(output/'Result.json').write_text(json.dumps(result,indent=2)+'\n');return result

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--source',type=Path,required=True);p.add_argument('--output',type=Path,required=True);p.add_argument('--locale',required=True);a=p.parse_args();print(json.dumps(apply(a.source,a.output,locale=a.locale)))
