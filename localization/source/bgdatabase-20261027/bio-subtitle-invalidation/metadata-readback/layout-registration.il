TYPE UnityEngine.UI.LayoutRebuilder
METHOD System.Void UnityEngine.UI.LayoutRebuilder::MarkLayoutForRebuild(UnityEngine.RectTransform) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0007: brtrue.s IL_0017
IL_0009: ldarg.0
IL_000a: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_000f: ldnull
IL_0010: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0015: brfalse.s IL_0018
IL_0017: ret
IL_0018: call System.Collections.Generic.List`1<T> UnityEngine.UI.ListPool`1<UnityEngine.Component>::Get()
IL_001d: stloc.0
IL_001e: ldc.i4.1
IL_001f: stloc.1
IL_0020: ldarg.0
IL_0021: stloc.2
IL_0022: ldloc.2
IL_0023: callvirt UnityEngine.Transform UnityEngine.Transform::get_parent()
IL_0028: isinst UnityEngine.RectTransform
IL_002d: stloc.3
IL_002e: br.s IL_0095
IL_0030: ldc.i4.0
IL_0031: stloc.1
IL_0032: ldloc.3
IL_0033: ldtoken UnityEngine.UI.ILayoutGroup
IL_0038: call System.Type System.Type::GetTypeFromHandle(System.RuntimeTypeHandle)
IL_003d: ldloc.0
IL_003e: callvirt System.Void UnityEngine.Component::GetComponents(System.Type,System.Collections.Generic.List`1<UnityEngine.Component>)
IL_0043: ldc.i4.0
IL_0044: stloc.s V_4
IL_0046: br.s IL_007f
IL_0048: ldloc.0
IL_0049: ldloc.s V_4
IL_004b: callvirt !0 System.Collections.Generic.List`1<UnityEngine.Component>::get_Item(System.Int32)
IL_0050: stloc.s V_5
IL_0052: ldloc.s V_5
IL_0054: ldnull
IL_0055: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_005a: brfalse.s IL_0079
IL_005c: ldloc.s V_5
IL_005e: isinst UnityEngine.Behaviour
IL_0063: brfalse.s IL_0079
IL_0065: ldloc.s V_5
IL_0067: castclass UnityEngine.Behaviour
IL_006c: callvirt System.Boolean UnityEngine.Behaviour::get_isActiveAndEnabled()
IL_0071: brfalse.s IL_0079
IL_0073: ldc.i4.1
IL_0074: stloc.1
IL_0075: ldloc.3
IL_0076: stloc.2
IL_0077: br.s IL_0089
IL_0079: ldloc.s V_4
IL_007b: ldc.i4.1
IL_007c: add
IL_007d: stloc.s V_4
IL_007f: ldloc.s V_4
IL_0081: ldloc.0
IL_0082: callvirt System.Int32 System.Collections.Generic.List`1<UnityEngine.Component>::get_Count()
IL_0087: blt.s IL_0048
IL_0089: ldloc.3
IL_008a: callvirt UnityEngine.Transform UnityEngine.Transform::get_parent()
IL_008f: isinst UnityEngine.RectTransform
IL_0094: stloc.3
IL_0095: ldloc.1
IL_0096: brfalse.s IL_00af
IL_0098: ldloc.3
IL_0099: ldnull
IL_009a: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_009f: brtrue.s IL_00af
IL_00a1: ldloc.3
IL_00a2: callvirt UnityEngine.GameObject UnityEngine.Component::get_gameObject()
IL_00a7: ldnull
IL_00a8: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00ad: brfalse.s IL_0030
IL_00af: ldloc.2
IL_00b0: ldarg.0
IL_00b1: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_00b6: brfalse.s IL_00c8
IL_00b8: ldloc.2
IL_00b9: ldloc.0
IL_00ba: call System.Boolean UnityEngine.UI.LayoutRebuilder::ValidController(UnityEngine.RectTransform,System.Collections.Generic.List`1<UnityEngine.Component>)
IL_00bf: brtrue.s IL_00c8
IL_00c1: ldloc.0
IL_00c2: call System.Void UnityEngine.UI.ListPool`1<UnityEngine.Component>::Release(System.Collections.Generic.List`1<T>)
IL_00c7: ret
IL_00c8: ldloc.2
IL_00c9: call System.Void UnityEngine.UI.LayoutRebuilder::MarkLayoutRootForRebuild(UnityEngine.RectTransform)
IL_00ce: ldloc.0
IL_00cf: call System.Void UnityEngine.UI.ListPool`1<UnityEngine.Component>::Release(System.Collections.Generic.List`1<T>)
IL_00d4: ret
