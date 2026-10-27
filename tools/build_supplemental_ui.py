"""Build/check the shared screenshot-omission addendum without touching live lanes.

This creates translation inputs, not game packages or editorial acceptance receipts.
Run with --check to compare the complete generated file set and exact contents.
"""
import argparse
import collections
import hashlib
import json
import re
import sys
from pathlib import Path
from urllib.parse import quote

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'localization/supplemental-ui/20261027'
sys.path.insert(0, str(ROOT / 'localization/source/bgdatabase-20261027'))
from decode_inventory import parse, variable_cells
from menu_supplement import PHRASES as MENU_PHRASES, source_addendum, render
import item_supplement as items
import notebook_supplement as notebook
import quest_supplement as quests
import journal_header_ui as headers


def sha(data):
    return hashlib.sha256(data).hexdigest()


def encoded(value):
    return (json.dumps(value, ensure_ascii=False, indent=2) + '\n').encode()


def selector(sheet, row, field):
    return 'bgdb:resources.assets:320/sheet/{}/row/{}/field/{}'.format(
        *[quote(x, safe='') for x in (sheet, row, field)])


def validate_locale_scope(scope, catalog):
    locales = scope['targetLocales']
    assert len(locales) == scope['targetCount'] == 30, 'target-locale-count'
    assert len(set(locales)) == 30, 'duplicate-target-locale'
    assert scope['sourceLocale'] == 'en' and 'en' not in locales, 'source-is-not-target'
    assert sha(catalog) == scope['catalog']['sha256'], 'canonical-locale-catalog-pin'
    match = re.search(r'export const SITE_LOCALE_CODES\s*=\s*\[(.*?)\]\s*as const;', catalog.decode(), re.S)
    assert match, 'canonical-locale-catalog-syntax'
    codes = re.findall(r'"([^"]+)"', match.group(1))
    assert len(codes) == len(set(codes)) == 31 and codes[0] == 'en', 'canonical-locale-catalog-shape'
    assert locales == [code for code in codes if code != 'en'], 'canonical-target-locale-coverage'
    assert set(locales) == set(scope['approvedGlossaries']['locales']), 'approved-glossary-locale-coverage'
    return locales


