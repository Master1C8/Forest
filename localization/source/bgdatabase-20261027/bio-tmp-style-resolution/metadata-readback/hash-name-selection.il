TYPE TMPro.TMP_TextParsingUtilities
METHOD System.Int32 TMPro.TMP_TextParsingUtilities::GetHashCode(System.String) | attributes=Public, Static, HideBySig | impl=IL
IL_0000: ldc.i4.0
IL_0001: stloc.0
IL_0002: ldc.i4.0
IL_0003: stloc.1
IL_0004: br.s IL_001d
IL_0006: ldloc.0
IL_0007: ldc.i4.5
IL_0008: shl
IL_0009: ldloc.0
IL_000a: add
IL_000b: ldarg.0
IL_000c: ldloc.1
IL_000d: callvirt System.Char System.String::get_Chars(System.Int32)
IL_0012: call System.Char TMPro.TMP_TextParsingUtilities::ToUpperASCIIFast(System.Char)
IL_0017: xor
IL_0018: stloc.0
IL_0019: ldloc.1
IL_001a: ldc.i4.1
IL_001b: add
IL_001c: stloc.1
IL_001d: ldloc.1
IL_001e: ldarg.0
IL_001f: callvirt System.Int32 System.String::get_Length()
IL_0024: blt.s IL_0006
IL_0026: ldloc.0
IL_0027: ret
