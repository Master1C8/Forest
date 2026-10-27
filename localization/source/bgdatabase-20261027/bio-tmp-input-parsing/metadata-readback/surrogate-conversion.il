TYPE TMPro.TMP_TextParsingUtilities
METHOD System.UInt32 TMPro.TMP_TextParsingUtilities::ConvertToUTF32(System.UInt32,System.UInt32) | attributes=Assembly, Static, HideBySig | impl=IL
IL_0000: ldarg.0
IL_0001: ldc.i4 55296
IL_0006: sub
IL_0007: ldc.i4 1024
IL_000c: mul
IL_000d: ldarg.1
IL_000e: ldc.i4 56320
IL_0013: sub
IL_0014: ldc.i4 65536
IL_0019: add
IL_001a: add
IL_001b: ret
