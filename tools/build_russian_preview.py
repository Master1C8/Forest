#!/usr/bin/env python3
"""Build one source-bound actual Russian dialogue preview, preserving original installation."""
import argparse
import copy
import hashlib
import json
import re
import shutil
import struct
import unicodedata
from pathlib import Path

import UnityPy
from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator

from extract_assets import read_tree, canonical
from addressables_catalog import update_catalog
from tmp_dialogue_font import coherent_tmp_face
from settings_glow import settings_glow_plan, settings_value_image_plan
from russian_settings_ui import settings_text_plan
from russian_report_ui import report_text_plan
from russian_quest_ui import project_quest_display
from russian_menu_ui import menu_plan, snapshot as snapshot_menu, patch_gallery
from russian_item_ui import project_item_display, snapshot as snapshot_items, patch_items
from russian_inventory_descriptions import project_descriptions, snapshot as snapshot_descriptions, patch_empty_cells, load_inputs as load_description_inputs
from russian_inventory_layout import snapshot as snapshot_inventory_layout, patch_layout as patch_inventory_layout
from russian_inventory_glitch import snapshot as snapshot_glitch, plan as glitch_plan, patch as patch_glitch, load_inputs as load_glitch_inputs
from item_notification_layout import layout_plan, snapshot as snapshot_item_layout
from russian_notebook_ui import notebook_plan, snapshot as snapshot_notebook
from journal_header_ui import plan as journal_header_plan,snapshot as snapshot_journal_headers
from russian_quest_family import project_quest_family, snapshot as snapshot_quest_family, patch_quest_code
from legacy_choice_font import CHOICE_SAMPLES, choice_font_plan
from russian_native_font_roles import native_role_plan, apply_native_role
from tmp_uniform_fallback import uniform_fallback_primary
from texture_policy import validate_texture_policy
from russian_preview_ui import typography_plan, project_actor_display, load_bg_parser, exact_ui_plan
parse, variable_cells = load_bg_parser()

