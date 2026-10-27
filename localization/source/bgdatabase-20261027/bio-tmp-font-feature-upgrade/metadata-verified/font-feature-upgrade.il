TYPE TMPro.TMP_FontAsset
METHOD System.Void TMPro.TMP_FontAsset::UpgradeGlyphAdjustmentTableToFontFeatureTable() | attributes=Private, HideBySig | impl=IL
IL_0000: ldstr "Upgrading font asset ["
IL_0005: ldarg.0
IL_0006: call System.String UnityEngine.Object::get_name()
IL_000b: ldstr "] Glyph Adjustment Table."
IL_0010: call System.String System.String::Concat(System.String,System.String,System.String)
IL_0015: ldarg.0
IL_0016: call System.Void UnityEngine.Debug::Log(System.Object,UnityEngine.Object)
IL_001b: ldarg.0
IL_001c: ldfld TMPro.TMP_FontFeatureTable TMPro.TMP_FontAsset::m_FontFeatureTable
IL_0021: brtrue.s IL_002e
IL_0023: ldarg.0
IL_0024: newobj System.Void TMPro.TMP_FontFeatureTable::.ctor()
IL_0029: stfld TMPro.TMP_FontFeatureTable TMPro.TMP_FontAsset::m_FontFeatureTable
IL_002e: ldarg.0
IL_002f: ldfld TMPro.KerningTable TMPro.TMP_FontAsset::m_KerningTable
IL_0034: ldfld System.Collections.Generic.List`1<TMPro.KerningPair> TMPro.KerningTable::kerningPairs
IL_0039: callvirt System.Int32 System.Collections.Generic.List`1<TMPro.KerningPair>::get_Count()
IL_003e: stloc.0
IL_003f: ldarg.0
IL_0040: ldfld TMPro.TMP_FontFeatureTable TMPro.TMP_FontAsset::m_FontFeatureTable
IL_0045: ldloc.0
IL_0046: newobj System.Void System.Collections.Generic.List`1<TMPro.TMP_GlyphPairAdjustmentRecord>::.ctor(System.Int32)
IL_004b: stfld System.Collections.Generic.List`1<TMPro.TMP_GlyphPairAdjustmentRecord> TMPro.TMP_FontFeatureTable::m_GlyphPairAdjustmentRecords
IL_0050: ldc.i4.0
IL_0051: stloc.1
IL_0052: br IL_0139
IL_0057: ldarg.0
IL_0058: ldfld TMPro.KerningTable TMPro.TMP_FontAsset::m_KerningTable
IL_005d: ldfld System.Collections.Generic.List`1<TMPro.KerningPair> TMPro.KerningTable::kerningPairs
IL_0062: ldloc.1
IL_0063: callvirt !0 System.Collections.Generic.List`1<TMPro.KerningPair>::get_Item(System.Int32)
IL_0068: stloc.2
IL_0069: ldc.i4.0
IL_006a: stloc.3
IL_006b: ldarg.0
IL_006c: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterLookupDictionary
IL_0071: ldloc.2
IL_0072: callvirt System.UInt32 TMPro.KerningPair::get_firstGlyph()
IL_0077: ldloca.s V_4
IL_0079: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character>::TryGetValue(!0,!1&)
IL_007e: brfalse.s IL_0088
IL_0080: ldloc.s V_4
IL_0082: callvirt System.UInt32 TMPro.TMP_TextElement::get_glyphIndex()
IL_0087: stloc.3
IL_0088: ldc.i4.0
IL_0089: stloc.s V_5
IL_008b: ldarg.0
IL_008c: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterLookupDictionary
IL_0091: ldloc.2
IL_0092: callvirt System.UInt32 TMPro.KerningPair::get_secondGlyph()
IL_0097: ldloca.s V_6
IL_0099: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character>::TryGetValue(!0,!1&)
IL_009e: brfalse.s IL_00a9
IL_00a0: ldloc.s V_6
IL_00a2: callvirt System.UInt32 TMPro.TMP_TextElement::get_glyphIndex()
IL_00a7: stloc.s V_5
IL_00a9: ldloc.3
IL_00aa: ldloc.2
IL_00ab: callvirt TMPro.GlyphValueRecord_Legacy TMPro.KerningPair::get_firstGlyphAdjustments()
IL_00b0: ldfld System.Single TMPro.GlyphValueRecord_Legacy::xPlacement
IL_00b5: ldloc.2
IL_00b6: callvirt TMPro.GlyphValueRecord_Legacy TMPro.KerningPair::get_firstGlyphAdjustments()
IL_00bb: ldfld System.Single TMPro.GlyphValueRecord_Legacy::yPlacement
IL_00c0: ldloc.2
IL_00c1: callvirt TMPro.GlyphValueRecord_Legacy TMPro.KerningPair::get_firstGlyphAdjustments()
IL_00c6: ldfld System.Single TMPro.GlyphValueRecord_Legacy::xAdvance
IL_00cb: ldloc.2
IL_00cc: callvirt TMPro.GlyphValueRecord_Legacy TMPro.KerningPair::get_firstGlyphAdjustments()
IL_00d1: ldfld System.Single TMPro.GlyphValueRecord_Legacy::yAdvance
IL_00d6: newobj System.Void TMPro.TMP_GlyphValueRecord::.ctor(System.Single,System.Single,System.Single,System.Single)
IL_00db: newobj System.Void TMPro.TMP_GlyphAdjustmentRecord::.ctor(System.UInt32,TMPro.TMP_GlyphValueRecord)
IL_00e0: ldloca.s V_7
IL_00e2: ldloc.s V_5
IL_00e4: ldloc.2
IL_00e5: callvirt TMPro.GlyphValueRecord_Legacy TMPro.KerningPair::get_secondGlyphAdjustments()
IL_00ea: ldfld System.Single TMPro.GlyphValueRecord_Legacy::xPlacement
IL_00ef: ldloc.2
IL_00f0: callvirt TMPro.GlyphValueRecord_Legacy TMPro.KerningPair::get_secondGlyphAdjustments()
IL_00f5: ldfld System.Single TMPro.GlyphValueRecord_Legacy::yPlacement
IL_00fa: ldloc.2
IL_00fb: callvirt TMPro.GlyphValueRecord_Legacy TMPro.KerningPair::get_secondGlyphAdjustments()
IL_0100: ldfld System.Single TMPro.GlyphValueRecord_Legacy::xAdvance
IL_0105: ldloc.2
IL_0106: callvirt TMPro.GlyphValueRecord_Legacy TMPro.KerningPair::get_secondGlyphAdjustments()
IL_010b: ldfld System.Single TMPro.GlyphValueRecord_Legacy::yAdvance
IL_0110: newobj System.Void TMPro.TMP_GlyphValueRecord::.ctor(System.Single,System.Single,System.Single,System.Single)
IL_0115: call System.Void TMPro.TMP_GlyphAdjustmentRecord::.ctor(System.UInt32,TMPro.TMP_GlyphValueRecord)
IL_011a: ldloc.s V_7
IL_011c: newobj System.Void TMPro.TMP_GlyphPairAdjustmentRecord::.ctor(TMPro.TMP_GlyphAdjustmentRecord,TMPro.TMP_GlyphAdjustmentRecord)
IL_0121: stloc.s V_8
IL_0123: ldarg.0
IL_0124: ldfld TMPro.TMP_FontFeatureTable TMPro.TMP_FontAsset::m_FontFeatureTable
IL_0129: ldfld System.Collections.Generic.List`1<TMPro.TMP_GlyphPairAdjustmentRecord> TMPro.TMP_FontFeatureTable::m_GlyphPairAdjustmentRecords
IL_012e: ldloc.s V_8
IL_0130: callvirt System.Void System.Collections.Generic.List`1<TMPro.TMP_GlyphPairAdjustmentRecord>::Add(!0)
IL_0135: ldloc.1
IL_0136: ldc.i4.1
IL_0137: add
IL_0138: stloc.1
IL_0139: ldloc.1
IL_013a: ldloc.0
IL_013b: blt IL_0057
IL_0140: ldarg.0
IL_0141: ldfld TMPro.KerningTable TMPro.TMP_FontAsset::m_KerningTable
IL_0146: ldnull
IL_0147: stfld System.Collections.Generic.List`1<TMPro.KerningPair> TMPro.KerningTable::kerningPairs
IL_014c: ldarg.0
IL_014d: ldnull
IL_014e: stfld TMPro.KerningTable TMPro.TMP_FontAsset::m_KerningTable
IL_0153: ret
