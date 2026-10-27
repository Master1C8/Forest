TYPE UnityEngine.CanvasRenderer
METHOD System.Void UnityEngine.CanvasRenderer::set_materialCount(System.Int32) | attributes=Public, HideBySig, SpecialName | impl=InternalCall
METHOD System.Void UnityEngine.CanvasRenderer::SetMaterial(UnityEngine.Material,System.Int32) | attributes=Public, HideBySig | impl=InternalCall
METHOD System.Void UnityEngine.CanvasRenderer::SetMaterial(UnityEngine.Material,UnityEngine.Texture) | attributes=Public, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldc.i4.1
IL_0003: ldarg.0
IL_0004: call System.Int32 UnityEngine.CanvasRenderer::get_materialCount()
IL_0009: call System.Int32 System.Math::Max(System.Int32,System.Int32)
IL_000e: call System.Void UnityEngine.CanvasRenderer::set_materialCount(System.Int32)
IL_0013: nop
IL_0014: ldarg.0
IL_0015: ldarg.1
IL_0016: ldc.i4.0
IL_0017: call System.Void UnityEngine.CanvasRenderer::SetMaterial(UnityEngine.Material,System.Int32)
IL_001c: nop
IL_001d: ldarg.0
IL_001e: ldarg.2
IL_001f: call System.Void UnityEngine.CanvasRenderer::SetTexture(UnityEngine.Texture)
IL_0024: nop
IL_0025: ret
