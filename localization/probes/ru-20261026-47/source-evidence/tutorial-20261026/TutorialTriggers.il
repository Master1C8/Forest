TYPE TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1
METHOD System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::ExecuteTrigger(System.String)
IL_0000: ldarg.1
IL_0001: ldstr "bunnyhouse_card"
IL_0006: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_000b: brfalse.s IL_0023
IL_000d: ldarg.0
IL_000e: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0013: brtrue.s IL_001d
IL_0015: ldarg.0
IL_0016: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_001b: brfalse.s IL_001e
IL_001d: ret
IL_001e: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::DisableGreetingCard()
IL_0023: ldarg.1
IL_0024: ldstr "bunnyhouse_chocolates"
IL_0029: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_002e: brfalse.s IL_0046
IL_0030: ldarg.0
IL_0031: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0036: brtrue.s IL_0040
IL_0038: ldarg.0
IL_0039: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_003e: brfalse.s IL_0041
IL_0040: ret
IL_0041: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::DisableChocolates()
IL_0046: ldarg.1
IL_0047: ldstr "bunnyhouse_food"
IL_004c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0051: brfalse.s IL_0069
IL_0053: ldarg.0
IL_0054: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0059: brtrue.s IL_0063
IL_005b: ldarg.0
IL_005c: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0061: brfalse.s IL_0064
IL_0063: ret
IL_0064: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::DisableFood()
IL_0069: ldarg.1
IL_006a: ldstr "otter_interrupts_red"
IL_006f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0074: brfalse.s IL_00b8
IL_0076: ldarg.0
IL_0077: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_007c: brtrue.s IL_008e
IL_007e: ldarg.0
IL_007f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0084: brtrue.s IL_008e
IL_0086: ldarg.0
IL_0087: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_008c: brfalse.s IL_008f
IL_008e: ret
IL_008f: ldc.r4 1.5
IL_0094: ldsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9__3_0
IL_0099: dup
IL_009a: brtrue.s IL_00b3
IL_009c: pop
IL_009d: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9
IL_00a2: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<ExecuteTrigger>b__3_0()
IL_00a8: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00ad: dup
IL_00ae: stsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9__3_0
IL_00b3: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_00b8: ldarg.1
IL_00b9: ldstr "tutorial_new_quest"
IL_00be: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00c3: brfalse.s IL_00f3
IL_00c5: ldarg.0
IL_00c6: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_00cb: brtrue.s IL_00dd
IL_00cd: ldarg.0
IL_00ce: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_00d3: brtrue.s IL_00dd
IL_00d5: ldarg.0
IL_00d6: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_00db: brfalse.s IL_00de
IL_00dd: ret
IL_00de: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.TutorialQuestBunnyIntroduction>()
IL_00e3: stloc.0
IL_00e4: ldloc.0
IL_00e5: ldnull
IL_00e6: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00eb: brfalse.s IL_00f3
IL_00ed: ldloc.0
IL_00ee: callvirt System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::Show_NewQuestAvailable()
IL_00f3: ldarg.1
IL_00f4: ldstr "tutorial_reprompt_quest"
IL_00f9: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00fe: brfalse.s IL_012e
IL_0100: ldarg.0
IL_0101: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_0106: brtrue.s IL_0118
IL_0108: ldarg.0
IL_0109: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_010e: brtrue.s IL_0118
IL_0110: ldarg.0
IL_0111: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0116: brfalse.s IL_0119
IL_0118: ret
IL_0119: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.TutorialQuestBunnyIntroduction>()
IL_011e: stloc.1
IL_011f: ldloc.1
IL_0120: ldnull
IL_0121: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0126: brfalse.s IL_012e
IL_0128: ldloc.1
IL_0129: callvirt System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::Show_RepromptQuest()
IL_012e: ldarg.1
IL_012f: ldstr "tutorial_turn_in_quest"
IL_0134: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0139: brfalse.s IL_0169
IL_013b: ldarg.0
IL_013c: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_0141: brtrue.s IL_0153
IL_0143: ldarg.0
IL_0144: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0149: brtrue.s IL_0153
IL_014b: ldarg.0
IL_014c: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0151: brfalse.s IL_0154
IL_0153: ret
IL_0154: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.TutorialQuestBunnyIntroduction>()
IL_0159: stloc.2
IL_015a: ldloc.2
IL_015b: ldnull
IL_015c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0161: brfalse.s IL_0169
IL_0163: ldloc.2
IL_0164: callvirt System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::Show_TurnInQuest()
IL_0169: ldarg.1
IL_016a: ldstr "tutorial_extra_dialogue"
IL_016f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0174: brfalse.s IL_01a4
IL_0176: ldarg.0
IL_0177: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_017c: brtrue.s IL_018e
IL_017e: ldarg.0
IL_017f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0184: brtrue.s IL_018e
IL_0186: ldarg.0
IL_0187: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_018c: brfalse.s IL_018f
IL_018e: ret
IL_018f: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.TutorialQuestBunnyIntroduction>()
IL_0194: stloc.3
IL_0195: ldloc.3
IL_0196: ldnull
IL_0197: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_019c: brfalse.s IL_01a4
IL_019e: ldloc.3
IL_019f: callvirt System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::Show_ContinueTopic()
IL_01a4: ldarg.1
IL_01a5: ldstr "tutorial_finished"
IL_01aa: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01af: brfalse.s IL_01da
IL_01b1: ldarg.0
IL_01b2: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_01b7: brtrue.s IL_01c1
IL_01b9: ldarg.0
IL_01ba: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_01bf: brfalse.s IL_01c2
IL_01c1: ret
IL_01c2: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.TutorialQuestBunnyIntroduction>()
IL_01c7: stloc.s V_4
IL_01c9: ldloc.s V_4
IL_01cb: ldnull
IL_01cc: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_01d1: brfalse.s IL_01da
IL_01d3: ldloc.s V_4
IL_01d5: callvirt System.Void TheForestOfLove.TutorialQuestBunnyIntroduction::HideAll()
IL_01da: ldarg.1
IL_01db: ldstr "check_otter_chocolates"
IL_01e0: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_01e5: brfalse.s IL_020c
IL_01e7: ldarg.0
IL_01e8: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isDialogueSkip()
IL_01ed: brtrue.s IL_01ff
IL_01ef: ldarg.0
IL_01f0: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_01f5: brtrue.s IL_01ff
IL_01f7: ldarg.0
IL_01f8: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_01fd: brfalse.s IL_0200
IL_01ff: ret
IL_0200: ldc.i4.s 20
IL_0202: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0207: call System.Void TheForestOfLove.Narrative.DialogueService::SetDialogueSystemBoolCondition(System.Boolean)
IL_020c: ldarg.1
IL_020d: ldstr "intro_from_beaver"
IL_0212: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0217: brtrue.s IL_0243
IL_0219: ldarg.1
IL_021a: ldstr "intro_from_mouse"
IL_021f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0224: brtrue.s IL_0243
IL_0226: ldarg.1
IL_0227: ldstr "intro_from_otter"
IL_022c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0231: brtrue.s IL_0243
IL_0233: ldarg.1
IL_0234: ldstr "give_sugar_to_bunny"
IL_0239: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_023e: brfalse IL_02ce
IL_0243: ldstr "Act1_TutorialQuest"
IL_0248: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.QuestTriggerHelper::LoadQuestStatus(System.String)
IL_024d: ldc.i4 200
IL_0252: beq.s IL_028e
IL_0254: ldstr "intro_from_beaver"
IL_0259: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerFired(System.String)
IL_025e: brfalse.s IL_028e
IL_0260: ldstr "intro_from_mouse"
IL_0265: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerFired(System.String)
IL_026a: brfalse.s IL_028e
IL_026c: ldstr "intro_from_otter"
IL_0271: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerFired(System.String)
IL_0276: brfalse.s IL_028e
IL_0278: ldstr "give_sugar_to_bunny"
IL_027d: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerFired(System.String)
IL_0282: brfalse.s IL_028e
IL_0284: ldstr "Act1_TutorialQuest"
IL_0289: call System.Void TheForestOfLove.QuestTriggerHelper::CompleteQuest(System.String)
IL_028e: ldarg.1
IL_028f: ldstr "give_sugar_to_bunny"
IL_0294: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0299: brfalse.s IL_02ce
IL_029b: ldstr "intro_from_beaver"
IL_02a0: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerFired(System.String)
IL_02a5: brfalse.s IL_02bf
IL_02a7: ldstr "intro_from_mouse"
IL_02ac: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerFired(System.String)
IL_02b1: brfalse.s IL_02bf
IL_02b3: ldstr "intro_from_otter"
IL_02b8: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerFired(System.String)
IL_02bd: brtrue.s IL_02ce
IL_02bf: ldstr "Act1_TutorialQuest_3"
IL_02c4: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_02c9: call System.Void TheForestOfLove.Narrative.NarrativeActions::LogNewlyEnteredStep(TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_02ce: ldarg.1
IL_02cf: ldstr "epiphany"
IL_02d4: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_02d9: brfalse IL_03af
IL_02de: newobj System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c__DisplayClass3_0::.ctor()
IL_02e3: stloc.s V_5
IL_02e5: ldarg.0
IL_02e6: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_02eb: brtrue.s IL_02f5
IL_02ed: ldarg.0
IL_02ee: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_02f3: brfalse.s IL_02f6
IL_02f5: ret
IL_02f6: ldloc.s V_5
IL_02f8: ldstr "Finley"
IL_02fd: call TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Gameplay.SpawnableActor::FindActorByName(System.String)
IL_0302: stfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c__DisplayClass3_0::finley
IL_0307: ldsfld TheForestOfLove.Content.MountainsSpawner TheForestOfLove.Content.MountainsSpawner::instance
IL_030c: ldnull
IL_030d: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0312: brtrue.s IL_0335
IL_0314: ldloc.s V_5
IL_0316: ldfld TheForestOfLove.Gameplay.SpawnableActor TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c__DisplayClass3_0::finley
IL_031b: ldnull
IL_031c: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0321: brtrue.s IL_0335
IL_0323: ldsfld TheForestOfLove.Content.MountainsSpawner TheForestOfLove.Content.MountainsSpawner::instance
IL_0328: callvirt AreaContent TheForestOfLove.Content.MountainsSpawner::get_EaselCameraTarget()
IL_032d: ldnull
IL_032e: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0333: brfalse.s IL_0369
IL_0335: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_033a: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_033f: ldc.r4 4
IL_0344: ldsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9__3_6
IL_0349: dup
IL_034a: brtrue.s IL_0363
IL_034c: pop
IL_034d: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9
IL_0352: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<ExecuteTrigger>b__3_6()
IL_0358: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_035d: dup
IL_035e: stsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9__3_6
IL_0363: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0368: ret
IL_0369: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_036e: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0373: ldsfld TheForestOfLove.Content.MountainsSpawner TheForestOfLove.Content.MountainsSpawner::instance
IL_0378: callvirt AreaContent TheForestOfLove.Content.MountainsSpawner::get_EaselCameraTarget()
IL_037d: callvirt !!0 UnityEngine.Component::GetComponentInChildren<TheForestOfLove.Cameras.CameraSettings>()
IL_0382: stloc.s V_6
IL_0384: ldloc.s V_5
IL_0386: ldsfld TheForestOfLove.Cameras.CameraController TheForestOfLove.Cameras.CameraController::current
IL_038b: ldloc.s V_6
IL_038d: ldc.i4.0
IL_038e: callvirt System.Int32 TheForestOfLove.Cameras.CameraController::PushSettings(TheForestOfLove.Cameras.CameraSettings,System.Boolean)
IL_0393: stfld System.Int32 TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c__DisplayClass3_0::id
IL_0398: ldc.r4 4
IL_039d: ldloc.s V_5
IL_039f: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c__DisplayClass3_0::<ExecuteTrigger>b__7()
IL_03a5: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_03aa: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_03af: ldarg.1
IL_03b0: ldstr "notebook_unlocked"
IL_03b5: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03ba: brfalse.s IL_03e5
IL_03bc: ldarg.0
IL_03bd: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_03c2: brtrue.s IL_03cc
IL_03c4: ldarg.0
IL_03c5: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_03ca: brfalse.s IL_03cd
IL_03cc: ret
IL_03cd: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ItemGetNotification>()
IL_03d2: stloc.s V_7
IL_03d4: ldloc.s V_7
IL_03d6: ldnull
IL_03d7: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_03dc: brfalse.s IL_03e5
IL_03de: ldloc.s V_7
IL_03e0: callvirt System.Void TheForestOfLove.ItemGetNotification::ShowGossipTutorial()
IL_03e5: ldarg.1
IL_03e6: ldstr "player_inspects_gator_shoreline"
IL_03eb: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03f0: brfalse.s IL_0436
IL_03f2: ldarg.0
IL_03f3: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_03f8: brtrue.s IL_0402
IL_03fa: ldarg.0
IL_03fb: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0400: brfalse.s IL_0403
IL_0402: ret
IL_0403: ldarg.0
IL_0404: ldarg.0
IL_0405: ldfld System.Int32 TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::gatorCrossingExaminableBranch
IL_040a: ldc.i4.1
IL_040b: add
IL_040c: stloc.s V_9
IL_040e: ldloc.s V_9
IL_0410: stfld System.Int32 TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::gatorCrossingExaminableBranch
IL_0415: ldloc.s V_9
IL_0417: ldc.i4.3
IL_0418: rem
IL_0419: call System.Void TheForestOfLove.Narrative.DialogueService::SetDialogueSystemBranchCondition(System.Int32)
IL_041e: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.GatorIntroductionCutscene>()
IL_0423: stloc.s V_8
IL_0425: ldloc.s V_8
IL_0427: ldnull
IL_0428: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_042d: brfalse.s IL_0436
IL_042f: ldloc.s V_8
IL_0431: callvirt System.Void TheForestOfLove.GatorIntroductionCutscene::OnPlayerInspectedShoreline()
IL_0436: ldarg.1
IL_0437: ldstr "gator_emerges"
IL_043c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0441: brfalse.s IL_046c
IL_0443: ldarg.0
IL_0444: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0449: brtrue.s IL_0453
IL_044b: ldarg.0
IL_044c: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0451: brfalse.s IL_0454
IL_0453: ret
IL_0454: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.GatorIntroductionCutscene>()
IL_0459: stloc.s V_10
IL_045b: ldloc.s V_10
IL_045d: ldnull
IL_045e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0463: brfalse.s IL_046c
IL_0465: ldloc.s V_10
IL_0467: callvirt System.Void TheForestOfLove.GatorIntroductionCutscene::StartCutscene()
IL_046c: ldarg.1
IL_046d: ldstr "gator_submerges"
IL_0472: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0477: brfalse.s IL_0499
IL_0479: ldstr "Act1_DashQuest"
IL_047e: call TheForestOfLove.Narrative.Quest TheForestOfLove.Services.Persistence.DataService::GetQuestByDbName(System.String)
IL_0483: stloc.s V_11
IL_0485: ldloc.s V_11
IL_0487: brfalse.s IL_0499
IL_0489: ldloc.s V_11
IL_048b: callvirt TheForestOfLove.Narrative.QuestStatus TheForestOfLove.Narrative.Quest::get_status()
IL_0490: brtrue.s IL_0499
IL_0492: ldloc.s V_11
IL_0494: callvirt System.Void TheForestOfLove.Narrative.Quest::SetStatusStarted()
IL_0499: ldarg.1
IL_049a: ldstr "hop_onto_gator"
IL_049f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04a4: brfalse.s IL_04d4
IL_04a6: ldarg.0
IL_04a7: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_04ac: brtrue.s IL_04b6
IL_04ae: ldarg.0
IL_04af: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_04b4: brfalse.s IL_04bc
IL_04b6: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::OnFinishGatorIntroductionCutscene()
IL_04bb: ret
IL_04bc: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.PlayerGatorCrossing>()
IL_04c1: stloc.s V_12
IL_04c3: ldloc.s V_12
IL_04c5: ldnull
IL_04c6: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_04cb: brfalse.s IL_04d4
IL_04cd: ldloc.s V_12
IL_04cf: callvirt System.Void TheForestOfLove.PlayerGatorCrossing::BeginCutscene()
IL_04d4: ldarg.1
IL_04d5: ldstr "begin_first_fast_travel"
IL_04da: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_04df: brfalse.s IL_050b
IL_04e1: ldarg.0
IL_04e2: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_04e7: brtrue.s IL_04f1
IL_04e9: ldarg.0
IL_04ea: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_04ef: brfalse.s IL_050b
IL_04f1: ldc.i4 180
IL_04f6: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_04fb: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::OnFoundBlueFastTravelBell()
IL_0500: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::OnPickedUpAtLeastOnePieceOfWood()
IL_0505: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerFastTravel::OnFastTravelFirstIdleConvo()
IL_050a: ret
IL_050b: ldarg.1
IL_050c: ldstr "return_to_gator"
IL_0511: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0516: brfalse.s IL_0538
IL_0518: ldarg.0
IL_0519: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_051e: brtrue.s IL_0528
IL_0520: ldarg.0
IL_0521: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0526: brfalse.s IL_0533
IL_0528: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::OnPickedUpGatorWoodStack()
IL_052d: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::OnCollectedEnoughWood()
IL_0532: ret
IL_0533: call System.Void TheForestOfLove.Content.LakeSpawner::SetupGatorWoodStackCollectible()
IL_0538: ldarg.1
IL_0539: ldstr "pick_up_wood"
IL_053e: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0543: pop
IL_0544: ldarg.1
IL_0545: ldstr "beaver_started_toy"
IL_054a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_054f: brfalse.s IL_0595
IL_0551: ldarg.0
IL_0552: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0557: brtrue.s IL_0561
IL_0559: ldarg.0
IL_055a: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_055f: brfalse.s IL_0562
IL_0561: ret
IL_0562: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_0567: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_056c: ldc.r4 1
IL_0571: ldsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9__3_1
IL_0576: dup
IL_0577: brtrue.s IL_0590
IL_0579: pop
IL_057a: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9
IL_057f: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<ExecuteTrigger>b__3_1()
IL_0585: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_058a: dup
IL_058b: stsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9__3_1
IL_0590: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0595: ldarg.1
IL_0596: ldstr "deliver_dildo"
IL_059b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_05a0: brfalse.s IL_05b8
IL_05a2: ldarg.0
IL_05a3: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_05a8: brtrue.s IL_05b2
IL_05aa: ldarg.0
IL_05ab: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_05b0: brfalse.s IL_05b3
IL_05b2: ret
IL_05b3: call System.Void TheForestOfLove.Content.CentralForestSpawner::SpawnBuckyAfterBridgeQuestDildoDelivery()
IL_05b8: ldarg.1
IL_05b9: ldstr "got_swim_floaties"
IL_05be: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_05c3: brfalse.s IL_05ee
IL_05c5: ldarg.0
IL_05c6: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_05cb: brtrue.s IL_05d5
IL_05cd: ldarg.0
IL_05ce: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_05d3: brfalse.s IL_05d6
IL_05d5: ret
IL_05d6: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ItemGetNotification>()
IL_05db: stloc.s V_13
IL_05dd: ldloc.s V_13
IL_05df: ldnull
IL_05e0: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_05e5: brfalse.s IL_05ee
IL_05e7: ldloc.s V_13
IL_05e9: callvirt System.Void TheForestOfLove.ItemGetNotification::ShowSwimFloatiesNotification()
IL_05ee: ldarg.1
IL_05ef: ldstr "bridgequest_give_final_wood_to_beaver"
IL_05f4: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_05f9: brfalse.s IL_0615
IL_05fb: ldarg.0
IL_05fc: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0601: brtrue.s IL_060b
IL_0603: ldarg.0
IL_0604: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0609: brfalse.s IL_060c
IL_060b: ret
IL_060c: ldc.i4.s 60
IL_060e: ldc.i4.s 25
IL_0610: call System.Void TheForestOfLove.Narrative.NarrativeActions::RemoveInventoryItem(TheForestOfLove.Inventory.InventoryItemType,System.Int32)
IL_0615: ldarg.1
IL_0616: ldstr "act1_greetingsquest_bunny_finished_intro"
IL_061b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0620: brfalse.s IL_0655
IL_0622: ldarg.0
IL_0623: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0628: brtrue.s IL_0632
IL_062a: ldarg.0
IL_062b: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0630: brfalse.s IL_0633
IL_0632: ret
IL_0633: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.QuestUpdatedUI>()
IL_0638: stloc.s V_14
IL_063a: ldloc.s V_14
IL_063c: ldnull
IL_063d: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0642: brfalse.s IL_0655
IL_0644: ldloc.s V_14
IL_0646: ldstr "Check in with Scarlett."
IL_064b: ldstr "Say hi to four more critters."
IL_0650: callvirt System.Void TheForestOfLove.QuestUpdatedUI::ShowNotification(System.String,System.String)
IL_0655: ldarg.1
IL_0656: ldstr "greetingsquest_critter_introduced_dustin"
IL_065b: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0660: brtrue.s IL_068c
IL_0662: ldarg.1
IL_0663: ldstr "greetingsquest_critter_introduced_finley"
IL_0668: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_066d: brtrue.s IL_068c
IL_066f: ldarg.1
IL_0670: ldstr "greetingsquest_critter_introduced_penny"
IL_0675: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_067a: brtrue.s IL_068c
IL_067c: ldarg.1
IL_067d: ldstr "greetingsquest_critter_introduced_augustus"
IL_0682: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0687: brfalse IL_0779
IL_068c: ldstr "Act1_GreetingsQuest"
IL_0691: call TheForestOfLove.Narrative.Quest TheForestOfLove.Services.Persistence.DataService::GetQuestByDbName(System.String)
IL_0696: stloc.s V_15
IL_0698: ldarg.0
IL_0699: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_069e: brtrue.s IL_06a8
IL_06a0: ldarg.0
IL_06a1: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_06a6: brfalse.s IL_06bd
IL_06a8: ldarg.1
IL_06a9: ldstr "greetingsquest_critter_introduced_dustin"
IL_06ae: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_06b3: brfalse.s IL_06bc
IL_06b5: ldloc.s V_15
IL_06b7: callvirt System.Void TheForestOfLove.Narrative.Quest::SetStatusCompleted()
IL_06bc: ret
IL_06bd: ldloc.s V_15
IL_06bf: callvirt System.Boolean TheForestOfLove.Narrative.Quest::get_isCompleted()
IL_06c4: brfalse.s IL_06c7
IL_06c6: ret
IL_06c7: ldarg.1
IL_06c8: brfalse.s IL_0742
IL_06ca: ldarg.1
IL_06cb: ldstr "greetingsquest_critter_introduced_augustus"
IL_06d0: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_06d5: brtrue.s IL_0700
IL_06d7: ldarg.1
IL_06d8: ldstr "greetingsquest_critter_introduced_dustin"
IL_06dd: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_06e2: brtrue.s IL_0711
IL_06e4: ldarg.1
IL_06e5: ldstr "greetingsquest_critter_introduced_finley"
IL_06ea: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_06ef: brtrue.s IL_0722
IL_06f1: ldarg.1
IL_06f2: ldstr "greetingsquest_critter_introduced_penny"
IL_06f7: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_06fc: brtrue.s IL_0733
IL_06fe: br.s IL_0742
IL_0700: ldstr "Act1_GreetingsQuest_3"
IL_0705: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_070a: call System.Void TheForestOfLove.Narrative.NarrativeActions::LogNewlyEnteredStep(TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_070f: br.s IL_0742
IL_0711: ldstr "Act1_GreetingsQuest_1"
IL_0716: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_071b: call System.Void TheForestOfLove.Narrative.NarrativeActions::LogNewlyEnteredStep(TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_0720: br.s IL_0742
IL_0722: ldstr "Act1_GreetingsQuest_2"
IL_0727: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_072c: call System.Void TheForestOfLove.Narrative.NarrativeActions::LogNewlyEnteredStep(TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_0731: br.s IL_0742
IL_0733: ldstr "Act1_GreetingsQuest_0"
IL_0738: call TheForestOfLove.Narrative.QuestProgressLogEntry TheForestOfLove.Services.Persistence.DataService::GetQuestProgressLogByDbName(System.String)
IL_073d: call System.Void TheForestOfLove.Narrative.NarrativeActions::LogNewlyEnteredStep(TheForestOfLove.Narrative.QuestProgressLogEntry)
IL_0742: ldstr "Penny"
IL_0747: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorIntroduced(System.String)
IL_074c: brfalse.s IL_0779
IL_074e: ldstr "Dustin"
IL_0753: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorIntroduced(System.String)
IL_0758: brfalse.s IL_0779
IL_075a: ldstr "Finley"
IL_075f: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorIntroduced(System.String)
IL_0764: brfalse.s IL_0779
IL_0766: ldstr "Augustus"
IL_076b: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorEncountered(System.String)
IL_0770: brfalse.s IL_0779
IL_0772: ldloc.s V_15
IL_0774: call System.Void TheForestOfLove.Narrative.NarrativeActions::CompleteQuest(TheForestOfLove.Narrative.Quest)
IL_0779: ldarg.1
IL_077a: ldstr "begin_the_race"
IL_077f: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0784: brfalse.s IL_07b9
IL_0786: ldarg.0
IL_0787: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_078c: brtrue.s IL_0796
IL_078e: ldarg.0
IL_078f: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0794: brfalse.s IL_07a1
IL_0796: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::OnDashQuestAbilityLearned()
IL_079b: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::OnDashQuestMinigameFinished()
IL_07a0: ret
IL_07a1: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.DashQuestController>()
IL_07a6: stloc.s V_16
IL_07a8: ldloc.s V_16
IL_07aa: ldnull
IL_07ab: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_07b0: brfalse.s IL_07b9
IL_07b2: ldloc.s V_16
IL_07b4: callvirt System.Void TheForestOfLove.DashQuestController::BeginDashQuest()
IL_07b9: ldarg.1
IL_07ba: ldstr "plant_quest_finished_intro"
IL_07bf: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_07c4: brfalse.s IL_07dc
IL_07c6: ldarg.0
IL_07c7: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_07cc: brtrue.s IL_07d6
IL_07ce: ldarg.0
IL_07cf: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_07d4: brfalse.s IL_07d7
IL_07d6: ret
IL_07d7: call System.Void TheForestOfLove.Content.CentralForestSpawner::DisableMabel()
IL_07dc: ldarg.1
IL_07dd: ldstr "plant_sex_scene"
IL_07e2: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_07e7: brfalse.s IL_085e
IL_07e9: ldarg.0
IL_07ea: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_07ef: brtrue.s IL_07f9
IL_07f1: ldarg.0
IL_07f2: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_07f7: brfalse.s IL_080a
IL_07f9: ldc.i4.3
IL_07fa: call System.Void TheForestOfLove.QuestTriggerHelper::UnlockMovie(TheForestOfLove.Narrative.Movie)
IL_07ff: ldstr "sex_scene_unlocked_plant"
IL_0804: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_0809: ret
IL_080a: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Plant>()
IL_080f: stloc.s V_17
IL_0811: ldloc.s V_17
IL_0813: ldnull
IL_0814: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0819: brfalse.s IL_081c
IL_081b: ret
IL_081c: ldloc.s V_17
IL_081e: ldc.i4.0
IL_081f: callvirt System.Void TheForestOfLove.Plant::SetFuckable(System.Boolean)
IL_0824: ldloc.s V_17
IL_0826: callvirt System.Void TheForestOfLove.Plant::AwakenPlant()
IL_082b: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_0830: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0835: ldc.r4 2
IL_083a: ldsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9__3_8
IL_083f: dup
IL_0840: brtrue.s IL_0859
IL_0842: pop
IL_0843: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9
IL_0848: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<ExecuteTrigger>b__3_8()
IL_084e: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0853: dup
IL_0854: stsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9__3_8
IL_0859: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_085e: ldarg.1
IL_085f: ldstr "extract_the_seeds"
IL_0864: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0869: brfalse.s IL_08a1
IL_086b: ldarg.0
IL_086c: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0871: brtrue.s IL_087b
IL_0873: ldarg.0
IL_0874: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0879: brfalse.s IL_0881
IL_087b: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::OnPlayerWonMinigame()
IL_0880: ret
IL_0881: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_0886: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_088b: ldc.r4 1
IL_0890: ldarg.0
IL_0891: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::<ExecuteTrigger>b__3_2()
IL_0897: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_089c: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_08a1: ldarg.1
IL_08a2: ldstr "bunny_sex_scene"
IL_08a7: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_08ac: brfalse.s IL_08d5
IL_08ae: ldarg.0
IL_08af: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_08b4: brtrue.s IL_08be
IL_08b6: ldarg.0
IL_08b7: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_08bc: brfalse.s IL_08cf
IL_08be: ldc.i4.1
IL_08bf: call System.Void TheForestOfLove.QuestTriggerHelper::UnlockMovie(TheForestOfLove.Narrative.Movie)
IL_08c4: ldstr "sex_scene_unlocked_bunny"
IL_08c9: call System.Void TheForestOfLove.QuestTriggerHelper::SetTrigger(System.String)
IL_08ce: ret
IL_08cf: ldc.i4.1
IL_08d0: call System.Void TheForestOfLove.Narrative.NarrativeActions::PlayMovie(TheForestOfLove.Narrative.Movie)
IL_08d5: ldarg.1
IL_08d6: ldstr "act1_victory_gathering"
IL_08db: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_08e0: brfalse.s IL_0926
IL_08e2: ldarg.0
IL_08e3: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_08e8: brtrue.s IL_08f2
IL_08ea: ldarg.0
IL_08eb: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_08f0: brfalse.s IL_08f3
IL_08f2: ret
IL_08f3: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_08f8: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_08fd: ldc.r4 2
IL_0902: ldsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9__3_3
IL_0907: dup
IL_0908: brtrue.s IL_0921
IL_090a: pop
IL_090b: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9
IL_0910: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<ExecuteTrigger>b__3_3()
IL_0916: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_091b: dup
IL_091c: stsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9__3_3
IL_0921: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_0926: ldarg.1
IL_0927: ldstr "act1_congrats"
IL_092c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0931: brfalse.s IL_0984
IL_0933: ldarg.0
IL_0934: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0939: brtrue.s IL_0943
IL_093b: ldarg.0
IL_093c: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0941: brfalse.s IL_0949
IL_0943: call System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::OnAct1Completed()
IL_0948: ret
IL_0949: ldc.i4.3
IL_094a: ldnull
IL_094b: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1::OnFinishAct1VictoryScreen()
IL_0951: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0956: call System.Void TheForestOfLove.TutorialHelper::StartTutorial(TheForestOfLove.Tutorial,System.Action)
IL_095b: ldc.r4 3
IL_0960: ldsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9__3_4
IL_0965: dup
IL_0966: brtrue.s IL_097f
IL_0968: pop
IL_0969: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9
IL_096e: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<ExecuteTrigger>b__3_4()
IL_0974: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0979: dup
IL_097a: stsfld System.Action TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9__3_4
IL_097f: call System.Void TheForestOfLove.Core.Timing.TimerHelper::StartTimer(System.Single,System.Action)
IL_0984: ldarg.1
IL_0985: ldstr "act1_victory_sleepover"
IL_098a: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_098f: brfalse.s IL_09d5
IL_0991: ldarg.0
IL_0992: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0997: brtrue.s IL_09a1
IL_0999: ldarg.0
IL_099a: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_099f: brfalse.s IL_09a2
IL_09a1: ret
IL_09a2: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneStart
IL_09a7: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_09ac: ldc.r4 2
IL_09b1: ldsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9__3_5
IL_09b6: dup
IL_09b7: brtrue.s IL_09d0
IL_09b9: pop
IL_09ba: ldsfld TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9
IL_09bf: ldftn System.Void TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<ExecuteTrigger>b__3_5()
IL_09c5: newobj System.Void UnityEngine.Events.UnityAction::.ctor(System.Object,System.IntPtr)
IL_09ca: dup
IL_09cb: stsfld UnityEngine.Events.UnityAction TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct1/<>c::<>9__3_5
IL_09d0: call System.Void TheForestOfLove.CutsceneManager::FadeToBlack(System.Single,UnityEngine.Events.UnityAction)
IL_09d5: ldarg.1
IL_09d6: ldstr "act1_victory_travelbell"
IL_09db: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_09e0: brfalse.s IL_0a2b
IL_09e2: ldc.i4.0
IL_09e3: stloc.s V_18
IL_09e5: ldc.i4 190
IL_09ea: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_09ef: brtrue.s IL_09fe
IL_09f1: ldc.i4.1
IL_09f2: stloc.s V_18
IL_09f4: ldc.i4 190
IL_09f9: call System.Void TheForestOfLove.Narrative.NarrativeActions::AddInventoryItem(TheForestOfLove.Inventory.InventoryItemType)
IL_09fe: ldarg.0
IL_09ff: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isChapterSelect()
IL_0a04: brtrue.s IL_0a0e
IL_0a06: ldarg.0
IL_0a07: call System.Boolean TheForestOfLove.QuestTriggerHandler::get_isCheatCode()
IL_0a0c: brfalse.s IL_0a0f
IL_0a0e: ret
IL_0a0f: ldloc.s V_18
IL_0a11: brfalse.s IL_0a2b
IL_0a13: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.ItemGetNotification>()
IL_0a18: stloc.s V_19
IL_0a1a: ldloc.s V_19
IL_0a1c: ldnull
IL_0a1d: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0a22: brfalse.s IL_0a2b
IL_0a24: ldloc.s V_19
IL_0a26: callvirt System.Void TheForestOfLove.ItemGetNotification::ShowCentralForestBellNotification()
IL_0a2b: ret
