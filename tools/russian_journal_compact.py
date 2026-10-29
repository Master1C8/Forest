#!/usr/bin/env python3
"""Finite reviewed Critter journal compression and guarded native layout repair."""
import argparse
import copy
import hashlib
import importlib.util
import json
from pathlib import Path
import shutil

PROJECT = Path('/Users/antonkrutov/Desktop/Forest')
LOCAL = Path(__file__).resolve().parent
if (LOCAL / 'journal-compact/pins.json').exists():
    LOCAL = LOCAL / 'journal-compact'
PACKET = LOCAL / 'inputs' if (LOCAL / 'pins.json').exists() else PROJECT / 'localization/hotfixes/ru-journal-compact-20261029'
RESOURCE_HASH = '51421921d9508539cca3e12ad14fb19bd19005e84070d7026bc76aad13c904b6'


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def module(path, name):
    spec = importlib.util.spec_from_file_location(name, path)
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


def load_inputs():
    if (LOCAL / 'pins.json').exists():
        for name, expected in json.loads((LOCAL / 'pins.json').read_text()).items():
            assert sha(LOCAL / name) == expected, ('Journal snapshot pin', name)
    targets = json.loads((PACKET / 'compact-targets.json').read_text())
    review = json.loads((PACKET / 'independent-wording-delta-review.json').read_text())
    assert review['status'] == 'clean' and not review['findings']
    assert review['targetsSha256'] == sha(PACKET / 'compact-targets.json')
    assert len(targets) == len({r['id'] for r in targets}) == 111
    assert sum(r['target'] != r['before'] for r in targets) == 29
    return targets


def snapshot(out):
    load_inputs()
    dest = Path(out) / 'journal-compact'
    dest.mkdir()
    (dest / 'inputs').mkdir()
    for name in ['compact-targets.json', 'independent-wording-review.json', 'independent-wording-delta-review.json',
                 'wording-review-packet.json', 'wording-delta.json', 'layout-contract.json', 'managed-helper-identities.json']:
        shutil.copy2(PACKET / name, dest / 'inputs' / name)
    if (LOCAL / 'pins.json').exists():
        for name in ['russian_journal_compact.py', 'russian_journal_layout.py', 'extract_assets.py', 'bg_helpers.py', 'bg_codec.py', 'bg_peer.py']:
            shutil.copy2(LOCAL / name, dest / name)
    else:
        files = {'russian_journal_compact.py': LOCAL / 'russian_journal_compact.py',
                 'russian_journal_layout.py': LOCAL / 'russian_journal_layout.py',
                 'extract_assets.py': LOCAL / 'extract_assets.py', 'bg_helpers.py': LOCAL / 'russian_bio_input_case.py',
                 'bg_codec.py': PROJECT / 'localization/source/bgdatabase-20261027/decode_inventory.py',
                 'bg_peer.py': PROJECT / 'localization/source/bgdatabase-complete-values-20261027/frozen_independent_reader.py'}
        for name, source in files.items():
            shutil.copy2(source, dest / name)
    shutil.copy2(dest / 'russian_journal_compact.py', Path(out) / 'russian_journal_compact.py')
    (dest / 'pins.json').write_text(json.dumps({str(p.relative_to(dest)): sha(p) for p in dest.rglob('*') if p.is_file()}, indent=2) + '\n')
    return dest


