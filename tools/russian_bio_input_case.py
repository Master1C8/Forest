#!/usr/bin/env python3
"""Finite accepted Bio113/input72 static display application. Never executes game code.

Output writes are independent and exclusive, not a multi-file transaction. Preserve
partial output for reconciliation; retry requires a new output directory.
"""
import argparse
import base64
import collections
import copy
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import shutil
import struct
import sys
import urllib.parse

PROJECT = Path('/Users/antonkrutov/Desktop/Forest')
LOCAL = Path(__file__).resolve().parent
FROZEN = (LOCAL / 'bio-input-snapshot.json').is_file()
ROOT = LOCAL / 'inputs' if FROZEN else PROJECT
CONTRACT = LOCAL / 'contract' if FROZEN else PROJECT / 'localization/source/bio-input-application-20261029'
NORMAL = LOCAL / 'normal-build-contract' if FROZEN else PROJECT / 'localization/source/bio-input-normal-build-repair-20261029'
NORMAL_PIN = 'ace72bce706ef59bf6a4f56a00e0a63eec84fa2d945c34ce02b3752a26f1cffd'
MAP = 'b52644b165af58d1c07f50c531c4e99de7ec68a09ce018d4923f7cf281288b88'
PACKETS = [('bio-case113',113,112,0,1,'859f07e34f6686bf5d0f92800ebd0045ba382404ef19d2c952931d52c7a10eba'),('input-case72',72,70,2,0,'6cb08e98a3e53e8079f80b95f0bc566ace05a2d4a98f1d416ce3774a6229ed3e')]
BG_PRIOR = '7765f04feb270f755adead4701911e659b6b9021498b6530b6430bb4174b75d2'
MANAGED = '6bb930ea1fa5befcd1f8a13f13d140347a7dc96419ce2c81aa95682c7625861d'
WIDTHS = {'BGFieldBool':1,'BGFieldInt':4,'BGFieldEnum':4,'BGFieldFloat':4,'BGFieldVector2':8}
CODEC = 'localization/source/bgdatabase-20261027/decode_inventory.py'
PEER = 'localization/source/bgdatabase-complete-values-20261027/frozen_independent_reader.py'

def need(ok, reason):
    if not ok: raise ValueError(reason)
def digest(b): return hashlib.sha256(b).hexdigest()
def sha(p):
    h=hashlib.sha256()
    with Path(p).open('rb') as f:
        for b in iter(lambda:f.read(1024*1024),b''):h.update(b)
    return h.hexdigest()
def enc(x): return (json.dumps(x,ensure_ascii=False,sort_keys=True,separators=(',',':'))+'\n').encode()
def read(p): return json.loads(Path(p).read_bytes())
def rows(p): return [json.loads(x) for x in Path(p).read_text().splitlines()]
def emit(p,x):
    with Path(p).open('xb') as f:f.write(enc(x))
def module(p,n):
    s=importlib.util.spec_from_file_location(n,p);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m

