"""Validate exact accounting with controls that fail at the intended boundaries."""
import copy
from reconcile import *

STATUSES={'accepted-evidence-reused','decision-prepared-needs-independent-review','needs-source','needs-wording','needs-runtime'}

def fail(code):
    raise ValueError(code)

def validate(registry, decisions, bindings, wording, remaining):
    cases=registry['cases'];expected=[c['id'] for c in cases]
    if len(decisions)!=23 or [r['caseId'] for r in decisions]!=expected:fail('exact-case-order-and-identity')
    if [r['caseId'] for r in wording]!=expected or [r['caseId'] for r in remaining]!=expected:fail('exact-case-dependent-products')
    grouped=collections.defaultdict(list)
    for b in bindings:grouped[b['caseId']].append(b)
    if set(grouped)!=set(expected):fail('binding-case-membership')
    for c,d,w,rem in zip(cases,decisions,wording,remaining):
        rr=grouped[c['id']]
        selected=[(b['bindingId'],b['sourceValueSha256'],b['registryRole']) for b in rr]
        original=[(b['id'],b['sourceValueSha256'],b['role']) for b in c['sourceBindings']]
        if selected!=original:fail('exact-source-binding-membership')
        if [b['bindingOrdinal'] for b in rr]!=list(range(1,len(rr)+1)):fail('binding-order')
        if not all(b['rawValueHashMatches'] and b['typedHashMatches'] and value_hash(b['source'])==b['sourceValueSha256'] for b in rr):fail('exact-source-value-and-typed-hash')
        if not all(b['disposition'] and b['typedLedger'] for b in rr):fail('explicit-per-binding-disposition')
        if d['scope']['selectorCount']!=len(rr) or d['scope']['acceptedTargetBindingCount']!=sum(bool(b['wordingReferences']) for b in rr):fail('scope-counts')
        refs=[dict(t,bindingId=b['bindingId']) for b in rr for t in b['wordingReferences']]
        if w['references']!=refs:fail('complete-wording-references')
        if d['scope']['dependencyBindingCount']!=sum(not b['wordingReferences'] for b in rr):fail('dependency-counts')
        if d['status'] not in STATUSES or not all(d[k] for k in ['russianSolution','reason','technicalFeasibilityRuntimeLimits','nextFinitePermittedAction','semanticRead']):fail('authored-case-decision')
        if not all(d[k] is False for k in ['ordinaryTranslationEntryAllowed','sourceGateAccepted','wholeGameAccepted']):fail('no-gate-waiver')
        if d['status']!='accepted-evidence-reused' and not rem['currentUnprovedCasePredicate']:fail('exact-open-case-predicate')
        if d['originalContract']!={k:c[k] for k in ['category','invariant','route','positive','negative','pendingDependencies']}:fail('original-case-contract')
    return True

