#!/usr/bin/env python3
"""Finite phase147 metadata join. No font parser, resource writer or model calls."""
import argparse
import copy
import hashlib
import json
from pathlib import Path
import unicodedata

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
OLD = Path('localization/fonts/font-role-reconciliation-20261027')
READBACK = OLD / 'reconciled-final'
NAME = Path('localization/fonts/nameplate-original-binding-20261027/recovered')
SOURCE = Path('localization/source/shared-source-completion-20261028/admission-v1')
DIALOGUE = Path('localization/font-checks/dialogue-20261027-02.json')
INTERFACE = Path('localization/font-checks/supplemental-30-20261028.json')
CJK = Path('localization/font-checks/cjk-candidates-20261027-01.json')
PROVENANCE = Path('localization/fonts/noto-cjk/provenance.json')


def require(ok, reason):
    if not ok:
        raise ValueError(reason)


def sha(data):
    return hashlib.sha256(data).hexdigest()


def encode(data):
    return (json.dumps(data, ensure_ascii=False, indent=2) + '\n').encode()


def value_hash(value, newline=False):
    # Admission hashes compact JSON without LF;118 component references add LF.
    return sha((json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(',', ':')) + ('\n' if newline else '')).encode())


def load(path):
    return json.loads((ROOT / path).read_text())


def lines(path):
    return [json.loads(s) for s in (ROOT / path).read_text().splitlines()]


def unique(rows, key, reason):
    result = {r[key]: r for r in rows}
    require(len(result) == len(rows), reason)
    return result


def fingerprint(path):
    data = (ROOT / path).read_bytes()
    return {'bytes': len(data), 'sha256': sha(data)}


def verify_pin(path, pin):
    require(not any(part.endswith('-assets') for part in Path(path).parts), 'live-target-read-prohibited')
    require(not Path(path).is_absolute(), 'project-relative-input-required')
    actual = fingerprint(path)
    require(actual['sha256'] == (pin if isinstance(pin, str) else pin['sha256']), 'input-fingerprint:' + str(path))
    if isinstance(pin, dict) and 'bytes' in pin:
        require(actual['bytes'] == pin['bytes'], 'input-length:' + str(path))


def chars(text):
    return sorted({ord(c) for c in text if not unicodedata.category(c).startswith('C')})


def requirements(texts):
    forms = {}
    for form in ['raw', 'NFC', 'NFD']:
        values = texts if form == 'raw' else [unicodedata.normalize(form, t) for t in texts]
        forms[form] = sorted({c for t in values for c in chars(t)})
    return {'forms': forms, 'rawNfcNfdCodepoints': sorted(set().union(*map(set, forms.values())))}


def checked_subset(required, universe, result, kind):
    """Reuse a missing-set only inside its proved universe, never as a full cmap."""
    require(set(required) <= set(universe), 'outside-reused-requirement-universe')
    if not required:
        return {'kind': kind, 'status': 'no-bound-target-characters', 'missingCount': None,
                'boundary': 'Empty projection is not a coverage pass'}
    if result.get('missingCount') is None:
        return {'kind': kind, 'status': 'unknown', 'missingCount': None}
    missing = sorted(set(required) & {ord(c) for c in result['missing']})
    return {'kind': kind, 'status': 'table-membership-only' if kind == 'serialized-bitmap-indices' else 'static-subset-only',
            'missingCodepoints': missing, 'missingCount': len(missing),
            'allSubsetCodepointsPresent': not missing, 'runtimeAccepted': False}