PROJECT = Path('/Users/antonkrutov/Desktop/Forest')
from russian_preview_support import validate_overlay, apply_overlay, clone_file, clone_ignore, CLONE_RECEIPTS, ROOT as INPUT_ROOT
MENU_ACTUAL = {
    'Play':'Играть', 'Press any key':'Нажмите любую клавишу',
    'Start New Game':'Новая игра', 'Start New Game\n':'Новая игра\n',
    'Gallery':'Галерея', 'Options':'Настройки', 'Options\n':'Настройки\n',
    'Controls':'Управление', 'Quit':'Выйти', 'Report a Bug':'Сообщить об ошибке',
    'Back':'Назад',
}
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
    parser.add_argument('--qa-product', required=True, help='Unique isolated QA product identity for this attempt')
    parser.add_argument('--sample-surface', choices=['tutorial', 'new-game', 'menu-settings', 'tutorial-choices'], default='tutorial')
    parser.add_argument('--repair-cyrillic-metrics', action='store_true')
    parser.add_argument('--coherent-legacy-face', action='store_true',
                        help='Use the bundled Liberation Sans for the entire native nameplate Font role')
    parser.add_argument('--coherent-tmp-face', action='store_true', help='Disabled in the current workflow: this option rewrites atlas textures')
    parser.add_argument('--uniform-tmp-fallback', action='store_true', help='Route all ordinary TMP glyphs through the existing dynamic fallback without changing serialized textures')
    parser.add_argument('--coherent-choice-face', action='store_true', help='Rebind only native response-label Text fonts to the already coherent embedded face')
    parser.add_argument('--repair-settings-glow', action='store_true', help='Candidate: stretch serialized Top OptionsMenu glow children to fitted parent height; actual resolved alignment and visual effect require review')
    parser.add_argument('--repair-settings-value-images', action='store_true', help='Compatibility flag: actual Russian previews always disable duplicate settings Images with complete TMP replacements')
    parser.add_argument('--inventory-display-completion', action='store_true', help='Apply the independently accepted52-unit additive description/empty-cell packet after historical item/quest stages')
    args = parser.parse_args()
    try:
        validate_texture_policy(args.coherent_tmp_face)
    except ValueError as error:
        parser.error(str(error))
    assert re.fullmatch(r'ForestRuActual[0-9]{8}_[0-9]{2,}', args.qa_product), 'Explicit isolated QA identity required'
    product = args.qa_product
    assert shutil.disk_usage(PROJECT).free >= 512 * 1024**2, 'Insufficient disk reserve before preview build'
    assert not args.repair_settings_glow or args.sample_surface == 'menu-settings'
    assert not args.coherent_tmp_face or args.coherent_legacy_face
    assert not args.uniform_tmp_fallback or args.repair_cyrillic_metrics
    assert not args.coherent_legacy_face or args.repair_cyrillic_metrics
    assert not args.coherent_choice_face or args.coherent_legacy_face
    assert args.sample_surface != 'tutorial-choices' or args.coherent_choice_face
    if args.inventory_display_completion:
        load_description_inputs()  # Fail before creating output when editorial acceptance is absent.
        load_glitch_inputs()
    out = args.output.resolve()
    assert PROJECT in out.parents and SOURCE not in out.parents
    assert not out.exists(), 'Use a new probe directory; do not overwrite prior evidence.'
    assert (SOURCE / DATA_NAME / 'Managed/Assembly-CSharp.dll').is_file()
    expected = json.loads((INPUT_ROOT / 'assets/source-v2/source-files.json').read_text())
    required = ['globalgamemanagers', 'resources.assets', 'level1', 'level5', 'level6', 'sharedassets0.assets', 'sharedassets1.assets', 'sharedassets2.assets', BUNDLE]
    for name in required:
        assert sha(SOURCE / DATA_NAME / name) == expected[name]['sha256'], name
    overlay, validation = validate_overlay()
    out.mkdir(parents=True)
    (out/'overlay-validation.json').write_text(json.dumps(validation,ensure_ascii=False,indent=2)+'\n')
    # Preserve the recipe used by this attempt, including partial failures.
    shutil.copy2(Path(__file__), out / 'build_russian_preview.py')
    shutil.copy2(PROJECT / 'tools/texture_policy.py', out / 'texture_policy.py')
    shutil.copy2(Path(__file__).parent / 'tmp_dialogue_font.py', out / 'tmp_dialogue_font.py')
    shutil.copy2(Path(__file__).parent / 'settings_glow.py', out / 'settings_glow.py')
    shutil.copy2(Path(__file__).parent / 'russian_settings_ui.py', out / 'russian_settings_ui.py')
    shutil.copy2(Path(__file__).parent / 'russian_report_ui.py', out / 'russian_report_ui.py')
    shutil.copy2(Path(__file__).parent / 'russian_actor_names.py', out / 'russian_actor_names.py')
    shutil.copy2(PROJECT / 'localization/source/actor-display-ru-20261027/plan.json', out / 'actor-display-plan.json')
    shutil.copy2(Path(__file__).parent / 'russian_quest_ui.py', out / 'russian_quest_ui.py')
    shutil.copy2(Path(__file__).parent / 'russian_menu_ui.py', out / 'russian_menu_ui.py')
    snapshot_menu(out)
    shutil.copy2(Path(__file__).parent / 'russian_item_ui.py', out / 'russian_item_ui.py')
    snapshot_items(out)
    shutil.copy2(Path(__file__).parent / 'russian_inventory_descriptions.py', out / 'russian_inventory_descriptions.py')
    shutil.copy2(Path(__file__).parent / 'russian_inventory_layout.py', out / 'russian_inventory_layout.py')
    shutil.copy2(Path(__file__).parent / 'russian_inventory_glitch.py', out / 'russian_inventory_glitch.py')
    if args.inventory_display_completion:
        snapshot_descriptions(out)
        snapshot_inventory_layout(out, SOURCE / DATA_NAME / 'Managed')
        snapshot_glitch(out)
    shutil.copy2(Path(__file__).parent/'item_notification_layout.py',out/'item_notification_layout.py')
    snapshot_item_layout(out)
    shutil.copy2(Path(__file__).parent/'russian_notebook_ui.py',out/'russian_notebook_ui.py')
    snapshot_notebook(out)
    shutil.copy2(Path(__file__).parent/'russian_quest_family.py',out/'russian_quest_family.py')
    snapshot_quest_family(out)
    snapshot_journal_headers(out)
    shutil.copy2(PROJECT / 'localization/source/tutorial-quest-ru-20261027/plan.json', out / 'tutorial-quest-plan.json')
    shutil.copy2(Path(__file__).parent / 'legacy_choice_font.py', out / 'legacy_choice_font.py')
    shutil.copy2(Path(__file__).parent / 'russian_native_font_roles.py', out / 'russian_native_font_roles.py')
    shutil.copy2(Path(__file__).parent / 'tmp_uniform_fallback.py', out / 'tmp_uniform_fallback.py')
    for helper in ['russian_preview_support.py', 'russian_preview_ui.py', 'decode_inventory.py', 'extract_assets.py', 'addressables_catalog.py']:
        candidate = Path(__file__).parent / helper
        if helper == 'decode_inventory.py' and not candidate.is_file():
            candidate = PROJECT / 'localization/source/bgdatabase-20261027/decode_inventory.py'
        shutil.copy2(candidate, out / helper)
    runtime = out / 'game'
    shutil.copytree(SOURCE, runtime, copy_function=clone_file, ignore=clone_ignore)
    (out/'clone-receipts.json').write_text(json.dumps(CLONE_RECEIPTS,indent=2)+'\n')
    assert not list(runtime.rglob('tfol.*'))
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
    if args.sample_surface == 'tutorial-choices':
        entry_ids = [159, 181]
    mark_samples = {}
    report = {'schemaVersion': 1, 'build': '0.45', 'siteLocale': 'ru',
              'sample': None, 'sampleSurface': 'actual-saved-dialogue', 'runtime': 'not-run', 'visual': 'not-run',
              'cyrillicMetricsRepair': args.repair_cyrillic_metrics,
              'coherentLegacyFace': args.coherent_legacy_face,
              'coherentTmpFace': args.coherent_tmp_face,
              'uniformTmpFallback': args.uniform_tmp_fallback,
              'inventoryDisplayCompletion': args.inventory_display_completion,
              'coherentChoiceFace': args.coherent_choice_face,
              'choiceSamples': {},
              'markSamples': mark_samples,
              'menuSamples': MENU_ACTUAL,
              'scope': 'Actual saved Russian dialogue preview; provisional source/editorial gates OPEN.',
              'overlay': validation,
              'sourceManifestSha256': sha(INPUT_ROOT / 'assets/source-v2/source-files.json'),
              'files': []}
    for name in required:
        env = UnityPy.load(str(SOURCE / DATA_NAME / name))
        objects = {o.path_id: o for o in env.objects}
        selected = {}
        glow_repairs = {}
        image_repairs = {}
        settings_repairs = {}
        report_repairs = {}
        menu_repairs = {}
        choice_repairs = {}
        ui_repairs = {}
        item_layout_repairs = {}
        notebook_repairs = {}
        coherent_spacings = {}
        glitch_repairs = {}
        if name == 'globalgamemanagers':
            selected = {o.path_id: o for o in env.objects if o.type.name == 'PlayerSettings'}
        elif name == 'resources.assets':
            selected = {1020: objects[1020], 320: objects[320]}
            if args.repair_cyrillic_metrics:
                selected[1017] = objects[1017]
        elif name=='sharedassets2.assets':
            face_env=UnityPy.load(str(target/'sharedassets0.assets'));face_obj=next(o for o in face_env.objects if o.path_id==3323)
            notebook_repairs,report['notebookTranslations']=notebook_plan(objects,generator,read_tree(face_obj,generator)['m_FaceInfo'])
            header_repairs,report['journalHeaderProjection']=journal_header_plan(objects,generator)
            assert not (notebook_repairs.keys()&header_repairs.keys());notebook_repairs.update(header_repairs)
            selected={pid:objects[pid] for pid in notebook_repairs}
            if args.inventory_display_completion:
                glitch_repairs,report['inventoryGlitchInitialProjection']=glitch_plan(objects,generator)
                selected.update({pid:objects[pid] for pid in glitch_repairs})
        elif name=='sharedassets1.assets':
            item_layout_repairs, report['itemNotificationLayout'] = layout_plan(objects,generator)
            selected={pid:objects[pid] for pid in item_layout_repairs}
        elif name in ['sharedassets0.assets', BUNDLE]:
            pid = 3336 if name == 'sharedassets0.assets' else -9011735310751668748
            selected = {pid: objects[pid]}
            if args.coherent_choice_face:
                choice_repairs, choice_evidence = choice_font_plan(objects, generator, native_fallback)
                report.setdefault('choiceFontRepair', {})[name] = choice_evidence
                selected.update({pid: objects[pid] for pid in choice_repairs})
            if args.repair_cyrillic_metrics:
                font_id = 368 if name == 'sharedassets0.assets' else 2133516458142313129
                selected[font_id] = objects[font_id]
                if args.coherent_legacy_face:
                    primary_id = 369 if name == 'sharedassets0.assets' else 525290011395715274
                    selected[primary_id] = objects[primary_id]
                if args.coherent_tmp_face or args.uniform_tmp_fallback:
                    tmp_id = 3323 if name == 'sharedassets0.assets' else -1127281652424575413
                    selected[tmp_id] = objects[tmp_id]
                if args.coherent_tmp_face:
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
            settings_repairs, report['settingsTranslations'] = settings_text_plan(objects, generator)
            report_repairs, report['reportTranslations'] = report_text_plan(objects, generator)
            image_repairs, report['settingsValueImageRepair'] = settings_value_image_plan(objects, generator)
            selected.update({pid: objects[pid] for pid in settings_repairs | report_repairs | image_repairs})
            menu_repairs, report['menuTranslations'] = menu_plan(objects, generator)
            selected.update({pid:objects[pid] for pid in menu_repairs})
        if (args.coherent_tmp_face or args.uniform_tmp_fallback) and name in ['level1', 'level5', 'level6', 'sharedassets0.assets', 'sharedassets1.assets', 'sharedassets2.assets', BUNDLE]:
            font_id = -1127281652424575413 if name == BUNDLE else 3323
            if name in ['level1', 'level5', 'level6', 'sharedassets1.assets', 'sharedassets2.assets']:
                face_env = UnityPy.load(str(SOURCE / DATA_NAME / 'sharedassets0.assets'))
                old_face = read_tree(next(o for o in face_env.objects if o.path_id == 3323), generator)['m_FaceInfo']
            else:
                old_face = read_tree(objects[font_id], generator)['m_FaceInfo']
            new_face = copy.deepcopy(tmp_fallback['m_FaceInfo'])
            new_face['m_Scale'] = struct.unpack('<f', struct.pack('<f', (77 / 176) / (59 / 86)))[0]
            if name in ['sharedassets1.assets', 'sharedassets2.assets']:
                external_ids=[i+1 for i,ref in enumerate(next(iter(objects.values())).assets_file.externals) if ref.path.replace('\\','/').split('/')[-1]=='sharedassets0.assets']
                assert len(external_ids)==1, ('shared-TMP-dependency',name)
                tmp_file_id=external_ids[0]
            else:
                tmp_file_id=5 if name=='level1' else 4 if name in ('level5','level6') else 0
            ui_repairs, ui_receipt = typography_plan(objects, generator, old_face, new_face, font_id, tmp_file_id,
                                                   minimum_spacing=0.0 if args.uniform_tmp_fallback else None)
            coherent_spacings={pid:tree['m_lineSpacing'] for pid,tree in ui_repairs.items()}
            report.setdefault('typographyRepair', {})[name] = ui_receipt
            selected.update({pid: objects[pid] for pid in ui_repairs})
        if name in ['level1', 'level5', 'level6', 'sharedassets0.assets', BUNDLE]:
            bindings, receipt = exact_ui_plan(objects, generator, name, ui_repairs)
            ui_repairs.update(bindings)
            report.setdefault('exactUiBindings', {})[name] = receipt
            selected.update({pid: objects[pid] for pid in bindings})
        native_role_repairs = {}
        if args.coherent_legacy_face:
            native_role_repairs, receipt = native_role_plan(objects, generator, name)
            if receipt:
                report.setdefault('nativeFontRoleRepair', []).extend(receipt)
                selected.update({pid: objects[pid] for pid in native_role_repairs})
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
                tree['productName'] = product
                tree['runInBackground'] = True
            elif name == 'resources.assets':
                if pid == 320:
                    assert tree['m_Name'] == 'bansheegz_database'
                    data = tree['m_Script'].encode('utf-8', errors='surrogateescape')
                    data, receipt = project_actor_display(data, parse, variable_cells)
                    data, quest_receipt = project_quest_display(data, parse, variable_cells)
                    report['questDisplayProjection'] = quest_receipt
                    data, report['itemDisplayProjection'] = project_item_display(data,parse,variable_cells)
                    data, report['questFamilyProjection'] = project_quest_family(data,parse,variable_cells)
                    if args.inventory_display_completion:
                        data, report['inventoryDescriptionProjection'] = project_descriptions(data,parse,variable_cells)
                    tree['m_Script'] = data.decode('utf-8', errors='surrogateescape')
                    report['actorDisplayProjection'] = receipt
                elif pid == 1020:
                    assert tree['m_Name'] == 'TMP Settings'
                    assert tree['m_fallbackFontAssets'] == []
                    tree['m_fallbackFontAssets'] = [{'m_FileID': 0, 'm_PathID': 1017}]
                else:
                    assert tree['m_Name'] == 'LiberationSans SDF - Fallback'
                    # The complete UI workload exhausts the single 512px dynamic
                    # atlas at the stored point size. Permit additional runtime
                    # pages without changing any serialized Texture2D or stream.
                    assert tree['m_IsMultiAtlasTexturesEnabled'] is False or tree['m_IsMultiAtlasTexturesEnabled'] == 0
                    tree['m_IsMultiAtlasTexturesEnabled'] = True
                    # Match the primary font's cap-height / point-size ratio.
                    # Keep Latin glyphs in their original font and preserve the
                    # existing glyph/atlas tables of this dynamic fallback.
                    tree['m_FaceInfo']['m_Scale'] = struct.unpack('<f', struct.pack('<f', (77 / 176) / (59 / 86)))[0]
            elif pid in notebook_repairs:
                tree=copy.deepcopy(notebook_repairs[pid])
            elif pid in item_layout_repairs:
                tree=copy.deepcopy(item_layout_repairs[pid])
            elif pid in ui_repairs:
                tree = copy.deepcopy(ui_repairs[pid])
                if pid in settings_repairs:
                    tree['m_text'] = settings_repairs[pid]['m_text']
                if pid in report_repairs:
                    tree['m_text'] = report_repairs[pid]['m_text']
                if pid in menu_repairs:
                    tree['m_text'] = menu_repairs[pid]['m_text']
                if name == 'level1' and tree.get('m_text') in report['menuSamples']:
                    tree['m_text'] = report['menuSamples'][tree['m_text']]
                if name != 'level1' and obj.type.name == 'MonoBehaviour' and tree.get('m_GameObject'):
                    if obj.parse_monobehaviour_head().m_GameObject.deref().read().m_Name == 'Subtitle Text':
                        tree['m_enableAutoSizing'] = True
                        tree['m_fontSizeMin'] = min(10.0, tree['m_fontSize'])
                        tree['m_fontSizeMax'] = tree['m_fontSize']
            elif name == 'level1':
                if pid in glow_repairs:
                    tree = copy.deepcopy(glow_repairs[pid])
                elif pid in image_repairs:
                    tree = copy.deepcopy(image_repairs[pid])
                elif pid in settings_repairs:
                    tree = copy.deepcopy(settings_repairs[pid])
                elif pid in report_repairs:
                    tree = copy.deepcopy(report_repairs[pid])
                elif pid in menu_repairs:
                    tree = copy.deepcopy(menu_repairs[pid])
                else:
                    tree['m_text'] = report['menuSamples'][tree['m_text']]
            elif pid in choice_repairs:
                tree = copy.deepcopy(choice_repairs[pid])
            elif pid in native_role_repairs:
                # Pointer repair is applied below after any other selected edits.
                pass
            elif pid in glitch_repairs:
                tree['m_text']=glitch_repairs[pid]['m_text']
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
            elif args.uniform_tmp_fallback and tree.get('m_Name') == 'MatchupPro_TFOL_SDF':
                tree, evidence = uniform_fallback_primary(tree, tmp_fallback, native_fallback)
                report.setdefault('uniformTmpFallbackRepair', {})[name] = evidence
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
                tree, receipt = apply_overlay(tree, overlay, name)
                (out / ('dialogue-readback-plan-'+ ('shared' if name=='sharedassets0.assets' else 'bundle')+'.json')).write_text(json.dumps(receipt,ensure_ascii=False,indent=2)+'\n')
            if pid in native_role_repairs:
                tree = apply_native_role(tree, native_role_repairs[pid])
            if pid in glitch_repairs:
                tree['m_text']=glitch_repairs[pid]['m_text']
            if pid in coherent_spacings:
                # Owner-specific wording/wrapping plans must not restore the old
                # bitmap spacing after the shared face-metric plan ran.
                tree['m_lineSpacing'] = coherent_spacings[pid]
            paths = fields_changed(before, canonical(tree))
            changes.append({'pathId': pid, 'changedFieldPaths': paths})
            # ObjectReader.read_typetree reads its original reader stream after
            # save_typetree; retain the authored value for independent readback.
            expected_trees[pid] = canonical(tree)
            save_tree(obj, tree, generator)
        written = target / name
        assert written.stat().st_ino != (SOURCE/DATA_NAME/name).stat().st_ino, 'Shared inode forbidden'
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
    (target / 'app.info').write_text('VNRevivalQA\n'+product)
    report['addressables'] = update_catalog(
        SOURCE / DATA_NAME / 'StreamingAssets/aa/catalog.json',
        target / 'StreamingAssets/aa/catalog.json',
        SOURCE / DATA_NAME / BUNDLE, target / BUNDLE)
    report['saveIsolation'] = {'companyName': 'VNRevivalQA', 'productName': product,
                               'originalAppIdentityUnchanged': True, 'copiedPlayerFiles': False}
    report['galleryCodeRepair'] = patch_gallery(target/'Managed',out,out/'gallery-code-readback.json')
    report['itemCodeRepair'] = patch_items(target/'Managed',out,out/'item-code-readback.json')
    report['questCodeRepair'] = patch_quest_code(target/'Managed/Assembly-CSharp.dll',out/'Assembly-CSharp.quest.dll',out/'quest-code-readback.json',out)
    shutil.copy2(out/'Assembly-CSharp.quest.dll',target/'Managed/Assembly-CSharp.dll')
    (out/'Assembly-CSharp.quest.dll').unlink()
    if args.inventory_display_completion:
        report['inventoryEmptyCellCodeRepair'] = patch_empty_cells(target/'Managed',out,out/'inventory-empty-code-readback.json')
        report['inventoryLayoutCodeRepair'] = patch_inventory_layout(target/'Managed',out,out/'inventory-layout-code-readback.json')
        report['inventoryGlitchCodeRepair'] = patch_glitch(target/'Managed',out,out/'inventory-glitch-code-readback.json')
        report['files'].append(dict(path='Managed/VNRevivalInventoryLayout.dll',probeSha256=sha(target/'Managed/VNRevivalInventoryLayout.dll'),purpose='Native inventory title/description reflow inside the original frame'))
    report['files'].append(dict(path='Managed/VNRevivalQuestLayout.dll',probeSha256=report['questCodeRepair']['layoutAssemblySha256'],purpose='Native Quest layout;existing ScrollRect'))
    report['files'].append({'path':'Managed/Assembly-CSharp.dll','sourceSha256':report['galleryCodeRepair']['sourceSha256'],
                            'probeSha256':sha(target/'Managed/Assembly-CSharp.dll'),'wholeMethodReadback':'passed'})
    (out / 'build.json').write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')


if __name__ == '__main__':
    main()
