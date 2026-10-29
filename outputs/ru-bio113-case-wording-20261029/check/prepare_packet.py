"""Deterministic context assembly only; Russian wording is authored separately."""
import collections, hashlib, json
from pathlib import Path
ROOT=Path('/Users/antonkrutov/Desktop/Forest')
CHECK=ROOT/'outputs/ru-bio113-case-wording-20261029/check'
OUT=ROOT/'localization/supplemental-ui/20261029-bio-case113'
def sha(p): return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def load(p): return json.loads((ROOT/p).read_text())
def lines(p): return [json.loads(s) for s in (ROOT/p).read_text().splitlines()]
def write(p,x): p.write_text(json.dumps(x,ensure_ascii=False,indent=2)+'\n')
def jl(p,rs): p.write_text(''.join(json.dumps(x,ensure_ascii=False,separators=(',',':'))+'\n' for x in rs))
assert json.loads((CHECK/'runtime-check.json').read_text())['verified']
assert not OUT.exists() or not any(OUT.iterdir())
OUT.mkdir(exist_ok=True)
a=lines('outputs/ru-bio113-case-wording-20261029/check/assigned.jsonl');assert len(a)==len({x['bindingId'] for x in a})==113
cp='localization/source/bgdatabase-complete-values-20261027/verified/cells.jsonl';cs=lines(cp);byid={x['id']:x for x in cs};rows=collections.defaultdict(dict);cellrows=collections.defaultdict(dict)
for n,c in enumerate(cs,1):
 rows[(c['sheet'],c['rowId'])][c['field']]=c['source'];cellrows[(c['sheet'],c['rowId'])][c['field']]={**c,'ledgerLine':n}
actors={k[1]:v for k,v in rows.items() if k[0]=='Actor'}
controls=load('localization/source/bgdatabase-20261027/bio-keywords/readback/bio-controls.json')
member=load('localization/source/bgdatabase-20261027/bio-note-kink/readback/bio-control-membership.json')
uip='localization/source/pause-inventory-bio-omissions-20261028/ui-bindings.json';ui={x['id']:x for x in load(uip)['texts']}
objs={x['id']:x for x in load('assets/source-v2/objects.json') if x['id'] in ['sharedassets2.assets:11976','sharedassets2.assets:12362']}
ledgercache={}
context=[]
for ordinal,x in enumerate(a,1):
 path=x['typedLedger']['path']
 if path not in ledgercache:ledgercache[path]=lines(path)
 typed=ledgercache[path][x['typedLedger']['line']-1]
 assert typed['id']==x['bindingId'] and typed['source']==x['source'] and typed['sourceValueSha256']==x['sourceValueSha256']
 assert hashlib.sha256(json.dumps(x['source'],ensure_ascii=False,separators=(',',':')).encode()).hexdigest()==x['sourceValueSha256']
 y={**x,'ordinal':ordinal,'typedRow':typed,'contextLedger':cp,'sourceContextRead':'author-read; see coverage-read-evidence.json'}
 if x['bindingId'] in byid:
  c=byid[x['bindingId']];assert c['source']==x['source'];k=(c['sheet'],c['rowId']);v=rows[k];uses=[]
  for j,w in rows.items():
   if j[0] not in ['BioDetail','BioNote','BioKink']:continue
   for f,val in w.items():
    if val==c['rowId']:
     uses.append({'sheet':j[0],'rowId':j[1],'slotField':f,'actor':actors[w['actor']], 'row':w,'relationCell':cellrows[j][f], 'rowCells':list(cellrows[j].values()),'actorIdentityCells':list(cellrows[('Actor',w['actor'])].values()),'displayPredicate':'Detail: introduced attempts unlock; show if known. Note/Kink: unlocked AND NOT hidden; otherwise ???. Selection/cache/tag priority unchanged.'})
  y.update(keywordRowIndex=c['rowIndex'],displayCell=c,identityCells=[cellrows[k][f] for f in ['name','savekey','plugin_db_trigger_name']],uses=uses,triggerContexts=[z for z in controls if z.get('keywordRowId')==c['rowId']],triggerMembership=[z for z in member if z.get('keywordRowId')==c['rowId']],currentThreeTableMembership='present' if uses else 'no-slot; not proof of global nonuse',producerEvidence=['localization/source/bgdatabase-20261027/bio-detail/keyword-callback.il','localization/source/bgdatabase-20261027/bio-detail/bio-values.il','localization/source/bgdatabase-20261027/bio-note-kink/critter-output.il'])
 else:
  u=ui[x['bindingId']];rid=12362 if u['pathId']==14193 else 11976
  y.update(ui=u,rectBinding=objs['sharedassets2.assets:'+str(rid)],rectBounds=None,rectUncertainty='The exported objects ledger binds the RectTransform and raw hash; its numeric bounds were not exported. No original-game access in this lane; technical owner must resolve dimensions and actual rendered fit.',producerEvidence=[uip,'localization/source/pause-inventory-bio-omissions-20261028/label-classification.json'])
 context.append(y)
