TYPE TheForestOfLove.Content.LakeRuinsSpawner
METHOD System.Void TheForestOfLove.Content.LakeRuinsSpawner::SpawnObjects() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldstr "Environment"
IL_0007: ldnull
IL_0008: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_000d: call System.Void TheForestOfLove.Content.LakeRuinsSpawner::set_Environment(AreaContentSet)
IL_0012: ldarg.0
IL_0013: ldarg.0
IL_0014: ldstr "Elements"
IL_0019: ldnull
IL_001a: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_001f: call System.Void TheForestOfLove.Content.LakeRuinsSpawner::set_Elements(AreaContentSet)
IL_0024: ldarg.0
IL_0025: ldarg.0
IL_0026: ldstr "Critters"
IL_002b: ldnull
IL_002c: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_0031: call System.Void TheForestOfLove.Content.LakeRuinsSpawner::set_Critters(AreaContentSet)
IL_0036: ldarg.0
IL_0037: ldarg.0
IL_0038: ldarg.0
IL_0039: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::player
IL_003e: callvirt System.String UnityEngine.Object::get_name()
IL_0043: ldarg.0
IL_0044: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::player
IL_0049: ldnull
IL_004a: ldc.i4.0
IL_004b: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContentOrFind(System.String,UnityEngine.GameObject,UnityEngine.Transform,System.Boolean)
IL_0050: call System.Void TheForestOfLove.Content.LakeRuinsSpawner::set_Player(AreaContent)
IL_0055: ldarg.0
IL_0056: ldarg.0
IL_0057: ldarg.0
IL_0058: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::environmentBase
IL_005d: ldarg.0
IL_005e: call AreaContentSet TheForestOfLove.Content.LakeRuinsSpawner::get_Environment()
IL_0063: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0068: call System.Void TheForestOfLove.Content.LakeRuinsSpawner::set_EnvironmentBase(AreaContent)
IL_006d: ldarg.0
IL_006e: ldarg.0
IL_006f: ldarg.0
IL_0070: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::elementsBase
IL_0075: ldarg.0
IL_0076: call AreaContentSet TheForestOfLove.Content.LakeRuinsSpawner::get_Elements()
IL_007b: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0080: call System.Void TheForestOfLove.Content.LakeRuinsSpawner::set_ElementsBase(AreaContent)
IL_0085: ldarg.0
IL_0086: ldarg.0
IL_0087: ldarg.0
IL_0088: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::endOfAct2ExitBlocker
IL_008d: callvirt System.String UnityEngine.Object::get_name()
IL_0092: ldarg.0
IL_0093: call AreaContentSet TheForestOfLove.Content.LakeRuinsSpawner::get_Elements()
IL_0098: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_009d: call System.Void TheForestOfLove.Content.LakeRuinsSpawner::set_EndOfAct2ExitBlocker(AreaContent)
IL_00a2: ldarg.0
IL_00a3: ldarg.0
IL_00a4: ldstr "Augustus"
IL_00a9: ldarg.0
IL_00aa: call AreaContentSet TheForestOfLove.Content.LakeRuinsSpawner::get_Critters()
IL_00af: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00b4: call System.Void TheForestOfLove.Content.LakeRuinsSpawner::set_Augustus(AreaContent)
IL_00b9: ldarg.0
IL_00ba: ldarg.0
IL_00bb: ldarg.0
IL_00bc: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::melodyFlipbookPhotoFirst
IL_00c1: callvirt System.String UnityEngine.Object::get_name()
IL_00c6: ldarg.0
IL_00c7: call AreaContentSet TheForestOfLove.Content.LakeRuinsSpawner::get_Elements()
IL_00cc: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00d1: call System.Void TheForestOfLove.Content.LakeRuinsSpawner::set_MelodyFlipbookPhotoFirst(AreaContent)
IL_00d6: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_00db: brfalse.s IL_00e4
IL_00dd: ldarg.0
IL_00de: call System.Void TheForestOfLove.Content.LakeRuinsSpawner::SpawnInstancedStoryStuff()
IL_00e3: ret
IL_00e4: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsAct2CapstoneOngoing()
IL_00e9: brfalse IL_018e
IL_00ee: ldarg.0
IL_00ef: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::glyphStonesGlowy
IL_00f4: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_00f9: pop
IL_00fa: ldarg.0
IL_00fb: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::glyphMonumentsGlowFx
IL_0100: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0105: pop
IL_0106: ldarg.0
IL_0107: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::endOfAct2CapstoneObjects
IL_010c: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0111: pop
IL_0112: call System.Boolean TheForestOfLove.SpawnManager::get_isFastTraveling()
IL_0117: brfalse.s IL_0156
IL_0119: ldarg.0
IL_011a: ldarg.0
IL_011b: ldarg.0
IL_011c: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::fastTravelPerchAct2Capstone
IL_0121: ldarg.0
IL_0122: call AreaContentSet TheForestOfLove.Content.LakeRuinsSpawner::get_Elements()
IL_0127: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_012c: call System.Void TheForestOfLove.Content.LakeRuinsSpawner::set_FastTravelPerch(AreaContent)
IL_0131: ldarg.0
IL_0132: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::fastTravelCutsceneAct2Capstone
IL_0137: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_013c: pop
IL_013d: ldarg.0
IL_013e: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::endOfAct2PlayerSpawnSnapper
IL_0143: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0148: pop
IL_0149: ldsfld TheForestOfLove.Player TheForestOfLove.Player::current
IL_014e: ldc.i4.1
IL_014f: callvirt System.Void TheForestOfLove.Gameplay.SpawnableActor::SetDefaultDirection(TheForestOfLove.Direction)
IL_0154: br.s IL_0169
IL_0156: ldarg.0
IL_0157: ldarg.0
IL_0158: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::npcPennyAct2Capstone
IL_015d: ldarg.0
IL_015e: call AreaContentSet TheForestOfLove.Content.LakeRuinsSpawner::get_Critters()
IL_0163: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0168: pop
IL_0169: ldstr "Act2Capstone_RuinsAugustus1"
IL_016e: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsConversationPlayed(System.String)
IL_0173: brtrue.s IL_01bb
IL_0175: ldarg.0
IL_0176: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::endOfAct2ExitBlocker
IL_017b: ldarg.0
IL_017c: call AreaContent TheForestOfLove.Content.LakeRuinsSpawner::get_EndOfAct2ExitBlocker()
IL_0181: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0186: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_018b: pop
IL_018c: br.s IL_01bb
IL_018e: call System.Boolean TheForestOfLove.QuestTriggerHelper::FinishedAct2()
IL_0193: brfalse.s IL_01b5
IL_0195: ldarg.0
IL_0196: call System.Void TheForestOfLove.Content.LakeRuinsSpawner::SpawnAugustus()
IL_019b: ldarg.0
IL_019c: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::glyphStonesPostAct2
IL_01a1: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_01a6: pop
IL_01a7: ldarg.0
IL_01a8: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::glyphMonumentsInteractionsPostAct2
IL_01ad: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_01b2: pop
IL_01b3: br.s IL_01bb
IL_01b5: ldarg.0
IL_01b6: call System.Void TheForestOfLove.Content.LakeRuinsSpawner::SpawnDefaultMonumentsAndGlyphstones()
IL_01bb: ldarg.0
IL_01bc: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::melodyFlipbookPhotoFirst
IL_01c1: call System.Boolean TheForestOfLove.Content.BaseSpawner::CanSpawnMelodyFlipbookPhotoPickup(UnityEngine.GameObject)
IL_01c6: brfalse.s IL_0211
IL_01c8: ldarg.0
IL_01c9: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::melodyFlipbookPhotoFirst
IL_01ce: ldarg.0
IL_01cf: call AreaContent TheForestOfLove.Content.LakeRuinsSpawner::get_MelodyFlipbookPhotoFirst()
IL_01d4: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_01d9: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_01de: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_01e3: ldarg.0
IL_01e4: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::melodyFlipbookPhotoFirstSpawnLocation
IL_01e9: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_01ee: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_01f3: ldc.r4 1
IL_01f8: ldc.r4 1
IL_01fd: ldc.r4 0
IL_0202: newobj System.Void UnityEngine.Vector3::.ctor(System.Single,System.Single,System.Single)
IL_0207: call UnityEngine.Vector3 UnityEngine.Vector3::Scale(UnityEngine.Vector3,UnityEngine.Vector3)
IL_020c: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_0211: ldarg.0
IL_0212: call System.Void TheForestOfLove.Content.LakeRuinsSpawner::SpawnDefaultCritters()
IL_0217: ret
METHOD System.Void TheForestOfLove.Content.LakeRuinsSpawner::SpawnAugustus() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "Augustus"
IL_0005: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsActorSpawnedOrOnDate(System.String)
IL_000a: brfalse.s IL_000d
IL_000c: ret
IL_000d: ldarg.0
IL_000e: ldfld UnityEngine.GameObject TheForestOfLove.Content.LakeRuinsSpawner::npcAugustus
IL_0013: ldarg.0
IL_0014: call AreaContent TheForestOfLove.Content.LakeRuinsSpawner::get_Augustus()
IL_0019: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_001e: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0023: pop
IL_0024: ret
