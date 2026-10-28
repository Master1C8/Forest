TYPE TheForestOfLove.Content.DeepWoodsTreeArchSpawner
METHOD System.Void TheForestOfLove.Content.DeepWoodsTreeArchSpawner::SpawnObjects() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldstr "Environment"
IL_0007: ldnull
IL_0008: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_000d: call System.Void TheForestOfLove.Content.DeepWoodsTreeArchSpawner::set_Environment(AreaContentSet)
IL_0012: ldarg.0
IL_0013: ldarg.0
IL_0014: ldstr "Elements"
IL_0019: ldnull
IL_001a: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_001f: call System.Void TheForestOfLove.Content.DeepWoodsTreeArchSpawner::set_Elements(AreaContentSet)
IL_0024: ldarg.0
IL_0025: ldarg.0
IL_0026: ldstr "Critters"
IL_002b: ldnull
IL_002c: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_0031: call System.Void TheForestOfLove.Content.DeepWoodsTreeArchSpawner::set_Critters(AreaContentSet)
IL_0036: ldarg.0
IL_0037: ldarg.0
IL_0038: ldarg.0
IL_0039: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsTreeArchSpawner::player
IL_003e: ldnull
IL_003f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,UnityEngine.Transform)
IL_0044: call System.Void TheForestOfLove.Content.DeepWoodsTreeArchSpawner::set_Player(AreaContent)
IL_0049: ldarg.0
IL_004a: ldarg.0
IL_004b: ldarg.0
IL_004c: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsTreeArchSpawner::environmentBase
IL_0051: ldarg.0
IL_0052: call AreaContentSet TheForestOfLove.Content.DeepWoodsTreeArchSpawner::get_Environment()
IL_0057: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_005c: call System.Void TheForestOfLove.Content.DeepWoodsTreeArchSpawner::set_EnvironmentBase(AreaContent)
IL_0061: ldarg.0
IL_0062: ldarg.0
IL_0063: ldarg.0
IL_0064: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsTreeArchSpawner::elementsBase
IL_0069: ldarg.0
IL_006a: call AreaContentSet TheForestOfLove.Content.DeepWoodsTreeArchSpawner::get_Elements()
IL_006f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0074: call System.Void TheForestOfLove.Content.DeepWoodsTreeArchSpawner::set_ElementsBase(AreaContent)
IL_0079: ldarg.0
IL_007a: ldarg.0
IL_007b: ldstr "Scarlett"
IL_0080: ldarg.0
IL_0081: call AreaContentSet TheForestOfLove.Content.DeepWoodsTreeArchSpawner::get_Critters()
IL_0086: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_008b: call System.Void TheForestOfLove.Content.DeepWoodsTreeArchSpawner::set_Scarlett(AreaContent)
IL_0090: ldarg.0
IL_0091: ldarg.0
IL_0092: ldarg.0
IL_0093: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsTreeArchSpawner::melodyFlipbookPhotoFirst
IL_0098: callvirt System.String UnityEngine.Object::get_name()
IL_009d: ldarg.0
IL_009e: call AreaContentSet TheForestOfLove.Content.DeepWoodsTreeArchSpawner::get_Elements()
IL_00a3: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00a8: call System.Void TheForestOfLove.Content.DeepWoodsTreeArchSpawner::set_MelodyFlipbookPhotoFirst(AreaContent)
IL_00ad: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_00b2: brfalse.s IL_00bb
IL_00b4: ldarg.0
IL_00b5: call System.Void TheForestOfLove.Content.DeepWoodsTreeArchSpawner::SpawnInstancedStoryStuff()
IL_00ba: ret
IL_00bb: call System.Boolean TheForestOfLove.QuestTriggerHelper::PlayerHasFullAccessToDeepWoods()
IL_00c0: brfalse.s IL_00ca
IL_00c2: ldarg.0
IL_00c3: call System.Void TheForestOfLove.Content.DeepWoodsTreeArchSpawner::SpawnLanternStuff()
IL_00c8: br.s IL_00d0
IL_00ca: ldarg.0
IL_00cb: call System.Void TheForestOfLove.Content.DeepWoodsTreeArchSpawner::SpawnDarknessStuff()
IL_00d0: call System.Boolean TheForestOfLove.PlantQuestMinigameControllerRedux::get_minigameActive()
IL_00d5: brfalse.s IL_00e3
IL_00d7: ldarg.0
IL_00d8: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsTreeArchSpawner::plantQuestMinigameController
IL_00dd: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_00e2: pop
IL_00e3: call System.Boolean TheForestOfLove.QuestTriggerHelper::CanSpawnScarlettHop()
IL_00e8: brfalse.s IL_0114
IL_00ea: ldarg.0
IL_00eb: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsTreeArchSpawner::npcScarlettHop
IL_00f0: ldarg.0
IL_00f1: call AreaContent TheForestOfLove.Content.DeepWoodsTreeArchSpawner::get_Scarlett()
IL_00f6: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_00fb: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0100: pop
IL_0101: ldarg.0
IL_0102: ldarg.0
IL_0103: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsTreeArchSpawner::scarlettHopHints
IL_0108: ldarg.0
IL_0109: call AreaContentSet TheForestOfLove.Content.DeepWoodsTreeArchSpawner::get_Elements()
IL_010e: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0113: pop
IL_0114: ldarg.0
IL_0115: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsTreeArchSpawner::melodyFlipbookPhotoFirst
IL_011a: call System.Boolean TheForestOfLove.Content.BaseSpawner::CanSpawnMelodyFlipbookPhotoPickup(UnityEngine.GameObject)
IL_011f: brfalse.s IL_016a
IL_0121: ldarg.0
IL_0122: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsTreeArchSpawner::melodyFlipbookPhotoFirst
IL_0127: ldarg.0
IL_0128: call AreaContent TheForestOfLove.Content.DeepWoodsTreeArchSpawner::get_MelodyFlipbookPhotoFirst()
IL_012d: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0132: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0137: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_013c: ldarg.0
IL_013d: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsTreeArchSpawner::melodyFlipbookPhotoFirstSpawnLocation
IL_0142: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0147: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_014c: ldc.r4 1
IL_0151: ldc.r4 1
IL_0156: ldc.r4 0
IL_015b: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_0160: call UnityEngine.Vector3 UnityEngine.Vector3::Scale(UnityEngine.Vector3,UnityEngine.Vector3)
IL_0165: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_016a: ret
