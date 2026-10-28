TYPE TheForestOfLove.Core.SceneSetup.PrefabDropper
METHOD System.Void TheForestOfLove.Core.SceneSetup.PrefabDropper::DropPrefabs() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String TheForestOfLove.Core.SceneSetup.PrefabDropper::containerName
IL_0006: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_000b: brfalse.s IL_0010
IL_000d: ldnull
IL_000e: br.s IL_0016
IL_0010: ldarg.0
IL_0011: ldfld System.String TheForestOfLove.Core.SceneSetup.PrefabDropper::containerName
IL_0016: stloc.0
IL_0017: ldarg.0
IL_0018: ldfld TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstanceType TheForestOfLove.Core.SceneSetup.PrefabDropper::managedType
IL_001d: ldc.i4 200
IL_0022: bne.un.s IL_0030
IL_0024: ldloc.0
IL_0025: brtrue.s IL_002e
IL_0027: ldstr "Singletons"
IL_002c: br.s IL_002f
IL_002e: ldloc.0
IL_002f: stloc.0
IL_0030: ldloc.0
IL_0031: brtrue.s IL_0036
IL_0033: ldnull
IL_0034: br.s IL_003c
IL_0036: ldloc.0
IL_0037: call UnityEngine.GameObject UnityEngine.GameObject::Find(System.String)
IL_003c: stloc.1
IL_003d: ldloc.0
IL_003e: brfalse.s IL_0069
IL_0040: ldloc.1
IL_0041: ldnull
IL_0042: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0047: brfalse.s IL_0069
IL_0049: newobj System.Void UnityEngine.GameObject::.ctor()
IL_004e: stloc.1
IL_004f: ldloc.1
IL_0050: ldloc.0
IL_0051: callvirt System.Void UnityEngine.Object::set_name(System.String)
IL_0056: ldarg.0
IL_0057: ldfld TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstanceType TheForestOfLove.Core.SceneSetup.PrefabDropper::managedType
IL_005c: ldc.i4 200
IL_0061: bne.un.s IL_0069
IL_0063: ldloc.1
IL_0064: call System.Void UnityEngine.Object::DontDestroyOnLoad(UnityEngine.Object)
IL_0069: call !!0[] UnityEngine.Object::FindObjectsOfType<TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstance>()
IL_006e: stloc.2
IL_006f: ldarg.0
IL_0070: ldfld UnityEngine.GameObject[] TheForestOfLove.Core.SceneSetup.PrefabDropper::prefabs
IL_0075: stloc.3
IL_0076: ldc.i4.0
IL_0077: stloc.s V_4
IL_0079: br IL_0180
IL_007e: ldloc.3
IL_007f: ldloc.s V_4
IL_0081: ldelem.ref
IL_0082: stloc.s V_5
IL_0084: ldloc.s V_5
IL_0086: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<TheForestOfLove.Core.SceneSetup.IPrefabDropperSpawnCondition>()
IL_008b: dup
IL_008c: ldlen
IL_008d: ldc.i4.0
IL_008e: ceq
IL_0090: stloc.s V_6
IL_0092: stloc.s V_7
IL_0094: ldc.i4.0
IL_0095: stloc.s V_8
IL_0097: br.s IL_00b0
IL_0099: ldloc.s V_7
IL_009b: ldloc.s V_8
IL_009d: ldelem.ref
IL_009e: callvirt System.Boolean TheForestOfLove.Core.SceneSetup.IPrefabDropperSpawnCondition::CanSpawn()
IL_00a3: brfalse.s IL_00aa
IL_00a5: ldc.i4.1
IL_00a6: stloc.s V_6
IL_00a8: br.s IL_00b8
IL_00aa: ldloc.s V_8
IL_00ac: ldc.i4.1
IL_00ad: add
IL_00ae: stloc.s V_8
IL_00b0: ldloc.s V_8
IL_00b2: ldloc.s V_7
IL_00b4: ldlen
IL_00b5: conv.i4
IL_00b6: blt.s IL_0099
IL_00b8: ldloc.s V_6
IL_00ba: brfalse IL_017a
IL_00bf: ldarg.0
IL_00c0: ldloc.2
IL_00c1: ldloc.s V_5
IL_00c3: call TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstance TheForestOfLove.Core.SceneSetup.PrefabDropper::FindExistingInstanceByNameAndGroup(System.Collections.Generic.IEnumerable`1<TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstance>,UnityEngine.GameObject)
IL_00c8: ldnull
IL_00c9: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00ce: brfalse IL_017a
IL_00d3: ldloc.1
IL_00d4: ldnull
IL_00d5: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00da: brtrue.s IL_00eb
IL_00dc: ldarg.0
IL_00dd: ldfld TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstanceType TheForestOfLove.Core.SceneSetup.PrefabDropper::managedType
IL_00e2: ldc.i4 300
IL_00e7: ceq
IL_00e9: br.s IL_00ec
IL_00eb: ldc.i4.1
IL_00ec: stloc.s V_9
IL_00ee: ldnull
IL_00ef: stloc.s V_10
IL_00f1: ldarg.0
IL_00f2: ldfld TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstanceType TheForestOfLove.Core.SceneSetup.PrefabDropper::managedType
IL_00f7: ldc.i4.s 100
IL_00f9: bne.un.s IL_0106
IL_00fb: ldloc.s V_5
IL_00fd: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0)
IL_0102: stloc.s V_10
IL_0104: br.s IL_0121
IL_0106: ldloc.s V_5
IL_0108: ldloc.s V_9
IL_010a: brtrue.s IL_0114
IL_010c: ldloc.1
IL_010d: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_0112: br.s IL_011a
IL_0114: ldarg.0
IL_0115: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_011a: call !!0 UnityEngine.Object::Instantiate<UnityEngine.GameObject>(!!0,UnityEngine.Transform)
IL_011f: stloc.s V_10
IL_0121: ldloc.s V_9
IL_0123: brfalse.s IL_0132
IL_0125: ldloc.s V_10
IL_0127: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_012c: ldnull
IL_012d: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform)
IL_0132: ldloc.s V_10
IL_0134: callvirt !!0 UnityEngine.GameObject::GetComponent<TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstance>()
IL_0139: stloc.s V_11
IL_013b: ldloc.s V_11
IL_013d: ldnull
IL_013e: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0143: brtrue.s IL_014e
IL_0145: ldloc.s V_10
IL_0147: callvirt !!0 UnityEngine.GameObject::AddComponent<TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstance>()
IL_014c: br.s IL_0150
IL_014e: ldloc.s V_11
IL_0150: stloc.s V_11
IL_0152: ldloc.s V_11
IL_0154: ldarg.0
IL_0155: ldfld TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstanceType TheForestOfLove.Core.SceneSetup.PrefabDropper::managedType
IL_015a: stfld TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstanceType TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstance::managedType
IL_015f: ldloc.s V_11
IL_0161: ldarg.0
IL_0162: ldfld System.String TheForestOfLove.Core.SceneSetup.PrefabDropper::groupName
IL_0167: stfld System.String TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstance::groupName
IL_016c: ldloc.s V_11
IL_016e: ldloc.s V_5
IL_0170: callvirt System.String UnityEngine.Object::get_name()
IL_0175: stfld System.String TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstance::sourcePrefabName
IL_017a: ldloc.s V_4
IL_017c: ldc.i4.1
IL_017d: add
IL_017e: stloc.s V_4
IL_0180: ldloc.s V_4
IL_0182: ldloc.3
IL_0183: ldlen
IL_0184: conv.i4
IL_0185: blt IL_007e
IL_018a: ldloc.1
IL_018b: ldnull
IL_018c: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0191: brfalse.s IL_01f8
IL_0193: ldloc.1
IL_0194: callvirt !!0[] UnityEngine.GameObject::GetComponentsInChildren<TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstance>()
IL_0199: stloc.s V_12
IL_019b: ldc.i4.0
IL_019c: stloc.s V_4
IL_019e: br.s IL_01f0
IL_01a0: ldloc.s V_12
IL_01a2: ldloc.s V_4
IL_01a4: ldelem.ref
IL_01a5: stloc.s V_13
IL_01a7: ldarg.0
IL_01a8: ldnull
IL_01a9: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_01ae: brfalse.s IL_01ea
IL_01b0: ldloc.s V_13
IL_01b2: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_01b7: callvirt UnityEngine.Transform UnityEngine.Transform::get_parent()
IL_01bc: ldarg.0
IL_01bd: call UnityEngine.Transform UnityEngine.Component::get_transform()
IL_01c2: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_01c7: brfalse.s IL_01ea
IL_01c9: ldloc.s V_13
IL_01cb: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_01d0: ldnull
IL_01d1: ldc.i4.0
IL_01d2: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform,System.Boolean)
IL_01d7: ldloc.s V_13
IL_01d9: callvirt UnityEngine.Transform UnityEngine.Component::get_transform()
IL_01de: ldloc.1
IL_01df: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_01e4: ldc.i4.0
IL_01e5: callvirt System.Void UnityEngine.Transform::SetParent(UnityEngine.Transform,System.Boolean)
IL_01ea: ldloc.s V_4
IL_01ec: ldc.i4.1
IL_01ed: add
IL_01ee: stloc.s V_4
IL_01f0: ldloc.s V_4
IL_01f2: ldloc.s V_12
IL_01f4: ldlen
IL_01f5: conv.i4
IL_01f6: blt.s IL_01a0
IL_01f8: ret
