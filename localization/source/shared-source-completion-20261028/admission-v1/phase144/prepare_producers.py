"""Snapshot only assigned original producers; reuse fingerprinted saved bodies first."""
import json,hashlib,sys,subprocess,collections
from pathlib import Path
HERE=Path(__file__).resolve().parent;OUT=HERE.parent;ROOT=OUT.parents[3]
sys.path.insert(0,str(OUT))
from phase138.expand_roles import method_bodies
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
assembly=ROOT/'localization/probes/ru-20261026-11/game/The Forest of Love_Data/Managed/Assembly-CSharp.dll'
inspector=ROOT/'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
assert sha(assembly)=='46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
assert sha(inspector)=='10e6da1a3ef09aff8ce89a1fc9f3e0fe56d15b776bc0e0ae70d56f42f304fc05'
selected=json.loads((OUT/'phase143/next-compiled-selectors.json').read_text())['selectors']
wanted=set(r['method'] for r in selected); saved={};pins={str(p.relative_to(ROOT)):sha(p) for p in [assembly,inspector,OUT/'phase143/next-compiled-selectors.json',ROOT/'outputs/pause-inventory-bio-completion-20261028/managed-index/literals.jsonl']}
for path in sorted(OUT.glob('phase*/*.il')):
 for method,body in method_bodies(path).items():
  if method in wanted and method not in saved:
   saved[method]=dict(method=method,instructions=body,evidence=str(path.relative_to(ROOT)),fileSha256=sha(path));pins[str(path.relative_to(ROOT))]=sha(path)
originals=[json.loads(l) for l in (ROOT/'outputs/pause-inventory-bio-completion-20261028/managed-index/literals.jsonl').read_text().splitlines()]
missing=collections.defaultdict(set)
for method in wanted-set(saved):
 owner,tail=method.split(' ',1)[1].split('::');missing[owner].add(tail.split('(')[0])
(HERE/'producers').mkdir(exist_ok=True)
for n,(owner,names) in enumerate(sorted(missing.items())):
 path=HERE/'producers'/f'{n:03d}.il'
 needed=[('IL_'+format(r['offset'],'04x')+': ldstr "'+r['value']+'"\n').encode() for r in originals if r['type']==owner and r['method'].split('::')[1].split('(')[0] in names]
 if not path.exists() or any(span not in path.read_bytes() for span in needed):
  result=subprocess.run(['/opt/homebrew/bin/dotnet',str(inspector),str(assembly),owner,','.join(sorted(names))],capture_output=True,check=True);path.write_bytes(result.stdout)
 for method,body in method_bodies(path).items():
  if method in wanted:saved[method]=dict(method=method,instructions=body,evidence=str(path.relative_to(ROOT)),fileSha256=sha(path))
 pins[str(path.relative_to(ROOT))]=sha(path)
assert set(saved)==wanted
# InspectMethods prints literal values verbatim, including embedded LF/CR,
# quotes and backslashes. Bind every actual literal against the pinned index
# and complete raw byte span rather than the historical one-line parser.
originals=[json.loads(l) for l in (ROOT/'outputs/pause-inventory-bio-completion-20261028/managed-index/literals.jsonl').read_text().splitlines()]
normalizations=[]
for source in originals:
 if source['method'] not in saved:continue
 record=saved[source['method']];body=record['instructions'];item=next(i for i in body if i['offset']==source['offset'])
 raw=(ROOT/record['evidence']).read_bytes()
 method_start=raw.index(('METHOD '+source['method']+' |').encode())
 method_end=raw.find(b'\nMETHOD ',method_start+1)
 block=raw[method_start:method_end if method_end>=0 else len(raw)]
 expected=('IL_'+format(source['offset'],'04x')+': ldstr "'+source['value']+'"\n').encode()
 assert expected in block,('raw-literal-source-span',source['method'],source['offset'])
 canonical=json.dumps(source['value'],ensure_ascii=False)
 if item['operand']!=canonical:normalizations.append(dict(method=source['method'],offset=source['offset'],rawEvidence=record['evidence'],sourceValueSha256=hashlib.sha256(json.dumps(source['value'],ensure_ascii=False,sort_keys=True,separators=(',',':')).encode()).hexdigest(),predicate='Complete exact raw ldstr bytes match pinned original index; canonical JSON escaping repairs LF/CR/quote/backslash transport only.'))
 item['operand']=canonical
(HERE/'literal-transport-normalization.json').write_text(json.dumps(normalizations,ensure_ascii=False,indent=2)+'\n')
rows=[saved[m] for m in dict.fromkeys(r['method'] for r in selected)]
(HERE/'producer-bodies.jsonl').write_text(''.join(json.dumps(r,ensure_ascii=False,separators=(',',':'))+'\n' for r in rows))
(HERE/'input-pins.json').write_text(json.dumps(pins,indent=2)+'\n')
print(json.dumps(dict(selectedMethods=len(rows),reusedMethods=sum('phase144/producers' not in r['evidence'] for r in rows),newTypeSelections=len(missing),instructions=sum(len(r['instructions']) for r in rows),boundary='Evidence capture is not semantic coverage; exact typed-argument decisions and unread producers remain separately recorded.')))
