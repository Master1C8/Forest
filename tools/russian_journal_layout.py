"""Frozen, resource-only Russian CritterLog typography adapter.

No runtime hooks, wording generation, installation or saves access. The contract
contains exact before trees. Apply only to a fresh output, then independently
read back every object and reverse the complete serialized container.
"""
import argparse
import copy
import hashlib
import io
import json
from pathlib import Path

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
CONTRACT = ROOT / 'localization/hotfixes/ru-journal-compact-20261029/layout-contract.json'


def digest(data):
    return hashlib.sha256(data).hexdigest()


def sha(path):
    return digest(Path(path).read_bytes())


def need(value, reason):
    if not value:
        raise ValueError(reason)


def emit(path, value):
    Path(path).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def load_contract():
    local = Path(__file__).with_name('journal-layout-contract.json')
    if local.exists():
        pins = json.loads(local.with_name('journal-layout-pins.json').read_text())
        for name, expected in pins.items():
            need(sha(local.with_name(name)) == expected, 'journal-frozen-input:' + name)
    return json.loads((local if local.exists() else CONTRACT).read_text())


def differences(a, b, pointer=''):
    if isinstance(a, dict) and isinstance(b, dict):
        need(a.keys() == b.keys(), 'tree-keys:' + pointer)
        return [p for k in a for p in differences(a[k], b[k], pointer + '/' + str(k))]
    if isinstance(a, list) and isinstance(b, list):
        need(len(a) == len(b), 'tree-list:' + pointer)
        return [p for i in range(len(a)) for p in differences(a[i], b[i], pointer + '/' + str(i))]
    return [] if a == b else [pointer]


def replace_pointer(tree, pointer, value):
    parts = pointer.strip('/').split('/')
    node = tree
    for part in parts[:-1]:
        node = node[part]
    node[parts[-1]] = value


def plan(objects, generator, contract=None):
    """Return exact trees for the owning builder, without saving objects."""
    from extract_assets import read_tree, canonical
    contract = contract or load_contract()
    for row in contract['guards']:
        obj = objects[row['pathId']]
        need(digest(obj.get_raw_data()) == row['rawSha256'], 'journal-guard:' + str(row['pathId']))
    result = {}
    for row in contract['changes']:
        pid = row['pathId']
        before = read_tree(objects[pid], generator)
        need(canonical(before) == row['beforeTree'], 'journal-before-tree:' + str(pid))
        after = copy.deepcopy(before)
        for pointer, value in row['replace'].items():
            replace_pointer(after, pointer, value)
        need(set(differences(before, after)) == set(row['replace']), 'journal-pointer-allowlist:' + str(pid))
        result[pid] = after
    need(len(result) == 27, 'journal-exact27-objects')
    return result


def snapshot(folder):
    """Freeze the complete plan and helper dependency for a future builder."""
    import shutil
    folder = Path(folder)
    folder.mkdir(parents=True, exist_ok=True)
    files = {'russian_journal_layout.py': Path(__file__),
             'extract_assets.py': Path(__file__).with_name('extract_assets.py'),
             'journal-layout-contract.json': CONTRACT}
    for name, path in files.items():
        need(not (folder / name).exists(), 'journal-snapshot-occupied:' + name)
        shutil.copyfile(path, folder / name)
    emit(folder / 'journal-layout-pins.json', {name: sha(folder / name) for name in files})


def font_metrics(data):
    from fontTools.ttLib import TTFont
    font = TTFont(io.BytesIO(data))
    return font


def measure_text(data, text, size):
    """Return nominal and positive-pair-kern bounds; no rendered-fit claim."""
    font = font_metrics(data)
    cmap, widths, upem = font.getBestCmap(), font['hmtx'].metrics, font['head'].unitsPerEm
    missing = sorted({c for c in text if c not in '\r\n' and ord(c) not in cmap})
    need(not missing, 'journal-font-missing:' + repr(missing))
    lines = text.split('\n')
    positive = {}
    if 'kern' in font:
        for table in font['kern'].kernTables:
            for pair, value in table.kernTable.items():
                positive[pair] = max(positive.get(pair, 0), value)
    if 'GPOS' in font:
        for lookup in font['GPOS'].table.LookupList.Lookup:
            if lookup.LookupType != 2:
                continue
            for table in lookup.SubTable:
                need(table.Format == 1, 'journal-unsupported-GPOS-pair-format')
                for left, pairs in zip(table.Coverage.glyphs, table.PairSet):
                    for pair in pairs.PairValueRecord:
                        value = sum(getattr(v, 'XAdvance', 0) or 0 for v in [pair.Value1, pair.Value2] if v)
                        key = (left, pair.SecondGlyph)
                        positive[key] = max(positive.get(key, 0), value)
    advance, bounds = [], []
    for line in lines:
        glyphs = [cmap[ord(c)] for c in line if c != '\r']
        base = sum(widths[g][0] for g in glyphs)
        extra = sum(positive.get(pair, 0) for pair in zip(glyphs, glyphs[1:]))
        advance.append(base * size / upem)
        bounds.append((base + extra) * size / upem)
    return dict(lineAdvances=advance, positivePairBounds=bounds,
                maxAdvance=max(bounds, default=0), lines=len(lines),
                hheaLineHeight=(font['hhea'].ascent-font['hhea'].descent+font['hhea'].lineGap)*size/upem)


