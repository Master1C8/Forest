"""Static packet validation. Does not run, patch, or emulate the actual Unity game."""
import collections,copy,hashlib,json,re
from pathlib import Path
ROOT=Path('/Users/antonkrutov/Desktop/Forest');OUT=ROOT/'localization/supplemental-ui/20261029-bio-case113'
def read(p):return json.loads(Path(p).read_text())
def jl(p):return [json.loads(x) for x in Path(p).read_text().splitlines()]
def sha(p):return hashlib.sha256(Path(p).read_bytes()).hexdigest()
def vh(x):return hashlib.sha256(json.dumps(x,ensure_ascii=False,separators=(',',':')).encode()).hexdigest()
def require(p,reason):
 if not p:raise ValueError(reason)
a=jl(ROOT/'outputs/ru-bio113-case-wording-20261029/check/assigned.jsonl'); cs=jl(ROOT/'localization/source/bgdatabase-complete-values-20261027/verified/cells.jsonl');byid={x['id']:x for x in cs};rows=collections.defaultdict(dict);cellrows=collections.defaultdict(dict)
for n,c in enumerate(cs,1):rows[(c['sheet'],c['rowId'])][c['field']]=c['source'];cellrows[(c['sheet'],c['rowId'])][c['field']]={**c,'ledgerLine':n}
tech=[c for c in cs if c['sheet'] in ['Actor','Tag','BioDetail','BioNote','BioKink'] or (c['sheet']=='BioKeyword' and c['field']!='bio_text')]
case=[x for x in jl(ROOT/'localization/case-decisions/ru-20261029/source-bindings.jsonl') if x['caseId']=='hidden-identity-and-unlock-masks' and x['bindingId'] not in {x['bindingId'] for x in a}]
ctrl=read(ROOT/'localization/source/bgdatabase-20261027/bio-keywords/readback/bio-controls.json');members=read(ROOT/'localization/source/bgdatabase-20261027/bio-note-kink/readback/bio-control-membership.json')
ledger_cache={}
for item in a:
 path=item['typedLedger']['path']
 if path not in ledger_cache:ledger_cache[path]=jl(ROOT/path)
ui={x['id']:x for x in read(ROOT/'localization/source/pause-inventory-bio-omissions-20261028/ui-bindings.json')['texts']}
def validate(target,context,protected,casecontext):
 require(len(target)==113 and len({x['id'] for x in target})==113,'target-id-coverage')
 require([x['id'] for x in target]==[x['bindingId'] for x in a],'target-id-order')
 require(len(context)==113 and [x['bindingId'] for x in context]==[x['bindingId'] for x in a],'context-id-coverage')
 require(protected==tech,'protected-technical-exact-equality')
 require(casecontext==case,'unassigned-case-context-exact-equality')
 for t,c,s in zip(target,context,a):
  require(t['source']==c['source']==s['source'] and t['sourceValueSha256']==c['sourceValueSha256']==s['sourceValueSha256']==vh(s['source']),'source-identity-value')
  require(t['locale']=='ru' and t['targetApplied'] is False and t['independentReview']=='pending','target-scope')
  if t['status']=='needs-source':require(t['target'] is None,'needs-source-null');continue
  require(isinstance(t['target'],str) and bool(t['target'].strip()) and '\n' not in t['target'] and '\r' not in t['target'] and '\t' not in t['target'],'target-shape')
  require(hashlib.sha256(t['target'].encode()).hexdigest()==t['targetUtf8Sha256'],'target-utf8-pin')
  require('?' not in s['source'] or re.findall(r'[?!]+',t['target'])==re.findall(r'[?!]+',s['source']),'question-exclamation-symbols')
  require(s['source']!='???' or t['target']=='???','literal-symbol-caption')
  require(s['source']=='???' or bool(re.search('[А-Яа-яЁё]',t['target'])),'target-script')
  ledger=ledger_cache[s['typedLedger']['path']][s['typedLedger']['line']-1]
  require(c['typedRow']==ledger and ledger['id']==s['bindingId'],'typed-ledger-binding')
  if s['bindingId'] in byid:
   b=byid[s['bindingId']]; k=(b['sheet'],b['rowId'])
   require(c['displayCell']==b and c['keywordRowIndex']==b['rowIndex'],'bg-display-binding')
   require(c['identityCells']==[cellrows[k][f] for f in ['name','savekey','plugin_db_trigger_name']],'keyword-identities')
   expected=[]
   for j,w in rows.items():
    if j[0] in ['BioDetail','BioNote','BioKink']:
     for f,v in w.items():
      if v==b['rowId']:expected.append((j[0],j[1],f))
   require([(u['sheet'],u['rowId'],u['slotField']) for u in c['uses']]==expected,'complete-slot-topology')
   for u in c['uses']:
    j=(u['sheet'],u['rowId']);w=rows[j]
    require(u['row']==w and u['rowCells']==list(cellrows[j].values()) and u['relationCell']==cellrows[j][u['slotField']],'source-hide-tags-slot-row')
    require(u['actor']==rows[('Actor',w['actor'])] and u['actorIdentityCells']==list(cellrows[('Actor',w['actor'])].values()),'actor-identity-join')
   require(c['triggerContexts']==[z for z in ctrl if z.get('keywordRowId')==b['rowId']],'trigger-context-join')
   require(c['triggerMembership']==[z for z in members if z.get('keywordRowId')==b['rowId']],'trigger-membership-join')
  else:require(c['ui']==ui[s['bindingId']],'heading-live-component-binding')
 return {'assigned':113,'nonNullTargets':sum(x['target'] is not None for x in target),'preparedWording':sum(x['status']=='prepared' for x in target),'preservedSymbolCaption':sum(x['status']=='prepared-preserve-symbol' for x in target),'technicalStates':len(protected),'unassignedContextStates':len(casecontext),'maskSelectors':sum(x['currentRole']=='preserve-display-symbol' for x in casecontext),'unassignedProseSelectors':sum(x['currentRole']=='display-source' for x in casecontext)}