def verify_dependencies():
    pins = load(HERE.relative_to(ROOT) / 'input-pins.json')
    for path, pin in pins.items():
        verify_pin(path, pin)
    # Reuse the original readbacks only while their complete original pins agree.
    inherited = load(READBACK / 'input-fingerprints.json')
    inherited.update(load(NAME / 'input-fingerprints.json'))
    # The documentation now includes the accepted119 binding and30-locale guard.
    # It is not an original object/font/check dependency. Preserve both versions,
    # verify its current phase baseline, and reuse every substantive prior pin.
    inherited.pop('localization/fonts/README.md')
    original_install = '/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data/sharedassets0.assets'
    install_pin = inherited.pop(original_install)
    require(install_pin['sha256'] == load(NAME / 'verification.json')['originalFileSha256'], 'prior-install-receipt-binding')
    require((HERE / 'previous-fonts-README.md').is_file(), 'missing-current-font-guide-baseline')
    for path, pin in inherited.items():
        verify_pin(path, pin)
    for directory in [READBACK, NAME]:
        receipt = load(directory / 'verification.json')
        for name, pin in receipt['outputs'].items():
            verify_pin(directory / name, pin)
    continuation = load(SOURCE / 'continuation-validation.json')
    verify_pin(SOURCE / 'manifest.json', continuation['currentManifestSha256'])
    for name, pin in continuation['outputPins'].items():
        path = Path(name) if str(name).startswith('localization/') else SOURCE / name
        verify_pin(path, pin)
    for name, pin in load(PROVENANCE)['files'].items():
        verify_pin(PROVENANCE.parent / name, pin)
    # Final supplemental target packets are immutable; saved dialogue overlays are NOT opened.
    for corpus in load(INTERFACE)['corpora'].values():
        verify_pin(corpus['path'], corpus['sha256'])
    return len(pins), len(inherited), len(continuation['outputPins'])


def profile_for(role):
    if role.startswith('quest-stepHistory'):
        return 'quest-history'
    return role


