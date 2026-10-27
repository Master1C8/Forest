#!/usr/bin/env python3
"""Apply the settings repair to a verified dialogue preview without rebuilding dialogue."""
import argparse
import copy
import ctypes
import hashlib
import json
import os
from pathlib import Path
import re
import shutil

import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator

from build_russian_preview import fields_changed, save_tree
from extract_assets import canonical, read_tree
from russian_settings_ui import settings_text_plan
from settings_glow import settings_value_image_plan

ROOT = Path('/Users/antonkrutov/Desktop/Forest')
DATA = 'The Forest of Love_Data'
SYSTEM = ctypes.CDLL('/usr/lib/libSystem.B.dylib', use_errno=True)


def sha(path):
    h = hashlib.sha256()
    with Path(path).open('rb') as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b''):
            h.update(chunk)
    return h.hexdigest()


def write(path, value):
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--base', required=True, type=Path)
    parser.add_argument('--output', required=True, type=Path)
    parser.add_argument('--qa-product', required=True)
    args = parser.parse_args()
    base, out = args.base.resolve(), args.output.resolve()
    assert (ROOT / 'localization/previews') in base.parents
    assert (ROOT / 'localization/previews') in out.parents and not out.exists()
    assert re.fullmatch(r'ForestRuActual[0-9]{8}_[0-9]{2,}', args.qa_product)
    report = json.loads((base / 'build.json').read_text())
    base_hash = sha(base / 'build.json')
    assert report['siteLocale'] == 'ru' and report['sampleSurface'] == 'actual-saved-dialogue'
    assert report['saveIsolation']['companyName'] == 'VNRevivalQA'
    assert len(report['files']) == 7 and report['coherentTmpFace']
    assert not report.get('settingsTranslations'), 'Already repaired: do not duplicate a repair cycle'
    for row in report['files']:
        assert sha(base / 'game' / DATA / row['path']) == row['probeSha256'], row['path']
    assert sha(base / 'game' / DATA / 'Managed/Assembly-CSharp.dll') == '46f43b212709b96ac51f2484d1564f863346fed8dc70f532860046226a020acf'
    overlay = report['overlay']['overlayAndGuardHashes']
    for path, expected in overlay.items():
        assert sha(ROOT / path) == expected, ('baseline-input-changed', path)
    # A user may have played the earlier preview. Preserve its saves in place,
    # exclude them from the new isolated artifact, and prove they stayed unchanged.
    excluded = {str(p.relative_to(base / 'game')): sha(p)
                for p in (base / 'game').rglob('tfol.*') if p.is_file()}
    assert shutil.disk_usage(ROOT).free > 512 * 1024**2
    out.mkdir()
    snapshots = out / 'recipe'
    snapshots.mkdir()
    for name in ['build_russian_settings_preview.py', 'build_russian_preview.py',
                 'russian_settings_ui.py', 'settings_glow.py', 'extract_assets.py',
                 'russian_preview_ui.py', 'russian_preview_support.py',
                 'addressables_catalog.py', 'tmp_dialogue_font.py', 'legacy_choice_font.py']:
        shutil.copy2(ROOT / 'tools' / name, snapshots / name)
    receipts = []

    def clone(source, target):
        assert not Path(source).is_symlink()
        expected = sha(source)
        cloned = SYSTEM.clonefile(os.fsencode(source), os.fsencode(target), 0) == 0
        if not cloned:
            shutil.copy2(source, target)
        assert os.stat(source).st_ino != os.stat(target).st_ino
        assert sha(target) == expected
        receipts.append({'path': str(Path(source).relative_to(base / 'game')),
                         'sha256': expected, 'copyOnWrite': cloned})
        return target

    shutil.copytree(base / 'game', out / 'game', copy_function=clone,
                    ignore=lambda path, names: [n for n in names if n.startswith('tfol.')])
    write(out / 'clone-receipts.json', receipts)
    target = out / 'game' / DATA
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(target / 'Managed'))
    incremental = {}
    for name in ['level1', 'globalgamemanagers']:
        env = UnityPy.load(str(target / name))
        objects = {o.path_id: o for o in env.objects}
        if name == 'level1':
            plan, report['settingsTranslations'] = settings_text_plan(objects, generator)
            images, report['settingsValueImageRepair'] = settings_value_image_plan(objects, generator)
            assert not (plan.keys() & images.keys())
            plan.update(images)
        else:
            plan = {}
            for obj in objects.values():
                if obj.type.name == 'PlayerSettings':
                    tree = read_tree(obj, generator)
                    assert tree['companyName'] == 'VNRevivalQA'
                    assert tree['productName'] == report['saveIsolation']['productName']
                    tree['productName'] = args.qa_product
                    plan[obj.path_id] = tree
            assert len(plan) == 1
        raw = {pid: sha_bytes(obj.get_raw_data()) for pid, obj in objects.items()}
        before = {pid: canonical(read_tree(objects[pid], generator)) for pid in plan}
        expected = {pid: canonical(tree) for pid, tree in plan.items()}
        changes = [{'pathId': pid, 'changedFieldPaths': fields_changed(before[pid], expected[pid])}
                   for pid in sorted(plan)]
        for pid, tree in plan.items():
            save_tree(objects[pid], copy.deepcopy(tree), generator)
        (target / name).write_bytes(next(iter(env.files.values())).save())
        reopened = {o.path_id: o for o in UnityPy.load(str(target / name)).objects}
        assert reopened.keys() == objects.keys()
        for pid, obj in reopened.items():
            if pid in expected:
                assert canonical(read_tree(obj, generator)) == expected[pid], ('repair-readback', name, pid)
            else:
                assert sha_bytes(obj.get_raw_data()) == raw[pid], ('unselected-object-changed', name, pid)
        incremental[name] = {'changes': changes, 'objectCount': len(objects),
                             'selectedCompleteTreeReadback': 'passed',
                             'unselectedRawBytesEquality': 'passed'}
        row = next(r for r in report['files'] if r['path'] == name)
        row['probeSha256'] = sha(target / name)
        row['incrementalSettingsChanges'] = changes
        print(name, 'exact selected/unselected readback passed', flush=True)
    (target / 'app.info').write_text('VNRevivalQA\n' + args.qa_product)
    allowed = {DATA + '/level1', DATA + '/globalgamemanagers', DATA + '/app.info'}
    final_paths = {str(p.relative_to(out / 'game')) for p in (out / 'game').rglob('*') if p.is_file()}
    assert final_paths == {row['path'] for row in receipts}
    for row in receipts:
        assert sha(base / 'game' / row['path']) == row['sha256'], ('baseline-mutated', row['path'])
        if row['path'] not in allowed:
            assert sha(out / 'game' / row['path']) == row['sha256'], ('unrelated-file-changed', row['path'])
    assert sha(base / 'build.json') == base_hash
    assert not list((out / 'game').rglob('tfol.*'))
    assert all(sha(base / 'game' / path) == expected for path, expected in excluded.items())
    report['saveIsolation']['productName'] = args.qa_product
    report['settingsRepair'] = {'base': str(base), 'baseBuildSha256': base_hash,
                                'recipeHashes': {p.name: sha(p) for p in snapshots.iterdir()},
                                'files': incremental, 'onlyChangedGameFiles': sorted(allowed),
                                'texturePixelsChanged': False,
                                'allOtherGameFilesByteIdentical': True,
                                'excludedPreservedPlayerFiles': excluded,
                                'baselineRemainsByteIdentical': True}
    report['runtime'] = report['visual'] = 'not-run-for-this-repair'
    write(out / 'build.json', report)
    print('Repaired uninstrumented preview:', out / 'game' / 'The Forest of Love.exe', flush=True)


def sha_bytes(value):
    return hashlib.sha256(value).hexdigest()


if __name__ == '__main__':
    main()
