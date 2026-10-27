TYPE TMPro.TMP_FontAsset
METHOD System.Void TMPro.TMP_FontAsset::AddSynthesizedCharactersAndFaceMetrics() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: ldarg.0
IL_0003: ldfld TMPro.AtlasPopulationMode TMPro.TMP_FontAsset::m_AtlasPopulationMode
IL_0008: ldc.i4.1
IL_0009: bne.un.s IL_0025
IL_000b: ldarg.0
IL_000c: call UnityEngine.Font TMPro.TMP_FontAsset::get_sourceFontFile()
IL_0011: ldarg.0
IL_0012: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_0017: call System.Int32 UnityEngine.TextCore.FaceInfo::get_pointSize()
IL_001c: call UnityEngine.TextCore.LowLevel.FontEngineError UnityEngine.TextCore.LowLevel.FontEngine::LoadFontFace(UnityEngine.Font,System.Int32)
IL_0021: ldc.i4.0
IL_0022: ceq
IL_0024: stloc.0
IL_0025: ldarg.0
IL_0026: ldc.i4.3
IL_0027: ldloc.0
IL_0028: ldc.i4.1
IL_0029: call System.Void TMPro.TMP_FontAsset::AddSynthesizedCharacter(System.UInt32,System.Boolean,System.Boolean)
IL_002e: ldarg.0
IL_002f: ldc.i4.s 9
IL_0031: ldloc.0
IL_0032: ldc.i4.1
IL_0033: call System.Void TMPro.TMP_FontAsset::AddSynthesizedCharacter(System.UInt32,System.Boolean,System.Boolean)
IL_0038: ldarg.0
IL_0039: ldc.i4.s 10
IL_003b: ldloc.0
IL_003c: ldc.i4.0
IL_003d: call System.Void TMPro.TMP_FontAsset::AddSynthesizedCharacter(System.UInt32,System.Boolean,System.Boolean)
IL_0042: ldarg.0
IL_0043: ldc.i4.s 11
IL_0045: ldloc.0
IL_0046: ldc.i4.0
IL_0047: call System.Void TMPro.TMP_FontAsset::AddSynthesizedCharacter(System.UInt32,System.Boolean,System.Boolean)
IL_004c: ldarg.0
IL_004d: ldc.i4.s 13
IL_004f: ldloc.0
IL_0050: ldc.i4.0
IL_0051: call System.Void TMPro.TMP_FontAsset::AddSynthesizedCharacter(System.UInt32,System.Boolean,System.Boolean)
IL_0056: ldarg.0
IL_0057: ldc.i4 1564
IL_005c: ldloc.0
IL_005d: ldc.i4.0
IL_005e: call System.Void TMPro.TMP_FontAsset::AddSynthesizedCharacter(System.UInt32,System.Boolean,System.Boolean)
IL_0063: ldarg.0
IL_0064: ldc.i4 8203
IL_0069: ldloc.0
IL_006a: ldc.i4.0
IL_006b: call System.Void TMPro.TMP_FontAsset::AddSynthesizedCharacter(System.UInt32,System.Boolean,System.Boolean)
IL_0070: ldarg.0
IL_0071: ldc.i4 8206
IL_0076: ldloc.0
IL_0077: ldc.i4.0
IL_0078: call System.Void TMPro.TMP_FontAsset::AddSynthesizedCharacter(System.UInt32,System.Boolean,System.Boolean)
IL_007d: ldarg.0
IL_007e: ldc.i4 8207
IL_0083: ldloc.0
IL_0084: ldc.i4.0
IL_0085: call System.Void TMPro.TMP_FontAsset::AddSynthesizedCharacter(System.UInt32,System.Boolean,System.Boolean)
IL_008a: ldarg.0
IL_008b: ldc.i4 8232
IL_0090: ldloc.0
IL_0091: ldc.i4.0
IL_0092: call System.Void TMPro.TMP_FontAsset::AddSynthesizedCharacter(System.UInt32,System.Boolean,System.Boolean)
IL_0097: ldarg.0
IL_0098: ldc.i4 8233
IL_009d: ldloc.0
IL_009e: ldc.i4.0
IL_009f: call System.Void TMPro.TMP_FontAsset::AddSynthesizedCharacter(System.UInt32,System.Boolean,System.Boolean)
IL_00a4: ldarg.0
IL_00a5: ldc.i4 8288
IL_00aa: ldloc.0
IL_00ab: ldc.i4.0
IL_00ac: call System.Void TMPro.TMP_FontAsset::AddSynthesizedCharacter(System.UInt32,System.Boolean,System.Boolean)
IL_00b1: ldarg.0
IL_00b2: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_00b7: call System.Single UnityEngine.TextCore.FaceInfo::get_capLine()
IL_00bc: ldc.r4 0
IL_00c1: bne.un.s IL_0109
IL_00c3: ldarg.0
IL_00c4: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterLookupDictionary
IL_00c9: ldc.i4.s 88
IL_00cb: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character>::ContainsKey(!0)
IL_00d0: brfalse.s IL_0109
IL_00d2: ldarg.0
IL_00d3: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterLookupDictionary
IL_00d8: ldc.i4.s 88
IL_00da: callvirt !1 System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character>::get_Item(!0)
IL_00df: callvirt System.UInt32 TMPro.TMP_TextElement::get_glyphIndex()
IL_00e4: stloc.1
IL_00e5: ldarg.0
IL_00e6: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_00eb: ldarg.0
IL_00ec: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph> TMPro.TMP_FontAsset::m_GlyphLookupDictionary
IL_00f1: ldloc.1
IL_00f2: callvirt !1 System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph>::get_Item(!0)
IL_00f7: callvirt UnityEngine.TextCore.GlyphMetrics UnityEngine.TextCore.Glyph::get_metrics()
IL_00fc: stloc.2
IL_00fd: ldloca.s V_2
IL_00ff: call System.Single UnityEngine.TextCore.GlyphMetrics::get_horizontalBearingY()
IL_0104: call System.Void UnityEngine.TextCore.FaceInfo::set_capLine(System.Single)
IL_0109: ldarg.0
IL_010a: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_010f: call System.Single UnityEngine.TextCore.FaceInfo::get_meanLine()
IL_0114: ldc.r4 0
IL_0119: bne.un.s IL_0161
IL_011b: ldarg.0
IL_011c: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterLookupDictionary
IL_0121: ldc.i4.s 120
IL_0123: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character>::ContainsKey(!0)
IL_0128: brfalse.s IL_0161
IL_012a: ldarg.0
IL_012b: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterLookupDictionary
IL_0130: ldc.i4.s 120
IL_0132: callvirt !1 System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character>::get_Item(!0)
IL_0137: callvirt System.UInt32 TMPro.TMP_TextElement::get_glyphIndex()
IL_013c: stloc.3
IL_013d: ldarg.0
IL_013e: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_0143: ldarg.0
IL_0144: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph> TMPro.TMP_FontAsset::m_GlyphLookupDictionary
IL_0149: ldloc.3
IL_014a: callvirt !1 System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph>::get_Item(!0)
IL_014f: callvirt UnityEngine.TextCore.GlyphMetrics UnityEngine.TextCore.Glyph::get_metrics()
IL_0154: stloc.2
IL_0155: ldloca.s V_2
IL_0157: call System.Single UnityEngine.TextCore.GlyphMetrics::get_horizontalBearingY()
IL_015c: call System.Void UnityEngine.TextCore.FaceInfo::set_meanLine(System.Single)
IL_0161: ret
