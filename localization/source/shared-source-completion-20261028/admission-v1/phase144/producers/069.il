TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2
METHOD System.Collections.Generic.HashSet`1<System.String> TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2::get_triggerFilters() | attributes=Public, Virtual, HideBySig, SpecialName | impl=IL
IL_0000: newobj System.Void System.Collections.Generic.HashSet`1<System.String>::.ctor()
IL_0005: dup
IL_0006: ldstr "Act2_"
IL_000b: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0010: pop
IL_0011: dup
IL_0012: ldstr "CoyoteQuest_"
IL_0017: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_001c: pop
IL_001d: dup
IL_001e: ldstr "DeliveryQuest_"
IL_0023: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0028: pop
IL_0029: dup
IL_002a: ldstr "Act2Capstone_"
IL_002f: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0034: pop
IL_0035: dup
IL_0036: ldstr "DustinBattleground"
IL_003b: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0040: pop
IL_0041: dup
IL_0042: ldstr "OtterShop_InitialItems"
IL_0047: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_004c: pop
IL_004d: dup
IL_004e: ldstr "Idles_Act1_Donkey"
IL_0053: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0058: pop
IL_0059: dup
IL_005a: ldstr "Idles_Act2_Oliver"
IL_005f: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0064: pop
IL_0065: dup
IL_0066: ldstr "Idles_Act3_Oliver"
IL_006b: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0070: pop
IL_0071: dup
IL_0072: ldstr "Gossip_BunnyPeter_Cuck"
IL_0077: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_007c: pop
IL_007d: dup
IL_007e: ldstr "Movies_BunnyCuck_Dialogue"
IL_0083: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0088: pop
IL_0089: dup
IL_008a: ldstr "Misc_Act3_FishEncounter2"
IL_008f: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.String>::Add(!0)
IL_0094: pop
IL_0095: ret
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2::ExecuteTrigger(System.String) | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldstr "ready_to_ride"
IL_0006: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_000b: brfalse.s IL_0023
IL_000d: ldarg.0
IL_000e: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0013: brtrue.s IL_001d
IL_0015: ldarg.0
IL_0016: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_001b: brfalse.s IL_001e
IL_001d: ret
IL_001e: call System.Void TheForestOfLove.Content.PlainsFieldSpawner::SetupDonkeyRunAfterDeliveringApples()
IL_0023: ldarg.1
IL_0024: ldstr "ride_requested"
IL_0029: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_002e: brfalse.s IL_0046
IL_0030: ldarg.0
IL_0031: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0036: brtrue.s IL_0040
IL_0038: ldarg.0
IL_0039: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_003e: brfalse.s IL_0041
IL_0040: ret
IL_0041: call System.Void TheForestOfLove.DonkeyRunCutscene::PlayCutscene()
IL_0046: ldarg.1
IL_0047: ldstr "give_all_apples"
IL_004c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0051: brfalse.s IL_0093
IL_0053: ldarg.0
IL_0054: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0059: brtrue.s IL_0063
IL_005b: ldarg.0
IL_005c: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0061: brfalse.s IL_0077
IL_0063: ldc.i4.s 90
IL_0065: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_006a: ldc.i4.s 90
IL_006c: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0071: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2::OnPickedUpApple()
IL_0076: ret
IL_0077: ldc.i4.3
IL_0078: stloc.0
IL_0079: br.s IL_008a
IL_007b: ldc.i4.s 90
IL_007d: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0082: ldloc.0
IL_0083: dup
IL_0084: ldc.i4.1
IL_0085: sub
IL_0086: stloc.0
IL_0087: ldc.i4.0
IL_0088: ble.s IL_0093
IL_008a: ldc.i4.s 90
IL_008c: call System.Boolean TheForestOfLove.Narrative.NarrativeActions::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0091: brtrue.s IL_007b
IL_0093: ldarg.1
IL_0094: ldstr "coyotes_oral_unlock_scene"
IL_0099: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_009e: brfalse.s IL_00c7
IL_00a0: ldarg.0
IL_00a1: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_00a6: brtrue.s IL_00b0
IL_00a8: ldarg.0
IL_00a9: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_00ae: brfalse.s IL_00bb
IL_00b0: ldstr "Cutscene_CoyotesIntroduction"
IL_00b5: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_00ba: ret
IL_00bb: ldc.i4.5
IL_00bc: ldnull
IL_00bd: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_00c2: call System.Void TheForestOfLove.Content.PlainsEndSpawner::DisableOliverInteractions()
IL_00c7: ldarg.1
IL_00c8: ldstr "pan_to_ollie"
IL_00cd: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00d2: brfalse.s IL_00f2
IL_00d4: ldarg.0
IL_00d5: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_00da: brtrue.s IL_00ec
IL_00dc: ldarg.0
IL_00dd: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_00e2: brtrue.s IL_00ec
IL_00e4: ldarg.0
IL_00e5: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_00ea: brfalse.s IL_00ed
IL_00ec: ret
IL_00ed: call System.Void TheForestOfLove.CoyotesIntroductionCutscene::StartCameraPanToOliver()
IL_00f2: ldarg.1
IL_00f3: ldstr "pan_back_to_coyotes"
IL_00f8: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00fd: brfalse.s IL_0115
IL_00ff: ldarg.0
IL_0100: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0105: brtrue.s IL_010f
IL_0107: ldarg.0
IL_0108: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_010d: brfalse.s IL_0110
IL_010f: ret
IL_0110: call System.Void TheForestOfLove.CoyotesIntroductionCutscene::EndCameraPanToOliver()
IL_0115: ldarg.1
IL_0116: ldstr "get_plains_fast_travel_bell"
IL_011b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0120: brfalse.s IL_0161
IL_0122: ldc.i4 210
IL_0127: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_012c: ldstr "found_plains_fast_travel_bell"
IL_0131: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_0136: ldarg.0
IL_0137: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_013c: brtrue.s IL_0146
IL_013e: ldarg.0
IL_013f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0144: brfalse.s IL_0147
IL_0146: ret
IL_0147: call System.Void TheForestOfLove.Content.PlainsEndSpawner::RefreshFastTravelPerch()
IL_014c: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ItemGetNotification>()
IL_0151: stloc.1
IL_0152: ldloc.1
IL_0153: ldnull
IL_0154: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0159: brfalse.s IL_0161
IL_015b: ldloc.1
IL_015c: callvirt System.Void TheForestOfLove.ItemGetNotification::ShowPlainsBellNotification()
IL_0161: ldarg.1
IL_0162: ldstr "learn_about_the_sweater"
IL_0167: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_016c: brfalse.s IL_0184
IL_016e: ldarg.0
IL_016f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0174: brtrue.s IL_017e
IL_0176: ldarg.0
IL_0177: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_017c: brfalse.s IL_017f
IL_017e: ret
IL_017f: call System.Void TheForestOfLove.Content.PlainsEndSpawner::EnableOliverInteractions()
IL_0184: ldarg.1
IL_0185: ldstr "rang_plains_fast_travel_bell"
IL_018a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_018f: brfalse.s IL_01a7
IL_0191: ldarg.0
IL_0192: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0197: brtrue.s IL_01a1
IL_0199: ldarg.0
IL_019a: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_019f: brfalse.s IL_01a2
IL_01a1: ret
IL_01a2: call System.Void TheForestOfLove.Content.PlainsEndSpawner::DisableAct2FastTravelExitBlocker()
IL_01a7: ldarg.1
IL_01a8: ldstr "finished_otter_deliveries_intro"
IL_01ad: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01b2: pop
IL_01b3: ldarg.1
IL_01b4: ldstr "unlock_legends"
IL_01b9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01be: brfalse.s IL_01ea
IL_01c0: ldarg.0
IL_01c1: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_01c6: brtrue.s IL_01d0
IL_01c8: ldarg.0
IL_01c9: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_01ce: brfalse.s IL_01ea
IL_01d0: ldc.i4 140
IL_01d5: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_01da: ldc.i4 140
IL_01df: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_01e4: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2::OnPickedUpPackage()
IL_01e9: ret
IL_01ea: ldarg.1
IL_01eb: ldstr "fish_emerges"
IL_01f0: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01f5: brfalse.s IL_0212
IL_01f7: ldarg.0
IL_01f8: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_01fd: brtrue.s IL_0207
IL_01ff: ldarg.0
IL_0200: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0205: brfalse.s IL_020d
IL_0207: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2::OnFishFirstEncounterFinished()
IL_020c: ret
IL_020d: call System.Void TheForestOfLove.FishFirstMeetingCutscene::PlayCutscene()
IL_0212: ldarg.1
IL_0213: ldstr "fish_emerges"
IL_0218: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_021d: brfalse.s IL_0235
IL_021f: ldarg.0
IL_0220: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0225: brtrue.s IL_022f
IL_0227: ldarg.0
IL_0228: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_022d: brfalse.s IL_0230
IL_022f: ret
IL_0230: call System.Void TheForestOfLove.FishSecondMeetingCutscene::PlayCutscene()
IL_0235: ldarg.1
IL_0236: ldstr "peter_explains_its_just_a_joke"
IL_023b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0240: brfalse.s IL_0258
IL_0242: ldarg.0
IL_0243: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0248: brtrue.s IL_0252
IL_024a: ldarg.0
IL_024b: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0250: brfalse.s IL_0253
IL_0252: ret
IL_0253: call System.Void TheForestOfLove.BunnyDeliveryInsideCutscene::JustAJoke()
IL_0258: ldarg.1
IL_0259: ldstr "deliver_package_to_peter"
IL_025e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0263: brfalse.s IL_0280
IL_0265: ldarg.0
IL_0266: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_026b: brtrue.s IL_0275
IL_026d: ldarg.0
IL_026e: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0273: brfalse.s IL_0280
IL_0275: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2::OnBunnyDeliveryOutsideCutsceneFinished()
IL_027a: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2::OnBunnyDeliveryInsideCutsceneFinished()
IL_027f: ret
IL_0280: ldarg.1
IL_0281: ldstr "deliveryquest_paid_7_coins"
IL_0286: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_028b: brfalse.s IL_0295
IL_028d: ldc.i4.s 100
IL_028f: ldc.i4.7
IL_0290: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType,System.Int32)
IL_0295: ldarg.1
IL_0296: ldstr "deliveryquest_paid_10_coins"
IL_029b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_02a0: brfalse.s IL_02c4
IL_02a2: ldarg.0
IL_02a3: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_02a8: brtrue.s IL_02ba
IL_02aa: ldarg.0
IL_02ab: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_02b0: brtrue.s IL_02ba
IL_02b2: ldarg.0
IL_02b3: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_02b8: brfalse.s IL_02bb
IL_02ba: ret
IL_02bb: ldc.i4.s 100
IL_02bd: ldc.i4.s 10
IL_02bf: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType,System.Int32)
IL_02c4: ldarg.1
IL_02c5: ldstr "ottershop_select_item_shears"
IL_02ca: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_02cf: brfalse.s IL_02e7
IL_02d1: ldarg.0
IL_02d2: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_02d7: brtrue.s IL_02e1
IL_02d9: ldarg.0
IL_02da: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_02df: brfalse.s IL_02e7
IL_02e1: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2::OttershopPurchaseShears()
IL_02e6: ret
IL_02e7: ldarg.1
IL_02e8: ldstr "ram_sex_scene"
IL_02ed: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_02f2: brfalse.s IL_0328
IL_02f4: ldarg.0
IL_02f5: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_02fa: brtrue.s IL_0304
IL_02fc: ldarg.0
IL_02fd: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0302: brfalse.s IL_0316
IL_0304: ldc.i4.s 9
IL_0306: call System.Void TheForestOfLove.QuestTriggerHelper::UnlockMovie(TheForestOfLove.Narrative.Movie)
IL_030b: ldstr "sex_scene_unlocked_ram_anal"
IL_0310: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_0315: ret
IL_0316: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ResponseOptionsUIMovieSwapper>()
IL_031b: callvirt System.Void TheForestOfLove.ResponseOptionsUIMovieSwapper::DisableOverworldResponseOptionsUiForNextMovie()
IL_0320: ldc.i4.s 9
IL_0322: ldnull
IL_0323: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0328: ldarg.1
IL_0329: ldstr "get_wool_from_finley"
IL_032e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0333: brfalse.s IL_033a
IL_0335: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2::Handler_GetWoolFromFinley()
IL_033a: ldarg.1
IL_033b: ldstr "play_bunny_cuck_scene"
IL_0340: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0345: brfalse.s IL_0379
IL_0347: ldarg.0
IL_0348: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_034d: brtrue.s IL_0357
IL_034f: ldarg.0
IL_0350: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0355: brfalse.s IL_0368
IL_0357: ldc.i4.6
IL_0358: call System.Void TheForestOfLove.QuestTriggerHelper::UnlockMovie(TheForestOfLove.Narrative.Movie)
IL_035d: ldstr "sex_scene_unlocked_bunny_cuck"
IL_0362: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_0367: ret
IL_0368: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ResponseOptionsUIMovieSwapper>()
IL_036d: callvirt System.Void TheForestOfLove.ResponseOptionsUIMovieSwapper::DisableOverworldResponseOptionsUiForNextMovie()
IL_0372: ldc.i4.6
IL_0373: ldnull
IL_0374: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0379: ldarg.1
IL_037a: ldstr "show_dates_tutorial"
IL_037f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0384: brfalse.s IL_03c2
IL_0386: ldarg.0
IL_0387: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_038c: brtrue.s IL_0396
IL_038e: ldarg.0
IL_038f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0394: brfalse.s IL_0397
IL_0396: ret
IL_0397: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ItemGetNotification>()
IL_039c: stloc.2
IL_039d: ldloc.2
IL_039e: ldnull
IL_039f: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_03a4: brfalse.s IL_03c2
IL_03a6: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onHideItemGetAchievement
IL_03ab: ldarg.0
IL_03ac: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2::Callback_DatesTutorialPostConvo()
IL_03b2: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_03b7: callvirt System.Void UnityEngine.Events.UnityEvent::AddListener(UnityEngine.Events.UnityAction)
IL_03bc: ldloc.2
IL_03bd: callvirt System.Void TheForestOfLove.ItemGetNotification::ShowDatesTutorial()
IL_03c2: ldarg.1
IL_03c3: ldstr "deliver_wool_to_coyotes"
IL_03c8: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03cd: brfalse.s IL_03da
IL_03cf: ldc.i4 170
IL_03d4: ldc.i4.8
IL_03d5: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType,System.Int32)
IL_03da: ldarg.1
IL_03db: ldstr "raunch_quest_started"
IL_03e0: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03e5: pop
IL_03e6: ldarg.1
IL_03e7: ldstr "act2_capstone_kickoff"
IL_03ec: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03f1: brfalse.s IL_0409
IL_03f3: ldarg.0
IL_03f4: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_03f9: brtrue.s IL_0403
IL_03fb: ldarg.0
IL_03fc: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0401: brfalse.s IL_0404
IL_0403: ret
IL_0404: call System.Void TheForestOfLove.Content.PlainsEndSpawner::SpawnAct2CapstoneKickoffInteracts()
IL_0409: ldarg.1
IL_040a: ldstr "act2_capstone_fly_to_ruins"
IL_040f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0414: brfalse.s IL_0436
IL_0416: ldarg.0
IL_0417: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_041c: brtrue.s IL_0426
IL_041e: ldarg.0
IL_041f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0424: brfalse.s IL_0427
IL_0426: ret
IL_0427: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Gameplay.FastTravelController>()
IL_042c: ldstr "Lake_Ruins"
IL_0431: callvirt System.Void TheForestOfLove.Gameplay.FastTravelController::PlayerInitiatesFastTravel(System.String)
IL_0436: ldarg.1
IL_0437: ldstr "receive_sweater"
IL_043c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0441: brfalse.s IL_048c
IL_0443: ldarg.0
IL_0444: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0449: brtrue.s IL_0453
IL_044b: ldarg.0
IL_044c: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0451: brfalse.s IL_0454
IL_0453: ret
IL_0454: call System.Void TheForestOfLove.Content.PlainsEndSpawner::DisableClaireInteractions()
IL_0459: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_045e: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0463: ldc.r4 0.25
IL_0468: ldsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2/<>c::<>9__2_0
IL_046d: dup
IL_046e: brtrue.s IL_0487
IL_0470: pop
IL_0471: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2/<>c::<>9
IL_0476: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2/<>c::<ExecuteTrigger>b__2_0()
IL_047c: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0481: dup
IL_0482: stsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2/<>c::<>9__2_0
IL_0487: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_048c: ldarg.1
IL_048d: ldstr "equip_sweater"
IL_0492: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0497: pop
IL_0498: ldarg.1
IL_0499: ldstr "model_sweater"
IL_049e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04a3: brfalse.s IL_04ee
IL_04a5: ldarg.0
IL_04a6: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_04ab: brtrue.s IL_04b5
IL_04ad: ldarg.0
IL_04ae: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_04b3: brfalse.s IL_04bb
IL_04b5: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2::AddSweaterItemAndFinishCoyoteQuest()
IL_04ba: ret
IL_04bb: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_04c0: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_04c5: ldc.r4 0.75
IL_04ca: ldsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2/<>c::<>9__2_1
IL_04cf: dup
IL_04d0: brtrue.s IL_04e9
IL_04d2: pop
IL_04d3: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2/<>c::<>9
IL_04d8: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2/<>c::<ExecuteTrigger>b__2_1()
IL_04de: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_04e3: dup
IL_04e4: stsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2/<>c::<>9__2_1
IL_04e9: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_04ee: ldarg.1
IL_04ef: ldstr "talk_to_gus_at_ruins"
IL_04f4: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04f9: brfalse.s IL_0511
IL_04fb: ldarg.0
IL_04fc: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0501: brtrue.s IL_050b
IL_0503: ldarg.0
IL_0504: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0509: brfalse.s IL_050c
IL_050b: ret
IL_050c: call System.Void TheForestOfLove.Content.LakeRuinsSpawner::DisableEndOfAct2ExitBlocker()
IL_0511: ldarg.1
IL_0512: ldstr "wool_delivery_penny_fly_away"
IL_0517: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_051c: brtrue.s IL_052b
IL_051e: ldarg.1
IL_051f: ldstr "sweater_pickup_penny_fly_away"
IL_0524: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0529: brfalse.s IL_0562
IL_052b: ldarg.0
IL_052c: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0531: brtrue.s IL_053b
IL_0533: ldarg.0
IL_0534: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0539: brfalse.s IL_053c
IL_053b: ret
IL_053c: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Gameplay.FastTravelController>()
IL_0541: callvirt System.Void TheForestOfLove.Gameplay.FastTravelController::ForcePennyTakeoff()
IL_0546: ldsfld TheForestOfLove.Content.PlainsEndSpawner TheForestOfLove.Content.PlainsEndSpawner::instance
IL_054b: ldnull
IL_054c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0551: brfalse.s IL_0562
IL_0553: ldsfld TheForestOfLove.Content.PlainsEndSpawner TheForestOfLove.Content.PlainsEndSpawner::instance
IL_0558: callvirt AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_Oliver()
IL_055d: callvirt System.Void AreaContent::Disable()
IL_0562: ldarg.1
IL_0563: ldstr "shear_snip_1"
IL_0568: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_056d: brfalse.s IL_058a
IL_056f: ldarg.0
IL_0570: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0575: brtrue.s IL_057f
IL_0577: ldarg.0
IL_0578: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_057d: brfalse.s IL_0580
IL_057f: ret
IL_0580: ldc.i4 1610
IL_0585: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_058a: ldarg.1
IL_058b: ldstr "shear_snip_2"
IL_0590: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0595: brfalse.s IL_05b2
IL_0597: ldarg.0
IL_0598: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_059d: brtrue.s IL_05a7
IL_059f: ldarg.0
IL_05a0: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_05a5: brfalse.s IL_05a8
IL_05a7: ret
IL_05a8: ldc.i4 1620
IL_05ad: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_05b2: ldarg.1
IL_05b3: ldstr "shear_snip_3"
IL_05b8: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_05bd: brfalse.s IL_05da
IL_05bf: ldarg.0
IL_05c0: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_05c5: brtrue.s IL_05cf
IL_05c7: ldarg.0
IL_05c8: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_05cd: brfalse.s IL_05d0
IL_05cf: ret
IL_05d0: ldc.i4 1630
IL_05d5: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_05da: ldarg.1
IL_05db: ldstr "shear_snip_4"
IL_05e0: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_05e5: brfalse.s IL_0602
IL_05e7: ldarg.0
IL_05e8: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_05ed: brtrue.s IL_05f7
IL_05ef: ldarg.0
IL_05f0: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_05f5: brfalse.s IL_05f8
IL_05f7: ret
IL_05f8: ldc.i4 1640
IL_05fd: call System.Void TheForestOfLove.Audio.SoundManager::Play(TheForestOfLove.Audio.SoundEffect)
IL_0602: ret
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct2::AddSweaterItemAndFinishCoyoteQuest() | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldc.i4 165
IL_0005: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_000a: ldstr "Act2_Capstone"
IL_000f: call System.Void TheForestOfLove.QuestTriggerHelper::CompleteQuest(System.String)
IL_0014: ldstr "Act2_CoyoteQuest"
IL_0019: call System.Void TheForestOfLove.QuestTriggerHelper::CompleteQuest(System.String)
IL_001e: ret
