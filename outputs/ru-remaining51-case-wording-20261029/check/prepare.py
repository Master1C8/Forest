"""Bind explicitly authored wording; never generate translations or semantic verdicts."""
import json,hashlib,pathlib,re,copy
ROOT=pathlib.Path('/Users/antonkrutov/Desktop/Forest');CHECK=ROOT/'outputs/ru-remaining51-case-wording-20261029/check';OUT=ROOT/'localization/supplemental-ui/20261029-remaining-case51'
def sha(p):return hashlib.sha256(pathlib.Path(p).read_bytes()).hexdigest()
def digest(v):return hashlib.sha256(json.dumps(v,ensure_ascii=False).encode()).hexdigest()
def read(p):return json.loads((ROOT/p).read_text())
def jsonl(p):return [json.loads(l) for l in (ROOT/p).open()]
def put(name,obj):
 p=OUT/name
 if p.exists():raise RuntimeError('Refusing overwrite '+str(p))
 p.write_text(json.dumps(obj,ensure_ascii=False,indent=2)+'\n')
def lines(name,rows):
 p=OUT/name
 if p.exists():raise RuntimeError('Refusing overwrite '+str(p))
 p.write_text(''.join(json.dumps(r,ensure_ascii=False)+'\n' for r in rows))
A=jsonl('outputs/ru-remaining51-case-wording-20261029/check/assigned51.jsonl');assert len(A)==51 and len({x['id'] for x in A})==51
assert all(digest(x['source'])==x['sourceValueSha256'] for x in A)
B='localization/source/shared-source-completion-20261028/';AD=B+'admission-v1/'
cellpath='localization/source/bgdatabase-complete-values-20261027/verified/cells.jsonl';cells=jsonl(cellpath);byid={x['id']:(n+1,x) for n,x in enumerate(cells)}
def cellgroup(sheet,row):return [{'line':n+1,'cell':r} for n,r in enumerate(cells) if r['sheet']==sheet and r['rowId']==row]
def get(group,key):return next(x['cell']['source'] for x in group if x['cell']['field']==key)
methods={}
for p in [B+'evidence/database-consumer-bodies.jsonl',B+'evidence/ui-consumer-bodies.jsonl',AD+'phase144/producer-bodies.jsonl',AD+'phase144/receiver-bodies.jsonl',AD+'phase146/receiver-bodies.jsonl']:
 for n,r in enumerate(jsonl(p),1):methods.setdefault(r['method'],[]).append({'path':p,'line':n,'fileSha256':sha(ROOT/p),'body':r})
compiled=jsonl('outputs/pause-inventory-bio-completion-20261028/managed-index/literals.jsonl');lit={('il:Assembly-CSharp.dll/'+r['method']+'/IL_'+format(r['offset'],'04x')):(n+1,r) for n,r in enumerate(compiled)}
roster=jsonl(B+'adventure-source/roster.jsonl');adv={r['id']:r for r in roster}
roles={}
for p in [AD+'phase144/compiled-role-decisions.json',AD+'phase146/compiled-role-decisions.json']:
 for r in read(p)['decisions']:roles[r['id']]={'path':p,'decision':r}
