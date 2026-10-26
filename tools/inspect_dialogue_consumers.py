#!/usr/bin/env python3
"""Preserve bounded original dialogue-consumer evidence without running the game."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]
ORIGINAL = Path('/Volumes/KINGSTONMAC/CrossOver/Bottles/Steam/drive_c/forest')
DATA = 'The Forest of Love_Data/Managed/'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    output = parser.parse_args().output.resolve()
    assert output.parent == ROOT / 'localization/source' and not output.exists()
    original_hashes = json.loads((ROOT / 'localization/probes/ru-20261026-39/original-game-files.json').read_text())
    inspector = ROOT / 'tools/probe/bin/Debug/net8.0/InspectMethods.dll'
    dependencies = [Path(__file__), inspector, ROOT / 'tools/probe/InspectMethods.cs',
                    ROOT / 'localization/source/dialogue-candidates.jsonl',
                    ROOT / 'localization/source/dialogue-manifest.json']
    assemblies = {name: ORIGINAL / (DATA + name) for name in
                  ['Auto-asmdef-FirstPass.dll', 'Assembly-CSharp.dll']}
    for name, path in assemblies.items():
        assert sha(path) == original_hashes[DATA + name], 'Original assembly identity changed'
    dependencies += list(assemblies.values())
    before = {str(p): sha(p) for p in dependencies}
    selections = [
        ('DialogueEntry', 'Auto-asmdef-FirstPass.dll', 'PixelCrushers.DialogueSystem.DialogueEntry',
         'GetCurrentDialogueTextField,get_currentDialogueText,get_subtitleText,get_responseButtonText,get_currentSequence'),
        ('ConversationModel', 'Auto-asmdef-FirstPass.dll', 'PixelCrushers.DialogueSystem.ConversationModel',
         'GetState,EvaluateLinksAtPriority,GetLinkText,CheckSequenceField'),
        ('ConversationView', 'Auto-asmdef-FirstPass.dll', 'PixelCrushers.DialogueSystem.ConversationView',
         'StartSubtitle,ShouldShowSubtitle,GetDefaultSequence,PreprocessSequence,StartResponses'),
        ('FormattedText', 'Auto-asmdef-FirstPass.dll', 'PixelCrushers.DialogueSystem.FormattedText',
         'Parse,ReplaceLuaTags,ReplaceVarTags,ReplaceAutocaseTags,ExtractVariableInputPrompt,ExtractPositionTag,ExtractPanelNumberTag,ExtractPicTag,ExtractEmphasisTags,ReplaceEmphasisTagsWithRichText'),
        ('SubtitlePanel', 'Auto-asmdef-FirstPass.dll', 'PixelCrushers.DialogueSystem.StandardUISubtitlePanel',
         'SetContent,SetFormattedText'),
        ('DialogueService', 'Assembly-CSharp.dll', 'TheForestOfLove.Narrative.DialogueService',
         'Handler_OnConversationLineBegin,HandleDialogueLineTriggering,HandleDialogueLineActor'),
        ('Nameplate', 'Assembly-CSharp.dll', 'TheForestOfLove.DialogueNameplateController',
         'OnConversationLine_Handler,SetFontToMouse'),
    ]
    outputs, commands = {}, {}
    for name, assembly, typename, methods in selections:
        argv = ['dotnet', str(inspector), str(assemblies[assembly]), typename, methods]
        result = subprocess.run(argv, capture_output=True, text=True, timeout=30, check=True)
        assert result.stdout.startswith('TYPE ' + typename + '\n')
        outputs[name + '.il'] = result.stdout
        commands[name + '.il'] = argv
    assert 'get_currentDialogueText()' in outputs['DialogueEntry.il']
    assert all(token in outputs['ConversationView.il'] for token in
               ['get_noSubtitle()', '"None()"', '"Continue()"'])
    assert 'System.String::EndsWith' not in outputs['DialogueEntry.il']
    assert before == {str(p): sha(p) for p in dependencies}, 'Evidence dependency changed during extraction'
    output.mkdir()
    for name, data in outputs.items():
        (output / name).write_text(data)
    findings = {
        'status': 'bounded-static-consumer-evidence; not complete source or runtime acceptance',
        'inputs': before, 'commands': commands,
        'findings': [
            'DialogueEntry.subtitleText uses current Dialogue Text if nonempty, otherwise Menu Text. Response buttons use Menu Text first, then Dialogue Text.',
            'The subtitle visibility consumer checks noSubtitle, exact None()/None();/Continue()/Continue(); sequences, speaker type and display settings. Colon endings and uppercase alone are not exclusion rules.',
            'Actual conversation state/links, effective sequences and game callbacks must be traced for each held occurrence before asserting visibility or nonvisibility.',
            'FormattedText.Parse recognizes concrete tag families and does not treat every square-bracketed phrase as an opaque command. Ordinary bracketed narration requires display-span validation.',
        ],
        'limits': 'No candidate ID removed, target changed, symbol decoded, source disposition accepted or model semantic audit credited. No game launch.',
        'artifacts': {name: sha(output / name) for name in outputs},
    }
    (output / 'verification.json').write_text(json.dumps(findings, indent=2) + '\n')
    print(json.dumps({'status': findings['status'], 'output': str(output), 'methodsFiles': len(outputs)}))


if __name__ == '__main__':
    main()
