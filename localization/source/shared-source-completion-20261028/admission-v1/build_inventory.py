"""Compile the explicitly authored source decisions against pinned existing data.

This is the finite 0.45 admission supplement, not a translation generator.
--check recomputes products without writing; unclassified inputs fail closed.
"""
import argparse
import hashlib
import json
from collections import Counter
from pathlib import Path

from prepare_context import ROOT, OUT, BASE, sha, load, lines
from phase135.reconcile_database import products as database_products
from phase136.reconcile_roles import products as consumer_products, GREETING_METHOD, GREETING_ID, GREETING
from phase138.expand_roles import products as command_products
from phase139.expand_roles import products as console_products
from phase140.expand_roles import products as playback_products
from phase141.expand_roles import products as arc_products
from phase142.expand_roles import products as loader_products
from phase143.reconcile_bindings import products as binding_products
from phase144.expand_roles import products as remaining_products
from phase145.expand_roles import products as tail_products
from phase146.expand_roles import products as final_products
NEXT_SOURCE = "Three remaining compiled static-field selectors (source lines331,332,4948) retain exact external/source-policy holds; no game-assembly reader is established. Do not repeat unchanged field scans. Next finite deliverable: reconcile the109 selected original Text/TMP identities into concrete game font roles, source/corpus requirement bindings and pinned candidate/resource decisions using localization/fonts/README.md. Preserve fictional-language mapping and all source/editorial/runtime gates; no target/font/texture production or GUI."

INDEX = ROOT / 'outputs/pause-inventory-bio-completion-20261028/managed-index'
SERIALIZED = ROOT / 'outputs/pause-inventory-bio-completion-20261028/serialized-nondialogue-roster.jsonl'
LEDGER = ROOT / 'localization/source/bgdatabase-complete-values-20261027/verified/cells.jsonl'
FROZEN = ROOT / 'localization/source/dialogue-candidates.jsonl'


def value_hash(value):
    return hashlib.sha256(json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(',', ':')).encode()).hexdigest()


def expand(groups, size):
    result = {}
    for g in groups:
        indices = g.get('indices', []) + [i for a, b in g.get('indexRanges', []) for i in range(a, b + 1)]
        for i in indices:
            assert i not in result, ('overlapping-authored-decisions', i)
            result[i] = g
    assert set(result) == set(range(size)), ('missing-authored-decisions', sorted(set(range(size)) - set(result)))
    return result


def jl(rows):
    return ''.join(json.dumps(r, ensure_ascii=False, separators=(',', ':')) + '\n' for r in rows).encode()


def j(value):
    return (json.dumps(value, ensure_ascii=False, indent=2) + '\n').encode()


def apply_compiled_role(source, prior_role, rules):
    """Apply only a fingerprinted exact occurrence in the authored finite delta."""
    key = source['method'], source['offset']
    rule = rules.get(key)
    if rule is None:
        return None
    expected_id = f"il:Assembly-CSharp.dll/{source['method']}/IL_{source['offset']:04x}"
    assert rule['id'] == expected_id, 'compiled-rule-selector'
    assert rule['sourceValueSha256'] == value_hash(source['value']), 'compiled-rule-value'
    assert prior_role == 'needs-consumer-decision', 'compiled-rule-overwrites-accepted-role'
    assert rule['reason'] and rule['evidence'], 'compiled-rule-missing-contract'
    if 'producerWindow' in rule:
        assert source['before'][-len(rule['producerWindow']):] == rule['producerWindow'], 'compiled-rule-producer-window'
    if 'consumer' in rule:
        assert rule['consumer'] in source['after'], 'compiled-rule-consumer'
        actual = [i for i in source['after'] if i['index'] <= rule['consumer']['index']]
        assert actual == rule['argumentWindow'], 'compiled-rule-argument-window'
    return rule


