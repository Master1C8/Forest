TYPE TheForestOfLove.GeneralStoryUIController
METHOD System.Void TheForestOfLove.GeneralStoryUIController::OnConversationLine_Handler(TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0006: brfalse.s IL_001a
IL_0008: ldarg.2
IL_0009: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_000e: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_0013: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0018: brfalse.s IL_0050
IL_001a: ldarg.2
IL_001b: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0020: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0025: brtrue.s IL_0039
IL_0027: ldarg.2
IL_0028: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_002d: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_0032: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0037: brfalse.s IL_004f
IL_0039: ldarg.0
IL_003a: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.GeneralStoryUIController::onDialogueEmptyWithTitledLine
IL_003f: ldarg.2
IL_0040: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0045: callvirt System.String PixelCrushers.DialogueSystem.DialogueEntry::get_Title()
IL_004a: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::Invoke(!0)
IL_004f: ret
IL_0050: ldarg.0
IL_0051: ldfld TheForestOfLove.Events.StringPrimitiveEvent TheForestOfLove.GeneralStoryUIController::onDialogueLine
IL_0056: ldarg.2
IL_0057: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_005c: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_0061: callvirt System.Void UnityEngine.Events.UnityEvent`1<System.String>::Invoke(!0)
IL_0066: ret
