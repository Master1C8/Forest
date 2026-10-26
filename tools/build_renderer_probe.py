#!/usr/bin/env python3
"""Build a disposable Cyrillic renderer probe without writing to the installation."""
import argparse
import copy
import hashlib
import json
import shutil
import struct
import unicodedata
from pathlib import Path

import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator

from extract_assets import read_tree, canonical
from addressables_catalog import update_catalog
from tmp_dialogue_font import coherent_tmp_face
from settings_glow import settings_glow_plan

PROJECT = Path(__file__).resolve().parents[1]
SOURCE = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')
DATA_NAME = 'The Forest of Love_Data'
BUNDLE = 'StreamingAssets/aa/StandaloneWindows64/defaultlocalgroup_assets_all_298c5a4d1d1846b1a8d2c7d5da3f319c.bundle'
SAMPLE = 'Ёж, съешь ещё этих мягких булок. Йй Щщ Ъъ Ыы Ьь Ээ Юю Яя; 123 — Latin!'
MENU_SAMPLES = {'Fullscreen:': 'Ёж Йй 123:', 'Scale:': 'Е\u0308 и\u0306 12:', 'Stretch:': 'Ёж Latin!:'}


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def save_tree(obj, tree, generator):
    nodes = None
    if obj.type.name == 'MonoBehaviour':
        script = obj.parse_monobehaviour_head().m_Script.deref().read()
        fullname = (script.m_Namespace + '.' if script.m_Namespace else '') + script.m_ClassName
        nodes = generator.cache.get(('forest-header-aligned:' + script.m_AssemblyName, fullname))
    obj.save_typetree(tree, nodes=nodes)


