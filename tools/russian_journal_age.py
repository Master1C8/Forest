#!/usr/bin/env python3
"""One reviewed shared journal age cell; preserve every other BG state/object."""
import argparse
import copy
import hashlib
import importlib.metadata
import importlib.util
import json
from pathlib import Path
import shutil
import sys

PROJECT = Path('/Users/antonkrutov/Desktop/Forest')
LOCAL = Path(__file__).resolve().parent
if (LOCAL / 'journal-age/pins.json').exists():
    LOCAL = LOCAL / 'journal-age'
PACKET = LOCAL / 'inputs' if (LOCAL / 'pins.json').exists() else PROJECT / 'localization/hotfixes/ru-journal-age-20261029'
SOURCE = 'e1e8ef2907e4e326a763650dcb141291d57a6cff3342a4007f53e0cb815c316a'
IDENT = 'bgdb:resources.assets:320/sheet/l7q0WkqA70qZcKsOchc8NQ/row/bhaKdhW3r0m0C38TU%2BD8Qw/field/QtfPU7c06U6IYvVCzuqTMg'


def sha(p):
    return hashlib.sha256(Path(p).read_bytes()).hexdigest()


def module(path, name):
    spec = importlib.util.spec_from_file_location(name, path)
    obj = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(obj)
    return obj


def dependencies(lock):
    packages = {}
    for line in lock.read_text().splitlines():
        name, version = line.split('=='); dist = importlib.metadata.distribution(name)
        assert dist.version == version
        packages[name] = dict(version=version, files={str(p): sha(dist.locate_file(p)) for p in dist.files if '..' not in p.parts and Path(str(p)).suffix != '.pyc' and dist.locate_file(p).is_file()})
    return dict(python=list(sys.version_info[:3]), packages=packages)


def load_inputs():
    if (LOCAL / 'pins.json').exists():
        for name, expected in json.loads((LOCAL / 'pins.json').read_text()).items():
            assert sha(LOCAL / name) == expected, ('Age snapshot pin', name)
        assert dependencies(LOCAL / 'requirements-assets.lock') == json.loads((LOCAL / 'runtime-dependencies.json').read_text())
    target = json.loads((PACKET / 'target-final.json').read_text())
    review = json.loads((PACKET / 'independent-review.json').read_text())
    assert review['status'] == 'clean' and not review['findings']
    assert review['targetsSha256'] == sha(PACKET / 'target-final.json') and review['packetSha256'] == sha(PACKET / 'review-packet-final.json')
    assert target['id'] == IDENT and target['source'] == 'Young Adult' and target['before'] == 'Ранняя взрослость'
    assert target['targetUtf8Sha256'] == hashlib.sha256(target['target'].encode()).hexdigest()
    assert {r['actor'] for r in target['uses']} == {'Dustin', 'Mabel', 'Maverick'} and len(target['uses']) == 3
    return target


def snapshot(out):
    load_inputs(); dest = Path(out) / 'journal-age'; dest.mkdir(); (dest / 'inputs').mkdir()
    for name in ['target-final.json', 'review-packet-final.json', 'independent-review.json']:
        shutil.copy2(PACKET / name, dest / 'inputs' / name)
    sources = {'russian_journal_age.py': LOCAL / 'russian_journal_age.py', 'extract_assets.py': LOCAL / 'extract_assets.py', 'russian_journal_layout.py': LOCAL / 'russian_journal_layout.py'}
    if (LOCAL / 'pins.json').exists():
        sources.update({n: LOCAL / n for n in ['bg_helpers.py', 'bg_codec.py', 'bg_peer.py']})
    else:
        sources.update({'bg_helpers.py': LOCAL / 'russian_bio_input_case.py', 'bg_codec.py': PROJECT / 'localization/source/bgdatabase-20261027/decode_inventory.py', 'bg_peer.py': PROJECT / 'localization/source/bgdatabase-complete-values-20261027/frozen_independent_reader.py'})
    for name, path in sources.items(): shutil.copy2(path, dest / name)
    lock = LOCAL / 'requirements-assets.lock'
    shutil.copy2(lock if lock.exists() else PROJECT / 'requirements-assets.lock', dest / 'requirements-assets.lock')
    (dest / 'runtime-dependencies.json').write_text(json.dumps(dependencies(dest / 'requirements-assets.lock'), indent=2) + '\n')
    shutil.copy2(dest / 'russian_journal_age.py', Path(out) / 'russian_journal_age.py')
    (dest / 'pins.json').write_text(json.dumps({str(p.relative_to(dest)): sha(p) for p in sorted(dest.rglob('*')) if p.is_file()}, indent=2) + '\n')
    return dest


