TYPE TheForestOfLove.Content.CentralForestSpawner
METHOD System.Void TheForestOfLove.Content.CentralForestSpawner::SpawnObjects()
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldstr "Environment"
IL_0007: ldnull
IL_0008: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_000d: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_Environment(AreaContentSet)
IL_0012: ldarg.0
IL_0013: ldarg.0
IL_0014: ldstr "Elements"
IL_0019: ldnull
IL_001a: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_001f: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_Elements(AreaContentSet)
IL_0024: ldarg.0
IL_0025: ldarg.0
IL_0026: ldstr "Critters"
IL_002b: ldnull
IL_002c: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_0031: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_Critters(AreaContentSet)
IL_0036: ldarg.0
IL_0037: ldarg.0
IL_0038: ldstr "Dates"
IL_003d: ldnull
IL_003e: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_0043: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_Dates(AreaContentSet)
IL_0048: ldarg.0
IL_0049: ldarg.0
IL_004a: ldarg.0
IL_004b: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::player
IL_0050: callvirt System.String UnityEngine.Object::get_name()
IL_0055: ldarg.0
IL_0056: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::player
IL_005b: ldnull
IL_005c: ldc.i4.0
IL_005d: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContentOrFind(System.String,UnityEngine.GameObject,UnityEngine.Transform,System.Boolean)
IL_0062: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_Player(AreaContent)
IL_0067: ldarg.0
IL_0068: ldarg.0
IL_0069: ldarg.0
IL_006a: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::environmentBase
IL_006f: callvirt System.String UnityEngine.Object::get_name()
IL_0074: ldarg.0
IL_0075: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::environmentBase
IL_007a: ldarg.0
IL_007b: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Environment()
IL_0080: ldc.i4.0
IL_0081: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContentOrFind(System.String,UnityEngine.GameObject,AreaContentSet,System.Boolean)
IL_0086: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_EnvironmentBase(AreaContent)
IL_008b: ldarg.0
IL_008c: ldarg.0
IL_008d: ldarg.0
IL_008e: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::elementsBase
IL_0093: callvirt System.String UnityEngine.Object::get_name()
IL_0098: ldarg.0
IL_0099: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::elementsBase
IL_009e: ldarg.0
IL_009f: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_00a4: ldc.i4.0
IL_00a5: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContentOrFind(System.String,UnityEngine.GameObject,AreaContentSet,System.Boolean)
IL_00aa: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_ElementsBase(AreaContent)
IL_00af: ldarg.0
IL_00b0: ldarg.0
IL_00b1: ldarg.0
IL_00b2: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::otterShopBackDoor
IL_00b7: ldarg.0
IL_00b8: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_00bd: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_00c2: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_OtterShopBackDoor(AreaContent)
IL_00c7: ldarg.0
IL_00c8: ldarg.0
IL_00c9: ldarg.0
IL_00ca: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::bunnyGardenWalkInteraction
IL_00cf: ldarg.0
IL_00d0: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_00d5: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_00da: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_BunnyGardenWalkInteraction(AreaContent)
IL_00df: ldarg.0
IL_00e0: ldarg.0
IL_00e1: ldarg.0
IL_00e2: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::stumpHouse
IL_00e7: ldarg.0
IL_00e8: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_00ed: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_00f2: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_StumpHouse(AreaContent)
IL_00f7: ldarg.0
IL_00f8: ldnull
IL_00f9: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_FastTravelPerch(AreaContent)
IL_00fe: ldarg.0
IL_00ff: ldarg.0
IL_0100: ldarg.0
IL_0101: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::fastTravelPerchAct1
IL_0106: ldarg.0
IL_0107: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_010c: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0111: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_FastTravelPerchAct1(AreaContent)
IL_0116: ldarg.0
IL_0117: ldarg.0
IL_0118: ldarg.0
IL_0119: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::fastTravelPerchAct2
IL_011e: ldarg.0
IL_011f: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_0124: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0129: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_FastTravelPerchAct2(AreaContent)
IL_012e: ldarg.0
IL_012f: ldarg.0
IL_0130: ldarg.0
IL_0131: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::fastTravelPerchPennyBusyElsewhere
IL_0136: ldarg.0
IL_0137: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_013c: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0141: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_FastTravelPerchPennyBusyElsewhere(AreaContent)
IL_0146: ldarg.0
IL_0147: ldarg.0
IL_0148: ldarg.0
IL_0149: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::fastTravelPerchAct3StormQuest
IL_014e: ldarg.0
IL_014f: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_0154: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0159: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_FastTravelPerchAct3StormQuest(AreaContent)
IL_015e: ldarg.0
IL_015f: ldarg.0
IL_0160: ldarg.0
IL_0161: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::fastTravelPerchPennyOnDate
IL_0166: ldarg.0
IL_0167: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_016c: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0171: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_FastTravelPerchPennyOnDate(AreaContent)
IL_0176: ldarg.0
IL_0177: ldarg.0
IL_0178: ldstr "Fast Travel Cutscene"
IL_017d: ldarg.0
IL_017e: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_0183: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0188: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_FastTravelCutscene(AreaContent)
IL_018d: ldarg.0
IL_018e: ldarg.0
IL_018f: ldarg.0
IL_0190: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::glyphStones
IL_0195: callvirt System.String UnityEngine.Object::get_name()
IL_019a: ldarg.0
IL_019b: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_01a0: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_01a5: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_GlyphStones(AreaContent)
IL_01aa: ldarg.0
IL_01ab: ldarg.0
IL_01ac: ldstr "Broken Bridge"
IL_01b1: ldarg.0
IL_01b2: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_01b7: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_01bc: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_BridgeBroken(AreaContent)
IL_01c1: ldarg.0
IL_01c2: ldarg.0
IL_01c3: ldstr "Repaired Bridge"
IL_01c8: ldarg.0
IL_01c9: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_01ce: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_01d3: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_BridgeRepaired(AreaContent)
IL_01d8: ldarg.0
IL_01d9: ldarg.0
IL_01da: ldarg.0
IL_01db: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::plantQuestMinigamePathBlockers
IL_01e0: callvirt System.String UnityEngine.Object::get_name()
IL_01e5: ldarg.0
IL_01e6: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_01eb: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_01f0: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_PlantQuestMinigamePathBlockers(AreaContent)
IL_01f5: ldarg.0
IL_01f6: ldarg.0
IL_01f7: ldstr "Otter Shop Front Door"
IL_01fc: ldarg.0
IL_01fd: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_0202: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0207: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_OtterShopFrontDoor(AreaContent)
IL_020c: ldarg.0
IL_020d: ldarg.0
IL_020e: ldarg.0
IL_020f: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::bushHouseDoor
IL_0214: callvirt System.String UnityEngine.Object::get_name()
IL_0219: ldarg.0
IL_021a: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_021f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0224: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_BushHouseDoor(AreaContent)
IL_0229: ldarg.0
IL_022a: ldarg.0
IL_022b: ldarg.0
IL_022c: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::bunnyHouseDoor
IL_0231: callvirt System.String UnityEngine.Object::get_name()
IL_0236: ldarg.0
IL_0237: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_023c: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0241: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_BunnyHouseDoor(AreaContent)
IL_0246: ldarg.0
IL_0247: ldarg.0
IL_0248: ldarg.0
IL_0249: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::beaverDamDoor
IL_024e: callvirt System.String UnityEngine.Object::get_name()
IL_0253: ldarg.0
IL_0254: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_0259: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_025e: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_BeaverDamDoor(AreaContent)
IL_0263: ldarg.0
IL_0264: ldarg.0
IL_0265: ldstr "Dustin Battleground"
IL_026a: ldarg.0
IL_026b: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_0270: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0275: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_DustinBattleground(AreaContent)
IL_027a: ldarg.0
IL_027b: ldarg.0
IL_027c: ldstr "Bucky"
IL_0281: ldarg.0
IL_0282: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Critters()
IL_0287: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_028c: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_Bucky(AreaContent)
IL_0291: ldarg.0
IL_0292: ldarg.0
IL_0293: ldstr "Mabel"
IL_0298: ldarg.0
IL_0299: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Critters()
IL_029e: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_02a3: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_Mabel(AreaContent)
IL_02a8: ldarg.0
IL_02a9: ldarg.0
IL_02aa: ldstr "Maverick"
IL_02af: ldarg.0
IL_02b0: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Critters()
IL_02b5: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_02ba: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_Maverick(AreaContent)
IL_02bf: ldarg.0
IL_02c0: ldarg.0
IL_02c1: ldstr "Peter"
IL_02c6: ldarg.0
IL_02c7: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Critters()
IL_02cc: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_02d1: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_Peter(AreaContent)
IL_02d6: ldarg.0
IL_02d7: ldarg.0
IL_02d8: ldstr "Scarlett"
IL_02dd: ldarg.0
IL_02de: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Critters()
IL_02e3: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_02e8: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_Scarlett(AreaContent)
IL_02ed: ldarg.0
IL_02ee: ldarg.0
IL_02ef: ldstr "Dustin"
IL_02f4: ldarg.0
IL_02f5: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Critters()
IL_02fa: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_02ff: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_Dustin(AreaContent)
IL_0304: ldarg.0
IL_0305: ldarg.0
IL_0306: ldarg.0
IL_0307: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::adventuresGateway
IL_030c: callvirt System.String UnityEngine.Object::get_name()
IL_0311: ldarg.0
IL_0312: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_0317: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_031c: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_AdventuresGateway(AreaContent)
IL_0321: ldarg.0
IL_0322: ldarg.0
IL_0323: ldarg.0
IL_0324: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::melodyFlipbookPhotoFirst
IL_0329: callvirt System.String UnityEngine.Object::get_name()
IL_032e: ldarg.0
IL_032f: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_0334: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0339: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_MelodyFlipbookPhotoFirst(AreaContent)
IL_033e: ldarg.0
IL_033f: ldarg.0
IL_0340: ldarg.0
IL_0341: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::melodyFlipbookPhotoSecond
IL_0346: callvirt System.String UnityEngine.Object::get_name()
IL_034b: ldarg.0
IL_034c: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_0351: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0356: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_MelodyFlipbookPhotoSecond(AreaContent)
IL_035b: ldarg.0
IL_035c: ldarg.0
IL_035d: ldarg.0
IL_035e: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::melodyFlipbookPhotoThird
IL_0363: callvirt System.String UnityEngine.Object::get_name()
IL_0368: ldarg.0
IL_0369: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_036e: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0373: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_MelodyFlipbookPhotoThird(AreaContent)
IL_0378: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAct2CapstoneOngoing()
IL_037d: brfalse.s IL_0398
IL_037f: ldarg.0
IL_0380: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::glyphStonesGlowy
IL_0385: ldarg.0
IL_0386: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_GlyphStones()
IL_038b: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0390: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0395: pop
IL_0396: br.s IL_03af
IL_0398: ldarg.0
IL_0399: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::glyphStones
IL_039e: ldarg.0
IL_039f: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_GlyphStones()
IL_03a4: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_03a9: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_03ae: pop
IL_03af: call System.Boolean TheForestOfLove.QuestTriggerHelper::FinishedAct1()
IL_03b4: brtrue.s IL_03cf
IL_03b6: ldarg.0
IL_03b7: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::bridgeBroken
IL_03bc: ldarg.0
IL_03bd: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_BridgeBroken()
IL_03c2: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_03c7: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_03cc: pop
IL_03cd: br.s IL_03e8
IL_03cf: ldarg.0
IL_03d0: ldarg.0
IL_03d1: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::beaverDamDoorwayCutout
IL_03d6: ldarg.0
IL_03d7: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_03dc: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_03e1: pop
IL_03e2: ldarg.0
IL_03e3: call System.Void TheForestOfLove.Content.CentralForestSpawner::SpawnBridgeRepaired()
IL_03e8: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_03ed: brfalse.s IL_03f6
IL_03ef: ldarg.0
IL_03f0: call System.Void TheForestOfLove.Content.CentralForestSpawner::SpawnInstancedStoryStuff()
IL_03f5: ret
IL_03f6: call System.Boolean TheForestOfLove.Content.BaseSpawner::get_DisableDatesNextSpawnCycle()
IL_03fb: brtrue.s IL_0402
IL_03fd: call System.Void TheForestOfLove.Narrative.StoryManager::SelectDatingCritters()
IL_0402: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerLearnedFastTravel()
IL_0407: brfalse.s IL_0442
IL_0409: call System.Boolean TheForestOfLove.QuestTriggerHelper::FinishedAct1()
IL_040e: brfalse.s IL_0429
IL_0410: ldarg.0
IL_0411: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::fastTravelCutsceneAct2
IL_0416: ldarg.0
IL_0417: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_FastTravelCutscene()
IL_041c: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0421: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0426: pop
IL_0427: br.s IL_0459
IL_0429: ldarg.0
IL_042a: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::fastTravelCutsceneAct1
IL_042f: ldarg.0
IL_0430: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_FastTravelCutscene()
IL_0435: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_043a: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_043f: pop
IL_0440: br.s IL_0459
IL_0442: ldarg.0
IL_0443: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::fastTravelCutsceneFirstFastTravel
IL_0448: ldarg.0
IL_0449: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_FastTravelCutscene()
IL_044e: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0453: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0458: pop
IL_0459: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3StormQuest()
IL_045e: brfalse.s IL_046b
IL_0460: ldarg.0
IL_0461: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_GlyphStones()
IL_0466: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::DisableInteractionInChildren(AreaContent)
IL_046b: ldstr "TutorialQuest_IntroFromBunny"
IL_0470: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0475: brtrue.s IL_0483
IL_0477: ldarg.0
IL_0478: ldfld TheForestOfLove.TutorialQuestBunnyIntroduction TheForestOfLove.Content.CentralForestSpawner::tutorialQuestBunnyIntroduction
IL_047d: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.TutorialQuestBunnyIntroduction>(!!0)
IL_0482: pop
IL_0483: ldarg.0
IL_0484: call System.Void TheForestOfLove.Content.CentralForestSpawner::TrySpawnEndOfAct1Kickoff()
IL_0489: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAct1CapstonePrebridgeOngoing()
IL_048e: brfalse.s IL_0496
IL_0490: ldarg.0
IL_0491: call System.Void TheForestOfLove.Content.CentralForestSpawner::SpawnAct1CrittersVictoryGatheringPrebridge()
IL_0496: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAct1CapstonePostbridgeOngoing()
IL_049b: brfalse.s IL_04a3
IL_049d: ldarg.0
IL_049e: call System.Void TheForestOfLove.Content.CentralForestSpawner::SpawnAct1CrittersVictoryGatheringPostbridge()
IL_04a3: ldstr "act1_victory_sleepover"
IL_04a8: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_04ad: brfalse.s IL_04c7
IL_04af: ldstr "act1_victory_newday"
IL_04b4: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_04b9: brtrue.s IL_04c7
IL_04bb: ldarg.0
IL_04bc: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::endOfAct1Newday
IL_04c1: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_04c6: pop
IL_04c7: ldstr "CoyoteQuest_MeetTheCoyotes"
IL_04cc: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_04d1: brtrue.s IL_04ea
IL_04d3: ldarg.0
IL_04d4: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::otterShopFrontDoor
IL_04d9: ldarg.0
IL_04da: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_OtterShopFrontDoor()
IL_04df: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_04e4: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_04e9: pop
IL_04ea: ldstr "rang_plains_fast_travel_bell"
IL_04ef: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_04f4: brfalse.s IL_050e
IL_04f6: ldstr "show_dates_tutorial"
IL_04fb: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0500: brtrue.s IL_050e
IL_0502: ldarg.0
IL_0503: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::scarlettBuckyDatesIntroCutscene
IL_0508: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_050d: pop
IL_050e: ldstr "receive_bunny_package"
IL_0513: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0518: brfalse.s IL_0532
IL_051a: ldstr "DeliveryQuest_BunnyDeliveryOutside"
IL_051f: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0524: brtrue.s IL_0532
IL_0526: ldarg.0
IL_0527: ldfld TheForestOfLove.BunnyDeliveryOutsideCutscene TheForestOfLove.Content.CentralForestSpawner::bunnyDeliveryOutsideCutscene
IL_052c: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.BunnyDeliveryOutsideCutscene>(!!0)
IL_0531: pop
IL_0532: ldstr "DeliveryQuest_DeliverShovel"
IL_0537: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_053c: brfalse IL_05de
IL_0541: ldstr "CoyoteQuest_FinishShearingFinley"
IL_0546: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_054b: brfalse.s IL_0592
IL_054d: ldstr "dustin_minigame_finished_training_at_least_once"
IL_0552: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0557: brfalse.s IL_0579
IL_0559: call System.Boolean TheForestOfLove.QuestTriggerHelper::FinishedAct2()
IL_055e: brfalse.s IL_0579
IL_0560: ldarg.0
IL_0561: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::dustinBattlegroundFinishedNovice
IL_0566: ldarg.0
IL_0567: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_DustinBattleground()
IL_056c: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0571: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0576: pop
IL_0577: br.s IL_05de
IL_0579: ldarg.0
IL_057a: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::dustinBattlegroundFinished
IL_057f: ldarg.0
IL_0580: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_DustinBattleground()
IL_0585: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_058a: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_058f: pop
IL_0590: br.s IL_05de
IL_0592: ldc.i4 150
IL_0597: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_059c: brtrue.s IL_05aa
IL_059e: ldstr "DustinBattleground3"
IL_05a3: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_05a8: brfalse.s IL_05b8
IL_05aa: ldarg.0
IL_05ab: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::dustinBattlegroundWIP4
IL_05b0: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_05b5: pop
IL_05b6: br.s IL_05de
IL_05b8: ldstr "DustinBattleground2"
IL_05bd: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_05c2: brfalse.s IL_05d2
IL_05c4: ldarg.0
IL_05c5: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::dustinBattlegroundWIP3
IL_05ca: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_05cf: pop
IL_05d0: br.s IL_05de
IL_05d2: ldarg.0
IL_05d3: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::dustinBattlegroundWIP2
IL_05d8: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_05dd: pop
IL_05de: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsDeliveringCookies()
IL_05e3: brfalse.s IL_05fd
IL_05e5: ldstr "CookieQuest_CD_Bucky"
IL_05ea: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_05ef: brtrue.s IL_05fd
IL_05f1: ldarg.0
IL_05f2: ldfld TheForestOfLove.BuckyCookieDeliveryCutscene TheForestOfLove.Content.CentralForestSpawner::buckyCookieDeliveryCutscene
IL_05f7: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.BuckyCookieDeliveryCutscene>(!!0)
IL_05fc: pop
IL_05fd: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsCharlotteMeetingCritters()
IL_0602: brfalse.s IL_0610
IL_0604: ldarg.0
IL_0605: ldfld TheForestOfLove.CharlotteMeetsTheCrittersCutscene TheForestOfLove.Content.CentralForestSpawner::charlotteMeetsTheCrittersCutscene
IL_060a: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.CharlotteMeetsTheCrittersCutscene>(!!0)
IL_060f: pop
IL_0610: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3StormQuest()
IL_0615: brfalse IL_07de
IL_061a: ldarg.0
IL_061b: ldarg.0
IL_061c: ldstr "StormQuestBunnies"
IL_0621: ldarg.0
IL_0622: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_0627: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_062c: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_Act3StormQuestBunniesCutscene(AreaContent)
IL_0631: ldarg.0
IL_0632: ldarg.0
IL_0633: ldstr "StormQuestBuckyMinigame"
IL_0638: ldarg.0
IL_0639: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_063e: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0643: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_Act3StormQuestBuckyMinigame(AreaContent)
IL_0648: ldarg.0
IL_0649: ldarg.0
IL_064a: ldstr "StormQuestPageCollectionMinigame"
IL_064f: ldarg.0
IL_0650: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_0655: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_065a: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_Act3StormQuestFinalPageCutscene(AreaContent)
IL_065f: ldarg.0
IL_0660: ldarg.0
IL_0661: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::act3StormQuestEnvironment
IL_0666: ldarg.0
IL_0667: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Environment()
IL_066c: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0671: pop
IL_0672: ldarg.0
IL_0673: ldarg.0
IL_0674: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::act3StormQuestPagesMinigame
IL_0679: ldarg.0
IL_067a: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_067f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0684: pop
IL_0685: ldarg.0
IL_0686: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::otterShopFrontDoor
IL_068b: ldarg.0
IL_068c: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_OtterShopFrontDoor()
IL_0691: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0696: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_069b: pop
IL_069c: ldarg.0
IL_069d: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::bushHouseDoor
IL_06a2: ldarg.0
IL_06a3: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_BushHouseDoor()
IL_06a8: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_06ad: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_06b2: pop
IL_06b3: ldarg.0
IL_06b4: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::bunnyHouseDoor
IL_06b9: ldarg.0
IL_06ba: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_BunnyHouseDoor()
IL_06bf: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_06c4: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_06c9: pop
IL_06ca: ldarg.0
IL_06cb: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::beaverDamDoor
IL_06d0: ldarg.0
IL_06d1: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_BeaverDamDoor()
IL_06d6: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_06db: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_06e0: pop
IL_06e1: ldarg.0
IL_06e2: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_FastTravelPerchAct3StormQuest()
IL_06e7: callvirt !!0 UnityEngine.Component::GetComponentInChildren<TheForestOfLove.Gameplay.ObjectActor>()
IL_06ec: stloc.0
IL_06ed: call !!0[] UnityEngine.Object::FindObjectsOfType<TheForestOfLove.Interaction.DialogueInteractionTrigger>()
IL_06f2: stloc.1
IL_06f3: ldc.i4.0
IL_06f4: stloc.2
IL_06f5: br.s IL_0739
IL_06f7: ldloc.1
IL_06f8: ldloc.2
IL_06f9: ldelem.ref
IL_06fa: stloc.3
IL_06fb: ldloc.3
IL_06fc: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0701: callvirt !!0 UnityEngine.GameObject::GetComponentInParent<TheForestOfLove.Gameplay.ObjectActor>()
IL_0706: stloc.s V_4
IL_0708: ldloc.s V_4
IL_070a: ldnull
IL_070b: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0710: brfalse.s IL_072f
IL_0712: ldloc.0
IL_0713: ldnull
IL_0714: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0719: brfalse.s IL_072f
IL_071b: ldloc.s V_4
IL_071d: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0722: ldloc.0
IL_0723: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0728: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_072d: brtrue.s IL_0735
IL_072f: ldloc.3
IL_0730: callvirt System.Void TheForestOfLove.Interaction.InteractionTrigger::DisableTriggerActivation()
IL_0735: ldloc.2
IL_0736: ldc.i4.1
IL_0737: add
IL_0738: stloc.2
IL_0739: ldloc.2
IL_073a: ldloc.1
IL_073b: ldlen
IL_073c: conv.i4
IL_073d: blt.s IL_06f7
IL_073f: ldarg.0
IL_0740: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_BunnyGardenWalkInteraction()
IL_0745: callvirt System.Void AreaContent::Disable()
IL_074a: ldarg.0
IL_074b: ldarg.0
IL_074c: ldarg.0
IL_074d: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::act3StormQuestPathBlockers
IL_0752: ldnull
IL_0753: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,UnityEngine.Transform)
IL_0758: call System.Void TheForestOfLove.Content.CentralForestSpawner::set_Act3StormQuestPathBlockers(AreaContent)
IL_075d: ldstr "StormQuest_ScarlettAndPeter"
IL_0762: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0767: brtrue.s IL_0783
IL_0769: ldarg.0
IL_076a: ldarg.0
IL_076b: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::act3StormQuestBunniesCutscene
IL_0770: ldarg.0
IL_0771: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_Act3StormQuestBunniesCutscene()
IL_0776: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_077b: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,UnityEngine.Transform)
IL_0780: pop
IL_0781: br.s IL_0796
IL_0783: ldarg.0
IL_0784: ldarg.0
IL_0785: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::act3StormQuestBunniesGardenCoveredTarp
IL_078a: ldarg.0
IL_078b: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_0790: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0795: pop
IL_0796: ldstr "StormQuest_ScarlettAndPeter"
IL_079b: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_07a0: brfalse.s IL_07b4
IL_07a2: ldstr "StormQuest_DustinAndBucky"
IL_07a7: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_07ac: brtrue.s IL_07b4
IL_07ae: ldarg.0
IL_07af: call System.Void TheForestOfLove.Content.CentralForestSpawner::Act3StormQuestFinishedTalkingToBunnies_Internal()
IL_07b4: ldstr "StormQuest_BuckyMinigame"
IL_07b9: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_07be: brfalse.s IL_07de
IL_07c0: ldstr "StormQuest_MabelGrabbedTheLastPage"
IL_07c5: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_07ca: brtrue.s IL_07de
IL_07cc: ldstr "act3_thestorm_collected_enough_pages"
IL_07d1: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_07d6: brfalse.s IL_07de
IL_07d8: ldarg.0
IL_07d9: call System.Void TheForestOfLove.Content.CentralForestSpawner::Act3StormQuestSpawnStuckPage_Internal()
IL_07de: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3AfterstormQuestKickoff()
IL_07e3: brfalse.s IL_07eb
IL_07e5: ldc.i4.1
IL_07e6: call System.Void TheForestOfLove.TransitionEffectsManager::set_IgnoreNextFadeFromBlack(System.Boolean)
IL_07eb: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3AfterstormQuestKickoff()
IL_07f0: brtrue.s IL_07f9
IL_07f2: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3AfterstormQuest()
IL_07f7: brfalse.s IL_083f
IL_07f9: ldstr "AfterstormQuest_ScarlettAndPeter"
IL_07fe: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0803: brtrue.s IL_081c
IL_0805: ldarg.0
IL_0806: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::beaverDamDoor
IL_080b: ldarg.0
IL_080c: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_BeaverDamDoor()
IL_0811: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0816: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_081b: pop
IL_081c: ldstr "AfterstormQuest_Bucky"
IL_0821: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0826: brtrue.s IL_083f
IL_0828: ldarg.0
IL_0829: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::otterShopFrontDoor
IL_082e: ldarg.0
IL_082f: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_OtterShopFrontDoor()
IL_0834: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0839: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_083e: pop
IL_083f: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3LightQuestGatheringFireflies()
IL_0844: brfalse.s IL_084c
IL_0846: ldarg.0
IL_0847: call System.Void TheForestOfLove.Content.CentralForestSpawner::Act3LightQuestSpawnFireflies_Internal()
IL_084c: call System.Boolean TheForestOfLove.QuestTriggerHelper::CanSpawnScarlettHop()
IL_0851: brfalse.s IL_08a0
IL_0853: ldarg.0
IL_0854: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::npcScarlettHop
IL_0859: ldarg.0
IL_085a: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_Scarlett()
IL_085f: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0864: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0869: pop
IL_086a: ldarg.0
IL_086b: ldarg.0
IL_086c: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::scarlettHopHints
IL_0871: ldarg.0
IL_0872: call AreaContentSet TheForestOfLove.Content.CentralForestSpawner::get_Elements()
IL_0877: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_087c: pop
IL_087d: ldarg.0
IL_087e: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::beaverDamDoor
IL_0883: ldarg.0
IL_0884: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_BeaverDamDoor()
IL_0889: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_088e: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0893: pop
IL_0894: ldarg.0
IL_0895: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::act3WolfQuestPathBlockers
IL_089a: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_089f: pop
IL_08a0: ldstr "WolfQuest_MeetTheWolf"
IL_08a5: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_08aa: brfalse.s IL_08cf
IL_08ac: ldstr "act3_wolfquest_asked_enough_critters_about_the_wolf"
IL_08b1: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_08b6: brtrue.s IL_08cf
IL_08b8: ldarg.0
IL_08b9: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::bunnyHouseDoor
IL_08be: ldarg.0
IL_08bf: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_BunnyHouseDoor()
IL_08c4: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_08c9: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_08ce: pop
IL_08cf: ldarg.0
IL_08d0: call System.Void TheForestOfLove.Content.CentralForestSpawner::SpawnDatingCritters()
IL_08d5: ldarg.0
IL_08d6: call System.Void TheForestOfLove.Content.CentralForestSpawner::RefreshFastTravelPerch_Internal()
IL_08db: ldarg.0
IL_08dc: call System.Void TheForestOfLove.Content.CentralForestSpawner::SpawnDefaultCritters()
IL_08e1: ldstr "Scarlett"
IL_08e6: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorDespawnedOrOnDate(System.String)
IL_08eb: brfalse.s IL_08f8
IL_08ed: ldarg.0
IL_08ee: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_BunnyGardenWalkInteraction()
IL_08f3: callvirt System.Void AreaContent::Disable()
IL_08f8: ldarg.0
IL_08f9: ldstr "home"
IL_08fe: call System.Boolean TheForestOfLove.Content.BaseSpawner::CanSpawnAdventuresForGatewayName(System.String)
IL_0903: brfalse.s IL_090b
IL_0905: ldarg.0
IL_0906: call System.Void TheForestOfLove.Content.CentralForestSpawner::SpawnAdventuresTeleport()
IL_090b: ldarg.0
IL_090c: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::melodyFlipbookPhotoFirst
IL_0911: call System.Boolean TheForestOfLove.Content.BaseSpawner::CanSpawnMelodyFlipbookPhotoPickup(UnityEngine.GameObject)
IL_0916: brfalse.s IL_0961
IL_0918: ldarg.0
IL_0919: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::melodyFlipbookPhotoFirst
IL_091e: ldarg.0
IL_091f: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_MelodyFlipbookPhotoFirst()
IL_0924: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0929: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_092e: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0933: ldarg.0
IL_0934: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::melodyFlipbookPhotoFirstSpawnLocation
IL_0939: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_093e: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0943: ldc.r4 1
IL_0948: ldc.r4 1
IL_094d: ldc.r4 0
IL_0952: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_0957: call UnityEngine.Vector3 UnityEngine.Vector3::Scale(UnityEngine.Vector3,UnityEngine.Vector3)
IL_095c: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_0961: ldarg.0
IL_0962: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::melodyFlipbookPhotoSecond
IL_0967: call System.Boolean TheForestOfLove.Content.BaseSpawner::CanSpawnMelodyFlipbookPhotoPickup(UnityEngine.GameObject)
IL_096c: brfalse.s IL_09b7
IL_096e: ldarg.0
IL_096f: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::melodyFlipbookPhotoSecond
IL_0974: ldarg.0
IL_0975: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_MelodyFlipbookPhotoSecond()
IL_097a: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_097f: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0984: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0989: ldarg.0
IL_098a: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::melodyFlipbookPhotoSecondSpawnLocation
IL_098f: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0994: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0999: ldc.r4 1
IL_099e: ldc.r4 1
IL_09a3: ldc.r4 0
IL_09a8: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_09ad: call UnityEngine.Vector3 UnityEngine.Vector3::Scale(UnityEngine.Vector3,UnityEngine.Vector3)
IL_09b2: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_09b7: ldarg.0
IL_09b8: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::melodyFlipbookPhotoThird
IL_09bd: call System.Boolean TheForestOfLove.Content.BaseSpawner::CanSpawnMelodyFlipbookPhotoPickup(UnityEngine.GameObject)
IL_09c2: brfalse.s IL_0a0d
IL_09c4: ldarg.0
IL_09c5: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::melodyFlipbookPhotoThird
IL_09ca: ldarg.0
IL_09cb: call AreaContent TheForestOfLove.Content.CentralForestSpawner::get_MelodyFlipbookPhotoThird()
IL_09d0: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_09d5: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_09da: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_09df: ldarg.0
IL_09e0: ldfld UnityEngine.GameObject TheForestOfLove.Content.CentralForestSpawner::melodyFlipbookPhotoThirdSpawnLocation
IL_09e5: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_09ea: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_09ef: ldc.r4 1
IL_09f4: ldc.r4 1
IL_09f9: ldc.r4 0
IL_09fe: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_0a03: call UnityEngine.Vector3 UnityEngine.Vector3::Scale(UnityEngine.Vector3,UnityEngine.Vector3)
IL_0a08: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_0a0d: call System.Boolean TheForestOfLove.PlantQuestMinigameControllerRedux::get_minigameActive()
IL_0a12: brfalse.s IL_0a1a
IL_0a14: ldarg.0
IL_0a15: call System.Void TheForestOfLove.Content.CentralForestSpawner::SetupSceneForPlantMinigame()
IL_0a1a: ret