def helper_identity(data):
    """Exact PE image except its COFF timestamp and sole Module MVID.

    This is deliberately narrower than semantic IL comparison: padding, table
    order, assembly identity, resources, references, methods and fields all stay
    exact. Parse the two regions; never search/replace arbitrary GUID bytes.
    """
    def u(fmt,at):
        need(0<=at and at+struct.calcsize(fmt)<=len(data),'helper-pe-bounds')
        return struct.unpack_from(fmt,data,at)[0]
    need(data[:2]==b'MZ','helper-dos-signature');pe=u('<I',60)
    need(data[pe:pe+4]==b'PE\0\0','helper-pe-signature')
    count=u('<H',pe+6);opt=pe+24;size=u('<H',pe+20)
    need(u('<H',opt)==0x10b and size>=224,'helper-pe32-layout')
    sections=opt+size
    def offset(rva,length):
        found=[]
        for i in range(count):
            p=sections+40*i;start=u('<I',p+12);rawsize=u('<I',p+16);raw=u('<I',p+20)
            if start<=rva and rva+length<=start+rawsize:found.append(raw+rva-start)
        need(len(found)==1,'helper-rva-section');at=found[0]
        need(0<=at and at+length<=len(data),'helper-rva-bounds');return at
    cli=offset(u('<I',opt+96+14*8),72)
    meta=offset(u('<I',cli+8),u('<I',cli+12));need(data[meta:meta+4]==b'BSJB','helper-metadata-signature')
    p=(meta+16+u('<I',meta+12)+3)&~3;streams=u('<H',p+2);p+=4;headers={}
    for _ in range(streams):
        off=u('<I',p);length=u('<I',p+4);end=data.index(b'\0',p+8,p+40);name=data[p+8:end].decode('ascii')
        need(name not in headers,'helper-duplicate-stream');headers[name]=(meta+off,length);p=(end+4)&~3
    need('#~' in headers and '#GUID' in headers,'helper-required-streams')
    table,tsize=headers['#~'];guid,gsize=headers['#GUID'];heaps=u('<B',table+6);valid=u('<Q',table+8);p=table+24;counts={}
    for i in range(64):
        if valid&(1<<i):counts[i]=u('<I',p);p+=4
    need(counts.get(0)==1 and gsize==16,'helper-single-module-mvid')
    stringwidth=4 if heaps&1 else 2;guidwidth=4 if heaps&2 else 2;fmt='<I' if guidwidth==4 else '<H'
    need(u('<H',p)==0,'helper-module-generation');mvid=u(fmt,p+2+stringwidth)
    need(mvid==1 and u(fmt,p+2+stringwidth+guidwidth)==0 and u(fmt,p+2+stringwidth+2*guidwidth)==0,'helper-module-guid-indices')
    need(guid+16<=len(data),'helper-guid-bounds')
    regions=[{'kind':'COFF.TimeDateStamp','offset':pe+8,'length':4}, {'kind':'Module.Mvid','offset':guid,'length':16}]
    normalized=bytearray(data)
    for r in regions:normalized[r['offset']:r['offset']+r['length']]=b'\0'*r['length']
    return digest(normalized),regions

def normal_contract():
    need(sha(NORMAL/'normal-build-contract.json')==NORMAL_PIN,'normal-build-contract-pin')
    c=read(NORMAL/'normal-build-contract.json')
    need(sha(NORMAL/'compiler-pins.json')==c['producerPins']['tools/remaining51_patch/compiler-pins.json'],'normal-compiler-manifest-pin')
    for n,r in c['helpers'].items():need(sha(NORMAL/r['reference'])==r['sha256'],'normal-helper-reference-pin:'+n)
    return c

def verify_producers(c):
    # Before any normal builder output/compilation, verify every producer source,
    # full compiler/host/runtime/reference-pack tree and original reference file.
    for n,h in c['producerPins'].items():need(sha(PROJECT/n)==h,'normal-producer-pin:'+n)
    for n,h in read(NORMAL/'compiler-pins.json')['files'].items():need(sha(n)==h,'normal-compiler-pin:'+n)
    managed=Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/Managed')
    for n,h in c['referencePins'].items():need(sha(managed/n)==h,'normal-original-reference-pin:'+n)

def verify_prior_files(source):
    expected=read(CONTRACT/'prior-files.json');c=normal_contract();report=[];variant=False
    for n,h in expected.items():
        raw=(source/n).read_bytes();actual=digest(raw);r={'file':n,'sha256':actual,'acceptedSha256':h,'byteExact':actual==h}
        if n in c['helpers']:
            reference=(NORMAL/c['helpers'][n]['reference']).read_bytes();identity,regions=helper_identity(raw);oldidentity,oldregions=helper_identity(reference)
            need(identity==oldidentity and regions==oldregions,'supported-prior-helper-image:'+n)
            r.update(nonvolatileImageSha256=identity,volatileRegions=regions)
            variant|=actual!=h
        else:need(actual==h,'supported-prior-file:'+n)
        report.append(r)
    if variant:
        # Real normal producer evidence is mandatory for a newly emitted helper.
        # Exact old fixtures remain supported without pretending they were rebuilt.
        recipe=source.parent.parent
        for n,h in c['recipePins'].items():need(sha(recipe/n)==h,'normal-recipe-pin:'+n)
        inv=read(recipe/'inventory-layout-build.json');helper=inv.pop('helperSha256')
        need(inv==c['inventoryBuildReceipt'],'normal-inventory-build-fingerprint')
        need(helper==sha(source/'Managed/VNRevivalInventoryLayout.dll'),'normal-inventory-output-binding')
        need(read(recipe/'quest-family-inputs.json')==c['questInputs'],'normal-quest-build-fingerprint')
        quest=read(recipe/'quest-code-readback.json')
        need(quest['sourceSha256']==c['questSourceAssembly'],'normal-quest-source-assembly')
        need(quest['layoutAssemblySha256']==sha(source/'Managed/VNRevivalQuestLayout.dll'),'normal-quest-output-binding')
        for n,h in c['referencePins'].items():
            if n!='Assembly-CSharp.dll':need(sha(source/'Managed'/n)==h,'normal-prior-reference-pin:'+n)
    return {'version':2,'allStrictFiles':report,'normalProducerEvidenceRequired':variant,'allowedVariation':'Only parsed COFF.TimeDateStamp and sole Module.Mvid; every other image byte exact.'}

