TYPE UnityEngine.Canvas
METHOD System.Void UnityEngine.Canvas::add_willRenderCanvases(UnityEngine.Canvas/WillRenderCanvases) | attributes=Public, Static, HideBySig, SpecialName | impl=IL
ATTRIBUTE System.Runtime.CompilerServices.CompilerGeneratedAttribute
IL_0000: ldsfld UnityEngine.Canvas/WillRenderCanvases UnityEngine.Canvas::willRenderCanvases
IL_0005: stloc.0
IL_0006: ldloc.0
IL_0007: stloc.1
IL_0008: ldloc.1
IL_0009: ldarg.0
IL_000a: call System.Delegate System.Delegate::Combine(System.Delegate,System.Delegate)
IL_000f: castclass UnityEngine.Canvas/WillRenderCanvases
IL_0014: stloc.2
IL_0015: ldsflda UnityEngine.Canvas/WillRenderCanvases UnityEngine.Canvas::willRenderCanvases
IL_001a: ldloc.2
IL_001b: ldloc.1
IL_001c: call !!0 System.Threading.Interlocked::CompareExchange<UnityEngine.Canvas/WillRenderCanvases>(!!0&,!!0,!!0)
IL_0021: stloc.0
IL_0022: ldloc.0
IL_0023: ldloc.1
IL_0024: bne.un.s IL_0006
IL_0026: ret
