TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Void UnityEngine.TextCore.FaceInfo::set_familyName(System.String) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.String UnityEngine.TextCore.FaceInfo::m_FamilyName
IL_0008: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Void UnityEngine.TextCore.FaceInfo::set_styleName(System.String) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.String UnityEngine.TextCore.FaceInfo::m_StyleName
IL_0008: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Void UnityEngine.TextCore.FaceInfo::set_pointSize(System.Int32) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Int32 UnityEngine.TextCore.FaceInfo::m_PointSize
IL_0008: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Void UnityEngine.TextCore.FaceInfo::set_lineHeight(System.Single) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Single UnityEngine.TextCore.FaceInfo::m_LineHeight
IL_0008: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Void UnityEngine.TextCore.FaceInfo::set_ascentLine(System.Single) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Single UnityEngine.TextCore.FaceInfo::m_AscentLine
IL_0008: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Void UnityEngine.TextCore.FaceInfo::set_baseline(System.Single) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Single UnityEngine.TextCore.FaceInfo::m_Baseline
IL_0008: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Void UnityEngine.TextCore.FaceInfo::set_descentLine(System.Single) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Single UnityEngine.TextCore.FaceInfo::m_DescentLine
IL_0008: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Void UnityEngine.TextCore.FaceInfo::set_superscriptOffset(System.Single) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Single UnityEngine.TextCore.FaceInfo::m_SuperscriptOffset
IL_0008: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Void UnityEngine.TextCore.FaceInfo::set_superscriptSize(System.Single) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Single UnityEngine.TextCore.FaceInfo::m_SuperscriptSize
IL_0008: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Void UnityEngine.TextCore.FaceInfo::set_subscriptOffset(System.Single) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Single UnityEngine.TextCore.FaceInfo::m_SubscriptOffset
IL_0008: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Void UnityEngine.TextCore.FaceInfo::set_subscriptSize(System.Single) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Single UnityEngine.TextCore.FaceInfo::m_SubscriptSize
IL_0008: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Void UnityEngine.TextCore.FaceInfo::set_underlineOffset(System.Single) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Single UnityEngine.TextCore.FaceInfo::m_UnderlineOffset
IL_0008: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Void UnityEngine.TextCore.FaceInfo::set_underlineThickness(System.Single) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Single UnityEngine.TextCore.FaceInfo::m_UnderlineThickness
IL_0008: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Void UnityEngine.TextCore.FaceInfo::set_strikethroughThickness(System.Single) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Single UnityEngine.TextCore.FaceInfo::m_StrikethroughThickness
IL_0008: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Void UnityEngine.TextCore.FaceInfo::set_tabWidth(System.Single) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Single UnityEngine.TextCore.FaceInfo::m_TabWidth
IL_0008: ret
TYPE UnityEngine.TextCore.Glyph
METHOD System.Void UnityEngine.TextCore.Glyph::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: nop
IL_0007: nop
IL_0008: ldarg.0
IL_0009: ldc.i4.0
IL_000a: stfld System.UInt32 UnityEngine.TextCore.Glyph::m_Index
IL_000f: ldarg.0
IL_0010: ldflda UnityEngine.TextCore.GlyphMetrics UnityEngine.TextCore.Glyph::m_Metrics
IL_0015: initobj UnityEngine.TextCore.GlyphMetrics
IL_001b: ldarg.0
IL_001c: ldflda UnityEngine.TextCore.GlyphRect UnityEngine.TextCore.Glyph::m_GlyphRect
IL_0021: initobj UnityEngine.TextCore.GlyphRect
IL_0027: ldarg.0
IL_0028: ldc.r4 1
IL_002d: stfld System.Single UnityEngine.TextCore.Glyph::m_Scale
IL_0032: ldarg.0
IL_0033: ldc.i4.0
IL_0034: stfld System.Int32 UnityEngine.TextCore.Glyph::m_AtlasIndex
IL_0039: ret
TYPE UnityEngine.TextCore.Glyph
METHOD System.Void UnityEngine.TextCore.Glyph::set_index(System.UInt32) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.UInt32 UnityEngine.TextCore.Glyph::m_Index
IL_0008: ret
TYPE UnityEngine.TextCore.Glyph
METHOD System.Void UnityEngine.TextCore.Glyph::set_glyphRect(UnityEngine.TextCore.GlyphRect) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld UnityEngine.TextCore.GlyphRect UnityEngine.TextCore.Glyph::m_GlyphRect
IL_0008: ret
TYPE UnityEngine.TextCore.Glyph
METHOD System.Void UnityEngine.TextCore.Glyph::set_metrics(UnityEngine.TextCore.GlyphMetrics) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld UnityEngine.TextCore.GlyphMetrics UnityEngine.TextCore.Glyph::m_Metrics
IL_0008: ret
TYPE UnityEngine.TextCore.Glyph
METHOD System.Void UnityEngine.TextCore.Glyph::set_scale(System.Single) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Single UnityEngine.TextCore.Glyph::m_Scale
IL_0008: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Single UnityEngine.TextCore.FaceInfo::get_ascentLine() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldfld System.Single UnityEngine.TextCore.FaceInfo::m_AscentLine
IL_0007: stloc.0
IL_0008: br.s IL_000a
IL_000a: ldloc.0
IL_000b: ret
