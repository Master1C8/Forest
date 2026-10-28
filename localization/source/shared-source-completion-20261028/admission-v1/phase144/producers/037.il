TYPE TheForestOfLove.Content.DeepWoodsLongPathSpawner
METHOD System.Void TheForestOfLove.Content.DeepWoodsLongPathSpawner::SpawnObjects() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldstr "Environment"
IL_0007: ldnull
IL_0008: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_000d: call System.Void TheForestOfLove.Content.DeepWoodsLongPathSpawner::set_Environment(AreaContentSet)
IL_0012: ldarg.0
IL_0013: ldarg.0
IL_0014: ldstr "Elements"
IL_0019: ldnull
IL_001a: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_001f: call System.Void TheForestOfLove.Content.DeepWoodsLongPathSpawner::set_Elements(AreaContentSet)
IL_0024: ldarg.0
IL_0025: ldarg.0
IL_0026: ldstr "Critters"
IL_002b: ldnull
IL_002c: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_0031: call System.Void TheForestOfLove.Content.DeepWoodsLongPathSpawner::set_Critters(AreaContentSet)
IL_0036: ldarg.0
IL_0037: ldarg.0
IL_0038: ldarg.0
IL_0039: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsLongPathSpawner::player
IL_003e: ldnull
IL_003f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,UnityEngine.Transform)
IL_0044: call System.Void TheForestOfLove.Content.DeepWoodsLongPathSpawner::set_Player(AreaContent)
IL_0049: ldarg.0
IL_004a: ldarg.0
IL_004b: ldarg.0
IL_004c: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsLongPathSpawner::environmentBase
IL_0051: callvirt System.String UnityEngine.Object::get_name()
IL_0056: ldarg.0
IL_0057: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsLongPathSpawner::environmentBase
IL_005c: ldarg.0
IL_005d: call AreaContentSet TheForestOfLove.Content.DeepWoodsLongPathSpawner::get_Environment()
IL_0062: ldc.i4.0
IL_0063: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContentOrFind(System.String,UnityEngine.GameObject,AreaContentSet,System.Boolean)
IL_0068: call System.Void TheForestOfLove.Content.DeepWoodsLongPathSpawner::set_EnvironmentBase(AreaContent)
IL_006d: ldarg.0
IL_006e: ldarg.0
IL_006f: ldarg.0
IL_0070: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsLongPathSpawner::elementsBase
IL_0075: callvirt System.String UnityEngine.Object::get_name()
IL_007a: ldarg.0
IL_007b: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsLongPathSpawner::elementsBase
IL_0080: ldarg.0
IL_0081: call AreaContentSet TheForestOfLove.Content.DeepWoodsLongPathSpawner::get_Elements()
IL_0086: ldc.i4.0
IL_0087: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContentOrFind(System.String,UnityEngine.GameObject,AreaContentSet,System.Boolean)
IL_008c: call System.Void TheForestOfLove.Content.DeepWoodsLongPathSpawner::set_ElementsBase(AreaContent)
IL_0091: ldarg.0
IL_0092: ldarg.0
IL_0093: ldarg.0
IL_0094: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsLongPathSpawner::plantInteraction
IL_0099: callvirt System.String UnityEngine.Object::get_name()
IL_009e: ldarg.0
IL_009f: call AreaContentSet TheForestOfLove.Content.DeepWoodsLongPathSpawner::get_Elements()
IL_00a4: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00a9: call System.Void TheForestOfLove.Content.DeepWoodsLongPathSpawner::set_PlantInteraction(AreaContent)
IL_00ae: ldarg.0
IL_00af: ldarg.0
IL_00b0: ldarg.0
IL_00b1: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsLongPathSpawner::glyphStones
IL_00b6: callvirt System.String UnityEngine.Object::get_name()
IL_00bb: ldarg.0
IL_00bc: call AreaContentSet TheForestOfLove.Content.DeepWoodsLongPathSpawner::get_Elements()
IL_00c1: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00c6: call System.Void TheForestOfLove.Content.DeepWoodsLongPathSpawner::set_GlyphStones(AreaContent)
IL_00cb: ldarg.0
IL_00cc: ldarg.0
IL_00cd: ldstr "Scarlett"
IL_00d2: ldarg.0
IL_00d3: call AreaContentSet TheForestOfLove.Content.DeepWoodsLongPathSpawner::get_Critters()
IL_00d8: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00dd: call System.Void TheForestOfLove.Content.DeepWoodsLongPathSpawner::set_Scarlett(AreaContent)
IL_00e2: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAct2CapstoneOngoing()
IL_00e7: brfalse.s IL_0102
IL_00e9: ldarg.0
IL_00ea: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsLongPathSpawner::glyphStonesGlowy
IL_00ef: ldarg.0
IL_00f0: call AreaContent TheForestOfLove.Content.DeepWoodsLongPathSpawner::get_GlyphStones()
IL_00f5: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_00fa: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_00ff: pop
IL_0100: br.s IL_0119
IL_0102: ldarg.0
IL_0103: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsLongPathSpawner::glyphStones
IL_0108: ldarg.0
IL_0109: call AreaContent TheForestOfLove.Content.DeepWoodsLongPathSpawner::get_GlyphStones()
IL_010e: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0113: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0118: pop
IL_0119: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_011e: brfalse.s IL_0121
IL_0120: ret
IL_0121: ldstr "Act1_PlantQuest"
IL_0126: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsQuestCompleted(System.String)
IL_012b: brfalse.s IL_0169
IL_012d: ldstr "Gossip_Bunny_Plant"
IL_0132: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0137: brfalse.s IL_0169
IL_0139: ldarg.0
IL_013a: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsLongPathSpawner::npcPlantPenetrable
IL_013f: ldarg.0
IL_0140: call AreaContentSet TheForestOfLove.Content.DeepWoodsLongPathSpawner::get_Elements()
IL_0145: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_014a: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_014f: pop
IL_0150: ldarg.0
IL_0151: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsLongPathSpawner::rascalPlantSubStoryPluckTheLeafCutscene
IL_0156: ldarg.0
IL_0157: call AreaContent TheForestOfLove.Content.DeepWoodsLongPathSpawner::get_PlantInteraction()
IL_015c: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0161: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0166: pop
IL_0167: br.s IL_0197
IL_0169: ldarg.0
IL_016a: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsLongPathSpawner::npcPlant
IL_016f: ldarg.0
IL_0170: call AreaContentSet TheForestOfLove.Content.DeepWoodsLongPathSpawner::get_Elements()
IL_0175: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_017a: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_017f: pop
IL_0180: ldarg.0
IL_0181: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsLongPathSpawner::plantInteraction
IL_0186: ldarg.0
IL_0187: call AreaContent TheForestOfLove.Content.DeepWoodsLongPathSpawner::get_PlantInteraction()
IL_018c: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0191: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0196: pop
IL_0197: call System.Boolean TheForestOfLove.PlantQuestMinigameControllerRedux::get_minigameActive()
IL_019c: brfalse.s IL_01b2
IL_019e: ldarg.0
IL_019f: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsLongPathSpawner::plantQuestMinigameController
IL_01a4: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_01a9: pop
IL_01aa: ldarg.0
IL_01ab: call System.Void TheForestOfLove.Content.DeepWoodsLongPathSpawner::SetupSceneForPlantMinigame()
IL_01b0: br.s IL_01d6
IL_01b2: ldstr "PlantQuest_IntroFromBunny"
IL_01b7: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_01bc: brfalse.s IL_01d6
IL_01be: ldstr "PlantQuest_FinishSeedExtraction"
IL_01c3: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_01c8: brtrue.s IL_01d6
IL_01ca: ldarg.0
IL_01cb: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsLongPathSpawner::plantQuestMinigameController
IL_01d0: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_01d5: pop
IL_01d6: call System.Boolean TheForestOfLove.QuestTriggerHelper::CanSpawnScarlettHop()
IL_01db: brfalse.s IL_021e
IL_01dd: ldarg.0
IL_01de: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsLongPathSpawner::npcScarlettHop
IL_01e3: ldarg.0
IL_01e4: call AreaContent TheForestOfLove.Content.DeepWoodsLongPathSpawner::get_Scarlett()
IL_01e9: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_01ee: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_01f3: pop
IL_01f4: ldarg.0
IL_01f5: ldarg.0
IL_01f6: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsLongPathSpawner::scarlettHopHints
IL_01fb: ldarg.0
IL_01fc: call AreaContentSet TheForestOfLove.Content.DeepWoodsLongPathSpawner::get_Elements()
IL_0201: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0206: pop
IL_0207: ldarg.0
IL_0208: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsLongPathSpawner::act3WolfQuestScarlettPlantCutscene
IL_020d: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0212: pop
IL_0213: ldarg.0
IL_0214: call AreaContent TheForestOfLove.Content.DeepWoodsLongPathSpawner::get_PlantInteraction()
IL_0219: callvirt System.Void AreaContent::Disable()
IL_021e: ret
