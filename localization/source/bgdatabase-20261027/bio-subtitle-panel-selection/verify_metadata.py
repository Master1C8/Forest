#!/usr/bin/env python3
"""Reproduce bounded subtitle selection metadata; never execute game assemblies."""
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


def ordered(text, *tokens):
    pos = 0
    for token in tokens:
        pos = text.index(token, pos) + len(token)


def method(text, name):
    matches = [b for b in text.split('METHOD ')[1:] if '::' + name + '(' in b.splitlines()[0]]
    assert len(matches) == 1, name
    return matches[0]


def verify(out):
    for name, expected in load(HERE / 'metadata-pins.json').items():
        p = Path(name) if Path(name).is_absolute() else ROOT / name
        assert sha(p) == expected, name
    rows = [r for filename in ('il-commands.json', 'il-commands-v2.json', 'il-commands-v3.json', 'il-commands-v4.json')
            for r in load(HERE / filename)]
    assert len(rows) == 17 and all(r['exitCode'] == 0 for r in rows)
    helper = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
    texts = {}
    for row in rows:
        result = subprocess.run(['dotnet', str(helper), str(DATA / 'Managed' / row['assembly']),
                                 row['type'], row['selection']], capture_output=True, check=True)
        assert not result.stderr
        p = out / row['output']
        p.write_bytes(result.stdout)
        assert sha(p) == row['sha256'], row['output']
        texts[row['output']] = result.stdout.decode()

    getter = texts['dialogue-controls-getter.il']
    ordered(getter, '::get_standardSubtitleControls()', '::m_standardSubtitleControls', 'ret')
    ctor = method(texts['dialogue-controls-initialize.il'], '.ctor')
    ordered(ctor, 'newobj System.Void PixelCrushers.DialogueSystem.StandardUISubtitleControls::.ctor()',
            'stfld PixelCrushers.DialogueSystem.StandardUISubtitleControls')
    initialize = method(texts['dialogue-controls-initialize.il'], 'Initialize')
    ordered(initialize, '::m_standardSubtitleControls', '::subtitlePanels', '::defaultNPCSubtitlePanel',
            '::defaultPCSubtitlePanel', 'StandardUISubtitleControls::Initialize(')
    assert 'BASE PixelCrushers.DialogueSystem.AbstractUISubtitleControls' in texts['subtitle-controls-fields.il']
    show = method(texts['subtitle-controls-show.il'], 'ShowSubtitle')
    assert 'attributes=Public, Virtual, HideBySig' in show.splitlines()[0]
    assert 'AbstractUISubtitleControls::ShowSubtitle' not in show
    ordered(show, 'IL_0001: brtrue.s IL_0004', 'IL_0003: ret', '::GetPanel(', '::SubtitleUsesBarkUI(',
            '::BarkString(', 'IL_0044:', 'UnityEngine.Object::op_Equality', 'IL_0073:',
            'System.String::IsNullOrEmpty', '::HideSubtitle(', '::m_lastPanelUsedByActor',
            '::m_focusedPanel', '::addSpeakerName', '::get_Name()', 'System.String::Format(',
            'FormattedText::set_text', '::setSubtitleColor', '::AdjustSubtitleColor(',
            'StandardUISubtitlePanel::ShowSubtitle(', '::SupercedeOtherPanels(')
    abstract = method(texts['abstract-subtitle-show.il'], 'ShowSubtitle')
    ordered(abstract, 'System.String::IsNullOrEmpty', '::currentSubtitle', '::SetSubtitle(', 'AbstractUIControls::Show()')

    selection = texts['subtitle-controls-selection.il']
    panel = method(selection, 'GetPanel')
    ordered(panel, 'IL_0003: ldarg.1', '::m_defaultNPCPanel', '::m_forcedOverridePanel',
            '::get_subtitlePanelNumber()', 'IL_002e: ldc.i4.0', 'IL_0030: bgt.s IL_005e',
            '::m_builtinPanels', '::get_Count()', 'IL_003e: bge.s IL_005e',
            '::set_actorOverridingPanel(', '::m_actorIdOverridePanel', '::set_actorOverridingPanel(',
            '::get_isNPC()', '::m_defaultPCPanel', '::m_defaultNPCPanel', '::GetActorTransformPanel(')
    transform = method(selection, 'GetActorTransformPanel')
    ordered(transform, 'UnityEngine.Object::op_Equality', 'IL_000c: ldarg.2', 'IL_000d: ret',
            '::m_dialogueActorCache', '::GetDialogueActorComponent(', '::m_actorPanelCache',
            '::m_useBarkUIs', '::DialogueActorUsesBarkUI(', '::GetDialogueActorPanel(',
            'IL_0097: ldarg.2', '::m_actorPanelCache', '::Add(')
    actor = method(selection, 'GetDialogueActorPanel')
    ordered(actor, '::subtitlePanelNumber', '::customSubtitlePanel', '::GetPanelFromNumber(')
    number = method(selection, 'GetPanelFromNumber')
    ordered(number, 'switch IL_0014,IL_0032,IL_0016', '::m_customPanels', '::GetSubtitlePanelIndex(',
            'IL_003d: bgt.s IL_004d', '::get_Count()', 'IL_004b: blt.s IL_004f')
    enum = texts['subtitle-panel-number.il']
    for name, value in [('Default', 0), ('UseBarkUI', 1), ('Custom', 2), ('Panel0', 3)]:
        assert f'::{name} = {value}\n' in enum

    controls_init = method(texts['subtitle-controls-initialize.il'], 'Initialize')
    ordered(controls_init, '::Clear()', '::AddRange(', '::m_defaultNPCPanel', '::m_defaultPCPanel',
            '::set_isDefaultNPCPanel(', '::set_isDefaultPCPanel(', '::set_panelNumber(', '::ClearCache()')
    assert 'BASE PixelCrushers.DialogueSystem.StandardUISubtitlePanel' in texts['panel-wrapper-fields.il']
    wrapper = texts['panel-wrapper-list.il'].splitlines()
    assert len(wrapper) == 1 and '::.ctor()' in wrapper[0]
    assert 'FIELD PixelCrushers.UITextField PixelCrushers.DialogueSystem.StandardUISubtitlePanel::subtitleText' in texts['panel-fields.il']
    panel_show = method(texts['panel-show.il'], 'ShowSubtitle')
    ordered(panel_show, '::waitForClose', '::AreAnyPanelsClosing()', '::ShowSubtitleAfterClosing(',
            '::StartCoroutine(', '::ShowSubtitleNow(')
    now = method(texts['panel-show-now.il'], 'ShowSubtitleNow')
    ordered(now, '::SetUIElementsActive(', 'UIPanel::Open()', '::Focus()', '::SetContent(', '::set_actorOverridingPanel(')

    assertions = [
        'Getter returns stored controls; constructor creates exact StandardUISubtitleControls; Initialize passes serialized panels/defaults.',
        'StandardUISubtitleControls overrides abstract ShowSubtitle; abstract empty-text/currentSubtitle behavior is not substituted for this override.',
        'Selection precedence: null GetPanel input, forced panel, valid zero-based formatted panel index, actor-ID override, Transform/PC-NPC route.',
        'Transform route checks DialogueActor and panel caches, then bark UI, actor custom/numbered panel and default; caches/live Unity equality remain unexecuted.',
        'ShowSubtitle selects panel before Bark UI/null/empty-text guards; sender-name/color mutation precedes panel dispatch.',
        'Wrapper panel declares constructor only; base dispatch can defer via coroutine, then activates/opens/focuses before virtual SetContent.',
        'Original3633 subtitleText is UITextField with legacy null and exact TMP4571; content setter, fonts/effects/native delivery remain next dependencies.'
    ]
    result = dict(status='passed-static-scoped', reproducedMetadataSelections=len(rows),
                  methodBodies=sum(t.count('\nMETHOD ') for t in texts.values()),
                  regressionAssertions=assertions, noMocks=True, gameAssemblyExecuted=False,
                  gameLaunches=0, imagesOpened=0, gitMutations=0, sourceAcceptance='needs-review',
                  runtime='not-run', visual='not-run', editorial='not-run', delivery='needs-review', usage=None)
    (out / 'verification.json').write_text(json.dumps(result, indent=2) + '\n')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    out = parser.parse_args().output.resolve()
    assert HERE in out.parents and not out.exists()
    out.mkdir()
    verify(out)
