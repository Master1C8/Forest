TYPE TMPro.TMP_Style
METHOD System.Int32 TMPro.TMP_Style::get_hashCode() | attributes=Public, HideBySig, SpecialName | impl=IL
IL_0000: ldarg.0
IL_0001: ldfld System.Int32 TMPro.TMP_Style::m_HashCode
IL_0006: ret
METHOD System.Void TMPro.TMP_Style::RefreshStyle() | attributes=Public, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldarg.0
IL_0002: ldfld System.String TMPro.TMP_Style::m_Name
IL_0007: call System.Int32 TMPro.TMP_TextParsingUtilities::GetHashCode(System.String)
IL_000c: stfld System.Int32 TMPro.TMP_Style::m_HashCode
IL_0011: ldarg.0
IL_0012: ldfld System.String TMPro.TMP_Style::m_OpeningDefinition
IL_0017: callvirt System.Int32 System.String::get_Length()
IL_001c: stloc.0
IL_001d: ldarg.0
IL_001e: ldloc.0
IL_001f: newarr System.Int32
IL_0024: stfld System.Int32[] TMPro.TMP_Style::m_OpeningTagArray
IL_0029: ldarg.0
IL_002a: ldloc.0
IL_002b: newarr System.UInt32
IL_0030: stfld System.UInt32[] TMPro.TMP_Style::m_OpeningTagUnicodeArray
IL_0035: ldc.i4.0
IL_0036: stloc.2
IL_0037: br.s IL_0065
IL_0039: ldarg.0
IL_003a: ldfld System.Int32[] TMPro.TMP_Style::m_OpeningTagArray
IL_003f: ldloc.2
IL_0040: ldarg.0
IL_0041: ldfld System.String TMPro.TMP_Style::m_OpeningDefinition
IL_0046: ldloc.2
IL_0047: callvirt System.Char System.String::get_Chars(System.Int32)
IL_004c: stelem.i4
IL_004d: ldarg.0
IL_004e: ldfld System.UInt32[] TMPro.TMP_Style::m_OpeningTagUnicodeArray
IL_0053: ldloc.2
IL_0054: ldarg.0
IL_0055: ldfld System.String TMPro.TMP_Style::m_OpeningDefinition
IL_005a: ldloc.2
IL_005b: callvirt System.Char System.String::get_Chars(System.Int32)
IL_0060: stelem.i4
IL_0061: ldloc.2
IL_0062: ldc.i4.1
IL_0063: add
IL_0064: stloc.2
IL_0065: ldloc.2
IL_0066: ldloc.0
IL_0067: blt.s IL_0039
IL_0069: ldarg.0
IL_006a: ldfld System.String TMPro.TMP_Style::m_ClosingDefinition
IL_006f: callvirt System.Int32 System.String::get_Length()
IL_0074: stloc.1
IL_0075: ldarg.0
IL_0076: ldloc.1
IL_0077: newarr System.Int32
IL_007c: stfld System.Int32[] TMPro.TMP_Style::m_ClosingTagArray
IL_0081: ldarg.0
IL_0082: ldloc.1
IL_0083: newarr System.UInt32
IL_0088: stfld System.UInt32[] TMPro.TMP_Style::m_ClosingTagUnicodeArray
IL_008d: ldc.i4.0
IL_008e: stloc.3
IL_008f: br.s IL_00bd
IL_0091: ldarg.0
IL_0092: ldfld System.Int32[] TMPro.TMP_Style::m_ClosingTagArray
IL_0097: ldloc.3
IL_0098: ldarg.0
IL_0099: ldfld System.String TMPro.TMP_Style::m_ClosingDefinition
IL_009e: ldloc.3
IL_009f: callvirt System.Char System.String::get_Chars(System.Int32)
IL_00a4: stelem.i4
IL_00a5: ldarg.0
IL_00a6: ldfld System.UInt32[] TMPro.TMP_Style::m_ClosingTagUnicodeArray
IL_00ab: ldloc.3
IL_00ac: ldarg.0
IL_00ad: ldfld System.String TMPro.TMP_Style::m_ClosingDefinition
IL_00b2: ldloc.3
IL_00b3: callvirt System.Char System.String::get_Chars(System.Int32)
IL_00b8: stelem.i4
IL_00b9: ldloc.3
IL_00ba: ldc.i4.1
IL_00bb: add
IL_00bc: stloc.3
IL_00bd: ldloc.3
IL_00be: ldloc.1
IL_00bf: blt.s IL_0091
IL_00c1: ret
