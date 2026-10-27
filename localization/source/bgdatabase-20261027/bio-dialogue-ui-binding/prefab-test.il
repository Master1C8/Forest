TYPE PixelCrushers.DialogueSystem.Tools
METHOD System.Boolean PixelCrushers.DialogueSystem.Tools::IsPrefab(UnityEngine.GameObject) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0007: brfalse.s IL_000b
IL_0009: ldc.i4.0
IL_000a: ret
IL_000b: ldarg.0
IL_000c: callvirt System.Boolean UnityEngine.GameObject::get_activeInHierarchy()
IL_0011: brfalse.s IL_0015
IL_0013: ldc.i4.0
IL_0014: ret
IL_0015: ldarg.0
IL_0016: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_001b: callvirt UnityEngine.Transform UnityEngine.Transform::get_parent()
IL_0020: ldnull
IL_0021: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0026: brfalse.s IL_0041
IL_0028: ldarg.0
IL_0029: callvirt UnityEngine.Transform UnityEngine.GameObject::get_transform()
IL_002e: callvirt UnityEngine.Transform UnityEngine.Transform::get_parent()
IL_0033: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_0038: callvirt System.Boolean UnityEngine.GameObject::get_activeSelf()
IL_003d: brfalse.s IL_0041
IL_003f: ldc.i4.0
IL_0040: ret
IL_0041: call !!0[] UnityEngine.Object::FindObjectsOfType<UnityEngine.GameObject>()
IL_0046: stloc.0
IL_0047: ldc.i4.0
IL_0048: stloc.1
IL_0049: br.s IL_005c
IL_004b: ldloc.0
IL_004c: ldloc.1
IL_004d: ldelem.ref
IL_004e: ldarg.0
IL_004f: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0054: brfalse.s IL_0058
IL_0056: ldc.i4.0
IL_0057: ret
IL_0058: ldloc.1
IL_0059: ldc.i4.1
IL_005a: add
IL_005b: stloc.1
IL_005c: ldloc.1
IL_005d: ldloc.0
IL_005e: ldlen
IL_005f: conv.i4
IL_0060: blt.s IL_004b
IL_0062: ldc.i4.1
IL_0063: ret
