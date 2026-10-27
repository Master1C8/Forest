TYPE TheForestOfLove.Narrative.DialogueService
METHOD System.Void TheForestOfLove.Narrative.DialogueService::Initialize() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Narrative.DialogueService::ResetDynamicConversation()
IL_0006: ldarg.0
IL_0007: ldfld PixelCrushers.DialogueSystem.DialogueSystemTrigger TheForestOfLove.Narrative.DialogueService::dialogueSystemTrigger
IL_000c: ldfld PixelCrushers.DialogueSystem.Condition PixelCrushers.DialogueSystem.DialogueSystemTrigger::condition
IL_0011: brfalse.s IL_002a
IL_0013: ldarg.0
IL_0014: ldfld PixelCrushers.DialogueSystem.DialogueSystemTrigger TheForestOfLove.Narrative.DialogueService::dialogueSystemTrigger
IL_0019: ldfld PixelCrushers.DialogueSystem.Condition PixelCrushers.DialogueSystem.DialogueSystemTrigger::condition
IL_001e: ldarg.0
IL_001f: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0024: callvirt System.Boolean PixelCrushers.DialogueSystem.Condition::IsTrue(UnityEngine.Transform)
IL_0029: pop
IL_002a: ldarg.0
IL_002b: ldfld PixelCrushers.DialogueSystem.DialogueSystemTrigger TheForestOfLove.Narrative.DialogueService::dialogueSystemTrigger
IL_0030: ldnull
IL_0031: stfld System.String PixelCrushers.DialogueSystem.DialogueSystemTrigger::conversation
IL_0036: ldarg.0
IL_0037: ldfld System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue> TheForestOfLove.Narrative.DialogueService::arcListCache
IL_003c: callvirt System.Void System.Collections.Generic.Dictionary`2<TheForestOfLove.Narrative.Arc,TheForestOfLove.Narrative.Dialogue>::Clear()
IL_0041: ldc.i4.0
IL_0042: call System.Void TheForestOfLove.Narrative.DialogueService::set_IsDialoguePlaying(System.Boolean)
IL_0047: ldc.i4.0
IL_0048: call System.Void TheForestOfLove.Narrative.DialogueService::set_IsPlayerQuestionDialoguePlaying(System.Boolean)
IL_004d: ldnull
IL_004e: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentDialogueDbName(System.String)
IL_0053: ldnull
IL_0054: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentDialogue(TheForestOfLove.Narrative.Dialogue)
IL_0059: ldnull
IL_005a: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentDialoguePluginDbName(System.String)
IL_005f: ldnull
IL_0060: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentArcName(System.String)
IL_0065: ldnull
IL_0066: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentArc(TheForestOfLove.Narrative.Arc)
IL_006b: ldnull
IL_006c: call System.Void TheForestOfLove.Narrative.DialogueService::set_PrimaryActor(TheForestOfLove.Narrative.Actor)
IL_0071: ldnull
IL_0072: call System.Void TheForestOfLove.Narrative.DialogueService::set_InitialActor(TheForestOfLove.Narrative.Actor)
IL_0077: ldnull
IL_0078: call System.Void TheForestOfLove.Narrative.DialogueService::set_CurrentActor(TheForestOfLove.Narrative.Actor)
IL_007d: ldarg.0
IL_007e: ldc.i4.0
IL_007f: stfld System.Boolean TheForestOfLove.Narrative.DialogueService::encounteredSpokenLineInCurrentDialogue
IL_0084: ldarg.0
IL_0085: ldc.i4.m1
IL_0086: stfld System.Int32 TheForestOfLove.Narrative.DialogueService::lastCurrentLineDialogueDbConversantId
IL_008b: ldarg.0
IL_008c: ldfld PixelCrushers.DialogueSystem.OverrideDialogueUI TheForestOfLove.Narrative.DialogueService::overrideDialogueUI
IL_0091: ldnull
IL_0092: stfld UnityEngine.GameObject PixelCrushers.DialogueSystem.OverrideDialogueUI::ui
IL_0097: ldc.i4.0
IL_0098: call System.Void TheForestOfLove.Narrative.DialogueService::set_IsPlayerResponseAvailable(System.Boolean)
IL_009d: ret