def validate_targets(rows, font_data):
    """Accept caller-provided authored text only; all failures stay explicit."""
    rows = list(rows)
    need(bool(rows), 'journal-empty-target-input')
    need(len({r['id'] for r in rows}) == len(rows), 'journal-duplicate-target-id')
    limits = {'cell': (10, 75, 1), 'fullName': (14, 184, 1),
              'resident': (12, 74, 1), 'subtitles': (11, 184, 3), 'section': (13, 58, 1)}
    result = []
    for row in rows:
        role, text = row['role'], row['target']
        size, width, lines = limits[role]
        need('<' not in text and '>' not in text and '\r' not in text, 'journal-plain-target:' + row['id'])
        metrics = measure_text(font_data, text, size)
        ok = metrics['lines'] <= lines and metrics['maxAdvance'] <= width
        result.append(dict(id=row['id'], role=role, fontSize=size, limit=width,
                           metrics=metrics, fits=ok))
    return dict(rows=result, allFit=all(r['fits'] for r in result),
                boundary='Static TTF advances only; no Unity rasterization/readability acceptance.')


def apply(source, output, contract=None):
    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    from extract_assets import read_tree, canonical
    source, output = Path(source).resolve(), Path(output).resolve()
    contract = contract or load_contract()
    need(source.name == 'sharedassets2.assets', 'journal-source-name')
    need(sha(source) == contract['sourcePins']['sharedassets2.assets'], 'journal-source-hash')
    need(source != output and not output.exists(), 'journal-fresh-output-required')
    need(sha(source.parent / 'Managed/Assembly-CSharp.dll') == contract['sourcePins']['Managed/Assembly-CSharp.dll'], 'journal-managed-hash')
    need(sha(source.parent / 'sharedassets0.assets') == contract['sourcePins']['sharedassets0.assets'], 'journal-font-container-hash')
    managed = source.parent / 'Managed'
    need({p.name: sha(p) for p in managed.glob('*.dll')} == contract['managedDependencies'], 'journal-managed-dependencies')
    env = UnityPy.load(str(source))
    objects = {o.path_id: o for o in env.objects}
    original = {pid: o.get_raw_data() for pid, o in objects.items()}
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(source.parent / 'Managed'))
    changes = plan(objects, generator, contract)
    for pid, tree in changes.items():
        obj = objects[pid]
        nodes = None
        if obj.type.name == 'MonoBehaviour':
            script = obj.parse_monobehaviour_head().m_Script.deref().read()
            fullname = (script.m_Namespace + '.' if script.m_Namespace else '') + script.m_ClassName
            nodes = generator.cache.get(('forest-header-aligned:' + script.m_AssemblyName, fullname))
        obj.save_typetree(tree, nodes=nodes)
    data = env.file.save()
    # Read saved bytes independently before any output becomes available.
    loaded = UnityPy.load(data)
    loaded.path = str(source.parent)
    after = {o.path_id: o for o in loaded.objects}
    need(objects.keys() == after.keys(), 'journal-object-id-set')
    changed = {pid for pid in objects if original[pid] != after[pid].get_raw_data()}
    need(changed == set(changes), 'journal-exact-changed-object-set')
    for pid in objects:
        if pid in changes:
            need(canonical(read_tree(after[pid], generator)) == canonical(changes[pid]), 'journal-saved-tree:' + str(pid))
        else:
            need(after[pid].get_raw_data() == original[pid], 'journal-unselected-bytes:' + str(pid))
    for pid in changed:
        after[pid].set_raw_data(original[pid])
    need(loaded.file.save() == source.read_bytes(), 'journal-whole-container-reversal')
    output.parent.mkdir(parents=True, exist_ok=True)
    with output.open('xb') as stream:
        stream.write(data)
    need(sha(output) == digest(data), 'journal-saved-file-readback')
    need(sha(source) == contract['sourcePins']['sharedassets2.assets'], 'journal-source-unchanged')
    return dict(sourceSha256=sha(source), outputSha256=sha(output), changedObjects=sorted(changed),
                totalObjects=len(objects), exactChangedPointerAllowlist=True,
                allUnselectedObjectsByteExact=True, savedTreeReadback=True,
                wholeContainerReversal=True, originalSourceUnchanged=True,
                runtime='not-run', readability='needs-review', sourceGateAccepted=False,
                ordinaryTranslationEntryAllowed=False, wholeGameAccepted=False,
                commitBoundary='One exclusive resource output after complete in-memory checks; receipt is a separate write, not a multi-file transaction.')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--receipt', type=Path, required=True)
    args = parser.parse_args()
    need(not args.receipt.exists(), 'journal-fresh-receipt-required')
    receipt = apply(args.source, args.output)
    emit(args.receipt, receipt)
    print(json.dumps(receipt))


if __name__ == '__main__':
    main()
