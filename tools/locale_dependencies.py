"""Current shared dependencies, reconciled with Russian mechanisms and exact reviews.

This consumes judgments; it does not generate votes, wording, release acceptance,
or permission to wake a model. Frozen results and execution inputs stay unchanged.
"""
import argparse
import hashlib
import json
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
REGISTRY='localization/completion/russian-reuse-20261030-01/registry.json'
OWNER_ACCEPTANCE='localization/completion/russian-owner-baseline-20261030-01/acceptance.json'


def require(ok, reason):
    if not ok:
        raise ValueError(reason)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def at(value, path):
    for key in path:
        value=value[key]
    return value


def unique(rows):
    result={row['id']:row for row in rows}
    require(len(result)==len(rows),'duplicate-dependency-review-id')
    return result


def verified_review(ev, claim):
    """Every assigned version, exact reviewer provenance; no inferred pass rows."""
    task=ev.json(claim['reviewTask']['path'],claim['reviewTask']['sha256'])['task']
    receipt=ev.json(claim['receipt']['path'],claim['receipt']['sha256'])
    direct=(ev.path(task['reviewPacket'])==ev.path(claim['packet']['path']) and
            task['reviewPacketSha256']==claim['packet']['sha256'])
    if not direct:
        require(bool(claim.get('legacyUnstampedPartitions')) and
                receipt.get('pins',{}).get(claim['packet']['path'])==claim['packet']['sha256'],
                'dependency-owning-review-packet')
    packet=unique(ev.row_list(claim['packet']['path'],claim['packet']['sha256']))
    judgments=unique(ev.row_list(claim['judgments']['path'],claim['judgments']['sha256']))
    require(set(packet)==set(judgments),'dependency-review-coverage')
    require(len(packet)==claim['expectedUnits'],'dependency-review-denominator')
    author=ev.json(claim['authorRuntime']['path'],claim['authorRuntime']['sha256'])
    actual=author['actualRuntime']
    require(actual['turn']=={'model':'gpt-6.1-sol','effort':'high'} and
            actual['session']['model_provider']=='openai' and
            actual['session']['parent_thread_id'] is None,'dependency-author-model')
    threads=set()
    for pin in claim['reviewerRuntimes']:
        runtime=ev.json(pin['path'],pin['sha256']);actual=runtime['actualRuntime']
        require(actual['turn']=={'model':'gpt-6.1-sol','effort':'high'} and
                actual['session']['model_provider']=='openai' and
                actual['session']['parent_thread_id'] is None,'dependency-review-model')
        require(runtime['threadId']!=author['threadId'],'dependency-review-independence')
        threads.add(runtime['threadId'])
    legacy={}
    for partition in claim.get('legacyUnstampedPartitions',[]):
        pin=partition['judgments']
        original=unique(ev.row_list(pin['path'],pin['sha256']))
        result=ev.json(partition['result']['path'],partition['result']['sha256'])
        runtime=ev.json(partition['runtime']['path'],partition['runtime']['sha256'])
        require(runtime['threadId'] in threads and result['reviews']==pin['path'] and
                pin in result['evidence'],'legacy-review-owning-result')
        require(len(original)==partition['expectedUnits'],'legacy-review-denominator')
        assigned=partition['assignedPacket']
        require(ev.path(task['reviewPacket'])==ev.path(assigned['path']) and
                task['reviewPacketSha256']==assigned['sha256'],'legacy-assigned-packet')
        assigned_rows=unique(ev.row_list(assigned['path'],assigned['sha256']))
        require(set(assigned_rows)==set(original) and
                all(assigned_rows[id_]==packet.get(id_) for id_ in assigned_rows),'legacy-assigned-versions')
        for id_,row in original.items():
            require(id_ in judgments and id_ not in legacy and
                    judgments[id_].get('reviewEvidence')==pin['path'] and
                    all(judgments[id_].get(k)==v for k,v in row.items()),'legacy-review-exact-row')
            legacy[id_]=partition
    for id_,row in packet.items():
        review=judgments[id_]
        require(review.get('reviewed') is not False and review.get('verdict') in ('pass','clean') and
                isinstance(review.get('rationale'),str) and bool(review['rationale'].strip()),
                'dependency-review-not-passed:'+id_)
        if 'reviewerThreadId' in review:
            require(review['reviewerThreadId'] in threads,'dependency-review-thread:'+id_)
        else:
            require(id_ in legacy,'dependency-review-thread:'+id_)
        for key in ['source','target']:
            require(digest(row[key].encode())==row[key+'Sha256']==review[key+'Sha256'],
                    'dependency-review-version:'+id_)
    for check in claim['assertions']:
        require(at(receipt,check['path'])==check['equals'],'dependency-receipt-scope:'+claim['id'])
    for pin in claim['artifacts']:
        ev.read(pin['path'],pin['sha256'])
    return dict(id=claim['id'],status=claim['acceptedStatus'],reviewedUnits=len(packet),
                legacyFileBoundRows=len(legacy),
                receipt=claim['receipt'],applicationAllowed=False,linguisticCoverageAdded=0)


