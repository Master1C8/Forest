TYPE TMPro.TMP_FontAsset
METHOD System.Void TMPro.TMP_FontAsset::AddSynthesizedCharacter(System.UInt32,System.Boolean,System.Boolean) | attributes=Private, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterLookupDictionary
IL_0006: ldarg.1
IL_0007: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character>::ContainsKey(!0)
IL_000c: brfalse.s IL_000f
IL_000e: ret
IL_000f: ldarg.2
IL_0010: brfalse.s IL_004f
IL_0012: ldarg.1
IL_0013: call System.UInt32 UnityEngine.TextCore.LowLevel.FontEngine::GetGlyphIndex(System.UInt32)
IL_0018: brfalse.s IL_004f
IL_001a: ldarg.3
IL_001b: brtrue.s IL_001e
IL_001d: ret
IL_001e: ldarg.0
IL_001f: ldfld UnityEngine.TextCore.LowLevel.GlyphRenderMode TMPro.TMP_FontAsset::m_AtlasRenderMode
IL_0024: ldc.i4.4
IL_0025: and
IL_0026: ldc.i4.4
IL_0027: beq.s IL_002c
IL_0029: ldc.i4.8
IL_002a: br.s IL_002e
IL_002c: ldc.i4.s 10
IL_002e: stloc.1
IL_002f: ldarg.1
IL_0030: ldloc.1
IL_0031: ldloca.s V_0
IL_0033: call System.Boolean UnityEngine.TextCore.LowLevel.FontEngine::TryGetGlyphWithUnicodeValue(System.UInt32,UnityEngine.TextCore.LowLevel.GlyphLoadFlags,UnityEngine.TextCore.Glyph&)
IL_0038: brfalse.s IL_004e
IL_003a: ldarg.0
IL_003b: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterLookupDictionary
IL_0040: ldarg.1
IL_0041: ldarg.1
IL_0042: ldarg.0
IL_0043: ldloc.0
IL_0044: newobj System.Void TMPro.TMP_Character::.ctor(System.UInt32,TMPro.TMP_FontAsset,UnityEngine.TextCore.Glyph)
IL_0049: callvirt System.Void System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character>::Add(!0,!1)
IL_004e: ret
IL_004f: ldc.i4.0
IL_0050: ldc.r4 0
IL_0055: ldc.r4 0
IL_005a: ldc.r4 0
IL_005f: ldc.r4 0
IL_0064: ldc.r4 0
IL_0069: newobj System.Void UnityEngine.TextCore.GlyphMetrics::.ctor(System.Single,System.Single,System.Single,System.Single,System.Single)
IL_006e: call UnityEngine.TextCore.GlyphRect UnityEngine.TextCore.GlyphRect::get_zero()
IL_0073: ldc.r4 1
IL_0078: ldc.i4.0
IL_0079: newobj System.Void UnityEngine.TextCore.Glyph::.ctor(System.UInt32,UnityEngine.TextCore.GlyphMetrics,UnityEngine.TextCore.GlyphRect,System.Single,System.Int32)
IL_007e: stloc.0
IL_007f: ldarg.0
IL_0080: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterLookupDictionary
IL_0085: ldarg.1
IL_0086: ldarg.1
IL_0087: ldarg.0
IL_0088: ldloc.0
IL_0089: newobj System.Void TMPro.TMP_Character::.ctor(System.UInt32,TMPro.TMP_FontAsset,UnityEngine.TextCore.Glyph)
IL_008e: callvirt System.Void System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character>::Add(!0,!1)
IL_0093: ret
TYPE UnityEngine.TextCore.Glyph
METHOD UnityEngine.TextCore.GlyphMetrics UnityEngine.TextCore.Glyph::get_metrics() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldfld UnityEngine.TextCore.GlyphMetrics UnityEngine.TextCore.Glyph::m_Metrics
IL_0007: stloc.0
IL_0008: br.s IL_000a
IL_000a: ldloc.0
IL_000b: ret
TYPE UnityEngine.TextCore.GlyphMetrics
METHOD System.Single UnityEngine.TextCore.GlyphMetrics::get_horizontalBearingY() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldfld System.Single UnityEngine.TextCore.GlyphMetrics::m_HorizontalBearingY
IL_0007: stloc.0
IL_0008: br.s IL_000a
IL_000a: ldloc.0
IL_000b: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Void UnityEngine.TextCore.FaceInfo::set_capLine(System.Single) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Single UnityEngine.TextCore.FaceInfo::m_CapLine
IL_0008: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Single UnityEngine.TextCore.FaceInfo::get_meanLine() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldfld System.Single UnityEngine.TextCore.FaceInfo::m_MeanLine
IL_0007: stloc.0
IL_0008: br.s IL_000a
IL_000a: ldloc.0
IL_000b: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Void UnityEngine.TextCore.FaceInfo::set_meanLine(System.Single) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Single UnityEngine.TextCore.FaceInfo::m_MeanLine
IL_0008: ret