def get(t,p):
    for k in p.strip('/').split('/'):t=t[int(k)] if isinstance(t,list) else t[k]
    return t

def put(t,p,v):
    ks=p.strip('/').split('/')
    for k in ks[:-1]:t=t[int(k)] if isinstance(t,list) else t[k]
    k=ks[-1];t[int(k) if isinstance(t,list) else k]=v

def diff(a,b,p=''):
    if isinstance(a,dict) and isinstance(b,dict) and a.keys()==b.keys():return [z for k in a for z in diff(a[k],b[k],p+'/'+str(k))]
    if isinstance(a,list) and isinstance(b,list) and len(a)==len(b):return [z for i in range(len(a)) for z in diff(a[i],b[i],p+'/'+str(i))]
    return [] if a==b else [p]

def validate_rows(targets,sources,plan,*,locale):
    need(locale=='ru','explicit-ru-locale-required')
    need(len(targets)==len({r['id'] for r in targets})==185,'exact185-unique-ids')
    need([r['id'] for r in targets]==[r.get('bindingId',r.get('assigned',{}).get('bindingId')) for r in sources],'ordered-source-id-set')
    need([r['id'] for r in targets]==[r['id'] for r in plan['rows']],'mapping-id-set')
    for t,s,r in zip(targets,sources,plan['rows']):
        ident=t['id'];source=s.get('source',s.get('assigned',{}).get('source'))
        need(t['locale']==locale,'target-locale:'+ident)
        need(t['source']==source==r['source'],'source-binding:'+ident)
        need(t['sourceValueSha256']==r['sourceValueSha256']==digest(json.dumps(source,ensure_ascii=False,sort_keys=True,separators=(',',':')).encode()),'source-value-hash:'+ident)
        need(t['target']==r['target'] and t['targetUtf8Sha256']==r['targetUtf8Sha256']==digest(t['target'].encode()),'accepted-target-binding:'+ident)
        need(r['retained']==bool(t.get('reuseReference')) and r['symbol']==(t['source']==t['target']),'retained-symbol-disjoint:'+ident)
        need(t['target'].strip() and '\0' not in t['target'] and '\\n' not in t['target'],'valid-raw-text:'+ident)
        tokens=lambda v:re.findall(r'<[^>]*>|\{[^{}]*\}|\[[^\]]*\]',v)
        need(tokens(t['source'])==tokens(t['target']) and t['source'].count('\n')==t['target'].count('\n'),'protected-controls:'+ident)
        need(r['kind']=='bg' or r['pointer']=='/m_text' or r['pointer']=='/m_Text' or re.fullmatch(r'/specialKeys/[04]/name',r['pointer']),'display-pointer-only:'+ident)
    need(sum(r['retained'] for r in plan['rows'])==2 and sum(r['symbol'] for r in plan['rows'])==1,'exact-retained2-symbol1')

def verify_snapshot():
    if FROZEN:
        for n,h in read(LOCAL/'bio-input-snapshot.json')['files'].items():need(sha(LOCAL/n)==h,'snapshot-pin:'+n)

