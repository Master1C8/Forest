"""Read existing exports only; bind every native/animator input to its component.

No extraction, game execution, images, translation, or semantic auto-approval.
"""
import hashlib
import json
from collections import Counter
from functools import lru_cache
from pathlib import Path

ROOT = Path(__file__).resolve().parents[4]
OUT = Path(__file__).resolve().parent
BASE = OUT.parent
EXPORT = ROOT / 'assets/source-v2'


def sha(p):
    h = hashlib.sha256()
    with p.open('rb') as f:
        for block in iter(lambda: f.read(1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()


def load(p):
    return json.loads(p.read_text())


def lines(p):
    with p.open() as f:
        for line in f:
            yield json.loads(line)


def write(name, rows):
    with (OUT / name).open('w') as f:
        for row in rows:
            f.write(json.dumps(row, ensure_ascii=False, separators=(',', ':')) + '\n')


def main():
    handoff = load(BASE / 'parent-handoff.json')
    checked = {}
    for name, expected in handoff['sourcePins'].items():
        actual = sha(ROOT / name)
        assert actual == expected, ('parent-input-changed', name, actual)
        checked[name] = actual
    objs = load(EXPORT / 'objects.json')
    by_id = {r['id']: r for r in objs}
    assert len(objs) == len(by_id), 'duplicate-object-identity'
    tree_pins = {}
    native_pins = {}
    native_objects = {}
    snapshot_path = OUT / 'context-transforms.jsonl'
    snapshot = {}
    if snapshot_path.exists():
        previous = load(OUT / 'context-input-pins.json')
        assert sha(snapshot_path) == previous['nativeTransformSnapshotSha256']
        snapshot = {r['object']: r for r in lines(snapshot_path)}
        native_pins.update(previous['nativeHierarchySourceFiles'])
    source_files = load(EXPORT / 'source-files.json')
    original = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')

    @lru_cache(maxsize=None)
    def tree(oid):
        obj = by_id[oid]
        if 'tree' not in obj:
            # Existing export intentionally omitted transforms. Read exactly the
            # missing original transform body for component hierarchy, not a new
            # all-resource/string extraction.
            if oid in snapshot:
                assert snapshot[oid]['rawSha256'] == obj['rawSha256']
                return snapshot[oid]['tree']
            source = obj['sourceFile']
            if source not in native_objects:
                import UnityPy
                p = original / source
                actual = sha(p)
                assert actual == source_files[source]['sha256'], ('original-changed', source)
                native_pins[source] = actual
                env = UnityPy.load(str(p))
                native_objects[source] = {(o.assets_file.name, o.path_id): o for o in env.objects}
            native = native_objects[source][(obj['asset'].split('!/')[-1], obj['pathId'])]
            assert hashlib.sha256(native.get_raw_data()).hexdigest() == obj['rawSha256'], ('native-transform-changed', oid)
            assert obj['type'] in ('Transform', 'RectTransform'), ('unplanned-native-read', oid, obj['type'])
            value = native.read_typetree()
            snapshot[oid] = dict(object=oid, rawSha256=obj['rawSha256'], tree=value)
            return value
        p = EXPORT / obj['tree']
        actual = sha(p)
        assert actual == obj['treeSha256'], ('tree-changed', oid)
        tree_pins[str(p.relative_to(ROOT))] = actual
        return load(p)

    def ref(asset, ptr):
        assert ptr['m_FileID'] == 0, ('external-context-ref', asset, ptr)
        return asset + ':' + str(ptr['m_PathID']) if ptr['m_PathID'] else None

    @lru_cache(maxsize=None)
    def ancestors(goid):
        go = tree(goid)
        obj = by_id[goid]
        transforms = [ref(obj['asset'], c['component']) for c in go['m_Component']
                      if by_id[ref(obj['asset'], c['component'])]['type'] in ('Transform', 'RectTransform')]
        assert len(transforms) == 1, ('transform-count', goid)
        transform = tree(transforms[0])
        father = ref(obj['asset'], transform['m_Father'])
        parent_go = ref(obj['asset'], tree(father)['m_GameObject']) if father else None
        result = [dict(object=goid, name=go['m_Name'], activeSelf=bool(go['m_IsActive']))]
        if parent_go:
            result.extend(ancestors(parent_go))
        return result

    def context(row):
        obj = by_id[row['object']]
        t = tree(row['object'])
        assert t[row['pointer'][1:]] == row['value'], ('source-value-readback', row['id'])
        goid = ref(obj['asset'], t['m_GameObject'])
        anc = ancestors(goid)
        peers = []
        for c in tree(goid)['m_Component']:
            peer = by_id[ref(obj['asset'], c['component'])]
            if peer['type'] == 'MonoBehaviour':
                peers.append(dict(object=peer['id'], type=peer.get('class'),
                                  tree=peer.get('tree'), rawSha256=peer['rawSha256']))
        return dict(**row, hierarchy='/'.join(a['name'] for a in reversed(anc)),
                    componentEnabled=bool(t.get('m_Enabled', True)), ancestors=anc,
                    peers=peers, tree=obj['tree'], treeSha256=obj['treeSha256'],
                    rawSha256=obj['rawSha256'])

    direct = [context(r) for r in lines(BASE / 'evidence/direct-ui.jsonl')]
    animator = [context(r) for r in lines(BASE / 'evidence/text-animator-inputs.jsonl')]
    write('direct-context.jsonl', direct)
    write('animator-context.jsonl', animator)
    write('context-transforms.jsonl', (snapshot[k] for k in sorted(snapshot)))
    values = []
    for i, group in enumerate(load(BASE / 'evidence/direct-ui-value-groups.json')):
        rows = [r for r in direct if r['value'] == group['source']]
        assert {r['id'] for r in rows} == {r['id'] for r in group['occurrences']}
        values.append(dict(index=i, source=group['source'], occurrences=len(rows),
                           contexts=[dict(hierarchy=h, occurrences=n) for h, n in
                                     Counter(r['hierarchy'] for r in rows).items()]))
    (OUT / 'direct-value-context.json').write_text(json.dumps(values, ensure_ascii=False, indent=2) + '\n')
    (OUT / 'context-input-pins.json').write_text(json.dumps(dict(
        schemaVersion=1, parentHandoffSha256=sha(BASE / 'parent-handoff.json'),
        parentInputs=checked, sourceTrees=tree_pins, nativeHierarchySourceFiles=native_pins,
        nativeTransformSnapshotSha256=sha(snapshot_path), nativeTransformBodies=len(snapshot),
        counts=dict(direct=len(direct), animator=len(animator), directValues=len(values)),
        boundary='Exact export/tree identity and stored value readback; hierarchy/activity is not runtime reachability or semantic admission.'), indent=2) + '\n')
    print(json.dumps(dict(direct=len(direct), animator=len(animator), directValues=len(values), trees=len(tree_pins))))


if __name__ == '__main__':
    main()