reusebase='localization/supplemental-ui/20261029-chapter-gallery-case/';accepted=read(reusebase+'ru.acceptance.json');assert sha(ROOT/reusebase/'ru.edited.jsonl')==accepted['targetSha256']
for v in accepted['evidence'].values():assert sha(ROOT/reusebase/v['file'])==v['sha256']
acceptedrows={r['id']:r for r in jsonl(reusebase+'ru.edited.jsonl')}
pre='localization/previews/ru-20261029-chapter-gallery-02/';build=read(pre+'build.json');code=read(pre+'chapter-gallery-code-readback.json');codeby={r['method']:r for r in code['inventory']};assert code['wholeMethodInventoryReadback'] and code['allOriginalBodiesRestored']
contexts=[];preserve=[];selectedbody=[]
for i,a in enumerate(A):
 c=copy.deepcopy(a);c['ordinal']=i;c['sourceUtf8Sha256']=hashlib.sha256(a['source'].encode()).hexdigest();c['sourceState']='stored-nonempty';c['runtime']='not-run';c['sourceGateAccepted']=False
 c['protectedControls']={'markup':re.findall(r'<[^>]+>|\[pic=\d+\]',a['source']),'placeholders':re.findall(r'\{\d+\}',a['source']),'LF':a['source'].count('\n'),'trailingWhitespace':re.search(r'\s*$',a['source']).group()}
 if i<17:
  n,cell=byid[a['id']];assert cell['source']==a['source'] and cell['sourceSpan']==a['sourceSpan']
  g=cellgroup('ActorGossipGreeting',a['rowId']);actor=cellgroup('Actor',get(g,'actor'));portrait=cellgroup('Portrait',get(g,'gossip_portrait'));pa=cellgroup('Actor',get(portrait,'actor'))
  c['BGContext']={'cellsFile':cellpath,'selectedCellLine':n,'greetingRow':g,'actorRow':actor,'portraitRow':portrait,'portraitActorRow':pa,'actorName':get(actor,'name'),'portraitName':get(portrait,'name'),'portraitActorName':get(pa,'name'),'groupIdentity':get(g,'name'),'sameActorGroupIndices':[r['rowIndex'] for r in cells if r['sheet']=='ActorGossipGreeting' and r['field']=='actor' and r['source']==get(g,'actor')],'filterContract':'GenerateGossipGreetings enumerates all rows with null predicate/comparison, groups by actual actor.dbName. ChooseGreetingText cycles (lastIndex+1)%Count for targetActorDbName; initial lastIndex=-1. No row-local condition field; actor availability outside this method is not inferred.','alignmentRight':get(g,'align_right'),'sourceAnomaly':'Claire actor selection with Violet portrait; preserve group and portrait, no actor reassignment' if i==12 else None}
  c['fontRoleConstraint']='GossipUI left/right greetingAnimator child TextMeshProUGUI text; preserve line count and align_right. Final font allocation/fitting is unverified; no font edits. Preserve mouse3324/material3/atlas245 fictional mapping.'
  c['producerEvidence']=[{'path':B+'evidence/database-consumer-bodies.jsonl','methods':[m for m in methods if 'GenerateGossipGreetings' in m]},{'path':'outputs/pause-inventory-bio-completion-20261028/consumer-bodies/GossipUI.il','method':'ChooseGreetingText','spans':'IL_0000..IL_007d'},{'path':B+'evidence/ui-consumer-bodies.jsonl','method':'System.Void TheForestOfLove.GossipUI::UpdateGreetingText(System.String,System.Boolean)','spans':'IL_0000..IL_0068'}]
  for x in g:
   if x['cell']['field']!='greeting_text_test':preserve.append({'owner':a['id'],'kind':'BG-unselected-field','file':cellpath,**x})
  c['exposure']='active-static-display-consumer;live actor selection unverified'
 else:
  n,l=lit[a['id']];assert l['value']==a['source'];c['originalLiteral']={'path':'outputs/pause-inventory-bio-completion-20261028/managed-index/literals.jsonl','line':n,'method':l['method'],'offset':l['offset'],'index':l['index']};c['originalAssemblySha256']='46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
  c['retainedRoleDecision']=roles.get(a['id']);c['AdventureRecord']=adv.get(a['id']);c['fontRoleConstraint']='Existing consumer font/TMP resource and layout remain unchanged; text-stage contract only. SIZE=22 ornamental initials and SIZE=10 status descriptor stay exact. Native fitting and Cyrillic glyph/resource binding need later owning technical checks.' if i!=31 else 'Minigame hitCounterLabelContainer children UnityEngine.UI.Text; preserve numeric Int32.ToString and source font/size. No TMP assumption; Cyrillic rendering/fitting unverified.'
  if l['method'] in methods:
   c['completeProducerReferences']=[{k:v for k,v in x.items() if k!='body'} for x in methods[l['method']]]
   for x in methods[l['method']]:
    if x['path'] not in [r['path'] for r in selectedbody if r['method']==l['method']]:selectedbody.append({'method':l['method'],**x})
  else:c['completeProducerReferences']=[{'path':B+'adventure-source/Adventure.il' if i>=33 else B+'adventure-source/InstancedStoryOverlayUI.il' if i in [23,24] else B+'evidence/ui-consumer-bodies.jsonl','method':l['method']}]
  c['savedBuild02']={'build':pre+'build.json','readback':pre+'chapter-gallery-code-readback.json','methodEvidence':codeby.get(l['method']),'assemblyTargetSha256':code['targetSha256'],'interpretation':'Three exact accepted operands already projected; not missing.' if i in [19,20,21] else 'No wording/application claim from string membership; reuse unchanged method identity evidence only. Future parent application must bind exact operand before/after.'}
  c['exposure']='active-static-display-producer;event/branch/live exposure unverified'
  if i in [19,20,21]:
   old=acceptedrows[a['id']];assert old['source']==a['source'];c['reuseEvidence']={'acceptance':reusebase+'ru.acceptance.json','acceptedTargetSha256':accepted['targetSha256'],'sourceRawUtf8Sha256':old['sourceSha256'],'targetRawUtf8Sha256':old['targetSha256'],'evidence':accepted['evidence']}
 contexts.append(c)