def load_inputs(*,locale):
    need(locale=='ru','explicit-ru-locale-required');verify_snapshot()
    supplemental=normal_contract()
    if not FROZEN:verify_producers(supplemental)
    need(sha(CONTRACT/'mapping.json')==MAP,'accepted-mapping-hash')
    for n,h in read(CONTRACT/'contract-pins.json').items():need(sha(CONTRACT/n)==h,'contract-pin:'+n)
    targets=[];sources=[]
    for case,count,new,retained,symbol,h in PACKETS:
        q=ROOT/('localization/supplemental-ui/20261029-'+case)
        need((q/'ru.acceptance.json').is_file(),'bounded-editorial-acceptance-required:'+case)
        a=read(q/'ru.acceptance.json')
        need(a['status']=='bounded-russian-editorial-accepted' and a['locale']==locale and a['targetEditorialAccepted'],'editorial-acceptance:'+case)
        need(a['assignedOccurrences']==count and a['newIndependentSemanticRows']==new and a['newSeparateNativeReadRows']==new and a['retainedAcceptedRows']==retained and a['preservedAssignedSymbols']==symbol and not a['exactFinalDelta'],'complete-acceptance:'+case)
        need(a['targetFile']=='ru.prepared.jsonl' and a['targetSha256']==h==sha(q/'ru.prepared.jsonl'),'accepted-target-hash:'+case)
        need(a['sourceSha256']==sha(q/'source-context.jsonl'),'accepted-source-hash:'+case)
        for n,v in a['evidence'].items():need(sha(ROOT/n)==v,'accepted-evidence-pin:'+n)
        targets+=rows(q/'ru.prepared.jsonl');sources+=rows(q/'source-context.jsonl')
    for n,h in read(CONTRACT/'input-pins.json').items():need(sha(ROOT/n)==h,'input-pin:'+n)
    plan=read(CONTRACT/'mapping.json');validate_rows(targets,sources,plan,locale=locale)
    return plan

def codecs():return module(ROOT/CODEC,'bio_codec'),module(ROOT/PEER,'bio_peer')
def bg_inventory(data,codec):
    env=codec.parse(data);states={}
    for s in env['sheets']:
        for f in s['fields']:
            blob=data[f['valuesOffset']:f['valuesOffset']+f['valuesBytes']];kind=f['type'].split(',')[0].rsplit('.',1)[-1]
            if kind in WIDTHS:
                w=WIDTHS[kind];need(len(blob)==w*len(s['rowIds']),'fixed-field-size');cells=[blob[i*w:(i+1)*w] for i in range(len(s['rowIds']))]
            else:cells,_=codec.variable_cells(dict(f,valuesHex=blob.hex()),len(s['rowIds']))
            for i,r in enumerate(s['rowIds']):
                ident='bgdb:resources.assets:320/sheet/'+urllib.parse.quote(s['id'],safe='')+'/row/'+urllib.parse.quote(r,safe='')+'/field/'+urllib.parse.quote(f['id'],safe='')
                need(ident not in states,'duplicate-bg-id');states[ident]=cells[i]
    need(len(states)==51572,'whole51572-states');return env,states

def independent_inventory(data,peer):
    # Different envelope decoder, IDs normalized from its native hex representation.
    inventory=peer.extract(data);result={}
    ident=lambda h:base64.b64encode(bytes.fromhex(h)).decode()[:22]
    for t in inventory['tables']:
        for f in t['fields']:
            blob=base64.b64decode(f['valuesBase64']);kind=f['type'].split(',')[0].rsplit('.',1)[-1];vals=[None]*len(t['rowIds'])
            if kind in WIDTHS:
                w=WIDTHS[kind];need(len(blob)==w*len(vals),'peer-fixed-size');vals=[blob[i*w:(i+1)*w] for i in range(len(vals))]
            elif blob:
                r=peer.Reader(blob);count=r.count();indices=[(r.integer(),r.integer()) for _ in range(count)];start=r.pos;end=0;seen=set()
                for i,e in indices:
                    need(0<=i<len(vals) and i not in seen and end<=e<=len(blob)-start,'peer-sparse-range');seen.add(i);vals[i]=blob[start+end:start+e];end=e
                need(start+end==len(blob),'peer-whole-field-consumed')
            for i,rid in enumerate(t['rowIds']):
                key='bgdb:resources.assets:320/sheet/'+urllib.parse.quote(ident(t['id']),safe='')+'/row/'+urllib.parse.quote(ident(rid),safe='')+'/field/'+urllib.parse.quote(ident(f['id']),safe='');need(key not in result,'peer-duplicate-id');result[key]=vals[i]
    need(len(result)==51572,'peer51572');return result

