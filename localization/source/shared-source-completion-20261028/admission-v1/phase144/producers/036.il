TYPE TheForestOfLove.Content.DeepWoodsFirstForkSpawner
METHOD System.Void TheForestOfLove.Content.DeepWoodsFirstForkSpawner::SpawnObjects() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldstr "Environment"
IL_0007: ldnull
IL_0008: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_000d: call System.Void TheForestOfLove.Content.DeepWoodsFirstForkSpawner::set_Environment(AreaContentSet)
IL_0012: ldarg.0
IL_0013: ldarg.0
IL_0014: ldstr "Elements"
IL_0019: ldnull
IL_001a: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_001f: call System.Void TheForestOfLove.Content.DeepWoodsFirstForkSpawner::set_Elements(AreaContentSet)
IL_0024: ldarg.0
IL_0025: ldarg.0
IL_0026: ldstr "Critters"
IL_002b: ldnull
IL_002c: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_0031: call System.Void TheForestOfLove.Content.DeepWoodsFirstForkSpawner::set_Critters(AreaContentSet)
IL_0036: ldarg.0
IL_0037: ldarg.0
IL_0038: ldarg.0
IL_0039: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsFirstForkSpawner::player
IL_003e: ldnull
IL_003f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,UnityEngine.Transform)
IL_0044: call System.Void TheForestOfLove.Content.DeepWoodsFirstForkSpawner::set_Player(AreaContent)
IL_0049: ldarg.0
IL_004a: ldarg.0
IL_004b: ldarg.0
IL_004c: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsFirstForkSpawner::environmentBase
IL_0051: ldarg.0
IL_0052: call AreaContentSet TheForestOfLove.Content.DeepWoodsFirstForkSpawner::get_Environment()
IL_0057: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_005c: call System.Void TheForestOfLove.Content.DeepWoodsFirstForkSpawner::set_EnvironmentBase(AreaContent)
IL_0061: ldarg.0
IL_0062: ldarg.0
IL_0063: ldarg.0
IL_0064: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsFirstForkSpawner::elementsBase
IL_0069: ldarg.0
IL_006a: call AreaContentSet TheForestOfLove.Content.DeepWoodsFirstForkSpawner::get_Elements()
IL_006f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0074: call System.Void TheForestOfLove.Content.DeepWoodsFirstForkSpawner::set_ElementsBase(AreaContent)
IL_0079: ldarg.0
IL_007a: ldarg.0
IL_007b: ldarg.0
IL_007c: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsFirstForkSpawner::northSignInteraction
IL_0081: ldarg.0
IL_0082: call AreaContentSet TheForestOfLove.Content.DeepWoodsFirstForkSpawner::get_Elements()
IL_0087: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_008c: call System.Void TheForestOfLove.Content.DeepWoodsFirstForkSpawner::set_NorthSignInteraction(AreaContent)
IL_0091: ldarg.0
IL_0092: ldarg.0
IL_0093: ldarg.0
IL_0094: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsFirstForkSpawner::glyphStones
IL_0099: callvirt System.String UnityEngine.Object::get_name()
IL_009e: ldarg.0
IL_009f: call AreaContentSet TheForestOfLove.Content.DeepWoodsFirstForkSpawner::get_Elements()
IL_00a4: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00a9: call System.Void TheForestOfLove.Content.DeepWoodsFirstForkSpawner::set_GlyphStones(AreaContent)
IL_00ae: ldarg.0
IL_00af: ldarg.0
IL_00b0: ldstr "Scarlett"
IL_00b5: ldarg.0
IL_00b6: call AreaContentSet TheForestOfLove.Content.DeepWoodsFirstForkSpawner::get_Critters()
IL_00bb: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00c0: call System.Void TheForestOfLove.Content.DeepWoodsFirstForkSpawner::set_Scarlett(AreaContent)
IL_00c5: ldarg.0
IL_00c6: ldarg.0
IL_00c7: ldarg.0
IL_00c8: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsFirstForkSpawner::act3WolfQuestPathBlockers
IL_00cd: callvirt System.String UnityEngine.Object::get_name()
IL_00d2: ldarg.0
IL_00d3: call AreaContentSet TheForestOfLove.Content.DeepWoodsFirstForkSpawner::get_Elements()
IL_00d8: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00dd: call System.Void TheForestOfLove.Content.DeepWoodsFirstForkSpawner::set_Act3WolfQuestPathBlocker(AreaContent)
IL_00e2: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAct2CapstoneOngoing()
IL_00e7: brfalse.s IL_0102
IL_00e9: ldarg.0
IL_00ea: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsFirstForkSpawner::glyphStonesGlowy
IL_00ef: ldarg.0
IL_00f0: call AreaContent TheForestOfLove.Content.DeepWoodsFirstForkSpawner::get_GlyphStones()
IL_00f5: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_00fa: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_00ff: pop
IL_0100: br.s IL_0119
IL_0102: ldarg.0
IL_0103: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsFirstForkSpawner::glyphStones
IL_0108: ldarg.0
IL_0109: call AreaContent TheForestOfLove.Content.DeepWoodsFirstForkSpawner::get_GlyphStones()
IL_010e: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0113: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0118: pop
IL_0119: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_011e: brfalse.s IL_0127
IL_0120: ldarg.0
IL_0121: call System.Void TheForestOfLove.Content.DeepWoodsFirstForkSpawner::SpawnInstancedStoryStuff()
IL_0126: ret
IL_0127: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerHasFullAccessToDeepWoods()
IL_012c: brtrue.s IL_0147
IL_012e: call System.String TheForestOfLove.Services.SceneManagement.SceneHelper::get_LastSceneName()
IL_0133: ldstr "DeepWoods_Campfire"
IL_0138: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_013d: brfalse.s IL_014d
IL_013f: ldarg.0
IL_0140: call System.Void TheForestOfLove.Content.DeepWoodsFirstForkSpawner::SpawnDarknessStuff()
IL_0145: br.s IL_014d
IL_0147: ldarg.0
IL_0148: call System.Void TheForestOfLove.Content.DeepWoodsFirstForkSpawner::SpawnLanternStuff()
IL_014d: call System.Boolean TheForestOfLove.PlantQuestMinigameControllerRedux::get_minigameActive()
IL_0152: brfalse.s IL_0176
IL_0154: ldarg.0
IL_0155: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsFirstForkSpawner::plantQuestMinigameController
IL_015a: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_015f: pop
IL_0160: ldarg.0
IL_0161: call AreaContent TheForestOfLove.Content.DeepWoodsFirstForkSpawner::get_NorthSignInteraction()
IL_0166: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::DisableInteractionInChildren(AreaContent)
IL_016b: ldarg.0
IL_016c: call AreaContent TheForestOfLove.Content.DeepWoodsFirstForkSpawner::get_GlyphStones()
IL_0171: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::DisableInteractionInChildren(AreaContent)
IL_0176: ldstr "MouseQuest_MeetMabelsMom"
IL_017b: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0180: brfalse.s IL_019a
IL_0182: ldstr "act3_mousequest_leaving_the_campsite"
IL_0187: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_018c: brtrue.s IL_019a
IL_018e: ldarg.0
IL_018f: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsFirstForkSpawner::act3MouseQuestLeavingTheCampsiteCutscene
IL_0194: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0199: pop
IL_019a: call System.Boolean TheForestOfLove.QuestTriggerHelper::CanSpawnScarlettHop()
IL_019f: brfalse.s IL_01e7
IL_01a1: ldarg.0
IL_01a2: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsFirstForkSpawner::npcScarlettHop
IL_01a7: ldarg.0
IL_01a8: call AreaContent TheForestOfLove.Content.DeepWoodsFirstForkSpawner::get_Scarlett()
IL_01ad: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_01b2: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_01b7: pop
IL_01b8: ldarg.0
IL_01b9: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsFirstForkSpawner::act3WolfQuestScarlettHopAwayCutscene
IL_01be: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_01c3: pop
IL_01c4: ldarg.0
IL_01c5: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsFirstForkSpawner::act3WolfQuestScarlettSaysFarewellCutscene
IL_01ca: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_01cf: pop
IL_01d0: ldarg.0
IL_01d1: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsFirstForkSpawner::act3WolfQuestPathBlockers
IL_01d6: ldarg.0
IL_01d7: call AreaContent TheForestOfLove.Content.DeepWoodsFirstForkSpawner::get_Act3WolfQuestPathBlocker()
IL_01dc: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_01e1: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_01e6: pop
IL_01e7: ret
