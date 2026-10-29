import json,hashlib,collections
from pathlib import Path
ROOT=Path('/Users/antonkrutov/Desktop/Forest'); C=ROOT/'outputs/ru-input72-case-wording-20261029/check'; O=ROOT/'localization/supplemental-ui/20261029-input-case72'; O.mkdir(exist_ok=False)
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def vh(x):return hashlib.sha256(json.dumps(x,ensure_ascii=False,sort_keys=True,separators=(',',':')).encode()).hexdigest()
def jl(p):return [json.loads(l) for l in p.read_text().splitlines()]
def write(n,x): (O/n).write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n')
def rows(n,x):(O/n).write_text(''.join(json.dumps(z,ensure_ascii=False,separators=(',',':'))+'\n' for z in x))
a=jl(C/'assigned.jsonl');ctx=jl(C/'context409.jsonl');ids={x['bindingId'] for x in ctx};assert len(ids)==409 and len(a)==72
pins={};cache={}
def pin(p):
 p=Path(p);p=p if p.is_absolute() else ROOT/p;pins[str(p)]=sha(p);return p
for n in ['brief.md','dispatch.json','runtime-verification.json','runtime-check.json','assigned.jsonl','context409.jsonl']:pin(C/n)
for n in ['en.json','ru.json','handoff.json']:pin(ROOT/'localization/glossary/inventory-display-20261028'/n)
for p in [ROOT/'AGENTS.md',ROOT/'README.md',ROOT/'CHECKPOINT.json',Path('/Users/antonkrutov/.codex/instructions/sitefor-mods.md'),Path('/Users/antonkrutov/.codex/instructions/game-localization-prompt.md'),Path('/Users/antonkrutov/.codex/instructions/game-localization-audit-workflow.md')]:pin(p)
for n in ['COMMON','WORKFLOW','CHECKPOINT','SPECIAL-SCENES','CHARACTERS'] :pin(Path('/Users/antonkrutov/.codex/skills/vn-game-localize/references')/(n+'.md'))
for n in ['ROUTING','CHECKPOINT']:pin(Path('/Users/antonkrutov/Desktop/SiteForMods/tools/codex-skills/shared')/(n+'.md'))
base=ROOT/'localization/source/shared-source-completion-20261028/admission-v1'
direct={x['id']:x for x in jl(pin(base/'direct-context.jsonl')) if x['id'] in ids}
objs=json.loads(pin(ROOT/'assets/source-v2/objects.json').read_text());idx={x['id']:x for x in objs};assert len(idx)==len(objs)
transforms={x['object']:x for x in jl(pin(base/'context-transforms.jsonl'))}
def tree(oid):
 obj=idx[oid]
 if obj.get('tree'):
  p=pin(ROOT/'assets/source-v2'/obj['tree']);assert sha(p)==obj['treeSha256'];return json.loads(p.read_text())
 assert oid in transforms;assert transforms[oid]['rawSha256']==obj['rawSha256'];return transforms[oid]['tree']
def ref(asset,p):
 assert p['m_FileID']==0;return asset+':'+str(p['m_PathID']) if p['m_PathID'] else None
def ancestry(oid):
 asset=idx[oid]['asset'];t=tree(oid);go=ref(asset,t['m_GameObject']);out=[]
 while go:
  g=tree(go);out.append({'object':go,'name':g['m_Name'],'activeSelf':g['m_IsActive']})
  tr=[ref(asset,c['component']) for c in g['m_Component'] if idx[ref(asset,c['component'])]['type'] in ['Transform','RectTransform']];assert len(tr)==1
  f=ref(asset,tree(tr[0])['m_Father']);go=ref(asset,tree(f)['m_GameObject']) if f else None
 return out
