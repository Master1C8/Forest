TYPE TheForestOfLove.Content.DeepWoodsEntrySpawner
METHOD System.Void TheForestOfLove.Content.DeepWoodsEntrySpawner::SpawnObjects() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldstr "Environment"
IL_0007: ldnull
IL_0008: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_000d: call System.Void TheForestOfLove.Content.DeepWoodsEntrySpawner::set_Environment(AreaContentSet)
IL_0012: ldarg.0
IL_0013: ldarg.0
IL_0014: ldstr "Elements"
IL_0019: ldnull
IL_001a: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_001f: call System.Void TheForestOfLove.Content.DeepWoodsEntrySpawner::set_Elements(AreaContentSet)
IL_0024: ldarg.0
IL_0025: ldarg.0
IL_0026: ldstr "Critters"
IL_002b: ldnull
IL_002c: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_0031: call System.Void TheForestOfLove.Content.DeepWoodsEntrySpawner::set_Critters(AreaContentSet)
IL_0036: ldarg.0
IL_0037: ldarg.0
IL_0038: ldarg.0
IL_0039: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsEntrySpawner::player
IL_003e: ldnull
IL_003f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,UnityEngine.Transform)
IL_0044: call System.Void TheForestOfLove.Content.DeepWoodsEntrySpawner::set_Player(AreaContent)
IL_0049: ldarg.0
IL_004a: ldarg.0
IL_004b: ldarg.0
IL_004c: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsEntrySpawner::environmentBase
IL_0051: ldarg.0
IL_0052: call AreaContentSet TheForestOfLove.Content.DeepWoodsEntrySpawner::get_Environment()
IL_0057: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_005c: call System.Void TheForestOfLove.Content.DeepWoodsEntrySpawner::set_EnvironmentBase(AreaContent)
IL_0061: ldarg.0
IL_0062: ldarg.0
IL_0063: ldarg.0
IL_0064: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsEntrySpawner::elementsBase
IL_0069: ldarg.0
IL_006a: call AreaContentSet TheForestOfLove.Content.DeepWoodsEntrySpawner::get_Elements()
IL_006f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0074: call System.Void TheForestOfLove.Content.DeepWoodsEntrySpawner::set_ElementsBase(AreaContent)
IL_0079: ldarg.0
IL_007a: ldarg.0
IL_007b: ldstr "Scarlett"
IL_0080: ldarg.0
IL_0081: call AreaContentSet TheForestOfLove.Content.DeepWoodsEntrySpawner::get_Critters()
IL_0086: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_008b: call System.Void TheForestOfLove.Content.DeepWoodsEntrySpawner::set_Scarlett(AreaContent)
IL_0090: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_0095: brfalse.s IL_0098
IL_0097: ret
IL_0098: ldstr "Act1_PlantQuest"
IL_009d: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.QuestTriggerHelper::LoadQuestStatus(System.String)
IL_00a2: brtrue.s IL_00b0
IL_00a4: ldarg.0
IL_00a5: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsEntrySpawner::plantQuestAccessBlocker
IL_00aa: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_00af: pop
IL_00b0: call System.Boolean TheForestOfLove.PlantQuestMinigameControllerRedux::get_minigameActive()
IL_00b5: brfalse.s IL_00cf
IL_00b7: ldarg.0
IL_00b8: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsEntrySpawner::plantQuestMinigameController
IL_00bd: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_00c2: pop
IL_00c3: ldarg.0
IL_00c4: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsEntrySpawner::plantQuestMabelInterruption
IL_00c9: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_00ce: pop
IL_00cf: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAct3LightQuestGatheringFireflies()
IL_00d4: brtrue.s IL_00f3
IL_00d6: ldstr "Act3_LightQuest"
IL_00db: call TheForestOfLove.Narrative.QuestStatus TheForestOfLove.QuestTriggerHelper::LoadQuestStatus(System.String)
IL_00e0: ldc.i4 200
IL_00e5: bne.un.s IL_0144
IL_00e7: ldstr "act3_lightquest_ready_to_enter_deepwoods"
IL_00ec: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_00f1: brtrue.s IL_0144
IL_00f3: call System.Boolean TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::AllButOneFirefliesCollected()
IL_00f8: brfalse.s IL_010d
IL_00fa: ldarg.0
IL_00fb: ldarg.0
IL_00fc: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsEntrySpawner::act3AfterStormFireflies
IL_0101: ldarg.0
IL_0102: call AreaContentSet TheForestOfLove.Content.DeepWoodsEntrySpawner::get_Elements()
IL_0107: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_010c: pop
IL_010d: call System.Boolean TheForestOfLove.Events.TriggerHandlers.TriggerHandlerAct3::AllButOneFirefliesCollected()
IL_0112: brtrue.s IL_012c
IL_0114: ldc.i4 440
IL_0119: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerHasItem(TheForestOfLove.Inventory.InventoryItemType)
IL_011e: brfalse.s IL_0144
IL_0120: ldstr "act3_lightquest_ready_to_enter_deepwoods"
IL_0125: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsTriggerSet(System.String)
IL_012a: brtrue.s IL_0144
IL_012c: ldarg.0
IL_012d: ldarg.0
IL_012e: ldarg.0
IL_012f: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsEntrySpawner::act3LightQuestLanternAccessBlocker
IL_0134: ldarg.0
IL_0135: call AreaContentSet TheForestOfLove.Content.DeepWoodsEntrySpawner::get_Elements()
IL_013a: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_013f: call System.Void TheForestOfLove.Content.DeepWoodsEntrySpawner::set_Act3LanternAccessBlocker(AreaContent)
IL_0144: call System.Boolean TheForestOfLove.QuestTriggerHelper::CanSpawnScarlettHop()
IL_0149: brfalse.s IL_0162
IL_014b: ldarg.0
IL_014c: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsEntrySpawner::npcScarlettHop
IL_0151: ldarg.0
IL_0152: call AreaContent TheForestOfLove.Content.DeepWoodsEntrySpawner::get_Scarlett()
IL_0157: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_015c: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0161: pop
IL_0162: ret
