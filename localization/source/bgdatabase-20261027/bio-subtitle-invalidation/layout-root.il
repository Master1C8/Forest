TYPE UnityEngine.UI.LayoutRebuilder
METHOD System.Void UnityEngine.UI.LayoutRebuilder::MarkLayoutRootForRebuild(UnityEngine.RectTransform) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldnull
IL_0002: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_0007: brfalse.s IL_000a
IL_0009: ret
IL_000a: ldsfld UnityEngine.UI.ObjectPool`1<UnityEngine.UI.LayoutRebuilder> UnityEngine.UI.LayoutRebuilder::s_Rebuilders
IL_000f: callvirt T UnityEngine.UI.ObjectPool`1<UnityEngine.UI.LayoutRebuilder>::Get()
IL_0014: stloc.0
IL_0015: ldloc.0
IL_0016: ldarg.0
IL_0017: callvirt System.Void UnityEngine.UI.LayoutRebuilder::Initialize(UnityEngine.RectTransform)
IL_001c: ldloc.0
IL_001d: call System.Boolean UnityEngine.UI.CanvasUpdateRegistry::TryRegisterCanvasElementForLayoutRebuild(UnityEngine.UI.ICanvasElement)
IL_0022: brtrue.s IL_002f
IL_0024: ldsfld UnityEngine.UI.ObjectPool`1<UnityEngine.UI.LayoutRebuilder> UnityEngine.UI.LayoutRebuilder::s_Rebuilders
IL_0029: ldloc.0
IL_002a: callvirt System.Void UnityEngine.UI.ObjectPool`1<UnityEngine.UI.LayoutRebuilder>::Release(T)
IL_002f: ret
