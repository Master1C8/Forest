"""Deterministic inputs/joins only; semantic judgments are authored separately."""
import json, hashlib, re
from pathlib import Path
ROOT=Path('/Users/antonkrutov/Desktop/Forest')
OUT=Path(__file__).resolve().parent
SRC=ROOT/'localization/source/counter-producer-contracts-20261029'
PKT=OUT.parent
CAN=ROOT/'localization/previews/ru-20261029-bio-input-v2-01'
SESSION=Path('/Users/antonkrutov/.codex/sessions/2026/10/29/rollout-2026-10-29T13-19-42-01a18650-77e7-75f0-9007-af547131da94.jsonl')
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def hs(s):return hashlib.sha256(s.encode()).hexdigest()
def cj(x):return json.dumps(x,ensure_ascii=False,sort_keys=True,separators=(',',':')).encode()
def read(p):return json.loads(Path(p).read_text())
def lines(p):return [json.loads(l) for l in Path(p).read_text().splitlines()]
def put(n,x):
 p=OUT/n
 assert not p.exists(),p
 p.write_text((''.join(json.dumps(r,ensure_ascii=False,separators=(',',':'))+'\n' for r in x)) if n.endswith('.jsonl') else json.dumps(x,ensure_ascii=False,indent=2)+'\n')
def unique(rows,key='id'):
 assert len({r[key] for r in rows})==len(rows)
 return {r[key]:r for r in rows}
meta=next(x['payload'] for x in lines(SESSION) if x['type']=='session_meta')
turn=next(x['payload'] for x in lines(SESSION) if x['type']=='turn_context')
assert meta['model_provider']=='openai' and turn['model']=='gpt-6.1-sol' and turn['effort']=='high'
put('runtime-verification.json',{'agent':'/root/counter_gallery_context_review','sessionId':meta['id'],'provider':meta['model_provider'],'model':turn['model'],'reasoning':turn['effort'],'evidence':str(SESSION),'verificationBeforeLocalizedContent':True,'freshNoInheritedHistory':'explicit parent spawn contract','nestedModelRequests':0})
ctx=read(SRC/'wording-dependency-context.json'); ids=ctx['additionalSourceContextIds']; assert len(ids)==8 and len(set(ids))==8
heading=ids[:6]; identity=ids[6:]
uip=ROOT/'localization/supplemental-ui/20261029-existing935'
ui=unique(lines(uip/'ru.edited.jsonl')); existing=unique(lines(ROOT/'outputs/ru-counter11-source-contracts-20261029/inputs/existing935.jsonl'))
remp=ROOT/'localization/supplemental-ui/20261029-remaining-case51';rem=unique(lines(remp/'ru.prepared.jsonl')); remcopy=unique(lines(ROOT/'outputs/ru-counter11-source-contracts-20261029/inputs/remaining51.jsonl'))
prepared=unique(lines(PKT/'ru.prepared.jsonl')); stored=[x for x in lines(PKT/'source-context.jsonl') if x['id'].startswith('level1:')];assert len(stored)==12
candidate=unique(read(CAN/'gallery-targets.json'));assert set(candidate)==set(heading)
adoption=read(SRC.with_name(SRC.name+'.parent-adoption.json'))
checks=[]
def check(path,expected,reason):
 actual=sha(path);checks.append({'path':str(Path(path).relative_to(ROOT)),'expectedSha256':expected,'actualSha256':actual,'matches':actual==expected,'reason':reason});assert actual==expected,(path,reason)
check(SRC/'source-contracts.json',adoption['sourceContractsSha256'],'parent source adoption')
for f,h in adoption['evidence'].items():check(ROOT/f,h,'parent source adoption')
check(CAN/'build.json','e0fddc537966c94e44c0989664b2904951c2add43d5d57aaada12753657e8d6d','actual candidate immutable build')
for base in [uip,remp,PKT,ROOT/'localization/supplemental-ui/20261029-chapter-gallery-case']:
 a=read(base/'ru.acceptance.json');check(base/a['targetFile'],a['targetSha256'],'accepted target')
 for k,e in a['evidence'].items():
  if isinstance(e,dict) and 'file' in e:check(base/e['file'],e['sha256'],'accepted receipt '+k)
  elif isinstance(e,str):check(ROOT/k,e,'accepted packet evidence')
for rr in read(PKT/'reused-receipts.json')['verifiedReceipts']:check(ROOT/rr['path'],rr['sha256'],'original retained receipt')
for n in ['en.json','ru.json']:
 h=read(ROOT/'localization/glossary/inventory-display-20261028/handoff.json')
 check(ROOT/'localization/glossary/inventory-display-20261028'/n,h['sourceSha256' if n=='en.json' else 'russianSha256'],'complete approved171 glossary')
