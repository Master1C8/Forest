TYPE TheForestOfLove.FastTravelPerch
METHOD System.Void TheForestOfLove.FastTravelPerch::SetupPerchInteraction() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Gameplay.DynamicConversationCustomTrigger TheForestOfLove.FastTravelPerch::dynamicConversationCustomTrigger
IL_0006: ldstr "BridgeQuest_MeetBirdAndFastTravel"
IL_000b: stfld System.String TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::targetConversationName
IL_0010: ldarg.0
IL_0011: ldfld TheForestOfLove.Gameplay.DynamicConversationCustomTrigger TheForestOfLove.FastTravelPerch::dynamicConversationCustomTrigger
IL_0016: ldstr "Penny"
IL_001b: stfld System.String TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::targetActorName
IL_0020: ldarg.0
IL_0021: ldfld TheForestOfLove.Gameplay.DynamicConversationCustomTrigger TheForestOfLove.FastTravelPerch::dynamicConversationCustomTrigger
IL_0026: ldstr "Narrator"
IL_002b: stfld System.String TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::preferredConversantName
IL_0030: ldarg.0
IL_0031: ldfld TheForestOfLove.Gameplay.DynamicConversationCustomTrigger TheForestOfLove.FastTravelPerch::dynamicConversationCustomTrigger
IL_0036: ldfld System.String TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::targetDialogueArcName
IL_003b: ldstr "penny_busy_with_date"
IL_0040: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0045: brfalse.s IL_009c
IL_0047: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inPlainsEnd()
IL_004c: brfalse.s IL_0072
IL_004e: ldarg.0
IL_004f: ldfld TheForestOfLove.Gameplay.DynamicConversationCustomTrigger TheForestOfLove.FastTravelPerch::dynamicConversationCustomTrigger
IL_0054: ldc.i4 210
IL_0059: call System.Boolean TheForestOfLove.Narrative.NarrativeActions::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_005e: brtrue.s IL_0067
IL_0060: ldstr "examine_the_perch"
IL_0065: br.s IL_006c
IL_0067: ldstr "ring_the_bell"
IL_006c: stfld System.String TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::targetDialogueArcName
IL_0071: ret
IL_0072: ldarg.0
IL_0073: ldfld TheForestOfLove.Gameplay.DynamicConversationCustomTrigger TheForestOfLove.FastTravelPerch::dynamicConversationCustomTrigger
IL_0078: ldc.i4 180
IL_007d: call System.Boolean TheForestOfLove.Narrative.NarrativeActions::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0082: brfalse.s IL_008b
IL_0084: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inMountains()
IL_0089: brfalse.s IL_0092
IL_008b: ldstr "examine_the_perch"
IL_0090: br.s IL_0097
IL_0092: ldstr "ring_the_bell"
IL_0097: stfld System.String TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::targetDialogueArcName
IL_009c: ret
METHOD System.Void TheForestOfLove.FastTravelPerch::DisablePerchInteractDuringDate() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TheForestOfLove.Gameplay.DynamicConversationCustomTrigger TheForestOfLove.FastTravelPerch::dynamicConversationCustomTrigger
IL_0006: ldstr "penny_busy_with_date"
IL_000b: stfld System.String TheForestOfLove.Gameplay.DynamicConversationCustomTrigger::targetDialogueArcName
IL_0010: ret
