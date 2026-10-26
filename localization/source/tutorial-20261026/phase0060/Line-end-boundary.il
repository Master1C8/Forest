TYPE TheForestOfLove.Narrative.DialogueService
METHOD System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationStart(UnityEngine.Transform) | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.1
IL_0001: call System.Void TheForestOfLove.Narrative.DialogueService::set_IsDialoguePlaying(System.Boolean)
IL_0006: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueStart
IL_000b: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_0010: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::Invoke(!0)
IL_0015: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueStart
IL_001a: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_001f: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationEnd(UnityEngine.Transform) | attributes=Private, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: call System.Void TheForestOfLove.Narrative.DialogueService::set_IsDialoguePlaying(System.Boolean)
IL_0006: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueFinish
IL_000b: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_0010: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::Invoke(!0)
IL_0015: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueEndFinishOrCancel
IL_001a: call TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.DialogueService::get_CurrentDialogue()
IL_001f: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::Invoke(!0)
IL_0024: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onDialogueEnd
IL_0029: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_002e: ldarg.0
IL_002f: call System.Void TheForestOfLove.Narrative.DialogueService::Initialize()
IL_0034: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationLineBegin(PixelCrushers.DialogueSystem.Subtitle) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call System.Void TheForestOfLove.Narrative.DialogueService::HandleDialogueLineTriggering(PixelCrushers.DialogueSystem.Subtitle)
IL_0007: ldarg.0
IL_0008: ldarg.1
IL_0009: call System.Void TheForestOfLove.Narrative.DialogueService::HandleDialogueLineActor(PixelCrushers.DialogueSystem.Subtitle)
IL_000e: ret
METHOD System.Void TheForestOfLove.Narrative.DialogueService::OnConversationLine_Handler(PixelCrushers.DialogueSystem.Subtitle) | attributes=Private, HideBySig | impl=IL
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
METHOD System.Boolean TheForestOfLove.Narrative.DialogueService::CheckIfActorChanged(TheForestOfLove.Narrative.Actor) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: brfalse.s IL_0034
IL_0003: ldarg.1
IL_0004: ldfld PixelCrushers.DialogueSystem.Actor TheForestOfLove.Narrative.Actor::pluginDbActor
IL_0009: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_000e: ldarg.0
IL_000f: ldfld System.Int32 TheForestOfLove.Narrative.DialogueService::lastCurrentLineDialogueDbConversantId
IL_0014: beq.s IL_0034
IL_0016: ldarg.0
IL_0017: ldarg.1
IL_0018: ldfld PixelCrushers.DialogueSystem.Actor TheForestOfLove.Narrative.Actor::pluginDbActor
IL_001d: ldfld System.Int32 PixelCrushers.DialogueSystem.Asset::id
IL_0022: stfld System.Int32 TheForestOfLove.Narrative.DialogueService::lastCurrentLineDialogueDbConversantId
IL_0027: ldsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DialogueService::onConversationLineCurrentActorChanged
IL_002c: ldarg.1
IL_002d: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Actor>::Invoke(!0)
IL_0032: ldc.i4.1
IL_0033: ret
IL_0034: ldc.i4.0
IL_0035: ret
