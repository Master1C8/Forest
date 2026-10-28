"""Bounded read-only source/target reconciliation; writes only beside this script."""
import json,hashlib,pathlib,collections,unicodedata,sys
from read_evidence import read, ROOT, OUT
A='localization/source/shared-source-completion-20261028/admission-v1/'
F='localization/fonts/final-corpus-bindings-20261028/'
I='localization/source/inventory-display-completion-20261028/'
N='localization/supplemental-ui/20261028-inventory/'
E='localization/editorial-delivery/'
C='localization/previews/ru-20261028-texture-preserving-12/'
def sha(b):return hashlib.sha256(b).hexdigest()
def j(p,mode='deterministic bounded evidence'):return json.loads(read(p,mode))
def jl(p,mode='deterministic complete ID/value join'):return [json.loads(x) for x in read(p,mode).splitlines()]
def put(n,d): (OUT/n).write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n')
def lines(n,rs):(OUT/n).write_text(''.join(json.dumps(x,ensure_ascii=False,separators=(',',':'))+'\n' for x in rs))
def unique(rs,key='id'):
 m={r[key]:r for r in rs};assert len(m)==len(rs),('duplicate',key);return m
checks=[]
def check(name,ok,detail=None):
 checks.append({'predicate':name,'passed':bool(ok),'detail':detail});assert ok,(name,detail)
# Deterministic coverage only. No semantic reread or external requests.
current=j(E+'ru-current.json');dialogue=jl(current['currentCorpus']['path']);dm=unique(dialogue)
check('exact current Russian dialogue file hash',sha(read(current['currentCorpus']['path'],'file hash only'))==current['currentCorpus']['sha256']=='462c91c948c3564225aeaf71da972c7426e5b5c068eaca7bab64e22e70e36587')
check('12246 IDs and 24492 physical occurrences',len(dm)==12246 and sum(len(r['occurrences']) for r in dialogue)==24492)
old=jl('localization/supplemental-ui/20261027/ru.jsonl');om=unique(old)
cat=j('localization/supplemental-ui/20261027/source-catalog.json');cm=unique(cat['units'])
check('all935 source/target IDs and exact source values',set(om)==set(cm) and len(om)==935 and all(om[k]['source']==cm[k]['source'] for k in om))
oldmanifest=j('localization/supplemental-ui/20261027/manifest.json')
oldpins=j(I+'input-pins.json')
old30=[]
for loc in oldmanifest['locales']:
 p=f'localization/supplemental-ui/20261027/{loc}.jsonl';actual=sha(read(p,'old all30 byte fingerprints only; no semantic read'))
 check('unchanged old935 '+loc,actual==oldpins[p]['sha256']);old30.append({'locale':loc,'path':p,'sha256':actual})
source=jl(I+'source.jsonl');sm=unique(source);target=jl(N+'ru.edited.jsonl');tm=unique(target);accept=j(N+'ru.acceptance.json')
check('complete52 exact source/target join',set(sm)==set(tm) and len(sm)==52 and all(tm[k]['source']==sm[k]['source'] for k in sm))
check('new Russian packet accepted target hash',sha(read(N+'ru.edited.jsonl','target hash only'))==accept['targetSha256'])
for p,h in accept['evidencePins'].items():check('52 acceptance pin '+p,sha(read(p,'52 accepted evidence fingerprint only'))==h)
reviews=jl('outputs/inventory-display-20261028/independent-01/review/reviews.jsonl','52 receipt ID/hash/verdict validation only');rm=unique(reviews)
check('52 independent receipt versions and verdicts',set(rm)==set(tm) and all(rm[k]['sourceSha256']==tm[k]['sourceSha256'] and rm[k]['targetSha256']==tm[k]['targetSha256'] and rm[k]['verdict']=='pass' for k in tm))
# Retain exact immutable Russian editorial receipts instead of stale draft counters.
selected=[E+'ru-cycle-02/initial/job.json',E+'ru-cycle-02/author/delivery-manifest.json',E+'ru-cycle-02/cycle/manifest.json',E+'ru-cycle-02/cycle/full-corpus-verification.json',E+'ru-cycle-02/cycle/retention-verification.json',E+'ru-cycle-02/peer/job.json',E+'ru-cycle-02/peer/0001-semantic/result.json',E+'ru-cycle-02/peer/0001-semantic/runtime-check.json',E+'ru-cycle-02/peer/0001-semantic/runtime-verification.json',E+'ru-cycle-02/parent/post-peer-validation.json',E+'ru-cycle-02/cycle/retained-reviews.jsonl',E+'ru-cycle-02/peer/0001-semantic/reviews.jsonl']
for p in selected:check('immutable current editorial pin '+p,sha(read(p,'selected immutable receipt hash only'))==current['evidence'][p]['sha256'])
retained=jl(E+'ru-cycle-02/cycle/retained-reviews.jsonl','retained receipt versions only');peer=jl(E+'ru-cycle-02/peer/0001-semantic/reviews.jsonl','final delta receipt versions only')
for label,rs in [('retained',retained),('peer',peer)]:
 unique(rs);check(label+' all source/target hashes match exact final corpus',all(r['id'] in dm and r['sourceSha256']==dm[r['id']]['sourceSha256'] and r['targetSha256']==dm[r['id']]['targetSha256'] for r in rs))
