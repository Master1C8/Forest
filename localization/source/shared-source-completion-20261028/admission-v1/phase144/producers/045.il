TYPE TheForestOfLove.Content.OtterShopSpawner
METHOD System.Void TheForestOfLove.Content.OtterShopSpawner::SpawnObjects() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldstr "Environment"
IL_0007: ldnull
IL_0008: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_000d: call System.Void TheForestOfLove.Content.OtterShopSpawner::set_Environment(AreaContentSet)
IL_0012: ldarg.0
IL_0013: ldarg.0
IL_0014: ldstr "Elements"
IL_0019: ldnull
IL_001a: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_001f: call System.Void TheForestOfLove.Content.OtterShopSpawner::set_Elements(AreaContentSet)
IL_0024: ldarg.0
IL_0025: ldarg.0
IL_0026: ldstr "Critters"
IL_002b: ldnull
IL_002c: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_0031: call System.Void TheForestOfLove.Content.OtterShopSpawner::set_Critters(AreaContentSet)
IL_0036: ldarg.0
IL_0037: ldarg.0
IL_0038: ldarg.0
IL_0039: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopSpawner::player
IL_003e: ldnull
IL_003f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,UnityEngine.Transform)
IL_0044: call System.Void TheForestOfLove.Content.OtterShopSpawner::set_Player(AreaContent)
IL_0049: ldarg.0
IL_004a: ldarg.0
IL_004b: ldarg.0
IL_004c: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopSpawner::environmentBase
IL_0051: ldarg.0
IL_0052: call AreaContentSet TheForestOfLove.Content.OtterShopSpawner::get_Environment()
IL_0057: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_005c: call System.Void TheForestOfLove.Content.OtterShopSpawner::set_EnvironmentBase(AreaContent)
IL_0061: ldarg.0
IL_0062: ldarg.0
IL_0063: ldstr "Scarlett"
IL_0068: ldarg.0
IL_0069: call AreaContentSet TheForestOfLove.Content.OtterShopSpawner::get_Critters()
IL_006e: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0073: call System.Void TheForestOfLove.Content.OtterShopSpawner::set_Scarlett(AreaContent)
IL_0078: ldarg.0
IL_0079: ldarg.0
IL_007a: ldstr "Items for Sale"
IL_007f: ldarg.0
IL_0080: call AreaContentSet TheForestOfLove.Content.OtterShopSpawner::get_Elements()
IL_0085: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_008a: call System.Void TheForestOfLove.Content.OtterShopSpawner::set_ItemsForSale(AreaContent)
IL_008f: ldarg.0
IL_0090: ldarg.0
IL_0091: ldstr "Maverick and Dustin BOTB Shared Interactive"
IL_0096: ldarg.0
IL_0097: call AreaContentSet TheForestOfLove.Content.OtterShopSpawner::get_Critters()
IL_009c: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00a1: call System.Void TheForestOfLove.Content.OtterShopSpawner::set_MaverickDustinNpcsBotbSharedInteractive(AreaContent)
IL_00a6: ldarg.0
IL_00a7: ldarg.0
IL_00a8: ldstr "Maverick and Dustin BOTB Individually Interactive"
IL_00ad: ldarg.0
IL_00ae: call AreaContentSet TheForestOfLove.Content.OtterShopSpawner::get_Critters()
IL_00b3: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00b8: call System.Void TheForestOfLove.Content.OtterShopSpawner::set_MaverickDustinNpcsBotbIndividuallyInteractive(AreaContent)
IL_00bd: ldarg.0
IL_00be: ldarg.0
IL_00bf: ldstr "Countertop"
IL_00c4: ldarg.0
IL_00c5: call AreaContentSet TheForestOfLove.Content.OtterShopSpawner::get_Elements()
IL_00ca: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00cf: call System.Void TheForestOfLove.Content.OtterShopSpawner::set_Countertop(AreaContent)
IL_00d4: ldarg.0
IL_00d5: ldarg.0
IL_00d6: ldstr "Maverick"
IL_00db: ldarg.0
IL_00dc: call AreaContentSet TheForestOfLove.Content.OtterShopSpawner::get_Critters()
IL_00e1: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00e6: call System.Void TheForestOfLove.Content.OtterShopSpawner::set_Maverick(AreaContent)
IL_00eb: ldarg.0
IL_00ec: ldarg.0
IL_00ed: ldstr "Mabel"
IL_00f2: ldarg.0
IL_00f3: call AreaContentSet TheForestOfLove.Content.OtterShopSpawner::get_Critters()
IL_00f8: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00fd: call System.Void TheForestOfLove.Content.OtterShopSpawner::set_Mabel(AreaContent)
IL_0102: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_0107: brfalse.s IL_0110
IL_0109: ldarg.0
IL_010a: call System.Void TheForestOfLove.Content.OtterShopSpawner::SpawnInstancedStoryStuff()
IL_010f: ret
IL_0110: ldstr "StormQuest_PostPhotoshootCutscene"
IL_0115: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_011a: brfalse.s IL_012b
IL_011c: ldstr "StormQuest_MaverickAndMabel"
IL_0121: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0126: ldc.i4.0
IL_0127: ceq
IL_0129: br.s IL_012c
IL_012b: ldc.i4.0
IL_012c: stloc.0
IL_012d: ldstr "StormQuest_MaverickAndMabel"
IL_0132: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0137: brfalse.s IL_0148
IL_0139: ldstr "return_to_centralforest_after_photoshoot"
IL_013e: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0143: ldc.i4.0
IL_0144: ceq
IL_0146: br.s IL_0149
IL_0148: ldc.i4.0
IL_0149: stloc.1
IL_014a: ldloc.0
IL_014b: ldloc.1
IL_014c: or
IL_014d: brfalse.s IL_0168
IL_014f: ldarg.0
IL_0150: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopSpawner::elementsCounterOpen
IL_0155: ldarg.0
IL_0156: call AreaContent TheForestOfLove.Content.OtterShopSpawner::get_Countertop()
IL_015b: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0160: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0165: pop
IL_0166: br.s IL_01ab
IL_0168: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsPhotoshootHappening()
IL_016d: brfalse.s IL_0194
IL_016f: ldarg.0
IL_0170: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopSpawner::elementsCounterOpen
IL_0175: ldarg.0
IL_0176: call AreaContent TheForestOfLove.Content.OtterShopSpawner::get_Countertop()
IL_017b: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0180: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0185: pop
IL_0186: ldarg.0
IL_0187: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopSpawner::examinablesBehindCounter
IL_018c: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0191: pop
IL_0192: br.s IL_01ab
IL_0194: ldarg.0
IL_0195: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopSpawner::elementsCounterClosed
IL_019a: ldarg.0
IL_019b: call AreaContent TheForestOfLove.Content.OtterShopSpawner::get_Countertop()
IL_01a0: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_01a5: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_01aa: pop
IL_01ab: ldstr "DeliveryQuest_DeliverShovel"
IL_01b0: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_01b5: brfalse.s IL_01e0
IL_01b7: ldarg.0
IL_01b8: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopSpawner::itemsForSaleDefault
IL_01bd: ldarg.0
IL_01be: call AreaContent TheForestOfLove.Content.OtterShopSpawner::get_ItemsForSale()
IL_01c3: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_01c8: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_01cd: pop
IL_01ce: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsPhotoshootHappening()
IL_01d3: brfalse.s IL_01e0
IL_01d5: ldarg.0
IL_01d6: call AreaContent TheForestOfLove.Content.OtterShopSpawner::get_ItemsForSale()
IL_01db: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::DisableInteractionInChildren(AreaContent)
IL_01e0: ldstr "CoyoteQuest_RingFastTravelBell"
IL_01e5: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_01ea: brfalse.s IL_0209
IL_01ec: ldstr "DeliveryQuest_GatorDelivery"
IL_01f1: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_01f6: brtrue.s IL_0209
IL_01f8: ldarg.0
IL_01f9: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopSpawner::deliveriesIntroCutscene
IL_01fe: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0203: pop
IL_0204: br IL_039e
IL_0209: ldstr "DeliveryQuest_GatorDelivery"
IL_020e: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0213: brfalse.s IL_0232
IL_0215: ldstr "DeliveryQuest_BunnyDeliveryInside"
IL_021a: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_021f: brtrue.s IL_0232
IL_0221: ldarg.0
IL_0222: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopSpawner::deliveriesSecondCutscene
IL_0227: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_022c: pop
IL_022d: br IL_039e
IL_0232: ldstr "DeliveryQuest_BunnyDeliveryInside"
IL_0237: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_023c: brfalse.s IL_025b
IL_023e: ldstr "DeliveryQuest_DeliverShovel"
IL_0243: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0248: brtrue.s IL_025b
IL_024a: ldarg.0
IL_024b: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopSpawner::deliveriesThirdCutscene
IL_0250: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0255: pop
IL_0256: br IL_039e
IL_025b: ldstr "DeliveryQuest_DeliverShovel"
IL_0260: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0265: brfalse.s IL_0284
IL_0267: ldstr "DeliveryQuest_ReturnToOtter3"
IL_026c: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0271: brtrue.s IL_0284
IL_0273: ldarg.0
IL_0274: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopSpawner::deliveriesFourthCutscene
IL_0279: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_027e: pop
IL_027f: br IL_039e
IL_0284: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsPhotoshootHappening()
IL_0289: brfalse.s IL_02ab
IL_028b: ldstr "melody_photoshoot_pick_up_camera"
IL_0290: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0295: brtrue IL_039e
IL_029a: ldarg.0
IL_029b: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopSpawner::melodyPhotoshootIntro
IL_02a0: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_02a5: pop
IL_02a6: br IL_039e
IL_02ab: ldloc.0
IL_02ac: brfalse.s IL_02fc
IL_02ae: ldarg.0
IL_02af: ldfld TheForestOfLove.StormQuestMaverickMabelCutscene TheForestOfLove.Content.OtterShopSpawner::stormQuestMaverickMabelCutscene
IL_02b4: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.StormQuestMaverickMabelCutscene>(!!0)
IL_02b9: pop
IL_02ba: ldarg.0
IL_02bb: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopSpawner::npcMaverickStormQuest
IL_02c0: ldarg.0
IL_02c1: call AreaContent TheForestOfLove.Content.OtterShopSpawner::get_Maverick()
IL_02c6: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_02cb: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_02d0: pop
IL_02d1: ldstr "StormQuest_MaverickAndMabel"
IL_02d6: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_02db: brtrue IL_039e
IL_02e0: ldarg.0
IL_02e1: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopSpawner::npcMabelStormQuest
IL_02e6: ldarg.0
IL_02e7: call AreaContent TheForestOfLove.Content.OtterShopSpawner::get_Mabel()
IL_02ec: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_02f1: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_02f6: pop
IL_02f7: br IL_039e
IL_02fc: ldloc.1
IL_02fd: brfalse.s IL_031b
IL_02ff: ldarg.0
IL_0300: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopSpawner::npcMaverickStormQuest
IL_0305: ldarg.0
IL_0306: call AreaContent TheForestOfLove.Content.OtterShopSpawner::get_Maverick()
IL_030b: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0310: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0315: pop
IL_0316: br IL_039e
IL_031b: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3AfterstormQuest()
IL_0320: brtrue.s IL_0329
IL_0322: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3LightQuest()
IL_0327: brfalse.s IL_0337
IL_0329: ldarg.0
IL_032a: ldfld TheForestOfLove.AfterstormQuestRequireBuyingJarCutscene TheForestOfLove.Content.OtterShopSpawner::afterstormQuestRequireBuyingJarCutscene
IL_032f: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.AfterstormQuestRequireBuyingJarCutscene>(!!0)
IL_0334: pop
IL_0335: br.s IL_039e
IL_0337: call System.Boolean TheForestOfLove.QuestTriggerHelper::CanPlayMaverickRascalShopStory()
IL_033c: brfalse.s IL_035d
IL_033e: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_LastSceneName()
IL_0343: ldstr "OtterShop_BackRoom"
IL_0348: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_034d: brfalse.s IL_035d
IL_034f: ldarg.0
IL_0350: ldfld TheForestOfLove.MaverickRascalShopStoryCutscene TheForestOfLove.Content.OtterShopSpawner::maverickRascalShopStoryCutscene
IL_0355: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.MaverickRascalShopStoryCutscene>(!!0)
IL_035a: pop
IL_035b: br.s IL_039e
IL_035d: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3WolfQuest()
IL_0362: brtrue.s IL_039e
IL_0364: ldstr "Gossip_Otter_Partner"
IL_0369: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_036e: brfalse.s IL_039e
IL_0370: ldstr "MaverickDatingPart2"
IL_0375: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_037a: brtrue.s IL_039e
IL_037c: ldc.r4 0
IL_0381: ldc.r4 1
IL_0386: call System.Single UnityEngine.Random::Range(System.Single,System.Single)
IL_038b: ldc.r4 0.5
IL_0390: bge.un.s IL_039e
IL_0392: ldarg.0
IL_0393: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopSpawner::cutsceneDatingPart2
IL_0398: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_039d: pop
IL_039e: call System.Boolean TheForestOfLove.QuestTriggerHelper::CanSpawnScarlettHop()
IL_03a3: brfalse.s IL_03bc
IL_03a5: ldarg.0
IL_03a6: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopSpawner::npcScarlettHop
IL_03ab: ldarg.0
IL_03ac: call AreaContent TheForestOfLove.Content.OtterShopSpawner::get_Scarlett()
IL_03b1: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_03b6: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_03bb: pop
IL_03bc: ldarg.0
IL_03bd: call System.Void TheForestOfLove.Content.OtterShopSpawner::SpawnDefaultCritters()
IL_03c2: ret
METHOD System.Void TheForestOfLove.Content.OtterShopSpawner::SpawnMaverick() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "Maverick"
IL_0005: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorSpawnedOrOnDate(System.String)
IL_000a: brfalse.s IL_000d
IL_000c: ret
IL_000d: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsPhotoshootHappening()
IL_0012: brfalse.s IL_0015
IL_0014: ret
IL_0015: ldarg.0
IL_0016: ldfld UnityEngine.GameObject TheForestOfLove.Content.OtterShopSpawner::npcMaverick
IL_001b: ldarg.0
IL_001c: call AreaContent TheForestOfLove.Content.OtterShopSpawner::get_Maverick()
IL_0021: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0026: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_002b: pop
IL_002c: ret