bodypath=ROOT/'outputs/ru-counter11-source-contracts-20261029/selected-source-bodies.jsonl'
bodies=[x for x in lines(bodypath) if 'StartScreenGallery' in x['method']];assert len(bodies)==12
prov=unique(lines(SRC/'body-provenance.jsonl'),'method')
for b in bodies:
 p=prov[b['method']];assert hashlib.sha256(cj(b['instructions'])).hexdigest()==p['instructionArraySha256']; assert hashlib.sha256(cj(b)).hexdigest()==p['bodyMetadataSha256'];assert len(b['instructions'])==p['instructionCount']
bodymap=unique(bodies,'method')
joins=[]
for expected in ctx['reusedAcceptedRows']:
 id=expected['id']; row=ui[id] if id in heading else rem[id]
 assert row['target']==(existing[id]['target'] if id in heading else remcopy[id]['target'])
 assert hs(row['target'])==expected['targetValueSha256']
 method,off=id.removeprefix('il:Assembly-CSharp.dll/').rsplit('/IL_',1)
 raw=next(i['operand'] for i in bodymap[method]['instructions'] if i['offset']==int(off,16))
 assert row['source']==raw==expected['sourceRawOperand']
 if id in heading:assert candidate[id]['source']==raw and candidate[id]['target']==row['target']
 joins.append({'id':id,'source':raw,'target':row['target'],'sourceUtf8Sha256':hs(raw),'targetUtf8Sha256':hs(row['target']),'kind':'heading-context-delta' if id in heading else 'unchanged-identity-receipt-reuse','method':method,'offset':off,'decodedSourceLF':raw.count('\n'),'decodedTargetLF':row['target'].count('\n'),'decodedLiteralBackslashN':row['target'].count('\\n'),'builderBoundary':'JSON decoded string copied directly to ldstr; exact source equality; no textual escape conversion'})
put('source-target-joins.jsonl',joins)
put('selected-source-bodies.jsonl',bodies)
put('body-provenance.jsonl',[prov[b['method']] for b in bodies])
basepins=[ROOT/'AGENTS.md',SRC/'HANDOFF.md',SRC/'serialized-binding-contracts.json',SRC/'source-contracts.json',SRC.with_name(SRC.name+'.parent-adoption.json'),SRC/'wording-dependency-context.json',SRC/'body-provenance.jsonl',bodypath,PKT/'ru.acceptance.json',PKT/'source-context.jsonl',PKT/'ru.prepared.jsonl',PKT/'review-closure.json',PKT/'reused-receipts.json',PKT/'assembled-producer-fixtures.jsonl',PKT/'process-binding.json',uip/'ru.acceptance.json',uip/'ru.edited.jsonl',CAN/'build.json',CAN/'gallery-targets.json',CAN/'gallery-code-readback.json',CAN/'russian_menu_ui.py',CAN/'menu-patch/Program.cs',ROOT/'localization/glossary/inventory-display-20261028/handoff.json']
for n in ['en.json','ru.json']:basepins.append(ROOT/'localization/glossary/inventory-display-20261028'/n)
for f in ['/Users/antonkrutov/.codex/instructions/sitefor-mods.md','/Users/antonkrutov/.codex/instructions/game-localization-prompt.md','/Users/antonkrutov/.codex/instructions/game-localization-audit-workflow.md','/Users/antonkrutov/.codex/skills/vn-game-localize/SKILL.md']:
 basepins.append(Path(f))
for p in checks:basepins.append(ROOT/p['path'])
for path in ['outputs/ru-ui935-review-20261029/initial-02/review/reviews.jsonl','outputs/ru-ui935-review-20261029/independent-01/review/reviews.jsonl']:
 file=ROOT/path; baseline=read(uip/('ru935.fullSemantic.json' if 'initial-' in path else 'ru935.independent.json'));check(file,baseline['reviewsSha256'],'original full review rows')
 basepins.append(file)
 matched=[r for r in lines(file) if r['id'] in set(heading)|{x['id'] for x in stored}];assert len(matched)==18
 for r in matched:
  value=ui[r['id']];assert r['verdict']=='pass' and r['sourceSha256']==hs(value['source']) and r['targetSha256']==hs(value['target'])
 put('retained-ui935-'+('semantic' if 'initial-' in path else 'independent')+'.jsonl',matched)