def derive():
    baseline = load(READBACK / 'components.json')['rows']
    require(len(baseline) == 108, 'baseline-component-count')
    old_ids = unique([{'id': r['component']['id']} for r in baseline], 'id', 'duplicate-component')
    binding = load(NAME / 'binding.json')
    native = binding['nativeTextComponents'][0]
    require(native['component']['id'] == 'sharedassets0.assets:4545', 'custom-nameplate-identity')
    require(native['fontIdentity']['id'] == 'sharedassets0.assets:369', 'custom-nameplate-font')
    require(binding['naturalLeafClosureReached'] and not binding['gaps'], 'custom-nameplate-incomplete')
    require('sharedassets0.assets:4545' not in old_ids, 'custom-nameplate-already-counted')
    components = copy.deepcopy(baseline)
    components.append({'component': native['component'], 'role': 'custom-nameplate', 'kind': 'UnityEngine.UI.Text',
                       'fontTarget': native['fontIdentity'], 'fontReference': native['fontPPtr'],
                       'materialTarget': native['materialIdentity'], 'materialReference': native['materialPPtr'],
                       'serializedSettings': native['fontData'], 'context': {'controller': native['controller'],
                       'root': native['root'], 'transform': native['transform'], 'gameObject': native['gameObject']},
                       'originalTextReference': {'id': 'sharedassets0.assets:4545/m_Text',
                       'valueSha256': value_hash(native['storedText'], newline=True)},
                       'runtimeSelection': 'not established by stored membership/active state'})
    unique([{'id': r['component']['id']} for r in components], 'id', 'duplicate-component')
    require(len(components) == 109, 'selected-component-count')
    direct = unique(lines(SOURCE / 'direct-context.jsonl'), 'id', 'duplicate-direct-selector')
    serial = unique(lines(SOURCE / 'serialized-inventory.jsonl'), 'id', 'duplicate-serialized-selector')
    old_bindings = unique(load(SOURCE / 'old935-selector-bindings.json'), 'id', 'duplicate-old935-id')
    require(len(old_bindings) == 935, 'old935-count')
    source_to_ui = {}
    for ui_id, row in old_bindings.items():
        require(row['valueMatches'], 'old935-source-mismatch')
        source_to_ui.setdefault(row['sourceId'], []).append(ui_id)
    bg = lines(SOURCE / 'bgdatabase-inventory.jsonl')
    cells = unique(lines(Path('localization/source/bgdatabase-complete-values-20261027/verified/cells.jsonl')),
                   'id', 'duplicate-bg-cell')
    wording = lines(SOURCE / 'compiled-wording-source.jsonl')
    saved = load(DIALOGUE)
    interface = load(INTERFACE)
    resources = load(READBACK / 'resources.json')['rows']
    ui = {}
    for locale, corpus in interface['corpora'].items():
        ui[locale] = unique(lines(corpus['path']), 'id', 'duplicate-interface-id')
        require(set(ui[locale]) == set(old_bindings), 'interface-id-mismatch:' + locale)
        for uid, row in ui[locale].items():
            require(value_hash(row['source']) == old_bindings[uid]['sourceValueSha256'], 'interface-source-hash:' + uid)
    profiles = {}
    for component in components:
        profile = profile_for(component['role'])
        source_id = component['originalTextReference']['id']
        require(source_id in direct and source_id in serial, 'missing-component-source:' + source_id)
        expected = component['originalTextReference']['valueSha256']
        require(value_hash(direct[source_id]['value'], newline=True) == expected and
                value_hash(direct[source_id]['value']) == serial[source_id]['sourceValueSha256'],
                'component-source-value:' + source_id)
        component['requirementProfile'] = profile
        component['requirementBinding'] = 'Superseded baseline applicability: see requirementProfile in this supplement'
        component['sourceRole'] = serial[source_id]['role']
        component['storedSource'] = {'id': source_id, 'valueSha256': serial[source_id]['sourceValueSha256'],
                                    'hashConvention': 'compact-JSON-UTF8-without-LF; originalTextReference uses compact-JSON-with-LF',
                                    'directContextIndex': direct[source_id]['index'] if 'index' in direct[source_id] else None,
                                    'old935TargetIds': source_to_ui.get(source_id, [])}
        profiles.setdefault(profile, {'componentIds': [], 'storedSelectors': []})
        profiles[profile]['componentIds'].append(component['component']['id'])
        profiles[profile]['storedSelectors'].append({'id': source_id, 'sourceValueSha256': serial[source_id]['sourceValueSha256'],
                                                   'role': serial[source_id]['role']})

    def bg_select(sheet, field):
        selected = []
        for r in bg:
            if r['sheet'] != sheet or r['field'] != field:
                continue
            cell = cells[r['id']]
            require(cell['stored'] == r['stored'] and value_hash(cell['source']) == r['sourceValueSha256'], 'bg-source-value')
            selected.append(dict(r, source=cell['source'], valueState='absent' if not cell['stored'] else 'nonempty' if cell['source'] else 'empty'))
        return selected

    def il_select(type_name, method=None, offsets=None):
        return [dict(r) for r in wording if (' ' + type_name + '::') in r['method']
                and (method is None or ('::' + method + '(') in r['method'])
                and (offsets is None or r['offset'] in offsets)]

    # Named game predicates, not broad regex-based claims of final sink completeness.
    dynamic = {
        'inventory-itemTitleText': bg_select('InventoryItem', 'title') + il_select('TheForestOfLove.InventoryInfoTicker', 'OnCellSelected', [0x10c, 0x11d]),
        'inventory-tickerText': bg_select('InventoryItem', 'description') + il_select('TheForestOfLove.InventoryInfoTicker', 'OnCellSelected', [0x111, 0x122]),
        'quest-title': bg_select('Quest', 'bio_title'),
        'quest-description': bg_select('Quest', 'bio_description'),
        'quest-history': bg_select('QuestProgressLogText', 'log_text') + il_select('TheForestOfLove.QuestLogDetailsPane') + il_select('TheForestOfLove.QuestLog', 'OnQuestLogUpdated'),
        'custom-nameplate': bg_select('Actor', 'nameplate_name') + il_select('TheForestOfLove.DialogueNameplateController'),
    }
    require(len(dynamic['inventory-itemTitleText']) == 50 and len(dynamic['inventory-tickerText']) == 50, 'inventory-profile-count')
    boundaries = {
        'ordinary-dialogue': ('StandardDialogueUI3926 -> panel3633 -> TMP4571; controller4311 main/mouse switch',
            'Saved12246 logical IDs contain commands/actor fields/fictional text; actual line/locale/parser/actor substitution and main-vs-mouse subset not a final role corpus.'),
        'bundled-subtitle': ('Exact75 original subtitle components; baseline candidate10 selector',
            'Actual prefab/scene/live selection and line-to-copy allocation unproved. Saved dialogue is a conservative logical superset, not75 source units.'),
        'inventory-itemTitleText': ('OnCellSelected IL00c5/012f and UpdateItemInfoText arg1 -> itemTitleText; IL010c/011d empty-cell branches',
            '48 stored item title candidates plus2 exact empty-cell inputs; item400 clears these fields and writes separate glitch TMP. Item405/quantity/consumed/selection branches and final targets remain unaccepted.'),
        'inventory-tickerText': ('OnCellSelected IL00cb/0135 and UpdateItemInfoText arg2 -> tickerText; IL0111/0122 empty-cell branches',
            '48 stored item description candidates plus2 exact empty-cell inputs; scrolling/layout and final target hashes remain open. Glitch output is a separate nonselected TMP consumer.'),
        'quest-title': ('QuestLogDetailsPane18307.UpdateSelectedQuest -> title field; Quest.bio_title',
            '38 stored candidates; actual selected quest, null/empty/default and final source/editorial application remain open.'),
        'quest-description': ('QuestLogDetailsPane18307.UpdateSelectedQuest -> description; Quest.bio_description',
            '38 stored candidates; actual selected quest, conditional overlays and final target application remain open.'),
        'quest-history': ('QuestLogDetailsPane18307 -> current/four history fields; quest-consumers/ADAPTER.md special branches',
            '119 DB log states plus whole DetailsPane/OnQuestLogUpdated wording are a conservative five-slot source family, not exact per-slot allocation. Counter/region joins, prefixes, placeholders, initial-order/reflection and status/unlock remain separate.'),
        'settings-layer': ('Three labels Fullscreen/Stretch/Scale; six exact original TMP layers each; stored hierarchy in component rows',
            '18 direct immutable old935 selectors; this bounded label coverage does not establish all settings/control/input captions, baked states, values or runtime layout.'),
        'plugin-portrait-name': ('StandardUISubtitlePanel3633.portraitName -> native Text3695/Font367 outside custom subtree',
            'Plugin actor/custom-name/locale localization, formatted speaker output and live visibility need a proved source-to-label handoff. No Actor.nameplate_name or dialogue character superset is silently declared its exact corpus.'),
        'custom-nameplate': ('controller4311 -> root2849 -> Text4545; UpdateNameplate -> Actor.NameplateName/customNameplate/???',
            '39 DB nameplate states and2 compiled conditional custom overrides are candidates only. NameplateName BioDetail override selection, intro/narrator/player guards, arbitrary setters/commands/parser and dynamic-name input policy need exact final source/target closure; full_name is not this field.'),
    }
    interface_fonts = interface['fonts']
    saved_fonts = saved['fonts']
    candidates = load(CJK)
    for name, profile in profiles.items():
        consumer, boundary = boundaries[name]
        profile.update({'consumerPredicate': consumer, 'remainingSourcePredicate': boundary,
                        'dynamicSelectors': dynamic.get(name, []),
                        'savedDialogue': {'applicability': 'logical-superset-only' if name in ['ordinary-dialogue', 'bundled-subtitle'] else 'not-a-role-requirement-set',
                                         'report': str(DIALOGUE), 'sha256': fingerprint(DIALOGUE)['sha256'],
                                         'finalTargetApplicability': 'unchecked; live overlays not read'},
                        'finalCorpusAccepted': False, 'resourceApplication': 'not-run', 'runtime': 'not-run', 'visual': 'not-run'})
        selected_sources = [r['id'] for r in profile['storedSelectors'] + profile['dynamicSelectors']]
        require(len(set(selected_sources)) == len(selected_sources), 'duplicate-profile-source:' + name)
        projected = [uid for uid in old_bindings if old_bindings[uid]['sourceId'] in selected_sources]
        profile['old935Projection'] = {'ids': projected, 'count': len(projected),
            'sourceSelectorsWithoutOld935Targets': [sid for sid in selected_sources if sid not in source_to_ui],
            'nonemptyDynamicSourcesWithoutOld935Targets': [r['id'] for r in profile['dynamicSelectors'] if r['id'] not in source_to_ui and r.get('source')],
            'absentDynamicStates': [r['id'] for r in profile['dynamicSelectors'] if r.get('valueState') == 'absent'],
            'boundary': 'Exact existing target/source joins only; no target authored for omissions and no final runtime allocation asserted.'}
        profile['storedSourceRequirements'] = requirements([direct[r['id']]['value'] for r in profile['storedSelectors']])
        profile['savedDialogueChecks'] = {}
        if name in ['ordinary-dialogue', 'bundled-subtitle']:
            for locale, corpus in saved['corpora'].items():
                checks = []
                for font_id in sorted({c['fontTarget']['id'] for c in components if c['requirementProfile'] == name}):
                    require('characterCodes' in resources[font_id], 'dialogue-TMP-resource')
                    missing = sorted(set(map(ord, corpus['characters'])) - set(resources[font_id]['characterCodes']))
                    checks.append({'storedResource': font_id, 'kind': 'stored-TMP-character-table',
                                   'missingCodepoints': missing, 'missingCount': len(missing),
                                   'boundary': 'Logical saved superset includes protected/fictional/control operands; not observed missing glyphs or exact ordinary-line requirements'})
                profile['savedDialogueChecks'][locale] = {'path': corpus['path'], 'sha256': corpus['sha256'],
                    'ids': corpus['ids'], 'requiredCharacters': corpus['distinctRequiredCharacters'],
                    'checks': checks, 'currentFinalRoleCorpus': False}
        per_locale = {}
        for locale, packet in ui.items():
            req = requirements([packet[uid]['target'] for uid in projected])
            require(set(req['rawNfcNfdCodepoints']) <= set(interface['corpora'][locale]['codepoints']), 'interface-requirement-reconstruction')
            checks = []
            fonts = {c['fontTarget']['id'] for c in components if c['requirementProfile'] == name}
            for font in interface_fonts:
                identity = font.get('id', font.get('path'))
                if identity not in fonts and identity not in ['resources.assets:439', candidates['locales']['zh']['font'], candidates['locales']['ja']['font']]:
                    continue
                result = checked_subset(req['rawNfcNfdCodepoints'], interface['corpora'][locale]['codepoints'],
                                        font['coverage'][locale], font['metrics'].get('kind', font['kind']))
                result['font'] = identity
                checks.append(result)
            # TMP actual character tables are independent from any native Font family.
            for font_id in sorted(fonts):
                if font_id in resources and 'characterCodes' in resources[font_id]:
                    missing = sorted(set(req['rawNfcNfdCodepoints']) - set(resources[font_id]['characterCodes']))
                    checks.append({'font': font_id, 'kind': 'stored-TMP-character-table', 'missingCodepoints': missing,
                                   'missingCount': len(missing) if req['rawNfcNfdCodepoints'] else None,
                                   'status': 'static-subset-only' if req['rawNfcNfdCodepoints'] else 'no-bound-target-characters',
                                   'runtimeAccepted': False})
            per_locale[locale] = {'packetPath': interface['corpora'][locale]['path'],
                'packetSha256': interface['corpora'][locale]['sha256'], 'units': len(projected),
                'requirements': req, 'checks': checks, 'finalRoleCorpus': False}
        profile['interfaceLocales'] = per_locale
        profile['nextPermittedAction'] = ('Use immutable source/editorial-delivery manifests to bind missing selectors and final wording; '
            'recheck only affected role/corpus hashes. Retain null/unknown resource states; no resource or texture production. '
            'Actual shaping, bidi, marks, line metrics, narrow layout, dynamic input and loaded fallback require separately authorized isolated runtime.')

    # Candidate decisions are per locale and per physical resource, never a union cmap.
    decisions = []
    for profile_id, profile in profiles.items():
        for locale, corpus in saved['corpora'].items():
            candidate_id = candidates['locales'][locale]['font'] if locale in ['zh', 'ja'] else 'resources.assets:439'
            candidate = candidates['locales'].get(locale)
            candidate_font = next(r for r in saved_fonts if r['id'] == candidate_id) if not candidate else None
            for font_id in sorted({r['fontTarget']['id'] for r in components if r['requirementProfile'] == profile_id}):
                decisions.append({'profile': profile_id, 'locale': locale, 'storedResource': font_id,
                    'decision': 'retain-original-binding; candidate-for-bounded-trial-only',
                    'trialCandidate': candidate_id,
                    'candidateSha256': candidate['sha256'] if candidate else candidate_font['metrics']['embeddedFaceSha256'],
                    'candidateFace': candidate['metrics']['postscriptName'] if candidate else candidate_font['metrics']['postscriptName'],
                    'candidateLicense': 'Pinned OFL1.1 notices; final packaging still unverified' if candidate else 'Redistribution permission/notices not established by saved name table',
                    'dialogueReportApplicability': profile['savedDialogue']['applicability'],
                    'savedDialogueHash': corpus['sha256'],
                    'savedDialogueCandidateMissing': candidate['missingCount'] if candidate else candidate_font['coverage'][locale]['missingCount'],
                    'boundary': 'Candidate evidence applies to pinned saved characters only; not a font replacement, actual loaded face, complete role corpus or native readability decision. Mouse3324 remains separate.',
                    'applicationBlockedBy': ['complete-role-source-and-final-target-binding', 'final-face-license-and-resource-plan',
                                            'no-texture-guard-and-full-texture-stream-equality', 'native-role-script-layout-acceptance']})
    for row in components:
        font_id = row['fontTarget']['id']
        row['resolvedResources'] = {'font': font_id,
            'material': row['materialTarget']['id'] if row.get('materialTarget') else None,
            'nativeMaterialBoundary': 'null serialized PPtr; actual default material unresolved' if row['materialReference']['m_PathID'] == 0 else None}
        font = resources[font_id]
        if 'characterCodes' in font:
            atlases = font['serialized']['m_AtlasTextures']
            asset = font_id.rsplit(':', 1)[0]
            row['resolvedResources']['atlases'] = [resources[asset + ':' + str(p['m_PathID'])]['identity']['id'] for p in atlases]
    fictional = load(READBACK / 'fictional-preservation.json')
    require(fictional['mappingPreserved'] and len(fictional['sourceRows']) == 38, 'fictional-source-binding')
    require(fictional['fontMouse']['m_PathID'] == 3324 and fictional['fontMain']['m_PathID'] == 3323, 'fictional-resource-selection')
    require(len(resources['sharedassets0.assets:3324']['characterCodes']) == 100, 'fictional-original-table')
    for candidate in candidates['locales'].values():
        require(candidate['missingCount'] == 12 and set(map(ord, candidate['missing'])) <= set(resources['sharedassets0.assets:3324']['characterCodes']), 'fictional-12-table-binding')
    result = {'schemaVersion': 1, 'phase': '0147-work', 'selectedComponents': components,
              'requirementProfiles': profiles, 'candidateDecisions': decisions, 'originalResources': resources,
              'fictionalPreservation': fictional, 'fictionalResources': {k: resources[k] for k in ['sharedassets0.assets:3324', 'sharedassets0.assets:3', 'sharedassets0.assets:245']},
              'sourceManifest': {'path': str(SOURCE / 'manifest.json'), 'sha256': fingerprint(SOURCE / 'manifest.json')['sha256']},
              'reports': {str(p): fingerprint(p) for p in [DIALOGUE, INTERFACE, CJK, PROVENANCE]},
              'coverageBoundary': '109 selected physical identities; not all game text components or visible units. Seven saved dialogue corpora and30 immutable935-unit packets are independent inputs. No live target was opened.',
              'gates': {'source': 'needs-review', 'editorial': 'needs-review', 'fonts': 'needs-review', 'resources': 'not-run', 'runtime': 'not-run', 'visual': 'not-run', 'delivery': 'needs-review'}}
    return result