def main():
 pins=read(OUT/'input-pins.json')
 for p,h in pins.items():require(sha(ROOT/p)==h,'input-pin:'+p)
 t=jl(OUT/'ru.prepared.jsonl');c=jl(OUT/'source-context.jsonl');p=jl(OUT/'protected-controls.jsonl');cc=jl(OUT/'protected-case-context.jsonl')
 counts=validate(t,c,p,cc);tests=[]
 def neg(name,reason,mut):
  args=copy.deepcopy([t,c,p,cc]);mut(args)
  try:validate(*args)
  except ValueError as e: require(str(e)==reason,'negative-wrong-boundary:'+name+':'+str(e));tests.append({'test':name,'expectedBoundary':reason,'observedBoundary':str(e),'pass':True});return
  raise ValueError('negative-accepted:'+name)
 neg('missing-assigned-target','target-id-coverage',lambda x:x[0].pop())
 neg('duplicate-assigned-target','target-id-coverage',lambda x:x[0].__setitem__(1,x[0][0]))
 def source_change(x):x[0][0]['source']='Changed';x[0][0]['sourceValueSha256']=vh('Changed')
 neg('changed-source-with-valid-new-hash','source-identity-value',source_change)
 def key_change(x):x[2][0]['source']='локализованный ключ'
 neg('translated-technical-value','protected-technical-exact-equality',key_change)
 neg('changed-keyword-identity-only','keyword-identities',lambda x:x[1][0]['identityCells'][0].__setitem__('source','Ремесленник'))
 neg('removed-actor-use','complete-slot-topology',lambda x:x[1][3]['uses'].pop())
 neg('hidden-slot-made-visible','source-hide-tags-slot-row',lambda x:x[1][6]['uses'][0]['row'].__setitem__('hide_in_list4',False))
 neg('wrong-actor-for-correct-caption','actor-identity-join',lambda x:x[1][0]['uses'][0]['actor'].__setitem__('name','Charlotte'))
 neg('removed-trigger-context','trigger-context-join',lambda x:x[1][0]['triggerContexts'].clear())
 neg('changed-unassigned-LF-mask','unassigned-case-context-exact-equality',lambda x:next(z for z in x[3] if z['source']=='???\n').__setitem__('source','???'))
 def symbol(x):x[0][92]['target']='Неизвестно';x[0][92]['targetUtf8Sha256']=hashlib.sha256('Неизвестно'.encode()).hexdigest()
 neg('symbol-caption-translated-valid-target-hash','question-exclamation-symbols',symbol)
 neg('heading-treated-as-disabled-art','heading-live-component-binding',lambda x:x[1][111]['ui'].__setitem__('componentEnabled',False))
 # Matching unchanged positive uses every actual assigned target after all negatives.
 positive=validate(t,c,p,cc)
 report={'status':'passed','validatedHashes':{n:sha(OUT/n) for n in ['ru.prepared.jsonl','source-context.jsonl','protected-controls.jsonl','protected-case-context.jsonl']},'boundary':'Static packet, exact source/protected data and context joins only; no reinsertion, renderer or runtime proof.','counts':counts,'inputPinsVerified':len(pins),'negatives':tests,'matchingActualPositive':positive,'sourceHashRepresentation':'SHA256 of UTF-8 compact JSON value, no terminal LF','targetHashRepresentation':'SHA256 of UTF-8 target string bytes','wholeGameAccepted':False}
 (OUT/'preflight.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps({'status':report['status'],'counts':counts,'negativeTests':len(tests)}))
if __name__=='__main__':main()
