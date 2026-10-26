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
METHOD System.Void TheForestOfLove.Narrative.DialogueService::.cctor()
IL_0000: newobj System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_0005: stsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueStart
IL_000a: newobj System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_000f: stsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onLinkedDialogueStart
IL_0014: newobj System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_0019: stsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueFinish
IL_001e: newobj System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_0023: stsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueCancel
IL_0028: newobj System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue>::.ctor()
IL_002d: stsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::onDialogueEndFinishOrCancel
IL_0032: newobj System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String>::.ctor()
IL_0037: stsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBegin
IL_003c: newobj System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle>::.ctor()
IL_0041: stsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginDetailed
IL_0046: newobj System.Void UnityEngine.Events.UnityEvent`1<System.String>::.ctor()
IL_004b: stsfld UnityEngine.Events.UnityEvent`1<System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBegin_AnyPassthruTitledLine
IL_0050: newobj System.Void UnityEngine.Events.UnityEvent`1<System.String>::.ctor()
IL_0055: stsfld UnityEngine.Events.UnityEvent`1<System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBegin_AnyTextLine
IL_005a: newobj System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String>::.ctor()
IL_005f: stsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginPlayer
IL_0064: newobj System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String>::.ctor()
IL_0069: stsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginNarrator
IL_006e: newobj System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String>::.ctor()
IL_0073: stsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineBeginNpc
IL_0078: newobj System.Void UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32>::.ctor()
IL_007d: stsfld UnityEngine.Events.UnityEvent`4<TheForestOfLove.Narrative.Dialogue,TheForestOfLove.Narrative.Arc,System.Int32,System.Int32> TheForestOfLove.Narrative.DialogueService::onDialogueLineArcTriggerCheck
IL_0082: newobj System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String>::.ctor()
IL_0087: stsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,System.String> TheForestOfLove.Narrative.DialogueService::onDialogueLineEnd
IL_008c: newobj System.Void UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle>::.ctor()
IL_0091: stsfld UnityEngine.Events.UnityEvent`2<TheForestOfLove.Narrative.Actor,PixelCrushers.DialogueSystem.Subtitle> TheForestOfLove.Narrative.DialogueService::onDialogueLineEndDetailed
IL_0096: newobj System.Void UnityEngine.Events.UnityEvent`1<System.Collections.Generic.IEnumerable`1<System.String>>::.ctor()
IL_009b: stsfld UnityEngine.Events.UnityEvent`1<System.Collections.Generic.IEnumerable`1<System.String>> TheForestOfLove.Narrative.DialogueService::onDialogueResponseMenu
IL_00a0: newobj System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Actor>::.ctor()
IL_00a5: stsfld UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Actor> TheForestOfLove.Narrative.DialogueService::onConversationLineCurrentActorChanged
IL_00aa: ret
