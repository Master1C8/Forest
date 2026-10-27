TYPE TMPro.TMP_FontAsset
METHOD System.Void TMPro.TMP_FontAsset::SetupNewAtlasTexture() | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasTextureIndex
IL_0007: ldc.i4.1
IL_0008: add
IL_0009: stfld System.Int32 TMPro.TMP_FontAsset::m_AtlasTextureIndex
IL_000e: ldarg.0
IL_000f: ldfld UnityEngine.Texture2D[] TMPro.TMP_FontAsset::m_AtlasTextures
IL_0014: ldlen
IL_0015: conv.i4
IL_0016: ldarg.0
IL_0017: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasTextureIndex
IL_001c: bne.un.s IL_0033
IL_001e: ldarg.0
IL_001f: ldflda UnityEngine.Texture2D[] TMPro.TMP_FontAsset::m_AtlasTextures
IL_0024: ldarg.0
IL_0025: ldfld UnityEngine.Texture2D[] TMPro.TMP_FontAsset::m_AtlasTextures
IL_002a: ldlen
IL_002b: conv.i4
IL_002c: ldc.i4.2
IL_002d: mul
IL_002e: call System.Void System.Array::Resize<UnityEngine.Texture2D>(!!0[]&,System.Int32)
IL_0033: ldarg.0
IL_0034: ldfld UnityEngine.Texture2D[] TMPro.TMP_FontAsset::m_AtlasTextures
IL_0039: ldarg.0
IL_003a: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasTextureIndex
IL_003f: ldarg.0
IL_0040: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasWidth
IL_0045: ldarg.0
IL_0046: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasHeight
IL_004b: ldc.i4.1
IL_004c: ldc.i4.0
IL_004d: newobj System.Void UnityEngine.Texture2D::.ctor(System.Int32,System.Int32,UnityEngine.TextureFormat,System.Boolean)
IL_0052: stelem.ref
IL_0053: ldarg.0
IL_0054: ldfld UnityEngine.Texture2D[] TMPro.TMP_FontAsset::m_AtlasTextures
IL_0059: ldarg.0
IL_005a: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasTextureIndex
IL_005f: ldelem.ref
IL_0060: call System.Void UnityEngine.TextCore.LowLevel.FontEngine::ResetAtlasTexture(UnityEngine.Texture2D)
IL_0065: ldarg.0
IL_0066: ldfld UnityEngine.TextCore.LowLevel.GlyphRenderMode TMPro.TMP_FontAsset::m_AtlasRenderMode
IL_006b: ldc.i4.s 16
IL_006d: and
IL_006e: ldc.i4.s 16
IL_0070: beq.s IL_0075
IL_0072: ldc.i4.1
IL_0073: br.s IL_0076
IL_0075: ldc.i4.0
IL_0076: stloc.0
IL_0077: ldarg.0
IL_0078: ldfld System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect> TMPro.TMP_FontAsset::m_FreeGlyphRects
IL_007d: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect>::Clear()
IL_0082: ldarg.0
IL_0083: ldfld System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect> TMPro.TMP_FontAsset::m_FreeGlyphRects
IL_0088: ldc.i4.0
IL_0089: ldc.i4.0
IL_008a: ldarg.0
IL_008b: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasWidth
IL_0090: ldloc.0
IL_0091: sub
IL_0092: ldarg.0
IL_0093: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasHeight
IL_0098: ldloc.0
IL_0099: sub
IL_009a: newobj System.Void UnityEngine.TextCore.GlyphRect::.ctor(System.Int32,System.Int32,System.Int32,System.Int32)
IL_009f: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect>::Add(!0)
IL_00a4: ldarg.0
IL_00a5: ldfld System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect> TMPro.TMP_FontAsset::m_UsedGlyphRects
IL_00aa: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect>::Clear()
IL_00af: ret
