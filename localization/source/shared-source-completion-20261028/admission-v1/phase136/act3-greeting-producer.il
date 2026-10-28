TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::ExecuteTrigger(System.String) | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldstr "finleyquest_melody_getting_finley_stuff"
IL_0006: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_000b: brfalse.s IL_002d
IL_000d: ldstr "charlotte_cookies_ready"
IL_0012: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_0017: ldarg.0
IL_0018: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_001d: brtrue.s IL_0027
IL_001f: ldarg.0
IL_0020: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0025: brfalse.s IL_0028
IL_0027: ret
IL_0028: call System.Void TheForestOfLove.Content.BearCaveSpawner::SpawnPlateOfCookies()
IL_002d: ldarg.1
IL_002e: ldstr "finleyquest_drop_finley_stuff"
IL_0033: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0038: brfalse.s IL_005f
IL_003a: ldarg.0
IL_003b: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0040: brtrue.s IL_004a
IL_0042: ldarg.0
IL_0043: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0048: brfalse.s IL_005a
IL_004a: ldc.i4 370
IL_004f: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0054: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::OnPickedUpFinleyStuff()
IL_0059: ret
IL_005a: call System.Void TheForestOfLove.Content.BearCaveSpawner::SpawnFinleyBoxOfStuff()
IL_005f: ldarg.1
IL_0060: ldstr "cookiequest_receive_cookies"
IL_0065: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_006a: brfalse.s IL_008d
IL_006c: ldarg.0
IL_006d: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0072: brtrue.s IL_0081
IL_0074: ldarg.0
IL_0075: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_007a: brtrue.s IL_0081
IL_007c: call System.Void TheForestOfLove.Content.BearCaveSpawner::DisablePlateOfCookies()
IL_0081: ldc.i4 340
IL_0086: ldc.i4.s 30
IL_0088: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType,System.Int32)
IL_008d: ldarg.1
IL_008e: ldstr "cookiequest_receive_special_cookie"
IL_0093: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0098: brfalse.s IL_00a4
IL_009a: ldc.i4 360
IL_009f: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_00a4: ldarg.1
IL_00a5: ldstr "cookiequest_receive_half_cookie"
IL_00aa: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00af: brfalse.s IL_00bb
IL_00b1: ldc.i4 350
IL_00b6: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_00bb: ldarg.1
IL_00bc: ldstr "cookiequest_give_1_cookies"
IL_00c1: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00c6: brfalse.s IL_00d9
IL_00c8: ldc.i4 340
IL_00cd: ldc.i4.1
IL_00ce: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType,System.Int32)
IL_00d3: ldarg.0
IL_00d4: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::CheckIfAllCookiesDelivered()
IL_00d9: ldarg.1
IL_00da: ldstr "cookiequest_give_2_cookies"
IL_00df: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00e4: brfalse.s IL_00f7
IL_00e6: ldc.i4 340
IL_00eb: ldc.i4.2
IL_00ec: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType,System.Int32)
IL_00f1: ldarg.0
IL_00f2: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::CheckIfAllCookiesDelivered()
IL_00f7: ldarg.1
IL_00f8: ldstr "cookiequest_give_3_cookies"
IL_00fd: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0102: brfalse.s IL_0115
IL_0104: ldc.i4 340
IL_0109: ldc.i4.3
IL_010a: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType,System.Int32)
IL_010f: ldarg.0
IL_0110: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::CheckIfAllCookiesDelivered()
IL_0115: ldarg.1
IL_0116: ldstr "cookiequest_give_4_cookies"
IL_011b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0120: brfalse.s IL_0133
IL_0122: ldc.i4 340
IL_0127: ldc.i4.4
IL_0128: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType,System.Int32)
IL_012d: ldarg.0
IL_012e: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::CheckIfAllCookiesDelivered()
IL_0133: ldarg.1
IL_0134: ldstr "cookiequest_give_special_cookie"
IL_0139: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_013e: brfalse.s IL_0150
IL_0140: ldc.i4 360
IL_0145: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_014a: ldarg.0
IL_014b: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::CheckIfAllCookiesDelivered()
IL_0150: ldarg.1
IL_0151: ldstr "finleyquest_give_finley_his_stuff"
IL_0156: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_015b: brfalse.s IL_0167
IL_015d: ldc.i4 370
IL_0162: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0167: ldarg.1
IL_0168: ldstr "cookiequest_deliver_dustin_cookie"
IL_016d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0172: brfalse.s IL_0189
IL_0174: ldarg.0
IL_0175: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_017a: brtrue.s IL_0189
IL_017c: ldarg.0
IL_017d: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0182: brtrue.s IL_0189
IL_0184: call System.Void TheForestOfLove.Content.CentralForestSpawner::SetDustinTargetDialogueToDashChallenge()
IL_0189: ldarg.1
IL_018a: ldstr "cookiequest_check_if_before_roomies_reunited"
IL_018f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0194: brfalse.s IL_01b6
IL_0196: ldarg.0
IL_0197: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_019c: brtrue.s IL_01a6
IL_019e: ldarg.0
IL_019f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_01a4: brfalse.s IL_01a7
IL_01a6: ret
IL_01a7: ldstr "FinleyQuest_RoommatesConclusion"
IL_01ac: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_01b1: call System.Void TheForestOfLove.Narrative.DialogueService::SetDialogueSystemBoolCondition(System.Boolean)
IL_01b6: ldarg.1
IL_01b7: ldstr "player_can_leave_cave"
IL_01bc: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01c1: brfalse.s IL_01d9
IL_01c3: ldarg.0
IL_01c4: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_01c9: brtrue.s IL_01d3
IL_01cb: ldarg.0
IL_01cc: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_01d1: brfalse.s IL_01d4
IL_01d3: ret
IL_01d4: call System.Void TheForestOfLove.BearCaveFinleyRoommatesCutscene::Freeplay()
IL_01d9: ldarg.1
IL_01da: ldstr "inspect_bearcave_bookshelf"
IL_01df: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01e4: pop
IL_01e5: ldarg.1
IL_01e6: ldstr "check_melody_nearby"
IL_01eb: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01f0: brfalse.s IL_0204
IL_01f2: ldstr "CharlotteSocialQuest_MeetingTheCritters"
IL_01f7: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_01fc: ldc.i4.0
IL_01fd: ceq
IL_01ff: call System.Void TheForestOfLove.Narrative.DialogueService::SetDialogueSystemBoolCondition(System.Boolean)
IL_0204: ldarg.1
IL_0205: ldstr "socialquest_travel_to_centralforest"
IL_020a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_020f: brfalse.s IL_0255
IL_0211: ldarg.0
IL_0212: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0217: brtrue.s IL_0221
IL_0219: ldarg.0
IL_021a: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_021f: brfalse.s IL_0222
IL_0221: ret
IL_0222: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_0227: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_022c: ldc.r4 1
IL_0231: ldsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9__8_0
IL_0236: dup
IL_0237: brtrue.s IL_0250
IL_0239: pop
IL_023a: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9
IL_023f: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<ExecuteTrigger>b__8_0()
IL_0245: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_024a: dup
IL_024b: stsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9__8_0
IL_0250: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0255: ldarg.1
IL_0256: ldstr "reset_photoshoot_dialogue_melody"
IL_025b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0260: brfalse.s IL_0282
IL_0262: ldarg.0
IL_0263: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0268: brtrue.s IL_0272
IL_026a: ldarg.0
IL_026b: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0270: brfalse.s IL_0282
IL_0272: ldc.i4 380
IL_0277: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_027c: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::OnPickedUpPhotoshootCamera()
IL_0281: ret
IL_0282: ldarg.1
IL_0283: ldstr "reset_photoshoot_dialogue_maverick"
IL_0288: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_028d: pop
IL_028e: ldarg.1
IL_028f: ldstr "show_melody_photoshoot_movie"
IL_0294: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0299: brfalse.s IL_02a6
IL_029b: ldc.i4 3800
IL_02a0: ldnull
IL_02a1: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_02a6: ldarg.1
IL_02a7: ldstr "show_melody_photoshoot_movie_unlock"
IL_02ac: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_02b1: brfalse.s IL_02e9
IL_02b3: ldarg.0
IL_02b4: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_02b9: brtrue.s IL_02c3
IL_02bb: ldarg.0
IL_02bc: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_02c1: brfalse.s IL_02d3
IL_02c3: ldc.i4 3800
IL_02c8: ldnull
IL_02c9: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_02ce: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::OnReturnToCentralForestAfterMelodyPhotoshoot()
IL_02d3: ldc.i4 3800
IL_02d8: ldnull
IL_02d9: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::OnFinishedMelodyPhotoshoot()
IL_02df: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_02e4: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_02e9: ldarg.1
IL_02ea: ldstr "finished_melody_photoshoot_movie"
IL_02ef: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_02f4: pop
IL_02f5: ldarg.1
IL_02f6: ldstr "check_otter_nearby"
IL_02fb: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0300: brfalse.s IL_031d
IL_0302: ldarg.0
IL_0303: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0308: brtrue.s IL_0312
IL_030a: ldarg.0
IL_030b: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0310: brfalse.s IL_0313
IL_0312: ret
IL_0313: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsPhotoshootHappening()
IL_0318: call System.Void TheForestOfLove.Narrative.DialogueService::SetDialogueSystemBoolCondition(System.Boolean)
IL_031d: ldarg.1
IL_031e: ldstr "check_shop_backdoor_unlocked"
IL_0323: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0328: brfalse.s IL_035d
IL_032a: ldarg.0
IL_032b: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0330: brtrue.s IL_033a
IL_0332: ldarg.0
IL_0333: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0338: brfalse.s IL_033b
IL_033a: ret
IL_033b: ldstr "ottershop_unlock_backdoor"
IL_0340: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0345: brtrue.s IL_034e
IL_0347: call System.Boolean TheForestOfLove.QuestTriggerHelper::CanPlayMaverickRascalShopStory()
IL_034c: br.s IL_034f
IL_034e: ldc.i4.1
IL_034f: call System.Boolean TheForestOfLove.QuestTriggerHelper::CanSpawnScarlettHop()
IL_0354: ldc.i4.0
IL_0355: ceq
IL_0357: and
IL_0358: call System.Void TheForestOfLove.Narrative.DialogueService::SetDialogueSystemBoolCondition(System.Boolean)
IL_035d: ldarg.1
IL_035e: ldstr "ottershop_use_backdoor"
IL_0363: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0368: brfalse.s IL_03c5
IL_036a: ldarg.0
IL_036b: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0370: brtrue.s IL_037a
IL_0372: ldarg.0
IL_0373: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0378: brfalse.s IL_037b
IL_037a: ret
IL_037b: ldstr "ottershop_unlock_backdoor"
IL_0380: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0385: stloc.0
IL_0386: ldarg.0
IL_0387: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_038c: brfalse.s IL_0392
IL_038e: ldloc.0
IL_038f: brtrue.s IL_0392
IL_0391: ret
IL_0392: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_0397: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_039c: ldc.r4 1
IL_03a1: ldsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9__8_5
IL_03a6: dup
IL_03a7: brtrue.s IL_03c0
IL_03a9: pop
IL_03aa: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9
IL_03af: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<ExecuteTrigger>b__8_5()
IL_03b5: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_03ba: dup
IL_03bb: stsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9__8_5
IL_03c0: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_03c5: ldarg.1
IL_03c6: ldstr "ottershop_use_backdoor_cf"
IL_03cb: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03d0: brfalse.s IL_042d
IL_03d2: ldarg.0
IL_03d3: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_03d8: brtrue.s IL_03e2
IL_03da: ldarg.0
IL_03db: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_03e0: brfalse.s IL_03e3
IL_03e2: ret
IL_03e3: ldstr "ottershop_unlock_backdoor"
IL_03e8: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_03ed: stloc.1
IL_03ee: ldarg.0
IL_03ef: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_03f4: brfalse.s IL_03fa
IL_03f6: ldloc.1
IL_03f7: brtrue.s IL_03fa
IL_03f9: ret
IL_03fa: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_03ff: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0404: ldc.r4 1
IL_0409: ldsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9__8_6
IL_040e: dup
IL_040f: brtrue.s IL_0428
IL_0411: pop
IL_0412: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9
IL_0417: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<ExecuteTrigger>b__8_6()
IL_041d: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0422: dup
IL_0423: stsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9__8_6
IL_0428: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_042d: ldarg.1
IL_042e: ldstr "ottershop_unlock_backdoor"
IL_0433: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0438: pop
IL_0439: ldarg.1
IL_043a: ldstr "ottershop_lock_backdoor"
IL_043f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0444: pop
IL_0445: ldarg.1
IL_0446: ldstr "ottershop_check_lights"
IL_044b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0450: pop
IL_0451: ldarg.1
IL_0452: ldstr "ottershop_lights_on"
IL_0457: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_045c: pop
IL_045d: ldarg.1
IL_045e: ldstr "ottershop_lights_off"
IL_0463: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0468: pop
IL_0469: ldarg.1
IL_046a: ldstr "check_melody_idle_before_photoshoot"
IL_046f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0474: brfalse.s IL_0499
IL_0476: ldarg.0
IL_0477: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_047c: brtrue.s IL_0486
IL_047e: ldarg.0
IL_047f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0484: brfalse.s IL_0487
IL_0486: ret
IL_0487: ldstr "MelodyQuest_ReadyForPhotoshoot"
IL_048c: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0491: ldc.i4.0
IL_0492: ceq
IL_0494: call System.Void TheForestOfLove.Narrative.DialogueService::SetDialogueSystemBoolCondition(System.Boolean)
IL_0499: ldarg.1
IL_049a: ldstr "check_melody_idle_before_photoshoot"
IL_049f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04a4: brfalse.s IL_04c6
IL_04a6: ldarg.0
IL_04a7: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_04ac: brtrue.s IL_04b6
IL_04ae: ldarg.0
IL_04af: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_04b4: brfalse.s IL_04b7
IL_04b6: ret
IL_04b7: ldstr "MelodyQuest_ReadyForPhotoshoot"
IL_04bc: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_04c1: call System.Void TheForestOfLove.Narrative.DialogueService::SetDialogueSystemBoolCondition(System.Boolean)
IL_04c6: ldarg.1
IL_04c7: ldstr "act3_thestorm_finishedhelpingbunnies"
IL_04cc: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04d1: brtrue.s IL_04f0
IL_04d3: ldarg.1
IL_04d4: ldstr "act3_thestorm_buckyminigamecompleted"
IL_04d9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04de: brtrue.s IL_04f0
IL_04e0: ldarg.1
IL_04e1: ldstr "act3_thestorm_grabbedthelastpage"
IL_04e6: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04eb: brfalse IL_05c6
IL_04f0: ldstr "Act3_StormQuest"
IL_04f5: call TheForestOfLove.Narrative.Quest TheForestOfLove.Services.Persistence.DataService::GetQuestByDbName(System.String)
IL_04fa: stloc.2
IL_04fb: ldarg.0
IL_04fc: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0501: brtrue.s IL_050b
IL_0503: ldarg.0
IL_0504: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0509: brfalse.s IL_0534
IL_050b: ldarg.1
IL_050c: ldstr "act3_thestorm_finishedhelpingbunnies"
IL_0511: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0516: brfalse.s IL_0533
IL_0518: ldc.i4 420
IL_051d: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0522: ldc.i4 420
IL_0527: ldc.i4.8
IL_0528: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType,System.Int32)
IL_052d: ldloc.2
IL_052e: callvirt System.Void TheForestOfLove.Narrative.Quest::SetStatusCompleted()
IL_0533: ret
IL_0534: ldloc.2
IL_0535: callvirt System.Boolean TheForestOfLove.Narrative.Quest::get_isCompleted()
IL_053a: brtrue IL_05c6
IL_053f: ldarg.1
IL_0540: brfalse.s IL_059c
IL_0542: ldarg.1
IL_0543: ldstr "act3_thestorm_finishedhelpingbunnies"
IL_0548: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_054d: brtrue.s IL_056b
IL_054f: ldarg.1
IL_0550: ldstr "act3_thestorm_buckyminigamecompleted"
IL_0555: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_055a: brtrue.s IL_057c
IL_055c: ldarg.1
IL_055d: ldstr "act3_thestorm_grabbedthelastpage"
IL_0562: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0567: brtrue.s IL_058d
IL_0569: br.s IL_059c
IL_056b: ldstr "Act3_StormQuest_3"
IL_0570: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_0575: call System.Void TheForestOfLove.Narrative.NarrativeActions::LogNewlyEnteredStep(TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_057a: br.s IL_059c
IL_057c: ldstr "Act3_StormQuest_4"
IL_0581: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_0586: call System.Void TheForestOfLove.Narrative.NarrativeActions::LogNewlyEnteredStep(TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_058b: br.s IL_059c
IL_058d: ldstr "Act3_StormQuest_5"
IL_0592: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_0597: call System.Void TheForestOfLove.Narrative.NarrativeActions::LogNewlyEnteredStep(TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_059c: ldstr "act3_thestorm_finishedhelpingbunnies"
IL_05a1: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_05a6: brfalse.s IL_05c6
IL_05a8: ldstr "act3_thestorm_buckyminigamecompleted"
IL_05ad: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_05b2: brfalse.s IL_05c6
IL_05b4: ldstr "act3_thestorm_grabbedthelastpage"
IL_05b9: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_05be: brfalse.s IL_05c6
IL_05c0: ldloc.2
IL_05c1: call System.Void TheForestOfLove.Narrative.NarrativeActions::CompleteQuest(TheForestOfLove.Narrative.Quest)
IL_05c6: ldarg.1
IL_05c7: ldstr "act3_thestorm_finishedhelpingbunnies"
IL_05cc: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_05d1: brfalse.s IL_0617
IL_05d3: ldarg.0
IL_05d4: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_05d9: brtrue.s IL_05e3
IL_05db: ldarg.0
IL_05dc: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_05e1: brfalse.s IL_05e4
IL_05e3: ret
IL_05e4: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_05e9: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_05ee: ldc.r4 1
IL_05f3: ldsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9__8_1
IL_05f8: dup
IL_05f9: brtrue.s IL_0612
IL_05fb: pop
IL_05fc: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9
IL_0601: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<ExecuteTrigger>b__8_1()
IL_0607: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_060c: dup
IL_060d: stsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9__8_1
IL_0612: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0617: ldarg.1
IL_0618: ldstr "act3_thestorm_dustinseeksshelter"
IL_061d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0622: brfalse IL_06fc
IL_0627: ldarg.0
IL_0628: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_062d: brtrue.s IL_0637
IL_062f: ldarg.0
IL_0630: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0635: brfalse.s IL_0638
IL_0637: ret
IL_0638: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_063d: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0642: ldstr "Dustin"
IL_0647: call TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Gameplay.SpawnableActor::FindActorByName(System.String)
IL_064c: stloc.3
IL_064d: ldloc.3
IL_064e: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0653: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0658: ldc.r4 2.1
IL_065d: ldc.r4 0.3
IL_0662: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single)
IL_0667: call UnityEngine.Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)
IL_066c: stloc.s V_4
IL_066e: ldloc.3
IL_066f: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0674: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0679: ldc.r4 2.7
IL_067e: ldc.r4 0.3
IL_0683: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single)
IL_0688: call UnityEngine.Vector3 UnityEngine.Vector3::op_Addition(UnityEngine.Vector3,UnityEngine.Vector3)
IL_068d: pop
IL_068e: ldloc.3
IL_068f: callvirt !!0 UnityEngine.Component::GetComponentInChildren<TheForestOfLove.Interaction.DustinIdleDashAnimator>()
IL_0694: stloc.s V_5
IL_0696: ldloc.s V_5
IL_0698: ldnull
IL_0699: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_069e: brfalse.s IL_06ab
IL_06a0: ldstr "trying to play a dustin dash effect but the fx prefab is unavailable, please investigate!"
IL_06a5: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_06aa: ret
IL_06ab: ldloc.s V_5
IL_06ad: ldfld UnityEngine.GameObject TheForestOfLove.Interaction.DustinIdleDashAnimator::container
IL_06b2: ldc.i4.1
IL_06b3: callvirt System.Void UnityEngine.GameObject::SetActive(System.Boolean)
IL_06b8: ldloc.3
IL_06b9: callvirt System.Void TheForestOfLove.Gameplay.SpawnableActor::HideSprites()
IL_06be: ldloc.s V_5
IL_06c0: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_06c5: ldloc.s V_4
IL_06c7: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_06cc: ldloc.s V_5
IL_06ce: callvirt System.Void TheForestOfLove.Interaction.DustinIdleDashAnimator::Dash()
IL_06d3: ldc.r4 1
IL_06d8: ldsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9__8_8
IL_06dd: dup
IL_06de: brtrue.s IL_06f7
IL_06e0: pop
IL_06e1: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9
IL_06e6: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<ExecuteTrigger>b__8_8()
IL_06ec: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_06f1: dup
IL_06f2: stsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9__8_8
IL_06f7: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_06fc: ldarg.1
IL_06fd: ldstr "act3_thestorm_buckyminigamebegin"
IL_0702: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0707: brfalse.s IL_0743
IL_0709: ldarg.0
IL_070a: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_070f: brtrue.s IL_0719
IL_0711: ldarg.0
IL_0712: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0717: brfalse.s IL_071a
IL_0719: ret
IL_071a: ldc.r4 1
IL_071f: ldsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9__8_2
IL_0724: dup
IL_0725: brtrue.s IL_073e
IL_0727: pop
IL_0728: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9
IL_072d: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<ExecuteTrigger>b__8_2()
IL_0733: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0738: dup
IL_0739: stsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9__8_2
IL_073e: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0743: ldarg.1
IL_0744: ldstr "act3_thestorm_buckyminigamecompleted"
IL_0749: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_074e: pop
IL_074f: ldarg.1
IL_0750: ldstr "act3_thestorm_grabbedthelastpage"
IL_0755: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_075a: brfalse.s IL_07af
IL_075c: ldarg.0
IL_075d: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0762: brtrue.s IL_076c
IL_0764: ldarg.0
IL_0765: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_076a: brfalse.s IL_076d
IL_076c: ret
IL_076d: ldc.r4 0
IL_0772: ldc.r4 1
IL_0777: newobj System.Void System.Nullable`1<System.Single>::.ctor(!0)
IL_077c: call System.Void TheForestOfLove.Audio.MusicManager::FadeToVolume(System.Single,System.Nullable`1<System.Single>)
IL_0781: ldc.i4 5700
IL_0786: ldnull
IL_0787: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::StormQuest_OnFinishedMabelRascalMovie()
IL_078d: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0792: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0797: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.StormQuestWindSystemController>()
IL_079c: stloc.s V_6
IL_079e: ldloc.s V_6
IL_07a0: ldnull
IL_07a1: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_07a6: brfalse.s IL_07af
IL_07a8: ldloc.s V_6
IL_07aa: callvirt System.Void TheForestOfLove.StormQuestWindSystemController::DisableAllGusts()
IL_07af: ldarg.1
IL_07b0: ldstr "act3_afterthestorm_introcutscenefinished"
IL_07b5: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_07ba: brfalse.s IL_07eb
IL_07bc: ldarg.0
IL_07bd: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_07c2: brtrue.s IL_07cc
IL_07c4: ldarg.0
IL_07c5: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_07ca: brfalse.s IL_07dc
IL_07cc: ldstr "Act3_AfterstormQuest_2"
IL_07d1: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_07d6: call System.Void TheForestOfLove.Narrative.NarrativeActions::LogNewlyEnteredStep(TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_07db: ret
IL_07dc: ldstr "Charlotte In Bed"
IL_07e1: call TheForestOfLove.Narrative.Actor TheForestOfLove.Services.Persistence.DataService::GetActorByDbName(System.String)
IL_07e6: callvirt System.Void TheForestOfLove.Narrative.Actor::Introduce()
IL_07eb: ldarg.1
IL_07ec: ldstr "act3_afterthestorm_talkedtobunnies"
IL_07f1: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_07f6: brfalse.s IL_0851
IL_07f8: ldarg.0
IL_07f9: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_07fe: brtrue.s IL_0808
IL_0800: ldarg.0
IL_0801: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0806: brfalse.s IL_0827
IL_0808: ldstr "Act3_LightQuest_1"
IL_080d: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_0812: call System.Void TheForestOfLove.Narrative.NarrativeActions::LogNewlyEnteredStep(TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_0817: ldstr "Act3_LightQuest_2"
IL_081c: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_0821: call System.Void TheForestOfLove.Narrative.NarrativeActions::LogNewlyEnteredStep(TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_0826: ret
IL_0827: ldc.i4.1
IL_0828: stsfld System.Boolean Globals::isCheatCode
IL_082d: ldstr "Act3_LightQuest_1"
IL_0832: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_0837: call System.Void TheForestOfLove.Narrative.NarrativeActions::LogNewlyEnteredStep(TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_083c: ldc.i4.0
IL_083d: stsfld System.Boolean Globals::isCheatCode
IL_0842: ldstr "Act3_LightQuest_2"
IL_0847: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_084c: call System.Void TheForestOfLove.Narrative.NarrativeActions::LogNewlyEnteredStep(TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_0851: ldarg.1
IL_0852: ldstr "act3_afterthestorm_talkedtodustin"
IL_0857: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_085c: brfalse.s IL_0873
IL_085e: ldarg.0
IL_085f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0864: brtrue.s IL_0873
IL_0866: ldarg.0
IL_0867: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_086c: brtrue.s IL_0873
IL_086e: call System.Void TheForestOfLove.Content.CentralForestSpawner::SetDustinTargetDialogueToDashChallenge()
IL_0873: ldarg.1
IL_0874: ldstr "act3_lightquest_leaving_otter_shop"
IL_0879: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_087e: brfalse.s IL_08a5
IL_0880: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3MouseQuest()
IL_0885: brtrue.s IL_088e
IL_0887: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3WolfQuest()
IL_088c: brfalse.s IL_088f
IL_088e: ret
IL_088f: ldarg.0
IL_0890: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0895: brtrue.s IL_089f
IL_0897: ldarg.0
IL_0898: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_089d: brfalse.s IL_08a0
IL_089f: ret
IL_08a0: call System.Void TheForestOfLove.Content.CentralForestSpawner::Act3LightQuestSpawnFireflies()
IL_08a5: ldarg.1
IL_08a6: ldstr "act3_afterthestorm_check_if_visited_all_critters"
IL_08ab: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_08b0: brfalse.s IL_08e8
IL_08b2: ldarg.0
IL_08b3: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_08b8: brtrue.s IL_08c2
IL_08ba: ldarg.0
IL_08bb: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_08c0: brfalse.s IL_08d7
IL_08c2: ldc.i4 200
IL_08c7: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_08cc: ldstr "Act3_AfterstormQuest"
IL_08d1: call System.Void TheForestOfLove.Narrative.NarrativeActions::CompleteQuest(System.String)
IL_08d6: ret
IL_08d7: call System.Boolean TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::CheckIfVisitedAllCrittersAfterStorm()
IL_08dc: brfalse.s IL_08e8
IL_08de: ldstr "Act3_AfterstormQuest"
IL_08e3: call System.Void TheForestOfLove.Narrative.NarrativeActions::CompleteQuest(System.String)
IL_08e8: ldarg.1
IL_08e9: ldstr "act3_afterthestorm_checkplayerhasjar"
IL_08ee: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_08f3: brfalse.s IL_0912
IL_08f5: ldarg.0
IL_08f6: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_08fb: brtrue.s IL_0905
IL_08fd: ldarg.0
IL_08fe: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0903: brfalse.s IL_0906
IL_0905: ret
IL_0906: ldc.i4.s 120
IL_0908: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_090d: call System.Void TheForestOfLove.Narrative.DialogueService::SetDialogueSystemBoolCondition(System.Boolean)
IL_0912: ldarg.1
IL_0913: ldstr "act3_afterstorm_charlotte_frowny"
IL_0918: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_091d: brfalse.s IL_0942
IL_091f: ldarg.0
IL_0920: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_0925: brtrue.s IL_0937
IL_0927: ldarg.0
IL_0928: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_092d: brtrue.s IL_0937
IL_092f: ldarg.0
IL_0930: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0935: brfalse.s IL_0938
IL_0937: ret
IL_0938: ldstr "frowny"
IL_093d: call System.Void TheForestOfLove.Content.BearCaveSpawner::Act3AfterstormSetCharlotteInBedAnimatorTrigger(System.String)
IL_0942: ldarg.1
IL_0943: ldstr "act3_afterstorm_charlotte_hide"
IL_0948: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_094d: brfalse.s IL_0972
IL_094f: ldarg.0
IL_0950: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_0955: brtrue.s IL_0967
IL_0957: ldarg.0
IL_0958: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_095d: brtrue.s IL_0967
IL_095f: ldarg.0
IL_0960: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0965: brfalse.s IL_0968
IL_0967: ret
IL_0968: ldstr "hide"
IL_096d: call System.Void TheForestOfLove.Content.BearCaveSpawner::Act3AfterstormSetCharlotteInBedAnimatorTrigger(System.String)
IL_0972: ldarg.1
IL_0973: ldstr "act3_afterstorm_charlotte_unhide"
IL_0978: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_097d: brfalse.s IL_09a2
IL_097f: ldarg.0
IL_0980: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_0985: brtrue.s IL_0997
IL_0987: ldarg.0
IL_0988: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_098d: brtrue.s IL_0997
IL_098f: ldarg.0
IL_0990: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0995: brfalse.s IL_0998
IL_0997: ret
IL_0998: ldstr "unhide"
IL_099d: call System.Void TheForestOfLove.Content.BearCaveSpawner::Act3AfterstormSetCharlotteInBedAnimatorTrigger(System.String)
IL_09a2: ldarg.1
IL_09a3: ldstr "act3_afterstorm_charlotte_happy"
IL_09a8: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_09ad: brfalse.s IL_09ca
IL_09af: ldarg.0
IL_09b0: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_09b5: brtrue.s IL_09bf
IL_09b7: ldarg.0
IL_09b8: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_09bd: brfalse.s IL_09c0
IL_09bf: ret
IL_09c0: ldstr "happy"
IL_09c5: call System.Void TheForestOfLove.Content.BearCaveSpawner::Act3AfterstormSetCharlotteInBedAnimatorTrigger(System.String)
IL_09ca: ldarg.1
IL_09cb: ldstr "act3_penny_mountains_perch_first_time_summoned"
IL_09d0: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_09d5: brfalse.s IL_0a0b
IL_09d7: ldarg.0
IL_09d8: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_09dd: brtrue.s IL_09ef
IL_09df: ldarg.0
IL_09e0: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_09e5: brtrue.s IL_09ef
IL_09e7: ldarg.0
IL_09e8: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_09ed: brfalse.s IL_09f0
IL_09ef: ret
IL_09f0: ldstr "act3_penny_mountains_perch_first_time_landed"
IL_09f5: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_09fa: brtrue.s IL_0a0b
IL_09fc: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Gameplay.FastTravelController>()
IL_0a01: ldstr "[pic=2]So where to?"
IL_0a06: callvirt System.Void TheForestOfLove.Gameplay.FastTravelController::set_NextFastTravelCustomGreetingText(System.String)
IL_0a0b: ldarg.1
IL_0a0c: ldstr "act3_penny_mountains_perch_first_time_landed"
IL_0a11: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0a16: brfalse.s IL_0a22
IL_0a18: ldstr "act3_penny_mountains_perch_first_time_summoned"
IL_0a1d: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_0a22: ldarg.1
IL_0a23: ldstr "show_mabel_cum_jar_easter_egg_story"
IL_0a28: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0a2d: brfalse.s IL_0a61
IL_0a2f: ldarg.0
IL_0a30: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0a35: brtrue.s IL_0a3f
IL_0a37: ldarg.0
IL_0a38: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0a3d: brfalse.s IL_0a40
IL_0a3f: ret
IL_0a40: ldsfld TheForestOfLove.Events.MovieEvent TheForestOfLove.Events.GameEvents::onMovieEnding
IL_0a45: ldnull
IL_0a46: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::OnActivateFireflyJarEasterEgg_FinishedMovie(TheForestOfLove.Narrative.Movie)
IL_0a4c: newobj System.Void UnityEngine.Events.UnityAction`1<TheForestOfLove.Narrative.Movie>::.ctor(System.Object,System.IntPtr)
IL_0a51: callvirt System.Void UnityEngine.Events.UnityEvent`1<TheForestOfLove.Narrative.Movie>::AddListener(UnityEngine.Events.UnityAction`1<!0>)
IL_0a56: ldc.i4 5900
IL_0a5b: ldnull
IL_0a5c: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0a61: ldarg.1
IL_0a62: ldstr "act3_lightquest_check_lantern_equip_available"
IL_0a67: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0a6c: brfalse.s IL_0a91
IL_0a6e: ldarg.0
IL_0a6f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0a74: brtrue.s IL_0a7e
IL_0a76: ldarg.0
IL_0a77: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0a7c: brfalse.s IL_0a7f
IL_0a7e: ret
IL_0a7f: call System.Boolean TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::CheckIfVisitedAllCrittersAfterStorm()
IL_0a84: dup
IL_0a85: call System.Void TheForestOfLove.Narrative.DialogueService::SetDialogueSystemBoolCondition(System.Boolean)
IL_0a8a: brfalse.s IL_0a91
IL_0a8c: call System.Void TheForestOfLove.Content.DeepWoodsEntrySpawner::TeardownAct3LanternAccessBlocker()
IL_0a91: ldarg.1
IL_0a92: ldstr "act3_lightquest_turn_back_for_more_critters"
IL_0a97: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0a9c: brfalse.s IL_0b08
IL_0a9e: ldarg.0
IL_0a9f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0aa4: brtrue.s IL_0aae
IL_0aa6: ldarg.0
IL_0aa7: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0aac: brfalse.s IL_0ab6
IL_0aae: ldc.i4.s 120
IL_0ab0: call System.Void TheForestOfLove.Narrative.NarrativeActions::ConsumeInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0ab5: ret
IL_0ab6: ldloca.s V_7
IL_0ab8: ldc.r4 -1
IL_0abd: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0ac2: callvirt TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_0ac7: callvirt UnityEngine.Vector3 TheForestOfLove.WaypointController::get_currentPosition()
IL_0acc: ldfld System.Single UnityEngine.Vector3::y
IL_0ad1: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0ad6: callvirt TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_0adb: callvirt UnityEngine.Vector3 TheForestOfLove.WaypointController::get_currentPosition()
IL_0ae0: ldfld System.Single UnityEngine.Vector3::z
IL_0ae5: call System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_0aea: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_0aef: callvirt TheForestOfLove.WaypointController TheForestOfLove.Player::get_waypointController()
IL_0af4: ldc.i4.1
IL_0af5: newarr UnityEngine.Vector3
IL_0afa: dup
IL_0afb: ldc.i4.0
IL_0afc: ldloc.s V_7
IL_0afe: stelem.any UnityEngine.Vector3
IL_0b03: callvirt System.Void TheForestOfLove.WaypointController::SetWaypoints(UnityEngine.Vector3[])
IL_0b08: ldarg.1
IL_0b09: ldstr "act3_mousequest_leaving_the_campsite"
IL_0b0e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0b13: brfalse.s IL_0b2b
IL_0b15: ldarg.0
IL_0b16: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0b1b: brtrue.s IL_0b25
IL_0b1d: ldarg.0
IL_0b1e: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0b23: brfalse.s IL_0b2b
IL_0b25: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::IntroduceForestMice()
IL_0b2a: ret
IL_0b2b: ldarg.1
IL_0b2c: ldstr "act3_wolfquest_approach_the_wolf"
IL_0b31: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0b36: brfalse.s IL_0b49
IL_0b38: ldarg.0
IL_0b39: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0b3e: brtrue.s IL_0b48
IL_0b40: ldarg.0
IL_0b41: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0b46: brfalse.s IL_0b49
IL_0b48: ret
IL_0b49: ldarg.1
IL_0b4a: ldstr "act3_wolfquest_rascal_has_no_rizz"
IL_0b4f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0b54: brfalse.s IL_0b67
IL_0b56: ldarg.0
IL_0b57: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0b5c: brtrue.s IL_0b66
IL_0b5e: ldarg.0
IL_0b5f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0b64: brfalse.s IL_0b67
IL_0b66: ret
IL_0b67: ldarg.1
IL_0b68: ldstr "act3_wolfquest_asked_about_the_wolf"
IL_0b6d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0b72: brfalse.s IL_0bb8
IL_0b74: ldarg.0
IL_0b75: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0b7a: brtrue.s IL_0b84
IL_0b7c: ldarg.0
IL_0b7d: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0b82: brfalse.s IL_0b8f
IL_0b84: ldstr "act3_wolfquest_asked_enough_critters_about_the_wolf"
IL_0b89: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_0b8e: ret
IL_0b8f: call System.Boolean TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::WolfQuestCheckIfEnoughCrittersAsked()
IL_0b94: brfalse.s IL_0bb8
IL_0b96: ldstr "act3_wolfquest_asked_enough_critters_about_the_wolf"
IL_0b9b: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0ba0: brtrue.s IL_0bb8
IL_0ba2: ldstr "act3_wolfquest_asked_enough_critters_about_the_wolf"
IL_0ba7: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_0bac: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inCentralForest()
IL_0bb1: brfalse.s IL_0bb8
IL_0bb3: call System.Void TheForestOfLove.Content.CentralForestSpawner::Act3WolfQuestAskedEnoughCritters()
IL_0bb8: ldarg.1
IL_0bb9: ldstr "act3_wolfquest_talked_to_dustin_ask_around"
IL_0bbe: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0bc3: brfalse.s IL_0bda
IL_0bc5: ldarg.0
IL_0bc6: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0bcb: brtrue.s IL_0bda
IL_0bcd: ldarg.0
IL_0bce: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0bd3: brtrue.s IL_0bda
IL_0bd5: call System.Void TheForestOfLove.Content.CentralForestSpawner::RefreshDustinTargetDialogue()
IL_0bda: ldarg.1
IL_0bdb: ldstr "act3_wolfquest_look_at_second_jar"
IL_0be0: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0be5: brfalse.s IL_0c05
IL_0be7: ldarg.0
IL_0be8: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_0bed: brtrue.s IL_0bff
IL_0bef: ldarg.0
IL_0bf0: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0bf5: brtrue.s IL_0bff
IL_0bf7: ldarg.0
IL_0bf8: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0bfd: brfalse.s IL_0c00
IL_0bff: ret
IL_0c00: call System.Void TheForestOfLove.Content.BearCaveSpawner::Act3WolfQuestPanCameraToJarOnShelf()
IL_0c05: ldarg.1
IL_0c06: ldstr "act3_wolfquest_obtain_second_jar"
IL_0c0b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0c10: brfalse.s IL_0c3c
IL_0c12: ldarg.0
IL_0c13: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0c18: brtrue.s IL_0c22
IL_0c1a: ldarg.0
IL_0c1b: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0c20: brfalse.s IL_0c2d
IL_0c22: ldc.i4 450
IL_0c27: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0c2c: ret
IL_0c2d: call System.Void TheForestOfLove.Content.BearCaveSpawner::Act3WolfQuestDisableJarOnShelf()
IL_0c32: ldc.i4 450
IL_0c37: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0c3c: ldarg.1
IL_0c3d: ldstr "act3_wolfquest_look_at_charlotte"
IL_0c42: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0c47: brfalse.s IL_0c67
IL_0c49: ldarg.0
IL_0c4a: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_0c4f: brtrue.s IL_0c61
IL_0c51: ldarg.0
IL_0c52: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0c57: brtrue.s IL_0c61
IL_0c59: ldarg.0
IL_0c5a: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0c5f: brfalse.s IL_0c62
IL_0c61: ret
IL_0c62: call System.Void TheForestOfLove.Content.BearCaveSpawner::Act3WolfQuestPanCameraToCharlotte()
IL_0c67: ldarg.1
IL_0c68: ldstr "act3_wolfquest_scarlett_begins_following"
IL_0c6d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0c72: brfalse.s IL_0cb8
IL_0c74: ldarg.0
IL_0c75: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0c7a: brtrue.s IL_0c84
IL_0c7c: ldarg.0
IL_0c7d: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0c82: brfalse.s IL_0c85
IL_0c84: ret
IL_0c85: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_0c8a: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0c8f: ldc.r4 1
IL_0c94: ldsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9__8_3
IL_0c99: dup
IL_0c9a: brtrue.s IL_0cb3
IL_0c9c: pop
IL_0c9d: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9
IL_0ca2: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<ExecuteTrigger>b__8_3()
IL_0ca8: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0cad: dup
IL_0cae: stsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9__8_3
IL_0cb3: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0cb8: ldarg.1
IL_0cb9: ldstr "act3_wolfquest_talked_to_dustin_scarlett_follow"
IL_0cbe: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0cc3: brfalse.s IL_0cda
IL_0cc5: ldarg.0
IL_0cc6: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0ccb: brtrue.s IL_0cda
IL_0ccd: ldarg.0
IL_0cce: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0cd3: brtrue.s IL_0cda
IL_0cd5: call System.Void TheForestOfLove.Content.CentralForestSpawner::RefreshDustinTargetDialogue()
IL_0cda: ldarg.1
IL_0cdb: ldstr "act3_wolfquest_finished_scarlett_intro"
IL_0ce0: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0ce5: brfalse.s IL_0cf8
IL_0ce7: ldarg.0
IL_0ce8: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0ced: brtrue.s IL_0cf7
IL_0cef: ldarg.0
IL_0cf0: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0cf5: brfalse.s IL_0cf8
IL_0cf7: ret
IL_0cf8: ldarg.1
IL_0cf9: ldstr "act3_wolfquest_finished_scarlett_intro2"
IL_0cfe: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0d03: brfalse.s IL_0d16
IL_0d05: ldarg.0
IL_0d06: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0d0b: brtrue.s IL_0d15
IL_0d0d: ldarg.0
IL_0d0e: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0d13: brfalse.s IL_0d16
IL_0d15: ret
IL_0d16: ldarg.1
IL_0d17: ldstr "act3_wolfquest_finished_eavesdropping"
IL_0d1c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0d21: brfalse.s IL_0d34
IL_0d23: ldarg.0
IL_0d24: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0d29: brtrue.s IL_0d33
IL_0d2b: ldarg.0
IL_0d2c: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0d31: brfalse.s IL_0d34
IL_0d33: ret
IL_0d34: ldarg.1
IL_0d35: ldstr "act3_wolfquest_show_fen_rascal_movie"
IL_0d3a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0d3f: brfalse.s IL_0d5d
IL_0d41: ldarg.0
IL_0d42: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0d47: brtrue.s IL_0d51
IL_0d49: ldarg.0
IL_0d4a: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0d4f: brfalse.s IL_0d52
IL_0d51: ret
IL_0d52: ldc.i4 6100
IL_0d57: ldnull
IL_0d58: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0d5d: ldarg.1
IL_0d5e: ldstr "act3_wolfquest_show_fen_rascal_movie_unlock"
IL_0d63: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0d68: brfalse.s IL_0dca
IL_0d6a: ldc.i4 6100
IL_0d6f: ldnull
IL_0d70: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0d75: ldstr "Act3_MouseQuest_4"
IL_0d7a: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_0d7f: call System.Void TheForestOfLove.Narrative.NarrativeActions::LogNewlyEnteredStep(TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_0d84: ldarg.0
IL_0d85: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0d8a: brtrue.s IL_0d94
IL_0d8c: ldarg.0
IL_0d8d: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0d92: brfalse.s IL_0daa
IL_0d94: ldc.i4 450
IL_0d99: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0d9e: ldc.i4 460
IL_0da3: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0da8: br.s IL_0dca
IL_0daa: ldc.i4.1
IL_0dab: stsfld System.Boolean Globals::isCheatCode
IL_0db0: ldc.i4 450
IL_0db5: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0dba: ldc.i4.0
IL_0dbb: stsfld System.Boolean Globals::isCheatCode
IL_0dc0: ldc.i4 460
IL_0dc5: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0dca: ldarg.1
IL_0dcb: ldstr "act3_wolfquest_finished_fen_calls_scarlett_back"
IL_0dd0: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0dd5: brfalse.s IL_0ded
IL_0dd7: ldarg.0
IL_0dd8: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0ddd: brtrue.s IL_0de7
IL_0ddf: ldarg.0
IL_0de0: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0de5: brfalse.s IL_0de8
IL_0de7: ret
IL_0de8: call System.Void TheForestOfLove.Act3WolfQuestScarlettFenPostSexCandidCutscene::StartCutscene()
IL_0ded: ldarg.1
IL_0dee: ldstr "act3_wolfquest_finished_fen_says_farewell_to_scarlett"
IL_0df3: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0df8: brfalse.s IL_0e10
IL_0dfa: ldarg.0
IL_0dfb: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0e00: brtrue.s IL_0e0a
IL_0e02: ldarg.0
IL_0e03: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0e08: brfalse.s IL_0e0b
IL_0e0a: ret
IL_0e0b: call System.Void TheForestOfLove.Act3WolfQuestScarlettFenPostSexCandidCutscene::EndCutscene()
IL_0e10: ldarg.1
IL_0e11: ldstr "act3_wolfquest_finished_scarlett_sees_the_plant"
IL_0e16: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0e1b: brfalse.s IL_0e2e
IL_0e1d: ldarg.0
IL_0e1e: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0e23: brtrue.s IL_0e2d
IL_0e25: ldarg.0
IL_0e26: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0e2b: brfalse.s IL_0e2e
IL_0e2d: ret
IL_0e2e: ldarg.1
IL_0e2f: ldstr "act3_wolfquest_finished_scarlett_says_farewell"
IL_0e34: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0e39: brfalse.s IL_0e51
IL_0e3b: ldarg.0
IL_0e3c: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0e41: brtrue.s IL_0e4b
IL_0e43: ldarg.0
IL_0e44: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0e49: brfalse.s IL_0e4c
IL_0e4b: ret
IL_0e4c: call System.Void TheForestOfLove.Content.DeepWoodsFirstForkSpawner::Act3WolfQuestRemovePathBlockers()
IL_0e51: ldarg.1
IL_0e52: ldstr "show_mouse_orgy_movie"
IL_0e57: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0e5c: brfalse.s IL_0ecb
IL_0e5e: ldarg.0
IL_0e5f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0e64: brtrue.s IL_0e6e
IL_0e66: ldarg.0
IL_0e67: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0e6c: brfalse.s IL_0e97
IL_0e6e: ldc.i4 460
IL_0e73: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0e78: ldc.i4 410
IL_0e7d: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0e82: ldc.i4 450
IL_0e87: call System.Void TheForestOfLove.Narrative.NarrativeActions::ClearInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0e8c: ldc.i4 450
IL_0e91: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0e96: ret
IL_0e97: ldc.i4 6200
IL_0e9c: ldnull
IL_0e9d: call System.Void TheForestOfLove.QuestTriggerHandler::PlayMovie(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0ea2: ldc.r4 4
IL_0ea7: ldsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9__8_4
IL_0eac: dup
IL_0ead: brtrue.s IL_0ec6
IL_0eaf: pop
IL_0eb0: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9
IL_0eb5: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<ExecuteTrigger>b__8_4()
IL_0ebb: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0ec0: dup
IL_0ec1: stsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3/<>c::<>9__8_4
IL_0ec6: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0ecb: ldarg.1
IL_0ecc: ldstr "mouse_orgy_movie_begin_narration"
IL_0ed1: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0ed6: brfalse.s IL_0f09
IL_0ed8: ldarg.0
IL_0ed9: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0ede: brtrue.s IL_0ef9
IL_0ee0: ldarg.0
IL_0ee1: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0ee6: brtrue.s IL_0ef9
IL_0ee8: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_0eed: ldstr "DeepWoods_Campfire"
IL_0ef2: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0ef7: brfalse.s IL_0efa
IL_0ef9: ret
IL_0efa: ldsfld TheForestOfLove.Content.DeepWoodsCampfireSpawner TheForestOfLove.Content.DeepWoodsCampfireSpawner::instance
IL_0eff: callvirt AreaContent TheForestOfLove.Content.DeepWoodsCampfireSpawner::get_Campfire()
IL_0f04: callvirt System.Void AreaContent::Disable()
IL_0f09: ldarg.1
IL_0f0a: ldstr "mouse_orgy_movie_resume_narration"
IL_0f0f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0f14: brfalse.s IL_0f47
IL_0f16: ldarg.0
IL_0f17: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0f1c: brtrue.s IL_0f37
IL_0f1e: ldarg.0
IL_0f1f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0f24: brtrue.s IL_0f37
IL_0f26: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_CurrentSceneName()
IL_0f2b: ldstr "DeepWoods_Campfire"
IL_0f30: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0f35: brfalse.s IL_0f38
IL_0f37: ret
IL_0f38: ldsfld TheForestOfLove.Content.DeepWoodsCampfireSpawner TheForestOfLove.Content.DeepWoodsCampfireSpawner::instance
IL_0f3d: callvirt AreaContent TheForestOfLove.Content.DeepWoodsCampfireSpawner::get_Campfire()
IL_0f42: callvirt System.Void AreaContent::Enable()
IL_0f47: ldarg.1
IL_0f48: ldstr "show_mouse_orgy_movie_unlock"
IL_0f4d: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0f52: brfalse.s IL_0f6a
IL_0f54: ldc.i4 6200
IL_0f59: ldnull
IL_0f5a: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::MouseQuestFinishedPostMovieDialogue()
IL_0f60: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_0f65: call System.Void TheForestOfLove.QuestTriggerHandler::HandleMovieUnlock(TheForestOfLove.Narrative.Movie,UnityEngine.Events.UnityAction)
IL_0f6a: ret
