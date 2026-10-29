"""Select and bind directly authored wording. Never generates translated wording.
All reads use existing saved JSON/CIL evidence; no native extraction or application.
"""
import collections, hashlib, json, pathlib, re

ROOT=pathlib.Path('/Users/antonkrutov/Desktop/Forest')
P=ROOT/'localization/supplemental-ui/20261029-pause-chapter-case576'
O=ROOT/'outputs/ru-pause-chapter576-case-wording-20261029'
S=ROOT/'localization/source/chapter-select-heading-20261029'
A=ROOT/'localization/source/shared-source-completion-20261028/admission-v1'
I=ROOT/'localization/supplemental-ui/20261029-input-case72'
def sha(p):return hashlib.sha256(pathlib.Path(p).read_bytes()).hexdigest()
def uhash(s):return hashlib.sha256(s.encode()).hexdigest()
def load(p):return json.loads(pathlib.Path(p).read_text())
def lines(p):return [json.loads(l) for l in pathlib.Path(p).read_text().splitlines()]
def write(name,d): (P/name).write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n')
def jl(name,d):(P/name).write_text(''.join(json.dumps(x,ensure_ascii=False,separators=(',',':'))+'\n' for x in d))
def group(h):return re.split(r'/(?:NameContainer(?: \(\d+\))?|NameGlowLeft|ButtonsHintGlowLeft)(?:/|$)',h)[0]
assert sha(S/'pause-chapter-576.source.jsonl')=='a9ad466ac810a5403fd3384bb4807a491860e365ffc59e1335c69451bcb6d682'
source=lines(S/'pause-chapter-576.source.jsonl'); assert len(source)==len({r['id'] for r in source})==576
rb={r['id']:r for r in lines(S/'pause-chapter-576-readback.jsonl')}
typed={r['id']:r for r in lines(A/'serialized-inventory.jsonl') if r['id'] in rb}
direct={r['id']:r for r in lines(A/'direct-context.jsonl') if r['id'] in rb}
retained={r['id']:r for r in lines(I/'ru.prepared.jsonl') if r['id'] in rb}
assert len(retained)==12
candidateBuild=ROOT/'localization/previews/ru-20261029-bio-input-v2-01/build.json'
candidateContainer=ROOT/'localization/previews/ru-20261029-bio-input-v2-01/bio-input-resources/sharedassets2.assets'
assert sha(candidateBuild)=='e0fddc537966c94e44c0989664b2904951c2add43d5d57aaada12753657e8d6d'
assert sha(candidateContainer)=='c7f0c6c05ac81e60ff0f62bf20b508d4daa2e4610e35686091986a13c9ff568a'
authored=load(P/'wording.authored.json')
pins={}; contexts=[]; schemas=[]; prepared=[]; protected=[]; trees={}; logical=collections.defaultdict(list)
def pin(p):
 p=pathlib.Path(p);pins[str(p.relative_to(ROOT)) if p.is_relative_to(ROOT) else str(p)]=sha(p)
def tree(n):
 p=ROOT/'assets/source-v2/trees'/('93427fb40d-sharedassets2.assets-'+str(n)+'.json')
 pin(p);return load(p)
