TYPE TMPro.TMP_FontAsset
METHOD System.Void TMPro.TMP_FontAsset::UpgradeFontAsset() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldstr "1.1.0"
IL_0006: stfld System.String TMPro.TMP_FontAsset::m_Version
IL_000b: ldc.i4.5
IL_000c: newarr System.String
IL_0011: dup
IL_0012: ldc.i4.0
IL_0013: ldstr "Upgrading font asset ["
IL_0018: stelem.ref
IL_0019: dup
IL_001a: ldc.i4.1
IL_001b: ldarg.0
IL_001c: call System.String UnityEngine.Object::get_name()
IL_0021: stelem.ref
IL_0022: dup
IL_0023: ldc.i4.2
IL_0024: ldstr "] to version "
IL_0029: stelem.ref
IL_002a: dup
IL_002b: ldc.i4.3
IL_002c: ldarg.0
IL_002d: ldfld System.String TMPro.TMP_FontAsset::m_Version
IL_0032: stelem.ref
IL_0033: dup
IL_0034: ldc.i4.4
IL_0035: ldstr "."
IL_003a: stelem.ref
IL_003b: call System.String System.String::Concat(System.String[])
IL_0040: ldarg.0
IL_0041: call System.Void UnityEngine.Debug::Log(System.Object,UnityEngine.Object)
IL_0046: ldarg.0
IL_0047: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_004c: ldarg.0
IL_004d: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_0052: ldfld System.String TMPro.FaceInfo_Legacy::Name
IL_0057: call System.Void UnityEngine.TextCore.FaceInfo::set_familyName(System.String)
IL_005c: ldarg.0
IL_005d: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_0062: ldsfld System.String System.String::Empty
IL_0067: call System.Void UnityEngine.TextCore.FaceInfo::set_styleName(System.String)
IL_006c: ldarg.0
IL_006d: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_0072: ldarg.0
IL_0073: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_0078: ldfld System.Single TMPro.FaceInfo_Legacy::PointSize
IL_007d: conv.i4
IL_007e: call System.Void UnityEngine.TextCore.FaceInfo::set_pointSize(System.Int32)
IL_0083: ldarg.0
IL_0084: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_0089: ldarg.0
IL_008a: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_008f: ldfld System.Single TMPro.FaceInfo_Legacy::Scale
IL_0094: call System.Void UnityEngine.TextCore.FaceInfo::set_scale(System.Single)
IL_0099: ldarg.0
IL_009a: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_009f: ldarg.0
IL_00a0: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_00a5: ldfld System.Single TMPro.FaceInfo_Legacy::LineHeight
IL_00aa: call System.Void UnityEngine.TextCore.FaceInfo::set_lineHeight(System.Single)
IL_00af: ldarg.0
IL_00b0: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_00b5: ldarg.0
IL_00b6: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_00bb: ldfld System.Single TMPro.FaceInfo_Legacy::Ascender
IL_00c0: call System.Void UnityEngine.TextCore.FaceInfo::set_ascentLine(System.Single)
IL_00c5: ldarg.0
IL_00c6: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_00cb: ldarg.0
IL_00cc: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_00d1: ldfld System.Single TMPro.FaceInfo_Legacy::CapHeight
IL_00d6: call System.Void UnityEngine.TextCore.FaceInfo::set_capLine(System.Single)
IL_00db: ldarg.0
IL_00dc: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_00e1: ldarg.0
IL_00e2: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_00e7: ldfld System.Single TMPro.FaceInfo_Legacy::CenterLine
IL_00ec: call System.Void UnityEngine.TextCore.FaceInfo::set_meanLine(System.Single)
IL_00f1: ldarg.0
IL_00f2: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_00f7: ldarg.0
IL_00f8: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_00fd: ldfld System.Single TMPro.FaceInfo_Legacy::Baseline
IL_0102: call System.Void UnityEngine.TextCore.FaceInfo::set_baseline(System.Single)
IL_0107: ldarg.0
IL_0108: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_010d: ldarg.0
IL_010e: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_0113: ldfld System.Single TMPro.FaceInfo_Legacy::Descender
IL_0118: call System.Void UnityEngine.TextCore.FaceInfo::set_descentLine(System.Single)
IL_011d: ldarg.0
IL_011e: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_0123: ldarg.0
IL_0124: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_0129: ldfld System.Single TMPro.FaceInfo_Legacy::SuperscriptOffset
IL_012e: call System.Void UnityEngine.TextCore.FaceInfo::set_superscriptOffset(System.Single)
IL_0133: ldarg.0
IL_0134: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_0139: ldarg.0
IL_013a: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_013f: ldfld System.Single TMPro.FaceInfo_Legacy::SubSize
IL_0144: call System.Void UnityEngine.TextCore.FaceInfo::set_superscriptSize(System.Single)
IL_0149: ldarg.0
IL_014a: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_014f: ldarg.0
IL_0150: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_0155: ldfld System.Single TMPro.FaceInfo_Legacy::SubscriptOffset
IL_015a: call System.Void UnityEngine.TextCore.FaceInfo::set_subscriptOffset(System.Single)
IL_015f: ldarg.0
IL_0160: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_0165: ldarg.0
IL_0166: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_016b: ldfld System.Single TMPro.FaceInfo_Legacy::SubSize
IL_0170: call System.Void UnityEngine.TextCore.FaceInfo::set_subscriptSize(System.Single)
IL_0175: ldarg.0
IL_0176: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_017b: ldarg.0
IL_017c: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_0181: ldfld System.Single TMPro.FaceInfo_Legacy::Underline
IL_0186: call System.Void UnityEngine.TextCore.FaceInfo::set_underlineOffset(System.Single)
IL_018b: ldarg.0
IL_018c: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_0191: ldarg.0
IL_0192: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_0197: ldfld System.Single TMPro.FaceInfo_Legacy::UnderlineThickness
IL_019c: call System.Void UnityEngine.TextCore.FaceInfo::set_underlineThickness(System.Single)
IL_01a1: ldarg.0
IL_01a2: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_01a7: ldarg.0
IL_01a8: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_01ad: ldfld System.Single TMPro.FaceInfo_Legacy::strikethrough
IL_01b2: call System.Void UnityEngine.TextCore.FaceInfo::set_strikethroughOffset(System.Single)
IL_01b7: ldarg.0
IL_01b8: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_01bd: ldarg.0
IL_01be: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_01c3: ldfld System.Single TMPro.FaceInfo_Legacy::strikethroughThickness
IL_01c8: call System.Void UnityEngine.TextCore.FaceInfo::set_strikethroughThickness(System.Single)
IL_01cd: ldarg.0
IL_01ce: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_01d3: ldarg.0
IL_01d4: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_01d9: ldfld System.Single TMPro.FaceInfo_Legacy::TabWidth
IL_01de: call System.Void UnityEngine.TextCore.FaceInfo::set_tabWidth(System.Single)
IL_01e3: ldarg.0
IL_01e4: ldfld UnityEngine.Texture2D[] TMPro.TMP_FontAsset::m_AtlasTextures
IL_01e9: brfalse.s IL_01f4
IL_01eb: ldarg.0
IL_01ec: ldfld UnityEngine.Texture2D[] TMPro.TMP_FontAsset::m_AtlasTextures
IL_01f1: ldlen
IL_01f2: brtrue.s IL_0200
IL_01f4: ldarg.0
IL_01f5: ldc.i4.1
IL_01f6: newarr UnityEngine.Texture2D
IL_01fb: stfld UnityEngine.Texture2D[] TMPro.TMP_FontAsset::m_AtlasTextures
IL_0200: ldarg.0
IL_0201: ldfld UnityEngine.Texture2D[] TMPro.TMP_FontAsset::m_AtlasTextures
IL_0206: ldc.i4.0
IL_0207: ldarg.0
IL_0208: ldfld UnityEngine.Texture2D TMPro.TMP_FontAsset::atlas
IL_020d: stelem.ref
IL_020e: ldarg.0
IL_020f: ldarg.0
IL_0210: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_0215: ldfld System.Single TMPro.FaceInfo_Legacy::AtlasWidth
IL_021a: conv.i4
IL_021b: stfld System.Int32 TMPro.TMP_FontAsset::m_AtlasWidth
IL_0220: ldarg.0
IL_0221: ldarg.0
IL_0222: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_0227: ldfld System.Single TMPro.FaceInfo_Legacy::AtlasHeight
IL_022c: conv.i4
IL_022d: stfld System.Int32 TMPro.TMP_FontAsset::m_AtlasHeight
IL_0232: ldarg.0
IL_0233: ldarg.0
IL_0234: ldfld TMPro.FaceInfo_Legacy TMPro.TMP_FontAsset::m_fontInfo
IL_0239: ldfld System.Single TMPro.FaceInfo_Legacy::Padding
IL_023e: conv.i4
IL_023f: stfld System.Int32 TMPro.TMP_FontAsset::m_AtlasPadding
IL_0244: ldarg.0
IL_0245: ldflda TMPro.FontAssetCreationSettings TMPro.TMP_FontAsset::m_CreationSettings
IL_024a: ldfld System.Int32 TMPro.FontAssetCreationSettings::renderMode
IL_024f: stloc.1
IL_0250: ldloc.1
IL_0251: switch IL_0278,IL_0285,IL_0292,IL_029f,IL_02c4,IL_02c4,IL_02ac,IL_02b9
IL_0276: br.s IL_02c4
IL_0278: ldarg.0
IL_0279: ldc.i4 4121
IL_027e: stfld UnityEngine.TextCore.LowLevel.GlyphRenderMode TMPro.TMP_FontAsset::m_AtlasRenderMode
IL_0283: br.s IL_02c4
IL_0285: ldarg.0
IL_0286: ldc.i4 4117
IL_028b: stfld UnityEngine.TextCore.LowLevel.GlyphRenderMode TMPro.TMP_FontAsset::m_AtlasRenderMode
IL_0290: br.s IL_02c4
IL_0292: ldarg.0
IL_0293: ldc.i4 4122
IL_0298: stfld UnityEngine.TextCore.LowLevel.GlyphRenderMode TMPro.TMP_FontAsset::m_AtlasRenderMode
IL_029d: br.s IL_02c4
IL_029f: ldarg.0
IL_02a0: ldc.i4 4118
IL_02a5: stfld UnityEngine.TextCore.LowLevel.GlyphRenderMode TMPro.TMP_FontAsset::m_AtlasRenderMode
IL_02aa: br.s IL_02c4
IL_02ac: ldarg.0
IL_02ad: ldc.i4 16422
IL_02b2: stfld UnityEngine.TextCore.LowLevel.GlyphRenderMode TMPro.TMP_FontAsset::m_AtlasRenderMode
IL_02b7: br.s IL_02c4
IL_02b9: ldarg.0
IL_02ba: ldc.i4 32806
IL_02bf: stfld UnityEngine.TextCore.LowLevel.GlyphRenderMode TMPro.TMP_FontAsset::m_AtlasRenderMode
IL_02c4: ldarg.0
IL_02c5: ldfld TMPro.TMP_FontWeightPair[] TMPro.TMP_FontAsset::fontWeights
IL_02ca: brfalse.s IL_0305
IL_02cc: ldarg.0
IL_02cd: ldfld TMPro.TMP_FontWeightPair[] TMPro.TMP_FontAsset::fontWeights
IL_02d2: ldlen
IL_02d3: brfalse.s IL_0305
IL_02d5: ldarg.0
IL_02d6: ldfld TMPro.TMP_FontWeightPair[] TMPro.TMP_FontAsset::m_FontWeightTable
IL_02db: ldc.i4.4
IL_02dc: ldarg.0
IL_02dd: ldfld TMPro.TMP_FontWeightPair[] TMPro.TMP_FontAsset::fontWeights
IL_02e2: ldc.i4.4
IL_02e3: ldelem.any TMPro.TMP_FontWeightPair
IL_02e8: stelem.any TMPro.TMP_FontWeightPair
IL_02ed: ldarg.0
IL_02ee: ldfld TMPro.TMP_FontWeightPair[] TMPro.TMP_FontAsset::m_FontWeightTable
IL_02f3: ldc.i4.7
IL_02f4: ldarg.0
IL_02f5: ldfld TMPro.TMP_FontWeightPair[] TMPro.TMP_FontAsset::fontWeights
IL_02fa: ldc.i4.7
IL_02fb: ldelem.any TMPro.TMP_FontWeightPair
IL_0300: stelem.any TMPro.TMP_FontWeightPair
IL_0305: ldarg.0
IL_0306: ldfld System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_FontAsset::fallbackFontAssets
IL_030b: brfalse.s IL_0366
IL_030d: ldarg.0
IL_030e: ldfld System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_FontAsset::fallbackFontAssets
IL_0313: callvirt System.Int32 System.Collections.Generic.List`1<TMPro.TMP_FontAsset>::get_Count()
IL_0318: ldc.i4.0
IL_0319: ble.s IL_0366
IL_031b: ldarg.0
IL_031c: ldfld System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_FontAsset::m_FallbackFontAssetTable
IL_0321: brtrue.s IL_0339
IL_0323: ldarg.0
IL_0324: ldarg.0
IL_0325: ldfld System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_FontAsset::fallbackFontAssets
IL_032a: callvirt System.Int32 System.Collections.Generic.List`1<TMPro.TMP_FontAsset>::get_Count()
IL_032f: newobj System.Void System.Collections.Generic.List`1<TMPro.TMP_FontAsset>::.ctor(System.Int32)
IL_0334: stfld System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_FontAsset::m_FallbackFontAssetTable
IL_0339: ldc.i4.0
IL_033a: stloc.2
IL_033b: br.s IL_0358
IL_033d: ldarg.0
IL_033e: ldfld System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_FontAsset::m_FallbackFontAssetTable
IL_0343: ldarg.0
IL_0344: ldfld System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_FontAsset::fallbackFontAssets
IL_0349: ldloc.2
IL_034a: callvirt !0 System.Collections.Generic.List`1<TMPro.TMP_FontAsset>::get_Item(System.Int32)
IL_034f: callvirt System.Void System.Collections.Generic.List`1<TMPro.TMP_FontAsset>::Add(!0)
IL_0354: ldloc.2
IL_0355: ldc.i4.1
IL_0356: add
IL_0357: stloc.2
IL_0358: ldloc.2
IL_0359: ldarg.0
IL_035a: ldfld System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_FontAsset::fallbackFontAssets
IL_035f: callvirt System.Int32 System.Collections.Generic.List`1<TMPro.TMP_FontAsset>::get_Count()
IL_0364: blt.s IL_033d
IL_0366: ldarg.0
IL_0367: ldflda TMPro.FontAssetCreationSettings TMPro.TMP_FontAsset::m_CreationSettings
IL_036c: ldfld System.String TMPro.FontAssetCreationSettings::sourceFontFileGUID
IL_0371: brtrue.s IL_038a
IL_0373: ldarg.0
IL_0374: ldflda TMPro.FontAssetCreationSettings TMPro.TMP_FontAsset::m_CreationSettings
IL_0379: ldfld System.String TMPro.FontAssetCreationSettings::sourceFontFileGUID
IL_037e: ldsfld System.String System.String::Empty
IL_0383: call System.Boolean System.String::op_Inequality(System.String,System.String)
IL_0388: brfalse.s IL_039d
IL_038a: ldarg.0
IL_038b: ldarg.0
IL_038c: ldflda TMPro.FontAssetCreationSettings TMPro.TMP_FontAsset::m_CreationSettings
IL_0391: ldfld System.String TMPro.FontAssetCreationSettings::sourceFontFileGUID
IL_0396: stfld System.String TMPro.TMP_FontAsset::m_SourceFontFileGUID
IL_039b: br.s IL_03b8
IL_039d: ldstr "Font asset ["
IL_03a2: ldarg.0
IL_03a3: call System.String UnityEngine.Object::get_name()
IL_03a8: ldstr "] doesn't have a reference to its source font file. Please assign the appropriate source font file for this asset in the Font Atlas & Material section of font asset inspector."
IL_03ad: call System.String System.String::Concat(System.String,System.String,System.String)
IL_03b2: ldarg.0
IL_03b3: call System.Void UnityEngine.Debug::LogWarning(System.Object,UnityEngine.Object)
IL_03b8: ldarg.0
IL_03b9: ldfld System.Collections.Generic.List`1<UnityEngine.TextCore.Glyph> TMPro.TMP_FontAsset::m_GlyphTable
IL_03be: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.TextCore.Glyph>::Clear()
IL_03c3: ldarg.0
IL_03c4: ldfld System.Collections.Generic.List`1<TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterTable
IL_03c9: callvirt System.Void System.Collections.Generic.List`1<TMPro.TMP_Character>::Clear()
IL_03ce: ldc.i4.0
IL_03cf: stloc.0
IL_03d0: ldc.i4.0
IL_03d1: stloc.3
IL_03d2: br IL_04c8
IL_03d7: ldarg.0
IL_03d8: ldfld System.Collections.Generic.List`1<TMPro.TMP_Glyph> TMPro.TMP_FontAsset::m_glyphInfoList
IL_03dd: ldloc.3
IL_03de: callvirt !0 System.Collections.Generic.List`1<TMPro.TMP_Glyph>::get_Item(System.Int32)
IL_03e3: stloc.s V_4
IL_03e5: newobj System.Void UnityEngine.TextCore.Glyph::.ctor()
IL_03ea: stloc.s V_5
IL_03ec: ldloc.3
IL_03ed: ldc.i4.1
IL_03ee: add
IL_03ef: stloc.s V_6
IL_03f1: ldloc.s V_5
IL_03f3: ldloc.s V_6
IL_03f5: callvirt System.Void UnityEngine.TextCore.Glyph::set_index(System.UInt32)
IL_03fa: ldloc.s V_5
IL_03fc: ldloc.s V_4
IL_03fe: ldfld System.Single TMPro.TMP_TextElement_Legacy::x
IL_0403: conv.i4
IL_0404: ldarg.0
IL_0405: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasHeight
IL_040a: ldloc.s V_4
IL_040c: ldfld System.Single TMPro.TMP_TextElement_Legacy::y
IL_0411: ldloc.s V_4
IL_0413: ldfld System.Single TMPro.TMP_TextElement_Legacy::height
IL_0418: add
IL_0419: ldc.r4 0.5
IL_041e: add
IL_041f: conv.i4
IL_0420: sub
IL_0421: ldloc.s V_4
IL_0423: ldfld System.Single TMPro.TMP_TextElement_Legacy::width
IL_0428: ldc.r4 0.5
IL_042d: add
IL_042e: conv.i4
IL_042f: ldloc.s V_4
IL_0431: ldfld System.Single TMPro.TMP_TextElement_Legacy::height
IL_0436: ldc.r4 0.5
IL_043b: add
IL_043c: conv.i4
IL_043d: newobj System.Void UnityEngine.TextCore.GlyphRect::.ctor(System.Int32,System.Int32,System.Int32,System.Int32)
IL_0442: callvirt System.Void UnityEngine.TextCore.Glyph::set_glyphRect(UnityEngine.TextCore.GlyphRect)
IL_0447: ldloc.s V_5
IL_0449: ldloc.s V_4
IL_044b: ldfld System.Single TMPro.TMP_TextElement_Legacy::width
IL_0450: ldloc.s V_4
IL_0452: ldfld System.Single TMPro.TMP_TextElement_Legacy::height
IL_0457: ldloc.s V_4
IL_0459: ldfld System.Single TMPro.TMP_TextElement_Legacy::xOffset
IL_045e: ldloc.s V_4
IL_0460: ldfld System.Single TMPro.TMP_TextElement_Legacy::yOffset
IL_0465: ldloc.s V_4
IL_0467: ldfld System.Single TMPro.TMP_TextElement_Legacy::xAdvance
IL_046c: newobj System.Void UnityEngine.TextCore.GlyphMetrics::.ctor(System.Single,System.Single,System.Single,System.Single,System.Single)
IL_0471: callvirt System.Void UnityEngine.TextCore.Glyph::set_metrics(UnityEngine.TextCore.GlyphMetrics)
IL_0476: ldloc.s V_5
IL_0478: ldloc.s V_4
IL_047a: ldfld System.Single TMPro.TMP_TextElement_Legacy::scale
IL_047f: callvirt System.Void UnityEngine.TextCore.Glyph::set_scale(System.Single)
IL_0484: ldloc.s V_5
IL_0486: ldc.i4.0
IL_0487: callvirt System.Void UnityEngine.TextCore.Glyph::set_atlasIndex(System.Int32)
IL_048c: ldarg.0
IL_048d: ldfld System.Collections.Generic.List`1<UnityEngine.TextCore.Glyph> TMPro.TMP_FontAsset::m_GlyphTable
IL_0492: ldloc.s V_5
IL_0494: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.TextCore.Glyph>::Add(!0)
IL_0499: ldloc.s V_4
IL_049b: ldfld System.Int32 TMPro.TMP_TextElement_Legacy::id
IL_04a0: ldarg.0
IL_04a1: ldloc.s V_5
IL_04a3: newobj System.Void TMPro.TMP_Character::.ctor(System.UInt32,TMPro.TMP_FontAsset,UnityEngine.TextCore.Glyph)
IL_04a8: stloc.s V_7
IL_04aa: ldloc.s V_4
IL_04ac: ldfld System.Int32 TMPro.TMP_TextElement_Legacy::id
IL_04b1: ldc.i4.s 32
IL_04b3: bne.un.s IL_04b7
IL_04b5: ldc.i4.1
IL_04b6: stloc.0
IL_04b7: ldarg.0
IL_04b8: ldfld System.Collections.Generic.List`1<TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterTable
IL_04bd: ldloc.s V_7
IL_04bf: callvirt System.Void System.Collections.Generic.List`1<TMPro.TMP_Character>::Add(!0)
IL_04c4: ldloc.3
IL_04c5: ldc.i4.1
IL_04c6: add
IL_04c7: stloc.3
IL_04c8: ldloc.3
IL_04c9: ldarg.0
IL_04ca: ldfld System.Collections.Generic.List`1<TMPro.TMP_Glyph> TMPro.TMP_FontAsset::m_glyphInfoList
IL_04cf: callvirt System.Int32 System.Collections.Generic.List`1<TMPro.TMP_Glyph>::get_Count()
IL_04d4: blt IL_03d7
IL_04d9: ldloc.0
IL_04da: brtrue.s IL_0555
IL_04dc: ldstr "Synthesizing Space for ["
IL_04e1: ldarg.0
IL_04e2: call System.String UnityEngine.Object::get_name()
IL_04e7: ldstr "]"
IL_04ec: call System.String System.String::Concat(System.String,System.String,System.String)
IL_04f1: call System.Void UnityEngine.Debug::Log(System.Object)
IL_04f6: ldc.i4.0
IL_04f7: ldc.r4 0
IL_04fc: ldc.r4 0
IL_0501: ldc.r4 0
IL_0506: ldc.r4 0
IL_050b: ldarg.0
IL_050c: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_0511: call System.Single UnityEngine.TextCore.FaceInfo::get_ascentLine()
IL_0516: ldc.r4 5
IL_051b: div
IL_051c: newobj System.Void UnityEngine.TextCore.GlyphMetrics::.ctor(System.Single,System.Single,System.Single,System.Single,System.Single)
IL_0521: call UnityEngine.TextCore.GlyphRect UnityEngine.TextCore.GlyphRect::get_zero()
IL_0526: ldc.r4 1
IL_052b: ldc.i4.0
IL_052c: newobj System.Void UnityEngine.TextCore.Glyph::.ctor(System.UInt32,UnityEngine.TextCore.GlyphMetrics,UnityEngine.TextCore.GlyphRect,System.Single,System.Int32)
IL_0531: stloc.s V_8
IL_0533: ldarg.0
IL_0534: ldfld System.Collections.Generic.List`1<UnityEngine.TextCore.Glyph> TMPro.TMP_FontAsset::m_GlyphTable
IL_0539: ldloc.s V_8
IL_053b: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.TextCore.Glyph>::Add(!0)
IL_0540: ldarg.0
IL_0541: ldfld System.Collections.Generic.List`1<TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterTable
IL_0546: ldc.i4.s 32
IL_0548: ldarg.0
IL_0549: ldloc.s V_8
IL_054b: newobj System.Void TMPro.TMP_Character::.ctor(System.UInt32,TMPro.TMP_FontAsset,UnityEngine.TextCore.Glyph)
IL_0550: callvirt System.Void System.Collections.Generic.List`1<TMPro.TMP_Character>::Add(!0)
IL_0555: ldarg.0
IL_0556: call System.Void TMPro.TMP_FontAsset::ReadFontAssetDefinition()
IL_055b: ret
