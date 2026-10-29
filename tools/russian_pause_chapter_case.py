#!/usr/bin/env python3
"""Apply the finite, independently accepted Russian Pause/Chapter434 captions.

One resource is written before receipts. An interrupted output is deliberately
preserved and occupied output directories reject retries; use a new directory.
No game code, fonts, rectangles, textures or source/target wording is edited.
"""
import argparse
import collections
import copy
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import re
import shutil
import sys
import unicodedata

PROJECT = Path('/Users/antonkrutov/Desktop/Forest')
LOCAL = Path(__file__).resolve().parent
FROZEN = (LOCAL/'pause-chapter-snapshot.json').is_file()
ROOT = LOCAL/'inputs' if FROZEN else PROJECT
CONTRACT_NAME = 'localization/source/pause-chapter434-application-20261029'
BINDING_NAME = 'localization/source/pause-chapter576-binding-contract-20261029'
PACKET_NAME = 'localization/supplemental-ui/20261029-pause-chapter-case576/revision-02'
CONTRACT = ROOT/CONTRACT_NAME
BINDING = ROOT/BINDING_NAME
PACKET = ROOT/PACKET_NAME
SOURCE_PLAN_SHA = 'f3abea9125597913f34012965c1094348cb598f5f13b81d6acc6911c15b6ed45'
# Exact parent-adopted final independent review; no target generation occurs here.
EDITORIAL_SHA = '76eb0e9ade75d5a9b4781694deacfe8f88dfddb3ef8af651921e6b32306ae6d0'
TARGET_SHA = 'e81cd112f36264b064b215edc36b22108efb10836b31391d3280ab678af6c2de'
PRIOR_QA_PRODUCT = 'ForestRuActual20261029_1852'
NAME = 'sharedassets2.assets'
STATIC = 'static-display-wording-candidate'
RETAINED = 'preserve-accepted-input72'
PROTECTED = {'preserve-keyboard-symbol','preserve-detail-level-symbol','preserve-entered-input-cache'}

def need(ok, reason):
    if not ok: raise ValueError(reason)
def digest(raw): return hashlib.sha256(raw).hexdigest()
def sha(path):
    h=hashlib.sha256()
    with Path(path).open('rb') as f:
        for b in iter(lambda:f.read(1024*1024),b''):h.update(b)
    return h.hexdigest()
def encoded(x): return (json.dumps(x,ensure_ascii=False,sort_keys=True,separators=(',',':'))+'\n').encode()
def treehash(x): return digest(encoded(x).rstrip(b'\n'))
def read(path): return json.loads(Path(path).read_bytes())
def rows(path): return [json.loads(l) for l in Path(path).read_text().splitlines()]
def emit(path, value):
    with Path(path).open('xb') as f:f.write(encoded(value))
def module(path,name):
    spec=importlib.util.spec_from_file_location(name,path);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);return m
def input_path(name):
    return LOCAL/'absolute-inputs'/name.lstrip('/') if FROZEN and name.startswith('/') else Path(name) if name.startswith('/') else ROOT/name
def get(tree,pointer):
    for k in pointer.strip('/').split('/'):tree=tree[int(k)] if isinstance(tree,list) else tree[k]
    return tree
def put(tree,pointer,value):
    ks=pointer.strip('/').split('/')
    for k in ks[:-1]:tree=tree[int(k)] if isinstance(tree,list) else tree[k]
    k=ks[-1];tree[int(k) if isinstance(tree,list) else k]=value
def changes(a,b,p=''):
    if isinstance(a,dict) and isinstance(b,dict) and a.keys()==b.keys():return [z for k in a for z in changes(a[k],b[k],p+'/'+str(k))]
    if isinstance(a,list) and isinstance(b,list) and len(a)==len(b):return [z for i in range(len(a)) for z in changes(a[i],b[i],p+'/'+str(i))]
    return [] if a==b else [p]
def partitions(plan):
    r=plan['rows']
    return {'applicationAllowedIds':[x['id'] for x in r if x['disposition']==STATIC],
            'retainedAcceptedIds':[x['id'] for x in r if x['disposition']==RETAINED],
            'protectedIds':[x['id'] for x in r if x['disposition'] in PROTECTED],
            'applicationHeldIds':[x['id'] for x in r if x['disposition'] not in PROTECTED|{STATIC,RETAINED}]}

