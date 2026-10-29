import json,pathlib,hashlib
root=pathlib.Path('/Users/antonkrutov/Desktop/Forest');c=root/'outputs/ru-console62-case-wording-20261029/check';o=root/'localization/supplemental-ui/20261029-console-case62'
a=[json.loads(x) for x in (c/'assigned.jsonl').read_text().splitlines()];auth=json.loads((c/'authored-wording.json').read_text());assert len(auth)==62 and len({x[0] for x in auth})==62
m={n:(t,note) for n,t,note in auth};assert set(m)=={r['bindingOrdinal'] for r in a}
rows=[]
for r in a:
 t,note=m[r['bindingOrdinal']];rows.append({**r,'locale':'ru','target':t,'targetSha256':hashlib.sha256(t.encode()).hexdigest(),'status':'prepared-conditional','origin':'direct-author-new','immediateEdit':note,'reusedReceipt':None,'targetApplied':False})
payload=''.join(json.dumps(x,ensure_ascii=False,separators=(',',':'))+'\n' for x in rows)
for name in ['ru.prepared.initial.jsonl','ru.prepared.jsonl']:
 p=o/name
 if p.exists():assert p.read_text()==payload,'Do not overwrite an earlier authored version'
 else:p.write_text(payload)
print('Authored',len(rows),'new conditional targets; no target application.')
