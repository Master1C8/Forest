"""Reuse candidate17's unchanged files and independently bind the combined text delta.

The full rebuild is the input proof. This static-only candidate retains the base
QA identity; its runtime clone must receive a new disposable identity.
"""
import argparse
import copy
import ctypes
import hashlib
import json
import os
from pathlib import Path
import shutil
import struct
import sys

import UnityPy
import russian_chapter_gallery_case as case
from russian_actor_names import replace_columns
from russian_ui935 import load_inputs as ui_inputs

ROOT = case.ROOT
BASE = ROOT / 'localization/previews/ru-20261028-texture-preserving-17'
DATA = 'The Forest of Love_Data'
CHANGED = {'resources.assets', 'sharedassets0.assets', 'sharedassets2.assets', 'Managed/Assembly-CSharp.dll'}


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(path):
    return json.loads(path.read_text())


def stage(applied, out):
    plan = case.load_inputs(locale='ru')
    old_ui, new_ui, ui_accept = ui_inputs(locale='ru')
    source = case.jsonl(plan.packet['source.jsonl'])
    targets = {r['id']: r for r in plan.rows}
    catalog = {r['id']: r for r in read(ROOT / 'localization/supplemental-ui/20261027/source-catalog.json')['units']}
    ui_changed = [key for key in old_ui if old_ui[key]['target'] != new_ui[key]['target']]
    assert len(ui_changed) == 32
    applied, out = applied.resolve(), out.resolve()
    assert applied.parent == out.parent == ROOT / 'localization/previews' and not out.exists()
    full, base = read(applied / 'build.json'), read(BASE / 'build.json')
    assert full['chapterGalleryCase'] and full['inventoryDisplayCompletion']
    files = lambda d: {r['path']: r['probeSha256'] for r in d['files']}
    assert files(full).keys() == files(base).keys()
    for folder, report in [(applied, full), (BASE, base)]:
        assert all(sha(folder / 'game' / DATA / name) == digest for name, digest in files(report).items())
        assert not list((folder / 'game').rglob('tfol.*'))
    assert read(BASE / 'texture-preservation.json')['status'] == 'pass'
    assert sha(BASE / 'build.json') == read(ROOT / 'localization/visual-qa/ru-inventory-20261028-09/final-acceptance.json')['evidencePins'][str((BASE / 'build.json').relative_to(ROOT))]
    # All expensive validation below reads immutable copies of the completed full
    # rebuild and accepted base. No application function generates the readback.
    sys.path.insert(0, str(applied))
    import decode_inventory as bg
    from extract_assets import read_tree
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(BASE / 'game' / DATA / 'Managed'))
    native = copy.deepcopy(full['chapterGalleryInitialProjection'])
    for name in ['sharedassets0.assets', 'sharedassets2.assets']:
        a = {o.path_id: o for o in UnityPy.load(str(BASE / 'game' / DATA / name)).objects}
        b = {o.path_id: o for o in UnityPy.load(str(applied / 'game' / DATA / name)).objects}
        assert a.keys() == b.keys()
        selections = {}
        for row in source:
            if row['id'].startswith(name + ':'):
                selections[int(row['physicalSelector']['object'].split(':')[1])] = (row['source'], targets[row['id']]['target'], row['id'])
        extra = []
        for key in ui_changed:
            prefix, selector = key.split(':', 1)
            if prefix not in (name, name.removesuffix('.assets')):
                continue
            assert selector.endswith('/m_text')
            pid = int(selector.split('/')[0]); assert pid not in selections
            selections[pid] = (old_ui[key]['target'], new_ui[key]['target'], key); extra.append(key)
        assert all(a[pid].get_raw_data() == b[pid].get_raw_data() for pid in a if pid not in selections)
        for pid, (before, after, key) in selections.items():
            left, right = a[pid].get_raw_data(), b[pid].get_raw_data()
            needle = struct.pack('<i', len(before.encode())) + before.encode()
            assert left.count(needle) == 1, ('ambiguous-text-span', key)
            start = left.index(needle); end = start + len(needle); end += (-end) % 4
            replacement = struct.pack('<i', len(after.encode())) + after.encode()
            replacement += b'\0' * (-(start + len(replacement)) % 4)
            assert right == left[:start] + replacement + left[end:], ('nontext-raw-bytes', key)
            assert read_tree(b[pid], generator)['m_text'] == after
        receipt = next(r for r in native if r['asset'] == name)
        receipt.update(postSaveReadback=True, allOtherObjectBytesPreserved=True,
                       preservationReference='Immediate prior accepted UI935 projection over candidate17; all other combined-delta objects and every selected non-text byte checked against17.',
                       additionalAcceptedUi935Ids=extra, combinedChangedObjects=len(selections))
    def payload(folder):
        obj = next(o for o in UnityPy.load(str(folder / 'game' / DATA / 'resources.assets')).objects if o.path_id == 320)
        return read_tree(obj, generator)['m_Script'].encode('utf-8', errors='surrogateescape')
    before, after = payload(BASE), payload(applied)
    def columns(data):
        return {(s['id'], f['id']): (s, f, data[f['valuesOffset']:f['valuesOffset'] + f['valuesBytes']]) for s in bg.parse(data)['sheets'] for f in s['fields']}
    old_columns, new_columns = columns(before), columns(after)
    selected = {(r['sheetId'], r['fieldId'], r['rowId']): (r['source'], targets[r['id']]['target']) for r in source if r['id'].startswith('bgdb:')}
    for key in ui_changed:
        if key.startswith('bgdb:'):
            r = catalog[key]; selected[r['sheetId'], r['fieldId'], r['rowId']] = (old_ui[key]['target'], new_ui[key]['target'])
    assert len(selected) == 115 and old_columns.keys() == new_columns.keys()
    touched = {(s, f) for s, f, r in selected}; assert len(touched) == 5
    restore = []
    for key, (old_sheet, old_field, blob) in old_columns.items():
        sheet, field, new_blob = new_columns[key]
        assert old_sheet['rowIds'] == sheet['rowIds'] and old_field['type'] == field['type']
        if key not in touched:
            assert blob == new_blob
            continue
        old_cells, _ = bg.variable_cells(dict(old_field, valuesHex=blob.hex()), len(sheet['rowIds']))
        new_cells, _ = bg.variable_cells(dict(field, valuesHex=new_blob.hex()), len(sheet['rowIds']))
        expected = list(old_cells)
        for index, row in enumerate(sheet['rowIds']):
            identity = (key[0], key[1], row)
            if identity in selected:
                prior, target = selected[identity]
                assert old_cells[index] == prior.encode()
                expected[index] = target.encode()
        assert list(new_cells) == expected
        restore.append((field, blob))
    assert replace_columns(after, restore) == before
    managed = full['chapterGalleryCodeProjection']
    assert managed['sourceSha256'] == case.MANAGED_BEFORE and managed['targetSha256'] == sha(applied / 'game' / DATA / 'Managed/Assembly-CSharp.dll')
    out.mkdir()
    lib = ctypes.CDLL('/usr/lib/libSystem.B.dylib', use_errno=True)
    def clone(src, dest):
        if lib.clonefile(os.fsencode(src), os.fsencode(dest), 0):
            shutil.copyfile(src, dest)
        assert os.stat(src).st_ino != os.stat(dest).st_ino
        return dest
    shutil.copytree(BASE / 'game', out / 'game', copy_function=clone)
    for name in CHANGED:
        shutil.copyfile(applied / 'game' / DATA / name, out / 'game' / DATA / name)
        assert sha(out / 'game' / DATA / name) == files(full)[name], ('copied-artifact-readback', name)
    result = copy.deepcopy(base)
    for key in ['chapterGalleryCase', 'chapterGalleryInitialProjection', 'chapterGalleryDatabaseProjection', 'chapterGalleryCodeProjection']:
        result[key] = full[key]
    for row in result['files']:
        row['probeSha256'] = sha(out / 'game' / DATA / row['path'])
    result['ui935AcceptanceSha256'] = sha(ROOT / 'localization/supplemental-ui/20261029-existing935/ru.acceptance.json')
    result['staticTextIncrement'] = dict(base=str(BASE), fullRebuild=str(applied), fullBuildSha256=sha(applied / 'build.json'),
                                       changedFiles=sorted(CHANGED), nativeTextChanges=48, bgTextChanges=115,
                                       baseQaIdentityRetainedForStaticOnly=True, runtimeCloneRequiresNewIdentity=True)
    (out / 'build.json').write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    proof = dict(status='complete-static-readback', caseId=case.CASE, locale='ru', buildSha256=sha(out / 'build.json'),
                 targetSha256=json.loads(plan.acceptance_bytes)['targetSha256'], sourcePins=case.SOURCE_PINS,
                 baselineBuildSha256=sha(BASE / 'build.json'), files=files(result), bg=full['chapterGalleryDatabaseProjection'],
                 native=native, managed=managed, additionalAcceptedUi935Ids=ui_changed,
                 combinedDelta=dict(bgCells=115, columns=5, allOther284ColumnsExact=True, wholePayloadReversal=True, nativeMTextFields=48),
                 runtime='not-run', wholeGameAccepted=False)
    (out / 'chapter-gallery-readback.json').write_text(json.dumps(proof, indent=2) + '\n')
    shutil.copyfile(Path(__file__), out / Path(__file__).name)
    assert all(sha(BASE / 'game' / DATA / name) == digest for name, digest in files(base).items())
    print(json.dumps(dict(status=proof['status'], candidate=str(out), nativeFields=48, bgCells=115, runtime='not-run')))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--applied', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    stage(args.applied, args.output)
