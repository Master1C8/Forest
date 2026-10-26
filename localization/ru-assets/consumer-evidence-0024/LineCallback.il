TYPE TheForestOfLove.Narrative.DialogueService
METHOD System.Void TheForestOfLove.Narrative.DialogueService::OnConversationLine_Handler(PixelCrushers.DialogueSystem.Subtitle)
IL_0000: ldarg.1
IL_0001: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0006: brfalse.s IL_001a
IL_0008: ldarg.1
IL_0009: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_000e: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_0013: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0018: brfalse.s IL_004f
IL_001a: ldarg.1
IL_001b: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0020: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0025: brtrue.s IL_0039
IL_0027: ldarg.1
IL_0028: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_002d: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0032: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0037: brfalse.s IL_004e
IL_0039: ldsfld UnityEngine.Events.UnityEvent`1<System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBegin_AnyPassthruTitledLine
IL_003e: ldarg.1
IL_003f: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0044: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0049: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::Invoke(!0)
IL_004e: ret
IL_004f: ldsfld UnityEngine.Events.UnityEvent`1<System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBegin_AnyTextLine
IL_0054: dup
IL_0055: brtrue.s IL_0059
IL_0057: pop
IL_0058: ret
IL_0059: ldarg.1
IL_005a: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_005f: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_0064: call System.Void UnityEngine.Events.UnityEvent`1<System.String>::Invoke(!0)
IL_0069: ret
