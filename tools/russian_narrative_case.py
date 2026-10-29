#!/usr/bin/env python3
"""Apply only the parent-admitted Russian narrative42 native text fields.

The resource is written before receipts; an interrupted occupied output must be
preserved and retried at a fresh path. Native rendering remains unverified.
"""
import argparse
import collections
import copy
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import shutil
import sys

PROJECT=Path('/Users/antonkrutov/Desktop/Forest')
LOCAL=Path(__file__).resolve().parent
FROZEN=(LOCAL/'narrative-snapshot.json').is_file()
ROOT=LOCAL/'inputs' if FROZEN else PROJECT
CONTRACT_NAME='localization/source/narrative42-application-20261029'
BINDING_NAME='localization/source/narrative150-resource-contract-20261029'
ADMISSION_NAME=BINDING_NAME+'.parent-admission.json'
PACKET_NAME='localization/supplemental-ui/20261029-narrative-case150'
CONTRACT=ROOT/CONTRACT_NAME
BINDING=ROOT/BINDING_NAME
PACKET=ROOT/PACKET_NAME
SOURCE_PLAN_SHA='735970800f9a338c6ee1cf8f3dc1cd22950c3104c020f6703e1d78cb5868cf87'
ADMISSION_SHA='583cf956950d5487f9eea430397d223ad6de612387bfa43c3c6bb66e1a40bd64'
EDITORIAL_SHA='5b1275cc8f7e91d0b30aa4edf09c440de8560dcfe30484b451a72cdd2bad0ee1'
TARGET_SHA='7ccd8ed80209210f82574fe4d0b9a78f370c03d12c091ff2e28264f795cf8202'
PRIOR_QA_PRODUCT='ForestRuActual20261029_4343'
NAME='StreamingAssets/aa/StandaloneWindows64/defaultlocalgroup_assets_all_298c5a4d1d1846b1a8d2c7d5da3f319c.bundle'
CAB='CAB-7cd732d37ea0297d073a22a52ce72d28'

def need(ok,reason):
    if not ok:raise ValueError(reason)
def digest(raw):return hashlib.sha256(raw).hexdigest()
def sha(path):
    h=hashlib.sha256()
    with Path(path).open('rb') as f:
        for b in iter(lambda:f.read(1024*1024),b''):h.update(b)
    return h.hexdigest()
def read(path):return json.loads(Path(path).read_bytes())
def rows(path):return [json.loads(l) for l in Path(path).read_text().splitlines()]
def encoded(x):return (json.dumps(x,ensure_ascii=False,sort_keys=True,separators=(',',':'))+'\n').encode()
def emit(path,value):
    with Path(path).open('xb') as f:f.write(encoded(value))
def module(path,name):
    s=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
def pid(ident):return int(ident.rsplit(':',1)[1].split('/')[0])
def bio_dependency():
    return module(LOCAL/'bio-dependency/russian_bio_input_case.py' if FROZEN else PROJECT/'tools/russian_bio_input_case.py','narrative_bio_dependency')
def verify_snapshot():
    if FROZEN:
        for n,h in read(LOCAL/'narrative-snapshot.json')['files'].items():need(sha(LOCAL/n)==h,'snapshot-pin:'+n)

