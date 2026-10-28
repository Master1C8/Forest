TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFastTravel
METHOD System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFastTravel::get_triggerFilters() | attributes=Public, Virtual, HideBySig, SpecialName | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.HashSet`1<System.String>::.ctor()
IL_0005: dup
IL_0006: ldstr "System_DynamicFastTravel"
IL_000b: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0010: pop
IL_0011: dup
IL_0012: ldstr "Examinables_FastTravelPerch_NoBell"
IL_0017: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_001c: pop
IL_001d: dup
IL_001e: ldstr "Examinables_FastTravelPerch_WithBell"
IL_0023: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0028: pop
IL_0029: dup
IL_002a: ldstr "BridgeQuest_MeetBirdAndFastTravel"
IL_002f: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0034: pop
IL_0035: ret
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFastTravel::ExecuteTrigger(System.String) | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldstr "ring_fast_travel_bell"
IL_0006: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_000b: brfalse.s IL_0028
IL_000d: ldarg.0
IL_000e: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0013: brtrue.s IL_001d
IL_0015: ldarg.0
IL_0016: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_001b: brfalse.s IL_001e
IL_001d: ret
IL_001e: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Gameplay.FastTravelController>()
IL_0023: callvirt System.Void TheForestOfLove.Gameplay.FastTravelController::PlayerRingsBell()
IL_0028: ldarg.1
IL_0029: ldstr "begin_first_fast_travel"
IL_002e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0033: brfalse.s IL_0055
IL_0035: ldarg.0
IL_0036: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_003b: brtrue.s IL_0045
IL_003d: ldarg.0
IL_003e: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0043: brfalse.s IL_0046
IL_0045: ret
IL_0046: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Gameplay.FastTravelController>()
IL_004b: ldstr "CentralForest"
IL_0050: callvirt System.Void TheForestOfLove.Gameplay.FastTravelController::PlayerInitiatesFastTravel(System.String)
IL_0055: ldarg.1
IL_0056: ldstr "fast_travel_to_central_forest"
IL_005b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0060: brfalse.s IL_008a
IL_0062: ldarg.0
IL_0063: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_0068: brtrue.s IL_007a
IL_006a: ldarg.0
IL_006b: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0070: brtrue.s IL_007a
IL_0072: ldarg.0
IL_0073: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0078: brfalse.s IL_007b
IL_007a: ret
IL_007b: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Gameplay.FastTravelController>()
IL_0080: ldstr "CentralForest"
IL_0085: callvirt System.Void TheForestOfLove.Gameplay.FastTravelController::PlayerInitiatesFastTravel(System.String)
IL_008a: ldarg.1
IL_008b: ldstr "fast_travel_to_lake"
IL_0090: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0095: brfalse.s IL_00bf
IL_0097: ldarg.0
IL_0098: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_009d: brtrue.s IL_00af
IL_009f: ldarg.0
IL_00a0: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_00a5: brtrue.s IL_00af
IL_00a7: ldarg.0
IL_00a8: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_00ad: brfalse.s IL_00b0
IL_00af: ret
IL_00b0: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Gameplay.FastTravelController>()
IL_00b5: ldstr "Lake"
IL_00ba: callvirt System.Void TheForestOfLove.Gameplay.FastTravelController::PlayerInitiatesFastTravel(System.String)
IL_00bf: ldarg.1
IL_00c0: ldstr "fast_travel_to_plains"
IL_00c5: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00ca: brfalse.s IL_00f4
IL_00cc: ldarg.0
IL_00cd: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_00d2: brtrue.s IL_00e4
IL_00d4: ldarg.0
IL_00d5: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_00da: brtrue.s IL_00e4
IL_00dc: ldarg.0
IL_00dd: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_00e2: brfalse.s IL_00e5
IL_00e4: ret
IL_00e5: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Gameplay.FastTravelController>()
IL_00ea: ldstr "Plains_End"
IL_00ef: callvirt System.Void TheForestOfLove.Gameplay.FastTravelController::PlayerInitiatesFastTravel(System.String)
IL_00f4: ldarg.1
IL_00f5: ldstr "fast_travel_to_mountains"
IL_00fa: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00ff: brfalse.s IL_0129
IL_0101: ldarg.0
IL_0102: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_0107: brtrue.s IL_0119
IL_0109: ldarg.0
IL_010a: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_010f: brtrue.s IL_0119
IL_0111: ldarg.0
IL_0112: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0117: brfalse.s IL_011a
IL_0119: ret
IL_011a: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Gameplay.FastTravelController>()
IL_011f: ldstr "Mountains"
IL_0124: callvirt System.Void TheForestOfLove.Gameplay.FastTravelController::PlayerInitiatesFastTravel(System.String)
IL_0129: ldarg.1
IL_012a: ldstr "fast_travel_to_deep_woods"
IL_012f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0134: brfalse.s IL_015e
IL_0136: ldarg.0
IL_0137: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_013c: brtrue.s IL_014e
IL_013e: ldarg.0
IL_013f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0144: brtrue.s IL_014e
IL_0146: ldarg.0
IL_0147: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_014c: brfalse.s IL_014f
IL_014e: ret
IL_014f: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Gameplay.FastTravelController>()
IL_0154: ldstr "DeepWoods_TreeArch"
IL_0159: callvirt System.Void TheForestOfLove.Gameplay.FastTravelController::PlayerInitiatesFastTravel(System.String)
IL_015e: ldarg.1
IL_015f: ldstr "cancel_fast_travel"
IL_0164: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0169: brfalse.s IL_0186
IL_016b: ldarg.0
IL_016c: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0171: brtrue.s IL_017b
IL_0173: ldarg.0
IL_0174: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0179: brfalse.s IL_017c
IL_017b: ret
IL_017c: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Gameplay.FastTravelController>()
IL_0181: callvirt System.Void TheForestOfLove.Gameplay.FastTravelController::PlayerCancelsFastTravel()
IL_0186: ret
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFastTravel::OnFastTravelFirstIdleConvo() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldstr "fast_travel_current_idle_convo"
IL_0005: ldstr "1"
IL_000a: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_000f: ret
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFastTravel::OnFastTravelLaterIdleConvos() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldstr "fast_travel_current_idle_convo"
IL_0005: call System.String TheForestOfLove.Services.Persistence.DataService::GetVariable(System.String)
IL_000a: stloc.0
IL_000b: ldloc.0
IL_000c: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_0011: brfalse.s IL_0024
IL_0013: ldstr "1"
IL_0018: stloc.0
IL_0019: ldstr "fast_travel_current_idle_convo"
IL_001e: ldloc.0
IL_001f: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_0024: ldloc.0
IL_0025: call System.Int32 System.Int32::Parse(System.String)
IL_002a: stloc.1
IL_002b: call System.Boolean TheForestOfLove.QuestTriggerHelper::FinishedAct1()
IL_0030: brfalse.s IL_0038
IL_0032: ldloc.1
IL_0033: ldc.i4.4
IL_0034: bge.s IL_0038
IL_0036: ldc.i4.4
IL_0037: stloc.1
IL_0038: call System.Boolean TheForestOfLove.QuestTriggerHelper::FinishedAct2()
IL_003d: brtrue.s IL_0042
IL_003f: ldc.i4.6
IL_0040: br.s IL_0043
IL_0042: ldc.i4.7
IL_0043: stloc.2
IL_0044: ldloc.1
IL_0045: ldloc.2
IL_0046: blt.s IL_004a
IL_0048: ldc.i4.4
IL_0049: stloc.1
IL_004a: ldstr "fast_travel_current_idle_convo"
IL_004f: ldloc.1
IL_0050: ldc.i4.1
IL_0051: add
IL_0052: dup
IL_0053: stloc.1
IL_0054: stloc.3
IL_0055: ldloca.s V_3
IL_0057: call System.String System.Int32::ToString()
IL_005c: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_0061: ret
