"""Read existing baseline/resource evidence; no judgments, builds or model calls."""
import json
from pathlib import Path


def baseline(ev, policy):
    binding=policy.get('ownerBaseline')
    if not binding:return None,{}
    owner=ev.json(binding)
    if not (owner.get('authority')=='owner' and owner.get('accepted') is True and owner.get('locale')=='ru'
            and owner.get('sharedMechanismReuseAllowed') is True and owner.get('targetLocaleAcceptanceGranted') is False):
        raise ValueError('Invalid Russian owner acceptance boundary')
    artifact=ev.json(owner['artifact']['path'],owner['artifact']['sha256'])
    ev.read(owner['sourceManifest']['path'],owner['sourceManifest']['sha256'])
    if artifact.get('candidate')!=owner['build']:raise ValueError('Russian accepted build identity changed')
    build=ev.json(owner['build']+'/build.json')
    if build['sourceManifestSha256']!=owner['sourceManifest']['sha256']:
        raise ValueError('Russian accepted build source version differs')
    mask_path=policy['preservationManifest']
    expected=build['overlay']['overlayAndGuardHashes'][mask_path]
    masks=ev.json(mask_path,expected)
    preserved={r['id']:r['sourceSha256'] for r in masks['records'] if r.get('mode')=='whole-field'}
    if len(preserved)!=sum(r.get('mode')=='whole-field' for r in masks['records']):
        raise ValueError('Duplicate accepted baseline preservation ID')
    return owner,preserved


def _bound_json(ev, folder, manifest, name):
    digest=manifest['files'][name]
    if isinstance(digest,dict):digest=digest['sha256']
    return ev.json(folder/name,digest)


def resources(ev, policy, row):
    """Count exact reviewed versions present in saved candidates, not final QA.

    Union credit describes materialized units; it does not assert that separate
    candidates form one complete package. Both physical dialogue copies must exist
    together in a candidate plan. Changed bytes or missing bindings earn no credit.
    """
    from locale_progress import version
    locale=row['locale'];refs=row.pop('_resourceRefs',{})
    candidates=list(policy.get('resourceCandidates',{}).get(locale,[]))
    candidates += [dict(path=name,sha256=digest) for name,digest in refs.items()
                   if Path(name).name=='manifest.json']
    accepted=row.pop('_acceptedVersions',{});bound=set();proofs=[];visited=set()

    def saved_outputs(path, document):
        outputs=document['outputs']
        if not outputs:raise ValueError('Empty resource output manifest')
        if not any(Path(name).suffix not in {'.json','.jsonl','.md','.txt'} for name in outputs):
            raise ValueError('No saved game resources')
        for name,pin in outputs.items():
            target=(path.parent/name).resolve()
            if not target.is_relative_to(path.parent.resolve()):raise ValueError('Resource output escapes candidate')
            ev.pin_file(target,pin['sha256'])
            if not pin['bytes'] or target.stat().st_size!=pin['bytes']:raise ValueError('Resource output size differs')

    def serialized(path, document, recipe_pin=None):
        if document.get('kind')!='composed-sparse-target-resource-candidate' or document.get('locale')!=locale:return set()
        saved_outputs(path,document)
        digest=document['frozenRecipeSha256']
        if recipe_pin is None:
            matches=[(name,h) for name,h in refs.items() if h==digest and Path(name).name=='manifest.json']
            if not matches:return set()
            recipe_pin=dict(path=matches[0][0],sha256=digest)
        if recipe_pin['sha256']!=digest:raise ValueError('Resource recipe version differs')
        recipe_path=ev.path(recipe_pin['path']);recipe=ev.json(recipe_path,digest)
        config=_bound_json(ev,recipe_path.parent,recipe,'config.json')
        plan=_bound_json(ev,recipe_path.parent,recipe,config['locales'][locale]['plan'])
        if plan.get('locale')!=locale:raise ValueError('Resource plan locale differs')
        occurrences={}
        for edit in plan['edits']:
            key=version(edit)
            if key and accepted.get(edit['id'])==key and edit['asset'] in document['outputs']:
                occurrences.setdefault(key,set()).add((edit['asset'],edit['pathId'],edit.get('pointer',edit['id'])))
        # These source rows have two physical bindings in the fixed inventory.
        return {key for key,positions in occurrences.items() if len(positions)>=(2 if key[0].startswith('ds:') else 1)}

    for pin in candidates:
        if (pin['path'],pin['sha256']) in visited:continue
        visited.add((pin['path'],pin['sha256']))
        try:
            path=ev.path(pin['path']);document=ev.json(path,pin['sha256'])
            kind=document.get('kind') if isinstance(document,dict) else None
            if kind=='composed-sparse-target-resource-candidate':
                found=serialized(path,document)
            elif kind=='locale-owned-static-resource-candidate' and document.get('locale')==locale:
                saved_outputs(path,document)
                profile_pin=document['profile'];profile=ev.json(profile_pin['path'],profile_pin['sha256'])
                if profile.get('kind')!='locale-owned-saved-candidate' or profile.get('locale')!=locale:
                    raise ValueError('Saved candidate profile locale/type differs')
                source_pin=profile['serializedManifest'];source_path=ev.path(source_pin['path'])
                source=ev.json(source_path,source_pin['sha256'])
                for name,binding in source['outputs'].items():
                    output_name='evidence/serialized-readback.json' if name=='readback.json' else name
                    if document['outputs'].get(output_name)!=binding:
                        raise ValueError('Candidate/profile saved resource differs')
                check=ev.json(profile['serializedCheck']['path'],profile['serializedCheck']['sha256'])
                if not (check.get('passed') is True and check.get('locale')==locale
                        and check.get('allPriorAndUnselectedObjectsExact') is True):
                    raise ValueError('Missing saved resource readback')
                found=serialized(source_path,source,profile['recipe'])
                managed=ev.json(profile['managedReadback']['path'],profile['managedReadback']['sha256'])
                request=ev.json(profile['managedRequest']['path'],profile['managedRequest']['sha256'])
                assembly=profile['assembly'];helper=profile['displayHelper']
                ev.pin_file(assembly['path'],assembly['sha256']);ev.pin_file(helper['path'],helper['sha256'])
                if (document['outputs']['Managed/Assembly-CSharp.dll']['sha256']!=assembly['sha256']
                        or document['outputs']['Managed/VNRevivalLocaleDisplay.dll']['sha256']!=helper['sha256']):
                    raise ValueError('Candidate/profile managed output differs')
                if not (managed.get('passed') is True and managed.get('locale')==request.get('locale')==locale
                        and managed.get('outputSha256')==assembly['sha256'] and managed.get('helperSha256')==helper['sha256']
                        and managed.get('completeTreeReadback') is True
                        and managed.get('completeOriginalSemanticTreeRestored') is True):
                    raise ValueError('Missing actual managed readback')
                found.update(key for item in request['rows'] if (key:=version(item)) and accepted.get(item['id'])==key)
            else:continue
            if found:
                bound.update(found);proofs.append(pin)
        except (OSError,ValueError,KeyError,TypeError) as error:
            ev.errors.append(f'{locale}: resource evidence {pin["path"]}: {error}')
    for family in row['families']:
        ids=row['_familyIds'][family['id']]
        family['resourceBound']=sum(key[0] in ids for key in bound) if ids is not None else 0
    row.pop('_familyIds',None)
    row['resources']=dict(materializedReviewedUnits=len(bound),savedCandidateProofs=proofs,
        completePackageAccepted=False,nativeAccepted=False,
        boundary='Matching reviewed/preserved units in saved candidates; not complete integration, fonts, native or release acceptance.')
    return bool(bound)