def fields_changed(before, after, pointer=''):
    if isinstance(before, dict) and isinstance(after, dict):
        assert before.keys() == after.keys(), pointer
        return [x for k in before for x in fields_changed(before[k], after[k], pointer + '/' + str(k))]
    if isinstance(before, list) and isinstance(after, list) and len(before) == len(after):
        return [x for i in range(len(before)) for x in fields_changed(before[i], after[i], pointer + '/' + str(i))]
    return [] if before == after else [pointer]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    parser.add_argument('--sample-surface', choices=['tutorial', 'new-game', 'menu-settings'], default='tutorial')
    parser.add_argument('--repair-cyrillic-metrics', action='store_true')
    parser.add_argument('--coherent-legacy-face', action='store_true',
                        help='Use the bundled Liberation Sans for the entire native nameplate Font role')
    parser.add_argument('--coherent-tmp-face', action='store_true', help='Use one bundled outline face and canonical mark-pair positioning for the shared dialogue TMP role')
    parser.add_argument('--repair-settings-glow', action='store_true', help='Candidate: stretch serialized Top OptionsMenu glow children to fitted parent height; actual resolved alignment and visual effect require review')
    args = parser.parse_args()
    assert not args.repair_settings_glow or args.sample_surface == 'menu-settings'
    assert not args.coherent_tmp_face or args.coherent_legacy_face
    assert not args.coherent_legacy_face or args.repair_cyrillic_metrics
    out = args.output.resolve()
    assert PROJECT in out.parents and SOURCE not in out.parents
    assert not out.exists(), 'Use a new probe directory; do not overwrite prior evidence.'
    assert (SOURCE / DATA_NAME / 'Managed/Assembly-CSharp.dll').is_file()
    expected = json.loads((PROJECT / 'assets/source-v2/source-files.json').read_text())
    required = ['globalgamemanagers', 'resources.assets', 'level1', 'sharedassets0.assets', BUNDLE]
    for name in required:
        assert sha(SOURCE / DATA_NAME / name) == expected[name]['sha256'], name
    out.mkdir(parents=True)
    # Preserve the recipe used by this attempt, including partial failures.
    shutil.copy2(Path(__file__), out / 'build_renderer_probe.py')
    shutil.copy2(PROJECT / 'tools/tmp_dialogue_font.py', out / 'tmp_dialogue_font.py')
    shutil.copy2(PROJECT / 'tools/settings_glow.py', out / 'settings_glow.py')
    runtime = out / 'game'
    shutil.copytree(SOURCE, runtime, ignore=shutil.ignore_patterns('tfol.*', '*.log', '*.dmp'))
    target = runtime / DATA_NAME
    generator = TypeTreeGenerator('2020.3.24f1')
    generator.load_local_dll_folder(str(SOURCE / DATA_NAME / 'Managed'))
    native_fallback = None
    if args.repair_cyrillic_metrics:
        fonts_env = UnityPy.load(str(SOURCE / DATA_NAME / 'resources.assets'))
        native_fallback = next(o for o in fonts_env.objects if o.path_id == 439).read_typetree()
        assert native_fallback['m_Name'] == 'LiberationSans'
        tmp_fallback = read_tree(next(o for o in fonts_env.objects if o.path_id == 1017), generator)
    entry_ids = [197, 199, 200, 202] if args.sample_surface == 'new-game' else [153, 154, 155, 156]
    mark_samples = {str(entry_ids[0]): SAMPLE + '\nЕ\u0308 и\u0306'}
    if args.coherent_legacy_face:
        mark_samples[str(entry_ids[1])] = SAMPLE + '\n' + unicodedata.normalize('NFC', 'Е\u0308 и\u0306')
    report = {'schemaVersion': 1, 'build': '0.45', 'siteLocale': 'ru',
              'sample': SAMPLE, 'sampleSurface': args.sample_surface, 'runtime': 'not-run', 'visual': 'not-run',
              'cyrillicMetricsRepair': args.repair_cyrillic_metrics,
              'coherentLegacyFace': args.coherent_legacy_face,
              'coherentTmpFace': args.coherent_tmp_face,
              'markSamples': mark_samples,
              'menuSamples': MENU_SAMPLES if args.sample_surface == 'menu-settings' else {'Fullscreen:': 'Ёж 123:'},
              'scope': 'Synthetic script feasibility only; no translated game corpus.',
              'sourceManifestSha256': sha(PROJECT / 'assets/source-v2/source-files.json'),
              'files': []}
    for name in required:
        env = UnityPy.load(str(SOURCE / DATA_NAME / name))
        objects = {o.path_id: o for o in env.objects}
        selected = {}
        glow_repairs = {}
        if name == 'globalgamemanagers':
            selected = {o.path_id: o for o in env.objects if o.type.name == 'PlayerSettings'}
        elif name == 'resources.assets':
            selected = {1020: objects[1020]}
            if args.repair_cyrillic_metrics:
                selected[1017] = objects[1017]
        elif name in ['sharedassets0.assets', BUNDLE]:
            pid = 3336 if name == 'sharedassets0.assets' else -9011735310751668748
            selected = {pid: objects[pid]}
            if args.repair_cyrillic_metrics:
                font_id = 368 if name == 'sharedassets0.assets' else 2133516458142313129
                selected[font_id] = objects[font_id]
                if args.coherent_legacy_face:
                    primary_id = 369 if name == 'sharedassets0.assets' else 525290011395715274
                    selected[primary_id] = objects[primary_id]
                if args.coherent_tmp_face:
                    tmp_id = 3323 if name == 'sharedassets0.assets' else -1127281652424575413
                    selected[tmp_id] = objects[tmp_id]
                    atlas_ref = read_tree(objects[tmp_id], generator)['m_AtlasTextures'][0]
                    assert atlas_ref['m_FileID'] == 0
                    selected[atlas_ref['m_PathID']] = objects[atlas_ref['m_PathID']]
                subtitle_count = 0
                for obj in env.objects:
                    if obj.type.name != 'MonoBehaviour':
                        continue
                    head = obj.parse_monobehaviour_head()
                    if head.m_Script.deref().read().m_ClassName == 'TextMeshProUGUI' and head.m_GameObject.deref().read().m_Name == 'Subtitle Text':
                        selected[obj.path_id] = obj
                        subtitle_count += 1
                assert subtitle_count >= 1, (name, subtitle_count)
        elif name == 'level1':
            # Actual menu-label fields; all other scene fields remain unchanged.
            for obj in env.objects:
                if obj.type.name != 'MonoBehaviour':
                    continue
                script = obj.parse_monobehaviour_head().m_Script.deref().read()
                if script.m_ClassName != 'TextMeshProUGUI':
                    continue
                tree = read_tree(obj, generator)
                if tree.get('m_text') in report['menuSamples']:
                    selected[obj.path_id] = obj
            if args.repair_settings_glow:
                glow_repairs, report['settingsGlowRepair'] = settings_glow_plan(objects, generator)
                selected.update({pid: objects[pid] for pid in glow_repairs})
        assert selected, name
        original = {pid: canonical(read_tree(obj, generator)) for pid, obj in selected.items()}
        raw_hashes = {pid: hashlib.sha256(obj.get_raw_data()).hexdigest() for pid, obj in objects.items()}
        for pid, obj in selected.items():
            save_tree(obj, read_tree(obj, generator), generator)
        asset_file = next(iter(env.files.values()))
        noop_bytes = asset_file.save(packer='lz4') if name == BUNDLE else asset_file.save()
        noop_path = out / ('noop-' + Path(name).name)
        noop_path.write_bytes(noop_bytes)
        noop_env = UnityPy.load(str(noop_path))
        noop_objects = {o.path_id: o for o in noop_env.objects}
        assert set(noop_objects) == set(objects)
        for pid, obj in noop_objects.items():
            if pid in selected:
                assert canonical(read_tree(obj, generator)) == original[pid], (name, pid, 'no-op tree')
            else:
                assert hashlib.sha256(obj.get_raw_data()).hexdigest() == raw_hashes[pid], (name, pid, 'unselected no-op bytes')
        del noop_env, noop_objects
        changes = []
        expected_trees = {}
        for pid, obj in selected.items():
            tree = read_tree(obj, generator)
            before = canonical(tree)
            if name == 'globalgamemanagers':
                tree['companyName'] = 'VNRevivalQA'
                tree['productName'] = 'ForestRuRendererProbe'
                tree['runInBackground'] = True
            elif name == 'resources.assets':
                if pid == 1020:
                    assert tree['m_Name'] == 'TMP Settings'
                    assert tree['m_fallbackFontAssets'] == []
                    tree['m_fallbackFontAssets'] = [{'m_FileID': 0, 'm_PathID': 1017}]
                else:
                    assert tree['m_Name'] == 'LiberationSans SDF - Fallback'
                    # Match the primary font's cap-height / point-size ratio.
                    # Keep Latin glyphs in their original font and preserve the
                    # existing glyph/atlas tables of this dynamic fallback.
                    tree['m_FaceInfo']['m_Scale'] = struct.unpack('<f', struct.pack('<f', (77 / 176) / (59 / 86)))[0]
            elif name == 'level1':
                if pid in glow_repairs:
                    tree = copy.deepcopy(glow_repairs[pid])
                else:
                    tree['m_text'] = report['menuSamples'][tree['m_text']]
            elif obj.type.name == 'Font':
                assert tree['m_Name'] in (['MatchupPro 1', 'MatchupPro_TFOL'] if args.coherent_legacy_face else ['MatchupPro 1'])
                # The default repair extends the existing fallback only. The
                # coherent-face option also replaces the primary's face data,
                # preserving identity and material/texture/object references.
                for key in ['m_FontData', 'm_FontNames', 'm_LineSpacing', 'm_FontSize',
                            'm_Ascent', 'm_Descent', 'm_KerningValues', 'm_FontRenderingMode']:
                    tree[key] = copy.deepcopy(native_fallback[key])
                if args.coherent_legacy_face:
                    # Both primary/fallback use the same embedded face, not OS font
                    # substitution. Keep object identity, links and material/texture
                    # references. Copy every other renderer metric/table together.
                    preserved = {'m_Name', 'm_DefaultMaterial', 'm_Texture', 'm_FallbackFonts'}
                    for key in tree.keys() - preserved:
                        tree[key] = copy.deepcopy(native_fallback[key])
            elif args.coherent_tmp_face and obj.type.name == 'Texture2D':
                assert tree['m_TextureFormat'] == 1 and tree['m_MipCount'] == 1
                assert tree['m_Width'] == 1024 and tree['m_Height'] == 1024
                tree['m_IsReadable'] = True
                tree['m_TextureSettings']['m_FilterMode'] = 1
                tree['image data'] = bytes(tree['m_Width'] * tree['m_Height'])
                tree['m_StreamData'] = {'offset': 0, 'size': 0, 'path': ''}
            elif args.coherent_tmp_face and tree.get('m_Name') == 'MatchupPro_TFOL_SDF':
                native_font_id = 369 if name == 'sharedassets0.assets' else 525290011395715274
                tree, pair_evidence = coherent_tmp_face(tree, tmp_fallback, native_font_id, native_fallback['m_FontData'])
                report['tmpMarkPairs'] = pair_evidence
            elif 'm_text' in tree:
                assert args.repair_cyrillic_metrics
                tree['m_enableAutoSizing'] = True
                tree['m_fontSizeMin'] = min(10.0, tree['m_fontSize'])
                tree['m_fontSizeMax'] = tree['m_fontSize']
            else:
                title = 'act1/newGame' if args.sample_surface == 'new-game' else 'act1/tutorialQuest/01_introFromBunny'
                conversations = [c for c in tree['conversations'] if any(f['title'] == 'Title' and f['value'] == title for f in c['fields'])]
                assert len(conversations) == 1
                changed = 0
                for entry in conversations[0]['dialogueEntries']:
                    for field in entry['fields']:
                        if field['title'] == 'Dialogue Text' and field['value'] and entry['id'] in entry_ids:
                            prefix = field['value'].split(']', 1)[0] + ']' if field['value'].startswith('[pic=') else ''
                            suffix = '\nЕ\u0308 и\u0306' if entry['id'] == entry_ids[0] else '  '
                            if args.coherent_legacy_face and entry['id'] == entry_ids[1]:
                                suffix = '\n' + unicodedata.normalize('NFC', 'Е\u0308 и\u0306')
                                assert unicodedata.normalize('NFD', suffix) == '\nЕ\u0308 и\u0306'
                            field['value'] = prefix + SAMPLE + suffix
                            changed += 1
                assert changed == 4, changed
            paths = fields_changed(before, canonical(tree))
            changes.append({'pathId': pid, 'changedFieldPaths': paths})
            # ObjectReader.read_typetree reads its original reader stream after
            # save_typetree; retain the authored value for independent readback.
            expected_trees[pid] = canonical(tree)
            save_tree(obj, tree, generator)
        written = target / name
        written.write_bytes(asset_file.save(packer='lz4') if name == BUNDLE else asset_file.save())
        rebuilt = UnityPy.load(str(written))
        rebuilt_objects = {o.path_id: o for o in rebuilt.objects}
        assert set(rebuilt_objects) == set(objects)
        for pid, obj in rebuilt_objects.items():
            if pid not in selected:
                assert hashlib.sha256(obj.get_raw_data()).hexdigest() == raw_hashes[pid], (name, pid, 'unselected changed')
            else:
                wanted = expected_trees[pid]
                got = canonical(read_tree(obj, generator))
                assert wanted == got, (name, pid, 'probe readback')
        report['files'].append({'path': name, 'sourceSha256': sha(SOURCE / DATA_NAME / name),
                                'probeSha256': sha(written), 'noOpSha256': sha(noop_path),
                                'objectCount': len(objects), 'noOpTreeEquality': 'passed',
                                'unselectedRawBytesEquality': 'passed', 'probeReadback': 'passed',
                                'changes': changes})
        (out / 'build.json').write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
        print(name, 'no-op and exact readback passed', flush=True)
    (target / 'app.info').write_text('VNRevivalQA\nForestRuRendererProbe')
    report['addressables'] = update_catalog(
        SOURCE / DATA_NAME / 'StreamingAssets/aa/catalog.json',
        target / 'StreamingAssets/aa/catalog.json',
        SOURCE / DATA_NAME / BUNDLE, target / BUNDLE)
    report['saveIsolation'] = {'companyName': 'VNRevivalQA', 'productName': 'ForestRuRendererProbe',
                               'originalAppIdentityUnchanged': True, 'copiedPlayerFiles': False}
    (out / 'build.json').write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')


if __name__ == '__main__':
    main()
