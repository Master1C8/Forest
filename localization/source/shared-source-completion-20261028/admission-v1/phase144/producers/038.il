TYPE TheForestOfLove.Content.DeepWoodsSecondForkSpawner
METHOD System.Void TheForestOfLove.Content.DeepWoodsSecondForkSpawner::SpawnObjects() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldstr "Environment"
IL_0007: ldnull
IL_0008: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_000d: call System.Void TheForestOfLove.Content.DeepWoodsSecondForkSpawner::set_Environment(AreaContentSet)
IL_0012: ldarg.0
IL_0013: ldarg.0
IL_0014: ldstr "Elements"
IL_0019: ldnull
IL_001a: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_001f: call System.Void TheForestOfLove.Content.DeepWoodsSecondForkSpawner::set_Elements(AreaContentSet)
IL_0024: ldarg.0
IL_0025: ldarg.0
IL_0026: ldstr "Critters"
IL_002b: ldnull
IL_002c: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_0031: call System.Void TheForestOfLove.Content.DeepWoodsSecondForkSpawner::set_Critters(AreaContentSet)
IL_0036: ldarg.0
IL_0037: ldarg.0
IL_0038: ldarg.0
IL_0039: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsSecondForkSpawner::player
IL_003e: ldnull
IL_003f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,UnityEngine.Transform)
IL_0044: call System.Void TheForestOfLove.Content.DeepWoodsSecondForkSpawner::set_Player(AreaContent)
IL_0049: ldarg.0
IL_004a: ldarg.0
IL_004b: ldarg.0
IL_004c: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsSecondForkSpawner::environmentBase
IL_0051: ldarg.0
IL_0052: call AreaContentSet TheForestOfLove.Content.DeepWoodsSecondForkSpawner::get_Environment()
IL_0057: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_005c: call System.Void TheForestOfLove.Content.DeepWoodsSecondForkSpawner::set_EnvironmentBase(AreaContent)
IL_0061: ldarg.0
IL_0062: ldarg.0
IL_0063: ldarg.0
IL_0064: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsSecondForkSpawner::elementsBase
IL_0069: ldarg.0
IL_006a: call AreaContentSet TheForestOfLove.Content.DeepWoodsSecondForkSpawner::get_Elements()
IL_006f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0074: call System.Void TheForestOfLove.Content.DeepWoodsSecondForkSpawner::set_ElementsBase(AreaContent)
IL_0079: ldarg.0
IL_007a: ldarg.0
IL_007b: ldarg.0
IL_007c: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsSecondForkSpawner::glyphStones
IL_0081: callvirt System.String UnityEngine.Object::get_name()
IL_0086: ldarg.0
IL_0087: call AreaContentSet TheForestOfLove.Content.DeepWoodsSecondForkSpawner::get_Elements()
IL_008c: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0091: call System.Void TheForestOfLove.Content.DeepWoodsSecondForkSpawner::set_GlyphStones(AreaContent)
IL_0096: ldarg.0
IL_0097: ldarg.0
IL_0098: ldstr "Scarlett"
IL_009d: ldarg.0
IL_009e: call AreaContentSet TheForestOfLove.Content.DeepWoodsSecondForkSpawner::get_Critters()
IL_00a3: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00a8: call System.Void TheForestOfLove.Content.DeepWoodsSecondForkSpawner::set_Scarlett(AreaContent)
IL_00ad: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAct2CapstoneOngoing()
IL_00b2: brfalse.s IL_00cd
IL_00b4: ldarg.0
IL_00b5: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsSecondForkSpawner::glyphStonesGlowy
IL_00ba: ldarg.0
IL_00bb: call AreaContent TheForestOfLove.Content.DeepWoodsSecondForkSpawner::get_GlyphStones()
IL_00c0: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_00c5: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_00ca: pop
IL_00cb: br.s IL_00e4
IL_00cd: ldarg.0
IL_00ce: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsSecondForkSpawner::glyphStones
IL_00d3: ldarg.0
IL_00d4: call AreaContent TheForestOfLove.Content.DeepWoodsSecondForkSpawner::get_GlyphStones()
IL_00d9: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_00de: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_00e3: pop
IL_00e4: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_00e9: brfalse.s IL_00ec
IL_00eb: ret
IL_00ec: call System.Boolean TheForestOfLove.PlantQuestMinigameControllerRedux::get_minigameActive()
IL_00f1: brfalse.s IL_010a
IL_00f3: ldarg.0
IL_00f4: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsSecondForkSpawner::plantQuestMinigameController
IL_00f9: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_00fe: pop
IL_00ff: ldarg.0
IL_0100: call AreaContent TheForestOfLove.Content.DeepWoodsSecondForkSpawner::get_GlyphStones()
IL_0105: call System.Void TheForestOfLove.Utility.ContentManagementExtensions::DisableInteractionInChildren(AreaContent)
IL_010a: call System.Boolean TheForestOfLove.QuestTriggerHelper::CanSpawnScarlettHop()
IL_010f: brfalse.s IL_0128
IL_0111: ldarg.0
IL_0112: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsSecondForkSpawner::npcScarlettHop
IL_0117: ldarg.0
IL_0118: call AreaContent TheForestOfLove.Content.DeepWoodsSecondForkSpawner::get_Scarlett()
IL_011d: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0122: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0127: pop
IL_0128: ret