def validate_contract(plan,admission,targets,pages,editorial):
    need(plan['game']==admission['game']==editorial['game']=='The Forest of Love' and plan['version']==admission['version']==editorial['version']=='0.45','supported-game-version')
    need(plan['locale']==admission['locale']==editorial['locale']=='ru','explicit-ru-locale-required')
    need(admission['status']=='bounded-narrative42-source-application-admitted' and admission['boundedSourceRolesAccepted'],'bounded-source-admission')
    need(not any(admission[k] for k in ['sourceGateAccepted','ordinaryTranslationEntryAllowed','wholeGameAccepted']),'global-gates-remain-false')
    need(editorial['status']=='bounded-russian-editorial-accepted' and editorial['targetEditorialAccepted'],'final-editorial-acceptance')
    need((editorial['assignedPages'],editorial['assignedMemberships'],editorial['acceptedWholePageTargets'],editorial['nullSourceHeldPages'])==(25,150,20,5) and editorial['exactFinalDelta']==[] and editorial['objectiveWordingFindings']==0,'complete-final-editorial-coverage')
    rr=plan['rows'];need(len(rr)==len({r['id'] for r in rr})==150,'exact150-source-ids')
    need(len(targets)==len({r['id'] for r in targets})==len(pages)==25,'exact25-target-page-ids')
    need([r['id'] for r in targets]==[r['id'] for r in pages],'ordered-page-id-set')
    groups=[set(admission[k]) for k in ['applicationAllowedIds','protectedInactiveIds','sourceHeldIds']];allowed,protected,held=groups
    need(list(map(len,groups))==[42,78,30] and sum(map(len,groups))==len(set.union(*groups))==150 and set.union(*groups)=={r['id'] for r in rr},'finite42-78-30-partitions')
    need((admission['selectedNativePages'],admission['selectedNativeFields'],admission['protectedInactiveFields'],admission['sourceHeldFields'])==(7,42,78,30),'source-admission-counts')
    byid={r['id']:r for r in rr};seen=[];selected=[]
    for page,t in zip(pages,targets):
        need(page==t,'page-target-contract:'+page['id'])
        need(t['locale']=='ru','page-locale:'+t['id'])
        ids=t['occurrenceIds'];need(len(ids)==len(set(ids))==6,'six-distinct-page-members:'+t['id']);seen+=ids
        need(all(byid[i]['pageId']==t['id'] and byid[i]['acceptedWholePageTarget']==t['target'] and byid[i]['targetUtf8Sha256']==t['targetUtf8Sha256'] and byid[i]['sourceValue']==t['source'] for i in ids),'six-layer-source-target-binding:'+t['id'])
        need(collections.Counter(byid[i]['role'] for i in ids)=={'invisible-layout-provider':1,'visible-face':1,'visible-glow':4},'six-layer-role-accounting:'+t['id'])
        if set(ids)&allowed:
            need(set(ids)<=allowed and t['id'] in admission['selectedPageIds'] and t['target'] is not None and not t['holdPredicates'],'whole-admitted-page:'+t['id']);selected.append(t)
            need(all(i.startswith(NAME+'!/'+CAB+':') and re.fullmatch(r'.+:-?\d+/m_text',i) for i in ids),'addressable-m-text-only')
            need(t['reuseRelation']['selectionEvidence']['bodySha256'] and t['producerContext']['staticNativeWording'],'actual-selection-evidence:'+t['id'])
        elif set(ids)&protected:need(set(ids)<=protected and t['family']=='MouseOrgyMovie','protected-inactive-page:'+t['id'])
        else:need(set(ids)<=held and t['target'] is None,'source-held-null-page:'+t['id'])
        if t['target'] is not None:need(isinstance(t['target'],str) and bool(t['target'].strip()) and '\0' not in t['target'] and digest(t['target'].encode())==t['targetUtf8Sha256'],'whole-target-hash:'+t['id'])
        else:need(t['targetUtf8Sha256'] is None,'null-target-hash:'+t['id'])
    need(len(seen)==len(set(seen))==150,'complete150-page-memberships')
    need(sorted(t['id'] for t in selected)==admission['selectedPageIds'] and collections.Counter(t['family'] for t in selected)=={'BotbMabelSummary':3,'MaverickRascalShopStory':3,'RascalSoloBearStory':1},'exact-selected-seven-pages')
    for r in rr:need(r['candidateValue']==r['sourceValue'] and not r['targetApplied'],'source-exact-before:'+r['id'])
    return dict(plan,allowedIds=sorted(allowed),protectedIds=sorted(protected),heldIds=sorted(held),selectedPageIds=admission['selectedPageIds'])

