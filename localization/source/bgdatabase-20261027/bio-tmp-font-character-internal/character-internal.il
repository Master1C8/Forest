TYPE TMPro.TMP_FontAssetUtilities
METHOD TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset_Internal(System.UInt32,TMPro.TMP_FontAsset,System.Boolean,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&) | attributes=Private, Static, HideBySig | impl=IL
IL_0000: ldarg.s isAlternativeTypeface
IL_0002: ldc.i4.0
IL_0003: stind.i1
IL_0004: ldnull
IL_0005: stloc.0
IL_0006: ldarg.3
IL_0007: ldc.i4.2
IL_0008: and
IL_0009: ldc.i4.2
IL_000a: ceq
IL_000c: stloc.1
IL_000d: ldloc.1
IL_000e: brtrue.s IL_001c
IL_0010: ldarg.s fontWeight
IL_0012: ldc.i4 400
IL_0017: beq IL_0115
IL_001c: ldarg.1
IL_001d: callvirt TMPro.TMP_FontWeightPair[] TMPro.TMP_FontAsset::get_fontWeightTable()
IL_0022: stloc.2
IL_0023: ldc.i4.4
IL_0024: stloc.3
IL_0025: ldarg.s fontWeight
IL_0027: ldc.i4 400
IL_002c: bgt.s IL_005c
IL_002e: ldarg.s fontWeight
IL_0030: ldc.i4 200
IL_0035: bgt.s IL_0048
IL_0037: ldarg.s fontWeight
IL_0039: ldc.i4.s 100
IL_003b: beq.s IL_0096
IL_003d: ldarg.s fontWeight
IL_003f: ldc.i4 200
IL_0044: beq.s IL_009a
IL_0046: br.s IL_00b9
IL_0048: ldarg.s fontWeight
IL_004a: ldc.i4 300
IL_004f: beq.s IL_009e
IL_0051: ldarg.s fontWeight
IL_0053: ldc.i4 400
IL_0058: beq.s IL_00a2
IL_005a: br.s IL_00b9
IL_005c: ldarg.s fontWeight
IL_005e: ldc.i4 600
IL_0063: bgt.s IL_0079
IL_0065: ldarg.s fontWeight
IL_0067: ldc.i4 500
IL_006c: beq.s IL_00a6
IL_006e: ldarg.s fontWeight
IL_0070: ldc.i4 600
IL_0075: beq.s IL_00aa
IL_0077: br.s IL_00b9
IL_0079: ldarg.s fontWeight
IL_007b: ldc.i4 700
IL_0080: beq.s IL_00ae
IL_0082: ldarg.s fontWeight
IL_0084: ldc.i4 800
IL_0089: beq.s IL_00b2
IL_008b: ldarg.s fontWeight
IL_008d: ldc.i4 900
IL_0092: beq.s IL_00b6
IL_0094: br.s IL_00b9
IL_0096: ldc.i4.1
IL_0097: stloc.3
IL_0098: br.s IL_00b9
IL_009a: ldc.i4.2
IL_009b: stloc.3
IL_009c: br.s IL_00b9
IL_009e: ldc.i4.3
IL_009f: stloc.3
IL_00a0: br.s IL_00b9
IL_00a2: ldc.i4.4
IL_00a3: stloc.3
IL_00a4: br.s IL_00b9
IL_00a6: ldc.i4.5
IL_00a7: stloc.3
IL_00a8: br.s IL_00b9
IL_00aa: ldc.i4.6
IL_00ab: stloc.3
IL_00ac: br.s IL_00b9
IL_00ae: ldc.i4.7
IL_00af: stloc.3
IL_00b0: br.s IL_00b9
IL_00b2: ldc.i4.8
IL_00b3: stloc.3
IL_00b4: br.s IL_00b9
IL_00b6: ldc.i4.s 9
IL_00b8: stloc.3
IL_00b9: ldloc.1
IL_00ba: brtrue.s IL_00ca
IL_00bc: ldloc.2
IL_00bd: ldloc.3
IL_00be: ldelema TMPro.TMP_FontWeightPair
IL_00c3: ldfld TMPro.TMP_FontAsset TMPro.TMP_FontWeightPair::regularTypeface
IL_00c8: br.s IL_00d6
IL_00ca: ldloc.2
IL_00cb: ldloc.3
IL_00cc: ldelema TMPro.TMP_FontWeightPair
IL_00d1: ldfld TMPro.TMP_FontAsset TMPro.TMP_FontWeightPair::italicTypeface
IL_00d6: stloc.s V_4
IL_00d8: ldloc.s V_4
IL_00da: ldnull
IL_00db: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00e0: brfalse.s IL_0115
IL_00e2: ldloc.s V_4
IL_00e4: callvirt System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::get_characterLookupTable()
IL_00e9: ldarg.0
IL_00ea: ldloca.s V_0
IL_00ec: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character>::TryGetValue(!0,!1&)
IL_00f1: brfalse.s IL_00f9
IL_00f3: ldarg.s isAlternativeTypeface
IL_00f5: ldc.i4.1
IL_00f6: stind.i1
IL_00f7: ldloc.0
IL_00f8: ret
IL_00f9: ldloc.s V_4
IL_00fb: callvirt TMPro.AtlasPopulationMode TMPro.TMP_FontAsset::get_atlasPopulationMode()
IL_0100: ldc.i4.1
IL_0101: bne.un.s IL_0115
IL_0103: ldloc.s V_4
IL_0105: ldarg.0
IL_0106: ldloca.s V_0
IL_0108: callvirt System.Boolean TMPro.TMP_FontAsset::TryAddCharacterInternal(System.UInt32,TMPro.TMP_Character&)
IL_010d: brfalse.s IL_0115
IL_010f: ldarg.s isAlternativeTypeface
IL_0111: ldc.i4.1
IL_0112: stind.i1
IL_0113: ldloc.0
IL_0114: ret
IL_0115: ldarg.1
IL_0116: callvirt System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character> TMPro.TMP_FontAsset::get_characterLookupTable()
IL_011b: ldarg.0
IL_011c: ldloca.s V_0
IL_011e: callvirt System.Boolean System.Collections.Generic.Dictionary`2<System.UInt32,TMPro.TMP_Character>::TryGetValue(!0,!1&)
IL_0123: brfalse.s IL_0127
IL_0125: ldloc.0
IL_0126: ret
IL_0127: ldarg.1
IL_0128: callvirt TMPro.AtlasPopulationMode TMPro.TMP_FontAsset::get_atlasPopulationMode()
IL_012d: ldc.i4.1
IL_012e: bne.un.s IL_013d
IL_0130: ldarg.1
IL_0131: ldarg.0
IL_0132: ldloca.s V_0
IL_0134: callvirt System.Boolean TMPro.TMP_FontAsset::TryAddCharacterInternal(System.UInt32,TMPro.TMP_Character&)
IL_0139: brfalse.s IL_013d
IL_013b: ldloc.0
IL_013c: ret
IL_013d: ldloc.0
IL_013e: ldnull
IL_013f: ceq
IL_0141: ldarg.2
IL_0142: and
IL_0143: brfalse.s IL_01c3
IL_0145: ldarg.1
IL_0146: callvirt System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_FontAsset::get_fallbackFontAssetTable()
IL_014b: brfalse.s IL_01c3
IL_014d: ldarg.1
IL_014e: callvirt System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_FontAsset::get_fallbackFontAssetTable()
IL_0153: stloc.s V_5
IL_0155: ldloc.s V_5
IL_0157: callvirt System.Int32 System.Collections.Generic.List`1<TMPro.TMP_FontAsset>::get_Count()
IL_015c: stloc.s V_6
IL_015e: ldloc.s V_6
IL_0160: brtrue.s IL_0164
IL_0162: ldnull
IL_0163: ret
IL_0164: ldc.i4.0
IL_0165: stloc.s V_7
IL_0167: br.s IL_01bd
IL_0169: ldloc.s V_5
IL_016b: ldloc.s V_7
IL_016d: callvirt !0 System.Collections.Generic.List`1<TMPro.TMP_FontAsset>::get_Item(System.Int32)
IL_0172: stloc.s V_8
IL_0174: ldloc.s V_8
IL_0176: ldnull
IL_0177: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_017c: brtrue.s IL_01b7
IL_017e: ldloc.s V_8
IL_0180: callvirt System.Int32 TMPro.TMP_Asset::get_instanceID()
IL_0185: stloc.s V_9
IL_0187: ldsfld System.Collections.Generic.HashSet`1<System.Int32> TMPro.TMP_FontAssetUtilities::k_SearchedAssets
IL_018c: ldloc.s V_9
IL_018e: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Int32>::Add(!0)
IL_0193: brfalse.s IL_01b7
IL_0195: ldarg.1
IL_0196: ldfld System.Collections.Generic.HashSet`1<System.Int32> TMPro.TMP_FontAsset::FallbackSearchQueryLookup
IL_019b: ldloc.s V_9
IL_019d: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Int32>::Add(!0)
IL_01a2: pop
IL_01a3: ldarg.0
IL_01a4: ldloc.s V_8
IL_01a6: ldc.i4.1
IL_01a7: ldarg.3
IL_01a8: ldarg.s fontWeight
IL_01aa: ldarg.s isAlternativeTypeface
IL_01ac: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset_Internal(System.UInt32,TMPro.TMP_FontAsset,System.Boolean,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&)
IL_01b1: stloc.0
IL_01b2: ldloc.0
IL_01b3: brfalse.s IL_01b7
IL_01b5: ldloc.0
IL_01b6: ret
IL_01b7: ldloc.s V_7
IL_01b9: ldc.i4.1
IL_01ba: add
IL_01bb: stloc.s V_7
IL_01bd: ldloc.s V_7
IL_01bf: ldloc.s V_6
IL_01c1: blt.s IL_0169
IL_01c3: ldnull
IL_01c4: ret
