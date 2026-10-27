TYPE TMPro.TMP_FontAsset
METHOD UnityEngine.Font TMPro.TMP_FontAsset::get_sourceFontFile() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Font TMPro.TMP_FontAsset::m_SourceFontFile
IL_0006: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Int32 UnityEngine.TextCore.FaceInfo::get_pointSize() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldfld System.Int32 UnityEngine.TextCore.FaceInfo::m_PointSize
IL_0007: stloc.0
IL_0008: br.s IL_000a
IL_000a: ldloc.0
IL_000b: ret
TYPE UnityEngine.TextCore.LowLevel.FontEngine
METHOD UnityEngine.TextCore.LowLevel.FontEngineError UnityEngine.TextCore.LowLevel.FontEngine::LoadFontFace(UnityEngine.Font,System.Int32) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: call System.Int32 UnityEngine.TextCore.LowLevel.FontEngine::LoadFontFace_With_Size_FromFont_Internal(UnityEngine.Font,System.Int32)
IL_0008: stloc.0
IL_0009: br.s IL_000b
IL_000b: ldloc.0
IL_000c: ret
TYPE TMPro.TMP_Character
METHOD System.Void TMPro.TMP_Character::.ctor(System.UInt32,TMPro.TMP_FontAsset,UnityEngine.TextCore.Glyph) | attributes=Public, HideBySig, SpecialName, RTSpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TMPro.TMP_TextElement::.ctor()
IL_0006: ldarg.0
IL_0007: ldc.i4.1
IL_0008: stfld TMPro.TextElementType TMPro.TMP_TextElement::m_ElementType
IL_000d: ldarg.0
IL_000e: ldarg.1
IL_000f: call System.Void TMPro.TMP_TextElement::set_unicode(System.UInt32)
IL_0014: ldarg.0
IL_0015: ldarg.2
IL_0016: call System.Void TMPro.TMP_TextElement::set_textAsset(TMPro.TMP_Asset)
IL_001b: ldarg.0
IL_001c: ldarg.3
IL_001d: call System.Void TMPro.TMP_TextElement::set_glyph(UnityEngine.TextCore.Glyph)
IL_0022: ldarg.0
IL_0023: ldarg.3
IL_0024: callvirt System.UInt32 UnityEngine.TextCore.Glyph::get_index()
IL_0029: call System.Void TMPro.TMP_TextElement::set_glyphIndex(System.UInt32)
IL_002e: ldarg.0
IL_002f: ldc.r4 1
IL_0034: call System.Void TMPro.TMP_TextElement::set_scale(System.Single)
IL_0039: ret
TYPE UnityEngine.TextCore.LowLevel.FontEngine
METHOD System.Boolean UnityEngine.TextCore.LowLevel.FontEngine::TryAddGlyphToTexture(System.UInt32,System.Int32,UnityEngine.TextCore.LowLevel.GlyphPackingMode,System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect>,System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect>,UnityEngine.TextCore.LowLevel.GlyphRenderMode,UnityEngine.Texture2D,UnityEngine.TextCore.Glyph&) | attributes=Assembly, Static, HideBySig | impl=IL
IL_0000: nop
IL_0001: ldarg.3
IL_0002: callvirt System.Int32 System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect>::get_Count()
IL_0007: stloc.0
IL_0008: ldarg.s usedGlyphRects
IL_000a: callvirt System.Int32 System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect>::get_Count()
IL_000f: stloc.1
IL_0010: ldloc.0
IL_0011: ldloc.1
IL_0012: add
IL_0013: stloc.2
IL_0014: ldsfld UnityEngine.TextCore.GlyphRect[] UnityEngine.TextCore.LowLevel.FontEngine::s_FreeGlyphRects
IL_0019: ldlen
IL_001a: conv.i4
IL_001b: ldloc.2
IL_001c: blt.s IL_002a
IL_001e: ldsfld UnityEngine.TextCore.GlyphRect[] UnityEngine.TextCore.LowLevel.FontEngine::s_UsedGlyphRects
IL_0023: ldlen
IL_0024: conv.i4
IL_0025: ldloc.2
IL_0026: clt
IL_0028: br.s IL_002b
IL_002a: ldc.i4.1
IL_002b: stloc.s V_5
IL_002d: ldloc.s V_5
IL_002f: brfalse.s IL_0055
IL_0031: nop
IL_0032: ldloc.2
IL_0033: ldc.i4.1
IL_0034: add
IL_0035: call System.Int32 UnityEngine.Mathf::NextPowerOfTwo(System.Int32)
IL_003a: stloc.s V_6
IL_003c: ldloc.s V_6
IL_003e: newarr UnityEngine.TextCore.GlyphRect
IL_0043: stsfld UnityEngine.TextCore.GlyphRect[] UnityEngine.TextCore.LowLevel.FontEngine::s_FreeGlyphRects
IL_0048: ldloc.s V_6
IL_004a: newarr UnityEngine.TextCore.GlyphRect
IL_004f: stsfld UnityEngine.TextCore.GlyphRect[] UnityEngine.TextCore.LowLevel.FontEngine::s_UsedGlyphRects
IL_0054: nop
IL_0055: ldloc.0
IL_0056: ldloc.1
IL_0057: call System.Int32 UnityEngine.Mathf::Max(System.Int32,System.Int32)
IL_005c: stloc.3
IL_005d: ldc.i4.0
IL_005e: stloc.s V_7
IL_0060: br.s IL_00a9
IL_0062: nop
IL_0063: ldloc.s V_7
IL_0065: ldloc.0
IL_0066: clt
IL_0068: stloc.s V_8
IL_006a: ldloc.s V_8
IL_006c: brfalse.s IL_0082
IL_006e: ldsfld UnityEngine.TextCore.GlyphRect[] UnityEngine.TextCore.LowLevel.FontEngine::s_FreeGlyphRects
IL_0073: ldloc.s V_7
IL_0075: ldarg.3
IL_0076: ldloc.s V_7
IL_0078: callvirt !0 System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect>::get_Item(System.Int32)
IL_007d: stelem.any UnityEngine.TextCore.GlyphRect
IL_0082: ldloc.s V_7
IL_0084: ldloc.1
IL_0085: clt
IL_0087: stloc.s V_9
IL_0089: ldloc.s V_9
IL_008b: brfalse.s IL_00a2
IL_008d: ldsfld UnityEngine.TextCore.GlyphRect[] UnityEngine.TextCore.LowLevel.FontEngine::s_UsedGlyphRects
IL_0092: ldloc.s V_7
IL_0094: ldarg.s usedGlyphRects
IL_0096: ldloc.s V_7
IL_0098: callvirt !0 System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect>::get_Item(System.Int32)
IL_009d: stelem.any UnityEngine.TextCore.GlyphRect
IL_00a2: nop
IL_00a3: ldloc.s V_7
IL_00a5: ldc.i4.1
IL_00a6: add
IL_00a7: stloc.s V_7
IL_00a9: ldloc.s V_7
IL_00ab: ldloc.3
IL_00ac: clt
IL_00ae: stloc.s V_10
IL_00b0: ldloc.s V_10
IL_00b2: brtrue.s IL_0062
IL_00b4: ldarg.0
IL_00b5: ldarg.1
IL_00b6: ldarg.2
IL_00b7: ldsfld UnityEngine.TextCore.GlyphRect[] UnityEngine.TextCore.LowLevel.FontEngine::s_FreeGlyphRects
IL_00bc: ldloca.s V_0
IL_00be: ldsfld UnityEngine.TextCore.GlyphRect[] UnityEngine.TextCore.LowLevel.FontEngine::s_UsedGlyphRects
IL_00c3: ldloca.s V_1
IL_00c5: ldarg.s renderMode
IL_00c7: ldarg.s texture
IL_00c9: ldloca.s V_4
IL_00cb: call System.Boolean UnityEngine.TextCore.LowLevel.FontEngine::TryAddGlyphToTexture_Internal(System.UInt32,System.Int32,UnityEngine.TextCore.LowLevel.GlyphPackingMode,UnityEngine.TextCore.GlyphRect[],System.Int32&,UnityEngine.TextCore.GlyphRect[],System.Int32&,UnityEngine.TextCore.LowLevel.GlyphRenderMode,UnityEngine.Texture2D,UnityEngine.TextCore.LowLevel.GlyphMarshallingStruct&)
IL_00d0: stloc.s V_11
IL_00d2: ldloc.s V_11
IL_00d4: brfalse.s IL_0152
IL_00d6: nop
IL_00d7: ldarg.s glyph
IL_00d9: ldloc.s V_4
IL_00db: newobj System.Void UnityEngine.TextCore.Glyph::.ctor(UnityEngine.TextCore.LowLevel.GlyphMarshallingStruct)
IL_00e0: stind.ref
IL_00e1: ldarg.3
IL_00e2: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect>::Clear()
IL_00e7: nop
IL_00e8: ldarg.s usedGlyphRects
IL_00ea: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect>::Clear()
IL_00ef: nop
IL_00f0: ldloc.0
IL_00f1: ldloc.1
IL_00f2: call System.Int32 UnityEngine.Mathf::Max(System.Int32,System.Int32)
IL_00f7: stloc.3
IL_00f8: ldc.i4.0
IL_00f9: stloc.s V_12
IL_00fb: br.s IL_0142
IL_00fd: nop
IL_00fe: ldloc.s V_12
IL_0100: ldloc.0
IL_0101: clt
IL_0103: stloc.s V_13
IL_0105: ldloc.s V_13
IL_0107: brfalse.s IL_011c
IL_0109: ldarg.3
IL_010a: ldsfld UnityEngine.TextCore.GlyphRect[] UnityEngine.TextCore.LowLevel.FontEngine::s_FreeGlyphRects
IL_010f: ldloc.s V_12
IL_0111: ldelem.any UnityEngine.TextCore.GlyphRect
IL_0116: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect>::Add(!0)
IL_011b: nop
IL_011c: ldloc.s V_12
IL_011e: ldloc.1
IL_011f: clt
IL_0121: stloc.s V_14
IL_0123: ldloc.s V_14
IL_0125: brfalse.s IL_013b
IL_0127: ldarg.s usedGlyphRects
IL_0129: ldsfld UnityEngine.TextCore.GlyphRect[] UnityEngine.TextCore.LowLevel.FontEngine::s_UsedGlyphRects
IL_012e: ldloc.s V_12
IL_0130: ldelem.any UnityEngine.TextCore.GlyphRect
IL_0135: callvirt System.Void System.Collections.Generic.List`1<UnityEngine.TextCore.GlyphRect>::Add(!0)
IL_013a: nop
IL_013b: nop
IL_013c: ldloc.s V_12
IL_013e: ldc.i4.1
IL_013f: add
IL_0140: stloc.s V_12
IL_0142: ldloc.s V_12
IL_0144: ldloc.3
IL_0145: clt
IL_0147: stloc.s V_15
IL_0149: ldloc.s V_15
IL_014b: brtrue.s IL_00fd
IL_014d: ldc.i4.1
IL_014e: stloc.s V_16
IL_0150: br.s IL_015b
IL_0152: ldarg.s glyph
IL_0154: ldnull
IL_0155: stind.ref
IL_0156: ldc.i4.0
IL_0157: stloc.s V_16
IL_0159: br.s IL_015b
IL_015b: ldloc.s V_16
IL_015d: ret
TYPE UnityEngine.TextCore.Glyph
METHOD System.Void UnityEngine.TextCore.Glyph::set_atlasIndex(System.Int32) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Int32 UnityEngine.TextCore.Glyph::m_AtlasIndex
IL_0008: ret
