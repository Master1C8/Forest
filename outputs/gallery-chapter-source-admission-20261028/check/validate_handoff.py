"""Read-only final gate for the exact completed source admission manifest."""
import pathlib,json,hashlib,collections
R=pathlib.Path('/Users/antonkrutov/Desktop/Forest');B=R/'localization/source/gallery-chapter-display-20261028/admission-v1'
sha=lambda b:hashlib.sha256(b).hexdigest()
def j(n):return json.loads((B/n).read_text())
def jl(n):return [json.loads(x) for x in (B/n).read_text().splitlines()]
def exact(rows):
 m={r['id']:r for r in rows};assert len(m)==len(rows),'duplicate-id';return m
manifest=j('manifest.json');assert manifest['status']=='finite-family-handoff-complete'
assert set(manifest['products'])=={p.name for p in B.iterdir() if p.name!='manifest.json'}
for n,h in manifest['products'].items():assert sha((B/n).read_bytes())==h['sha256'] and (B/n).stat().st_size==h['bytes'],('product-fingerprint',n)
for n in ['input-pins.json','supplemental-input-pins.json']:
 for p,h in j(n).items():
  path=pathlib.Path(p);path=path if path.is_absolute() else R/path
  assert sha(path.read_bytes())==h['sha256'] and path.stat().st_size==h['bytes'],('input-fingerprint',p)
prepared=exact([json.loads(x) for x in (B.parent/'source.jsonl').read_text().splitlines()]);states=exact(jl('column-states.jsonl'));ctx=exact(jl('consumer-context.jsonl'))
assert len(states)==129 and len(prepared)==len(ctx)==113 and set(ctx)==set(prepared)
assert collections.Counter(r['admissionState'] for r in states.values())=={'stored-nonempty':113,'absent':16}
for id_,r in ctx.items():
 assert all(r[k]==prepared[id_][k] for k in prepared[id_]),('prepared-changed',id_)
 assert r['source']==states[id_]['source'] and r['sourceSpan']==states[id_]['sourceSpan'] and r['applicationSelector']=={k:r[k] for k in ['sheetId','fieldId','rowId','rowIndex']}
 assert r['sourceDecision'] and r['targetAuthored'] is False and r['runtimeReachabilityAccepted'] is False
 assert all(c['id'] in {x['id'] for x in jl('row-context-cells.jsonl')} for c in [states[id_]])
coverage=j('column-coverage.json');assert len(coverage)==3 and sum(x['states'] for x in coverage)==129 and sum(x['absent'] for x in coverage)==16
for f in coverage:
 group=[r for r in states.values() if r['sheetId']==f['sheetId'] and r['fieldId']==f['fieldId']]
 assert len(group)==f['rows']==f['states'] and [r['rowIndex'] for r in group]==list(range(f['rows']))
 assert set(f['storedRowsOrder'])=={r['rowIndex'] for r in group if r['stored']}
contracts=j('consumer-contracts.json');cs=[id_ for c in contracts['contracts'] for id_ in c['ids']];assert len(cs)==113 and set(cs)==set(ctx)
assert len(jl('consumer-evidence.jsonl'))==15
assert sum(r['family']=='gallery-hint' for r in ctx.values())==57
assert sum(r['family']=='chapter-title' for r in ctx.values())==28 and sum(r['family']=='chapter-description' for r in ctx.values())==28
reuse=j('reuse-candidates.json');assert len(reuse['candidates'])==12 and len({r['destinationId'] for r in reuse['candidates']})==7
for candidate in reuse['candidates']:
 assert candidate['destinationId'] in ctx and candidate['source']==ctx[candidate['destinationId']]['source']
 assert candidate['sourceUtf8Sha256']==ctx[candidate['destinationId']]['sourceUtf8Sha256'] and sha(candidate['target'].encode())==candidate['targetUtf8Sha256']
 assert not candidate['physicalSelectorBound'] and not candidate['independentEditorialAcceptanceForDestination']
source=j('source-decisions.json');assert source['necessarySourceContextPredicatesUnresolved']==[]
for item in source['sourceInformationLimits']+source['wordplayGroups']:assert set(item['ids'])<=set(ctx)
family=j('family-decision.json');assert family['ids']==list(ctx) and family['decision']=='accepted-for-conservative-bounded-gap-repair' and family['allNecessarySourceContextSettled']
assert family['necessarySourceContextPredicatesUnresolved']==[] and family['ordinaryWholeGamePhraseDenominator'] is None
assert family['gates']['boundedSourceFamily'] is True and all(v is False for k,v in family['gates'].items() if k!='boundedSourceFamily')
design=j('application-design.json');assert design['exactTargetIds']==list(ctx) and len(design['exactColumns'])==3 and design['executedTargetTests'] is False
v=j('validation.json');assert v['wholePayloadSourceReconstructionSha256']==design['sourcePayloadSha256'] and v['storedNonempty']==113 and v['absent']==16 and not v['targetProjectionRun']
assert len(j('acceptance-checklist.json'))==6
print(json.dumps({'status':'passed-final-static-handoff','products':len(manifest['products']),'sourceIds':113,'columnStates':129,'storedNonempty':113,'absent':16,'wholeGameAccepted':False,'semanticBoundary':'Structural/version integrity; does not replace the authored source decisions or any future target editorial/runtime check.'}))
