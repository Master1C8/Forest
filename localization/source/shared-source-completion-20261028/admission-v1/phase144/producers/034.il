TYPE TheForestOfLove.Content.DeepWoodsCampfireSpawner
METHOD System.Void TheForestOfLove.Content.DeepWoodsCampfireSpawner::SpawnObjects() | attributes=Family, Virtual, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldstr "Environment"
IL_0007: ldnull
IL_0008: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_000d: call System.Void TheForestOfLove.Content.DeepWoodsCampfireSpawner::set_Environment(AreaContentSet)
IL_0012: ldarg.0
IL_0013: ldarg.0
IL_0014: ldstr "Elements"
IL_0019: ldnull
IL_001a: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_001f: call System.Void TheForestOfLove.Content.DeepWoodsCampfireSpawner::set_Elements(AreaContentSet)
IL_0024: ldarg.0
IL_0025: ldarg.0
IL_0026: ldstr "Critters"
IL_002b: ldnull
IL_002c: call AreaContentSet TheForestOfLove.Content.BaseSpawner::NewEmptyContentSet(System.String,UnityEngine.Transform)
IL_0031: call System.Void TheForestOfLove.Content.DeepWoodsCampfireSpawner::set_Critters(AreaContentSet)
IL_0036: ldarg.0
IL_0037: ldarg.0
IL_0038: ldarg.0
IL_0039: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsCampfireSpawner::player
IL_003e: ldnull
IL_003f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,UnityEngine.Transform)
IL_0044: call System.Void TheForestOfLove.Content.DeepWoodsCampfireSpawner::set_Player(AreaContent)
IL_0049: ldarg.0
IL_004a: ldarg.0
IL_004b: ldarg.0
IL_004c: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsCampfireSpawner::environmentBase
IL_0051: ldarg.0
IL_0052: call AreaContentSet TheForestOfLove.Content.DeepWoodsCampfireSpawner::get_Environment()
IL_0057: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_005c: call System.Void TheForestOfLove.Content.DeepWoodsCampfireSpawner::set_EnvironmentBase(AreaContent)
IL_0061: ldarg.0
IL_0062: ldarg.0
IL_0063: ldarg.0
IL_0064: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsCampfireSpawner::elementsBase
IL_0069: ldarg.0
IL_006a: call AreaContentSet TheForestOfLove.Content.DeepWoodsCampfireSpawner::get_Elements()
IL_006f: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_0074: call System.Void TheForestOfLove.Content.DeepWoodsCampfireSpawner::set_ElementsBase(AreaContent)
IL_0079: ldarg.0
IL_007a: ldarg.0
IL_007b: ldarg.0
IL_007c: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsCampfireSpawner::campfire
IL_0081: ldarg.0
IL_0082: call AreaContentSet TheForestOfLove.Content.DeepWoodsCampfireSpawner::get_Elements()
IL_0087: call AreaContent TheForestOfLove.Content.BaseSpawner::NewContent(UnityEngine.GameObject,AreaContentSet)
IL_008c: call System.Void TheForestOfLove.Content.DeepWoodsCampfireSpawner::set_Campfire(AreaContent)
IL_0091: ldarg.0
IL_0092: ldarg.0
IL_0093: ldstr "MabelsMom"
IL_0098: ldarg.0
IL_0099: call AreaContentSet TheForestOfLove.Content.DeepWoodsCampfireSpawner::get_Critters()
IL_009e: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00a3: call System.Void TheForestOfLove.Content.DeepWoodsCampfireSpawner::set_MabelsMom(AreaContent)
IL_00a8: ldarg.0
IL_00a9: ldarg.0
IL_00aa: ldstr "Mabel"
IL_00af: ldarg.0
IL_00b0: call AreaContentSet TheForestOfLove.Content.DeepWoodsCampfireSpawner::get_Critters()
IL_00b5: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00ba: call System.Void TheForestOfLove.Content.DeepWoodsCampfireSpawner::set_Mabel(AreaContent)
IL_00bf: ldarg.0
IL_00c0: ldarg.0
IL_00c1: ldstr "forest mice spawn randomizers"
IL_00c6: ldarg.0
IL_00c7: call AreaContentSet TheForestOfLove.Content.DeepWoodsCampfireSpawner::get_Critters()
IL_00cc: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00d1: call System.Void TheForestOfLove.Content.DeepWoodsCampfireSpawner::set_ForestMiceSpawnRandomizers(AreaContent)
IL_00d6: ldarg.0
IL_00d7: ldarg.0
IL_00d8: ldstr "forest mice"
IL_00dd: ldarg.0
IL_00de: call AreaContentSet TheForestOfLove.Content.DeepWoodsCampfireSpawner::get_Critters()
IL_00e3: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_00e8: call System.Void TheForestOfLove.Content.DeepWoodsCampfireSpawner::set_ForestMice(AreaContent)
IL_00ed: call System.Boolean TheForestOfLove.QuestTriggerHelper::InAnyInstancedStory()
IL_00f2: brfalse.s IL_00f5
IL_00f4: ret
IL_00f5: ldstr "Act3_MouseQuest"
IL_00fa: call System.Boolean TheForestOfLove.QuestTriggerHelper::IsQuestCompleted(System.String)
IL_00ff: brtrue.s IL_011a
IL_0101: ldarg.0
IL_0102: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsCampfireSpawner::npcMabelsMom
IL_0107: ldarg.0
IL_0108: call AreaContent TheForestOfLove.Content.DeepWoodsCampfireSpawner::get_MabelsMom()
IL_010d: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0112: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0117: pop
IL_0118: br.s IL_011f
IL_011a: call System.Void TheForestOfLove.Content.DeepWoodsCampfireSpawner::SpawnMabelAndMabelsMomAct3MouseQuestCompleted()
IL_011f: ldarg.0
IL_0120: call System.Void TheForestOfLove.Content.DeepWoodsCampfireSpawner::SpawnRandomForestMice()
IL_0125: ret
METHOD System.Void TheForestOfLove.Content.DeepWoodsCampfireSpawner::SpawnRandomForestMice() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call AreaContent TheForestOfLove.Content.DeepWoodsCampfireSpawner::get_ForestMiceSpawnRandomizers()
IL_0006: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_000b: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_0010: ldarg.0
IL_0011: call AreaContent TheForestOfLove.Content.DeepWoodsCampfireSpawner::get_ForestMice()
IL_0016: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_001b: call System.Void UnityEngine.Object::Destroy(UnityEngine.Object)
IL_0020: ldarg.0
IL_0021: ldarg.0
IL_0022: ldstr "forest mice spawn randomizers"
IL_0027: ldarg.0
IL_0028: call AreaContentSet TheForestOfLove.Content.DeepWoodsCampfireSpawner::get_Critters()
IL_002d: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0032: call System.Void TheForestOfLove.Content.DeepWoodsCampfireSpawner::set_ForestMiceSpawnRandomizers(AreaContent)
IL_0037: ldarg.0
IL_0038: ldarg.0
IL_0039: ldstr "forest mice"
IL_003e: ldarg.0
IL_003f: call AreaContentSet TheForestOfLove.Content.DeepWoodsCampfireSpawner::get_Critters()
IL_0044: call AreaContent TheForestOfLove.Content.BaseSpawner::NewEmptyContent(System.String,AreaContentSet)
IL_0049: call System.Void TheForestOfLove.Content.DeepWoodsCampfireSpawner::set_ForestMice(AreaContent)
IL_004e: ldarg.0
IL_004f: ldfld TheForestOfLove.ForestMouseSpawnPointRandomizer[] TheForestOfLove.Content.DeepWoodsCampfireSpawner::mouseSpawnRandomizers
IL_0054: ldlen
IL_0055: conv.i4
IL_0056: newobj System.Void System.Collections.Generic.List`1<TheForestOfLove.ForestMouseSpawnPointRandomizer>::.ctor(System.Int32)
IL_005b: stloc.0
IL_005c: ldarg.0
IL_005d: ldfld TheForestOfLove.ForestMouseSpawnPointRandomizer[] TheForestOfLove.Content.DeepWoodsCampfireSpawner::mouseSpawnRandomizers
IL_0062: stloc.3
IL_0063: ldc.i4.0
IL_0064: stloc.s V_4
IL_0066: br.s IL_0091
IL_0068: ldloc.3
IL_0069: ldloc.s V_4
IL_006b: ldelem.ref
IL_006c: stloc.s V_5
IL_006e: ldloc.0
IL_006f: ldloc.s V_5
IL_0071: ldarg.0
IL_0072: call AreaContent TheForestOfLove.Content.DeepWoodsCampfireSpawner::get_ForestMiceSpawnRandomizers()
IL_0077: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_007c: call !!0 UnityEngine.Object::Instantiate<TheForestOfLove.ForestMouseSpawnPointRandomizer>(!!0,UnityEngine.Transform)
IL_0081: callvirt !!0 UnityEngine.Component::GetComponent<TheForestOfLove.ForestMouseSpawnPointRandomizer>()
IL_0086: callvirt System.Void System.Collections.Generic.List`1<TheForestOfLove.ForestMouseSpawnPointRandomizer>::Add(!0)
IL_008b: ldloc.s V_4
IL_008d: ldc.i4.1
IL_008e: add
IL_008f: stloc.s V_4
IL_0091: ldloc.s V_4
IL_0093: ldloc.3
IL_0094: ldlen
IL_0095: conv.i4
IL_0096: blt.s IL_0068
IL_0098: ldloc.0
IL_0099: call System.Void TheForestOfLove.Content.DeepWoodsCampfireSpawner::RandomizeList<TheForestOfLove.ForestMouseSpawnPointRandomizer>(System.Collections.Generic.List`1<T>)
IL_009e: newobj System.Void System.Collections.Generic.List`1<UnityEngine.GameObject>::.ctor()
IL_00a3: stloc.1
IL_00a4: ldloc.1
IL_00a5: ldarg.0
IL_00a6: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsCampfireSpawner::npcForestMouse_Amorous
IL_00ab: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.GameObject>::Add(!0)
IL_00b0: ldloc.1
IL_00b1: ldarg.0
IL_00b2: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsCampfireSpawner::npcForestMouse_Astonished
IL_00b7: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.GameObject>::Add(!0)
IL_00bc: ldloc.1
IL_00bd: ldarg.0
IL_00be: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsCampfireSpawner::npcForestMouse_Cautious
IL_00c3: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.GameObject>::Add(!0)
IL_00c8: ldloc.1
IL_00c9: ldarg.0
IL_00ca: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsCampfireSpawner::npcForestMouse_Cordial
IL_00cf: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.GameObject>::Add(!0)
IL_00d4: ldloc.1
IL_00d5: ldarg.0
IL_00d6: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsCampfireSpawner::npcForestMouse_Curious
IL_00db: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.GameObject>::Add(!0)
IL_00e0: ldloc.1
IL_00e1: ldarg.0
IL_00e2: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsCampfireSpawner::npcForestMouse_Excited
IL_00e7: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.GameObject>::Add(!0)
IL_00ec: ldloc.1
IL_00ed: ldarg.0
IL_00ee: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsCampfireSpawner::npcForestMouse_Hospitable
IL_00f3: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.GameObject>::Add(!0)
IL_00f8: ldloc.1
IL_00f9: ldarg.0
IL_00fa: ldfld UnityEngine.GameObject TheForestOfLove.Content.DeepWoodsCampfireSpawner::npcForestMouse_Polite
IL_00ff: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.GameObject>::Add(!0)
IL_0104: ldloc.1
IL_0105: call System.Void TheForestOfLove.Content.DeepWoodsCampfireSpawner::RandomizeList<UnityEngine.GameObject>(System.Collections.Generic.List`1<T>)
IL_010a: ldarg.0
IL_010b: ldfld System.Int32 TheForestOfLove.Content.DeepWoodsCampfireSpawner::minForestMice
IL_0110: ldarg.0
IL_0111: ldfld System.Int32 TheForestOfLove.Content.DeepWoodsCampfireSpawner::maxForestMice
IL_0116: ldc.i4.1
IL_0117: add
IL_0118: call System.Int32 UnityEngine.Random::Range(System.Int32,System.Int32)
IL_011d: stloc.2
IL_011e: ldloc.2
IL_011f: ldloc.1
IL_0120: callvirt System.Int32 System.Collections.Generic.List`1<UnityEngine.GameObject>::get_Count()
IL_0125: call System.Int32 UnityEngine.Mathf::Min(System.Int32,System.Int32)
IL_012a: stloc.2
IL_012b: ldloc.2
IL_012c: ldloc.0
IL_012d: callvirt System.Int32 System.Collections.Generic.List`1<TheForestOfLove.ForestMouseSpawnPointRandomizer>::get_Count()
IL_0132: call System.Int32 UnityEngine.Mathf::Min(System.Int32,System.Int32)
IL_0137: stloc.2
IL_0138: ldc.i4.0
IL_0139: stloc.s V_6
IL_013b: br IL_01c7
IL_0140: ldloc.1
IL_0141: ldloc.s V_6
IL_0143: callvirt !0 System.Collections.Generic.List`1<UnityEngine.GameObject>::get_Item(System.Int32)
IL_0148: ldarg.0
IL_0149: call AreaContent TheForestOfLove.Content.DeepWoodsCampfireSpawner::get_ForestMice()
IL_014e: callvirt UnityEngine.Transform AreaContent::get_Wrapper()
IL_0153: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_0158: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.Gameplay.SpawnableActor>()
IL_015d: stloc.s V_7
IL_015f: ldloc.0
IL_0160: ldloc.s V_6
IL_0162: callvirt !0 System.Collections.Generic.List`1<TheForestOfLove.ForestMouseSpawnPointRandomizer>::get_Item(System.Int32)
IL_0167: stloc.s V_8
IL_0169: ldloc.s V_7
IL_016b: callvirt UnityEngine.SpriteRenderer TheForestOfLove.Gameplay.SpawnableActor::get_SpriteRenderer()
IL_0170: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0175: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.TransformOffset>()
IL_017a: stloc.s V_9
IL_017c: ldloc.s V_7
IL_017e: callvirt TheForestOfLove.TransformOffset TheForestOfLove.Gameplay.SpawnableActor::get_TransformOffset()
IL_0183: ldloc.s V_9
IL_0185: ldfld UnityEngine.Vector3 TheForestOfLove.TransformOffset::offset
IL_018a: stfld UnityEngine.Vector3 TheForestOfLove.TransformOffset::offset
IL_018f: ldloc.s V_7
IL_0191: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_0196: ldloc.s V_8
IL_0198: callvirt UnityEngine.Transform TheForestOfLove.ForestMouseSpawnPointRandomizer::GetSpawnPoint()
IL_019d: callvirt UnityEngine.Vector3 UnityEngine.Transform::get_position()
IL_01a2: ldloc.s V_7
IL_01a4: callvirt UnityEngine.Vector3 TheForestOfLove.Gameplay.SpawnableActor::get_TransformBaseOffset()
IL_01a9: call UnityEngine.Vector3 UnityEngine.Vector3::op_Subtraction(UnityEngine.Vector3,UnityEngine.Vector3)
IL_01ae: callvirt System.Void UnityEngine.Transform::set_position(UnityEngine.Vector3)
IL_01b3: ldloc.s V_7
IL_01b5: ldloc.s V_8
IL_01b7: callvirt TheForestOfLove.Direction TheForestOfLove.ForestMouseSpawnPointRandomizer::GetSpawnDirection()
IL_01bc: callvirt System.Void TheForestOfLove.Gameplay.SpawnableActor::SetDefaultDirection(TheForestOfLove.Direction)
IL_01c1: ldloc.s V_6
IL_01c3: ldc.i4.1
IL_01c4: add
IL_01c5: stloc.s V_6
IL_01c7: ldloc.s V_6
IL_01c9: ldloc.2
IL_01ca: blt IL_0140
IL_01cf: ret