def reconcile(ev):
    data=ev.json(REGISTRY)
    require(data['schemaVersion']==1,'dependency-registry-schema')
    for pin in data['pins']:
        ev.read(pin['path'],pin['sha256'])
    source_pin=data['canonicalSourceManifest']
    source_version_matched=digest(ev.read(source_pin['path']))==source_pin['sha256']
    ru=data['russianReference']
    manifest=ev.json(ru['manifest']);build=ev.json(ru['build'])
    require(manifest['candidate']==str(Path(ru['build']).parent),'russian-reference-identity')
    require(build['siteLocale']=='ru' and build['sourceManifestSha256']==
            digest(ev.read(ru['sourceManifest'])),'russian-source-version')
    owner=ev.json(OWNER_ACCEPTANCE)
    require(owner['authority']=='owner' and owner['accepted'] is True and owner['locale']=='ru' and
            owner['gameVersion']=='0.45' and owner['sharedMechanismReuseAllowed'] is True,'russian-owner-acceptance')
    require(owner['artifact']['path']==ru['manifest'] and owner['artifact']['sha256']==digest(ev.read(ru['manifest'])) and
            owner['sourceManifest']['path']==ru['sourceManifest'] and
            owner['sourceManifest']['sha256']==digest(ev.read(ru['sourceManifest'])),'russian-owner-artifact-version')
    require(owner['targetLocaleAcceptanceGranted'] is False and owner['targetEditorialAcceptanceGranted'] is False and
            owner['targetFontAndNativeAcceptanceGranted'] is False,'russian-owner-target-boundary')
    families=[]
    spec=ev.json(data['processSpec'])
    require(len(unique(data['families']))==len(spec['families']) and
            {r['id'] for r in data['families']}=={r['id'] for r in spec['families']},'dependency-family-coverage')
    for row in data['families']:
        for pointer in row['buildPointers']:
            require(bool(at(build,pointer)),'russian-mechanism-missing:'+row['id'])
        current=dict(row,applicationAllowed=False,localeWordingAccepted=False,nativeAccepted=False,
                     historicalReferenceStatus=row['referenceStatus'])
        current['referenceStatus']='owner-accepted-Russian-baseline-behavior'
        current['nextAction']='Port the accepted Russian implementation and its selection/preservation policy using own-locale reviewed targets. Validate actual target font/layout differences; do not repeat unchanged baseline research.'
        families.append(current)
    approvals={claim['id']:verified_review(ev,claim) for claim in data['approvals']}
    require(len(approvals)==len(data['approvals']),'duplicate-dependency-approval')
    decision=ev.json(data['parentDecision'])
    require(decision['operation']=='accept-exact-technical-preservation' and
            decision['commonSourceAccepted'] is False and decision['sourceExclusions']==[] and
            decision['translationEntryAllowed'] is False,'parent-decision-scope')
    policies=ev.json(data['originalPolicies'])['rows']
    require(len(policies)==len(decision['selectors'])==3,'exact-three-policy-scope')
    before=unique(policies);after=unique(decision['selectors'])
    require(set(before)==set(after),'parent-policy-selectors')
    methods={r['method']:r for r in ev.row_list(ru['haikuStageMethodReadback'])}
    for id_,row in before.items():
        selected=after[id_]
        require(all(row[k]==selected[k] for k in ['source','sourceSha256','sourceValueSha256','field','method']),
                'parent-policy-original-version')
        method=methods[row['method']]
        require(method['changed'] is False and method['definitionBefore']==method['definitionAfter'] and
                method['bodyBefore']==method['bodyAfter'],'russian-policy-method-changed')
        require(selected['policy']=='preserve-identity-including-any-echo' and
                selected['displayAbsenceProved'] is False,'parent-policy-not-a-source-exclusion')
    require(data['policyApprovalId'] in approvals,'parent-policy-independent-review')
    base=ev.json(data['baseGateMatrix'])
    gates=[]
    for row in base['predicates']:
        if row['id']==decision['predicateId']:
            gates.append(dict(id=row['id'],status='accepted-exact-preservation-policy',
                remainingMissingFacts=[],nextPermittedAction='Retain exact identities; no unchanged field scan or policy review.',
                acceptance=decision['scope']))
        else:
            update=data['gateUpdates'].get(row['id'],{})
            gates.append(dict(id=row['id'],status='held',remainingMissingFacts=update.get('remainingMissingFacts',row['remainingMissingFacts']),
                              nextPermittedAction=update.get('nextPermittedAction',row['nextPermittedAction'])))
    require(sum(r['status']=='accepted-exact-preservation-policy' for r in gates)==1 and len(gates)==5,
            'unexpected-source-gate-promotion')
    for gate in gates:
        gate['historicalStatus']=gate['status']
        gate['blocksRussianBaselineReuse']=False
        if gate['status']=='held':
            gate['status']='superseded-as-baseline-reuse-blocker-by-owner-acceptance'
            gate['historicalMissingFacts']=gate.pop('remainingMissingFacts')
            gate['remainingMissingFacts']=[]
            gate['nextPermittedAction']='Reuse the accepted Russian implementation. Require evidence only for a concrete target-locale difference; do not reopen unchanged baseline behavior.'
    locales={}
    for locale,entry in data['locales'].items():
        blocked=ev.json(entry['owningBlockedResult'])
        require(blocked['outcome']=='blocked','dependency-owning-blocked-result')
        closed=[]
        for correction in entry['closedWaits']:
            require(correction['approvalId'] in approvals,'unverified-dependency-correction')
            closed.append(correction)
        locales[locale]=dict(owningBlockedResult=entry['owningBlockedResult'],closedWaits=closed,
            completedSubdependencies=[approvals[id_] for id_ in entry['completedSubdependencies']],
            remaining=owner['coordinatorFollowUp'][locale],
            sharedHeldCategories=0,waitingFor='actual-target-port-and-locale-specific-work',
            newLanguageIds=[],newModelWakeAllowed=False,applicationAllowed=False,ready=False)
    return dict(schemaVersion=1,families=families,approvals=list(approvals.values()),gates=gates,locales=locales,
                inputBindings=[pin for pin in data['pins'] if any(pin['path']==entry['owningBlockedResult'] for entry in data['locales'].values())],
                russianReference=ru,sourceExclusions=[],commonSourceAccepted=False,translationEntryAllowed=False,
                russianOwnerAcceptance=owner,sharedBaseAccepted=True,
                currentSourceVersionMatched=source_version_matched,
                newModelWakeAllowed=False,ready=False,scope='Dependency reconciliation and exact technical-preservation policy only.')


def current_lane_state(row, dependencies):
    entry=dependencies['locales'].get(row['locale'])
    if entry is None or row['laneStatus']!='blocked' or not dependencies['currentSourceVersionMatched']:
        return None
    pin=next((p for p in dependencies['inputBindings'] if p['path']==entry['owningBlockedResult']),None)
    if pin is None or row.get('lastResult')!=pin:
        return None
    return entry


def main():
    from locale_progress import Evidence
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--json',action='store_true');args=parser.parse_args()
    ev=Evidence(ROOT);result=reconcile(ev);ev.stable()
    if args.json:
        print(json.dumps(dict(result,evidencePins=ev.pins),ensure_ascii=False,indent=2))
    else:
        if not result['currentSourceVersionMatched']:
            print('Canonical source admission changed; the historical dependency overlay needs reconciliation.')
            return
        print('Russian localization: accepted by the owner. Shared baseline reuse: allowed for all 28 families.')
        for locale,entry in result['locales'].items():
            print(locale+': '+str(len(entry['closedWaits']))+' obsolete waits removed; '+
                  '; '.join(entry['remaining']))


if __name__=='__main__':main()