# Copy immutable complete evidence only inside this task; no inspection/extraction rerun.
lines('producer-evidence.jsonl',selectedbody)
lines('source-context.jsonl',contexts)
for r in jsonl(B+'adventure-source/preserve-exactly.jsonl'):preserve.append({'kind':'Adventure-protected-identity',**r})
# Preserve all non-display selected producer operands/instructions, not merely token membership.
selected={(x['originalLiteral']['method'],x['originalLiteral']['offset']) for x in contexts if 'originalLiteral' in x}
for m in {x['originalLiteral']['method'] for x in contexts if 'originalLiteral' in x}:
 if m in methods:
  x=methods[m][0]
  for ins in x['body']['instructions']:
   if (m,ins['offset']) not in selected:preserve.append({'kind':'unselected-producer-instruction','method':m,'path':x['path'],'line':x['line'],'instruction':ins})
for c in contexts:preserve.append({'kind':'selected-source-contract','id':c['id'],'source':c['source'],'sourceValueSha256':c['sourceValueSha256'],'protectedControls':c['protectedControls']})
lines('preserve-exactly.jsonl',preserve)
paths=[cellpath,'localization/source/bgdatabase-complete-values-20261027/readback-validation.json','outputs/pause-inventory-bio-completion-20261028/managed-index/literals.jsonl',B+'adventure-source/verification.json',B+'adventure-source/roster.jsonl',B+'adventure-source/Adventure.il',B+'adventure-source/InstancedStoryOverlayUI.il',B+'adventure-source/OverworldAllInOneNotification.il',B+'adventure-source/notification-dispatch.il',AD+'consumer-matrix.json',AD+'phase136/dynamic-consumers.il',AD+'phase136/act3-greeting-producer.il',AD+'phase136/fast-travel-arguments.il',AD+'phase136/fast-travel-caller.il','outputs/pause-inventory-bio-completion-20261028/consumer-bodies/GossipUI.il',pre+'build.json',pre+'chapter-gallery-code-readback.json','localization/ru-assets/dialogue.ru.jsonl','localization/glossary/inventory-display-20261028/en.json','localization/glossary/inventory-display-20261028/ru.json','localization/glossary/inventory-display-20261028/handoff.json',reusebase+'ru.edited.jsonl',reusebase+'ru.acceptance.json']
paths+=list({x['path'] for refs in methods.values() for x in refs})+[reusebase+x['file'] for x in accepted['evidence'].values()]
paths+=['outputs/ru-remaining51-case-wording-20261029/check/'+p for p in ['assigned51.jsonl','brief.md','dispatch.json','runtime-verification.json','runtime-check.json']]
manuals=['/Users/antonkrutov/.codex/instructions/sitefor-mods.md','/Users/antonkrutov/.codex/instructions/game-localization-prompt.md','/Users/antonkrutov/.codex/instructions/game-localization-audit-workflow.md']+[f'/Users/antonkrutov/.codex/skills/vn-game-localize/references/{n}.md' for n in ['COMMON','WORKFLOW','CHECKPOINT','SPECIAL-SCENES','CHARACTERS','ROUTING']]
pins={p:sha(ROOT/p) for p in sorted(set(paths))};pins.update({p:sha(p) for p in manuals});assert pins['localization/ru-assets/dialogue.ru.jsonl']=='462c91c948c3564225aeaf71da972c7426e5b5c068eaca7bab64e22e70e36587'
put('input-pins.json',pins)
put('process-binding.json',{'scope':'The Forest of Love 0.45 / ru / standard / finite special-case preparation','stage':'translate-edit bounded preparatory case wording; ordinary entry remains forbidden','canonicalProcessBinding':read('CHECKPOINT.json')['processBinding'],'referencesCurrentSha256':{p:pins[p] for p in manuals},'editorial':'Immediate author edit, deterministic preflight, complete self semantic source-to-target audit and separate native read; parent independent review pending','writes':'Only this task check/ and new supplemental-ui/20261029-remaining-case51/; no Git/root changes','stateCoverage':{'assignedActiveStored':51,'assignedAbsent':0,'greetingDormantSiblingPreserved':17,'unassignedAbsentStates':'preserve; no synthesized targets'},'gatePromotion':False})
print('Prepared contexts:',len(contexts),'preserve records:',len(preserve),'input pins:',len(pins))
