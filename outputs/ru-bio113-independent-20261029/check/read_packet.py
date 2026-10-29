import json,sys
from pathlib import Path
P=Path('/Users/antonkrutov/Desktop/Forest/localization/supplemental-ui/20261029-bio-case113')
S=[json.loads(l) for l in (P/'source-context.jsonl').read_text().splitlines()];T=[json.loads(l) for l in (P/'ru.prepared.jsonl').read_text().splitlines()]
def fields(a):return {x['title']:x['value'] for x in a if x.get('value') not in ('','[]')}
for x,t in zip(S,T):
 if not int(sys.argv[1])<=x['ordinal']<=int(sys.argv[2]):continue
 print(x['ordinal'],repr(x['source']),'->',repr(t['target']),'keys', [(i['field'],i['source']) for i in x.get('identityCells',[])])
 for u in x.get('uses',[]):print(' USE',u['actor']['name'],u['sheet'],u['rowId'],u['slotField'],'hidden',u['row'].get('hide_in_list'+''.join(c for c in u['slotField'] if c.isdigit())),'tags',u['row'].get('enable_with_tags'),'default',u['row'].get('is_default'))
 for z in x.get('triggerContexts',[]):
  print(' TRIGGER',z['id'],z['conversationTitle'],repr(z['source']),'firstDestination',z['firstLinkDestinationId'])
  print(' FIELDS',json.dumps([fields(z.get(k,[])) for k in ['conversationFields','sourceEntryFields','firstLinkDestinationFields']],ensure_ascii=False,separators=(',',':')))
  nonempty={k:z[k] for k in ['sourceConditions','sourceUserScript','destinationConditions','destinationUserScript'] if z.get(k)}
  if nonempty:print(' CONDITION/SCRIPT',json.dumps(nonempty,ensure_ascii=False))
  extras=[q for q in z.get('outgoingLinks',[]) if q.get('destinationDialogueID')!=z['firstLinkDestinationId']]
  if extras:print(' OTHERLINKS',extras)
 for m in x.get('triggerMembership',[]):
  if m['status']!='exact-category-membership-found':print(' MEMBERSHIP GAP',m)
 for k in ['ui','rectBinding','rectBounds','rectUncertainty']:
  if k in x:print(k,json.dumps(x[k],ensure_ascii=False))
