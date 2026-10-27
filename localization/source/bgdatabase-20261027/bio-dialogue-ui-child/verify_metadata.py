#!/usr/bin/env python3
"""Reproduce the selected original UI wrapper metadata and retain the next dependency."""
import argparse
import hashlib
import json
import subprocess
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
DATA = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest/The Forest of Love_Data')


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def load(p):
    return json.loads(p.read_text())


def dump(p, data):
    p.write_text(json.dumps(data, indent=2, ensure_ascii=False) + '\n')


def ordered(text, *tokens):
    pos = 0
    for token in tokens:
        pos = text.index(token, pos) + len(token)


def verify(out):
    for name, expected in load(HERE / 'metadata-pins.json').items():
        p = Path(name) if Path(name).is_absolute() else ROOT / name
        assert sha(p) == expected, name
    commands = [r for filename in ('il-commands.json', 'il-commands-v2.json', 'il-commands-v3.json')
                for r in load(HERE / filename) if r['exitCode'] == 0]
    assert len(commands) == 7
    helper = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
    for row in commands:
        result = subprocess.run(['dotnet', str(helper), str(DATA / 'Managed' / row['assembly']),
                                 row['type'], row['selection']], capture_output=True, check=True)
        assert not result.stderr
        p = out / row['output']
        p.write_bytes(result.stdout)
        assert sha(p) == row['sha256'], row['output']
    result = subprocess.run(['dotnet', str(HERE / 'bin/Debug/net8.0/ChildType.dll'), str(DATA / 'Managed')],
                            capture_output=True, check=True)
    assert not result.stderr
    p = out / 'child-type-interfaces.json'
    p.write_bytes(result.stdout)
    assert sha(p) == sha(HERE / 'child-type-interfaces.json')
    rows = load(p)
    assert len(rows) == 1
    row = rows[0]
    assert row['selectedType'] == 'PixelCrushers.DialogueSystem.Wrappers.StandardDialogueUI'
    assert row['implementsIDialogueUI']
    assert row['allInterfaces'] == ['PixelCrushers.DialogueSystem.IDialogueUI', 'PixelCrushers.DialogueSystem.IStandardDialogueUI']
    expected = [
        'PixelCrushers.DialogueSystem.Wrappers.StandardDialogueUI',
        'PixelCrushers.DialogueSystem.StandardDialogueUI',
        'PixelCrushers.DialogueSystem.CanvasDialogueUI',
        'PixelCrushers.DialogueSystem.AbstractDialogueUI',
        'UnityEngine.MonoBehaviour', 'UnityEngine.Behaviour', 'UnityEngine.Component', 'UnityEngine.Object', 'System.Object']
    assert [n['type'] for n in row['chain']] == expected
    installed = load(ROOT / 'localization/source/bgdatabase-20261027/bio-prepare-bindings/binding-pins.json')
    for node in row['chain']:
        path = Path(node['modulePath'])
        assert path.parent == DATA / 'Managed'
        assert sha(path) == node['moduleSha256'] == installed[node['modulePath']]
        assert node['type'] not in ('UnityEngine.UI.Text', 'TMPro.TMP_Text', 'TMPro.TextMeshProUGUI')
    wrapper = (out / 'wrapper-list.il').read_text().splitlines()
    assert len(wrapper) == 1 and '::.ctor()' in wrapper[0], 'Wrapper declares no ShowSubtitle override'
    fields = (out / 'standard-fields-v2.il').read_text()
    assert 'FIELD PixelCrushers.DialogueSystem.StandardUIDialogueControls PixelCrushers.DialogueSystem.StandardDialogueUI::conversationUIElements' in fields
    text = (out / 'standard-subtitle-v2.il').read_text()
    blocks = text.split('METHOD ')[1:]
    assert len(blocks) == 3
    show = next(b for b in blocks if '::ShowSubtitle(' in b.splitlines()[0])
    ordered(show, '::conversationUIElements', '::get_standardMenuControls()', '::Close()',
            '::conversationUIElements', '::get_standardSubtitleControls()', 'ldarg.1',
            '::ShowSubtitle(PixelCrushers.DialogueSystem.Subtitle)')
    assert 'AbstractUISubtitleControls::ShowSubtitle' in show
    hide = next(b for b in blocks if '::HideSubtitle(' in b.splitlines()[0])
    ordered(hide, '::conversationUIElements', '::get_standardSubtitleControls()', 'ldarg.1',
            'StandardUISubtitleControls::HideSubtitle')
    resources = load(HERE / 'readback/child-ui-binding.json')
    ui = next(r for r in resources['objects'] if r['inventory']['pathId'] == 3926)
    assert ui['scriptResolution']['declaredType'] == row['selectedType']
    assert ui['scriptResolution']['assembly'] == row['selectedAssembly']
    assert ui['decoded']['m_GameObject'] == dict(m_FileID=0, m_PathID=737)
    controls = ui['decoded']['conversationUIElements']
    ptr = controls['defaultNPCSubtitlePanel']
    assert ptr == dict(m_FileID=0, m_PathID=3633)
    assert controls['subtitlePanels'][0] == ptr
    inventory = load(ROOT / 'assets/source-v2/objects.json')
    matches = [r for r in inventory if r['asset'] == 'sharedassets0.assets' and r['pathId'] == ptr['m_PathID']]
    assert len(matches) == 1
    dump(out / 'next-consumer.json', dict(
        fromObject='sharedassets0.assets:3926',
        sourceField='/conversationUIElements/defaultNPCSubtitlePanel', reference=ptr,
        mapping='fileID0 -> same sharedassets0.assets', inventory=matches[0],
        nextMetadata=[
            'PixelCrushers.DialogueSystem.StandardUIDialogueControls::get_standardSubtitleControls()',
            'PixelCrushers.DialogueSystem.AbstractUISubtitleControls::ShowSubtitle(Subtitle)',
            'PixelCrushers.DialogueSystem.StandardUISubtitleControls panel selection and ShowSubtitle dispatch'],
        evidence='StandardDialogueUI.ShowSubtitle closes standard menu then calls abstract subtitle controls through standardSubtitleControls getter.',
        status='Stored default NPC panel pointer; original3633 bytes/renderer and actual selected panel not read or accepted.',
        required='Trace exact subtitle-control dispatch/selection before crediting any default panel. Read only3633 and indispensable direct bindings, not the ten-child hierarchy.'))
    dump(out / 'verification.json', dict(status='passed-static-scoped', reproducedMetadataSelections=len(commands),
        methodBodies=3, completeSelectedTypeChains=1, inheritedIDialogueUIImplementers=1,
        selectedChainLegacyTextOrTMPTypes=0,
        actualRuntimeSelection='needs-review; cached interface/native child search/default/clone and lifecycle remain unexecuted',
        originalPanelOrRenderer='not-read/unaccepted',
        regressionAssertions=[
            'Child2447 points back to parent2454 and directly to GameObject737 with four MonoBehaviours',
            'All four script fileID1 references resolve original globalgamemanagers.assets with whole-export parity',
            'Wrapper3926 resolves Auto-asmdef-FirstPass.dll; complete original chain inherits IDialogueUI via AbstractDialogueUI',
            'Wrapper declares constructor only; base StandardDialogueUI.ShowSubtitle closes menu then dispatches subtitle via controls',
            'UI component is not itself a legacy Text or TMP component; serialized TMP-named fields do not establish rendering',
            'Default NPC panel3633 is a stored pointer, not proven actual panel or selected native UI'],
        gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0, gitMutations=0,
        sourceAcceptance='needs-review', runtime='not-run', visual='not-run', editorial='not-run', delivery='needs-review', usage=None))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    out = args.output.resolve()
    assert HERE in out.parents and not out.exists()
    out.mkdir()
    verify(out)