def verify_snapshot():
    if FROZEN:
        for n,h in read(LOCAL/'pause-chapter-snapshot.json')['files'].items():need(sha(LOCAL/n)==h,'snapshot-pin:'+n)

def source_inputs(*,locale):
    need(locale=='ru','explicit-ru-locale-required');verify_snapshot()
    need(sha(CONTRACT/'source-plan.json')==SOURCE_PLAN_SHA,'source-plan-pin')
    plan=read(CONTRACT/'source-plan.json')
    for n,h in plan['producerPins'].items():need(sha(input_path(n))==h,'source-producer-pin:'+n)
    matrix=rows(BINDING/'selector-binding-matrix.jsonl')
    need(sha(BINDING/'selector-binding-matrix.jsonl')==plan['sourceMatrixSha256'],'source-matrix-pin')
    need(len(plan['rows'])==len({r['id'] for r in plan['rows']})==576,'exact576-source-ids')
    need(all(all(r[k]==s[k] for k in r) for r,s in zip(plan['rows'],matrix)),'source-plan-matrix-binding')
    a=read(ROOT/(BINDING_NAME+'.parent-acceptance.json'))
    need(a['status']=='bounded-pause-chapter576-role-admission-accepted' and a['locale']==locale and a['boundedSourceRolesAccepted'],'bounded-role-admission')
    need(a['version']==plan['version']=='0.45' and a['game']==plan['game']=='The Forest of Love','supported-game-version')
    need((a['static434'],a['retained12'],a['held37'],a['protected93'])==(434,12,37,93),'role-admission-counts')
    need(a['sourceResultSha256']==sha(BINDING/'Result.json') and a['matrixSha256']==plan['sourceMatrixSha256'],'role-admission-evidence')
    for n,h in a['evidence'].items():need(sha(ROOT/n)==h,'role-admission-evidence-pin:'+n)
    groups=partitions(plan)
    need(all(a[k]==v for k,v in groups.items()),'exact-source-role-allowlists')
    need([len(groups[k]) for k in ['applicationAllowedIds','retainedAcceptedIds','applicationHeldIds','protectedIds']]==[434,12,37,93],'finite-role-accounting')
    need(all(re.fullmatch(r'sharedassets2\.assets:\d+/m_text',i) for i in groups['applicationAllowedIds']),'static-text-pointers-only')
    need(not read(BINDING/'overlap-matrix.json')['titleWKerningOverlap'],'ornamental-overlap-forbidden')
    return plan

def validate_targets(targets,plan,*,locale):
    need(locale=='ru','explicit-ru-locale-required')
    need(len(targets)==len({r['id'] for r in targets})==576,'exact576-target-ids')
    need([r['id'] for r in targets]==[r['id'] for r in plan['rows']],'ordered-target-source-id-set')
    held_labels={r['id'] for r in rows(BINDING/'unlock-movies-six-authored-label-hold.jsonl')}
    nonnull=[]
    for t,r in zip(targets,plan['rows']):
        ident=r['id'];need(t['locale']==locale,'target-locale:'+ident)
        need(all(t[k]==r[k] for k in ['source','sourceValueSha256','currentValue','pointer','className','hierarchy']),'target-source-binding:'+ident)
        need(t['technicalDisposition']==r['disposition'],'target-source-role-binding:'+ident)
        need(t['sourceValueSha256']==digest(json.dumps(r['source'],ensure_ascii=False,sort_keys=True,separators=(',',':')).encode()),'source-value-hash:'+ident)
        target=t['target'];d=r['disposition']
        need(bool(t.get('reuseReference'))==(d==RETAINED),'retained12-overlap-both-directions:'+ident)
        if target is not None:
            nonnull.append(ident);need(isinstance(target,str) and t['targetUtf8Sha256']==digest(target.encode()),'target-text-hash:'+ident)
        else:need(t['targetUtf8Sha256'] is None,'null-target-hash:'+ident)
        if d==STATIC:
            need(isinstance(target,str) and bool(target.strip()) and '\0' not in target and '\\n' not in target,'static-target-required:'+ident)
            tokens=lambda v:re.findall(r'<[^>]*>|\{[^{}]*\}|\[[^\]]*\]',v)
            need(tokens(r['source'])==tokens(target) and r['source'].count('\n')==target.count('\n'),'protected-controls:'+ident)
        elif d==RETAINED:need(target==r['currentValue'],'retained12-exact:'+ident)
        elif ident not in held_labels:need(target is None,'held-or-protected-target-must-be-null:'+ident)
    need(set(nonnull)==set(partitions(plan)['applicationAllowedIds'])|set(partitions(plan)['retainedAcceptedIds'])|held_labels,'nonnull452-is-not-patch434')
    return [dict(r,target=t['target']) for r,t in zip(plan['rows'],targets)]

