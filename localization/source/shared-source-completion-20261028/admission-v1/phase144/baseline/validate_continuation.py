"""Validate the current source delta against the fingerprinted parent readback.

No extraction, original-install access, model call, GUI or semantic auto-pass.
The full parent tree/span readback is reused only on unchanged source values,
IDs, occurrence order and preserved context. Role judgments remain authored.
"""
import copy
import contextlib
import hashlib
import io
import itertools
import json
import sys
import tempfile
from collections import Counter
from pathlib import Path
from unittest.mock import patch

import build_inventory as builder_module

from prepare_context import ROOT, OUT, sha, load, lines
from build_inventory import products, value_hash, jl, INDEX, SERIALIZED, apply_compiled_role
from phase135.reconcile_database import check_partition, classify, get
from phase136.reconcile_roles import GREETING_ID, GREETING, classify_remaining
from phase137.expand_roles import expanded, first_typed_call
from phase138.expand_roles import expanded as expanded_commands, registration
from phase139.expand_roles import expanded as expanded_console, validate_rule as validate_console_rule, method_bodies
from phase140.expand_roles import expanded as expanded_playback, validate_rule as validate_playback_rule
from phase141.expand_roles import expanded as expanded_arc, validate_rule as validate_arc_rule, METHOD as ARC_METHOD
from phase142.expand_roles import expanded as expanded_loader, validate_rule as validate_loader_rule
from phase143.reconcile_bindings import refine as refine_binding, analyze_lua, validate_selector as validate_binding_selector, NEXT as NEXT_SOURCE


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
    phase143 = OUT / 'phase143'
    for name, digest in load(phase143 / 'baseline-pins.json').items():
        assert sha(phase143 / 'baseline' / name) == digest, ('preserved-phase142', name)
    phase142 = OUT / 'phase142'
    for name, digest in load(phase142 / 'baseline-pins.json').items():
        assert sha(phase142 / 'baseline' / name) == digest, ('preserved-phase141', name)
    phase141 = OUT / 'phase141'
    for name, digest in load(phase141 / 'baseline-pins.json').items():
        assert sha(phase141 / 'baseline' / name) == digest, ('preserved-phase140', name)
    phase140 = OUT / 'phase140'
    for name, digest in load(phase140 / 'baseline-pins.json').items():
        assert sha(phase140 / 'baseline' / name) == digest, ('preserved-phase139', name)
    phase139 = OUT / 'phase139'
    for name, digest in load(phase139 / 'baseline-pins.json').items():
        assert sha(phase139 / 'baseline' / name) == digest, ('preserved-phase138', name)
    phase138 = OUT / 'phase138'
    for name, digest in load(phase138 / 'baseline-pins.json').items():
        assert sha(phase138 / 'baseline' / name) == digest, ('preserved-phase137', name)
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
    assert sum(r['role']=='needs-consumer-decision' for r in managed) == 1251
    phase141_managed = list(lines(phase142 / 'baseline/managed-literal-inventory.jsonl'))
    phase140_managed = list(lines(phase141 / 'baseline/managed-literal-inventory.jsonl'))
    phase139_managed = list(lines(phase140 / 'baseline/managed-literal-inventory.jsonl'))
    phase138_managed = list(lines(phase139 / 'baseline/managed-literal-inventory.jsonl'))
    phase137_managed = list(lines(phase138 / 'baseline/managed-literal-inventory.jsonl'))
    phase136_managed = list(lines(phase137 / 'baseline/managed-literal-inventory.jsonl'))
    same_identity_values(phase136_managed, managed)
    compiled_decisions = load(phase137 / 'compiled-role-decisions.json')
    assert compiled_decisions == expanded(), 'authored-compiled-expansion'
    exact_rules = {(r['method'],r['offset']):r for r in compiled_decisions['decisions']}
    changed_compiled = [(a,b) for a,b in zip(phase136_managed,phase137_managed) if a!=b]
    assert len(changed_compiled)==len(exact_rules)==817
    assert all(a['role']=='needs-consumer-decision' and b['role']==exact_rules[b['method'],b['offset']]['role'] for a,b in changed_compiled)
    reconstructed_phase136 = copy.deepcopy(phase137_managed)
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
    delta=list(lines(phase138/'baseline/compiled-source-role-delta.jsonl'))
    assert len(delta)==817 and sum(r['role']=='display-source' for r in delta)==20
    assert all(r['sourceValueSha256']==value_hash(by_selector[r['method'],r['offset']]['value']) for r in delta)
    assert sum('source' in r for r in delta)==20
    wording=list(lines(OUT/'compiled-wording-source.jsonl'))
    preserved=list(lines(OUT/'compiled-preserve-exactly.jsonl'))
    wording_ids={r['id'] for r in wording};preserved_ids={r['id'] for r in preserved}
    assert len(wording)==len(wording_ids)==185 and len(preserved)==len(preserved_ids)==7152
    assert wording_ids|preserved_ids=={r['id'] for r in managed if r['role']!='needs-consumer-decision'}
    assert wording_ids&preserved_ids=={r['id'] for r in managed if r['role']=='comparison-on-display'}
    for r in wording:
        assert r['source']==by_selector[r['method'],r['offset']]['value'],'compiled-wording-source'
    for r in preserved:
        source=original_il[r['sourceLine']-1]
        assert (source['method'],source['offset'],value_hash(source['value']))==(r['method'],r['offset'],r['sourceValueSha256']),'compiled-preserve-exact-source'
    handoff=load(OUT/'compiled-source-handoff.json')
    assert handoff['resolvedOccurrences']==7325 and handoff['unresolvedOccurrences']==1251
    assert handoff['completeCompiledRolePacket'] is False and handoff['translationEntryAllowed'] is False
    adventure_case=next(r for r in load(OUT/'special-cases.json')['cases'] if r['id']=='compiled-adventure-title-body-status')
    assert {r['id'] for r in adventure_case['sourceBindings']}=={r['id'] for r in adventure}
    next_selectors=load(phase137/'next-compiled-selectors.json')
    assert next_selectors['occurrences']==len(next_selectors['rows'])==255
    assert {r['id'] for r in next_selectors['rows']} <= {r['id'] for r in phase137_managed if r['role']=='needs-consumer-decision'}

    # New145 exact identities reconstruct the WHOLE prior product, retaining all817
    # prior role decisions, precise metadata and original occurrence order.
    authored_commands, expected_dependencies, expected_remaining = expanded_commands()
    assert load(phase138/'compiled-role-decisions.json')==authored_commands, 'command-authored-expansion'
    command_rules={(r['method'],r['offset']):r for r in authored_commands['decisions']}
    assert len(command_rules)==145
    command_changed=[(a,b) for a,b in zip(phase137_managed,phase138_managed) if a!=b]
    assert len(command_changed)==145
    assert all(a['role']=='needs-consumer-decision' and b['role']==command_rules[b['method'],b['offset']]['role'] for a,b in command_changed)
    reconstructed_phase137=copy.deepcopy(phase138_managed)
    for r in reconstructed_phase137:
        if (r['method'],r['offset']) in command_rules:
            r.update(role='needs-consumer-decision',decision='complete-index-unread-consumer')
            r.pop('source',None)
    assert jl(reconstructed_phase137)==(phase138/'baseline/managed-literal-inventory.jsonl').read_bytes(), 'unexpected-phase138-compiled-delta'
    current_delta=list(lines(phase139/'baseline/compiled-source-role-delta.jsonl'))
    assert len(current_delta)==145 and all(r['role'].startswith('preserve-') for r in current_delta)
    assert {r['id'] for r in current_delta}=={r['id'] for r in authored_commands['decisions']}
    assert all('source' not in r for r in current_delta), 'protected-delta-is-not-target-wording'
    command_rule=next(r for r in authored_commands['decisions'] if r['role']=='preserve-visible-command-identity')
    command_source=by_selector[command_rule['method'],command_rule['offset']]
    registration(command_source)
    apply_compiled_role(command_source,'needs-consumer-decision',{(command_rule['method'],command_rule['offset']):command_rule})
    for kind,reason in [('value','compiled-rule-value'),('selector','compiled-rule-selector'),('consumer','compiled-rule-consumer'),('role','compiled-rule-overwrites-accepted-role'),('producer','compiled-rule-producer-window')]:
        altered_source,altered_rule=copy.deepcopy(command_source),copy.deepcopy(command_rule)
        prior_role='needs-consumer-decision'
        if kind=='value':altered_source['value']+='__changed__'
        if kind=='selector':altered_rule['id']+='__changed__'
        if kind=='consumer':altered_rule['consumer']['operand']='System.Void Changed::Sink(System.String)'
        if kind=='role':prior_role='display-source'
        if kind=='producer':altered_source['before'][-4]['operand']='System.Void Changed::Command()'
        try:
            apply_compiled_role(altered_source,prior_role,{(command_rule['method'],command_rule['offset']):altered_rule})
        except AssertionError as error:assert str(error)==reason,(kind,error)
        else:raise AssertionError('changed-command-contract-accepted:'+kind)
    branch_source=copy.deepcopy(command_source);branch_source['before'][-2]['opcode']='br.s'
    try:registration(branch_source)
    except AssertionError as error:assert str(error)=='command-producer-window'
    else:raise AssertionError('command-producer-crossed-branch')
    registration_source=copy.deepcopy(command_source);registration_source['after'][1]['operand']='System.Void Changed::Register()'
    try:registration(registration_source)
    except AssertionError as error:assert str(error)=='command-registration-window'
    else:raise AssertionError('command-registration-changed')
    identity_dependencies=load(OUT/'compiled-display-identity-dependencies.json')
    registry=load(OUT/'special-cases.json')['cases']
    def validate_identity_dependencies(dependencies):
        assert dependencies['rows']==expected_dependencies,'command-display-dependency-membership'
        assert len(dependencies['rows'])==dependencies['occurrences']==120
        for row in dependencies['rows']:
            source=by_selector[row['method'],row['offset']]
            assert row['source']==source['value'] and row['sourceValueSha256']==value_hash(source['value'])
        for ident,kind in [('compiled-command-input-suggestion-identities','command-input-and-suggestion'),('compiled-simulation-scene-label-identities','scene-state-and-label')]:
            case=next(r for r in registry if r['id']==ident)
            assert {r['id'] for r in case['sourceBindings']}=={r['id'] for r in dependencies['rows'] if r['kind']==kind},'command-special-case-membership'
    validate_identity_dependencies(identity_dependencies)
    bad=copy.deepcopy(identity_dependencies);bad['rows'].pop()
    try:validate_identity_dependencies(bad)
    except AssertionError as error:assert str(error)=='command-display-dependency-membership'
    else:raise AssertionError('lost-displayed-identity-accepted')
    bad=copy.deepcopy(identity_dependencies);bad['rows'][0]['assembledCommand']+='__changed__'
    try:validate_identity_dependencies(bad)
    except AssertionError as error:assert str(error)=='command-display-dependency-membership'
    else:raise AssertionError('changed-command-insertion-accepted')
    next_commands=load(phase138/'next-compiled-selectors.json')
    assert next_commands['rows']==expected_remaining and len(expected_remaining)==next_commands['occurrences']==110
    assert len({r['method'] for r in expected_remaining})==next_commands['methods']
    assert {r['id'] for r in expected_remaining}<={r['id'] for r in phase138_managed if r['role']=='needs-consumer-decision'}
    assert {r['id'] for r in expected_remaining}.isdisjoint({r['id'] for r in authored_commands['decisions']})
    assert {r['id'] for r in expected_remaining}|{r['id'] for r in authored_commands['decisions']}=={r['id'] for r in next_selectors['rows']}
    assert handoff['visibleIdentityDependencies']['occurrences']==120 and handoff['newDelta']['occurrences']==29

    # Exact new110 source roles; whole prior product reconstruction rejects
    # accidental edits to any old role/metadata, not merely source values.
    console_decisions, console_context = expanded_console()
    assert load(phase139/'compiled-role-decisions.json') == console_decisions, 'console-authored-expansion'
    assert load(OUT/'compiled-console-source-context.json') == console_context, 'console-context-expansion'
    console_rules = {(r['method'],r['offset']):r for r in console_decisions['decisions']}
    assert len(console_rules)==110
    console_changed=[(a,b) for a,b in zip(phase138_managed,phase139_managed) if a!=b]
    assert len(console_changed)==110
    assert all(a['role']=='needs-consumer-decision' and b['role']==console_rules[b['method'],b['offset']]['role'] for a,b in console_changed)
    reconstructed_phase138=copy.deepcopy(phase139_managed)
    for r in reconstructed_phase138:
        if (r['method'],r['offset']) in console_rules:
            r.update(role='needs-consumer-decision',decision='complete-index-unread-consumer')
            r.pop('source',None)
    assert jl(reconstructed_phase138)==(phase139/'baseline/managed-literal-inventory.jsonl').read_bytes(), 'unexpected-phase139-compiled-delta'
    console_delta=list(lines(phase140/'baseline/compiled-source-role-delta.jsonl'))
    assert {r['id'] for r in console_delta}=={r['id'] for r in console_decisions['decisions']}
    assert len(console_delta)==110 and sum('source' in r for r in console_delta)==62
    assert console_decisions['roleCounts']=={'display-console-wording':62,'preserve-display-format':30,'preserve-database-identity':1,'preserve-search-ranking-key':4,'preserve-input-normalization':4,'preserve-search-assembly':2,'preserve-visible-filter-identity':7}
    assert len(console_context['groups'])==32
    assert {i for g in console_context['groups'] for i in g['wordingIds']}=={r['id'] for r in console_decisions['decisions'] if r['roleKind']=='W'}
    assert {i for g in console_context['groups'] for i in g['preserveIds']}=={r['id'] for r in console_decisions['decisions'] if r['roleKind']!='W'}
    assert len(console_context['displayedFilterDependencies'])==7
    console_case=next(r for r in registry if r['id']=='compiled-console-wording-and-filter-identities')
    assert {r['id'] for r in console_case['sourceBindings']}=={r['id'] for r in console_decisions['decisions']}
    # Matched positive and single-boundary negative controls.
    rule=next(r for r in console_decisions['decisions'] if r['roleKind']=='D')
    source=by_selector[rule['method'],rule['offset']]
    prior_console=next(r for r in phase138_managed if r['id']==rule['id'])
    body=method_bodies(phase138/'game-08.il')[rule['method']]
    validate_console_rule(source,prior_console,rule,body)
    for kind,reason in [('value','console-source-value'),('selector','console-selector'),('body','console-producer-body'),('role','console-role-membership'),('context','console-context-membership'),('placeholder','console-placeholder-contract'),('prior','console-prior-role')]:
        altered_source,altered_prior,altered_rule,altered_body=map(copy.deepcopy,[source,prior_console,rule,body])
        if kind=='value':altered_source['value']+='__changed__'
        if kind=='selector':altered_rule['sourceLine']+=1
        if kind=='body':altered_body[-1]['opcode']='throw'
        if kind=='role':altered_rule.update(roleKind='W',role='display-console-wording')
        if kind=='context':altered_rule['context']+='__changed__'
        if kind=='placeholder':altered_rule['placeholderContract']=['{99}']
        if kind=='prior':altered_prior['role']='comparison-on-display'
        try:validate_console_rule(altered_source,altered_prior,altered_rule,altered_body)
        except AssertionError as error:assert str(error)==reason,(kind,error)
        else:raise AssertionError('changed-console-contract-accepted:'+kind)
    # Replay only the observed filter/title predicates, not the CLR/game.
    # Full body fingerprints above bind the replay to original source semantics.
    filter_values=[r['source'] for r in console_context['displayedFilterDependencies']]
    def selected_types(values,token):
        return [v for v in values if token and len(token.strip())>=3 and token.lower() in v.lower()]
    assert selected_types(filter_values,'quest')==['quest']
    assert selected_types(filter_values,'choice')==['player choice']
    assert selected_types(filter_values,'fi')==[]
    assert selected_types(filter_values,' quest ')==[]  # original token is not trimmed for Contains
    altered_values=['__synthetic_caption__' if v=='quest' else v for v in filter_values]
    assert selected_types(altered_values,'quest')==[], 'display-only-replacement-must-break-original-filter'
    test_selection=console_context['testConversation']
    assert test_selection['key']=='system/testconvo'
    for source_copy in test_selection['copies']:
        assert source_copy['field']['title']=='Title' and source_copy['field']['value']==test_selection['key']
        assert source_copy['exactTitleMatches']==[dict(index=240,id=43)]
        assert source_copy['field']['value']!='__synthetic_title__', 'changed-title-must-fail-original-equality'
    assert handoff['displayedFilterDependencies']['occurrences']==7
    # No unchanged occurrence is silently removed by the next selector.
    next_family=load(phase139/'next-compiled-selectors.json')
    owners={'TheForestOfLove.Narrative.DialogueSystemLoader','TheForestOfLove.Narrative.DialogueService'}
    expected_family=[r for r in phase139_managed if r['role']=='needs-consumer-decision' and r['method'].split(' ',1)[1].split('::')[0] in owners]
    assert [r['id'] for r in next_family['rows']]==[r['id'] for r in expected_family]
    assert len(expected_family)==next_family['occurrences']==77
    assert len({r['method'] for r in expected_family})==next_family['methods']==26
    assert not {r['id'] for r in expected_remaining}&{r['id'] for r in managed if r['role']=='needs-consumer-decision'}

    # Playback23 is a real subset of the assigned77, not implicit coverage of
    # the saved loader bodies. Reconstruct every byte of the prior product.
    playback_decisions, playback_context, held_loader = expanded_playback()
    assert load(phase140/'compiled-role-decisions.json') == playback_decisions, 'playback-authored-expansion'
    assert load(OUT/'compiled-playback-source-context.json') == playback_context, 'playback-context-expansion'
    playback_rules = {(r['method'],r['offset']):r for r in playback_decisions['decisions']}
    playback_changed = [(a,b) for a,b in zip(phase139_managed,phase140_managed) if a!=b]
    assert len(playback_changed) == len(playback_rules) == 23
    assert all(a['role']=='needs-consumer-decision' and b['role']==playback_rules[b['method'],b['offset']]['role'] for a,b in playback_changed)
    reconstructed_phase139 = copy.deepcopy(phase140_managed)
    for r in reconstructed_phase139:
        if (r['method'],r['offset']) in playback_rules:
            r.update(role='needs-consumer-decision',decision='complete-index-unread-consumer')
            r.pop('source',None)
    assert jl(reconstructed_phase139) == (phase140/'baseline/managed-literal-inventory.jsonl').read_bytes(), 'unexpected-phase140-compiled-delta'
    playback_delta=list(lines(phase141/'baseline/compiled-source-role-delta.jsonl'))
    assert {r['id'] for r in playback_delta}=={r['id'] for r in playback_decisions['decisions']}
    assert len(playback_delta)==23 and sum('source' in r for r in playback_delta)==3
    assert playback_decisions['roleCounts']=={'display-conditional-unity-log-wording':3,'preserve-conversation-trigger-identity':2,'preserve-database-identity':3,'preserve-dialogue-entry-title-identity':11,'preserve-conversation-title-template':1,'preserve-lua-variable-key':2,'preserve-history-report-event-prefix':1}
    assert len(playback_context['groups'])==10
    assert {i for g in playback_context['groups'] for i in g['wordingIds']}=={r['id'] for r in playback_decisions['decisions'] if r['roleKind']=='W'}
    assert {i for g in playback_context['groups'] for i in g['preserveIds']}=={r['id'] for r in playback_decisions['decisions'] if r['roleKind']!='W'}
    playback_case=next(r for r in registry if r['id']=='compiled-playback-graph-and-conditional-diagnostics')
    assert {r['id'] for r in playback_case['sourceBindings']}=={r['id'] for r in playback_decisions['decisions']}
    remaining_loader=load(phase140/'next-compiled-selectors.json')
    assert remaining_loader['rows']==held_loader
    current_loader=[r for r in phase140_managed if r['role']=='needs-consumer-decision' and r['method'].split(' ',1)[1].split('::')[0] in owners]
    assert [r['id'] for r in current_loader]==[r['id'] for r in held_loader]
    assert len(held_loader)==remaining_loader['occurrences']==54 and len({r['method'] for r in held_loader})==16
    assert {r['id'] for r in held_loader}.isdisjoint({r['id'] for r in playback_decisions['decisions']})
    assert {r['id'] for r in held_loader}|{r['id'] for r in playback_decisions['decisions']}=={r['id'] for r in next_family['rows']}
    assert sum(r['role']=='needs-consumer-decision' for r in phase140_managed)-len(held_loader)==1251
    # Positive control reaches the intended boundary before each single change.
    rule=next(r for r in playback_decisions['decisions'] if r['contextKey']=='HandleDialogueLineActor')
    source=by_selector[rule['method'],rule['offset']]
    prior_playback=next(r for r in phase139_managed if r['id']==rule['id'])
    body=method_bodies(phase140/'service.il')[rule['method']]
    validate_playback_rule(source,prior_playback,rule,body)
    for kind,reason in [('value','playback-source-value'),('selector','playback-selector'),('body','playback-producer-body'),('role','playback-role-membership'),('context','playback-context-membership'),('placeholder','playback-placeholder-contract'),('prior','playback-prior-role'),('consumer','playback-consumer'),('argument','playback-argument-window')]:
        altered_source,altered_prior,altered_rule,altered_body=map(copy.deepcopy,[source,prior_playback,rule,body])
        if kind=='value':altered_source['value']+='__changed__'
        if kind=='selector':altered_rule['sourceLine']+=1
        if kind=='body':altered_body[-1]['opcode']='throw'
        if kind=='role':altered_rule.update(roleKind='K',role='preserve-lua-variable-key')
        if kind=='context':altered_rule['context']+='__changed__'
        if kind=='placeholder':altered_rule['placeholderContract']=['{99}']
        if kind=='prior':altered_prior['role']='comparison-on-display'
        if kind=='consumer':altered_rule['bodyConsumer']['offset']+=1
        if kind=='argument':altered_rule['bodyArgumentWindow']=[]
        try:validate_playback_rule(altered_source,altered_prior,altered_rule,altered_body)
        except AssertionError as error:assert str(error)==reason,(kind,error)
        else:raise AssertionError('changed-playback-contract-accepted:'+kind)
    # Replay the actual console bitmask predicate only; this does not execute
    # Unity native delivery, subscription, component activation or GUI.
    capture=lambda mask,level:(mask & level)==level
    assert capture(8,8) and capture(12,8) and not capture(4,8) and not capture(0,8)
    for proof in playback_context['consumerProofs']['methods']:
        assert proof['bodySha256']==value_hash(method_bodies(phase140/proof['path'])[proof['method']])
    assert handoff['playbackContext']=='compiled-playback-source-context.json'
    assert handoff['newDelta']['remainingSelected']==0
    # Arc25 changes only its exact prior unknown rows. Reconstruct the entire
    # prior compiled product byte-for-byte, including every precise old role.
    arc_decisions, arc_context, held_after_arc = expanded_arc()
    assert load(phase141/'compiled-role-decisions.json') == arc_decisions, 'arc-authored-expansion'
    assert load(OUT/'compiled-arc-source-context.json') == arc_context, 'arc-context-expansion'
    arc_rules = {(r['method'],r['offset']):r for r in arc_decisions['decisions']}
    arc_changed = [(a,b) for a,b in zip(phase140_managed,phase141_managed) if a!=b]
    assert len(arc_changed) == len(arc_rules) == 25
    assert all(a['role']=='needs-consumer-decision' and b['role']==arc_rules[b['method'],b['offset']]['role'] for a,b in arc_changed)
    reconstructed_phase140 = copy.deepcopy(phase141_managed)
    for r in reconstructed_phase140:
        if (r['method'],r['offset']) in arc_rules:
            r.update(role='needs-consumer-decision',decision='complete-index-unread-consumer')
            r.pop('source',None)
    assert jl(reconstructed_phase140) == (phase141/'baseline/managed-literal-inventory.jsonl').read_bytes(), 'unexpected-phase141-compiled-delta'
    arc_delta=list(lines(phase142/'baseline/compiled-source-role-delta.jsonl'))
    assert len(arc_delta)==25 and sum('source' in r for r in arc_delta)==11
    assert {r['id'] for r in arc_delta}=={r['id'] for r in arc_decisions['decisions']}
    assert arc_decisions['roleCounts']=={'potential-display-exception-wording':11,'preserve-exception-assembly-separator':9,'preserve-actor-plugin-lookup-key':2,'preserve-dialogue-entry-field-key':1,'preserve-generated-arc-identity-delimiter':2}
    complete_arc={r['id'] for r in arc_context['completeProducerLiterals']}
    assert complete_arc=={r['id'] for r in managed if r['method']==ARC_METHOD} and len(complete_arc)==33
    arc_case=next(r for r in registry if r['id']=='compiled-arc-keys-and-exception-assembly')
    assert {r['id'] for r in arc_case['sourceBindings']}==complete_arc, 'arc-registry-membership'
    assert set(arc_context['wordingIds'])=={r['id'] for r in arc_decisions['decisions'] if r['roleKind']=='W'}
    assert set(arc_context['preserveIds'])=={r['id'] for r in arc_decisions['decisions'] if r['roleKind']!='W'}
    assert len(arc_context['exceptionAssemblies'])==11
    assert {s for a in arc_context['exceptionAssemblies'] for s in a['separatorIds']}=={r['id'] for r in arc_decisions['decisions'] if r['roleKind']=='S'}
    remaining_arc=load(phase141/'next-compiled-selectors.json')
    assert remaining_arc['rows']==held_after_arc and remaining_arc['occurrences']==len(held_after_arc)==29
    assert remaining_arc['methods']==len({r['method'] for r in held_after_arc})==15
    assert {r['id'] for r in held_after_arc}.isdisjoint(arc_context['wordingIds']+arc_context['preserveIds'])
    assert {r['id'] for r in held_after_arc}|set(arc_context['wordingIds']+arc_context['preserveIds'])=={r['id'] for r in held_loader}
    assert [r['id'] for r in phase141_managed if r['role']=='needs-consumer-decision' and r['method'].split(' ',1)[1].split('::')[0] in owners]==[r['id'] for r in held_after_arc]
    assert sum(r['role']=='needs-consumer-decision' for r in phase141_managed)-len(held_after_arc)==1251
    assert handoff['arcContext']=='compiled-arc-source-context.json' and handoff['exceptionPresentation']=='unknown;ctor-and-throw-proved-only'
    rule=next(r for r in arc_decisions['decisions'] if r['roleKind']=='W')
    source=by_selector[rule['method'],rule['offset']]
    prior_arc=next(r for r in phase140_managed if r['id']==rule['id'])
    body=method_bodies(OUT/'phase135/arc-consumers.il')[ARC_METHOD]
    validate_arc_rule(source,prior_arc,rule,body)
    for kind,reason in [('value','arc-source-value'),('selector','arc-selector'),('body','arc-producer-body'),('role','arc-role-membership'),('context','arc-context-membership'),('prior','arc-prior-role'),('consumer','arc-consumer'),('argument','arc-argument-window'),('throw','arc-exception-throw'),('visibility','arc-visibility-boundary')]:
        altered_source,altered_prior,altered_rule,altered_body=map(copy.deepcopy,[source,prior_arc,rule,body])
        if kind=='value':altered_source['value']+='__changed__'
        if kind=='selector':altered_rule['sourceLine']+=1
        if kind=='body':altered_body[-1]['opcode']='throw'
        if kind=='role':altered_rule.update(roleKind='A',role='preserve-actor-plugin-lookup-key')
        if kind=='context':altered_rule['context']+='__changed__'
        if kind=='prior':altered_prior['role']='preserve-diagnostic'
        if kind=='consumer':altered_rule['bodyConsumer']['offset']+=1
        if kind=='argument':altered_rule['bodyArgumentWindow']=[]
        if kind=='throw':altered_rule['throw']['opcode']='ret'
        if kind=='visibility':altered_rule['visibility']='proved-visible-in-unity-console'
        try:validate_arc_rule(altered_source,altered_prior,altered_rule,altered_body)
        except AssertionError as error:assert str(error)==reason,(kind,error)
        else:raise AssertionError('changed-arc-contract-accepted:'+kind)
    def check_arc_context(value):
        assert value==arc_context, 'arc-context-expansion'
    check_arc_context(load(OUT/'compiled-arc-source-context.json'))
    bad=copy.deepcopy(arc_context);bad['exceptionAssemblies'][2]['separatorIds']=[]
    try:check_arc_context(bad)
    except AssertionError as error:assert str(error)=='arc-context-expansion'
    else:raise AssertionError('lost-exception-assembly-dependency-accepted')
    # Replays original regex predicates only, not CLR, graph or save behavior.
    import re
    arc_sources=[by_selector[r['method'],r['offset']] for r in managed if r['method']==ARC_METHOD]
    patterns=[r['value'] for r in arc_sources if r['offset'] in (0x253,0x2ed,0x387,0x421)]
    assert patterns==['^[p][0-9]*','^[s][0-9]*','^[i][0-9]*','^[n][0-9]*']
    for pattern,letter in zip(patterns,'psin'):
        assert re.search(pattern,letter) and re.search(pattern,letter+'notdigits') and re.search(pattern,letter+'12tail')
        assert not re.search(pattern,'x'+letter) and not re.search(pattern,letter.upper())
    # Exercise the actual build write loop with synthetic products redirected
    # to task-owned disposable files. Source generation is replaced here; this
    # checks only the sequential partial-write boundary, never corpus validity.
    with tempfile.TemporaryDirectory(prefix='write-boundary-',dir=phase143) as scratch_name:
        scratch=Path(scratch_name)
        fixtures={'first.json':b'first\n','second.json':b'second\n','manifest.json':b'{"counts":{}}\n'}
        original_write=Path.write_bytes
        def fail_second(path,content):
            if path==scratch/'second.json':
                raise OSError('injected-second-product-write')
            return original_write(path,content)
        with patch.object(builder_module,'OUT',scratch), patch.object(builder_module,'products',return_value=fixtures), patch.object(sys,'argv',['build_inventory.py']):
            with patch.object(Path,'write_bytes',fail_second):
                try:builder_module.main()
                except OSError as error:assert str(error)=='injected-second-product-write'
                else:raise AssertionError('injected-write-failure-not-observed')
            assert (scratch/'first.json').read_bytes()==fixtures['first.json']
            assert not (scratch/'second.json').exists() and not (scratch/'manifest.json').exists()
            with contextlib.redirect_stdout(io.StringIO()):builder_module.main()
            assert all((scratch/name).read_bytes()==content for name,content in fixtures.items())

    loader_decisions, loader_context = expanded_loader()
    assert load(phase142/'compiled-role-decisions.json') == loader_decisions, 'loader-authored-expansion'
    assert load(OUT/'compiled-loader-source-context.json') == loader_context, 'loader-context-expansion'
    loader_rules = {(r['method'],r['offset']):r for r in loader_decisions['decisions']}
    loader_changed = [(a,b) for a,b in zip(phase141_managed,managed) if a!=b]
    assert len(loader_changed) == len(loader_rules) == 29
    assert all(a['role']=='needs-consumer-decision' and b['role']==loader_rules[b['method'],b['offset']]['role'] for a,b in loader_changed)
    reconstructed_phase141 = copy.deepcopy(managed)
    for r in reconstructed_phase141:
        if (r['method'],r['offset']) in loader_rules:
            r.update(role='needs-consumer-decision',decision='complete-index-unread-consumer')
            r.pop('source',None)
    assert jl(reconstructed_phase141)==(phase142/'baseline/managed-literal-inventory.jsonl').read_bytes(), 'unexpected-phase142-compiled-delta'
    loader_delta=list(lines(OUT/'compiled-source-role-delta.jsonl'))
    assert len(loader_delta)==29 and sum('source' in r for r in loader_delta)==18
    assert {r['id'] for r in loader_delta}=={r['id'] for r in held_after_arc}
    assert not [r for r in managed if r['role']=='needs-consumer-decision' and r['method'].split(' ',1)[1].split('::')[0] in owners], 'loader-scope-not-complete'
    groups=loader_context['groups']; complete_loader={r['id'] for g in groups for r in g['completeProducerLiterals']}
    assert len(groups)==15 and len(complete_loader)==64
    assert len(complete_loader-{r['id'] for r in loader_delta})==35
    loader_case=next(r for r in registry if r['id']=='compiled-loader-state-keys-and-exception-assembly')
    assert {r['id'] for r in loader_case['sourceBindings']}==complete_loader, 'loader-registry-membership'
    assert {i for g in groups for i in g['wordingIds']}=={r['id'] for r in loader_delta if r['roleKind']=='W'}
    assert {i for g in groups for i in g['preserveIds']}=={r['id'] for r in loader_delta if r['roleKind']!='W'}
    assemblies=[a for g in groups for a in g['exceptionAssemblies']]
    assert len(assemblies)==18
    assert {i for a in assemblies for i in a['separatorIds']}=={r['id'] for r in loader_delta if r['roleKind']=='S'}
    for rule in loader_decisions['decisions']:
        source=by_selector[rule['method'],rule['offset']]
        prior_loader=next(r for r in phase141_managed if r['id']==rule['id'])
        body=method_bodies(phase140/'loader.il')[rule['method']]
        validate_loader_rule(source,prior_loader,rule,body)
    rule=next(r for r in loader_decisions['decisions'] if r['roleKind']=='W')
    source=by_selector[rule['method'],rule['offset']]
    prior_loader=next(r for r in phase141_managed if r['id']==rule['id'])
    body=method_bodies(phase140/'loader.il')[rule['method']]
    for kind,reason in [('value','loader-source-value'),('selector','loader-selector'),('body','loader-producer-body'),('role','loader-role-membership'),('context','loader-context-membership'),('prior','loader-prior-role'),('consumer','loader-consumer'),('argument','loader-argument-window'),('throw','loader-exception-throw'),('visibility','loader-visibility-boundary')]:
        altered_source,altered_prior,altered_rule,altered_body=map(copy.deepcopy,[source,prior_loader,rule,body])
        if kind=='value':altered_source['value']+='__changed__'
        if kind=='selector':altered_rule['sourceLine']+=1
        if kind=='body':altered_body[-1]['opcode']='throw'
        if kind=='role':altered_rule.update(roleKind='K',role='preserve-inferred-watch-trigger-suffix')
        if kind=='context':altered_rule['context']+='__changed__'
        if kind=='prior':altered_prior['role']='preserve-diagnostic'
        if kind=='consumer':altered_rule['bodyConsumer']['offset']+=1
        if kind=='argument':altered_rule['bodyArgumentWindow']=[]
        if kind=='throw':altered_rule['throw']['opcode']='ret'
        if kind=='visibility':altered_rule['visibility']='proved-visible-in-unity-console'
        try:validate_loader_rule(altered_source,altered_prior,altered_rule,altered_body)
        except AssertionError as error:assert str(error)==reason,(kind,error)
        else:raise AssertionError('changed-loader-contract-accepted:'+kind)
    def check_loader_context(value):
        assert value==loader_context,'loader-context-expansion'
    check_loader_context(load(OUT/'compiled-loader-source-context.json'))
    for field in ['wordingIds','preserveIds','exceptionAssemblies']:
        bad=copy.deepcopy(loader_context)
        g=next(g for g in bad['groups'] if g[field]);g[field]=[]
        try:check_loader_context(bad)
        except AssertionError as error:assert str(error)=='loader-context-expansion'
        else:raise AssertionError('lost-loader-membership-accepted:'+field)
    assert handoff['loaderContext']=='compiled-loader-source-context.json'

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
    # Preserve the previous consumer product exactly, then validate this finite
    # supplement separately instead of rewriting phase136 historical decisions.
    phase142_dispositions=load(phase143/'baseline/dialogue-database-consumer-dispositions.json')['values']
    assert [classify_remaining(r,source_tree) for r in previous]==phase142_dispositions
    expected_bindings=[refine_binding(r,source_tree) if not r['roleResolved'] else r for r in phase142_dispositions]
    assert expected_bindings==dispositions, 'finite-database-binding-dispositions'
    current_unresolved=load(OUT/'dialogue-database-unresolved.json')['values']
    old_unresolved=load(phase143/'baseline/dialogue-database-unresolved.json')['values']
    assert len(current_unresolved)==len(old_unresolved)==1655
    for before,after in zip(old_unresolved,current_unresolved):
        validate_binding_selector(before,after)
    assert len({r['pointer'] for r in current_unresolved})==1655
    assert sum(len(r['occurrences']) for r in current_unresolved)==3310
    assert Counter(r['fieldTitle'] for r in current_unresolved)=={'Title':934,'TfolConversationType':193,'TfolUniqueDataKeySuffix':523,'Description':5}
    assert all(r['finiteStaticAssignment']=='complete;source-policy-or-identified-runtime-evidence-needed' for r in current_unresolved)
    for field, changed, reason in (
        ('source','__mutated_source__','database-binding-preserved-source'),
        ('occurrences',list(reversed(current_unresolved[0]['occurrences'])),'database-binding-preserved-occurrences'),
        ('roleResolved',True,'database-binding-preserved-roleResolved'),
        ('consumerBindingEvidence','', 'database-binding-missing-evidence')):
        altered=copy.deepcopy(current_unresolved[0]);altered[field]=changed
        try:
            validate_binding_selector(old_unresolved[0],altered)
        except ValueError as error:
            assert str(error)==reason
        else:
            raise AssertionError('invalid-database-binding-accepted:'+field)
    lua=load(OUT/'phase143/lua-inputs.json')
    assert lua['counts']['slotsPerCopy']==32793 and lua['counts']['emptyPerCopy']==32752
    assert lua['nonemptyLogicalPrograms']==41 and lua['physicalNonemptyPrograms']==82
    assert lua['counts']['conditionsStringNonempty']==39 and lua['counts']['userScriptNonempty']==2
    assert lua['distinctExpressions']==8 and lua['customConversationFieldInputs']==[] and lua['unparsedPrograms']==[]
    for program in lua['programs']:
        assert get(source_tree,program['pointer'])==program['source']
        assert program['sourceValueSha256']==value_hash(program['source'])
        assert analyze_lua(program['source'])==program['analysis']
    for unknown in ('Conversation[1][fieldName]', 'Variable["bool_condition"] == true; GetConversationField(1, key)', 'x = math.random(100); doSomething()'):
        result=analyze_lua(unknown)
        assert result['status']=='unparsed;dynamic-or-new-source' and result['reads'] is None
    callers=load(OUT/'phase143/game-callers.json')
    assert len(callers['directCalls'])==6
    assert Counter(r['nameInput'] for r in callers['directCalls'])=={'bool_condition':4,'branch_condition':1,'TfolUniqueDataKeySuffix':1}
    bindings=load(OUT/'dialogue-database-caller-bindings.json')
    assert bindings['serializedBoundary']['instances']==39 and bindings['serializedBoundary']['absentIsNotNull']
    assert bindings['codeTitleBoundary']['remaining934ExactPredicateMatches']==0
    assert bindings['unresolvedLogicalValues']==1655 and not bindings['commonSourceAccepted']
    next_compiled=load(OUT/'phase143/next-compiled-selectors.json')
    assert next_compiled['occurrences']==1251 and next_compiled['methods']==443
    assert [r['id'] for r in next_compiled['selectors']]==[r['id'] for r in managed if r['role']=='needs-consumer-decision']
    assert (OUT/'managed-literal-inventory.jsonl').read_bytes()==(phase143/'baseline/managed-literal-inventory.jsonl').read_bytes(), 'phase143-compiled-whole-product-changed'
    assert load(OUT/'unresolved-consumers.json')['nextPredicate']==NEXT_SOURCE
    changed_products={'compiled-source-handoff.json','consumer-matrix.json','unresolved-consumers.json','manifest.json','dialogue-database-reconciliation.json','dialogue-database-values.jsonl','dialogue-database-unresolved.json','dialogue-database-consumer-dispositions.json'}
    previous_products=load(phase142/'integration-handoff.json')['generatedOutputPins']
    for name,digest in previous_products.items():
        if name not in changed_products:
            assert sha(OUT/name)==digest, ('phase143-unaffected-prior-product',name)

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
    receipt = dict(schemaVersion=1, status='passed-fingerprinted-source-continuation', phase='0143-work',
                   reusedParentReadback=dict(path=str((baseline/'readback-validation.json').relative_to(ROOT)),
                       sha256=sha(baseline/'readback-validation.json'), originalManifestSha256=prior['manifestSha256'],
                       boundary='Original parent full source/tree/span readback, reused on exactly unchanged values/IDs/context; not rerun or relabeled as independent semantic judgment.'),
                   currentManifestSha256=sha(OUT/'manifest.json'), builderSha256=sha(OUT/'build_inventory.py'),
                   validatorSha256=sha(Path(__file__)), generatedProducts=len(generated),
                   preservedProducts=unchanged_products, sourceDeltas=counts, mixedLeafPartitions=dict(partitions),
                   unknownCompiledStates=1251, potentialControlLabelBindingStates=1389,
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
    receipt['phase138CompiledDelta']=dict(changedRoles=145,protectedOperands=145,commandNamespaces=103,sceneLabelProducers=17,visibleIdentityDependencies=120,remainingSelectedOccurrences=110,remainingSelectedMethods=next_commands['methods'],remainingCompiledOccurrences=1438,remainingCompiledMethods=len({r['method'] for r in phase138_managed if r['role']=='needs-consumer-decision'}),priorWholeProductReconstructedExactly=True,knownWordingOperands=91,protectedOperandsTotal=7059,resolvedPartition=7138,completeCompiledPacket=False)
    receipt['negativeControls'].update(changedCommandProducerRejected=True,commandProducerBranchRejected=True,changedCommandRegistrationRejected=True,lostDisplayedIdentityRejected=True,changedCommandInsertionRejected=True)
    receipt['phase139CompiledDelta']=dict(changedRoles=110,wordingOperands=62,protectedOperands=48,displayedFilterIdentities=7,remainingSelectedOccurrences=0,remainingCompiledOccurrences=1328,remainingCompiledMethods=len({r['method'] for r in phase139_managed if r['role']=='needs-consumer-decision'}),priorWholeProductReconstructedExactly=True,knownWordingOperands=153,protectedOperandsTotal=7107,resolvedPartition=7248,nextFamilyOccurrences=77,nextFamilyMethods=26,completeCompiledPacket=False)
    receipt['negativeControls'].update(changedConsoleSourceRejected=True,changedConsoleSelectorRejected=True,changedConsoleProducerRejected=True,displayedFilterRoleOverwriteRejected=True,changedConsoleContextRejected=True,changedConsolePlaceholderRejected=True,changedConsolePriorRoleRejected=True,originalFilterReplayPassed=True,displayOnlyFilterReplacementLosesSelection=True,exactTestConversationTitlePredicatePassed=True)
    receipt['phase140CompiledDelta']=dict(changedRoles=23,wordingOperands=3,protectedOperands=20,assignedOccurrences=77,remainingSelectedOccurrences=54,remainingSelectedMethods=16,remainingCompiledOccurrences=1305,remainingCompiledMethods=len({r['method'] for r in phase140_managed if r['role']=='needs-consumer-decision'}),priorWholeProductReconstructedExactly=True,knownWordingOperands=156,protectedOperandsTotal=7127,resolvedPartition=7271,completeCompiledPacket=False)
    receipt['negativeControls'].update(changedPlaybackSourceRejected=True,changedPlaybackSelectorRejected=True,changedPlaybackProducerRejected=True,changedPlaybackRoleRejected=True,changedPlaybackContextRejected=True,changedPlaybackPlaceholderRejected=True,changedPlaybackPriorRoleRejected=True,changedPlaybackConsumerRejected=True,changedPlaybackArgumentWindowRejected=True,consoleBitmaskPredicateReplayPassed=True,exactLoader54Retained=True)
    receipt['phase141CompiledDelta']=dict(changedRoles=25,potentialExceptionWording=11,protectedOperands=14,completeProducerLiterals=33,priorPreciseRolesRetained=8,exceptionAssemblies=11,exceptionSeparators=9,remainingSelectedOccurrences=29,remainingSelectedMethods=15,remainingCompiledOccurrences=1280,remainingCompiledMethods=len({r['method'] for r in phase141_managed if r['role']=='needs-consumer-decision'}),priorWholeProductReconstructedExactly=True,knownWordingAndPotentialOperands=167,protectedOperandsTotal=7141,resolvedPartition=7296,completeCompiledPacket=False,exceptionPresentation='unknown;ctor-and-throw-proved-only')
    receipt['negativeControls'].update(changedArcSourceRejected=True,changedArcSelectorRejected=True,changedArcProducerRejected=True,changedArcRoleRejected=True,changedArcContextRejected=True,changedArcPriorRoleRejected=True,changedArcConsumerRejected=True,changedArcArgumentWindowRejected=True,changedArcThrowRejected=True,unsupportedExceptionVisibilityRejected=True,lostExceptionAssemblyDependencyRejected=True,originalPrefixRegexReplayPassed=True,exactLoader29Retained=True)
    receipt['phase142CompiledDelta']=dict(changedRoles=29,potentialExceptionWording=18,protectedOperands=11,completeProducerLiterals=64,priorPreciseRolesRetained=35,exceptionAssemblies=18,exceptionSeparators=6,remainingSelectedOccurrences=0,remainingSelectedMethods=0,remainingCompiledOccurrences=1251,remainingCompiledMethods=len({r['method'] for r in managed if r['role']=='needs-consumer-decision'}),priorWholeProductReconstructedExactly=True,knownWordingAndPotentialOperands=185,protectedOperandsTotal=7152,resolvedPartition=7325,completeCompiledPacket=False,exceptionPresentation='unknown;ctor-and-throw-proved-only')
    receipt['negativeControls'].update(changedLoaderSourceRejected=True,changedLoaderSelectorRejected=True,changedLoaderProducerRejected=True,changedLoaderRoleRejected=True,changedLoaderContextRejected=True,changedLoaderPriorRoleRejected=True,changedLoaderConsumerRejected=True,changedLoaderArgumentWindowRejected=True,changedLoaderThrowRejected=True,unsupportedLoaderVisibilityRejected=True,lostLoaderMembershipRejected=True,all29LoaderSelectorsResolved=True)
    receipt['phase143DatabaseBindings']=dict(assignedLogicalValues=1655,physicalSelectors=3310,retainedProvedKeys=5,remainingLogicalValues=1655,serializedInstances=39,originalLuaSlotsPerCopy=32793,nonemptyLuaExpressions=41,distinctExpressions=8,directGameApiCalls=6,wholePriorCompiledProductUnchanged=True,priorUnaffectedProductsUnchanged=len(previous_products)-len(changed_products),nextCompiledOccurrences=1251,nextCompiledMethods=443,sourcePolicyAndExternalBoundary='unresolved;finite-static-assignment-complete',completeSourceAccepted=False)
    receipt['negativeControls'].update(changedDatabaseBindingSourceRejected=True,changedDatabaseBindingOccurrenceRejected=True,unsupportedDatabaseAdmissionRejected=True,missingDatabaseBindingEvidenceRejected=True,unknownLuaSyntaxHeldWithoutAbsenceClaim=True)
    receipt['writeBoundary']=dict(actualBuildWriteLoop='passed-second-write-failure-and-positive-control',planning='synthetic-products-only;real-source-generation-verified-separately',firstProductSurvives=True,laterProductsAbsentAtFailure=True,rollback=False,multiFileTransaction=False)
    (OUT/'continuation-validation.json').write_text(json.dumps(receipt,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({k:v for k,v in receipt.items() if k not in ('outputPins','preservedProducts','boundary')}))


if __name__ == '__main__':
    main()
