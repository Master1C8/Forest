TYPE TheForestOfLove.Content.LakeSpawner
METHOD System.Void TheForestOfLove.Content.LakeSpawner::SpawnObjects() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldstr "Environment"
IL_0007: ldnull
IL_0008: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_000d: call System.Void TheForestOfLove.Content.LakeSpawner::set_Environment(AreaContentSet)
IL_0012: ldarg.0
IL_0013: ldarg.0
IL_0014: ldstr "Elements"
IL_0019: ldnull
IL_001a: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_001f: call System.Void TheForestOfLove.Content.LakeSpawner::set_Elements(AreaContentSet)
IL_0024: ldarg.0
IL_0025: ldarg.0
IL_0026: ldstr "Critters"
IL_002b: ldnull
IL_002c: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_0031: call System.Void TheForestOfLove.Content.LakeSpawner::set_Critters(AreaContentSet)
IL_0036: ldarg.0
IL_0037: ldarg.0
IL_0038: ldarg.0
IL_0039: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::player
IL_003e: callvirt System.String UnityEngine.Object::get_name()
IL_0043: ldarg.0
IL_0044: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::player
IL_0049: ldnull
IL_004a: ldc.i4.0
IL_004b: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContentOrFind(System.String,UnityEngine.GameObject,UnityEngine.Transform,System.Boolean)
IL_0050: call System.Void TheForestOfLove.Content.LakeSpawner::set_Player(AreaContent)
IL_0055: ldarg.0
IL_0056: ldarg.0
IL_0057: ldarg.0
IL_0058: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::environmentBase
IL_005d: callvirt System.String UnityEngine.Object::get_name()
IL_0062: ldarg.0
IL_0063: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::environmentBase
IL_0068: ldarg.0
IL_0069: call AreaContentSet TheForestOfLove.Content.LakeSpawner::get_Environment()
IL_006e: ldc.i4.0
IL_006f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContentOrFind(System.String,UnityEngine.GameObject,AreaContentSet,System.Boolean)
IL_0074: call System.Void TheForestOfLove.Content.LakeSpawner::set_EnvironmentBase(AreaContent)
IL_0079: ldarg.0
IL_007a: ldarg.0
IL_007b: ldarg.0
IL_007c: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::elementsBase
IL_0081: callvirt System.String UnityEngine.Object::get_name()
IL_0086: ldarg.0
IL_0087: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::elementsBase
IL_008c: ldarg.0
IL_008d: call AreaContentSet TheForestOfLove.Content.LakeSpawner::get_Elements()
IL_0092: ldc.i4.0
IL_0093: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContentOrFind(System.String,UnityEngine.GameObject,AreaContentSet,System.Boolean)
IL_0098: call System.Void TheForestOfLove.Content.LakeSpawner::set_ElementsBase(AreaContent)
IL_009d: ldarg.0
IL_009e: ldarg.0
IL_009f: ldarg.0
IL_00a0: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::doorwayToCentralForest
IL_00a5: callvirt System.String UnityEngine.Object::get_name()
IL_00aa: ldarg.0
IL_00ab: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::doorwayToCentralForest
IL_00b0: ldarg.0
IL_00b1: call AreaContentSet TheForestOfLove.Content.LakeSpawner::get_Elements()
IL_00b6: ldc.i4.1
IL_00b7: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContentOrFind(System.String,UnityEngine.GameObject,AreaContentSet,System.Boolean)
IL_00bc: call System.Void TheForestOfLove.Content.LakeSpawner::set_DoorwayToCentralForest(AreaContent)
IL_00c1: ldarg.0
IL_00c2: ldarg.0
IL_00c3: ldarg.0
IL_00c4: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::doorwayToCentralForestCameraTrigger
IL_00c9: callvirt System.String UnityEngine.Object::get_name()
IL_00ce: ldarg.0
IL_00cf: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::doorwayToCentralForestCameraTrigger
IL_00d4: ldarg.0
IL_00d5: call AreaContentSet TheForestOfLove.Content.LakeSpawner::get_Elements()
IL_00da: ldc.i4.1
IL_00db: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContentOrFind(System.String,UnityEngine.GameObject,AreaContentSet,System.Boolean)
IL_00e0: call System.Void TheForestOfLove.Content.LakeSpawner::set_DoorwayToCentralForestCameraTrigger(AreaContent)
IL_00e5: ldarg.0
IL_00e6: ldfld TheForestOfLove.FastTravelCutscene TheForestOfLove.Content.LakeSpawner::fastTravelCutscene
IL_00eb: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.FastTravelCutscene>(!!0)
IL_00f0: pop
IL_00f1: ldarg.0
IL_00f2: ldnull
IL_00f3: call System.Void TheForestOfLove.Content.LakeSpawner::set_FastTravelPerch(AreaContent)
IL_00f8: ldarg.0
IL_00f9: ldarg.0
IL_00fa: ldarg.0
IL_00fb: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::fastTravelPerchNoBell
IL_0100: ldarg.0
IL_0101: call AreaContentSet TheForestOfLove.Content.LakeSpawner::get_Elements()
IL_0106: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_010b: call System.Void TheForestOfLove.Content.LakeSpawner::set_FastTravelPerchNoBell(AreaContent)
IL_0110: ldarg.0
IL_0111: ldarg.0
IL_0112: ldarg.0
IL_0113: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::fastTravelPerchWithBell
IL_0118: ldarg.0
IL_0119: call AreaContentSet TheForestOfLove.Content.LakeSpawner::get_Elements()
IL_011e: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0123: call System.Void TheForestOfLove.Content.LakeSpawner::set_FastTravelPerchWithBell(AreaContent)
IL_0128: ldarg.0
IL_0129: ldarg.0
IL_012a: ldarg.0
IL_012b: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::fastTravelPerchPennyBusyElsewhere
IL_0130: ldarg.0
IL_0131: call AreaContentSet TheForestOfLove.Content.LakeSpawner::get_Elements()
IL_0136: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_013b: call System.Void TheForestOfLove.Content.LakeSpawner::set_FastTravelPerchPennyBusyElsewhere(AreaContent)
IL_0140: ldarg.0
IL_0141: ldarg.0
IL_0142: ldarg.0
IL_0143: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::glyphStones
IL_0148: callvirt System.String UnityEngine.Object::get_name()
IL_014d: ldarg.0
IL_014e: call AreaContentSet TheForestOfLove.Content.LakeSpawner::get_Elements()
IL_0153: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0158: call System.Void TheForestOfLove.Content.LakeSpawner::set_GlyphStones(AreaContent)
IL_015d: ldarg.0
IL_015e: ldarg.0
IL_015f: ldarg.0
IL_0160: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::bridgeQuestGatorWoodStackStatic
IL_0165: callvirt System.String UnityEngine.Object::get_name()
IL_016a: ldarg.0
IL_016b: call AreaContentSet TheForestOfLove.Content.LakeSpawner::get_Elements()
IL_0170: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0175: call System.Void TheForestOfLove.Content.LakeSpawner::set_GatorWoodStackStatic(AreaContent)
IL_017a: ldarg.0
IL_017b: ldarg.0
IL_017c: ldarg.0
IL_017d: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::bridgeQuestGatorWoodStackCollectible
IL_0182: callvirt System.String UnityEngine.Object::get_name()
IL_0187: ldarg.0
IL_0188: call AreaContentSet TheForestOfLove.Content.LakeSpawner::get_Elements()
IL_018d: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0192: call System.Void TheForestOfLove.Content.LakeSpawner::set_GatorWoodStackCollectible(AreaContent)
IL_0197: ldarg.0
IL_0198: ldarg.0
IL_0199: ldstr "Augustus"
IL_019e: ldarg.0
IL_019f: call AreaContentSet TheForestOfLove.Content.LakeSpawner::get_Critters()
IL_01a4: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_01a9: call System.Void TheForestOfLove.Content.LakeSpawner::set_Augustus(AreaContent)
IL_01ae: ldarg.0
IL_01af: ldarg.0
IL_01b0: ldstr "Dustin"
IL_01b5: ldarg.0
IL_01b6: call AreaContentSet TheForestOfLove.Content.LakeSpawner::get_Critters()
IL_01bb: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_01c0: call System.Void TheForestOfLove.Content.LakeSpawner::set_Dustin(AreaContent)
IL_01c5: ldarg.0
IL_01c6: ldarg.0
IL_01c7: ldarg.0
IL_01c8: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::melodyFlipbookPhotoFirst
IL_01cd: callvirt System.String UnityEngine.Object::get_name()
IL_01d2: ldarg.0
IL_01d3: call AreaContentSet TheForestOfLove.Content.LakeSpawner::get_Elements()
IL_01d8: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_01dd: call System.Void TheForestOfLove.Content.LakeSpawner::set_MelodyFlipbookPhotoFirst(AreaContent)
IL_01e2: ldarg.0
IL_01e3: ldarg.0
IL_01e4: ldarg.0
IL_01e5: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::melodyFlipbookPhotoSecond
IL_01ea: callvirt System.String UnityEngine.Object::get_name()
IL_01ef: ldarg.0
IL_01f0: call AreaContentSet TheForestOfLove.Content.LakeSpawner::get_Elements()
IL_01f5: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_01fa: call System.Void TheForestOfLove.Content.LakeSpawner::set_MelodyFlipbookPhotoSecond(AreaContent)
IL_01ff: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_0204: brfalse.s IL_020d
IL_0206: ldarg.0
IL_0207: call System.Void TheForestOfLove.Content.LakeSpawner::SpawnInstancedStoryStuff()
IL_020c: ret
IL_020d: ldarg.0
IL_020e: call System.Void TheForestOfLove.Content.LakeSpawner::RefreshFastTravelPerch_Internal()
IL_0213: ldc.i4 180
IL_0218: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_021d: brtrue.s IL_022b
IL_021f: ldarg.0
IL_0220: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::bridgeQuestLakeBellPickup
IL_0225: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_022a: pop
IL_022b: ldstr "BridgeQuest_ReturnToGator"
IL_0230: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0235: brtrue.s IL_027b
IL_0237: ldarg.0
IL_0238: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::bridgeQuestGatorWoodStackStatic
IL_023d: ldarg.0
IL_023e: call AreaContent TheForestOfLove.Content.LakeSpawner::get_GatorWoodStackStatic()
IL_0243: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0248: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_024d: pop
IL_024e: ldc.i4.s 50
IL_0250: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_0255: brfalse.s IL_029e
IL_0257: ldarg.0
IL_0258: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::bridgeQuestGatorWoodStackCollectible
IL_025d: ldarg.0
IL_025e: call AreaContent TheForestOfLove.Content.LakeSpawner::get_GatorWoodStackCollectible()
IL_0263: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0268: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_026d: pop
IL_026e: ldarg.0
IL_026f: call AreaContent TheForestOfLove.Content.LakeSpawner::get_GatorWoodStackCollectible()
IL_0274: callvirt System.Void AreaContent::Disable()
IL_0279: br.s IL_029e
IL_027b: ldstr "ITEMPOWERUP_act1/gatorWoodStack"
IL_0280: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0285: brtrue.s IL_029e
IL_0287: ldarg.0
IL_0288: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::bridgeQuestGatorWoodStackCollectible
IL_028d: ldarg.0
IL_028e: call AreaContent TheForestOfLove.Content.LakeSpawner::get_GatorWoodStackCollectible()
IL_0293: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0298: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_029d: pop
IL_029e: ldstr "deliver_dildo"
IL_02a3: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_02a8: brfalse.s IL_02b8
IL_02aa: ldarg.0
IL_02ab: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::lakeSwimTriggers
IL_02b0: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_02b5: pop
IL_02b6: br.s IL_02ec
IL_02b8: ldstr "BridgeQuest_MeetGator"
IL_02bd: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_02c2: brtrue.s IL_02e0
IL_02c4: ldstr "Act1_BridgeQuest"
IL_02c9: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.QuestTriggerHelper::LoadQuestStatus(System.String)
IL_02ce: ldc.i4.s 100
IL_02d0: bne.un.s IL_02e0
IL_02d2: ldarg.0
IL_02d3: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::bridgeQuestGatorIntroductionObjects
IL_02d8: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_02dd: pop
IL_02de: br.s IL_02ec
IL_02e0: ldarg.0
IL_02e1: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::bridgeQuestWaitingForSwimFloaties
IL_02e6: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_02eb: pop
IL_02ec: ldstr "DashQuest_RaceTheSquirrel"
IL_02f1: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_02f6: brtrue.s IL_0304
IL_02f8: ldarg.0
IL_02f9: ldfld TheForestOfLove.DashQuestController TheForestOfLove.Content.LakeSpawner::dashQuestController
IL_02fe: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.DashQuestController>(!!0)
IL_0303: pop
IL_0304: ldstr "collected_enough_wood"
IL_0309: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerFired(System.String)
IL_030e: brtrue.s IL_031c
IL_0310: ldarg.0
IL_0311: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::bridgeQuestWoodPowerups
IL_0316: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_031b: pop
IL_031c: ldstr "Cutscene_FishFirstEncounter"
IL_0321: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_0326: brtrue.s IL_0340
IL_0328: ldstr "DeliveryQuest_OttershopIntro"
IL_032d: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0332: brfalse.s IL_0340
IL_0334: ldarg.0
IL_0335: ldfld TheForestOfLove.FishFirstMeetingCutscene TheForestOfLove.Content.LakeSpawner::fishFirstMeetingCutscene
IL_033a: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.FishFirstMeetingCutscene>(!!0)
IL_033f: pop
IL_0340: ldstr "DeliveryQuest_ReturnToOtter2"
IL_0345: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_034a: brfalse.s IL_0364
IL_034c: ldstr "DeliveryQuest_DeliverShovel"
IL_0351: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0356: brtrue.s IL_0364
IL_0358: ldarg.0
IL_0359: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::shovelDeliveryNPCs
IL_035e: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0363: pop
IL_0364: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAct2CapstoneOngoing()
IL_0369: brfalse.s IL_0384
IL_036b: ldarg.0
IL_036c: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::glyphStonesGlowy
IL_0371: ldarg.0
IL_0372: call AreaContent TheForestOfLove.Content.LakeSpawner::get_GlyphStones()
IL_0377: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_037c: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0381: pop
IL_0382: br.s IL_039b
IL_0384: ldarg.0
IL_0385: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::glyphStones
IL_038a: ldarg.0
IL_038b: call AreaContent TheForestOfLove.Content.LakeSpawner::get_GlyphStones()
IL_0390: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0395: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_039a: pop
IL_039b: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAct2CapstoneOngoing()
IL_03a0: brtrue.s IL_03a9
IL_03a2: call System.Boolean TheForestOfLove.QuestTriggerHelper::FinishedAct2()
IL_03a7: brfalse.s IL_03b5
IL_03a9: ldarg.0
IL_03aa: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::gatorCaveInteraction
IL_03af: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_03b4: pop
IL_03b5: ldstr "rascal_solo_bear_story_enabled"
IL_03ba: call System.String TheForestOfLove.Services.Persistence.DataService::GetVariable(System.String)
IL_03bf: ldstr "true"
IL_03c4: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_03c9: brfalse.s IL_03f8
IL_03cb: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAct1CapstonePostbridgeOngoing()
IL_03d0: brtrue.s IL_03f8
IL_03d2: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAct2CapstoneOngoing()
IL_03d7: brtrue.s IL_03f8
IL_03d9: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_03de: brtrue.s IL_03f8
IL_03e0: ldarg.0
IL_03e1: ldarg.0
IL_03e2: ldarg.0
IL_03e3: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::lakeRascalSoloBearStoryInteract
IL_03e8: ldarg.0
IL_03e9: call AreaContentSet TheForestOfLove.Content.LakeSpawner::get_Elements()
IL_03ee: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_03f3: call System.Void TheForestOfLove.Content.LakeSpawner::set_RascalSoloBearStoryInteraction(AreaContent)
IL_03f8: ldstr "DeliveryQuest_FishEncounter"
IL_03fd: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0402: brfalse.s IL_0424
IL_0404: call System.Int32 TheForestOfLove.QuestTriggerHelper::GetCurrentAct()
IL_0409: ldc.i4.3
IL_040a: blt.s IL_0424
IL_040c: ldstr "Misc_Act3_FishEncounter2"
IL_0411: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0416: brtrue.s IL_0424
IL_0418: ldarg.0
IL_0419: ldfld TheForestOfLove.FishSecondMeetingCutscene TheForestOfLove.Content.LakeSpawner::fishSecondMeetingCutscene
IL_041e: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.FishSecondMeetingCutscene>(!!0)
IL_0423: pop
IL_0424: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3LightQuestGatheringFireflies()
IL_0429: brfalse.s IL_043e
IL_042b: ldarg.0
IL_042c: ldarg.0
IL_042d: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::act3AfterStormFireflies
IL_0432: ldarg.0
IL_0433: call AreaContentSet TheForestOfLove.Content.LakeSpawner::get_Elements()
IL_0438: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_043d: pop
IL_043e: ldarg.0
IL_043f: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::melodyFlipbookPhotoFirst
IL_0444: call System.Boolean TheForestOfLove.Content.BaseSpawner::CanSpawnMelodyFlipbookPhotoPickup(UnityEngine.GameObject)
IL_0449: brfalse.s IL_0494
IL_044b: ldarg.0
IL_044c: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::melodyFlipbookPhotoFirst
IL_0451: ldarg.0
IL_0452: call AreaContent TheForestOfLove.Content.LakeSpawner::get_MelodyFlipbookPhotoFirst()
IL_0457: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_045c: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0461: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0466: ldarg.0
IL_0467: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::melodyFlipbookPhotoFirstSpawnLocation
IL_046c: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0471: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_0476: ldc.r4 1
IL_047b: ldc.r4 1
IL_0480: ldc.r4 0
IL_0485: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_048a: call UnityEngine.Vector3 UnityEngine.Vector3::Scale(UnityEngine.Vector3,UnityEngine.Vector3)
IL_048f: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_0494: ldarg.0
IL_0495: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::melodyFlipbookPhotoSecond
IL_049a: call System.Boolean TheForestOfLove.Content.BaseSpawner::CanSpawnMelodyFlipbookPhotoPickup(UnityEngine.GameObject)
IL_049f: brfalse.s IL_04ea
IL_04a1: ldarg.0
IL_04a2: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::melodyFlipbookPhotoSecond
IL_04a7: ldarg.0
IL_04a8: call AreaContent TheForestOfLove.Content.LakeSpawner::get_MelodyFlipbookPhotoSecond()
IL_04ad: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_04b2: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_04b7: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_04bc: ldarg.0
IL_04bd: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::melodyFlipbookPhotoSecondSpawnLocation
IL_04c2: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_04c7: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_04cc: ldc.r4 1
IL_04d1: ldc.r4 1
IL_04d6: ldc.r4 0
IL_04db: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_04e0: call UnityEngine.Vector3 UnityEngine.Vector3::Scale(UnityEngine.Vector3,UnityEngine.Vector3)
IL_04e5: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_04ea: ldarg.0
IL_04eb: call System.Void TheForestOfLove.Content.LakeSpawner::SpawnDefaultCritters()
IL_04f0: ret
METHOD System.Void TheForestOfLove.Content.LakeSpawner::SpawnAugustus() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "Augustus"
IL_0005: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorSpawnedOrOnDate(System.String)
IL_000a: brfalse.s IL_000d
IL_000c: ret
IL_000d: ldstr "BridgeQuest_MeetGator"
IL_0012: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0017: brtrue.s IL_001a
IL_0019: ret
IL_001a: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAct2CapstoneOngoing()
IL_001f: brtrue.s IL_0028
IL_0021: call System.Boolean TheForestOfLove.QuestTriggerHelper::FinishedAct2()
IL_0026: brfalse.s IL_0029
IL_0028: ret
IL_0029: ldarg.0
IL_002a: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::npcAugustus
IL_002f: ldarg.0
IL_0030: call AreaContent TheForestOfLove.Content.LakeSpawner::get_Augustus()
IL_0035: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_003a: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_003f: pop
IL_0040: ret
METHOD System.Void TheForestOfLove.Content.LakeSpawner::SpawnDustin() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "Dustin"
IL_0005: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorSpawnedOrOnDate(System.String)
IL_000a: brfalse.s IL_000d
IL_000c: ret
IL_000d: ldstr "DashQuest_RaceTheSquirrel"
IL_0012: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0017: brtrue.s IL_001a
IL_0019: ret
IL_001a: ldstr "DeliveryQuest_ReturnToOtter2"
IL_001f: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0024: brfalse.s IL_0027
IL_0026: ret
IL_0027: ldarg.0
IL_0028: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeSpawner::npcDustinAct1
IL_002d: ldarg.0
IL_002e: call AreaContent TheForestOfLove.Content.LakeSpawner::get_Dustin()
IL_0033: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0038: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_003d: pop
IL_003e: ret