def load_inputs(*,locale):
    # Check acceptance before source inspection/output/snapshot construction.
    need(locale=='ru','explicit-ru-locale-required')
    need((PACKET/'ru.acceptance.json').is_file(),'final-editorial-acceptance-required')
    need(EDITORIAL_SHA is not None and TARGET_SHA is not None,'final-editorial-pins-not-adopted')
    need(sha(PACKET/'ru.acceptance.json')==EDITORIAL_SHA,'editorial-receipt-pin')
    a=read(PACKET/'ru.acceptance.json')
    need(a['status']=='bounded-russian-editorial-accepted' and a['locale']==locale and a['targetEditorialAccepted'],'final-editorial-acceptance')
    need(a['game']=='The Forest of Love' and a['version']=='0.45','editorial-supported-game-version')
    need((a['assignedOccurrences'],a['independentlyReviewedNonNullFields'],a['separateRussianReadFields'],a['reviewedNullContextFields'],a['applicableStaticFields'],a['retainedAcceptedFields'],a['applicationHeldFields'],a['protectedFields'],a['heldNonNullWordings'])==(576,452,452,124,434,12,37,93,6) and a['exactFinalDelta']==[] and a['objectiveWordingFindings']==0,'complete-final-editorial-coverage')
    need(a['targetFile']=='ru.prepared.jsonl' and a['targetSha256']==TARGET_SHA==sha(PACKET/'ru.prepared.jsonl'),'accepted-target-pin')
    need(a['sourceSha256']==sha(PACKET/'source-context.jsonl'),'accepted-source-context-pin')
    for n,h in a['evidence'].items():need(sha(ROOT/n)==h,'accepted-editorial-evidence-pin:'+n)
    plan=source_inputs(locale=locale);target=rows(PACKET/'ru.prepared.jsonl')
    plan=dict(plan,rows=validate_targets(target,plan,locale=locale),editorialReceiptSha256=EDITORIAL_SHA,targetSha256=TARGET_SHA)
    return plan

def bio_dependency():
    return module(LOCAL/'bio-dependency/russian_bio_input_case.py' if FROZEN else PROJECT/'tools/russian_bio_input_case.py','pause_bio_dependency')

def qa_identity(raw, expected):
    """Admit one QA productName only by reversing the entire pinned container."""
    import UnityPy
    env=UnityPy.load(raw);objects={o.path_id:o for o in env.objects}
    need(1 in objects and objects[1].type.name=='PlayerSettings','qa-player-settings-object')
    settings=objects[1].read_typetree();product=settings['productName']
    need(isinstance(product,str) and re.fullmatch(r'ForestRuActual[0-9]{8}_[0-9]{2,}',product),'qa-product-name-pattern')
    need(settings['companyName']=='VNRevivalQA','qa-company-name')
    settings['productName']=PRIOR_QA_PRODUCT;objects[1].save_typetree(settings)
    need(digest(env.file.save())==expected,'qa-product-only-whole-container-reversal')
    return {'productName':product,'acceptedPriorProductName':PRIOR_QA_PRODUCT,
            'wholeContainerReversalSha256':expected,'allowedField':'PlayerSettings:1/productName'}

