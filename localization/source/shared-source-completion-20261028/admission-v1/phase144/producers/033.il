TYPE TheForestOfLove.Content.DeepWoodsBayouSpawner
METHOD System.Void TheForestOfLove.Content.DeepWoodsBayouSpawner::SpawnObjects() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldstr "Environment"
IL_0007: ldnull
IL_0008: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_000d: call System.Void TheForestOfLove.Content.DeepWoodsBayouSpawner::set_Environment(AreaContentSet)
IL_0012: ldarg.0
IL_0013: ldarg.0
IL_0014: ldstr "Elements"
IL_0019: ldnull
IL_001a: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_001f: call System.Void TheForestOfLove.Content.DeepWoodsBayouSpawner::set_Elements(AreaContentSet)
IL_0024: ldarg.0
IL_0025: ldarg.0
IL_0026: ldstr "Critters"
IL_002b: ldnull
IL_002c: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_0031: call System.Void TheForestOfLove.Content.DeepWoodsBayouSpawner::set_Critters(AreaContentSet)
IL_0036: ldarg.0
IL_0037: ldarg.0
IL_0038: ldarg.0
IL_0039: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsBayouSpawner::player
IL_003e: ldnull
IL_003f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,UnityEngine.Transform)
IL_0044: call System.Void TheForestOfLove.Content.DeepWoodsBayouSpawner::set_Player(AreaContent)
IL_0049: ldarg.0
IL_004a: ldarg.0
IL_004b: ldarg.0
IL_004c: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsBayouSpawner::environmentBase
IL_0051: ldarg.0
IL_0052: call AreaContentSet TheForestOfLove.Content.DeepWoodsBayouSpawner::get_Environment()
IL_0057: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_005c: call System.Void TheForestOfLove.Content.DeepWoodsBayouSpawner::set_EnvironmentBase(AreaContent)
IL_0061: ldarg.0
IL_0062: ldarg.0
IL_0063: ldarg.0
IL_0064: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsBayouSpawner::elementsBase
IL_0069: ldarg.0
IL_006a: call AreaContentSet TheForestOfLove.Content.DeepWoodsBayouSpawner::get_Elements()
IL_006f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0074: call System.Void TheForestOfLove.Content.DeepWoodsBayouSpawner::set_ElementsBase(AreaContent)
IL_0079: ldarg.0
IL_007a: ldarg.0
IL_007b: ldstr "Fen"
IL_0080: ldarg.0
IL_0081: call AreaContentSet TheForestOfLove.Content.DeepWoodsBayouSpawner::get_Critters()
IL_0086: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_008b: call System.Void TheForestOfLove.Content.DeepWoodsBayouSpawner::set_Fen(AreaContent)
IL_0090: ldarg.0
IL_0091: ldarg.0
IL_0092: ldstr "Scarlett"
IL_0097: ldarg.0
IL_0098: call AreaContentSet TheForestOfLove.Content.DeepWoodsBayouSpawner::get_Critters()
IL_009d: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00a2: call System.Void TheForestOfLove.Content.DeepWoodsBayouSpawner::set_Scarlett(AreaContent)
IL_00a7: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_00ac: brfalse.s IL_00b5
IL_00ae: ldarg.0
IL_00af: call System.Void TheForestOfLove.Content.DeepWoodsBayouSpawner::SpawnInstancedStoryStuff()
IL_00b4: ret
IL_00b5: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerHasFullAccessToDeepWoods()
IL_00ba: brfalse.s IL_00d0
IL_00bc: ldstr "MouseQuest_MeetMabelsMom"
IL_00c1: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_00c6: brfalse.s IL_00d0
IL_00c8: ldarg.0
IL_00c9: call System.Void TheForestOfLove.Content.DeepWoodsBayouSpawner::SpawnLanternStuff()
IL_00ce: br.s IL_00d6
IL_00d0: ldarg.0
IL_00d1: call System.Void TheForestOfLove.Content.DeepWoodsBayouSpawner::SpawnDarknessStuff()
IL_00d6: call System.Boolean TheForestOfLove.PlantQuestMinigameControllerRedux::get_minigameActive()
IL_00db: brfalse.s IL_00e9
IL_00dd: ldarg.0
IL_00de: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsBayouSpawner::plantQuestMinigameController
IL_00e3: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_00e8: pop
IL_00e9: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerHasFullAccessToDeepWoods()
IL_00ee: brfalse.s IL_0107
IL_00f0: ldarg.0
IL_00f1: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsBayouSpawner::npcFen
IL_00f6: ldarg.0
IL_00f7: call AreaContent TheForestOfLove.Content.DeepWoodsBayouSpawner::get_Fen()
IL_00fc: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0101: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0106: pop
IL_0107: ldstr "MouseQuest_MeetMabelsMom"
IL_010c: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0111: brfalse.s IL_012b
IL_0113: ldstr "WolfQuest_MeetTheWolf"
IL_0118: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_011d: brtrue.s IL_012b
IL_011f: ldarg.0
IL_0120: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsBayouSpawner::act3WolfQuestMeetTheWolfCutscene
IL_0125: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_012a: pop
IL_012b: call System.Boolean TheForestOfLove.QuestTriggerHelper::CanSpawnScarlettHop()
IL_0130: brfalse.s IL_0180
IL_0132: ldarg.0
IL_0133: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsBayouSpawner::npcScarlettHop
IL_0138: ldarg.0
IL_0139: call AreaContent TheForestOfLove.Content.DeepWoodsBayouSpawner::get_Scarlett()
IL_013e: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0143: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0148: pop
IL_0149: ldarg.0
IL_014a: ldarg.0
IL_014b: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsBayouSpawner::scarlettHopHints
IL_0150: ldarg.0
IL_0151: call AreaContentSet TheForestOfLove.Content.DeepWoodsBayouSpawner::get_Elements()
IL_0156: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_015b: pop
IL_015c: ldarg.0
IL_015d: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsBayouSpawner::act3WolfQuestReturnToWolfCutscene
IL_0162: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0167: pop
IL_0168: ldarg.0
IL_0169: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsBayouSpawner::act3WolfQuestScarlettHopToFenCutscene
IL_016e: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0173: pop
IL_0174: ldarg.0
IL_0175: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsBayouSpawner::act3WolfQuestScarlettFenPostSexCandidCutscene
IL_017a: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_017f: pop
IL_0180: ret
