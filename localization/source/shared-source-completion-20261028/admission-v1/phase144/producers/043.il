TYPE TheForestOfLove.Content.MountainsSpawner
METHOD System.Void TheForestOfLove.Content.MountainsSpawner::SpawnObjects() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldstr "Environment"
IL_0007: ldnull
IL_0008: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_000d: call System.Void TheForestOfLove.Content.MountainsSpawner::set_Environment(AreaContentSet)
IL_0012: ldarg.0
IL_0013: ldarg.0
IL_0014: ldstr "Elements"
IL_0019: ldnull
IL_001a: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_001f: call System.Void TheForestOfLove.Content.MountainsSpawner::set_Elements(AreaContentSet)
IL_0024: ldarg.0
IL_0025: ldarg.0
IL_0026: ldstr "Critters"
IL_002b: ldnull
IL_002c: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_0031: call System.Void TheForestOfLove.Content.MountainsSpawner::set_Critters(AreaContentSet)
IL_0036: ldarg.0
IL_0037: ldarg.0
IL_0038: ldarg.0
IL_0039: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::player
IL_003e: ldnull
IL_003f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,UnityEngine.Transform)
IL_0044: call System.Void TheForestOfLove.Content.MountainsSpawner::set_Player(AreaContent)
IL_0049: ldarg.0
IL_004a: ldarg.0
IL_004b: ldarg.0
IL_004c: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::environmentBase
IL_0051: ldarg.0
IL_0052: call AreaContentSet TheForestOfLove.Content.MountainsSpawner::get_Environment()
IL_0057: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_005c: call System.Void TheForestOfLove.Content.MountainsSpawner::set_EnvironmentBase(AreaContent)
IL_0061: ldarg.0
IL_0062: ldarg.0
IL_0063: ldarg.0
IL_0064: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::elementsBase
IL_0069: ldarg.0
IL_006a: call AreaContentSet TheForestOfLove.Content.MountainsSpawner::get_Elements()
IL_006f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0074: call System.Void TheForestOfLove.Content.MountainsSpawner::set_ElementsBase(AreaContent)
IL_0079: ldarg.0
IL_007a: ldarg.0
IL_007b: ldarg.0
IL_007c: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::appleTree
IL_0081: ldarg.0
IL_0082: call AreaContentSet TheForestOfLove.Content.MountainsSpawner::get_Elements()
IL_0087: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_008c: call System.Void TheForestOfLove.Content.MountainsSpawner::set_AppleTree(AreaContent)
IL_0091: ldarg.0
IL_0092: ldarg.0
IL_0093: ldarg.0
IL_0094: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::easelCameraTarget
IL_0099: callvirt System.String UnityEngine.Object::get_name()
IL_009e: ldarg.0
IL_009f: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::easelCameraTarget
IL_00a4: ldarg.0
IL_00a5: call AreaContentSet TheForestOfLove.Content.MountainsSpawner::get_Elements()
IL_00aa: ldc.i4.0
IL_00ab: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContentOrFind(System.String,UnityEngine.GameObject,AreaContentSet,System.Boolean)
IL_00b0: call System.Void TheForestOfLove.Content.MountainsSpawner::set_EaselCameraTarget(AreaContent)
IL_00b5: ldarg.0
IL_00b6: ldfld TheForestOfLove.FastTravelCutscene TheForestOfLove.Content.MountainsSpawner::fastTravelCutscene
IL_00bb: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.FastTravelCutscene>(!!0)
IL_00c0: pop
IL_00c1: ldarg.0
IL_00c2: ldnull
IL_00c3: call System.Void TheForestOfLove.Content.MountainsSpawner::set_FastTravelPerch(AreaContent)
IL_00c8: ldarg.0
IL_00c9: ldarg.0
IL_00ca: ldarg.0
IL_00cb: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::fastTravelPerchNoBell
IL_00d0: ldarg.0
IL_00d1: call AreaContentSet TheForestOfLove.Content.MountainsSpawner::get_Elements()
IL_00d6: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_00db: call System.Void TheForestOfLove.Content.MountainsSpawner::set_FastTravelPerchNoBell(AreaContent)
IL_00e0: ldarg.0
IL_00e1: ldarg.0
IL_00e2: ldarg.0
IL_00e3: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::fastTravelPerchWithBell
IL_00e8: ldarg.0
IL_00e9: call AreaContentSet TheForestOfLove.Content.MountainsSpawner::get_Elements()
IL_00ee: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_00f3: call System.Void TheForestOfLove.Content.MountainsSpawner::set_FastTravelPerchWithBell(AreaContent)
IL_00f8: ldarg.0
IL_00f9: ldarg.0
IL_00fa: ldarg.0
IL_00fb: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::fastTravelPerchPennyBusyElsewhere
IL_0100: ldarg.0
IL_0101: call AreaContentSet TheForestOfLove.Content.MountainsSpawner::get_Elements()
IL_0106: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_010b: call System.Void TheForestOfLove.Content.MountainsSpawner::set_FastTravelPerchPennyBusyElsewhere(AreaContent)
IL_0110: ldarg.0
IL_0111: ldarg.0
IL_0112: ldarg.0
IL_0113: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::glyphStones
IL_0118: callvirt System.String UnityEngine.Object::get_name()
IL_011d: ldarg.0
IL_011e: call AreaContentSet TheForestOfLove.Content.MountainsSpawner::get_Elements()
IL_0123: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0128: call System.Void TheForestOfLove.Content.MountainsSpawner::set_GlyphStones(AreaContent)
IL_012d: ldarg.0
IL_012e: ldarg.0
IL_012f: ldarg.0
IL_0130: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::mountainTopAccessBlocker
IL_0135: callvirt System.String UnityEngine.Object::get_name()
IL_013a: ldarg.0
IL_013b: call AreaContentSet TheForestOfLove.Content.MountainsSpawner::get_Elements()
IL_0140: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0145: call System.Void TheForestOfLove.Content.MountainsSpawner::set_AccessBlocker(AreaContent)
IL_014a: ldarg.0
IL_014b: ldarg.0
IL_014c: ldarg.0
IL_014d: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::easel
IL_0152: callvirt System.String UnityEngine.Object::get_name()
IL_0157: ldarg.0
IL_0158: call AreaContentSet TheForestOfLove.Content.MountainsSpawner::get_Elements()
IL_015d: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0162: call System.Void TheForestOfLove.Content.MountainsSpawner::set_Easel(AreaContent)
IL_0167: ldarg.0
IL_0168: ldarg.0
IL_0169: ldstr "Finley"
IL_016e: ldarg.0
IL_016f: call AreaContentSet TheForestOfLove.Content.MountainsSpawner::get_Critters()
IL_0174: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0179: call System.Void TheForestOfLove.Content.MountainsSpawner::set_Finley(AreaContent)
IL_017e: ldarg.0
IL_017f: ldarg.0
IL_0180: ldarg.0
IL_0181: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::melodyFlipbookPhotoFirst
IL_0186: callvirt System.String UnityEngine.Object::get_name()
IL_018b: ldarg.0
IL_018c: call AreaContentSet TheForestOfLove.Content.MountainsSpawner::get_Elements()
IL_0191: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0196: call System.Void TheForestOfLove.Content.MountainsSpawner::set_MelodyFlipbookPhotoFirst(AreaContent)
IL_019b: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_01a0: brfalse.s IL_01a9
IL_01a2: ldarg.0
IL_01a3: call System.Void TheForestOfLove.Content.MountainsSpawner::SpawnInstancedStoryStuff()
IL_01a8: ret
IL_01a9: ldarg.0
IL_01aa: call System.Void TheForestOfLove.Content.MountainsSpawner::RefreshFastTravelPerch_Internal()
IL_01af: ldc.i4.0
IL_01b0: stloc.0
IL_01b1: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3AfterstormQuest()
IL_01b6: brtrue.s IL_01bf
IL_01b8: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3LightQuest()
IL_01bd: brfalse.s IL_01da
IL_01bf: ldc.i4.1
IL_01c0: stloc.0
IL_01c1: ldarg.0
IL_01c2: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::easelAct3Afterstorm
IL_01c7: ldarg.0
IL_01c8: call AreaContent TheForestOfLove.Content.MountainsSpawner::get_Easel()
IL_01cd: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_01d2: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_01d7: pop
IL_01d8: br.s IL_01f1
IL_01da: ldarg.0
IL_01db: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::easel
IL_01e0: ldarg.0
IL_01e1: call AreaContent TheForestOfLove.Content.MountainsSpawner::get_Easel()
IL_01e6: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_01eb: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_01f0: pop
IL_01f1: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAct2CapstoneOngoing()
IL_01f6: brfalse.s IL_0211
IL_01f8: ldarg.0
IL_01f9: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::glyphStonesGlowy
IL_01fe: ldarg.0
IL_01ff: call AreaContent TheForestOfLove.Content.MountainsSpawner::get_GlyphStones()
IL_0204: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0209: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_020e: pop
IL_020f: br.s IL_0228
IL_0211: ldarg.0
IL_0212: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::glyphStones
IL_0217: ldarg.0
IL_0218: call AreaContent TheForestOfLove.Content.MountainsSpawner::get_GlyphStones()
IL_021d: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0222: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0227: pop
IL_0228: ldstr "Act2_DonkeyQuest"
IL_022d: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.QuestTriggerHelper::LoadQuestStatus(System.String)
IL_0232: ldc.i4.s 100
IL_0234: bne.un.s IL_024e
IL_0236: ldstr "collected_apples"
IL_023b: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0240: brtrue.s IL_024e
IL_0242: ldarg.0
IL_0243: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::donkeyQuestApples
IL_0248: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_024d: pop
IL_024e: call System.Boolean TheForestOfLove.QuestTriggerHelper::FinishedAct2()
IL_0253: brfalse.s IL_0263
IL_0255: ldarg.0
IL_0256: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::mountainsSweaterTransition
IL_025b: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0260: pop
IL_0261: br.s IL_026f
IL_0263: ldarg.0
IL_0264: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::mountainTopAccessBlocker
IL_0269: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_026e: pop
IL_026f: ldc.i4 150
IL_0274: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0279: brfalse.s IL_029e
IL_027b: ldstr "CoyoteQuest_FinleyAgreesToShearing"
IL_0280: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0285: brtrue.s IL_029e
IL_0287: ldarg.0
IL_0288: call AreaContent TheForestOfLove.Content.MountainsSpawner::get_Easel()
IL_028d: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::DisableInteractionInChildren(AreaContent)
IL_0292: ldarg.0
IL_0293: ldfld TheForestOfLove.FinleyShearingCutscene TheForestOfLove.Content.MountainsSpawner::act2FinleyAsksForShearingCutscene
IL_0298: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.FinleyShearingCutscene>(!!0)
IL_029d: pop
IL_029e: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsWoolCollectionOngoing()
IL_02a3: brfalse.s IL_02ab
IL_02a5: ldarg.0
IL_02a6: call System.Void TheForestOfLove.Content.MountainsSpawner::InstantiateWoolCollectionObjects_Internal()
IL_02ab: call System.Boolean TheForestOfLove.QuestTriggerHelper::FinishedAct2()
IL_02b0: brfalse.s IL_02ee
IL_02b2: ldstr "FinleyQuest_IntroFromFinley"
IL_02b7: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_02bc: brtrue.s IL_02ee
IL_02be: ldarg.0
IL_02bf: call AreaContent TheForestOfLove.Content.MountainsSpawner::get_Easel()
IL_02c4: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::DisableInteractionInChildren(AreaContent)
IL_02c9: ldarg.0
IL_02ca: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::npcFinleyFromAct3IntroCutscene
IL_02cf: ldarg.0
IL_02d0: call AreaContent TheForestOfLove.Content.MountainsSpawner::get_Finley()
IL_02d5: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_02da: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_02df: pop
IL_02e0: ldarg.0
IL_02e1: ldfld TheForestOfLove.FinleyAct3IntroCutscene TheForestOfLove.Content.MountainsSpawner::finleyAct3IntroCutscene
IL_02e6: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.FinleyAct3IntroCutscene>(!!0)
IL_02eb: pop
IL_02ec: br.s IL_02fe
IL_02ee: call System.Boolean TheForestOfLove.QuestTriggerHelper::FinishedAct2()
IL_02f3: brfalse.s IL_02fe
IL_02f5: ldloc.0
IL_02f6: brtrue.s IL_02fe
IL_02f8: ldarg.0
IL_02f9: call System.Void TheForestOfLove.Content.MountainsSpawner::ConfigureEaselForPostAct2RotatingPaintings()
IL_02fe: ldarg.0
IL_02ff: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::melodyFlipbookPhotoFirst
IL_0304: call System.Boolean TheForestOfLove.Content.BaseSpawner::CanSpawnMelodyFlipbookPhotoPickup(UnityEngine.GameObject)
IL_0309: brfalse.s IL_0354
IL_030b: ldarg.0
IL_030c: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::melodyFlipbookPhotoFirst
IL_0311: ldarg.0
IL_0312: call AreaContent TheForestOfLove.Content.MountainsSpawner::get_MelodyFlipbookPhotoFirst()
IL_0317: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_031c: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0321: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0326: ldarg.0
IL_0327: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::melodyFlipbookPhotoFirstSpawnLocation
IL_032c: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0331: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0336: ldc.r4 1
IL_033b: ldc.r4 1
IL_0340: ldc.r4 0
IL_0345: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_034a: call UnityEngine.Vector3 UnityEngine.Vector3::Scale(UnityEngine.Vector3,UnityEngine.Vector3)
IL_034f: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_0354: ldarg.0
IL_0355: call System.Void TheForestOfLove.Content.MountainsSpawner::SpawnDefaultCritters()
IL_035a: call System.Boolean TheForestOfLove.QuestTriggerHelper::FinishedAct2()
IL_035f: brfalse.s IL_0378
IL_0361: ldstr "Finley"
IL_0366: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorSpawned(System.String)
IL_036b: brtrue.s IL_0378
IL_036d: ldarg.0
IL_036e: call AreaContent TheForestOfLove.Content.MountainsSpawner::get_Easel()
IL_0373: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::DisableInteractionInChildren(AreaContent)
IL_0378: ret
METHOD System.Void TheForestOfLove.Content.MountainsSpawner::SpawnInstancedStoryStuff() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Content.MountainsSpawner::RefreshFastTravelPerch_Internal()
IL_0006: ldarg.0
IL_0007: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::npcFinley
IL_000c: ldarg.0
IL_000d: call AreaContent TheForestOfLove.Content.MountainsSpawner::get_Finley()
IL_0012: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0017: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_001c: pop
IL_001d: ldarg.0
IL_001e: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::easel
IL_0023: ldarg.0
IL_0024: call AreaContent TheForestOfLove.Content.MountainsSpawner::get_Easel()
IL_0029: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_002e: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0033: pop
IL_0034: call System.Boolean TheForestOfLove.QuestTriggerHelper::FinishedAct2()
IL_0039: brfalse.s IL_004f
IL_003b: ldarg.0
IL_003c: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::mountainsSweaterTransition
IL_0041: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0046: pop
IL_0047: ldarg.0
IL_0048: call System.Void TheForestOfLove.Content.MountainsSpawner::ConfigureEaselForPostAct2RotatingPaintings()
IL_004d: br.s IL_005b
IL_004f: ldarg.0
IL_0050: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::mountainTopAccessBlocker
IL_0055: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_005a: pop
IL_005b: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsBootyLineupFemalesQuestOngoing()
IL_0060: brfalse.s IL_007a
IL_0062: ldstr "BootyLineUpFemalesQuest_RecruitTheLadies"
IL_0067: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_006c: brtrue.s IL_007a
IL_006e: ldarg.0
IL_006f: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::bootyLineupFemalesCritters
IL_0074: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0079: pop
IL_007a: call System.Boolean TheForestOfLove.QuestTriggerHelper::FinishedAct2()
IL_007f: brfalse.s IL_0098
IL_0081: ldstr "Finley"
IL_0086: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorSpawned(System.String)
IL_008b: brtrue.s IL_0098
IL_008d: ldarg.0
IL_008e: call AreaContent TheForestOfLove.Content.MountainsSpawner::get_Easel()
IL_0093: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::DisableInteractionInChildren(AreaContent)
IL_0098: ret
METHOD System.Void TheForestOfLove.Content.MountainsSpawner::ConfigureEaselForPostAct2RotatingPaintings() | attributes=Private, HideBySig | impl=IL
IL_0000: ldnull
IL_0001: stloc.0
IL_0002: ldnull
IL_0003: stloc.1
IL_0004: ldnull
IL_0005: stloc.2
IL_0006: ldstr "finley_current_painting_number"
IL_000b: call System.String TheForestOfLove.Services.Persistence.DataService::GetVariable(System.String)
IL_0010: stloc.3
IL_0011: ldloc.3
IL_0012: brtrue.s IL_0029
IL_0014: ldstr "finley_current_painting_number"
IL_0019: ldstr "2"
IL_001e: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_0023: ldstr "2"
IL_0028: stloc.3
IL_0029: ldloc.3
IL_002a: call System.Int32 System.Int32::Parse(System.String)
IL_002f: stloc.s V_4
IL_0031: ldloc.s V_4
IL_0033: ldc.i4.2
IL_0034: sub
IL_0035: switch IL_0052,IL_0061,IL_0070,IL_0085,IL_009a,IL_00af
IL_0052: ldarg.0
IL_0053: ldfld UnityEngine.Sprite TheForestOfLove.Content.MountainsSpawner::ramEaselArtwork2
IL_0058: stloc.0
IL_0059: ldstr "Examinables_Mountains_Easel2"
IL_005e: stloc.1
IL_005f: br.s IL_00c2
IL_0061: ldarg.0
IL_0062: ldfld UnityEngine.Sprite TheForestOfLove.Content.MountainsSpawner::ramEaselArtwork3
IL_0067: stloc.0
IL_0068: ldstr "Examinables_Mountains_Easel3"
IL_006d: stloc.1
IL_006e: br.s IL_00c2
IL_0070: ldarg.0
IL_0071: ldfld UnityEngine.Sprite TheForestOfLove.Content.MountainsSpawner::ramEaselArtworkEyes
IL_0076: stloc.0
IL_0077: ldstr "Examinables_Mountains_Easel5"
IL_007c: stloc.1
IL_007d: ldstr "dragon_eyes"
IL_0082: stloc.2
IL_0083: br.s IL_00c2
IL_0085: ldarg.0
IL_0086: ldfld UnityEngine.Sprite TheForestOfLove.Content.MountainsSpawner::ramEaselArtworkMask
IL_008b: stloc.0
IL_008c: ldstr "Examinables_Mountains_Easel5"
IL_0091: stloc.1
IL_0092: ldstr "mask"
IL_0097: stloc.2
IL_0098: br.s IL_00c2
IL_009a: ldarg.0
IL_009b: ldfld UnityEngine.Sprite TheForestOfLove.Content.MountainsSpawner::ramEaselArtworkPorcupine
IL_00a0: stloc.0
IL_00a1: ldstr "Examinables_Mountains_Easel5"
IL_00a6: stloc.1
IL_00a7: ldstr "porcupine"
IL_00ac: stloc.2
IL_00ad: br.s IL_00c2
IL_00af: ldarg.0
IL_00b0: ldfld UnityEngine.Sprite TheForestOfLove.Content.MountainsSpawner::ramEaselArtworkRaccoon
IL_00b5: stloc.0
IL_00b6: ldstr "Examinables_Mountains_Easel5"
IL_00bb: stloc.1
IL_00bc: ldstr "raccoon"
IL_00c1: stloc.2
IL_00c2: ldloc.s V_4
IL_00c4: ldc.i4.7
IL_00c5: blt.s IL_00ca
IL_00c7: ldc.i4.1
IL_00c8: stloc.s V_4
IL_00ca: ldsfld UnityEngine.KeyCode TheForestOfLove.InputHelper::LastRecordedKey
IL_00cf: ldc.i4.s 56
IL_00d1: ceq
IL_00d3: stloc.s V_5
IL_00d5: ldstr "Movies_MabelRascalAfterTheStorm_Dialogue"
IL_00da: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_00df: brtrue.s IL_010a
IL_00e1: ldstr "painting2"
IL_00e6: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_00eb: brtrue.s IL_010a
IL_00ed: ldarg.0
IL_00ee: ldfld UnityEngine.Sprite TheForestOfLove.Content.MountainsSpawner::ramEaselArtwork2
IL_00f3: stloc.0
IL_00f4: ldstr "Examinables_Mountains_Easel2"
IL_00f9: stloc.1
IL_00fa: ldc.i4.1
IL_00fb: stloc.s V_4
IL_00fd: ldarg.0
IL_00fe: call AreaContent TheForestOfLove.Content.MountainsSpawner::get_Easel()
IL_0103: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::DisableInteractionInChildren(AreaContent)
IL_0108: br.s IL_0144
IL_010a: ldstr "GlitchRascal_GlitchConclusion"
IL_010f: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0114: brfalse.s IL_0144
IL_0116: ldc.r4 0
IL_011b: ldc.r4 1
IL_0120: call System.Single UnityEngine.Random::Range(System.Single,System.Single)
IL_0125: ldc.r4 0.05
IL_012a: clt
IL_012c: ldloc.s V_5
IL_012e: or
IL_012f: brfalse.s IL_0144
IL_0131: ldarg.0
IL_0132: ldfld UnityEngine.Sprite TheForestOfLove.Content.MountainsSpawner::ramEaselArtworkGlitch
IL_0137: stloc.0
IL_0138: ldstr "Examinables_Mountains_Easel5"
IL_013d: stloc.1
IL_013e: ldstr "something"
IL_0143: stloc.2
IL_0144: ldstr "finley_current_painting_number"
IL_0149: ldloc.s V_4
IL_014b: ldc.i4.1
IL_014c: add
IL_014d: dup
IL_014e: stloc.s V_4
IL_0150: stloc.s V_6
IL_0152: ldloca.s V_6
IL_0154: call System.String System.Int32::ToString()
IL_0159: call System.Void TheForestOfLove.Services.Persistence.DataService::SetVariable(System.String,System.String)
IL_015e: ldarg.0
IL_015f: call AreaContent TheForestOfLove.Content.MountainsSpawner::get_Easel()
IL_0164: callvirt !!0 UnityEngine.Component::GetComponentInChildren<UnityEngine.SpriteRenderer>()
IL_0169: ldloc.0
IL_016a: callvirt System.Void UnityEngine.SpriteRenderer::set_sprite(UnityEngine.Sprite)
IL_016f: ldarg.0
IL_0170: call AreaContent TheForestOfLove.Content.MountainsSpawner::get_Easel()
IL_0175: ldloc.1
IL_0176: ldloc.2
IL_0177: ldnull
IL_0178: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::SetTargetDialogueInChildren(AreaContent,System.String,System.String,System.String)
IL_017d: ret
METHOD System.Void TheForestOfLove.Content.MountainsSpawner::SpawnFinley() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "Finley"
IL_0005: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorSpawnedOrOnDate(System.String)
IL_000a: brfalse.s IL_000d
IL_000c: ret
IL_000d: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3AfterstormQuest()
IL_0012: brtrue.s IL_001b
IL_0014: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3LightQuest()
IL_0019: brfalse.s IL_001c
IL_001b: ret
IL_001c: ldarg.0
IL_001d: ldfld UnityEngine.GameObject TheForestOfLove.Content.MountainsSpawner::npcFinley
IL_0022: ldarg.0
IL_0023: call AreaContent TheForestOfLove.Content.MountainsSpawner::get_Finley()
IL_0028: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_002d: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0032: pop
IL_0033: ret
