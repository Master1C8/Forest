TYPE TMPro.TMP_FontFeatureTable
METHOD System.Void TMPro.TMP_FontFeatureTable::.ctor() | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: ldarg.0
IL_0007: newobj System.Void System.Collections.Generic.List`1<TMPro.TMP_GlyphPairAdjustmentRecord>::.ctor()
IL_000c: stfld System.Collections.Generic.List`1<TMPro.TMP_GlyphPairAdjustmentRecord> TMPro.TMP_FontFeatureTable::m_GlyphPairAdjustmentRecords
IL_0011: ldarg.0
IL_0012: newobj System.Void System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_GlyphPairAdjustmentRecord>::.ctor()
IL_0017: stfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_GlyphPairAdjustmentRecord> TMPro.TMP_FontFeatureTable::m_GlyphPairAdjustmentRecordLookupDictionary
IL_001c: ret
TYPE TMPro.KerningPair
METHOD System.UInt32 TMPro.KerningPair::get_firstGlyph() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.UInt32 TMPro.KerningPair::m_FirstGlyph
IL_0006: ret
TYPE TMPro.KerningPair
METHOD System.UInt32 TMPro.KerningPair::get_secondGlyph() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.UInt32 TMPro.KerningPair::m_SecondGlyph
IL_0006: ret
TYPE TMPro.KerningPair
METHOD TMPro.GlyphValueRecord_Legacy TMPro.KerningPair::get_firstGlyphAdjustments() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TMPro.GlyphValueRecord_Legacy TMPro.KerningPair::m_FirstGlyphAdjustments
IL_0006: ret
TYPE TMPro.TMP_GlyphValueRecord
METHOD System.Void TMPro.TMP_GlyphValueRecord::.ctor(System.Single,System.Single,System.Single,System.Single) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.Single TMPro.TMP_GlyphValueRecord::m_XPlacement
IL_0007: ldarg.0
IL_0008: ldarg.2
IL_0009: stfld System.Single TMPro.TMP_GlyphValueRecord::m_YPlacement
IL_000e: ldarg.0
IL_000f: ldarg.3
IL_0010: stfld System.Single TMPro.TMP_GlyphValueRecord::m_XAdvance
IL_0015: ldarg.0
IL_0016: ldarg.s yAdvance
IL_0018: stfld System.Single TMPro.TMP_GlyphValueRecord::m_YAdvance
IL_001d: ret
TYPE TMPro.TMP_GlyphAdjustmentRecord
METHOD System.Void TMPro.TMP_GlyphAdjustmentRecord::.ctor(System.UInt32,TMPro.TMP_GlyphValueRecord) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.1
IL_0002: stfld System.UInt32 TMPro.TMP_GlyphAdjustmentRecord::m_GlyphIndex
IL_0007: ldarg.0
IL_0008: ldarg.2
IL_0009: stfld TMPro.TMP_GlyphValueRecord TMPro.TMP_GlyphAdjustmentRecord::m_GlyphValueRecord
IL_000e: ret
TYPE TMPro.KerningPair
METHOD TMPro.GlyphValueRecord_Legacy TMPro.KerningPair::get_secondGlyphAdjustments() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TMPro.GlyphValueRecord_Legacy TMPro.KerningPair::m_SecondGlyphAdjustments
IL_0006: ret
TYPE TMPro.TMP_GlyphPairAdjustmentRecord
METHOD System.Void TMPro.TMP_GlyphPairAdjustmentRecord::.ctor(TMPro.TMP_GlyphAdjustmentRecord,TMPro.TMP_GlyphAdjustmentRecord) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void System.Object::.ctor()
IL_0006: ldarg.0
IL_0007: ldarg.1
IL_0008: stfld TMPro.TMP_GlyphAdjustmentRecord TMPro.TMP_GlyphPairAdjustmentRecord::m_FirstAdjustmentRecord
IL_000d: ldarg.0
IL_000e: ldarg.2
IL_000f: stfld TMPro.TMP_GlyphAdjustmentRecord TMPro.TMP_GlyphPairAdjustmentRecord::m_SecondAdjustmentRecord
IL_0014: ldarg.0
IL_0015: ldc.i4.0
IL_0016: stfld TMPro.FontFeatureLookupFlags TMPro.TMP_GlyphPairAdjustmentRecord::m_FeatureLookupFlags
IL_001b: ret