check('164 clean delta dispositions',len(peer)==164 and collections.Counter(r['verdict'] for r in peer)=={'pass':143,'technical-preservation':21})
# Raw/NFC/NFD are different inputs. Digest representation is JSON ordered ID/target pairs.
normal=[]
for label,rows in [('dialogue12246',dialogue),('old935',old),('inventory52',target)]:
 ts=[(r['id'],r['target']) for r in rows];raw=''.join(t for _,t in ts)
 marks=[(id_,i,ord(c)) for id_,t in ts for i,c in enumerate(t) if unicodedata.category(c).startswith('M')]
 normal.append({'corpus':label,'ids':len(rows),'orderedIdTargetJsonSha256':sha(json.dumps(ts,ensure_ascii=False,separators=(',',':')).encode()),'digestRepresentation':'UTF-8 JSON array of ordered [id,target] pairs, ensure_ascii=False, compact separators, no terminal LF','rawMarkCategoryOccurrences':len(marks),'rawNonzeroCombiningClassOccurrences':sum(bool(unicodedata.combining(c)) for c in raw),'rawEqualsNFC':all(t==unicodedata.normalize('NFC',t) for _,t in ts),'NFDWouldChangeTargets':sum(t!=unicodedata.normalize('NFD',t) for _,t in ts),'marksAddedBySyntheticNFD':sorted({f'U+{ord(c):04X}' for c in unicodedata.normalize('NFD',raw) if unicodedata.category(c).startswith('M')})})
 check(label+' zero actual raw marks',not marks)
# Approved policy exact set, with whole per-selector provenance retained.
policy=j('localization/source/source-policy-decision-20261028.json');pres=jl(I+'approved-preservation.jsonl');unique(pres)
check('policy exact3047 family partition',collections.Counter(r['family'] for r in pres)=={'dialogue-database':1655,'rewired-system':1389,'compiled-technical':3})
dbu=j(A+'dialogue-database-unresolved.json');pv={r['id']:r for r in pres if r['family']=='dialogue-database'}
check('policy1655 matches every unresolved DB value',set(pv)=={r['pointer'] for r in dbu['values']} and all(pv[r['pointer']]['sourceValueSha256']==r['sourceValueSha256'] and pv[r['pointer']]['occurrences']==r['occurrences'] for r in dbu['values']))
serial=jl(A+'serialized-inventory.jsonl');bg=jl(A+'bgdatabase-inventory.jsonl');il=jl(A+'managed-literal-inventory.jsonl');add=jl(A+'additional-source-selectors.jsonl')
allsource=unique(serial+bg+il)
check('exact original source union cardinalities',len(serial)==36107 and len(bg)==51572 and len(il)==8576 and len(add)==9209)
check('remaining three compiled are exactly approved', {r['id'] for r in il if r['role']=='needs-consumer-decision'}=={r['id'] for r in pres if r['family']=='compiled-technical'})
check('remaining1389 Rewired aliases exactly approved',{r['id'] for r in serial if r['role'] in ['potential-display-resource-label','potential-display-control-identity']}=={r['id'] for r in pres if r['family']=='rewired-system'})
# Reuse original cells/roster, not a new extraction. Exact IDs retain repetitions.
cells=unique(jl('localization/source/bgdatabase-complete-values-20261027/verified/cells.jsonl'))
roster=unique(jl('outputs/pause-inventory-bio-completion-20261028/serialized-nondialogue-roster.jsonl'))
direct=unique(jl(A+'direct-context.jsonl'));words=unique(jl(A+'compiled-wording-source.jsonl'))
sc=j(A+'special-cases.json');cases_by_id=collections.defaultdict(list)
for case in sc['cases']:
 for s in case['sourceBindings']:cases_by_id[s['id']].append(case['id'])
