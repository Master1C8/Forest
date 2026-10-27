import pathlib,json,sys,hashlib
R=pathlib.Path(__file__).parent;P=R.parents[1]/'independent-batches-v1/ru';allrows=[json.loads(l) for l in (P/'full-pairs.jsonl').read_text().splitlines()];by={x['id']:x for x in allrows};selected=[json.loads(l) for l in (R/'class-rows.jsonl').read_text().splitlines()];want=selected[int(sys.argv[1]):int(sys.argv[2])];ctx=json.loads((P/'source-context.json').read_text());nodes={(c['id'],e['id']):e for c in ctx['conversations'] for e in c['dialogueEntries']};keys=set()
for x in want:
 _,c,e,_=x['id'].split(':');k=(int(c),int(e));keys.add(k)
 keys.update((l['destinationConversationID'],l['destinationDialogueID']) for l in nodes[k]['outgoingLinks'])
 keys.update(kk for kk,n in nodes.items() if any((l['destinationConversationID'],l['destinationDialogueID'])==k for l in n['outgoingLinks']))
lines=['Columns: key, actor, conversant, source, target, title, sequence, conditions, script, destinations. * = class hit']
for k,n in nodes.items():
 if k not in keys:continue
 f={x['title']:x['value'] for x in n['fields']};p=by.get(f'ds:{k[0]}:{k[1]}:Dialogue Text',{});lines.append(json.dumps([('*' if p.get('id') in {w['id'] for w in want} else '')+f'{k[0]}:{k[1]}',f.get('Actor'),f.get('Conversant'),f.get('Dialogue Text'),p.get('target'),f.get('Title'),f.get('Sequence'),n['conditionsString'],n['userScript'],[[l['destinationConversationID'],l['destinationDialogueID']] for l in n['outgoingLinks']]],ensure_ascii=False,separators=(',',':')))
raw=('\n'.join(lines)+'\n').encode();(R/f'class-read-{sys.argv[1]}-{sys.argv[2]}.txt').write_bytes(raw);print(raw.decode(),end='');print('RECEIPT',len(want),len(keys),hashlib.sha256(raw).hexdigest())
