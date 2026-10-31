"""Read both actual haiku resource occurrences and all six template seed bindings.

No resources are modified and no reachability, rendering, or native pass is inferred.
"""
import argparse
import importlib.util
import json
from pathlib import Path
import re
import sys


def sha(data):
    import hashlib
    return hashlib.sha256(data).hexdigest()


def need(ok,reason):
    if not ok:
        raise ValueError(reason)


def encode(d):
    return (json.dumps(d,ensure_ascii=False,sort_keys=True,indent=2)+'\n').encode()


def selector(ident):
    m=re.fullmatch(r'([^:!]+)(?:!/([^:!/]+))?:(-?[0-9]+)(?:/(.*))?',ident)
    need(m is not None,'exact-selector:'+ident)
    asset,member,pid,pointer=m.groups();return asset,member,int(pid),pointer


def run(root,profile_path,output):
    config=json.loads(profile_path.read_bytes());need(not output.exists(),'fresh-output')
    pins={}
    def read(pin):
        p=(root/pin['path']).resolve();need(p.is_relative_to(root),'project-path')
        b=p.read_bytes();need(sha(b)==pin['sha256'],'pin:'+pin['path']);pins[pin['path']]=pin['sha256'];return b
    need(sys.version==config['python'] and sha(Path(sys.executable).read_bytes())==config['pythonExecutableSha256'],'pinned-python')
    engine_manifest=json.loads(read(config['engineManifest']));engine=(root/config['engineManifest']['path']).parent
    for name,digest in engine_manifest['files'].items():
        p=(engine/name).resolve();need(p.is_relative_to(engine) and sha(p.read_bytes())==digest,'engine-closure:'+name)
    sys.path[:0]=[str(engine/'vendor'),str(engine/'engine')]
    import UnityPy
    import extract_assets as ex
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    generator=TypeTreeGenerator('2020.3.24f1');generator.load_local_dll_folder(str(engine/'source/Managed'))
    mapping=json.loads(read(config['mapping']))
    candidate=(root/config['candidateManifest']['path']).parent;manifest=json.loads(read(config['candidateManifest']))
    need(manifest['locale']==mapping['locale']==config['locale'],'explicit-locale')
    assembly=candidate/'Managed/Assembly-CSharp.dll'
    need(sha(assembly.read_bytes())==manifest['outputs']['Managed/Assembly-CSharp.dll']['sha256'],'actual-delivered-dll')
    inventory=[json.loads(s) for s in read(config['inventory']).splitlines() if s]
    seeds=[r for r in inventory if r.get('source')=='line of a haiku' and '/HaikuStuff/HaikuLine' in r.get('hierarchy','')]
    need(len(seeds)==6,'six-seeds')
    contexts={r['id']:r for r in [json.loads(s) for s in read(config['directContext']).splitlines() if s] if r['id'] in {s['id'] for s in seeds}}
    resources={selector(i)[0] for c in mapping['choices'] for i in c['occurrences']}|{selector(s['id'])[0] for s in seeds}
    envs={};cache={}
    def tree(env,member,pid):
        matches=[f for f in env.assets if f.name==member];need(len(matches)==1,'member:'+member)
        obj=matches[0].objects[pid]
        key=(id(env),member,pid)
        if key not in cache:cache[key]=ex.read_tree(obj,generator)
        return obj,cache[key]
    for role in ('source','target'):
        for asset in resources:
            pin=config['sourceResources'][asset] if role=='source' else dict(path=str((candidate/asset).relative_to(root)),sha256=manifest['outputs'][asset]['sha256'])
            read(pin);env=UnityPy.load(str(root/pin['path']));env.path=str(engine/'source');envs[role,asset]=env
    options=[]
    for c in mapping['choices']:
        occurrences=[]
        for ident in c['occurrences']:
            asset,member,pid,pointer=selector(ident);member=member or asset
            observations={}
            for role in ('source','target'):
                obj,t=tree(envs[role,asset],member,pid);v=t
                for part in pointer.split('/'):
                    v=v[int(part)] if isinstance(v,list) else v[part]
                need(v==c['source' if role=='source' else 'target'],'actual-choice-wording:'+ident)
                parts=pointer.split('/');conv=t['conversations'][int(parts[1])];node=conv['dialogueEntries'][int(parts[3])]
                need(conv['id']==303 and node['id']==int(c['id'].split(':')[2]),'stable-choice-identity')
                # Compare every non-localized property of the selected choice itself.
                control={k:v for k,v in node.items() if k!='fields'}
                fields={f['title']:f['value'] for f in node['fields']}
                need(fields['Menu Text']=='','source-selects-dialogue-text')
                if role=='source':
                    source_control=control
                else:need(control==source_control,'choice-control-preservation')
                need(node['outgoingLinks']==[c['destination']],'exact-choice-successor')
                observations[role]=dict(value=v,utf8Sha256=sha(v.encode()),controlSha256=sha(encode(control)))
            occurrences.append(dict(id=ident,readback=observations))
        options.append(dict(id=c['id'],slot=c['slot'],source=c['source'],target=c['target'],occurrences=occurrences))
    seed_rows=[]
    for seed in seeds:
        ident=seed['id'];asset,member,pid,field=selector(ident);member=member or asset
        readbacks={}
        for role in ('source','target'):
            env=envs[role,asset];obj,t=tree(env,member,pid)
            need(t[field]==seed['source'],'seed-preserved:'+ident)
            context=contexts[ident];slot=int(context['hierarchy'][-1])
            line_go=int(context['ancestors'][0]['object'].rsplit(':',1)[1])
            owner_go=int(next(a for a in context['ancestors'] if a['name']=='ResponseOptionsUI')['object'].rsplit(':',1)[1])
            _,go=tree(env,member,owner_go);owners=[]
            for component in go['m_Component']:
                ptr=component.get('component',component)
                _,ct=tree(env,member,ptr['m_PathID'])
                if all('haikuLine'+str(s) in ct for s in (1,2,3)):
                    owners.append((ptr['m_PathID'],ct))
            need(len(owners)==1,'one-response-options-owner:'+ident);owner_pid,owner=owners[0]
            line_ptr=owner['haikuLine'+str(slot)];need(line_ptr['m_FileID']==0,'local-line-component')
            _,line=tree(env,member,line_ptr['m_PathID'])
            need(line['m_GameObject']['m_PathID']==line_go and t['m_GameObject']['m_PathID']==line_go,'setter-targets-seed-gameobject')
            _,line_gameobject=tree(env,member,line_go)
            candidates=[]
            for cp in line_gameobject['m_Component']:
                ptr=cp.get('component',cp);_,ct=tree(env,member,ptr['m_PathID'])
                if 'm_text' in ct:candidates.append(ptr['m_PathID'])
            need(candidates==[pid],'single-tmp-on-bound-line-object')
            _,bg=tree(env,member,owner['haikuBackground']['m_PathID'])
            ancestry=[]
            for a in context['ancestors']:
                aid=int(a['object'].rsplit(':',1)[1]);_,at=tree(env,member,aid)
                ancestry.append(dict(id=aid,name=at.get('m_Name'),activeSelf=at.get('m_IsActive')))
            readbacks[role]=dict(seed=t[field],seedSha256=sha(t[field].encode()),owner=owner_pid,slot=slot,
                lineCanvasGroup=line_ptr,lineGameObject=line_go,lineAlpha=line['m_Alpha'],backgroundAlpha=bg['m_Alpha'],
                enableHaikuUpdates=owner.get('enableHaikuUpdates'),componentEnabled=t.get('m_Enabled'),activeAncestry=ancestry)
        seed_rows.append(dict(id=ident,hierarchy=seed['hierarchy'],readback=readbacks,notLinguisticCoverage=True,native='not-run'))
    for n,h in pins.items():need(sha((root/n).read_bytes())==h,'input-changed:'+n)
    report=dict(passed=True,locale=config['locale'],actualAssemblySha256=sha(assembly.read_bytes()),options=options,seeds=seed_rows,
        verifiedPins=pins,engineClosureFiles=len(engine_manifest['files']),native='not-run',runtime='not-run',ready=False,
        boundary='Actual two serialized occurrences and six seed-to-controller bindings. Unity getter/renderer/native scheduling and visibility are not executed.')
    output.write_bytes(encode(report))
    return dict(passed=True,options=len(options),occurrences=sum(len(c['occurrences']) for c in options),seeds=len(seed_rows),actualAssemblySha256=report['actualAssemblySha256'])


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--root',type=Path,required=True);p.add_argument('--profile',type=Path,required=True);p.add_argument('--output',type=Path,required=True)
    a=p.parse_args();print(json.dumps(run(a.root.resolve(),a.profile.resolve(),a.output.resolve())))
