#!/usr/bin/env python3
"""Read one original manager's localization settings; never execute game code."""
import argparse
import hashlib
import json
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')


def sha(path):
    h = hashlib.sha256()
    with path.open('rb') as stream:
        for block in iter(lambda: stream.read(4 * 1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()


def load(path):
    return json.loads(path.read_text())


def dump(path, value):
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def verify(out):
    baseline = load(HERE / 'baseline.json')
    for key in ('inputs', 'frozenPins', 'owningHelpers', 'processReferences'):
        for name, expected in baseline[key].items():
            p = Path(name) if Path(name).is_absolute() else ROOT / name
            assert sha(p) == expected, (key, name)
    for name, expected in baseline['installedSources'].items():
        assert sha(DATA / name) == expected, name
    dll_pins = load(ROOT / 'localization/source/bgdatabase-20261027/bio-prepare-bindings/binding-pins.json')
    for name, expected in dll_pins.items():
        assert sha(Path(name)) == expected, name
    installed_dlls = [p for p in dll_pins if Path(p).parent == DATA / 'Managed' and p.endswith('.dll')]
    assert len(installed_dlls) == 150
    assert {p.name for p in (DATA / 'Managed').glob('*.dll')} == {
        Path(p).name for p in installed_dlls}
    for name, archive in [('README.md', 'previous-summary.md'), ('CHECKPOINT.json', 'previous-checkpoint.json')]:
        assert sha(HERE / archive) == baseline['summaryPins'][name], archive

    import UnityPy
    from UnityPy.helpers.TypeTreeGenerator import TypeTreeGenerator
    sys.path.insert(0, str(ROOT / 'tools'))
    from extract_assets import read_tree, canonical
    inventory = load(ROOT / 'assets/source-v2/objects.json')
    selected = {}
    for pid in (4608, 1297, 744):
        rows = [o for o in inventory if o['asset'] == 'sharedassets0.assets' and o['pathId'] == pid]
        assert len(rows) == 1, (pid, 'unique inventory identity')
        selected[pid] = rows[0]
    binding = load(ROOT / 'localization/source/bgdatabase-20261027/bio-prepare-bindings/readback/serialized-manager-binding.json')
    assert binding['candidateManager']['component'] == selected[4608]['id']
    assert selected[4608]['rawSha256'] == binding['inventoryCandidates'][0]['rawSha256']
    env = UnityPy.load(str(DATA / 'sharedassets0.assets'))
    matches = [o for o in env.objects if o.path_id == 4608]
    assert len(matches) == 1
    obj = matches[0]
    raw = obj.get_raw_data()
    assert len(raw) == selected[4608]['bytes'] == 440
    assert hashlib.sha256(raw).hexdigest() == selected[4608]['rawSha256']
    gen = TypeTreeGenerator('2020.3.24f1')
    gen.load_local_dll_folder(str(DATA / 'Managed'))
    tree = canonical(read_tree(obj, gen))
    export = ROOT / 'assets/source-v2' / selected[4608]['tree']
    assert sha(export) == selected[4608]['treeSha256']
    assert tree == load(export), 'whole-object export parity'
    assert tree['m_GameObject'] == dict(m_FileID=0, m_PathID=1297)
    assert tree['m_Script'] == dict(m_FileID=1, m_PathID=3980)
    assert tree['m_Enabled'] == 1
    settings = tree['displaySettings']['localizationSettings']
    assert set(settings) == {'language', 'useSystemLanguage', 'textTable'}
    assert settings == dict(language='', useSystemLanguage=0, textTable=dict(m_FileID=0, m_PathID=0))
    ptr = settings['textTable']
    assert ptr['m_PathID'] == 0 and ptr['m_FileID'] == 0
    # Zero path ID is null. Do not dereference it or infer dynamic table absence.
    dialogue_ui = tree['displaySettings']['dialogueUI']
    assert dialogue_ui == dict(m_FileID=0, m_PathID=744)
    next_export = ROOT / 'assets/source-v2' / selected[744]['tree']
    assert sha(next_export) == selected[744]['treeSha256']
    next_tree = load(next_export)
    assert next_tree['m_Name'] == 'OverworldDialogueCanvas'
    assert len(next_tree['m_Component']) == 6
    result = dict(
        boundary='Original resource bytes decoded with unchanged header-aligned reader; full manager export parity, not runtime selection or initialization.',
        component=selected[4608]['id'], gameObject=selected[1297]['id'],
        rawBytes=len(raw), rawSha256=hashlib.sha256(raw).hexdigest(),
        export=str(export.relative_to(ROOT)), exportSha256=sha(export),
        localizationSettings=settings,
        textTableResolution=dict(fileID=ptr['m_FileID'], pathID=ptr['m_PathID'],
            fileMapping='fileID 0 denotes the containing sharedassets0.assets; no external mapping is selected',
            target='null pathID 0; no serialized table dependency to follow', dereferenced=False),
        distinction='Component-local DialogueSystemController displaySettings only; not LocalizeUI.m_textTable, UILocalizationManager singleton, GlobalTextTable, or an observed language/cache state.',
        conditionalConsequence='If unchanged and this candidate is the receiver, selected GetLocalizedText follows the absent-settings-table input return. Native selection, later assignments and actual calls remain unaccepted.',
        nextConsumer=dict(sourceField='/displaySettings/dialogueUI', reference=dialogue_ui,
            fileMapping='same sharedassets0.assets (fileID 0)', inventory=selected[744],
            pinnedExportName=next_tree['m_Name'], pinnedExportComponents=next_tree['m_Component'],
            status='Direct nonnull source binding; its original resource/component consumer readback is pending. No instantiated/active renderer claim.'),
        liveState='not-run/unaccepted; null serialized table does not exclude dynamically created or later-loaded tables')
    dump(out / 'serialized-localization.json', result)
    verification = dict(status='passed-static-scoped', managerObjectsRead=1,
        managerRawBytes=len(raw), completeManagerExportParity=True,
        frozenPinsUnchanged=len(baseline['frozenPins']), helpersChecked=len(baseline['owningHelpers']),
        installedResourcesChecked=len(baseline['installedSources']), metadataDllsPinned=150,
        pinnedPriorEvidenceFilesChecked=len(baseline['inputs']),
        previousMetadataTraces='retained by hashes; not rerun',
        previousSourceCounts='phase88 retained evidence: 12246 values/copy, 24492 occurrences,16 actor IDs,126 registrations,114 entries; not recomputed in this phase',
        serializedLanguage='', serializedUseSystemLanguage=0, serializedTableNull=True,
        tableReferencesFollowed=0, externalTableMappingsSelected=0,
        nextBoundConsumer='sharedassets0.assets:744 /displaySettings/dialogueUI; pending original readback',
        gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0, gitMutations=0,
        authoredTranslations=0, sourceAcceptance='needs-review', editorial='not-run',
        runtime='not-run', visual='not-run', delivery='needs-review', usage=None)
    dump(out / 'verification.json', verification)
    return verification


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert args.output.resolve().is_relative_to(HERE), 'write only inside this supplement'
    args.output.mkdir(parents=True, exist_ok=False)
    print(json.dumps(verify(args.output)))
