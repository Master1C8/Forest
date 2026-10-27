TYPE UnityEngine.UI.CanvasUpdateRegistry
METHOD System.Boolean UnityEngine.UI.CanvasUpdateRegistry::InternalRegisterCanvasElementForLayoutRebuild(UnityEngine.UI.ICanvasElement) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_LayoutRebuildQueue
IL_0006: ldarg.1
IL_0007: callvirt System.Boolean UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::Contains(T)
IL_000c: brfalse.s IL_0010
IL_000e: ldc.i4.0
IL_000f: ret
IL_0010: ldarg.0
IL_0011: ldfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_LayoutRebuildQueue
IL_0016: ldarg.1
IL_0017: callvirt System.Boolean UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::AddUnique(T)
IL_001c: ret
