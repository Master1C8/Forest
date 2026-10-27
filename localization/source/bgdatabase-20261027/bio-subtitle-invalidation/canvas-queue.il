TYPE UnityEngine.UI.CanvasUpdateRegistry
METHOD UnityEngine.UI.CanvasUpdateRegistry UnityEngine.UI.CanvasUpdateRegistry::get_instance() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: ldsfld UnityEngine.UI.CanvasUpdateRegistry UnityEngine.UI.CanvasUpdateRegistry::s_Instance
IL_0005: brtrue.s IL_0011
IL_0007: newobj System.Void UnityEngine.UI.CanvasUpdateRegistry::.ctor()
IL_000c: stsfld UnityEngine.UI.CanvasUpdateRegistry UnityEngine.UI.CanvasUpdateRegistry::s_Instance
IL_0011: ldsfld UnityEngine.UI.CanvasUpdateRegistry UnityEngine.UI.CanvasUpdateRegistry::s_Instance
IL_0016: ret
METHOD System.Boolean UnityEngine.UI.CanvasUpdateRegistry::InternalRegisterCanvasElementForGraphicRebuild(UnityEngine.UI.ICanvasElement) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Boolean UnityEngine.UI.CanvasUpdateRegistry::m_PerformingGraphicUpdate
IL_0006: brfalse.s IL_001a
IL_0008: ldstr "Trying to add {0} for graphic rebuild while we are already inside a graphic rebuild loop. This is not supported."
IL_000d: ldarg.1
IL_000e: call System.String System.String::Format(System.String,System.Object)
IL_0013: call System.Void UnityEngine.Debug::LogError(System.Object)
IL_0018: ldc.i4.0
IL_0019: ret
IL_001a: ldarg.0
IL_001b: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_GraphicRebuildQueue
IL_0020: ldarg.1
IL_0021: callvirt System.Boolean UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::AddUnique(T)
IL_0026: ret