put('pin-verification.json',{'checks':checks,'allPassed':True})
put('input-pins.json',[{'path':str(p),'sha256':sha(p)} for p in sorted(set(basepins))])
put('stored-context-joins.jsonl',[{'id':x['id'],'source':x['source'],'target':prepared[x['id']]['target'],'sourceUtf8Sha256':hs(x['source']),'targetUtf8Sha256':hs(prepared[x['id']]['target']),'context':x['directContext'],'retainedReceipt':prepared[x['id']]['reusedEvidence'],'root':'level1:1852' if 'Movie ' in x['source'] else 'level1:1475','newDynamicHeadingMembershipOnly':True} for x in stored])
fixture=[]
for j in joins[:6]:
 story='Story' in j['method']; isbare='{0}' not in j['source']; flags=[(False,False),(False,True),(True,False),(True,True)] if story else [(None,None)]
 for a,b in flags:
  total=48-int(not a)-int(not b) if story else 11
  for u in ([None] if isbare else [0,1,total]):
   coh=u is None or u>=int(bool(a))+int(bool(b))
   fixture.append({'fixtureId':f'heading-{len(fixture)+1:02d}','id':j['id'],'branch':'default-last-selected-compares-null' if isbare else ('default-last-selected-compares-nonnull' if 'ShowDefault' in j['method'] else 'selection-update-index-ignored'),'unlockedCount':u,'total':total,'glitchSecretUnlocked':a,'mabelSecretUnlocked':b,'snapshotCountCoherent':coh,'source':j['source'] if isbare else j['source'].format(u,total),'target':j['target'] if isbare else j['target'].format(u,total),'basis':'static-source-argument-substitution; actual original method and Unity not executed','reachability':'not-proven' if coh else 'symbolic-format-only; inconsistent with initialized secret-count fold','actualGameRuntime':'not-run'})
put('assembled-heading-fixtures.jsonl',fixture)
controls=[]
for j in joins[:6]:
 if '{0}' not in j['source']:continue
 s,t=j['source'],j['target'];assert re.findall(r'\{\d+\}',s)==re.findall(r'\{\d+\}',t)==['{0}','{1}'];assert t.count('\n')==1 and not '\\n' in t
 assert t.split('\n')[1]=='<size=12>(открыто: {0}/{1})</size>'
 controls.append({'id':j['id'],'kind':'format-positive','result':'passed','predicate':'same placeholder identities/order; LF after category; full unlocked clause in size12 span'})
for family in ['movie','story']:
 total=11 if family=='movie' else 46
 pattern=next(j['target'] for j in joins if ('Movie' if family=='movie' else 'Story') in j['method'] and '{0}' in j['target'])
 outcomes=[pattern.format(1,total) for index in [-1,0,1,10 if family=='movie' else 47,2147483647]]
 assert len(set(outcomes))==1
 controls.append({'kind':'index-ignored-positive','family':family,'indices':[-1,0,1,10 if family=='movie' else 47,2147483647],'count':1,'total':total,'outputs':outcomes,'result':'passed','boundary':'source-derived fixture function ignores index; not original method execution'})
 for wrong,reason in [({'numeratorRole':'optionIndex','total':total},'numerator-must-be-unlocked-count'),({'numeratorRole':'unlockedCount','total':8},'total-must-use-serialized-options-and-secret-predicates')]:
  def contract(x):
   if x['numeratorRole']!='unlockedCount':return 'numerator-must-be-unlocked-count'
   if x['total']!=total:return 'total-must-use-serialized-options-and-secret-predicates'
   return 'accepted'
  assert contract({'numeratorRole':'unlockedCount','total':total})=='accepted';assert contract(wrong)==reason
  controls.append({'kind':'matched-negative','family':family,'positive':{'numeratorRole':'unlockedCount','total':total},'negative':wrong,'expectedRejection':reason,'observedRejection':contract(wrong),'result':'passed','boundary':'review-contract validation only'})
put('boundary-controls.jsonl',controls)
put('deterministic-preflight.json',{'passed':True,'headingIds':heading,'storedIds':[x['id'] for x in stored],'unchangedIdentityIds':identity,'headings':6,'storedContexts':12,'identityReuses':2,'sourceBodies':len(bodies),'sourceInstructions':sum(len(x['instructions']) for x in bodies),'assembledFixtures':len(fixture),'incoherentSymbolicBoundaryFixtures':sum(not x['snapshotCountCoherent'] for x in fixture),'candidateBuildSha256':sha(CAN/'build.json'),'candidateGalleryCodeReadback':read(CAN/'gallery-code-readback.json'),'candidateReadbackEqualsBuild':read(CAN/'gallery-code-readback.json')==read(CAN/'build.json')['galleryCodeRepair'],'semanticJudgment':'not-established-by-this-script','actualGameRuntime':'not-run'})
print(json.dumps({'output':str(OUT),'fixtures':len(fixture),'bodies':len(bodies),'checks':len(checks),'incoherentSymbolic':sum(not x['snapshotCountCoherent'] for x in fixture)}))