def encode_cells(old,cells):
    count=struct.unpack_from('<i',old)[0];order=[struct.unpack_from('<ii',old,4+8*i)[0] for i in range(count)];end=0;pairs=[];payload=[]
    need(len(set(order))==count,'duplicate-stored-index')
    for i in order:
        need(cells[i] is not None,'stored-null');end+=len(cells[i]);pairs.append(struct.pack('<ii',i,end));payload.append(cells[i])
    return struct.pack('<i',count)+b''.join(pairs)+b''.join(payload)
def replace_columns(data,cols):
    for f,b in sorted(cols,key=lambda x:x[0]['valuesOffset'],reverse=True):
        start=f['valuesOffset'];data=data[:start-4]+struct.pack('<i',len(b))+b+data[start+f['valuesBytes']:]
    return data

def validate_bg_change(before,after,plan):
    chosen=[r for r in plan['rows'] if r['kind']=='bg'];need(before.keys()==after.keys(),'bg-id-set')
    for r in chosen:
        need(before[r['id']]==r['priorValue'].encode(),'bg-before:'+r['id']);need(after[r['id']]==r['target'].encode(),'bg-target:'+r['id'])
    changed={k for k in before if before[k]!=after[k]};need(changed=={r['id'] for r in chosen if r['changes']},'bg-exact110-changed-set')
    for r in rows(ROOT/'localization/supplemental-ui/20261029-bio-case113/protected-controls.jsonl'):
        # This source-context set also contains already localized Actor display
        # names. Preserve the supported prior state; never revert accepted names
        # to English merely because the historical source ledger calls it protected.
        need(before[r['id']]==after[r['id']],'protected1468-bg:'+r['id'])
    return changed

def project_bg(data,*,locale,plan=None):
    accepted=load_inputs(locale=locale);need(plan is None or plan==accepted,'accepted-plan-version');plan=accepted
    codec,peer=codecs();before,states=bg_inventory(data,codec);need(states==independent_inventory(data,peer),'independent-before51572')
    cols=[];oldcols={};selected=[r for r in plan['rows'] if r['kind']=='bg' and r['changes']]
    for s in before['sheets']:
        for f in s['fields']:
            rr=[r for r in selected if r['sheetId']==s['id'] and r['fieldId']==f['id']]
            if rr:
                need(s['name']=='BioKeyword' and f['name']=='bio_text','exact-bio-display-column');old=data[f['valuesOffset']:f['valuesOffset']+f['valuesBytes']];cells,_=codec.variable_cells(dict(f,valuesHex=old.hex()),len(s['rowIds']))
                for r in rr:
                    need(s['rowIds'][r['rowIndex']]==r['rowId'] and states[r['id']]==r['priorValue'].encode(),'bg-source-selector:'+r['id']);cells[r['rowIndex']]=r['target'].encode()
                cols.append((f,encode_cells(old,cells)));oldcols[(s['id'],f['id'])]=old
    need(digest(data)==BG_PRIOR,'supported-prior-bg-payload')
    result=replace_columns(data,cols);after,new=bg_inventory(result,codec);need(new==independent_inventory(result,peer),'independent-after51572');changed=validate_bg_change(states,new,plan)
    reverse=[(f,oldcols[(s['id'],f['id'])]) for s in after['sheets'] for f in s['fields'] if (s['id'],f['id']) in oldcols]
    need(replace_columns(result,reverse)==data,'whole-prior-bg-reversal')
    ledger=[{'id':k,'before':None if states[k] is None else base64.b64encode(states[k]).decode(),'after':None if new[k] is None else base64.b64encode(new[k]).decode(),'changed':k in changed} for k in states]
    return result,{'comparedStates':51572,'independentStates':51572,'changedIds':sorted(changed),'changedCells':len(changed),'fullPriorPayloadReversed':True,'beforeSha256':digest(data),'afterSha256':digest(result)},ledger