bindings=j(A+'old935-selector-bindings.json');alias={r['sourceId']:r['id'] for r in bindings}
check('935 exact selector alias binding values',len(bindings)==935 and all(r['valueMatches'] for r in bindings))
preserve_ids={r['id'] for r in pres if r['family']!='dialogue-database'}
# Every additional selector gets a finite disposition; a hold never counts as translation.
ledger=[]
for a in add:
 r=allsource[a['id']];id_=r['id'];value=(cells[id_]['source'] if id_ in cells else roster[id_]['value'] if id_ in roster else words[id_]['source'] if id_ in words else None)
 disposition=('owner-approved-exact-preservation' if id_ in preserve_ids else 'accepted-new52-Russian-target' if id_ in tm else 'bound-old935-target' if id_ in alias else 'preserve-display-format-or-symbol' if r['role'] in ['preserve-display-format','preserve-display-symbol','display-format','visible-format'] else 'dormant-preserve-until-actual-consumer-contract' if r['role']=='dormant-potential-display-source' else 'source-application-or-special-case-disposition-required')
 ledger.append({'id':id_,'family':r['family'],'role':r['role'],'source':value,'sourceValueSha256':r['sourceValueSha256'],'disposition':disposition,'existingDecision':r.get('decision'),'consumer':direct[id_]['hierarchy'] if id_ in direct else r.get('method') or (r.get('sheet','')+'.'+r.get('field','')),'specialCases':cases_by_id[id_],'targetId':id_ if id_ in tm else alias.get(id_),'all30SharedSource':True,'countsAsNewOrdinaryTranslation':None if disposition=='source-application-or-special-case-disposition-required' else False})
lines('source-selector-reconciliation.jsonl',ledger)
# Concrete untranslated original display bindings beyond52. No absence inference from old935 alone:
# actual typed consumers + original values + complete selected DB column projection boundary.
build=j(C+'build.json');matrix=j(A+'consumer-matrix.json');bg_reasons={(r['sheet'],r['field']):r for r in matrix['remainingBgColumns']}
missing=[]
for r in bg:
 if r['role']!='display' or not cells[r['id']]['source']:continue
 c=cells[r['id']];check('active BG display outside bound Russian packets '+r['id'],r['id'] not in tm and r['id'] not in alias)
 q=bg_reasons[r['sheet'],r['field']]
 missing.append({'id':r['id'],'family':'active-BG-display','source':c['source'],'sourceValueSha256':r['sourceValueSha256'],'sourceSpan':c['sourceSpan'],'sheet':r['sheet'],'field':r['field'],'rowId':c['rowId'],'rowIndex':r['rowIndex'],'consumer':q['reason'],'consumerMethods':q['getterUses'],'RussianDelivery':'no bound target in current dialogue/935/52; current candidate DB projection is Actor/Quest/InventoryItem only; these columns remain original','runtime':'not-run; actual unlock/actor/filter selection retained','all30SharedSourceImplication':'Admit these exact shared selectors append-only, settle scene/glossary dependencies, author/review each locale and project this column; preserve original absent states.'})
check('complete130 active BG nonempty display states',len(missing)==130)
# These complete narrative pages are authored initial text, not generic subtitle placeholders.
narr_ids={r['id'] for r in next(c for c in sc['cases'] if c['id']=='narration-and-speaker-context')['sourceBindings']}
narr=[]
for id_ in sorted(narr_ids):
 d=direct[id_];narr.append({'id':id_,'family':'native-narrative-page','source':d['value'],'sourceValueSha256':allsource[id_]['sourceValueSha256'],'consumer':d['hierarchy'],'sourceTree':d['tree'],'sourceTreeSha256':d['treeSha256'],'componentEnabled':d['componentEnabled'],'RussianDelivery':'No source-bound native page wording projection in candidate07->12; typography preserves these words. Matching dialogue wording, if any, is not a binding.','runtime':'Page controller selection/order/callback contract unresolved; no absence or reachability pass.','all30SharedSourceImplication':'Same exact page/face/glow occurrences for all30; settle original page controller/semantic group before target application.'})
lines('untranslated-display-inputs.jsonl',missing+narr)
# All348 compiled wording candidates retained, including developer/backend and conditional outputs.
compiled=[]
for id_,r in words.items():
 category='bound-old935-target' if id_ in alias else 'accepted-new52-target' if id_ in tm else 'protected-display-comparison-or-codec' if r['role'] in ['comparison-on-display','special-display-codec','display-format','visible-format'] else 'conditional-or-unallocated-compiled-display-input'
 compiled.append({**r,'reconciledDisposition':category,'old935TargetId':alias.get(id_),'specialCases':cases_by_id[id_],'ordinaryRequirementCount':None,'boundary':'Existing exact role retained. No new blanket developer/backend preservation exception; owner3047 policy applies only to its exact set. Conditional log/exception/OSK/nameplate output is not an ordinary-game denominator without its actual selection contract.'})
