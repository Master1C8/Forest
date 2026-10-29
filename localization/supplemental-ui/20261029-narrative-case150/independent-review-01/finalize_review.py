"""Final receipt correspondence and immutable input checks, review-only output."""
from pathlib import Path
import json,hashlib,datetime
ROOT=Path('/Users/antonkrutov/Desktop/Forest')
P=ROOT/'localization/supplemental-ui/20261029-narrative-case150'
O=P/'independent-review-01'
def load(p):return json.loads(p.read_text())
def jl(p):return [json.loads(x) for x in p.read_text().splitlines()]
def sha(b):return hashlib.sha256(b).hexdigest()
def write(n,v):(O/n).write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')

# Correct only this review's operational typo; no original packet content changes.
h=O/'HANDOFF.md';h.write_text(h.read_text().replace('elders/Mейбл','elders/Мейбл'))
rows=jl(P/'ru.prepared.jsonl');semantic=jl(O/'semantic-review25.jsonl');native=jl(O/'native-read20.jsonl');physical=jl(O/'physical-coverage150.jsonl');context=jl(O/'context-coverage315.jsonl')
assert [x['id'] for x in semantic]==[x['id'] for x in rows]
assert [x['id'] for x in native]==[x['id'] for x in rows if x['target'] is not None]
assert len(physical)==150 and len({x['id'] for x in physical})==150
assert len(context)==315 and len({(x['conversationId'],x['entryId']) for x in context})==315
for r,s in zip(rows,semantic):
 assert r['source']==s['source'] and r['target']==s['target']
 assert r['sourceUtf8Sha256']==s['sourceUtf8Sha256'] and r['targetUtf8Sha256']==s['targetUtf8Sha256']
for n in native:
 assert n['targetUtf8Sha256']==next(x for x in rows if x['id']==n['id'])['targetUtf8Sha256']
checked=0
for entry in load(O/'input-verification.json')['pins']:
 path=Path(entry['path']) if entry['path'].startswith('/') else ROOT/entry['path'];b=path.read_bytes()
 assert sha(b)==entry['sha256'] and len(b)==entry['bytes'],entry['path'];checked+=1
assert checked==92
write('final-verification.json',{'status':'passed','unchangedOriginalOutputAndInputPinRecords':checked,'pageReviewCorrespondence':25,'separateRussianReviewCorrespondence':20,'physicalReceiptCorrespondence':150,'contextReceiptCorrespondence':315,'reviewReceiptSourceAndTargetHashesMatch':True,'newOutputDirectoryOnly':str(O.relative_to(ROOT)),'targetApplied':False,'actualGameRuntime':'not-run','ordinaryTranslationEntryAllowed':False,'sourceGateAccepted':False,'wholeGameAccepted':False})
write('usage.json',{'status':'measured-child-session-subtotal-at-fixed-cutoff','agent':'/root/narrative150_independent','sessionId':'01a18627-94a0-7883-80d8-5a4d3046d8cb','model':'gpt-6.1-sol','reasoning':'high','provider':'openai','source':'Exact child-session event_msg/token_count cumulative total_token_usage, read once at final accounting milestone.','sourcePath':'/Users/antonkrutov/.codex/sessions/2026/10/29/rollout-2026-10-29T12-35-03-01a18627-94a0-7883-80d8-5a4d3046d8cb.jsonl','cutoff':'2026-10-29T05:41:37.201Z','inputTokens':3258893,'cachedInputTokens':3081472,'outputTokens':15991,'reasoningOutputTokens':2302,'totalTokens':3274884,'counterScope':'Fresh no-history child session assignment only. First cumulative snapshot equals its last-request snapshot; no pre-assignment inherited cumulative counter was subtracted or included.','cachedInputIsSubsetOfInput':True,'reasoningIsSubsetOfOutput':True,'requestsCountedInCumulativeSnapshot':28,'descendantUsage':'none;no descendants launched','coordinatorOrchestrationUsage':'unknown-in-child;parent must report separately','reportingTail':'Unmeasured after fixed cutoff, including usage collection result processing, final artifact checks/writes, handoff and final report. Platform overhead is unknown. This is a measured subtotal, not a claim of final complete usage.','cost':'not calculated;token counts are not monetary charges'})
files={}
for path in sorted(O.iterdir()):
 if path.is_file() and path.name!='output-manifest.json':
  b=path.read_bytes();files[str(path.relative_to(ROOT))]={'sha256':sha(b),'bytes':len(b)}
write('output-manifest.json',{'schemaVersion':1,'createdAt':datetime.datetime.now(datetime.timezone.utc).isoformat(),'boundary':'All independent-review-01 files except this manifest; original packet and inputs are read-only external pins.','newlineConvention':'UTF-8 LF;JSONL one object per line with trailing LF','files':files,'preparedSha256':'7ccd8ed80209210f82574fe4d0b9a78f370c03d12c091ff2e28264f795cf8202','originalOutputManifestSha256':'8db1a48849329a42b11922623c57343a287f3b60eb9a8b93613e22e3412e82ae','closureManifestSha256':'a791ca81abd0eed7a1a5bcfbb985d77af81e4b567021e4a8ddacbd40b5c495ca','reviewer':'/root/narrative150_independent','cleanWordingReview':True,'sourceHolds':5,'targetApplied':False,'actualGameRuntime':'not-run','ordinaryTranslationEntryAllowed':False,'sourceGateAccepted':False,'wholeGameAccepted':False})
print(json.dumps({'status':'passed','files':len(files),'manifestSha256':sha((O/'output-manifest.json').read_bytes()),'ResultSha256':sha((O/'Result.json').read_bytes()),'cleanWordingReview':True,'sourceHolds':5}))