for r in source:
 ident=r['id'];assert typed[ident]==r and rb[ident]['source']==r['source']
 if ident not in retained:assert rb[ident]['currentValue']==r['source'],('unexpected-new-current',ident)
 d=direct[ident];assert d['value']==r['source'] and d['hierarchy']==r['hierarchy']
 native=ROOT/'assets/source-v2'/d['tree'];pin(native);t=load(native)
 assert t[r['pointer'][1:]]==r['source']
 trees[ident]=t
 schemas.append({'id':ident,'tree':str(native.relative_to(ROOT)),'treeSha256':sha(native),'sourceNativeFields':t})
 contexts.append({'source':r,'currentCandidate':rb[ident],'directContext':d,'sourceNativeTree':str(native.relative_to(ROOT)),'sourceNativeTreeSha256':sha(native)})
 h=r['hierarchy'];status='prepared';target=None;reason=None;reuse=None
 if ident in retained:
  old=retained[ident];assert old['source']==r['source'] and old['target']==rb[ident]['currentValue']
  target=old['target'];status='retained-exact-current-binding';reuse={'path':str((I/'ru.prepared.jsonl').relative_to(ROOT)),'id':ident,'targetUtf8Sha256':uhash(target)}
 elif r['role'].startswith('preserve-'):
  status='preserve-exactly';reason='Exact keyboard/layout symbol, system-detail marker or input sentinel; preserve complete original value and all native non-display fields.'
 elif r['role']=='potential-display-source' or '/HiddenContent/' in h or '/Tooltip' in h:
  status='needs-source';reason='Establish exact live setter/default-cache/initial activation and restoration for this saved ChapterSelect template/tooltip/debug leaf. Runtime ChapterRecord title/description producers are separate; do not count translated seed as producer coverage.'
 elif '/CheatsMenu/' in h and r['source'] in ['Run Cheat?','Activated','Not Activated','On','Off']:
  status='needs-source';reason='Bind exact cheat activation chooser/cache/restoration and prove this face text is not an identity/comparison/input operand. Controller16433 GO pointers alone do not establish all runtime text reads or UnlockMovies binding.'
 elif r['source'] in ['System Info','Application Info']:
  status='needs-source';reason='Bind BugReportMenu system/application-info column producer, overwrite/default and payload/display split before localizing this initial column value.'
 else:
  assert r['source'] in authored,('missing-authored',ident,r['source'])
  target=authored[r['source']][0]
  if r['source'] in ['On','Off']:assert '/OptionsMenu/' in h
 row={'id':ident,'ordinal':len(prepared)+1,'locale':'ru','caseId':'pause-chapter576-missing-binding','source':r['source'],'sourceValueSha256':r['sourceValueSha256'],'sourceUtf8Sha256':uhash(r['source']),'currentValue':rb[ident]['currentValue'],'currentUtf8Sha256':uhash(rb[ident]['currentValue']),'target':target,'targetUtf8Sha256':uhash(target) if target is not None else None,'status':status,'hierarchy':h,'pointer':r['pointer'],'className':r['className'],'role':r['role'],'sourceLine':r['sourceLine'],'logicalGroup':group(h),'missingPredicate':reason if status=='needs-source' else None,'preserveReason':reason if status=='preserve-exactly' else None,'reuseReference':reuse,'displayOnly':True,'targetApplied':False}
 prepared.append(row);logical[group(h)].append(row)
 if target is None:protected.append(row)
jl('source-context.jsonl',contexts);jl('native-component-schemas.jsonl',schemas);jl('ru.initial.jsonl',prepared);jl('ru.prepared.jsonl',prepared);jl('protected-contracts.jsonl',protected)
groups=[]
for k,rs in logical.items():
 groups.append({'groupId':f'group-{len(groups)+1:03d}','hierarchy':k,'ids':[r['id'] for r in rs],'sources':sorted(set(r['source'] for r in rs)),'targets':sorted(set(r['target'] for r in rs if r['target'] is not None)),'statuses':dict(collections.Counter(r['status'] for r in rs)),'members':[{'id':r['id'],'suffix':r['hierarchy'][len(k):],'source':r['source'],'currentValue':r['currentValue'],'target':r['target']} for r in rs],'assembly':'Parallel foreground/glow display leaves; do not concatenate these siblings. Each full sentence/paragraph is the complete field replacement.','completenessBoundary':'Exact assigned576 source memberships only; no broader whole-game consumer/reachability claim.'})
