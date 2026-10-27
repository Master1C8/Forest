TYPE UnityEngine.TextCore.Glyph
METHOD System.Void UnityEngine.TextCore.Glyph::.ctor(UnityEngine.TextCore.LowLevel.GlyphMarshallingStruct) | attributes=Assembly, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: nop
IL_0007: nop
IL_0008: ldarg.0
IL_0009: ldarg.1
IL_000a: ldfld System.UInt32 UnityEngine.TextCore.LowLevel.GlyphMarshallingStruct::index
IL_000f: stfld System.UInt32 UnityEngine.TextCore.Glyph::m_Index
IL_0014: ldarg.0
IL_0015: ldarg.1
IL_0016: ldfld UnityEngine.TextCore.GlyphMetrics UnityEngine.TextCore.LowLevel.GlyphMarshallingStruct::metrics
IL_001b: stfld UnityEngine.TextCore.GlyphMetrics UnityEngine.TextCore.Glyph::m_Metrics
IL_0020: ldarg.0
IL_0021: ldarg.1
IL_0022: ldfld UnityEngine.TextCore.GlyphRect UnityEngine.TextCore.LowLevel.GlyphMarshallingStruct::glyphRect
IL_0027: stfld UnityEngine.TextCore.GlyphRect UnityEngine.TextCore.Glyph::m_GlyphRect
IL_002c: ldarg.0
IL_002d: ldarg.1
IL_002e: ldfld System.Single UnityEngine.TextCore.LowLevel.GlyphMarshallingStruct::scale
IL_0033: stfld System.Single UnityEngine.TextCore.Glyph::m_Scale
IL_0038: ldarg.0
IL_0039: ldarg.1
IL_003a: ldfld System.Int32 UnityEngine.TextCore.LowLevel.GlyphMarshallingStruct::atlasIndex
IL_003f: stfld System.Int32 UnityEngine.TextCore.Glyph::m_AtlasIndex
IL_0044: ret
