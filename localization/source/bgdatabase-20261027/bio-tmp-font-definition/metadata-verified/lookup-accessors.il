TYPE UnityEngine.TextCore.Glyph
METHOD System.UInt32 UnityEngine.TextCore.Glyph::get_index() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldfld System.UInt32 UnityEngine.TextCore.Glyph::m_Index
IL_0007: stloc.0
IL_0008: br.s IL_000a
IL_000a: ldloc.0
IL_000b: ret
TYPE TMPro.TMP_TextElement
METHOD System.UInt32 TMPro.TMP_TextElement::get_unicode() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.UInt32 TMPro.TMP_TextElement::m_Unicode
IL_0006: ret
TYPE TMPro.TMP_TextElement
METHOD System.UInt32 TMPro.TMP_TextElement::get_glyphIndex() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.UInt32 TMPro.TMP_TextElement::m_GlyphIndex
IL_0006: ret
TYPE TMPro.TMP_TextElement
METHOD System.Void TMPro.TMP_TextElement::set_textAsset(TMPro.TMP_Asset) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld TMPro.TMP_Asset TMPro.TMP_TextElement::m_TextAsset
IL_0007: ret
TYPE TMPro.TMP_TextElement
METHOD System.Void TMPro.TMP_TextElement::set_glyph(UnityEngine.TextCore.Glyph) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld UnityEngine.TextCore.Glyph TMPro.TMP_TextElement::m_Glyph
IL_0007: ret
TYPE TMPro.GlyphPairKey
METHOD System.Void TMPro.GlyphPairKey::.ctor(TMPro.TMP_GlyphPairAdjustmentRecord) | attributes=Assembly, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: callvirt TMPro.TMP_GlyphAdjustmentRecord TMPro.TMP_GlyphPairAdjustmentRecord::get_firstAdjustmentRecord()
IL_0007: stloc.0
IL_0008: ldloca.s V_0
IL_000a: call System.UInt32 TMPro.TMP_GlyphAdjustmentRecord::get_glyphIndex()
IL_000f: stfld System.UInt32 TMPro.GlyphPairKey::firstGlyphIndex
IL_0014: ldarg.0
IL_0015: ldarg.1
IL_0016: callvirt TMPro.TMP_GlyphAdjustmentRecord TMPro.TMP_GlyphPairAdjustmentRecord::get_secondAdjustmentRecord()
IL_001b: stloc.0
IL_001c: ldloca.s V_0
IL_001e: call System.UInt32 TMPro.TMP_GlyphAdjustmentRecord::get_glyphIndex()
IL_0023: stfld System.UInt32 TMPro.GlyphPairKey::secondGlyphIndex
IL_0028: ldarg.0
IL_0029: ldarg.0
IL_002a: ldfld System.UInt32 TMPro.GlyphPairKey::secondGlyphIndex
IL_002f: ldc.i4.s 16
IL_0031: shl
IL_0032: ldarg.0
IL_0033: ldfld System.UInt32 TMPro.GlyphPairKey::firstGlyphIndex
IL_0038: or
IL_0039: stfld System.UInt32 TMPro.GlyphPairKey::key
IL_003e: ret