def load_inputs(*,locale):
    need(locale=='ru','explicit-ru-locale-required');verify_snapshot()
    need(sha(CONTRACT/'source-plan.json')==SOURCE_PLAN_SHA,'source-plan-pin');plan=read(CONTRACT/'source-plan.json')
    for n,h in plan['producerPins'].items():need(sha(ROOT/n)==h,'source-producer-pin:'+n)
    need(sha(ROOT/ADMISSION_NAME)==ADMISSION_SHA==plan['admissionSha256'],'source-admission-pin')
    need(sha(PACKET/'ru.acceptance.json')==EDITORIAL_SHA,'editorial-receipt-pin')
    a=read(ROOT/ADMISSION_NAME);e=read(PACKET/'ru.acceptance.json')
    need(e['targetSha256']==a['targetSha256']==TARGET_SHA==sha(PACKET/'ru.prepared.jsonl'),'accepted-target-pin')
    need(plan['candidateBuildSha256']==a['candidateBuildSha256']=='9880fdca75fac8ecffc77f749898708f72c16ca8cbc447e0f961ff1ec75d52b6','accepted-prior-candidate-build')
    need(e['sourceSha256']==a['sourcePacketSha256'],'source-editorial-version-binding')
    return validate_contract(plan,a,rows(PACKET/'ru.prepared.jsonl'),rows(BINDING/'pages25.jsonl'),e)

def qa_identity(raw,expected):
    import UnityPy
    env=UnityPy.load(raw);obs={o.path_id:o for o in env.objects};need(1 in obs and obs[1].type.name=='PlayerSettings','qa-player-settings-object')
    t=obs[1].read_typetree();product=t['productName'];need(isinstance(product,str) and re.fullmatch(r'ForestRuActual[0-9]{8}_[0-9]{2,}',product),'qa-product-name-pattern');need(t['companyName']=='VNRevivalQA','qa-company-name')
    t['productName']=PRIOR_QA_PRODUCT;obs[1].save_typetree(t);need(digest(env.file.save())==expected,'qa-product-only-whole-container-reversal')
    return dict(productName=product,acceptedPriorProductName=PRIOR_QA_PRODUCT,wholeContainerReversalSha256=expected,allowedField='PlayerSettings:1/productName')

def verify_prior(source,plan):
    source=Path(source);bio=bio_dependency();c=bio.normal_contract();admission=[];variant=False
    for n,h in plan['priorFiles'].items():
        raw=(source/n).read_bytes();actual=digest(raw);record=dict(file=n,beforeSha256=actual,acceptedSha256=h,byteExact=actual==h)
        if n in c['helpers']:
            reference=(bio.NORMAL/c['helpers'][n]['reference']).read_bytes();identity,regions=bio.helper_identity(raw);old,oldregions=bio.helper_identity(reference)
            need(identity==old and regions==oldregions,'supported-prior-helper-image:'+n);record.update(nonvolatileImageSha256=identity,volatileRegions=regions);variant|=actual!=h
        elif n=='globalgamemanagers' and actual!=h:record['qaIdentityAdmission']=qa_identity(raw,h)
        else:need(actual==h,'supported-prior-file:'+n)
        admission.append(record)
    if variant:
        recipe=source.parent.parent
        for n,h in c['recipePins'].items():need(sha(recipe/n)==h,'normal-recipe-pin:'+n)
        inv=read(recipe/'inventory-layout-build.json');helper=inv.pop('helperSha256');need(inv==c['inventoryBuildReceipt'],'normal-inventory-build-fingerprint');need(helper==sha(source/'Managed/VNRevivalInventoryLayout.dll'),'normal-inventory-output-binding')
        need(read(recipe/'quest-family-inputs.json')==c['questInputs'],'normal-quest-build-fingerprint');quest=read(recipe/'quest-code-readback.json');need(quest['sourceSha256']==c['questSourceAssembly'],'normal-quest-source-assembly');need(quest['layoutAssemblySha256']==sha(source/'Managed/VNRevivalQuestLayout.dll'),'normal-quest-output-binding')
    for n,h in plan['managedParserPins'].items():
        if n not in {Path(p).name for p in c['helpers']}:need(sha(source/'Managed'/n)==h,'managed-parser-pin:'+n)
    for n,h in plan['externalStreams'].items():need(sha(source/n)==h,'supported-external-stream:'+n)
    return dict(files=admission,normalProducerEvidenceRequired=variant,externalStreams=plan['externalStreams'],boundary='Exact post-Pause434; only v2 parsed helper timestamp/MVID variation with producer proof and one-field QA productName whole-container reversal are admitted.')

