TYPE TMPro.TMP_Text
METHOD TMPro.TMP_TextElement TMPro.TMP_Text::GetTextElement(System.UInt32,TMPro.TMP_FontAsset,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&) | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.1
IL_0001: ldarg.2
IL_0002: ldc.i4.0
IL_0003: ldarg.3
IL_0004: ldarg.s fontWeight
IL_0006: ldarg.s isUsingAlternativeTypeface
IL_0008: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset(System.UInt32,TMPro.TMP_FontAsset,System.Boolean,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&)
IL_000d: stloc.0
IL_000e: ldloc.0
IL_000f: brfalse.s IL_0013
IL_0011: ldloc.0
IL_0012: ret
IL_0013: ldarg.2
IL_0014: ldfld System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_FontAsset::m_FallbackFontAssetTable
IL_0019: brfalse.s IL_003d
IL_001b: ldarg.2
IL_001c: ldfld System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_FontAsset::m_FallbackFontAssetTable
IL_0021: callvirt System.Int32 System.Collections.Generic.List`1<TMPro.TMP_FontAsset>::get_Count()
IL_0026: ldc.i4.0
IL_0027: ble.s IL_003d
IL_0029: ldarg.1
IL_002a: ldarg.2
IL_002b: ldarg.2
IL_002c: ldfld System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_FontAsset::m_FallbackFontAssetTable
IL_0031: ldc.i4.1
IL_0032: ldarg.3
IL_0033: ldarg.s fontWeight
IL_0035: ldarg.s isUsingAlternativeTypeface
IL_0037: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAssets(System.UInt32,TMPro.TMP_FontAsset,System.Collections.Generic.List`1<TMPro.TMP_FontAsset>,System.Boolean,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&)
IL_003c: stloc.0
IL_003d: ldloc.0
IL_003e: brfalse.s IL_0042
IL_0040: ldloc.0
IL_0041: ret
IL_0042: ldarg.2
IL_0043: callvirt System.Int32 TMPro.TMP_Asset::get_instanceID()
IL_0048: ldarg.0
IL_0049: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_fontAsset
IL_004e: callvirt System.Int32 TMPro.TMP_Asset::get_instanceID()
IL_0053: beq.s IL_00c8
IL_0055: ldarg.1
IL_0056: ldarg.0
IL_0057: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_fontAsset
IL_005c: ldc.i4.0
IL_005d: ldarg.3
IL_005e: ldarg.s fontWeight
IL_0060: ldarg.s isUsingAlternativeTypeface
IL_0062: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset(System.UInt32,TMPro.TMP_FontAsset,System.Boolean,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&)
IL_0067: stloc.0
IL_0068: ldloc.0
IL_0069: brfalse.s IL_008a
IL_006b: ldarg.0
IL_006c: ldc.i4.0
IL_006d: stfld System.Int32 TMPro.TMP_Text::m_currentMaterialIndex
IL_0072: ldarg.0
IL_0073: ldsfld TMPro.MaterialReference[] TMPro.TMP_Text::m_materialReferences
IL_0078: ldc.i4.0
IL_0079: ldelema TMPro.MaterialReference
IL_007e: ldfld UnityEngine.Material TMPro.MaterialReference::material
IL_0083: stfld UnityEngine.Material TMPro.TMP_Text::m_currentMaterial
IL_0088: ldloc.0
IL_0089: ret
IL_008a: ldarg.0
IL_008b: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_fontAsset
IL_0090: ldfld System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_FontAsset::m_FallbackFontAssetTable
IL_0095: brfalse.s IL_00c3
IL_0097: ldarg.0
IL_0098: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_fontAsset
IL_009d: ldfld System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_FontAsset::m_FallbackFontAssetTable
IL_00a2: callvirt System.Int32 System.Collections.Generic.List`1<TMPro.TMP_FontAsset>::get_Count()
IL_00a7: ldc.i4.0
IL_00a8: ble.s IL_00c3
IL_00aa: ldarg.1
IL_00ab: ldarg.2
IL_00ac: ldarg.0
IL_00ad: ldfld TMPro.TMP_FontAsset TMPro.TMP_Text::m_fontAsset
IL_00b2: ldfld System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_FontAsset::m_FallbackFontAssetTable
IL_00b7: ldc.i4.1
IL_00b8: ldarg.3
IL_00b9: ldarg.s fontWeight
IL_00bb: ldarg.s isUsingAlternativeTypeface
IL_00bd: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAssets(System.UInt32,TMPro.TMP_FontAsset,System.Collections.Generic.List`1<TMPro.TMP_FontAsset>,System.Boolean,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&)
IL_00c2: stloc.0
IL_00c3: ldloc.0
IL_00c4: brfalse.s IL_00c8
IL_00c6: ldloc.0
IL_00c7: ret
IL_00c8: ldarg.0
IL_00c9: ldfld TMPro.TMP_SpriteAsset TMPro.TMP_Text::m_spriteAsset
IL_00ce: ldnull
IL_00cf: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_00d4: brfalse.s IL_00e9
IL_00d6: ldarg.1
IL_00d7: ldarg.0
IL_00d8: ldfld TMPro.TMP_SpriteAsset TMPro.TMP_Text::m_spriteAsset
IL_00dd: ldc.i4.1
IL_00de: call TMPro.TMP_SpriteCharacter TMPro.TMP_FontAssetUtilities::GetSpriteCharacterFromSpriteAsset(System.UInt32,TMPro.TMP_SpriteAsset,System.Boolean)
IL_00e3: stloc.1
IL_00e4: ldloc.1
IL_00e5: brfalse.s IL_00e9
IL_00e7: ldloc.1
IL_00e8: ret
IL_00e9: call System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_Settings::get_fallbackFontAssets()
IL_00ee: brfalse.s IL_0110
IL_00f0: call System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_Settings::get_fallbackFontAssets()
IL_00f5: callvirt System.Int32 System.Collections.Generic.List`1<TMPro.TMP_FontAsset>::get_Count()
IL_00fa: ldc.i4.0
IL_00fb: ble.s IL_0110
IL_00fd: ldarg.1
IL_00fe: ldarg.2
IL_00ff: call System.Collections.Generic.List`1<TMPro.TMP_FontAsset> TMPro.TMP_Settings::get_fallbackFontAssets()
IL_0104: ldc.i4.1
IL_0105: ldarg.3
IL_0106: ldarg.s fontWeight
IL_0108: ldarg.s isUsingAlternativeTypeface
IL_010a: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAssets(System.UInt32,TMPro.TMP_FontAsset,System.Collections.Generic.List`1<TMPro.TMP_FontAsset>,System.Boolean,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&)
IL_010f: stloc.0
IL_0110: ldloc.0
IL_0111: brfalse.s IL_0115
IL_0113: ldloc.0
IL_0114: ret
IL_0115: call TMPro.TMP_FontAsset TMPro.TMP_Settings::get_defaultFontAsset()
IL_011a: ldnull
IL_011b: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0120: brfalse.s IL_0134
IL_0122: ldarg.1
IL_0123: call TMPro.TMP_FontAsset TMPro.TMP_Settings::get_defaultFontAsset()
IL_0128: ldc.i4.1
IL_0129: ldarg.3
IL_012a: ldarg.s fontWeight
IL_012c: ldarg.s isUsingAlternativeTypeface
IL_012e: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset(System.UInt32,TMPro.TMP_FontAsset,System.Boolean,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&)
IL_0133: stloc.0
IL_0134: ldloc.0
IL_0135: brfalse.s IL_0139
IL_0137: ldloc.0
IL_0138: ret
IL_0139: call TMPro.TMP_SpriteAsset TMPro.TMP_Settings::get_defaultSpriteAsset()
IL_013e: ldnull
IL_013f: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_0144: brfalse.s IL_0158
IL_0146: ldarg.1
IL_0147: call TMPro.TMP_SpriteAsset TMPro.TMP_Settings::get_defaultSpriteAsset()
IL_014c: ldc.i4.1
IL_014d: call TMPro.TMP_SpriteCharacter TMPro.TMP_FontAssetUtilities::GetSpriteCharacterFromSpriteAsset(System.UInt32,TMPro.TMP_SpriteAsset,System.Boolean)
IL_0152: stloc.2
IL_0153: ldloc.2
IL_0154: brfalse.s IL_0158
IL_0156: ldloc.2
IL_0157: ret
IL_0158: ldnull
IL_0159: ret
