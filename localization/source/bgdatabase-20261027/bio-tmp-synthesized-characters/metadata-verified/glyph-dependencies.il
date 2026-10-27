TYPE UnityEngine.TextCore.LowLevel.FontEngine
METHOD System.Boolean UnityEngine.TextCore.LowLevel.FontEngine::TryGetGlyphWithUnicodeValue(System.UInt32,UnityEngine.TextCore.LowLevel.GlyphLoadFlags,UnityEngine.TextCore.Glyph&) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldloca.s V_0
IL_0003: initobj UnityEngine.TextCore.LowLevel.GlyphMarshallingStruct
IL_0009: ldarg.0
IL_000a: ldarg.1
IL_000b: ldloca.s V_0
IL_000d: call System.Boolean UnityEngine.TextCore.LowLevel.FontEngine::TryGetGlyphWithUnicodeValue_Internal(System.UInt32,UnityEngine.TextCore.LowLevel.GlyphLoadFlags,UnityEngine.TextCore.LowLevel.GlyphMarshallingStruct&)
IL_0012: stloc.1
IL_0013: ldloc.1
IL_0014: brfalse.s IL_0023
IL_0016: nop
IL_0017: ldarg.2
IL_0018: ldloc.0
IL_0019: newobj System.Void UnityEngine.TextCore.Glyph::.ctor(UnityEngine.TextCore.LowLevel.GlyphMarshallingStruct)
IL_001e: stind.ref
IL_001f: ldc.i4.1
IL_0020: stloc.2
IL_0021: br.s IL_002a
IL_0023: ldarg.2
IL_0024: ldnull
IL_0025: stind.ref
IL_0026: ldc.i4.0
IL_0027: stloc.2
IL_0028: br.s IL_002a
IL_002a: ldloc.2
IL_002b: ret
TYPE UnityEngine.TextCore.GlyphMetrics
METHOD System.Void UnityEngine.TextCore.GlyphMetrics::.ctor(System.Single,System.Single,System.Single,System.Single,System.Single) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Single UnityEngine.TextCore.GlyphMetrics::m_Width
IL_0008: ldarg.0
IL_0009: ldarg.2
IL_000a: stfld System.Single UnityEngine.TextCore.GlyphMetrics::m_Height
IL_000f: ldarg.0
IL_0010: ldarg.3
IL_0011: stfld System.Single UnityEngine.TextCore.GlyphMetrics::m_HorizontalBearingX
IL_0016: ldarg.0
IL_0017: ldarg.s bearingY
IL_0019: stfld System.Single UnityEngine.TextCore.GlyphMetrics::m_HorizontalBearingY
IL_001e: ldarg.0
IL_001f: ldarg.s advance
IL_0021: stfld System.Single UnityEngine.TextCore.GlyphMetrics::m_HorizontalAdvance
IL_0026: ret
TYPE UnityEngine.TextCore.GlyphRect
METHOD UnityEngine.TextCore.GlyphRect UnityEngine.TextCore.GlyphRect::get_zero() | attributes=Public, Static, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldsfld UnityEngine.TextCore.GlyphRect UnityEngine.TextCore.GlyphRect::s_ZeroGlyphRect
IL_0006: stloc.0
IL_0007: br.s IL_0009
IL_0009: ldloc.0
IL_000a: ret
TYPE UnityEngine.TextCore.Glyph
METHOD System.Void UnityEngine.TextCore.Glyph::.ctor(System.UInt32,UnityEngine.TextCore.GlyphMetrics,UnityEngine.TextCore.GlyphRect,System.Single,System.Int32) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: nop
IL_0007: nop
IL_0008: ldarg.0
IL_0009: ldarg.1
IL_000a: stfld System.UInt32 UnityEngine.TextCore.Glyph::m_Index
IL_000f: ldarg.0
IL_0010: ldarg.2
IL_0011: stfld UnityEngine.TextCore.GlyphMetrics UnityEngine.TextCore.Glyph::m_Metrics
IL_0016: ldarg.0
IL_0017: ldarg.3
IL_0018: stfld UnityEngine.TextCore.GlyphRect UnityEngine.TextCore.Glyph::m_GlyphRect
IL_001d: ldarg.0
IL_001e: ldarg.s scale
IL_0020: stfld System.Single UnityEngine.TextCore.Glyph::m_Scale
IL_0025: ldarg.0
IL_0026: ldarg.s atlasIndex
IL_0028: stfld System.Int32 UnityEngine.TextCore.Glyph::m_AtlasIndex
IL_002d: ret
