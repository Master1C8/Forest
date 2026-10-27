TYPE TMPro.TMP_FontAsset
METHOD System.Void TMPro.TMP_FontAsset::InitializeGlyphLookupDictionary() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph> TMPro.TMP_FontAsset::m_GlyphLookupDictionary
IL_0006: brtrue.s IL_0015
IL_0008: ldarg.0
IL_0009: newobj System.Void System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph>::.ctor()
IL_000e: stfld System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph> TMPro.TMP_FontAsset::m_GlyphLookupDictionary
IL_0013: br.s IL_0020
IL_0015: ldarg.0
IL_0016: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph> TMPro.TMP_FontAsset::m_GlyphLookupDictionary
IL_001b: callvirt System.Void System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph>::Clear()
IL_0020: ldarg.0
IL_0021: ldfld System.Collections.Generic.List`1<System.UInt32> TMPro.TMP_FontAsset::m_GlyphIndexList
IL_0026: brtrue.s IL_0035
IL_0028: ldarg.0
IL_0029: newobj System.Void System.Collections.Generic.List`1<System.UInt32>::.ctor()
IL_002e: stfld System.Collections.Generic.List`1<System.UInt32> TMPro.TMP_FontAsset::m_GlyphIndexList
IL_0033: br.s IL_0040
IL_0035: ldarg.0
IL_0036: ldfld System.Collections.Generic.List`1<System.UInt32> TMPro.TMP_FontAsset::m_GlyphIndexList
IL_003b: callvirt System.Void System.Collections.Generic.List`1<System.UInt32>::Clear()
IL_0040: ldarg.0
IL_0041: ldfld System.Collections.Generic.List`1<System.UInt32> TMPro.TMP_FontAsset::m_GlyphIndexListNewlyAdded
IL_0046: brtrue.s IL_0055
IL_0048: ldarg.0
IL_0049: newobj System.Void System.Collections.Generic.List`1<System.UInt32>::.ctor()
IL_004e: stfld System.Collections.Generic.List`1<System.UInt32> TMPro.TMP_FontAsset::m_GlyphIndexListNewlyAdded
IL_0053: br.s IL_0060
IL_0055: ldarg.0
IL_0056: ldfld System.Collections.Generic.List`1<System.UInt32> TMPro.TMP_FontAsset::m_GlyphIndexListNewlyAdded
IL_005b: callvirt System.Void System.Collections.Generic.List`1<System.UInt32>::Clear()
IL_0060: ldarg.0
IL_0061: ldfld System.Collections.Generic.List`1<UnityEngine.TextCore.Glyph> TMPro.TMP_FontAsset::m_GlyphTable
IL_0066: callvirt System.Int32 System.Collections.Generic.List`1<UnityEngine.TextCore.Glyph>::get_Count()
IL_006b: stloc.0
IL_006c: ldc.i4.0
IL_006d: stloc.1
IL_006e: br.s IL_00af
IL_0070: ldarg.0
IL_0071: ldfld System.Collections.Generic.List`1<UnityEngine.TextCore.Glyph> TMPro.TMP_FontAsset::m_GlyphTable
IL_0076: ldloc.1
IL_0077: callvirt !0 System.Collections.Generic.List`1<UnityEngine.TextCore.Glyph>::get_Item(System.Int32)
IL_007c: stloc.2
IL_007d: ldloc.2
IL_007e: callvirt System.UInt32 UnityEngine.TextCore.Glyph::get_index()
IL_0083: stloc.3
IL_0084: ldarg.0
IL_0085: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph> TMPro.TMP_FontAsset::m_GlyphLookupDictionary
IL_008a: ldloc.3
IL_008b: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph>::ContainsKey(!0)
IL_0090: brtrue.s IL_00ab
IL_0092: ldarg.0
IL_0093: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph> TMPro.TMP_FontAsset::m_GlyphLookupDictionary
IL_0098: ldloc.3
IL_0099: ldloc.2
IL_009a: callvirt System.Void System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph>::Add(!0,!1)
IL_009f: ldarg.0
IL_00a0: ldfld System.Collections.Generic.List`1<System.UInt32> TMPro.TMP_FontAsset::m_GlyphIndexList
IL_00a5: ldloc.3
IL_00a6: callvirt System.Void System.Collections.Generic.List`1<System.UInt32>::Add(!0)
IL_00ab: ldloc.1
IL_00ac: ldc.i4.1
IL_00ad: add
IL_00ae: stloc.1
IL_00af: ldloc.1
IL_00b0: ldloc.0
IL_00b1: blt.s IL_0070
IL_00b3: ret
TYPE TMPro.TMP_FontAsset
METHOD System.Void TMPro.TMP_FontAsset::InitializeCharacterLookupDictionary() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterLookupDictionary
IL_0006: brtrue.s IL_0015
IL_0008: ldarg.0
IL_0009: newobj System.Void System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character>::.ctor()
IL_000e: stfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterLookupDictionary
IL_0013: br.s IL_0020
IL_0015: ldarg.0
IL_0016: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterLookupDictionary
IL_001b: callvirt System.Void System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character>::Clear()
IL_0020: ldc.i4.0
IL_0021: stloc.0
IL_0022: br.s IL_0077
IL_0024: ldarg.0
IL_0025: ldfld System.Collections.Generic.List`1<TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterTable
IL_002a: ldloc.0
IL_002b: callvirt !0 System.Collections.Generic.List`1<TMPro.TMP_Character>::get_Item(System.Int32)
IL_0030: stloc.1
IL_0031: ldloc.1
IL_0032: callvirt System.UInt32 TMPro.TMP_TextElement::get_unicode()
IL_0037: stloc.2
IL_0038: ldloc.1
IL_0039: callvirt System.UInt32 TMPro.TMP_TextElement::get_glyphIndex()
IL_003e: stloc.3
IL_003f: ldarg.0
IL_0040: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterLookupDictionary
IL_0045: ldloc.2
IL_0046: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character>::ContainsKey(!0)
IL_004b: brtrue.s IL_0073
IL_004d: ldarg.0
IL_004e: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterLookupDictionary
IL_0053: ldloc.2
IL_0054: ldloc.1
IL_0055: callvirt System.Void System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character>::Add(!0,!1)
IL_005a: ldloc.1
IL_005b: ldarg.0
IL_005c: callvirt System.Void TMPro.TMP_TextElement::set_textAsset(TMPro.TMP_Asset)
IL_0061: ldloc.1
IL_0062: ldarg.0
IL_0063: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph> TMPro.TMP_FontAsset::m_GlyphLookupDictionary
IL_0068: ldloc.3
IL_0069: callvirt !1 System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph>::get_Item(!0)
IL_006e: callvirt System.Void TMPro.TMP_TextElement::set_glyph(UnityEngine.TextCore.Glyph)
IL_0073: ldloc.0
IL_0074: ldc.i4.1
IL_0075: add
IL_0076: stloc.0
IL_0077: ldloc.0
IL_0078: ldarg.0
IL_0079: ldfld System.Collections.Generic.List`1<TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterTable
IL_007e: callvirt System.Int32 System.Collections.Generic.List`1<TMPro.TMP_Character>::get_Count()
IL_0083: blt.s IL_0024
IL_0085: ldarg.0
IL_0086: ldfld System.Collections.Generic.HashSet`1<System.Int32> TMPro.TMP_FontAsset::FallbackSearchQueryLookup
IL_008b: brtrue.s IL_0099
IL_008d: ldarg.0
IL_008e: newobj System.Void System.Collections.Generic.HashSet`1<System.Int32>::.ctor()
IL_0093: stfld System.Collections.Generic.HashSet`1<System.Int32> TMPro.TMP_FontAsset::FallbackSearchQueryLookup
IL_0098: ret
IL_0099: ldarg.0
IL_009a: ldfld System.Collections.Generic.HashSet`1<System.Int32> TMPro.TMP_FontAsset::FallbackSearchQueryLookup
IL_009f: callvirt System.Void System.Collections.Generic.HashSet`1<System.Int32>::Clear()
IL_00a4: ret
TYPE TMPro.TMP_FontAsset
METHOD System.Void TMPro.TMP_FontAsset::InitializeGlyphPaidAdjustmentRecordsLookupDictionary() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld TMPro.KerningTable TMPro.TMP_FontAsset::m_KerningTable
IL_0006: brfalse.s IL_002e
IL_0008: ldarg.0
IL_0009: ldfld TMPro.KerningTable TMPro.TMP_FontAsset::m_KerningTable
IL_000e: ldfld System.Collections.Generic.List`1<TMPro.KerningPair> TMPro.KerningTable::kerningPairs
IL_0013: brfalse.s IL_002e
IL_0015: ldarg.0
IL_0016: ldfld TMPro.KerningTable TMPro.TMP_FontAsset::m_KerningTable
IL_001b: ldfld System.Collections.Generic.List`1<TMPro.KerningPair> TMPro.KerningTable::kerningPairs
IL_0020: callvirt System.Int32 System.Collections.Generic.List`1<TMPro.KerningPair>::get_Count()
IL_0025: ldc.i4.0
IL_0026: ble.s IL_002e
IL_0028: ldarg.0
IL_0029: call System.Void TMPro.TMP_FontAsset::UpgradeGlyphAdjustmentTableToFontFeatureTable()
IL_002e: ldarg.0
IL_002f: ldfld TMPro.TMP_FontFeatureTable TMPro.TMP_FontAsset::m_FontFeatureTable
IL_0034: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_GlyphPairAdjustmentRecord> TMPro.TMP_FontFeatureTable::m_GlyphPairAdjustmentRecordLookupDictionary
IL_0039: brtrue.s IL_004d
IL_003b: ldarg.0
IL_003c: ldfld TMPro.TMP_FontFeatureTable TMPro.TMP_FontAsset::m_FontFeatureTable
IL_0041: newobj System.Void System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_GlyphPairAdjustmentRecord>::.ctor()
IL_0046: stfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_GlyphPairAdjustmentRecord> TMPro.TMP_FontFeatureTable::m_GlyphPairAdjustmentRecordLookupDictionary
IL_004b: br.s IL_005d
IL_004d: ldarg.0
IL_004e: ldfld TMPro.TMP_FontFeatureTable TMPro.TMP_FontAsset::m_FontFeatureTable
IL_0053: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_GlyphPairAdjustmentRecord> TMPro.TMP_FontFeatureTable::m_GlyphPairAdjustmentRecordLookupDictionary
IL_0058: callvirt System.Void System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_GlyphPairAdjustmentRecord>::Clear()
IL_005d: ldarg.0
IL_005e: ldfld TMPro.TMP_FontFeatureTable TMPro.TMP_FontAsset::m_FontFeatureTable
IL_0063: ldfld System.Collections.Generic.List`1<TMPro.TMP_GlyphPairAdjustmentRecord> TMPro.TMP_FontFeatureTable::m_GlyphPairAdjustmentRecords
IL_0068: stloc.0
IL_0069: ldloc.0
IL_006a: brfalse.s IL_00b6
IL_006c: ldc.i4.0
IL_006d: stloc.1
IL_006e: br.s IL_00ad
IL_0070: ldloc.0
IL_0071: ldloc.1
IL_0072: callvirt !0 System.Collections.Generic.List`1<TMPro.TMP_GlyphPairAdjustmentRecord>::get_Item(System.Int32)
IL_0077: stloc.2
IL_0078: ldloc.2
IL_0079: newobj System.Void TMPro.GlyphPairKey::.ctor(TMPro.TMP_GlyphPairAdjustmentRecord)
IL_007e: ldfld System.UInt32 TMPro.GlyphPairKey::key
IL_0083: stloc.3
IL_0084: ldarg.0
IL_0085: ldfld TMPro.TMP_FontFeatureTable TMPro.TMP_FontAsset::m_FontFeatureTable
IL_008a: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_GlyphPairAdjustmentRecord> TMPro.TMP_FontFeatureTable::m_GlyphPairAdjustmentRecordLookupDictionary
IL_008f: ldloc.3
IL_0090: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_GlyphPairAdjustmentRecord>::ContainsKey(!0)
IL_0095: brtrue.s IL_00a9
IL_0097: ldarg.0
IL_0098: ldfld TMPro.TMP_FontFeatureTable TMPro.TMP_FontAsset::m_FontFeatureTable
IL_009d: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_GlyphPairAdjustmentRecord> TMPro.TMP_FontFeatureTable::m_GlyphPairAdjustmentRecordLookupDictionary
IL_00a2: ldloc.3
IL_00a3: ldloc.2
IL_00a4: callvirt System.Void System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_GlyphPairAdjustmentRecord>::Add(!0,!1)
IL_00a9: ldloc.1
IL_00aa: ldc.i4.1
IL_00ab: add
IL_00ac: stloc.1
IL_00ad: ldloc.1
IL_00ae: ldloc.0
IL_00af: callvirt System.Int32 System.Collections.Generic.List`1<TMPro.TMP_GlyphPairAdjustmentRecord>::get_Count()
IL_00b4: blt.s IL_0070
IL_00b6: ret
