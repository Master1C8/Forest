TYPE TMPro.TMP_FontAsset
METHOD System.Boolean TMPro.TMP_FontAsset::TryAddCharacterInternal(System.UInt32,TMPro.TMP_Character&) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: ldnull
IL_0002: stind.ref
IL_0003: ldarg.0
IL_0004: ldfld System.Collections.Generic.HashSet`1<System.UInt32> TMPro.TMP_FontAsset::m_MissingUnicodesFromFontFile
IL_0009: ldarg.1
IL_000a: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.UInt32>::Contains(!0)
IL_000f: brfalse.s IL_0013
IL_0011: ldc.i4.0
IL_0012: ret
IL_0013: ldarg.0
IL_0014: call UnityEngine.Font TMPro.TMP_FontAsset::get_sourceFontFile()
IL_0019: ldarg.0
IL_001a: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_001f: call System.Int32 UnityEngine.TextCore.FaceInfo::get_pointSize()
IL_0024: call UnityEngine.TextCore.LowLevel.FontEngineError UnityEngine.TextCore.LowLevel.FontEngine::LoadFontFace(UnityEngine.Font,System.Int32)
IL_0029: brfalse.s IL_002d
IL_002b: ldc.i4.0
IL_002c: ret
IL_002d: ldarg.1
IL_002e: call System.UInt32 UnityEngine.TextCore.LowLevel.FontEngine::GetGlyphIndex(System.UInt32)
IL_0033: stloc.0
IL_0034: ldloc.0
IL_0035: brtrue.s IL_0075
IL_0037: ldarg.1
IL_0038: ldc.i4 160
IL_003d: beq.s IL_0051
IL_003f: ldarg.1
IL_0040: ldc.i4 173
IL_0045: beq.s IL_005b
IL_0047: ldarg.1
IL_0048: ldc.i4 8209
IL_004d: beq.s IL_005b
IL_004f: br.s IL_0063
IL_0051: ldc.i4.s 32
IL_0053: call System.UInt32 UnityEngine.TextCore.LowLevel.FontEngine::GetGlyphIndex(System.UInt32)
IL_0058: stloc.0
IL_0059: br.s IL_0063
IL_005b: ldc.i4.s 45
IL_005d: call System.UInt32 UnityEngine.TextCore.LowLevel.FontEngine::GetGlyphIndex(System.UInt32)
IL_0062: stloc.0
IL_0063: ldloc.0
IL_0064: brtrue.s IL_0075
IL_0066: ldarg.0
IL_0067: ldfld System.Collections.Generic.HashSet`1<System.UInt32> TMPro.TMP_FontAsset::m_MissingUnicodesFromFontFile
IL_006c: ldarg.1
IL_006d: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.UInt32>::Add(!0)
IL_0072: pop
IL_0073: ldc.i4.0
IL_0074: ret
IL_0075: ldarg.0
IL_0076: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph> TMPro.TMP_FontAsset::m_GlyphLookupDictionary
IL_007b: ldloc.0
IL_007c: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph>::ContainsKey(!0)
IL_0081: brfalse.s IL_00b5
IL_0083: ldarg.2
IL_0084: ldarg.1
IL_0085: ldarg.0
IL_0086: ldarg.0
IL_0087: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph> TMPro.TMP_FontAsset::m_GlyphLookupDictionary
IL_008c: ldloc.0
IL_008d: callvirt !1 System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph>::get_Item(!0)
IL_0092: newobj System.Void TMPro.TMP_Character::.ctor(System.UInt32,TMPro.TMP_FontAsset,UnityEngine.TextCore.Glyph)
IL_0097: stind.ref
IL_0098: ldarg.0
IL_0099: ldfld System.Collections.Generic.List`1<TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterTable
IL_009e: ldarg.2
IL_009f: ldind.ref
IL_00a0: callvirt System.Void System.Collections.Generic.List`1<TMPro.TMP_Character>::Add(!0)
IL_00a5: ldarg.0
IL_00a6: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterLookupDictionary
IL_00ab: ldarg.1
IL_00ac: ldarg.2
IL_00ad: ldind.ref
IL_00ae: callvirt System.Void System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character>::Add(!0,!1)
IL_00b3: ldc.i4.1
IL_00b4: ret
IL_00b5: ldnull
IL_00b6: stloc.1
IL_00b7: ldarg.0
IL_00b8: ldfld UnityEngine.Texture2D[] TMPro.TMP_FontAsset::m_AtlasTextures
IL_00bd: ldarg.0
IL_00be: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasTextureIndex
IL_00c3: ldelem.ref
IL_00c4: callvirt System.Boolean UnityEngine.Texture::get_isReadable()
IL_00c9: brtrue.s IL_0120
IL_00cb: ldc.i4.5
IL_00cc: newarr System.String
IL_00d1: dup
IL_00d2: ldc.i4.0
IL_00d3: ldstr "Unable to add the requested character to font asset ["
IL_00d8: stelem.ref
IL_00d9: dup
IL_00da: ldc.i4.1
IL_00db: ldarg.0
IL_00dc: call System.String UnityEngine.Object::get_name()
IL_00e1: stelem.ref
IL_00e2: dup
IL_00e3: ldc.i4.2
IL_00e4: ldstr "]'s atlas texture. Please make the texture ["
IL_00e9: stelem.ref
IL_00ea: dup
IL_00eb: ldc.i4.3
IL_00ec: ldarg.0
IL_00ed: ldfld UnityEngine.Texture2D[] TMPro.TMP_FontAsset::m_AtlasTextures
IL_00f2: ldarg.0
IL_00f3: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasTextureIndex
IL_00f8: ldelem.ref
IL_00f9: callvirt System.String UnityEngine.Object::get_name()
IL_00fe: stelem.ref
IL_00ff: dup
IL_0100: ldc.i4.4
IL_0101: ldstr "] readable."
IL_0106: stelem.ref
IL_0107: call System.String System.String::Concat(System.String[])
IL_010c: ldarg.0
IL_010d: ldfld UnityEngine.Texture2D[] TMPro.TMP_FontAsset::m_AtlasTextures
IL_0112: ldarg.0
IL_0113: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasTextureIndex
IL_0118: ldelem.ref
IL_0119: call System.Void UnityEngine.Debug::LogWarning(System.Object,UnityEngine.Object)
IL_011e: ldc.i4.0
IL_011f: ret
IL_0120: ldarg.0
IL_0121: ldfld UnityEngine.Texture2D[] TMPro.TMP_FontAsset::m_AtlasTextures
IL_0126: ldarg.0
IL_0127: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasTextureIndex
IL_012c: ldelem.ref
IL_012d: callvirt System.Int32 UnityEngine.Texture::get_width()
IL_0132: brfalse.s IL_0148
IL_0134: ldarg.0
IL_0135: ldfld UnityEngine.Texture2D[] TMPro.TMP_FontAsset::m_AtlasTextures
IL_013a: ldarg.0
IL_013b: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasTextureIndex
IL_0140: ldelem.ref
IL_0141: callvirt System.Int32 UnityEngine.Texture::get_height()
IL_0146: brtrue.s IL_0179
IL_0148: ldarg.0
IL_0149: ldfld UnityEngine.Texture2D[] TMPro.TMP_FontAsset::m_AtlasTextures
IL_014e: ldarg.0
IL_014f: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasTextureIndex
IL_0154: ldelem.ref
IL_0155: ldarg.0
IL_0156: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasWidth
IL_015b: ldarg.0
IL_015c: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasHeight
IL_0161: callvirt System.Boolean UnityEngine.Texture2D::Resize(System.Int32,System.Int32)
IL_0166: pop
IL_0167: ldarg.0
IL_0168: ldfld UnityEngine.Texture2D[] TMPro.TMP_FontAsset::m_AtlasTextures
IL_016d: ldarg.0
IL_016e: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasTextureIndex
IL_0173: ldelem.ref
IL_0174: call System.Void UnityEngine.TextCore.LowLevel.FontEngine::ResetAtlasTexture(UnityEngine.Texture2D)
IL_0179: ldloc.0
IL_017a: ldarg.0
IL_017b: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasPadding
IL_0180: ldc.i4.0
IL_0181: ldarg.0
IL_0182: ldfld System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect> TMPro.TMP_FontAsset::m_FreeGlyphRects
IL_0187: ldarg.0
IL_0188: ldfld System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect> TMPro.TMP_FontAsset::m_UsedGlyphRects
IL_018d: ldarg.0
IL_018e: ldfld UnityEngine.TextCore.LowLevel.GlyphRenderMode TMPro.TMP_FontAsset::m_AtlasRenderMode
IL_0193: ldarg.0
IL_0194: ldfld UnityEngine.Texture2D[] TMPro.TMP_FontAsset::m_AtlasTextures
IL_0199: ldarg.0
IL_019a: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasTextureIndex
IL_019f: ldelem.ref
IL_01a0: ldloca.s V_1
IL_01a2: call System.Boolean UnityEngine.TextCore.LowLevel.FontEngine::TryAddGlyphToTexture(System.UInt32,System.Int32,UnityEngine.TextCore.LowLevel.GlyphPackingMode,System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect>,System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect>,UnityEngine.TextCore.LowLevel.GlyphRenderMode,UnityEngine.Texture2D,UnityEngine.TextCore.Glyph&)
IL_01a7: brfalse.s IL_021a
IL_01a9: ldloc.1
IL_01aa: ldarg.0
IL_01ab: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasTextureIndex
IL_01b0: callvirt System.Void UnityEngine.TextCore.Glyph::set_atlasIndex(System.Int32)
IL_01b5: ldarg.0
IL_01b6: ldfld System.Collections.Generic.List`1<UnityEngine.TextCore.Glyph> TMPro.TMP_FontAsset::m_GlyphTable
IL_01bb: ldloc.1
IL_01bc: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.TextCore.Glyph>::Add(!0)
IL_01c1: ldarg.0
IL_01c2: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph> TMPro.TMP_FontAsset::m_GlyphLookupDictionary
IL_01c7: ldloc.0
IL_01c8: ldloc.1
IL_01c9: callvirt System.Void System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph>::Add(!0,!1)
IL_01ce: ldarg.2
IL_01cf: ldarg.1
IL_01d0: ldarg.0
IL_01d1: ldloc.1
IL_01d2: newobj System.Void TMPro.TMP_Character::.ctor(System.UInt32,TMPro.TMP_FontAsset,UnityEngine.TextCore.Glyph)
IL_01d7: stind.ref
IL_01d8: ldarg.0
IL_01d9: ldfld System.Collections.Generic.List`1<TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterTable
IL_01de: ldarg.2
IL_01df: ldind.ref
IL_01e0: callvirt System.Void System.Collections.Generic.List`1<TMPro.TMP_Character>::Add(!0)
IL_01e5: ldarg.0
IL_01e6: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterLookupDictionary
IL_01eb: ldarg.1
IL_01ec: ldarg.2
IL_01ed: ldind.ref
IL_01ee: callvirt System.Void System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character>::Add(!0,!1)
IL_01f3: ldarg.0
IL_01f4: ldfld System.Collections.Generic.List`1<System.UInt32> TMPro.TMP_FontAsset::m_GlyphIndexList
IL_01f9: ldloc.0
IL_01fa: callvirt System.Void System.Collections.Generic.List`1<System.UInt32>::Add(!0)
IL_01ff: ldarg.0
IL_0200: ldfld System.Collections.Generic.List`1<System.UInt32> TMPro.TMP_FontAsset::m_GlyphIndexListNewlyAdded
IL_0205: ldloc.0
IL_0206: callvirt System.Void System.Collections.Generic.List`1<System.UInt32>::Add(!0)
IL_020b: call System.Boolean TMPro.TMP_Settings::get_getFontFeaturesAtRuntime()
IL_0210: brfalse.s IL_0218
IL_0212: ldarg.0
IL_0213: call System.Void TMPro.TMP_FontAsset::RegisterFontAssetForFontFeatureUpdate(TMPro.TMP_FontAsset)
IL_0218: ldc.i4.1
IL_0219: ret
IL_021a: ldarg.0
IL_021b: ldfld System.Boolean TMPro.TMP_FontAsset::m_IsMultiAtlasTexturesEnabled
IL_0220: brfalse IL_02cc
IL_0225: ldarg.0
IL_0226: call System.Void TMPro.TMP_FontAsset::SetupNewAtlasTexture()
IL_022b: ldloc.0
IL_022c: ldarg.0
IL_022d: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasPadding
IL_0232: ldc.i4.0
IL_0233: ldarg.0
IL_0234: ldfld System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect> TMPro.TMP_FontAsset::m_FreeGlyphRects
IL_0239: ldarg.0
IL_023a: ldfld System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect> TMPro.TMP_FontAsset::m_UsedGlyphRects
IL_023f: ldarg.0
IL_0240: ldfld UnityEngine.TextCore.LowLevel.GlyphRenderMode TMPro.TMP_FontAsset::m_AtlasRenderMode
IL_0245: ldarg.0
IL_0246: ldfld UnityEngine.Texture2D[] TMPro.TMP_FontAsset::m_AtlasTextures
IL_024b: ldarg.0
IL_024c: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasTextureIndex
IL_0251: ldelem.ref
IL_0252: ldloca.s V_1
IL_0254: call System.Boolean UnityEngine.TextCore.LowLevel.FontEngine::TryAddGlyphToTexture(System.UInt32,System.Int32,UnityEngine.TextCore.LowLevel.GlyphPackingMode,System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect>,System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect>,UnityEngine.TextCore.LowLevel.GlyphRenderMode,UnityEngine.Texture2D,UnityEngine.TextCore.Glyph&)
IL_0259: brfalse.s IL_02cc
IL_025b: ldloc.1
IL_025c: ldarg.0
IL_025d: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasTextureIndex
IL_0262: callvirt System.Void UnityEngine.TextCore.Glyph::set_atlasIndex(System.Int32)
IL_0267: ldarg.0
IL_0268: ldfld System.Collections.Generic.List`1<UnityEngine.TextCore.Glyph> TMPro.TMP_FontAsset::m_GlyphTable
IL_026d: ldloc.1
IL_026e: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.TextCore.Glyph>::Add(!0)
IL_0273: ldarg.0
IL_0274: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph> TMPro.TMP_FontAsset::m_GlyphLookupDictionary
IL_0279: ldloc.0
IL_027a: ldloc.1
IL_027b: callvirt System.Void System.Collections.Generic.Dictionary`2<System.UInt32,UnityEngine.TextCore.Glyph>::Add(!0,!1)
IL_0280: ldarg.2
IL_0281: ldarg.1
IL_0282: ldarg.0
IL_0283: ldloc.1
IL_0284: newobj System.Void TMPro.TMP_Character::.ctor(System.UInt32,TMPro.TMP_FontAsset,UnityEngine.TextCore.Glyph)
IL_0289: stind.ref
IL_028a: ldarg.0
IL_028b: ldfld System.Collections.Generic.List`1<TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterTable
IL_0290: ldarg.2
IL_0291: ldind.ref
IL_0292: callvirt System.Void System.Collections.Generic.List`1<TMPro.TMP_Character>::Add(!0)
IL_0297: ldarg.0
IL_0298: ldfld System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::m_CharacterLookupDictionary
IL_029d: ldarg.1
IL_029e: ldarg.2
IL_029f: ldind.ref
IL_02a0: callvirt System.Void System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character>::Add(!0,!1)
IL_02a5: ldarg.0
IL_02a6: ldfld System.Collections.Generic.List`1<System.UInt32> TMPro.TMP_FontAsset::m_GlyphIndexList
IL_02ab: ldloc.0
IL_02ac: callvirt System.Void System.Collections.Generic.List`1<System.UInt32>::Add(!0)
IL_02b1: ldarg.0
IL_02b2: ldfld System.Collections.Generic.List`1<System.UInt32> TMPro.TMP_FontAsset::m_GlyphIndexListNewlyAdded
IL_02b7: ldloc.0
IL_02b8: callvirt System.Void System.Collections.Generic.List`1<System.UInt32>::Add(!0)
IL_02bd: call System.Boolean TMPro.TMP_Settings::get_getFontFeaturesAtRuntime()
IL_02c2: brfalse.s IL_02ca
IL_02c4: ldarg.0
IL_02c5: call System.Void TMPro.TMP_FontAsset::RegisterFontAssetForFontFeatureUpdate(TMPro.TMP_FontAsset)
IL_02ca: ldc.i4.1
IL_02cb: ret
IL_02cc: ldc.i4.0
IL_02cd: ret
