TYPE TheForestOfLove.Gameplay.FastTravelController
METHOD System.String TheForestOfLove.Gameplay.FastTravelController::get_NextFastTravelCustomGreetingText() | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldfld System.String TheForestOfLove.Gameplay.FastTravelController::<NextFastTravelCustomGreetingText>k__BackingField
IL_0006: ret
METHOD System.Void TheForestOfLove.Gameplay.FastTravelController::set_NextFastTravelCustomGreetingText(System.String) | attributes=Public, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.String TheForestOfLove.Gameplay.FastTravelController::<NextFastTravelCustomGreetingText>k__BackingField
IL_0007: ret
METHOD System.Collections.Generic.List`1<System.String> TheForestOfLove.Gameplay.FastTravelController::GetDynamicFastTravelDestinationSceneNames() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Gameplay.FastTravelController::dynamicFastTravelDestinationSceneNamesCache
IL_0006: callvirt System.Void System.Collections.Generic.List`1<System.String>::Clear()
IL_000b: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inLake()
IL_0010: brfalse.s IL_0025
IL_0012: call System.Boolean TheForestOfLove.QuestTriggerHelper::ReachedAct2()
IL_0017: brtrue.s IL_0025
IL_0019: ldstr "BridgeQuest_DeliverToyToOtter"
IL_001e: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0023: br.s IL_0026
IL_0025: ldc.i4.0
IL_0026: stloc.0
IL_0027: ldc.i4 190
IL_002c: call System.Boolean TheForestOfLove.Narrative.NarrativeActions::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0031: ldloc.0
IL_0032: or
IL_0033: brfalse.s IL_0045
IL_0035: ldarg.0
IL_0036: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Gameplay.FastTravelController::dynamicFastTravelDestinationSceneNamesCache
IL_003b: ldstr "CentralForest"
IL_0040: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0045: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inCentralForest()
IL_004a: brfalse.s IL_0062
IL_004c: call System.Boolean TheForestOfLove.QuestTriggerHelper::ReachedAct2()
IL_0051: brtrue.s IL_0062
IL_0053: ldstr "BridgeQuest_DeliverToyToOtter"
IL_0058: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_005d: ldc.i4.0
IL_005e: ceq
IL_0060: br.s IL_0063
IL_0062: ldc.i4.0
IL_0063: stloc.1
IL_0064: ldc.i4 180
IL_0069: call System.Boolean TheForestOfLove.Narrative.NarrativeActions::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_006e: brfalse.s IL_0083
IL_0070: ldloc.1
IL_0071: brtrue.s IL_0083
IL_0073: ldarg.0
IL_0074: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Gameplay.FastTravelController::dynamicFastTravelDestinationSceneNamesCache
IL_0079: ldstr "Lake"
IL_007e: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_0083: ldc.i4 210
IL_0088: call System.Boolean TheForestOfLove.Narrative.NarrativeActions::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_008d: brfalse.s IL_009f
IL_008f: ldarg.0
IL_0090: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Gameplay.FastTravelController::dynamicFastTravelDestinationSceneNamesCache
IL_0095: ldstr "Plains_End"
IL_009a: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_009f: ldc.i4 200
IL_00a4: call System.Boolean TheForestOfLove.Narrative.NarrativeActions::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_00a9: brfalse.s IL_00bb
IL_00ab: ldarg.0
IL_00ac: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Gameplay.FastTravelController::dynamicFastTravelDestinationSceneNamesCache
IL_00b1: ldstr "Mountains"
IL_00b6: callvirt System.Void System.Collections.Generic.List`1<System.String>::Add(!0)
IL_00bb: ldarg.0
IL_00bc: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Gameplay.FastTravelController::dynamicFastTravelDestinationSceneNamesCache
IL_00c1: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_00c6: callvirt System.Boolean System.Collections.Generic.List`1<System.String>::Remove(!0)
IL_00cb: pop
IL_00cc: ldarg.0
IL_00cd: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Gameplay.FastTravelController::dynamicFastTravelDestinationSceneNamesCache
IL_00d2: callvirt System.Int32 System.Collections.Generic.List`1<System.String>::get_Count()
IL_00d7: brfalse.s IL_00dc
IL_00d9: ldc.i4.0
IL_00da: br.s IL_00dd
IL_00dc: ldc.i4.1
IL_00dd: stloc.2
IL_00de: ldarg.0
IL_00df: call System.String TheForestOfLove.Gameplay.FastTravelController::get_NextFastTravelCustomGreetingText()
IL_00e4: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_00e9: brtrue.s IL_00ed
IL_00eb: ldc.i4.2
IL_00ec: stloc.2
IL_00ed: ldarg.0
IL_00ee: call System.Boolean TheForestOfLove.Gameplay.FastTravelController::get_NextFastTravelDisableGreeting()
IL_00f3: brfalse.s IL_00f7
IL_00f5: ldc.i4.3
IL_00f6: stloc.2
IL_00f7: ldarg.0
IL_00f8: ldnull
IL_00f9: call System.Void TheForestOfLove.Gameplay.FastTravelController::set_NextFastTravelCustomGreetingText(System.String)
IL_00fe: ldarg.0
IL_00ff: ldc.i4.0
IL_0100: call System.Void TheForestOfLove.Gameplay.FastTravelController::set_NextFastTravelDisableGreeting(System.Boolean)
IL_0105: ldloc.2
IL_0106: call System.Void TheForestOfLove.Narrative.DialogueService::SetDialogueSystemBranchCondition(System.Int32)
IL_010b: ldarg.0
IL_010c: ldfld System.Collections.Generic.List`1<System.String> TheForestOfLove.Gameplay.FastTravelController::dynamicFastTravelDestinationSceneNamesCache
IL_0111: ret
