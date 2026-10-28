TYPE TheForestOfLove.Content.PlainsEndSpawner
METHOD System.Void TheForestOfLove.Content.PlainsEndSpawner::SpawnObjects() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldstr "Environment"
IL_0007: ldnull
IL_0008: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_000d: call System.Void TheForestOfLove.Content.PlainsEndSpawner::set_Environment(AreaContentSet)
IL_0012: ldarg.0
IL_0013: ldarg.0
IL_0014: ldstr "Elements"
IL_0019: ldnull
IL_001a: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_001f: call System.Void TheForestOfLove.Content.PlainsEndSpawner::set_Elements(AreaContentSet)
IL_0024: ldarg.0
IL_0025: ldarg.0
IL_0026: ldstr "Critters"
IL_002b: ldnull
IL_002c: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_0031: call System.Void TheForestOfLove.Content.PlainsEndSpawner::set_Critters(AreaContentSet)
IL_0036: ldarg.0
IL_0037: ldarg.0
IL_0038: ldarg.0
IL_0039: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsEndSpawner::player
IL_003e: ldnull
IL_003f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,UnityEngine.Transform)
IL_0044: call System.Void TheForestOfLove.Content.PlainsEndSpawner::set_Player(AreaContent)
IL_0049: ldarg.0
IL_004a: ldarg.0
IL_004b: ldarg.0
IL_004c: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsEndSpawner::environmentBase
IL_0051: ldarg.0
IL_0052: call AreaContentSet TheForestOfLove.Content.PlainsEndSpawner::get_Environment()
IL_0057: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_005c: call System.Void TheForestOfLove.Content.PlainsEndSpawner::set_EnvironmentBase(AreaContent)
IL_0061: ldarg.0
IL_0062: ldarg.0
IL_0063: ldarg.0
IL_0064: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsEndSpawner::elementsBase
IL_0069: ldarg.0
IL_006a: call AreaContentSet TheForestOfLove.Content.PlainsEndSpawner::get_Elements()
IL_006f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0074: call System.Void TheForestOfLove.Content.PlainsEndSpawner::set_ElementsBase(AreaContent)
IL_0079: ldarg.0
IL_007a: ldnull
IL_007b: call System.Void TheForestOfLove.Content.PlainsEndSpawner::set_FastTravelPerch(AreaContent)
IL_0080: ldarg.0
IL_0081: ldarg.0
IL_0082: ldarg.0
IL_0083: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsEndSpawner::fastTravelPerchNoBell
IL_0088: ldarg.0
IL_0089: call AreaContentSet TheForestOfLove.Content.PlainsEndSpawner::get_Elements()
IL_008e: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0093: call System.Void TheForestOfLove.Content.PlainsEndSpawner::set_FastTravelPerchNoBell(AreaContent)
IL_0098: ldarg.0
IL_0099: ldarg.0
IL_009a: ldarg.0
IL_009b: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsEndSpawner::fastTravelPerchWithBell
IL_00a0: ldarg.0
IL_00a1: call AreaContentSet TheForestOfLove.Content.PlainsEndSpawner::get_Elements()
IL_00a6: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_00ab: call System.Void TheForestOfLove.Content.PlainsEndSpawner::set_FastTravelPerchWithBell(AreaContent)
IL_00b0: ldarg.0
IL_00b1: ldarg.0
IL_00b2: ldarg.0
IL_00b3: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsEndSpawner::fastTravelPerchPennyBusyElsewhere
IL_00b8: ldarg.0
IL_00b9: call AreaContentSet TheForestOfLove.Content.PlainsEndSpawner::get_Elements()
IL_00be: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_00c3: call System.Void TheForestOfLove.Content.PlainsEndSpawner::set_FastTravelPerchPennyBusyElsewhere(AreaContent)
IL_00c8: ldarg.0
IL_00c9: ldarg.0
IL_00ca: ldarg.0
IL_00cb: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsEndSpawner::act2FastTravelExitBlocker
IL_00d0: ldarg.0
IL_00d1: call AreaContentSet TheForestOfLove.Content.PlainsEndSpawner::get_Elements()
IL_00d6: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_00db: call System.Void TheForestOfLove.Content.PlainsEndSpawner::set_Act2FastTravelExitBlocker(AreaContent)
IL_00e0: ldarg.0
IL_00e1: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsEndSpawner::fastTravelCutscene
IL_00e6: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_00eb: pop
IL_00ec: ldarg.0
IL_00ed: ldarg.0
IL_00ee: ldstr "Claire"
IL_00f3: ldarg.0
IL_00f4: call AreaContentSet TheForestOfLove.Content.PlainsEndSpawner::get_Critters()
IL_00f9: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00fe: call System.Void TheForestOfLove.Content.PlainsEndSpawner::set_Claire(AreaContent)
IL_0103: ldarg.0
IL_0104: ldarg.0
IL_0105: ldstr "Oliver"
IL_010a: ldarg.0
IL_010b: call AreaContentSet TheForestOfLove.Content.PlainsEndSpawner::get_Critters()
IL_0110: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0115: call System.Void TheForestOfLove.Content.PlainsEndSpawner::set_Oliver(AreaContent)
IL_011a: ldarg.0
IL_011b: ldarg.0
IL_011c: ldstr "Violet"
IL_0121: ldarg.0
IL_0122: call AreaContentSet TheForestOfLove.Content.PlainsEndSpawner::get_Critters()
IL_0127: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_012c: call System.Void TheForestOfLove.Content.PlainsEndSpawner::set_Violet(AreaContent)
IL_0131: ldarg.0
IL_0132: ldarg.0
IL_0133: ldarg.0
IL_0134: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsEndSpawner::melodyFlipbookPhotoFirst
IL_0139: callvirt System.String UnityEngine.Object::get_name()
IL_013e: ldarg.0
IL_013f: call AreaContentSet TheForestOfLove.Content.PlainsEndSpawner::get_Elements()
IL_0144: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0149: call System.Void TheForestOfLove.Content.PlainsEndSpawner::set_MelodyFlipbookPhotoFirst(AreaContent)
IL_014e: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_0153: brfalse.s IL_015c
IL_0155: ldarg.0
IL_0156: call System.Void TheForestOfLove.Content.PlainsEndSpawner::SpawnInstancedStoryStuff()
IL_015b: ret
IL_015c: ldarg.0
IL_015d: call System.Void TheForestOfLove.Content.PlainsEndSpawner::RefreshFastTravelPerch_Internal()
IL_0162: ldstr "CoyoteQuest_MeetTheCoyotes"
IL_0167: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_016c: brtrue.s IL_017a
IL_016e: ldarg.0
IL_016f: ldfld TheForestOfLove.CoyotesIntroductionCutscene TheForestOfLove.Content.PlainsEndSpawner::coyotesIntroCutscene
IL_0174: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.CoyotesIntroductionCutscene>(!!0)
IL_0179: pop
IL_017a: ldstr "rang_plains_fast_travel_bell"
IL_017f: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0184: brfalse.s IL_0191
IL_0186: ldarg.0
IL_0187: call AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_Act2FastTravelExitBlocker()
IL_018c: callvirt System.Void AreaContent::Disable()
IL_0191: ldstr "act2_capstone_kickoff"
IL_0196: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_019b: brfalse.s IL_01af
IL_019d: ldstr "Act2Capstone_PennyIntroduction"
IL_01a2: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_01a7: brtrue.s IL_01af
IL_01a9: ldarg.0
IL_01aa: call System.Void TheForestOfLove.Content.PlainsEndSpawner::SpawnAct2CapstoneKickoffInteracts_Internal()
IL_01af: ldstr "receive_sweater"
IL_01b4: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_01b9: brfalse.s IL_01cd
IL_01bb: ldstr "model_sweater"
IL_01c0: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_01c5: brtrue.s IL_01cd
IL_01c7: ldarg.0
IL_01c8: call System.Void TheForestOfLove.Content.PlainsEndSpawner::SpawnSweaterInteracts_Internal()
IL_01cd: ldarg.0
IL_01ce: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsEndSpawner::melodyFlipbookPhotoFirst
IL_01d3: call System.Boolean TheForestOfLove.Content.BaseSpawner::CanSpawnMelodyFlipbookPhotoPickup(UnityEngine.GameObject)
IL_01d8: brfalse.s IL_0223
IL_01da: ldarg.0
IL_01db: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsEndSpawner::melodyFlipbookPhotoFirst
IL_01e0: ldarg.0
IL_01e1: call AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_MelodyFlipbookPhotoFirst()
IL_01e6: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_01eb: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_01f0: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_01f5: ldarg.0
IL_01f6: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsEndSpawner::melodyFlipbookPhotoFirstSpawnLocation
IL_01fb: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0200: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0205: ldc.r4 1
IL_020a: ldc.r4 1
IL_020f: ldc.r4 0
IL_0214: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_0219: call UnityEngine.Vector3 UnityEngine.Vector3::Scale(UnityEngine.Vector3,UnityEngine.Vector3)
IL_021e: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_0223: ldarg.0
IL_0224: call System.Void TheForestOfLove.Content.PlainsEndSpawner::SpawnDefaultCritters()
IL_0229: ret
METHOD System.Void TheForestOfLove.Content.PlainsEndSpawner::SpawnInstancedStoryStuff() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TheForestOfLove.Content.PlainsEndSpawner::RefreshFastTravelPerch_Internal()
IL_0006: ldarg.0
IL_0007: call AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_Act2FastTravelExitBlocker()
IL_000c: callvirt System.Void AreaContent::Disable()
IL_0011: call System.Boolean TheForestOfLove.SpawnManager::get_donkeyFastTravel()
IL_0016: brfalse.s IL_0057
IL_0018: ldarg.0
IL_0019: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsEndSpawner::npcOliver
IL_001e: ldarg.0
IL_001f: call AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_Oliver()
IL_0024: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0029: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_002e: pop
IL_002f: ldc.i4.0
IL_0030: call System.Void TheForestOfLove.SpawnManager::set_donkeyFastTravel(System.Boolean)
IL_0035: call System.Boolean TheForestOfLove.QuestTriggerHelper::FinishedTheBigStorm()
IL_003a: brtrue.s IL_0043
IL_003c: ldstr "Idles_Act2_Oliver"
IL_0041: br.s IL_0048
IL_0043: ldstr "Idles_Act3_Oliver"
IL_0048: stloc.0
IL_0049: ldarg.0
IL_004a: call AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_Oliver()
IL_004f: ldloc.0
IL_0050: ldnull
IL_0051: ldnull
IL_0052: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::SetTargetDialogueInChildren(AreaContent,System.String,System.String,System.String)
IL_0057: ldarg.0
IL_0058: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsEndSpawner::npcClaire
IL_005d: ldarg.0
IL_005e: call AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_Claire()
IL_0063: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0068: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_006d: pop
IL_006e: ldarg.0
IL_006f: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsEndSpawner::npcViolet
IL_0074: ldarg.0
IL_0075: call AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_Violet()
IL_007a: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_007f: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0084: pop
IL_0085: ret
METHOD System.Void TheForestOfLove.Content.PlainsEndSpawner::SpawnClaire() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "Claire"
IL_0005: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorSpawnedOrOnDate(System.String)
IL_000a: brfalse.s IL_000d
IL_000c: ret
IL_000d: ldarg.0
IL_000e: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsEndSpawner::npcClaire
IL_0013: ldarg.0
IL_0014: call AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_Claire()
IL_0019: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_001e: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0023: pop
IL_0024: ret
METHOD System.Void TheForestOfLove.Content.PlainsEndSpawner::SpawnOliver() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "Oliver"
IL_0005: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorSpawnedOrOnDate(System.String)
IL_000a: brfalse.s IL_000d
IL_000c: ret
IL_000d: call System.Boolean TheForestOfLove.SpawnManager::get_donkeyFastTravel()
IL_0012: brtrue.s IL_0021
IL_0014: ldstr "CoyoteQuest_RingFastTravelBell"
IL_0019: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_001e: brfalse.s IL_0021
IL_0020: ret
IL_0021: ldarg.0
IL_0022: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsEndSpawner::npcOliver
IL_0027: ldarg.0
IL_0028: call AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_Oliver()
IL_002d: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0032: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0037: pop
IL_0038: call System.Boolean TheForestOfLove.SpawnManager::get_donkeyFastTravel()
IL_003d: brfalse.s IL_00be
IL_003f: ldc.i4.0
IL_0040: call System.Void TheForestOfLove.SpawnManager::set_donkeyFastTravel(System.Boolean)
IL_0045: ldstr "learn_about_the_sweater"
IL_004a: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_004f: brtrue.s IL_0068
IL_0051: ldarg.0
IL_0052: call AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_Oliver()
IL_0057: ldstr "Idles_Act1_Donkey"
IL_005c: ldstr "non_travel_idle"
IL_0061: ldnull
IL_0062: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::SetTargetDialogueInChildren(AreaContent,System.String,System.String,System.String)
IL_0067: ret
IL_0068: ldstr "get_plains_fast_travel_bell"
IL_006d: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0072: brfalse IL_00f8
IL_0077: call System.Boolean TheForestOfLove.QuestTriggerHelper::FinishedTheBigStorm()
IL_007c: brfalse.s IL_0091
IL_007e: ldarg.0
IL_007f: call AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_Oliver()
IL_0084: ldstr "Idles_Act3_Oliver"
IL_0089: ldnull
IL_008a: ldnull
IL_008b: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::SetTargetDialogueInChildren(AreaContent,System.String,System.String,System.String)
IL_0090: ret
IL_0091: call System.Boolean TheForestOfLove.QuestTriggerHelper::FinishedAct2()
IL_0096: brfalse.s IL_00ab
IL_0098: ldarg.0
IL_0099: call AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_Oliver()
IL_009e: ldstr "Idles_Act2_Oliver"
IL_00a3: ldnull
IL_00a4: ldnull
IL_00a5: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::SetTargetDialogueInChildren(AreaContent,System.String,System.String,System.String)
IL_00aa: ret
IL_00ab: ldarg.0
IL_00ac: call AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_Oliver()
IL_00b1: ldstr "Idles_Act1_Donkey"
IL_00b6: ldnull
IL_00b7: ldnull
IL_00b8: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::SetTargetDialogueInChildren(AreaContent,System.String,System.String,System.String)
IL_00bd: ret
IL_00be: ldstr "learn_about_the_sweater"
IL_00c3: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_00c8: brtrue.s IL_00f8
IL_00ca: ldstr "CoyoteQuest_MeetTheCoyotes"
IL_00cf: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_00d4: brfalse.s IL_00e2
IL_00d6: ldarg.0
IL_00d7: call AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_Oliver()
IL_00dc: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::DisableInteractionInChildren(AreaContent)
IL_00e1: ret
IL_00e2: ldarg.0
IL_00e3: call AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_Oliver()
IL_00e8: ldstr "Idles_Act1_Donkey"
IL_00ed: ldstr "non_travel_idle"
IL_00f2: ldnull
IL_00f3: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::SetTargetDialogueInChildren(AreaContent,System.String,System.String,System.String)
IL_00f8: ret
METHOD System.Void TheForestOfLove.Content.PlainsEndSpawner::SpawnViolet() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "Violet"
IL_0005: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorSpawnedOrOnDate(System.String)
IL_000a: brfalse.s IL_000d
IL_000c: ret
IL_000d: ldarg.0
IL_000e: ldfld UnityEngine.GameObject TheForestOfLove.Content.PlainsEndSpawner::npcViolet
IL_0013: ldarg.0
IL_0014: call AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_Violet()
IL_0019: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_001e: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0023: pop
IL_0024: ret
METHOD System.Void TheForestOfLove.Content.PlainsEndSpawner::EnableOliverInteractions() | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldsfld TheForestOfLove.Content.PlainsEndSpawner TheForestOfLove.Content.PlainsEndSpawner::instance
IL_0005: ldnull
IL_0006: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000b: brfalse.s IL_0032
IL_000d: ldsfld TheForestOfLove.Content.PlainsEndSpawner TheForestOfLove.Content.PlainsEndSpawner::instance
IL_0012: callvirt AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_Oliver()
IL_0017: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::EnableInteractionInChildren(AreaContent)
IL_001c: ldsfld TheForestOfLove.Content.PlainsEndSpawner TheForestOfLove.Content.PlainsEndSpawner::instance
IL_0021: callvirt AreaContent TheForestOfLove.Content.PlainsEndSpawner::get_Oliver()
IL_0026: ldstr "CoyoteQuest_GetFastTravelBellFromDonkey"
IL_002b: ldnull
IL_002c: ldnull
IL_002d: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::SetTargetDialogueInChildren(AreaContent,System.String,System.String,System.String)
IL_0032: ret
