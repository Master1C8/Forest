"""Read exact pinned scene nodes; no wording generation or source mutation."""
import pathlib,json,sys,hashlib
ROOT=pathlib.Path('/Users/antonkrutov/Desktop/Forest'); RUN=pathlib.Path(__file__).parent
pairs=[json.loads(x) for x in (ROOT/'outputs/editorial-20261027/independent-batches-v1/ru/full-pairs.jsonl').read_text().splitlines()]; by={x['id']:x for x in pairs}
ctx=json.loads((ROOT/'outputs/editorial-20261027/independent-batches-v1/ru/source-context.json').read_text()); conv={c['id']:c for c in ctx['conversations']}; nodes={(c['id'],e['id']):e for c in ctx['conversations'] for e in c['dialogueEntries']}
if sys.argv[1]=='accepted':
 ds=[x for x in map(json.loads,(ROOT/'outputs/editorial-20261027/ru/adjudication-v2/decisions.jsonl').read_text().splitlines()) if x['decision']=='accept-correction']; selected=set()
 for d in ds[int(sys.argv[2]):int(sys.argv[3])]:
  _,c,n,_=d['id'].split(':'); k=(int(c),int(n)); selected.add(k)
  selected.update((l['destinationConversationID'],l['destinationDialogueID']) for l in nodes[k]['outgoingLinks'])
  selected.update(key for key,e in nodes.items() if any((l['destinationConversationID'],l['destinationDialogueID'])==k for l in e['outgoingLinks']))
else:
 selected=set()
 for s in sys.argv[1:]:
  c,rs=s.split(':');c=int(c)
  for token in rs.split(','):
   a=token.split('-'); lo=int(a[0]);hi=int(a[-1]);selected.update((c,n) for n in range(lo,hi+1) if (c,n) in nodes)
out=[]
for c in ctx['conversations']:
 picked=[e for e in c['dialogueEntries'] if (c['id'],e['id']) in selected]
 if not picked:continue
 out.append('SCENE '+json.dumps([c['id'],{f['title']:f['value'] for f in c['fields']}],ensure_ascii=False,separators=(',',':')))
 for e in picked:
  f={v['title']:v['value'] for v in e['fields']};n=e['id'];p=by.get(f"ds:{c['id']}:{n}:Dialogue Text",{});m=by.get(f"ds:{c['id']}:{n}:Menu Text",{})
  out.append(json.dumps([f"{c['id']}:{n}",f.get('Actor'),f.get('Conversant'),f.get('Title'),f.get('Dialogue Text'),p.get('target'),f.get('Menu Text'),m.get('target'),f.get('Sequence'),e['isGroup'],e['conditionsString'],e['userScript'],[[l['destinationConversationID'],l['destinationDialogueID'],l.get('priority')] for l in e['outgoingLinks']]],ensure_ascii=False,separators=(',',':')))
text='\n'.join(out)+'\n';raw=text.encode(); name='context-'+hashlib.sha256(' '.join(sys.argv[1:]).encode()).hexdigest()[:12]+'.txt'; (RUN/name).write_bytes(raw);print(text,end='');print('RECEIPT',name,len(selected),len(raw),hashlib.sha256(raw).hexdigest())