def validate_result(result):
    baseline = load(READBACK / 'components.json')['rows']
    expected = {r['component']['id']: r for r in baseline}
    expected['sharedassets0.assets:4545'] = {'fontTarget': {'id': 'sharedassets0.assets:369'},
        'fontReference': {'m_FileID': 0, 'm_PathID': 369}, 'materialReference': {'m_FileID': 0, 'm_PathID': 0},
        'materialTarget': None, 'originalTextReference': {'id': 'sharedassets0.assets:4545/m_Text',
        'valueSha256': value_hash('Scarlett', newline=True)}}
    ids = unique([dict(id=r['component']['id'], row=r) for r in result['selectedComponents']], 'id', 'duplicate-component')
    require(set(ids) == set(expected), 'selected-identity-coverage')
    for cid, item in ids.items():
        row, old = item['row'], expected[cid]
        for key in ['fontReference', 'materialReference', 'materialTarget', 'originalTextReference']:
            require(row[key] == old[key], 'stored-resource-binding:' + key)
        require(row['fontTarget']['id'] == old['fontTarget']['id'], 'stored-font-identity')
        profile = result['requirementProfiles'][row['requirementProfile']]
        require(cid in profile['componentIds'], 'profile-component-coverage')
        require(row['originalTextReference']['id'] in {r['id'] for r in profile['storedSelectors']}, 'profile-source-coverage')
        require(not profile['finalCorpusAccepted'], 'unsupported-final-corpus-acceptance')
    for profile in result['requirementProfiles'].values():
        require(len(profile['interfaceLocales']) == 30, 'locale-projection-coverage')
        for row in profile['interfaceLocales'].values():
            require(row['units'] == profile['old935Projection']['count'], 'projection-unit-coverage')
            if not row['requirements']['rawNfcNfdCodepoints']:
                require(all(c['missingCount'] is None for c in row['checks']), 'empty-projection-coverage-claim')
    require(all(r['storedResource'] != 'sharedassets0.assets:3324' for r in result['candidateDecisions']), 'fictional-candidate-replacement')
    require(result['fictionalPreservation'] == load(READBACK / 'fictional-preservation.json'), 'fictional-row-preservation')


