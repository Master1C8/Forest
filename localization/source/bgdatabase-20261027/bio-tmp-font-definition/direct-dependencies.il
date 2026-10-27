TYPE TMPro.TMP_FontAsset
METHOD System.Void TMPro.TMP_FontAsset::InitializeDictionaryLookupTables() | attributes=Assembly, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: call System.Void TMPro.TMP_FontAsset::InitializeGlyphLookupDictionary()
IL_0006: ldarg.0
IL_0007: call System.Void TMPro.TMP_FontAsset::InitializeCharacterLookupDictionary()
IL_000c: ldarg.0
IL_000d: call System.Void TMPro.TMP_FontAsset::InitializeGlyphPaidAdjustmentRecordsLookupDictionary()
IL_0012: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Single UnityEngine.TextCore.FaceInfo::get_scale() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldfld System.Single UnityEngine.TextCore.FaceInfo::m_Scale
IL_0007: stloc.0
IL_0008: br.s IL_000a
IL_000a: ldloc.0
IL_000b: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Void UnityEngine.TextCore.FaceInfo::set_scale(System.Single) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Single UnityEngine.TextCore.FaceInfo::m_Scale
IL_0008: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Single UnityEngine.TextCore.FaceInfo::get_strikethroughOffset() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldfld System.Single UnityEngine.TextCore.FaceInfo::m_StrikethroughOffset
IL_0007: stloc.0
IL_0008: br.s IL_000a
IL_000a: ldloc.0
IL_000b: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Single UnityEngine.TextCore.FaceInfo::get_capLine() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldfld System.Single UnityEngine.TextCore.FaceInfo::m_CapLine
IL_0007: stloc.0
IL_0008: br.s IL_000a
IL_000a: ldloc.0
IL_000b: ret
TYPE UnityEngine.TextCore.FaceInfo
METHOD System.Void UnityEngine.TextCore.FaceInfo::set_strikethroughOffset(System.Single) | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: nop
IL_0001: ldarg.0
IL_0002: ldarg.1
IL_0003: stfld System.Single UnityEngine.TextCore.FaceInfo::m_StrikethroughOffset
IL_0008: ret
TYPE TMPro.TMP_TextUtilities
METHOD System.Int32 TMPro.TMP_TextUtilities::GetSimpleHashCode(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: ldc.i4.0
IL_0003: stloc.1
IL_0004: br.s IL_0018
IL_0006: ldloc.0
IL_0007: ldc.i4.5
IL_0008: shl
IL_0009: ldloc.0
IL_000a: add
IL_000b: ldarg.0
IL_000c: ldloc.1
IL_000d: callvirt System.Char System.String::get_Chars(System.Int32)
IL_0012: xor
IL_0013: stloc.0
IL_0014: ldloc.1
IL_0015: ldc.i4.1
IL_0016: add
IL_0017: stloc.1
IL_0018: ldloc.1
IL_0019: ldarg.0
IL_001a: callvirt System.Int32 System.String::get_Length()
IL_001f: blt.s IL_0006
IL_0021: ldloc.0
IL_0022: ret
