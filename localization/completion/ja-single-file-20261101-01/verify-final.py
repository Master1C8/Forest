"""Read delivered bytes and original source; never install or modify resources."""
import gc
import hashlib
import json
import sys
from pathlib import Path

ROOT=Path(__file__).resolve().parents[3]
sys.path.insert(0,str(ROOT/'tools'))
from forest_localization.core import engines
from forest_localization import font_metrics
P=ROOT/'outputs/ja-single-file-20261101-01'
F=ROOT/'localization/framework/forest045-shared-v2'
O=ROOT/'dist/Forest-ja-single-file-final-20261101-01'
DATA=O/'The Forest of Love_Data'
def read(p):return json.loads(Path(p).read_text())
def sha(b):return hashlib.sha256(b).hexdigest()
framework=read(F/'framework.json');manifest=read(O/'manifest.json')
language=read(ROOT/'localization/languages/ja.json')
assert sha((ROOT/'localization/languages/ja.json').read_bytes())==manifest['languageSha256']
for n,v in manifest['files'].items():
    b=(O/n).read_bytes();assert len(b)==v['bytes'] and sha(b)==v['sha256'],n
original=Path(framework['sourceProvenance'])
sourcefiles={}
for n,v in framework['sourceMembers'].items():
    p=original/n;b=p.read_bytes();assert len(b)==v['bytes'] and sha(b)==v['sha256'],n
    sourcefiles[n]=v
U,Generator,tree,canonical,comp,inv,writer=engines()
gen=Generator('2020.3.24f1');gen.load_local_dll_folder(str(F/'references'))
selected={}
for key,r in framework['fontRoles'].items():selected.setdefault(r['asset'],[]).append((key,r))
fontproof=[];tmpproof={};textureproof=[];source_texture_count=0;metricproof=[]
for name in sourcefiles:
    if not (name.endswith('.assets') or name.endswith('.bundle') or name.startswith('Resources/')):continue
    src=U.load(str(original/name));src.path=str(original)
    obs=comp.objects(src)
    chosen=DATA/name
    saved=U.load(str(chosen)) if chosen.exists() else src
    # An overlay deliberately omits unchanged external companions. Resolve those
    # from the hash-verified original game, never from an assumed full overlay.
    saved.path=str(original)
    target=comp.objects(saved)
    tex=[]
    for pid,obj in obs.items():
        if obj.type.name!='Texture2D':continue
        h=sha(obj.get_raw_data());assert h==sha(target[pid].get_raw_data()),(name,pid)
        tex.append(dict(pathId=pid,sha256=h))
    source_texture_count+=len(tex)
    streamproof=[]
    if not hasattr(src.file,'objects'):
        assert set(src.file.files)==set(saved.file.files)
        for member,a in src.file.files.items():
            if hasattr(a,'objects'):continue
            b=saved.file.files[member];assert a.bytes==b.bytes
            streamproof.append(dict(member=member,sha256=sha(a.bytes),bytes=len(a.bytes)))
    textureproof.append(dict(asset=name,delivered=chosen.exists(),textureCount=len(tex),textures=tex,bundleStreams=streamproof))
    baseline=U.load(str(F/'base'/name)) if name in selected else None
    if baseline:baseline.path=str(F/'base')
    baseline_objects=comp.objects(baseline) if baseline else {}
    for key,r in selected.get(name,[]):
        t=tree(target[r['pathId']],gen);payload=bytes(t['m_FontData']);spec=language['fonts'][key]
        assert sha(payload)==spec['asset'] and t['m_FontNames']==[spec['family']]
        old=tree(baseline_objects[r['pathId']],gen)
        metrics=font_metrics.face_metrics(payload,spec['family'])
        expected=font_metrics.native_font(old,payload,metrics)
        assert canonical(t)==canonical(expected),(key,'native metric projection')
        metricproof.append(dict(role=key,pointSize=t['m_FontSize'],ascent=t['m_Ascent'],descent=t['m_Descent'],lineSpacing=t['m_LineSpacing'],kerningCount=len(t['m_KerningValues'])))
        fontproof.append(dict(role=key,pathId=r['pathId'],name=t['m_Name'],fontNames=t['m_FontNames'],bytes=len(payload),sha256=sha(payload),material=t.get('m_Material'),texture=t.get('m_Texture'),fallbacks=t.get('m_FallbackFonts')))
    if name=='resources.assets':
        assert baseline_objects[1020].get_raw_data()==target[1020].get_raw_data(),'accepted TMP1020 unchanged'
        tmp=tree(target[1017],gen);before=tree(baseline_objects[1017],gen)
        expected=font_metrics.tmp_font(before,metrics,439,language['fonts']['resources.assets:439']['asset']+metrics['extension'])
        assert canonical(tmp)==canonical(expected),'saved TMP1017 exact coherent projection'
        for k in ['m_SourceFontFile','m_FallbackFontAssetTable','m_AtlasTextures']:
            assert tmp[k]==before[k],k
        for pid in [1017,1020]:
            t=tree(target[pid],gen)
            tmpproof[str(pid)]={k:t.get(k) for k in ['m_Name','m_FaceInfo','m_SourceFontFile','m_FallbackFontAssetTable','m_AtlasPopulationMode','m_AtlasTextures','m_CharacterTable']}
    if name=='sharedassets0.assets':
        for pid in [3324,3,245]:assert obs[pid].get_raw_data()==target[pid].get_raw_data(),('fictional',pid)
    del src,saved,obs,target,baseline,baseline_objects
    gc.collect()
    print(name,len(tex),flush=True)
assert source_texture_count==1385,source_texture_count
assert len(fontproof)==8
# External files are not copied by this overlay; prove their original hashes and
# inventory rather than pretending absence is an emitted replacement.
streams={n:v for n,v in sourcefiles.items() if n.endswith(('.resS','.resource'))}
proof=dict(languageSha256=manifest['languageSha256'],manifestSha256=sha((O/'manifest.json').read_bytes()),originalRoot=str(original),sourceFilesVerified=len(sourcefiles),sourceMembersSha256=sha(json.dumps(sourcefiles,sort_keys=True,separators=(',',':')).encode()),texturesCompared=source_texture_count,textureObjects=textureproof,externalStreamsRetainedOriginal=streams,fontPayloads=fontproof,tmpBindings=tmpproof,fontMetricProjection=metricproof,tmp1020='accepted baseline raw bytes equal',fictionalFont3324Material3Atlas245='original raw bytes equal',boundary='Saved-byte static comparison against original247-member game source. Overlay resources replace exact paths; omitted companions remain original. This proves no install/native load, shaping, fallback selection or visual acceptance.')
(P/'final-saved-resource-font-texture-proof.json').write_text(json.dumps(proof,ensure_ascii=False,indent=2)+'\n')
print(json.dumps(dict(textures=source_texture_count,sourceFiles=len(sourcefiles),fontPayloads=len(fontproof),tmpFace=tmpproof['1017']['m_FaceInfo']),ensure_ascii=False),flush=True)