def controls(result):
    validate_result(result)
    require(len(result['selectedComponents']) == 109, 'positive-selected-coverage')
    events = []
    def reject(name, action, reason):
        try:
            action()
        except ValueError as exc:
            require(str(exc) == reason, 'wrong-control-boundary:' + name + ':' + str(exc))
            events.append({'id': name, 'result': 'rejected', 'reason': reason})
        else:
            raise ValueError('negative-control-accepted:' + name)
    reject('duplicate-component', lambda: unique([{'id': 'x'}, {'id': 'x'}], 'id', 'duplicate-component'), 'duplicate-component')
    reject('out-of-universe-character', lambda: checked_subset([0x4e00], [65], {'missingCount': 0, 'missing': ''}, 'embedded-sfnt-cmap'), 'outside-reused-requirement-universe')
    unknown = checked_subset([65], [65], {'missingCount': None}, 'unavailable-embedded-face-and-character-map')
    require(unknown['missingCount'] is None and unknown['status'] == 'unknown', 'unknown-became-empty-cmap')
    present = checked_subset([65], [65, 66], {'missingCount': 1, 'missing': 'B'}, 'embedded-sfnt-cmap')
    absent = checked_subset([66], [65, 66], {'missingCount': 1, 'missing': 'B'}, 'embedded-sfnt-cmap')
    require(present['missingCount'] == 0 and absent['missingCount'] == 1, 'missing-set-subset-controls')
    require(requirements(['й'])['forms']['raw'] != requirements(['й'])['forms']['NFD'], 'normalization-control')
    reject('live-target-input', lambda: verify_pin('localization/ru-assets/dialogue.ru.jsonl', 'invalid'), 'live-target-read-prohibited')
    changed = copy.deepcopy(result['selectedComponents'][0]['storedSource'])
    changed['valueSha256'] = '0' * 64
    actual = next(r for r in lines(SOURCE / 'direct-context.jsonl') if r['id'] == changed['id'])
    reject('source-value-change', lambda: require(value_hash(actual['value']) == changed['valueSha256'], 'component-source-value'), 'component-source-value')
    ids = {r['component']['id']: r for r in result['selectedComponents']}
    require(ids['sharedassets0.assets:4545']['fontTarget']['id'] == 'sharedassets0.assets:369', 'custom-positive')
    require(ids['sharedassets0.assets:3695']['fontTarget']['id'] == 'sharedassets0.assets:367', 'plugin-positive')
    reject('plugin-substitutes-custom', lambda: require(ids['sharedassets0.assets:3695']['component']['id'] == 'sharedassets0.assets:4545', 'wrong-custom-component'), 'wrong-custom-component')
    changed = copy.deepcopy(result)
    changed['selectedComponents'].pop()
    reject('omitted-custom-component', lambda: validate_result(changed), 'selected-identity-coverage')
    changed = copy.deepcopy(result)
    changed['selectedComponents'][0]['materialReference']['m_PathID'] = 7
    reject('shared-material-substitutes-bundled', lambda: validate_result(changed), 'stored-resource-binding:materialReference')
    changed = copy.deepcopy(result)
    changed['requirementProfiles']['ordinary-dialogue']['interfaceLocales']['ru']['checks'][0]['missingCount'] = 0
    reject('empty-projection-becomes-pass', lambda: validate_result(changed), 'empty-projection-coverage-claim')
    changed = copy.deepcopy(result)
    changed['candidateDecisions'][0]['storedResource'] = 'sharedassets0.assets:3324'
    reject('candidate-replaces-fictional', lambda: validate_result(changed), 'fictional-candidate-replacement')
    require(len({sha(b'Scarlett'), value_hash('Scarlett'), value_hash('Scarlett', newline=True)}) == 3, 'hash-convention-control')
    return {'negative': events, 'positive': ['unknown-remains-unknown', 'matched-missing-and-present-subsets', 'raw-vs-NFD-distinction', '109-unique-components', 'custom369-and-plugin367-separate'],
            'boundary': 'Exercises joins and requirement reuse; does not parse fonts, build resources, test game or independently review semantics.'}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--check', action='store_true')
    args = ap.parse_args()
    counts = verify_dependencies()
    result = derive()
    validation = controls(result)
    outputs = {'reconciliation.json': encode(result)}
    validation.update({'schemaVersion': 1, 'phase': '0147-work', 'status': 'passed-static-scoped',
        'selectedComponents': len(result['selectedComponents']), 'profiles': len(result['requirementProfiles']),
        'interfaceLocales': 30, 'savedDialogueLocales': 7,
        'directOld935Components': sum(bool(r['storedSource']['old935TargetIds']) for r in result['selectedComponents']),
        'inputPins': counts[0], 'inheritedOriginalPins': counts[1], 'reusedSourceProducts': counts[2],
        'historicalPinApplicability': {'originalInstall': 'Prior119 receipt hash retained; original install not reopened',
            'fontsGuide': 'Prior documentation superseded by accepted119/30-locale guide; current pre-phase bytes preserved separately'},
        'recipeSha256': sha(Path(__file__).read_bytes()), 'outputs': {k: sha(v) for k,v in outputs.items()},
        'fontParsersRun': 0, 'liveTargetsRead': 0, 'newIL': 0, 'resourceEdits': 0, 'textureEdits': 0,
        'gameLaunches': 0, 'imagesOpened': 0, 'workerGitMutations': 0,
        'usage': 'unknown; parent owns actual request telemetry'})
    outputs['validation.json'] = encode(validation)
    for name, data in outputs.items():
        path = HERE / name
        if args.check:
            require(path.read_bytes() == data, 'output-reproduction:' + name)
        else:
            require(not path.exists(), 'refuse-overwrite:' + name)
            path.write_bytes(data)
    print(json.dumps({k:v for k,v in validation.items() if k not in ['negative','positive','outputs']}, indent=2))


if __name__ == '__main__':
    main()
