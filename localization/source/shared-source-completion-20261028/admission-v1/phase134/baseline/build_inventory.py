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


def products():
    decisions = load(OUT / 'source-decisions.json')
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
        row = dict(id=f"il:Assembly-CSharp.dll/{r['method']}/IL_{r['offset']:04x}",
                   family='managed-literal', method=r['method'], offset=r['offset'], sourceLine=n,
                   sourceValueSha256=value_hash(r['value']), role=role, decision=decision,
                   application='hold-common-source-special-case-and-feasibility-gates')
        if role.startswith(('display', 'visible', 'special-display')) or role == 'comparison-on-display':
            row['source'] = r['value']
        il.append(row)
    assert len(il) == len({r['id'] for r in il}) == 8576

    old = load(ROOT / 'localization/supplemental-ui/20261027/source-catalog.json')['units']
    old_by_id = {r['id']: r for r in old}
    full_rows = serialized + bg + il
    new_by_id = {r['id']: r for r in full_rows}
    assert len(new_by_id) == len(full_rows)
    old_bindings = []
    for r in old:
        same = new_by_id.get(r['id'])
        old_bindings.append(dict(id=r['id'], sourceValueSha256=value_hash(r['source']),
                                 binding='exact-occurrence' if same else 'requires-selector-alias-reconciliation',
                                 valueMatches=(same['sourceValueSha256'] == value_hash(r['source'])) if same else None))
    # Include every old selector in the finite comparison, without equating two
    # instances merely because their English wording happens to match.
    additions = [dict(id=r['id'], family=r['family'], role=r['role'], sourceValueSha256=r['sourceValueSha256'],
                      category=('unresolved' if 'unresolvedPredicate' in r else
                                'preserve-display' if r['role'].startswith('preserve') else
                                'potential-or-dormant' if r['role'].startswith(('potential','dormant')) else
                                'display-candidate'))
                 for r in full_rows if ('display' in r['role'] or r['role'].startswith('visible')) and r['id'] not in old_by_id]
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
    case_spec = load(OUT / 'special-case-spec.json')
    pins[str((OUT / 'special-case-spec.json').relative_to(ROOT))] = sha(OUT / 'special-case-spec.json')
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
            if il_type_by_selector[row['id']] in spec.get('managedTypes', []):
                selected[row['id']] = row
        assert selected, ('empty-special-case', spec['id'])
        cases.append(dict(id=spec['id'], category=spec['category'], invariant=spec['invariant'],
                          route=spec['route'], positive=spec['positive'], negative=spec['negative'],
                          sourceBindings=[dict(id=r['id'], sourceValueSha256=r['sourceValueSha256'], role=r['role']) for r in selected.values()],
                          pendingDependencies=spec['pendingDependencies'], sourceAnalysis='needs-review-dependency-closure',
                          editorial='not-run', adapter='not-run-for-new-source', structural='exact-source-bindings',
                          runtimeVisual='not-run', localeDecisions={}))
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
                      serializedGroups=[dict(index=i, **g, decision=group_choices[i]['id'],
                                             predicate=group_choices[i]['unresolvedPredicate'])
                                        for i,g in enumerate(group_roster) if 'unresolvedPredicate' in group_choices[i]],
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
    return {
        'serialized-inventory.jsonl': jl(serialized), 'bgdatabase-inventory.jsonl': jl(bg),
        'frozen-dialogue-bindings.jsonl': jl(frozen), 'managed-literal-inventory.jsonl': jl(il),
        'nodecanvas-preserve-exactly.jsonl': jl(nodes), 'consumer-matrix.json': j(consumers),
        'special-cases.json': j(case_registry), 'unresolved-consumers.json': j(unresolved),
        'old935-selector-bindings.json': j(old_bindings), 'additional-source-selectors.jsonl': jl(additions),
        'thirty-locale-coverage.json': j(coverage), 'manifest.json': j(manifest),
    }


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
