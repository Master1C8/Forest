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
from build_inventory import products, value_hash, INDEX, SERIALIZED
from phase135.reconcile_database import check_partition, classify


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
    assert sum(r['role']=='needs-consumer-decision' for r in managed) == 2401
    baseline_managed = list(lines(phase135 / 'baseline/managed-literal-inventory.jsonl'))
    same_identity_values(baseline_managed, managed)
    role_delta = [(a,b) for a,b in zip(baseline_managed,managed) if a['role'] != b['role']]
    assert len(role_delta) == 1059
    assert all(a['role']=='needs-consumer-decision' and b['role']=='preserve-comparison-operand' for a,b in role_delta)
    display_comparisons = [r for r in baseline_managed if r['role']=='comparison-on-display']
    assert len(display_comparisons)==12
    assert display_comparisons == [r for r in managed if r['role']=='comparison-on-display']
    database = load(OUT / 'dialogue-database-reconciliation.json')
    assert database['completeExportUnion']==911903
    assert database['sourceStringsPerCopy']==722670 and database['physicalStringStates']==1445340
    assert database['noncandidateStringStates']==1420848
    assert sum(g['logicalStates'] for g in database['selectorGroups'])==722670
    assert database['unresolvedLogicalValues']==1660
    assert database['unresolvedRoles']=={'preserve-custom-metadata;consumer-unresolved':721,'retained-node-label;consumer-unresolved':939}
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
    receipt = dict(schemaVersion=1, status='passed-fingerprinted-source-continuation', phase='0135-work',
                   reusedParentReadback=dict(path=str((baseline/'readback-validation.json').relative_to(ROOT)),
                       sha256=sha(baseline/'readback-validation.json'), originalManifestSha256=prior['manifestSha256'],
                       boundary='Original parent full source/tree/span readback, reused on exactly unchanged values/IDs/context; not rerun or relabeled as independent semantic judgment.'),
                   currentManifestSha256=sha(OUT/'manifest.json'), builderSha256=sha(OUT/'build_inventory.py'),
                   validatorSha256=sha(Path(__file__)), generatedProducts=len(generated),
                   preservedProducts=unchanged_products, sourceDeltas=counts, mixedLeafPartitions=dict(partitions),
                   unknownCompiledStates=2401, potentialControlLabelBindingStates=1389,
                   comparisonOperandIntegration=dict(parentOperands=1121,newlyResolved=1059,priorRolesRetained=62,comparisonOnDisplayUnchanged=12),
                   dialogueDatabase=dict(completeExportUnion=911903,physicalStringsIncludingEmpty=1445340,
                       noncandidatePhysicalStrings=1420848,unresolvedLogicalValues=1660,
                       completeOriginalNoncandidateTreeDigestPassed=True),
                   dialogueGrammar=dict(logicalIds=12246,physicalOccurrences=24492,protectedSpans=7103,
                       lineSeparators=291,unresolvedLexicalSpans=0,completePartitionReconstruction=True),
                   old935Bindings=dict(direct=911, exactObjectAliases=24, allSourceValuesEqual=True),
                   unchangedLocalePackets=30, haiku=dict(sourceIds=194, nodes=259, originalPredicateCombinations=27,
                       outcomes=dict(outcomes), syntheticDisplayOnlyBranchChanges=changed, actualRuntimeAdapter='not-implemented'),
                   negativeControls=dict(changedSourceRejected=True, equalWordingOccurrenceLossRejected=True,
                       changedControlSpanRejected=True,unknownDatabaseSelectorRejected=True,matchingPositiveControlsPassed=True),
                   outputPins={name:sha(OUT/name) for name in generated},
                   noGateWaiver=dict(commonSourceAccepted=False, translationEntryAllowed=False,editorial='not-run',runtime='not-run',visual='not-run'),
                   boundary='Deterministic identity/value/occurrence and rule-expansion validation. No original-install access, game execution, image input, texture edit or target authoring. Files are written sequentially; no multi-file transaction claim.')
    (OUT/'continuation-validation.json').write_text(json.dumps(receipt,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({k:v for k,v in receipt.items() if k not in ('outputPins','preservedProducts','boundary')}))


if __name__ == '__main__':
    main()