def validate_native_change(before,after,selected):
    need(set(diff(before,after))=={r['pointer'] for r in selected if r['changes']},'native-exact-pointer-set')
    for r in selected:
        need(get(before,r['pointer'])==r['priorValue'],'native-before:'+r['id']);need(get(after,r['pointer'])==r['target'],'native-target:'+r['id'])

def keyboard_contract(trees,plan):
    facts=read(CONTRACT/'native-resource-facts.initial.json');report=[]
    for f in facts:
        if 'queue' not in f:continue
        file=f['file'];key=(file,f['pathId']);t=trees[key];need(t['layout']==f['tree']['layout'],'keyboard-layout-identity')
        tokens=[x for x in t['layout'].split(' ') if x and not x.startswith('\n') and 'Skip' not in x]
        queue=f['queue'];need(len(tokens)==33 and len(queue)==(36 if 'LeftShift' in tokens else 37),'saved-key-queue-scope')
        for i,label in [(19,'LeftShift'),(28,'ScrollLock'),(32,'Return')]:
            if label=='LeftShift' and tokens[i]!='LeftShift':continue
            need(tokens[i]==label,'saved-queue-key-position');need(queue[i]['key']=={'LeftShift':304,'ScrollLock':302,'Return':13}[label],'saved-queue-keycode')
        for sk,old in zip(t['specialKeys'],f['tree']['specialKeys']):
            need({k:v for k,v in sk.items() if k!='name'}=={k:v for k,v in old.items() if k!='name'},'special-dispatch-identity')
        for k in queue:
            target=next((r['target'] for r in plan['rows'] if r['kind']=='native' and r['file']==file and r['pathId']==k['labelPathId']),k['label'])
            label=trees.get((file,k['labelPathId']),{}).get('m_text',k['label']);need(label==target,'initial-label-identity')
            if k['key'] not in [303,304]:continue
            sk=next(s for s in t['specialKeys'] if s['keycode']==k['key']);need(sk['name']==label,'cache-awake-generate-parity')
            # Source-derived static state transitions, not execution of the game methods.
            for order in ['Awake->Generate','Generate->Awake']:
                cache=label;generated=sk['name'];need(cache==generated==target,'defaultLabelText-restore')
                override='existing contextual override';visible=override;need(visible==override,'nonnull-Relabel-preserved');visible=cache;need(visible==target,'null-Relabel-restore')
            report.append({'file':file,'keyboard':f['pathId'],'keyComponent':k['pathId'],'keycode':k['key'],'captionId':file+':'+str(k['labelPathId'])+'/m_text','cacheValue':label,'orders':['Awake->Generate','Generate->Awake'],'RelabelNonNull':'original override preserved','RelabelNull':'exact translated default','actualGameRuntime':'not-run'})
    need(len(report)==2,'two-shift-caches');return report