def run():
    registry=js(BASE+'special-cases.json')
    decisions=jl(str(OUT/'decisions.jsonl'));bindings=jl(str(OUT/'source-bindings.jsonl'))
    wording=jl(str(OUT/'wording-references.jsonl'));remaining=js(str(OUT/'remaining-packet.json'))
    checkrows=[]
    def control(name,ds,bs,expected_error=None):
        try:
            validate(registry,ds,bs,wording,remaining)
            got=None
        except ValueError as e:got=str(e)
        ok=got==expected_error
        checkrows.append({'control':name,'expectedBoundary':expected_error or 'positive-complete-accounting','actualBoundary':got or 'positive-complete-accounting','passed':ok})
        assert ok,(name,got,expected_error)
    control('complete unchanged positive',decisions,bindings)
    dropped=copy.deepcopy(bindings);dropped.pop(0)
    control('one binding omitted with all other guards valid',decisions,dropped,'exact-source-binding-membership')
    swapped=copy.deepcopy(decisions);swapped[0]['caseId']=swapped[1]['caseId']
    control('same23 count with case substitution',swapped,bindings,'exact-case-order-and-identity')
    wrong=copy.deepcopy(bindings);wrong[0]['sourceValueSha256']='0'*64
    control('one original value hash changed',decisions,wrong,'exact-source-binding-membership')
    changed=copy.deepcopy(bindings);changed[0]['source']='changed while original declared hash retained'
    control('raw source substitution under same binding/hash',decisions,changed,'exact-source-value-and-typed-hash')
    waiver=copy.deepcopy(decisions);waiver[0]['ordinaryTranslationEntryAllowed']=True
    control('ordinary entry waiver rejected',waiver,bindings,'no-gate-waiver')
    statuses=dict(collections.Counter(d['status'] for d in decisions))
    receipts=js(str(OUT/'receipt-verification.json'));runtime=js(str(OUT/'runtime-receipt-pin-checks.json'))
    assert receipts['passed'] and all(r['passed'] for r in runtime)
    # Immutable dependency verification at the final cutoff; task-owned evolving
    # scripts/ledgers are output evidence, not external input preservation guards.
    pins=js(str(OUT/'input-pins.json'));rechecked=[]
    for p,r in pins.items():
        if p.startswith('outputs/ru-case-decisions-20261029/check/'):continue
        pp=Path(p) if Path(p).is_absolute() else ROOT/p
        actual=digest(pp.read_bytes());rechecked.append({'path':p,'expected':r['sha256'],'actual':actual,'passed':actual==r['sha256']})
    assert all(r['passed'] for r in rechecked),[r['path'] for r in rechecked if not r['passed']]
    write(OUT/'input-preservation.json',{'externalPinnedFiles':len(rechecked),'allUnchanged':True,'files':rechecked,'boundary':'These are exact relevant immutable input fingerprints; no claim about untracked unrelated owner work.'})
    result={'status':'finite-russian23-case-decision-reconciliation-complete','game':'The Forest of Love','build':'0.45','locale':'ru',
        'all23Accounted':True,'all23Accepted':all(d['status']=='accepted-evidence-reused' for d in decisions),
        'cases':23,'sourceBindingMemberships':len(bindings),'distinctSourceBindingIds':len({b['bindingId'] for b in bindings}),
        'sourceBindingCountsOverlap':True,'statusCounts':statuses,'sourceTypedAndRawHashMatches':len(bindings),
        'receiptChecks':len(receipts['checks']),'runtimeReceiptFingerprintChecks':len(runtime),'allChecksPassed':True,
        'ordinaryTranslationEntryAllowed':False,'sourceGateAccepted':False,'wholeGameAccepted':False,
        'semanticJudgment':'23 case decisions authored by the verified fresh Sol/high/OpenAI process. Prior exact semantic and independent receipts reused; deterministic code supplies accounting only. No new translated wording or independent reviewer created.',
        'runtime':'No game/GUI/input/process control; prior scoped runtime evidence reused only at recorded versions.',
        'scopeLimits':{'nestedJobs':0,'GitMutations':0,'rootReadmeCheckpointMutations':0,'targetCorpusMutations':0,'sharedSourceRegistryMutations':0,'fontTextureProduction':0,'publicationDeploymentServerActions':0},
        'outputsDirectory':'localization/case-decisions/ru-20261029','sourceRegistry':BASE+'special-cases.json',
        'runtimeCheck':'outputs/ru-case-decisions-20261029/check/runtime-check.json',
        'automaticNextPhase':False,'usage':'Parent owns actual session telemetry; no token estimates from file sizes or this report.'}
    write(OUT/'validation.json',{'passed':True,'controls':checkrows,'receiptChecks':len(receipts['checks']),'runtimeReceiptFingerprintChecks':len(runtime),'sourceBindingAccounting':{'memberships':len(bindings),'distinctIds':len({b['bindingId'] for b in bindings})},'semanticJudgmentGenerated':False})
    write(OUT/'Result.json',result)
    write(CHECK/'Result.json',result)
    print(json.dumps(result,indent=2))

if __name__=='__main__':run()
