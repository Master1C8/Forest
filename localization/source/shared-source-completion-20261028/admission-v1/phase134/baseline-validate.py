"""Validate exact source bindings and protected values, not translation meaning.

Uses existing exported values and source spans; never reruns extraction or calls
models. New source admission remains blocked by explicitly recorded predicates.
"""
import base64
import copy
import hashlib
import json
from pathlib import Path

from prepare_context import ROOT, OUT, BASE, sha, load, lines
from build_inventory import INDEX, SERIALIZED, LEDGER, FROZEN, value_hash


def exact_rows(expected, actual):
    """Full ID/value/role comparison, including protected rows; no substring test."""
    if [r['id'] for r in expected] != [r['id'] for r in actual]:
        raise ValueError('ordered-source-identities')
    if len({r['id'] for r in actual}) != len(actual):
        raise ValueError('duplicate-source-identity')
    for left, right in zip(expected, actual):
        if left != right:
            raise ValueError('exact-source-record:' + left['id'])


def main():
    manifest = load(OUT / 'manifest.json')
    for name, expected in manifest['inputs'].items():
        assert sha(ROOT / name) == expected, ('input-fingerprint', name)
    pins = load(OUT / 'context-input-pins.json')
    for name, expected in pins['parentInputs'].items():
        assert sha(ROOT / name) == expected, ('parent-fingerprint', name)
    for name, expected in pins['sourceTrees'].items():
        assert sha(ROOT / name) == expected, ('original-component-tree', name)
    assert sha(OUT / 'context-transforms.jsonl') == pins['nativeTransformSnapshotSha256']

    expected_serialized = list(lines(SERIALIZED))
    serialized = list(lines(OUT / 'serialized-inventory.jsonl'))
    assert [r['id'] for r in expected_serialized] == [r['id'] for r in serialized]
    for source, row in zip(expected_serialized, serialized):
        assert value_hash(source['value']) == row['sourceValueSha256'], ('serialized-exact-value', row['id'])
        if 'source' in row:
            assert source['value'] == row['source'], ('serialized-display-source', row['id'])
        assert not (source['class'].endswith('CodecksApiSettings') and 'source' in row), 'configuration-exposure'

    original_trees = {}
    def tree(name):
        if name not in original_trees:
            original_trees[name] = load(ROOT / 'assets/source-v2' / name)
        return original_trees[name]
    direct = list(lines(OUT / 'direct-context.jsonl'))
    animator = list(lines(OUT / 'animator-context.jsonl'))
    paired = []
    for context in direct + animator:
        assert tree(context['tree'])[context['pointer'][1:]] == context['value'], ('text-context-readback', context['id'])
    direct_by_object = {r['object']: r for r in direct}
    for r in animator:
        peers = [direct_by_object[p['object']] for p in r['peers'] if p['object'] in direct_by_object]
        assert len(peers) == 1, ('animator-TMP-peer', r['id'])
        paired.append(dict(animatorId=r['id'], tmpId=peers[0]['id'],
                           equalStoredValue=(r['value'] == peers[0]['value']),
                           animatorValueSha256=value_hash(r['value']), tmpValueSha256=value_hash(peers[0]['value']),
                           application='paired-source-cache-coherence-required;runtime-order-not-tested'))

    bg_source = list(lines(LEDGER))
    bg = list(lines(OUT / 'bgdatabase-inventory.jsonl'))
    assert [r['id'] for r in bg_source] == [r['id'] for r in bg]
    payload = ROOT / 'assets/source-v2/text-assets/90744c19ec-resources.assets-320.bin'
    raw = payload.read_bytes()
    assert hashlib.sha256(raw).hexdigest() == '41834cda2f3ea6f010234f3ca2332e31b95b990ab38a8940b0d92f000477fda9'
    present = absent = 0
    for source, row in zip(bg_source, bg):
        assert row['sourceValueSha256'] == value_hash(source['source'])
        assert (row['stored'], row['sourceSpan']) == (source['stored'], source['sourceSpan'])
        if 'source' in row:
            assert source['source'] == row['source']
        if not source['stored']:
            assert source['sourceSpan'] is None and source['sourceBytesBase64'] is None
            absent += 1
            continue
        span = source['sourceSpan']
        original = base64.b64decode(source['sourceBytesBase64'], validate=True)
        assert raw[span['offset']:span['offset']+span['bytes']] == original, ('BG-source-span', source['id'])
        if isinstance(source['source'], str) and source['kind'] in ('BGFieldString','BGFieldText','BGFieldEntityName'):
            assert original.decode('utf-8') == source['source']
        present += 1

    il_source = list(lines(INDEX / 'literals.jsonl'))
    il = list(lines(OUT / 'managed-literal-inventory.jsonl'))
    for source, row in zip(il_source, il):
        assert row['method'] == source['method'] and row['offset'] == source['offset']
        assert row['sourceValueSha256'] == value_hash(source['value'])
        if 'source' in row:
            assert source['value'] == row['source']
    assert len(il) == len(il_source) == 8576
    frozen_source = list(lines(FROZEN))
    frozen = list(lines(OUT / 'frozen-dialogue-bindings.jsonl'))
    for source, row in zip(frozen_source, frozen):
        assert (source['id'], source['source'], source['occurrences']) == (row['id'], row['source'], row['occurrences'])
    assert len(frozen) == len(frozen_source) == 12246
    assert sum(len(r['occurrences']) for r in frozen) == 24492

    nodes = list(lines(OUT / 'nodecanvas-preserve-exactly.jsonl'))
    node_source = list(lines(BASE / 'evidence/nodecanvas-string-leaves.jsonl'))
    for source, row in zip(node_source, nodes):
        assert (source['sourceFieldId'], source['pointer'], source['value']) == (row['sourceFieldId'],row['pointer'],row['source'])
    assert len(nodes) == len(node_source) == 1653
    roster_by_id = {r['id']: r['value'] for r in expected_serialized}
    def pointer(value, path):
        for part in path.split('/')[1:]:
            part = part.replace('~1','/').replace('~0','~')
            value = value[int(part)] if isinstance(value, list) else value[part]
        return value
    for row in nodes:
        enclosing = json.loads(roster_by_id[row['sourceFieldId']])
        assert pointer(enclosing,row['pointer']) == row['source'], ('node-leaf-readback',row['id'])

    # The validator's negative control reaches the exact record comparison with
    # identical IDs/order/length, then changes only a protected value hash.
    real_protected = next(r for r in serialized if r['role'] == 'preserve-control')
    control = [copy.deepcopy(real_protected)]
    exact_rows([real_protected], control)
    control[0]['sourceValueSha256'] = value_hash('changed-protected-control')
    try:
        exact_rows([real_protected], control)
    except ValueError as e:
        assert str(e) == 'exact-source-record:' + real_protected['id']
    else:
        raise AssertionError('mutated-protected-value-accepted')
    # Equal wording in two real, different source selectors must stay two rows.
    pairs = {}
    same_wording = None
    for row in serialized:
        if row['sourceValueSha256'] in pairs:
            same_wording = [pairs[row['sourceValueSha256']], row]
            break
        pairs[row['sourceValueSha256']] = row
    assert same_wording and same_wording[0]['id'] != same_wording[1]['id']
    exact_rows(same_wording, copy.deepcopy(same_wording))
    try:
        exact_rows(same_wording, [same_wording[0]])
    except ValueError as e:
        assert str(e) == 'ordered-source-identities'
    else:
        raise AssertionError('deduplicated-physical-occurrence-accepted')

    # This reads immutable existing proof of complete field-blob restoration;
    # replaying a bytearray copy would not independently test that boundary.
    prior = load(ROOT / 'localization/source/bgdatabase-complete-values-20261027/readback-validation.json')
    assert prior['sourceAndOutputPins'][str(LEDGER.relative_to(ROOT))] == sha(LEDGER)
    assert prior['wholePayloadReconstructedSha256'] == hashlib.sha256(raw).hexdigest()
    assert prior['restoredFromDeliveredCellsFieldBlobs'] == 289
    receipt = dict(schemaVersion=1, status='passed-exact-source-readback',
                   serializedStates=len(serialized), directNativeTextStates=len(direct),
                   animatorStates=len(animator), animatorTmpPairs=len(paired),
                   equalStoredAnimatorTmpPairs=sum(r['equalStoredValue'] for r in paired),
                   bgStates=len(bg), bgStored=present, bgAbsent=absent,
                   compiledLiteralStates=len(il), nodeCanvasLeaves=len(nodes),
                   frozenDialogueIds=len(frozen), frozenDialogueOccurrences=24492,
                   originalTreeFingerprints=len(pins['sourceTrees']), nativeTransformBodies=pins['nativeTransformBodies'],
                   regressions=dict(protectedValueMutationRejected=True, equalWordingOccurrenceLossRejected=True,
                                    matchingPositiveControlsPassed=True),
                   reusedWholePayloadRestoration=dict(path='localization/source/bgdatabase-complete-values-20261027/readback-validation.json',
                       sha256=sha(ROOT / 'localization/source/bgdatabase-complete-values-20261027/readback-validation.json'),
                       fields=289, payloadSha256=hashlib.sha256(raw).hexdigest()),
                   noGateWaiver=dict(commonSourceAccepted=False, translationEntryAllowed=False,
                                    editorial='not-run', reinsertion='not-run', runtime='not-run', visual='not-run'),
                   boundary='Source/identity/typed-span readback and preserved native-component context. No translation, original install writes, game launch, image input or save access. Multi-file artifacts are written sequentially; no transaction/rollback claim.',
                   validatorSha256=sha(Path(__file__)), builderSha256=sha(OUT / 'build_inventory.py'),
                   manifestSha256=sha(OUT / 'manifest.json'))
    (OUT / 'animator-tmp-pairs.json').write_text(json.dumps(paired,ensure_ascii=False,indent=2)+'\n')
    (OUT / 'readback-validation.json').write_text(json.dumps(receipt,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps(receipt))


if __name__ == '__main__':
    main()