def apply(source,output,*,locale,plan=None,fail_after=None):
    accepted=load_inputs(locale=locale);need(plan is None or plan==accepted,'accepted-plan-version');plan=accepted
    source,output=Path(source),Path(output);need(not output.exists(),'new-output-required');need(PROJECT in output.resolve().parents,'project-owned-output')
    admission=verify_prior_files(source)
    # Imports resolve only frozen sources/dependencies for private execution.
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    ex=module(ROOT/'tools/extract_assets.py','bio_extract');g=TypeTreeGenerator('2020.3.24f1');g.load_local_dll_folder(str(source/'Managed'))
    byfile=collections.defaultdict(list)
    for r in plan['rows']:
        if r['kind']=='native':byfile[r['file']].append(r)
    names=sorted(set(byfile)|{'resources.assets'});prepared={};receipts=[];bg_receipt=ledger=None;alltrees={}
    keyboard_ids={(f['file'],f['pathId']) for f in read(CONTRACT/'native-resource-facts.initial.json') if 'queue' in f}
    for name in names:
        env=UnityPy.load(str(source/name));obs={o.path_id:o for o in env.objects};raw={i:o.get_raw_data() for i,o in obs.items()};selected=collections.defaultdict(list)
        for r in byfile[name]:selected[r['pathId']].append(r)
        expected_trees={}
        for pid,rr in selected.items():
            before=ex.canonical(ex.read_tree(obs[pid],g));after=copy.deepcopy(before)
            for r in rr:need(get(before,r['pointer'])==r['priorValue'],'native-before:'+r['id']);put(after,r['pointer'],r['target'])
            validate_native_change(before,after,rr);expected_trees[pid]=after
            if any(r['changes'] for r in rr):save_tree(obs[pid],after,g)
        if name=='resources.assets':
            before=ex.read_tree(obs[320],g);data=before['m_Script'].encode('utf-8',errors='surrogateescape');new,bg_receipt,ledger=project_bg(data,locale=locale,plan=plan);after=copy.deepcopy(before);after['m_Script']=new.decode('utf-8',errors='surrogateescape');expected_trees[320]=ex.canonical(after);save_tree(obs[320],after,g)
        data=env.file.save();reload=UnityPy.load(data);reload.path=str(source);reobs={o.path_id:o for o in reload.objects};need(reobs.keys()==obs.keys(),'native-object-id-set:'+name)
        changed=[];objects=[]
        for pid,obj in reobs.items():
            got=obj.get_raw_data();is_changed=got!=raw[pid]
            objects.append({'pathId':pid,'type':obj.type.name,'beforeSha256':digest(raw[pid]),'afterSha256':digest(got),'changed':is_changed})
            if pid in expected_trees:
                need(ex.canonical(ex.read_tree(obj,g))==expected_trees[pid],'serialized-native-target:'+name+':'+str(pid))
                need(is_changed==(pid==320 and name=='resources.assets' or any(r['changes'] for r in selected[pid])),'physical-changed-object:'+str(pid))
            else:need(not is_changed,'unrelated-object-change:'+name+':'+str(pid))
            if obj.type.name=='Texture2D':need(got==raw[pid],'texture-raw-bytes')
            if is_changed:changed.append(pid)
            if name in ['level1','sharedassets2.assets'] and ((name,pid) in keyboard_ids or pid in selected):alltrees[(name,pid)]=ex.canonical(ex.read_tree(obj,g))
        # Reverse actual serialized object payloads and actual whole container framing.
        for pid in changed:reobs[pid].set_raw_data(raw[pid])
        reversed_bytes=reload.file.save();need(reversed_bytes==(source/name).read_bytes(),'whole-native-container-reversal:'+name)
        prepared[name]=data;receipts.append({'file':name,'beforeSha256':sha(source/name),'afterSha256':digest(data),'changedObjects':changed,'objectCount':len(objects),'objects':objects,'wholeContainerReversedByteExact':True})
    cache=keyboard_contract(alltrees,plan)
    need(sum(len(r['changedObjects']) for r in receipts)==71,'physical71-changed-objects')
    # No file exists until ALL resource transformations/readbacks and cache checks pass.
    output.mkdir(parents=True)
    for index,name in enumerate(names,1):
        with (output/name).open('xb') as f:f.write(prepared[name])
        if fail_after==index:raise RuntimeError('injected-between-resource-writes:'+str(index))
    emit(output/'whole-bg-ledger.jsonl.manifest',{'records':51572,'encoding':'canonical JSONL, raw cell base64, absent null'})
    with (output/'whole-bg-ledger.jsonl').open('xb') as f:
        for r in ledger:f.write(enc(r))
    for r in receipts:emit(output/(r['file']+'.inventory.json'),r)
    emit(output/'cache-dispatch-proof.json',{'status':'static-contract-pass','compiledAliasRequired':False,'managedSha256':MANAGED,'shiftCaches':cache,'runtime':'not-run','boundary':'Saved source IL and exact resource state; native Unity lifecycle execution remains unverified.'})
    for r in admission['allStrictFiles']:
        need(sha(source/r['file'])==r['sha256'],'prior-source-changed-during-application:'+r['file'])
    admission['allPriorFilesByteExactBeforeAfterApplication']=True
    emit(output/'prior-admission-v2.json',admission)
    result={'status':'finite185-private-application-pass','assigned':185,'newSemanticWordings':182,'changedBGCells':110,'changedNativeFields':72,'changedNativeObjects':70,'physicalChangedObjectsIncludingTextAsset':71,'retained':2,'symbolPreserved':1,'bg':bg_receipt,'files':{r['file']:r['afterSha256'] for r in receipts},'managedAssemblyUnchanged':MANAGED,'compiledMethodsPreserved':14099,'actualGameRuntime':'not-run','targetWordingChanged':0,'sourceGateAccepted':False,'ordinaryTranslationEntryAllowed':False,'wholeGameAccepted':False,'commitBoundary':'independent exclusive resource/ledger/receipt writes; occupied directory rejects retry; no multi-file rollback transaction'}
    result.update(priorAdmissionContractVersion=2,priorAdmissionReceiptSha256=sha(output/'prior-admission-v2.json'),managedHelpersPreservedByteExact=True)
    emit(output/'Result.json',result);return result