jl('semantic-groups.jsonl',groups)
# Exact saved controller bindings from pre-existing source trees.
controllers=[]
for n in [16433,17041,18627]:controllers.append({'id':f'sharedassets2.assets:{n}','fields':tree(n)})
write('controller-contracts.json',controllers)
# Explicitly verify boolean-bound options faces against the exact saved GO ancestry.
opt=controllers[-1]['fields'];bindings={}
for control,field in [('Fullscreen/On','optionsFullscreenYes'),('Fullscreen/Off','optionsFullscreenNo'),('FullscreenStretch/On','optionsFullscreenStretchYes'),('FullscreenStretch/Off','optionsFullscreenStretchNo')]:
 rs=[r for r in prepared if '/OptionsMenu/Controls/'+control+'/' in r['hierarchy']];assert len(rs)==6
 obj='sharedassets2.assets:'+str(opt[field]['m_PathID'])
 assert all(any(a['object']==obj for a in direct[r['id']]['ancestors']) for r in rs)
 bindings[control]={'controller':'sharedassets2.assets:18627','field':field,'gameObject':obj,'ids':[r['id'] for r in rs],'caption':rs[0]['target'],'identity':'Boolean -> SetActive(GO), never translated GO name or controller field. Source consumer OptionsMenu-settings.il ConfigureForEverythingElse / OnClickFullscreen; no runtime execution.'}
write('settings-boolean-bindings.json',bindings)
for p in [S/'pause-chapter-576.source.jsonl',S/'pause-chapter-576-readback.jsonl',S/'pause-chapter-576-readback-summary.json',S/'source-context.jsonl',S/'scope.json',A/'serialized-inventory.jsonl',A/'direct-context.jsonl',A/'source-decisions.json',A/'special-cases.json',I/'ru.prepared.jsonl',I/'ru.acceptance.json',I/'producer-evidence.json',I/'display-cache-dispatch-proposal.json',I/'native-component-schemas.jsonl',ROOT/'localization/source/chapter-gallery-case-20261029/producer-context.json',ROOT/'localization/source/consumers/OptionsMenu-settings.il',ROOT/'localization/visual-qa/ru-chapter-description-20261029-07/review.json',ROOT/'localization/ru-assets/dialogue.ru.jsonl',ROOT/'localization/previews/ru-20261029-bio-input-v2-01/build.json']:
 pin(p)
for p in (ROOT/'localization/glossary/inventory-display-20261028').glob('*.json'):pin(p)
for p in (A/'phase134').glob('key*.il'):pin(p)
for p in [ROOT/'tools/russian_menu_ui.py',ROOT/'tools/russian_settings_ui.py',ROOT/'tools/russian_report_ui.py',ROOT/'localization/supplemental-ui/20261029-existing935/ru.edited.jsonl']:pin(p)
acceptance=load(I/'ru.acceptance.json')
pin(candidateContainer)
assert sha(I/'ru.prepared.jsonl')==acceptance['targetSha256']
for path,expected in acceptance['evidence'].items():assert sha(ROOT/path)==expected;pin(ROOT/path)
reuse=[]
for ident in retained:
 found=[]
 for path in ['outputs/ru-input72-independent-20261029/check/reviews.jsonl','outputs/ru-input72-independent-20261029/check/native-read.jsonl']:
  selected=[r for r in lines(ROOT/path) if r.get('id')==ident];assert len(selected)==1 and selected[0]['verdict']=='pass'
  assert selected[0]['targetUtf8Sha256']==uhash(retained[ident]['target'])
  assert selected[0]['sourceValueSha256']==typed[ident]['sourceValueSha256']
  found.append({'path':path,'sha256':sha(ROOT/path),'receipt':selected[0]})
 reuse.append({'id':ident,'source':retained[ident]['source'],'target':retained[ident]['target'],'reference':str((I/'ru.prepared.jsonl').relative_to(ROOT)),'referenceSha256':sha(I/'ru.prepared.jsonl'),'acceptanceSha256':sha(I/'ru.acceptance.json'),'receipts':found,'applicability':'Same exact physical ID/source/current target. Newly read in complete Pause/Chapter576 context; inherited pass applies only to unchanged wording, no new runtime/source acceptance.'})
write('reused-receipts.json',reuse)
write('input-pins.json',pins)
write('coverage.json',{'assigned':len(prepared),'logicalGroups':len(groups),'statusCounts':dict(collections.Counter(r['status'] for r in prepared)),'nonnull':sum(r['target'] is not None for r in prepared),'sourceRoles':dict(collections.Counter(r['role'] for r in prepared)),'all576Mapped':True,'newExtraction':False,'actualGameRuntime':'not-run','independentReview':'pending'})
print(json.dumps(load(P/'coverage.json'),ensure_ascii=False))
