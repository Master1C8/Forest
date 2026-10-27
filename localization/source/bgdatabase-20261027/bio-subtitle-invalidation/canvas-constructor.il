TYPE UnityEngine.UI.CanvasUpdateRegistry
METHOD System.Void UnityEngine.UI.CanvasUpdateRegistry::.ctor() | attributes=Family, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4.5
IL_0002: newarr System.String
IL_0007: dup
IL_0008: ldc.i4.0
IL_0009: ldstr "CanvasUpdate.Prelayout"
IL_000e: stelem.ref
IL_000f: dup
IL_0010: ldc.i4.1
IL_0011: ldstr "CanvasUpdate.Layout"
IL_0016: stelem.ref
IL_0017: dup
IL_0018: ldc.i4.2
IL_0019: ldstr "CanvasUpdate.PostLayout"
IL_001e: stelem.ref
IL_001f: dup
IL_0020: ldc.i4.3
IL_0021: ldstr "CanvasUpdate.PreRender"
IL_0026: stelem.ref
IL_0027: dup
IL_0028: ldc.i4.4
IL_0029: ldstr "CanvasUpdate.LatePreRender"
IL_002e: stelem.ref
IL_002f: stfld System.String[] UnityEngine.UI.CanvasUpdateRegistry::m_CanvasUpdateProfilerStrings
IL_0034: ldarg.0
IL_0035: newobj System.Void UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::.ctor()
IL_003a: stfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_LayoutRebuildQueue
IL_003f: ldarg.0
IL_0040: newobj System.Void UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement>::.ctor()
IL_0045: stfld UnityEngine.UI.Collections.IndexedSet`1<UnityEngine.UI.ICanvasElement> UnityEngine.UI.CanvasUpdateRegistry::m_GraphicRebuildQueue
IL_004a: ldarg.0
IL_004b: call System.Void System.Object::.ctor()
IL_0050: ldarg.0
IL_0051: ldftn System.Void UnityEngine.UI.CanvasUpdateRegistry::PerformUpdate()
IL_0057: newobj System.Void UnityEngine.Canvas/WillRenderCanvases::.ctor(System.Object,System.IntPtr)
IL_005c: call System.Void UnityEngine.Canvas::add_willRenderCanvases(UnityEngine.Canvas/WillRenderCanvases)
IL_0061: ret