def apply(source, output, *, locale, fail_after=None):
    assert locale == 'ru'
    targets = load_inputs()
    source, output = Path(source), Path(output)
    assert not output.exists(), 'New journal output required'
    assert sha(source / 'resources.assets') == RESOURCE_HASH
    frozen = (LOCAL / 'pins.json').exists()
    helpers = module(LOCAL / ('bg_helpers.py' if frozen else 'russian_bio_input_case.py'), 'journal_bg_helpers')
    codec = module(LOCAL / 'bg_codec.py' if frozen else PROJECT / 'localization/source/bgdatabase-20261027/decode_inventory.py', 'journal_bg_codec')
    peer = module(LOCAL / 'bg_peer.py' if frozen else PROJECT / 'localization/source/bgdatabase-complete-values-20261027/frozen_independent_reader.py', 'journal_bg_peer')
    layout = module(LOCAL / 'russian_journal_layout.py', 'journal_layout')
    contract = json.loads((PACKET / 'layout-contract.json').read_text())
    variants = []
    identities = json.loads((PACKET / 'managed-helper-identities.json').read_text())
    # Normal producers may emit only the already admitted PE timestamp/MVID
    # variation in the two layout helpers; every other dependency byte is exact.
    for name, expected in contract['managedDependencies'].items():
        actual = sha(source / 'Managed' / name)
        if actual != expected:
            assert name in identities, ('Unexpected journal dependency', name)
            identity, regions = helpers.helper_identity((source / 'Managed' / name).read_bytes())
            assert identity == identities[name]['nonvolatileSha256'] and regions == identities[name]['regions']
            variants.append(dict(name=name, before=expected, actual=actual, nonvolatileSha256=identity))
            contract['managedDependencies'][name] = actual
    import UnityPy
    from extract_assets import read_tree, canonical
    env = UnityPy.load(str(source / 'resources.assets'))
    objects = env.file.objects
    original = {pid: obj.get_raw_data() for pid, obj in objects.items()}
    tree = read_tree(objects[320], None)
    data = tree['m_Script'].encode('utf-8', errors='surrogateescape')
    before, states = helpers.bg_inventory(data, codec)
    assert states == helpers.independent_inventory(data, peer)
    byid = {r['id']: r for r in targets}
    for r in targets:
        assert states[r['id']] == r['before'].encode(), ('Journal prior wording', r['id'])
    sheet, = [s for s in before['sheets'] if s['name'] == 'BioKeyword']
    field, = [f for f in sheet['fields'] if f['name'] == 'bio_text']
    old = data[field['valuesOffset']:field['valuesOffset'] + field['valuesBytes']]
    cells, _ = codec.variable_cells(dict(field, valuesHex=old.hex()), len(sheet['rowIds']))
    import urllib.parse
    for index, rid in enumerate(sheet['rowIds']):
        ident = 'bgdb:resources.assets:320/sheet/' + urllib.parse.quote(sheet['id'], safe='') + '/row/' + urllib.parse.quote(rid, safe='') + '/field/' + urllib.parse.quote(field['id'], safe='')
        assert ident in byid
        cells[index] = byid[ident]['target'].encode()
    projected = helpers.replace_columns(data, [(field, helpers.encode_cells(old, cells))])
    after, new = helpers.bg_inventory(projected, codec)
    assert new == helpers.independent_inventory(projected, peer)
    changed = {key for key in states if states[key] != new[key]}
    assert changed == {r['id'] for r in targets if r['before'] != r['target']}
    assert len(changed) == 29
    for r in targets:
        assert new[r['id']] == r['target'].encode()
    restored_sheet, = [s for s in after['sheets'] if s['name'] == 'BioKeyword']
    restored_field, = [f for f in restored_sheet['fields'] if f['name'] == 'bio_text']
    assert helpers.replace_columns(projected, [(restored_field, old)]) == data
    after_tree = copy.deepcopy(tree)
    after_tree['m_Script'] = projected.decode('utf-8', errors='surrogateescape')
    objects[320].save_typetree(after_tree)
    resource = env.file.save()
    back = UnityPy.load(resource).file
    actual_raw = {pid: obj.get_raw_data() for pid, obj in back.objects.items()}
    assert original.keys() == actual_raw.keys()
    assert {pid for pid in original if original[pid] != actual_raw[pid]} == {320}
    assert canonical(read_tree(back.objects[320], None)) == canonical(after_tree)
    back.objects[320].set_raw_data(original[320])
    assert back.save() == (source / 'resources.assets').read_bytes()
    output.mkdir(parents=True)
    (output / 'resources.assets').write_bytes(resource)
    if fail_after == 'resources':
        raise RuntimeError('injected-between-journal-resource-writes')
    layout_receipt = layout.apply(source / 'sharedassets2.assets', output / 'sharedassets2.assets', contract)
    receipt = dict(status='finite-journal-compact-pass', locale=locale, changedKeywordCells=29,
                   comparedBGStates=51572, independentlyDecodedBGStates=51572, protectedBGStates=51543,
                   preservedUnchangedBioTargets=82, wholeBGPayloadRestored=True,
                   wholeResourcesContainerRestored=True, allOtherResourceObjectsExact=True,
                   layout=layout_receipt, admittedHelperVariants=variants,
                   files={name: sha(output / name) for name in ['resources.assets', 'sharedassets2.assets']},
                   targetsSha256=sha(PACKET / 'compact-targets.json'),
                   runtimeVisualAccepted=False, wholeGameAccepted=False,
                   commitBoundary='Two exclusive resources then receipt. Incomplete occupied output rejects retry; no multi-file transaction.')
    (output / 'Result.json').write_text(json.dumps(receipt, indent=2) + '\n')
    return receipt


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--locale', required=True)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    print(json.dumps(apply(args.source, args.output, locale=args.locale)))
