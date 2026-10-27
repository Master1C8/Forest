TYPE TMPro.TMP_FontAssetUtilities
METHOD TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset(System.UInt32,TMPro.TMP_FontAsset,System.Boolean,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.2
IL_0001: brfalse.s IL_0020
IL_0003: ldsfld System.Collections.Generic.HashSet`1<System.Int32> TMPro.TMP_FontAssetUtilities::k_SearchedAssets
IL_0008: brtrue.s IL_0016
IL_000a: newobj System.Void System.Collections.Generic.HashSet`1<System.Int32>::.ctor()
IL_000f: stsfld System.Collections.Generic.HashSet`1<System.Int32> TMPro.TMP_FontAssetUtilities::k_SearchedAssets
IL_0014: br.s IL_0020
IL_0016: ldsfld System.Collections.Generic.HashSet`1<System.Int32> TMPro.TMP_FontAssetUtilities::k_SearchedAssets
IL_001b: callvirt System.Void System.Collections.Generic.HashSet`1<System.Int32>::Clear()
IL_0020: ldarg.0
IL_0021: ldarg.1
IL_0022: ldarg.2
IL_0023: ldarg.3
IL_0024: ldarg.s fontWeight
IL_0026: ldarg.s isAlternativeTypeface
IL_0028: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset_Internal(System.UInt32,TMPro.TMP_FontAsset,System.Boolean,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&)
IL_002d: ret
TYPE TMPro.TMP_FontAssetUtilities
METHOD TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAssets(System.UInt32,TMPro.TMP_FontAsset,System.Collections.Generic.List`1<TMPro.TMP_FontAsset>,System.Boolean,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldarg.s isAlternativeTypeface
IL_0002: ldc.i4.0
IL_0003: stind.i1
IL_0004: ldarg.2
IL_0005: brfalse.s IL_000f
IL_0007: ldarg.2
IL_0008: callvirt System.Int32 System.Collections.Generic.List`1<TMPro.TMP_FontAsset>::get_Count()
IL_000d: brtrue.s IL_0011
IL_000f: ldnull
IL_0010: ret
IL_0011: ldarg.3
IL_0012: brfalse.s IL_0031
IL_0014: ldsfld System.Collections.Generic.HashSet`1<System.Int32> TMPro.TMP_FontAssetUtilities::k_SearchedAssets
IL_0019: brtrue.s IL_0027
IL_001b: newobj System.Void System.Collections.Generic.HashSet`1<System.Int32>::.ctor()
IL_0020: stsfld System.Collections.Generic.HashSet`1<System.Int32> TMPro.TMP_FontAssetUtilities::k_SearchedAssets
IL_0025: br.s IL_0031
IL_0027: ldsfld System.Collections.Generic.HashSet`1<System.Int32> TMPro.TMP_FontAssetUtilities::k_SearchedAssets
IL_002c: callvirt System.Void System.Collections.Generic.HashSet`1<System.Int32>::Clear()
IL_0031: ldarg.2
IL_0032: callvirt System.Int32 System.Collections.Generic.List`1<TMPro.TMP_FontAsset>::get_Count()
IL_0037: stloc.0
IL_0038: ldc.i4.0
IL_0039: stloc.1
IL_003a: br.s IL_0077
IL_003c: ldarg.2
IL_003d: ldloc.1
IL_003e: callvirt !0 System.Collections.Generic.List`1<TMPro.TMP_FontAsset>::get_Item(System.Int32)
IL_0043: stloc.2
IL_0044: ldloc.2
IL_0045: ldnull
IL_0046: call System.Boolean UnityEngine.Object::op_Equality(UnityEngine.Object,UnityEngine.Object)
IL_004b: brtrue.s IL_0073
IL_004d: ldarg.1
IL_004e: ldfld System.Collections.Generic.HashSet`1<System.Int32> TMPro.TMP_FontAsset::FallbackSearchQueryLookup
IL_0053: ldloc.2
IL_0054: callvirt System.Int32 TMPro.TMP_Asset::get_instanceID()
IL_0059: callvirt System.Boolean System.Collections.Generic.HashSet`1<System.Int32>::Add(!0)
IL_005e: pop
IL_005f: ldarg.0
IL_0060: ldloc.2
IL_0061: ldarg.3
IL_0062: ldarg.s fontStyle
IL_0064: ldarg.s fontWeight
IL_0066: ldarg.s isAlternativeTypeface
IL_0068: call TMPro.TMP_Character TMPro.TMP_FontAssetUtilities::GetCharacterFromFontAsset_Internal(System.UInt32,TMPro.TMP_FontAsset,System.Boolean,TMPro.FontStyles,TMPro.FontWeight,System.Boolean&)
IL_006d: stloc.3
IL_006e: ldloc.3
IL_006f: brfalse.s IL_0073
IL_0071: ldloc.3
IL_0072: ret
IL_0073: ldloc.1
IL_0074: ldc.i4.1
IL_0075: add
IL_0076: stloc.1
IL_0077: ldloc.1
IL_0078: ldloc.0
IL_0079: blt.s IL_003c
IL_007b: ldnull
IL_007c: ret
TYPE TMPro.TMP_Asset
METHOD System.Int32 TMPro.TMP_Asset::get_instanceID() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TMPro.TMP_Asset::m_InstanceID
IL_0006: brtrue.s IL_0014
IL_0008: ldarg.0
IL_0009: ldarg.0
IL_000a: call System.Int32 UnityEngine.Object::GetInstanceID()
IL_000f: stfld System.Int32 TMPro.TMP_Asset::m_InstanceID
IL_0014: ldarg.0
IL_0015: ldfld System.Int32 TMPro.TMP_Asset::m_InstanceID
IL_001a: ret
