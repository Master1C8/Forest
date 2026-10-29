"""Package authored decisions and exhaustive deterministic accounting; no wording generation."""
import contextlib
import copy
import io
from reconcile import *

def fingerprint(obj):
    return digest(json.dumps(obj,ensure_ascii=False,separators=(',',':')).encode())

def finalize():
    with contextlib.redirect_stdout(io.StringIO()):
        registry, roles, source, targets, narrative, bindings=build()
    authored=js('outputs/ru-case-decisions-20261029/check/semantic-decisions.json')
    assert [r['caseId'] for r in authored]==[c['id'] for c in registry['cases']]
    receipts=js('outputs/ru-case-decisions-20261029/check/receipt-verification.json')
    assert receipts['passed']
    evidence_paths={p for r in authored for p in r['evidence']}
    evidence_paths.update([
        'localization/completion/ru-20261029/acceptance-checklist.json',
        'localization/glossary/inventory-display-20261028/en.json',
        'localization/glossary/inventory-display-20261028/ru.json',
        'localization/source/chapter-gallery-case-20261029/producer-context.json',
        'localization/source/chapter-gallery-case-20261029/case-decision.json',
        BASE+'phase134/haiku-source-context.json',
        BASE+'compiled-console-source-context.json',
        BASE+'compiled-playback-source-context.json',
        BASE+'compiled-arc-source-context.json',
        BASE+'compiled-loader-source-context.json',
        BASE+'compiled-remaining-source-context.json',
    ])
    # Bodies already captured/read by their owning source phase: verify the recorded
    # producer/receiver files by hash; never extract or recursively audit new bodies.
    matrix=js(BASE+'consumer-matrix.json')
    for name,h in matrix['continuationDecisions']['evidence'].items():
        p=BASE+'phase134/'+name
        assert digest(read(p).encode())==h, p
    for p in sorted(evidence_paths):read(p)
    # Reuse scoped runtime records through their own immutable pins. No images are loaded.
    runtime_records=[
        'localization/visual-qa/ru-inventory-20261028-09/final-acceptance.json',
        'localization/visual-qa/ru-gallery-20261029-01-diagnostic/gallery-scoped-acceptance.json',
        'localization/visual-qa/ru-quests-20261029-01/final-acceptance.json',
    ]
    runtime_pin_checks=[]
    for p in runtime_records:
        r=js(p)
        for ep,h in r.get('evidencePins',r.get('pins',{})).items():
            expected=h if isinstance(h,str) else h['sha256']
            # Saved hashes are checked as bytes; raster files are never emitted.
            pp=Path(ep) if Path(ep).is_absolute() else ROOT/ep
            b=pp.read_bytes()
            PINS[str(pp.relative_to(ROOT)) if pp.is_relative_to(ROOT) else str(pp)]={'sha256':digest(b),'bytes':len(b),'readMode':'fingerprint-only; no image input'}
            runtime_pin_checks.append({'path':ep,'passed':digest(b)==expected})
    assert all(r['passed'] for r in runtime_pin_checks)
    policy=jl('localization/source/inventory-display-completion-20261028/approved-preservation.jsonl')
    policy_members={}
    for n,r in enumerate(policy,1):
        for oid in r.get('occurrences',[r['id']]):policy_members[oid]={'line':n,'row':r}
    absent={r['id'] for r in jl('localization/source/chapter-gallery-case-20261029/absence.jsonl')}
    identity=js(BASE+'compiled-display-identity-dependencies.json')
    identity_by_id={r['id']:(n,r) for n,r in enumerate(identity['rows'],1)}
    dialogue_reviews={r['id']:r for r in jl('localization/editorial-delivery/ru-cycle-02/cycle/retained-reviews.jsonl')+jl('localization/editorial-delivery/ru-cycle-02/peer/0001-semantic/reviews.jsonl')}
    role_classes={}
    for role in sorted({r['currentRole'] for r in bindings}):
        role_classes[role]=('typed-preserve-exactly' if role.startswith(('preserve-','protected-')) else 'display-input-needs-binding-or-wording')
    role_classes.update({'needs-consumer-decision':'exact-owner-policy-required','special-display-codec':'case-specific-codec-contract','comparison-on-display':'display-identity-adapter-required','dormant-potential-display-source':'dormant-exact-source-hold'})
    by_case=collections.defaultdict(list)
    for b in bindings:
        id_=b['bindingId'];role=b['currentRole']
        b['roleClass']=role_classes[role]
        if id_ in policy_members:
            r=policy_members[id_]
            assert b['sourceValueSha256']==r['row']['sourceValueSha256']
            b['disposition']='owner-approved-preserve-original'
            b['policyReference']={'path':'localization/source/inventory-display-completion-20261028/approved-preservation.jsonl','line':r['line']}
        elif id_ in absent or b['source'] is None:
            b['disposition']='preserve-absent-state'
        elif id_ in dialogue_reviews and b['wordingReferences'] and dialogue_reviews[id_]['verdict']=='technical-preservation':
            b['disposition']='reuse-exact-dialogue-technical-preservation'
            b['priorReceipt']=dialogue_reviews[id_]
        elif b['wordingReferences']:
            b['disposition']='reuse-version-matching-accepted-wording;case-contract-separate'
            if id_ in dialogue_reviews:b['priorReceipt']=dialogue_reviews[id_]
        elif b['narrativeCompatibility']:
            b['disposition']='conditional-narrative-compatibility;no-target-application'
        elif b['caseId']=='inventory-glitch-fictional-trace' and role=='special-display-codec':
            b['disposition']='retain-exact-fictional-payload;accepted-windowed-display-contract'
        elif b['roleClass']=='typed-preserve-exactly':
            b['disposition']='reuse-exact-typed-preservation'
        elif b['roleClass']=='dormant-exact-source-hold':
            b['disposition']='retain-dormant-source;not-active-greeting-wording'
        else:
            b['disposition']='explicit-unbound-display-or-adaptation-dependency'
        if id_ in identity_by_id:
            n,r=identity_by_id[id_]
            assert r['sourceValueSha256']==b['sourceValueSha256']
            b['identityDependency']={'path':BASE+'compiled-display-identity-dependencies.json','rowIndex':n,'kind':r['kind'],'adaptation':r['adaptation']}
        b['newSemanticPass']=False
        by_case[b['caseId']].append(b)
    decisions=[];remaining=[];findings=[]
    for ordinal,(c,a) in enumerate(zip(registry['cases'],authored),1):
        rr=by_case[c['id']]
        assert len(rr)==len(c['sourceBindings'])
        refs=[dict(t,bindingId=r['bindingId']) for r in rr for t in r['wordingReferences']]
        pending=[r for r in rr if r['disposition'] in ['explicit-unbound-display-or-adaptation-dependency','conditional-narrative-compatibility;no-target-application']]
        binding_pairs=[{'id':b['id'],'sourceValueSha256':b['sourceValueSha256'],'role':b['role']} for b in c['sourceBindings']]
        dep=[{'id':r['bindingId'],'sourceValueSha256':r['sourceValueSha256'],'currentRole':r['currentRole'],'disposition':r['disposition']} for r in rr if not r['wordingReferences']]
        d=dict(a,ordinal=ordinal,locale='ru',scope={
            'selectorCount':len(rr),'distinctSelectorCount':len({r['bindingId'] for r in rr}),
            'sourceBindingsFingerprint':fingerprint(binding_pairs),
            'sourceBindingsRepresentation':'UTF-8 compact JSON ordered array of {id,sourceValueSha256,role}; no terminal LF',
            'acceptedTargetBindingCount':sum(bool(r['wordingReferences']) for r in rr),
            'acceptedTargetReferenceCount':len(refs),
            'distinctAcceptedTargetIds':len({(r['path'],r['targetId']) for r in refs}),
            'dependencyBindingCount':len(dep),'dependencyFingerprint':fingerprint(dep),
            'typedRoleCounts':dict(collections.Counter(r['currentRole'] for r in rr)),
            'dispositionCounts':dict(collections.Counter(r['disposition'] for r in rr)),
            'allSourceBindingsAccounted':True,
            'countBoundary':'Counts are memberships and overlap other cases; never sum as unique phrases.'},
            originalContract={k:c[k] for k in ['category','invariant','route','positive','negative','pendingDependencies']},
            registryReference={'path':BASE+'special-cases.json','caseOrdinal':ordinal},
            wordingReferences={'artifact':'wording-references.jsonl','caseId':c['id'],'bindings':sum(bool(r['wordingReferences']) for r in rr),'fingerprint':fingerprint(refs)},
            priorReceiptApplicability={'verifiedReceiptChecks':'receipt-verification.json','scope':'Only exact source/target versions and actual previous semantic/preservation verdicts. No new independent review from this reconciliation.','semanticRead':a['semanticRead']},
            readCoverage={'sourceBindingsDeterministicallyJoined':len(rr),'directSemanticReadDeclaration':a['semanticRead'],'unreadOrUnprovedDependencyBindingIds':[r['bindingId'] for r in pending],'boundary':'Deterministic joins and complete role accounting are not fresh linguistic reads.'},
            ordinaryTranslationEntryAllowed=False,sourceGateAccepted=False,wholeGameAccepted=False)
        decisions.append(d)
        remaining.append({'caseId':c['id'],'status':a['status'],'pendingBindingIds':[r['bindingId'] for r in pending],
            'pendingBindings':[{'id':r['bindingId'],'sourceValueSha256':r['sourceValueSha256'],'role':r['currentRole'],'disposition':r['disposition']} for r in pending],
            'allDependencyBindings':dep,'exactNextAction':a['nextFinitePermittedAction'],
            'unboundCrossSourceDependencies':c['pendingDependencies'],
            'currentUnprovedCasePredicate':None if a['status']=='accepted-evidence-reused' else {'seedBindingIds':[r['bindingId'] for r in rr], 'predicate':a['reason'], 'missingExternalOrCallbackIds':None, 'missingIdMeaning':'Where a dependency identity has not been bound by the owning source artifact it is explicitly unknown, not omitted or replaced by an invented translation ID. See exact next action.'},
            'historicalDependencyNote':'Historical descriptions are retained as provenance; current reason/next action supersede completed extraction/factory/role-policy counters.',
            'missingTranslationIdsInvented':False,'ordinaryEntryAllowed':False})
        if a['status']!='accepted-evidence-reused':
            findings.append({'caseId':c['id'],'status':a['status'],'reason':a['reason'],'selectorArtifact':'remaining-packet.json','exactNextAction':a['nextFinitePermittedAction']})
    # Write content artifacts first; Result is written only after exact validation.
    lines(OUT/'source-bindings.jsonl',bindings)
    lines(OUT/'wording-references.jsonl',[{'caseId':d['caseId'],'references':[dict(t,bindingId=r['bindingId']) for r in by_case[d['caseId']] for t in r['wordingReferences']]} for d in decisions])
    lines(OUT/'decisions.jsonl',decisions)
    write(OUT/'remaining-packet.json',remaining)
    write(OUT/'findings.json',findings)
    write(OUT/'role-dispositions.json',{'roleClasses':role_classes,'boundary':'Typed roles are consumed as an exact per-ID ledger; source spelling/regex matching never establishes preservation or semantic acceptance.'})
    write(OUT/'runtime-receipt-pin-checks.json',runtime_pin_checks)
    # Preserve reusable receipt provenance in the delivery directory.
    write(OUT/'receipt-verification.json',receipts)
    pins={}
    for p in ['initial-input-pins.json','verified-input-pins.json']:
        pins.update(json.loads((CHECK/p).read_text()))
    pins.update(PINS)
    write(OUT/'input-pins.json',pins)
    print('prepared',len(decisions),'cases',len(bindings),'memberships',len({r['bindingId'] for r in bindings}),'distinct selectors')

if __name__=='__main__':finalize()
