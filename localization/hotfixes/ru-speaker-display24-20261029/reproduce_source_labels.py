#!/usr/bin/env python3
"""Reproduce the bounded immutable source speaker-label membership list."""
from pathlib import Path
import json,hashlib,re
ROOT=Path('/Users/antonkrutov/Desktop/Forest')
OUT=Path(__file__).resolve().parent
TREE=ROOT/'assets/source-v2/trees/57009919ee-sharedassets0.assets-3336.json'
VALUES=ROOT/'localization/source/shared-source-completion-20261028/admission-v1/dialogue-database-values.jsonl'
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
assert sha(TREE)=='41749d8b093ab438a9fc73519993809cee8b1288c5fbc6fab46782a1b899d69b'
data=json.loads(TREE.read_text());inventory={r['pointer']:r for l in VALUES.open() if (r:=json.loads(l)).get('role')=='protected-dispatch-command-title'}
rename=[];forced=[]
for ci,c in enumerate(data['conversations']):
    title=next((f['value'] for f in c['fields'] if f['title']=='Title'),None)
    for ei,e in enumerate(c['dialogueEntries']):
        for fi,f in enumerate(e['fields']):
            if f['title']!='Title':continue
            value=f['value'];m=re.fullmatch(r'PORTRAITS\(rename\[([^,\]]+),([^,\]]+),([^,\]]+)\]\)',value)
            n=re.fullmatch(r'PORTRAITS\((force_next_left|force_next_right)\[([^\]]+)\]\)',value)
            if not (m or n):continue
            pointer=f'/conversations/{ci}/dialogueEntries/{ei}/fields/{fi}/value'
            prior=inventory[pointer];assert prior['source']==value
            row={'conversationId':c['id'],'entryId':e['id'],'field':'Title','conversation':title,'sourcePointer':pointer,'source':value,'sourceValueSha256':hashlib.sha256(value.encode()).hexdigest(),'inventoryRole':prior['role'],'translationId':prior['translationId'],'occurrences':prior['occurrences']}
            assert row['translationId'] is None
            if m:
                key,label,pitch=m.groups();row.update({'actorKey':key,'label':label,'pitchLiteral':pitch});rename.append(row)
            else:
                side,label=n.groups();row.update({'side':side,'label':label});forced.append(row)
assert len(rename)==29 and len(forced)==2
labels=sorted({r['label'] for r in rename});assert len(labels)==22
result={'schemaVersion':1,'scope':'Display values only; immutable protected Title fields are evidence, not translation inputs.','sourcePins':{str(p.relative_to(ROOT)):sha(p) for p in [TREE,VALUES]},'renameLabelValues':labels,'renameRowCount':len(rename),'renameConversationCount':len({r['conversationId'] for r in rename}),'renameRows':rename,'forceNextRows':forced,'forceNextLabelValues':sorted({r['label'] for r in forced}),'fullDisplayValues':sorted({r['label'] for r in rename+forced}),'consumer':'TheForestOfLove.CustomPortraitsUi::UpdateChildLabels(UnityEngine.Transform,System.String)','preserveExactly':['Every source Title value (entire string)','actor_a through actor_f keys','pitch literals and Parse calls','DS actor IDs, conversation/entry IDs and links','BG Actor null/default fields and identities','All frozen dialogue rows, including detached colon-ending speaker records','replaceNames keys/values, insertion, overwrite and clear lifetime','Saved game state; no save access performed'],'limits':'Finite source command-family scope only; not all possible speaker names or full game/runtime acceptance.'}
(OUT/'source-labels.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
print(json.dumps({'renameRows':len(rename),'renameLabels':len(labels),'renameConversations':result['renameConversationCount'],'forceNextRows':len(forced),'fullDisplayValues':len(result['fullDisplayValues'])}))
