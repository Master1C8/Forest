"""Validate the current source delta against the fingerprinted parent readback.

No extraction, original-install access, model call, GUI or semantic auto-pass.
The full parent tree/span readback is reused only on unchanged source values,
IDs, occurrence order and preserved context. Role judgments remain authored.
"""
import copy
import hashlib
import itertools
import json
from collections import Counter
from pathlib import Path

from prepare_context import ROOT, OUT, sha, load, lines
from build_inventory import products, value_hash, jl, INDEX, SERIALIZED, apply_compiled_role
from phase135.reconcile_database import check_partition, classify
from phase136.reconcile_roles import GREETING_ID, GREETING, classify_remaining
from phase137.expand_roles import expanded, first_typed_call


def same_identity_values(before, after):
    if [r['id'] for r in before] != [r['id'] for r in after]:
        raise ValueError('ordered-source-identities')
    if len({r['id'] for r in after}) != len(after):
        raise ValueError('duplicate-source-identity')
    for a, b in zip(before, after):
        if a['sourceValueSha256'] != b['sourceValueSha256']:
            raise ValueError('source-value:' + a['id'])
        if 'source' in a and 'source' in b and a['source'] != b['source']:
            raise ValueError('source-text:' + a['id'])


def main():
    phase137 = OUT / 'phase137'
    for name, digest in load(phase137 / 'baseline-pins.json').items():
        assert sha(phase137 / 'baseline' / name) == digest, ('preserved-phase136', name)
    phase136 = OUT / 'phase136'
    for name, digest in load(phase136 / 'baseline-pins.json').items():
        assert sha(phase136 / 'baseline' / name) == digest, ('preserved-phase135', name)
    phase135 = OUT / 'phase135'
    for name, digest in load(phase135 / 'baseline-pins.json').items():
        assert sha(phase135 / 'baseline' / name) == digest, ('preserved-phase134', name)
    phase = OUT / 'phase134'
    baseline = phase / 'baseline'
    for name, digest in load(phase / 'baseline-output-pins.json').items():
        assert sha(baseline / name) == digest, ('preserved-baseline', name)
    prior = load(baseline / 'readback-validation.json')
    assert prior['status'] == 'passed-exact-source-readback'
    for key, name in [('validatorSha256','validate.py'), ('builderSha256','build_inventory.py'), ('manifestSha256','manifest.json')]:
        assert prior[key] == sha(baseline / name), ('parent-readback-binding', key)
    original_manifest = load(baseline / 'manifest.json')
    manifest = load(OUT / 'manifest.json')
    rules = load(OUT / 'continuation-decisions.json')
    for name, digest in manifest['inputs'].items():
        assert sha(ROOT / name) == digest, ('current-input-fingerprint', name)
    # Source/manual input changes are forbidden. Only authored decision files
    # may differ from the archived parent manifest in this bounded extension.
    changed_inputs = {'localization/source/shared-source-completion-20261028/admission-v1/special-case-spec.json'}
    for name, digest in original_manifest['inputs'].items():
        if name not in changed_inputs:
            assert sha(ROOT / name) == digest, ('baseline-source-input-changed', name)
    generated = products()
    for name, data in generated.items():
        assert (OUT / name).read_bytes() == data, ('product-reproduction', name)

    unchanged_products = ['bgdatabase-inventory.jsonl', 'frozen-dialogue-bindings.jsonl',
                          'nodecanvas-preserve-exactly.jsonl', 'direct-context.jsonl',
                          'animator-context.jsonl', 'context-transforms.jsonl', 'animator-tmp-pairs.json']
    for name in unchanged_products:
        assert sha(OUT / name) == sha(baseline / name), ('unchanged-source-product', name)
    counts = {}
    for name in ['serialized-inventory.jsonl', 'managed-literal-inventory.jsonl']:
        before, after = list(lines(baseline / name)), list(lines(OUT / name))
        same_identity_values(before, after)
        counts[name] = dict(states=len(after), changedRoles=sum(a['role'] != b['role'] for a,b in zip(before,after)),
                            changedRecords=sum(a != b for a,b in zip(before,after)))
    serialized = list(lines(OUT / 'serialized-inventory.jsonl'))
    originals = list(lines(SERIALIZED))
    assert len(serialized) == len(originals) == 36107
    for source, row in zip(originals, serialized):
        assert source['id'] == row['id'] and value_hash(source['value']) == row['sourceValueSha256']
        if 'source' in row:
            assert row['source'] == source['value'], ('stored-source', row['id'])
    partitions = Counter(r['decision'] for r in serialized if r['decision'].startswith('phase134:'))
    assert sum(partitions.values()) == 1782
    assert sum('consumerBindingPredicate' in r for r in serialized) == 1389
    assert all(r['application'] == 'preserve-original-lookup-value;display-alias-binding-unverified'
               for r in serialized if 'consumerBindingPredicate' in r)
    assert partitions['phase134:keyboardActionLabel'] == 6
    assert partitions['phase134:keyboardSymbolLabel'] == 14
    assert partitions['phase134:keyboardLayout'] == 4

    managed = list(lines(OUT / 'managed-literal-inventory.jsonl'))
    original_il = list(lines(INDEX / 'literals.jsonl'))
    by_selector = {(r['method'],r['offset']):r for r in original_il}
    for row in rules['exactMethodLiterals']:
        assert value_hash(by_selector[row['method'],row['offset']]['value']) == row['sourceValueSha256']
    assert len(managed) == len(original_il) == 8576
    for source, row in zip(original_il, managed):
        assert (source['method'],source['offset'],value_hash(source['value'])) == (row['method'],row['offset'],row['sourceValueSha256'])
    assert sum(r['role']=='needs-consumer-decision' for r in managed) == 1583
    phase136_managed = list(lines(phase137 / 'baseline/managed-literal-inventory.jsonl'))
    same_identity_values(phase136_managed, managed)
    compiled_decisions = load(phase137 / 'compiled-role-decisions.json')
    assert compiled_decisions == expanded(), 'authored-compiled-expansion'
    exact_rules = {(r['method'],r['offset']):r for r in compiled_decisions['decisions']}
    changed_compiled = [(a,b) for a,b in zip(phase136_managed,managed) if a!=b]
    assert len(changed_compiled)==len(exact_rules)==817
    assert all(a['role']=='needs-consumer-decision' and b['role']==exact_rules[b['method'],b['offset']]['role'] for a,b in changed_compiled)
    reconstructed_phase136 = copy.deepcopy(managed)
    for r in reconstructed_phase136:
        if (r['method'],r['offset']) in exact_rules:
            r.update(role='needs-consumer-decision',decision='complete-index-unread-consumer')
            r.pop('source',None)
    assert jl(reconstructed_phase136)==(phase137/'baseline/managed-literal-inventory.jsonl').read_bytes(), 'unexpected-phase137-compiled-delta'
    # Independent guards check exact selector/value/typed consumer and rejection reason.
    rule = next(r for r in compiled_decisions['decisions'] if 'consumer' in r)
    source = by_selector[rule['method'],rule['offset']]
    one_rule = {(rule['method'],rule['offset']):rule}
    apply_compiled_role(source,'needs-consumer-decision',one_rule)
    for kind,reason in [('value','compiled-rule-value'),('selector','compiled-rule-selector'),('consumer','compiled-rule-consumer'),('role','compiled-rule-overwrites-accepted-role')]:
        altered_source,altered_rule=copy.deepcopy(source),copy.deepcopy(rule)
        prior_role='needs-consumer-decision'
        if kind=='value':altered_source['value']+='__changed__'
        if kind=='selector':altered_rule['id']+='__changed__'
        if kind=='consumer':altered_rule['consumer']['operand']='System.Void Changed::Sink(System.String)'
        if kind=='role':prior_role='comparison-on-display'
        try:
            apply_compiled_role(altered_source,prior_role,{(rule['method'],rule['offset']):altered_rule})
        except AssertionError as error:
            assert str(error)==reason,(kind,error)
        else:raise AssertionError('changed-compiled-contract-accepted:'+kind)
    assert first_typed_call(source)==rule['consumer']
    barrier=copy.deepcopy(source);barrier['after'][0]['opcode']='br.s'
    assert first_typed_call(barrier) is None,'typed-argument-crossed-branch'
    barrier=copy.deepcopy(source);barrier['after'][0]['opcode']='stloc.0'
    assert first_typed_call(barrier) is None,'typed-argument-crossed-store'
    adventure=list(lines(OUT.parent/'adventure-source/roster.jsonl'))
    assert len(adventure)==44 and Counter(r['role'] for r in adventure)=={'display-source':20,'preserve-adventure-identity':24}
    for r in adventure:
        assert exact_rules[r['method'],r['offset']]['sourceValueSha256']==r['sourceValueSha256']
    delta=list(lines(OUT/'compiled-source-role-delta.jsonl'))
    assert len(delta)==817 and sum(r['role']=='display-source' for r in delta)==20
    assert all(r['sourceValueSha256']==value_hash(by_selector[r['method'],r['offset']]['value']) for r in delta)
    assert sum('source' in r for r in delta)==20
    wording=list(lines(OUT/'compiled-wording-source.jsonl'))
    preserved=list(lines(OUT/'compiled-preserve-exactly.jsonl'))
    wording_ids={r['id'] for r in wording};preserved_ids={r['id'] for r in preserved}
    assert len(wording)==len(wording_ids)==91 and len(preserved)==len(preserved_ids)==6914
    assert wording_ids|preserved_ids=={r['id'] for r in managed if r['role']!='needs-consumer-decision'}
    assert wording_ids&preserved_ids=={r['id'] for r in managed if r['role']=='comparison-on-display'}
    for r in wording:
        assert r['source']==by_selector[r['method'],r['offset']]['value'],'compiled-wording-source'
    for r in preserved:
        source=original_il[r['sourceLine']-1]
        assert (source['method'],source['offset'],value_hash(source['value']))==(r['method'],r['offset'],r['sourceValueSha256']),'compiled-preserve-exact-source'
    handoff=load(OUT/'compiled-source-handoff.json')
    assert handoff['resolvedOccurrences']==6993 and handoff['unresolvedOccurrences']==1583
    assert handoff['completeCompiledRolePacket'] is False and handoff['translationEntryAllowed'] is False
    adventure_case=next(r for r in load(OUT/'special-cases.json')['cases'] if r['id']=='compiled-adventure-title-body-status')
    assert {r['id'] for r in adventure_case['sourceBindings']}=={r['id'] for r in adventure}
    next_selectors=load(phase137/'next-compiled-selectors.json')
    assert next_selectors['occurrences']==len(next_selectors['rows'])==255
    assert {r['id'] for r in next_selectors['rows']} <= {r['id'] for r in managed if r['role']=='needs-consumer-decision'}
    baseline_managed = list(lines(phase135 / 'baseline/managed-literal-inventory.jsonl'))
    same_identity_values(baseline_managed, managed)
    role_delta = [(a,b) for a,b in zip(baseline_managed,phase136_managed) if a['role'] != b['role']]
    assert len(role_delta) == 1060
    assert all(a['role']=='needs-consumer-decision' and
               (b['role']=='preserve-comparison-operand' or
                (b['id']==GREETING_ID and b['role']=='display-runtime-fast-travel-greeting' and b['source']==GREETING))
               for a,b in role_delta)
    assert sum(b['role']=='preserve-comparison-operand' for a,b in role_delta)==1059
    reconstructed_phase135 = copy.deepcopy(phase136_managed)
    greeting_row = next(r for r in reconstructed_phase135 if r['id']==GREETING_ID)
    greeting_row.update(role='needs-consumer-decision',decision='complete-index-unread-consumer')
    del greeting_row['source']
    assert hashlib.sha256(jl(reconstructed_phase135)).hexdigest()==load(phase136/'baseline/continuation-validation.json')['outputPins']['managed-literal-inventory.jsonl'], 'unexpected-phase136-compiled-delta'
    display_comparisons = [r for r in baseline_managed if r['role']=='comparison-on-display']
    assert len(display_comparisons)==12
    assert display_comparisons == [r for r in managed if r['role']=='comparison-on-display']
    database = load(OUT / 'dialogue-database-reconciliation.json')
    assert database['completeExportUnion']==911903
    assert database['sourceStringsPerCopy']==722670 and database['physicalStringStates']==1445340
    assert database['noncandidateStringStates']==1420848
    assert sum(g['logicalStates'] for g in database['selectorGroups'])==722670
    assert database['unresolvedLogicalValues']==1655
    assert database['unresolvedRoles']=={'preserve-custom-metadata;consumer-unresolved':721,'retained-node-label;consumer-unresolved':934}
    assert database['rolesPerCopy']['protected-fast-travel-selection-key']==8
    grammar_partitions = list(lines(OUT / 'dialogue-inline-partitions.jsonl'))
    frozen_rows = list(lines(OUT / 'frozen-dialogue-bindings.jsonl'))
    assert [r['id'] for r in grammar_partitions]==[r['id'] for r in frozen_rows]
    for source,row in zip(frozen_rows,grammar_partitions):
        assert row['occurrences']==source['occurrences']
        check_partition(source['source'],row)
    sample_partition=copy.deepcopy(grammar_partitions[0])
    check_partition(frozen_rows[0]['source'],sample_partition)
    sample_partition['partition'][0]['text']='[pic=7]'
    try:
        check_partition(frozen_rows[0]['source'],sample_partition)
    except AssertionError as error:
        assert str(error)=='partition-value'
    else:
        raise AssertionError('changed-control-span-accepted')
    try:
        classify({},'/unreviewedText','fixture',{},set())
    except ValueError as error:
        assert str(error)=='unread-string-selector:/unreviewedText'
    else:
        raise AssertionError('unknown-database-selector-accepted')
    potential = list(lines(OUT/'dialogue-database-values.jsonl'))
    occurrences = [i for r in potential for i in r['occurrences']]
    assert len(occurrences)==len(set(occurrences))==2*len(potential)
    assert all(r['translationId'] is None for r in potential)
    travel=load(OUT/'fast-travel-source-dependencies.json')
    registered_travel=next(r for r in load(OUT/'special-cases.json')['cases'] if r['id']==travel['id'])
    assert len(travel['sourceIds'])==7 and travel['customGreetingWriteTarget']==719
    assert 'ds:58:719:Dialogue Text' in travel['sourceIds']
    assert set(travel['sourceIds']) <= {r['id'] for r in registered_travel['sourceBindings']}
    assert travel['runtimeProducerIds']==[GREETING_ID]
    def validate_producer_binding(registry_case):
        if GREETING_ID not in {r['id'] for r in registry_case['sourceBindings']}:
            raise ValueError('missing-fast-travel-runtime-producer')
    validate_producer_binding(registered_travel)
    missing_producer=copy.deepcopy(registered_travel)
    missing_producer['sourceBindings']=[r for r in missing_producer['sourceBindings'] if r['id']!=GREETING_ID]
    try:
        validate_producer_binding(missing_producer)
    except ValueError as error:
        assert str(error)=='missing-fast-travel-runtime-producer'
    else:
        raise AssertionError('missing-runtime-producer-accepted')
    dispositions=load(OUT/'dialogue-database-consumer-dispositions.json')['values']
    previous=load(phase136/'baseline/dialogue-database-unresolved.json')['values']
    assert len(dispositions)==len(previous)==1660
    for old,new in zip(previous,dispositions):
        assert all(old[k]==new[k] for k in ('pointer','occurrences','source','sourceValueSha256'))
        assert new['consumerBoundary'] and new['remainingPredicate']
    assert Counter(r['role'] for r in dispositions if r['roleResolved'])=={
        'protected-dynamic-conversation-selection-key':4,'protected-story-event-comparison-key':1}
    assert [r for r in dispositions if not r['roleResolved']]==load(OUT/'dialogue-database-unresolved.json')['values']
    source_tree=load(ROOT/load(ROOT/'localization/source/dialogue-manifest.json')['sources'][0]['tree'])
    assert [classify_remaining(r,source_tree) for r in previous]==dispositions
    known_title=next(r for r in previous if (r.get('conversationId'),r.get('entryId'))==(109,5))
    classify_remaining(known_title,source_tree)
    altered_title=copy.deepcopy(known_title);altered_title['source']='__localized_identity__'
    try:
        classify_remaining(altered_title,source_tree)
    except AssertionError as error:
        assert error.args[0]==('known-title-value',(109,5))
    else:
        raise AssertionError('changed-known-title-accepted')
    old_values=[json.loads(s) for s in (phase136/'baseline/dialogue-database-values.jsonl').read_text().splitlines()]
    assert len(old_values)==len(potential)==10316
    for old,new in zip(old_values,potential):
        assert all(old[k]==new[k] for k in ('pointer','occurrences','source','sourceValueSha256'))
    # Independently reconstruct the five new and remaining934 Title group digests.
    from phase135.reconcile_database import encoded
    for group in database['selectorGroups']:
        if group['role'] in ('retained-node-label;consumer-unresolved','protected-dynamic-conversation-selection-key','protected-story-event-comparison-key'):
            rows=[r for r in dispositions if r['role']==group['role']]
            assert group['logicalStates']==len(rows)
            assert group['orderedPointerValueSha256']==hashlib.sha256(b''.join(encoded([r['pointer'],r['source']])+b'\n' for r in rows)).hexdigest()
    assert len([r for r in potential if r['role']=='protected-fast-travel-selection-key'])==8
    actual_protected=sum(p['kind'] not in ('ordinary-lexical-text;field-eligibility-separate','preserved-line-separator')
        for r in grammar_partitions for p in r['partition'])
    assert actual_protected==7103
    assert sum(p['kind']=='preserved-line-separator' for r in grammar_partitions for p in r['partition'])==291

    bindings = load(OUT / 'old935-selector-bindings.json')
    assert len(bindings) == len({r['id'] for r in bindings}) == len({r['sourceId'] for r in bindings}) == 935
    assert all(r['valueMatches'] is True for r in bindings)
    assert Counter(r['binding'] for r in bindings) == {'exact-occurrence':911, 'verified-exact-object-alias':24}
    additions = list(lines(OUT / 'additional-source-selectors.jsonl'))
    assert not ({r['id'] for r in additions} & {r['sourceId'] for r in bindings})
    packets = load(ROOT / 'localization/supplemental-ui/20261027/manifest.json')
    coverage = load(OUT / 'thirty-locale-coverage.json')
    assert len(coverage) == 30 and all(r['existingUnits'] == 935 for r in coverage)
    for r in coverage:
        p = ROOT / 'localization/supplemental-ui/20261027' / (r['locale']+'.jsonl')
        assert sha(p) == r['unchangedPacketSha256'] == packets['locales'][r['locale']]['sha256']

    haiku = load(phase / 'haiku-source-dependencies.json')
    assert sha(phase / 'haiku-source-context.json') == haiku['contextSha256']
    frozen = {r['id']:r for r in lines(OUT / 'frozen-dialogue-bindings.jsonl')}
    assert len(haiku['sourceIds']) == len(set(haiku['sourceIds'])) == 194
    assert all(i in frozen for i in haiku['sourceIds'])
    registry = load(OUT / 'special-cases.json')
    registered = next(r for r in registry['cases'] if r['id']=='haiku-group')
    assert set(haiku['sourceIds']) <= {r['id'] for r in registered['sourceBindings']}
    assert set(haiku['comparisonLiteralIds']) <= {r['id'] for r in registered['sourceBindings']}
    expected_combinations = list(itertools.product(*haiku['choiceSlots']))
    assert [tuple(r['ids']) for r in haiku['originalPredicateReplay']] == expected_combinations
    outcomes = Counter()
    changed = 0
    for row in haiku['originalPredicateReplay']:
        wording = [frozen[i]['source'] for i in row['ids']]
        outcome = next((b['arc'] for b in haiku['branchContracts']
                        if all(k in s.lower() for k,s in zip(b['keywords'],wording))), 'mixed_ending')
        assert outcome == row['sourceEnding']
        outcomes[outcome] += 1
        changed += row['displayOnlyChangesOutcome']
    assert outcomes == {'bridge_ending':1,'penny_ending':1,'bug_ending':1,'mixed_ending':24} and changed == 3

    # Matched negative controls change only the boundary being checked.
    sample = next(r for r in serialized if r['decision']=='phase134:keyboardActionLabel')
    same_identity_values([sample], [copy.deepcopy(sample)])
    altered = copy.deepcopy(sample); altered['sourceValueSha256'] = value_hash('__changed_action_label__')
    try:
        same_identity_values([sample], [altered])
    except ValueError as e:
        assert str(e) == 'source-value:' + sample['id']
    else:
        raise AssertionError('changed-source-accepted')
    same_wording = [r for r in serialized if r.get('source') == sample['source']][:2]
    assert len(same_wording) == 2 and same_wording[0]['id'] != same_wording[1]['id']
    same_identity_values(same_wording, copy.deepcopy(same_wording))
    try:
        same_identity_values(same_wording, same_wording[:1])
    except ValueError as e:
        assert str(e) == 'ordered-source-identities'
    else:
        raise AssertionError('equal-wording-occurrence-loss-accepted')
    assert manifest['commonSourceAccepted'] is False and manifest['translationEntryAllowed'] is False
    receipt = dict(schemaVersion=1, status='passed-fingerprinted-source-continuation', phase='0137-work',
                   reusedParentReadback=dict(path=str((baseline/'readback-validation.json').relative_to(ROOT)),
                       sha256=sha(baseline/'readback-validation.json'), originalManifestSha256=prior['manifestSha256'],
                       boundary='Original parent full source/tree/span readback, reused on exactly unchanged values/IDs/context; not rerun or relabeled as independent semantic judgment.'),
                   currentManifestSha256=sha(OUT/'manifest.json'), builderSha256=sha(OUT/'build_inventory.py'),
                   validatorSha256=sha(Path(__file__)), generatedProducts=len(generated),
                   preservedProducts=unchanged_products, sourceDeltas=counts, mixedLeafPartitions=dict(partitions),
                   unknownCompiledStates=1583, potentialControlLabelBindingStates=1389,
                   phase137CompiledDelta=dict(changedRoles=817,displayOperands=20,preservedOperands=797,
                       parentAdventureOperands=44,remainingMethods=543,priorWholeProductReconstructedExactly=True,
                       nextCommandSelectors=255,knownWordingOperands=91,allProtectedOperands=6914,
                       sharedComparisonDependencies=12,resolvedPartition=6993,completeCompiledPacket=False),
                   phase136CompiledDelta=dict(changedRoles=1,id=GREETING_ID,priorWholeProductReconstructedExactly=True),
                   comparisonOperandIntegration=dict(parentOperands=1121,newlyResolved=1059,priorRolesRetained=62,comparisonOnDisplayUnchanged=12),
                   dialogueDatabase=dict(completeExportUnion=911903,physicalStringsIncludingEmpty=1445340,
                       noncandidatePhysicalStrings=1420848,unresolvedLogicalValues=1655,
                       assignedConsumerDispositions=1660,resolvedTitleControlKeys=5,
                       completeOriginalNoncandidateTreeDigestPassed=True),
                   dialogueGrammar=dict(logicalIds=12246,physicalOccurrences=24492,protectedSpans=7103,
                       lineSeparators=291,unresolvedLexicalSpans=0,completePartitionReconstruction=True),
                   old935Bindings=dict(direct=911, exactObjectAliases=24, allSourceValuesEqual=True),
                   unchangedLocalePackets=30, haiku=dict(sourceIds=194, nodes=259, originalPredicateCombinations=27,
                       outcomes=dict(outcomes), syntheticDisplayOnlyBranchChanges=changed, actualRuntimeAdapter='not-implemented'),
                   negativeControls=dict(changedSourceRejected=True, equalWordingOccurrenceLossRejected=True,
                       changedControlSpanRejected=True,unknownDatabaseSelectorRejected=True,
                       changedKnownTitleRejected=True,missingRuntimeProducerRejected=True,matchingPositiveControlsPassed=True),
                   outputPins={name:sha(OUT/name) for name in generated},
                   noGateWaiver=dict(commonSourceAccepted=False, translationEntryAllowed=False,editorial='not-run',runtime='not-run',visual='not-run'),
                   boundary='Deterministic identity/value/occurrence and rule-expansion validation. No original-install access, game execution, image input, texture edit or target authoring. Files are written sequentially; no multi-file transaction claim.')
    receipt['negativeControls'].update(changedCompiledValueRejected=True,changedCompiledSelectorRejected=True,
        changedCompiledConsumerRejected=True,acceptedRoleOverwriteRejected=True,typedArgumentBranchBarrier=True,typedArgumentStoreBarrier=True)
    (OUT/'continuation-validation.json').write_text(json.dumps(receipt,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({k:v for k,v in receipt.items() if k not in ('outputPins','preservedProducts','boundary')}))


if __name__ == '__main__':
    main()