lines('compiled-display-reconciliation.jsonl',compiled)
# Every role selector is checked against both existing935 and new52, distinguishing null/empty and templates.
profiles=j(F+'profile-sources.json');roles=[]
for name,p in profiles.items():
 unresolved=[];accepted_new=[];old_bound=[];absent=[]
 for s in p['selectors']:
  id_=s['sourceId']
  if id_ in tm: accepted_new.append(id_)
  elif s['old935TargetIds']:old_bound.append(id_)
  elif s['valueState']=='absent':absent.append(id_)
  else:unresolved.append({'id':id_,'kind':s['selectorKind'],'valueState':s['valueState'],'source':cells[id_]['source'] if id_ in cells else direct[id_]['value'] if id_ in direct else words[id_]['source'] if id_ in words else None,'existingRole':allsource.get(id_,{}).get('role'),'reconciliation':'stored example needs producer allocation, not automatic translation' if s['selectorKind']=='stored' else 'actual conditional producer/application contract required; compare current quest patch before assigning new wording'})
 roles.append({'profile':name,'componentIds':p['componentIds'],'consumerPredicate':p['consumerPredicate'],'remainingSourcePredicate':p['remainingSourcePredicate'],'old935BoundSourceSelectors':len(old_bound),'acceptedNew52Selectors':accepted_new,'absentPreservedSelectors':absent,'unallocatedSelectors':unresolved,'sourceAccepted':False,'boundary':'Old counters are historical. New52 resolves inventory dynamic target omissions. Null states add no text; stored placeholders and conditional producers require actual application allocation. Native/visual acceptance is separate.'})
put('role-reconciliation.json',roles)
holds=j(E+'ru-cycle-02/author/retained-open-holds.json');holdrows=[]
finley={'ds:199:180:Dialogue Text','ds:199:181:Dialogue Text','ds:199:182:Dialogue Text','ds:409:790:Dialogue Text','ds:422:754:Dialogue Text','ds:428:737:Dialogue Text','ds:569:788:Dialogue Text','ds:569:792:Dialogue Text'}
for h in holds['completeIndependentSourceContextVerdicts']:
 check('retained source hold exact final hashes '+h['id'],h['sourceSha256']==dm[h['id']]['sourceSha256'] and h['targetSha256']==dm[h['id']]['targetSha256'])
 holdrows.append({**h,'reconciliation':'Primary roommate fact now agrees with repaired local glossary; historical dialogue receipt remains bound to original snapshot. No target correction inferred; full-game glossary applicability decision remains.' if h['id'] in finley else 'Retain exact source/context finding; no new objective Russian correction inferred. Resolve its named source/consumer/scene predicate before full-game acceptance.'})
put('editorial-holds.json',{'historicalDistinctIds':len(holdrows),'FinleyBackgroundOnlyIds':sorted(finley),'rows':holdrows,'boundary':'41 is not41 untranslated strings. Six source placeholders and technical/source anomalies retain their original exact dispositions. New52 glossary handoff does not silently rebind historical dialogue.'})
summary={'checks':checks,'old30Pins':old30,'normalization':normal,'policy':{'total':3047,'families':dict(collections.Counter(r['family'] for r in pres)),'countsSuperseded':True},'sourceLedger':{'rows':len(ledger),'dispositions':dict(collections.Counter(r['disposition'] for r in ledger))},'additionalDisplayInputs':{'activeBGNonempty':len(missing),'activeBGFields':dict(collections.Counter(r['sheet']+'.'+r['field'] for r in missing)),'nativeNarrativeOccurrences':len(narr),'nativeNarrativeDistinctValues':len({r['source'] for r in narr}),'globalNewOrdinaryCount':None,'reason':'Exact whole-field source eligibility/effects/special-scene and runtime producer/application allocations still incomplete. Known display binding gaps are enumerated, not a proved complete translation denominator.'},'compiled':{'rows':len(compiled),'dispositions':dict(collections.Counter(r['reconciledDisposition'] for r in compiled))},'editorial':{'retainedVersionMatchingReceipts':len(retained),'peerVersionMatchingReceipts':len(peer),'unionIds':len({r['id'] for r in retained+peer}),'peerVerdicts':dict(collections.Counter(r['verdict'] for r in peer)),'fullInitialSourceTargetAuditIds':12246,'boundary':'Receipt byte/version checks reuse prior semantic judgment; no new semantic audit or full-game acceptance.'},'wholeGameAccepted':False}
put('deterministic-evidence.json',summary)
print(json.dumps({k:v for k,v in summary.items() if k not in ['checks','old30Pins','normalization']},ensure_ascii=False,indent=2));print('CHECKS',len(checks),'passed',all(x['passed'] for x in checks));print('NORMALIZATION',json.dumps(normal,ensure_ascii=False))
