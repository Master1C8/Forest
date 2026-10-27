TYPE TheForestOfLove.Narrative.DialogueService
METHOD System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationLineBegin(PixelCrushers.DialogueSystem.Subtitle) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: call System.Void TheForestOfLove.Narrative.DialogueService::HandleDialogueLineTriggering(PixelCrushers.DialogueSystem.Subtitle)
IL_0007: ldarg.0
IL_0008: ldarg.1
IL_0009: call System.Void TheForestOfLove.Narrative.DialogueService::HandleDialogueLineActor(PixelCrushers.DialogueSystem.Subtitle)
IL_000e: ret
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
