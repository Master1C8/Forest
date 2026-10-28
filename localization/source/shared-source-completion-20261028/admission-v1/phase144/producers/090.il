TYPE TheForestOfLove.Gameplay.FastTravelController
METHOD System.Void TheForestOfLove.Gameplay.FastTravelController::StartInflightDialogue(System.String&,System.String&,System.String&) | attributes=Public, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerLearnedFastTravel()
IL_0005: brtrue.s IL_001d
IL_0007: ldarg.1
IL_0008: ldstr "BridgeQuest_MeetBirdAndFastTravel"
IL_000d: stind.ref
IL_000e: ldarg.2
IL_000f: ldstr "Penny"
IL_0014: stind.ref
IL_0015: ldarg.3
IL_0016: ldstr "inflight_conversation"
IL_001b: stind.ref
IL_001c: ret
IL_001d: ldstr "fast_travel_current_idle_convo"
IL_0022: call System.String TheForestOfLove.Services.Persistence.DataService::GetVariable(System.String)
IL_0027: stloc.0
IL_0028: ldloc.0
IL_0029: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_002e: brfalse.s IL_0041
IL_0030: ldstr "1"
IL_0035: stloc.0
IL_0036: ldstr "fast_travel_current_idle_convo"
IL_003b: ldloc.0
IL_003c: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_0041: ldarg.2
IL_0042: ldstr "Penny"
IL_0047: stind.ref
IL_0048: ldarg.1
IL_0049: ldstr "Idles_FastTravel"
IL_004e: stind.ref
IL_004f: ldarg.3
IL_0050: ldstr "inflight_conversation"
IL_0055: ldloc.0
IL_0056: call System.String System.String::Concat(System.String,System.String)
IL_005b: stind.ref
IL_005c: ret
METHOD System.Void TheForestOfLove.Gameplay.FastTravelController::PlayPennyOnPerchPreTravelDialogue() | attributes=Private, HideBySig | impl=IL
IL_0000: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_0005: brtrue.s IL_0069
IL_0007: ldstr "WolfQuest_AskAround_Bunnies"
IL_000c: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0011: brfalse.s IL_0069
IL_0013: ldstr "WolfQuest_ReturnToWolf"
IL_0018: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_001d: brtrue.s IL_0069
IL_001f: ldstr "WolfQuest_ScarlettFollow_Penny"
IL_0024: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0029: brtrue.s IL_0069
IL_002b: ldstr "WolfQuest_ScarlettFollow_Penny"
IL_0030: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_0035: ldstr "Penny"
IL_003a: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_003f: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_0044: ldsfld System.Action TheForestOfLove.Gameplay.FastTravelController/<>c::<>9__20_0
IL_0049: dup
IL_004a: brtrue.s IL_0063
IL_004c: pop
IL_004d: ldsfld TheForestOfLove.Gameplay.FastTravelController/<>c TheForestOfLove.Gameplay.FastTravelController/<>c::<>9
IL_0052: ldftn System.Void TheForestOfLove.Gameplay.FastTravelController/<>c::<PlayPennyOnPerchPreTravelDialogue>b__20_0()
IL_0058: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_005d: dup
IL_005e: stsfld System.Action TheForestOfLove.Gameplay.FastTravelController/<>c::<>9__20_0
IL_0063: stsfld System.Action TheForestOfLove.QuestConversationHelper::onConversationEnd
IL_0068: ret
IL_0069: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_006e: brtrue.s IL_00bf
IL_0070: ldstr "WolfQuest_MeetTheWolf"
IL_0075: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_007a: brfalse.s IL_00bf
IL_007c: ldstr "WolfQuest_AskAround_Bunnies"
IL_0081: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0086: brtrue.s IL_00bf
IL_0088: ldstr "WolfQuest_AskAround_Penny"
IL_008d: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0092: brtrue.s IL_00bf
IL_0094: ldstr "WolfQuest_AskAround_Penny"
IL_0099: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_009e: ldstr "Penny"
IL_00a3: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_00a8: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_00ad: ldarg.0
IL_00ae: ldftn System.Void TheForestOfLove.Gameplay.FastTravelController::<PlayPennyOnPerchPreTravelDialogue>b__20_1()
IL_00b4: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_00b9: stsfld System.Action TheForestOfLove.QuestConversationHelper::onConversationEnd
IL_00be: ret
IL_00bf: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_00c4: brtrue IL_0165
IL_00c9: ldstr "Act3_AfterstormQuest"
IL_00ce: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.QuestTriggerHelper::LoadQuestStatus(System.String)
IL_00d3: ldc.i4.s 100
IL_00d5: bne.un IL_0165
IL_00da: ldstr "AfterstormQuest_Penny"
IL_00df: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_00e4: brtrue.s IL_0165
IL_00e6: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inMountains()
IL_00eb: brfalse.s IL_013a
IL_00ed: ldc.i4 200
IL_00f2: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_00f7: brfalse.s IL_013a
IL_00f9: ldstr "act3_penny_mountains_perch_first_time_summoned"
IL_00fe: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0103: brtrue.s IL_013a
IL_0105: ldstr "AfterstormQuest_Penny"
IL_010a: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_010f: ldstr "Penny"
IL_0114: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_0119: ldstr "penny_first_mountains_fast_travel_plus_afterstorm"
IL_011e: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_0123: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_0128: ldarg.0
IL_0129: ldftn System.Void TheForestOfLove.Gameplay.FastTravelController::<PlayPennyOnPerchPreTravelDialogue>b__20_2()
IL_012f: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0134: stsfld System.Action TheForestOfLove.QuestConversationHelper::onConversationEnd
IL_0139: ret
IL_013a: ldstr "AfterstormQuest_Penny"
IL_013f: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_0144: ldstr "Penny"
IL_0149: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_014e: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_0153: ldarg.0
IL_0154: ldftn System.Void TheForestOfLove.Gameplay.FastTravelController::<PlayPennyOnPerchPreTravelDialogue>b__20_3()
IL_015a: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_015f: stsfld System.Action TheForestOfLove.QuestConversationHelper::onConversationEnd
IL_0164: ret
IL_0165: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_016a: brtrue.s IL_01c0
IL_016c: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inMountains()
IL_0171: brfalse.s IL_01c0
IL_0173: ldc.i4 200
IL_0178: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_017d: brfalse.s IL_01c0
IL_017f: ldstr "act3_penny_mountains_perch_first_time_summoned"
IL_0184: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0189: brtrue.s IL_01c0
IL_018b: ldstr "AfterstormQuest_Penny"
IL_0190: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_0195: ldstr "Penny"
IL_019a: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_019f: ldstr "penny_first_mountains_fast_travel"
IL_01a4: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_01a9: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_01ae: ldarg.0
IL_01af: ldftn System.Void TheForestOfLove.Gameplay.FastTravelController::<PlayPennyOnPerchPreTravelDialogue>b__20_4()
IL_01b5: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_01ba: stsfld System.Action TheForestOfLove.QuestConversationHelper::onConversationEnd
IL_01bf: ret
IL_01c0: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_01c5: brtrue.s IL_020a
IL_01c7: ldstr "CookieQuest_CookiesAreReady"
IL_01cc: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_01d1: brfalse.s IL_020a
IL_01d3: ldstr "CookieQuest_CD_Penny"
IL_01d8: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_01dd: brtrue.s IL_020a
IL_01df: ldstr "CookieQuest_CD_Penny"
IL_01e4: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_01e9: ldstr "Penny"
IL_01ee: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_01f3: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_01f8: ldarg.0
IL_01f9: ldftn System.Void TheForestOfLove.Gameplay.FastTravelController::<PlayPennyOnPerchPreTravelDialogue>b__20_5()
IL_01ff: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0204: stsfld System.Action TheForestOfLove.QuestConversationHelper::onConversationEnd
IL_0209: ret
IL_020a: call System.Boolean TheForestOfLove.QuestTriggerHelper::InSeasonsGreetingsStoryInstance()
IL_020f: brfalse.s IL_0248
IL_0211: ldstr "SeasonsGreetingsQuest_TalkToPenny"
IL_0216: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_021b: brtrue.s IL_0248
IL_021d: ldstr "SeasonsGreetingsQuest_TalkToPenny"
IL_0222: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_0227: ldstr "Penny"
IL_022c: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_0231: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_0236: ldarg.0
IL_0237: ldftn System.Void TheForestOfLove.Gameplay.FastTravelController::<PlayPennyOnPerchPreTravelDialogue>b__20_6()
IL_023d: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0242: stsfld System.Action TheForestOfLove.QuestConversationHelper::onConversationEnd
IL_0247: ret
IL_0248: call System.Boolean TheForestOfLove.QuestTriggerHelper::InBotbStoryInstance()
IL_024d: brfalse.s IL_0286
IL_024f: ldstr "BotbLore_Penny"
IL_0254: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0259: brtrue.s IL_0286
IL_025b: ldstr "BotbLore_Penny"
IL_0260: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_0265: ldstr "Penny"
IL_026a: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_026f: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_0274: ldarg.0
IL_0275: ldftn System.Void TheForestOfLove.Gameplay.FastTravelController::<PlayPennyOnPerchPreTravelDialogue>b__20_7()
IL_027b: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0280: stsfld System.Action TheForestOfLove.QuestConversationHelper::onConversationEnd
IL_0285: ret
IL_0286: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_028b: brtrue IL_034f
IL_0290: ldstr "DeliveryQuest_ReturnToOtter2"
IL_0295: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_029a: brfalse IL_034f
IL_029f: ldstr "DeliveryQuest_DeliverShovel"
IL_02a4: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_02a9: brtrue IL_034f
IL_02ae: ldstr "DeliveryQuest_SD_Penny"
IL_02b3: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_02b8: brtrue IL_034f
IL_02bd: ldstr "DeliveryQuest_SD_1Penny_AlreadyAtLake"
IL_02c2: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_02c7: brtrue IL_034f
IL_02cc: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inLake()
IL_02d1: brfalse.s IL_0311
IL_02d3: ldstr "DeliveryQuest_SD_1Penny_AlreadyAtLake"
IL_02d8: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_02dd: ldstr "Penny"
IL_02e2: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_02e7: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_02ec: ldsfld System.Action TheForestOfLove.Gameplay.FastTravelController/<>c::<>9__20_8
IL_02f1: dup
IL_02f2: brtrue.s IL_030b
IL_02f4: pop
IL_02f5: ldsfld TheForestOfLove.Gameplay.FastTravelController/<>c TheForestOfLove.Gameplay.FastTravelController/<>c::<>9
IL_02fa: ldftn System.Void TheForestOfLove.Gameplay.FastTravelController/<>c::<PlayPennyOnPerchPreTravelDialogue>b__20_8()
IL_0300: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0305: dup
IL_0306: stsfld System.Action TheForestOfLove.Gameplay.FastTravelController/<>c::<>9__20_8
IL_030b: stsfld System.Action TheForestOfLove.QuestConversationHelper::onConversationEnd
IL_0310: ret
IL_0311: ldstr "DeliveryQuest_SD_Penny"
IL_0316: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_031b: ldstr "Penny"
IL_0320: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_0325: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_032a: ldsfld System.Action TheForestOfLove.Gameplay.FastTravelController/<>c::<>9__20_9
IL_032f: dup
IL_0330: brtrue.s IL_0349
IL_0332: pop
IL_0333: ldsfld TheForestOfLove.Gameplay.FastTravelController/<>c TheForestOfLove.Gameplay.FastTravelController/<>c::<>9
IL_0338: ldftn System.Void TheForestOfLove.Gameplay.FastTravelController/<>c::<PlayPennyOnPerchPreTravelDialogue>b__20_9()
IL_033e: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_0343: dup
IL_0344: stsfld System.Action TheForestOfLove.Gameplay.FastTravelController/<>c::<>9__20_9
IL_0349: stsfld System.Action TheForestOfLove.QuestConversationHelper::onConversationEnd
IL_034e: ret
IL_034f: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_0354: brtrue.s IL_03b2
IL_0356: ldstr "CoyoteQuest_RingFastTravelBell"
IL_035b: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0360: brtrue.s IL_03b2
IL_0362: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inPlainsEnd()
IL_0367: brfalse.s IL_03b2
IL_0369: ldsfld TheForestOfLove.Content.PlainsEndSpawner TheForestOfLove.Content.PlainsEndSpawner::instance
IL_036e: callvirt AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_FastTravelPerch()
IL_0373: callvirt !!0 UnityEngine.Component::GetComponentInChildren<TheForestOfLove.Cameras.CameraSettings>()
IL_0378: stsfld TheForestOfLove.Cameras.CameraSettings TheForestOfLove.QuestConversationHelper::targetCameraSettings
IL_037d: ldstr "CoyoteQuest_RingFastTravelBell"
IL_0382: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_0387: ldstr "plains_fast_travel_bell_first_ring"
IL_038c: stsfld System.String TheForestOfLove.QuestConversationHelper::targetDialogueArcName
IL_0391: ldstr "Penny"
IL_0396: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_039b: ldarg.0
IL_039c: ldftn System.Void TheForestOfLove.Gameplay.FastTravelController::<PlayPennyOnPerchPreTravelDialogue>b__20_10()
IL_03a2: newobj System.Void System.Action::.ctor(System.Object,System.IntPtr)
IL_03a7: stsfld System.Action TheForestOfLove.QuestConversationHelper::onConversationEnd
IL_03ac: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_03b1: ret
IL_03b2: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_03b7: brtrue.s IL_0406
IL_03b9: ldstr "CoyoteQuest_ReturnToCoyotes"
IL_03be: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_03c3: brfalse.s IL_0406
IL_03c5: ldstr "Act2Capstone_PennyIntroduction"
IL_03ca: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_03cf: brtrue.s IL_0406
IL_03d1: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inPlainsEnd()
IL_03d6: brfalse.s IL_0406
IL_03d8: ldsfld TheForestOfLove.Content.PlainsEndSpawner TheForestOfLove.Content.PlainsEndSpawner::instance
IL_03dd: callvirt AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_FastTravelPerch()
IL_03e2: callvirt !!0 UnityEngine.Component::GetComponentInChildren<TheForestOfLove.Cameras.CameraSettings>()
IL_03e7: stsfld TheForestOfLove.Cameras.CameraSettings TheForestOfLove.QuestConversationHelper::targetCameraSettings
IL_03ec: ldstr "Act2Capstone_PennyIntroduction"
IL_03f1: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_03f6: ldstr "Penny"
IL_03fb: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_0400: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_0405: ret
IL_0406: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_040b: brtrue.s IL_044e
IL_040d: ldstr "BridgeQuest_MeetBirdAndFastTravel"
IL_0412: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0417: brtrue.s IL_044e
IL_0419: call System.Boolean TheForestOfLove.Services.SceneManagement.SceneHelper::get_inLake()
IL_041e: brfalse.s IL_044e
IL_0420: ldsfld TheForestOfLove.Content.LakeSpawner TheForestOfLove.Content.LakeSpawner::instance
IL_0425: callvirt AreaContent TheForestOfLove.Content.LakeSpawner::get_FastTravelPerch()
IL_042a: callvirt !!0 UnityEngine.Component::GetComponentInChildren<TheForestOfLove.Cameras.CameraSettings>()
IL_042f: stsfld TheForestOfLove.Cameras.CameraSettings TheForestOfLove.QuestConversationHelper::targetCameraSettings
IL_0434: ldstr "BridgeQuest_MeetBirdAndFastTravel"
IL_0439: stsfld System.String TheForestOfLove.QuestConversationHelper::targetConversationName
IL_043e: ldstr "Penny"
IL_0443: stsfld System.String TheForestOfLove.QuestConversationHelper::targetActorName
IL_0448: call System.Void TheForestOfLove.QuestConversationHelper::StartConversation()
IL_044d: ret
IL_044e: ldarg.0
IL_044f: call System.Void TheForestOfLove.Gameplay.FastTravelController::PlayPennyOnPerchDynamicDestinationsDialogue()
IL_0454: ret
METHOD System.Void TheForestOfLove.Gameplay.FastTravelController::PlayerInitiatesFastTravel(System.String) | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.String TheForestOfLove.Gameplay.FastTravelController::destinationSceneName
IL_0007: ldarg.1
IL_0008: call TheForestOfLove.Narrative.AreaRecord TheForestOfLove.Services.Persistence.DataService::GetAreaRecordByUnitySceneName(System.String)
IL_000d: stloc.0
IL_000e: ldloc.0
IL_000f: brfalse.s IL_0026
IL_0011: ldstr "initiated penny fast travel to area "
IL_0016: ldloc.0
IL_0017: ldfld System.String TheForestOfLove.Narrative.AreaRecord::dbName
IL_001c: call System.String System.String::Concat(System.String,System.String)
IL_0021: call System.Void TheForestOfLove.GameplayLogManager::AddEventLog(System.String)
IL_0026: ldc.i4.1
IL_0027: call System.Void TheForestOfLove.SpawnManager::set_isFastTraveling(System.Boolean)
IL_002c: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onFastTravelStart
IL_0031: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_0036: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.FastTravelCutscene>()
IL_003b: callvirt System.Void TheForestOfLove.FastTravelCutscene::PlayerInitiatesFastTravel()
IL_0040: ret
METHOD System.Void TheForestOfLove.Gameplay.FastTravelController::PlayerCancelsFastTravel() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: stfld System.String TheForestOfLove.Gameplay.FastTravelController::destinationSceneName
IL_0007: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.FastTravelCutscene>()
IL_000c: callvirt System.Void TheForestOfLove.FastTravelCutscene::PlayerCancelsFastTravel()
IL_0011: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.Narrative.StoryManager>()
IL_0016: ldstr "Penny"
IL_001b: ldc.i4.2
IL_001c: ldnull
IL_001d: ldnull
IL_001e: callvirt TheForestOfLove.Narrative.Dialogue TheForestOfLove.Narrative.StoryManager::HasAvailableMessages(System.String,TheForestOfLove.Narrative.QuestManagerInteractionMode,System.String,System.String)
IL_0023: brfalse.s IL_002f
IL_0025: call T TheForestOfLove.Services.ServiceLocator::Get<TheForestOfLove.GossipUI>()
IL_002a: callvirt System.Void TheForestOfLove.GossipUI::Show()
IL_002f: ret
METHOD System.Void TheForestOfLove.Gameplay.FastTravelController::<PlayPennyOnPerchPreTravelDialogue>b__20_10() | attributes=Private, HideBySig | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldsfld UnityEngine.Events.UnityEvent TheForestOfLove.Events.GameEvents::onCutsceneEnd
IL_0005: callvirt System.Void UnityEngine.Events.UnityEvent::Invoke()
IL_000a: ldarg.0
IL_000b: ldstr "CentralForest"
IL_0010: call System.Void TheForestOfLove.Gameplay.FastTravelController::PlayerInitiatesFastTravel(System.String)
IL_0015: ret