def validate_before(trees,plan):
    need(set(trees)=={r['id'] for r in plan['rows']},'before150-selector-set')
    for r in plan['rows']:
        t=trees[r['id']];need(t['m_text']==r['candidateValue'],'field-before:'+r['id']);need({k:v for k,v in t.items() if k!='m_text'}==r['candidateNontext'],'field-before-nontext:'+r['id'])
def validate_fields(before,after,plan):
    validate_before(before,plan);need(set(after)==set(before),'after150-selector-set');allowed=set(plan['allowedIds']);changed=set()
    for r in plan['rows']:
        i=r['id'];target=r['acceptedWholePageTarget'] if i in allowed else r['candidateValue'];need(after[i]['m_text']==target,'field-after:'+i)
        need({k:v for k,v in after[i].items() if k!='m_text'}==r['candidateNontext'],'field-nontext-protection:'+i)
        if after[i]!=before[i]:changed.add(i)
    need(changed==allowed,'exact42-field-changes')
    groups=collections.defaultdict(list)
    for r in plan['rows']:groups[r['pageId']].append(r['id'])
    for p,ids in groups.items():need(len(ids)==6 and len({after[i]['m_text'] for i in ids})==1,'six-layer-page-consistency:'+p)
    return changed

def open_resources(source,plan):
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    ex=module(ROOT/'tools/extract_assets.py','narrative_extract');g=TypeTreeGenerator('2020.3.24f1');g.load_local_dll_folder(str(source/'Managed'));envs={};assets={}
    for r in plan['rows']:
        asset=r['id'].rsplit(':',1)[0];container=asset.split('!/',1)[0]
        if container not in envs:
            env=UnityPy.load(str(source/container));envs[container]=env
            def add(f):
                if hasattr(f,'objects'):assets[container+'!/'+f.name if '!/' in asset else container]=f
                elif hasattr(f,'files'):
                    for c in f.files.values():add(c)
            for f in env.files.values():add(f)
    def obj(ident):return assets[ident.rsplit(':',1)[0]].objects[pid(ident)]
    def trees():return {r['id']:ex.canonical(ex.read_tree(obj(r['id']),g)) for r in plan['rows']}
    return envs,assets,obj,trees,ex,g

def save_tree(obj,tree,generator):
    s=obj.parse_monobehaviour_head().m_Script.deref().read();name=(s.m_Namespace+'.' if s.m_Namespace else '')+s.m_ClassName
    obj.save_typetree(tree,nodes=generator.cache.get(('forest-header-aligned:'+s.m_AssemblyName,name)))