def verify_prior(source,plan):
    source=Path(source);c=bio_dependency().normal_contract();bio=bio_dependency();admission=[];variant=False
    for n,h in plan['priorFiles'].items():
        raw=(source/n).read_bytes();actual=digest(raw);record={'file':n,'beforeSha256':actual,'acceptedSha256':h,'byteExact':actual==h}
        if n in c['helpers']:
            reference=ROOT/'localization/source/bio-input-normal-build-repair-20261029'/c['helpers'][n]['reference']
            identity,regions=bio.helper_identity(raw);oldidentity,oldregions=bio.helper_identity(reference.read_bytes())
            need(identity==oldidentity and regions==oldregions,'supported-prior-helper-image:'+n)
            record.update(nonvolatileImageSha256=identity,volatileRegions=regions);variant|=actual!=h
        elif n=='globalgamemanagers' and actual!=h:
            record['qaIdentityAdmission']=qa_identity(raw,h)
        else:need(actual==h,'supported-prior-file:'+n)
        admission.append(record)
    if variant:
        recipe=source.parent.parent
        for n,h in c['recipePins'].items():need(sha(recipe/n)==h,'normal-recipe-pin:'+n)
        inv=read(recipe/'inventory-layout-build.json');helper=inv.pop('helperSha256')
        need(inv==c['inventoryBuildReceipt'],'normal-inventory-build-fingerprint')
        need(helper==sha(source/'Managed/VNRevivalInventoryLayout.dll'),'normal-inventory-output-binding')
        need(read(recipe/'quest-family-inputs.json')==c['questInputs'],'normal-quest-build-fingerprint')
        quest=read(recipe/'quest-code-readback.json')
        need(quest['sourceSha256']==c['questSourceAssembly'],'normal-quest-source-assembly')
        need(quest['layoutAssemblySha256']==sha(source/'Managed/VNRevivalQuestLayout.dll'),'normal-quest-output-binding')
    for n,h in plan['externalStreams'].items():need(sha(source/n)==h,'supported-external-stream:'+n)
    return {'files':admission,'normalProducerEvidenceRequired':variant,'externalStreams':plan['externalStreams'],'boundary':'Exact post-Bio185 resources; parsed helper timestamp/MVID variation requires unchanged v2 producer proof. QA productName alone may vary under the normal identity pattern only after byte-exact whole-container reversal.'}

def save_tree(obj,tree,generator):
    nodes=None
    if obj.type.name=='MonoBehaviour':
        s=obj.parse_monobehaviour_head().m_Script.deref().read();name=(s.m_Namespace+'.' if s.m_Namespace else '')+s.m_ClassName
        nodes=generator.cache.get(('forest-header-aligned:'+s.m_AssemblyName,name))
    obj.save_typetree(tree,nodes=nodes)

def validate_fields(before,after,plan):
    allowed=set(partitions(plan)['applicationAllowedIds']);expected=set()
    for r in plan['rows']:
        i=r['id'];p=r['pointer'];need(get(before[i],p)==r['currentValue'],'field-before:'+i)
        target=r['target'] if i in allowed else r['currentValue']
        need(get(after[i],p)==target,'field-after:'+i)
        need(changes(before[i],after[i])==([p] if target!=r['currentValue'] else []),'field-only-text-change:'+i)
        nontext={k:v for k,v in after[i].items() if k!=p.lstrip('/')}
        need(treehash(nontext)==r['currentNonTextTreeSha256'],'field-nontext-protection:'+i)
        if target!=r['currentValue']:expected.add(i)
    need(expected==allowed,'exact434-physical-field-changes');return expected

def validate_before(trees,plan):
    need(set(trees)=={r['id'] for r in plan['rows']},'before576-selector-set')
    for r in plan['rows']:
        i=r['id'];p=r['pointer'];need(get(trees[i],p)==r['currentValue'],'field-before:'+i)
        nontext={k:v for k,v in trees[i].items() if k!=p.lstrip('/')}
        need(treehash(nontext)==r['currentNonTextTreeSha256'],'field-before-nontext:'+i)

def validate_controllers(trees):
    controls=read(BINDING/'protected-controller-contract.json')['controllers']
    need(len(controls)==522,'controller522-count')
    for c in controls:need(trees[c['id']]==c['currentFields'],'current-controller522-preservation:'+c['id'])
    return len(controls)

def validate_payloads(before,after,selected):
    need(before.keys()==after.keys(),'whole-object-id-set')
    need({i for i in before if before[i]!=after[i]}==selected,'whole-object-changed-set')