schema=[];sc=[];protected=[]
for x in ctx:
 path=pin(x['typedLedger']['path']);ls=cache.setdefault(str(path),path.read_text().splitlines());z=json.loads(ls[x['typedLedger']['line']-1]);assert z['id']==x['bindingId'] and z['sourceValueSha256']==x['sourceValueSha256'] and z['role']==x['currentRole'];assert vh(x['source'])==x['sourceValueSha256']
 oid=x['bindingId'].split('/',1)[0] if not x['bindingId'].startswith('StreamingAssets/') else x['bindingId'].rsplit('/',1)[0]
 # serialized IDs contain / in bundle paths; split at the field pointer.
 if z['family']=='serialized-nondialogue':
  oid=x['bindingId'][:-len(z['pointer'])]; t=tree(oid);value=t
  for k in z['pointer'].strip('/').split('/'):value=value[int(k)] if isinstance(value,list) else value[k]
  assert value==x['source'];anc=ancestry(oid);asset=idx[oid]['asset'];d={'bindingId':x['bindingId'],'object':oid,'class':idx[oid].get('class'),'tree':'assets/source-v2/'+idx[oid]['tree'],'treeSha256':idx[oid]['treeSha256'],'rawSha256':idx[oid]['rawSha256'],'hierarchy':'/'.join(v['name'] for v in reversed(anc)),'activeAncestry':anc,'componentEnabled':t.get('m_Enabled')}
  if z['className']=='UnityEngine.UI.InputField':
   d['inputContract']={k:t[k] for k in ['m_Text','m_TextComponent','m_Placeholder','m_ContentType','m_InputType','m_CharacterValidation','m_LineType','m_CharacterLimit','m_OnEndEdit','m_OnValueChanged'] if k in t}
  if z['className']=='viperOSK.OSK_Keyboard_TFOL':d['keyboardContract']={k:t[k] for k in ['generateOnStart','output','layout','specialKeys','shift','acceptPhysicalKeyboard','acceptGamePadInput','onSwitchLayoutsKeyPressed','rascalKey','doneKey','cursorLKey','cursorRKey'] if k in t}
  if '/KeyName' in d['hierarchy']:
   parent=anc[1]['object'];g=tree(parent)
   keys=[ref(asset,v['component']) for v in g['m_Component'] if idx[ref(asset,v['component'])].get('class')=='viperOSK.OSK_Key_TFOL'];assert len(keys)==1
   kt=tree(keys[0]);assert ref(asset,kt['keyName'])==oid;d['keyComponent']={'object':keys[0],'tree':'assets/source-v2/'+idx[keys[0]]['tree'],'treeSha256':idx[keys[0]]['treeSha256'],'contract':kt}
  schema.append(d)
 else:d={'bindingId':x['bindingId'],'bgdatabase':z}
 if x['bindingId'] in {u['bindingId'] for u in a}:sc.append({'assigned':x,'typedSource':z,'nativeContext':d})
 else:protected.append({'bindingId':x['bindingId'],'source':x['source'],'sourceValueSha256':x['sourceValueSha256'],'currentRole':x['currentRole'],'typedLedger':x['typedLedger'],'target':None,'action':'preserve-exactly-pending-consumer-binding' if x['currentRole']=='potential-display-input-seed' else 'preserve-exactly','missingPredicate':'Prove this input seed reaches a player-visible initial value or is replaced before display; identify writer, entered-value/submit semantics and any independent placeholder alias. No exclusion from invisibility or default-name assumptions.' if x['currentRole']=='potential-display-input-seed' else None})
rows('source-context.jsonl',sc);rows('native-component-schemas.jsonl',schema);rows('protected-controls.jsonl',protected)
write('input-pins.json',pins)
print('source-context',len(sc),'native schemas',len(schema),'protected/potential',len(protected),'pins',len(pins))
print('KEY CONTRACTS')
for s in schema:
 if s['bindingId'] in {u['bindingId'] for u in a} and (s.get('keyComponent') or s.get('keyboardContract')): print(json.dumps(s,ensure_ascii=False,separators=(',',':')))
print('POTENTIAL GROUPS')
g=collections.Counter((s['class'],s['hierarchy'].split('/')[-2]+'/'+s['hierarchy'].split('/')[-1],json.dumps(s.get('inputContract'),sort_keys=True)) for s in schema if s['bindingId'] not in {u['bindingId'] for u in a} and s['class']=='UnityEngine.UI.InputField')
for k,v in g.items():print(v,k)