def apply(source,output,*,locale,plan=None,fail_after=None):
    accepted=load_inputs(locale=locale);need(plan is None or plan==accepted,'accepted-application-version');plan=accepted
    source=Path(source);output=Path(output);need(not output.exists(),'new-output-required');need(PROJECT in output.resolve().parents,'project-owned-output')
    admission=verify_prior(source,plan);envs,assets,obj,trees,ex,g=open_resources(source,plan);before=trees();validate_before(before,plan)
    env=envs[NAME];cab=assets[NAME+'!/'+CAB];raw={i:o.get_raw_data() for i,o in cab.objects.items()};cab_before=cab.save();need(cab_before==cab.reader.bytes,'original-serialized-cab-noop-exact');noop=env.file.save(packer='original')
    original_other_payloads={n:(f.save() if hasattr(f,'save') else f.bytes) for n,f in env.file.files.items() if n!=CAB}
    after=copy.deepcopy(before)
    for r in plan['rows']:
        if r['id'] in plan['allowedIds']:after[r['id']]['m_text']=r['acceptedWholePageTarget'];save_tree(obj(r['id']),after[r['id']],g)
    validate_fields(before,after,plan);data=env.file.save(packer='original')
    import UnityPy
    reload=UnityPy.load(data)
    def find(f):
        if hasattr(f,'objects') and f.name==CAB:return f
        if hasattr(f,'files'):
            for child in f.files.values():
                result=find(child)
                if result:return result
    recab=find(reload.file);need(recab is not None,'serialized-cab-present');reobs=recab.objects
    actual=copy.deepcopy(before)
    for r in plan['rows']:
        if r['id'].startswith(NAME+'!/'):actual[r['id']]=ex.canonical(ex.read_tree(reobs[pid(r['id'])],g))
    validate_fields(before,actual,plan);need(actual==after,'actual-saved150-readback')
    actualraw={i:o.get_raw_data() for i,o in reobs.items()};selected={pid(i) for i in plan['allowedIds']}
    need(raw.keys()==actualraw.keys() and {i for i in raw if raw[i]!=actualraw[i]}==selected,'whole-cab-object-changed-set')
    # Compare every unselected bundle payload against its original bytes.
    need(set(env.file.files)==set(reload.file.files),'whole-bundle-payload-set')
    actual_other_payloads={n:(f.save() if hasattr(f,'save') else f.bytes) for n,f in reload.file.files.items() if n!=CAB}
    need(original_other_payloads==actual_other_payloads,'other-whole-bundle-payloads-preserved')
    for i in selected:reobs[i].set_raw_data(raw[i])
    need(recab.save()==cab_before,'whole-serialized-cab-reversal');reversed_bundle=reload.file.save(packer='original');need(reversed_bundle==noop,'whole-bundle-reversal-to-noop')
    exact=reversed_bundle==(source/NAME).read_bytes()
    ledger=[dict(pathId=i,type=cab.objects[i].type.name,beforeSha256=digest(raw[i]),afterSha256=digest(actualraw[i]),changed=i in selected) for i in sorted(raw)]
    # Reuse unchanged pinned resources/corpus-bound coverage; no invented native pass.
    coverage=rows(BINDING/'font-coverage120.jsonl');need(len(coverage)==120,'reused120-resource-coverage')
    output.mkdir(parents=True);(output/NAME).parent.mkdir(parents=True,exist_ok=True)
    with (output/NAME).open('xb') as f:f.write(data)
    if fail_after=='resource':raise RuntimeError('injected-after-resource-before-receipts')
    disk=UnityPy.load(str(output/NAME));diskcab=find(disk.file);need({i:o.get_raw_data() for i,o in diskcab.objects.items()}==actualraw,'delivered-file-raw-readback')
    for n,h in {r['file']:r['beforeSha256'] for r in admission['files']}.items():need(sha(source/n)==h,'prior-source-unchanged:'+n)
    for n,h in plan['externalStreams'].items():need(sha(source/n)==h,'external-stream-unchanged:'+n)
    emit(output/'object-ledger.json',ledger);emit(output/'prior-admission.json',admission)
    emit(output/'field-readback.json',[dict(id=r['id'],pageId=r['pageId'],before=r['candidateValue'],after=actual[r['id']]['m_text'],applied=r['id'] in plan['allowedIds']) for r in plan['rows']])
    result=dict(status='finite42-private-application-pass',game='The Forest of Love',version='0.45',locale='ru',assigned=150,appliedStaticFields=42,selectedWholePages=7,protectedInactiveFields=78,sourceHeldFields=30,changedObjects=42,objects=len(raw),textureObjectsPreserved=sum(o.type.name=='Texture2D' for o in cab.objects.values()),allOtherRawObjectsPreserved=True,allNontextFieldsPreserved=True,allManagedBytesPreserved=True,allOtherBundlePayloadsPreserved=True,wholeSerializedCABReversedByteExact=True,wholeBundleReversalToNoopByteExact=True,wholeBundleReversedByteExact=exact,noOpBundleEqualsSource=noop==(source/NAME).read_bytes(),sourceBundleSha256=sha(source/NAME),noOpBundleSha256=digest(noop),sourceSerializedCABSha256=digest(cab_before),bundleCompression='original-flags',sourceBundleFlags=int(env.file.dataflags),savedBundleFlags=int(disk.file.dataflags),files={NAME:digest(data)},sourcePlanSha256=SOURCE_PLAN_SHA,editorialReceiptSha256=EDITORIAL_SHA,targetSha256=TARGET_SHA,targetWordingChanged=0,actualGameRuntime='not-run',ordinaryTranslationEntryAllowed=False,sourceGateAccepted=False,wholeGameAccepted=False,commitBoundary='One resource then independent receipts. Failure leaves partial output without Result; occupied directory rejects retry. Use a new output path; no multi-file rollback.')
    emit(output/'Result.json',result);return result