def font_requirements(source,plan):
    # Actual serialized role/fallback resources; cmap is static evidence only.
    import UnityPy
    from fontTools.ttLib import TTFont
    env=UnityPy.load(str(source/'resources.assets'));obs={o.path_id:o for o in env.objects}
    ex=module(ROOT/'tools/extract_assets.py','pause_font_extract')
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    g=TypeTreeGenerator('2020.3.24f1');g.load_local_dll_folder(str(source/'Managed'))
    fallback=ex.read_tree(obs[1017],g);native=ex.read_tree(obs[439],g)
    need(fallback['m_SourceFontFile']=={'m_FileID':0,'m_PathID':439},'actual-fallback-source-font439')
    fontdata=bytes(native['m_FontData']);font=TTFont(io.BytesIO(fontdata));cmap=set(font.getBestCmap())
    native_env=UnityPy.load(str(source/'sharedassets0.assets'));native_obj=next(o for o in native_env.objects if o.path_id==369)
    native_data=bytes(ex.read_tree(native_obj,g)['m_FontData']);native_cmap=set(TTFont(io.BytesIO(native_data)).getBestCmap())
    grouped=collections.defaultdict(list)
    for r in plan['rows']:
        # Held/protected values remain exact; authored potential targets are not displayed.
        text=r['target'] if r['disposition']==STATIC else r['currentValue']
        role=r['fontAndLayout'].get('m_fontAsset',r['fontAndLayout'].get('m_FontData',{}).get('m_Font'))
        grouped[json.dumps(role,sort_keys=True)].append((r['id'],text))
    report=[]
    for role,rr in grouped.items():
        sets={form:sorted({ord(ch) for _,t in rr for ch in (t if form=='raw' else unicodedata.normalize(form,t)) if not ch.isspace()}) for form in ['raw','NFC','NFD']}
        # Source sentinels such as sprite markup are reported as stored raw text;
        # actual required glyphs exclude TMP tags, preserving their control syntax.
        actual=sorted({ord(ch) for _,t in rr for ch in re.sub(r'<[^>]*>','',t) if not ch.isspace()})
        ref=json.loads(role);selected_cmap=native_cmap if ref=={'m_FileID':5,'m_PathID':369} else cmap
        unknown=ref not in [{'m_FileID':5,'m_PathID':3323},{'m_FileID':6,'m_PathID':1118},{'m_FileID':5,'m_PathID':369}]
        missing=None if unknown else sorted(set(actual)-selected_cmap)
        report.append({'role':ref,'ids':[i for i,_ in rr],'storedCodepoints':sets,'actualRequiredCodepoints':actual,'missingActualCmap':missing,'missingRawCmap':None if unknown else sorted(set(sets['raw'])-selected_cmap),'missingNFCCmap':None if unknown else sorted(set(sets['NFC'])-selected_cmap),'nativeBuiltInRoleUnknown':unknown})
    # Newly applied static captions use ordinary TMP3323 through existing fallback1017.
    static=set(ord(ch) for r in plan['rows'] if r['disposition']==STATIC for text in [r['target'],unicodedata.normalize('NFC',r['target'])] for ch in re.sub(r'<[^>]*>','',text) if not ch.isspace())
    need(not static-cmap,'static434-actual-required-glyph-coverage')
    return {'roles':report,'fallbackResource':'resources.assets:1017','fallbackSourceFont':'resources.assets:439','nativeHintFont':'sharedassets0.assets:369','fallbackFaceSha256':digest(fontdata),'nativeHintFaceSha256':digest(native_data),'fictionalMapping':'sharedassets0:3324/material3/atlas245 preserved by whole-file pins','rawAndNFCRequired':True,'NFD':'reported; no transform introduced','nativeFit':'not-run','dynamicGeneratedCorpus':'unresolved; outside finite434'}

