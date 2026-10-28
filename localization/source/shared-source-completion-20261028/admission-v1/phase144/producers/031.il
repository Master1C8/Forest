TYPE TheForestOfLove.Content.BunnyHouseSpawner
METHOD System.Void TheForestOfLove.Content.BunnyHouseSpawner::SpawnObjects() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldstr "Environment"
IL_0007: ldnull
IL_0008: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_000d: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_Environment(AreaContentSet)
IL_0012: ldarg.0
IL_0013: ldarg.0
IL_0014: ldstr "Elements"
IL_0019: ldnull
IL_001a: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_001f: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_Elements(AreaContentSet)
IL_0024: ldarg.0
IL_0025: ldarg.0
IL_0026: ldstr "Table"
IL_002b: ldarg.0
IL_002c: call AreaContentSet TheForestOfLove.Content.BunnyHouseSpawner::get_Elements()
IL_0031: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,AreaContentSet)
IL_0036: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_ElementsTable(AreaContentSet)
IL_003b: ldarg.0
IL_003c: ldarg.0
IL_003d: ldstr "Critters"
IL_0042: ldnull
IL_0043: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_0048: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_Critters(AreaContentSet)
IL_004d: ldarg.0
IL_004e: ldarg.0
IL_004f: ldarg.0
IL_0050: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::player
IL_0055: ldnull
IL_0056: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,UnityEngine.Transform)
IL_005b: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_Player(AreaContent)
IL_0060: ldarg.0
IL_0061: ldarg.0
IL_0062: ldarg.0
IL_0063: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::environmentBase
IL_0068: ldarg.0
IL_0069: call AreaContentSet TheForestOfLove.Content.BunnyHouseSpawner::get_Environment()
IL_006e: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0073: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_EnvironmentBase(AreaContent)
IL_0078: ldarg.0
IL_0079: ldarg.0
IL_007a: ldarg.0
IL_007b: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::elementsBase
IL_0080: ldarg.0
IL_0081: call AreaContentSet TheForestOfLove.Content.BunnyHouseSpawner::get_Elements()
IL_0086: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_008b: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_ElementsBase(AreaContent)
IL_0090: ldarg.0
IL_0091: ldarg.0
IL_0092: ldarg.0
IL_0093: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::elementsBed
IL_0098: ldarg.0
IL_0099: call AreaContentSet TheForestOfLove.Content.BunnyHouseSpawner::get_Elements()
IL_009e: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_00a3: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_ElementsBed(AreaContent)
IL_00a8: ldarg.0
IL_00a9: ldarg.0
IL_00aa: ldarg.0
IL_00ab: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::elementsTableBare
IL_00b0: ldarg.0
IL_00b1: call AreaContentSet TheForestOfLove.Content.BunnyHouseSpawner::get_ElementsTable()
IL_00b6: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_00bb: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_ElementsTableBare(AreaContent)
IL_00c0: ldarg.0
IL_00c1: ldarg.0
IL_00c2: ldarg.0
IL_00c3: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::elementsCard
IL_00c8: ldarg.0
IL_00c9: call AreaContentSet TheForestOfLove.Content.BunnyHouseSpawner::get_ElementsTable()
IL_00ce: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_00d3: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_ElementsCard(AreaContent)
IL_00d8: ldarg.0
IL_00d9: ldarg.0
IL_00da: ldarg.0
IL_00db: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::elementsChocolate
IL_00e0: ldarg.0
IL_00e1: call AreaContentSet TheForestOfLove.Content.BunnyHouseSpawner::get_ElementsTable()
IL_00e6: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_00eb: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_ElementsChocolate(AreaContent)
IL_00f0: ldarg.0
IL_00f1: ldarg.0
IL_00f2: ldarg.0
IL_00f3: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::elementsFlowers
IL_00f8: ldarg.0
IL_00f9: call AreaContentSet TheForestOfLove.Content.BunnyHouseSpawner::get_ElementsTable()
IL_00fe: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0103: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_ElementsFlowers(AreaContent)
IL_0108: ldarg.0
IL_0109: ldarg.0
IL_010a: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::elementsPlateEmpty
IL_010f: ldarg.0
IL_0110: call AreaContentSet TheForestOfLove.Content.BunnyHouseSpawner::get_ElementsTable()
IL_0115: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_011a: pop
IL_011b: ldarg.0
IL_011c: ldarg.0
IL_011d: ldarg.0
IL_011e: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::elementsKitchen
IL_0123: ldarg.0
IL_0124: call AreaContentSet TheForestOfLove.Content.BunnyHouseSpawner::get_Elements()
IL_0129: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_012e: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_ElementsKitchen(AreaContent)
IL_0133: ldarg.0
IL_0134: ldarg.0
IL_0135: ldarg.0
IL_0136: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::elementsPlateFood
IL_013b: ldarg.0
IL_013c: call AreaContentSet TheForestOfLove.Content.BunnyHouseSpawner::get_ElementsTable()
IL_0141: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0146: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_ElementsPlateFood(AreaContent)
IL_014b: ldarg.0
IL_014c: ldarg.0
IL_014d: ldarg.0
IL_014e: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::elementsRug
IL_0153: ldarg.0
IL_0154: call AreaContentSet TheForestOfLove.Content.BunnyHouseSpawner::get_Elements()
IL_0159: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_015e: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_ElementsRug(AreaContent)
IL_0163: ldarg.0
IL_0164: ldarg.0
IL_0165: ldarg.0
IL_0166: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::elementsRugCorner
IL_016b: ldarg.0
IL_016c: call AreaContentSet TheForestOfLove.Content.BunnyHouseSpawner::get_Elements()
IL_0171: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0176: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_ElementsRugCorner(AreaContent)
IL_017b: ldarg.0
IL_017c: ldarg.0
IL_017d: ldarg.0
IL_017e: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::elementsCrib
IL_0183: ldarg.0
IL_0184: call AreaContentSet TheForestOfLove.Content.BunnyHouseSpawner::get_Elements()
IL_0189: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_018e: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_ElementsCrib(AreaContent)
IL_0193: ldarg.0
IL_0194: ldarg.0
IL_0195: ldarg.0
IL_0196: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::elementsTools
IL_019b: ldarg.0
IL_019c: call AreaContentSet TheForestOfLove.Content.BunnyHouseSpawner::get_Elements()
IL_01a1: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_01a6: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_ElementsTools(AreaContent)
IL_01ab: ldarg.0
IL_01ac: ldarg.0
IL_01ad: ldarg.0
IL_01ae: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::elementsVegetables
IL_01b3: ldarg.0
IL_01b4: call AreaContentSet TheForestOfLove.Content.BunnyHouseSpawner::get_Elements()
IL_01b9: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_01be: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_ElementsVegetables(AreaContent)
IL_01c3: ldarg.0
IL_01c4: ldarg.0
IL_01c5: ldstr "Peter"
IL_01ca: ldarg.0
IL_01cb: call AreaContentSet TheForestOfLove.Content.BunnyHouseSpawner::get_Critters()
IL_01d0: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_01d5: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_Peter(AreaContent)
IL_01da: ldarg.0
IL_01db: ldarg.0
IL_01dc: ldstr "Scarlett"
IL_01e1: ldarg.0
IL_01e2: call AreaContentSet TheForestOfLove.Content.BunnyHouseSpawner::get_Critters()
IL_01e7: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_01ec: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_Scarlett(AreaContent)
IL_01f1: ldarg.0
IL_01f2: ldarg.0
IL_01f3: ldarg.0
IL_01f4: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::adventuresGateway
IL_01f9: callvirt System.String UnityEngine.Object::get_name()
IL_01fe: ldarg.0
IL_01ff: call AreaContentSet TheForestOfLove.Content.BunnyHouseSpawner::get_Elements()
IL_0204: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0209: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::set_AdventuresGateway(AreaContent)
IL_020e: ldarg.0
IL_020f: call AreaContent TheForestOfLove.Content.BunnyHouseSpawner::get_ElementsTableBare()
IL_0214: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::DisableInteractionInChildren(AreaContent)
IL_0219: ldstr "bunnyhouse_chocolates"
IL_021e: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0223: brfalse.s IL_0230
IL_0225: ldarg.0
IL_0226: call AreaContent TheForestOfLove.Content.BunnyHouseSpawner::get_ElementsChocolate()
IL_022b: callvirt System.Void AreaContent::Disable()
IL_0230: ldstr "bunnyhouse_food"
IL_0235: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_023a: brfalse.s IL_0247
IL_023c: ldarg.0
IL_023d: call AreaContent TheForestOfLove.Content.BunnyHouseSpawner::get_ElementsPlateFood()
IL_0242: callvirt System.Void AreaContent::Disable()
IL_0247: ldstr "bunnyhouse_card"
IL_024c: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0251: brfalse.s IL_025e
IL_0253: ldarg.0
IL_0254: call AreaContent TheForestOfLove.Content.BunnyHouseSpawner::get_ElementsCard()
IL_0259: callvirt System.Void AreaContent::Disable()
IL_025e: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_0263: brfalse.s IL_026c
IL_0265: ldarg.0
IL_0266: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::SpawnInstancedStoryStuff()
IL_026b: ret
IL_026c: ldstr "NewGame_Intro"
IL_0271: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0276: brtrue.s IL_0284
IL_0278: ldarg.0
IL_0279: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::cutsceneIntroBunnyHouse
IL_027e: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0283: pop
IL_0284: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3AfterstormQuest()
IL_0289: brfalse.s IL_02b5
IL_028b: ldstr "AfterstormQuest_ScarlettAndPeter"
IL_0290: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0295: brtrue.s IL_02b5
IL_0297: ldarg.0
IL_0298: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::cutsceneAct3AfterStorm
IL_029d: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_02a2: pop
IL_02a3: ldarg.0
IL_02a4: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::bunniesSharedInteraction
IL_02a9: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_02ae: pop
IL_02af: ldarg.0
IL_02b0: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::DisableExaminablesNearBunnyDuo()
IL_02b5: ldstr "Cutscene_BunnyDeliveryOutside"
IL_02ba: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_02bf: brfalse.s IL_02df
IL_02c1: ldstr "Cutscene_BunnyDeliveryInside"
IL_02c6: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_02cb: brtrue.s IL_02df
IL_02cd: ldarg.0
IL_02ce: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::cutsceneBunnyDeliveryInside
IL_02d3: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_02d8: pop
IL_02d9: ldarg.0
IL_02da: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::DisableExaminablesNearBunnyDuo()
IL_02df: ldstr "CookieQuest_CookiesAreReady"
IL_02e4: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_02e9: brfalse.s IL_0309
IL_02eb: ldstr "CookieQuest_CD_Bunnies"
IL_02f0: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_02f5: brtrue.s IL_0309
IL_02f7: ldarg.0
IL_02f8: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::bunniesSharedInteraction
IL_02fd: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0302: pop
IL_0303: ldarg.0
IL_0304: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::DisableExaminablesNearBunnyDuo()
IL_0309: ldstr "BootyLineUpQuest_RecruitDustin"
IL_030e: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0313: brfalse.s IL_034a
IL_0315: ldstr "BootyLineUpQuest_RecruitBucky"
IL_031a: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_031f: brfalse.s IL_034a
IL_0321: ldstr "BootyLineUpQuest_ReturnToBunnies"
IL_0326: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_032b: brtrue.s IL_034a
IL_032d: ldarg.0
IL_032e: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::scarlettBootyLineup
IL_0333: ldarg.0
IL_0334: call AreaContent TheForestOfLove.Content.BunnyHouseSpawner::get_Scarlett()
IL_0339: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_033e: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0343: pop
IL_0344: ldarg.0
IL_0345: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::DisableExaminablesNearBunnyDuo()
IL_034a: ldstr "BootyLineUpFemalesQuest_RecruitTheLadies"
IL_034f: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0354: brfalse.s IL_037f
IL_0356: ldstr "BootyLineUpFemalesQuest_ReturnToBunnies"
IL_035b: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0360: brtrue.s IL_037f
IL_0362: ldarg.0
IL_0363: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::peterBootyLineupFemales
IL_0368: ldarg.0
IL_0369: call AreaContent TheForestOfLove.Content.BunnyHouseSpawner::get_Peter()
IL_036e: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0373: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0378: pop
IL_0379: ldarg.0
IL_037a: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::DisableExaminablesNearBunnyDuo()
IL_037f: call System.Boolean TheForestOfLove.QuestTriggerHelper::CanSpawnScarlettHop()
IL_0384: brfalse.s IL_038c
IL_0386: ldarg.0
IL_0387: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::Act3WolfQuestSpawnScarlettHop_Internal()
IL_038c: ldarg.0
IL_038d: ldstr "BunnyHouse"
IL_0392: call System.Boolean TheForestOfLove.Content.BaseSpawner::CanSpawnAdventuresForGatewayName(System.String)
IL_0397: brfalse.s IL_039f
IL_0399: ldarg.0
IL_039a: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::SpawnAdventuresTeleport()
IL_039f: ldarg.0
IL_03a0: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::SpawnDefaultCritters()
IL_03a5: ret
METHOD System.Void TheForestOfLove.Content.BunnyHouseSpawner::SpawnPeter() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "Peter"
IL_0005: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorSpawnedOrOnDate(System.String)
IL_000a: brfalse.s IL_000d
IL_000c: ret
IL_000d: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAct2CapstoneOngoing()
IL_0012: brfalse.s IL_0015
IL_0014: ret
IL_0015: call System.Boolean TheForestOfLove.QuestTriggerHelper::InShovelDelivery()
IL_001a: brfalse.s IL_001d
IL_001c: ret
IL_001d: ldstr "Cutscene_BunnyDeliveryInside"
IL_0022: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0027: brtrue.s IL_002a
IL_0029: ret
IL_002a: ldarg.0
IL_002b: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::npcPeter
IL_0030: ldarg.0
IL_0031: call AreaContent TheForestOfLove.Content.BunnyHouseSpawner::get_Peter()
IL_0036: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_003b: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0040: pop
IL_0041: ldarg.0
IL_0042: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::DisableExaminablesNearBunnyDuo()
IL_0047: ret
METHOD System.Void TheForestOfLove.Content.BunnyHouseSpawner::SpawnScarlett() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "Scarlett"
IL_0005: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorSpawnedOrOnDate(System.String)
IL_000a: brfalse.s IL_000d
IL_000c: ret
IL_000d: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAct2CapstoneOngoing()
IL_0012: brfalse.s IL_0015
IL_0014: ret
IL_0015: call System.Boolean TheForestOfLove.QuestTriggerHelper::InShovelDelivery()
IL_001a: brfalse.s IL_001d
IL_001c: ret
IL_001d: ldstr "Cutscene_BunnyDeliveryInside"
IL_0022: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0027: brtrue.s IL_002a
IL_0029: ret
IL_002a: ldarg.0
IL_002b: ldfld UnityEngine.GameObject TheForestOfLove.Content.BunnyHouseSpawner::npcScarlett
IL_0030: ldarg.0
IL_0031: call AreaContent TheForestOfLove.Content.BunnyHouseSpawner::get_Scarlett()
IL_0036: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_003b: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0040: pop
IL_0041: ldarg.0
IL_0042: call System.Void TheForestOfLove.Content.BunnyHouseSpawner::DisableExaminablesNearBunnyDuo()
IL_0047: ret
