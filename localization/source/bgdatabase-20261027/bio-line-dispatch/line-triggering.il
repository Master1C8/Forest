TYPE TheForestOfLove.Narrative.DialogueService
METHOD System.Void TheForestOfLove.Narrative.DialogueService::HandleDialogueLineTriggering(PixelCrushers.DialogueSystem.Subtitle) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0006: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_000b: ldarg.1
IL_000c: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0011: brfalse.s IL_002a
IL_0013: ldarg.1
IL_0014: ldfld System.String PixelCrushers.DialogueSystem.Subtitle::sequence
IL_0019: callvirt System.String System.String::ToLower()
IL_001e: ldstr "none"
IL_0023: callvirt System.Boolean System.String::Contains(System.String)
IL_0028: br.s IL_002b
IL_002a: ldc.i4.0
IL_002b: stloc.0
IL_002c: ldc.i4.0
IL_002d: ble.s IL_0053
IL_002f: ldloc.0
IL_0030: brtrue.s IL_0053
IL_0032: ldarg.1
IL_0033: ldfld PixelCrushers.DialogueSystem.DialogueEntry PixelCrushers.DialogueSystem.Subtitle::dialogueEntry
IL_0038: callvirt System.Int32 PixelCrushers.DialogueSystem.DialogueEntry::get_ActorID()
IL_003d: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByPluginDbId(System.Int32)
IL_0042: stloc.1
IL_0043: ldarg.0
IL_0044: ldloc.1
IL_0045: call System.Boolean TheForestOfLove.Narrative.DialogueService::CheckIfActorChanged(TheForestOfLove.Narrative.Actor)
IL_004a: brfalse.s IL_0053
IL_004c: ldarg.0
IL_004d: ldc.i4.1
IL_004e: stfld System.Boolean TheForestOfLove.Narrative.DialogueService::encounteredSpokenLineInCurrentDialogue
IL_0053: ldarg.0
IL_0054: ldfld System.Boolean TheForestOfLove.Narrative.DialogueService::encounteredSpokenLineInCurrentDialogue
IL_0059: brtrue.s IL_0062
IL_005b: ldarg.0
IL_005c: ldarg.1
IL_005d: call System.Void TheForestOfLove.Narrative.DialogueService::Handler_OnConversationLineEnd(PixelCrushers.DialogueSystem.Subtitle)
IL_0062: ret