def products():
    scope = json.loads((OUT / 'locale-scope.json').read_text())
    locales = validate_locale_scope(scope, Path(scope['catalog']['path']).read_bytes())
    inputs = [
        'localization/previews/ru-20261027-settings-fix/build.json',
        'localization/source/bug-report-ui-20261027/inventory.json',
        'localization/source/actor-display-ru-20261027/plan.json',
        'localization/source/tutorial-quest-ru-20261027/plan.json',
        'localization/source/bgdatabase-20261027/actor-identity/decoded.json',
        'localization/source/bgdatabase-20261027/quest-progress/decoded.json',
        'localization/source/bgdatabase-20261027/quest-progress/readback/counter-dependency.json',
        'assets/source-v2/text-assets/90744c19ec-resources.assets-320.bin',
    ]
    pins = {p: sha((ROOT / p).read_bytes()) for p in inputs}
    settings, report, actor, quest = [json.loads((ROOT / p).read_text()) for p in inputs[:4]]
    assert pins[inputs[0]] == 'b947226767d4595cd3c50102f438c1ef2fa22d6ed9135ba42417b1aec6401783'
    assert pins[inputs[1]] == 'dd7e3382ef8c2e0a3ef59106d7ed3c550a2e14e3fff34cdd0f202acf12cc48f3'
    assert pins[inputs[2]] == 'a09e06f91f8d95b0e4a03f4ee4da3d56d0ad9758daed8469f48d7611ea3c55cb'
    assert pins[inputs[3]] == '9a94aa6a554bed1a7e6f9b30196004da63b724ece5651da6e8e2e54a11b65e73'
    assert pins[inputs[7]] == '41834cda2f3ea6f010234f3ca2332e31b95b990ab38a8940b0d92f000477fda9'
    for evidence in [actor['sourceReadback'], quest['sourceReadback']]:
        assert pins[evidence['path']] == evidence['sha256']
    assert pins[quest['excludedDependency']['source']] == quest['excludedDependency']['sha256']
    phrase_sources = [
        ('settings.music', 'Music'), ('settings.effects', 'Effects'),
        ('settings.fullscreen', 'Fullscreen:'), ('settings.stretch', 'Stretch:'),
        ('settings.scale', 'Scale:'), ('settings.on', 'On'), ('settings.off', 'Off'),
        ('report.system-info-label', 'System Info:'), ('report.edit-text', 'Edit Text'),
        ('report.send', 'Send\nReport'),
        ('report.instructions', "Select ''Edit Text'' to let us know what happened!\n\nThe report tool will gather the other information we need.\nYou can adjust the detail level of system information sent."),
        ('report.keyboard', 'You can type your report with a physical keyboard.\nOr use our virtual keyboard. It supports touch and gamepad controls!'),
        ('report.success', 'The bug report was sent successfully!\nThank you for your feedback.'),
        ('report.empty', 'The bug report text is empty!\nPlease add some text and try again.'),
        ('report.confirm-send', 'Send the bug report?'),
        ('report.confirm-cancel', 'Cancel the bug report?\nThe text you entered will be erased.'),
        ('report.unsupported', "The bug report cannot be sent on this platform.\nPlease share your feedback from a Desktop build\nor on the game's website tfol.info"),
        ('report.yes', 'Yes'), ('report.no', 'No'), ('report.ok', 'Ok'),
        ('report.data-heading', 'The following information will be sent:'),
        ('report.application-info', 'Application Info'), ('report.system-info', 'System Info'),
        ('report.back', 'Back'),
    ] + [('tutorial.' + u['field'] if u['sheet'] == 'Quest' else 'tutorial.' + u['identity'].rsplit('_', 1)[1], u['source']) for u in quest['units']]
    assert len(phrase_sources) == 30 and len(dict(phrase_sources)) == 30
    source_keys = {source: key for key, source in phrase_sources}
    units, protected = [], []
    for group in settings['settingsTranslations']:
        for pid in group['textIds']:
            units.append(dict(id=f'level1:{pid}/m_text', family='settings', source=group['source'],
                              phrase=source_keys[group['source']], context=group['hierarchy']))
    for row in report['rows']:
        ident = f"{row['id']}/m_text"
        if row['source'] in source_keys:
            units.append(dict(id=ident, family='report', source=row['source'],
                              phrase=source_keys[row['source']], context=row['hierarchy']))
        else:
            assert row['source'] in ('+', '++', '+++', '++++', '\u200b')
            protected.append(dict(id=ident, expected=row['source'], reason='control marker, not prose'))
    for row in actor['rows']:
        for field, source in row['source'].items():
            ident = selector(actor['sheetId'], row['rowId'], actor['fieldIds'][field])
            if source is None:
                protected.append(dict(id=ident, expected=None, reason='absent display override'))
            else:
                units.append(dict(id=ident, family='actor', source=source,
                                  field=field, glossaryId=row['glossaryId'], context=row['identity']))
    for unit in quest['units']:
        units.append(dict(id=selector(unit['sheetId'], unit['rowId'], unit['fieldId']),
                          family='tutorial', source=unit['source'], phrase=source_keys[unit['source']],
                          context=unit['identity'], glossaryId='tfol-119' if unit['field']=='bio_title' else None))
    assert len(units) == 212 and len({u['id'] for u in units}) == 212
    assert collections.Counter(u['family'] for u in units) == {'settings':54, 'report':106, 'actor':46, 'tutorial':6}
    # Keep all technical Actor blobs and every other Quest display cell exact.
    data = (ROOT / inputs[7]).read_bytes()
    env = parse(data)
    for sheet in env['sheets']:
        for field in sheet['fields']:
            blob = data[field['valuesOffset']:field['valuesOffset'] + field['valuesBytes']]
            if sheet['name'] == 'Actor' and field['name'] not in actor['fieldIds']:
                protected.append(dict(sheetId=sheet['id'], fieldId=field['id'], expectedBlobHex=blob.hex(),
                                      reason='technical Actor column; 39 states'))
            if (sheet['name'], field['name']) in [('Quest','bio_title'), ('Quest','bio_description'), ('QuestProgressLogText','log_text')]:
                cells, _ = variable_cells(dict(field, valuesHex=blob.hex()), len(sheet['rowIds']))
                for row_id, cell in zip(sheet['rowIds'], cells):
                    ident = selector(sheet['id'], row_id, field['id'])
                    if ident not in {u['id'] for u in units}:
                        protected.append(dict(id=ident, expectedValueHex=cell.hex() if cell is not None else None,
                                              reason='outside bounded tutorial repair; includes lost-photo comparison'))
    menu_units, menu_pins = source_addendum(units)
    units += menu_units
    pins.update(menu_pins)
    phrase_sources += MENU_PHRASES
    assert len(dict(phrase_sources)) == len(phrase_sources) == 51
    item_units,item_protected,item_pins=items.source_addendum(units)
    units+=item_units; protected.append(dict(sheetId='0BzeuogxqUOTnLWmTpBxVw',columns=item_protected,reason='All 16 unselected InventoryItem columns remain byte-exact'))
    pins.update(item_pins); phrase_sources+=items.PHRASES
    notebook_units,notebook_protected,notebook_pins=notebook.source_addendum(units)
    units+=notebook_units;protected+=notebook_protected;pins.update(notebook_pins)
    _,notebook_words=notebook.inputs()
    quest_units,quest_protected,quest_pins=quests.source_addendum(units)
    # All prior selected tutorial cells remain retained;new complete family supersedes old outside-scope cell guards.
    selected_quest_ids={r['id'] for r in quests.inventory()['sourceStates'] if r['source'] is not None}
    protected=[p for p in protected if p.get('id') not in selected_quest_ids]
    units+=quest_units;protected+=quest_protected;pins.update(quest_pins)
    assert len(units)==911 and len({u['id'] for u in units})==911
    header_units,header_protected,header_pins=headers.addendum(units);units+=header_units;protected+=header_protected;pins.update(header_pins)
    assert len(units)==935 and len({u['id'] for u in units})==935
    catalog = dict(schemaVersion=2, sourceLanguage='en', scope='All screenshot omissions through 2026-10-27 20:22 plus complete item notification,five-page notebook tutorial and complete Quest display family repairs; additive to the frozen dialogue inventory',
                   sourcePins=pins, phraseOrder=[dict(key=k, source=s) for k,s in phrase_sources]+quests.inventory()['phrases'], units=units,
                   preserveExactly=protected, processBinding=quest['processBinding'],
                   applicationContract={
                       'textLayers':'Apply every ID, including all six TMP face/glow copies. Retain existing layout bindings; validate target-specific fitting.',
                       'duplicateImage':{'id':'level1:9708/m_Enabled','before':1,'after':0,'reason':'duplicate Off sprite already replaced by six TMP layers; disable the Image, do not redraw its texture'},
                       'glitchNotification':'Branch1 uses the glitch prefab without invoking the Configure methods. Apply all six pinned serialized found-label values and preserve the six question marks and line break.',
                       'itemNotificationLayout':'Both normal and glitch controllers share sharedassets1 prefabs1284/1279. Wrap all12 TMP fields and constrain2 outer rects to210 units inside320-unit right-anchored groups with8-unit right padding, move their2 icon rects to reserve space, and stretch10 nested face/glow rects to matching widths; preserve fonts, sizes and stroke offsets. Validate each locale; see item-notifications-20261027/layout.json.',
                       'retainedWebsite':'TFoL.info is the exact website/domain identifier in six main-menu TMP fields, retained verbatim in every locale; website-consumer.il binds Application.OpenURL.',
                       'notebook':'All156 TMP fields of the five-page GossipTutorialRedux15851 are selected. Preserve paired native action labels and all Image/Sprite artwork, including the English control identifiers cited by the translated instructions. Adapt title emphasis to the first target grapheme plus the complete approved Notebook term; preserve size22/36 syntax and exact CR/LF sequences. Use the existing complete-title variant on all five pages instead of English manually separated title segments (ten guarded GameObject active states). Apply common face-metric spacing compensation to all selected TMP layers;30 multiline face/glow child rects inherit the preferred height of their parent. No texture redraw.',
                       'items':'Patch the 96 pinned title/notification_phrase cells and eight display operands; preserve descriptions, IDs, enum/save keys, item ownership and all other columns. See item-notifications-20261027/inventory.json.',
                       'actor':'Patch only nameplate_name/full_name. Compare all unselected columns, null cells and full payload restoration as in russian_actor_names.py.',
                       'tutorial':'Six original tutorial cells retained;all remaining Quest display cells are selected by quest-family.',
                       'quests':'Patch177 nonempty DB cells plus28 compiled display operands;retain18 null states,15 technical columns,original branches,identities,formats and ordering. Use exact selected log identity for the three lost-photo counter slots,including completion shift. Preserve greetings,storm and32 regional masks x2 statuses. Validate preferred-height wrapping/scroll layout and actual HUD per locale;Russian evidence is not other-locale acceptance.',
                       'fonts':'Resolve actual native/TMP roles per locale before packaging; preserve fictional-language font mapping. Russian font acceptance does not cover other scripts.',
                       'textures':'Notify the owner of texture-only omissions; do not produce or replace textures.',
                       'journalHeaders':'All24 actual Quest Log/Critter Log TMP layers/variants use approved terms. Preserve16/20 base sizes and22/30 first-grapheme emphasis;adapt source two-cap formatting to complete target term. Their legacy Images are disabled,not visible texture exceptions. L/R navigation icons are source sprites386/381 and remain unchanged. Active/Completed are painted sprites544/593.',
                       'reportOnlyArtwork':'The Forest of Love title and the separate Gallery heading are reported-only for all30 locales; see localization/source/menu-remaining-ui-20261027/graphics-findings.json and its exact Gallery Image/Sprite binding.',
                       'dynamicReportData':'These are form captions, not proof of localization of generated diagnostic payloads.',
                       'galleryCode':'Apply only the six pinned display ldstr operands in four original gallery-label methods. Preserve all branches, counter operands, unlock logic, placeholders and tags. Verify whole-method readback and restoration.',
                       'settingsCaptionLayout':'Use preferred-width ContentSizeFitter and right pivot on both pinned caption containers; keep left origins of state values fixed, retain the six-layer renderer and validate actual glyph separation. See menu-inventory.json captionLayout.',
                       'liveLanes':'Do not modify running briefs, immutable manifests, frozen 12246-ID dialogue inputs or prior dialogue-only receipts.'})
    files = {'source-catalog.json': encoded(catalog)}
    wording = json.loads((OUT / 'wording.json').read_text())
    authored_pins = {'wording.json': sha((OUT / 'wording.json').read_bytes()), 'item-wording.json': sha((OUT/'item-wording.json').read_bytes()), 'notebook-wording.json': sha((OUT/'notebook-wording.json').read_bytes())}
    for path in sorted((OUT / 'wording').glob('*.json')):
        locale = path.stem
        assert locale not in wording, ('duplicate-authored-locale', locale)
        wording[locale] = json.loads(path.read_text())
        authored_pins[str(path.relative_to(OUT))] = sha(path.read_bytes())
    assert set(wording) == set(locales), ('authored-locale-coverage', sorted(set(locales)-set(wording)))
    locale_receipts = {}
    for locale in locales:
        glossary_path = ROOT / f'localization/glossary/{locale}.json'
        assert sha(glossary_path.read_bytes()) == scope['approvedGlossaries']['locales'][locale]['sha256']
        glossary = json.loads(glossary_path.read_text())
        authored = wording[locale]
        quest_words=quests.words(locale)
        authored_pins['quest-wording/'+locale+'.json']=sha((OUT/'quest-wording'/(locale+'.json')).read_bytes())
        assert not (set(authored['phrases']) & set(items.KEYS))
        authored['phrases'].update(items.wording()[locale])
        assert set(authored['phrases']) == {k for k,s in phrase_sources}
        phrases = authored['phrases']
        assert phrases['tutorial.bio_title'] == glossary['tfol-119']['term']
        records = []
        for unit in units:
            if unit['family']=='journal-header':
                target=headers.render(unit,glossary,locale)
            elif unit['family'] in ('quest-family','quest-code'):
                target=glossary[unit['glossaryId']]['term'] if 'glossaryId' in unit else quest_words[unit['phrase']]
            elif unit['family']=='notebook':
                target=notebook.render(unit,notebook_words[locale],glossary)
            elif unit['family'] in ('item','item-code','item-prefab'):
                target=items.render(unit,phrases,glossary)
            elif unit['family'] != 'actor':
                target = render(unit, phrases)
            elif unit['field'] == 'full_name':
                target = glossary[unit['glossaryId']]['term']
            else:
                target = authored['shortNames'][unit['source']]
            assert isinstance(target, str) and target and (target == target.strip(' \t\r') or unit['family']=='notebook' and target.endswith(('\r','\n')) or unit.get('lineEnding')=='space' and target.endswith(' ') and target[:-1]==target[:-1].strip(' \t\r'))
            assert target.count('\n') == unit['source'].count('\n'), (locale,unit['id'],'line breaks')
            assert target.count('tfol.info') == unit['source'].count('tfol.info')
            assert sorted(re.findall(r'\{[0-9]+\}', target)) == sorted(re.findall(r'\{[0-9]+\}', unit['source']))
            if unit['family']=='notebook':notebook.validate(unit,target,notebook_words[locale],glossary)
            elif unit['family']=='journal-header':headers.validate(unit,target,glossary,locale)
            else:assert re.findall(r'</?size(?:=[0-9]+)?>', target) == re.findall(r'</?size(?:=[0-9]+)?>', unit['source'])
            if unit.get('phrase')=='item.plank':
                assert target.endswith('<.<') and target.count('<.<')==unit['source'].count('<.<'), 'item-emoticon-preservation'
            if unit.get('formatArgs'):
                assert re.findall(r'[0-9]+', target) == re.findall(r'[0-9]+', unit['source'])
            record = dict(id=unit['id'], source=unit['source'], target=target)
            if target == unit['source']:
                native_no = locale in ('es', 'es-419', 'it') and unit.get('phrase') == 'report.no'
                glossary_unchanged=unit['family'] in ('item','quest-family') and 'glossaryId' in unit and target==glossary[unit['glossaryId']]['term']
                plank_unchanged=locale=='nl' and unit.get('phrase')=='item.plank'
                notebook_same=unit['family']=='notebook' and (unit['phrase']=='caption' or unit['phrase']=='title-first')
                assert unit['family']=='actor' or native_no or glossary_unchanged or plank_unchanged or notebook_same, (locale, unit['id'], target)
                record['unchangedReason'] = ('Approved glossary title' if unit['family']=='quest-family' and glossary_unchanged else 'Native tutorial cognate or matching approved title grapheme' if notebook_same else 'approved glossary term' if glossary_unchanged else 'Dutch word Plank and original emoticon' if plank_unchanged else 'approved proper name' if unit['family']=='actor' else
                    'Spanish negative response is also No' if locale in ('es','es-419') else
                    'Italian negative response is also No')
            records.append(record)
        assert [r['id'] for r in records] == [u['id'] for u in units]
        filename = locale + '.jsonl'
        files[filename] = ''.join(json.dumps(r,ensure_ascii=False) + '\n' for r in records).encode()
        prior=(OUT/'history/thirty-locales-before-items'/filename).read_bytes()
        prior_item=(OUT/'history/items-before-glitch'/filename).read_bytes()
        assert len(prior_item.splitlines())==550 and files[filename].startswith(prior_item),('prior-item-104-drift',locale)
        assert len(prior.splitlines())==446 and files[filename].startswith(prior), ('prior-446-record-drift',locale)
        old_notebook=(OUT/'history/before-notebook'/filename).read_bytes()
        assert len(old_notebook.splitlines())==556 and files[filename].startswith(old_notebook),('prior-556-drift',locale)
        before_quest=(OUT/'history/before-quests'/filename).read_bytes()
        assert len(before_quest.splitlines())==712 and files[filename].startswith(before_quest),('prior-712-drift',locale)
        assert records[712:911]==quests.new_records(locale),('quest-record-render-drift',locale)
        old_headers=(OUT/'history/before-journal-headers'/filename).read_bytes();assert len(old_headers.splitlines())==911 and files[filename].startswith(old_headers)
        assert records[911:]==headers.records(locale)
        locale_receipts[locale] = dict(file=filename, sha256=sha(files[filename]), units=len(records),
                                       glossaryPath=str(glossary_path.relative_to(ROOT)), glossarySha256=sha(glossary_path.read_bytes()),
                                       direction='rtl' if locale in ('ar','fa','he') else 'ltr',
                                       shapingAndBidi='needs-review' if locale in ('ar','fa','he','hi','th') else 'not-run',
                                       independentEditorial='pending', resourceApplication='not-run', runtime='not-run', visual='not-run', releaseAccepted=False)
    files['manifest.json'] = encoded(dict(schemaVersion=1, sourceCatalogSha256=sha(files['source-catalog.json']),
                                         authoredInputs=authored_pins,
                                         localeScopeSha256=sha((OUT/'locale-scope.json').read_bytes()),
                                         targetCount=len(locales),
                                         generatorSha256=sha(Path(__file__).read_bytes()),
                                         status='author-edited supplemental translation inputs; deterministic validation passed',
                                         locales=locale_receipts, completeGameAccepted=False,
                                         preservedDialogueInventory='12246 source IDs; unchanged scope and existing receipts',
                                         atomicity='All outputs prepared and validated in memory before writing. Per-file replacement only; interruption requires a complete --check before consuming any output.'))
    return files


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    files = products()
    expected_targets = {name for name in files if name.endswith('.jsonl')}
    existing_targets = {path.name for path in OUT.glob('*.jsonl')}
    assert not existing_targets - expected_targets, 'unknown-target-output'
    if args.check:
        assert existing_targets == expected_targets, 'target-output-file-coverage'
    for name, contents in files.items():
        path = OUT / name
        if args.check:
            assert path.read_bytes() == contents, ('generated-file-drift', name)
        else:
            temporary = path.with_suffix(path.suffix + '.pending')
            temporary.write_bytes(contents)
            temporary.replace(path)
    manifest = json.loads(files['manifest.json'])
    counts = [row['units'] for row in manifest['locales'].values()]
    assert len(set(counts)) == 1
    print(json.dumps(dict(status='checked' if args.check else 'written', locales=manifest['targetCount'], unitsPerLocale=counts[0], totalTargets=sum(counts), files=len(files))))


if __name__ == '__main__':
    main()