def apply(source,output,*,locale,plan=None,fail_after=None):
    accepted=load_inputs(locale=locale);need(plan is None or plan==accepted,'accepted-application-version');plan=accepted
    source=Path(source);output=Path(output);need(not output.exists(),'new-output-required');need(PROJECT in output.resolve().parents,'project-owned-output')
    admission=verify_prior(source,plan)
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    ex=module(ROOT/'tools/extract_assets.py','pause_extract');g=TypeTreeGenerator('2020.3.24f1');g.load_local_dll_folder(str(source/'Managed'))
    env=UnityPy.load(str(source/NAME));obs={o.path_id:o for o in env.objects};raw={i:o.get_raw_data() for i,o in obs.items()}
    before={r['id']:ex.canonical(ex.read_tree(obs[int(r['id'].split(':')[1].split('/')[0])],g)) for r in plan['rows']}
    validate_before(before,plan)
    after=copy.deepcopy(before);allowed=set(partitions(plan)['applicationAllowedIds'])
    for r in plan['rows']:
        if r['id'] in allowed:put(after[r['id']],r['pointer'],r['target'])
    validate_fields(before,after,plan)
    controller_ids=[c['id'] for c in read(BINDING/'protected-controller-contract.json')['controllers']]
    validate_controllers({i:ex.canonical(ex.read_tree(obs[int(i.split(':')[1])],g)) for i in controller_ids})
    for r in plan['rows']:
        need(ex.canonical(ex.read_tree(obs[r['rectId']],g))==r['rect'],'rect576-before:'+r['id'])
        if r['id'] in allowed:save_tree(obs[int(r['id'].split(':')[1].split('/')[0])],after[r['id']],g)
    data=env.file.save();reload=UnityPy.load(data);reload.path=str(source);reobs={o.path_id:o for o in reload.objects}
    actual={r['id']:ex.canonical(ex.read_tree(reobs[int(r['id'].split(':')[1].split('/')[0])],g)) for r in plan['rows']}
    validate_fields(before,actual,plan);need(actual==after,'actual-saved576-readback')
    validate_controllers({i:ex.canonical(ex.read_tree(reobs[int(i.split(':')[1])],g)) for i in controller_ids})
    actualraw={i:o.get_raw_data() for i,o in reobs.items()};selected={int(i.split(':')[1].split('/')[0]) for i in allowed}
    validate_payloads(raw,actualraw,selected)
    for r in plan['rows']:need(ex.canonical(ex.read_tree(reobs[r['rectId']],g))==r['rect'],'rect576-after:'+r['id'])
    for pid in selected:reobs[pid].set_raw_data(raw[pid])
    need(reload.file.save()==(source/NAME).read_bytes(),'actual-whole-container-reversal')
    glyphs=font_requirements(source,plan)
    ledger=[{'pathId':i,'type':obs[i].type.name,'beforeSha256':digest(raw[i]),'afterSha256':digest(actualraw[i]),'changed':i in selected} for i in sorted(raw)]
    # All transformations/readbacks pass before the first output write.
    output.mkdir(parents=True)
    with (output/NAME).open('xb') as f:f.write(data)
    if fail_after=='resource':raise RuntimeError('injected-after-resource-before-receipts')
    # Independently reopen the delivered file, not only in-memory saved bytes.
    disk=UnityPy.load(str(output/NAME));disk.path=str(source);diskobs={o.path_id:o for o in disk.objects}
    need({i:o.get_raw_data() for i,o in diskobs.items()}==actualraw,'delivered-file-raw-readback')
    for n,h in {r['file']:r['beforeSha256'] for r in admission['files']}.items():need(sha(source/n)==h,'prior-source-unchanged:'+n)
    for n,h in plan['externalStreams'].items():need(sha(source/n)==h,'external-streams-unchanged:'+n)
    emit(output/'object-ledger.json',ledger);emit(output/'prior-admission.json',admission);emit(output/'font-requirements.json',glyphs)
    emit(output/'field-readback.json',[{'id':r['id'],'before':r['currentValue'],'after':get(actual[r['id']],r['pointer']),'disposition':r['disposition']} for r in plan['rows']])
    result={'status':'finite434-private-application-pass','game':'The Forest of Love','version':'0.45','locale':'ru','assigned':576,'appliedStaticFields':434,'retainedAcceptedFields':12,'applicationHeldFields':37,'protectedFields':93,'controllersPreserved':522,'changedObjects':434,'objects':len(raw),'textureObjectsPreserved':sum(o.type.name=='Texture2D' for o in obs.values()),'externalStreamsPreserved':len(plan['externalStreams']),'allOtherRawObjectsPreserved':True,'allNontextFieldsPreserved':True,'allManagedBytesPreserved':True,'wholeContainerReversedByteExact':True,'files':{NAME:digest(data)},'sourcePlanSha256':SOURCE_PLAN_SHA,'editorialReceiptSha256':EDITORIAL_SHA,'targetSha256':TARGET_SHA,'targetWordingChanged':0,'actualGameRuntime':'not-run','ordinaryTranslationEntryAllowed':False,'sourceGateAccepted':False,'wholeGameAccepted':False,'commitBoundary':'One resource then independent receipts. Failure leaves partial output without Result; occupied directory rejects retry. Reconcile and use a new output path; no multi-file rollback.'}
    emit(output/'Result.json',result);return result

