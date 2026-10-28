TYPE TheForestOfLove.Core.SceneSetup.PrefabDropperSingletonsDestroyer
METHOD System.Void TheForestOfLove.Core.SceneSetup.PrefabDropperSingletonsDestroyer::DestroyGameObjects() | attributes=Family, Virtual, HideBySig, VtableLayoutMask | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.String TheForestOfLove.Core.SceneSetup.PrefabDropperSingletonsDestroyer::customContainerName
IL_0006: call System.Boolean System.String::IsNullOrWhiteSpace(System.String)
IL_000b: brfalse.s IL_0010
IL_000d: ldnull
IL_000e: br.s IL_0016
IL_0010: ldarg.0
IL_0011: ldfld System.String TheForestOfLove.Core.SceneSetup.PrefabDropperSingletonsDestroyer::customContainerName
IL_0016: stloc.0
IL_0017: ldloc.0
IL_0018: dup
IL_0019: brtrue.s IL_0021
IL_001b: pop
IL_001c: ldstr "Singletons"
IL_0021: stloc.0
IL_0022: ldloc.0
IL_0023: brtrue.s IL_0028
IL_0025: ldnull
IL_0026: br.s IL_002e
IL_0028: ldloc.0
IL_0029: call UnityEngine.GameObject UnityEngine.GameObject::Find(System.String)
IL_002e: stloc.1
IL_002f: ldloc.1
IL_0030: ldnull
IL_0031: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0036: brfalse.s IL_00a1
IL_0038: ldloc.1
IL_0039: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_003e: callvirt !!0[] UnityEngine.Component::GetComponentsInChildren<TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstance>()
IL_0043: ldc.i4.0
IL_0044: stloc.2
IL_0045: ldloc.1
IL_0046: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_004b: callvirt System.Int32 UnityEngine.Transform::get_childCount()
IL_0050: stloc.3
IL_0051: stloc.s V_4
IL_0053: ldc.i4.0
IL_0054: stloc.s V_5
IL_0056: br.s IL_0089
IL_0058: ldloc.s V_4
IL_005a: ldloc.s V_5
IL_005c: ldelem.ref
IL_005d: stloc.s V_6
IL_005f: ldloc.s V_6
IL_0061: ldfld System.String TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstance::groupName
IL_0066: ldarg.0
IL_0067: ldfld System.String TheForestOfLove.Core.SceneSetup.PrefabDropperSingletonsDestroyer::managedGroupName
IL_006c: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_0071: brfalse.s IL_0083
IL_0073: ldloc.s V_6
IL_0075: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_007a: call System.Void UnityEngine.Object::DestroyImmediate(UnityEngine.Object)
IL_007f: ldloc.2
IL_0080: ldc.i4.1
IL_0081: add
IL_0082: stloc.2
IL_0083: ldloc.s V_5
IL_0085: ldc.i4.1
IL_0086: add
IL_0087: stloc.s V_5
IL_0089: ldloc.s V_5
IL_008b: ldloc.s V_4
IL_008d: ldlen
IL_008e: conv.i4
IL_008f: blt.s IL_0058
IL_0091: ldloc.3
IL_0092: ldloc.2
IL_0093: bne.un.s IL_00f1
IL_0095: ldloc.1
IL_0096: callvirt UnityEngine.GameObject UnityEngine.GameObject::get_gameObject()
IL_009b: call System.Void UnityEngine.Object::DestroyImmediate(UnityEngine.Object)
IL_00a0: ret
IL_00a1: ldtoken TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstance
IL_00a6: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_00ab: call UnityEngine.Object[] UnityEngine.Object::FindObjectsOfType(System.Type)
IL_00b0: isinst TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstance[]
IL_00b5: stloc.s V_4
IL_00b7: ldc.i4.0
IL_00b8: stloc.s V_5
IL_00ba: br.s IL_00e9
IL_00bc: ldloc.s V_4
IL_00be: ldloc.s V_5
IL_00c0: ldelem.ref
IL_00c1: stloc.s V_7
IL_00c3: ldloc.s V_7
IL_00c5: ldfld System.String TheForestOfLove.Core.SceneSetup.PrefabDropperManagedInstance::groupName
IL_00ca: ldarg.0
IL_00cb: ldfld System.String TheForestOfLove.Core.SceneSetup.PrefabDropperSingletonsDestroyer::managedGroupName
IL_00d0: call System.Boolean System.String::op_Equality(System.String,System.String)
IL_00d5: brfalse.s IL_00e3
IL_00d7: ldloc.s V_7
IL_00d9: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00de: call System.Void UnityEngine.Object::DestroyImmediate(UnityEngine.Object)
IL_00e3: ldloc.s V_5
IL_00e5: ldc.i4.1
IL_00e6: add
IL_00e7: stloc.s V_5
IL_00e9: ldloc.s V_5
IL_00eb: ldloc.s V_4
IL_00ed: ldlen
IL_00ee: conv.i4
IL_00ef: blt.s IL_00bc
IL_00f1: ret
