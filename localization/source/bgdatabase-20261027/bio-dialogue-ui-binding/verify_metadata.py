#!/usr/bin/env python3
"""Reproduce exact bounded metadata selections and verify UI selection boundaries."""
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


def dump(p, x):
    p.write_text(json.dumps(x, indent=2, ensure_ascii=False) + '\n')


def method(text, name):
    blocks = [b for b in text.split('METHOD ')[1:] if '::' + name + '(' in b.splitlines()[0]]
    assert len(blocks) == 1, name
    return blocks[0]


def ordered(text, *values):
    start = 0
    for value in values:
        pos = text.index(value, start)
        start = pos + len(value)


def verify(out):
    for name, expected in load(HERE / 'metadata-pins.json').items():
        path = Path(name) if Path(name).is_absolute() else ROOT / name
        assert sha(path) == expected, name
    helper = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
    commands = load(HERE / 'il-commands.json')
    for row in commands:
        assert row['exitCode'] == 0
        result = subprocess.run(['dotnet', str(helper), str(DATA / 'Managed' / row['assembly']),
                                 row['type'], row['selection']], capture_output=True, check=True)
        assert not result.stderr, result.stderr
        p = out / row['output']
        p.write_bytes(result.stdout)
        assert sha(p) == row['sha256'], row['output']
    types = subprocess.run(['dotnet', str(HERE / 'bin/Debug/net8.0/DirectTypes.dll'),
                            str(DATA / 'Managed')], capture_output=True, check=True)
    assert not types.stderr, types.stderr
    p = out / 'direct-type-interfaces.json'
    p.write_bytes(types.stdout)
    assert sha(p) == sha(HERE / 'direct-type-interfaces.json')
    rows = load(p)
    assert len(rows) == 6
    assert all(not r['implementsIDialogueUI'] for r in rows)
    assert rows[0]['selectedType'] == 'UnityEngine.RectTransform'
    assert rows[0]['allInterfaces'] == ['System.Collections.IEnumerable'], 'Inherited-interface positive control'
    installed = load(ROOT / 'localization/source/bgdatabase-20261027/bio-prepare-bindings/binding-pins.json')
    for row in rows:
        for node in row['chain']:
            assert Path(node['modulePath']).parent == DATA / 'Managed', node
            assert installed[node['modulePath']] == node['moduleSha256'], node
            assert node['type'] not in ('UnityEngine.UI.Text', 'TMPro.TMP_Text', 'TMPro.TextMeshProUGUI',
                                        'PixelCrushers.DialogueSystem.AbstractDialogueUI')
    text = (out / 'controller-ui.il').read_text()
    getter = method(text, 'GetDialogueUI')
    ordered(getter, '::ValidateCurrentDialogueUI()', '::m_currentDialogueUI')
    selection = method(text, 'GetDialogueUIFromDisplaySettings')
    ordered(selection, '::dialogueUI', '::op_Inequality', '::IsPrefab',
            '::GetComponentInChildren(System.Type)', 'isinst PixelCrushers.DialogueSystem.IDialogueUI',
            '::LoadDialogueUIPrefab', 'stfld PixelCrushers.DialogueSystem.IDialogueUI')
    prefab = method(text, 'LoadDialogueUIPrefab')
    ordered(prefab, '::Instantiate<UnityEngine.GameObject>', '::GetComponentInChildren(System.Type)',
            'isinst PixelCrushers.DialogueSystem.IDialogueUI', '::Destroy(UnityEngine.Object)',
            'isinst PixelCrushers.DialogueSystem.CanvasDialogueUI')
    validate = method((out / 'controller-validate.il').read_text(), 'ValidateCurrentDialogueUI')
    ordered(validate, '::m_currentDialogueUI', 'brtrue.s IL_0048', '::GetDialogueUIFromDisplaySettings()',
            '::LoadDefaultDialogueUI()', 'isinst UnityEngine.MonoBehaviour',
            '::get_gameObject()', 'stfld UnityEngine.GameObject PixelCrushers.DialogueSystem.DisplaySettings::dialogueUI')
    isprefab = method((out / 'prefab-test.il').read_text(), 'IsPrefab')
    ordered(isprefab, '::get_activeInHierarchy()', '::get_parent()', '::get_activeSelf()',
            '::FindObjectsOfType<UnityEngine.GameObject>()')
    display = (out / 'display-fields.il').read_text()
    assert 'FIELD UnityEngine.GameObject PixelCrushers.DialogueSystem.DisplaySettings::dialogueUI' in display
    resource = load(HERE / 'readback-v2/direct-ui-binding.json')
    assert resource['objects'][1]['decoded']['m_Children'] == [dict(m_FileID=0, m_PathID=2447)]
    inv = load(ROOT / 'assets/source-v2/objects.json')
    matches = [o for o in inv if o['asset'] == 'sharedassets0.assets' and o['pathId'] == 2447]
    assert len(matches) == 1
    dump(out / 'next-consumer.json', dict(
        fromObject='sharedassets0.assets:2454', sourceField='/m_Children/0',
        reference=dict(m_FileID=0, m_PathID=2447), mapping='same sharedassets0.assets',
        inventory=matches[0], status='Original child object and its GameObject/component consumer bindings not read yet',
        required='Read this one original child transform, then its direct GameObject/components only as needed for IDialogueUI; do not dump hierarchy.'))
    dump(out / 'verification.json', dict(status='passed-static-scoped',
        reproducedMetadataSelections=len(commands), methodBodies=6, completeDirectTypeChains=6,
        directIDialogueUIImplementers=0, inheritedInterfacePositiveControl='RectTransform -> Transform -> IEnumerable',
        directLegacyTextOrTMPTypes=0, nextBoundConsumer='sharedassets0.assets:2447 /m_Children/0',
        regressionAssertions=['Declared UI field is GameObject, not a component pointer',
            'Cached interface can bypass selection; fallback and settings writeback are ordered',
            'Prefab test uses native live hierarchy/object enumeration; no serialized-boolean decision',
            'Nonprefab and cloned-prefab routes use native GetComponentInChildren(IDialogueUI)',
            'No six direct type implements IDialogueUI; inherited-interface positive control succeeds',
            'All resolved type-chain modules match original pinned Managed DLLs',
            'Only one direct child pointer is pinned; its original consumer remains unresolved'],
        gameAssemblyExecuted=False, gameLaunches=0, imagesOpened=0, gitMutations=0,
        runtime='not-run', visual='not-run', sourceAcceptance='needs-review', usage=None))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    output = args.output.resolve()
    assert HERE in output.parents and not output.exists()
    output.mkdir()
    verify(output)