def snapshot(out,*,locale):
    plan=load_inputs(locale=locale);dest=Path(out)/'narrative';need(not dest.exists(),'new-snapshot-required');pins=dict(plan['producerPins']);pins[CONTRACT_NAME+'/source-plan.json']=SOURCE_PLAN_SHA
    dest.mkdir(parents=True);shutil.copy2(Path(__file__),dest/'russian_narrative_case.py')
    for n,h in pins.items():
        p=dest/'inputs'/n;p.parent.mkdir(parents=True,exist_ok=True);need(sha(ROOT/n)==h,'snapshot-input:'+n);shutil.copy2(ROOT/n,p)
    bio=dest/'bio-dependency';bio.mkdir();dependency=bio_dependency();shutil.copy2(Path(dependency.__file__),bio/'russian_bio_input_case.py');shutil.copytree(dependency.NORMAL,bio/'normal-build-contract',ignore=shutil.ignore_patterns('__pycache__'));emit(bio/'bio-input-snapshot.json',{'files':{},'scope':'Only helper_identity and normal_contract; complete dependency pinned by outer snapshot.'})
    shutil.copytree(sys.base_prefix,dest/'runtime/python',symlinks=False,ignore=shutil.ignore_patterns('__pycache__'))
    if not FROZEN:
        import site
        packages=[Path(p) for p in site.getsitepackages() if Path(p).is_dir() and not Path(p).is_relative_to(Path(sys.base_prefix))];need(len(packages)==1,'single-pinned-package-tree');shutil.copytree(packages[0],dest/'runtime/python/lib/python3.14/site-packages',dirs_exist_ok=True,symlinks=False,ignore=shutil.ignore_patterns('__pycache__'))
    emit(dest/'narrative-snapshot.json',dict(files={str(p.relative_to(dest)):sha(p) for p in sorted(dest.rglob('*')) if p.is_file()},pythonVersion=sys.version,completeRuntime='CPython/stdlib/native libraries/full active site-packages and type generator; macOS system libraries remain OS dependencies',commitBoundary='Independent files; final manifest marks complete snapshot'));return dest

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--locale',required=True);s=p.add_subparsers(dest='command',required=True);s.add_parser('preflight');a=s.add_parser('snapshot');a.add_argument('--output',type=Path,required=True);a=s.add_parser('apply');a.add_argument('--source',type=Path,required=True);a.add_argument('--output',type=Path,required=True);a.add_argument('--fail-after',choices=['resource']);args=p.parse_args()
    if args.command=='preflight':print(json.dumps(dict(status='accepted-preflight-pass',assigned=len(load_inputs(locale=args.locale)['rows']))))
    elif args.command=='snapshot':print(snapshot(args.output,locale=args.locale))
    else:print(json.dumps(apply(args.source,args.output,locale=args.locale,fail_after=args.fail_after)))
if __name__=='__main__':main()