def snapshot(out,*,locale):
    plan=load_inputs(locale=locale);dest=Path(out)/'pause-chapter';need(not dest.exists(),'new-snapshot-required')
    pins=dict(plan['producerPins']);pins[CONTRACT_NAME+'/source-plan.json']=SOURCE_PLAN_SHA
    pins[PACKET_NAME+'/ru.acceptance.json']=EDITORIAL_SHA;pins[PACKET_NAME+'/ru.prepared.jsonl']=TARGET_SHA
    a=read(PACKET/'ru.acceptance.json');pins[PACKET_NAME+'/source-context.jsonl']=a['sourceSha256'];pins.update(a['evidence'])
    dest.mkdir(parents=True)
    shutil.copy2(Path(__file__),dest/'russian_pause_chapter_case.py')
    for n,h in pins.items():
        p=dest/'absolute-inputs'/n.lstrip('/') if n.startswith('/') else dest/'inputs'/n
        p.parent.mkdir(parents=True,exist_ok=True);need(sha(input_path(n))==h,'snapshot-input:'+n);shutil.copy2(input_path(n),p)
    # Small isolated dependency supplies the existing parsed helper-identity guard.
    bio=dest/'bio-dependency';bio.mkdir();shutil.copy2(ROOT/'tools/russian_bio_input_case.py',bio/'russian_bio_input_case.py')
    shutil.copytree(ROOT/'localization/source/bio-input-normal-build-repair-20261029',bio/'normal-build-contract',ignore=shutil.ignore_patterns('__pycache__'))
    emit(bio/'bio-input-snapshot.json',{'files':{},'scope':'Only helper_identity/normal_contract are called. Their complete normal manifest/references are copied and covered by outer snapshot.'})
    shutil.copytree(sys.base_prefix,dest/'runtime/python',symlinks=False,ignore=shutil.ignore_patterns('__pycache__'))
    if not FROZEN:
        import site
        packages=[Path(p) for p in site.getsitepackages() if Path(p).is_dir() and not Path(p).is_relative_to(Path(sys.base_prefix))]
        need(len(packages)==1,'single-pinned-package-tree');shutil.copytree(packages[0],dest/'runtime/python/lib/python3.14/site-packages',dirs_exist_ok=True,symlinks=False,ignore=shutil.ignore_patterns('__pycache__'))
    emit(dest/'pause-chapter-snapshot.json',{'files':{str(p.relative_to(dest)):sha(p) for p in sorted(dest.rglob('*')) if p.is_file()},'pythonVersion':sys.version,'completeRuntime':'CPython/stdlib/native libraries/full active site-packages and type generator; macOS system libraries remain OS dependencies','commitBoundary':'Independent files; final manifest marks complete snapshot'})
    return dest

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--locale',required=True);s=p.add_subparsers(dest='command',required=True)
    s.add_parser('preflight');s.add_parser('source-preflight')
    a=s.add_parser('snapshot');a.add_argument('--output',type=Path,required=True)
    a=s.add_parser('apply');a.add_argument('--source',type=Path,required=True);a.add_argument('--output',type=Path,required=True)
    args=p.parse_args()
    if args.command=='source-preflight':print(json.dumps({'status':'source-only;editorial-not-accepted','assigned':len(source_inputs(locale=args.locale)['rows'])}))
    elif args.command=='preflight':print(json.dumps({'status':'accepted-preflight-pass','assigned':len(load_inputs(locale=args.locale)['rows'])}))
    elif args.command=='snapshot':print(snapshot(args.output,locale=args.locale))
    else:print(json.dumps(apply(args.source,args.output,locale=args.locale)))
if __name__=='__main__':main()
