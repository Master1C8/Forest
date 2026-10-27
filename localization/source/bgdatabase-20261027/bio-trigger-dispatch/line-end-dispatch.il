TYPE TheForestOfLove.Narrative.DialogueService
METHOD System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationLineEnd(PixelCrushers.DialogueSystem.Subtitle) | attributes=Private, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_0005: brtrue.s IL_0008
IL_0007: ret
IL_0008: ldarg.0
IL_0009: ldarg.1
IL_000a: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_000f: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::conversationID
IL_0014: ldarg.1
IL_0015: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_001a: ldfld System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::id
IL_001f: ldarg.1
IL_0020: ldfld PixelCrushers.DialogueSystem.FormattedText PixelCrushers.DialogueSystem.Subtitle::formattedText
IL_0025: callvirt System.String PixelCrushers.DialogueSystem.FormattedText::get_text()
IL_002a: call System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationLineEnd(System.Int32,System.Int32,System.String)
IL_002f: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationLineEnd(System.Int32,System.Int32,System.String) | attributes=Private, HideBySig | impl=IL
IL_0000: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_0005: brtrue.s IL_0008
IL_0007: ret
IL_0008: ldsfld UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32> TheForestOfLove.Narrative.DialogueService::onDialogueLineArcTriggerCheck
IL_000d: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_0012: call TheForestOfLove.Narrative.Arc TheForestOfLove.Narrative.DialogueService::get_CurrentArc()
IL_0017: ldarg.1
IL_0018: ldarg.2
IL_0019: callvirt System.Void UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32>::Invoke(!0,!1,!2,!3)
IL_001e: ldsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineEnd
IL_0023: call TheForestOfLove.Narrative.Actor TheForestOfLove.Narrative.DialogueService::get_CurrentActor()
IL_0028: ldarg.3
IL_0029: callvirt System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String>::Invoke(!0,!1)
IL_002e: ldc.i4.0
IL_002f: call System.Void TheForestOfLove.Narrative.DialogueService::set_IsPlayerResponseAvailable(System.Boolean)
IL_0034: ret