def products():
    decisions = load(OUT / 'source-decisions.json')
    continuation = load(OUT / 'continuation-decisions.json')
    assert sha(OUT / continuation['priorDecisions']) == continuation['priorSha256']
    for name, expected in continuation['evidence'].items():
        assert sha(OUT / 'phase134' / name) == expected, ('continuation-evidence', name)
    direct_groups = load(BASE / 'evidence/direct-ui-value-groups.json')
    assert sha(BASE / 'evidence/direct-ui-value-groups.json') == decisions['directValueGroupsSha256']
    direct_choices = expand(decisions['directDecisions'], 400)
    by_value = {g['source']: (i, direct_choices[i]) for i, g in enumerate(direct_groups)}
    assert len(by_value) == 400
    group_roster = load(BASE / 'evidence/serialized-nondialogue-summary.json')['nonDisplayGroups']
    group_choices = expand(decisions['serializedGroupDecisions'], 271)
    by_group = {(g['className'], g['field']): (i, group_choices[i]) for i, g in enumerate(group_roster)}
    direct = {r['id']: r for r in lines(OUT / 'direct-context.jsonl')}
    animator = {r['id']: r for r in lines(OUT / 'animator-context.jsonl')}
    serialized = []
    actual_groups = Counter()
    for n, r in enumerate(lines(SERIALIZED), 1):
        row = dict(id=r['id'], family='serialized-nondialogue', sourceLine=n,
                   sourceValueSha256=value_hash(r['value']), className=r['class'], pointer=r['pointer'])
        if r['reviewGroup'] == 'direct-text':
            i, decision = by_value[r['value']]
            assert direct[r['id']]['value'] == r['value']
            row.update(source=r['value'], directValueIndex=i,
                       hierarchy=direct[r['id']]['hierarchy'], context='direct-context.jsonl')
        elif r['reviewGroup'] == 'object-identity':
            # These are names used in resource/object identity, not a blanket
            # proof that every producer keeps names out of visible output.
            decision = dict(id='object-identity', role='preserve-object-identity',
                            reason='Object/resource names stay exact; any displayed alias needs its own proved producer.')
        else:
            i, decision = by_group[(r['class'], r['pointer'].split('/')[1])]
            actual_groups[i] += 1
            row['serializedGroupIndex'] = i
            if 'display' in decision['role'] or decision['id'] == 'keyboard-layout-and-special-labels':
                if not r['class'].endswith('CodecksApiSettings'):
                    row['source'] = r['value']
            if r['id'] in animator:
                row.update(hierarchy=animator[r['id']]['hierarchy'], context='animator-context.jsonl')
        row.update(role=decision['role'], decision=decision['id'],
                   application='hold-common-source-special-case-and-feasibility-gates')
        if 'unresolvedPredicate' in decision:
            row['unresolvedPredicate'] = decision['unresolvedPredicate']
        # Split the two historically mixed families by the actual leaf contract.
        # Potential Rewired labels remain held for a separate display alias;
        # game-only call-index absence never establishes external UI absence.
        leaf = None
        if row.get('serializedGroupIndex') == 64:
            leaf = 'keyboardLayout'
        elif row.get('serializedGroupIndex') == 65:
            if r['value'] in continuation['serialized']['keyboardActionLabel']['values']:
                leaf = 'keyboardActionLabel'
            elif r['value'] in continuation['serialized']['keyboardSymbolLabel']['values']:
                leaf = 'keyboardSymbolLabel'
            else:
                raise AssertionError(('unread-keyboard-label', r['id']))
        elif row.get('serializedGroupIndex') in (125,126,128,129,130,133):
            leaf = 'rewiredPotentialLabel'
        elif row.get('serializedGroupIndex') in (127,131,132,135):
            leaf = 'rewiredResourceIdentity'
        elif row.get('serializedGroupIndex') == 134:
            assert r['pointer'].rsplit('/',1)[-1] in ('name','joystickGuid','fileGuid')
            leaf = 'rewiredPotentialLabel' if r['pointer'].endswith('/name') else 'rewiredResourceIdentity'
        elif row.get('serializedGroupIndex') == 249:
            field = r['pointer'].rsplit('/',1)[-1]
            if field in ('_descriptiveName','_positiveDescriptiveName','_negativeDescriptiveName'):
                leaf = 'rewiredPotentialLabel'
            elif field in ('_name','name'):
                leaf = 'rewiredDualIdentity'
            else:
                assert field.startswith('exportConsts_') or field in ('_tag','_typeGuidString','hardwareGuidString'), ('unread-rewired-field',r['id'])
                leaf = 'rewiredResourceIdentity'
        if leaf:
            rule = continuation['serialized'][leaf]
            row.update(role=rule['role'], decision='phase134:' + leaf)
            row.pop('unresolvedPredicate', None)
            if 'display' in rule['role']:
                row['source'] = r['value']
            if 'consumerBindingPredicate' in rule:
                row['consumerBindingPredicate'] = rule['consumerBindingPredicate']
                row['application'] = 'preserve-original-lookup-value;display-alias-binding-unverified'
        serialized.append(row)
    assert len(serialized) == len({r['id'] for r in serialized}) == 36107
    assert actual_groups == Counter({i: g['occurrences'] for i, g in enumerate(group_roster)})

    remaining = load(BASE / 'remaining-bgdatabase-decisions.json')
    assert sha(BASE / 'remaining-bgdatabase-decisions.json') == decisions['bgRemainingAdmission']['decisionSourceSha256']
    bg_decisions = {(g['sheet'], g['field']): g for g in remaining['columns']}
    bg = []
    remaining_counts = Counter()
    for n, r in enumerate(lines(LEDGER), 1):
        role, decision = r['classification'], 'retained-complete-ledger-classification'
        if (r['sheet'], r['field']) in bg_decisions:
            g = bg_decisions[(r['sheet'], r['field'])]
            assert r['fieldId'] == g['fieldId']
            remaining_counts[(r['sheet'], r['field'])] += 1
            role, decision = g['role'], 'parent29:' + r['sheet'] + '.' + r['field']
            if r['field'] == 'greeting_text' and r['sheet'] == 'ActorGossipGreeting':
                role = 'dormant-potential-display-source'
        row = dict(id=r['id'], family='bgdatabase', sourceLine=n, sheet=r['sheet'],
                   field=r['field'], fieldId=r['fieldId'], rowIndex=r['rowIndex'], stored=r['stored'],
                   sourceSpan=r['sourceSpan'], sourceValueSha256=value_hash(r['source']),
                   role=role, decision=decision,
                   application='hold-common-source-special-case-and-feasibility-gates')
        if role in ('display', 'display-candidate', 'dormant-potential-display-source'):
            row['source'] = r['source']
        bg.append(row)
    assert len(bg) == len({r['id'] for r in bg}) == 51572
    assert remaining_counts == Counter({(g['sheet'], g['field']): g['states'] for g in remaining['columns']})
    assert not any(r['role'] == 'unresolved-text-consumer' for r in bg)

    frozen = [dict(id=r['id'], family='frozen-dialogue', source=r['source'],
                   sourceValueSha256=value_hash(r['source']), occurrences=r['occurrences'],
                   conversationId=r['conversationId'], entryId=r['entryId'], field=r['field'],
                   role='display-candidate-inline-grammar-and-special-discovery-pending',
                   application='frozen-owner-authorized-lanes-only;no-input-mutation') for r in lines(FROZEN)]
    assert len(frozen) == len({r['id'] for r in frozen}) == 12246
    assert sum(len(r['occurrences']) for r in frozen) == 24492

    prior = load(ROOT / 'localization/source/inventory-20261026/literal-classification.json')['rows']
    prior_by_selector = {(r['method'], int(r['offset'].removeprefix('IL_'), 16)): r for r in prior}
    bodies = list(lines(BASE / 'evidence/ui-consumer-bodies.jsonl'))
    # These complete original bodies were actually read in this context.
    read_body_indices = [25,26,27,32,33,34,35,36,45,46,47,48,52,54,55,56,57,70,71,72,74,75,76,77,78,79,80,81,82,83,84,85,88]
    reviewed = {bodies[i]['method']: i for i in read_body_indices}
    literal_roles = {
        26: {20: 'preserve-display-format'},
        34: {28: 'special-display-codec',84: 'special-display-codec'},
        36: {96: 'display-format'},
        45: {91: 'preserve-display-format',111: 'preserve-display-format',144: 'preserve-display-format'},
        46: {62: 'preserve-control',128: 'preserve-display-format'},
        47: {29: 'preserve-control',95: 'preserve-display-format'},
        48: {47: 'preserve-control',67: 'preserve-control',117: 'preserve-display-format'},
        52: {32: 'preserve-display-format',51: 'display-source'},
        71: {30: 'preserve-markup',35: 'preserve-markup',53: 'preserve-markup',58: 'preserve-markup'},
        72: {9: 'preserve-object-identity'},
        75: {74: 'display-prefix'}, 76: {74: 'display-prefix'}, 77: {74: 'display-prefix'},
        78: {38: 'display-prefix'}, 79: {38: 'display-source'}, 80: {38: 'display-prefix'},
        81: {38: 'display-prefix'}, 82: {38: 'display-prefix'}, 83: {38: 'display-prefix'},
        84: {7: 'display-source',34: 'display-prefix',66: 'preserve-control'},
        85: {154: 'preserve-control',183: 'preserve-control'},
        88: {225: 'display-prefix'},
    }
    exact_literals = {}
    for i, offsets in literal_roles.items():
        body = bodies[i]
        actual = {x['offset']: x['operand'] for x in body['instructions'] if x['opcode'] == 'ldstr'}
        assert set(offsets) == set(actual), ('reviewed-body-literal-selector', i, actual, offsets)
        for offset, role in offsets.items():
            exact_literals[(body['method'], offset)] = (actual[offset], role, i)
    il = []
    immediate_consumers = {r['target']: r for r in decisions['immediateManagedConsumers']}
    new_consumers = {r['target']: r for r in continuation['managedImmediateConsumers']}
    stored_fields = {r['target']: r for r in continuation['managedStoredFields']}
    exact_continuation = {(r['method'],r['offset']):r for r in continuation['exactMethodLiterals']}
    assert len(exact_continuation) == len(continuation['exactMethodLiterals'])
    comparison_path = BASE / 'comparison-operands/preserve-exactly.jsonl'
    comparison_operands = {(r['method'], r['offset']): r for r in lines(comparison_path)}
    assert len(comparison_operands) == 1121
    integrated_comparisons = 0
    compiled_delta = load(OUT / 'phase137/compiled-role-decisions.json')
    compiled_rules = {(r['method'], r['offset']):r for r in compiled_delta['decisions']}
    assert len(compiled_rules) == len(compiled_delta['decisions']) == 817
    command_delta = load(OUT / 'phase138/compiled-role-decisions.json')
    command_rules = {(r['method'], r['offset']):r for r in command_delta['decisions']}
    assert len(command_rules) == len(command_delta['decisions']) == 145
    console_delta = load(OUT / 'phase139/compiled-role-decisions.json')
    console_rules = {(r['method'],r['offset']):r for r in console_delta['decisions']}
    assert len(console_rules) == len(console_delta['decisions']) == 110
    applied_console_rules = set()
    playback_delta = load(OUT / 'phase140/compiled-role-decisions.json')
    playback_rules = {(r['method'],r['offset']):r for r in playback_delta['decisions']}
    assert len(playback_rules) == len(playback_delta['decisions']) == 23
    applied_playback_rules = set()
    arc_delta = load(OUT / 'phase141/compiled-role-decisions.json')
    arc_rules = {(r['method'],r['offset']):r for r in arc_delta['decisions']}
    assert len(arc_rules) == len(arc_delta['decisions']) == 25
    applied_arc_rules = set()
    loader_delta = load(OUT / "phase142/compiled-role-decisions.json")
    loader_rules = {(r["method"],r["offset"]):r for r in loader_delta["decisions"]}
    assert len(loader_rules) == len(loader_delta["decisions"]) == 29
    applied_loader_rules = set()
    remaining_outputs = remaining_products()
    remaining_delta = remaining_outputs["phase144/compiled-role-decisions.json"]
    remaining_rules = {(r["method"],r["offset"]):r for r in remaining_delta["decisions"]}
    assert len(remaining_rules) == len(remaining_delta["decisions"]) == 682
    applied_remaining_rules = set()
    tail_outputs = tail_products()
    tail_delta = tail_outputs['phase145/compiled-role-decisions.json']
    tail_rules = {(r['method'],r['offset']):r for r in tail_delta['decisions']}
    assert len(tail_rules) == 318
    applied_tail_rules = set()
    final_outputs = final_products()
    final_delta = final_outputs['phase146/compiled-role-decisions.json']
    final_rules = {(r['method'],r['offset']):r for r in final_delta['decisions']}
    assert len(final_rules) == 248
    applied_final_rules = set()
    applied_command_rules = set()
    applied_compiled_rules = set()
    for n, r in enumerate(lines(INDEX / 'literals.jsonl'), 1):
        key = r['method'], r['offset']
        role, decision = 'needs-consumer-decision', 'complete-index-unread-consumer'
        if key in prior_by_selector:
            old = prior_by_selector[key]
            assert old['value'] == r['value'], ('prior-literal-mismatch', key)
            role, decision = old['role'], 'retained83:' + old['reason']
        if key in exact_literals:
            value, role, i = exact_literals[key]
            assert value == r['value']
            decision = 'read-complete-ui-body:' + str(i)
        if role == 'needs-consumer-decision' and r['after']:
            first = r['after'][0]
            if first['opcode'] in ('call','callvirt','newobj') and first['operand'] in immediate_consumers:
                rule = immediate_consumers[first['operand']]
                role, decision = rule['role'], 'authored-immediate-consumer:' + rule['target']
        if r['type'].startswith('TheForestOfLove.DB.'):
            first = r['after'][0]
            if (first['opcode'], first['operand']) == ('callvirt', 'BansheeGz.BGDatabase.BGEntity BansheeGz.BGDatabase.BGMetaEntity::GetEntity(System.String)'):
                role, decision = 'preserve-database-identity', 'literal-immediate-GetEntity-argument'
            elif (first['opcode'], first['operand']) == ('newobj', 'System.Void System.Exception::.ctor(System.String)'):
                role, decision = 'preserve-diagnostic', 'literal-immediate-generated-exception-argument'
            else:
                raise AssertionError(('new-generated-literal-consumer', key))
        if role == 'needs-consumer-decision' and r['after']:
            first = r['after'][0]
            if first['opcode'] in ('call','callvirt') and first['operand'] in new_consumers:
                role, decision = new_consumers[first['operand']]['role'], 'phase134:immediate:' + first['operand']
            elif first['opcode'] == 'stsfld' and first['operand'] in stored_fields:
                role, decision = stored_fields[first['operand']]['role'], 'phase134:stored-key:' + first['operand']
        if key in exact_continuation:
            rule = exact_continuation[key]
            assert rule['sourceValueSha256'] == value_hash(r['value']), ('continuation-literal-value',key)
            role, decision = rule['role'], 'phase134:complete-body:' + rule['evidence']
        if key in comparison_operands:
            proof = comparison_operands[key]
            assert proof['sourceValueSha256'] == value_hash(r['value']), ('comparison-value', key)
            first = r['after'][0]
            assert (first['offset'], first['opcode'], first['operand']) == (proof['consumerOffset'], proof['consumerOpcode'], proof['consumer']), ('comparison-consumer', key)
            if role == 'needs-consumer-decision':
                role, decision = proof['role'], 'phase135:exact-parent-comparison-argument'
                integrated_comparisons += 1
        if key == (GREETING_METHOD, 0x0a01):
            assert r['value'] == GREETING and role == 'needs-consumer-decision'
            assert r['after'][0]['operand'] == 'System.Void TheForestOfLove.Gameplay.FastTravelController::set_NextFastTravelCustomGreetingText(System.String)'
            role, decision = 'display-runtime-fast-travel-greeting', 'phase136:exact-runtime-greeting-producer'
        rule = apply_compiled_role(r, role, compiled_rules)
        if rule:
            role, decision = rule['role'], 'phase137:' + rule['contract']
            applied_compiled_rules.add(key)
        rule = apply_compiled_role(r, role, command_rules)
        if rule:
            role, decision = rule['role'], 'phase138:' + rule['contract']
            applied_command_rules.add(key)
        rule = apply_compiled_role(r, role, console_rules)
        if rule:
            role, decision = rule['role'], 'phase139:' + rule['contract']
            applied_console_rules.add(key)
        rule = apply_compiled_role(r, role, playback_rules)
        if rule:
            role, decision = rule['role'], 'phase140:' + rule['contract']
            applied_playback_rules.add(key)
        rule = apply_compiled_role(r, role, arc_rules)
        if rule:
            role, decision = rule['role'], 'phase141:' + rule['contract']
            applied_arc_rules.add(key)
        rule = apply_compiled_role(r, role, loader_rules)
        if rule:
            role, decision = rule['role'], 'phase142:' + rule['contract']
            applied_loader_rules.add(key)
        rule = apply_compiled_role(r, role, remaining_rules)
        if rule:
            role, decision = rule['role'], 'phase144:' + rule['contract']
            applied_remaining_rules.add(key)
        rule = apply_compiled_role(r, role, tail_rules)
        if rule:
            role, decision = rule['role'], 'phase145:' + rule['contract']
            applied_tail_rules.add(key)
        rule = apply_compiled_role(r, role, final_rules)
        if rule:
            role, decision = rule['role'], 'phase146:' + rule['contract']
            applied_final_rules.add(key)
        row = dict(id=f"il:Assembly-CSharp.dll/{r['method']}/IL_{r['offset']:04x}",
                   family='managed-literal', method=r['method'], offset=r['offset'], sourceLine=n,
                   sourceValueSha256=value_hash(r['value']), role=role, decision=decision,
                   application='hold-common-source-special-case-and-feasibility-gates')
        if role.startswith(('display', 'visible', 'special-display')) or role == 'comparison-on-display' or (key in (set(remaining_rules)|set(tail_rules)|set(final_rules)) and role.startswith('potential-display')):
            row['source'] = r['value']
        il.append(row)
    assert len(il) == len({r['id'] for r in il}) == 8576
    assert integrated_comparisons == 1059
    assert applied_compiled_rules == set(compiled_rules), 'unmatched-compiled-role-rules'
    assert applied_command_rules == set(command_rules), 'unmatched-command-role-rules'
    assert applied_console_rules == set(console_rules), 'unmatched-console-role-rules'
    assert applied_playback_rules == set(playback_rules), 'unmatched-playback-role-rules'
    assert applied_arc_rules == set(arc_rules), 'unmatched-arc-role-rules'
    assert applied_loader_rules == set(loader_rules), 'unmatched-loader-role-rules'
    assert applied_remaining_rules == set(remaining_rules), 'unmatched-remaining-role-rules'
    assert applied_tail_rules == set(tail_rules), 'unmatched-tail-role-rules'
    assert applied_final_rules == set(final_rules), 'unmatched-final-role-rules'

    old = load(ROOT / 'localization/supplemental-ui/20261027/source-catalog.json')['units']
    old_by_id = {r['id']: r for r in old}
    full_rows = serialized + bg + il
    new_by_id = {r['id']: r for r in full_rows}
    assert len(new_by_id) == len(full_rows)
    old_bindings = []
    aliases = {r['oldId']: r for r in continuation['old935SelectorAliases']}
    bound_existing = set()
    for r in old:
        source_id = aliases.get(r['id'], {}).get('sourceId', r['id'])
        same = new_by_id.get(source_id)
        if r['id'] in aliases:
            assert r['family'] == 'journal-header' and same is not None
            assert direct[source_id]['hierarchy'] == r['hierarchy'] == aliases[r['id']]['hierarchy']
            assert aliases[r['id']]['sourceValueSha256'] == value_hash(r['source'])
        if same:
            assert same['sourceValueSha256'] == value_hash(r['source']), ('old935-value-mismatch',r['id'])
            assert source_id not in bound_existing, ('old935-multiplicity-alias',source_id)
            bound_existing.add(source_id)
        old_bindings.append(dict(id=r['id'], sourceValueSha256=value_hash(r['source']),
                                 sourceId=source_id if same else None,
                                 binding=('verified-exact-object-alias' if r['id'] in aliases else 'exact-occurrence') if same else 'requires-selector-alias-reconciliation',
                                 valueMatches=(same['sourceValueSha256'] == value_hash(r['source'])) if same else None))
    assert len(bound_existing) == len(old) == 935
    # Include every old selector in the finite comparison, without equating two
    # instances merely because their English wording happens to match.
    additions = [dict(id=r['id'], family=r['family'], role=r['role'], sourceValueSha256=r['sourceValueSha256'],
                      category=('unresolved' if 'unresolvedPredicate' in r else
                                'preserve-display' if r['role'].startswith('preserve') else
                                'potential-or-dormant' if r['role'].startswith(('potential','dormant')) else
                                'display-candidate'))
                 for r in full_rows if ('display' in r['role'] or r['role'].startswith('visible')) and r['id'] not in bound_existing]
    locale_scope = load(ROOT / 'localization/supplemental-ui/20261027/locale-scope.json')['targetLocales']
    packet_manifest = load(ROOT / 'localization/supplemental-ui/20261027/manifest.json')
    coverage = []
    for locale in locale_scope:
        p = ROOT / 'localization/supplemental-ui/20261027' / (locale + '.jsonl')
        assert sha(p) == packet_manifest['locales'][locale]['sha256']
        rows = list(lines(p))
        assert [(r['id'],r['source']) for r in rows] == [(r['id'],r['source']) for r in old]
        coverage.append(dict(locale=locale, existingUnits=len(rows), unchangedPacketSha256=sha(p),
                             additionalSourceSelectors=len(additions), correction='not-started-source-gate',
                             editorial='not-run-for-additions', runtime='not-run-for-additions'))
    assert len(coverage) == 30

    node_leaves = list(lines(BASE / 'evidence/nodecanvas-string-leaves.jsonl'))
    assert len(node_leaves) == 1653
    nodes = [dict(id=r['sourceFieldId'] + '#' + r['pointer'], sourceFieldId=r['sourceFieldId'],
                  pointer=r['pointer'], source=r['value'], sourceValueSha256=value_hash(r['value']),
                  role='preserve-control-graph', decision='nodeCanvasAdmission') for r in node_leaves]
    assert len(nodes) == len({r['id'] for r in nodes})
    counts = dict(serializedStates=len(serialized), directNativeTextStates=len(direct),
                  directNativeDistinctValues=400, animatorInputStates=len(animator),
                  bgdatabaseStates=len(bg), bgRemainingStates=sum(remaining_counts.values()),
                  frozenDialogueIds=len(frozen), frozenDialogueOccurrences=24492,
                  compiledLiteralStates=len(il), nodeCanvasLeaves=len(nodes),
                  serializedRoles=dict(Counter(r['role'] for r in serialized)),
                  bgRoles=dict(Counter(r['role'] for r in bg)), ilRoles=dict(Counter(r['role'] for r in il)),
                  additionsIncludingDormantAndProtectedDisplaySymbols=len(additions),
                  unresolvedSerializedStates=sum('unresolvedPredicate' in r for r in serialized),
                  unresolvedCompiledStates=sum(r['role'] == 'needs-consumer-decision' for r in il))
    remaining_admitted = [dict(g, admittedRole=('dormant-potential-display-source'
                          if (g['sheet'],g['field']) == ('ActorGossipGreeting','greeting_text') else g['role']))
                          for g in remaining['columns']]
    consumers = dict(schemaVersion=1, remainingBgColumns=remaining_admitted,
                     directNativeDecisions=decisions['directDecisions'],
                     serializedGroups=[dict(index=i, **g, decision=group_choices[i]['id'],
                                             role=group_choices[i]['role']) for i,g in enumerate(group_roster)],
                     authoredSerializedDecisions=decisions['serializedGroupDecisions'],
                     animator=decisions['animatorAdmission'], nodeCanvas=decisions['nodeCanvasAdmission'],
                     immediateManagedConsumers=decisions['immediateManagedConsumers'],
                     readCompleteUiBodies=[dict(index=i, method=bodies[i]['method']) for i in read_body_indices],
                     generatedDbLiterals=dict(identityArguments=2442, exceptionArguments=216,
                       predicate='Every literal is immediately consumed by exactly GetEntity(string) or new Exception(string); source role only, no framework recursion.'),
                     boundary='Source roles and exact consumers, not translated application, independent editorial judgment or runtime acceptance.')
    consumers['continuationDecisions'] = continuation
    consumers['comparisonOperandIntegration'] = dict(artifact='../comparison-operands/preserve-exactly.jsonl',
        sourceOperands=1121, newlyResolved=integrated_comparisons, unchangedPriorRoles=62,
        boundary='Exact argument roles only. All comparison-on-display roles and haiku dependency retained; input/display producer and application predicates remain separate.')
    consumers['mixedFamilyLeafPartitions'] = dict(Counter(r['decision'] for r in serialized if r['decision'].startswith('phase134:')))
    consumers['potentialControlLabelBindingStates'] = sum('consumerBindingPredicate' in r for r in serialized)
    for group in consumers['serializedGroups']:
        partition = Counter(r['role'] for r in serialized if r.get('serializedGroupIndex') == group['index'])
        if any(r.get('serializedGroupIndex') == group['index'] and r['decision'].startswith('phase134:') for r in serialized):
            group['historicalBaseRole'] = group['role']
            group['role'] = 'partitioned-by-exact-leaf'
            group['leafRoles'] = dict(partition)
    inputs = [BASE / 'parent-handoff.json', OUT / 'source-decisions.json', OUT / 'context-input-pins.json',
              OUT / 'direct-context.jsonl', OUT / 'animator-context.jsonl', OUT / 'context-transforms.jsonl',
              OUT / 'direct-value-context.json', SERIALIZED, INDEX / 'manifest.json', INDEX / 'literals.jsonl',
              BASE / 'remaining-bgdatabase-decisions.json', BASE / 'generated-field-binding-readback.json',
              BASE / 'remaining-column-readback.json', BASE / 'evidence/ui-consumer-bodies.jsonl',
              BASE / 'evidence/nodecanvas-string-leaves.jsonl', BASE / 'evidence/nodecanvas-types.json',
              LEDGER, FROZEN, ROOT / 'assets/source-v2/string-fields.json',
              ROOT / 'localization/source/dialogue-manifest.json', ROOT / 'special-scenes.json',
              ROOT / 'localization/source/inventory-20261026/literal-classification.json',
              ROOT / 'localization/supplemental-ui/20261027/source-catalog.json',
              ROOT / 'localization/supplemental-ui/20261027/manifest.json',
              ROOT / 'localization/supplemental-ui/20261027/locale-scope.json',
              OUT / 'IntroForestCutscene-waypoints.il', OUT / 'VerticalSliceIntroCutscene-waypoints.il']
    pins = {str(p.relative_to(ROOT)): sha(p) for p in inputs}
    pins[str((OUT / 'continuation-decisions.json').relative_to(ROOT))] = sha(OUT / 'continuation-decisions.json')
    pins[str((OUT / 'phase134/haiku-source-dependencies.json').relative_to(ROOT))] = sha(OUT / 'phase134/haiku-source-dependencies.json')
    case_spec = load(OUT / 'special-case-spec.json')
    extra = binding_products(consumer_products(database_products()))
    database_value_rows = [json.loads(s) for s in extra['dialogue-database-values.jsonl'].splitlines()]
    database_report = json.loads(extra['dialogue-database-reconciliation.json'])
    pins[str((OUT / 'special-case-spec.json').relative_to(ROOT))] = sha(OUT / 'special-case-spec.json')
    for name, digest in load(OUT / 'phase135/input-pins.json').items():
        assert sha(ROOT / name) == digest, ('phase135-input', name)
        pins[name] = digest
    pins[str((OUT / 'phase135/reconcile_database.py').relative_to(ROOT))] = sha(OUT / 'phase135/reconcile_database.py')
    for name, digest in load(OUT / 'phase136/input-pins.json').items():
        assert sha(ROOT / name) == digest, ('phase136-input', name)
        pins[name] = digest
    pins[str((OUT / 'phase136/reconcile_roles.py').relative_to(ROOT))] = sha(OUT / 'phase136/reconcile_roles.py')
    for name, digest in load(OUT / 'phase137/input-pins.json').items():
        assert sha(ROOT / name) == digest, ('phase137-input', name)
        pins[name] = digest
    pins[str((OUT / 'phase137/compiled-role-decisions.json').relative_to(ROOT))] = sha(OUT / 'phase137/compiled-role-decisions.json')
    pins[str((OUT / 'phase137/expand_roles.py').relative_to(ROOT))] = sha(OUT / 'phase137/expand_roles.py')
    for name, digest in load(OUT / 'phase138/input-pins.json').items():
        assert sha(ROOT / name) == digest, ('phase138-input', name)
        pins[name] = digest
    pins[str((OUT / 'phase138/compiled-role-decisions.json').relative_to(ROOT))] = sha(OUT / 'phase138/compiled-role-decisions.json')
    pins[str((OUT / 'phase138/expand_roles.py').relative_to(ROOT))] = sha(OUT / 'phase138/expand_roles.py')
    for name, digest in load(OUT / 'phase139/input-pins.json').items():
        assert sha(ROOT / name) == digest, ('phase139-input', name)
        pins[name] = digest
    for name in ['phase139/compiled-role-decisions.json', 'phase139/expand_roles.py']:
        pins[str((OUT / name).relative_to(ROOT))] = sha(OUT / name)
    for name, digest in load(OUT / 'phase140/input-pins.json').items():
        assert sha(ROOT / name) == digest, ('phase140-input', name)
        pins[name] = digest
    for name in ['phase140/compiled-role-decisions.json', 'phase140/expand_roles.py']:
        pins[str((OUT / name).relative_to(ROOT))] = sha(OUT / name)
    for name, digest in load(OUT / 'phase141/input-pins.json').items():
        assert sha(ROOT / name) == digest, ('phase141-input', name)
        pins[name] = digest
    for name in ['phase141/compiled-role-decisions.json', 'phase141/expand_roles.py']:
        pins[str((OUT / name).relative_to(ROOT))] = sha(OUT / name)
    for name, digest in load(OUT / 'phase142/input-pins.json').items():
        assert sha(ROOT / name) == digest, ('phase142-input', name)
        pins[name] = digest
    for name in ['phase142/compiled-role-decisions.json', 'phase142/expand_roles.py']:
        pins[str((OUT / name).relative_to(ROOT))] = sha(OUT / name)
    for name, digest in load(OUT / 'phase143/input-pins.json').items():
        assert sha(ROOT / name) == digest, ('phase143-input', name)
        pins[name] = digest
    for name in ['phase143/reconcile_bindings.py', 'phase143/role-decisions.json']:
        pins[str((OUT / name).relative_to(ROOT))] = sha(OUT / name)
    il_type_by_selector = {f"il:Assembly-CSharp.dll/{r['method']}/IL_{r['offset']:04x}":r['type']
                           for r in lines(INDEX / 'literals.jsonl')}
    cases = []
    for spec in case_spec['cases']:
        selected = {}
        indices = set(spec.get('directIndices', [])) | {i for a,b in spec.get('directRanges', []) for i in range(a,b+1)}
        for row in serialized:
            if row.get('directValueIndex') in indices or row.get('serializedGroupIndex') in spec.get('serializedGroups', []):
                selected[row['id']] = row
        for selector in spec.get('bgSelectors', []):
            match = [r for r in bg if (r['sheet'],r['field']) == (selector['sheet'],selector['field'])
                     and ('rows' not in selector or r['rowIndex'] in selector['rows'])]
            assert match, ('empty-case-bg-selector', spec['id'], selector)
            for row in match:
                selected[row['id']] = row
        for row in il:
            if il_type_by_selector[row['id']] in spec.get('managedTypes', []) or row['id'] in spec.get('managedLiteralIds', []):
                selected[row['id']] = row
        for row in frozen:
            if row['conversationId'] in spec.get('dialogueConversationIds', []):
                selected[row['id']] = row
        database_nodes = {tuple(pair) for pair in spec.get('databaseNodes', [])}
        if database_nodes:
            for row in frozen:
                if (row['conversationId'],row['entryId']) in database_nodes:
                    selected[row['id']] = row
            for row in database_value_rows:
                if (row.get('conversationId'),row.get('entryId')) in database_nodes:
                    for occurrence in row['occurrences']:
                        selected[occurrence] = dict(id=occurrence,sourceValueSha256=row['sourceValueSha256'],role=row['role'])
            dependency = json.loads(extra[spec['dependencyArtifact']])
            dependency_ids = set(dependency['sourceIds'])
            for row in frozen:
                if row['id'] in dependency_ids:
                    selected[row['id']] = row
            assert dependency_ids <= set(selected), ('missing-runtime-write-dependency',spec['id'])
            producer_ids = set(dependency.get('runtimeProducerIds', []))
            for row in il:
                if row['id'] in producer_ids:
                    selected[row['id']] = row
            assert producer_ids <= set(selected), ('missing-runtime-producer-dependency',spec['id'])
        assert selected, ('empty-special-case', spec['id'])
        cases.append(dict(id=spec['id'], category=spec['category'], invariant=spec['invariant'],
                          route=spec['route'], positive=spec['positive'], negative=spec['negative'],
                          sourceBindings=[dict(id=r['id'], sourceValueSha256=r['sourceValueSha256'], role=r['role']) for r in selected.values()],
                          pendingDependencies=spec['pendingDependencies'], sourceAnalysis='needs-review-dependency-closure',
                          editorial='not-run', adapter='not-run-for-new-source', structural='exact-source-bindings',
                          runtimeVisual='not-run', localeDecisions={}))
        if 'dependencyArtifact' in spec:
            cases[-1]['dependencyArtifact'] = spec['dependencyArtifact']
    case_registry = dict(schemaVersion=1, game='The Forest of Love', build='0.45',
                          sourceRevision='shared-source-completion-20261028/admission-v1',
                          discoveryCoverage=case_spec['discoveryCoverage'], sourceAcceptance='needs-review',
                          localePretranslationGate='not-run-for-new-source;all30-locales', cases=cases,
                          retainedRootRegistry=dict(path='special-scenes.json',sha256=sha(ROOT / 'special-scenes.json'),
                                                    boundary='Historical partial texture/source registry, not complete textual discovery.'),
                          boundary='Exact newly registered dependency groups; no absence claim for unreviewed source, no accepted locale wording or image edits.')
    unresolved_methods = {}
    for row in il:
        if row['role'] == 'needs-consumer-decision':
            unresolved_methods.setdefault(row['method'], []).append(row['id'])
    unresolved = dict(schemaVersion=1, compiledLiteralStates=counts['unresolvedCompiledStates'],
                      compiledMethods=[dict(method=m, literalIds=ids) for m,ids in unresolved_methods.items()],
                      serializedStates=counts['unresolvedSerializedStates'],
                      potentialControlLabelBindingStates=sum('consumerBindingPredicate' in r for r in serialized),
                      serializedGroups=[dict(index=i, **g, decision=group_choices[i]['id'],
                                             predicate=group_choices[i]['unresolvedPredicate'])
                                        for i,g in enumerate(group_roster) if any(
                                            r.get('serializedGroupIndex') == i and 'unresolvedPredicate' in r for r in serialized)],
                      potentialLabelGroups=[dict(index=i, className=g['className'], field=g['field'],
                                                 states=sum(r.get('serializedGroupIndex') == i and 'consumerBindingPredicate' in r for r in serialized))
                                            for i,g in enumerate(group_roster) if any(
                                                r.get('serializedGroupIndex') == i and 'consumerBindingPredicate' in r for r in serialized)],
                      nextPredicate='Resolve actual text producers and mixed operands; do not replace this with recursive TMP/font/framework tracing.')
    manifest = dict(schemaVersion=1, game='The Forest of Love', build='0.45', sourceLocale='en',
                    revision='shared-source-completion-20261028/admission-v1',
                    status='complete-linked-storage-inventory;partial-source-admission',
                    commonSourceAccepted=False, translationEntryAllowed=False,
                    completeVisibleTranslationDenominator=None,
                    sourceRoleResolvedScopes=['29 remaining BG columns (3279 states), with17 dormant greeting states retained',
                                              '6909 native initial text states (400 values)',
                                              '124 animator input/cache states', '1653 inventoried NodeCanvas string leaves',
                                              'five Waypoint.title states across four complete consumer bodies',
                                              '2658 immediate generated DB literal operands'],
                    unresolvedScopes=['Managed literal producers outside reviewed/immediate/retained decisions',
                                      'OSK specialKeys mixed grammar/labels and Rewired possible control-display labels',
                                      'Dialogue inline grammar/control spans and complete textual special-scene discovery',
                                      'Runtime producers replacing stored native examples; actual application selectors',
                                      'Noncandidate DialogueDatabase fields, TextAsset/resource-family cross-reconciliation'],
                    linkedCompleteSerializedInventory=dict(path='assets/source-v2/string-fields.json',
                        sha256=pins['assets/source-v2/string-fields.json'], states=911903,
                        rule='Existing stable id/object/pointer/value inventory reused unchanged. This supplement explicitly classifies36107 non-dialogue states; other875796 states retain their prior classification/hold, never an inferred exclusion.'),
                    counts=counts, inputs=pins, targetLocales=locale_scope,
                    texturePolicy='notify-only;all texture bytes unchanged',
                    scopeBoundary='Inventory includes dormant/potential text. Source-role resolution does not establish reachability, reinsertion, editorial, fonts/shaping/RTL, full-game source or release acceptance.',
                    model=dict(model='gpt-6.1-sol', reasoning='high', provider='OpenAI', ignoreUserConfig=True,
                               verification='Actual current CLI ancestor arguments; no nested model/CLI jobs or agents.'),
                    gitCoordinator='parent', workerGitMutations=0, runtime='not-run', visual='not-run')
    manifest['sourceRoleResolvedScopes'].append('1782 mixed OSK/Rewired states partitioned by typed leaf; potential resource/control labels retained with display-alias binding unknown')
    manifest['sourceRoleResolvedScopes'].append('Phase134 exact immediate game dictionary/state arguments, four conversation-key stores and complete selected producer bodies')
    manifest['unresolvedScopes'][1] = 'Potential Rewired label aliases: actual vendor/game UI binding and selection unverified; original resource/dispatch values held exact'
    manifest['counts']['potentialControlLabelBindingStates'] = sum('consumerBindingPredicate' in r for r in serialized)
    manifest['haikuDependencyArtifact'] = 'phase134/haiku-source-dependencies.json'
    manifest['sourceRoleResolvedScopes'].append('1059 previously unknown immediate comparison/search/pattern operands integrated by exact argument identity; existing precise roles preserved')
    manifest['sourceRoleResolvedScopes'].append('Complete frozen dialogue lexical partition:12246 IDs/24492 occurrences,7103 exact markup/delimiter spans and291 line separators; ordinary text spans separate from field eligibility')
    manifest['unresolvedScopes'][2] = 'Whole-field dialogue callbacks, registered effects, display producers and complete textual special-scene discovery; lexical spans resolved separately'
    manifest['unresolvedScopes'][-1] = 'Noncandidate database typed consumer gaps explicitly enumerated in dialogue-database-unresolved.json; TextAsset/resource-family joins remain separate'
    manifest['linkedCompleteSerializedInventory']['rule'] = 'Exact911903-state source union reconciled:36107 non-dialogue plus875796 nonempty original database strings. Empty database strings and nonstring state remain in the full tree contract. Complete storage accounting does not accept unresolved typed consumers or whole-game source.'
    manifest['dialogueLexicalArtifact'] = 'dialogue-inline-partitions.jsonl'
    manifest['dialogueDatabaseArtifact'] = 'dialogue-database-reconciliation.json'
    manifest['counts']['noncandidateDatabaseUnresolvedLogicalValues'] = database_report['unresolvedLogicalValues']
    manifest['counts']['databasePhysicalStringStatesIncludingEmpty'] = database_report['physicalStringStates']
    manifest['sourceRoleResolvedScopes'].append('Phase136 five exact dynamic/story Title control keys; all1660 former residual values have bounded per-selector dispositions. Compiled fast-travel greeting producer joins seven frozen text IDs without changing source values.')
    manifest['dialogueDatabaseConsumerDispositionArtifact'] = 'dialogue-database-consumer-dispositions.json'
    consumers['dialogueDatabase'] = dict(artifact='dialogue-database-reconciliation.json',
        unresolvedArtifact='dialogue-database-unresolved.json', completeStorageUnion=911903,
        typedConsumerUnresolved=database_report['unresolvedLogicalValues'], runtime='not-run')
    consumers['phase137CompiledRoleDelta'] = dict(artifact='phase137/compiled-role-decisions.json',
        resolved=817, displaySourceOperands=20, preservedOperands=797, remaining=1583,
        parentAdventureOperands=44, boundary=compiled_delta['boundary'])
    manifest['sourceRoleResolvedScopes'].append('Phase137 exact817 compiled-role decisions: parent Adventure44 plus773 typed argument/report operands;20 new complete display sources and797 protected operands. Original8576 source identities/values/order remain exact.')
    manifest['compiledRoleDeltaArtifact'] = 'compiled-source-role-delta.jsonl'
    command_outputs = command_products()
    assert json.loads(json.dumps(command_delta)) == command_outputs['phase138/compiled-role-decisions.json'], 'command-role-expansion'
    consumers['phase138CompiledRoleDelta'] = dict(artifact='phase138/compiled-role-decisions.json',resolved=145,protectedOperands=145,visibleIdentityDependencies=120,remaining=1438,remainingSelected=110,boundary=command_delta['boundary'])
    manifest['sourceRoleResolvedScopes'].append('Phase138 exact145 command/scene/save identities, including103 executable suggestion namespaces and17 scene-label producers.120 displayed identities are retained separately;110 selected consumer roles and1438 total compiled roles remain held.')
    manifest['compiledDisplayIdentityDependencies'] = 'compiled-display-identity-dependencies.json'
    console_outputs = console_products()
    assert console_delta == console_outputs['phase139/compiled-role-decisions.json'], 'console-role-expansion'
    consumers['phase139CompiledRoleDelta'] = dict(artifact='phase139/compiled-role-decisions.json',resolved=110,wordingOperands=62,protectedOperands=48,displayedFilterIdentities=7,remaining=1328,remainingSelected=0,boundary=console_delta['boundary'])
    manifest['sourceRoleResolvedScopes'].append('Phase139 finishes all110 selected command/console consumers across32 methods:62 wording and48 preserved operands, with seven dual displayed filter identities;1328 original compiled roles remain across469 methods.')
    manifest['compiledConsoleSourceContext'] = 'compiled-console-source-context.json'
    playback_outputs = playback_products()
    assert playback_delta == playback_outputs['phase140/compiled-role-decisions.json'], 'playback-role-expansion'
    consumers['phase140CompiledRoleDelta'] = dict(artifact='phase140/compiled-role-decisions.json',resolved=23,wordingOperands=3,protectedOperands=20,remaining=1305,remainingSelected=54,boundary=playback_delta['boundary'])
    manifest['sourceRoleResolvedScopes'].append('Phase140 adjudicates all23 playback operands across10 complete DialogueService producers: three conditional Unity-console wording inputs and20 exact conversation/node/template/Lua/history operands.54 assigned loader roles across16 methods and1251 other compiled roles remain explicit; whole compiled scope1305 across459 methods.')
    manifest['compiledPlaybackSourceContext'] = 'compiled-playback-source-context.json'
    arc_outputs = arc_products()
    assert arc_delta == arc_outputs['phase141/compiled-role-decisions.json'], 'arc-role-expansion'
    consumers['phase141CompiledRoleDelta'] = dict(artifact='phase141/compiled-role-decisions.json',resolved=25,potentialExceptionWording=11,protectedOperands=14,remaining=1280,remainingSelected=29,boundary=arc_delta['boundary'])
    manifest['sourceRoleResolvedScopes'].append('Phase141 resolves exact25 remaining PopulateDialogueArcs operands:11 potential exception wording inputs and14 protected actor/field/identity/assembly operands. All33 complete producer literals and actual lookup/storage/throw boundaries are bound; prior eight precise roles retained.29 loader operands across15 methods plus1251 other compiled roles remain. Exception presentation unknown, not inferred from LogError.')
    manifest['compiledArcSourceContext'] = 'compiled-arc-source-context.json'
    loader_outputs = loader_products()
    assert loader_delta == loader_outputs['phase142/compiled-role-decisions.json'], 'loader-role-expansion'
    consumers['phase142CompiledRoleDelta'] = dict(artifact='phase142/compiled-role-decisions.json',resolved=29,potentialExceptionWording=18,protectedOperands=11,completeProducerLiterals=64,priorPreciseRolesRetained=35,remaining=1251,remainingSelected=0,boundary=loader_delta['boundary'])
    manifest['sourceRoleResolvedScopes'].append('Phase142 finishes every29 remaining loader operand across15 full producers:18 potential exception wording and11 protected watch/identifier/BIO/exception-separator operands. All64 complete producer literals and35 prior precise roles are bound. Actual action/watch/parser/portrait/font/priority consumers are source-bound; fictional mapping unchanged. No assigned loader roles remain;1251 other original compiled roles remain explicit.')
    manifest['compiledLoaderSourceContext'] = 'compiled-loader-source-context.json'
    unresolved['nextPredicate'] = NEXT_SOURCE
    manifest['sourceRoleResolvedScopes'].append('Phase143 finite1655 database serialized/caller dispositions: complete39-instance persistent-field absence, actual Rascal receiver predicate, all41 nonempty original Lua expressions and six direct API callers. Residual source-policy/external uncertainty retained; no new exclusions.')
    manifest['dialogueDatabaseCallerBindings'] = 'dialogue-database-caller-bindings.json'
    consumers['dialogueDatabase']['callerBindingArtifact'] = 'dialogue-database-caller-bindings.json'
    consumers['dialogueDatabase']['finiteStaticAssignment'] = 'complete;source-policy/external-boundary-retained'
    for name, digest in load(OUT / 'phase144/input-pins.json').items():
        assert sha(ROOT/name)==digest, ('phase144-input', name)
        pins[name]=digest
    for name in ['phase144/input-pins.json','phase144/expand_roles.py','phase144/validate_roles.py','phase144/compiled-role-decisions.json']:
        pins[str((OUT/name).relative_to(ROOT))]=sha(OUT/name)
    manifest['compiledRemainingSourceContext']='compiled-remaining-source-context.json'
    manifest['sourceRoleResolvedScopes'].append('Phase144 consolidates the entire1251-selector scope:682 exact typed roles resolved;569 remain across284 methods, with all443 complete producers captured and47 named receivers pinned. Capture is not semantic coverage. Original prior roles and source identities/values/order remain exact.')
    manifest['unresolvedScopes'][0]='Three exact static-field external/source-policy holds at original source lines331,332,4948; phase146/next-compiled-selectors.json. No inferred display absence.'
    consumers['phase144CompiledRoleDelta']=dict(artifact='phase144/compiled-role-decisions.json',assigned=1251,assignedMethods=443,resolved=682,remaining=569,remainingMethods=284,roleCounts=remaining_delta['roleCounts'],boundary=remaining_delta['boundary'])
    for name,digest in load(OUT/'phase145/input-pins.json').items():
        assert sha(ROOT/name)==digest,('phase145-input',name)
        pins[name]=digest
    for name in ['phase145/input-pins.json','phase145/expand_roles.py','phase145/selector_specs.py','phase145/validate_roles.py','phase145/compiled-role-decisions.json']:
        pins[str((OUT/name).relative_to(ROOT))]=sha(OUT/name)
    manifest['compiledTailSourceContext']='compiled-tail-source-context.json'
    manifest['sourceRoleResolvedScopes'].append('Phase145 adjudicates the whole569-remainder assignment and resolves318 exact operand roles across typed argument, original branch, cache and named receiver proofs. All prior8007 precise records and complete original identities/values/order remain exact;251 remain across98 methods.84 conditional console wording,8 direct display,17 potential display/exception/input and209 protected operands remain distinct; no runtime/source admission is implied.')
    consumers['phase145CompiledRoleDelta']=dict(artifact='phase145/compiled-role-decisions.json',assigned=569,assignedMethods=284,resolved=318,remaining=251,remainingMethods=98,roleCounts=tail_delta['roleCounts'],boundary=tail_delta['boundary'])
    for name,digest in load(OUT/'phase146/input-pins.json').items():
        assert sha(ROOT/name)==digest,('phase146-input',name)
        pins[name]=digest
    for name in ['phase146/input-pins.json','phase146/expand_roles.py','phase146/selector_specs.py','phase146/validate_roles.py','phase146/compiled-role-decisions.json','phase146/static-field-holds.json','phase146/literal-transport-normalization.json']:
        pins[str((OUT/name).relative_to(ROOT))]=sha(OUT/name)
    manifest['compiledFinalSourceContext']='compiled-final-source-context.json'
    manifest['sourceRoleResolvedScopes'].append('Phase146 resolves248 of251 exact original compiled roles across95 methods. Named original store/return/branch consumers and48 receiver snapshots preserve all8325 prior precise records. Three static-field external/source-policy holds remain; whole source, resource and runtime acceptance stay open.')
    consumers['phase146CompiledRoleDelta']=dict(artifact='phase146/compiled-role-decisions.json',assigned=251,assignedMethods=98,resolved=248,remaining=3,remainingMethods=3,roleCounts=final_delta['roleCounts'],boundary=final_delta['boundary'])
    literal_values = {(r['method'],r['offset']):r['value'] for r in lines(INDEX/'literals.jsonl')}
    delta_rows = [dict(r, sourceIndexReference=dict(path=str((INDEX/'literals.jsonl').relative_to(ROOT)),line=new_by_id[r['id']]['sourceLine']),
                       **({'source':literal_values[r['method'],r['offset']]} if r['role'].startswith(('display','potential-display')) else {}))
                  for r in final_delta['decisions']]
    compiled_wording = [dict(r,source=literal_values[r['method'],r['offset']]) for r in il
                        if r['role'].startswith(('display','visible','special-display','potential-display')) or r['role']=='comparison-on-display']
    compiled_preserve = [dict(id=r['id'],method=r['method'],offset=r['offset'],sourceLine=r['sourceLine'],
                             sourceValueSha256=r['sourceValueSha256'],role=r['role'],decision=r['decision'],
                             sourceIndex=str((INDEX/'literals.jsonl').relative_to(ROOT)),
                             adaptation='Preserve this exact operand until an explicit source-bound adapter contract supersedes it; any displayed alias/producer remains separate.')
                         for r in il if r['role'].startswith('preserve') or r['role']=='comparison-on-display']
    unresolved['dialogueDatabase'] = dict(artifact='dialogue-database-unresolved.json',
        counts=database_report['unresolvedRoles'], predicates=database_report['unresolvedPredicates'])
    result = {
        'serialized-inventory.jsonl': jl(serialized), 'bgdatabase-inventory.jsonl': jl(bg),
        'frozen-dialogue-bindings.jsonl': jl(frozen), 'managed-literal-inventory.jsonl': jl(il),
        'nodecanvas-preserve-exactly.jsonl': jl(nodes), 'consumer-matrix.json': j(consumers),
        'special-cases.json': j(case_registry), 'unresolved-consumers.json': j(unresolved),
        'old935-selector-bindings.json': j(old_bindings), 'additional-source-selectors.jsonl': jl(additions),
        'thirty-locale-coverage.json': j(coverage), 'manifest.json': j(manifest),
        'compiled-source-role-delta.jsonl': jl(delta_rows),
        'compiled-wording-source.jsonl': jl(compiled_wording),
        'compiled-preserve-exactly.jsonl': jl(compiled_preserve),
        'compiled-source-handoff.json': j(dict(schemaVersion=1,phase='0146-work',targetLocales=locale_scope,
            originalOccurrences=8576, resolvedOccurrences=8576-counts['unresolvedCompiledStates'],
            unresolvedOccurrences=counts['unresolvedCompiledStates'], completeCompiledRolePacket=False,
            newDelta=dict(artifact='compiled-source-role-delta.jsonl',occurrences=248,display=sum(r['role'].startswith('display') for r in final_delta['decisions']),potentialDisplay=0,preserve=sum(r['role'].startswith('preserve') for r in final_delta['decisions']),visibleIdentityDependencies=0,remainingSelected=3),
            knownWording=dict(artifact='compiled-wording-source.jsonl',occurrences=len(compiled_wording),completeWhileRolesUnresolved=False),
            preservedOperands=dict(artifact='compiled-preserve-exactly.jsonl',occurrences=len(compiled_preserve),
                overlap='The12 comparison-on-display operands also appear in the wording dependency family; preserve them until an identity adapter is verified.'),
            preserveContract='Every resolved non-wording occurrence remains bound to exact original index method/offset/value hash. Display comparisons/identities and format/markup roles retain separate adaptation/preservation contracts; no whole-method exclusions.',
            visibleIdentityDependencies=dict(artifact='compiled-display-identity-dependencies.json',occurrences=120,boundary='Displayed executable/state identities; original spelling remains protected. Separate from target wording and the12 retained display comparisons.'),
            displayedFilterDependencies=dict(artifact='compiled-console-source-context.json',occurrences=7,boundary='Additional protected typeName values also displayed; original filter values retained, no caption projection implemented.'),
            remainingArtifact='unresolved-consumers.json',nextSelectors='phase146/next-compiled-selectors.json',databaseCallerBinding='dialogue-database-caller-bindings.json',handoffContinuationPhase='0146-work',remainingContext='compiled-final-source-context.json',consoleContext='compiled-console-source-context.json',playbackContext='compiled-playback-source-context.json',arcContext='compiled-arc-source-context.json',loaderContext='compiled-loader-source-context.json',exceptionPresentation='unknown;ctor-and-throw-proved-only',
            commonSourceAccepted=False,translationEntryAllowed=False,editorial='not-run',runtime='not-run',
            boundary='Material subset; neither an accepted full source family nor a visible translation denominator. Targets and textures unchanged.')),
    }
    result.update(extra)
    result.update({name:j(value) for name,value in tail_outputs.items()})
    result.update({name:j(value) for name,value in final_outputs.items()})
    result.update({name:j(value) for name,value in remaining_outputs.items()})
    result.update({name:j(value) for name,value in command_outputs.items() if name!='phase138/compiled-role-decisions.json'})
    result.update({name:j(value) for name,value in console_outputs.items() if name!='phase139/compiled-role-decisions.json'})
    result.update({name:j(value) for name,value in playback_outputs.items() if name!='phase140/compiled-role-decisions.json'})
    result.update({name:j(value) for name,value in arc_outputs.items() if name!='phase141/compiled-role-decisions.json'})
    result.update({name:j(value) for name,value in loader_outputs.items() if name!='phase142/compiled-role-decisions.json'})
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    data = products()
    for name, content in data.items():
        path = OUT / name
        if args.check:
            assert path.read_bytes() == content, ('nonreproducible-product', name)
        else:
            path.write_bytes(content)
    print(json.dumps(dict(status='passed-reproduction' if args.check else 'built',
                          files=len(data), counts=json.loads(data['manifest.json'])['counts'])))


if __name__ == '__main__':
    main()