def apply(source, output, *, locale='ru', fail_after_resource=False):
    import UnityPy
    from extract_assets import read_tree, canonical
    target = load_inputs(); source, output = Path(source), Path(output)
    assert locale == 'ru' and not output.exists(), 'New Russian age output required'
    assert sha(source / 'resources.assets') == SOURCE, 'Exact pre-age resources required'
    frozen = (LOCAL / 'pins.json').exists()
    helpers = module(LOCAL / ('bg_helpers.py' if frozen else 'russian_bio_input_case.py'), 'age_helpers')
    codec = module(LOCAL / 'bg_codec.py' if frozen else PROJECT / 'localization/source/bgdatabase-20261027/decode_inventory.py', 'age_codec')
    peer = module(LOCAL / 'bg_peer.py' if frozen else PROJECT / 'localization/source/bgdatabase-complete-values-20261027/frozen_independent_reader.py', 'age_peer')
    layout = module(LOCAL / 'russian_journal_layout.py', 'age_metrics')
    env = UnityPy.load(str(source / 'resources.assets')); objects = env.file.objects
    original = {pid: obj.get_raw_data() for pid, obj in objects.items()}
    assert env.file.save() == (source / 'resources.assets').read_bytes()
    tree = read_tree(objects[320], None); data = tree['m_Script'].encode('utf-8', errors='surrogateescape')
    before, states = helpers.bg_inventory(data, codec); assert states == helpers.independent_inventory(data, peer)
    assert len(states) == 51572 and states[IDENT] == target['before'].encode()
    sheet, = [s for s in before['sheets'] if s['name'] == 'BioKeyword']; field, = [f for f in sheet['fields'] if f['name'] == 'bio_text']
    old = data[field['valuesOffset']:field['valuesOffset'] + field['valuesBytes']]
    cells, _ = codec.variable_cells(dict(field, valuesHex=old.hex()), len(sheet['rowIds']))
    index = sheet['rowIds'].index('bhaKdhW3r0m0C38TU+D8Qw'); assert cells[index] == target['before'].encode(); cells[index] = target['target'].encode()
    projected = helpers.replace_columns(data, [(field, helpers.encode_cells(old, cells))])
    after, new = helpers.bg_inventory(projected, codec); assert new == helpers.independent_inventory(projected, peer)
    assert {k for k in states if states[k] != new[k]} == {IDENT} and new[IDENT] == target['target'].encode()
    new_sheet, = [s for s in after['sheets'] if s['name'] == 'BioKeyword']; new_field, = [f for f in new_sheet['fields'] if f['name'] == 'bio_text']
    assert helpers.replace_columns(projected, [(new_field, old)]) == data
    font = bytes(x % 256 for x in objects[439].read().m_FontData)
    fit = layout.validate_targets([dict(id=IDENT, role='subtitles', target=target['target'])], font); assert fit['allFit']
    fixed = copy.deepcopy(tree); fixed['m_Script'] = projected.decode('utf-8', errors='surrogateescape'); objects[320].save_typetree(fixed)
    output.mkdir(parents=True); (output / 'resources.assets').write_bytes(env.file.save())
    back = UnityPy.load(str(output / 'resources.assets')).file
    assert original.keys() == back.objects.keys() and {pid for pid in original if original[pid] != back.objects[pid].get_raw_data()} == {320}
    assert canonical(read_tree(back.objects[320], None)) == canonical(fixed)
    saved = read_tree(back.objects[320], None)['m_Script'].encode('utf-8', errors='surrogateescape'); assert helpers.independent_inventory(saved, peer) == new
    back.objects[320].set_raw_data(original[320]); assert back.save() == (source / 'resources.assets').read_bytes()
    if fail_after_resource: raise RuntimeError('injected-after-age-resource-before-receipt')
    result = dict(status='finite-journal-age-pass', locale=locale, resource='resources.assets', sourceSha256=SOURCE, targetSha256=sha(output / 'resources.assets'), targetsSha256=sha(PACKET / 'target-final.json'), changedSharedCells=1, affectedBiographyUses=3, independentlyComparedBGStates=51572, protectedUnchangedBGStates=51571, changedResourceObjects=[320], allOtherObjectsByteExact=True, wholeBGPayloadRestored=True, wholeResourcesContainerRestored=True, actualSavedReadback=True, fit=fit, runtimeVisualAccepted=False, wholeGameAccepted=False, sourceGateAccepted=False, commitBoundary='Exclusive one resource then separate receipt; interruption retains occupied output')
    (output / 'Result.json').write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n'); return result

if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__); p.add_argument('--source', type=Path, required=True); p.add_argument('--output', type=Path, required=True); p.add_argument('--locale', required=True); a = p.parse_args(); print(json.dumps(apply(a.source, a.output, locale=a.locale)))
