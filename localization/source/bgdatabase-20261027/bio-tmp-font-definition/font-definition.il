TYPE TMPro.TMP_FontAsset
METHOD System.Void TMPro.TMP_FontAsset::ReadFontAssetDefinition() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld UnityEngine.Material TMPro.TMP_Asset::material
IL_0006: ldnull
IL_0007: call System.Boolean UnityEngine.Object::op_Inequality(UnityEngine.Object,UnityEngine.Object)
IL_000c: brfalse.s IL_0021
IL_000e: ldarg.0
IL_000f: ldfld System.String TMPro.TMP_FontAsset::m_Version
IL_0014: call System.Boolean System.String::IsNullOrEmpty(System.String)
IL_0019: brfalse.s IL_0021
IL_001b: ldarg.0
IL_001c: call System.Void TMPro.TMP_FontAsset::UpgradeFontAsset()
IL_0021: ldarg.0
IL_0022: call System.Void TMPro.TMP_FontAsset::InitializeDictionaryLookupTables()
IL_0027: ldarg.0
IL_0028: call System.Void TMPro.TMP_FontAsset::AddSynthesizedCharactersAndFaceMetrics()
IL_002d: ldarg.0
IL_002e: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_0033: call System.Single UnityEngine.TextCore.FaceInfo::get_scale()
IL_0038: ldc.r4 0
IL_003d: bne.un.s IL_004f
IL_003f: ldarg.0
IL_0040: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_0045: ldc.r4 1
IL_004a: call System.Void UnityEngine.TextCore.FaceInfo::set_scale(System.Single)
IL_004f: ldarg.0
IL_0050: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_0055: call System.Single UnityEngine.TextCore.FaceInfo::get_strikethroughOffset()
IL_005a: ldc.r4 0
IL_005f: bne.un.s IL_007d
IL_0061: ldarg.0
IL_0062: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_0067: ldarg.0
IL_0068: ldflda UnityEngine.TextCore.FaceInfo TMPro.TMP_FontAsset::m_FaceInfo
IL_006d: call System.Single UnityEngine.TextCore.FaceInfo::get_capLine()
IL_0072: ldc.r4 2.5
IL_0077: div
IL_0078: call System.Void UnityEngine.TextCore.FaceInfo::set_strikethroughOffset(System.Single)
IL_007d: ldarg.0
IL_007e: ldfld System.Int32 TMPro.TMP_FontAsset::m_AtlasPadding
IL_0083: brtrue.s IL_00b0
IL_0085: ldarg.0
IL_0086: ldfld UnityEngine.Material TMPro.TMP_Asset::material
IL_008b: ldsfld System.Int32 TMPro.ShaderUtilities::ID_GradientScale
IL_0090: callvirt System.Boolean UnityEngine.Material::HasProperty(System.Int32)
IL_0095: brfalse.s IL_00b0
IL_0097: ldarg.0
IL_0098: ldarg.0
IL_0099: ldfld UnityEngine.Material TMPro.TMP_Asset::material
IL_009e: ldsfld System.Int32 TMPro.ShaderUtilities::ID_GradientScale
IL_00a3: callvirt System.Single UnityEngine.Material::GetFloat(System.Int32)
IL_00a8: conv.i4
IL_00a9: ldc.i4.1
IL_00aa: sub
IL_00ab: stfld System.Int32 TMPro.TMP_FontAsset::m_AtlasPadding
IL_00b0: ldarg.0
IL_00b1: ldarg.0
IL_00b2: call System.String UnityEngine.Object::get_name()
IL_00b7: call System.Int32 TMPro.TMP_TextUtilities::GetSimpleHashCode(System.String)
IL_00bc: stfld System.Int32 TMPro.TMP_Asset::hashCode
IL_00c1: ldarg.0
IL_00c2: ldarg.0
IL_00c3: call System.String UnityEngine.Object::get_name()
IL_00c8: ldsfld System.String TMPro.TMP_FontAsset::s_DefaultMaterialSuffix
IL_00cd: call System.String System.String::Concat(System.String,System.String)
IL_00d2: call System.Int32 TMPro.TMP_TextUtilities::GetSimpleHashCode(System.String)
IL_00d7: stfld System.Int32 TMPro.TMP_Asset::materialHashCode
IL_00dc: ldarg.0
IL_00dd: ldc.i4.0
IL_00de: stfld System.Boolean TMPro.TMP_FontAsset::IsFontAssetLookupTablesDirty
IL_00e3: ret