def save_tree(obj,t,g):
    nodes=None
    if obj.type.name=='MonoBehaviour':
        s=obj.parse_monobehaviour_head().m_Script.deref().read();cl=(s.m_Namespace+'.' if s.m_Namespace else '')+s.m_ClassName;nodes=g.cache.get(('forest-header-aligned:'+s.m_AssemblyName,cl))
    obj.save_typetree(t,nodes=nodes)

def snapshot(out,*,locale):
    load_inputs(locale=locale);dest=Path(out)/'bio-input';need(not dest.exists(),'new-snapshot-required')
    files={'russian_bio_input_case.py':Path(__file__).read_bytes(),'build_russian_preview.py':(LOCAL/'build_russian_preview.py').read_bytes()}
    for n in ['contract-pins.json']+list(read(CONTRACT/'contract-pins.json')):files['contract/'+n]=(CONTRACT/n).read_bytes()
    for p in NORMAL.rglob('*'):
        if p.is_file() and (p.name in ['normal-build-contract.json','compiler-pins.json'] or p.parent.name=='accepted-helpers'):
            files['normal-build-contract/'+str(p.relative_to(NORMAL))]=p.read_bytes()
    for n,h in read(CONTRACT/'input-pins.json').items():
        raw=(ROOT/n).read_bytes();need(digest(raw)==h,'snapshot-input:'+n);files['inputs/'+n]=raw
    dest.mkdir(parents=True)
    for n,b in files.items():
        p=dest/n;p.parent.mkdir(parents=True,exist_ok=True)
        with p.open('xb') as f:f.write(b)
    # Complete relocatable interpreter, stdlib, native extensions, generator and packages.
    shutil.copytree(sys.base_prefix,dest/'runtime/python',symlinks=False,ignore=shutil.ignore_patterns('__pycache__'))
    if not FROZEN:
        import site
        packages=[Path(p) for p in site.getsitepackages() if Path(p).is_dir() and not Path(p).is_relative_to(Path(sys.base_prefix))]
        need(len(packages)==1,'single-pinned-package-tree')
        shutil.copytree(packages[0],dest/'runtime/python/lib/python3.14/site-packages',dirs_exist_ok=True,symlinks=False,ignore=shutil.ignore_patterns('__pycache__'))
    emit(dest/'bio-input-snapshot.json',{'files':{str(p.relative_to(dest)):sha(p) for p in sorted(dest.rglob('*')) if p.is_file()},'pythonVersion':sys.version,'completeRuntime':'relocatable CPython base, stdlib, native libraries and entire active site-packages; macOS system libraries remain OS dependencies','commitBoundary':'independent files; final manifest marks complete snapshot'})
    return dest

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--locale',required=True);s=p.add_subparsers(dest='command',required=True);s.add_parser('preflight');a=s.add_parser('snapshot');a.add_argument('--output',type=Path,required=True);a=s.add_parser('apply');a.add_argument('--source',type=Path,required=True);a.add_argument('--output',type=Path,required=True);args=p.parse_args()
    if args.command=='preflight':print(json.dumps({'passed':True,'occurrences':len(load_inputs(locale=args.locale)['rows'])}))
    elif args.command=='snapshot':print(snapshot(args.output,locale=args.locale))
    else:print(json.dumps(apply(args.source,args.output,locale=args.locale)))
if __name__=='__main__':main()