jl(OUT/'source-context.jsonl',context)
# 94 runtime masks + 12 unassigned prose/identity states remain context, not authored IDs.
bindings=lines('localization/case-decisions/ru-20261029/source-bindings.jsonl');assigned={x['bindingId'] for x in a}
protected=[x for x in bindings if x.get('caseId')=='hidden-identity-and-unlock-masks' and x.get('bindingId',x.get('id')) not in assigned]
assert len(protected)==106,(len(protected),list(bindings[0]))
jl(OUT/'protected-case-context.jsonl',protected)
# Preserve ALL relevant database technical states, not only text-shaped keys.
technical=[c for c in cs if c['sheet'] in ['Actor','Tag','BioDetail','BioNote','BioKink'] or (c['sheet']=='BioKeyword' and c['field']!='bio_text')]
jl(OUT/'protected-controls.jsonl',technical)
inputs=[cp,'outputs/ru-bio113-case-wording-20261029/check/assigned.jsonl','outputs/ru-bio113-case-wording-20261029/check/dispatch.json','outputs/ru-bio113-case-wording-20261029/check/runtime-verification.json','outputs/ru-bio113-case-wording-20261029/check/runtime-check.json',uip,'assets/source-v2/objects.json','assets/source-v2/source-files.json','localization/glossary/inventory-display-20261028/en.json','localization/glossary/inventory-display-20261028/ru.json','localization/glossary/inventory-display-20261028/handoff.json','localization/case-decisions/ru-20261029/decisions.jsonl','localization/case-decisions/ru-20261029/source-bindings.jsonl','localization/source/bgdatabase-20261027/bio-keywords/readback/bio-controls.json','localization/source/bgdatabase-20261027/bio-note-kink/readback/bio-control-membership.json','localization/source/bgdatabase-20261027/bio-note-kink/readback/slot-bindings.json','localization/source/bgdatabase-complete-values-20261027/readback-validation.json','assets/source-v2/trees/57009919ee-sharedassets0.assets-3336.json','localization/supplemental-ui/20261029-remaining-case51/process-binding.json']+list(ledgercache)
for folder in ['bio-detail','bio-note-kink','bio-keywords']:
 inputs.append('localization/source/bgdatabase-20261027/'+folder+'/ADAPTER.md')
inputs+=['localization/source/bgdatabase-20261027/bio-detail/keyword-callback.il','localization/source/bgdatabase-20261027/bio-detail/bio-values.il','localization/source/bgdatabase-20261027/bio-note-kink/critter-output.il','localization/source/pause-inventory-bio-omissions-20261028/label-classification.json']
write(OUT/'input-pins.json',{p:sha(ROOT/p) for p in sorted(set(inputs))})
write(OUT/'process-binding.json',{'stage':'translate-edit: finite necessary special-case wording preparation','canonicalBinding':'README.md stage table at line1300; read-only','reusedBinding':'localization/supplemental-ui/20261029-remaining-case51/process-binding.json','referenceHashes':{p:sha(p) for p in ['/Users/antonkrutov/.codex/instructions/sitefor-mods.md','/Users/antonkrutov/.codex/instructions/game-localization-prompt.md','/Users/antonkrutov/.codex/instructions/game-localization-audit-workflow.md']},'locale':'ru','game':'The Forest of Love 0.45','type':'standard','independentReview':'pending','gatePromotion':False})
print({'context':len(context),'caseContext':len(protected),'technicalStates':len(technical),'output':str(OUT)})
